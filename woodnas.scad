$fn = 50;
wall_th = 1.2;  //cm

case_depth = 45.0; //cm
case_height = 36.0; //cm
case_width = 25.0; //cm

seperator_height = 0; //cm

atx_power_w=15.0;
atx_power_h=8.6;
atx_power_d=14.0;

hdd_slot_h = 4.2;
hdd_slot_w = 14.6;
hdd_slot_d = 14.7;
hdd_carrier_w = case_width - 3*wall_th;
hdd_carrier_d = hdd_slot_w + 2;

fan_th = 2.5 + 1;

alpha = 0.8;

colors = [
    "lightblue",
    "lightgreen",
    "lightpink",
    "LightSalmon",
    "Wheat",
    "DarkSeaGreen",
    "PapayaWhip",
    "PowderBlue",
    "Lavender"
    ];





module apc_back_ups() {
    d = 31.0;
    w = 8.0;
    h = 19;
    
    translate([
        case_width-3*wall_th-w,
        3*wall_th,
        case_height])
    rotate([0,0,0])
    {
        color([0.2,0.2,0.2])
        cube([w, d, h]);
    
        color("DeepSkyBlue")
        translate([w/2-w*0.4/2,-0.1,h-h*0.25])
        cube([w*0.4,0.3,h*0.2]);
    }
}

module atx_power_supply() {
    a = 0.5;
    w=atx_power_w;
    h=atx_power_h;
    d=atx_power_d;
    fan=12.0;
    
    translate([
        case_width-wall_th,
        case_depth-d-wall_th-0.1,
        h+wall_th
    ])
    rotate([0,180,0])
    {
        //body
        color([0.3,0.3,0.3], a)
        cube([w,d,h]);
        
        color([0.6,0.6,0.6], a)
        //fan
        translate([
            w/2,
            d/2,
            -0.1
        ])
        cylinder(h=0.1,d1=fan,d2=fan);
        
        //main cable
        color([0.4,0.4,0.4], a)
        translate([w-3,0,2])
        rotate([90,90,0])
        cylinder(h=6,d1=2,d2=2);
    }
    
}


module mini_itx_board() {
    a = 0.5;
    translate([
        case_width-wall_th-0.5,
        case_depth-wall_th-0.1,
        case_height-wall_th-3
    ])
    rotate([180,90,0]) {
        color("ForestGreen", a)
        cube([17,17,0.5]);

        color("grey", a) {
            cube(2);
            translate([2,0,0.1])
            cube(3);
            
            translate([2+3,0,0.1])
            cube(1);
            
            translate([2+3+2,0,0.1])
            cube(2.5);
            
            translate([2+3+2+2.5+2,0,0.1])
            cube(1.5);
            
            translate([2+3+2+2.5+2+2,0,0.1])
            cube(2);
        }
        
        color([1,1,1], 0.01)
        translate([0,-0.05,-0.05])
        cube([17.1,17.1,5.1]);
    }
}

module atx_switch() {
    color([0.1,0.1,0.1])
    cube([1,1,0.5]);
    
    translate([0,0,0.5])
    color([0.5,0.5,0.5])
    cube([1,1,0.5]);

    color([0.1,0.1,0.1])
    union() {
        translate([0.3,0.3,1])
        cube([0.4,0.4,0.4]);

        translate([0.4,0.3,1])
        cube([0.2,0.4,0.7]);
    }
    
    color([0.2,0.2,0.2])
    translate([0.2,0.1,-0.8])
    cube([0.6,0.15,0.8]);
}


module atx_led(col="red") {
    //contacts
    translate([-0.1,-0.05,0.3])
    color([0.3,0.3,0.3])
    cube([0.2,0.1,0.5]);
    
    //body
    color(col)
    union() {
        cylinder(h=0.3,d1=0.3,d2=0.3);
        sphere(d=0.3);
    }
}


