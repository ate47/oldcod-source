#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicleriders_shared;

#namespace vehicle;

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x2
// Checksum 0x24e27897, Offset: 0x7e0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"vehicle_shared", &__init__, undefined, undefined);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xe7280424, Offset: 0x828
// Size: 0xd54
function __init__() {
    level._customvehiclecbfunc = &spawned_callback;
    level.allvehicles = [];
    clientfield::register("vehicle", "toggle_lockon", 1, 1, "int", &field_toggle_lockon_handler, 0, 0);
    clientfield::register("vehicle", "toggle_sounds", 1, 1, "int", &field_toggle_sounds, 0, 0);
    clientfield::register("vehicle", "use_engine_damage_sounds", 1, 2, "int", &field_use_engine_damage_sounds, 0, 0);
    clientfield::register("vehicle", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0);
    clientfield::register("vehicle", "toggle_exhaustfx", 1, 1, "int", &field_toggle_exhaustfx_handler, 0, 0);
    clientfield::register("vehicle", "toggle_lights", 1, 2, "int", &field_toggle_lights_handler, 0, 0);
    clientfield::register("vehicle", "toggle_lights_group1", 1, 1, "int", &field_toggle_lights_group_handler1, 0, 0);
    clientfield::register("vehicle", "toggle_lights_group2", 1, 1, "int", &field_toggle_lights_group_handler2, 0, 0);
    clientfield::register("vehicle", "toggle_lights_group3", 1, 1, "int", &field_toggle_lights_group_handler3, 0, 0);
    clientfield::register("vehicle", "toggle_lights_group4", 1, 1, "int", &field_toggle_lights_group_handler4, 0, 0);
    clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int", &field_toggle_ambient_anim_handler1, 0, 0);
    clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int", &field_toggle_ambient_anim_handler2, 0, 0);
    clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int", &field_toggle_ambient_anim_handler3, 0, 0);
    clientfield::register("vehicle", "toggle_emp_fx", 1, 1, "int", &field_toggle_emp, 0, 0);
    clientfield::register("vehicle", "toggle_burn_fx", 1, 1, "int", &field_toggle_burn, 0, 0);
    clientfield::register("vehicle", "deathfx", 1, 2, "int", &field_do_deathfx, 0, 0);
    clientfield::register("vehicle", "stopallfx", 1, 1, "int", &function_4135bf97, 0, 0);
    clientfield::register("vehicle", "flickerlights", 1, 2, "int", &flicker_lights, 0, 0);
    clientfield::register("vehicle", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0);
    clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0);
    clientfield::register("vehicle", "stun", 1, 1, "int", &function_777009e6, 0, 0);
    clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0);
    clientfield::register("vehicle", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0);
    clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0);
    clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0);
    clientfield::register("vehicle", "toggle_horn_sound", 1, 1, "int", &function_88c3cb5e, 0, 0);
    clientfield::register("vehicle", "update_malfunction", 1, 2, "int", &function_97aae1ce, 0, 0);
    if (!sessionmodeiszombiesgame() && !(isdefined(level.var_56889215) && level.var_56889215)) {
        clientfield::register("clientuimodel", "vehicle.ammoCount", 1, 10, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.ammoReloading", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.ammoLow", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.rocketAmmo", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.ammo2Count", 1, 10, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.ammo2Reloading", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.ammo2Low", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.collisionWarning", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.enemyInReticle", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.missileRepulsed", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.incomingMissile", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.malfunction", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.showHoldToExitPrompt", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.holdToExitProgress", 1, 5, "float", undefined, 0, 0);
        clientfield::register("clientuimodel", "vehicle.vehicleAttackMode", 1, 3, "int", undefined, 0, 0);
        for (i = 0; i < 3; i++) {
            clientfield::register("clientuimodel", "vehicle.bindingCooldown" + i + ".cooldown", 1, 5, "float", undefined, 0, 0);
        }
    }
    clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int", &field_toggle_dnidamagefx, 0, 0);
    clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int", &toggle_flir_postfxbundle, 0, 0);
    clientfield::register("toplayer", "static_postfx", 1, 1, "int", &set_static_postfxbundle, 0, 1);
    clientfield::register("vehicle", "vehUseMaterialPhysics", 1, 1, "int", &function_e091202b, 0, 0);
    clientfield::register("scriptmover", "play_flare_fx", 1, 1, "int", &play_flare_fx, 0, 0);
    clientfield::register("scriptmover", "play_flare_hit_fx", 1, 1, "int", &play_flare_hit_fx, 0, 0);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x897c21e4, Offset: 0x1588
// Size: 0x92
function add_vehicletype_callback(vehicletype, callback, data = undefined) {
    if (!isdefined(level.vehicletypecallbackarray)) {
        level.vehicletypecallbackarray = [];
    }
    if (!isdefined(level.var_625af09a)) {
        level.var_625af09a = [];
    }
    level.vehicletypecallbackarray[vehicletype] = callback;
    level.var_625af09a[vehicletype] = data;
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x4
// Checksum 0x6a3468cf, Offset: 0x1628
// Size: 0x9a
function private function_b72d32d4(localclientnum, vehicletype) {
    if (isdefined(vehicletype) && isdefined(level.vehicletypecallbackarray[vehicletype])) {
        if (isdefined(level.var_625af09a[vehicletype])) {
            self thread [[ level.vehicletypecallbackarray[vehicletype] ]](localclientnum, level.var_625af09a[vehicletype]);
        } else {
            self thread [[ level.vehicletypecallbackarray[vehicletype] ]](localclientnum);
        }
        return true;
    }
    return false;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x646d59c3, Offset: 0x16d0
// Size: 0x11c
function spawned_callback(localclientnum) {
    if (isdefined(self.vehicleridersbundle)) {
        set_vehicleriders_bundle(self.vehicleridersbundle);
    }
    self callback::callback(#"on_vehicle_spawned", localclientnum);
    vehicletype = self.vehicletype;
    if (isdefined(level.vehicletypecallbackarray)) {
        if (!function_b72d32d4(localclientnum, vehicletype)) {
            function_b72d32d4(localclientnum, self.scriptvehicletype);
        }
    }
    if (self usessubtargets()) {
        self thread watch_vehicle_damage();
    }
    array::add(level.allvehicles, self, 0);
    self callback::on_shutdown(&on_shutdown);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x49e85fcf, Offset: 0x17f8
// Size: 0x44
function on_shutdown(localclientnum) {
    self function_1bb72703();
    arrayremovevalue(level.allvehicles, self);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xc8c7c1df, Offset: 0x1848
// Size: 0xc0
function watch_vehicle_damage() {
    self endon(#"death");
    self.notifyonbulletimpact = 1;
    while (isdefined(self)) {
        waitresult = self waittill(#"damage");
        subtarget = waitresult.subtarget;
        attacker = waitresult.attacker;
        if (attacker function_60dbc438() && isdefined(subtarget) && subtarget > 0) {
            self thread function_d0ef3a09(subtarget);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x1fa226be, Offset: 0x1910
// Size: 0x154
function function_d0ef3a09(subtarget) {
    self endon(#"death");
    time = gettime();
    if (isdefined(subtarget)) {
        if (!isdefined(self.var_f02127fe)) {
            self.var_f02127fe = [];
        }
        if (!isdefined(self.var_f02127fe[subtarget]) || self.var_f02127fe[subtarget] <= time) {
            self.var_f02127fe[subtarget] = time + 150;
            bone = self submodelboneforsubtarget(subtarget);
            self playrenderoverridebundle(#"hash_20bdbaa0db5eb57d", bone);
            wait 0.1;
            self stoprenderoverridebundle(#"hash_20bdbaa0db5eb57d", bone);
        }
        return;
    }
    self playrenderoverridebundle(#"hash_20bdbaa0db5eb57d");
    wait 0.15;
    self stoprenderoverridebundle(#"hash_20bdbaa0db5eb57d");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x8ce7344e, Offset: 0x1a70
// Size: 0x2b6
function rumble(localclientnum) {
    self endon(#"death");
    if (!isdefined(self.rumbletype) || self.rumbleradius == 0) {
        return;
    }
    if (!isdefined(self.rumbleon)) {
        self.rumbleon = 1;
    }
    height = self.rumbleradius * 2;
    zoffset = -1 * self.rumbleradius;
    self.player_touching = 0;
    radius_squared = self.rumbleradius * self.rumbleradius;
    wait 2;
    while (true) {
        if (!isdefined(level.localplayers[localclientnum]) || distancesquared(self.origin, level.localplayers[localclientnum].origin) > radius_squared || self getspeed() == 0) {
            wait 0.2;
            continue;
        }
        if (isdefined(self.rumbleon) && !self.rumbleon) {
            wait 0.2;
            continue;
        }
        self playrumblelooponentity(localclientnum, self.rumbletype);
        while (isdefined(level.localplayers[localclientnum]) && distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 0) {
            earthquake(localclientnum, self.rumblescale, self.rumbleduration, self.origin, self.rumbleradius);
            time_to_wait = self.rumblebasetime + randomfloat(self.rumbleadditionaltime);
            if (time_to_wait <= 0) {
                time_to_wait = 0.05;
            }
            wait time_to_wait;
        }
        if (isdefined(level.localplayers[localclientnum])) {
            self stoprumble(localclientnum, self.rumbletype);
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xc89eba48, Offset: 0x1d30
// Size: 0x16
function kill_treads_forever() {
    self notify(#"kill_treads_forever");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x24e37c16, Offset: 0x1d50
// Size: 0x1b2
function play_exhaust(localclientnum) {
    if (isdefined(self.csf_no_exhaust) && self.csf_no_exhaust) {
        return;
    }
    if (!isdefined(self.exhaust_fx) && isdefined(self.exhaustfxname)) {
        if (!isdefined(level._effect)) {
            level._effect = [];
        }
        if (!isdefined(level._effect[self.exhaustfxname])) {
            level._effect[self.exhaustfxname] = self.exhaustfxname;
        }
        self.exhaust_fx = level._effect[self.exhaustfxname];
    }
    if (isdefined(self.exhaust_fx) && isdefined(self.exhaustfxtag1)) {
        if (isalive(self)) {
            assert(isdefined(self.exhaustfxtag1), self.vehicletype + "<dev string:x30>");
            self endon(#"death");
            self util::waittill_dobj(localclientnum);
            self.exhaust_id_left = util::playfxontag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag1);
            if (!isdefined(self.exhaust_id_right) && isdefined(self.exhaustfxtag2)) {
                self.exhaust_id_right = util::playfxontag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag2);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd15ad34, Offset: 0x1f10
// Size: 0x9e
function stop_exhaust(localclientnum) {
    self util::waittill_dobj(localclientnum);
    waitframe(1);
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.exhaust_id_left)) {
        stopfx(localclientnum, self.exhaust_id_left);
        self.exhaust_id_left = undefined;
    }
    if (isdefined(self.exhaust_id_right)) {
        stopfx(localclientnum, self.exhaust_id_right);
        self.exhaust_id_right = undefined;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x3d76c7b, Offset: 0x1fb8
// Size: 0x88
function boost_think(localclientnum) {
    self endon(#"death");
    for (;;) {
        self waittill(#"veh_boost");
        self play_boost(localclientnum, 0);
        if (isinvehicle(localclientnum, self)) {
            self play_boost(localclientnum, 1);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x84e4def7, Offset: 0x2048
// Size: 0x1a4
function play_boost(localclientnum, var_239bda6b) {
    if (var_239bda6b) {
        var_c3c152b5 = self.var_a9efa4f4;
        var_e0895cdc = self.var_dc94f30f;
        var_7fcb2f76 = undefined;
    } else {
        var_c3c152b5 = self.var_73dd201;
        var_e0895cdc = self.var_e46ef01;
        var_7fcb2f76 = self.var_3449696a;
    }
    if (isdefined(var_c3c152b5)) {
        if (isalive(self)) {
            assert(isdefined(var_e0895cdc), self.vehicletype + "<dev string:x8c>");
            self endon(#"death");
            self util::waittill_dobj(localclientnum);
            var_b7c24c15 = util::playfxontag(localclientnum, var_c3c152b5, self, var_e0895cdc);
            if (isdefined(var_7fcb2f76)) {
                var_ef61dc8d = util::playfxontag(localclientnum, var_c3c152b5, self, var_7fcb2f76);
            }
            if (var_239bda6b) {
                self thread function_b902297f(localclientnum, var_b7c24c15);
            }
            self thread kill_boost(localclientnum, var_b7c24c15);
            if (isdefined(var_ef61dc8d)) {
                self thread kill_boost(localclientnum, var_ef61dc8d);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x8404e3bb, Offset: 0x21f8
// Size: 0x64
function kill_boost(localclientnum, var_b7c24c15) {
    self endon(#"death");
    wait self.boostduration + 0.5;
    self notify(#"end_boost");
    stopfx(localclientnum, var_b7c24c15);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xffd45de7, Offset: 0x2268
// Size: 0x96
function function_b902297f(localclientnum, var_b7c24c15) {
    self endon(#"end_boost");
    self endon(#"veh_boost");
    self endon(#"death");
    while (true) {
        if (!isinvehicle(localclientnum, self)) {
            stopfx(localclientnum, var_b7c24c15);
            break;
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xd62a02, Offset: 0x2308
// Size: 0x310
function aircraft_dustkick() {
    self endon(#"death");
    waittillframeend();
    self endon(#"kill_treads_forever");
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.treadfxnamearray)) {
        return;
    }
    if (isdefined(self.csf_no_tread) && self.csf_no_tread) {
        return;
    }
    while (isdefined(self)) {
        fxarray = self.treadfxnamearray;
        if (!isdefined(fxarray)) {
            wait 1;
            continue;
        }
        trace = bullettrace(self.origin, self.origin - (0, 0, 700 * 2), 0, self, 1);
        distsqr = distancesquared(self.origin, trace[#"position"]);
        if (trace[#"fraction"] < 0.01 || distsqr < 0 * 0) {
            wait 0.2;
            continue;
        } else if (trace[#"fraction"] >= 1 || distsqr > 700 * 700) {
            wait 1;
            continue;
        }
        if (0 * 0 < distsqr && distsqr < 700 * 700) {
            surfacetype = trace[#"surfacetype"];
            if (!isdefined(surfacetype)) {
                surfacetype = "dirt";
            }
            if (isdefined(fxarray[surfacetype])) {
                forward = anglestoforward(self.angles);
                playfx(0, fxarray[surfacetype], trace[#"position"], (0, 0, 1), forward);
            }
            velocity = self getvelocity();
            speed = length(velocity);
            waittime = mapfloat(10, 100, 1, 0.2, speed);
            wait waittime;
            continue;
        }
        wait 1;
        continue;
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xc04e6281, Offset: 0x2620
// Size: 0x136
function lights_on(localclientnum, team) {
    lights_off(localclientnum);
    self endon(#"death");
    util::waittill_dobj(localclientnum);
    if (isdefined(self.lightfxnamearray)) {
        if (!isdefined(self.light_fx_handles)) {
            self.light_fx_handles = [];
        }
        for (i = 0; i < self.lightfxnamearray.size; i++) {
            self.light_fx_handles[i] = util::playfxontag(localclientnum, self.lightfxnamearray[i], self, self.lightfxtagarray[i]);
            setfxignorepause(localclientnum, self.light_fx_handles[i], 1);
            if (isdefined(team)) {
                setfxteam(localclientnum, self.light_fx_handles[i], team);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0xb452eab0, Offset: 0x2760
// Size: 0x108
function addanimtolist(animitem, &liston, &listoff, playwhenoff, id, maxid) {
    if (isdefined(animitem) && id <= maxid) {
        if (playwhenoff === 1) {
            if (!isdefined(listoff)) {
                listoff = [];
            } else if (!isarray(listoff)) {
                listoff = array(listoff);
            }
            listoff[listoff.size] = animitem;
            return;
        }
        if (!isdefined(liston)) {
            liston = [];
        } else if (!isarray(liston)) {
            liston = array(liston);
        }
        liston[liston.size] = animitem;
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x70409b7d, Offset: 0x2870
// Size: 0x5ee
function ambient_anim_toggle(localclientnum, groupid, ison) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings)) {
        return;
    }
    self endon(#"death");
    util::waittill_dobj(localclientnum);
    liston = [];
    listoff = [];
    switch (groupid) {
    case 1:
        addanimtolist(settings.ambient_group1_anim1, liston, listoff, settings.ambient_group1_off1, 1, settings.ambient_group1_numslots);
        addanimtolist(settings.ambient_group1_anim2, liston, listoff, settings.ambient_group1_off2, 2, settings.ambient_group1_numslots);
        addanimtolist(settings.ambient_group1_anim3, liston, listoff, settings.ambient_group1_off3, 3, settings.ambient_group1_numslots);
        addanimtolist(settings.ambient_group1_anim4, liston, listoff, settings.ambient_group1_off4, 4, settings.ambient_group1_numslots);
        break;
    case 2:
        addanimtolist(settings.ambient_group2_anim1, liston, listoff, settings.ambient_group2_off1, 1, settings.ambient_group2_numslots);
        addanimtolist(settings.ambient_group2_anim2, liston, listoff, settings.ambient_group2_off2, 2, settings.ambient_group2_numslots);
        addanimtolist(settings.ambient_group2_anim3, liston, listoff, settings.ambient_group2_off3, 3, settings.ambient_group2_numslots);
        addanimtolist(settings.ambient_group2_anim4, liston, listoff, settings.ambient_group2_off4, 4, settings.ambient_group2_numslots);
        break;
    case 3:
        addanimtolist(settings.ambient_group3_anim1, liston, listoff, settings.ambient_group3_off1, 1, settings.ambient_group3_numslots);
        addanimtolist(settings.ambient_group3_anim2, liston, listoff, settings.ambient_group3_off2, 2, settings.ambient_group3_numslots);
        addanimtolist(settings.ambient_group3_anim3, liston, listoff, settings.ambient_group3_off3, 3, settings.ambient_group3_numslots);
        addanimtolist(settings.ambient_group3_anim4, liston, listoff, settings.ambient_group3_off4, 4, settings.ambient_group3_numslots);
        break;
    case 4:
        addanimtolist(settings.ambient_group4_anim1, liston, listoff, settings.ambient_group4_off1, 1, settings.ambient_group4_numslots);
        addanimtolist(settings.ambient_group4_anim2, liston, listoff, settings.ambient_group4_off2, 2, settings.ambient_group4_numslots);
        addanimtolist(settings.ambient_group4_anim3, liston, listoff, settings.ambient_group4_off3, 3, settings.ambient_group4_numslots);
        addanimtolist(settings.ambient_group4_anim4, liston, listoff, settings.ambient_group4_off4, 4, settings.ambient_group4_numslots);
        break;
    }
    if (ison) {
        weighton = 1;
        weightoff = 0;
    } else {
        weighton = 0;
        weightoff = 1;
    }
    for (i = 0; i < liston.size; i++) {
        self setanim(liston[i], weighton, 0.2, 1);
    }
    for (i = 0; i < listoff.size; i++) {
        self setanim(listoff[i], weightoff, 0.2, 1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xfaddb914, Offset: 0x2e68
// Size: 0x5c
function field_toggle_ambient_anim_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self ambient_anim_toggle(localclientnum, 1, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x5ab2db74, Offset: 0x2ed0
// Size: 0x5c
function field_toggle_ambient_anim_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self ambient_anim_toggle(localclientnum, 2, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x1a01cd27, Offset: 0x2f38
// Size: 0x5c
function field_toggle_ambient_anim_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self ambient_anim_toggle(localclientnum, 3, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x8f7c3bb, Offset: 0x2fa0
// Size: 0x5c
function field_toggle_ambient_anim_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self ambient_anim_toggle(localclientnum, 4, newval);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xe3c2fb23, Offset: 0x3008
// Size: 0x38a
function lights_group_toggle(localclientnum, groupid, ison) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings) || !isdefined(settings.lightgroups_numgroups)) {
        return;
    }
    self endon(#"death");
    if (isdefined(self.lightfxgroups) && isdefined(self.lightfxgroups[groupid])) {
        foreach (fx_handle in self.lightfxgroups[groupid]) {
            stopfx(localclientnum, fx_handle);
        }
    }
    if (!ison) {
        return;
    }
    util::waittill_dobj(localclientnum);
    if (!isdefined(self.lightfxgroups)) {
        self.lightfxgroups = [];
    }
    if (!isdefined(self.lightfxgroups[groupid])) {
        self.lightfxgroups[groupid] = [];
    }
    fxlist = [];
    taglist = [];
    switch (groupid) {
    case 0:
        function_70c032e2(settings.lightgroups_1_slots, fxlist, taglist);
        break;
    case 1:
        function_70c032e2(settings.lightgroups_2_slots, fxlist, taglist);
        break;
    case 2:
        function_70c032e2(settings.lightgroups_3_slots, fxlist, taglist);
        break;
    case 3:
        function_70c032e2(settings.lightgroups_4_slots, fxlist, taglist);
        break;
    }
    for (i = 0; i < fxlist.size; i++) {
        fx_handle = util::playfxontag(localclientnum, fxlist[i], self, taglist[i]);
        if (!isdefined(self.lightfxgroups[groupid])) {
            self.lightfxgroups[groupid] = [];
        } else if (!isarray(self.lightfxgroups[groupid])) {
            self.lightfxgroups[groupid] = array(self.lightfxgroups[groupid]);
        }
        self.lightfxgroups[groupid][self.lightfxgroups[groupid].size] = fx_handle;
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x14cbcb3c, Offset: 0x33a0
// Size: 0x5c
function field_toggle_lights_group_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lights_group_toggle(localclientnum, 0, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xb1e2600c, Offset: 0x3408
// Size: 0x5c
function field_toggle_lights_group_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lights_group_toggle(localclientnum, 1, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x902afa10, Offset: 0x3470
// Size: 0x5c
function field_toggle_lights_group_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lights_group_toggle(localclientnum, 2, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x2cfa0448, Offset: 0x34d8
// Size: 0x5c
function field_toggle_lights_group_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lights_group_toggle(localclientnum, 3, newval);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x2549d68c, Offset: 0x3540
// Size: 0x6e
function delete_alert_lights(localclientnum) {
    if (isdefined(self.alert_light_fx_handles)) {
        for (i = 0; i < self.alert_light_fx_handles.size; i++) {
            stopfx(localclientnum, self.alert_light_fx_handles[i]);
        }
    }
    self.alert_light_fx_handles = undefined;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc7ee904, Offset: 0x35b8
// Size: 0x84
function lights_off(localclientnum) {
    if (isdefined(self.light_fx_handles)) {
        for (i = 0; i < self.light_fx_handles.size; i++) {
            stopfx(localclientnum, self.light_fx_handles[i]);
        }
    }
    self.light_fx_handles = undefined;
    delete_alert_lights(localclientnum);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0xa42cb249, Offset: 0x3648
// Size: 0x2fe
function lights_flicker(localclientnum, duration = 8, var_627f22e2 = 1) {
    self notify("79fb1ead51919d32");
    self endon("79fb1ead51919d32");
    self endon(#"cancel_flicker");
    self endon(#"death");
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    state = 1;
    durationleft = gettime() + int(duration * 1000);
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings) || !isdefined(settings.lightgroups_numgroups)) {
        while (durationleft > gettime()) {
            if (randomint(4) == 0) {
                state = !state;
                if (state) {
                    self lights_on(localclientnum);
                } else {
                    self lights_off(localclientnum);
                }
            }
            waitframe(1);
        }
    } else {
        while (durationleft > gettime()) {
            state = !state;
            self lights_group_toggle(localclientnum, randomint(settings.lightgroups_numgroups), state);
            waitframe(1);
        }
        if (var_627f22e2) {
            for (i = 0; i < settings.lightgroups_numgroups; i++) {
                self lights_group_toggle(localclientnum, i, 0);
            }
        }
    }
    if (var_627f22e2) {
        self lights_off(localclientnum);
        if (isdefined(settings)) {
            for (i = 0; i < settings.lightgroups_numgroups; i++) {
                self lights_group_toggle(localclientnum, i, 0);
            }
        }
        return;
    }
    if (!state) {
        self lights_on(localclientnum);
        if (isdefined(settings)) {
            for (i = 0; i < settings.lightgroups_numgroups; i++) {
                self lights_group_toggle(localclientnum, i, 1);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xbc211494, Offset: 0x3950
// Size: 0x64
function field_toggle_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread toggle_fx_bundle(localclientnum, "emp_base", newval == 1);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xb4f3c2c6, Offset: 0x39c0
// Size: 0x64
function field_toggle_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread toggle_fx_bundle(localclientnum, "burn_base", newval == 1);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xf5b7e8b, Offset: 0x3a30
// Size: 0xee
function flicker_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self notify(#"cancel_flicker");
        self lights_off(localclientnum);
        return;
    }
    if (newval == 1) {
        self thread lights_flicker(localclientnum);
        return;
    }
    if (newval == 2) {
        self thread lights_flicker(localclientnum, 20);
        return;
    }
    if (newval == 3) {
        self notify(#"cancel_flicker");
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xb0f3f283, Offset: 0x3b28
// Size: 0x154
function function_4135bf97(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (isdefined(self)) {
        function_6a1989b9(localclientnum, self, 1);
        self thread function_1e76e649(localclientnum, "emp_base");
        self thread function_1e76e649(localclientnum, "burn_base");
        self thread function_1e76e649(localclientnum, "smolder");
        self thread function_1e76e649(localclientnum, "death");
        self thread function_1e76e649(localclientnum, "empdeath");
        if (newval) {
            self lights_off(localclientnum);
        }
        self thread stop_exhaust(localclientnum);
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x2ba6756b, Offset: 0x3c88
// Size: 0x11c
function function_1e76e649(localclientnum, name) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.fx_handles)) {
        self.fx_handles = [];
    }
    if (isdefined(self.fx_handles[name])) {
        handle = self.fx_handles[name];
        if (isdefined(handle)) {
            if (isarray(handle)) {
                foreach (handleelement in handle) {
                    stopfx(localclientnum, handleelement);
                }
                return;
            }
            stopfx(localclientnum, handle);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x2f6dc8f0, Offset: 0x3db0
// Size: 0x1ae
function toggle_fx_bundle(localclientnum, name, turnon) {
    if (!isdefined(self.settings) && isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    if (!isdefined(self.settings)) {
        return;
    }
    self endon(#"death");
    self notify("end_toggle_field_fx_" + name);
    self endon("end_toggle_field_fx_" + name);
    util::waittill_dobj(localclientnum);
    self function_1e76e649(localclientnum, name);
    if (turnon) {
        for (i = 1; ; i++) {
            fx = self.settings.(name + "_fx_" + i);
            if (!isdefined(fx)) {
                return;
            }
            tag = self.settings.(name + "_tag_" + i);
            delay = self.settings.(name + "_delay_" + i);
            self thread delayed_fx_thread(localclientnum, name, fx, tag, delay);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 5, eflags: 0x0
// Checksum 0xcd76323b, Offset: 0x3f68
// Size: 0x140
function delayed_fx_thread(localclientnum, name, fx, tag, delay) {
    self endon(#"death");
    self endon("end_toggle_field_fx_" + name);
    if (!isdefined(tag)) {
        return;
    }
    if (isdefined(delay) && delay > 0) {
        wait delay;
    }
    fx_handle = util::playfxontag(localclientnum, fx, self, tag);
    if (!isdefined(self.fx_handles[name])) {
        self.fx_handles[name] = [];
    } else if (!isarray(self.fx_handles[name])) {
        self.fx_handles[name] = array(self.fx_handles[name]);
    }
    self.fx_handles[name][self.fx_handles[name].size] = fx_handle;
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xa82ba091, Offset: 0x40b0
// Size: 0xe4
function field_toggle_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self.vehicleclass === "helicopter") {
        if (newval) {
            self notify(#"stop_heli_sounds");
            self.should_not_play_sounds = 1;
        } else {
            self notify(#"play_heli_sounds");
            self.should_not_play_sounds = 0;
        }
    }
    if (newval) {
        self disablevehiclesounds();
        self function_1bb72703();
        return;
    }
    self enablevehiclesounds();
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x4
// Checksum 0x126242a3, Offset: 0x41a0
// Size: 0x1c
function private function_1bb72703() {
    self function_6125d61d();
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x736e9005, Offset: 0x41c8
// Size: 0x64
function field_toggle_dnidamagefx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle(#"pstfx_dni_vehicle_dmg");
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xa874c7a6, Offset: 0x4238
// Size: 0x1d4
function toggle_flir_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = self;
    if (newval == oldval) {
        return;
    }
    if (!isdefined(player) || !player function_60dbc438()) {
        return;
    }
    if (newval == 0) {
        if (oldval == 1) {
            player thread postfx::stoppostfxbundle("pstfx_infrared");
        } else if (oldval == 2) {
            player thread postfx::stoppostfxbundle("pstfx_flir");
        }
        update_ui_fullscreen_filter_model(localclientnum, 0);
        return;
    }
    if (newval == 1) {
        if (player shouldchangescreenpostfx(localclientnum)) {
            player thread postfx::playpostfxbundle(#"pstfx_infrared");
            update_ui_fullscreen_filter_model(localclientnum, 2);
        }
        return;
    }
    if (newval == 2) {
        should_change = 1;
        if (player shouldchangescreenpostfx(localclientnum)) {
            player thread postfx::playpostfxbundle(#"pstfx_flir");
            update_ui_fullscreen_filter_model(localclientnum, 1);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xe63b9dd0, Offset: 0x4418
// Size: 0x8e
function shouldchangescreenpostfx(localclientnum) {
    player = self;
    assert(isdefined(player));
    if (function_1fe374eb(localclientnum)) {
        killcamentity = function_e27699cf(localclientnum);
        if (isdefined(killcamentity) && killcamentity != player) {
            return false;
        }
    }
    return true;
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x9e742ed0, Offset: 0x44b0
// Size: 0x12c
function set_static_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = self;
    if (newval == oldval) {
        return;
    }
    if (!isdefined(player) || !player function_60dbc438()) {
        return;
    }
    if (newval == 0) {
        if (player postfx::function_7348f3a5(#"pstfx_static")) {
            player thread postfx::stoppostfxbundle(#"pstfx_static");
        }
        return;
    }
    if (newval == 1) {
        if (player postfx::function_7348f3a5(#"pstfx_static") == 0) {
            player thread postfx::playpostfxbundle(#"pstfx_static");
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xae78856a, Offset: 0x45e8
// Size: 0x7c
function update_ui_fullscreen_filter_model(localclientnum, vision_set_value) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = getuimodel(controllermodel, "vehicle.fullscreenFilter");
    if (isdefined(model)) {
        setuimodelvalue(model, vision_set_value);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xcac9b0c3, Offset: 0x4670
// Size: 0x20c
function field_toggle_treadfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self.vehicleclass === "helicopter" || self.vehicleclass === "plane") {
        println("<dev string:xe4>");
        if (newval) {
            if (isdefined(self.csf_no_tread)) {
                self.csf_no_tread = 0;
            }
            self kill_treads_forever();
            self thread aircraft_dustkick();
        } else if (isdefined(bnewent) && bnewent) {
            self.csf_no_tread = 1;
        } else {
            self kill_treads_forever();
        }
        return;
    }
    if (newval) {
        println("<dev string:x104>");
        if (isdefined(bnewent) && bnewent) {
            println("<dev string:x12b>" + self getentitynumber());
            self.csf_no_tread = 1;
        } else {
            println("<dev string:x149>" + self getentitynumber());
            self kill_treads_forever();
        }
        return;
    }
    println("<dev string:x165>");
    if (isdefined(self.csf_no_tread)) {
        self.csf_no_tread = 0;
    }
    self kill_treads_forever();
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x7e65ace1, Offset: 0x4888
// Size: 0xea
function field_use_engine_damage_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self.vehicleclass === "helicopter") {
        switch (newval) {
        case 0:
            self.engine_damage_low = 0;
            self.engine_damage_high = 0;
            break;
        case 1:
            self.engine_damage_low = 1;
            self.engine_damage_high = 0;
            break;
        case 1:
            self.engine_damage_low = 0;
            self.engine_damage_high = 1;
            break;
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x4
// Checksum 0x94c223de, Offset: 0x4980
// Size: 0x2a
function private function_fb5cbb8e() {
    self.var_f9b394a1 = self playloopsound(self.hornsound);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x4
// Checksum 0x17c3912, Offset: 0x49b8
// Size: 0x36
function private function_6125d61d() {
    if (isdefined(self.var_f9b394a1)) {
        self stoploopsound(self.var_f9b394a1);
        self.var_f9b394a1 = undefined;
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x4
// Checksum 0x328bd8ee, Offset: 0x49f8
// Size: 0x9c
function private function_88c3cb5e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self function_2a8c9709()) {
        return;
    }
    if (!isdefined(self.hornsound)) {
        return;
    }
    if (newval) {
        self function_fb5cbb8e();
        return;
    }
    self function_6125d61d();
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xed9cfa1, Offset: 0x4aa0
// Size: 0x696
function function_97aae1ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.settings) && isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    if (!isdefined(self.settings) || !isdefined(self.settings.malfunction_effects)) {
        return;
    }
    if (!isdefined(self.fx_handles)) {
        self.fx_handles = [];
    }
    if (!isdefined(self.fx_handles[#"malfunction"])) {
        self.fx_handles[#"malfunction"] = [];
    }
    foreach (handle in self.fx_handles[#"malfunction"]) {
        stopfx(localclientnum, handle);
    }
    self.fx_handles[#"malfunction"] = [];
    if (newval) {
        foreach (var_f180da7 in self.settings.malfunction_effects) {
            tag = var_f180da7.var_7ca8a1ef;
            effect = var_f180da7.transition;
            if (isdefined(var_f180da7.transition) && isdefined(var_f180da7.var_7ca8a1ef)) {
                util::playfxontag(localclientnum, var_f180da7.transition, self, var_f180da7.var_7ca8a1ef);
            }
            switch (newval) {
            case 0:
                break;
            case 1:
                if (isdefined(var_f180da7.warning) && isdefined(var_f180da7.tag_warning)) {
                    handle = util::playfxontag(localclientnum, var_f180da7.warning, self, var_f180da7.tag_warning);
                    if (!isdefined(self.fx_handles[#"malfunction"])) {
                        self.fx_handles[#"malfunction"] = [];
                    } else if (!isarray(self.fx_handles[#"malfunction"])) {
                        self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
                    }
                    self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
                }
                break;
            case 2:
                if (isdefined(var_f180da7.active) && isdefined(var_f180da7.var_8dee63b8)) {
                    handle = util::playfxontag(localclientnum, var_f180da7.active, self, var_f180da7.var_8dee63b8);
                    if (!isdefined(self.fx_handles[#"malfunction"])) {
                        self.fx_handles[#"malfunction"] = [];
                    } else if (!isarray(self.fx_handles[#"malfunction"])) {
                        self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
                    }
                    self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
                }
                break;
            case 3:
                if (isdefined(var_f180da7.fatal) && isdefined(var_f180da7.var_a56737d8)) {
                    handle = util::playfxontag(localclientnum, var_f180da7.fatal, self, var_f180da7.var_a56737d8);
                    if (!isdefined(self.fx_handles[#"malfunction"])) {
                        self.fx_handles[#"malfunction"] = [];
                    } else if (!isarray(self.fx_handles[#"malfunction"])) {
                        self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
                    }
                    self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
                }
                break;
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xf8927611, Offset: 0x5140
// Size: 0x114
function field_do_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval) {
        self stop_stun_fx(localclientnum);
    }
    if (newval == 2) {
        self field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    } else {
        self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
    if (isdefined(self.var_75175b9a)) {
        self thread function_d29a821e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x623f778c, Offset: 0x5260
// Size: 0x33c
function function_d29a821e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !binitialsnap) {
        self endon(#"death");
        if (isdefined(self.var_3baea236)) {
            wait self.var_3baea236;
        }
        if (!isdefined(self.fx_handles)) {
            self.fx_handles = [];
        }
        if (!isdefined(self.fx_handles[#"smolder"])) {
            self.fx_handles[#"smolder"] = [];
        }
        if (isdefined(self.var_75175b9a) && self.var_75175b9a != "") {
            if (isdefined(self.var_d1d78681) && self.var_d1d78681 != "") {
                handle = util::playfxontag(localclientnum, self.var_75175b9a, self, self.var_d1d78681);
            } else {
                handle = playfx(localclientnum, self.var_75175b9a, self.origin);
            }
            setfxignorepause(localclientnum, handle, 1);
            if (!isdefined(self.fx_handles[#"smolder"])) {
                self.fx_handles[#"smolder"] = [];
            } else if (!isarray(self.fx_handles[#"smolder"])) {
                self.fx_handles[#"smolder"] = array(self.fx_handles[#"smolder"]);
            }
            self.fx_handles[#"smolder"][self.fx_handles[#"smolder"].size] = handle;
        }
        if (isdefined(self.var_c5d889f4) && self.var_c5d889f4 != "") {
            self playsound(localclientnum, self.var_c5d889f4);
        }
        if (isdefined(handle) && isdefined(self.var_49f8ae7d) && self.var_49f8ae7d > 0) {
            wait self.var_49f8ae7d;
            if (isfxplaying(localclientnum, handle)) {
                stopfx(localclientnum, handle);
                arrayremovevalue(self.fx_handles[#"smolder"], handle, 0);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x81d32820, Offset: 0x55a8
// Size: 0x304
function field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !binitialsnap) {
        self endon(#"death");
        util::waittill_dobj(localclientnum);
        if (!isdefined(self.fx_handles)) {
            self.fx_handles = [];
        }
        if (!isdefined(self.fx_handles[#"death"])) {
            self.fx_handles[#"death"] = [];
        }
        if (isdefined(self.deathfxname)) {
            if (isdefined(self.deathfxtag) && self.deathfxtag != "") {
                handle = util::playfxontag(localclientnum, self.deathfxname, self, self.deathfxtag);
            } else {
                handle = playfx(localclientnum, self.deathfxname, self.origin);
            }
            setfxignorepause(localclientnum, handle, 1);
            if (!isdefined(self.fx_handles[#"death"])) {
                self.fx_handles[#"death"] = [];
            } else if (!isarray(self.fx_handles[#"death"])) {
                self.fx_handles[#"death"] = array(self.fx_handles[#"death"]);
            }
            self.fx_handles[#"death"][self.fx_handles[#"death"].size] = handle;
        }
        self playsound(localclientnum, self.deathfxsound);
        if (isdefined(self.deathquakescale) && self.deathquakescale > 0) {
            earthquake(localclientnum, self.deathquakescale, self.deathquakeduration, self.origin, self.deathquakeradius);
        }
        if (isdefined(self.var_617fc376) && self.var_617fc376 != "") {
            self playrumbleonentity(localclientnum, self.var_617fc376);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xbd8a5ae9, Offset: 0x58b8
// Size: 0x394
function field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.settings) && isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    if (!isdefined(self.settings)) {
        self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    if (newval && !binitialsnap) {
        self endon(#"death");
        util::waittill_dobj(localclientnum);
        if (!isdefined(self.fx_handles)) {
            self.fx_handles = [];
        }
        if (!isdefined(self.fx_handles[#"empdeath"])) {
            self.fx_handles[#"empdeath"] = [];
        }
        s = self.settings;
        if (isdefined(s.emp_death_fx_1)) {
            if (isdefined(s.emp_death_tag_1) && s.emp_death_tag_1 != "") {
                handle = util::playfxontag(localclientnum, s.emp_death_fx_1, self, s.emp_death_tag_1);
            } else {
                handle = playfx(localclientnum, s.emp_death_tag_1, self.origin);
            }
            setfxignorepause(localclientnum, handle, 1);
            if (!isdefined(self.fx_handles[#"empdeath"])) {
                self.fx_handles[#"empdeath"] = [];
            } else if (!isarray(self.fx_handles[#"empdeath"])) {
                self.fx_handles[#"empdeath"] = array(self.fx_handles[#"empdeath"]);
            }
            self.fx_handles[#"empdeath"][self.fx_handles[#"empdeath"].size] = handle;
        }
        self playsound(localclientnum, s.emp_death_sound_1);
        if (isdefined(self.deathquakescale) && self.deathquakescale > 0) {
            earthquake(localclientnum, self.deathquakescale * 0.25, self.deathquakeduration * 2, self.origin, self.deathquakeradius);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x944677e8, Offset: 0x5c58
// Size: 0x1f2
function field_update_alert_level(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    delete_alert_lights(localclientnum);
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    if (!isdefined(self.alert_light_fx_handles)) {
        self.alert_light_fx_handles = [];
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    switch (newval) {
    case 0:
        break;
    case 1:
        if (isdefined(settings.unawarelightfx1)) {
            self.alert_light_fx_handles[0] = util::playfxontag(localclientnum, settings.unawarelightfx1, self, settings.lighttag1);
        }
        break;
    case 2:
        if (isdefined(settings.alertlightfx1)) {
            self.alert_light_fx_handles[0] = util::playfxontag(localclientnum, settings.alertlightfx1, self, settings.lighttag1);
        }
        break;
    case 3:
        if (isdefined(settings.combatlightfx1)) {
            self.alert_light_fx_handles[0] = util::playfxontag(localclientnum, settings.combatlightfx1, self, settings.lighttag1);
        }
        break;
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xac84479, Offset: 0x5e58
// Size: 0xc4
function field_toggle_exhaustfx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(bnewent) && bnewent) {
            self.csf_no_exhaust = 1;
        } else {
            self stop_exhaust(localclientnum);
        }
        return;
    }
    if (isdefined(self.csf_no_exhaust)) {
        self.csf_no_exhaust = 0;
    }
    self stop_exhaust(localclientnum);
    self play_exhaust(localclientnum);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x54ebbdb4, Offset: 0x5f28
// Size: 0x1ac
function control_lights_groups(localclientnum, on) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings) || !isdefined(settings.lightgroups_numgroups)) {
        return;
    }
    if (settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on !== 1 && !(isdefined(level.var_e84713ea) && level.var_e84713ea)) {
        lights_group_toggle(localclientnum, 0, on);
    }
    if (settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on !== 1) {
        lights_group_toggle(localclientnum, 1, on);
    }
    if (settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on !== 1) {
        lights_group_toggle(localclientnum, 2, on);
    }
    if (settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on !== 1) {
        lights_group_toggle(localclientnum, 3, on);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x24e00f9b, Offset: 0x60e0
// Size: 0x10c
function field_toggle_lights_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self lights_off(localclientnum);
    } else if (newval == 2) {
        self lights_on(localclientnum, #"allies");
    } else if (newval == 3) {
        self lights_on(localclientnum, #"axis");
    } else {
        self lights_on(localclientnum);
    }
    control_lights_groups(localclientnum, newval != 1);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x7196ea32, Offset: 0x61f8
// Size: 0x3c
function field_toggle_lockon_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x28cd531a, Offset: 0x6240
// Size: 0xae
function function_70c032e2(var_58cb9a3e, &fxlist, &taglist) {
    if (isdefined(var_58cb9a3e) && isarray(var_58cb9a3e)) {
        for (i = 0; i < var_58cb9a3e.size; i++) {
            addfxandtagtolists(var_58cb9a3e[i].fx, var_58cb9a3e[i].tag, fxlist, taglist, i, var_58cb9a3e.size - 1);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0x597846b9, Offset: 0x62f8
// Size: 0x128
function addfxandtagtolists(fx, tag, &fxlist, &taglist, id, maxid) {
    if (isdefined(fx) && isdefined(tag) && isint(id) && isint(maxid) && id <= maxid) {
        if (!isdefined(fxlist)) {
            fxlist = [];
        } else if (!isarray(fxlist)) {
            fxlist = array(fxlist);
        }
        fxlist[fxlist.size] = fx;
        if (!isdefined(taglist)) {
            taglist = [];
        } else if (!isarray(taglist)) {
            taglist = array(taglist);
        }
        taglist[taglist.size] = tag;
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x76bdb324, Offset: 0x6428
// Size: 0xb4
function function_777009e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval) {
        self notify(#"light_disable");
        self stop_stun_fx(localclientnum);
        self start_stun_fx(localclientnum);
        return;
    }
    self stop_stun_fx(localclientnum);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x3d396685, Offset: 0x64e8
// Size: 0xe4
function start_stun_fx(localclientnum) {
    stunfx = isdefined(self.var_ef080602) ? self.var_ef080602 : #"killstreaks/fx_agr_emp_stun";
    var_a377d4c3 = isdefined(self.stunfxtag) ? self.stunfxtag : "tag_origin";
    var_de07e296 = isdefined(self.var_3cd8784c) ? self.var_3cd8784c : #"veh_talon_shutdown";
    self.stun_fx = util::playfxontag(localclientnum, stunfx, self, var_a377d4c3);
    playsound(localclientnum, var_de07e296, self.origin);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x51e9a031, Offset: 0x65d8
// Size: 0x3e
function stop_stun_fx(localclientnum) {
    if (isdefined(self.stun_fx)) {
        stopfx(localclientnum, self.stun_fx);
        self.stun_fx = undefined;
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x9edbf472, Offset: 0x6620
// Size: 0x304
function field_update_damage_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (isdefined(self.damage_state_fx_handles)) {
        foreach (fx_handle in self.damage_state_fx_handles) {
            stopfx(localclientnum, fx_handle);
        }
    }
    self.damage_state_fx_handles = [];
    fxlist = [];
    taglist = [];
    sound = undefined;
    if (newval > 0) {
        var_df0fb360 = "damagestate_lv" + newval;
        numslots = settings.(var_df0fb360 + "_numslots");
        for (fxindex = 1; isdefined(numslots) && fxindex <= numslots; fxindex++) {
            addfxandtagtolists(settings.(var_df0fb360 + "_fx" + fxindex), settings.(var_df0fb360 + "_tag" + fxindex), fxlist, taglist, fxindex, numslots);
        }
        sound = settings.(var_df0fb360 + "_sound");
    }
    for (i = 0; i < fxlist.size; i++) {
        fx_handle = util::playfxontag(localclientnum, fxlist[i], self, taglist[i]);
        if (!isdefined(self.damage_state_fx_handles)) {
            self.damage_state_fx_handles = [];
        } else if (!isarray(self.damage_state_fx_handles)) {
            self.damage_state_fx_handles = array(self.damage_state_fx_handles);
        }
        self.damage_state_fx_handles[self.damage_state_fx_handles.size] = fx_handle;
    }
    if (isdefined(self) && isdefined(sound)) {
        self playsound(localclientnum, sound);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x8b01e15, Offset: 0x6930
// Size: 0x646
function field_death_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (localclientnum == 0) {
        velocity = self getvelocity();
        numdynents = isdefined(settings.death_dynent_count) ? settings.death_dynent_count : 0;
        for (i = 0; i < numdynents; i++) {
            model = settings.("death_dynmodel" + i);
            if (!isdefined(model)) {
                continue;
            }
            gibpart = settings.("death_dynent_gib" + i);
            if (self.gibbed === 1 && gibpart === 1) {
                continue;
            }
            pitch = isdefined(settings.("death_dynent_force_pitch" + i)) ? settings.("death_dynent_force_pitch" + i) : 0;
            yaw = isdefined(settings.("death_dynent_force_yaw" + i)) ? settings.("death_dynent_force_yaw" + i) : 0;
            angles = (randomfloatrange(pitch - 15, pitch + 15), randomfloatrange(yaw - 20, yaw + 20), randomfloatrange(-20, 20));
            direction = anglestoforward(self.angles + angles);
            minscale = isdefined(settings.("death_dynent_force_minscale" + i)) ? settings.("death_dynent_force_minscale" + i) : 0;
            maxscale = isdefined(settings.("death_dynent_force_maxscale" + i)) ? settings.("death_dynent_force_maxscale" + i) : 0;
            force = direction * randomfloatrange(minscale, maxscale);
            offset = (isdefined(settings.("death_dynent_offsetX" + i)) ? settings.("death_dynent_offsetX" + i) : 0, isdefined(settings.("death_dynent_offsetY" + i)) ? settings.("death_dynent_offsetY" + i) : 0, isdefined(settings.("death_dynent_offsetZ" + i)) ? settings.("death_dynent_offsetZ" + i) : 0);
            switch (newval) {
            case 0:
                break;
            case 1:
                fx = settings.("death_dynent_fx" + i);
                break;
            case 2:
                fx = settings.("death_dynent_elec_fx" + i);
                break;
            case 3:
                fx = settings.("death_dynent_fire_fx" + i);
                break;
            }
            offset = rotatepoint(offset, self.angles);
            if (newval > 1 && isdefined(fx)) {
                dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8, fx);
            } else if (newval == 1 && isdefined(fx)) {
                dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8, fx);
            } else {
                dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8);
            }
            if (isdefined(dynent)) {
                hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
                launchdynent(dynent, force, hitoffset);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xf85d37df, Offset: 0x6f80
// Size: 0x54e
function field_gib_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (localclientnum == 0) {
        velocity = self getvelocity();
        numdynents = 2;
        for (i = 0; i < numdynents; i++) {
            model = settings.("servo_gib_model" + i);
            if (!isdefined(model)) {
                return;
            }
            self.gibbed = 1;
            origin = self.origin;
            angles = self.angles;
            hidetag = settings.("servo_gib_tag" + i);
            if (isdefined(hidetag)) {
                origin = self gettagorigin(hidetag);
                angles = self gettagangles(hidetag);
            }
            pitch = isdefined(settings.("servo_gib_force_pitch" + i)) ? settings.("servo_gib_force_pitch" + i) : 0;
            yaw = isdefined(settings.("servo_gib_force_yaw" + i)) ? settings.("servo_gib_force_yaw" + i) : 0;
            relative_angles = (randomfloatrange(pitch - 5, pitch + 5), randomfloatrange(yaw - 5, yaw + 5), randomfloatrange(-5, 5));
            direction = anglestoforward(angles + relative_angles);
            minscale = isdefined(settings.("servo_gib_force_minscale" + i)) ? settings.("servo_gib_force_minscale" + i) : 0;
            maxscale = isdefined(settings.("servo_gib_force_maxscale" + i)) ? settings.("servo_gib_force_maxscale" + i) : 0;
            force = direction * randomfloatrange(minscale, maxscale);
            offset = (isdefined(settings.("servo_gib_offsetX" + i)) ? settings.("servo_gib_offsetX" + i) : 0, isdefined(settings.("servo_gib_offsetY" + i)) ? settings.("servo_gib_offsetY" + i) : 0, isdefined(settings.("servo_gib_offsetZ" + i)) ? settings.("servo_gib_offsetZ" + i) : 0);
            fx = settings.("servo_gib_fx" + i);
            offset = rotatepoint(offset, angles);
            if (isdefined(fx)) {
                dynent = createdynentandlaunch(localclientnum, model, origin + offset, angles, (0, 0, 0), velocity * 0.8, fx);
            } else {
                dynent = createdynentandlaunch(localclientnum, model, origin + offset, angles, (0, 0, 0), velocity * 0.8);
            }
            if (isdefined(dynent)) {
                hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
                launchdynent(dynent, force, hitoffset);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x2
// Checksum 0xac76fd, Offset: 0x74d8
// Size: 0xaa
function autoexec build_damage_filter_list() {
    if (!isdefined(level.vehicle_damage_filters)) {
        level.vehicle_damage_filters = [];
    }
    level.vehicle_damage_filters[0] = "generic_filter_vehicle_damage";
    level.vehicle_damage_filters[1] = "generic_filter_sam_damage";
    level.vehicle_damage_filters[2] = "generic_filter_f35_damage";
    level.vehicle_damage_filters[3] = "generic_filter_vehicle_damage_sonar";
    level.vehicle_damage_filters[4] = "generic_filter_rts_vehicle_damage";
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x1d1ca7c6, Offset: 0x7590
// Size: 0xdc
function init_damage_filter(materialid) {
    level.localplayers[0].damage_filter_intensity = 0;
    materialname = level.vehicle_damage_filters[materialid];
    filter::init_filter_vehicle_damage(level.localplayers[0], materialname);
    filter::enable_filter_vehicle_damage(level.localplayers[0], 3, materialname);
    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, 0);
    filter::set_filter_vehicle_sun_position(level.localplayers[0], 3, 0, 0);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xf4826358, Offset: 0x7678
// Size: 0x94
function damage_filter_enable(localclientnum, materialid) {
    filter::enable_filter_vehicle_damage(level.localplayers[0], 3, level.vehicle_damage_filters[materialid]);
    level.localplayers[0].damage_filter_intensity = 0;
    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xee098c92, Offset: 0x7718
// Size: 0x9c
function damage_filter_disable(localclientnum) {
    level notify(#"damage_filter_off");
    level.localplayers[0].damage_filter_intensity = 0;
    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    filter::disable_filter_vehicle_damage(level.localplayers[0], 3);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xc1f87476, Offset: 0x77c0
// Size: 0x130
function damage_filter_off(localclientnum) {
    level endon(#"damage_filter");
    level endon(#"damage_filter_off");
    level endon(#"damage_filter_heavy");
    if (!isdefined(level.localplayers[0].damage_filter_intensity)) {
        return;
    }
    while (level.localplayers[0].damage_filter_intensity > 0) {
        level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity - 0.0505061;
        if (level.localplayers[0].damage_filter_intensity < 0) {
            level.localplayers[0].damage_filter_intensity = 0;
        }
        filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
        wait 0.016667;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xa0f9f6b0, Offset: 0x78f8
// Size: 0x128
function damage_filter_light(localclientnum) {
    level endon(#"damage_filter_off");
    level endon(#"damage_filter_heavy");
    level notify(#"damage_filter");
    while (level.localplayers[0].damage_filter_intensity < 0.5) {
        level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity + 0.083335;
        if (level.localplayers[0].damage_filter_intensity > 0.5) {
            level.localplayers[0].damage_filter_intensity = 0.5;
        }
        filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
        wait 0.016667;
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x57edb8c2, Offset: 0x7a28
// Size: 0x100
function damage_filter_heavy(localclientnum) {
    level endon(#"damage_filter_off");
    level notify(#"damage_filter_heavy");
    while (level.localplayers[0].damage_filter_intensity < 1) {
        level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity + 0.083335;
        if (level.localplayers[0].damage_filter_intensity > 1) {
            level.localplayers[0].damage_filter_intensity = 1;
        }
        filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
        wait 0.016667;
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x2562ae02, Offset: 0x7b30
// Size: 0x64
function function_e091202b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self function_bf2fb2fe(newval);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x7a20c466, Offset: 0x7ba0
// Size: 0xa4
function play_flare_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_73b38e89 = util::playfxontag(localclientnum, #"hash_3905863dd0908e4a", self, "tag_origin");
    }
    if (newval == 0) {
        stopfx(localclientnum, self.var_73b38e89);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xfe17588, Offset: 0x7c50
// Size: 0xa4
function play_flare_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_3641c127 = util::playfxontag(localclientnum, #"hash_1e747bdc27127b91", self, "tag_origin");
    }
    if (newval == 0) {
        stopfx(localclientnum, self.var_3641c127);
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x8cbf1bab, Offset: 0x7d00
// Size: 0x5c
function set_static_amount(staticamount) {
    driverlocalclient = self getlocalclientdriver();
    if (isdefined(driverlocalclient)) {
        setfilterpassconstant(driverlocalclient, 4, 0, 1, staticamount);
    }
}

