include <wn_renderctrl.scad>
use <wn_sizes.scad>

module wn_top_cover() {
    w = wn_case_w()-2*wn_wall_d();
    h = wn_case_d();
    
    echo(str("top cover: ", w, " x ", h));
    
    color(wn_colors()[3])
    cube([
        w,
        h,
        wn_wall_d()
        ]);
}