module hdd_carrier() {
    //must be a little bit bigger then slot to fit into rails
    carrier_w = hdd_carrier_w;
    carrier_d = hdd_carrier_d;
    carrier_h = 0.5;
    
    drive_w = 10.2;
    drive_h = 2.6;
    drive_d = 14.7;
    
    //carrier
    cube([carrier_w, carrier_d, carrier_h]);
    
    //hdd
    color([0.9,0.9,0.9], alpha=0.5)
    translate([
        (carrier_w-drive_w)/2-1,
        (carrier_d-drive_d)/2,
        carrier_h
    ])
    cube([drive_w, drive_d, drive_h]);
}


module hdd_carrier_stack() {
    
    translate([0,0, 0*hdd_slot_h])
    hdd_carrier();
    
    translate([0,0, 1*hdd_slot_h])
    hdd_carrier();
    
    translate([0,0, 2*hdd_slot_h])
    hdd_carrier();
    
    translate([0,0, 3*hdd_slot_h])
    hdd_carrier();
}

module fan_box() {
    cage_h = 4*hdd_slot_h + hdd_slot_h/2;
    fan_box_w = case_width - 4*wall_th;
    
    difference() {
        cube([
            fan_box_w,
            wall_th,
            cage_h
        ]);

        {
            translate([0,wall_th*2,0])
            for(r=[1:4]) {
                translate([0,0,r*hdd_slot_h])
                for(c=[1:9]) {
                    translate([c*1.7,-wall_th/2,0])
                    rotate([90,0,0])
                    cylinder(h=wall_th*2,d1=1.2,d2=1.2);
                }
            }
        }
    }
    
    //lower edge
    translate([0,-fan_th,0])
    cube([
        fan_box_w,
        fan_th,
        wall_th
    ]);
    
    //top plate
    translate([0,-fan_th,cage_h])
    cube([
        fan_box_w,
        hdd_carrier_d+2*wall_th+fan_th,
        wall_th
    ]);

}

module hdd_carrier_assembly() {
    base_height = atx_power_h + hdd_slot_h;

    cage_h = 4*hdd_slot_h + hdd_slot_h/2;
    back_mount_w = 4;


    fan_box_w = case_width - 4*wall_th;
    fan_box_d = wall_th + fan_th;


    translate([
        case_width-hdd_carrier_w-wall_th,
        wall_th+fan_box_d,
        base_height
    ])
    {    
        //back mount
        translate([hdd_carrier_w-back_mount_w, hdd_carrier_d, -hdd_slot_h/2])
        cube([
            back_mount_w,
            wall_th,
            cage_h
        ]);
        
        //fan box
        translate([hdd_carrier_w-fan_box_w, -wall_th, -hdd_slot_h/2])
        fan_box();
        
        //carriers
        hdd_carrier_stack();        
    }
}


module atx_power_back_fixer() {
    l=4;
    
    translate([
        case_width-2*wall_th,
        case_depth-wall_th-l-atx_power_d+1,
        atx_power_h+wall_th-1
    ])
    
    difference() {
        cube([
            wall_th,
            l,
            l]);
        
        translate([-0.2,l-1,-0.2])
        cube([
            wall_th+1,
            1.2,
            1.2
        ]);
    }
    
}

module right_cover() {
    w = case_depth - wall_th;
    h = case_height - wall_th;
    echo(str("right cover: ", w, " x ", h));
    
    color(colors[0])
    translate([case_width-wall_th, wall_th])
    cube([
        wall_th,
        w,
        h
        ]);
}

module lower_left_cover() {
    color(colors[6]);
    cube([
        wall_th,
        case_depth,
        seperator_height+2*wall_th
    ]);
}

module button_holes() {
    translate([8,0,0])
    rotate([90,0,0])
    cylinder(h=2*wall_th,d1=1.6,d2=1.6);
    
    translate([4,0,0])
    rotate([90,0,0])
    cylinder(h=2*wall_th,d1=1,d2=1);
    
