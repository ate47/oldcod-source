#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\deployable;

#namespace smart_cover;

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x1 linked
// Checksum 0x29d76e30, Offset: 0x248
// Size: 0x27c
function init_shared() {
    callback::on_localplayer_spawned(&on_local_player_spawned);
    clientfield::register("scriptmover", "smartcover_placed", 1, 5, "float", &smartcover_placed, 0, 0);
    clientfield::register_clientuimodel("hudItems.smartCoverState", #"hash_6f4b11a0bee9b73d", #"smartcoverstate", 1, 1, "int", undefined, 0, 0);
    clientfield::register("scriptmover", "start_smartcover_microwave", 1, 1, "int", &smartcover_start_microwave, 0, 0);
    level.smartcoversettings = spawnstruct();
    level.smartcoversettings.previewmodels = [];
    level.smartcoversettings.var_aef370a9 = [];
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
// Params 0, eflags: 0x1 linked
// Checksum 0x99af3511, Offset: 0x4d0
// Size: 0x284
function setupdvars() {
    setdvar(#"hash_25f7092e7c7b66f2", 0);
    setdvar(#"hash_4332205cbf1cc384", 0);
    setdvar(#"smartcover_drawtime", 1000);
    setdvar(#"hash_436fc2fad44e9041", 1);
    setdvar(#"hash_1d8eb304f5cf8033", 0);
    setdvar(#"smartcover_tracedistance", level.smartcoversettings.bundle.var_1f0ae388);
    setdvar(#"hash_13c23fd3a4387b84", 8);
    setdvar(#"hash_55a8dba3350b8b7c", 4);
    setdvar(#"hash_4f4ce3cb18b004bc", 10);
    setdvar(#"hash_417afa70d515fba5", isdefined(level.smartcoversettings.bundle.var_76d79155) ? level.smartcoversettings.bundle.var_76d79155 : 0);
    setdvar(#"hash_71f8bd4cd30de4b3", isdefined(level.smartcoversettings.bundle.var_e35fc674) ? level.smartcoversettings.bundle.var_e35fc674 : 0);
    setdvar(#"hash_39a564d4801c4b2e", isdefined(level.smartcoversettings.bundle.var_1f0ae388) ? level.smartcoversettings.bundle.var_1f0ae388 : 0);
}

// Namespace smart_cover/gadget_smart_cover
// Params 7, eflags: 0x1 linked
// Checksum 0xdb266510, Offset: 0x760
// Size: 0xae
function smartcover_start_microwave(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (is_true(level.smartcoversettings.bundle.var_f4e0e7d7) && bwastimejump == 1) {
        self thread startmicrowavefx(fieldname);
        return;
    }
    if (bwastimejump == 0) {
        self notify(#"beam_stop");
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 7, eflags: 0x1 linked
// Checksum 0xcaec4516, Offset: 0x818
// Size: 0x194
function smartcover_placed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(binitialsnap);
    if (!isdefined(level.smartcoversettings.bundle.deployanim)) {
        return;
    }
    self useanimtree("generic");
    if (fieldname == 1) {
        self setanimrestart(level.smartcoversettings.bundle.deployanim, 1, 0, 1);
        return;
    }
    if (bwastimejump) {
        currentanimtime = self getanimtime(level.smartcoversettings.bundle.deployanim);
        var_f56117a2 = 1 - fieldname;
        if (var_f56117a2 < currentanimtime) {
            self setanimtime(level.smartcoversettings.bundle.deployanim, var_f56117a2);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x1 linked
// Checksum 0x998f8322, Offset: 0x9b8
// Size: 0xc0
function function_112e3e89(localclientnum) {
    if (!isdefined(level.smartcoversettings.previewmodels[localclientnum])) {
        return;
    }
    foreach (previewmodel in level.smartcoversettings.previewmodels[localclientnum]) {
        previewmodel hide();
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x1 linked
// Checksum 0x633bcece, Offset: 0xa80
// Size: 0x4c
function function_fd04d5d5(localclientnum) {
    player = self;
    player function_112e3e89(localclientnum);
    level.smartcoversettings.var_aef370a9[localclientnum] = 0;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xb06aad59, Offset: 0xad8
// Size: 0x308
function function_1c2930c7(localclientnum) {
    player = function_5c10bd79(localclientnum);
    player notify(#"hash_5c7dbac0591cb11f");
    player endon(#"hash_5c7dbac0591cb11f", #"game_ended");
    level endon(#"game_ended");
    level.smartcoversettings.var_aef370a9[localclientnum] = 1;
    function_722fc669(localclientnum);
    var_ccfe777 = 0;
    while (true) {
        waitframe(1);
        player = function_5c10bd79(localclientnum);
        if (!isdefined(player)) {
            break;
        }
        var_b43e8dc2 = player function_287dcf4b(level.smartcoversettings.bundle.var_63aab046, level.smartcoversettings.bundle.maxwidth, 1, 1, level.smartcoversettings.var_8d86ade8);
        if (!isdefined(var_b43e8dc2) && !var_ccfe777) {
            var_ccfe777 = 1;
            player function_112e3e89(localclientnum);
            player function_bf191832(0, (0, 0, 0), (0, 0, 0));
            continue;
        } else if (isdefined(var_b43e8dc2) && var_ccfe777) {
            var_ccfe777 = 0;
        } else if (!isdefined(var_b43e8dc2)) {
            player function_bf191832(0, (0, 0, 0), (0, 0, 0));
            continue;
        }
        if (isdefined(level.smartcoversettings.bundle.var_8fa9aac4) ? level.smartcoversettings.bundle.var_8fa9aac4 : 0) {
            if (var_b43e8dc2.var_bf9ca9b0) {
                previewmodel = player function_8fb44aff(localclientnum, var_b43e8dc2.origin, var_b43e8dc2.angles, var_b43e8dc2.isvalid, 0, 1);
                continue;
            }
            previewmodel = player function_8fb44aff(localclientnum, var_b43e8dc2.origin, var_b43e8dc2.angles, var_b43e8dc2.isvalid, 2, 3);
            previewmodel function_dbaf4647(localclientnum);
            previewmodel function_5a8becdc(localclientnum, player, var_b43e8dc2, 1);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x1 linked
// Checksum 0x8d8db48e, Offset: 0xde8
// Size: 0x4c
function function_59605cb(localclientnum) {
    player = self;
    player notify(#"hash_5c7dbac0591cb11f");
    player function_fd04d5d5(localclientnum);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x6c72a01d, Offset: 0xe40
// Size: 0x7a
function function_17d973ec(localclientnum) {
    player = function_5c10bd79(localclientnum);
    player notify(#"hash_5c39bdc22418d792");
    player endon(#"hash_5c39bdc22418d792");
    if (!isdefined(player.smartcover)) {
        player.smartcover = spawnstruct();
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x932481e9, Offset: 0xec8
// Size: 0x78
function function_5d802b86(localclientnum) {
    player = self;
    player endon(#"disconnect");
    player waittill(#"death");
    player function_59605cb(localclientnum);
    player notify(#"hash_5c39bdc22418d792");
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x1 linked
// Checksum 0x4eda8f73, Offset: 0xf48
// Size: 0xc
function on_local_player_spawned(*localclientnum) {
    
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x1 linked
// Checksum 0xbcab3e22, Offset: 0xf60
// Size: 0x88
function function_641491ac(localclientnum, modelname) {
    previewmodel = spawn(localclientnum, (0, 0, 0), "script_model");
    previewmodel setmodel(modelname);
    previewmodel hide();
    previewmodel notsolid();
    return previewmodel;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x1 linked
// Checksum 0x80b1490d, Offset: 0xff0
// Size: 0x16e
function function_722fc669(localclientnum) {
    player = self;
    if (isdefined(level.smartcoversettings.previewmodels[localclientnum])) {
        return;
    }
    level.smartcoversettings.previewmodels[localclientnum] = [];
    level.smartcoversettings.previewmodels[localclientnum][0] = function_641491ac(localclientnum, level.smartcoversettings.bundle.placementmodel);
    level.smartcoversettings.previewmodels[localclientnum][1] = function_641491ac(localclientnum, level.smartcoversettings.bundle.var_46732914);
    level.smartcoversettings.previewmodels[localclientnum][2] = function_641491ac(localclientnum, level.smartcoversettings.bundle.var_1b5c037d);
    level.smartcoversettings.previewmodels[localclientnum][3] = function_641491ac(localclientnum, level.smartcoversettings.bundle.var_76ac23f2);
}

// Namespace smart_cover/gadget_smart_cover
// Params 6, eflags: 0x1 linked
// Checksum 0x15043294, Offset: 0x1168
// Size: 0x19e
function function_8fb44aff(localclientnum, origin, angles, isvalid, var_eb65925c, var_4b3e5e0a) {
    player = self;
    previewmodel = undefined;
    var_80f43370 = undefined;
    var_ff5a387e = isvalid ? var_eb65925c : var_4b3e5e0a;
    for (var_a6932c26 = 0; var_a6932c26 < level.smartcoversettings.previewmodels[localclientnum].size; var_a6932c26++) {
        if (var_a6932c26 == var_ff5a387e) {
            continue;
        }
        level.smartcoversettings.previewmodels[localclientnum][var_a6932c26] hide();
    }
    level.smartcoversettings.previewmodels[localclientnum][var_ff5a387e].origin = origin;
    level.smartcoversettings.previewmodels[localclientnum][var_ff5a387e].angles = angles;
    level.smartcoversettings.previewmodels[localclientnum][var_ff5a387e] show();
    player function_bf191832(0, origin, angles);
    return level.smartcoversettings.previewmodels[localclientnum][var_ff5a387e];
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x1 linked
// Checksum 0x26b761c6, Offset: 0x1310
// Size: 0x70
function function_d66a0190(row, column) {
    cellindex = row * level.smartcoversettings.bundle.rowcount + column;
    if (cellindex < 10) {
        return ("joint_0" + cellindex);
    }
    return "joint_" + cellindex;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x1 linked
// Checksum 0x6192f5ad, Offset: 0x1388
// Size: 0xc4
function function_dbaf4647(localclientnum) {
    smartcover = self;
    for (rowindex = 0; rowindex < level.smartcoversettings.bundle.rowcount; rowindex++) {
        for (colindex = 1; colindex <= level.smartcoversettings.bundle.var_b118698f; colindex++) {
            celllabel = function_d66a0190(rowindex, colindex);
            smartcover showpart(localclientnum, celllabel);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 4, eflags: 0x1 linked
// Checksum 0x7f34b025, Offset: 0x1458
// Size: 0x444
function function_5a8becdc(localclientnum, *player, buildinfo, *var_4b1c8937) {
    smartcover = self;
    cellheight = level.smartcoversettings.bundle.maxheight / level.smartcoversettings.bundle.rowcount;
    cellwidth = level.smartcoversettings.bundle.maxwidth / level.smartcoversettings.bundle.var_b118698f;
    var_b963136f = int(var_4b1c8937.width / cellwidth);
    var_227adab7 = var_4b1c8937.width - cellwidth * var_b963136f;
    if (var_227adab7 > 0 && var_227adab7 / 2 < level.smartcoversettings.bundle.var_3dfbdbeb && var_b963136f + 2 <= level.smartcoversettings.bundle.var_b118698f) {
        var_b963136f += 2;
    }
    var_9de92bd5 = int(var_4b1c8937.height / cellheight);
    var_2582dbd = var_4b1c8937.height - cellheight * var_9de92bd5;
    if (var_2582dbd > 0 && var_2582dbd < level.smartcoversettings.bundle.var_3dfbdbeb && var_2582dbd < level.smartcoversettings.bundle.rowcount) {
        var_9de92bd5++;
    }
    cellstoremove = [];
    var_e465f403 = level.smartcoversettings.bundle.rowcount - var_9de92bd5;
    for (rowindex = 0; rowindex < var_e465f403; rowindex++) {
        rownum = level.smartcoversettings.bundle.rowcount - rowindex - 1;
        for (colindex = 1; colindex < level.smartcoversettings.bundle.var_b118698f; colindex++) {
            celllabel = function_d66a0190(rownum, colindex);
            smartcover hidepart(buildinfo, celllabel);
        }
    }
    var_f636c423 = level.smartcoversettings.bundle.var_b118698f - var_b963136f;
    for (var_688bc60 = 0; var_688bc60 < int(var_f636c423 / 2); var_688bc60++) {
        cola = var_688bc60 + 1;
        colb = level.smartcoversettings.bundle.var_b118698f - var_688bc60;
        for (rowindex = 0; rowindex < level.smartcoversettings.bundle.rowcount; rowindex++) {
            microwave_sh_turr = function_d66a0190(rowindex, cola);
            var_1ffc0b2e = function_d66a0190(rowindex, colb);
            smartcover hidepart(buildinfo, microwave_sh_turr);
            smartcover hidepart(buildinfo, var_1ffc0b2e);
        }
    }
}

/#

    // Namespace smart_cover/gadget_smart_cover
    // Params 2, eflags: 0x0
    // Checksum 0xf6ad0e45, Offset: 0x18a8
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

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x1 linked
// Checksum 0x36fd0b92, Offset: 0x1998
// Size: 0x4ac
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
        forward = vectorscale(forward, (isdefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) + 40);
        var_e2e9fefa = anglestoforward(angles + (0, 55 / 3, 0));
        var_e2e9fefa = vectorscale(var_e2e9fefa, (isdefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) + 40);
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
        microwavefxent playmicrowavefx(localclientnum, trace, traceright, traceleft, origin, turret.team);
        turret.should_update_fx = 0;
        wait 1;
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 3, eflags: 0x1 linked
// Checksum 0xc6ec0268, Offset: 0x1e50
// Size: 0x17a
function microwavefxhash(trace, origin, name) {
    hash = 0;
    counter = 2;
    for (i = 0; i < 5; i++) {
        endofhalffxsq = function_a3f6cdac(i * 150 + 125);
        endoffullfxsq = function_a3f6cdac(i * 150 + 200);
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
// Params 2, eflags: 0x1 linked
// Checksum 0xd854fb79, Offset: 0x1fd8
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

// Namespace smart_cover/gadget_smart_cover
// Params 4, eflags: 0x1 linked
// Checksum 0x4b0f6e81, Offset: 0x20c0
// Size: 0xbc
function play_fx_on_tag(localclientnum, fxname, tag, team) {
    if (!isdefined(self.fxhandles[tag]) || fxname != self.fxnames[tag]) {
        stop_fx_on_tag(localclientnum, fxname, tag);
        self.fxnames[tag] = fxname;
        self.fxhandles[tag] = util::playfxontag(localclientnum, fxname, self, tag);
        setfxteam(localclientnum, self.fxhandles[tag], team);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 3, eflags: 0x1 linked
// Checksum 0xbd4b968d, Offset: 0x2188
// Size: 0x74
function stop_fx_on_tag(localclientnum, *fxname, tag) {
    if (isdefined(self.fxhandles[tag])) {
        stopfx(fxname, self.fxhandles[tag]);
        self.fxhandles[tag] = undefined;
        self.fxnames[tag] = undefined;
    }
}

/#

    // Namespace smart_cover/gadget_smart_cover
    // Params 3, eflags: 0x0
    // Checksum 0x86187580, Offset: 0x2208
    // Size: 0x94
    function render_debug_sphere(tag, color, *fxname) {
        if (getdvarint(#"scr_microwave_turret_fx_debug", 0)) {
            origin = self gettagorigin(color);
            sphere(origin, 2, fxname, 0.75, 1, 10, 100);
        }
    }

#/

// Namespace smart_cover/gadget_smart_cover
// Params 5, eflags: 0x1 linked
// Checksum 0xe9efd422, Offset: 0x22a8
// Size: 0xec
function stop_or_start_fx(localclientnum, fxname, tag, start, team) {
    if (start) {
        self play_fx_on_tag(localclientnum, fxname, tag, team);
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

// Namespace smart_cover/gadget_smart_cover
// Params 6, eflags: 0x1 linked
// Checksum 0xd5d851df, Offset: 0x23a0
// Size: 0x56a
function playmicrowavefx(localclientnum, trace, traceright, traceleft, origin, team) {
    for (i = 0; i < 5; i++) {
        endofhalffxsq = function_a3f6cdac(i * 150 + 125);
        endoffullfxsq = function_a3f6cdac(i * 150 + 200);
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

