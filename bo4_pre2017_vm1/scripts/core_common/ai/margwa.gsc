#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/margwa;
#using scripts/core_common/ai/systems/animation_state_machine_mocomp;
#using scripts/core_common/ai/systems/animation_state_machine_notetracks;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai/zombie_utility;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/fx_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace namespace_6c6fd2b0;

// Namespace namespace_6c6fd2b0/margwa
// Params 0, eflags: 0x2
// Checksum 0x692c98ed, Offset: 0xbd0
// Size: 0x374
function autoexec init() {
    function_618e8c7d();
    spawner::add_archetype_spawn_function("margwa", &function_6c01c950);
    spawner::add_archetype_spawn_function("margwa", &namespace_c96301ee::function_eac87e92);
    clientfield::register("actor", "margwa_head_left", 1, 2, "int");
    clientfield::register("actor", "margwa_head_mid", 1, 2, "int");
    clientfield::register("actor", "margwa_head_right", 1, 2, "int");
    clientfield::register("actor", "margwa_fx_in", 1, 1, "counter");
    clientfield::register("actor", "margwa_fx_out", 1, 1, "counter");
    clientfield::register("actor", "margwa_fx_spawn", 1, 1, "counter");
    clientfield::register("actor", "margwa_smash", 1, 1, "counter");
    clientfield::register("actor", "margwa_head_left_hit", 1, 1, "counter");
    clientfield::register("actor", "margwa_head_mid_hit", 1, 1, "counter");
    clientfield::register("actor", "margwa_head_right_hit", 1, 1, "counter");
    clientfield::register("actor", "margwa_head_killed", 1, 2, "int");
    clientfield::register("actor", "margwa_jaw", 1, 6, "int");
    clientfield::register("toplayer", "margwa_head_explosion", 1, 1, "counter");
    clientfield::register("scriptmover", "margwa_fx_travel", 1, 1, "int");
    clientfield::register("scriptmover", "margwa_fx_travel_tell", 1, 1, "int");
    clientfield::register("actor", "supermargwa", 1, 1, "int");
    function_ce6a5d8a();
}

