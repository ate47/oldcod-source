#using script_1940fc077a028a81;
#using script_2c5daa95f8fec03c;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_35b8a6927c851193;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_attackables;
#using scripts\zm_common\zm_behavior_utility;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_behavior;

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x1 linked
// Checksum 0x279a3bd7, Offset: 0x4c8
// Size: 0x174
function function_70a657d8() {
    initzmbehaviorsandasm();
    if (!isdefined(level.zigzag_activation_distance)) {
        level.zigzag_activation_distance = 175;
    }
    if (!isdefined(level.zigzag_distance_min)) {
        level.zigzag_distance_min = 256;
    }
    if (!isdefined(level.zigzag_distance_max)) {
        level.zigzag_distance_max = 400;
    }
    if (!isdefined(level.inner_zigzag_radius)) {
        level.inner_zigzag_radius = 16;
    }
    if (!isdefined(level.outer_zigzag_radius)) {
        level.outer_zigzag_radius = 128;
    }
    zm_utility::function_d0f02e71(#"zombie");
    spawner::add_archetype_spawn_function(#"zombie", &function_c15c6e44);
    spawner::add_archetype_spawn_function(#"zombie", &zombiespawninit);
    level.do_randomized_zigzag_path = 1;
    level.zombie_targets = [];
    zm::register_actor_damage_callback(&function_7994fd99);
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x5 linked
// Checksum 0x39e4c5bd, Offset: 0x648
// Size: 0xcc
function private zombiespawninit() {
    self pushplayer(0);
    self collidewithactors(0);
    self thread zm_utility::function_13cc9756();
    self.closest_player_override = &zm_utility::function_c52e1749;
    self.var_1731eda3 = 1;
    self.am_i_valid = 1;
    self.cant_move_cb = &zombiebehavior::function_22762653;
    self ai::set_behavior_attribute("use_attackable", 1);
    self zm_spawner::zombie_spawn_init();
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x5 linked
// Checksum 0xbca3adfe, Offset: 0x720
// Size: 0x56
function private function_c15c6e44() {
    self endon(#"death");
    self waittill(#"completed_emerging_into_playable_area");
    self.var_641025d6 = gettime() + self ai::function_9139c839().var_9c0ebe1e;
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x1 linked
// Checksum 0xdd8ae9a, Offset: 0x780
// Size: 0x3c
function postinit() {
    array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, &function_57d3b5eb);
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x1 linked
// Checksum 0x3127a7c2, Offset: 0x7c8
// Size: 0x146
function function_57d3b5eb() {
    if (!isdefined(self._starting_round_number)) {
        self zm_cleanup::function_aa5726f2();
    }
    self zm_utility::init_zombie_run_cycle();
    self thread zm_spawner::zombie_think();
    if (isdefined(level._zombie_custom_spawn_logic)) {
        if (isarray(level._zombie_custom_spawn_logic)) {
            for (i = 0; i < level._zombie_custom_spawn_logic.size; i++) {
                self thread [[ level._zombie_custom_spawn_logic[i] ]]();
            }
        } else {
            self thread [[ level._zombie_custom_spawn_logic ]]();
        }
    }
    if (isdefined(level.zombie_init_done)) {
        self [[ level.zombie_init_done ]]();
    }
    namespace_81245006::initweakpoints(self);
    self.zombie_init_done = 1;
    self zm_score::function_82732ced();
    self notify(#"zombie_init_done");
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x5 linked
// Checksum 0x4e126f51, Offset: 0x918
// Size: 0x30c4
function private initzmbehaviorsandasm() {
    assert(isscriptfunctionptr(&shouldmovecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmove", &shouldmovecondition);
    assert(isscriptfunctionptr(&zombieshouldtearcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtear", &zombieshouldtearcondition);
    assert(isscriptfunctionptr(&zombieshouldattackthroughboardscondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackthroughboards", &zombieshouldattackthroughboardscondition);
    assert(isscriptfunctionptr(&zombieshouldattackthroughboardscondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombieshouldattackthroughboards", &zombieshouldattackthroughboardscondition);
    assert(isscriptfunctionptr(&zombieshouldtauntcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtaunt", &zombieshouldtauntcondition);
    assert(isscriptfunctionptr(&zombieshouldtauntcondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombieshouldtaunt", &zombieshouldtauntcondition);
    assert(isscriptfunctionptr(&zombiegottoentrancecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoentrance", &zombiegottoentrancecondition);
    assert(isscriptfunctionptr(&zombiegottoattackspotcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoattackspot", &zombiegottoattackspotcondition);
    assert(isscriptfunctionptr(&zombiehasattackspotalreadycondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehasattackspotalready", &zombiehasattackspotalreadycondition);
    assert(isscriptfunctionptr(&zombiehasattackspotalreadycondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombiehasattackspotalready", &zombiehasattackspotalreadycondition);
    assert(isscriptfunctionptr(&zombieshouldenterplayablecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldenterplayable", &zombieshouldenterplayablecondition);
    assert(isscriptfunctionptr(&ischunkvalidcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"ischunkvalid", &ischunkvalidcondition);
    assert(isscriptfunctionptr(&ischunkvalidcondition));
    behaviorstatemachine::registerbsmscriptapiinternal(#"ischunkvalid", &ischunkvalidcondition);
    assert(isscriptfunctionptr(&inplayablearea));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"inplayablearea", &inplayablearea);
    assert(isscriptfunctionptr(&shouldskipteardown));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldskipteardown", &shouldskipteardown);
    assert(isscriptfunctionptr(&zombieisthinkdone));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisthinkdone", &zombieisthinkdone);
    assert(isscriptfunctionptr(&zombieisatgoal));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatgoal", &zombieisatgoal);
    assert(isscriptfunctionptr(&zombieisatgoal));
    behaviorstatemachine::registerbsmscriptapiinternal(#"zombieisatgoal", &zombieisatgoal);
    assert(isscriptfunctionptr(&zombieisatentrance));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatentrance", &zombieisatentrance);
    assert(isscriptfunctionptr(&function_4c12882b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_626619641083db91", &function_4c12882b);
    assert(isscriptfunctionptr(&function_4c12882b));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_626619641083db91", &function_4c12882b);
    assert(isscriptfunctionptr(&function_b86a1b9d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_150eeb42b488a14e", &function_b86a1b9d);
    assert(isscriptfunctionptr(&function_b86a1b9d));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_150eeb42b488a14e", &function_b86a1b9d);
    assert(isscriptfunctionptr(&function_e7f2e349));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3f46416df5ad6e3e", &function_e7f2e349);
    assert(isscriptfunctionptr(&function_e7f2e349));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3f46416df5ad6e3e", &function_e7f2e349);
    assert(isscriptfunctionptr(&function_45009145));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2a86b9d29348a4df", &function_45009145);
    assert(isscriptfunctionptr(&function_a5a66d65));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_f8bf19d37668bca", &function_a5a66d65);
    assert(isscriptfunctionptr(&zombieshouldmoveawaycondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmoveaway", &zombieshouldmoveawaycondition);
    assert(isscriptfunctionptr(&waskilledbyteslacondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"waskilledbytesla", &waskilledbyteslacondition);
    assert(isscriptfunctionptr(&zombieshouldstun));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldstun", &zombieshouldstun);
    assert(isscriptfunctionptr(&zombieisbeinggrappled));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisbeinggrappled", &zombieisbeinggrappled);
    assert(isscriptfunctionptr(&zombieshouldknockdown));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldknockdown", &zombieshouldknockdown);
    assert(isscriptfunctionptr(&zombieispushed));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieispushed", &zombieispushed);
    assert(isscriptfunctionptr(&zombiekilledwhilegettingpulled));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiekilledwhilegettingpulled", &zombiekilledwhilegettingpulled);
    assert(isscriptfunctionptr(&zombiekilledbyblackholebombcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiekilledbyblackholebombcondition", &zombiekilledbyblackholebombcondition);
    assert(isscriptfunctionptr(&function_38fec26f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_18fea53546637859", &function_38fec26f);
    assert(isscriptfunctionptr(&function_e4d7303f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_32d8ffc79910d80b", &function_e4d7303f);
    assert(isscriptfunctionptr(&function_17cd1b17));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1da059a5800a95c5", &function_17cd1b17);
    assert(isscriptfunctionptr(&function_691fecba));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1492e6d3746e9ebb", &function_691fecba);
    assert(isscriptfunctionptr(&function_d8b225ae));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_651ab332997a387f", &function_d8b225ae);
    assert(isscriptfunctionptr(&disablepowerups));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"disablepowerups", &disablepowerups);
    assert(isscriptfunctionptr(&enablepowerups));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"enablepowerups", &enablepowerups);
    assert(!isdefined(&zombiemovetoentranceaction) || isscriptfunctionptr(&zombiemovetoentranceaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiemovetoentranceactionterminate) || isscriptfunctionptr(&zombiemovetoentranceactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemovetoentranceaction", &zombiemovetoentranceaction, undefined, &zombiemovetoentranceactionterminate);
    assert(!isdefined(&zombiemovetoattackspotaction) || isscriptfunctionptr(&zombiemovetoattackspotaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiemovetoattackspotactionterminate) || isscriptfunctionptr(&zombiemovetoattackspotactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemovetoattackspotaction", &zombiemovetoattackspotaction, undefined, &zombiemovetoattackspotactionterminate);
    assert(isscriptfunctionptr(&function_6eb4f847));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5a7ebfd6f2aaad7b", &function_6eb4f847);
    assert(isscriptfunctionptr(&function_547701ae));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3006c33ad53fb0be", &function_547701ae);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombieidleaction", undefined, undefined, undefined);
    assert(!isdefined(&zombiemoveaway) || isscriptfunctionptr(&zombiemoveaway));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemoveaway", &zombiemoveaway, undefined, undefined);
    assert(!isdefined(&zombietraverseaction) || isscriptfunctionptr(&zombietraverseaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombietraverseactionterminate) || isscriptfunctionptr(&zombietraverseactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombietraverseaction", &zombietraverseaction, undefined, &zombietraverseactionterminate);
    assert(!isdefined(&zombieholdboardaction) || isscriptfunctionptr(&zombieholdboardaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombieholdboardactionterminate) || isscriptfunctionptr(&zombieholdboardactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"holdboardaction", &zombieholdboardaction, undefined, &zombieholdboardactionterminate);
    assert(!isdefined(&zombiegrabboardaction) || isscriptfunctionptr(&zombiegrabboardaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiegrabboardactionterminate) || isscriptfunctionptr(&zombiegrabboardactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"grabboardaction", &zombiegrabboardaction, undefined, &zombiegrabboardactionterminate);
    assert(isscriptfunctionptr(&function_66a8aef2));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2c6c8e7fbe32827d", &function_66a8aef2);
    assert(isscriptfunctionptr(&function_16251b30));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7b8b6e4f20e7c65c", &function_16251b30);
    assert(!isdefined(&zombiepullboardaction) || isscriptfunctionptr(&zombiepullboardaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiepullboardactionterminate) || isscriptfunctionptr(&zombiepullboardactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"pullboardaction", &zombiepullboardaction, undefined, &zombiepullboardactionterminate);
    assert(isscriptfunctionptr(&function_aa76355a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6e6a6ae6dbfda8b6", &function_aa76355a);
    assert(isscriptfunctionptr(&function_76d619c8));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_61d9bc9bf2de7261", &function_76d619c8);
    assert(isscriptfunctionptr(&barricadebreakterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("barricadeBreakTerminate", &barricadebreakterminate);
    assert(!isdefined(&zombieattackthroughboardsaction) || isscriptfunctionptr(&zombieattackthroughboardsaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombieattackthroughboardsactionterminate) || isscriptfunctionptr(&zombieattackthroughboardsactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombieattackthroughboardsaction", &zombieattackthroughboardsaction, undefined, &zombieattackthroughboardsactionterminate);
    assert(isscriptfunctionptr(&function_ebba4d65));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5cf57595a9a7f525", &function_ebba4d65);
    assert(isscriptfunctionptr(&function_28b47cc8));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1b4d2e123def1564", &function_28b47cc8);
    assert(!isdefined(&zombietauntaction) || isscriptfunctionptr(&zombietauntaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombietauntactionterminate) || isscriptfunctionptr(&zombietauntactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombietauntaction", &zombietauntaction, undefined, &zombietauntactionterminate);
    assert(isscriptfunctionptr(&function_eb270aac));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5d23aebf14e71bd5", &function_eb270aac);
    assert(isscriptfunctionptr(&function_ba06c8a0));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5e8abe4da3ebfbd4", &function_ba06c8a0);
    assert(!isdefined(&zombiemantleaction) || isscriptfunctionptr(&zombiemantleaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiemantleactionterminate) || isscriptfunctionptr(&zombiemantleactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemantleaction", &zombiemantleaction, undefined, &zombiemantleactionterminate);
    assert(!isdefined(&zombiestunactionstart) || isscriptfunctionptr(&zombiestunactionstart));
    assert(!isdefined(&function_4e52c07) || isscriptfunctionptr(&function_4e52c07));
    assert(!isdefined(&zombiestunactionend) || isscriptfunctionptr(&zombiestunactionend));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiestunaction", &zombiestunactionstart, &function_4e52c07, &zombiestunactionend);
    assert(isscriptfunctionptr(&zombiestunstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestunstart", &zombiestunstart);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_4e52c07) || isscriptfunctionptr(&function_4e52c07));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiestunactionloop", undefined, &function_4e52c07, undefined);
    assert(isscriptfunctionptr(&function_c377438f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5cae731c54d7a310", &function_c377438f);
    assert(isscriptfunctionptr(&function_7531db00));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3ec08de422ecdfa7", &function_7531db00);
    assert(isscriptfunctionptr(&function_1329e086));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_cf69ce67c8c33fc", &function_1329e086);
    assert(isscriptfunctionptr(&zombiegrappleactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegrappleactionstart", &zombiegrappleactionstart);
    assert(isscriptfunctionptr(&zombieknockdownactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieknockdownactionstart", &zombieknockdownactionstart);
    assert(isscriptfunctionptr(&function_c8939973));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a6273a84b4237ce", &function_c8939973);
    assert(isscriptfunctionptr(&zombiegetupactionterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegetupactionterminate", &zombiegetupactionterminate);
    assert(isscriptfunctionptr(&zombiepushedactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiepushedactionstart", &zombiepushedactionstart);
    assert(isscriptfunctionptr(&zombiepushedactionterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiepushedactionterminate", &zombiepushedactionterminate);
    assert(!isdefined(&zombieblackholebombpullstart) || isscriptfunctionptr(&zombieblackholebombpullstart));
    assert(!isdefined(&zombieblackholebombpullupdate) || isscriptfunctionptr(&zombieblackholebombpullupdate));
    assert(!isdefined(&zombieblackholebombpullend) || isscriptfunctionptr(&zombieblackholebombpullend));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombieblackholebombpullaction", &zombieblackholebombpullstart, &zombieblackholebombpullupdate, &zombieblackholebombpullend);
    assert(!isdefined(&zombiekilledbyblackholebombstart) || isscriptfunctionptr(&zombiekilledbyblackholebombstart));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiekilledbyblackholebombend) || isscriptfunctionptr(&zombiekilledbyblackholebombend));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombieblackholebombdeathaction", &zombiekilledbyblackholebombstart, undefined, &zombiekilledbyblackholebombend);
    assert(isscriptfunctionptr(&function_b654f4f5));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2574c98f8c8e07ea", &function_b654f4f5);
    assert(isscriptfunctionptr(&function_36b3cb7d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65c425729831f505", &function_36b3cb7d);
    assert(isscriptfunctionptr(&getchunkservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"getchunkservice", &getchunkservice);
    assert(isscriptfunctionptr(&function_38237e30));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4dde9e6bcca48bcb", &function_38237e30);
    assert(isscriptfunctionptr(&updatechunkservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"updatechunkservice", &updatechunkservice);
    assert(isscriptfunctionptr(&updateattackspotservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"updateattackspotservice", &updateattackspotservice);
    assert(isscriptfunctionptr(&function_b3311a1a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_24d32558bbe4dd3b", &function_b3311a1a);
    assert(isscriptfunctionptr(&findnodesservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"findnodesservice", &findnodesservice);
    assert(isscriptfunctionptr(&function_92d348e2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7f1ef64b934748c3", &function_92d348e2);
    assert(isscriptfunctionptr(&zombieattackableobjectservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackableobjectservice", &zombieattackableobjectservice);
    assert(isscriptfunctionptr(&function_fb814207));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiefindfleshservice", &function_fb814207, 2);
    assert(isscriptfunctionptr(&function_f637b05d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_712f0844b14c72fe", &function_f637b05d, 1);
    assert(isscriptfunctionptr(&zombieenteredplayable));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieenteredplayableservice", &zombieenteredplayable);
    animationstatenetwork::registeranimationmocomp("mocomp_board_tear@zombie", &boardtearmocompstart, &boardtearmocompupdate, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter@zombie", &barricadeentermocompstart, &barricadeentermocompupdate, &barricadeentermocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter_no_z@zombie", &barricadeentermocompnozstart, &barricadeentermocompnozupdate, &barricadeentermocompnozterminate);
    animationstatenetwork::registernotetrackhandlerfunction("destroy_piece", &notetrackboardtear);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_window_melee", &notetrackboardmelee);
    animationstatenetwork::registernotetrackhandlerfunction("smash_board", &function_b37b8c0d);
    animationstatenetwork::registernotetrackhandlerfunction("bhb_burst", &zombiebhbburst);
    animationstatenetwork::registernotetrackhandlerfunction("freezegun_hide", &function_36b3cb7d);
    setdvar(#"scr_zm_use_code_enemy_selection", 0);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x949aa198, Offset: 0x39e8
// Size: 0xf6
function function_d8b225ae(entity) {
    if (!isdefined(entity.attackable)) {
        return false;
    }
    radius = entity.goalradius;
    if (is_true(entity.allowoffnavmesh)) {
        radius = 16;
    }
    if (isdefined(entity.var_b238ef38) && distance2dsquared(entity.origin, entity.var_b238ef38.position) < function_a3f6cdac(radius) && abs(entity.origin[2] - entity.var_b238ef38.position[2]) < 50) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xd35c52b9, Offset: 0x3ae8
// Size: 0x716
function function_691fecba(entity) {
    if (is_true(entity.var_8a96267d) || is_true(entity.var_8ba6ede3)) {
        return false;
    }
    if (is_true(entity.var_4c85ebad)) {
        return true;
    }
    if (function_d8b225ae(entity)) {
        return true;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!namespace_85745671::is_player_valid(entity.enemy) && !namespace_85745671::function_1b9ed9b0(entity.enemy) && entity.team === level.zombie_team) {
        return false;
    }
    if (is_true(entity.ignoremelee)) {
        return false;
    }
    if (isdefined(entity.zombie_poi)) {
        return false;
    }
    if (isdefined(entity.enemy_override)) {
        return false;
    }
    meleedistsq = zombiebehavior::function_997f1224(entity);
    enemy_vehicle = undefined;
    test_origin = entity.enemy.origin;
    if (isplayer(entity.enemy) || is_true(entity.enemy.var_d003d23c)) {
        if (!is_true(zm_utility::is_classic())) {
            if (namespace_85745671::function_142c3c86(entity.enemy)) {
                enemy_vehicle = entity.enemy getvehicleoccupied();
                var_81952387 = enemy_vehicle.origin;
                for (i = 0; i < 11; i++) {
                    if (enemy_vehicle function_dcef0ba1(i)) {
                        var_ec950ebd = enemy_vehicle function_defc91b2(i);
                        if (isdefined(var_ec950ebd) && var_ec950ebd >= 0) {
                            seat_pos = enemy_vehicle function_5051cc0c(i);
                            if (distancesquared(entity.origin, var_81952387) > distancesquared(entity.origin, seat_pos)) {
                                var_81952387 = seat_pos;
                            }
                        }
                    }
                }
                test_origin = var_81952387;
            } else if (isvehicle(entity.enemy getgroundent())) {
                enemy_vehicle = entity.enemy getgroundent();
                test_origin = isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin;
            } else if (isvehicle(entity.enemy getmoverent())) {
                enemy_vehicle = entity.enemy getmoverent();
                test_origin = isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin;
            }
        }
        if (isdefined(enemy_vehicle) && isdefined(entity.var_cbc65493)) {
            meleedistsq *= entity.var_cbc65493;
        }
    }
    if (abs(entity.origin[2] - test_origin[2]) > (isdefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
        return false;
    }
    if (distancesquared(entity.origin, test_origin) > meleedistsq) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > (isdefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
        return false;
    }
    if (!entity cansee(isdefined(enemy_vehicle) ? enemy_vehicle : entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, test_origin) < function_a3f6cdac(40)) {
        entity.idletime = gettime();
        entity.var_1b250399 = entity.origin;
        return true;
    }
    if (isdefined(enemy_vehicle)) {
        entity.idletime = gettime();
        entity.var_1b250399 = entity.origin;
        return true;
    }
    if (is_true(entity.var_1fa24724)) {
        return false;
    }
    if (is_true(self.isonnavmesh) && !tracepassedonnavmesh(entity.origin, isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
        return false;
    }
    entity.idletime = gettime();
    entity.var_1b250399 = entity.origin;
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xf0bc3e8, Offset: 0x4208
// Size: 0x6c
function function_fb814207(behaviortreeentity) {
    if (is_true(behaviortreeentity.ai.var_870d0893)) {
        return;
    }
    if (isdefined(self.var_72411ccf)) {
        self [[ self.var_72411ccf ]](self);
        return;
    }
    self zombiefindflesh(self);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x1b7b1d68, Offset: 0x4280
// Size: 0xad2
function zombiefindflesh(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enablepushtime)) {
        if (gettime() >= behaviortreeentity.enablepushtime) {
            behaviortreeentity collidewithactors(1);
            behaviortreeentity.enablepushtime = undefined;
        }
    }
    if (getdvarint(#"scr_zm_use_code_enemy_selection", 0)) {
        zombiefindfleshcode(behaviortreeentity);
        return;
    }
    if (level.intermission) {
        return;
    }
    if (is_true(behaviortreeentity.var_67faa700)) {
        return;
    }
    if (behaviortreeentity getpathmode() == "dont move") {
        return;
    }
    behaviortreeentity.ignore_player = [];
    behaviortreeentity.goalradius = 30;
    if (is_true(behaviortreeentity.ignore_find_flesh)) {
        return;
    }
    if (behaviortreeentity.team == #"allies") {
        behaviortreeentity findzombieenemy();
        return;
    }
    if (zombieshouldmoveawaycondition(behaviortreeentity)) {
        return;
    }
    zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
    behaviortreeentity.zombie_poi = zombie_poi;
    if (isdefined(zombie_poi) && isdefined(level.var_4e4950d1)) {
        if (![[ level.var_4e4950d1 ]](behaviortreeentity.zombie_poi)) {
            behaviortreeentity.zombie_poi = undefined;
        }
    }
    players = getplayers();
    if (!isdefined(behaviortreeentity.ignore_player) || players.size == 1) {
        behaviortreeentity.ignore_player = [];
    } else if (!isdefined(level._should_skip_ignore_player_logic) || ![[ level._should_skip_ignore_player_logic ]]()) {
        for (i = 0; i < behaviortreeentity.ignore_player.size; i++) {
            if (isdefined(behaviortreeentity.ignore_player[i]) && isdefined(behaviortreeentity.ignore_player[i].ignore_counter) && behaviortreeentity.ignore_player[i].ignore_counter > 3) {
                behaviortreeentity.ignore_player[i].ignore_counter = 0;
                behaviortreeentity.ignore_player = arrayremovevalue(behaviortreeentity.ignore_player, behaviortreeentity.ignore_player[i]);
                if (!isdefined(behaviortreeentity.ignore_player)) {
                    behaviortreeentity.ignore_player = [];
                }
                i = 0;
                continue;
            }
        }
    }
    behaviortreeentity zombie_utility::run_ignore_player_handler();
    designated_target = 0;
    if (isdefined(behaviortreeentity.var_93a62fe) && is_true(behaviortreeentity.var_93a62fe.b_is_designated_target)) {
        designated_target = 1;
    }
    if (!isdefined(behaviortreeentity.var_93a62fe) && !isdefined(zombie_poi) && !isdefined(behaviortreeentity.attackable)) {
        if (isdefined(behaviortreeentity.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            behaviortreeentity.ignore_player = [];
        }
        /#
            if (is_true(behaviortreeentity.ispuppet)) {
                return;
            }
        #/
        if (isdefined(level.no_target_override)) {
            [[ level.no_target_override ]](behaviortreeentity);
            return;
        }
        behaviortreeentity setgoal(behaviortreeentity.origin);
        return;
    } else if (isdefined(level.var_d22435d9)) {
        [[ level.var_d22435d9 ]](behaviortreeentity);
    }
    if (!isdefined(level.var_4bde8b8f) || ![[ level.var_4bde8b8f ]]()) {
        behaviortreeentity.enemyoverride = behaviortreeentity.zombie_poi;
        behaviortreeentity.favoriteenemy = behaviortreeentity.var_93a62fe;
    }
    if (isdefined(behaviortreeentity.v_zombie_custom_goal_pos)) {
        goalpos = behaviortreeentity.v_zombie_custom_goal_pos;
        if (isdefined(behaviortreeentity.n_zombie_custom_goal_radius)) {
            behaviortreeentity.goalradius = behaviortreeentity.n_zombie_custom_goal_radius;
        }
        behaviortreeentity setgoal(goalpos);
    } else if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        behaviortreeentity.has_exit_point = undefined;
        goalpos = behaviortreeentity.enemyoverride[0];
        if (!isdefined(zombie_poi)) {
            aiprofile_beginentry("zombiefindflesh-enemyoverride");
            queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);
            aiprofile_endentry();
            foreach (point in queryresult.data) {
                goalpos = point.origin;
                break;
            }
        }
        behaviortreeentity setgoal(goalpos);
    } else if (isdefined(behaviortreeentity.attackable) && !designated_target) {
        if (isdefined(behaviortreeentity.attackable_slot)) {
            if (isdefined(behaviortreeentity.attackable_goal_radius)) {
                behaviortreeentity.goalradius = behaviortreeentity.attackable_goal_radius;
            }
            nav_mesh = getclosestpointonnavmesh(behaviortreeentity.attackable_slot.origin, 64);
            if (isdefined(nav_mesh)) {
                behaviortreeentity setgoal(nav_mesh);
            } else {
                behaviortreeentity setgoal(behaviortreeentity.attackable_slot.origin);
            }
        } else if (isdefined(behaviortreeentity.var_b238ef38) && isdefined(behaviortreeentity.var_b238ef38.position)) {
            behaviortreeentity setgoal(behaviortreeentity.var_b238ef38.position);
        }
    } else if (isdefined(behaviortreeentity.favoriteenemy)) {
        behaviortreeentity.has_exit_point = undefined;
        behaviortreeentity val::reset(#"attack_properties", "ignoreall");
        if (is_true(behaviortreeentity.var_1fa24724)) {
            if (isdefined(behaviortreeentity.enemy) && (!isdefined(behaviortreeentity.var_898c5e62) || behaviortreeentity.var_898c5e62 <= gettime()) && (!isdefined(behaviortreeentity.var_42ecd9f3) || behaviortreeentity.var_42ecd9f3 <= gettime())) {
                behaviortreeentity.var_3beb881b = undefined;
                function_d5fbbdf8(behaviortreeentity);
                behaviortreeentity.var_898c5e62 = gettime() + int(0.25 * 1000);
            }
            if (is_true(behaviortreeentity.var_3beb881b) || isarray(behaviortreeentity.enemy.var_f904e440) && isinarray(behaviortreeentity.enemy.var_f904e440, behaviortreeentity)) {
                return;
            }
        } else {
            behaviortreeentity.var_3beb881b = undefined;
            if (isarray(behaviortreeentity.enemy.var_f904e440)) {
                arrayremovevalue(behaviortreeentity.enemy.var_f904e440, behaviortreeentity);
            }
        }
        if (isdefined(level.enemy_location_override_func)) {
            goalpos = [[ level.enemy_location_override_func ]](behaviortreeentity, behaviortreeentity.favoriteenemy);
            if (isdefined(goalpos)) {
                behaviortreeentity setgoal(goalpos);
            } else {
                behaviortreeentity zombieupdategoal();
            }
        } else if (is_true(behaviortreeentity.is_rat_test)) {
        } else if (zombieshouldmoveawaycondition(behaviortreeentity)) {
        } else {
            behaviortreeentity zombieupdategoal();
        }
    }
    if (players.size > 1) {
        for (i = 0; i < behaviortreeentity.ignore_player.size; i++) {
            if (isdefined(behaviortreeentity.ignore_player[i])) {
                if (!isdefined(behaviortreeentity.ignore_player[i].ignore_counter)) {
                    behaviortreeentity.ignore_player[i].ignore_counter = 0;
                    continue;
                }
                behaviortreeentity.ignore_player[i].ignore_counter = behaviortreeentity.ignore_player[i].ignore_counter + 1;
            }
        }
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x10602106, Offset: 0x4d60
// Size: 0x5a
function function_f637b05d(behaviortreeentity) {
    if (is_true(behaviortreeentity.ai.var_870d0893)) {
        return;
    }
    behaviortreeentity.var_93a62fe = zm_utility::get_closest_valid_player(behaviortreeentity.origin, behaviortreeentity.ignore_player);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xde1e643f, Offset: 0x4dc8
// Size: 0x404
function zombiefindfleshcode(behaviortreeentity) {
    aiprofile_beginentry("zombieFindFleshCode");
    if (level.intermission) {
        aiprofile_endentry();
        return;
    }
    behaviortreeentity.ignore_player = [];
    behaviortreeentity.goalradius = 30;
    if (behaviortreeentity.team == #"allies") {
        behaviortreeentity findzombieenemy();
        aiprofile_endentry();
        return;
    }
    if (level.wait_and_revive) {
        aiprofile_endentry();
        return;
    }
    if (level.zombie_poi_array.size > 0) {
        zombie_poi = behaviortreeentity zm_utility::get_zombie_point_of_interest(behaviortreeentity.origin);
    }
    behaviortreeentity zombie_utility::run_ignore_player_handler();
    zm_utility::update_valid_players(behaviortreeentity.origin, behaviortreeentity.ignore_player);
    if (!isdefined(behaviortreeentity.enemy) && !isdefined(zombie_poi)) {
        /#
            if (is_true(behaviortreeentity.ispuppet)) {
                aiprofile_endentry();
                return;
            }
        #/
        if (isdefined(level.no_target_override)) {
            [[ level.no_target_override ]](behaviortreeentity);
        } else {
            behaviortreeentity setgoal(behaviortreeentity.origin);
        }
        aiprofile_endentry();
        return;
    }
    behaviortreeentity.enemyoverride = zombie_poi;
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        behaviortreeentity.has_exit_point = undefined;
        goalpos = behaviortreeentity.enemyoverride[0];
        queryresult = positionquery_source_navigation(goalpos, 0, 48, 36, 4);
        foreach (point in queryresult.data) {
            goalpos = point.origin;
            break;
        }
        behaviortreeentity setgoal(goalpos);
    } else if (isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.has_exit_point = undefined;
        /#
            if (is_true(behaviortreeentity.is_rat_test)) {
                aiprofile_endentry();
                return;
            }
        #/
        if (isdefined(level.enemy_location_override_func)) {
            goalpos = [[ level.enemy_location_override_func ]](behaviortreeentity, behaviortreeentity.enemy);
            if (isdefined(goalpos)) {
                behaviortreeentity setgoal(goalpos);
            } else {
                behaviortreeentity zombieupdategoalcode();
            }
        } else if (isdefined(behaviortreeentity.enemy.last_valid_position)) {
            behaviortreeentity zombieupdategoalcode();
        }
    }
    aiprofile_endentry();
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x1 linked
// Checksum 0xc83f94fc, Offset: 0x51d8
// Size: 0xbcc
function zombieupdategoal() {
    aiprofile_beginentry("zombieUpdateGoal");
    shouldrepath = 0;
    zigzag_activation_distance = level.zigzag_activation_distance;
    if (isdefined(self.zigzag_activation_distance)) {
        zigzag_activation_distance = self.zigzag_activation_distance;
    }
    if (!shouldrepath && isdefined(self.favoriteenemy)) {
        pathgoalpos = self.pathgoalpos;
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.favoriteenemy.origin) <= function_a3f6cdac(zigzag_activation_distance)) {
            shouldrepath = 1;
        } else if (isdefined(pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, pathgoalpos);
            shouldrepath = distancetogoalsqr < function_a3f6cdac(72);
        }
    }
    if (is_true(level.validate_on_navmesh)) {
        if (!ispointonnavmesh(self.origin, self)) {
            shouldrepath = 0;
        }
    }
    if (is_true(self.keep_moving)) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (self function_dd070839()) {
        shouldrepath = 0;
    }
    if (isactor(self) && self asmistransitionrunning() || self asmistransdecrunning()) {
        shouldrepath = 0;
    }
    if (shouldrepath) {
        if (isplayer(self.favoriteenemy)) {
            goalent = zm_ai_utility::function_a2e8fd7b(self, self.favoriteenemy);
            if (isdefined(goalent.last_valid_position)) {
                goalpos = getclosestpointonnavmesh(goalent.last_valid_position, 64, self getpathfindingradius());
                if (!isdefined(goalpos)) {
                    goalpos = goalent.origin;
                }
            } else {
                goalpos = goalent.origin;
            }
        } else {
            goalpos = getclosestpointonnavmesh(self.favoriteenemy.origin, 64, self getpathfindingradius());
            if (!isdefined(goalpos) && self.favoriteenemy function_dd070839() && isdefined(self.favoriteenemy.traversestartnode)) {
                goalpos = self.favoriteenemy.traversestartnode.origin;
            }
            if (!isdefined(goalpos)) {
                goalpos = self.origin;
            }
        }
        if (isentity(goalent)) {
            if (!is_true(self.var_1fa24724)) {
                self.var_1f1f2fcd = undefined;
            } else if (self isposinclaimedlocation(isdefined(self.var_1f1f2fcd) ? self.var_1f1f2fcd : goalpos)) {
                queryresult = positionquery_source_navigation(goalpos, self getpathfindingradius(), self getpathfindingradius() * 5, 64, 16, self);
                if (queryresult.data.size > 0) {
                    positionquery_filter_inclaimedlocation(queryresult, self);
                    queryresult.data = function_7b8e26b3(queryresult.data, 0, "inClaimedLocation");
                    if (queryresult.data.size > 0) {
                        point = arraygetclosest(self.origin, queryresult.data);
                        self.var_1f1f2fcd = point.origin;
                        goalpos = point.origin;
                    }
                }
            }
            goalpos = isdefined(self.var_1f1f2fcd) ? self.var_1f1f2fcd : goalpos;
        }
        self setgoal(goalpos);
        should_zigzag = 1;
        if (isdefined(level.should_zigzag)) {
            should_zigzag = self [[ level.should_zigzag ]]();
        } else if (isdefined(self.should_zigzag)) {
            should_zigzag = self.should_zigzag;
        }
        if (isdefined(self.var_592a8227)) {
            should_zigzag = should_zigzag && self.var_592a8227;
        }
        var_eb1c6f1c = 0;
        if (is_true(level.do_randomized_zigzag_path) && should_zigzag) {
            if (distancesquared(self.origin, goalpos) > function_a3f6cdac(zigzag_activation_distance)) {
                self.keep_moving = 1;
                self.keep_moving_time = gettime() + 700;
                path = undefined;
                if (is_true(self.var_ceed8829)) {
                    pathdata = generatenavmeshpath(self.origin, goalpos, self);
                    if (isdefined(pathdata) && pathdata.status === "succeeded" && isdefined(pathdata.pathpoints)) {
                        path = pathdata.pathpoints;
                    }
                } else {
                    path = self calcapproximatepathtoposition(goalpos, 0);
                }
                if (isdefined(path)) {
                    /#
                        if (getdvarint(#"ai_debugzigzag", 0)) {
                            for (index = 1; index < path.size; index++) {
                                recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x38>", self);
                                record3dtext(abs(path[index - 1][2] - path[index][2]), path[index - 1], (1, 0, 0));
                            }
                        }
                    #/
                    deviationdistance = randomintrange(level.zigzag_distance_min, level.zigzag_distance_max);
                    if (isdefined(self.zigzag_distance_min) && isdefined(self.zigzag_distance_max)) {
                        deviationdistance = randomintrange(self.zigzag_distance_min, self.zigzag_distance_max);
                    }
                    segmentlength = 0;
                    for (index = 1; index < path.size; index++) {
                        if (isdefined(level.var_562c8f67) && abs(path[index - 1][2] - path[index][2]) > level.var_562c8f67) {
                            break;
                        }
                        currentseglength = distance(path[index - 1], path[index]);
                        var_570a7c72 = segmentlength + currentseglength > deviationdistance;
                        if (index == path.size - 1 && !var_570a7c72) {
                            deviationdistance = segmentlength + currentseglength - 1;
                            var_eb1c6f1c = 1;
                        }
                        if (var_570a7c72 || var_eb1c6f1c) {
                            remaininglength = deviationdistance - segmentlength;
                            seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                            /#
                                recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x38>", self);
                            #/
                            innerzigzagradius = level.inner_zigzag_radius;
                            if (var_eb1c6f1c) {
                                innerzigzagradius = 0;
                            } else if (isdefined(self.inner_zigzag_radius)) {
                                innerzigzagradius = self.inner_zigzag_radius;
                            }
                            outerzigzagradius = level.outer_zigzag_radius;
                            if (var_eb1c6f1c) {
                                outerzigzagradius = 48;
                            } else if (isdefined(self.outer_zigzag_radius)) {
                                outerzigzagradius = self.outer_zigzag_radius;
                            }
                            queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
                            positionquery_filter_inclaimedlocation(queryresult, self);
                            queryresult.data = function_7b8e26b3(queryresult.data, 0, "inClaimedLocation");
                            if (queryresult.data.size > 0) {
                                a_data = array::randomize(queryresult.data);
                                for (i = 0; i < a_data.size; i++) {
                                    point = a_data[i];
                                    n_z_diff = seedposition[2] - point.origin[2];
                                    if (abs(n_z_diff) < 32) {
                                        self setgoal(point.origin);
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                        segmentlength += currentseglength;
                    }
                }
            }
        }
        self.nextgoalupdate = gettime() + randomintrange(500, 1000);
    }
    aiprofile_endentry();
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x1 linked
// Checksum 0x56c80ee4, Offset: 0x5db0
// Size: 0x55c
function zombieupdategoalcode() {
    aiprofile_beginentry("zombieUpdateGoalCode");
    shouldrepath = 0;
    if (!shouldrepath && isdefined(self.enemy)) {
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.enemy.origin) <= function_a3f6cdac(200)) {
            shouldrepath = 1;
        } else if (isdefined(self.pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
            shouldrepath = distancetogoalsqr < function_a3f6cdac(72);
        }
    }
    if (is_true(self.keep_moving)) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (shouldrepath) {
        goalpos = self.enemy.origin;
        if (isdefined(self.enemy.last_valid_position)) {
            var_2a741504 = getclosestpointonnavmesh(self.enemy.last_valid_position, 64, 16);
            if (isdefined(var_2a741504)) {
                goalpos = var_2a741504;
            }
        }
        if (is_true(level.do_randomized_zigzag_path)) {
            if (distancesquared(self.origin, goalpos) > function_a3f6cdac(240)) {
                self.keep_moving = 1;
                self.keep_moving_time = gettime() + 250;
                path = self calcapproximatepathtoposition(goalpos, 0);
                /#
                    if (getdvarint(#"ai_debugzigzag", 0)) {
                        for (index = 1; index < path.size; index++) {
                            recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x38>", self);
                        }
                    }
                #/
                deviationdistance = randomintrange(240, 480);
                segmentlength = 0;
                for (index = 1; index < path.size; index++) {
                    currentseglength = distance(path[index - 1], path[index]);
                    if (segmentlength + currentseglength > deviationdistance) {
                        remaininglength = deviationdistance - segmentlength;
                        seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                        /#
                            recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x38>", self);
                        #/
                        innerzigzagradius = level.inner_zigzag_radius;
                        outerzigzagradius = level.outer_zigzag_radius;
                        queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
                        positionquery_filter_inclaimedlocation(queryresult, self);
                        if (queryresult.data.size > 0) {
                            point = queryresult.data[randomint(queryresult.data.size)];
                            if (tracepassedonnavmesh(seedposition, point.origin, 16)) {
                                goalpos = point.origin;
                            }
                        }
                        break;
                    }
                    segmentlength += currentseglength;
                }
            }
        }
        self setgoal(goalpos);
        self.nextgoalupdate = gettime() + randomintrange(500, 1000);
    }
    aiprofile_endentry();
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xafe9b428, Offset: 0x6318
// Size: 0x1f0
function zombieenteredplayable(behaviortreeentity) {
    if (!isdefined(level.playable_areas)) {
        level.playable_areas = getentarray("player_volume", "script_noteworthy");
    }
    if (zm_utility::function_21f4ac36()) {
        if (!isdefined(level.var_a2a9b2de)) {
            level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
        }
        node = function_52c1730(behaviortreeentity.origin, level.var_a2a9b2de, 500);
        if (isdefined(node)) {
            if (isdefined(behaviortreeentity.var_ee833cd6)) {
                behaviortreeentity [[ behaviortreeentity.var_ee833cd6 ]]();
            } else {
                behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
            }
            return true;
        }
    }
    if (zm_utility::function_c85ebbbc()) {
        foreach (area in level.playable_areas) {
            if (behaviortreeentity istouching(area)) {
                if (isdefined(behaviortreeentity.var_ee833cd6)) {
                    behaviortreeentity [[ behaviortreeentity.var_ee833cd6 ]]();
                } else {
                    behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
                }
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x10e7646e, Offset: 0x6510
// Size: 0x4e
function shouldmovecondition(behaviortreeentity) {
    if (behaviortreeentity haspath()) {
        return true;
    }
    if (is_true(behaviortreeentity.keep_moving)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x2c108250, Offset: 0x6568
// Size: 0x16
function zombieshouldmoveawaycondition(*behaviortreeentity) {
    return level.wait_and_revive;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x44cf41be, Offset: 0x6588
// Size: 0x2e
function waskilledbyteslacondition(behaviortreeentity) {
    if (is_true(behaviortreeentity.tesla_death)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x3b3d0230, Offset: 0x65c0
// Size: 0x1a
function disablepowerups(behaviortreeentity) {
    behaviortreeentity.no_powerups = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x2d8c9362, Offset: 0x65e8
// Size: 0x16
function enablepowerups(behaviortreeentity) {
    behaviortreeentity.no_powerups = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xb1ab5074, Offset: 0x6608
// Size: 0x2c8
function zombiemoveaway(behaviortreeentity, asmstatename) {
    player = util::gethostplayer();
    if (!isdefined(player)) {
        return 5;
    }
    queryresult = level.move_away_points;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    if (!isdefined(queryresult)) {
        return 5;
    }
    self.keep_moving = 0;
    for (i = 0; i < queryresult.data.size; i++) {
        if (!zm_utility::check_point_in_playable_area(queryresult.data[i].origin)) {
            continue;
        }
        isbehind = vectordot(player.origin - behaviortreeentity.origin, queryresult.data[i].origin - behaviortreeentity.origin);
        if (isbehind < 0) {
            behaviortreeentity setgoal(queryresult.data[i].origin);
            arrayremoveindex(level.move_away_points.data, i, 0);
            i--;
            return 5;
        }
    }
    for (i = 0; i < queryresult.data.size; i++) {
        if (!zm_utility::check_point_in_playable_area(queryresult.data[i].origin)) {
            continue;
        }
        dist_zombie = distancesquared(queryresult.data[i].origin, behaviortreeentity.origin);
        dist_player = distancesquared(queryresult.data[i].origin, player.origin);
        if (dist_zombie < dist_player) {
            behaviortreeentity setgoal(queryresult.data[i].origin);
            arrayremoveindex(level.move_away_points.data, i, 0);
            i--;
            return 5;
        }
    }
    self zm::default_find_exit_point();
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x5c8d5093, Offset: 0x68d8
// Size: 0x2e
function zombieisbeinggrappled(behaviortreeentity) {
    if (is_true(behaviortreeentity.grapple_is_fatal)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xcc3e695d, Offset: 0x6910
// Size: 0x2e
function zombieshouldknockdown(behaviortreeentity) {
    if (is_true(behaviortreeentity.knockdown)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x12860b75, Offset: 0x6948
// Size: 0x2e
function zombieispushed(behaviortreeentity) {
    if (is_true(behaviortreeentity.pushed)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xbe79405b, Offset: 0x6980
// Size: 0xa8
function function_7531db00(behaviortreeentity) {
    aiutility::traversesetup(behaviortreeentity);
    behaviortreeentity.old_powerups = behaviortreeentity.no_powerups;
    disablepowerups(behaviortreeentity);
    behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
    behaviortreeentity pushplayer(1);
    behaviortreeentity callback::callback(#"hash_1518febf00439d5");
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xf06e7e78, Offset: 0x6a30
// Size: 0xc0
function function_1329e086(behaviortreeentity) {
    behaviortreeentity.no_powerups = behaviortreeentity.old_powerups;
    if (!is_true(behaviortreeentity.missinglegs)) {
        behaviortreeentity collidewithactors(0);
        behaviortreeentity.enablepushtime = gettime() + 1000;
    }
    if (isdefined(behaviortreeentity.var_9ed3cc11)) {
        behaviortreeentity pushplayer(behaviortreeentity.var_9ed3cc11);
        behaviortreeentity.var_9ed3cc11 = undefined;
    }
    behaviortreeentity callback::callback(#"hash_34b65342cbfdadac");
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x640052ad, Offset: 0x6af8
// Size: 0x34
function zombiegrappleactionstart(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_grapple_direction", self.grapple_direction);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xd819200a, Offset: 0x6b38
// Size: 0xaa
function zombieknockdownactionstart(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
    behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
    behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
    behaviortreeentity collidewithactors(0);
    behaviortreeentity.blockingpain = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x5 linked
// Checksum 0x25ae61c2, Offset: 0x6bf0
// Size: 0x4c
function private function_c8939973(behaviortreeentity) {
    if (is_true(behaviortreeentity.missinglegs)) {
        behaviortreeentity.knockdown = 0;
        behaviortreeentity collidewithactors(1);
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x5 linked
// Checksum 0x88b114c1, Offset: 0x6c48
// Size: 0x34
function private zombiegetupactionterminate(behaviortreeentity) {
    behaviortreeentity.knockdown = 0;
    behaviortreeentity collidewithactors(1);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x5 linked
// Checksum 0x3090b4, Offset: 0x6c88
// Size: 0x4c
function private zombiepushedactionstart(behaviortreeentity) {
    behaviortreeentity collidewithactors(0);
    behaviortreeentity setblackboardattribute("_push_direction", behaviortreeentity.push_direction);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x5 linked
// Checksum 0xd565aace, Offset: 0x6ce0
// Size: 0x2e
function private zombiepushedactionterminate(behaviortreeentity) {
    behaviortreeentity collidewithactors(1);
    behaviortreeentity.pushed = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x271f09b3, Offset: 0x6d18
// Size: 0x52
function zombieshouldstun(behaviortreeentity) {
    if (behaviortreeentity ai::is_stunned() && !is_true(behaviortreeentity.tesla_death)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x686d1b04, Offset: 0x6d78
// Size: 0x4c
function zombiestunstart(behaviortreeentity) {
    behaviortreeentity pathmode("dont move", 1);
    callback::callback(#"hash_1eda827ff5e6895b");
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x7302c091, Offset: 0x6dd0
// Size: 0x4c
function function_c377438f(behaviortreeentity) {
    behaviortreeentity pathmode("move allowed");
    callback::callback(#"hash_210adcf09e99fba1");
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xc899e24c, Offset: 0x6e28
// Size: 0x48
function zombiestunactionstart(behaviortreeentity, asmstatename) {
    zombiestunstart(behaviortreeentity);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x51d821ca, Offset: 0x6e78
// Size: 0x38
function function_4e52c07(behaviortreeentity, *asmstatename) {
    if (asmstatename ai::is_stunned()) {
        return 5;
    }
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x11da0892, Offset: 0x6eb8
// Size: 0x30
function zombiestunactionend(behaviortreeentity, *asmstatename) {
    function_c377438f(asmstatename);
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xd05a9d75, Offset: 0x6ef0
// Size: 0xb0
function zombietraverseaction(behaviortreeentity, asmstatename) {
    aiutility::traverseactionstart(behaviortreeentity, asmstatename);
    behaviortreeentity.old_powerups = behaviortreeentity.no_powerups;
    disablepowerups(behaviortreeentity);
    behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
    behaviortreeentity pushplayer(1);
    behaviortreeentity callback::callback(#"hash_1518febf00439d5");
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x6d937b51, Offset: 0x6fa8
// Size: 0x100
function zombietraverseactionterminate(behaviortreeentity, asmstatename) {
    aiutility::wpn_debug_bot_joinleave(behaviortreeentity, asmstatename);
    if (behaviortreeentity asmgetstatus() == "asm_status_complete") {
        behaviortreeentity.no_powerups = behaviortreeentity.old_powerups;
        if (!is_true(behaviortreeentity.missinglegs)) {
            behaviortreeentity collidewithactors(0);
            behaviortreeentity.enablepushtime = gettime() + 1000;
        }
        if (isdefined(behaviortreeentity.var_9ed3cc11)) {
            behaviortreeentity pushplayer(behaviortreeentity.var_9ed3cc11);
            behaviortreeentity.var_9ed3cc11 = undefined;
        }
    }
    behaviortreeentity callback::callback(#"hash_34b65342cbfdadac");
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x98452e36, Offset: 0x70b0
// Size: 0x2e
function zombiegottoentrancecondition(behaviortreeentity) {
    if (is_true(behaviortreeentity.got_to_entrance)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x98c326ca, Offset: 0x70e8
// Size: 0x2e
function zombiegottoattackspotcondition(behaviortreeentity) {
    if (is_true(behaviortreeentity.at_entrance_tear_spot)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x6b5a8eb2, Offset: 0x7120
// Size: 0x38
function zombiehasattackspotalreadycondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.attacking_spot_index) && behaviortreeentity.attacking_spot_index >= 0) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x29ff8c90, Offset: 0x7160
// Size: 0x7e
function zombieshouldtearcondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.first_node)) {
        if (isdefined(behaviortreeentity.first_node.zbarrier)) {
            if (isdefined(behaviortreeentity.first_node.barrier_chunks)) {
                if (!zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xa3b713f1, Offset: 0x71e8
// Size: 0x282
function zombieshouldattackthroughboardscondition(behaviortreeentity) {
    if (is_true(behaviortreeentity.missinglegs)) {
        return false;
    }
    if (isdefined(behaviortreeentity.first_node.zbarrier)) {
        if (!behaviortreeentity.first_node.zbarrier zbarriersupportszombiereachthroughattacks()) {
            chunks = undefined;
            if (isdefined(behaviortreeentity.first_node)) {
                chunks = zm_utility::get_non_destroyed_chunks(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);
            }
            if (isdefined(chunks) && chunks.size > 0) {
                return false;
            }
        }
    }
    if (getdvarstring(#"zombie_reachin_freq") == "") {
        setdvar(#"zombie_reachin_freq", 50);
    }
    freq = getdvarint(#"zombie_reachin_freq", 0);
    players = getplayers();
    attack = 0;
    behaviortreeentity.player_targets = [];
    for (i = 0; i < players.size; i++) {
        if (isalive(players[i]) && !isdefined(players[i].revivetrigger) && distance2d(behaviortreeentity.origin, players[i].origin) <= 109.8 && !is_true(players[i].ignoreme)) {
            behaviortreeentity.player_targets[behaviortreeentity.player_targets.size] = players[i];
            attack = 1;
        }
    }
    if (!attack || freq < randomint(100)) {
        return false;
    }
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x28d888fc, Offset: 0x7478
// Size: 0x110
function zombieshouldtauntcondition(behaviortreeentity) {
    if (is_true(behaviortreeentity.missinglegs)) {
        return false;
    }
    if (!isdefined(behaviortreeentity.first_node.zbarrier)) {
        return false;
    }
    if (!behaviortreeentity.first_node.zbarrier zbarriersupportszombietaunts()) {
        return false;
    }
    if (getdvarstring(#"zombie_taunt_freq") == "") {
        setdvar(#"zombie_taunt_freq", 5);
    }
    freq = getdvarint(#"zombie_taunt_freq", 0);
    if (freq >= randomint(100)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x90c4b578, Offset: 0x7590
// Size: 0xc2
function zombieshouldenterplayablecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.first_node) && isdefined(behaviortreeentity.first_node.barrier_chunks)) {
        if (zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
            if ((!isdefined(behaviortreeentity.attacking_spot) || is_true(behaviortreeentity.at_entrance_tear_spot)) && !is_true(behaviortreeentity.completed_emerging_into_playable_area)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x4b54e252, Offset: 0x7660
// Size: 0x24
function ischunkvalidcondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.chunk)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x9d208236, Offset: 0x7690
// Size: 0x2e
function inplayablearea(behaviortreeentity) {
    if (is_true(behaviortreeentity.completed_emerging_into_playable_area)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x340dfbe5, Offset: 0x76c8
// Size: 0x36
function shouldskipteardown(behaviortreeentity) {
    if (behaviortreeentity zm_spawner::should_skip_teardown(behaviortreeentity.find_flesh_struct_string)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xb01d77d1, Offset: 0x7708
// Size: 0x56
function zombieisthinkdone(behaviortreeentity) {
    /#
        if (is_true(behaviortreeentity.is_rat_test)) {
            return false;
        }
    #/
    if (is_true(behaviortreeentity.zombie_think_done)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xe771df6c, Offset: 0x7768
// Size: 0x10c
function zombieisatgoal(behaviortreeentity) {
    goalinfo = behaviortreeentity function_4794d6a3();
    isatscriptgoal = is_true(goalinfo.var_9e404264);
    if (is_true(level.var_21326085)) {
        if (!isatscriptgoal && isdefined(goalinfo.overridegoalpos)) {
            if (abs(goalinfo.overridegoalpos[2] - behaviortreeentity.origin[2]) < 17) {
                dist = distance2dsquared(goalinfo.overridegoalpos, behaviortreeentity.origin);
                if (dist < 289) {
                    return 1;
                }
            }
        }
    }
    return isatscriptgoal;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xda8d7c32, Offset: 0x7880
// Size: 0x7a
function zombieisatentrance(behaviortreeentity) {
    goalinfo = behaviortreeentity function_4794d6a3();
    isatscriptgoal = is_true(goalinfo.var_9e404264);
    isatentrance = isdefined(behaviortreeentity.first_node) && isatscriptgoal;
    return isatentrance;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xed44f407, Offset: 0x7908
// Size: 0x8a
function function_4c12882b(behaviortreeentity) {
    if (!is_true(behaviortreeentity.got_to_entrance)) {
        return false;
    }
    if (isdefined(behaviortreeentity.first_node)) {
        return true;
    }
    node = behaviortreeentity.traversestartnode;
    if (isdefined(node.var_597f08bf) && node.var_597f08bf.targetname === "barricade_window") {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x74df69e1, Offset: 0x79a0
// Size: 0x20a
function function_b86a1b9d(behaviortreeentity) {
    barricades = [isdefined(behaviortreeentity.traversestartnode.var_597f08bf) ? behaviortreeentity.traversestartnode.var_597f08bf : undefined, behaviortreeentity.first_node];
    foreach (barricade in barricades) {
        if (namespace_85745671::function_f4087909(barricade)) {
            /#
                if (getdvarint(#"hash_2f078c2224f40586", 0) && isdefined(barricade.zbarrier)) {
                    record3dtext("<dev string:x46>" + barricade.zbarrier getentnum(), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x38>", behaviortreeentity);
                }
            #/
            return true;
        }
        /#
            if (getdvarint(#"hash_2f078c2224f40586", 0) && isdefined(barricade.zbarrier)) {
                record3dtext("<dev string:x5d>" + barricade.zbarrier getentnum(), behaviortreeentity.origin, (1, 0, 0), "<dev string:x38>", behaviortreeentity);
            }
        #/
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x12e0ca21, Offset: 0x7bb8
// Size: 0x3c
function function_e7f2e349(behaviortreeentity) {
    return function_4c12882b(behaviortreeentity) && function_b86a1b9d(behaviortreeentity);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xb564f559, Offset: 0x7c00
// Size: 0x3e
function function_45009145(behaviortreeentity) {
    ret = is_true(behaviortreeentity.var_348e5e19);
    behaviortreeentity.var_348e5e19 = undefined;
    return ret;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x6876df73, Offset: 0x7c48
// Size: 0x14c
function getchunkservice(behaviortreeentity) {
    if (isdefined(behaviortreeentity.chunk) && isdefined(behaviortreeentity.first_node.zbarrier) && behaviortreeentity.first_node.zbarrier getzbarrierpiecestate(behaviortreeentity.chunk) === "targetted_by_zombie") {
        behaviortreeentity.first_node.zbarrier setzbarrierpiecestate(behaviortreeentity.chunk, "closed");
    }
    behaviortreeentity.chunk = zm_utility::get_closest_non_destroyed_chunk(behaviortreeentity.origin, behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);
    if (isdefined(behaviortreeentity.chunk)) {
        behaviortreeentity.first_node.zbarrier setzbarrierpiecestate(behaviortreeentity.chunk, "targetted_by_zombie");
        behaviortreeentity.first_node thread zm_spawner::check_zbarrier_piece_for_zombie_death(behaviortreeentity.chunk, behaviortreeentity.first_node.zbarrier, behaviortreeentity);
    }
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xe374f1fa, Offset: 0x7da0
// Size: 0x2c
function function_38237e30(behaviortreeentity, *anim) {
    getchunkservice(anim);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x8db57293, Offset: 0x7dd8
// Size: 0x6a
function updatechunkservice(behaviortreeentity) {
    while (0 < behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]) {
        behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]--;
    }
    behaviortreeentity.lastchunk_destroy_time = gettime();
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xe3880786, Offset: 0x7e50
// Size: 0xf2
function updateattackspotservice(behaviortreeentity) {
    if (is_true(behaviortreeentity.marked_for_death) || behaviortreeentity.health < 0) {
        return false;
    }
    if (!isdefined(behaviortreeentity.attacking_spot)) {
        if (!isdefined(behaviortreeentity.first_node) || !behaviortreeentity zm_spawner::get_attack_spot(behaviortreeentity.first_node)) {
            return false;
        }
    }
    if (isdefined(behaviortreeentity.attacking_spot)) {
        behaviortreeentity.goalradius = 17;
        behaviortreeentity function_a57c34b7(behaviortreeentity.attacking_spot);
        if (zombieisatgoal(behaviortreeentity)) {
            behaviortreeentity.at_entrance_tear_spot = 1;
        }
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xb1349447, Offset: 0x7f50
// Size: 0x2a
function function_b3311a1a(behaviortreeentity, *anim) {
    return updateattackspotservice(anim);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xdfff61b1, Offset: 0x7f88
// Size: 0x228
function findnodesservice(behaviortreeentity) {
    node = undefined;
    behaviortreeentity.entrance_nodes = [];
    if (isdefined(behaviortreeentity.find_flesh_struct_string)) {
        if (behaviortreeentity.find_flesh_struct_string == "find_flesh") {
            return 0;
        }
        for (i = 0; i < level.exterior_goals.size; i++) {
            if (isdefined(level.exterior_goals[i].script_string) && level.exterior_goals[i].script_string == behaviortreeentity.find_flesh_struct_string) {
                node = level.exterior_goals[i];
                break;
            }
        }
        for (i = 0; i < level.barrier_align.size; i++) {
            if (isdefined(level.barrier_align[i].script_string) && level.barrier_align[i].script_string == behaviortreeentity.find_flesh_struct_string) {
                behaviortreeentity.barrier_align = level.barrier_align[i];
            }
        }
        behaviortreeentity.entrance_nodes[behaviortreeentity.entrance_nodes.size] = node;
        assert(isdefined(node), "<dev string:x78>" + behaviortreeentity.find_flesh_struct_string + "<dev string:xae>");
        behaviortreeentity.first_node = node;
        goal_pos = getclosestpointonnavmesh(node.origin, 128, self getpathfindingradius());
        behaviortreeentity function_a57c34b7(goal_pos);
        if (zombieisatentrance(behaviortreeentity)) {
            behaviortreeentity.got_to_entrance = 1;
        }
        return 1;
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xa507dd57, Offset: 0x81b8
// Size: 0x60
function function_92d348e2(behaviortreeentity) {
    node = behaviortreeentity.traversestartnode;
    if (isdefined(node.var_597f08bf)) {
        barricade = node.var_597f08bf;
        barricade notify(#"hash_5cfbbb6ee8378665");
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xbebc9770, Offset: 0x8220
// Size: 0x1a2
function zombieattackableobjectservice(behaviortreeentity) {
    if (is_true(behaviortreeentity.ai.var_870d0893)) {
        return;
    }
    if (!behaviortreeentity ai::has_behavior_attribute("use_attackable") || !behaviortreeentity ai::get_behavior_attribute("use_attackable")) {
        namespace_85745671::function_2b925fa5(behaviortreeentity);
        return 0;
    }
    if (is_true(behaviortreeentity.missinglegs)) {
        namespace_85745671::function_2b925fa5(behaviortreeentity);
        return 0;
    }
    if (is_true(behaviortreeentity.aat_turned)) {
        namespace_85745671::function_2b925fa5(behaviortreeentity);
        return 0;
    }
    if (isdefined(behaviortreeentity.var_b238ef38) && !isdefined(behaviortreeentity.attackable)) {
        namespace_85745671::function_2b925fa5(behaviortreeentity);
        return;
    }
    if (!isdefined(behaviortreeentity.attackable)) {
        behaviortreeentity.attackable = namespace_85745671::get_attackable(behaviortreeentity, 1);
        return;
    }
    if (!is_true(behaviortreeentity.attackable.is_active)) {
        behaviortreeentity.attackable = undefined;
    }
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xd088a2cf, Offset: 0x83d0
// Size: 0x38
function zombiemovetoentranceaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.got_to_entrance = 0;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xcaaeacc8, Offset: 0x8410
// Size: 0x3e
function zombiemovetoentranceactionterminate(behaviortreeentity, *asmstatename) {
    if (zombieisatentrance(asmstatename)) {
        asmstatename.got_to_entrance = 1;
    }
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x1a48a5d, Offset: 0x8458
// Size: 0x48
function zombiemovetoattackspotaction(behaviortreeentity, asmstatename) {
    function_6eb4f847(behaviortreeentity);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x92447dab, Offset: 0x84a8
// Size: 0x1a
function function_6eb4f847(behaviortreeentity) {
    behaviortreeentity.at_entrance_tear_spot = 0;
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x7370e3eb, Offset: 0x84d0
// Size: 0x30
function zombiemovetoattackspotactionterminate(behaviortreeentity, *asmstatename) {
    function_547701ae(asmstatename);
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x58e70478, Offset: 0x8508
// Size: 0x1e
function function_547701ae(behaviortreeentity) {
    behaviortreeentity.at_entrance_tear_spot = 1;
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x12436a89, Offset: 0x8530
// Size: 0x98
function zombieholdboardaction(behaviortreeentity, asmstatename) {
    function_f83905d5(behaviortreeentity);
    boardactionast = behaviortreeentity astsearch(asmstatename);
    boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x321b6bb8, Offset: 0x85d0
// Size: 0x98
function function_f83905d5(behaviortreeentity) {
    aiutility::keepclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
    behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x2a46955e, Offset: 0x8670
// Size: 0x30
function zombieholdboardactionterminate(behaviortreeentity, *asmstatename) {
    function_7d0a2e12(asmstatename);
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x925c07b2, Offset: 0x86a8
// Size: 0x98
function function_7d0a2e12(behaviortreeentity) {
    aiutility::keepclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
    behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xe054f389, Offset: 0x8748
// Size: 0x98
function zombiegrabboardaction(behaviortreeentity, asmstatename) {
    function_66a8aef2(behaviortreeentity);
    boardactionast = behaviortreeentity astsearch(asmstatename);
    boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x43171c08, Offset: 0x87e8
// Size: 0xb8
function function_66a8aef2(behaviortreeentity) {
    aiutility::keepclaimnode(behaviortreeentity);
    behaviortreeentity pathmode("dont move");
    behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
    behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xd6f43dc5, Offset: 0x88a8
// Size: 0x30
function zombiegrabboardactionterminate(behaviortreeentity, *asmstatename) {
    function_16251b30(asmstatename);
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xc7f4a66, Offset: 0x88e0
// Size: 0x28
function function_16251b30(behaviortreeentity) {
    aiutility::releaseclaimnode(behaviortreeentity);
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x5819aa6a, Offset: 0x8910
// Size: 0x98
function zombiepullboardaction(behaviortreeentity, asmstatename) {
    function_aa76355a(behaviortreeentity);
    boardactionast = behaviortreeentity astsearch(asmstatename);
    boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x5e961b84, Offset: 0x89b0
// Size: 0x98
function function_aa76355a(behaviortreeentity) {
    aiutility::keepclaimnode(behaviortreeentity);
    behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
    behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x692db8af, Offset: 0x8a50
// Size: 0x30
function zombiepullboardactionterminate(behaviortreeentity, *asmstatename) {
    function_76d619c8(asmstatename);
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xe0d2a46d, Offset: 0x8a88
// Size: 0x32
function function_76d619c8(behaviortreeentity) {
    aiutility::releaseclaimnode(behaviortreeentity);
    self.lastchunk_destroy_time = gettime();
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x671aca, Offset: 0x8ac8
// Size: 0x114
function barricadebreakterminate(behaviortreeentity) {
    behaviortreeentity.pushable = 1;
    behaviortreeentity.blockingpain = 0;
    behaviortreeentity pathmode("move allowed");
    behaviortreeentity clearpath();
    behaviortreeentity animmode("normal", 0);
    behaviortreeentity orientmode("face motion");
    if (zm_utility::is_survival()) {
        if (isdefined(behaviortreeentity.var_67ab7d45)) {
            behaviortreeentity setgoal(behaviortreeentity.var_67ab7d45);
            behaviortreeentity.var_67ab7d45 = undefined;
        }
        callback::function_d8abfc3d(#"hash_34b65342cbfdadac", &function_a26fcba);
    }
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x1 linked
// Checksum 0xa34c131, Offset: 0x8be8
// Size: 0x8a
function function_a26fcba() {
    callback::function_52ac9652(#"hash_34b65342cbfdadac", &function_a26fcba);
    self clearpath();
    self.first_node = undefined;
    self.barrier_align = undefined;
    self zombie_utility::reset_attack_spot();
    self.at_entrance_tear_spot = 0;
    self.got_to_entrance = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x7ab0d305, Offset: 0x8c80
// Size: 0x1e
function function_a5a66d65(behaviortreeentity) {
    behaviortreeentity.var_348e5e19 = 1;
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x9df1d200, Offset: 0x8ca8
// Size: 0x48
function zombieattackthroughboardsaction(behaviortreeentity, asmstatename) {
    function_ebba4d65(behaviortreeentity);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x526b8e48, Offset: 0x8cf8
// Size: 0x36
function function_ebba4d65(behaviortreeentity) {
    aiutility::keepclaimnode(behaviortreeentity);
    behaviortreeentity.boardattack = 1;
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x5d1fece5, Offset: 0x8d38
// Size: 0x30
function zombieattackthroughboardsactionterminate(behaviortreeentity, *asmstatename) {
    function_28b47cc8(asmstatename);
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xc6d8e9e1, Offset: 0x8d70
// Size: 0x32
function function_28b47cc8(behaviortreeentity) {
    aiutility::releaseclaimnode(behaviortreeentity);
    behaviortreeentity.boardattack = 0;
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x60f3af7a, Offset: 0x8db0
// Size: 0x48
function zombietauntaction(behaviortreeentity, asmstatename) {
    function_eb270aac(behaviortreeentity);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x346578a2, Offset: 0x8e00
// Size: 0x28
function function_eb270aac(behaviortreeentity) {
    aiutility::keepclaimnode(behaviortreeentity);
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x299c90d1, Offset: 0x8e30
// Size: 0x30
function zombietauntactionterminate(behaviortreeentity, *asmstatename) {
    function_ba06c8a0(asmstatename);
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x9858f1e3, Offset: 0x8e68
// Size: 0x28
function function_ba06c8a0(behaviortreeentity) {
    aiutility::releaseclaimnode(behaviortreeentity);
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x594acec, Offset: 0x8e98
// Size: 0xe8
function zombiemantleaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.clamptonavmesh = 0;
    if (isdefined(behaviortreeentity.attacking_spot_index)) {
        behaviortreeentity.saved_attacking_spot_index = behaviortreeentity.attacking_spot_index;
        behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    }
    behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
    behaviortreeentity pushplayer(1);
    behaviortreeentity.isinmantleaction = 1;
    behaviortreeentity zombie_utility::reset_attack_spot();
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xff64848c, Offset: 0x8f88
// Size: 0x80
function zombiemantleactionterminate(behaviortreeentity, *asmstatename) {
    asmstatename.clamptonavmesh = 1;
    asmstatename.isinmantleaction = undefined;
    if (isdefined(asmstatename.var_9ed3cc11)) {
        asmstatename pushplayer(asmstatename.var_9ed3cc11);
        asmstatename.var_9ed3cc11 = undefined;
    }
    asmstatename zm_behavior_utility::enteredplayablearea();
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x1 linked
// Checksum 0x64f94c28, Offset: 0x9010
// Size: 0x1cc
function boardtearmocompstart(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompanimflag.barrier_align)) {
        origin = getstartorigin(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
        angles = getstartangles(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
    } else {
        origin = getstartorigin(mocompanimflag.first_node.zbarrier.origin, mocompanimflag.first_node.zbarrier.angles, mocompduration);
        angles = getstartangles(mocompanimflag.first_node.zbarrier.origin, mocompanimflag.first_node.zbarrier.angles, mocompduration);
    }
    mocompanimflag forceteleport(origin, angles, 1);
    mocompanimflag.pushable = 0;
    mocompanimflag.blockingpain = 1;
    mocompanimflag animmode("noclip", 1);
    mocompanimflag orientmode("face angle", angles[1]);
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x1 linked
// Checksum 0xe4c1a923, Offset: 0x91e8
// Size: 0x62
function boardtearmocompupdate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration animmode("noclip", 0);
    mocompduration.pushable = 0;
    mocompduration.blockingpain = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x1 linked
// Checksum 0x10137514, Offset: 0x9258
// Size: 0x272
function barricadeentermocompstart(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompanimflag.barrier_align)) {
        origin = getstartorigin(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
        angles = getstartangles(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
    } else {
        zbarrier_origin = isdefined(mocompanimflag.first_node.zbarrier) ? mocompanimflag.first_node.zbarrier.origin : mocompanimflag.first_node.zbarrier_origin;
        var_f4b27846 = isdefined(mocompanimflag.first_node.zbarrier) ? mocompanimflag.first_node.zbarrier.angles : mocompanimflag.first_node.var_f4b27846;
        origin = getstartorigin(zbarrier_origin, var_f4b27846, mocompduration);
        angles = getstartangles(zbarrier_origin, var_f4b27846, mocompduration);
    }
    if (isdefined(mocompanimflag.mocomp_barricade_offset)) {
        origin += anglestoforward(angles) * mocompanimflag.mocomp_barricade_offset;
    }
    mocompanimflag forceteleport(origin, angles, 1);
    mocompanimflag animmode("noclip", 0);
    mocompanimflag orientmode("face angle", angles[1]);
    mocompanimflag.pushable = 0;
    mocompanimflag.blockingpain = 1;
    mocompanimflag pathmode("dont move");
    mocompanimflag.usegoalanimweight = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x1 linked
// Checksum 0xb03deb2, Offset: 0x94d8
// Size: 0x56
function barricadeentermocompupdate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration animmode("noclip", 0);
    mocompduration.pushable = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x1 linked
// Checksum 0x67220458, Offset: 0x9538
// Size: 0x4e
function barricadeentermocompterminate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    barricadebreakterminate(mocompduration);
    mocompduration.usegoalanimweight = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x1 linked
// Checksum 0x4cea268c, Offset: 0x9590
// Size: 0x272
function barricadeentermocompnozstart(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompanimflag.barrier_align)) {
        origin = getstartorigin(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
        angles = getstartangles(mocompanimflag.barrier_align.origin, mocompanimflag.barrier_align.angles, mocompduration);
    } else {
        zbarrier_origin = isdefined(mocompanimflag.first_node.zbarrier) ? mocompanimflag.first_node.zbarrier.origin : mocompanimflag.first_node.zbarrier_origin;
        var_f4b27846 = isdefined(mocompanimflag.first_node.zbarrier) ? mocompanimflag.first_node.zbarrier.angles : mocompanimflag.first_node.var_f4b27846;
        origin = getstartorigin(zbarrier_origin, var_f4b27846, mocompduration);
        angles = getstartangles(zbarrier_origin, var_f4b27846, mocompduration);
    }
    if (isdefined(mocompanimflag.mocomp_barricade_offset)) {
        origin += anglestoforward(angles) * mocompanimflag.mocomp_barricade_offset;
    }
    mocompanimflag forceteleport(origin, angles, 1);
    mocompanimflag animmode("noclip", 0);
    mocompanimflag orientmode("face angle", angles[1]);
    mocompanimflag.pushable = 0;
    mocompanimflag.blockingpain = 1;
    mocompanimflag pathmode("dont move");
    mocompanimflag.usegoalanimweight = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x1 linked
// Checksum 0x6d0f7e11, Offset: 0x9810
// Size: 0x56
function barricadeentermocompnozupdate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration animmode("noclip", 0);
    mocompduration.pushable = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x1 linked
// Checksum 0xea9e0cd, Offset: 0x9870
// Size: 0xac
function barricadeentermocompnozterminate(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.pushable = 1;
    mocompduration.blockingpain = 0;
    mocompduration pathmode("move allowed");
    mocompduration.usegoalanimweight = 0;
    mocompduration animmode("normal", 0);
    mocompduration orientmode("face motion");
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xec404568, Offset: 0x9928
// Size: 0xac
function notetrackboardtear(animationentity) {
    if (isdefined(animationentity.chunk)) {
        animationentity.first_node.zbarrier setzbarrierpiecestate(animationentity.chunk, "opening");
        level notify(#"zombie_board_tear", {#ai_zombie:animationentity, #s_board:animationentity.first_node});
        animationentity.first_node notify(#"zombie_board_tear");
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x513b0f91, Offset: 0x99e0
// Size: 0x2d4
function notetrackboardmelee(animationentity) {
    assert(animationentity.meleeweapon != level.weaponnone, "<dev string:xc1>");
    if (isdefined(animationentity.first_node)) {
        meleedistsq = 8100;
        if (isdefined(level.attack_player_thru_boards_range)) {
            meleedistsq = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
        }
        triggerdistsq = 2601;
        for (i = 0; i < animationentity.player_targets.size; i++) {
            if (!isdefined(animationentity.player_targets[i])) {
                continue;
            }
            playerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.origin);
            heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.origin[2]);
            if (playerdistsq < meleedistsq && heightdiff * heightdiff < meleedistsq) {
                playertriggerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.first_node.trigger_location.origin);
                heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.first_node.trigger_location.origin[2]);
                if (playertriggerdistsq < triggerdistsq && heightdiff * heightdiff < triggerdistsq) {
                    animationentity.player_targets[i] playsoundtoplayer(#"hash_75318bcffca7ff06", animationentity.player_targets[i]);
                    animationentity.player_targets[i] dodamage(animationentity.meleeweapon.meleedamage, animationentity.origin, self, self, "none", "MOD_MELEE");
                    break;
                }
            }
        }
        return;
    }
    animationentity melee();
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x52ac1017, Offset: 0x9cc0
// Size: 0x3c
function function_b37b8c0d(entity) {
    if (isdefined(entity.first_node)) {
        zm_blockers::open_zbarrier(entity.first_node, 1);
    }
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x1 linked
// Checksum 0x22796dae, Offset: 0x9d08
// Size: 0x1fc
function findzombieenemy() {
    if (isdefined(self.var_8b59c468)) {
        self [[ self.var_8b59c468 ]]();
        return;
    }
    zombies = getaispeciesarray(level.zombie_team, "all");
    zombie_enemy = undefined;
    closest_dist = undefined;
    foreach (zombie in zombies) {
        if (isalive(zombie) && is_true(zombie.completed_emerging_into_playable_area) && !zm_utility::is_magic_bullet_shield_enabled(zombie) && is_true(zombie.canbetargetedbyturnedzombies)) {
            dist = distancesquared(self.origin, zombie.origin);
            if (!isdefined(closest_dist) || dist < closest_dist) {
                closest_dist = dist;
                zombie_enemy = zombie;
            }
        }
    }
    self.favoriteenemy = zombie_enemy;
    if (isdefined(self.favoriteenemy)) {
        self setgoal(self.favoriteenemy.origin);
        return;
    }
    self setgoal(self.origin);
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xe449f58, Offset: 0x9f10
// Size: 0x8e
function zombieblackholebombpullstart(entity, asmstatename) {
    entity.pulltime = gettime();
    entity.pullorigin = entity.origin;
    animationstatenetworkutility::requeststate(entity, asmstatename);
    zombieupdateblackholebombpullstate(entity);
    if (isdefined(entity.damageorigin)) {
        entity.n_zombie_custom_goal_radius = 8;
        entity.v_zombie_custom_goal_pos = entity.damageorigin;
    }
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x46ade508, Offset: 0x9fa8
// Size: 0x76
function zombieupdateblackholebombpullstate(entity) {
    dist_to_bomb = distancesquared(entity.origin, entity.damageorigin);
    if (dist_to_bomb < 16384) {
        entity._black_hole_bomb_collapse_death = 1;
        return;
    }
    if (dist_to_bomb < 1048576) {
        return;
    }
    if (dist_to_bomb > 4227136) {
    }
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x42ab01e2, Offset: 0xa028
// Size: 0x1de
function zombieblackholebombpullupdate(entity, *asmstatename) {
    if (!isdefined(asmstatename.interdimensional_gun_kill)) {
        return 4;
    }
    zombieupdateblackholebombpullstate(asmstatename);
    if (is_true(asmstatename._black_hole_bomb_collapse_death)) {
        asmstatename.skipautoragdoll = 1;
        asmstatename dodamage(asmstatename.health + 666, asmstatename.origin + (0, 0, 50), asmstatename.interdimensional_gun_attacker, undefined, undefined, "MOD_CRUSH");
        return 4;
    }
    if (isdefined(asmstatename.damageorigin)) {
        asmstatename.v_zombie_custom_goal_pos = asmstatename.damageorigin;
    }
    if (!is_true(asmstatename.missinglegs) && gettime() - asmstatename.pulltime > 1000) {
        distsq = distance2dsquared(asmstatename.origin, asmstatename.pullorigin);
        if (distsq < 144) {
            asmstatename setavoidancemask("avoid all");
            asmstatename.cant_move = 1;
            if (isdefined(asmstatename.cant_move_cb)) {
                asmstatename thread [[ asmstatename.cant_move_cb ]]();
            }
        } else {
            asmstatename setavoidancemask("avoid none");
            asmstatename.cant_move = 0;
        }
        asmstatename.pulltime = gettime();
        asmstatename.pullorigin = asmstatename.origin;
    }
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0x50e1b2e4, Offset: 0xa210
// Size: 0x46
function zombieblackholebombpullend(entity, *asmstatename) {
    asmstatename.v_zombie_custom_goal_pos = undefined;
    asmstatename.n_zombie_custom_goal_radius = undefined;
    asmstatename.pulltime = undefined;
    asmstatename.pullorigin = undefined;
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xd02a85cd, Offset: 0xa260
// Size: 0x72
function zombiekilledwhilegettingpulled(entity) {
    if (!is_true(self.missinglegs) && is_true(entity.interdimensional_gun_kill) && !is_true(entity._black_hole_bomb_collapse_death)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xaa246729, Offset: 0xa2e0
// Size: 0x2e
function zombiekilledbyblackholebombcondition(entity) {
    if (is_true(entity._black_hole_bomb_collapse_death)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x32499273, Offset: 0xa318
// Size: 0x2e
function function_38fec26f(entity) {
    if (is_true(entity.freezegun_death)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x11a94293, Offset: 0xa350
// Size: 0x22
function function_e4d7303f(entity) {
    return is_true(entity.var_69a981e6);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x33a29ea4, Offset: 0xa380
// Size: 0xd2
function function_17cd1b17(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    meleedistsq = 4096;
    if (isdefined(behaviortreeentity.meleeweapon) && behaviortreeentity.meleeweapon !== level.weaponnone) {
        meleedistsq = behaviortreeentity.meleeweapon.aimeleerange * behaviortreeentity.meleeweapon.aimeleerange;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > meleedistsq) {
        return false;
    }
    return isdefined(behaviortreeentity.melee_cooldown) && gettime() < behaviortreeentity.melee_cooldown;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xae9dc22b, Offset: 0xa460
// Size: 0x64
function zombiekilledbyblackholebombstart(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    if (isdefined(level.black_hole_bomb_death_start_func)) {
        entity thread [[ level.black_hole_bomb_death_start_func ]](entity.damageorigin, entity.interdimensional_gun_projectile);
    }
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x1 linked
// Checksum 0xd1969093, Offset: 0xa4d0
// Size: 0xe0
function zombiekilledbyblackholebombend(entity, *asmstatename) {
    if (isdefined(level._effect) && isdefined(level._effect[#"black_hole_bomb_zombie_gib"])) {
        fxorigin = asmstatename gettagorigin("tag_origin");
        forward = anglestoforward(asmstatename.angles);
        playfx(level._effect[#"black_hole_bomb_zombie_gib"], fxorigin, forward, (0, 0, 1));
    }
    asmstatename hide();
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xd5193bd2, Offset: 0xa5b8
// Size: 0xbc
function zombiebhbburst(entity) {
    if (isdefined(level._effect) && isdefined(level._effect[#"black_hole_bomb_zombie_destroy"])) {
        fxorigin = entity gettagorigin("tag_origin");
        playfx(level._effect[#"black_hole_bomb_zombie_destroy"], fxorigin);
    }
    if (isdefined(entity.interdimensional_gun_projectile)) {
        entity.interdimensional_gun_projectile notify(#"black_hole_bomb_kill");
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x60fefd9d, Offset: 0xa680
// Size: 0x34
function function_b654f4f5(entity) {
    if (isdefined(level.var_58e6238)) {
        entity [[ level.var_58e6238 ]]();
    }
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x267f1d1b, Offset: 0xa6c0
// Size: 0x30
function function_36b3cb7d(entity) {
    if (isdefined(level.var_f975b6ae)) {
        entity [[ level.var_f975b6ae ]]();
    }
}

// Namespace zm_behavior/zm_behavior
// Params 12, eflags: 0x1 linked
// Checksum 0x83af7eb7, Offset: 0xa6f8
// Size: 0x100
function function_7994fd99(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, *surfacetype) {
    if (isdefined(damage) && isactor(damage) && self.team == damage.team) {
        return -1;
    }
    if (self.archetype == #"zombie" && !isdefined(self.var_9fde8624)) {
        self destructserverutils::handledamage(attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
    }
    return -1;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0xcbdacdb1, Offset: 0xa800
// Size: 0x3f2
function function_4a99b560(entity) {
    /#
        if (getdvarint(#"hash_2c509ee80b516880", 0)) {
            var_8a34a513 = isdefined(entity.enemy) && isarray(entity.enemy.var_f904e440);
            var_79637724 = var_8a34a513 && isinarray(entity.enemy.var_f904e440, entity);
            var_b295b952 = !isdefined(entity.enemy) || distance2dsquared(entity.origin, entity.enemy.origin) <= function_a3f6cdac(100);
            var_6c2051ca = !isdefined(entity.enemy) || !sighttracepassed(entity geteyeapprox(), entity.enemy geteyeapprox(), 1, entity, entity.var_735e0049);
            record3dtext("<dev string:xe7>", entity.origin, var_8a34a513 ? (0, 1, 0) : (1, 0, 0), "<dev string:x102>", entity);
            record3dtext("<dev string:x10c>", entity.origin, var_79637724 ? (0, 1, 0) : (1, 0, 0), "<dev string:x102>", entity);
            record3dtext("<dev string:x126>", entity.origin, var_b295b952 ? (1, 0, 0) : (0, 1, 0), "<dev string:x102>", entity);
            record3dtext("<dev string:x13f>", entity.origin, var_6c2051ca ? (1, 0, 0) : (0, 1, 0), "<dev string:x102>", entity);
            return (var_8a34a513 && var_79637724 && !var_b295b952 && !var_6c2051ca);
        }
    #/
    if (!(isdefined(entity.enemy) && isdefined(entity.enemy.var_f904e440)) || zm_utility::is_survival() && isdefined(entity.current_state) && entity.current_state.name !== #"chase" || !isinarray(entity.enemy.var_f904e440, entity) || distance2dsquared(entity.origin, entity.enemy.origin) <= function_a3f6cdac(100) || !sighttracepassed(entity geteyeapprox(), entity.enemy geteyeapprox(), 1, entity, entity.var_735e0049)) {
        return false;
    }
    return true;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x1 linked
// Checksum 0x74ef1ae7, Offset: 0xac00
// Size: 0x4b4
function function_d5fbbdf8(entity) {
    if (!isdefined(entity.enemy.var_f904e440)) {
        entity.enemy.var_f904e440 = [];
    }
    arrayremovevalue(entity.enemy.var_f904e440, undefined);
    var_a702ff0 = [];
    foreach (zombie in entity.enemy.var_f904e440) {
        if (zombie.enemy !== entity.enemy || zm_utility::is_survival() && isdefined(zombie.current_state) && zombie.current_state.name !== #"chase") {
            var_a702ff0[var_a702ff0.size] = zombie;
        }
    }
    foreach (zombie in var_a702ff0) {
        arrayremovevalue(entity.enemy.var_f904e440, zombie);
    }
    if (!isinarray(entity.enemy.var_f904e440, entity) && entity.enemy.var_f904e440.size < (zm_utility::is_survival() ? 2 : 24)) {
        entity.enemy.var_f904e440[entity.enemy.var_f904e440.size] = entity;
    }
    if (isinarray(entity.enemy.var_f904e440, entity)) {
        if (!isdefined(entity.var_6ca50f69)) {
            entity.var_6ca50f69 = 0;
        }
        if (function_4a99b560(entity)) {
            entity.var_8c4d3e5d = 1;
            entity.var_6ca50f69 = 0;
            entity setgoal(entity.origin);
            entity.keep_moving = 0;
            return;
        }
        step_size = max(100 - distance2d(entity.origin, entity.enemy.origin), 64 + entity.var_6ca50f69 * 64);
        var_e737d2f1 = function_c41c61e8(step_size);
        if (isdefined(var_e737d2f1)) {
            entity.var_6ca50f69 = 0;
            entity setgoal(var_e737d2f1);
            return;
        }
        reacquirestep = entity reacquirestep(step_size, 1);
        if (isdefined(reacquirestep)) {
            entity.var_6ca50f69 = 0;
            entity setgoal(reacquirestep);
            return;
        }
        entity.var_6ca50f69++;
        if (entity.var_6ca50f69 > 4) {
            entity.var_6ca50f69 = undefined;
            if (isdefined(entity.enemy) && isarray(entity.enemy.var_f904e440)) {
                arrayremovevalue(entity.enemy.var_f904e440, entity);
            }
            if (zm_utility::is_survival()) {
                awareness::set_state(entity, #"wander");
            }
        }
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x5 linked
// Checksum 0x720c9e64, Offset: 0xb0c0
// Size: 0x1dc
function private function_c41c61e8(step_size) {
    dir = self.origin - self.enemy.origin;
    dir = vectornormalize((dir[0], dir[1], 0));
    start_point = getclosestpointonnavmesh(self.origin);
    if (isdefined(start_point)) {
        point = checknavmeshdirection(start_point, dir, step_size, self getpathfindingradius() * 1.2);
        if (isdefined(point) && point != start_point && !self isposinclaimedlocation(point) && distancesquared(point, self.origin) > function_a3f6cdac(self.goalradius)) {
            var_18aea779 = self geteyeapprox() - self.origin;
            /#
                recordline(point + var_18aea779, self.enemy geteye(), (1, 0.5, 0), "<dev string:x102>", self);
            #/
            if (sighttracepassed(point + var_18aea779, self.enemy geteye(), 0, self)) {
                return point;
            }
        }
    }
}

