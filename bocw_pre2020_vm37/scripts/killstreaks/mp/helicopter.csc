#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\helicopter_sounds_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\helicopter_shared;

#namespace helicopter;

// Namespace helicopter/helicopter
// Params 0, eflags: 0x6
// Checksum 0x2b077def, Offset: 0x1f8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"helicopter", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace helicopter/helicopter
// Params 0, eflags: 0x5 linked
// Checksum 0x8555f28c, Offset: 0x248
// Size: 0x254
function private function_70a657d8() {
    init_shared();
    bundle = "killstreak_helicopter_guard";
    if (sessionmodeiswarzonegame()) {
        bundle += "_wz";
    }
    params = getscriptbundle(bundle);
    level._effect[#"heli_guard_light"][#"friendly"] = params.var_667eb0de;
    level._effect[#"heli_guard_light"][#"enemy"] = params.var_1d8c24a8;
    clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int", &warnmissilelocking, 0, 0);
    clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int", &warnmissilelocked, 0, 0);
    clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int", &warnmissilefired, 0, 0);
    clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int", &heli_comlink_bootup_anim, 0, 0);
    clientfield::register("vehicle", "active_camo", 1, 3, "int", &active_camo_changed, 0, 0);
    callback::on_spawned(&on_player_spawned);
}

// Namespace helicopter/helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0xf8ce60f4, Offset: 0x4a8
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

// Namespace helicopter/helicopter
// Params 7, eflags: 0x1 linked
// Checksum 0x15a1ea32, Offset: 0x550
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

// Namespace helicopter/helicopter
// Params 2, eflags: 0x1 linked
// Checksum 0xc935df5, Offset: 0x610
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

// Namespace helicopter/helicopter
// Params 7, eflags: 0x1 linked
// Checksum 0xe0b68a4b, Offset: 0x7a0
// Size: 0x3c
function heli_comlink_bootup_anim(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    
}

// Namespace helicopter/helicopter
// Params 7, eflags: 0x1 linked
// Checksum 0xc76ab188, Offset: 0x7e8
// Size: 0x7c
function warnmissilelocking(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !self function_4add50a7()) {
        return;
    }
    helicopter_sounds::play_targeted_sound(bwastimejump);
}

// Namespace helicopter/helicopter
// Params 7, eflags: 0x1 linked
// Checksum 0x18875142, Offset: 0x870
// Size: 0x7c
function warnmissilelocked(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !self function_4add50a7()) {
        return;
    }
    helicopter_sounds::play_locked_sound(bwastimejump);
}

// Namespace helicopter/helicopter
// Params 7, eflags: 0x1 linked
// Checksum 0xc66a671b, Offset: 0x8f8
// Size: 0x7c
function warnmissilefired(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump && !self function_4add50a7()) {
        return;
    }
    helicopter_sounds::play_fired_sound(bwastimejump);
}

// Namespace helicopter/helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0xab2a0225, Offset: 0x980
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

// Namespace helicopter/helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0x37530b8b, Offset: 0xae0
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

// Namespace helicopter/helicopter
// Params 1, eflags: 0x0
// Checksum 0x345b7207, Offset: 0xd18
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

// Namespace helicopter/helicopter
// Params 2, eflags: 0x1 linked
// Checksum 0xdc99d991, Offset: 0xe08
// Size: 0x54
function heli_comlink_lights_on_after_wait(localclientnum, wait_time) {
    self endon(#"death");
    self endon(#"heli_comlink_lights_off");
    wait wait_time;
    self heli_comlink_lights_on(localclientnum);
}

// Namespace helicopter/helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0xd84a0826, Offset: 0xe68
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

// Namespace helicopter/helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0x8a64dc8e, Offset: 0x1008
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

// Namespace helicopter/helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0x8ff2eb0, Offset: 0x10a8
// Size: 0x120
function updatemarkerthread(localclientnum) {
    self endon(#"death");
    player = self;
    killstreakcorebundle = getscriptbundle("killstreak_core");
    while (isdefined(player.markerobj)) {
        viewangles = getlocalclientangles(localclientnum);
        forwardvector = vectorscale(anglestoforward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
        results = bullettrace(player geteye(), player geteye() + forwardvector, 0, player);
        player.markerobj.origin = results[#"position"];
        waitframe(1);
    }
}

// Namespace helicopter/helicopter
// Params 1, eflags: 0x1 linked
// Checksum 0xda31b776, Offset: 0x11d0
// Size: 0x102
function stopcrateeffects(localclientnum) {
    crate = self;
    if (isdefined(crate.thrusterfxhandle0)) {
        stopfx(localclientnum, crate.thrusterfxhandle0);
    }
    if (isdefined(crate.thrusterfxhandle1)) {
        stopfx(localclientnum, crate.thrusterfxhandle1);
    }
    if (isdefined(crate.thrusterfxhandle2)) {
        stopfx(localclientnum, crate.thrusterfxhandle2);
    }
    if (isdefined(crate.thrusterfxhandle3)) {
        stopfx(localclientnum, crate.thrusterfxhandle3);
    }
    crate.thrusterfxhandle0 = undefined;
    crate.thrusterfxhandle1 = undefined;
    crate.thrusterfxhandle2 = undefined;
    crate.thrusterfxhandle3 = undefined;
}

// Namespace helicopter/helicopter
// Params 1, eflags: 0x0
// Checksum 0xa6b298fb, Offset: 0x12e0
// Size: 0x74
function cleanupthrustersthread(localclientnum) {
    crate = self;
    crate notify(#"cleanupthrustersthread_singleton");
    crate endon(#"cleanupthrustersthread_singleton");
    crate waittill(#"death");
    crate stopcrateeffects(localclientnum);
}

// Namespace helicopter/helicopter
// Params 7, eflags: 0x0
// Checksum 0xce66948c, Offset: 0x1360
// Size: 0x264
function marker_state_changed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    player = self;
    killstreakcorebundle = getscriptbundle("killstreak_core");
    if (bwastimejump == 1) {
        player.markerfx = killstreakcorebundle.fxvalidlocation;
    } else if (bwastimejump == 2) {
        player.markerfx = killstreakcorebundle.fxinvalidlocation;
    } else {
        player.markerfx = undefined;
    }
    if (isdefined(player.markerobj) && !player.markerobj hasdobj(fieldname)) {
        return;
    }
    if (isdefined(player.markerfxhandle)) {
        killfx(fieldname, player.markerfxhandle);
        player.markerfxhandle = undefined;
    }
    if (isdefined(player.markerfx)) {
        if (!isdefined(player.markerobj)) {
            player.markerobj = spawn(fieldname, (0, 0, 0), "script_model");
            player.markerobj.angles = (270, 0, 0);
            player.markerobj setmodel(#"wpn_t7_none_world");
            player.markerobj util::waittill_dobj(fieldname);
            player thread updatemarkerthread(fieldname);
        }
        player.markerfxhandle = util::playfxontag(fieldname, player.markerfx, player.markerobj, "tag_origin");
        return;
    }
    if (isdefined(player.markerobj)) {
        player.markerobj delete();
    }
}