    translate([1,0,0])
    rotate([90,0,0])
    cylinder(h=2*wall_th,d1=0.4,d2=0.4);
    
    translate([0,0,0])
    rotate([90,0,0])
    cylinder(h=2*wall_th,d1=0.4,d2=0.4);
}

module power_button() {
    color("DeepSkyBlue", 0.5)
    union() {
        scale([1.3,1.3,1.3])
        difference() {
            sphere(1);
        
            translate([-2,-0.6,-2])
            cube(4);
            
            translate([-2,-4.8,-2])
            cube(4);
        }
        
        translate([0,1.1,0])
        rotate([90,0,0])
        cylinder(h=2,d1=1.6,d2=1.6);
    }    
}

module atx_reset_switch(button_top_offset) {
    translate([
        13+3.5,
        wall_th + 1.05,
        case_height-button_top_offset-0.5  
    ])
    rotate([90,0,0])
    atx_switch();
    
    translate([
        13+3.5 + 0.5,
        wall_th - 0.4,
        case_height-button_top_offset-0.5 + 0.5
    ])
    rotate([90,0,0])
    cylinder(h=wall_th-0.3,d1=0.95,d2=0.95);
}

module front_cover(with_buttons) {
    w = case_width;
    h = case_height - wall_th;
    
    echo(str("front cover: ", w, " x ", h));
    
    button_top_offset = 3*wall_th;
    
    color(colors[1])
    
    difference() {        
        {
            translate([0,0,seperator_height])
            cube([
                w,
                wall_th,
                h
                ]);
        }
        
        //fan hole
        {
            translate([
                case_width/2,
                wall_th*1.5,
                seperator_height+6+ 3.5*hdd_slot_h
            ])
            rotate([90,0,0])
            cylinder(h=2*wall_th,d1=12,d2=12);
        }
        
        //button holes
        {
            translate([
                13,
                1.5*wall_th,
                case_height-button_top_offset
            ])
            button_holes();
        }
    }

    if(with_buttons)
    {
        //power switch
        translate([
            13+8,
            0.75,
            case_height-button_top_offset
        ])
        power_button();
        
        //reset switch
        atx_reset_switch(button_top_offset);
        
        
        //leds
        translate([
            13,
            0.8,
            case_height-button_top_offset  
        ])
        rotate([-90,0,0])
        atx_led(col="red");


        translate([
            14,
            0.8,
            case_height-button_top_offset  
        ])
        rotate([-90,0,0])
        atx_led(col="green");
    } //with_buttons
    
}

module back_cover() {
    w = case_width-wall_th;
    h = case_height-2*wall_th;
    
    echo(str("back cover: ", w, " x ", h));
    
    color(colors[6])
    difference() {
        {
            translate([
                0,
                case_depth-wall_th,
                wall_th
            ])
            cube([
                w,
                wall_th,
                h,
                ]);
        }
    
        //fan hole
        {
            translate([
                6+3*wall_th+1,
                case_depth+wall_th/2,
                case_height-3*wall_th-6
            ])
            rotate([90,0,0])
            cylinder(h=2*wall_th,d1=12,d2=12);
        }
        
        //atx power hole
        {
            translate([
                case_width-atx_power_w-wall_th+0.5,
                case_depth-wall_th*1.5,
                wall_th-0.1
            ])
            cube([
                atx_power_w-0.5+0.1,
                2*wall_th,
                atx_power_h-0.5+0.1
            ]);
            
        }
        
        //itx board hole
        {
            translate([0,wall_th*1.5,0])
            mini_itx_board();
        }
    }
    
}

module upright_cover_rail(d=wall_th) {
    translate([
        0,
        0,
        2*wall_th
    ])
    cube([
        wall_th,
        d,
        case_height-3*wall_th
    ]);
}

