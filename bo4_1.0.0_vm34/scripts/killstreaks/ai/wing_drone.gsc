#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;

#namespace wing_drone;

// Namespace wing_drone/wing_drone
// Params 0, eflags: 0x0
// Checksum 0x1c7f3dfe, Offset: 0x108
// Size: 0x4c
function init_shared() {
    if (!isdefined(level.var_497bf165)) {
        level.var_497bf165 = {};
        vehicle::add_main_callback("wing_drone", &function_4080d848);
    }
}

// Namespace wing_drone/wing_drone
// Params 0, eflags: 0x0
// Checksum 0x2047f69c, Offset: 0x160
// Size: 0x184
function function_4080d848() {
    self endon(#"death");
    self useanimtree("generic");
    vehicle::make_targetable(self, (0, 0, 0));
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self setneargoalnotifydist(40);
    self.fovcosine = 0;
    self.fovcosinebusy = 0.574;
    self.vehaircraftcollisionenabled = 1;
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.var_3a335ca = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    self.var_b5d3f230 = self.var_3a335ca * self.var_3a335ca;
    self.vehaircraftcollisionenabled = 0;
    self.ai.var_8f317f8f = gettime();
    defaultrole();
    self laseron();
    self thread monitorleader();
}

// Namespace wing_drone/wing_drone
// Params 0, eflags: 0x0
// Checksum 0x5e10041d, Offset: 0x2f0
// Size: 0xfc
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    vehicle_ai::startinitialstate("combat");
}

// Namespace wing_drone/wing_drone
// Params 0, eflags: 0x0
// Checksum 0x3aa60af, Offset: 0x3f8
// Size: 0x82
function monitorleader() {
    self endon(#"death");
    for (;;) {
        if (isdefined(self.leader)) {
            break;
        }
        waitframe(1);
    }
    for (;;) {
        if (!isdefined(self.leader) || !isalive(self.leader)) {
            self kill();
            break;
        }
        waitframe(1);
    }
}

// Namespace wing_drone/wing_drone
// Params 1, eflags: 0x0
// Checksum 0x632ebdf6, Offset: 0x488
// Size: 0x124
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

// Namespace wing_drone/wing_drone
// Params 1, eflags: 0x0
// Checksum 0x7074e974, Offset: 0x5b8
// Size: 0x34
function state_combat_enter(params) {
    self function_3c8dce03(self.origin, 1, 1);
}

// Namespace wing_drone/wing_drone
// Params 0, eflags: 0x0
// Checksum 0xfd99e3b, Offset: 0x5f8
// Size: 0xfe
function attackthread() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    while (true) {
        enemy = self.enemy;
        if (isdefined(enemy)) {
            self vehlookat(enemy);
            if (self cansee(enemy)) {
                self turretsettarget(0, self.enemy);
                while (!self.turretontarget) {
                    waitframe(1);
                }
                self vehicle_ai::fire_for_time(2 + randomfloat(0.8), undefined, enemy);
            }
        }
        waitframe(1);
    }
}

