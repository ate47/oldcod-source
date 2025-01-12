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

#namespace mp_stronghold_doors;

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x16cfd93d, Offset: 0x400
// Size: 0x1fc
function init() {
    doors = getentarray("mp_stronghold_security_door_lower", "targetname");
    if (!isdefined(doors) || doors.size == 0) {
        return;
    }
    uppers = getentarray("mp_stronghold_security_door_upper", "targetname");
    killtriggers = getentarray("mp_stronghold_killbrush", "targetname");
    /#
        assert(uppers.size == doors.size);
    #/
    /#
        assert(killtriggers.size == killtriggers.size);
    #/
    foreach (door in doors) {
        upper = get_closest(door.origin, uppers);
        killtrigger = get_closest(door.origin, killtriggers);
        level thread setup_doors(door, upper, killtrigger);
    }
    level thread door_use_trigger();
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 3, eflags: 0x0
// Checksum 0xfac36c55, Offset: 0x608
// Size: 0x19c
function setup_doors(door, upper, trigger) {
    door.upper = upper;
    door.kill_trigger = trigger;
    /#
        assert(isdefined(door.kill_trigger));
    #/
    door.kill_trigger enablelinkto();
    door.kill_trigger linkto(door);
    door.opened = 1;
    door.origin_opened = door.origin;
    door.force_open_time = 0;
    door.origin_closed_half = (door.origin[0], door.origin[1], door.origin[2] - 90);
    door.origin_closed = (door.origin[0], door.origin[1], door.origin[2] - 180);
    door thread door_think();
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x4a243ef7, Offset: 0x7b0
// Size: 0xca
function door_use_trigger() {
    use_triggers = getentarray("mp_stronghold_usetrigger", "targetname");
    foreach (use_trigger in use_triggers) {
        use_trigger thread watchtriggerusage();
        use_trigger thread watchtriggerenabledisable();
    }
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x387cdb84, Offset: 0x888
// Size: 0x24
function watchtriggerusage() {
    for (;;) {
        self waittill("trigger");
        level notify(#"mp_stronghold_trigger_use");
    }
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x42090074, Offset: 0x8b8
// Size: 0xc8
function watchtriggerenabledisable() {
    hintstring = "";
    for (;;) {
        returnvar = level waittill("mp_stronghold_trigger_enable", "mp_stronghold_trigger_disable", "mp_stronghold_trigger_cooldown");
        switch (returnvar._notify) {
        case #"mp_stronghold_trigger_enable":
            hintstring = "ENABLE";
            break;
        case #"mp_stronghold_trigger_disable":
            hintstring = "DISABLE";
            break;
        case #"mp_stronghold_trigger_cooldown":
            hintstring = "COOLDOWN";
            break;
        }
        self sethintstring(hintstring);
    }
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
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
        if (self door_should_open()) {
            level notify(#"mp_stronghold_trigger_disable");
        } else {
            level notify(#"mp_stronghold_trigger_enable");
        }
        level waittill("mp_stronghold_trigger_use");
        level notify(#"mp_stronghold_trigger_cooldown");
        if (self door_should_open()) {
            self thread door_open();
            self security_door_drop_think(0);
            continue;
        }
        self thread door_close();
        self security_door_drop_think(1);
    }
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x40e8ad7b, Offset: 0xad0
// Size: 0x10
function door_should_open() {
    return !self.opened;
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x57cf1629, Offset: 0xae8
// Size: 0xf4
function door_open() {
    if (self.opened) {
        return;
    }
    dist = distance(self.origin_closed, self.origin);
    frac = dist / 180;
    halftime = 4.5;
    self moveto(self.origin_closed_half, halftime);
    self.upper moveto(self.origin_opened, halftime);
    self waittill("movedone");
    self moveto(self.origin_opened, halftime);
    self.opened = 1;
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x68a3c2dd, Offset: 0xbe8
// Size: 0xf0
function door_close() {
    if (!self.opened) {
        return;
    }
    dist = distance(self.origin_closed, self.origin);
    frac = dist / 180;
    halftime = 4.5;
    self moveto(self.origin_closed_half, halftime);
    self waittill("movedone");
    self moveto(self.origin_closed, halftime);
    self.upper moveto(self.origin_closed_half, halftime);
    self.opened = 0;
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 1, eflags: 0x0
// Checksum 0xa13ad14, Offset: 0xce0
// Size: 0x650
function security_door_drop_think(killplayers) {
    self endon(#"movedone");
    self.disablefinalkillcam = 1;
    door = self;
    corpse_delay = 0;
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
            if (killplayers == 0 && isplayer(entity)) {
                continue;
            }
            entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
            if (isplayer(entity)) {
                corpse_delay = gettime() + 1000;
            }
        }
        self destroy_supply_crates();
        if (gettime() > corpse_delay) {
            self destroy_corpses();
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

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x187aeb64, Offset: 0x1338
// Size: 0x162
function destroy_supply_crates() {
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

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x88817618, Offset: 0x14a8
// Size: 0x9e
function destroy_corpses() {
    corpses = getcorpsearray();
    for (i = 0; i < corpses.size; i++) {
        if (distancesquared(corpses[i].origin, self.origin) < 40000) {
            corpses[i] delete();
        }
    }
}

// Namespace mp_stronghold_doors/mp_stronghold_doors
// Params 2, eflags: 0x0
// Checksum 0xa664136e, Offset: 0x1550
// Size: 0xf2
function get_closest(org, array) {
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

