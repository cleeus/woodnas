include <wn_renderctrl.scad>
use <wn_sizes.scad>

wn_rail_color = wn_colors()[7];

module wn_rail_bottom_inner() {

  bottom_rail_l = wn_case_d() - 2*wn_wall_d();
  bottom_rail_w = wn_case_w() - 2*wn_wall_d() - wn_atx_power_w() - wn_wall_d();            
  echo(str("bottom rail: ", bottom_rail_l, "x", bottom_rail_w));

  color(wn_rail_color)
  cube([
      bottom_rail_w,
      bottom_rail_l,
      wn_wall_d()
  ]);
}

module wn_rail_front_inner_bottom() {
  front_rail_l = wn_fan_box_base()-wn_wall_d();
  front_rail_w = wn_fan_box_d() + wn_thin_wall_d();
  
  echo(str("front rail bottom part: ", front_rail_l, "x", front_rail_w));

  color(wn_rail_color)
  cube([
        wn_wall_d(),
        front_rail_w,
        front_rail_l
    ]);

}
