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

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x2
// Checksum 0xa5c6345c, Offset: 0x468
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_roulette", &__init__, undefined, undefined);
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0xbf3c76f1, Offset: 0x4a8
// Size: 0x328
function __init__() {
    clientfield::register("toplayer", "roulette_state", 11000, 2, "int");
    ability_player::register_gadget_activation_callbacks(43, &function_ca371720, &function_fc8f7639);
    ability_player::register_gadget_possession_callbacks(43, &function_a55195e4, &function_e13e0d32);
    ability_player::register_gadget_flicker_callbacks(43, &function_26221a8d);
    ability_player::register_gadget_is_inuse_callbacks(43, &function_4cfa6fa0);
    ability_player::register_gadget_ready_callbacks(43, &function_a3b109bf);
    ability_player::register_gadget_is_flickering_callbacks(43, &function_327cbbe);
    ability_player::register_gadget_should_notify(43, 0);
    callback::on_connect(&function_1a90b6ab);
    callback::on_spawned(&function_e25adb10);
    if (sessionmodeismultiplayergame()) {
        level.var_645f7522 = [];
        level.var_645f7522[0] = 0;
        level.var_645f7522[1] = 0;
        level.weaponnone = getweapon("none");
        level.var_a7d38b50 = getweapon("gadget_roulette");
        function_96a406d2("gadget_flashback", 1, 1);
        function_96a406d2("gadget_combat_efficiency", 1, 1);
        function_96a406d2("gadget_heat_wave", 1, 1);
        function_96a406d2("gadget_vision_pulse", 1, 1);
        function_96a406d2("gadget_speed_burst", 1, 1);
        function_96a406d2("gadget_camo", 1, 1);
        function_96a406d2("gadget_armor", 1, 1);
        function_96a406d2("gadget_resurrect", 1, 1);
        function_96a406d2("gadget_clone", 1, 1);
    }
    /#
    #/
}

/#

    // Namespace roulette/namespace_a7d38b50
    // Params 0, eflags: 0x0
    // Checksum 0xb7a698de, Offset: 0x7d8
    // Size: 0x1c
    function updatedvars() {
        while (true) {
            wait 1;
        }
    }

#/

// Namespace roulette/namespace_a7d38b50
// Params 1, eflags: 0x0
// Checksum 0x1d947320, Offset: 0x800
// Size: 0x22
function function_4cfa6fa0(slot) {
    return self gadgetisactive(slot);
}

