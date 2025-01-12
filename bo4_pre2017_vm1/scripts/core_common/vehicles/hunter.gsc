#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/gameskill_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/vehicles/attack_drone;

#namespace hunter;

// Namespace hunter/hunter
// Params 0, eflags: 0x2
// Checksum 0xcf8d6bf, Offset: 0x648
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("hunter", &__init__, undefined, undefined);
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x54f494a6, Offset: 0x688
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("hunter", &function_4a1f0e84);
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x81dc3105, Offset: 0x6c0
// Size: 0x442
function function_49e9f3ca() {
    self.var_3b6698a2 = [];
    if (false) {
        if (!isdefined(self.var_3b6698a2)) {
            self.var_3b6698a2 = [];
        } else if (!isarray(self.var_3b6698a2)) {
            self.var_3b6698a2 = array(self.var_3b6698a2);
        }
        self.var_3b6698a2[self.var_3b6698a2.size] = "tag_target_l";
        if (!isdefined(self.var_3b6698a2)) {
            self.var_3b6698a2 = [];
        } else if (!isarray(self.var_3b6698a2)) {
            self.var_3b6698a2 = array(self.var_3b6698a2);
        }
        self.var_3b6698a2[self.var_3b6698a2.size] = "tag_target_r";
    }
    self.var_6946ca8d = [];
    if (false) {
        if (!isdefined(self.var_6946ca8d)) {
            self.var_6946ca8d = [];
        } else if (!isarray(self.var_6946ca8d)) {
            self.var_6946ca8d = array(self.var_6946ca8d);
        }
        self.var_6946ca8d[self.var_6946ca8d.size] = "tag_fan_base_l";
        if (!isdefined(self.var_6946ca8d)) {
            self.var_6946ca8d = [];
        } else if (!isarray(self.var_6946ca8d)) {
            self.var_6946ca8d = array(self.var_6946ca8d);
        }
        self.var_6946ca8d[self.var_6946ca8d.size] = "tag_fan_base_r";
    }
    self.missiletags = [];
    if (!isdefined(self.missiletags)) {
        self.missiletags = [];
    } else if (!isarray(self.missiletags)) {
        self.missiletags = array(self.missiletags);
    }
    self.missiletags[self.missiletags.size] = "tag_rocket1";
    if (!isdefined(self.missiletags)) {
        self.missiletags = [];
    } else if (!isarray(self.missiletags)) {
        self.missiletags = array(self.missiletags);
    }
    self.missiletags[self.missiletags.size] = "tag_rocket2";
    self.var_bd6cae75 = [];
    if (false) {
        if (!isdefined(self.var_bd6cae75)) {
            self.var_bd6cae75 = [];
        } else if (!isarray(self.var_bd6cae75)) {
            self.var_bd6cae75 = array(self.var_bd6cae75);
        }
        self.var_bd6cae75[self.var_bd6cae75.size] = "tag_drone_attach_l";
        if (!isdefined(self.var_bd6cae75)) {
            self.var_bd6cae75 = [];
        } else if (!isarray(self.var_bd6cae75)) {
            self.var_bd6cae75 = array(self.var_bd6cae75);
        }
        self.var_bd6cae75[self.var_bd6cae75.size] = "tag_drone_attach_r";
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xc87074c5, Offset: 0xb10
// Size: 0x1c0
function function_f52e9192() {
    self.var_6cfdd1e3 = [];
    if (false) {
        foreach (var_38a935c3 in self.var_bd6cae75) {
            origin = self gettagorigin(var_38a935c3);
            angles = self gettagangles(var_38a935c3);
            drone = spawnvehicle("spawner_bo3_attack_drone_enemy", origin, angles);
            drone.owner = self;
            drone.attachtag = var_38a935c3;
            drone.team = self.team;
            if (!isdefined(self.var_6cfdd1e3)) {
                self.var_6cfdd1e3 = [];
            } else if (!isarray(self.var_6cfdd1e3)) {
                self.var_6cfdd1e3 = array(self.var_6cfdd1e3);
            }
            self.var_6cfdd1e3[self.var_6cfdd1e3.size] = drone;
        }
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xe3f9f518, Offset: 0xcd8
// Size: 0x2d4
function function_4a1f0e84() {
    self endon(#"death");
    self useanimtree(#generic);
    vehicle::make_targetable(self, (0, 0, 0));
    ai::createinterfaceforentity(self);
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self setneargoalnotifydist(50);
    self sethoverparams(15, 100, 40);
    self.flyheight = getdvarfloat("g_quadrotorFlyHeight");
    self.fovcosine = 0;
    self.fovcosinebusy = 0.574;
    self.vehaircraftcollisionenabled = 1;
    self.original_vehicle_type = self.vehicletype;
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 999999;
    self.goalheight = 999999;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self function_49e9f3ca();
    self.overridevehicledamage = &function_8fff56d4;
    self thread vehicle_ai::nudge_collision();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    self turret::_init_turret(1);
    self turret::_init_turret(2);
    self turret::set_burst_parameters(1, 2, 1, 2, 1);
    self turret::set_burst_parameters(1, 2, 1, 2, 2);
    self side_turrets_forward();
    self pathvariableoffset((10, 10, -30), 1);
    defaultrole();
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xf0318f2f, Offset: 0xfb8
// Size: 0x41c
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role();
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("driving").enter_func = &function_b7946aa4;
    self vehicle_ai::get_state_callbacks("scripted").enter_func = &function_b7946aa4;
    self vehicle_ai::get_state_callbacks("death").enter_func = &function_9a222158;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::get_state_callbacks("emped").update_func = &function_b5c19eaf;
    self vehicle_ai::add_state("unaware", undefined, &state_unaware_update, &function_d16325b3);
    vehicle_ai::add_interrupt_connection("unaware", "scripted", "enter_scripted");
    vehicle_ai::add_interrupt_connection("unaware", "emped", "emped");
    vehicle_ai::add_interrupt_connection("unaware", "off", "shut_off");
    vehicle_ai::add_interrupt_connection("unaware", "driving", "enter_vehicle");
    vehicle_ai::add_interrupt_connection("unaware", "pain", "pain");
    self vehicle_ai::add_state("strafe", &function_f0f6044d, &function_d5b7537e, &function_6fcdaa81);
    vehicle_ai::add_interrupt_connection("strafe", "scripted", "enter_scripted");
    vehicle_ai::add_interrupt_connection("strafe", "emped", "emped");
    vehicle_ai::add_interrupt_connection("strafe", "off", "shut_off");
    vehicle_ai::add_interrupt_connection("strafe", "driving", "enter_vehicle");
    vehicle_ai::add_interrupt_connection("strafe", "pain", "pain");
    vehicle_ai::add_utility_connection("strafe", "combat");
    vehicle_ai::add_utility_connection("emped", "strafe");
    vehicle_ai::add_utility_connection("pain", "strafe");
    vehicle_ai::startinitialstate();
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xc2c16663, Offset: 0x13e0
// Size: 0x64
function function_9329f246() {
    self endon(#"death");
    self notify(#"hash_e9de6408");
    if (isdefined(self.var_5772ae4)) {
        self.var_5772ae4.var_966f680a delete();
        self.var_5772ae4 delete();
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x2c853c0a, Offset: 0x1450
// Size: 0x15a
function function_fa3e8939() {
    self endon(#"death");
    foreach (drone in self.var_6cfdd1e3) {
        if (isalive(drone) && distance2dsquared(self.origin, drone.origin) < 80 * 80) {
            damageorigin = self.origin + (0, 0, 1);
            drone finishvehicleradiusdamage(self.death_info.attacker, self.death_info.attacker, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", level.weaponnone, damageorigin, 400, -1, (0, 0, 1), 0);
        }
    }
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x17a0adae, Offset: 0x15b8
// Size: 0x7c
function function_9a222158(params) {
    self endon(#"death");
    if (isdefined(self.var_fa144784)) {
        self.var_fa144784 delete();
    }
    vehicle_ai::defaultstate_death_enter();
    self.inpain = 1;
    self thread function_9329f246();
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x8bfa6df7, Offset: 0x1640
// Size: 0x12c
function state_death_update(params) {
    self endon(#"death");
    death_type = vehicle_ai::get_death_type(params);
    if (!isdefined(death_type)) {
        params.death_type = "gibbed";
        death_type = params.death_type;
    }
    self vehicle_ai::clearalllookingandtargeting();
    self vehicle_ai::clearallmovement();
    self cancelaimove();
    self setspeedimmediate(0);
    self setvehvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self vehicle_ai::defaultstate_death_update(params);
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x60d32c23, Offset: 0x1778
// Size: 0x7c
function function_73d33fb3(params) {
    ratio = 0.5;
    accel = self getdefaultacceleration();
    self setspeed(ratio * self.settings.defaultmovespeed, ratio * accel, ratio * accel);
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0xf14c864c, Offset: 0x1800
// Size: 0xd0
function state_unaware_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    if (isdefined(self.enemy)) {
        self vehicle_ai::set_state("combat");
    }
    self vehclearlookat();
    self function_9af6e9cf();
    self thread function_52951bdf();
    while (true) {
        self waittill("enemy");
        self vehicle_ai::set_state("combat");
    }
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x85d8870, Offset: 0x18d8
// Size: 0x1a
function function_d16325b3(params) {
    self notify(#"end_movement_thread");
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xa42cb23e, Offset: 0x1900
// Size: 0x2fa
function function_52951bdf() {
    self endon(#"death");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    var_3c6e7674 = 120;
    var_6437cdb2 = 800;
    minsearchradius = math::clamp(var_3c6e7674, 0, self.goalradius);
    maxsearchradius = math::clamp(var_6437cdb2, var_3c6e7674, self.goalradius);
    halfheight = 400;
    innerspacing = 80;
    outerspacing = 50;
    var_fc9d1e61 = 15;
    var_3728fd9e = 2.5 + randomfloat(1);
    while (true) {
        queryresult = positionquery_source_navigation(self.origin, minsearchradius, maxsearchradius, halfheight, innerspacing, self, outerspacing);
        positionquery_filter_distancetogoal(queryresult, self);
        vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
        vehicle_ai::positionquery_filter_random(queryresult, 0, 10);
        vehicle_ai::positionquery_postprocess_sortscore(queryresult);
        var_9a745b6c = var_3728fd9e > 0.2;
        foundpath = 0;
        for (i = 0; i < queryresult.data.size && !foundpath; i++) {
            goalpos = queryresult.data[i].origin;
            foundpath = self setvehgoalpos(goalpos, var_9a745b6c, 1);
        }
        if (foundpath) {
            self waittilltimeout(var_fc9d1e61, "near_goal", "force_goal", "reached_end_node", "goal");
            if (var_9a745b6c) {
                wait randomfloatrange(0.5 * var_3728fd9e, var_3728fd9e);
            }
            continue;
        }
        wait 1;
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x1511fa82, Offset: 0x1c08
// Size: 0x34
function enable_turrets() {
    self turret::enable(1, 0);
    self turret::enable(2, 0);
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xd5ef2848, Offset: 0x1c48
// Size: 0x4c
function function_9af6e9cf() {
    self turret::disable(1);
    self turret::disable(2);
    self side_turrets_forward();
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x6f7c5f2a, Offset: 0x1ca0
// Size: 0x54
function side_turrets_forward() {
    self turretsettargetangles(1, (10, -90, 0));
    self turretsettargetangles(2, (10, 90, 0));
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x8cdbeece, Offset: 0x1d00
// Size: 0xac
function state_combat_enter(params) {
    ratio = 1;
    accel = self getdefaultacceleration();
    self setspeed(ratio * self.settings.defaultmovespeed, ratio * accel, ratio * accel);
    self function_45bbe5dd();
    self enable_turrets();
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x20dfa238, Offset: 0x1db8
// Size: 0xd0
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    if (!isdefined(self.enemy)) {
        self vehicle_ai::set_state("unaware");
    }
    self thread function_d19e6907();
    self thread function_e2183396();
    self thread function_76333d5f();
    while (true) {
        self waittill("no_enemy");
        self vehicle_ai::set_state("unaware");
    }
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0xd7399699, Offset: 0x1e90
// Size: 0x3c
function state_combat_exit(params) {
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self turretcleartarget(0);
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0xfb44022, Offset: 0x1ed8
// Size: 0xb4
function function_f0f6044d(params) {
    ratio = 2;
    accel = ratio * self getdefaultacceleration();
    speed = ratio * self.settings.defaultmovespeed;
    var_141ca569 = 100;
    if (var_141ca569 > 0) {
        speed = var_141ca569;
    }
    self setspeed(speed, accel, accel);
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0xa1e94122, Offset: 0x1f98
// Size: 0x7d4
function function_d5b7537e(params) {
    self endon(#"change_state");
    self endon(#"death");
    self clearvehgoalpos();
    distancetotarget = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    target = self.origin + anglestoforward(self.angles) * distancetotarget;
    if (isdefined(self.enemy)) {
        distancetotarget = distance(self.origin, self.enemy.origin);
    }
    distancethreshold = 500 + distancetotarget * 0.08;
    var_8651707b = 100;
    if (var_8651707b > 0) {
        distancethreshold = var_8651707b;
    }
    maxsearchradius = distancethreshold * 1.5;
    halfheight = 300;
    outerspacing = maxsearchradius * 0.05;
    innerspacing = outerspacing * 2;
    queryresult = positionquery_source_navigation(self.origin, 0, maxsearchradius, halfheight, innerspacing, self, outerspacing);
    positionquery_filter_directness(queryresult, self.origin, target);
    positionquery_filter_distancetogoal(queryresult, self);
    positionquery_filter_inclaimedlocation(queryresult, self);
    self vehicle_ai::positionquery_filter_outofgoalanchor(queryresult, 200);
    foreach (point in queryresult.data) {
        var_9742f62b = distancesquared(point.origin, self.origin);
        if (var_9742f62b < distancethreshold * 0.5) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x28>"] = distancethreshold * -1;
            #/
            point.score += distancethreshold * -1;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = sqrt(var_9742f62b);
        #/
        point.score += sqrt(var_9742f62b);
        difftoprefereddirectness = abs(point.directness - 0);
        directnessscore = mapfloat(0, 1, 1000, 0, difftoprefereddirectness);
        if (difftoprefereddirectness > 0.1) {
            directnessscore -= 500;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x31>"] = point.directness;
        #/
        point.score += point.directness;
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x3f>"] = directnessscore;
        #/
        point.score += directnessscore;
        if (point.directionchange < 0.6) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x4a>"] = -2000;
            #/
            point.score += -2000;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x5a>"] = point.directionchange;
        #/
        point.score += point.directionchange;
    }
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);
    foreach (point in queryresult.data) {
        self.current_pathto_pos = point.origin;
        foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 1);
        if (foundpath) {
            self waittilltimeout(5, "near_goal", "force_goal", "goal", "enemy_visible");
            break;
        }
    }
    previous_state = self vehicle_ai::get_previous_state();
    if (!isdefined(previous_state) || previous_state == "strafe") {
        previous_state = "combat";
    }
    self vehicle_ai::set_state(previous_state);
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0xc7004483, Offset: 0x2778
// Size: 0x2c
function function_6fcdaa81(params) {
    vehicle_ai::cooldown("strafe_again", 2);
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x2b9b95e, Offset: 0x27b0
// Size: 0x6ee
function getnextmoveposition_tactical(enemy) {
    if (self.goalforced) {
        return self.goalpos;
    }
    selfdisttoenemy = distance2d(self.origin, enemy.origin);
    gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    tooclosedist = 0.8 * gooddist;
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttoenemy);
    prefereddistawayfromorigin = 150;
    maxsearchradius = 1000 * querymultiplier;
    halfheight = 300 * querymultiplier;
    innerspacing = 80 * querymultiplier;
    outerspacing = 80 * querymultiplier;
    queryresult = positionquery_source_navigation(self.origin, 0, maxsearchradius, halfheight, innerspacing, self, outerspacing);
    positionquery_filter_distancetogoal(queryresult, self);
    positionquery_filter_inclaimedlocation(queryresult, self);
    positionquery_filter_sight(queryresult, enemy.origin, self geteye() - self.origin, self, 0, enemy);
    self vehicle_ai::positionquery_filter_outofgoalanchor(queryresult, 200);
    self vehicle_ai::positionquery_filter_engagementdist(queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    self vehicle_ai::positionquery_filter_random(queryresult, 0, 30);
    goalheight = enemy.origin[2] + 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
    foreach (point in queryresult.data) {
        if (!point.visibility) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x6d>"] = -600;
            #/
            point.score += -600;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x7b>"] = point.distawayfromengagementarea * -1;
        #/
        point.score += point.distawayfromengagementarea * -1;
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x8a>"] = mapfloat(0, prefereddistawayfromorigin, 0, 600, point.disttoorigin2d);
        #/
        point.score += mapfloat(0, prefereddistawayfromorigin, 0, 600, point.disttoorigin2d);
        if (point.inclaimedlocation) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x97>"] = -500;
            #/
            point.score += -500;
        }
        preferedheightrange = 75;
        distfrompreferredheight = abs(point.origin[2] - goalheight);
        if (distfrompreferredheight > preferedheightrange) {
            heightscore = mapfloat(preferedheightrange, 5000, 0, 9000, distfrompreferredheight) * -1;
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:xa9>"] = heightscore;
            #/
            point.score += heightscore;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    if (queryresult.data.size) {
        return queryresult.data[0].origin;
    }
    return self.origin;
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x2cb58f2, Offset: 0x2ea8
// Size: 0x8c8
function function_d19e6907() {
    self endon(#"death");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    var_fc9d1e61 = 10;
    stuckcount = 0;
    while (true) {
        enemy = self.enemy;
        if (!isdefined(enemy)) {
            wait 1;
            continue;
        }
        usepathfinding = 1;
        onnavvolume = ispointinnavvolume(self.origin, "navvolume_big");
        if (!onnavvolume) {
            getbackpoint = undefined;
            pointonnavvolume = self getclosestpointonnavvolume(self.origin, 500);
            if (isdefined(pointonnavvolume)) {
                if (sighttracepassed(self.origin, pointonnavvolume, 0, self)) {
                    getbackpoint = pointonnavvolume;
                }
            }
            if (!isdefined(getbackpoint)) {
                queryresult = positionquery_source_navigation(self.origin, 0, 800, 400, 1.5 * self.radius);
                positionquery_filter_sight(queryresult, self.origin, (0, 0, 0), self, 1);
                getbackpoint = undefined;
                foreach (point in queryresult.data) {
                    if (point.visibility === 1) {
                        getbackpoint = point.origin;
                        break;
                    }
                }
            }
            if (isdefined(getbackpoint)) {
                self.current_pathto_pos = getbackpoint;
                usepathfinding = 0;
            } else {
                stuckcount++;
                if (stuckcount == 1) {
                    stucklocation = self.origin;
                } else if (stuckcount > 10) {
                    /#
                        /#
                            assert(0, "<dev string:xb0>" + self.origin);
                        #/
                        v_box_min = (self.radius * -1, self.radius * -1, self.radius * -1);
                        v_box_max = (self.radius, self.radius, self.radius);
                        box(self.origin, v_box_min, v_box_max, self.angles[1], (1, 0, 0), 1, 0, 1000000);
                        if (isdefined(stucklocation)) {
                            line(stucklocation, self.origin, (1, 0, 0), 1, 1, 1000000);
                        }
                    #/
                    self kill();
                }
            }
        } else {
            stuckcount = 0;
            if (self.goalforced) {
                goalpos = self getclosestpointonnavvolume(self.goalpos, 200);
                if (isdefined(goalpos)) {
                    self.current_pathto_pos = goalpos;
                    usepathfinding = 1;
                } else {
                    self.current_pathto_pos = self.goalpos;
                    usepathfinding = 0;
                }
            } else {
                self.current_pathto_pos = getnextmoveposition_tactical(enemy);
                usepathfinding = 1;
            }
        }
        if (!isdefined(self.current_pathto_pos)) {
            wait 0.5;
            continue;
        }
        distancetogoalsq = distancesquared(self.current_pathto_pos, self.origin);
        if (distancetogoalsq > 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) {
            self setspeed(self.settings.defaultmovespeed * 2);
        } else {
            self setspeed(self.settings.defaultmovespeed);
        }
        self vehlookat(enemy);
        foundpath = self setvehgoalpos(self.current_pathto_pos, 1, usepathfinding);
        if (foundpath) {
            /#
                if (isdefined(getdvarint("<dev string:xd5>")) && getdvarint("<dev string:xd5>")) {
                    recordline(self.origin, self.current_pathto_pos, (0.3, 1, 0));
                    recordline(self.origin, enemy.origin, (1, 0, 0.4));
                }
            #/
            self waittilltimeout(var_fc9d1e61, "near_goal", "force_goal", "goal");
        } else {
            wait 0.5;
        }
        enemy = self.enemy;
        if (isdefined(enemy)) {
            goalheight = enemy.origin[2] + 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
            distfrompreferredheight = abs(self.origin[2] - goalheight);
            fardist = self.settings.engagementdistmax;
            neardist = self.settings.engagementdistmin;
            selfdisttoenemy = distance2d(self.origin, enemy.origin);
            if (self cansee(enemy) && selfdisttoenemy < fardist && selfdisttoenemy > neardist && distfrompreferredheight < 230) {
                msg = self waittilltimeout(randomfloatrange(2, 4), "enemy_not_visible");
                if (msg._notify == "enemy_not_visible") {
                    msg = self waittilltimeout(1, "enemy_visible");
                    if (msg._notify != "timeout") {
                        wait 1;
                    }
                }
            }
            continue;
        }
        wait 1;
    }
}

// Namespace hunter/hunter
// Params 3, eflags: 0x0
// Checksum 0xe5dab76e, Offset: 0x3778
// Size: 0x20c
function function_ea4bbd0d(point, enemy, var_5e1bf73c) {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self endon(#"hash_b8564875");
    enemy endon(#"death");
    if (!isdefined(self.var_fa144784)) {
        self.var_fa144784 = spawn("script_origin", point);
    }
    self.var_fa144784 unlink();
    self.var_fa144784.origin = point;
    self turretsettarget(0, self.var_fa144784);
    self waittill("turret_on_target");
    timestart = gettime();
    offset = (0, 0, 0);
    if (issentient(enemy)) {
        offset = enemy geteye() - enemy.origin;
    }
    while (gettime() < timestart + var_5e1bf73c * 1000) {
        self.var_fa144784.origin = lerpvector(point, enemy.origin + offset, (gettime() - timestart) / var_5e1bf73c * 1000);
        waitframe(1);
    }
    self.var_fa144784.origin = enemy.origin + offset;
    waitframe(1);
    self.var_fa144784 linkto(enemy);
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x783e0fe8, Offset: 0x3990
// Size: 0x250
function function_e2183396() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    while (true) {
        enemy = self.enemy;
        if (isdefined(enemy)) {
            self vehlookat(enemy);
            if (self cansee(enemy)) {
                vectorfromenemy = vectornormalize(((self.origin - enemy.origin)[0], (self.origin - enemy.origin)[1], 0));
                self thread function_ea4bbd0d(enemy.origin + vectorfromenemy * 300, enemy, 1.5);
                self waittill("turret_on_target");
                self vehicle_ai::fire_for_time(2 + randomfloat(0.8));
                self turretcleartarget(0);
                self turretsettargetangles(0, (15, 0, 0));
                if (isdefined(enemy) && isai(enemy)) {
                    wait 2.5 + randomfloat(0.5);
                } else {
                    wait 2 + randomfloat(0.4);
                }
            } else {
                wait 0.4;
            }
            continue;
        }
        self turretcleartarget(0);
        self vehclearlookat();
        wait 0.4;
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x1018f3fd, Offset: 0x3be8
// Size: 0x4c0
function function_76333d5f() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    while (true) {
        enemy = self.enemy;
        if (!isdefined(enemy)) {
            wait 1;
            continue;
        }
        if (isdefined(enemy) && self cansee(enemy) && vehicle_ai::iscooldownready("rocket_launcher")) {
            vehicle_ai::cooldown("rocket_launcher", 8);
            self notify(#"end_movement_thread");
            self clearvehgoalpos();
            self setvehgoalpos(self.origin, 1, 0);
            target = enemy.origin;
            self vehlookat(enemy);
            self function_45bbe5dd();
            wait 1.5;
            eye = self gettagorigin("tag_eye");
            if (isdefined(enemy)) {
                var_c64af691 = vectortoangles(enemy.origin - eye);
                angles = var_c64af691 - self.angles;
                if (-30 < angles[0] && angles[0] < 60 && -70 < angles[1] && angles[1] < 70) {
                    target = enemy.origin;
                } else {
                    var_c64af691 = vectortoangles(target - eye);
                }
            } else {
                var_c64af691 = vectortoangles(target - eye);
            }
            rightdir = anglestoright(var_c64af691);
            randomrange = 30;
            offset = [];
            offset[0] = rightdir * -1 * randomrange * 2 + (randomfloatrange(randomrange * -1, randomrange), randomfloatrange(randomrange * -1, randomrange), 0);
            offset[1] = rightdir * randomrange * 2 + (randomfloatrange(randomrange * -1, randomrange), randomfloatrange(randomrange * -1, randomrange), 0);
            self function_ed543896(0, target, offset[0]);
            wait 0.5;
            if (isdefined(enemy)) {
                eye = self gettagorigin("tag_eye");
                angles = vectortoangles(enemy.origin - eye) - self.angles;
                if (-30 < angles[0] && angles[0] < 60 && -70 < angles[1] && angles[1] < 70) {
                    target = enemy.origin;
                }
            }
            self function_ed543896(1, target, offset[1]);
            wait 1;
            self thread function_d19e6907();
        }
        wait 0.5;
    }
}

// Namespace hunter/hunter
// Params 5, eflags: 0x0
// Checksum 0x58d91eba, Offset: 0x40b0
// Size: 0x250
function function_ed543896(var_e569678c, target, offset, var_d5ccbff6, var_8d0a485e) {
    self endon(#"death");
    if (isdefined(var_d5ccbff6) && var_d5ccbff6) {
        self vehicle_ai::blink_lights_for_time(1);
        if (isdefined(var_8d0a485e) && var_8d0a485e > 0) {
            wait var_8d0a485e;
        }
    }
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    spawntag = self.missiletags[var_e569678c];
    origin = self gettagorigin(spawntag);
    angles = self gettagangles(spawntag);
    forward = anglestoforward(angles);
    up = anglestoup(angles);
    if (isdefined(spawntag) && isdefined(target)) {
        weapon = getweapon("hunter_rocket_turret");
        if (isentity(target)) {
            missile = magicbullet(weapon, origin, target.origin + offset, self, target, offset);
            return;
        }
        if (isvec(target)) {
            missile = magicbullet(weapon, origin, target + offset, self);
            return;
        }
        missile = magicbullet(weapon, origin, target.origin + offset, self);
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x1dffedf4, Offset: 0x4308
// Size: 0x8c
function function_b563a727() {
    self endon(#"death");
    hostmigration::waitlongdurationwithhostmigrationpause(10);
    playfx(level.var_67421f32["missileExplode"], self.origin);
    self playlocalsound("mpl_ks_reaper_explosion");
    self delete();
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xab3dc564, Offset: 0x43a0
// Size: 0x44
function function_45bbe5dd() {
    self thread vehicle_ai::blink_lights_for_time(1.5);
    self playsound("veh_hunter_alarm_target");
}

// Namespace hunter/hunter
// Params 2, eflags: 0x0
// Checksum 0xa5483754, Offset: 0x43f0
// Size: 0xec
function getenemyarray(var_90f6a18c, var_c776eebd) {
    enemyarray = [];
    enemy_team = "allies";
    if (isdefined(var_90f6a18c) && var_90f6a18c) {
        aiarray = getaiteamarray(enemy_team);
        enemyarray = arraycombine(enemyarray, aiarray, 0, 0);
    }
    if (isdefined(var_c776eebd) && var_c776eebd) {
        playerarray = getplayers(enemy_team);
        enemyarray = arraycombine(enemyarray, playerarray, 0, 0);
    }
    return enemyarray;
}

// Namespace hunter/hunter
// Params 2, eflags: 0x0
// Checksum 0x44e944cf, Offset: 0x44e8
// Size: 0x134
function function_d16e8674(point, do_trace) {
    if (!isdefined(point)) {
        return 0;
    }
    scanner = self.var_5772ae4;
    var_e8663043 = point - scanner.origin;
    in_view = lengthsquared(var_e8663043) <= 10000 * 10000;
    if (in_view) {
        in_view = util::within_fov(scanner.origin, scanner.angles, point, cos(190));
    }
    if (isdefined(do_trace) && in_view && do_trace && isdefined(self.enemy)) {
        in_view = sighttracepassed(scanner.origin, point, 0, self.enemy);
    }
    return in_view;
}

// Namespace hunter/hunter
// Params 2, eflags: 0x0
// Checksum 0xe9281351, Offset: 0x4628
// Size: 0x104
function is_valid_target(target, do_trace) {
    var_f230ef9a = 1;
    if (isdefined(target.ignoreme) && target.ignoreme || target.health <= 0) {
        var_f230ef9a = 0;
    } else if (target isnotarget() || issentient(target) && target ai::is_dead_sentient()) {
        var_f230ef9a = 0;
    } else if (isdefined(target.origin) && !function_d16e8674(target.origin, do_trace)) {
        var_f230ef9a = 0;
    }
    return var_f230ef9a;
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0xa4a4bb5c, Offset: 0x4738
// Size: 0x12c
function function_c35210a8(do_trace) {
    var_526bc7e = [];
    enemyarray = getenemyarray(1, 1);
    foreach (enemy in enemyarray) {
        if (is_valid_target(enemy, do_trace)) {
            if (!isdefined(var_526bc7e)) {
                var_526bc7e = [];
            } else if (!isarray(var_526bc7e)) {
                var_526bc7e = array(var_526bc7e);
            }
            var_526bc7e[var_526bc7e.size] = enemy;
        }
    }
    return var_526bc7e;
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xff5653b1, Offset: 0x4870
// Size: 0x1ac
function function_d92edef5() {
    self.var_5772ae4 = spawn("script_model", self gettagorigin("tag_gunner_flash3"));
    self.var_5772ae4 setmodel("tag_origin");
    self.var_5772ae4.angles = self gettagangles("tag_gunner_flash3");
    self.var_5772ae4 linkto(self, "tag_gunner_flash3");
    self.var_5772ae4.owner = self;
    self.var_5772ae4.var_f56360bf = 0;
    self.var_5772ae4.var_966f680a = spawn("script_origin", self.var_5772ae4.origin + anglestoforward(self.angles) * 1000);
    self.var_5772ae4.var_966f680a linkto(self.var_5772ae4);
    wait 0.25;
    if (false) {
        playfxontag(self.settings.var_1ce01d35, self.var_5772ae4, "tag_origin");
    }
}

// Namespace hunter/hunter
// Params 2, eflags: 0x0
// Checksum 0xe8a6f247, Offset: 0x4a28
// Size: 0x8c
function function_ff25493(targetent, offset) {
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    if (isdefined(targetent)) {
        self.var_5772ae4.targetent = targetent;
        self.var_5772ae4.var_f56360bf = 1;
        self turretsettarget(3, self.var_5772ae4.targetent, offset);
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xcc3ee22e, Offset: 0x4ac0
// Size: 0x34
function function_b3df73a8() {
    self.var_5772ae4.var_f56360bf = 0;
    self turretcleartarget(3);
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0xebc354bc, Offset: 0x4b00
// Size: 0x54
function function_4406e447(targetpos) {
    if (isdefined(targetpos)) {
        self.var_5772ae4.targetpos = targetpos;
        self turretsettarget(3, self.var_5772ae4.targetpos);
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xd0b4ebe2, Offset: 0x4b60
// Size: 0x448
function function_18fb105e() {
    self endon(#"hash_e9de6408");
    self endon(#"crash_done");
    self endon(#"death");
    function_d92edef5();
    var_89879d1 = 0;
    var_a2c1ed4e = 0;
    pitchstep = 2.23607;
    yawstep = 3.14159;
    pitchrange = 20;
    yawrange = 45;
    var_488ceea8 = undefined;
    while (true) {
        var_845c3483 = self.var_5772ae4.origin;
        if (isdefined(self.inpain) && self.inpain) {
            wait 0.3;
            offset = (50, 0, 0) + (math::randomsign() * randomfloatrange(1, 2) * pitchrange, math::randomsign() * randomfloatrange(1, 2) * yawrange, 0);
            var_488ceea8 = anglestoforward(self.angles + offset);
        } else if (!isdefined(self.enemy)) {
            if (false) {
                self.var_5772ae4.var_966f680a playloopsound("veh_hunter_scanner_loop", 1);
            }
            var_89879d1 += pitchstep;
            var_a2c1ed4e += yawstep;
            offset = (50, 0, 0) + (sin(var_89879d1) * pitchrange, cos(var_a2c1ed4e) * yawrange, 0);
            var_488ceea8 = anglestoforward(self.angles + offset);
            enemies = function_c35210a8(1);
            if (enemies.size > 0) {
                closest_enemy = arraygetclosest(self.origin, enemies);
                self.favoriteenemy = closest_enemy;
                /#
                    line(var_845c3483, closest_enemy.origin, (0, 1, 0), 1, 3);
                #/
            }
        } else {
            if (self function_d16e8674(self.enemy.origin, 1)) {
                self notify(#"hash_5176d091");
            } else {
                self notify(#"hash_5a14c09c");
            }
            var_488ceea8 = vectornormalize(self.enemy.origin - var_845c3483);
            if (false) {
                self.var_5772ae4.var_966f680a stoploopsound(1);
            }
        }
        targetlocation = var_845c3483 + var_488ceea8 * 1000;
        self function_4406e447(targetlocation);
        /#
            line(var_845c3483, self.var_5772ae4.targetpos, (0, 1, 0), 1, 1000);
        #/
        wait 0.1;
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xe3166853, Offset: 0x4fb0
// Size: 0xfc
function function_55e65823() {
    waitresult = self waittill("exit_vehicle");
    waitresult.player val::reset("hunter", "ignoreme");
    waitresult.player val::reset("hunter", "takedamage");
    self setheliheightlock(0);
    self enableaimassist();
    self setvehicletype(self.original_vehicle_type);
    self.attachedpath = undefined;
    self setgoal(self.origin, 0, 4096, 512);
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x473e4528, Offset: 0x50b8
// Size: 0x24c
function function_b7946aa4(params) {
    params.driver = self getseatoccupant(0);
    if (isdefined(params.driver)) {
        self disableaimassist();
        self thread vehicle_death::vehicle_damage_filter("firestorm_turret");
        params.driver val::set("hunter", "ignoreme", 1);
        params.driver val::set("hunter", "takedamage", 0);
        if (isdefined(self.var_38954f91)) {
            self setvehweapon(self.var_38954f91);
        }
        self thread function_55e65823();
        self thread function_f5a4219e();
        self thread function_bf3c27f8();
        self thread function_31439733();
        self thread function_9d3d995e();
    }
    if (isdefined(self.goal_node) && isdefined(self.goal_node.var_3bb0f8c1)) {
        self.goal_node.var_3bb0f8c1 = undefined;
    }
    self turretcleartarget(0);
    self clearvehgoalpos();
    self pathvariableoffsetclear();
    self pathfixedoffsetclear();
    self vehclearlookat();
    self resumespeed();
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xf4521632, Offset: 0x5310
// Size: 0xce
function function_bf3c27f8() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    weapon = self seatgetweapon(1);
    firetime = weapon.firetime;
    while (true) {
        self turretsettarget(1, self turretgettarget(0));
        if (self isdriverfiring()) {
            self fireweapon(1);
        }
        wait firetime;
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x6c1bd67d, Offset: 0x53e8
// Size: 0xce
function function_31439733() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    weapon = self seatgetweapon(2);
    firetime = weapon.firetime;
    while (true) {
        self turretsettarget(2, self turretgettarget(0));
        if (self isdriverfiring()) {
            self fireweapon(2);
        }
        wait firetime;
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x2696027b, Offset: 0x54c0
// Size: 0x194
function function_9d3d995e() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    weapon = getweapon("hunter_rocket_turret_player");
    firetime = weapon.firetime;
    driver = self getseatoccupant(0);
    while (true) {
        if (driver buttonpressed("BUTTON_A")) {
            var_cc403332 = self.missiletags[0];
            var_f242ad9b = self.missiletags[1];
            origin0 = self gettagorigin(var_cc403332);
            origin1 = self gettagorigin(var_f242ad9b);
            target = self turretgettarget(0);
            magicbullet(weapon, origin0, target);
            magicbullet(weapon, origin1, target);
            wait firetime;
        }
        waitframe(1);
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0x307909ee, Offset: 0x5660
// Size: 0x120
function function_f5a4219e() {
    self endon(#"change_state");
    self endon(#"crash_done");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("veh_collision");
        velocity = waitresult.velocity;
        normal = waitresult.normal;
        driver = self getseatoccupant(0);
        if (isdefined(driver) && lengthsquared(velocity) > 4900) {
            earthquake(0.25, 0.25, driver.origin, 50);
            driver playrumbleonentity("damage_heavy");
        }
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xe3cd1bef, Offset: 0x5788
// Size: 0x14e
function function_f47e4a8f() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        var_eb59fb11 = abs(self getspeed() / self getmaxspeed());
        if (var_eb59fb11 < 0.1) {
            level.player playrumbleonentity("hunter_fly");
            wait 0.35;
            continue;
        }
        time = randomfloatrange(0.1, 0.2);
        earthquake(randomfloatrange(0.1, 0.15), time, self.origin, 200);
        level.player playrumbleonentity("hunter_fly");
        wait time;
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xcc921990, Offset: 0x58e0
// Size: 0x1ac
function function_c2f7d68d() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    self_destruct = 0;
    var_2b2fe37c = 0;
    while (true) {
        if (!self_destruct) {
            if (level.player meleebuttonpressed()) {
                self_destruct = 1;
                var_2b2fe37c = 5;
            }
            waitframe(1);
            continue;
        }
        iprintlnbold(var_2b2fe37c);
        wait 1;
        var_2b2fe37c -= 1;
        if (var_2b2fe37c == 0) {
            driver = self getseatoccupant(0);
            if (isdefined(driver)) {
                driver val::reset("hunter", "takedamage");
            }
            earthquake(3, 1, self.origin, 256);
            radiusdamage(self.origin, 1000, 15000, 15000, level.player, "MOD_EXPLOSIVE");
            self dodamage(self.health + 1000, self.origin);
        }
        continue;
    }
}

// Namespace hunter/hunter
// Params 0, eflags: 0x0
// Checksum 0xffb4a981, Offset: 0x5a98
// Size: 0xfe
function function_295ee7d() {
    self endon(#"death");
    self endon(#"emped");
    self endon(#"landed");
    while (isdefined(self.emped)) {
        velocity = self.velocity;
        self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
        ang_vel = self getangularvelocity() * 0.85;
        self setangularvelocity(ang_vel);
        self setvehvelocity(velocity);
        waitframe(1);
    }
}

// Namespace hunter/hunter
// Params 1, eflags: 0x0
// Checksum 0x96fe705d, Offset: 0x5ba0
// Size: 0x64
function function_b5c19eaf(params) {
    self endon(#"death");
    self endon(#"emped");
    self.emped = 1;
    wait randomfloatrange(4, 7);
    self vehicle_ai::evaluate_connections();
}

// Namespace hunter/hunter
// Params 4, eflags: 0x0
// Checksum 0x335995ca, Offset: 0x5c10
// Size: 0x1d0
function function_dd1df31a(time, var_f7558f2d, var_78b17090, restorelookpoint) {
    self endon(#"death");
    self.painstarttime = gettime();
    if (!(isdefined(self.inpain) && self.inpain)) {
        self.inpain = 1;
        while (gettime() < self.painstarttime + time * 1000) {
            self setvehvelocity(self.velocity * var_f7558f2d);
            self setangularvelocity(self getangularvelocity() * var_78b17090);
            wait 0.1;
        }
        if (isdefined(restorelookpoint)) {
            restorelookent = spawn("script_model", restorelookpoint);
            restorelookent setmodel("tag_origin");
            self vehclearlookat();
            self vehlookat(restorelookent);
            self turretsettarget(0, restorelookent);
            wait 1.5;
            self vehclearlookat();
            self turretcleartarget(0);
            restorelookent delete();
        }
        self.inpain = 0;
    }
}

// Namespace hunter/hunter
// Params 6, eflags: 0x0
// Checksum 0x83435d10, Offset: 0x5de8
// Size: 0x1fc
function function_20bcfea(eattacker, damagetype, hitpoint, hitdirection, hitlocationinfo, partname) {
    if (!isdefined(hitpoint) || !isdefined(hitdirection)) {
        return;
    }
    self setvehvelocity(self.velocity + vectornormalize(hitdirection) * 20);
    if (!(isdefined(self.inpain) && self.inpain)) {
        var_d6c80d1d = anglestoright(self.angles);
        sign = math::sign(vectordot(var_d6c80d1d, hitdirection));
        yaw_vel = sign * randomfloatrange(100, 140);
        ang_vel = self getangularvelocity();
        ang_vel += (randomfloatrange(-120, -100), yaw_vel, randomfloatrange(-100, 100));
        self setangularvelocity(ang_vel);
        self thread function_dd1df31a(1.5, 1, 0.8);
    }
    self vehicle_ai::set_state("strafe");
}

// Namespace hunter/hunter
// Params 15, eflags: 0x0
// Checksum 0x4c121bca, Offset: 0x5ff0
// Size: 0x298
function function_8fff56d4(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    driver = self getseatoccupant(0);
    if (isdefined(eattacker) && eattacker.team == self.team) {
        return 0;
    }
    num_players = getplayers().size;
    maxdamage = self.healthdefault * (0.35 - 0.025 * num_players);
    if (smeansofdeath !== "MOD_UNKNOWN" && idamage > maxdamage) {
        idamage = maxdamage;
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
        function_20bcfea(eattacker, smeansofdeath, vpoint, vdir, shitloc, partname);
        vehicle::set_damage_fx_level(self.damagelevel);
    }
    if (vehicle_ai::should_emp(self, weapon, smeansofdeath, einflictor, eattacker)) {
        function_20bcfea(eattacker, smeansofdeath, vpoint, vdir, shitloc, partname);
    }
    return idamage;
}

