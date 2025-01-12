#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\deployable;

#namespace smart_cover;

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x9b3a0783, Offset: 0x200
// Size: 0x264
function init_shared() {
    callback::on_localplayer_spawned(&on_local_player_spawned);
    clientfield::register("scriptmover", "smartcover_placed", 1, 5, "float", &smartcover_placed, 0, 0);
    clientfield::register("clientuimodel", "hudItems.smartCoverState", 1, 1, "int", undefined, 0, 0);
    clientfield::register("scriptmover", "start_smartcover_microwave", 1, 1, "int", &smartcover_start_microwave, 0, 0);
    level.smartcoversettings = spawnstruct();
    level.smartcoversettings.previewmodels = [];
    level.smartcoversettings.var_856ee88b = [];
    level.smartcoversettings.weapon = getweapon(#"ability_smart_cover");
    deployable::register_deployable(level.smartcoversettings.weapon, 1);
    if (sessionmodeismultiplayergame()) {
        level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_mp");
    } else if (sessionmodeiswarzonegame()) {
        level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_wz");
    } else if (sessionmodeiscampaigngame()) {
        level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_cp");
    }
    setupdvars();
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x5ceb100c, Offset: 0x470
// Size: 0x28c
function setupdvars() {
    setdvar(#"hash_25f7092e7c7b66f2", 0);
    setdvar(#"hash_4332205cbf1cc384", 0);
    setdvar(#"smartcover_drawtime", 1000);
    setdvar(#"hash_436fc2fad44e9041", 1);
    setdvar(#"hash_1d8eb304f5cf8033", 1);
    setdvar(#"smartcover_tracedistance", level.smartcoversettings.bundle.var_caed4c6d);
    setdvar(#"hash_13c23fd3a4387b84", 8);
    setdvar(#"hash_55a8dba3350b8b7c", 4);
    setdvar(#"hash_4f4ce3cb18b004bc", 10);
    setdvar(#"hash_417afa70d515fba5", isdefined(level.smartcoversettings.bundle.var_8dd8c6b1) ? level.smartcoversettings.bundle.var_8dd8c6b1 : 0);
    setdvar(#"hash_71f8bd4cd30de4b3", isdefined(level.smartcoversettings.bundle.var_6a71dfe) ? level.smartcoversettings.bundle.var_6a71dfe : 0);
    setdvar(#"hash_39a564d4801c4b2e", isdefined(level.smartcoversettings.bundle.var_caed4c6d) ? level.smartcoversettings.bundle.var_caed4c6d : 0);
}

// Namespace smart_cover/gadget_smart_cover
// Params 7, eflags: 0x0
// Checksum 0x7590396b, Offset: 0x708
// Size: 0xc6
function smartcover_start_microwave(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.smartcoversettings.bundle.var_c99d7dc7) && level.smartcoversettings.bundle.var_c99d7dc7 && newval == 1) {
        self thread startmicrowavefx(localclientnum);
        return;
    }
    if (newval == 0) {
        self notify(#"beam_stop");
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 7, eflags: 0x0
// Checksum 0xbac2d865, Offset: 0x7d8
// Size: 0x19c
function smartcover_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(level.smartcoversettings.bundle.deployanim)) {
        return;
    }
    self useanimtree("generic");
    if (newval == 1) {
        self setanimrestart(level.smartcoversettings.bundle.deployanim, 1, 0, 1);
        return;
    }
    if (bwastimejump) {
        currentanimtime = self getanimtime(level.smartcoversettings.bundle.deployanim);
        var_b9df8180 = 1 - newval;
        if (var_b9df8180 < currentanimtime) {
            self setanimtime(level.smartcoversettings.bundle.deployanim, var_b9df8180);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xaa9d60de, Offset: 0x980
// Size: 0xb0
function function_292aace8(localclientnum) {
    if (!isdefined(level.smartcoversettings.previewmodels[localclientnum])) {
        return;
    }
    foreach (previewmodel in level.smartcoversettings.previewmodels[localclientnum]) {
        previewmodel hide();
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x266763a4, Offset: 0xa38
// Size: 0x4e
function function_72cf5097(localclientnum) {
    player = self;
    player function_292aace8(localclientnum);
    level.smartcoversettings.var_856ee88b[localclientnum] = 0;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x1c982668, Offset: 0xa90
// Size: 0x318
function function_e924e54e(localclientnum) {
    player = function_f97e7787(localclientnum);
    player notify(#"hash_5c7dbac0591cb11f");
    player endon(#"hash_5c7dbac0591cb11f", #"game_ended");
    level endon(#"game_ended");
    level.smartcoversettings.var_856ee88b[localclientnum] = 1;
    function_57439f58(localclientnum);
    var_b3cf5783 = 0;
    while (true) {
        waitframe(1);
        player = function_f97e7787(localclientnum);
        if (!isdefined(player)) {
            break;
        }
        var_83c20ba7 = player function_92f39379(level.smartcoversettings.bundle.var_bbde0b27, level.smartcoversettings.bundle.maxwidth, 1, 1);
        if (!isdefined(var_83c20ba7) && !var_b3cf5783) {
            var_b3cf5783 = 1;
            player function_292aace8(localclientnum);
            player function_d83e9f0e(0, (0, 0, 0), (0, 0, 0));
            continue;
        } else if (isdefined(var_83c20ba7) && var_b3cf5783) {
            var_b3cf5783 = 0;
        } else if (!isdefined(var_83c20ba7)) {
            player function_d83e9f0e(0, (0, 0, 0), (0, 0, 0));
            continue;
        }
        if (isdefined(level.smartcoversettings.bundle.var_ab65f781) ? level.smartcoversettings.bundle.var_ab65f781 : 0) {
            if (var_83c20ba7.var_397d52cc) {
                previewmodel = player function_9909341f(localclientnum, var_83c20ba7.origin, var_83c20ba7.angles, var_83c20ba7.isvalid, 0, 1);
                continue;
            }
            previewmodel = player function_9909341f(localclientnum, var_83c20ba7.origin, var_83c20ba7.angles, var_83c20ba7.isvalid, 2, 3);
            previewmodel function_e64a3a7(localclientnum);
            previewmodel function_3d16f64a(localclientnum, player, var_83c20ba7, 1);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x6d4b223a, Offset: 0xdb0
// Size: 0x4c
function function_8487b56a(localclientnum) {
    player = self;
    player notify(#"hash_5c7dbac0591cb11f");
    player function_72cf5097(localclientnum);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x7c7448e1, Offset: 0xe08
// Size: 0x7e
function function_bd991dd5(localclientnum) {
    player = function_f97e7787(localclientnum);
    player notify(#"hash_5c39bdc22418d792");
    player endon(#"hash_5c39bdc22418d792");
    if (!isdefined(player.smartcover)) {
        player.smartcover = spawnstruct();
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x834ac864, Offset: 0xe90
// Size: 0x78
function function_fd2a4973(localclientnum) {
    player = self;
    player endon(#"disconnect");
    player waittill(#"death");
    player function_8487b56a(localclientnum);
    player notify(#"hash_5c39bdc22418d792");
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xaf8b6527, Offset: 0xf10
// Size: 0xc
function on_local_player_spawned(localclientnum) {
    
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0xdce08735, Offset: 0xf28
// Size: 0x88
function function_a95b9b02(localclientnum, modelname) {
    previewmodel = spawn(localclientnum, (0, 0, 0), "script_model");
    previewmodel setmodel(modelname);
    previewmodel hide();
    previewmodel notsolid();
    return previewmodel;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x7b414563, Offset: 0xfb8
// Size: 0x178
function function_57439f58(localclientnum) {
    player = self;
    if (isdefined(level.smartcoversettings.previewmodels[localclientnum])) {
        return;
    }
    level.smartcoversettings.previewmodels[localclientnum] = [];
    level.smartcoversettings.previewmodels[localclientnum][0] = function_a95b9b02(localclientnum, level.smartcoversettings.bundle.placementmodel);
    level.smartcoversettings.previewmodels[localclientnum][1] = function_a95b9b02(localclientnum, level.smartcoversettings.bundle.var_74d576ce);
    level.smartcoversettings.previewmodels[localclientnum][2] = function_a95b9b02(localclientnum, level.smartcoversettings.bundle.var_4553643);
    level.smartcoversettings.previewmodels[localclientnum][3] = function_a95b9b02(localclientnum, level.smartcoversettings.bundle.var_ae089762);
}

// Namespace smart_cover/gadget_smart_cover
// Params 6, eflags: 0x0
// Checksum 0x3665092c, Offset: 0x1138
// Size: 0x1b2
function function_9909341f(localclientnum, origin, angles, isvalid, var_63a58e2, var_879d5125) {
    player = self;
    previewmodel = undefined;
    var_eed719c2 = undefined;
    var_d7b958 = isvalid ? var_63a58e2 : var_879d5125;
    for (var_a9b3660c = 0; var_a9b3660c < level.smartcoversettings.previewmodels[localclientnum].size; var_a9b3660c++) {
        if (var_a9b3660c == var_d7b958) {
            continue;
        }
        level.smartcoversettings.previewmodels[localclientnum][var_a9b3660c] hide();
    }
    level.smartcoversettings.previewmodels[localclientnum][var_d7b958].origin = origin;
    level.smartcoversettings.previewmodels[localclientnum][var_d7b958].angles = angles;
    level.smartcoversettings.previewmodels[localclientnum][var_d7b958] show();
    player function_d83e9f0e(0, origin, angles);
    return level.smartcoversettings.previewmodels[localclientnum][var_d7b958];
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0xf19eabc1, Offset: 0x12f8
// Size: 0x70
function function_8d07c2eb(row, column) {
    cellindex = row * level.smartcoversettings.bundle.rowcount + column;
    if (cellindex < 10) {
        return ("joint_0" + cellindex);
    }
    return "joint_" + cellindex;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x8210acf3, Offset: 0x1370
// Size: 0xd0
function function_e64a3a7(localclientnum) {
    smartcover = self;
    for (rowindex = 0; rowindex < level.smartcoversettings.bundle.rowcount; rowindex++) {
        for (colindex = 1; colindex <= level.smartcoversettings.bundle.var_5f55efda; colindex++) {
            celllabel = function_8d07c2eb(rowindex, colindex);
            smartcover showpart(localclientnum, celllabel);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 4, eflags: 0x0
// Checksum 0x6d6d27ac, Offset: 0x1448
// Size: 0x478
function function_3d16f64a(localclientnum, player, buildinfo, var_af8e2576) {
    smartcover = self;
    cellheight = level.smartcoversettings.bundle.maxheight / level.smartcoversettings.bundle.rowcount;
    cellwidth = level.smartcoversettings.bundle.maxwidth / level.smartcoversettings.bundle.var_5f55efda;
    var_1515b0e3 = int(buildinfo.width / cellwidth);
    var_6c73fe4e = buildinfo.width - cellwidth * var_1515b0e3;
    if (var_6c73fe4e > 0 && var_6c73fe4e / 2 < level.smartcoversettings.bundle.var_d7a876a5 && var_1515b0e3 + 2 <= level.smartcoversettings.bundle.var_5f55efda) {
        var_1515b0e3 += 2;
    }
    var_d00864f3 = int(buildinfo.height / cellheight);
    var_dbf5c43f = buildinfo.height - cellheight * var_d00864f3;
    if (var_dbf5c43f > 0 && var_dbf5c43f < level.smartcoversettings.bundle.var_d7a876a5 && var_dbf5c43f < level.smartcoversettings.bundle.rowcount) {
        var_d00864f3++;
    }
    cellstoremove = [];
    var_7bde5089 = level.smartcoversettings.bundle.rowcount - var_d00864f3;
    for (rowindex = 0; rowindex < var_7bde5089; rowindex++) {
        rownum = level.smartcoversettings.bundle.rowcount - rowindex - 1;
        for (colindex = 1; colindex < level.smartcoversettings.bundle.var_5f55efda; colindex++) {
            celllabel = function_8d07c2eb(rownum, colindex);
            smartcover hidepart(localclientnum, celllabel);
        }
    }
    var_a5cdcc97 = level.smartcoversettings.bundle.var_5f55efda - var_1515b0e3;
    for (var_889f39f4 = 0; var_889f39f4 < int(var_a5cdcc97 / 2); var_889f39f4++) {
        cola = var_889f39f4 + 1;
        colb = level.smartcoversettings.bundle.var_5f55efda - var_889f39f4;
        for (rowindex = 0; rowindex < level.smartcoversettings.bundle.rowcount; rowindex++) {
            var_14a7c4a = function_8d07c2eb(rowindex, cola);
            var_db4801e1 = function_8d07c2eb(rowindex, colb);
            smartcover hidepart(localclientnum, var_14a7c4a);
            smartcover hidepart(localclientnum, var_db4801e1);
        }
    }
}

/#

    // Namespace smart_cover/gadget_smart_cover
    // Params 2, eflags: 0x0
    // Checksum 0xec5d231a, Offset: 0x18c8
    // Size: 0xec
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

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xd0289622, Offset: 0x19c0
// Size: 0x508
function startmicrowavefx(localclientnum) {
    turret = self;
    turret endon(#"death");
    turret endon(#"beam_stop");
    turret.should_update_fx = 1;
    angles = turret.angles;
    origin = turret.origin + (0, 0, 30);
    microwavefxent = spawn(localclientnum, origin, "script_model");
    microwavefxent setmodel(#"tag_microwavefx");
    microwavefxent.angles = angles;
    microwavefxent.fxhandles = [];
    microwavefxent.fxnames = [];
    microwavefxent.fxhashs = [];
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
        angles = turret.angles;
        origin = turret.origin + (0, 0, 30);
        forward = anglestoforward(angles);
        forward = vectorscale(forward, (isdefined(level.smartcoversettings.bundle.var_d600d0ee) ? level.smartcoversettings.bundle.var_d600d0ee : 0) + 40);
        var_e60cbef8 = anglestoforward(angles + (0, 55 / 3, 0));
        var_e60cbef8 = vectorscale(var_e60cbef8, (isdefined(level.smartcoversettings.bundle.var_d600d0ee) ? level.smartcoversettings.bundle.var_d600d0ee : 0) + 40);
        trace = bullettrace(origin, origin + forward, 0, turret);
        traceright = bullettrace(origin, origin - var_e60cbef8, 0, turret);
        traceleft = bullettrace(origin, origin + var_e60cbef8, 0, turret);
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
        microwavefxent playmicrowavefx(localclientnum, trace, traceright, traceleft, origin, turret.team);
        turret.should_update_fx = 0;
        wait 1;
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 3, eflags: 0x0
// Checksum 0xec0dd622, Offset: 0x1ed0
// Size: 0x1a8
function microwavefxhash(trace, origin, name) {
    hash = 0;
    counter = 2;
    for (i = 0; i < 5; i++) {
        endofhalffxsq = (i * 150 + 125) * (i * 150 + 125);
        endoffullfxsq = (i * 150 + 200) * (i * 150 + 200);
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

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0x3c15062e, Offset: 0x2080
// Size: 0xd4
function cleanupfx(localclientnum, microwavefxent) {
    self waittill(#"death", #"beam_stop");
    foreach (handle in microwavefxent.fxhandles) {
        if (isdefined(handle)) {
            stopfx(localclientnum, handle);
        }
    }
    microwavefxent delete();
}

// Namespace smart_cover/gadget_smart_cover
// Params 4, eflags: 0x0
// Checksum 0x97aa60b3, Offset: 0x2160
// Size: 0xdc
function play_fx_on_tag(localclientnum, fxname, tag, team) {
    if (!isdefined(self.fxhandles[tag]) || fxname != self.fxnames[tag]) {
        stop_fx_on_tag(localclientnum, fxname, tag);
        self.fxnames[tag] = fxname;
        self.fxhandles[tag] = util::playfxontag(localclientnum, fxname, self, tag);
        setfxteam(localclientnum, self.fxhandles[tag], team);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 3, eflags: 0x0
// Checksum 0x8c1c803b, Offset: 0x2248
// Size: 0x74
function stop_fx_on_tag(localclientnum, fxname, tag) {
    if (isdefined(self.fxhandles[tag])) {
        stopfx(localclientnum, self.fxhandles[tag]);
        self.fxhandles[tag] = undefined;
        self.fxnames[tag] = undefined;
    }
}

/#

    // Namespace smart_cover/gadget_smart_cover
    // Params 3, eflags: 0x0
    // Checksum 0x35733628, Offset: 0x22c8
    // Size: 0x94
    function render_debug_sphere(tag, color, fxname) {
        if (getdvarint(#"scr_microwave_turret_fx_debug", 0)) {
            origin = self gettagorigin(tag);
            sphere(origin, 2, color, 0.75, 1, 10, 100);
        }
    }

#/

// Namespace smart_cover/gadget_smart_cover
// Params 5, eflags: 0x0
// Checksum 0x583972df, Offset: 0x2368
// Size: 0xec
function stop_or_start_fx(localclientnum, fxname, tag, start, team) {
    if (start) {
        self play_fx_on_tag(localclientnum, fxname, tag, team);
        /#
            if (fxname == "<dev string:x30>") {
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

// Namespace smart_cover/gadget_smart_cover
// Params 6, eflags: 0x0
// Checksum 0x8ea1797a, Offset: 0x2460
// Size: 0x5ec
function playmicrowavefx(localclientnum, trace, traceright, traceleft, origin, team) {
    for (i = 0; i < 5; i++) {
        endofhalffxsq = (i * 150 + 125) * (i * 150 + 125);
        endoffullfxsq = (i * 150 + 200) * (i * 150 + 200);
        tracedistsq = distancesquared(origin, trace[#"position"]);
        startfx = tracedistsq >= endofhalffxsq || i == 0;
        fxname = tracedistsq > endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave" : "weapon/fx8_equip_smart_cover_microwave_sm";
        switch (i) {
        case 0:
            self play_fx_on_tag(localclientnum, fxname, "tag_fx11", team);
            break;
        case 1:
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx32", startfx, team);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx42", startfx, team);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx43", startfx, team);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx53", startfx, team);
            break;
        }
        tracedistsq = distancesquared(origin, traceleft[#"position"]);
        startfx = tracedistsq >= endofhalffxsq;
        fxname = tracedistsq > endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave" : "weapon/fx8_equip_smart_cover_microwave_sm";
        switch (i) {
        case 0:
            break;
        case 1:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx22", startfx, team);
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx33", startfx, team);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx44", startfx, team);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx54", startfx, team);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx55", startfx, team);
            break;
        }
        tracedistsq = distancesquared(origin, traceright[#"position"]);
        startfx = tracedistsq >= endofhalffxsq;
        fxname = tracedistsq > endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave" : "weapon/fx8_equip_smart_cover_microwave_sm";
        switch (i) {
        case 0:
            break;
        case 1:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx21", startfx, team);
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx31", startfx, team);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx41", startfx, team);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx51", startfx, team);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx52", startfx, team);
            break;
        }
    }
}

