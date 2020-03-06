/*
additions/changes: 
- mullions on top (correct?)
- 8 sections/stories
- half circle-rounding at top and not on bottom
- 16 indents/16 raised areas
- pediment added but needs help very seriously
- note: yes! we can do more sides! 
*/

 manifoldCut = 0.0001;
 
 sfn = 30;
 spheresfn = 15;
 
 mainCollumnRadius = 160;
 mainCollumnHeight = 770;
 
 module mainCollumn() {
     difference() {
        cylinder(r = mainCollumnRadius, h = mainCollumnHeight, $fn = sfn, center = true);
         mainCollumnFlutes();
     }
     mainCollumnRings();
     mainCollumnFlutePediments();
     mainCollumnTopMullions();

 }
 
 
 mainCollumnNumRings = 8;
 
 module mainCollumnRings() {
     translate([0,0, mainCollumnHeight/-2]) {
         for(i = [1: (mainCollumnNumRings-1)]) {
             translate([0,0, mainCollumnHeight/mainCollumnNumRings * i]) mainCollumnRing();
         }
     }
 }
 
 mainCollumnRingBulge = -2.5;
 mainCollumnRingThickness = 20;
 
 module mainCollumnRing() {
     cylinder(r = mainCollumnRadius + mainCollumnRingBulge/2, h = mainCollumnRingThickness, center = true, $fn = sfn);
 }

 mainCollumnNumberOfFlutes = 16;
 mainCollumnFluteProtrusion = 0;
 
 module mainCollumnFlutes() {
     for(i = [0: mainCollumnNumberOfFlutes]) {
         rotate((i * 360 / mainCollumnNumberOfFlutes) * [0, 0, 1]) {
             translate([mainCollumnRadius - (mainCollumnFluteRadius * mainCollumnFluteProtrusion), 0, 0]) {
                 singleMainCollumnFlute();
             }
         }
     }
 }
  
 mainCollumnFluteRadius = 18;
 mainCollumnFluteHeight = 740; //INCLUDING top decoration
 
 module singleMainCollumnFlute() {
     translate([0,0,mainCollumnTopRoundingHeight/-2]) cylinder(r = mainCollumnFluteRadius, h = mainCollumnFluteHeight - mainCollumnTopRoundingHeight, $fn = sfn, center = true);
     translate([0, 0, (mainCollumnFluteHeight-mainCollumnTopRoundingHeight*2)/2 - manifoldCut]) {
         mainCollumnTopOrnamentation();
     }
 }
 
 
 mainCollumnTopRadius = mainCollumnFluteRadius;
 mainCollumnTopRoundingHeight = 30;
 
 module mainCollumnTopOrnamentation() {
     difference() {
        scale([1,1, mainCollumnTopRoundingHeight/mainCollumnTopRadius]) sphere(r = mainCollumnTopRadius, $fn = spheresfn);
        translate([0,0,mainCollumnTopRoundingHeight/-2]) cube([mainCollumnTopRadius*2, mainCollumnTopRadius*2, mainCollumnTopRoundingHeight], center = true);
     }
 }
 
 
 mainCollumnTopMullionProtrusion = 1;
 
 module mainCollumnTopMullions() {
     translate([0,0,mainCollumnHeight/2 - (mainCollumnHeight-mainCollumnFluteHeight)/2]) {
        for(i = [0: mainCollumnNumberOfFlutes]) {
             rotate((i * 360 / mainCollumnNumberOfFlutes) * [0, 0, 1]) {
                 translate([mainCollumnRadius - (mainCollumnTopMullionDepth/2 * mainCollumnTopMullionProtrusion), 0, 0]) {
                     mainCollumnTopMullion();
                 }
             }
         }
     }
 }
     
 mainCollumnTopMullionHeight = 80;
 mainCollumnTopMullionDepth = 50;
 mainCollumnTopMullionWidth = 5;
 
 module mainCollumnTopMullion() {
     translate([0,0,mainCollumnTopMullionHeight/-2]) cube([mainCollumnTopMullionDepth, mainCollumnTopMullionWidth, mainCollumnTopMullionHeight], center = true);
 }
 
 mainCollumnFlutePedimentProtrusion = 1;

 
 module mainCollumnFlutePediments() {
     translate([0,0,mainCollumnHeight/-2 + (mainCollumnHeight-mainCollumnFluteHeight)/2]) {
         for(i = [0: mainCollumnNumberOfFlutes]) {
             rotate((i * 360 / mainCollumnNumberOfFlutes) * [0, 0, 1]) {
                 translate([mainCollumnRadius - (mainCollumnFlutePedimentBaseThickness * mainCollumnFlutePedimentProtrusion), 0, 0]) {
            mainCollumnFlutePediment();
                 }
             }
         }
     }
 }
 
 mainCollumnFlutePedimentBaseHeight = 20;
 mainCollumnFlutePedimentBaseWidth = 25;
 mainCollumnFlutePedimentBaseThickness = 10;
 
 module mainCollumnFlutePediment() {
     translate([0,0,mainCollumnFlutePedimentBaseHeight/2]) {
         cube([mainCollumnFlutePedimentBaseThickness, mainCollumnFlutePedimentBaseWidth, mainCollumnFlutePedimentBaseHeight], center=true);
         translate([0,0,mainCollumnFlutePedimentBaseHeight/2]) mainCollumnFlutePedimentRoof();
     }
 }
 
 
 mainCollumnFlutePedimentRoofRadius = 25;
 mainCollumnFlutePedimentRoofScale = 0.55;
 mainCollumnFlutePedimentRoofThickness = 20;
 
 module mainCollumnFlutePedimentRoof() {
     translate([0,0,mainCollumnFlutePedimentRoofRadius*mainCollumnFlutePedimentRoofScale/2]) {
         scale([1, 1, mainCollumnFlutePedimentRoofScale]) {
            rotate([90, 30, 90]) {
                cylinder(r = mainCollumnFlutePedimentRoofRadius, h = mainCollumnFlutePedimentRoofThickness, center = true, $fn = 3);    }
        }
     } 
 }
 
 mainCollumn();
 
 