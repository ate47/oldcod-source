#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace qrdrone;

// Namespace qrdrone/qrdrone
// Params 0, eflags: 0x0
// Checksum 0x298a9db2, Offset: 0x180
// Size: 0x204
function init_shared() {
    if (!isdefined(level.var_83c7f3c2)) {
        level.var_83c7f3c2 = {};
        type = "qrdrone_mp";
        clientfield::register("vehicle", "qrdrone_state", 1, 3, "int", &statechange, 0, 0);
        level._effect[#"qrdrone_enemy_light"] = #"hash_6b275eecd5caf9d7";
        level._effect[#"qrdrone_friendly_light"] = #"hash_4c41f659efb80ad3";
        level._effect[#"qrdrone_viewmodel_light"] = #"hash_4c3b0a59efb20e21";
        clientfield::register("vehicle", "qrdrone_countdown", 1, 1, "int", &start_blink, 0, 0);
        clientfield::register("vehicle", "qrdrone_timeout", 1, 1, "int", &final_blink, 0, 0);
        clientfield::register("vehicle", "qrdrone_out_of_range", 1, 1, "int", &out_of_range_update, 0, 0);
        vehicle::add_vehicletype_callback("qrdrone_mp", &spawned);
    }
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0x35a23f70, Offset: 0x390
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
// Checksum 0xae9f2722, Offset: 0x420
// Size: 0x7c
function statechange(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self restartfx(localclientnum, newval);
}

// Namespace qrdrone/qrdrone
// Params 2, eflags: 0x0
// Checksum 0xaa89f1bd, Offset: 0x4a8
// Size: 0x14c
function restartfx(localclientnum, blinkstage) {
    self notify(#"restart_fx");
    println("<dev string:x30>" + blinkstage);
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
// Checksum 0xb33d706f, Offset: 0x600
// Size: 0x94
function watchrestartfx(localclientnum) {
    self endon(#"death");
    level waittill(#"demo_jump", #"player_switch", #"killcam_begin", #"killcam_end");
    self restartfx(localclientnum, clientfield::get("qrdrone_state"));
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xceed86c9, Offset: 0x6a0
// Size: 0xdc
function spawn_solid_fx(localclientnum) {
    if (self function_2a8c9709()) {
        fx_handle = util::playfxontag(localclientnum, level._effect[#"qrdrone_viewmodel_light"], self, "tag_body");
    } else {
        fx_handle = self fx::function_b63f5a0e(localclientnum, level._effect[#"qrdrone_friendly_light"], level._effect[#"qrdrone_enemy_light"], "tag_body");
    }
    self thread cleanupfx(localclientnum, fx_handle);
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xb46424b0, Offset: 0x788
// Size: 0x2c
function spawn_blinking_fx(localclientnum) {
    self thread blink_fx_and_sound(localclientnum, "wpn_qr_alert");
}

// Namespace qrdrone/qrdrone
// Params 2, eflags: 0x0
// Checksum 0x8a18a4cb, Offset: 0x7c0
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
// Checksum 0xe23ee1c3, Offset: 0x908
// Size: 0x74
function cleanupfx(localclientnum, handle) {
    self waittill(#"death", #"blink", #"stopfx", #"restart_fx");
    stopfx(localclientnum, handle);
}

// Namespace qrdrone/qrdrone
// Params 7, eflags: 0x0
// Checksum 0x7b746d99, Offset: 0x988
// Size: 0x56
function start_blink(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self notify(#"blink");
}

// Namespace qrdrone/qrdrone
// Params 7, eflags: 0x0
// Checksum 0xf425a5ec, Offset: 0x9e8
// Size: 0x56
function final_blink(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self.interval = 0.133;
}

// Namespace qrdrone/qrdrone
// Params 7, eflags: 0x0
// Checksum 0xfe97fe7a, Offset: 0xa48
// Size: 0x94
function out_of_range_update(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.outOfRange");
    if (isdefined(model)) {
        setuimodelvalue(model, newval);
    }
}

// Namespace qrdrone/qrdrone
// Params 4, eflags: 0x0
// Checksum 0x9414826c, Offset: 0xae8
// Size: 0x16e
function loop_local_sound(localclientnum, alias, interval, fx) {
    self endon(#"death");
    self endon(#"stopfx");
    level endon(#"demo_jump");
    level endon(#"player_switch");
    if (!isdefined(self.interval)) {
        self.interval = interval;
    }
    while (true) {
        self playsound(localclientnum, alias);
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
// Params 1, eflags: 0x0
// Checksum 0x3f8d7d36, Offset: 0xc60
// Size: 0xf4
function check_for_player_switch_or_time_jump(localclientnum) {
    self endon(#"death");
    level waittill(#"demo_jump", #"player_switch", #"killcam_begin");
    self notify(#"stopfx");
    waittillframeend();
    self thread blink_light(localclientnum);
    if (isdefined(self.blinkstarttime) && self.blinkstarttime <= level.servertime) {
        self.interval = 1;
        self thread start_blink(localclientnum, 1);
    } else {
        self spawn_solid_fx(localclientnum);
    }
    self thread check_for_player_switch_or_time_jump(localclientnum);
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xe75f090d, Offset: 0xd60
// Size: 0x174
function blink_light(localclientnum) {
    self endon(#"death");
    level endon(#"demo_jump");
    level endon(#"player_switch");
    level endon(#"killcam_begin");
    self waittill(#"blink");
    if (!isdefined(self.blinkstarttime)) {
        self.blinkstarttime = level.servertime;
    }
    if (self function_2a8c9709()) {
        self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[#"qrdrone_viewmodel_light"]);
        return;
    }
    if (self function_31d3dfec()) {
        self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[#"qrdrone_friendly_light"]);
        return;
    }
    self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect[#"qrdrone_enemy_light"]);
}

// Namespace qrdrone/qrdrone
// Params 1, eflags: 0x0
// Checksum 0xedebdc84, Offset: 0xee0
// Size: 0x130
function collisionhandler(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"veh_collision");
        hip = waitresult.velocity;
        hitn = waitresult.normal;
        hit_intensity = waitresult.intensity;
        driver_local_client = self getlocalclientdriver();
        if (isdefined(driver_local_client)) {
            player = function_f97e7787(driver_local_client);
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
// Checksum 0x1abbb3d4, Offset: 0x1018
// Size: 0x70
function enginestutterhandler(localclientnum) {
    self endon(#"death");
    while (true) {
        self waittill(#"veh_engine_stutter");
        if (self function_2a8c9709()) {
            function_d2913e3e(localclientnum, "rcbomb_engine_stutter");
        }
    }
}

// Namespace qrdrone/qrdrone
// Params 0, eflags: 0x0
// Checksum 0x8ab1b88b, Offset: 0x1090
// Size: 0x138
function getminimumflyheight() {
    if (!isdefined(level.airsupportheightscale)) {
        level.airsupportheightscale = 1;
    }
    airsupport_height = struct::get("air_support_height", "targetname");
    if (isdefined(airsupport_height)) {
        planeflyheight = airsupport_height.origin[2];
    } else {
        println("<dev string:x4b>");
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
// Checksum 0xc4ffc4b9, Offset: 0x11d0
// Size: 0x2c0
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
// Checksum 0x47dc7e9a, Offset: 0x1498
// Size: 0x56
function qrdrone_in_range() {
    if (self.origin[2] < self.maxheight && self.origin[2] > self.minheight) {
        if (self isinsideheightlock()) {
            return true;
        }
    }
    return false;
}

// Namespace qrdrone/qrdrone
// Params 3, eflags: 0x0
// Checksum 0x82f3c233, Offset: 0x14f8
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
// Checksum 0xc2b4aa42, Offset: 0x1600
// Size: 0x54
function qrdrone_staticstopondeath(sndent) {
    self waittill(#"death");
    sndent stopallloopsounds(0.1);
    sndent delete();
}

