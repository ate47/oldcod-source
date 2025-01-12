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
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace thief;

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x2
// Checksum 0xe3ed8f7e, Offset: 0x918
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_thief", &__init__, undefined, undefined);
}

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0x1b39f8eb, Offset: 0x958
// Size: 0x27c
function __init__() {
    clientfield::register("toplayer", "thief_state", 11000, 2, "int");
    clientfield::register("toplayer", "thief_weapon_option", 11000, 4, "int");
    ability_player::register_gadget_activation_callbacks(44, &function_443d988, &function_187ceb81);
    ability_player::register_gadget_possession_callbacks(44, &function_f42ffc8c, &function_f0dd0e3a);
    ability_player::register_gadget_flicker_callbacks(44, &function_4b26d505);
    ability_player::register_gadget_is_inuse_callbacks(44, &function_2bbe8c38);
    ability_player::register_gadget_ready_callbacks(44, &function_93bbdda7);
    ability_player::register_gadget_is_flickering_callbacks(44, &function_8909e8f6);
    clientfield::register("scriptmover", "gadget_thief_fx", 11000, 1, "int");
    clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashStart", 11000, 3, "int");
    clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashEnd", 11000, 3, "int");
    callback::on_connect(&function_81f89e3);
    callback::on_spawned(&function_5a521c68);
    function_f6dcf468();
    level.var_4e101858 = 0;
    level.gadgetthiefshutdownfullcharge = getdvarint("gadgetThiefShutdownFullCharge", 1);
    /#
        level thread updatedvars();
    #/
}

/#

    // Namespace thief/namespace_eb1a1028
    // Params 0, eflags: 0x0
    // Checksum 0xcedf09ce, Offset: 0xbe0
    // Size: 0x44
    function updatedvars() {
        while (true) {
            level.var_4e101858 = getdvarint("<dev string:x28>", 0);
            wait 1;
        }
    }

