#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/burnplayer;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_heat_wave;

// Namespace gadget_heat_wave/gadget_heat_wave
// Params 0, eflags: 0x2
// Checksum 0x64afdb26, Offset: 0x3d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_heat_wave", &__init__, undefined, undefined);
}

// Namespace gadget_heat_wave/gadget_heat_wave
// Params 0, eflags: 0x0
// Checksum 0x631faf16, Offset: 0x410
// Size: 0x16c
function __init__() {
    clientfield::register("scriptmover", "heatwave_fx", 1, 1, "int", &function_35b42cb4, 0, 0);
    clientfield::register("allplayers", "heatwave_victim", 1, 1, "int", &function_318dd491, 0, 0);
    clientfield::register("toplayer", "heatwave_activate", 1, 1, "int", &function_4bf284ca, 0, 0);
    level.var_ca9e7366 = getdvarint("scr_debug_heat_wave_traces", 0);
    visionset_mgr::register_visionset_info("heatwave", 1, 16, undefined, "heatwave");
    visionset_mgr::register_visionset_info("charred", 1, 16, undefined, "charred");
    /#
        level thread updatedvars();
    #/
}

/#

    // Namespace gadget_heat_wave/gadget_heat_wave
    // Params 0, eflags: 0x0
    // Checksum 0x89b58f40, Offset: 0x588
    // Size: 0x4c
    function updatedvars() {
        while (true) {
            level.var_ca9e7366 = getdvarint("<dev string:x28>", level.var_ca9e7366);
            wait 1;
        }
    }

#/

// Namespace gadget_heat_wave/gadget_heat_wave
// Params 7, eflags: 0x0
// Checksum 0xf3efb982, Offset: 0x5e0
// Size: 0x64
function function_4bf284ca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_heat_pulse");
    }
}

// Namespace gadget_heat_wave/gadget_heat_wave
// Params 7, eflags: 0x0
// Checksum 0x1166902d, Offset: 0x650
// Size: 0xac
function function_318dd491(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self endon(#"death");
        self util::waittill_dobj(localclientnum);
        self playrumbleonentity(localclientnum, "heat_wave_damage");
        playtagfxset(localclientnum, "ability_hero_heat_wave_player_impact", self);
    }
}

// Namespace gadget_heat_wave/gadget_heat_wave
// Params 7, eflags: 0x0
// Checksum 0x6d328c4a, Offset: 0x708
// Size: 0x84
function function_35b42cb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_45bc6290(localclientnum);
    if (newval) {
        self.var_c9a5771e = [];
        self thread aoe_fx(localclientnum);
    }
}

// Namespace gadget_heat_wave/gadget_heat_wave
// Params 1, eflags: 0x0
// Checksum 0x8334f915, Offset: 0x798
// Size: 0xaa
function function_45bc6290(localclientnum) {
    if (!isdefined(self.var_c9a5771e)) {
        return;
    }
    foreach (fx in self.var_c9a5771e) {
        stopfx(localclientnum, fx);
    }
}

// Namespace gadget_heat_wave/gadget_heat_wave
// Params 1, eflags: 0x0
// Checksum 0x930f1246, Offset: 0x850
// Size: 0x356
function aoe_fx(localclientnum) {
    self endon(#"death");
    center = self.origin + (0, 0, 30);
    startpitch = -90;
    yaw_count = [];
    yaw_count[0] = 1;
    yaw_count[1] = 4;
    yaw_count[2] = 6;
    yaw_count[3] = 8;
    yaw_count[4] = 6;
    yaw_count[5] = 4;
    yaw_count[6] = 1;
    pitch_vals = [];
    pitch_vals[0] = 90;
    pitch_vals[3] = 0;
    pitch_vals[6] = -90;
    trace = bullettrace(center, center + (0, 0, -1) * 400, 0, self);
    if (trace["fraction"] < 1) {
        pitch_vals[1] = 90 - atan(150 / trace["fraction"] * 400);
        pitch_vals[2] = 90 - atan(300 / trace["fraction"] * 400);
    } else {
        pitch_vals[1] = 60;
        pitch_vals[2] = 30;
    }
    trace = bullettrace(center, center + (0, 0, 1) * 400, 0, self);
    if (trace["fraction"] < 1) {
        pitch_vals[5] = -90 + atan(150 / trace["fraction"] * 400);
        pitch_vals[4] = -90 + atan(300 / trace["fraction"] * 400);
    } else {
        pitch_vals[5] = -60;
        pitch_vals[4] = -30;
    }
    currentpitch = startpitch;
    for (yaw_level = 0; yaw_level < yaw_count.size; yaw_level++) {
        currentpitch = pitch_vals[yaw_level];
        function_89e1d77b(localclientnum, center, yaw_count[yaw_level], currentpitch);
    }
}

// Namespace gadget_heat_wave/gadget_heat_wave
// Params 4, eflags: 0x0
// Checksum 0x5c2770e3, Offset: 0xbb0
// Size: 0x4d8
function function_89e1d77b(localclientnum, center, yaw_count, pitch) {
    currentyaw = randomint(360);
    for (fxcount = 0; fxcount < yaw_count; fxcount++) {
        randomoffsetpitch = randomint(5) - 2.5;
        randomoffsetyaw = randomint(30) - 15;
        angles = (pitch + randomoffsetpitch, currentyaw + randomoffsetyaw, 0);
        tracedir = anglestoforward(angles);
        currentyaw += 360 / yaw_count;
        fx_position = center + tracedir * 400;
        trace = bullettrace(center, fx_position, 0, self);
        sphere_size = 5;
        angles = (0, randomint(360), 0);
        forward = anglestoforward(angles);
        if (trace["fraction"] < 1) {
            fx_position = center + tracedir * 400 * trace["fraction"];
            /#
                if (level.var_ca9e7366) {
                    sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
                    sphere(trace["<dev string:x43>"], sphere_size, (1, 1, 0), 1, 1, 8, 300);
                }
            #/
            normal = trace["normal"];
            if (lengthsquared(normal) == 0) {
                normal = -1 * tracedir;
            }
            right = (normal[2] * -1, normal[1] * -1, normal[0]);
            if (lengthsquared(vectorcross(forward, normal)) == 0) {
                forward = vectorcross(right, forward);
            }
            self.var_c9a5771e[self.var_c9a5771e.size] = playfx(localclientnum, "player/fx_plyr_heat_wave_distortion_volume", trace["position"], normal, forward);
        } else {
            /#
                if (level.var_ca9e7366) {
                    line(fx_position + (0, 0, 50), fx_position - (0, 0, 50), (1, 0, 0), 1, 0, 300);
                    sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
                }
            #/
            if (lengthsquared(vectorcross(forward, tracedir * -1)) == 0) {
                forward = vectorcross(right, forward);
            }
            self.var_c9a5771e[self.var_c9a5771e.size] = playfx(localclientnum, "player/fx_plyr_heat_wave_distortion_volume_air", fx_position, tracedir * -1, forward);
        }
        if (fxcount % 2) {
            waitframe(1);
        }
    }
}

