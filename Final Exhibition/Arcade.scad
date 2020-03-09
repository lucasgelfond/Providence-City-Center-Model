 manifold = 0.01;

 masHeight = 147;
 masDepth = 150;
 masWidth = 57;
 sfn = 30;
 
 
 windowVerticalCushion = 5;
 windowHorizontalCushion = 2;
 windowHeight = 40;
 smallWindowWidth = 15;
 smallWindowDepth = 20;
 
 windowBarThickness = 3.5;

 mas();
 
 module mas() {
    arch();
    translate([0,0,archHeight]) window();
    for(i = [1, -1]) {
        translate([(masSideWidth+masWidth)/2*i, 0, 0]) masSide();
    }
 } 
  

 archHorizontalCushion = 2;
 
 smallWindowSpacing = (masWidth - smallWindowWidth * 3 - windowHorizontalCushion * 2)/2;
 archHeight = masHeight - windowHeight;
 
 module arch() {
     translate([0,masDepth/-2,archHeight/2]) {
         difference() {
             cube([masWidth, masDepth, archHeight], center = true);
             translate([0,0,(masWidth-archHorizontalCushion*2)/-4-manifold]) kickboard(masWidth-archHorizontalCushion*2, masDepth+manifold, archHeight+manifold);
         }
     }
 }
 
 masSideNumCollumns = 5;
 masSideCollumnRadius = 1.25;
 masSideCollumnProtrusion = 0;
 masSideCushioning = 0.5;
 masSideWidth = 20;
 
 masSideCollumnSpacing = ( (masSideWidth - masSideCushioning*2) - (masSideCollumnRadius * 2 * masSideNumCollumns) )/masSideNumCollumns;
 
 masSideDecorationLength = masSideCollumnRadius * 2 * masSideNumCollumns + masSideCollumnSpacing * (masSideNumCollumns - 1);
 
 //some of this decoration may not work perfectly, but it shouldn't be much of an issue
 module masSide() {
     translate([0, masDepth/-2, masHeight/2]) {
         difference() {
             cube([masSideWidth, masDepth, masHeight], center = true);
             for(i = [0 : masSideNumCollumns-1]) {
                 translate([masSideDecorationLength/-2 + masSideCollumnRadius+(masSideCollumnRadius*2+masSideCollumnSpacing)*i, masDepth/2-masSideCollumnProtrusion,0]) {
                     cylinder(r = masSideCollumnRadius, h = masHeight + manifold, center = true, $fn = sfn);
                 }
             }
         }
     }
 }
  
 
 
 module window() {
     translate([0,0,windowHeight/2]) {
         difference() {
             translate([0,masDepth/-2, 0]) cube([masWidth, masDepth, windowHeight], center = true);
             translate([0,-smallWindowDepth/2+manifold,smallWindowWidth/-4]) {
                 kickboard(smallWindowWidth, smallWindowDepth, windowHeight - windowVerticalCushion * 2);
                 for(i = [-1, 1]) {
                    translate([(smallWindowWidth+smallWindowSpacing)*i,0,0]) kickboard(smallWindowWidth, smallWindowDepth, windowHeight - windowVerticalCushion * 2);
                 }
             }
         }
     }
 }
 
 module kickboard(width, depth, height) {
    union() {
        cube([width, depth, height - width/2], center = true);
        translate([0,0, (height - width/2) / 2]) {
            rotate([0, 90, 90]) {
                cylinder(r = width/2, h = depth, center = true, $fn = sfn);
            }
        }
    }
}
   

