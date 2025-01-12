#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\statemachine_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\smart_bomb;
#using scripts\weapons\arc;

#namespace seeker_mine;

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x2
// Checksum 0xe9bda996, Offset: 0x1a8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"seeker_mine", &__init__, undefined, undefined);
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x1d92111, Offset: 0x1f0
// Size: 0xa4
function __init__() {
    vehicle::add_main_callback("seeker_mine", &function_a2dd32d3);
    clientfield::register("vehicle", "seeker_mine_fx", 1, 1, "int");
    clientfield::register("vehicle", "seeker_mine_light_fx", 1, 1, "int");
    /#
        level thread update_dvars();
    #/
}

/#

    // Namespace seeker_mine/seeker_mine
    // Params 0, eflags: 0x0
    // Checksum 0x8862e235, Offset: 0x2a0
    // Size: 0x4a
    function update_dvars() {
        while (true) {
            wait 1;
            level.var_fe2c6511 = getdvarint(#"hash_6b0c29fe436582f0", 0);
        }
    }

#/

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x1aeac3b5, Offset: 0x2f8
// Size: 0x26c
function function_a2dd32d3() {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.allowfriendlyfiredamageoverride = &smart_bomb::function_b59c9603;
    self.var_f85997c8 = 0;
    self.var_b13f2b64 = 0;
    self.delete_on_death = 1;
    self setplayercollision(0);
    self setavoidancemask("avoid none");
    self useanimtree("generic");
    self thread function_50820888();
    self.overridevehicledamage = &function_85238ecd;
    if (isdefined(self.owner)) {
        self setteam(self.owner.team);
    }
    self setneargoalnotifydist(31);
    defaultrole();
    if (self oob::istouchinganyoobtrigger() && !function_c537d17a()) {
        function_9d24198b();
        return;
    }
    if (!ispointonnavmesh(self.origin)) {
        newpos = getclosestpointonnavmesh(self.origin, 250, 30);
        if (!isdefined(newpos)) {
            function_9d24198b();
            return;
        }
    }
    if (function_868950b3()) {
        tacpoint = getclosesttacpoint(self.origin);
        if (isdefined(tacpoint)) {
            self.origin = tacpoint.origin;
        }
    }
    self thread function_ded2e81();
    self thread targetting_delay::function_3362444f();
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x513fb89d, Offset: 0x570
// Size: 0x15c
function defaultrole() {
    statemachine = self vehicle_ai::init_state_machine_for_role("default");
    statemachine statemachine::add_state("seek", &function_3178e98e, &function_89f500e1, &function_3962ee4e);
    statemachine statemachine::add_state("chase", &state_chase_start, &function_8fc59a55, &function_22f46862);
    statemachine statemachine::add_state("discharge", &function_33e3ec84, &function_40bc6343, &function_3ce9e04f);
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::call_custom_add_state_callbacks();
    vehicle_ai::startinitialstate("seek");
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xa3b5eed4, Offset: 0x6d8
// Size: 0x1a
function function_95d6329a() {
    return self.origin + (0, 0, 30);
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x4
// Checksum 0x768ab3cf, Offset: 0x700
// Size: 0xae
function private function_868950b3() {
    trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);
    if (isdefined(trace[#"entity"])) {
        entity = trace[#"entity"];
        if (entity ismovingplatform()) {
            return true;
        }
    }
    return false;
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x4
// Checksum 0xd7cd7a85, Offset: 0x7b8
// Size: 0x4e
function private function_aad05886() {
    result = function_cfee2a04(self.origin + (0, 0, 100), 400);
    if (isdefined(result)) {
        return true;
    }
    return false;
}

// Namespace seeker_mine/seeker_mine
// Params 15, eflags: 0x0
// Checksum 0x37cae398, Offset: 0x810
// Size: 0xca
function function_85238ecd(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (weapon == level.shockrifleweapon) {
        idamage = self.health;
    }
    if (weapon === getweapon(#"ability_smart_cover")) {
        idamage = 0;
    }
    return idamage;
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xe8647a2c, Offset: 0x8e8
// Size: 0xf4
function state_chase_start(params) {
    self clientfield::set("seeker_mine_light_fx", 1);
    self.var_a37041e8 = gettime();
    if (isdefined(self.settings.var_bcc32daa)) {
        self playloopsound(self.settings.var_bcc32daa);
    }
    self thread function_8cbc7cc8();
    self thread function_e85a1132();
    self thread watch_for_timeout(&function_7b982596, int(self.settings.var_8c9cb24d * 1000));
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xc704f50e, Offset: 0x9e8
// Size: 0x34
function function_22f46862(params) {
    self.var_b13f2b64 = function_7b982596();
    self stoploopsound();
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x983f640d, Offset: 0xa28
// Size: 0x26
function function_7b982596() {
    time = self.var_b13f2b64 + gettime() - self.var_a37041e8;
    return time;
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xfe91b21e, Offset: 0xa58
// Size: 0x106
function function_8fc59a55(params) {
    self endon(#"death");
    self endon(#"change_state");
    for (;;) {
        if (isdefined(self.favoriteenemy) && isalive(self.favoriteenemy)) {
            self setbrake(0);
            self setspeed(self.settings.var_627b76aa);
            if (!chase_enemy()) {
                self vehicle_ai::set_state("seek");
            }
        } else {
            self vehicle_ai::set_state("seek");
        }
        self waittill_pathing_done(2);
        waitframe(1);
    }
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x8d76e966, Offset: 0xb68
// Size: 0x80
function waittill_pathing_done(maxtime = 15) {
    self endon(#"death");
    self endon(#"change_state");
    result = self waittilltimeout(maxtime, #"near_goal", #"hash_f6b2d6a37e22523", #"switch_enemy");
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x6004de7c, Offset: 0xbf0
// Size: 0x8a
function chase_enemy() {
    if (isdefined(self.favoriteenemy) && function_1d34bdb3(self.favoriteenemy)) {
        return false;
    }
    targetpos = function_7175ef39();
    if (isdefined(targetpos)) {
        if (self function_3c8dce03(targetpos, 0, 1)) {
            self.current_pathto_pos = targetpos;
            return true;
        }
    }
    return false;
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xe3fe0114, Offset: 0xc88
// Size: 0xb4
function function_7175ef39() {
    if (isdefined(self.favoriteenemy)) {
        target_pos = self.favoriteenemy.origin;
    }
    if (isdefined(target_pos)) {
        target_pos_onnavmesh = getclosestpointonnavmesh(target_pos, self.settings.var_361d6627 * 1.5, self getpathfindingradius() * 1.2, 4194287);
    }
    if (isdefined(target_pos_onnavmesh)) {
        return target_pos_onnavmesh;
    }
    if (isdefined(self.current_pathto_pos)) {
        return self.current_pathto_pos;
    }
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x2b88199b, Offset: 0xd48
// Size: 0x12e
function function_e85a1132() {
    self endon(#"death");
    self endon(#"change_state");
    for (;;) {
        if (isdefined(self.favoriteenemy) && isalive(self.favoriteenemy)) {
            if (function_1d34bdb3(self.favoriteenemy)) {
                self vehicle_ai::set_state("seek");
            }
            var_8e3d470 = arc::function_921683f4(level.var_f8bec0dd[self.arcweapon], self.owner, self, self function_95d6329a(), 0, self.favoriteenemy);
            if (var_8e3d470) {
                self vehicle_ai::set_state("discharge");
            }
        } else {
            self vehicle_ai::set_state("seek");
        }
        waitframe(1);
    }
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xb0c9ae14, Offset: 0xe80
// Size: 0x9c
function function_33e3ec84(params) {
    if (isplayer(self.owner)) {
        self notify(#"seeker_discharge");
        self.owner notify(#"seeker_discharge");
    }
    self setbrake(1);
    self function_9f59031e();
    self function_3c8dce03(self.origin);
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xf8edda30, Offset: 0xf28
// Size: 0x8c
function function_3ce9e04f(params) {
    if (isplayer(self.owner)) {
        self notify(#"seeker_discharge_stopped");
        self.owner notify(#"seeker_discharge_stopped");
    }
    if (isdefined(self.var_94cf710e)) {
        self.var_94cf710e delete();
    }
    self stoploopsound();
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xa437fd29, Offset: 0xfc0
// Size: 0x21c
function function_40bc6343(params) {
    self endon(#"death");
    self endon(#"change_state");
    starttime = gettime();
    var_c1fa867f = int(self.settings.var_92a2a80e * 1000);
    var_6536d43a = -2500;
    while (starttime + var_c1fa867f > gettime() && (!isdefined(self.var_222f3f2) || self.var_222f3f2 + var_6536d43a > gettime())) {
        if (isdefined(self.arcweapon)) {
            if (isdefined(level.var_f8bec0dd[self.arcweapon])) {
                self.var_f8bec0dd = level.var_f8bec0dd[self.arcweapon];
                if (!isdefined(self.var_8d124203) || self.var_8d124203.size < level.var_f8bec0dd[self.arcweapon].var_3d0c8d1d) {
                    arc::find_arc_targets(level.var_f8bec0dd[self.arcweapon], self.owner, self, self function_95d6329a(), 0);
                }
            }
            if (!(isdefined(self.var_8640f206) && self.var_8640f206)) {
                self clientfield::set("seeker_mine_fx", 1);
                if (isdefined(self.settings.var_42557b37)) {
                    self playsound(self.settings.var_42557b37);
                }
                self.var_8640f206 = 1;
            }
        }
        waitframe(1);
    }
    self vehicle_ai::set_state("death");
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xaa1f4ae5, Offset: 0x11e8
// Size: 0xdc
function function_3178e98e(params) {
    self.favoriteenemy = undefined;
    self.var_988825b0 = gettime();
    self clientfield::set("seeker_mine_light_fx", 0);
    self thread function_8cbc7cc8();
    self thread function_9db76ddf();
    self thread function_30b3decb();
    self thread watch_for_timeout(&function_767a66de, int(self.settings.var_9594bc3f * 1000));
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xed9e260e, Offset: 0x12d0
// Size: 0x3a
function function_3962ee4e(params) {
    self stoploopsound();
    self.var_f85997c8 = function_767a66de();
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xa44be0bc, Offset: 0x1318
// Size: 0x26
function function_767a66de() {
    time = self.var_f85997c8 + gettime() - self.var_988825b0;
    return time;
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x4
// Checksum 0xdee28bd0, Offset: 0x1348
// Size: 0x70
function private function_ded2e81() {
    self endon(#"death");
    while (true) {
        if (!function_aad05886() && function_c537d17a()) {
            self notify(#"hash_f6b2d6a37e22523");
        }
        waitframe(2);
    }
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x4
// Checksum 0xc1e7d589, Offset: 0x13c0
// Size: 0xe0
function private function_30b3decb() {
    self endon(#"death");
    self endon(#"change_state");
    while (true) {
        currentdir = anglestoforward(self.angles);
        wait 1;
        newdir = anglestoforward(self.angles);
        if (vectordot(currentdir, newdir) < -0.5) {
            if (isdefined(self.settings.var_23411683)) {
                self playsound(self.settings.var_23411683);
            }
        }
    }
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x3030000c, Offset: 0x14a8
// Size: 0x456
function function_89f500e1(params) {
    self endon(#"death");
    self endon(#"change_state");
    for (;;) {
        if (isdefined(self.favoriteenemy)) {
            self.current_pathto_pos = self function_7175ef39();
            if (isdefined(self.current_pathto_pos)) {
                if (self function_3c8dce03(self.current_pathto_pos, 0, 1)) {
                    self setspeed(self.settings.var_c92afc97);
                    self setbrake(0);
                    self waittill_pathing_done(2);
                    continue;
                }
            }
        }
        self setspeed(self.settings.var_dd3171f2);
        if (function_aad05886()) {
            forward = anglestoforward(self.angles);
            forwardpos = self.origin + forward * 500;
            var_ae49e2a0 = ai::t_cylinder(self.origin, 200, 60);
            tacpoints = tacticalquery("mp_seeker_seek_no_enemy", self.origin, self, var_ae49e2a0, forwardpos);
            if (isdefined(tacpoints) && tacpoints.size != 0) {
                /#
                    record3dtext("<dev string:x30>", self.origin - (0, 0, 20), (1, 0, 0));
                #/
                newpos = tacpoints[0].origin;
                newpos = getclosestpointonnavmesh(newpos, 500, 30);
                if (isdefined(newpos)) {
                    if (self function_3c8dce03(newpos, 0, 1)) {
                        self waittill_pathing_done(2);
                    } else {
                        self function_3c8dce03(newpos, 0, 0);
                        self waittill_pathing_done(2);
                    }
                }
            } else {
                newpos = getclosestpointonnavmesh(self.origin, 1000, 10);
                if (isdefined(newpos)) {
                    var_ae49e2a0 = ai::t_cylinder(self.origin, 400, 60);
                    cylinder = ai::t_cylinder(self.origin, 1500, 150);
                    tacpoints = tacticalquery("mp_seeker_seek_no_enemy_fallback", newpos, self, var_ae49e2a0, cylinder);
                    if (isdefined(tacpoints) && tacpoints.size != 0) {
                        /#
                            record3dtext("<dev string:x30>", self.origin - (0, 0, 20), (1, 0, 0));
                        #/
                        newpos = tacpoints[0].origin;
                        newpos = getclosestpointonnavmesh(newpos, 500, 30);
                        if (isdefined(newpos)) {
                            if (self function_3c8dce03(newpos, 0, 1)) {
                                self waittill_pathing_done(2);
                            } else {
                                self function_3c8dce03(newpos, 0, 0);
                                self waittill_pathing_done(2);
                            }
                        }
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x8d4aea05, Offset: 0x1908
// Size: 0x2de
function function_1d34bdb3(target) {
    if (isplayer(target)) {
        if (!isalive(target)) {
            return true;
        }
        if (isdefined(target.var_d9a0386) && target.var_d9a0386) {
            return true;
        }
        if (isdefined(target.isplanting) && target.isplanting || isdefined(target.isdefusing) && target.isdefusing || target oob::isoutofbounds()) {
            return true;
        }
        if (target laststand::player_is_in_laststand()) {
            return true;
        }
        if (target isremotecontrolling() || isdefined(target.holding_placeable)) {
            return true;
        }
        if (target isinvehicle()) {
            return true;
        }
        if (target player::is_spawn_protected()) {
            return true;
        }
        if (isdefined(target.var_db63b8ae) && target.var_db63b8ae) {
            return true;
        }
        if (target isgrappling()) {
            return true;
        }
        if (isdefined(target.var_40726073) && isdefined(target.var_40726073.isshocked) && target.var_40726073.isshocked) {
            return true;
        }
        if (target hasperk(#"specialty_nottargetedbyraps") && !isdefined(level.var_6ae98805)) {
            distsqtotarget = distancesquared(target.origin, self.origin);
            if (distsqtotarget <= 40000) {
                return false;
            }
            return true;
        }
    }
    target_pos_onnavmesh = undefined;
    if (isdefined(target)) {
        target_pos_onnavmesh = getclosestpointonnavmesh(target.origin, self.settings.var_361d6627 * 1.5, self getpathfindingradius() * 1.2, 4194287);
        if (!isdefined(target_pos_onnavmesh)) {
            return true;
        }
    }
    return false;
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xab46210c, Offset: 0x1bf0
// Size: 0x1aa
function function_9db76ddf() {
    self endon(#"death");
    self endon(#"change_state");
    while (true) {
        if (isdefined(self.favoriteenemy)) {
            target = self.favoriteenemy;
            distsqtotarget = distancesquared(target.origin, self.origin);
            if (distsqtotarget <= 122500) {
                var_a21cc986 = 1;
            }
            var_8d1fc0b2 = self targetting_delay::function_3b2437d9(target, 0);
            canseetarget = var_8d1fc0b2 && target sightconetrace(self function_95d6329a(), self, anglestoforward(self.angles), self.settings.var_6facf3ad);
            if (canseetarget || isdefined(var_a21cc986) && var_a21cc986) {
                if (isdefined(self.settings.var_6d8a6331)) {
                    self playsound(self.settings.var_6d8a6331);
                }
                self vehicle_ai::set_state("chase");
                break;
            }
        }
        waitframe(1);
    }
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xc6d47c24, Offset: 0x1da8
// Size: 0x62
function function_699211b8(target) {
    if (isdefined(self.favoriteenemy) && self.favoriteenemy != target) {
        self targetting_delay::function_4ba58de4(target);
        self notify(#"switch_enemy");
    }
    self.favoriteenemy = target;
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x639dcee3, Offset: 0x1e18
// Size: 0x3f6
function function_8cbc7cc8() {
    self endon(#"death", #"change_state");
    wait 1;
    firsttime = 1;
    while (true) {
        if (isdefined(self.favoriteenemy) && function_1d34bdb3(self.favoriteenemy)) {
            self.favoriteenemy = undefined;
        }
        if (isdefined(self.favoriteenemy)) {
            if (util::within_fov(self.origin, self.angles, self.favoriteenemy.origin, 0.939)) {
                distsqtotarget = distancesquared(self.favoriteenemy.origin, self.origin);
                if (distsqtotarget <= 122500) {
                    waitframe(1);
                    continue;
                }
            }
        }
        enemies = util::function_8260dc36(self.team);
        alltargets = arraycombine(enemies, getactorarray(), 1, 0);
        alltargets = arraysort(enemies, self function_95d6329a(), 1);
        foundenemy = 0;
        foreach (target in alltargets) {
            if (function_1d34bdb3(target)) {
                continue;
            }
            angles = self.angles;
            if (isdefined(firsttime) && firsttime && isdefined(self.owner)) {
                angles = self.owner.angles;
                firsttime = 0;
            }
            if (util::within_fov(self.origin, angles, target.origin, 0)) {
                function_699211b8(target);
                foundenemy = 1;
                break;
            }
        }
        if (!foundenemy) {
            foreach (target in alltargets) {
                distsqtotarget = distancesquared(target.origin, self.origin);
                if (distsqtotarget <= 122500 && !function_1d34bdb3(target)) {
                    function_699211b8(target);
                    foundenemy = 1;
                    break;
                }
            }
        }
        if (!foundenemy && alltargets.size && isdefined(alltargets[0]) && !function_1d34bdb3(alltargets[0])) {
            function_699211b8(target);
        }
        waitframe(1);
    }
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xca8d6bba, Offset: 0x2218
// Size: 0x142
function function_c537d17a(var_e67c1428 = 500) {
    if (function_aad05886()) {
        return true;
    }
    /#
        record3dtext("<dev string:x3d>", self.origin - (0, 0, 20), (1, 0, 0));
    #/
    newpos = getclosestpointonnavmesh(self.origin, var_e67c1428, self getpathfindingradius() * 1.2);
    if (isdefined(newpos)) {
        trace = groundtrace(newpos + (0, 0, 70), newpos + (0, 0, -70), 0, undefined);
        if (isdefined(trace[#"position"])) {
            newpos = trace[#"position"];
        }
        self.origin = newpos;
        return true;
    }
    return false;
}

// Namespace seeker_mine/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x9a566d8e, Offset: 0x2368
// Size: 0x76
function watch_for_timeout(var_163a7e54, max_duration) {
    self endon(#"death");
    self endon(#"change_state");
    for (;;) {
        if (self [[ var_163a7e54 ]]() > max_duration) {
            self vehicle_ai::set_state("death");
        }
        waitframe(1);
    }
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x5caa1ec7, Offset: 0x23e8
// Size: 0x60
function function_50820888() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"veh_collision");
        self playsound(#"veh_wasp_wall_imp");
    }
}

// Namespace seeker_mine/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x46a697ec, Offset: 0x2450
// Size: 0x24
function function_9d24198b() {
    self vehicle_ai::set_state("death");
}

// Namespace seeker_mine/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x1bba8a1b, Offset: 0x2480
// Size: 0x9c
function state_death_update(params) {
    self clientfield::set("seeker_mine_fx", 0);
    self arc::function_d3f13e8(self.var_f8bec0dd);
    vehicle_ai::defaultstate_death_update(params);
    if (isdefined(self.owner)) {
        self.owner globallogic_score::function_8fe8d71e(#"hash_2cbb2354f066e90");
    }
}

