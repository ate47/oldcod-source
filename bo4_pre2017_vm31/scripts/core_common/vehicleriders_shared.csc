#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;

#namespace vehicle;

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x2
// Checksum 0x3f806d92, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("vehicleriders", &__init__, undefined, undefined);
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x0
// Checksum 0xc9b2a644, Offset: 0x278
// Size: 0x2f2
function __init__() {
    a_registered_fields = [];
    foreach (bundle in struct::get_script_bundles("vehicleriders")) {
        foreach (object in bundle.objects) {
            if (isstring(object.vehicleenteranim)) {
                array::add(a_registered_fields, object.position + "_enter", 0);
            }
            if (isstring(object.vehicleexitanim)) {
                array::add(a_registered_fields, object.position + "_exit", 0);
            }
            if (isstring(object.vehiclecloseanim)) {
                array::add(a_registered_fields, object.position + "_close", 0);
            }
            if (isstring(object.vehicleriderdeathanim)) {
                array::add(a_registered_fields, object.position + "_death", 0);
            }
        }
    }
    foreach (str_clientfield in a_registered_fields) {
        clientfield::register("vehicle", str_clientfield, 1, 1, "counter", &play_vehicle_anim, 0, 0);
    }
}

// Namespace vehicle/vehicleriders_shared
// Params 7, eflags: 0x0
// Checksum 0x2123b4ac, Offset: 0x578
// Size: 0x33c
function play_vehicle_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_bundle = struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
    str_pos = "";
    str_action = "";
    if (strendswith(fieldname, "_enter")) {
        str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
        str_action = "enter";
    } else if (strendswith(fieldname, "_exit")) {
        str_pos = getsubstr(fieldname, 0, fieldname.size - 5);
        str_action = "exit";
    } else if (strendswith(fieldname, "_close")) {
        str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
        str_action = "close";
    } else if (strendswith(fieldname, "_death")) {
        str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
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
            case #"close":
                str_vh_anim = s_rider.vehiclecloseanim;
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
// Params 1, eflags: 0x0
// Checksum 0x3990864e, Offset: 0x8c0
// Size: 0x34
function set_vehicleriders_bundle(str_bundlename) {
    self.vehicleriders = struct::get_script_bundle("vehicleriders", str_bundlename);
}

