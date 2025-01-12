#using script_2c5daa95f8fec03c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_blight_father;
#using scripts\core_common\ai\archetype_blight_father_interface;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\trials\zm_trial_force_archetypes;
#using scripts\zm_common\trials\zm_trial_special_enemy;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_grappler;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_lockdown_util;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_blight_father;

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x2
// Checksum 0xbffba35b, Offset: 0xb10
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_blight_father", &__init__, undefined, undefined);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xde67a52b, Offset: 0xb58
// Size: 0x8a2
function __init__() {
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function("blight_father", &function_c72f4d3a);
    spawner::function_c2d00d5a("blight_father", &function_bb4e9700);
    zm_utility::function_81bbcc91("blight_father");
    callback::on_spawned(&on_player_spawned);
    function_b2e22718();
    clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int");
    clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int");
    clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int");
    clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int");
    clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int");
    clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int");
    clientfield::register("scriptmover", "blight_father_purchase_lockdown_vomit_fx", 1, 3, "int");
    clientfield::register("toplayer", "tongueGrabPostFx", 1, 1, "int");
    clientfield::register("toplayer", "tongueGrabRumble", 1, 1, "int");
    clientfield::register("actor", "blight_father_vomit_fx", 1, 2, "int");
    clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter");
    clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter");
    clientfield::register("actor", "mtl_blight_father_clientfield", 1, 1, "int");
    clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int");
    clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int");
    clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter");
    clientfield::register("toplayer", "blight_father_vomit_postfx_clientfield", 1, 1, "int");
    clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int");
    level thread aat::register_immunity("zm_aat_brain_decay", "blight_father", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_frostbite", "blight_father", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_kill_o_watt", "blight_father", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", "blight_father", 1, 1, 1);
    blight_father_spawner = getent("zombie_spawner_blight_father", "targetname");
    zm_transform::function_17652056(blight_father_spawner, "blight_father", &function_652d2382, 5, &function_e2733ab6, &function_7da5b515, "aib_vign_zm_zod_bltfthr_spawn_pre_split", "aib_vign_zm_zod_bltfthr_spawn_post_split");
    zm_spawner::register_zombie_death_event_callback(&killed_callback);
    callback::on_ai_killed(&function_791c3379);
    zm_round_spawning::register_archetype("blight_father", &function_55404471, &round_spawn, undefined, 300);
    zm_round_spawning::function_1a28bc99("blight_father", &function_938eb359);
    if (true) {
        level.var_22fdd3f8 = [];
        for (i = 0; i < 12; i++) {
            trigger = spawn("trigger_damage", (0, 0, 0), 0, 40, 40);
            trigger enablelinkto();
            trigger.inuse = 0;
            trigger triggerenable(0);
            if (!isdefined(level.var_22fdd3f8)) {
                level.var_22fdd3f8 = [];
            } else if (!isarray(level.var_22fdd3f8)) {
                level.var_22fdd3f8 = array(level.var_22fdd3f8);
            }
            level.var_22fdd3f8[level.var_22fdd3f8.size] = trigger;
        }
    }
    level.var_73451561 = [#"tag_mouth_weakspot":&function_f64d7f9c, #"tag_elbow_weakspot_le":&function_eaea407d, #"tag_elbow_weakspot_ri":&function_91052e18, #"tag_eggsack_weakspot_le":&function_d17bf4dc, #"tag_eggsack_weakspot_ri":&function_e8add48b];
    zm_ai_utility::function_dd6daffa("blight_father", &function_29d2ef52);
    zm_trial_special_enemy::function_6e25f633(#"blight_father", &function_19175da1);
    zm_utility::register_slowdown(#"hash_2fd5f5f16583a427", 0.8);
    /#
        spawner::add_archetype_spawn_function("<dev string:x30>", &zombie_utility::updateanimationrate);
        level thread function_17c8b975();
    #/
    level.var_2dbd0c0b = 0;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 4, eflags: 0x4
// Checksum 0xef225d12, Offset: 0x1408
// Size: 0x7c
function private function_723e62dd(entity, attribute, oldvalue, value) {
    if (value == "low") {
        entity thread zm_utility::function_447d3917(#"hash_2fd5f5f16583a427");
        return;
    }
    entity thread zm_utility::function_95398de5(#"hash_2fd5f5f16583a427");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0xffc40f3c, Offset: 0x1490
// Size: 0x12
function private on_player_spawned() {
    self.grapple_tag = "j_mainroot";
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x14b0
// Size: 0x4
function private function_b2e22718() {
    
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x49558eea, Offset: 0x14c0
// Size: 0x678
function private function_c72f4d3a() {
    self endon(#"death");
    self.zombie_move_speed = "sprint";
    self zombie_utility::function_9c628842(0);
    if (!(isdefined(level.var_595dcfa9) && level.var_595dcfa9) && !zm_trial_special_enemy::is_active() && !zm_trial_force_archetypes::function_64eeba9b("blight_father") && !(isdefined(level.var_7cbb06a0) && level.var_7cbb06a0)) {
        self.ignore_enemy_count = 1;
    }
    self.var_d3c40f30 = 1;
    self.var_2e8cef76 = 1;
    self.ignore_nuke = 1;
    self.lightning_chain_immune = 1;
    self.instakill_func = &zm_powerups::function_ef67590f;
    self.var_101fcd59 = 1;
    if (isdefined(level.var_8a959e57)) {
        self.var_aaea343e = level.var_8a959e57;
    } else {
        self.var_aaea343e = &function_c626b86e;
    }
    self.var_693891b8 = self ai::function_a0dbf10a().var_20d6cc90;
    self attach("c_t8_zmb_blightfather_mouth");
    self attach("c_t8_zmb_blightfather_elbow1_le");
    self attach("c_t8_zmb_blightfather_elbow1_ri");
    self attach("c_t8_zmb_blightfather_eggsack1_both");
    self attach("c_t8_zmb_blightfather_tongue2");
    self hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
    aiutility::addaioverridedamagecallback(self, &function_a505a12);
    aiutility::addaioverridedamagecallback(self, &function_84c9039b);
    self.var_849f9ffb = gettime() + self ai::function_a0dbf10a().var_526d4755;
    self.var_da135442 = 1;
    self.grapple_tag = "tag_jaw";
    self.var_fc14d6a = {#traces:[], #timestamp:gettime()};
    self.var_d066e895 = gettime() + self ai::function_a0dbf10a().var_82910acd;
    self.var_92445916 = &function_38a8375e;
    self.var_83103966 = &function_723e62dd;
    self.var_3201a22f = &function_59a21e2c;
    self.closest_player_override = &zm_utility::function_87d568c4;
    self.var_77966006 = &function_7d6fec24;
    self.var_b578ce15 = &function_b578ce15;
    self.cant_move_cb = &zombiebehavior::function_6137e5da;
    self.should_zigzag = 0;
    self.var_f197caf2 = 5;
    self.completed_emerging_into_playable_area = 1;
    self.ignorepathenemyfightdist = 1;
    self.var_5ab1a87d = &function_606621fb;
    self.var_c2129537 = &function_ce67287d;
    self.var_c5a4812d = gettime();
    if (!isdefined(self.var_e01f007d)) {
        self.var_e01f007d = [];
    }
    if (!isdefined(self.var_e01f007d)) {
        self.var_e01f007d = [];
    } else if (!isarray(self.var_e01f007d)) {
        self.var_e01f007d = array(self.var_e01f007d);
    }
    self.var_e01f007d[self.var_e01f007d.size] = &function_67a13dca;
    self allowpitchangle(1);
    self setpitchorient();
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_utility::update_zone_name();
    self thread zm_audio::play_ambient_zombie_vocals();
    self collidewithactors(1);
    self.deathfunction = &zm_spawner::zombie_death_animscript;
    if (!isdefined(level.var_a2452e1c)) {
        level.var_a2452e1c = getweapon("zombie_ai_defaultmelee");
    }
    util::wait_network_frame();
    self clientfield::set("blight_father_weakpoint_l_elbow_fx", 1);
    self clientfield::set("blight_father_weakpoint_r_elbow_fx", 1);
    self clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 1);
    self clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 1);
    self clientfield::set("blight_father_weakpoint_jaw_fx", 1);
    self clientfield::set("blight_father_amb_sac_clientfield", 1);
    level.var_2dbd0c0b++;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0xa7aa4679, Offset: 0x1b40
// Size: 0xf4
function private function_bb4e9700() {
    self.maxhealth = int(self zm_ai_utility::function_55a1bfd1(1, self._starting_round_number) * (isdefined(level.var_a915bb7) ? level.var_a915bb7 : 1));
    self.health = self.maxhealth;
    namespace_9088c704::initweakpoints(self, #"c_t8_zmb_blightfather_weakpoint_def");
    zm_score::function_c723805e("blight_father", self ai::function_a0dbf10a().var_cf17ae01);
    self zm_score::function_c4374c52();
    /#
        function_cb6fcfc5(self);
    #/
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xe16ec160, Offset: 0x1c40
// Size: 0xdc
function private function_67a13dca(entity) {
    entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
    entity.var_2b82eea9 = undefined;
    entity.knockdown = undefined;
    var_4e32c3bc = zm_lockdown_util::function_13e129fe(entity);
    if (isdefined(var_4e32c3bc)) {
        zm_lockdown_util::function_26e5ad8c(var_4e32c3bc);
        entity.var_d96f278 = undefined;
        entity.b_ignore_cleanup = entity.var_249da860;
        entity.var_249da860 = undefined;
    }
    entity thread function_5a2064a4();
    function_10b5404d(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xb80a98b1, Offset: 0x1d28
// Size: 0xbc
function private killed_callback(e_attacker) {
    if (self.archetype != "blight_father") {
        return;
    }
    self clientfield::set("blight_father_amb_sac_clientfield", 0);
    if (!isplayer(e_attacker)) {
        return;
    }
    if (level flag::get("zombie_drop_powerups") && !zm_utility::is_standard()) {
        level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x484d4d36, Offset: 0x1df0
// Size: 0x34
function private function_791c3379(params) {
    if (self.archetype !== "blight_father") {
        return;
    }
    self function_38a8375e();
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0x1e045f6d, Offset: 0x1e30
// Size: 0x12
function function_b578ce15() {
    self.completed_emerging_into_playable_area = 1;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xa99c999d, Offset: 0x1e50
// Size: 0x258
function function_c626b86e() {
    if (!isdefined(level.var_e899fd7b)) {
        level.var_e899fd7b = struct::get_array("blight_father_location", "script_noteworthy");
    }
    if (level.var_e899fd7b.size < 1) {
        self.b_ignore_cleanup = 1;
        return true;
    }
    var_e8c20bad = arraycopy(level.players);
    var_e8c20bad = arraysortclosest(var_e8c20bad, self.origin);
    i = 0;
    var_a2cdabee = level.var_e899fd7b[0];
    var_f6cadd32 = distancesquared(var_e8c20bad[0].origin, var_a2cdabee.origin);
    foreach (var_ec1c9465 in level.var_e899fd7b) {
        if (!zm_utility::is_player_valid(var_e8c20bad[i])) {
            i++;
            if (i >= var_e8c20bad.size) {
                i = 0;
                util::wait_network_frame();
            }
            continue;
        }
        var_4c271932 = distancesquared(var_e8c20bad[i].origin, var_ec1c9465.origin);
        if (var_4c271932 < var_f6cadd32) {
            var_f6cadd32 = var_4c271932;
            var_a2cdabee = var_ec1c9465;
        }
    }
    if (isalive(self)) {
        self.completed_emerging_into_playable_area = 0;
        self dontinterpolate();
        self forceteleport(var_a2cdabee.origin);
    }
    return true;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x6124c5eb, Offset: 0x20b0
// Size: 0x1174
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_4238f9e1));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_148b4066ca34ac7d", &function_4238f9e1);
    assert(isscriptfunctionptr(&function_1c5d0a6d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5c96eb204e351d55", &function_1c5d0a6d);
    assert(isscriptfunctionptr(&function_a6df9944));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7121da36951eb072", &function_a6df9944);
    assert(isscriptfunctionptr(&function_15172fe6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_32703c2c1d28f6f8", &function_15172fe6);
    assert(isscriptfunctionptr(&function_38961090));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_68ad8f05c187147e", &function_38961090);
    assert(isscriptfunctionptr(&function_4ab9214c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2fa134b71f113f7a", &function_4ab9214c);
    assert(isscriptfunctionptr(&function_c90f51d1));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_73649a2d01c11f41", &function_c90f51d1);
    assert(isscriptfunctionptr(&blightfathershouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldmelee", &blightfathershouldmelee);
    assert(isscriptfunctionptr(&blightfathershouldshowpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldshowpain", &blightfathershouldshowpain);
    assert(isscriptfunctionptr(&function_910e1326));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_41aa80b14334caac", &function_910e1326);
    assert(isscriptfunctionptr(&function_57cd23cb));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_124ccb4b34a00c0f", &function_57cd23cb);
    assert(isscriptfunctionptr(&function_8ab96e0e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_667d737e6c9aba40", &function_8ab96e0e);
    assert(isscriptfunctionptr(&blightfatherdeathstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfatherdeathstart", &blightfatherdeathstart);
    assert(isscriptfunctionptr(&function_750cf649));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ef0bb5832b7989d", &function_750cf649);
    assert(isscriptfunctionptr(&function_1cd2c5c2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1db7e3af327c9b04", &function_1cd2c5c2);
    assert(isscriptfunctionptr(&function_67a410e9));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7817d265f22976fd", &function_67a410e9);
    assert(isscriptfunctionptr(&function_c296a58d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_21c5672c06f01755", &function_c296a58d);
    assert(isscriptfunctionptr(&function_278dbf95));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_45f5d3d442f48795", &function_278dbf95);
    assert(isscriptfunctionptr(&function_66de51c1));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3598ca6c9a0b1b1", &function_66de51c1);
    assert(isscriptfunctionptr(&function_d5567714));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4913708f18cd3e3e", &function_d5567714);
    assert(isscriptfunctionptr(&function_f6e7ee6d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6a7eedc191a3f371", &function_f6e7ee6d);
    assert(isscriptfunctionptr(&function_4ec5a60e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_ae71931f5fb12d8", &function_4ec5a60e);
    assert(isscriptfunctionptr(&function_3e2929a1));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_23b3b2b5a3230cc5", &function_3e2929a1);
    assert(isscriptfunctionptr(&function_22f0da72));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77b88d91d0990898", &function_22f0da72);
    assert(isscriptfunctionptr(&function_30fd609));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6e5059e0839da879", &function_30fd609);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_1bc9157c) || isscriptfunctionptr(&function_1bc9157c));
    assert(!isdefined(&function_d47113be) || isscriptfunctionptr(&function_d47113be));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_7ebcf0c2d647b3a2", undefined, &function_1bc9157c, &function_d47113be);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_9d65423b) || isscriptfunctionptr(&function_9d65423b));
    assert(!isdefined(&function_d47113be) || isscriptfunctionptr(&function_d47113be));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_efb5b2c25a5b7cb", undefined, &function_9d65423b, &function_d47113be);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_ff44ef3b) || isscriptfunctionptr(&function_ff44ef3b));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_7b6603199659e6ff", undefined, &function_ff44ef3b, undefined);
    animationstatenetwork::registernotetrackhandlerfunction("blight_father_tongue_grab_launch", &function_426d513b);
    animationstatenetwork::registernotetrackhandlerfunction("blight_father_vomit_start", &function_e2c11a35);
    animationstatenetwork::registernotetrackhandlerfunction("fire_left", &function_6e462994);
    animationstatenetwork::registernotetrackhandlerfunction("fire_right", &function_5e0cf4cb);
    animationstatenetwork::registernotetrackhandlerfunction("blight_father_melee", &function_6829289a);
    animationstatenetwork::registernotetrackhandlerfunction("blight_father_show_tongue", &function_2b37c755);
    animationstatenetwork::registernotetrackhandlerfunction("blight_father_hide_tongue", &function_7905f242);
    animationstatenetwork::registernotetrackhandlerfunction("blightfather_explode", &function_22da16fd);
    animationstatenetwork::registeranimationmocomp("mocomp_purchase_lockdown_vomit@blight_father", &function_a931a1ee, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_grapple_attack_launch@blight_father", &function_6ab8695a, &function_e961ba55, &function_c24141b);
    assert(isscriptfunctionptr(&function_170a26d9));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ab9ffa56496f9a1", &function_170a26d9);
    assert(isscriptfunctionptr(&function_bc566142));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_116b298d64ab0478", &function_bc566142);
    assert(isscriptfunctionptr(&function_2469fe3a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7156796e4e9cd68", &function_2469fe3a);
    assert(isscriptfunctionptr(&function_d104e769));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7a04596792c5199d", &function_d104e769);
    assert(isscriptfunctionptr(&function_50ddd201));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_435c602040220705", &function_50ddd201);
    assert(isscriptfunctionptr(&function_9684881b));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_483c1950bc1df07f", &function_9684881b);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0xfc2c5b4b, Offset: 0x3230
// Size: 0x1c4
function function_22da16fd(entity) {
    if (entity isragdoll()) {
        entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
        if (entity isattached("c_t8_zmb_blightfather_eggsack1_both")) {
            entity detach("c_t8_zmb_blightfather_eggsack1_both");
        } else if (entity isattached("c_t8_zmb_blightfather_eggsack1_le")) {
            entity detach("c_t8_zmb_blightfather_eggsack1_le");
        } else if (entity isattached("c_t8_zmb_blightfather_eggsack1_ri")) {
            entity detach("c_t8_zmb_blightfather_eggsack1_ri");
        }
        entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
        return;
    }
    if (isdefined(entity.gib_model)) {
        entity.gib_model clientfield::set("blight_father_gib_explosion", 1);
        entity.gib_model stopanimscripted(0, 1);
        entity.gib_model startragdoll();
    }
    entity delete();
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x97fe1bb9, Offset: 0x3400
// Size: 0x4c
function private function_c13c95ce() {
    self endon(#"death");
    level waittilltimeout(300, #"clear_all_corpses");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0x3d94cc7e, Offset: 0x3458
// Size: 0x8e
function function_2bbddbf2() {
    if (isdefined(self.favoriteenemy)) {
        predictedpos = self lastknownpos(self.favoriteenemy);
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
            return turnyaw;
        }
    }
    return undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xf36db239, Offset: 0x34f0
// Size: 0x18e
function function_f1dfd3fd() {
    if (zm_lockdown_util::function_e4baa0a4(self)) {
        stub = zm_lockdown_util::function_13e129fe(self);
        var_a127dbcc = zm_lockdown_util::function_d6ef7837(self, stub);
        if (isdefined(var_a127dbcc)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(var_a127dbcc.origin - self.origin)[1]);
        } else {
            println("<dev string:x3e>" + self getentitynumber() + "<dev string:x4f>" + self.origin[0] + "<dev string:x55>" + self.origin[1] + "<dev string:x55>" + self.origin[2] + "<dev string:x57>");
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(stub.origin - self.origin)[1]);
        }
        return turnyaw;
    }
    return undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x404fb5a1, Offset: 0x3688
// Size: 0x11a
function private function_bc566142(entity) {
    enemies = getaiarchetypearray("zombie");
    enemies = arraycombine(enemies, getaiarchetypearray("catalyst"), 0, 0);
    enemies = array::filter(enemies, 0, &function_7bd6888b, entity);
    foreach (enemy in enemies) {
        enemy zombie_utility::setup_zombie_knockdown(entity);
        enemy.knockdown_type = "knockdown_shoved";
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0x816e0db0, Offset: 0x37b0
// Size: 0x1a8
function private function_7bd6888b(enemy, target) {
    if (isdefined(enemy.knockdown) && enemy.knockdown) {
        return false;
    }
    if (gibserverutils::isgibbed(enemy, 384)) {
        return false;
    }
    if (distancesquared(enemy.origin, target.origin) > self ai::function_a0dbf10a().var_529b2c4f * self ai::function_a0dbf10a().var_529b2c4f) {
        return false;
    }
    facingvec = anglestoforward(target.angles);
    enemyvec = enemy.origin - target.origin;
    var_c960aec6 = (enemyvec[0], enemyvec[1], 0);
    var_ca23d7da = (facingvec[0], facingvec[1], 0);
    var_c960aec6 = vectornormalize(var_c960aec6);
    var_ca23d7da = vectornormalize(var_ca23d7da);
    enemydot = vectordot(var_ca23d7da, var_c960aec6);
    if (enemydot < 0) {
        return false;
    }
    return true;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0x62df5e7e, Offset: 0x3960
// Size: 0x4a
function private function_ce7e8ac9(origin, angles) {
    fx_model = util::spawn_model(#"tag_origin", origin, angles);
    return fx_model;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x4accc486, Offset: 0x39b8
// Size: 0x24
function private blightfathershouldshowpain(entity) {
    if (isdefined(entity.var_2b82eea9)) {
        return true;
    }
    return false;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xfe0e0812, Offset: 0x39e8
// Size: 0x54
function private function_22f0da72(entity) {
    function_d5567714(entity);
    entity thread function_5a2064a4();
    function_10b5404d(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xe3b2dd54, Offset: 0x3a48
// Size: 0x6c
function private function_910e1326(entity) {
    return blightfathershouldshowpain(entity) || zm_behavior::zombieshouldstun(entity) || function_38961090(entity) || zm_behavior::zombieshouldknockdown(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x91040602, Offset: 0x3ac0
// Size: 0x22
function private function_d5567714(entity) {
    entity.var_2b82eea9 = undefined;
    entity.var_479f7721 = undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 12, eflags: 0x4
// Checksum 0x6c8d85f1, Offset: 0x3af0
// Size: 0x178
function private function_84c9039b(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (!(isdefined(self.var_5d598ea6) && self.var_5d598ea6) && isdefined(self.e_grapplee) && (hitloc == "head" || attacker === self.e_grapplee)) {
        if (!isdefined(self.var_479f7721)) {
            self.var_479f7721 = 0;
        }
        self.var_479f7721 += damage;
        if (function_38961090(self)) {
            self.var_57a0fb7f = inflictor;
        }
    }
    if (!(isdefined(self.var_5d598ea6) && self.var_5d598ea6) && isdefined(self.e_grapplee) && (zm_loadout::is_hero_weapon(weapon) || meansofdamage === "MOD_PROJECTILE")) {
        self ai::stun();
    }
    return damage;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x9ebb9100, Offset: 0x3c70
// Size: 0x34
function private function_38a8375e() {
    function_10b5404d(self);
    self thread function_5a2064a4();
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xa1ed22f, Offset: 0x3cb0
// Size: 0x6c
function private function_ce67287d(grapplee) {
    if (isdefined(grapplee) && isplayer(grapplee)) {
        grapplee clientfield::set_to_player("tongueGrabPostFx", 0);
        grapplee clientfield::set_to_player("tongueGrabRumble", 0);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x3f401b24, Offset: 0x3d28
// Size: 0x16a
function private blightfatherdeathstart(entity) {
    entity val::set(#"blight_father_death", "takedamage", 0);
    if (level.var_2e442253 === entity) {
        level.var_2e442253 = undefined;
    }
    if (entity isattached("c_t8_zmb_blightfather_tongue2", "tag_tongue_grab")) {
        entity detach("c_t8_zmb_blightfather_tongue2");
    }
    if (!entity isragdoll()) {
        gib_model = util::spawn_anim_model("c_t8_zmb_blightfather_body1_gib", entity.origin, entity.angles);
        if (!isdefined(gib_model)) {
            return;
        }
        gib_model animscripted(#"hash_56a346d1e0dd61cd", gib_model.origin, gib_model.angles, #"hash_3e937fff0e0a4362", "normal");
        gib_model thread function_c13c95ce();
        entity.gib_model = gib_model;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xbe940172, Offset: 0x3ea0
// Size: 0x22
function private blightfathershouldmelee(entity) {
    return zombiebehavior::zombieshouldmeleecondition(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x4811ef17, Offset: 0x3ed0
// Size: 0x320
function private function_6829289a(entity) {
    meleerange = entity ai::function_a0dbf10a().var_ab74e665;
    meleerangesq = meleerange * meleerange;
    potential_players = [];
    foreach (player in getplayers()) {
        if (meleerangesq < distancesquared(entity.origin, player.origin)) {
            continue;
        }
        if (!isdefined(potential_players)) {
            potential_players = [];
        } else if (!isarray(potential_players)) {
            potential_players = array(potential_players);
        }
        if (!isinarray(potential_players, player)) {
            potential_players[potential_players.size] = player;
        }
    }
    bhtnactionstartevent(entity, "attack_melee");
    var_cc47ad4e = anglestoforward(entity.angles);
    var_4386a100 = entity gettagorigin("j_spine4");
    var_5d4569dd = entity ai::function_a0dbf10a().var_50bc3420;
    foreach (player in potential_players) {
        vec_to_player = vectornormalize(player.origin - entity.origin);
        if (vectordot(vec_to_player, var_cc47ad4e) < var_5d4569dd) {
            continue;
        }
        if (bullettracepassed(var_4386a100, player geteye(), 0, entity)) {
            player dodamage(entity.meleeweapon.playerdamage, entity.origin, entity, entity, "none", "MOD_MELEE");
        }
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x168acbd7, Offset: 0x41f8
// Size: 0x1a2
function private function_7d6fec24(entity) {
    /#
        if (isdefined(entity.ispuppet) && entity.ispuppet) {
            return;
        }
    #/
    if (!isdefined(entity.var_532a149b)) {
        if (isdefined(self.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            self.ignore_player = [];
        }
        if (!isdefined(entity.var_24fac890)) {
            entity.var_24fac890 = entity zm_cleanup::get_escape_position();
        }
        if (isdefined(entity.var_24fac890)) {
            entity setgoal(entity.var_24fac890.origin);
        } else {
            entity setgoal(entity.origin);
        }
        return 0;
    }
    entity.var_24fac890 = undefined;
    if (isdefined(entity.var_d96f278)) {
        targetpos = entity.var_d96f278;
        self function_3c8dce03(targetpos);
    } else {
        targetpos = entity.var_532a149b.origin;
        zm_utility::function_23a24406(targetpos);
    }
    entity.favoriteenemy = entity.var_532a149b;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x5da41efb, Offset: 0x43a8
// Size: 0x54
function private function_66de51c1(entity) {
    function_74e138ba(entity);
    function_10b5404d(entity);
    zm_behavior::zombiestunstart(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0x84046096, Offset: 0x4408
// Size: 0x38
function private function_ff44ef3b(entity, asmstatename) {
    if (zm_behavior::zombieshouldstun(entity)) {
        return 5;
    }
    return 4;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x8b788f80, Offset: 0x4448
// Size: 0x54
function private function_30fd609(entity) {
    function_74e138ba(entity);
    function_10b5404d(entity);
    zm_behavior::zombieknockdownactionstart(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0x11d22d09, Offset: 0x44a8
// Size: 0x30
function private function_d47113be(entity, asmstatename) {
    function_c296a58d(entity);
    return 4;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x2685c0c7, Offset: 0x44e0
// Size: 0x54
function private function_c296a58d(entity) {
    if (function_910e1326(entity)) {
        function_74e138ba(entity);
        function_10b5404d(entity);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x76212096, Offset: 0x4540
// Size: 0x50
function private function_e4188e2() {
    if (isdefined(self.var_65570131) && self.var_65570131) {
        return "left_sac_destroyed";
    }
    if (isdefined(self.var_b25ccef2) && self.var_b25ccef2) {
        return "right_sac_destroyed";
    }
    return undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 13, eflags: 0x4
// Checksum 0x433e799f, Offset: 0x4598
// Size: 0x114
function private function_924791c1(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity.var_693891b8--;
    entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
    entity destructserverutils::handledamage(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 13, eflags: 0x4
// Checksum 0xb94fb61e, Offset: 0x46b8
// Size: 0x156
function private function_f64d7f9c(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity.var_5d598ea6 = 1;
    entity.var_46d408de = 1;
    entity clientfield::set("blight_father_weakpoint_jaw_fx", 0);
    entity attach("c_t8_zmb_blightfather_mouth_dmg1");
    if (entity isattached("c_t8_zmb_blightfather_tongue2", "tag_tongue_grab")) {
        entity detach("c_t8_zmb_blightfather_tongue2");
    }
    stub = zm_lockdown_util::function_13e129fe(entity);
    zm_lockdown_util::function_26e5ad8c(stub);
    entity.var_d96f278 = undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 13, eflags: 0x4
// Checksum 0x587d983e, Offset: 0x4818
// Size: 0x8c
function private function_eaea407d(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity clientfield::set("blight_father_weakpoint_l_elbow_fx", 0);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 13, eflags: 0x4
// Checksum 0x6c58a7b4, Offset: 0x48b0
// Size: 0x8c
function private function_91052e18(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity clientfield::set("blight_father_weakpoint_r_elbow_fx", 0);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 13, eflags: 0x4
// Checksum 0x91948016, Offset: 0x4948
// Size: 0x16c
function private function_d17bf4dc(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity.var_65570131 = 1;
    entity clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 0);
    entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
    if (isdefined(entity.var_b25ccef2) && entity.var_b25ccef2) {
        entity detach("c_t8_zmb_blightfather_eggsack1_le");
    } else {
        entity detach("c_t8_zmb_blightfather_eggsack1_both");
        entity attach("c_t8_zmb_blightfather_eggsack1_ri");
    }
    entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 13, eflags: 0x4
// Checksum 0xc9ffaaa4, Offset: 0x4ac0
// Size: 0x16c
function private function_e8add48b(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity.var_b25ccef2 = 1;
    entity clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 0);
    entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
    if (isdefined(entity.var_65570131) && entity.var_65570131) {
        entity detach("c_t8_zmb_blightfather_eggsack1_ri");
    } else {
        entity detach("c_t8_zmb_blightfather_eggsack1_both");
        entity attach("c_t8_zmb_blightfather_eggsack1_le");
    }
    entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 14, eflags: 0x4
// Checksum 0xac1045e2, Offset: 0x4c38
// Size: 0x224
function private function_5a30ecc8(var_b750d1c8, entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (namespace_9088c704::function_4abac7be(var_b750d1c8) != 1) {
        return;
    }
    namespace_9088c704::damageweakpoint(var_b750d1c8, damage);
    inflictor thread function_48e82a7c(self);
    if (namespace_9088c704::function_4abac7be(var_b750d1c8) == 3) {
        if (isdefined(level.var_73451561[var_b750d1c8.var_778c0469])) {
            entity [[ level.var_73451561[var_b750d1c8.var_778c0469] ]](entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        }
        if (!entity isplayinganimscripted()) {
            entity.var_2b82eea9 = var_b750d1c8.var_778c0469;
            entity setblackboardattribute("_blight_father_weak_point", var_b750d1c8.var_778c0469);
        }
        bone = boneindex;
        if (zm_utility::is_explosive_damage(meansofdamage)) {
            bone = var_b750d1c8.var_778c0469;
        }
        function_924791c1(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, bone, modelindex);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0xc24ce0f3, Offset: 0x4e68
// Size: 0x64
function function_48e82a7c(ai) {
    if (level.var_2dbd0c0b <= 2) {
        if (level.time - ai.birthtime > 3000) {
            self thread zm_audio::create_and_play_dialog("blight_father", "weak_points");
        }
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 12, eflags: 0x4
// Checksum 0x8c341224, Offset: 0x4ed8
// Size: 0x34e
function private function_a505a12(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    var_ce4361a0 = zm_ai_utility::function_9094ed69(entity, attacker, weapon, boneindex);
    damage_scale = var_ce4361a0.damage_scale;
    var_b750d1c8 = var_ce4361a0.var_b750d1c8;
    var_9c192fd2 = var_ce4361a0.var_9c192fd2;
    if (zm_utility::is_explosive_damage(meansofdamage)) {
        damage_scale = max(damage_scale, entity ai::function_a0dbf10a().explosivedamagescale);
        final_damage = int(damage * damage_scale);
        if (meansofdamage === "MOD_PROJECTILE" && isdefined(var_b750d1c8) && var_9c192fd2) {
            function_5a30ecc8(var_b750d1c8, entity, inflictor, attacker, var_b750d1c8.health, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        }
    } else {
        final_damage = int(damage * damage_scale);
        if (isdefined(var_b750d1c8) && var_9c192fd2) {
            function_5a30ecc8(var_b750d1c8, entity, inflictor, attacker, final_damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        }
    }
    /#
        if (isdefined(level.var_643255b) && level.var_643255b) {
            iprintlnbold("<dev string:x9c>" + damage_scale + "<dev string:xa8>" + final_damage + "<dev string:xb0>" + entity.health - final_damage + "<dev string:xbb>" + entity.var_693891b8);
        }
    #/
    if (entity.var_693891b8 <= 0) {
        origin = entity.origin;
        if (isdefined(inflictor)) {
            origin = inflictor.origin;
        }
        entity kill(origin, attacker, inflictor, weapon, 0, 1);
        final_damage = 0;
    }
    return final_damage;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xd3df55aa, Offset: 0x5230
// Size: 0xe8
function private function_9e4abccc(entity) {
    var_72a43d60 = entity astsearch("grapple_attack_vomit@blight_father");
    animname = animationstatenetworkutility::searchanimationmap(entity, var_72a43d60[#"animation"]);
    tag_pos = getanimtagorigin(animname, 0, "tag_tongue");
    var_a34fff1 = rotatepoint(tag_pos, entity gettagangles("tag_origin"));
    var_a34fff1 += entity.origin;
    return var_a34fff1;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x5ec59468, Offset: 0x5320
// Size: 0x36
function private function_83af9df4(entity) {
    entity.var_849f9ffb = gettime() + entity ai::function_a0dbf10a().var_526d4755;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0xa0af2fdb, Offset: 0x5360
// Size: 0x1e6
function private function_5eb4ae08(entity, player) {
    if (entity.var_fc14d6a.timestamp !== gettime()) {
        entity.var_fc14d6a.traces = [];
        entity.var_fc14d6a.timestamp = gettime();
    } else if (isdefined(entity.var_fc14d6a.traces[player getentitynumber()])) {
        return entity.var_fc14d6a.traces[player getentitynumber()];
    }
    clip_mask = 1 | 8;
    if (player haspart("j_mainroot")) {
        trace = physicstrace(entity.origin + (0, 0, 35), player gettagorigin("j_mainroot"), (-15, -15, -20), (15, 15, 40), entity, clip_mask);
    } else {
        trace = physicstrace(entity.origin + (0, 0, 35), player.origin, (-15, -15, -20), (15, 15, 40), entity, clip_mask);
    }
    entity.var_fc14d6a.traces[player getentitynumber()] = trace;
    return trace;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x62f15124, Offset: 0x5550
// Size: 0x4a
function private function_57cd23cb(entity) {
    if (!isdefined(level.var_c1448fc4) || level.var_c1448fc4 === entity) {
        level.var_c1448fc4 = entity;
        return true;
    }
    return false;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x32ced2a6, Offset: 0x55a8
// Size: 0x16
function private function_29d27bde(entity) {
    level.var_c1448fc4 = undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x2fb5726a, Offset: 0x55c8
// Size: 0x76
function private function_8ab96e0e(entity) {
    if (function_57cd23cb(entity)) {
        if (function_4238f9e1(entity)) {
            function_29d27bde(entity);
            return true;
        }
        if (function_c90f51d1(entity)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x7d98ccef, Offset: 0x5648
// Size: 0x2f6
function private function_4238f9e1(entity) {
    if (!ai::get_behavior_attribute("tongue_grab_enabled")) {
        return false;
    }
    if (entity.var_849f9ffb > gettime()) {
        return false;
    }
    if (zm_grappler::function_86ba73d5()) {
        return false;
    }
    var_ffd3e32b = function_d1fb27e8(entity);
    if (isdefined(var_ffd3e32b) && var_ffd3e32b != 4) {
        return false;
    }
    if (isdefined(entity.var_5d598ea6) && entity.var_5d598ea6) {
        return false;
    }
    if (abs(entity aiutility::function_333b8895()) > 5) {
        return false;
    }
    foreach (player in level.players) {
        /#
            if (player isinmovemode("<dev string:xcc>", "<dev string:xd0>")) {
                continue;
            }
        #/
        if (!zombie_utility::is_player_valid(player, 1)) {
            continue;
        }
        var_559d3d07 = distancesquared(player.origin, entity.origin);
        if (var_559d3d07 > entity ai::function_a0dbf10a().var_94bff710 * entity ai::function_a0dbf10a().var_94bff710) {
            continue;
        }
        if (vectordot(vectornormalize(player.origin - entity.origin), anglestoforward(entity.angles)) < entity ai::function_a0dbf10a().var_e86a54cb) {
            continue;
        }
        test_trace = function_5eb4ae08(entity, player);
        if (test_trace[#"fraction"] == 1 || test_trace[#"entity"] === player) {
            entity.var_1fdc6ca = player;
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x954941f8, Offset: 0x5948
// Size: 0x18
function private function_1c5d0a6d(entity) {
    return isdefined(entity.e_grapplee);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x96eb326b, Offset: 0x5968
// Size: 0x3c
function private function_6b86e4fc(notifyhash) {
    function_10b5404d(self);
    function_5a2064a4(notifyhash);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0x5ba5b609, Offset: 0x59b0
// Size: 0x5bc
function private function_99530eda(entity, var_9504b907) {
    entity endoncallback(&function_6b86e4fc, #"death", #"hash_2fb2eddfa6a0ef3f");
    grapple_start = zm_grappler::create_mover(entity gettagorigin("tag_jaw"), entity.angles);
    grapple_end = zm_grappler::create_mover(entity gettagorigin("tag_jaw"), entity.angles * -1);
    grapple_end.var_683c052c = entity;
    grapple_start linkto(entity, "tag_jaw");
    entity.var_3278d491 = {#beamstart:grapple_start, #beamend:grapple_end, #status:0, #ignore_ents:[]};
    thread zm_grappler::function_28ac2916(grapple_start, grapple_end);
    util::wait_network_frame();
    n_time = distance(grapple_end.origin, var_9504b907) / entity ai::function_a0dbf10a().var_146d3e73;
    entity.var_3278d491.status = 1;
    grapple_end playsound(#"zmb_grapple_start");
    grapple_end moveto(var_9504b907, n_time, 0, n_time * 0.1);
    grapple_end.return_pos = entity zm_grappler::function_1e702195();
    thread function_e5b962df(entity, entity ai::function_a0dbf10a().var_b3d6c45b * entity ai::function_a0dbf10a().var_b3d6c45b, level.players);
    grapple_end flagsys::wait_till("grapple_moveto_done");
    grapple_end flagsys::clear("grapple_moveto_done");
    entity.var_3278d491.status = 2;
    n_time = distance(grapple_end.origin, grapple_end.return_pos) / entity ai::function_a0dbf10a().var_146d3e73;
    grapple_end moveto(grapple_end.return_pos, n_time, n_time * 0.1, 0);
    var_32e5a771 = entity.e_grapplee;
    grapple_end playsound(#"zmb_grapple_pull");
    thread function_e5b962df(entity, entity ai::function_a0dbf10a().var_b3d6c45b * entity ai::function_a0dbf10a().var_b3d6c45b, level.players);
    grapple_end flagsys::wait_till("grapple_moveto_done");
    grapple_end flagsys::clear("grapple_moveto_done");
    if (!isdefined(var_32e5a771) && isdefined(entity.e_grapplee)) {
        n_time = distance(grapple_end.origin, grapple_end.return_pos) / entity ai::function_a0dbf10a().var_146d3e73;
        grapple_end moveto(grapple_end.return_pos, n_time, 0, 0);
        grapple_end waittill(#"movedone");
    }
    if (isdefined(entity.e_grapplee)) {
        var_60df7dd9 = function_9e4abccc(entity);
        var_1067eb07 = entity.origin - var_60df7dd9;
        angles = vectortoangles(var_1067eb07);
        grapple_end.angles = (grapple_end.angles[0], angles[1], grapple_end.angles[2]);
    }
    entity.var_3278d491.status = 4;
    if (!isdefined(entity.e_grapplee)) {
        entity thread function_5a2064a4();
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x1f00b11d, Offset: 0x5f78
// Size: 0x1dc
function private function_426d513b(entity) {
    entity.var_479f7721 = 0;
    if (zombie_utility::is_player_valid(entity.var_1fdc6ca, 1, 1)) {
        dir = entity.var_1fdc6ca zm_grappler::function_1e702195() - entity zm_grappler::function_1e702195();
        dir_norm = vectornormalize(dir);
        if (vectordot(dir_norm, anglestoforward(entity.angles)) < entity ai::function_a0dbf10a().var_e86a54cb) {
            dir_norm = anglestoforward(entity.angles);
        }
        var_9504b907 = entity zm_grappler::function_1e702195() + dir_norm * entity ai::function_a0dbf10a().var_94bff710;
        test_trace = worldtrace(entity zm_grappler::function_1e702195(), var_9504b907);
        if (test_trace[#"fraction"] < 1) {
            var_9504b907 = test_trace[#"position"];
        }
        thread function_99530eda(entity, var_9504b907);
    }
    function_29d27bde(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0x659ea34d, Offset: 0x6160
// Size: 0x32
function function_d1fb27e8(entity) {
    if (isdefined(entity.var_3278d491)) {
        return entity.var_3278d491.status;
    }
    return undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0xb50fbbae, Offset: 0x61a0
// Size: 0x3c
function function_75526691(notifyhash) {
    if (notifyhash === #"movedone") {
        self flagsys::set("grapple_moveto_done");
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 3, eflags: 0x0
// Checksum 0x8f84832b, Offset: 0x61e8
// Size: 0x560
function function_e5b962df(entity, var_c9b9f7ba, var_87f72f29) {
    entity endon(#"death", #"hash_2fb2eddfa6a0ef3f");
    entity.var_3278d491.beamend endoncallback(&function_75526691, #"death", #"movedone");
    /#
        if (getdvarint(#"hash_692fb9cc4cff6541", 0)) {
            var_8ad26463 = sqrt(var_c9b9f7ba);
            debug_origins = [];
        }
    #/
    while (true) {
        if (!isdefined(entity.e_grapplee)) {
            /#
                if (getdvarint(#"hash_692fb9cc4cff6541", 0)) {
                    if (!isdefined(debug_origins)) {
                        debug_origins = [];
                    } else if (!isarray(debug_origins)) {
                        debug_origins = array(debug_origins);
                    }
                    if (!isinarray(debug_origins, entity.var_3278d491.beamend.origin)) {
                        debug_origins[debug_origins.size] = entity.var_3278d491.beamend.origin;
                    }
                    foreach (origin in debug_origins) {
                        recordcircle(origin, var_8ad26463, (1, 0, 0));
                        recordstar(origin, (0, 1, 0));
                    }
                }
            #/
            e_grapplee = function_62527ce4(entity, entity.var_3278d491.beamend.origin, var_c9b9f7ba, var_87f72f29);
            if (isdefined(e_grapplee)) {
                entity.var_3278d491.beamend.return_pos = entity gettagorigin("tag_jaw");
                if (isdefined(e_grapplee.hasriotshieldequipped) && e_grapplee.hasriotshieldequipped) {
                    if (!isdefined(entity.var_3278d491.ignore_ents)) {
                        entity.var_3278d491.ignore_ents = [];
                    } else if (!isarray(entity.var_3278d491.ignore_ents)) {
                        entity.var_3278d491.ignore_ents = array(entity.var_3278d491.ignore_ents);
                    }
                    if (!isinarray(entity.var_3278d491.ignore_ents, e_grapplee)) {
                        entity.var_3278d491.ignore_ents[entity.var_3278d491.ignore_ents.size] = e_grapplee;
                    }
                    e_grapplee thread riotshield::player_take_riotshield();
                } else if (e_grapplee function_61d1659d()) {
                    if (!isdefined(entity.var_3278d491.ignore_ents)) {
                        entity.var_3278d491.ignore_ents = [];
                    } else if (!isarray(entity.var_3278d491.ignore_ents)) {
                        entity.var_3278d491.ignore_ents = array(entity.var_3278d491.ignore_ents);
                    }
                    if (!isinarray(entity.var_3278d491.ignore_ents, e_grapplee)) {
                        entity.var_3278d491.ignore_ents[entity.var_3278d491.ignore_ents.size] = e_grapplee;
                    }
                } else {
                    function_9aed7158(entity, entity.var_3278d491.beamend, e_grapplee);
                }
                entity.var_3278d491.beamend flagsys::set("grapple_moveto_done");
                return;
            }
        }
        waitframe(1);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 4, eflags: 0x4
// Checksum 0xdc1198e2, Offset: 0x6750
// Size: 0x22c
function private function_62527ce4(entity, var_53424f3b, var_c9b9f7ba, var_87f72f29) {
    foreach (var_13aac156 in var_87f72f29) {
        if (!zombie_utility::is_player_valid(var_13aac156, 1, 1) || isdefined(var_13aac156.var_14f171d3) && var_13aac156.var_14f171d3 || isdefined(var_13aac156.var_fc6fd274) && var_13aac156.var_fc6fd274 || var_13aac156 issliding() || var_13aac156 getstance() == "prone" || isinarray(entity.var_3278d491.ignore_ents, var_13aac156)) {
            continue;
        }
        if (distancesquared(var_13aac156 gettagorigin("j_mainroot"), var_53424f3b) < var_c9b9f7ba) {
            var_60df7dd9 = function_9e4abccc(entity);
            var_4b4beea3 = var_13aac156 geteye() - var_60df7dd9;
            var_8d99eb0c = (var_4b4beea3[0], var_4b4beea3[1], 0);
            if (vectordot(var_8d99eb0c, anglestoforward(entity.angles)) > 0) {
                return var_13aac156;
            }
        }
    }
    return undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x12e1e1b3, Offset: 0x6988
// Size: 0x4c
function private function_1bc80b76() {
    self endon(#"death");
    while (self isswitchingweapons()) {
        waitframe(1);
    }
    self thread riotshield::function_8aeed162();
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 3, eflags: 0x4
// Checksum 0xe7658864, Offset: 0x69e0
// Size: 0x33c
function private function_9aed7158(var_683c052c, var_9608be00, e_grapplee) {
    if (!isdefined(var_9608be00)) {
        return;
    }
    var_683c052c.e_grapplee = e_grapplee;
    e_grapplee zm_grappler::function_63b4b8a5(1, 0);
    if (isplayer(e_grapplee)) {
        e_grapplee thread function_1bc80b76();
        e_grapplee function_191a0803();
    }
    var_60df7dd9 = function_9e4abccc(var_683c052c);
    /#
        recordstar(var_60df7dd9, (1, 0.5, 0));
        recordcircle(var_60df7dd9, 10, (0, 0, 1));
    #/
    var_9608be00.return_pos = var_60df7dd9;
    var_7c18526c = util::spawn_model("tag_origin", e_grapplee.origin, e_grapplee.angles);
    var_7c18526c linkto(var_9608be00, "tag_origin", (0, 0, 35) * -1);
    e_grapplee.var_7c18526c = var_7c18526c;
    if (isplayer(e_grapplee)) {
        e_grapplee playerlinkto(var_7c18526c, "tag_origin", 1, 40, 40, 80, 15);
        /#
            recordstar(var_60df7dd9, (1, 0, 0));
            recordstar(e_grapplee geteye(), (0, 0, 1));
        #/
        angles = vectortoangles(var_60df7dd9 - e_grapplee geteye());
        var_9608be00.angles = (0, angles[1], 0);
        e_grapplee setplayerangles(angles);
        e_grapplee setstance("stand");
        e_grapplee allowcrouch(0);
        e_grapplee allowprone(0);
        e_grapplee function_606621fb();
    } else {
        e_grapplee linkto(var_9608be00);
    }
    e_grapplee playsound(#"zmb_grapple_grab");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0x3f0992d, Offset: 0x6d28
// Size: 0x1de
function function_10b5404d(entity) {
    entity.var_57a0fb7f = undefined;
    grapplee = entity.e_grapplee;
    if (!isdefined(grapplee)) {
        return;
    }
    grapplee notify(#"hash_46064b6c2cb5cf20", {#blight_father:entity});
    function_ce67287d(grapplee);
    grapplee unlink();
    if (isdefined(grapplee.var_7c18526c)) {
        grapplee.var_7c18526c delete();
        grapplee.var_7c18526c = undefined;
    }
    grapplee zm_grappler::function_63b4b8a5(0, 0);
    if (isplayer(grapplee)) {
        grapplee function_8713f03e();
        grapplee allowcrouch(1);
        grapplee allowprone(1);
    }
    droppoint = getclosestpointonnavmesh(grapplee.origin, 64);
    if (isdefined(droppoint)) {
        if (isplayer(grapplee)) {
            grapplee setorigin(droppoint);
        } else {
            grapplee forceteleport(droppoint);
        }
    }
    grapplee function_5e2f2004();
    entity.e_grapplee = undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x4d3ae274, Offset: 0x6f10
// Size: 0x1bc
function private function_5e2f2004() {
    enemies = getaispeciesarray(level.zombie_team, "all");
    enemies = arraysortclosest(enemies, self.origin, undefined, 0, self getpathfindingradius() + 100);
    foreach (enemy in enemies) {
        if (self istouching(enemy)) {
            if (isdefined(enemy.allowdeath) && enemy.allowdeath && (enemy.var_29ed62b2 === #"basic" || enemy.var_29ed62b2 === #"popcorn")) {
                enemy zm_cleanup::function_9d243698();
                enemy kill();
                continue;
            }
            self dodamage(self.health + 1000, self.origin, enemy, enemy, "none", "MOD_RIFLE_BULLET");
            break;
        }
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0x33b6dd07, Offset: 0x70d8
// Size: 0x122
function function_5a2064a4(notifyhash) {
    if (isdefined(self.var_683c052c)) {
        entity = self.var_683c052c;
    } else {
        entity = self;
    }
    if (!isdefined(entity.var_3278d491)) {
        return;
    }
    e_source = entity.var_3278d491.beamstart;
    e_beamend = entity.var_3278d491.beamend;
    entity.var_3278d491 = undefined;
    zm_grappler::function_b7c692b0();
    level.var_5b94112c = 1;
    if (isdefined(e_source)) {
        e_source unlink();
        zm_grappler::destroy_mover(e_source);
    }
    if (isdefined(e_beamend)) {
        zm_grappler::destroy_mover(e_beamend);
    }
    util::wait_network_frame();
    level.var_5b94112c = 0;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x657a1e28, Offset: 0x7208
// Size: 0x44
function private function_606621fb() {
    self clientfield::set_to_player("tongueGrabRumble", 1);
    self clientfield::set_to_player("tongueGrabPostFx", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 5, eflags: 0x4
// Checksum 0xd4e31af5, Offset: 0x7258
// Size: 0xdc
function private function_6ab8695a(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (zm_utility::is_player_valid(entity.var_1fdc6ca)) {
        to_player = entity.var_1fdc6ca.origin - entity.origin;
        var_40aaf111 = vectortoangles(to_player);
        entity orientmode("face angle", var_40aaf111[1]);
    }
    entity animmode("zonly_physics", 0);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 5, eflags: 0x4
// Checksum 0x3d35c785, Offset: 0x7340
// Size: 0x1ac
function private function_e961ba55(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (function_d1fb27e8(entity) === 0 && zm_utility::is_player_valid(entity.var_1fdc6ca) && !isdefined(entity.e_grapplee)) {
        /#
            record3dtext("<dev string:xd7>", entity.origin + (0, 0, 16), (0, 0, 1));
        #/
        to_player = entity.var_1fdc6ca.origin - entity.origin;
        var_40aaf111 = vectortoangles(to_player);
        entity orientmode("face angle", var_40aaf111[1]);
    } else {
        /#
            record3dtext("<dev string:xe5>", entity.origin + (0, 0, 16), (0, 1, 0));
        #/
        entity orientmode("face current");
    }
    entity animmode("zonly_physics", 0);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 5, eflags: 0x4
// Checksum 0xe5a306f2, Offset: 0x74f8
// Size: 0x4c
function private function_c24141b(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face default");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0xc85ce3c0, Offset: 0x7550
// Size: 0x58
function private function_1bc9157c(entity, asmstatename) {
    if (function_d1fb27e8(entity) === 0 || function_d1fb27e8(entity) === 1) {
        return 5;
    }
    return 4;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0xa920ef99, Offset: 0x75b0
// Size: 0x3e
function private function_9d65423b(entity, asmstatename) {
    if (function_d1fb27e8(entity) === 2) {
        return 5;
    }
    return 4;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0xb814dd59, Offset: 0x75f8
// Size: 0x2c
function function_278dbf95(entity) {
    entity.var_1fdc6ca = undefined;
    function_c296a58d(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x72fd8e2d, Offset: 0x7630
// Size: 0x5c
function private watch_disconnect(grappler) {
    grappler endon(#"death", #"hash_2fb2eddfa6a0ef3f");
    self waittill(#"disconnect");
    thread function_74e138ba(grappler);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x7ab916a6, Offset: 0x7698
// Size: 0x4e
function private function_d7336abd(grappler) {
    self endon(#"disconnect");
    grappler waittill(#"death", #"hash_2fb2eddfa6a0ef3f");
    self.var_de91f30f = 0;
}

/#

    // Namespace zm_ai_blight_father/zm_ai_blight_father
    // Params 1, eflags: 0x4
    // Checksum 0x446697df, Offset: 0x76f0
    // Size: 0xa8
    function private function_e682e6d3(grappler) {
        self endon(#"disconnect");
        grappler endon(#"death", #"hash_2fb2eddfa6a0ef3f");
        while (true) {
            if (self isinmovemode("<dev string:xd0>", "<dev string:xcc>")) {
                grappler function_38a8375e();
                function_10b5404d(grappler);
            }
            wait 0.1;
        }
    }

#/

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x6916d510, Offset: 0x77a0
// Size: 0x1d0
function private function_9684881b(entity) {
    grapplee = entity.e_grapplee;
    if (isdefined(grapplee)) {
        entity thread function_5a2064a4();
        if (isdefined(grapplee.var_7c18526c)) {
            grapplee.var_7c18526c unlink();
            var_2c4beae3 = vectortoangles(entity.origin - grapplee.var_7c18526c.origin);
            var_132252c9 = entity gettagangles("tag_tongue");
            grapplee.var_7c18526c linkto(entity, "tag_tongue", (0, 0, 35) * -1, (var_132252c9[0] * -1, var_2c4beae3[1] - var_132252c9[1], var_132252c9[2] * -1));
            grapplee setplayercollision(1);
        } else {
            function_10b5404d(entity);
        }
        println("<dev string:xf4>" + distance(function_9e4abccc(entity), grapplee.origin + (0, 0, 35)));
    }
    return true;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xb9ab1993, Offset: 0x7978
// Size: 0x25c
function private function_50ddd201(entity) {
    var_8694b35a = 0;
    grapplee = entity.e_grapplee;
    if (isdefined(grapplee) && isplayer(grapplee) && !(isdefined(grapplee.var_56c7266a) && grapplee.var_56c7266a) && !(isdefined(grapplee.var_d3c40f30) && grapplee.var_d3c40f30)) {
        grapplee.var_de91f30f = 1;
        var_8694b35a = 1;
        var_f98db658 = entity gettagorigin("tag_jaw") - grapplee geteye();
        angles = vectortoangles(var_f98db658);
        grapplee setplayerangles((angles[0], angles[1], grapplee.angles[2]));
        grapplee thread watch_disconnect(entity);
        grapplee thread function_d7336abd(entity);
        /#
            grapplee thread function_e682e6d3(entity);
        #/
    }
    if (!var_8694b35a && entity.var_da135442 < ai::function_a0dbf10a().var_103ec1d8) {
        if (math::cointoss()) {
            entity.var_da135442 += 2;
        } else {
            entity.var_da135442++;
        }
    } else {
        entity.var_da135442 = 1;
        function_83af9df4(entity);
    }
    entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xee142919, Offset: 0x7be0
// Size: 0x48
function private function_2469fe3a(entity) {
    if (isdefined(entity.var_da135442)) {
        return (entity.var_da135442 < entity ai::function_a0dbf10a().var_103ec1d8);
    }
    return false;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xa5878b34, Offset: 0x7c30
// Size: 0x22
function private function_a6df9944(entity) {
    return zombie_utility::is_player_valid(entity.e_grapplee);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x5d67f0ca, Offset: 0x7c60
// Size: 0x174
function private function_f6e7ee6d(entity) {
    entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
    if (isdefined(entity.e_grapplee)) {
        grapplee = entity.e_grapplee;
        var_57fa56f5 = angleclamp180(vectortoangles(entity gettagorigin("j_head") - grapplee geteye())[0]);
        var_60647724 = abs(var_57fa56f5 - 10);
        var_23bbe45f = max(var_57fa56f5 + 10, 0);
        grapplee lerpviewangleclamp(0, 0, 0, 20, 20, var_60647724, var_23bbe45f);
        grapplee util::delay(0.5, undefined, &zm_audio::create_and_play_dialog, "blight_father", "vomit");
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x453ce9a6, Offset: 0x7de0
// Size: 0x3e
function private function_15172fe6(entity) {
    grapplee = entity.e_grapplee;
    return isdefined(grapplee) && !zombie_utility::is_player_valid(grapplee);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x4798696a, Offset: 0x7e28
// Size: 0x6c
function private function_74e138ba(entity) {
    entity notify(#"hash_2fb2eddfa6a0ef3f");
    entity clientfield::set("blight_father_vomit_fx", 0);
    function_83af9df4(entity);
    entity thread function_5a2064a4();
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x3e567ba2, Offset: 0x7ea0
// Size: 0x4c
function private function_750cf649(entity) {
    function_74e138ba(entity);
    entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xf9c596c9, Offset: 0x7ef8
// Size: 0x64
function private function_4ec5a60e(entity) {
    function_74e138ba(entity);
    function_10b5404d(entity);
    entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x61fe2a1e, Offset: 0x7f68
// Size: 0x24
function private function_3e2929a1(entity) {
    function_4ec5a60e(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x11d9e13c, Offset: 0x7f98
// Size: 0x52
function private function_38961090(entity) {
    if (isdefined(entity.var_479f7721) && entity.var_479f7721 > entity ai::function_a0dbf10a().var_215061d7) {
        return true;
    }
    return false;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0xe32b363c, Offset: 0x7ff8
// Size: 0x34
function function_29d2ef52(player) {
    if (self.e_grapplee !== player) {
        return;
    }
    self ai::stun();
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x5c4693c3, Offset: 0x8038
// Size: 0xac
function private function_e2c11a35(entity) {
    grapplee = entity.e_grapplee;
    if (isdefined(grapplee)) {
        entity clientfield::set("blight_father_vomit_fx", 1);
        grapplee thread function_37f11195(entity, grapplee);
        return;
    }
    entity clientfield::set("blight_father_vomit_fx", 2);
    function_39300ba6(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0x500cb270, Offset: 0x80f0
// Size: 0x13c
function private function_37f11195(blight_father, player) {
    player endon(#"death", #"disconnect");
    player clientfield::set_to_player("blight_father_vomit_postfx_clientfield", 1);
    while (isdefined(blight_father) && isalive(blight_father) && zm_utility::is_player_valid(blight_father.e_grapplee) && blight_father.e_grapplee === player) {
        player dodamage(blight_father ai::function_a0dbf10a().var_7cc7d155, blight_father.origin, blight_father, blight_father);
        wait blight_father ai::function_a0dbf10a().var_3503b30e;
    }
    if (isdefined(player)) {
        player clientfield::set_to_player("blight_father_vomit_postfx_clientfield", 0);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xb33f037d, Offset: 0x8238
// Size: 0x44
function private function_d104e769(entity) {
    entity clientfield::set("blight_father_vomit_fx", 0);
    function_c296a58d(entity);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xf474203f, Offset: 0x8288
// Size: 0x34
function private function_2b37c755(entity) {
    entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x10a85c9, Offset: 0x82c8
// Size: 0x34
function private function_7905f242(entity) {
    entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0xa63bda14, Offset: 0x8308
// Size: 0x1fa
function private function_410cf696(entity, minplayerdist) {
    playerpositions = [];
    foreach (player in getplayers()) {
        if (!isdefined(playerpositions)) {
            playerpositions = [];
        } else if (!isarray(playerpositions)) {
            playerpositions = array(playerpositions);
        }
        if (!isinarray(playerpositions, isdefined(player.last_valid_position) ? player.last_valid_position : player.origin)) {
            playerpositions[playerpositions.size] = isdefined(player.last_valid_position) ? player.last_valid_position : player.origin;
        }
    }
    position = getclosestpointonnavmesh(entity.origin, 128, entity getpathfindingradius());
    if (!isdefined(position)) {
        return false;
    }
    pathdata = generatenavmeshpath(position, playerpositions, entity);
    if (isdefined(pathdata) && pathdata.status === "succeeded" && pathdata.pathdistance < minplayerdist) {
        return false;
    }
    return true;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 4, eflags: 0x4
// Checksum 0x89014c34, Offset: 0x8510
// Size: 0x9a
function private function_59a21e2c(entity, attribute, oldvalue, value) {
    if (!value) {
        var_4e32c3bc = zm_lockdown_util::function_13e129fe(entity);
        if (isdefined(var_4e32c3bc)) {
            zm_lockdown_util::function_26e5ad8c(var_4e32c3bc);
            entity.var_d96f278 = undefined;
            entity.b_ignore_cleanup = entity.var_249da860;
            entity.var_249da860 = undefined;
        }
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xb3002f34, Offset: 0x85b8
// Size: 0x6c2
function private function_170a26d9(entity) {
    /#
        zm_lockdown_util::function_819c89(entity);
    #/
    if (entity clientfield::get("blight_father_vomit_fx")) {
        return;
    }
    if (!entity ai::get_behavior_attribute("lockdown_enabled")) {
        return;
    }
    if (isdefined(entity.var_5d598ea6) && entity.var_5d598ea6 || zombiebehavior::zombieshouldmeleecondition(entity) || function_8ab96e0e(entity)) {
        return;
    }
    var_4e32c3bc = zm_lockdown_util::function_13e129fe(entity);
    if (isdefined(var_4e32c3bc)) {
        if (!zm_lockdown_util::function_70cf3d31(entity, var_4e32c3bc)) {
            zm_lockdown_util::function_26e5ad8c(var_4e32c3bc);
            entity.var_d96f278 = undefined;
            entity.b_ignore_cleanup = entity.var_249da860;
            entity.var_249da860 = undefined;
        }
        return;
    } else {
        entity.var_d96f278 = undefined;
    }
    if (self.var_c5a4812d > gettime()) {
        return;
    }
    stub_types = [];
    if (!isdefined(stub_types)) {
        stub_types = [];
    } else if (!isarray(stub_types)) {
        stub_types = array(stub_types);
    }
    stub_types[stub_types.size] = "lockdown_stub_type_wallbuys";
    if (!isdefined(stub_types)) {
        stub_types = [];
    } else if (!isarray(stub_types)) {
        stub_types = array(stub_types);
    }
    stub_types[stub_types.size] = "lockdown_stub_type_crafting_tables";
    if (!isdefined(stub_types)) {
        stub_types = [];
    } else if (!isarray(stub_types)) {
        stub_types = array(stub_types);
    }
    stub_types[stub_types.size] = "lockdown_stub_type_perks";
    if (!isdefined(stub_types)) {
        stub_types = [];
    } else if (!isarray(stub_types)) {
        stub_types = array(stub_types);
    }
    stub_types[stub_types.size] = "lockdown_stub_type_pap";
    if (!isdefined(stub_types)) {
        stub_types = [];
    } else if (!isarray(stub_types)) {
        stub_types = array(stub_types);
    }
    stub_types[stub_types.size] = "lockdown_stub_type_magic_box";
    var_ad671012 = zm_lockdown_util::function_6b5c9744(entity, stub_types, entity ai::function_a0dbf10a().var_c9644430, entity ai::function_a0dbf10a().var_5bcbc2d4);
    entity.var_c5a4812d = gettime() + 500;
    if (var_ad671012.size == 0) {
        return;
    }
    stub = var_ad671012[0];
    if (!function_410cf696(entity, entity ai::function_a0dbf10a().var_99cfef8)) {
        return;
    }
    var_a127dbcc = zm_lockdown_util::function_d6ef7837(entity, stub);
    if (!isdefined(var_a127dbcc)) {
        println("<dev string:x3e>" + entity getentitynumber() + "<dev string:x11c>" + stub.origin + "<dev string:x151>");
        var_c9672c88 = zm_utility::function_eb5eb205(stub.origin);
        halfheight = 32;
        if (!isdefined(var_c9672c88)) {
            var_c9672c88 = [];
            var_c9672c88[#"point"] = stub.origin;
            halfheight = (stub.origin - zm_utility::groundpos(stub.origin))[2] + 1;
        }
        var_b61e6cbf = positionquery_source_navigation(var_c9672c88[#"point"], 0, 256, halfheight, 20, 1);
        if (var_b61e6cbf.data.size == 0) {
            return;
        }
        start_origin = var_b61e6cbf.data[0].origin;
    } else {
        var_7edb7f56 = entity astsearch("purchase_lockdown_vomit@blight_father");
        animname = animationstatenetworkutility::searchanimationmap(entity, var_7edb7f56[#"animation"]);
        start_origin = getstartorigin(var_a127dbcc.origin, var_a127dbcc.angles, animname);
    }
    if (!ispointonnavmesh(start_origin, entity)) {
        /#
            if (isdefined(var_a127dbcc)) {
                zm_lockdown_util::function_a5eb496b(entity, stub, 14, start_origin, var_a127dbcc);
            }
        #/
        return;
    }
    zm_lockdown_util::function_66774b7(entity, stub);
    entity setblackboardattribute("_lockdown_type", zm_lockdown_util::function_165ef62f(stub.lockdowntype));
    entity.var_249da860 = entity.b_ignore_cleanup;
    entity.b_ignore_cleanup = 1;
    entity.var_d96f278 = start_origin;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0x2fa0db62, Offset: 0x8c88
// Size: 0x8a
function function_3b0c500f(player) {
    if (isdefined(level.var_9f315b82) && level.var_9f315b82) {
        self sethintstring(#"hash_3aa47b7b8258ebd2");
    } else {
        self sethintstring(#"hash_5ef6d21d81a0250b", 500);
    }
    return zm_lockdown_util::function_ec53c9d4(self.stub);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0xdb09f94c, Offset: 0x8d20
// Size: 0x100
function private function_b1c9fcf5() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"trigger");
        if (!isdefined(waitresult.activator) || !zm_utility::is_player_valid(waitresult.activator)) {
            continue;
        }
        player = waitresult.activator;
        if (!player zm_score::can_player_purchase(500)) {
            continue;
        }
        player zm_score::minus_to_player_score(500);
        self.stub thread zm_lockdown_util::function_403f1f1b();
        player playsoundtoplayer("zmb_powerup_vomit_cleaned", player);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x9c9f6249, Offset: 0x8e28
// Size: 0x64
function private function_42a92e2(stub) {
    if (isdefined(stub.var_4556cc11)) {
        stub thread function_5341fd7d(stub.var_4556cc11);
    }
    wait getdvarfloat(#"hash_2f19f037c4f8ddc9", 2);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x78360470, Offset: 0x8e98
// Size: 0x54
function private function_5341fd7d(model) {
    model clientfield::set("blight_father_purchase_lockdown_vomit_fx", 0);
    util::wait_network_frame();
    model delete();
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x4be83539, Offset: 0x8ef8
// Size: 0xc0
function private function_4ab9214c(entity) {
    if (isdefined(entity.var_5d598ea6) && entity.var_5d598ea6) {
        return false;
    }
    if (!zm_lockdown_util::function_e4baa0a4(entity)) {
        return false;
    }
    if (!isdefined(entity.var_d96f278)) {
        return false;
    }
    if (distancesquared(entity.var_d96f278, entity.origin) > entity ai::function_a0dbf10a().var_87b51d9d * entity ai::function_a0dbf10a().var_87b51d9d) {
        return false;
    }
    return true;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x1268c5f5, Offset: 0x8fc0
// Size: 0x242
function private function_39300ba6(entity) {
    if (zm_lockdown_util::function_e4baa0a4(entity)) {
        stub = zm_lockdown_util::function_a0ca5bc8(entity, &function_3b0c500f, &function_b1c9fcf5, &function_42a92e2);
        if (!isdefined(stub)) {
            return;
        }
        switch (stub.lockdowntype) {
        case #"lockdown_stub_type_perks":
            var_e79cb118 = 2;
            var_8c621846 = zm_lockdown_util::function_51482fb2(stub);
            break;
        case #"lockdown_stub_type_magic_box":
            var_e79cb118 = 3;
            var_8c621846 = zm_lockdown_util::function_51482fb2(stub);
            break;
        case #"lockdown_stub_type_crafting_tables":
            var_e79cb118 = 4;
            var_8c621846 = zm_lockdown_util::function_51482fb2(stub);
            break;
        case #"lockdown_stub_type_wallbuys":
            var_8c621846 = zm_lockdown_util::function_51482fb2(stub);
        default:
            var_e79cb118 = 1;
            break;
        }
        if (!isdefined(var_8c621846)) {
            v_origin = stub.origin;
            v_angles = stub.angles;
        } else {
            v_origin = var_8c621846.origin;
            v_angles = var_8c621846.angles;
        }
        stub.var_4556cc11 = function_ce7e8ac9(v_origin, v_angles);
        stub.var_4556cc11 clientfield::set("blight_father_purchase_lockdown_vomit_fx", var_e79cb118);
        entity.var_d96f278 = undefined;
        entity.b_ignore_cleanup = entity.var_249da860;
        entity.var_249da860 = undefined;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 5, eflags: 0x4
// Checksum 0x60caa072, Offset: 0x9210
// Size: 0x1fc
function private function_a931a1ee(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    stub = zm_lockdown_util::function_13e129fe(entity);
    var_a127dbcc = zm_lockdown_util::function_d6ef7837(entity, stub);
    if (isdefined(var_a127dbcc)) {
        start_origin = getstartorigin(var_a127dbcc.origin, var_a127dbcc.angles, mocompanim);
        start_angles = getstartangles(var_a127dbcc.origin, var_a127dbcc.angles, mocompanim);
    } else {
        println("<dev string:x3e>" + entity getentitynumber() + "<dev string:x4f>" + entity.origin[0] + "<dev string:x55>" + entity.origin[1] + "<dev string:x55>" + entity.origin[2] + "<dev string:x57>");
        start_origin = entity.origin;
        start_angles = entity.angles;
    }
    entity forceteleport(start_origin, start_angles);
    entity animmode("noclip", 1);
    entity orientmode("face angle", start_angles[1]);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xfcef0132, Offset: 0x9418
// Size: 0x2a
function private function_c360a7c3(entity) {
    return entity ai::function_a0dbf10a().var_82910acd;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x7946de62, Offset: 0x9450
// Size: 0x28
function private function_4ff8c972(entity) {
    return isdefined(entity.var_46d408de) && entity.var_46d408de;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x230f2591, Offset: 0x9480
// Size: 0x8c
function private function_4ceffdf4() {
    var_4527632e = 0;
    foreach (trigger in level.var_22fdd3f8) {
        if (!trigger.inuse) {
            var_4527632e++;
        }
    }
    return var_4527632e;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0x629398b3, Offset: 0x9518
// Size: 0xa8
function private function_f9ae6949() {
    foreach (trigger in level.var_22fdd3f8) {
        if (!trigger.inuse) {
            trigger.inuse = 1;
            trigger triggerenable(1);
            return trigger;
        }
    }
    return undefined;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xe84945e9, Offset: 0x95c8
// Size: 0x42
function private function_5d0bf7b0(trigger) {
    trigger.inuse = 0;
    trigger triggerenable(0);
    trigger.origin = (0, 0, 0);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x1e193489, Offset: 0x9618
// Size: 0x48
function private function_c90f51d1(entity) {
    var_7490741 = function_9c9584ce(entity);
    function_29d27bde(entity);
    return var_7490741;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x456e481d, Offset: 0x9668
// Size: 0x63c
function private function_9c9584ce(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (!isplayer(entity.favoriteenemy)) {
        return false;
    }
    if (isdefined(entity.var_65570131) && entity.var_65570131 && isdefined(entity.var_b25ccef2) && entity.var_b25ccef2) {
        return false;
    }
    if (isdefined(level.var_2e442253) && level.var_2e442253 != entity && isalive(level.var_2e442253)) {
        return false;
    }
    if (!function_4ff8c972(entity) && entity.var_d066e895 > gettime()) {
        return false;
    }
    var_87cbdebd = function_4ceffdf4();
    if (var_87cbdebd <= 0) {
        return false;
    } else if (!(isdefined(entity.var_65570131) && entity.var_65570131) && !(isdefined(entity.var_b25ccef2) && entity.var_b25ccef2) && var_87cbdebd < 3) {
        return false;
    }
    forward = anglestoforward(entity.angles);
    forward2d = vectornormalize((forward[0], forward[1], 0));
    dirtotarget = entity.favoriteenemy.origin - entity.origin;
    var_a9bdcbe8 = vectornormalize((dirtotarget[0], dirtotarget[1], 0));
    dot = vectordot(forward2d, var_a9bdcbe8);
    if (dot < entity ai::function_a0dbf10a().var_c3f77c93) {
        return false;
    }
    test_trace = function_5eb4ae08(entity, entity.favoriteenemy);
    if (test_trace[#"fraction"] < 1 && test_trace[#"entity"] !== entity.favoriteenemy) {
        return false;
    }
    height = self.maxs[2] - self.mins[2];
    forward = anglestoforward(self.angles);
    var_3abedd48 = forward * entity ai::function_a0dbf10a().var_5140eb92;
    var_dbc1dea7 = bullettracepassed(self.origin + (0, 0, height), self.origin + var_3abedd48 + (0, 0, height + entity ai::function_a0dbf10a().var_bbb2bd4e), 0, self);
    /#
        recordline(self.origin + (0, 0, height), self.origin + var_3abedd48 + (0, 0, height + entity ai::function_a0dbf10a().var_bbb2bd4e), (0, 1, 0));
    #/
    if (var_dbc1dea7) {
        var_61fe103d = forward * entity ai::function_a0dbf10a().var_e0402f6f;
        var_dbc1dea7 = bullettracepassed(self.origin + var_3abedd48 + (0, 0, height + entity ai::function_a0dbf10a().var_bbb2bd4e), self.origin + var_61fe103d + (0, 0, height + entity ai::function_a0dbf10a().var_bbb2bd4e), 0, self);
        /#
            recordline(self.origin + var_3abedd48 + (0, 0, height + entity ai::function_a0dbf10a().var_bbb2bd4e), self.origin + var_61fe103d + (0, 0, height + entity ai::function_a0dbf10a().var_bbb2bd4e), (0, 1, 0));
        #/
    }
    if (!var_dbc1dea7) {
        return false;
    }
    var_442435e2 = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (var_442435e2 < entity ai::function_a0dbf10a().var_ca28dbef * entity ai::function_a0dbf10a().var_ca28dbef || var_442435e2 > entity ai::function_a0dbf10a().var_5f2b6691 * entity ai::function_a0dbf10a().var_5f2b6691) {
        return false;
    }
    return true;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x31ec076, Offset: 0x9cb0
// Size: 0x2c
function private function_1cd2c5c2(entity) {
    entity clientfield::set("blight_father_amb_sac_clientfield", 0);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x119744ef, Offset: 0x9ce8
// Size: 0x5c
function private function_67a410e9(entity) {
    entity.var_d066e895 = gettime() + function_c360a7c3(entity);
    level.var_2e442253 = undefined;
    entity clientfield::set("blight_father_amb_sac_clientfield", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xb591f297, Offset: 0x9d50
// Size: 0x94
function private function_6e462994(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        println("<dev string:x172>");
        return;
    }
    entity clientfield::increment("blight_father_spawn_maggot_fx_left");
    entity thread blightfatherlaunchchaosmissile(entity.favoriteenemy, (0, 0, 5), "tag_sac_fx_le");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x46abd786, Offset: 0x9df0
// Size: 0x94
function private function_5e0cf4cb(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        println("<dev string:x172>");
        return;
    }
    entity clientfield::increment("blight_father_spawn_maggot_fx_right");
    entity thread blightfatherlaunchchaosmissile(entity.favoriteenemy, (0, 0, 5), "tag_sac_fx_ri");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0xa4580daa, Offset: 0x9e90
// Size: 0x4c
function private function_5bec6fd() {
    self endon(#"death");
    util::wait_network_frame();
    self clientfield::set("blight_father_maggot_trail_fx", 1);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 3, eflags: 0x4
// Checksum 0x20e0bfb3, Offset: 0x9ee8
// Size: 0x540
function private blightfatherlaunchchaosmissile(var_35c794d2, var_e9f82448, var_26459ad5) {
    var_901beb29 = self gettagorigin(var_26459ad5);
    var_c87db491 = var_35c794d2.origin + var_e9f82448;
    if (isdefined(self.var_46d408de) && self.var_46d408de) {
        self.var_46d408de = 0;
    }
    var_d3068d2a = util::spawn_model(#"tag_origin", var_901beb29);
    var_742b5db7 = function_f9ae6949();
    var_742b5db7.origin = var_d3068d2a.origin;
    var_742b5db7.angles = var_d3068d2a.angles;
    var_742b5db7 linkto(var_d3068d2a, "tag_origin");
    var_d3068d2a.trigger = var_742b5db7;
    var_d3068d2a thread function_2bac740a(self ai::function_a0dbf10a().var_79b264e3);
    var_d3068d2a thread function_5bec6fd();
    var_d3068d2a thread function_4f37a7c3(var_742b5db7);
    var_d3068d2a.var_a20afc82 = 0;
    var_d3068d2a.var_78888d81 = self;
    angles_to_enemy = self gettagangles(var_26459ad5);
    normal_vector = anglestoforward(angles_to_enemy);
    var_d3068d2a.angles = angles_to_enemy;
    var_d3068d2a.var_41c69ef0 = normal_vector * self ai::function_a0dbf10a().var_4c50dd47;
    max_trail_iterations = int(self ai::function_a0dbf10a().var_5f2b6691 / self ai::function_a0dbf10a().var_1f49e373 * self ai::function_a0dbf10a().var_e990e9fd);
    var_d3068d2a.missile_target = var_35c794d2;
    var_d3068d2a thread function_fd459a50(var_e9f82448, 96);
    var_d3068d2a playloopsound(#"hash_5b21b7c645692f8", 0.1);
    var_d3068d2a moveto(self gettagorigin(var_26459ad5) + var_e9f82448, self ai::function_a0dbf10a().var_8c3221ba);
    var_4452e7aa = self ai::function_a0dbf10a().var_e990e9fd;
    var_e6ae3988 = self ai::function_a0dbf10a().var_2c02f1ea;
    var_bb93319a = self ai::function_a0dbf10a().var_1f49e373;
    wait self ai::function_a0dbf10a().var_8c3221ba;
    while (isdefined(var_d3068d2a)) {
        if (!zombie_utility::is_player_valid(var_d3068d2a.missile_target, 1)) {
            var_d3068d2a.missile_target = undefined;
            players = getplayers();
            players = arraysortclosest(players, var_d3068d2a.origin);
            foreach (player in players) {
                if (zombie_utility::is_player_valid(player, 1)) {
                    var_d3068d2a.missile_target = player;
                    break;
                }
            }
        }
        if (var_d3068d2a.var_a20afc82 >= max_trail_iterations) {
            var_d3068d2a thread function_b39cca31(0);
        } else {
            var_d3068d2a function_ea231b0a(var_bb93319a, var_e6ae3988, var_4452e7aa);
            var_d3068d2a.var_a20afc82 += 1;
        }
        wait var_4452e7aa;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0xeeca072f, Offset: 0xa430
// Size: 0x4c
function function_4f37a7c3(var_c6ca9695) {
    self waittill(#"death");
    var_c6ca9695 unlink();
    function_5d0bf7b0(var_c6ca9695);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0x7bb7ca88, Offset: 0xa488
// Size: 0xdc
function function_2bac740a(starting_health) {
    self endon(#"detonated");
    self.n_health = starting_health;
    while (self.n_health > 0) {
        s_notify = self.trigger waittill(#"damage");
        if (isdefined(s_notify.attacker) && isplayer(s_notify.attacker) && s_notify.amount > 0) {
            self.n_health -= s_notify.amount;
        }
    }
    self thread function_b39cca31(0);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 4, eflags: 0x4
// Checksum 0x5edd5f6a, Offset: 0xa570
// Size: 0x10e
function private function_3ec5e3d3(forward_dir, var_901beb29, var_c87db491, max_angle) {
    vec_to_enemy = var_c87db491 - var_901beb29;
    vec_to_enemy_normal = vectornormalize(vec_to_enemy);
    angle_to_enemy = vectordot(forward_dir, vec_to_enemy_normal);
    if (angle_to_enemy >= max_angle) {
        return vec_to_enemy_normal;
    }
    plane_normal = vectorcross(forward_dir, vec_to_enemy_normal);
    perpendicular_normal = vectorcross(plane_normal, forward_dir);
    var_3b1746a6 = forward_dir * cos(max_angle) + perpendicular_normal * sin(max_angle);
    return var_3b1746a6;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 2, eflags: 0x4
// Checksum 0xfc2c2233, Offset: 0xa688
// Size: 0x18e
function private function_fd459a50(var_e9f82448, var_a900abe9) {
    self endon(#"death", #"detonated");
    var_d3068d2a = self;
    while (isdefined(var_d3068d2a)) {
        player_origins = [];
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player_origins)) {
                player_origins = [];
            } else if (!isarray(player_origins)) {
                player_origins = array(player_origins);
            }
            player_origins[player_origins.size] = player.origin + var_e9f82448;
        }
        players = arraysortclosest(player_origins, var_d3068d2a.origin, undefined, 0, var_a900abe9);
        if (players.size > 0) {
            var_d3068d2a thread function_b39cca31(0);
        }
        waitframe(1);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 3, eflags: 0x4
// Checksum 0x9f3fb22b, Offset: 0xa820
// Size: 0x394
function private function_ea231b0a(var_bb93319a, var_1a05784d, var_4452e7aa) {
    self endon(#"detonated", #"death");
    if (!isdefined(self.var_5d20f001)) {
        self.var_5d20f001 = cos(var_1a05784d * var_4452e7aa);
    }
    if (isdefined(self.missile_target) && isdefined(self.var_41c69ef0)) {
        var_d59b7fb9 = self.missile_target getcentroid();
        if (isplayer(self.missile_target)) {
            var_d59b7fb9 = self.missile_target getplayercamerapos();
        }
        vector_to_target = var_d59b7fb9 - self.origin;
        normal_vector = vectornormalize(vector_to_target);
        dot = vectordot(normal_vector, self.var_41c69ef0);
        if (dot >= 1) {
            dot = 1;
        } else if (dot <= -1) {
            dot = -1;
        }
        new_vector = normal_vector - self.var_41c69ef0;
        angle_between_vectors = acos(dot);
        if (!isdefined(angle_between_vectors)) {
            angle_between_vectors = 180;
        }
        if (angle_between_vectors == 0) {
            angle_between_vectors = 0.0001;
        }
        ratio = var_1a05784d * var_4452e7aa / angle_between_vectors;
        if (ratio > 1) {
            ratio = 1;
        }
        new_vector *= ratio;
        new_vector += self.var_41c69ef0;
        normal_vector = vectornormalize(new_vector);
    } else {
        normal_vector = self.var_41c69ef0;
    }
    move_distance = var_bb93319a * var_4452e7aa;
    move_vector = var_bb93319a * var_4452e7aa * normal_vector;
    move_to_point = self.origin + move_vector;
    trace = bullettrace(self.origin, move_to_point, 0, self);
    if (trace[#"surfacetype"] !== "none") {
        detonate_point = trace[#"position"];
        dist_sq = distancesquared(detonate_point, self.origin);
        move_dist_sq = move_distance * move_distance;
        ratio = dist_sq / move_dist_sq;
        delay = ratio * var_4452e7aa;
        self thread function_b39cca31(delay);
    }
    self.var_41c69ef0 = normal_vector;
    self moveto(move_to_point, var_4452e7aa);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0xdc129887, Offset: 0xabc0
// Size: 0x224
function private function_b39cca31(delay) {
    if (!isdefined(self)) {
        return;
    }
    var_d3068d2a = self;
    missile_owner = var_d3068d2a.var_78888d81;
    blast_radius = 128;
    var_cd631910 = 45;
    var_51766817 = 40;
    var_d1f26848 = 96 * 96;
    if (delay > 0) {
        wait delay;
    }
    if (isdefined(var_d3068d2a)) {
        var_d3068d2a notify(#"detonated");
        var_d3068d2a moveto(var_d3068d2a.origin, 0.05);
        var_d3068d2a clientfield::set("blight_father_chaos_missile_explosion_clientfield", 1);
        e_blightfather = var_d3068d2a.var_78888d81;
        w_weapon = getweapon(#"none");
        var_d3068d2a function_a86a319b(var_d1f26848, e_blightfather, w_weapon);
        explosion_point = var_d3068d2a.origin;
        function_57da30c3(explosion_point + (0, 0, 18));
        util::wait_network_frame();
        radiusdamage(explosion_point + (0, 0, 18), blast_radius, var_cd631910, var_51766817, e_blightfather, "MOD_UNKNOWN", w_weapon);
        if (isdefined(var_d3068d2a)) {
            var_d3068d2a clientfield::set("blight_father_maggot_trail_fx", 0);
            var_d3068d2a delete();
        }
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x4
// Checksum 0x61dc13b1, Offset: 0xadf0
// Size: 0x23e
function private function_57da30c3(var_3bac7237) {
    players = getplayers();
    v_length = 100 * 100;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!isalive(player)) {
            continue;
        }
        if (player.sessionstate == "spectator") {
            continue;
        }
        if (player.sessionstate == "intermission") {
            continue;
        }
        if (isdefined(player.ignoreme) && player.ignoreme) {
            continue;
        }
        if (player isnotarget()) {
            continue;
        }
        n_distance = distance2dsquared(var_3bac7237, player.origin);
        if (n_distance < 0.01) {
            continue;
        }
        if (n_distance < v_length) {
            v_dir = player.origin - var_3bac7237;
            v_dir = (v_dir[0], v_dir[1], 0.1);
            v_dir = vectornormalize(v_dir);
            n_push_strength = getdvarint(#"hash_708ca0a943843f57", 500);
            n_push_strength = 200 + randomint(n_push_strength - 200);
            v_player_velocity = player getvelocity();
            player setvelocity(v_player_velocity + v_dir * n_push_strength);
        }
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 3, eflags: 0x4
// Checksum 0xd5fc7fa2, Offset: 0xb038
// Size: 0x126
function private function_a86a319b(var_d1f26848, blight_father, weapon) {
    for (i = 0; i < level.activeplayers.size; i++) {
        distancesq = distancesquared(self.origin, level.activeplayers[i].origin + (0, 0, 48));
        if (distancesq > var_d1f26848) {
            continue;
        }
        status_effect = getstatuseffect(#"hash_7867f8f9aaaa0c40");
        level.activeplayers[i] status_effect::status_effect_apply(status_effect, weapon, blight_father);
        level.activeplayers[i] clientfield::increment_to_player("blight_father_chaos_missile_rumble_clientfield", 1);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xb5634195, Offset: 0xb168
// Size: 0x60
function function_c202e7e3() {
    level.var_edb9001e++;
    level.zombie_ai_limit--;
    self waittill(#"death");
    level.var_edb9001e--;
    level.zombie_ai_limit++;
    level notify(#"hash_5fb3aa7a0745af2c");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xd0b5d5b9, Offset: 0xb1d0
// Size: 0x20a
function function_652d2382() {
    if (!self zm_ai_utility::function_4f5236d3()) {
        return false;
    }
    if (isdefined(level.var_28d1499a) && level.var_28d1499a) {
        return false;
    }
    if (isdefined(level.var_595dcfa9) && level.var_595dcfa9) {
        return true;
    }
    if (isdefined(self.var_8c40dbcb) && self.var_8c40dbcb > gettime()) {
        return false;
    }
    var_6ad1d636 = 0;
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        if (distancesquared(player.origin, self.origin) < 16384) {
            continue;
        }
        if (distancesquared(player.origin, self.origin) > 102400) {
            continue;
        }
        var_6ad1d636 = self sightconetrace(player.origin, player, anglestoforward(player.angles));
        var_b74eb4e4 = 1;
        if (isdefined(level.var_b99001e6)) {
            var_b74eb4e4 = self [[ level.var_b99001e6 ]]();
        }
        if (var_6ad1d636 && var_b74eb4e4) {
            break;
        }
    }
    return var_6ad1d636 && var_b74eb4e4;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0x2e150872, Offset: 0xb3e8
// Size: 0x12
function function_e2733ab6() {
    self.b_ignore_cleanup = 1;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0xa781d9fe, Offset: 0xb408
// Size: 0xc
function function_7da5b515(n_health_percent) {
    
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0x15cac804, Offset: 0xb420
// Size: 0xda
function function_938eb359(n_round_number) {
    level endon(#"end_game");
    if (!isdefined(level.var_7df60299)) {
        level.var_7df60299 = 0;
    }
    while (true) {
        level waittill(#"hash_5d3012139f083ccb");
        if (zm_round_spawning::function_f172115b("blight_father") && !(isdefined(level.var_28d1499a) && level.var_28d1499a)) {
            level.var_7df60299++;
            level.var_427c4c08 = level.round_number + randomintrangeinclusive(3, 5);
        }
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 1, eflags: 0x0
// Checksum 0x30ae76ad, Offset: 0xb508
// Size: 0x252
function function_55404471(var_e14d9cae) {
    forced = zm_trial_force_archetypes::function_64eeba9b("blight_father");
    var_13385fd5 = int(floor(var_e14d9cae / 300));
    if (isdefined(level.var_427c4c08) && level.round_number < level.var_427c4c08 && !forced) {
        return 0;
    }
    var_9a3561d4 = 0;
    var_c33c4ac6 = 1;
    if (forced) {
        var_9a3561d4 = 1;
    }
    if (level.players.size == 1) {
        switch (level.var_7df60299) {
        case 0:
        case 1:
        case 2:
            break;
        default:
            var_9a3561d4 = 1;
            break;
        }
    } else {
        switch (level.var_7df60299) {
        case 0:
            break;
        case 1:
            var_c33c4ac6 = 2;
            break;
        case 2:
            var_c33c4ac6 = 3;
            break;
        case 3:
            var_9a3561d4 = 1;
            var_c33c4ac6 = 3;
            break;
        case 4:
            var_9a3561d4 = 2;
            var_c33c4ac6 = 3;
            break;
        default:
            var_9a3561d4 = 3;
            var_c33c4ac6 = 3;
            break;
        }
    }
    return randomintrangeinclusive(var_9a3561d4, int(min(var_13385fd5, var_c33c4ac6)));
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xdb53ad56, Offset: 0xb768
// Size: 0x7a
function function_204321d3() {
    var_5c5e8351 = function_2a3c5b5b();
    var_55147a = function_91f7d400();
    if (var_5c5e8351 >= var_55147a || !level flag::get("spawn_zombies")) {
        return false;
    }
    return true;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xbac7b33e, Offset: 0xb7f0
// Size: 0xdc
function function_2a3c5b5b() {
    a_ai_blight_father = getaiarchetypearray("blight_father");
    a_ai_blight_father = array::remove_dead(a_ai_blight_father);
    var_f4e3daa = a_ai_blight_father.size;
    if (isarray(level.var_deb579ca) && isdefined(level.var_deb579ca[#"blight_father"]) && isdefined(level.var_deb579ca[#"blight_father"].var_39491bdc)) {
        var_f4e3daa += level.var_deb579ca[#"blight_father"].var_39491bdc;
    }
    return var_f4e3daa;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xb9b12ff2, Offset: 0xb8d8
// Size: 0x9a
function function_91f7d400() {
    switch (level.players.size) {
    case 1:
        return 1;
    case 2:
        return 3;
    case 3:
        return 3;
    case 4:
        return 3;
    default:
        return 3;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xe9bc4255, Offset: 0xb980
// Size: 0x8e
function round_spawn() {
    /#
        blight_father_spawners = getspawnerarray("<dev string:x1b1>", "<dev string:x1ce>");
        if (blight_father_spawners.size == 0) {
            iprintln("<dev string:x1e0>");
            return;
        }
    #/
    if (function_204321d3()) {
        zm_transform::function_5dbbf742("blight_father");
    }
    return 0;
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x4
// Checksum 0xaf330135, Offset: 0xba18
// Size: 0x90
function private function_19175da1() {
    spawners = getspawnerarray("zombie_blight_father_spawner", "script_noteworthy");
    assert(spawners.size > 0);
    new_ai = spawners[0] spawnfromspawner(0, 1);
    new_ai zm_transform::function_b028c09b();
    return true;
}

/#

    // Namespace zm_ai_blight_father/zm_ai_blight_father
    // Params 1, eflags: 0x4
    // Checksum 0xf03acbb8, Offset: 0xbab0
    // Size: 0x8a
    function private function_5f75543b(part_name) {
        foreach (weakpoint in self.var_c226046d) {
            if (weakpoint.var_eaec3e95 == part_name) {
                return weakpoint;
            }
        }
    }

    // Namespace zm_ai_blight_father/zm_ai_blight_father
    // Params 1, eflags: 0x4
    // Checksum 0x56d6f5b7, Offset: 0xbb48
    // Size: 0x178
    function private function_a27345a3(hittag) {
        enemies = getaiarchetypearray("<dev string:x30>");
        foreach (enemy in enemies) {
            if (isalive(enemy)) {
                var_b750d1c8 = namespace_9088c704::function_fc6ac723(enemy, hittag);
                if (!isdefined(var_b750d1c8)) {
                    return;
                } else if (namespace_9088c704::function_4abac7be(var_b750d1c8) != 1) {
                    continue;
                }
                enemy function_a505a12(level.players[0], level.players[0], var_b750d1c8.maxhealth, undefined, undefined, level.players[0] getcurrentweapon(), level.players[0].origin, undefined, undefined, 0, hittag);
            }
        }
    }

    // Namespace zm_ai_blight_father/zm_ai_blight_father
    // Params 1, eflags: 0x4
    // Checksum 0x4d70379e, Offset: 0xbcc8
    // Size: 0xde
    function private function_cb6fcfc5(blight_father) {
        if (isdefined(level.var_35b4de45)) {
            return;
        }
        foreach (var_b750d1c8 in namespace_9088c704::function_6c1699d5(blight_father)) {
            adddebugcommand("<dev string:x200>" + var_b750d1c8.var_778c0469 + "<dev string:x236>" + var_b750d1c8.var_778c0469 + "<dev string:x269>");
        }
        level.var_35b4de45 = 1;
    }

    // Namespace zm_ai_blight_father/zm_ai_blight_father
    // Params 0, eflags: 0x4
    // Checksum 0x73d76a50, Offset: 0xbdb0
    // Size: 0x420
    function private function_17c8b975() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x26c>");
        adddebugcommand("<dev string:x2bb>");
        adddebugcommand("<dev string:x30c>");
        adddebugcommand("<dev string:x362>");
        adddebugcommand("<dev string:x3df>");
        adddebugcommand("<dev string:x449>");
        while (true) {
            waitframe(1);
            string = getdvarstring(#"hash_1999cec56042c9de", "<dev string:x4b6>");
            cmd = strtok(string, "<dev string:x55>");
            if (cmd.size > 0) {
                switch (cmd[0]) {
                case #"spawn":
                    function_8f3648e4();
                    break;
                case #"kill":
                    function_433042de();
                    break;
                case #"destroy_weakpoint":
                    function_a27345a3(cmd[1]);
                    break;
                case #"debug_purchase_lockdown":
                    setdvar(#"hash_3ec02cda135af40f", !getdvarint(#"hash_3ec02cda135af40f", 0));
                    break;
                case #"debug_dmg":
                    level.var_643255b = !(isdefined(level.var_643255b) && level.var_643255b);
                    break;
                case #"hash_3170107749934609":
                    foreach (blight_father in getaiarchetypearray("<dev string:x30>")) {
                        blight_father ai::set_behavior_attribute("<dev string:x4b7>", !blight_father ai::get_behavior_attribute("<dev string:x4b7>"));
                    }
                    break;
                case #"toggle_lockdown":
                    foreach (blight_father in getaiarchetypearray("<dev string:x30>")) {
                        blight_father ai::set_behavior_attribute("<dev string:x4cb>", !blight_father ai::get_behavior_attribute("<dev string:x4cb>"));
                    }
                    break;
                default:
                    if (isdefined(level.var_5d6efcf7)) {
                        [[ level.var_5d6efcf7 ]](cmd);
                    }
                    break;
                }
            }
            setdvar(#"hash_1999cec56042c9de", "<dev string:x4b6>");
        }
    }

    // Namespace zm_ai_blight_father/zm_ai_blight_father
    // Params 0, eflags: 0x4
    // Checksum 0x5193d702, Offset: 0xc1d8
    // Size: 0xae
    function private function_c409b190() {
        player = getplayers()[0];
        queryresult = positionquery_source_navigation(player.origin, 128, 256, 128, 20);
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            return queryresult.data[0];
        }
        return {#origin:player.origin};
    }

    // Namespace zm_ai_blight_father/zm_ai_blight_father
    // Params 0, eflags: 0x4
    // Checksum 0x51749549, Offset: 0xc290
    // Size: 0x12c
    function private function_8f3648e4() {
        blight_father_spawners = getspawnerarray("<dev string:x1b1>", "<dev string:x1ce>");
        spawn_point = function_c409b190();
        if (blight_father_spawners.size == 0) {
            iprintln("<dev string:x1e0>");
            return;
        }
        blight_father_spawners[0].script_forcespawn = 1;
        entity = zombie_utility::spawn_zombie(blight_father_spawners[0], undefined, spawn_point);
        if (!isdefined(entity)) {
            return;
        }
        if (!isdefined(spawn_point.angles)) {
            angles = (0, 0, 0);
        } else {
            angles = spawn_point.angles;
        }
        entity zm_transform::function_b028c09b();
        entity forceteleport(spawn_point.origin, angles);
    }

    // Namespace zm_ai_blight_father/zm_ai_blight_father
    // Params 0, eflags: 0x4
    // Checksum 0x9b0a6692, Offset: 0xc3c8
    // Size: 0xb8
    function private function_433042de() {
        enemies = getaiarchetypearray("<dev string:x30>");
        foreach (enemy in enemies) {
            if (isalive(enemy)) {
                enemy kill();
            }
        }
    }

#/
