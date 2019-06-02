include <wn_renderctrl.scad>
use <wn_sizes.scad>


module wn_hdd_carrier() {
    //must be a little bit bigger then slot to fit into rails
    carrier_w = wn_hdd_carrier_w();
    carrier_d = wn_hdd_carrier_d();
    carrier_h = wn_thin_wall_d();
    
    echo(str("hdd carrier: ", wn_hdd_carrier_w(), " x ", wn_hdd_carrier_d()));
    
    drive_w = 102;
    drive_h = 26;
    drive_d = 147;
    
    //carrier
    cube([carrier_w, carrier_d, carrier_h]);
    
    //hdd drive placeholder
    color([0.9,0.9,0.9], alpha=0.5)
    translate([
        (carrier_w-drive_w)/2-1,
        (carrier_d-drive_d)/2,
        carrier_h
    ])
    cube([drive_w, drive_d, drive_h]);
}


