#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace qrdrone;

// Namespace qrdrone/qrdrone
// Params 0, eflags: 0x0
// Checksum 0x3a0f8c2, Offset: 0x198
// Size: 0x174
function init_shared() {
    if (!isdefined(level.var_2444b2ee)) {
        level.var_2444b2ee = {};
        type = "qrdrone_mp";
        clientfield::register("vehicle", "qrdrone_state", 1, 3, "int", &statechange, 0, 0);
        clientfield::register("vehicle", "qrdrone_countdown", 1, 1, "int", &start_blink, 0, 0);
        clientfield::register("vehicle", "qrdrone_timeout", 1, 1, "int", &final_blink, 0, 0);
        clientfield::register("vehicle", "qrdrone_out_of_range", 1, 1, "int", &out_of_range_update, 0, 0);
        vehicle::add_vehicletype_callback("qrdrone_mp", &spawned);
    }
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xc3623ab1, Offset: 0x318
// Size: 0x84
function spawned(localclientnum) {
    self util::waittill_dobj(localclientnum);
    self thread restartfx(localclientnum, 0);
    self thread collisionhandler(localclientnum);
    self thread enginestutterhandler(localclientnum);
    self thread qrdrone_watch_distance();
}

// Namespace qrdrone/qrdrone
// Params 7, eflags: 0x0
// Checksum 0x9c2a66f5, Offset: 0x3a8
// Size: 0x7c
function statechange(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(fieldname);
    self restartfx(fieldname, bwastimejump);
}

// Namespace qrdrone/qrdrone
// Params 2, eflags: 0x0
// Checksum 0x378ec989, Offset: 0x430
// Size: 0x14c
function restartfx(localclientnum, blinkstage) {
    self notify(#"restart_fx");
    println("<dev string:x38>" + blinkstage);
    switch (blinkstage) {
    case 0:
        self spawn_solid_fx(localclientnum);
        break;
    case 1:
        self.fx_interval = 1;
        self spawn_blinking_fx(localclientnum);
        break;
    case 2:
        self.fx_interval = 0.133;
        self spawn_blinking_fx(localclientnum);
        break;
    case 3:
        self notify(#"stopfx");
        self notify(#"fx_death");
        return;
    }
    self thread watchrestartfx(localclientnum);
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0x39c2f275, Offset: 0x588
// Size: 0x94
function watchrestartfx(localclientnum) {
    self endon(#"death");
    level waittill(#"demo_jump", #"player_switch", #"killcam_begin", #"killcam_end");
    self restartfx(localclientnum, clientfield::get("qrdrone_state"));
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xd7df7610, Offset: 0x628
// Size: 0x2a
function spawn_solid_fx(*localclientnum) {
    if (self function_4add50a7()) {
    }
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0x4d0f0367, Offset: 0x660
// Size: 0x2c
function spawn_blinking_fx(localclientnum) {
    self thread blink_fx_and_sound(localclientnum, "wpn_qr_alert");
}

// Namespace qrdrone/qrdrone
// Params 2, eflags: 0x0
// Checksum 0xa81303ac, Offset: 0x698
// Size: 0x13e
function blink_fx_and_sound(localclientnum, soundalias) {
    self endon(#"death");
    self endon(#"restart_fx");
    self endon(#"fx_death");
    if (!isdefined(self.interval)) {
        self.interval = 1;
    }
    while (true) {
        self playsound(localclientnum, soundalias);
        self spawn_solid_fx(localclientnum);
        util::server_wait(localclientnum, self.interval / 2);
        self notify(#"stopfx");
        util::server_wait(localclientnum, self.interval / 2);
        self.interval /= 1.17;
        if (self.interval < 0.1) {
            self.interval = 0.1;
        }
    }
}

// Namespace qrdrone/qrdrone
// Params 2, eflags: 0x0
// Checksum 0x4d54e41c, Offset: 0x7e0
// Size: 0x74
function cleanupfx(localclientnum, handle) {
    self waittill(#"death", #"blink", #"stopfx", #"restart_fx");
    stopfx(localclientnum, handle);
}

// Namespace qrdrone/qrdrone
// Params 7, eflags: 0x0
// Checksum 0xf6050bb5, Offset: 0x860
// Size: 0x56
function start_blink(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        return;
    }
    self notify(#"blink");
}

// Namespace qrdrone/qrdrone
// Params 7, eflags: 0x0
// Checksum 0x8e703aa3, Offset: 0x8c0
// Size: 0x56
function final_blink(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        return;
    }
    self.interval = 0.133;
}

// Namespace qrdrone/qrdrone
// Params 7, eflags: 0x0
// Checksum 0x44736528, Offset: 0x920
// Size: 0x9c
function out_of_range_update(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    model = getuimodel(function_1df4c3b0(fieldname, #"vehicle_info"), "outOfRange");
    if (isdefined(model)) {
        setuimodelvalue(model, bwastimejump);
    }
}

// Namespace qrdrone/qrdrone
// Params 4, eflags: 0x0
// Checksum 0xc46682b5, Offset: 0x9c8
// Size: 0x16e
function loop_local_sound(localclientnum, alias, interval, *fx) {
    self endon(#"death");
    self endon(#"stopfx");
    level endon(#"demo_jump");
    level endon(#"player_switch");
    if (!isdefined(self.interval)) {
        self.interval = fx;
    }
    while (true) {
        self playsound(alias, interval);
        self spawn_solid_fx(alias);
        util::server_wait(alias, self.interval / 2);
        self notify(#"stopfx");
        util::server_wait(alias, self.interval / 2);
        self.interval /= 1.17;
        if (self.interval < 0.1) {
            self.interval = 0.1;
        }
    }
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0x1c79dbbd, Offset: 0xb40
// Size: 0x104
function check_for_player_switch_or_time_jump(localclientnum) {
    self endon(#"death");
    level waittill(#"demo_jump", #"player_switch", #"killcam_begin");
    self notify(#"stopfx");
    waittillframeend();
    self thread blink_light(localclientnum);
    if (isdefined(self.blinkstarttime) && self.blinkstarttime <= getservertime(0)) {
        self.interval = 1;
        self thread start_blink(localclientnum, 1);
    } else {
        self spawn_solid_fx(localclientnum);
    }
    self thread check_for_player_switch_or_time_jump(localclientnum);
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xb0409eb2, Offset: 0xc50
// Size: 0x17c
function blink_light(localclientnum) {
    self endon(#"death");
    level endon(#"demo_jump");
    level endon(#"player_switch");
    level endon(#"killcam_begin");
    self waittill(#"blink");
    if (!isdefined(self.blinkstarttime)) {
        self.blinkstarttime = getservertime(0);
    }
    if (self function_4add50a7()) {
        self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[#"qrdrone_viewmodel_light"]);
        return;
    }
    if (self function_ca024039()) {
        self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[#"qrdrone_friendly_light"]);
        return;
    }
    self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[#"qrdrone_enemy_light"]);
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xf4b10619, Offset: 0xdd8
// Size: 0x120
function collisionhandler(*localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"veh_collision");
        hip = waitresult.velocity;
        hitn = waitresult.normal;
        hit_intensity = waitresult.intensity;
        driver_local_client = self getlocalclientdriver();
        if (isdefined(driver_local_client)) {
            player = function_5c10bd79(driver_local_client);
            if (isdefined(player)) {
                if (hit_intensity > 15) {
                    player playrumbleonentity(driver_local_client, "damage_heavy");
                    continue;
                }
                player playrumbleonentity(driver_local_client, "damage_light");
            }
        }
    }
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xdcb88dde, Offset: 0xf00
// Size: 0x70
function enginestutterhandler(localclientnum) {
    self endon(#"death");
    while (true) {
        self waittill(#"veh_engine_stutter");
        if (self function_4add50a7()) {
            function_36e4ebd4(localclientnum, "rcbomb_engine_stutter");
        }
    }
}

// Namespace qrdrone/qrdrone
// Params 0, eflags: 0x0
// Checksum 0x330e4c0c, Offset: 0xf78
// Size: 0x138
function getminimumflyheight() {
    if (!isdefined(level.airsupportheightscale)) {
        level.airsupportheightscale = 1;
    }
    airsupport_height = struct::get("air_support_height", "targetname");
    if (isdefined(airsupport_height)) {
        planeflyheight = airsupport_height.origin[2];
    } else {
        println("<dev string:x56>");
        planeflyheight = 850;
        if (isdefined(level.airsupportheightscale)) {
            level.airsupportheightscale = getdvarint(#"scr_airsupportheightscale", level.airsupportheightscale);
            planeflyheight *= getdvarint(#"scr_airsupportheightscale", level.airsupportheightscale);
        }
        if (isdefined(level.forceairsupportmapheight)) {
            planeflyheight += level.forceairsupportmapheight;
        }
    }
    return planeflyheight;
}

// Namespace qrdrone/qrdrone
// Params 0, eflags: 0x0
// Checksum 0x6b9cdd01, Offset: 0x10b8
// Size: 0x2b8
function qrdrone_watch_distance() {
    self endon(#"death");
    qrdrone_height = struct::get("qrdrone_height", "targetname");
    if (isdefined(qrdrone_height)) {
        self.maxheight = qrdrone_height.origin[2];
    } else {
        self.maxheight = int(getminimumflyheight());
    }
    self.maxdistance = 12800;
    level.mapcenter = getmapcenter();
    self.minheight = level.mapcenter[2] - 800;
    inrangepos = self.origin;
    soundent = spawn(0, self.origin, "script_origin");
    soundent linkto(self);
    self thread qrdrone_staticstopondeath(soundent);
    while (true) {
        if (!self qrdrone_in_range()) {
            staticalpha = 0;
            while (!self qrdrone_in_range()) {
                if (isdefined(self.heliinproximity)) {
                    dist = distance(self.origin, self.heliinproximity.origin);
                    staticalpha = 1 - (dist - 150) / 150;
                } else {
                    dist = distance(self.origin, inrangepos);
                    staticalpha = min(1, dist / 200);
                }
                sid = soundent playloopsound(#"veh_qrdrone_static_lp", 0.2);
                self vehicle::set_static_amount(staticalpha * 2);
                waitframe(1);
            }
            self thread qrdrone_staticfade(staticalpha, soundent, sid);
        }
        inrangepos = self.origin;
        waitframe(1);
    }
}

// Namespace qrdrone/qrdrone
// Params 0, eflags: 0x0
// Checksum 0x1b10df9e, Offset: 0x1378
// Size: 0x56
function qrdrone_in_range() {
    if (self.origin[2] < self.maxheight && self.origin[2] > self.minheight) {
        if (self function_4826630a()) {
            return true;
        }
    }
    return false;
}

// Namespace qrdrone/qrdrone
// Params 3, eflags: 0x0
// Checksum 0xb7410cd9, Offset: 0x13d8
// Size: 0xfe
function qrdrone_staticfade(staticalpha, sndent, sid) {
    self endon(#"death");
    while (self qrdrone_in_range()) {
        staticalpha -= 0.05;
        if (staticalpha <= 0) {
            sndent stopallloopsounds(0.5);
            self vehicle::set_static_amount(0);
            break;
        }
        setsoundvolumerate(sid, 0.6);
        setsoundvolume(sid, staticalpha);
        self vehicle::set_static_amount(staticalpha * 2);
        waitframe(1);
    }
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0x466effee, Offset: 0x14e0
// Size: 0x54
function qrdrone_staticstopondeath(sndent) {
    self waittill(#"death");
    sndent stopallloopsounds(0.1);
    sndent delete();
}

