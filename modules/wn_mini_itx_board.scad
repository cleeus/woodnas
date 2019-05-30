include <wn_renderctrl.scad>
use <wn_sizes.scad>


module wn_mini_itx_board() {
    a = 0.5;

    rotate([180,90,0]) {
        color("ForestGreen", a)
        cube([170,170,5]);

        color("grey", a) {
            cube(20);
            translate([20,0,0.1])
            cube(30);
            
            translate([20+30,0,0.1])
            cube(10);
            
            translate([20+30+20,0,0.1])
            cube(25);
            
            translate([20+30+20+25+20,0,0.1])
            cube(15);
            
            translate([20+30+20+25+20+20,0,0.1])
            cube(20);
        }
        
        color([1,1,1], 0.01)
        translate([0,-0.05,-0.05])
        cube([170.1,170.1,50.1]);
    }
}
