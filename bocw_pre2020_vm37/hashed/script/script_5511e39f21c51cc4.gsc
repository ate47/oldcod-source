#using script_4721de209091b1a6;
#using scripts\core_common\battlechatter;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\challenges;
#using scripts\mp_common\player\player_utils;

#namespace helicopter;

// Namespace helicopter/helicopter_guard
// Params 0, eflags: 0x6
// Checksum 0xc5c7bef8, Offset: 0x138
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"helicopter_guard", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace helicopter/helicopter_guard
// Params 0, eflags: 0x5 linked
// Checksum 0x3e0e9306, Offset: 0x188
// Size: 0x104
function private function_70a657d8() {
    level.var_34f03cda = &function_34f03cda;
    level.var_4d5e1035 = &function_4d5e1035;
    level.var_6af968ce = &function_6af968ce;
    bundle = "killstreak_helicopter_guard";
    if (sessionmodeiswarzonegame()) {
        bundle = "killstreak_helicopter_guard_wz";
    }
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        killstreaks::register_killstreak(bundle, &usekillstreakhelicopter);
    }
    init_shared();
    player::function_cf3aa03d(&function_d45a1f8d, 0);
}

// Namespace helicopter/helicopter_guard
// Params 3, eflags: 0x1 linked
// Checksum 0x6e6c408e, Offset: 0x298
// Size: 0x144
function function_6af968ce(attacker, weapon, mod) {
    if (isdefined(attacker) && isplayer(attacker)) {
        if (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker)) {
            attacker battlechatter::function_eebf94f6(self.killstreaktype);
            self killstreaks::function_73566ec7(attacker, weapon, self.owner);
            challenges::destroyedhelicopter(attacker, weapon, mod, 0);
            attacker challenges::addflyswatterstat(weapon, self);
            attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
        }
    }
    if (self.leaving !== 1) {
        self namespace_f9b02f80::play_destroyed_dialog_on_owner(self.killstreaktype, self.killstreak_id);
    }
}

// Namespace helicopter/helicopter_guard
// Params 1, eflags: 0x1 linked
// Checksum 0x458843ef, Offset: 0x3e8
// Size: 0xc
function function_34f03cda(*hardpointtype) {
    
}

// Namespace helicopter/helicopter_guard
// Params 7, eflags: 0x1 linked
// Checksum 0x9784adc4, Offset: 0x400
// Size: 0x168
function function_4d5e1035(attacker, weapon, type, weapon_damage, event, playercontrolled, hardpointtype) {
    if (weapon_damage > 0) {
        self challenges::trackassists(attacker, weapon_damage, 0);
    }
    if (isdefined(event)) {
        if (isdefined(self.owner) && self.owner util::isenemyplayer(attacker)) {
            challenges::destroyedhelicopter(attacker, weapon, type, 0);
            challenges::destroyedaircraft(attacker, weapon, playercontrolled, 1);
            scoreevents::processscoreevent(event, attacker, self.owner, weapon);
            attacker challenges::addflyswatterstat(weapon, self);
            if (playercontrolled == 1) {
                attacker challenges::destroyedplayercontrolledaircraft();
            }
            if (hardpointtype == "helicopter_player_gunner") {
                attacker stats::function_e24eec31(weapon, #"destroyed_controlled_killstreak", 1);
            }
        }
    }
}

// Namespace helicopter/helicopter_guard
// Params 9, eflags: 0x1 linked
// Checksum 0x237d656e, Offset: 0x570
// Size: 0x12e
function function_d45a1f8d(einflictor, attacker, *idamage, *smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    if (!isdefined(shitloc) || !isdefined(shitloc.owner) || !isdefined(psoffsettime) || !isdefined(deathanimduration)) {
        return;
    }
    if (shitloc.owner == psoffsettime && deathanimduration == getweapon(#"cobra_20mm_comlink") && (isdefined(shitloc.lastkillvo) ? shitloc.lastkillvo : 0) < gettime()) {
        shitloc namespace_f9b02f80::play_pilot_dialog_on_owner("kill", "helicopter_guard", shitloc.killstreak_id);
        shitloc.lastkillvo = gettime() + 5000;
    }
}

