#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;

#namespace zm_aoe;

// Namespace zm_aoe
// Method(s) 2 Total 2
class areaofeffect {

    var spawntime;
    var state;
    var var_eb4d27d2;

    // Namespace areaofeffect/zm_aoe
    // Params 0, eflags: 0x8
    // Checksum 0x26857016, Offset: 0x158
    // Size: 0x2a
    constructor() {
        spawntime = gettime();
        state = 0;
        var_eb4d27d2 = gettime() + 100;
    }

}

// Namespace zm_aoe
// Method(s) 2 Total 2
class class_2be88390 {

    var var_40e15903;

    // Namespace class_2be88390/zm_aoe
    // Params 0, eflags: 0x8
    // Checksum 0xd9cf6d76, Offset: 0x230
    // Size: 0xe
    constructor() {
        var_40e15903 = [];
    }

}

// Namespace zm_aoe/zm_aoe
// Params 0, eflags: 0x2
// Checksum 0x8ece260, Offset: 0x108
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_aoe", &__init__, &__main__, undefined);
}

// Namespace zm_aoe/zm_aoe
// Params 0, eflags: 0x0
// Checksum 0xdd7648d, Offset: 0x2e8
// Size: 0x84
function __init__() {
    clientfield::register("scriptmover", "aoe_state", 1, getminbitcountfornum(4), "int");
    clientfield::register("scriptmover", "aoe_id", 1, getminbitcountfornum(5), "int");
}

// Namespace zm_aoe/zm_aoe
// Params 0, eflags: 0x4
// Checksum 0xd92775c6, Offset: 0x378
// Size: 0xac
function private __main__() {
    function_83d921cc(1, "zm_aoe_spear", 15, 16000, 2000, 5, 15, 40, 80);
    function_83d921cc(2, "zm_aoe_spear_small", 15, 12000, 2000, 5, 15, 20, 80);
    function_83d921cc(3, "zm_aoe_spear_big", 15, 25000, 2000, 5, 15, 60, 80);
}

// Namespace zm_aoe/zm_aoe
// Params 1, eflags: 0x4
// Checksum 0x4980218, Offset: 0x430
// Size: 0x98
function private function_dd7e9c0d(type) {
    assert(isdefined(level.var_c0a905a3));
    arraykeys = getarraykeys(level.var_c0a905a3);
    if (isinarray(arraykeys, hash(type))) {
        return level.var_c0a905a3[hash(type)];
    }
    return undefined;
}

// Namespace zm_aoe/zm_aoe
// Params 9, eflags: 0x0
// Checksum 0xdcabaf87, Offset: 0x4d0
// Size: 0x1ec
function function_83d921cc(aoeid, type, var_a55f41e3, lifetime, var_4a98c61c, damagemin, damagemax, radius, height) {
    if (!isdefined(level.var_c0a905a3)) {
        level.var_c0a905a3 = [];
    }
    arraykeys = getarraykeys(level.var_c0a905a3);
    assert(!isinarray(arraykeys, hash(type)));
    var_50e9f8c9 = new class_2be88390();
    level.var_c0a905a3[type] = var_50e9f8c9;
    assert(damagemin <= damagemax, "<dev string:x30>");
    var_50e9f8c9.type = type;
    var_50e9f8c9.var_a55f41e3 = var_a55f41e3;
    var_50e9f8c9.lifetime = lifetime;
    var_50e9f8c9.damagemin = damagemin;
    var_50e9f8c9.damagemax = damagemax;
    var_50e9f8c9.var_4a98c61c = var_4a98c61c;
    var_50e9f8c9.radius = radius;
    var_50e9f8c9.height = height;
    var_50e9f8c9.aoeid = aoeid;
    level thread function_b813f818(type);
    /#
        level thread function_b089f569(var_50e9f8c9);
    #/
}

