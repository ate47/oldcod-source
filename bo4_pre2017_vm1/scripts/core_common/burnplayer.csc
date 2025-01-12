#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace burnplayer;

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x2
// Checksum 0x6a97b9ac, Offset: 0x600
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("burnplayer", &__init__, undefined, undefined);
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0x64b6b9ad, Offset: 0x640
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
// Checksum 0xc5a06d79, Offset: 0x730
// Size: 0x2f8
function loadeffects() {
    level._effect["burn_j_elbow_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect["burn_j_elbow_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect["burn_j_shoulder_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect["burn_j_shoulder_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect["burn_j_spine4_loop"] = "fire/fx_fire_ai_human_torso_loop";
    level._effect["burn_j_hip_le_loop"] = "fire/fx_fire_ai_human_hip_left_loop";
    level._effect["burn_j_hip_ri_loop"] = "fire/fx_fire_ai_human_hip_right_loop";
    level._effect["burn_j_knee_le_loop"] = "fire/fx_fire_ai_human_leg_left_loop";
    level._effect["burn_j_knee_ri_loop"] = "fire/fx_fire_ai_human_leg_right_loop";
    level._effect["burn_j_head_loop"] = "fire/fx_fire_ai_human_head_loop";
    level._effect["burn_j_elbow_le_os"] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect["burn_j_elbow_ri_os"] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect["burn_j_shoulder_le_os"] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect["burn_j_shoulder_ri_os"] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect["burn_j_spine4_os"] = "fire/fx_fire_ai_human_torso_os";
    level._effect["burn_j_hip_le_os"] = "fire/fx_fire_ai_human_hip_left_os";
    level._effect["burn_j_hip_ri_os"] = "fire/fx_fire_ai_human_hip_right_os";
    level._effect["burn_j_knee_le_os"] = "fire/fx_fire_ai_human_leg_left_os";
    level._effect["burn_j_knee_ri_os"] = "fire/fx_fire_ai_human_leg_right_os";
    level._effect["burn_j_head_os"] = "fire/fx_fire_ai_human_head_os";
    level.burntags = array("j_elbow_le", "j_elbow_ri", "j_shoulder_le", "j_shoulder_ri", "j_spine4", "j_spinelower", "j_hip_le", "j_hip_ri", "j_head", "j_knee_le", "j_knee_ri");
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x9639c64e, Offset: 0xa30
// Size: 0x1ec
function on_local_client_connect(localclientnum) {
    registerrewindfx(localclientnum, level._effect["burn_j_elbow_le_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_elbow_ri_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_shoulder_le_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_shoulder_ri_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_spine4_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_hip_le_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_hip_ri_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_knee_le_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_knee_ri_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_head_loop"]);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0xa9753593, Offset: 0xc28
// Size: 0xc
function on_localplayer_spawned(localclientnum) {
    
}

// Namespace burnplayer/burnplayer
// Params 7, eflags: 0x0
// Checksum 0xe9470819, Offset: 0xc40
// Size: 0x7c
function burning_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_4c9baeb2(localclientnum);
        return;
    }
    self burn_off(localclientnum);
}

// Namespace burnplayer/burnplayer
// Params 7, eflags: 0x0
// Checksum 0x79dbb411, Offset: 0xcc8
// Size: 0x7c
function burning_corpse_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self set_corpse_burning(localclientnum);
        return;
    }
    self burn_off(localclientnum);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0xdb1baf42, Offset: 0xd50
// Size: 0x24
function set_corpse_burning(localclientnum) {
    self thread _burnbody(localclientnum);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0x455ae4d6, Offset: 0xd80
// Size: 0x4c
function burn_off(localclientnum) {
    self notify(#"burn_off");
    if (getlocalplayer(localclientnum) == self) {
        self postfx::exitpostfxbundle();
    }
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x0
// Checksum 0xc967a01b, Offset: 0xdd8
// Size: 0xac
function function_4c9baeb2(localclientnum) {
    if (getlocalplayer(localclientnum) != self || isthirdperson(localclientnum)) {
        self thread _burnbody(localclientnum);
    }
    if (getlocalplayer(localclientnum) == self && !isthirdperson(localclientnum)) {
        self thread burn_on_postfx();
    }
}

// Namespace burnplayer/burnplayer
// Params 0, eflags: 0x0
// Checksum 0x2da30cf7, Offset: 0xe90
// Size: 0x54
function burn_on_postfx() {
    self endon(#"burn_off");
    self endon(#"death");
    self notify(#"burn_on_postfx");
    self endon(#"burn_on_postfx");
    self thread postfx::playpostfxbundle("pstfx_burn_loop");
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x4
// Checksum 0xbb169028, Offset: 0xef0
// Size: 0xa4
function private _burntag(localclientnum, tag, postfix) {
    if (isdefined(self) && self hasdobj(localclientnum)) {
        fxname = "burn_" + tag + postfix;
        if (isdefined(level._effect[fxname])) {
            return playfxontag(localclientnum, level._effect[fxname], self, tag);
        }
    }
}

// Namespace burnplayer/burnplayer
// Params 2, eflags: 0x4
// Checksum 0x3b46ee29, Offset: 0xfa0
// Size: 0x134
function private _burntagson(localclientnum, tags) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self endon(#"burn_off");
    self notify(#"burn_tags_on");
    self endon(#"burn_tags_on");
    activefx = [];
    for (i = 0; i < tags.size; i++) {
        activefx[activefx.size] = self _burntag(localclientnum, tags[i], "_loop");
    }
    burnsound = self playloopsound("chr_burn_loop_overlay", 0.5);
    self thread _burntagswatchend(localclientnum, activefx, burnsound);
    self thread _burntagswatchclear(localclientnum, activefx, burnsound);
}

// Namespace burnplayer/burnplayer
// Params 1, eflags: 0x4
// Checksum 0x2d2a31a, Offset: 0x10e0
// Size: 0x3c
function private _burnbody(localclientnum) {
    self endon(#"death");
    self thread _burntagson(localclientnum, level.burntags);
}

// Namespace burnplayer/burnplayer
// Params 3, eflags: 0x4
// Checksum 0x94d510fa, Offset: 0x1128
// Size: 0xf2
function private _burntagswatchend(localclientnum, fxarray, burnsound) {
    self endon(#"death");
    self waittill("burn_off");
    if (isdefined(burnsound)) {
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
// Checksum 0x322e317a, Offset: 0x1228
// Size: 0xea
function private _burntagswatchclear(localclientnum, fxarray, burnsound) {
    self endon(#"burn_off");
    self waittill("death");
    if (isdefined(burnsound)) {
        stopsound(burnsound);
    }
    if (isdefined(fxarray)) {
        foreach (fx in fxarray) {
            stopfx(localclientnum, fx);
        }
    }
}

