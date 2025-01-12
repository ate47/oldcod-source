#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace burnplayer;

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x2
// Checksum 0x9cd31eea, Offset: 0xf8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"burnplayer", &__init__, undefined, undefined);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0xa874416a, Offset: 0x140
// Size: 0xe4
function __init__() {
    clientfield::register("allplayers", "burn", 1, 1, "int", &burning_callback, 0, 0);
    clientfield::register("playercorpse", "burned_effect", 1, 1, "int", &burning_corpse_callback, 0, 1);
    loadeffects();
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_connect(&on_local_client_connect);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0x229dd4c1, Offset: 0x230
// Size: 0x12
function loadeffects() {
    level.burntags = [];
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0xbcd6d01b, Offset: 0x250
// Size: 0xc
function on_local_client_connect(localclientnum) {
    
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x7e2855c0, Offset: 0x268
// Size: 0xc
function on_localplayer_spawned(localclientnum) {
    
}

// Namespace burnplayer/burnplayer
// Params 7, eflags: 0x0
// Checksum 0xac775f6e, Offset: 0x280
// Size: 0xa4
function burning_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_d3f51bde(localclientnum);
        self function_d6c64f88(localclientnum);
        return;
    }
    self function_ff2d377c(localclientnum);
    self function_3e871fb2(localclientnum);
}

// Namespace burnplayer/burnplayer
// Params 7, eflags: 0x0
// Checksum 0x11f8633e, Offset: 0x330
// Size: 0x8c
function burning_corpse_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self set_corpse_burning(localclientnum);
        return;
    }
    self function_ff2d377c(localclientnum);
    self function_3e871fb2(localclientnum);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x6fb52dac, Offset: 0x3c8
// Size: 0x2c
function set_corpse_burning(localclientnum) {
    self thread _burnbody(localclientnum, 1);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x3b0f338, Offset: 0x400
// Size: 0x44
function function_ff2d377c(localclientnum) {
    if (self function_60dbc438()) {
        self postfx::stoppostfxbundle("pstfx_burn_loop");
    }
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x15e9e935, Offset: 0x450
// Size: 0x1e
function function_3e871fb2(localclientnum) {
    self notify(#"burn_off");
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x110f24ce, Offset: 0x478
// Size: 0x74
function function_d3f51bde(localclientnum) {
    if (self function_60dbc438() && !isthirdperson(localclientnum) && !self isremotecontrolling(localclientnum)) {
        self thread burn_on_postfx();
    }
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x3bcf6da8, Offset: 0x4f8
// Size: 0x54
function function_d6c64f88(localclientnum) {
    if (!self function_60dbc438() || isthirdperson(localclientnum)) {
        self thread _burnbody(localclientnum);
    }
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0x208a3043, Offset: 0x558
// Size: 0x94
function burn_on_postfx() {
    self endon(#"burn_off");
    self endon(#"death");
    self notify(#"burn_on_postfx");
    self endon(#"burn_on_postfx");
    self playsound(0, #"hash_791f349cb716e078");
    self thread postfx::playpostfxbundle(#"pstfx_burn_loop");
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x4
// Checksum 0x379c630, Offset: 0x5f8
// Size: 0x9c
function private _burntag(localclientnum, tag, postfix) {
    if (isdefined(self) && self hasdobj(localclientnum)) {
        fxname = "burn_" + tag + postfix;
        if (isdefined(level._effect[fxname])) {
            return util::playfxontag(localclientnum, level._effect[fxname], self, tag);
        }
    }
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x4
// Checksum 0xccd0ba7d, Offset: 0x6a0
// Size: 0x1b4
function private _burntagson(localclientnum, tags, use_tagfxset) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self endon(#"burn_off");
    self notify(#"burn_tags_on");
    self endon(#"burn_tags_on");
    if (use_tagfxset) {
        self util::waittill_dobj(localclientnum);
        activefx = playtagfxset(localclientnum, "weapon_hero_molotov_fire_3p", self);
    } else {
        activefx = [];
        for (i = 0; i < tags.size; i++) {
            activefx[activefx.size] = self _burntag(localclientnum, tags[i], "_loop");
        }
    }
    playsound(0, #"chr_ignite", self.origin);
    burnsound = self playloopsound(#"chr_burn_loop_overlay", 0.5);
    self thread _burntagswatchend(localclientnum, activefx, burnsound);
    self thread _burntagswatchclear(localclientnum, activefx, burnsound);
}

// Namespace burnplayer/burnplayer
// Params 2, eflags: 0x4
// Checksum 0x598a3afe, Offset: 0x860
// Size: 0x5c
function private _burnbody(localclientnum, use_tagfxset = 0) {
    self endon(#"death");
    self thread _burntagson(localclientnum, level.burntags, use_tagfxset);
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x4
// Checksum 0x24db5e1a, Offset: 0x8c8
// Size: 0xf0
function private _burntagswatchend(localclientnum, fxarray, burnsound) {
    self waittill(#"burn_off", #"death");
    if (isdefined(self) && isdefined(burnsound)) {
        self stoploopsound(burnsound, 1);
    }
    if (isdefined(fxarray)) {
        foreach (fx in fxarray) {
            stopfx(localclientnum, fx);
        }
    }
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x4
// Checksum 0x499ed04f, Offset: 0x9c0
// Size: 0xd8
function private _burntagswatchclear(localclientnum, fxarray, burnsound) {
    self endon(#"burn_off");
    self waittill(#"death");
    if (isdefined(burnsound)) {
        stopsound(burnsound);
    }
    if (isdefined(fxarray)) {
        foreach (fx in fxarray) {
            stopfx(localclientnum, fx);
        }
    }
}
