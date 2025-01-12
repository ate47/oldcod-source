#using scripts/core_common/abilities/ability_gadgets;
#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/array_shared;
#using scripts/core_common/burnplayer;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace roulette;

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x2
// Checksum 0xa5c6345c, Offset: 0x468
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_roulette", &__init__, undefined, undefined);
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0xbf3c76f1, Offset: 0x4a8
// Size: 0x328
function __init__() {
    clientfield::register("toplayer", "roulette_state", 11000, 2, "int");
    ability_player::register_gadget_activation_callbacks(43, &gadget_roulette_on_activate, &gadget_roulette_on_deactivate);
    ability_player::register_gadget_possession_callbacks(43, &gadget_roulette_on_give, &gadget_roulette_on_take);
    ability_player::register_gadget_flicker_callbacks(43, &gadget_roulette_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(43, &gadget_roulette_is_inuse);
    ability_player::register_gadget_ready_callbacks(43, &gadget_roulette_is_ready);
    ability_player::register_gadget_is_flickering_callbacks(43, &gadget_roulette_is_flickering);
    ability_player::register_gadget_should_notify(43, 0);
    callback::on_connect(&gadget_roulette_on_connect);
    callback::on_spawned(&gadget_roulette_on_player_spawn);
    if (sessionmodeismultiplayergame()) {
        level.gadgetrouletteprobabilities = [];
        level.gadgetrouletteprobabilities[0] = 0;
        level.gadgetrouletteprobabilities[1] = 0;
        level.weaponnone = getweapon("none");
        level.gadget_roulette = getweapon("gadget_roulette");
        registergadgettype("gadget_flashback", 1, 1);
        registergadgettype("gadget_combat_efficiency", 1, 1);
        registergadgettype("gadget_heat_wave", 1, 1);
        registergadgettype("gadget_vision_pulse", 1, 1);
        registergadgettype("gadget_speed_burst", 1, 1);
        registergadgettype("gadget_camo", 1, 1);
        registergadgettype("gadget_armor", 1, 1);
        registergadgettype("gadget_resurrect", 1, 1);
        registergadgettype("gadget_clone", 1, 1);
    }
    /#
    #/
}

/#

    // Namespace roulette/gadget_roulette
    // Params 0, eflags: 0x0
    // Checksum 0xb7a698de, Offset: 0x7d8
    // Size: 0x1c
    function updatedvars() {
        while (true) {
            wait 1;
        }
    }

#/

// Namespace roulette/gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x1d947320, Offset: 0x800
// Size: 0x22
function gadget_roulette_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace roulette/gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x7adeaa0, Offset: 0x830
// Size: 0x22
function gadget_roulette_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0x5233f3b2, Offset: 0x860
// Size: 0x34
function gadget_roulette_on_flicker(slot, weapon) {
    self thread gadget_roulette_flicker(slot, weapon);
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0xca6a535b, Offset: 0x8a0
// Size: 0x54
function gadget_roulette_on_give(slot, weapon) {
    self clientfield::set_to_player("roulette_state", 0);
    if (sessionmodeismultiplayergame()) {
        self.isroulette = 1;
    }
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0xa622b834, Offset: 0x900
// Size: 0x38
function gadget_roulette_on_take(slot, weapon) {
    /#
        if (level.devgui_giving_abilities === 1) {
            self.isroulette = 0;
        }
    #/
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0xa1d05e, Offset: 0x940
// Size: 0x14
function gadget_roulette_on_connect() {
    roulette_init_allow_spin();
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0x1bbf878d, Offset: 0x960
// Size: 0x46
function roulette_init_allow_spin() {
    if (self.isroulette === 1) {
        if (!isdefined(self.pers[#"hash_9f129a92"])) {
            self.pers[#"hash_9f129a92"] = 1;
        }
    }
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0xa6f9ae30, Offset: 0x9b0
// Size: 0x14
function gadget_roulette_on_player_spawn() {
    roulette_init_allow_spin();
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9d0
// Size: 0x4
function watch_entity_shutdown() {
    
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0xe39ff1eb, Offset: 0x9e0
// Size: 0x2c
function gadget_roulette_on_activate(slot, weapon) {
    gadget_roulette_give_earned_specialist(weapon, 1);
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0xf3f5404, Offset: 0xa18
// Size: 0x4c
function gadget_roulette_is_ready(slot, weapon) {
    if (self gadgetisactive(slot)) {
        return;
    }
    gadget_roulette_give_earned_specialist(weapon, 0);
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0xcc8cee32, Offset: 0xa70
// Size: 0x8c
function gadget_roulette_give_earned_specialist(weapon, playsound) {
    self giverandomweapon(weapon, 1);
    if (playsound) {
        self playsoundtoplayer("mpl_bm_specialist_roulette", self);
    }
    self thread watchgadgetactivated(weapon);
    self thread watchrespin(weapon);
}

// Namespace roulette/gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x67ba0a46, Offset: 0xb08
// Size: 0x5c
function disable_hero_gadget_activation(duration) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"roulette_respin_activate");
    self disableoffhandspecial();
    wait duration;
    self enableoffhandspecial();
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0xc564036a, Offset: 0xb70
// Size: 0x54
function watchRespinGadgetActivated() {
    self endon(#"watchRespinGadgetActivated");
    self endon(#"death");
    self endon(#"disconnect");
    self waittill("hero_gadget_activated");
    self clientfield::set_to_player("roulette_state", 0);
}

// Namespace roulette/gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x6d63a5b7, Offset: 0xbd0
// Size: 0x1be
function watchrespin(weapon) {
    self endon(#"hero_gadget_activated");
    self notify(#"watchrespin");
    self endon(#"watchrespin");
    if (!isdefined(self.pers[#"hash_9f129a92"]) || self.pers[#"hash_9f129a92"] == 0) {
        return;
    }
    self thread watchRespinGadgetActivated();
    self clientfield::set_to_player("roulette_state", 1);
    wait getdvarfloat("scr_roulette_pre_respin_wait_time", 1.3);
    while (true) {
        if (!isdefined(self)) {
            break;
        }
        if (self dpad_left_pressed()) {
            self.pers[#"hash_65987563"] = undefined;
            self giverandomweapon(weapon, 0);
            self.pers[#"hash_9f129a92"] = 0;
            self notify(#"watchRespinGadgetActivated");
            self notify(#"roulette_respin_activate");
            self clientfield::set_to_player("roulette_state", 2);
            self playsoundtoplayer("mpl_bm_specialist_roulette", self);
            self thread reset_roulette_state_to_default();
            break;
        }
        waitframe(1);
    }
    if (isdefined(self)) {
        self notify(#"watchRespinGadgetActivated");
    }
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0x5949c382, Offset: 0xd98
// Size: 0x34
function failsafe_reenable_offhand_special() {
    self endon(#"end_failsafe_reenable_offhand_special");
    wait 3;
    if (isdefined(self)) {
        self enableoffhandspecial();
    }
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0xbcb22e88, Offset: 0xdd8
// Size: 0x44
function reset_roulette_state_to_default() {
    self endon(#"death");
    self endon(#"disconnect");
    wait 0.5;
    self clientfield::set_to_player("roulette_state", 0);
}

// Namespace roulette/gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x49ab9798, Offset: 0xe28
// Size: 0x9c
function watchgadgetactivated(weapon) {
    self endon(#"death");
    self notify(#"watchgadgetactivated");
    self endon(#"watchgadgetactivated");
    self waittill("hero_gadget_activated");
    self.pers[#"hash_9f129a92"] = 1;
    if (isdefined(weapon) || weapon.name != "gadget_roulette") {
        self clientfield::set_to_player("roulette_state", 0);
    }
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0x1bab4cde, Offset: 0xed0
// Size: 0x24e
function giverandomweapon(weapon, isprimaryroll) {
    for (i = 0; i < 4; i++) {
        if (isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    randomweapon = weapon;
    if (isdefined(self.pers[#"hash_65987563"])) {
        randomweapon = self.pers[#"hash_65987563"];
    } else if (isdefined(self.pers[#"hash_cbcfa831"]) || isdefined(self.pers[#"hash_cbcfa832"])) {
        for (randomweapon = getrandomgadget(isprimaryroll); isdefined(self.pers[#"hash_cbcfa832"]) && (randomweapon == self.pers[#"hash_cbcfa831"] || randomweapon == self.pers[#"hash_cbcfa832"]); randomweapon = getrandomgadget(isprimaryroll)) {
        }
    } else {
        randomweapon = getrandomgadget(isprimaryroll);
    }
    if (isdefined(level.playgadgetready) && !isprimaryroll) {
        self thread [[ level.playgadgetready ]](randomweapon, !isprimaryroll);
    }
    self thread gadget_roulette_on_deactivate_helper(weapon);
    self giveweapon(randomweapon);
    self.pers[#"hash_65987563"] = randomweapon;
    self.pers[#"hash_cbcfa832"] = self.pers[#"hash_cbcfa831"];
    self.pers[#"hash_cbcfa831"] = randomweapon;
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0x784f6867, Offset: 0x1128
// Size: 0x2c
function gadget_roulette_on_deactivate(slot, weapon) {
    thread gadget_roulette_on_deactivate_helper(weapon);
}

// Namespace roulette/gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x7e8e539d, Offset: 0x1160
// Size: 0x144
function gadget_roulette_on_deactivate_helper(weapon) {
    self notify(#"gadget_roulette_on_deactivate_helper");
    self endon(#"gadget_roulette_on_deactivate_helper");
    waitresult = self waittill("heroAbility_off");
    weapon_off = waitresult.weapon;
    if (isdefined(weapon_off) && weapon_off.name == "gadget_speed_burst") {
        waitresult = self waittill("heroAbility_off");
        weapon_off = waitresult.weapon;
    }
    for (i = 0; i < 4; i++) {
        if (isdefined(self) && isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    if (isdefined(self)) {
        self giveweapon(level.gadget_roulette);
        self.pers[#"hash_65987563"] = undefined;
    }
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0x83d16b9f, Offset: 0x12b0
// Size: 0x14
function gadget_roulette_flicker(slot, weapon) {
    
}

// Namespace roulette/gadget_roulette
// Params 2, eflags: 0x0
// Checksum 0x77b7b591, Offset: 0x12d0
// Size: 0x9c
function set_gadget_status(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Roulette: " + status + timestr);
    }
}

// Namespace roulette/gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0x38d50f1f, Offset: 0x1378
// Size: 0x1a
function dpad_left_pressed() {
    return self actionslotthreebuttonpressed();
}

// Namespace roulette/gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x4585123b, Offset: 0x13a0
// Size: 0x172
function getrandomgadget(isprimaryroll) {
    if (isprimaryroll) {
        category = 0;
        totalcategory = 0;
    } else {
        category = 1;
        totalcategory = 1;
    }
    randomgadgetnumber = randomintrange(1, level.gadgetrouletteprobabilities[totalcategory] + 1);
    gadgetnames = getarraykeys(level.gadgetrouletteprobabilities);
    selectedgadget = "";
    foreach (gadget in gadgetnames) {
        randomgadgetnumber -= level.gadgetrouletteprobabilities[gadget][category];
        if (randomgadgetnumber <= 0) {
            selectedgadget = gadget;
            break;
        }
    }
    return selectedgadget;
}

// Namespace roulette/gadget_roulette
// Params 3, eflags: 0x0
// Checksum 0xdd7c1197, Offset: 0x1520
// Size: 0x146
function registergadgettype(gadgetnamestring, primaryweight, secondaryweight) {
    gadgetweapon = getweapon(gadgetnamestring);
    assert(isdefined(gadgetweapon));
    if (gadgetweapon == level.weaponnone) {
        assertmsg(gadgetnamestring + "<dev string:x28>");
    }
    if (!isdefined(level.gadgetrouletteprobabilities[gadgetweapon])) {
        level.gadgetrouletteprobabilities[gadgetweapon] = [];
    }
    level.gadgetrouletteprobabilities[gadgetweapon][0] = primaryweight;
    level.gadgetrouletteprobabilities[gadgetweapon][1] = secondaryweight;
    level.gadgetrouletteprobabilities[0] = level.gadgetrouletteprobabilities[0] + primaryweight;
    level.gadgetrouletteprobabilities[1] = level.gadgetrouletteprobabilities[1] + secondaryweight;
}

