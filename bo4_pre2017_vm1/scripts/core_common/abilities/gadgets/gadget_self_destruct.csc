#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace gadget_self_destruct;

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x2
// Checksum 0x2d4b4973, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_self_destruct", &__init__, undefined, undefined);
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 0, eflags: 0x0
// Checksum 0x27519477, Offset: 0x240
// Size: 0x4c
function __init__() {
    clientfield::register("scriptmover", "death_fx", 1, 1, "int", &set_death_fx, 0, 0);
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 7, eflags: 0x0
// Checksum 0xb956ade8, Offset: 0x298
// Size: 0x84
function set_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self clear_death_fx(localclientnum);
    if (newval) {
        self.deathfx = [];
        self thread aoe_fx(localclientnum);
    }
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 1, eflags: 0x0
// Checksum 0x7fe8c19c, Offset: 0x328
// Size: 0xaa
function clear_death_fx(localclientnum) {
    if (!isdefined(self.deathfx)) {
        return;
    }
    foreach (fx in self.deathfx) {
        stopfx(localclientnum, fx);
    }
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 1, eflags: 0x0
// Checksum 0x25259563, Offset: 0x3e0
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
        do_fx(localclientnum, center, yaw_count[yaw_level], currentpitch);
    }
}

// Namespace gadget_self_destruct/gadget_self_destruct
// Params 4, eflags: 0x0
// Checksum 0x529fc484, Offset: 0x740
// Size: 0x4d8
function do_fx(localclientnum, center, yaw_count, pitch) {
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
                if (level.debug_heat_wave_traces) {
                    sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
                    sphere(trace["<dev string:x28>"], sphere_size, (1, 1, 0), 1, 1, 8, 300);
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
            self.deathfx[self.deathfx.size] = playfx(localclientnum, "explosions/fx_exp_grenade_default", trace["position"], normal, forward);
        } else {
            /#
                if (level.debug_heat_wave_traces) {
                    line(fx_position + (0, 0, 50), fx_position - (0, 0, 50), (1, 0, 0), 1, 0, 300);
                    sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
                }
            #/
            if (lengthsquared(vectorcross(forward, tracedir * -1)) == 0) {
                forward = vectorcross(right, forward);
            }
            self.deathfx[self.deathfx.size] = playfx(localclientnum, "explosions/fx_exp_grenade_default", fx_position, tracedir * -1, forward);
        }
        if (fxcount % 2) {
            waitframe(1);
        }
    }
}

