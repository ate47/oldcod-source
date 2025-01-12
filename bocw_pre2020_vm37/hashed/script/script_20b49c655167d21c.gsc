#using script_1cc417743d7c262d;
#using script_4721de209091b1a6;
#using scripts\core_common\battlechatter;

#namespace namespace_f9b02f80;

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 0, eflags: 0x1 linked
// Checksum 0x88403f32, Offset: 0x100
// Size: 0x154
function init() {
    level.play_killstreak_firewall_being_hacked_dialog = &function_427f6a2e;
    level.play_killstreak_firewall_hacked_dialog = &function_6fa91236;
    level.play_killstreak_being_hacked_dialog = &function_1cd175ba;
    level.play_killstreak_hacked_dialog = &function_520a5752;
    level.play_killstreak_start_dialog = &function_7bed52a;
    level.play_pilot_dialog_on_owner = &function_9716fce9;
    level.play_pilot_dialog = &function_f6370f75;
    level.play_destroyed_dialog_on_owner = &function_6a5cc212;
    level.play_taacom_dialog_response_on_owner = &function_3cf68327;
    level.play_taacom_dialog = &function_3d6e0cd9;
    level.var_514f9d20 = &function_b11487a4;
    level.var_992ad5b3 = &function_a7a52384;
    level.var_6d7da491 = &function_d49b5eff;
    level.var_9f8e080d = &function_ed335136;
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x5 linked
// Checksum 0x7ce3a013, Offset: 0x260
// Size: 0x5c
function private function_427f6a2e(killstreaktype, killstreakid) {
    if (self killstreak_dialog_queued("firewallBeingHacked", killstreaktype, killstreakid)) {
        return;
    }
    self globallogic_audio::play_taacom_dialog("firewallBeingHacked", killstreaktype, killstreakid);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x5 linked
// Checksum 0x532007d9, Offset: 0x2c8
// Size: 0x5c
function private function_6fa91236(killstreaktype, killstreakid) {
    if (self killstreak_dialog_queued("firewallHacked", killstreaktype, killstreakid)) {
        return;
    }
    self globallogic_audio::play_taacom_dialog("firewallHacked", killstreaktype, killstreakid);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x5 linked
// Checksum 0xb1b6baab, Offset: 0x330
// Size: 0x5c
function private function_1cd175ba(killstreaktype, killstreakid) {
    if (self killstreak_dialog_queued("beingHacked", killstreaktype, killstreakid)) {
        return;
    }
    self globallogic_audio::play_taacom_dialog("beingHacked", killstreaktype, killstreakid);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x5 linked
// Checksum 0x44321ca6, Offset: 0x398
// Size: 0x13c
function private function_520a5752(killstreaktype, killstreakid, hacker) {
    self globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
    self globallogic_audio::play_taacom_dialog("hacked", killstreaktype);
    if (level.teambased) {
        globallogic_audio::function_b4319f8e(level.killstreaks[killstreaktype].script_bundle.var_335def6c, self.team, self);
        globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].script_bundle.var_7a502c34, self.team, undefined, killstreakid);
        return;
    }
    self globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].script_bundle.var_335def6c);
    hacker globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].script_bundle.var_7a502c34);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x5 linked