// Namespace wing_drone/wing_drone
// Params 6, eflags: 0x0
// Checksum 0xb85eed34, Offset: 0x700
// Size: 0x2d6
function function_c8671a1(origin, owner, innerradius, outerradius, halfheight, spacing) {
    queryresult = positionquery_source_navigation(origin, innerradius, outerradius, halfheight, spacing, "navvolume_small", spacing);
    positionquery_filter_sight(queryresult, origin, self geteye() - self.origin, self, 0, owner);
    foreach (point in queryresult.data) {
        if (!point.visibility) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                if (!isdefined(point._scoredebug[#"no visibility"])) {
                    point._scoredebug[#"no visibility"] = spawnstruct();
                }
                point._scoredebug[#"no visibility"].score = -5000;
                point._scoredebug[#"no visibility"].scorename = "<dev string:x30>";
            #/
            point.score += -5000;
        }
    }
    if (queryresult.data.size > 0) {
        vehicle_ai::positionquery_postprocess_sortscore(queryresult);
        self vehicle_ai::positionquery_debugscores(queryresult);
        foreach (point in queryresult.data) {
            if (isdefined(point.origin)) {
                goal = point.origin;
                break;
            }
        }
    }
    return goal;
}

// Namespace wing_drone/wing_drone
// Params 1, eflags: 0x0
// Checksum 0xd1b3c82e, Offset: 0x9e0
// Size: 0x23e
function function_37ba1376(owner) {
    assert(owner);
    protectdest = undefined;
    leader = owner;
    groundpos = getclosestpointonnavmesh(owner.origin, 10000);
    if (isdefined(groundpos)) {
        protectdest = undefined;
        leader_back = anglestoforward(leader.angles) * -1 * 128;
        if (self.formation == "right") {
            var_eadd081c = anglestoright(leader.angles) * 128;
        } else {
            var_eadd081c = anglestoright(leader.angles) * -1 * 128;
        }
        var_ecc6fa9c = leader.origin + leader_back + var_eadd081c;
        goalpos = self getclosestpointonnavvolume(var_ecc6fa9c, 2000);
        self.var_963db8db = groundpos;
        pos = groundpos + (0, 0, randomintrange(150, 275));
        pos = getclosestpointonnavvolume(pos, "navvolume_small", 2000);
        if (isdefined(pos)) {
            var_db0aed8f = distance(self.origin, pos);
            if (var_db0aed8f > 128) {
                protectdest = function_c8671a1(pos, self.owner, 64, 128, 48, 48);
                self.protectdest = protectdest;
            }
        }
    }
    return protectdest;
}

// Namespace wing_drone/wing_drone
// Params 1, eflags: 0x0
// Checksum 0x29f2160e, Offset: 0xc28
// Size: 0x47a
function function_19c48c1c(leader) {
    assert(isdefined(leader));
    distsq = distancesquared(self.origin, self.leader.origin);
    if (distsq <= 128 * 128) {
        return undefined;
    }
    protectdest = undefined;
    leader_back = anglestoforward(leader.angles) * -1 * 128;
    if (self.formation == "right") {
        var_eadd081c = anglestoright(leader.angles) * 128;
    } else {
        var_eadd081c = anglestoright(leader.angles) * -1 * 128;
    }
    var_ecc6fa9c = leader.origin + leader_back + var_eadd081c;
    groundpos = getclosestpointonnavmesh(var_ecc6fa9c, 10000);
    if (isdefined(groundpos)) {
        self.var_963db8db = groundpos;
        groundpos += (0, 0, randomintrange(150, 275));
        goalpos = getclosestpointonnavvolume(groundpos, "navvolume_small", 2000);
    }
    if (isdefined(goalpos)) {
        queryresult = positionquery_source_navigation(goalpos, 64, 128, 48, 48, "navvolume_small", 48);
        positionquery_filter_sight(queryresult, goalpos, self geteye() - self.origin, self, 0, leader);
        foreach (point in queryresult.data) {
            if (!point.visibility) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    if (!isdefined(point._scoredebug[#"no visibility"])) {
                        point._scoredebug[#"no visibility"] = spawnstruct();
                    }
                    point._scoredebug[#"no visibility"].score = -5000;
                    point._scoredebug[#"no visibility"].scorename = "<dev string:x30>";
                #/
                point.score += -5000;
            }
        }
        if (queryresult.data.size > 0) {
            vehicle_ai::positionquery_postprocess_sortscore(queryresult);
            self vehicle_ai::positionquery_debugscores(queryresult);
            foreach (point in queryresult.data) {
                if (isdefined(point.origin)) {
                    protectdest = point.origin;
                    break;
                }
            }
        }
    }
    self.protectdest = protectdest;
    return protectdest;
}

// Namespace wing_drone/wing_drone
// Params 0, eflags: 0x0
// Checksum 0xf1ecad5a, Offset: 0x10b0
// Size: 0xd6
function function_6c28c4f() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.protectdest)) {
            /#
                recordsphere(self.protectdest, 8, (0, 1, 1), "<dev string:x3e>");
            #/
            if (isdefined(self.var_963db8db)) {
                /#
                    recordsphere(self.protectdest, 8, (1, 1, 0), "<dev string:x3e>");
                    recordline(self.protectdest, self.var_963db8db, (0, 1, 0), "<dev string:x3e>");
                #/
            }
        }
        waitframe(1);
    }
}

// Namespace wing_drone/wing_drone
// Params 1, eflags: 0x0
// Checksum 0x459985ef, Offset: 0x1190
// Size: 0x19e
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    self thread function_6c28c4f();
    self thread attackthread();
    for (;;) {
        if (!ispointinnavvolume(self.origin, "navvolume_small")) {
            var_15a21163 = getclosestpointonnavvolume(self.origin, "navvolume_small", 2000);
            if (isdefined(var_15a21163)) {
                self.origin = var_15a21163;
            }
        }
        protectdest = self.origin;
        if (isdefined(self.leader)) {
            protectdest = function_19c48c1c(self.leader);
        } else if (isdefined(self.owner)) {
            protectdest = function_37ba1376(self.owner);
        }
        if (isdefined(protectdest) && self function_3c8dce03(protectdest, 1, 1)) {
            self waittilltimeout(15, #"near_goal");
        } else {
            self function_3c8dce03(self.origin, 1, 1);
        }
        waitframe(1);
    }
}

// Namespace wing_drone/wing_drone
// Params 1, eflags: 0x0
// Checksum 0x5d9eeca1, Offset: 0x1338
// Size: 0x44
function state_combat_exit(params) {
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self turretcleartarget(0);
}

// Namespace wing_drone/wing_drone
// Params 15, eflags: 0x0
// Checksum 0x9c510225, Offset: 0x1388
// Size: 0xce
function function_d06f19d5(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    emp_damage = self.healthdefault * 0.5 + 0.5;
    self.damagetaken += idamage;
    return idamage;
}

