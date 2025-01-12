#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
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
// Params 0, eflags: 0x2
// Checksum 0x6b5c7b2b, Offset: 0x3d8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_behavior", &__init__, &__main__, undefined);
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x0
// Checksum 0x93c02b8e, Offset: 0x428
// Size: 0x144
function __init__() {
    initzmbehaviorsandasm();
    if (!isdefined(level.zigzag_activation_distance)) {
        level.zigzag_activation_distance = 128;
    }
    if (!isdefined(level.zigzag_distance_min)) {
        level.zigzag_distance_min = 200;
    }
    if (!isdefined(level.zigzag_distance_max)) {
        level.zigzag_distance_max = 400;
    }
    if (!isdefined(level.inner_zigzag_radius)) {
        level.inner_zigzag_radius = 0;
    }
    if (!isdefined(level.outer_zigzag_radius)) {
        level.outer_zigzag_radius = 160;
    }
    zm_utility::function_81bbcc91("zombie");
    spawner::add_archetype_spawn_function("zombie", &function_a2b6b3a6);
    spawner::add_archetype_spawn_function("zombie", &zombiespawninit);
    level.do_randomized_zigzag_path = 1;
    level.zombie_targets = [];
    zm::register_actor_damage_callback(&function_207884a0);
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x4
// Checksum 0xaff94b10, Offset: 0x578
// Size: 0x9c
function private zombiespawninit() {
    self pushplayer(0);
    self collidewithactors(0);
    self thread zm_utility::function_eada9bee();
    self.closest_player_override = &zm_utility::function_87d568c4;
    self.var_cd095456 = 1;
    self.var_817e15c1 = 1;
    self.am_i_valid = 1;
    self zm_spawner::zombie_spawn_init();
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x4
// Checksum 0xeaa5b937, Offset: 0x620
// Size: 0x56
function private function_a2b6b3a6() {
    self endon(#"death");
    self waittill(#"completed_emerging_into_playable_area");
    self.var_8c40dbcb = gettime() + self ai::function_a0dbf10a().var_c0b46afd;
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x4
// Checksum 0x3947dc47, Offset: 0x680
// Size: 0x3c
function private __main__() {
    array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, &function_9d6991e8);
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x4
// Checksum 0x94a5ff3c, Offset: 0x6c8
// Size: 0x20e
function private function_9d6991e8() {
    if (isdefined(self._starting_round_number)) {
        self.maxhealth = int(zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), self._starting_round_number) * (isdefined(level.var_b326c393) ? level.var_b326c393 : 1));
        self.health = self.maxhealth;
    } else {
        self zm_cleanup::function_3944eecb();
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
    if (!isdefined(self.no_eye_glow) || !self.no_eye_glow) {
        if (!(isdefined(self.is_inert) && self.is_inert)) {
            self thread zombie_utility::delayed_zombie_eye_glow();
        }
    }
    if (isdefined(level.zombie_init_done)) {
        self [[ level.zombie_init_done ]]();
    }
    self.zombie_init_done = 1;
    self zm_score::function_c4374c52();
    self notify(#"zombie_init_done");
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x4
// Checksum 0xbfdba241, Offset: 0x8e0
// Size: 0x2434
function private initzmbehaviorsandasm() {
    assert(isscriptfunctionptr(&shouldmovecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmove", &shouldmovecondition);
    assert(isscriptfunctionptr(&zombieshouldtearcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtear", &zombieshouldtearcondition);
    assert(isscriptfunctionptr(&zombieshouldattackthroughboardscondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackthroughboards", &zombieshouldattackthroughboardscondition);
    assert(isscriptfunctionptr(&zombieshouldtauntcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldtaunt", &zombieshouldtauntcondition);
    assert(isscriptfunctionptr(&zombiegottoentrancecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoentrance", &zombiegottoentrancecondition);
    assert(isscriptfunctionptr(&zombiegottoattackspotcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegottoattackspot", &zombiegottoattackspotcondition);
    assert(isscriptfunctionptr(&zombiehasattackspotalreadycondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehasattackspotalready", &zombiehasattackspotalreadycondition);
    assert(isscriptfunctionptr(&zombieshouldenterplayablecondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldenterplayable", &zombieshouldenterplayablecondition);
    assert(isscriptfunctionptr(&ischunkvalidcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"ischunkvalid", &ischunkvalidcondition);
    assert(isscriptfunctionptr(&inplayablearea));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"inplayablearea", &inplayablearea);
    assert(isscriptfunctionptr(&shouldskipteardown));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldskipteardown", &shouldskipteardown);
    assert(isscriptfunctionptr(&zombieisthinkdone));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisthinkdone", &zombieisthinkdone);
    assert(isscriptfunctionptr(&zombieisatgoal));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatgoal", &zombieisatgoal);
    assert(isscriptfunctionptr(&zombieisatentrance));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatentrance", &zombieisatentrance);
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
    assert(isscriptfunctionptr(&function_c71ac43d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_18fea53546637859", &function_c71ac43d);
    assert(isscriptfunctionptr(&function_523dc287));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_32d8ffc79910d80b", &function_523dc287);
    assert(isscriptfunctionptr(&function_6940485d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1da059a5800a95c5", &function_6940485d);
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
    assert(!isdefined(&zombiepullboardaction) || isscriptfunctionptr(&zombiepullboardaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiepullboardactionterminate) || isscriptfunctionptr(&zombiepullboardactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"pullboardaction", &zombiepullboardaction, undefined, &zombiepullboardactionterminate);
    assert(!isdefined(&zombieattackthroughboardsaction) || isscriptfunctionptr(&zombieattackthroughboardsaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombieattackthroughboardsactionterminate) || isscriptfunctionptr(&zombieattackthroughboardsactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombieattackthroughboardsaction", &zombieattackthroughboardsaction, undefined, &zombieattackthroughboardsactionterminate);
    assert(!isdefined(&zombietauntaction) || isscriptfunctionptr(&zombietauntaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombietauntactionterminate) || isscriptfunctionptr(&zombietauntactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombietauntaction", &zombietauntaction, undefined, &zombietauntactionterminate);
    assert(!isdefined(&zombiemantleaction) || isscriptfunctionptr(&zombiemantleaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiemantleactionterminate) || isscriptfunctionptr(&zombiemantleactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemantleaction", &zombiemantleaction, undefined, &zombiemantleactionterminate);
    assert(!isdefined(&zombiestunactionstart) || isscriptfunctionptr(&zombiestunactionstart));
    assert(!isdefined(&function_d13cda66) || isscriptfunctionptr(&function_d13cda66));
    assert(!isdefined(&zombiestunactionend) || isscriptfunctionptr(&zombiestunactionend));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiestunaction", &zombiestunactionstart, &function_d13cda66, &zombiestunactionend);
    assert(isscriptfunctionptr(&zombiestunstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestunstart", &zombiestunstart);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_d13cda66) || isscriptfunctionptr(&function_d13cda66));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"zombiestunactionloop", undefined, &function_d13cda66, undefined);
    assert(isscriptfunctionptr(&function_3b7500a2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5cae731c54d7a310", &function_3b7500a2);
    assert(isscriptfunctionptr(&zombiegrappleactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegrappleactionstart", &zombiegrappleactionstart);
    assert(isscriptfunctionptr(&zombieknockdownactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieknockdownactionstart", &zombieknockdownactionstart);
    assert(isscriptfunctionptr(&function_7d550b20));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a6273a84b4237ce", &function_7d550b20);
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
    assert(isscriptfunctionptr(&function_f65daae4));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2574c98f8c8e07ea", &function_f65daae4);
    assert(isscriptfunctionptr(&function_3829cfaf));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65c425729831f505", &function_3829cfaf);
    assert(isscriptfunctionptr(&getchunkservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"getchunkservice", &getchunkservice);
    assert(isscriptfunctionptr(&updatechunkservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"updatechunkservice", &updatechunkservice);
    assert(isscriptfunctionptr(&updateattackspotservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"updateattackspotservice", &updateattackspotservice);
    assert(isscriptfunctionptr(&findnodesservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"findnodesservice", &findnodesservice);
    assert(isscriptfunctionptr(&zombieattackableobjectservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackableobjectservice", &zombieattackableobjectservice);
    assert(isscriptfunctionptr(&function_40d0bd43));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiefindfleshservice", &function_40d0bd43, 1);
    assert(isscriptfunctionptr(&function_419dbb23));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_712f0844b14c72fe", &function_419dbb23, 1);
    assert(isscriptfunctionptr(&zombieenteredplayable));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieenteredplayableservice", &zombieenteredplayable);
    animationstatenetwork::registeranimationmocomp("mocomp_board_tear@zombie", &boardtearmocompstart, &boardtearmocompupdate, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter@zombie", &barricadeentermocompstart, &barricadeentermocompupdate, &barricadeentermocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_barricade_enter_no_z@zombie", &barricadeentermocompnozstart, &barricadeentermocompnozupdate, &barricadeentermocompnozterminate);
    animationstatenetwork::registernotetrackhandlerfunction("destroy_piece", &notetrackboardtear);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_window_melee", &notetrackboardmelee);
    animationstatenetwork::registernotetrackhandlerfunction("smash_board", &function_ff3622ef);
    animationstatenetwork::registernotetrackhandlerfunction("bhb_burst", &zombiebhbburst);
    animationstatenetwork::registernotetrackhandlerfunction("freezegun_hide", &function_3829cfaf);
    setdvar(#"scr_zm_use_code_enemy_selection", 0);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xcd344354, Offset: 0x2d20
// Size: 0x44
function function_40d0bd43(behaviortreeentity) {
    if (isdefined(self.var_77966006)) {
        self [[ self.var_77966006 ]](self);
        return;
    }
    self zombiefindflesh(self);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x6d8a1035, Offset: 0x2d70
// Size: 0x94c
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
    if (behaviortreeentity getpathmode() == "dont move") {
        return;
    }
    behaviortreeentity val::set(#"hash_56179d0919c84732", "ignoreme", 0);
    behaviortreeentity.ignore_player = [];
    behaviortreeentity.goalradius = 30;
    if (isdefined(behaviortreeentity.ignore_find_flesh) && behaviortreeentity.ignore_find_flesh) {
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
    if (isdefined(behaviortreeentity.var_532a149b) && isdefined(behaviortreeentity.var_532a149b.b_is_designated_target) && behaviortreeentity.var_532a149b.b_is_designated_target) {
        designated_target = 1;
    }
    if (!isdefined(behaviortreeentity.var_532a149b) && !isdefined(zombie_poi) && !isdefined(behaviortreeentity.attackable)) {
        if (isdefined(behaviortreeentity.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            behaviortreeentity.ignore_player = [];
        }
        /#
            if (isdefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
                return;
            }
        #/
        if (isdefined(level.no_target_override)) {
            [[ level.no_target_override ]](behaviortreeentity);
            return;
        }
        behaviortreeentity setgoal(behaviortreeentity.origin);
        return;
    } else if (isdefined(level.var_f86a6db6)) {
        [[ level.var_f86a6db6 ]](behaviortreeentity);
    }
    if (!isdefined(level.var_4cc24155) || ![[ level.var_4cc24155 ]]()) {
        behaviortreeentity.enemyoverride = zombie_poi;
        behaviortreeentity.favoriteenemy = behaviortreeentity.var_532a149b;
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
        }
    } else if (isdefined(behaviortreeentity.favoriteenemy)) {
        behaviortreeentity.has_exit_point = undefined;
        behaviortreeentity val::reset(#"attack_properties", "ignoreall");
        if (isdefined(level.enemy_location_override_func)) {
            goalpos = [[ level.enemy_location_override_func ]](behaviortreeentity, behaviortreeentity.favoriteenemy);
            if (isdefined(goalpos)) {
                behaviortreeentity setgoal(goalpos);
            } else {
                behaviortreeentity zombieupdategoal();
            }
        } else if (isdefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {
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
// Params 1, eflags: 0x0
// Checksum 0xfd5f8fc2, Offset: 0x36c8
// Size: 0x3e
function function_419dbb23(behaviortreeentity) {
    behaviortreeentity.var_532a149b = zm_utility::get_closest_valid_player(behaviortreeentity.origin, behaviortreeentity.ignore_player);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x2ac1bdf9, Offset: 0x3710
// Size: 0x414
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
            if (isdefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
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
            if (isdefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {
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
// Params 0, eflags: 0x0
// Checksum 0xd9598696, Offset: 0x3b30
// Size: 0x994
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
        } else if (distancesquared(self.origin, self.favoriteenemy.origin) <= zigzag_activation_distance * zigzag_activation_distance) {
            shouldrepath = 1;
        } else if (isdefined(pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, pathgoalpos);
            shouldrepath = distancetogoalsqr < 72 * 72;
        }
    }
    if (isdefined(level.validate_on_navmesh) && level.validate_on_navmesh) {
        if (!ispointonnavmesh(self.origin, self)) {
            shouldrepath = 0;
        }
    }
    if (isdefined(self.keep_moving) && self.keep_moving) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (self function_482b72a()) {
        shouldrepath = 0;
    }
    if (shouldrepath) {
        if (isplayer(self.favoriteenemy)) {
            goalent = zm_ai_utility::function_93d978d(self, self.favoriteenemy);
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
            if (!isdefined(goalpos) && self.favoriteenemy function_482b72a() && isdefined(self.favoriteenemy.traversestartnode)) {
                goalpos = self.favoriteenemy.traversestartnode.origin;
            }
            if (!isdefined(goalpos)) {
                goalpos = self.origin;
            }
        }
        self setgoal(goalpos);
        should_zigzag = 1;
        if (isdefined(level.should_zigzag)) {
            should_zigzag = self [[ level.should_zigzag ]]();
        } else if (isdefined(self.should_zigzag)) {
            should_zigzag = self.should_zigzag;
        }
        if (isdefined(self.var_bf3d3b68)) {
            should_zigzag = should_zigzag && self.var_bf3d3b68;
        }
        var_35f2180f = 0;
        if (isdefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path && should_zigzag) {
            if (distancesquared(self.origin, goalpos) > zigzag_activation_distance * zigzag_activation_distance) {
                self.keep_moving = 1;
                self.keep_moving_time = gettime() + 250;
                path = self calcapproximatepathtoposition(goalpos, 0);
                /#
                    if (getdvarint(#"ai_debugzigzag", 0)) {
                        for (index = 1; index < path.size; index++) {
                            recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x30>", self);
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
                    if (isdefined(level.var_d04cc94c) && abs(path[index - 1][2] - path[index][2]) > level.var_d04cc94c) {
                        break;
                    }
                    currentseglength = distance(path[index - 1], path[index]);
                    var_e6778ae0 = segmentlength + currentseglength > deviationdistance;
                    if (index == path.size - 1 && !var_e6778ae0) {
                        deviationdistance = segmentlength + currentseglength - 1;
                        var_35f2180f = 1;
                    }
                    if (var_e6778ae0 || var_35f2180f) {
                        remaininglength = deviationdistance - segmentlength;
                        seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                        /#
                            recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x30>", self);
                        #/
                        innerzigzagradius = level.inner_zigzag_radius;
                        if (var_35f2180f) {
                            innerzigzagradius = 16;
                        } else if (isdefined(self.inner_zigzag_radius)) {
                            innerzigzagradius = self.inner_zigzag_radius;
                        }
                        outerzigzagradius = level.outer_zigzag_radius;
                        if (var_35f2180f) {
                            outerzigzagradius = 48;
                        } else if (isdefined(self.outer_zigzag_radius)) {
                            outerzigzagradius = self.outer_zigzag_radius;
                        }
                        queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
                        positionquery_filter_inclaimedlocation(queryresult, self);
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
        self.nextgoalupdate = gettime() + randomintrange(500, 1000);
    }
    aiprofile_endentry();
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x0
// Checksum 0xf4d5f52d, Offset: 0x44d0
// Size: 0x56c
function zombieupdategoalcode() {
    aiprofile_beginentry("zombieUpdateGoalCode");
    shouldrepath = 0;
    if (!shouldrepath && isdefined(self.enemy)) {
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.enemy.origin) <= 200 * 200) {
            shouldrepath = 1;
        } else if (isdefined(self.pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
            shouldrepath = distancetogoalsqr < 72 * 72;
        }
    }
    if (isdefined(self.keep_moving) && self.keep_moving) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (shouldrepath) {
        goalpos = self.enemy.origin;
        if (isdefined(self.enemy.last_valid_position)) {
            var_de879d95 = getclosestpointonnavmesh(self.enemy.last_valid_position, 64, 16);
            if (isdefined(var_de879d95)) {
                goalpos = var_de879d95;
            }
        }
        if (isdefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path) {
            if (distancesquared(self.origin, goalpos) > 240 * 240) {
                self.keep_moving = 1;
                self.keep_moving_time = gettime() + 250;
                path = self calcapproximatepathtoposition(goalpos, 0);
                /#
                    if (getdvarint(#"ai_debugzigzag", 0)) {
                        for (index = 1; index < path.size; index++) {
                            recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x30>", self);
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
                            recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x30>", self);
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
// Params 1, eflags: 0x0
// Checksum 0x61b833de, Offset: 0x4a48
// Size: 0x1f0
function zombieenteredplayable(behaviortreeentity) {
    if (!isdefined(level.playable_areas)) {
        level.playable_areas = getentarray("player_volume", "script_noteworthy");
    }
    if (zm_utility::function_be4cf12d()) {
        if (!isdefined(level.var_4b530519)) {
            level.var_4b530519 = getnodearray("player_region", "script_noteworthy");
        }
        node = function_e910fb8c(behaviortreeentity.origin, level.var_4b530519, 500);
        if (isdefined(node)) {
            if (isdefined(behaviortreeentity.var_b578ce15)) {
                behaviortreeentity [[ behaviortreeentity.var_b578ce15 ]]();
            } else {
                behaviortreeentity zm_spawner::zombie_complete_emerging_into_playable_area();
            }
            return true;
        }
    }
    if (zm_utility::function_a70772a9()) {
        foreach (area in level.playable_areas) {
            if (behaviortreeentity istouching(area)) {
                if (isdefined(behaviortreeentity.var_b578ce15)) {
                    behaviortreeentity [[ behaviortreeentity.var_b578ce15 ]]();
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
// Params 1, eflags: 0x0
// Checksum 0xb4eef7ea, Offset: 0x4c40
// Size: 0x54
function shouldmovecondition(behaviortreeentity) {
    if (behaviortreeentity haspath()) {
        return true;
    }
    if (isdefined(behaviortreeentity.keep_moving) && behaviortreeentity.keep_moving) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xe36a08fa, Offset: 0x4ca0
// Size: 0x16
function zombieshouldmoveawaycondition(behaviortreeentity) {
    return level.wait_and_revive;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x125f7dd, Offset: 0x4cc0
// Size: 0x34
function waskilledbyteslacondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xc1dc010e, Offset: 0x4d00
// Size: 0x1a
function disablepowerups(behaviortreeentity) {
    behaviortreeentity.no_powerups = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x12395c7a, Offset: 0x4d28
// Size: 0x1a
function enablepowerups(behaviortreeentity) {
    behaviortreeentity.no_powerups = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xae45cdd3, Offset: 0x4d50
// Size: 0x2c6
function zombiemoveaway(behaviortreeentity, asmstatename) {
    player = util::gethostplayer();
    queryresult = level.move_away_points;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    if (!isdefined(queryresult)) {
        return 5;
    }
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
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x234f1bc0, Offset: 0x5020
// Size: 0x34
function zombieisbeinggrappled(behaviortreeentity) {
    if (isdefined(behaviortreeentity.grapple_is_fatal) && behaviortreeentity.grapple_is_fatal) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xffd8358e, Offset: 0x5060
// Size: 0x34
function zombieshouldknockdown(behaviortreeentity) {
    if (isdefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x385c47bd, Offset: 0x50a0
// Size: 0x34
function zombieispushed(behaviortreeentity) {
    if (isdefined(behaviortreeentity.pushed) && behaviortreeentity.pushed) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x23e00fa1, Offset: 0x50e0
// Size: 0x34
function zombiegrappleactionstart(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_grapple_direction", self.grapple_direction);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xfe94d77a, Offset: 0x5120
// Size: 0xaa
function zombieknockdownactionstart(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
    behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
    behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
    behaviortreeentity collidewithactors(0);
    behaviortreeentity.blockingpain = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x4
// Checksum 0xd78a359e, Offset: 0x51d8
// Size: 0x54
function private function_7d550b20(behaviortreeentity) {
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
        behaviortreeentity.knockdown = 0;
        behaviortreeentity collidewithactors(1);
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x4
// Checksum 0xd55b3bba, Offset: 0x5238
// Size: 0x34
function private zombiegetupactionterminate(behaviortreeentity) {
    behaviortreeentity.knockdown = 0;
    behaviortreeentity collidewithactors(1);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x4
// Checksum 0xff710a9b, Offset: 0x5278
// Size: 0x4c
function private zombiepushedactionstart(behaviortreeentity) {
    behaviortreeentity collidewithactors(0);
    behaviortreeentity setblackboardattribute("_push_direction", behaviortreeentity.push_direction);
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x4
// Checksum 0xfb3d46ff, Offset: 0x52d0
// Size: 0x32
function private zombiepushedactionterminate(behaviortreeentity) {
    behaviortreeentity collidewithactors(1);
    behaviortreeentity.pushed = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x5b00ca08, Offset: 0x5310
// Size: 0x54
function zombieshouldstun(behaviortreeentity) {
    if (behaviortreeentity ai::is_stunned() && !(isdefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x9bcd6bcb, Offset: 0x5370
// Size: 0x4c
function zombiestunstart(behaviortreeentity) {
    behaviortreeentity pathmode("dont move", 1);
    callback::callback(#"hash_1eda827ff5e6895b");
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xb068425e, Offset: 0x53c8
// Size: 0x4c
function function_3b7500a2(behaviortreeentity) {
    behaviortreeentity pathmode("move allowed");
    callback::callback(#"hash_210adcf09e99fba1");
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xcb576368, Offset: 0x5420
// Size: 0x48
function zombiestunactionstart(behaviortreeentity, asmstatename) {
    zombiestunstart(behaviortreeentity);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x7c6e3284, Offset: 0x5470
// Size: 0x38
function function_d13cda66(behaviortreeentity, asmstatename) {
    if (behaviortreeentity ai::is_stunned()) {
        return 5;
    }
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x5d9caf20, Offset: 0x54b0
// Size: 0x30
function zombiestunactionend(behaviortreeentity, asmstatename) {
    function_3b7500a2(behaviortreeentity);
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x5cc13dee, Offset: 0x54e8
// Size: 0x98
function zombietraverseaction(behaviortreeentity, asmstatename) {
    aiutility::traverseactionstart(behaviortreeentity, asmstatename);
    behaviortreeentity.old_powerups = behaviortreeentity.no_powerups;
    disablepowerups(behaviortreeentity);
    behaviortreeentity.var_f3f83845 = behaviortreeentity function_effb2fc();
    behaviortreeentity pushplayer(1);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x21c4c79e, Offset: 0x5588
// Size: 0xf2
function zombietraverseactionterminate(behaviortreeentity, asmstatename) {
    aiutility::function_e745ade6(behaviortreeentity, asmstatename);
    if (behaviortreeentity asmgetstatus() == "asm_status_complete") {
        behaviortreeentity.no_powerups = behaviortreeentity.old_powerups;
        if (!(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)) {
            behaviortreeentity collidewithactors(0);
            behaviortreeentity.enablepushtime = gettime() + 1000;
        }
        if (isdefined(behaviortreeentity.var_f3f83845)) {
            behaviortreeentity pushplayer(behaviortreeentity.var_f3f83845);
            behaviortreeentity.var_f3f83845 = undefined;
        }
    }
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x9945a305, Offset: 0x5688
// Size: 0x34
function zombiegottoentrancecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.got_to_entrance) && behaviortreeentity.got_to_entrance) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x447111ca, Offset: 0x56c8
// Size: 0x34
function zombiegottoattackspotcondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.at_entrance_tear_spot) && behaviortreeentity.at_entrance_tear_spot) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x53a80868, Offset: 0x5708
// Size: 0x38
function zombiehasattackspotalreadycondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.attacking_spot_index) && behaviortreeentity.attacking_spot_index >= 0) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xabe88d2a, Offset: 0x5748
// Size: 0x6e
function zombieshouldtearcondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.first_node) && isdefined(behaviortreeentity.first_node.barrier_chunks)) {
        if (!zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x5a923037, Offset: 0x57c0
// Size: 0x2c2
function zombieshouldattackthroughboardscondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
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
        if (isalive(players[i]) && !isdefined(players[i].revivetrigger) && distance2d(behaviortreeentity.origin, players[i].origin) <= 109.8 && !(isdefined(players[i].ignoreme) && players[i].ignoreme)) {
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
// Params 1, eflags: 0x0
// Checksum 0x3f7d3ec1, Offset: 0x5a90
// Size: 0x118
function zombieshouldtauntcondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
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
// Params 1, eflags: 0x0
// Checksum 0xc3300b49, Offset: 0x5bb0
// Size: 0xcc
function zombieshouldenterplayablecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.first_node) && isdefined(behaviortreeentity.first_node.barrier_chunks)) {
        if (zm_utility::all_chunks_destroyed(behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks)) {
            if ((!isdefined(behaviortreeentity.attacking_spot) || isdefined(behaviortreeentity.at_entrance_tear_spot) && behaviortreeentity.at_entrance_tear_spot) && !(isdefined(behaviortreeentity.completed_emerging_into_playable_area) && behaviortreeentity.completed_emerging_into_playable_area)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x93e99472, Offset: 0x5c88
// Size: 0x24
function ischunkvalidcondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.chunk)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x3311608d, Offset: 0x5cb8
// Size: 0x34
function inplayablearea(behaviortreeentity) {
    if (isdefined(behaviortreeentity.completed_emerging_into_playable_area) && behaviortreeentity.completed_emerging_into_playable_area) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xc6d6eb16, Offset: 0x5cf8
// Size: 0x36
function shouldskipteardown(behaviortreeentity) {
    if (behaviortreeentity zm_spawner::should_skip_teardown(behaviortreeentity.find_flesh_struct_string)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x9898d3a1, Offset: 0x5d38
// Size: 0x5c
function zombieisthinkdone(behaviortreeentity) {
    /#
        if (isdefined(behaviortreeentity.is_rat_test) && behaviortreeentity.is_rat_test) {
            return false;
        }
    #/
    if (isdefined(behaviortreeentity.zombie_think_done) && behaviortreeentity.zombie_think_done) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xa067a531, Offset: 0x5da0
// Size: 0x5c
function zombieisatgoal(behaviortreeentity) {
    goalinfo = behaviortreeentity function_e9a79b0e();
    isatscriptgoal = isdefined(goalinfo.var_7e7e6ebb) && goalinfo.var_7e7e6ebb;
    return isatscriptgoal;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xef761ce2, Offset: 0x5e08
// Size: 0x7e
function zombieisatentrance(behaviortreeentity) {
    goalinfo = behaviortreeentity function_e9a79b0e();
    isatscriptgoal = isdefined(goalinfo.var_7e7e6ebb) && goalinfo.var_7e7e6ebb;
    isatentrance = isdefined(behaviortreeentity.first_node) && isatscriptgoal;
    return isatentrance;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x41f43ad7, Offset: 0x5e90
// Size: 0xdc
function getchunkservice(behaviortreeentity) {
    behaviortreeentity.chunk = zm_utility::get_closest_non_destroyed_chunk(behaviortreeentity.origin, behaviortreeentity.first_node, behaviortreeentity.first_node.barrier_chunks);
    if (isdefined(behaviortreeentity.chunk)) {
        behaviortreeentity.first_node.zbarrier setzbarrierpiecestate(behaviortreeentity.chunk, "targetted_by_zombie");
        behaviortreeentity.first_node thread zm_spawner::check_zbarrier_piece_for_zombie_death(behaviortreeentity.chunk, behaviortreeentity.first_node.zbarrier, behaviortreeentity);
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x43020787, Offset: 0x5f78
// Size: 0x76
function updatechunkservice(behaviortreeentity) {
    while (0 < behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]) {
        behaviortreeentity.first_node.zbarrier.chunk_health[behaviortreeentity.chunk]--;
    }
    behaviortreeentity.lastchunk_destroy_time = gettime();
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x53aae023, Offset: 0x5ff8
// Size: 0xee
function updateattackspotservice(behaviortreeentity) {
    if (isdefined(behaviortreeentity.marked_for_death) && behaviortreeentity.marked_for_death || behaviortreeentity.health < 0) {
        return false;
    }
    if (!isdefined(behaviortreeentity.attacking_spot)) {
        if (!behaviortreeentity zm_spawner::get_attack_spot(behaviortreeentity.first_node)) {
            return false;
        }
    }
    if (isdefined(behaviortreeentity.attacking_spot)) {
        behaviortreeentity.goalradius = 8;
        behaviortreeentity function_3c8dce03(behaviortreeentity.attacking_spot);
        if (zombieisatgoal(behaviortreeentity)) {
            behaviortreeentity.at_entrance_tear_spot = 1;
        }
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xb0254e31, Offset: 0x60f0
// Size: 0x1a4
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
        behaviortreeentity.entrance_nodes[behaviortreeentity.entrance_nodes.size] = node;
        assert(isdefined(node), "<dev string:x3b>" + behaviortreeentity.find_flesh_struct_string + "<dev string:x6e>");
        behaviortreeentity.first_node = node;
        behaviortreeentity.goalradius = 128;
        behaviortreeentity function_3c8dce03(node.origin);
        if (zombieisatentrance(behaviortreeentity)) {
            behaviortreeentity.got_to_entrance = 1;
        }
        return 1;
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x68c5eed3, Offset: 0x62a0
// Size: 0x12e
function zombieattackableobjectservice(behaviortreeentity) {
    if (!behaviortreeentity ai::has_behavior_attribute("use_attackable") || !behaviortreeentity ai::get_behavior_attribute("use_attackable")) {
        behaviortreeentity.attackable = undefined;
        return 0;
    }
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
        behaviortreeentity.attackable = undefined;
        return 0;
    }
    if (isdefined(behaviortreeentity.aat_turned) && behaviortreeentity.aat_turned) {
        behaviortreeentity.attackable = undefined;
        return 0;
    }
    if (!isdefined(behaviortreeentity.attackable)) {
        behaviortreeentity.attackable = zm_attackables::get_attackable();
        return;
    }
    if (!(isdefined(behaviortreeentity.attackable.is_active) && behaviortreeentity.attackable.is_active)) {
        behaviortreeentity.attackable = undefined;
    }
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x30bdbeaa, Offset: 0x63d8
// Size: 0x40
function zombiemovetoentranceaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.got_to_entrance = 0;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x444bfdb3, Offset: 0x6420
// Size: 0x42
function zombiemovetoentranceactionterminate(behaviortreeentity, asmstatename) {
    if (zombieisatentrance(behaviortreeentity)) {
        behaviortreeentity.got_to_entrance = 1;
    }
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xc0307e00, Offset: 0x6470
// Size: 0x40
function zombiemovetoattackspotaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.at_entrance_tear_spot = 0;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xb674bd8, Offset: 0x64b8
// Size: 0x26
function zombiemovetoattackspotactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity.at_entrance_tear_spot = 1;
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xc34f227b, Offset: 0x64e8
// Size: 0xf8
function zombieholdboardaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 1;
    behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
    behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    boardactionast = behaviortreeentity astsearch(asmstatename);
    boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xd52c5bf8, Offset: 0x65e8
// Size: 0x26
function zombieholdboardactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 0;
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xba15bb2f, Offset: 0x6618
// Size: 0xf8
function zombiegrabboardaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 1;
    behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
    behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    boardactionast = behaviortreeentity astsearch(asmstatename);
    boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xd297369a, Offset: 0x6718
// Size: 0x26
function zombiegrabboardactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 0;
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xb107dcb5, Offset: 0x6748
// Size: 0xf8
function zombiepullboardaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 1;
    behaviortreeentity setblackboardattribute("_which_board_pull", int(behaviortreeentity.chunk));
    behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    boardactionast = behaviortreeentity astsearch(asmstatename);
    boardactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, boardactionast[#"animation"]);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x473d0133, Offset: 0x6848
// Size: 0x32
function zombiepullboardactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 0;
    self.lastchunk_destroy_time = gettime();
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x4277d934, Offset: 0x6888
// Size: 0x50
function zombieattackthroughboardsaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 1;
    behaviortreeentity.boardattack = 1;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xe939c760, Offset: 0x68e0
// Size: 0x32
function zombieattackthroughboardsactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 0;
    behaviortreeentity.boardattack = 0;
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xb75ee3fa, Offset: 0x6920
// Size: 0x40
function zombietauntaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 1;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x772fd22c, Offset: 0x6968
// Size: 0x26
function zombietauntactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity.keepclaimednode = 0;
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xd0a0404, Offset: 0x6998
// Size: 0xf8
function zombiemantleaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.clamptonavmesh = 0;
    if (isdefined(behaviortreeentity.attacking_spot_index)) {
        behaviortreeentity.saved_attacking_spot_index = behaviortreeentity.attacking_spot_index;
        behaviortreeentity setblackboardattribute("_board_attack_spot", float(behaviortreeentity.attacking_spot_index));
    }
    behaviortreeentity.var_f3f83845 = behaviortreeentity function_effb2fc();
    behaviortreeentity pushplayer(1);
    behaviortreeentity.isinmantleaction = 1;
    behaviortreeentity zombie_utility::reset_attack_spot();
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0x68e76551, Offset: 0x6a98
// Size: 0x80
function zombiemantleactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity.clamptonavmesh = 1;
    behaviortreeentity.isinmantleaction = undefined;
    if (isdefined(behaviortreeentity.var_f3f83845)) {
        behaviortreeentity pushplayer(behaviortreeentity.var_f3f83845);
        behaviortreeentity.var_f3f83845 = undefined;
    }
    behaviortreeentity zm_behavior_utility::enteredplayablearea();
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x0
// Checksum 0x3f2f40d9, Offset: 0x6b20
// Size: 0x164
function boardtearmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    origin = getstartorigin(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
    angles = getstartangles(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
    entity forceteleport(origin, angles, 1);
    entity.pushable = 0;
    entity.blockingpain = 1;
    entity animmode("noclip", 1);
    entity orientmode("face angle", angles[1]);
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x0
// Checksum 0x9e4f5357, Offset: 0x6c90
// Size: 0x6a
function boardtearmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("noclip", 0);
    entity.pushable = 0;
    entity.blockingpain = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x0
// Checksum 0x2adebfb7, Offset: 0x6d08
// Size: 0x1ca
function barricadeentermocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    origin = getstartorigin(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
    angles = getstartangles(entity.first_node.zbarrier.origin, entity.first_node.zbarrier.angles, mocompanim);
    if (isdefined(entity.mocomp_barricade_offset)) {
        origin += anglestoforward(angles) * entity.mocomp_barricade_offset;
    }
    entity forceteleport(origin, angles, 1);
    entity animmode("noclip", 0);
    entity orientmode("face angle", angles[1]);
    entity.pushable = 0;
    entity.blockingpain = 1;
    entity pathmode("dont move");
    entity.usegoalanimweight = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x0
// Checksum 0x9246b651, Offset: 0x6ee0
// Size: 0x5a
function barricadeentermocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("noclip", 0);
    entity.pushable = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x0
// Checksum 0x55c79318, Offset: 0x6f48
// Size: 0xb4
function barricadeentermocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.pushable = 1;
    entity.blockingpain = 0;
    entity pathmode("move allowed");
    entity.usegoalanimweight = 0;
    entity animmode("normal", 0);
    entity orientmode("face motion");
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x0
// Checksum 0xa69c6a3f, Offset: 0x7008
// Size: 0x1fa
function barricadeentermocompnozstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    zbarrier_origin = (entity.first_node.zbarrier.origin[0], entity.first_node.zbarrier.origin[1], entity.origin[2]);
    origin = getstartorigin(zbarrier_origin, entity.first_node.zbarrier.angles, mocompanim);
    angles = getstartangles(zbarrier_origin, entity.first_node.zbarrier.angles, mocompanim);
    if (isdefined(entity.mocomp_barricade_offset)) {
        origin += anglestoforward(angles) * entity.mocomp_barricade_offset;
    }
    entity forceteleport(origin, angles, 1);
    entity animmode("noclip", 0);
    entity orientmode("face angle", angles[1]);
    entity.pushable = 0;
    entity.blockingpain = 1;
    entity pathmode("dont move");
    entity.usegoalanimweight = 1;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x0
// Checksum 0x3d21c541, Offset: 0x7210
// Size: 0x5a
function barricadeentermocompnozupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("noclip", 0);
    entity.pushable = 0;
}

// Namespace zm_behavior/zm_behavior
// Params 5, eflags: 0x0
// Checksum 0x582301c7, Offset: 0x7278
// Size: 0xb4
function barricadeentermocompnozterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.pushable = 1;
    entity.blockingpain = 0;
    entity pathmode("move allowed");
    entity.usegoalanimweight = 0;
    entity animmode("normal", 0);
    entity orientmode("face motion");
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xf8e34f71, Offset: 0x7338
// Size: 0x54
function notetrackboardtear(animationentity) {
    if (isdefined(animationentity.chunk)) {
        animationentity.first_node.zbarrier setzbarrierpiecestate(animationentity.chunk, "opening");
    }
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x51dbbb01, Offset: 0x7398
// Size: 0x2ac
function notetrackboardmelee(animationentity) {
    assert(animationentity.meleeweapon != level.weaponnone, "<dev string:x7e>");
    if (isdefined(animationentity.first_node)) {
        meleedistsq = 8100;
        if (isdefined(level.attack_player_thru_boards_range)) {
            meleedistsq = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
        }
        triggerdistsq = 2601;
        for (i = 0; i < animationentity.player_targets.size; i++) {
            playerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.origin);
            heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.origin[2]);
            if (playerdistsq < meleedistsq && heightdiff * heightdiff < meleedistsq) {
                playertriggerdistsq = distance2dsquared(animationentity.player_targets[i].origin, animationentity.first_node.trigger_location.origin);
                heightdiff = abs(animationentity.player_targets[i].origin[2] - animationentity.first_node.trigger_location.origin[2]);
                if (playertriggerdistsq < triggerdistsq && heightdiff * heightdiff < triggerdistsq) {
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
// Params 1, eflags: 0x0
// Checksum 0xc9da203f, Offset: 0x7650
// Size: 0x3c
function function_ff3622ef(entity) {
    if (isdefined(entity.first_node)) {
        zm_blockers::open_zbarrier(entity.first_node, 1);
    }
}

// Namespace zm_behavior/zm_behavior
// Params 0, eflags: 0x0
// Checksum 0xaa4e083c, Offset: 0x7698
// Size: 0x1dc
function findzombieenemy() {
    zombies = getaispeciesarray(level.zombie_team, "all");
    zombie_enemy = undefined;
    closest_dist = undefined;
    foreach (zombie in zombies) {
        if (isalive(zombie) && isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area && !zm_utility::is_magic_bullet_shield_enabled(zombie) && isdefined(zombie.canbetargetedbyturnedzombies) && zombie.canbetargetedbyturnedzombies) {
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
// Params 2, eflags: 0x0
// Checksum 0x233909, Offset: 0x7880
// Size: 0xa6
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
// Params 1, eflags: 0x0
// Checksum 0x1b754a52, Offset: 0x7930
// Size: 0x82
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
// Params 2, eflags: 0x0
// Checksum 0x312c7827, Offset: 0x79c0
// Size: 0x212
function zombieblackholebombpullupdate(entity, asmstatename) {
    if (!isdefined(entity.interdimensional_gun_kill)) {
        return 4;
    }
    zombieupdateblackholebombpullstate(entity);
    if (isdefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death) {
        entity.skipautoragdoll = 1;
        entity dodamage(entity.health + 666, entity.origin + (0, 0, 50), entity.interdimensional_gun_attacker, undefined, undefined, "MOD_CRUSH");
        return 4;
    }
    if (isdefined(entity.damageorigin)) {
        entity.v_zombie_custom_goal_pos = entity.damageorigin;
    }
    if (!(isdefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.pulltime > 1000) {
        distsq = distance2dsquared(entity.origin, entity.pullorigin);
        if (distsq < 144) {
            entity setavoidancemask("avoid all");
            entity.cant_move = 1;
            if (isdefined(entity.cant_move_cb)) {
                entity thread [[ entity.cant_move_cb ]]();
            }
        } else {
            entity setavoidancemask("avoid none");
            entity.cant_move = 0;
        }
        entity.pulltime = gettime();
        entity.pullorigin = entity.origin;
    }
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xf7a4a179, Offset: 0x7be0
// Size: 0x46
function zombieblackholebombpullend(entity, asmstatename) {
    entity.v_zombie_custom_goal_pos = undefined;
    entity.n_zombie_custom_goal_radius = undefined;
    entity.pulltime = undefined;
    entity.pullorigin = undefined;
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x14e16442, Offset: 0x7c30
// Size: 0x78
function zombiekilledwhilegettingpulled(entity) {
    if (!(isdefined(self.missinglegs) && self.missinglegs) && isdefined(entity.interdimensional_gun_kill) && entity.interdimensional_gun_kill && !(isdefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death)) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xfb9a9249, Offset: 0x7cb0
// Size: 0x34
function zombiekilledbyblackholebombcondition(entity) {
    if (isdefined(entity._black_hole_bomb_collapse_death) && entity._black_hole_bomb_collapse_death) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x1c6b645a, Offset: 0x7cf0
// Size: 0x34
function function_c71ac43d(entity) {
    if (isdefined(entity.freezegun_death) && entity.freezegun_death) {
        return true;
    }
    return false;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xee83782, Offset: 0x7d30
// Size: 0x28
function function_523dc287(entity) {
    return isdefined(entity.var_3059fa07) && entity.var_3059fa07;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0x9d203a11, Offset: 0x7d60
// Size: 0xe2
function function_6940485d(behaviortreeentity) {
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
// Params 2, eflags: 0x0
// Checksum 0x14b35823, Offset: 0x7e50
// Size: 0x68
function zombiekilledbyblackholebombstart(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    if (isdefined(level.black_hole_bomb_death_start_func)) {
        entity thread [[ level.black_hole_bomb_death_start_func ]](entity.damageorigin, entity.interdimensional_gun_projectile);
    }
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 2, eflags: 0x0
// Checksum 0xa154382, Offset: 0x7ec0
// Size: 0xe8
function zombiekilledbyblackholebombend(entity, asmstatename) {
    if (isdefined(level._effect) && isdefined(level._effect[#"black_hole_bomb_zombie_gib"])) {
        fxorigin = entity gettagorigin("tag_origin");
        forward = anglestoforward(entity.angles);
        playfx(level._effect[#"black_hole_bomb_zombie_gib"], fxorigin, forward, (0, 0, 1));
    }
    entity hide();
    return 4;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xe02c3eaa, Offset: 0x7fb0
// Size: 0xc0
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
// Params 1, eflags: 0x0
// Checksum 0x75f74f8a, Offset: 0x8078
// Size: 0x34
function function_f65daae4(entity) {
    if (isdefined(level.var_e4cff484)) {
        entity [[ level.var_e4cff484 ]]();
    }
    return 5;
}

// Namespace zm_behavior/zm_behavior
// Params 1, eflags: 0x0
// Checksum 0xa105303c, Offset: 0x80b8
// Size: 0x30
function function_3829cfaf(entity) {
    if (isdefined(level.var_cd039377)) {
        entity [[ level.var_cd039377 ]]();
    }
}

// Namespace zm_behavior/zm_behavior
// Params 12, eflags: 0x0
// Checksum 0xcc31d53b, Offset: 0x80f0
// Size: 0x100
function function_207884a0(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isdefined(attacker) && isactor(attacker) && self.team == attacker.team) {
        return -1;
    }
    if (self.archetype == "zombie") {
        self destructserverutils::handledamage(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
    return -1;
}

