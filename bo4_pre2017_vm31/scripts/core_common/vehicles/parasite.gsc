#using scripts/core_common/ai/blackboard_vehicle;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/zombie_utility;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;

#namespace parasite;

// Namespace parasite/parasite
// Params 0, eflags: 0x2
// Checksum 0xb1e913bf, Offset: 0x4d0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("parasite", &__init__, undefined, undefined);
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0xe1b819ec, Offset: 0x510
// Size: 0x12c
function __init__() {
    vehicle::add_main_callback("parasite", &parasite_initialize);
    clientfield::register("vehicle", "parasite_tell_fx", 1, 1, "int");
    clientfield::register("vehicle", "parasite_secondary_deathfx", 1, 1, "int");
    clientfield::register("toplayer", "parasite_damage", 1, 1, "counter");
    callback::on_spawned(&parasite_damage);
    ai::registermatchedinterface("parasite", "firing_rate", "slow", array("slow", "medium", "fast"));
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0xe5e85ca6, Offset: 0x648
// Size: 0xd8
function parasite_damage() {
    self notify(#"parasite_damage_thread");
    self endon(#"parasite_damage_thread");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("damage");
        if (isdefined(waitresult.attacker.is_parasite) && waitresult.attacker.is_parasite && !(isdefined(waitresult.attacker.squelch_damage_overlay) && waitresult.attacker.squelch_damage_overlay)) {
            self clientfield::increment_to_player("parasite_damage");
        }
    }
}

// Namespace parasite/parasite
// Params 1, eflags: 0x4
// Checksum 0x5a454eca, Offset: 0x728
// Size: 0xf6
function private is_target_valid(target) {
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (isplayer(target) && target.sessionstate == "spectator") {
        return false;
    }
    if (isplayer(target) && target.sessionstate == "intermission") {
        return false;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return false;
    }
    if (target isnotarget()) {
        return false;
    }
    return true;
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0x351e7cbc, Offset: 0x828
// Size: 0x13c
function get_parasite_enemy() {
    parasite_targets = getplayers();
    least_hunted = parasite_targets[0];
    for (i = 0; i < parasite_targets.size; i++) {
        if (!isdefined(parasite_targets[i].hunted_by)) {
            parasite_targets[i].hunted_by = 0;
        }
        if (!is_target_valid(parasite_targets[i])) {
            continue;
        }
        if (!is_target_valid(least_hunted)) {
            least_hunted = parasite_targets[i];
        }
        if (parasite_targets[i].hunted_by < least_hunted.hunted_by) {
            least_hunted = parasite_targets[i];
        }
    }
    if (!is_target_valid(least_hunted)) {
        return undefined;
    }
    return least_hunted;
}

// Namespace parasite/parasite
// Params 1, eflags: 0x0
// Checksum 0x6cfe76cb, Offset: 0x970
// Size: 0x11c
function set_parasite_enemy(enemy) {
    if (!is_target_valid(enemy)) {
        return;
    }
    if (isdefined(self.parasiteenemy)) {
        if (!isdefined(self.parasiteenemy.hunted_by)) {
            self.parasiteenemy.hunted_by = 0;
        }
        if (self.parasiteenemy.hunted_by > 0) {
            self.parasiteenemy.hunted_by--;
        }
    }
    self.parasiteenemy = enemy;
    if (!isdefined(self.parasiteenemy.hunted_by)) {
        self.parasiteenemy.hunted_by = 0;
    }
    self.parasiteenemy.hunted_by++;
    self vehlookat(self.parasiteenemy);
    self turretsettarget(0, self.parasiteenemy);
}

// Namespace parasite/parasite
// Params 0, eflags: 0x4
// Checksum 0x3080aa3f, Offset: 0xa98
// Size: 0x128
function private parasite_target_selection() {
    self endon(#"change_state");
    self endon(#"death");
    for (;;) {
        if (isdefined(self.ignoreall) && self.ignoreall) {
            wait 0.5;
            continue;
        }
        if (is_target_valid(self.parasiteenemy)) {
            wait 0.5;
            continue;
        }
        target = get_parasite_enemy();
        if (!isdefined(target)) {
            self.parasiteenemy = undefined;
        } else {
            self.parasiteenemy = target;
            self.parasiteenemy.hunted_by += 1;
            self vehlookat(self.parasiteenemy);
            self turretsettarget(0, self.parasiteenemy);
        }
        wait 0.5;
    }
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0x14c58f5a, Offset: 0xbc8
// Size: 0x1fc
function parasite_initialize() {
    self useanimtree(#generic);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    ai::createinterfaceforentity(self);
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(25);
    self setdrawinfrared(1);
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 1;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 999999;
    self.goalheight = 4000;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.is_parasite = 1;
    self thread vehicle_ai::nudge_collision();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    defaultrole();
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0xfa1adc3c, Offset: 0xdd0
// Size: 0xe4
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::call_custom_add_state_callbacks();
    vehicle_ai::startinitialstate("combat");
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0xf7b880d4, Offset: 0xec0
// Size: 0x22
function getparasitefiringrate() {
    return self ai::get_behavior_attribute("firing_rate");
}

// Namespace parasite/parasite
// Params 1, eflags: 0x0
// Checksum 0xfad0d01f, Offset: 0xef0
// Size: 0x12c
function state_death_update(params) {
    self endon(#"death");
    self asmrequestsubstate("death@stationary");
    if (isdefined(self.parasiteenemy) && isdefined(self.parasiteenemy.hunted_by)) {
        self.parasiteenemy.hunted_by--;
    }
    self setphysacceleration((0, 0, -300));
    self.vehcheckforpredictedcrash = 1;
    self thread vehicle_death::death_fx();
    self playsound("zmb_parasite_explo");
    self waittilltimeout(4, "veh_predictedcollision");
    self clientfield::set("parasite_secondary_deathfx", 1);
    wait 0.2;
    self delete();
}

// Namespace parasite/parasite
// Params 1, eflags: 0x0
// Checksum 0x787699c6, Offset: 0x1028
// Size: 0x64
function state_combat_enter(params) {
    if (isdefined(self.owner) && isdefined(self.owner.enemy)) {
        self.parasiteenemy = self.owner.enemy;
    }
    self thread parasite_target_selection();
}

// Namespace parasite/parasite
// Params 1, eflags: 0x0
// Checksum 0xfc7a0ac7, Offset: 0x1098
// Size: 0x4d0
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    lasttimechangeposition = 0;
    self.shouldgotonewposition = 0;
    self.lasttimetargetinsight = 0;
    self.lasttimejuked = 0;
    self asmrequestsubstate("locomotion@movement");
    for (;;) {
        if (isdefined(self._override_parasite_combat_speed)) {
            self setspeed(self._override_parasite_combat_speed);
        } else {
            self setspeed(self.settings.defaultmovespeed);
        }
        if (isdefined(self.inpain) && self.inpain) {
            wait 0.1;
            continue;
        }
        if (!isdefined(self.parasiteenemy)) {
            wait 0.25;
            continue;
        }
        if (self.goalforced) {
            returndata = [];
            returndata["origin"] = self getclosestpointonnavvolume(self.goalpos, 100);
            returndata["centerOnNav"] = ispointinnavvolume(self.origin, "navvolume_small");
        } else if (isdefined(self._override_juke) && (randomint(100) < self.settings.jukeprobability && !(isdefined(self.lasttimejuked) && self.lasttimejuked) || self._override_juke)) {
            returndata = getnextmoveposition_forwardjuke();
            self.lasttimejuked = 1;
            self._override_juke = undefined;
        } else {
            returndata = getnextmoveposition_tactical();
            self.lasttimejuked = 0;
        }
        self.current_pathto_pos = returndata["origin"];
        if (isdefined(self.current_pathto_pos)) {
            if (isdefined(self.stucktime)) {
                self.stucktime = undefined;
            }
            if (self setvehgoalpos(self.current_pathto_pos, 1, returndata["centerOnNav"])) {
                self thread path_update_interrupt();
                self playsound("zmb_vocals_parasite_juke");
                self vehicle_ai::waittill_pathing_done(5);
            } else {
                wait 0.1;
            }
        } else if (!(isdefined(returndata["centerOnNav"]) && returndata["centerOnNav"])) {
            if (!isdefined(self.stucktime)) {
                self.stucktime = gettime();
            }
            if (gettime() - self.stucktime > 10000) {
                self dodamage(self.health + 100, self.origin);
            }
        }
        if (isdefined(self.lasttimejuked) && self.lasttimejuked) {
            if (randomint(100) < 50 && isdefined(self.parasiteenemy) && distance2dsquared(self.origin, self.parasiteenemy.origin) < 64 * 64) {
                self.parasiteenemy dodamage(self.settings.meleedamage, self.parasiteenemy.origin, self);
            } else {
                self fire_pod_logic(self.lasttimejuked);
            }
            continue;
        }
        if (randomint(100) < 30) {
            self fire_pod_logic(self.lasttimejuked);
        }
    }
}

// Namespace parasite/parasite
// Params 1, eflags: 0x0
// Checksum 0x53819e0f, Offset: 0x1570
// Size: 0x2f4
function fire_pod_logic(chosetojuke) {
    if (isdefined(self.parasiteenemy) && self cansee(self.parasiteenemy) && distance2dsquared(self.parasiteenemy.origin, self.origin) < 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3 * 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3) {
        self asmrequestsubstate("fire@stationary");
        self playsound("zmb_vocals_parasite_preattack");
        self clientfield::set("parasite_tell_fx", 1);
        self waittill("pre_fire");
        if (isdefined(self.parasiteenemy) && self cansee(self.parasiteenemy) && distance2dsquared(self.parasiteenemy.origin, self.origin) < 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3 * 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3) {
            self turretsettarget(0, self.parasiteenemy, self.parasiteenemy getvelocity() * 0.3);
        }
        self vehicle_ai::waittill_asm_complete("fire@stationary", 5);
        self asmrequestsubstate("locomotion@movement");
        self clientfield::set("parasite_tell_fx", 0);
        if (!chosetojuke) {
            wait randomfloatrange(0.25, 0.5);
        }
        return;
    }
    wait randomfloatrange(1, 2);
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0x689d673f, Offset: 0x1870
// Size: 0x736
function getnextmoveposition_tactical() {
    self endon(#"change_state");
    self endon(#"death");
    selfdisttotarget = distance2d(self.origin, self.parasiteenemy.origin);
    gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
    preferedheightrange = 0.5 * (self.settings.engagementheightmax - self.settings.engagementheightmin);
    randomness = 30;
    queryresult = positionquery_source_navigation(self.origin, 75, 225 * querymultiplier, 75, 20 * querymultiplier, self, 20 * querymultiplier);
    if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav)) {
        self.vehaircraftcollisionenabled = 0;
    } else {
        self.vehaircraftcollisionenabled = 1;
    }
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.parasiteenemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    goalheight = self.parasiteenemy.origin[2] + 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
    best_point = undefined;
    best_score = -999999;
    trace_count = 0;
    foreach (point in queryresult.data) {
        if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav)) {
            if (sighttracepassed(self.origin, point.origin, 0, undefined)) {
                trace_count++;
                if (trace_count > 3) {
                    waitframe(1);
                    trace_count = 0;
                }
                if (!bullettracepassed(self.origin, point.origin, 0, self)) {
                    continue;
                }
            } else {
                continue;
            }
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = randomfloatrange(0, randomness);
        #/
        point.score += randomfloatrange(0, randomness);
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x2f>"] = point.distawayfromengagementarea * -1;
        #/
        point.score += point.distawayfromengagementarea * -1;
        distfrompreferredheight = abs(point.origin[2] - goalheight);
        if (distfrompreferredheight > preferedheightrange) {
            heightscore = mapfloat(0, 500, 0, 2000, distfrompreferredheight);
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x3e>"] = heightscore * -1;
            #/
            point.score += heightscore * -1;
        }
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        if (isdefined(getdvarint("<dev string:x45>")) && getdvarint("<dev string:x45>")) {
            recordline(self.origin, best_point.origin, (0.3, 1, 0));
            recordline(self.origin, self.parasiteenemy.origin, (1, 0, 0.4));
        }
    #/
    returndata = [];
    returndata["origin"] = isdefined(best_point) ? best_point.origin : undefined;
    returndata["centerOnNav"] = queryresult.centeronnav;
    return returndata;
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0x8a2c8ec5, Offset: 0x1fb0
// Size: 0x736
function getnextmoveposition_forwardjuke() {
    self endon(#"change_state");
    self endon(#"death");
    selfdisttotarget = distance2d(self.origin, self.parasiteenemy.origin);
    gooddist = 0.5 * (self.settings.forwardjukeengagementdistmin + self.settings.forwardjukeengagementdistmax);
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
    preferedheightrange = 0.5 * (self.settings.forwardjukeengagementheightmax - self.settings.forwardjukeengagementheightmin);
    randomness = 30;
    queryresult = positionquery_source_navigation(self.origin, 75, 300 * querymultiplier, 75, 20 * querymultiplier, self, 20 * querymultiplier);
    if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav)) {
        self.vehaircraftcollisionenabled = 0;
    } else {
        self.vehaircraftcollisionenabled = 1;
    }
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.parasiteenemy, self.settings.forwardjukeengagementdistmin, self.settings.forwardjukeengagementdistmax);
    goalheight = self.parasiteenemy.origin[2] + 0.5 * (self.settings.forwardjukeengagementheightmin + self.settings.forwardjukeengagementheightmax);
    best_point = undefined;
    best_score = -999999;
    trace_count = 0;
    foreach (point in queryresult.data) {
        if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav)) {
            if (sighttracepassed(self.origin, point.origin, 0, undefined)) {
                trace_count++;
                if (trace_count > 3) {
                    waitframe(1);
                    trace_count = 0;
                }
                if (!bullettracepassed(self.origin, point.origin, 0, self)) {
                    continue;
                }
            } else {
                continue;
            }
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = randomfloatrange(0, randomness);
        #/
        point.score += randomfloatrange(0, randomness);
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x2f>"] = point.distawayfromengagementarea * -1;
        #/
        point.score += point.distawayfromengagementarea * -1;
        distfrompreferredheight = abs(point.origin[2] - goalheight);
        if (distfrompreferredheight > preferedheightrange) {
            heightscore = mapfloat(0, 500, 0, 2000, distfrompreferredheight);
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x3e>"] = heightscore * -1;
            #/
            point.score += heightscore * -1;
        }
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        if (isdefined(getdvarint("<dev string:x45>")) && getdvarint("<dev string:x45>")) {
            recordline(self.origin, best_point.origin, (0.3, 1, 0));
            recordline(self.origin, self.parasiteenemy.origin, (1, 0, 0.4));
        }
    #/
    returndata = [];
    returndata["origin"] = isdefined(best_point) ? best_point.origin : undefined;
    returndata["centerOnNav"] = queryresult.centeronnav;
    return returndata;
}

// Namespace parasite/parasite
// Params 0, eflags: 0x0
// Checksum 0x60c11a92, Offset: 0x26f0
// Size: 0xc0
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    wait 1;
    while (true) {
        if (isdefined(self.current_pathto_pos)) {
            if (distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius) {
                wait 0.2;
                self._override_juke = 1;
                self notify(#"near_goal");
            }
        }
        wait 0.2;
    }
}

// Namespace parasite/parasite
// Params 3, eflags: 0x0
// Checksum 0x5683cc86, Offset: 0x27b8
// Size: 0x1e8
function drone_pain_for_time(time, stablizeparam, restorelookpoint) {
    self endon(#"death");
    self.painstarttime = gettime();
    if (!(isdefined(self.inpain) && self.inpain)) {
        self.inpain = 1;
        self playsound("zmb_vocals_parasite_pain");
        while (gettime() < self.painstarttime + time * 1000) {
            self setvehvelocity(self.velocity * stablizeparam);
            self setangularvelocity(self getangularvelocity() * stablizeparam);
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

// Namespace parasite/parasite
// Params 6, eflags: 0x0
// Checksum 0xbc818e70, Offset: 0x29a8
// Size: 0x12c
function drone_pain(eattacker, damagetype, hitpoint, hitdirection, hitlocationinfo, partname) {
    if (!(isdefined(self.inpain) && self.inpain)) {
        yaw_vel = math::randomsign() * randomfloatrange(280, 320);
        ang_vel = self getangularvelocity();
        ang_vel += (randomfloatrange(-120, -100), yaw_vel, randomfloatrange(-200, 200));
        self setangularvelocity(ang_vel);
        self thread drone_pain_for_time(0.8, 0.7);
    }
}

