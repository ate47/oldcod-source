#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace drown;

// Namespace drown/drown
// Params 0, eflags: 0x2
// Checksum 0x202af1eb, Offset: 0x240
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("drown", &__init__, undefined, undefined);
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xbc229291, Offset: 0x280
// Size: 0x19c
function __init__() {
    clientfield::register("toplayer", "drown_stage", 1, 3, "int", &drown_stage_callback, 0, 0);
    callback::on_localplayer_spawned(&player_spawned);
    level.playermaxhealth = getgametypesetting("playerMaxHealth");
    level.var_f9e80709 = getdvarfloat("player_swimDamagerInterval", 5000) * 1000;
    level.var_fa013947 = getdvarfloat("player_swimDamage", 5000);
    level.var_e7798ae7 = getdvarfloat("player_swimTime", 5000) * 1000;
    level.var_7100629e = level.playermaxhealth / level.var_fa013947 * level.var_f9e80709 + 2000;
    visionset_mgr::register_overlay_info_style_speed_blur("drown_blur", 1, 1, 0.04, 1, 1, 0, 0, 125, 125, 0);
    setup_radius_values();
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0x649b2e71, Offset: 0x428
// Size: 0x420
function setup_radius_values() {
    level.drown_radius["inner"]["begin"][1] = 0.8;
    level.drown_radius["inner"]["begin"][2] = 0.6;
    level.drown_radius["inner"]["begin"][3] = 0.6;
    level.drown_radius["inner"]["begin"][4] = 0.5;
    level.drown_radius["inner"]["end"][1] = 0.5;
    level.drown_radius["inner"]["end"][2] = 0.3;
    level.drown_radius["inner"]["end"][3] = 0.3;
    level.drown_radius["inner"]["end"][4] = 0.2;
    level.drown_radius["outer"]["begin"][1] = 1;
    level.drown_radius["outer"]["begin"][2] = 0.8;
    level.drown_radius["outer"]["begin"][3] = 0.8;
    level.drown_radius["outer"]["begin"][4] = 0.7;
    level.drown_radius["outer"]["end"][1] = 0.8;
    level.drown_radius["outer"]["end"][2] = 0.6;
    level.drown_radius["outer"]["end"][3] = 0.6;
    level.drown_radius["outer"]["end"][4] = 0.5;
    level.opacity["begin"][1] = 0.4;
    level.opacity["begin"][2] = 0.5;
    level.opacity["begin"][3] = 0.6;
    level.opacity["begin"][4] = 0.6;
    level.opacity["end"][1] = 0.5;
    level.opacity["end"][2] = 0.6;
    level.opacity["end"][3] = 0.7;
    level.opacity["end"][4] = 0.7;
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0xa8eb330e, Offset: 0x850
// Size: 0x54
function player_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    self player_init_drown_values();
    self thread player_watch_drown_shutdown(localclientnum);
}

// Namespace drown/drown
// Params 0, eflags: 0x0
// Checksum 0xecd8dc37, Offset: 0x8b0
// Size: 0x44
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
// Checksum 0x9728f7c, Offset: 0x900
// Size: 0x34
function player_watch_drown_shutdown(localclientnum) {
    self waittill("death");
    self disable_drown(localclientnum);
}

// Namespace drown/drown
// Params 2, eflags: 0x0
// Checksum 0x576d88d4, Offset: 0x940
// Size: 0xa0
function enable_drown(localclientnum, stage) {
    filter::init_filter_drowning_damage(localclientnum);
    filter::enable_filter_drowning_damage(localclientnum, 1);
    self.drown_start_time = getservertime(localclientnum) - (stage - 1) * level.var_f9e80709;
    self.drown_outerradius = 0;
    self.drown_innerradius = 0;
    self.drown_opacity = 0;
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0x52e21a64, Offset: 0x9e8
// Size: 0x24
function disable_drown(localclientnum) {
    filter::disable_filter_drowning_damage(localclientnum, 1);
}

// Namespace drown/drown
// Params 2, eflags: 0x0
// Checksum 0x482021cb, Offset: 0xa18
// Size: 0x2ee
function player_drown_fx(localclientnum, stage) {
    self endon(#"death");
    self endon(#"player_fade_out_drown_fx");
    self notify(#"player_drown_fx");
    self endon(#"player_drown_fx");
    self player_init_drown_values();
    lastoutwatertimestage = self.drown_start_time + (stage - 1) * level.var_f9e80709;
    stageduration = level.var_f9e80709;
    if (stage == 1) {
        stageduration = 2000;
    }
    while (true) {
        currenttime = getservertime(localclientnum);
        elapsedtime = currenttime - self.drown_start_time;
        stageratio = math::clamp((currenttime - lastoutwatertimestage) / stageduration, 0, 1);
        self.drown_outerradius = lerpfloat(level.drown_radius["outer"]["begin"][stage], level.drown_radius["outer"]["end"][stage], stageratio) * 1.41421;
        self.drown_innerradius = lerpfloat(level.drown_radius["inner"]["begin"][stage], level.drown_radius["inner"]["end"][stage], stageratio) * 1.41421;
        self.drown_opacity = lerpfloat(level.opacity["begin"][stage], level.opacity["end"][stage], stageratio);
        filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, self.drown_innerradius);
        filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, self.drown_outerradius);
        filter::set_filter_drowning_damage_opacity(localclientnum, 1, self.drown_opacity);
        waitframe(1);
    }
}

// Namespace drown/drown
// Params 1, eflags: 0x0
// Checksum 0x7133ca8e, Offset: 0xd10
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
// Checksum 0x1f3cde20, Offset: 0xf10
// Size: 0xcc
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

