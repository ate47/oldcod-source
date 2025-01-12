#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace drown;

// Namespace drown/drown
// Params 0, eflags: 0x2
// Checksum 0x86dfb86d, Offset: 0xc0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"drown", &__init__, undefined, #"visionset_mgr");
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xf4847478, Offset: 0x110
// Size: 0xbc
function __init__() {
    clientfield::register("toplayer", "drown_stage", 1, 3, "int", &drown_stage_callback, 0, 0);
    callback::on_localplayer_spawned(&player_spawned);
    visionset_mgr::register_overlay_info_style_speed_blur("drown_blur", 1, 1, 0.04, 1, 1, 0, 0, 125, 125, 0);
    setup_radius_values();
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x5427c75e, Offset: 0x1d8
// Size: 0x53c
function setup_radius_values() {
    level.drown_radius[#"inner"][#"begin"][1] = 0.8;
    level.drown_radius[#"inner"][#"begin"][2] = 0.6;
    level.drown_radius[#"inner"][#"begin"][3] = 0.6;
    level.drown_radius[#"inner"][#"begin"][4] = 0.5;
    level.drown_radius[#"inner"][#"end"][1] = 0.5;
    level.drown_radius[#"inner"][#"end"][2] = 0.3;
    level.drown_radius[#"inner"][#"end"][3] = 0.3;
    level.drown_radius[#"inner"][#"end"][4] = 0.2;
    level.drown_radius[#"outer"][#"begin"][1] = 1;
    level.drown_radius[#"outer"][#"begin"][2] = 0.8;
    level.drown_radius[#"outer"][#"begin"][3] = 0.8;
    level.drown_radius[#"outer"][#"begin"][4] = 0.7;
    level.drown_radius[#"outer"][#"end"][1] = 0.8;
    level.drown_radius[#"outer"][#"end"][2] = 0.6;
    level.drown_radius[#"outer"][#"end"][3] = 0.6;
    level.drown_radius[#"outer"][#"end"][4] = 0.5;
    level.opacity[#"begin"][1] = 0.4;
    level.opacity[#"begin"][2] = 0.5;
    level.opacity[#"begin"][3] = 0.6;
    level.opacity[#"begin"][4] = 0.6;
    level.opacity[#"end"][1] = 0.5;
    level.opacity[#"end"][2] = 0.6;
    level.opacity[#"end"][3] = 0.7;
    level.opacity[#"end"][4] = 0.7;
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0xecff5d4f, Offset: 0x720
// Size: 0x54
function player_spawned(localclientnum) {
    if (!self function_60dbc438()) {
        return;
    }
    self player_init_drown_values();
    self thread player_watch_drown_shutdown(localclientnum);
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x39d51e51, Offset: 0x780
// Size: 0x3e
function player_init_drown_values() {
    if (!isdefined(self.drown_start_time)) {
        self.drown_start_time = 0;
        self.drown_outerradius = 0;
        self.drown_innerradius = 0;
        self.drown_opacity = 0;
    }
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0x3bb98733, Offset: 0x7c8
// Size: 0x3c
function player_watch_drown_shutdown(localclientnum) {
    self waittill(#"death");
    self disable_drown(localclientnum);
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xfd0f0a87, Offset: 0x810
// Size: 0x6a
function function_2c7b3c5a() {
    playerrole = self getrolefields();
    assert(isdefined(playerrole));
    return int(playerrole.var_6b7d0837 * 1000);
}

// Namespace drown/drown
// Params 2, eflags: 0x0
// Checksum 0x971bc09, Offset: 0x888
// Size: 0xaa
function enable_drown(localclientnum, stage) {
    filter::init_filter_drowning_damage(localclientnum);
    filter::enable_filter_drowning_damage(localclientnum, 1);
    self.drown_start_time = getservertime(localclientnum) - (stage - 1) * self function_2c7b3c5a();
    self.drown_outerradius = 0;
    self.drown_innerradius = 0;
    self.drown_opacity = 0;
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0x63f12e58, Offset: 0x940
// Size: 0x24
function disable_drown(localclientnum) {
    filter::disable_filter_drowning_damage(localclientnum, 1);
}

// Namespace drown/drown
// Params 2, eflags: 0x0
// Checksum 0x9d939437, Offset: 0x970
// Size: 0x32e
function player_drown_fx(localclientnum, stage) {
    self endon(#"death");
    self endon(#"player_fade_out_drown_fx");
    self notify(#"player_drown_fx");
    self endon(#"player_drown_fx");
    self player_init_drown_values();
    var_6b7d0837 = self function_2c7b3c5a();
    lastoutwatertimestage = self.drown_start_time + (stage - 1) * var_6b7d0837;
    stageduration = var_6b7d0837;
    if (stage == 1) {
        stageduration = 2000;
    }
    while (true) {
        currenttime = getservertime(localclientnum);
        elapsedtime = currenttime - self.drown_start_time;
        stageratio = math::clamp((currenttime - lastoutwatertimestage) / stageduration, 0, 1);
        self.drown_outerradius = lerpfloat(level.drown_radius[#"outer"][#"begin"][stage], level.drown_radius[#"outer"][#"end"][stage], stageratio) * 1.41421;
        self.drown_innerradius = lerpfloat(level.drown_radius[#"inner"][#"begin"][stage], level.drown_radius[#"inner"][#"end"][stage], stageratio) * 1.41421;
        self.drown_opacity = lerpfloat(level.opacity[#"begin"][stage], level.opacity[#"end"][stage], stageratio);
        filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, self.drown_innerradius);
        filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, self.drown_outerradius);
        filter::set_filter_drowning_damage_opacity(localclientnum, 1, self.drown_opacity);
        waitframe(1);
    }
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0xa06fd8f4, Offset: 0xca8
// Size: 0x1f4
function player_fade_out_drown_fx(localclientnum) {
    self endon(#"death");
    self endon(#"player_drown_fx");
    self notify(#"player_fade_out_drown_fx");
    self endon(#"player_fade_out_drown_fx");
    self player_init_drown_values();
    fadestarttime = getservertime(localclientnum);
    for (currenttime = getservertime(localclientnum); currenttime - fadestarttime < 250; currenttime = getservertime(localclientnum)) {
        ratio = (currenttime - fadestarttime) / 250;
        outerradius = lerpfloat(self.drown_outerradius, 1.41421, ratio);
        innerradius = lerpfloat(self.drown_innerradius, 1.41421, ratio);
        opacity = lerpfloat(self.drown_opacity, 0, ratio);
        filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, outerradius);
        filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, innerradius);
        filter::set_filter_drowning_damage_opacity(localclientnum, 1, opacity);
        waitframe(1);
    }
    self disable_drown(localclientnum);
}

// Namespace drown/drown
// Params 7, eflags: 0x0
// Checksum 0xc8afd43f, Offset: 0xea8
// Size: 0xb4
function drown_stage_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        self enable_drown(localclientnum, newval);
        self thread player_drown_fx(localclientnum, newval);
        return;
    }
    if (!bnewent) {
        self thread player_fade_out_drown_fx(localclientnum);
        return;
    }
    self disable_drown(localclientnum);
}

