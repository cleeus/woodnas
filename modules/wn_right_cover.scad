include <wn_renderctrl.scad>
use <wn_sizes.scad>

module wn_right_cover() {
    w = wn_case_d() - wn_wall_d();
    h = wn_case_h() - wn_wall_d();
    echo(str("right cover: ", w, " x ", h));
    
    color(wn_colors()[0])
    cube([
        wn_wall_d(),
        w,
        h
    ]);
}
