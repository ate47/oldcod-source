#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\remote_weapons;

#namespace lead_drone;

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x2
// Checksum 0x7fda3cb, Offset: 0x130
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"lead_drone", &__init__, undefined, undefined);
}

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x0
// Checksum 0x14f2fcd2, Offset: 0x178
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("lead_drone", &function_a36af97d);
}

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x4
// Checksum 0x99fc16f6, Offset: 0x1b0
// Size: 0x184
function private function_a36af97d() {
    self endon(#"death");
    self useanimtree("generic");
    vehicle::make_targetable(self, (0, 0, 0));
    ai::createinterfaceforentity(self);
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
}

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x4
// Checksum 0x7f36b462, Offset: 0x340
// Size: 0x54
function private side_turrets_forward() {
    self turretsettargetangles(1, (10, -90, 0));
    self turretsettargetangles(2, (10, 90, 0));
}

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x0
// Checksum 0x9cb15a5c, Offset: 0x3a0
// Size: 0xf4
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role();
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    vehicle_ai::startinitialstate("combat");
}

// Namespace lead_drone/lead_drone
// Params 1, eflags: 0x0
// Checksum 0x1e8ea76f, Offset: 0x4a0
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

// Namespace lead_drone/lead_drone
// Params 1, eflags: 0x0
// Checksum 0xbebfbd09, Offset: 0x5d0
// Size: 0x34
function state_combat_enter(params) {
    self function_3c8dce03(self.origin, 1, 1);
}

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x0
// Checksum 0x395b936e, Offset: 0x610
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
                self vehicle_ai::fire_for_time(randomfloatrange(2, 4), undefined, enemy);
            }
        }
        waitframe(1);
    }
}

// Namespace lead_drone/lead_drone
// Params 6, eflags: 0x0
// Checksum 0xcf954e78, Offset: 0x718
// Size: 0x2d6
function function_696f14a2(origin, owner, innerradius, outerradius, halfheight, spacing) {
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

// Namespace lead_drone/lead_drone
// Params 1, eflags: 0x0
// Checksum 0x18399444, Offset: 0x9f8
// Size: 0x166
function function_37ba1376(owner) {
    protectdest = undefined;
    if (isdefined(owner)) {
        groundpos = getclosestpointonnavmesh(owner.origin, 10000);
        groundpos += vectorscale(anglestoforward(owner.angles), randomintrange(100, 200));
        if (isdefined(groundpos)) {
            self.var_963db8db = groundpos;
            pos = groundpos + (0, 0, randomintrange(150, 275));
            pos = getclosestpointonnavvolume(pos, "navvolume_small", 2000);
            if (isdefined(pos)) {
                var_db0aed8f = distance(self.origin, pos);
                if (var_db0aed8f > 256) {
                    protectdest = function_696f14a2(pos, self.owner, 32, 256, 48, 48);
                    self.protectdest = protectdest;
                }
            }
        }
    }
    return protectdest;
}

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x0
// Checksum 0x691cedb6, Offset: 0xb68
// Size: 0xce
function function_6c28c4f() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.protectdest)) {
            /#
                recordsphere(self.protectdest, 8, (0, 0, 1), "<dev string:x3e>");
            #/
            if (isdefined(self.var_963db8db)) {
                /#
                    recordsphere(self.protectdest, 8, (0, 1, 0), "<dev string:x3e>");
                    recordline(self.protectdest, self.var_963db8db, (0, 1, 0), "<dev string:x3e>");
                #/
            }
        }
        waitframe(1);
    }
}

// Namespace lead_drone/lead_drone
// Params 1, eflags: 0x0
// Checksum 0x147db081, Offset: 0xc40
// Size: 0x156
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
        protectdest = function_37ba1376(self.owner);
        if (isdefined(protectdest) && self function_3c8dce03(protectdest, 1, 1)) {
            self waittilltimeout(15, #"near_goal");
        } else {
            self function_3c8dce03(self.origin, 1, 1);
        }
        waitframe(1);
    }
}

// Namespace lead_drone/lead_drone
// Params 1, eflags: 0x0
// Checksum 0x95e5c134, Offset: 0xda0
// Size: 0x44
function state_combat_exit(params) {
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self turretcleartarget(0);
}

// Namespace lead_drone/lead_drone
// Params 15, eflags: 0x0
// Checksum 0x28849c5a, Offset: 0xdf0
// Size: 0x142
function function_d06f19d5(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    emp_damage = self.healthdefault * 0.5 + 0.5;
    idamage = killstreaks::ondamageperweapon("drone_squadron", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, &destroyed_cb, self.maxhealth * 0.4, &low_health_cb, emp_damage, undefined, 1, 1);
    self.damagetaken += idamage;
    return idamage;
}

// Namespace lead_drone/lead_drone
// Params 2, eflags: 0x0
// Checksum 0x362121f6, Offset: 0xf40
// Size: 0x14
function destroyed_cb(attacker, weapon) {
    
}

// Namespace lead_drone/lead_drone
// Params 2, eflags: 0x0
// Checksum 0xba770d50, Offset: 0xf60
// Size: 0x5a
function low_health_cb(attacker, weapon) {
    if (self.playeddamaged == 0) {
        self killstreaks::play_pilot_dialog_on_owner("damaged", "drone_squadron", self.killstreak_id);
        self.playeddamaged = 1;
    }
}

