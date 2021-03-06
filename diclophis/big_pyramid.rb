#!/usr/bin/env ruby

$: << "."
$: << "diclophis"

require 'diclophis_world_painter'

srand

oox = 0
ooy = 0
ooz = 0

global_painter = DiclophisWorldPainter.new(true, oox, ooy, ooz)
puts "connected"

#global_painter.execute("setworldspawn 0 70 0")

def drop_tower(painter, tx, ty)

#painter.execute("tp world,#{tx},#{60 + (rand * 16.0).to_i},#{ty}")
#puts painter.execute("setworldspawn #{tx.to_i} 70 #{ty.to_i}")
#position = Vector.new(tx, 55, ty) #painter.player_position("faker")
#painter.center = position
#puts position.inspect

s = 30 + (rand * 10.0).to_i
floors = 22 + (rand * 10.0).to_i
floors_per_tier = 2 + (rand * 7.5).to_i
i = 0

ox = tx
oy = 0
oz = ty

=begin
painter.async do
  s.times { |x|
    64.times { |y|
      s.times { |z|
        if ((x + oox) - position.x).abs > 128 || ((y + ooy) - position.y).abs > 128 || ((z + ooz) - position.z).abs > 128
          painter.teleport("diclophis", oox + x + 1, ooy + y + 16, ooz + z + 1)
          painter.execute("/fly diclophis on")
          position = painter.player_position("diclophis")
          sleep 0.5
        end

        painter.place(x, y, z, painter.sandstone_type)
      }
    }
    painter.flush_async
  }
end
exit 0
=end

painter.async do
  floors.times { |f|
    if ((f % floors_per_tier) == (floors_per_tier - 1)) && s > 5
      i = 0
      s -= 3
      ox += 0
      oz += 0
    end
    s.times { |x|
      i += 1
      8.times { |y|
        s.times { |z|
          if ((y % 7) == 0)
            i += 3
            if ((i % 9) == 0) && (x != 0 && x != (s-1)) && (z != 0 && z != (s-1))
              type = painter.glow_type
            else
              type = painter.type
            end
          else
            if ((x) == 0) || ((x) == (s-1)) || (z == 0) || (z == (s-1))
              if ((x % 9) > 5) || ((z % 9) > 5)
                type = painter.type
              else
                type = painter.air_type
              end
            else
              if (((x-7) % 9) == 0) && (((z-7) % 9) == 0)
                type = painter.type
              else
                type = painter.air_type
              end
            end
          end

          place = false
          case type
            when painter.air_type
              place = false #(rand > 0.00001)
            when painter.type
              place = true #(rand > 0.01)
            when painter.glow_type
              place = (rand > 0.1)
              if (rand > 0.987)
                type = painter.water_type
              end
          end

          painter.place(x + ox, y + oy, z + oz, type) if place
        }
      }
    }

    oy += 7
  }
end

end

64.times { |x|
  64.times { |y|
    drop_tower(global_painter, (x * (20 + rand * 8.0)) - 256, (y * (25 + rand * 10.0)) - 256)
    $stdout.write(".")
  }
}


## maze through buildings
## wall of lava
## cirle of obsidian around spawn
