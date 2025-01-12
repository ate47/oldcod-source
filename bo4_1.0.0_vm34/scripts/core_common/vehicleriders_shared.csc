#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;

#namespace vehicle;

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x2
// Checksum 0x33d94f2f, Offset: 0xd8
// Size: 0x14
function autoexec init() {
    function_b53ec93a();
}

// Namespace vehicle/vehicleriders_shared
// Params 0, eflags: 0x4
// Checksum 0xfbb766cd, Offset: 0xf8
// Size: 0x280
function private function_b53ec93a() {
    a_registered_fields = [];
    foreach (bundle in struct::get_script_bundles("vehicleriders")) {
        foreach (object in bundle.objects) {
            if (isdefined(object.vehicleenteranim)) {
                array::add(a_registered_fields, object.position + "_enter", 0);
            }
            if (isdefined(object.vehicleexitanim)) {
                array::add(a_registered_fields, object.position + "_exit", 0);
            }
            if (isdefined(object.vehiclecloseanim)) {
                array::add(a_registered_fields, object.position + "_close", 0);
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
// Params 7, eflags: 0x0
// Checksum 0xf0d0cb94, Offset: 0x380
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
// Checksum 0x629db572, Offset: 0x6c8
// Size: 0x2a
function set_vehicleriders_bundle(str_bundlename) {
    self.vehicleriders = struct::get_script_bundle("vehicleriders", str_bundlename);
}

