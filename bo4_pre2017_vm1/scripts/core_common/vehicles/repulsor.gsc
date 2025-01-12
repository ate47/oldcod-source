#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;

#namespace repulsor;

// Namespace repulsor/repulsor
// Params 0, eflags: 0x2
// Checksum 0x7d3bc6b6, Offset: 0x368
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("repulsor", &__init__, undefined, undefined);
}

// Namespace repulsor/repulsor
// Params 1, eflags: 0x0
// Checksum 0x3700619, Offset: 0x3a8
// Size: 0x24
function guard(target) {
    self vehicle_ai::airfollow(target);
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x0
// Checksum 0x1ac666f4, Offset: 0x3d8
// Size: 0x5c
function __init__() {
    vehicle::add_main_callback("repulsor", &function_1f003b2c);
    clientfield::register("vehicle", "pulse_fx", 1, 1, "counter");
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x0
// Checksum 0x38885d40, Offset: 0x440
// Size: 0x20c
function function_1f003b2c() {
    self useanimtree(#generic);
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(40);
    self sethoverparams(50, 100, 100);
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 1;
    /#
        assert(isdefined(self.scriptbundlesettings));
    #/
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 999999;
    self.goalheight = 999999;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.overridevehicledamage = &drone_callback_damage;
    self.allowfriendlyfiredamageoverride = &drone_allowfriendlyfiredamage;
    self.attackeraccuracy = 0.5;
    self thread vehicle_ai::nudge_collision();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    self.lastdamagetime = 0;
    function_d8a5e619();
    defaultrole();
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x0
// Checksum 0x42e1bc17, Offset: 0x658
// Size: 0x9c
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_guard_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    vehicle_ai::startinitialstate("combat");
}

// Namespace repulsor/repulsor
// Params 1, eflags: 0x0
// Checksum 0xbf22405f, Offset: 0x700
// Size: 0x3dc
function state_death_update(params) {
    self endon(#"death");
    function_dd8d3882();
    if (isarray(self.followers)) {
        foreach (follower in self.followers) {
            if (isdefined(follower)) {
                follower.leader = undefined;
            }
        }
    }
    self.off = 1;
    death_type = vehicle_ai::get_death_type(params);
    if (!isdefined(death_type) && isdefined(params)) {
        if (isdefined(params.weapon)) {
            if (params.weapon.doannihilate) {
                death_type = "gibbed";
            } else if (params.weapon.dogibbing && isdefined(params.attacker)) {
                dist = distance(self.origin, params.attacker.origin);
                if (dist < params.weapon.maxgibdistance) {
                    gib_chance = 1 - dist / params.weapon.maxgibdistance;
                    if (randomfloatrange(0, 2) < gib_chance) {
                        death_type = "gibbed";
                    }
                }
            }
        }
        if (isdefined(params.meansofdeath)) {
            meansofdeath = params.meansofdeath;
            if (meansofdeath === "MOD_EXPLOSIVE" || meansofdeath === "MOD_GRENADE_SPLASH" || meansofdeath === "MOD_PROJECTILE_SPLASH" || meansofdeath === "MOD_PROJECTILE") {
                death_type = "gibbed";
            }
        }
    }
    if (!isdefined(death_type)) {
        crash_style = randomint(3);
        switch (crash_style) {
        case 0:
            if (self.hijacked === 1) {
                params.death_type = "gibbed";
                vehicle_ai::defaultstate_death_update(params);
            } else {
                vehicle_death::barrel_rolling_crash();
            }
            break;
        case 1:
            vehicle_death::plane_crash();
            break;
        default:
            vehicle_death::random_crash(params.vdir);
            break;
        }
        self vehicle_death::deletewhensafe();
        return;
    }
    params.death_type = death_type;
    vehicle_ai::defaultstate_death_update(params);
}

/#

    // Namespace repulsor/repulsor
    // Params 0, eflags: 0x0
    // Checksum 0x4a477e92, Offset: 0xae8
    // Size: 0x114
    function guard_points_debug() {
        self endon(#"death");
        if (self.isdebugdrawing === 1) {
            return;
        }
        self.isdebugdrawing = 1;
        while (true) {
            foreach (point in self.debugpointsarray) {
                color = (1, 0, 0);
                if (ispointinnavvolume(point, "<dev string:x28>")) {
                    color = (0, 1, 0);
                }
                debugstar(point, 5, color);
            }
            waitframe(1);
        }
    }

#/

// Namespace repulsor/repulsor
// Params 1, eflags: 0x0
// Checksum 0x1cf7b38c, Offset: 0xc08
// Size: 0x38e
function get_guard_points(owner) {
    /#
        assert(self._guard_points.size > 0, "<dev string:x38>");
    #/
    points_array = [];
    foreach (point in self._guard_points) {
        offset = rotatepoint(point, owner.angles);
        worldpoint = offset + owner.origin + owner getvelocity() * 0.5;
        if (ispointinnavvolume(worldpoint, "navvolume_small")) {
            if (!isdefined(points_array)) {
                points_array = [];
            } else if (!isarray(points_array)) {
                points_array = array(points_array);
            }
            points_array[points_array.size] = worldpoint;
        }
    }
    if (points_array.size < 1) {
        queryresult = positionquery_source_navigation(owner.origin + (0, 0, 50), 25, 200, 100, 1.2 * self.radius, self);
        positionquery_filter_sight(queryresult, owner.origin + (0, 0, 10), (0, 0, 0), self, 3);
        foreach (point in queryresult.data) {
            if (point.visibility === 1 && bullettracepassed(owner.origin + (0, 0, 10), point.origin, 0, self, self, 0, 1)) {
                if (!isdefined(points_array)) {
                    points_array = [];
                } else if (!isarray(points_array)) {
                    points_array = array(points_array);
                }
                points_array[points_array.size] = point.origin;
            }
        }
    }
    return points_array;
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x0
// Checksum 0xe8badf21, Offset: 0xfa0
// Size: 0x15e
function function_dbe26b0() {
    if (isalive(self.host)) {
        return;
    }
    aiarray = getaiteamarray(self.team);
    aiarray = arraysort(aiarray, self.origin, 1);
    for (i = 0; i < aiarray.size; i++) {
        friend = aiarray[i];
        if (friend !== self && !vehicle_ai::entityisarchetype(friend, "repulsor") && isalive(friend)) {
            if (self cansee(friend)) {
                guard(friend);
                break;
            }
            if (!isalive(self.host)) {
                guard(friend);
            }
        }
    }
}

// Namespace repulsor/repulsor
// Params 1, eflags: 0x0
// Checksum 0x7b5270ff, Offset: 0x1108
// Size: 0x6c
function test_get_back_point(point) {
    if (sighttracepassed(self.origin, point, 0, self)) {
        if (bullettracepassed(self.origin, point, 0, self, self, 0, 1)) {
            return 1;
        }
        return 0;
    }
    return -1;
}

// Namespace repulsor/repulsor
// Params 1, eflags: 0x0
// Checksum 0x5fc64880, Offset: 0x1180
// Size: 0xf2
function test_get_back_queryresult(queryresult) {
    getbackpoint = undefined;
    foreach (point in queryresult.data) {
        testresult = test_get_back_point(point.origin);
        if (testresult == 1) {
            return point.origin;
        }
        if (testresult == 0) {
            waitframe(1);
        }
    }
    return undefined;
}

// Namespace repulsor/repulsor
// Params 1, eflags: 0x0
// Checksum 0x97c39d4c, Offset: 0x1280
// Size: 0x720
function state_guard_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self sethoverparams(20, 40, 30);
    wait 0.1;
    self clientfield::increment("pulse_fx", 1);
    timenotatgoal = gettime();
    pointindex = 0;
    stuckcount = 0;
    while (true) {
        function_dbe26b0();
        if (!isalive(self.host)) {
            wait 0.5;
            continue;
        }
        owner = self.host;
        if (!isdefined(owner)) {
            wait 1;
            continue;
        }
        usepathfinding = 1;
        onnavvolume = ispointinnavvolume(self.origin, "navvolume_small");
        if (!onnavvolume) {
            getbackpoint = undefined;
            pointonnavvolume = self getclosestpointonnavvolume(self.origin, 500);
            if (isdefined(pointonnavvolume)) {
                if (test_get_back_point(pointonnavvolume) == 1) {
                    getbackpoint = pointonnavvolume;
                }
            }
            if (!isdefined(getbackpoint)) {
                queryresult = positionquery_source_navigation(self.origin, 0, 1500, 200, 80, self);
                getbackpoint = test_get_back_queryresult(queryresult);
            }
            if (!isdefined(getbackpoint)) {
                queryresult = positionquery_source_navigation(self.origin, 0, 300, 700, 30, self);
                getbackpoint = test_get_back_queryresult(queryresult);
            }
            if (isdefined(getbackpoint)) {
                if (distancesquared(getbackpoint, self.origin) > 20 * 20) {
                    self.current_pathto_pos = getbackpoint;
                    usepathfinding = 0;
                    self.vehaircraftcollisionenabled = 0;
                } else {
                    onnavvolume = 1;
                }
            } else {
                stuckcount++;
                if (stuckcount == 1) {
                    stucklocation = self.origin;
                } else if (stuckcount > 10) {
                    /#
                        v_box_min = (self.radius * -1, self.radius * -1, self.radius * -1);
                        v_box_max = (self.radius, self.radius, self.radius);
                        box(self.origin, v_box_min, v_box_max, self.angles[1], (1, 0, 0), 1, 0, 1000000);
                        if (isdefined(stucklocation)) {
                            line(stucklocation, self.origin, (1, 0, 0), 1, 1, 1000000);
                        }
                    #/
                    self kill();
                    wait 0.5;
                    continue;
                }
            }
        }
        var_5d2d35ad = undefined;
        if (onnavvolume) {
            self.vehaircraftcollisionenabled = 1;
            var_5d2d35ad = self vehicle_ai::getairfollowingposition(1);
        }
        if (isdefined(var_5d2d35ad)) {
            if (vehicle_ai::timesince(self.lastdamagetime) < 1.5) {
                if (!isdefined(self.var_4923c36b)) {
                    self.var_4923c36b = math::point_on_sphere_even_distribution(100, randomint(80), 100);
                }
                self.current_pathto_pos = self getclosestpointonnavvolume(var_5d2d35ad + 100 * self.var_4923c36b, 60);
                if (!isdefined(self.current_pathto_pos)) {
                    self.current_pathto_pos = var_5d2d35ad;
                }
            } else {
                self.var_4923c36b = undefined;
                self.current_pathto_pos = var_5d2d35ad;
            }
        }
        if (isdefined(self.current_pathto_pos)) {
            distancetogoalsq = distancesquared(self.current_pathto_pos, self.origin);
            if (!onnavvolume || distancetogoalsq > 60 * 60) {
                if (distancetogoalsq > 500 * 500) {
                    self setspeed(self.settings.defaultmovespeed * 2);
                } else {
                    self setspeed(self.settings.defaultmovespeed);
                }
                timenotatgoal = gettime();
            } else {
                wait 0.2;
                continue;
            }
            if (self setvehgoalpos(self.current_pathto_pos, 1, usepathfinding)) {
                self playsound("veh_repulsor_direction");
                self vehclearlookat();
                self notify(#"fire_stop");
                self thread path_update_interrupt();
                if (onnavvolume) {
                    self vehicle_ai::waittill_pathing_done(1);
                } else {
                    self vehicle_ai::waittill_pathing_done();
                }
            } else {
                wait 0.5;
            }
            continue;
        }
        wait 0.5;
    }
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x0
// Checksum 0xd9952632, Offset: 0x19a8
// Size: 0xd8
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    wait 1;
    while (true) {
        if (isdefined(self.host)) {
            length = vehicle_ai::getairfollowinglength(self.host);
            if (distance2dsquared(self.current_pathto_pos, self vehicle_ai::getairfollowingorigin()) > length * length) {
                wait 0.2;
                self notify(#"near_goal");
            }
        }
        wait 0.2;
    }
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x0
// Checksum 0x343fe9e, Offset: 0x1a88
// Size: 0xf8
function function_4d94f2a0() {
    self notify(#"hash_d27732d2");
    self endon(#"hash_d27732d2");
    self endon(#"death");
    while (true) {
        self waittill("projectile_applyattractor", "play_meleefx");
        if (vehicle_ai::iscooldownready("repulsorfx_interval")) {
            playfxontag(self.settings.var_27def451, self, "tag_origin");
            self clientfield::increment("pulse_fx", 1);
            vehicle_ai::cooldown("repulsorfx_interval", 0.5);
            self playsound("wpn_quadtank_shield_impact");
        }
    }
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x0
// Checksum 0x62c1759d, Offset: 0x1b88
// Size: 0x64
function function_d8a5e619() {
    if (!isdefined(self.var_3ab5b78c)) {
        self.var_3ab5b78c = missile_createrepulsorent(self, 40000, self.settings.var_316e3dc7, 1);
    }
    self thread function_4d94f2a0();
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x0
// Checksum 0x154aa8c4, Offset: 0x1bf8
// Size: 0x42
function function_dd8d3882() {
    if (isdefined(self.var_3ab5b78c)) {
        missile_deleteattractor(self.var_3ab5b78c);
        self.var_3ab5b78c = undefined;
    }
    self notify(#"hash_d27732d2");
}

// Namespace repulsor/repulsor
// Params 15, eflags: 0x0
// Checksum 0x6005f783, Offset: 0x1c48
// Size: 0x164
function drone_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    if (smeansofdeath === "MOD_GRENADE" && smeansofdeath === "MOD_GRENADE_SPLASH" && smeansofdeath === "MOD_PROJECTILE" && smeansofdeath === "MOD_PROJECTILE_SPLASH" && smeansofdeath === "MOD_EXPLOSIVE" && smeansofdeath === "MOD_IMPACT" && smeansofdeath === "MOD_ELECTROCUTED" && smeansofdeath === "MOD_GAS") {
        return 0;
    }
    self.lastdamagetime = gettime();
    return idamage;
}

// Namespace repulsor/repulsor
// Params 4, eflags: 0x0
// Checksum 0x7bf0e665, Offset: 0x1db8
// Size: 0x7c
function drone_allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
    if (isdefined(eattacker) && isdefined(eattacker.archetype) && isdefined(smeansofdeath) && eattacker.archetype == "repulsor" && smeansofdeath == "MOD_EXPLOSIVE") {
        return true;
    }
    return false;
}

