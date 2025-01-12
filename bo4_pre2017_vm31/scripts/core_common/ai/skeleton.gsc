#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/animation_state_machine_notetracks;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/fx_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_5ec5b06;

// Namespace namespace_5ec5b06/skeleton
// Params 0, eflags: 0x2
// Checksum 0x4f2d360d, Offset: 0x4a8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("skeleton", &__init__, undefined, undefined);
}

// Namespace namespace_5ec5b06/skeleton
// Params 0, eflags: 0x0
// Checksum 0x4e418460, Offset: 0x4e8
// Size: 0xac
function __init__() {
    function_9aa7ac57();
    spawner::add_archetype_spawn_function("skeleton", &function_203c170e);
    spawner::add_archetype_spawn_function("skeleton", &skeletonspawnsetup);
    if (ai::shouldregisterclientfieldforarchetype("skeleton")) {
        clientfield::register("actor", "skeleton", 1, 1, "int");
    }
}

// Namespace namespace_5ec5b06/skeleton
// Params 0, eflags: 0x0
// Checksum 0x9cb74025, Offset: 0x5a0
// Size: 0xbc
function skeletonspawnsetup() {
    self.zombie_move_speed = "walk";
    if (randomint(2) == 0) {
        self.zombie_arms_position = "up";
    } else {
        self.zombie_arms_position = "down";
    }
    self.missinglegs = 0;
    self setavoidancemask("avoid none");
    self collidewithactors(1);
    clientfield::set("skeleton", 1);
}

