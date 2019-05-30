include <wn_renderctrl.scad>
use <wn_sizes.scad>


module wn_atx_power_supply() {
    a = wn_alpha()/1.5;
    w=wn_atx_power_w();
    h=wn_atx_power_h();
    d=wn_atx_power_d();
    fan=120;
    
    //body
    color([0.3,0.3,0.3], a)
    cube([w,d,h]);
    
    color([0.6,0.6,0.6], a)
    //fan
    translate([
        w/2,
        d/2,
        -1.1
    ])
    cylinder(h=1,d=fan);
    
    //main cable
    color([0.4,0.4,0.4], a)
    translate([w-30,0,20])
    rotate([90,90,0])
    cylinder(h=60,d=20);
    
}

wn_atx_power_supply();
