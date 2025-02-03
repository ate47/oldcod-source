#using script_45fdb6cec5580007;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\ping_shared;
#using scripts\core_common\system_shared;

#namespace ping;

// Namespace ping/ping
// Params 0, eflags: 0x6
// Checksum 0x67f375fd, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ping", &preinit, undefined, undefined, undefined);
}

// Namespace ping/ping
// Params 0, eflags: 0x4
// Checksum 0x94124ed8, Offset: 0xd0
// Size: 0x1fc
function private preinit() {
    setdvar(#"hash_1d7aa0dce875f0eb", 1);
    if (!getdvarint(#"hash_449fa75f87a4b5b4", 0)) {
        return;
    }
    level.ping = {#players:[], #count:0, #pings:[], #durations:[10, 10, 10, 15, 20, 30, 15, 15, 25]};
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
// Params 0, eflags: 0x4
// Checksum 0xcccdaf2b, Offset: 0x2d8
// Size: 0x2c
function private function_77d2f4f5() {
    return level.ping.players[self getentitynumber()];
}

// Namespace ping/ping
// Params 0, eflags: 0x4
// Checksum 0x2729120, Offset: 0x310
// Size: 0x2c
function private function_76fbd527() {
    level.ping.players[self getentitynumber()] = [];
}

// Namespace ping/ping
// Params 0, eflags: 0x4
// Checksum 0x4a23ad5e, Offset: 0x348
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
// Params 0, eflags: 0x4
// Checksum 0xff80482, Offset: 0x3c8
// Size: 0x14c
function private function_68ee7643() {
    pings = self function_77d2f4f5();
    entnum = self getentitynumber();
    if (isdefined(pings)) {
        foreach (ping in level.ping.pings) {
            if (entnum == ping.playerentnum) {
                function_aa50d3e4(ping);
            }
        }
        self function_b56144ae(self function_9c9adcf1(), 1, 10, (0, 0, 0));
        level.ping.players[self getentitynumber()] = undefined;
    }
}

// Namespace ping/ping
// Params 0, eflags: 0x4
// Checksum 0xead010f4, Offset: 0x520
// Size: 0xf0
function private clear_all_pings() {
    foreach (ping in level.ping.pings) {
        ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
        function_aa50d3e4(ping);
    }
}

// Namespace ping/ping
// Params 0, eflags: 0x0
// Checksum 0xebf55c31, Offset: 0x618
// Size: 0x44
function on_player_spawn() {
    pings = self function_77d2f4f5();
    if (!isdefined(pings)) {
        self function_76fbd527();
    }
}

// Namespace ping/ping
// Params 1, eflags: 0x0
// Checksum 0xb65523f3, Offset: 0x668
// Size: 0x3c
function on_joined_team(*params) {
    self function_68ee7643();
    self function_76fbd527();
}

// Namespace ping/ping
// Params 0, eflags: 0x0
// Checksum 0x2ba93d33, Offset: 0x6b0
// Size: 0x1c
function on_disconnect() {
    self function_68ee7643();
}

// Namespace ping/ping
// Params 0, eflags: 0x0
// Checksum 0xb43a544e, Offset: 0x6d8
// Size: 0x14
function on_end_game() {
    clear_all_pings();
}

// Namespace ping/ping
// Params 1, eflags: 0x0
// Checksum 0xc33ae06a, Offset: 0x6f8
// Size: 0x158
function function_d58bf295(*params) {
    foreach (ping in level.ping.pings) {
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
// Params 4, eflags: 0x4
// Checksum 0x417c7423, Offset: 0x858
// Size: 0x30e
function private function_c5f0d88f(player, eventtype, location, param) {
    pool = function_5947d757(eventtype);
    ping = spawnstruct();
    ping.player = player;
    ping.playerentnum = player getentitynumber();
    ping.eventtype = eventtype;
    ping.pooltype = pool;
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
    assert(!isdefined(level.ping.pings[ping.id]));
    if (isdefined(level.ping.pings[ping.id])) {
        function_aa50d3e4(level.ping.pings[ping.id]);
    }
    level.ping.pings[ping.id] = ping;
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
// Params 1, eflags: 0x0
// Checksum 0xc353d337, Offset: 0xb70
// Size: 0x15c
function function_bbe2694a(networkid) {
    if (!isdefined(level.ping.pings)) {
        return;
    }
    foreach (ping in level.ping.pings) {
        if (ping.pooltype == 4 && ping.param == networkid) {
            if (isplayer(ping.player)) {
                ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
            }
            function_aa50d3e4(ping);
            break;
        }
    }
}

// Namespace ping/ping
// Params 1, eflags: 0x4
// Checksum 0x5e033365, Offset: 0xcd8
// Size: 0x154
function private function_aa50d3e4(ping) {
    assert(isdefined(level.ping.pings[ping.id]));
    level.ping.pings[ping.id] = undefined;
    assert(isdefined(level.ping.players[ping.playerentnum][ping.pooltype]));
    var_2d64756e = level.ping.players[ping.playerentnum][ping.pooltype];
    index = array::find(var_2d64756e, ping);
    assert(isdefined(index));
    if (var_2d64756e.size == 1) {
        level.ping.players[ping.playerentnum][ping.pooltype] = undefined;
        return;
    }
    array::pop(var_2d64756e, index, 0);
}

// Namespace ping/ping
// Params 2, eflags: 0x4
// Checksum 0x75625bad, Offset: 0xe38
// Size: 0x24
function private function_220a4754(ping, param) {
    return ping.param === param;
}

// Namespace ping/ping
// Params 3, eflags: 0x4
// Checksum 0xff34db31, Offset: 0xe68
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
// Params 1, eflags: 0x4
// Checksum 0x874b3, Offset: 0xf68
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
// Params 0, eflags: 0x4
// Checksum 0xa6a17875, Offset: 0x10e0
// Size: 0x122
function private update() {
    while (true) {
        time = gettime();
        foreach (ping in level.ping.pings) {
            if (ping.expiration < time) {
                ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
                function_aa50d3e4(ping);
            }
        }
        wait 1;
    }
}

