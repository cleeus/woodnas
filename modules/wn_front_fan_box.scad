include <wn_renderctrl.scad>
use <wn_sizes.scad>
use <wn_dowel_pin.scad>
use <wn_u_profile.scad>

module wn_front_fan_box() {
    thin_wall_d = wn_thin_wall_d();
    wall_d = wn_wall_d();
    
    cage_h = wn_fan_box_h()-wall_d;
    fan_box_w = wn_fan_box_w();
    
    //sieve
    translate([0, wn_fan_box_d(),-1])
    difference() {
        cube([
            fan_box_w,
            thin_wall_d,
            cage_h
        ]);

        {
            hole_d = 12;
            hole_dist = hole_d * 1.5;
            hole_back_distance = (fan_box_w - 8*hole_dist) / 2;
            
            translate([hole_back_distance,thin_wall_d*2,0])
            for(row=[1:4]) {
                translate([0,0,row*wn_hdd_slot_h()])
                for(column=[0:8]) {
                    translate([column*hole_dist,-thin_wall_d/2,0])
                    rotate([90,0,0])
                    cylinder(h=thin_wall_d*2,d=hole_d);
                }
            }
        }
        
    }
    
    //lower edge
    color(wn_colors()[9])
    cube([
        fan_box_w,
        wn_fan_box_d(),
        wall_d
    ]);
    
    //dowel pin connectors on lower edge - only glued to lower edge, not to sieve
    translate([
      0,
      wn_fan_box_d() + wn_dowel_pin_l()/3,
      wall_d/2
    ])
    for(column=[0:2]) {
      pin_dist = fan_box_w / 3;
      translate([column*pin_dist + pin_dist/2,0,0])
      rotate([90,0,0])
      wn_dowel_pin();
    }
    
    
    //top plate
    color(wn_colors()[9])
    translate([0,0,cage_h])
    cube([
        fan_box_w,
        wn_hdd_carrier_d()+2*wall_d+wn_fan_box_d(),
        wall_d
    ]);
    
    
    //top u profile to hold sieve
    translate([
      0.5,
      wn_fan_box_d()+thin_wall_d+1,
      cage_h
    ])
    rotate([180,0,0])
    wn_u_profile(fan_box_w-1);
}
wn_front_fan_box();