// Namespace zm_aoe/zm_aoe
// Params 3, eflags: 0x0
// Checksum 0x3572f6de, Offset: 0x6c8
// Size: 0x174
function function_3defe341(aoeid, type, position) {
    var_61cc2b88 = function_dd7e9c0d(type);
    assert(isdefined(var_61cc2b88), "<dev string:x6a>");
    if (var_61cc2b88.var_40e15903.size >= var_61cc2b88.var_a55f41e3) {
        function_c070176b(type);
    }
    assert(var_61cc2b88.var_40e15903.size < var_61cc2b88.var_a55f41e3);
    aoe = new areaofeffect();
    aoe.position = position;
    aoe.endtime = gettime() + var_61cc2b88.lifetime;
    aoe.entity = spawn("script_model", position);
    aoe.type = type;
    aoe.entity clientfield::set("aoe_id", aoeid);
    function_1e5c704d(aoe, type);
}

// Namespace zm_aoe/zm_aoe
// Params 2, eflags: 0x4
// Checksum 0x5d738eb7, Offset: 0x848
// Size: 0xa4
function private function_1e5c704d(aoe, type) {
    var_61cc2b88 = function_dd7e9c0d(type);
    assert(isdefined(var_61cc2b88), "<dev string:x6a>");
    array::add(var_61cc2b88.var_40e15903, aoe);
    assert(var_61cc2b88.var_40e15903.size <= var_61cc2b88.var_a55f41e3);
}

// Namespace zm_aoe/zm_aoe
// Params 1, eflags: 0x4
// Checksum 0x55c2aa7b, Offset: 0x8f8
// Size: 0x104
function private function_8249377f(type) {
    var_61cc2b88 = function_dd7e9c0d(type);
    assert(isdefined(var_61cc2b88), "<dev string:x6a>");
    if (var_61cc2b88.var_40e15903.size) {
        oldest = var_61cc2b88.var_40e15903[0];
        foreach (aoe in var_61cc2b88.var_40e15903) {
            if (aoe.spawntime < oldest.spawntime) {
                oldest = aoe;
            }
        }
        return oldest;
    }
}

// Namespace zm_aoe/zm_aoe
// Params 2, eflags: 0x4
// Checksum 0x7dabb346, Offset: 0xa08
// Size: 0xd4
function private function_c4a0db9d(aoe, type) {
    var_61cc2b88 = function_dd7e9c0d(type);
    assert(isinarray(var_61cc2b88.var_40e15903, aoe));
    aoe.entity delete();
    arrayremovevalue(var_61cc2b88.var_40e15903, aoe);
    assert(var_61cc2b88.var_40e15903.size < var_61cc2b88.var_a55f41e3);
}

// Namespace zm_aoe/zm_aoe
// Params 1, eflags: 0x4
// Checksum 0x98cda3a4, Offset: 0xae8
// Size: 0xbc
function private function_c070176b(type) {
    var_61cc2b88 = function_dd7e9c0d(type);
    var_4c28fde9 = function_8249377f(type);
    var_4c28fde9.entity delete();
    arrayremovevalue(var_61cc2b88.var_40e15903, var_4c28fde9);
    assert(var_61cc2b88.var_40e15903.size < var_61cc2b88.var_a55f41e3);
}

// Namespace zm_aoe/zm_aoe
// Params 1, eflags: 0x4
// Checksum 0x5814c4cc, Offset: 0xbb0
// Size: 0x1e2
function private function_bd62f438(aoe) {
    var_61cc2b88 = function_dd7e9c0d(aoe.type);
    assert(isdefined(var_61cc2b88));
    if (gettime() < aoe.var_eb4d27d2) {
        return;
    }
    if (aoe.state == 0) {
        aoe.entity clientfield::set("aoe_state", 1);
        aoe.state = 1;
        aoe.var_eb4d27d2 = gettime() + 100;
        return;
    }
    if (aoe.state == 1) {
        aoe.entity clientfield::set("aoe_state", 2);
        aoe.state = 2;
        aoe.var_eb4d27d2 = aoe.endtime;
        return;
    }
    if (aoe.state == 2) {
        aoe.entity clientfield::set("aoe_state", 3);
        aoe.state = 3;
        aoe.var_eb4d27d2 = gettime() + var_61cc2b88.var_4a98c61c;
        return;
    }
    if (aoe.state == 3) {
        aoe.entity clientfield::set("aoe_state", 4);
        aoe.state = 4;
    }
}

