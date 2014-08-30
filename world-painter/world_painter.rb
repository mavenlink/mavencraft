#!/usr/bin/env ruby

require_relative '../minecraft-wrapper/client.rb'

# Minecraft block types: http://minecraft-ids.grahamedgecombe.com/
# Id of 0 is delete.
# Data values: http://minecraft.gamepedia.com/Data_values#Leaves

class Vector
  attr_accessor :x, :y, :z

  def initialize(x, y = nil, z = nil, debug = false)
    if x.is_a?(Array)
      @x, @y, @z = x
    elsif @x.is_a?(Vector)
      @x, @y, @z = x.x, x.y, x.z
    else
      @x, @y, @z = x, y, z
    end

    @debug = debug
  end

  def -(v)
    Vector.new(x - v.x, y - v.y, z - v.z)
  end

  def +(v)
    Vector.new(x + v.x, y + v.y, z + v.z)
  end

  def /(c)
    Vector.new(x/c, y/c, z/c)
  end

  def *(c)
    Vector.new(x*c, y*c, z*c)
  end

  def ==(c)
    x == c.x && y == c.y && z == c.z
  end

  def length
    Math.sqrt(x*x + y*y + z*z)
  end
  alias_method :magnitude, :length

  def normalized
    self / length
  end

  def abs
    Vector.new(x.abs, y.abs, z.abs)
  end

  def max
    [x, y, z].max
  end

  def round
    Vector.new(x.round, y.round, z.round)
  end
end

class WorldPainter
  attr_accessor :center

  def initialize(center_x, center_y, center_z, options = {})
    @center = Vector.new(center_x, center_y, center_z)

    if @center.magnitude < 10_000
      puts "Too close to spawn!"
      exit 1
    end

    @dry_run = options[:dry_run]
    @debug = options[:debug]
    @async = options[:async_client]
    @client = MinecraftClient.new(@async)
  end

  def flush_async
    @client.flush_async if @async
  end

  def dry_run?
    @dry_run
  end

  def debug?
    @debug
  end

  def teleport(player, x, y, z)
    cmd = "/tp #{player} #{x.to_i} #{y.to_i} #{z.to_i}"
    execute(cmd)
  end

  def place(x, y, z, thing = 'dirt', data = 0, mode = 'replace', data_tag = nil)
    thing = thing.is_a?(String) ? "minecraft:#{thing}" : thing
    set_block_command = "setblock #{(@center.x + x).to_i} #{(@center.y + y).to_i} #{(@center.z + z).to_i} #{thing} #{data} #{mode} #{data_tag}"
    execute set_block_command
  end

  def summon(x, y, z, thing = 'air', data_tag = '')
    summon_command = "summon #{thing} #{(@center.x + x).to_i} #{(@center.y + y).to_i} #{(@center.z + z).to_i} #{data_tag}"
    execute summon_command
  end

  def test(x, y, z)
    result = execute("testforblock #{(@center.x + x).to_i} #{(@center.y + y).to_i} #{(@center.z + z).to_i} 0", /The block at|Successfully found the block/)
    if result =~ /Successfully found the block/
      'air'
    else
      result[/\d+ is (.*?) \(/, 1].downcase
    end
  end

  def air?(x, y, z)
    without_debug do
      !!(test(x, y, z) =~ /\bair\b/)
    end
  end

  def not_land?(x, y, z, options = {})
    without_debug do
      !!(test(x, y, z) =~ /(#{([options[:ignore]].flatten.compact + %w[air wood leaves flower]).join('|')})/i)
    end
  end

  def without_debug
    old_debug = @debug
    @debug = false
    yield
  ensure
    @debug = old_debug
  end

  def execute(cmd, pattern = nil)
    if dry_run?
      puts cmd
    else
      puts cmd if debug?
      output = @client.execute_command(cmd, pattern)
      puts output if debug?
      output
    end
  end

  def platform(center_x = 0, center_y = 0, center_z = 0, width = 10, id = 20, data = 0, options = {})
    width.times do |x|
      width.times do |z|
        options[:before_each].call(center_x - width/2 + x, center_y, center_z - width/2 + z) if options[:before_each]
        place center_x - width/2 + x, center_y, center_z - width/2 + z, id, data
        options[:after_each].call(center_x - width/2 + x, center_y, center_z - width/2 + z) if options[:after_each]
      end
    end
  end

  def ground(x, z, options = {})
    max = 126
    min = 0
    mid = nil

    tries = 0
    while max >= min && (tries += 1) < 256
      mid = min + (max - min) / 2

      air = not_land?(x, mid - @center.y, z, options)
      airDown = not_land?(x, mid - 1 - @center.y, z, options)

      if air && !airDown
        return mid - @center.y
      end

      # [126, 50, 88]
      # 38

      if air
        max = mid
      else
        min = mid
      end
    end

    return mid
  end

  # Bresenham’s line drawing algorithm
  # http://www.cb.uu.se/~cris/blog/index.php/archives/400
  def line(p1, p2, options = {})
    p = p1
    d = p2-p1
    n = d.abs.max
    s = d/n.to_f;
    n.times do
      p = p+s
      (options[:xwidth] || options[:width] || 1).times do |xw|
        (options[:zwidth] || 1).times do |zw|
          (options[:ywidth] || 1).times do |yw|
            id = evaluate(options[:id])
            data = evaluate(options[:data], 0)
            options[:before_each].call(p.x+xw, p.y+yw, p.z+zw) if options[:before_each]
            puts place p.x+xw, p.y+yw, p.z+zw, id, data
            options[:after_each].call(p.x+xw, p.y+yw, p.z+zw) if options[:after_each]
          end
        end
      end
    end
  end

  def evaluate(something, default = 'air')
    if something.is_a?(Proc)
      something.call || default
    else
      something || default
    end
  end

  def xy_from_angle_radius(angle, radius)
    [Math.cos(angle) * radius, Math.sin(angle) * radius]
  end

  def player_position(player_name)
    position = []
    execute("getpos #{player_name}")
    while line = @client.gets
      [:x, :y, :z].each do |c|
        position << (line.split(" ")[3].gsub(",", "")).to_f if line.include?(c.to_s.upcase + ": ")
      end
      break if line.include?("Pitch")
    end

    position
  end
end
