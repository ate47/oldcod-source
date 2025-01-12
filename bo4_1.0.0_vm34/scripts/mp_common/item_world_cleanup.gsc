#using scripts\abilities\gadgets\gadget_cymbal_monkey;
#using scripts\abilities\gadgets\gadget_tripwire;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace item_world_cleanup;

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x2
// Checksum 0x5d3bcb12, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"item_world_cleanup", &__init__, undefined, undefined);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x4
// Checksum 0x9234b4ef, Offset: 0xf8
// Size: 0x1c
function private __init__() {
    level thread _cleanup();
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x4
// Checksum 0x60f1e17a, Offset: 0x120
// Size: 0x152
function private _cleanup() {
    level flagsys::wait_till(#"item_world_reset");
    var_b5ad1a50 = array(&function_2230307d, &function_4f3b2149, &function_447b2cd5, &function_861291a5, &function_18f4ab38);
    while (true) {
        if (isdefined(level.deathcircle)) {
            foreach (func in var_b5ad1a50) {
                util::wait_network_frame(1);
                [[ func ]](level.deathcircle, level.deathcircles[level.deathcircleindex - 1]);
            }
        }
        wait 1;
    }
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 2, eflags: 0x4
// Checksum 0xa70b107e, Offset: 0x280
// Size: 0x114
function private function_2230307d(deathcircle, var_7032348c) {
    if (!isdefined(level.var_47028219)) {
        return;
    }
    deathstashes = arraycopy(level.var_47028219);
    foreach (deathstash in deathstashes) {
        if (!isdefined(deathstash)) {
            continue;
        }
        if (function_357caa7f(deathstash, var_7032348c, 1)) {
            deathstash delete();
            waitframe(1);
        }
    }
    arrayremovevalue(level.var_47028219, undefined, 0);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 2, eflags: 0x4
// Checksum 0xae0d709e, Offset: 0x3a0
// Size: 0x41e
function private function_4f3b2149(deathcircle, var_7032348c) {
    players = getplayers();
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
            foreach (object in watcherarray.objectarray) {
                if (function_357caa7f(object, deathcircle)) {
                    if (isdefined(object.weapon)) {
                        watcherarray thread weaponobjects::waitanddetonate(object, 0);
                    }
                    if (isdefined(object)) {
                        object kill();
                    }
                }
            }
            arrayremovevalue(watcherarray.objectarray, undefined, 0);
        }
        waitframe(1);
    }
    var_a77cff96 = [];
    foreach (tripwire in level.tripwires) {
        if (function_357caa7f(tripwire, deathcircle)) {
            var_a77cff96[var_a77cff96.size] = tripwire;
        }
    }
    for (index = 0; index < var_a77cff96.size; index++) {
        var_a77cff96[index] gadget_tripwire::function_1f0c140a();
    }
    var_62d6726d = [];
    foreach (monkey in level.var_573faa47) {
        if (isdefined(monkey) && function_357caa7f(monkey, deathcircle)) {
            var_62d6726d[var_62d6726d.size] = monkey;
        }
    }
    for (index = 0; index < var_62d6726d.size; index++) {
        var_62d6726d[index] gadget_cymbal_monkey::function_f3ad05bf();
    }
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 2, eflags: 0x4
// Checksum 0x339753bb, Offset: 0x7c8
// Size: 0x1cc
function private function_447b2cd5(deathcircle, var_7032348c) {
    if (!isdefined(level.item_spawn_drops)) {
        return;
    }
    itemspawndrops = arraycopy(level.item_spawn_drops);
    foreach (dropitem in itemspawndrops) {
        if (!isdefined(dropitem)) {
            continue;
        }
        if (isdefined(dropitem.spawning) && dropitem.spawning) {
            continue;
        }
        supplydrop = dropitem getlinkedent();
        if (isdefined(supplydrop)) {
            var_341e18df = supplydrop getlinkedent();
            if (isdefined(var_341e18df) && isdefined(var_341e18df.var_3bee8dcf) && var_341e18df.var_3bee8dcf) {
                continue;
            }
        }
        if (function_357caa7f(dropitem, var_7032348c, 1)) {
            dropitem delete();
            waitframe(1);
        }
    }
    arrayremovevalue(level.item_spawn_drops, undefined, 1);
    arrayremovevalue(level.var_12a9e573, undefined, 1);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 2, eflags: 0x4
// Checksum 0x9cf7fe4e, Offset: 0x9a0
// Size: 0x15c
function private function_861291a5(deathcircle, var_7032348c) {
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
        if (function_357caa7f(supplydrop, var_7032348c, 1)) {
            supplydrop clientfield::set("supply_drop_fx", 0);
            util::wait_network_frame(1);
            supplydrop delete();
            waitframe(1);
        }
    }
    arrayremovevalue(level.item_supply_drops, undefined, 0);
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 2, eflags: 0x4
// Checksum 0x4a882c7c, Offset: 0xb08
// Size: 0x38c
function private function_18f4ab38(deathcircle, var_7032348c) {
    time = gettime();
    if (time < level.var_88443c54) {
        return;
    }
    if (!isdefined(level.var_b140a8ba) || level.var_b140a8ba.size == 0) {
        return;
    }
    level.var_88443c54 = time + 10000;
    count = 0;
    var_d69fe8a0 = 10;
    /#
        deleted = 0;
    #/
    foreach (vehicle in level.var_b140a8ba) {
        if (!isdefined(vehicle)) {
            continue;
        }
        if (iscorpse(vehicle) || isalive(vehicle) && vehicle function_476d5fe()) {
            continue;
        }
        if (function_357caa7f(vehicle, deathcircle, 1)) {
            safedelete = 1;
            foreach (player in getplayers()) {
                var_8c3a229f = distance2dsquared(vehicle.origin, player.origin);
                if (var_8c3a229f < 1800 * 1800) {
                    safedelete = 0;
                    break;
                }
            }
            if (safedelete) {
                /#
                    if (getdvarint(#"hash_55e8ad2b1d030870", 0)) {
                        iprintlnbold("<dev string:x30>" + vehicle.scriptvehicletype + "<dev string:x3b>" + vehicle.origin);
                    }
                    deleted++;
                #/
                vehicle delete();
            }
        }
        count++;
        if (count % var_d69fe8a0 == 0) {
            util::wait_network_frame(1);
        }
    }
    arrayremovevalue(level.var_b140a8ba, undefined, 0);
    /#
        if (getdvarint(#"hash_55e8ad2b1d030870", 0) && deleted > 0) {
            iprintlnbold("<dev string:x41>" + level.var_b140a8ba.size + "<dev string:x51>" + deleted);
        }
    #/
}

// Namespace item_world_cleanup/item_world_cleanup
// Params 0, eflags: 0x4
// Checksum 0x834acf82, Offset: 0xea0
// Size: 0x88
function private function_476d5fe() {
    b_occupied = 0;
    for (i = 0; i < 4; i++) {
        if (self function_504b3ba8(i)) {
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
// Params 3, eflags: 0x4
// Checksum 0x24b101d9, Offset: 0xf30
// Size: 0xb0
function private function_357caa7f(entity, deathcircle, var_387ac9b4 = 0) {
    if (!isdefined(entity) || !isdefined(deathcircle)) {
        return false;
    }
    var_5c2d58a = var_387ac9b4 ? 3000 : 0;
    return distance2dsquared(entity.origin, deathcircle.origin) >= (deathcircle.radius + var_5c2d58a) * (deathcircle.radius + var_5c2d58a);
}

