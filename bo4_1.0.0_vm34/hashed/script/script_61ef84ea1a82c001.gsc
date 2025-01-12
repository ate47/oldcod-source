#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_tomahawk;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_ab10cedb;

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x2
// Checksum 0x4c5eda86, Offset: 0x1d8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"hash_1f7228023b83d053", &__init__, &__main__, undefined);
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x0
// Checksum 0x8e5b72c0, Offset: 0x228
// Size: 0x236
function __init__() {
    clientfield::register("toplayer", "" + #"place_spoon", 1, 1, "int");
    clientfield::register("toplayer", "" + #"fill_blood", 1, 4, "int");
    clientfield::register("toplayer", "" + #"hash_2058d8d474a6b3e1", 1, 1, "int");
    clientfield::register("world", "" + #"hash_ef497244490a0fc", 1, 3, "int");
    level flag::init(#"hash_1a367a4a0dfb0471");
    level flag::init(#"hash_79e07d3dcfbfb5ae");
    level flag::init(#"hash_29dc018e9551ecf");
    level flag::init(#"spoon_quest_completed");
    level.var_7d904193 = struct::get("s_firm_use_trig");
    level.s_break_large_metal = struct::get("s_break_large_metal");
    level.var_5d0b024a = util::spawn_model("p8_fxanim_zm_esc_water_tower_mod", level.s_break_large_metal.origin, level.s_break_large_metal.angles);
    level.var_8150136c = getentarray("t_metal_piece", "targetname");
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x0
// Checksum 0x78206e4b, Offset: 0x468
// Size: 0x2d4
function __main__() {
    level flag::wait_till("all_players_spawned");
    if (!isdefined(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = [];
    } else if (!isarray(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
    }
    level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_b8f1b8ad;
    foreach (e_player in level.players) {
        e_player flag::init(#"hash_6b33efdeedf241f");
        e_player flag::init(#"hash_30ae3926b2d211db");
        e_player flag::init(#"hash_79ab766693ef2532");
        e_player clientfield::set_to_player("" + #"fill_blood", 1);
    }
    level.var_2354c816 = array(#"hash_67a31e96e8f4d0e9", #"hash_67a31b96e8f4cbd0", #"hash_67a31c96e8f4cd83", #"hash_67a32196e8f4d602");
    level flag::wait_till(#"spoon_quest_completed");
    zm_spawner::register_zombie_death_event_callback(&function_69693a55);
    foreach (e_player in getplayers()) {
        e_player thread function_76684f7e();
    }
    level function_d4d6fd52();
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x0
// Checksum 0x409f8d6a, Offset: 0x748
// Size: 0xea
function function_76684f7e() {
    self endon(#"disconnect");
    level.var_7d904193.var_a3d397b1 = level.var_7d904193 zm_unitrigger::create(&function_ff78a0e0, 128, &function_6ea74237);
    self.var_721c41ba = 0;
    self thread function_c777e4f9();
    self flag::wait_till(#"hash_30ae3926b2d211db");
    level.var_7d904193.var_c9d6121a = level.var_7d904193 zm_unitrigger::create(&function_d33eb24a, 128, &function_fc3e755);
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 1, eflags: 0x0
// Checksum 0xc392e6ea, Offset: 0x840
// Size: 0x134
function function_6ea74237(params) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (isplayer(e_player)) {
            break;
        }
    }
    e_player takeweapon(getweapon(#"spoon_alcatraz"));
    if (isdefined(e_player.var_22a7e110)) {
        e_player giveweapon(e_player.var_22a7e110);
    }
    e_player clientfield::set_to_player("" + #"place_spoon", 1);
    e_player flag::set(#"hash_6b33efdeedf241f");
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 1, eflags: 0x0
// Checksum 0x9da5757c, Offset: 0x980
// Size: 0x10c
function function_fc3e755(params) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (isplayer(e_player)) {
            break;
        }
    }
    e_player clientfield::set_to_player("" + #"place_spoon", 0);
    wait 0.1;
    e_player clientfield::set_to_player("" + #"fill_blood", 8);
    level flag::set(#"hash_1a367a4a0dfb0471");
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 1, eflags: 0x0
// Checksum 0x535c8c8b, Offset: 0xa98
// Size: 0x13c
function function_69693a55(e_player) {
    if (!isplayer(e_player)) {
        return;
    }
    if (!isdefined(e_player.var_721c41ba)) {
        return;
    }
    if (function_f098699f(self.damageweapon)) {
        if (e_player.var_a3b3320d) {
            e_player.var_721c41ba++;
            /#
                iprintln("<dev string:x30>" + e_player.var_721c41ba);
            #/
            e_player function_e3ce45bf(e_player.var_721c41ba);
        }
        if (e_player.var_721c41ba >= 60) {
            e_player notify(#"roof_kills_completed");
            e_player playsoundtoplayer(#"vox_zmba_event_magicbox_0", e_player);
            e_player.var_721c41ba = undefined;
            e_player flag::set(#"hash_30ae3926b2d211db");
        }
    }
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x0
// Checksum 0xb35a37ff, Offset: 0xbe0
// Size: 0x98
function function_c777e4f9() {
    self endon(#"disconnect", #"roof_kills_completed");
    while (true) {
        var_f97c401 = self zm_zonemgr::get_player_zone();
        if (var_f97c401 === "zone_roof" || var_f97c401 === "zone_roof_infirmary") {
            self.var_a3b3320d = 1;
        } else {
            self.var_a3b3320d = 0;
        }
        wait 1;
    }
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 1, eflags: 0x0
// Checksum 0xf19fe3a6, Offset: 0xc80
// Size: 0x1a2
function function_e3ce45bf(var_721c41ba) {
    switch (var_721c41ba) {
    case 10:
        self clientfield::set_to_player("" + #"fill_blood", 2);
        break;
    case 20:
        self clientfield::set_to_player("" + #"fill_blood", 3);
        break;
    case 30:
        self clientfield::set_to_player("" + #"fill_blood", 4);
        break;
    case 40:
        self clientfield::set_to_player("" + #"fill_blood", 5);
        break;
    case 50:
        self clientfield::set_to_player("" + #"fill_blood", 6);
        break;
    case 60:
        self clientfield::set_to_player("" + #"fill_blood", 7);
        break;
    }
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 1, eflags: 0x0
// Checksum 0xe0a1a255, Offset: 0xe30
// Size: 0x26
function function_f098699f(weapon_type) {
    switch (weapon_type.name) {
    case #"ww_blundergat_fire_t8":
    case #"ww_blundergat_fire_t8_upgraded":
    case #"ww_blundergat_acid_t8":
    case #"hash_3de0926b89369160":
    case #"hash_494f5501b3f8e1e9":
    case #"ww_blundergat_acid_t8_upgraded":
        return true;
    default:
        return false;
    }
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 1, eflags: 0x0
// Checksum 0xb71cb0ff, Offset: 0xee0
// Size: 0x5c
function function_ff78a0e0(e_player) {
    return e_player hasweapon(getweapon(#"spoon_alcatraz")) && e_player util::is_looking_at(self.origin);
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 1, eflags: 0x0
// Checksum 0xcaa821e0, Offset: 0xf48
// Size: 0x2a
function function_d33eb24a(e_player) {
    return e_player flag::get(#"hash_30ae3926b2d211db");
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x0
// Checksum 0x7592f2ed, Offset: 0xf80
// Size: 0xcc
function function_d4d6fd52() {
    /#
        level endon(#"hash_2386148c8bbd1bd5");
    #/
    level flag::wait_till(#"hash_1a367a4a0dfb0471");
    foreach (var_3575276d in level.var_8150136c) {
        var_3575276d thread function_795c7f09();
    }
    level function_8bbafde0();
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x0
// Checksum 0xc3d827e0, Offset: 0x1058
// Size: 0x214
function function_795c7f09() {
    self endon(#"death");
    level endon(#"end_game");
    n_script_int = self.script_int;
    self waittill(#"trigger");
    switch (n_script_int) {
    case 1:
        hidemiscmodels(self.target);
        level thread clientfield::set("" + #"hash_ef497244490a0fc", 1);
        break;
    case 2:
        hidemiscmodels(self.target);
        level thread clientfield::set("" + #"hash_ef497244490a0fc", 2);
        break;
    case 3:
        hidemiscmodels(self.target);
        level thread clientfield::set("" + #"hash_ef497244490a0fc", 3);
        break;
    case 4:
        hidemiscmodels(self.target);
        level thread clientfield::set("" + #"hash_ef497244490a0fc", 4);
        break;
    }
    self delete();
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 0, eflags: 0x0
// Checksum 0x6ca2eff4, Offset: 0x1278
// Size: 0x16c
function function_8bbafde0() {
    level flag::wait_till_all(level.var_2354c816);
    level flag::set(#"hash_79e07d3dcfbfb5ae");
    level.var_5d0b024a thread scene::play(#"p8_fxanim_zm_esc_water_tower_bundle", level.var_5d0b024a);
    level thread clientfield::increment("" + #"hash_cd028842e18845e", 1);
    wait 5;
    foreach (e_player in level.players) {
        e_player thread clientfield::set_to_player("" + #"hash_2058d8d474a6b3e1", 1);
    }
    level flag::set(#"hash_29dc018e9551ecf");
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 2, eflags: 0x0
// Checksum 0x50458da6, Offset: 0x13f0
// Size: 0x18c
function function_b8f1b8ad(e_grenade, n_grenade_charge_power) {
    s_spork = struct::get("s_s_t_loc");
    if (!isdefined(s_spork)) {
        return false;
    }
    if (distancesquared(e_grenade.origin, s_spork.origin) < 40000 && !self flag::get(#"hash_79ab766693ef2532")) {
        self clientfield::set_to_player("" + #"hash_2058d8d474a6b3e1", 0);
        mdl_tomahawk = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
        mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
        var_14b7e78b = util::spawn_model("wpn_t8_zm_spork_world", e_grenade.origin, s_spork.angles);
        var_14b7e78b linkto(mdl_tomahawk);
        self thread zm_weap_tomahawk::tomahawk_return_player(mdl_tomahawk, undefined, 800);
        self thread function_7b08207c(mdl_tomahawk, var_14b7e78b);
        return true;
    }
    return false;
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 2, eflags: 0x0
// Checksum 0x49c3792a, Offset: 0x1588
// Size: 0xf4
function function_7b08207c(mdl_tomahawk, mdl_spork) {
    self endon(#"disconnect");
    mdl_tomahawk waittill(#"death");
    mdl_spork delete();
    self playsoundtoplayer(level.zmb_laugh_alias, self);
    w_current = self.currentweapon;
    self giveweapon(getweapon(#"spork_alcatraz"));
    self switchtoweapon(w_current);
    self flag::set(#"hash_79ab766693ef2532");
}

// Namespace namespace_ab10cedb/namespace_ab10cedb
// Params 1, eflags: 0x0
// Checksum 0xedb1ee87, Offset: 0x1688
// Size: 0x54
function function_e14bcdb9(e_player) {
    return !e_player flag::get(#"hash_79ab766693ef2532") && level flag::get(#"hash_29dc018e9551ecf");
}

