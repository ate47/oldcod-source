#using scripts/core_common/array_shared;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/killstreaks/rcbomb;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/util;

#namespace namespace_fd660bb1;

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x16cfd93d, Offset: 0x400
// Size: 0x1fc
function init() {
    doors = getentarray("mp_stronghold_security_door_lower", "targetname");
    if (!isdefined(doors) || doors.size == 0) {
        return;
    }
    var_6001ee4a = getentarray("mp_stronghold_security_door_upper", "targetname");
    killtriggers = getentarray("mp_stronghold_killbrush", "targetname");
    /#
        assert(var_6001ee4a.size == doors.size);
    #/
    /#
        assert(killtriggers.size == killtriggers.size);
    #/
    foreach (door in doors) {
        upper = function_b02c2d9b(door.origin, var_6001ee4a);
        var_318c56b3 = function_b02c2d9b(door.origin, killtriggers);
        level thread function_a9870442(door, upper, var_318c56b3);
    }
    level thread door_use_trigger();
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 3, eflags: 0x0
// Checksum 0xfac36c55, Offset: 0x608
// Size: 0x19c
function function_a9870442(door, upper, trigger) {
    door.upper = upper;
    door.kill_trigger = trigger;
    /#
        assert(isdefined(door.kill_trigger));
    #/
    door.kill_trigger enablelinkto();
    door.kill_trigger linkto(door);
    door.opened = 1;
    door.var_ac9a7989 = door.origin;
    door.var_e5d0c7af = 0;
    door.var_c99bab0a = (door.origin[0], door.origin[1], door.origin[2] - 90);
    door.var_6839fc52 = (door.origin[0], door.origin[1], door.origin[2] - 180);
    door thread door_think();
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x4a243ef7, Offset: 0x7b0
// Size: 0xca
function door_use_trigger() {
    use_triggers = getentarray("mp_stronghold_usetrigger", "targetname");
    foreach (use_trigger in use_triggers) {
        use_trigger thread function_dc8340b();
        use_trigger thread function_4b4db561();
    }
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x387cdb84, Offset: 0x888
// Size: 0x24
function function_dc8340b() {
    for (;;) {
        self waittill("trigger");
        level notify(#"hash_40d64b76");
    }
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x42090074, Offset: 0x8b8
// Size: 0xc8
function function_4b4db561() {
    hintstring = "";
    for (;;) {
        returnvar = level waittill("mp_stronghold_trigger_enable", "mp_stronghold_trigger_disable", "mp_stronghold_trigger_cooldown");
        switch (returnvar._notify) {
        case #"hash_7ef557e4":
            hintstring = "ENABLE";
            break;
        case #"hash_6d6f0e1f":
            hintstring = "DISABLE";
            break;
        case #"hash_1ebb9c2":
            hintstring = "COOLDOWN";
            break;
        }
        self sethintstring(hintstring);
    }
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0xfbb8d75c, Offset: 0x988
// Size: 0x140
function door_think() {
    for (;;) {
        exploder::exploder("fx_switch_red");
        exploder::kill_exploder("fx_switch_green");
        wait 20;
        exploder::exploder("fx_switch_green");
        exploder::kill_exploder("fx_switch_red");
        if (self function_1213d8bc()) {
            level notify(#"hash_6d6f0e1f");
        } else {
            level notify(#"hash_7ef557e4");
        }
        level waittill("mp_stronghold_trigger_use");
        level notify(#"hash_1ebb9c2");
        if (self function_1213d8bc()) {
            self thread door_open();
            self function_8149b63b(0);
            continue;
        }
        self thread door_close();
        self function_8149b63b(1);
    }
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x40e8ad7b, Offset: 0xad0
// Size: 0x10
function function_1213d8bc() {
    return !self.opened;
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x57cf1629, Offset: 0xae8
// Size: 0xf4
function door_open() {
    if (self.opened) {
        return;
    }
    dist = distance(self.var_6839fc52, self.origin);
    frac = dist / 180;
    halftime = 4.5;
    self moveto(self.var_c99bab0a, halftime);
    self.upper moveto(self.var_ac9a7989, halftime);
    self waittill("movedone");
    self moveto(self.var_ac9a7989, halftime);
    self.opened = 1;
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x68a3c2dd, Offset: 0xbe8
// Size: 0xf0
function door_close() {
    if (!self.opened) {
        return;
    }
    dist = distance(self.var_6839fc52, self.origin);
    frac = dist / 180;
    halftime = 4.5;
    self moveto(self.var_c99bab0a, halftime);
    self waittill("movedone");
    self moveto(self.var_6839fc52, halftime);
    self.upper moveto(self.var_c99bab0a, halftime);
    self.opened = 0;
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 1, eflags: 0x0
// Checksum 0xa13ad14, Offset: 0xce0
// Size: 0x650
function function_8149b63b(var_6b9180f5) {
    self endon(#"movedone");
    self.disablefinalkillcam = 1;
    door = self;
    var_cd78fc15 = 0;
    for (;;) {
        wait 0.2;
        entities = getdamageableentarray(self.origin, 200);
        foreach (entity in entities) {
            if (!entity istouching(self.kill_trigger)) {
                continue;
            }
            if (!isalive(entity)) {
                continue;
            }
            if (isdefined(entity.targetname)) {
                if (entity.targetname == "talon") {
                    entity notify(#"death");
                    continue;
                } else if (entity.targetname == "riotshield_mp") {
                    entity dodamage(1, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
                    continue;
                }
            }
            if (isdefined(entity.helitype) && entity.helitype == "qrdrone") {
                watcher = entity.owner weaponobjects::getweaponobjectwatcher("qrdrone");
                watcher thread weaponobjects::waitanddetonate(entity, 0, undefined);
                continue;
            }
            if (entity.classname == "grenade") {
                if (!isdefined(entity.name)) {
                    continue;
                }
                if (!isdefined(entity.owner)) {
                    continue;
                }
                if (entity.name == "proximity_grenade_mp") {
                    watcher = entity.owner weaponobjects::getwatcherforweapon(entity.name);
                    watcher thread weaponobjects::waitanddetonate(entity, 0, undefined, "script_mover_mp");
                    continue;
                }
                if (!entity.isequipment) {
                    continue;
                }
                watcher = entity.owner weaponobjects::getwatcherforweapon(entity.name);
                if (!isdefined(watcher)) {
                    continue;
                }
                watcher thread weaponobjects::waitanddetonate(entity, 0, undefined, "script_mover_mp");
                continue;
            }
            if (entity.classname == "auto_turret") {
                if (!isdefined(entity.damagedtodeath) || !entity.damagedtodeath) {
                    entity util::domaxdamage(self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
                }
                continue;
            }
            if (var_6b9180f5 == 0 && isplayer(entity)) {
                continue;
            }
            entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
            if (isplayer(entity)) {
                var_cd78fc15 = gettime() + 1000;
            }
        }
        self function_efb0f9a4();
        if (gettime() > var_cd78fc15) {
            self function_dde749cf();
        }
        if (level.gametype == "ctf") {
            foreach (flag in level.flags) {
                if (flag.visuals[0] istouching(self.kill_trigger) && level.ctfreturnflag != undefined) {
                    flag [[ level.ctfreturnflag ]]();
                }
            }
            continue;
        }
        if (level.gametype == "sd" && !level.multibomb) {
            if (level.sdbomb.visuals[0] istouching(self.kill_trigger)) {
                level.sdbomb gameobjects::return_home();
            }
        }
    }
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x187aeb64, Offset: 0x1338
// Size: 0x162
function function_efb0f9a4() {
    crates = getentarray("care_package", "script_noteworthy");
    foreach (crate in crates) {
        if (distancesquared(crate.origin, self.origin) < 40000) {
            if (crate istouching(self)) {
                playfx(level._supply_drop_explosion_fx, crate.origin);
                playsoundatposition("wpn_grenade_explode", crate.origin);
                wait 0.1;
                crate supplydrop::cratedelete();
            }
        }
    }
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 0, eflags: 0x0
// Checksum 0x88817618, Offset: 0x14a8
// Size: 0x9e
function function_dde749cf() {
    corpses = getcorpsearray();
    for (i = 0; i < corpses.size; i++) {
        if (distancesquared(corpses[i].origin, self.origin) < 40000) {
            corpses[i] delete();
        }
    }
}

// Namespace namespace_fd660bb1/namespace_fd660bb1
// Params 2, eflags: 0x0
// Checksum 0xa664136e, Offset: 0x1550
// Size: 0xf2
function function_b02c2d9b(org, array) {
    dist = 9999999;
    distsq = dist * dist;
    if (array.size < 1) {
        return;
    }
    index = undefined;
    for (i = 0; i < array.size; i++) {
        newdistsq = distancesquared(array[i].origin, org);
        if (newdistsq >= distsq) {
            continue;
        }
        distsq = newdistsq;
        index = i;
    }
    return array[index];
}

