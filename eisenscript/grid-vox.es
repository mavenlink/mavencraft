// Seed = 25
set maxdepth 16
set background white  
//Floor
//{ s 100 100 0.1 z -3 color #eee } box
// Blocks
50 * { x 1 } 50 * { y 1 } 1 * { s 0.38 0.5 0.4 } spiral
rule spiral w 100 {
box
{ y 0.4 rx 90 s 0.995 } spiral
}
rule spiral w 100 {
box
{ y 0.4 rx 90 rz -90 s 0.995} spiral
}
rule spiral w 100 {
box
{ y 0.4 rx 90 rz 90 s 0.995} spiral
}
rule spiral w 3 {
{ rx 90 s 5 1.3 1 } spiral
{ ry 180 h 3 s 1 0.7 1 } spiral
}
rule spiral w 2 {
{ rx 90 s 6 1.3 1 } spiral
{ ry 180 h 3 s 1 0.7 1 } spiral
}
rule spiral w 1.5 {
sphere
{ y 0.4 rx 90 rz 90 s 0.995} spiral
}
