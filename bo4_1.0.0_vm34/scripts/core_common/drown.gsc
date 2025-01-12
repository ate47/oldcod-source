#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace drown;

// Namespace drown/drown
// Params 0, eflags: 0x2
// Checksum 0x69202e5d, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"drown", &__init__, undefined, undefined);
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x5ceceed2, Offset: 0x110
// Size: 0xe4
function __init__() {
    callback::on_spawned(&function_7123c00e);
    callback::on_connect(&on_connect);
    level.drown_pre_damage_stage_time = 2000;
    if (!isdefined(level.vsmgr_prio_overlay_drown_blur)) {
        level.vsmgr_prio_overlay_drown_blur = 10;
    }
    visionset_mgr::register_info("overlay", "drown_blur", 1, level.vsmgr_prio_overlay_drown_blur, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
    clientfield::register("toplayer", "drown_stage", 1, 3, "int");
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x2285f0ca, Offset: 0x200
// Size: 0x54
function on_connect() {
    self callback::on_death(&function_eed58e6b);
    self callback::function_1dea870d(#"on_end_game", &function_50c0e3fd);
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x1ac4e427, Offset: 0x260
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
// Checksum 0xed10d0f5, Offset: 0x2d8
// Size: 0x4e
function deactivate_player_health_visionset() {
    if (!isdefined(self.drown_vision_set) || self.drown_vision_set) {
        visionset_mgr::deactivate("overlay", "drown_blur", self);
        self.drown_vision_set = 0;
    }
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x4d46fb31, Offset: 0x330
// Size: 0x34
function function_7123c00e() {
    self thread watch_player_drowning();
    self deactivate_player_health_visionset();
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0x79772c5f, Offset: 0x370
// Size: 0x44
function function_50c0e3fd(params) {
    self function_eed58e6b(params);
    self callback::remove_on_death(&function_eed58e6b);
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x372773f3, Offset: 0x3c0
// Size: 0x460
function watch_player_drowning() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    self.lastwaterdamagetime = self getlastoutwatertime();
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    if (!isdefined(self.playerrole)) {
        return;
    }
    while (true) {
        underwater = game.state == "playing" && self isplayerunderwater() && self isplayerswimming();
        var_dc9e1fbc = isdefined(level.var_1ac85360) && level.var_1ac85360 && self inlaststand() && getwaterheight(self.origin) > self getplayercamerapos()[2];
        underwater |= var_dc9e1fbc;
        if (underwater && !(isdefined(self.var_8105b7f6) && self.var_8105b7f6)) {
            n_swimtime = int(self.playerrole.swimtime * 1000);
            if (self hasperk(#"hash_4ef368f54cd86ab7")) {
                n_swimtime = int(n_swimtime * 1.5);
            }
            if (gettime() - self.lastwaterdamagetime > n_swimtime - level.drown_pre_damage_stage_time && self.drownstage == 0) {
                self.drownstage++;
                self clientfield::set_to_player("drown_stage", self.drownstage);
            } else if (self.drownstage == 0 && var_dc9e1fbc) {
                self.drownstage++;
                self clientfield::set_to_player("drown_stage", self.drownstage);
                self.lastwaterdamagetime = gettime() - n_swimtime + int(self.playerrole.var_6b7d0837 * 1000);
            }
            if (gettime() - self.lastwaterdamagetime > n_swimtime) {
                self.lastwaterdamagetime += int(self.playerrole.var_6b7d0837 * 1000);
                self dodamage(self.playerrole.swimdamage, self.origin, undefined, undefined, undefined, "MOD_DROWN", 6);
                self activate_player_health_visionset();
                if (self.drownstage < 4) {
                    self.drownstage++;
                    self clientfield::set_to_player("drown_stage", self.drownstage);
                }
            }
            waitframe(1);
            continue;
        }
        self.drownstage = 0;
        self clientfield::set_to_player("drown_stage", 0);
        self.lastwaterdamagetime = self getlastoutwatertime();
        self deactivate_player_health_visionset();
        wait 0.5;
    }
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0xae87cfe9, Offset: 0x828
// Size: 0x5c
function function_eed58e6b(params = undefined) {
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self deactivate_player_health_visionset();
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xea158614, Offset: 0x890
// Size: 0x3e
function is_player_drowning() {
    drowning = 1;
    if (!isdefined(self.drownstage) || self.drownstage == 0) {
        drowning = 0;
    }
    return drowning;
}

