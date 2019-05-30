use <../modules/wn_sizes.scad>
use <../modules/wn_front_cover.scad>
use <../modules/wn_bottom_cover.scad>
use <../modules/wn_front_fan_box.scad>
use <../modules/wn_left_cover_rails.scad>
use <../modules/wn_atx_power_supply.scad>



module wn_hdd_carrier_assembly()
{
    base_height = wn_atx_power_h() + wn_hdd_slot_h();
    
    translate([
        wn_case_w()-wn_wall_d()-wn_fan_box_w(),
        wn_wall_d(),
        base_height - 2*wn_wall_d()
    ])
    wn_front_fan_box();
}

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
    wn_rail_front_inner();
}


module wn_covers() {
    wn_front_cover(with_buttons=true);
    
    translate([0,wn_wall_d(),0])
    wn_bottom_cover();
}


wn_covers();
wn_hdd_carrier_assembly();
wn_left_cover_rails();


translate([ //position in case
    wn_case_w()-wn_wall_d()-wn_atx_power_w(),
    wn_case_d()-wn_wall_d()-wn_atx_power_d(),
    wn_wall_d()+0.01
])
translate([ wn_atx_power_w(), 0, wn_atx_power_h()]) //center on 0,0,0
rotate([0,180,0]) //turn upside-down
wn_atx_power_supply();