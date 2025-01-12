#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace namespace_10544329;

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x2
// Checksum 0xb9a22b3f, Offset: 0x1b0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_7ca2cbd84515aff1", &__init__, undefined, undefined);
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0xc046c222, Offset: 0x1f8
// Size: 0x46c
function __init__() {
    clientfield::register("allplayers", "" + #"hash_26af481b9a9d41ce", 1, 1, "counter");
    clientfield::register("allplayers", "" + #"charge_gem", 1, 2, "int");
    clientfield::register("allplayers", "" + #"hash_275debebcd185ea1", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_dc971935944f005", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_6b725eefec5d09d1", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_73e9280f74528e8f", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_21ff5b4eccea85ff", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_64a830301c1adbf3", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_4f32455c6a0286cd", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_32ef1785f4e55e5c", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_2cd1bb15f71aedb8", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_1769e95fdb10dfae", 1, 1, "counter");
    level.var_6c69e11e = spawnstruct();
    level.var_6c69e11e.firestorm_weapon = getweapon(#"zhield_zword_turret");
    level.var_6c69e11e.melee_weapon = getweapon(#"zhield_zword_dw");
    callback::on_connect(&player_init);
    level.riotshield_melee = &function_2320278e;
    callback::add_weapon_fired(getweapon(#"zhield_zword_turret"), &function_91c12e44);
    callback::on_ai_killed(&function_cb4166e6);
    zm::register_zombie_damage_override_callback(&function_e25bc514);
    zm::register_zombie_damage_override_callback(&function_6527d3b4);
    level thread function_4199fea6();
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0x61d1ca2d, Offset: 0x670
// Size: 0x6c
function player_init() {
    self.var_6c69e11e = spawnstruct();
    self.var_6c69e11e.var_d1980c32 = 0;
    self.var_6c69e11e.n_charge_level = 0;
    self.var_6c69e11e.b_charged = 0;
    self.var_6c69e11e.var_faf5e24b = 0;
    self thread function_9a00318a();
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0x9e8036f1, Offset: 0x6e8
// Size: 0x282
function function_9a00318a() {
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"destroy_riotshield", #"flame_off", #"weapon_change");
        if (s_waitresult._notify == "weapon_change") {
            if (s_waitresult.last_weapon == level.var_6c69e11e.melee_weapon) {
                self clientfield::set("" + #"charge_gem", 0);
            } else if (s_waitresult.weapon == level.var_6c69e11e.melee_weapon) {
                self clientfield::set("" + #"charge_gem", self.var_6c69e11e.n_charge_level);
            }
            if (s_waitresult.weapon == level.var_6c69e11e.firestorm_weapon && self.var_6c69e11e.b_charged) {
                self clientfield::set("" + #"hash_275debebcd185ea1", 1);
            } else if (s_waitresult.last_weapon == level.var_6c69e11e.firestorm_weapon && self.var_6c69e11e.b_charged) {
                self clientfield::set("" + #"hash_275debebcd185ea1", 0);
            }
        }
        if (s_waitresult._notify == "destroy_riotshield" || s_waitresult._notify == "flame_off") {
            self clientfield::set("" + #"charge_gem", 0);
            self.var_6c69e11e.var_d1980c32 = 0;
            self.var_6c69e11e.n_charge_level = 0;
            self.var_6c69e11e.b_charged = 0;
            self.var_6c69e11e.var_faf5e24b = 0;
        }
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0x1eda7a90, Offset: 0x978
// Size: 0x22c
function function_2320278e(weapon) {
    if (!isdefined(level.riotshield_knockdown_enemies)) {
        level.riotshield_knockdown_enemies = [];
        level.riotshield_knockdown_gib = [];
        level.riotshield_fling_enemies = [];
        level.riotshield_fling_vecs = [];
    }
    self riotshield::riotshield_get_enemies_in_range();
    shield_damage = 0;
    level.var_75bba292 = 0;
    for (i = 0; i < level.riotshield_fling_enemies.size; i++) {
        riotshield::function_cea518ee();
        if (isdefined(level.riotshield_fling_enemies[i])) {
            level.riotshield_fling_enemies[i] thread riotshield::riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
            shield_damage += zombie_utility::get_zombie_var(#"riotshield_fling_damage_shield");
        }
    }
    for (i = 0; i < level.riotshield_knockdown_enemies.size; i++) {
        riotshield::function_cea518ee();
        level.riotshield_knockdown_enemies[i] thread riotshield::riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i]);
        shield_damage += zombie_utility::get_zombie_var(#"riotshield_knockdown_damage_shield");
    }
    level.riotshield_knockdown_enemies = [];
    level.riotshield_knockdown_gib = [];
    level.riotshield_fling_enemies = [];
    level.riotshield_fling_vecs = [];
    if (shield_damage && !self.var_6c69e11e.b_charged) {
        self riotshield::player_damage_shield(shield_damage, 0);
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0xe1f19f2a, Offset: 0xbb0
// Size: 0x86
function function_91c12e44(weapon) {
    if (!isdefined(self.var_6a32861a) || !self.var_6a32861a) {
        self.var_6a32861a = 1;
        self clientfield::increment("" + #"hash_26af481b9a9d41ce", 1);
        self waittill(#"end_firing");
        self.var_6a32861a = 0;
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0x14d62a99, Offset: 0xc40
// Size: 0x1f8
function function_cb4166e6(s_params) {
    e_attacker = s_params.eattacker;
    if (!isplayer(e_attacker)) {
        return;
    }
    if (s_params.weapon == level.var_6c69e11e.melee_weapon && !e_attacker.var_6c69e11e.b_charged) {
        e_attacker.var_6c69e11e.var_d1980c32++;
        n_charge = e_attacker.var_6c69e11e.var_d1980c32;
        if (n_charge >= 3) {
            e_attacker.var_6c69e11e.var_d1980c32 = 0;
            e_attacker.var_6c69e11e.n_charge_level++;
            e_attacker clientfield::set("" + #"charge_gem", e_attacker.var_6c69e11e.n_charge_level);
            if (e_attacker.var_6c69e11e.n_charge_level >= 3) {
                e_attacker notify(#"flame_on", {#ai_killed:self});
                e_attacker thread player_flame_on();
            }
        }
    }
    if (s_params.weapon == level.var_6c69e11e.melee_weapon && e_attacker.var_6c69e11e.b_charged) {
        e_attacker.var_6c69e11e.var_faf5e24b++;
        if (e_attacker.var_6c69e11e.var_faf5e24b >= 9) {
            e_attacker notify(#"flame_off");
        }
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0x399422fc, Offset: 0xe40
// Size: 0x16
function player_flame_on() {
    self.var_6c69e11e.b_charged = 1;
}

// Namespace namespace_10544329/zm_towers_shield
// Params 13, eflags: 0x0
// Checksum 0xa2f981a6, Offset: 0xe60
// Size: 0x1e6
function function_e25bc514(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (weapon != level.var_6c69e11e.melee_weapon) {
        return;
    }
    if (!isplayer(attacker)) {
        return;
    }
    if (!(isdefined(attacker.var_6c69e11e.b_charged) && attacker.var_6c69e11e.b_charged)) {
        return;
    }
    if (!isdefined(self.var_29ed62b2)) {
        return;
    }
    n_damage = damage;
    switch (self.var_29ed62b2) {
    case #"popcorn":
    case #"basic":
        if (level.round_number >= 30) {
            n_damage = self.maxhealth * 0.75;
        } else {
            n_damage = self.maxhealth + 666;
        }
        break;
    case #"heavy":
        n_damage = self.maxhealth * 0.3;
        break;
    case #"miniboss":
        n_damage = self.maxhealth * 0.15;
        break;
    case #"boss":
        n_damage = self.maxhealth * 0.05;
        break;
    }
    return n_damage;
}

// Namespace namespace_10544329/zm_towers_shield
// Params 13, eflags: 0x0
// Checksum 0x3811a995, Offset: 0x1050
// Size: 0x1e6
function function_6527d3b4(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (weapon != level.var_6c69e11e.firestorm_weapon) {
        return;
    }
    if (!isplayer(attacker)) {
        return;
    }
    if (!(isdefined(attacker.var_6c69e11e.b_charged) && attacker.var_6c69e11e.b_charged)) {
        return;
    }
    if (!isdefined(self.var_29ed62b2)) {
        return;
    }
    n_damage = damage;
    switch (self.var_29ed62b2) {
    case #"popcorn":
    case #"basic":
        if (level.round_number >= 30) {
            n_damage = self.maxhealth * 0.5;
        } else {
            n_damage = self.maxhealth + 666;
        }
        break;
    case #"heavy":
        n_damage = self.maxhealth * 0.05;
        break;
    case #"miniboss":
        n_damage = self.maxhealth * 0.035;
        break;
    case #"boss":
        n_damage = self.maxhealth * 0.003;
        break;
    }
    return n_damage;
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0xff29ac31, Offset: 0x1240
// Size: 0x1a4
function function_4199fea6() {
    callback::on_connect(&function_ac355862);
    level flag::init(#"hash_3551c4ab09311644");
    level flag::init(#"hash_392f20a71becaec7");
    level flag::init(#"hash_17425b597c04b9c3");
    var_c77a194 = getentarray("t_shield_quest_hit", "targetname");
    array::thread_all(var_c77a194, &function_bd4928ef);
    var_161e2a59 = struct::get(#"hash_727d8b7a91c0b9ba");
    s_katar = struct::get(#"hash_6ef4fc9a0ac3e3bc");
    var_bc17eaca = struct::get(#"hash_6dcfc8c42587d50d");
    var_161e2a59 thread function_cd1a621(#"lower");
    s_katar thread function_cd1a621(#"katar");
    var_bc17eaca thread function_cd1a621(#"upper");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0xb5d4d0ed, Offset: 0x13f0
// Size: 0x1b8
function function_cd1a621(str_piece) {
    level endon(#"end_game");
    self endon(#"death");
    switch (str_piece) {
    case #"lower":
        var_cf97a7b0 = #"hash_4752663d0689d2c2";
        var_58c87743 = #"hash_4246a36eeaccdedb";
        break;
    case #"katar":
        var_cf97a7b0 = #"hash_3c5ef4492a237f89";
        var_58c87743 = #"hash_1e11ea0627c40424";
        break;
    case #"upper":
        var_cf97a7b0 = #"hash_5be88bdaaf36eedf";
        var_58c87743 = #"hash_15ea02b45ed633fa";
        break;
    }
    self.var_f9ac5e7a = var_cf97a7b0;
    self.var_26d958bd = var_58c87743;
    s_unitrigger = self zm_unitrigger::create(&function_3999c35, 96);
    while (true) {
        s_waitresult = self waittill(#"trigger_activated");
        e_player = s_waitresult.e_who;
        if (e_player flag::get(var_cf97a7b0)) {
            e_player flag::set(var_58c87743);
        }
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0xee3c233e, Offset: 0x15b0
// Size: 0x170
function function_3999c35(e_player) {
    s_loc = self.stub.related_parent;
    var_cf97a7b0 = s_loc.var_f9ac5e7a;
    var_58c87743 = s_loc.var_26d958bd;
    b_enable = 0;
    if (e_player flag::get(var_cf97a7b0) && !e_player flag::get(var_58c87743)) {
        var_e12f52f6 = e_player zm_utility::is_player_looking_at(s_loc.origin, 0.9, 0);
        b_is_valid = zm_utility::is_player_valid(e_player, 0, 0);
        if (var_e12f52f6 && b_is_valid) {
            b_enable = 1;
        }
    }
    if (b_enable) {
        self sethintstringforplayer(e_player, #"hash_6f823e80320927c5");
    } else {
        self sethintstringforplayer(e_player, "");
    }
    return b_enable;
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0xa10294fe, Offset: 0x1728
// Size: 0x30c
function function_ac355862() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self flag::init(#"hash_3551c4ab09311644");
    self flag::init(#"hash_392f20a71becaec7");
    self flag::init(#"hash_17425b597c04b9c3");
    self flag::init(#"hash_3c9852bec865f6b3");
    self flag::init(#"hash_320a1da5bf925c8b");
    self flag::init(#"hash_1d380d2c916018c9");
    self flag::init(#"hash_1e015d048e504d45");
    self flag::init(#"hash_4752663d0689d2c2");
    self flag::init(#"hash_3c5ef4492a237f89");
    self flag::init(#"hash_5be88bdaaf36eedf");
    self flag::init(#"hash_4246a36eeaccdedb");
    self flag::init(#"hash_1e11ea0627c40424");
    self flag::init(#"hash_15ea02b45ed633fa");
    /#
        self thread function_505e76fa();
    #/
    self function_6c48a541(level flag::get(#"hash_3551c4ab09311644"));
    self function_2a31325a(level flag::get(#"hash_3551c4ab09311644"));
    self function_27bfb7ec(level flag::get(#"hash_392f20a71becaec7"));
    self function_7868a32f(level flag::get(#"hash_392f20a71becaec7"));
    self function_89fc7a38(level flag::get(#"hash_17425b597c04b9c3"));
    self function_ccb5e683(level flag::get(#"hash_17425b597c04b9c3"));
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0xc6ccc2f6, Offset: 0x1a40
// Size: 0xa4
function function_6c48a541(b_skipped = 0) {
    level endon(#"end_game");
    self endon(#"disconnect");
    if (b_skipped) {
        return;
    }
    self.var_daaad0ff = [];
    self flag::wait_till_any(array(#"hash_320a1da5bf925c8b", #"hash_3551c4ab09311644"));
}

// Namespace namespace_10544329/zm_towers_shield
// Params 2, eflags: 0x0
// Checksum 0x1ef3c430, Offset: 0x1af0
// Size: 0x9c
function function_2a31325a(b_skipped = 0, var_c86ff890 = 0) {
    level endon(#"end_game");
    self endon(#"disconnect");
    self flag::set(#"hash_320a1da5bf925c8b");
    self thread function_101888dc(#"lower");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0x30b483d3, Offset: 0x1b98
// Size: 0x210
function function_bd4928ef() {
    self notify("2564b0d20b5f3629");
    self endon("2564b0d20b5f3629");
    level endon(#"end_game");
    while (true) {
        s_waitresult = self waittill(#"damage");
        e_attacker = s_waitresult.attacker;
        w_weapon = s_waitresult.weapon;
        if (isplayer(e_attacker) && w_weapon === getweapon(#"zhield_zword_turret")) {
            if (!isdefined(e_attacker.var_daaad0ff)) {
                e_attacker.var_daaad0ff = [];
            } else if (!isarray(e_attacker.var_daaad0ff)) {
                e_attacker.var_daaad0ff = array(e_attacker.var_daaad0ff);
            }
            if (!isinarray(e_attacker.var_daaad0ff, self)) {
                e_attacker.var_daaad0ff[e_attacker.var_daaad0ff.size] = self;
            }
            if (e_attacker.var_daaad0ff.size >= 3) {
                e_attacker flag::set(#"hash_320a1da5bf925c8b");
                continue;
            }
            if (!e_attacker flag::get(#"hash_3c9852bec865f6b3")) {
                e_attacker flag::set(#"hash_3c9852bec865f6b3");
                e_attacker thread function_1542a404();
            }
        }
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0x1ade4d34, Offset: 0x1db0
// Size: 0x64
function function_1542a404() {
    self endon(#"disconnect");
    self waittill(#"death", #"end_firing");
    self.var_daaad0ff = [];
    self flag::clear(#"hash_3c9852bec865f6b3");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0x76267ae7, Offset: 0x1e20
// Size: 0xb4
function function_27bfb7ec(b_skipped = 0) {
    level endon(#"end_game");
    self endon(#"disconnect");
    if (b_skipped) {
        return;
    }
    self.var_c156c174 = [];
    self thread function_4328f76d();
    self flag::wait_till_any(array(#"hash_1d380d2c916018c9", #"hash_392f20a71becaec7"));
}

// Namespace namespace_10544329/zm_towers_shield
// Params 2, eflags: 0x0
// Checksum 0x8acac5ab, Offset: 0x1ee0
// Size: 0x9c
function function_7868a32f(b_skipped = 0, var_c86ff890 = 0) {
    level endon(#"end_game");
    self endon(#"disconnect");
    self flag::set(#"hash_1d380d2c916018c9");
    self thread function_101888dc(#"katar");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0x4a4f7c65, Offset: 0x1f88
// Size: 0x27e
function function_4328f76d() {
    self notify("7677c7af6156a36e");
    self endon("7677c7af6156a36e");
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"flame_on");
        ai_killed = s_waitresult.ai_killed;
        if (isdefined(ai_killed)) {
            switch (ai_killed.archetype) {
            case #"catalyst":
                if (isdefined(self.var_c156c174)) {
                    if (!isdefined(self.var_c156c174)) {
                        self.var_c156c174 = [];
                    } else if (!isarray(self.var_c156c174)) {
                        self.var_c156c174 = array(self.var_c156c174);
                    }
                    if (!isinarray(self.var_c156c174, ai_killed.var_ea94c12a)) {
                        self.var_c156c174[self.var_c156c174.size] = ai_killed.var_ea94c12a;
                    }
                    if (self.var_c156c174.size >= 4) {
                        self flag::set(#"hash_1d380d2c916018c9");
                    }
                }
                break;
            case #"gladiator":
                if (isdefined(self.var_ec05dbea)) {
                    if (!isdefined(self.var_ec05dbea)) {
                        self.var_ec05dbea = [];
                    } else if (!isarray(self.var_ec05dbea)) {
                        self.var_ec05dbea = array(self.var_ec05dbea);
                    }
                    if (!isinarray(self.var_ec05dbea, ai_killed.var_ea94c12a)) {
                        self.var_ec05dbea[self.var_ec05dbea.size] = ai_killed.var_ea94c12a;
                    }
                    if (self.var_ec05dbea.size >= 2) {
                        self flag::set(#"hash_1e015d048e504d45");
                    }
                }
                break;
            }
        }
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0x2f789a78, Offset: 0x2210
// Size: 0xb4
function function_89fc7a38(b_skipped = 0) {
    level endon(#"end_game");
    self endon(#"disconnect");
    if (b_skipped) {
        return;
    }
    self.var_ec05dbea = [];
    self thread function_4328f76d();
    self flag::wait_till_any(array(#"hash_1e015d048e504d45", #"hash_17425b597c04b9c3"));
}

// Namespace namespace_10544329/zm_towers_shield
// Params 2, eflags: 0x0
// Checksum 0x8432c684, Offset: 0x22d0
// Size: 0x9c
function function_ccb5e683(b_skipped = 0, var_c86ff890 = 0) {
    level endon(#"end_game");
    self endon(#"disconnect");
    self flag::set(#"hash_1e015d048e504d45");
    self thread function_101888dc(#"upper");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 1, eflags: 0x0
// Checksum 0xcc9161c7, Offset: 0x2378
// Size: 0x2ec
function function_101888dc(str_piece) {
    self endon(#"disconnect");
    switch (str_piece) {
    case #"lower":
        var_387a15ae = "" + #"hash_dc971935944f005";
        var_3be39f92 = "" + #"hash_6b725eefec5d09d1";
        var_8a353644 = "" + #"hash_73e9280f74528e8f";
        str_trigger = "t_shield_quest_lower_drop";
        var_cf97a7b0 = #"hash_4752663d0689d2c2";
        var_58c87743 = #"hash_4246a36eeaccdedb";
        n_drop_time = 1;
        break;
    case #"katar":
        var_387a15ae = "" + #"hash_21ff5b4eccea85ff";
        var_3be39f92 = "" + #"hash_64a830301c1adbf3";
        var_8a353644 = "" + #"hash_4f32455c6a0286cd";
        str_trigger = "t_shield_quest_katar_drop";
        var_cf97a7b0 = #"hash_3c5ef4492a237f89";
        var_58c87743 = #"hash_1e11ea0627c40424";
        n_drop_time = 0;
        break;
    case #"upper":
        var_387a15ae = "" + #"hash_32ef1785f4e55e5c";
        var_3be39f92 = "" + #"hash_2cd1bb15f71aedb8";
        var_8a353644 = "" + #"hash_1769e95fdb10dfae";
        str_trigger = "t_shield_quest_upper_drop";
        var_cf97a7b0 = #"hash_5be88bdaaf36eedf";
        var_58c87743 = #"hash_15ea02b45ed633fa";
        n_drop_time = 0.5;
        break;
    }
    self clientfield::increment_to_player(var_387a15ae);
    if (str_piece != #"katar") {
        trigger::wait_till(str_trigger, "targetname", self);
    }
    self clientfield::increment_to_player(var_3be39f92);
    if (n_drop_time > 0) {
        wait n_drop_time;
    }
    self flag::set(var_cf97a7b0);
    self flag::wait_till(var_58c87743);
    self clientfield::increment_to_player(var_8a353644);
}

/#

    // Namespace namespace_10544329/zm_towers_shield
    // Params 0, eflags: 0x4
    // Checksum 0x58158c12, Offset: 0x2670
    // Size: 0xf4
    function private function_505e76fa() {
        level endon(#"end_game");
        self endon(#"disconnect");
        level flag::wait_till(#"hash_3551c4ab09311644");
        self flag::set(#"hash_3551c4ab09311644");
        level flag::wait_till(#"hash_392f20a71becaec7");
        self flag::set(#"hash_392f20a71becaec7");
        level flag::wait_till(#"hash_17425b597c04b9c3");
        self flag::set(#"hash_17425b597c04b9c3");
    }

#/
