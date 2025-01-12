#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;

#namespace vehicle;

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x2
// Checksum 0xa0950c0, Offset: 0x130
// Size: 0x14
function autoexec init() {
    function_d64f1d30();
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x8f455ef0, Offset: 0x150
// Size: 0x328
function private function_d64f1d30() {
    a_registered_fields = [];
    foreach (bundle in getscriptbundles("vehicleriders")) {
        foreach (object in bundle.objects) {
            if (isdefined(object.vehicleenteranim)) {
                array::add(a_registered_fields, object.position + "_enter", 0);
            }
            if (isdefined(object.vehicleexitanim)) {
                array::add(a_registered_fields, object.position + "_exit", 0);
            }
            if (isdefined(object.var_cbf50c1d)) {
                array::add(a_registered_fields, object.position + "_exit_combat", 0);
            }
            if (isdefined(object.vehiclecloseanim)) {
                array::add(a_registered_fields, object.position + "_close", 0);
            }
            if (isdefined(object.var_b7605392)) {
                array::add(a_registered_fields, object.position + "_close_combat", 0);
            }
            if (isdefined(object.vehicleriderdeathanim)) {
                array::add(a_registered_fields, object.position + "_death", 0);
            }
        }
    }
    foreach (str_clientfield in a_registered_fields) {
        clientfield::register("vehicle", str_clientfield, 1, 1, "counter", &play_vehicle_anim, 0, 0);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x8ed0f185, Offset: 0x480
// Size: 0x41c
function play_vehicle_anim(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    s_bundle = getscriptbundle(self.vehicleridersbundle);
    str_pos = "";
    str_action = "";
    if (strendswith(bwastimejump, "_enter")) {
        str_pos = getsubstr(bwastimejump, 0, bwastimejump.size - 6);
        str_action = "enter";
    } else if (strendswith(bwastimejump, "_exit")) {
        str_pos = getsubstr(bwastimejump, 0, bwastimejump.size - 5);
        str_action = "exit";
    } else if (strendswith(bwastimejump, "_exit_combat")) {
        str_pos = getsubstr(bwastimejump, 0, bwastimejump.size - 12);
        str_action = "exit_combat";
    } else if (strendswith(bwastimejump, "_close")) {
        str_pos = getsubstr(bwastimejump, 0, bwastimejump.size - 6);
        str_action = "close";
    } else if (strendswith(bwastimejump, "_close_combat")) {
        str_pos = getsubstr(bwastimejump, 0, bwastimejump.size - 13);
        str_action = "close_combat";
    } else if (strendswith(bwastimejump, "_death")) {
        str_pos = getsubstr(bwastimejump, 0, bwastimejump.size - 6);
        str_action = "death";
    }
    str_vh_anim = undefined;
    foreach (s_rider in s_bundle.objects) {
        if (s_rider.position == str_pos) {
            switch (str_action) {
            case #"enter":
                str_vh_anim = s_rider.vehicleenteranim;
                break;
            case #"exit":
                str_vh_anim = s_rider.vehicleexitanim;
                break;
            case #"exit_combat":
                str_vh_anim = s_rider.var_cbf50c1d;
                break;
            case #"close":
                str_vh_anim = s_rider.vehiclecloseanim;
                break;
            case #"close_combat":
                str_vh_anim = s_rider.var_b7605392;
                break;
            case #"death":
                str_vh_anim = s_rider.vehicleriderdeathanim;
                break;
            }
            break;
        }
    }
    if (isdefined(str_vh_anim)) {
        self setanimrestart(str_vh_anim);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x465b1f26, Offset: 0x8a8
// Size: 0x2a
function set_vehicleriders_bundle(str_bundlename) {
    self.vehicleriders = getscriptbundle(str_bundlename);
}

