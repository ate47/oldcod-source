#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\laststand_warzone;
#using scripts\mp_common\player\player_damage;

#namespace player;

// Namespace player/player_callbacks
// Params 8, eflags: 0x0
// Checksum 0xa5002f4e, Offset: 0xb0
// Size: 0xc4
function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
    hit = 1;
    if (level.teambased && self.team == eattacker.team) {
        if (level.friendlyfire == 0) {
            hit = 0;
        }
    }
    self finishmeleehit(eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

// Namespace player/player_callbacks
// Params 5, eflags: 0x0
// Checksum 0x37d6b092, Offset: 0x180
// Size: 0x154
function function_72e649b3(attacker, effectname, var_c1550143, durationoverride, weapon) {
    var_4e443908 = function_73b8c15(effectname);
    if (isdefined(durationoverride) && durationoverride > 0) {
        duration = durationoverride;
    } else {
        duration = undefined;
    }
    attackerishittingteammate = isplayer(attacker) && self util::isenemyplayer(attacker) == 0;
    attackerishittingself = isplayer(attacker) && self == attacker;
    if (attackerishittingself && weapon.var_2df68bac) {
        return;
    }
    if (attackerishittingteammate && !function_1595b674(0)) {
        return;
    }
    self status_effect::status_effect_apply(var_4e443908, weapon, attacker, undefined, duration, var_c1550143);
}

// Namespace player/player_callbacks
// Params 1, eflags: 0x0
// Checksum 0xd2b9d094, Offset: 0x2e0
// Size: 0x84
function callback_playershielddamageblocked(damage) {
    previous_shield_damage = self.shielddamageblocked;
    self.shielddamageblocked += damage;
    if (self.shielddamageblocked % 200 < previous_shield_damage % 200) {
        score_event = "shield_blocked_damage";
        scoreevents::processscoreevent(score_event, self, undefined, self.currentweapon);
    }
}

// Namespace player/player_callbacks
// Params 0, eflags: 0x0
// Checksum 0xf45a5c37, Offset: 0x370
// Size: 0xd0
function callback_playermigrated() {
    println("<dev string:x30>" + self.name + "<dev string:x38>" + gettime());
    if (isdefined(self.connected) && self.connected) {
        self globallogic_ui::updateobjectivetext();
    }
    level.hostmigrationreturnedplayercount++;
    if (level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3) {
        println("<dev string:x55>");
        level notify(#"hostmigration_enoughplayers");
    }
}

// Namespace player/player_callbacks
// Params 9, eflags: 0x0
// Checksum 0x23893566, Offset: 0x448
// Size: 0xdc
function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (sessionmodeiswarzonegame()) {
        laststand_warzone::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        return;
    }
    if (isdefined(level.var_67140788)) {
        [[ level.var_67140788 ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    }
}

