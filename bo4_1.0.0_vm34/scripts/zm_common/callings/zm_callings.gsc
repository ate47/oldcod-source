#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callings\zm_callings_devgui;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_callings;

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x2
// Checksum 0x6ab36df4, Offset: 0xc8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_callings", &__init__, &__main__, undefined);
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0x55a109df, Offset: 0x118
// Size: 0x4c
function __init__() {
    level.var_29e827fa = getscriptbundle(#"t8_callings_settings");
    zm_spawner::register_zombie_death_event_callback(&function_db6decae);
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0xe438e011, Offset: 0x170
// Size: 0x34
function __main__() {
    /#
        level thread zm_callings_devgui::function_8aec39bb();
    #/
    level thread earned_points_tracking();
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xd3cf8767, Offset: 0x1b0
// Size: 0x94
function function_b6d849b8(taskid) {
    if (!isdefined(level.var_2c553910)) {
        level.var_2c553910 = array();
    }
    if (!isdefined(level.var_2c553910[taskid])) {
        level.var_2c553910[taskid] = getscriptbundle(level.var_29e827fa.tasklist[taskid].task);
    }
    return level.var_2c553910[taskid];
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0x39459ab8, Offset: 0x250
// Size: 0x94
function function_4c7563a2(var_3af8f28f) {
    if (!isdefined(level.var_827f6fa2)) {
        level.var_827f6fa2 = array();
    }
    if (!isdefined(level.var_827f6fa2[var_3af8f28f])) {
        level.var_827f6fa2[var_3af8f28f] = getscriptbundle(level.var_29e827fa.rewardlist[var_3af8f28f].reward);
    }
    return level.var_827f6fa2[var_3af8f28f];
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xecc4e6b0, Offset: 0x2f0
// Size: 0x94
function function_4603d949(var_473005c4) {
    if (!isdefined(level.var_caf2e309)) {
        level.var_caf2e309 = array();
    }
    if (!isdefined(level.var_caf2e309[var_473005c4])) {
        level.var_caf2e309[var_473005c4] = getscriptbundle(level.var_29e827fa.factionlist[var_473005c4].faction);
    }
    return level.var_caf2e309[var_473005c4];
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xcc94ad7b, Offset: 0x390
// Size: 0x5c
function function_cbdffba5(tier) {
    if (isplayer(self)) {
        self stats::set_stat(#"playercalling", #"hash_3e3ff081c0fcd06e", tier);
    }
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xccbdd575, Offset: 0x3f8
// Size: 0x5c
function function_432adbf1(var_5b4eaff4) {
    if (isplayer(self)) {
        self stats::set_stat(#"playercalling", #"callingtype", var_5b4eaff4);
    }
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0xc0cd5b51, Offset: 0x460
// Size: 0x54
function function_e0c8bbf5() {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"callingtype");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 2, eflags: 0x0
// Checksum 0x8b8bb91b, Offset: 0x4c0
// Size: 0x74
function function_6bdfe3f9(slotindex, taskid) {
    if (isplayer(self)) {
        self stats::set_stat(#"playercalling", #"tasklist", slotindex, #"index", taskid);
    }
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0x99f802a5, Offset: 0x540
// Size: 0x6c
function function_cbbdaadd(slotindex) {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"tasklist", slotindex, #"index");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xeb966a08, Offset: 0x5b8
// Size: 0x6c
function function_1356e476(slotindex) {
    if (isplayer(self)) {
        self stats::set_stat(#"playercalling", #"tasklist", slotindex, #"progress", 0);
    }
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xd45abba0, Offset: 0x630
// Size: 0x6c
function function_a56ef669(slotindex) {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"tasklist", slotindex, #"progress");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 2, eflags: 0x0
// Checksum 0x452de63, Offset: 0x6a8
// Size: 0xec
function function_55966fcd(slotindex, num) {
    if (isplayer(self) && self function_5034d1dc() && !function_8f381695(slotindex)) {
        self stats::set_stat(#"playercalling", #"tasklist", slotindex, #"progress", num);
        if (function_8f381695(slotindex)) {
            self function_d699a25f(slotindex);
        }
        self function_3519441f();
    }
}

// Namespace zm_callings/zm_callings
// Params 2, eflags: 0x0
// Checksum 0x8eb60ba4, Offset: 0x7a0
// Size: 0x1b4
function function_23dabaad(slotindex, delta = 1) {
    /#
        delta *= getdvarint(#"hash_56e2a9e5690e0373", 1);
    #/
    if (isplayer(self) && self function_5034d1dc() && !function_8f381695(slotindex)) {
        self stats::inc_stat(#"playercalling", #"tasklist", slotindex, #"progress", delta);
        /#
            progress = self function_a56ef669(slotindex);
            target = self function_2e5b79db(slotindex);
            iprintln(self.name + "<dev string:x30>" + slotindex + "<dev string:x41>" + progress + "<dev string:x51>" + target);
        #/
        if (function_8f381695(slotindex)) {
            self function_d699a25f(slotindex);
        }
        self function_3519441f();
    }
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0x582b684b, Offset: 0x960
// Size: 0x174
function function_2e5b79db(slotindex) {
    if (isplayer(self)) {
        taskid = self function_cbbdaadd(slotindex);
        if (isdefined(taskid)) {
            task = function_b6d849b8(taskid);
            callingtype = self function_e0c8bbf5();
            if (isdefined(callingtype)) {
                switch (callingtype) {
                case 1:
                    if (slotindex == 0) {
                        return task.dailytarget;
                    } else if (slotindex == 1 || slotindex == 2) {
                        return task.var_50fa8393;
                    }
                    break;
                case 2:
                    return task.var_5951e754;
                case 3:
                    if (slotindex == 0) {
                        return task.dailytarget;
                    } else if (slotindex == 1) {
                        return task.var_91a71923;
                    }
                    break;
                }
            }
        }
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xa754a0ed, Offset: 0xae0
// Size: 0x54
function function_59516288(slotindex) {
    target = function_2e5b79db(slotindex);
    if (isdefined(target)) {
        self function_55966fcd(slotindex, target);
    }
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0x503e2d66, Offset: 0xb40
// Size: 0x64
function function_8f381695(slotindex) {
    progress = self function_a56ef669(slotindex);
    target = self function_2e5b79db(slotindex);
    if (!isdefined(target)) {
        return false;
    }
    return progress >= target;
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0x318cf795, Offset: 0xbb0
// Size: 0x6c
function get_reward(slotindex) {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"rewardlist", slotindex, #"index");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0x7ecff22e, Offset: 0xc28
// Size: 0x6c
function function_1dfe70fe(slotindex) {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"rewardlist", slotindex, #"awarded");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xb93d8146, Offset: 0xca0
// Size: 0x84
function function_d699a25f(slotindex) {
    taskid = function_cbbdaadd(slotindex);
    if (isplayer(self)) {
        self luinotifyevent(#"zombie_callings_notification", 3, taskid, 0, self getentitynumber());
    }
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x0
// Checksum 0xcb5cd31b, Offset: 0xd30
// Size: 0xac
function function_5535de82(slotindex) {
    var_3af8f28f = get_reward(slotindex);
    reward = function_4c7563a2(var_3af8f28f);
    var_7eff92bb = reward.desc;
    self stats::set_stat(#"playercalling", #"rewardlist", slotindex, #"awarded", 1);
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0x955788b0, Offset: 0xde8
// Size: 0x29a
function function_3519441f() {
    if (isplayer(self)) {
        callingtype = self function_e0c8bbf5();
        if (isdefined(callingtype)) {
            switch (callingtype) {
            case 1:
                if (self function_8f381695(0) && !self function_1dfe70fe(0)) {
                    self function_5535de82(0);
                }
                if (self function_8f381695(1) && self function_8f381695(2) && !self function_1dfe70fe(1)) {
                    self function_5535de82(1);
                }
                break;
            case 2:
                tiercompleted = 1;
                for (i = 0; i < 4; i++) {
                    if (self function_8f381695(i)) {
                        if (!self function_1dfe70fe(i)) {
                            self function_5535de82(i);
                        }
                        continue;
                    }
                    tiercompleted = 0;
                }
                if (tiercompleted) {
                    self function_c113e287();
                }
                break;
            case 3:
                if (self function_8f381695(0) && !self function_1dfe70fe(0)) {
                    self function_5535de82(0);
                }
                if (self function_8f381695(1) && !self function_1dfe70fe(1)) {
                    self function_5535de82(1);
                }
                break;
            }
        }
    }
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0xd11e69d4, Offset: 0x1090
// Size: 0x54
function function_1b43d8c9() {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"hash_3e3ff081c0fcd06e");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0xd60ee79a, Offset: 0x10f0
// Size: 0x54
function function_ea493eb2() {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"hash_7dfcc1388ea0ffb2");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0x584dec32, Offset: 0x1150
// Size: 0x54
function function_a48eb426() {
    if (isplayer(self)) {
        self stats::inc_stat(#"playercalling", #"hash_7dfcc1388ea0ffb2", 1);
    }
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0x65150fad, Offset: 0x11b0
// Size: 0x54
function function_93c558ee() {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"hash_67a2b047b6546765");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0xf8eecfa1, Offset: 0x1210
// Size: 0x54
function function_796fd05f() {
    if (isplayer(self)) {
        return self stats::get_stat(#"playercalling", #"hash_6fd95a9d76a74396");
    }
    return undefined;
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0x418df1, Offset: 0x1270
// Size: 0x214
function function_c113e287() {
    seasonid = self function_796fd05f();
    if (seasonid == 0) {
        /#
            iprintln(self.name + "<dev string:x53>");
        #/
        return;
    }
    var_473005c4 = self function_93c558ee();
    faction = function_4603d949(var_473005c4);
    factionname = faction.factionname;
    self function_a48eb426();
    self stats::inc_stat(#"hash_415268fcc38d9f4c", seasonid - 1, "factions", var_473005c4, "tokens", 1);
    var_932f23c5 = self stats::get_stat(#"hash_415268fcc38d9f4c", seasonid - 1, #"factions", var_473005c4, #"hash_1c86003ee015ee63");
    if (var_932f23c5 > 12) {
        self stats::set_stat(#"hash_415268fcc38d9f4c", seasonid - 1, #"factions", var_473005c4, #"hash_1c86003ee015ee63", 12);
        return;
    }
    if (var_932f23c5 < 12) {
        self stats::inc_stat(#"hash_415268fcc38d9f4c", seasonid - 1, #"factions", var_473005c4, #"hash_1c86003ee015ee63", 1);
    }
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0xa79e6644, Offset: 0x1490
// Size: 0x14c
function function_f3210f03() {
    if (isplayer(self)) {
        gametype = hash(util::get_game_type());
        switch (gametype) {
        case #"zstandard":
        case #"zclassic":
        case #"ztrials":
            if (zm_custom::function_6642c67a()) {
                if (isdefined(level.var_29e827fa)) {
                    callingtype = self function_e0c8bbf5();
                    if (isdefined(callingtype)) {
                        switch (callingtype) {
                        case 1:
                        case 3:
                            return true;
                        case 2:
                            if (self function_1b43d8c9() != 0) {
                                return true;
                            }
                            break;
                        }
                    }
                }
            }
            break;
        }
    }
    return false;
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x0
// Checksum 0x8b3941b, Offset: 0x15e8
// Size: 0x32
function function_5034d1dc() {
    if (!isdefined(self.var_5034d1dc)) {
        self.var_5034d1dc = self function_f3210f03();
    }
    return self.var_5034d1dc;
}

// Namespace zm_callings/zm_callings
// Params 3, eflags: 0x4
// Checksum 0x768bed58, Offset: 0x1628
// Size: 0x54
function private function_b87a79d2(taskid, slotindex, delta) {
    if (self function_cbbdaadd(slotindex) == taskid) {
        self function_23dabaad(slotindex, delta);
    }
}

// Namespace zm_callings/zm_callings
// Params 2, eflags: 0x0
// Checksum 0xdf19e103, Offset: 0x1688
// Size: 0x1ca
function function_7cafbdd3(taskid, delta = 1) {
    if (self function_5034d1dc()) {
        callingtype = self function_e0c8bbf5();
        if (isdefined(callingtype)) {
            switch (callingtype) {
            case 1:
                self function_b87a79d2(taskid, 0, delta);
                self function_b87a79d2(taskid, 1, delta);
                self function_b87a79d2(taskid, 2, delta);
                break;
            case 2:
                self function_b87a79d2(taskid, 0, delta);
                self function_b87a79d2(taskid, 1, delta);
                self function_b87a79d2(taskid, 2, delta);
                self function_b87a79d2(taskid, 3, delta);
                break;
            case 3:
                self function_b87a79d2(taskid, 0, delta);
                self function_b87a79d2(taskid, 1, delta);
                break;
            }
        }
    }
}

// Namespace zm_callings/zm_callings
// Params 1, eflags: 0x4
// Checksum 0x3c70ec9, Offset: 0x1860
// Size: 0x58a
function private function_db6decae(e_attacker) {
    if (!isdefined(e_attacker)) {
        return;
    }
    if (!isplayer(e_attacker)) {
        return;
    }
    e_player = e_attacker;
    e_player function_7cafbdd3(1);
    if (isvehicle(self)) {
        str_damagemod = self.str_damagemod;
        w_damage = self.w_damage;
    } else {
        str_damagemod = self.damagemod;
        w_damage = self.damageweapon;
    }
    if (w_damage.isdualwield) {
        w_damage = w_damage.dualwieldweapon;
    }
    w_damage = zm_weapons::get_nonalternate_weapon(w_damage);
    if (zm_utility::is_headshot(w_damage, self.damagelocation, str_damagemod)) {
        e_player function_7cafbdd3(14);
    }
    if (str_damagemod == "MOD_MELEE") {
        e_player function_7cafbdd3(9);
    }
    if (zm_weapons::is_weapon_upgraded(w_damage)) {
        e_player function_7cafbdd3(10);
    }
    weapon_group = zm_utility::getweaponclasszm(w_damage);
    switch (weapon_group) {
    case #"weapon_assault":
        e_player function_7cafbdd3(2);
        break;
    case #"weapon_smg":
        e_player function_7cafbdd3(3);
        break;
    case #"weapon_lmg":
        e_player function_7cafbdd3(4);
        break;
    case #"weapon_sniper":
        e_player function_7cafbdd3(5);
        break;
    case #"weapon_cqb":
        e_player function_7cafbdd3(6);
        break;
    case #"weapon_tactical":
        e_player function_7cafbdd3(7);
        break;
    case #"weapon_pistol":
        e_player function_7cafbdd3(8);
        break;
    }
    switch (str_damagemod) {
    case #"mod_explosive":
    case #"mod_grenade":
    case #"mod_projectile":
    case #"mod_grenade_splash":
    case #"mod_projectile_splash":
        e_player function_7cafbdd3(11);
        break;
    }
    switch (w_damage.name) {
    case #"hero_sword_pistol_lv2":
    case #"hero_sword_pistol_lv3":
    case #"hero_sword_pistol_lv1":
    case #"hero_hammer_lv3":
    case #"hero_hammer_lv2":
    case #"hero_hammer_lv1":
    case #"hero_chakram_lv2":
    case #"hero_chakram_lv3":
    case #"hero_chakram_lv1":
    case #"hero_scepter_lv3":
    case #"hero_scepter_lv2":
    case #"hero_scepter_lv1":
        e_player function_7cafbdd3(12);
        break;
    case #"gun_mini_turret":
    case #"eq_wraith_fire":
    case #"sticky_grenade_extra":
    case #"eq_frag_grenade_extra":
    case #"eq_acid_bomb_extra":
    case #"eq_molotov_extra":
    case #"eq_frag_grenade":
    case #"claymore_extra":
    case #"eq_acid_bomb":
    case #"eq_molotov":
    case #"eq_wraith_fire_extra":
    case #"sticky_grenade":
    case #"claymore":
        e_player function_7cafbdd3(13);
        break;
    }
}

// Namespace zm_callings/zm_callings
// Params 0, eflags: 0x4
// Checksum 0x7e5b2dce, Offset: 0x1df8
// Size: 0xa8
function private earned_points_tracking() {
    level endon(#"end_game");
    while (true) {
        result = level waittill(#"earned_points");
        e_player = result.player;
        n_points = result.points;
        if (isdefined(e_player)) {
            e_player function_7cafbdd3(17, result.points);
        }
    }
}

