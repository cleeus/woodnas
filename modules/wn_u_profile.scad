include <wn_renderctrl.scad>
use <wn_sizes.scad>


module wn_u_profile(length) {
  u_profile_wall_d = 1.5;
  u_profile_h = wn_thin_wall_d() + 2+u_profile_wall_d;
  
  color(wn_colors()[11])
  difference() {
    //outer cube
    cube([
      length,
      2*u_profile_wall_d + wn_thin_wall_d(),
      u_profile_h
    ]);
    
    //inner cutout
    {
      translate([-1,u_profile_wall_d,u_profile_wall_d])
      cube([
        length+2,
        wn_thin_wall_d(),
        u_profile_h
      ]);
    }
  }
}

wn_u_profile(10);
