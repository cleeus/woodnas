include <wn_renderctrl.scad>
use <wn_sizes.scad>

wn_front_cover_atx_switch_w1 = 8.4;
wn_front_cover_atx_switch_h1 = 8.4;
wn_front_cover_atx_switch_d1 = 8.0;
    
wn_front_cover_atx_switch_w2 = 4;
wn_front_cover_atx_switch_h2 = 4;
wn_front_cover_atx_switch_d2 = 5.6;

wn_front_cover_button_holes_power_d = 12;
wn_front_cover_button_holes_reset_d = 12;
wn_front_cover_button_holes_led_d = 4;

wn_front_cover_button_innset = 1;

wn_front_cover_button_distance = 32; //M12 washer diameter

module wn_front_cover_M12_washer() {
  d_hole = 13;
  d_outer = 31.5;
  h = 3;
  
  color([0.9,0.9,1.0])
  translate([0,0,-h])
  difference() {
    cylinder(h=h, d=d_outer);
    
    translate([0,0,-h/2])
    cylinder(h=h*2, d=d_hole);
  }

}

module wn_front_cover_atx_switch() {
    w1 = wn_front_cover_atx_switch_w1;
    h1 = wn_front_cover_atx_switch_h1;
    d1 = wn_front_cover_atx_switch_d1;
    
    w2 = wn_front_cover_atx_switch_w2;
    h2 = wn_front_cover_atx_switch_h2;
    d2 = wn_front_cover_atx_switch_d2;
    
    innset = wn_front_cover_button_innset;
    
    translate([0,0,innset]) {
      translate([-w1/2,-h1/2, -d1])
      {
        color([0.1,0.1,0.1])
        cube([w1,h1,d1/2]);
        
        color([0.5,0.5,0.5])
        translate([0,0,d1/2])
        cube([w1,h1,d1/2]);
      }

      color([0.1,0.1,0.1])
      translate([ -w2/2 , -h2/2, 0])
      union() {
          cube([w2, h2, d2/2]);

          translate([w2/4,0,d2/2])
          cube([w2/2, h2, d2/2]);
      }
      
      color([0.2,0.2,0.2])
      translate([-w1/4, h1/4, -d1*1.5])
      cube([w1/2, h1/8, d1/2]);
    }
    
    wn_front_cover_M12_washer();
}


module wn_front_cover_atx_switch_with_wood_cover(diameter) {

    //switch
    rotate([90,0,0])
    wn_front_cover_atx_switch();
    
    //wood cover
    color([242/255, 192/255, 101/255, wn_alpha()])
    translate([0,- wn_front_cover_button_innset - wn_front_cover_atx_switch_d2/2 - 0.1, 0])
    rotate([90,0,0])
    cylinder(h=wn_wall_d() - wn_front_cover_atx_switch_d2/2, d=diameter);
}

module wn_front_cover_atx_power_button() {
    color("DeepSkyBlue", 0.5)
    union() {
        scale([1.3,1.3,1.3])
        difference() {
            sphere(10);
        
            translate([-20,-6,-20])
            cube(40);
            
            translate([-20,-48,-20])
            cube(40);
        }
        
        translate([0,11,0])
        rotate([90,0,0])
        cylinder(h=20,d=16);
    }    
}

module wn_front_cover_atx_led(col="red") {
    //contacts
    translate([-1,-0.5,3])
    color([0.3,0.3,0.3])
    cube([2,1,5]);
    
    //body
    color(col)
    union() {
        cylinder(h=3,d=3);
        sphere(d=3);
    }
}



module wn_front_cover_button_holes() {
    wall_d = wn_wall_d();
    
    //led1
    translate([-wn_front_cover_button_distance/6,0,0])
    rotate([90,0,0])
    cylinder(h=2*wall_d,d=wn_front_cover_button_holes_led_d);
    
    //led2
    translate([wn_front_cover_button_distance/6,0,0])
    rotate([90,0,0])
    cylinder(h=2*wall_d,d=wn_front_cover_button_holes_led_d);
    
    //power button
    translate([0,0,wn_front_cover_button_distance*0.5])
    rotate([90,0,0])
    cylinder(h=2*wall_d,d=wn_front_cover_button_holes_power_d);
    
    //reset button
    translate([0,0,wn_front_cover_button_distance*1.5])
    rotate([90,0,0])
    cylinder(h=2*wall_d,d=wn_front_cover_button_holes_reset_d);
    
}


module wn_front_cover_buttons() {
    //led1
    translate([-wn_front_cover_button_distance/6,0,0])
    rotate([-90,0,0])
    wn_front_cover_atx_led(col="red");

    //led2
    translate([wn_front_cover_button_distance/6,0,0])
    rotate([-90,0,0])
    wn_front_cover_atx_led(col="green");
    
    //power switch
    translate([0,0,wn_front_cover_button_distance*0.5])
    wn_front_cover_atx_switch_with_wood_cover(wn_front_cover_button_holes_power_d-1);
    
    //reset switch
    translate([0,0,wn_front_cover_button_distance*1.5])
    wn_front_cover_atx_switch_with_wood_cover(wn_front_cover_button_holes_power_d-1);
        
}


module wn_front_cover(with_buttons) {
    wall_d = wn_wall_d();
    case_w = wn_case_w();
    case_h = wn_case_h();
    
    w = wn_case_w();
    h = wn_case_h() - wall_d;
    seperator_h = wn_seperator_h();
    
    hdd_slot_h = wn_hdd_slot_h();
    
    echo(str("front cover: ", w, " x ", h));
    
    button_top_offset = 3*wall_d;
    
    color(wn_colors()[1])
    
    difference() {        
        {
            translate([0,0,seperator_h])
            cube([
                w,
                wall_d,
                h
                ]);
        }
        
        //fan hole
        {
            translate([
                case_w/2,
                wall_d*1.5,
                seperator_h + wn_fan_r() + 3.5*hdd_slot_h
            ])
            rotate([90,0,0])
            cylinder(h=2*wall_d, r=wn_fan_r());
        }
        
        //button holes
        {
            translate([
                3*wall_d + wn_front_cover_button_distance/2,
                wall_d*1.5,
                2.5*wall_d
            ])
            wn_front_cover_button_holes();
        }
    }

    if(with_buttons)
    {
        translate([
            3*wall_d + wn_front_cover_button_distance/2,
            wall_d,
            2.5*wall_d
        ])
        wn_front_cover_buttons();
    } //with_buttons
    
}


