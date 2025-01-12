#using script_3dfd071e58d0071f;
#using script_45fdb6cec5580007;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace ping;

// Namespace ping/ping
// Params 0, eflags: 0x6
// Checksum 0xaecb9f33, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ping", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace ping/ping
// Params 0, eflags: 0x5 linked
// Checksum 0x2c8c67c2, Offset: 0xd0
// Size: 0x1d4
function private function_70a657d8() {
    if (!getdvarint(#"hash_449fa75f87a4b5b4", 0)) {
        return;
    }
    level.ping = {#players:[], #count:0, #var_92963150:[], #durations:[10, 10, 10, 15, 20, 30, 15, 15, 25]};
    assert(level.ping.durations.size == 9);
    callback::on_ping(&on_ping);
    callback::on_disconnect(&on_disconnect);
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&on_player_spawn);
    callback::on_death(&function_d58bf295);
    callback::on_end_game(&on_end_game);
    level thread update();
}

// Namespace ping/ping
// Params 0, eflags: 0x5 linked
// Checksum 0xa6dadf0d, Offset: 0x2b0
// Size: 0x2c
function private function_77d2f4f5() {
    return level.ping.players[self getentitynumber()];
}

// Namespace ping/ping
// Params 0, eflags: 0x5 linked
// Checksum 0x34dc3571, Offset: 0x2e8
// Size: 0x2c
function private function_76fbd527() {
    level.ping.players[self getentitynumber()] = [];
}

// Namespace ping/ping
// Params 0, eflags: 0x5 linked
// Checksum 0xe2299e1e, Offset: 0x320
// Size: 0x72
function private function_9c9adcf1() {
    pingplayers = undefined;
    if (squads::function_a9758423() && isdefined(self.squad)) {
        pingplayers = function_c65231e2(self.squad);
    } else {
        pingplayers = getfriendlyplayers(self.team);
    }
    return pingplayers;
}

// Namespace ping/ping
// Params 0, eflags: 0x5 linked
// Checksum 0xc750a0f5, Offset: 0x3a0
// Size: 0x14c
function private function_68ee7643() {
    var_92963150 = self function_77d2f4f5();
    entnum = self getentitynumber();
    if (isdefined(var_92963150)) {
        foreach (ping in level.ping.var_92963150) {
            if (entnum == ping.playerentnum) {
                function_aa50d3e4(ping);
            }
        }
        self function_b56144ae(self function_9c9adcf1(), 1, 10, (0, 0, 0));
        level.ping.players[self getentitynumber()] = undefined;
    }
}

// Namespace ping/ping
// Params 0, eflags: 0x5 linked
// Checksum 0x30636ffc, Offset: 0x4f8
// Size: 0xf0
function private clear_all_pings() {
    foreach (ping in level.ping.var_92963150) {
        ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
        function_aa50d3e4(ping);
    }
}

// Namespace ping/ping
// Params 0, eflags: 0x1 linked
// Checksum 0xb0487547, Offset: 0x5f0
// Size: 0x44
function on_player_spawn() {
    var_92963150 = self function_77d2f4f5();
    if (!isdefined(var_92963150)) {
        self function_76fbd527();
    }
}

// Namespace ping/ping
// Params 1, eflags: 0x1 linked
// Checksum 0x578f852e, Offset: 0x640
// Size: 0x3c
function on_joined_team(*params) {
    self function_68ee7643();
    self function_76fbd527();
}

// Namespace ping/ping
// Params 0, eflags: 0x1 linked
// Checksum 0xdfe3c6bd, Offset: 0x688
// Size: 0x1c
function on_disconnect() {
    self function_68ee7643();
}

// Namespace ping/ping
// Params 0, eflags: 0x1 linked
// Checksum 0xba0df2fc, Offset: 0x6b0
// Size: 0x14
function on_end_game() {
    clear_all_pings();
}

// Namespace ping/ping
// Params 1, eflags: 0x1 linked
// Checksum 0xe79a47e8, Offset: 0x6d0
// Size: 0x158
function function_d58bf295(*params) {
    foreach (ping in level.ping.var_92963150) {
        if (ping.eventtype != 2 && ping.eventtype != 3) {
            continue;
        }
        entnum = self getentitynumber();
        if (ping.param != entnum) {
            continue;
        }
        ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
        function_aa50d3e4(ping);
    }
}

// Namespace ping/ping
// Params 4, eflags: 0x5 linked
// Checksum 0x7d2af952, Offset: 0x830
// Size: 0x30e
function private function_c5f0d88f(player, eventtype, location, param) {
    pool = function_5947d757(eventtype);
    ping = spawnstruct();
    ping.player = player;
    ping.playerentnum = player getentitynumber();
    ping.eventtype = eventtype;
    ping.var_a1e081ad = pool;
    ping.location = location;
    ping.param = param;
    assert(isdefined(level.ping.durations[eventtype]));
    ping.expiration = gettime() + int(level.ping.durations[eventtype] * 1000);
    ping.id = level.ping.count;
    var_6e071234 = player function_77d2f4f5();
    assert(isdefined(var_6e071234));
    if (isdefined(var_6e071234[pool]) && var_6e071234[pool].size >= function_44806bba(eventtype)) {
        function_aa50d3e4(var_6e071234[pool][0]);
    }
    assert(!isdefined(level.ping.var_92963150[ping.id]));
    if (isdefined(level.ping.var_92963150[ping.id])) {
        function_aa50d3e4(level.ping.var_92963150[ping.id]);
    }
    level.ping.var_92963150[ping.id] = ping;
    level.ping.count++;
    if (level.ping.count >= 16384) {
        level.ping.count = 0;
    }
    if (!isdefined(var_6e071234[pool])) {
        var_6e071234[pool] = [];
    } else if (!isarray(var_6e071234[pool])) {
        var_6e071234[pool] = array(var_6e071234[pool]);
    }
    var_6e071234[pool][var_6e071234[pool].size] = ping;
    return ping;
}

// Namespace ping/ping
// Params 1, eflags: 0x5 linked
// Checksum 0x17216168, Offset: 0xb48
// Size: 0x154
function private function_aa50d3e4(ping) {
    assert(isdefined(level.ping.var_92963150[ping.id]));
    level.ping.var_92963150[ping.id] = undefined;
    assert(isdefined(level.ping.players[ping.playerentnum][ping.var_a1e081ad]));
    var_2d64756e = level.ping.players[ping.playerentnum][ping.var_a1e081ad];
    index = array::find(var_2d64756e, ping);
    assert(isdefined(index));
    if (var_2d64756e.size == 1) {
        level.ping.players[ping.playerentnum][ping.var_a1e081ad] = undefined;
        return;
    }
    array::pop(var_2d64756e, index, 0);
}

// Namespace ping/ping
// Params 2, eflags: 0x5 linked
// Checksum 0x73f3f8d2, Offset: 0xca8
// Size: 0x24
function private function_220a4754(ping, param) {
    return ping.param === param;
}

// Namespace ping/ping
// Params 3, eflags: 0x5 linked
// Checksum 0x3dccc393, Offset: 0xcd8
// Size: 0xf8
function private function_cff0c866(player, event_type, param) {
    var_6e071234 = player function_77d2f4f5();
    pool = function_5947d757(event_type);
    assert(isdefined(var_6e071234));
    if (isdefined(var_6e071234[pool])) {
        index = array::find(var_6e071234[pool], param, &function_220a4754);
        if (isdefined(index)) {
            ping = var_6e071234[pool][index];
            function_aa50d3e4(ping);
        }
    }
    return ping;
}

// Namespace ping/ping
// Params 1, eflags: 0x5 linked
// Checksum 0xc453ce2b, Offset: 0xdd8
// Size: 0x16c
function private on_ping(params) {
    player = params.player;
    eventtype = params.type;
    remove = params.remove;
    param = params.param;
    location = params.location;
    assert(isdefined(eventtype));
    if (eventtype < 9) {
        if (remove) {
            ping = function_cff0c866(player, eventtype, param);
        } else {
            ping = function_c5f0d88f(player, eventtype, location, param);
        }
        id = ping.id;
        if (isdefined(id)) {
            player function_b56144ae(player function_9c9adcf1(), eventtype, remove, location, param, id);
        }
        return;
    }
    player function_b56144ae(player function_9c9adcf1(), eventtype, remove, location, param);
}

// Namespace ping/ping
// Params 0, eflags: 0x5 linked
// Checksum 0x8a443613, Offset: 0xf50
// Size: 0x122
function private update() {
    while (true) {
        time = gettime();
        foreach (ping in level.ping.var_92963150) {
            if (ping.expiration < time) {
                ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
                function_aa50d3e4(ping);
            }
        }
        wait 1;
    }
}

