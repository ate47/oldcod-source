#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\system_shared;

#namespace zm_bot_action;

// Namespace zm_bot_action/zm_bot_action
// Params 0, eflags: 0x2
// Checksum 0xcc44ccca, Offset: 0xc8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bot_action", &__init__, &__main__, undefined);
}

// Namespace zm_bot_action/zm_bot_action
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x118
// Size: 0x4
function __init__() {
    
}

// Namespace zm_bot_action/zm_bot_action
// Params 0, eflags: 0x0
// Checksum 0x3e26863c, Offset: 0x128
// Size: 0x94
function __main__() {
    level bot_action::register_actions();
    level bot_action::register_weapons();
    level bot_action::function_47e27c09();
    level register_actions();
    level register_weapons();
    level function_47e27c09();
}

// Namespace zm_bot_action/zm_bot_action
// Params 0, eflags: 0x0
// Checksum 0x1fa31fb0, Offset: 0x1c8
// Size: 0x234
function register_actions() {
    bot_action::register_action(#"melee_zombie_enemy", &bot_action::current_melee_weapon_rank, &function_a0503584, &bot_action::melee_enemy);
    bot_action::register_action(#"hash_22d98a5a241c78ba", &bot_action::rank_priority, &function_3816a13f, &function_b2124bfc);
    bot_action::register_action(#"hash_5c2824c8a8f125f7", &bot_action::rank_priority, &function_f4ec4122, &function_ca3db1df);
    bot_action::register_action(#"zombie_auto_revive", &bot_action::rank_priority, &function_94f772b8, &zombie_auto_revive);
    bot_action::register_action(#"zombie_reload_weapon", &bot_action::current_weapon_rank, &bot_action::reload_weapon_weight, &zombie_reload_weapon);
    bot_action::register_action(#"zombie_revive_player", &bot_action::rank_priority, &function_d3c77946, &bot_action::revive_player);
    bot_action::register_action(#"zombie_scan_for_threats", &bot_action::function_f46d3345, &bot_action::scan_for_threats_weight, &zombie_scan_for_threats);
}

// Namespace zm_bot_action/zm_bot_action
// Params 0, eflags: 0x0
// Checksum 0xd316659c, Offset: 0x408
// Size: 0x17c
function register_weapons() {
    bot_action::register_bulletweapon(#"ar_mg1909_t8");
    bot_action::register_bulletweapon(#"minigun");
    bot_action::register_bulletweapon(#"pistol_revolver38");
    bot_action::register_bulletweapon(#"pistol_topbreak_t8");
    bot_action::register_bulletweapon(#"shotgun_trenchgun_t8");
    bot_action::register_bulletweapon(#"smg_drum_pistol_t8");
    bot_action::register_bulletweapon(#"ww_tricannon_t8");
    bot_action::register_bulletweapon(#"ww_tricannon_air_t8");
    bot_action::register_bulletweapon(#"ww_tricannon_earth_t8");
    bot_action::register_bulletweapon(#"ww_tricannon_fire_t8");
    bot_action::register_bulletweapon(#"ww_tricannon_water_t8");
    self function_3491953();
}

// Namespace zm_bot_action/zm_bot_action
// Params 0, eflags: 0x0
// Checksum 0xaea9f5b2, Offset: 0x590
// Size: 0x104
function function_47e27c09() {
    bot_action::register_action(#"throw_chakram", &bot_action::weapon_rank, &function_3bbc8318, &throw_chakram);
    bot_action::register_action(#"hash_43719a8d0ef689ba", &bot_action::weapon_rank, &function_e61c2ddf, &function_4c00a9dc);
    bot_action::function_eeecc088(#"hero_chakram_lv1", #"throw_chakram");
    bot_action::function_3800d421(#"hero_chakram_lv1", #"hash_43719a8d0ef689ba");
}

// Namespace zm_bot_action/zm_bot_action
// Params 0, eflags: 0x0
// Checksum 0x7bf315a5, Offset: 0x6a0
// Size: 0x44
function function_3491953() {
    bot_action::function_60a0d9d4(#"hero_chakram_lv1", &bot_action::function_dde10d2d, &bot_action::function_6e41259d);
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0xbe4a686d, Offset: 0x6f0
// Size: 0x38
function function_3bbc8318(actionparams) {
    actionparams.target = self.enemy;
    self bot_action::function_77ee8d5(actionparams);
    return 100;
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0x9cf11bd6, Offset: 0x730
// Size: 0x106
function throw_chakram(actionparams) {
    weapon = actionparams.weapon;
    dualwieldweapon = weapon.dualwieldweapon;
    while (!self bot_action::function_68380091() && self bot::weapon_loaded(dualwieldweapon)) {
        self bot_action::function_e9fddff3(actionparams);
        self bot_action::function_b69f54b(actionparams);
        if (self bot_action::function_61e908ed(actionparams, dualwieldweapon.maxdamagerange) && self bot_action::function_c3d770a4(actionparams)) {
            self bottapbutton(24);
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0xe8ac2aa6, Offset: 0x840
// Size: 0x402
function function_e61c2ddf(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
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
            actionparams.debug[actionparams.debug.size] = "<dev string:x52>";
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
            actionparams.debug[actionparams.debug.size] = "<dev string:x63>";
        #/
        return undefined;
    }
    if (!isdefined(self.enemy) || !isalive(self.enemy)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x71>";
        #/
        return undefined;
    }
    if (self getenemiesinradius(self.origin, 512).size < 8 && self getenemiesinradius(self.origin, 256).size < 5) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x7a>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0x3bb9b6f9, Offset: 0xc50
// Size: 0x6e
function function_4c00a9dc(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (self isswitchingweapons()) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0x7c9f986a, Offset: 0xcc8
// Size: 0x352
function function_a0503584(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    primaryweapons = self getweaponslistprimaries();
    foreach (primary in primaryweapons) {
        if (isdefined(primary) && primary.name != "none") {
            if (self getammocount(primary) > 0) {
                /#
                    if (!isdefined(actionparams.debug)) {
                        actionparams.debug = [];
                    } else if (!isarray(actionparams.debug)) {
                        actionparams.debug = array(actionparams.debug);
                    }
                    actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
                #/
                return undefined;
            }
        }
    }
    if (!self bot_action::is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xac>";
        #/
        return undefined;
    }
    meleerange = actionparams.weapon.var_9bde0fd9;
    enemyradius = self.enemy getpathfindingradius();
    if (distance2dsquared(self.origin, self.enemy.origin) > (meleerange + enemyradius) * (meleerange + enemyradius)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xbd>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0x377c4600, Offset: 0x1028
// Size: 0x3e
function zombie_auto_revive(actionparams) {
    while (isdefined(self.revivetrigger)) {
        self bottapbutton(3);
        waitframe(1);
    }
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0xb21c02ce, Offset: 0x1070
// Size: 0xc2
function function_94f772b8(actionparams) {
    if (!isdefined(self.var_d692c624) || self.var_d692c624 <= 0) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xd6>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0x3ce50491, Offset: 0x1140
// Size: 0x34a
function function_f4ec4122(actionparams) {
    if (self getcurrentweapon().isgadget) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xed>";
        #/
        return undefined;
    }
    if (!self bot::function_cdf20f6b()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xfa>";
        #/
        return undefined;
    }
    zombie_weapon_upgrade = self bot::get_interact();
    actionparams.zombie_weapon_upgrade = zombie_weapon_upgrade;
    if (!isdefined(zombie_weapon_upgrade.trigger_stub.playertrigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x115>";
        #/
        return undefined;
    }
    trigger = zombie_weapon_upgrade.trigger_stub.playertrigger[self getentitynumber()];
    if (!isdefined(trigger) || !self function_eda95da5(trigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x115>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0xe213f026, Offset: 0x1498
// Size: 0xca
function function_56c34d45(actionparams) {
    self notify(#"hash_782d5f24975a7cd1");
    self endon(#"hash_782d5f24975a7cd1");
    self endon(#"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start", #"hash_1728f8b5de3bde13");
    level endon(#"game_ended");
    self waittill(#"wallbuy_done");
    actionparams.var_7a5f3ab4 = 1;
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x4
// Checksum 0x67f1436f, Offset: 0x1570
// Size: 0xc6
function private function_eda95da5(trigger) {
    var_4fc5861e = self getpathfindingradius();
    maxs = (trigger.maxs[0], trigger.maxs[1], 0);
    var_c13cb290 = length(maxs);
    return distance2dsquared(self.origin, trigger.origin) <= (120 + var_c13cb290 + var_4fc5861e) * (120 + var_c13cb290 + var_4fc5861e);
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0x74d297f0, Offset: 0x1640
// Size: 0x244
function function_ca3db1df(actionparams) {
    zombie_weapon_upgrade = actionparams.zombie_weapon_upgrade;
    trigger = zombie_weapon_upgrade.trigger_stub.playertrigger[self getentitynumber()];
    lookpoint = trigger.origin;
    self thread function_56c34d45(actionparams);
    while (isdefined(self.bot) && isdefined(zombie_weapon_upgrade) && zombie_weapon_upgrade === self bot::get_interact() && isdefined(trigger) && self function_eda95da5(trigger)) {
        self bot_action::look_at_point(lookpoint, "Weapon Upgrade Trigger", (1, 1, 1));
        if (self botgetlookdot() >= 0.76 && self istouching(trigger)) {
            self botsetlookcurrent();
            break;
        }
        waitframe(1);
    }
    while (isdefined(self.bot) && isdefined(zombie_weapon_upgrade) && zombie_weapon_upgrade === self bot::get_interact() && isdefined(trigger) && self istouching(trigger) && !(isdefined(actionparams.var_7a5f3ab4) && actionparams.var_7a5f3ab4)) {
        self bot_action::look_at_point(lookpoint, "Weapon Upgrade Trigger", (1, 1, 1));
        self bottapbutton(3);
        waitframe(1);
    }
    self bot::clear_interact();
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0xdb726a01, Offset: 0x1890
// Size: 0x142
function function_b89ea388(interact) {
    assert(isbot(self));
    if (!isdefined(interact)) {
        return;
    }
    if (isentity(interact)) {
        return interact;
    }
    if (isdefined(interact.trigger_stub) && isdefined(interact.trigger_stub.playertrigger)) {
        return interact.trigger_stub.playertrigger[self getentitynumber()];
    }
    if (isdefined(interact.unitrigger_stub) && isdefined(interact.unitrigger_stub.playertrigger)) {
        return interact.unitrigger_stub.playertrigger[self getentitynumber()];
    }
    if (isdefined(interact.playertrigger)) {
        return interact.playertrigger[self getentitynumber()];
    }
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0x7154e5e6, Offset: 0x19e0
// Size: 0x34a
function function_3816a13f(actionparams) {
    if (self getcurrentweapon().isgadget) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xed>";
        #/
        return undefined;
    }
    if (!self bot::function_ccdf4349()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12a>";
        #/
        return undefined;
    }
    interact = self bot::get_interact();
    actionparams.interact = interact;
    trigger = function_b89ea388(interact);
    if (!isdefined(trigger) || !self istouching(trigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x115>";
        #/
        return undefined;
    }
    if (self haspath() && !self istouching(trigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x115>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0x1c62e17a, Offset: 0x1d38
// Size: 0xdc
function function_b2124bfc(actionparams) {
    trigger = function_b89ea388(actionparams.interact);
    lookpoint = trigger.origin;
    while (isdefined(self.bot) && actionparams.interact === self bot::get_interact() && isdefined(trigger) && self istouching(trigger)) {
        self bottapbutton(3);
        waitframe(1);
    }
    self bot::clear_interact();
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0xc0de8702, Offset: 0x1e20
// Size: 0x2aa
function zombie_scan_for_threats(actionparams) {
    targetvisible = self bot_action::is_target_visible(actionparams);
    actionparams.targetvisible = targetvisible;
    while (!self bot_action::function_68380091() && self bot_action::is_target_enemy(actionparams) && actionparams.targetvisible == targetvisible) {
        trigger = function_b89ea388(bot::get_interact());
        if (isdefined(trigger) && self bot::function_cdf20f6b() && function_eda95da5(trigger)) {
            break;
        }
        if (targetvisible && self bot_action::function_e5578b7f(actionparams)) {
            self bot_action::function_e9fddff3(actionparams);
            self bot_action::function_b69f54b(actionparams);
        } else if (targetvisible) {
            self bot_action::function_e9fddff3(actionparams);
            self bot_action::aim_at_target(actionparams);
        } else if (!targetvisible && self bot_action::function_e5578b7f(actionparams) && self seerecently(actionparams.target, 4000)) {
            self bot_action::function_e9fddff3(actionparams);
            self bot_action::function_b69f54b(actionparams);
        } else if (self bot_action::function_d5f640c7()) {
            self bot_action::function_b07d5884();
        } else if (self haspath()) {
            self bot_action::look_along_path();
        } else {
            self bot_action::function_97fae03a();
        }
        self waittill(#"hash_347a612b61067eb3");
        targetvisible = self bot_action::is_target_visible(actionparams);
    }
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0xac543d3d, Offset: 0x20d8
// Size: 0x206
function zombie_reload_weapon(actionparams) {
    weapon = self getcurrentweapon();
    if (!self isreloading()) {
        self bottapbutton(4);
    }
    self waittill(#"hash_347a612b61067eb3");
    while (self isreloading()) {
        if (self bot_action::is_target_enemy(actionparams) && self bot_action::is_target_visible(actionparams)) {
            self bot_action::function_e9fddff3(actionparams);
            self bot_action::function_b69f54b(actionparams);
        } else if (self bot_action::is_target_enemy(actionparams) && self bot_action::function_bfdb45e7(self.bot.tacbundle.var_f19c9f47)) {
            if (self bot_action::function_444016e7()) {
                self bot_action::function_50172422();
            } else {
                self bot_action::function_97fae03a();
            }
        } else if (self bot_action::function_d5f640c7()) {
            self bot_action::function_b07d5884();
        } else {
            if (self haspath()) {
                self bot_action::look_along_path();
                return;
            }
            self bot_action::function_97fae03a();
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace zm_bot_action/zm_bot_action
// Params 1, eflags: 0x0
// Checksum 0xcabf0bf4, Offset: 0x22e8
// Size: 0x722
function function_d3c77946(actionparams) {
    if (self getcurrentweapon().isgadget) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xed>";
        #/
        return undefined;
    }
    if (!self ai::get_behavior_attribute("revive")) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x13d>";
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
            actionparams.debug[actionparams.debug.size] = "<dev string:x159>";
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
        actionparams.debug[actionparams.debug.size] = "<dev string:x16a>" + revivetarget.name;
    #/
    if (!isdefined(revivetarget.revivetrigger)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x173>";
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
            actionparams.debug[actionparams.debug.size] = "<dev string:x115>";
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
            actionparams.debug[actionparams.debug.size] = "<dev string:x185>";
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
            actionparams.debug[actionparams.debug.size] = "<dev string:x193>";
        #/
        return undefined;
    }
    nearbyenemies = self getenemiesinradius(revivetarget.revivetrigger.origin, 256);
    if (nearbyenemies.size > 0) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x19f>";
        #/
        return undefined;
    }
    return 100;
}