// Namespace roulette/namespace_a7d38b50
// Params 1, eflags: 0x0
// Checksum 0x7adeaa0, Offset: 0x830
// Size: 0x22
function function_327cbbe(slot) {
    return self gadgetflickering(slot);
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0x5233f3b2, Offset: 0x860
// Size: 0x34
function function_26221a8d(slot, weapon) {
    self thread function_d54205c5(slot, weapon);
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0xca6a535b, Offset: 0x8a0
// Size: 0x54
function function_a55195e4(slot, weapon) {
    self clientfield::set_to_player("roulette_state", 0);
    if (sessionmodeismultiplayergame()) {
        self.isroulette = 1;
    }
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0xa622b834, Offset: 0x900
// Size: 0x38
function function_e13e0d32(slot, weapon) {
    /#
        if (level.devgui_giving_abilities === 1) {
            self.isroulette = 0;
        }
    #/
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0xa1d05e, Offset: 0x940
// Size: 0x14
function function_1a90b6ab() {
    function_7c7f99df();
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0x1bbf878d, Offset: 0x960
// Size: 0x46
function function_7c7f99df() {
    if (self.isroulette === 1) {
        if (!isdefined(self.pers[#"hash_9f129a92"])) {
            self.pers[#"hash_9f129a92"] = 1;
        }
    }
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0xa6f9ae30, Offset: 0x9b0
// Size: 0x14
function function_e25adb10() {
    function_7c7f99df();
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9d0
// Size: 0x4
function function_f0e244e5() {
    
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0xe39ff1eb, Offset: 0x9e0
// Size: 0x2c
function function_ca371720(slot, weapon) {
    function_41f588ae(weapon, 1);
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0xf3f5404, Offset: 0xa18
// Size: 0x4c
function function_a3b109bf(slot, weapon) {
    if (self gadgetisactive(slot)) {
        return;
    }
    function_41f588ae(weapon, 0);
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0xcc8cee32, Offset: 0xa70
// Size: 0x8c
function function_41f588ae(weapon, playsound) {
    self function_381f2fff(weapon, 1);
    if (playsound) {
        self playsoundtoplayer("mpl_bm_specialist_roulette", self);
    }
    self thread function_1eb9e79f(weapon);
    self thread function_e3065835(weapon);
}

// Namespace roulette/namespace_a7d38b50
// Params 1, eflags: 0x0
// Checksum 0x67ba0a46, Offset: 0xb08
// Size: 0x5c
function function_834ca490(duration) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_d1bf2e9");
    self disableoffhandspecial();
    wait duration;
    self enableoffhandspecial();
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0xc564036a, Offset: 0xb70
// Size: 0x54
function function_921cfa96() {
    self endon(#"hash_921cfa96");
    self endon(#"death");
    self endon(#"disconnect");
    self waittill("hero_gadget_activated");
    self clientfield::set_to_player("roulette_state", 0);
}

// Namespace roulette/namespace_a7d38b50
// Params 1, eflags: 0x0
// Checksum 0x6d63a5b7, Offset: 0xbd0
// Size: 0x1be
function function_e3065835(weapon) {
    self endon(#"hero_gadget_activated");
    self notify(#"hash_e3065835");
    self endon(#"hash_e3065835");
    if (!isdefined(self.pers[#"hash_9f129a92"]) || self.pers[#"hash_9f129a92"] == 0) {
        return;
    }
    self thread function_921cfa96();
    self clientfield::set_to_player("roulette_state", 1);
    wait getdvarfloat("scr_roulette_pre_respin_wait_time", 1.3);
    while (true) {
        if (!isdefined(self)) {
            break;
        }
        if (self function_81b15d4d()) {
            self.pers[#"hash_65987563"] = undefined;
            self function_381f2fff(weapon, 0);
            self.pers[#"hash_9f129a92"] = 0;
            self notify(#"hash_921cfa96");
            self notify(#"hash_d1bf2e9");
            self clientfield::set_to_player("roulette_state", 2);
            self playsoundtoplayer("mpl_bm_specialist_roulette", self);
            self thread function_9746c63b();
            break;
        }
        waitframe(1);
    }
    if (isdefined(self)) {
        self notify(#"hash_921cfa96");
    }
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0x5949c382, Offset: 0xd98
// Size: 0x34
function function_12fae26() {
    self endon(#"hash_ab02b20c");
    wait 3;
    if (isdefined(self)) {
        self enableoffhandspecial();
    }
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0xbcb22e88, Offset: 0xdd8
// Size: 0x44
function function_9746c63b() {
    self endon(#"death");
    self endon(#"disconnect");
    wait 0.5;
    self clientfield::set_to_player("roulette_state", 0);
}

// Namespace roulette/namespace_a7d38b50
// Params 1, eflags: 0x0
// Checksum 0x49ab9798, Offset: 0xe28
// Size: 0x9c
function function_1eb9e79f(weapon) {
    self endon(#"death");
    self notify(#"hash_1eb9e79f");
    self endon(#"hash_1eb9e79f");
    self waittill("hero_gadget_activated");
    self.pers[#"hash_9f129a92"] = 1;
    if (isdefined(weapon) || weapon.name != "gadget_roulette") {
        self clientfield::set_to_player("roulette_state", 0);
    }
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0x1bab4cde, Offset: 0xed0
// Size: 0x24e
function function_381f2fff(weapon, var_beed3e44) {
    for (i = 0; i < 4; i++) {
        if (isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    randomweapon = weapon;
    if (isdefined(self.pers[#"hash_65987563"])) {
        randomweapon = self.pers[#"hash_65987563"];
    } else if (isdefined(self.pers[#"hash_cbcfa831"]) || isdefined(self.pers[#"hash_cbcfa832"])) {
        for (randomweapon = function_917fa966(var_beed3e44); isdefined(self.pers[#"hash_cbcfa832"]) && (randomweapon == self.pers[#"hash_cbcfa831"] || randomweapon == self.pers[#"hash_cbcfa832"]); randomweapon = function_917fa966(var_beed3e44)) {
        }
    } else {
        randomweapon = function_917fa966(var_beed3e44);
    }
    if (isdefined(level.playgadgetready) && !var_beed3e44) {
        self thread [[ level.playgadgetready ]](randomweapon, !var_beed3e44);
    }
    self thread function_27bf03c4(weapon);
    self giveweapon(randomweapon);
    self.pers[#"hash_65987563"] = randomweapon;
    self.pers[#"hash_cbcfa832"] = self.pers[#"hash_cbcfa831"];
    self.pers[#"hash_cbcfa831"] = randomweapon;
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0x784f6867, Offset: 0x1128
// Size: 0x2c
function function_fc8f7639(slot, weapon) {
    thread function_27bf03c4(weapon);
}

// Namespace roulette/namespace_a7d38b50
// Params 1, eflags: 0x0
// Checksum 0x7e8e539d, Offset: 0x1160
// Size: 0x144
function function_27bf03c4(weapon) {
    self notify(#"hash_27bf03c4");
    self endon(#"hash_27bf03c4");
    waitresult = self waittill("heroAbility_off");
    var_9a1435cf = waitresult.weapon;
    if (isdefined(var_9a1435cf) && var_9a1435cf.name == "gadget_speed_burst") {
        waitresult = self waittill("heroAbility_off");
        var_9a1435cf = waitresult.weapon;
    }
    for (i = 0; i < 4; i++) {
        if (isdefined(self) && isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    if (isdefined(self)) {
        self giveweapon(level.var_a7d38b50);
        self.pers[#"hash_65987563"] = undefined;
    }
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0x83d16b9f, Offset: 0x12b0
// Size: 0x14
function function_d54205c5(slot, weapon) {
    
}

// Namespace roulette/namespace_a7d38b50
// Params 2, eflags: 0x0
// Checksum 0x77b7b591, Offset: 0x12d0
// Size: 0x9c
function function_39b1b87b(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Roulette: " + status + timestr);
    }
}

// Namespace roulette/namespace_a7d38b50
// Params 0, eflags: 0x0
// Checksum 0x38d50f1f, Offset: 0x1378
// Size: 0x1a
function function_81b15d4d() {
    return self actionslotthreebuttonpressed();
}

// Namespace roulette/namespace_a7d38b50
// Params 1, eflags: 0x0
// Checksum 0x4585123b, Offset: 0x13a0
// Size: 0x172
function function_917fa966(var_beed3e44) {
    if (var_beed3e44) {
        category = 0;
        var_ef0c7c51 = 0;
    } else {
        category = 1;
        var_ef0c7c51 = 1;
    }
    var_e11107cf = randomintrange(1, level.var_645f7522[var_ef0c7c51] + 1);
    var_57988017 = getarraykeys(level.var_645f7522);
    var_19a3ca3e = "";
    foreach (gadget in var_57988017) {
        var_e11107cf -= level.var_645f7522[gadget][category];
        if (var_e11107cf <= 0) {
            var_19a3ca3e = gadget;
            break;
        }
    }
    return var_19a3ca3e;
}

// Namespace roulette/namespace_a7d38b50
// Params 3, eflags: 0x0
// Checksum 0xdd7c1197, Offset: 0x1520
// Size: 0x146
function function_96a406d2(var_edf36e37, var_86166a51, var_c730de85) {
    gadgetweapon = getweapon(var_edf36e37);
    /#
        assert(isdefined(gadgetweapon));
    #/
    if (gadgetweapon == level.weaponnone) {
        /#
            assertmsg(var_edf36e37 + "<dev string:x28>");
        #/
    }
    if (!isdefined(level.var_645f7522[gadgetweapon])) {
        level.var_645f7522[gadgetweapon] = [];
    }
    level.var_645f7522[gadgetweapon][0] = var_86166a51;
    level.var_645f7522[gadgetweapon][1] = var_c730de85;
    level.var_645f7522[0] = level.var_645f7522[0] + var_86166a51;
    level.var_645f7522[1] = level.var_645f7522[1] + var_c730de85;
}

