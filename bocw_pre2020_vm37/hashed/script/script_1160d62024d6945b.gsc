#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_d0eacb0d;

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 0, eflags: 0x6
// Checksum 0xdaaf00fe, Offset: 0x78
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_dd05779fff7e75f", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 0, eflags: 0x5 linked
// Checksum 0xb9875462, Offset: 0xd0
// Size: 0xdc
function private function_70a657d8() {
    if (currentsessionmode() != 4 && getgametypesetting(#"hash_435c853b64e3175e") === 1) {
        level.var_9fd4b8f = spawnstruct();
        level.var_9fd4b8f.vehicles = [];
        level.var_10e55912 = getgametypesetting(#"hash_3cc3acd830a8eef") === 1;
        callback::on_vehicle_killed(&on_vehicle_killed);
        level thread function_7955100c();
    }
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x1b8
// Size: 0x4
function private postinit() {
    
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x1 linked
// Checksum 0xd18001f5, Offset: 0x1c8
// Size: 0x62
function on_vehicle_killed(*params) {
    if (isdefined(self.spawnindex)) {
        level.var_9fd4b8f.vehicles[self.spawnindex].alive = 0;
        level.var_9fd4b8f.vehicles[self.spawnindex].var_93438377 = gettime();
    }
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 6, eflags: 0x5 linked
// Checksum 0x71811a93, Offset: 0x238
// Size: 0xf8
function private function_b604ec09(vehicletype, spawnpos, spawnangles, spawncallback, params, count) {
    var_1957bf22 = spawnstruct();
    var_1957bf22.var_e7f51a60 = count;
    var_1957bf22.spawncount = 0;
    var_1957bf22.spawnpos = spawnpos;
    var_1957bf22.spawnangles = spawnangles;
    var_1957bf22.vehicletype = vehicletype;
    var_1957bf22.spawncallback = spawncallback;
    var_1957bf22.params = params;
    var_1957bf22.index = level.var_9fd4b8f.vehicles.size;
    var_1957bf22.alive = 1;
    level.var_9fd4b8f.vehicles[level.var_9fd4b8f.vehicles.size] = var_1957bf22;
    return var_1957bf22;
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 2, eflags: 0x5 linked
// Checksum 0xf47448d9, Offset: 0x338
// Size: 0xaa
function private function_f7bb1527(var_1957bf22, vehicle) {
    var_1957bf22.respawntime = function_f77a9b1b(vehicle);
    var_1957bf22.timeouttime = function_e674d71a(vehicle);
    var_1957bf22.radius = vehicle.radius;
    var_1957bf22.origin = vehicle.origin;
    var_1957bf22.angles = vehicle.angles;
    var_1957bf22.center = vehicle getboundsmidpoint();
    var_1957bf22.halfsize = vehicle getboundshalfsize();
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 0, eflags: 0x1 linked
// Checksum 0xf3ed8ee2, Offset: 0x3f0
// Size: 0x6a
function function_585a895b() {
    count = 0;
    infinitespawn = 0;
    spawnflags = self.spawnflags;
    if (isdefined(spawnflags)) {
        infinitespawn = spawnflags & 64;
    }
    if (self.count && !infinitespawn) {
        count = self.count;
    }
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 5, eflags: 0x1 linked
// Checksum 0x6a2531eb, Offset: 0x468
// Size: 0x106
function function_711f53df(vehicletype, spawnpos, spawnangles, spawncallback, params) {
    self endon(#"death");
    if (getgametypesetting(#"hash_435c853b64e3175e") === 1) {
        wait 1;
        if (!isdefined(self.spawnindex)) {
            count = self function_585a895b();
            var_1957bf22 = function_b604ec09(vehicletype, spawnpos, spawnangles, spawncallback, params, count);
            var_1957bf22.vehicle = self;
            function_f7bb1527(var_1957bf22, var_1957bf22.vehicle);
            self.spawnindex = var_1957bf22.index;
        }
    }
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 5, eflags: 0x1 linked
// Checksum 0x38ac281f, Offset: 0x578
// Size: 0x124
function function_f863c07e(vehicletype, spawnpos, spawnangles, spawncallback, params) {
    if (getgametypesetting(#"hash_435c853b64e3175e") === 1) {
        count = self function_585a895b();
        var_1957bf22 = function_b604ec09(vehicletype, spawnpos, spawnangles, spawncallback, params, count);
        var_1957bf22.vehicle = spawn_vehicle(vehicletype, spawnpos, spawnangles, var_1957bf22.index, spawncallback, params);
        var_1957bf22.spawncount++;
        function_f7bb1527(var_1957bf22, var_1957bf22.vehicle);
        return var_1957bf22.vehicle;
    }
    return spawn_vehicle(vehicletype, spawnpos, spawnangles, undefined, spawncallback, params);
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 6, eflags: 0x5 linked
// Checksum 0x5f1504c9, Offset: 0x6a8
// Size: 0xa2
function private spawn_vehicle(vehicletype, spawnpos, spawnangles, index, callback, params) {
    vehicle = spawnvehicle(vehicletype, spawnpos, spawnangles);
    assert(isdefined(vehicle));
    if (isdefined(vehicle)) {
        if (isdefined(callback)) {
            [[ callback ]](vehicle, params);
        }
        vehicle.spawnindex = index;
    }
    return vehicle;
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x5 linked
// Checksum 0x39df4d8c, Offset: 0x758
// Size: 0x310
function private function_a20b03ed(vs) {
    if (vs.alive) {
        return false;
    }
    if (!vs.respawntime) {
        return false;
    }
    if (isdefined(vs.var_e7f51a60) && vs.spawncount >= vs.var_e7f51a60) {
        return false;
    }
    time = gettime();
    if (time < vs.var_93438377 + vs.respawntime) {
        return false;
    }
    if (isdefined(vs.vehicle)) {
        vs.vehicle delete();
    }
    ents = getentitiesinradius(vs.origin, vs.radius);
    if (ents.size > 0) {
        /#
            if (getdvarint(#"hash_67f18c2de587c7d3", 0)) {
            }
        #/
        foreach (ent in ents) {
            if (!isdefined(ent.model)) {
                continue;
            }
            if (ent.model == #"") {
                continue;
            }
            var_84c67202 = ent getboundsmidpoint();
            var_59485761 = ent getboundshalfsize();
            if (function_ecdf9b24(vs.origin + vs.center, vs.angles, vs.halfsize, ent.origin + var_84c67202, ent.angles, var_59485761)) {
                /#
                    if (getdvarint(#"hash_67f18c2de587c7d3", 0)) {
                        box(vs.origin + vs.center, vs.halfsize * -1, vs.halfsize, vs.angles, (1, 0, 0), 1, 0, 25);
                        box(ent.origin + var_84c67202, var_59485761 * -1, var_59485761, ent.angles, (1, 0, 0), 1, 0, 25);
                    }
                #/
                return false;
            }
        }
    }
    return true;
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x1 linked
// Checksum 0x8220142d, Offset: 0xa70
// Size: 0x44
function function_6b4b0313(vs) {
    time = gettime();
    if (function_a20b03ed(vs)) {
        thread function_af758179(vs);
    }
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x1 linked
// Checksum 0x24268334, Offset: 0xac0
// Size: 0x7c
function function_af758179(vs) {
    vs.alive = 1;
    util::wait_network_frame();
    vs.vehicle = spawn_vehicle(vs.vehicletype, vs.spawnpos, vs.spawnangles, vs.index, vs.spawncallback, vs.params);
    vs.spawncount++;
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x1 linked
// Checksum 0x267d13f5, Offset: 0xb48
// Size: 0x1c6
function function_ef4c0e24(vehicle) {
    pixbeginevent(#"hash_7dffca8fd413098d");
    players = getentitiesinradius(vehicle.origin, 200, 1);
    if (players.size > 0) {
        pixendevent();
        return true;
    }
    players = getentitiesinradius(vehicle.origin, 2000, 1);
    foreach (player in players) {
        direction = vehicle.origin - player.origin;
        dir = vectornormalize(direction);
        forward = anglestoforward(player.angles);
        if (vectordot(forward, dir) > 0.707) {
            pixendevent();
            return true;
        }
    }
    pixendevent();
    return false;
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x1 linked
// Checksum 0xb96cd79c, Offset: 0xd18
// Size: 0x160
function function_ef45a8f4(vs) {
    if (!level.var_10e55912) {
        return false;
    }
    if (!vs.alive) {
        return false;
    }
    if (!vs.timeouttime) {
        return false;
    }
    vehicle = vs.vehicle;
    if (!isdefined(vehicle)) {
        return false;
    }
    if (!isvehicle(vehicle)) {
        return false;
    }
    if (!isdefined(vehicle.last_enter)) {
        return false;
    }
    occupants = vehicle getvehoccupants();
    if (isdefined(occupants) && occupants.size) {
        return false;
    }
    if (distancesquared(vehicle.origin, vs.spawnpos) < 36864) {
        return false;
    }
    time = gettime();
    if (!isdefined(vehicle.var_70ad8a9e) || function_ef4c0e24(vehicle)) {
        vehicle.var_70ad8a9e = time;
    }
    if (vs.timeouttime + vehicle.var_70ad8a9e > time) {
        return false;
    }
    return true;
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x1 linked
// Checksum 0x1c413fcb, Offset: 0xe80
// Size: 0x5c
function function_6ecd8f13(vs) {
    if (function_ef45a8f4(vs)) {
        vs.vehicle on_vehicle_killed();
        vs.vehicle delete();
    }
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 0, eflags: 0x1 linked
// Checksum 0xe02d1f78, Offset: 0xee8
// Size: 0x15a
function function_7955100c() {
    while (true) {
        vehiclecount = level.var_9fd4b8f.vehicles.size;
        var_cefe19ce = int(vehiclecount * float(function_60d95f53()) / 1000);
        count = 0;
        foreach (vs in level.var_9fd4b8f.vehicles) {
            count++;
            function_6b4b0313(vs);
            function_6ecd8f13(vs);
            if (var_cefe19ce > 0 && !(count % var_cefe19ce)) {
                waitframe(1);
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x1 linked
// Checksum 0xf99453f3, Offset: 0x1050
// Size: 0xca
function function_2265d46b(deathmodel) {
    if (isdefined(self.spawnindex)) {
        assert(isdefined(level.var_9fd4b8f));
        assert(isdefined(level.var_9fd4b8f.vehicles));
        assert(isdefined(level.var_9fd4b8f.vehicles[self.spawnindex]));
        deathmodel.spawnindex = self.spawnindex;
        level.var_9fd4b8f.vehicles[self.spawnindex].vehicle = deathmodel;
    }
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x5 linked
// Checksum 0xeb9e47ab, Offset: 0x1128
// Size: 0x46a
function private function_e674d71a(vehicle) {
    respawntime = 60;
    if (isdefined(vehicle.scriptvehicletype)) {
        switch (vehicle.scriptvehicletype) {
        case #"player_atv":
            respawntime = getgametypesetting(#"hash_25d72112144c5ea0");
            break;
        case #"player_tank":
            respawntime = getgametypesetting(#"hash_4725de6afe873b87");
            break;
        case #"helicopter_light":
            respawntime = getgametypesetting(#"hash_7f190c8839d3f05c");
            break;
        case #"helicopter_heavy":
            respawntime = getgametypesetting(#"hash_4f00f3f568c284af");
            break;
        case #"hash_2212824fabcc986c":
            respawntime = getgametypesetting(#"hash_7d53c8bab3db8122");
            break;
        case #"player_motorcycle_2wd":
        case #"player_motorcycle":
            respawntime = getgametypesetting(#"hash_b30022a9302a5a6");
            break;
        case #"player_fav":
            respawntime = getgametypesetting(#"hash_28005bb885acabc3");
            break;
        case #"player_btr40":
            respawntime = getgametypesetting(#"hash_3eeb8cb5c84b1939");
            break;
        case #"player_fav_light":
            respawntime = getgametypesetting(#"hash_3d5a87878a3bef28");
            break;
        case #"cargo_truck_wz":
            respawntime = getgametypesetting(#"hash_4201d2890785fb14");
            break;
        case #"hash_5b215c4eff8f5759":
            respawntime = getgametypesetting(#"hash_22c53ddb2cb67f13");
            break;
        case #"player_pbr":
            respawntime = getgametypesetting(#"hash_39cfd81268504039");
            break;
        case #"tactical_raft_wz":
        case #"player_tactical_raft":
            respawntime = getgametypesetting(#"hash_53fd9a3e9a0e78e1");
            break;
        case #"player_muscle":
            respawntime = getgametypesetting(#"hash_5f116b8cfbdbc3fe");
            break;
        case #"player_suv":
            respawntime = getgametypesetting(#"hash_208071125a2b0b0b");
            break;
        case #"player_uaz":
            respawntime = getgametypesetting(#"hash_52ef5b12764c8139");
            break;
        case #"player_jetski":
            respawntime = getgametypesetting(#"hash_76f686986e1a58b");
            break;
        default:
            break;
        }
    }
    assert(isdefined(respawntime));
    return int(respawntime * 1000);
}

// Namespace namespace_d0eacb0d/namespace_d0eacb0d
// Params 1, eflags: 0x5 linked
// Checksum 0x28802e30, Offset: 0x15a0
// Size: 0x4ba
function private function_f77a9b1b(vehicle) {
    /#
        if (getdvarint(#"hash_3ff1cd3c47489190", 0) > 0) {
            return int(1 * 1000);
        }
    #/
    respawntime = 0;
    if (isdefined(vehicle.scriptvehicletype)) {
        switch (vehicle.scriptvehicletype) {
        case #"player_atv":
            respawntime = getgametypesetting(#"hash_42b840c668fd2c85");
            break;
        case #"player_tank":
            respawntime = getgametypesetting(#"hash_46f0ae82f5c2f7d4");
            break;
        case #"helicopter_light":
            respawntime = getgametypesetting(#"hash_2a02614601829003");
            break;
        case #"helicopter_heavy":
            respawntime = getgametypesetting(#"hash_5598d36d6b224c9a");
            break;
        case #"hash_2212824fabcc986c":
            respawntime = getgametypesetting(#"hash_7353bbc24d72ec59");
            break;
        case #"player_motorcycle_2wd":
        case #"player_motorcycle":
            respawntime = getgametypesetting(#"hash_5a4fde688cbf1a01");
            break;
        case #"player_fav":
            respawntime = getgametypesetting(#"hash_6b2754246df1bc7c");
            break;
        case #"player_btr40":
            respawntime = getgametypesetting(#"hash_6773166f56896564");
            break;
        case #"player_fav_light":
            respawntime = getgametypesetting(#"hash_54d908d6273c8893");
            break;
        case #"cargo_truck_wz":
            respawntime = getgametypesetting(#"hash_1974892bc7266bab");
            break;
        case #"hash_5b215c4eff8f5759":
            respawntime = getgametypesetting(#"hash_273d049136c76afa");
            break;
        case #"player_pbr":
            respawntime = getgametypesetting(#"hash_44f0b1c6b2d3b6f8");
            break;
        case #"tactical_raft_wz":
        case #"player_tactical_raft":
            respawntime = getgametypesetting(#"hash_56f6d77da3124af2");
            break;
        case #"player_muscle":
            respawntime = getgametypesetting(#"hash_7c33e5bebaf05afb");
            break;
        case #"player_suv":
            respawntime = getgametypesetting(#"hash_5dc620c6c0919d82");
            break;
        case #"player_uaz":
            respawntime = getgametypesetting(#"hash_2aea36c6a4135574");
            break;
        case #"player_jetski":
            respawntime = getgametypesetting(#"hash_38a8f601ab8388d0");
            break;
        default:
            break;
        }
    }
    assert(isdefined(respawntime));
    return int(respawntime * 1000);
}

