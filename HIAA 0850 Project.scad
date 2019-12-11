   
/*
    CODE OF GLOBAL IMPORTANCE
*/
  
    //Make sure that all differences are printable.
    extraCutoff = 0.01;
    
    //Amount of sides per cylinder. 
    $fn = 30;
    
    //Tiny collumn that ornaments small collumns on partial piece! 
    module tinyCollumn(radius, height) {
        cylinder(r = radius, h = height, center = true);
    }
    
    
    
    //Loop that makes all of the ornamentation for the small collumns.
    module tinyCollumns(height, smallRadius, tinyRadius, protrusion) {
        for(i = [0: sectionANumberOfOrnamentalCollumns]) {
            rotate( 
                (i * 360 / sectionANumberOfOrnamentalCollumns) * 
                [0, 0, 1]) {
                    translate([smallRadius - tinyRadius * protrusion, 0, 0]) {
                        tinyCollumn(tinyRadius, height);
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
        tinyCollumns(height+extraCutoff, sectionASmallCollumnRadius, sectionAOrnamentationRadius, sectionAOrnamentationProtrusion);
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

/* BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB                      CODE OF PERTINENCE TO SECTION B  
    BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
*/
    



module makeRing(radius, thickness) { 
    cylinder(r = radius, h = thickness, center = true);
}

module createHalfWafer(numberOfBoards, ringRadius, ringThickness, middleRadius, middleThickness, width, depth) {
    translate([0,0, ringThickness/2]) {
        makeRing(ringRadius, ringThickness);
    }
    translate([0,0, ringThickness + middleThickness/2]) { 
        difference() {
            makeRing(middleRadius, middleThickness);
            translate([0, 0, middleThickness/-4]) createKickboards(ringRadius, numberOfBoards, width, depth, middleThickness);
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

topHalfWaferCut = 1;

module threeRings() {
    rotate([0,0,35]) {
        createHalfWafer(
        numberOfBoardsLevel2, 
        ring2Radius, 
        ring2Thickness, 
        level2Radius, 
        level2Height, 
        kickboardWidthLevel2, 
        ring2Radius * topHalfWaferCut);
    }
    translate([0, 0, level2Height + ring2Thickness]) { 
        rotate([0, 0, 0]) {
            createHalfWafer(
            numberOfBoardsLevel3,
            ring3Radius, 
            ring3Thickness,
            level3Radius, 
            level3Height,
            kickboardWidthLevel3,
            ring3Radius * topHalfWaferCut);
        }
        translate([0,0,level3Height + ring3Thickness]) {
            rotate([0,0,0]) {
                createHalfWafer(
                numberOfBoardsLevel4,
                ring4Radius,
                ring4Thickness,
                level4Radius,
                level4Height,
                kickboardWidthLevel4,
                ring4Radius * topHalfWaferCut);
            }
        }
    }
}



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
    

module bottomThing() {
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

module currentRender() {
    translate([sectionARadius + middleTriangleThickness,0, -200]) middleCourtHouse();
    translate([0,0,-130]) bottomThing();
    translate([0,0,sectionAHeight]) threeRings();
    translate([0, 0, sectionAHeight/2]) sectionA();
}

currentRender();

//    module tinyCollumns(height, smallRadius, tinyRadius, protrusion) {


module ornamentedCollumn(height, collumnOuterRadius, collumnOrnamentRadius, protrusion) {
    difference() {
        
            tinyCollumns(height, collumnOuterRadius, collumnOrnamentalRadius, protrusion);
    }
} 

