    
    //Make sure that all differences are printable.
    extraCutoff = 1;
    
    //Radius of ornamentation on surrounding collumns.
    tinyCollumnRadius = 8;
    
    //Height of the  partial portion with tiny/small/big collumns.
    partialCollumnHeight = 750;
    
    /*Radius of the ornamental collumns that run partially up the building.
    */
    smallCollumnRadius = 20;
    
    //Amount of sides per cylinder. 
    $fn = 100;
    
    //Number of collumns ornamented on each small collumn.
    numberOfTinyCollumns = 8;
    
    /*
    How much of the collumns to show. Play with this to change
    the appearence of the small collumns. 
    */
    tinyCollumnProtrusion = 1.35;
    
    
    numberOfSmallCollumns = 15;
    bigCollumnRadius = 150;
    smallCollumnProtrusion = 100;

    
    module smallCollumnBase() {
        cylinder(r = smallCollumnRadius, h = partialCollumnHeight, center = true);
    }
        
    
    module tinyCollumn() {
        cylinder(r = tinyCollumnRadius, h = partialCollumnHeight, center = true);
    }
    
    module tinyCollumns() {
        for(i = [0: numberOfTinyCollumns]) {
        rotate( 
            (i * 360 / numberOfTinyCollumns) * 
            [0, 0, 1]) {
                translate([smallCollumnRadius - tinyCollumnRadius / tinyCollumnProtrusion, 0, 0]) {
                    tinyCollumn();
                }
            }
        }
    }
    
    module smallCollumn() {
        smallCollumnBase();
        tinyCollumns();
    }
    
    
    module bigPartialCollumn() {
        cylinder(r = bigCollumnRadius, h = partialCollumnHeight,
        center = true);
        for(i = [0: numberOfSmallCollumns]) {
            rotate(
            (i * 360 / numberOfSmallCollumns) * [0, 0, 1]) {
                translate([bigCollumnRadius - smallCollumnRadius             / smallCollumnProtrusion, 0, 0]) {
                    smallCollumn();
            }
        }
    }
}

topSectionBigRadius = 175;
topSectionRingBulge = 15;
topSectionLowGapHeight = 100;

topSectionBottomRingHeight = 15;
topSectionMiddleRingHeight = 50;
topSectionTopRingHeight = 30;

    module topRingSection() {

        //bottom ring
        translate([0, 0, topSectionBottomRingHeight / 2]) { 
        cylinder(r = topSectionBigRadius + topSectionRingBulge, h = topSectionBottomRingHeight, center = true); 
        }
        
        //middle section
        translate([0, 0, topSectionLowGapHeight / 2 +
        topSectionBottomRingHeight]) {
            cylinder(r = topSectionBigRadius, 
            h = topSectionLowGapHeight, center = true);
        }
    
        //top ring
        translate([0, 0, topSectionTopRingHeight / 2 + 
        topSectionBottomRingHeight + topSectionLowGapHeight]) {
            cylinder(r = topSectionBigRadius +      
            topSectionRingBulge, h = 
            topSectionTopRingHeight, center = true);
        }
    }
    

topRingSection();
    
