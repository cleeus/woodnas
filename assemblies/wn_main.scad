use <../modules/wn_sizes.scad>
use <../modules/wn_front_cover.scad>
use <../modules/wn_right_cover.scad>
use <../modules/wn_top_cover.scad>
use <../modules/wn_bottom_cover.scad>
use <../modules/wn_left_cover_rails.scad>
use <../modules/wn_atx_power_supply.scad>
use <../modules/wn_mini_itx_board.scad>

use <wn_hdd_carrier_assembly.scad>

module wn_left_cover_rails() {
    translate([
        2*wn_wall_d(),
        wn_wall_d(),
        wn_wall_d()
    ])
    wn_rail_bottom_inner();
    
    
    translate([
        2*wn_wall_d(),
        wn_wall_d(),
        2*wn_wall_d(),
    ])
    wn_rail_front_inner_bottom();
    
}


module wn_covers() {
    wn_front_cover(with_buttons=true);
    
    translate([0,wn_wall_d(),0])
    wn_bottom_cover();
    
    translate([
        wn_case_w()-wn_wall_d(),
        wn_wall_d(),
        0])
    wn_right_cover();
    
    
    translate([
        2*wn_wall_d(),
        0,
        wn_case_h()-wn_wall_d()
    ])
    wn_top_cover();
}




wn_covers();

translate([0,0,wn_atx_power_h()+wn_wall_d()])
wn_hdd_carrier_assembly();
wn_left_cover_rails();

translate([ //position in case
    wn_case_w()-wn_wall_d()-wn_atx_power_w()-0.01,
    wn_case_d()-wn_wall_d()-wn_atx_power_d(),
    wn_wall_d()+0.01
])
translate([ wn_atx_power_w(), 0, wn_atx_power_h()]) //center on 0,0,0
rotate([0,180,0]) //turn upside-down
wn_atx_power_supply();

translate([
    wn_case_w()-wn_wall_d()-5,
    wn_case_d()-wn_wall_d()-1,
    wn_case_h()-wn_wall_d()-30
])
wn_mini_itx_board();