#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_d03f485e;

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x0
// Checksum 0x1d0f5ba3, Offset: 0x2d0
// Size: 0x4d4
function init_shared(*eventstruct) {
    fields = getmapfields();
    level.var_117b4a3a = [];
    level.var_117b4a3a[0] = isdefined(fields.var_306136ca) ? fields.var_306136ca : #"hash_280d5153e1276d";
    level.var_117b4a3a[1] = isdefined(fields.var_e1ef0bf1) ? fields.var_e1ef0bf1 : #"hash_4b1a3a0285bea14d";
    level.var_117b4a3a[2] = isdefined(fields.var_97278b57) ? fields.var_97278b57 : #"hash_36a94457406aea0e";
    level.var_117b4a3a[3] = isdefined(fields.var_29209af9) ? fields.var_29209af9 : #"hash_5a60154937b01557";
    level.var_117b4a3a[4] = isdefined(fields.var_cd9dabc7) ? fields.var_cd9dabc7 : #"hash_c102abd4eb802c2";
    level.var_117b4a3a[5] = isdefined(fields.var_66b704d1) ? fields.var_66b704d1 : #"hash_1f6942044733abd";
    level.var_117b4a3a[6] = isdefined(fields.var_43647dc0) ? fields.var_43647dc0 : #"hash_5a5907512d97c7dc";
    level.var_117b4a3a[7] = isdefined(fields.var_f605c142) ? fields.var_f605c142 : #"hash_1ebd257fc3bf9843";
    level.zones = [];
    level.var_5070c5fa = [];
    level.current_zone = [];
    level.var_4d2a6912 = [];
    clientfield::register("world", "war_zone", 1, 5, "int", &function_a0c208cf, 0, 0);
    clientfield::register("scriptmover", "scriptid", 1, 5, "int", &function_e116df6c, 0, 0);
    clientfield::function_5b7d846d("team_momentum.level1PercentageAllies", #"team_momentum", #"hash_643b3f9da9c4d8d2", 1, 8, "float", undefined, 0, 0);
    clientfield::function_5b7d846d("team_momentum.level2PercentageAllies", #"team_momentum", #"hash_611b2f468342607", 1, 8, "float", undefined, 0, 0);
    clientfield::function_5b7d846d("team_momentum.level1PercentageAxis", #"team_momentum", #"hash_7ea338ad957a1105", 1, 8, "float", undefined, 0, 0);
    clientfield::function_5b7d846d("team_momentum.level2PercentageAxis", #"team_momentum", #"hash_35d701c412ac4bac", 1, 8, "float", undefined, 0, 0);
    clientfield::function_5b7d846d("team_momentum.currentLevelAllies", #"team_momentum", #"hash_73ad40a7fc3a4e6e", 1, 2, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("team_momentum.currentLevelAxis", #"team_momentum", #"hash_2afd77ad8b4bdb99", 1, 2, "int", undefined, 0, 0);
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_localplayer_spawned(&function_df78674f);
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x0
// Checksum 0x99eb04ff, Offset: 0x7b0
// Size: 0x16c
function on_localclient_connect(local_client_num) {
    while (level.var_5070c5fa.size == 0) {
        waitframe(1);
        for (zi = 0; zi < 5; zi++) {
            objid = serverobjective_getobjective(local_client_num, "war_" + zi);
            if (!isdefined(objid)) {
                continue;
            }
            level.var_5070c5fa[objid] = zi;
        }
    }
    objectives = getarraykeys(level.var_5070c5fa);
    foreach (objective in objectives) {
        function_dd2493cc(local_client_num, objective);
        level thread function_3ec0c10c(local_client_num, objective);
    }
    function_d456b15a(local_client_num);
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x4
// Checksum 0x15efb4db, Offset: 0x928
// Size: 0xdc
function private function_d456b15a(*localclientnum) {
    var_980d4dc3 = 2 + "x";
    setuimodelvalue(getuimodel(function_5f72e972(#"team_momentum"), "level1Multiplier"), var_980d4dc3);
    var_298172e3 = 3 + "x";
    setuimodelvalue(getuimodel(function_5f72e972(#"team_momentum"), "level2Multiplier"), var_298172e3);
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2, eflags: 0x0
// Checksum 0x728e2f05, Offset: 0xa10
// Size: 0x448
function function_dd2493cc(local_client_num, objid) {
    zone_index = level.var_5070c5fa[objid];
    if (!isdefined(zone_index)) {
        return;
    }
    var_c86e6ba8 = function_9b3f0ed1(local_client_num);
    iscodcaster = codcaster::function_b8fe9b52(local_client_num);
    suffix = iscodcaster ? "_codcaster" : "";
    var_efa99888 = serverobjective_getobjectivegamemodeflags(local_client_num, objid);
    objective = serverobjective_getobjectiveentity(local_client_num, objid);
    var_44fada37 = isdefined(objective function_9682ea07()) ? objective function_9682ea07() : 0;
    capturingteam = function_364d50b(var_44fada37);
    var_b65ea6f2 = function_364d50b(var_efa99888);
    contested = var_44fada37 === 3;
    locked = var_efa99888 === 3;
    inactive = var_efa99888 === 4;
    state = 0;
    if (locked || inactive) {
        state = 0;
    } else if (contested) {
        state = 3;
    } else if (capturingteam === #"none") {
        if (var_b65ea6f2 === #"none") {
            state = 0;
        } else if (var_b65ea6f2 === var_c86e6ba8) {
            state = 1;
        } else {
            state = 2;
        }
    } else if (capturingteam === var_c86e6ba8) {
        var_4c107e47 = var_b65ea6f2 === var_c86e6ba8 || var_b65ea6f2 === #"none";
        state = var_4c107e47 ? 4 : 7;
    } else {
        var_6dbe5a6e = var_b65ea6f2 !== var_c86e6ba8;
        state = var_6dbe5a6e ? 5 : 6;
    }
    if (isdefined(level.othervisuals[zone_index])) {
        foreach (entid in level.othervisuals[zone_index]) {
            entity = getentbynum(local_client_num, entid);
            for (si = 0; si < level.var_117b4a3a.size; si++) {
                rob = level.var_117b4a3a[si] + suffix;
                if (entity function_d2503806(rob)) {
                    if (state != si) {
                        entity stoprenderoverridebundle(rob);
                    }
                    continue;
                }
                if (state == si) {
                    entity playrenderoverridebundle(rob);
                    if (iscodcaster) {
                        codcaster::function_773f6e31(local_client_num, entity, rob, state);
                    }
                }
            }
        }
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x0
// Checksum 0x1e186b94, Offset: 0xe60
// Size: 0x9c
function function_df78674f(localclientnum) {
    if (isdefined(localclientnum) && isdefined(level.current_zone[localclientnum])) {
        function_dd2493cc(localclientnum, level.current_zone[localclientnum]);
    }
    if (isdefined(localclientnum) && is_true(level.var_4d2a6912[localclientnum])) {
        soundsetmusicstate("");
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2, eflags: 0x0
// Checksum 0xcc7258a2, Offset: 0xf08
// Size: 0x2d8
function function_3ec0c10c(localclientnum, objectiveid) {
    level endon(#"game_ended");
    if (!isdefined(localclientnum) || !isdefined(objectiveid)) {
        return;
    }
    objective = serverobjective_getobjectiveentity(localclientnum, objectiveid);
    if (!isdefined(objective)) {
        return;
    }
    while (true) {
        local_player = function_5c10bd79(localclientnum);
        if (!isdefined(local_player)) {
            wait 1;
            continue;
        }
        if (!isdefined(objective)) {
            objective = serverobjective_getobjectiveentity(localclientnum, objectiveid);
        }
        if (!isdefined(objective)) {
            wait 0.25;
            continue;
        }
        var_44fada37 = isdefined(objective function_9682ea07()) ? objective function_9682ea07() : 0;
        if (!isdefined(local_player.var_a01d8a9b)) {
            local_player.var_a01d8a9b = [];
        }
        if (!isdefined(local_player.var_bf29fd10)) {
            local_player.var_bf29fd10 = [];
        }
        if (!isdefined(local_player.var_8854e023)) {
            local_player.var_8854e023 = [];
        }
        if (!isdefined(local_player.var_145446e5)) {
            local_player.var_145446e5 = [];
        }
        isplayerusing = function_ebea14a0(localclientnum, objectiveid, local_player);
        if (isplayerusing) {
            if (var_44fada37 === 3) {
                local_player function_6d3c03c1(objectiveid);
                local_player thread function_bd67b54(localclientnum, objectiveid, 255);
            } else {
                local_player function_bed50d4f(objectiveid);
                capturingteam = function_364d50b(var_44fada37);
                if (capturingteam === local_player.team) {
                    local_player thread function_bd67b54(localclientnum, objectiveid, 255);
                } else {
                    local_player function_94748ad0(objectiveid, var_44fada37);
                }
            }
        } else {
            local_player function_bed50d4f(objectiveid);
            local_player function_94748ad0(objectiveid);
        }
        wait 0.25;
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x0
// Checksum 0x268057f9, Offset: 0x11e8
// Size: 0x20
function function_6d3c03c1(objectiveid) {
    self.var_8854e023[objectiveid] = 1;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x0
// Checksum 0x488b0f6, Offset: 0x1210
// Size: 0x1c
function function_bed50d4f(objectiveid) {
    self.var_8854e023[objectiveid] = 0;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 3, eflags: 0x0
// Checksum 0x51b83d57, Offset: 0x1238
// Size: 0x1a6
function function_bd67b54(localclientnum, objectiveid, var_f802a6b1) {
    level endon(#"game_ended");
    if (!isdefined(level.var_4d2a6912[localclientnum])) {
        level.var_4d2a6912[localclientnum] = 1;
    }
    if (!is_true(self.var_145446e5[objectiveid])) {
        self.var_145446e5[objectiveid] = 1;
        self endon(#"death");
        self endon(#"disconnect");
        self endon("sndStopCaptureMusic" + objectiveid);
        progress = serverobjective_getobjectiveprogress(localclientnum, objectiveid);
        var_1ba62555 = progress / var_f802a6b1;
        var_1d305896 = var_1ba62555;
        while (true) {
            progress = serverobjective_getobjectiveprogress(localclientnum, objectiveid);
            var_1ba62555 = progress / var_f802a6b1;
            if (var_1ba62555 < var_1d305896) {
                self.var_c3ee4641 = 1;
            } else if (var_1ba62555 > var_1d305896) {
                self.var_c3ee4641 = 0;
            }
            var_1d305896 = var_1ba62555;
            if (!isdefined(var_1ba62555)) {
                return;
            }
            self function_b1afa080(objectiveid, var_1ba62555, self.var_8854e023[objectiveid], self.var_c3ee4641);
            waitframe(1);
        }
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2, eflags: 0x0
// Checksum 0xccb66ab1, Offset: 0x13e8
// Size: 0xcc
function function_94748ad0(objectiveid, var_44fada37) {
    level endon(#"game_ended");
    if (is_true(self.var_145446e5[objectiveid])) {
        self notify("sndStopCaptureMusic" + objectiveid);
        self.var_145446e5[objectiveid] = undefined;
        self.var_b3890fdf = 0;
        self.var_8c921a1f = "";
        if (var_44fada37 === 0) {
            soundsetmusicstate("cap_war_success");
            return;
        }
        soundsetmusicstate("cap_war_exit");
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 4, eflags: 0x0
// Checksum 0xa13aef0, Offset: 0x14c0
// Size: 0x2e4
function function_b1afa080(*objectiveid, var_1ba62555, var_498fc93a = 0, var_3b2f769b = 0) {
    if (!isdefined(self.var_8c921a1f)) {
        self.var_8c921a1f = "";
    }
    if (!isdefined(self.var_b3890fdf)) {
        self.var_b3890fdf = 0;
    }
    if (var_498fc93a) {
        var_9c1ed9ea = "cap_war_contested";
        str_alias = #"hash_43014e1f7354354f";
        n_wait_time = 1.25;
    } else if (var_3b2f769b) {
        var_9c1ed9ea = "cap_war_draining";
        str_alias = #"hash_1c518fb856754e14";
        n_wait_time = 2.5;
    } else if (var_1ba62555 >= 0.8) {
        var_9c1ed9ea = "cap_war_percent_90";
        str_alias = #"hash_1c518cb8567548fb";
        n_wait_time = 1.25;
    } else if (var_1ba62555 >= 0.6) {
        var_9c1ed9ea = "cap_war_percent_75";
        str_alias = #"hash_1c5191b85675517a";
        n_wait_time = 1.25;
    } else if (var_1ba62555 >= 0.4) {
        var_9c1ed9ea = "cap_war_percent_50";
        str_alias = #"hash_1c5192b85675532d";
        n_wait_time = 1.25;
    } else if (var_1ba62555 >= 0.2) {
        var_9c1ed9ea = "cap_war_percent_25";
        str_alias = #"hash_1c5192b85675532d";
        n_wait_time = 2.5;
    } else {
        var_9c1ed9ea = "cap_war_percent_0";
        str_alias = #"hash_1c518fb856754e14";
        n_wait_time = 2.5;
    }
    if (isdefined(str_alias)) {
        var_bb0c6711 = gettime();
        if (self.var_b3890fdf <= var_bb0c6711) {
            if (self.var_b3890fdf === 0) {
                self.var_b3890fdf = var_bb0c6711 - 50;
            }
            self.var_b3890fdf += int(n_wait_time * 1000);
            self playsound(0, str_alias);
        }
    }
    if (var_9c1ed9ea != self.var_8c921a1f) {
        self.var_8c921a1f = var_9c1ed9ea;
        soundsetmusicstate(var_9c1ed9ea);
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x0
// Checksum 0x417ca41b, Offset: 0x17b0
// Size: 0x7a
function function_364d50b(teamindex = 0) {
    team = #"none";
    if (teamindex === 1) {
        team = #"allies";
    } else if (teamindex === 2) {
        team = #"axis";
    }
    return team;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 7, eflags: 0x0
// Checksum 0x9c5e95cd, Offset: 0x1838
// Size: 0x3b0
function function_a0c208cf(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.var_2a9880e9)) {
        level.var_2a9880e9 = getentarray(fieldname, "war_zone", "targetname");
    }
    currentzoneindex = level.current_zone[fieldname];
    if (isdefined(currentzoneindex) && isdefined(level.othervisuals[currentzoneindex])) {
        foreach (entid in level.othervisuals[currentzoneindex]) {
            entity = getentbynum(fieldname, entid);
            for (si = 0; si < 4; si++) {
                if (entity function_d2503806(level.var_117b4a3a[si])) {
                    entity stoprenderoverridebundle(level.var_117b4a3a[si]);
                }
            }
        }
    }
    level.current_zone[fieldname] = bwastimejump;
    if (isdefined(level.zones[bwastimejump])) {
        foreach (entid in level.othervisuals[bwastimejump]) {
            newzone = getentbynum(fieldname, entid);
            if (!newzone function_d2503806(level.var_117b4a3a[0])) {
                newzone playrenderoverridebundle(level.var_117b4a3a[0]);
            }
            foreach (trig in level.var_2a9880e9) {
                if (isdefined(newzone.script_index) && newzone.script_index == trig.script_index) {
                    trig function_c06a8682(fieldname);
                    continue;
                }
                trig function_c6c4ce9f(fieldname);
            }
        }
        return;
    }
    level.current_zone[fieldname] = undefined;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 7, eflags: 0x0
// Checksum 0xeea5b778, Offset: 0x1bf0
// Size: 0x1b8
function function_e116df6c(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    fieldname -= 1;
    bwastimejump -= 1;
    if (bwastimejump == fieldname && isdefined(self.script_index)) {
        return;
    }
    script_index = bwastimejump;
    self.script_index = script_index;
    if (!isdefined(level.othervisuals[script_index])) {
        level.othervisuals[script_index] = [];
    }
    if (!isdefined(level.othervisuals[script_index])) {
        level.othervisuals[script_index] = [];
    } else if (!isarray(level.othervisuals[script_index])) {
        level.othervisuals[script_index] = array(level.othervisuals[script_index]);
    }
    if (!isinarray(level.othervisuals[script_index], self getentitynumber())) {
        level.othervisuals[script_index][level.othervisuals[script_index].size] = self getentitynumber();
    }
    level.zones[bwastimejump] = self getentitynumber();
}

// Namespace namespace_d03f485e/event_f4737734
// Params 1, eflags: 0x40
// Checksum 0xbf1096ee, Offset: 0x1db0
// Size: 0x64
function event_handler[event_f4737734] objective_update(eventstruct) {
    local_client_num = eventstruct.localclientnum;
    obj_id = eventstruct.id;
    ent = eventstruct.entity_num;
    function_dd2493cc(local_client_num, obj_id);
}

