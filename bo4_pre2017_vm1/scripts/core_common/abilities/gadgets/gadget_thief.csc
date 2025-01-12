#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_eb1a1028;

// Namespace namespace_eb1a1028/namespace_eb1a1028
// Params 0, eflags: 0x2
// Checksum 0x36cb6106, Offset: 0x2e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_thief", &__init__, undefined, undefined);
}

// Namespace namespace_eb1a1028/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0x7f21aeb1, Offset: 0x320
// Size: 0x1ac
function __init__() {
    clientfield::register("scriptmover", "gadget_thief_fx", 11000, 1, "int", &function_9f84f28b, 0, 0);
    clientfield::register("toplayer", "thief_state", 11000, 2, "int", &function_5215beb4, 0, 0);
    clientfield::register("toplayer", "thief_weapon_option", 11000, 4, "int", &function_11b5ab11, 0, 0);
    clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashStart", 11000, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashEnd", 11000, 3, "int", undefined, 0, 0);
    level._effect["fx_hero_blackjack_beam_source"] = "weapon/fx_hero_blackjack_beam_source";
    level._effect["fx_hero_blackjack_beam_target"] = "weapon/fx_hero_blackjack_beam_target";
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace namespace_eb1a1028/namespace_eb1a1028
// Params 7, eflags: 0x0
// Checksum 0xe142df48, Offset: 0x4d8
// Size: 0xbc
function function_9f84f28b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    playfxoncamera(localclientnum, level._effect["fx_hero_blackjack_beam_target"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    playfx(localclientnum, level._effect["fx_hero_blackjack_beam_source"], self.origin);
}

// Namespace namespace_eb1a1028/namespace_eb1a1028
// Params 7, eflags: 0x0
// Checksum 0x9c25521b, Offset: 0x5a0
// Size: 0x54
function function_5215beb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_2f9da783(localclientnum, newval);
}

// Namespace namespace_eb1a1028/namespace_eb1a1028
// Params 7, eflags: 0x0
// Checksum 0x82ed02e, Offset: 0x600
// Size: 0x54
function function_11b5ab11(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_403d3d3e(localclientnum, newval);
}

// Namespace namespace_eb1a1028/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0xe6334d69, Offset: 0x660
// Size: 0x8c
function function_2f9da783(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        var_3c7ebefc = getuimodel(controllermodel, "playerAbilities.playerGadget3.thiefStatus");
        if (isdefined(var_3c7ebefc)) {
            setuimodelvalue(var_3c7ebefc, newval);
        }
    }
}

// Namespace namespace_eb1a1028/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0xd3da218b, Offset: 0x6f8
// Size: 0x8c
function function_403d3d3e(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        var_3c7ebefc = getuimodel(controllermodel, "playerAbilities.playerGadget3.thiefWeaponStatus");
        if (isdefined(var_3c7ebefc)) {
            setuimodelvalue(var_3c7ebefc, newval);
        }
    }
}

// Namespace namespace_eb1a1028/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0x9e55568e, Offset: 0x790
// Size: 0xbc
function on_localplayer_spawned(localclientnum) {
    var_3640ea11 = 0;
    var_f6707842 = 0;
    if (getserverhighestclientfieldversion() >= 11000) {
        var_3640ea11 = self clientfield::get_to_player("thief_state");
        var_f6707842 = self clientfield::get_to_player("thief_weapon_option");
    }
    function_2f9da783(localclientnum, var_3640ea11);
    function_403d3d3e(localclientnum, var_f6707842);
}

