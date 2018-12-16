// maze parts

outer_size = 1.0;
cut_size = outer_size * 0.5;
inner_size = outer_size * 1.0;
core_size = outer_size / 1.015;
path_size = outer_size * 0.33;
inner_path_size = path_size * 0.95;
fudge = 0.06 * outer_size;
inner_intersection_size = 0.6;
quarter_slice_size = 0.34;
outer_fudge_smidge = (outer_size+fudge)*0.789;
half_smidge = 0.33;

module pathway(direction) {
    scale([1, 1.0, 0.55]) {
        intersection() {
            if (direction == 5) {
                translate([-cut_size*inner_intersection_size,0,0]) {
                    cube(size=[inner_size, path_size, inner_size], center=true);
                }
            }
    
            if (direction == 6) {
                translate([cut_size*inner_intersection_size,0,0]) {
                    cube(size=[inner_size, path_size, inner_size], center=true);
                }
            }
    
            if (direction == 7) {
                translate([0,-cut_size*inner_intersection_size,0]) {
                    cube(size=[path_size, inner_size, inner_size], center=true);
                }
            }
    
            if (direction == 8) {
                translate([0,cut_size*inner_intersection_size,0]) {
                    cube(size=[path_size, inner_size, inner_size], center=true);
                }
            }
    
            if (direction == 9) {
                cube(size=[path_size, inner_size, inner_size], center=true);
            }
    
            if (direction == 10) {
                cube(size=[inner_size, path_size, inner_size], center=true);
            }
    
            if (direction == 11) {
                union() {
                    translate([cut_size*inner_intersection_size,0,0]) {
                        cube(size=[inner_size, path_size, inner_size], center=true);
                    }
    
                    translate([0,-cut_size*inner_intersection_size,0]) {
                        cube(size=[path_size, inner_size, inner_size], center=true);
                    }
                }
            }
            
            if (direction == 12) {
                union() {
                    translate([cut_size*inner_intersection_size,0,0]) {
                        cube(size=[inner_size, path_size, inner_size], center=true);
                    }
                    
                    translate([0,cut_size*inner_intersection_size,0]) {
                        cube(size=[path_size, inner_size, inner_size], center=true);
                    }
                }
            }
    
            if (direction == 13) {
                union() {
                    translate([-cut_size*inner_intersection_size,0,0]) {
                        cube(size=[inner_size, path_size, inner_size], center=true);
                    }
    
                    translate([0,cut_size*inner_intersection_size,0]) {
                        cube(size=[path_size, inner_size, inner_size], center=true);
                    }
                }
            }
    
            if (direction == 14) {
                union() {
                    translate([-cut_size*inner_intersection_size,0,0]) {
                        cube(size=[inner_size, path_size, inner_size], center=true);
                    }
    
                    translate([0,-cut_size*inner_intersection_size,0]) {
                        cube(size=[path_size, inner_size, inner_size], center=true);
                    }
                }
            }
    
            difference() {
                union() {
                    cube(size=[path_size, outer_size, path_size], center=true);
                    cube(size=[outer_size, path_size, path_size], center=true);
                }
    
                translate([0,0,path_size * half_smidge]) {
                    if (direction == 0) {
                        cube(size=[inner_path_size, outer_size+fudge, inner_path_size], center=true);
                        cube(size=[outer_size+fudge, inner_path_size, inner_path_size], center=true);
                    }
    
                    if (direction == 1) {
                        translate([0,outer_size*half_smidge,0]) {
                            cube(size=[inner_path_size, outer_size+fudge, inner_path_size], center=true);
                        }
                        cube(size=[outer_size+fudge, inner_path_size, inner_path_size], center=true);
                    }
    
                    if (direction == 2) {
                        translate([0,-outer_size*half_smidge,0]) {
                            cube(size=[inner_path_size, outer_size+fudge, inner_path_size], center=true);
                        }
                        cube(size=[outer_size+fudge, inner_path_size, inner_path_size], center=true);
                    }
    
                    if (direction == 3) {
                        cube(size=[inner_path_size, outer_size+fudge, inner_path_size], center=true);
                        translate([outer_size*half_smidge,0,0]) {
                           cube(size=[outer_size+fudge, inner_path_size, inner_path_size], center=true);
                        }
                    }
    
                    if (direction == 4) {
                        cube(size=[inner_path_size, outer_size+fudge, inner_path_size], center=true);
                        translate([-outer_size*half_smidge,0,0]) {
                            cube(size=[outer_size+fudge, inner_path_size, inner_path_size], center=true);
                        }
                    }
    
                    if (direction == 5) {
                        translate([-outer_size*quarter_slice_size,0,0]) {
                            cube(size=[outer_size+fudge, inner_path_size, inner_path_size], center=true);
                        }
                    }
    
                    if (direction == 6) {
                        translate([outer_size*quarter_slice_size,0,0]) {
                            cube(size=[outer_size+fudge, inner_path_size, inner_path_size], center=true);
                        }
                    }
    
                    if (direction == 7) {
                        translate([0,-outer_size*quarter_slice_size,0]) {
                            cube(size=[inner_path_size, outer_size+fudge, inner_path_size], center=true);
                        }
                    }
    
                    if (direction == 8) {
                        translate([0, outer_size*quarter_slice_size,0]) {
                            cube(size=[inner_path_size, outer_size+fudge, inner_path_size], center=true);
                        }
                    }
    
                    if (direction == 9) {
                        cube(size=[inner_path_size, outer_size+fudge, inner_path_size], center=true);
                    }
    
                    if (direction == 10) {
                        cube(size=[outer_size+fudge, inner_path_size, inner_path_size], center=true);
                    }
    
                    if (direction == 11) {
                        union() {
                            translate([outer_size*quarter_slice_size,0,0]) {
                                cube(size=[outer_fudge_smidge, inner_path_size, inner_path_size], center=true);
                            }
    
                            translate([0,-outer_size*quarter_slice_size,0]) {
                                cube(size=[inner_path_size, outer_fudge_smidge, inner_path_size], center=true);
                            }
                        }
                    }
    
                    if (direction == 12) {
                        union() {
                            translate([outer_size*quarter_slice_size,0,0]) {
                                cube(size=[outer_fudge_smidge, inner_path_size, inner_path_size], center=true);
                            }
    
                            translate([0, outer_size*quarter_slice_size,0]) {
                                cube(size=[inner_path_size, outer_fudge_smidge, inner_path_size], center=true);
                            }
                        }
                    }
    
                    if (direction == 13) {
                        union() {
                            translate([-outer_size*quarter_slice_size,0,0]) {
                                cube(size=[outer_fudge_smidge, inner_path_size, inner_path_size], center=true);
                            }
    
                            translate([0, outer_size*quarter_slice_size,0]) {
                                cube(size=[inner_path_size, outer_fudge_smidge, inner_path_size], center=true);
                            }
                        }
                    }
    
                    if (direction == 14) {
                        union() {
                            translate([-outer_size*quarter_slice_size,0,0]) {
                                cube(size=[outer_fudge_smidge, inner_path_size, inner_path_size], center=true);
                            }
    
                            translate([0,-outer_size*quarter_slice_size,0]) {
                                cube(size=[inner_path_size, outer_fudge_smidge, inner_path_size], center=true);
                            }
                        }
                    }
                }
    
                translate([0,0,-path_size*0.75]) {
                    union() {
                        cube(size=[path_size+fudge, outer_size+fudge, path_size+fudge], center=true);
                        cube(size=[outer_size+fudge, path_size+fudge, path_size+fudge], center=true);
                    }
                }
            }
        }
    }
}

