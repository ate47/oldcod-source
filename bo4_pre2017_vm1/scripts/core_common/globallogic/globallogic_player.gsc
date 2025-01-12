#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/array_shared;
#using scripts/core_common/burnplayer;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameskill_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/medals_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/core_common/weapons/weapons;
#using scripts/core_common/weapons_shared;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 4, eflags: 0x0
// Checksum 0xadfe24f9, Offset: 0x4f0
// Size: 0x34a
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
// Checksum 0x73e37d47, Offset: 0x848
// Size: 0x4e
function allowedassistweapon(weapon) {
    if (!killstreaks::is_killstreak_weapon(weapon)) {
        return true;
    }
    if (killstreaks::is_killstreak_weapon_assist_allowed(weapon)) {
        return true;
    }
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 5, eflags: 0x0
// Checksum 0xdaa2a89, Offset: 0x8a0
// Size: 0x104
function giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon) {
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
// Checksum 0xe9aa28dd, Offset: 0x9b0
// Size: 0x190
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