// Namespace namespace_5ec5b06/skeleton
// Params 0, eflags: 0x4
// Checksum 0xd05ff092, Offset: 0x668
// Size: 0x20c
function private function_9aa7ac57() {
    assert(isscriptfunctionptr(&skeletonTargetService));
    behaviortreenetworkutility::registerbehaviortreescriptapi("skeletonTargetService", &skeletonTargetService);
    assert(isscriptfunctionptr(&function_4db74dea));
    behaviortreenetworkutility::registerbehaviortreescriptapi("skeletonShouldMelee", &function_4db74dea);
    assert(isscriptfunctionptr(&skeletonGibLegsCondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("skeletonGibLegsCondition", &skeletonGibLegsCondition);
    assert(isscriptfunctionptr(&isSkeletonWalking));
    behaviortreenetworkutility::registerbehaviortreescriptapi("isSkeletonWalking", &isSkeletonWalking);
    assert(isscriptfunctionptr(&skeletondeathaction));
    behaviortreenetworkutility::registerbehaviortreescriptapi("skeletonDeathAction", &skeletondeathaction);
    animationstatenetwork::registernotetrackhandlerfunction("contact", &function_53729d53);
}

// Namespace namespace_5ec5b06/skeleton
// Params 0, eflags: 0x4
// Checksum 0x92b4b6c3, Offset: 0x880
// Size: 0x34
function private function_203c170e() {
    blackboard::createblackboardforentity(self);
    self.___archetypeonanimscriptedcallback = &archetypeskeletononanimscriptedcallback;
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x4
// Checksum 0x19dafe2d, Offset: 0x8c0
// Size: 0x34
function private archetypeskeletononanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity function_203c170e();
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0x26d55bbb, Offset: 0x900
// Size: 0x80
function isSkeletonWalking(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.zombie_move_speed)) {
        return true;
    }
    return behaviortreeentity.zombie_move_speed == "walk" && !(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) && behaviortreeentity.zombie_arms_position == "up";
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0x932f594, Offset: 0x988
// Size: 0x42
function skeletonGibLegsCondition(behaviortreeentity) {
    return gibserverutils::isgibbed(behaviortreeentity, 256) || gibserverutils::isgibbed(behaviortreeentity, 128);
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0xb645273f, Offset: 0x9d8
// Size: 0x84
function function_53729d53(animationentity) {
    hitent = animationentity melee();
    if (isdefined(hitent) && isdefined(animationentity.var_688f2d0c) && self.team != hitent.team) {
        animationentity [[ animationentity.var_688f2d0c ]](hitent);
    }
}

// Namespace namespace_5ec5b06/skeleton
// Params 4, eflags: 0x0
// Checksum 0x78f2d645, Offset: 0xa68
// Size: 0xa2
function function_d8362e5(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0x832e20e5, Offset: 0xb18
// Size: 0x202
function function_a770f4e8(player) {
    self endon(#"death");
    if (!isdefined(self.var_535aff84)) {
        self.var_535aff84 = [];
    }
    entnum = player getentitynumber();
    if (!isdefined(self.var_535aff84[entnum])) {
        self.var_535aff84[entnum] = 0;
    }
    if (self.var_535aff84[entnum] > gettime()) {
        return true;
    }
    var_ab7ad415 = self.origin + (0, 0, 40);
    player_pos = player.origin + (0, 0, 40);
    distancesq = distancesquared(var_ab7ad415, player_pos);
    if (distancesq < 4096) {
        self.var_535aff84[entnum] = gettime() + 3000;
        return true;
    } else if (distancesq > 1048576) {
        return false;
    }
    if (function_d8362e5(var_ab7ad415, self.angles, player_pos, cos(60))) {
        trace = groundtrace(var_ab7ad415, player_pos, 0, undefined);
        if (trace["fraction"] < 1) {
            return false;
        } else {
            self.var_535aff84[entnum] = gettime() + 3000;
            return true;
        }
    }
    return false;
}

// Namespace namespace_5ec5b06/skeleton
// Params 3, eflags: 0x0
// Checksum 0x18b70deb, Offset: 0xd28
// Size: 0x180
function is_player_valid(player, checkignoremeflag, ignore_laststand_players) {
    if (!isdefined(player)) {
        return 0;
    }
    if (!isalive(player)) {
        return 0;
    }
    if (!isplayer(player)) {
        return 0;
    }
    if (isdefined(player.is_zombie) && player.is_zombie == 1) {
        return 0;
    }
    if (player.sessionstate == "spectator") {
        return 0;
    }
    if (player.sessionstate == "intermission") {
        return 0;
    }
    if (isdefined(self.intermission) && self.intermission) {
        return 0;
    }
    if (!(isdefined(ignore_laststand_players) && ignore_laststand_players)) {
        if (player laststand::player_is_in_laststand()) {
            return 0;
        }
    }
    if (isdefined(checkignoremeflag) && checkignoremeflag && player.ignoreme) {
        return 0;
    }
    if (isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](player);
    }
    return 1;
}

// Namespace namespace_5ec5b06/skeleton
// Params 2, eflags: 0x0
// Checksum 0x22d22330, Offset: 0xeb0
// Size: 0x25c
function get_closest_valid_player(origin, ignore_player) {
    valid_player_found = 0;
    players = getplayers();
    if (isdefined(ignore_player)) {
        for (i = 0; i < ignore_player.size; i++) {
            arrayremovevalue(players, ignore_player[i]);
        }
    }
    done = 0;
    while (players.size && !done) {
        done = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!is_player_valid(player, 1)) {
                arrayremovevalue(players, player);
                done = 0;
                break;
            }
        }
    }
    if (players.size == 0) {
        return undefined;
    }
    while (!valid_player_found) {
        if (isdefined(self.closest_player_override)) {
            player = [[ self.closest_player_override ]](origin, players);
        } else if (isdefined(level.closest_player_override)) {
            player = [[ level.closest_player_override ]](origin, players);
        } else {
            player = arraygetclosest(origin, players);
        }
        if (!isdefined(player) || players.size == 0) {
            return undefined;
        }
        if (!is_player_valid(player, 1)) {
            arrayremovevalue(players, player);
            if (players.size == 0) {
                return undefined;
            }
            continue;
        }
        return player;
    }
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0xcddef1f6, Offset: 0x1118
// Size: 0x4c
function function_989e1981(goal) {
    if (isdefined(self.var_ccaea265)) {
        return [[ self.var_ccaea265 ]](goal);
    }
    self setgoal(goal);
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0x8102ef9f, Offset: 0x1170
// Size: 0x3c0
function skeletonTargetService(behaviortreeentity) {
    self endon(#"death");
    if (isdefined(behaviortreeentity.ignoreall) && behaviortreeentity.ignoreall) {
        return 0;
    }
    if (isdefined(behaviortreeentity.enemy) && behaviortreeentity.enemy.team == behaviortreeentity.team) {
        behaviortreeentity clearentitytarget();
    }
    if (behaviortreeentity.team == "allies") {
        if (isdefined(behaviortreeentity.favoriteenemy)) {
            behaviortreeentity function_989e1981(behaviortreeentity.favoriteenemy.origin);
            return 1;
        }
        if (isdefined(behaviortreeentity.enemy)) {
            behaviortreeentity function_989e1981(behaviortreeentity.enemy.origin);
            return 1;
        }
        target = function_1bfb2259(getaiteamarray("axis"));
        if (isdefined(target)) {
            behaviortreeentity function_989e1981(target.origin);
            return 1;
        } else {
            behaviortreeentity function_989e1981(behaviortreeentity.origin);
            return 0;
        }
        return;
    }
    player = get_closest_valid_player(behaviortreeentity.origin, behaviortreeentity.ignore_player);
    if (!isdefined(player)) {
        if (isdefined(behaviortreeentity.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            behaviortreeentity.ignore_player = [];
        }
        behaviortreeentity function_989e1981(behaviortreeentity.origin);
        return 0;
    }
    if (isdefined(player.last_valid_position)) {
        cansee = self function_a770f4e8(player);
        if (cansee) {
            behaviortreeentity function_989e1981(player.last_valid_position);
            return 1;
        } else {
            var_ecc9583c = undefined;
            if (isdefined(var_ecc9583c)) {
                if (distancesquared(var_ecc9583c, behaviortreeentity.origin) > 1024) {
                    behaviortreeentity function_989e1981(var_ecc9583c);
                    return 1;
                }
                behaviortreeentity clearpath();
                return 0;
            } else {
                behaviortreeentity clearpath();
                return 0;
            }
        }
        return 1;
    }
    behaviortreeentity function_989e1981(behaviortreeentity.origin);
    return 0;
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0xb0eb777, Offset: 0x1538
// Size: 0x1e
function isvalidenemy(enemy) {
    if (!isdefined(enemy)) {
        return false;
    }
    return true;
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0xd9a361d9, Offset: 0x1560
// Size: 0x42
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace namespace_5ec5b06/skeleton
// Params 0, eflags: 0x0
// Checksum 0x18d2a24d, Offset: 0x15b0
// Size: 0xec
function getyawtoenemy() {
    pos = undefined;
    if (isvalidenemy(self.enemy)) {
        pos = self.enemy.origin;
    } else {
        forward = anglestoforward(self.angles);
        forward = vectorscale(forward, 150);
        pos = self.origin + forward;
    }
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0x964728b, Offset: 0x16a8
// Size: 0xec
function function_4db74dea(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (isdefined(behaviortreeentity.stunned) && behaviortreeentity.stunned) {
        return false;
    }
    yaw = abs(getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 4096) {
        return true;
    }
    return false;
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0x1b384b6c, Offset: 0x17a0
// Size: 0x38
function skeletondeathaction(behaviortreeentity) {
    if (isdefined(behaviortreeentity.deathfunction)) {
        behaviortreeentity [[ behaviortreeentity.deathfunction ]]();
    }
}

// Namespace namespace_5ec5b06/skeleton
// Params 2, eflags: 0x0
// Checksum 0x1f1a1c38, Offset: 0x17e0
// Size: 0x4a
function function_5ee38fe3(origin, entarray) {
    if (!isdefined(entarray)) {
        return;
    }
    if (entarray.size == 0) {
        return;
    }
    return arraygetclosest(origin, entarray);
}

// Namespace namespace_5ec5b06/skeleton
// Params 1, eflags: 0x0
// Checksum 0x8909c46, Offset: 0x1838
// Size: 0x2a
function function_1bfb2259(entarray) {
    return function_5ee38fe3(self.origin, entarray);
}

