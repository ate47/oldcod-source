#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai/systems/init;
#using scripts/core_common/ai/systems/weaponlist;
#using scripts/core_common/ai_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/throttle_shared;
#using scripts/core_common/util_shared;

#namespace shared;

// Namespace shared/shared
// Params 0, eflags: 0x2
// Checksum 0xcd8ab967, Offset: 0x2a0
// Size: 0x44
function autoexec main() {
    level.ai_weapon_throttle = new throttle();
    [[ level.ai_weapon_throttle ]]->initialize(1, 0.1);
}

// Namespace shared/shared
// Params 3, eflags: 0x4
// Checksum 0xd1daeb44, Offset: 0x2f0
// Size: 0x9c
function private _throwstowedweapon(entity, weapon, weaponmodel) {
    entity waittill("death");
    if (isdefined(entity)) {
        weaponmodel unlink();
        entity throwweapon(weapon, gettagforpos("back"), 0, 0);
    }
    weaponmodel delete();
}

// Namespace shared/shared
// Params 3, eflags: 0x0
// Checksum 0xc2c1ce3c, Offset: 0x398
// Size: 0xec
function stowweapon(weapon, positionoffset, orientationoffset) {
    entity = self;
    if (!isdefined(positionoffset)) {
        positionoffset = (0, 0, 0);
    }
    if (!isdefined(orientationoffset)) {
        orientationoffset = (0, 0, 0);
    }
    weaponmodel = spawn("script_model", (0, 0, 0));
    weaponmodel setmodel(weapon.worldmodel);
    weaponmodel linkto(entity, "tag_stowed_back", positionoffset, orientationoffset);
    entity thread _throwstowedweapon(entity, weapon, weaponmodel);
}

