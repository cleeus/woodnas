include <wn_renderctrl.scad>
use <wn_sizes.scad>

module wn_bottom_cover() {
    wall_d = wn_wall_d();
    w = wn_case_w() - wall_d;
    h = wn_case_d() - wall_d;
    
    echo(str("bottom cover: ", w, " x ", h));
    
    color(wn_colors()[4])
    cube([
        w,
        h,
        wall_d
    ]);    
}
