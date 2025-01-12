#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace item_world_cleanup;

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x6
// Checksum 0xc311abdb, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"item_world_cleanup", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x5 linked
// Checksum 0xa3be77a4, Offset: 0xf8
// Size: 0x1c
function private function_70a657d8() {
    level thread _cleanup();
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x5 linked
// Checksum 0x735cc751, Offset: 0x120
// Size: 0x234
function private _cleanup() {
    level flag::wait_till(#"item_world_reset");
    var_ce255078 = array(&function_b465b436, &function_35e11623, &function_b7c5f376, &function_6ef5c287, &function_ada16428);
    var_314770d8 = array(&function_a534560c);
    while (true) {
        if (death_circle::is_active()) {
            foreach (func in var_ce255078) {
                util::wait_network_frame(1);
                [[ func ]](death_circle::function_b980b4ca(), death_circle::function_f8dae197(), death_circle::function_e32d74d8(), death_circle::function_3009b78f());
            }
        }
        foreach (func in var_314770d8) {
            util::wait_network_frame(1);
            [[ func ]]();
        }
        wait 1;
    }
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x5 linked
// Checksum 0x2d655db, Offset: 0x360
// Size: 0x23c
function private function_a534560c() {
    if (!isdefined(level.item_spawn_drops)) {
        return;
    }
    itemspawndrops = arraycopy(level.item_spawn_drops);
    time = gettime();
    foreach (dropitem in itemspawndrops) {
        if (!isdefined(dropitem)) {
            continue;
        }
        if (is_true(dropitem.spawning)) {
            continue;
        }
        supplydrop = dropitem getlinkedent();
        if (isdefined(supplydrop)) {
            var_da05d0b2 = supplydrop getlinkedent();
            if (isdefined(var_da05d0b2) && is_true(var_da05d0b2.var_5d0810d7)) {
                continue;
            }
        }
        if (!isdefined(dropitem.droptime)) {
            continue;
        }
        if (isdefined(dropitem.var_a6762160.var_fa988b4b) && dropitem.var_a6762160.var_fa988b4b > 0) {
            if (float(time - dropitem.droptime) / 1000 >= dropitem.var_a6762160.var_fa988b4b) {
                item_world::consume_item(dropitem, 1);
                waitframe(1);
            }
        }
    }
    arrayremovevalue(level.item_spawn_drops, undefined, 1);
    arrayremovevalue(level.var_18dc9d17, undefined, 1);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 4, eflags: 0x5 linked
// Checksum 0x5e4999b0, Offset: 0x5a8
// Size: 0x134
function private function_b465b436(*var_11f2ba1f, *var_c5a0bed8, previous_origin, var_7c597200) {
    if (!isdefined(level.var_ace9fb52)) {
        return;
    }
    deathstashes = arraycopy(level.var_ace9fb52);
    foreach (deathstash in deathstashes) {
        if (!isdefined(deathstash)) {
            continue;
        }
        if (function_3703bc36(deathstash, previous_origin, var_7c597200, 1)) {
            deathstash delete();
            waitframe(1);
        }
    }
    arrayremovevalue(level.var_ace9fb52, undefined, 0);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 4, eflags: 0x5 linked
// Checksum 0x394c3a40, Offset: 0x6e8
// Size: 0x690
function private function_35e11623(var_11f2ba1f, var_c5a0bed8, *previous_origin, *var_7c597200) {
    players = getplayers();
    excludelist = [#"eq_acid_bomb":1, #"eq_cluster_semtex_grenade":1, #"eq_molotov":1, #"eq_slow_grenade":1, #"eq_swat_grenade":1, #"eq_wraith_fire":1, #"frag_grenade":1, #"willy_pete":1];
    foreach (player in players) {
        if (!isplayer(player)) {
            continue;
        }
        if (!isarray(player.weaponobjectwatcherarray)) {
            continue;
        }
        foreach (watcherarray in player.weaponobjectwatcherarray) {
            if (!isdefined(watcherarray) || !isarray(watcherarray.objectarray)) {
                continue;
            }
            for (index = 0; index < watcherarray.objectarray.size; index++) {
                object = watcherarray.objectarray[index];
                if (function_3703bc36(object, previous_origin, var_7c597200)) {
                    if (isdefined(object.weapon)) {
                        weapon = object.weapon;
                        if (isdefined(excludelist[weapon.name])) {
                            continue;
                        }
                        if (weapon.name == #"hatchet" || weapon.name == #"tomahawk_t8") {
                            velocity = object getvelocity();
                            if (velocity[0] > 0 || velocity[1] > 0 || velocity[2]) {
                                continue;
                            }
                        }
                        watcherarray thread weaponobjects::waitanddetonate(object, 0);
                    }
                    if (isdefined(object) && !is_true(object.detonated)) {
                        object kill();
                        if (isdefined(object)) {
                            object delete();
                        }
                    }
                }
            }
            arrayremovevalue(watcherarray.objectarray, undefined, 0);
        }
        waitframe(1);
    }
    if (isdefined(level.var_2e06b76a)) {
        var_a5a016fc = [];
        foreach (tripwire in level.tripwires) {
            if (function_3703bc36(tripwire, previous_origin, var_7c597200)) {
                var_a5a016fc[var_a5a016fc.size] = tripwire;
            }
        }
        for (index = 0; index < var_a5a016fc.size; index++) {
            var_a5a016fc[index] [[ level.var_2e06b76a ]]();
        }
    }
    if (isdefined(level.var_7c5c96dc)) {
        var_90afc439 = [];
        foreach (monkey in level.var_7d95e1ed) {
            if (isdefined(monkey) && function_3703bc36(monkey, previous_origin, var_7c597200)) {
                var_90afc439[var_90afc439.size] = monkey;
            }
        }
        for (index = 0; index < var_90afc439.size; index++) {
            var_90afc439[index] [[ level.var_7c5c96dc ]]();
        }
    }
    if (isdefined(level.var_cc310d06)) {
        var_2e20127d = [];
        foreach (homunculus in level.var_2da60c10) {
            if (isdefined(homunculus) && function_3703bc36(homunculus, previous_origin, var_7c597200)) {
                var_2e20127d[var_2e20127d.size] = homunculus;
            }
        }
        for (index = 0; index < var_2e20127d.size; index++) {
            var_2e20127d[index] [[ level.var_cc310d06 ]]();
        }
    }
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 4, eflags: 0x5 linked
// Checksum 0x5ca34e28, Offset: 0xd80
// Size: 0x20c
function private function_b7c5f376(*var_11f2ba1f, *var_c5a0bed8, previous_origin, var_7c597200) {
    if (!isdefined(level.item_spawn_drops)) {
        return;
    }
    itemspawndrops = arraycopy(level.item_spawn_drops);
    foreach (dropitem in itemspawndrops) {
        if (!isdefined(dropitem)) {
            continue;
        }
        if (is_true(dropitem.spawning)) {
            continue;
        }
        supplydrop = dropitem getlinkedent();
        if (isdefined(supplydrop)) {
            var_da05d0b2 = supplydrop getlinkedent();
            if (isdefined(var_da05d0b2) && is_true(var_da05d0b2.var_5d0810d7)) {
                continue;
            }
        }
        if (function_3703bc36(dropitem, previous_origin, var_7c597200, 1)) {
            dropitem.hidetime = gettime();
            item_world::function_a54d07e6(dropitem, undefined);
            dropitem delete();
            waitframe(1);
        }
    }
    arrayremovevalue(level.item_spawn_drops, undefined, 1);
    arrayremovevalue(level.var_18dc9d17, undefined, 1);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 4, eflags: 0x5 linked
// Checksum 0x75b77ac, Offset: 0xf98
// Size: 0x17c
function private function_6ef5c287(*var_11f2ba1f, *var_c5a0bed8, previous_origin, var_7c597200) {
    if (!isdefined(level.item_supply_drops)) {
        return;
    }
    supplydrops = arraycopy(level.item_supply_drops);
    foreach (supplydrop in supplydrops) {
        if (!isdefined(supplydrop)) {
            continue;
        }
        if (isdefined(supplydrop.supplydropveh)) {
            continue;
        }
        if (function_3703bc36(supplydrop, previous_origin, var_7c597200, 1)) {
            supplydrop clientfield::set("supply_drop_fx", 0);
            util::wait_network_frame(1);
            supplydrop delete();
            waitframe(1);
        }
    }
    arrayremovevalue(level.item_supply_drops, undefined, 0);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 4, eflags: 0x5 linked
// Checksum 0x2327c717, Offset: 0x1120
// Size: 0x584
function private function_ada16428(var_11f2ba1f, var_c5a0bed8, *previous_origin, *var_7c597200) {
    if (!isdefined(level.var_63e0085)) {
        return;
    }
    time = gettime();
    if (time < level.var_63e0085) {
        return;
    }
    if (!isdefined(level.var_cd8f416a) || level.var_cd8f416a.size == 0) {
        return;
    }
    level.var_63e0085 = time + 10000;
    count = 0;
    var_3624d2c5 = 10;
    /#
        deleted = 0;
    #/
    time = gettime();
    foreach (vehicle in level.var_cd8f416a) {
        if (!isdefined(vehicle)) {
            continue;
        }
        if (isvehicle(vehicle) && vehicle function_213a12e4()) {
            continue;
        }
        if (function_3703bc36(vehicle, previous_origin, var_7c597200, 1)) {
            if (!isdefined(vehicle.var_a6b3cbdc)) {
                delay = 60000;
                if (isdefined(vehicle.var_8e382c5f)) {
                    delay += 300000;
                }
                vehicle.var_a6b3cbdc = time + delay;
            }
            if (vehicle.var_a6b3cbdc > time) {
                continue;
            }
            safedelete = 1;
            foreach (player in level.deathcircle.players) {
                if (!isdefined(player) || !isalive(player)) {
                    continue;
                }
                var_6287b00e = distance2dsquared(vehicle.origin, player.origin);
                if (var_6287b00e < function_a3f6cdac(10000)) {
                    safedelete = 0;
                    break;
                }
                var_42beec1c = (previous_origin[0] - player.origin[0], previous_origin[1] - player.origin[1], 0);
                var_42beec1c = vectornormalize(var_42beec1c);
                var_838d27e = (vehicle.origin[0] - player.origin[0], vehicle.origin[1] - player.origin[1], 0);
                var_838d27e = vectornormalize(var_838d27e);
                if (vectordot(var_42beec1c, var_838d27e) >= 0.9396) {
                    var_c64c4a1f = distance2dsquared(vehicle.origin, player.origin);
                    var_f25c153c = distance2dsquared(player.origin, previous_origin);
                    if (var_c64c4a1f < var_f25c153c) {
                        safedelete = 0;
                        break;
                    }
                }
            }
            if (safedelete) {
                /#
                    if (getdvarint(#"hash_55e8ad2b1d030870", 0)) {
                        iprintlnbold("<dev string:x38>" + vehicle.scriptvehicletype + "<dev string:x46>" + vehicle.origin);
                    }
                    deleted++;
                #/
                vehicle delete();
            }
        }
        count++;
        if (count % var_3624d2c5 == 0) {
            util::wait_network_frame(1);
        }
    }
    arrayremovevalue(level.var_cd8f416a, undefined, 0);
    /#
        if (getdvarint(#"hash_55e8ad2b1d030870", 0) && deleted > 0) {
            iprintlnbold("<dev string:x4f>" + level.var_cd8f416a.size + "<dev string:x62>" + deleted);
        }
    #/
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x5 linked
// Checksum 0x379cce32, Offset: 0x16b0
// Size: 0x86
function private function_213a12e4() {
    b_occupied = 0;
    for (i = 0; i < 4; i++) {
        if (self function_dcef0ba1(i)) {
            if (self isvehicleseatoccupied(i)) {
                b_occupied = 1;
                break;
            }
            continue;
        }
        break;
    }
    return b_occupied;
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 4, eflags: 0x5 linked
// Checksum 0xf9d2e5b2, Offset: 0x1740
// Size: 0xac
function private function_3703bc36(entity, origin, radius, var_7e2f7f1f = 0) {
    if (!isdefined(entity) || !isdefined(origin) || !isdefined(radius)) {
        return false;
    }
    var_be38b475 = var_7e2f7f1f ? 5000 : 0;
    return distance2dsquared(entity.origin, origin) >= function_a3f6cdac(radius + var_be38b475);
}

