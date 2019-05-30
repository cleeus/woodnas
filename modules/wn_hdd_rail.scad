use <wn_sizes.scad>
use <wn_u_profile.scad>

module wn_hdd_rail()
{
  right_h = wn_fan_box_h() - wn_hdd_slot_h()/2;
  left_h = wn_case_h() - 3*wn_wall_d();
  base_offset = left_h-right_h;
  
  echo(str("right hdd rail: ", wn_hdd_rail_w(), " x ", right_h));
  echo(str("left hdd rail: ", wn_hdd_rail_w(), " x ", left_h));
  
  //right rail
  translate([wn_hdd_carrier_w()-wn_hdd_rail_w(), 0, base_offset])
  cube([
    wn_hdd_rail_w(),
    wn_wall_d(),
    right_h
  ]);

  //left rail
  cube([
    wn_hdd_rail_w(),
    wn_wall_d(),
    left_h
  ]);

  
  //u profiles to fix hdd carries
  for(carrier=[0:wn_hdd_count()-1]) {
      translate([
          0,
          0,
          base_offset + carrier*wn_hdd_slot_h() + wn_u_profile_w() + wn_u_profile_wall_d()])
      rotate([90,0,0])
      wn_u_profile(wn_fan_box_w());
  }

}
