#using script_2c5daa95f8fec03c;
#using script_36f4be19da8eb6d0;
#using script_3819e7a1427df6d2;
#using script_3d3c03b88e16a244;
#using scripts\core_common\aat_shared;
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
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_88795f45;

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x6
// Checksum 0xe7295a75, Offset: 0x558
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_338a74f5c94ba66a", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x8c50bc6f, Offset: 0x5b0
// Size: 0x2f4
function private function_70a657d8() {
    registerbehaviorscriptfunctions();
    /#
        execdevgui("<dev string:x38>");
        level thread function_e96e00cc();
    #/
    spawner::add_archetype_spawn_function(#"hash_7c0d83ac1e845ac2", &function_7ec99c76);
    spawner::function_89a2cd87(#"hash_7c0d83ac1e845ac2", &function_cf0706a7);
    clientfield::register("actor", "steiner_radiation_aura_clientfield", 1, 1, "int");
    clientfield::register("actor", "steiner_radiation_bomb_prepare_fire_clientfield", 1, 1, "int");
    clientfield::register("scriptmover", "radiation_bomb_play_landed_fx", 1, 2, "int");
    clientfield::register("actor", "steiner_split_combine_fx_clientfield", 1, 1, "int");
    callback::on_actor_killed(&function_f26fe009);
    callback::on_actor_damage(&function_61e1c2a1);
    callback::on_player_damage(&function_bc9fe637);
    zm_utility::function_d0f02e71(#"hash_7c0d83ac1e845ac2");
    zm_cleanup::function_cdf5a512(#"hash_7c0d83ac1e845ac2", &function_99c14949);
    zm_round_spawning::register_archetype(#"hash_7c0d83ac1e845ac2", &function_f4788553, &round_spawn, undefined, 100);
    zm_round_spawning::function_306ce518(#"hash_7c0d83ac1e845ac2", &function_3ced6468);
    zm::function_84d343d(#"hash_2b47921791da6f0", &function_7709f2df);
    zm::function_84d343d(#"hash_67307aa00ad6f686", &function_7ff0ce68);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x8b0
// Size: 0x4
function private postinit() {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0xf51bc722, Offset: 0x8c0
// Size: 0x15dc
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_7a893a7));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7280253b8045f3aa", &function_7a893a7);
    assert(isscriptfunctionptr(&function_e6d0f1d4));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_25f6a58aa44b9b2a", &function_e6d0f1d4);
    assert(isscriptfunctionptr(&function_b46c0796));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_79642ea6dc02eebd", &function_b46c0796);
    assert(isscriptfunctionptr(&function_15c1e3df));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ad94e79dd5192", &function_15c1e3df);
    assert(isscriptfunctionptr(&function_b52cb76c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4cc6cc5dc62bf114", &function_b52cb76c);
    assert(isscriptfunctionptr(&function_e9e122fa));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_154f7a6870ab70d2", &function_e9e122fa);
    assert(isscriptfunctionptr(&function_7cac529b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7d62ea78150d61ab", &function_7cac529b);
    assert(isscriptfunctionptr(&function_29744716));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a17e3794c739769", &function_29744716);
    assert(isscriptfunctionptr(&function_52479a49));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4f21279adbfeb5c6", &function_52479a49);
    assert(isscriptfunctionptr(&function_dcac38af));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ada226476fbbc5a", &function_dcac38af);
    assert(isscriptfunctionptr(&function_efc7dca5));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4db554ff25b3f605", &function_efc7dca5);
    assert(isscriptfunctionptr(&function_e6b7aa9d));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_50a4fe24c23b6d27", &function_e6b7aa9d);
    assert(isscriptfunctionptr(&function_dab44559));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_23c568af83b67b77", &function_dab44559);
    assert(isscriptfunctionptr(&function_2745a754));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34d3f0d3d41d76e5", &function_2745a754);
    assert(isscriptfunctionptr(&function_5142fcce));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e44bc48a1f81235", &function_5142fcce);
    assert(isscriptfunctionptr(&function_4b261274));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2a396809551c1af9", &function_4b261274);
    assert(isscriptfunctionptr(&function_f9eee290));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4b68c168ade3461c", &function_f9eee290);
    assert(isscriptfunctionptr(&function_baffe829));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1146baaf761ec6ed", &function_baffe829);
    assert(isscriptfunctionptr(&function_fe1e617c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57c7c778e27ffa59", &function_fe1e617c);
    assert(isscriptfunctionptr(&function_4245d56f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_98b56eef8e28325", &function_4245d56f);
    assert(isscriptfunctionptr(&function_45fabe41));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1658d524a973ce91", &function_45fabe41);
    assert(isscriptfunctionptr(&function_99608cba));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a163703acd2ed3f", &function_99608cba);
    assert(isscriptfunctionptr(&function_779b5a9));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2bb826405d693ccb", &function_779b5a9);
    assert(isscriptfunctionptr(&function_363c063));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_f175e396e0073c6", &function_363c063);
    assert(isscriptfunctionptr(&function_380fc4a5));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4f54754f71b9dd6e", &function_380fc4a5);
    assert(isscriptfunctionptr(&function_545f48af));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_305325825d9f1ae9", &function_545f48af);
    assert(isscriptfunctionptr(&function_42d0830a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_188114dd969b5dd5", &function_42d0830a);
    assert(isscriptfunctionptr(&function_5c25cce9));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_79093a39082de682", &function_5c25cce9);
    assert(isscriptfunctionptr(&function_5070830c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4544909102899fea", &function_5070830c);
    assert(isscriptfunctionptr(&function_d33f94e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_170557ad6e763f0c", &function_d33f94e);
    assert(isscriptfunctionptr(&function_4b63f114));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5676e5630fdedd2c", &function_4b63f114);
    assert(isscriptfunctionptr(&function_46e10c70));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7cb881b920ccf02e", &function_46e10c70);
    assert(isscriptfunctionptr(&function_d778b630));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e786509dc63e8d5", &function_d778b630);
    assert(isscriptfunctionptr(&function_a14fcce8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ce32e790014a59", &function_a14fcce8);
    assert(isscriptfunctionptr(&function_3bdb520f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_dd673574a092994", &function_3bdb520f);
    assert(isscriptfunctionptr(&function_2154581b));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_604e4765f2e53c69", &function_2154581b);
    assert(isscriptfunctionptr(&function_7b89edb0));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4a436c24681915c9", &function_7b89edb0);
    assert(isscriptfunctionptr(&function_8e782bd8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e8af19176b18981", &function_8e782bd8);
    assert(isscriptfunctionptr(&function_850378bc));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_f99aa9fd7ca1763", &function_850378bc);
    assert(isscriptfunctionptr(&function_c9181afb));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_d426e2923cd605f", &function_c9181afb);
    assert(isscriptfunctionptr(&function_bf6d273f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6e9c0fd10ee65237", &function_bf6d273f);
    assert(isscriptfunctionptr(&function_bd9179c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1122d04b4a1feb63", &function_bd9179c);
    assert(isscriptfunctionptr(&function_13f6d246));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_136f063162bf4aa2", &function_13f6d246);
    assert(isscriptfunctionptr(&function_e37d4e19));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_24bc3164c6e2d00a", &function_e37d4e19);
    assert(isscriptfunctionptr(&function_553ec0ae));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6e07bf77046e74de", &function_553ec0ae);
    assert(isscriptfunctionptr(&function_f60a1f74));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_789e829d5e75ebb6", &function_f60a1f74);
    assert(isscriptfunctionptr(&function_9397dd2f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_29e39b41a2ae57c6", &function_9397dd2f);
    assert(isscriptfunctionptr(&function_d5e64bba));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_696fd459823b4d1c", &function_d5e64bba);
    assert(isscriptfunctionptr(&function_6fc64eed));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72b6cfe3e9c93972", &function_6fc64eed);
    assert(isscriptfunctionptr(&function_6254c264));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_52b10d159b214f3d", &function_6254c264);
    assert(isscriptfunctionptr(&function_e5ef0d0d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_375d2172d1ccc231", &function_e5ef0d0d);
    assert(isscriptfunctionptr(&function_e456ad9b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78f3493bbe2fc0a6", &function_e456ad9b);
    animationstatenetwork::registernotetrackhandlerfunction("steiner_blast_fire", &function_46f4d406);
    animationstatenetwork::registernotetrackhandlerfunction("steiner_bomb_fire", &function_fc9189dd);
    assert(isscriptfunctionptr(&function_829cfcc8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3bd518a057cb317c", &function_829cfcc8);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x199fdd12, Offset: 0x1ea8
// Size: 0x42c
function function_7ec99c76() {
    self.no_gib = 1;
    self.instakill_func = &zm_powerups::function_16c2586a;
    self.zombie_move_speed = "walk";
    self.cant_move_cb = &zombiebehavior::function_79fe956f;
    self.allowdeath = 1;
    self.variant_type = 0;
    self.var_126d7bef = 1;
    self.ignore_round_spawn_failsafe = 1;
    self.var_f0d59f6d = 0;
    self.var_216935f8 = 1;
    if (!isdefined(self.var_9fde8624) || self function_ba878b50() || self.var_9fde8624 === #"hash_5605f3a585b3ef9f") {
        self.var_53bac70d = 1;
    }
    if (!isdefined(self.var_9fde8624) || self function_3758a4e7() || self.var_9fde8624 === #"hash_5605f3a585b3ef9f") {
        self.var_22b8f534 = 1;
    }
    if (!isdefined(self.var_9fde8624) || self.var_9fde8624 === #"hash_5605f3a585b3ef9f") {
        self.var_8d1d18aa = 1;
    }
    self.var_3ad8ef86 = 0;
    self.var_b52fc691 = 0;
    self.var_fcca372 = 0;
    if (!isdefined(self.ai)) {
        self.ai = spawnstruct();
    }
    self.ai.var_a02f86e7 = 0;
    self.ai.var_5dc77566 = 0;
    self.ai.var_b13e6817 = 0;
    self.ai.var_76786d9c = 0;
    self.ai.var_fad877bf = 0;
    self.ai.var_2642a09b = 0;
    self.ai.var_a29f9a91 = 0;
    self.ai.var_8c90ae8e = 0;
    self.ai.var_bb06b848 = 1;
    self.ai.var_e875a95c = 0;
    self.ai.var_e93366a = 0;
    self.ai.var_a49798e7 = 0;
    self.ai.var_3dbed9a0 = 0;
    self.ai.var_b90dccd6 = 0;
    self.ai.var_62741bfb = 0;
    if (is_true(self.var_22b8f534) && !isdefined(level.var_879dbfb8)) {
        level.var_879dbfb8 = 0;
    }
    self.var_b077b73d = &function_b077b73d;
    self.var_fe72f961 = &function_617dea8a;
    aiutility::addaioverridedamagecallback(self, &function_4e005f8f);
    zm_score::function_e5d6e6dd(#"hash_7c0d83ac1e845ac2", 60);
    self zm_score::function_82732ced();
    self zm_powerup_nuke::function_9a79647b(0.5);
    level thread zm_spawner::zombie_death_event(self);
    self thread function_ed79082a();
    if (getdvarint(#"hash_7bb1af7c8592abdf", 0)) {
        self function_5ac86e25();
    }
    if (self function_6b87eed1()) {
        self thread function_3c494a14();
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0xa2c665b5, Offset: 0x22e0
// Size: 0x1c
function function_cf0706a7() {
    namespace_81245006::initweakpoints(self);
}

/#

    // Namespace namespace_88795f45/namespace_88795f45
    // Params 0, eflags: 0x4
    // Checksum 0x649bc2ef, Offset: 0x2308
    // Size: 0x7c
    function private function_e96e00cc() {
        if (isarchetypeloaded(#"hash_7c0d83ac1e845ac2")) {
            level flag::wait_till("<dev string:x5a>");
            zm_devgui::add_custom_devgui_callback(&function_15677aa0);
            function_1d9f7b18();
        }
    }

    // Namespace namespace_88795f45/namespace_88795f45
    // Params 0, eflags: 0x4
    // Checksum 0xe661d5cc, Offset: 0x2390
    // Size: 0x6c
    function private function_1d9f7b18() {
        if (is_true(level.var_a4fe61a4)) {
            return;
        }
        adddebugcommand("<dev string:x76>");
        adddebugcommand("<dev string:xab>");
        level.var_a4fe61a4 = 1;
    }

    // Namespace namespace_88795f45/namespace_88795f45
    // Params 1, eflags: 0x4
    // Checksum 0x793c5d7c, Offset: 0x2408
    // Size: 0x992
    function private function_15677aa0(cmd) {
        switch (cmd) {
        case #"hash_fb30e673c6ed7ed":
        case #"hash_3710ddeafb2df7df":
        case #"hash_7791897f03cdc3bf":
        case #"hash_794aad9f189f1889":
            player = getplayers()[0];
            v_direction = player getplayerangles();
            v_direction = anglestoforward(v_direction) * 8000;
            eye = player geteye();
            trace = bullettrace(eye, eye + v_direction, 0, undefined);
            var_380c580a = positionquery_source_navigation(trace[#"position"], 128, 256, 128, 20);
            s_spot = spawnstruct();
            if (isdefined(var_380c580a) && var_380c580a.data.size > 0) {
                s_spot.origin = var_380c580a.data[0].origin;
            } else {
                s_spot.origin = player.origin;
            }
            s_spot.angles = (0, player.angles[1] - 180, 0);
            spawner = #"spawner_zm_steiner";
            if (cmd == "<dev string:x10f>") {
                spawner = #"spawner_zm_steiner_split_radiation_blast";
            } else if (cmd == "<dev string:x12c>") {
                spawner = #"spawner_zm_steiner_split_radiation_bomb";
            } else if (cmd == "<dev string:xf5>") {
                function_f045e7c(s_spot, 0);
                break;
            }
            steiner = spawnactor(spawner, s_spot.origin, s_spot.angles);
            if (isdefined(steiner)) {
                steiner forceteleport(s_spot.origin);
            }
            break;
        case #"hash_7168487d1ca40ace":
            var_84e505 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
            foreach (steiner in var_84e505) {
                steiner thread function_735ef74d();
            }
            break;
        case #"hash_56fe56d42aeaae84":
            var_84e505 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
            foreach (steiner in var_84e505) {
                if (isalive(steiner)) {
                    steiner function_bf898e7e(!steiner function_b37b32b9());
                }
            }
            break;
        case #"hash_6c5505a13bdeb727":
            var_84e505 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
            foreach (steiner in var_84e505) {
                if (isalive(steiner)) {
                    if (!isdefined(steiner.var_9fde8624) || steiner function_ba878b50() || steiner.var_9fde8624 === #"hash_5605f3a585b3ef9f") {
                        steiner function_af554aaf(!is_true(steiner.var_53bac70d));
                    }
                }
            }
            break;
        case #"hash_359a6fc8ff117087":
            var_84e505 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
            foreach (steiner in var_84e505) {
                if (isalive(steiner)) {
                    if (!isdefined(steiner.var_9fde8624) || steiner function_3758a4e7() || steiner.var_9fde8624 === #"hash_5605f3a585b3ef9f") {
                        steiner function_16a8babd(!is_true(steiner.var_22b8f534));
                    }
                }
            }
            break;
        case #"hash_24ad0cbc87557614":
            var_84e505 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
            foreach (steiner in var_84e505) {
                if (isalive(steiner)) {
                    steiner.ai.var_bb06b848 = !steiner.ai.var_bb06b848;
                }
            }
            break;
        case #"hash_2359be32da56aa21":
            var_84e505 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
            split_blast = undefined;
            split_bomb = undefined;
            foreach (steiner in var_84e505) {
                if (!isdefined(steiner.var_9fde8624) || steiner.var_9fde8624 === #"hash_5605f3a585b3ef9f") {
                    continue;
                }
                if (steiner function_ba878b50() && !isdefined(split_blast)) {
                    split_blast = steiner;
                } else if (steiner function_3758a4e7() && !isdefined(split_bomb)) {
                    split_bomb = steiner;
                }
                if (isdefined(split_blast) && isdefined(split_bomb)) {
                    level thread function_67a0e9a2([split_blast, split_bomb], split_blast);
                    break;
                }
            }
            break;
        case #"hash_108d247458cb597b":
            function_bbb547de(250);
            break;
        case #"hash_77e4b4a0f4904933":
            function_32af84be(level.players[0]);
            break;
        default:
            break;
        }
    }

    // Namespace namespace_88795f45/namespace_88795f45
    // Params 0, eflags: 0x0
    // Checksum 0x12af36e2, Offset: 0x2da8
    // Size: 0x46
    function update_dvars() {
        while (true) {
            level.var_a71c09f8 = getdvarint(#"hash_71bbda417e2a07e9", 0);
            wait 1;
        }
    }

    // Namespace namespace_88795f45/namespace_88795f45
    // Params 1, eflags: 0x0
    // Checksum 0xd838c4a1, Offset: 0x2df8
    // Size: 0x44
    function function_ee21651d(message) {
        if (isdefined(level.var_a71c09f8)) {
            println("<dev string:x148>" + message);
        }
    }

#/

// Namespace namespace_88795f45/namespace_88795f45
// Params 3, eflags: 0x1 linked
// Checksum 0x307cee65, Offset: 0x2e48
// Size: 0x1c8
function spawn_single(b_force_spawn, var_eb3a8721 = 0, *var_bc66d64b) {
    if (!var_eb3a8721 && !function_fbb9b8fb()) {
        return undefined;
    }
    if (isdefined(var_bc66d64b)) {
        s_spawn_loc = var_bc66d64b;
    } else if (isdefined(level.var_2a8acd42)) {
        s_spawn_loc = [[ level.var_2a8acd42 ]]();
    } else if (level.zm_loc_types[#"steiner_location"].size > 0) {
        s_spawn_loc = array::random(level.zm_loc_types[#"steiner_location"]);
    }
    if (!isdefined(s_spawn_loc)) {
        /#
            if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                iprintlnbold("<dev string:x158>");
            }
        #/
        return undefined;
    }
    ai = spawnactor(#"spawner_zm_steiner", s_spawn_loc.origin, s_spawn_loc.angles);
    if (isdefined(ai)) {
        ai.script_string = s_spawn_loc.script_string;
        ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
        ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
    }
    return ai;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0xcb30d58a, Offset: 0x3018
// Size: 0x4c8
function function_99c14949() {
    self endon(#"death");
    println("<dev string:x18b>");
    while (true) {
        var_31f7011a = arraysortclosest(getplayers(), self.origin);
        foreach (player in var_31f7011a) {
            if (zm_utility::is_player_valid(player)) {
                closest_player = player;
                break;
            }
        }
        if (isdefined(closest_player)) {
            break;
        }
        util::wait_network_frame();
    }
    s_spawn_locs = [];
    if (isdefined(level.var_2a8acd42)) {
        var_cd04f695 = [[ level.var_2a8acd42 ]](1);
        if (isarray(var_cd04f695)) {
            s_spawn_locs = var_cd04f695;
        } else {
            array::add(s_spawn_locs, var_cd04f695);
        }
    } else if (level.zm_loc_types[#"steiner_location"].size > 0) {
        s_spawn_locs = level.zm_loc_types[#"steiner_location"];
    }
    var_69681a59 = [];
    if (isdefined(level.active_zone_names) && isarray(s_spawn_locs) && s_spawn_locs.size > 0) {
        foreach (spawn_loc in s_spawn_locs) {
            if (isdefined(spawn_loc.zone_name) && array::contains(level.active_zone_names, spawn_loc.zone_name)) {
                if (!isdefined(var_69681a59)) {
                    var_69681a59 = [];
                } else if (!isarray(var_69681a59)) {
                    var_69681a59 = array(var_69681a59);
                }
                var_69681a59[var_69681a59.size] = spawn_loc;
            }
        }
    }
    if (var_69681a59.size < 1) {
        println("<dev string:x1ab>");
        return true;
    }
    var_56feeec4 = 9999999;
    foreach (var_d7eff26a in var_69681a59) {
        n_dist = distancesquared(closest_player.origin, var_d7eff26a.origin);
        if (n_dist < var_56feeec4) {
            var_56feeec4 = n_dist;
            var_b2aa54a9 = var_d7eff26a;
        }
    }
    if (!isdefined(var_b2aa54a9)) {
        println("<dev string:x21f>");
        return true;
    }
    println("<dev string:x260>" + self.origin + "<dev string:x290>" + var_b2aa54a9.origin);
    self function_bf898e7e(0);
    self zm_ai_utility::function_a8dc3363(var_b2aa54a9);
    self function_bf898e7e(1);
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x8d7a3a8c, Offset: 0x34e8
// Size: 0x6c
function private function_735ef74d() {
    if (isalive(self)) {
        self.marked_for_death = 1;
        self.allowdeath = 1;
        self kill();
        waitframe(1);
        if (isdefined(self)) {
            self delete();
        }
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x22140a6b, Offset: 0x3560
// Size: 0x1e2
function function_f4788553(*var_dbce0c44) {
    if (isdefined(level.var_ad49daf9) && level.round_number < level.var_ad49daf9) {
        return 0;
    }
    var_2506688 = 1;
    var_1797c23a = 1;
    n_player_count = zm_utility::function_a2541519(getplayers().size);
    if (n_player_count == 1) {
        switch (level.var_b15745d6) {
        case 0:
        case 1:
        case 2:
            var_2506688 = 1;
            break;
        default:
            var_2506688 = 1;
            var_1797c23a = 2;
            break;
        }
    } else {
        switch (level.var_b15745d6) {
        case 0:
            break;
        case 1:
            var_2506688 = 1;
            var_1797c23a = 2;
            break;
        case 2:
            var_2506688 = 2;
            var_1797c23a = 2;
            break;
        case 3:
            var_2506688 = 2;
            var_1797c23a = 3;
            break;
        default:
            var_2506688 = 3;
            var_1797c23a = 3;
            break;
        }
    }
    return randomintrangeinclusive(var_2506688, var_1797c23a);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x4ee3fbd9, Offset: 0x3750
// Size: 0x134
function function_3ced6468(*n_round_number) {
    level endon(#"end_game");
    if (!isdefined(level.var_b15745d6)) {
        level.var_b15745d6 = 0;
    }
    while (true) {
        level waittill(#"hash_5d3012139f083ccb");
        if (zm_round_spawning::function_d0db51fc(#"hash_7c0d83ac1e845ac2")) {
            level.var_b15745d6++;
            n_player_count = zm_utility::function_a2541519(getplayers().size);
            if (n_player_count == 1) {
                level.var_ad49daf9 = level.round_number + randomintrangeinclusive(3, 5);
                continue;
            }
            level.var_ad49daf9 = level.round_number + randomintrangeinclusive(3, 4);
        }
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x6fbab46c, Offset: 0x3890
// Size: 0x38
function round_spawn() {
    ai = spawn_single();
    if (isdefined(ai)) {
        level.zombie_total--;
        return true;
    }
    return false;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x3eadb569, Offset: 0x38d0
// Size: 0xb4
function function_fbb9b8fb() {
    var_77c7cc93 = function_5e039106();
    var_60f05a03 = function_1f8ac25d();
    if (!is_true(level.var_76934955) && (is_true(level.var_fe2bb2ac) || var_77c7cc93 >= var_60f05a03 || !level flag::get("spawn_zombies"))) {
        return false;
    }
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0xd8b042b4, Offset: 0x3990
// Size: 0xca
function function_1f8ac25d() {
    n_player_count = zm_utility::function_a2541519(getplayers().size);
    switch (n_player_count) {
    case 1:
        return 1;
    case 2:
        return 3;
    case 3:
        return 3;
    case 4:
        return 3;
    case 5:
        return 3;
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0xf1db8d7c, Offset: 0x3a68
// Size: 0xca
function function_5e039106() {
    var_5a2d0d60 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
    var_77c7cc93 = var_5a2d0d60.size;
    foreach (var_494993c6 in var_5a2d0d60) {
        if (!isalive(var_494993c6)) {
            var_77c7cc93--;
        }
    }
    return var_77c7cc93;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x92bd22d5, Offset: 0x3b40
// Size: 0xc0
function function_f26fe009(params) {
    if (self.archetype !== #"hash_7c0d83ac1e845ac2") {
        return;
    }
    self function_bf898e7e(0);
    self thread function_4b193227();
    if (isplayer(params.eattacker) && self zm_utility::in_playable_area()) {
        level notify(#"hash_7e3660d8d125a63a", {#position:self.origin});
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xea04e69a, Offset: 0x3c08
// Size: 0x15c
function function_61e1c2a1(params) {
    if (self.archetype !== #"hash_7c0d83ac1e845ac2") {
        return;
    }
    if (self.team == #"allies") {
        self.health = self.maxhealth;
        if (!isplayer(params.eattacker)) {
            self.ai.var_a49798e7 = 1;
        }
    }
    if (isdefined(params.weapon) && namespace_b376a999::function_5fef4201(params.weapon)) {
        self.ai.var_76786d9c = 1;
        self thread function_c235ead4(3);
        if (isdefined(params.smeansofdeath) && namespace_b376a999::function_760c0d2d(params.weapon, params.smeansofdeath)) {
            self.ai.var_5810aebe = gettime() + 500;
            println("<dev string:x298>" + 500 + "<dev string:x2ca>");
        }
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 12, eflags: 0x1 linked
// Checksum 0xcd7c59b5, Offset: 0x3d70
// Size: 0x168
function function_4e005f8f(*inflictor, attacker, damage, *dflags, *mod, *weapon, *point, *dir, hitloc, *offsettime, *boneindex, *modelindex) {
    if (isplayer(offsettime) && self.team === offsettime.team) {
        return 0;
    }
    damage_type = 1;
    weakpoint = namespace_81245006::function_3131f5dd(self, modelindex, 1);
    if (weakpoint.var_3765e777 === 1) {
        damage_type = 2;
    }
    callback::callback(#"hash_3886c79a26cace38", {#eattacker:offsettime, #var_dcc8dd60:self getentitynumber(), #idamage:boneindex, #type:damage_type});
    return boneindex;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x941ccff3, Offset: 0x3ee0
// Size: 0x54
function function_bf898e7e(enable) {
    if (isdefined(self)) {
        self.var_216935f8 = is_true(enable);
        self clientfield::set("steiner_radiation_aura_clientfield", self.var_216935f8);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x0
// Checksum 0xd00aec52, Offset: 0x3f40
// Size: 0x24
function function_b37b32b9() {
    return isdefined(self) && is_true(self.var_216935f8);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0xc936c3f4, Offset: 0x3f70
// Size: 0x294
function private function_5ac86e25() {
    level endon(#"end_game");
    self endon(#"death", #"entitydeleted");
    var_ef4f2892 = 250;
    if (self function_6b87eed1()) {
        var_ef4f2892 = int(125);
    }
    var_1e2b1cca = var_ef4f2892 * var_ef4f2892;
    var_bb604001 = self gettagorigin("j_head");
    var_8b1f38b5 = var_bb604001[2] - self.origin[2];
    self clientfield::set("steiner_radiation_aura_clientfield", is_true(self.var_216935f8));
    params = getstatuseffect("dot_steiner_radiation_aura");
    while (isdefined(self) && isalive(self)) {
        if (!is_true(self.var_216935f8)) {
            wait 0.2;
            continue;
        }
        players = function_a1ef346b(undefined, self.origin, var_ef4f2892);
        foreach (player in players) {
            if (player inlaststand()) {
                continue;
            }
            if (abs(player.origin[2] - self.origin[2]) > var_8b1f38b5) {
                continue;
            }
            player status_effect::status_effect_apply(params, undefined, self);
        }
        wait 0.2;
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x8d731e4d, Offset: 0x4210
// Size: 0x9c
function function_bc9fe637(s_params) {
    attacker = s_params.eattacker;
    if (isdefined(attacker) && isdefined(attacker.archetype) && attacker.archetype == #"hash_7c0d83ac1e845ac2" && s_params.idamage > 0) {
        if (s_params.smeansofdeath == "MOD_MELEE") {
            attacker function_5a481a84(self);
        }
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xfa0ce87b, Offset: 0x42b8
// Size: 0x198
function private function_c235ead4(time) {
    if (!getdvar(#"hash_7bb1af7c8592abdf", 0)) {
        return;
    }
    if (!isdefined(time) || time <= 0) {
        return;
    }
    if (!is_true(self.var_216935f8) && !isdefined(self.var_7f1f0ba)) {
        return;
    }
    self notify(#"hash_2a19d3b2750fdda9");
    self endon(#"death", #"hash_2a19d3b2750fdda9");
    self function_bf898e7e(0);
    var_7f1f0ba = gettime() + int(time * 1000);
    if (isdefined(self.var_7f1f0ba)) {
        self.var_7f1f0ba = int(max(self.var_7f1f0ba, var_7f1f0ba));
    } else {
        self.var_7f1f0ba = var_7f1f0ba;
    }
    while (isalive(self) && isdefined(self.var_7f1f0ba)) {
        if (gettime() >= self.var_7f1f0ba) {
            self function_bf898e7e(1);
            return;
        }
        waitframe(1);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x770295ac, Offset: 0x4458
// Size: 0x84
function private get_enemy() {
    if (!zm_utility::is_survival()) {
        return (isdefined(self.favoriteenemy) ? self.favoriteenemy : self.enemy);
    }
    if (isentity(self.attackable)) {
        return self.attackable;
    }
    return isdefined(self.favoriteenemy) ? self.favoriteenemy : self.enemy;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x9e69e815, Offset: 0x44e8
// Size: 0x76
function private function_b860fc37(enemy) {
    return isalive(enemy) && (!isplayer(enemy) || !enemy inlaststand()) && !is_true(enemy.ignoreme);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x8e548d0, Offset: 0x4568
// Size: 0x9a
function private can_see_enemy() {
    if (!isdefined(self.can_see_enemy)) {
        self.can_see_enemy = 0;
    }
    if (!isdefined(self.var_6ed00311)) {
        self.var_6ed00311 = 0;
    }
    enemy = self get_enemy();
    if (isdefined(enemy) && self.var_6ed00311 < gettime()) {
        self.can_see_enemy = self cansee(enemy);
        self.var_6ed00311 = gettime() + 50;
    }
    return self.can_see_enemy;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x2f67357a, Offset: 0x4610
// Size: 0x16
function private function_880fad96() {
    return self.ai.var_2642a09b != 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xa3ea8cbd, Offset: 0x4630
// Size: 0x4e
function private function_1da02b50(var_b268a2ed) {
    assert(var_b268a2ed >= 0 && var_b268a2ed <= 3);
    self.ai.var_2642a09b = var_b268a2ed;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0xafcd001f, Offset: 0x4688
// Size: 0x56
function private function_9ee55afa() {
    self.ai.var_2642a09b = 0;
    self.var_fcca372 = gettime() + int(3 * 1000);
    self notify(#"hash_58f0b0e23afeccb9");
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x8218b8cb, Offset: 0x46e8
// Size: 0x20
function private function_efd416d6() {
    return !isdefined(self.var_fcca372) || self.var_fcca372 < gettime();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xa29978ef, Offset: 0x4710
// Size: 0x6e
function function_af554aaf(enable) {
    if (!isdefined(self)) {
        return;
    }
    var_53bac70d = is_true(self.var_53bac70d);
    self.var_53bac70d = is_true(enable);
    if (var_53bac70d != self.var_53bac70d) {
        self.var_3ad8ef86 = 0;
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x958add9, Offset: 0x4788
// Size: 0xbe
function private function_7a893a7(entity) {
    if (!is_true(entity.var_53bac70d)) {
        return 0;
    }
    enemy = self get_enemy();
    if (!function_b860fc37(enemy)) {
        return 0;
    } else {
        var_8ff86729 = distance2dsquared(self.origin, enemy.origin);
        if (var_8ff86729 <= 90000) {
            return 0;
        }
    }
    return entity.ai.var_a02f86e7;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xded45b93, Offset: 0x4850
// Size: 0x24
function private function_baffe829(entity) {
    entity function_1da02b50(1);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xd77eb085, Offset: 0x4880
// Size: 0xe4
function private function_fe1e617c(entity) {
    if (isalive(entity)) {
        var_16122b95 = 2 * 0.25;
        cooldown = randomintrange(1, 3);
        entity.var_3ad8ef86 = gettime() + int((var_16122b95 + cooldown) * 1000);
        entity.ai.var_a02f86e7 = 0;
        entity.var_f0d59f6d += 1;
        entity.variant_type = 0;
        entity function_9ee55afa();
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x53b74da4, Offset: 0x4970
// Size: 0x4ac
function private function_3aa93442(entity) {
    level endon(#"end_game");
    entity endon(#"death", #"entitydeleted");
    weapon = getweapon(#"hash_2b47921791da6f0");
    tags = ["j_head", "j_head", "j_head"];
    if (entity function_6b87eed1()) {
        tags = ["j_head", "j_head", "j_head"];
    }
    assert(tags.size >= 3);
    count = 0;
    var_8c0e4cc3 = undefined;
    while (count < 3) {
        if (!isalive(entity)) {
            return;
        }
        enemy = entity get_enemy();
        if (function_b860fc37(enemy)) {
            target_origin = enemy.origin;
            velocity = enemy getvelocity();
            dist = distance(entity.origin, target_origin);
            var_b98d779c = dist / weapon.projectilespeed;
            target_origin += velocity * var_b98d779c;
            var_68ff3c95 = enemy.origin[2] - entity.origin[2];
            if (var_68ff3c95 > 80) {
                target_origin += (0, 0, 36);
            } else {
                var_b495d5d6 = randomintrange(30, 100);
                rand_x = randomintrange(0, var_b495d5d6);
                rand_y = var_b495d5d6 - rand_x;
                if (math::cointoss()) {
                    rand_x *= -1;
                }
                if (math::cointoss()) {
                    rand_y *= -1;
                }
                target_origin += (rand_x, rand_y, 0);
            }
            if (isdefined(var_8c0e4cc3)) {
                var_5193085 = distancesquared(target_origin, var_8c0e4cc3);
                if (var_5193085 < 2500) {
                    rand_x = randomintrange(0, 50);
                    rand_y = 50 - rand_x;
                    if (math::cointoss()) {
                        rand_x *= -1;
                    }
                    if (math::cointoss()) {
                        rand_y *= -1;
                    }
                    target_origin += (rand_x, rand_y, 0);
                }
            }
            var_21e2ce99 = entity gettagorigin(tags[count]);
            entity playsoundontag(#"hash_67495e1530f787db", tags[count]);
            /#
                if (getdvarint(#"hash_77b40b42481ff900", 0)) {
                    recordsphere(target_origin, 20, (1, 0, 0));
                }
            #/
            magicbullet(weapon, var_21e2ce99, target_origin, entity);
            var_8c0e4cc3 = target_origin;
        }
        count++;
        if (true) {
            wait 0.25;
        }
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 12, eflags: 0x5 linked
// Checksum 0x35023737, Offset: 0x4e28
// Size: 0xc8
function private function_7709f2df(inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    var_7aa37d9f = surfacetype;
    if (isdefined(psoffsettime) && isdefined(boneindex) && isdefined(psoffsettime.team) && isdefined(boneindex.team) && psoffsettime.team == boneindex.team) {
        var_7aa37d9f = 0;
    }
    return var_7aa37d9f;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xd3a65d9d, Offset: 0x4ef8
// Size: 0x3c
function private function_46f4d406(entity) {
    if (isalive(entity)) {
        level thread function_3aa93442(entity);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xa6264b28, Offset: 0x4f40
// Size: 0x3b4
function private function_829cfcc8(entity) {
    if (entity function_880fad96()) {
        return;
    }
    if (!isdefined(entity.var_f8bb81c1)) {
        random = randomintrange(1, 3);
        entity.var_f8bb81c1 = random;
    }
    if (entity function_6b87eed1()) {
        entity.var_f8bb81c1 = 0;
    }
    entity.ai.var_a02f86e7 = 0;
    entity.ai.var_5dc77566 = 0;
    entity.ai.var_b13e6817 = 0;
    if (!entity function_efd416d6()) {
        return;
    }
    enemy = entity get_enemy();
    if (!isdefined(enemy)) {
        return;
    }
    currentvelocity = self getvelocity();
    currentspeed = length(currentvelocity);
    var_eab3f54a = distance2dsquared(entity.origin, enemy.origin);
    if (is_true(entity.var_22b8f534) && entity.var_b52fc691 < gettime() && !function_2bde9dfa(entity) && entity.var_f8bb81c1 <= entity.var_f0d59f6d) {
        var_477db4d3 = currentspeed < 0 ? var_eab3f54a <= 1000000 : var_eab3f54a <= 810000;
        if (var_477db4d3 && entity can_see_enemy()) {
            entity.ai.var_b13e6817 = 1;
            entity.ai.var_5dc77566 = 1;
        }
    } else if (is_true(entity.var_53bac70d) && entity.var_3ad8ef86 < gettime() && !function_2bde9dfa(entity)) {
        var_477db4d3 = currentspeed < 0 ? var_eab3f54a <= 1000000 : var_eab3f54a <= 810000;
        if (var_477db4d3 && entity can_see_enemy()) {
            entity.ai.var_a02f86e7 = 1;
        }
    }
    if (isdefined(entity.ai.var_6d3ee308) && (entity.ai.var_5dc77566 || entity.ai.var_a02f86e7)) {
        if (entity.ai.var_6d3ee308 < gettime()) {
            entity.ai.var_6d3ee308 = undefined;
            entity.variant_type = 0;
            return;
        }
        entity.variant_type = 1;
        println("<dev string:x2d1>");
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xe9328ac, Offset: 0x5300
// Size: 0x6e
function function_16a8babd(enable) {
    if (!isdefined(self)) {
        return;
    }
    var_22b8f534 = is_true(self.var_22b8f534);
    self.var_22b8f534 = is_true(enable);
    if (var_22b8f534 != self.var_22b8f534) {
        self.var_b52fc691 = 0;
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x2c1dc45d, Offset: 0x5378
// Size: 0xd4
function private function_e6d0f1d4(entity) {
    if (!is_true(entity.var_22b8f534)) {
        return false;
    }
    enemy = self get_enemy();
    if (!function_b860fc37(enemy)) {
        return false;
    } else {
        var_8ff86729 = distance2dsquared(self.origin, enemy.origin);
        if (var_8ff86729 <= 90000) {
            return false;
        }
    }
    return entity.ai.var_5dc77566 && entity function_52562969();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0xfe7e69c0, Offset: 0x5458
// Size: 0xbc
function private function_52562969() {
    if (isdefined(self.var_90c3aec8) && self.var_90c3aec8.size >= 3) {
        return false;
    }
    enemy = self get_enemy();
    if (!function_b860fc37(enemy)) {
        return false;
    } else {
        var_8ff86729 = distance2dsquared(self.origin, enemy.origin);
        if (var_8ff86729 <= 90000) {
            return false;
        }
    }
    return level.var_879dbfb8 < 9;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x5678ecd9, Offset: 0x5520
// Size: 0xc
function private function_99608cba(*entity) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xdbcf7b02, Offset: 0x5538
// Size: 0xc
function private function_779b5a9(*entity) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xe5043452, Offset: 0x5550
// Size: 0x82
function private function_4245d56f(entity) {
    if (entity function_52562969()) {
        level.var_879dbfb8++;
        entity.var_4d0d199c = 1;
        entity clientfield::set("steiner_radiation_bomb_prepare_fire_clientfield", 1);
        entity function_1da02b50(2);
        return;
    }
    entity.var_4d0d199c = 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x8d020790, Offset: 0x55e0
// Size: 0x124
function private function_45fabe41(entity) {
    if (is_true(entity.var_4d0d199c)) {
        entity.var_4d0d199c = 0;
    }
    cooldown = randomintrange(3, 5);
    if (entity function_6b87eed1()) {
        cooldown = randomintrange(1, 3);
    }
    entity.var_b52fc691 = gettime() + int(cooldown * 1000);
    entity.ai.var_5dc77566 = 0;
    entity.var_f0d59f6d = 0;
    entity.var_f8bb81c1 = undefined;
    entity.variant_type = 0;
    entity clientfield::set("steiner_radiation_bomb_prepare_fire_clientfield", 0);
    entity function_9ee55afa();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 12, eflags: 0x5 linked
// Checksum 0x36bec5dc, Offset: 0x5710
// Size: 0xc8
function private function_7ff0ce68(inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    var_7aa37d9f = surfacetype;
    if (isdefined(psoffsettime) && isdefined(boneindex) && isdefined(psoffsettime.team) && isdefined(boneindex.team) && psoffsettime.team == boneindex.team) {
        var_7aa37d9f = 0;
    }
    return var_7aa37d9f;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x770f7a31, Offset: 0x57e0
// Size: 0x5f0
function private function_bf8080c1(entity) {
    entity clientfield::set("steiner_radiation_bomb_prepare_fire_clientfield", 0);
    var_c29d35bd = getweapon(#"hash_67307aa00ad6f686");
    enemy = entity get_enemy();
    if (!function_b860fc37(enemy)) {
        return false;
    }
    var_dd6bc3a6 = var_c29d35bd.projectilespeed;
    if (!bullettracepassed(entity gettagorigin("tag_bombthrower_FX"), enemy gettagorigin("j_ankle_ri"), 0, self) && !bullettracepassed(entity gettagorigin("tag_bombthrower_FX"), enemy gettagorigin("j_ankle_le"), 0, self)) {
        var_dd6bc3a6 /= 2;
    }
    target_dist = distance(self.origin, enemy.origin);
    var_b6897326 = target_dist / var_dd6bc3a6;
    rand = randomfloatrange(0.5, 1);
    var_b6897326 += rand;
    var_6e3ad56b = enemy.origin;
    if (isplayer(enemy)) {
        velocity = enemy getvelocity();
        var_6e3ad56b += velocity * var_b6897326;
    }
    target_pos = groundtrace(enemy.origin + (0, 0, 64), enemy.origin + (0, 0, -100000), 0, enemy)[#"position"];
    angles = vectortoangles(target_pos - entity.origin);
    dir = anglestoforward(angles);
    var_8598bad6 = entity gettagorigin("tag_bombthrower_FX");
    dist = distance(var_8598bad6, target_pos);
    velocity = dir * var_dd6bc3a6;
    to_target = target_pos - var_8598bad6;
    time = length((to_target[0], to_target[1], to_target[2])) / var_dd6bc3a6;
    var_813d38fa = (to_target[2] + 0.5 * getdvarfloat(#"bg_lowgravity", 400) * function_a3f6cdac(time)) / time;
    velocity = (velocity[0], velocity[1], var_813d38fa);
    entity playsoundontag(#"hash_24961baa62849a57", "tag_bombthrower_FX");
    /#
        if (getdvarint(#"hash_65abc910bc611782", 0)) {
            recordsphere(target_pos, 16, (0, 1, 0));
            recordline(var_8598bad6, target_pos, (0, 1, 0));
            println("<dev string:x301>" + enemy.origin + "<dev string:x331>" + target_pos);
            for (i = 0; i <= time; i += 0.1) {
                height = var_8598bad6[2] + var_813d38fa * i - 0.5 * getdvarfloat(#"bg_lowgravity", 400) * function_a3f6cdac(i);
                debug_pos = (var_8598bad6[0] + velocity[0] * i, var_8598bad6[1] + velocity[1] * i, height);
                recordsphere(debug_pos, 8, (0, 1, 0));
            }
        }
    #/
    grenade = entity magicgrenadetype(var_c29d35bd, var_8598bad6, velocity);
    if (isdefined(grenade)) {
        grenade.owner = entity;
        grenade.team = entity.team;
        grenade thread function_a56050b0();
    }
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xdf64c360, Offset: 0x5dd8
// Size: 0x46
function private function_2bde9dfa(entity) {
    if (entity.ai.var_5dc77566 || entity.ai.var_b13e6817) {
        return 1;
    }
    return 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x189b6529, Offset: 0x5e28
// Size: 0x1d4
function private function_a56050b0() {
    level endon(#"end_game");
    owner = self.owner;
    self waittill(#"grenade_explode", #"death");
    if (isalive(owner)) {
        origin = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
        /#
            println("<dev string:x346>" + self.origin + "<dev string:x36d>" + origin);
            if (getdvarint(#"hash_65abc910bc611782", 0)) {
                recordsphere(self.origin, 16, (0, 1, 0));
            }
        #/
        var_b308e59c = spawn("script_model", origin);
        var_b308e59c setmodel("tag_origin");
        var_b308e59c clientfield::set("radiation_bomb_play_landed_fx", 1);
        var_b308e59c.owner = owner;
        owner function_4d70c1d3(var_b308e59c);
        var_b308e59c thread function_fac064dc();
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xc3c115ff, Offset: 0x6008
// Size: 0x8c
function private function_4d70c1d3(ent) {
    if (!isdefined(self.var_90c3aec8)) {
        self.var_90c3aec8 = [];
    }
    if (!isdefined(self.var_90c3aec8)) {
        self.var_90c3aec8 = [];
    } else if (!isarray(self.var_90c3aec8)) {
        self.var_90c3aec8 = array(self.var_90c3aec8);
    }
    self.var_90c3aec8[self.var_90c3aec8.size] = ent;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x5 linked
// Checksum 0xb4ce283, Offset: 0x60a0
// Size: 0x18c
function private function_f2cb8145(var_ec2c535e, destroyed) {
    if (is_true(destroyed)) {
        self clientfield::set("radiation_bomb_play_landed_fx", 2);
    } else {
        self clientfield::set("radiation_bomb_play_landed_fx", 0);
    }
    if (is_true(var_ec2c535e) && isdefined(self.owner) && isdefined(self.owner.var_90c3aec8)) {
        arrayremovevalue(self.owner.var_90c3aec8, self);
    }
    if (is_true(self.var_5d15d0b2)) {
        return;
    }
    self.var_5d15d0b2 = 1;
    util::wait_network_frame();
    level.var_879dbfb8--;
    assert(level.var_879dbfb8 >= 0);
    if (isdefined(self.trigger_damage)) {
        self.trigger_damage delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x103759ab, Offset: 0x6238
// Size: 0x5e
function private function_4b193227() {
    if (!isdefined(self.var_90c3aec8) || !self.var_90c3aec8.size) {
        return;
    }
    array::thread_all(self.var_90c3aec8, &function_f2cb8145, 0);
    self.var_90c3aec8 = [];
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x2be4c608, Offset: 0x62a0
// Size: 0x1d4
function private function_fac064dc() {
    level endon(#"end_game");
    self endon(#"death");
    self thread function_5afaa306(128);
    var_6f13bbe0 = gettime() + int(10000);
    origin = self.origin;
    owner = self.owner;
    weapon = getweapon(#"tear_gas");
    params = getstatuseffect("dot_steiner_radiation_bomb");
    while (gettime() < var_6f13bbe0) {
        alive_players = function_a1ef346b(undefined, origin, 128);
        foreach (player in alive_players) {
            if (player laststand::player_is_in_laststand() === 0) {
                player status_effect::status_effect_apply(params, weapon, self);
            }
        }
        wait 0.2;
    }
    self thread function_f2cb8145(1);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x991939e6, Offset: 0x6480
// Size: 0x112
function private function_5afaa306(trigger_radius) {
    self endon(#"death");
    self.trigger_damage = spawn("trigger_damage", self.origin, 0, trigger_radius, 24);
    self.trigger_damage endon(#"death");
    while (true) {
        s_result = self.trigger_damage waittill(#"damage");
        if (isplayer(s_result.attacker)) {
            if (isdefined(s_result.weapon) && namespace_b376a999::function_5fef4201(s_result.weapon)) {
                self thread function_f2cb8145(1, 1);
                return;
            }
        }
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x5e352933, Offset: 0x65a0
// Size: 0x3c
function private function_fc9189dd(entity) {
    if (isalive(entity)) {
        function_bf8080c1(entity);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x295f4132, Offset: 0x65e8
// Size: 0x3e4
function private function_ac56fb75() {
    level endon(#"end_game");
    self endon(#"death", #"entitydeleted");
    if (!isalive(self)) {
        return;
    }
    if (is_true(self.var_8576e0be) || is_true(self.var_9b474709)) {
        return;
    }
    if (self function_880fad96()) {
        self.var_9b474709 = 1;
        waitresult = self waittill(#"hash_58f0b0e23afeccb9", #"stop_wait_for_split");
        if (!isalive(self) || waitresult._notify == "stop_wait_for_split") {
            return;
        }
        self.var_9b474709 = 0;
    }
    self.var_8576e0be = 1;
    self.var_c3083789 = 1;
    if (isplayer(self.attacker)) {
        level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:self.attacker, #scoreevent:"steiner_split_zm"});
    }
    self function_1da02b50(3);
    health = int(max(ceil(self.health * 0.5), 10));
    var_9f7c58e6 = #"spawner_zm_steiner_split_radiation_blast";
    var_a0024591 = #"spawner_zm_steiner_split_radiation_bomb";
    if (self function_1e521615()) {
        var_9f7c58e6 = #"hash_7f957e36b4f6160f";
        var_a0024591 = #"hash_6904f5c7bef64405";
    }
    var_188c5348 = self.var_fde10e1d === 30;
    var_33867b8b = self function_eafb4701(var_9f7c58e6, self, health, var_188c5348);
    var_863c0d4d = self function_eafb4701(var_a0024591, self, health, var_188c5348);
    if (isdefined(self.var_9d59692c)) {
        self [[ self.var_9d59692c ]](var_33867b8b, var_863c0d4d);
    }
    println("<dev string:x380>" + health);
    self function_bf898e7e(0);
    self pathmode("dont move");
    self.suicidaldeath = 1;
    waitframe(1);
    self notify(#"spawned_split_ai");
    self function_9ee55afa();
    self hide();
    self thread function_735ef74d();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 4, eflags: 0x5 linked
// Checksum 0x6ad02591, Offset: 0x69d8
// Size: 0x110
function private function_eafb4701(aitype, location, health, var_188c5348) {
    if (!isdefined(location.angles)) {
        angles = (0, 0, 0);
    } else {
        angles = location.angles;
    }
    entity = spawnactor(aitype, location.origin, angles);
    if (!isdefined(entity)) {
        return;
    }
    entity notify(#"hash_57cb7b473056de06", {#origin:location.origin, #angles:angles, #var_188c5348:var_188c5348});
    entity.maxhealth = health;
    entity.health = health;
    entity setmaxhealth(health);
    return entity;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x2808b6a2, Offset: 0x6af0
// Size: 0x27c
function private function_3c494a14() {
    self endon(#"death");
    waitresult = self waittill(#"hash_57cb7b473056de06");
    self ghost();
    self dontinterpolate();
    self forceteleport(waitresult.origin, waitresult.angles);
    waitframe(1);
    self show();
    self orientmode("face default");
    self pathmode("dont move", 1);
    self val::set(#"hash_57cb7b473056de06", "ignoreall", 1);
    self.ignore_all_poi = 1;
    animation = is_true(waitresult.var_188c5348) ? #"hash_472dc064bf8b45b6" : #"hash_1303360c7d27b2b4";
    if (self function_ba878b50()) {
        animation = is_true(waitresult.var_188c5348) ? #"hash_4e82076610a39b4b" : #"hash_2c6a542c7f682ad3";
    }
    self animscripted("steiner_split_intro", self.origin, self.angles, animation, "normal");
    self waittillmatch({#notetrack:"end"}, #"steiner_split_intro");
    self val::reset(#"hash_57cb7b473056de06", "ignoreall");
    self.ignore_all_poi = 0;
    self pathmode("move allowed");
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x50adceb3, Offset: 0x6d78
// Size: 0x128
function private function_b46c0796(entity) {
    var_87222bcb = entity.maxhealth * 0.5;
    if (entity function_1e521615()) {
        var_87222bcb = entity.maxhealth * 0.25;
    }
    if (isalive(entity) && is_true(entity.var_8d1d18aa) && entity.health <= var_87222bcb) {
        if (!is_true(entity.var_8576e0be) && (entity function_3108de07(60) || entity function_3108de07(30))) {
            return 1;
        } else {
            return 0;
        }
        return;
    }
    return 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x6f4e7715, Offset: 0x6ea8
// Size: 0x2c
function private function_363c063(entity) {
    entity orientmode("face default");
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x2ad49e47, Offset: 0x6ee0
// Size: 0x24
function private function_380fc4a5(entity) {
    entity thread function_ac56fb75();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xa97804f8, Offset: 0x6f10
// Size: 0x20e
function private function_3108de07(var_fde10e1d) {
    var_8e6411bf = anglestoright(self.angles) * var_fde10e1d;
    rightposition = getclosestpointonnavmesh(self.origin + var_8e6411bf, self getpathfindingradius());
    var_d9ca447f = isdefined(rightposition) && distancesquared(self.origin, rightposition) >= function_a3f6cdac(var_fde10e1d) && tracepassedonnavmesh(self.origin, rightposition, 15);
    if (var_d9ca447f) {
        leftposition = getclosestpointonnavmesh(self.origin - var_8e6411bf, self getpathfindingradius());
        var_290edef9 = isdefined(leftposition) && distancesquared(self.origin, leftposition) >= function_a3f6cdac(var_fde10e1d) && tracepassedonnavmesh(self.origin, leftposition, 15);
        if (var_290edef9) {
            println("<dev string:x3a5>" + self.origin + "<dev string:x3be>" + var_fde10e1d);
            self.var_fde10e1d = var_fde10e1d;
            return true;
        }
    }
    println("<dev string:x3d1>" + self.origin);
    return false;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xac18c2c2, Offset: 0x7128
// Size: 0x30
function private function_15c1e3df(entity) {
    if (entity.ai.var_fad877bf) {
        return 1;
    }
    return 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x318468d3, Offset: 0x7160
// Size: 0xc
function private function_d33f94e(*entity) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x30cad9d6, Offset: 0x7178
// Size: 0x1e
function private function_4b63f114(entity) {
    entity.ai.var_fad877bf = 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xfb975fb1, Offset: 0x71a0
// Size: 0x5c
function private function_b52cb76c(entity) {
    if (is_true(entity.suicidaldeath)) {
        return false;
    }
    if (!hasasm(entity)) {
        return false;
    }
    return !is_true(entity.missinglegs);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xcd28d179, Offset: 0x7208
// Size: 0x84
function private function_e9e122fa(entity) {
    var_9ef80b55 = entity aiutility::function_9144ba8();
    if (var_9ef80b55 == "heavy") {
        println("<dev string:x3ed>" + entity getentitynumber() + "<dev string:x3f9>");
        return true;
    }
    return false;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xb93b8215, Offset: 0x7298
// Size: 0x2a
function function_617dea8a(ratio) {
    if (ratio >= 0.33) {
        return "heavy";
    }
    return "light";
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xf67e66b3, Offset: 0x72d0
// Size: 0x3c
function function_b077b73d(time) {
    if (!isdefined(time) || time <= 0) {
        return;
    }
    self thread function_392a816a(time);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x3e5b9b0f, Offset: 0x7318
// Size: 0x19e
function private function_392a816a(time) {
    if (is_true(self.var_8576e0be)) {
        return;
    }
    if (!is_true(self.var_8d1d18aa) && !isdefined(self.var_e1f39584)) {
        return;
    }
    self notify(#"hash_1126b46a114399d");
    self endon(#"death", #"hash_1126b46a114399d");
    self.var_8d1d18aa = 0;
    if (is_true(self.var_9b474709)) {
        self notify(#"stop_wait_for_split");
        self.var_9b474709 = 0;
    }
    var_e1f39584 = gettime() + int(time * 1000);
    if (isdefined(self.var_e1f39584)) {
        self.var_e1f39584 = int(max(self.var_e1f39584, var_e1f39584));
    } else {
        self.var_e1f39584 = var_e1f39584;
    }
    while (isalive(self) && isdefined(self.var_e1f39584)) {
        if (gettime() >= self.var_e1f39584) {
            self.var_8d1d18aa = 1;
            return;
        }
        waitframe(1);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x9e00bc5b, Offset: 0x74c0
// Size: 0x32
function private function_d778b630(entity) {
    entity.ai.var_76786d9c = 0;
    entity.ai.var_80045105 = gettime();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x9d4aa06d, Offset: 0x7500
// Size: 0x5a
function private function_46e10c70(entity) {
    if (entity.ai.var_76786d9c) {
        entity.ai.var_fad877bf = 1;
        entity.ai.var_76786d9c = 0;
        return 4;
    }
    return 5;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xe9109cb5, Offset: 0x7568
// Size: 0x154
function private function_5a481a84(player) {
    dist = distance(self.origin, player.origin);
    targetorigin = (player.origin[0], player.origin[1], self.origin[2]);
    var_a6470558 = vectornormalize(targetorigin - self.origin);
    aimeleerange = self.meleeweapon.aimeleerange;
    var_32708f81 = 100 + aimeleerange;
    var_8cf8f805 = mapfloat(0, aimeleerange, 100, var_32708f81, dist);
    player playerknockback(1);
    player applyknockback(int(var_8cf8f805), var_a6470558);
    player playerknockback(0);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x13eb7010, Offset: 0x76c8
// Size: 0x44
function private function_a14fcce8(entity) {
    println("<dev string:x412>");
    entity function_fc82d5c7();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x33e58180, Offset: 0x7718
// Size: 0x44
function private function_fc82d5c7() {
    self.ai.var_4902424b = gettime() + 5000;
    self.zombie_move_speed = "walk";
    println("<dev string:x431>");
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x66cf7106, Offset: 0x7768
// Size: 0x1f0
function function_7cac529b(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_9ecae3b4)) {
        return 1;
    }
    if (behaviortreeentity getpathmode() == "dont move" || behaviortreeentity.ignoreall) {
        return 0;
    }
    if (is_true(behaviortreeentity.ai.var_48ae6dbf)) {
        return 1;
    }
    if (is_true(behaviortreeentity.ai.var_db6715c9)) {
        return 1;
    }
    if (isdefined(behaviortreeentity.ai.var_5810aebe) && behaviortreeentity.ai.var_5810aebe > gettime()) {
        return 0;
    }
    if (behaviortreeentity.ai.var_3dbed9a0 > gettime()) {
        return 1;
    }
    enemy = behaviortreeentity get_enemy();
    if (isdefined(enemy) && function_b860fc37(enemy)) {
        var_eab3f54a = distance2dsquared(behaviortreeentity.origin, enemy.origin);
        canseeenemy = behaviortreeentity can_see_enemy();
        return behaviortreeentity function_3e6b7dd4(enemy, var_eab3f54a, canseeenemy);
    } else if (is_true(self.ai.var_870d0893) && self haspath()) {
        return 1;
    }
    return 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x716ecb81, Offset: 0x7960
// Size: 0x78
function function_3bdb520f(entity) {
    if (is_true(entity.ai.var_d9f167ee) && !isdefined(entity.ai.var_f38a2e83)) {
        entity.ai.var_f38a2e83 = gettime();
        println("<dev string:x452>");
    }
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xc6afc183, Offset: 0x79e0
// Size: 0xda
function function_2154581b(behaviortreeentity) {
    if (function_7a893a7(behaviortreeentity) || function_e6d0f1d4(behaviortreeentity)) {
        behaviortreeentity clearpath();
        println("<dev string:x46f>");
    }
    if (isdefined(behaviortreeentity.ai.var_f38a2e83) && behaviortreeentity.ai.var_f38a2e83 + 10000 <= gettime()) {
        behaviortreeentity function_fc82d5c7();
        behaviortreeentity.ai.var_f38a2e83 = undefined;
    }
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xb844bae3, Offset: 0x7ac8
// Size: 0x70
function private function_7b89edb0(behaviortreeentity) {
    if (!behaviortreeentity function_dd070839()) {
        behaviortreeentity clearpath();
    }
    behaviortreeentity.ai.var_3dbed9a0 = gettime();
    println("<dev string:x4a2>");
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xda4a6841, Offset: 0x7b40
// Size: 0x40
function function_553ec0ae(behaviortreeentity) {
    behaviortreeentity.ai.var_48ae6dbf = 1;
    println("<dev string:x4c0>");
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x5877e86b, Offset: 0x7b88
// Size: 0x40
function function_f60a1f74(behaviortreeentity) {
    behaviortreeentity.ai.var_48ae6dbf = 0;
    println("<dev string:x4e3>");
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xb4f51e, Offset: 0x7bd0
// Size: 0x1e
function function_efc7dca5(behaviortreeentity) {
    return behaviortreeentity.ai.var_e875a95c;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 3, eflags: 0x5 linked
// Checksum 0xdd10754b, Offset: 0x7bf8
// Size: 0x50e
function private function_3e6b7dd4(enemy, var_eab3f54a, canseeenemy) {
    if (var_eab3f54a > 1000000 || !canseeenemy || var_eab3f54a <= 90000) {
        self setblackboardattribute("_run_n_gun_variation", "variation_forward");
        goal = getclosestpointonnavmesh(enemy.origin, 128, 30);
        if (isdefined(goal)) {
            self setgoal(goal);
            if (self haspath()) {
                self.ai.var_3dbed9a0 = gettime() + 1000;
                self function_21746f2d(var_eab3f54a);
            } else {
                println("<dev string:x505>" + self.origin + "<dev string:x290>" + goal);
            }
        } else {
            println("<dev string:x52a>" + enemy.origin);
            radius = 1000;
            if (var_eab3f54a < 1000000) {
                radius = sqrt(var_eab3f54a);
            }
            goal = getrandomnavpoint(enemy.origin, radius, 30);
            if (isdefined(goal)) {
                self setgoal(goal);
                if (self haspath()) {
                    self.ai.var_3dbed9a0 = gettime() + 1000;
                    self function_21746f2d(var_eab3f54a);
                } else {
                    println("<dev string:x505>" + self.origin + "<dev string:x290>" + goal);
                }
            } else {
                println("<dev string:x55f>" + self.origin + "<dev string:x57a>");
            }
        }
    } else {
        var_e3b6f14a = 0;
        self.ai.var_e875a95c = 0;
        if (var_e3b6f14a) {
            var_5920d6a6 = randomint(100) > 50;
            if (self function_bb5d7e92(var_5920d6a6, enemy)) {
                self.ai.var_e875a95c = 1;
            } else if (self function_bb5d7e92(!var_5920d6a6, enemy)) {
                var_5920d6a6 = !var_5920d6a6;
                self.ai.var_e875a95c = 1;
            }
            if (self.ai.var_e875a95c) {
                println("<dev string:x58b>");
                self.ai.var_3dbed9a0 = gettime() + 1000;
            }
        } else {
            goal = self function_fc9fc2dd(enemy, var_eab3f54a);
            self setblackboardattribute("_run_n_gun_variation", "variation_forward");
            self setgoal(goal);
            if (self haspath()) {
                self.ai.var_3dbed9a0 = gettime() + 1000;
                self function_21746f2d(var_eab3f54a);
            } else {
                /#
                    if (isdefined(goal)) {
                        println("<dev string:x505>" + self.origin + "<dev string:x290>" + goal);
                    } else {
                        println("<dev string:x505>" + self.origin + "<dev string:x5a3>");
                    }
                #/
            }
        }
    }
    if (self.ai.var_3dbed9a0 <= gettime()) {
        self.ai.var_d9f167ee = 0;
        self.ai.var_f38a2e83 = undefined;
        println("<dev string:x5bd>");
    }
    return self.ai.var_3dbed9a0 > gettime();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x1 linked
// Checksum 0xc6bfae1, Offset: 0x8110
// Size: 0x402
function function_fc9fc2dd(enemy, var_eab3f54a) {
    if (!isdefined(self.var_67ecda8f)) {
        self.var_67ecda8f = 0;
    }
    var_777f01b2 = self function_4794d6a3();
    var_ca505e91 = distance2dsquared(self.origin, var_777f01b2.goalpos);
    if (var_ca505e91 > function_a3f6cdac(128) && gettime() < self.var_67ecda8f) {
        return var_777f01b2.goalpos;
    }
    goal = self.origin;
    var_5494b2e9 = 1;
    enemy_distance = sqrt(var_eab3f54a);
    vector_to_target = enemy.origin - self.origin;
    vector_to_target = vectornormalize(vector_to_target);
    facing_angles = vectortoangles(vector_to_target);
    test_points = array(self.origin + anglestoforward((0, angleclamp180(facing_angles[1] + randomfloatrange(45, 75) / 2), 0)) * randomfloatrange(100, 300), self.origin + anglestoforward((0, angleclamp180(facing_angles[1] - randomfloatrange(45, 75) / 2), 0)) * randomfloatrange(100, 300), self.origin + anglestoforward((0, angleclamp180(facing_angles[1] - randomfloatrange(45, 75) / 2), 0)) * randomfloatrange(100, 300), self.origin + anglestoforward((0, angleclamp180(facing_angles[1] - randomfloatrange(45, 75) / 2), 0)) * randomfloatrange(100, 300));
    test_points = array::randomize(test_points);
    if (var_5494b2e9) {
        bestpoint = undefined;
        foreach (point in test_points) {
            bestpoint = function_7c5a37e9(self, point, enemy);
            if (isdefined(bestpoint)) {
                goal = bestpoint;
                self.var_67ecda8f = gettime() + 3000;
                break;
            }
        }
    }
    return goal;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 3, eflags: 0x1 linked
// Checksum 0x8a3162d6, Offset: 0x8520
// Size: 0x23a
function function_7c5a37e9(entity, point, *enemy) {
    groundpos = groundtrace(enemy + (0, 0, 500) + (0, 0, 8), enemy + (0, 0, 500) + (0, 0, -100000), 0, point)[#"position"];
    if (groundpos[2] < enemy[2] - 2000) {
        /#
            recordsphere(enemy, 10, (1, 0, 0), "<dev string:x5dd>", point);
        #/
        return undefined;
    }
    nextpos = getclosestpointonnavmesh(groundpos, 128, point getpathfindingradius());
    if (!isdefined(nextpos)) {
        /#
            recordsphere(enemy, 10, (1, 0, 0), "<dev string:x5dd>", point);
        #/
        return undefined;
    }
    if (!point canpath(point.origin, nextpos)) {
        /#
            recordsphere(enemy, 10, (1, 0, 0), "<dev string:x5dd>", point);
        #/
        return undefined;
    }
    groundpos = groundtrace(nextpos + (0, 0, 500) + (0, 0, 8), nextpos + (0, 0, 500) + (0, 0, -100000), 0, point)[#"position"];
    if (abs(nextpos[2] - groundpos[2]) > 5) {
        return undefined;
    }
    return nextpos;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x4
// Checksum 0xc01254f, Offset: 0x8768
// Size: 0x7e
function private function_a788e366(var_eab3f54a, canseeenemy) {
    if (is_true(self.ai.var_bb06b848)) {
        return false;
    }
    if (var_eab3f54a > 360000 || var_eab3f54a < 10000) {
        return false;
    }
    if (is_true(canseeenemy)) {
        return false;
    }
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x5 linked
// Checksum 0xd19d2144, Offset: 0x87f0
// Size: 0x20a
function private function_bb5d7e92(var_5920d6a6, *enemy) {
    right = anglestoright(self.angles);
    var_900963e4 = is_true(enemy) ? -1 : 1;
    var_91d0d82d = randomintrange(100, 300);
    targetpoint = self.origin + vectorscale(right, var_91d0d82d * var_900963e4);
    nav_mesh = getclosestpointonnavmesh(targetpoint, self getpathfindingradius(), 30);
    if (isdefined(nav_mesh) && tracepassedonnavmesh(self.origin, nav_mesh, self getpathfindingradius()) && sighttracepassed(self.origin + (0, 0, 80), nav_mesh + (0, 0, 30), 0, self)) {
        if (self haspath()) {
            self setblackboardattribute("_run_n_gun_variation", enemy ? "variation_strafe_1" : "variation_strafe_2");
            attribute = self getblackboardattribute("_run_n_gun_variation");
            self setgoal(nav_mesh);
            self.ignore_find_flesh = 1;
            return true;
        }
    }
    return false;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x2115660d, Offset: 0x8a08
// Size: 0xfa
function private function_8e782bd8(behaviortreeentity) {
    attribute = behaviortreeentity getblackboardattribute("_run_n_gun_variation");
    /#
        if (behaviortreeentity getblackboardattribute("<dev string:x5e7>") === "<dev string:x5ff>") {
            println("<dev string:x615>");
        } else if (behaviortreeentity getblackboardattribute("<dev string:x5e7>") === "<dev string:x633>") {
            println("<dev string:x649>");
        } else {
            println("<dev string:x668>");
        }
    #/
    behaviortreeentity.ai.var_db6715c9 = 1;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x83455423, Offset: 0x8b10
// Size: 0x6e
function private function_850378bc(behaviortreeentity) {
    if (behaviortreeentity isatgoal()) {
        behaviortreeentity.ignore_find_flesh = 0;
        behaviortreeentity.ai.var_db6715c9 = 0;
        println("<dev string:x6b3>");
        return 4;
    }
    return 5;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xa0d00186, Offset: 0x8b88
// Size: 0x4a
function private function_c9181afb(behaviortreeentity) {
    println("<dev string:x6d1>");
    behaviortreeentity.ignore_find_flesh = 0;
    behaviortreeentity.ai.var_db6715c9 = 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x3de3f80d, Offset: 0x8be0
// Size: 0x54
function function_e6b7aa9d(behaviortreeentity) {
    if (is_true(behaviortreeentity.ai.var_48ae6dbf)) {
        return false;
    }
    return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_walk";
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xf49c6736, Offset: 0x8c40
// Size: 0x54
function function_dab44559(behaviortreeentity) {
    if (is_true(behaviortreeentity.ai.var_48ae6dbf)) {
        return false;
    }
    return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_run";
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x17125ae5, Offset: 0x8ca0
// Size: 0x284
function private function_21746f2d(var_eab3f54a) {
    if (isdefined(self.ai.var_4902424b) && self.ai.var_4902424b > gettime()) {
        self.zombie_move_speed = "walk";
        return;
    }
    if (!is_true(self.ai.var_d9f167ee) && var_eab3f54a <= 90000) {
        self.ai.var_d9f167ee = 1;
        println("<dev string:x6e8>");
    }
    var_533af8f8 = !is_true(self.ai.var_e93366a);
    if (var_eab3f54a > 90000 && var_eab3f54a <= 1000000) {
        var_533af8f8 = 0;
    }
    isrunning = self.zombie_move_speed == "run";
    if (var_533af8f8 && !isrunning) {
        if (!isdefined(self.ai.rundelay)) {
            self.ai.rundelay = gettime() + randomintrange(1000, 2000);
            println("<dev string:x706>");
        }
        if (self.ai.rundelay > gettime()) {
            var_533af8f8 = 0;
        }
    }
    if (var_533af8f8 != isrunning) {
        if (var_533af8f8) {
            currentvelocity = self getvelocity();
            currentspeed = length(currentvelocity);
            if (!isrunning || currentspeed > 0) {
                self.zombie_move_speed = "run";
                self.ai.rundelay = undefined;
                println("<dev string:x71f>");
            }
            return;
        }
        self.zombie_move_speed = "walk";
        println("<dev string:x73a>");
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xe2416d0f, Offset: 0x8f30
// Size: 0x1e
function private function_29744716(entity) {
    return entity.ai.var_b90dccd6;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x488e798a, Offset: 0x8f58
// Size: 0x36
function private function_2745a754(entity) {
    return entity.ai.var_8c90ae8e && !entity.ai.var_a49798e7;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x6a00aab, Offset: 0x8f98
// Size: 0xc
function private function_bf6d273f(*entity) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x55f659de, Offset: 0x8fb0
// Size: 0xc
function private function_bd9179c(*entity) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x6b8dad42, Offset: 0x8fc8
// Size: 0x1e6
function function_dede41c0() {
    enemy = self get_enemy();
    if (!zm_utility::is_survival()) {
        if (isdefined(enemy) && function_b860fc37(enemy)) {
            predictedpos = self lastknownpos(enemy);
            if (isdefined(predictedpos)) {
                turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
                return turnyaw;
            }
        }
        codegoal = self function_4794d6a3();
        if (isdefined(codegoal.goalangles)) {
            turnyaw = absangleclamp360(self.angles[1] - codegoal.goalangles[1]);
            return turnyaw;
        }
    } else {
        pos = undefined;
        if (issentient(enemy)) {
            pos = self lastknownpos(enemy);
        } else if (isdefined(enemy)) {
            pos = enemy.origin;
        }
        if (isdefined(pos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(pos - self.origin)[1]);
            return turnyaw;
        }
    }
    return undefined;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x3c9fb485, Offset: 0x91b8
// Size: 0x7a
function function_5142fcce(entity) {
    if (entity.ai.var_a49798e7 && entity.ai.var_8c90ae8e) {
        entity notify(#"hash_39f4b987812e1540");
        entity thread function_2a30b3a3(6);
        return 1;
    }
    return 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0xe3c0fe58, Offset: 0x9240
// Size: 0xc
function function_13f6d246(*entity) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x671e71c6, Offset: 0x9258
// Size: 0xc
function function_e37d4e19(*entity) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xbbeb49cb, Offset: 0x9270
// Size: 0xb0
function private function_2a30b3a3(n_duration) {
    self endon(#"hash_362dfacc3f97bf98", #"hash_39f4b987812e1540");
    var_cccb9018 = n_duration * 1000;
    lasttime = gettime();
    while (true) {
        var_cccb9018 -= gettime() - lasttime;
        lasttime = gettime();
        if (var_cccb9018 <= 0) {
            self.ai.var_a49798e7 = 0;
            self notify(#"hash_362dfacc3f97bf98");
        }
        waitframe(1);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x1 linked
// Checksum 0xfba24d7e, Offset: 0x9328
// Size: 0xf6
function function_67a0e9a2(var_2fa3c4c9, location) {
    level.var_f0c367c9 = location;
    level.var_8cc83376 = [];
    foreach (split in var_2fa3c4c9) {
        split.ai.var_b90dccd6 = 0;
        split.ai.var_62741bfb = 1;
        split setgoal(split.origin, 1);
        split.ignoreall = 1;
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xbd3c0abd, Offset: 0x9428
// Size: 0x1e
function private function_52479a49(entity) {
    return entity.ai.var_62741bfb;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xcc05f30e, Offset: 0x9450
// Size: 0x2c
function private function_5c25cce9(entity) {
    entity clientfield::set("steiner_split_combine_fx_clientfield", 1);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xdb5ac6fb, Offset: 0x9488
// Size: 0xa8
function private function_5070830c(entity) {
    array::add(level.var_8cc83376, entity, 0);
    entity clientfield::set("steiner_split_combine_fx_clientfield", 0);
    entity.ai.var_62741bfb = 0;
    if (level.var_8cc83376.size == 2) {
        level thread function_aed09e18(level.var_8cc83376, level.var_f0c367c9);
        level.var_8cc83376 = [];
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x162e4be6, Offset: 0x9538
// Size: 0x1e
function private function_dcac38af(entity) {
    return entity.ai.var_a29f9a91;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x6bb3c731, Offset: 0x9560
// Size: 0xc
function private function_545f48af(*entity) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x88c132c, Offset: 0x9578
// Size: 0x5a
function private function_42d0830a(entity) {
    if (entity.variant_type < 3) {
        entity.variant_type += 1;
        return;
    }
    entity.variant_type = 0;
    entity.ai.var_a29f9a91 = 0;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x5 linked
// Checksum 0xbcc8e391, Offset: 0x95e0
// Size: 0x24c
function private function_aed09e18(var_2fa3c4c9, location) {
    spawner = #"spawner_zm_steiner";
    if (var_2fa3c4c9[0] function_1e521615()) {
        spawner = #"hash_acac3fe7a341329";
    }
    foreach (split in var_2fa3c4c9) {
        split hide();
        split deletedelay();
    }
    steiner = spawnactor(#"spawner_zm_steiner", location.origin, location.angles);
    if (isdefined(steiner)) {
        steiner forceteleport(location.origin, location.angles);
        steiner.team = #"allies";
        steiner.ignoreall = 1;
        steiner.ignore_find_flesh = 1;
        steiner.ignoreme = 1;
        steiner.ignore_nuke = 1;
        steiner.ignore_all_poi = 1;
        steiner.takedamage = 0;
        steiner.var_8d1d18aa = 0;
        steiner.ai.var_a29f9a91 = 1;
        steiner.variant_type = 0;
        steiner function_bf898e7e(0);
        steiner function_af554aaf(0);
        steiner function_16a8babd(0);
    }
    level flag::set("steiner_merge_done");
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x1 linked
// Checksum 0x8db16586, Offset: 0x9838
// Size: 0x172
function function_f045e7c(location, var_c406df14) {
    steiner = spawnactor(#"spawner_zm_steiner", location.origin, location.angles);
    if (isdefined(steiner)) {
        steiner forceteleport(location.origin, location.angles);
        steiner.team = #"allies";
        steiner.ignoreall = 1;
        steiner.ignore_find_flesh = 1;
        steiner.ignoreme = 0;
        steiner.ignore_nuke = 1;
        steiner.ignore_all_poi = 1;
        steiner.instakill_func = &zm_powerups::function_16c2586a;
        steiner.var_d003d23c = 1;
        steiner.takedamage = 1;
        steiner.var_8d1d18aa = 0;
        steiner.ai.var_a29f9a91 = var_c406df14;
        steiner.variant_type = 0;
        steiner function_bf898e7e(0);
        steiner function_af554aaf(0);
        steiner function_16a8babd(0);
        return steiner;
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x1 linked
// Checksum 0xd6cd75e2, Offset: 0x99b8
// Size: 0xa4
function function_7e855c12(point, var_c03fe9e3) {
    self.var_9ecae3b4 = 1;
    if (isdefined(var_c03fe9e3)) {
        self.zombie_move_speed = var_c03fe9e3;
    } else {
        self.zombie_move_speed = "walk";
    }
    self setgoal(point, 0);
    self waittill(#"goal");
    self.var_9ecae3b4 = undefined;
    self setgoal(self.origin, 1);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x3fce6915, Offset: 0x9a68
// Size: 0x5c
function function_c6579189(target) {
    if (!isdefined(target)) {
        return;
    }
    self setgoal(self.origin, 0, undefined, undefined, vectortoangles(target.origin - self.origin));
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x4
// Checksum 0x1f57de86, Offset: 0x9ad0
// Size: 0x132
function private function_46d99f6b() {
    var_84e505 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
    var_ddb534a3 = [];
    foreach (steiner in var_84e505) {
        if (isalive(steiner) && steiner.team == #"allies") {
            if (!isdefined(var_ddb534a3)) {
                var_ddb534a3 = [];
            } else if (!isarray(var_ddb534a3)) {
                var_ddb534a3 = array(var_ddb534a3);
            }
            var_ddb534a3[var_ddb534a3.size] = steiner;
        }
    }
    return var_ddb534a3;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x21a2c61e, Offset: 0x9c10
// Size: 0x8a
function function_6b87eed1() {
    if (!isdefined(self.var_9fde8624)) {
        return 0;
    }
    var_6f8997fc = array(#"hash_5653bbc44a034094", #"hash_70162f4bc795092", #"hash_12fa854f3a7721b9", #"hash_3498fb1fbfcd0cf");
    return isinarray(var_6f8997fc, self.var_9fde8624);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0xbead45d7, Offset: 0x9ca8
// Size: 0x6a
function function_3758a4e7() {
    if (!isdefined(self.var_9fde8624)) {
        return 0;
    }
    var_6f8997fc = array(#"hash_70162f4bc795092", #"hash_3498fb1fbfcd0cf");
    return isinarray(var_6f8997fc, self.var_9fde8624);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x1ffa6069, Offset: 0x9d20
// Size: 0x6a
function function_ba878b50() {
    if (!isdefined(self.var_9fde8624)) {
        return 0;
    }
    var_6f8997fc = array(#"hash_5653bbc44a034094", #"hash_12fa854f3a7721b9");
    return isinarray(var_6f8997fc, self.var_9fde8624);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x8e7971d7, Offset: 0x9d98
// Size: 0x7a
function function_1e521615() {
    if (!isdefined(self.var_9fde8624)) {
        return 0;
    }
    var_6f8997fc = array(#"hash_5605f3a585b3ef9f", #"hash_3498fb1fbfcd0cf", #"hash_12fa854f3a7721b9");
    return isinarray(var_6f8997fc, self.var_9fde8624);
}

/#

    // Namespace namespace_88795f45/namespace_88795f45
    // Params 1, eflags: 0x0
    // Checksum 0x15035bb5, Offset: 0x9e20
    // Size: 0x1d8
    function function_bbb547de(dist) {
        var_ddb534a3 = function_46d99f6b();
        foreach (steiner in var_ddb534a3) {
            fwd = vectorscale(vectornormalize(anglestoforward(steiner.angles)), dist);
            eye = steiner.origin + (0, 0, 80);
            trace = bullettrace(eye, eye + fwd, 0, undefined);
            var_380c580a = positionquery_source_navigation(trace[#"position"], 128, 256, 128, 20);
            point = steiner.origin;
            if (isdefined(var_380c580a) && var_380c580a.data.size > 0) {
                point = var_380c580a.data[0].origin;
            }
            goal = getclosestpointonnavmesh(point);
            steiner thread function_7e855c12(goal);
        }
    }

    // Namespace namespace_88795f45/namespace_88795f45
    // Params 1, eflags: 0x0
    // Checksum 0x1cb20bd7, Offset: 0xa000
    // Size: 0xb0
    function function_32af84be(target) {
        var_ddb534a3 = function_46d99f6b();
        foreach (steiner in var_ddb534a3) {
            steiner thread function_c6579189(target);
        }
    }

#/

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x8e2c38ed, Offset: 0xa0b8
// Size: 0x12
function function_ed79082a() {
    self.var_d03a9e80 = 1;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x0
// Checksum 0xd8ffc07c, Offset: 0xa0d8
// Size: 0x7e
function function_1ebe48df() {
    self endon(#"death", #"entitydeleted");
    while (true) {
        self waittill(#"hash_3eea9a5090ab2f4b");
        if (is_true(self.var_d03a9e80)) {
            self.var_d03a9e80 = 0;
            continue;
        }
        self.var_d03a9e80 = 1;
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x0
// Checksum 0x1d03c63e, Offset: 0xa160
// Size: 0x90
function function_5e09bd0f() {
    self endon(#"death", #"entitydeleted");
    while (true) {
        if (is_true(self.var_d03a9e80)) {
            self playsoundontag(#"hash_5d4fa1004dc72f03", "tag_eye");
        }
        wait randomintrange(3, 9);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x998e47b2, Offset: 0xa1f8
// Size: 0x182
function function_4b261274(entity) {
    if (entity.ignoreall) {
        return false;
    }
    enemy = entity get_enemy();
    if (!isdefined(enemy) || !function_b860fc37(enemy)) {
        return false;
    }
    var_ff38566a = lengthsquared(enemy getvelocity());
    var_17c3916f = 10000;
    if (var_ff38566a < 30625) {
        var_17c3916f = 36100;
    }
    if (!is_true(level.intermission)) {
        if (distancesquared(entity.origin, enemy.origin) > var_17c3916f) {
            return false;
        }
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x919036d2, Offset: 0xa388
// Size: 0x34
function function_f9eee290(entity) {
    return isdefined(entity.damageweapon) && namespace_b376a999::function_5fef4201(entity.damageweapon);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xaae4c9f4, Offset: 0xa3c8
// Size: 0x2c
function private function_9397dd2f(entity) {
    entity asmsetanimationrate(1);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x179ded45, Offset: 0xa400
// Size: 0x3e
function private function_6fc64eed(entity) {
    entity asmsetanimationrate(1);
    entity.ai.var_2a4908cd = gettime();
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xc8ba394a, Offset: 0xa448
// Size: 0x76
function private function_d5e64bba(entity) {
    if (function_7a893a7(entity) || function_e6d0f1d4(entity)) {
        entity.ai.var_6d3ee308 = gettime() + 500;
        return (gettime() - entity.ai.var_2a4908cd);
    }
    return 1000;
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x78a1cd8f, Offset: 0xa4c8
// Size: 0x64
function private function_6254c264(entity) {
    if (isdefined(entity.var_2e874959)) {
        entity asmsetanimationrate(entity.var_2e874959);
        println("<dev string:x756>" + entity.var_2e874959);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xdb0f0f0a, Offset: 0xa538
// Size: 0x2c
function private function_e5ef0d0d(entity) {
    entity asmsetanimationrate(1);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x99f38c11, Offset: 0xa570
// Size: 0x64
function private function_e456ad9b(entity) {
    if (isdefined(entity.var_2e874959)) {
        entity asmsetanimationrate(entity.var_2e874959);
        println("<dev string:x792>" + entity.var_2e874959);
    }
}

