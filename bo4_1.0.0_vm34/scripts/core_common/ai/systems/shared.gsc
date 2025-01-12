#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\init;
#using scripts\core_common\throttle_shared;

#namespace shared;

// Namespace shared/shared
// Params 0, eflags: 0x2
// Checksum 0xce239123, Offset: 0x118
// Size: 0x3c
function autoexec main() {
    level.ai_weapon_throttle = new throttle();
    [[ level.ai_weapon_throttle ]]->initialize(1, 0.1);
}

// Namespace shared/shared
// Params 3, eflags: 0x4
// Checksum 0x222a03, Offset: 0x160
// Size: 0xa4
function private _throwstowedweapon(entity, weapon, weaponmodel) {
    entity waittill(#"death");
    if (isdefined(entity)) {
        weaponmodel unlink();
        entity throwweapon(weapon, gettagforpos("back"), 0, 0);
    }
    weaponmodel delete();
}

// Namespace shared/shared
// Params 3, eflags: 0x0
// Checksum 0xc5f2ce6c, Offset: 0x210
// Size: 0xd4
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
// Checksum 0x49e31799, Offset: 0x2f0
// Size: 0x3ec
function placeweaponon(weapon, position) {
    self notify(#"weapon_position_change");
    if (isstring(weapon)) {
        weapon = getweapon(weapon);
    }
    if (!isdefined(self.weaponinfo[weapon.name])) {
        self init::initweapon(weapon);
    }
    curposition = self.weaponinfo[weapon.name].position;
    assert(curposition == "<dev string:x30>" || self.a.weaponpos[curposition] == weapon);
    if (!isarray(self.a.weaponpos)) {
        self.a.weaponpos = [];
    }
    assert(isarray(self.a.weaponpos));
    assert(position == "<dev string:x30>" || isdefined(self.a.weaponpos[position]), "<dev string:x35>" + position + "<dev string:x47>");
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
    assert(self.a.weaponpos[#"left"] == level.weaponnone || self.a.weaponpos[#"right"] == level.weaponnone);
}

// Namespace shared/shared
// Params 1, eflags: 0x0
// Checksum 0x9acff8b1, Offset: 0x6e8
// Size: 0x6e
function detachweapon(weapon) {
    self.a.weaponpos[self.weaponinfo[weapon.name].position] = level.weaponnone;
    self.weaponinfo[weapon.name].position = "none";
}

// Namespace shared/shared
// Params 2, eflags: 0x0
// Checksum 0x94c0305e, Offset: 0x760
// Size: 0x52
function updatescriptweaponinfoandpos(weapon, position) {
    self.weaponinfo[weapon.name].position = position;
    self.a.weaponpos[position] = weapon;
}

// Namespace shared/shared
// Params 0, eflags: 0x0
// Checksum 0xd5cbe815, Offset: 0x7c0
// Size: 0xa6
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
// Checksum 0xafa1e2e2, Offset: 0x870
// Size: 0x126
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
// Checksum 0x91bbfdc7, Offset: 0x9a0
// Size: 0xd2
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
        assertmsg("<dev string:x49>" + position);
        break;
    }
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x19088498, Offset: 0xa80
// Size: 0x216
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
// Checksum 0x4ed39b98, Offset: 0xca0
// Size: 0x2f4
function dropaiweapon() {
    self endon(#"death");
    if (self.weapon == level.weaponnone) {
        return;
    }
    if (isdefined(self.script_nodropsecondaryweapon) && self.script_nodropsecondaryweapon && self.weapon == self.initial_secondaryweapon) {
        println("<dev string:x6d>" + self.weapon.name + "<dev string:x8d>");
        return;
    } else if (isdefined(self.script_nodropsidearm) && self.script_nodropsidearm && self.weapon == self.sidearm) {
        println("<dev string:x8f>" + self.weapon.name + "<dev string:x8d>");
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
// Checksum 0xee1894a3, Offset: 0xfa0
// Size: 0x3da
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
                    println("<dev string:x6d>" + weapon.name + "<dev string:x8d>");
                    continue;
                }
                if (isdefined(self.script_nodropsidearm) && self.script_nodropsidearm && weapon == self.sidearm) {
                    println("<dev string:x8f>" + weapon.name + "<dev string:x8d>");
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
// Checksum 0x2d39adf, Offset: 0x1388
// Size: 0x10
function player_weapon_drop(weapon) {
    return weapon;
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x78914570, Offset: 0x13a0
// Size: 0x24
function handlenotetrack(note, flagname, customfunction, var1) {
    
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x36760d22, Offset: 0x13d0
// Size: 0xa8
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
// Checksum 0x1f0d30cd, Offset: 0x1480
// Size: 0xd8
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
// Checksum 0x38d119e1, Offset: 0x1560
// Size: 0xb6
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
// Checksum 0xf2dd98a9, Offset: 0x1620
// Size: 0x54
function donotetracksforever(flagname, killstring, customfunction, debugidentifier) {
    donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, debugidentifier);
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x5d362772, Offset: 0x1680
// Size: 0x54
function donotetracksforeverintercept(flagname, killstring, interceptfunction, debugidentifier) {
    donotetracksforeverproc(&donotetracksintercept, flagname, killstring, interceptfunction, debugidentifier);
}

// Namespace shared/shared
// Params 5, eflags: 0x0
// Checksum 0xee722d05, Offset: 0x16e0
// Size: 0x14e
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
                println(gettime() + "<dev string:xa6>" + debugidentifier + "<dev string:xa8>" + flagname + "<dev string:xf2>" + returnednote + "<dev string:xfe>");
                wait 0.05 - timetaken;
            }
        }
    }
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0x125c4e98, Offset: 0x1838
// Size: 0x84
function donotetracksfortime(time, flagname, customfunction, debugidentifier) {
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify(time);
    donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, debugidentifier, ent);
}

// Namespace shared/shared
// Params 4, eflags: 0x0
// Checksum 0xbca94dbd, Offset: 0x18c8
// Size: 0x84
function donotetracksfortimeintercept(time, flagname, interceptfunction, debugidentifier) {
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify(time);
    donotetracksfortimeproc(&donotetracksforeverintercept, time, flagname, interceptfunction, debugidentifier, ent);
}

// Namespace shared/shared
// Params 6, eflags: 0x0
// Checksum 0x332e09e8, Offset: 0x1958
// Size: 0x62
function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, debugidentifier, ent) {
    ent endon(#"stop_notetracks");
    [[ donotetracksforeverfunc ]](flagname, undefined, customfunction, debugidentifier);
}

// Namespace shared/shared
// Params 1, eflags: 0x0
// Checksum 0x939ee3d9, Offset: 0x19c8
// Size: 0x26
function donotetracksfortimeendnotify(time) {
    wait time;
    self notify(#"stop_notetracks");
}