// for (offset=[0:15]) {
//     translate([(offset*(outer_size+0)),0,0]) {
//         pathway(offset);
//     }
// }

pathway(shape);

translate([quarter_slice_size * 0.5, quarter_slice_size * 0.5, quarter_slice_size * 0.35]) {
    cube(size=[0.03, 0.03, 0.03], center=true);
}

translate([-quarter_slice_size * 0.5, -quarter_slice_size * 0.5, quarter_slice_size * 0.35]) {
    cube(size=[0.03, 0.03, 0.03], center=true);
}

translate([quarter_slice_size * 0.5, -quarter_slice_size * 0.5, quarter_slice_size * 0.35]) {
    cube(size=[0.03, 0.03, 0.03], center=true);
}

translate([-quarter_slice_size * 0.5, quarter_slice_size * 0.5, quarter_slice_size * 0.35]) {
    cube(size=[0.03, 0.03, 0.03], center=true);
}

translate([outer_size * 0.5,outer_size*0.5,outer_size*0.5]) {
    cube(size=[0.01, 0.01, 0.01], center=true);
}

translate([-outer_size * 0.5,outer_size*0.5,outer_size*0.5]) {
    cube(size=[0.01, 0.01, 0.01], center=true);
}

translate([-outer_size * 0.5,-outer_size*0.5,outer_size*0.5]) {
    cube(size=[0.01, 0.01, 0.01], center=true);
}

translate([-outer_size * 0.5,-outer_size*0.5,-outer_size*0.5]) {
    cube(size=[0.01, 0.01, 0.01], center=true);
}

translate([outer_size * 0.5,-outer_size*0.5,-outer_size*0.5]) {
    cube(size=[0.01, 0.01, 0.01], center=true);
}

translate([outer_size * 0.5,outer_size*0.5,-outer_size*0.5]) {
    cube(size=[0.01, 0.01, 0.01], center=true);
}

translate([-outer_size * 0.5,outer_size*0.5,-outer_size*0.5]) {
    cube(size=[0.01, 0.01, 0.01], center=true);
}

translate([outer_size * 0.5,-outer_size*0.5,outer_size*0.5]) {
    cube(size=[0.01, 0.01, 0.01], center=true);
}