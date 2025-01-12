#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\statemachine_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_e58235eb;

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x2
// Checksum 0x690cae1b, Offset: 0x170
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_60e9e594b4389b03", &__init__, undefined, undefined);
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x0
// Checksum 0x3f32c034, Offset: 0x1b8
// Size: 0x8c
function __init__() {
    vehicle::add_main_callback(#"dust_ball", &function_dd7df908);
    clientfield::register("scriptmover", "towers_boss_dust_ball_fx", 1, getminbitcountfornum(4), "int");
    /#
        level thread update_dvars();
    #/
}

/#

    // Namespace namespace_e58235eb/namespace_e58235eb
    // Params 0, eflags: 0x0
    // Checksum 0xfc1a88fa, Offset: 0x250
    // Size: 0x8
    function update_dvars() {
        
    }

#/

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x0
// Checksum 0x281f5035, Offset: 0x260
// Size: 0xac
function function_dd7df908() {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.var_f85997c8 = 0;
    self useanimtree("generic");
    if (isdefined(self.owner)) {
        self setteam(self.owner.team);
    }
    self setneargoalnotifydist(60);
    defaultrole();
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x0
// Checksum 0x62801ffc, Offset: 0x318
// Size: 0x1d4
function defaultrole() {
    statemachine = self vehicle_ai::init_state_machine_for_role("default");
    statemachine statemachine::add_state("seek", &function_3178e98e, &function_89f500e1, &function_3962ee4e);
    statemachine statemachine::add_state("soul", &function_559e997b, &function_cf5bdb6e, &function_133bd651);
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self val::set(#"dust_ball", "takedamage", 0);
    self.takedamage = 0;
    self vehicle_ai::call_custom_add_state_callbacks();
    self.fxent = spawn("script_model", self.origin);
    self.fxent setmodel("tag_origin");
    self.fxent linkto(self);
    self.fxent clientfield::set("towers_boss_dust_ball_fx", 1);
    vehicle_ai::startinitialstate("seek");
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x0
// Checksum 0x53f00be8, Offset: 0x4f8
// Size: 0x1a
function function_95d6329a() {
    return self.origin + (0, 0, 30);
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0xb5a4bf6f, Offset: 0x520
// Size: 0x56
function waittill_pathing_done(maxtime = 15) {
    self endon(#"death");
    self endon(#"change_state");
    self waittilltimeout(maxtime, #"near_goal");
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x0
// Checksum 0xfaf772c8, Offset: 0x580
// Size: 0x8c
function function_ecb38b08() {
    if (isdefined(self.favoriteenemy)) {
        target_pos = self.favoriteenemy.origin;
    }
    if (isdefined(target_pos)) {
        target_pos_onnavmesh = getclosestpointonnavmesh(target_pos, 20, self.radius, 4194287);
    }
    if (isdefined(target_pos_onnavmesh)) {
        return target_pos_onnavmesh;
    }
    if (isdefined(self.current_pathto_pos)) {
        return self.current_pathto_pos;
    }
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0xbe3a8f1d, Offset: 0x618
// Size: 0x34
function function_559e997b(params) {
    self.fxent clientfield::set("towers_boss_dust_ball_fx", 3);
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0x2ec01726, Offset: 0x658
// Size: 0x128
function function_cf5bdb6e(params) {
    self endon(#"death");
    self setneargoalnotifydist(40);
    while (true) {
        if (!isdefined(self.ai.var_d91827d9)) {
            waitframe(1);
            continue;
        }
        self setspeed(self.settings.var_dd3171f2);
        self setbrake(0);
        self function_3c8dce03(self.ai.var_d91827d9, 1, 1);
        self waittilltimeout(30, #"near_goal");
        if (isdefined(self.fxent)) {
            self.fxent delete();
        }
        self delete();
    }
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0xb590c300, Offset: 0x788
// Size: 0xc
function function_133bd651(params) {
    
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0xbed2f011, Offset: 0x7a0
// Size: 0xc4
function function_3178e98e(params) {
    self.var_7874b0d7 = undefined;
    self.favoriteenemy = undefined;
    self.var_988825b0 = gettime();
    self thread function_e9843235();
    self thread function_5e1a70bf(&function_767a66de, int(self.settings.var_9594bc3f * 1000));
    if (isdefined(self.settings.var_13b1b622)) {
        self playloopsound(self.settings.var_13b1b622);
    }
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0xcc558722, Offset: 0x870
// Size: 0x3a
function function_3962ee4e(params) {
    self stoploopsound();
    self.var_f85997c8 = function_767a66de();
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x0
// Checksum 0x9318f251, Offset: 0x8b8
// Size: 0x26
function function_767a66de() {
    time = self.var_f85997c8 + gettime() - self.var_988825b0;
    return time;
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0x9f5b3a3c, Offset: 0x8e8
// Size: 0x146
function function_89f500e1(params) {
    self endon(#"death");
    self endon(#"change_state");
    for (;;) {
        if (isdefined(self.favoriteenemy)) {
            if (isdefined(self.settings.var_8e86f2d3)) {
                self playloopsound(self.settings.var_8e86f2d3);
            }
            self.current_pathto_pos = self function_ecb38b08();
            if (isdefined(self.current_pathto_pos)) {
                self setspeed(self.settings.var_dd3171f2);
                self setbrake(0);
                self function_3c8dce03(self.current_pathto_pos, 1, 1);
                self waittill_pathing_done(1);
                continue;
            }
        } else {
            self function_8cbc7cc8();
        }
        waitframe(1);
    }
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x0
// Checksum 0x43b9678e, Offset: 0xa38
// Size: 0x276
function function_e9843235() {
    self endon(#"death");
    self endon(#"change_state");
    wait 0.5;
    while (true) {
        enemies = util::function_8260dc36(self.team);
        alltargets = arraysort(enemies, self function_95d6329a(), 1);
        zombiesarray = getaiarchetypearray("zombie");
        zombiesarray = arraycombine(zombiesarray, getaiarchetypearray("catalyst"), 0, 0);
        alltargets = arraycombine(zombiesarray, alltargets, 0, 0);
        foreach (target in alltargets) {
            distsqtotarget = distancesquared(target.origin, self function_95d6329a());
            if (distsqtotarget <= self.settings.damage_radius * self.settings.damage_radius) {
                if (isdefined(target.archetype)) {
                    target zombie_utility::setup_zombie_knockdown(self);
                    target.knockdown_type = "knockdown_shoved";
                    continue;
                }
                target dodamage(self.settings.var_341fa3d2, self.origin, self, self, "", "MOD_IMPACT", 0);
            }
        }
        physicsexplosionsphere(self.origin, 200, 100, 2);
        waitframe(1);
    }
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0xef4c1e3, Offset: 0xcb8
// Size: 0xc0
function function_ba7af07e(target) {
    var_7c564ab5 = getaiarchetypearray(#"dust_ball");
    foreach (dustball in var_7c564ab5) {
        if (dustball == self) {
            continue;
        }
        if (dustball.favoriteenemy === target) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x0
// Checksum 0xbbf44190, Offset: 0xd80
// Size: 0x2ba
function function_8cbc7cc8() {
    self endon(#"death");
    self endon(#"change_state");
    wait 0.5;
    if (isdefined(self.favoriteenemy)) {
        if (util::within_fov(self.origin, self.angles, self.favoriteenemy.origin, 0.939)) {
            distsqtotarget = distancesquared(self.favoriteenemy.origin, self function_95d6329a());
            if (distsqtotarget <= 10000) {
                return;
            }
        }
    }
    enemies = util::function_8260dc36(self.team);
    alltargets = arraysort(enemies, self function_95d6329a(), 1);
    foreach (target in alltargets) {
        angles = self.angles;
        if (self function_ba7af07e(target)) {
            continue;
        }
        if (util::within_fov(self.origin, angles, target.origin, 0)) {
            self.favoriteenemy = target;
            return;
        }
    }
    foreach (target in alltargets) {
        distsqtotarget = distancesquared(target.origin, self function_95d6329a());
        if (distsqtotarget <= 10000) {
            self.favoriteenemy = target;
            return;
        }
    }
    if (alltargets.size && isdefined(alltargets[0])) {
        self.favoriteenemy = alltargets[0];
    }
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 2, eflags: 0x0
// Checksum 0xb079cd12, Offset: 0x1048
// Size: 0x17e
function function_5e1a70bf(var_163a7e54, max_duration) {
    self endon(#"death");
    self endon(#"change_state");
    for (;;) {
        if (self [[ var_163a7e54 ]]() > max_duration) {
            self vehicle_ai::set_state("death");
        }
        if (isdefined(self.favoriteenemy)) {
            distfromplayer = distancesquared(self.origin, self.favoriteenemy.origin);
            if (distfromplayer < self.settings.var_74984f2a * self.settings.var_74984f2a && !(isdefined(self.var_d78c0414) && self.var_d78c0414)) {
                self.fxent clientfield::set("towers_boss_dust_ball_fx", 2);
                self.var_d78c0414 = 1;
            }
            if (distfromplayer < self.settings.var_889348a1 * self.settings.var_889348a1) {
                self vehicle_ai::set_state("death");
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0xba7d4829, Offset: 0x11d0
// Size: 0x2c
function function_7cfc887d(fxent) {
    wait 0.1;
    fxent delete();
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 1, eflags: 0x0
// Checksum 0x6c448270, Offset: 0x1208
// Size: 0x9c
function state_death_update(params) {
    self.fxent clientfield::set("towers_boss_dust_ball_fx", 0);
    if (isdefined(level.var_17e8f697)) {
        [[ level.var_17e8f697 ]](self);
    }
    vehicle_ai::defaultstate_death_update(params);
    wait 2;
    level thread function_7cfc887d(self.fxent);
    self delete();
}

