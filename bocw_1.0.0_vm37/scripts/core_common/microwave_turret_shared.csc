#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace microwave_turret;

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xdae2300f, Offset: 0x230
// Size: 0xdc
function init_shared() {
    clientfield::register("vehicle", "turret_microwave_open", 1, 1, "int", &microwave_open, 0, 0);
    clientfield::register("scriptmover", "turret_microwave_init", 1, 1, "int", &microwave_init_anim, 0, 0);
    clientfield::register("scriptmover", "turret_microwave_close", 1, 1, "int", &microwave_close_anim, 0, 0);
}

// Namespace microwave_turret/microwave_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x9307b821, Offset: 0x318
// Size: 0x1ec
function turret_microwave_sound_start(localclientnum) {
    self endon(#"death");
    self endon(#"sound_stop");
    if (is_true(self.sound_loop_enabled)) {
        return;
    }
    self playsound(0, #"wpn_micro_turret_start");
    wait 0.7;
    origin = self gettagorigin("tag_flash");
    angles = self gettagangles("tag_flash");
    forward = anglestoforward(angles);
    forward = vectorscale(forward, 750);
    trace = bullettrace(origin, origin + forward, 0, self);
    start = origin;
    end = trace[#"position"];
    self.microwave_audio_start = start;
    self.microwave_audio_end = end;
    self thread turret_microwave_sound_updater();
    if (!is_true(self.sound_loop_enabled)) {
        self.sound_loop_enabled = 1;
        soundlineemitter(#"wpn_micro_turret_loop", self.microwave_audio_start, self.microwave_audio_end);
        self thread turret_microwave_sound_off_waiter(localclientnum);
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x9e7d751e, Offset: 0x510
// Size: 0xbe
function turret_microwave_sound_off_waiter(*localclientnum) {
    msg = self waittill(#"sound_stop", #"death");
    if (msg === "sound_stop") {
        playsound(0, #"wpn_micro_turret_stop", self.microwave_audio_start);
    }
    soundstoplineemitter(#"wpn_micro_turret_loop", self.microwave_audio_start, self.microwave_audio_end);
    if (isdefined(self)) {
        self.sound_loop_enabled = 0;
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x4eb8b2fd, Offset: 0x5d8
// Size: 0x1b8
function turret_microwave_sound_updater() {
    self endon(#"beam_stop");
    self endon(#"death");
    while (true) {
        origin = self gettagorigin("tag_flash");
        if (origin[0] != self.microwave_audio_start[0] || origin[1] != self.microwave_audio_start[1] || origin[2] != self.microwave_audio_start[2]) {
            previousstart = self.microwave_audio_start;
            previousend = self.microwave_audio_end;
            angles = self gettagangles("tag_flash");
            forward = anglestoforward(angles);
            forward = vectorscale(forward, 750);
            trace = bullettrace(origin, origin + forward, 0, self);
            self.microwave_audio_start = origin;
            self.microwave_audio_end = trace[#"position"];
            soundupdatelineemitter(#"wpn_micro_turret_loop", previousstart, previousend, self.microwave_audio_start, self.microwave_audio_end);
        }
        wait 0.1;
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 7, eflags: 0x0
// Checksum 0xbe7d4c91, Offset: 0x798
// Size: 0x46
function microwave_init_anim(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        return;
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 7, eflags: 0x0
// Checksum 0x17059f1e, Offset: 0x7e8
// Size: 0x7c
function microwave_open(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        self notify(#"beam_stop");
        self notify(#"sound_stop");
        return;
    }
    self thread startmicrowavefx(fieldname);
}

// Namespace microwave_turret/microwave_turret_shared
// Params 7, eflags: 0x0
// Checksum 0xabfbf6fc, Offset: 0x870
// Size: 0x46
function microwave_close_anim(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        return;
    }
}

/#

    // Namespace microwave_turret/microwave_turret_shared
    // Params 2, eflags: 0x0
    // Checksum 0xa3e6639d, Offset: 0x8c0
    // Size: 0xe4
    function debug_trace(origin, trace) {
        if (trace[#"fraction"] < 1) {
            color = (0.95, 0.05, 0.05);
        } else {
            color = (0.05, 0.95, 0.05);
        }
        sphere(trace[#"position"], 5, color, 0.75, 1, 10, 100);
        util::debug_line(origin, trace[#"position"], color, 100);
    }

#/

// Namespace microwave_turret/microwave_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x61a3d174, Offset: 0x9b0
// Size: 0x4ac
function startmicrowavefx(localclientnum) {
    turret = self;
    turret endon(#"death");
    turret endon(#"beam_stop");
    turret.should_update_fx = 1;
    self thread turret_microwave_sound_start(localclientnum);
    origin = turret gettagorigin("tag_flash");
    angles = turret gettagangles("tag_flash");
    microwavefxent = spawn(localclientnum, origin, "script_model");
    microwavefxent setmodel(#"tag_microwavefx");
    microwavefxent.angles = angles;
    microwavefxent linkto(turret, "tag_flash");
    microwavefxent.fxhandles = [];
    microwavefxent.fxnames = [];
    microwavefxent.fxhashs = [];
    self thread updatemicrowaveaim(microwavefxent);
    self thread cleanupfx(localclientnum, microwavefxent);
    wait 0.3;
    while (true) {
        /#
            if (getdvarint(#"scr_microwave_turret_fx_debug", 0)) {
                turret.should_update_fx = 1;
                microwavefxent.fxhashs[#"center"] = 0;
            }
        #/
        if (turret.should_update_fx == 0) {
            wait 1;
            continue;
        }
        if (isdefined(level.last_microwave_turret_fx_trace) && level.last_microwave_turret_fx_trace == gettime()) {
            waitframe(1);
            continue;
        }
        angles = turret gettagangles("tag_flash");
        origin = turret gettagorigin("tag_flash");
        forward = anglestoforward(angles);
        forward = vectorscale(forward, 750 + 40);
        var_e2e9fefa = anglestoforward(angles + (0, 55 / 3, 0));
        var_e2e9fefa = vectorscale(var_e2e9fefa, 750 + 40);
        trace = bullettrace(origin, origin + forward, 0, turret);
        traceright = bullettrace(origin, origin - var_e2e9fefa, 0, turret);
        traceleft = bullettrace(origin, origin + var_e2e9fefa, 0, turret);
        /#
            if (getdvarint(#"scr_microwave_turret_fx_debug", 0)) {
                debug_trace(origin, trace);
                debug_trace(origin, traceright);
                debug_trace(origin, traceleft);
            }
        #/
        need_to_rebuild = microwavefxent microwavefxhash(trace, origin, "center");
        need_to_rebuild |= microwavefxent microwavefxhash(traceright, origin, "right");
        need_to_rebuild |= microwavefxent microwavefxhash(traceleft, origin, "left");
        level.last_microwave_turret_fx_trace = gettime();
        if (!need_to_rebuild) {
            wait 1;
            continue;
        }
        wait 0.1;
        microwavefxent playmicrowavefx(localclientnum, trace, traceright, traceleft, origin);
        turret.should_update_fx = 0;
        wait 1;
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x9b30dbd0, Offset: 0xe68
// Size: 0xcc
function updatemicrowaveaim(*microwavefxent) {
    turret = self;
    turret endon(#"death");
    turret endon(#"beam_stop");
    last_angles = turret gettagangles("tag_flash");
    while (true) {
        angles = turret gettagangles("tag_flash");
        if (last_angles != angles) {
            turret.should_update_fx = 1;
            last_angles = angles;
        }
        wait 0.1;
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 3, eflags: 0x0
// Checksum 0x5a675bd1, Offset: 0xf40
// Size: 0x17a
function microwavefxhash(trace, origin, name) {
    hash = 0;
    counter = 2;
    for (i = 0; i < 5; i++) {
        endofhalffxsq = sqr(i * 150 + 125);
        endoffullfxsq = sqr(i * 150 + 200);
        tracedistsq = distancesquared(origin, trace[#"position"]);
        if (tracedistsq >= endofhalffxsq || i == 0) {
            if (tracedistsq < endoffullfxsq) {
                hash += 1;
            } else {
                hash += counter;
            }
        }
        counter *= 2;
    }
    if (!isdefined(self.fxhashs[name])) {
        self.fxhashs[name] = 0;
    }
    last_hash = self.fxhashs[name];
    self.fxhashs[name] = hash;
    return last_hash != hash;
}

// Namespace microwave_turret/microwave_turret_shared
// Params 2, eflags: 0x0
// Checksum 0xb80632fb, Offset: 0x10c8
// Size: 0xdc
function cleanupfx(localclientnum, microwavefxent) {
    self waittill(#"death", #"beam_stop");
    foreach (handle in microwavefxent.fxhandles) {
        if (isdefined(handle)) {
            stopfx(localclientnum, handle);
        }
    }
    microwavefxent delete();
}

// Namespace microwave_turret/microwave_turret_shared
// Params 3, eflags: 0x0
// Checksum 0x8bf3e2c5, Offset: 0x11b0
// Size: 0x90
function play_fx_on_tag(localclientnum, fxname, tag) {
    if (!isdefined(self.fxhandles[tag]) || fxname != self.fxnames[tag]) {
        stop_fx_on_tag(localclientnum, fxname, tag);
        self.fxnames[tag] = fxname;
        self.fxhandles[tag] = util::playfxontag(localclientnum, fxname, self, tag);
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 3, eflags: 0x0
// Checksum 0xfede73f5, Offset: 0x1248
// Size: 0x74
function stop_fx_on_tag(localclientnum, *fxname, tag) {
    if (isdefined(self.fxhandles[tag])) {
        stopfx(fxname, self.fxhandles[tag]);
        self.fxhandles[tag] = undefined;
        self.fxnames[tag] = undefined;
    }
}

/#

    // Namespace microwave_turret/microwave_turret_shared
    // Params 3, eflags: 0x0
    // Checksum 0x7b6d8cb9, Offset: 0x12c8
    // Size: 0x94
    function render_debug_sphere(tag, color, *fxname) {
        if (getdvarint(#"scr_microwave_turret_fx_debug", 0)) {
            origin = self gettagorigin(color);
            sphere(origin, 2, fxname, 0.75, 1, 10, 100);
        }
    }

#/

// Namespace microwave_turret/microwave_turret_shared
// Params 4, eflags: 0x0
// Checksum 0x3d5f19a4, Offset: 0x1368
// Size: 0xdc
function stop_or_start_fx(localclientnum, fxname, tag, start) {
    if (start) {
        self play_fx_on_tag(localclientnum, fxname, tag);
        /#
            if (fxname == "<dev string:x38>") {
                render_debug_sphere(tag, (0.5, 0.5, 0), fxname);
            } else {
                render_debug_sphere(tag, (0, 1, 0), fxname);
            }
        #/
        return;
    }
    stop_fx_on_tag(localclientnum, fxname, tag);
    /#
        render_debug_sphere(tag, (1, 0, 0), fxname);
    #/
}

// Namespace microwave_turret/microwave_turret_shared
// Params 5, eflags: 0x0
// Checksum 0xe5469cfd, Offset: 0x1450
// Size: 0x542
function playmicrowavefx(localclientnum, trace, traceright, traceleft, origin) {
    for (i = 0; i < 5; i++) {
        endofhalffxsq = sqr(i * 150 + 125);
        endoffullfxsq = sqr(i * 150 + 200);
        tracedistsq = distancesquared(origin, trace[#"position"]);
        startfx = tracedistsq >= endofhalffxsq || i == 0;
        fxname = tracedistsq > endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash" : "killstreaks/fx_sg_distortion_cone_ash_sm";
        switch (i) {
        case 0:
            self play_fx_on_tag(localclientnum, fxname, "tag_fx11");
            break;
        case 1:
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx32", startfx);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx42", startfx);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx43", startfx);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx53", startfx);
            break;
        }
        tracedistsq = distancesquared(origin, traceleft[#"position"]);
        startfx = tracedistsq >= endofhalffxsq;
        fxname = tracedistsq > endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash" : "killstreaks/fx_sg_distortion_cone_ash_sm";
        switch (i) {
        case 0:
            break;
        case 1:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx22", startfx);
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx33", startfx);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx44", startfx);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx54", startfx);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx55", startfx);
            break;
        }
        tracedistsq = distancesquared(origin, traceright[#"position"]);
        startfx = tracedistsq >= endofhalffxsq;
        fxname = tracedistsq > endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash" : "killstreaks/fx_sg_distortion_cone_ash_sm";
        switch (i) {
        case 0:
            break;
        case 1:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx21", startfx);
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx31", startfx);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx41", startfx);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx51", startfx);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx52", startfx);
            break;
        }
    }
}

