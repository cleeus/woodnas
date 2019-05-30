use <../modules/wn_sizes.scad>
use <../modules/wn_front_fan_box.scad>
use <../modules/wn_hdd_carrier.scad>

wn_hdd_carrier_back_rail_w = (wn_fan_box_w() - wn_hdd_slot_w())/2;

module wn_hdd_carrier_back_rail()
{
  cube([
    wn_hdd_carrier_back_rail_w,
    wn_wall_d(),
    wn_fan_box_h() - wn_hdd_slot_h()/2
  ]);
}

module wn_hdd_carrier_assembly()
{    
    translate([
        wn_case_w()-wn_wall_d()-wn_fan_box_w(),
        wn_wall_d(),
        0
    ])
    wn_front_fan_box();

    for(carrier=[0:wn_hdd_count()-1]) {
        translate([
            wn_wall_d()*2,
            wn_fan_box_d()+wn_wall_d()+wn_thin_wall_d(),
            wn_hdd_slot_h()/2 + carrier*wn_hdd_slot_h()])
        wn_hdd_carrier();
    }
    
    translate([
      wn_case_w() - wn_hdd_carrier_back_rail_w - wn_wall_d(),
      wn_wall_d() + wn_fan_box_d() + wn_thin_wall_d() + wn_hdd_carrier_d(),
      wn_wall_d() + wn_u_profile_h() - wn_hdd_slot_h()/2 + wn_wall_d()])
    wn_hdd_carrier_back_rail();
}
