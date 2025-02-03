#using script_396f7d71538c9677;
#using script_725554a59d6a75b9;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace drown;

// Namespace drown/drown
// Params 0, eflags: 0x6
// Checksum 0xf9034277, Offset: 0x108
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"drown", &preinit, undefined, undefined, undefined);
}

// Namespace drown/drown
// Params 0, eflags: 0x4
// Checksum 0xeb1b5a84, Offset: 0x150
// Size: 0x11c
function private preinit() {
    callback::on_spawned(&function_27777812);
    callback::on_player_killed(&function_1ef50162);
    callback::add_callback(#"on_end_game", &function_c621d98c);
    level.drown_pre_damage_stage_time = 2000;
    if (!isdefined(level.vsmgr_prio_overlay_drown_blur)) {
        level.vsmgr_prio_overlay_drown_blur = 10;
    }
    visionset_mgr::register_info("overlay", "drown_blur", 1, level.vsmgr_prio_overlay_drown_blur, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
    clientfield::register("toplayer", "drown_stage", 1, 3, "int");
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x46326980, Offset: 0x278
// Size: 0x6a
function activate_player_health_visionset() {
    self deactivate_player_health_visionset();
    if (!self.drown_vision_set) {
        visionset_mgr::activate("overlay", "drown_blur", self, 0.1, 0.25, 0.1);
        self.drown_vision_set = 1;
    }
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x9540a5f2, Offset: 0x2f0
// Size: 0x4e
function deactivate_player_health_visionset() {
    if (!isdefined(self.drown_vision_set) || self.drown_vision_set) {
        visionset_mgr::deactivate("overlay", "drown_blur", self);
        self.drown_vision_set = 0;
    }
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x94a2e877, Offset: 0x348
// Size: 0x4c
function function_27777812() {
    self callback::add_callback(#"underwater", &function_84845e32);
    self deactivate_player_health_visionset();
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0x6a971ad9, Offset: 0x3a0
// Size: 0x24
function function_c621d98c(params) {
    self function_1ef50162(params);
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0x58610848, Offset: 0x3d0
// Size: 0x3c
function function_84845e32(params) {
    if (!isdefined(self.playerrole)) {
        return;
    }
    if (params.underwater) {
        thread watch_player_drowning();
    }
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x74398969, Offset: 0x418
// Size: 0x634
function watch_player_drowning() {
    self endon(#"disconnect", #"death");
    level endon(#"game_ended");
    self clientfield::set_to_player("drown_stage", 0);
    self.lastwaterdamagetime = self getlastoutwatertime();
    self.drownstage = 0;
    var_c1e8fa5d = 4000;
    underwaterbreathtime = 1000;
    underwaterbreathtime = int(battlechatter::mpdialog_value("underwaterBreathTime", 1) * 1000);
    exertbuffer = battlechatter::mpdialog_value("playerExertBuffer", 1);
    while (true) {
        waitframe(1);
        underwater = (game.state == #"pregame" || game.state == #"playing") && self isplayerunderwater();
        var_790acff6 = is_true(level.var_8e910e84) && self inlaststand() && getwaterheight(self.origin) > self getplayercamerapos()[2];
        underwater |= var_790acff6;
        if (underwater && !is_true(self.var_f07d3654)) {
            if (!is_true(self.wasunderwater)) {
                self.wasunderwater = 1;
                self.var_cdefe788 = gettime();
                self stopsounds();
            }
            n_swimtime = int(self.playerrole.swimtime * 1000);
            if (self hasperk(#"hash_4ef368f54cd86ab7")) {
                n_swimtime = int(n_swimtime * 1.5);
            }
            if (gettime() - self.lastwaterdamagetime > n_swimtime - var_c1e8fa5d && self.drownstage == 0) {
                self thread battlechatter::pain_vox("MOD_DROWN");
                var_c1e8fa5d -= int(self.playerrole.var_f0886300 * 1000);
            }
            if (gettime() - self.lastwaterdamagetime > n_swimtime - level.drown_pre_damage_stage_time && self.drownstage == 0) {
                self.drownstage++;
                self clientfield::set_to_player("drown_stage", self.drownstage);
            } else if (self.drownstage == 0 && var_790acff6) {
                self.drownstage++;
                self clientfield::set_to_player("drown_stage", self.drownstage);
                self.lastwaterdamagetime = gettime() - n_swimtime + int(self.playerrole.var_f0886300 * 1000);
            }
            if (gettime() - self.lastwaterdamagetime > n_swimtime) {
                self.lastwaterdamagetime += int(self.playerrole.var_f0886300 * 1000);
                self dodamage(self.playerrole.swimdamage, self.origin, undefined, undefined, undefined, "MOD_DROWN", 6);
                self activate_player_health_visionset();
                if (self.drownstage < 4) {
                    self.drownstage++;
                    self clientfield::set_to_player("drown_stage", self.drownstage);
                }
            }
            continue;
        }
        if (is_true(self.wasunderwater)) {
            if (self.drownstage > 0) {
                thread battlechatter::function_e9f06034(self, 1);
            } else if (gettime() > (isdefined(self.var_cdefe788) ? self.var_cdefe788 : 0) + underwaterbreathtime) {
                thread battlechatter::function_e9f06034(self, 0);
            }
        }
        self.drownstage = 0;
        self clientfield::set_to_player("drown_stage", 0);
        self.lastwaterdamagetime = self getlastoutwatertime();
        self deactivate_player_health_visionset();
        var_c1e8fa5d = 4000;
        self.wasunderwater = 0;
        return;
    }
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0xe20d66ab, Offset: 0xa58
// Size: 0x54
function function_1ef50162(*params) {
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self.wasunderwater = 0;
    self deactivate_player_health_visionset();
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xf13d93a, Offset: 0xab8
// Size: 0x3e
function is_player_drowning() {
    drowning = 1;
    if (!isdefined(self.drownstage) || self.drownstage == 0) {
        drowning = 0;
    }
    return drowning;
}

