
function wn_wall_d() = 12;  //mm
function wn_thin_wall_d() = 6; //mm

function wn_u_profile_wall_d() = 1.5; //mm
function wn_u_profile_h() = 10; //mm
function wn_u_profile_w() = wn_thin_wall_d() + 2*wn_u_profile_wall_d(); //mm


function wn_case_d() = 450; //mm
function wn_case_h() = 360; //mm
function wn_case_w() = 250; //mm

function wn_seperator_h() = 0; //mm

function wn_atx_power_w() = 150; //mm
function wn_atx_power_h() = 86; //mm
function wn_atx_power_d() = 140; //mm

function wn_hdd_count() = 5;
function wn_hdd_slot_h() = 42;  //mm
function wn_hdd_slot_w() = 146;  //mm
function wn_hdd_slot_d() = 147;  //mm
function wn_hdd_carrier_w() = wn_case_w() - 3*wn_wall_d();
function wn_hdd_carrier_d() = wn_hdd_slot_w() + 2*wn_u_profile_h() + 12;

function wn_fan_d() = 25;
function wn_fan_r() = 120/2;

function wn_fan_box_base() = wn_atx_power_h();
function wn_fan_box_d() = wn_fan_d() + 15 /*buffer*/;
function wn_fan_box_w() = wn_case_w() - 3*wn_wall_d();
function wn_fan_box_h() = wn_case_h() - wn_fan_box_base() - wn_wall_d();


function wn_alpha() = 0.8;

function wn_dowel_pin_d() = 6;
function wn_dowel_pin_l() = 30;

function wn_colors() = [
    "lightblue",      //0
    "lightgreen",     //1
    "lightpink",      //2
    "LightSalmon",    //3
    "Wheat",          //4
    "DarkSeaGreen",   //5
    "PapayaWhip",     //6
    "PowderBlue",     //7
    "Lavender",       //8
    "Goldenrod",      //9
    "SaddleBrown",    //10
    "LightSlateGray", //11
    "BurlyWood"       //12
    ];
