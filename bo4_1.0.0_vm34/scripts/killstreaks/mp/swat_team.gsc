#using script_52d2de9b438adc78;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_human;
#using scripts\core_common\ai\archetype_human_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\gestures;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\path;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\ai\tracking;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;

#namespace swat_team;

// Namespace swat_team
// Method(s) 2 Total 2
class class_d305970f {

    var currentstate;
    var var_7d8a7f6a;

    // Namespace class_d305970f/swat_team
    // Params 0, eflags: 0x8
    // Checksum 0xf496f416, Offset: 0x1698
    // Size: 0x1e
    constructor() {
        currentstate = "engage_center";
        var_7d8a7f6a = gettime();
    }

}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x2
// Checksum 0xff2fe2b7, Offset: 0x7a8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"swat_team", &__init__, undefined, #"killstreaks");
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0xe4b4c085, Offset: 0x7f8
// Size: 0x384
function __init__() {
    ir_strobe::init_shared();
    if (!isdefined(level.var_4c7ab42c)) {
        level.var_4c7ab42c = [];
        level.var_4c7ab42c[#"allies"] = [];
        level.var_4c7ab42c[#"allies"][0] = "spawner_mp_swat_buddy_team1_male";
        level.var_4c7ab42c[#"allies"][1] = "spawner_mp_swat_buddy_team1_female";
        level.var_4c7ab42c[#"allies"][2] = "spawner_mp_swat_buddy_team1_male";
        level.var_4c7ab42c[#"axis"] = [];
        level.var_4c7ab42c[#"axis"][0] = "spawner_mp_swat_buddy_team2_male";
        level.var_4c7ab42c[#"axis"][1] = "spawner_mp_swat_buddy_team2_female";
        level.var_4c7ab42c[#"axis"][2] = "spawner_mp_swat_buddy_team2_male";
    }
    loadsentienteventparameters("sentientevents_mp");
    spawner::add_archetype_spawn_function("human", &function_f257c654);
    callback::on_actor_damage(&function_17ffc4b4);
    callback::on_ai_killed(&function_71475a4b);
    callback::on_actor_killed(&on_swat_kill);
    callback::on_player_killed_with_params(&on_swat_kill);
    clientfield::register("actor", "swat_light_strobe", 1, 1, "int");
    clientfield::register("actor", "swat_shocked", 1, 1, "int");
    clientfield::register("vehicle", "swat_helicopter_death_fx", 1, getminbitcountfornum(2), "int");
    clientfield::register("actor", "swat_rob_state", 1, 1, "int");
    killstreaks::register_killstreak("killstreak_swat_team", &function_106a11bc);
    killstreaks::register_alt_weapon("swat_team", getweapon(#"ar_accurate_t8_swat"));
    player::function_74c335a(&function_b794738);
    registerbehaviorscriptfunctions();
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x18c08063, Offset: 0xb88
// Size: 0x21e
function createremoteweapontrigger(hintstring) {
    player = self;
    assert(isplayer(player));
    weapon = spawnstruct();
    weapon.remoteowner = player;
    weapon.inittime = gettime();
    weapon.usetrigger = spawn("trigger_radius_use", player.origin, 0, 32, 32);
    weapon.usetrigger enablelinkto();
    weapon.usetrigger linkto(player);
    weapon.usetrigger sethintlowpriority(1);
    weapon.usetrigger setcursorhint("HINT_NOICON");
    weapon.usetrigger sethintstring(hintstring);
    weapon.usetrigger setteamfortrigger(player.team);
    weapon.usetrigger.team = player.team;
    player clientclaimtrigger(weapon.usetrigger);
    player.remotecontroltrigger = weapon.usetrigger;
    player.activeremotecontroltriggers[player.activeremotecontroltriggers.size] = weapon.usetrigger;
    weapon.usetrigger.claimedby = player;
    return weapon;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xc5a2a7a3, Offset: 0xdb0
// Size: 0x44
function function_88296881(hintstring) {
    assert(isdefined(self.usetrigger));
    self.usetrigger sethintstring(hintstring);
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x114a02d7, Offset: 0xe00
// Size: 0x2b0
function function_106a11bc(killstreak) {
    player = self;
    context = spawnstruct();
    context.radius = level.killstreakcorebundle.ksairdropsupplydropradius;
    context.dist_from_boundary = 100;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.islocationgood = &islocationgood;
    context.objective = #"hash_1b5a86007f598bbc";
    context.validlocationsound = level.killstreakcorebundle.ksvalidcarepackagelocationsound;
    context.tracemask = 1;
    context.droptag = "tag_attach";
    context.droptagoffset = (-32, 0, 23);
    context.killstreaktype = killstreak;
    context.var_b222d13d = &stopkillstreak;
    context.var_5e08dfac = player.team;
    killstreak_id = killstreakrules::killstreakstart("swat_team", self.team, 0, 0);
    ksbundle = killstreak_bundles::get_bundle(context);
    if (isdefined(ksbundle)) {
        context.time = ksbundle.kstime;
        context.fx_name = ksbundle.var_4e9eb452;
    }
    waterdepth = self depthofplayerinwater();
    if (!self isonground() || self util::isusingremote() || waterdepth > 2) {
        return false;
    }
    spawn_swat_team(player, context, player.origin);
    util::function_d1f9db00(21, player.team, player getentitynumber(), level.killstreaks[#"swat_team"].uiname);
    return true;
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x4
// Checksum 0xfdbb99a4, Offset: 0x10b8
// Size: 0x314
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_fe4d8225));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_62335a0608a02309", &function_fe4d8225);
    assert(isscriptfunctionptr(&function_934c4ec1));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4a938922d1af0c4d", &function_934c4ec1);
    assert(isscriptfunctionptr(&function_d17507ce));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4cc583c8bb841d4c", &function_d17507ce);
    assert(isscriptfunctionptr(&function_87d5f452));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3861dc092e2bcf88", &function_87d5f452);
    assert(isscriptfunctionptr(&function_c266062c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_48334fe2b83169f2", &function_c266062c);
    assert(isscriptfunctionptr(&function_19ccde73));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_44cbd2652f2bcafb", &function_19ccde73);
    assert(isscriptfunctionptr(&function_14a0f8a0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_37de1d651cda8ede", &function_14a0f8a0);
    animationstatenetwork::registeranimationmocomp("mocomp_swat_team_pain", &function_bcd9b8e6, undefined, &function_829bb385);
}

// Namespace swat_team/swat_team
// Params 5, eflags: 0x0
// Checksum 0x6dd77bec, Offset: 0x13d8
// Size: 0xa2
function function_bcd9b8e6(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", self.angles[1]);
    entity animmode("zonly_physics", 1);
    entity pathmode("dont move");
    entity.blockingpain = 1;
}

// Namespace swat_team/swat_team
// Params 5, eflags: 0x0
// Checksum 0x895196d7, Offset: 0x1488
// Size: 0x5a
function function_829bb385(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity pathmode("move allowed");
    entity.blockingpain = 0;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x6100ffcc, Offset: 0x14f0
// Size: 0x44
function private function_fe4d8225(entity) {
    if (isdefined(entity.ai.swat_gunner) && entity.ai.swat_gunner) {
        return true;
    }
    return false;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xb988489e, Offset: 0x1540
// Size: 0x24
function private function_934c4ec1(entity) {
    entity unlink();
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x11b7999b, Offset: 0x1570
// Size: 0x9e
function private function_d17507ce(entity) {
    if (isdefined(entity.enemy) && !(isdefined(entity.ignoreall) && entity.ignoreall)) {
        if (util::within_fov(entity.origin, entity.angles, entity.enemy.origin, cos(90))) {
            return true;
        }
    }
    return false;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x9f19ad6d, Offset: 0x1618
// Size: 0x44
function private function_19ccde73(entity) {
    if (entity.var_a38dd6f === "electrical") {
        clientfield::set("swat_shocked", 1);
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xdc67c0f5, Offset: 0x1668
// Size: 0x24
function private function_14a0f8a0(entity) {
    clientfield::set("swat_shocked", 0);
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x65448dd9, Offset: 0x1760
// Size: 0x64
function private function_ef36c2a4(entity) {
    if (isdefined(entity.ai.var_a21f13b)) {
        entity.ai.var_a21f13b = undefined;
        if (isdefined(entity.goalpos)) {
            entity function_3c8dce03(entity.goalpos);
        }
    }
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x4
// Checksum 0xb8dfe092, Offset: 0x17d0
// Size: 0x74
function private function_1011f5f7(entity, newspot) {
    assert(isdefined(newspot));
    if (isdefined(entity.goalpos) && isdefined(entity.goalradius)) {
        if (entity isingoal(newspot)) {
            return true;
        }
        return false;
    }
    return true;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x2ef812ba, Offset: 0x1850
// Size: 0x6e
function private function_61a73ea1(entity) {
    function_ef36c2a4(entity);
    entity.ai.var_a21f13b = new class_d305970f();
    entity.ai.var_a21f13b.centerpos = entity.origin;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xb2347f62, Offset: 0x18c8
// Size: 0x6e
function private function_468e4b2e(entity) {
    assert(isdefined(entity.ai.var_a21f13b));
    entity.ai.var_a21f13b.var_7d8a7f6a = gettime() + randomintrange(1200, 2200);
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x1a120a0f, Offset: 0x1940
// Size: 0x920
function private function_c266062c(entity) {
    if (isdefined(entity.reacquire_state) && entity.reacquire_state > 0) {
        function_ef36c2a4(entity);
        return false;
    }
    if (!isdefined(entity.enemy) || !entity seerecently(entity.enemy, 8)) {
        function_ef36c2a4(entity);
        return false;
    }
    if (!issentient(entity.enemy) || !isplayer(entity.enemy)) {
        function_ef36c2a4(entity);
        return false;
    }
    var_b24b66d7 = distancesquared(entity.origin, entity.enemy.origin);
    if (var_b24b66d7 < 100 * 100) {
        function_ef36c2a4(entity);
        return false;
    }
    if (var_b24b66d7 > 1000 * 1000) {
        function_ef36c2a4(entity);
        return false;
    }
    seerecently = entity seerecently(entity.enemy, 8);
    var_7b75c9ce = entity attackedrecently(entity.enemy, 4);
    var_a1f1d03f = seerecently && var_7b75c9ce;
    if (!var_a1f1d03f) {
        function_ef36c2a4(entity);
        return false;
    }
    if (!isdefined(entity.ai.var_a21f13b)) {
        entity thread function_13393de9("swat_engaging");
        function_61a73ea1(entity);
    }
    if (gettime() < entity.ai.var_a21f13b.var_7d8a7f6a) {
        return false;
    }
    assert(isdefined(entity.ai.var_a21f13b));
    nextstate = "engage_center";
    switch (entity.ai.var_a21f13b.currentstate) {
    case #"engage_center":
        random = randomint(100);
        if (random < 33) {
            nextstate = "engage_left";
        } else if (random < 66) {
            nextstate = "engage_right";
        }
        break;
    case #"engage_left":
    case #"engage_right":
        nextstate = "engage_center";
        break;
    default:
        break;
    }
    if (nextstate != entity.ai.var_a21f13b.currentstate) {
        dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
        angles = vectortoangles(dirtoenemy);
        angles = (0, angles[1], 0);
        newspot = undefined;
        direction = undefined;
        if (nextstate == "engage_left") {
            var_f51a68de = anglestoright(angles) * -1;
            movepos = entity.origin + vectorscale(var_f51a68de, randomintrange(60, 200));
            tacpoint = getclosesttacpoint(movepos);
            if (isdefined(tacpoint) && tracepassedonnavmesh(entity.origin, tacpoint.origin, 18)) {
                newspot = tacpoint.origin;
                direction = "engage_left";
            }
        } else if (nextstate == "engage_right") {
            var_85245595 = anglestoright(angles);
            movepos = entity.origin + vectorscale(var_85245595, randomintrange(60, 200));
            tacpoint = getclosesttacpoint(movepos);
            if (isdefined(tacpoint) && tracepassedonnavmesh(entity.origin, tacpoint.origin, 18)) {
                newspot = tacpoint.origin;
                direction = "engage_right";
            }
        } else {
            newspot = entity.ai.var_a21f13b.centerpos;
            direction = "engage_center";
        }
        if (isdefined(newspot) && isdefined(direction) && function_1011f5f7(entity, newspot)) {
            entity function_3c8dce03(newspot);
            function_468e4b2e(entity);
            /#
                record3dtext("<dev string:x30>" + direction, newspot + (0, 0, 10), (0, 0, 1), "<dev string:x31>");
                recordline(entity.origin, newspot, (0, 0, 1), "<dev string:x31>");
                recordcircle(newspot, 8, (0, 0, 1), "<dev string:x31>");
            #/
        } else {
            cylinder = ai::t_cylinder(entity.ai.var_a21f13b.centerpos, entity.goalradius, 40);
            var_7442ca2d = ai::t_cylinder(entity.ai.var_a21f13b.centerpos, 60, 40);
            enemypos = entity.enemy.origin;
            tacpoints = tacticalquery("swat_engage_enemy", cylinder, entity, enemypos, var_7442ca2d);
            if (isdefined(tacpoints) && tacpoints.size) {
                tacpoint = array::random(tacpoints);
                entity function_3c8dce03(tacpoint.origin);
                function_468e4b2e(entity);
                /#
                    record3dtext("<dev string:x38>", tacpoint.origin + (0, 0, 10), (0, 0, 1), "<dev string:x31>");
                    recordline(entity.origin, tacpoint.origin, (0, 0, 1), "<dev string:x31>");
                    recordcircle(tacpoint.origin, 8, (0, 0, 1), "<dev string:x31>");
                #/
            }
        }
    }
    return true;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x4e757747, Offset: 0x2268
// Size: 0x2ba
function private function_87d5f452(entity) {
    if (!isdefined(entity.reacquire_state)) {
        entity.reacquire_state = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.reacquire_state = 0;
        return false;
    }
    if (entity haspath()) {
        entity.reacquire_state = 0;
        return false;
    }
    if (entity seerecently(entity.enemy, 4)) {
        entity.reacquire_state = 0;
        return false;
    }
    dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
    forward = anglestoforward(entity.angles);
    if (vectordot(dirtoenemy, forward) < 0.5) {
        entity.reacquire_state = 0;
        return false;
    }
    switch (entity.reacquire_state) {
    case 0:
    case 1:
    case 2:
        step_size = 32 + entity.reacquire_state * 32;
        reacquirepos = entity reacquirestep(step_size);
        break;
    case 4:
        if (!entity cansee(entity.enemy) || !entity canshootenemy()) {
            entity flagenemyunattackable();
        }
        break;
    default:
        if (entity.reacquire_state > 15) {
            entity.reacquire_state = 0;
            return false;
        }
        break;
    }
    if (isvec(reacquirepos)) {
        entity function_3c8dce03(reacquirepos);
        return true;
    }
    entity.reacquire_state++;
    return false;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xae60ad94, Offset: 0x2530
// Size: 0x9c
function private on_swat_kill(params) {
    if (isdefined(params.einflictor) && isactor(params.einflictor) && isdefined(params.einflictor.ai.var_b74d1988) && params.einflictor.ai.var_b74d1988) {
        params.einflictor thread function_13393de9("swat_kill");
    }
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x4
// Checksum 0xf6f0847c, Offset: 0x25d8
// Size: 0xc4
function private function_17ffc4b4() {
    if (isdefined(self.ai.var_b74d1988) && self.ai.var_b74d1988) {
        var_eb47e76f = int(1 * 1000);
        self.ai.var_a6735fbd = gettime() + var_eb47e76f;
        if (isdefined(self.var_f91c18c3)) {
            maxhealth = self.maxhealth;
            health_percent = self.health / maxhealth;
            objective_setprogress(self.var_f91c18c3, health_percent);
        }
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x67681ec8, Offset: 0x26a8
// Size: 0x27c
function private function_71475a4b(params) {
    if (!(isdefined(self.ai.var_b74d1988) && self.ai.var_b74d1988)) {
        return;
    }
    clientfield::set("swat_light_strobe", 0);
    if (isdefined(self.script_owner) && isdefined(self.script_owner.swat_team)) {
        arrayremovevalue(self.script_owner.swat_team, self);
    }
    self laseroff();
    if (isdefined(self.var_f91c18c3)) {
        objective_delete(self.var_f91c18c3);
        gameobjects::release_obj_id(self.var_f91c18c3);
    }
    if (isdefined(params.eattacker)) {
        if (isplayer(params.eattacker)) {
            params.eattacker battlechatter::function_b5530e2c("swat_team", params.weapon);
            self killstreaks::function_8acf563(params.eattacker, params.weapon, self.script_owner);
        }
    }
    self function_f3a74570();
    if (isdefined(self.script_owner) && isdefined(self.script_owner.swat_team)) {
        foreach (swat in self.script_owner.swat_team) {
            if (isdefined(swat) && isalive(swat) && swat != self) {
                swat thread function_13393de9("swat_destroyed");
                break;
            }
        }
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x79f0ebed, Offset: 0x2930
// Size: 0x20e
function function_16eeeb93(owner) {
    self endon(#"death");
    if (getdvarint(#"hash_667dcfb9f4060f0c", 0)) {
        self.var_f91c18c3 = gameobjects::get_next_obj_id();
        objective_add(self.var_f91c18c3, "active", self, #"hash_6cff9cefb99a67d1");
        objective_setprogress(self.var_f91c18c3, 1);
        function_eeba3a5c(self.var_f91c18c3, 1);
        objective_setinvisibletoall(self.var_f91c18c3);
        objective_setvisibletoplayer(self.var_f91c18c3, owner);
    }
    self.ai.var_a6735fbd = gettime();
    maxhealth = self.maxhealth;
    while (true) {
        var_a688eb9c = gettime() >= self.ai.var_a6735fbd;
        var_1c50406a = self.health >= self.maxhealth;
        if (var_a688eb9c && !var_1c50406a) {
            newhealth = self.health + 200;
            if (newhealth <= maxhealth) {
                self.health = newhealth;
            } else {
                self.health = maxhealth;
            }
            health_percent = self.health / maxhealth;
            if (isdefined(self.var_f91c18c3)) {
                objective_setprogress(self.var_f91c18c3, health_percent);
            }
        }
        wait 1;
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xbac8ae15, Offset: 0x2b48
// Size: 0x92
function function_8a47555a(swat) {
    goalinfo = swat function_e9a79b0e();
    if (isdefined(goalinfo.node)) {
        var_dad3ca18 = goalinfo.node.origin + vectorscale(anglestoforward(goalinfo.node.angles), 400);
        return var_dad3ca18;
    }
    return undefined;
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x4
// Checksum 0xa2a87815, Offset: 0x2be8
// Size: 0x4c
function private function_f3a74570() {
    removeallinfluencersfromentity(self);
    level influencers::create_friendly_influencer("friend_dead", self.origin, self.team);
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x4
// Checksum 0x8edceb21, Offset: 0x2c40
// Size: 0x1a2
function private function_23d39642() {
    assert(isdefined(self.script_owner));
    if (!level.teambased) {
        team_mask = level.spawnsystem.ispawn_teammask_free;
        enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
    } else if (isdefined(self.script_owner.pers[#"team"])) {
        team = self.script_owner.pers[#"team"];
        team_mask = util::getteammask(team);
        enemy_teams_mask = util::getotherteamsmask(team);
    } else {
        team_mask = 0;
        enemy_teams_mask = 0;
    }
    angles = self.angles;
    origin = self.origin;
    up = (0, 0, 1);
    forward = (1, 0, 0);
    self influencers::create_entity_influencer("enemy", enemy_teams_mask);
    if (level.teambased) {
        self influencers::create_entity_influencer("friend", team_mask);
    }
    self.influencers_created = 1;
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x4
// Checksum 0x6c349671, Offset: 0x2df0
// Size: 0x356
function private function_dcb7e010() {
    self endon(#"death");
    self.ai.var_b74d1988 = 1;
    self.health = 2000;
    self.maxhealth = 2000;
    self.enableterrainik = 1;
    self.ai.var_fb202a5a = 1;
    self.highlyawareradius = 2000;
    self.script_accuracy = 1;
    self.var_5732eb59 = 600;
    self.goalradius = 350;
    self.ai.var_8e5bbae5 = 1;
    self.sightlatency = 0;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.ai.var_d829299a = &function_8a47555a;
    self laseron();
    self collidewithactors(0);
    self setplayercollision(0);
    self ai::set_behavior_attribute("useGrenades", 0);
    self function_23d39642();
    while (true) {
        if (getdvarint(#"scr_debug_swat_behavior", 0)) {
            if (isdefined(self.likelyenemyposition)) {
                /#
                    recordline(self.origin, self.likelyenemyposition, (0, 0, 1), "<dev string:x31>");
                    recordcircle(self.likelyenemyposition, 8, (0, 0, 1), "<dev string:x31>");
                #/
            }
            if (isdefined(self.enemy)) {
                /#
                    recordline(self.origin + (0, 0, 70), self.enemy.origin + (0, 0, 70), (1, 0, 0), "<dev string:x31>");
                    recordcircle(self.enemy.origin + (0, 0, 70), 8, (1, 0, 0), "<dev string:x31>");
                    if (isplayer(self.enemy)) {
                        pathdata = generatenavmeshpath(self.origin, self.enemy.origin, self);
                        pathdistance = pathdata.pathdistance;
                        path = pathdata.pathpoints;
                        path::function_2d83a00(path, (0, 0, 1), (1, 0, 0), (1, 0.5, 0));
                    }
                #/
            }
        }
        waitframe(1);
    }
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x4
// Checksum 0xe198ed57, Offset: 0x3150
// Size: 0x158
function private function_fa6a6097(swat, helicopter, position) {
    swat endon(#"death");
    swat endon(#"stop_riding");
    ride_anim = undefined;
    switch (position) {
    case 0:
        ride_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_01_idle";
        break;
    case 1:
        ride_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_02_idle";
        break;
    case 2:
        ride_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_03_idle";
        break;
    default:
        assertmsg("<dev string:x3f>");
        break;
    }
    assert(isdefined(ride_anim));
    while (true) {
        swat animation::play(ride_anim, helicopter, "tag_origin", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    }
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x4
// Checksum 0x80b78c56, Offset: 0x32b0
// Size: 0x124
function private function_75a32df0(swat, helicopter, killstreak_id) {
    swat endon(#"swat_landed");
    swat endon(#"death");
    helicopter endon(#"death");
    helicopter waittill(#"hash_216c905d79c8bbea");
    if (isdefined(swat.script_owner)) {
        swat.script_owner notify(#"hash_216c905d79c8bbea");
        swat.script_owner notify(#"payload_fail");
    }
    swat unlink();
    swat startragdoll();
    swat kill();
    function_7a4daa04(helicopter);
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xc0c57887, Offset: 0x33e0
// Size: 0x6c
function private function_885c54ce(swat) {
    swat endon(#"swat_landed");
    swat waittill(#"death");
    swat unlink();
    swat startragdoll();
}

// Namespace swat_team/swat_team
// Params 5, eflags: 0x0
// Checksum 0xa21e2d2e, Offset: 0x3458
// Size: 0x338
function swat_deploy(swat, helicopter, position, var_17a872d8, var_1dae39c3) {
    swat endon(#"death");
    deploy_anim = undefined;
    switch (position) {
    case 0:
        deploy_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_01";
        break;
    case 1:
        deploy_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_02";
        break;
    case 2:
        deploy_anim = "ai_swat_rifle_ent_litlbird_rappel_stn_base_03";
        break;
    default:
        assertmsg("<dev string:x75>");
        break;
    }
    assert(isdefined(deploy_anim));
    swat notify(#"stop_riding");
    swat pathmode("dont move");
    swat animation::play(deploy_anim, helicopter.origin, helicopter.angles, 1.2, 0.2, 0.3, undefined, undefined, undefined, 0);
    swat unlink();
    if (var_1dae39c3) {
        swat thread function_13393de9("swat_arrive");
    }
    aiutility::removeaioverridedamagecallback(swat, &function_eabb08f8);
    aiutility::addaioverridedamagecallback(swat, &function_70808bdf);
    if (!ispointonnavmesh(self.origin, self)) {
        point = getclosestpointonnavmesh(swat.origin, 100);
        if (isdefined(point)) {
            swat forceteleport(point);
        }
    }
    swat.ignoreall = 0;
    swat.ignoreme = 0;
    swat pathmode("move allowed");
    if (isdefined(swat.var_bae8cb14)) {
        swat setgoal(swat.var_bae8cb14.origin);
        swat usecovernode(swat.var_bae8cb14);
    } else if (isdefined(swat.var_b0dbb171)) {
        swat setgoal(swat.var_b0dbb171);
    }
    swat notify(#"swat_landed");
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xb8bf6d72, Offset: 0x3798
// Size: 0x166
function private function_768b2544(leavenode) {
    self endon(#"death");
    radius = distance(self.origin, leavenode.origin);
    var_40c02d23 = getclosestpointonnavvolume(leavenode.origin, "navvolume_big", radius);
    if (isdefined(var_40c02d23)) {
        self function_8474d4c8(var_40c02d23, 0);
        while (true) {
            /#
                recordsphere(var_40c02d23, 8, (0, 0, 1), "<dev string:x31>");
            #/
            var_6f7637e2 = ispointinnavvolume(self.origin, "navvolume_big");
            if (!var_6f7637e2) {
                self function_32aff240();
                self notify(#"hash_2bf34763927dd61b");
                break;
            }
            waitframe(1);
        }
        return;
    }
    self function_32aff240();
    self notify(#"hash_2bf34763927dd61b");
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x4e49f98f, Offset: 0x3908
// Size: 0x45c
function function_b4b74073(helicopter) {
    helicopter notify(#"leaving");
    helicopter notify(#"heli_leave");
    helicopter.leaving = 1;
    leavenode = helicopter::getvalidrandomleavenode(helicopter.origin);
    var_b321594 = leavenode.origin;
    heli_reset();
    helicopter vehclearlookat();
    exitangles = vectortoangles(var_b321594 - helicopter.origin);
    helicopter setgoalyaw(exitangles[1]);
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        if (!ispointinnavvolume(helicopter.origin, "navvolume_big")) {
            if (issentient(helicopter)) {
                helicopter function_32aff240();
            }
            radius = distance(self.origin, leavenode.origin);
            var_40c02d23 = getclosestpointonnavvolume(helicopter.origin, "navvolume_big", radius);
            if (isdefined(var_40c02d23)) {
                helicopter function_8474d4c8(var_40c02d23, 0);
                while (true) {
                    /#
                        recordsphere(var_40c02d23, 8, (0, 0, 1), "<dev string:x31>");
                    #/
                    var_6f7637e2 = ispointinnavvolume(helicopter.origin, "navvolume_big");
                    if (var_6f7637e2) {
                        helicopter makesentient();
                        break;
                    }
                    waitframe(1);
                }
            }
        }
        if (!ispointinnavvolume(leavenode.origin, "navvolume_big")) {
            helicopter thread function_768b2544(leavenode);
            helicopter waittill(#"hash_2bf34763927dd61b");
        }
    }
    helicopter function_8474d4c8(var_b321594, 1);
    helicopter waittilltimeout(20, #"near_goal", #"death");
    if (isdefined(helicopter.var_3ba5a2d9)) {
        for (i = helicopter.var_3ba5a2d9.size; i >= 0; i--) {
            if (isdefined(helicopter.var_3ba5a2d9[i]) && isalive(helicopter.var_3ba5a2d9[i])) {
                helicopter.var_3ba5a2d9[i] delete();
            }
        }
    }
    if (isdefined(helicopter)) {
        helicopter stoploopsound(1);
        helicopter util::death_notify_wrapper();
        if (isdefined(helicopter.alarm_snd_ent)) {
            helicopter.alarm_snd_ent stoploopsound();
            helicopter.alarm_snd_ent delete();
            helicopter.alarm_snd_ent = undefined;
        }
        helicopter delete();
    }
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x4
// Checksum 0x616b9055, Offset: 0x3d70
// Size: 0x150
function private function_7bdc40cb(helicopter, var_4a256eea) {
    helicopter endon(#"death");
    helicopter endon(#"heli_leave");
    var_b520b593 = var_4a256eea;
    lerp_duration = max((helicopter.origin[2] - var_4a256eea[2] - 600) / 625, 0.8);
    helicopter animation::play("ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2", var_b520b593, (0, helicopter.angles[1], 0), 1, 0.1, 0.2, lerp_duration);
    while (true) {
        helicopter animation::play("ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2", var_b520b593, (0, helicopter.angles[1], 0), 1, 0.1, 0.2, 0.8);
    }
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0x9a60edec, Offset: 0x3ec8
// Size: 0x74
function heli_reset() {
    self cleartargetyaw();
    self cleargoalyaw();
    self setyawspeed(75, 45, 45);
    self setmaxpitchroll(30, 30);
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0x52de7db7, Offset: 0x3f48
// Size: 0x124
function function_b973a2e3() {
    self endon(#"death");
    self endon(#"abandoned");
    while (true) {
        var_6f7637e2 = ispointinnavvolume(self.origin, "navvolume_big");
        if (var_6f7637e2) {
            heli_reset();
            self makepathfinder();
            if (!issentient(self)) {
                self makesentient();
            }
            self.ignoreme = 1;
            if (isdefined(self.heligoalpos)) {
                self function_8474d4c8(self.heligoalpos, 1);
            }
            self notify(#"hash_340ab3c2b94ff86a");
            break;
        }
        waitframe(1);
    }
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0xf1d6fced, Offset: 0x4078
// Size: 0x114
function function_8474d4c8(goalpos, stop) {
    self.heligoalpos = goalpos;
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        if (issentient(self) && ispathfinder(self) && ispointinnavvolume(self.origin, "navvolume_big")) {
            self setgoal(goalpos, stop);
            self function_3c8dce03(goalpos, stop, 1);
        } else {
            self function_3c8dce03(goalpos, stop, 0);
        }
        return;
    }
    self setgoal(goalpos, stop);
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x4
// Checksum 0x47eafb1d, Offset: 0x4198
// Size: 0x3a8
function private function_3e4666a1(helicopter, destination) {
    helicopter endon(#"death");
    var_1d9e00b4 = destination;
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        helicopter thread function_b973a2e3();
        if (!ispointinnavvolume(var_1d9e00b4, "navvolume_big")) {
            var_40c02d23 = getclosestpointonnavvolume(destination, "navvolume_big", 10000);
            var_1d9e00b4 = (var_40c02d23[0], var_40c02d23[1], destination[2]);
            if (isdefined(var_1d9e00b4)) {
                helicopter function_8474d4c8(var_1d9e00b4, 1);
                helicopter.var_1d9e00b4 = var_1d9e00b4;
                if (!ispointinnavvolume(var_1d9e00b4, "navvolume_big")) {
                    self waittilltimeout(10, #"hash_340ab3c2b94ff86a");
                }
            }
        }
        self function_8474d4c8(var_1d9e00b4, 1);
        self waittill(#"near_goal");
    } else {
        helicopter thread airsupport::setgoalposition(destination, "swat_heli_reached", 1);
        helicopter waittill(#"swat_heli_reached");
    }
    last_distance_from_goal_squared = 1e+07 * 1e+07;
    continue_waiting = 1;
    for (remaining_tries = 30; continue_waiting && remaining_tries > 0; remaining_tries--) {
        current_distance_from_goal_squared = distance2dsquared(helicopter.origin, destination);
        continue_waiting = current_distance_from_goal_squared < last_distance_from_goal_squared && current_distance_from_goal_squared > 4 * 4;
        last_distance_from_goal_squared = current_distance_from_goal_squared;
        /#
            if (getdvarint(#"swat_debug", 0)) {
                sphere(destination, 8, (1, 0, 0), 0.9, 0, 20, 1);
            }
        #/
        if (continue_waiting) {
            /#
                if (getdvarint(#"swat_debug", 0)) {
                    iprintln("<dev string:xac>" + distance2d(helicopter.origin, destination));
                }
            #/
            waitframe(1);
        }
    }
    /#
        if (getdvarint(#"swat_debug", 0)) {
            iprintln("<dev string:xc4>" + distance2d(helicopter.origin, destination));
        }
    #/
    helicopter notify(#"reached_destination");
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x98719cba, Offset: 0x4548
// Size: 0x4c
function swat_helicopter_explode(helicopter) {
    helicopter helicopter::function_236dcb7b();
    wait 0.1;
    if (isdefined(helicopter)) {
        helicopter delete();
    }
}

// Namespace swat_team/swat_team
// Params 4, eflags: 0x4
// Checksum 0x4b1b8e42, Offset: 0x45a0
// Size: 0x250
function private spawn_swat_helicopter(owner, origin, angles, context) {
    helicopter = spawnvehicle("vehicle_t8_mil_helicopter_swat_transport", origin, angles, "swat_helicopter");
    helicopter setowner(owner);
    helicopter thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
    helicopter.spawntime = gettime();
    helicopter clientfield::set("enemyvehicle", 1);
    helicopter.attackers = [];
    helicopter.attackerdata = [];
    helicopter.attackerdamage = [];
    helicopter.flareattackerdamage = [];
    helicopter.killstreak_id = context.killstreak_id;
    helicopter setdrawinfrared(1);
    helicopter.allowcontinuedlockonafterinvis = 1;
    helicopter.soundmod = "heli";
    notifydist = 128;
    helicopter setneargoalnotifydist(notifydist);
    helicopter.maxhealth = level.heli_maxhealth;
    helicopter.health = level.heli_maxhealth;
    helicopter.overridevehicledamage = &function_fb780485;
    helicopter killstreaks::configure_team("swat_team", context.killstreak_id, owner);
    context.helicopter = helicopter;
    helicopter.target_offset = (0, 0, -25);
    target_set(helicopter, (0, 0, -25));
    helicopter setrotorspeed(1);
    return helicopter;
}

// Namespace swat_team/swat_team
// Params 15, eflags: 0x0
// Checksum 0x7f41f640, Offset: 0x47f8
// Size: 0x1a0
function function_fb780485(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    helicopter = self;
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    idamage = self killstreaks::ondamageperweapon("swat_team", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.lowhealth, undefined, 0, undefined, 1, 1);
    /#
        if (getdvarint(#"hash_2272264bb18906ce", 0)) {
            idamage = self.health + 1;
        }
    #/
    if (idamage >= self.health) {
        self.health = idamage + 1;
        helicopter.overridevehicledamage = undefined;
        helicopter notify(#"hash_216c905d79c8bbea");
        function_7a4daa04(helicopter);
        helicopter thread swat_helicopter_explode(helicopter);
    }
    return idamage;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x190b086a, Offset: 0x49a0
// Size: 0x10c
function private function_8edb82a4(helicopter) {
    assert(!isdefined(helicopter.rope));
    helicopter.rope = spawn("script_model", helicopter.origin);
    assert(isdefined(helicopter.rope));
    helicopter.rope useanimtree("generic");
    helicopter.rope setmodel("p8_fxanim_gp_vehicle_lb_swat_rappel_mod");
    helicopter.rope linkto(helicopter, "tag_origin");
    helicopter.rope hide();
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x4d420cde, Offset: 0x4ab8
// Size: 0x10c
function private function_c03f10c3(helicopter) {
    assert(isdefined(helicopter.rope));
    helicopter endon(#"hash_216c905d79c8bbea");
    helicopter endon(#"death");
    helicopter.rope endon(#"death");
    helicopter.rope show();
    helicopter endon(#"hash_216c905d79c8bbea");
    helicopter endon(#"death");
    helicopter.rope animation::play("p8_fxanim_gp_vehicle_lb_swat_rappel_start_anim", helicopter, "tag_origin", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xef86a281, Offset: 0x4bd0
// Size: 0x3c
function private function_344c0760(rope) {
    rope endon(#"death");
    if (isdefined(rope)) {
        rope delete();
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x8f7c80b1, Offset: 0x4c18
// Size: 0xfc
function private function_af099dbd(helicopter) {
    assert(isdefined(helicopter.rope));
    helicopter endon(#"hash_216c905d79c8bbea");
    helicopter endon(#"death");
    helicopter.rope endon(#"death");
    helicopter notify(#"hash_6d5d50a125188a1b");
    helicopter.rope thread animation::play("p8_fxanim_gp_vehicle_lb_swat_rappel_drop_anim", helicopter, "tag_origin", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
    wait 0.5;
    function_7a4daa04(helicopter);
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x288001a9, Offset: 0x4d20
// Size: 0x4c
function private function_7a4daa04(helicopter) {
    helicopter endon(#"death");
    if (isdefined(helicopter.rope)) {
        helicopter.rope delete();
    }
}

// Namespace swat_team/swat_team
// Params 12, eflags: 0x0
// Checksum 0x13100466, Offset: 0x4d78
// Size: 0x120
function function_70808bdf(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    bundle = getscriptbundle("killstreak_swat_team");
    chargelevel = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage("swat_team", self.maxhealth, attacker, weapon, meansofdeath, damage, idflags, chargelevel);
    if (!isdefined(weapon_damage)) {
        weapon_damage = killstreaks::get_old_damage(attacker, weapon, meansofdeath, damage, 1);
    }
    self thread function_86e6830e(meansofdeath);
    return weapon_damage;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x0
// Checksum 0x162147ee, Offset: 0x4ea0
// Size: 0x52
function function_3dbb9642(weapon, shitloc, smeansofdeath) {
    if (!isdefined(shitloc)) {
        return false;
    }
    if (shitloc != "head" && shitloc != "helmet") {
        return false;
    }
    return true;
}

// Namespace swat_team/swat_team
// Params 12, eflags: 0x0
// Checksum 0x1d19ac8, Offset: 0x4f00
// Size: 0xf0
function function_eabb08f8(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(attacker) && attacker.team != self.team) {
        var_c0382d86 = function_3dbb9642(weapon, hitloc, meansofdeath);
        if (var_c0382d86) {
            damage *= 1.2;
        } else {
            damage *= 0.3;
        }
        if (damage < 0) {
            damage = 0;
        }
    }
    return damage;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xc6bd2d36, Offset: 0x4ff8
// Size: 0x3e
function function_27eb0046(swat_gunner) {
    swat_gunner.blindaim = 1;
    swat_gunner.script_accuracy = 0.99;
    swat_gunner.var_5732eb59 = 400;
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0x633baaf6, Offset: 0x5040
// Size: 0x326
function function_a2ee96(owner, helicopter) {
    assert(isdefined(owner.swat_team));
    assert(isdefined(helicopter));
    owner.var_3ba5a2d9 = [];
    helicopter.var_3ba5a2d9 = [];
    for (i = 0; i < 2; i++) {
        swat_gunner = spawnactor("spawner_mp_swat_gunner", helicopter.origin, (0, 0, 0), "swat_gunner");
        if (!isdefined(owner.var_3ba5a2d9)) {
            owner.var_3ba5a2d9 = [];
        } else if (!isarray(owner.var_3ba5a2d9)) {
            owner.var_3ba5a2d9 = array(owner.var_3ba5a2d9);
        }
        owner.var_3ba5a2d9[owner.var_3ba5a2d9.size] = swat_gunner;
        if (!isdefined(helicopter.var_3ba5a2d9)) {
            helicopter.var_3ba5a2d9 = [];
        } else if (!isarray(helicopter.var_3ba5a2d9)) {
            helicopter.var_3ba5a2d9 = array(helicopter.var_3ba5a2d9);
        }
        helicopter.var_3ba5a2d9[helicopter.var_3ba5a2d9.size] = swat_gunner;
        swat_gunner setentityowner(owner);
        swat_gunner setteam(owner.team);
        aiutility::addaioverridedamagecallback(swat_gunner, &function_eabb08f8);
        swat_gunner function_27eb0046(swat_gunner);
        swat_gunner thread function_16eeeb93(owner);
        if (i == 0) {
            swat_gunner linkto(helicopter, "tag_rider1", (0, 0, 0), (0, 90, 0));
        } else {
            swat_gunner linkto(helicopter, "tag_rider2", (0, 0, 0), (0, -90, 0));
        }
        swat_gunner function_27eb0046(swat_gunner);
        swat_gunner thread function_16eeeb93(owner);
        swat_gunner thread function_75a32df0(swat_gunner, helicopter);
    }
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x4
// Checksum 0x8456ebac, Offset: 0x5370
// Size: 0x96
function private function_3733773(tacpoint, context) {
    if (tacpoint.ceilingheight >= 4000) {
        /#
            recordsphere(tacpoint.origin, 2, (0, 1, 0), "<dev string:x31>");
        #/
        return true;
    }
    /#
        recordsphere(tacpoint.origin, 2, (1, 0, 0), "<dev string:x31>");
    #/
    return false;
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x4
// Checksum 0xb2694d10, Offset: 0x5410
// Size: 0xa6
function private function_c544ed11(origin, context) {
    if (ispointonnavmesh(origin, 45)) {
        /#
            recordsphere(origin + (0, 0, 10), 2, (0, 1, 0), "<dev string:x31>");
        #/
        return true;
    }
    /#
        recordsphere(origin + (0, 0, 10), 2, (1, 0, 0), "<dev string:x31>");
    #/
    return false;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x4
// Checksum 0x5b2f0c92, Offset: 0x54c0
// Size: 0x104
function private function_da52d234(origin, context, verticaloffset) {
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        destination = origin + (0, 0, verticaloffset);
        var_6f7637e2 = ispointinnavvolume(destination, "navvolume_big");
        if (var_6f7637e2) {
            /#
                recordsphere(origin + (0, 0, 20), 2, (0, 1, 0), "<dev string:x31>");
            #/
            return true;
        }
        /#
            recordsphere(origin + (0, 0, 20), 2, (1, 0, 0), "<dev string:x31>");
        #/
        return false;
    }
    return true;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x4
// Checksum 0x9add60c, Offset: 0x55d0
// Size: 0x140
function private function_8ae2ceee(origin, context, verticaloffset) {
    mask = 1;
    radius = 30;
    trace = physicstrace(origin + (0, 0, verticaloffset), origin + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), mask);
    if (trace[#"fraction"] < 1) {
        /#
            recordsphere(origin + (0, 0, 20), 2, (1, 0, 0), "<dev string:x31>");
        #/
        return false;
    }
    /#
        recordsphere(origin + (0, 0, 20), 2, (0, 1, 0), "<dev string:x31>");
    #/
    return true;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x0
// Checksum 0xed33774d, Offset: 0x5718
// Size: 0xf2
function function_3da41164(origins, context, verticaloffset) {
    assert(isdefined(origins) && origins.size);
    filteredpoints = [];
    foreach (origin in origins) {
        if (function_8ae2ceee(origin, context, verticaloffset)) {
            filteredpoints[filteredpoints.size] = origin;
            break;
        }
        waitframe(1);
    }
    return filteredpoints;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x4
// Checksum 0x4284938e, Offset: 0x5818
// Size: 0x130
function private function_78327378(tacpoints, context, verticaloffset) {
    assert(isdefined(tacpoints) && tacpoints.size);
    filteredpoints = [];
    foreach (tacpoint in tacpoints) {
        if (function_3733773(tacpoint, context) && function_c544ed11(tacpoint.origin, context) && function_da52d234(tacpoint.origin, context, verticaloffset)) {
            filteredpoints[filteredpoints.size] = tacpoint.origin;
        }
    }
    return filteredpoints;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x0
// Checksum 0xa1fc5a68, Offset: 0x5950
// Size: 0x2b6
function function_45eea428(var_4a256eea, context, owner) {
    if (getdvarint(#"hash_60d47d611bbc3bed", 1)) {
        verticaloffset = getstartorigin(var_4a256eea, (0, 0, 0), "ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2")[2] - var_4a256eea[2];
        if (function_c544ed11(var_4a256eea, context) && function_da52d234(var_4a256eea, context, verticaloffset)) {
            if (function_8ae2ceee(var_4a256eea, context, verticaloffset)) {
                return var_4a256eea;
            }
        }
        cylinder = ai::t_cylinder(var_4a256eea, 2000, 200);
        var_ae49e2a0 = ai::t_cylinder(var_4a256eea, 100, 200);
        tacpoints = tacticalquery("swat_team_deploy", var_4a256eea, cylinder, var_ae49e2a0);
        if (isdefined(tacpoints) && tacpoints.size) {
            tacpoints = function_78327378(tacpoints, context, verticaloffset);
            waitframe(1);
            if (tacpoints.size) {
                tacpoints = arraysortclosest(tacpoints, var_4a256eea);
                filteredpoints = function_3da41164(tacpoints, context, verticaloffset);
                if (isdefined(filteredpoints[0])) {
                    /#
                        recordsphere(filteredpoints[0] + (0, 0, 70), 4, (1, 0.5, 0), "<dev string:x31>");
                    #/
                    return filteredpoints[0];
                } else {
                    var_2a9ea29a = arraygetclosest(var_4a256eea, tacpoints);
                    /#
                        recordsphere(var_2a9ea29a + (0, 0, 70), 4, (0, 1, 1), "<dev string:x31>");
                    #/
                    return var_2a9ea29a;
                }
            }
        }
    }
    return var_4a256eea;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x0
// Checksum 0xe1d1b118, Offset: 0x5c10
// Size: 0xf6
function function_9413ce6e(helicopter, var_4a256eea, destination) {
    helicopter endon(#"death", #"payload_delivered", #"hash_216c905d79c8bbea");
    while (true) {
        /#
            recordsphere(var_4a256eea, 4, (1, 0.5, 0), "<dev string:x31>");
            recordsphere(destination, 4, (1, 0.5, 0), "<dev string:x31>");
            recordline(var_4a256eea, destination, (1, 0.5, 0), "<dev string:x31>");
        #/
        waitframe(1);
    }
}

// Namespace swat_team/swat_team
// Params 4, eflags: 0x4
// Checksum 0xd98273aa, Offset: 0x5d10
// Size: 0x528
function private function_ed7d4fae(owner, var_4a256eea, nodes, context) {
    owner endoncallback(&function_d82364b9, #"disconnect", #"joined_team", #"joined_spectators");
    assert(isdefined(var_4a256eea));
    var_4a256eea = function_45eea428(var_4a256eea, context, owner);
    destination = getstartorigin(var_4a256eea, (0, 0, 0), "ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2");
    var_799562a = helicopter::getvalidrandomstartnode(destination).origin;
    helicopter = spawn_swat_helicopter(owner, var_799562a, vectortoangles(owner.origin - var_799562a), context);
    helicopter endon(#"death");
    helicopter endon(#"hash_216c905d79c8bbea");
    helicopter.hardpointtype = "swat_team";
    waitframe(1);
    /#
        helicopter thread function_9413ce6e(helicopter, var_4a256eea, destination);
    #/
    function_8edb82a4(helicopter);
    assert(isdefined(owner.swat_team));
    position = 0;
    foreach (swat in owner.swat_team) {
        aiutility::addaioverridedamagecallback(swat, &function_eabb08f8);
        swat linkto(helicopter, "tag_origin", (0, 0, 0), (0, 0, 0));
        swat thread function_fa6a6097(swat, helicopter, position);
        swat thread function_885c54ce(swat);
        owner thread function_75a32df0(swat, helicopter, context.killstreak_id);
        position++;
    }
    helicopter thread function_3e4666a1(helicopter, destination);
    helicopter waittill(#"reached_destination");
    helicopter thread function_7bdc40cb(helicopter, var_4a256eea);
    wait_start = gettime();
    while (helicopter.origin[2] - var_4a256eea[2] > 620 && gettime() - wait_start < 1000) {
        wait 0.1;
    }
    level thread function_c03f10c3(helicopter);
    position = 0;
    foreach (swat in owner.swat_team) {
        if (position == 0) {
            swat thread swat_deploy(swat, helicopter, position, nodes[position], 1);
        } else {
            swat thread swat_deploy(swat, helicopter, position, nodes[position], 0);
        }
        position++;
    }
    wait 6.4;
    helicopter thread function_af099dbd(helicopter);
    context.deployed = 1;
    helicopter thread function_b4b74073(helicopter);
    helicopter notify(#"payload_delivered");
    owner notify(#"payload_delivered");
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0x31240a13, Offset: 0x6240
// Size: 0xc4
function function_8dcc4b08(team, killstreak_id) {
    self endon(#"payload_delivered", #"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");
    self waittill(#"payload_fail");
    if (isdefined(self.var_1af217bc.deployed) && self.var_1af217bc.deployed) {
        return;
    }
    self stopkillstreak(self.var_1af217bc);
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xfed86fba, Offset: 0x6310
// Size: 0x152
function function_86e6830e(meansofdeath) {
    if (!isdefined(self.ai.var_171467eb)) {
        self.ai.var_171467eb = gettime();
    }
    vo_type = "generic_pain";
    if (meansofdeath === "MOD_MELEE" || meansofdeath === "MOD_MELEE_WEAPON_BUTT") {
        vo_type = "stab_pain";
    } else if (isdefined(self.var_a38dd6f)) {
        switch (self.var_a38dd6f) {
        case #"fire":
            vo_type = "fire_pain";
            break;
        case #"flash":
        case #"emp":
        case #"electrical":
            vo_type = "flash_pain";
            break;
        }
    }
    if (gettime() >= self.ai.var_171467eb) {
        self thread function_13393de9(vo_type);
        self.ai.var_171467eb = randomintrange(2000, 3500);
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xc0b83721, Offset: 0x6470
// Size: 0x5aa
function private function_13393de9(type) {
    self endon(#"death");
    if (!isdefined(level.var_fd8df427)) {
        level.var_fd8df427 = [];
        array::add(level.var_fd8df427, #"hash_2416186b2c2fd1a8");
        array::add(level.var_fd8df427, #"hash_5ed736ce5677e90");
        array::add(level.var_fd8df427, #"hash_6ac3aef794ea4b07");
    }
    if (!isdefined(level.var_f8974da2)) {
        level.var_f8974da2 = [];
        array::add(level.var_f8974da2, #"hash_310164c2facacc31");
        array::add(level.var_f8974da2, #"hash_c3ec7c69991c32d");
        array::add(level.var_f8974da2, #"hash_6ac3aef794ea4b07");
    }
    if (!isdefined(self.voxid)) {
        return;
    }
    switch (type) {
    case #"swat_arrive":
        if (self.voxid) {
            self playsound(#"hash_56b7aae259b5a917");
        } else {
            self playsound(#"hash_4bf706e954f1c546");
        }
        break;
    case #"swat_destroyed":
        if (self.voxid) {
            self playsound(#"hash_2009c0412f91af0b");
        } else {
            self playsound(#"hash_5ff088609f0462f4");
        }
        break;
    case #"swat_engaging":
        if (self.voxid) {
            self playsound(#"hash_4102874b1b06f938");
        } else {
            self playsound(#"hash_3f60777864899961");
        }
        break;
    case #"swat_kill":
        if (self.voxid) {
            self playsound(#"hash_1ab599435464ac20");
        } else {
            self playsound(#"hash_2c3d8a130bd5a971");
        }
        break;
    case #"swat_ready":
        if (self.voxid) {
            self playsound(#"hash_229ff7554bbef677");
        } else {
            self playsound(#"hash_5f3caebd8741eb2c");
        }
    case #"generic_pain":
        if (self.voxid) {
            self playsound(array::random(level.var_fd8df427));
        } else {
            self playsound(array::random(level.var_f8974da2));
        }
        break;
    case #"flash_pain":
        if (randomint(100) > 50) {
            if (self.voxid) {
                self playsound(#"hash_36b05bd405239e64");
            } else {
                self playsound(#"hash_5647597c1cb17d77");
            }
        } else if (self.voxid) {
            self playsound(#"hash_245affd4245ea3f");
        } else {
            self playsound(#"hash_7fd1fc03b11ce4cc");
        }
        break;
    case #"fire_pain":
        if (self.voxid) {
            self playsound(#"hash_658b80360bccb644");
        } else {
            self playsound(#"hash_2f0ae3994beebb2f");
        }
        break;
    case #"stab_pain":
        if (self.voxid) {
            self playsound(#"hash_4bd3cc9d2839f677");
        } else {
            self playsound(#"hash_483bf5e7289c4f18");
        }
        break;
    default:
        break;
    }
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x0
// Checksum 0x4daf47d6, Offset: 0x6a28
// Size: 0x48c
function spawn_swat_team(owner, context, origin) {
    if (!isdefined(owner.swat_team)) {
        self.swat_team = [];
    } else {
        owner swat_cleanup();
        owner notify(#"hash_71a1db99eb99dcff");
    }
    owner.var_1af217bc = context;
    owner.var_1af217bc.kills = 0;
    owner.var_1af217bc.clear_kills = 0;
    zone = function_7a19cd5(origin);
    var_4a256eea = undefined;
    nodes = [];
    owner killstreaks::play_killstreak_start_dialog("swat_team", self.team, context.killstreak_id);
    owner thread function_8dcc4b08(owner.team, context.killstreak_id);
    if (isdefined(zone)) {
        nodes = getnodearray(zone.target, "targetname");
        for (i = 0; i < nodes.size; i++) {
            if (nodes[i].type == "BAD NODE") {
                nodes = function_f8e8448a(origin);
                break;
            }
        }
    } else {
        nodes = function_f8e8448a(origin);
    }
    if (!isdefined(nodes)) {
        nodes = [];
        for (i = 0; i < 2; i++) {
            if (!isdefined(nodes)) {
                nodes = [];
            } else if (!isarray(nodes)) {
                nodes = array(nodes);
            }
            nodes[nodes.size] = (0, 0, 0);
        }
    }
    var_4a256eea = origin;
    aitypes = level.var_4c7ab42c[#"axis"];
    if (isdefined(owner.team) && owner.team == #"allies") {
        aitypes = level.var_4c7ab42c[#"allies"];
    }
    for (i = 0; i < 2; i++) {
        swat = spawnactor(aitypes[i], (-1000, 0, 0), (0, 0, 0), "swat");
        if (!isdefined(self.swat_team)) {
            self.swat_team = [];
        } else if (!isarray(self.swat_team)) {
            self.swat_team = array(self.swat_team);
        }
        self.swat_team[self.swat_team.size] = swat;
        swat setentityowner(self);
        swat setteam(self.team);
        swat.ignoreall = 1;
        swat.ignoreme = 1;
        obj_set("swat_member", swat);
        swat.voxid = i;
        swat callback::function_1dea870d(#"on_ai_killed", &function_e397fc44);
    }
    owner thread swat_loop(context.killstreak_id);
    owner function_ed7d4fae(owner, var_4a256eea, nodes, context);
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x4
// Checksum 0x1014a7ba, Offset: 0x6ec0
// Size: 0xb0
function private function_74c1abdc() {
    self endon(#"death");
    while (true) {
        waittillframeend();
        if (isdefined(self.enemy) && isplayer(self.enemy) && self cansee(self.enemy)) {
            self.holdfire = !self targetting_delay::function_3b2437d9(self.enemy);
        } else {
            self.holdfire = 0;
        }
        waitframe(1);
    }
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0x2b95dc32, Offset: 0x6f78
// Size: 0x15a
function function_f257c654() {
    self endon(#"death");
    if (isactor(self) && self.archetype === "human") {
        laser_weapon = getweapon(self.weapon.name, "steadyaim");
        self ai::gun_remove();
        self ai::gun_switchto(laser_weapon, "right");
        wait 2;
        clientfield::set("swat_light_strobe", 1);
        self.var_b154c656 = function_f9f48566() / 1000;
        self thread targetting_delay::function_3362444f();
        self thread function_74c1abdc();
        self thread function_dcb7e010();
        self thread function_16eeeb93(self.script_owner);
        self.killstreaktype = "swat_team";
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x433d6cc, Offset: 0x70e0
// Size: 0x5f6
function function_873fad8e(killstreak_id) {
    self endon(#"hash_71a1db99eb99dcff");
    self endon(#"disconnect", #"joined_team");
    if (!isdefined(self.var_1af217bc)) {
        return;
    }
    if (!isdefined(self.var_1af217bc.remoteweapon)) {
        return;
    }
    if (!isdefined(self.var_1af217bc.remoteweapon.usetrigger)) {
        return;
    }
    self.var_1af217bc.remoteweapon.usetrigger endon(#"death");
    while (isdefined(self.var_1af217bc) && isdefined(self.var_1af217bc.remoteweapon)) {
        if (!isdefined(self.var_1af217bc.remoteweapon.usetrigger)) {
            break;
        }
        res = self.var_1af217bc.remoteweapon.usetrigger waittill(#"trigger", #"death");
        if (res._notify == "death") {
            break;
        }
        if (self.var_eb3b93ad == #"swat_team") {
            waitframe(1);
            if (!self function_1b77f4ea() && !(isdefined(self.is_capturing_own_supply_drop) && self.is_capturing_own_supply_drop)) {
                ordering = 1;
                timer = gettime() + 50;
                self notify(#"hash_388d15e349a6a017");
                if (self.var_18c08c57 == "swat_escort") {
                    self.var_18c08c57 = "swat_guard";
                    self swat_guard();
                    if (isdefined(self.var_1af217bc.remoteweapon)) {
                        self.var_1af217bc.remoteweapon function_88296881("");
                    }
                    wait 3;
                    if (isdefined(self.var_1af217bc.remoteweapon)) {
                        if (!self gamepadusedlast()) {
                            self.var_1af217bc.remoteweapon function_88296881(#"hash_600af0ac4af0b090");
                        } else {
                            self.var_1af217bc.remoteweapon function_88296881(#"hash_60c7465070c7985c");
                        }
                    }
                } else {
                    self.var_18c08c57 = "swat_escort";
                    self gestures::function_42215dfa(#"gestable_order_follow", undefined, 0);
                    self function_1af7867a();
                    self thread swat_escort();
                    if (isdefined(self.var_1af217bc.remoteweapon)) {
                        self.var_1af217bc.remoteweapon function_88296881("");
                    }
                    wait 3;
                    if (isdefined(self.var_1af217bc.remoteweapon)) {
                        if (!self gamepadusedlast()) {
                            self.var_1af217bc.remoteweapon function_88296881(#"hash_167e638f51287532");
                        } else {
                            self.var_1af217bc.remoteweapon function_88296881(#"hash_6800108794068996");
                        }
                    }
                }
            }
        } else if (isdefined(ordering) && ordering && !self util::use_button_held()) {
            ordering = 0;
        }
        if (isdefined(self.is_capturing_own_supply_drop) && self.is_capturing_own_supply_drop) {
            if (isdefined(self.var_1af217bc.remoteweapon)) {
                self.var_1af217bc.remoteweapon function_88296881("");
            }
            wait 5;
            if (isdefined(self.var_1af217bc.remoteweapon)) {
                if (self.var_18c08c57 == "swat_guard") {
                    if (!self gamepadusedlast()) {
                        self.var_1af217bc.remoteweapon function_88296881(#"hash_600af0ac4af0b090");
                    } else {
                        self.var_1af217bc.remoteweapon function_88296881(#"hash_60c7465070c7985c");
                    }
                    continue;
                }
                if (!self gamepadusedlast()) {
                    self.var_1af217bc.remoteweapon function_88296881(#"hash_600af0ac4af0b090");
                    continue;
                }
                self.var_1af217bc.remoteweapon function_88296881(#"hash_60c7465070c7985c");
            }
        }
    }
    waitframe(1);
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x1702e375, Offset: 0x76e0
// Size: 0x2f0
function swat_loop(killstreak_id) {
    self endon(#"hash_71a1db99eb99dcff");
    self endoncallback(&function_d82364b9, #"disconnect", #"joined_team");
    endtime = gettime() + self.var_1af217bc.time;
    self.var_eb3b93ad = #"swat_team";
    self.var_18c08c57 = "swat_escort";
    function_fd802221(self, 1);
    self thread swat_escort(0);
    self waittill(#"payload_delivered");
    if (isplayer(self)) {
        if (!self gamepadusedlast()) {
            self.var_1af217bc.remoteweapon = self createremoteweapontrigger(#"hash_167e638f51287532");
        } else {
            self.var_1af217bc.remoteweapon = self createremoteweapontrigger(#"hash_6800108794068996");
        }
    }
    self thread function_873fad8e(killstreak_id);
    while (isdefined(self.var_1af217bc)) {
        alldead = 1;
        for (i = 0; i < 2; i++) {
            if (!isdefined(self.swat_team[i])) {
                continue;
            }
            alldead = 0;
            break;
        }
        if (alldead || gettime() > endtime) {
            if (alldead) {
                self globallogic_audio::flush_killstreak_dialog_on_player(killstreak_id);
                self globallogic_audio::play_taacom_dialog("destroyed", "swat_team");
            } else if (gettime() > endtime) {
                self globallogic_audio::play_taacom_dialog("timeout", "swat_team");
            }
            self function_1af7867a();
            start_swat_team_leave();
            if (isdefined(self.var_1af217bc.remoteweapon)) {
                self.var_1af217bc.remoteweapon.usetrigger delete();
                self.var_1af217bc.remoteweapon = undefined;
            }
            break;
        }
        waitframe(1);
    }
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0xfcc5664, Offset: 0x79d8
// Size: 0x2c
function sort_by_score(left, right) {
    return left.score > right.score;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x4
// Checksum 0x86b03467, Offset: 0x7a10
// Size: 0x162
function private function_8f3bc0a2(var_e9c38fc3, var_555c60d2, nodes) {
    tacpoint = getclosesttacpoint(var_555c60d2);
    foreach (node in nodes) {
        withinfov = vectordot(var_e9c38fc3, vectornormalize(node.origin - var_555c60d2) > cos(30));
        if (withinfov && function_c80ec59e(tacpoint, node.origin)) {
            node.score = 100;
            continue;
        }
        node.score = 0;
    }
    return array::merge_sort(nodes, &sort_by_score);
}

// Namespace swat_team/swat_team
// Params 5, eflags: 0x0
// Checksum 0x8360b836, Offset: 0x7b80
// Size: 0x2f6
function function_90fb5656(swat, owner, var_e9c38fc3, var_555c60d2, forced = 0) {
    /#
        recordsphere(var_555c60d2, 8, (0, 1, 1), "<dev string:x31>");
    #/
    nodes = getnodesinradiussorted(var_555c60d2, 600, 64, 300, "Path");
    if (nodes.size) {
        if (!forced) {
            nodes_sorted = function_8f3bc0a2(var_e9c38fc3, var_555c60d2, nodes);
        } else {
            nodes_sorted = nodes;
        }
        foreach (node in nodes_sorted) {
            if (canclaimnode(node, owner.team) && !isdefined(node.owner)) {
                /#
                    recordsphere(node.origin, 4, (1, 0.5, 0), "<dev string:x31>");
                    recordline(owner.origin, node.origin, (1, 0.5, 0), "<dev string:x31>");
                #/
                if (!swat.keepclaimednode) {
                    swat setgoal(node);
                    swat usecovernode(node);
                    swat.var_b0dbb171 = node.origin;
                    swat.var_bae8cb14 = node;
                }
                break;
            }
        }
        return;
    }
    points = function_f8e8448a(var_555c60d2);
    for (i = 0; i < 2; i++) {
        if (owner.swat_team[i] == swat) {
            swat setgoal(points[i]);
            swat.var_b0dbb171 = points[i];
            return;
        }
    }
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0xb12792e, Offset: 0x7e80
// Size: 0x626
function function_fd802221(owner, forced = 0) {
    result = function_cfee2a04(owner.origin, 1000);
    if (!isdefined(result)) {
        return;
    }
    owner_origin = result[#"point"];
    if (!isdefined(owner_origin)) {
        return;
    }
    potentialenemies = getplayers(util::getotherteam(owner.team));
    if (!forced) {
        velocity = owner getvelocity();
        if (length(velocity) >= 20) {
            velocity = vectornormalize(velocity);
            owner.var_16fbbf6e = velocity;
        }
        if (isdefined(owner.var_16fbbf6e)) {
            var_555c60d2 = owner_origin + vectorscale(vectornormalize(owner.var_16fbbf6e), 200);
        } else {
            var_555c60d2 = owner_origin + vectorscale(anglestoforward(owner.angles), 200);
        }
    } else {
        var_555c60d2 = owner_origin;
    }
    result = function_cfee2a04(var_555c60d2, 1000);
    if (isdefined(result)) {
        var_555c60d2 = result[#"point"];
    }
    if (!isdefined(var_555c60d2) && (!isdefined(potentialenemies) || !potentialenemies.size)) {
        waitframe(1);
        return;
    }
    for (i = 0; i < 2; i++) {
        if (!isdefined(owner.swat_team[i])) {
            continue;
        }
        swat = owner.swat_team[i];
        if (isdefined(swat.ai.var_a21f13b)) {
            continue;
        }
        if (!isdefined(swat.ai.var_b0700f0a)) {
            swat.ai.var_b0700f0a = gettime();
        }
        if (isdefined(potentialenemies) && potentialenemies.size) {
            if (isdefined(swat.enemy)) {
                nearbyplayer = swat.enemy;
            } else {
                nearbyplayer = arraygetclosest(swat.origin, potentialenemies);
            }
            var_9d2c634 = distancesquared(swat.origin, nearbyplayer.origin);
            if (swat cansee(nearbyplayer) || var_9d2c634 < 300 * 300) {
                waitframe(1);
                continue;
            }
            if (isdefined(nearbyplayer)) {
                if (gettime() < swat.ai.var_b0700f0a) {
                    waitframe(1);
                    continue;
                }
                tacpoint = getclosesttacpoint(nearbyplayer.origin);
                if (isdefined(tacpoint)) {
                    cylinder = ai::t_cylinder(swat.origin, 1200, 200);
                    var_db1ad975 = ai::t_cylinder(swat.origin, 150, 200);
                    var_d61458c1 = ai::t_cylinder(swat.origin, 300, 200);
                    tacpoints = tacticalquery("swat_tacquery_seek", swat.origin, cylinder, swat, var_db1ad975, tacpoint.origin, var_d61458c1);
                    if (isdefined(tacpoints) && tacpoints.size) {
                        swat setgoal(tacpoints[0].origin, 1);
                        swat.ai.var_b0700f0a = randomintrange(2000, 3000);
                        continue;
                    }
                }
            }
        }
        if (!isdefined(var_555c60d2)) {
            waitframe(1);
            continue;
        }
        var_e9c38fc3 = vectornormalize(var_555c60d2 - owner_origin);
        tacpoint = getclosesttacpoint(var_555c60d2);
        shouldmove = 0;
        if (isdefined(tacpoint)) {
            if (forced) {
                shouldmove = 1;
            } else if (isdefined(swat.var_b0dbb171)) {
                shouldmove = distancesquared(var_555c60d2, swat.var_b0dbb171) >= 600 * 600;
            } else {
                shouldmove = distancesquared(var_555c60d2, swat.origin) >= 600 * 600;
            }
        }
        if (shouldmove) {
            function_90fb5656(swat, owner, var_e9c38fc3, var_555c60d2, forced);
        }
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xe221d63e, Offset: 0x84b0
// Size: 0xfe
function swat_escort(playgesture = 1) {
    owner = self;
    owner endon(#"hash_71a1db99eb99dcff", #"disconnect", #"joined_team");
    owner waittill(#"payload_delivered");
    owner function_1af7867a();
    if (playgesture) {
        owner gestures::function_42215dfa(#"gestable_order_follow", undefined, 0);
    }
    while (true) {
        if (self.var_18c08c57 == "swat_escort") {
            function_fd802221(owner);
        }
        wait 1;
    }
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0x6abc2a0, Offset: 0x85b8
// Size: 0x386
function swat_guard() {
    direction = self getplayerangles();
    direction_vec = anglestoforward(direction);
    eye = self geteye();
    direction_vec = (direction_vec[0] * 2000, direction_vec[1] * 2000, direction_vec[2] * 2000);
    trace = bullettrace(eye, eye + direction_vec, 0, self);
    position = getclosestpointonnavmesh(trace[#"position"]);
    if (!isdefined(position)) {
        var_d7b81c34 = trace[#"position"] - eye;
        for (i = 0; i < 8; i++) {
            testpos = eye + vectorscale(var_d7b81c34, (8 - i) / 8);
            position = function_cfee2a04(testpos, 800);
            if (isdefined(position)) {
                position = position[#"point"];
                break;
            }
        }
    }
    if (!isdefined(position)) {
        return;
    }
    zone = function_7a19cd5(position);
    if (isdefined(zone)) {
        nodes = getnodearray(zone.target, "targetname");
        for (i = 0; i < nodes.size; i++) {
            if (nodes[i].type == "BAD NODE") {
                nodes = function_f8e8448a(position);
                break;
            }
        }
    } else {
        nodes = function_f8e8448a(position);
    }
    if (!isdefined(nodes)) {
        waitframe(1);
        return;
    }
    self function_72726415(position);
    self gestures::function_42215dfa(#"hash_5c6551e0e87ff08b", undefined, 0);
    for (i = 0; i < 2; i++) {
        if (!isdefined(self.swat_team[i])) {
            return;
        }
        if (i == 0) {
            self.swat_team[i] thread function_13393de9("swat_ready");
        }
        self.swat_team[i] setgoal(nodes[i]);
    }
    self.var_1af217bc.clear_kills = 0;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x887f1b9, Offset: 0x8948
// Size: 0x1c
function function_d82364b9(str_notify) {
    swat_cleanup();
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xdcca39c9, Offset: 0x8970
// Size: 0xbe
function function_6cd148b0(tacpoint) {
    players = getplayers();
    foreach (player in players) {
        if (distancesquared(tacpoint.origin, player.origin) <= 200 * 200) {
            return true;
        }
    }
    return false;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x8805c066, Offset: 0x8a38
// Size: 0xaa
function function_19edab19(tacpoint) {
    players = getplayers();
    foreach (player in players) {
        if (function_c80ec59e(tacpoint, player.origin)) {
            return true;
        }
    }
    return false;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xe9004b9b, Offset: 0x8af0
// Size: 0xec
function private function_42b50663(tacpoints) {
    assert(isdefined(tacpoints) && tacpoints.size);
    filteredpoints = [];
    foreach (tacpoint in tacpoints) {
        if (!function_19edab19(tacpoint) && !function_6cd148b0(tacpoint)) {
            filteredpoints[filteredpoints.size] = tacpoint;
        }
    }
    return filteredpoints;
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0xec0b7d08, Offset: 0x8be8
// Size: 0x218
function private function_7c1057c1(owner) {
    if (isdefined(owner)) {
        origin = owner.origin;
        angles = owner getplayerangles();
    } else {
        origin = self.origin;
        angles = self.angles;
    }
    cylinder = ai::t_cylinder(self.origin, 1500, 250);
    var_60b8e47f = origin;
    var_bb460730 = ai::t_cylinder(origin, 100, 250);
    tacpoints = tacticalquery("swat_team_leave", origin, self, cylinder, var_bb460730, var_60b8e47f);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_42b50663(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:angles};
        }
    }
    tacpoints = tacticalquery("swat_team_leave_fallback", origin, self, cylinder, var_bb460730, var_60b8e47f);
    if (isdefined(tacpoints) && tacpoints.size) {
        tacpoints = function_42b50663(tacpoints);
        if (tacpoints.size) {
            tacpoint = array::random(tacpoints);
            return {#origin:tacpoint.origin, #angles:angles};
        }
    }
    return undefined;
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0x5bdd800d, Offset: 0x8e08
// Size: 0x86
function start_swat_team_leave() {
    for (i = 0; i < 2; i++) {
        if (!isdefined(self.swat_team[i])) {
            continue;
        }
        if (isdefined(self.owner)) {
            self.owner notify(#"hash_71a1db99eb99dcff");
        }
        self.swat_team[i] thread swat_leave();
    }
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0xd6fd6d9c, Offset: 0x8e98
// Size: 0x160
function function_219f1b11() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        players = getplayers();
        canbeseen = 0;
        foreach (player in players) {
            if (sighttracepassed(self geteye(), player geteye(), 0, undefined)) {
                canbeseen = 1;
                break;
            }
        }
        if (!canbeseen) {
            function_6286b942("swat_member", self);
            util::wait_network_frame();
            self delete();
        }
        wait 0.5;
    }
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0xd70aed59, Offset: 0x9000
// Size: 0x15c
function swat_leave() {
    self endon(#"death");
    level endon(#"game_ended");
    self.exit_spawn = function_7c1057c1(self.script_owner);
    self clientfield::set("swat_rob_state", 1);
    if (isdefined(self.exit_spawn)) {
        self thread function_219f1b11();
        self function_9f59031e();
        self pathmode("move allowed");
        self.goalradius = 20;
        self setgoal(self.exit_spawn.origin, 0);
        self waittilltimeout(10, #"goal");
    }
    waittillframeend();
    function_6286b942("swat_member", self);
    util::wait_network_frame();
    self delete();
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0x7c020bdc, Offset: 0x9168
// Size: 0x268
function swat_cleanup(destroy_heli) {
    if (gamestate::is_game_over()) {
        return;
    }
    if (!isdefined(destroy_heli)) {
        destroy_heli = 1;
    }
    self notify(#"hash_71a1db99eb99dcff");
    profilestart();
    if (isdefined(self.var_1af217bc)) {
        for (i = self.swat_team.size; i >= 0; i--) {
            if (isdefined(self.swat_team[i]) && isalive(self.swat_team[i])) {
                self.swat_team[i] kill();
            }
        }
        if (isdefined(self.var_3ba5a2d9)) {
            for (i = self.var_3ba5a2d9.size; i >= 0; i--) {
                if (isdefined(self.var_3ba5a2d9[i]) && isalive(self.var_3ba5a2d9[i])) {
                    self.var_3ba5a2d9[i] kill();
                }
            }
        }
        if (isdefined(self.var_1af217bc.helicopter)) {
            function_7a4daa04(self.var_1af217bc.helicopter);
            if (destroy_heli) {
                thread swat_helicopter_explode(self.var_1af217bc.helicopter);
            }
        }
        self function_1af7867a();
        if (isdefined(self.var_1af217bc.killstreak_id) && isdefined(self.var_1af217bc.var_5e08dfac)) {
            stopkillstreak(self.var_1af217bc);
        }
        if (isdefined(self.var_1af217bc.remoteweapon)) {
            self.var_1af217bc.remoteweapon.usetrigger delete();
            self.var_1af217bc.remoteweapon = undefined;
        }
        self.var_1af217bc = undefined;
    }
    self.swat_team = [];
    profilestop();
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xd8f027a9, Offset: 0x93d8
// Size: 0x24
function function_e397fc44(params) {
    function_6286b942("swat_member", self);
}

// Namespace swat_team/swat_team
// Params 4, eflags: 0x0
// Checksum 0xc80094e3, Offset: 0x9408
// Size: 0x2d2
function function_b794738(einflictor, victim, idamage, weapon) {
    attacker = self;
    if (!isdefined(attacker.var_1af217bc)) {
        return;
    }
    if (isactor(einflictor)) {
        attacker.var_1af217bc.kills++;
        if (attacker.var_1af217bc.kills == 3) {
            scoreevents::processscoreevent(#"hash_7caba8ab83b5373f", attacker, victim, getweapon(#"swat_team"));
        }
        if (einflictor isatgoal()) {
            scoreevents::processscoreevent(#"hash_69a40144e52332f9", attacker, victim, getweapon(#"swat_team"));
        } else {
            attacker.var_1af217bc.clear_kills++;
            if (attacker.var_1af217bc.clear_kills == 2) {
                scoreevents::processscoreevent(#"hash_7e7146503217ca9c", attacker, victim, getweapon(#"swat_team"));
            }
        }
        return;
    }
    foreach (swat in attacker.swat_team) {
        if (isdefined(swat) && isdefined(swat.enemy) && swat.enemy == victim && swat attackedrecently(victim, 3)) {
            scoreevents::processscoreevent(#"hash_1f0ecf369a09e682", attacker, victim, getweapon(#"swat_team"));
            return;
        }
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x4
// Checksum 0x7592d75, Offset: 0x96e8
// Size: 0x21c
function private function_72726415(origin) {
    self function_1af7867a();
    if (isdefined(self.var_1af217bc.marker)) {
        self.var_1af217bc.marker.origin = origin;
        self.var_1af217bc.marker.team = self.team;
        self.var_1af217bc.marker entityheadicons::setentityheadicon(self.pers[#"team"], self, self.var_1af217bc.objective);
        objid = self.var_1af217bc.marker.entityheadobjectives[self.var_1af217bc.marker.entityheadobjectives.size - 1];
        objective_setinvisibletoall(objid);
        objective_setvisibletoplayer(objid, self);
    }
    self.var_1af217bc.fx_marker = spawnfx(self.var_1af217bc.fx_name, origin + (0, 0, 3), (0, 0, 1), (1, 0, 0));
    self.var_1af217bc.fx_marker.team = self.team;
    triggerfx(self.var_1af217bc.fx_marker);
    self.var_1af217bc.fx_marker setinvisibletoall();
    self.var_1af217bc.fx_marker setvisibletoplayer(self);
    self playsoundtoplayer(#"uin_mp_combat_bot_guard", self);
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x4
// Checksum 0xe5a9dac, Offset: 0x9910
// Size: 0x92
function private function_1af7867a() {
    if (!isdefined(self.var_1af217bc)) {
        return;
    }
    if (isdefined(self.var_1af217bc.marker)) {
        self.var_1af217bc.marker entityheadicons::destroyentityheadicons();
    }
    if (isdefined(self.var_1af217bc.fx_marker)) {
        self.var_1af217bc.fx_marker delete();
        self.var_1af217bc.fx_marker = undefined;
    }
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xe1824499, Offset: 0x99b0
// Size: 0x132
function function_7a19cd5(origin) {
    structs = struct::get_array("swat_zone", "variantname");
    if (!structs.size) {
        return undefined;
    }
    shortest = distancesquared(origin, structs[0].origin);
    best = structs[0];
    foreach (struct in structs) {
        newdist = distancesquared(origin, struct.origin);
        if (newdist < shortest) {
            shortest = newdist;
            best = struct;
        }
    }
    return best;
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0x214b410f, Offset: 0x9af0
// Size: 0x236
function function_cff5746f(location, context) {
    foreach (droplocation in level.droplocations) {
        if (distance2dsquared(droplocation, location) < 3600) {
            return false;
        }
    }
    if (context.perform_physics_trace === 1) {
        mask = 1;
        if (isdefined(context.tracemask)) {
            mask = context.tracemask;
        }
        radius = context.radius;
        trace = physicstrace(location + (0, 0, 5000), location + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
        if (trace[#"fraction"] < 1) {
            if (!(isdefined(level.var_25b256f9) && level.var_25b256f9)) {
                return false;
            }
        }
    }
    result = function_cfee2a04(location + (0, 0, 100), 170);
    if (!isdefined(result)) {
        return false;
    }
    if (context.check_same_floor === 1 && abs(location[2] - self.origin[2]) > 96) {
        return false;
    }
    return true;
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0x93b64ef5, Offset: 0x9d30
// Size: 0x490
function islocationgood(location, context) {
    if (getdvarint(#"hash_60d47d611bbc3bed", 1)) {
        return function_cff5746f(location, context);
    }
    foreach (droplocation in level.droplocations) {
        if (distance2dsquared(droplocation, location) < 3600) {
            return 0;
        }
    }
    if (context.perform_physics_trace === 1) {
        mask = 1;
        if (isdefined(context.tracemask)) {
            mask = context.tracemask;
        }
        radius = context.radius;
        trace = physicstrace(location + (0, 0, 5000), location + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
        if (trace[#"fraction"] < 1) {
            if (!(isdefined(level.var_25b256f9) && level.var_25b256f9)) {
                return 0;
            }
        }
    }
    closestpoint = getclosestpointonnavmesh(location, max(context.max_dist_from_location, 24), context.dist_from_boundary);
    isvalidpoint = isdefined(closestpoint);
    if (isvalidpoint && context.check_same_floor === 1 && abs(location[2] - closestpoint[2]) > 96) {
        isvalidpoint = 0;
    }
    if (isvalidpoint && distance2dsquared(location, closestpoint) > context.max_dist_from_location * context.max_dist_from_location) {
        isvalidpoint = 0;
    }
    if (isdefined(level.var_6fb48cdb) && level.var_6fb48cdb) {
        destination = getstartorigin(location, (0, 0, 0), "ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2");
        var_6f7637e2 = ispointinnavvolume(destination, "navvolume_big");
        if (!var_6f7637e2) {
            isvalidpoint = 0;
        }
    }
    /#
        if (getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
            if (!isvalidpoint) {
                otherclosestpoint = getclosestpointonnavmesh(location, getdvarfloat(#"scr_supply_drop_valid_location_radius_debug", 96), context.dist_from_boundary);
                if (isdefined(otherclosestpoint)) {
                    sphere(otherclosestpoint, context.max_dist_from_location, (1, 0, 0), 0.8, 0, 20, 1);
                }
            } else {
                sphere(closestpoint, context.max_dist_from_location, (0, 1, 0), 0.8, 0, 20, 1);
                util::drawcylinder(closestpoint, context.radius, 8000, 0.0166667, undefined, (0, 0.9, 0), 0.7);
            }
        }
    #/
    return isvalidpoint;
}

// Namespace swat_team/swat_team
// Params 0, eflags: 0x0
// Checksum 0xa477f604, Offset: 0xa1c8
// Size: 0x8c
function checkforemp() {
    self endon(#"hash_27be2db04a0908d5");
    self endon(#"spawned_player");
    self endon(#"disconnect");
    self endon(#"weapon_change");
    self endon(#"death");
    self endon(#"trigger_weapon_shutdown");
    self waittill(#"emp_jammed");
    self killstreaks::switch_to_last_non_killstreak_weapon();
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0x5b04ec84, Offset: 0xa260
// Size: 0xa6
function checkweaponchange(team, killstreak_id) {
    self endon(#"hash_27be2db04a0908d5", #"spawned_player", #"disconnect", #"trigger_weapon_shutdown", #"death");
    self waittill(#"weapon_change");
    stopkillstreak(self.var_1af217bc);
    self notify(#"cleanup_marker");
}

// Namespace swat_team/swat_team
// Params 1, eflags: 0x0
// Checksum 0xd8c7ac19, Offset: 0xa310
// Size: 0x6a
function stopkillstreak(context) {
    if (isdefined(context.var_b4c1bba2) && context.var_b4c1bba2) {
        return;
    }
    killstreakrules::killstreakstop("swat_team", context.var_5e08dfac, context.killstreak_id);
    context.var_b4c1bba2 = 1;
}

// Namespace swat_team/swat_team
// Params 3, eflags: 0x0
// Checksum 0xb4960439, Offset: 0xa388
// Size: 0x78
function addoffsetontopoint(point, direction, offset) {
    angles = vectortoangles((direction[0], direction[1], 0));
    offset_world = rotatepoint(offset, angles);
    return point + offset_world;
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0x70e54e9b, Offset: 0xa408
// Size: 0x18c
function obj_set(str_objective, e_target) {
    n_obj_id = gameobjects::get_next_obj_id();
    if (!isdefined(e_target.a_n_objective_ids)) {
        e_target.a_n_objective_ids = [];
    }
    e_target.a_n_objective_ids[str_objective] = n_obj_id;
    objective_add(n_obj_id, "active", e_target, str_objective);
    function_c3a2445a(n_obj_id, e_target.team, 1);
    objective_setteam(n_obj_id, e_target.team);
    n_obj_id = gameobjects::get_next_obj_id();
    e_target.a_n_objective_ids[str_objective + "_enemy"] = n_obj_id;
    objective_add(n_obj_id, "active", e_target, str_objective + "_enemy");
    function_eeba3a5c(n_obj_id, 1);
    function_c3a2445a(n_obj_id, e_target.team, 0);
    objective_setteam(n_obj_id, e_target.team);
}

// Namespace swat_team/swat_team
// Params 2, eflags: 0x0
// Checksum 0x8a7cbcca, Offset: 0xa5a0
// Size: 0x104
function function_6286b942(str_objective, e_target) {
    if (isdefined(e_target.a_n_objective_ids) && isdefined(e_target.a_n_objective_ids[str_objective])) {
        n_obj_id = e_target.a_n_objective_ids[str_objective];
        e_target.a_n_objective_ids[str_objective] = undefined;
        objective_setstate(n_obj_id, "done");
        gameobjects::release_obj_id(n_obj_id);
        n_obj_id = e_target.a_n_objective_ids[str_objective + "_enemy"];
        e_target.a_n_objective_ids[str_objective + "_enemy"] = undefined;
        objective_setstate(n_obj_id, "done");
        gameobjects::release_obj_id(n_obj_id);
    }
}