// Namespace namespace_6c6fd2b0/margwa
// Params 0, eflags: 0x4
// Checksum 0x24a610d, Offset: 0xf50
// Size: 0x11e
function private function_ce6a5d8a() {
    if (!isdefined(level.var_dbb10dd8)) {
        level.var_dbb10dd8 = [];
    }
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "ray_gun";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "ray_gun_upgraded";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "pistol_standard_upgraded";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "pistol_revolver38_upgraded";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "pistol_revolver38lh_upgraded";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "launcher_standard";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "launcher_standard_upgraded";
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x0
// Checksum 0xb6700b2e, Offset: 0x1078
// Size: 0xae
function function_5f9266e0(weaponname) {
    foreach (weapon in level.var_dbb10dd8) {
        if (weapon == weaponname) {
            return;
        }
    }
    level.var_dbb10dd8[level.var_dbb10dd8.size] = weaponname;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 0, eflags: 0x4
// Checksum 0xbf17cc7d, Offset: 0x1130
// Size: 0xf24
function private function_618e8c7d() {
    /#
        assert(isscriptfunctionptr(&margwatargetservice));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTargetService", &margwatargetservice);
    /#
        assert(isscriptfunctionptr(&margwashouldsmashattack));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSmashAttack", &margwashouldsmashattack);
    /#
        assert(isscriptfunctionptr(&margwashouldswipeattack));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSwipeAttack", &margwashouldswipeattack);
    /#
        assert(isscriptfunctionptr(&margwashouldshowpain));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldShowPain", &margwashouldshowpain);
    /#
        assert(isscriptfunctionptr(&margwashouldreactstun));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactStun", &margwashouldreactstun);
    /#
        assert(isscriptfunctionptr(&function_177ffb7f));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactIDGun", &function_177ffb7f);
    /#
        assert(isscriptfunctionptr(&function_f779aea3));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactSword", &function_f779aea3);
    /#
        assert(isscriptfunctionptr(&margwashouldspawn));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSpawn", &margwashouldspawn);
    /#
        assert(isscriptfunctionptr(&function_41769342));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldFreeze", &function_41769342);
    /#
        assert(isscriptfunctionptr(&function_9782fb97));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldTeleportIn", &function_9782fb97);
    /#
        assert(isscriptfunctionptr(&function_ee830c62));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldTeleportOut", &function_ee830c62);
    /#
        assert(isscriptfunctionptr(&function_8526bc6c));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldWait", &function_8526bc6c);
    /#
        assert(isscriptfunctionptr(&margwashouldreset));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReset", &margwashouldreset);
    /#
        assert(!isdefined(&margwareactstunaction) || isscriptfunctionptr(&margwareactstunaction));
    #/
    /#
        assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    #/
    /#
        assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    #/
    behaviortreenetworkutility::registerbehaviortreeaction("margwaReactStunAction", &margwareactstunaction, undefined, undefined);
    /#
        assert(!isdefined(&margwaswipeattackaction) || isscriptfunctionptr(&margwaswipeattackaction));
    #/
    /#
        assert(!isdefined(&function_43d6f899) || isscriptfunctionptr(&function_43d6f899));
    #/
    /#
        assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    #/
    behaviortreenetworkutility::registerbehaviortreeaction("margwaSwipeAttackAction", &margwaswipeattackaction, &function_43d6f899, undefined);
    /#
        assert(isscriptfunctionptr(&margwaidlestart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaIdleStart", &margwaidlestart);
    /#
        assert(isscriptfunctionptr(&margwamovestart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaMoveStart", &margwamovestart);
    /#
        assert(isscriptfunctionptr(&margwatraverseactionstart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTraverseActionStart", &margwatraverseactionstart);
    /#
        assert(isscriptfunctionptr(&function_f4326d46));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportInStart", &function_f4326d46);
    /#
        assert(isscriptfunctionptr(&function_d6861357));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportInTerminate", &function_d6861357);
    /#
        assert(isscriptfunctionptr(&function_a3b5ed13));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportOutStart", &function_a3b5ed13);
    /#
        assert(isscriptfunctionptr(&function_9bf18b02));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportOutTerminate", &function_9bf18b02);
    /#
        assert(isscriptfunctionptr(&margwapainstart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaPainStart", &margwapainstart);
    /#
        assert(isscriptfunctionptr(&margwapainterminate));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaPainTerminate", &margwapainterminate);
    /#
        assert(isscriptfunctionptr(&margwareactstunstart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactStunStart", &margwareactstunstart);
    /#
        assert(isscriptfunctionptr(&margwareactstunterminate));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactStunTerminate", &margwareactstunterminate);
    /#
        assert(isscriptfunctionptr(&function_bd904c32));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactIDGunStart", &function_bd904c32);
    /#
        assert(isscriptfunctionptr(&function_8219ce43));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactIDGunTerminate", &function_8219ce43);
    /#
        assert(isscriptfunctionptr(&function_78a5c7d6));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactSwordStart", &function_78a5c7d6);
    /#
        assert(isscriptfunctionptr(&function_976fb907));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactSwordTerminate", &function_976fb907);
    /#
        assert(isscriptfunctionptr(&margwaspawnstart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSpawnStart", &margwaspawnstart);
    /#
        assert(isscriptfunctionptr(&margwasmashattackstart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSmashAttackStart", &margwasmashattackstart);
    /#
        assert(isscriptfunctionptr(&margwasmashattackterminate));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSmashAttackTerminate", &margwasmashattackterminate);
    /#
        assert(isscriptfunctionptr(&margwaswipeattackstart));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSwipeAttackStart", &margwaswipeattackstart);
    /#
        assert(isscriptfunctionptr(&margwaswipeattackterminate));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSwipeAttackTerminate", &margwaswipeattackterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@margwa", &function_405168ca, &function_95847de7, &function_8bdd20c9);
    animationstatenetwork::registernotetrackhandlerfunction("margwa_smash_attack", &function_f28be431);
    animationstatenetwork::registernotetrackhandlerfunction("margwa_bodyfall large", &function_c2a638dc);
    animationstatenetwork::registernotetrackhandlerfunction("margwa_melee_fire", &function_13e0502d);
}

// Namespace namespace_6c6fd2b0/margwa
// Params 0, eflags: 0x4
// Checksum 0x629bfa2b, Offset: 0x2060
// Size: 0x5c
function private function_6c01c950() {
    blackboard::createblackboardforentity(self);
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
    self.___archetypeonanimscriptedcallback = &function_4bc01a36;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x5119915c, Offset: 0x20c8
// Size: 0x34
function private function_4bc01a36(entity) {
    entity.__blackboard = undefined;
    entity function_6c01c950();
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xd67e852d, Offset: 0x2108
// Size: 0x34c
function private function_f28be431(entity) {
    players = getplayers();
    foreach (player in players) {
        var_c06eca13 = entity.origin + vectorscale(anglestoforward(self.angles), 60);
        distsq = distancesquared(var_c06eca13, player.origin);
        if (distsq < 20736) {
            if (!isgodmode(player)) {
                if (isdefined(player.hasriotshield) && player.hasriotshield) {
                    damageshield = 0;
                    attackdir = player.origin - self.origin;
                    if (isdefined(player.hasriotshieldequipped) && player.hasriotshieldequipped) {
                        if (player namespace_c96301ee::function_2edfc800(attackdir, 0.2)) {
                            damageshield = 1;
                        }
                    } else if (player namespace_c96301ee::function_2edfc800(attackdir, 0.2, 0)) {
                        damageshield = 1;
                    }
                    if (damageshield) {
                        self clientfield::increment("margwa_smash");
                        shield_damage = level.weaponriotshield.weaponstarthitpoints;
                        if (isdefined(player.weaponriotshield)) {
                            shield_damage = player.weaponriotshield.weaponstarthitpoints;
                        }
                        player [[ player.player_shield_apply_damage ]](shield_damage, 0);
                        continue;
                    }
                }
                if (isdefined(level.var_d8750101) && isfunctionptr(level.var_d8750101)) {
                    if (player [[ level.var_d8750101 ]](self)) {
                        continue;
                    }
                }
                self clientfield::increment("margwa_smash");
                player dodamage(166, self.origin, self);
            }
        }
    }
    if (isdefined(self.var_d3a99070)) {
        self [[ self.var_d3a99070 ]]();
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x8ee6f69b, Offset: 0x2460
// Size: 0x60
function private function_c2a638dc(entity) {
    if (self.archetype == "margwa") {
        entity ghost();
        if (isdefined(self.var_b4036965)) {
            self [[ self.var_b4036965 ]]();
        }
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xa53bbc03, Offset: 0x24c8
// Size: 0x24
function private function_13e0502d(entity) {
    entity melee();
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xcae6a4ea, Offset: 0x24f8
// Size: 0x168
function private margwatargetservice(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
    if (!isdefined(player)) {
        if (isdefined(self.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            self.ignore_player = [];
        }
        self setgoal(self.origin);
        return 0;
    }
    targetpos = getclosestpointonnavmesh(player.origin, 64, 30);
    if (isdefined(targetpos)) {
        entity setgoal(targetpos);
        return 1;
    }
    entity setgoal(entity.origin);
    return 0;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x0
// Checksum 0xadf461d2, Offset: 0x2668
// Size: 0x8e
function margwashouldsmashattack(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!entity namespace_c96301ee::function_4e77203(entity.enemy)) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x0
// Checksum 0x1da475b7, Offset: 0x2700
// Size: 0xa6
function margwashouldswipeattack(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > 16384) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xb39ea652, Offset: 0x27b0
// Size: 0xfe
function private margwashouldshowpain(entity) {
    if (isdefined(entity.headdestroyed)) {
        headinfo = entity.head[entity.headdestroyed];
        switch (headinfo.cf) {
        case #"margwa_head_left":
            self setblackboardattribute("_margwa_head", "left");
            break;
        case #"margwa_head_mid":
            self setblackboardattribute("_margwa_head", "middle");
            break;
        case #"margwa_head_right":
            self setblackboardattribute("_margwa_head", "right");
            break;
        }
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x7723473f, Offset: 0x28b8
// Size: 0x3a
function private margwashouldreactstun(entity) {
    if (isdefined(entity.var_9e59b56e) && entity.var_9e59b56e) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x46b8c2af, Offset: 0x2900
// Size: 0x3a
function private function_177ffb7f(entity) {
    if (isdefined(entity.var_843f1731) && entity.var_843f1731) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x5c75a324, Offset: 0x2948
// Size: 0x3a
function private function_f779aea3(entity) {
    if (isdefined(entity.var_70e85a9d) && entity.var_70e85a9d) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x7ddb84df, Offset: 0x2990
// Size: 0x3a
function private margwashouldspawn(entity) {
    if (isdefined(entity.var_c7ae07c2) && entity.var_c7ae07c2) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x48f8a65e, Offset: 0x29d8
// Size: 0x3a
function private function_41769342(entity) {
    if (isdefined(entity.isfrozen) && entity.isfrozen) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x89747f0, Offset: 0x2a20
// Size: 0x3a
function private function_9782fb97(entity) {
    if (isdefined(entity.var_b830cb9) && entity.var_b830cb9) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x6693e902, Offset: 0x2a68
// Size: 0x3a
function private function_ee830c62(entity) {
    if (isdefined(entity.var_3993b370) && entity.var_3993b370) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x1dacfaf2, Offset: 0x2ab0
// Size: 0x3a
function private function_8526bc6c(entity) {
    if (isdefined(entity.waiting) && entity.waiting) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xdd7261d1, Offset: 0x2af8
// Size: 0xaa
function private margwashouldreset(entity) {
    if (isdefined(entity.headdestroyed)) {
        return true;
    }
    if (isdefined(entity.var_843f1731) && entity.var_843f1731) {
        return true;
    }
    if (isdefined(entity.var_70e85a9d) && entity.var_70e85a9d) {
        return true;
    }
    if (isdefined(entity.var_9e59b56e) && entity.var_9e59b56e) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 2, eflags: 0x4
// Checksum 0xb404e5e7, Offset: 0x2bb0
// Size: 0xf0
function private margwareactstunaction(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    var_a0d3cbe5 = entity astsearch(istring(asmstatename));
    var_aee9e36b = animationstatenetworkutility::searchanimationmap(entity, var_a0d3cbe5["animation"]);
    closetime = getanimlength(var_aee9e36b) * 1000;
    entity namespace_c96301ee::function_b09c53b4(closetime);
    margwareactstunstart(entity);
    return 5;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 2, eflags: 0x4
// Checksum 0x587d8930, Offset: 0x2ca8
// Size: 0xe8
function private margwaswipeattackaction(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    if (!isdefined(entity.var_5ed154c5)) {
        var_6efece41 = entity astsearch(istring(asmstatename));
        var_a6752387 = animationstatenetworkutility::searchanimationmap(entity, var_6efece41["animation"]);
        var_9535398c = getanimlength(var_a6752387) * 1000;
        entity.var_5ed154c5 = gettime() + var_9535398c;
    }
    return 5;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 2, eflags: 0x4
// Checksum 0x37db685a, Offset: 0x2d98
// Size: 0x46
function private function_43d6f899(entity, asmstatename) {
    if (isdefined(entity.var_5ed154c5) && gettime() > entity.var_5ed154c5) {
        return 4;
    }
    return 5;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xf565a830, Offset: 0x2de8
// Size: 0x44
function private margwaidlestart(entity) {
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 1);
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x280cca19, Offset: 0x2e38
// Size: 0x8c
function private margwamovestart(entity) {
    if (entity namespace_c96301ee::function_33361523()) {
        if (entity.zombie_move_speed == "run") {
            entity clientfield::set("margwa_jaw", 13);
            return;
        }
        entity clientfield::set("margwa_jaw", 7);
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x6efe74d4, Offset: 0x2ed0
// Size: 0xc
function private function_d663d52(entity) {
    
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x132d48a0, Offset: 0x2ee8
// Size: 0x14e
function private margwatraverseactionstart(entity) {
    entity setblackboardattribute("_traversal_type", entity.traversestartnode.animscript);
    if (isdefined(entity.traversestartnode.animscript)) {
        if (entity namespace_c96301ee::function_33361523()) {
            switch (entity.traversestartnode.animscript) {
            case #"hash_eaab94b4":
                entity clientfield::set("margwa_jaw", 21);
                break;
            case #"hash_8c592bf2":
                entity clientfield::set("margwa_jaw", 22);
                break;
            case #"hash_7851f8b5":
                entity clientfield::set("margwa_jaw", 24);
                break;
            case #"hash_d6a46177":
                entity clientfield::set("margwa_jaw", 25);
                break;
            }
        }
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x68b2e017, Offset: 0x3040
// Size: 0x154
function private function_f4326d46(entity) {
    entity unlink();
    if (isdefined(entity.var_16410986)) {
        entity forceteleport(entity.var_16410986);
    }
    entity show();
    entity pathmode("move allowed");
    entity.var_b830cb9 = 0;
    self setblackboardattribute("_margwa_teleport", "in");
    if (isdefined(self.var_58ce2260)) {
        self.var_58ce2260 clientfield::set("margwa_fx_travel", 0);
    }
    self clientfield::increment("margwa_fx_in", 1);
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 17);
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x0
// Checksum 0x3802f90, Offset: 0x31a0
// Size: 0x4c
function function_d6861357(entity) {
    if (isdefined(self.var_58ce2260)) {
        self.var_58ce2260 clientfield::set("margwa_fx_travel", 0);
    }
    entity.isteleporting = 0;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x21c31fcd, Offset: 0x31f8
// Size: 0xcc
function private function_a3b5ed13(entity) {
    entity.var_3993b370 = 0;
    entity.isteleporting = 1;
    entity.var_e9eccbbc = entity.origin;
    self setblackboardattribute("_margwa_teleport", "out");
    self clientfield::increment("margwa_fx_out", 1);
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 18);
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x34b82fde, Offset: 0x32d0
// Size: 0x134
function private function_9bf18b02(entity) {
    if (isdefined(entity.var_58ce2260)) {
        entity.var_58ce2260.origin = entity gettagorigin("j_spine_1");
        entity.var_58ce2260 clientfield::set("margwa_fx_travel", 1);
    }
    entity ghost();
    entity pathmode("dont move");
    if (isdefined(entity.var_58ce2260)) {
        entity linkto(entity.var_58ce2260);
    }
    if (isdefined(entity.var_11ba7521)) {
        entity thread [[ entity.var_11ba7521 ]]();
        return;
    }
    entity thread namespace_c96301ee::function_11ba7521();
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xa5510f34, Offset: 0x3410
// Size: 0x12c
function private margwapainstart(entity) {
    entity notify(#"hash_a78415a");
    if (entity namespace_c96301ee::function_33361523()) {
        head = self getblackboardattribute("_margwa_head");
        switch (head) {
        case #"left":
            entity clientfield::set("margwa_jaw", 3);
            break;
        case #"middle":
            entity clientfield::set("margwa_jaw", 4);
            break;
        case #"right":
            entity clientfield::set("margwa_jaw", 5);
            break;
        }
    }
    entity.headdestroyed = undefined;
    entity.var_894f701d = 0;
    entity.candamage = 0;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x37df8ddb, Offset: 0x3548
// Size: 0x74
function private margwapainterminate(entity) {
    entity.headdestroyed = undefined;
    entity.var_894f701d = 1;
    entity.candamage = 1;
    entity namespace_c96301ee::function_b09c53b4(5000);
    entity clearpath();
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x75ad0ae3, Offset: 0x35c8
// Size: 0x64
function private margwareactstunstart(entity) {
    entity.var_9e59b56e = undefined;
    entity.var_894f701d = 0;
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 6);
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x0
// Checksum 0xe64fa04, Offset: 0x3638
// Size: 0x20
function margwareactstunterminate(entity) {
    entity.var_894f701d = 1;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x7f3b6285, Offset: 0x3660
// Size: 0x13c
function private function_bd904c32(entity) {
    entity.var_843f1731 = undefined;
    entity.var_894f701d = 0;
    var_15006cdd = 0;
    if (entity getblackboardattribute("_zombie_damageweapon_type") == "regular") {
        if (entity namespace_c96301ee::function_33361523()) {
            entity clientfield::set("margwa_jaw", 8);
        }
        entity namespace_c96301ee::function_b09c53b4(5000);
    } else {
        if (entity namespace_c96301ee::function_33361523()) {
            entity clientfield::set("margwa_jaw", 9);
        }
        entity namespace_c96301ee::function_b09c53b4(10000);
        var_15006cdd = 1;
    }
    if (isdefined(entity.var_afb57718)) {
        entity [[ entity.var_afb57718 ]](var_15006cdd);
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x0
// Checksum 0xb5aad234, Offset: 0x37a8
// Size: 0x44
function function_8219ce43(entity) {
    entity.var_894f701d = 1;
    entity setblackboardattribute("_zombie_damageweapon_type", "regular");
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xee579895, Offset: 0x37f8
// Size: 0x58
function private function_78a5c7d6(entity) {
    entity.var_70e85a9d = undefined;
    entity.var_894f701d = 0;
    if (isdefined(entity.var_337c5d83)) {
        entity.var_337c5d83 notify(#"hash_3f13116c");
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xebb36534, Offset: 0x3858
// Size: 0x20
function private function_976fb907(entity) {
    entity.var_894f701d = 1;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x7ec5282, Offset: 0x3880
// Size: 0x1c
function private margwaspawnstart(entity) {
    entity.var_c7ae07c2 = 0;
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0xd1c99f3c, Offset: 0x38a8
// Size: 0x5c
function private margwasmashattackstart(entity) {
    entity namespace_c96301ee::function_41d4a9e4();
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 14);
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x0
// Checksum 0x43e77625, Offset: 0x3910
// Size: 0x24
function margwasmashattackterminate(entity) {
    entity namespace_c96301ee::function_b09c53b4();
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x0
// Checksum 0x13dcb6e9, Offset: 0x3940
// Size: 0x44
function margwaswipeattackstart(entity) {
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 16);
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 1, eflags: 0x4
// Checksum 0x69b052de, Offset: 0x3990
// Size: 0x24
function private margwaswipeattackterminate(entity) {
    entity namespace_c96301ee::function_b09c53b4();
}

// Namespace namespace_6c6fd2b0/margwa
// Params 5, eflags: 0x4
// Checksum 0x96802dcb, Offset: 0x39c0
// Size: 0x144
function private function_405168ca(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traverseendnode)) {
        entity.var_e9eccbbc = entity.origin;
        entity.var_16410986 = entity.traverseendnode.origin;
        self clientfield::increment("margwa_fx_out", 1);
        if (isdefined(entity.traversestartnode)) {
            if (isdefined(entity.traversestartnode.speed)) {
                self.var_ea7c154 = entity.traversestartnode.speed;
            }
        }
    }
}

// Namespace namespace_6c6fd2b0/margwa
// Params 5, eflags: 0x4
// Checksum 0x90ef658c, Offset: 0x3b10
// Size: 0x2c
function private function_95847de7(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

// Namespace namespace_6c6fd2b0/margwa
// Params 5, eflags: 0x4
// Checksum 0x30125933, Offset: 0x3b48
// Size: 0x44
function private function_8bdd20c9(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    function_9bf18b02(entity);
}

#namespace namespace_c96301ee;

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x4
// Checksum 0x77dfe0bb, Offset: 0x3b98
// Size: 0x240
function private function_eac87e92() {
    self disableaimassist();
    self.disableammodrop = 1;
    self.no_gib = 1;
    self.ignore_nuke = 1;
    self.ignore_enemy_count = 1;
    self.zombie_move_speed = "walk";
    self.overrideactordamage = &function_b59ae4e9;
    self.candamage = 1;
    self.var_a0c7c5f = 3;
    self.var_4e09343b = 0;
    self function_ba853eca("c_zom_margwa_chunks_le", "j_chunk_head_bone_le");
    self function_ba853eca("c_zom_margwa_chunks_mid", "j_chunk_head_bone");
    self function_ba853eca("c_zom_margwa_chunks_ri", "j_chunk_head_bone_ri");
    self.var_b77c9d35 = 600;
    self function_69913a5a();
    self.var_58ce2260 = spawn("script_model", self.origin);
    self.var_58ce2260 setmodel("tag_origin");
    self.var_58ce2260 notsolid();
    self.var_6a46ac61 = spawn("script_model", self.origin);
    self.var_6a46ac61 setmodel("tag_origin");
    self.var_6a46ac61 notsolid();
    self thread function_cbfbf8ac();
    self.updatesight = 0;
    self.ignorerunandgundist = 1;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x4
// Checksum 0x55d01a66, Offset: 0x3de0
// Size: 0x84
function private function_cbfbf8ac() {
    self waittill("death");
    if (isdefined(self.var_9e9a84fb)) {
        self.var_9e9a84fb notify(#"margwa_kill");
    }
    if (isdefined(self.var_58ce2260)) {
        self.var_58ce2260 delete();
    }
    if (isdefined(self.var_6a46ac61)) {
        self.var_6a46ac61 delete();
    }
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x0
// Checksum 0xb6186270, Offset: 0x3e70
// Size: 0x14
function function_21573f43() {
    self.var_894f701d = 1;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x4
// Checksum 0x9d6ff6ef, Offset: 0x3e90
// Size: 0x10
function private function_69913a5a() {
    self.var_894f701d = 0;
}

// Namespace namespace_c96301ee/margwa
// Params 2, eflags: 0x4
// Checksum 0xcec6eff6, Offset: 0x3ea8
// Size: 0x4ac
function private function_ba853eca(headmodel, var_edc01299) {
    model = headmodel;
    var_23a2fd22 = undefined;
    switch (headmodel) {
    case #"c_zom_margwa_chunks_le":
        if (isdefined(level.var_2c028bba)) {
            model = level.var_2c028bba;
            var_23a2fd22 = level.var_4182a531;
        }
        break;
    case #"c_zom_margwa_chunks_mid":
        if (isdefined(level.var_72374095)) {
            model = level.var_72374095;
            var_23a2fd22 = level.var_7ff16e00;
        }
        break;
    case #"c_zom_margwa_chunks_ri":
        if (isdefined(level.var_c9a18bd)) {
            model = level.var_c9a18bd;
            var_23a2fd22 = level.var_b9c5d5f0;
        }
        break;
    }
    self attach(model);
    if (!isdefined(self.head)) {
        self.head = [];
    }
    self.head[model] = spawnstruct();
    self.head[model].model = model;
    self.head[model].tag = var_edc01299;
    self.head[model].health = 600;
    self.head[model].candamage = 0;
    self.head[model].open = 1;
    self.head[model].closed = 2;
    self.head[model].smash = 3;
    switch (headmodel) {
    case #"c_zom_margwa_chunks_le":
        self.head[model].cf = "margwa_head_left";
        self.head[model].var_92dc0464 = "margwa_head_left_hit";
        self.head[model].gore = "c_zom_margwa_gore_le";
        if (isdefined(var_23a2fd22)) {
            self.head[model].gore = var_23a2fd22;
        }
        self.head[model].var_ac197c3f = 1;
        self.var_5e150e0b = model;
        break;
    case #"c_zom_margwa_chunks_mid":
        self.head[model].cf = "margwa_head_mid";
        self.head[model].var_92dc0464 = "margwa_head_mid_hit";
        self.head[model].gore = "c_zom_margwa_gore_mid";
        if (isdefined(var_23a2fd22)) {
            self.head[model].gore = var_23a2fd22;
        }
        self.head[model].var_ac197c3f = 2;
        self.var_170dfeda = model;
        break;
    case #"c_zom_margwa_chunks_ri":
        self.head[model].cf = "margwa_head_right";
        self.head[model].var_92dc0464 = "margwa_head_right_hit";
        self.head[model].gore = "c_zom_margwa_gore_ri";
        if (isdefined(var_23a2fd22)) {
            self.head[model].gore = var_23a2fd22;
        }
        self.head[model].var_ac197c3f = 3;
        self.var_b406e5f2 = model;
        break;
    }
    self thread function_6d2d2ad3(self.head[model]);
}

// Namespace namespace_c96301ee/margwa
// Params 1, eflags: 0x0
// Checksum 0x27985a6f, Offset: 0x4360
// Size: 0xa2
function function_53ce09a(health) {
    self.var_b77c9d35 = health;
    foreach (head in self.head) {
        head.health = health;
    }
}

// Namespace namespace_c96301ee/margwa
// Params 2, eflags: 0x4
// Checksum 0xe55c88ce, Offset: 0x4410
// Size: 0x46
function private function_cd7a8132(min, max) {
    time = gettime() + randomintrange(min, max);
    return time;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x4
// Checksum 0x9db010bf, Offset: 0x4460
// Size: 0x48
function private function_a509fa6e() {
    if (self.var_a0c7c5f > 1) {
        if (self.var_4e09343b < self.var_a0c7c5f - 1) {
            return true;
        }
    } else {
        return true;
    }
    return false;
}

// Namespace namespace_c96301ee/margwa
// Params 1, eflags: 0x4
// Checksum 0x769f4110, Offset: 0x44b0
// Size: 0x2a8
function private function_6d2d2ad3(headinfo) {
    self endon(#"death");
    self endon(#"hash_a78415a");
    headinfo notify(#"hash_a78415a");
    headinfo endon(#"hash_a78415a");
    while (true) {
        if (self ispaused()) {
            util::wait_network_frame();
            continue;
        }
        if (!isdefined(headinfo.closetime)) {
            if (self.var_a0c7c5f == 1) {
                headinfo.closetime = function_cd7a8132(500, 1000);
            } else {
                headinfo.closetime = function_cd7a8132(1500, 3500);
            }
        }
        if (gettime() > headinfo.closetime && self function_a509fa6e()) {
            self.var_4e09343b++;
            headinfo.closetime = undefined;
        } else {
            util::wait_network_frame();
            continue;
        }
        self function_78a5758c(headinfo, 1);
        self clientfield::set(headinfo.cf, headinfo.open);
        self playsoundontag("zmb_vocals_margwa_ambient", headinfo.tag);
        while (true) {
            if (!isdefined(headinfo.opentime)) {
                headinfo.opentime = function_cd7a8132(3000, 5000);
            }
            if (gettime() > headinfo.opentime) {
                self.var_4e09343b--;
                headinfo.opentime = undefined;
                break;
            }
            util::wait_network_frame();
            continue;
        }
        self function_78a5758c(headinfo, 0);
        self clientfield::set(headinfo.cf, headinfo.closed);
    }
}

// Namespace namespace_c96301ee/margwa
// Params 2, eflags: 0x4
// Checksum 0x9c766965, Offset: 0x4760
// Size: 0x3c
function private function_78a5758c(headinfo, candamage) {
    self endon(#"death");
    wait 0.1;
    headinfo.candamage = candamage;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x4
// Checksum 0x175ed826, Offset: 0x47a8
// Size: 0x1c2
function private function_41d4a9e4() {
    self notify(#"hash_a78415a");
    var_b5497362 = [];
    foreach (head in self.head) {
        if (head.health > 0) {
            var_b5497362[var_b5497362.size] = head;
        }
    }
    var_b5497362 = array::randomize(var_b5497362);
    open = 0;
    foreach (head in var_b5497362) {
        if (!open) {
            head.candamage = 1;
            self clientfield::set(head.cf, head.smash);
            open = 1;
            continue;
        }
        self function_5adc4b54(head);
    }
}

// Namespace namespace_c96301ee/margwa
// Params 1, eflags: 0x4
// Checksum 0x168fb887, Offset: 0x4978
// Size: 0x4c
function private function_5adc4b54(headinfo) {
    headinfo.candamage = 0;
    self clientfield::set(headinfo.cf, headinfo.closed);
}

// Namespace namespace_c96301ee/margwa
// Params 1, eflags: 0x4
// Checksum 0x1c952e60, Offset: 0x49d0
// Size: 0x12a
function private function_b09c53b4(closetime) {
    if (self ispaused()) {
        return;
    }
    foreach (head in self.head) {
        if (head.health > 0) {
            head.closetime = undefined;
            head.opentime = undefined;
            if (isdefined(closetime)) {
                head.closetime = gettime() + closetime;
            }
            self.var_4e09343b = 0;
            self function_5adc4b54(head);
            self thread function_6d2d2ad3(head);
        }
    }
}

// Namespace namespace_c96301ee/margwa
// Params 2, eflags: 0x0
// Checksum 0xff00e17f, Offset: 0x4b08
// Size: 0x192
function function_a614f89c(var_9c967ca3, attacker) {
    headinfo = self.head[var_9c967ca3];
    headinfo.health = 0;
    headinfo notify(#"hash_a78415a");
    if (isdefined(headinfo.candamage) && headinfo.candamage) {
        self function_5adc4b54(headinfo);
        self.var_4e09343b--;
    }
    self function_3133a8cb();
    if (isdefined(self.var_bad584d0)) {
        self thread [[ self.var_bad584d0 ]](var_9c967ca3, attacker);
    }
    self clientfield::set("margwa_head_killed", headinfo.var_ac197c3f);
    self detach(headinfo.model);
    self attach(headinfo.gore);
    self.var_a0c7c5f--;
    if (self.var_a0c7c5f <= 0) {
        self.var_9e9a84fb = attacker;
        return true;
    } else {
        self.headdestroyed = var_9c967ca3;
    }
    return false;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x0
// Checksum 0xfc9e153c, Offset: 0x4ca8
// Size: 0xc4
function function_6fb4c3f9() {
    foreach (head in self.head) {
        if (isdefined(head.candamage) && isdefined(head) && head.health > 0 && head.candamage) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x0
// Checksum 0xc2162d19, Offset: 0x4d78
// Size: 0x42
function function_d7d05b41() {
    if (isdefined(self.candamage) && isdefined(self) && self.health > 0 && self.candamage) {
        return true;
    }
    return false;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x0
// Checksum 0x99655d1a, Offset: 0x4dc8
// Size: 0x90
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace namespace_c96301ee/margwa
// Params 1, eflags: 0x4
// Checksum 0xe1cbba7c, Offset: 0x4e60
// Size: 0x9e
function private function_be30bd79(weapon) {
    foreach (var_86814471 in level.var_dbb10dd8) {
        if (weapon.name == var_86814471) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_c96301ee/margwa
// Params 12, eflags: 0x0
// Checksum 0x1bac4706, Offset: 0x4f08
// Size: 0x6cc
function function_b59ae4e9(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(self.var_522f1d1c) && self.var_522f1d1c) {
        return damage;
    }
    if (isdefined(attacker) && isdefined(attacker.var_13804b27)) {
        damage *= attacker.var_13804b27;
    }
    if (isdefined(level.var_9b5d7667)) {
        n_result = [[ level.var_9b5d7667 ]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        if (isdefined(n_result)) {
            return n_result;
        }
    }
    var_40fbf63a = 0;
    if (!(isdefined(self.candamage) && self.candamage)) {
        self.health += 1;
        return 1;
    }
    if (function_be30bd79(weapon)) {
        var_b5497362 = [];
        foreach (head in self.head) {
            if (head function_d7d05b41()) {
                var_b5497362[var_b5497362.size] = head;
            }
        }
        if (var_b5497362.size > 0) {
            max = 100000;
            var_817400d4 = undefined;
            foreach (head in var_b5497362) {
                distsq = distancesquared(point, self gettagorigin(head.tag));
                if (distsq < max) {
                    max = distsq;
                    var_817400d4 = head;
                }
            }
            if (isdefined(var_817400d4)) {
                if (max < 576) {
                    if (isdefined(level.var_73978b41) && isfunctionptr(level.var_73978b41)) {
                        damage = attacker [[ level.var_73978b41 ]](damage);
                    }
                    var_817400d4.health -= damage;
                    var_40fbf63a = 1;
                    self clientfield::increment(var_817400d4.var_92dc0464);
                    attacker show_hit_marker();
                    if (var_817400d4.health <= 0) {
                        if (isdefined(level.var_64a92274)) {
                            [[ level.var_64a92274 ]](self, weapon);
                        }
                        if (self function_a614f89c(var_817400d4.model, attacker)) {
                            return self.health;
                        }
                    }
                }
            }
        }
    }
    partname = getpartname(self.model, boneindex);
    if (isdefined(partname)) {
        /#
            if (isdefined(self.var_c5dc6229) && self.var_c5dc6229) {
                printtoprightln(partname + "<dev string:x28>" + damage);
            }
        #/
        var_9c967ca3 = self function_db2d5def(self, partname);
        if (isdefined(var_9c967ca3)) {
            headinfo = self.head[var_9c967ca3];
            if (headinfo function_d7d05b41()) {
                if (isdefined(level.var_73978b41) && isfunctionptr(level.var_73978b41)) {
                    damage = attacker [[ level.var_73978b41 ]](damage);
                }
                if (isdefined(attacker)) {
                    attacker notify(#"hash_2e01a903", {#entity:self});
                }
                headinfo.health -= damage;
                var_40fbf63a = 1;
                self clientfield::increment(headinfo.var_92dc0464);
                attacker show_hit_marker();
                if (headinfo.health <= 0) {
                    if (isdefined(level.var_64a92274)) {
                        [[ level.var_64a92274 ]](self, weapon);
                    }
                    if (self function_a614f89c(var_9c967ca3, attacker)) {
                        return self.health;
                    }
                }
            }
        }
    }
    if (var_40fbf63a) {
        return 0;
    }
    self.health += 1;
    return 1;
}

// Namespace namespace_c96301ee/margwa
// Params 2, eflags: 0x4
// Checksum 0x2144acdd, Offset: 0x55e0
// Size: 0x78
function private function_db2d5def(entity, partname) {
    switch (partname) {
    case #"j_chunk_head_bone_le":
    case #"hash_20f94dc2":
        return self.var_5e150e0b;
    case #"j_chunk_head_bone":
    case #"hash_9adceb0c":
        return self.var_170dfeda;
    case #"j_chunk_head_bone_ri":
    case #"hash_25797e0":
        return self.var_b406e5f2;
    }
    return undefined;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x4
// Checksum 0xf535f01d, Offset: 0x5660
// Size: 0xa4
function private function_3133a8cb() {
    if (self.zombie_move_speed == "walk") {
        self.zombie_move_speed = "run";
        self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
        return;
    }
    if (self.zombie_move_speed == "run") {
        self.zombie_move_speed = "sprint";
        self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
    }
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x0
// Checksum 0xc5303d13, Offset: 0x5710
// Size: 0x3c
function function_8869a77() {
    self.zombie_move_speed = "sprint";
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
}

// Namespace namespace_c96301ee/margwa
// Params 1, eflags: 0x4
// Checksum 0x76b15c3f, Offset: 0x5758
// Size: 0xc
function private function_d357cdce(var_9c967ca3) {
    
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x0
// Checksum 0xf25600e9, Offset: 0x5770
// Size: 0x40
function function_33361523() {
    if (!(isdefined(self.var_25094731) && self.var_25094731)) {
        return false;
    }
    if (self.var_a0c7c5f < 3) {
        return true;
    }
    return false;
}

// Namespace namespace_c96301ee/margwa
// Params 3, eflags: 0x0
// Checksum 0x384ef13e, Offset: 0x57b8
// Size: 0x96
function function_30c7c3d3(origin, radius, var_bfc672df) {
    pos = getclosestpointonnavmesh(origin, 64, 30);
    if (isdefined(pos)) {
        self setgoal(pos);
        return true;
    }
    self setgoal(self.origin);
    return false;
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x4
// Checksum 0x73d8d07, Offset: 0x5858
// Size: 0x18e
function private function_11ba7521() {
    self endon(#"death");
    self.waiting = 1;
    self.var_b830cb9 = 1;
    destpos = self.var_16410986 + (0, 0, 60);
    dist = distance(self.var_e9eccbbc, destpos);
    time = dist / 600;
    if (isdefined(self.var_ea7c154)) {
        if (self.var_ea7c154 > 0) {
            time = dist / self.var_ea7c154;
        }
    }
    if (isdefined(self.var_58ce2260)) {
        self thread function_e9c9b15b();
        self.var_58ce2260 moveto(destpos, time);
        self.var_58ce2260 waittilltimeout(time + 0.1, "movedone");
        self.var_6a46ac61 clientfield::set("margwa_fx_travel_tell", 0);
    }
    self.waiting = 0;
    self.var_3993b370 = 0;
    if (isdefined(self.var_ea7c154)) {
        self.var_ea7c154 = undefined;
    }
}

// Namespace namespace_c96301ee/margwa
// Params 0, eflags: 0x0
// Checksum 0x771f7a63, Offset: 0x59f0
// Size: 0x64
function function_e9c9b15b() {
    self endon(#"death");
    self.var_6a46ac61.origin = self.var_16410986;
    util::wait_network_frame();
    self.var_6a46ac61 clientfield::set("margwa_fx_travel_tell", 1);
}

// Namespace namespace_c96301ee/margwa
// Params 3, eflags: 0x4
// Checksum 0x6a7fefa3, Offset: 0x5a60
// Size: 0x162
function private function_2edfc800(vdir, limit, front) {
    if (!isdefined(front)) {
        front = 1;
    }
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    if (!front) {
        forwardvec *= -1;
    }
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = vdir * -1;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    return dotproduct > limit;
}

// Namespace namespace_c96301ee/margwa
// Params 1, eflags: 0x4
// Checksum 0x6d9f21df, Offset: 0x5bd0
// Size: 0xd0
function private function_4e77203(enemy) {
    var_c06eca13 = self.origin;
    heightoffset = abs(self.origin[2] - enemy.origin[2]);
    if (heightoffset > 48) {
        return false;
    }
    distsq = distancesquared(var_c06eca13, enemy.origin);
    range = 25600;
    if (distsq < range) {
        return true;
    }
    return false;
}

