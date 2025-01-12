#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_robot;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\mp\supplydrop;
#using scripts\mp_common\bb;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;
#using scripts\weapons\weaponobjects;

#namespace escort;

// Namespace escort/escort
// Params 0, eflags: 0x2
// Checksum 0xcfa856a2, Offset: 0x828
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"escort", &__init__, undefined, undefined);
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x83b334f8, Offset: 0x870
// Size: 0x84
function __init__() {
    clientfield::register("actor", "robot_state", 1, 2, "int");
    clientfield::register("actor", "escort_robot_burn", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace escort/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x24057507, Offset: 0x900
// Size: 0x4a4
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerroundscorelimit(0, 2000);
    util::registerscorelimit(0, 5000);
    util::registerroundlimit(0, 12);
    util::registerroundswitch(0, 9);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    level.boottime = getgametypesetting(#"boottime");
    level.reboottime = getgametypesetting(#"reboottime");
    level.rebootplayers = getgametypesetting(#"rebootplayers");
    level.moveplayers = getgametypesetting(#"moveplayers");
    level.robotshield = getgametypesetting(#"robotshield");
    level.robotspeed = "run";
    level.var_c9d3723c = &function_4fdb87a6;
    switch (getgametypesetting(#"shutdowndamage")) {
    case 1:
        level.escortrobotkillstreakbundle = "escort_robot_low";
        break;
    case 2:
        level.escortrobotkillstreakbundle = "escort_robot";
        break;
    case 3:
        level.escortrobotkillstreakbundle = "escort_robot_high";
    case 0:
    default:
        level.shutdowndamage = 0;
        break;
    }
    if (isdefined(level.escortrobotkillstreakbundle)) {
        killstreak_bundles::register_killstreak_bundle(level.escortrobotkillstreakbundle);
        level.shutdowndamage = killstreak_bundles::get_max_health(level.escortrobotkillstreakbundle);
    }
    /#
        switch (getdvarint(#"robotspeed", 1)) {
        case 1:
            level.robotspeed = "<dev string:x30>";
            break;
        case 2:
            level.robotspeed = "<dev string:x34>";
            break;
        case 0:
        default:
            level.robotspeed = "<dev string:x3b>";
            break;
        }
    #/
    globallogic_audio::set_leader_gametype_dialog("startSafeguard", "hcStartSafeguard", "sfgStartAttack", "sfgStartDefend");
    level.overrideteamscore = 1;
    level.scoreroundwinbased = 1;
    level.doubleovertime = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    player::function_b0320e78(&onplayerkilled);
    level.ontimelimit = &ontimelimit;
    level.onendround = &onendround;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    killstreak_bundles::register_killstreak_bundle("escort_robot");
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xab20af37, Offset: 0xdb0
// Size: 0x114
function function_4fdb87a6() {
    spawning::place_spawn_points("mp_escort_spawn_attacker_start");
    spawning::place_spawn_points("mp_escort_spawn_defender_start");
    spawning::add_start_spawn_points("attackers", "mp_escort_spawn_attacker_start");
    spawning::add_start_spawn_points("defenderss", "mp_escort_spawn_defender_start");
    spawning::add_spawn_points("attackers", "mp_escort_spawn_attacker");
    spawning::add_spawn_points("defenders", "mp_escort_spawn_defender");
    spawning::add_fallback_spawnpoints("attackers", "mp_tdm_spawn");
    spawning::add_fallback_spawnpoints("defenders", "mp_tdm_spawn");
    spawning::updateallspawnpoints();
    spawning::update_fallback_spawnpoints();
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x3d488a7, Offset: 0xed0
// Size: 0x154
function onstartgametype() {
    globallogic_spawn::addsupportedspawnpointtype("escort");
    globallogic_spawn::addspawns();
    if (overtime::is_overtime_round()) {
        [[ level._setteamscore ]](#"allies", 0);
        [[ level._setteamscore ]](#"axis", 0);
        level.ontimelimit = &function_9990aed0;
        if (game.overtime_round == 1) {
            level.onendround = &function_491cda2f;
        } else if (isdefined(game.var_6ed6aaa7)) {
            times = float(game.var_6ed6aaa7) / 1000;
            timem = int(times) / 60;
            util::registertimelimit(timem, timem);
        }
    }
    level thread drop_robot();
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x4640fdf5, Offset: 0x1030
// Size: 0x24
function onspawnplayer(predictedspawn) {
    spawning::onspawnplayer(predictedspawn);
}

// Namespace escort/escort
// Params 9, eflags: 0x0
// Checksum 0xd6c293fd, Offset: 0x1060
// Size: 0x194
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isdefined(attacker) || attacker == self || !isplayer(attacker) || attacker.team == self.team) {
        return;
    }
    if (self.team == game.defenders && isdefined(attacker.escortingrobot) && attacker.escortingrobot) {
        attacker recordgameevent("attacking");
        scoreevents::processscoreevent(#"killed_defender", attacker, self, weapon);
        return;
    }
    if (self.team == game.attackers && isdefined(self.escortingrobot) && self.escortingrobot) {
        attacker recordgameevent("defending");
        scoreevents::processscoreevent(#"killed_attacker", attacker, self, weapon);
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x69f221cd, Offset: 0x1200
// Size: 0x54
function ontimelimit() {
    globallogic_score::giveteamscoreforobjective_delaypostprocessing(game.defenders, 1);
    round::set_winner(game.defenders);
    level thread globallogic::end_round(2);
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x8b33b47, Offset: 0x1260
// Size: 0x34
function function_9990aed0() {
    round::set_winner(game.defenders);
    level thread globallogic::end_round(2);
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0xe1c08ec, Offset: 0x12a0
// Size: 0x84
function onendround(var_c3d87d03) {
    winningteam = round::get_winning_team();
    if (isdefined(level.robot.distancetraveled)) {
        iprintln("Robot has traveled: " + level.robot.distancetraveled);
    }
    level.robot thread delete_on_endgame_sequence();
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x6772ff9a, Offset: 0x1330
// Size: 0xfc
function function_491cda2f(var_c3d87d03) {
    if (isdefined(level.robot.distancetraveled)) {
        iprintln("Robot has traveled: " + level.robot.distancetraveled);
    }
    switch (var_c3d87d03) {
    case 1:
        game.var_6ed6aaa7 = globallogic_utils::gettimepassed();
        break;
    case 2:
        game.var_ef2b23fe = level.robot.origin;
        break;
    default:
        break;
    }
    level.robot thread delete_on_endgame_sequence();
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xff30fd2b, Offset: 0x1438
// Size: 0xc6
function shouldplayovertimeround() {
    if (overtime::is_overtime_round()) {
        if (game.overtime_round == 1 || !level.gameended) {
            return true;
        }
        return false;
    }
    alliesroundswon = util::getroundswon(#"allies");
    axisroundswon = util::getroundswon(#"axis");
    if (util::hitroundlimit() && alliesroundswon == axisroundswon) {
        return true;
    }
    return false;
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x40465647, Offset: 0x1508
// Size: 0xe
function on_player_spawned() {
    self.escortingrobot = undefined;
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xd0f2eece, Offset: 0x1520
// Size: 0x864
function drop_robot() {
    globallogic::waitforplayers();
    movetrigger = getent("escort_robot_move_trig", "targetname");
    patharray = get_robot_path_array();
    startdir = patharray[0] - movetrigger.origin;
    startangles = vectortoangles(startdir);
    drop_origin = movetrigger.origin;
    drop_height = isdefined(level.escort_drop_height) ? level.escort_drop_height : supplydrop::getdropheight(drop_origin);
    heli_drop_goal = (drop_origin[0], drop_origin[1], drop_height);
    level.robotstart = drop_origin;
    goalpath = undefined;
    dropoffset = (0, -120, 0);
    goalpath = supplydrop::supplydrophelistartpath_v2_setup(heli_drop_goal, dropoffset);
    supplydrop::supplydrophelistartpath_v2_part2_local(heli_drop_goal, goalpath, dropoffset);
    drop_direction = vectortoangles((heli_drop_goal[0], heli_drop_goal[1], 0) - (goalpath.start[0], goalpath.start[1], 0));
    chopper = spawnvehicle("combat_escort_robot_dropship", heli_drop_goal, (0, 0, 0));
    chopper.maxhealth = 999999;
    chopper.health = 999999;
    chopper.spawntime = gettime();
    supplydropspeed = isdefined(level.escort_drop_speed) ? level.escort_drop_speed : getdvarint(#"scr_supplydropspeedstarting", 1000);
    supplydropaccel = isdefined(level.escort_drop_accel) ? level.escort_drop_accel : getdvarint(#"scr_supplydropaccelstarting", 1000);
    chopper setspeed(supplydropspeed, supplydropaccel);
    maxpitch = getdvarint(#"scr_supplydropmaxpitch", 25);
    maxroll = getdvarint(#"scr_supplydropmaxroll", 45);
    chopper setmaxpitchroll(0, maxroll);
    spawnposition = (0, 0, 0);
    spawnangles = (0, 0, 0);
    level.robot = spawn_robot(spawnposition, spawnangles);
    level.robot.onground = undefined;
    level.robot.team = game.attackers;
    level.robot setforcenocull();
    vehicle::get_in(level.robot, chopper, "driver");
    level.robot.dropundervehicleoriginoverride = 1;
    level.robot.targetangles = startangles;
    chopper vehicle::unload("all");
    level.robot playsound(#"evt_safeguard_robot_land");
    chopper thread drop_heli_leave();
    while (level.robot flagsys::get(#"in_vehicle")) {
        wait 1;
    }
    level.robot.patharray = patharray;
    level.robot.pathindex = 0;
    level.robot.victimsoundmod = "safeguard_robot";
    level.robot.goaljustblocked = 0;
    level.robot thread update_stop_position();
    level.robot thread watch_robot_damaged();
    level.robot thread wait_robot_moving();
    level.robot thread wait_robot_stopped();
    level.robot.spawn_influencer_friendly = level.robot influencers::create_entity_friendly_influencer("escort_robot_attackers", game.attackers);
    /#
        debug_draw_robot_path();
        level thread debug_reset_robot_to_start();
    #/
    level.moveobject = setup_move_object(level.robot, "escort_robot_move_trig");
    level.goalobject = setup_goal_object(level.robot, "escort_robot_goal_trig");
    setup_reboot_object(level.robot, "escort_robot_reboot_trig");
    if (level.boottime) {
        level.robot clientfield::set("robot_state", 2);
        level.moveobject gameobjects::set_flags(2);
        level.robot setblackboardattribute("_stance", "crouch");
        level.robot ai::set_behavior_attribute("rogue_control_speed", level.robotspeed);
        level.robot shutdown_robot();
    } else {
        objective_setprogress(level.moveobject.objectiveid, 1);
        level.moveobject gameobjects::allow_use(#"friendly");
    }
    level.robot thread wait_robot_shutdown();
    level.robot thread wait_robot_reboot();
    while (level.inprematchperiod) {
        waitframe(1);
    }
    level.robot.onground = 1;
    level.robot.distancetraveled = 0;
    level.robot thread function_6e971ba();
    if (level.boottime) {
        level.robot thread auto_reboot_robot(level.boottime);
        return;
    }
    if (level.moveplayers == 0) {
        level.robot move_robot();
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x26f6d07d, Offset: 0x1d90
// Size: 0x14c
function drop_heli_leave() {
    chopper = self;
    wait 1;
    supplydropspeed = getdvarint(#"scr_supplydropspeedleaving", 250);
    supplydropaccel = getdvarint(#"scr_supplydropaccelleaving", 60);
    chopper setspeed(supplydropspeed, supplydropaccel);
    goal = helicopter::getvalidrandomleavenode(chopper.origin, 1).origin;
    chopper setgoal(goal);
    chopper setneargoalnotifydist(400);
    result = chopper waittill(#"near_goal", #"goal_reached", #"goal");
    chopper delete();
}

/#

    // Namespace escort/escort
    // Params 0, eflags: 0x0
    // Checksum 0xbf62a79f, Offset: 0x1ee8
    // Size: 0x1b8
    function debug_draw_robot_path() {
        if ((isdefined(getdvarint(#"scr_escort_debug_robot_path", 0)) ? getdvarint(#"scr_escort_debug_robot_path", 0) : 0) == 0) {
            return;
        }
        debug_duration = 999999999;
        pathnodes = level.robot.patharray;
        for (i = 0; i < pathnodes.size - 1; i++) {
            currnode = pathnodes[i];
            nextnode = pathnodes[i + 1];
            util::debug_line(currnode, nextnode, (0, 0.9, 0), 0.9, 0, debug_duration);
        }
        foreach (path in pathnodes) {
            util::debug_sphere(path, 6, (0, 0, 0.9), 0.9, debug_duration);
        }
    }

    // Namespace escort/escort
    // Params 1, eflags: 0x0
    // Checksum 0xf04f79ac, Offset: 0x20a8
    // Size: 0x1b0
    function debug_draw_approximate_robot_path_to_goal(&goalpatharray) {
        if ((isdefined(getdvarint(#"scr_escort_debug_robot_path", 0)) ? getdvarint(#"scr_escort_debug_robot_path", 0) : 0) == 0) {
            return;
        }
        debug_duration = 60;
        pathnodes = goalpatharray;
        for (i = 0; i < pathnodes.size - 1; i++) {
            currnode = pathnodes[i];
            nextnode = pathnodes[i + 1];
            util::debug_line(currnode, nextnode, (0.9, 0.9, 0), 0.9, 0, debug_duration);
        }
        foreach (path in pathnodes) {
            util::debug_sphere(path, 3, (0, 0.5, 0.5), 0.9, debug_duration);
        }
    }

    // Namespace escort/escort
    // Params 1, eflags: 0x0
    // Checksum 0x24867168, Offset: 0x2260
    // Size: 0xb4
    function debug_draw_current_robot_goal(goal) {
        if ((isdefined(getdvarint(#"scr_escort_debug_robot_path", 0)) ? getdvarint(#"scr_escort_debug_robot_path", 0) : 0) == 0) {
            return;
        }
        if (isdefined(goal)) {
            debug_duration = 60;
            util::debug_sphere(goal, 8, (0, 0.9, 0), 0.9, debug_duration);
        }
    }

    // Namespace escort/escort
    // Params 1, eflags: 0x0
    // Checksum 0xc3c39429, Offset: 0x2320
    // Size: 0xc4
    function debug_draw_find_immediate_goal(pathgoal) {
        if ((isdefined(getdvarint(#"scr_escort_debug_robot_path", 0)) ? getdvarint(#"scr_escort_debug_robot_path", 0) : 0) == 0) {
            return;
        }
        if (isdefined(pathgoal)) {
            debug_duration = 60;
            util::debug_sphere(pathgoal + (0, 0, 18), 6, (0.9, 0, 0), 0.9, debug_duration);
        }
    }

    // Namespace escort/escort
    // Params 1, eflags: 0x0
    // Checksum 0xf7876794, Offset: 0x23f0
    // Size: 0xc4
    function debug_draw_find_immediate_goal_override(immediategoal) {
        if ((isdefined(getdvarint(#"scr_escort_debug_robot_path", 0)) ? getdvarint(#"scr_escort_debug_robot_path", 0) : 0) == 0) {
            return;
        }
        if (isdefined(immediategoal)) {
            debug_duration = 60;
            util::debug_sphere(immediategoal + (0, 0, 18), 6, (0.9, 0, 0.9), 0.9, debug_duration);
        }
    }

    // Namespace escort/escort
    // Params 2, eflags: 0x0
    // Checksum 0x47db376d, Offset: 0x24c0
    // Size: 0x10c
    function debug_draw_blocked_path_kill_radius(center, radius) {
        if ((isdefined(getdvarint(#"scr_escort_debug_robot_path", 0)) ? getdvarint(#"scr_escort_debug_robot_path", 0) : 0) == 0) {
            return;
        }
        if (isdefined(center)) {
            debug_duration = 200;
            circle(center + (0, 0, 2), radius, (0.9, 0, 0), 1, 1, debug_duration);
            circle(center + (0, 0, 4), radius, (0.9, 0, 0), 1, 1, debug_duration);
        }
    }

#/

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x4f6b1003, Offset: 0x25d8
// Size: 0x98
function wait_robot_moving() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_moving");
        self recordgameeventnonplayer("robot_start");
        self clientfield::set("robot_state", 1);
        level.moveobject gameobjects::set_flags(1);
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x3944b736, Offset: 0x2678
// Size: 0xa8
function wait_robot_stopped() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_stopped");
        if (self.active) {
            self recordgameeventnonplayer("robot_stop");
            self clientfield::set("robot_state", 0);
            level.moveobject gameobjects::set_flags(0);
        }
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x1956af16, Offset: 0x2728
// Size: 0x198
function wait_robot_shutdown() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_shutdown");
        level.moveobject gameobjects::allow_use(#"none");
        objective_setprogress(level.moveobject.objectiveid, -0.05);
        self clientfield::set("robot_state", 2);
        level.moveobject gameobjects::set_flags(2);
        otherteam = util::getotherteam(self.team);
        globallogic_audio::leader_dialog("sfgRobotDisabledAttacker", self.team, undefined, "robot");
        globallogic_audio::leader_dialog("sfgRobotDisabledDefender", otherteam, undefined, "robot");
        globallogic_audio::play_2d_on_team("mpl_safeguard_disabled_sting_friend", self.team);
        globallogic_audio::play_2d_on_team("mpl_safeguard_disabled_sting_enemy", otherteam);
        self thread auto_reboot_robot(level.reboottime);
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x545d2989, Offset: 0x28c8
// Size: 0x1e8
function wait_robot_reboot() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_reboot");
        self recordgameeventnonplayer("robot_repair_complete");
        level.moveobject gameobjects::allow_use(#"friendly");
        otherteam = util::getotherteam(self.team);
        globallogic_audio::leader_dialog("sfgRobotRebootedAttacker", self.team, undefined, "robot");
        globallogic_audio::leader_dialog("sfgRobotRebootedDefender", otherteam, undefined, "robot");
        globallogic_audio::play_2d_on_team("mpl_safeguard_reboot_sting_friend", self.team);
        globallogic_audio::play_2d_on_team("mpl_safeguard_reboot_sting_enemy", otherteam);
        objective_setprogress(level.moveobject.objectiveid, 1);
        if (level.moveplayers == 0) {
            self move_robot();
            continue;
        }
        if (level.moveobject.numtouching[level.moveobject.ownerteam] == 0) {
            self clientfield::set("robot_state", 0);
            level.moveobject gameobjects::set_flags(0);
        }
    }
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x1f2e28f2, Offset: 0x2ab8
// Size: 0x2a4
function auto_reboot_robot(time) {
    self endon(#"robot_reboot");
    self endon(#"game_ended");
    shutdowntime = 0;
    while (shutdowntime < time) {
        rate = 0;
        friendlycount = level.moveobject.numtouching[level.moveobject.ownerteam];
        if (!level.rebootplayers) {
            rate = float(function_f9f48566()) / 1000;
        } else if (friendlycount > 0) {
            rate = float(function_f9f48566()) / 1000;
            if (friendlycount > 1) {
                bonusrate = (friendlycount - 1) * float(function_f9f48566()) / 1000 * 0;
                rate += bonusrate;
            }
        }
        if (rate > 0) {
            shutdowntime += rate;
            percent = min(1, shutdowntime / time);
            objective_setprogress(level.moveobject.objectiveid, percent);
        }
        waitframe(1);
    }
    if (level.rebootplayers > 0) {
        foreach (struct in level.moveobject.touchlist[game.attackers]) {
            scoreevents::processscoreevent(#"escort_robot_reboot", struct.player, undefined, undefined);
        }
    }
    self thread reboot_robot();
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x9b5c6180, Offset: 0x2d68
// Size: 0x162
function watch_robot_damaged() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_damaged");
        percent = min(1, self.shutdowndamage / level.shutdowndamage);
        objective_setprogress(level.moveobject.objectiveid, 1 - percent);
        health = level.shutdowndamage - self.shutdowndamage;
        lowhealth = killstreak_bundles::get_low_health(level.escortrobotkillstreakbundle);
        if (!(isdefined(self.playeddamage) && self.playeddamage) && health <= lowhealth) {
            globallogic_audio::leader_dialog("sfgRobotUnderFire", self.team, undefined, "robot");
            self.playeddamage = 1;
            continue;
        }
        if (health > lowhealth) {
            self.playeddamage = 0;
        }
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xc7fa9ec5, Offset: 0x2ed8
// Size: 0x44
function delete_on_endgame_sequence() {
    self endon(#"death");
    level waittill(#"endgame_intermission");
    self delete();
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x9ab34201, Offset: 0x2f28
// Size: 0x12c
function get_robot_path_array() {
    if (isdefined(level.escortrobotpath)) {
        println("<dev string:x40>");
        return level.escortrobotpath;
    }
    println("<dev string:x63>");
    patharray = [];
    currnode = getnode("escort_robot_path_start", "targetname");
    patharray[patharray.size] = currnode.origin;
    while (isdefined(currnode.target)) {
        currnode = getnode(currnode.target, "targetname");
        patharray[patharray.size] = currnode.origin;
    }
    if (isdefined(level.update_escort_robot_path)) {
        [[ level.update_escort_robot_path ]](patharray);
    }
    return patharray;
}

/#

    // Namespace escort/escort
    // Params 2, eflags: 0x0
    // Checksum 0x38d4b612, Offset: 0x3060
    // Size: 0xb4
    function calc_robot_path_length(robotorigin, patharray) {
        distance = 0;
        lastpoint = robotorigin;
        for (i = 0; i < patharray.size; i++) {
            distance += distance(lastpoint, patharray[i]);
            lastpoint = patharray[i];
        }
        println("<dev string:x77>" + distance);
    }

#/

// Namespace escort/escort
// Params 2, eflags: 0x0
// Checksum 0x5609ab9b, Offset: 0x3120
// Size: 0x428
function spawn_robot(position, angles) {
    robot = spawnactor("spawner_bo3_robot_grunt_assault_mp_escort", position, angles, "", 1);
    robot ai::set_behavior_attribute("rogue_allow_pregib", 0);
    robot ai::set_behavior_attribute("rogue_allow_predestruct", 0);
    robot ai::set_behavior_attribute("rogue_control", "forced_level_2");
    robot ai::set_behavior_attribute("rogue_control_speed", level.robotspeed);
    robot val::set(#"escort_robot", "ignoreall", 1);
    robot.allowdeath = 0;
    robot ai::set_behavior_attribute("can_become_crawler", 0);
    robot ai::set_behavior_attribute("can_be_meleed", 0);
    robot ai::set_behavior_attribute("can_initiateaivsaimelee", 0);
    robot ai::set_behavior_attribute("traversals", "procedural");
    aiutility::clearaioverridedamagecallbacks(robot);
    robot.active = 1;
    robot.canwalk = 1;
    robot.moving = 0;
    robot.shutdowndamage = 0;
    robot.propername = "";
    robot.ignoretriggerdamage = 1;
    robot.allowpain = 0;
    robot clientfield::set("robot_mind_control", 0);
    robot ai::set_behavior_attribute("robot_lights", 3);
    robot.pushable = 0;
    robot collidewithactors(1);
    robot pushplayer(1);
    robot setavoidancemask("avoid none");
    robot disableaimassist();
    robot setsteeringmode("slow steering");
    robot setblackboardattribute("_robot_locomotion_type", "alt1");
    if (level.robotshield) {
        aiutility::attachriotshield(robot, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_stowed_back");
    }
    robot asmsetanimationrate(1.1);
    if (isdefined(level.shutdowndamage) && level.shutdowndamage) {
        target_set(robot, (0, 0, 50));
    }
    robot.overrideactordamage = &robot_damage;
    robot thread robot_move_chatter();
    robot.missiletargetmissdistance = 64;
    robot thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile();
    return robot;
}

// Namespace escort/escort
// Params 12, eflags: 0x0
// Checksum 0x9dc36de, Offset: 0x3550
// Size: 0x6da
function robot_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    if (!(isdefined(self.onground) && self.onground)) {
        return false;
    }
    if (level.shutdowndamage <= 0 || !self.active || eattacker.team == game.attackers) {
        return false;
    }
    level.usestartspawns = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage(level.escortrobotkillstreakbundle, level.shutdowndamage, eattacker, weapon, smeansofdeath, idamage, idflags, undefined);
    if (!isdefined(weapon_damage)) {
        weapon_damage = idamage;
    }
    if (!weapon_damage) {
        return false;
    }
    self.shutdowndamage += weapon_damage;
    self notify(#"robot_damaged");
    if (!isdefined(eattacker.damagerobot)) {
        eattacker.damagerobot = 0;
    }
    eattacker.damagerobot += weapon_damage;
    if (self.shutdowndamage >= level.shutdowndamage) {
        origin = (0, 0, 0);
        if (isplayer(eattacker)) {
            level thread popups::displayteammessagetoall(#"hash_6fd616c1d7988357", eattacker);
            level.robot recordgameeventnonplayer("robot_disabled");
            if (distance2dsquared(self.origin, level.goalobject.trigger.origin) < (level.goalobject.trigger.radius + 50) * (level.goalobject.trigger.radius + 50)) {
                scoreevents::processscoreevent(#"escort_robot_disable_near_goal", eattacker, undefined, undefined);
            } else {
                scoreevents::processscoreevent(#"escort_robot_disable", eattacker, undefined, undefined);
            }
            if (isdefined(eattacker.pers[#"disables"])) {
                eattacker.pers[#"disables"]++;
                eattacker.disables = eattacker.pers[#"disables"];
            }
            eattacker stats::function_2dabbec7(#"disables", 1);
            eattacker recordgameevent("return");
            origin = eattacker.origin;
        }
        foreach (player in level.players) {
            if (player == eattacker || player.team == self.team || !isdefined(player.damagerobot)) {
                continue;
            }
            damagepercent = player.damagerobot / level.shutdowndamage;
            if (damagepercent >= 0.5) {
                scoreevents::processscoreevent(#"escort_robot_disable_assist_50", player, undefined, undefined);
            } else if (damagepercent >= 0.25) {
                scoreevents::processscoreevent(#"escort_robot_disable_assist_25", player, undefined, undefined);
            }
            player.damagerobot = undefined;
        }
        bb::function_9cca214a("escort_shutdown", undefined, game.defenders, origin);
        self shutdown_robot();
        if (isdefined(eattacker) && eattacker != self && isdefined(weapon)) {
            if (weapon.name == #"planemortar") {
                if (!isdefined(eattacker.planemortarbda)) {
                    eattacker.planemortarbda = 0;
                }
                eattacker.planemortarbda++;
            } else if (weapon.name == #"dart" || weapon.name == #"dart_turret") {
                if (!isdefined(eattacker.dartbda)) {
                    eattacker.dartbda = 0;
                }
                eattacker.dartbda++;
            } else if (weapon.name == #"straferun_rockets" || weapon.name == #"straferun_gun") {
                if (isdefined(eattacker.straferunbda)) {
                    eattacker.straferunbda++;
                }
            } else if (weapon.name == #"remote_missile_missile" || weapon.name == #"remote_missile_bomblet") {
                if (!isdefined(eattacker.remotemissilebda)) {
                    eattacker.remotemissilebda = 0;
                }
                eattacker.remotemissilebda++;
            }
        }
    }
    self.health += 1;
    return true;
}

// Namespace escort/escort
// Params 12, eflags: 0x0
// Checksum 0xa5b83dd6, Offset: 0x3c38
// Size: 0x66
function robot_damage_none(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    return false;
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xb274ce53, Offset: 0x3ca8
// Size: 0x154
function shutdown_robot() {
    self.active = 0;
    self val::set(#"hash_3de2bce887b7b68d", "ignoreme", 1);
    self.canwalk = 0;
    self stop_robot();
    self notify(#"robot_shutdown");
    if (target_istarget(self)) {
        target_remove(self);
    }
    if (isdefined(self.riotshield)) {
        self asmchangeanimmappingtable(1);
        self detach(self.riotshield.model, self.riotshield.tag);
        aiutility::attachriotshield(self, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_weapon_left");
    }
    self ai::set_behavior_attribute("shutdown", 1);
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x9c267c6d, Offset: 0x3e08
// Size: 0x19a
function reboot_robot() {
    self endon(#"robot_shutdown");
    level endon(#"game_ended");
    self.active = 1;
    self.shutdowndamage = 0;
    self val::reset(#"hash_3de2bce887b7b68d", "ignoreme");
    self notify(#"robot_reboot");
    if (isdefined(level.shutdowndamage) && level.shutdowndamage) {
        target_set(self, (0, 0, 50));
    }
    if (isdefined(self.riotshield)) {
        self asmchangeanimmappingtable(0);
        self detach(self.riotshield.model, self.riotshield.tag);
        aiutility::attachriotshield(self, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_stowed_back");
    }
    self ai::set_behavior_attribute("shutdown", 0);
    wait getanimlength(#"ai_robot_rogue_ctrl_crc_shutdown_2_alert");
    self.canwalk = 1;
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xbe9c1f5c, Offset: 0x3fb0
// Size: 0xb4
function move_robot() {
    if (self.active == 0 || self.moving || !isdefined(self.pathindex)) {
        return;
    }
    if (self check_blocked_goal_and_kill()) {
        return;
    }
    if (gettime() < (isdefined(self.blocked_wait_end_time) ? self.blocked_wait_end_time : 0)) {
        return;
    }
    self notify(#"robot_moving");
    self.moving = 1;
    self set_goal_to_point_on_path();
    self thread robot_wait_next_point();
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x4763dab6, Offset: 0x4070
// Size: 0x174
function function_6e971ba() {
    self endon(#"robot_shutdown");
    level endon(#"game_ended");
    while (true) {
        if (self.moving) {
            distance = 0;
            if (self.pathindex > 0) {
                distance += distance(level.robotstart, self.patharray[0]);
                for (i = 1; i < self.pathindex; i++) {
                    distance += distance(self.patharray[i - 1], self.patharray[i]);
                }
                distance += distance(self.patharray[self.pathindex - 1], self.origin);
            } else {
                distance += distance(level.robotstart, self.origin);
            }
            if (distance > self.distancetraveled) {
                self.distancetraveled = distance;
            }
        }
        waitframe(1);
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xc2abb14, Offset: 0x41f0
// Size: 0x2c
function get_current_goal() {
    return isdefined(self.immediategoaloverride) ? self.immediategoaloverride : self.patharray[self.pathindex];
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x8fb75aea, Offset: 0x4228
// Size: 0xfe
function reached_closest_nav_mesh_goal_but_still_too_far_and_blocked(goalonnavmesh) {
    if (isdefined(self.immediategoaloverride)) {
        return false;
    }
    distsqr = distancesquared(goalonnavmesh, self.origin);
    robotreachedclosestgoalonnavmesh = distsqr <= 24 * 24;
    if (robotreachedclosestgoalonnavmesh) {
        closestgoalonnavmeshtoofarfrompathgoal = distancesquared(goalonnavmesh, self.patharray[self.pathindex]) > 1 * 1;
        if (closestgoalonnavmeshtoofarfrompathgoal) {
            robotisblockedfromgettingtopathgoal = self check_if_goal_is_blocked(self.origin, self.patharray[self.pathindex]);
            if (robotisblockedfromgettingtopathgoal) {
                return true;
            }
        }
    }
    return false;
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x5d1c1232, Offset: 0x4330
// Size: 0x1bc
function check_blocked_goal_and_kill() {
    if (!self.canwalk) {
        return 0;
    }
    if (gettime() < (isdefined(self.blocked_wait_end_time) ? self.blocked_wait_end_time : 0)) {
        wait float(self.blocked_wait_end_time - gettime()) / 1000;
    }
    goalonnavmesh = self get_closest_point_on_nav_mesh_for_current_goal();
    previousgoal = self.pathindex > 0 && !isdefined(self.immediategoaloverride) ? self.patharray[self.pathindex - 1] : self.origin;
    if (self.goaljustblocked || self reached_closest_nav_mesh_goal_but_still_too_far_and_blocked(goalonnavmesh) || self check_if_goal_is_blocked(previousgoal, goalonnavmesh)) {
        self.goaljustblocked = 0;
        stillblocked = 1;
        killedsomething = self kill_anything_blocking_goal(goalonnavmesh);
        if (killedsomething) {
            stillblocked = self check_if_goal_is_blocked(previousgoal, goalonnavmesh);
            if (stillblocked) {
                self.blocked_wait_end_time = gettime() + 200;
                self stop_robot();
            }
        } else {
            self find_immediate_goal();
        }
        return stillblocked;
    }
    return 0;
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xc5636256, Offset: 0x44f8
// Size: 0x10c
function find_immediate_goal() {
    pathgoal = self.patharray[self.pathindex];
    currpos = self.origin;
    /#
        debug_draw_find_immediate_goal(pathgoal);
    #/
    for (immediategoal = get_closest_point_on_nav_mesh(vectorlerp(currpos, pathgoal, 0.5)); self check_if_goal_is_blocked(currpos, immediategoal); immediategoal = get_closest_point_on_nav_mesh(vectorlerp(currpos, immediategoal, 0.5))) {
    }
    self.immediategoaloverride = immediategoal;
    /#
        debug_draw_find_immediate_goal_override(self.immediategoaloverride);
    #/
}

// Namespace escort/escort
// Params 2, eflags: 0x0
// Checksum 0xdfe9b24b, Offset: 0x4610
// Size: 0xba
function check_if_goal_is_blocked(previousgoal, goal) {
    approxpatharray = self calcapproximatepathtoposition(goal);
    distancetonextgoal = min(distance(self.origin, goal), distance(previousgoal, goal));
    approxpathtoolong = is_path_distance_to_goal_too_long(approxpatharray, distancetonextgoal * 2.5);
    return approxpathtoolong;
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x49c101c7, Offset: 0x46d8
// Size: 0x13a
function watch_goal_becoming_blocked(goal) {
    self notify(#"end_watch_goal_becoming_blocked_singleton");
    self endon(#"end_watch_goal_becoming_blocked_singleton");
    self endon(#"robot_stopped");
    self endon(#"goal");
    level endon(#"game_ended");
    disttogoalsqr = 1e+09;
    while (true) {
        wait 0.1;
        if (isdefined(self.traversestartnode)) {
            self waittill(#"traverse_end");
            continue;
        }
        if (self asmistransdecrunning()) {
            continue;
        }
        if (!self.canwalk) {
            continue;
        }
        newdisttogoalsqr = distancesquared(self.origin, goal);
        if (newdisttogoalsqr < disttogoalsqr) {
            disttogoalsqr = newdisttogoalsqr;
            continue;
        }
        self.goaljustblocked = 1;
        self notify(#"goal_blocked");
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x363f1683, Offset: 0x4820
// Size: 0x13e
function watch_becoming_blocked_at_goal() {
    self notify(#"end_watch_becoming_blocked_at_goal");
    self endon(#"end_watch_becoming_blocked_at_goal");
    self endon(#"robot_stop");
    level endon(#"game_ended");
    while (isdefined(self.traversestartnode)) {
        self waittill(#"traverse_end");
    }
    self.watch_becoming_blocked_at_goal_established = 1;
    startpos = self.origin;
    atsameposcount = 0;
    iterationcount = 0;
    while (self.moving) {
        wait 0.1;
        if (distancesquared(startpos, self.origin) < 1) {
            atsameposcount++;
        }
        if (atsameposcount >= 2) {
            self.goaljustblocked = 1;
            self notify(#"goal_blocked");
        }
        iterationcount++;
        if (iterationcount >= 3) {
            break;
        }
    }
    self.watch_becoming_blocked_at_goal_established = 0;
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xb7570387, Offset: 0x4968
// Size: 0x12e
function stop_robot() {
    if (!self.moving) {
        return;
    }
    if (isdefined(self.traversestartnode)) {
        self thread check_robot_on_travesal_end();
        return;
    }
    self.moving = 0;
    self.mostrecentclosestpathpointgoal = undefined;
    self.watch_becoming_blocked_at_goal_established = 0;
    velocity = self getvelocity();
    deltapos = velocity * 0.05;
    stopgoal = isdefined(getclosestpointonnavmesh(self.origin + deltapos, 48, 15)) ? getclosestpointonnavmesh(self.origin + deltapos, 48, 15) : self.origin;
    self setgoal(stopgoal, 0);
    self notify(#"robot_stopped");
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x8f0328b6, Offset: 0x4aa0
// Size: 0xe4
function check_robot_on_travesal_end() {
    self notify(#"check_robot_on_travesal_end_singleton");
    self endon(#"check_robot_on_travesal_end_singleton");
    self endon(#"death");
    self waittill(#"traverse_end");
    numowners = isdefined(level.moveobject.numtouching[level.moveobject.ownerteam]) ? level.moveobject.numtouching[level.moveobject.ownerteam] : 0;
    if (numowners < level.moveplayers) {
        self stop_robot();
        return;
    }
    self move_robot();
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x5c90be6e, Offset: 0x4b90
// Size: 0x78
function update_stop_position() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"traverse_end");
        if (!self.moving) {
            self setgoal(self.origin, 1);
        }
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x9b916165, Offset: 0x4c10
// Size: 0x288
function robot_wait_next_point() {
    self endon(#"robot_stopped");
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"goal", #"goal_blocked");
        if (!isdefined(self.watch_becoming_blocked_at_goal_established) || self.watch_becoming_blocked_at_goal_established == 0) {
            self thread watch_becoming_blocked_at_goal();
        }
        if (distancesquared(self.origin, get_current_goal()) < 24 * 24) {
            self.pathindex += isdefined(self.immediategoaloverride) ? 0 : 1;
            self.immediategoaloverride = undefined;
        }
        while (self.pathindex < self.patharray.size && distancesquared(self.origin, self.patharray[self.pathindex]) < (48 + 1) * (48 + 1)) {
            self.pathindex++;
        }
        if (self.pathindex >= self.patharray.size) {
            self.pathindex = undefined;
            self stop_robot();
            return;
        }
        if (self.pathindex + 1 >= self.patharray.size) {
            otherteam = util::getotherteam(self.team);
            globallogic_audio::leader_dialog("sfgRobotCloseAttacker", self.team, undefined, "robot");
            globallogic_audio::leader_dialog("sfgRobotCloseDefender", otherteam, undefined, "robot");
        }
        if (self check_blocked_goal_and_kill()) {
            self stop_robot();
        }
        set_goal_to_point_on_path();
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xb1de7f3d, Offset: 0x4ea0
// Size: 0x82
function get_closest_point_on_nav_mesh_for_current_goal() {
    immediategoal = get_current_goal();
    closestpathpoint = getclosestpointonnavmesh(immediategoal, 48, 15);
    if (!isdefined(closestpathpoint)) {
        closestpathpoint = getclosestpointonnavmesh(immediategoal, 96, 15);
    }
    return isdefined(closestpathpoint) ? closestpathpoint : immediategoal;
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x21718157, Offset: 0x4f30
// Size: 0x104
function get_closest_point_on_nav_mesh(point) {
    closestpathpoint = getclosestpointonnavmesh(point, 48, 15);
    if (!isdefined(closestpathpoint)) {
        closestpathpoint = getclosestpointonnavmesh(point, 96, 15);
    }
    if (!isdefined(closestpathpoint)) {
        itercount = 0;
        lowerpoint = point - (0, 0, 36);
        while (!isdefined(closestpathpoint) && itercount < 5) {
            closestpathpoint = getclosestpointonnavmesh(lowerpoint, 48, 15);
            lowerpoint -= (0, 0, 36);
            itercount++;
        }
    }
    return isdefined(closestpathpoint) ? closestpathpoint : point;
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x83c5091f, Offset: 0x5040
// Size: 0x144
function set_goal_to_point_on_path(recursioncount = 0) {
    self.goaljustblocked = 0;
    closestpathpoint = self get_closest_point_on_nav_mesh_for_current_goal();
    if (isdefined(closestpathpoint)) {
        if (!isdefined(self.mostrecentclosestpathpointgoal) || distancesquared(closestpathpoint, self.mostrecentclosestpathpointgoal) > 1) {
            self setgoal(closestpathpoint, 0, 24);
            self thread watch_goal_becoming_blocked(closestpathpoint);
            self.mostrecentclosestpathpointgoal = closestpathpoint;
        }
    } else if (recursioncount < 3) {
        self find_immediate_goal();
        self set_goal_to_point_on_path(recursioncount + 1);
    } else {
        self stop_robot();
    }
    /#
        debug_draw_current_robot_goal(closestpathpoint);
    #/
}

// Namespace escort/escort
// Params 2, eflags: 0x0
// Checksum 0x24e78f31, Offset: 0x5190
// Size: 0xd8
function is_path_distance_to_goal_too_long(&patharray, toolongthreshold) {
    /#
        debug_draw_approximate_robot_path_to_goal(patharray);
    #/
    if (toolongthreshold < 20) {
        toolongthreshold = 20;
    }
    goaldistance = 0;
    lastindextocheck = patharray.size - 1;
    for (i = 0; i < lastindextocheck; i++) {
        goaldistance += distance(patharray[i], patharray[i + 1]);
        if (goaldistance >= toolongthreshold) {
            return true;
        }
    }
    return false;
}

/#

    // Namespace escort/escort
    // Params 0, eflags: 0x0
    // Checksum 0xa818975e, Offset: 0x5270
    // Size: 0x250
    function debug_reset_robot_to_start() {
        level endon(#"game_ended");
        while (true) {
            if ((isdefined(getdvarint(#"scr_escort_robot_reset_path", 0)) ? getdvarint(#"scr_escort_robot_reset_path", 0) : 0) > 0) {
                if (isdefined(level.robot)) {
                    pathindex = (isdefined(getdvarint(#"scr_escort_robot_reset_path", 0)) ? getdvarint(#"scr_escort_robot_reset_path", 0) : 0) - 1;
                    pathpoint = level.robot.patharray[pathindex];
                    robotangles = (0, 0, 0);
                    if (pathindex < level.robot.patharray.size - 1) {
                        nextpoint = level.robot.patharray[pathindex + 1];
                        robotangles = vectortoangles(nextpoint - pathpoint);
                    }
                    level.robot forceteleport(pathpoint, robotangles);
                    level.robot.pathindex = pathindex;
                    level.robot.immediategoaloverride = undefined;
                    while (isdefined(self.traversestartnode)) {
                        waitframe(1);
                    }
                    level.robot stop_robot();
                    level.robot setgoal(level.robot.origin, 0);
                }
                setdvar(#"scr_escort_robot_reset_path", 0);
            }
            wait 0.5;
        }
    }

#/

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x1177d480, Offset: 0x54c8
// Size: 0x26c
function explode_robot() {
    self clientfield::set("escort_robot_burn", 1);
    clientfield::set("robot_mind_control_explosion", 1);
    self thread wait_robot_corpse();
    if (randomint(100) >= 50) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    gibserverutils::gibhead(self);
    velocity = self getvelocity() * 0.125;
    self startragdoll();
    self launchragdoll((velocity[0] + randomfloatrange(-20, 20), velocity[1] + randomfloatrange(-20, 20), randomfloatrange(60, 80)), "j_mainroot");
    playfxontag("weapon/fx_c4_exp_metal", self, "tag_origin");
    if (target_istarget(self)) {
        target_remove(self);
    }
    physicsexplosionsphere(self.origin, 200, 1, 1, 1, 1);
    radiusdamage(self.origin, 200, 1, 1, undefined, "MOD_EXPLOSIVE");
    playrumbleonposition("grenade_rumble", self.origin);
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x35787f2f, Offset: 0x5740
// Size: 0x5c
function wait_robot_corpse() {
    archetype = self.archetype;
    waitresult = self waittill(#"actor_corpse");
    waitresult.corpse clientfield::set("escort_robot_burn", 1);
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xac2e4da, Offset: 0x57a8
// Size: 0x78
function robot_move_chatter() {
    level endon(#"game_ended");
    while (true) {
        if (self.moving) {
            self playsoundontag("vox_robot_chatter", "J_Head");
        }
        wait randomfloatrange(1.5, 2.5);
    }
}

// Namespace escort/escort
// Params 2, eflags: 0x0
// Checksum 0x56eda183, Offset: 0x5828
// Size: 0x1fe
function setup_move_object(robot, triggername) {
    trigger = getent(triggername, "targetname");
    useobj = gameobjects::create_use_object(game.attackers, trigger, [], (0, 0, 0), #"escort_robot");
    useobj gameobjects::set_objective_entity(robot);
    useobj gameobjects::allow_use(#"none");
    useobj gameobjects::set_visible_team(#"any");
    useobj gameobjects::set_use_time(0);
    trigger enablelinkto();
    trigger linkto(robot);
    useobj.onuse = &on_use_robot_move;
    useobj.onupdateuserate = &on_update_use_rate_robot_move;
    useobj.robot = robot;
    if (isdefined(level.levelescortdisable)) {
        if (!isdefined(useobj.exclusions)) {
            useobj.exclusions = [];
        }
        foreach (trigger in level.levelescortdisable) {
            useobj.exclusions[useobj.exclusions.size] = trigger;
        }
    }
    return useobj;
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x37e7bba7, Offset: 0x5a30
// Size: 0x9c
function on_use_robot_move(player) {
    level.usestartspawns = 0;
    if (self.robot.moving || !self.robot.active || self.numtouching[self.ownerteam] < level.moveplayers) {
        return;
    }
    self thread track_escorting_players();
    self.robot move_robot();
}

// Namespace escort/escort
// Params 3, eflags: 0x0
// Checksum 0x8c0daeb1, Offset: 0x5ad8
// Size: 0x64
function on_update_use_rate_robot_move(team, progress, change) {
    numowners = self.numtouching[self.ownerteam];
    if (numowners < level.moveplayers) {
        self.robot stop_robot();
    }
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0xff707058, Offset: 0x5b48
// Size: 0x102
function track_escorting_players() {
    level endon(#"game_ended");
    self.robot endon(#"robot_stopped");
    while (true) {
        foreach (touch in self.touchlist[self.team]) {
            if (!(isdefined(touch.player.escortingrobot) && touch.player.escortingrobot)) {
                self thread track_escort_time(touch.player);
            }
        }
        waitframe(1);
    }
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x8513860a, Offset: 0x5c58
// Size: 0x254
function track_escort_time(player) {
    level endon(#"game_ended");
    player endon(#"death");
    self.robot endon(#"robot_shutdown");
    player.escortingrobot = 1;
    player recordgameevent("player_escort_start");
    self thread wait_escort_death(player);
    self thread wait_escort_shutdown(player);
    consecutiveescorts = 0;
    while (true) {
        wait 1;
        touching = 0;
        foreach (touch in self.touchlist[self.team]) {
            if (touch.player == player) {
                touching = 1;
                break;
            }
        }
        if (!touching) {
            break;
        }
        if (isdefined(player.pers[#"escorts"])) {
            player.pers[#"escorts"]++;
            player.escorts = player.pers[#"escorts"];
        }
        player stats::function_2dabbec7(#"escorts", 1);
        consecutiveescorts++;
        if (consecutiveescorts % 3 == 0) {
            scoreevents::processscoreevent(#"escort_robot_escort", player, undefined, undefined);
        }
    }
    player player_stop_escort();
}

// Namespace escort/escort
// Params 0, eflags: 0x0
// Checksum 0x6665a758, Offset: 0x5eb8
// Size: 0x3e
function player_stop_escort() {
    self.escortingrobot = 0;
    self recordgameevent("player_escort_stop");
    self notify(#"escorting_stopped");
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x9ccdcfa9, Offset: 0x5f00
// Size: 0x6c
function wait_escort_death(player) {
    level endon(#"game_ended");
    player endon(#"escorting_stopped");
    player waittill(#"death");
    player thread player_stop_escort();
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x4b393084, Offset: 0x5f78
// Size: 0x6c
function wait_escort_shutdown(player) {
    level endon(#"game_ended");
    player endon(#"escorting_stopped");
    self.robot waittill(#"robot_shutdown");
    player thread player_stop_escort();
}

// Namespace escort/escort
// Params 2, eflags: 0x0
// Checksum 0x1034ecaf, Offset: 0x5ff0
// Size: 0x5c
function setup_reboot_object(robot, triggername) {
    trigger = getent(triggername, "targetname");
    if (isdefined(trigger)) {
        trigger delete();
    }
}

// Namespace escort/escort
// Params 2, eflags: 0x0
// Checksum 0x5e9cf508, Offset: 0x6058
// Size: 0x1b8
function setup_goal_object(robot, triggername) {
    trigger = getent(triggername, "targetname");
    if (isdefined(game.var_ef2b23fe)) {
        trigger = spawn("trigger_radius_new", game.var_ef2b23fe);
        trigger.radius = 120;
    }
    useobj = gameobjects::create_use_object(game.defenders, trigger, [], (0, 0, 0), #"escort_goal");
    useobj gameobjects::set_visible_team(#"any");
    useobj gameobjects::allow_use(#"none");
    useobj gameobjects::set_use_time(0);
    fwd = (0, 0, 1);
    right = (0, -1, 0);
    useobj.fx = spawnfx("ui/fx_dom_marker_team_r120", trigger.origin, fwd, right);
    useobj.fx.team = game.defenders;
    triggerfx(useobj.fx, 0.001);
    useobj thread watch_robot_enter(robot);
    return useobj;
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x747f85, Offset: 0x6218
// Size: 0x2c8
function watch_robot_enter(robot) {
    robot endon(#"death");
    level endon(#"game_ended");
    radiussq = self.trigger.radius * self.trigger.radius;
    while (true) {
        if (robot.moving === 1 && distance2dsquared(self.trigger.origin, robot.origin) < radiussq) {
            level.moveplayers = 0;
            robot.overrideactordamage = &robot_damage_none;
            if (target_istarget(self)) {
                target_remove(self);
            }
            attackers = game.attackers;
            self.fx.team = attackers;
            foreach (player in level.aliveplayers[attackers]) {
                if (isdefined(player.escortingrobot) && player.escortingrobot) {
                    scoreevents::processscoreevent(#"escort_robot_escort_goal", player, undefined, undefined);
                }
            }
            level.robot recordgameeventnonplayer("robot_reached_objective");
            setgameendtime(0);
            robot val::set(#"escort_robot", "ignoreme", 1);
            robot thread explode_robot_after_wait(1);
            globallogic_score::giveteamscoreforobjective(attackers, 1);
            round::set_winner(attackers);
            level thread globallogic::end_round(1);
            return;
        }
        waitframe(1);
    }
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x4d2ef11f, Offset: 0x64e8
// Size: 0x3c
function explode_robot_after_wait(wait_time) {
    robot = self;
    wait wait_time;
    if (isdefined(robot)) {
        robot explode_robot();
    }
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0x7a1a748d, Offset: 0x6530
// Size: 0x40c
function kill_anything_blocking_goal(goal) {
    self endon(#"end_kill_anything");
    self.disablefinalkillcam = 1;
    dirtogoal = vectornormalize(goal - self.origin);
    atleastonedestroyed = 0;
    bestcandidate = undefined;
    bestcandidatedot = -1e+09;
    /#
        debug_draw_blocked_path_kill_radius(self.origin, 108);
    #/
    entities = getdamageableentarray(self.origin, 108);
    foreach (entity in entities) {
        if (isplayer(entity)) {
            continue;
        }
        if (entity == self) {
            continue;
        }
        if (entity.classname == "grenade") {
            continue;
        }
        if (!isalive(entity)) {
            continue;
        }
        entitydot = vectordot(dirtogoal, entity.origin - self.origin);
        if (entitydot > bestcandidatedot) {
            bestcandidate = entity;
            bestcandidatedot = entitydot;
        }
    }
    if (isdefined(bestcandidate)) {
        entity = bestcandidate;
        if (isdefined(entity.targetname)) {
            if (entity.targetname == "talon") {
                entity notify(#"death");
                return 1;
            }
        }
        if (isdefined(entity.helitype) && entity.helitype == "qrdrone") {
            watcher = entity.owner weaponobjects::getweaponobjectwatcher("qrdrone");
            watcher thread weaponobjects::waitanddetonate(entity, 0, undefined);
            return 1;
        }
        if (entity.classname == "auto_turret") {
            if (!isdefined(entity.damagedtodeath) || !entity.damagedtodeath) {
                entity util::domaxdamage(self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
            }
            return 1;
        }
        if (isvehicle(entity) && (!isdefined(entity.team) || entity.team != #"neutral")) {
            entity kill();
            return 1;
        }
        entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
        atleastonedestroyed = 1;
    }
    atleastonedestroyed = atleastonedestroyed || self destroy_supply_crate_blocking_goal(dirtogoal);
    return atleastonedestroyed;
}

// Namespace escort/escort
// Params 1, eflags: 0x0
// Checksum 0xaf587b5, Offset: 0x6948
// Size: 0x1b4
function destroy_supply_crate_blocking_goal(dirtogoal) {
    crates = getentarray("care_package", "script_noteworthy");
    bestcrate = undefined;
    bestcrateedot = -1e+09;
    foreach (crate in crates) {
        if (distancesquared(crate.origin, self.origin) > 108 * 108) {
            continue;
        }
        cratedot = vectordot(dirtogoal, crate.origin - self.origin);
        if (cratedot > bestcrateedot) {
            bestcrate = crate;
            bestcrateedot = cratedot;
        }
    }
    if (isdefined(bestcrate)) {
        playfx(level._supply_drop_explosion_fx, bestcrate.origin);
        playsoundatposition(#"wpn_grenade_explode", bestcrate.origin);
        wait 0.1;
        bestcrate supplydrop::cratedelete();
        return true;
    }
    return false;
}