// Checksum 0xc3f06dfe, Offset: 0x4e0
// Size: 0x274
function private function_7bed52a(killstreaktype, team, killstreakid) {
    if (!isdefined(killstreaktype) || !isdefined(killstreakid)) {
        return;
    }
    self notify("killstreak_start_" + killstreaktype);
    self notify("killstreak_start_inventory_" + killstreaktype);
    excludeself = [];
    excludeself[0] = self;
    if (level.teambased) {
        if (!isdefined(self.currentkillstreakdialog)) {
            self thread battlechatter::function_fff18afc(level.killstreaks[killstreaktype].script_bundle.var_c236921c, level.killstreaks[killstreaktype].script_bundle.var_f5871fe4);
        }
        if (isdefined(level.killstreakrules[killstreaktype]) && level.killstreakrules[killstreaktype].curteam[team] > 1) {
            globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].script_bundle.var_7742570a, team, undefined, killstreakid);
        } else {
            globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].script_bundle.var_2451b1f2, team, undefined, killstreakid);
        }
        return;
    }
    if (!isdefined(self.currentkillstreakdialog) && isdefined(level.killstreaks[killstreaktype].script_bundle.var_c236921c)) {
        self thread battlechatter::function_576ff6fe(killstreaktype);
    }
    if (isdefined(level.killstreakrules[killstreaktype]) && level.killstreakrules[killstreaktype].cur > 1) {
        globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].script_bundle.var_7742570a, team, undefined, killstreakid);
        return;
    }
    globallogic_audio::function_b4319f8e(level.killstreaks[killstreaktype].script_bundle.var_2451b1f2, undefined, excludeself, undefined, killstreakid);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 2, eflags: 0x5 linked
// Checksum 0x8ba42db7, Offset: 0x760
// Size: 0x8c
function private function_6a5cc212(killstreaktype, killstreakid) {
    if (!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team) {
        return;
    }
    self.owner globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
    self.owner globallogic_audio::play_taacom_dialog("destroyed", killstreaktype);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x5 linked
// Checksum 0xca994df5, Offset: 0x7f8
// Size: 0x9c
function private function_9716fce9(dialogkey, killstreaktype, killstreakid) {
    if (!isdefined(self.owner) || !isdefined(self.owner.team) || !isdefined(self.team) || self.team != self.owner.team) {
        return;
    }
    self.owner play_pilot_dialog(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 4, eflags: 0x5 linked
// Checksum 0x73f1cc7d, Offset: 0x8a0
// Size: 0x5c
function private function_f6370f75(dialogkey, killstreaktype, killstreakid, pilotindex) {
    if (!isdefined(killstreaktype) || !isdefined(pilotindex)) {
        return;
    }
    self globallogic_audio::killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 7, eflags: 0x5 linked
// Checksum 0x468c57b7, Offset: 0x908
// Size: 0x5c
function private function_3d6e0cd9(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority) {
    self globallogic_audio::play_taacom_dialog(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 3, eflags: 0x5 linked
// Checksum 0xbb26aa3d, Offset: 0x970
// Size: 0xb4
function private function_3cf68327(dialogkey, killstreaktype, killstreakid) {
    assert(isdefined(dialogkey));
    assert(isdefined(killstreaktype));
    if (!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team) {
        return;
    }
    self.owner play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 5, eflags: 0x5 linked
// Checksum 0xac891a06, Offset: 0xa30
// Size: 0x4c
function private function_ed335136(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
    globallogic_audio::leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 5, eflags: 0x5 linked
// Checksum 0xfaa19264, Offset: 0xa88
// Size: 0x4c
function private function_b11487a4(dialogkey, team, objectivekey, killstreakid, dialogbufferkey) {
    globallogic_audio::leader_dialog(dialogkey, team, objectivekey, killstreakid, dialogbufferkey);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 6, eflags: 0x5 linked
// Checksum 0x51bde784, Offset: 0xae0
// Size: 0x54
function private function_a7a52384(dialogkey, team, exclusion, objectivekey, killstreakid, dialogbufferkey) {
    globallogic_audio::function_b4319f8e(dialogkey, team, exclusion, objectivekey, killstreakid, dialogbufferkey);
}

// Namespace namespace_f9b02f80/namespace_f9b02f80
// Params 6, eflags: 0x5 linked
// Checksum 0xfdc689fd, Offset: 0xb40
// Size: 0x54
function private function_d49b5eff(dialogkey, team, exclusions, objectivekey, killstreakid, dialogbufferkey) {
    globallogic_audio::function_248fc9f7(dialogkey, team, exclusions, objectivekey, killstreakid, dialogbufferkey);
}

