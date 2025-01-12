#using scripts\core_common\callbacks_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\killstreak_vehicle;
#using scripts\killstreaks\mp\killstreakrules;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x2
// Checksum 0xc12e2874, Offset: 0x118
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"killstreaks", &__init__, undefined, #"weapons");
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x0
// Checksum 0xc7f486d5, Offset: 0x168
// Size: 0x6e
function __init__() {
    init_shared();
    killstreak_vehicle::init();
    killstreakrules::init();
    callback::on_start_gametype(&init);
    level.var_a58f156 = &play_killstreak_start_dialog;
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x0
// Checksum 0xffe8b2b6, Offset: 0x1e0
// Size: 0x23c
function init() {
    /#
        level.killstreak_init_start_time = getmillisecondsraw();
        thread debug_ricochet_protection();
    #/
    function_7ba8ee28();
    level.var_a25d611f = &function_7ffae23e;
    level.play_killstreak_firewall_being_hacked_dialog = &function_a76d5507;
    level.play_killstreak_firewall_hacked_dialog = &function_fc0c7137;
    level.play_killstreak_being_hacked_dialog = &function_b39bb8c2;
    level.play_killstreak_hacked_dialog = &function_809f6cc2;
    level.play_killstreak_start_dialog = &function_76ea8760;
    level.play_pilot_dialog_on_owner = &function_a000f433;
    level.play_pilot_dialog = &function_dfc58059;
    level.play_destroyed_dialog_on_owner = &function_15fc456a;
    level.play_taacom_dialog_response_on_owner = &function_f9d7f460;
    level.play_taacom_dialog = &function_dac3f1e2;
    level.var_2e2a6dd4 = &function_ac6932af;
    level.var_2f5ed0a0 = &function_9cfc7847;
    level.var_6f9f2a9f = &function_fe31ae;
    callback::callback(#"hash_45f35669076bc317");
    /#
        level.killstreak_init_end_time = getmillisecondsraw();
        elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
        println("<dev string:x30>" + elapsed_time + "<dev string:x4e>");
        level thread killstreak_debug_think();
    #/
}

// Namespace killstreaks/killstreaks
// Params 1, eflags: 0x4
// Checksum 0x825ce80d, Offset: 0x428
// Size: 0x4c
function private function_7ffae23e(killstreaktype) {
    globallogic_score::_setplayermomentum(self, self.momentum - self function_ec6a435b(level.killstreaks[killstreaktype].itemindex));
}

// Namespace killstreaks/killstreaks
// Params 2, eflags: 0x4
// Checksum 0x6e4526c9, Offset: 0x480
// Size: 0x5c
function private function_a76d5507(killstreaktype, killstreakid) {
    if (self killstreak_dialog_queued("firewallBeingHacked", killstreaktype, killstreakid)) {
        return;
    }
    self globallogic_audio::play_taacom_dialog("firewallBeingHacked", killstreaktype, killstreakid);
}

// Namespace killstreaks/killstreaks
// Params 2, eflags: 0x4
// Checksum 0xf3729619, Offset: 0x4e8
// Size: 0x5c
function private function_fc0c7137(killstreaktype, killstreakid) {
    if (self killstreak_dialog_queued("firewallHacked", killstreaktype, killstreakid)) {
        return;
    }
    self globallogic_audio::play_taacom_dialog("firewallHacked", killstreaktype, killstreakid);
}

// Namespace killstreaks/killstreaks
// Params 2, eflags: 0x4
// Checksum 0x962c02ba, Offset: 0x550
// Size: 0x5c
function private function_b39bb8c2(killstreaktype, killstreakid) {
    if (self killstreak_dialog_queued("beingHacked", killstreaktype, killstreakid)) {
        return;
    }
    self globallogic_audio::play_taacom_dialog("beingHacked", killstreaktype, killstreakid);
}

// Namespace killstreaks/killstreaks
// Params 3, eflags: 0x4
// Checksum 0xff274a09, Offset: 0x5b8
// Size: 0x134
function private function_809f6cc2(killstreaktype, killstreakid, hacker) {
    self globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
    self globallogic_audio::play_taacom_dialog("hacked", killstreaktype);
    excludeself = [];
    excludeself[0] = self;
    if (level.teambased) {
        globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].hackeddialogkey, self.team, excludeself);
        globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].hackedstartdialogkey, self.team, undefined, killstreakid);
        return;
    }
    self globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].hackeddialogkey);
    hacker globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].hackedstartdialogkey);
}

