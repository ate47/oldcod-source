#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace burnplayer;

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x6
// Checksum 0x2e9eec, Offset: 0xf8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"burnplayer", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x5 linked
// Checksum 0xfb8cf40d, Offset: 0x140
// Size: 0xe4
function private function_70a657d8() {
    clientfield::register("allplayers", "burn", 1, 1, "int", &burning_callback, 0, 1);
    clientfield::register("playercorpse", "burned_effect", 1, 1, "int", &burning_corpse_callback, 0, 1);
    loadeffects();
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_connect(&on_local_client_connect);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0x88757563, Offset: 0x230
// Size: 0x10
function loadeffects() {
    level.burntags = [];
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x374d9b03, Offset: 0x248
// Size: 0xc
function on_local_client_connect(*localclientnum) {
    
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0xe6c25c2f, Offset: 0x260
// Size: 0x94
function on_localplayer_spawned(*localclientnum) {
    if (self function_21c0fa55() && self clientfield::get("burn") == 0 && self postfx::function_556665f2(#"pstfx_burn_loop")) {
        self postfx::stoppostfxbundle(#"pstfx_burn_loop");
    }
}

// Namespace burnplayer/burnplayer
// Params 7, eflags: 0x1 linked
// Checksum 0x5d1847cd, Offset: 0x300
// Size: 0xa4
function burning_callback(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self function_a6cb96f(fieldname);
        self function_adae7d84(fieldname);
        return;
    }
    self function_8227cec3(fieldname);
    self function_68a11df6(fieldname);
}

// Namespace burnplayer/burnplayer
// Params 7, eflags: 0x1 linked
// Checksum 0x78e6339b, Offset: 0x3b0
// Size: 0x8c
function burning_corpse_callback(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self set_corpse_burning(fieldname);
        return;
    }
    self function_8227cec3(fieldname);
    self function_68a11df6(fieldname);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x5d51cc7d, Offset: 0x448
// Size: 0x2c
function set_corpse_burning(localclientnum) {
    self thread _burnbody(localclientnum, 1);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x48a09635, Offset: 0x480
// Size: 0xa6
function function_8227cec3(*localclientnum) {
    if (self function_21c0fa55()) {
        if (self postfx::function_556665f2(#"pstfx_burn_loop")) {
            self postfx::stoppostfxbundle(#"pstfx_burn_loop");
        }
        if (is_true(self.var_bd048859)) {
            self playsound(0, #"hash_41520794c2fd8aa");
            self.var_bd048859 = 0;
        }
    }
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0xb5c751a5, Offset: 0x530
// Size: 0x1e
function function_68a11df6(*localclientnum) {
    self notify(#"burn_off");
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x11e12f72, Offset: 0x558
// Size: 0x74
function function_a6cb96f(localclientnum) {
    if (self function_21c0fa55() && !isthirdperson(localclientnum) && !self isremotecontrolling(localclientnum)) {
        self thread burn_on_postfx();
    }
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x703b1e48, Offset: 0x5d8
// Size: 0x54
function function_adae7d84(localclientnum) {
    if (!self function_21c0fa55() || isthirdperson(localclientnum)) {
        self thread _burnbody(localclientnum);
    }
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0x616d675c, Offset: 0x638
// Size: 0xa4
function burn_on_postfx() {
    self endon(#"burn_off");
    self endon(#"death");
    self notify(#"burn_on_postfx");
    self endon(#"burn_on_postfx");
    self playsound(0, #"hash_791f349cb716e078");
    self.var_bd048859 = 1;
    self thread postfx::playpostfxbundle(#"pstfx_burn_loop");
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x5 linked
// Checksum 0x12cb830, Offset: 0x6e8
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
// Params 3, eflags: 0x5 linked
// Checksum 0xb435d6fe, Offset: 0x790
// Size: 0x19c
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
// Params 2, eflags: 0x5 linked
// Checksum 0x9a560f36, Offset: 0x938
// Size: 0x5c
function private _burnbody(localclientnum, use_tagfxset = 0) {
    self endon(#"death");
    self thread _burntagson(localclientnum, level.burntags, use_tagfxset);
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x5 linked
// Checksum 0xd503d7cb, Offset: 0x9a0
// Size: 0x100
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
// Params 3, eflags: 0x5 linked
// Checksum 0xc21161a5, Offset: 0xaa8
// Size: 0xe8
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

