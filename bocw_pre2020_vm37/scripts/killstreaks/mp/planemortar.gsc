#using script_1cc417743d7c262d;
#using script_396f7d71538c9677;
#using script_4721de209091b1a6;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\planemortar_shared;
#using scripts\mp_common\util;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x6
// Checksum 0x78a8492f, Offset: 0x178
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"planemortar", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x5 linked
// Checksum 0xd32ebbbd, Offset: 0x1c8
// Size: 0xbc
function private function_70a657d8() {
    init_shared();
    bundlename = "killstreak_planemortar";
    if (sessionmodeiswarzonegame()) {
        bundlename += "_wz";
    }
    killstreaks::register_killstreak(bundlename, &usekillstreakplanemortar);
    level.plane_mortar_bda_dialog = &plane_mortar_bda_dialog;
    level.planeawardscoreevent = &planeawardscoreevent;
    level.var_269fec2 = &function_269fec2;
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x1 linked
// Checksum 0x145fed43, Offset: 0x290
// Size: 0x8e
function function_269fec2() {
    if (isdefined(level.var_30264985)) {
        self notify(#"mortarradarused");
    }
    if (!isdefined(self.var_6e5974d2) || self.var_6e5974d2 + int(10 * 1000) < gettime()) {
        globallogic_audio::leader_dialog_for_other_teams("enemyPlaneMortarUsed", self.team);
        self.var_6e5974d2 = gettime();
    }
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x1 linked
// Checksum 0x726a5740, Offset: 0x328
// Size: 0x1de
function plane_mortar_bda_dialog() {
    self.planemortarpilotindex = 0;
    if (isdefined(self.planemortarbda)) {
        if (self.planemortarbda === 1) {
            bdadialog = "kill1";
        } else if (self.planemortarbda === 2) {
            bdadialog = "kill2";
        } else if (self.planemortarbda === 3) {
            bdadialog = "kill3";
        } else if (self.planemortarbda > 3) {
            bdadialog = "killMultiple";
        }
        self namespace_f9b02f80::play_pilot_dialog(bdadialog, "planemortar", undefined, self.planemortarpilotindex);
        self namespace_f9b02f80::play_taacom_dialog("confirmHit");
    } else if (is_true(self.("planemortar" + "_hitconfirmed"))) {
        self namespace_f9b02f80::play_pilot_dialog("hitConfirmed_p0", "planemortar", undefined, self.planemortarpilotindex);
        self namespace_f9b02f80::play_taacom_dialog("confirmHit");
    } else {
        self namespace_f9b02f80::play_pilot_dialog("killNone", "planemortar", undefined, self.planemortarpilotindex);
        self namespace_f9b02f80::play_taacom_dialog("confirmMiss");
    }
    self.planemortarbda = undefined;
    self.("planemortar" + "_hitconfirmed") = undefined;
    self.var_6e5974d2 = undefined;
}

// Namespace planemortar/planemortar
// Params 2, eflags: 0x1 linked
// Checksum 0x8da815d5, Offset: 0x510
// Size: 0x14c
function planeawardscoreevent(attacker, plane) {
    attacker endon(#"disconnect");
    attacker notify(#"planeawardscoreevent_singleton");
    attacker endon(#"planeawardscoreevent_singleton");
    waittillframeend();
    if (isdefined(attacker) && (!isdefined(plane.owner) || plane.owner util::isenemyplayer(attacker))) {
        challenges::destroyedaircraft(attacker, getweapon(#"emp"), 0, 1);
        scoreevents::processscoreevent(#"destroyed_plane_mortar", attacker, plane.owner, getweapon(#"emp"));
        attacker challenges::addflyswatterstat(getweapon(#"emp"), plane);
    }
}

