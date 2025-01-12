#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_blundergat;
#using scripts\zm\zm_escape_util;
#using scripts\zm_common\util\ai_brutus_util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace namespace_3f0e5106;

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x2
// Checksum 0x7ed693d9, Offset: 0x448
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"hash_32658a301920c858", &__init__, &__main__, undefined);
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x6d7440e2, Offset: 0x498
// Size: 0x5cc
function __init__() {
    clientfield::register("scriptmover", "magma_fireplace_fx", 1, getminbitcountfornum(4), "int");
    clientfield::register("scriptmover", "magma_fireplace_skull_fx", 1, 1, "int");
    clientfield::register("scriptmover", "magma_door_barrier_fx", 1, 1, "int");
    clientfield::register("scriptmover", "magma_glow_fx", 1, 1, "int");
    clientfield::register("scriptmover", "magma_forging_fx", 1, 2, "int");
    clientfield::register("scriptmover", "magma_urn_fire_fx", 1, 2, "int");
    clientfield::register("scriptmover", "magma_urn_ember_fx", 1, 1, "int");
    clientfield::register("scriptmover", "bg_spawn_fx", 1, 1, "int");
    clientfield::register("toplayer", "magma_gat_glow_override", 1, 1, "int");
    clientfield::register("toplayer", "magma_gat_glow_recharge", 1, 1, "counter");
    clientfield::register("toplayer", "magma_gat_glow_shot_fired", 1, 1, "counter");
    clientfield::register("scriptmover", "magma_essence_explode_fx", 1, 1, "counter");
    clientfield::register("scriptmover", "magma_gat_essence_fx", 1, 1, "int");
    clientfield::register("scriptmover", "magma_gat_disappear_fx", 1, 1, "counter");
    clientfield::register("scriptmover", "magma_urn_triggered_fx", 1, 1, "counter");
    clientfield::register("scriptmover", "acid_gat_lock_fx", 1, 1, "counter");
    clientfield::register("scriptmover", "" + #"hash_7692067c56d8b6cc", 1, 1, "int");
    level.var_6a55b564 = getentarray("mg_al_skull", "targetname");
    level.var_a661072b = getent("mg_ho_vol", "targetname");
    zm_powerups::set_weapon_ignore_max_ammo(#"ww_blundergat_fire_t8_unfinished");
    var_b1db1276 = struct::get("mg_door_frame_pos", "targetname");
    level.var_70bec34a = util::spawn_model("tag_origin", var_b1db1276.origin, var_b1db1276.angles);
    var_598317e7 = struct::get("mg_fp_pos", "targetname");
    level.var_6a1a98e9 = util::spawn_model("tag_origin", var_598317e7.origin, var_598317e7.angles);
    var_f8b78f96 = struct::get("mg_forg_pos", "targetname");
    level.var_42be3d8c = util::spawn_model("tag_origin", var_f8b78f96.origin, var_f8b78f96.angles);
    level flag::init(#"hash_3ec656e276ceee53");
    level flag::init(#"hash_3fb7d58b07b04333");
    level flag::init(#"hash_1d5f5fbf80476490");
    level flag::init(#"magma_forge_completed");
    level flag::init(#"hash_5e6097345e223e2d");
    level.var_770ad102 = 0;
    scene::add_scene_func(#"aib_vign_zm_mob_smelter_ghost", &function_440bf8d0, "play");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0xad8e5e00, Offset: 0xa70
// Size: 0xf4
function __main__() {
    if (!zm_custom::function_5638f689(#"zmwonderweaponisenabled")) {
        return;
    }
    /#
        level thread function_fbff3e7c();
    #/
    level flag::wait_till("start_zombie_round_logic");
    var_cf459596 = struct::get_array("mg_fire_urn", "targetname");
    array::thread_all(var_cf459596, &function_5c9e2aa1);
    level thread function_951176a1();
    level thread function_50341e45();
    level thread function_18ca0d89();
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x781e94c0, Offset: 0xb70
// Size: 0xa4
function function_951176a1() {
    var_598317e7 = struct::get("mg_fp_pos");
    var_598317e7.s_unitrigger_stub = var_598317e7 zm_unitrigger::create(&function_1ec225c6, 128, &function_ce4a7182);
    zm_unitrigger::unitrigger_force_per_player_triggers(var_598317e7.s_unitrigger_stub, 1);
    level.var_6a1a98e9 clientfield::set("magma_fireplace_fx", 1);
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0xe99ab266, Offset: 0xc20
// Size: 0x3aa
function function_1ec225c6(player) {
    if (level flag::get(#"magma_forge_completed") || level flag::get(#"hash_5e6097345e223e2d")) {
        return 0;
    }
    if (isdefined(zm_audio::function_8ff5b3a1(player.currentweapon))) {
        return 0;
    }
    if ((player hasweapon(getweapon(#"ww_blundergat_t8")) || player hasweapon(getweapon(#"ww_blundergat_t8_upgraded")) || player hasweapon(getweapon(#"ww_blundergat_acid_t8")) || player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded"))) && !isdefined(self.stub.var_de5370c5)) {
        if (player hasweapon(getweapon(#"ww_blundergat_t8"))) {
            self sethintstring(#"hash_6aefb24885426431");
        } else if (player hasweapon(getweapon(#"ww_blundergat_t8_upgraded"))) {
            self sethintstring(#"hash_7755302d416e3168");
        } else if (player hasweapon(getweapon(#"ww_blundergat_acid_t8"))) {
            self sethintstring(#"hash_1875e6c5a3e5e96c");
        } else if (player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded"))) {
            self sethintstring(#"hash_ecb311bfa753664");
        }
        return 1;
    }
    if (isdefined(player.var_3aabe884) && player.var_3aabe884) {
        if (!level flag::get(#"hash_1d5f5fbf80476490") && isdefined(self.stub.var_fd5d06a6)) {
            self sethintstring(#"hash_86231cba8afa1fd");
            return 1;
        } else if (level flag::get(#"hash_1d5f5fbf80476490")) {
            self sethintstring(#"hash_6717cabd759589c4");
            return 1;
        } else {
            return 0;
        }
        return;
    }
    return 0;
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x4
// Checksum 0xd32b563a, Offset: 0xfd8
// Size: 0x6c8
function private function_ce4a7182() {
    self thread function_b4cde3f();
    v_weapon_origin_offset = (8, -2, 9);
    v_weapon_angles_offset = (0, -90, 0);
    self.v_weapon_origin = level.var_6a1a98e9.origin + v_weapon_origin_offset;
    self.v_weapon_angles = level.var_6a1a98e9.angles + v_weapon_angles_offset;
    var_fd5d06a6 = undefined;
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (!level flag::get(#"hash_3fb7d58b07b04333") && !level flag::get(#"hash_1d5f5fbf80476490")) {
            var_ba1489dd = undefined;
            if (e_player hasweapon(getweapon(#"ww_blundergat_t8"))) {
                var_ba1489dd = #"ww_blundergat_t8";
            } else if (e_player hasweapon(getweapon(#"ww_blundergat_t8_upgraded"))) {
                var_ba1489dd = #"ww_blundergat_t8_upgraded";
            } else if (e_player hasweapon(getweapon(#"ww_blundergat_acid_t8"))) {
                var_ba1489dd = #"ww_blundergat_acid_t8";
            } else if (e_player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded"))) {
                var_ba1489dd = #"ww_blundergat_acid_t8_upgraded";
            }
            if (isdefined(var_ba1489dd)) {
                e_player.var_c7229167 = var_ba1489dd;
                e_player takeweapon(getweapon(var_ba1489dd));
                e_player.var_545303fc = 1;
                self.stub.var_de5370c5 = 1;
                level.var_770ad102 = 0;
                exploder::exploder("fxexplo_magma_window_barrier_fx");
                level.var_6a1a98e9 clientfield::set("magma_fireplace_fx", 1);
                playsoundatposition(#"hash_2c4234f291620027", self.origin);
                self.var_f19b316b = zm_utility::spawn_weapon_model(getweapon(var_ba1489dd), undefined, self.v_weapon_origin, self.v_weapon_angles);
                self.var_f19b316b thread scene::play(#"p8_fxanim_zm_esc_blundergat_fireplace_hover_bundle", self.var_f19b316b);
                level flag::clear(#"hash_3ec656e276ceee53");
                e_player thread function_477fecfb(self);
                e_player thread function_b9f7cd66();
                e_player function_b25fd98a();
                if (isalive(e_player) && level flag::get(#"hash_3fb7d58b07b04333")) {
                    var_fd5d06a6 = 1;
                    self.stub.var_fd5d06a6 = 1;
                    e_player.var_3aabe884 = 1;
                } else {
                    self function_5911bcaf(e_player, 1);
                    playsoundatposition(#"hash_1d6afdd3f475507e", (0, 0, 0));
                }
            }
            continue;
        }
        if (level flag::get(#"hash_3fb7d58b07b04333") && !level flag::get(#"hash_1d5f5fbf80476490")) {
            self.var_f19b316b delete();
            self.var_f19b316b = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_fire_t8_unfinished"), undefined, self.v_weapon_origin, self.v_weapon_angles);
            self.stub.var_fd5d06a6 = undefined;
            level.var_6a1a98e9 function_ef929c70();
            level flag::set(#"hash_1d5f5fbf80476490");
            if (isalive(e_player)) {
                self thread function_411987b4(e_player);
                self thread wait_for_timeout(e_player, var_fd5d06a6);
                var_56331bd1 = self waittill(#"magma_timeout", #"magma_taken");
                e_player.var_545303fc = undefined;
                e_player.var_3aabe884 = undefined;
                self.stub.var_de5370c5 = undefined;
                self.stub.var_fd5d06a6 = undefined;
                if (var_56331bd1._notify == "magma_timeout") {
                    self function_5911bcaf(e_player, 1);
                    playsoundatposition(#"hash_1d6afdd3f475507e", (0, 0, 0));
                }
            }
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 2, eflags: 0x0
// Checksum 0x9f0fb81a, Offset: 0x16a8
// Size: 0x17e
function function_5911bcaf(e_player, var_95455b51) {
    level notify(#"hash_fd8be2ffb55eaf7");
    level.var_770ad102 = 0;
    function_74f946df();
    exploder::stop_exploder("fxexplo_magma_window_barrier_fx");
    level.var_6a1a98e9 clientfield::set("magma_fireplace_fx", 1);
    level flag::clear(#"hash_3fb7d58b07b04333");
    level flag::clear(#"hash_1d5f5fbf80476490");
    level flag::clear(#"hash_3ec656e276ceee53");
    if (isdefined(self.var_f19b316b)) {
        if (isdefined(var_95455b51) && var_95455b51) {
            self thread magma_gat_disappear_fx();
        }
        self.var_f19b316b delete();
    }
    self.stub.var_de5370c5 = undefined;
    self.stub.var_fd5d06a6 = undefined;
    if (isdefined(e_player)) {
        e_player.var_c7229167 = undefined;
        e_player.var_3f6d4df = undefined;
        e_player.var_3aabe884 = undefined;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x3e362716, Offset: 0x1830
// Size: 0xa8
function function_74f946df() {
    foreach (mdl_skull in level.var_6a55b564) {
        mdl_skull setmodel("p8_zm_esc_skull_sgl");
        mdl_skull clientfield::set("magma_fireplace_skull_fx", 0);
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x36e23ca1, Offset: 0x18e0
// Size: 0x84
function magma_gat_disappear_fx() {
    var_2741f335 = util::spawn_model("tag_origin", self.v_weapon_origin, self.v_weapon_angles);
    if (isdefined(var_2741f335)) {
        waitframe(1);
        var_2741f335 clientfield::increment("magma_gat_disappear_fx");
        wait 3;
        var_2741f335 delete();
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x7f99021f, Offset: 0x1970
// Size: 0x15c
function function_ef929c70() {
    level endon(#"hash_fd8be2ffb55eaf7");
    var_992817cf = array::sort_by_script_int(level.var_6a55b564, 0);
    foreach (mdl_skull in var_992817cf) {
        mdl_skull setmodel("p8_zm_esc_skull_sgl");
        mdl_skull clientfield::set("magma_fireplace_skull_fx", 0);
        wait 0.5;
    }
    wait 0.5;
    self clientfield::set("magma_fireplace_fx", 4);
    playsoundatposition(#"hash_5642bd4cb9f030d7", self.origin);
    wait 1;
    self clientfield::set("magma_fireplace_fx", 3);
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x4
// Checksum 0x13700fe8, Offset: 0x1ad8
// Size: 0x28a
function private function_411987b4(e_player) {
    self endon(#"magma_timeout");
    e_player endon(#"disconnect");
    while (true) {
        s_result = self waittill(#"trigger");
        if (s_result.activator == e_player) {
            if (zm_utility::can_use(e_player, 1) && e_player.currentweapon.name != "none") {
                self notify(#"magma_taken");
                e_player notify(#"magma_taken");
                var_dd27188c = zm_utility::get_player_weapon_limit(e_player);
                a_primaries = e_player getweaponslistprimaries();
                if (isdefined(a_primaries) && a_primaries.size >= var_dd27188c) {
                    e_player takeweapon(e_player.currentweapon);
                }
                e_player giveweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"));
                e_player switchtoweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"));
                e_player clientfield::set_to_player("magma_gat_glow_override", 1);
                e_player.var_fdf5920e = 1;
                level notify(#"hash_575b654fc5c59146", {#e_player:e_player});
                level flag::set(#"hash_5e6097345e223e2d");
                e_player zm_audio::create_and_play_dialog("weapon_pickup", "magmagat_unfinished");
                e_player thread function_ac51b6fb();
                self function_5911bcaf(undefined, undefined);
                return;
            }
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 2, eflags: 0x4
// Checksum 0x393f14c5, Offset: 0x1d70
// Size: 0x72
function private wait_for_timeout(e_player, var_d78a8ead) {
    self endon(#"magma_taken");
    if (isdefined(var_d78a8ead) && var_d78a8ead) {
        wait 30;
    } else {
        wait 20;
    }
    self notify(#"magma_timeout");
    if (isdefined(e_player)) {
        e_player.var_c7229167 = undefined;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x584f13c7, Offset: 0x1df0
// Size: 0x108
function function_b4cde3f() {
    level flag::wait_till(#"magma_forge_completed");
    if (isdefined(self.stub.var_de5370c5) && self.stub.var_de5370c5) {
        foreach (e_player in level.activeplayers) {
            if (isdefined(e_player.var_c7229167)) {
                e_player giveweapon(getweapon(e_player.var_c7229167));
                self function_5911bcaf(e_player);
            }
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x45947351, Offset: 0x1f00
// Size: 0xfc
function function_b25fd98a() {
    self endoncallback(&function_3fcacc8f, #"disconnect");
    level.var_70bec34a thread clientfield::set("magma_door_barrier_fx", 1);
    callback::on_ai_killed(&function_b9b5a3d1);
    s_result = level flag::wait_till_any(array(#"hash_3ec656e276ceee53", #"hash_3fb7d58b07b04333"));
    callback::remove_on_ai_killed(&function_b9b5a3d1);
    level.var_70bec34a thread clientfield::set("magma_door_barrier_fx", 0);
    wait 1;
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x1c9f3151, Offset: 0x2008
// Size: 0x4c
function function_3fcacc8f(str_notify) {
    callback::remove_on_ai_killed(&function_b9b5a3d1);
    level flag::set(#"hash_3ec656e276ceee53");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x19d76511, Offset: 0x2060
// Size: 0xa4
function function_b9b5a3d1(s_params) {
    if (self.archetype != "zombie" && self.archetype != "zombie_dog" && self.archetype != "brutus") {
        return;
    }
    if (isplayer(s_params.eattacker) && self istouching(level.var_a661072b)) {
        self thread function_1ad8c8a8();
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x4c112028, Offset: 0x2110
// Size: 0x154
function function_1ad8c8a8() {
    var_b44c4d3d = util::spawn_model("tag_origin", self.origin + (0, 0, 22), self.angles);
    var_b44c4d3d endon(#"death");
    var_1005298 = spawn("trigger_radius", self.origin, 0, 24, 96);
    var_1005298 setvisibletoteam(util::get_enemy_team(self.team));
    var_1005298 setteamfortrigger(util::get_enemy_team(self.team));
    var_1005298 thread function_fe093ed5(var_b44c4d3d);
    var_b44c4d3d thread function_275d7bd4(var_1005298);
    var_b44c4d3d thread function_6e1f5f84(var_1005298);
    while (isdefined(var_1005298)) {
        wait 0.25;
    }
    var_b44c4d3d delete();
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x4fe4579, Offset: 0x2270
// Size: 0x360
function function_fe093ed5(var_b44c4d3d) {
    self endon(#"death");
    var_b44c4d3d endon(#"death");
    var_d90c64d4 = int(5);
    foreach (mdl_skull in level.var_6a55b564) {
        if (mdl_skull.script_int == 0) {
            var_3976ce39 = mdl_skull;
            continue;
        }
        if (mdl_skull.script_int == 1) {
            var_137453d0 = mdl_skull;
            continue;
        }
        var_857bc30b = mdl_skull;
    }
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            level.var_770ad102++;
            playsoundatposition(#"hash_7924de0ae1c7e3c7", self.origin);
            if (level.var_770ad102 == var_d90c64d4) {
                var_3976ce39 setmodel("p8_zm_esc_skull_afterlife");
                var_3976ce39 thread clientfield::set("magma_fireplace_skull_fx", 1);
            } else if (level.var_770ad102 == var_d90c64d4 * 2) {
                var_137453d0 setmodel("p8_zm_esc_skull_afterlife");
                var_137453d0 thread clientfield::set("magma_fireplace_skull_fx", 1);
            } else if (level.var_770ad102 >= 15) {
                var_857bc30b setmodel("p8_zm_esc_skull_afterlife");
                var_857bc30b thread clientfield::set("magma_fireplace_skull_fx", 1);
                level.var_6a1a98e9 clientfield::set("magma_fireplace_fx", 2);
                exploder::exploder_stop("fxexplo_magma_window_barrier_fx");
                level flag::set(#"hash_3fb7d58b07b04333");
            }
            var_b44c4d3d clientfield::set("magma_gat_essence_fx", 0);
            playfx(level._effect[#"powerup_grabbed_solo"], var_b44c4d3d.origin);
            if (isdefined(self)) {
                self delete();
            }
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x579c9856, Offset: 0x25d8
// Size: 0x68
function function_275d7bd4(var_1005298) {
    self endon(#"death");
    self clientfield::set("magma_gat_essence_fx", 1);
    while (isdefined(var_1005298)) {
        self zm_escape_util::make_wobble();
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x7e81c099, Offset: 0x2648
// Size: 0xbc
function function_6e1f5f84(var_1005298) {
    self endon(#"death");
    self movez(36, 3);
    wait 3;
    if (isdefined(var_1005298)) {
        var_1005298 delete();
    }
    self clientfield::set("magma_gat_essence_fx", 0);
    playsoundatposition(#"hash_279a376468c0749c", self.origin);
    self delete();
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0xf35e7a6b, Offset: 0x2710
// Size: 0xbc
function function_477fecfb(var_5ad4cd8b) {
    level endon(#"hash_3ec656e276ceee53");
    self endon(#"magma_taken");
    self waittill(#"death", #"disconnect");
    if (level flag::get(#"hash_3fb7d58b07b04333")) {
        var_5ad4cd8b function_5911bcaf(self, 1);
    }
    level flag::set(#"hash_3ec656e276ceee53");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0xf476c69b, Offset: 0x27d8
// Size: 0x128
function function_b9f7cd66() {
    level endon(#"hash_3ec656e276ceee53");
    while (!level flag::get(#"hash_3fb7d58b07b04333")) {
        if (!self istouching(level.var_a661072b)) {
            if (!isdefined(self.var_3f6d4df)) {
                self.var_3f6d4df = 0;
            } else {
                self.var_3f6d4df++;
                if (self.var_3f6d4df >= 30) {
                    level flag::set(#"hash_3ec656e276ceee53");
                } else if (self.var_3f6d4df >= 10 && level.var_770ad102 > 0) {
                    level.var_770ad102 = 0;
                    function_74f946df();
                }
            }
        } else {
            self.var_3f6d4df = 0;
        }
        wait 1;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0xa1d30c92, Offset: 0x2908
// Size: 0x28e
function function_ac51b6fb() {
    self thread function_d5bd32ac();
    self thread function_ac8881c();
    self thread function_58b603dc();
    self.n_cooldown_time = 25;
    while (isdefined(self) && self.n_cooldown_time > 0 && isdefined(self.var_fdf5920e) && self.var_fdf5920e) {
        self.n_cooldown_time -= 0.5;
        wait 0.5;
    }
    if (isdefined(self.var_fdf5920e) && self.var_fdf5920e && self.n_cooldown_time <= 0) {
        if (self hasweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"))) {
            self clientfield::set_to_player("magma_gat_glow_override", 0);
            self takeweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"));
            playsoundatposition(#"hash_1d6afdd3f475507e", (0, 0, 0));
        }
        if (isdefined(self.var_c7229167)) {
            self giveweapon(getweapon(self.var_c7229167));
            self switchtoweapon(getweapon(self.var_c7229167));
            self zm_audio::create_and_play_dialog("magmagat", "burnout", undefined, 1);
            self.var_c7229167 = undefined;
        }
        self.var_fdf5920e = undefined;
        self notify(#"hash_3c807aeefe7734fa");
        function_34f43e67();
        self notify(#"hash_2c23d48f0925d266");
        level flag::clear(#"hash_5e6097345e223e2d");
    }
    self.n_cooldown_time = undefined;
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0xfe0ac238, Offset: 0x2ba0
// Size: 0x23a
function function_d5bd32ac() {
    self endon(#"death", #"disconnect", #"hash_5dc448a84a24492", #"hash_2c23d48f0925d266");
    while (true) {
        s_result = self waittill(#"weapon_change");
        wait 0.1;
        if (isdefined(self.var_ce1f9aca) && self.var_ce1f9aca) {
            continue;
        }
        if (s_result.last_weapon != getweapon(#"ww_blundergat_fire_t8_unfinished")) {
            continue;
        }
        if (self hasweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"))) {
            self clientfield::set_to_player("magma_gat_glow_override", 0);
            self takeweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"));
            playsoundatposition(#"hash_1d6afdd3f475507e", (0, 0, 0));
        }
        if (isdefined(self.var_c7229167)) {
            self giveweapon(getweapon(self.var_c7229167));
            self switchtoweapon(getweapon(self.var_c7229167));
            self.var_c7229167 = undefined;
        }
        level flag::clear(#"hash_5e6097345e223e2d");
        function_34f43e67();
        self.var_fdf5920e = undefined;
        self notify(#"hash_3c807aeefe7734fa");
        self notify(#"hash_2c23d48f0925d266");
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x589bc9b0, Offset: 0x2de8
// Size: 0x1cc
function function_ac8881c() {
    self endon(#"death", #"disconnect", #"hash_5dc448a84a24492", #"hash_2c23d48f0925d266");
    self waittill(#"fasttravel_over");
    if (self hasweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"))) {
        self clientfield::set_to_player("magma_gat_glow_override", 0);
        self takeweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"));
        playsoundatposition(#"hash_1d6afdd3f475507e", (0, 0, 0));
        if (isdefined(self.var_c7229167)) {
            self giveweapon(getweapon(self.var_c7229167));
            self switchtoweapon(getweapon(self.var_c7229167));
            self.var_c7229167 = undefined;
        }
        function_34f43e67();
        self.var_fdf5920e = undefined;
        self notify(#"hash_3c807aeefe7734fa");
        self notify(#"hash_2c23d48f0925d266");
        level flag::clear(#"hash_5e6097345e223e2d");
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0xc5004b14, Offset: 0x2fc0
// Size: 0x128
function function_58b603dc() {
    self endon(#"death", #"disconnect", #"hash_5dc448a84a24492", #"hash_2c23d48f0925d266");
    while (true) {
        s_result = self waittill(#"weapon_fired");
        if (s_result.weapon == getweapon(#"ww_blundergat_fire_t8_unfinished")) {
            assert(isdefined(self.n_cooldown_time), "<dev string:x30>");
            self.n_cooldown_time -= 6;
            self clientfield::increment_to_player("magma_gat_glow_shot_fired");
            self givemaxammo(getweapon(#"ww_blundergat_fire_t8_unfinished"));
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x56ef965f, Offset: 0x30f0
// Size: 0x128
function function_5c9e2aa1() {
    var_e0134271 = util::spawn_model("tag_origin", self.origin, self.angles);
    self.s_unitrigger_stub = self zm_unitrigger::create(&function_cb51cff2, 64, &function_8b08f7ca, 0);
    self.s_unitrigger_stub.var_e0134271 = var_e0134271;
    self.var_e0134271 = var_e0134271;
    wait 0.4;
    var_e0134271 clientfield::set("magma_urn_fire_fx", 1);
    while (true) {
        s_result = level waittill(#"hash_575b654fc5c59146");
        if (isplayer(s_result.e_player)) {
            var_e0134271 clientfield::set("magma_urn_fire_fx", 2);
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x6b0cd121, Offset: 0x3220
// Size: 0x3a
function function_cb51cff2(player) {
    if (isdefined(player.var_fdf5920e) && player.var_fdf5920e) {
        return 1;
    }
    return 0;
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x1088e05, Offset: 0x3268
// Size: 0x280
function function_8b08f7ca() {
    var_94ef1c4a = undefined;
    while (true) {
        var_3be5dde3 = 25;
        n_power = var_3be5dde3;
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (isdefined(e_player.var_fdf5920e) && e_player.var_fdf5920e && var_3be5dde3 > 0) {
            self.stub.var_e0134271 clientfield::increment("magma_urn_triggered_fx");
            self.stub.var_e0134271 clientfield::set("magma_urn_ember_fx", 0);
            self.stub.var_e0134271 clientfield::set("magma_urn_fire_fx", 0);
            if (isdefined(e_player.n_cooldown_time)) {
                if (e_player.n_cooldown_time + n_power > 25) {
                    e_player.n_cooldown_time = 25;
                } else {
                    e_player.n_cooldown_time += n_power;
                }
            }
            var_3be5dde3 = 0;
            if (isalive(e_player) && isdefined(e_player.var_fdf5920e) && e_player.var_fdf5920e) {
                e_player clientfield::increment_to_player("magma_gat_glow_recharge");
                e_player givemaxammo(getweapon(#"ww_blundergat_fire_t8_unfinished"));
                if (!(isdefined(e_player.var_cf8d891d) && e_player.var_cf8d891d)) {
                    e_player.var_cf8d891d = 1;
                    e_player thread function_62c475a5();
                    e_player zm_audio::create_and_play_dialog("magmagat", "reheat", undefined, 1);
                }
            }
            level waittill(#"hash_575b654fc5c59146");
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x4
// Checksum 0x6b12e7e1, Offset: 0x34f0
// Size: 0x2a
function private function_62c475a5() {
    self endon(#"disconnect");
    wait 45;
    self.var_cf8d891d = undefined;
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0xf01f08ce, Offset: 0x3528
// Size: 0xe0
function function_34f43e67() {
    var_cf459596 = struct::get_array("mg_fire_urn", "targetname");
    foreach (var_b3e46caf in var_cf459596) {
        var_b3e46caf.var_e0134271 clientfield::set("magma_urn_fire_fx", 1);
        var_b3e46caf.var_e0134271 clientfield::set("magma_urn_ember_fx", 0);
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x9de37d19, Offset: 0x3610
// Size: 0xa4
function function_50341e45() {
    var_f8b78f96 = struct::get("mg_forg_pos");
    var_f8b78f96 = struct::get(var_f8b78f96.target);
    var_f8b78f96.s_unitrigger_stub = var_f8b78f96 zm_unitrigger::create(&function_cd8cae55, 80, &function_9b67fc0b, 1);
    zm_unitrigger::unitrigger_force_per_player_triggers(var_f8b78f96.s_unitrigger_stub);
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0xf1e17ab9, Offset: 0x36c0
// Size: 0x3b2
function function_cd8cae55(player) {
    if (isdefined(zm_audio::function_8ff5b3a1(player.currentweapon))) {
        return 0;
    }
    if (player hasweapon(getweapon(#"ww_blundergat_fire_t8_unfinished")) && !isdefined(self.stub.var_e7ccbbfe)) {
        self sethintstring(#"hash_6aefb24885426431");
        return 1;
    }
    if ((player hasweapon(getweapon(#"ww_blundergat_t8")) || player hasweapon(getweapon(#"ww_blundergat_t8_upgraded")) || player hasweapon(getweapon(#"ww_blundergat_acid_t8")) || player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded"))) && level flag::get(#"magma_forge_completed") && !isdefined(self.stub.var_e7ccbbfe)) {
        if (player hasweapon(getweapon(#"ww_blundergat_t8"))) {
            self sethintstring(#"hash_6aefb24885426431");
        } else if (player hasweapon(getweapon(#"ww_blundergat_t8_upgraded"))) {
            self sethintstring(#"hash_7755302d416e3168");
        } else if (player hasweapon(getweapon(#"ww_blundergat_acid_t8"))) {
            self sethintstring(#"hash_1875e6c5a3e5e96c");
        } else if (player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded"))) {
            self sethintstring(#"hash_ecb311bfa753664");
        }
        return 1;
    }
    if (isdefined(self.stub.var_62828ca1) && self.stub.var_62828ca1 && isdefined(player.var_ce1f9aca) && player.var_ce1f9aca) {
        self sethintstring(#"hash_14afad0ad7a156a5");
        return 1;
    }
    return 0;
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x437d79c4, Offset: 0x3a80
// Size: 0x618
function function_9b67fc0b() {
    v_weapon_origin_offset = (0, 0, 9);
    v_weapon_angles_offset = (0, -90, 0);
    self.v_weapon_origin = level.var_42be3d8c.origin + anglestoforward(level.var_42be3d8c.angles) * 15 + v_weapon_origin_offset;
    self.v_weapon_angles = level.var_42be3d8c.angles + v_weapon_angles_offset;
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        var_9b962656 = undefined;
        if (!level flag::get(#"magma_forge_completed")) {
            if (e_player hasweapon(getweapon(#"ww_blundergat_fire_t8_unfinished"))) {
                var_9b962656 = #"ww_blundergat_fire_t8_unfinished";
            }
        } else if (e_player hasweapon(getweapon(#"ww_blundergat_t8"))) {
            var_9b962656 = #"ww_blundergat_t8";
        } else if (e_player hasweapon(getweapon(#"ww_blundergat_t8_upgraded"))) {
            var_9b962656 = #"ww_blundergat_t8_upgraded";
        } else if (e_player hasweapon(getweapon(#"ww_blundergat_acid_t8"))) {
            var_9b962656 = #"ww_blundergat_acid_t8";
        } else if (e_player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded"))) {
            var_9b962656 = #"ww_blundergat_acid_t8_upgraded";
        }
        if (isdefined(var_9b962656)) {
            self.stub.var_e7ccbbfe = 1;
            if (var_9b962656 == #"ww_blundergat_fire_t8_unfinished") {
                e_player clientfield::set_to_player("magma_gat_glow_override", 0);
            }
            e_player takeweapon(getweapon(var_9b962656));
            e_player.var_ce1f9aca = 1;
            e_player.var_fdf5920e = undefined;
            e_player notify(#"hash_3c807aeefe7734fa");
            e_player notify(#"hash_5dc448a84a24492");
            level.var_42be3d8c thread clientfield::set("magma_fireplace_fx", 2);
            self.var_f19b316b = zm_utility::spawn_weapon_model(getweapon(var_9b962656), undefined, self.v_weapon_origin, self.v_weapon_angles);
            var_ca93cbf6 = struct::get("s_ni_mach");
            var_ca93cbf6 thread scene::play();
            function_34f43e67();
            wait 5;
            if (isdefined(e_player)) {
                self.stub.var_62828ca1 = 1;
                is_upgraded = self function_733692ca(e_player.var_c7229167);
                level.var_42be3d8c thread clientfield::set("magma_fireplace_fx", 3);
                self thread function_6e8cfb7c(e_player, is_upgraded);
                self thread wait_for_timeout(e_player);
                self thread function_7a069817(e_player);
                s_result = self waittill(#"magma_timeout", #"magma_taken");
                self.stub.var_62828ca1 = undefined;
                if (isdefined(e_player)) {
                    e_player.var_ce1f9aca = undefined;
                    e_player.var_c7229167 = undefined;
                }
                level.var_42be3d8c thread clientfield::set("magma_fireplace_fx", 2);
                if (s_result._notify == "magma_timeout") {
                    self thread magma_gat_disappear_fx();
                    playsoundatposition(#"hash_1d6afdd3f475507e", (0, 0, 0));
                } else if (s_result._notify == "magma_taken") {
                    if (!level flag::get(#"magma_forge_completed")) {
                        zombie_brutus_util::attempt_brutus_spawn(1, "zone_new_industries");
                    }
                    level flag::set(#"magma_forge_completed");
                }
            }
            self.stub.var_e7ccbbfe = undefined;
            self.var_f19b316b delete();
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0xd71ef337, Offset: 0x40a0
// Size: 0x1d4
function function_440bf8d0(a_ents) {
    var_9b272de2 = a_ents[#"fakeactor 1"];
    var_7524b379 = a_ents[#"fakeactor 2"];
    var_9b272de2 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    var_7524b379 clientfield::set("" + #"hash_34562274d7e875a4", 1);
    var_7524b379 waittill(#"start_alpha");
    var_7524b379 clientfield::set("" + #"hash_7692067c56d8b6cc", 1);
    var_9b272de2 waittill(#"start_alpha");
    var_9b272de2 clientfield::set("" + #"hash_7692067c56d8b6cc", 1);
    var_9b272de2 waittill(#"end_alpha");
    var_9b272de2 clientfield::set("" + #"hash_7692067c56d8b6cc", 0);
    var_7524b379 clientfield::set("" + #"hash_7692067c56d8b6cc", 0);
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x4
// Checksum 0x41496a50, Offset: 0x4280
// Size: 0x150
function private function_733692ca(var_ba1489dd) {
    self.var_f19b316b delete();
    if (!isdefined(var_ba1489dd)) {
        self.var_f19b316b = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_fire_t8"), undefined, self.v_weapon_origin, self.v_weapon_angles);
        return 0;
    }
    if (var_ba1489dd == #"ww_blundergat_t8" || var_ba1489dd == #"ww_blundergat_acid_t8") {
        self.var_f19b316b = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_fire_t8"), undefined, self.v_weapon_origin, self.v_weapon_angles);
        return 0;
    }
    self.var_f19b316b = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_fire_t8_upgraded"), undefined, self.v_weapon_origin, self.v_weapon_angles);
    return 1;
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 2, eflags: 0x4
// Checksum 0x5fdaa553, Offset: 0x43d8
// Size: 0x276
function private function_6e8cfb7c(e_player, is_upgraded) {
    self endon(#"magma_timeout");
    e_player endon(#"disconnect");
    while (true) {
        s_result = self waittill(#"trigger");
        if (s_result.activator == e_player) {
            if (zm_utility::can_use(e_player, 1) && e_player.currentweapon.name != "none") {
                self notify(#"magma_taken");
                e_player notify(#"magma_taken");
                var_dd27188c = zm_utility::get_player_weapon_limit(e_player);
                a_primaries = e_player getweaponslistprimaries();
                if (isdefined(a_primaries) && a_primaries.size >= var_dd27188c) {
                    e_player takeweapon(e_player.currentweapon);
                }
                if (isdefined(is_upgraded) && is_upgraded) {
                    e_player giveweapon(getweapon(#"ww_blundergat_fire_t8_upgraded"));
                    e_player switchtoweapon(getweapon(#"ww_blundergat_fire_t8_upgraded"));
                } else {
                    e_player giveweapon(getweapon(#"ww_blundergat_fire_t8"));
                    e_player switchtoweapon(getweapon(#"ww_blundergat_fire_t8"));
                }
                e_player thread zm_audio::create_and_play_dialog("weapon_pickup", "magmagat");
                e_player notify(#"hash_6e0a27b37f225a25");
                return;
            }
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x9c02e699, Offset: 0x4658
// Size: 0x66
function function_7a069817(e_player) {
    self endon(#"magma_taken", #"magma_timeout");
    e_player waittill(#"death", #"disconnect");
    self notify(#"magma_timeout");
}

/#

    // Namespace namespace_3f0e5106/namespace_4b9249a2
    // Params 0, eflags: 0x0
    // Checksum 0xc241df4, Offset: 0x46c8
    // Size: 0x5c
    function function_fbff3e7c() {
        zm_devgui::add_custom_devgui_callback(&function_54d7ccc3);
        adddebugcommand("<dev string:x7d>");
        adddebugcommand("<dev string:xec>");
    }

    // Namespace namespace_3f0e5106/namespace_4b9249a2
    // Params 1, eflags: 0x0
    // Checksum 0x454cf3c6, Offset: 0x4730
    // Size: 0x132
    function function_54d7ccc3(cmd) {
        switch (cmd) {
        case #"hash_2406dff55d52785a":
            foreach (mdl_skull in level.var_6a55b564) {
                mdl_skull setmodel("<dev string:x15b>");
                mdl_skull clientfield::set("<dev string:x175>", 1);
            }
            level flag::set(#"hash_3fb7d58b07b04333");
            break;
        case #"hash_384ee6deba35ca28":
            level flag::set(#"magma_forge_completed");
            break;
        }
    }

#/

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x2599eab9, Offset: 0x4870
// Size: 0x34c
function function_18ca0d89() {
    var_6e971eca = struct::get_array("key_door_trigger", "targetname");
    foreach (var_21c0c14b in var_6e971eca) {
        var_21c0c14b.a_e_doors = [];
        a_e_parts = getentarray(var_21c0c14b.target, "targetname");
        foreach (e_part in a_e_parts) {
            if (e_part.script_noteworthy === "door") {
                if (!isdefined(var_21c0c14b.a_e_doors)) {
                    var_21c0c14b.a_e_doors = [];
                } else if (!isarray(var_21c0c14b.a_e_doors)) {
                    var_21c0c14b.a_e_doors = array(var_21c0c14b.a_e_doors);
                }
                if (!isinarray(var_21c0c14b.a_e_doors, e_part)) {
                    var_21c0c14b.a_e_doors[var_21c0c14b.a_e_doors.size] = e_part;
                }
                continue;
            }
            if (e_part.script_noteworthy === "clip") {
                var_21c0c14b.e_clip = e_part;
                continue;
            }
            if (e_part.script_noteworthy === "lock") {
                var_21c0c14b.e_lock = e_part;
                continue;
            }
            if (e_part.script_noteworthy === "item_part") {
                var_21c0c14b.e_item = e_part;
            }
        }
    }
    zm_items::function_187a472b(getweapon(#"zitem_acid_gat_part_1"), &function_ef228c44);
    zm_items::function_187a472b(getweapon(#"zitem_acid_gat_part_2"), &function_ef228c44);
    zm_items::function_187a472b(getweapon(#"zitem_acid_gat_part_3"), &function_ef228c44);
    array::thread_all(var_6e971eca, &function_24bf300f);
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 2, eflags: 0x0
// Checksum 0x52c0333c, Offset: 0x4bc8
// Size: 0x34
function function_ef228c44(e_holder, w_item) {
    self playsound(#"hash_230737b2535a3374");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0xa6cddc81, Offset: 0x4c08
// Size: 0x3d2
function function_24bf300f() {
    t_door = spawn("trigger_radius_use", self.origin, 0, 64, 64);
    t_door setcursorhint("HINT_NOICON");
    t_door triggerignoreteam();
    t_door setvisibletoall();
    t_door thread function_e5d7170e();
    while (true) {
        s_result = t_door waittill(#"trigger");
        e_player = s_result.activator;
        if (level flag::get(#"hash_7039457b1cc827de")) {
            t_door delete();
            self.e_lock delete();
            foreach (e_door in self.a_e_doors) {
                if (isdefined(e_door.script_vector)) {
                    e_door rotateto(e_door.script_vector, 1);
                    continue;
                }
                e_door movez(10000, 1);
            }
            if (isdefined(self.e_item) && isdefined(self.e_item.script_int)) {
                if (self.e_item.script_int == 1) {
                    self.e_item ghost();
                    var_64f9e392 = zm_crafting::get_component(#"zitem_acid_gat_part_1");
                    zm_items::spawn_item(var_64f9e392, self.e_item.origin, self.e_item.angles);
                    self.e_item delete();
                }
                if (self.e_item.script_int == 2) {
                    self.e_item ghost();
                    var_64f9e392 = zm_crafting::get_component(#"zitem_acid_gat_part_2");
                    zm_items::spawn_item(var_64f9e392, self.e_item.origin, self.e_item.angles);
                    self.e_item delete();
                }
            }
            if (isdefined(self.e_clip)) {
                self.e_clip notsolid();
                self.e_clip connectpaths();
                wait 0.5;
                if (isdefined(self.e_clip)) {
                    self.e_clip delete();
                }
            }
            return;
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x4
// Checksum 0xdd220e00, Offset: 0x4fe8
// Size: 0x7c
function private function_e5d7170e() {
    self endon(#"death");
    self sethintstring(#"hash_2f5a14e8bf175422");
    level flag::wait_till(#"hash_7039457b1cc827de");
    self sethintstring(#"hash_6ca88a5a4b9466d8");
}