module left_cover_rails() {
    color(colors[7]) {
        translate([2*wall_th,0])
        {
            //inner front
            translate([0, wall_th])
            upright_cover_rail(d=wall_th+fan_th);
            
            //inner back
            translate([0, case_depth-2*wall_th])
            upright_cover_rail();
            
            bottom_rail_l = case_depth-2*wall_th;
            bottom_rail_w = case_width-2*wall_th-atx_power_w-wall_th;
            
            echo(str("bottom rail: ", bottom_rail_l, "x", bottom_rail_w));
            
            //inner bottom
            translate([
                0,
                wall_th,
                wall_th
            ])
            cube([
                bottom_rail_w,
                bottom_rail_l,
                wall_th
            ]);
        }
        
        //outer front
        translate([0, wall_th])
        upright_cover_rail();
        
        //outer back
        translate([0, case_depth-2*wall_th])
        upright_cover_rail();
        
        //outer bottom
        translate([0, wall_th, wall_th])
        cube([
            wall_th,
            case_depth-2*wall_th,
            wall_th
        ]);
    }
}
    
module top_cover() {
    w = case_width-2*wall_th;
    h = case_depth;
    
    echo(str("top cover: ", w, " x ", h));
    
    color(colors[3])
    translate([
        2*wall_th,
        0,
        case_height-wall_th])
    cube([
        w,
        h,
        wall_th
        ]);
}



module bottom_cover() {
    w = case_width-wall_th;
    h = case_depth-wall_th;
    
    echo(str("bottom cover: ", w, " x ", h));
    
    color(colors[4])
    translate([
        0,
        wall_th,
        seperator_height
    ])
    cube([
        w,
        h,
        wall_th
    ]);    
}


module left_cover() {
    w1 = case_depth-2*wall_th;
    h1 = case_height-2*wall_th;
    
    w2 = case_depth-2*wall_th-2*wall_th;
    h2 = case_height-3*wall_th;
    
    echo(str("left inner cover: ", w1, " x ", h1));
    echo(str("left outer cover: ", w2, " x ", h2));
    
    translate([-3*case_width,0])
    color(colors[8]) {
        //inner big layer
        translate([
            wall_th,
            wall_th,
            seperator_height+wall_th
        ])
        cube([
            wall_th,
            w1,
            h1
        ]);
        
        //outer smaller layer        
        difference() {
            translate([
                0,
                2*wall_th,
                seperator_height+2*wall_th
            ])        
            cube([
                wall_th,
                w2,
                h2
            ]);
            
            //hole for handle
            translate([0, case_depth/2, case_height - 5*wall_th])
            {
                d=5;
                $fn=20.0;
                rotate([0,90,0])
                translate([0,-d/2,-wall_th/2])
                hull() {
                    cylinder(h=wall_th*1.5,d1=d,d2=d);
                
                    translate([0,d])
                    cylinder(h=wall_th*1.5,d1=d,d2=d);
                }
            }
        }
        
        
        //top edge
        translate([
            0,0,
            case_height-wall_th
        ])
        cube([
            2*wall_th,
            case_depth,
            wall_th
        ]);
    
    }
}

//from https://gist.github.com/damccull/1a1df5e785e56daf53e0d7b7d8ff219e
module explode(distance = [10, 0, 0], center = false, enable = true) {
    if(enable){
        offset = center ? (($children * distance) / 2 - distance / 2) * -1 : [0, 0 , 0];
        for(i = [0 : 1 : $children - 1]) {
            translate(i * distance + offset) {
                children(i);
            }
        }
    } else {
        children();
    }
}
//explode(distance = [7, 7, 0], enable=false) { ... }

translate([0,0,0]) {
    apc_back_ups();
    //lower_left_cover();
    atx_power_supply();
    atx_power_back_fixer();
    mini_itx_board();
    hdd_carrier_assembly();

    front_cover();
        
    left_cover_rails();
    left_cover();
        
    back_cover();
    right_cover();
    bottom_cover();
    top_cover();
}


* projection(cut=true) {
    scale([10.0,10.0])
        translate([0,0,-wall_th/2])
        rotate([90,0,0])
        front_cover();
}


