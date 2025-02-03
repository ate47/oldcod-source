#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace water_surface;

// Namespace water_surface/water_surface
// Params 0, eflags: 0x6
// Checksum 0x82217114, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"water_surface", &preinit, undefined, undefined, undefined);
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x4
// Checksum 0xdb374bf0, Offset: 0xf0
// Size: 0x94
function private preinit() {
    level._effect[#"water_player_jump_out"] = #"player/fx_plyr_water_jump_out_splash_1p";
    level._effect[#"hash_1e7095084eda811c"] = #"hash_123c2521c68b2167";
    if (is_true(level.disablewatersurfacefx)) {
        return;
    }
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace water_surface/water_surface
// Params 1, eflags: 0x0
// Checksum 0x82efe39c, Offset: 0x190
// Size: 0x74
function localplayer_spawned(*localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    if (is_true(level.disablewatersurfacefx)) {
        return;
    }
    self thread underwaterwatchbegin();
    self thread underwaterwatchend();
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x9ccb2075, Offset: 0x210
// Size: 0x90
function underwaterwatchbegin() {
    self notify(#"underwaterwatchbegin");
    self endon(#"underwaterwatchbegin");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"underwater_begin");
        if (waitresult.is_teleported) {
            continue;
        }
        self thread underwaterbegin();
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0xd543aade, Offset: 0x2a8
// Size: 0x90
function underwaterwatchend() {
    self notify(#"underwaterwatchend");
    self endon(#"underwaterwatchend");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"underwater_end");
        if (waitresult.is_teleported) {
            continue;
        }
        self thread underwaterend();
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x43a2f0f3, Offset: 0x340
// Size: 0x11c
function underwaterbegin() {
    self notify(#"water_surface_underwater_begin");
    self endon(#"water_surface_underwater_begin");
    self endon(#"death");
    localclientnum = self getlocalclientnumber();
    if (islocalclientdead(localclientnum) == 0 && !is_true(self.topdowncamera)) {
        self.var_733dd716 = playfxoncamera(localclientnum, level._effect[#"hash_1e7095084eda811c"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        if (!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_watertransition") {
            self thread postfx::playpostfxbundle(#"pstfx_watertransition");
        }
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0xff3ffad, Offset: 0x468
// Size: 0xdc
function underwaterend() {
    self notify(#"water_surface_underwater_end");
    self endon(#"water_surface_underwater_end");
    self endon(#"death");
    localclientnum = self getlocalclientnumber();
    if (islocalclientdead(localclientnum) == 0 && !is_true(self.topdowncamera)) {
        if (!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_water_t_out") {
            self thread postfx::playpostfxbundle(#"pstfx_water_t_out");
        }
    }
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x550
// Size: 0x4
function startwaterdive() {
    
}

// Namespace water_surface/water_surface
// Params 0, eflags: 0x0
// Checksum 0x51d30c0f, Offset: 0x560
// Size: 0x38
function startwatersheeting() {
    self notify(#"startwatersheeting_singleton");
    self endon(#"startwatersheeting_singleton");
    self endon(#"death");
}

// Namespace water_surface/water_surface
// Params 1, eflags: 0x0
// Checksum 0x78c7bc1e, Offset: 0x5a0
// Size: 0xb6
function stop_player_fx(localclient) {
    if (isdefined(localclient.firstperson_water_fx)) {
        localclientnum = localclient getlocalclientnumber();
        stopfx(localclientnum, localclient.firstperson_water_fx);
        localclient.firstperson_water_fx = undefined;
    }
    if (isdefined(localclient.var_733dd716)) {
        localclientnum = localclient getlocalclientnumber();
        stopfx(localclientnum, localclient.var_733dd716);
        localclient.var_733dd716 = undefined;
    }
}

