#using scripts/core_common/callbacks_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace water_surface;

// Namespace water_surface/water_surface
// Params 0, eflags: 0x2
// Checksum 0xc2b2b0c9, Offset: 0x210
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("water_surface", &__init__, undefined, undefined);
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0xe651602f, Offset: 0x250
// Size: 0x8c
function __init__() {
    level._effect["water_player_jump_in"] = "player/fx_plyr_water_jump_in_bubbles_1p";
    level._effect["water_player_jump_out"] = "player/fx_plyr_water_jump_out_splash_1p";
    if (isdefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1) {
        return;
    }
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace water_surface/water_surface
// Params 1, eflags: 0x0
// Checksum 0x1333b440, Offset: 0x2e8
// Size: 0xdc
function localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    if (isdefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1) {
        return;
    }
    filter::init_filter_water_sheeting(self);
    filter::init_filter_water_dive(self);
    self thread underwaterwatchbegin();
    self thread underwaterwatchend();
    filter::disable_filter_water_sheeting(self, 1);
    stop_player_fx(self);
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0xce07df8e, Offset: 0x3d0
// Size: 0xd8
function underwaterwatchbegin() {
    self notify(#"underwaterwatchbegin");
    self endon(#"underwaterwatchbegin");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("underwater_begin");
        if (waitresult.is_teleported) {
            filter::disable_filter_water_sheeting(self, 1);
            stop_player_fx(self);
            filter::disable_filter_water_dive(self, 1);
            stop_player_fx(self);
            continue;
        }
        self thread underwaterbegin();
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x6f91b61f, Offset: 0x4b0
// Size: 0xd8
function underwaterwatchend() {
    self notify(#"underwaterwatchend");
    self endon(#"underwaterwatchend");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("underwater_end");
        if (waitresult.is_teleported) {
            filter::disable_filter_water_sheeting(self, 1);
            stop_player_fx(self);
            filter::disable_filter_water_dive(self, 1);
            stop_player_fx(self);
            continue;
        }
        self thread underwaterend();
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x97e8486c, Offset: 0x590
// Size: 0x12c
function underwaterbegin() {
    self notify(#"water_surface_underwater_begin");
    self endon(#"water_surface_underwater_begin");
    self endon(#"death");
    localclientnum = self getlocalclientnumber();
    filter::disable_filter_water_sheeting(self, 1);
    stop_player_fx(self);
    if (islocalclientdead(localclientnum) == 0) {
        self.firstperson_water_fx = playfxoncamera(localclientnum, level._effect["water_player_jump_in"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        if (!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_watertransition") {
            self thread postfx::playpostfxbundle("pstfx_watertransition");
        }
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x5c8fd944, Offset: 0x6c8
// Size: 0xac
function underwaterend() {
    self notify(#"water_surface_underwater_end");
    self endon(#"water_surface_underwater_end");
    self endon(#"death");
    localclientnum = self getlocalclientnumber();
    if (islocalclientdead(localclientnum) == 0) {
        if (!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_water_t_out") {
            self thread postfx::playpostfxbundle("pstfx_water_t_out");
        }
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x9e058683, Offset: 0x780
// Size: 0x24a
function startwaterdive() {
    filter::enable_filter_water_dive(self, 1);
    filter::set_filter_water_scuba_dive_speed(self, 1, 0.25);
    filter::set_filter_water_wash_color(self, 1, 0.16, 0.5, 0.9);
    filter::set_filter_water_wash_reveal_dir(self, 1, -1);
    for (i = 0; i < 0.05; i += 0.01) {
        filter::set_filter_water_dive_bubbles(self, 1, i / 0.05);
        wait 0.01;
    }
    filter::set_filter_water_dive_bubbles(self, 1, 1);
    filter::set_filter_water_scuba_bubble_attitude(self, 1, -1);
    filter::set_filter_water_scuba_bubbles(self, 1, 1);
    filter::set_filter_water_wash_reveal_dir(self, 1, 1);
    for (i = 0.2; i > 0; i -= 0.01) {
        filter::set_filter_water_dive_bubbles(self, 1, i / 0.2);
        wait 0.01;
    }
    filter::set_filter_water_dive_bubbles(self, 1, 0);
    wait 0.1;
    for (i = 0.2; i > 0; i -= 0.01) {
        filter::set_filter_water_scuba_bubbles(self, 1, i / 0.2);
        wait 0.01;
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0xa393d8be, Offset: 0x9d8
// Size: 0x214
function startwatersheeting() {
    self notify(#"startwatersheeting_singleton");
    self endon(#"startwatersheeting_singleton");
    self endon(#"death");
    filter::enable_filter_water_sheeting(self, 1);
    filter::set_filter_water_sheet_reveal(self, 1, 1);
    filter::set_filter_water_sheet_speed(self, 1, 1);
    for (i = 2; i > 0; i -= 0.01) {
        filter::set_filter_water_sheet_reveal(self, 1, i / 2);
        filter::set_filter_water_sheet_speed(self, 1, i / 2);
        rivulet1 = i / 2 - 0.19;
        rivulet2 = i / 2 - 0.13;
        rivulet3 = i / 2 - 0.07;
        filter::set_filter_water_sheet_rivulet_reveal(self, 1, rivulet1, rivulet2, rivulet3);
        wait 0.01;
    }
    filter::set_filter_water_sheet_reveal(self, 1, 0);
    filter::set_filter_water_sheet_speed(self, 1, 0);
    filter::set_filter_water_sheet_rivulet_reveal(self, 1, 0, 0, 0);
}

// Namespace water_surface/water_surface
// Params 1, eflags: 0x0
// Checksum 0x672ce742, Offset: 0xbf8
// Size: 0x72
function stop_player_fx(localclient) {
    if (isdefined(localclient.firstperson_water_fx)) {
        localclientnum = localclient getlocalclientnumber();
        stopfx(localclientnum, localclient.firstperson_water_fx);
        localclient.firstperson_water_fx = undefined;
    }
}

