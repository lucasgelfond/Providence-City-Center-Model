/*
my notes/fixes :
- dimensions fixed and attempted to make better; are these proportions better? 
- how do I do parapet cornices? what is the geometry of them? what are examples of similar hood cornices? let's play with what this looks like together
- openings changed from rounded to square 
- code really cleaned up so opening change should work—you say "14 openings" but is that for all of these, or just one level? let's decide level by level
- dome bands actually do spring up from the openings, I think 
- choragic monument made, this was the biggest change:
    - is there a center there? or is it supposed to be open
    - does the ledge bit have a curve? i'm confused
    - doesn't totally square away with specifics of diagram Jon gave me/I found online/
    

*/

sfn = 30;
spheresfn = 20;
manifold = 0.0001;

topper();

module topper() {
    level1();
    translate([0,0,level1Height]) {
        level2();
        translate([0,0,level2Height]) {
            level3(); 
            translate([0,0,level3Height]) {
                level4();
                translate([0,0, level4Height]) {
                    dome();
                    translate([0, 0, domeHeight*domeScale + domeRingThick]) {
                        choragicCollumn();
                    }
                }
            }
        }
    }
}


//level 1
level1BaseRadius = 172;
level1BaseHeight = 15;
level1MiddleRadius = 161;
level1MiddleHeight = 99;

level1Windows = 16;
level1WindowWidth = 30;
level1WindowHeight = level1MiddleHeight/2;
level1WindowDepth = 100;

level1Height = level1BaseHeight + level1MiddleHeight;

//level 2
level2BaseRadius = 172;
level2BaseHeight = 15;
level2MiddleRadius = 161;
level2MiddleHeight = 99;

level2Windows = 16;
level2WindowWidth = 40;
level2WindowHeight = level2MiddleHeight/2;
level2WindowDepth = 100;

level2Height = level2BaseHeight + level2MiddleHeight;

//level3
level3BaseRadius = 138;
level3BaseHeight = 15;
level3MiddleRadius = 117;
level3MiddleHeight = 90;

level3Windows = 8;
level3WindowWidth = 45;
level3WindowDepth = 100;
level3WindowHeight = level3MiddleHeight/1.5;

level3Height = level3BaseHeight + level3MiddleHeight;

//level 4
level4BaseRadius = 113;
level4BaseHeight = 20;
level4MiddleRadius = 98;
level4MiddleHeight = 70;

level4Windows = 10;
level4WindowWidth = 30;
level4WindowDepth = 100;
level4WindowHeight = level4MiddleHeight/2;

level4Height = level4BaseHeight + level4MiddleHeight;

module level4() {
    base(level4BaseRadius, level4BaseHeight);
    translate([0,0,level4BaseHeight]) level4Middle();
}

module level3() {
    base(level3BaseRadius, level3BaseHeight);
    translate([0,0,level3BaseHeight]) level3Middle();
}

module level2() {
    base(level2BaseRadius, level2BaseHeight);
    translate([0,0,level2BaseHeight]) level2Middle();
}

module level1() {
    base(level1BaseRadius, level1BaseHeight);
    translate([0,0,level1BaseHeight]) level1Middle();
}

module level1Middle() {
    middleLevel(level1MiddleRadius, level1MiddleHeight, level1Windows, level1WindowWidth, level1WindowHeight, level1WindowDepth);
}

module level2Middle() {
   middleLevel(level2MiddleRadius, level2MiddleHeight, level2Windows, level2WindowWidth, level2WindowHeight, level2WindowDepth);
}

module level3Middle() {
       middleLevel(level3MiddleRadius, level3MiddleHeight, level3Windows, level3WindowWidth, level3WindowHeight, level3WindowDepth);
}

module level4Middle() {
    middleLevel(level4MiddleRadius, level4MiddleHeight, level4Windows, level4WindowWidth, level4WindowHeight, level4WindowDepth);
}

module middleLevel(middleRadius, middleHeight, windows, windowWidth, windowHeight, windowDepth) {
    translate([0,0, middleHeight/2]) {
        difference() {
            cylinder(r = middleRadius, h = middleHeight, $fn = sfn, center = true);
            windowedCylinderWindows(middleRadius, windows, windowWidth, windowHeight, windowDepth);
        }
    }
}


module base(baseRadius, baseHeight) {
    translate([0,0,baseHeight/2]) cylinder(r = baseRadius, h = baseHeight, $fn = sfn, center = true);
}

