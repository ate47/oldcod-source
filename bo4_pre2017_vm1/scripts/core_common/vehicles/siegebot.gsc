#using scripts/core_common/ai/blackboard_vehicle;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/array_shared;
#using scripts/core_common/gameskill_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/vehicles/repulsor;
#using scripts/core_common/weapons/spike_charge_siegebot;

#namespace siegebot;

// Namespace siegebot/siegebot
// Params 0, eflags: 0x2
// Checksum 0xdbdc2ed, Offset: 0x5b0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("siegebot", &__init__, undefined, undefined);
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xa8073d55, Offset: 0x5f0
// Size: 0x54
function __init__() {
    vehicle::add_main_callback("siegebot", &siegebot_initialize);
    vehicle::add_main_callback("xbot", &siegebot_initialize);
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xcb6a352d, Offset: 0x650
// Size: 0x49c
function siegebot_initialize() {
    self useanimtree(#generic);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    vehicle::make_targetable(self, (0, 0, 0));
    self enableaimassist();
    self setneargoalnotifydist(40);
    self.fovcosine = 0.5;
    self.fovcosinebusy = 0.5;
    self.maxsightdistsqrd = 10000 * 10000;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 9999999;
    self.goalheight = 5000;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.overridevehicledamage = &siegebot_callback_damage;
    self turretsetontargettolerance(0, 5);
    if (self.scriptvehicletype == "xbot") {
        self.destructible_event_handler = &xbot_destructible_event_handler;
        self.isxbot = 1;
    }
    self siegebot_update_difficulty();
    self turretsetontargettolerance(0, self.settings.gunner_turret_on_target_range);
    self asmrequestsubstate("locomotion@movement");
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(0.5);
        self hidepart("tag_turret_canopy_animate");
        self hidepart("tag_turret_panel_01_d0");
        self hidepart("tag_turret_panel_02_d0");
        self hidepart("tag_turret_panel_03_d0");
        self hidepart("tag_turret_panel_04_d0");
        self hidepart("tag_turret_panel_05_d0");
    } else if (self.vehicletype == "zombietron_veh_siegebot") {
        self asmsetanimationrate(1.429);
    }
    self initjumpstruct();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    self.airfollowconfig = spawnstruct();
    self.airfollowconfig.distance = 130;
    self.airfollowconfig.numberofpoints = 8;
    self.airfollowconfig.pitchrange = 90;
    self.airfollowconfig.tag = "tag_turret_null";
    self.disableburndamage = 1;
    self thread vehicle_ai::target_hijackers();
    if (!sessionmodeismultiplayergame()) {
        defaultrole();
    }
}

// Namespace siegebot/siegebot
// Params 5, eflags: 0x0
// Checksum 0x42854e70, Offset: 0xaf8
// Size: 0xb8
function xbot_destructible_event_handler(event, param1, param2, param3, param4) {
    if (event == "broken") {
        message = param1;
        if (message == "left_arm_broken") {
            self.left_arm_disabled = 1;
            return;
        }
        if (message == "right_arm_broken") {
            self.right_arm_disabled = 1;
            return;
        }
        if (message == "javelin_broken") {
            self.javelin_disabled = 1;
        }
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x5e2a4804, Offset: 0xbb8
// Size: 0xb0
function siegebot_update_difficulty() {
    value = gameskill::get_general_difficulty_level();
    scale_up = mapfloat(0, 9, 0.8, 2, value);
    scale_down = mapfloat(0, 9, 1, 0.5, value);
    self.difficulty_scale_up = scale_up;
    self.difficulty_scale_down = scale_down;
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x6583c319, Offset: 0xc70
// Size: 0x2ac
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("driving").update_func = &siegebot_driving;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::get_state_callbacks("pain").update_func = &pain_update;
    self vehicle_ai::get_state_callbacks("emped").enter_func = &emped_enter;
    self vehicle_ai::get_state_callbacks("emped").update_func = &emped_update;
    self vehicle_ai::get_state_callbacks("emped").exit_func = &emped_exit;
    self vehicle_ai::get_state_callbacks("emped").reenter_func = &emped_reenter;
    self vehicle_ai::add_state("jump", &state_jump_enter, &state_jump_update, &state_jump_exit);
    vehicle_ai::add_utility_connection("combat", "jump", &state_jump_can_enter);
    vehicle_ai::add_utility_connection("jump", "combat");
    self vehicle_ai::add_state("unaware", undefined, &state_unaware_update, undefined);
    vehicle_ai::startinitialstate("combat");
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x29106de4, Offset: 0xf28
// Size: 0x33c
function state_death_update(params) {
    self endon(#"death");
    self endon(#"nodeath_thread");
    streamermodelhint(self.deathmodel, 6);
    death_type = vehicle_ai::get_death_type(params);
    if (!isdefined(death_type)) {
        params.death_type = "gibbed";
        death_type = params.death_type;
    }
    self clean_up_spawned();
    self setturretspinning(0);
    self stopmovementandsetbrake();
    badplace_box("", 0, self.origin, 50, "all");
    self vehicle::set_damage_fx_level(0);
    self playsound("veh_quadtank_sparks");
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    self.turretrotscale = 3;
    self turretsettargetangles(0, (0, 0, 0));
    self turretsettargetangles(1, (0, 0, 0));
    self turretsettargetangles(2, (0, 0, 0));
    self asmrequestsubstate("death@stationary");
    self waittill("model_swap");
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents();
    self vehicle_death::death_radius_damage();
    self waittill("bodyfall large");
    self radiusdamage(self.origin + (0, 0, 10), self.radius * 0.8, 150, 60, self, "MOD_CRUSH");
    vehicle_ai::waittill_asm_complete("death@stationary", 3);
    self disconnectpaths(1);
    self thread vehicle_death::cleanup();
    self vehicle_death::freewhensafe();
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0xc7f73036, Offset: 0x1270
// Size: 0x84
function siegebot_driving(params) {
    self thread siegebot_player_fireupdate();
    self thread siegebot_kill_on_tilting();
    self turretcleartarget(0);
    self cancelaimove();
    self clearvehgoalpos();
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xe2ab5bcd, Offset: 0x1300
// Size: 0x106
function siegebot_kill_on_tilting() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    tilecount = 0;
    while (true) {
        selfup = anglestoup(self.angles);
        worldup = (0, 0, 1);
        if (vectordot(selfup, worldup) < 0.64) {
            tilecount += 1;
        } else {
            tilecount = 0;
        }
        if (tilecount > 20) {
            driver = self getseatoccupant(0);
            self kill(self.origin);
        }
        waitframe(1);
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x8da90550, Offset: 0x1410
// Size: 0xe0
function siegebot_player_fireupdate() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    weapon = self seatgetweapon(2);
    firetime = weapon.firetime;
    driver = self getseatoccupant(0);
    self thread siegebot_player_aimupdate();
    while (true) {
        if (driver attackbuttonpressed()) {
            self fireweapon(2);
            wait firetime;
            continue;
        }
        waitframe(1);
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x639884b8, Offset: 0x14f8
// Size: 0x76
function siegebot_player_aimupdate() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        target = self turretgettarget(1);
        if (isdefined(target)) {
            self turretsettarget(2, target);
        }
        waitframe(1);
    }
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x1843a924, Offset: 0x1578
// Size: 0xb4
function emped_enter(params) {
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.notify_param[1];
    self.abnormal_status.inflictor = params.notify_param[2];
    self vehicle::toggle_emp_fx(1);
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x57410b9e, Offset: 0x1638
// Size: 0xf4
function emped_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self stopmovementandsetbrake();
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    asmstate = "damage_2@pain";
    self asmrequestsubstate(asmstate);
    self vehicle_ai::waittill_asm_complete(asmstate, 3);
    self setbrake(0);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x47436de1, Offset: 0x1738
// Size: 0xc
function emped_exit(params) {
    
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x5801d914, Offset: 0x1750
// Size: 0xe
function emped_reenter(params) {
    return false;
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x21474f4d, Offset: 0x1768
// Size: 0x1c
function pain_toggle(enabled) {
    self._enablepain = enabled;
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0xefaac5e6, Offset: 0x1790
// Size: 0x114
function pain_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self stopmovementandsetbrake();
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    if (self.newdamagelevel == 3) {
        asmstate = "damage_2@pain";
    } else {
        asmstate = "damage_1@pain";
    }
    self asmrequestsubstate(asmstate);
    self vehicle_ai::waittill_asm_complete(asmstate, 1.5);
    self setbrake(0);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0xc0cc5e17, Offset: 0x18b0
// Size: 0xb6
function state_unaware_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self turretsettargetangles(1, (0, 90, 0));
    self turretsettargetangles(2, (0, 90, 0));
    self thread movement_thread_unaware();
    while (true) {
        self vehicle_ai::evaluate_connections();
        wait 1;
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x17106734, Offset: 0x1970
// Size: 0x138
function movement_thread_unaware() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    while (true) {
        self.current_pathto_pos = self getnextmoveposition_unaware();
        foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
        if (foundpath) {
            locomotion_start();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify(#"near_goal");
            self cancelaimove();
            self clearvehgoalpos();
            scan();
        } else {
            wait 1;
        }
        waitframe(1);
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x4bc9367c, Offset: 0x1ab0
// Size: 0x48a
function getnextmoveposition_unaware() {
    if (self.goalforced) {
        return self.goalpos;
    }
    minsearchradius = 500;
    maxsearchradius = 1500;
    halfheight = 400;
    spacing = 80;
    queryresult = positionquery_source_navigation(self.origin, minsearchradius, maxsearchradius, halfheight, spacing, self, spacing);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    forward = anglestoforward(self.angles);
    foreach (point in queryresult.data) {
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = randomfloatrange(0, 30);
        #/
        point.score += randomfloatrange(0, 30);
        pointdirection = vectornormalize(point.origin - self.origin);
        factor = vectordot(pointdirection, forward);
        if (factor > 0.7) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = 600;
            #/
            point.score += 600;
            continue;
        }
        if (factor > 0) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = 0;
            #/
            point.score += 0;
            continue;
        }
        if (factor > -0.5) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = -600;
            #/
            point.score += -600;
            continue;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x2f>"] = -1200;
        #/
        point.score += -1200;
    }
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);
    if (queryresult.data.size == 0) {
        return self.origin;
    }
    return queryresult.data[0].origin;
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x6f1ba6c, Offset: 0x1f48
// Size: 0x4c
function clean_up_spawned() {
    if (isdefined(self.jump) && isdefined(self.jump.linkent)) {
        self.jump.linkent delete();
    }
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x4668f389, Offset: 0x1fa0
// Size: 0x3c
function clean_up_spawnedondeath(enttowatch) {
    self endon(#"death");
    enttowatch waittill("death");
    self delete();
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x2dc6b256, Offset: 0x1fe8
// Size: 0x13c
function initjumpstruct() {
    if (isdefined(self.jump)) {
        self unlink();
        self.jump.linkent delete();
        self.jump delete();
    }
    self.jump = spawnstruct();
    self.jump.linkent = spawn("script_origin", self.origin);
    self.jump.linkent thread clean_up_spawnedondeath(self);
    self.jump.in_air = 0;
    self.jump.highgrounds = struct::get_array("balcony_point");
    self.jump.groundpoints = struct::get_array("ground_point");
}

// Namespace siegebot/siegebot
// Params 3, eflags: 0x0
// Checksum 0xf30e7ce, Offset: 0x2130
// Size: 0x50
function state_jump_can_enter(from_state, to_state, connection) {
    if (isdefined(self.nojumping) && self.nojumping) {
        return false;
    }
    return self.vehicletype === "spawner_enemy_boss_siegebot_zombietron";
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x436fbd5f, Offset: 0x2188
// Size: 0x1e4
function state_jump_enter(params) {
    goal = params.jumpgoal;
    trace = physicstrace(goal + (0, 0, 500), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(trace["<dev string:x3d>"], 60000, (0, 1, 0));
        #/
        /#
            line(goal, trace["<dev string:x3d>"], (0, 1, 0), 1, 0, 60000);
        #/
    }
    if (trace["fraction"] < 1) {
        goal = trace["position"];
    }
    self.jump.goal = goal;
    params.scaleforward = 40;
    params.gravityforce = (0, 0, -6);
    params.upbyheight = 50;
    params.landingstate = "land@jump";
    self pain_toggle(0);
    self stopmovementandsetbrake();
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x79771457, Offset: 0x2378
// Size: 0xc54
function state_jump_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    goal = self.jump.goal;
    self face_target(goal);
    self.jump.linkent.origin = self.origin;
    self.jump.linkent.angles = self.angles;
    waitframe(1);
    self linkto(self.jump.linkent);
    self.jump.in_air = 1;
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(goal + (0, 0, 100), 60000, (0, 1, 0));
        #/
        /#
            line(goal, goal + (0, 0, 100), (0, 1, 0), 1, 0, 60000);
        #/
    }
    totaldistance = distance2d(goal, self.jump.linkent.origin);
    forward = (((goal - self.jump.linkent.origin) / totaldistance)[0], ((goal - self.jump.linkent.origin) / totaldistance)[1], 0);
    upbydistance = mapfloat(500, 2000, 46, 52, totaldistance);
    antigravitybydistance = 0;
    initvelocityup = (0, 0, 1) * (upbydistance + params.upbyheight);
    initvelocityforward = forward * params.scaleforward * mapfloat(500, 2000, 0.8, 1, totaldistance);
    velocity = initvelocityup + initvelocityforward;
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    self asmrequestsubstate("inair@jump");
    self waittill("engine_startup");
    self vehicle::impact_fx(self.settings.startupfx1);
    self waittill("leave_ground");
    self vehicle::impact_fx(self.settings.takeofffx1);
    while (true) {
        distancetogoal = distance2d(self.jump.linkent.origin, goal);
        antigravityscaleup = 1;
        antigravityscale = 1;
        antigravity = (0, 0, 0);
        if (false) {
            /#
                line(self.jump.linkent.origin, self.jump.linkent.origin + antigravity, (0, 1, 0), 1, 0, 60000);
            #/
        }
        velocityforwardscale = mapfloat(self.radius * 1, self.radius * 4, 0.2, 1, distancetogoal);
        velocityforward = initvelocityforward * velocityforwardscale;
        if (false) {
            /#
                line(self.jump.linkent.origin, self.jump.linkent.origin + velocityforward, (0, 1, 0), 1, 0, 60000);
            #/
        }
        oldverticlespeed = velocity[2];
        velocity = (0, 0, velocity[2]);
        velocity += velocityforward + params.gravityforce + antigravity;
        if (oldverticlespeed > 0 && velocity[2] < 0) {
            self asmrequestsubstate("fall@jump");
        }
        if (velocity[2] < 0 && self.jump.linkent.origin[2] + velocity[2] < goal[2]) {
            break;
        }
        heightthreshold = goal[2] + 110;
        oldheight = self.jump.linkent.origin[2];
        self.jump.linkent.origin += velocity;
        if (oldverticlespeed > 0 && (oldheight > heightthreshold || self.jump.linkent.origin[2] < heightthreshold && velocity[2] < 0)) {
            self notify(#"start_landing");
            self asmrequestsubstate(params.landingstate);
        }
        if (false) {
            /#
                debugstar(self.jump.linkent.origin, 60000, (1, 0, 0));
            #/
        }
        waitframe(1);
    }
    self.jump.linkent.origin = (self.jump.linkent.origin[0], self.jump.linkent.origin[1], 0) + (0, 0, goal[2]);
    self notify(#"land_crush");
    foreach (player in level.players) {
        player._takedamage_old = player.takedamage;
        player.takedamage = 0;
    }
    self radiusdamage(self.origin + (0, 0, 15), self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE");
    foreach (player in level.players) {
        player.takedamage = player._takedamage_old;
        player._takedamage_old = undefined;
        if (distance2dsquared(self.origin, player.origin) < 200 * 200) {
            direction = ((player.origin - self.origin)[0], (player.origin - self.origin)[1], 0);
            if (abs(direction[0]) < 0.01 && abs(direction[1]) < 0.01) {
                direction = (randomfloatrange(1, 2), randomfloatrange(1, 2), 0);
            }
            direction = vectornormalize(direction);
            strength = 700;
            player setvelocity(player getvelocity() + direction * strength);
            if (player.health > 80) {
                player dodamage(player.health - 70, self.origin, self);
            }
        }
    }
    self vehicle::impact_fx(self.settings.landingfx1);
    self stopmovementandsetbrake();
    wait 0.3;
    self unlink();
    waitframe(1);
    self.jump.in_air = 0;
    self notify(#"jump_finished");
    vehicle_ai::cooldown("jump", 7);
    self vehicle_ai::waittill_asm_complete(params.landingstate, 3);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0xb2ee66bd, Offset: 0x2fd8
// Size: 0xc
function state_jump_exit(params) {
    
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0xfc60c7a0, Offset: 0x2ff0
// Size: 0xb4
function state_combat_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self thread movement_thread();
    self thread attack_thread_machinegun();
    self thread attack_thread_rocket();
    if (isdefined(self.isxbot) && self.isxbot) {
        self thread attack_thread_main();
        self thread attack_thread_javelin();
    }
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0x4c65e8d0, Offset: 0x30b0
// Size: 0x3c
function state_combat_exit(params) {
    self turretcleartarget(0);
    self setturretspinning(0);
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xf1173ae2, Offset: 0x30f8
// Size: 0x5c
function locomotion_start() {
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(0.5);
    }
    self asmrequestsubstate("locomotion@movement");
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xcb733ee4, Offset: 0x3160
// Size: 0x48a
function getnextmoveposition_tactical() {
    if (self.goalforced) {
        return self.goalpos;
    }
    maxsearchradius = 800;
    halfheight = 400;
    innerspacing = 50;
    outerspacing = 60;
    queryresult = positionquery_source_navigation(self.origin, 0, maxsearchradius, halfheight, innerspacing, self, outerspacing);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    if (isdefined(self.enemy)) {
        positionquery_filter_sight(queryresult, self.enemy.origin, self geteye() - self.origin, self, 0, self.enemy);
        self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    }
    foreach (point in queryresult.data) {
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = randomfloatrange(0, 30);
        #/
        point.score += randomfloatrange(0, 30);
        if (point.disttoorigin2d < 120) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x46>"] = (120 - point.disttoorigin2d) * -1.5;
            #/
            point.score += (120 - point.disttoorigin2d) * -1.5;
        }
        if (isdefined(self.enemy)) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x55>"] = point.distawayfromengagementarea * -1;
            #/
            point.score += point.distawayfromengagementarea * -1;
            if (!point.visibility) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x64>"] = -600;
                #/
                point.score += -600;
            }
        }
    }
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);
    if (queryresult.data.size == 0) {
        return self.origin;
    }
    return queryresult.data[0].origin;
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xacf49f11, Offset: 0x35f8
// Size: 0x4ac
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    canseeenemycount = 0;
    old_enemy = self.enemy;
    startpath = gettime();
    old_origin = self.origin;
    move_dist = 300;
    wait 1.5;
    while (true) {
        self setmaxspeedscale(1);
        self setmaxaccelerationscale(1);
        self setspeed(self.settings.defaultmovespeed);
        if (isdefined(self.enemy)) {
            selfdisttotarget = distance2d(self.origin, self.enemy.origin);
            farengagementdist = self.settings.engagementdistmax + 150;
            closeengagementdist = self.settings.engagementdistmin - 150;
            if (self cansee(self.enemy)) {
                self vehlookat(self.enemy);
                self turretsettarget(0, self.enemy);
                if (selfdisttotarget < farengagementdist && selfdisttotarget > closeengagementdist) {
                    canseeenemycount++;
                    if (vehicle_ai::timesince(startpath) > 5 || canseeenemycount > 3 && distance2dsquared(old_origin, self.origin) > move_dist * move_dist) {
                        self notify(#"near_goal");
                    }
                } else {
                    self setmaxspeedscale(2.5);
                    self setmaxaccelerationscale(3);
                    self setspeed(self.settings.defaultmovespeed * 2);
                }
            } else if (!self seerecently(self.enemy, 1.5) && self seerecently(self.enemy, 15) || selfdisttotarget > farengagementdist) {
                self setmaxspeedscale(1.8);
                self setmaxaccelerationscale(2);
                self setspeed(self.settings.defaultmovespeed * 1.5);
            }
        } else {
            canseeenemycount = 0;
        }
        if (isdefined(self.enemy)) {
            if (!isdefined(old_enemy)) {
                self notify(#"near_goal");
            } else if (self.enemy != old_enemy) {
                self notify(#"near_goal");
            }
            if (self cansee(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < 150 * 150 && distance2dsquared(old_origin, self.enemy.origin) > 151 * 151) {
                self notify(#"near_goal");
            }
        }
        wait 0.2;
    }
}

// Namespace siegebot/siegebot
// Params 2, eflags: 0x0
// Checksum 0xf2bba5b1, Offset: 0x3ab0
// Size: 0x8c
function weapon_doors_state(isopen, waittime) {
    if (!isdefined(waittime)) {
        waittime = 0;
    }
    self endon(#"death");
    self notify(#"weapon_doors_state");
    self endon(#"weapon_doors_state");
    if (isdefined(waittime) && waittime > 0) {
        wait waittime;
    }
    self vehicle::toggle_ambient_anim_group(1, isopen);
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xbe2e8726, Offset: 0x3b48
// Size: 0x348
function movement_thread() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    while (true) {
        self.current_pathto_pos = self getnextmoveposition_tactical();
        if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
            if (vehicle_ai::iscooldownready("jump")) {
                params = spawnstruct();
                params.jumpgoal = self.current_pathto_pos;
                locomotion_start();
                wait 0.5;
                self vehicle_ai::evaluate_connections(undefined, params);
                wait 0.5;
            }
        }
        foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
        if (foundpath) {
            if (isdefined(self.enemy) && self seerecently(self.enemy, 1)) {
                self vehlookat(self.enemy);
                self turretsettarget(0, self.enemy);
            }
            locomotion_start();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify(#"near_goal");
            self cancelaimove();
            self clearvehgoalpos();
            if (isdefined(self.enemy) && self seerecently(self.enemy, 2)) {
                if (isdefined(self.isxbot)) {
                    self vehlookat(self.enemy);
                    self turretsettarget(0, self.enemy);
                } else {
                    self face_target(self.enemy.origin);
                }
            }
        }
        wait 1;
        startadditionalwaiting = gettime();
        while (isdefined(self.enemy) && self cansee(self.enemy) && vehicle_ai::timesince(startadditionalwaiting) < 1.5) {
            wait 0.4;
        }
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x9154e822, Offset: 0x3e98
// Size: 0x94
function stopmovementandsetbrake() {
    self notify(#"end_movement_thread");
    self notify(#"near_goal");
    self cancelaimove();
    self clearvehgoalpos();
    self turretcleartarget(0);
    self vehclearlookat();
    self setbrake(1);
}

// Namespace siegebot/siegebot
// Params 2, eflags: 0x0
// Checksum 0xbed09b31, Offset: 0x3f38
// Size: 0x20c
function face_target(position, targetanglediff) {
    if (!isdefined(targetanglediff)) {
        targetanglediff = 30;
    }
    v_to_enemy = ((position - self.origin)[0], (position - self.origin)[1], 0);
    v_to_enemy = vectornormalize(v_to_enemy);
    goalangles = vectortoangles(v_to_enemy);
    anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
    if (anglediff <= targetanglediff) {
        return;
    }
    self vehlookat(position);
    self turretsettarget(0, position);
    self locomotion_start();
    angleadjustingstart = gettime();
    while (anglediff > targetanglediff && vehicle_ai::timesince(angleadjustingstart) < 4) {
        anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
        waitframe(1);
    }
    self clearvehgoalpos();
    self vehclearlookat();
    self turretcleartarget(0);
    self cancelaimove();
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xa75fff60, Offset: 0x4150
// Size: 0x224
function scan() {
    angles = self gettagangles("tag_barrel");
    angles = (0, angles[1], 0);
    rotate = 360;
    while (rotate > 0) {
        angles += (0, 30, 0);
        rotate -= 30;
        forward = anglestoforward(angles);
        aimpos = self.origin + forward * 1000;
        self turretsettarget(0, aimpos);
        self waittilltimeout(0.5, "turret_on_target");
        wait 0.1;
        if (isdefined(self.enemy) && self cansee(self.enemy)) {
            self turretsettarget(0, self.enemy);
            self vehlookat(self.enemy);
            self face_target(self.enemy);
            return;
        }
    }
    forward = anglestoforward(self.angles);
    aimpos = self.origin + forward * 1000;
    self turretsettarget(0, aimpos);
    self waittilltimeout(3, "turret_on_target");
    self turretcleartarget(0);
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x42e6f45e, Offset: 0x4380
// Size: 0x2b0
function attack_thread_machinegun() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"end_machinegun_attack_thread");
    self endon(#"end_machinegun_attack_thread");
    self.turretrotscale = 1 * self.difficulty_scale_up;
    spinning = 0;
    while (!(isdefined(self.left_arm_disabled) && self.left_arm_disabled)) {
        enemy = self.enemy;
        if (isdefined(self.isxbot) && self.isxbot) {
            enemy = self.gunner1enemy;
        }
        if (isdefined(enemy) && self cansee(enemy)) {
            self vehlookat(enemy);
            self turretsettarget(0, enemy);
            if (!spinning) {
                spinning = 1;
                self setturretspinning(1);
                wait 0.5;
                continue;
            }
            self turretsettarget(1, enemy, (0, 0, 0));
            self turretsettarget(2, enemy, (0, 0, 0));
            self vehicle_ai::fire_for_time(randomfloatrange(0.75, 1.5) * self.difficulty_scale_up, 1);
            if (isdefined(enemy) && isai(enemy)) {
                wait randomfloatrange(0.1, 0.2);
            } else {
                wait randomfloatrange(0.2, 0.3) * self.difficulty_scale_down;
            }
            continue;
        }
        spinning = 0;
        self setturretspinning(0);
        self turretcleartarget(1);
        self turretcleartarget(2);
        wait 0.4;
    }
}

// Namespace siegebot/siegebot
// Params 1, eflags: 0x0
// Checksum 0xaed871f1, Offset: 0x4638
// Size: 0xac
function attack_rocket(target) {
    if (isdefined(target)) {
        self turretsettarget(0, target);
        self turretsettarget(3, target, (0, 0, -10));
        self waittilltimeout(1, "turret_on_target");
        self fireweapon(2, target, (0, 0, -10));
        self turretcleartarget(2);
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0x7c90d5c8, Offset: 0x46f0
// Size: 0x258
function attack_thread_rocket() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"end_rocket_attack_thread");
    self endon(#"end_rocket_attack_thread");
    vehicle_ai::cooldown("rocket", 3);
    while (!(isdefined(self.right_arm_disabled) && self.right_arm_disabled)) {
        if (isdefined(self.gunner2enemy) && self seerecently(self.gunner2enemy, 3) && vehicle_ai::iscooldownready("rocket", 1.5)) {
            self turretsettarget(1, self.gunner2enemy, (0, 0, 0));
            self turretsettarget(3, self.gunner2enemy, (0, 0, -10));
            self thread weapon_doors_state(1);
            wait 1.5;
            if (isdefined(self.gunner2enemy) && self seerecently(self.gunner2enemy, 1)) {
                vehicle_ai::cooldown("rocket", 5);
                attack_rocket(self.gunner2enemy);
                wait 1;
                if (isdefined(self.gunner2enemy)) {
                    attack_rocket(self.gunner2enemy);
                }
                self thread weapon_doors_state(0, 1);
            } else {
                self thread weapon_doors_state(0);
            }
            continue;
        }
        self turretcleartarget(1);
        self turretcleartarget(2);
        wait 0.4;
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xd899166c, Offset: 0x4950
// Size: 0xc0
function attack_thread_main() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    while (true) {
        if (isdefined(self.enemy) && self cansee(self.enemy) && self.turretontarget) {
            self vehicle_ai::fire_for_time(randomfloatrange(0.75, 1.5), 0);
        }
        wait randomfloatrange(0.5, 1.5);
    }
}

// Namespace siegebot/siegebot
// Params 0, eflags: 0x0
// Checksum 0xf50f520a, Offset: 0x4a18
// Size: 0x298
function attack_thread_javelin() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    while (!(isdefined(self.javelin_disabled) && self.javelin_disabled)) {
        if (isdefined(self.enemy) && vehicle_ai::iscooldownready("javelin_rocket_launcher")) {
            fired = 0;
            for (i = 0; i < 3 && isdefined(self.enemy); i++) {
                enemy = self.enemy;
                if (i == 1 && isdefined(self.gunner3enemy)) {
                    enemy = self.gunner3enemy;
                    if (enemy == self.enemy) {
                        continue;
                    }
                }
                if (i == 2 && isdefined(self.gunner2enemy)) {
                    enemy = self.gunner2enemy;
                    if (enemy == self.enemy) {
                        continue;
                    }
                }
                if (distance2dsquared(self.origin, enemy.origin) < 300 * 300) {
                    continue;
                }
                self thread vehicle_ai::javelin_losetargetatrighttime(enemy, 2);
                self fireweapon(3, enemy);
                fired = 1;
                wait 0.8;
            }
            if (fired) {
                cooldown = 15;
                if (self.scriptvehicletype == "xbot") {
                    if (isdefined(self.left_arm_disabled) && self.left_arm_disabled) {
                        cooldown -= 5;
                    }
                    if (isdefined(self.right_arm_disabled) && self.right_arm_disabled) {
                        cooldown -= 5;
                    }
                }
                vehicle_ai::cooldown("javelin_rocket_launcher", cooldown);
            }
        }
        wait 0.3;
    }
}

// Namespace siegebot/siegebot
// Params 15, eflags: 0x0
// Checksum 0x28f4164a, Offset: 0x4cb8
// Size: 0x2c0
function siegebot_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    num_players = getplayers().size;
    maxdamage = self.healthdefault * (0.4 - 0.02 * num_players);
    if (smeansofdeath !== "MOD_UNKNOWN" && idamage > maxdamage) {
        idamage = maxdamage;
    }
    if (vehicle_ai::should_emp(self, weapon, smeansofdeath, einflictor, eattacker)) {
        minempdowntime = 0.8 * self.settings.empdowntime;
        maxempdowntime = 1.2 * self.settings.empdowntime;
        self notify(#"emped", {#param0:randomfloatrange(minempdowntime, maxempdowntime), #param1:eattacker, #param2:einflictor});
    }
    if (!isdefined(self.damagelevel)) {
        self.damagelevel = 0;
        self.newdamagelevel = self.damagelevel;
    }
    newdamagelevel = vehicle::should_update_damage_fx_level(self.health, idamage, self.healthdefault);
    if (newdamagelevel > self.damagelevel) {
        self.newdamagelevel = newdamagelevel;
    }
    if (self.newdamagelevel > self.damagelevel) {
        self.damagelevel = self.newdamagelevel;
        driver = self getseatoccupant(0);
        if (!isdefined(driver)) {
            self notify(#"pain");
        }
        vehicle::set_damage_fx_level(self.damagelevel);
    }
    return idamage;
}

