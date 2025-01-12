#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_thief;

// Namespace gadget_thief/gadget_thief
// Params 0, eflags: 0x2
// Checksum 0x36cb6106, Offset: 0x2e0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_thief", &__init__, undefined, undefined);
}

// Namespace gadget_thief/gadget_thief
// Params 0, eflags: 0x0
// Checksum 0x7f21aeb1, Offset: 0x320
// Size: 0x1ac
function __init__() {
    clientfield::register("scriptmover", "gadget_thief_fx", 11000, 1, "int", &thief_clientfield_cb, 0, 0);
    clientfield::register("toplayer", "thief_state", 11000, 2, "int", &thief_ui_model_clientfield_cb, 0, 0);
    clientfield::register("toplayer", "thief_weapon_option", 11000, 4, "int", &thief_weapon_option_ui_model_clientfield_cb, 0, 0);
    clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashStart", 11000, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashEnd", 11000, 3, "int", undefined, 0, 0);
    level._effect["fx_hero_blackjack_beam_source"] = "weapon/fx_hero_blackjack_beam_source";
    level._effect["fx_hero_blackjack_beam_target"] = "weapon/fx_hero_blackjack_beam_target";
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace gadget_thief/gadget_thief
// Params 7, eflags: 0x0
// Checksum 0xe142df48, Offset: 0x4d8
// Size: 0xbc
function thief_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    playfxoncamera(localclientnum, level._effect["fx_hero_blackjack_beam_target"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    playfx(localclientnum, level._effect["fx_hero_blackjack_beam_source"], self.origin);
}

// Namespace gadget_thief/gadget_thief
// Params 7, eflags: 0x0
// Checksum 0x9c25521b, Offset: 0x5a0
// Size: 0x54
function thief_ui_model_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    update_thief(localclientnum, newval);
}

// Namespace gadget_thief/gadget_thief
// Params 7, eflags: 0x0
// Checksum 0x82ed02e, Offset: 0x600
// Size: 0x54
function thief_weapon_option_ui_model_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    update_thief_weapon(localclientnum, newval);
}

// Namespace gadget_thief/gadget_thief
// Params 2, eflags: 0x0
// Checksum 0xe6334d69, Offset: 0x660
// Size: 0x8c
function update_thief(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        thiefstatusmodel = getuimodel(controllermodel, "playerAbilities.playerGadget3.thiefStatus");
        if (isdefined(thiefstatusmodel)) {
            setuimodelvalue(thiefstatusmodel, newval);
        }
    }
}

// Namespace gadget_thief/gadget_thief
// Params 2, eflags: 0x0
// Checksum 0xd3da218b, Offset: 0x6f8
// Size: 0x8c
function update_thief_weapon(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        thiefstatusmodel = getuimodel(controllermodel, "playerAbilities.playerGadget3.thiefWeaponStatus");
        if (isdefined(thiefstatusmodel)) {
            setuimodelvalue(thiefstatusmodel, newval);
        }
    }
}

// Namespace gadget_thief/gadget_thief
// Params 1, eflags: 0x0
// Checksum 0x9e55568e, Offset: 0x790
// Size: 0xbc
function on_localplayer_spawned(localclientnum) {
    thief_state = 0;
    thief_weapon_option = 0;
    if (getserverhighestclientfieldversion() >= 11000) {
        thief_state = self clientfield::get_to_player("thief_state");
        thief_weapon_option = self clientfield::get_to_player("thief_weapon_option");
    }
    update_thief(localclientnum, thief_state);
    update_thief_weapon(localclientnum, thief_weapon_option);
}

