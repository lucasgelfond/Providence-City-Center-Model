   
/*
    CODE OF GLOBAL IMPORTANCE
*/
  
    //Make sure that all differences are printable.
    extraCutoff = 0.01;
    
    
    //i'm so lazy lmao this is for stuff that won't cutoff hey man as long as it compiles
    extremeCutoff = 100000;
    
    //Amount of sides per cylinder. 
    $fn = 20;
    
    
    
    //Loop that makes all of the ornamentation for the small collumns.
    module tinyCollumns(collumnHeight, smallRadius, tinyRadius, protrusion, numCollumns) {
        for(i = [0: numCollumns]) {
            rotate( 
                (i * 360 / numCollumns) * 
                [0, 0, 1]) {
                    translate([smallRadius - (tinyRadius * protrusion), 0, 0]) {
                        //minkowski() {
                            cylinder(r = tinyRadius, h = collumnHeight-(tinyRadius*4), center = true);
                            //translate([0,0, 0]) rotate([0, 90, 0]) cylinder(r = tinyRadius, h = tinyRadius*2, $fn = 10);
                        //}
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
sectionARadius = 160;
sectionAHeight = 770;
    
    
sectionANumberOfRings = 10;
sectionARingBulge = -2.5;
sectionAThickness = 16;
    
    
sectionAFluteRadius =  12;
sectionAFluteProtrusion = 0;
sectionAFlutes = 15;
       
    //Ornamental bands around the section A
    module sectionARings() {
        for(i = [0.5: sectionANumberOfRings-0.5]) {
            translate([0,0, sectionAHeight/sectionANumberOfRings * i - 
            sectionAHeight / 2]) {
                cylinder(r = sectionARadius + sectionARingBulge, h = sectionAThickness, center = true, $fn = 50);
            }
        }
    }      
    
       // module tinyCollumns(collumnHeight, smallRadius, tinyRadius, protrusion, numCollumns) {

    //Creates big section with the double ornamentation and adds small collumns around it
    module sectionA() {
        difference() {
            cylinder(r = sectionARadius, h = sectionAHeight,
            center = true, $fn = 100);
            tinyCollumns(sectionAHeight, sectionARadius, sectionAFluteRadius, 
            sectionAFluteProtrusion, sectionAFlutes);
            
        
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


//level 0
numberOfBoardsLevel0 = 16;
kickboardWidthLevel0 = 40;

bread0Radius = 167;
bread0Height = 41;
meat0Radius = 164;
meat0Height = 96;

//level 1

numberOfBoardsLevel1 = 16;
kickboardWidthLevel1 = 40;

bread1Radius = 172;
bread1Height = 41;
meat1Radius = 161;
meat1Height = 99;

//level 2

numberOfBoardsLevel2 = 8;
kickboardWidthLevel2 = 45;

bread2Radius = 138;
bread2Height = 59;
meat2Radius = 117;
meat2Height = 107;

//level 3

numberOfBoardsLevel3 = 8;
kickboardWidthLevel3 = 40;

bread3Radius = 113;
meat3Radius = 98;
bread3Height = 20;
meat3Height = 30;

//module createWindowedCylinder(numberOfBoards, breadRadius, breadThickness, middleRadius, middleThickness, width, depth) {


sectionBWaferCut = 1;

module sectionB() {
    rotate([0,0,0]) {
        createWindowedCylinder(
        numberOfBoardsLevel0, 
        bread0Radius, 
        bread0Height, 
        meat0Radius, 
        meat0Height, 
        kickboardWidthLevel0, 
        bread0Radius * sectionBWaferCut);
    }
    translate([0, 0, meat0Height + bread0Height]) { 
        rotate([0, 0, 0]) {
            createWindowedCylinder(
                numberOfBoardsLevel1, 
                bread1Radius, 
                bread1Height, 
                meat1Radius, 
                meat1Height, 
                kickboardWidthLevel1, 
                bread1Radius * sectionBWaferCut);
        }
        translate([0,0,meat1Height + bread1Height]) {
            rotate([0,0,0]) {
                createWindowedCylinder(
                numberOfBoardsLevel2,
                bread2Radius,
                bread2Height,
                meat2Radius,
                meat2Height,
                kickboardWidthLevel2,
                bread2Radius * sectionBWaferCut);
            }
            translate([0,0,meat2Height + bread2Height]) {
                     rotate([0,0,0]) {
                        createWindowedCylinder(
                        numberOfBoardsLevel3,
                        bread3Radius,
                        bread3Height,
                        meat3Radius,
                        meat3Height,
                        kickboardWidthLevel3,
                        bread3Radius * sectionBWaferCut);
                }
            }
        }
    }
}

topperScale = 1.27;
topperRadius = 24;
topperHeight = 92;


topperRingWidth = 6.5;
topperRingThick = 15;
numTopperRings = 10;

topperRingRadius = topperRingThick/2 + meat3Radius;


module topperRing() {
    difference() {
        rotate([90,0,90]) {
            scale([1, 1.25, 1]) {
                difference() {
                    cylinder(r = topperRingRadius, h = topperRingWidth, center = true);
                    cylinder(r = topperRingRadius - topperRingThick/2, h = topperRingWidth+extraCutoff, 
                    center = true);
                }
            }
        }
        union() {
            translate([0,0,topperScale*topperRingRadius/-1]) cube([topperRingWidth*2,topperScale*topperRingRadius*2, topperScale*topperRingRadius*2], center = true);
            translate([0,topperScale*topperRingRadius/2,topperScale*topperRingRadius/2]) cube([topperRingWidth*2, topperScale*topperRingRadius, topperScale*topperRingRadius], center = true);
        }
    }
}


module topperRings() {
    for(i = [1:numTopperRings]) {
        rotate([0,0,360/numTopperRings*i]) topperRing();
    }
}




module topper() {
    scale([1, 1, topperScale]) {
        difference() {
            sphere(r = meat3Radius);
            translate([0,0,-meat3Radius]) 
            cube([meat3Radius*2, meat3Radius*2, meat3Radius*2],  center = true);
        }
    }
    translate([0,0,(topperRadius*topperScale)+topperHeight*1.5]) {
        cylinder(r = topperRadius, h = topperHeight, center = true);
    }
    topperRings();
}

/* 
    DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
                        CODE OF PERTINENCE TO SECTIONS D & E
    DEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE
*/

//    module kickboard(width, depth, height) {

masoleumTinyOrnaments = 8;
masoleumTinyOrnamentRadius = 4;
masoleumCollumnOrnamentationProtrusion =  -0.4;
masoluemCollumnRadius = 13;
bigMasHeight = 147;


//to be completely honest, a lot of the alignments get fucked up when you play with these, but I don't need to debug them (yet) so I'm going to leave them

   DFWindowLength = 57;
   DFArchModifier = 0.75;
   DFSmallKickboardWidth = 15;
   DFWindowKickboards = 3;
   DFWindowMiddleHeight = 30;
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

   
   
windowBarThickness = 3.5;

module windowBar(length) {
    cube([length, DFKickboardSandwichDepth, windowBarThickness], center = true);
}
   
module kickboardArch(switch) {
       difference() {
       cube([DFWindowLength + DFWindowCollumnExtra * 2, DFKickboardSandwichDepth, DFKickboardArchHeight], center = true);
           translate([0, 
           (DFKickboardSandwichDepth)/2 + (DFKickboardSandwichDepth * DFBigKickboardImprint)/-2, 
           (DFWindowMiddleHeight+DFKickboardArchExtraVertical+extraCutoff)/-2]) {
            kickboard(DFWindowLength * DFArchModifier, DFBigKickboardImprint*DFKickboardSandwichDepth + extraCutoff, DFKickboardArchHeight-DFKickboardArchExtraVertical + extraCutoff);     
           }
       }
       if(switch == 1) {
           translate([0,0, DFKickboardArchHeight/5]) windowBar(DFWindowLength);
           for(i = [1, -1 ]) {
               translate([-DFWindowCollumnExtra/2*i,0,0]) {
                   rotate([0, 90, 0]) {
                       windowBar(DFKickboardArchHeight);
                   }
               }
           }
       }
   }
   



   module kickboardSandwich(switch) {
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
       translate([0,0, bigMasHeight/-2]) kickboardArch(switch);
       
   }
   
   
   // module tinyCollumns(collumnHeight, smallRadius, tinyRadius, protrusion, numCollumns) {


   module masoleumCollumns(collumnHeight, length, numberOfParts) {
       difference() {
           cylinder(r = masoluemCollumnRadius, h = collumnHeight, center = true);
           //IF THERE ARE PROBLEMS WITH STL CHECK HERE
           tinyCollumns(extremeCutoff, masoluemCollumnRadius, masoleumTinyOrnamentRadius, masoleumCollumnOrnamentationProtrusion, masoleumTinyOrnaments);
       }
   }
   
   
   numSectionEMas = 20;
  
   
   module masoleum(numMasoleumThings, switch) {
       translate([((masoluemCollumnRadius + DFWindowLength+DFWindowCollumnExtra-DFWindowOverlap) * numMasoleumThings)/-2,0,0]) {
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
                   kickboardSandwich(switch);
           }
       }
       
      translate([((masoluemCollumnRadius + DFWindowLength+DFWindowCollumnExtra-DFWindowOverlap) * numMasoleumThings)/2,
       DFKickboardSandwichDepth/-2, (bigMasHeight+DFTopRoofThick)/2]) {
          cube([((masoluemCollumnRadius + DFWindowLength+DFWindowCollumnExtra-DFWindowOverlap) * numMasoleumThings)
           + masoluemCollumnRadius*2, DFKickboardSandwichDepth, DFTopRoofThick], center = true);
          translate([0, 0, (DFTopPokeOutThick+DFTopRoofThick)/2]) {
              cube([(masoluemCollumnRadius + DFWindowLength+DFWindowCollumnExtra-DFWindowOverlap) * numMasoleumThings + masoluemCollumnRadius*2, DFKickboardSandwichDepth +DFTopPoking , DFTopPokeOutThick], center = true);
          }
      }
   }
   }
   
   DFLength = (masoluemCollumnRadius + DFWindowLength+DFWindowCollumnExtra-DFWindowOverlap) * numSectionEMas + masoluemCollumnRadius*2;
   
   
   //(masoluemCollumnRadius * 5 + DFWindowLength+DFWindowCollumnExtra-DFWindowOverlap) * 3 + 
   
   
  DFTopRoofThick = 10;
   DFTopPokeOutThick = 10;
   DFTopPoking = 0;
  

/* 
    EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                        CODE OF PERTINENCE TO SECTION E
    EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
*/


module sectionE() {
    translate([0, 0,
    (bigMasHeight - sectionAThickness)/-2]) {
        rotate([0,0,270]) {
            masoleum(numSectionEMas, 0);
        }
        //translate([0, ((DFWindowLength)*3 + masoluemCollumnRadius*2 - DFWindowCollumnExtra*1.5)*i , 0]) sectionD();

    }
}

sectionDDoubleWindowWidth = 15;

module sectionDTopWindowCutouts() {    
        for(i = [1, - 1]) {
            translate([0,sectionDDoubleWindowWidth*i,0]) cube([extremeCutoff, sectionDDoubleWindowWidth, DFWindowMiddleHeight], center = true);
        }
    }
    
pyramidXSetback = 100;
    pyramidBottomThickness = 10;
    pyramidHeight = 100;
    pyramidWidth = 650;
    
module sectionDPyramid() {
    cube([(DFKickboardSandwichDepth*(sectionDRows+1)/2)-pyramidXSetback, (masoluemCollumnRadius * 8 + DFWindowLength* 3), pyramidBottomThickness], center = true);
    
    translate([0,0, pyramidHeight/2 + pyramidBottomThickness/2]) {
        
        scale([1,(masoluemCollumnRadius * 8 + DFWindowLength* 3)/((DFKickboardSandwichDepth*(sectionDRows+1)/2)-pyramidXSetback), 1]) 
        
        rotate([0,0,45]) 

        cylinder(r1 = (pyramidWidth-pyramidXSetback)/2, r2 = 0, h = pyramidHeight, $fn = 4, center = true);
    }
}


sectionDRows = 6;



module sectionD() {
    for(i = [0 : sectionDRows-1]) {
        translate([DFKickboardSandwichDepth/2 * i,0,0]) {
               rotate([0, 0, 270]) {
                masoleum(3, 1);
            }
        }
        translate([0,0,(bigMasHeight/2 + (DFWindowMiddleHeight+DFWindowCrustThickness*2)/2 + DFTopRoofThick + DFTopPokeOutThick)]) {
               translate([DFKickboardSandwichDepth*(10/3)/8,0,(pyramidHeight/2-pyramidBottomThickness/2)/2]) sectionDPyramid();
            sectionDBottom();
        }
           translate([DFTopPokeOutThick,0,((bigMasHeight+DFTopRoofThick*3)/-2)]) {
            sectionDBottom();
        }
    }
}

/*
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
  DFTopRoofThick = 15;
   DFTopPokeOutThick = 15;
*/



module sectionDBottom() {                
    difference() {
            translate([DFKickboardSandwichDepth*(sectionDRows/2)/4,0,0]) 
        cube([DFKickboardSandwichDepth*(sectionDRows+1)/2, 
            (masoluemCollumnRadius * 8 + DFWindowLength* 3)
            , DFWindowMiddleHeight + DFWindowCrustThickness*2 ], center = true);
            union() {
                translate([0,masoluemCollumnRadius,0]) {
                    sectionDTopWindowCutouts();
                    for(i = [1, -1]) {
                        translate([0, (DFWindowLength+masoluemCollumnRadius*2)*i, 0]) {
                            sectionDTopWindowCutouts();
                        }
                    }
                }
            }
        }
    }
    
 module underBottom() {                
    difference() {
            translate([DFKickboardSandwichDepth/-2,0,0]) 
        cube([DFKickboardSandwichDepth+masoluemCollumnRadius*2, 
            (masoluemCollumnRadius * 8 + DFWindowLength* 3)
            , DFWindowMiddleHeight + DFWindowCrustThickness*2 + DFTopRoofThick], center = true);
            union() {
                translate([0,masoluemCollumnRadius,0]) {
                    sectionDTopWindowCutouts();
                    for(i = [1, -1]) {
                        translate([0, (DFWindowLength+masoluemCollumnRadius*2)*i, 0]) {
                            sectionDTopWindowCutouts();
                        }
                    }
                }
            }
        }
    }



    
    
    //translate([0,0,bigMasHeight/2]) cube([DFKickboardSandwichDepth/2,DFKickboardSandwichDepth,bigMasHeight/2], center = true);


//sectionD();




/* 
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        CODE OF PERTINENCE TO SECTION F 
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
*/

level0Radius = 178;
level0NumberOfBoards = 14;
level0CutOutHeight = 32;
level0NonCutOutHeight = 359;
kickboardWidthLevel0F = 20;

level0Height = level0NonCutOutHeight + level0CutOutHeight;

level0RingRadius = 186;
level0RingHeight = 32;
    

module sectionF() {
   difference() {
        cylinder(r = level0Radius, h = level0Height, center = true);
        translate([0,0, (level0NonCutOutHeight-kickboardWidthLevel0)/2 - extraCutoff]) { 
         for(i = [0: level0NumberOfBoards]) {
              rotate([0,0, 360 / level0NumberOfBoards] * [0, 0, i]) {
                  translate([0,level0Radius/-2,0]) cube([kickboardWidthLevel0F,level0Radius*2,level0CutOutHeight], center = true);
                }
            }
     
        }
    }
    translate([0,0,(level0Height+level0RingHeight)/2]) {
        cylinder(r = level0RingRadius, h = level0RingHeight, center = true);
    }
    translate([0,100,0]) {
        translate([0,level0Radius,(level0CutOutHeight*3+middleCollumnHeight*2+dCollumnSandwichBreadHeight-dTotalHeight)/-2]) sectionD();
        translate([0,0,(level0Height-middleCollumnHeight*2-level0CutOutHeight+level0RingHeight)/2]) rotate([0,0,270]) middleCourtHouse();
        for(i = [-1, 1]) {
            translate([120*i,level0Radius,-150]) thrownTogetherShitLol();
        }
    }
    
    translate([0,level0Radius,(level0NonCutOutHeight/2+stairHeight*1.20)/-2]) {
            dStairs();
    }
   
}


module thrownTogetherShitLol() {
    cube([40, 100, 100], center = true);
}


middleTriangleRadius = 150;
middleTriangleThickness = 150;
middleCollumnHeight = 100;
middleCollumnWidth = 25;
middleTinyCollumnWidth = 5;
middleCollumnProtrusion = 2;

middleTriangleBorder = 15;
middleCutDepth = 15;

// module tinyCollumns(collumnHeight, smallRadius, tinyRadius, protrusion, numCollumns) 

module middleCourtHouse() {
    translate([middleTriangleThickness/-1.25,0, 0]) {
        scale([1, 1, 0.25])  {
            rotate([90, 30, 90]) {
                difference() {
                    cylinder(r = middleTriangleRadius, h = middleTriangleThickness, $fn = 3, center = true);
                    translate([0,0,middleTriangleThickness/-2]) cylinder(r = middleTriangleRadius-middleTriangleBorder*2, h = middleCutDepth+extraCutoff, $fn = 3, center = true);
                }

            }
        }
    }
    //sectionACollumn(100);
}

//GLOBAL STAGING

dCollumnRadius = 12; 
dTotalHeight = 225;
dCollumnCapitalExtra = 10;
dCollumnHCapitalThick = 20; 
dBigRadiusExtra = 2;

module dCollumn() {
    cylinder(r2 = dCollumnRadius, r1 = dCollumnRadius + dBigRadiusExtra, h = dTotalHeight-2*dCollumnHCapitalThick, center = true);
    for(i = [1, -1]) {
        translate([0,0,(dTotalHeight-dCollumnHCapitalThick)/2*i]) {
            cube([dCollumnRadius*2+dCollumnCapitalExtra, dCollumnRadius*2+dCollumnCapitalExtra, dCollumnHCapitalThick], center = true);
        }
    }
}

dCollumnSandwichBreadHeight = 10;

module dCollumnSandwich() {
    for(i = [-1.5, -0.5, 0.5, 1.5]) {
        translate([(level0Radius/4+15)*i,0,0]) {
            dCollumn();
        }
    }
    for(i = [-1, 1]) {
        translate([0,0,(dCollumnSandwichBreadHeight+dTotalHeight)/2*i]) {
            cube([middleTriangleRadius*1.75,dCollumnCapitalExtra+dCollumnRadius*2, dCollumnSandwichBreadHeight], center = true);
        }
    }
}

stairWidth = 300;
stairInitialHeight = -5;
stairVerticalIncrement = 2.5;
stairHorizontalIncrement = 10;
stairs = 20;
stairLength = stairHorizontalIncrement * stairs;
stairHeight = stairVerticalIncrement * stairs;

module dStairs() {
    rotate([0,180,0]) {
        difference() {
            for(i = [1 : stairs]) {
                translate([0,stairHorizontalIncrement/2*i,stairInitialHeight+stairVerticalIncrement*(i-1)*2]) 
                cube([stairWidth, stairHorizontalIncrement*i, stairInitialHeight + stairVerticalIncrement*i], center = true);
            }
                    translate([0,0,stairHeight*2]) cube([stairWidth*2, stairLength*2, stairHeight], center = true);

        }
    }
}

//dStairs();


module sectionD() {
    dCollumnSandwich();
}




module currentRender() {
    //translate([sectionARadius + middleTriangleThickness,0, -200]) middleCourtHouse();

    //translate([0,0,sectionAHeight]) sectionB();
    //translate([0, 0, sectionAHeight/2]) sectionA();

    
}

//I should not that, in order to get a model for printB (I think) I did break printA in the process.....
module printA() {
    translate([0, 0, sectionAHeight/2]) sectionA();
}

toppersHeight = bread0Height + meat0Height + bread1Height + meat1Height + bread2Height + meat2Height + bread3Height + meat3Height;

module printB() {
    sectionB();
    translate([0,0, toppersHeight]) topper();
}
  
module printC() {
        //translate([-110,-10,(bigMasHeight+10+(bigMasHeight+DFTopRoofThick*2)/2)/-2]) cube([550, 1920, 10], center = true);
  translate([sectionARadius/-1,0,0]) {
        translate([0, -85,bigMasHeight/2]) sectionE();
         translate([(DFKickboardSandwichDepth)/-2,((masoluemCollumnRadius * 9.5 + DFWindowLength* 3)*3+DFWindowLength/-1), 0]) sectionD();
       translate([(DFKickboardSandwichDepth)/-2,(((masoluemCollumnRadius * 10.5 + DFWindowLength* 3)*3+DFWindowLength/-1)/-1), 0]) sectionD();
        }
        translate([0, -25, 0]) for(i = [-3: 3]) {
            translate([DFKickboardSandwichDepth*-1, DFKickboardSandwichDepth*(sectionDRows+0.25)/2*i/2,((bigMasHeight+DFTopRoofThick*2)/-2)]) 
            underBottom();
        }
    }

module printD() {
    sectionF();
   translate([200,0,0])  middleCourtHouse();
}




printC();
//printD();

