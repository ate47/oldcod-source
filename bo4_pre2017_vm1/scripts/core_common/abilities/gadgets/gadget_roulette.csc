#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_a7d38b50;

// Namespace namespace_a7d38b50/namespace_a7d38b50
// Params 0, eflags: 0x2
// Checksum 0x7571b803, Offset: 0x1a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_roulette", &__init__, undefined, undefined);
}

// Namespace namespace_a7d38b50/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0xff40e952, Offset: 0x1e8
// Size: 0x6c
function __init__() {
    clientfield::register("toplayer", "roulette_state", 11000, 2, "int", &function_abc7905, 0, 0);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace namespace_a7d38b50/namespace_a7d38b50
// Params 7, eflags: 0x0
// Checksum 0x8aaea5d5, Offset: 0x260
// Size: 0x54
function function_abc7905(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_80a6323d(localclientnum, newval);
}

// Namespace namespace_a7d38b50/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0x33c35c29, Offset: 0x2c0
// Size: 0x8c
function function_80a6323d(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        var_2bab83be = getuimodel(controllermodel, "playerAbilities.playerGadget3.rouletteStatus");
        if (isdefined(var_2bab83be)) {
            setuimodelvalue(var_2bab83be, newval);
        }
    }
}

// Namespace namespace_a7d38b50/namespace_a7d38b50
// Params 1, eflags: 0x0
// Checksum 0x65e4873e, Offset: 0x358
// Size: 0x74
function on_localplayer_spawned(localclientnum) {
    var_4c8a0a2b = 0;
    if (getserverhighestclientfieldversion() >= 11000) {
        var_4c8a0a2b = self clientfield::get_to_player("roulette_state");
    }
    function_80a6323d(localclientnum, var_4c8a0a2b);
}

