#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\weapons\heatseekingmissile;

#namespace flak_drone;

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0x3f777601, Offset: 0x1b0
// Size: 0x7c
function init_shared() {
    if (!isdefined(level.var_cc04df33)) {
        level.var_cc04df33 = {};
        clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int");
        vehicle::add_main_callback("veh_flak_drone_mp", &initflakdrone);
    }
}

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0xb7bc403d, Offset: 0x238
// Size: 0x24c
function initflakdrone() {
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(40);
    self sethoverparams(50, 75, 100);
    self setvehicleavoidance(1);
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 1;
    self.goalradius = 999999;
    self.goalheight = 999999;
    self function_a57c34b7(self.origin);
    self thread vehicle_ai::nudge_collision();
    self.overridevehicledamage = &flakdronedamageoverride;
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("off").enter_func = &state_off_enter;
    self vehicle_ai::get_state_callbacks("off").update_func = &state_off_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::startinitialstate("off");
}

// Namespace flak_drone/flak_drone
// Params 1, eflags: 0x0
// Checksum 0x665444d3, Offset: 0x490
// Size: 0xc
function state_off_enter(*params) {
    
}

// Namespace flak_drone/flak_drone
// Params 1, eflags: 0x0
// Checksum 0x46cf5190, Offset: 0x4a8
// Size: 0x430
function state_off_update(*params) {
    self endon(#"change_state", #"death");
    while (!isdefined(self.parent)) {
        wait 0.1;
    }
    self.parent endon(#"death");
    while (true) {
        self setspeed(400);
        if (is_true(self.inpain)) {
            wait 0.1;
        }
        self vehclearlookat();
        self.current_pathto_pos = undefined;
        queryorigin = self.parent.origin + (0, 0, -75);
        queryresult = positionquery_source_navigation(queryorigin, 25, 75, 40, 40, self);
        if (isdefined(queryresult)) {
            positionquery_filter_distancetogoal(queryresult, self);
            vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
            best_point = undefined;
            best_score = -999999;
            foreach (point in queryresult.data) {
                randomscore = randomfloatrange(0, 100);
                disttooriginscore = point.disttoorigin2d * 0.2;
                point.score += randomscore + disttooriginscore;
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    if (!isdefined(point._scoredebug[#"disttoorigin"])) {
                        point._scoredebug[#"disttoorigin"] = spawnstruct();
                    }
                    point._scoredebug[#"disttoorigin"].score = disttooriginscore;
                    point._scoredebug[#"disttoorigin"].scorename = "<dev string:x38>";
                #/
                point.score += disttooriginscore;
                if (point.score > best_score) {
                    best_score = point.score;
                    best_point = point;
                }
            }
            self vehicle_ai::positionquery_debugscores(queryresult);
            if (isdefined(best_point)) {
                self.current_pathto_pos = best_point.origin;
            }
        }
        if (isdefined(self.current_pathto_pos)) {
            self updateflakdronespeed();
            self function_a57c34b7(self.current_pathto_pos);
        } else {
            if (isdefined(self.parent.heligoalpos)) {
                self.current_pathto_pos = self.parent.heligoalpos;
            } else {
                self.current_pathto_pos = queryorigin;
            }
            self updateflakdronespeed();
            self function_a57c34b7(self.current_pathto_pos);
        }
        wait randomfloatrange(0.1, 0.2);
    }
}

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0xd126f2b, Offset: 0x8e0
// Size: 0x164
function updateflakdronespeed() {
    desiredspeed = 400;
    if (isdefined(self.parent)) {
        parentspeed = self.parent getspeed();
        desiredspeed = parentspeed * 0.9;
        if (distance2dsquared(self.parent.origin, self.origin) > sqr(36)) {
            if (isdefined(self.current_pathto_pos)) {
                flakdronedistancetogoalsquared = distance2dsquared(self.origin, self.current_pathto_pos);
                parentdistancetogoalsquared = distance2dsquared(self.parent.origin, self.current_pathto_pos);
                if (flakdronedistancetogoalsquared > parentdistancetogoalsquared) {
                    desiredspeed = parentspeed * 1.3;
                } else {
                    desiredspeed = parentspeed * 0.8;
                }
            }
        }
    }
    self setspeed(max(desiredspeed, 10));
}

// Namespace flak_drone/flak_drone
// Params 1, eflags: 0x0
// Checksum 0xf1fe450f, Offset: 0xa50
// Size: 0xc
function state_combat_enter(*params) {
    
}

// Namespace flak_drone/flak_drone
// Params 1, eflags: 0x0
// Checksum 0x7d962853, Offset: 0xa68
// Size: 0x8c
function state_combat_update(*params) {
    drone = self;
    drone endon(#"change_state", #"death");
    drone thread spawnflakrocket(drone.incoming_missile, drone.origin, drone.parent);
    drone ghost();
}

// Namespace flak_drone/flak_drone
// Params 3, eflags: 0x0
// Checksum 0xa0bcacc6, Offset: 0xb00
// Size: 0x502
function spawnflakrocket(missile, spawnpos, parent) {
    drone = self;
    missile endon(#"death");
    missile missile_settarget(parent);
    rocket = magicbullet(getweapon(#"flak_drone_rocket"), spawnpos, missile.origin, parent, missile);
    rocket.team = parent.team;
    rocket setteam(parent.team);
    rocket clientfield::set("enemyvehicle", 1);
    rocket missile_settarget(missile);
    missile thread cleanupaftermissiledeath(rocket, drone);
    curdist = distance(missile.origin, rocket.origin);
    tooclosetopredictedparent = 0;
    /#
        debug_draw = getdvarint(#"scr_flak_drone_debug_trails", 0);
        debug_duration = getdvarint(#"scr_flak_drone_debug_trails_duration", 400);
    #/
    while (true) {
        waitframe(1);
        prevdist = curdist;
        if (isdefined(rocket)) {
            curdist = distance(missile.origin, rocket.origin);
            distdelta = prevdist - curdist;
            predicteddist = curdist - distdelta;
        }
        /#
            if (debug_draw && isdefined(missile)) {
                util::debug_sphere(missile.origin, 6, (0.9, 0, 0), 0.9, debug_duration);
            }
            if (debug_draw && isdefined(rocket)) {
                util::debug_sphere(rocket.origin, 6, (0, 0, 0.9), 0.9, debug_duration);
            }
        #/
        if (isdefined(parent)) {
            parentvelocity = parent getvelocity();
            parentpredictedlocation = parent.origin + parentvelocity * 0.05;
            missilevelocity = missile getvelocity();
            missilepredictedlocation = missile.origin + missilevelocity * 0.05;
            if (distancesquared(parentpredictedlocation, missilepredictedlocation) < sqr(1000) || distancesquared(parent.origin, missilepredictedlocation) < sqr(1000)) {
                tooclosetopredictedparent = 1;
            }
        }
        if (predicteddist < 0 || curdist > prevdist || tooclosetopredictedparent || !isdefined(rocket)) {
            /#
                if (debug_draw && isdefined(parent)) {
                    if (tooclosetopredictedparent && !(predicteddist < 0 || curdist > prevdist)) {
                        util::debug_sphere(parent.origin, 18, (0.9, 0, 0.9), 0.9, debug_duration);
                    } else {
                        util::debug_sphere(parent.origin, 18, (0, 0.9, 0), 0.9, debug_duration);
                    }
                }
            #/
            if (isdefined(rocket)) {
                rocket detonate();
            }
            missile thread heatseekingmissile::_missiledetonate(missile.target_attacker, missile.target_weapon, missile.target_weapon.explosionradius, 10, 20);
            return;
        }
    }
}

// Namespace flak_drone/flak_drone
// Params 2, eflags: 0x0
// Checksum 0x9c7515ea, Offset: 0x1010
// Size: 0x84
function cleanupaftermissiledeath(rocket, flak_drone) {
    missile = self;
    missile waittill(#"death");
    wait 0.5;
    if (isdefined(rocket)) {
        rocket delete();
    }
    if (isdefined(flak_drone)) {
        flak_drone delete();
    }
}

// Namespace flak_drone/flak_drone
// Params 1, eflags: 0x0
// Checksum 0xad78492, Offset: 0x10a0
// Size: 0x1bc
function state_death_update(params) {
    self endon(#"death");
    dogibbeddeath = 0;
    if (isdefined(self.death_info)) {
        if (isdefined(self.death_info.weapon)) {
            if (self.death_info.weapon.dogibbing || self.death_info.weapon.doannihilate) {
                dogibbeddeath = 1;
            }
        }
        if (isdefined(self.death_info.meansofdeath)) {
            meansofdeath = self.death_info.meansofdeath;
            if (meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_PROJECTILE") {
                dogibbeddeath = 1;
            }
        }
    }
    params = getscriptbundle("killstreak_core");
    if (dogibbeddeath) {
        self playsound(#"veh_wasp_gibbed");
        self ghost();
        self notsolid();
        wait 5;
        if (isdefined(self)) {
            self delete();
        }
        return;
    }
    self vehicle_death::flipping_shooting_death();
}

// Namespace flak_drone/flak_drone
// Params 3, eflags: 0x0
// Checksum 0x4065d9c, Offset: 0x1268
// Size: 0x1e6
function drone_pain_for_time(time, stablizeparam, restorelookpoint) {
    self endon(#"death");
    self.painstarttime = gettime();
    if (!is_true(self.inpain)) {
        self.inpain = 1;
        while (gettime() < self.painstarttime + int(time * 1000)) {
            self setvehvelocity(self.velocity * stablizeparam);
            self setangularvelocity(self getangularvelocity() * stablizeparam);
            wait 0.1;
        }
        if (isdefined(restorelookpoint)) {
            restorelookent = spawn("script_model", restorelookpoint);
            restorelookent setmodel(#"tag_origin");
            self vehclearlookat();
            self vehlookat(restorelookent);
            self turretsettarget(0, restorelookent);
            restorelookent thread util::function_f9af3d43(1.5);
            wait 1.5;
            self vehclearlookat();
            self turretcleartarget(0);
        }
        self.inpain = 0;
    }
}

// Namespace flak_drone/flak_drone
// Params 6, eflags: 0x0
// Checksum 0xd87f23a0, Offset: 0x1458
// Size: 0x12c
function drone_pain(*eattacker, *damagetype, *hitpoint, *hitdirection, *hitlocationinfo, *partname) {
    if (!is_true(self.inpain)) {
        yaw_vel = math::randomsign() * randomfloatrange(280, 320);
        ang_vel = self getangularvelocity();
        ang_vel += (randomfloatrange(-120, -100), yaw_vel, randomfloatrange(-200, 200));
        self setangularvelocity(ang_vel);
        self thread drone_pain_for_time(0.8, 0.7);
    }
}

// Namespace flak_drone/flak_drone
// Params 15, eflags: 0x0
// Checksum 0x169684e6, Offset: 0x1590
// Size: 0xf8
function flakdronedamageoverride(*einflictor, eattacker, idamage, *idflags, smeansofdeath, *weapon, vpoint, vdir, shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, partname, *vsurfacenormal) {
    if (psoffsettime == "MOD_TRIGGER_HURT") {
        return 0;
    }
    if (isdefined(shitloc) && isdefined(shitloc.team) && util::function_fbce7263(shitloc.team, self.team)) {
        drone_pain(shitloc, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    return vdamageorigin;
}

// Namespace flak_drone/flak_drone
// Params 2, eflags: 0x0
// Checksum 0x5f00ac3c, Offset: 0x1690
// Size: 0x130
function spawn(parent, ondeathcallback) {
    if (!isnavvolumeloaded()) {
        /#
            iprintlnbold("<dev string:x48>");
        #/
        return undefined;
    }
    spawnpoint = parent.origin + (0, 0, -50);
    drone = spawnvehicle("veh_flak_drone_mp", spawnpoint, parent.angles, "dynamic_spawn_ai");
    drone.death_callback = ondeathcallback;
    drone configureteam(parent, 0);
    drone thread watchgameevents();
    drone thread watchdeath();
    drone thread watchparentdeath();
    drone thread watchparentmissiles();
    return drone;
}

// Namespace flak_drone/flak_drone
// Params 2, eflags: 0x0
// Checksum 0xc29234ec, Offset: 0x17c8
// Size: 0xb2
function configureteam(parent, ishacked) {
    drone = self;
    drone.team = parent.team;
    drone setteam(parent.team);
    if (ishacked) {
        drone clientfield::set("enemyvehicle", 2);
    } else {
        drone clientfield::set("enemyvehicle", 1);
    }
    drone.parent = parent;
}

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0x2c3122c7, Offset: 0x1888
// Size: 0x9c
function watchgameevents() {
    drone = self;
    drone endon(#"death");
    drone.parent.owner waittill(#"game_ended", #"emp_jammed", #"disconnect", #"joined_team");
    drone shutdown(1);
}

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0x6c686602, Offset: 0x1930
// Size: 0x5c
function watchdeath() {
    drone = self;
    drone.parent endon(#"death");
    drone waittill(#"death");
    drone shutdown(1);
}

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0x7955e1e5, Offset: 0x1998
// Size: 0x64
function watchparentdeath() {
    drone = self;
    drone endon(#"death");
    drone.parent waittill(#"death");
    drone shutdown(1);
}

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x0
// Checksum 0x23a75ee0, Offset: 0x1a08
// Size: 0xcc
function watchparentmissiles() {
    drone = self;
    drone endon(#"death");
    drone.parent endon(#"death");
    waitresult = drone.parent waittill(#"stinger_fired_at_me");
    drone.incoming_missile = waitresult.projectile;
    drone.incoming_missile.target_weapon = waitresult.weapon;
    drone.incoming_missile.target_attacker = waitresult.attacker;
    drone vehicle_ai::set_state("combat");
}

// Namespace flak_drone/flak_drone
// Params 1, eflags: 0x0
// Checksum 0x6e042428, Offset: 0x1ae0
// Size: 0x2c
function setcamostate(state) {
    self clientfield::set("flak_drone_camo", state);
}

// Namespace flak_drone/flak_drone
// Params 1, eflags: 0x0
// Checksum 0xbde9d498, Offset: 0x1b18
// Size: 0x114
function shutdown(explode) {
    drone = self;
    if (isdefined(drone.death_callback)) {
        drone.parent thread [[ drone.death_callback ]]();
    }
    if (isdefined(drone) && !isdefined(drone.parent)) {
        drone ghost();
        drone notsolid();
        wait 5;
        if (isdefined(drone)) {
            drone delete();
        }
    }
    if (isdefined(drone)) {
        if (explode) {
            drone dodamage(drone.health + 1000, drone.origin, drone, drone, "none", "MOD_EXPLOSIVE");
            return;
        }
        drone delete();
    }
}

