   
/*
    CODE OF GLOBAL IMPORTANCE
*/
  
    //Make sure that all differences are printable.
    extraCutoff = 0.01;
    
    
    //i'm so lazy lmao this is for stuff that won't cutoff hey man as long as it compiles
    extremeCutoff = 100000;
    
    //Amount of sides per cylinder. 
    $fn = 100;
    
    
    
    //Loop that makes all of the ornamentation for the small collumns.
    module tinyCollumns(collumnHeight, smallRadius, tinyRadius, protrusion, numCollumns) {
        for(i = [0: numCollumns]) {
            rotate( 
                (i * 360 / numCollumns) * 
                [0, 0, 1]) {
                    translate([smallRadius - (tinyRadius * protrusion), 0, 0]) {
                        cylinder(r = tinyRadius, h = collumnHeight, center = true);
                    }
                }
            }
    }
    
    
    //Creates a series of kickboard shapes to use around a cylinder
    module createKickboards(xTrans, numberOfBoards, width, depth, height) {    
        for(i = [0: numberOfBoards]) {
              rotate((i * 360 / numberOfBoards) * [0, 0, 1]) {
                    translate([xTrans, 0, 0]) {
                        rotate([0,0,90]) kickboard(width, depth, height); 
                }
            }
        }
    }

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


    
 /*
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
                    CODE OF PERTINENCE TO SECTION A  
    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
*/
    sectionARadius = 150;
    sectionAHeight = 750;
    sectionASmallCollumnRadius = 20;

    
    //Play with these to change the look of the ornamental collumns
    sectionAOrnamentationProtrusion = -0.625;
    sectionALargeCollumnProtrusion = 100;

   //Radius of the ornamentation cut out of the small large collumns
    sectionAOrnamentationRadius = 8;
    
    //Number of ornamented collumns in section A
    sectionAOrnamentalCollumns = 15;
    
    //Number of cylinders with which to apply ornamentation in Section A
    sectionANumberOfOrnamentalCollumns = 8;

      
    module sectionACollumns(height) {
        difference() {
        cylinder(r = sectionASmallCollumnRadius, h = height, center = true);
        tinyCollumns(height+extraCutoff, sectionASmallCollumnRadius, sectionAOrnamentationRadius, sectionAOrnamentationProtrusion, sectionANumberOfOrnamentalCollumns);
        }
    }
    
sectionANumberOfRings = 8;
sectionARingBulge = 25;
sectionAThickness = 20;
   
    //Ornamental bands around the section A
    module sectionARings() {
        for(i = [0: sectionANumberOfRings]) {
            translate([0,0, sectionAHeight/sectionANumberOfRings * i - 
            sectionAHeight / 2]) {
                cylinder(r = sectionARadius + sectionARingBulge, h = sectionAThickness, center = true);
            }
        }
    }      
    //Creates big section with the double ornamentation and adds small collumns around it
    module sectionA() {
        cylinder(r = sectionARadius, h = sectionAHeight,
        center = true);
        for(i = [0: sectionAOrnamentalCollumns]) {
            rotate(
            (i * 360 / sectionAOrnamentalCollumns) * [0, 0, 1]) {
                translate([sectionARadius - sectionASmallCollumnRadius / sectionALargeCollumnProtrusion, 0, 0]) {
                    sectionACollumns(sectionAHeight);
            }
        }
    }
    sectionARings();
}

/* 
    BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB                      
                        CODE OF PERTINENCE TO SECTION B  
    BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
*/
    


module sectionBRing(radius, thickness) { 
    cylinder(r = radius, h = thickness, center = true);
}

   /*
    These are used mostly by sections B and F, but may be used
    elsewhere so I'm including them up here globally.
    */
    
    //These are each level of the sort of "cake toppers" in section B
module createWindowedCylinder(numberOfBoards, ringRadius, ringThickness, middleRadius, middleThickness, width, depth) {
    translate([0,0, ringThickness/2]) {
        //adds bottom thick part
        sectionBRing(ringRadius, ringThickness);
    }
    //top skinnier part
    translate([0,0, ringThickness + middleThickness/2]) { 
        difference() {
            //adds ring
            sectionBRing(middleRadius, middleThickness);
            //adds cutouts 
            translate([0, 0, middleThickness/-4]) createKickboards(ringRadius, numberOfBoards, width, depth, middleThickness);
        }
    }
}



numberOfBoardsLevel2 = 16;
level2Radius = 150;
ring2Radius = 200;
ring2Thickness = 10;
level2Height = 125;
kickboardWidthLevel2 = 40;

