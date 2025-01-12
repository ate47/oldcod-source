#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_escape_travel;
#using scripts\zm_common\util\ai_dog_util;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_escape_util;

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x2
// Checksum 0x427c6eeb, Offset: 0x368
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_escape_util", &__init__, &__main__, undefined);
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0xe502bf4, Offset: 0x3b8
// Size: 0x54
function __init__() {
    level flag::init(#"hash_7039457b1cc827de");
    level.lighting_state = 0;
    callback::on_connect(&function_31674841);
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0xfeeb1093, Offset: 0x418
// Size: 0x64
function __main__() {
    level thread function_9228d3ff();
    level thread catwalk_arm_scene_init();
    level.gravityspike_position_check = &function_f8e134fe;
    level thread function_36472ca7();
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0xb37682c8, Offset: 0x488
// Size: 0xc4
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_7327d0447d656234", 1, 1, "int");
    clientfield::register("item", "" + #"hash_76662556681a502c", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_59be891b288663cc", 1, 1, "int");
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x0
// Checksum 0x92af85d7, Offset: 0x558
// Size: 0x246
function function_6b6f3b8e(str_script_noteworthy) {
    var_f5d10d24 = 0;
    switch (level.activeplayers.size) {
    case 1:
        n_multiplier = 3;
        break;
    case 2:
        n_multiplier = 2;
        break;
    case 3:
        n_multiplier = 1;
        break;
    default:
        n_multiplier = 1;
        break;
    }
    var_26b40da1 = zm_round_logic::get_zombie_count_for_round(level.round_number, level.activeplayers.size) - level.round_number * n_multiplier;
    level.var_dab4f794 = var_26b40da1;
    if (var_26b40da1 < 0) {
        var_26b40da1 = 0;
    } else {
        switch (level.activeplayers.size) {
        case 1:
            if (var_26b40da1 > 36) {
                var_26b40da1 = 36;
            }
            break;
        case 2:
            if (var_26b40da1 > 37) {
                var_26b40da1 = 37;
            }
            break;
        case 3:
            if (var_26b40da1 > 38) {
                var_26b40da1 = 38;
            }
            break;
        case 4:
            if (var_26b40da1 > 39) {
                var_26b40da1 = 39;
            }
            break;
        }
    }
    var_d7a579ca = zombie_utility::get_current_zombie_count();
    if (var_d7a579ca > var_26b40da1) {
        var_f5d10d24 = 1;
    }
    return var_f5d10d24;
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x4a3d6813, Offset: 0x7a8
// Size: 0x38
function function_f16e2a8f() {
    var_3c933eba = zombie_utility::get_current_zombie_count();
    if (var_3c933eba >= level.zombie_ai_limit) {
        return true;
    }
    return false;
}

// Namespace zm_escape_util/zm_escape_util
// Params 2, eflags: 0x0
// Checksum 0x98d41eb1, Offset: 0x7e8
// Size: 0xce
function function_1332d61(str_script_noteworthy, var_272fece5 = 0) {
    self endon(#"death");
    if (isdefined(str_script_noteworthy)) {
        self.script_noteworthy = str_script_noteworthy;
    }
    self.var_7402a17a = 1;
    self.ignore_enemy_count = 1;
    self.exclude_cleanup_adding_to_total = 1;
    self zombie_utility::set_zombie_run_cycle("sprint");
    if (!var_272fece5) {
        self zm_score::function_96865aad();
    }
    self waittill(#"completed_emerging_into_playable_area");
    self.no_powerups = 1;
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x0
// Checksum 0x7757b8f6, Offset: 0x8c0
// Size: 0x336
function function_389bc4e7(s_loc) {
    self endon(#"death");
    self.ignore_find_flesh = 1;
    self.b_ignore_cleanup = 1;
    self.ignore_enemy_count = 1;
    self.exclude_cleanup_adding_to_total = 1;
    self val::set(#"dog_spawn", "ignoreall", 1);
    self val::set(#"dog_spawn", "ignoreme", 1);
    self util::magic_bullet_shield();
    self setfreecameralockonallowed(0);
    self forceteleport(s_loc.origin, s_loc.angles);
    self ghost();
    playsoundatposition(#"zmb_hellhound_prespawn", s_loc.origin);
    wait 1.5;
    self clientfield::increment("dog_spawn_fx");
    playsoundatposition(#"zmb_hellhound_bolt", s_loc.origin);
    earthquake(0.5, 0.75, s_loc.origin, 1000);
    playsoundatposition(#"zmb_hellhound_spawn", s_loc.origin);
    assert(isdefined(self), "<dev string:x30>");
    assert(isalive(self), "<dev string:x49>");
    assert(zm_utility::is_magic_bullet_shield_enabled(self), "<dev string:x5c>");
    self zombie_dog_util::zombie_setup_attack_properties_dog();
    self util::stop_magic_bullet_shield();
    wait 0.1;
    self show();
    self setfreecameralockonallowed(1);
    self val::reset(#"dog_spawn", "ignoreme");
    self val::reset(#"dog_spawn", "ignoreall");
    self notify(#"visible");
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x350132b9, Offset: 0xc00
// Size: 0xbc
function catwalk_arm_scene_init() {
    scene::add_scene_func(#"aib_vign_tplt_zm_arm_grasp_01", &function_e13b1be8, "init");
    scene::add_scene_func(#"hash_356b988baded60ad", &function_e13b1be8, "init");
    var_123562a0 = struct::get_array("catwalk_arm_scene", "targetname");
    array::thread_all(var_123562a0, &function_ca2076f6);
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x0
// Checksum 0xde974705, Offset: 0xcc8
// Size: 0x1fc
function function_e13b1be8(a_ents) {
    a_ents[#"arm_grasp"] setcandamage(1);
    a_ents[#"arm_grasp"].health = 10000;
    var_8323e74c = getent(self.target, "targetname");
    a_ents[#"arm_grasp"].var_71fb33f7 = 1;
    var_8323e74c thread function_550da715(a_ents[#"arm_grasp"]);
    while (true) {
        s_result = a_ents[#"arm_grasp"] waittill(#"damage");
        if (isplayer(s_result.attacker) && isalive(s_result.attacker)) {
            s_result.attacker zm_score::add_to_player_score(10);
        }
        self thread scene::play("Shot 1");
        a_ents[#"arm_grasp"].var_71fb33f7 = 0;
        var_8323e74c notify(#"hash_4a3551167bd870c2");
        break;
    }
    level waittill(#"between_round_over");
    self.t_arm setvisibletoall();
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x0
// Checksum 0x39c4a473, Offset: 0xed0
// Size: 0xc8
function function_550da715(var_20ce1ae4) {
    self endon(#"death", #"hash_4a3551167bd870c2");
    while (true) {
        waitresult = self waittill(#"trigger");
        if (isplayer(waitresult.activator) && var_20ce1ae4.var_71fb33f7) {
            waitresult.activator dodamage(10, waitresult.activator.origin);
            wait 4;
        }
        wait 0.1;
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x1b197cb2, Offset: 0xfa0
// Size: 0xb0
function function_ca2076f6() {
    self.t_arm = spawn("trigger_radius_new", self.origin, 0, 256, 96);
    while (true) {
        s_result = self.t_arm waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            self thread scene::init();
            self.t_arm setinvisibletoall();
        }
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x6d2fad32, Offset: 0x1058
// Size: 0x184
function function_9228d3ff() {
    level endon(#"hash_7039457b1cc827de");
    while (!level flag::get(#"hash_7039457b1cc827de")) {
        var_261e5cf5 = zm_crafting::function_f941c8e0();
        foreach (s_blueprint in var_261e5cf5) {
            if (s_blueprint.var_29ca87bc == getweapon(#"zhield_spectral_dw")) {
                level flag::set(#"hash_7039457b1cc827de");
                break;
            }
        }
        if (zm_items::player_has(level.players[0], zm_crafting::get_component(#"zitem_spectral_shield_part_3"))) {
            level flag::set(#"hash_7039457b1cc827de");
            break;
        }
        wait 1;
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0xc38e9170, Offset: 0x11e8
// Size: 0xe0
function function_316c3cb7() {
    a_mdl_parts = getitemarray();
    foreach (mdl_part in a_mdl_parts) {
        if (mdl_part.item == getweapon(#"zitem_spectral_shield_part_2")) {
            mdl_part clientfield::set("" + #"hash_76662556681a502c", 1);
        }
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x32cf8f21, Offset: 0x12d0
// Size: 0x2e0
function function_31674841() {
    self callback::function_c4f1b25e(&function_c54ef4d0);
    self endon(#"disconnect");
    a_bad_zones = [];
    a_bad_zones[0] = "zone_model_industries";
    a_bad_zones[1] = "zone_studio";
    a_bad_zones[2] = "zone_citadel_stairs";
    a_bad_zones[3] = "cellblock_shower";
    a_bad_zones[4] = "zone_citadel";
    a_bad_zones[5] = "zone_infirmary";
    a_bad_zones[6] = "zone_infirmary_roof";
    a_bad_zones[7] = "zone_citadel_shower";
    level flag::wait_till("start_zombie_round_logic");
    var_3cbff7af = 0;
    while (true) {
        wait randomfloatrange(1, 11);
        if (isdefined(self function_de56aa91(a_bad_zones)) && self function_de56aa91(a_bad_zones)) {
            self.var_a6f33720 = 1;
            self util::set_lighting_state(math::clamp(level.lighting_state + 1, 1, 3));
            exploder::exploder("bx_lightning_setup");
        }
        var_8a70fb09 = randomintrange(1, 6);
        if (var_8a70fb09 === var_3cbff7af) {
            var_8a70fb09 = math::clamp(var_8a70fb09 + 1, 1, 6);
        }
        var_3cbff7af = var_8a70fb09;
        exploder::exploder("fxexp_script_lightning_0" + var_8a70fb09);
        wait randomfloatrange(0.2, 1.2);
        if (isdefined(self.var_a6f33720) && self.var_a6f33720) {
            self util::set_lighting_state(level.lighting_state);
            self.var_a6f33720 = undefined;
            exploder::stop_exploder("bx_lightning_setup");
        }
        exploder::stop_exploder("fxexp_script_lightning_0" + var_8a70fb09);
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x0
// Checksum 0xe1bd5fd1, Offset: 0x15b8
// Size: 0x4e
function function_de56aa91(a_bad_zones) {
    str_zone = self zm_zonemgr::get_player_zone();
    if (isinarray(a_bad_zones, str_zone)) {
        return false;
    }
    return true;
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x84b3b672, Offset: 0x1610
// Size: 0xb0
function function_3f8f3d1a() {
    var_171e3a1b = getentarray("afterlife_shock_box", "targetname");
    foreach (var_ccf99daf in var_171e3a1b) {
        var_ccf99daf.var_4711b1db = 1;
        var_ccf99daf thread function_57fd0c2c();
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x5fdbc1ab, Offset: 0x16c8
// Size: 0x4c
function function_14bbb55e() {
    self setmodel(#"hash_233df8109c680010");
    self thread scene::play("p8_fxanim_zm_esc_shockbox_bundle", "Activated", self);
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x874abdc4, Offset: 0x1720
// Size: 0x4c
function function_6aa38de4() {
    self setmodel(#"p8_fxanim_zm_esc_shockbox_mod");
    self thread scene::play("p8_fxanim_zm_esc_shockbox_bundle", "Desactivated", self);
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0xfe0884b7, Offset: 0x1778
// Size: 0x13a
function function_57fd0c2c() {
    self endon(#"hash_7f8e7011812dff48");
    while (isdefined(self.var_4711b1db) && self.var_4711b1db) {
        s_info = self waittill(#"blast_attack");
        if (self.script_string == "crane_shock_box") {
            level.var_bdf1d58d = s_info.e_player;
        }
        if (isdefined(self.var_ecdefca6) && self.var_ecdefca6) {
            continue;
        }
        self function_14bbb55e();
        self notify(#"hash_7e1d78666f0be68b");
        if (isdefined(self.var_800b9303) && self.var_800b9303) {
            self waittilltimeout(10, #"turn_off");
        } else {
            self waittill(#"turn_off");
        }
        self function_6aa38de4();
        self notify(#"hash_57de930eb121052f");
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 2, eflags: 0x0
// Checksum 0xb1d94f3a, Offset: 0x18c0
// Size: 0x19e
function function_35e99b28(ent_name, message) {
    ents = getentarray(ent_name, "targetname");
    foreach (ent in ents) {
        ent setmodel(ent.model_off);
        ent thread scene::play(ent.bundle, "OFF", ent);
        waitframe(1);
    }
    level flag::wait_till(message);
    foreach (ent in ents) {
        ent setmodel(ent.model_on);
        ent thread scene::play(ent.bundle, "ON", ent);
        waitframe(1);
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x0
// Checksum 0xbd304d70, Offset: 0x1a68
// Size: 0x106
function function_f2668b19(e_player) {
    if ((level flag::get("gondola_doors_moving") || level flag::get("gondola_in_motion")) && e_player zm_escape_travel::function_250c012e() && !self zm_escape_travel::function_250c012e()) {
        return 0;
    }
    if ((level flag::get("gondola_doors_moving") || level flag::get("gondola_in_motion")) && !e_player zm_escape_travel::function_250c012e() && self zm_escape_travel::function_250c012e()) {
        return 0;
    }
    return 1;
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0xc6da8135, Offset: 0x1b78
// Size: 0x272
function function_8160799a() {
    switch (level.dog_round_count) {
    case 2:
        level.next_dog_round = level.round_number + randomintrangeinclusive(5, 7);
        zm_round_spawning::function_c9b9ab96("zombie_dog", level.next_dog_round + 1);
        break;
    case 3:
        level.next_dog_round = level.round_number + randomintrangeinclusive(6, 8);
        break;
    case 4:
        level.next_dog_round = level.round_number + randomintrangeinclusive(7, 9);
        break;
    default:
        level.next_dog_round = level.round_number + randomintrangeinclusive(8, 10);
        break;
    }
    foreach (e_player in level.activeplayers) {
        if (e_player flag::exists(#"hash_120fbb364796cd32") && e_player flag::exists(#"hash_11ab20934759ebc3") && e_player flag::get(#"hash_120fbb364796cd32") && !e_player flag::get(#"hash_11ab20934759ebc3")) {
            level.next_dog_round = level.round_number + randomintrangeinclusive(5, 7);
        }
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0xb899310b, Offset: 0x1df8
// Size: 0x22
function function_4c99572a() {
    if (isdefined(self.var_56c7266a) && self.var_56c7266a) {
        return 0;
    }
    return undefined;
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0x41ef97f5, Offset: 0x1e28
// Size: 0x12c
function make_wobble() {
    waittime = randomfloatrange(2.5, 5);
    yaw = randomint(360);
    if (yaw > 300) {
        yaw = 300;
    } else if (yaw < 60) {
        yaw = 60;
    }
    yaw = self.angles[1] + yaw;
    new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
    self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    wait randomfloat(waittime - 0.1);
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x4
// Checksum 0x46a496d, Offset: 0x1f60
// Size: 0x60
function private function_f8e134fe() {
    if (isdefined(level.e_gondola) && isdefined(level.e_gondola.t_ride) && self istouching(level.e_gondola.t_ride)) {
        return false;
    }
    return true;
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x0
// Checksum 0xf2c010e1, Offset: 0x1fc8
// Size: 0x1b0
function function_ef3caaa9() {
    foreach (e_player in level.players) {
        if (e_player inlaststand()) {
            e_player reviveplayer();
            e_player notify(#"stop_revive_trigger");
            if (isdefined(e_player.revivetrigger)) {
                e_player.revivetrigger delete();
                e_player.revivetrigger = undefined;
            }
            e_player allowjump(1);
            e_player val::reset(#"laststand", "ignoreme");
            e_player.laststand = undefined;
            e_player clientfield::set("zmbLastStand", 0);
            e_player notify(#"player_revived", {#reviver:self});
            continue;
        }
        if (e_player util::is_spectating()) {
            e_player thread zm_player::spectator_respawn_player();
        }
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x0
// Checksum 0xba65b240, Offset: 0x2180
// Size: 0xbc
function function_ddd7ade1(var_1746b856) {
    var_1746b856.var_76b55fb2 = 1;
    var_1746b856 clientfield::set("brutus_spawn_clientfield", 0);
    waitframe(1);
    var_587f6bf = struct::get("s_teleport_br_kill");
    var_1746b856 forceteleport(var_587f6bf.origin);
    wait 0.1;
    if (isalive(var_1746b856)) {
        var_1746b856 kill();
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 1, eflags: 0x4
// Checksum 0x5c14f4da, Offset: 0x2248
// Size: 0xf4
function private function_c54ef4d0(s_event) {
    if (s_event.weapon === getweapon(#"golden_knife")) {
        level.var_f11e78d5[s_event.weapon] = 0.1;
        self thread aat::acquire(s_event.weapon);
        return;
    }
    if (s_event.weapon === getweapon(#"spknifeork")) {
        level.var_f11e78d5[s_event.weapon] = 0.2;
        self thread aat::acquire(s_event.weapon);
    }
}

// Namespace zm_escape_util/zm_escape_util
// Params 0, eflags: 0x4
// Checksum 0xb9c4ecb5, Offset: 0x2348
// Size: 0x158
function private function_36472ca7() {
    while (true) {
        s_result = level waittill(#"brutus_locked", #"unlock_purchased");
        if (s_result.s_stub.targetname !== "crafting_trigger") {
            continue;
        }
        if (s_result._notify == #"brutus_locked") {
            var_ef4ec808 = util::spawn_model("tag_origin", s_result.s_stub.origin, s_result.s_stub.angles);
            var_ef4ec808 clientfield::set("" + #"hash_59be891b288663cc", 1);
            continue;
        }
        if (isdefined(var_ef4ec808)) {
            var_ef4ec808 clientfield::set("" + #"hash_59be891b288663cc", 0);
            var_ef4ec808 delete();
        }
    }
}

