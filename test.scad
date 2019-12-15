//
//translate([0,0,1]) cylinder(r1 = 5, r2 = 4, h = 1, center = true, $fn = 30)  ;
//cylinder(r = 5, h = 1, center = true, $fn= 30);
//translate([0,0,-1]) cylinder(r2 = 5, r1 = 4, h = 1, center = true, $fn = 30);


 module kickboard(width, depth, height) {
        union() {
            cube([width, depth, height - width/2], center = true);
            translate([0,0, (height - width/2) / 2]) {
                rotate([0, 90, 90]) {
                    cylinder(r = width/2, h = depth, center = true);
                }
            }
        }
    }


kickboard(10, 2, 20);