// Namespace shared/shared
// Params 2, eflags: 0x0
// Checksum 0xe4ec0a7e, Offset: 0x490
// Size: 0x3fc
function placeweaponon(weapon, position) {
    self notify(#"weapon_position_change");
    if (isstring(weapon)) {
        weapon = getweapon(weapon);
    }
    if (!isdefined(self.weaponinfo[weapon.name])) {
        self init::initweapon(weapon);
    }
    curposition = self.weaponinfo[weapon.name].position;
    assert(curposition == "<dev string:x28>" || self.a.weaponpos[curposition] == weapon);
    if (!isarray(self.a.weaponpos)) {
        self.a.weaponpos = [];
    }
    assert(isarray(self.a.weaponpos));
    assert(position == "<dev string:x28>" || isdefined(self.a.weaponpos[position]), "<dev string:x2d>" + position + "<dev string:x3f>");
    assert(isweapon(weapon));
    if (position != "none" && self.a.weaponpos[position] == weapon) {
        return;
    }
    self detachallweaponmodels();
    if (curposition != "none") {
        self detachweapon(weapon);
    }
    if (position == "none") {
        self updateattachedweaponmodels();
        self aiutility::setcurrentweapon(level.weaponnone);
        return;
    }
    if (self.a.weaponpos[position] != level.weaponnone) {
        self detachweapon(self.a.weaponpos[position]);
    }
    if (position == "left" || position == "right") {
        self updatescriptweaponinfoandpos(weapon, position);
        self aiutility::setcurrentweapon(weapon);
    } else {
        self updatescriptweaponinfoandpos(weapon, position);
    }
    self updateattachedweaponmodels();
    assert(self.a.weaponpos["<dev string:x41>"] == level.weaponnone || self.a.weaponpos["<dev string:x46>"] == level.weaponnone);
}

// Namespace shared/shared
// Params 1, eflags: 0x0
// Checksum 0x4d8f0c6a, Offset: 0x898
// Size: 0x74
function detachweapon(weapon) {
    self.a.weaponpos[self.weaponinfo[weapon.name].position] = level.weaponnone;
    self.weaponinfo[weapon.name].position = "none";
}

// Namespace shared/shared
// Params 2, eflags: 0x0
// Checksum 0x2063033f, Offset: 0x918
// Size: 0x5a
function updatescriptweaponinfoandpos(weapon, position) {
    self.weaponinfo[weapon.name].position = position;
    self.a.weaponpos[position] = weapon;
}

// Namespace shared/shared
// Params 0, eflags: 0x0
// Checksum 0x75fb0c7f, Offset: 0x980
// Size: 0xc6
function detachallweaponmodels() {
    if (isdefined(self.weapon_positions)) {
        for (index = 0; index < self.weapon_positions.size; index++) {
            weapon = self.a.weaponpos[self.weapon_positions[index]];
            if (weapon == level.weaponnone) {
                continue;
            }
            self setactorweapon(level.weaponnone, self getactorweaponoptions());
        }
    }
}

// Namespace shared/shared
// Params 0, eflags: 0x0
// Checksum 0xb2627d81, Offset: 0xa50
// Size: 0x146
function updateattachedweaponmodels() {
    if (isdefined(self.weapon_positions)) {
        for (index = 0; index < self.weapon_positions.size; index++) {
            weapon = self.a.weaponpos[self.weapon_positions[index]];
            if (weapon == level.weaponnone) {
                continue;
            }
            if (self.weapon_positions[index] != "right") {
                continue;
            }
            self setactorweapon(weapon, self getactorweaponoptions());
            if (self.weaponinfo[weapon.name].useclip && !self.weaponinfo[weapon.name].hasclip) {
                self hidepart("tag_clip");
            }
        }
    }
}

// Namespace shared/shared
// Params 1, eflags: 0x0
// Checksum 0x54bf5368, Offset: 0xba0
// Size: 0x9e
function gettagforpos(position) {
    switch (position) {
    case #"chest":
        return "tag_weapon_chest";
    case #"back":
        return "tag_stowed_back";
    case #"left":
        return "tag_weapon_left";
    case #"right":
        return "tag_weapon_right";
    case #"hand":
        return "tag_inhand";
    default:
        assertmsg("<dev string:x4c>" + position);
        break;
    }
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x3df265e9, Offset: 0xc48
// Size: 0x236
function throwweapon(weapon, positiontag, scavenger, deleteweaponafterdropping) {
    waittime = 0.1;
    linearscalar = 2;
    angularscalar = 10;
    startposition = self gettagorigin(positiontag);
    startangles = self gettagangles(positiontag);
    if (!isdefined(startposition) || !isdefined(startangles)) {
        return;
    }
    wait waittime;
    if (isdefined(self)) {
        endposition = self gettagorigin(positiontag);
        endangles = self gettagangles(positiontag);
        linearvelocity = (endposition - startposition) * 1 / waittime * linearscalar;
        angularvelocity = vectornormalize(endangles - startangles) * angularscalar;
        throwweapon = self dropweapon(weapon, positiontag, linearvelocity, angularvelocity, scavenger);
        if (isdefined(throwweapon)) {
            throwweapon setcontents(throwweapon setcontents(0) & ~(32768 | 67108864 | 8388608 | 33554432));
        }
        if (deleteweaponafterdropping) {
            throwweapon delete();
            return;
        }
        return throwweapon;
    }
}

// Namespace shared/shared
// Params 0, eflags: 0x0
// Checksum 0xa02c1e54, Offset: 0xe88
// Size: 0x33c
function dropaiweapon() {
    self endon(#"death");
    if (self.weapon == level.weaponnone) {
        return;
    }
    if (isdefined(self.script_nodropsecondaryweapon) && self.script_nodropsecondaryweapon && self.weapon == self.initial_secondaryweapon) {
        println("<dev string:x70>" + self.weapon.name + "<dev string:x90>");
        return;
    } else if (isdefined(self.script_nodropsidearm) && self.script_nodropsidearm && self.weapon == self.sidearm) {
        println("<dev string:x92>" + self.weapon.name + "<dev string:x90>");
        return;
    }
    [[ level.ai_weapon_throttle ]]->waitinqueue(self);
    current_weapon = self.weapon;
    dropweaponname = player_weapon_drop(current_weapon);
    position = self.weaponinfo[current_weapon.name].position;
    shoulddropweapon = !isdefined(self.dontdropweapon) || self.dontdropweapon === 0;
    shoulddeleteafterdropping = current_weapon == getweapon("riotshield");
    if (current_weapon.isscavengable == 0) {
        shoulddropweapon = 0;
    }
    if (shoulddropweapon && self.dropweapon) {
        self.dontdropweapon = 1;
        positiontag = gettagforpos(position);
        throwweapon(dropweaponname, positiontag, 0, shoulddeleteafterdropping);
    }
    if (self.weapon != level.weaponnone) {
        placeweaponon(current_weapon, "none");
        if (self.weapon == self.primaryweapon) {
            self aiutility::setprimaryweapon(level.weaponnone);
        } else if (self.weapon == self.secondaryweapon) {
            self aiutility::setsecondaryweapon(level.weaponnone);
        }
    }
    self aiutility::setcurrentweapon(level.weaponnone);
}

// Namespace shared/shared
// Params 0, eflags: 0x0
// Checksum 0xd3e4c0b, Offset: 0x11d0
// Size: 0x446
function dropallaiweapons() {
    if (isdefined(self.a.dropping_weapons) && self.a.dropping_weapons) {
        return;
    }
    if (!self.dropweapon) {
        if (self.weapon != level.weaponnone) {
            placeweaponon(self.weapon, "none");
            self aiutility::setcurrentweapon(level.weaponnone);
        }
        return;
    }
    self.a.dropping_weapons = 1;
    self detachallweaponmodels();
    droppedsidearm = 0;
    if (isdefined(self.weapon_positions)) {
        for (index = 0; index < self.weapon_positions.size; index++) {
            weapon = self.a.weaponpos[self.weapon_positions[index]];
            if (weapon != level.weaponnone) {
                self.weaponinfo[weapon.name].position = "none";
                self.a.weaponpos[self.weapon_positions[index]] = level.weaponnone;
                if (isdefined(self.script_nodropsecondaryweapon) && self.script_nodropsecondaryweapon && weapon == self.initial_secondaryweapon) {
                    println("<dev string:x70>" + weapon.name + "<dev string:x90>");
                    continue;
                }
                if (isdefined(self.script_nodropsidearm) && self.script_nodropsidearm && weapon == self.sidearm) {
                    println("<dev string:x92>" + weapon.name + "<dev string:x90>");
                    continue;
                }
                velocity = self getvelocity();
                speed = length(velocity) * 0.5;
                weapon = player_weapon_drop(weapon);
                droppedweapon = self dropweapon(weapon, self.weapon_positions[index], speed);
                if (self.sidearm != level.weaponnone) {
                    if (weapon == self.sidearm) {
                        droppedsidearm = 1;
                    }
                }
            }
        }
    }
    if (!droppedsidearm && self.sidearm != level.weaponnone) {
        if (randomint(100) <= 10) {
            velocity = self getvelocity();
            speed = length(velocity) * 0.5;
            droppedweapon = self dropweapon(self.sidearm, "chest", speed);
        }
    }
    self aiutility::setcurrentweapon(level.weaponnone);
    self.a.dropping_weapons = undefined;
}

// Namespace shared/shared
// Params 1, eflags: 0x0
// Checksum 0xbc7486e, Offset: 0x1620
// Size: 0x50
function player_weapon_drop(weapon) {
    if (issubstr(weapon.name, "rpg")) {
        return getweapon("rpg_player");
    }
    return weapon;
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0xcb90ee80, Offset: 0x1678
// Size: 0x24
function handlenotetrack(note, flagname, customfunction, var1) {
    
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0xce4caceb, Offset: 0x16a8
// Size: 0xb4
function donotetracks(flagname, customfunction, debugidentifier, var1) {
    for (;;) {
        waitresult = self waittill(flagname);
        note = waitresult.notetrack;
        if (!isdefined(note)) {
            note = "undefined";
        }
        val = self handlenotetrack(note, flagname, customfunction, var1);
        if (isdefined(val)) {
            return val;
        }
    }
}

// Namespace shared/shared
// Params 3, eflags: 0x0
// Checksum 0x5ecb7bde, Offset: 0x1768
// Size: 0xf4
function donotetracksintercept(flagname, interceptfunction, debugidentifier) {
    assert(isdefined(interceptfunction));
    for (;;) {
        waitresult = self waittill(flagname);
        note = waitresult.notetrack;
        if (!isdefined(note)) {
            note = "undefined";
        }
        intercepted = [[ interceptfunction ]](note);
        if (isdefined(intercepted) && intercepted) {
            continue;
        }
        val = self handlenotetrack(note, flagname);
        if (isdefined(val)) {
            return val;
        }
    }
}

// Namespace shared/shared
// Params 2, eflags: 0x0
// Checksum 0xc021f366, Offset: 0x1868
// Size: 0xcc
function donotetrackspostcallback(flagname, postfunction) {
    assert(isdefined(postfunction));
    for (;;) {
        waitresult = self waittill(flagname);
        note = waitresult.notetrack;
        if (!isdefined(note)) {
            note = "undefined";
        }
        val = self handlenotetrack(note, flagname);
        [[ postfunction ]](note);
        if (isdefined(val)) {
            return val;
        }
    }
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x33f6a98e, Offset: 0x1940
// Size: 0x54
function donotetracksforever(flagname, killstring, customfunction, debugidentifier) {
    donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, debugidentifier);
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x96cfc3d0, Offset: 0x19a0
// Size: 0x54
function donotetracksforeverintercept(flagname, killstring, interceptfunction, debugidentifier) {
    donotetracksforeverproc(&donotetracksintercept, flagname, killstring, interceptfunction, debugidentifier);
}

// Namespace shared/shared
// Params 5, eflags: 0x0
// Checksum 0xec5af579, Offset: 0x1a00
// Size: 0x166
function donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, debugidentifier) {
    if (isdefined(killstring)) {
        self endon(killstring);
    }
    self endon(#"killanimscript");
    if (!isdefined(debugidentifier)) {
        debugidentifier = "undefined";
    }
    for (;;) {
        time = gettime();
        returnednote = [[ notetracksfunc ]](flagname, customfunction, debugidentifier);
        timetaken = gettime() - time;
        if (timetaken < 0.05) {
            time = gettime();
            returnednote = [[ notetracksfunc ]](flagname, customfunction, debugidentifier);
            timetaken = gettime() - time;
            if (timetaken < 0.05) {
                println(gettime() + "<dev string:xa9>" + debugidentifier + "<dev string:xab>" + flagname + "<dev string:xf5>" + returnednote + "<dev string:x101>");
                wait 0.05 - timetaken;
            }
        }
    }
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x1bacbece, Offset: 0x1b70
// Size: 0x94
function donotetracksfortime(time, flagname, customfunction, debugidentifier) {
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify(time);
    donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, debugidentifier, ent);
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x2faad682, Offset: 0x1c10
// Size: 0x94
function donotetracksfortimeintercept(time, flagname, interceptfunction, debugidentifier) {
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify(time);
    donotetracksfortimeproc(&donotetracksforeverintercept, time, flagname, interceptfunction, debugidentifier, ent);
}

// Namespace shared/shared
// Params 6, eflags: 0x0
// Checksum 0xabb20b96, Offset: 0x1cb0
// Size: 0x5c
function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, debugidentifier, ent) {
    ent endon(#"stop_notetracks");
    [[ donotetracksforeverfunc ]](flagname, undefined, customfunction, debugidentifier);
}

// Namespace shared/shared
// Params 1, eflags: 0x0
// Checksum 0x1034e386, Offset: 0x1d18
// Size: 0x1e
function donotetracksfortimeendnotify(time) {
    wait time;
    self notify(#"stop_notetracks");
}

