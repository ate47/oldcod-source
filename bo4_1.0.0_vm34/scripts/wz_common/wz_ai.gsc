#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\mp_common\item_drop;

#namespace wz_ai;

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x2
// Checksum 0x1b7c2293, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_ai", &__init__, undefined, undefined);
}

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x4
// Checksum 0x225ec6bb, Offset: 0x160
// Size: 0x64
function private __init__() {
    clientfield::register("vehicle", "enable_on_radar", 1, 1, "int");
    clientfield::register("actor", "enable_on_radar", 1, 1, "int");
}

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x0
// Checksum 0xb4f5e8a2, Offset: 0x1d0
// Size: 0x14
function ai_init() {
    function_c7fe5469();
}

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x0
// Checksum 0x7c26bdf1, Offset: 0x1f0
// Size: 0xc8
function function_c7fe5469() {
    if (getdvarint(#"hash_20cd968623dbb8ef", 0)) {
        patrolspawns = struct::get_array("wz_patrol_loc", "targetname");
        foreach (spot in patrolspawns) {
            level thread function_c7736b40(spot);
        }
    }
}

// Namespace wz_ai/wz_ai
// Params 1, eflags: 0x0
// Checksum 0x653a4d9e, Offset: 0x2c0
// Size: 0x5b0
function function_c7736b40(spawn_loc) {
    level endon(#"game_ended");
    if (!ispointonnavmesh(spawn_loc.origin)) {
        return;
    }
    parms = strtok(spawn_loc.script_parameters, ";");
    assert(parms.size == 5);
    zone = spawnstruct();
    if (!isdefined(zone)) {
        return;
    }
    zone.name = parms[0];
    zone.volume = getent(zone.name, "targetname");
    zone.mins = zone.volume.origin + zone.volume.mins;
    zone.maxs = zone.volume.origin + zone.volume.maxs;
    zone.var_e53f2a25 = int(parms[1]);
    zone.is_vehicle = int(parms[2]);
    zone.fovcosine = cos(int(parms[4]));
    zone.goalradius = isdefined(spawn_loc.radius) ? spawn_loc.radius : 4096;
    zone.maxsightdistsqrd = int(parms[3]) * int(parms[3]);
    zone.type = spawn_loc.script_noteworthy;
    zone thread function_7095a0b3();
    patroller = undefined;
    while (true) {
        if (zone.var_e53f2a25 < 1) {
            return;
        }
        while (!(isdefined(zone.is_occupied) && zone.is_occupied)) {
            wait randomintrange(2, 6);
        }
        if (!isdefined(patroller)) {
            if (isdefined(zone.is_vehicle) && zone.is_vehicle) {
                patroller = spawnvehicle(spawn_loc.script_noteworthy, spawn_loc.origin, (0, 0, 0), "wz_patrol_veh_ai");
            } else {
                patroller = spawnactor(spawn_loc.script_noteworthy, spawn_loc.origin, (0, 0, 0), "wz_patrol_ai");
            }
            if (isdefined(patroller)) {
                patroller clientfield::set("enable_on_radar", 1);
                patroller.goalradius = zone.goalradius;
                patroller.maxsightdistsqrd = zone.maxsightdistsqrd;
                patroller.fovcosine = zone.fovcosine;
                patroller.zone = zone;
                if (patroller.archetype === #"amws") {
                    patroller.scan_turret = 1;
                    patroller.var_4f53abcb = 1;
                    patroller.var_59227300 = 1;
                }
                if (isdefined(spawn_loc.target)) {
                    node = getnode(spawn_loc.target, "targetname");
                    if (isdefined(node)) {
                        patroller thread function_5d0e5a0f(node, patroller.goalradius);
                    } else {
                        patroller setgoal(patroller.origin);
                    }
                } else {
                    patroller setgoal(patroller.origin);
                }
                patroller thread function_778cc86e();
                patroller thread function_5216b7e1();
                zone thread function_20816231(patroller);
                zone thread function_708f6879(patroller);
            }
        }
        while (isdefined(zone.is_occupied) && zone.is_occupied) {
            wait randomintrange(2, 6);
        }
        if (isdefined(patroller)) {
            patroller delete();
        }
    }
}

// Namespace wz_ai/wz_ai
// Params 3, eflags: 0x0
// Checksum 0x5a742dee, Offset: 0x878
// Size: 0xb6
function function_f13f0df(point, mins, maxs) {
    return point[0] >= mins[0] && point[0] <= maxs[0] && point[1] >= mins[1] && point[1] <= maxs[1] && point[2] >= mins[2] && point[2] <= maxs[2];
}

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x0
// Checksum 0xc7eb5a35, Offset: 0x938
// Size: 0x128
function function_7095a0b3() {
    level endon(#"game_ended");
    self.is_occupied = 0;
    while (true) {
        self.is_occupied = 0;
        foreach (player in getplayers()) {
            if (!isdefined(player) || !isalive(player)) {
                continue;
            }
            istouching = player istouching(self.volume);
            if (istouching) {
                self.is_occupied = 1;
                break;
            }
        }
        wait randomfloatrange(2, 4);
    }
}

// Namespace wz_ai/wz_ai
// Params 1, eflags: 0x0
// Checksum 0x2cf713fe, Offset: 0xa68
// Size: 0x5e
function function_fe579830(type) {
    items = [];
    switch (type) {
    case #"hash_33ccea7be2e5f439":
        break;
    default:
        break;
    }
    return items;
}

// Namespace wz_ai/wz_ai
// Params 1, eflags: 0x0
// Checksum 0x4a36783e, Offset: 0xad0
// Size: 0x80
function function_20816231(patroller) {
    type = patroller.type;
    waitresult = patroller waittill(#"death");
    attacker = waitresult.attacker;
    if (isdefined(attacker) && attacker != patroller) {
        self.var_e53f2a25--;
    }
}

// Namespace wz_ai/wz_ai
// Params 3, eflags: 0x0
// Checksum 0xbebbc63, Offset: 0xb58
// Size: 0x28
function function_58417962(origin, angles, items) {
    if (!items.size) {
        return;
    }
}

// Namespace wz_ai/wz_ai
// Params 2, eflags: 0x0
// Checksum 0x53067414, Offset: 0xb88
// Size: 0x23c
function function_5d0e5a0f(node, oldgoalradius) {
    self endon(#"death");
    level endon(#"game_ended");
    self notify("39b0c4b2843a64d1");
    self endon("39b0c4b2843a64d1");
    if (isdefined(self.enemy)) {
        self.goalradius = oldgoalradius;
        wait randomintrange(3, 6);
        self thread function_5d0e5a0f(node, oldgoalradius);
        return;
    }
    if (!isdefined(node)) {
        self setgoal(self.origin);
        self.goalradius = oldgoalradius;
        return;
    } else {
        if (isdefined(node.radius)) {
            self.goalradius = node.radius;
        } else {
            self.goalradius = 512;
        }
        self setgoal(node);
    }
    if (isdefined(self.scan_turret) && self.scan_turret) {
        self turretsettargetangles(0, (0, self.angles[1], 0));
    }
    isatgoal = 0;
    while (!isatgoal) {
        goalinfo = self function_e9a79b0e();
        isatgoal = isdefined(goalinfo.isatgoal) && goalinfo.isatgoal || self isapproachinggoal() && isdefined(self.overridegoalpos);
        wait 1;
    }
    if (isdefined(node.target)) {
        self thread function_5d0e5a0f(getnode(node.target, "targetname"), oldgoalradius);
    }
}

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x0
// Checksum 0xf8d1e696, Offset: 0xdd0
// Size: 0xc4
function function_5216b7e1() {
    self endon(#"death");
    level endon(#"game_ended");
    self notify("37e3b4b5efcdb012");
    self endon("37e3b4b5efcdb012");
    waitresult = self waittill(#"damage");
    if (isdefined(waitresult.attacker) && isplayer(waitresult.attacker)) {
        self.favoriteenemy = waitresult.attacker;
        wait 5;
        self.favoriteenemy = undefined;
    }
    self thread function_5216b7e1();
}

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x0
// Checksum 0x184b1b55, Offset: 0xea0
// Size: 0x1c0
function function_778cc86e() {
    self endon(#"death");
    level endon(#"game_ended");
    self notify("2996ea4e3661f1c7");
    self endon("2996ea4e3661f1c7");
    goalradius = self.goalradius;
    misscount = 5;
    while (true) {
        if (isdefined(self.enemy)) {
            self.goalradius = 1024;
            if (!self cansee(self.enemy)) {
                misscount--;
                if (misscount < 1) {
                    self clearenemy();
                    misscount = 5;
                }
            } else {
                self setgoal(self.enemy.origin);
            }
        } else {
            self.goalradius = goalradius;
            if (isdefined(self.scan_turret) && self.scan_turret) {
                if (randomint(100) > 50) {
                    self turretsettargetangles(0, (0, self.angles[1], 0));
                } else {
                    self turretsettargetangles(0, (0, randomint(360), 0));
                }
            }
        }
        wait randomintrange(3, 6);
    }
}

// Namespace wz_ai/wz_ai
// Params 1, eflags: 0x0
// Checksum 0xb6f514fe, Offset: 0x1068
// Size: 0x128
function function_708f6879(patroller) {
    level endon(#"game_ended", #"hash_12a8f2c59a67e4fc");
    patroller endon(#"death");
    while (!isdefined(level.deathcircle)) {
        wait 1;
    }
    while (isdefined(patroller)) {
        distsq = distance2dsquared(patroller.origin, level.deathcircle.origin);
        if (distsq > level.deathcircle.radius * level.deathcircle.radius) {
            patroller dodamage(patroller.health, patroller.origin, level.deathcircle);
            self.var_e53f2a25 = 0;
        }
        wait randomint(10);
    }
}

