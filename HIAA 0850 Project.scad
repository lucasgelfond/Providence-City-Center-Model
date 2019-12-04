    
    //Make sure that all differences are printable.
    extraCutoff = 0.01;
    
    //Amount of sides per cylinder. 
    $fn = 30;
    
    //How much of the collumns to show. Play with this to change appearence of small collumns.
    tinyCollumnProtrusion = 1.35;
    
    
    numberOfSmallCollumns = 15;
    bigCollumnRadius = 150;
    smallCollumnProtrusion = 100;
    
    

    //Radius of ornamentation on surrounding collumns.
    tinyCollumnRadius = 8;
    
    //Height of the  partial portion with tiny/small/big collumn ornamentation scheme.
    partialCollumnHeight = 750;
    
    //Tiny collumn that ornaments small collumns on partial piece! 
    module tinyCollumn(height) {
        cylinder(r = tinyCollumnRadius, h = height, center = true);
    }
    
    
    //Radius of the ornamental collumns that run partially up the building.
    smallCollumnRadius = 20;

    //Base cylinder for small Collumn
    module smallCollumnBase(height) {
        cylinder(r = smallCollumnRadius, h = height, center = true);
    }
        
   //Number of collumns ornamented on each small collumn.
    numberOfTinyCollumns = 8;
    
    //Loop that makes all of the ornamentation for the small collumns.
    module tinyCollumns(height, smallRadius, tinyRadius, protrusion) {
        for(i = [0: numberOfTinyCollumns]) {
        rotate( 
            (i * 360 / numberOfTinyCollumns) * 
            [0, 0, 1]) {
                translate([smallRadius - tinyRadius / protrusion, 0, 0]) {
                    tinyCollumn(height);
                }
            }
        }
    }
    
    //Puts small collumn together with ornamentation! 
    module smallCollumn(height) {
        smallCollumnBase(height);
        tinyCollumns(height, smallCollumnRadius, tinyCollumnRadius, tinyCollumnProtrusion);
    }
    
    
bottomSectionNumberOfRings = 8;
bottomSectionRingBulge = 20;
bottomSectionThickness = 20;
module bigRings() {
    for(i = [0: bottomSectionNumberOfRings]) {
        translate([0,0, partialCollumnHeight/bottomSectionNumberOfRings * i - 
        partialCollumnHeight / 2]) {
            cylinder(r = bigCollumnRadius + bottomSectionRingBulge, h = bottomSectionThickness, center = true);
        }
    }
}
    //Creates big section with the double ornamentation and adds small collumns around it
    module bigPartialCollumn() {
        cylinder(r = bigCollumnRadius, h = partialCollumnHeight,
        center = true);
        for(i = [0: numberOfSmallCollumns]) {
            rotate(
            (i * 360 / numberOfSmallCollumns) * [0, 0, 1]) {
                translate([bigCollumnRadius - smallCollumnRadius / smallCollumnProtrusion, 0, 0]) {
                    smallCollumn(partialCollumnHeight);
            }
        }
    }
    bigRings();
}



module makeRing(radius, thickness) { 
    cylinder(r = radius, h = thickness, center = true);
}

module createKickboards(xTrans, numberOfBoards, width, depth, height) {    
    for(i = [0: numberOfBoards]) {
          rotate((i * 360 / numberOfBoards) * [0, 0, 1]) {
                translate([xTrans, 0, 0]) {
                    rotate([0,0,90]) kickboard(width, depth, height); 
            }
        }
    }
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

//createHalfWafer(numberOfBoards, ringRadius, ringThickness, middleRadius, middleThickness, width, depth)

module threeRings() {
    rotate([0,0,35]) {
        createHalfWafer(
        numberOfBoardsLevel2, 
        ring2Radius, 
        ring2Thickness, 
        level2Radius, 
        level2Height, 
        kickboardWidthLevel2, 
        bigCollumnRadius*5);
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
            bigCollumnRadius * 5);
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
                bigCollumnRadius * 5);
            }
        }
    }
}

level0Radius = 180;
level0NumberOfBoards = 10;
level0CutOutHeight = 40;
level0NonCutOutHeight = 200;
kickboardWidthLevel0 = 30;

//module createKickboards(xTrans, numberOfBoards, width, depth, height)

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

//    module tinyCollumns(height, smallRadius, tinyRadius, protrusion) {


translate([bigCollumnRadius + middleTriangleThickness,0, -200]) middleCourtHouse();

translate([0,0,-130]) bottomThing();

translate([0,0,partialCollumnHeight]) threeRings();
translate([0, 0, partialCollumnHeight/2]) bigPartialCollumn();

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
    //middle
    tinyCollumns(middleCollumnHeight, middleTinyCollumnWidth, middleCollumnWidth, middleCollumnProtrusion);
    
    for(i = [-1, 1]) { 
        translate([0, (middleTriangleRadius*3/5)*i,0]) {
                tinyCollumns(middleCollumnHeight, middleTinyCollumnWidth, middleCollumnWidth, middleCollumnProtrusion);
        }
    }
}



