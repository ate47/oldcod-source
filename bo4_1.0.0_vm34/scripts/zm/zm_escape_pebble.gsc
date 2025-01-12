#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_flamethrower;
#using scripts\zm\weapons\zm_weap_katana;
#using scripts\zm\weapons\zm_weap_spectral_shield;
#using scripts\zm\weapons\zm_weap_tomahawk;
#using scripts\zm\zm_escape_util;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\util\ai_dog_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace pebble;

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x2
// Checksum 0x5a687da1, Offset: 0x5c8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_escape_pebble", &__init__, &__main__, undefined);
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x7f8248c7, Offset: 0x618
// Size: 0x34
function __init__() {
    init_clientfield();
    init_flags();
    init_quests();
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0xa254c867, Offset: 0x658
// Size: 0x16c
function __main__() {
    level flag::wait_till(#"all_players_spawned");
    level thread function_48a79d3f();
    level thread function_1f2eeab6();
    if (zm_custom::function_5638f689(#"hash_3c5363541b97ca3e") && getdvarint(#"zm_ee_enabled", 0)) {
        zm_sq::start(#"jump_scare");
        zm_sq::start(#"drawings");
        zm_sq::start(#"narrative_room");
        level thread function_f5340959();
    }
    if (getdvarint(#"zm_ee_enabled", 0)) {
        level thread function_3fee167b();
    }
    level thread function_b0c3e93f();
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0xceac9cb5, Offset: 0x7d0
// Size: 0x1c4
function init_clientfield() {
    clientfield::register("actor", "" + #"hash_7792af358100c735", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_92008cb81480da0", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter");
    clientfield::register("world", "" + #"narrative_room", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_46dbc12bdc275121", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_59623b8b4fc694c8", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_ce418c45d804842", 1, 1, "counter");
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x8ef7adb0, Offset: 0x9a0
// Size: 0x24
function init_flags() {
    level flag::init(#"hash_731f4115fe0cbef");
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x58470616, Offset: 0x9d0
// Size: 0x524
function init_quests() {
    zm_sq::register(#"jump_scare", #"1", #"hash_3203b932029a4e0b", &jump_scare, &jump_scare_cleanup);
    zm_sq::register(#"drawings", #"1", #"drawings_quest", &function_6fff3e95, &drawings_cleanup);
    zm_sq::register(#"narrative_room", #"1", #"hash_64d6af5ddc324d26", &function_c6856b74, &function_774512bd);
    zm_sq::register(#"narrative_room", #"2", #"hash_3f567f217222e5b2", &narrative_room, &narrative_room_cleanup);
    zm_sq::register(#"hash_e1a54725ab6e00b", #"hash_66e936afdcdd5d4d", #"hash_574005386f679cf6", &function_ae09b7d0, &function_61389901);
    zm_sq::register(#"hash_e1a54725ab6e00b", #"hash_385585cb6cbead68", #"hash_574004386f679b43", &function_2011270b, &function_bcbec34e);
    zm_sq::register(#"hash_e1a54725ab6e00b", #"hash_42a50f35aa200869", #"hash_574003386f679990", &function_fa0eaca2, &function_97971ff7);
    zm_sq::register(#"monkey_bomb", #"hash_438156183f3f5ffa", #"monkey_bomb_step_1", &function_2ddba04b, &function_186af98e);
    zm_sq::register(#"monkey_bomb", #"hash_bf8e42b419290b3", #"monkey_bomb_step_2", &function_bbd43110, &function_1fd35041);
    if (getdvarint(#"zm_ee_enabled", 0)) {
        if (!isdefined(level.a_tomahawk_pickup_funcs)) {
            level.a_tomahawk_pickup_funcs = [];
        } else if (!isarray(level.a_tomahawk_pickup_funcs)) {
            level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
        }
        level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_342f6a9;
        if (!isdefined(level.a_tomahawk_pickup_funcs)) {
            level.a_tomahawk_pickup_funcs = [];
        } else if (!isarray(level.a_tomahawk_pickup_funcs)) {
            level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
        }
        level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_f10a9825;
        if (zm_custom::function_5638f689(#"zmequipmentisenabled")) {
            zm_sq::start(#"hash_e1a54725ab6e00b");
        }
    }
    if (zm_custom::function_5638f689(#"zmequipmentisenabled")) {
        zm_sq::start(#"monkey_bomb", 1);
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x641f0a90, Offset: 0xf00
// Size: 0x1c
function on_player_connect() {
    self thread track_player_eyes();
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x73bf23bc, Offset: 0xf28
// Size: 0x24
function function_c6856b74(var_4df52d26) {
    level waittill(#"fake_waittill");
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x347aa8f3, Offset: 0xf58
// Size: 0x14
function function_774512bd(var_4df52d26, var_c86ff890) {
    
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x31b9cb07, Offset: 0xf78
// Size: 0xcc
function narrative_room(var_4df52d26) {
    mdl_door = getent("cr_door", "targetname");
    mdl_door rotateyaw(90, 1.6);
    var_3adde794 = getent("cr_door_bar", "targetname");
    var_3adde794 delete();
    level clientfield::set("" + #"narrative_room", 1);
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0xa5bb7c1c, Offset: 0x1050
// Size: 0x14
function narrative_room_cleanup(var_4df52d26, var_c86ff890) {
    
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x111be65a, Offset: 0x1070
// Size: 0x306
function function_48a79d3f() {
    var_a11baa62 = array("double_points", "full_ammo", "insta_kill");
    if (!zm_custom::function_5638f689("zmPowerupDouble")) {
        arrayremovevalue(var_a11baa62, "double_points");
    }
    if (!zm_custom::function_5638f689("zmPowerupMaxAmmo")) {
        arrayremovevalue(var_a11baa62, "full_ammo");
    }
    if (!zm_custom::function_5638f689("zmPowerupInstakill")) {
        arrayremovevalue(var_a11baa62, "insta_kill");
    }
    if (var_a11baa62.size == 0) {
        return;
    } else if (var_a11baa62.size == 1) {
        str_value = var_a11baa62[0];
        if (!isdefined(var_a11baa62)) {
            var_a11baa62 = [];
        } else if (!isarray(var_a11baa62)) {
            var_a11baa62 = array(var_a11baa62);
        }
        var_a11baa62[var_a11baa62.size] = str_value;
    }
    var_a11baa62 = array::randomize(var_a11baa62);
    for (i = 1; i <= 2; i++) {
        var_bf9ad0e6 = struct::get("powerup_cell_" + i, "targetname");
        var_bf9ad0e6.var_2e1c56d6 = var_a11baa62[i - 1];
        var_124e4b77 = level.zombie_powerups[var_a11baa62[i - 1]].model_name;
        var_10b98bdf = util::spawn_model(var_124e4b77, var_bf9ad0e6.origin + (0, 0, 40), var_bf9ad0e6.angles);
        var_10b98bdf thread function_7cff5f64();
        var_10b98bdf clientfield::set("powerup_fx", 1);
        var_bf9ad0e6.var_10b98bdf = var_10b98bdf;
        var_ccf99daf = getent("cell_shock_box_" + i, "script_string");
        var_ccf99daf thread function_c58ebe94(i, var_bf9ad0e6);
    }
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x7905a483, Offset: 0x1380
// Size: 0x136
function function_c58ebe94(n_index, var_bf9ad0e6) {
    self waittill(#"hash_7e1d78666f0be68b");
    var_bf9ad0e6.var_10b98bdf notify(#"finish_wobble");
    var_bf9ad0e6.var_10b98bdf delete();
    spawn_infinite_powerup_drop(var_bf9ad0e6.origin, var_bf9ad0e6.var_2e1c56d6);
    mdl_door = getent("powerup_cell_door_" + n_index, "targetname");
    if (n_index == 1) {
        mdl_door movex(36, 2, 1);
    } else if (n_index == 2) {
        mdl_door movex(-34, 2, 1);
    }
    self notify(#"hash_7f8e7011812dff48");
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x10069d00, Offset: 0x14c0
// Size: 0x5a
function spawn_infinite_powerup_drop(v_origin, str_type) {
    level._powerup_timeout_override = &function_5af039ad;
    e_powerup = zm_powerups::specific_powerup_drop(str_type, v_origin);
    level._powerup_timeout_override = undefined;
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1528
// Size: 0x4
function function_5af039ad() {
    
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x5ca2231c, Offset: 0x1538
// Size: 0x38
function function_7cff5f64() {
    self endon(#"finish_wobble");
    while (isdefined(self)) {
        self zm_escape_util::make_wobble();
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x3f38436f, Offset: 0x1578
// Size: 0xac
function jump_scare(var_4df52d26) {
    foreach (player in level.players) {
        player thread track_player_eyes();
    }
    callback::on_connect(&on_player_connect);
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x2eb8721a, Offset: 0x1630
// Size: 0x210
function track_player_eyes() {
    self notify(#"track_player_eyes");
    self endon(#"disconnect", #"track_player_eyes");
    b_saw_the_wth = 0;
    var_6523688f = struct::get("s_sq_wth", "targetname");
    while (!b_saw_the_wth) {
        n_time = 0;
        while (self adsbuttonpressed() && n_time < 25) {
            n_time++;
            waitframe(1);
        }
        if (n_time >= 25 && self adsbuttonpressed() && self zm_zonemgr::entity_in_zone("zone_catwalk_03") && is_weapon_sniper(self getcurrentweapon()) && zm_utility::is_player_looking_at(var_6523688f.origin, 0.9, 0, undefined)) {
            self zm_utility::do_player_general_vox("general", "scare_react", undefined, 100);
            self clientfield::increment_to_player("" + #"hash_f2d0b920043dbbd", 1);
            j_time = 0;
            while (self adsbuttonpressed() && j_time < 5) {
                j_time++;
                waitframe(1);
            }
            b_saw_the_wth = 1;
        }
        waitframe(1);
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x4
// Checksum 0x39fb9230, Offset: 0x1848
// Size: 0x34
function private is_weapon_sniper(w_weapon) {
    if (isdefined(w_weapon.issniperweapon) && w_weapon.issniperweapon) {
        return true;
    }
    return false;
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0xff44c462, Offset: 0x1888
// Size: 0x14
function jump_scare_cleanup(var_4df52d26, var_c86ff890) {
    
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x426c32ee, Offset: 0x18a8
// Size: 0xc
function function_6fff3e95(var_4df52d26) {
    
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0xc4ba6706, Offset: 0x18c0
// Size: 0x14
function drawings_cleanup(var_4df52d26, var_c86ff890) {
    
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x4
// Checksum 0x611b5c73, Offset: 0x18e0
// Size: 0x1ac
function private function_4f747a76() {
    var_f35a71d9 = getent("graphic_01", "targetname");
    var_f35a71d9 setscale(0.7);
    var_8e78960b = getent("graphic_01_mover", "targetname");
    var_f35a71d9 linkto(var_8e78960b);
    t_damage = spawn("trigger_damage", var_8e78960b.origin, 0, 64, 64);
    v_end_pos = (-1052.89, 8901.02, 1362);
    while (true) {
        s_result = t_damage waittill(#"damage");
        if (isplayer(s_result.attacker)) {
            if (zm_weap_flamethrower::is_flamethrower_weapon(s_result.weapon, 3) && isdefined(s_result.attacker.var_8f4c892)) {
                break;
            }
        }
    }
    var_8e78960b moveto(v_end_pos, 0.4);
    t_damage delete();
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x4
// Checksum 0x2c9aa971, Offset: 0x1a98
// Size: 0x1ac
function private function_d3be26fa() {
    var_3ec7040 = getent("graphic_02_mover", "targetname");
    t_damage = spawn("trigger_damage", var_3ec7040.origin, 0, 64, 64);
    while (true) {
        s_result = t_damage waittill(#"damage");
        if (isplayer(s_result.attacker) && s_result.attacker hasperk(#"specialty_electriccherry")) {
            if (s_result.weapon == getweapon(#"spoon_alcatraz") || s_result.weapon == getweapon(#"spork_alcatraz") || s_result.weapon == getweapon(#"spknifeork")) {
                break;
            }
        }
    }
    var_3ec7040 rotateyaw(-65.9, 0.4);
    t_damage delete();
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x4
// Checksum 0x7f723528, Offset: 0x1c50
// Size: 0x1b4
function private function_9070feb8() {
    var_6d7e66d5 = getent("graphic_03_mover", "targetname");
    t_damage = spawn("trigger_damage", var_6d7e66d5.origin + (0, 0, -10), 0, 64, 64);
    v_end_pos = (-432, 9110, 1397);
    v_end_angles = (38, 90, 0);
    while (true) {
        s_result = t_damage waittill(#"damage");
        if (isplayer(s_result.attacker)) {
            if (s_result.weapon === getweapon(#"spork_alcatraz") || s_result.weapon == getweapon(#"spknifeork")) {
                break;
            }
        }
    }
    var_6d7e66d5 moveto(v_end_pos, 0.4);
    var_6d7e66d5 rotateto(v_end_angles, 0.4);
    t_damage delete();
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x4
// Checksum 0x8c94ddff, Offset: 0x1e10
// Size: 0x114
function private function_6c7d6191() {
    var_6561e114 = getent("graphic_04", "targetname");
    t_damage = spawn("trigger_damage", var_6561e114.origin, 0, 64, 64);
    while (true) {
        s_result = t_damage waittill(#"damage");
        if (isplayer(s_result.attacker)) {
            if (zm_weap_katana::function_78220d55(s_result.weapon, 2)) {
                break;
            }
        }
    }
    var_6561e114 movex(7.5, 0.4);
    t_damage delete();
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x4
// Checksum 0xbeb6f489, Offset: 0x1f30
// Size: 0x104
function private function_ea081a34() {
    var_8b645b7d = getent("graphic_05", "targetname");
    v_end_pos = (139.543, 6704.51, 98.597);
    while (true) {
        s_result = level waittill(#"hero_weapon_activated");
        if (isplayer(s_result.e_player) && distance2d(s_result.e_player.origin, var_8b645b7d.origin) <= 128) {
            break;
        }
    }
    var_8b645b7d moveto(v_end_pos, 0.4);
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x5d31fc53, Offset: 0x2040
// Size: 0x298
function function_c665b7a3(var_fb5e0d37) {
    level notify(#"hash_433df71d489240ab");
    level endon(#"hash_433df71d489240ab");
    level endoncallback(&function_e86c3f61, #"hash_3698278a3a5d8beb");
    self endoncallback(&function_e86c3f61, #"stop_damage", #"hash_6ce63d9afba84f4c");
    mdl_lock = getent("box_lock", "targetname");
    if (!isdefined(mdl_lock) || mdl_lock != var_fb5e0d37) {
        return;
    }
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        return;
    }
    if (isdefined(mdl_lock.var_3fd14f21) && mdl_lock.var_3fd14f21) {
        return;
    }
    if (!isdefined(mdl_lock.n_start_time)) {
        mdl_lock.n_start_time = gettime();
    }
    if (!isdefined(mdl_lock.var_4e954263)) {
        mdl_lock.var_4e954263 = 1;
    }
    var_382c276e = self getentitynumber();
    mdl_lock clientfield::set("zombie_spectral_key_stun", var_382c276e + 1);
    while (true) {
        mdl_lock waittill(#"hash_2afc3e42ad78d30e");
        n_time = gettime();
        if (isdefined(mdl_lock) && !isdefined(mdl_lock.var_3fd14f21) && n_time - mdl_lock.n_start_time > 1000) {
            mdl_lock.var_3fd14f21 = 1;
            mdl_lock setmodel(#"hash_41df1b7f74511221");
            mdl_lock clientfield::set("" + #"hash_92008cb81480da0", 1);
            mdl_lock clientfield::set("zombie_spectral_key_stun", 0);
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x4e69dcfd, Offset: 0x22e0
// Size: 0xa4
function function_e86c3f61() {
    mdl_lock = getent("box_lock", "targetname");
    if (!isdefined(mdl_lock)) {
        return;
    }
    if (!isdefined(mdl_lock.var_3fd14f21) && isdefined(mdl_lock.n_start_time)) {
        mdl_lock.n_start_time = undefined;
    }
    if (isdefined(mdl_lock.var_4e954263)) {
        mdl_lock.var_4e954263 = undefined;
    }
    mdl_lock clientfield::set("zombie_spectral_key_stun", 0);
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0xa507dac7, Offset: 0x2390
// Size: 0x23c
function function_f10a9825(e_grenade, n_grenade_charge_power) {
    mdl_lock = getent("box_lock", "targetname");
    if (!isdefined(mdl_lock)) {
        return false;
    }
    if (distancesquared(e_grenade.origin, mdl_lock.origin) < 10000 && isdefined(mdl_lock.var_3fd14f21) && mdl_lock.var_3fd14f21 && !isdefined(mdl_lock.var_988f575f) && !self hasweapon(getweapon(#"zhield_spectral_dw_upgraded"))) {
        mdl_lock.var_988f575f = 1;
        mdl_lock ghost();
        level notify(#"hash_5002eab927d4056d");
        level thread zm_audio::sndannouncerplayvox("shield_upgrade");
        mdl_tomahawk = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
        mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
        var_656684f9 = util::spawn_model(level.chest_joker_model, e_grenade.origin, mdl_lock.angles);
        var_656684f9 linkto(mdl_tomahawk);
        self thread zm_weap_tomahawk::tomahawk_return_player(mdl_tomahawk, undefined, 800);
        self thread function_eb750df(mdl_tomahawk, var_656684f9);
        var_656684f9 clientfield::set("" + #"hash_92008cb81480da0", 1);
        return true;
    }
    return false;
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x60597bbc, Offset: 0x25d8
// Size: 0x13c
function function_eb750df(mdl_tomahawk, mdl_lock) {
    self endon(#"disconnect");
    while (isdefined(mdl_tomahawk)) {
        waitframe(1);
    }
    mdl_lock delete();
    if (self hasweapon(getweapon(#"zhield_spectral_dw"))) {
        self takeweapon(getweapon(#"zhield_spectral_dw"));
    }
    self giveweapon(getweapon(#"zhield_spectral_dw_upgraded"));
    self switchtoweapon(getweapon(#"zhield_spectral_dw_upgraded"));
    self thread zm_audio::create_and_play_dialog("shield", "upgrade", undefined, 1);
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0xc4373b6d, Offset: 0x2720
// Size: 0xc6
function function_ae09b7d0(var_4df52d26) {
    if (getdvarint(#"zm_ee_enabled", 0)) {
        callback::on_connect(&function_14c43482);
    }
    /#
        level thread function_32d5a799();
    #/
    if (!var_4df52d26) {
        var_67894141 = "" + #"hash_574005386f679cf6" + "_";
        level waittill(var_67894141 + "completed", var_67894141 + "skipped_over", var_67894141 + "ended_early");
    }
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x8cb17287, Offset: 0x27f0
// Size: 0xcc
function function_61389901(var_4df52d26, var_c86ff890) {
    if (var_4df52d26 || var_c86ff890) {
        foreach (e_player in level.activeplayers) {
            e_player flag::set(#"hash_18c7b52cebad7171");
        }
        callback::remove_on_ai_killed(&function_1950b996);
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x55cd0e6e, Offset: 0x28c8
// Size: 0x12c
function function_14c43482() {
    self endon(#"disconnect");
    self.var_92c1a2b7 = 0;
    self flag::init(#"hash_46915cd7994e2d33");
    self flag::init(#"hash_18c7b52cebad7171");
    self flag::init(#"hash_120fbb364796cd32");
    self flag::init(#"hash_11ab20934759ebc3");
    while (!isdefined(self.var_187e198d)) {
        self.var_187e198d = self._gadgets_player[1];
        wait 1;
    }
    self flag::wait_till(#"hash_46915cd7994e2d33");
    self thread function_56abda1f();
    level callback::on_ai_killed(&function_1950b996);
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0xe877b95b, Offset: 0x2a00
// Size: 0x23a
function function_56abda1f() {
    self endon(#"disconnect", #"hash_18c7b52cebad7171");
    a_s_urns = struct::get_array("mg_fire_urn", "targetname");
    var_5356fa0c = [];
    foreach (s_urn in a_s_urns) {
        if (isdefined(s_urn.var_212fa898) && s_urn.var_212fa898) {
            if (!isdefined(var_5356fa0c)) {
                var_5356fa0c = [];
            } else if (!isarray(var_5356fa0c)) {
                var_5356fa0c = array(var_5356fa0c);
            }
            var_5356fa0c[var_5356fa0c.size] = s_urn;
        }
    }
    while (true) {
        s_result = self waittill(#"throwing_tomahawk");
        e_tomahawk = s_result.e_grenade;
        self thread function_8dd115d9(e_tomahawk);
        if (!self zm_zonemgr::is_player_in_zone(array("zone_catwalk_01", "zone_catwalk_02", "zone_catwalk_03", "zone_catwalk_04"))) {
            continue;
        }
        while (isdefined(e_tomahawk)) {
            if (isdefined(self.var_fa61bb16)) {
                e_tomahawk clientfield::set("tomahawk_trail_fx", 2);
                self thread function_f5b46b23();
                break;
            }
            wait 0.1;
        }
    }
    return false;
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x3b1aba18, Offset: 0x2c48
// Size: 0xc4
function function_8dd115d9(e_tomahawk) {
    self notify(#"hash_381a1d8c3e2bdb50");
    self endon(#"disconnect", #"hash_18c7b52cebad7171", #"hash_381a1d8c3e2bdb50");
    var_e45ae26b = getent("t_pebble_is_on_fire", "targetname");
    while (true) {
        if (self istouching(var_e45ae26b)) {
            self.var_fa61bb16 = 1;
        } else {
            self.var_fa61bb16 = undefined;
        }
        wait 0.1;
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0xb9721e22, Offset: 0x2d18
// Size: 0xe4
function function_f5b46b23(e_tomahawk) {
    self notify(#"hash_67898531e66a70ff");
    self endon(#"disconnect", #"hash_18c7b52cebad7171", #"hash_67898531e66a70ff");
    e_volume = getent("e_hr_yard_volume", "targetname");
    while (true) {
        if (!self istouching(e_volume) && isdefined(self.var_fa61bb16)) {
            self.var_92c1a2b7 = 0;
            self.var_fa61bb16 = undefined;
            self notify(#"hash_67898531e66a70ff");
        }
        wait 0.1;
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0xfe232e71, Offset: 0x2e08
// Size: 0x26c
function function_1950b996(s_params) {
    if (self.archetype != "zombie") {
        return;
    }
    if (!isplayer(s_params.eattacker) || !isdefined(s_params.eattacker.var_fa61bb16)) {
        return;
    }
    if (s_params.weapon != getweapon(#"tomahawk_t8")) {
        return;
    }
    str_zone_name = s_params.eattacker zm_zonemgr::get_player_zone();
    if (!issubstr(str_zone_name, "zone_catwalk")) {
        return;
    }
    if (isdefined(s_params.eattacker.var_fa61bb16) && s_params.eattacker.var_fa61bb16 && !s_params.eattacker flag::get(#"hash_18c7b52cebad7171") && !isdefined(self.var_aee6f262)) {
        self thread zombie_death::flame_death_fx();
        self.var_aee6f262 = 1;
        s_params.eattacker.var_92c1a2b7++;
        /#
            iprintln("<dev string:x30>" + s_params.eattacker.var_92c1a2b7);
        #/
        if (s_params.eattacker.var_92c1a2b7 >= 30) {
            s_params.eattacker flag::set(#"hash_18c7b52cebad7171");
            s_params.eattacker playsoundtoplayer(#"hash_6e048d37333004da", s_params.eattacker);
            s_params.eattacker thread function_cf318ef0();
            /#
                iprintln("<dev string:x4b>");
            #/
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0xb686416, Offset: 0x3080
// Size: 0xe6
function function_2011270b(var_4df52d26) {
    foreach (e_player in level.activeplayers) {
        e_player thread function_cf318ef0();
    }
    if (!var_4df52d26) {
        var_67894141 = "" + #"hash_574004386f679b43" + "_";
        level waittill(var_67894141 + "completed", var_67894141 + "skipped_over", var_67894141 + "ended_early");
    }
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0xc6e73253, Offset: 0x3170
// Size: 0x198
function function_bcbec34e(var_4df52d26, var_c86ff890) {
    if (var_4df52d26 || var_c86ff890) {
        foreach (e_player in level.activeplayers) {
            e_player flag::set(#"hash_120fbb364796cd32");
            if (isdefined(e_player.var_28fe57bb)) {
                e_player.var_28fe57bb delete();
            }
            if (isdefined(e_player.var_570dca64)) {
                e_player.var_570dca64 setvisibletoplayer(e_player);
            }
            if (e_player hasweapon(getweapon(#"tomahawk_t8"))) {
                e_player takeweapon(getweapon(#"tomahawk_t8"));
                if (isdefined(e_player.var_187e198d)) {
                    e_player giveweapon(e_player.var_187e198d);
                }
            }
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x92fb6ab2, Offset: 0x3310
// Size: 0x164
function function_cf318ef0() {
    self endon(#"disconnect");
    var_df87d0bb = struct::get_array("hr_step_2_glyph");
    for (var_30e15430 = array::random(var_df87d0bb); isdefined(var_30e15430.e_owner); var_30e15430 = array::random(var_df87d0bb)) {
    }
    mdl_glyph = util::spawn_model(#"p8_zm_esc_dream_catcher_blue", var_30e15430.origin, var_30e15430.angles);
    var_30e15430.mdl_glyph = mdl_glyph;
    var_30e15430.e_owner = self;
    self.var_30e15430 = var_30e15430;
    mdl_glyph setinvisibletoall();
    if (self.currentweapon == level.var_3d9066fe || self.currentweapon == level.var_cc1a6c85) {
        mdl_glyph setvisibletoplayer(self);
    }
    self thread function_8baacea7(var_30e15430);
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x18dbf9b5, Offset: 0x3480
// Size: 0x100
function function_8baacea7(var_30e15430) {
    self endoncallback(&function_f79d27a, #"disconnect", #"hash_120fbb364796cd32");
    while (true) {
        s_result = self waittill(#"weapon_change");
        if (isdefined(var_30e15430.mdl_glyph)) {
            if (s_result.weapon == level.var_3d9066fe || s_result.weapon == level.var_cc1a6c85) {
                var_30e15430.mdl_glyph setvisibletoplayer(self);
                continue;
            }
            wait 1.25;
            if (isdefined(var_30e15430.mdl_glyph)) {
                var_30e15430.mdl_glyph setinvisibletoplayer(self);
            }
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x49d22ea6, Offset: 0x3588
// Size: 0x6a
function function_f79d27a(str_notify) {
    if (str_notify == "disconnect") {
        if (isdefined(self.var_30e15430)) {
            if (isdefined(self.var_30e15430.mdl_glyph)) {
                self.var_30e15430.mdl_glyph delete();
            }
            self.var_30e15430.e_owner = undefined;
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x97d52b2c, Offset: 0x3600
// Size: 0x2b8
function function_342f6a9(e_grenade, n_grenade_charge_power) {
    if (!self flag::get(#"hash_18c7b52cebad7171") || self flag::get(#"hash_120fbb364796cd32")) {
        return false;
    }
    var_40c688c7 = struct::get_array("hr_step_2_glyph");
    foreach (var_1c7cfb34 in var_40c688c7) {
        if (!isdefined(var_1c7cfb34.e_owner) || var_1c7cfb34.e_owner != self) {
            continue;
        }
        if (distancesquared(e_grenade.origin, var_1c7cfb34.mdl_glyph.origin) < 10000) {
            var_1c7cfb34 thread function_6aaa5496(self);
            var_1c7cfb34.mdl_glyph delete();
            var_1c7cfb34.mdl_glyph = undefined;
            var_1c7cfb34.e_owner = undefined;
            self.var_30e15430 = undefined;
            self notify(#"tomahawk_returned");
            if (isdefined(e_grenade)) {
                e_grenade delete();
            }
            while (self function_1b77f4ea()) {
                waitframe(1);
            }
            self takeweapon(getweapon(#"tomahawk_t8"));
            if (isdefined(self.var_187e198d)) {
                self giveweapon(self.var_187e198d);
                self thread zm_audio::create_and_play_dialog("ax_upgrade", "pickup", undefined, 1);
            }
            self playsoundtoplayer(#"hash_6e048d37333004da", self);
            self flag::set(#"hash_120fbb364796cd32");
            return true;
        }
    }
    return false;
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x1d34a0c4, Offset: 0x38c0
// Size: 0x184
function function_6aaa5496(e_player) {
    s_angles = struct::get(self.target);
    if (isdefined(s_angles)) {
        mdl_fx = util::spawn_model("tag_origin", self.origin, s_angles.angles);
    } else {
        mdl_fx = util::spawn_model("tag_origin", self.origin, self.angles);
    }
    mdl_fx setinvisibletoall();
    if (isplayer(e_player) && isalive(e_player)) {
        mdl_fx setvisibletoplayer(e_player);
    }
    playsoundatposition(#"hash_6f61076a871fcbab", mdl_fx.origin);
    mdl_fx clientfield::set("" + #"hash_46dbc12bdc275121", 1);
    wait 5;
    mdl_fx delete();
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x3344beb, Offset: 0x3a50
// Size: 0x6e
function function_fa0eaca2(var_4df52d26) {
    if (!var_4df52d26) {
        var_67894141 = "" + #"hash_574003386f679990" + "_";
        level waittill(var_67894141 + "completed", var_67894141 + "skipped_over", var_67894141 + "ended_early");
    }
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x8fd10e82, Offset: 0x3ac8
// Size: 0xa8
function function_97971ff7(var_4df52d26, var_c86ff890) {
    if (var_4df52d26 || var_c86ff890) {
        foreach (e_player in level.activeplayers) {
            e_player flag::set(#"hash_11ab20934759ebc3");
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x7d0ecb2e, Offset: 0x3b78
// Size: 0x52a
function function_f5340959() {
    var_f75eb3e0 = getent("zombie_ghost_dog_spawner", "script_noteworthy");
    while (true) {
        if (!zm_custom::function_5638f689(#"zmspecialroundsenabled")) {
            level waittill(#"start_of_round");
        } else {
            level flag::wait_till("dog_round");
        }
        var_6ec77c3b = [];
        var_4ded0af5 = struct::get_array("hr_dog_spawn");
        foreach (e_player in level.activeplayers) {
            if (e_player flag::exists(#"hash_120fbb364796cd32") && e_player flag::get(#"hash_120fbb364796cd32") && !e_player flag::get(#"hash_11ab20934759ebc3")) {
                for (var_4d7d0bda = array::random(var_4ded0af5); !zm_utility::is_point_inside_enabled_zone(var_4d7d0bda.origin); var_4d7d0bda = array::random(var_4ded0af5)) {
                }
                e_dog = zombie_utility::spawn_zombie(var_f75eb3e0, undefined, var_4d7d0bda);
                e_dog setinvisibletoall();
                e_dog setvisibletoplayer(e_player);
                waitframe(1);
                if (isdefined(e_dog)) {
                    if (!isdefined(var_6ec77c3b)) {
                        var_6ec77c3b = [];
                    } else if (!isarray(var_6ec77c3b)) {
                        var_6ec77c3b = array(var_6ec77c3b);
                    }
                    var_6ec77c3b[var_6ec77c3b.size] = e_dog;
                    e_dog clientfield::set("" + #"hash_7792af358100c735", 1);
                    e_dog clientfield::set("" + #"hash_65da20412fcaf97e", 1);
                    e_dog thread zm_escape_util::function_389bc4e7(var_4d7d0bda);
                    e_dog thread function_660d2b03();
                    mdl_tomahawk = util::spawn_model(#"hash_2963eae43f30b9ed", var_4d7d0bda.origin);
                    mdl_tomahawk.origin = e_dog gettagorigin("tag_mouth_fx");
                    mdl_tomahawk.angles = e_dog.angles + (0, 90, 0);
                    mdl_tomahawk linkto(e_dog, "tag_mouth_fx");
                    e_dog.mdl_tomahawk = mdl_tomahawk;
                    mdl_tomahawk clientfield::set("" + #"hash_34562274d7e875a4", 1);
                    mdl_tomahawk clientfield::set("" + #"hash_7327d0447d656234", 1);
                    e_dog thread function_d18aab5c(e_player);
                }
            }
        }
        if (!zm_custom::function_5638f689(#"zmspecialroundsenabled")) {
            level waittill(#"end_of_round");
        } else {
            level flag::wait_till_clear("dog_round");
        }
        for (i = 0; i < var_6ec77c3b.size; i++) {
            if (isalive(var_6ec77c3b[i])) {
                var_6ec77c3b[i] kill();
            }
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0xdc2b6d2b, Offset: 0x40b0
// Size: 0x2a0
function function_d18aab5c(e_player) {
    self endon(#"death");
    var_a0d424ec = struct::get_array("s_pebble_trav", "targetname");
    current_zone = self zm_utility::get_current_zone(1);
    foreach (var_1ed86754 in var_a0d424ec) {
        if (var_1ed86754.script_string == current_zone.name) {
            var_a7c33a31 = var_1ed86754;
        }
    }
    self setgoal(var_a7c33a31.origin, 1);
    self waittill(#"goal");
    while (true) {
        current_zone = self zm_utility::get_current_zone(1);
        /#
            iprintln("<dev string:x65>" + current_zone.name);
        #/
        str_next_location = function_c1c401f0(current_zone, self);
        foreach (var_1ed86754 in var_a0d424ec) {
            if (var_1ed86754.script_string == str_next_location) {
                var_510f2b86 = var_1ed86754;
                break;
            }
        }
        self lookatpos(var_510f2b86.origin);
        self thread function_db3b67f6(e_player);
        self setgoal(var_510f2b86.origin, 1);
        self function_4ba51c35(e_player, var_510f2b86);
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x8b9c6b2e, Offset: 0x4358
// Size: 0x13e
function function_db3b67f6(e_player) {
    self endon(#"death");
    for (i = 0; i <= 4; i++) {
        var_ac984b8 = util::spawn_model("p7_zm_ctl_wolf_paw_print_escape", self.origin + (0, 0, 2), self.angles + (-90, 0, 180));
        var_ac984b8 setscale(0.6);
        var_ac984b8 clientfield::set("" + #"hash_53586aa63ca15286", 1);
        var_ac984b8 thread function_62b263e4();
        var_ac984b8 setinvisibletoall();
        var_ac984b8 setvisibletoplayer(e_player);
        wait 0.5;
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0xba6a16f, Offset: 0x44a0
// Size: 0x34
function function_62b263e4() {
    self endon(#"death");
    wait 12;
    self delete();
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x1bc16551, Offset: 0x44e0
// Size: 0x154
function function_c1c401f0(current_zone, e_dog) {
    var_f3dfbf3c = array();
    var_8c9779af = zm_cleanup::get_adjacencies_to_zone(current_zone.name);
    foreach (zone in var_8c9779af) {
        if (zm_zonemgr::zone_is_enabled(zone)) {
            array::add(var_f3dfbf3c, zone, 0);
        }
    }
    while (true) {
        str_next_location = array::random(var_f3dfbf3c);
        if (!isdefined(e_dog.var_7cf3b4bf)) {
            break;
        } else if (e_dog.var_7cf3b4bf.script_string == str_next_location) {
            continue;
        }
        break;
    }
    return str_next_location;
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0xef70d9f8, Offset: 0x4640
// Size: 0x86
function function_4ba51c35(e_player, var_510f2b86) {
    self endon(#"death");
    self waittill(#"goal");
    self.var_7cf3b4bf = var_510f2b86;
    self thread function_b722dd72(e_player);
    self waittilltimeout(8, #"hash_4607576ad3772956");
    self notify(#"hash_1947ed5f21e90252");
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x342ef7c0, Offset: 0x46d0
// Size: 0x94
function function_b722dd72(e_player) {
    self endon(#"death", #"hash_4607576ad3772956", #"hash_1947ed5f21e90252");
    while (true) {
        if (distance2dsquared(self.origin, e_player.origin) < 144400) {
            self notify(#"hash_4607576ad3772956");
        }
        wait 0.1;
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0xbb31ec56, Offset: 0x4770
// Size: 0x24c
function function_660d2b03() {
    s_result = self waittill(#"death");
    level thread zombie_dog_util::dog_explode_fx(self, self.origin);
    e_attacker = s_result.attacker;
    if (isplayer(e_attacker) && isalive(e_attacker) && e_attacker flag::get(#"hash_120fbb364796cd32") && !e_attacker flag::get(#"hash_11ab20934759ebc3")) {
        if (s_result.mod == "MOD_IMPACT" && s_result.weapon == getweapon(#"zhield_spectral_turret")) {
            e_attacker flag::set(#"hash_11ab20934759ebc3");
            var_4a4970e8 = struct::get("tom_pil");
            mdl_tomahawk = var_4a4970e8.scene_ents[#"prop 2"];
            mdl_tomahawk setvisibletoplayer(e_attacker);
            var_a879fa43 = e_attacker getentitynumber() + 1;
            mdl_tomahawk clientfield::set("" + #"hash_51657261e835ac7c", var_a879fa43);
            e_attacker playsoundtoplayer(#"hash_6e048d37333004da", e_attacker);
        }
    }
    self.mdl_tomahawk delete();
    self delete();
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0xc9c7a014, Offset: 0x49c8
// Size: 0x404
function function_b0c3e93f() {
    level flag::wait_till("power_on1");
    a_items = getitemarray();
    while (true) {
        a_w_items = getitemarray();
        var_97a6d7f = undefined;
        foreach (w_item in a_w_items) {
            if (w_item.item == getweapon(#"zitem_spectral_shield_part_2")) {
                var_97a6d7f = w_item;
                break;
            }
        }
        var_a948ee56 = struct::get_array("afterlife_trigger");
        if (isdefined(level.var_c4d7274a) && level.var_c4d7274a) {
            var_2c65ae45 = var_a948ee56.size;
        } else {
            var_2c65ae45 = 1;
        }
        var_a948ee56 = array::randomize(var_a948ee56);
        for (i = 0; i < var_2c65ae45; i++) {
            var_6d4e6b36 = var_a948ee56[i];
            if (isdefined(var_97a6d7f) && !(isdefined(level.var_c4d7274a) && level.var_c4d7274a)) {
                while (distancesquared(var_97a6d7f.origin, var_6d4e6b36.origin) < 10000) {
                    var_6d4e6b36 = array::random(var_a948ee56);
                }
            }
            mdl_spark = util::spawn_model("tag_origin", var_6d4e6b36.origin, var_6d4e6b36.angles);
            if (!isdefined(var_6d4e6b36.s_unitrigger_stub)) {
                var_6d4e6b36.s_unitrigger_stub = var_6d4e6b36 zm_unitrigger::create("", 96, &function_bc9fbc6e);
            } else {
                zm_unitrigger::register_unitrigger(var_6d4e6b36.s_unitrigger_stub, &function_bc9fbc6e);
            }
            var_6d4e6b36.mdl_spark = mdl_spark;
            mdl_spark clientfield::set("" + #"hash_4be2ce4248d80d22", 1);
        }
        level waittill(#"between_round_over");
        var_a948ee56 = struct::get_array("afterlife_trigger");
        foreach (var_6d4e6b36 in var_a948ee56) {
            if (isdefined(var_6d4e6b36.s_unitrigger_stub)) {
                zm_unitrigger::unregister_unitrigger(var_6d4e6b36.s_unitrigger_stub);
            }
            if (isdefined(var_6d4e6b36.mdl_spark)) {
                var_6d4e6b36.mdl_spark delete();
            }
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0xa313b376, Offset: 0x4dd8
// Size: 0x334
function function_bc9fbc6e() {
    level endon(#"between_round_over");
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator) && isalive(s_result.activator)) {
            var_f0e32b93 = array(getweapon(#"zhield_spectral_dw"), getweapon(#"zhield_spectral_dw_upgraded"), getweapon(#"zhield_spectral_turret"), getweapon(#"zhield_spectral_turret_upgraded"));
            w_current = s_result.activator.currentweapon;
            if (array::contains(var_f0e32b93, w_current)) {
                s_result.activator.var_65f7ac63 += 12;
                s_result.activator.var_65f7ac63 = math::clamp(s_result.activator.var_65f7ac63, 0, s_result.activator.var_146f6928 * 3);
                s_result.activator thread zm_weap_spectral_shield::function_dea8d9ae();
                s_result.activator playsound(#"hash_19d5ba8ff22edcce");
                break;
            }
            s_result.activator status_effect::status_effect_apply(getstatuseffect(#"hash_19533caf858a9f3b"), undefined, self);
            s_result.activator playrumbleonentity("damage_heavy");
            s_result.activator dodamage(25, self.stub.related_parent.origin);
            s_result.activator playsound(#"hash_7f81f21dc017790d");
            break;
        }
    }
    self.stub.related_parent.mdl_spark delete();
    zm_unitrigger::unregister_unitrigger(self.stub);
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x6f862041, Offset: 0x5118
// Size: 0x15e
function function_1f2eeab6() {
    level.var_5c23d591 = 0;
    var_be6c055c = struct::get("walnut_teleporter_01");
    var_30737497 = struct::get("walnut_teleporter_02");
    var_9e8b3c85 = getent("mdl_walnut_teleporter_1", "targetname");
    var_c48db6ee = getent("mdl_walnut_teleporter_2", "targetname");
    var_be6c055c.var_b9f42618 = 1;
    var_c48db6ee setmodel("p7_light_round_spot_flat_off");
    hidemiscmodels("walnut_02");
    var_be6c055c.s_unitrigger_stub = var_be6c055c zm_unitrigger::create(&function_44430b79, 64, &function_e98faeb);
    var_30737497.s_unitrigger_stub = var_30737497 zm_unitrigger::create(&function_44430b79, 64, &function_e98faeb);
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x4beca659, Offset: 0x5280
// Size: 0x34
function function_44430b79(player) {
    if (isdefined(level.var_c170c4aa) && level.var_c170c4aa) {
        return false;
    }
    return true;
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x87a45f8b, Offset: 0x52c0
// Size: 0x5e8
function function_e98faeb() {
    level endon(#"hash_540673c3f2a6c830");
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator) && isdefined(self.stub.related_parent.var_b9f42618) && self.stub.related_parent.var_b9f42618) {
            if (level.var_5c23d591 == 0) {
                s_result.activator thread zm_audio::create_and_play_dialog("teleport", "activate", undefined, 1);
            }
            self.stub.related_parent.var_b9f42618 = undefined;
            if (self.stub.related_parent.targetname == "walnut_teleporter_01") {
                var_1f54253a = struct::get("walnut_teleporter_02");
                var_fc421501 = getent("mdl_walnut_teleporter_1", "targetname");
                var_fc062f68 = getent("mdl_walnut_teleporter_2", "targetname");
            } else {
                var_1f54253a = struct::get("walnut_teleporter_01");
                var_fc421501 = getent("mdl_walnut_teleporter_2", "targetname");
                var_fc062f68 = getent("mdl_walnut_teleporter_1", "targetname");
            }
            mdl_spark = util::spawn_model("tag_origin", self.stub.related_parent.origin, self.stub.related_parent.angles);
            playsoundatposition(#"wpn_zmb_electrap_zap", self.stub.related_parent.origin);
            waitframe(2);
            mdl_spark clientfield::increment("" + #"hash_ce418c45d804842");
            s_result.activator playrumbleonentity(#"zm_escape_walnut");
            var_fc421501 setmodel(#"p7_light_round_spot_flat_off");
            if (self.stub.related_parent.targetname == "walnut_teleporter_01") {
                hidemiscmodels("walnut_01");
            } else if (self.stub.related_parent.targetname == "walnut_teleporter_02") {
                hidemiscmodels("walnut_02");
            }
            level.var_5c23d591++;
            wait 2;
            mdl_spark delete();
            if (level.var_5c23d591 < 3) {
                mdl_spark = util::spawn_model("tag_origin", var_1f54253a.origin, var_1f54253a.angles);
                playsoundatposition(#"wpn_zmb_electrap_zap", var_1f54253a.origin);
                waitframe(2);
                mdl_spark clientfield::increment("" + #"hash_ce418c45d804842");
                if (self.stub.related_parent.targetname == "walnut_teleporter_01") {
                    showmiscmodels("walnut_02");
                } else if (self.stub.related_parent.targetname == "walnut_teleporter_02") {
                    showmiscmodels("walnut_01");
                }
                wait 5;
                mdl_spark delete();
                wait 25;
                var_fc062f68 setmodel(#"p7_light_round_spot_flat_on_warm");
                var_1f54253a.var_b9f42618 = 1;
                continue;
            }
            playsoundatposition(#"wpn_zmb_electrap_zap", var_1f54253a.origin);
            playfx(level._effect[#"switch_sparks"], var_1f54253a.origin);
            if (isalive(s_result.activator)) {
                s_result.activator thread zm_audio::create_and_play_dialog("teleport", "destroy", undefined, 1);
            }
            level thread function_f9ff3303();
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x32147f8a, Offset: 0x58b0
// Size: 0xd6
function function_f9ff3303() {
    var_be6c055c = struct::get("walnut_teleporter_01");
    var_30737497 = struct::get("walnut_teleporter_02");
    if (isdefined(var_be6c055c.mdl_walnut)) {
        var_be6c055c.mdl_walnut delete();
    }
    if (isdefined(var_30737497.mdl_walnut)) {
        var_30737497.mdl_walnut delete();
    }
    zm_unitrigger::unregister_unitrigger(var_be6c055c.s_unitrigger_stub);
    zm_unitrigger::unregister_unitrigger(var_30737497.s_unitrigger_stub);
    level.var_5c23d591 = undefined;
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x16fe5338, Offset: 0x5990
// Size: 0x14a
function function_2ddba04b(var_4df52d26) {
    var_4549d507 = struct::get("s_m_b_stat_spawn");
    var_5d3fcad8 = util::spawn_model(var_4549d507.model, var_4549d507.origin, var_4549d507.angles);
    var_f23f19e = getent("e_m_bomb_q_vol", "targetname");
    level.var_adcb60b = 0;
    level.var_f23f19e = var_f23f19e;
    level.var_5d3fcad8 = var_5d3fcad8;
    callback::on_ai_killed(&function_61a8289e);
    var_67894141 = "" + #"monkey_bomb_step_1" + "_";
    level waittill(var_67894141 + "completed", var_67894141 + "skipped_over", var_67894141 + "ended_early", #"hash_731f4115fe0cbef");
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0xbd29cdd7, Offset: 0x5ae8
// Size: 0x7c
function function_186af98e(var_4df52d26, var_c86ff890) {
    callback::remove_on_ai_killed(&function_61a8289e);
    level.var_adcb60b = undefined;
    level.var_f23f19e delete();
    level flag::delete(#"hash_731f4115fe0cbef");
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0xe01c4965, Offset: 0x5b70
// Size: 0x224
function function_61a8289e(s_params) {
    if (self.archetype != "zombie" && self.archetype != "zombie_dog") {
        return;
    }
    if (!isplayer(s_params.eattacker)) {
        return;
    }
    e_player = s_params.eattacker;
    if (!isdefined(level.var_f23f19e)) {
        return;
    }
    if (!e_player istouching(level.var_f23f19e)) {
        return;
    }
    var_9600d9cd = array(level.hero_weapon[#"flamethrower"][1], level.hero_weapon[#"flamethrower"][2], level.hero_weapon[#"gravityspikes"][1], level.hero_weapon[#"gravityspikes"][2], level.hero_weapon[#"katana"][1], level.hero_weapon[#"katana"][2], level.hero_weapon[#"minigun"][1], level.hero_weapon[#"minigun"][2], getweapon(#"hash_492e530f9862f6cc"));
    if (!isinarray(var_9600d9cd, s_params.weapon)) {
        return;
    }
    level thread function_6f1d655e(self gettagorigin("tag_eye"));
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x4
// Checksum 0x8fcaebe2, Offset: 0x5da0
// Size: 0x1cc
function private function_6f1d655e(v_origin) {
    mdl_fx = util::spawn_model("tag_origin", v_origin);
    mdl_fx clientfield::set("spectral_key_essence", 1);
    mdl_fx playsound(#"zmb_sq_souls_release");
    var_d8802548 = struct::get("s_m_b_stat_spawn");
    var_d8802548 = struct::get(var_d8802548.target);
    n_time = distance(v_origin, var_d8802548.origin) / 100;
    mdl_fx moveto(var_d8802548.origin, n_time, n_time * 0.25, n_time * 0.25);
    mdl_fx waittill(#"movedone");
    mdl_fx playsound(#"zmb_sq_souls_impact");
    mdl_fx delete();
    if (isdefined(level.var_adcb60b)) {
        level.var_adcb60b++;
    }
    if (isdefined(level.var_adcb60b) && level.var_adcb60b >= 20) {
        level flag::set(#"hash_731f4115fe0cbef");
    }
}

// Namespace pebble/zm_escape_pebble
// Params 1, eflags: 0x0
// Checksum 0x67b8aad0, Offset: 0x5f78
// Size: 0x1bc
function function_bbd43110(var_4df52d26) {
    if (var_4df52d26) {
        return;
    }
    level.var_5d3fcad8 clientfield::set("" + #"hash_59623b8b4fc694c8", 1);
    level.var_5d3fcad8 thread function_524bfda4();
    level waittill(#"hash_763832898999092c");
    foreach (e_player in level.players) {
        if (isalive(e_player)) {
            e_player playsoundtoplayer("vox_zmba_event_magicbox_0", e_player);
        }
    }
    wait 0.5;
    level.var_5d3fcad8 clientfield::set("" + #"hash_59623b8b4fc694c8", 2);
    level.var_5d3fcad8 movez(60, 1, 0.25, 0.25);
    level.var_5d3fcad8 waittill(#"movedone");
    level thread function_d3385ba8();
}

// Namespace pebble/zm_escape_pebble
// Params 2, eflags: 0x0
// Checksum 0x4ff621d7, Offset: 0x6140
// Size: 0xb4
function function_1fd35041(var_4df52d26, var_c86ff890) {
    level notify(#"hash_763832898999092c");
    if (isdefined(level.var_5d3fcad8)) {
        level.var_5d3fcad8 clientfield::set("" + #"hash_59623b8b4fc694c8", 0);
        waitframe(1);
        level.var_5d3fcad8 delete();
    }
    if (var_4df52d26 || var_c86ff890) {
        level thread function_d3385ba8();
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x188ee7c3, Offset: 0x6200
// Size: 0x8c
function function_524bfda4() {
    level endon(#"hash_763832898999092c");
    self setcandamage(1);
    while (true) {
        s_result = self waittill(#"damage");
        if (isplayer(s_result.attacker)) {
            level notify(#"hash_763832898999092c");
        }
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0x57193f54, Offset: 0x6298
// Size: 0x1a6
function function_d3385ba8() {
    level.var_c170c4aa = 1;
    s_spawn = struct::get("s_m_b_pick_spawn");
    s_spawn.mdl_monkey = util::spawn_model(s_spawn.model, s_spawn.origin, s_spawn.angles);
    playsoundatposition(#"wpn_zmb_electrap_zap", s_spawn.origin);
    playfx(level._effect[#"powerup_grabbed_solo"], s_spawn.origin);
    s_spawn.e_player = s_spawn zm_unitrigger::function_b7e350e6(#"hash_455b1ae7ea932324", 64);
    if (isplayer(s_spawn.e_player) && isalive(s_spawn.e_player)) {
        s_spawn.e_player giveweapon(getweapon(#"cymbal_monkey"));
        s_spawn.mdl_monkey delete();
    }
    level.var_c170c4aa = undefined;
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x4
// Checksum 0xd5b937ee, Offset: 0x6448
// Size: 0x44
function private function_3fee167b() {
    a_s_logs = struct::get_array("s_a_lo");
    array::thread_all(a_s_logs, &audio_log);
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x4
// Checksum 0xf755b6f0, Offset: 0x6498
// Size: 0x24cc
function private audio_log() {
    self.e_activator = self zm_unitrigger::function_b7e350e6("", 64);
    if (!isplayer(self.e_activator)) {
        return;
    }
    if (isdefined(self.target)) {
        a_mdl_reels = getentarray(self.target, "targetname");
        foreach (mdl_reel in a_mdl_reels) {
            mdl_reel thread function_c6a3469f();
            wait 0.5;
        }
    }
    switch (self.script_int) {
    case 1:
        playsoundatposition(#"hash_54b201a78dc00bee", self.origin);
        wait soundgetplaybacktime(#"hash_54b201a78dc00bee") * 0.001;
        playsoundatposition(#"hash_54b202a78dc00da1", self.origin);
        wait soundgetplaybacktime(#"hash_54b202a78dc00da1") * 0.001;
        playsoundatposition(#"hash_54b1ffa78dc00888", self.origin);
        wait soundgetplaybacktime(#"hash_54b1ffa78dc00888") * 0.001;
        playsoundatposition(#"hash_54b200a78dc00a3b", self.origin);
        wait soundgetplaybacktime(#"hash_54b200a78dc00a3b") * 0.001;
        playsoundatposition(#"hash_54b205a78dc012ba", self.origin);
        wait soundgetplaybacktime(#"hash_54b205a78dc012ba") * 0.001;
        playsoundatposition(#"hash_54b206a78dc0146d", self.origin);
        wait soundgetplaybacktime(#"hash_54b206a78dc0146d") * 0.001;
        playsoundatposition(#"hash_54b203a78dc00f54", self.origin);
        wait soundgetplaybacktime(#"hash_54b203a78dc00f54") * 0.001;
        playsoundatposition(#"hash_54b204a78dc01107", self.origin);
        wait soundgetplaybacktime(#"hash_54b204a78dc01107") * 0.001;
        break;
    case 2:
        playsoundatposition(#"hash_3a8604a77edfb147", self.origin);
        wait soundgetplaybacktime(#"hash_3a8604a77edfb147") * 0.001;
        playsoundatposition(#"hash_3a8603a77edfaf94", self.origin);
        wait soundgetplaybacktime(#"hash_3a8603a77edfaf94") * 0.001;
        playsoundatposition(#"hash_514c699c95ffeda4", self.origin);
        wait soundgetplaybacktime(#"hash_514c699c95ffeda4") * 0.001;
        playsoundatposition(#"hash_514c6a9c95ffef57", self.origin);
        wait soundgetplaybacktime(#"hash_514c6a9c95ffef57") * 0.001;
        playsoundatposition(#"hash_514c6b9c95fff10a", self.origin);
        wait soundgetplaybacktime(#"hash_514c6b9c95fff10a") * 0.001;
        playsoundatposition(#"hash_514c6c9c95fff2bd", self.origin);
        wait soundgetplaybacktime(#"hash_514c6c9c95fff2bd") * 0.001;
        playsoundatposition(#"hash_514c659c95ffe6d8", self.origin);
        wait soundgetplaybacktime(#"hash_514c659c95ffe6d8") * 0.001;
        break;
    case 3:
        playsoundatposition(#"hash_7d5a5aa2f76ff786", self.origin);
        wait soundgetplaybacktime(#"hash_7d5a5aa2f76ff786") * 0.001;
        playsoundatposition(#"hash_527a28837317921e", self.origin);
        wait soundgetplaybacktime(#"hash_527a28837317921e") * 0.001;
        playsoundatposition(#"hash_7d5a58a2f76ff420", self.origin);
        wait soundgetplaybacktime(#"hash_7d5a58a2f76ff420") * 0.001;
        playsoundatposition(#"hash_527a2283731787ec", self.origin);
        wait soundgetplaybacktime(#"hash_527a2283731787ec") * 0.001;
        playsoundatposition(#"hash_7d5a66a2f7700bea", self.origin);
        wait soundgetplaybacktime(#"hash_7d5a66a2f7700bea") * 0.001;
        playsoundatposition(#"hash_52841c83731fd23f", self.origin);
        wait soundgetplaybacktime(#"hash_52841c83731fd23f") * 0.001;
        playsoundatposition(#"hash_7d5de6a2f7731b41", self.origin);
        wait soundgetplaybacktime(#"hash_7d5de6a2f7731b41") * 0.001;
        playsoundatposition(#"hash_52841e83731fd5a5", self.origin);
        wait soundgetplaybacktime(#"hash_52841e83731fd5a5") * 0.001;
        playsoundatposition(#"hash_7d5de4a2f77317db", self.origin);
        wait soundgetplaybacktime(#"hash_7d5de4a2f77317db") * 0.001;
        playsoundatposition(#"hash_52841883731fcb73", self.origin);
        wait soundgetplaybacktime(#"hash_52841883731fcb73") * 0.001;
        playsoundatposition(#"hash_7d5deaa2f773220d", self.origin);
        wait soundgetplaybacktime(#"hash_7d5deaa2f773220d") * 0.001;
        playsoundatposition(#"hash_5d914b0a89a171da", self.origin);
        wait soundgetplaybacktime(#"hash_5d914b0a89a171da") * 0.001;
        playsoundatposition(#"hash_7d5de8a2f7731ea7", self.origin);
        wait soundgetplaybacktime(#"hash_7d5de8a2f7731ea7") * 0.001;
        playsoundatposition(#"hash_52842483731fdfd7", self.origin);
        wait soundgetplaybacktime(#"hash_52842483731fdfd7") * 0.001;
        playsoundatposition(#"hash_5d913e0a89a15bc3", self.origin);
        wait soundgetplaybacktime(#"hash_5d913e0a89a15bc3") * 0.001;
        playsoundatposition(#"hash_7d60eba2f7755997", self.origin);
        wait soundgetplaybacktime(#"hash_7d60eba2f7755997") * 0.001;
        playsoundatposition(#"hash_5d944a0a89a3a5fe", self.origin);
        wait soundgetplaybacktime(#"hash_5d944a0a89a3a5fe") * 0.001;
        playsoundatposition(#"hash_52811483731d8ed0", self.origin);
        wait soundgetplaybacktime(#"hash_52811483731d8ed0") * 0.001;
        playsoundatposition(#"hash_7d60eca2f7755b4a", self.origin);
        wait soundgetplaybacktime(#"hash_7d60eca2f7755b4a") * 0.001;
        break;
    case 4:
        playsoundatposition(#"hash_2ef1d5ccb09d7de0", self.origin);
        wait soundgetplaybacktime(#"hash_2ef1d5ccb09d7de0") * 0.001;
        playsoundatposition(#"hash_2ef1d6ccb09d7f93", self.origin);
        wait soundgetplaybacktime(#"hash_2ef1d6ccb09d7f93") * 0.001;
        playsoundatposition(#"hash_2ef1d7ccb09d8146", self.origin);
        wait soundgetplaybacktime(#"hash_2ef1d7ccb09d8146") * 0.001;
        playsoundatposition(#"hash_5adc69bd9cc6be48", self.origin);
        wait soundgetplaybacktime(#"hash_5adc69bd9cc6be48") * 0.001;
        playsoundatposition(#"hash_2ef1e1ccb09d9244", self.origin);
        wait soundgetplaybacktime(#"hash_2ef1e1ccb09d9244") * 0.001;
        playsoundatposition(#"hash_5adc67bd9cc6bae2", self.origin);
        wait soundgetplaybacktime(#"hash_5adc67bd9cc6bae2") * 0.001;
        playsoundatposition(#"hash_2eee53ccb09a6b23", self.origin);
        wait soundgetplaybacktime(#"hash_2eee53ccb09a6b23") * 0.001;
        playsoundatposition(#"hash_5ad25fbd9cbe58c5", self.origin);
        wait soundgetplaybacktime(#"hash_5ad25fbd9cbe58c5") * 0.001;
        playsoundatposition(#"hash_2eee55ccb09a6e89", self.origin);
        wait soundgetplaybacktime(#"hash_2eee55ccb09a6e89") * 0.001;
        playsoundatposition(#"hash_5ad25dbd9cbe555f", self.origin);
        wait soundgetplaybacktime(#"hash_5ad25dbd9cbe555f") * 0.001;
        playsoundatposition(#"hash_2eee57ccb09a71ef", self.origin);
        wait soundgetplaybacktime(#"hash_2eee57ccb09a71ef") * 0.001;
        playsoundatposition(#"hash_5ad25bbd9cbe51f9", self.origin);
        wait soundgetplaybacktime(#"hash_5ad25bbd9cbe51f9") * 0.001;
        playsoundatposition(#"hash_2eee59ccb09a7555", self.origin);
        wait soundgetplaybacktime(#"hash_2eee59ccb09a7555") * 0.001;
        playsoundatposition(#"hash_5ad259bd9cbe4e93", self.origin);
        wait soundgetplaybacktime(#"hash_5ad259bd9cbe4e93") * 0.001;
        playsoundatposition(#"hash_2eee5bccb09a78bb", self.origin);
        wait soundgetplaybacktime(#"hash_2eee5bccb09a78bb") * 0.001;
        playsoundatposition(#"hash_5ad267bd9cbe665d", self.origin);
        wait soundgetplaybacktime(#"hash_5ad267bd9cbe665d") * 0.001;
        playsoundatposition(#"hash_2eeaedccb09787fa", self.origin);
        wait soundgetplaybacktime(#"hash_2eeaedccb09787fa") * 0.001;
        break;
    case 5:
        playsoundatposition(#"hash_69da2d44d1c0608", self.origin);
        wait soundgetplaybacktime(#"hash_69da2d44d1c0608") * 0.001;
        playsoundatposition(#"hash_69da5d44d1c0b21", self.origin);
        wait soundgetplaybacktime(#"hash_69da5d44d1c0b21") * 0.001;
        playsoundatposition(#"hash_3619001afb9ce3cc", self.origin);
        wait soundgetplaybacktime(#"hash_3619001afb9ce3cc") * 0.001;
        playsoundatposition(#"hash_69da7d44d1c0e87", self.origin);
        wait soundgetplaybacktime(#"hash_69da7d44d1c0e87") * 0.001;
        playsoundatposition(#"hash_3618fe1afb9ce066", self.origin);
        wait soundgetplaybacktime(#"hash_3618fe1afb9ce066") * 0.001;
        playsoundatposition(#"hash_69da9d44d1c11ed", self.origin);
        wait soundgetplaybacktime(#"hash_69da9d44d1c11ed") * 0.001;
        playsoundatposition(#"hash_3018a9b38daf275b", self.origin);
        wait soundgetplaybacktime(#"hash_3018a9b38daf275b") * 0.001;
        playsoundatposition(#"hash_69d9bd44d1bfa23", self.origin);
        wait soundgetplaybacktime(#"hash_69d9bd44d1bfa23") * 0.001;
        playsoundatposition(#"hash_3018a7b38daf23f5", self.origin);
        wait soundgetplaybacktime(#"hash_3018a7b38daf23f5") * 0.001;
        playsoundatposition(#"hash_69391d44d1394a0", self.origin);
        wait soundgetplaybacktime(#"hash_69391d44d1394a0") * 0.001;
        playsoundatposition(#"hash_301527b38dac149e", self.origin);
        wait soundgetplaybacktime(#"hash_301527b38dac149e") * 0.001;
        playsoundatposition(#"hash_69393d44d139806", self.origin);
        wait soundgetplaybacktime(#"hash_69393d44d139806") * 0.001;
        playsoundatposition(#"hash_361c881afba000bb", self.origin);
        wait soundgetplaybacktime(#"hash_361c881afba000bb") * 0.001;
        playsoundatposition(#"hash_361c8d1afba0093a", self.origin);
        wait soundgetplaybacktime(#"hash_361c8d1afba0093a") * 0.001;
        playsoundatposition(#"hash_69396d44d139d1f", self.origin);
        wait soundgetplaybacktime(#"hash_69396d44d139d1f") * 0.001;
        playsoundatposition(#"hash_361c8b1afba005d4", self.origin);
        wait soundgetplaybacktime(#"hash_361c8b1afba005d4") * 0.001;
        playsoundatposition(#"hash_69398d44d13a085", self.origin);
        wait soundgetplaybacktime(#"hash_69398d44d13a085") * 0.001;
        playsoundatposition(#"hash_301520b38dac08b9", self.origin);
        wait soundgetplaybacktime(#"hash_301520b38dac08b9") * 0.001;
        playsoundatposition(#"hash_6939ad44d13a3eb", self.origin);
        wait soundgetplaybacktime(#"hash_6939ad44d13a3eb") * 0.001;
        playsoundatposition(#"hash_69717d44d16ae29", self.origin);
        wait soundgetplaybacktime(#"hash_69717d44d16ae29") * 0.001;
        playsoundatposition(#"hash_36200e1afba31a44", self.origin);
        wait soundgetplaybacktime(#"hash_36200e1afba31a44") * 0.001;
        break;
    case 6:
        playsoundatposition(#"hash_32c74c51be77cda", self.origin);
        wait soundgetplaybacktime(#"hash_32c74c51be77cda") * 0.001;
        playsoundatposition(#"hash_32c75c51be77e8d", self.origin);
        wait soundgetplaybacktime(#"hash_32c75c51be77e8d") * 0.001;
        playsoundatposition(#"hash_32c6ec51be772a8", self.origin);
        wait soundgetplaybacktime(#"hash_32c6ec51be772a8") * 0.001;
        playsoundatposition(#"hash_32c6fc51be7745b", self.origin);
        wait soundgetplaybacktime(#"hash_32c6fc51be7745b") * 0.001;
        playsoundatposition(#"hash_32c70c51be7760e", self.origin);
        wait soundgetplaybacktime(#"hash_32c70c51be7760e") * 0.001;
        playsoundatposition(#"hash_32c71c51be777c1", self.origin);
        wait soundgetplaybacktime(#"hash_32c71c51be777c1") * 0.001;
        playsoundatposition(#"hash_32c6ac51be76bdc", self.origin);
        wait soundgetplaybacktime(#"hash_32c6ac51be76bdc") * 0.001;
        playsoundatposition(#"hash_32c6bc51be76d8f", self.origin);
        wait soundgetplaybacktime(#"hash_32c6bc51be76d8f") * 0.001;
        break;
    case 7:
        playsoundatposition(#"hash_585732bb0cc095d4", self.origin);
        wait soundgetplaybacktime(#"hash_585732bb0cc095d4") * 0.001;
        playsoundatposition(#"hash_585733bb0cc09787", self.origin);
        wait soundgetplaybacktime(#"hash_585733bb0cc09787") * 0.001;
        playsoundatposition(#"hash_585734bb0cc0993a", self.origin);
        wait soundgetplaybacktime(#"hash_585734bb0cc0993a") * 0.001;
        playsoundatposition(#"hash_585735bb0cc09aed", self.origin);
        wait soundgetplaybacktime(#"hash_585735bb0cc09aed") * 0.001;
        playsoundatposition(#"hash_58572ebb0cc08f08", self.origin);
        wait soundgetplaybacktime(#"hash_58572ebb0cc08f08") * 0.001;
        playsoundatposition(#"hash_58572fbb0cc090bb", self.origin);
        wait soundgetplaybacktime(#"hash_58572fbb0cc090bb") * 0.001;
        playsoundatposition(#"hash_585730bb0cc0926e", self.origin);
        wait soundgetplaybacktime(#"hash_585730bb0cc0926e") * 0.001;
        playsoundatposition(#"hash_585731bb0cc09421", self.origin);
        wait soundgetplaybacktime(#"hash_585731bb0cc09421") * 0.001;
        break;
    case 8:
        playsoundatposition(#"hash_2c86b0b4ab84f6ad", self.origin);
        wait soundgetplaybacktime(#"hash_2c86b0b4ab84f6ad") * 0.001;
        playsoundatposition(#"hash_2c86afb4ab84f4fa", self.origin);
        wait soundgetplaybacktime(#"hash_2c86afb4ab84f4fa") * 0.001;
        playsoundatposition(#"hash_2c8322b4ab81cf8c", self.origin);
        wait soundgetplaybacktime(#"hash_2c8322b4ab81cf8c") * 0.001;
        playsoundatposition(#"hash_2c8323b4ab81d13f", self.origin);
        wait soundgetplaybacktime(#"hash_2c8323b4ab81d13f") * 0.001;
        playsoundatposition(#"hash_2c8324b4ab81d2f2", self.origin);
        wait soundgetplaybacktime(#"hash_2c8324b4ab81d2f2") * 0.001;
        playsoundatposition(#"hash_2c8325b4ab81d4a5", self.origin);
        wait soundgetplaybacktime(#"hash_2c8325b4ab81d4a5") * 0.001;
        playsoundatposition(#"hash_2c831eb4ab81c8c0", self.origin);
        wait soundgetplaybacktime(#"hash_2c831eb4ab81c8c0") * 0.001;
        playsoundatposition(#"hash_2c831fb4ab81ca73", self.origin);
        wait soundgetplaybacktime(#"hash_2c831fb4ab81ca73") * 0.001;
        playsoundatposition(#"hash_2c8320b4ab81cc26", self.origin);
        wait soundgetplaybacktime(#"hash_2c8320b4ab81cc26") * 0.001;
        break;
    case 9:
        playsoundatposition(#"hash_34ec71eed537322e", self.origin);
        wait soundgetplaybacktime(#"hash_34ec71eed537322e") * 0.001;
        playsoundatposition(#"hash_34ec6ceed53729af", self.origin);
        wait soundgetplaybacktime(#"hash_34ec6ceed53729af") * 0.001;
        playsoundatposition(#"hash_34ec6beed53727fc", self.origin);
        wait soundgetplaybacktime(#"hash_34ec6beed53727fc") * 0.001;
        playsoundatposition(#"hash_6022f0d425ef789d", self.origin);
        wait soundgetplaybacktime(#"hash_6022f0d425ef789d") * 0.001;
        playsoundatposition(#"hash_6022efd425ef76ea", self.origin);
        wait soundgetplaybacktime(#"hash_6022efd425ef76ea") * 0.001;
        playsoundatposition(#"hash_6022eed425ef7537", self.origin);
        wait soundgetplaybacktime(#"hash_6022eed425ef7537") * 0.001;
        playsoundatposition(#"hash_6022edd425ef7384", self.origin);
        wait soundgetplaybacktime(#"hash_6022edd425ef7384") * 0.001;
        break;
    case 10:
        playsoundatposition(#"hash_2e5f58bc89eb69de", self.origin);
        wait soundgetplaybacktime(#"hash_2e5f58bc89eb69de") * 0.001;
        playsoundatposition(#"hash_2e5f59bc89eb6b91", self.origin);
        wait soundgetplaybacktime(#"hash_2e5f59bc89eb6b91") * 0.001;
        playsoundatposition(#"hash_2e5f56bc89eb6678", self.origin);
        wait soundgetplaybacktime(#"hash_2e5f56bc89eb6678") * 0.001;
        playsoundatposition(#"hash_2e5f57bc89eb682b", self.origin);
        wait soundgetplaybacktime(#"hash_2e5f57bc89eb682b") * 0.001;
        playsoundatposition(#"hash_2e5f54bc89eb6312", self.origin);
        wait soundgetplaybacktime(#"hash_2e5f54bc89eb6312") * 0.001;
        playsoundatposition(#"hash_2e5f55bc89eb64c5", self.origin);
        wait soundgetplaybacktime(#"hash_2e5f55bc89eb64c5") * 0.001;
        break;
    }
    foreach (mdl_reel in a_mdl_reels) {
        mdl_reel notify(#"hash_1f140c04b559c01a");
    }
}

// Namespace pebble/zm_escape_pebble
// Params 0, eflags: 0x0
// Checksum 0xeeef088a, Offset: 0x8970
// Size: 0x56
function function_c6a3469f() {
    self endon(#"hash_1f140c04b559c01a");
    while (true) {
        self rotateroll(360, 5);
        self waittill(#"rotatedone");
    }
}

/#

    // Namespace pebble/zm_escape_pebble
    // Params 0, eflags: 0x0
    // Checksum 0xe56c716b, Offset: 0x89d0
    // Size: 0x44
    function function_32d5a799() {
        zm_devgui::add_custom_devgui_callback(&function_dd1803e2);
        adddebugcommand("<dev string:x86>");
    }

    // Namespace pebble/zm_escape_pebble
    // Params 1, eflags: 0x0
    // Checksum 0x5383c783, Offset: 0x8a20
    // Size: 0xea
    function function_dd1803e2(cmd) {
        switch (cmd) {
        case #"hash_8a61bbec91098c":
            var_df87d0bb = struct::get_array("<dev string:x103>");
            foreach (s_glyph in var_df87d0bb) {
                util::spawn_model(#"p8_zm_esc_dream_catcher_blue", s_glyph.origin, s_glyph.angles);
            }
            break;
        }
    }

#/
