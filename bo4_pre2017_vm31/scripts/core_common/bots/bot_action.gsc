#using scripts/core_common/ai_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/dialog_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/utility_eval;
#using scripts/core_common/values_shared;

#namespace bot_action;

// Namespace bot_action/bot_action
// Params 0, eflags: 0x2
// Checksum 0x19a1f7c8, Offset: 0x8f8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("bot_action", &__init__, undefined, undefined);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x36696f3e, Offset: 0x938
// Size: 0x4fc
function __init__() {
    level.botactions = [];
    level.botweapons = [];
    register_action("use_objective_gameobject", &rank_priority, &use_objective_gameobject_weight, &use_objective_gameobject);
    register_action("revive_player", &rank_priority, &revive_player_weight, &revive_player);
    register_action("melee_enemy", &current_melee_weapon_rank, &melee_enemy_weight, &melee_enemy);
    register_action("reload_weapon", &current_weapon_rank, &reload_weapon_weight, &reload_weapon);
    register_action("scan_for_threats", &current_weapon_rank, &scan_for_threats_weight, &scan_for_threats);
    register_action("look_for_enemy", &current_weapon_rank, &look_for_enemy_weight, &look_for_enemy);
    register_action("look_helplessly_at_enemy", &current_weapon_rank, &look_helplessly_at_enemy_weight, &look_helplessly_at_enemy);
    register_action("scripted_node_pose", &current_weapon_rank, &scripted_node_pose_weight, &scripted_node_pose);
    register_action("shoot_bulletweapon_at_enemy", &weapon_rank, &shoot_bulletweapon_at_enemy_weight, &shoot_bulletweapon_at_enemy);
    register_action("shoot_grenadeweapon_at_enemy", &weapon_rank, &shoot_bulletweapon_at_enemy_weight, &shoot_grenadeweapon_at_enemy);
    register_action("shoot_lockon_rocketlauncher_at_enemy", &weapon_rank, &shoot_lockon_rocketlauncher_at_enemy_weight, &shoot_lockon_rocketlauncher_at_enemy);
    register_action("shoot_rocketlauncher_at_enemy", &weapon_rank, &shoot_rocketlauncher_at_enemy_weight, &shoot_rocketlauncher_at_enemy);
    register_action("activate_charged_gadget", &rank_idle, &activate_charged_gadget_weight, &activate_charged_gadget);
    register_action("battery_blitz", &rank_priority, &battery_blitz_weight, &battery_blitz);
    register_action("ruin_stuff", &rank_priority, &ruin_stuff_weight, &ruin_stuff);
    register_action("bleed_out", &rank_priority, &bleed_out_weight, &bleed_out);
    register_action("switch_to_weapon", &best_stowed_primary_weapon_rank, &switch_to_weapon_weight, &switch_to_weapon);
    thread register_weapons();
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xb7fca13f, Offset: 0xe40
// Size: 0xcf4
function register_weapons() {
    waitframe(1);
    register_weapon("ar_accurate", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("ar_cqb", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("ar_damage", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("ar_fastburst", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("ar_longburst", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("ar_marksman", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("ar_standard", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("lmg_cqb", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("lmg_heavy", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("lmg_light", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("lmg_slowfire", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("pistol_burst", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("pistol_fullauto", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("pistol_standard", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("shotgun_fullauto", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("shotgun_precision", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("shotgun_pump", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("shotgun_semiauto", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("smg_burst", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("smg_capactiy", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("smg_fastfire", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("smg_longrange", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("smg_standard", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("smg_versatile", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("sniper_chargeshot", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("sniper_fastbolt", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("sniper_fastsemi", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("sniper_powerbolt", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon("knife_held", &rank_meleewapon_against_enemy, &rank_weapon_idle);
    register_weapon("knife_loadout", &rank_meleewapon_against_enemy, &rank_weapon_idle);
    register_weapon("launcher_standard", &rank_rocketlauncher_against_enemy, &rank_weapon_idle);
    register_weapon("launcher_standard", &rank_rocketlauncher_against_enemy, &rank_weapon_idle);
    register_weapon("hero_annihilator", &rank_heavyweapon_against_enemy, &rank_weapon_idle);
    register_weapon("hero_pineapplegun_companion", &rank_heavyweapon_against_enemy, &rank_weapon_idle);
    register_weapon("noweapon", &rank_terrible_weapon_enemy, &rank_terrible_weapon_idle);
    register_weapon("knife_loadout", &rank_terrible_weapon_enemy, &rank_terrible_weapon_idle);
    register_weapon("knife_held", &rank_terrible_weapon_enemy, &rank_terrible_weapon_idle);
    register_weapon("bare_hands", &rank_terrible_weapon_enemy, &rank_terrible_weapon_idle);
    register_weapon("pistol_revolver38", &rank_bulletweapon_against_enemy, &rank_weapon_idle);
    register_weapon_action("ar_accurate", "shoot_bulletweapon_at_enemy");
    register_weapon_action("ar_cqb", "shoot_bulletweapon_at_enemy");
    register_weapon_action("ar_damage", "shoot_bulletweapon_at_enemy");
    register_weapon_action("ar_fastburst", "shoot_bulletweapon_at_enemy");
    register_weapon_action("ar_longburst", "shoot_bulletweapon_at_enemy");
    register_weapon_action("ar_marksman", "shoot_bulletweapon_at_enemy");
    register_weapon_action("ar_standard", "shoot_bulletweapon_at_enemy");
    register_weapon_action("lmg_cqb", "shoot_bulletweapon_at_enemy");
    register_weapon_action("lmg_heavy", "shoot_bulletweapon_at_enemy");
    register_weapon_action("lmg_light", "shoot_bulletweapon_at_enemy");
    register_weapon_action("lmg_slowfire", "shoot_bulletweapon_at_enemy");
    register_weapon_action("pistol_burst", "shoot_bulletweapon_at_enemy");
    register_weapon_action("pistol_fullauto", "shoot_bulletweapon_at_enemy");
    register_weapon_action("pistol_standard", "shoot_bulletweapon_at_enemy");
    register_weapon_action("shotgun_fullauto", "shoot_bulletweapon_at_enemy");
    register_weapon_action("shotgun_precision", "shoot_bulletweapon_at_enemy");
    register_weapon_action("shotgun_pump", "shoot_bulletweapon_at_enemy");
    register_weapon_action("shotgun_semiauto", "shoot_bulletweapon_at_enemy");
    register_weapon_action("smg_burst", "shoot_bulletweapon_at_enemy");
    register_weapon_action("smg_capactiy", "shoot_bulletweapon_at_enemy");
    register_weapon_action("smg_fastfire", "shoot_bulletweapon_at_enemy");
    register_weapon_action("smg_longrange", "shoot_bulletweapon_at_enemy");
    register_weapon_action("smg_standard", "shoot_bulletweapon_at_enemy");
    register_weapon_action("smg_versatile", "shoot_bulletweapon_at_enemy");
    register_weapon_action("sniper_chargeshot", "shoot_bulletweapon_at_enemy");
    register_weapon_action("sniper_fastbolt", "shoot_bulletweapon_at_enemy");
    register_weapon_action("sniper_fastsemi", "shoot_bulletweapon_at_enemy");
    register_weapon_action("sniper_powerbolt", "shoot_bulletweapon_at_enemy");
    register_weapon_action("knife_held", "melee_enemy");
    register_weapon_action("knife_loadout", "melee_enemy");
    register_weapon_action("launcher_standard", "shoot_lockon_rocketlauncher_at_enemy");
    register_weapon_action("launcher_standard", "shoot_rocketlauncher_at_enemy");
    register_weapon_action("hero_annihilator", "shoot_bulletweapon_at_enemy");
    register_weapon_action("hero_pineapplegun_companion", "shoot_grenadeweapon_at_enemy");
    register_weapon_action("pistol_revolver38", "shoot_bulletweapon_at_enemy");
}

// Namespace bot_action/bot_action
// Params 4, eflags: 0x0
// Checksum 0xb0db29d1, Offset: 0x1b40
// Size: 0x66
function register_action(name, rankfunc, weightfunc, executefunc) {
    action = create_action(name, rankfunc, weightfunc, executefunc);
    level.botactions[name] = action;
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0xef8913d5, Offset: 0x1bb0
// Size: 0x8e
function register_weapon(weaponname, enemyRankFunc, idlerankfunc) {
    weapon = getweapon(weaponname);
    if (weapon == level.weaponnone) {
        return;
    }
    level.botweapons[weapon] = {#enemyRankFunc:enemyRankFunc, #idlerankfunc:idlerankfunc, #actions:[]};
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xe0000cc4, Offset: 0x1c48
// Size: 0xbe
function register_weapon_action(weaponname, actionname) {
    weapon = getweapon(weaponname);
    if (weapon == level.weaponnone) {
        return;
    }
    action = get_action(actionname);
    if (!isdefined(actionname)) {
        return;
    }
    botweapon = level.botweapons[weapon];
    botweapon.actions[botweapon.actions.size] = action;
}

// Namespace bot_action/bot_action
// Params 4, eflags: 0x0
// Checksum 0x3217e001, Offset: 0x1d10
// Size: 0x94
function create_action(name, rankfunc, weightfunc, executefunc) {
    action = spawnstruct();
    action.name = name;
    action.rankfunc = rankfunc;
    action.weightfunc = weightfunc;
    action.executefunc = executefunc;
    return action;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xc8b1d002, Offset: 0x1db0
// Size: 0x1c
function get_action(name) {
    return level.botactions[name];
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xda1b1c2c, Offset: 0x1dd8
// Size: 0x146
function add_weapon_actions(weapon, &actions) {
    botweapon = level.botweapons[weapon.rootweapon];
    if (!isdefined(botweapon)) {
        return;
    }
    foreach (action in botweapon.actions) {
        actions[actions.size] = action;
        self.botactionutility[action.name] = spawnstruct();
        self.botactionutility[action.name].weapon = weapon;
        /#
            self.botactionutility[action.name].debug = [];
        #/
    }
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0x7b3f2d2b, Offset: 0x1f28
// Size: 0x184
function execute_current_action() {
    if (!isdefined(self.currentaction)) {
        self botprintwarning("Chose no action");
        wait 0.5;
        return;
    }
    self thread action_timeout();
    executetime = gettime();
    actionname = self bot::get_action_name();
    action = get_action(actionname);
    actionutility = self.botactionutility[actionname];
    self [[ action.executefunc ]](actionutility.weapon, actionutility.enemy);
    self notify(#"bot_action_done");
    finishtime = gettime();
    if (executetime == finishtime) {
        self botprinterror("Action " + self bot::get_action_name() + " executed in 0ms ");
        wait 0.5;
    }
    self.currentaction = undefined;
    self bot::set_action_name(undefined);
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xb5a04f75, Offset: 0x20b8
// Size: 0x7c
function action_timeout() {
    self endon(#"death");
    self endon(#"bot_action_done");
    level endon(#"game_ended");
    wait 10;
    self botprintwarning("Action " + self bot::get_action_name() + " ran longer than 10s");
    self cancel_action();
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xc3a9423f, Offset: 0x2140
// Size: 0x348
function add_loadout_actions(&actions) {
    currentweapon = self getcurrentweapon();
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        rank_weapon(weapon);
        if (weapon == currentweapon) {
            if (weapon.isprimary) {
                add_weapon_actions(weapon, actions);
            } else if (weapon.isheavyweapon && weapon.offhandslot == "None" && weapon.weaponholdmode == "wield") {
                add_weapon_actions(weapon, actions);
            }
            continue;
        }
        if (weapon.offhandslot != "None" || weapon.weaponholdmode != "wield") {
            add_weapon_actions(weapon, actions);
        }
    }
    if (level.gametype === "pvp" && self util::is_companion()) {
        bodytypeindex = self getcharacterbodytype();
        if (bodytypeindex == 5) {
            action = get_action("battery_blitz");
            actions[actions.size] = action;
            self.botactionutility[action.name] = spawnstruct();
            /#
                self.botactionutility[action.name].debug = [];
            #/
        } else if (bodytypeindex == 2) {
            action = get_action("ruin_stuff");
            actions[actions.size] = action;
            self.botactionutility[action.name] = spawnstruct();
            /#
                self.botactionutility[action.name].debug = [];
            #/
        }
    }
    return actions;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x2df9133, Offset: 0x2490
// Size: 0x15c
function add_state_actions(tacbundle, &actions) {
    if (!isdefined(tacbundle.actionlist)) {
        return;
    }
    for (i = 0; i < tacbundle.actionlist.size; i++) {
        if (!isdefined(tacbundle.actionlist[i])) {
            continue;
        }
        actionname = tacbundle.actionlist[i].name;
        if (!isdefined(actionname)) {
            continue;
        }
        action = get_action(actionname);
        if (!isdefined(action)) {
            self botprinterror("Could not find action: " + actionname);
            continue;
        }
        self.botactionutility[actionname] = spawnstruct();
        /#
            self.botactionutility[actionname].debug = [];
        #/
        actions[actions.size] = action;
    }
    return actions;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xcf071f2, Offset: 0x25f8
// Size: 0x12
function cancel_action() {
    self notify(#"bot_cancel_action");
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x2af88677, Offset: 0x2618
// Size: 0x5c4
function pick_action(tacbundle) {
    self.botweaponranks = [];
    self.botactionutility = [];
    /#
        self.botweaponranksdebug = [];
    #/
    actions = [];
    self add_loadout_actions(actions);
    self add_state_actions(tacbundle, actions);
    pixbeginevent("bot_pick_action");
    aiprofile_beginentry("bot_pick_action");
    self rank_actions(actions, tacbundle);
    bestaction = self weight_actions(actions, tacbundle);
    pixendevent();
    aiprofile_endentry();
    /#
        if (self bot::should_record("<dev string:x28>")) {
            pixbeginevent("<dev string:x3d>");
            aiprofile_beginentry("<dev string:x3d>");
            if (isdefined(bestaction)) {
                bestactionutility = self.botactionutility[bestaction.name];
            }
            foreach (action in actions) {
                color = (0.75, 0.75, 0.75);
                headerstr = "<dev string:x54>";
                recordrank = "<dev string:x54>";
                recordweight = "<dev string:x54>";
                actionutility = self.botactionutility[action.name];
                if (isdefined(actionutility.rank)) {
                    recordrank = actionutility.rank;
                    if (isdefined(actionutility.weight)) {
                        color = (1, 1, 1);
                        headerstr = "<dev string:x56>";
                        recordweight = actionutility.weight;
                        if (isdefined(bestaction)) {
                            if (actionutility.rank >= bestactionutility.rank) {
                                color = utility_eval::utility_color(actionutility.weight, 100);
                                headerstr = action == bestaction ? "<dev string:x58>" : "<dev string:x5a>";
                            }
                        }
                    }
                }
                record3dtext(headerstr + action.name + "<dev string:x5c>" + recordrank + "<dev string:x5f>" + recordweight, self.origin, color, "<dev string:x62>", self, 0.5);
                if (isdefined(actionutility.weapon) && isdefined(self.botweaponranksdebug[actionutility.weapon])) {
                    foreach (str in self.botweaponranksdebug[actionutility.weapon]) {
                        record3dtext("<dev string:x69>" + str, self.origin, color, "<dev string:x62>", self, 0.5);
                    }
                }
                foreach (entry in actionutility.debug) {
                    record3dtext("<dev string:x69>" + entry, self.origin, color, "<dev string:x62>", self, 0.5);
                }
            }
            pixendevent();
            aiprofile_endentry();
        }
    #/
    if (isdefined(bestaction)) {
        self.currentaction = bestaction;
        self bot::set_action_name(bestaction.name);
        return true;
    }
    return false;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xc77339f0, Offset: 0x2be8
// Size: 0x290
function weight_actions(&actions, tacbundle) {
    pixbeginevent("bot_weight_actions");
    aiprofile_beginentry("bot_weight_actions");
    bestaction = undefined;
    bestrank = undefined;
    bestweight = undefined;
    foreach (action in actions) {
        actionutility = self.botactionutility[action.name];
        if (!isdefined(actionutility.rank)) {
            continue;
        }
        pixbeginevent("bot_weight_" + action.name);
        aiprofile_beginentry("bot_weight_" + action.name);
        actionutility.weight = self [[ action.weightfunc ]](actionutility, tacbundle);
        pixendevent();
        aiprofile_endentry();
        if (!isdefined(actionutility.weight)) {
            continue;
        }
        if (isdefined(bestaction) && actionutility.rank < bestrank) {
            continue;
        }
        if (!isdefined(bestaction) || actionutility.rank > bestrank || actionutility.weight > bestweight) {
            bestaction = action;
            bestrank = actionutility.rank;
            bestweight = actionutility.weight;
        }
    }
    pixendevent();
    aiprofile_endentry();
    return bestaction;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x7a64de9c, Offset: 0x2e80
// Size: 0x194
function rank_actions(&actions, tacbundle) {
    pixbeginevent("bot_rank_actions");
    aiprofile_beginentry("bot_rank_actions");
    foreach (action in actions) {
        pixbeginevent("bot_rank_" + action.name);
        aiprofile_beginentry("bot_rank_" + action.name);
        actionutility = self.botactionutility[action.name];
        actionutility.rank = self [[ action.rankfunc ]](actionutility, tacbundle);
        pixendevent();
        aiprofile_endentry();
    }
    pixendevent();
    aiprofile_endentry();
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x1b53fcbb, Offset: 0x3020
// Size: 0x16
function rank_idle(actionutility, tacbundle) {
    return false;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x1aba84ca, Offset: 0x3040
// Size: 0x18
function rank_priority(actionutility, tacbundle) {
    return 1000;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x7c100da8, Offset: 0x3060
// Size: 0x18
function rank_terrible(actionutility, tacbundle) {
    return -1000;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x203d6c65, Offset: 0x3080
// Size: 0x112
function current_melee_weapon_rank(actionutility, tacbundle) {
    weapon = self getcurrentweapon();
    actionutility.weapon = weapon;
    if (!weapon.ismeleeweapon) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = weapon.name + "<dev string:x6d>";
        #/
        return undefined;
    }
    return 1000;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xc967b72b, Offset: 0x31a0
// Size: 0x82
function current_weapon_rank(actionutility, tacbundle) {
    weapon = self getcurrentweapon();
    actionutility.weapon = weapon;
    if (weapon == level.weaponnone) {
        return -1000;
    }
    return weapon_rank(actionutility, tacbundle);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x32e04579, Offset: 0x3230
// Size: 0x222
function best_stowed_primary_weapon_rank(actionutility, tacbundle) {
    currentweapon = self getcurrentweapon();
    weapons = self getweaponslistprimaries();
    bestweapon = undefined;
    bestweaponrank = undefined;
    foreach (weapon in weapons) {
        if (weapon == currentweapon) {
            continue;
        }
        weaponrank = self.botweaponranks[weapon];
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
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x81>";
        #/
        return undefined;
    }
    actionutility.weapon = bestweapon;
    return weapon_rank(actionutility, tacbundle);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xef019c67, Offset: 0x3460
// Size: 0x58
function weapon_rank(actionutility, tacbundle) {
    weapon = actionutility.weapon;
    if (!isdefined(self.botweaponranks[weapon])) {
        return undefined;
    }
    return self.botweaponranks[weapon];
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xd9e08901, Offset: 0x34c0
// Size: 0xc0
function rank_weapon(weapon) {
    botweapon = level.botweapons[weapon.rootweapon];
    if (!isdefined(botweapon)) {
        return;
    }
    if (self bot::has_visible_enemy()) {
        if (isdefined(botweapon.enemyRankFunc)) {
            self [[ botweapon.enemyRankFunc ]](weapon, self.enemy);
        }
        return;
    }
    if (isdefined(botweapon.idlerankfunc)) {
        self [[ botweapon.idlerankfunc ]](weapon);
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xf41e817c, Offset: 0x3588
// Size: 0x34
function rank_meleewapon_against_enemy(weapon, enemy) {
    self set_weapon_rank(weapon, -1000);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x21296ad6, Offset: 0x35c8
// Size: 0x3c
function rank_terrible_weapon_enemy(weapon, enemy) {
    self set_weapon_rank(weapon, -1000, "This weapon is terrible");
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x3bb9da1a, Offset: 0x3610
// Size: 0x5c
function rank_bulletweapon_against_enemy(weapon, enemy) {
    self set_weapon_rank(weapon, 1);
    self factor_damage_range(weapon, enemy.origin);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x3ded0620, Offset: 0x3678
// Size: 0xcc
function rank_rocketlauncher_against_enemy(weapon, enemy) {
    if (!self use_launchers(weapon)) {
        return;
    }
    self set_weapon_rank(weapon, 0);
    self factor_lockon(weapon, enemy);
    self factor_dumbfire_range(weapon, enemy.origin);
    self factor_rocketlauncher_overkill(weapon, enemy);
    self factor_ammo(weapon);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x52f783a2, Offset: 0x3750
// Size: 0x10c
function use_launchers(weapon) {
    uselaunchers = getdvarstring("bot_useLaunchers", "dopplebot");
    if (uselaunchers == "dopplebot") {
        if (self iscompanion()) {
            self set_weapon_rank(weapon, undefined, "Not a player bot");
            return false;
        }
    } else if (uselaunchers == "companion") {
        if (!self iscompanion()) {
            self set_weapon_rank(weapon, undefined, "Not a companion");
            return false;
        }
    } else if (uselaunchers != "all") {
        self set_weapon_rank(weapon, undefined, "Launchers forbidden");
        return false;
    }
    return true;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xf24a7f68, Offset: 0x3868
// Size: 0x4c
function rank_heavyweapon_against_enemy(weapon, enemy) {
    self set_weapon_rank(weapon, 1000);
    self factor_ammo(weapon);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x970fefda, Offset: 0x38c0
// Size: 0x34
function rank_terrible_weapon_idle(weapon) {
    self set_weapon_rank(weapon, -1000, "This weapon is terrible");
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x54f78721, Offset: 0x3900
// Size: 0x272
function rank_weapon_idle(weapon) {
    if (weapon.isheavyweapon) {
        self set_weapon_rank(weapon, 1000, "Heavy Weapon");
        self factor_ammo(weapon);
        return;
    }
    if (weapon.isabilityweapon) {
        self set_weapon_rank(weapon, 1000, "Ability Weapon");
        self factor_ammo(weapon);
        return;
    }
    switch (weapon.weapclass) {
    case #"mg":
        self set_weapon_rank(weapon, 6, "Machine Gun");
        break;
    case #"rifle":
        self set_weapon_rank(weapon, 5, "Rifle");
        break;
    case #"spread":
        self set_weapon_rank(weapon, 4, "Shotgun");
        break;
    case #"smg":
        self set_weapon_rank(weapon, 3, "Submachine Gun");
        break;
    case #"pistol":
    case #"hash_ae7987cd":
        self set_weapon_rank(weapon, 2, "Pistol");
        break;
    case #"rocketlauncher":
        if (self use_launchers(weapon)) {
            self set_weapon_rank(weapon, 1, "Rocket Launcher");
        }
        break;
    case #"melee":
        self set_weapon_rank(weapon, 0, "Melee");
        break;
    default:
        self set_weapon_rank(weapon, undefined, "Unrankable");
        break;
    }
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0xe102b937, Offset: 0x3b80
// Size: 0xd4
function set_weapon_rank(weapon, rank, reason) {
    self.botweaponranks[weapon] = rank;
    /#
        rankstr = isdefined(rank) ? rank : "<dev string:x54>";
        self.botweaponranksdebug[weapon] = array(weapon.name + "<dev string:x5c>" + rankstr);
        if (isdefined(reason)) {
            self.botweaponranksdebug[weapon][self.botweaponranksdebug[weapon].size] = "<dev string:x9b>" + reason;
        }
    #/
}

// Namespace bot_action/bot_action
// Params 3, eflags: 0x0
// Checksum 0xe34d091a, Offset: 0x3c60
// Size: 0xd0
function modify_weapon_rank(weapon, amount, reason) {
    if (!isdefined(self.botweaponranks[weapon])) {
        return;
    }
    self.botweaponranks[weapon] = self.botweaponranks[weapon] + amount;
    sign = amount > 0 ? "+" : "";
    /#
        self.botweaponranksdebug[weapon][self.botweaponranksdebug[weapon].size] = "<dev string:x9b>" + sign + amount + "<dev string:x5a>" + reason;
    #/
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xbae32e06, Offset: 0x3d38
// Size: 0xc4
function factor_ammo(weapon) {
    clipammo = self clip_ammo(weapon);
    stockammo = self getweaponammostock(weapon);
    if (clipammo + stockammo <= 0) {
        if (weapon.isheavyweapon) {
            self set_weapon_rank(weapon, undefined, "No ammo");
            return;
        }
        self set_weapon_rank(weapon, -1000, "No ammo");
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x50e73628, Offset: 0x3e08
// Size: 0xdc
function factor_damage_range(weapon, point) {
    distsq = distancesquared(self.origin, point);
    if (distsq < weapon.maxdamagerange * weapon.maxdamagerange) {
        self modify_weapon_rank(weapon, 1, "In max damage range");
        return;
    }
    if (distsq > weapon.mindamagerange * weapon.mindamagerange) {
        self modify_weapon_rank(weapon, -1, "In min damage range");
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x963fac5f, Offset: 0x3ef0
// Size: 0xa4
function factor_lockon(weapon, enemy) {
    if (target_istarget(enemy)) {
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
// Checksum 0xb332c796, Offset: 0x3fa0
// Size: 0x9c
function factor_dumbfire_range(weapon, point) {
    distsq = distancesquared(self.origin, point);
    if (distsq < 2250000) {
        self modify_weapon_rank(weapon, 1, "In Dumbfire Range");
        return;
    }
    self modify_weapon_rank(weapon, -1, "Outside Dumbfire Range");
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x6bd6d3ae, Offset: 0x4048
// Size: 0xec
function factor_rocketlauncher_overkill(weapon, enemy) {
    enemymaxhealth = self.enemy get_max_health();
    if (!isdefined(enemymaxhealth)) {
        self set_weapon_rank(weapon, undefined, "Max Health is undefined");
        return;
    }
    if (enemymaxhealth >= 400) {
        self modify_weapon_rank(weapon, 2, "Enemy Max Health " + enemymaxhealth + " >= " + 400);
        return;
    }
    self modify_weapon_rank(weapon, -1, "Enemy Max Health " + enemymaxhealth + " < " + 400);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xf2026fd6, Offset: 0x4140
// Size: 0x34
function scan_for_threats_weight(actionutility, tacbundle) {
    if (self set_visible_enemy(actionutility)) {
        return undefined;
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xe5d8257e, Offset: 0x4180
// Size: 0xbe
function scan_for_threats(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start", #"bot_goal_reached");
    level endon(#"game_ended");
    endtime = gettime() + randomintrange(1000, 3000);
    while (!self bot::has_visible_enemy()) {
        self look_along_path();
        waitframe(1);
        if (gettime() > endtime) {
            break;
        }
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x1f045e9e, Offset: 0x4248
// Size: 0x1dc
function scripted_node_pose_weight(actionutility, tacbundle) {
    if (self set_visible_enemy(actionutility)) {
        return undefined;
    }
    if (self haspath()) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x9e>";
        #/
        return undefined;
    }
    pathnode = self bot::get_position_node();
    actionutility.pathnode = pathnode;
    if (!isdefined(pathnode) || pathnode.type != "Scripted") {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:xad>";
        #/
        return undefined;
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xff76b36e, Offset: 0x4430
// Size: 0x16c
function scripted_node_pose(weapon, enemy) {
    self endoncallback(&end_scripted_node_pose, #"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    self setlowready(1);
    pathnode = self bot::get_position_node();
    if (!isdefined(pathnode)) {
        waitframe(1);
        self end_scripted_node_pose(undefined);
        return;
    }
    self botsetlookangles(pathnode.angles);
    endtime = gettime() + randomintrange(1000, 3000);
    while (!self bot::has_visible_enemy() && !self haspath()) {
        waitframe(1);
        if (gettime() > endtime) {
            break;
        }
    }
    self end_scripted_node_pose(undefined);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x5e3a866b, Offset: 0x45a8
// Size: 0x24
function end_scripted_node_pose(notifyhash) {
    self setlowready(0);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x3727ad9e, Offset: 0x45d8
// Size: 0x18c
function look_for_enemy_weight(actionutility, tacbundle) {
    if (!self bot::has_active_enemy()) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:xc2>";
        #/
        return undefined;
    }
    if (self bot::enemy_is_visible(self.enemy)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:xd2>";
        #/
        return undefined;
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xac1fca6d, Offset: 0x4770
// Size: 0x11c
function look_for_enemy(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    endtime = gettime() + randomintrange(1000, 3000);
    while (!self bot::has_visible_enemy() && isdefined(self.enemylastseenpos)) {
        self botsetlookpoint(self.enemylastseenpos);
        /#
            if (self bot::should_record("<dev string:xe0>")) {
                recordsphere(self.enemylastseenpos, 4, (1, 0, 0), "<dev string:xf1>", self);
            }
        #/
        waitframe(1);
        if (gettime() > endtime) {
            return;
        }
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x65f26d1b, Offset: 0x4898
// Size: 0x316
function use_objective_gameobject_weight(actionutility, tacbundle) {
    objective = bot::get_objective();
    if (!isdefined(objective)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:xf8>";
        #/
        return undefined;
    }
    actionutility.objective = objective;
    if (!self can_use_gameobject(objective)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x10e>";
        #/
        return undefined;
    }
    if (self haspath()) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x12d>";
        #/
        return undefined;
    }
    if (!self istouching(objective.trigger)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x139>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xa1cfb91d, Offset: 0x4bb8
// Size: 0x42c
function use_objective_gameobject(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action");
    level endon(#"game_ended");
    objective = self bot::get_objective();
    lookpoint = undefined;
    lookpoint = objective.trigger.origin;
    while (self can_use_gameobject(objective) && self istouching(objective.trigger) && objective === self bot::get_objective()) {
        self botsetlookpoint(lookpoint);
        if (self botgetlookdot() >= 0.76) {
            self botsetlookcurrent();
            break;
        }
        waitframe(1);
    }
    while (self can_use_gameobject(objective) && self istouching(objective.trigger) && objective === self bot::get_objective() && !isdefined(self.claimtrigger)) {
        self bottapbutton(3);
        waitframe(1);
    }
    while (self can_use_gameobject(objective) && self istouching(objective.trigger) && objective === self bot::get_objective() && isdefined(self.claimtrigger)) {
        self bottapbutton(3);
        waitframe(1);
    }
    if (!isdefined(objective)) {
        return;
    }
    if (objective.identifier === "mobile_armory") {
        waitframe(1);
        self bot::menu_cancel("menu_changeclass");
        waitframe(1);
    } else if (isdefined(objective.is_cryptopad) && objective === self bot::get_objective() && objective.is_cryptopad) {
        waitframe(1);
        while (isdefined(self.cryptopad_active) && self.cryptopad_active) {
            waitresult = self waittill("cryptopad_button_ready");
            if (!isdefined(waitresult.button_bit)) {
                self bottapbutton(62);
                break;
            }
            self bottapbutton(waitresult.button_bit);
            waitresult.progress++;
            if (waitresult.progress >= waitresult.button_count) {
                break;
            }
        }
        while (isdefined(self.cryptopad_active) && self.cryptopad_active) {
            waitframe(1);
        }
    }
    if (isdefined(objective) && objective === self bot::get_objective()) {
        self bot::clear_objective();
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xdf85b267, Offset: 0x4ff0
// Size: 0x268
function revive_player_weight(actionutility, tacbundle) {
    revivetarget = self bot::get_revive_target();
    if (!isdefined(revivetarget)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x14e>";
        #/
        return undefined;
    }
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x15f>" + revivetarget.name;
    #/
    if (!self istouching(revivetarget.revivetrigger)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x139>";
        #/
        return undefined;
    }
    actionutility.player = revivetarget;
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x1c19ad5a, Offset: 0x5260
// Size: 0x27e
function revive_player(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    player = self bot::get_revive_target();
    reviving = 0;
    while (isalive(player) && isdefined(player.revivetrigger) && self istouching(player.revivetrigger)) {
        if (isdefined(player.revivetrigger.beingrevived) && player.revivetrigger.beingrevived) {
            return;
        }
        self botsetlookpoint(player.origin);
        if (self botgetlookdot() >= 0.76) {
            self botsetlookcurrent();
            self.overridepos = self.origin;
            break;
        }
        waitframe(1);
    }
    cooldown = "revive_vo_" + self.team;
    if (level util::iscooldownready(cooldown)) {
        dialog_flag_team = 1;
        self dialog_shared::play_dialog("revive", dialog_flag_team);
        level util::cooldown(cooldown, 5);
    }
    while (isalive(player) && isdefined(player.revivetrigger) && self istouching(player.revivetrigger)) {
        self bottapbutton(3);
        waitframe(1);
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x15ef5911, Offset: 0x54e8
// Size: 0x34
function look_helplessly_at_enemy_weight(actionutility, tacbundle) {
    if (!self set_visible_enemy(actionutility)) {
        return undefined;
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xbf4fdf52, Offset: 0x5528
// Size: 0x154
function look_helplessly_at_enemy(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(enemy), "<dev string:x168>");
    endtime = gettime() + randomintrange(500, 1500);
    while (self bot::enemy_is_current(enemy) && self bot::has_visible_enemy()) {
        aimpoint = enemy gettagorigin("j_spine4");
        if (!isdefined(aimpoint)) {
            aimpoint = enemy getcentroid();
        }
        self botsetlookpoint(aimpoint);
        waitframe(1);
        if (gettime() > endtime) {
            return;
        }
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x434c5cc1, Offset: 0x5688
// Size: 0x32
function switch_to_weapon_weight(actionutility, tacbundle) {
    weapon = actionutility.weapon;
    return false;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xc64a40ef, Offset: 0x56c8
// Size: 0xce
function switch_to_weapon(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(weapon), "<dev string:x193>");
    currentweapon = self getcurrentweapon();
    if (weapon == currentweapon) {
        return;
    }
    self botswitchtoweapon(weapon);
    self waittilltimeout(1, "weapon_change_complete");
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xa84508b, Offset: 0x57a0
// Size: 0x23e
function reload_weapon_weight(actionutility, tacbundle) {
    weapon = actionutility.weapon;
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x1b6>" + clipammo + "<dev string:x1bd>" + weapon.clipsize;
    #/
    if (clipammo >= weapon.clipsize) {
        return undefined;
    }
    stockammo = self getweaponammostock(weapon);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x1bf>" + stockammo;
    #/
    if (stockammo <= 0) {
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        actionutility.enemy = self.enemy;
    }
    return 0;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x8425cd86, Offset: 0x59e8
// Size: 0x1fe
function reload_weapon(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(weapon), "<dev string:x1c7>");
    currentweapon = self getcurrentweapon();
    if (weapon != currentweapon) {
        return;
    }
    if (!self isreloading()) {
        self bottapbutton(4);
        cooldown = "reload_vo_" + self.team;
        if (level util::iscooldownready(cooldown)) {
            dialog_flag_team = 1;
            level util::cooldown(cooldown, 7);
            self dialog_shared::play_dialog("reload", dialog_flag_team);
            level util::addcooldowntime(cooldown, 3);
        }
    }
    waitframe(1);
    while (self isreloading()) {
        if (isdefined(enemy) && isalive(enemy) && self bot::enemy_is_visible(enemy)) {
            self aim_at_entity(enemy);
        } else {
            self look_along_path();
        }
        waitframe(1);
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xa0a79e05, Offset: 0x5bf0
// Size: 0x21e
function melee_enemy_weight(actionutility, tacbundle) {
    if (!self set_visible_enemy(actionutility)) {
        return undefined;
    }
    enemy = actionutility.enemy;
    meleerange = getdvarfloat("player_meleeRangeDefault", 0);
    if (distancesquared(self.origin, enemy.origin) > meleerange * meleerange) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x1e7>";
        #/
        return undefined;
    }
    if (self bot::fwd_dot(self.enemy get_aim_point()) < 0.5) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x200>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xbd3dd286, Offset: 0x5e18
// Size: 0x98
function melee_enemy(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    self bottapbutton(2);
    waitframe(1);
    if (self ismeleeing()) {
        while (self ismeleeing()) {
            waitframe(1);
        }
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x114b8ccd, Offset: 0x5eb8
// Size: 0x20e
function shoot_bulletweapon_at_enemy_weight(actionutility, tacbundle) {
    if (!self set_visible_enemy(actionutility)) {
        return undefined;
    }
    weapon = actionutility.weapon;
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x219>" + clipammo + "<dev string:x1bd>" + weapon.clipsize;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    if (!self in_range(weapon, self.enemy.origin)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x21f>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xdfdbfc94, Offset: 0x60d0
// Size: 0x304
function shoot_bulletweapon_at_enemy(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(weapon), "<dev string:x232>");
    assert(isdefined(enemy), "<dev string:x260>");
    currentweapon = self getcurrentweapon();
    if (weapon != currentweapon) {
        return;
    }
    targetdot = cos(weapon.hipspreadstandmin);
    maxs = enemy getmaxs();
    enemyradius = maxs[0];
    endtime = gettime() + randomintrange(500, 1500);
    while (self bot::enemy_is_current(enemy) && self bot::has_visible_enemy()) {
        clipammo = self clip_ammo(weapon);
        if (clipammo <= 0) {
            return;
        }
        aimpoint = self aim_at_entity(enemy);
        if (self botgetlookdot() >= targetdot) {
            if (weapon.aimdownsight) {
                projectedspread = self projected_spread(weapon.hipspreadstandmin, aimpoint);
                if (projectedspread > 1.5 * enemyradius) {
                    self bottapbutton(11);
                }
            }
            if (self weapon_can_fire(weapon)) {
                self bottapbutton(0);
            }
            if (weapon.dualwieldweapon != level.weaponnone && self weapon_can_fire(weapon.dualwieldweapon)) {
                self bottapbutton(24);
            }
        }
        waitframe(1);
        if (gettime() > endtime) {
            return;
        }
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x16d6f690, Offset: 0x63e0
// Size: 0x25c
function shoot_grenadeweapon_at_enemy(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(weapon), "<dev string:x28e>");
    assert(isdefined(enemy), "<dev string:x2bd>");
    currentweapon = self getcurrentweapon();
    if (weapon != currentweapon) {
        return;
    }
    endtime = gettime() + randomintrange(1000, 3000);
    while (self bot::enemy_is_current(enemy) && self bot::has_visible_enemy()) {
        clipammo = self clip_ammo(weapon);
        if (clipammo <= 0) {
            return;
        }
        aimpoint = enemy gettagorigin("j_spine4");
        if (!isdefined(aimpoint)) {
            aimpoint = enemy getcentroid();
        }
        aimangles = self botgetprojectileaimangles(weapon, aimpoint, 0);
        if (isdefined(aimangles)) {
            self botsetlookangles(aimangles);
            if (self weapon_can_fire(weapon) && self botgetlookdot() >= 1) {
                self bottapbutton(0);
            }
        }
        waitframe(1);
        if (gettime() > endtime) {
            return;
        }
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x8220c41, Offset: 0x6648
// Size: 0x212
function shoot_lockon_rocketlauncher_at_enemy_weight(actionutility, tacbundle) {
    if (!self set_visible_enemy(actionutility)) {
        return undefined;
    }
    enemy = actionutility.enemy;
    if (!target_istarget(enemy)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x2ec>";
        #/
        return undefined;
    }
    weapon = actionutility.weapon;
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x219>" + clipammo + "<dev string:x1bd>" + weapon.clipsize;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xee1c66e1, Offset: 0x6868
// Size: 0x31c
function shoot_lockon_rocketlauncher_at_enemy(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(weapon), "<dev string:x307>");
    assert(isdefined(enemy), "<dev string:x33e>");
    currentweapon = self getcurrentweapon();
    if (weapon != currentweapon) {
        return;
    }
    targetdot = cos(weapon.hipspreadstandmin);
    lockedflag = 1 << self getentitynumber();
    endtime = gettime() + randomintrange(500, 1500);
    while (self bot::enemy_is_current(enemy) && self bot::has_visible_enemy() && target_istarget(enemy)) {
        subtargets = target_getsubtargets(enemy);
        if (subtargets[0] != 0) {
            aimpoint = target_getorigin(enemy, subtargets[0]);
        } else {
            aimpoint = target_getorigin(enemy);
        }
        /#
            if (self bot::should_record("<dev string:xe0>")) {
                recordsphere(aimpoint, 4, (1, 0, 0), "<dev string:xf1>", self);
            }
        #/
        self botsetlookpoint(aimpoint);
        if (self botgetlookdot() >= targetdot) {
            self bottapbutton(11);
            if (isdefined(self.stingertarget) && isdefined(self.stingertarget.locked_on) && self.stingertarget.locked_on & lockedflag) {
                self bottapbutton(0);
                waitframe(1);
                return;
            }
        }
        waitframe(1);
        if (gettime() > endtime) {
            return;
        }
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xf43eb77a, Offset: 0x6b90
// Size: 0x246
function shoot_rocketlauncher_at_enemy_weight(actionutility, tacbundle) {
    if (!self set_visible_enemy(actionutility)) {
        return undefined;
    }
    enemy = actionutility.enemy;
    weapon = actionutility.weapon;
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x219>" + clipammo + "<dev string:x1bd>" + weapon.clipsize;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    distsq = distancesquared(self.origin, enemy.origin);
    if (distsq > 2250000) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x375>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xf1dc9d7d, Offset: 0x6de0
// Size: 0x29c
function shoot_rocketlauncher_at_enemy(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(weapon), "<dev string:x3a0>");
    assert(isdefined(enemy), "<dev string:x3d0>");
    currentweapon = self getcurrentweapon();
    if (weapon != currentweapon) {
        return;
    }
    targetdot = cos(weapon.hipspreadstandmin);
    maxs = enemy getmaxs();
    enemyradius = maxs[0];
    endtime = gettime() + randomintrange(500, 1500);
    while (self bot::enemy_is_current(enemy) && self bot::has_visible_enemy()) {
        aimpoint = self aim_at_entity(enemy);
        if (self botgetlookdot() >= targetdot) {
            projectedspread = self projected_spread(weapon.hipspreadstandmin, aimpoint);
            if (projectedspread > 1.5 * enemyradius) {
                self bottapbutton(11);
                if (self playerads() >= 1) {
                    self bottapbutton(0);
                    waitframe(1);
                    return;
                }
            } else {
                self bottapbutton(0);
                waitframe(1);
                return;
            }
        }
        waitframe(1);
        if (gettime() > endtime) {
            return;
        }
    }
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x732eed90, Offset: 0x7088
// Size: 0x200
function activate_charged_gadget_weight(actionutility, tacbundle) {
    weapon = actionutility.weapon;
    slot = self gadgetgetslot(weapon);
    power = self gadgetpowerget(slot);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x400>" + power;
    #/
    if (!weapon.isheavyweapon && !weapon.isabilityweapon) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x408>";
        #/
        return undefined;
    }
    if (power < 100) {
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x893fe31c, Offset: 0x7290
// Size: 0x84
function activate_charged_gadget(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(weapon), "<dev string:x429>");
    self bot::activate_hero_gadget(weapon);
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xd6748d8e, Offset: 0x7320
// Size: 0x196
function battery_blitz_weight(actionutility, tacbundle) {
    if (self.goalforced) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x453>";
        #/
    }
    pineapplegun = getweapon("hero_pineapplegun_companion");
    armor = getweapon("gadget_armor");
    allcharged = 1;
    allcharged &= self hero_gadget_charged(pineapplegun, actionutility);
    allcharged &= self hero_gadget_charged(armor, actionutility);
    if (!allcharged) {
        return undefined;
    }
    if (!self set_visible_enemy(actionutility)) {
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x60bdea37, Offset: 0x74c0
// Size: 0xde
function battery_blitz(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    pineapplegun = getweapon("hero_pineapplegun_companion");
    armor = getweapon("gadget_armor");
    self bot::activate_hero_gadget(armor);
    waitframe(1);
    self bot::activate_hero_gadget(pineapplegun);
    self waittilltimeout(1, "weapon_change_complete");
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xa6db82ea, Offset: 0x75a8
// Size: 0x34e
function ruin_stuff_weight(actionutility, tacbundle) {
    if (self.goalforced) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x453>";
        #/
        return undefined;
    }
    gravityspikes = getweapon("hero_gravityspikes");
    speedburst = getweapon("gadget_speed_burst");
    allcharged = 1;
    allcharged &= self hero_gadget_charged(gravityspikes, actionutility);
    allcharged &= self hero_gadget_charged(speedburst, actionutility);
    if (!allcharged) {
        return undefined;
    }
    if (!self set_visible_enemy(actionutility)) {
        return undefined;
    }
    enemy = actionutility.enemy;
    if (!ispointonnavmesh(enemy.origin, self)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x45f>";
        #/
        return undefined;
    }
    if (distancesquared(self.origin, enemy.origin) > 490000) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x474>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xcfac3361, Offset: 0x7900
// Size: 0x29c
function ruin_stuff(weapon, enemy) {
    self endoncallback(&end_ruin_stuff, #"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start");
    level endon(#"game_ended");
    assert(isdefined(enemy), "<dev string:x487>");
    self val::set("ruin_stuff", "ignoreme", 1);
    gravityspikes = getweapon("hero_gravityspikes");
    speedburst = getweapon("gadget_speed_burst");
    self bot::activate_hero_gadget(speedburst);
    self.overridepos = enemy.origin;
    lookpoint = self.enemy.origin + (0, 0, 60);
    self botsetlookpoint(lookpoint);
    waitframe(1);
    if (self.goalforced) {
        self notify(#"cancel_ignoreme");
        self val::reset("ruin_stuff", "ignoreme");
        return;
    }
    while (distancesquared(self.origin, self.overridepos) > 262144 && self botgetlookdot() < 0.866) {
        self botsetlookpoint(lookpoint);
        waitframe(1);
        if (self.goalforced) {
            self notify(#"cancel_ignoreme");
            self val::reset("ruin_stuff", "ignoreme");
            return;
        }
    }
    self bot::activate_hero_gadget(gravityspikes);
    wait 0.75;
    self end_ruin_stuff(undefined);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xa66a9979, Offset: 0x7ba8
// Size: 0x34
function end_ruin_stuff(notifyhash) {
    self val::reset("ruin_stuff", "ignoreme");
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xd1409b4d, Offset: 0x7be8
// Size: 0x3ae
function bleed_out_weight(actionutility, tacbundle) {
    if (!isdefined(self.owner)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x4a4>";
        #/
        return undefined;
    }
    if (self.owner.sessionstate == "playing") {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x4b4>";
        #/
        return undefined;
    }
    if (!isdefined(self.revivetrigger)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x4c5>";
        #/
        return undefined;
    }
    if (isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x4d7>";
        #/
        return undefined;
    }
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x4e5>" + self.owner.sessionstate;
    #/
    return 100;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xc1da1493, Offset: 0x7fa0
// Size: 0xce
function bleed_out(weapon, enemy) {
    self endon(#"death", #"entering_last_stand", #"bot_cancel_action", #"animscripted_start", #"player_revived");
    level endon(#"game_ended");
    while (isalive(self) && self laststand::player_is_in_laststand() && !(isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived)) {
        self bottapbutton(3);
        waitframe(1);
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0xb3b42ed9, Offset: 0x8078
// Size: 0x3f4
function set_visible_enemy(actionutility) {
    if (!isdefined(self.enemy)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x4ef>";
        #/
        return false;
    }
    if (self bot::get_engage_enemies() == "none") {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x4f8>";
        #/
        return false;
    }
    if (self bot::get_engage_enemies() == "favorite") {
        if (!isdefined(self.favoriteenemy) || self.favoriteenemy != self.enemy) {
            /#
                if (!isdefined(actionutility.debug)) {
                    actionutility.debug = [];
                } else if (!isarray(actionutility.debug)) {
                    actionutility.debug = array(actionutility.debug);
                }
                actionutility.debug[actionutility.debug.size] = "<dev string:x50d>";
            #/
            return false;
        }
    }
    if (!isalive(self.enemy)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x520>";
        #/
        return false;
    }
    if (!self cansee(self.enemy)) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = "<dev string:x52e>";
        #/
        return false;
    }
    actionutility.enemy = self.enemy;
    return true;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xf4ec1381, Offset: 0x8478
// Size: 0x32
function get_max_health() {
    if (isvehicle(self)) {
        return self.healthdefault;
    }
    return self.maxhealth;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x2b59a982, Offset: 0x84b8
// Size: 0x50
function aim_at_entity(entity) {
    aimpoint = entity get_aim_point();
    self botsetlookpoint(aimpoint);
    return aimpoint;
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xdabcab83, Offset: 0x8510
// Size: 0x52
function get_aim_point() {
    aimpoint = self gettagorigin("j_spine4");
    if (isdefined(aimpoint)) {
        return aimpoint;
    }
    return self getcentroid();
}

// Namespace bot_action/bot_action
// Params 0, eflags: 0x0
// Checksum 0xa27555d1, Offset: 0x8570
// Size: 0x214
function look_along_path() {
    color = (1, 1, 1);
    if (self haspath()) {
        lookpoint = self botgetpredictedcornerentry();
        if (isdefined(lookpoint)) {
            lookpoint = (lookpoint[0], lookpoint[1], self.origin[2]);
            color = (1, 1, 0);
        } else if (isdefined(self.overridepos)) {
            lookpoint = self.overridepos;
            color = (1, 0, 1);
        } else {
            lookpoint = self.goalpos;
            color = self.goalforced ? (0, 1, 1) : (0, 1, 0);
        }
    } else {
        lookpoint = self bot::get_point_of_interest();
        if (!isdefined(lookpoint) && isdefined(self.owner) && self.owner isbot()) {
            lookpoint = self.owner bot::get_point_of_interest();
        }
        color = (0, 0, 1);
    }
    if (isdefined(lookpoint)) {
        viewheight = self getplayerviewheight();
        lookpoint += (0, 0, viewheight);
        /#
            if (self bot::should_record("<dev string:x53e>")) {
                recordsphere(lookpoint, 4, color, "<dev string:x550>", self);
            }
        #/
        self botsetlookpoint(lookpoint);
    }
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x727bb5ea, Offset: 0x8790
// Size: 0x3c
function can_use_gameobject(gameobject) {
    return self bot::can_interact_with(gameobject) && gameobject.triggertype == "use";
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x3f54cb74, Offset: 0x87d8
// Size: 0x1f6
function action_weapon_has_ammo(actionutility) {
    weapon = actionutility.weapon;
    clipammo = self clip_ammo(weapon);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x1b6>" + clipammo + "<dev string:x1bd>" + weapon.clipsize;
    #/
    stockammo = self getweaponammostock(weapon);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = "<dev string:x1bf>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return false;
    }
    return true;
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x55f9d8eb, Offset: 0x89d8
// Size: 0x44
function clip_ammo(weapon) {
    return self getweaponammoclip(weapon) + self getweaponammoclip(weapon.dualwieldweapon);
}

// Namespace bot_action/bot_action
// Params 1, eflags: 0x0
// Checksum 0x40fb1d44, Offset: 0x8a28
// Size: 0x9a
function weapon_can_fire(weapon) {
    if (self getweaponammoclip(weapon) <= 0) {
        return false;
    }
    if (weapon.firetype == "Single Shot" || weapon.firetype == "Burst" || weapon.firetype == "Charge Shot") {
        return !self attackbuttonpressed();
    }
    return true;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0xf723b754, Offset: 0x8ad0
// Size: 0x6c
function in_range(weapon, targetpos) {
    distsq = distancesquared(self.origin, targetpos);
    mindamagerange = weapon.mindamagerange;
    return distsq < mindamagerange * mindamagerange;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x176bc642, Offset: 0x8b48
// Size: 0x8e
function projected_spread(spreadangle, aimpoint) {
    eyepoint = self geteye();
    distance = distance(eyepoint, aimpoint);
    projectedspread = distance * sin(spreadangle);
    return projectedspread;
}

// Namespace bot_action/bot_action
// Params 2, eflags: 0x0
// Checksum 0x9ab4e3b, Offset: 0x8be0
// Size: 0x3ac
function hero_gadget_charged(weapon, actionutility) {
    slot = self gadgetgetslot(weapon);
    if (slot < 0) {
        /#
            if (!isdefined(actionutility.debug)) {
                actionutility.debug = [];
            } else if (!isarray(actionutility.debug)) {
                actionutility.debug = array(actionutility.debug);
            }
            actionutility.debug[actionutility.debug.size] = weapon.name + "<dev string:x559>";
        #/
        return false;
    }
    if (weapon.isheavyweapon) {
        clipammo = self getweaponammoclip(weapon);
        stockammo = self getweaponammostock(weapon);
        if (clipammo + stockammo > 0) {
            /#
                if (!isdefined(actionutility.debug)) {
                    actionutility.debug = [];
                } else if (!isarray(actionutility.debug)) {
                    actionutility.debug = array(actionutility.debug);
                }
                actionutility.debug[actionutility.debug.size] = "<dev string:x1b6>" + clipammo + "<dev string:x1bd>" + weapon.clipsize;
            #/
            /#
                if (!isdefined(actionutility.debug)) {
                    actionutility.debug = [];
                } else if (!isarray(actionutility.debug)) {
                    actionutility.debug = array(actionutility.debug);
                }
                actionutility.debug[actionutility.debug.size] = "<dev string:x1bf>" + stockammo;
            #/
            return true;
        }
    }
    power = self gadgetpowerget(slot);
    /#
        if (!isdefined(actionutility.debug)) {
            actionutility.debug = [];
        } else if (!isarray(actionutility.debug)) {
            actionutility.debug = array(actionutility.debug);
        }
        actionutility.debug[actionutility.debug.size] = weapon.name + "<dev string:x568>" + power;
    #/
    return power >= 100;
}