numberOfBoardsLevel3 = 8;
level3Radius = 125;
ring3Radius = 180;
ring3Thickness = 35;
level3Height = 110;
kickboardWidthLevel3 = 45;

numberOfBoardsLevel4 = 6;
ring4Radius = 140;
level4Radius = 100;
ring4Thickness = 20;
level4Height = 135;
kickboardWidthLevel4 = 40;

sectionBWaferCut = 1;

module sectionB() {
    rotate([0,0,35]) {
        createWindowedCylinder(
        numberOfBoardsLevel2, 
        ring2Radius, 
        ring2Thickness, 
        level2Radius, 
        level2Height, 
        kickboardWidthLevel2, 
        ring2Radius * sectionBWaferCut);
    }
    translate([0, 0, level2Height + ring2Thickness]) { 
        rotate([0, 0, 0]) {
            createWindowedCylinder(
            numberOfBoardsLevel3,
            ring3Radius, 
            ring3Thickness,
            level3Radius, 
            level3Height,
            kickboardWidthLevel3,
            ring3Radius * sectionBWaferCut);
        }
        translate([0,0,level3Height + ring3Thickness]) {
            rotate([0,0,0]) {
                createWindowedCylinder(
                numberOfBoardsLevel4,
                ring4Radius,
                ring4Thickness,
                level4Radius,
                level4Height,
                kickboardWidthLevel4,
                ring4Radius * sectionBWaferCut);
            }
        }
    }
}

/* 
    DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                        CODE OF PERTINENCE TO SECTIONS D & E
    DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
*/

//    module kickboard(width, depth, height) {

masoleumTinyOrnaments = 8;
masoleumTinyOrnamentRadius = 6;
masoleumCollumnOrnamentationProtrusion =  -0.4;
masoluemCollumnRadius = 20;
bigMasHeight = 150;


//to be completely honest, a lot of the alignments get fucked up when you play with these, but I don't need to debug them (yet) so I'm going to leave them

   DFWindowLength = 60;
   DFArchModifier = 0.75;
   DFSmallKickboardWidth = 10;
   DFWindowKickboards = 3;
   DFWindowMiddleHeight = 25;
   DFWindowCrustThickness = 10;
   DFKickboardSandwichDepth = 150;
   
   //I've been debugging these FOREVER and they don't work, I'm honestly just going to leave them and deal with it later
   DFSmallKickboardImprint = 0.3;
   DFBigKickboardImprint = 1;

   DFWindowCollumnExtra = 20;
   DFWindowOverlap = 0;

   DFWindowFullThick = DFWindowMiddleHeight + DFWindowCrustThickness;
   DFKickboardArchHeight = bigMasHeight - DFWindowFullThick;
   DFKickboardArchExtraVertical = 3;
   
   //    module kickboard(width, depth, height) {

   
module kickboardArch() {
       difference() {
       cube([DFWindowLength + DFWindowCollumnExtra * 2, DFKickboardSandwichDepth, DFKickboardArchHeight], center = true);
           translate([0, 
           (DFKickboardSandwichDepth)/2 + (DFKickboardSandwichDepth * DFBigKickboardImprint)/-2, 
           (DFWindowMiddleHeight+DFKickboardArchExtraVertical+extraCutoff)/-2]) {
            kickboard(DFWindowLength * DFArchModifier, DFBigKickboardImprint*DFKickboardSandwichDepth + extraCutoff, DFKickboardArchHeight-DFKickboardArchExtraVertical + extraCutoff);     
           }
       }
       
   }



   module kickboardSandwich() {
       difference() {
           cube([DFWindowLength + DFWindowCollumnExtra * 2, DFKickboardSandwichDepth, DFWindowFullThick], center = true);
           translate(
               [(DFWindowLength - DFWindowOverlap/2 + DFWindowLength / DFWindowKickboards)/-2 - DFWindowOverlap/4, 
              ((DFBigKickboardImprint*DFKickboardSandwichDepth)/2 + 
           (DFSmallKickboardImprint * DFKickboardSandwichDepth)/-2), 
               DFWindowCrustThickness/-2]) {
           
               for(i = [1 : DFWindowKickboards]) {
                   translate([DFWindowLength/DFWindowKickboards * i,    
                    0,
                   , 0]) {
                    kickboard(DFSmallKickboardWidth, 
                       DFSmallKickboardImprint*DFKickboardSandwichDepth + extraCutoff, 
                       DFWindowMiddleHeight);
                   }
               }
           }
       }
       translate([0,0, bigMasHeight/-2]) kickboardArch();
       
   }
   
   
   // module tinyCollumns(collumnHeight, smallRadius, tinyRadius, protrusion, numCollumns) {


   module masoleumCollumns(collumnHeight, length, numberOfParts) {
       difference() {
           cylinder(r = masoluemCollumnRadius, h = collumnHeight, center = true);
           //IF THERE ARE PROBLEMS WITH STL CHECK HERE
           tinyCollumns(extremeCutoff, masoluemCollumnRadius, masoleumTinyOrnamentRadius, masoleumCollumnOrnamentationProtrusion, masoleumTinyOrnaments);
       }
   }
   
   
     
   module masoleum(numMasoleumThings) {
       translate([((DFWindowFullThick * numMasoleumThings) +(masoluemCollumnRadius*2 )* (numMasoleumThings + 4))/-2,0,0]) {
           for(i = [0: numMasoleumThings]) {
               translate([(masoluemCollumnRadius * 2 + DFWindowLength - DFWindowOverlap), 0, 0] * i) {
                   masoleumCollumns(bigMasHeight, 
                   //former masoleum length variable
                   (DFWindowFullThick * numMasoleumThings) +(masoluemCollumnRadius*2 * (numMasoleumThings + 1)),
                    numMasoleumThings);
               }
           }
       
       for(i = [1: numMasoleumThings]) {
           translate([
               (masoluemCollumnRadius) * 2 * (i-0.5) + DFWindowLength * (i-0.5) - DFWindowOverlap * i + DFWindowOverlap/2, 
               DFKickboardSandwichDepth/-2, 
               (bigMasHeight-DFWindowFullThick)/2]) {
                   kickboardSandwich();
           }
       }
   }
   }
  

