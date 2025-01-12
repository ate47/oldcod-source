#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ac130;

// Namespace ac130/ac130
// Params 0, eflags: 0x2
// Checksum 0xf58b2aab, Offset: 0x190
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"ac130", &__init__, undefined, #"killstreaks");
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x62737d15, Offset: 0x1e0
// Size: 0x124
function __init__() {
    callback::on_localclient_connect(&on_localclient_connect);
    clientfield::register("clientuimodel", "vehicle.selectedWeapon", 1, 2, "int", &function_7378d31b, 0, 0);
    clientfield::register("clientuimodel", "vehicle.flareCount", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "vehicle.inAC130", 1, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "inAC130", 1, 1, "int", &function_77785fd2, 0, 1);
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xecb6fcd5, Offset: 0x310
// Size: 0xcc
function on_localclient_connect(localclientnum) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "vehicle.ac130.maincannonClipSize"), 2);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "vehicle.ac130.autocannonClipSize"), 4);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "vehicle.ac130.chaingunClipSize"), 20);
}

// Namespace ac130/ac130
// Params 7, eflags: 0x0
// Checksum 0x44bff108, Offset: 0x3e8
// Size: 0x11c
function function_77785fd2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    bundle = struct::get_script_bundle("killstreak", "killstreak_ac130");
    postfxbundle = bundle.("ksVehiclePostEffectBun");
    if (!isdefined(postfxbundle)) {
        return;
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (self postfx::function_7348f3a5(postfxbundle) == 0) {
            self codeplaypostfxbundle(postfxbundle);
        }
        return;
    }
    if (self postfx::function_7348f3a5(postfxbundle)) {
        self codestoppostfxbundle(postfxbundle);
    }
}

// Namespace ac130/ac130
// Params 7, eflags: 0x0
// Checksum 0xa2566a5c, Offset: 0x510
// Size: 0x10a
function function_7378d31b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == 0) {
        return;
    }
    switch (newval) {
    case 1:
        playsound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
        break;
    case 2:
        playsound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
        break;
    case 3:
        playsound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
        break;
    }
}

