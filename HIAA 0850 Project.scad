    
    //Make sure that all differences are printable.
    extraCutoff = 1;
    
    //
    smallCollumnRadius = 7;
    collumnHeight = 100;
    bigCollumnRadius = 20;
    $fn = 100;
    
    //number
    numberOfSmallCollumns = 8;
    
    /*
    How much of the collumns to show. Play with this to change
    the appearence of the small collumns. 
    */
    extendOutRatio = 1.5;
    
    
    module bigCollumnBase() {
        cylinder(r = bigCollumnRadius, h = collumnHeight, center = true);
    }
        
    
    module smallCollumn() {
        cylinder(r = smallCollumnRadius, h = collumnHeight, center = true);
    }
    
    module smallCollumns() {
        for(i = [0: numberOfSmallCollumns]) {
        rotate( 
            (i * 360 / numberOfSmallCollumns) * 
            [0, 0, 1]) {
                translate([bigCollumnRadius - smallCollumnRadius/extendOutRatio, 0, 0]) {
                    smallCollumn();
                }
            }
        }
    }
    

    bigCollumnBase();
    smallCollumns();