/* 
    EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                        CODE OF PERTINENCE TO SECTION E
    EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
*/

numSectionEMas = 6;

module sectionE() {
    for(i = [1, -1]) {
        translate([sectionARadius, 
        ((((DFWindowFullThick + DFWindowCollumnExtra) * numSectionEMas - masoluemCollumnRadius/2) + sectionARadius)*i),
        (bigMasHeight - sectionAThickness)/-2]) {
            rotate([0,0,270]) {
                masoleum(numSectionEMas);
            }
            translate([0, ((DFWindowLength)*3 + masoluemCollumnRadius*2 - DFWindowCollumnExtra*1.5)*i , 0]) sectionD();

        }
    }
}

module sectionD() {
    for(i = [0 : 3]) {
        translate([DFKickboardSandwichDepth/2 * i,0,0]) {
               rotate([0, 0, 270]) {
                masoleum(3);
            }
        }
    }
    //translate([0,0,bigMasHeight/2]) cube([DFKickboardSandwichDepth/2,DFKickboardSandwichDepth,bigMasHeight/2], center = true);
}

currentRender();



/* 
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        CODE OF PERTINENCE TO SECTION F 
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
*/

level0Radius = 180;
level0NumberOfBoards = 10;
level0CutOutHeight = 40;
level0NonCutOutHeight = 200;
kickboardWidthLevel0 = 30;

level0Height = level0NonCutOutHeight + level0CutOutHeight;
    

module sectionF() {
   difference() {
    cylinder(r = level0Radius, h = level0Height, center = true);
    translate([0,0, (level0NonCutOutHeight-kickboardWidthLevel0)/2 - extraCutoff]) { 
     createKickboards(
    level0Radius, 
    level0NumberOfBoards, 
    kickboardWidthLevel0, 
    level0Radius * 5, 
    level0CutOutHeight);
    }
   }
}

middleTriangleRadius = 200;
middleTriangleThickness = 40;
middleCollumnHeight = 120;
middleCollumnWidth = 25;
middleTinyCollumnWidth = 5;
middleCollumnProtrusion = 2;


module middleCourtHouse() {
    translate([-middleTriangleThickness/2,0, middleTriangleRadius/2]) {
        scale([1, 1, 0.4])  {
            rotate([90, 30, 90]) {
                cylinder(r = middleTriangleRadius, h = middleTriangleThickness, $fn = 3);
            }
        }
    }
}

//GLOBAL STAGING

module currentRender() {
    translate([sectionARadius + middleTriangleThickness,0, -200]) middleCourtHouse();
    translate([0,0,(level0Height+sectionAThickness)/-2]) {
        sectionF();
    }
    translate([0,0,(level0Height+sectionAThickness)/-1 + bigMasHeight]) sectionE();
    translate([0,0,sectionAHeight]) sectionB();
    translate([0, 0, sectionAHeight/2]) sectionA();
    translate([100,50, (level0Height + 15)/-1]) cube([700, 1850, 10], center = true);

    


}

//currentRender();



