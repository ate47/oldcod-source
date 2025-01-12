#using scripts\core_common\callbacks_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace water_surface;

// Namespace water_surface/water_surface
// Params 0, eflags: 0x2
// Checksum 0x93b488e1, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"water_surface", &__init__, undefined, undefined);
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0xab1d6a4e, Offset: 0xf8
// Size: 0xdc
function __init__() {
    level._effect[#"hash_215b5515b4582919"] = #"hash_42f96312d63ba7a2";
    level._effect[#"water_player_jump_out"] = #"player/fx_plyr_water_jump_out_splash_1p";
    level._effect[#"hash_1e7095084eda811c"] = #"hash_123c2521c68b2167";
    if (isdefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1) {
        return;
    }
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace water_surface/water_surface
// Params 1, eflags: 0x0
// Checksum 0xe54d63b1, Offset: 0x1e0
// Size: 0xdc
function localplayer_spawned(localclientnum) {
    if (!self function_60dbc438()) {
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
// Checksum 0xc9da33d8, Offset: 0x2c8
// Size: 0xe8
function underwaterwatchbegin() {
    self notify(#"underwaterwatchbegin");
    self endon(#"underwaterwatchbegin");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"underwater_begin");
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
// Checksum 0x50c84755, Offset: 0x3b8
// Size: 0xe8
function underwaterwatchend() {
    self notify(#"underwaterwatchend");
    self endon(#"underwaterwatchend");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"underwater_end");
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
// Checksum 0xcc9d8d20, Offset: 0x4a8
// Size: 0x16c
function underwaterbegin() {
    self notify(#"water_surface_underwater_begin");
    self endon(#"water_surface_underwater_begin");
    self endon(#"death");
    localclientnum = self getlocalclientnumber();
    filter::disable_filter_water_sheeting(self, 1);
    stop_player_fx(self);
    if (islocalclientdead(localclientnum) == 0) {
        self.firstperson_water_fx = playfxoncamera(localclientnum, level._effect[#"hash_215b5515b4582919"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        self.var_838b5cc4 = playfxoncamera(localclientnum, level._effect[#"hash_1e7095084eda811c"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        if (!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_watertransition") {
            self thread postfx::playpostfxbundle(#"pstfx_watertransition");
        }
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x312d4f8d, Offset: 0x620
// Size: 0xbc
function underwaterend() {
    self notify(#"water_surface_underwater_end");
    self endon(#"water_surface_underwater_end");
    self endon(#"death");
    localclientnum = self getlocalclientnumber();
    if (islocalclientdead(localclientnum) == 0) {
        if (!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_water_t_out") {
            self thread postfx::playpostfxbundle(#"pstfx_water_t_out");
        }
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0xe4bb66bd, Offset: 0x6e8
// Size: 0x230
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
// Checksum 0x677abc14, Offset: 0x920
// Size: 0x20c
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
// Checksum 0x916e876e, Offset: 0xb38
// Size: 0xb6
function stop_player_fx(localclient) {
    if (isdefined(localclient.firstperson_water_fx)) {
        localclientnum = localclient getlocalclientnumber();
        stopfx(localclientnum, localclient.firstperson_water_fx);
        localclient.firstperson_water_fx = undefined;
    }
    if (isdefined(localclient.var_838b5cc4)) {
        localclientnum = localclient getlocalclientnumber();
        stopfx(localclientnum, localclient.var_838b5cc4);
        localclient.var_838b5cc4 = undefined;
    }
}

