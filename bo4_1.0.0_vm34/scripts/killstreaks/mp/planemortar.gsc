#using scripts\core_common\challenges_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\planemortar_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\util;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x2
// Checksum 0x771f5e57, Offset: 0x168
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"planemortar", &__init__, undefined, #"killstreaks");
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x0
// Checksum 0x6c6e7797, Offset: 0x1b8
// Size: 0xcc
function __init__() {
    init_shared();
    bundle = struct::get_script_bundle("killstreak", "killstreak_planemortar");
    killstreaks::register_bundle(bundle, &usekillstreakplanemortar);
    level.plane_mortar_bda_dialog = &plane_mortar_bda_dialog;
    level.planeawardscoreevent = &planeawardscoreevent;
    level.var_86d52c42 = &function_86d52c42;
    killstreaks::set_team_kill_penalty_scale("planemortar", level.teamkillreducedpenalty);
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x0
// Checksum 0xcea3244, Offset: 0x290
// Size: 0x84
function function_86d52c42() {
    if (!isdefined(self.pers[#"mortarradarused"]) || !self.pers[#"mortarradarused"]) {
        otherteam = util::getotherteam(self.team);
        globallogic_audio::leader_dialog("enemyPlaneMortarUsed", otherteam);
    }
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x0
// Checksum 0x97af658a, Offset: 0x320
// Size: 0x186
function plane_mortar_bda_dialog() {
    if (isdefined(self.planemortarbda)) {
        if (self.planemortarbda === 1) {
            bdadialog = "kill1";
        } else if (self.planemortarbda === 2) {
            bdadialog = "kill2";
        } else if (self.planemortarbda === 3) {
            bdadialog = "kill3";
        } else if (isdefined(self.planemortarbda) && self.planemortarbda > 3) {
            bdadialog = "killMultiple";
        }
        self killstreaks::play_pilot_dialog(bdadialog, "planemortar", undefined, self.planemortarpilotindex);
        if (battlechatter::dialog_chance("taacomPilotKillConfirmChance")) {
            self killstreaks::play_taacom_dialog_response("killConfirmed", "planemortar", undefined, self.planemortarpilotindex);
        } else {
            self globallogic_audio::play_taacom_dialog("confirmHit");
        }
    } else {
        killstreaks::play_pilot_dialog("killNone", "planemortar", undefined, self.planemortarpilotindex);
        globallogic_audio::play_taacom_dialog("confirmMiss");
    }
    self.planemortarbda = undefined;
}

// Namespace planemortar/planemortar
// Params 2, eflags: 0x0
// Checksum 0xb9c64524, Offset: 0x4b0
// Size: 0x14c
function planeawardscoreevent(attacker, plane) {
    attacker endon(#"disconnect");
    attacker notify(#"planeawardscoreevent_singleton");
    attacker endon(#"planeawardscoreevent_singleton");
    waittillframeend();
    if (isdefined(attacker) && (!isdefined(plane.owner) || plane.owner util::isenemyplayer(attacker))) {
        challenges::destroyedaircraft(attacker, getweapon(#"emp"), 0);
        scoreevents::processscoreevent(#"destroyed_plane_mortar", attacker, plane.owner, getweapon(#"emp"));
        attacker challenges::addflyswatterstat(getweapon(#"emp"), plane);
    }
}

