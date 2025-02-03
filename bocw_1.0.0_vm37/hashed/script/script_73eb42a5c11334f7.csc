#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\ping_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ping;

// Namespace ping/ping
// Params 0, eflags: 0x6
// Checksum 0x711026fc, Offset: 0x160
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"ping", &preinit, &init, undefined, undefined);
}

// Namespace ping/ping
// Params 0, eflags: 0x4
// Checksum 0xba5b56f0, Offset: 0x1b8
// Size: 0x40a
function private preinit() {
    setdvar(#"hash_1d7aa0dce875f0eb", 1);
    callback::on_ping(&on_ping);
    callback::function_78827e7f(&function_78827e7f);
    callback::function_56df655f(&function_2dd58893);
    callback::function_f8062bf(&function_2dd58893);
    callback::function_ed112c52(&function_2dd58893);
    callback::on_killcam_begin(&function_2dd58893);
    callback::on_killcam_end(&function_2dd58893);
    level.ping = spawnstruct();
    level.ping.types = [{#sound:#"hash_1a0de47f7204a9d6", #objective:#"teammate_waypoint"}, {#sound:#"hash_1a0de47f7204a9d6", #objective:#"enemy_waypoint"}, {#sound:#"uin_ping_enemy", #objective:#"enemy_waypoint"}, {#sound:#"uin_ping_enemy", #objective:#"hash_6ee59c4b375ac2ae"}, {#sound:#"hash_1a0de47f7204a9d6", #objective:#"hash_614502911ac7d29"}, {#sound:#"hash_1a0de47f7204a9d6"}, {#sound:#"uin_ping_enemy", #objective:#"hash_4aacdcc1899f9c59"}, {#sound:#"uin_ping_enemy", #objective:#"hash_4aacdcc1899f9c59"}, {#sound:#"hash_1a0de47f7204a9d6", #objective:#"hash_19b425c37cb9f718"}];
    assert(level.ping.types.size == 9);
    level.ping.var_19e1f40d = 0;
    level.ping.var_ea98b5ff = getgametypesetting(#"hash_5462586bdce0346e");
}

// Namespace ping/ping
// Params 0, eflags: 0x4
// Checksum 0x254bf150, Offset: 0x5d0
// Size: 0xbc
function private init() {
    level.var_907386c0 = [];
    for (i = 0; i < getmaxlocalclients(); i++) {
        level.var_907386c0[i] = [];
        for (j = 0; j < getdvarint(#"com_maxclients", 0); j++) {
            level.var_907386c0[i][j] = [];
        }
    }
    level thread function_c81ef836();
}

// Namespace ping/ping
// Params 1, eflags: 0x4
// Checksum 0x24291d9a, Offset: 0x698
// Size: 0x34
function private function_2dd58893(params) {
    if (isdefined(params.localclientnum)) {
        clear_all_pings(params.localclientnum);
    }
}

// Namespace ping/ping
// Params 0, eflags: 0x4
// Checksum 0xfad720ad, Offset: 0x6d8
// Size: 0x398
function private function_c81ef836() {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill(#"minimap_waypoint", #"clear_all_pings");
        local_client_num = waitresult.localclientnum;
        if (waitresult._notify == "minimap_waypoint") {
            if (is_true(waitresult.remove)) {
                function_40c4bce(local_client_num, 0, 1);
            } else {
                x = waitresult.xcoord;
                y = waitresult.ycoord;
                var_bfd46ccc = 2147483647;
                var_cfa5f67b = -2147483647;
                trace = bullettrace((x, y, var_bfd46ccc), (x, y, var_cfa5f67b), 0, self, 1);
                position = trace[#"position"];
                if (trace[#"fraction"] == 1) {
                    position = (position[0], position[1], 0);
                }
                if (true) {
                    params = {#eventtype:0, #remove:0, #uniqueid:-1, #var_a0bf56ac:waitresult.clientnum, #var_89c7e02:getentbynum(local_client_num, waitresult.clientnum), #location:position, #localclientnum:local_client_num, #var_dcc5aade:1};
                    function_78827e7f(params);
                }
                function_40c4bce(local_client_num, 0, 0, position);
            }
            continue;
        }
        if (waitresult._notify == "clear_all_pings") {
            if (true) {
                player_ent = function_5c10bd79(local_client_num);
                params = {#eventtype:10, #remove:1, #var_a0bf56ac:waitresult.clientnum, #var_89c7e02:function_5c10bd79(local_client_num), #localclientnum:local_client_num, #var_dcc5aade:1};
                function_78827e7f(params);
            }
            function_40c4bce(local_client_num, 10, 1);
        }
    }
}

// Namespace ping/ping
// Params 1, eflags: 0x4
// Checksum 0x11e75549, Offset: 0xa78
// Size: 0x6b4
function private on_ping(params) {
    local_client_num = params.localclientnum;
    event_type = 0;
    param = undefined;
    remove = 0;
    if (isdefined(level.var_38c7030b)) {
        shoulddisable = [[ level.var_38c7030b ]](local_client_num);
        if (shoulddisable) {
            return;
        }
    }
    if (isdefined(params.var_44a5df)) {
        if (isdefined(level.var_a0b1f787[params.var_44a5df.model]) && !isdefined(params.var_44a5df.var_fc558e74)) {
            params.var_44a5df.var_fc558e74 = level.var_a0b1f787[params.var_44a5df.model];
        }
        if (isdefined(params.var_44a5df.var_fc558e74)) {
            event_type = 8;
            handled = 1;
        } else if (params.var_89c7e02.team != params.var_44a5df.team && params.var_44a5df.team != #"none" && params.var_44a5df.team != #"neutral") {
            if (params.var_44a5df isplayer()) {
                event_type = 2;
            } else {
                event_type = 3;
            }
            handled = 1;
        } else if (params.var_89c7e02.team === params.var_44a5df.team && !params.var_44a5df isplayer()) {
            event_type = 6;
            handled = 1;
        } else if (params.var_44a5df.team == #"none" || params.var_44a5df.team == #"neutral") {
            event_type = 7;
            handled = 1;
        }
        if (is_true(handled)) {
            param = params.var_44a5df getentitynumber();
        }
    }
    if (!is_true(handled) && is_true(params.danger)) {
        event_type = 1;
        handled = 1;
    }
    if (!is_true(handled) && params.objectiveid != -1) {
        param = params.objectiveid;
        var_d0b9da93 = undefined;
        foreach (client_num, pings in level.var_907386c0[local_client_num]) {
            foreach (var_20da58f9 in pings) {
                index = array::find(var_20da58f9, param, &function_929e2988);
                if (isdefined(index)) {
                    var_d0b9da93 = var_20da58f9[index];
                    event_type = var_d0b9da93.event_type;
                    break;
                }
            }
            if (isdefined(var_d0b9da93)) {
                break;
            }
        }
        if (isdefined(var_d0b9da93)) {
            if (client_num == params.clientnum) {
                remove = 1;
            } else {
                event_type = 9;
                remove = array::contains(var_d0b9da93.var_f1bdc795, params.clientnum);
                param = var_d0b9da93.unique_id;
            }
            handled = 1;
        } else if (param <= 63) {
            event_type = 5;
            handled = 1;
        } else {
            println("<dev string:x38>");
            return;
        }
    }
    loc = params.location;
    if (!is_true(handled)) {
        itemworld = function_6ebaaf97(params.localclientnum);
        if (isdefined(itemworld)) {
            param = isdefined(itemworld.networkid) ? itemworld.networkid : itemworld.id;
            loc = itemworld.origin;
            event_type = 4;
            handled = 1;
        }
    }
    if (true) {
        if (event_type < 9) {
            var_237e3e32 = structcopy(params);
            var_237e3e32.eventtype = event_type;
            var_237e3e32.param = param;
            var_237e3e32.remove = remove;
            var_237e3e32.uniqueid = -1;
            var_237e3e32.var_a0bf56ac = var_237e3e32.var_89c7e02 getentitynumber();
            var_237e3e32.var_dcc5aade = 1;
            var_237e3e32.location = loc;
            function_78827e7f(var_237e3e32);
        }
    }
    function_40c4bce(params.localclientnum, event_type, remove, loc, param);
}

// Namespace ping/ping
// Params 1, eflags: 0x4
// Checksum 0x1eae8f10, Offset: 0x1138
// Size: 0x76
function private function_da96be68(params) {
    if (isdefined(level.var_be4583aa.var_2e3efdda)) {
        items = [[ level.var_be4583aa.var_2e3efdda ]](params.location, undefined, 1, 20);
        if (isdefined(items[0])) {
            return items[0].id;
        }
    }
    return undefined;
}

// Namespace ping/ping
// Params 1, eflags: 0x4
// Checksum 0xca2229d1, Offset: 0x11b8
// Size: 0x42
function private function_6ebaaf97(localclientnum) {
    if (!isdefined(level.var_be4583aa.var_9b71de90)) {
        return undefined;
    }
    return [[ level.var_be4583aa.var_9b71de90 ]](localclientnum);
}

// Namespace ping/ping
// Params 1, eflags: 0x4
// Checksum 0xb0d8f620, Offset: 0x1208
// Size: 0x48a
function private function_78827e7f(params) {
    var_56bcf423 = params.var_89c7e02;
    var_ec31db0f = params.var_a0bf56ac;
    location = params.location;
    event_type = params.eventtype;
    param = params.param;
    local_client_num = params.localclientnum;
    remove = params.remove;
    unique_id = params.uniqueid;
    var_dcc5aade = is_true(params.var_dcc5aade);
    currentplayer = function_5c10bd79(local_client_num);
    var_df55840 = currentplayer == var_56bcf423 && !var_dcc5aade;
    var_d09a35d4 = remove ? var_dcc5aade ? 2 : 1 : 0;
    if (1 && var_df55840 && event_type < 9 && !remove) {
        var_638e268e = function_5947d757(event_type);
        var_20da58f9 = level.var_907386c0[local_client_num][var_ec31db0f][var_638e268e];
        if (isdefined(var_20da58f9)) {
            foreach (ping in var_20da58f9) {
                if (ping.unique_id === -1) {
                    ping.unique_id = unique_id;
                }
            }
        }
        return;
    }
    if (event_type < 9 && currentplayer == var_56bcf423 && !remove) {
        playsound(local_client_num, level.ping.types[event_type].sound);
    }
    switch (event_type) {
    case 0:
    case 1:
    case 2:
        function_d5a244dc(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, param, var_d09a35d4);
        break;
    case 3:
    case 6:
    case 7:
        function_afdaea76(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, param, var_d09a35d4);
        break;
    case 4:
        function_a5de4bd1(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, param, var_d09a35d4);
        break;
    case 5:
        function_35dba327(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, param, var_d09a35d4);
        break;
    case 8:
        function_83751d93(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, param, var_d09a35d4);
        break;
    case 9:
        function_f2e6b227(local_client_num, unique_id, event_type, var_56bcf423, var_ec31db0f, param, var_d09a35d4);
        break;
    case 10:
        if (0 || !var_df55840) {
            function_892476d5(local_client_num, var_ec31db0f);
        }
        break;
    }
}

// Namespace ping/ping
// Params 9, eflags: 0x4
// Checksum 0x11cd76a, Offset: 0x16a0
// Size: 0x2fc
function private function_85bffd7c(local_client_num, event_type, location, clientnum, objective_id, var_fc97ceec, offsetz, var_c039614d, var_d09a35d4) {
    model = function_1df4c3b0(local_client_num, #"ping_system");
    setuimodelvalue(getuimodel(model, "type"), event_type);
    setuimodelvalue(getuimodel(model, "clientNum"), isdefined(clientnum) ? clientnum : -1);
    setuimodelvalue(getuimodel(model, "objectiveId"), isdefined(objective_id) ? objective_id : -1);
    setuimodelvalue(getuimodel(model, "remove"), (isdefined(var_d09a35d4) ? var_d09a35d4 : 0) != 0);
    setuimodelvalue(getuimodel(model, "locationX"), isdefined(location[0]) ? location[0] : 0);
    setuimodelvalue(getuimodel(model, "locationY"), isdefined(location[1]) ? location[1] : 0);
    setuimodelvalue(getuimodel(model, "customText"), isdefined(var_fc97ceec) ? var_fc97ceec : #"");
    setuimodelvalue(getuimodel(model, "offsetZ"), isdefined(offsetz) ? offsetz : 0);
    setuimodelvalue(getuimodel(model, "customImage"), isdefined(var_c039614d) ? var_c039614d : #"");
    forcenotifyuimodel(getuimodel(model, "notify"));
}

// Namespace ping/ping
// Params 2, eflags: 0x4
// Checksum 0x999a9371, Offset: 0x19a8
// Size: 0xce
function private function_daee0412(local_client_num, player) {
    if (level.ping.var_ea98b5ff === 1) {
        switch (player function_b0c2768d()) {
        case 1:
            return 20;
        case 2:
            return 21;
        case 3:
            return 22;
        case 4:
            return 23;
        }
    }
    if (player getlocalclientnumber() === local_client_num) {
        return 6;
    }
    return 3;
}

// Namespace ping/ping
// Params 5, eflags: 0x4
// Checksum 0x334a4a4d, Offset: 0x1a80
// Size: 0x8c
function private function_5300c425(local_client_num, var_56bcf423, var_ccdb199a, var_c232a3ca, var_c3fe48ea) {
    color = function_daee0412(local_client_num, var_56bcf423);
    function_c79ecd60(local_client_num, var_56bcf423 getplayername(), color, undefined, var_ccdb199a, undefined, undefined, var_c232a3ca, var_c3fe48ea);
}

// Namespace ping/ping
// Params 4, eflags: 0x4
// Checksum 0xe6b856bf, Offset: 0x1b18
// Size: 0x104
function private function_9be72061(local_client_num, obj_id, ent, n_seconds) {
    if (!isdefined(obj_id) || !isdefined(ent) || !isdefined(n_seconds)) {
        return;
    }
    level endon(#"game_ended");
    level notify(obj_id + "_end_follow_ent");
    level endon(obj_id + "_end_follow_ent");
    level endon(obj_id + "_removed");
    objective_onentity(local_client_num, obj_id, ent, 0, 0, 0);
    wait n_seconds;
    objective_clearentity(local_client_num, obj_id);
    if (isdefined(ent)) {
        objective_setposition(local_client_num, obj_id, ent.origin);
    }
}

// Namespace ping/ping
// Params 3, eflags: 0x0
// Checksum 0x4a166a52, Offset: 0x1c28
// Size: 0xf4
function function_bcb7d0e7(local_client_num, var_ec31db0f, ping) {
    assert(isdefined(ping));
    if (ping.event_type != 5 && ping.obj_id >= 64) {
        clientobjid = ping.obj_id - 64;
        level notify(clientobjid + "_removed");
        objective_delete(local_client_num, clientobjid);
        util::releaseobjid(local_client_num, clientobjid);
    }
    function_85bffd7c(local_client_num, ping.event_type, undefined, var_ec31db0f, ping.obj_id, undefined, undefined, undefined, 1);
}

// Namespace ping/ping
// Params 3, eflags: 0x4
// Checksum 0xe5f85f3c, Offset: 0x1d28
// Size: 0xd0
function private function_ccc05112(local_client_num, var_ec31db0f, var_638e268e) {
    foreach (ping in level.var_907386c0[local_client_num][var_ec31db0f][var_638e268e]) {
        function_bcb7d0e7(local_client_num, var_ec31db0f, ping);
    }
    level.var_907386c0[local_client_num][var_ec31db0f][var_638e268e] = undefined;
}

// Namespace ping/ping
// Params 3, eflags: 0x4
// Checksum 0x1330a2b, Offset: 0x1e00
// Size: 0xc4
function private function_807b75f0(local_client_num, var_ec31db0f, event_type) {
    var_869573d5 = function_5947d757(event_type);
    var_20da58f9 = level.var_907386c0[local_client_num][var_ec31db0f][var_869573d5];
    if (isdefined(var_20da58f9) && var_20da58f9.size >= function_44806bba(event_type)) {
        ping = array::pop_front(var_20da58f9, 0);
        function_bcb7d0e7(local_client_num, var_ec31db0f, ping);
    }
}

// Namespace ping/ping
// Params 2, eflags: 0x4
// Checksum 0xa32d46a9, Offset: 0x1ed0
// Size: 0x24
function private function_935e5b46(ping, unique_id) {
    return ping.unique_id === unique_id;
}

// Namespace ping/ping
// Params 2, eflags: 0x4
// Checksum 0x7b178036, Offset: 0x1f00
// Size: 0x24
function private function_929e2988(ping, obj_id) {
    return ping.obj_id === obj_id;
}

// Namespace ping/ping
// Params 6, eflags: 0x4
// Checksum 0xbda1b8c7, Offset: 0x1f30
// Size: 0x11c
function private function_2084e2d9(local_client_num, var_ec31db0f, event_type, var_398c2dad, var_1433567e, *var_d4b54312) {
    var_869573d5 = function_5947d757(var_398c2dad);
    var_20da58f9 = level.var_907386c0[var_ec31db0f][event_type][var_869573d5];
    if (isdefined(var_20da58f9)) {
        index = array::find(var_20da58f9, var_d4b54312, var_1433567e);
        if (isdefined(index)) {
            ping = var_20da58f9[index];
            if (var_20da58f9.size == 1) {
                level.var_907386c0[var_ec31db0f][event_type][var_869573d5] = undefined;
            } else {
                array::pop(var_20da58f9, index, 0);
            }
            function_bcb7d0e7(var_ec31db0f, event_type, ping);
        }
    }
}

// Namespace ping/ping
// Params 4, eflags: 0x4
// Checksum 0xe11d4f71, Offset: 0x2058
// Size: 0x54
function private function_e0180998(local_client_num, var_ec31db0f, event_type, obj_id) {
    function_2084e2d9(local_client_num, var_ec31db0f, event_type, &function_929e2988, obj_id, 0);
}

// Namespace ping/ping
// Params 5, eflags: 0x4
// Checksum 0xc57cbf24, Offset: 0x20b8
// Size: 0x84
function private function_1544c7f4(local_client_num, var_56bcf423, var_ec31db0f, event_type, unique_id) {
    var_421f350 = function_5c10bd79(local_client_num) == var_56bcf423;
    function_2084e2d9(local_client_num, var_ec31db0f, event_type, &function_935e5b46, unique_id, var_421f350);
}

// Namespace ping/ping
// Params 11, eflags: 0x4
// Checksum 0x3ee0a36c, Offset: 0x2148
// Size: 0x2ce
function private function_1793cfaf(local_client_num, unique_id, var_56bcf423, var_ec31db0f, event_type, location, objective_type, var_ccdb199a, var_c232a3ca, var_c3fe48ea, follow_ent = undefined) {
    obj_id = util::getnextobjid(local_client_num);
    var_6d305537 = {#obj_id:obj_id + 64, #unique_id:unique_id, #var_f1bdc795:[], #var_c232a3ca:var_c232a3ca, #var_c3fe48ea:var_c3fe48ea, #event_type:event_type, #var_638e268e:function_5947d757(event_type)};
    if (!isdefined(level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e])) {
        level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e] = [];
    } else if (!isarray(level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e])) {
        level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e] = array(level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e]);
    }
    level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e][level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e].size] = var_6d305537;
    objective_add(local_client_num, obj_id, "active", objective_type, location, #"none", var_ec31db0f);
    function_2e625a75(local_client_num, obj_id, 1);
    if (isdefined(follow_ent)) {
        level thread function_9be72061(local_client_num, obj_id, follow_ent, 4);
    }
    if (isdefined(var_c232a3ca) && var_c232a3ca != #"") {
        function_5300c425(local_client_num, var_56bcf423, var_ccdb199a, var_c232a3ca, var_c3fe48ea);
    }
    return obj_id + 64;
}

// Namespace ping/ping
// Params 8, eflags: 0x4
// Checksum 0xe37290be, Offset: 0x2420
// Size: 0x26c
function private function_d5a244dc(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, var_d4f0ac6e, var_d09a35d4) {
    if (var_d09a35d4 == 2) {
        function_e0180998(local_client_num, var_ec31db0f, event_type, var_d4f0ac6e);
    } else if (var_d09a35d4 == 1) {
        function_1544c7f4(local_client_num, var_56bcf423, var_ec31db0f, event_type, unique_id);
    } else {
        function_807b75f0(local_client_num, var_ec31db0f, event_type);
        follow_ent = undefined;
        if (event_type == 2 && isdefined(var_d4f0ac6e)) {
            ent = getentbynum(local_client_num, var_d4f0ac6e);
            if (isdefined(ent)) {
                location = ent.origin;
                if (!ent isplayer() || level.ping.var_19e1f40d) {
                    follow_ent = ent;
                }
            }
        }
        zonename = undefined;
        if (isdefined(level.var_d6c4af7f)) {
            zonename = [[ level.var_d6c4af7f ]](location);
        }
        if (event_type == 2 || event_type == 1) {
            var_3695f891 = isdefined(zonename) ? zonename : #"hash_1e32ad8efd3bd291";
        } else {
            var_3695f891 = isdefined(zonename) ? zonename : #"hash_18b0d1618dc96364";
        }
        obj_id = function_1793cfaf(local_client_num, unique_id, var_56bcf423, var_ec31db0f, event_type, location, level.ping.types[event_type].objective, #"hash_5052920a34135f31", var_3695f891, undefined, follow_ent);
    }
    function_85bffd7c(local_client_num, event_type, location, var_ec31db0f, obj_id, undefined, undefined, undefined, var_d09a35d4);
}

// Namespace ping/ping
// Params 8, eflags: 0x4
// Checksum 0x39ecbdc, Offset: 0x2698
// Size: 0x244
function private function_afdaea76(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, var_d4f0ac6e, var_d09a35d4) {
    var_b2f64e7 = undefined;
    if (var_d09a35d4 == 2) {
        function_e0180998(local_client_num, var_ec31db0f, event_type, var_d4f0ac6e);
    } else if (var_d09a35d4 == 1) {
        function_1544c7f4(local_client_num, var_56bcf423, var_ec31db0f, event_type, unique_id);
    } else {
        function_807b75f0(local_client_num, var_ec31db0f, event_type);
        ent = getentbynum(local_client_num, var_d4f0ac6e);
        if (isdefined(ent)) {
            location = ent.origin;
            if (ent isvehicle()) {
                name = ent.displayname;
                image = ent.var_c95558ce;
            } else if (isdefined(ent.weapon)) {
                name = ent.weapon.displayname;
                image = ent.weapon.var_c95558ce;
            }
            var_166a2084 = ent getpointinbounds(0, 0, 1);
            var_b2f64e7 = var_166a2084[2] - location[2];
        }
        obj_id = function_1793cfaf(local_client_num, unique_id, var_56bcf423, var_ec31db0f, event_type, location, level.ping.types[event_type].objective, #"hash_5052920a34135f31", name, undefined, ent);
    }
    function_85bffd7c(local_client_num, event_type, location, var_ec31db0f, obj_id, name, var_b2f64e7, image, var_d09a35d4);
}

// Namespace ping/ping
// Params 8, eflags: 0x4
// Checksum 0x172cbe27, Offset: 0x28e8
// Size: 0x1b4
function private function_a5de4bd1(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, var_113c24cb, var_d09a35d4) {
    if (var_d09a35d4 == 2) {
        function_e0180998(local_client_num, var_ec31db0f, event_type, var_113c24cb);
    } else if (var_d09a35d4 == 1) {
        function_1544c7f4(local_client_num, var_56bcf423, var_ec31db0f, event_type, unique_id);
    } else {
        function_807b75f0(local_client_num, var_ec31db0f, event_type);
        item = function_b1702735(var_113c24cb);
        if (isdefined(item)) {
            item_name = item_world::get_item_name(item.itementry);
            item_image = item_world::function_6fe428b3(item.itementry);
        }
        obj_id = function_1793cfaf(local_client_num, unique_id, var_56bcf423, var_ec31db0f, event_type, location, level.ping.types[event_type].objective, #"hash_7eae2f9838aa52cf", item_name, undefined);
    }
    function_85bffd7c(local_client_num, event_type, location, var_ec31db0f, obj_id, item_name, undefined, item_image, var_d09a35d4);
}

// Namespace ping/ping
// Params 8, eflags: 0x4
// Checksum 0x1ac02335, Offset: 0x2aa8
// Size: 0x30c
function private function_35dba327(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, obj_id, var_d09a35d4) {
    if (var_d09a35d4 != 0) {
        function_e0180998(local_client_num, var_ec31db0f, event_type, obj_id);
        return;
    }
    function_807b75f0(local_client_num, var_ec31db0f, event_type);
    function_85bffd7c(local_client_num, event_type, location, var_ec31db0f, obj_id, undefined, undefined, undefined, var_d09a35d4);
    var_55b682f2 = function_288ec082(local_client_num, obj_id);
    var_ec131a0a = function_a00c5167(local_client_num, obj_id);
    var_c3fe48ea = undefined;
    if (var_ec131a0a == #"friendly") {
        var_c3fe48ea = 3;
    } else if (var_ec131a0a == #"neutral") {
        var_c3fe48ea = 0;
    } else {
        var_c3fe48ea = 0;
    }
    var_6d305537 = {#obj_id:obj_id, #unique_id:unique_id, #var_f1bdc795:[], #var_c232a3ca:var_55b682f2, #var_c3fe48ea:var_c3fe48ea, #event_type:event_type, #var_638e268e:function_5947d757(event_type)};
    if (!isdefined(level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e])) {
        level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e] = [];
    } else if (!isarray(level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e])) {
        level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e] = array(level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e]);
    }
    level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e][level.var_907386c0[local_client_num][var_ec31db0f][var_6d305537.var_638e268e].size] = var_6d305537;
    if (var_55b682f2 != #"") {
        function_5300c425(local_client_num, var_56bcf423, #"hash_5052920a34135f31", var_55b682f2, undefined);
    }
}

// Namespace ping/ping
// Params 8, eflags: 0x4
// Checksum 0x5554a608, Offset: 0x2dc0
// Size: 0x22c
function private function_83751d93(local_client_num, unique_id, event_type, location, var_56bcf423, var_ec31db0f, var_d4f0ac6e, var_d09a35d4) {
    var_b2f64e7 = undefined;
    name = undefined;
    image = undefined;
    if (var_d09a35d4 == 2) {
        function_e0180998(local_client_num, var_ec31db0f, event_type, var_d4f0ac6e);
    } else if (var_d09a35d4 == 1) {
        function_1544c7f4(local_client_num, var_56bcf423, var_ec31db0f, event_type, unique_id);
    } else {
        function_807b75f0(local_client_num, var_ec31db0f, event_type);
        ent = getentbynum(local_client_num, var_d4f0ac6e);
        if (isdefined(ent)) {
            location = ent.origin;
            name = isdefined(level.var_2d1b0ac[ent.var_fc558e74]) ? level.var_2d1b0ac[ent.var_fc558e74] : undefined;
            image = undefined;
            var_166a2084 = ent getpointinbounds(0, 0, 1);
            var_b2f64e7 = var_166a2084[2] - location[2];
        }
        obj_id = function_1793cfaf(local_client_num, unique_id, var_56bcf423, var_ec31db0f, event_type, location, level.ping.types[event_type].objective, #"hash_5052920a34135f31", name, undefined, ent);
    }
    function_85bffd7c(local_client_num, event_type, location, var_ec31db0f, obj_id, name, undefined, image, var_d09a35d4);
}

// Namespace ping/ping
// Params 7, eflags: 0x4
// Checksum 0xcb6c80b1, Offset: 0x2ff8
// Size: 0x2cc
function private function_f2e6b227(local_client_num, *unique_id, event_type, var_56bcf423, var_ec31db0f, var_5172fec0, var_d09a35d4) {
    foreach (client_num, pings in level.var_907386c0[unique_id]) {
        if (client_num == var_ec31db0f) {
            continue;
        }
        foreach (var_20da58f9 in pings) {
            index = array::find(var_20da58f9, var_5172fec0, &function_935e5b46);
            if (isdefined(index)) {
                var_d0b9da93 = var_20da58f9[index];
                break;
            }
        }
        if (isdefined(var_d0b9da93)) {
            break;
        }
    }
    if (isdefined(var_d0b9da93)) {
        index = array::find(var_d0b9da93.var_f1bdc795, var_ec31db0f);
        if (var_d09a35d4 != 0 && isdefined(index)) {
            array::remove_index(var_d0b9da93.var_f1bdc795, index);
            var_834e72f6 = 1;
        } else if (var_d09a35d4 == 0 && !isdefined(index)) {
            array::add(var_d0b9da93.var_f1bdc795, var_ec31db0f);
            var_834e72f6 = 1;
            if (isdefined(var_d0b9da93.var_c232a3ca) && var_d0b9da93.var_c232a3ca != #"") {
                function_5300c425(unique_id, var_56bcf423, #"hash_417da90934e51345", var_d0b9da93.var_c232a3ca, undefined);
            }
        }
        if (is_true(var_834e72f6)) {
            function_85bffd7c(unique_id, event_type, undefined, var_ec31db0f, var_d0b9da93.obj_id, undefined, undefined, undefined, var_d09a35d4);
        }
    }
}

// Namespace ping/ping
// Params 2, eflags: 0x4
// Checksum 0x9f408d7f, Offset: 0x32d0
// Size: 0xb8
function private function_892476d5(local_client_num, var_ec31db0f) {
    foreach (var_638e268e in getarraykeys(level.var_907386c0[local_client_num][var_ec31db0f])) {
        function_ccc05112(local_client_num, var_ec31db0f, var_638e268e);
    }
}

// Namespace ping/ping
// Params 1, eflags: 0x4
// Checksum 0x88e8a362, Offset: 0x3390
// Size: 0xa0
function private clear_all_pings(local_client_num) {
    foreach (clientnum, var_3866572e in level.var_907386c0[local_client_num]) {
        function_892476d5(local_client_num, clientnum);
    }
}

