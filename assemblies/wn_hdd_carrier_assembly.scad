use <../modules/wn_sizes.scad>
use <../modules/wn_front_fan_box.scad>
use <../modules/wn_hdd_carrier.scad>
use <../modules/wn_hdd_rail.scad>

module wn_hdd_carrier_assembly()
{
    //fan box
    translate([
        wn_case_w()-wn_wall_d()-wn_fan_box_w(),
        wn_wall_d(),
        wn_atx_power_h()+wn_wall_d()
    ])
    wn_front_fan_box();

    echo(str("hdd slot: ", wn_hdd_slot_h()));
    
    //carriers
    for(carrier=[0:wn_hdd_count()-1]) {
        translate([0,0,wn_atx_power_h()+wn_wall_d()])
        translate([
            wn_wall_d()*2,
            wn_fan_box_d()+wn_wall_d()+wn_thin_wall_d(),
            wn_hdd_slot_h()/2 + carrier*wn_hdd_slot_h()])
        wn_hdd_carrier();
    }
    
    //back rail
    translate([
      2*wn_wall_d(),
      wn_wall_d() + wn_fan_box_d() + wn_thin_wall_d() + wn_hdd_carrier_d() + wn_u_profile_wall_d(),
      2*wn_wall_d()
    ])
    wn_hdd_rail();
}
