#using scripts\core_common\weapons_shared;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x71b0591c, Offset: 0x90
// Size: 0x36a
function function_94420886(eattacker, einflictor, idamage, smeansofdeath, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    if (!isplayer(eattacker)) {
        return;
    }
    assert(isarray(self.attackerdata));
    if (self.attackerdata.size == 0) {
        self.firsttimedamaged = gettime();
    }
    if (self.attackerdata.size == 0 || !isdefined(self.attackerdata[eattacker.clientid])) {
        self.attackerdamage[eattacker.clientid] = spawnstruct();
        self.attackerdamage[eattacker.clientid].damage = idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        self.attackerdamage[eattacker.clientid].time = gettime();
        self.attackerdamage[eattacker.clientid].lastdamagetime = gettime();
        self.attackerdamage[eattacker.clientid].einflictor = einflictor;
        self.attackers[self.attackers.size] = eattacker;
        self.attackerdata[eattacker.clientid] = 0;
    } else {
        self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        self.attackerdamage[eattacker.clientid].lastdamagetime = gettime();
        if (!isdefined(self.attackerdamage[eattacker.clientid].time)) {
            self.attackerdamage[eattacker.clientid].time = gettime();
        }
    }
    if (isarray(self.attackersthisspawn)) {
        self.attackersthisspawn[eattacker.clientid] = eattacker;
    }
    self.attackerdamage[eattacker.clientid].lasttimedamaged = gettime();
    if (weapons::is_primary_weapon(weapon)) {
        self.attackerdata[eattacker.clientid] = 1;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x25de70e2, Offset: 0x408
// Size: 0xc4
function function_dd73496a(eattacker, einflictor, idamage, smeansofdeath, weapon) {
    self function_94420886(eattacker, einflictor, idamage, smeansofdeath, weapon);
    if (!isdefined(einflictor)) {
        return;
    }
    if (!isdefined(einflictor.owner)) {
        return;
    }
    if (isdefined(eattacker) && eattacker == einflictor.owner) {
        return;
    }
    self function_94420886(einflictor.owner, einflictor, idamage, smeansofdeath, weapon);
}

// Namespace globallogic_player/globallogic_player
// Params 4, eflags: 0x0
// Checksum 0x99118429, Offset: 0x4d8
// Size: 0x302
function trackattackerdamage(eattacker, idamage, smeansofdeath, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    if (!isplayer(eattacker)) {
        return;
    }
    assert(isarray(self.attackerdata));
    if (self.attackerdata.size == 0) {
        self.firsttimedamaged = gettime();
    }
    if (self.attackerdata.size == 0 || !isdefined(self.attackerdata[eattacker.clientid])) {
        self.attackerdamage[eattacker.clientid] = spawnstruct();
        self.attackerdamage[eattacker.clientid].damage = idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        self.attackerdamage[eattacker.clientid].time = gettime();
        self.attackers[self.attackers.size] = eattacker;
        self.attackerdata[eattacker.clientid] = 0;
    } else {
        self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        if (!isdefined(self.attackerdamage[eattacker.clientid].time)) {
            self.attackerdamage[eattacker.clientid].time = gettime();
        }
    }
    if (isarray(self.attackersthisspawn)) {
        self.attackersthisspawn[eattacker.clientid] = eattacker;
    }
    self.attackerdamage[eattacker.clientid].lasttimedamaged = gettime();
    if (weapons::is_primary_weapon(weapon)) {
        self.attackerdata[eattacker.clientid] = 1;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xa5e361f7, Offset: 0x7e8
// Size: 0x32
function allowedassistweapon(weapon) {
    if (isdefined(level.var_4df933c4)) {
        return [[ level.var_4df933c4 ]](weapon);
    }
    return 0;
}

// Namespace globallogic_player/globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x3cc9fee1, Offset: 0x828
// Size: 0x144
function giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon) {
    if (isdefined(level.var_3867395b) && level.var_3867395b) {
        function_dd73496a(eattacker, einflictor, idamage, smeansofdeath, weapon);
        return;
    }
    if (!allowedassistweapon(weapon)) {
        return;
    }
    self trackattackerdamage(eattacker, idamage, smeansofdeath, weapon);
    if (!isdefined(einflictor)) {
        return;
    }
    if (!isdefined(einflictor.owner)) {
        return;
    }
    if (!isdefined(einflictor.ownergetsassist)) {
        return;
    }
    if (!einflictor.ownergetsassist) {
        return;
    }
    if (isdefined(eattacker) && eattacker == einflictor.owner) {
        return;
    }
    self trackattackerdamage(einflictor.owner, idamage, smeansofdeath, weapon);
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xf4ed76de, Offset: 0x978
// Size: 0xf2
function function_5bc7cfdb(einflictor) {
    if (!isdefined(self.var_aad77fda)) {
        return;
    }
    if (isplayer(einflictor)) {
        return;
    }
    if (!isdefined(einflictor)) {
        return;
    }
    if (!isplayer(einflictor.owner)) {
        return;
    }
    entnum = einflictor getentitynumber();
    if (!isdefined(self.var_aad77fda[entnum])) {
        self.var_aad77fda[entnum] = spawnstruct();
        self.var_aad77fda[entnum].owner = einflictor.owner;
        self.var_aad77fda[entnum].vehicletype = einflictor.vehicletype;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x0
// Checksum 0x475746fe, Offset: 0xa78
// Size: 0x16e
function figureoutattacker(eattacker) {
    if (isdefined(eattacker)) {
        if (isai(eattacker) && isdefined(eattacker.script_owner)) {
            team = self.team;
            if (isai(self) && isdefined(self.team)) {
                team = self.team;
            }
            if (eattacker.script_owner.team != team) {
                eattacker = eattacker.script_owner;
            }
        }
        if (eattacker.classname == "script_vehicle" && isdefined(eattacker.owner) && !issentient(eattacker)) {
            eattacker = eattacker.owner;
        } else if (eattacker.classname == "auto_turret" && isdefined(eattacker.owner)) {
            eattacker = eattacker.owner;
        }
        if (isdefined(eattacker.remote_owner)) {
            eattacker = eattacker.remote_owner;
        }
    }
    return eattacker;
}

