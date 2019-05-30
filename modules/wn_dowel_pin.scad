include <wn_renderctrl.scad>
use <wn_sizes.scad>

module wn_dowel_pin()
{
  color(wn_colors()[10])
  cylinder(h=wn_dowel_pin_l(),d=wn_dowel_pin_d());
}