module windowedCylinderWindows(radius, numWindows, windowWidth, windowHeight, windowDepth, myModule) {
    for(i = [0 : numWindows]) {
        rotate((i * 360 / numWindows) * [0, 0, 1]) {
            translate([radius-windowDepth/2, 0, 0]) {
                window(windowDepth, windowHeight, windowWidth);
            }
        }
    }
} 

module window(windowDepth, windowHeight, windowWidth) {
    cube([windowDepth, windowWidth, windowHeight], center = true);
}

domeRadius = 24;
domeHeight = 92;
domeScale = 1.25;


module dome() {
    scale([1, 1, domeScale]) {
        difference() {
            sphere(r = level4MiddleRadius, $fn = spheresfn);
            translate([0,0, -level4MiddleRadius]) {
                cube([level4MiddleRadius * 2, level4MiddleRadius * 2, level4MiddleRadius * 2], center = true);
            }
        }
    }
    domeRings();
}


numDomeRings = 10;

module domeRings() {
    for(i = [1:numDomeRings]) { 
        rotate([0, 0, (360/numDomeRings)*i]) translate([manifold, manifold, 0]) domeRing();
    }
}

domeRingWidth = 6.5;
domeRingThick = 15;
domeRingRadius = domeRingThick/2 + level4MiddleRadius;
domeRingScale = 1.25;

module domeRing() {
    scale([1,1,domeRingScale]) {
        difference() {
            rotate([90, 0, 90]) {
                difference() {
                    cylinder(r = domeRingRadius, h = domeRingWidth, center = true, $fn = sfn);
                    cylinder(r = domeRingRadius - domeRingThick/2, h = domeRingWidth+manifold, center = true);
                }
            }
            union() {
                translate([0, 0, domeRingRadius/-1]) cube([domeRingWidth * 2,  domeRingRadius*2, domeRingRadius*2], center = true);
                translate([0, domeRingRadius/2, domeRingRadius/2]) cube([domeRingWidth * 2,  domeRingRadius, domeRingRadius], center = true);
            }
        }
    }   
}






module choragicCollumn() {
    choragicCollumnBase();
    translate([0,0, choragicBaseIndentHeight + choragicBaseUnderHeight]) {
        choragicCollumnMiddle();
        translate([0,0, choragicSurroundingCollumnHeight]) {
            choragicCollumnTop();
            translate([0,0, choragicTopHeight]) {
                choragicPole();
            }
        }
    }
}


choragicBaseIndentRadius = 17.5;
choragicBaseIndentHeight = 15;
choragicBaseUnderRadius = 25;
choragicBaseUnderHeight = 7.5;

module choragicCollumnBase() {
    translate([0,0,choragicBaseIndentHeight/2]) {
        cylinder(r = choragicBaseIndentRadius, h = choragicBaseIndentHeight, $fn = sfn, center = true);
        translate([0, 0,(choragicBaseIndentHeight + choragicBaseUnderHeight)/2]) {
            cylinder(r = choragicBaseUnderRadius, h = choragicBaseUnderHeight, $fn = sfn, center = true);
        }
    }
}

choragicSurroundingCollumnHeight = 60;
choragicCollumnRadius = 20;

module choragicCollumnMiddle() {
    for(i = [0:numChoragicSurroundingCollumns]) {
        rotate(360/numChoragicSurroundingCollumns * i * [0,0, 1]) translate([choragicCollumnRadius,0,choragicSurroundingCollumnHeight/2]) choragicSurroundingCollumn();
    }
}

numChoragicSurroundingCollumns = 8;
choragicSurroundingCollumnRadius = 4.5;

module choragicSurroundingCollumn(){
    cylinder(r = choragicSurroundingCollumnRadius, h = choragicSurroundingCollumnHeight, $fn = sfn, center = true);
}


choragicTopBigRadius = 30;
choragicTopSmallRadius = 7.5;
choragicTopHeight = 15;
choragicTopFlatPortion = 5;

module choragicCollumnTop() {
       translate([0,0, choragicTopFlatPortion/2]) cylinder(r = choragicTopBigRadius, h = choragicTopFlatPortion, $fn = sfn, center = true);
        translate([0,0,choragicTopHeight/2 + choragicTopFlatPortion/2]) cylinder(r1 = choragicTopBigRadius, r2 = choragicTopSmallRadius, h = choragicTopHeight-choragicTopFlatPortion, $fn = sfn, center = true);
}

choragicPoleRadius = 3.5;
choragicPoleHeight = 45;

module choragicPole() {
    translate([0,0,choragicPoleHeight/2]) cylinder(r = choragicPoleRadius, h = choragicPoleHeight, $fn = sfn, center = true);
}



