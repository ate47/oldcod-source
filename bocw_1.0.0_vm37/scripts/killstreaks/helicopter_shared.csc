#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\helicopter_sounds_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\flak_drone;
#using scripts\killstreaks\killstreak_bundles;

#namespace helicopter;

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0x7a21de84, Offset: 0x1f0
// Size: 0x2b4
function init_shared() {
    if (!isdefined(level.var_164c3b65)) {
        level.var_164c3b65 = {};
        flak_drone::init_shared();
        params = getscriptbundle("killstreak_helicopter_guard");
        level._effect[#"heli_guard_light"][#"friendly"] = params.var_667eb0de;
        level._effect[#"heli_guard_light"][#"enemy"] = params.var_1d8c24a8;
        clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int", &warnmissilelocking, 0, 0);
        clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int", &warnmissilelocked, 0, 0);
        clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int", &warnmissilefired, 0, 0);
        clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int", &heli_comlink_bootup_anim, 0, 0);
        clientfield::register("vehicle", "active_camo", 1, 3, "int", &active_camo_changed, 0, 0);
        callback::on_spawned(&on_player_spawned);
        callback::on_vehicle_spawned(&on_vehicle_spawned);
        bundle = getscriptbundle("killstreak_helicopter_comlink");
        if (isdefined(bundle)) {
            vehicle::add_vehicletype_callback(bundle.ksvehicle, &killstreak_bundles::spawned, bundle);
        }
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x79370de0, Offset: 0x4b0
// Size: 0x9e
function on_player_spawned(localclientnum) {
    player = self;
    player waittill(#"death");
    player.markerfx = undefined;
    if (isdefined(player.markerobj)) {
        player.markerobj delete();
    }
    if (isdefined(player.markerfxhandle)) {
        killfx(localclientnum, player.markerfxhandle);
        player.markerfxhandle = undefined;
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x3ac473c0, Offset: 0x558
// Size: 0x34
function on_vehicle_spawned(localclientnum) {
    if (self.type == "helicopter") {
        self thread startfx_loop(localclientnum);
    }
}

// Namespace helicopter/helicopter_shared
// Params 0, eflags: 0x0
// Checksum 0xa5a380c, Offset: 0x598
// Size: 0x4c
function setupanimtree() {
    if (isdefined(self) && self hasanimtree() == 0) {
        self useanimtree("generic");
    }
}

// Namespace helicopter/helicopter_shared
// Params 7, eflags: 0x0
// Checksum 0x149231ab, Offset: 0x5f0
// Size: 0xb4
function active_camo_changed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 0) {
        self thread heli_comlink_lights_on_after_wait(fieldname, 0.7);
    } else {
        self heli_comlink_lights_off(fieldname);
    }
    self notify(#"endtest");
    self thread doreveal(fieldname, bwastimejump != 0);
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0x988dc18f, Offset: 0x6b0
// Size: 0x184
function doreveal(local_client_num, direction) {
    self notify(#"endtest");
    self endon(#"endtest");
    self endon(#"death");
    if (direction) {
        startval = 0;
        endval = 1;
    } else {
        startval = 1;
        endval = 0;
    }
    priorvalue = startval;
    while (startval >= 0 && startval <= 1) {
        self mapshaderconstant(local_client_num, 0, "scriptVector0", startval, 0, 0, 0);
        if (direction) {
            startval += 0.032;
            if (priorvalue < 0.5 && startval >= 0.5) {
            }
        } else {
            startval -= 0.032;
            if (priorvalue > 0.5 && startval <= 0.5) {
            }
        }
        priorvalue = startval;
        waitframe(1);
    }
    self mapshaderconstant(local_client_num, 0, "scriptVector0", endval, 0, 0, 0);
}

// Namespace helicopter/helicopter_shared
// Params 7, eflags: 0x0
// Checksum 0xf1a4a334, Offset: 0x840
// Size: 0x50
function heli_comlink_bootup_anim(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
}

// Namespace helicopter/helicopter_shared
// Params 7, eflags: 0x0
// Checksum 0x205a6430, Offset: 0x898
// Size: 0x7c
function warnmissilelocking(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !self function_4add50a7()) {
        return;
    }
    helicopter_sounds::play_targeted_sound(bwastimejump);
}

// Namespace helicopter/helicopter_shared
// Params 7, eflags: 0x0
// Checksum 0x95c1a9a5, Offset: 0x920
// Size: 0x7c
function warnmissilelocked(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !self function_4add50a7()) {
        return;
    }
    helicopter_sounds::play_locked_sound(bwastimejump);
}

// Namespace helicopter/helicopter_shared
// Params 7, eflags: 0x0
// Checksum 0x21cb0c11, Offset: 0x9a8
// Size: 0x7c
function warnmissilefired(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !self function_4add50a7()) {
        return;
    }
    helicopter_sounds::play_fired_sound(bwastimejump);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x260b27b7, Offset: 0xa30
// Size: 0x156
function heli_deletefx(localclientnum) {
    if (isdefined(self.exhaustleftfxhandle)) {
        deletefx(localclientnum, self.exhaustleftfxhandle);
        self.exhaustleftfxhandle = undefined;
    }
    if (isdefined(self.exhaustrightfxhandlee)) {
        deletefx(localclientnum, self.exhaustrightfxhandle);
        self.exhaustrightfxhandle = undefined;
    }
    if (isdefined(self.lightfxid)) {
        deletefx(localclientnum, self.lightfxid);
        self.lightfxid = undefined;
    }
    if (isdefined(self.propfxid)) {
        deletefx(localclientnum, self.propfxid);
        self.propfxid = undefined;
    }
    if (isdefined(self.vtolleftfxid)) {
        deletefx(localclientnum, self.vtolleftfxid);
        self.vtolleftfxid = undefined;
    }
    if (isdefined(self.vtolrightfxid)) {
        deletefx(localclientnum, self.vtolrightfxid);
        self.vtolrightfxid = undefined;
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xbac2e439, Offset: 0xb90
// Size: 0x22a
function startfx(localclientnum) {
    self endon(#"death");
    if (isdefined(self.vehicletype)) {
        if (self.vehicletype == #"remote_mortar_vehicle_mp") {
            return;
        }
        if (self.vehicletype == #"vehicle_straferun_mp") {
            return;
        }
    }
    if (isdefined(self.exhaustfxname) && self.exhaustfxname != "") {
        self.exhaustfx = self.exhaustfxname;
    }
    if (isdefined(self.exhaustfx)) {
        self.exhaustleftfxhandle = util::playfxontag(localclientnum, self.exhaustfx, self, "tag_engine_left");
        if (!is_true(self.oneexhaust)) {
            self.exhaustrightfxhandle = util::playfxontag(localclientnum, self.exhaustfx, self, "tag_engine_right");
        }
    } else {
        println("<dev string:x38>");
    }
    if (isdefined(self.vehicletype)) {
        light_fx = undefined;
        switch (self.vehicletype) {
        case #"heli_ai_mp":
            light_fx = "heli_comlink_light";
            break;
        case #"heli_guard_mp":
            light_fx = "heli_guard_light";
            break;
        }
        if (isdefined(light_fx)) {
            self.lightfxid = self fx::function_3539a829(localclientnum, level._effect[light_fx][#"friendly"], level._effect[light_fx][#"enemy"], "tag_origin");
        }
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x219034a2, Offset: 0xdc8
// Size: 0xe2
function startfx_loop(localclientnum) {
    self endon(#"death");
    self thread helicopter_sounds::aircraft_dustkick(localclientnum);
    startfx(localclientnum);
    servertime = getservertime(0);
    lastservertime = servertime;
    while (isdefined(self)) {
        if (servertime < lastservertime) {
            heli_deletefx(localclientnum);
            startfx(localclientnum);
        }
        waitframe(1);
        lastservertime = servertime;
        servertime = getservertime(0);
    }
}

// Namespace helicopter/helicopter_shared
// Params 2, eflags: 0x0
// Checksum 0xf10cd00a, Offset: 0xeb8
// Size: 0x54
function heli_comlink_lights_on_after_wait(localclientnum, wait_time) {
    self endon(#"death");
    self endon(#"heli_comlink_lights_off");
    wait wait_time;
    self heli_comlink_lights_on(localclientnum);
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0x6dfec7c, Offset: 0xf18
// Size: 0x194
function heli_comlink_lights_on(localclientnum) {
    if (!isdefined(self.light_fx_handles_heli_comlink)) {
        self.light_fx_handles_heli_comlink = [];
    }
    params = getscriptbundle("killstreak_helicopter_comlink");
    self.light_fx_handles_heli_comlink[0] = util::playfxontag(localclientnum, params.var_ffb74bd2, self, params.var_cc7457a3);
    self.light_fx_handles_heli_comlink[1] = util::playfxontag(localclientnum, params.var_ffb74bd2, self, params.var_a4b60827);
    self.light_fx_handles_heli_comlink[2] = util::playfxontag(localclientnum, params.var_ffb74bd2, self, params.var_caf75475);
    self.light_fx_handles_heli_comlink[3] = util::playfxontag(localclientnum, params.var_ffb74bd2, self, params.var_a6b70bf5);
    if (isdefined(self.team)) {
        for (i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
            setfxteam(localclientnum, self.light_fx_handles_heli_comlink[i], self.owner.team);
        }
    }
}

// Namespace helicopter/helicopter_shared
// Params 1, eflags: 0x0
// Checksum 0xbab01a8b, Offset: 0x10b8
// Size: 0x96
function heli_comlink_lights_off(localclientnum) {
    self notify(#"heli_comlink_lights_off");
    if (isdefined(self.light_fx_handles_heli_comlink)) {
        for (i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
            if (isdefined(self.light_fx_handles_heli_comlink[i])) {
                deletefx(localclientnum, self.light_fx_handles_heli_comlink[i]);
            }
        }
        self.light_fx_handles_heli_comlink = undefined;
    }
}

