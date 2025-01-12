#using scripts\core_common\challenges_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\player\player_utils;

#namespace helicopter;

// Namespace helicopter/helicopter
// Params 0, eflags: 0x2
// Checksum 0xa63d7576, Offset: 0x128
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"helicopter", &__init__, undefined, #"killstreaks");
}

// Namespace helicopter/helicopter
// Params 0, eflags: 0x0
// Checksum 0x207d0029, Offset: 0x178
// Size: 0x84
function __init__() {
    level.var_63b9b5b1 = &function_63b9b5b1;
    level.var_8ca610ad = &function_8ca610ad;
    level.var_891a0eff = &function_891a0eff;
    init_shared("killstreak_helicopter_comlink");
    player::function_b0320e78(&function_a0bae9e1, 0);
}

// Namespace helicopter/helicopter
// Params 2, eflags: 0x0
// Checksum 0x167b23ad, Offset: 0x208
// Size: 0xb4
function function_891a0eff(attacker, weapon) {
    if (isdefined(attacker) && isplayer(attacker)) {
        attacker battlechatter::function_b5530e2c(self.killstreaktype, weapon);
        self killstreaks::function_8acf563(attacker, weapon, self.owner);
    }
    if (self.leaving !== 1) {
        self killstreaks::play_destroyed_dialog_on_owner(self.killstreaktype, self.killstreak_id);
    }
}

// Namespace helicopter/helicopter
// Params 1, eflags: 0x0
// Checksum 0xa3b199cb, Offset: 0x2c8
// Size: 0x44
function function_63b9b5b1(hardpointtype) {
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        self challenges::calledincomlinkchopper();
    }
}

// Namespace helicopter/helicopter
// Params 7, eflags: 0x0
// Checksum 0x69ab8ba8, Offset: 0x318
// Size: 0x180
function function_8ca610ad(attacker, weapon, type, weapon_damage, event, playercontrolled, hardpointtype) {
    if (weapon_damage > 0) {
        self challenges::trackassists(attacker, weapon_damage, 0);
    }
    if (isdefined(event)) {
        if (isdefined(self.owner) && self.owner util::isenemyplayer(attacker)) {
            challenges::destroyedhelicopter(attacker, weapon, type, 0);
            challenges::destroyedaircraft(attacker, weapon, playercontrolled);
            scoreevents::processscoreevent(event, attacker, self.owner, weapon);
            attacker challenges::addflyswatterstat(weapon, self);
            if (playercontrolled == 1) {
                attacker challenges::destroyedplayercontrolledaircraft();
            }
            if (hardpointtype == "helicopter_player_gunner") {
                attacker stats::function_4f10b697(weapon, #"destroyed_controlled_killstreak", 1);
            }
        }
    }
}

// Namespace helicopter/helicopter
// Params 9, eflags: 0x0
// Checksum 0xc31a6a02, Offset: 0x4a0
// Size: 0x136
function function_a0bae9e1(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isdefined(einflictor) || !isdefined(einflictor.owner) || !isdefined(attacker) || !isdefined(weapon)) {
        return;
    }
    if (einflictor.owner == attacker && weapon == getweapon(#"cobra_20mm_comlink") && (isdefined(einflictor.lastkillvo) ? einflictor.lastkillvo : 0) < gettime()) {
        einflictor killstreaks::play_pilot_dialog_on_owner("kill", "helicopter_comlink", einflictor.killstreak_id);
        einflictor.lastkillvo = gettime() + 5000;
    }
}

