#using scripts/core_common/ai/blackboard_vehicle;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/array_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;

#namespace truck;

// Namespace truck/namespace_7a35ca30
// Params 0, eflags: 0x2
// Checksum 0x6092bd43, Offset: 0x290
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("sentiotruck", &__init__, undefined, undefined);
}

// Namespace truck/namespace_7a35ca30
// Params 0, eflags: 0x0
// Checksum 0x351d6022, Offset: 0x2d0
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("sentiotruck", &function_4f8e7942);
}

// Namespace truck/namespace_7a35ca30
// Params 0, eflags: 0x0
// Checksum 0xf2bf8a76, Offset: 0x308
// Size: 0x1f4
function function_4f8e7942() {
    self useanimtree(#generic);
    vehicle::make_targetable(self);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(200);
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 1;
    /#
        assert(isdefined(self.scriptbundlesettings));
    #/
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 999999;
    self.goalheight = 512;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.delete_on_death = 0;
    self.overridevehicledamage = &function_6b68f036;
    self thread vehicle_ai::nudge_collision();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    defaultrole();
}

// Namespace truck/namespace_7a35ca30
// Params 0, eflags: 0x0
// Checksum 0xb46b3151, Offset: 0x508
// Size: 0x74
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::startinitialstate("combat");
}

// Namespace truck/namespace_7a35ca30
// Params 1, eflags: 0x0
// Checksum 0x421186a7, Offset: 0x588
// Size: 0x186
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    self thread function_3a94fda4();
    for (;;) {
        self setspeed(self.settings.defaultmovespeed);
        goalpos = function_74a74c91();
        if (distance2dsquared(goalpos, self.origin) > 200 * 200 || isdefined(goalpos) && abs(goalpos[2] - self.origin[2]) > self.height) {
            self setspeed(self.settings.defaultmovespeed, 5, 5);
            self setvehgoalpos(goalpos, 0, 1);
            self.current_pathto_pos = goalpos;
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
        }
        waitframe(1);
    }
}

// Namespace truck/namespace_7a35ca30
// Params 0, eflags: 0x0
// Checksum 0x902bbcb4, Offset: 0x718
// Size: 0x178
function function_3a94fda4() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_eda479de");
    self endon(#"hash_eda479de");
    wait 0.2;
    while (true) {
        enemy = self.enemy;
        if (isdefined(enemy) && self cansee(enemy)) {
            self turretsettarget(1, enemy, (0, 0, 0));
            self vehicle_ai::fire_for_time(randomfloatrange(0.75, 1.5), 1);
            if (isdefined(enemy) && isai(enemy)) {
                wait randomfloatrange(0.2, 0.4);
            } else {
                wait randomfloatrange(0.4, 0.7);
            }
            continue;
        }
        self turretcleartarget(1);
        wait 0.4;
    }
}

// Namespace truck/namespace_7a35ca30
// Params 0, eflags: 0x0
// Checksum 0x9157fefc, Offset: 0x898
// Size: 0x20c
function function_74a74c91() {
    goalpos = undefined;
    if (self.goalforced) {
        goalpos = getclosestpointonnavmesh(self.goalpos, self.radius * 2, self.radius);
    } else if (isdefined(self.enemy)) {
        forwarddir = anglestoforward(self.angles);
        forwardpoint = self.origin + forwarddir;
        vec_enemy_to_self = vectornormalize(((self.origin - self.enemy.origin)[0], (self.origin - self.enemy.origin)[1], 0));
        engagementdistance = (self.settings.engagementdistmin + self.settings.engagementdistmax) * 0.5;
        var_44367de6 = self.enemy.origin + vec_enemy_to_self * engagementdistance;
        var_5754fe41 = 0.5 * (forwarddir - vec_enemy_to_self) + self.origin;
        goalarray = tacticalquery("sentiotruck_combat", self, self, self.enemy, forwardpoint, var_44367de6, var_5754fe41);
        if (goalarray.size > 0) {
            goalpos = goalarray[0].origin;
        }
        /#
        #/
    }
    return goalpos;
}

// Namespace truck/namespace_7a35ca30
// Params 0, eflags: 0x0
// Checksum 0x2defaa5a, Offset: 0xab0
// Size: 0xb0
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
                self notify(#"near_goal");
            }
        }
        wait 0.2;
    }
}

// Namespace truck/namespace_7a35ca30
// Params 15, eflags: 0x0
// Checksum 0xbb17daf5, Offset: 0xb68
// Size: 0xd4
function function_6b68f036(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    return idamage;
}