// Namespace zm_aoe/zm_aoe
// Params 1, eflags: 0x4
// Checksum 0x60d9cc3b, Offset: 0xda0
// Size: 0x180
function private function_b10f26ea(type) {
    var_61cc2b88 = function_dd7e9c0d(type);
    assert(isdefined(var_61cc2b88));
    var_8d31b5c = [];
    foreach (aoe in var_61cc2b88.var_40e15903) {
        function_bd62f438(aoe);
        if (aoe.state == 4) {
            array::add(var_8d31b5c, aoe, 0);
        }
    }
    foreach (aoe in var_8d31b5c) {
        function_c4a0db9d(aoe, aoe.type);
    }
}

// Namespace zm_aoe/zm_aoe
// Params 1, eflags: 0x4
// Checksum 0xbe72483b, Offset: 0xf28
// Size: 0x2e0
function private function_8b050861(type) {
    var_61cc2b88 = function_dd7e9c0d(type);
    assert(isdefined(var_61cc2b88));
    players = getplayers();
    foreach (aoe in var_61cc2b88.var_40e15903) {
        foreach (player in players) {
            assert(isdefined(aoe.entity));
            dist = distance(aoe.entity.origin, player.origin);
            withinrange = dist <= var_61cc2b88.radius;
            var_da50285a = 0;
            if (!withinrange) {
                continue;
            }
            heightdiff = abs(aoe.entity.origin[2] - player.origin[2]);
            if (heightdiff <= var_61cc2b88.height) {
                var_da50285a = 1;
            }
            if (withinrange && var_da50285a) {
                damage = mapfloat(0, var_61cc2b88.radius, var_61cc2b88.damagemin, var_61cc2b88.damagemax, dist);
                player dodamage(damage, aoe.entity.origin);
                player notify(#"aoe_damage", {#str_source:aoe.type});
            }
        }
    }
}

// Namespace zm_aoe/zm_aoe
// Params 1, eflags: 0x4
// Checksum 0xd04e76d4, Offset: 0x1210
// Size: 0xa6
function private function_b813f818(type) {
    var_61cc2b88 = function_dd7e9c0d(type);
    assert(isdefined(var_61cc2b88));
    while (true) {
        if (!var_61cc2b88.var_40e15903.size) {
            waitframe(1);
            continue;
        }
        function_b10f26ea(type);
        function_8b050861(type);
        waitframe(1);
    }
}

/#

    // Namespace zm_aoe/zm_aoe
    // Params 1, eflags: 0x4
    // Checksum 0x5d6296d5, Offset: 0x12c0
    // Size: 0x2d0
    function private function_b089f569(var_61cc2b88) {
        var_61cc2b88 endon(#"hash_343e166e4aa4288e");
        while (true) {
            if (getdvarint(#"zm_debug_aoe", 0)) {
                if (var_61cc2b88.var_40e15903.size) {
                    var_8249377f = function_8249377f(var_61cc2b88.type);
                    i = 0;
                    foreach (aoe in var_61cc2b88.var_40e15903) {
                        circle(aoe.position, var_61cc2b88.radius, (1, 0.5, 0), 1, 1);
                        circle(aoe.position + (0, 0, var_61cc2b88.height), var_61cc2b88.radius, (1, 0.5, 0), 1, 1);
                        line(aoe.position, aoe.position + (0, 0, var_61cc2b88.height), (1, 0.5, 0));
                        if (aoe == var_8249377f) {
                            print3d(aoe.position + (0, 0, var_61cc2b88.height + 5), "<dev string:x9c>" + var_61cc2b88.type + "<dev string:xa3>" + i + "<dev string:xa5>", (1, 0, 0));
                        } else {
                            print3d(aoe.position + (0, 0, var_61cc2b88.height + 5), "<dev string:x9c>" + var_61cc2b88.type + "<dev string:xa3>" + i + "<dev string:xa5>", (1, 0.5, 0));
                        }
                        i++;
                    }
                }
            }
            waitframe(1);
        }
    }

#/
