#using script_544e81d6e48b88c0;
#using script_78825cbb1ab9f493;

#namespace namespace_cf48051e;

// Namespace namespace_cf48051e/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xeaaa1562, Offset: 0xe0
// Size: 0x1c
function event_handler[gametype_init] main(*eventstruct) {
    namespace_17baa64d::init();
}

// Namespace namespace_cf48051e/event_f4737734
// Params 1, eflags: 0x40
// Checksum 0x604829e4, Offset: 0x108
// Size: 0x174
function event_handler[event_f4737734] objective_update(eventstruct) {
    if (eventstruct.isnew) {
        camera = undefined;
        switch (eventstruct.name) {
        case #"dom_a":
            camera = "dom_a_cam";
            break;
        case #"dom_b":
            camera = "dom_b_cam";
            break;
        case #"dom_c":
            camera = "dom_c_cam";
            break;
        case #"dom_d":
            camera = "dom_d_cam";
            break;
        case #"dom_e":
            camera = "dom_e_cam";
            break;
        case #"dom_headquarter":
            if (eventstruct.team == #"allies") {
                camera = "dom_allies_hq_cam";
            } else if (eventstruct.team == #"axis") {
                camera = "dom_axis_hq_cam";
            }
            break;
        }
        if (isdefined(camera)) {
            namespace_99c84a33::function_99652b58(camera, eventstruct.id);
        }
    }
}

