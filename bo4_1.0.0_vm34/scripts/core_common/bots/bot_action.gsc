#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\bots\bot_stance;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace bot_action;

// Namespace bot_action/bot_action
// Params 0, eflags: 0x2
// Checksum 0xb82ff610, Offset: 0x3f8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bot_action", &__init__, undefined, undefined);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x2335d083, Offset: 0x440
// Size: 0x1e
function __init__() {
    level.botactions = [];
    level.botweapons = [];
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x87c2a111, Offset: 0x468
// Size: 0x504
function register_actions() {
    register_action(#"revive_player", &rank_priority, &revive_player_weight, &revive_player);
    register_action(#"use_gameobject", &rank_priority, &function_f9913745, &use_gameobject);
    register_action(#"switch_to_weapon", &best_stowed_primary_weapon_rank, &switch_to_weapon_weight, &switch_to_weapon);
    register_action(#"hash_78881ac649c38041", &rank_priority, &function_b1202564, &function_f54ed6f1);
    register_action(#"melee_enemy", &current_melee_weapon_rank, &melee_enemy_weight, &melee_enemy);
    register_action(#"reload_weapon", &current_weapon_rank, &reload_weapon_weight, &reload_weapon);
    register_action(#"look_for_enemy", &current_weapon_rank, &look_for_enemy_weight, &look_for_enemy);
    register_action(#"hash_55fc6b6e868ae6c3", &current_weapon_rank, &function_433b15f2, &function_c5aef62f);
    register_action(#"hash_2bbb309be663cb4c", &function_f46d3345, &scan_for_threats_weight, &function_e217bc76);
    register_action(#"scan_for_threats", &function_f46d3345, &scan_for_threats_weight, &scan_for_threats);
    register_action(#"bleed_out", &rank_priority, &bleed_out_weight, &bleed_out);
    register_action(#"hash_7aaeac32a4e1bf84", &weapon_rank, &function_8dba31c1, &function_704da46e);
    register_action(#"hash_434716893aa869f3", &weapon_rank, &function_a347410a, &function_bb4ffec7);
    register_action(#"fire_grenade", &weapon_rank, &function_753af3c1, &fire_grenade);
    register_action(#"fire_rocketlauncher", &weapon_rank, &function_9d2bd3ff, &fire_rocketlauncher);
    register_action(#"fire_locked_rocketlauncher", &weapon_rank, &function_20b1d2f0, &fire_locked_rocketlauncher);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x1b4ceeea, Offset: 0x978
// Size: 0x3c4
function register_weapons() {
    register_weapon(#"none", &function_a34957b6);
    register_bulletweapon(#"ar_accurate_t8");
    register_bulletweapon(#"ar_damage_t8");
    register_bulletweapon(#"ar_fastfire_t8");
    register_bulletweapon(#"ar_modular_t8");
    register_bulletweapon(#"ar_stealth_t8");
    register_bulletweapon(#"lmg_double_t8");
    register_bulletweapon(#"lmg_heavy_t8");
    register_bulletweapon(#"lmg_spray_t8");
    register_bulletweapon(#"lmg_standard_t8");
    register_bulletweapon(#"pistol_burst_t8");
    register_bulletweapon(#"pistol_standard_t8");
    register_bulletweapon(#"pistol_revolver_t8");
    register_bulletweapon(#"shotgun_pump_t8");
    register_bulletweapon(#"shotgun_semiauto_t8");
    register_bulletweapon(#"smg_accurate_t8");
    register_bulletweapon(#"smg_capacity_t8");
    register_bulletweapon(#"smg_fastfire_t8");
    register_bulletweapon(#"smg_handling_t8");
    register_bulletweapon(#"smg_standard_t8");
    register_bulletweapon(#"sniper_fastrechamber_t8");
    register_bulletweapon(#"sniper_powerbolt_t8");
    register_bulletweapon(#"sniper_powersemi_t8");
    register_bulletweapon(#"sniper_quickscope_t8");
    register_bulletweapon(#"tr_leveraction_t8");
    register_bulletweapon(#"tr_longburst_t8");
    register_bulletweapon(#"tr_midburst_t8");
    register_bulletweapon(#"tr_powersemi_t8");
    register_weapon(#"launcher_standard_t8", &function_ece19386);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x118c0342, Offset: 0xd48
// Size: 0x54
function function_47e27c09() {
    function_eeecc088(#"launcher_standard_t8", "fire_rocketlauncher");
    function_eeecc088(#"launcher_standard_t8", "fire_locked_rocketlauncher");
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x566132b2, Offset: 0xda8
// Size: 0x4a
function start() {
    self.bot.var_1f812a11 = {#maxhealth:100, #distsq:1000000, #istarget:0};
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xd655f8c2, Offset: 0xe00
// Size: 0x16
function stop() {
    self notify(#"hash_5b4f399c08222e2");
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x4537a4f2, Offset: 0xe20
// Size: 0x22
function reset() {
    if (isdefined(self.bot)) {
        self.bot.var_80fecbdf = 0;
    }
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x7762009a, Offset: 0xe50
// Size: 0x104
function update() {
    if (isdefined(self.bot.action)) {
        self notify(#"hash_347a612b61067eb3");
        /#
            forcedstr = isdefined(self.bot.actionparams.forced) && self.bot.actionparams.forced ? "<dev string:x30>" : "<dev string:x39>";
            record3dtext("<dev string:x3a>" + function_15979fa9(self.bot.action.name) + forcedstr, self.origin, (1, 0, 1), "<dev string:x3d>", self, 0.5);
        #/
        return;
    }
    self thread execution_loop();
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0xe3e6b2ae, Offset: 0xf60
// Size: 0x70
function force(actionname, weapon, target) {
    action = get_action(actionname);
    if (!isdefined(action)) {
        return false;
    }
    self function_acf511dc(action, weapon, target);
    return true;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x57d76bc2, Offset: 0xfd8
// Size: 0x19c
function function_38c9bca9(slot) {
    gadgetweapon = undefined;
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        if (self gadgetgetslot(weapon) == slot) {
            gadgetweapon = weapon;
            break;
        }
    }
    if (!isdefined(gadgetweapon)) {
        return;
    }
    var_4f0a8746 = gadgetweapon.rootweapon.var_50c24831;
    if (!isdefined(var_4f0a8746) || var_4f0a8746.size <= 0) {
        /#
            self botprinterror("<dev string:x44>" + function_15979fa9(weapon.name));
        #/
        return;
    }
    self gadgetpowerset(slot, 100);
    self gadgetcharging(slot, 0);
    self function_acf511dc(var_4f0a8746[0], gadgetweapon, self.enemy);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xacaa3c6d, Offset: 0x1180
// Size: 0x12c
function function_56a75d03() {
    scorestreakweapon = undefined;
    weapons = self getweaponslist();
    for (i = 5; i < weapons.size; i++) {
        if (killstreaks::is_killstreak_weapon(weapons[i])) {
            scorestreakweapon = weapons[i];
            break;
        }
    }
    if (!isdefined(scorestreakweapon)) {
        return;
    }
    var_4f0a8746 = scorestreakweapon.rootweapon.var_50c24831;
    if (!isdefined(var_4f0a8746) || var_4f0a8746.size <= 0) {
        /#
            self botprinterror("<dev string:x61>" + function_15979fa9(weapons[i].name));
        #/
        return;
    }
    self function_acf511dc(var_4f0a8746[0], scorestreakweapon, self.enemy);
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x4
// Checksum 0xe770116b, Offset: 0x12b8
// Size: 0x84
function private function_acf511dc(action, weapon, target) {
    self.bot.var_3984d12a = {#action:action, #weapon:weapon, #target:target, #forced:1};
    self reset();
}

// Namespace bot_action/bot_action
// Params 4, eflags: 0x0
// Checksum 0x32f1e7e6, Offset: 0x1348
// Size: 0x7e
function register_action(name, rankfunc, weightfunc, executefunc) {
    level.botactions[name] = {#name:name, #rankfunc:rankfunc, #weightfunc:weightfunc, #executefunc:executefunc};
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x52412684, Offset: 0x13d0
// Size: 0x82
function register_weapon(weaponname, rankfunc) {
    weapon = getweapon(weaponname);
    if (weapon.name == #"none") {
        return;
    }
    level.botweapons[weaponname] = weapon;
    weapon.var_a3542b54 = rankfunc;
}

/#

    // Namespace bot_action/bot_action
    // Params 1, eflags: 0x0
    // Checksum 0x3d769c1f, Offset: 0x1460
    // Size: 0x5c
    function function_585771f0(weaponname) {
        if (!isdefined(level.botweapons[weaponname])) {
            assertmsg("<dev string:x83>" + function_15979fa9(weaponname) + "<dev string:x93>");
        }
    }

#/

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xc63f65a0, Offset: 0x14c8
// Size: 0x6c
function register_bulletweapon(weaponname) {
    register_weapon(weaponname, &function_c94c454e);
    function_eeecc088(weaponname, #"hash_7aaeac32a4e1bf84");
    function_eeecc088(weaponname, #"hash_434716893aa869f3");
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0xf89cddf1, Offset: 0x1540
// Size: 0x6a
function function_60a0d9d4(weaponname, rankfunc, activatefunc) {
    register_weapon(weaponname, rankfunc);
    weapon = level.botweapons[weaponname];
    if (!isdefined(weapon)) {
        return;
    }
    weapon.var_281b14fd = activatefunc;
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0xe8d0a810, Offset: 0x15b8
// Size: 0x6a
function function_b25b7c5a(weaponname, rankfunc, activatefunc) {
    register_weapon(weaponname, rankfunc);
    weapon = level.botweapons[weaponname];
    if (!isdefined(weapon)) {
        return;
    }
    weapon.var_8152d86b = activatefunc;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x52f7bc3d, Offset: 0x1630
// Size: 0x9e
function function_eeecc088(weaponname, actionname) {
    weapon = level.botweapons[weaponname];
    if (!isdefined(weapon)) {
        return;
    }
    action = get_action(actionname);
    if (!isdefined(action)) {
        return;
    }
    if (!isdefined(weapon.var_fea0003a)) {
        weapon.var_fea0003a = [];
    }
    weapon.var_fea0003a[weapon.var_fea0003a.size] = action;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x91bc0a7d, Offset: 0x16d8
// Size: 0x9e
function function_3800d421(weaponname, actionname) {
    weapon = level.botweapons[weaponname];
    if (!isdefined(weapon)) {
        return;
    }
    action = get_action(actionname);
    if (!isdefined(action)) {
        return;
    }
    if (!isdefined(weapon.var_50c24831)) {
        weapon.var_50c24831 = [];
    }
    weapon.var_50c24831[weapon.var_50c24831.size] = action;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x837777f5, Offset: 0x1780
// Size: 0x1c
function get_action(name) {
    return level.botactions[name];
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x74403857, Offset: 0x17a8
// Size: 0xf0
function function_e4c147e7(weapon, var_fe0a9816) {
    if (!isdefined(var_fe0a9816)) {
        return;
    }
    paramslist = self.bot.paramslist;
    foreach (action in var_fe0a9816) {
        actionparams = {#action:action, #weapon:weapon};
        /#
            actionparams.debug = [];
        #/
        paramslist[paramslist.size] = actionparams;
    }
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x6a04034f, Offset: 0x18a0
// Size: 0x232
function function_243dd079() {
    currentweapon = self getcurrentweapon();
    var_a93e80f1 = self.bot.var_1f812a11;
    if (self function_bfdb45e7(self.bot.tacbundle.var_f19c9f47)) {
        var_a93e80f1 = spawnstruct();
        var_a93e80f1.maxhealth = self.enemy get_max_health();
        var_a93e80f1.distsq = distancesquared(self.origin, self.enemy.origin);
        var_a93e80f1.istarget = target_istarget(self.enemy);
    }
    if (isdefined(self.revivetrigger)) {
        self rank_weapon(currentweapon, var_a93e80f1);
        return;
    }
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        self rank_weapon(weapon, var_a93e80f1);
        if (weapon == currentweapon) {
            self function_e4c147e7(weapon, weapon.rootweapon.var_fea0003a);
            continue;
        }
        self function_e4c147e7(weapon, weapon.rootweapon.var_50c24831);
    }
    self.bot.var_1f812a11 = var_a93e80f1;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x2b2a5bbd, Offset: 0x1ae0
// Size: 0x146
function function_6cf9070a() {
    actionlist = self.bot.tacbundle.actionlist;
    if (!isdefined(actionlist)) {
        return;
    }
    paramslist = self.bot.paramslist;
    for (i = 0; i < actionlist.size; i++) {
        if (!isdefined(actionlist[i])) {
            continue;
        }
        actionname = actionlist[i].name;
        if (!isdefined(actionname)) {
            continue;
        }
        action = get_action(actionname);
        if (!isdefined(action)) {
            /#
                self botprinterror("<dev string:xb7>" + function_15979fa9(actionname));
            #/
            continue;
        }
        actionparams = {#action:action};
        /#
            actionparams.debug = [];
        #/
        paramslist[paramslist.size] = actionparams;
    }
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x4
// Checksum 0x434056a5, Offset: 0x1c30
// Size: 0x138
function private execution_loop() {
    self endon(#"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    level endon(#"game_ended");
    while (self bot::initialized()) {
        actionparams = self function_933463ee();
        if (isdefined(self.bot.var_1b9fd613) && !self.bot.var_1b9fd613) {
            self bot_position::start();
        }
        if (!isdefined(actionparams)) {
            /#
                self botprintwarning("<dev string:xcf>");
            #/
            return;
        }
        self function_d59bfb47(actionparams);
        self bot::function_4378a549();
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x4
// Checksum 0xd9328b0f, Offset: 0x1d70
// Size: 0x1f2
function private function_d59bfb47(actionparams) {
    self endoncallback(&function_fc557d36, #"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    level endon(#"game_ended");
    action = actionparams.action;
    self.bot.action = action;
    self.bot.actionparams = actionparams;
    self thread action_timeout(action.name);
    executetime = gettime();
    self function_e46da2b6(self.bot.tacbundle.var_2373cb5, self.bot.tacbundle.var_ed18951b);
    self [[ action.executefunc ]](actionparams);
    self notify(#"hash_1728f8b5de3bde13");
    finishtime = gettime();
    if (executetime == finishtime) {
        /#
            self botprinterror("<dev string:xdf>" + function_15979fa9(action.name) + "<dev string:xe7>");
        #/
        self waittill(#"hash_347a612b61067eb3");
    }
    self.bot.action = undefined;
    self.bot.actionparams = undefined;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x4
// Checksum 0xed2ddac3, Offset: 0x1f70
// Size: 0x46
function private function_fc557d36(notifyhash) {
    if (!self bot::initialized()) {
        return;
    }
    self.bot.action = undefined;
    self.bot.actionparams = undefined;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x4
// Checksum 0xb0fe75f5, Offset: 0x1fc0
// Size: 0xfe
function private action_timeout(actionname) {
    self endon(#"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start", #"hash_1728f8b5de3bde13");
    level endon(#"game_ended");
    wait 10;
    if (!isbot(self)) {
        return;
    }
    /#
        self botprintwarning("<dev string:xdf>" + function_15979fa9(actionname) + "<dev string:xf9>" + 10 + "<dev string:x10b>");
    #/
    self notify(#"hash_5b4f399c08222e2");
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x99083509, Offset: 0x20c8
// Size: 0x3a
function function_e46da2b6(smin, smax) {
    self.bot.var_80fecbdf = bot::function_905773a(smin, smax);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xae8e23bb, Offset: 0x2110
// Size: 0x18
function function_68380091() {
    return gettime() > self.bot.var_80fecbdf;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x96d760b3, Offset: 0x2130
// Size: 0x5e8
function function_933463ee() {
    self.bot.weaponranks = [];
    self.bot.paramslist = [];
    /#
        self.bot.var_52589897 = [];
    #/
    var_3984d12a = function_5c91c07f();
    if (isdefined(var_3984d12a)) {
        /#
            if (self bot::should_record("<dev string:x10d>")) {
                record3dtext("<dev string:x11e>" + function_15979fa9(var_3984d12a.action.name), self.origin, (1, 0, 1), "<dev string:x3d>", self, 0.5);
            }
        #/
        return var_3984d12a;
    }
    /#
        if (self bot::should_record("<dev string:x10d>")) {
            record3dtext("<dev string:x128>", self.origin, (1, 0, 1), "<dev string:x3d>", self, 0.5);
        }
    #/
    self function_243dd079();
    self function_6cf9070a();
    pixbeginevent(#"bot_pick_action");
    aiprofile_beginentry("bot_pick_action");
    self rank_actions();
    var_c951d02b = self weight_actions();
    pixendevent();
    aiprofile_endentry();
    /#
        if (self bot::should_record("<dev string:x10d>")) {
            pixbeginevent(#"bot_record_action_eval");
            aiprofile_beginentry("<dev string:x13a>");
            foreach (actionparams in self.bot.paramslist) {
                color = (0.75, 0.75, 0.75);
                headerstr = "<dev string:x151>";
                recordrank = "<dev string:x151>";
                recordweight = "<dev string:x151>";
                if (isdefined(actionparams.rank)) {
                    recordrank = actionparams.rank;
                    if (isdefined(actionparams.weight)) {
                        color = (1, 1, 1);
                        headerstr = "<dev string:x153>";
                        recordweight = actionparams.weight;
                        if (isdefined(var_c951d02b)) {
                            if (actionparams.rank >= var_c951d02b.rank) {
                                color = utility_color(actionparams.weight, 100);
                                headerstr = actionparams == var_c951d02b ? "<dev string:x155>" : "<dev string:x157>";
                            }
                        }
                    }
                }
                record3dtext(headerstr + function_15979fa9(actionparams.action.name) + "<dev string:x159>" + recordrank + "<dev string:x15c>" + recordweight, self.origin, color, "<dev string:x3d>", self, 0.5);
                if (isdefined(actionparams.weapon) && isdefined(self.bot.var_52589897[actionparams.weapon])) {
                    foreach (str in self.bot.var_52589897[actionparams.weapon]) {
                        record3dtext("<dev string:x15f>" + str, self.origin, color, "<dev string:x3d>", self, 0.5);
                    }
                }
                foreach (entry in actionparams.debug) {
                    record3dtext("<dev string:x15f>" + entry, self.origin, color, "<dev string:x3d>", self, 0.5);
                }
            }
            pixendevent();
            aiprofile_endentry();
        }
    #/
    return var_c951d02b;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x95ccd6a6, Offset: 0x2720
// Size: 0x56
function function_5c91c07f() {
    if (!isdefined(self.bot.var_3984d12a)) {
        return undefined;
    }
    actionparams = self.bot.var_3984d12a;
    self.bot.var_3984d12a = undefined;
    if (!isdefined(actionparams)) {
        return undefined;
    }
    return actionparams;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xef3bf91c, Offset: 0x2780
// Size: 0x260
function weight_actions() {
    pixbeginevent(#"bot_weight_actions");
    aiprofile_beginentry("bot_weight_actions");
    var_c951d02b = undefined;
    bestrank = undefined;
    bestweight = undefined;
    paramslist = self.bot.paramslist;
    foreach (actionparams in paramslist) {
        if (!isdefined(actionparams.rank)) {
            continue;
        }
        action = actionparams.action;
        pixbeginevent("bot_weight_" + action.name);
        aiprofile_beginentry("bot_weight_" + action.name);
        actionparams.weight = self [[ action.weightfunc ]](actionparams);
        pixendevent();
        aiprofile_endentry();
        if (!isdefined(actionparams.weight)) {
            continue;
        }
        if (isdefined(var_c951d02b) && actionparams.rank < bestrank) {
            continue;
        }
        if (!isdefined(var_c951d02b) || actionparams.rank > bestrank || actionparams.weight > bestweight) {
            var_c951d02b = actionparams;
            bestrank = actionparams.rank;
            bestweight = actionparams.weight;
        }
    }
    pixendevent();
    aiprofile_endentry();
    return var_c951d02b;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xadea3f10, Offset: 0x29e8
// Size: 0x184
function rank_actions() {
    pixbeginevent(#"bot_rank_actions");
    aiprofile_beginentry("bot_rank_actions");
    paramslist = self.bot.paramslist;
    foreach (actionparams in paramslist) {
        action = actionparams.action;
        pixbeginevent("bot_rank_" + action.name);
        aiprofile_beginentry("bot_rank_" + action.name);
        actionparams.rank = self [[ action.rankfunc ]](actionparams);
        pixendevent();
        aiprofile_endentry();
    }
    pixendevent();
    aiprofile_endentry();
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xe75085, Offset: 0x2b78
// Size: 0x10
function rank_priority(actionparams) {
    return 1000;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x59806e9a, Offset: 0x2b90
// Size: 0x10
function function_1437c5fb(actionparams) {
    return -1000;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xb7c29977, Offset: 0x2ba8
// Size: 0x1a6
function current_melee_weapon_rank(actionparams) {
    weapon = self getcurrentweapon();
    actionparams.weapon = weapon;
    if (sessionmodeiszombiesgame()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x163>";
        #/
        return 1000;
    }
    if (!weapon.ismeleeweapon) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = weapon.name + "<dev string:x176>";
        #/
        return undefined;
    }
    return 1000;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x8158f9c, Offset: 0x2d58
// Size: 0x6a
function current_weapon_rank(actionparams) {
    weapon = self getcurrentweapon();
    actionparams.weapon = weapon;
    if (weapon == level.weaponnone) {
        return -1000;
    }
    return weapon_rank(actionparams);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x2500b8c5, Offset: 0x2dd0
// Size: 0x1f2
function best_stowed_primary_weapon_rank(actionparams) {
    currentweapon = self getcurrentweapon();
    weapons = self getweaponslistprimaries();
    bestweapon = undefined;
    bestweaponrank = undefined;
    foreach (weapon in weapons) {
        if (weapon == currentweapon) {
            continue;
        }
        weaponrank = self function_ccac487f(weapon);
        if (!isdefined(weaponrank)) {
            continue;
        }
        if (!isdefined(bestweapon) || bestweaponrank < weaponrank) {
            bestweapon = weapon;
            bestweaponrank = weaponrank;
        }
    }
    if (!isdefined(bestweapon)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x18a>";
        #/
        return undefined;
    }
    actionparams.weapon = bestweapon;
    return weapon_rank(actionparams);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x7d7a03c1, Offset: 0x2fd0
// Size: 0x3a
function weapon_rank(actionparams) {
    weapon = actionparams.weapon;
    return self function_ccac487f(weapon);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x665dfabd, Offset: 0x3018
// Size: 0x54
function function_ccac487f(weapon) {
    ammo = self getammocount(weapon);
    if (ammo <= 0) {
        return -1000;
    }
    return self.bot.weaponranks[weapon];
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x6c2f5ed4, Offset: 0x3078
// Size: 0x38
function function_63fd8e23(actionparams) {
    weapon = actionparams.weapon;
    return self.bot.weaponranks[weapon];
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xc29e9c94, Offset: 0x30b8
// Size: 0x50
function rank_weapon(weapon, var_a93e80f1) {
    rankfunc = weapon.rootweapon.var_a3542b54;
    if (!isdefined(rankfunc)) {
        return;
    }
    self [[ rankfunc ]](weapon, var_a93e80f1);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x104be741, Offset: 0x3110
// Size: 0x2c
function function_b0efcdba(weapon, var_a93e80f1) {
    self set_weapon_rank(weapon, 0);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x60b6759d, Offset: 0x3148
// Size: 0xbc
function function_c94c454e(weapon, var_a93e80f1) {
    self set_weapon_rank(weapon, 1);
    self factor_damage_range(weapon, var_a93e80f1);
    if (weapon.weapclass == "pistol" || weapon.weapclass == "pistol spread") {
        self set_weapon_rank(weapon, 0.8, "Pistol");
    }
    self factor_ammo(weapon);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x9d681d08, Offset: 0x3210
// Size: 0x8c
function function_ece19386(weapon, var_a93e80f1) {
    self set_weapon_rank(weapon, 0);
    self factor_lockon(weapon, var_a93e80f1);
    self factor_dumbfire_range(weapon, var_a93e80f1);
    self factor_rocketlauncher_overkill(weapon, var_a93e80f1);
    self factor_ammo(weapon);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xed97619d, Offset: 0x32a8
// Size: 0x54
function function_2407c50c(weapon, var_a93e80f1) {
    self set_weapon_rank(weapon, 998, "Secondary offhand weapon");
    self factor_ammo(weapon, var_a93e80f1);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x443b72f0, Offset: 0x3308
// Size: 0x54
function function_fdf4c25(weapon, var_a93e80f1) {
    self set_weapon_rank(weapon, 999, "Special offhand weapon");
    self factor_ammo(weapon, var_a93e80f1);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x5d85ccb, Offset: 0x3368
// Size: 0x84
function function_d269dfe1(weapon, var_a93e80f1) {
    if (self getcurrentweapon() != weapon) {
        self set_weapon_rank(weapon, 999, "Scorestreak weapon");
        return;
    }
    self set_weapon_rank(weapon, -1000, "Don't use scorestreak weapon that is already equipped");
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x815b5667, Offset: 0x33f8
// Size: 0x54
function function_dde10d2d(weapon, var_a93e80f1) {
    self set_weapon_rank(weapon, 1000, "This weapon is a priority");
    self factor_ammo(weapon, var_a93e80f1);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xec85fd94, Offset: 0x3458
// Size: 0x3c
function function_a34957b6(weapon, var_a93e80f1) {
    self set_weapon_rank(weapon, -1000, "This weapon is unusable");
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0x874536aa, Offset: 0x34a0
// Size: 0xe8
function set_weapon_rank(weapon, rank, reason) {
    self.bot.weaponranks[weapon] = rank;
    /#
        rankstr = isdefined(rank) ? rank : "<dev string:x151>";
        self.bot.var_52589897[weapon] = array(weapon.name + "<dev string:x159>" + rankstr);
        if (isdefined(reason)) {
            self.bot.var_52589897[weapon][self.bot.var_52589897[weapon].size] = "<dev string:x1a4>" + reason;
        }
    #/
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0x4d8a0f9, Offset: 0x3590
// Size: 0xec
function modify_weapon_rank(weapon, amount, reason) {
    if (!isdefined(self.bot.weaponranks[weapon])) {
        return;
    }
    self.bot.weaponranks[weapon] = self.bot.weaponranks[weapon] + amount;
    /#
        sign = amount < 0 ? "<dev string:x39>" : "<dev string:x1a7>";
        self.bot.var_52589897[weapon][self.bot.var_52589897[weapon].size] = "<dev string:x1a4>" + sign + amount + "<dev string:x157>" + reason;
    #/
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xafea3472, Offset: 0x3688
// Size: 0xf4
function factor_ammo(weapon, var_a93e80f1) {
    clipammo = self clip_ammo(weapon);
    stockammo = self getweaponammostock(weapon);
    if (clipammo + stockammo <= 0) {
        if (weapon.isgadget) {
            slot = self gadgetgetslot(weapon);
            if (!self gadgetisready(slot)) {
                self set_weapon_rank(weapon, undefined, "Gadget not ready");
            }
            return;
        }
        self set_weapon_rank(weapon, -1000, "No ammo");
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x696a0475, Offset: 0x3788
// Size: 0x104
function factor_damage_range(weapon, var_a93e80f1) {
    if (!isdefined(self.enemy)) {
        return;
    }
    if (var_a93e80f1.distsq < weapon.maxdamagerange * weapon.maxdamagerange) {
        self modify_weapon_rank(weapon, 1, "In max damage range");
        return;
    }
    if (var_a93e80f1.distsq >= weapon.mindamagerange * weapon.mindamagerange) {
        if (weapon.weapclass == "spread") {
            self set_weapon_rank(weapon, undefined, "Outside of spread min damage range");
            return;
        }
        self modify_weapon_rank(weapon, -1, "In min damage range");
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x31878ec6, Offset: 0x3898
// Size: 0x94
function factor_lockon(weapon, var_a93e80f1) {
    if (var_a93e80f1.istarget) {
        if (weapon.lockontype != "None") {
            self modify_weapon_rank(weapon, 1, "Lockon Target");
        }
        return;
    }
    if (weapon.requirelockontofire) {
        self set_weapon_rank(weapon, undefined, "Requires Lockon");
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x985aa109, Offset: 0x3938
// Size: 0x74
function factor_dumbfire_range(weapon, var_a93e80f1) {
    if (var_a93e80f1.distsq < 2250000) {
        self modify_weapon_rank(weapon, 1, "In Dumbfire Range");
        return;
    }
    self modify_weapon_rank(weapon, -1, "Outside Dumbfire Range");
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x52413a9f, Offset: 0x39b8
// Size: 0xe4
function factor_rocketlauncher_overkill(weapon, var_a93e80f1) {
    if (!isdefined(var_a93e80f1.maxhealth)) {
        self set_weapon_rank(weapon, undefined, "Max Health is undefined");
        return;
    }
    if (var_a93e80f1.maxhealth >= 400) {
        self modify_weapon_rank(weapon, 2, "Enemy Max Health " + var_a93e80f1.maxhealth + " >= " + 400);
        return;
    }
    self modify_weapon_rank(weapon, -1, "Enemy Max Health " + var_a93e80f1.maxhealth + " < " + 400);
}

/#

    // Namespace bot_action/bot_action
    // Params 2, eflags: 0x0
    // Checksum 0x1cf2e099, Offset: 0x3aa8
    // Size: 0x12c
    function utility_color(utility, targetutility) {
        colorscale = array((1, 0, 0), (1, 0.5, 0), (1, 1, 0), (0, 1, 0));
        if (utility >= targetutility) {
            return colorscale[colorscale.size - 1];
        } else if (utility <= 0) {
            return colorscale[0];
        }
        utilityindex = utility * colorscale.size / targetutility;
        utilityindex -= 1;
        colorindex = int(utilityindex);
        colorfrac = utilityindex - colorindex;
        utilitycolor = vectorlerp(colorscale[colorindex], colorscale[colorindex + 1], colorfrac);
        return utilitycolor;
    }

#/

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x3ffa367e, Offset: 0x3be0
// Size: 0x260
function look_for_enemy_weight(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x1a9>";
        #/
        return undefined;
    }
    if (self is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b7>";
        #/
        return undefined;
    }
    if (!self function_bfdb45e7(self.bot.tacbundle.var_f19c9f47)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x1c8>";
        #/
        return undefined;
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xff6dce71, Offset: 0x3e48
// Size: 0xe6
function look_for_enemy(actionparams) {
    var_50787f09 = self.enemy;
    weapon = self getcurrentweapon();
    while (!self function_68380091() && self function_28b0a79b() && self bot::in_combat() && self is_target_enemy(actionparams) && !self is_target_visible(actionparams)) {
        self function_50172422();
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xb76c3b57, Offset: 0x3f38
// Size: 0x246
function function_433b15f2(actionparams) {
    if (self.ignoreall) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x1e9>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x1f3>";
        #/
        return undefined;
    }
    target = self ai::function_baa92a04(0);
    if (!isdefined(target)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x201>";
        #/
        return undefined;
    }
    actionparams.target = target;
    self function_3e1dfdce(target);
    return 0;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x40d5c4b4, Offset: 0x4188
// Size: 0x116
function function_c5aef62f(actionparams) {
    target = actionparams.target;
    self setentitytarget(target);
    self.bot.var_470dfa67 = 1;
    while (!self function_68380091() && !self.ignoreall && isdefined(target) && self is_target_enemy(actionparams) && isalive(target) && !self is_target_visible(actionparams)) {
        self function_e9fddff3(actionparams);
        self aim_at_target(actionparams);
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xf2991659, Offset: 0x42a8
// Size: 0x40
function function_f46d3345(actionparams) {
    currentweaponrank = self current_weapon_rank(actionparams);
    if (isdefined(currentweaponrank)) {
        return currentweaponrank;
    }
    return -1000;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x3e43bba9, Offset: 0x42f0
// Size: 0x36
function scan_for_threats_weight(actionparams) {
    actionparams.target = self.enemy;
    self function_77ee8d5(actionparams);
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x11656a39, Offset: 0x4330
// Size: 0x1e2
function scan_for_threats(actionparams) {
    targetvisible = self is_target_visible(actionparams);
    actionparams.targetvisible = targetvisible;
    while (!self function_68380091() && self is_target_enemy(actionparams) && actionparams.targetvisible == targetvisible) {
        if (targetvisible && self function_e5578b7f(actionparams)) {
            self function_e9fddff3(actionparams);
            self function_b69f54b(actionparams);
        } else if (!targetvisible && self function_e5578b7f(actionparams)) {
            self function_e9fddff3(actionparams);
            self function_b69f54b(actionparams);
        } else if (self function_d5f640c7()) {
            self function_b07d5884();
        } else if (targetvisible) {
            self function_e9fddff3(actionparams);
            self aim_at_target(actionparams);
        } else {
            self function_5182cb26();
        }
        self waittill(#"hash_347a612b61067eb3");
        targetvisible = self is_target_visible(actionparams);
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xc766f0d2, Offset: 0x4520
// Size: 0x1aa
function function_e217bc76(actionparams) {
    targetvisible = self is_target_visible(actionparams);
    actionparams.targetvisible = targetvisible;
    while (!self function_68380091() && self is_target_enemy(actionparams) && actionparams.targetvisible == targetvisible) {
        if (targetvisible && self function_e5578b7f(actionparams)) {
            self function_e9fddff3(actionparams);
            self function_b69f54b(actionparams);
        } else if (!targetvisible && self function_e5578b7f(actionparams)) {
            self function_e9fddff3(actionparams);
            self function_b69f54b(actionparams);
        } else if (self function_d5f640c7()) {
            self function_b07d5884();
        } else {
            self function_5182cb26();
        }
        self waittill(#"hash_347a612b61067eb3");
        targetvisible = self is_target_visible(actionparams);
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x96678e84, Offset: 0x46d8
// Size: 0x592
function revive_player_weight(actionparams) {
    if (!self ai::get_behavior_attribute("revive")) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x21d>";
        #/
        return undefined;
    }
    revivetarget = self bot::get_revive_target();
    if (!isdefined(revivetarget)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x239>";
        #/
        return undefined;
    }
    actionparams.revivetarget = revivetarget;
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x24a>" + revivetarget.name;
    #/
    if (!isdefined(revivetarget.revivetrigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x253>";
        #/
        return undefined;
    }
    if (!self istouching(revivetarget.revivetrigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x265>";
        #/
        return undefined;
    }
    if (isdefined(revivetarget.revivetrigger.beingrevived) && revivetarget.revivetrigger.beingrevived) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x27a>";
        #/
        return;
    }
    pathenemyfightdist = self.bot.tacbundle.pathenemyfightdist;
    if (!self ai::get_behavior_attribute("ignorepathenemyfightdist") && isdefined(self.enemy) && isdefined(pathenemyfightdist) && pathenemyfightdist > 0 && distance2dsquared(self.origin, self.enemy.origin) < pathenemyfightdist * pathenemyfightdist) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x288>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x70b375ff, Offset: 0x4c78
// Size: 0x27c
function revive_player(actionparams) {
    player = actionparams.revivetarget;
    if (!isdefined(player)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x2ae>");
        #/
        return;
    }
    self.attackeraccuracy = 0.01;
    while (isalive(player) && isdefined(player.revivetrigger) && self istouching(player.revivetrigger)) {
        if (isdefined(player.revivetrigger.beingrevived) && player.revivetrigger.beingrevived) {
            function_7031cf94();
            return;
        }
        self look_at_point(player.revivetrigger.origin, "Revive Trigger", (1, 1, 1));
        if (self botgetlookdot() >= 0) {
            self botsetlookcurrent();
            break;
        }
        self bot_stance::crouch();
        self waittill(#"hash_347a612b61067eb3");
    }
    while (isalive(player) && isdefined(player.revivetrigger) && self istouching(player.revivetrigger)) {
        self look_at_point(player.revivetrigger.origin, "Revive Trigger", (1, 1, 1));
        self bot_stance::crouch();
        self bottapbutton(3);
        self waittill(#"hash_347a612b61067eb3");
    }
    self function_7031cf94();
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xe319f14e, Offset: 0x4f00
// Size: 0x2c
function function_7031cf94(notifyhash) {
    self.attackeraccuracy = 1;
    self bot_stance::reset();
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xef9def8, Offset: 0x4f38
// Size: 0x25a
function function_f9913745(actionparams) {
    if (!self bot::function_7928da6()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x2c7>";
        #/
        return undefined;
    }
    gameobject = self bot::get_interact();
    actionparams.gameobject = gameobject;
    if (self haspath()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x2de>";
        #/
        return undefined;
    }
    if (!self istouching(gameobject.trigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x265>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x1baf528d, Offset: 0x51a0
// Size: 0x212
function use_gameobject(actionparams) {
    gameobject = actionparams.gameobject;
    lookpoint = gameobject.trigger.origin;
    while (isdefined(gameobject) && gameobject === self bot::get_interact() && self istouching(gameobject.trigger)) {
        self look_at_point(lookpoint, "Gameobject Trigger", (1, 1, 1));
        if (self botgetlookdot() >= 0.76) {
            self botsetlookcurrent();
            break;
        }
        waitframe(1);
    }
    while (isdefined(gameobject) && gameobject === self bot::get_interact() && self istouching(gameobject.trigger) && !isdefined(self.claimtrigger)) {
        self bottapbutton(3);
        waitframe(1);
    }
    if (isdefined(gameobject) && gameobject === self bot::get_interact() && isdefined(gameobject.inuse) && gameobject.inuse && isdefined(gameobject.trigger) && self.claimtrigger === gameobject.trigger) {
        self bottapbutton(3);
        waitframe(1);
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x2012271e, Offset: 0x53c0
// Size: 0x242
function function_b1202564(actionparams) {
    if (!isdefined(self.bot.traversal)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x2ea>";
        #/
        return undefined;
    }
    if (isdefined(self.bot.traversal.mantlenode)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x2fb>";
        #/
        return undefined;
    }
    if (self.bot.traversal.targetheight < 40) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30b>" + self.bot.traversal.targetheight + "<dev string:x31a>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xabc4c2a8, Offset: 0x5610
// Size: 0x66
function function_f54ed6f1(actionparams) {
    while (isdefined(self.bot.traversal)) {
        self botsetlookpoint(self.bot.traversal.endpos);
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xdc9edce1, Offset: 0x5680
// Size: 0x10c
function switch_to_weapon_weight(actionparams) {
    currentweapon = self getcurrentweapon();
    currentweaponrank = self function_ccac487f(currentweapon);
    if (isdefined(currentweaponrank) && actionparams.rank <= currentweaponrank) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x320>" + currentweaponrank;
        #/
        return undefined;
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xc7bcca23, Offset: 0x5798
// Size: 0x7e
function switch_to_weapon(actionparams) {
    weapon = actionparams.weapon;
    self botswitchtoweapon(weapon);
    self waittill(#"hash_347a612b61067eb3");
    while (self isswitchingweapons()) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xe786060b, Offset: 0x5820
// Size: 0x3a0
function reload_weapon_weight(actionparams) {
    weapon = actionparams.weapon;
    actionparams.target = self.enemy;
    self function_77ee8d5(actionparams);
    stockammo = self getweaponammostock(weapon);
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x33e>" + stockammo;
    #/
    if (stockammo <= 0) {
        return undefined;
    }
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x346>" + clipammo + "<dev string:x34d>" + weapon.clipsize;
    #/
    if (clipammo >= weapon.clipsize) {
        return undefined;
    }
    if (self bot::in_combat() && clipammo > weapon.clipsize * 0.2) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x34f>";
        #/
        return undefined;
    }
    if (self isreloading()) {
        return 100;
    }
    if (!self function_a3ec3e()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x359>";
        #/
        return undefined;
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xf5b89000, Offset: 0x5bc8
// Size: 0x1d6
function reload_weapon(actionparams) {
    weapon = self getcurrentweapon();
    if (!self isreloading()) {
        self bottapbutton(4);
    }
    self waittill(#"hash_347a612b61067eb3");
    while (self isreloading()) {
        if (self is_target_enemy(actionparams) && self is_target_visible(actionparams)) {
            self function_e9fddff3(actionparams);
            self function_b69f54b(actionparams);
        } else if (self is_target_enemy(actionparams) && self function_bfdb45e7(self.bot.tacbundle.var_f19c9f47)) {
            if (self function_444016e7()) {
                self function_50172422();
            } else {
                self function_97fae03a();
            }
        } else if (self function_d5f640c7()) {
            self function_b07d5884();
        } else {
            self function_5182cb26();
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x2e381d56, Offset: 0x5da8
// Size: 0x29a
function melee_enemy_weight(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    if (!self is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x36a>";
        #/
        return undefined;
    }
    meleerange = actionparams.weapon.var_9bde0fd9;
    if (distancesquared(self.origin, self.enemy.origin) > meleerange * meleerange) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x37b>";
        #/
        return undefined;
    }
    if (self bot::fwd_dot(self.enemy.origin) < 0.5) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x394>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x5f6d0541, Offset: 0x6050
// Size: 0xce
function melee_enemy(actionparams) {
    self function_e9fddff3(actionparams);
    self function_b69f54b(actionparams);
    self bottapbutton(2);
    if (sessionmodeiszombiesgame()) {
        wait 0.5;
        return;
    }
    self waittill(#"hash_347a612b61067eb3");
    if (self ismeleeing()) {
        while (self ismeleeing()) {
            self waittill(#"hash_347a612b61067eb3");
        }
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x9c128cb3, Offset: 0x6128
// Size: 0x290
function function_8dba31c1(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    if (!self is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x36a>";
        #/
        return undefined;
    }
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x3ad>" + clipammo + "<dev string:x34d>" + weapon.clipsize;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    if (!self function_e5578b7f(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3b3>";
        #/
        return undefined;
    }
    self function_77ee8d5(actionparams);
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x376e33b3, Offset: 0x63c0
// Size: 0x10e
function function_704da46e(actionparams) {
    weapon = actionparams.weapon;
    while (!self function_68380091() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
        self function_e9fddff3(actionparams);
        self function_b69f54b(actionparams);
        if (self function_c3d770a4(actionparams)) {
            self bot::function_58e90f90();
            self bot::function_58e90f90(1);
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xaf4087b1, Offset: 0x64d8
// Size: 0x420
function function_a347410a(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    if (!self is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x36a>";
        #/
        return undefined;
    }
    if (!weapon.aimdownsight) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3cf>";
        #/
        return undefined;
    }
    if (self haspath() && !(isdefined(self.bot.tacbundle.var_43b31b07) && self.bot.tacbundle.var_43b31b07)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3e1>";
        #/
        return undefined;
    }
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x3ad>" + clipammo + "<dev string:x34d>" + weapon.clipsize;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    if (!self function_25d08c02(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3e8>";
        #/
        return undefined;
    }
    self function_77ee8d5(actionparams);
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x7fcbbefc, Offset: 0x6900
// Size: 0x15e
function function_bb4ffec7(actionparams) {
    weapon = actionparams.weapon;
    while (!self function_68380091() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
        self function_e9fddff3(actionparams);
        self aim_at_target(actionparams);
        if (self function_6881160c(actionparams)) {
            self bottapbutton(11);
            if (self function_5e0e6587(actionparams) && self playerads() >= 1) {
                self bot::function_58e90f90();
                self bot::function_58e90f90(1);
            }
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x36016862, Offset: 0x6a68
// Size: 0x412
function function_753af3c1(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    if (!self is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x36a>";
        #/
        return undefined;
    }
    if (self haspath()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3e1>";
        #/
        return undefined;
    }
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x3ad>" + clipammo + "<dev string:x34d>" + weapon.clipsize;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    self function_e9fddff3(actionparams);
    self function_8b5bb921(actionparams);
    if (!isdefined(actionparams.var_7ac9e90b)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x404>";
        #/
        return undefined;
    }
    self function_7e5f837a(actionparams);
    if (!self function_ed41018(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x426>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x17e682f2, Offset: 0x6e88
// Size: 0x15e
function fire_grenade(actionparams) {
    weapon = actionparams.weapon;
    while (!self function_68380091() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
        self function_e9fddff3(actionparams);
        self function_8b5bb921(actionparams);
        self function_7e5f837a(actionparams);
        self function_d3b4f42(actionparams);
        if (self function_ed41018(actionparams)) {
            if (self botgetlookdot() >= 1 && self bot::function_34a60ad()) {
                self bot::function_4e025546();
            }
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xdd3cf5a, Offset: 0x6ff0
// Size: 0x3fa
function function_20b1d2f0(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    if (!self is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x36a>";
        #/
        return undefined;
    }
    if (!self function_b4606f4(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x43e>";
        #/
        return undefined;
    }
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x3ad>" + clipammo + "<dev string:x34d>" + weapon.clipsize;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    if (self haspath()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3e1>";
        #/
        return undefined;
    }
    distsq = distancesquared(self.origin, self.enemy.origin);
    if (distsq < 2250000) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x459>";
        #/
        return 0;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x8e492bec, Offset: 0x73f8
// Size: 0x27e
function fire_locked_rocketlauncher(actionparams) {
    target = actionparams.target;
    weapon = actionparams.weapon;
    lockedflag = 1 << self getentitynumber();
    while (!self function_68380091() && !self haspath() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self function_b4606f4(actionparams) && self bot::weapon_loaded(weapon)) {
        self function_40f48286(actionparams);
        self aim_at_target(actionparams);
        if (self function_6881160c(actionparams)) {
            self bottapbutton(11);
            if (self playerads() >= 1 && isdefined(self.stingertarget) && isdefined(self.stingertarget.locked_on) && self.stingertarget.locked_on & lockedflag) {
                self bottapbutton(0);
            }
        }
        self waittill(#"hash_347a612b61067eb3");
        if (self isfiring()) {
            break;
        }
    }
    while (self isfiring()) {
        if (self is_target_visible(actionparams)) {
            self function_e9fddff3(actionparams);
            self aim_at_target(actionparams);
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xb0b888d1, Offset: 0x7680
// Size: 0x2a2
function function_9d2bd3ff(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    if (!self is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x36a>";
        #/
        return undefined;
    }
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x3ad>" + clipammo + "<dev string:x34d>" + weapon.clipsize;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    distsq = distancesquared(self.origin, self.enemy.origin);
    if (distsq > 2250000) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x471>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x992e92e6, Offset: 0x7930
// Size: 0x23e
function fire_rocketlauncher(actionparams) {
    target = actionparams.target;
    weapon = actionparams.weapon;
    while (!self function_68380091() && self is_target_enemy(actionparams) && self is_target_visible(actionparams) && self bot::weapon_loaded(weapon)) {
        self function_e9fddff3(actionparams);
        self aim_at_target(actionparams);
        if (self function_6881160c(actionparams)) {
            if (self function_5e0e6587(actionparams)) {
                if (!self haspath()) {
                    self bottapbutton(11);
                    if (self playerads() >= 1) {
                        self bottapbutton(0);
                        self waittill(#"hash_347a612b61067eb3");
                        break;
                    }
                } else {
                    self bottapbutton(0);
                }
            }
        }
        self waittill(#"hash_347a612b61067eb3");
        if (self isfiring()) {
            break;
        }
    }
    while (self isfiring()) {
        if (self is_target_visible(actionparams)) {
            self function_e9fddff3(actionparams);
            self aim_at_target(actionparams);
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xe6c0549, Offset: 0x7b78
// Size: 0x6e
function function_a5d700ec(weapon) {
    activatefunc = weapon.rootweapon.var_281b14fd;
    if (!isdefined(activatefunc)) {
        /#
            self botprinterror(weapon.name + "<dev string:x49c>");
        #/
        return;
    }
    self [[ activatefunc ]](weapon);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x85d78151, Offset: 0x7bf0
// Size: 0xae
function activate_health_gadget(actionparams) {
    weapon = actionparams.weapon;
    self function_a5d700ec(weapon);
    while (self isthrowinggrenade() || !self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xe1bda83c, Offset: 0x7ca8
// Size: 0x346
function throw_offhand(actionparams) {
    weapon = actionparams.weapon;
    self function_a5d700ec(weapon);
    slot = self gadgetgetslot(weapon);
    button = self function_628f19f9(weapon);
    self function_d3b4f42(actionparams);
    self waittill(#"hash_347a612b61067eb3");
    while (!self function_7229e29e()) {
        self function_e9fddff3(actionparams);
        self function_8b5bb921(actionparams);
        self function_d3b4f42(actionparams);
        self bottapbutton(button);
        self waittill(#"hash_347a612b61067eb3");
    }
    holding = 1;
    while (!self function_68380091() && self isthrowinggrenade() && self is_target_enemy(actionparams) && self is_target_visible(actionparams)) {
        self function_e9fddff3(actionparams);
        self function_8b5bb921(actionparams);
        self function_d3b4f42(actionparams);
        if (holding) {
            self function_7e5f837a(actionparams);
            if (!self function_ed41018(actionparams)) {
                break;
            } else if (self botgetlookdot() >= 1) {
                holding = 0;
            }
        }
        self waittill(#"hash_347a612b61067eb3");
    }
    if (holding) {
        while (self isthrowinggrenade()) {
            self bottapbutton(71);
            self bottapbutton(49);
            self function_97fae03a();
            self waittill(#"hash_347a612b61067eb3");
        }
    }
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x6d3a2d6e, Offset: 0x7ff8
// Size: 0x366
function bleed_out_weight(actionparams) {
    if (!isdefined(self.owner)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x4c1>";
        #/
        return undefined;
    }
    if (self.owner.sessionstate == "playing") {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x4ca>";
        #/
        return undefined;
    }
    if (!isdefined(self.revivetrigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x4db>";
        #/
        return undefined;
    }
    if (isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x4ed>";
        #/
        return undefined;
    }
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x4fb>" + self.owner.sessionstate;
    #/
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x1ec6d701, Offset: 0x8368
// Size: 0x7e
function bleed_out(actionparams) {
    while (!isdefined(self.revivetrigger) && !(isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived)) {
        self bottapbutton(3);
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x65e23550, Offset: 0x83f0
// Size: 0x3c
function function_77ee8d5(actionparams) {
    self function_3e1dfdce(actionparams, self.bot.tacbundle.var_8d75fa90);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xf8a0f7fd, Offset: 0x8438
// Size: 0x3c
function function_2ae2afff(actionparams) {
    self function_3e1dfdce(actionparams, self.bot.tacbundle.var_6bf87752);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xaf58f339, Offset: 0x8480
// Size: 0xf2
function function_3e1dfdce(actionparams, aimtag) {
    target = actionparams.target;
    if (!isentity(target)) {
        return;
    }
    if (self.scriptenemy === target && isdefined(self.scriptenemytag)) {
        actionparams.aimtag = self.scriptenemytag;
    } else if (isdefined(target.shootattag)) {
        actionparams.aimtag = target.shootattag;
    } else {
        actionparams.aimtag = aimtag;
    }
    actionparams.var_349f7682 = actionparams.aimtag;
    if (isdefined(target.aimattag)) {
        actionparams.var_349f7682 = target.aimattag;
    }
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x4
// Checksum 0xd34de303, Offset: 0x8580
// Size: 0x80
function private function_e7a3065(tag, target, defaultorigin) {
    if (!isdefined(tag)) {
        return defaultorigin;
    }
    if (tag == "tag_origin") {
        return target.origin;
    }
    tagorigin = target gettagorigin(tag);
    if (isdefined(tagorigin)) {
        return tagorigin;
    }
    return defaultorigin;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xc86cc70d, Offset: 0x8608
// Size: 0x14c
function function_e9fddff3(actionparams) {
    target = actionparams.target;
    if (isvec(target)) {
        actionparams.aimpoint = target;
    } else if (function_a5354464(target)) {
        actionparams.aimpoint = target.var_b49c3390;
    } else if (isentity(target)) {
        centroid = target getcentroid();
        actionparams.aimpoint = function_e7a3065(actionparams.aimtag, target, centroid);
        actionparams.var_c5870f88 = function_e7a3065(actionparams.var_349f7682, target, centroid);
    }
    if (!isdefined(actionparams.var_c5870f88)) {
        actionparams.var_c5870f88 = actionparams.aimpoint;
    }
    self function_5098bb8e(actionparams);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x5f6f074d, Offset: 0x8760
// Size: 0x26a
function function_5098bb8e(actionparams) {
    if (!isdefined(self.bot.var_b5f9ea92) || gettime() >= self.bot.var_b5f9ea92) {
        eyes = self geteye();
        angles = self getplayerangles();
        fwd = anglestoforward(angles);
        right = anglestoright(angles);
        up = anglestoup(angles);
        aimoffset = function_f9e2a36d(actionparams.aimpoint, eyes, fwd, right, up, self.bot.var_3cbdf005, 0);
        if (isdefined(aimoffset)) {
            self.bot.aimoffset = aimoffset;
        }
        var_e7cf4067 = function_f9e2a36d(actionparams.var_c5870f88, eyes, fwd, right, up, self.bot.var_3cbdf005, 1);
        if (isdefined(var_e7cf4067)) {
            self.bot.var_e7cf4067 = var_e7cf4067;
        }
        if (isdefined(aimoffset) || isdefined(var_e7cf4067)) {
            self.bot.var_3cbdf005 *= randomfloatrange(0.8, 0.9);
            self.bot.var_b5f9ea92 = gettime() + randomintrange(300, 600);
        }
    }
    actionparams.aimpoint += self.bot.aimoffset;
    actionparams.var_c5870f88 += self.bot.var_e7cf4067;
}

// Namespace bot_action/bot_action
// Params 7, eflags: 0x0
// Checksum 0xf68c7d3d, Offset: 0x89d8
// Size: 0x258
function function_f9e2a36d(var_906a278a, eyes, fwd, right, up, var_3cbdf005, close) {
    var_ba8bee4d = var_906a278a - eyes;
    var_c2e425a2 = vectornormalize(var_ba8bee4d);
    aimoffset = undefined;
    if (vectordot(fwd, var_c2e425a2) > 0.7) {
        var_c25d46e2 = min(var_3cbdf005, length(var_ba8bee4d) * 0.25);
        if (close) {
            var_c25d46e2 *= 0.5;
        }
        var_13923365 = var_c25d46e2 * 0.25;
        var_d34132b = var_c25d46e2;
        var_34e96d0e = vectordot(var_ba8bee4d, right) < 0;
        if (var_34e96d0e) {
            aimoffset = right * randomfloatrange(var_d34132b * -1, var_13923365);
        } else {
            aimoffset = right * randomfloatrange(var_13923365 * -1, var_d34132b);
        }
        var_f3edbc6f = vectordot(var_ba8bee4d, up) < 0;
        if (var_f3edbc6f) {
            aimoffset = (aimoffset[0], aimoffset[1], randomfloatrange(var_d34132b * -1, var_13923365) * 0.5);
        } else {
            aimoffset = (aimoffset[0], aimoffset[1], randomfloatrange(var_13923365 * -1, var_d34132b) * 0.5);
        }
    }
    return aimoffset;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x208c4d45, Offset: 0x8c38
// Size: 0xae
function function_40f48286(actionparams) {
    target = actionparams.target;
    if (!isentity(target)) {
        return;
    }
    subtargets = target_getsubtargets(target);
    if (subtargets[0] != 0) {
        actionparams.aimpoint = target_getorigin(target, subtargets[0]);
        return;
    }
    actionparams.aimpoint = target_getorigin(target);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x75c85329, Offset: 0x8cf0
// Size: 0x7e
function function_8b5bb921(actionparams) {
    aimpoint = actionparams.aimpoint;
    weapon = actionparams.weapon;
    if (isdefined(aimpoint) && isdefined(weapon)) {
        actionparams.var_7ac9e90b = self botgetprojectileaimangles(weapon, aimpoint);
        return;
    }
    actionparams.var_7ac9e90b = undefined;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xbcf37805, Offset: 0x8d78
// Size: 0x76
function function_a3ce67(actionparams) {
    aimpoint = actionparams.aimpoint;
    if (isdefined(aimpoint)) {
        actionparams.bullettrace = bullettrace(self geteye(), aimpoint, 1, self);
        return;
    }
    actionparams.bullettrace = undefined;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x1edd5097, Offset: 0x8df8
// Size: 0x86
function function_7e5f837a(actionparams) {
    var_7ac9e90b = actionparams.var_7ac9e90b;
    weapon = actionparams.weapon;
    if (isdefined(var_7ac9e90b) && isdefined(weapon)) {
        actionparams.var_3348176f = self function_c8794b18(weapon, var_7ac9e90b.var_6fbefb5d);
        return;
    }
    actionparams.var_3348176f = undefined;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x48bc50a4, Offset: 0x8e88
// Size: 0xd6
function is_target_visible(actionparams) {
    target = actionparams.target;
    if (!isdefined(target)) {
        return 0;
    }
    if (isentity(target)) {
        return (isalive(target) && self cansee(target, self.bot.tacbundle.var_f19c9f47));
    }
    if (isvec(target)) {
        return sighttracepassed(self geteye(), target, 1, self);
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x38edf6e6, Offset: 0x8f68
// Size: 0x58
function function_417d9dbe(actionparams) {
    target = actionparams.target;
    if (!isdefined(target)) {
        return false;
    }
    if (isplayer(target)) {
        return isdefined(target.revivetrigger);
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x1db72c96, Offset: 0x8fc8
// Size: 0x48
function is_target_enemy(actionparams) {
    target = actionparams.target;
    if (isvec(target)) {
        return true;
    }
    return self.enemy === target;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x69e3a5bc, Offset: 0x9018
// Size: 0x42
function function_b4606f4(actionparams) {
    target = actionparams.target;
    if (!isdefined(target)) {
        return 0;
    }
    return target_istarget(target);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x1134a101, Offset: 0x9068
// Size: 0x12a
function function_e5578b7f(actionparams) {
    target = actionparams.target;
    weapon = actionparams.weapon;
    if (!isdefined(target) || !isdefined(weapon)) {
        return false;
    }
    if (issentient(target) && self lastknowntime(target) + 5000 < gettime()) {
        return false;
    }
    targetorigin = isvec(target) ? target : target.origin;
    targetdistsq = distancesquared(self.origin, targetorigin);
    var_e0514d13 = self.bot.tacbundle.shortrange;
    return targetdistsq <= var_e0514d13 * var_e0514d13;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x6bb8af11, Offset: 0x91a0
// Size: 0xea
function function_25d08c02(actionparams) {
    target = actionparams.target;
    weapon = actionparams.weapon;
    if (!isdefined(target) || !isdefined(weapon)) {
        return false;
    }
    targetorigin = isvec(target) ? target : target.origin;
    targetdistsq = distancesquared(self.origin, targetorigin);
    var_84bfd0b0 = self.bot.tacbundle.maxrange;
    return targetdistsq <= var_84bfd0b0 * var_84bfd0b0;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x8f711f74, Offset: 0x9298
// Size: 0xe6
function function_61e908ed(actionparams, range) {
    target = actionparams.target;
    if (!isdefined(target)) {
        return false;
    }
    if (issentient(target) && self lastknowntime(target) + 5000 < gettime()) {
        return false;
    }
    targetorigin = isvec(target) ? target : target.origin;
    targetdistsq = distancesquared(self.origin, targetorigin);
    return targetdistsq <= range * range;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x6c58085a, Offset: 0x9388
// Size: 0xc4
function function_b70c570f(actionparams) {
    target = actionparams.target;
    bullettrace = actionparams.bullettrace;
    if (!isdefined(target) || !isdefined(bullettrace)) {
        return false;
    }
    if (isentity(target)) {
        return (target === bullettrace[#"entity"]);
    } else if (isvec(target)) {
        return (bullettrace[#"fraction"] >= 1);
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x6e570dc5, Offset: 0x9458
// Size: 0xdc
function function_ed41018(actionparams) {
    target = actionparams.target;
    var_3348176f = actionparams.var_3348176f;
    if (!isdefined(target) || !isdefined(var_3348176f)) {
        return false;
    }
    if (isentity(target)) {
        return (target === var_3348176f[#"entity"]);
    } else if (isvec(target)) {
        return (distancesquared(var_3348176f[#"position"], target) < 100);
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xfed6489a, Offset: 0x9540
// Size: 0x58
function aim_at_target(actionparams) {
    aimpoint = actionparams.aimpoint;
    if (!isdefined(aimpoint)) {
        return;
    }
    self look_at_point(aimpoint, "Aim", (1, 0, 0));
    return aimpoint;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x5080a8b1, Offset: 0x95a0
// Size: 0x58
function function_b69f54b(actionparams) {
    aimpoint = actionparams.var_c5870f88;
    if (!isdefined(aimpoint)) {
        return;
    }
    self look_at_point(aimpoint, "Aim", (1, 0, 0));
    return aimpoint;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x15936f55, Offset: 0x9600
// Size: 0xf4
function function_d3b4f42(actionparams) {
    var_7ac9e90b = actionparams.var_7ac9e90b;
    if (isdefined(var_7ac9e90b)) {
        self botsetlookangles(var_7ac9e90b.var_6fbefb5d);
    }
    /#
        if (self bot::should_record("<dev string:x505>") && isdefined(actionparams.aimpoint)) {
            recordsphere(actionparams.aimpoint, 4, (1, 0, 0), "<dev string:x3d>");
            record3dtext("<dev string:x514>", actionparams.aimpoint + (0, 0, 5), (1, 0, 0), "<dev string:x3d>", undefined, 0.5);
        }
    #/
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x890b0e49, Offset: 0x9700
// Size: 0x90
function function_c3d770a4(actionparams) {
    var_69dba1e5 = self haspath() ? self.bot.tacbundle.var_471e8e77 : self.bot.tacbundle.var_c62b6927;
    if (!isdefined(var_69dba1e5)) {
        var_69dba1e5 = 0;
    }
    return self botgetlookdot() >= var_69dba1e5;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xc4812f28, Offset: 0x9798
// Size: 0x68
function function_5e0e6587(actionparams) {
    var_664870d6 = isdefined(self.bot.tacbundle.var_664870d6) ? self.bot.tacbundle.var_664870d6 : 0;
    return self botgetlookdot() >= var_664870d6;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x3085d7ce, Offset: 0x9808
// Size: 0x68
function function_6881160c(actionparams) {
    var_11c31f62 = isdefined(self.bot.tacbundle.var_11c31f62) ? self.bot.tacbundle.var_11c31f62 : 0;
    return self botgetlookdot() >= var_11c31f62;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x164ba4eb, Offset: 0x9878
// Size: 0x2e
function get_max_health() {
    if (isvehicle(self)) {
        return self.healthdefault;
    }
    return self.maxhealth;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x64157107, Offset: 0x98b0
// Size: 0x1dc
function look_along_path() {
    var_fa4a2a4c = "Path";
    debugcolor = (1, 1, 1);
    var_9a1c37c1 = self function_28dbe634();
    if (isdefined(var_9a1c37c1) && isdefined(var_9a1c37c1.var_92706ab9)) {
        var_b2e7e1a8 = var_9a1c37c1.var_92706ab9;
        var_fa4a2a4c = "Corner";
        if (isdefined(var_9a1c37c1.var_ab761ebe)) {
            distsq = distance2dsquared(self.origin, var_b2e7e1a8);
            if (distsq < 4096) {
                var_b2e7e1a8 = var_9a1c37c1.var_ab761ebe;
                var_fa4a2a4c = "Next Corner";
            }
        }
        lookpoint = var_b2e7e1a8;
        debugcolor = (1, 1, 0);
    } else if (isdefined(self.overridegoalpos)) {
        lookpoint = self.overridegoalpos;
        var_fa4a2a4c = "Override Goal Pos";
        debugcolor = (1, 0, 1);
    } else {
        lookpoint = self.goalpos;
        var_fa4a2a4c = self.goalforced ? "Goal Pos (Forced)" : "Goal Pos";
        debugcolor = self.goalforced ? (0, 1, 1) : (0, 1, 0);
    }
    viewheight = self getplayerviewheight();
    lookpoint += (0, 0, viewheight);
    self look_at_point(lookpoint, var_fa4a2a4c, debugcolor);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xabc4faf7, Offset: 0x9a98
// Size: 0x23c
function function_38442e42(node) {
    var_15e215df = node.spawnflags & 262144;
    var_3dc95fa = node.spawnflags & 524288;
    if (!var_15e215df && !var_3dc95fa) {
        self botsetlookangles(node.angles);
        return;
    }
    noderight = anglestoright(node.angles);
    rotation = isfullcovernode(node) ? 20 : 45;
    if (var_15e215df && var_3dc95fa) {
        if (isfullcovernode(node)) {
            if (vectordot(noderight, self.origin - node.origin) >= 0) {
                rotation *= -1;
            }
        } else if (isdefined(self.enemylastseenpos)) {
            if (vectordot(noderight, self.enemylastseenpos - self.origin) >= 0) {
                rotation *= -1;
            }
        } else if (randomint(2) > 0) {
            rotation *= -1;
        }
    } else if (var_3dc95fa) {
        rotation *= -1;
    }
    lookangles = (node.angles[0], node.angles[1] + rotation, node.angles[2]);
    self botsetlookangles(lookangles);
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0x49740be9, Offset: 0x9ce0
// Size: 0xbc
function look_at_point(point, var_fa4a2a4c, debugcolor) {
    self botsetlookpoint(point);
    /#
        if (self bot::should_record("<dev string:x505>")) {
            recordsphere(point, 4, debugcolor, "<dev string:x3d>");
            record3dtext(var_fa4a2a4c, point + (0, 0, 5), debugcolor, "<dev string:x3d>", undefined, 0.5);
        }
    #/
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x8e986b31, Offset: 0x9da8
// Size: 0x54c
function function_5182cb26() {
    if (self haspath()) {
        self look_along_path();
        return;
    }
    if (isdefined(self.ignoreall) && self.ignoreall || isdefined(self.var_3644ec4) && self.var_3644ec4) {
        self function_97fae03a();
        return;
    }
    var_7f082716 = length(self getvelocity()) < 10 && (!isdefined(self.var_298d8451) || distancesquared(self.origin, self.var_298d8451) > 256);
    if (var_7f082716) {
        self.var_7132cc = undefined;
        self.var_298d8451 = self.origin;
        var_5aa1eed4 = getclosesttacpoint(self.origin);
        var_5aa1eed4.searched = 1;
        var_12ff1bc8 = [var_5aa1eed4];
        var_7b89bb53 = [var_5aa1eed4];
        var_83a91306 = [];
        var_d87bbbe8 = [];
        self.var_fffe83da = [];
        while (var_12ff1bc8.size > 0) {
            currentpoint = var_12ff1bc8[0];
            newpoints = function_a7c167d6(currentpoint);
            foreach (point in newpoints) {
                if (!(isdefined(point.searched) && point.searched)) {
                    point.searched = 1;
                    var_7b89bb53[var_7b89bb53.size] = point;
                    if (var_5aa1eed4.region != point.region) {
                        if (!array::contains(var_83a91306, currentpoint)) {
                            var_83a91306[var_83a91306.size] = currentpoint;
                        }
                        continue;
                    }
                    if (!function_c80ec59e(var_5aa1eed4, point.origin + (0, 0, 60))) {
                        if (!array::contains(var_d87bbbe8, currentpoint)) {
                            var_d87bbbe8[var_d87bbbe8.size] = currentpoint;
                        }
                        continue;
                    }
                    var_12ff1bc8[var_12ff1bc8.size] = point;
                }
            }
            var_12ff1bc8 = array::remove_index(var_12ff1bc8, 0);
        }
        foreach (point in var_7b89bb53) {
            point.searched = undefined;
        }
        self.var_fffe83da = arraycombine(var_83a91306, var_d87bbbe8, 0, 0);
    }
    if (isdefined(self.var_fffe83da) && self.var_fffe83da.size > 0) {
        if (!isdefined(self.var_7132cc) || !isdefined(self.var_b89575dd) || gettime() - self.var_b89575dd > 5000) {
            self.var_b89575dd = gettime();
            self.var_7132cc = array::random(self.var_fffe83da);
        }
    }
    if (isdefined(self.var_7132cc)) {
        viewheight = self getplayerviewheight();
        lookpoint = self.var_7132cc.origin + (0, 0, viewheight);
        var_fa4a2a4c = "Neighboring Region Entrance";
        debugcolor = (1, 0, 0);
        self look_at_point(lookpoint, var_fa4a2a4c, debugcolor);
        return;
    }
    node = self bot::get_position_node();
    if (isdefined(node)) {
        self function_38442e42(node);
        return;
    }
    self function_97fae03a();
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x47e4d026, Offset: 0xa300
// Size: 0x24
function function_97fae03a() {
    self botsetlookangles(self.angles);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x640ba261, Offset: 0xa330
// Size: 0xc
function function_28b0a79b() {
    return isdefined(self.enemylastseenpos);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x3a3a1e67, Offset: 0xa348
// Size: 0x48
function function_bfdb45e7(limit = 0) {
    return isdefined(self.enemylastseenpos) && isdefined(self.enemylastseentime) && gettime() < self.enemylastseentime + limit;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xe8963766, Offset: 0xa398
// Size: 0x32
function function_444016e7() {
    return sighttracepassed(self geteye(), self.enemylastseenpos, 0, self);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x40924ce2, Offset: 0xa3d8
// Size: 0x34
function function_50172422() {
    self look_at_point(self.enemylastseenpos, "EnemyLastSeenPos", (1, 0.5, 0));
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xdb00882d, Offset: 0xa418
// Size: 0xc
function function_d5f640c7() {
    return isdefined(self.var_e13b45f4);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xf9ec72a6, Offset: 0xa430
// Size: 0x34
function function_b07d5884() {
    self look_at_point(self.var_e13b45f4, "LikelyEnemyPosition", (1, 0.5, 0));
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xd4eb5da6, Offset: 0xa470
// Size: 0x44
function clip_ammo(weapon) {
    return self getweaponammoclip(weapon) + self getweaponammoclip(weapon.dualwieldweapon);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xc7b8d32, Offset: 0xa4c0
// Size: 0x24a
function function_a2af4bd4(actionparams) {
    if (self.ignoreall) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x1e9>";
        #/
        return undefined;
    }
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x523>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x545>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x1a379b30, Offset: 0xa718
// Size: 0x2fa
function function_1ed83677(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x523>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x545>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x1a9>";
        #/
        return undefined;
    }
    if (!isdefined(self.enemy)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x556>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x46091058, Offset: 0xaa20
// Size: 0x25a
function function_dcf6e9c8(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x523>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x545>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x55f>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x4e15b862, Offset: 0xac88
// Size: 0x82
function function_56ed213a(weapon) {
    slot = self gadgetgetslot(weapon);
    button = self function_628f19f9(weapon);
    if (!isdefined(button)) {
        return;
    }
    self bottapbutton(button);
    self waittill(#"hash_347a612b61067eb3");
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x64cb86c5, Offset: 0xad18
// Size: 0xb2
function function_ae33d394(weapon) {
    slot = self gadgetgetslot(weapon);
    button = self function_628f19f9(weapon);
    if (!isdefined(button)) {
        return;
    }
    self botswitchtoweapon(weapon);
    self waittill(#"hash_347a612b61067eb3");
    self bottapbutton(button);
    self waittill(#"hash_347a612b61067eb3");
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xa78b09b1, Offset: 0xadd8
// Size: 0x9a
function function_6e41259d(weapon) {
    slot = self gadgetgetslot(weapon);
    button = self function_628f19f9(weapon);
    if (!isdefined(button)) {
        return;
    }
    self bottapbutton(button);
    self botswitchtoweapon(weapon);
    self waittill(#"hash_347a612b61067eb3");
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x3da1cef4, Offset: 0xae80
// Size: 0xf6
function test_gadget(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x585>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self function_a5d700ec(weapon);
    while (self isthrowinggrenade() || !self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x43112d99, Offset: 0xaf80
// Size: 0xac
function function_70df76df(slot) {
    switch (slot) {
    case 0:
        return self ai::get_behavior_attribute("allowprimaryoffhand");
    case 1:
        return self ai::get_behavior_attribute("allowsecondaryoffhand");
    case 2:
        return self ai::get_behavior_attribute("allowspecialoffhand");
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x1516a15c, Offset: 0xb038
// Size: 0x22
function function_b211d748() {
    return self ai::get_behavior_attribute("allowscorestreak");
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xcecaa2d5, Offset: 0xb068
// Size: 0x3a
function function_d68a136d(weapon) {
    self botswitchtoweapon(weapon);
    self waittill(#"hash_347a612b61067eb3");
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x2494992b, Offset: 0xb0b0
// Size: 0x6e
function function_795fbbe2(weapon) {
    activatefunc = weapon.rootweapon.var_8152d86b;
    if (!isdefined(activatefunc)) {
        /#
            self botprinterror(weapon.name + "<dev string:x49c>");
        #/
        return;
    }
    self [[ activatefunc ]](weapon);
}

