include <wn_renderctrl.scad>
use <wn_sizes.scad>
use <wn_dowel_pin.scad>
use <wn_u_profile.scad>

module wn_front_fan_box() {
    thin_wall_d = wn_thin_wall_d();
    wall_d = wn_wall_d();
    
    sieve_h = wn_fan_box_h() - 2*wall_d - 2*wn_u_profile_wall_d();
    fan_box_w = wn_fan_box_w();
    
    echo(str("hdd fan sieve: ", sieve_h, " x ", fan_box_w));
    
    
    //bottom plate
    bottom_plate_w = fan_box_w;
    bottom_plate_l = wn_fan_box_d() + wn_thin_wall_d() + wn_u_profile_wall_d();
    echo(str("hdd carrier bottom plate: ", bottom_plate_w, " x ", bottom_plate_l));
    
    color(wn_colors()[9])
    cube([
        fan_box_w,
        bottom_plate_l,
        wall_d
    ]);
    
    //bottom u profile to hold sieve
    translate([
      0.5,
      bottom_plate_l - wn_u_profile_w(),
      wall_d
    ])
    rotate([0,0,0])
    wn_u_profile(fan_box_w-1);
    
    /*
    //top plate
    top_plate_w = fan_box_w;
    top_plate_l = wn_hdd_carrier_d() + wn_fan_box_d() + thin_wall_d;
    echo(str("hdd carrier top plate: ", top_plate_w, " x ", top_plate_l));
    
    color(wn_colors()[9])
    translate([0,0,sieve_h+wall_d+2*wn_u_profile_wall_d()])
    cube([
        top_plate_w,
        top_plate_l,
        wall_d
    ]);
    */
    
    //top u profile to hold sieve
    translate([
      0.5,
      bottom_plate_l,
      sieve_h+wall_d+2*wn_u_profile_wall_d()
    ])
    rotate([180,0,0])
    wn_u_profile(fan_box_w-1);
    
    //u profiles to fix hdd carriers
    for(carrier=[0:wn_hdd_count()-1]) {
      translate([0,0,wn_hdd_slot_h()/2 + carrier*wn_hdd_slot_h()])
      translate([
        1,
        wn_fan_box_d()+thin_wall_d,
        wn_u_profile_w()-1
      ])
      rotate([-90,0,0])
      wn_u_profile(fan_box_w-1);
    }
    
    //sieve
    translate([0, wn_fan_box_d(), wall_d+wn_u_profile_wall_d()])
    difference() {
        cube([
            fan_box_w,
            thin_wall_d,
            sieve_h
        ]);

        {
            hole_d = 12;
            hole_dist = hole_d * 1.5;
            hole_back_distance = (fan_box_w - 8*hole_dist) / 2;
            
            translate([hole_back_distance,thin_wall_d*2,0])
            for(row=[1:wn_hdd_count()]) {
                translate([0,0,row*wn_hdd_slot_h() - wn_hdd_slot_h()/2 + thin_wall_d])
                for(column=[0:8]) {
                    translate([column*hole_dist,-thin_wall_d/2,0])
                    rotate([90,0,0])
                    cylinder(h=thin_wall_d*2,d=hole_d);
                }
            }
        }
        
    }
    
    //sieve front stabilizer
    translate([0,wn_fan_box_d()-wall_d,wall_d+wn_u_profile_h()])
    color(wn_colors()[12])
    cube([wall_d, wall_d, sieve_h-2*wn_u_profile_h()+2*wn_u_profile_wall_d()]);
    
    //sieve back stabilizer
    translate([wn_fan_box_w()-wall_d,wn_fan_box_d()-wall_d,wall_d+wn_u_profile_h()])
    color(wn_colors()[12])
    cube([wall_d, wall_d, sieve_h-2*wn_u_profile_h()+2*wn_u_profile_wall_d()]);
    
}
wn_front_fan_box();
