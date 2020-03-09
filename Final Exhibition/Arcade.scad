 manifold = 0.01;
 masSideWidth = 20;
 masHeight = 147;
 masDepth = 150;
 masWidth = 57;
 sfn = 15;
 
 
 windowVerticalCushion = 5;
 windowHorizontalCushion = 2;
 windowHeight = 40;
 smallWindowWidth = 15;
 smallWindowDepth = 15;
 
 
  module masDepth(depth) {
     difference() {
        translate([0, depth/-2, masHeight/2]) cube([masWidth + 2*masSideWidth, depth, masHeight], center = true);
         decorativeCutouts(depth);
     }
 }
 
 
houseDepth = 477;
numCutouts = 6;
barsDepth = 10;
houseCutoutDepth = masWidth*3+masSideWidth*5;
houseCutoutHorizontalCushion = masSideWidth;
 
  module housePreCutouts() {
      masDepth(houseDepth);
      windowBars(barsDepth);
      for(i = [1, -1]) translate([(masHeight+masSideWidth)/2*i, 0,0]) {
          masDepth(houseDepth);
          windowBars(barsDepth);
      }
      for(i = [-3, -1, 1, 3]) {
           translate([(masSideWidth*1.33+masWidth)/2*i,houseDepth/-2,masHeight/2]) masSideCutouts(houseDepth);
      }
  }
  
  //and you may tell yourself, this is not my beautiful
  
  module house() {
      difference() {
          housePreCutouts();
          for(i = [0:numCutouts-1]) {
              translate([houseCutoutDepth/-2,masWidth/-2-houseCutoutHorizontalCushion-(masWidth+masSideWidth)*i,0]) {
                  rotate([0,0,90]) {
                    decorativeCutouts(houseCutoutDepth);
                  }
              }
          }
      }
      for(i = [0:numCutouts - 1], j = [(houseCutoutDepth/-2+barsDepth/3), -(houseCutoutDepth/-2+barsDepth*4/3)]) {
          translate([j, masWidth/-2 - houseCutoutHorizontalCushion - (masWidth+masSideWidth) * i, 0]) {
              rotate([0, 0, 90]) {
                  windowBars(barsDepth);
              }
          }
      }
  }
  
  house();
 
  module decorativeCutouts(depth) {
      //window
      translate([0,0,archHeight]) {
          translate([0,0,windowHeight/2]) windowCutouts(depth+manifold*2);
      }
      translate([0,depth/-2,archHeight/2]) archCutout(depth);
  }
   
 

 archHorizontalCushion = 2;
 
 smallWindowSpacing = (masWidth - smallWindowWidth * 3 - windowHorizontalCushion * 2)/2;
 archHeight = masHeight - windowHeight;
 
 module archCutout(depth) {
     translate([0,0,(masWidth-archHorizontalCushion*2)/-4-manifold]) kickboard(masWidth-archHorizontalCushion*2, depth+manifold, archHeight+manifold);
 }
 
 windowBarThickness = 3.5;
 windowBarSpacing = 20;
 
  module windowBars(depth) {
     translate([0, depth/-2, archHeight*7/10]) windowBar(masWidth, depth);
     for(i = [1, -1]) {
         translate([-windowBarSpacing/2*i, depth/-2,archHeight/2]) {
             rotate([0, 90,0]) {
                 windowBar(masHeight-windowHeight, depth);
             }
         }
     }
 }
 
 module windowBar(length, depth) {
     cube([length, depth, windowBarThickness], center = true);
 }
 
 
 masSideNumCollumns = 5;
 masSideCollumnRadius = 1.25;
 masSideCollumnProtrusion = 0;
 masSideCushioning = 0.5;
 
 masSideCollumnSpacing = ( (masSideWidth - masSideCushioning*2) - (masSideCollumnRadius * 2 * masSideNumCollumns) )/masSideNumCollumns;
 
 masSideDecorationLength = masSideCollumnRadius * 2 * masSideNumCollumns + masSideCollumnSpacing * (masSideNumCollumns - 1);
 
  

module masSideCutouts(depth) {
    for(i = [0 : masSideNumCollumns-1]) {
        translate([masSideDecorationLength/-2 + masSideCollumnRadius+(masSideCollumnRadius*2+masSideCollumnSpacing)*i, depth/2-masSideCollumnProtrusion,0]) {
            cylinder(r = masSideCollumnRadius, h = masHeight + manifold, center = true, $fn = sfn);
        }
    }
}
 
 
 
 module windowCutouts(depth) {
     translate([0,-depth/2+manifold,smallWindowWidth/-4]) {
         kickboard(smallWindowWidth, depth, windowHeight - windowVerticalCushion * 2);
         for(i = [-1, 1]) {
            translate([(smallWindowWidth+smallWindowSpacing)*i,0,0]) kickboard(smallWindowWidth, depth, windowHeight - windowVerticalCushion * 2);
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


/* DEPRECATED:

module mas() {
    arch();
    translate([0,0,archHeight]) window();
    for(i = [1, -1]) {
        translate([(masSideWidth+masWidth)/2*i, 0, 0]) masSide();
    }
 } 

 module arch() {
     translate([0,masDepth/-2,archHeight/2]) {
         difference() {
             cube([masWidth, masDepth, archHeight], center = true);
             archCutout(masDepth);
         }
     }
 }

 module window() {
     translate([0,0,windowHeight/2]) {
         difference() {
             translate([0,masDepth/-2, 0]) cube([masWidth, masDepth, windowHeight], center = true);
             windowCutouts(smallWindowDepth);
         }
     }
 }
 
  //some of this decoration may not work perfectly, but it shouldn't be much of an issue
 module masSide() {
     translate([0, masDepth/-2, masHeight/2]) {
         difference() {
             cube([masSideWidth, masDepth, masHeight], center = true);
             masSideCutouts(masDepth);
         }
     }
 }

*/