// Namespace killstreaks/killstreaks
// Params 3, eflags: 0x4
// Checksum 0xdd72432d, Offset: 0x6f8
// Size: 0x274
function private function_76ea8760(killstreaktype, team, killstreakid) {
    if (!isdefined(killstreaktype) || !isdefined(killstreakid)) {
        return;
    }
    self notify("killstreak_start_" + killstreaktype);
    self notify("killstreak_start_inventory_" + killstreaktype);
    excludeself = [];
    excludeself[0] = self;
    if (level.teambased) {
        if (!isdefined(self.currentkillstreakdialog) && isdefined(level.var_602d80f2)) {
            self thread [[ level.var_602d80f2 ]](level.killstreaks[killstreaktype].requestdialogkey, level.killstreaks[killstreaktype].var_8f7e621a);
        }
        if (isdefined(level.killstreakrules[killstreaktype]) && level.killstreakrules[killstreaktype].curteam[team] > 1) {
            globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartmultipledialogkey, team, undefined, killstreakid);
        } else {
            globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartdialogkey, team, undefined, killstreakid);
        }
        return;
    }
    if (!isdefined(self.currentkillstreakdialog) && isdefined(level.killstreaks[killstreaktype].requestdialogkey) && isdefined(level.heroplaydialog)) {
        self thread [[ level.heroplaydialog ]](level.killstreaks[killstreaktype].requestdialogkey);
    }
    if (isdefined(level.killstreakrules[killstreaktype]) && level.killstreakrules[killstreaktype].cur > 1) {
        globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartmultipledialogkey, team, undefined, killstreakid);
        return;
    }
    globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].enemystartdialogkey, undefined, excludeself, undefined, killstreakid);
}

// Namespace killstreaks/killstreaks
// Params 2, eflags: 0x4
// Checksum 0xd477b58, Offset: 0x978
// Size: 0x8c
function private function_15fc456a(killstreaktype, killstreakid) {
    if (!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team) {
        return;
    }
    self.owner globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
    self.owner globallogic_audio::play_taacom_dialog("destroyed", killstreaktype);
}

// Namespace killstreaks/killstreaks
// Params 3, eflags: 0x4
// Checksum 0xef8821ee, Offset: 0xa10
// Size: 0xa4
function private function_a000f433(dialogkey, killstreaktype, killstreakid) {
    if (!isdefined(self.owner) || !isdefined(self.owner.team) || !isdefined(self.team) || self.team != self.owner.team) {
        return;
    }
    self.owner play_pilot_dialog(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

// Namespace killstreaks/killstreaks
// Params 4, eflags: 0x4
// Checksum 0xe483b7ca, Offset: 0xac0
// Size: 0x5c
function private function_dfc58059(dialogkey, killstreaktype, killstreakid, pilotindex) {
    if (!isdefined(killstreaktype) || !isdefined(pilotindex)) {
        return;
    }
    self globallogic_audio::killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex);
}

// Namespace killstreaks/killstreaks
// Params 3, eflags: 0x4
// Checksum 0xec39d05f, Offset: 0xb28
// Size: 0x3c
function private function_dac3f1e2(dialogkey, killstreaktype, killstreakid) {
    self globallogic_audio::play_taacom_dialog(dialogkey, killstreaktype, killstreakid);
}

// Namespace killstreaks/killstreaks
// Params 3, eflags: 0x4
// Checksum 0x64ee963a, Offset: 0xb70
// Size: 0xbc
function private function_f9d7f460(dialogkey, killstreaktype, killstreakid) {
    assert(isdefined(dialogkey));
    assert(isdefined(killstreaktype));
    if (!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team) {
        return;
    }
    self.owner play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

// Namespace killstreaks/killstreaks
// Params 5, eflags: 0x4
// Checksum 0x1e8bba5b, Offset: 0xc38
// Size: 0x54
function private function_9cfc7847(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
    globallogic_audio::leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
}

// Namespace killstreaks/killstreaks
// Params 6, eflags: 0x4
// Checksum 0x6849f98a, Offset: 0xc98
// Size: 0x5c
function private function_ac6932af(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
    globallogic_audio::leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey);
}

// Namespace killstreaks/killstreaks
// Params 4, eflags: 0x4
// Checksum 0x16bce31, Offset: 0xd00
// Size: 0x44
function private function_fe31ae(event, player, victim, weapon) {
    scoreevents::processscoreevent(event, player, victim, weapon);
}