#/

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0x812fce6f, Offset: 0xc30
// Size: 0x1de
function function_f6dcf468() {
    weapons = enumerateweapons("weapon");
    level.var_22a1096a = [];
    for (i = 0; i < weapons.size; i++) {
        if (weapons[i].isgadget && weapons[i].isheroweapon == 1) {
            if (weapons[i].name != "gadget_thief" && weapons[i].name != "gadget_roulette" && weapons[i].name != "hero_bowlauncher2" && weapons[i].name != "hero_bowlauncher3" && weapons[i].name != "hero_bowlauncher4" && weapons[i].name != "hero_pineapple_grenade" && weapons[i].name != "gadget_speed_burst" && weapons[i].name != "hero_minigun_body3" && weapons[i].name != "hero_lightninggun_arc") {
                arrayinsert(level.var_22a1096a, weapons[i], 0);
            }
        }
    }
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0x9bd9fc2, Offset: 0xe18
// Size: 0x22
function function_2bbe8c38(slot) {
    return self gadgetisactive(slot);
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0x8b588f54, Offset: 0xe48
// Size: 0x22
function function_8909e8f6(slot) {
    return self gadgetflickering(slot);
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0xea68fcc4, Offset: 0xe78
// Size: 0x34
function function_4b26d505(slot, weapon) {
    self thread function_dc57cabd(slot, weapon);
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0xe02d7bdc, Offset: 0xeb8
// Size: 0x1b4
function function_f42ffc8c(slot, weapon) {
    self.var_3646319f = &function_3646319f;
    self.var_77983c03 = slot;
    self thread function_aac33c1d(slot, weapon);
    if (sessionmodeismultiplayergame()) {
        self.isthief = 1;
    }
    self clientfield::set_to_player("thief_state", 0);
    currentpower = isdefined(self gadgetpowerget(slot)) ? self gadgetpowerget(slot) : 0;
    var_d51f2b51 = 0;
    if (isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers[#"hash_c35f137f"]) && isdefined(self.pers["held_gadgets_power"][self.pers[#"hash_c35f137f"]])) {
        var_d51f2b51 = self.pers["held_gadgets_power"][self.pers[#"hash_c35f137f"]];
    }
    if (currentpower >= 100 || var_d51f2b51 >= 100) {
        self.var_9d4429ed = 1;
        self.var_57656623 = slot;
    }
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0x5daf935a, Offset: 0x1078
// Size: 0x5c
function function_3646319f(victim, weapon) {
    /#
        assert(isdefined(self.var_77983c03));
    #/
    self thread function_dd8bf2ad(self.var_77983c03, weapon, victim);
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0x280054ac, Offset: 0x10e0
// Size: 0x38
function function_f0dd0e3a(slot, weapon) {
    /#
        if (level.devgui_giving_abilities === 1) {
            self.isthief = 0;
        }
    #/
}

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0xf791056e, Offset: 0x1120
// Size: 0x6c
function function_81f89e3() {
    self.pers[#"hash_c5c4a13f"] = 1;
    /#
        level.var_bc61f38b = getdvarint("<dev string:x41>", 0);
        if (level.var_bc61f38b) {
            self thread function_8da00c80();
        }
    #/
}

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0xe1e05fe5, Offset: 0x1198
// Size: 0x96
function function_5a521c68() {
    if (self.isthief === 1) {
        self thread function_70a51d75();
        if (self.var_9d4429ed === 1) {
            self function_6ccc7536(self.var_57656623, 1);
            self gadgetpowerset(self.var_57656623, 100);
            self.var_9d4429ed = undefined;
            self.var_57656623 = undefined;
        }
    }
}

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1238
// Size: 0x4
function function_f0e244e5() {
    
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0x4a1d40ee, Offset: 0x1248
// Size: 0x14
function function_443d988(slot, weapon) {
    
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0x889f1032, Offset: 0x1268
// Size: 0x14
function function_93bbdda7(slot, weapon) {
    
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0xfd14369d, Offset: 0x1288
// Size: 0x8c
function function_aac33c1d(slot, weapon) {
    waittillframeend();
    if (isdefined(self.pers[#"hash_c35f137f"]) && weapon.name != "gadget_thief") {
        self thread function_dbe98d36(slot, weapon, self.pers[#"hash_476984c8"]);
    }
    self thread function_25dc0dbf(slot);
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0x946df1df, Offset: 0x1320
// Size: 0x172
function function_1af936c7(gadget) {
    if (!gadget.isheavyweapon) {
        var_ab30b46 = "";
        switch (gadget.name) {
        case #"hash_9334d6bb":
            var_ab30b46 = "hero_lightninggun";
            break;
        case #"gadget_combat_efficiency":
            var_ab30b46 = "hero_annihilator";
            break;
        case #"gadget_heat_wave":
            var_ab30b46 = "hero_flamethrower";
            break;
        case #"gadget_vision_pulse":
            var_ab30b46 = "hero_bowlauncher";
            break;
        case #"gadget_speed_burst":
            var_ab30b46 = "hero_gravityspikes";
            break;
        case #"gadget_camo":
            var_ab30b46 = "hero_armblade";
            break;
        case #"gadget_armor":
            var_ab30b46 = "hero_pineapplegun";
            break;
        case #"gadget_resurrect":
            var_ab30b46 = "hero_chemicalgelgun";
            break;
        case #"gadget_clone":
            var_ab30b46 = "hero_minigun";
            break;
        }
        if (var_ab30b46 != "") {
            heavyweapon = getweapon(var_ab30b46);
        }
    } else {
        heavyweapon = gadget;
    }
    return heavyweapon;
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0xd569278e, Offset: 0x14a0
// Size: 0x6c
function function_1208ecd9(delay) {
    self notify(#"hash_2bd7947a");
    self endon(#"hash_2bd7947a");
    wait delay;
    self clientfield::set_player_uimodel("playerAbilities.playerGadget3.flashStart", 0);
    self clientfield::set_player_uimodel("playerAbilities.playerGadget3.flashEnd", 0);
}

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0x68931587, Offset: 0x1518
// Size: 0x98
function function_60e43dc1() {
    gadgetthiefkillpowergain = getdvarfloat("gadgetThiefKillPowerGain", 12.5);
    var_fc61bff8 = isdefined(getgametypesetting("scoreThiefPowerGainFactor")) ? getgametypesetting("scoreThiefPowerGainFactor") : 1;
    gadgetthiefkillpowergain *= var_fc61bff8;
    return gadgetthiefkillpowergain;
}

// Namespace thief/namespace_eb1a1028
// Params 3, eflags: 0x0
// Checksum 0xef7b4281, Offset: 0x15b8
// Size: 0x384
function function_dd8bf2ad(slot, weapon, victim) {
    if (isdefined(weapon) && !killstreaks::is_killstreak_weapon(weapon) && !weapon.isheroweapon && isalive(self)) {
        if (self gadgetisactive(slot) == 0) {
            power = self gadgetpowerget(slot);
            gadgetthiefkillpowergain = function_60e43dc1();
            var_b5caca08 = function_60e43dc1();
            victimgadgetpower = isdefined(victim gadgetpowerget(0)) ? victim gadgetpowerget(0) : 0;
            var_aafa8a08 = 0;
            if (var_aafa8a08 || power < 100) {
                if (victimgadgetpower == 100) {
                    self playsoundtoplayer("mpl_bm_specialist_bar_thief", self);
                } else {
                    self playsoundtoplayer("mpl_bm_specialist_bar_thief", self);
                }
            }
            currentpower = power + gadgetthiefkillpowergain;
            if (power < 80 && currentpower >= 80 && currentpower < 100) {
                if (self hasperk("specialty_overcharge")) {
                    currentpower = 100;
                }
            }
            if (currentpower >= 100) {
                var_34a4ec9c = power >= 100;
                self function_fb9d3bc7(victim, slot, var_34a4ec9c);
            }
            self clientfield::set_player_uimodel("playerAbilities.playerGadget3.flashStart", int(power / var_b5caca08));
            self clientfield::set_player_uimodel("playerAbilities.playerGadget3.flashEnd", int(currentpower / var_b5caca08));
            self thread function_1208ecd9(3);
            self gadgetpowerset(slot, currentpower);
            return;
        }
        if (isplayer(victim) && self.pers[#"hash_476984c8"] === victim.entnum && weapon.isheroweapon) {
            scoreevents::processscoreevent("kill_enemy_with_their_hero_weapon", self);
        }
    }
}

// Namespace thief/namespace_eb1a1028
// Params 4, eflags: 0x0
// Checksum 0xed4126fd, Offset: 0x1948
// Size: 0x2ec
function function_fb9d3bc7(victim, slot, var_34a4ec9c, var_b8e167f8) {
    if (!isdefined(victim)) {
        return;
    }
    heroweapon = undefined;
    var_d116c003 = victim.isthief === 1 || victim.isroulette === 1;
    if (var_d116c003) {
        if (isdefined(var_b8e167f8)) {
            heroweapon = var_b8e167f8;
        } else if (isdefined(victim.pers[#"hash_c35f137f"]) && victim.pers[#"hash_c35f137f"].isheroweapon === 1) {
            heroweapon = victim.pers[#"hash_c35f137f"];
        }
    }
    if (!isdefined(heroweapon)) {
        var_6dc341dd = victim._gadgets_player[0];
        heroweapon = function_1af936c7(var_6dc341dd);
    }
    if (var_34a4ec9c) {
        if ((!isdefined(self.pers[#"hash_5c5e3658"]) || isdefined(heroweapon) && heroweapon != self.pers[#"hash_c35f137f"] && heroweapon != self.pers[#"hash_5c5e3658"]) && self.pers[#"hash_c5c4a13f"]) {
            self thread function_57d5323b(slot, victim, heroweapon);
        }
        return;
    }
    self clientfield::set_to_player("thief_state", 1);
    self clientfield::set_to_player("thief_weapon_option", 0);
    self thread function_dbe98d36(slot, heroweapon, victim.entnum);
    self.pers[#"hash_5c5e3658"] = undefined;
    self.var_57f13765 = gettime();
    if (isdefined(self.pers[#"hash_c35f137f"]) && self.pers[#"hash_c35f137f"].isheroweapon === 1) {
        self function_ed78a948(self.pers[#"hash_c35f137f"]);
    }
    self playsoundtoplayer("mpl_bm_specialist_bar_filled", self);
}

// Namespace thief/namespace_eb1a1028
// Params 3, eflags: 0x0
// Checksum 0xf10f4340, Offset: 0x1c40
// Size: 0x1cc
function function_57d5323b(slot, victim, heroweapon) {
    self notify(#"hash_608c4799");
    self endon(#"hash_608c4799");
    var_e25f8363 = isdefined(self.var_8e3989aa) ? self.var_8e3989aa : 0;
    self.var_8e3989aa = gettime();
    var_8d97c22 = var_e25f8363 == self.var_8e3989aa;
    self.pers[#"hash_5c5e3658"] = heroweapon;
    var_1c7e5537 = function_4c1c1b75(victim, heroweapon);
    self function_ed78a948(heroweapon);
    self notify(#"hash_1b499703");
    if (self.var_8e3989aa - var_e25f8363 > 99) {
        self playsoundtoplayer("mpl_bm_specialist_coin_place", self);
    }
    elapsed_time = (gettime() - (isdefined(self.var_57f13765) ? self.var_57f13765 : 0)) * 0.001;
    if (elapsed_time < 0.75) {
        wait 0.75 - elapsed_time;
    }
    self clientfield::set_to_player("thief_state", 2);
    self thread function_acd87de5(slot, var_1c7e5537, 0);
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0x85900daa, Offset: 0x1e18
// Size: 0xa4
function function_6ccc7536(slot, justspawned) {
    if (isdefined(self.pers[#"hash_c35f137f"])) {
        self thread function_dbe98d36(slot, self.pers[#"hash_c35f137f"], self.pers[#"hash_476984c8"], justspawned);
        if (isdefined(self.pers[#"hash_5c5e3658"])) {
            self thread function_acd87de5(slot, self.pers[#"hash_6de3aefa"], justspawned);
        }
    }
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0xec69c5f7, Offset: 0x1ec8
// Size: 0x5c
function function_834ca490(duration) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_1b499703");
    self disableoffhandspecial();
    wait duration;
    self enableoffhandspecial();
}

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0xb4728256, Offset: 0x1f30
// Size: 0x34
function function_12fae26() {
    self endon(#"hash_ab02b20c");
    wait 3;
    if (isdefined(self)) {
        self enableoffhandspecial();
    }
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0xb7013d20, Offset: 0x1f70
// Size: 0x204
function function_ed78a948(heavyweapon) {
    switch (heavyweapon.name) {
    case #"hero_minigun":
    case #"hash_8deed52f":
        event = "minigun_stolen";
        label = "SCORE_MINIGUN_STOLEN";
        break;
    case #"hero_flamethrower":
        event = "flamethrower_stolen";
        label = "SCORE_FLAMETHROWER_STOLEN";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        event = "lightninggun_stolen";
        label = "SCORE_LIGHTNINGGUN_STOLEN";
        break;
    case #"hero_chemicalgelgun":
    case #"hero_firefly_swarm":
        event = "gelgun_stolen";
        label = "SCORE_GELGUN_STOLEN";
        break;
    case #"hero_pineapple_grenade":
    case #"hero_pineapplegun":
        event = "pineapple_stolen";
        label = "SCORE_PINEAPPLE_STOLEN";
        break;
    case #"hero_armblade":
        event = "armblades_stolen";
        label = "SCORE_ARMBLADES_STOLEN";
        break;
    case #"hero_bowlauncher":
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
        event = "bowlauncher_stolen";
        label = "SCORE_BOWLAUNCHER_STOLEN";
        break;
    case #"hero_gravityspikes":
        event = "gravityspikes_stolen";
        label = "SCORE_GRAVITYSPIKES_STOLEN";
        break;
    case #"hero_annihilator":
        event = "annihilator_stolen";
        label = "SCORE_ANNIHILATOR_STOLEN";
        break;
    default:
        return;
    }
    self luinotifyevent(%score_event, 5, istring(label), 0, 0, 0, 1);
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0xb34664f2, Offset: 0x2180
// Size: 0x240
function function_25dc0dbf(slot) {
    self notify(#"hash_63c8b607");
    self endon(#"hash_63c8b607");
    self.gadgetthiefactive = 1;
    while (true) {
        waitresult = self waittill("hero_shutdown_gadget");
        herogadget = waitresult.gadget;
        victim = waitresult.victim;
        var_c5283ce1 = function_1af936c7(herogadget);
        var_668e7ff = 0;
        if (var_668e7ff) {
            self function_3ba16324(victim.origin);
            var_aac40aca = spawn("script_model", victim.origin);
            var_aac40aca clientfield::set("gadget_thief_fx", 1);
            var_aac40aca thread waitthendelete(5);
        }
        if (isdefined(level.gadgetthiefshutdownfullcharge) && level.gadgetthiefshutdownfullcharge) {
            if (self gadgetisactive(slot) == 0) {
                scoreevents::processscoreevent("thief_shutdown_enemy", self);
                power = self gadgetpowerget(slot);
                self gadgetpowerset(slot, 100);
                var_34a4ec9c = power >= 100;
                self function_fb9d3bc7(victim, slot, var_34a4ec9c, var_c5283ce1);
            }
        }
    }
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0x24e8638e, Offset: 0x23c8
// Size: 0x74
function function_3ba16324(origin) {
    var_aac40aca = spawn("script_model", origin);
    var_aac40aca clientfield::set("gadget_thief_fx", 1);
    var_aac40aca thread waitthendelete(5);
}

/#

    // Namespace thief/namespace_eb1a1028
    // Params 0, eflags: 0x0
    // Checksum 0xdcdd79d4, Offset: 0x2448
    // Size: 0xd0
    function function_8da00c80() {
        while (true) {
            waitresult = self waittill("<dev string:x59>");
            self function_3ba16324(waitresult.victim.origin);
            var_aac40aca = spawn("<dev string:x6d>", waitresult.victim.origin);
            var_aac40aca clientfield::set("<dev string:x7a>", 1);
            var_aac40aca thread waitthendelete(5);
        }
    }

#/

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0xfc90df33, Offset: 0x2520
// Size: 0x24
function waitthendelete(time) {
    wait time;
    self delete();
}

// Namespace thief/namespace_eb1a1028
// Params 4, eflags: 0x0
// Checksum 0x75eff1f1, Offset: 0x2550
// Size: 0x3e4
function function_dbe98d36(slot, weapon, var_74232a9d, justspawned) {
    if (!isdefined(justspawned)) {
        justspawned = 0;
    }
    var_661dd512 = undefined;
    for (i = 0; i < 4; i++) {
        if (isdefined(self._gadgets_player[i])) {
            if (!isdefined(var_661dd512)) {
                var_661dd512 = self._gadgets_player[i];
            }
            self takeweapon(self._gadgets_player[i]);
        }
    }
    if (!isdefined(level.var_22a1096a)) {
        weapons = enumerateweapons("weapon");
        level.var_22a1096a = [];
        for (i = 0; i < weapons.size; i++) {
            if (weapons[i].isgadget && weapons[i] != weapon && weapons[i].isheavyweapon) {
                if (weapons[i].name != "gadget_thief" && weapons[i].name != "gadget_roulette" && weapons[i].name != "hero_bowlauncher2" && weapons[i].name != "hero_bowlauncher3" && weapons[i].name != "hero_bowlauncher4" && weapons[i].name != "hero_pineapple_grenade" && weapons[i].name != "gadget_speed_burst" && weapons[i].name != "hero_lightninggun_arc") {
                    arrayinsert(level.var_22a1096a, weapons[i], 0);
                }
            }
        }
    }
    selectedweapon = weapon;
    /#
        if (getdvarint("<dev string:x8a>", -1) != -1) {
            selectedweapon = level.var_22a1096a[getdvarint("<dev string:x8a>", -1)];
        }
    #/
    self giveweapon(selectedweapon);
    self gadgetcharging(slot, level.var_4e101858);
    self.var_5cc6569a = slot;
    self.pers[#"hash_c35f137f"] = selectedweapon;
    self.pers[#"hash_476984c8"] = var_74232a9d;
    if (!isdefined(var_661dd512) || var_661dd512 != selectedweapon) {
        self notify(#"hash_6693bb23", {#var_62ad6b50:justspawned, #weapon:selectedweapon});
    }
    self thread function_1eb9e79f(slot);
}

// Namespace thief/namespace_eb1a1028
// Params 3, eflags: 0x0
// Checksum 0x90e9631, Offset: 0x2940
// Size: 0x204
function function_acd87de5(slot, var_1c7e5537, justspawned) {
    self endon(#"death");
    self endon(#"hero_gadget_activated");
    self notify(#"hash_64fda59e");
    self endon(#"hash_64fda59e");
    if (self.pers[#"hash_c5c4a13f"] == 0) {
        return;
    }
    self clientfield::set_to_player("thief_weapon_option", var_1c7e5537 + 1);
    self.pers[#"hash_6de3aefa"] = var_1c7e5537;
    if (!justspawned) {
        wait 0.85;
        self enableoffhandspecial();
        self notify(#"hash_ab02b20c");
    }
    while (true) {
        if (self function_81b15d4d()) {
            self clientfield::set_to_player("thief_state", 1);
            self clientfield::set_to_player("thief_weapon_option", 0);
            self.pers[#"hash_c35f137f"] = self.pers[#"hash_5c5e3658"];
            self.pers[#"hash_5c5e3658"] = undefined;
            self.pers[#"hash_c5c4a13f"] = 0;
            self thread function_dbe98d36(slot, self.pers[#"hash_c35f137f"], self.pers[#"hash_476984c8"]);
            if (isdefined(level.playgadgetready)) {
                self thread [[ level.playgadgetready ]](self.pers[#"hash_c35f137f"], 1);
            }
            return;
        }
        waitframe(1);
    }
}

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0xb91d4422, Offset: 0x2b50
// Size: 0x1a
function function_81b15d4d() {
    return self actionslotthreebuttonpressed();
}

// Namespace thief/namespace_eb1a1028
// Params 0, eflags: 0x0
// Checksum 0x25e3b060, Offset: 0x2b78
// Size: 0xf0
function function_70a51d75() {
    self notify(#"hash_fae354ab");
    self endon(#"hash_fae354ab");
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill("thief_heavy_weapon_changed");
        newweapon = waitresult.weapon;
        if (waitresult.var_62ad6b50) {
            if (isdefined(newweapon) && isdefined(newweapon.gadgetreadysoundplayer)) {
                self playsoundtoplayer(newweapon.gadgetreadysoundplayer, self);
            }
            continue;
        }
        self playsoundtoplayer("mpl_bm_specialist_thief", self);
    }
}

// Namespace thief/namespace_eb1a1028
// Params 1, eflags: 0x0
// Checksum 0xe94f05ca, Offset: 0x2c70
// Size: 0x1cc
function function_1eb9e79f(slot) {
    self notify(#"hash_941e28bd");
    self endon(#"hash_941e28bd");
    self waittill("hero_gadget_activated");
    self clientfield::set_to_player("thief_weapon_option", 0);
    self.pers[#"hash_c35f137f"] = undefined;
    self.pers[#"hash_5c5e3658"] = undefined;
    self.pers[#"hash_c5c4a13f"] = 1;
    self waittill("heroAbility_off");
    power = self gadgetpowerget(slot);
    power = int(power / function_60e43dc1()) * function_60e43dc1();
    self gadgetpowerset(slot, power);
    for (i = 0; i < 4; i++) {
        if (isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    self giveweapon(getweapon("gadget_thief"));
    self clientfield::set_to_player("thief_state", 0);
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0x441317a4, Offset: 0x2e48
// Size: 0xd4
function function_187ceb81(slot, weapon) {
    self waittill("heroAbility_off");
    for (i = 0; i < 4; i++) {
        if (isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    self giveweapon(weapon);
    self gadgetcharging(slot, level.var_4e101858);
    self.var_5cc6569a = slot;
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0xea0a90c4, Offset: 0x2f28
// Size: 0x14
function function_dc57cabd(slot, weapon) {
    
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0x88dcd4b4, Offset: 0x2f48
// Size: 0x9c
function function_39b1b87b(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget thief: " + status + timestr);
    }
}

// Namespace thief/namespace_eb1a1028
// Params 2, eflags: 0x0
// Checksum 0x2d3e2ffa, Offset: 0x2ff0
// Size: 0x152
function function_4c1c1b75(victim, heroweapon) {
    bodyindex = victim getcharacterbodytype();
    if (bodyindex == 9) {
        switch (heroweapon.name) {
        case #"hero_minigun":
        case #"hash_8deed52f":
            bodyindex = 6;
            break;
        case #"hero_flamethrower":
            bodyindex = 8;
            break;
        case #"hero_lightninggun":
            bodyindex = 2;
            break;
        case #"hero_chemicalgelgun":
            bodyindex = 5;
            break;
        case #"hero_pineapplegun":
            bodyindex = 3;
            break;
        case #"hero_armblade":
            bodyindex = 7;
            break;
        case #"hero_bowlauncher":
        case #"hero_bowlauncher2":
        case #"hero_bowlauncher3":
        case #"hero_bowlauncher4":
            bodyindex = 1;
            break;
        case #"hero_gravityspikes":
            bodyindex = 0;
            break;
        case #"hero_annihilator":
        default:
            bodyindex = 4;
            break;
        }
    }
    return bodyindex;
}

