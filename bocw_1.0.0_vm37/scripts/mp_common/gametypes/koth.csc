#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace koth;

// Namespace koth/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x3b70559d, Offset: 0x158
// Size: 0x468
function event_handler[gametype_init] main(*eventstruct) {
    level.current_zone = [];
    level.current_state = [];
    for (i = 0; i < 4; i++) {
        level.current_zone[i] = 0;
        level.current_state[i] = 0;
    }
    level.hardpoints = [];
    level.visuals = [];
    level.hardpointfx = [];
    level.othervisuals = [];
    clientfield::register("world", "hardpoint", 1, 5, "int", &hardpoint, 0, 0);
    clientfield::register("world", "hardpointteam", 1, 5, "int", &hardpoint_state, 0, 0);
    clientfield::register("world", "activeTriggerIndex", 1, 5, "int", &function_9e6c42f8, 0, 0);
    clientfield::register("scriptmover", "scriptid", 1, 5, "int", &function_e116df6c, 0, 0);
    level._effect[#"zoneedgemarker"] = [];
    level._effect[#"zoneedgemarker"][0] = #"ui/fx8_infil_marker_neutral";
    level._effect[#"zoneedgemarker"][1] = #"hash_5c2ae9f4f331d4b9";
    level._effect[#"zoneedgemarker"][2] = #"hash_7d1b0f001ea88b82";
    level._effect[#"zoneedgemarker"][3] = #"hash_7981eb245ea536fc";
    level._effect[#"zoneedgemarkerwndw"] = [];
    level._effect[#"zoneedgemarkerwndw"][0] = #"ui/fx8_infil_marker_neutral_window";
    level._effect[#"zoneedgemarkerwndw"][1] = #"hash_5565c3fc2c7742fe";
    level._effect[#"zoneedgemarkerwndw"][2] = #"hash_3283b765fe480df7";
    level._effect[#"zoneedgemarkerwndw"][3] = #"hash_6a512c225256a2e9";
    fields = getmapfields();
    level.var_117b4a3a = [];
    level.var_117b4a3a[0] = isdefined(fields.var_306136ca) ? fields.var_306136ca : #"hash_280d5153e1276d";
    level.var_117b4a3a[1] = isdefined(fields.var_e1ef0bf1) ? fields.var_e1ef0bf1 : #"hash_4b1a3a0285bea14d";
    level.var_117b4a3a[2] = isdefined(fields.var_97278b57) ? fields.var_97278b57 : #"hash_36a94457406aea0e";
    level.var_117b4a3a[3] = isdefined(fields.var_29209af9) ? fields.var_29209af9 : #"hash_5a60154937b01557";
    callback::on_spawned(&function_df78674f);
    level.var_5ff510b = [];
}

// Namespace koth/event_f4737734
// Params 1, eflags: 0x40
// Checksum 0x5e91690c, Offset: 0x5c8
// Size: 0xa4
function event_handler[event_f4737734] objective_update(eventstruct) {
    local_client_num = eventstruct.localclientnum;
    obj_id = eventstruct.id;
    ent = eventstruct.entity_num;
    if (isdefined(ent.script_index)) {
        level.var_5ff510b[ent.script_index] = obj_id;
    }
    if (level.current_zone[local_client_num] === ent.script_index) {
        function_dd2493cc(local_client_num, obj_id);
    }
}

// Namespace koth/koth
// Params 2, eflags: 0x0
// Checksum 0x6f663dcd, Offset: 0x678
// Size: 0x310
function function_dd2493cc(local_client_num, objid) {
    zone_index = level.current_zone[local_client_num];
    if (!isdefined(zone_index)) {
        return;
    }
    iscodcaster = codcaster::function_b8fe9b52(local_client_num);
    if (iscodcaster) {
        var_4bb78aa3 = function_8147db19(local_client_num, objid, #"allies");
        var_c7fc4f01 = function_8147db19(local_client_num, objid, #"axis");
    } else {
        friendlyteam = function_9b3f0ed1(local_client_num);
        enemyteam = util::get_enemy_team(friendlyteam);
        var_4bb78aa3 = function_8147db19(local_client_num, objid, friendlyteam);
        var_c7fc4f01 = function_8147db19(local_client_num, objid, enemyteam);
    }
    suffix = iscodcaster ? "_codcaster" : "";
    state = 0;
    if (var_4bb78aa3) {
        state = 1;
    }
    if (var_c7fc4f01) {
        state = 2;
    }
    if (var_4bb78aa3 && var_c7fc4f01) {
        state = 3;
    }
    if (isdefined(level.othervisuals[zone_index])) {
        foreach (entid in level.othervisuals[zone_index]) {
            entity = getentbynum(local_client_num, entid);
            for (si = 0; si < 4; si++) {
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

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x28984287, Offset: 0x990
// Size: 0xf4
function function_df78674f(localclientnum) {
    if (isdefined(localclientnum) && isdefined(level.current_zone) && isdefined(level.current_state)) {
        setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
        if (isdefined(level.current_zone[localclientnum])) {
            obj_id = level.var_5ff510b[level.current_zone[localclientnum]];
            if (!isdefined(obj_id)) {
                obj_id = serverobjective_getobjective(localclientnum, #"hardpoint");
            }
            if (isdefined(obj_id)) {
                function_dd2493cc(localclientnum, obj_id);
            }
        }
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xac074393, Offset: 0xa90
// Size: 0x200
function function_64ffa588(*local_client_num) {
    effects = [];
    effects[#"zoneedgemarker"] = level._effect[#"zoneedgemarker"];
    effects[#"zoneedgemarkerwndw"] = level._effect[#"zoneedgemarkerwndw"];
    effects[#"zoneedgemarker"][1] = #"hash_682365220f952226";
    effects[#"zoneedgemarker"][2] = #"hash_5c0d472966d09d41";
    effects[#"zoneedgemarker"][3] = [];
    effects[#"zoneedgemarker"][3][1] = #"hash_3d943e08d321081c";
    effects[#"zoneedgemarker"][3][2] = #"hash_6328e922e5ef809f";
    effects[#"zoneedgemarkerwndw"][1] = #"hash_6bfa43a02f3672e3";
    effects[#"zoneedgemarkerwndw"][2] = #"hash_7e0524ef3f409d16";
    effects[#"zoneedgemarkerwndw"][3] = [];
    effects[#"zoneedgemarkerwndw"][3][1] = #"hash_252ee62d9ea8dcc9";
    effects[#"zoneedgemarkerwndw"][3][2] = #"hash_7495c7dec3ebf9dc";
    return effects;
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0xd34cc34b, Offset: 0xc98
// Size: 0xbc
function get_fx_state(local_client_num, state, var_b8fe9b52) {
    if (var_b8fe9b52) {
        return state;
    }
    if (state == 1) {
        if (function_9b3f0ed1(local_client_num) == #"allies") {
            return 1;
        } else {
            return 2;
        }
    } else if (state == 2) {
        if (function_9b3f0ed1(local_client_num) == #"axis") {
            return 1;
        } else {
            return 2;
        }
    }
    return state;
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0x2eb96b7e, Offset: 0xd60
// Size: 0x26
function get_fx(fx_name, fx_state, effects) {
    return effects[fx_name][fx_state];
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0xd1a08c3b, Offset: 0xd90
// Size: 0x304
function setup_hardpoint_fx(local_client_num, zone_index, state) {
    effects = [];
    if (codcaster::function_39bce377(local_client_num)) {
        effects = function_64ffa588(local_client_num);
    } else {
        effects[#"zoneedgemarker"] = level._effect[#"zoneedgemarker"];
        effects[#"zoneedgemarkerwndw"] = level._effect[#"zoneedgemarkerwndw"];
    }
    if (isdefined(level.hardpointfx[local_client_num])) {
        foreach (fx in level.hardpointfx[local_client_num]) {
            stopfx(local_client_num, fx);
        }
    }
    level.hardpointfx[local_client_num] = [];
    if (zone_index) {
        if (isdefined(level.visuals[zone_index])) {
            fx_state = get_fx_state(local_client_num, state, codcaster::function_b8fe9b52(local_client_num));
            foreach (visual in level.visuals[zone_index]) {
                if (!isdefined(visual.script_fxid)) {
                    continue;
                }
                fxid = get_fx(visual.script_fxid, fx_state, effects);
                if (isarray(fxid)) {
                    state = 1;
                    function_ca8ebccf(local_client_num, visual, fxid[state], state);
                    state = 2;
                    function_ca8ebccf(local_client_num, visual, fxid[state], state);
                    continue;
                }
                function_ca8ebccf(local_client_num, visual, fxid, state);
            }
        }
    }
    thread watch_for_team_change(local_client_num);
}

// Namespace koth/koth
// Params 4, eflags: 0x4
// Checksum 0xc339779c, Offset: 0x10a0
// Size: 0x13c
function private function_ca8ebccf(local_client_num, visual, fxid, state) {
    if (isdefined(visual.angles)) {
        forward = anglestoforward(visual.angles);
    } else {
        forward = (0, 0, 0);
    }
    fxhandle = playfx(local_client_num, fxid, visual.origin, forward);
    level.hardpointfx[local_client_num][level.hardpointfx[local_client_num].size] = fxhandle;
    if (isdefined(fxhandle)) {
        if (state == 1) {
            setfxteam(local_client_num, fxhandle, #"allies");
            return;
        }
        if (state == 2) {
            setfxteam(local_client_num, fxhandle, #"axis");
            return;
        }
        setfxteam(local_client_num, fxhandle, #"none");
    }
}

// Namespace koth/koth
// Params 7, eflags: 0x0
// Checksum 0xee82bd18, Offset: 0x11e8
// Size: 0x34c
function hardpoint(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (level.hardpoints.size == 0) {
        hardpoints = struct::get_array("koth_zone_center", "targetname");
        for (i = 0; i < hardpoints.size; i++) {
            point = hardpoints[i];
            level.hardpoints[point.script_index] = point;
            obj = serverobjective_getobjective(fieldname, "koth_" + point.script_index);
        }
        foreach (point in level.hardpoints) {
            level.visuals[point.script_index] = struct::get_array(point.target, "targetname");
        }
    }
    level.current_zone[fieldname] = bwastimejump;
    level.current_state[fieldname] = 0;
    iscodcaster = codcaster::function_b8fe9b52(fieldname);
    suffix = iscodcaster ? "_codcaster" : "";
    rob = level.var_117b4a3a[0] + suffix;
    if (isdefined(level.othervisuals[bwastimejump])) {
        foreach (ent_id in level.othervisuals[bwastimejump]) {
            entity = getentbynum(fieldname, ent_id);
            if (!entity function_d2503806(rob)) {
                entity playrenderoverridebundle(rob);
            }
            if (iscodcaster) {
                codcaster::function_773f6e31(fieldname, entity, rob, 0);
            }
        }
    }
    setup_hardpoint_fx(fieldname, level.current_zone[fieldname], level.current_state[fieldname]);
}

// Namespace koth/koth
// Params 7, eflags: 0x0
// Checksum 0xaec1b003, Offset: 0x1540
// Size: 0x23c
function function_e116df6c(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump != fieldname || !isdefined(self.script_index)) {
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
        iscodcaster = codcaster::function_b8fe9b52(binitialsnap);
        suffix = iscodcaster ? "_codcaster" : "";
        rob = level.var_117b4a3a[0] + suffix;
        if (!self function_d2503806(rob)) {
            self playrenderoverridebundle(rob);
        }
        if (iscodcaster) {
            codcaster::function_773f6e31(binitialsnap, self, rob, 0);
        }
    }
}

// Namespace koth/koth
// Params 7, eflags: 0x0
// Checksum 0xa6ee9cac, Offset: 0x1788
// Size: 0x94
function hardpoint_state(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump != level.current_state[fieldname]) {
        level.current_state[fieldname] = bwastimejump;
        setup_hardpoint_fx(fieldname, level.current_zone[fieldname], level.current_state[fieldname]);
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x8b573463, Offset: 0x1828
// Size: 0x84
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    thread setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
}

// Namespace koth/koth
// Params 7, eflags: 0x0
// Checksum 0xe98053f8, Offset: 0x18b8
// Size: 0x17c
function function_9e6c42f8(local_client_num, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (is_false(getgametypesetting(#"hash_4091f2d0019b1f4a"))) {
        return;
    }
    if (bwastimejump != fieldname) {
        if (!isdefined(level.var_ca06174)) {
            level.var_ca06174 = getentarray(binitialsnap, "koth_zone_trigger", "targetname");
        }
        level.var_ca06174 = arraycombine(level.var_ca06174, getentarray(binitialsnap, "koth_zone_trigger", "script_noteworthy"));
        for (i = 0; i < level.var_ca06174.size; i++) {
            if (i == bwastimejump) {
                level.var_ca06174[i] function_c06a8682(binitialsnap);
                continue;
            }
            level.var_ca06174[i] function_c6c4ce9f(binitialsnap);
        }
    }
}

