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

#namespace namespace_7e0a2a28;

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x2
// Checksum 0xcdb64d83, Offset: 0x318
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"hash_77ae506b4db4f2ce", &__init__, &__main__, undefined);
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x4c3a41e8, Offset: 0x368
// Size: 0x6dc
function __init__() {
    clientfield::register("toplayer", "" + #"hash_11ff39a3100ac894", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_37c33178198d54e4", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_5d9808a62579e894", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_4ec2b359458774e4", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_4724376be4e925a3", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_1aa1c7790dc67d1e", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_7cdfc8f4819bab2e", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_61ed2f45564d54f9", 1, 1, "int");
    level flag::init(#"hash_6ee51d9a7d37aecc");
    level flag::init(#"hash_43114a11c9ca5302");
    level flag::init(#"hash_4e263b5dda470559");
    level flag::init(#"hash_5466d69fa17fc721");
    level.var_fc3072f8 = array(#"hash_79ab766693ef2532", #"hash_5acbab45c034f5bd");
    level.var_ccff1dc1 = array(#"hash_12826eeb0abe1308", #"hash_465b23ced2029d95", #"hash_3aa12cac41d4ba98");
    level.var_2dd9124a = array(#"hash_59f3be0494c4801f", #"hash_29001ce64677a5cf", #"hash_1c96d8540b5d8c50");
    level.var_46c7a502 = getent("mdl_acid_trap_finished_g", "targetname");
    level.var_46c7a502 setinvisibletoall();
    level.var_bb7f1ea5 = getent("mdl_spin_trap_finished_r", "targetname");
    level.var_bb7f1ea5 setinvisibletoall();
    level.var_c38f6610 = getent("mdl_fan_trap_finished_b", "targetname");
    level.var_c38f6610 setinvisibletoall();
    level.var_60c2dc00 = getentarray("zm_escape_rubble_pieces", "targetname");
    foreach (mdl_piece in level.var_60c2dc00) {
        mdl_piece setinvisibletoall();
    }
    level.var_fa799cf = getent("mdl_new_indust_geo_brush", "targetname");
    level.var_fa799cf setinvisibletoall();
    level.var_fa799cf notsolid();
    level.var_72eb6991 = getent("mdl_white_metal", "targetname");
    level.var_72eb6991.var_b20e966b = 0;
    level.var_72eb6991.var_13ce4459 = 25;
    level.var_72eb6991.var_e25a08c2 = -25;
    level.var_72eb6991 movez(level.var_72eb6991.var_e25a08c2, 1.5);
    level.var_eb89f0ed = getent("mdl_world_rebar_g", "targetname");
    level.var_eb89f0ed setinvisibletoall();
    level.var_a90c4d34 = getentarray("mdl_d_w_i_k", "targetname");
    foreach (var_f0bd464e in level.var_a90c4d34) {
        var_f0bd464e setinvisibletoall();
    }
    level.var_ae85a919 = 0;
    callback::on_connect(&on_player_connect);
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x352f8217, Offset: 0xa50
// Size: 0x552
function __main__() {
    level flag::wait_till("all_players_spawned");
    foreach (e_player in level.players) {
        e_player flag::init(#"hash_d41f651bb868608");
        e_player flag::init(#"hash_334221cd7977f5d5");
        e_player flag::init(#"hash_12826eeb0abe1308");
        e_player flag::init(#"hash_465b23ced2029d95");
        e_player flag::init(#"hash_3aa12cac41d4ba98");
        e_player flag::init(#"hash_7317dfbae4fa0df5");
        e_player flag::init(#"hash_2218e030b30c77e2");
        e_player flag::init(#"hash_12000c871284e0b5");
        e_player flag::init(#"hash_7e372a60b99a89e0");
        e_player flag::init(#"hash_59f3be0494c4801f");
        e_player flag::init(#"hash_29001ce64677a5cf");
        e_player flag::init(#"hash_1c96d8540b5d8c50");
        e_player flag::init(#"hash_1213756b45a941f0");
        e_player flag::init(#"hash_21827937692e2aba");
        e_player flag::init(#"hash_3043d41614094af2");
        e_player flag::init(#"hash_f3f31bee1b786f2");
        e_player flag::init(#"hash_85d6f56e62aa0c4");
        e_player flag::init(#"hash_7bcf95ea12236f0d");
        e_player flag::init(#"hash_548a6763233817f5");
        e_player clientfield::set_to_player("" + #"hash_11ff39a3100ac894", 1);
        e_player clientfield::set_to_player("" + #"hash_37c33178198d54e4", 1);
        if (getdvarint(#"zm_debug_ee", 0)) {
            e_player thread function_da2f42fd();
        }
    }
    zm_spawner::register_zombie_death_event_callback(&function_1415f930);
    if (!isdefined(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = [];
    } else if (!isarray(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
    }
    level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_8b7ee76d;
    if (!isdefined(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = [];
    } else if (!isarray(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
    }
    level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_663fa289;
    if (!isdefined(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = [];
    } else if (!isarray(level.a_tomahawk_pickup_funcs)) {
        level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
    }
    level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_986832ba;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x2e09c21d, Offset: 0xfb0
// Size: 0x100
function on_player_connect() {
    self endon(#"disconnect");
    self flag::init(#"hash_5acbab45c034f5bd");
    while (true) {
        var_3551d88 = self waittill("new_" + "lethal_grenade");
        w_newweapon = var_3551d88.weapon;
        var_2d10a9a2 = getweapon(#"tomahawk_t8_upgraded");
        if (w_newweapon == var_2d10a9a2) {
            self flag::set(#"hash_5acbab45c034f5bd");
            continue;
        }
        self flag::clear(#"hash_5acbab45c034f5bd");
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x8ee84023, Offset: 0x10b8
// Size: 0x7c
function function_da2f42fd() {
    self endon(#"disconnect");
    self flag::wait_till_all(level.var_fc3072f8);
    self.var_750a08c1 = 0;
    self flag::wait_till(#"hash_d41f651bb868608");
    self.var_750a08c1 = undefined;
    self thread function_56686f45();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0x13c9d750, Offset: 0x1140
// Size: 0x10c
function function_1415f930(e_player) {
    if (!isplayer(e_player)) {
        return;
    }
    if (!isdefined(e_player.var_750a08c1)) {
        return;
    }
    var_ce43ca86 = getweapon(#"spork_alcatraz");
    if (self.damageweapon == var_ce43ca86) {
        e_player.var_750a08c1++;
        /#
            iprintln("<dev string:x30>" + e_player.var_750a08c1);
        #/
        if (e_player.var_750a08c1 >= 100) {
            level.var_fa799cf setvisibletoplayer(e_player);
            e_player.var_750a08c1 = undefined;
            e_player flag::set(#"hash_d41f651bb868608");
        }
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x47660a39, Offset: 0x1258
// Size: 0xac
function function_56686f45() {
    var_5fd3a0c9 = struct::get("s_white_metal_loc");
    if (!isdefined(var_5fd3a0c9.var_efd88c83)) {
        var_5fd3a0c9.var_efd88c83 = var_5fd3a0c9 zm_unitrigger::create(&function_4fb2cecf, 64, &function_c417f397);
    }
    self flag::wait_till(#"hash_334221cd7977f5d5");
    self thread function_724fa1ed();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0x326b1c6f, Offset: 0x1310
// Size: 0x116
function function_4fb2cecf(e_player) {
    if (!e_player flag::get(#"hash_334221cd7977f5d5") && e_player flag::get(#"hash_d41f651bb868608")) {
        return 1;
    }
    if (!e_player flag::get(#"hash_85d6f56e62aa0c4") && e_player flag::get(#"hash_f3f31bee1b786f2")) {
        return 1;
    }
    if (!e_player flag::get(#"hash_548a6763233817f5") && e_player flag::get(#"hash_7bcf95ea12236f0d")) {
        return 1;
    }
    return 0;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xeb86cccd, Offset: 0x1430
// Size: 0xa0c
function function_c417f397() {
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        e_player endon(#"disconnect");
        if (!e_player flag::get(#"hash_334221cd7977f5d5") && e_player flag::get(#"hash_d41f651bb868608")) {
            if (!level.var_72eb6991.var_b20e966b) {
                level.var_72eb6991.var_b20e966b = 1;
                level.var_72eb6991 movez(level.var_72eb6991.var_13ce4459, 1);
                level.var_72eb6991 waittill(#"movedone");
                level.var_72eb6991.var_275b7e94 = level.var_72eb6991 gettagorigin("tag_spork");
                level.var_72eb6991.var_e113577a = level.var_72eb6991 gettagangles("tag_spork");
                level.var_72eb6991.mdl_spork = util::spawn_model("wpn_t8_zm_spork_world", level.var_72eb6991.var_275b7e94, level.var_72eb6991.var_e113577a);
                level.var_72eb6991.mdl_spork linkto(level.var_72eb6991);
                e_player takeweapon(getweapon(#"spork_alcatraz"));
                w_current = e_player.currentweapon;
                e_player giveweapon(getweapon(#"knife"));
                e_player switchtoweapon(w_current);
                wait 0.5;
                level.var_72eb6991 rotateyaw(720, 1);
                level.var_72eb6991 waittill(#"rotatedone");
                level.var_72eb6991 movez(level.var_72eb6991.var_e25a08c2, 1.5);
                level.var_72eb6991 waittill(#"movedone");
                level.var_72eb6991.mdl_spork delete();
                e_player flag::set(#"hash_334221cd7977f5d5");
                level.var_72eb6991.var_b20e966b = 0;
            }
        } else if (!e_player flag::get(#"hash_85d6f56e62aa0c4") && e_player flag::get(#"hash_f3f31bee1b786f2")) {
            if (!level.var_72eb6991.var_b20e966b) {
                level.var_72eb6991.var_b20e966b = 1;
                level.var_72eb6991 movez(level.var_72eb6991.var_13ce4459, 1);
                level.var_72eb6991 waittill(#"movedone");
                level.var_72eb6991.var_275b7e94 = level.var_72eb6991 gettagorigin("tag_spork");
                level.var_72eb6991.var_e113577a = level.var_72eb6991 gettagangles("tag_spork");
                level.var_72eb6991.mdl_golden_knife = util::spawn_model("wpn_t7_knife_butterfly_world", level.var_72eb6991.var_275b7e94, level.var_72eb6991.var_e113577a);
                level.var_72eb6991.mdl_golden_knife linkto(level.var_72eb6991);
                e_player takeweapon(getweapon(#"golden_knife"));
                w_current = e_player.currentweapon;
                e_player giveweapon(getweapon(#"knife"));
                e_player switchtoweapon(w_current);
                wait 0.5;
                level.var_72eb6991 rotateyaw(720, 1.35);
                level.var_72eb6991 waittill(#"rotatedone");
                level.var_72eb6991 movez(level.var_72eb6991.var_e25a08c2, 1.5);
                level.var_72eb6991 waittill(#"movedone");
                level.var_72eb6991.mdl_golden_knife delete();
                e_player flag::set(#"hash_85d6f56e62aa0c4");
                level.var_72eb6991.var_b20e966b = 0;
            }
        } else if (!e_player flag::get(#"hash_548a6763233817f5") && e_player flag::get(#"hash_7bcf95ea12236f0d") && !level flag::get(#"hash_4e263b5dda470559")) {
            if (!level.var_72eb6991.var_b20e966b) {
                level flag::set(#"hash_4e263b5dda470559");
                level.var_72eb6991.var_b20e966b = 1;
                level.var_72eb6991.var_275b7e94 = level.var_72eb6991 gettagorigin("tag_spork");
                level.var_72eb6991.var_e113577a = level.var_72eb6991 gettagangles("tag_spork");
                level.var_72eb6991.var_1a73212e = util::spawn_model("wpn_t8_zm_spknifeork_world", level.var_72eb6991.var_275b7e94, level.var_72eb6991.var_e113577a);
                level.var_72eb6991.var_1a73212e linkto(level.var_72eb6991);
                level.var_72eb6991 movez(level.var_72eb6991.var_13ce4459, 1);
                level.var_72eb6991 thread function_5d1320a4();
            }
        } else if (!e_player flag::get(#"hash_548a6763233817f5") && e_player flag::get(#"hash_7bcf95ea12236f0d") && level flag::get(#"hash_4e263b5dda470559")) {
            level notify(#"hash_421aca00fd70d9ea");
            w_current = e_player.currentweapon;
            e_player giveweapon(getweapon(#"spknifeork"));
            e_player switchtoweapon(w_current);
            level.var_72eb6991.var_1a73212e delete();
            level.var_72eb6991 rotateyaw(1440, 1.5);
            level.var_72eb6991 movez(level.var_72eb6991.var_e25a08c2, 1.5);
            e_player flag::set(#"hash_548a6763233817f5");
            level.var_72eb6991.var_b20e966b = 0;
            return;
        }
        wait 0.1;
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xdcc40d08, Offset: 0x1e48
// Size: 0xde
function function_5d1320a4() {
    level endon(#"hash_421aca00fd70d9ea");
    wait 5;
    level.var_72eb6991 movez(level.var_72eb6991.var_e25a08c2, 1.5);
    level.var_72eb6991 waittill(#"movedone");
    if (isdefined(level.var_72eb6991.var_1a73212e)) {
        level.var_72eb6991.var_1a73212e delete();
    }
    level flag::clear(#"hash_4e263b5dda470559");
    level.var_72eb6991.var_b20e966b = 0;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x4e4434ae, Offset: 0x1f30
// Size: 0x6c
function function_724fa1ed() {
    self endon(#"disconnect");
    self flag::wait_till_all(level.var_ccff1dc1);
    self flag::set(#"hash_7317dfbae4fa0df5");
    self function_a0303a8d();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 2, eflags: 0x0
// Checksum 0xdc597a80, Offset: 0x1fa8
// Size: 0x1dc
function function_986832ba(e_grenade, n_grenade_charge_power) {
    if (!isdefined(level.var_3fefdc53) || !self flag::get(#"hash_334221cd7977f5d5")) {
        return false;
    }
    if (distancesquared(e_grenade.origin, level.var_3fefdc53.origin) < 62500 && !self flag::get(#"hash_465b23ced2029d95")) {
        level flag::set(#"hash_6ee51d9a7d37aecc");
        mdl_tomahawk = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
        mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
        var_10804613 = util::spawn_model(level.var_3fefdc53.model, e_grenade.origin, level.var_3fefdc53.angles);
        var_10804613 setscale(0.15);
        var_10804613 linkto(mdl_tomahawk);
        level.var_3fefdc53 delete();
        self thread zm_weap_tomahawk::tomahawk_return_player(mdl_tomahawk, undefined, 800);
        self thread function_fe316adf(mdl_tomahawk, var_10804613);
        return true;
    }
    return false;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 2, eflags: 0x0
// Checksum 0xbfa25295, Offset: 0x2190
// Size: 0x74
function function_fe316adf(mdl_tomahawk, mdl_rock) {
    self endon(#"disconnect");
    mdl_tomahawk waittill(#"death");
    mdl_rock delete();
    self flag::set(#"hash_465b23ced2029d95");
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 2, eflags: 0x0
// Checksum 0xed15605f, Offset: 0x2210
// Size: 0x1dc
function function_8b7ee76d(e_grenade, n_grenade_charge_power) {
    s_rock = struct::get("s_g_r_sp2");
    if (!isdefined(s_rock) || !self flag::get(#"hash_334221cd7977f5d5")) {
        return false;
    }
    if (distancesquared(e_grenade.origin, s_rock.origin) < 10000 && !self flag::get(#"hash_3aa12cac41d4ba98")) {
        self clientfield::set_to_player("" + #"hash_11ff39a3100ac894", 0);
        mdl_tomahawk = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
        mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
        var_10804613 = util::spawn_model(s_rock.model, e_grenade.origin, s_rock.angles);
        var_10804613 setscale(2.75);
        var_10804613 linkto(mdl_tomahawk);
        self thread zm_weap_tomahawk::tomahawk_return_player(mdl_tomahawk, undefined, 800);
        self thread function_7b8f9a08(mdl_tomahawk, var_10804613);
        return true;
    }
    return false;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 2, eflags: 0x0
// Checksum 0xf317a618, Offset: 0x23f8
// Size: 0x74
function function_7b8f9a08(mdl_tomahawk, mdl_rock) {
    self endon(#"disconnect");
    mdl_tomahawk waittill(#"death");
    mdl_rock delete();
    self flag::set(#"hash_3aa12cac41d4ba98");
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 2, eflags: 0x0
// Checksum 0x3dd2a579, Offset: 0x2478
// Size: 0x1dc
function function_663fa289(e_grenade, n_grenade_charge_power) {
    s_rock = struct::get("s_r_s_sp2");
    if (!isdefined(s_rock) || !self flag::get(#"hash_334221cd7977f5d5")) {
        return false;
    }
    if (distancesquared(e_grenade.origin, s_rock.origin) < 10000 && !self flag::get(#"hash_12826eeb0abe1308")) {
        self clientfield::set_to_player("" + #"hash_37c33178198d54e4", 0);
        mdl_tomahawk = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
        mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
        var_10804613 = util::spawn_model(s_rock.model, e_grenade.origin, s_rock.angles);
        var_10804613 setscale(0.3);
        var_10804613 linkto(mdl_tomahawk);
        self thread zm_weap_tomahawk::tomahawk_return_player(mdl_tomahawk, undefined, 800);
        self thread function_23dbe1d8(mdl_tomahawk, var_10804613);
        return true;
    }
    return false;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 2, eflags: 0x0
// Checksum 0xf5d2edb6, Offset: 0x2660
// Size: 0x74
function function_23dbe1d8(mdl_tomahawk, mdl_rock) {
    self endon(#"disconnect");
    mdl_tomahawk waittill(#"death");
    mdl_rock delete();
    self flag::set(#"hash_12826eeb0abe1308");
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xc7e4ebf2, Offset: 0x26e0
// Size: 0xcc
function function_a0303a8d() {
    self endon(#"disconnect");
    self thread acid_trap_think();
    self thread function_2c1dc5b8();
    self thread fan_trap_think();
    self thread function_725d36df();
    self flag::wait_till_all(level.var_2dd9124a);
    self flag::set(#"hash_1213756b45a941f0");
    self function_d012f2b4();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x9278f265, Offset: 0x27b8
// Size: 0x134
function acid_trap_think() {
    self endon(#"disconnect");
    s_acid_trap_place_loc = struct::get("s_acid_trap_place_loc");
    if (!isdefined(s_acid_trap_place_loc.s_unitrigger_stub)) {
        s_acid_trap_place_loc.s_unitrigger_stub = s_acid_trap_place_loc zm_unitrigger::create(&function_9116c0a6, 64, &function_ed864f14);
    }
    self.var_4111e6e7 = 0;
    self flag::wait_till(#"hash_2218e030b30c77e2");
    self clientfield::set_to_player("" + #"hash_7cdfc8f4819bab2e", 1);
    self clientfield::set_to_player("" + #"hash_5d9808a62579e894", 0);
    level.var_46c7a502 setvisibletoplayer(self);
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0x4e846789, Offset: 0x28f8
// Size: 0xb0
function function_9116c0a6(e_player) {
    if (e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_2218e030b30c77e2")) {
        return 1;
    }
    if (e_player flag::get(#"hash_2218e030b30c77e2") && !e_player flag::get(#"hash_1c96d8540b5d8c50")) {
        return 1;
    }
    return 0;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xfce3006f, Offset: 0x29b0
// Size: 0x154
function function_ed864f14() {
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_2218e030b30c77e2")) {
            e_player clientfield::set_to_player("" + #"hash_5d9808a62579e894", 1);
        } else if (e_player flag::get(#"hash_2218e030b30c77e2") && !e_player flag::get(#"hash_1c96d8540b5d8c50")) {
            level.var_46c7a502 setinvisibletoplayer(e_player);
            e_player flag::set(#"hash_1c96d8540b5d8c50");
            return;
        }
        wait 0.1;
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x4a50a3ba, Offset: 0x2b10
// Size: 0x134
function function_2c1dc5b8() {
    self endon(#"disconnect");
    s_spin_trap_place_loc = struct::get("s_spin_trap_place_loc");
    if (!isdefined(s_spin_trap_place_loc.s_unitrigger_stub)) {
        s_spin_trap_place_loc.s_unitrigger_stub = s_spin_trap_place_loc zm_unitrigger::create(&function_f94e4963, 64, &function_c3233b1f);
    }
    self.var_ddee4284 = 0;
    self flag::wait_till(#"hash_12000c871284e0b5");
    self clientfield::set_to_player("" + #"hash_1aa1c7790dc67d1e", 1);
    self clientfield::set_to_player("" + #"hash_4ec2b359458774e4", 0);
    level.var_bb7f1ea5 setvisibletoplayer(self);
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0x1eb6b329, Offset: 0x2c50
// Size: 0xb0
function function_f94e4963(e_player) {
    if (e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_12000c871284e0b5")) {
        return 1;
    }
    if (e_player flag::get(#"hash_12000c871284e0b5") && !e_player flag::get(#"hash_59f3be0494c4801f")) {
        return 1;
    }
    return 0;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x51ecc224, Offset: 0x2d08
// Size: 0x154
function function_c3233b1f() {
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_12000c871284e0b5")) {
            e_player clientfield::set_to_player("" + #"hash_4ec2b359458774e4", 1);
        } else if (e_player flag::get(#"hash_12000c871284e0b5") && !e_player flag::get(#"hash_59f3be0494c4801f")) {
            level.var_bb7f1ea5 setinvisibletoplayer(e_player);
            e_player flag::set(#"hash_59f3be0494c4801f");
            return;
        }
        wait 0.1;
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x51f409e2, Offset: 0x2e68
// Size: 0x134
function fan_trap_think() {
    self endon(#"disconnect");
    s_fan_trap_place_loc = struct::get("s_fan_trap_place_loc");
    if (!isdefined(s_fan_trap_place_loc.var_efd88c83)) {
        s_fan_trap_place_loc.var_efd88c83 = s_fan_trap_place_loc zm_unitrigger::create(&function_15eb2c24, 64, &function_3f85752a);
    }
    self.var_29a27abf = 0;
    self flag::wait_till(#"hash_7e372a60b99a89e0");
    self clientfield::set_to_player("" + #"hash_61ed2f45564d54f9", 1);
    self clientfield::set_to_player("" + #"hash_4724376be4e925a3", 0);
    level.var_c38f6610 setvisibletoplayer(self);
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0x7c3036d3, Offset: 0x2fa8
// Size: 0xb0
function function_15eb2c24(e_player) {
    if (e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_7e372a60b99a89e0")) {
        return 1;
    }
    if (e_player flag::get(#"hash_7e372a60b99a89e0") && !e_player flag::get(#"hash_29001ce64677a5cf")) {
        return 1;
    }
    return 0;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0x1f951215, Offset: 0x3060
// Size: 0x154
function function_3f85752a(e_player) {
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (e_player flag::get(#"hash_7317dfbae4fa0df5") && !e_player flag::get(#"hash_7e372a60b99a89e0")) {
            e_player clientfield::set_to_player("" + #"hash_4724376be4e925a3", 1);
        } else if (e_player flag::get(#"hash_7e372a60b99a89e0") && !e_player flag::get(#"hash_29001ce64677a5cf")) {
            level.var_c38f6610 setinvisibletoplayer(e_player);
            e_player flag::set(#"hash_29001ce64677a5cf");
            return;
        }
        wait 0.1;
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x4b284199, Offset: 0x31c0
// Size: 0x24e
function function_725d36df() {
    self endon(#"disconnect");
    while (!self flag::get(#"hash_1213756b45a941f0")) {
        waitresult = level waittill(#"hash_148b3ce521088846", #"hash_317f58ba0d580c27", #"hash_528d7b7f7d6c51a1");
        switch (waitresult._notify) {
        case #"hash_148b3ce521088846":
            if (isdefined(self.var_ddee4284)) {
                self.var_ddee4284++;
                /#
                    self function_3086f5d2(self.var_ddee4284, "<dev string:x4f>");
                #/
                if (self.var_ddee4284 >= 20) {
                    self.var_ddee4284 = undefined;
                    self flag::set(#"hash_12000c871284e0b5");
                }
            }
            break;
        case #"hash_317f58ba0d580c27":
            if (isdefined(self.var_4111e6e7)) {
                self.var_4111e6e7++;
                /#
                    self function_3086f5d2(self.var_4111e6e7, "<dev string:x59>");
                #/
                if (self.var_4111e6e7 >= 20) {
                    self.var_4111e6e7 = undefined;
                    self flag::set(#"hash_2218e030b30c77e2");
                }
            }
            break;
        case #"hash_528d7b7f7d6c51a1":
            if (isdefined(self.var_29a27abf)) {
                self.var_29a27abf++;
                /#
                    self function_3086f5d2(self.var_29a27abf, "<dev string:x63>");
                #/
                if (self.var_29a27abf >= 20) {
                    self.var_29a27abf = undefined;
                    self flag::set(#"hash_7e372a60b99a89e0");
                }
            }
            break;
        }
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x1c327d00, Offset: 0x3418
// Size: 0x94
function function_d012f2b4() {
    self endon(#"disconnect");
    level.t_g_o_s4 = getent("t_g_o_s4", "targetname");
    self thread function_4cd059ff();
    self flag::wait_till(#"hash_21827937692e2aba");
    self construction();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xa9049fc4, Offset: 0x34b8
// Size: 0x126
function function_4cd059ff() {
    self endon(#"disconnect", #"hash_21827937692e2aba");
    while (!self flag::get(#"hash_21827937692e2aba")) {
        s_result = self waittill(#"throwing_tomahawk");
        e_tomahawk = s_result.e_grenade;
        if (!isdefined(e_tomahawk)) {
            return;
        }
        while (isdefined(e_tomahawk) && self flag::get(#"hash_1213756b45a941f0") && level flag::get(#"hash_5466d69fa17fc721")) {
            if (e_tomahawk istouching(level.t_g_o_s4)) {
                self function_8053c170();
                break;
            }
            waitframe(1);
        }
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xb47d8802, Offset: 0x35e8
// Size: 0xcc
function function_8053c170() {
    self endon(#"disconnect");
    var_bf6c24f6 = struct::get("s_g_n_o_sp2");
    var_aff7887f = getent("mdl_g_o_s4", "targetname");
    var_aff7887f setinvisibletoplayer(self);
    scene::add_scene_func(#"p8_fxanim_zm_esc_golden_nugget_bundle", &function_96f09c55, "play", self);
    var_bf6c24f6 thread scene::play();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 2, eflags: 0x0
// Checksum 0x615c74f3, Offset: 0x36c0
// Size: 0xf4
function function_96f09c55(a_ents, e_player) {
    self notify("762a9475fe00de85");
    self endon("762a9475fe00de85");
    e_nugget = a_ents[#"prop 1"];
    e_nugget setinvisibletoall();
    e_nugget setvisibletoplayer(e_player);
    self waittill(#"scene_done");
    e_nugget.s_unitrigger_stub = e_nugget zm_unitrigger::function_b7e350e6(&function_43ccc2ee, 64);
    e_player flag::set(#"hash_21827937692e2aba");
    e_nugget delete();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0x12669f87, Offset: 0x37c0
// Size: 0x66
function function_43ccc2ee(e_player) {
    if (!e_player flag::get(#"hash_21827937692e2aba") && e_player flag::get(#"hash_1213756b45a941f0")) {
        return 1;
    }
    return 0;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x6e937414, Offset: 0x3830
// Size: 0xc4
function construction() {
    self endon(#"disconnect");
    var_9217c6d6 = struct::get("s_table_loc_ni");
    if (!isdefined(var_9217c6d6.var_efd88c83)) {
        var_9217c6d6.var_efd88c83 = var_9217c6d6 zm_unitrigger::create(&function_19506385, 64, &function_83890be9);
    }
    self flag::wait_till(#"hash_f3f31bee1b786f2");
    self function_59b0326d();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0xddab98b8, Offset: 0x3900
// Size: 0xbe
function function_19506385(e_player) {
    if (!e_player flag::get(#"hash_3043d41614094af2") && e_player flag::get(#"hash_21827937692e2aba")) {
        return 1;
    }
    if (!e_player flag::get(#"hash_f3f31bee1b786f2") && e_player flag::get(#"hash_3043d41614094af2")) {
        return 1;
    }
    return 0;
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x9f18d375, Offset: 0x39c8
// Size: 0x49c
function function_83890be9() {
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        e_player endon(#"disconnect");
        if (!e_player flag::get(#"hash_3043d41614094af2") && e_player flag::get(#"hash_21827937692e2aba")) {
            foreach (mdl_piece in level.var_60c2dc00) {
                mdl_piece setvisibletoplayer(e_player);
            }
            if (e_player hasweapon(getweapon(#"spork_alcatraz"))) {
                e_player takeweapon(getweapon(#"spork_alcatraz"));
                if (isdefined(e_player.var_22a7e110)) {
                    e_player giveweapon(e_player.var_22a7e110);
                } else {
                    w_knife = getweapon(#"knife");
                    e_player giveweapon(w_knife);
                }
            }
            wait 3;
            level.var_60c2dc00 = getentarray("zm_escape_rubble_pieces", "targetname");
            foreach (mdl_piece in level.var_60c2dc00) {
                mdl_piece setinvisibletoall();
            }
            level.var_eb89f0ed setvisibletoplayer(e_player);
            e_player flag::set(#"hash_3043d41614094af2");
        } else if (!e_player flag::get(#"hash_f3f31bee1b786f2") && e_player flag::get(#"hash_3043d41614094af2")) {
            level.var_eb89f0ed setinvisibletoplayer(e_player);
            if (isdefined(e_player.var_22a7e110) && e_player hasweapon(e_player.var_22a7e110)) {
                e_player takeweapon(e_player.var_22a7e110);
                w_current = e_player.currentweapon;
                e_player giveweapon(getweapon(#"golden_knife"));
                e_player switchtoweapon(w_current);
            } else {
                w_current = e_player.currentweapon;
                e_player giveweapon(getweapon(#"golden_knife"));
                e_player switchtoweapon(w_current);
            }
            e_player flag::set(#"hash_f3f31bee1b786f2");
            return;
        }
        wait 0.1;
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xcadde79f, Offset: 0x3e70
// Size: 0x54
function function_59b0326d() {
    self endon(#"disconnect");
    self flag::wait_till(#"hash_85d6f56e62aa0c4");
    self function_45600e85();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0x55d5fe72, Offset: 0x3ed0
// Size: 0x264
function function_45600e85() {
    self endon(#"disconnect");
    foreach (var_f0bd464e in level.var_a90c4d34) {
        var_f0bd464e setvisibletoplayer(self);
    }
    if (!level flag::get(#"hash_43114a11c9ca5302")) {
        zm_spawner::register_zombie_death_event_callback(&function_5581c0fc);
        level flag::set(#"hash_43114a11c9ca5302");
        level.var_ae85a919 = 1;
    }
    self.var_cf6765e1 = 0;
    self thread function_77aae5d0();
    self flag::wait_till(#"hash_7bcf95ea12236f0d");
    self.var_cf6765e1 = undefined;
    if (level flag::get(#"hash_43114a11c9ca5302")) {
        foreach (player in getplayers()) {
            if (isdefined(player.var_cf6765e1)) {
                level.var_ae85a919 = 1;
            }
        }
        if (!level.var_ae85a919) {
            zm_spawner::deregister_zombie_death_event_callback(&function_5581c0fc);
            level flag::clear(#"hash_43114a11c9ca5302");
        }
    }
    self function_75aadfe9();
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xeba290ac, Offset: 0x4140
// Size: 0xb8
function function_77aae5d0() {
    self endon(#"disconnect");
    t_r_br_sp2_7 = getent("t_r_br_sp2_7", "targetname");
    self.var_8b9a9c1 = 0;
    while (!self flag::get(#"hash_7bcf95ea12236f0d")) {
        if (self istouching(t_r_br_sp2_7)) {
            self.var_8b9a9c1 = 1;
        } else {
            self.var_8b9a9c1 = 0;
        }
        wait 0.1;
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 1, eflags: 0x0
// Checksum 0x931bd1f3, Offset: 0x4200
// Size: 0x162
function function_5581c0fc(e_player) {
    if (!isplayer(e_player)) {
        return;
    }
    if (!isdefined(e_player.var_cf6765e1)) {
        return;
    }
    w_knife = getweapon("knife");
    if (self.damageweapon == w_knife && self.archetype == "brutus" && e_player.var_8b9a9c1 === 1) {
        e_player.var_cf6765e1++;
        e_player flag::set(#"hash_7bcf95ea12236f0d");
        level.var_ae85a919 = 0;
        foreach (player in getplayers()) {
            if (isdefined(player.var_cf6765e1)) {
                level.var_ae85a919 = 1;
            }
        }
    }
}

// Namespace namespace_7e0a2a28/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xee61ec2d, Offset: 0x4370
// Size: 0x24
function function_75aadfe9() {
    self flag::wait_till(#"hash_548a6763233817f5");
}

/#

    // Namespace namespace_7e0a2a28/namespace_50e40b79
    // Params 2, eflags: 0x0
    // Checksum 0xcaa264dc, Offset: 0x43a0
    // Size: 0x2fa
    function function_3086f5d2(var_82805bdb, var_63feebc3) {
        switch (var_63feebc3) {
        case #"acid trap":
            switch (var_82805bdb) {
            case 10:
            case 20:
            case 30:
            case 40:
            case 50:
            case 60:
            case 70:
            case 80:
            case 90:
            case 100:
                iprintln("<dev string:x6c>" + var_82805bdb);
                break;
            }
            break;
        case #"spin trap":
            switch (var_82805bdb) {
            case 10:
            case 20:
            case 30:
            case 40:
            case 50:
            case 60:
            case 70:
            case 80:
            case 90:
            case 100:
                iprintln("<dev string:x88>" + var_82805bdb);
                break;
            }
            break;
        case #"fan trap":
            switch (var_82805bdb) {
            case 10:
            case 20:
            case 30:
            case 40:
            case 50:
            case 60:
            case 70:
            case 80:
            case 90:
            case 100:
                iprintln("<dev string:xa4>" + var_82805bdb);
                break;
            }
            break;
        }
    }

#/
