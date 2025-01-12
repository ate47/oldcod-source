#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace drown;

// Namespace drown/drown
// Params 0, eflags: 0x2
// Checksum 0xa86378a1, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("drown", &__init__, undefined, undefined);
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x4b140185, Offset: 0x258
// Size: 0x14c
function __init__() {
    callback::on_spawned(&on_player_spawned);
    level.drown_damage = getdvarfloat("player_swimDamage");
    level.var_8e026421 = getdvarfloat("player_swimDamagerInterval") * 1000;
    level.var_460fc258 = getdvarfloat("player_swimTime") * 1000;
    level.drown_pre_damage_stage_time = 2000;
    if (!isdefined(level.vsmgr_prio_overlay_drown_blur)) {
        level.vsmgr_prio_overlay_drown_blur = 10;
    }
    visionset_mgr::register_info("overlay", "drown_blur", 1, level.vsmgr_prio_overlay_drown_blur, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
    clientfield::register("toplayer", "drown_stage", 1, 3, "int");
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xb49df9cf, Offset: 0x3b0
// Size: 0x74
function activate_player_health_visionset() {
    self deactivate_player_health_visionset();
    if (!self.drown_vision_set) {
        visionset_mgr::activate("overlay", "drown_blur", self, 0.1, 0.25, 0.1);
        self.drown_vision_set = 1;
    }
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x9baaf88, Offset: 0x430
// Size: 0x50
function deactivate_player_health_visionset() {
    if (!isdefined(self.drown_vision_set) || self.drown_vision_set) {
        visionset_mgr::deactivate("overlay", "drown_blur", self);
        self.drown_vision_set = 0;
    }
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xd4e78d0a, Offset: 0x488
// Size: 0x64
function on_player_spawned() {
    self thread watch_player_drowning();
    self thread function_cb6a2e72();
    self thread watch_game_ended();
    self deactivate_player_health_visionset();
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xf8603fb5, Offset: 0x4f8
// Size: 0x2a0
function watch_player_drowning() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    self.lastwaterdamagetime = self getlastoutwatertime();
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    if (!isdefined(self.var_460fc258)) {
        self.var_460fc258 = level.var_460fc258;
    }
    while (true) {
        if (self isplayerunderwater() && self isplayerswimming()) {
            if (gettime() - self.lastwaterdamagetime > self.var_460fc258 - level.drown_pre_damage_stage_time && self.drownstage == 0) {
                self.drownstage++;
                self clientfield::set_to_player("drown_stage", self.drownstage);
            }
            if (gettime() - self.lastwaterdamagetime > self.var_460fc258) {
                self.lastwaterdamagetime += level.var_8e026421;
                var_b25e4fe = 6;
                self dodamage(level.drown_damage, self.origin, undefined, undefined, undefined, "MOD_DROWN", var_b25e4fe);
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
// Params 0, eflags: 0x0
// Checksum 0x73878b8c, Offset: 0x7a0
// Size: 0x6c
function function_cb6a2e72() {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self waittill("death");
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self deactivate_player_health_visionset();
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x61714a4f, Offset: 0x818
// Size: 0x6c
function watch_game_ended() {
    self endon(#"disconnect");
    self endon(#"death");
    level waittill("game_ended");
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self deactivate_player_health_visionset();
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x9462b557, Offset: 0x890
// Size: 0x42
function is_player_drowning() {
    drowning = 1;
    if (!isdefined(self.drownstage) || self.drownstage == 0) {
        drowning = 0;
    }
    return drowning;
}

