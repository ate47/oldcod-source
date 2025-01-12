#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/util_shared;

#namespace ability_util;

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x4fbe46ac, Offset: 0x178
// Size: 0xc8
function init_aoe_fx_info(aoe_name) {
    if (!isdefined(level.aoe_fx_info) || !isarray(level.aoe_fx_info)) {
        level.aoe_fx_info = [];
    }
    if (!isdefined(level.aoe_fx_info[aoe_name]) || !isstruct(level.aoe_fx_info[aoe_name])) {
        level.aoe_fx_info[aoe_name] = spawnstruct();
    }
    return level.aoe_fx_info[aoe_name];
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0xc06a04a9, Offset: 0x248
// Size: 0x1c
function get_aoe_fx_info(aoe_name) {
    return level.aoe_fx_info[aoe_name];
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x2cd7a67b, Offset: 0x270
// Size: 0xc8
function init_applied_aoe_fx_info(aoe_name) {
    if (!isdefined(level.applied_aoe_fx_info) || !isarray(level.applied_aoe_fx_info)) {
        level.applied_aoe_fx_info = [];
    }
    if (!isdefined(level.applied_aoe_fx_info[aoe_name]) || !isstruct(level.applied_aoe_fx_info[aoe_name])) {
        level.applied_aoe_fx_info[aoe_name] = spawnstruct();
    }
    return level.applied_aoe_fx_info[aoe_name];
}

// Namespace ability_util/ability_util
// Params 7, eflags: 0x0
// Checksum 0x43f28cf0, Offset: 0x340
// Size: 0x18c
function update_applied_aoe_fx(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    fx_info = level.applied_aoe_fx_info[fieldname];
    if (!isdefined(fx_info)) {
        return;
    }
    if (newval != oldval) {
        local_player = getlocalplayer(local_client_num);
        if (self == local_player) {
            self duplicate_render::update_dr_flag(local_client_num, fx_info.dr_set, newval);
            if (newval) {
                playfx(local_client_num, fx_info.fx_1p, self.origin);
            }
        } else if (newval) {
            playfx(local_client_num, fx_info.fx_3p, self.origin);
        }
    }
    if (newval) {
        self endon(#"death");
        self util::waittill_dobj(local_client_num);
        playtagfxset(local_client_num, fx_info.tagfxset, self);
    }
}

// Namespace ability_util/ability_util
// Params 7, eflags: 0x0
// Checksum 0xffc18b82, Offset: 0x4d8
// Size: 0xac
function set_aoe_fx(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    aoe_fx_info = level.aoe_fx_info[fieldname];
    if (!isdefined(aoe_fx_info)) {
        return;
    }
    self stop_aoe_fx(local_client_num, fieldname, aoe_fx_info);
    if (newval) {
        self thread aoe_fx(local_client_num, fieldname, aoe_fx_info);
    }
}

// Namespace ability_util/ability_util
// Params 3, eflags: 0x0
// Checksum 0x1f13c049, Offset: 0x590
// Size: 0xf8
function stop_aoe_fx(local_client_num, clientfield_name, aoe_fx_info) {
    if (!isdefined(self.aoe_fx_arrays)) {
        return;
    }
    if (!isdefined(self.aoe_fx_arrays[clientfield_name])) {
        return;
    }
    foreach (fx in self.aoe_fx_arrays[clientfield_name]) {
        if (!isdefined(fx)) {
            continue;
        }
        stopfx(local_client_num, fx);
    }
    self.aoe_fx_arrays[clientfield_name] = undefined;
}

// Namespace ability_util/ability_util
// Params 3, eflags: 0x4
// Checksum 0xef39d772, Offset: 0x690
// Size: 0x3a6
function private aoe_fx(local_client_num, clientfield_name, aoe_fx_info) {
    self endon(#"death");
    center = self.origin + (0, 0, aoe_fx_info.center_offset_z);
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
    trace = bullettrace(center, center + (0, 0, -1) * aoe_fx_info.explosion_radius, 0, self);
    if (trace["fraction"] < 1) {
        pitch_vals[1] = 90 - atan(150 / trace["fraction"] * aoe_fx_info.explosion_radius);
        pitch_vals[2] = 90 - atan(300 / trace["fraction"] * aoe_fx_info.explosion_radius);
    } else {
        pitch_vals[1] = 60;
        pitch_vals[2] = 30;
    }
    trace = bullettrace(center, center + (0, 0, 1) * aoe_fx_info.explosion_radius, 0, self);
    if (trace["fraction"] < 1) {
        pitch_vals[5] = -90 + atan(150 / trace["fraction"] * aoe_fx_info.explosion_radius);
        pitch_vals[4] = -90 + atan(300 / trace["fraction"] * aoe_fx_info.explosion_radius);
    } else {
        pitch_vals[5] = -60;
        pitch_vals[4] = -30;
    }
    currentpitch = startpitch;
    for (yaw_level = 0; yaw_level < yaw_count.size; yaw_level++) {
        currentpitch = pitch_vals[yaw_level];
        do_aoe_fx(local_client_num, center, yaw_count[yaw_level], currentpitch, clientfield_name, aoe_fx_info);
    }
}

// Namespace ability_util/ability_util
// Params 6, eflags: 0x4
// Checksum 0x46f73850, Offset: 0xa40
// Size: 0x76c
function private do_aoe_fx(local_client_num, center, yaw_count, pitch, clientfield_name, aoe_fx_info) {
    profile_script = getdvarint("scr_profile_aoe_client", 0);
    if (profile_script) {
        profile_start_time = util::get_start_time();
        profile_elapsed_times = [];
    }
    if (!isdefined(self.aoe_fx_arrays)) {
        self.aoe_fx_arrays = [];
    }
    if (!isdefined(self.aoe_fx_arrays[clientfield_name])) {
        self.aoe_fx_arrays[clientfield_name] = [];
    }
    /#
        debug_aoe_traces = getdvarint("<dev string:x28>", 0);
    #/
    currentyaw = randomint(360);
    for (fxcount = 0; fxcount < yaw_count; fxcount++) {
        randomoffsetpitch = randomint(5) - 2.5;
        randomoffsetyaw = randomint(30) - 15;
        angles = (pitch + randomoffsetpitch, currentyaw + randomoffsetyaw, 0);
        tracedir = anglestoforward(angles);
        currentyaw += 360 / yaw_count;
        fx_position = center + tracedir * aoe_fx_info.explosion_radius;
        trace = bullettrace(center, fx_position, 0, self);
        sphere_size = 5;
        angles = (0, randomint(360), 0);
        forward = anglestoforward(angles);
        if (trace["fraction"] < 1) {
            fx_position = center + tracedir * aoe_fx_info.explosion_radius * trace["fraction"];
            /#
                if (debug_aoe_traces) {
                    sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
                    sphere(trace["<dev string:x39>"], sphere_size, (1, 1, 0), 1, 1, 8, 300);
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
            fx = playfx(local_client_num, aoe_fx_info.distortion_volume_fx, trace["position"], normal, forward);
            if (!isdefined(self.aoe_fx_arrays[clientfield_name])) {
                self.aoe_fx_arrays[clientfield_name] = [];
            } else if (!isarray(self.aoe_fx_arrays[clientfield_name])) {
                self.aoe_fx_arrays[clientfield_name] = array(self.aoe_fx_arrays[clientfield_name]);
            }
            self.aoe_fx_arrays[clientfield_name][self.aoe_fx_arrays[clientfield_name].size] = fx;
        } else {
            /#
                if (debug_aoe_traces) {
                    line(fx_position + (0, 0, 50), fx_position - (0, 0, 50), (1, 0, 0), 1, 0, 300);
                    sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
                }
            #/
            if (lengthsquared(vectorcross(forward, tracedir * -1)) == 0) {
                forward = vectorcross(right, forward);
            }
            fx = playfx(local_client_num, aoe_fx_info.distortion_volume_air_fx, fx_position, tracedir * -1, forward);
            if (!isdefined(self.aoe_fx_arrays[clientfield_name])) {
                self.aoe_fx_arrays[clientfield_name] = [];
            } else if (!isarray(self.aoe_fx_arrays[clientfield_name])) {
                self.aoe_fx_arrays[clientfield_name] = array(self.aoe_fx_arrays[clientfield_name]);
            }
            self.aoe_fx_arrays[clientfield_name][self.aoe_fx_arrays[clientfield_name].size] = fx;
        }
        if (profile_script) {
            util::record_elapsed_time(profile_start_time, profile_elapsed_times);
        }
        if (fxcount % aoe_fx_info.fx_per_frame) {
            waitframe(1);
        }
        if (profile_script) {
            profile_start_time = util::get_start_time();
        }
    }
    if (profile_script) {
        util::note_elapsed_times(profile_elapsed_times, "util aoe client");
    }
}

