#using scripts\core_common\vehicle_shared;

#namespace damage;

// Namespace damage/damage
// Params 3, eflags: 0x0
// Checksum 0x337e7f86, Offset: 0x70
// Size: 0x348
function friendlyfirecheck(owner, attacker, forcedfriendlyfirerule) {
    if (!isdefined(owner)) {
        return true;
    }
    if (!level.teambased) {
        return true;
    }
    friendlyfirerule = [[ level.figure_out_friendly_fire ]](undefined);
    if (isdefined(forcedfriendlyfirerule)) {
        friendlyfirerule = forcedfriendlyfirerule;
    }
    if (friendlyfirerule != 0) {
        return true;
    }
    if (attacker == owner) {
        return true;
    }
    if (isplayer(attacker)) {
        ownerteam = owner.team;
        if (!isdefined(ownerteam) && isdefined(owner.pers)) {
            ownerteam = owner.pers[#"team"];
        }
        if (!isdefined(attacker.pers[#"team"])) {
            return true;
        }
        if (attacker.pers[#"team"] != ownerteam) {
            return true;
        }
    } else if (isactor(attacker)) {
        ownerteam = owner.team;
        if (!isdefined(ownerteam) && isdefined(owner.pers)) {
            ownerteam = owner.pers[#"team"];
        }
        if (attacker.team != ownerteam) {
            return true;
        }
    } else if (isvehicle(attacker)) {
        if (isdefined(attacker.owner) && isplayer(attacker.owner)) {
            ownerteam = owner.team;
            if (!isdefined(ownerteam) && isdefined(owner.pers)) {
                ownerteam = owner.pers[#"team"];
            }
            if (attacker.owner.pers[#"team"] != ownerteam) {
                return true;
            }
        } else {
            occupant_team = attacker vehicle::vehicle_get_occupant_team();
            if (isplayer(owner)) {
                if (occupant_team != owner.pers[#"team"] && occupant_team != #"spectator") {
                    return true;
                }
            } else if (owner.team !== occupant_team) {
                return true;
            }
        }
    }
    return false;
}

