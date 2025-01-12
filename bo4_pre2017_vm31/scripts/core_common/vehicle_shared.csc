#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicleriders_shared;

#namespace vehicle;

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x2
// Checksum 0xf16e7fd5, Offset: 0x700
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("vehicle_shared", &__init__, undefined, undefined);
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0xa9c5237e, Offset: 0x740
// Size: 0xd9c
function __init__() {
    level._customvehiclecbfunc = &spawned_callback;
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
    clientfield::register("vehicle", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0);
    clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0);
    clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0);
    clientfield::register("vehicle", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0);
    clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0);
    clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0);
    clientfield::register("helicopter", "toggle_lockon", 1, 1, "int", &field_toggle_lockon_handler, 0, 0);
    clientfield::register("helicopter", "toggle_sounds", 1, 1, "int", &field_toggle_sounds, 0, 0);
    clientfield::register("helicopter", "use_engine_damage_sounds", 1, 2, "int", &field_use_engine_damage_sounds, 0, 0);
    clientfield::register("helicopter", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0);
    clientfield::register("helicopter", "toggle_exhaustfx", 1, 1, "int", &field_toggle_exhaustfx_handler, 0, 0);
    clientfield::register("helicopter", "toggle_lights", 1, 2, "int", &field_toggle_lights_handler, 0, 0);
    clientfield::register("helicopter", "toggle_lights_group1", 1, 1, "int", &field_toggle_lights_group_handler1, 0, 0);
    clientfield::register("helicopter", "toggle_lights_group2", 1, 1, "int", &field_toggle_lights_group_handler2, 0, 0);
    clientfield::register("helicopter", "toggle_lights_group3", 1, 1, "int", &field_toggle_lights_group_handler3, 0, 0);
    clientfield::register("helicopter", "toggle_lights_group4", 1, 1, "int", &field_toggle_lights_group_handler4, 0, 0);
    clientfield::register("helicopter", "toggle_ambient_anim_group1", 1, 1, "int", &field_toggle_ambient_anim_handler1, 0, 0);
    clientfield::register("helicopter", "toggle_ambient_anim_group2", 1, 1, "int", &field_toggle_ambient_anim_handler2, 0, 0);
    clientfield::register("helicopter", "toggle_ambient_anim_group3", 1, 1, "int", &field_toggle_ambient_anim_handler3, 0, 0);
    clientfield::register("helicopter", "toggle_emp_fx", 1, 1, "int", &field_toggle_emp, 0, 0);
    clientfield::register("helicopter", "toggle_burn_fx", 1, 1, "int", &field_toggle_burn, 0, 0);
    clientfield::register("helicopter", "deathfx", 1, 1, "int", &field_do_deathfx, 0, 0);
    clientfield::register("helicopter", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0);
    clientfield::register("helicopter", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0);
    clientfield::register("helicopter", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0);
    clientfield::register("helicopter", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0);
    clientfield::register("helicopter", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0);
    clientfield::register("helicopter", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0);
    clientfield::register("plane", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0);
    clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int", &field_toggle_dnidamagefx, 0, 0);
    clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int", &toggle_flir_postfxbundle, 0, 0);
    clientfield::register("toplayer", "static_postfx", 1, 1, "int", &set_static_postfxbundle, 0, 0);
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xab2d86e1, Offset: 0x14e8
// Size: 0x4a
function add_vehicletype_callback(vehicletype, callback) {
    if (!isdefined(level.vehicletypecallbackarray)) {
        level.vehicletypecallbackarray = [];
    }
    level.vehicletypecallbackarray[vehicletype] = callback;
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x60bc3f65, Offset: 0x1540
// Size: 0x11c
function spawned_callback(localclientnum) {
    if (isdefined(self.vehicleridersbundle)) {
        set_vehicleriders_bundle(self.vehicleridersbundle);
    }
    vehicletype = self.vehicletype;
    if (isdefined(level.vehicletypecallbackarray)) {
        if (isdefined(vehicletype) && isdefined(level.vehicletypecallbackarray[vehicletype])) {
            self thread [[ level.vehicletypecallbackarray[vehicletype] ]](localclientnum);
        } else if (isdefined(self.scriptvehicletype) && isdefined(level.vehicletypecallbackarray[self.scriptvehicletype])) {
            self thread [[ level.vehicletypecallbackarray[self.scriptvehicletype] ]](localclientnum);
        }
    }
    if (self usessubtargets()) {
        self thread watch_vehicle_damage();
    }
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x73034578, Offset: 0x1668
// Size: 0xc0
function watch_vehicle_damage() {
    self endon(#"death");
    self.notifyonbulletimpact = 1;
    while (isdefined(self)) {
        waitresult = self waittill("damage");
        subtarget = waitresult.subtarget;
        attacker = waitresult.attacker;
        if (attacker islocalplayer() && isdefined(subtarget) && subtarget > 0) {
            self thread function_d0ef3a09(subtarget);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xeea09cde, Offset: 0x1730
// Size: 0x144
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
            self playrenderoverridebundle("rob_vehicle_target", bone);
            wait 0.1;
            self stoprenderoverridebundle(bone);
        }
        return;
    }
    self playrenderoverridebundle("rob_vehicle_target");
    wait 0.15;
    self stoprenderoverridebundle();
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xf0d071b0, Offset: 0x1880
// Size: 0x2ee
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
            self earthquake(self.rumblescale, self.rumbleduration, self.origin, self.rumbleradius);
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
// Checksum 0xdecbbf9, Offset: 0x1b78
// Size: 0x12
function kill_treads_forever() {
    self notify(#"kill_treads_forever");
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x819142ad, Offset: 0x1b98
// Size: 0x1fc
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
            assert(isdefined(self.exhaustfxtag1), self.vehicletype + "<dev string:x28>");
            self endon(#"death");
            self wait_for_dobj(localclientnum);
            self.exhaust_id_left = playfxontag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag1);
            if (!isdefined(self.exhaust_id_right) && isdefined(self.exhaustfxtag2)) {
                self.exhaust_id_right = playfxontag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag2);
            }
            self thread function_49a7bb3b(localclientnum);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x377ed38a, Offset: 0x1da0
// Size: 0x96
function function_49a7bb3b(localclientnum) {
    self endon(#"death");
    self waittill("stop_exhaust_fx");
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
// Checksum 0x6faa9c4a, Offset: 0x1e40
// Size: 0x1a
function stop_exhaust(localclientnum) {
    self notify(#"stop_exhaust_fx");
}

// Namespace vehicle/vehicle_shared
// Params 0, eflags: 0x0
// Checksum 0x363c693, Offset: 0x1e68
// Size: 0x2fc
function aircraft_dustkick() {
    self endon(#"death");
    waittillframeend();
    self endon(#"kill_treads_forever");
    if (!isdefined(self)) {
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
        trace = bullettrace(self.origin, self.origin - (0, 0, 700 * 2), 0, self);
        distsqr = distancesquared(self.origin, trace["position"]);
        if (trace["fraction"] < 0.01 || distsqr < 180 * 180) {
            wait 0.2;
            continue;
        } else if (trace["fraction"] >= 1 || distsqr > 700 * 700) {
            wait 1;
            continue;
        }
        if (180 * 180 < distsqr && distsqr < 700 * 700) {
            surfacetype = trace["surfacetype"];
            if (!isdefined(surfacetype)) {
                surfacetype = "dirt";
            }
            if (isdefined(fxarray[surfacetype])) {
                forward = anglestoforward(self.angles);
                playfx(0, fxarray[surfacetype], trace["position"], (0, 0, 1), forward);
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
// Params 1, eflags: 0x0
// Checksum 0x8b735e58, Offset: 0x2170
// Size: 0x78
function wait_for_dobj(localclientnum) {
    for (count = 30; !self hasdobj(localclientnum); count -= 1) {
        if (count < 0) {
            /#
                iprintlnbold("<dev string:x84>");
            #/
            return;
        }
        waitframe(1);
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0xdd600df4, Offset: 0x21f0
// Size: 0x14e
function lights_on(localclientnum, team) {
    self endon(#"death");
    lights_off(localclientnum);
    wait_for_dobj(localclientnum);
    if (isdefined(self.lightfxnamearray)) {
        if (!isdefined(self.light_fx_handles)) {
            self.light_fx_handles = [];
        }
        for (i = 0; i < self.lightfxnamearray.size; i++) {
            self.light_fx_handles[i] = playfxontag(localclientnum, self.lightfxnamearray[i], self, self.lightfxtagarray[i]);
            setfxignorepause(localclientnum, self.light_fx_handles[i], 1);
            if (isdefined(team)) {
                setfxteam(localclientnum, self.light_fx_handles[i], team);
            }
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0x697acb13, Offset: 0x2348
// Size: 0x112
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
// Checksum 0x1694cda0, Offset: 0x2468
// Size: 0x5f6
function ambient_anim_toggle(localclientnum, groupid, ison) {
    self endon(#"death");
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings)) {
        return;
    }
    wait_for_dobj(localclientnum);
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
// Checksum 0x31eef068, Offset: 0x2a68
// Size: 0x5c
function field_toggle_ambient_anim_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self ambient_anim_toggle(localclientnum, 1, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x402a1fed, Offset: 0x2ad0
// Size: 0x5c
function field_toggle_ambient_anim_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self ambient_anim_toggle(localclientnum, 2, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x2adbe0f2, Offset: 0x2b38
// Size: 0x5c
function field_toggle_ambient_anim_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self ambient_anim_toggle(localclientnum, 3, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x77085c97, Offset: 0x2ba0
// Size: 0x5c
function field_toggle_ambient_anim_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self ambient_anim_toggle(localclientnum, 4, newval);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x1b5966c8, Offset: 0x2c08
// Size: 0x7e2
function lights_group_toggle(localclientnum, id, ison) {
    self endon(#"death");
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings) || !isdefined(settings.lightgroups_numgroups)) {
        return;
    }
    wait_for_dobj(localclientnum);
    groupid = id - 1;
    if (isdefined(self.lightfxgroups) && groupid < self.lightfxgroups.size) {
        foreach (fx_handle in self.lightfxgroups[groupid]) {
            stopfx(localclientnum, fx_handle);
        }
    }
    if (!ison) {
        return;
    }
    if (!isdefined(self.lightfxgroups)) {
        self.lightfxgroups = [];
        for (i = 0; i < settings.lightgroups_numgroups; i++) {
            var_c1f0ad6c = [];
            if (!isdefined(self.lightfxgroups)) {
                self.lightfxgroups = [];
            } else if (!isarray(self.lightfxgroups)) {
                self.lightfxgroups = array(self.lightfxgroups);
            }
            self.lightfxgroups[self.lightfxgroups.size] = var_c1f0ad6c;
        }
    }
    self.lightfxgroups[groupid] = [];
    fxlist = [];
    taglist = [];
    switch (groupid) {
    case 0:
        addfxandtagtolists(settings.var_e03a3d35, settings.var_7e835403, fxlist, taglist, 1, settings.var_fe34abc5);
        addfxandtagtolists(settings.var_63cb79e, settings.var_c7be4c8, fxlist, taglist, 2, settings.var_fe34abc5);
        addfxandtagtolists(settings.var_2c3f3207, settings.var_327e5f31, fxlist, taglist, 3, settings.var_fe34abc5);
        addfxandtagtolists(settings.var_222dd928, settings.var_f08ac33e, fxlist, taglist, 4, settings.var_fe34abc5);
        break;
    case 1:
        addfxandtagtolists(settings.var_f6ffea3a, settings.var_9dbc8cda, fxlist, taglist, 1, settings.var_96c37b4);
        addfxandtagtolists(settings.var_d0fd6fd1, settings.var_77ba1271, fxlist, taglist, 2, settings.var_96c37b4);
        addfxandtagtolists(settings.var_aafaf568, settings.var_51b79808, fxlist, taglist, 3, settings.var_96c37b4);
        addfxandtagtolists(settings.var_b50c4e47, settings.var_5bc8f0e7, fxlist, taglist, 4, settings.var_96c37b4);
        break;
    case 2:
        addfxandtagtolists(settings.var_f4564ad3, settings.var_378fa355, fxlist, taglist, 1, settings.var_92bf77a3);
        addfxandtagtolists(settings.var_824edb98, settings.var_5d921dbe, fxlist, taglist, 2, settings.var_92bf77a3);
        addfxandtagtolists(settings.var_a8515601, settings.var_83949827, fxlist, taglist, 3, settings.var_92bf77a3);
        addfxandtagtolists(settings.var_665dba0e, settings.var_79833f48, fxlist, taglist, 4, settings.var_92bf77a3);
        break;
    case 3:
        addfxandtagtolists(settings.var_386cfc80, settings.var_e710b4fc, fxlist, taglist, 1, settings.var_a1783f62);
        addfxandtagtolists(settings.var_aa746bbb, settings.var_59182437, fxlist, taglist, 2, settings.var_a1783f62);
        addfxandtagtolists(settings.var_8471f152, settings.var_3315a9ce, fxlist, taglist, 3, settings.var_a1783f62);
        addfxandtagtolists(settings.var_f679608d, settings.var_750945c1, fxlist, taglist, 4, settings.var_a1783f62);
        break;
    }
    for (i = 0; i < fxlist.size; i++) {
        fx_handle = playfxontag(localclientnum, fxlist[i], self, taglist[i]);
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
// Checksum 0xd27b10, Offset: 0x33f8
// Size: 0x5c
function field_toggle_lights_group_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lights_group_toggle(localclientnum, 1, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xadf1255f, Offset: 0x3460
// Size: 0x5c
function field_toggle_lights_group_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lights_group_toggle(localclientnum, 2, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x619f2fa1, Offset: 0x34c8
// Size: 0x5c
function field_toggle_lights_group_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lights_group_toggle(localclientnum, 3, newval);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xd78fe5f, Offset: 0x3530
// Size: 0x5c
function field_toggle_lights_group_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lights_group_toggle(localclientnum, 4, newval);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0x6f9a8d3e, Offset: 0x3598
// Size: 0x7e
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
// Checksum 0x4c283986, Offset: 0x3620
// Size: 0x94
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
// Params 7, eflags: 0x0
// Checksum 0xb915f03d, Offset: 0x36c0
// Size: 0x64
function field_toggle_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread toggle_fx_bundle(localclientnum, "emp_base", newval == 1);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xb27b92f0, Offset: 0x3730
// Size: 0x64
function field_toggle_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread toggle_fx_bundle(localclientnum, "burn_base", newval == 1);
}

// Namespace vehicle/vehicle_shared
// Params 3, eflags: 0x0
// Checksum 0x28895cde, Offset: 0x37a0
// Size: 0x2c6
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
    wait_for_dobj(localclientnum);
    if (!isdefined(self.fx_handles)) {
        self.fx_handles = [];
    }
    if (isdefined(self.fx_handles[name])) {
        handle = self.fx_handles[name];
        if (isarray(handle)) {
            foreach (handleelement in handle) {
                stopfx(localclientnum, handleelement);
            }
        } else {
            stopfx(localclientnum, handle);
        }
    }
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
// Checksum 0x5f3bb7a7, Offset: 0x3a70
// Size: 0x150
function delayed_fx_thread(localclientnum, name, fx, tag, delay) {
    self endon(#"death");
    self endon("end_toggle_field_fx_" + name);
    if (!isdefined(tag)) {
        return;
    }
    if (isdefined(delay) && delay > 0) {
        wait delay;
    }
    fx_handle = playfxontag(localclientnum, fx, self, tag);
    if (!isdefined(self.fx_handles[name])) {
        self.fx_handles[name] = [];
    } else if (!isarray(self.fx_handles[name])) {
        self.fx_handles[name] = array(self.fx_handles[name]);
    }
    self.fx_handles[name][self.fx_handles[name].size] = fx_handle;
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x392b4e85, Offset: 0x3bc8
// Size: 0xcc
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
        return;
    }
    self enablevehiclesounds();
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x26c57dee, Offset: 0x3ca0
// Size: 0x64
function field_toggle_dnidamagefx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_dni_vehicle_dmg");
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x512fae71, Offset: 0x3d10
// Size: 0x19c
function toggle_flir_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = self;
    if (newval == oldval) {
        return;
    }
    if (!isdefined(player) || !player islocalplayer()) {
        return;
    }
    if (newval == 0) {
        player thread postfx::function_9493d991();
        update_ui_fullscreen_filter_model(localclientnum, 0);
        return;
    }
    if (newval == 1) {
        if (player shouldchangescreenpostfx(localclientnum)) {
            player thread postfx::playpostfxbundle("pstfx_infrared");
            update_ui_fullscreen_filter_model(localclientnum, 2);
        }
        return;
    }
    if (newval == 2) {
        should_change = 1;
        if (player shouldchangescreenpostfx(localclientnum)) {
            player thread postfx::playpostfxbundle("pstfx_flir");
            update_ui_fullscreen_filter_model(localclientnum, 1);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xdf5ecbef, Offset: 0x3eb8
// Size: 0xa0
function shouldchangescreenpostfx(localclientnum) {
    player = self;
    assert(isdefined(player));
    if (player getinkillcam(localclientnum)) {
        killcamentity = player getkillcamentity(localclientnum);
        if (isdefined(killcamentity) && killcamentity != player) {
            return false;
        }
    }
    return true;
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x4b00de42, Offset: 0x3f60
// Size: 0xd4
function set_static_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = self;
    if (newval == oldval) {
        return;
    }
    if (!isdefined(player) || !player islocalplayer()) {
        return;
    }
    if (newval == 0) {
        player thread postfx::function_9493d991();
        return;
    }
    if (newval == 1) {
        player thread postfx::playpostfxbundle("pstfx_static");
    }
}

// Namespace vehicle/vehicle_shared
// Params 2, eflags: 0x0
// Checksum 0x4e8c7196, Offset: 0x4040
// Size: 0x84
function update_ui_fullscreen_filter_model(localclientnum, vision_set_value) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = getuimodel(controllermodel, "vehicle.fullscreenFilter");
    if (isdefined(model)) {
        setuimodelvalue(model, vision_set_value);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xc1d72068, Offset: 0x40d0
// Size: 0x234
function field_toggle_treadfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self.vehicleclass === "helicopter" || self.vehicleclass === "plane") {
        println("<dev string:xc7>");
        if (newval) {
            if (isdefined(bnewent) && bnewent) {
                self.csf_no_tread = 1;
            } else {
                self kill_treads_forever();
            }
        } else {
            if (isdefined(self.csf_no_tread)) {
                self.csf_no_tread = 0;
            }
            self kill_treads_forever();
            self thread aircraft_dustkick();
        }
        return;
    }
    if (newval) {
        println("<dev string:xe7>");
        if (isdefined(bnewent) && bnewent) {
            println("<dev string:x10e>" + self getentitynumber());
            self.csf_no_tread = 1;
        } else {
            println("<dev string:x12c>" + self getentitynumber());
            self kill_treads_forever();
        }
        return;
    }
    println("<dev string:x148>");
    if (isdefined(self.csf_no_tread)) {
        self.csf_no_tread = 0;
    }
    self kill_treads_forever();
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x3cd1532c, Offset: 0x4310
// Size: 0xda
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
// Params 7, eflags: 0x0
// Checksum 0xcbe33fa6, Offset: 0x43f8
// Size: 0xbc
function field_do_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval == 2) {
        self field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x3cd28f56, Offset: 0x44c0
// Size: 0x194
function field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !binitialsnap) {
        wait_for_dobj(localclientnum);
        if (isdefined(self.deathfxname)) {
            if (isdefined(self.deathfxtag) && self.deathfxtag != "") {
                handle = playfxontag(localclientnum, self.deathfxname, self, self.deathfxtag);
            } else {
                handle = playfx(localclientnum, self.deathfxname, self.origin);
            }
            setfxignorepause(localclientnum, handle, 1);
        }
        self playsound(localclientnum, self.deathfxsound);
        if (isdefined(self.deathquakescale) && self.deathquakescale > 0) {
            self earthquake(self.deathquakescale, self.deathquakeduration, self.origin, self.deathquakeradius);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xe6ae7d8, Offset: 0x4660
// Size: 0x26c
function field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.settings) && isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    if (!isdefined(self.settings)) {
        self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    if (newval && !binitialsnap) {
        wait_for_dobj(localclientnum);
        s = self.settings;
        if (isdefined(s.emp_death_fx_1)) {
            if (isdefined(s.emp_death_tag_1) && s.emp_death_tag_1 != "") {
                handle = playfxontag(localclientnum, s.emp_death_fx_1, self, s.emp_death_tag_1);
            } else {
                handle = playfx(localclientnum, s.emp_death_tag_1, self.origin);
            }
            setfxignorepause(localclientnum, handle, 1);
        }
        self playsound(localclientnum, s.emp_death_sound_1);
        if (isdefined(self.deathquakescale) && self.deathquakescale > 0) {
            self earthquake(self.deathquakescale * 0.25, self.deathquakeduration * 2, self.origin, self.deathquakeradius);
        }
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x61047239, Offset: 0x48d8
// Size: 0x1ee
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
            self.alert_light_fx_handles[0] = playfxontag(localclientnum, settings.unawarelightfx1, self, settings.lighttag1);
        }
        break;
    case 2:
        if (isdefined(settings.alertlightfx1)) {
            self.alert_light_fx_handles[0] = playfxontag(localclientnum, settings.alertlightfx1, self, settings.lighttag1);
        }
        break;
    case 3:
        if (isdefined(settings.combatlightfx1)) {
            self.alert_light_fx_handles[0] = playfxontag(localclientnum, settings.combatlightfx1, self, settings.lighttag1);
        }
        break;
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0x2d84b8aa, Offset: 0x4ad0
// Size: 0xd4
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
// Checksum 0x77597638, Offset: 0x4bb0
// Size: 0x1bc
function control_lights_groups(localclientnum, on) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings) || !isdefined(settings.lightgroups_numgroups)) {
        return;
    }
    if (settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on !== 1) {
        lights_group_toggle(localclientnum, 1, on);
    }
    if (settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on !== 1) {
        lights_group_toggle(localclientnum, 2, on);
    }
    if (settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on !== 1) {
        lights_group_toggle(localclientnum, 3, on);
    }
    if (settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on !== 1) {
        lights_group_toggle(localclientnum, 4, on);
    }
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xaf2d5eb7, Offset: 0x4d78
// Size: 0x104
function field_toggle_lights_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self lights_off(localclientnum);
    } else if (newval == 2) {
        self lights_on(localclientnum, "allies");
    } else if (newval == 3) {
        self lights_on(localclientnum, "axis");
    } else {
        self lights_on(localclientnum);
    }
    control_lights_groups(localclientnum, newval != 1);
}

// Namespace vehicle/vehicle_shared
// Params 7, eflags: 0x0
// Checksum 0xf86e84d3, Offset: 0x4e88
// Size: 0x3c
function field_toggle_lockon_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace vehicle/vehicle_shared
// Params 6, eflags: 0x0
// Checksum 0xf54b2ecd, Offset: 0x4ed0
// Size: 0x10a
function addfxandtagtolists(fx, tag, &fxlist, &taglist, id, maxid) {
    if (isdefined(fx) && isdefined(tag) && id <= maxid) {
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
// Checksum 0x4a7ff203, Offset: 0x4fe8
// Size: 0x94c
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
    switch (newval) {
    case 0:
        break;
    case 1:
        addfxandtagtolists(settings.damagestate_lv1_fx1, settings.damagestate_lv1_tag1, fxlist, taglist, 1, settings.damagestate_lv1_numslots);
        addfxandtagtolists(settings.damagestate_lv1_fx2, settings.damagestate_lv1_tag2, fxlist, taglist, 2, settings.damagestate_lv1_numslots);
        addfxandtagtolists(settings.var_eba1a69f, settings.var_47ce35e9, fxlist, taglist, 3, settings.damagestate_lv1_numslots);
        addfxandtagtolists(settings.var_e1904dc0, settings.var_5da99f6, fxlist, taglist, 4, settings.damagestate_lv1_numslots);
        sound = settings.damagestate_lv1_sound;
        break;
    case 2:
        addfxandtagtolists(settings.damagestate_lv2_fx1, settings.damagestate_lv2_tag1, fxlist, taglist, 1, settings.damagestate_lv2_numslots);
        addfxandtagtolists(settings.damagestate_lv2_fx2, settings.damagestate_lv2_tag2, fxlist, taglist, 2, settings.damagestate_lv2_numslots);
        addfxandtagtolists(settings.var_ebf40040, settings.var_cf970fe0, fxlist, taglist, 3, settings.damagestate_lv2_numslots);
        addfxandtagtolists(settings.var_f605591f, settings.var_d9a868bf, fxlist, taglist, 4, settings.damagestate_lv2_numslots);
        sound = settings.damagestate_lv2_sound;
        break;
    case 3:
        addfxandtagtolists(settings.damagestate_lv3_fx1, settings.damagestate_lv3_tag1, fxlist, taglist, 1, settings.damagestate_lv3_numslots);
        addfxandtagtolists(settings.var_42ee84b0, settings.var_199c6b36, fxlist, taglist, 2, settings.damagestate_lv3_numslots);
        addfxandtagtolists(settings.var_68f0ff19, settings.var_3f9ee59f, fxlist, taglist, 3, settings.damagestate_lv3_numslots);
        addfxandtagtolists(settings.var_26fd6326, settings.var_358d8cc0, fxlist, taglist, 4, settings.damagestate_lv3_numslots);
        sound = settings.damagestate_lv3_sound;
        break;
    case 4:
        addfxandtagtolists(settings.var_b95bf2b8, settings.var_7df721f4, fxlist, taglist, 1, settings.var_3ac09dba);
        addfxandtagtolists(settings.var_2b6361f3, settings.var_effe912f, fxlist, taglist, 2, settings.var_3ac09dba);
        addfxandtagtolists(settings.var_560e78a, settings.var_c9fc16c6, fxlist, taglist, 3, settings.var_3ac09dba);
        addfxandtagtolists(settings.var_776856c5, settings.var_befb2b9, fxlist, taglist, 4, settings.var_3ac09dba);
        sound = settings.var_376b7f22;
        break;
    case 5:
        addfxandtagtolists(settings.var_e79f0ec1, settings.var_55d2a85f, fxlist, taglist, 1, settings.var_9797b361);
        addfxandtagtolists(settings.var_da1892a, settings.var_e3cb3924, fxlist, taglist, 2, settings.var_9797b361);
        addfxandtagtolists(settings.var_33a40393, settings.var_9cdb38d, fxlist, taglist, 3, settings.var_9797b361);
        addfxandtagtolists(settings.var_59a67dfc, settings.var_97c64452, fxlist, taglist, 4, settings.var_9797b361);
        sound = settings.var_34384caf;
        break;
    case 6:
        addfxandtagtolists(settings.var_999a6a6, settings.var_1f11a036, fxlist, taglist, 1, settings.var_ee464570);
        addfxandtagtolists(settings.var_e3972c3d, settings.var_f90f25cd, fxlist, taglist, 2, settings.var_ee464570);
        addfxandtagtolists(settings.var_bd94b1d4, settings.var_d30cab64, fxlist, taglist, 3, settings.var_ee464570);
        addfxandtagtolists(settings.var_9792376b, settings.var_ad0a30fb, fxlist, taglist, 4, settings.var_ee464570);
        sound = settings.var_e385e548;
        break;
    }
    for (i = 0; i < fxlist.size; i++) {
        fx_handle = playfxontag(localclientnum, fxlist[i], self, taglist[i]);
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
// Checksum 0x31e195de, Offset: 0x5940
// Size: 0x6a6
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
// Checksum 0x28e16425, Offset: 0x5ff0
// Size: 0x5c6
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
// Checksum 0x783f6d81, Offset: 0x65c0
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
// Checksum 0xb6eb015c, Offset: 0x6678
// Size: 0xe4
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
// Checksum 0x4f298f23, Offset: 0x6768
// Size: 0xa4
function damage_filter_enable(localclientnum, materialid) {
    filter::enable_filter_vehicle_damage(level.localplayers[0], 3, level.vehicle_damage_filters[materialid]);
    level.localplayers[0].damage_filter_intensity = 0;
    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xa6edada6, Offset: 0x6818
// Size: 0x9c
function damage_filter_disable(localclientnum) {
    level notify(#"damage_filter_off");
    level.localplayers[0].damage_filter_intensity = 0;
    filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    filter::disable_filter_vehicle_damage(level.localplayers[0], 3);
}

// Namespace vehicle/vehicle_shared
// Params 1, eflags: 0x0
// Checksum 0xd51ce551, Offset: 0x68c0
// Size: 0x140
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
// Checksum 0x9e026fd5, Offset: 0x6a08
// Size: 0x130
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
// Checksum 0x91218e17, Offset: 0x6b40
// Size: 0x118
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

