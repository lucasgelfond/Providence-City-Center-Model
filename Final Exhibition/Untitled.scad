 windowLength = 57;
 archModifier = 0.75;
 
 windowVerticalCushion = 10;
 windowHorizontalCushion = 0;
 windowHeight = 50;
 smallWindowWidth = 15;
 smallWindows = 2;
 smallWindowDepth = 10;
 
 archDepth = 150;
 
 module window() {
     difference() {
         %translate([0,archDepth/-2, 0]) cube([windowLength, archDepth, windowHeight + windowVerticalCushion * 2], center = true);
         translate([]) {
             for(i = [0:smallWindows]) {
                 #translate([windowLength/-2 + ((windowLength - windowHorizontalCushion*2) / smallWindows * i), 0,0]) kickboard(smallWindowWidth, smallWindowDepth, windowHeight - windowVerticalCushion * 2);
             }
         }
     }
 }
 
 window();
 
 
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
   

