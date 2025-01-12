#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace zm_lockdown_util;

// Namespace zm_lockdown_util
// Method(s) 2 Total 2
class class_47d4fa8c {

    var claimed;
    var owner;
    var var_1ddef03b;
    var var_c6035c50;

    // Namespace class_47d4fa8c/zm_lockdown_util
    // Params 0, eflags: 0x8
    // Checksum 0x4dae0754, Offset: 0x390
    // Size: 0x32
    constructor() {
        claimed = 0;
        var_1ddef03b = 0;
        owner = undefined;
        var_c6035c50 = undefined;
    }

}

// Namespace zm_lockdown_util
// Method(s) 2 Total 2
class class_275e38df {

    var entity;
    var var_28c60800;

    // Namespace class_275e38df/zm_lockdown_util
    // Params 0, eflags: 0x8
    // Checksum 0x3ae2b13e, Offset: 0x470
    // Size: 0x1a
    constructor() {
        var_28c60800 = [];
        entity = undefined;
    }

}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x2
// Checksum 0xcd66e118, Offset: 0x348
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_lockdown_util", &__init__, undefined, undefined);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x0
// Checksum 0x5850419e, Offset: 0x538
// Size: 0x144
function __init__() {
    level thread function_90b5f1c8();
    level thread function_4b444139();
    level.var_c91aa23c = [#"lockdown_stub_type_boards":&function_331bb0b5, #"lockdown_stub_type_crafting_tables":&function_8cbc69b1, #"lockdown_stub_type_magic_box":&function_8345adc7, #"lockdown_stub_type_pap":&function_72db2876, #"lockdown_stub_type_perks":&function_740f8c17, #"lockdown_stub_type_traps":&function_5ed1a734, #"lockdown_stub_type_wallbuys":&function_8037437];
    level.var_46a8c91f = [];
    /#
        level function_11a49512();
    #/
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x4
// Checksum 0xda17f59c, Offset: 0x688
// Size: 0x104
function private function_90b5f1c8() {
    level endon(#"end_game");
    if (!isdefined(level.var_e00c92c1)) {
        level.var_e00c92c1 = [];
    }
    if (!isdefined(level.pap_lockdown_stubs)) {
        level.pap_lockdown_stubs = [];
    }
    if (!isdefined(level.var_37201b2b)) {
        level.var_37201b2b = [];
    }
    if (!isdefined(level.var_597415d2)) {
        level.var_597415d2 = [];
    }
    level flagsys::wait_till("start_zombie_round_logic");
    function_e535e66c();
    function_876445ac();
    function_97396d4e();
    level flag::wait_till("pap_machine_active");
    function_5140581e();
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x4
// Checksum 0x23a68855, Offset: 0x798
// Size: 0x1ea
function private function_4b444139() {
    level endon(#"end_game");
    if (!isdefined(level.var_e29447b4)) {
        level.var_e29447b4 = [];
    }
    level flagsys::wait_till("start_zombie_round_logic");
    traps = getentarray("zombie_trap", "targetname");
    foreach (trap in traps) {
        if (!isdefined(trap._trap_use_trigs)) {
            continue;
        }
        foreach (trap_trig in trap._trap_use_trigs) {
            if (!isdefined(trap_trig._trap)) {
                continue;
            }
            if (!isdefined(level.var_e29447b4)) {
                level.var_e29447b4 = [];
            } else if (!isarray(level.var_e29447b4)) {
                level.var_e29447b4 = array(level.var_e29447b4);
            }
            level.var_e29447b4[level.var_e29447b4.size] = trap_trig;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x0
// Checksum 0xce0a0645, Offset: 0x990
// Size: 0x382
function function_bdb49bee(stub, category) {
    if (!isdefined(stub) || !isdefined(category)) {
        return;
    }
    switch (category) {
    case #"lockdown_stub_type_wallbuys":
        if (!isdefined(level.var_e00c92c1)) {
            level.var_e00c92c1 = [];
        }
        if (!isinarray(level.var_e00c92c1, stub)) {
            if (!isdefined(level.var_e00c92c1)) {
                level.var_e00c92c1 = [];
            } else if (!isarray(level.var_e00c92c1)) {
                level.var_e00c92c1 = array(level.var_e00c92c1);
            }
            level.var_e00c92c1[level.var_e00c92c1.size] = stub;
        }
        break;
    case #"lockdown_stub_type_pap":
        if (!isdefined(level.pap_lockdown_stubs)) {
            level.pap_lockdown_stubs = [];
        }
        if (!isinarray(level.pap_lockdown_stubs, stub)) {
            if (!isdefined(level.pap_lockdown_stubs)) {
                level.pap_lockdown_stubs = [];
            } else if (!isarray(level.pap_lockdown_stubs)) {
                level.pap_lockdown_stubs = array(level.pap_lockdown_stubs);
            }
            level.pap_lockdown_stubs[level.pap_lockdown_stubs.size] = stub;
        }
        break;
    case #"lockdown_stub_type_perks":
        if (!isdefined(level.var_37201b2b)) {
            level.var_37201b2b = [];
        }
        if (!isinarray(level.var_37201b2b, stub)) {
            if (!isdefined(level.var_37201b2b)) {
                level.var_37201b2b = [];
            } else if (!isarray(level.var_37201b2b)) {
                level.var_37201b2b = array(level.var_37201b2b);
            }
            level.var_37201b2b[level.var_37201b2b.size] = stub;
        }
        break;
    case #"lockdown_stub_type_crafting_tables":
        if (!isdefined(level.var_597415d2)) {
            level.var_597415d2 = [];
        }
        if (!isinarray(level.var_597415d2, stub)) {
            if (!isdefined(level.var_597415d2)) {
                level.var_597415d2 = [];
            } else if (!isarray(level.var_597415d2)) {
                level.var_597415d2 = array(level.var_597415d2);
            }
            level.var_597415d2[level.var_597415d2.size] = stub;
        }
        break;
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0xdd4213fe, Offset: 0xd20
// Size: 0x164
function function_30571aaf(stub) {
    function_26e5ad8c(stub);
    if (isdefined(level.var_e00c92c1) && isinarray(level.var_e00c92c1, stub)) {
        arrayremovevalue(level.var_e00c92c1, stub);
    }
    if (isdefined(level.pap_lockdown_stubs) && isinarray(level.pap_lockdown_stubs, stub)) {
        arrayremovevalue(level.pap_lockdown_stubs, stub);
    }
    if (isdefined(level.var_37201b2b) && isinarray(level.var_37201b2b, stub)) {
        arrayremovevalue(level.var_37201b2b, stub);
    }
    if (isdefined(level.var_597415d2) && isinarray(level.var_597415d2, stub)) {
        arrayremovevalue(level.var_597415d2, stub);
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x4
// Checksum 0x12f7a264, Offset: 0xe90
// Size: 0xc0
function private function_36677d7d(targetname, category) {
    foreach (stub in level._unitriggers.trigger_stubs) {
        if (isdefined(stub.targetname) && stub.targetname == targetname) {
            function_bdb49bee(stub, category);
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x4
// Checksum 0xa41b0593, Offset: 0xf58
// Size: 0x44
function private function_e535e66c() {
    function_36677d7d("weapon_upgrade", "lockdown_stub_type_wallbuys");
    function_36677d7d("bowie_upgrade", "lockdown_stub_type_wallbuys");
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x4
// Checksum 0x874a7292, Offset: 0xfa8
// Size: 0x24
function private function_876445ac() {
    function_36677d7d("perk_vapor_altar_stub", "lockdown_stub_type_perks");
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x4
// Checksum 0x6ef7634c, Offset: 0xfd8
// Size: 0x24
function private function_97396d4e() {
    function_36677d7d("crafting_trigger", "lockdown_stub_type_crafting_tables");
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x0
// Checksum 0x2623079f, Offset: 0x1008
// Size: 0x24
function function_5140581e() {
    function_36677d7d("pap_machine_stub", "lockdown_stub_type_pap");
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0x52e29044, Offset: 0x1038
// Size: 0xea
function private function_8804b9c(entity, stub, node) {
    var_398d9f2 = groundtrace(node.origin + (0, 0, 8), node.origin + (0, 0, -100000), 0, entity)[#"position"];
    var_27303e84 = {#origin:var_398d9f2, #angles:node.angles};
    if (!(isdefined(stub.var_c03c8b32) && stub.var_c03c8b32)) {
        stub.var_27303e84 = var_27303e84;
    }
    return var_27303e84;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x0
// Checksum 0x444f08b2, Offset: 0x1130
// Size: 0x394
function function_d6ef7837(entity, stub) {
    if (!isdefined(stub)) {
        return undefined;
    }
    if (isdefined(stub.var_27303e84)) {
        return stub.var_27303e84;
    }
    if (isdefined(stub.target)) {
        node = getnode(stub.target, "targetname");
        if (isdefined(node)) {
            return function_8804b9c(entity, stub, node);
        }
    }
    radius = entity getpathfindingradius();
    height = entity function_5c52d4ac();
    heightoffset = (0, 0, height * -1 / 2);
    var_e69d54e8 = (radius, radius, height / 2);
    if (isentity(stub)) {
        maxs = stub.maxs;
    } else {
        switch (stub.script_unitrigger_type) {
        case #"unitrigger_box_use":
            maxs = (stub.script_width / 2, stub.script_height / 2, stub.script_length / 2);
            break;
        case #"unitrigger_radius_use":
            maxs = (stub.radius, stub.script_height / 2, stub.radius);
            break;
        }
    }
    search_radius = max(max(maxs[0] + var_e69d54e8[0], maxs[1] + var_e69d54e8[1]), maxs[2] + var_e69d54e8[2]);
    nodes = getnodearray("lockdown_alignment_node", "script_noteworthy");
    nodes = arraysortclosest(nodes, stub.origin + heightoffset, 1, 0, search_radius);
    fallback_node = undefined;
    foreach (node in nodes) {
        if (!isdefined(fallback_node)) {
            fallback_node = node;
        }
        if (node.script_noteworthy === "lockdown_alignment_node") {
            return function_8804b9c(entity, stub, node);
        }
    }
    if (isdefined(fallback_node)) {
        return function_8804b9c(entity, stub, fallback_node);
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0xe8b1268b, Offset: 0x14d0
// Size: 0xfe
function function_51482fb2(stub) {
    if (!isdefined(stub)) {
        return undefined;
    }
    if (isdefined(stub.fxnode)) {
        return stub.fxnode;
    }
    if (isdefined(stub.script_height)) {
        n_radius = stub.script_height;
    } else {
        n_radius = 64;
    }
    a_structs = struct::get_array("lockdown_fx", "targetname");
    fxnode = arraygetclosest(stub.origin, a_structs, n_radius);
    if (isdefined(fxnode) && !(isdefined(stub.var_de6cbdbb) && stub.var_de6cbdbb)) {
        stub.fxnode = fxnode;
    }
    return fxnode;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0x95b2f4b6, Offset: 0x15d8
// Size: 0x184
function private function_e035e3e3(stub, entity, maxheight) {
    if (entity.origin[2] > stub.origin[2]) {
        /#
            if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
                function_a5eb496b(entity, stub, 7);
            }
        #/
        return false;
    }
    if (stub.origin[2] - entity.origin[2] > maxheight) {
        /#
            if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
                function_a5eb496b(entity, stub, 11, stub.origin[2] - entity.origin[2]);
            }
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x4
// Checksum 0xa641f, Offset: 0x1768
// Size: 0x34
function private function_831828b(stub) {
    self waittill(#"death");
    function_26e5ad8c(stub);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0x19ee3997, Offset: 0x17a8
// Size: 0x64
function function_26e5ad8c(stub) {
    if (!isdefined(stub)) {
        return;
    }
    var_9d078d09 = function_383a79b4(stub);
    if (isdefined(var_9d078d09) && var_9d078d09.claimed) {
        function_4664b053(stub);
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x4
// Checksum 0xb7f6829e, Offset: 0x1818
// Size: 0x108
function private function_4664b053(stub) {
    for (var_c0db2a2c = 0; var_c0db2a2c < level.var_46a8c91f.size; var_c0db2a2c++) {
        var_cf043318 = level.var_46a8c91f[var_c0db2a2c];
        for (index = 0; index < var_cf043318.var_28c60800.size; index++) {
            if (var_cf043318.var_28c60800[index].stub == stub) {
                var_cf043318.var_28c60800 = array::remove_index(var_cf043318.var_28c60800, index);
                break;
            }
        }
        if (var_cf043318.var_28c60800.size == 0) {
            level.var_46a8c91f = array::remove_index(level.var_46a8c91f, var_c0db2a2c);
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x4
// Checksum 0x54352395, Offset: 0x1928
// Size: 0x104
function private function_383a79b4(stub) {
    foreach (var_cf043318 in level.var_46a8c91f) {
        foreach (var_6d2870ad in var_cf043318.var_28c60800) {
            if (var_6d2870ad.stub === stub || var_6d2870ad.var_c6035c50 === stub) {
                return var_6d2870ad;
            }
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x4
// Checksum 0xef0cf1ac, Offset: 0x1a38
// Size: 0x8a
function private function_62da968d(entity) {
    foreach (var_cf043318 in level.var_46a8c91f) {
        if (var_cf043318.entity === entity) {
            return var_cf043318;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x4
// Checksum 0x3edd06dc, Offset: 0x1ad0
// Size: 0x10e
function private function_66e9dca9(entity) {
    foreach (var_cf043318 in level.var_46a8c91f) {
        if (var_cf043318.entity === entity) {
            foreach (var_6d2870ad in var_cf043318.var_28c60800) {
                if (isdefined(var_6d2870ad.claimed) && var_6d2870ad.claimed) {
                    return var_6d2870ad;
                }
            }
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x4
// Checksum 0xe0f26d46, Offset: 0x1be8
// Size: 0x56
function private function_94ab9f4d(stub) {
    var_6d2870ad = function_383a79b4(stub);
    return isdefined(var_6d2870ad) && isdefined(var_6d2870ad.var_1ddef03b) && var_6d2870ad.var_1ddef03b;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x4
// Checksum 0xb8dcdc72, Offset: 0x1c48
// Size: 0x76
function private function_1fc6c242(stub, entity) {
    var_6d2870ad = function_383a79b4(stub);
    return isdefined(var_6d2870ad) && isdefined(var_6d2870ad.claimed) && var_6d2870ad.claimed && entity !== var_6d2870ad.owner;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0x757768a2, Offset: 0x1cc8
// Size: 0x7c
function private function_aeb28d43(entity, stub, current_zone) {
    if (isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone) {
        /#
            function_a5eb496b(entity, stub, 2);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0xe665d421, Offset: 0x1d50
// Size: 0x1f4
function private function_8037437(entity, &var_ad671012, range) {
    current_zone = entity zm_utility::get_current_zone();
    stubs = arraysortclosest(level.var_e00c92c1, entity.origin, undefined, 0, range);
    foreach (stub in stubs) {
        if (function_94ab9f4d(stub)) {
            /#
                function_a5eb496b(entity, stub, 0);
            #/
            continue;
        }
        if (function_1fc6c242(stub, entity)) {
            /#
                function_a5eb496b(entity, stub, 1);
            #/
            continue;
        }
        if (!function_aeb28d43(entity, stub, current_zone)) {
            continue;
        }
        stub.lockdowntype = "lockdown_stub_type_wallbuys";
        if (!isdefined(var_ad671012)) {
            var_ad671012 = [];
        } else if (!isarray(var_ad671012)) {
            var_ad671012 = array(var_ad671012);
        }
        if (!isinarray(var_ad671012, stub)) {
            var_ad671012[var_ad671012.size] = stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0xef55c89d, Offset: 0x1f50
// Size: 0xd4
function private function_58ebb21d(entity, stub, current_zone) {
    if (isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone) {
        /#
            function_a5eb496b(entity, stub, 2);
        #/
        return false;
    }
    if (isdefined(stub.var_dd23f742) && stub.var_dd23f742.var_548e0166 !== "on") {
        /#
            function_a5eb496b(entity, stub, 17);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0xb1a00505, Offset: 0x2030
// Size: 0x1f4
function private function_740f8c17(entity, &var_ad671012, range) {
    current_zone = entity zm_utility::get_current_zone();
    stubs = arraysortclosest(level.var_37201b2b, entity.origin, undefined, 0, range);
    foreach (stub in stubs) {
        if (function_94ab9f4d(stub)) {
            /#
                function_a5eb496b(entity, stub, 0);
            #/
            continue;
        }
        if (function_1fc6c242(stub, entity)) {
            /#
                function_a5eb496b(entity, stub, 1);
            #/
            continue;
        }
        if (!function_58ebb21d(entity, stub, current_zone)) {
            continue;
        }
        stub.lockdowntype = "lockdown_stub_type_perks";
        if (!isdefined(var_ad671012)) {
            var_ad671012 = [];
        } else if (!isarray(var_ad671012)) {
            var_ad671012 = array(var_ad671012);
        }
        if (!isinarray(var_ad671012, stub)) {
            var_ad671012[var_ad671012.size] = stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0xbc9b5247, Offset: 0x2230
// Size: 0x7c
function private function_e8cc6bdd(entity, stub, current_zone) {
    if (isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone) {
        /#
            function_a5eb496b(entity, stub, 2);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0x65647601, Offset: 0x22b8
// Size: 0x1f4
function private function_8cbc69b1(entity, &var_ad671012, range) {
    current_zone = entity zm_utility::get_current_zone();
    stubs = arraysortclosest(level.var_597415d2, entity.origin, undefined, 0, range);
    foreach (stub in stubs) {
        if (function_94ab9f4d(stub)) {
            /#
                function_a5eb496b(entity, stub, 0);
            #/
            continue;
        }
        if (function_1fc6c242(stub, entity)) {
            /#
                function_a5eb496b(entity, stub, 1);
            #/
            continue;
        }
        if (!function_e8cc6bdd(entity, stub, current_zone)) {
            continue;
        }
        stub.lockdowntype = "lockdown_stub_type_crafting_tables";
        if (!isdefined(var_ad671012)) {
            var_ad671012 = [];
        } else if (!isarray(var_ad671012)) {
            var_ad671012 = array(var_ad671012);
        }
        if (!isinarray(var_ad671012, stub)) {
            var_ad671012[var_ad671012.size] = stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x4
// Checksum 0xc9117e35, Offset: 0x24b8
// Size: 0x1b4
function private function_22a58d55(entity, stub) {
    if (level flag::get("moving_chest_now")) {
        /#
            function_a5eb496b(entity, stub.trigger_target, 15);
        #/
        return false;
    }
    if (isdefined(stub.trigger_target.hidden) && stub.trigger_target.hidden) {
        /#
            function_a5eb496b(entity, stub.trigger_target, 3);
        #/
        return false;
    }
    if (isdefined(stub.trigger_target._box_open) && stub.trigger_target._box_open) {
        /#
            function_a5eb496b(entity, stub.trigger_target, 4);
        #/
        return false;
    }
    if (isdefined(stub.trigger_target.was_temp) && stub.trigger_target.was_temp || isdefined(stub.trigger_target.being_removed) && stub.trigger_target.being_removed) {
        /#
            function_a5eb496b(entity, stub.trigger_target, 13);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0xba7b7943, Offset: 0x2678
// Size: 0x1ec
function private function_8345adc7(entity, &var_ad671012, range) {
    chests = arraysortclosest(level.chests, entity.origin, undefined, 0, range);
    foreach (chest in chests) {
        if (!function_22a58d55(entity, chest.unitrigger_stub)) {
            continue;
        }
        if (function_94ab9f4d(chest.unitrigger_stub)) {
            /#
                function_a5eb496b(entity, chest, 0);
            #/
            continue;
        }
        if (function_1fc6c242(chest.unitrigger_stub, entity)) {
            /#
                function_a5eb496b(entity, chest, 1);
            #/
            continue;
        }
        chest.unitrigger_stub.lockdowntype = "lockdown_stub_type_magic_box";
        if (!isdefined(var_ad671012)) {
            var_ad671012 = [];
        } else if (!isarray(var_ad671012)) {
            var_ad671012 = array(var_ad671012);
        }
        if (!isinarray(var_ad671012, chest.unitrigger_stub)) {
            var_ad671012[var_ad671012.size] = chest.unitrigger_stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x4
// Checksum 0xb74e3db2, Offset: 0x2870
// Size: 0xac
function private function_7f555be2(entity, trigger) {
    if (trigger.pap_machine.state !== "powered") {
        /#
            function_a5eb496b(entity, trigger, 5);
        #/
        return false;
    }
    if (!trigger.pap_machine flag::get("pap_waiting_for_user")) {
        /#
            function_a5eb496b(entity, trigger, 6);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0x93d52c28, Offset: 0x2928
// Size: 0x1c4
function private function_72db2876(entity, &var_ad671012, range) {
    if (!level flag::get("pap_machine_active")) {
        return;
    }
    foreach (stub in level.pap_lockdown_stubs) {
        if (function_1fc6c242(stub, entity)) {
            /#
                function_a5eb496b(entity, stub, 1);
            #/
            continue;
        }
        if (!function_7f555be2(entity, stub)) {
            continue;
        }
        if (function_94ab9f4d(stub)) {
            /#
                function_a5eb496b(entity, stub, 0);
            #/
            continue;
        }
        stub.lockdowntype = "lockdown_stub_type_pap";
        if (!isdefined(var_ad671012)) {
            var_ad671012 = [];
        } else if (!isarray(var_ad671012)) {
            var_ad671012 = array(var_ad671012);
        }
        if (!isinarray(var_ad671012, stub)) {
            var_ad671012[var_ad671012.size] = stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x4
// Checksum 0x1f3df0af, Offset: 0x2af8
// Size: 0x64
function private function_355866dd(entity, blocker) {
    if (zm_utility::all_chunks_destroyed(blocker, blocker.barrier_chunks)) {
        /#
            function_a5eb496b(entity, blocker, 12);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0x4ea3051e, Offset: 0x2b68
// Size: 0x1f4
function private function_331bb0b5(entity, &var_ad671012, range) {
    blockers = arraysortclosest(level.exterior_goals, entity.origin, undefined, 0, range);
    foreach (blocker in blockers) {
        if (function_1fc6c242(blocker, entity)) {
            /#
                function_a5eb496b(entity, blocker, 1);
            #/
            continue;
        }
        if (function_94ab9f4d(blocker)) {
            /#
                function_a5eb496b(entity, blocker, 0);
            #/
            continue;
        }
        if (!function_355866dd(entity, blocker)) {
            /#
                function_a5eb496b(entity, blocker, 12);
            #/
            continue;
        }
        blocker.lockdowntype = "lockdown_stub_type_boards";
        if (!isdefined(var_ad671012)) {
            var_ad671012 = [];
        } else if (!isarray(var_ad671012)) {
            var_ad671012 = array(var_ad671012);
        }
        if (!isinarray(var_ad671012, blocker)) {
            var_ad671012[var_ad671012.size] = blocker;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x4
// Checksum 0x2e4a0b6f, Offset: 0x2d68
// Size: 0x74
function private function_c957e6f6(entity, trap_trig) {
    if (!trap_trig._trap._trap_in_use || !trap_trig._trap istriggerenabled()) {
        /#
            function_a5eb496b(entity, trap_trig, 16);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x4
// Checksum 0xeff6eff9, Offset: 0x2de8
// Size: 0x194
function private function_5ed1a734(entity, &var_ad671012, range) {
    trap_trigs = arraysortclosest(level.var_e29447b4, entity.origin, undefined, 0, range);
    foreach (trap_trig in trap_trigs) {
        if (function_1fc6c242(trap_trig, entity)) {
            /#
                function_a5eb496b(entity, trap_trig, 1);
            #/
            continue;
        }
        if (!function_c957e6f6(entity, trap_trig)) {
            continue;
        }
        trap_trig.lockdowntype = "lockdown_stub_type_traps";
        if (!isdefined(var_ad671012)) {
            var_ad671012 = [];
        } else if (!isarray(var_ad671012)) {
            var_ad671012 = array(var_ad671012);
        }
        if (!isinarray(var_ad671012, trap_trig)) {
            var_ad671012[var_ad671012.size] = trap_trig;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0x7150e435, Offset: 0x2f88
// Size: 0xd2
function function_165ef62f(lockdowntype) {
    switch (lockdowntype) {
    case #"lockdown_stub_type_pap":
        return "PAP";
    case #"lockdown_stub_type_magic_box":
        return "MAGIC_BOX";
    case #"lockdown_stub_type_boards":
        return "BOARDS";
    case #"lockdown_stub_type_wallbuys":
        return "WALLBUY";
    case #"lockdown_stub_type_crafting_tables":
        return "CRAFTING_TABLE";
    case #"lockdown_stub_type_perks":
        return "PERK";
    case #"lockdown_stub_type_traps":
        return "TRAP";
    }
    return "INVALID";
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0x42d8c72, Offset: 0x3068
// Size: 0x44
function function_13e129fe(entity) {
    var_9d078d09 = function_66e9dca9(entity);
    if (isdefined(var_9d078d09)) {
        return var_9d078d09.stub;
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x0
// Checksum 0xfcfc78d3, Offset: 0x30b8
// Size: 0x144
function function_66774b7(entity, stub) {
    var_cf043318 = function_62da968d(entity);
    if (!isdefined(var_cf043318)) {
        var_cf043318 = new class_275e38df();
        var_cf043318.entity = entity;
        array::add(level.var_46a8c91f, var_cf043318);
    }
    var_6d2870ad = function_383a79b4(stub);
    if (!isdefined(var_6d2870ad)) {
        var_6d2870ad = new class_47d4fa8c();
        var_6d2870ad.stub = stub;
        var_6d2870ad.owner = entity;
        var_6d2870ad.claimed = 1;
        array::add(var_cf043318.var_28c60800, var_6d2870ad);
        /#
            function_a5eb496b(entity, stub, 10);
        #/
    }
    entity thread function_831828b(stub);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 4, eflags: 0x0
// Checksum 0x9f662c39, Offset: 0x3208
// Size: 0x1da
function function_6b5c9744(entity, stubtypes, var_c53619b, var_8a3be9e3) {
    /#
        if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
            entity.var_9e3dcc65 = [];
        }
    #/
    var_ad671012 = [];
    foreach (stubtype in stubtypes) {
        [[ level.var_c91aa23c[stubtype] ]](entity, var_ad671012, var_c53619b);
    }
    var_ad671012 = array::filter(var_ad671012, 0, &function_e035e3e3, entity, var_8a3be9e3);
    /#
        if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
            function_fe11a9ca(entity, var_ad671012, var_c53619b);
        }
    #/
    return arraysortclosest(var_ad671012, entity.origin);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 4, eflags: 0x0
// Checksum 0x7d2523d, Offset: 0x33f0
// Size: 0x392
function function_a0ca5bc8(entity, var_55aa0d82, var_b0219169, unlockfunc) {
    var_9d078d09 = function_66e9dca9(entity);
    if (!isdefined(var_9d078d09) || !isdefined(var_9d078d09.stub)) {
        return;
    }
    if (!function_70cf3d31(entity, var_9d078d09.stub)) {
        function_26e5ad8c(var_9d078d09.stub);
        return undefined;
    }
    stub = var_9d078d09.stub;
    if (stub.lockdowntype === "lockdown_stub_type_boards") {
        zm_blockers::open_zbarrier(stub);
        function_4664b053(stub);
        return;
    }
    if (stub.lockdowntype === "lockdown_stub_type_traps") {
        stub._trap notify(#"trap_finished");
        function_4664b053(stub);
        return;
    } else if (!isentity(stub)) {
        if (!isdefined(stub.var_367a0246)) {
            stub.var_367a0246 = stub.prompt_and_visibility_func;
        }
        stub.prompt_and_visibility_func = var_55aa0d82;
        if (!isdefined(stub.var_bdee867c)) {
            stub.var_bdee867c = stub.trigger_func;
        }
        stub.trigger_func = var_b0219169;
        zm_unitrigger::reregister_unitrigger(stub);
    } else {
        stub triggerenable(0);
        newstub = stub zm_unitrigger::function_9916df24(stub.maxs[0] - stub.mins[0], stub.maxs[1] - stub.mins[1], stub.maxs[2] - stub.mins[2]);
        newstub.prompt_and_visibility_func = var_55aa0d82;
        newstub.var_c6035c50 = stub;
        newstub.lockdowntype = stub.lockdowntype;
        stub.lockdowntype = undefined;
        stub.lockdownstub = newstub;
        var_9d078d09.stub = newstub;
        var_9d078d09.var_c6035c50 = stub;
        stub = newstub;
        zm_unitrigger::register_unitrigger(newstub, var_b0219169);
    }
    if (stub.lockdowntype === "lockdown_stub_type_perks") {
        stub.var_dd23f742 zm_perks::function_29a9ca48();
    }
    stub.unlockfunc = unlockfunc;
    var_9d078d09.var_1ddef03b = 1;
    var_9d078d09.claimed = 0;
    return stub;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0x681812e9, Offset: 0x3790
// Size: 0x24
function function_e4baa0a4(entity) {
    return isdefined(function_66e9dca9(entity));
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0x9ff4f5da, Offset: 0x37c0
// Size: 0x40
function function_ec53c9d4(stub) {
    var_9d078d09 = function_383a79b4(stub);
    return var_9d078d09.var_1ddef03b === 1;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x0
// Checksum 0x5518726f, Offset: 0x3808
// Size: 0x138
function function_70cf3d31(entity, stub) {
    switch (stub.lockdowntype) {
    case #"lockdown_stub_type_boards":
        return function_355866dd(entity, stub);
    case #"lockdown_stub_type_crafting_tables":
        current_zone = entity zm_utility::get_current_zone();
        return function_e8cc6bdd(entity, stub, current_zone);
    case #"lockdown_stub_type_magic_box":
        return function_22a58d55(entity, stub);
    case #"lockdown_stub_type_pap":
        return function_7f555be2(entity, stub);
    case #"lockdown_stub_type_perks":
        current_zone = entity zm_utility::get_current_zone();
        return function_58ebb21d(entity, stub, current_zone);
    case #"lockdown_stub_type_wallbuys":
        current_zone = entity zm_utility::get_current_zone();
        return function_aeb28d43(entity, stub, current_zone);
    case #"lockdown_stub_type_traps":
        return function_c957e6f6(entity, stub);
    default:
        return 1;
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x0
// Checksum 0xf5a97f48, Offset: 0x39d8
// Size: 0xf4
function function_13c3d2e9() {
    var_9d078d09 = function_383a79b4(self);
    if (isdefined(var_9d078d09)) {
        var_9d078d09.var_1ddef03b = 2;
    }
    if (isdefined(self) && isdefined(self.unlockfunc)) {
        [[ self.unlockfunc ]](self);
    }
    self.prompt_and_visibility_func = self.var_367a0246;
    self.trigger_func = self.var_bdee867c;
    if (self.lockdowntype === "lockdown_stub_type_perks") {
        self.var_dd23f742 zm_perks::function_dbc1588c();
    }
    self.var_367a0246 = undefined;
    self.var_bdee867c = undefined;
    function_4664b053(self);
    zm_unitrigger::reregister_unitrigger(self);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x0
// Checksum 0xcf8b7550, Offset: 0x3ad8
// Size: 0xc4
function function_2d50e64d() {
    var_9d078d09 = function_383a79b4(self);
    if (isdefined(var_9d078d09)) {
        var_9d078d09.var_1ddef03b = 2;
    }
    self.var_c6035c50.lockdownstub = undefined;
    if (isdefined(self) && isdefined(self.unlockfunc)) {
        [[ self.unlockfunc ]](self);
    }
    self.var_c6035c50 triggerenable(1);
    function_4664b053(self);
    zm_unitrigger::unregister_unitrigger(self);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x0
// Checksum 0x6c68a724, Offset: 0x3ba8
// Size: 0x7c
function function_403f1f1b() {
    var_9d078d09 = function_383a79b4(self);
    assert(isdefined(var_9d078d09));
    if (isdefined(self.var_c6035c50)) {
        self function_2d50e64d();
        return;
    }
    self function_13c3d2e9();
}

/#

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 4, eflags: 0x20 variadic
    // Checksum 0xef826e6c, Offset: 0x3c30
    // Size: 0x136
    function function_a5eb496b(entity, stub, reason, ...) {
        if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
            if (!isdefined(entity.var_9e3dcc65)) {
                entity.var_9e3dcc65 = [];
            } else if (!isarray(entity.var_9e3dcc65)) {
                entity.var_9e3dcc65 = array(entity.var_9e3dcc65);
            }
            entity.var_9e3dcc65[entity.var_9e3dcc65.size] = {#stub:stub, #reason:reason, #args:vararg};
        }
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 1, eflags: 0x0
    // Checksum 0x5b9b97bb, Offset: 0x3d70
    // Size: 0x530
    function function_819c89(entity) {
        if (!(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1)) {
            return;
        }
        if (!isdefined(entity.var_9e3dcc65)) {
            return;
        }
        if (getdvarint(#"zm_lockdown_ent", -1) != entity getentitynumber()) {
            return;
        }
        foreach (var_9dd44f6e in entity.var_9e3dcc65) {
            text = entity getentitynumber() + "<dev string:x30>";
            color = (1, 0, 0);
            switch (var_9dd44f6e.reason) {
            case 0:
                text += "<dev string:x33>";
                break;
            case 1:
                text += "<dev string:x47>";
                break;
            case 2:
                text += "<dev string:x5e>";
                break;
            case 3:
                text += "<dev string:x6a>";
                break;
            case 4:
                text += "<dev string:x75>";
                break;
            case 5:
                text += "<dev string:x80>";
                break;
            case 6:
                text += "<dev string:x90>";
                break;
            case 8:
                text += "<dev string:xa3>" + var_9dd44f6e.args[0];
                break;
            case 9:
                text += "<dev string:xb3>";
                break;
            case 7:
                text += "<dev string:xc4>";
                break;
            case 11:
                text += "<dev string:xcc>" + var_9dd44f6e.args[0];
                break;
            case 10:
                text += "<dev string:xd8>";
                color = (0, 1, 0);
                break;
            case 13:
                text += "<dev string:xe0>";
                break;
            case 14:
                text += "<dev string:xec>";
                recordstar(var_9dd44f6e.args[0], (0, 1, 1));
                recordstar(var_9dd44f6e.args[1].origin, (1, 0, 1));
                recordline(var_9dd44f6e.args[1].origin, var_9dd44f6e.args[1].origin + anglestoforward(var_9dd44f6e.args[1].angles) * 10, (1, 1, 0));
                break;
            case 15:
                text += "<dev string:x10f>";
                break;
            case 16:
                text += "<dev string:x11d>";
                break;
            case 17:
                text += "<dev string:x12d>";
                break;
            }
            recordstar(var_9dd44f6e.stub.origin, (1, 1, 0));
            record3dtext(text, var_9dd44f6e.stub.origin + (0, 0, 10), color);
        }
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 3, eflags: 0x4
    // Checksum 0x772ac9fd, Offset: 0x42a8
    // Size: 0xf0
    function private function_fe11a9ca(entity, var_ad671012, var_c53619b) {
        foreach (stub in var_ad671012) {
            dist = distancesquared(entity.origin, stub.origin);
            if (dist > var_c53619b * var_c53619b) {
                function_a5eb496b(entity, stub, 8, sqrt(dist));
            }
        }
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 0, eflags: 0x4
    // Checksum 0xe9290cde, Offset: 0x43a0
    // Size: 0xa4
    function private function_11a49512() {
        zm_devgui::add_custom_devgui_callback(&function_2e9b643d);
        adddebugcommand("<dev string:x141>");
        adddebugcommand("<dev string:x179>");
        adddebugcommand("<dev string:x19d>");
        adddebugcommand("<dev string:x1d6>");
        adddebugcommand("<dev string:x235>");
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 1, eflags: 0x4
    // Checksum 0x2aa979df, Offset: 0x4450
    // Size: 0xaa
    function private function_2e9b643d(cmd) {
        switch (cmd) {
        case #"hash_619d20b906a39230":
            level.var_9307bd2a = !(isdefined(level.var_9307bd2a) && level.var_9307bd2a);
            if (isdefined(level.var_9307bd2a) && level.var_9307bd2a) {
                level thread function_500f0cb7();
            } else {
                level notify(#"hash_52b90374b27fcb8a");
            }
            break;
        }
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 0, eflags: 0x4
    // Checksum 0xbc8d08ee, Offset: 0x4508
    // Size: 0x3b4
    function private function_500f0cb7() {
        self notify("<invalid>");
        self endon("<invalid>");
        level endon(#"hash_52b90374b27fcb8a");
        stubs = arraycombine(level.exterior_goals, level.var_597415d2, 0, 0);
        stubs = arraycombine(stubs, level.pap_lockdown_stubs, 0, 0);
        stubs = arraycombine(stubs, level.var_37201b2b, 0, 0);
        stubs = arraycombine(stubs, level.var_e29447b4, 0, 0);
        stubs = arraycombine(stubs, level.var_e00c92c1, 0, 0);
        foreach (chest in level.chests) {
            if (!isdefined(stubs)) {
                stubs = [];
            } else if (!isarray(stubs)) {
                stubs = array(stubs);
            }
            stubs[stubs.size] = chest.unitrigger_stub;
        }
        var_b1317137 = (-16, -16, 0);
        var_2ddf9795 = (16, 16, 32);
        while (true) {
            wait 0.5;
            entity = getentbynum(getdvarint(#"zm_lockdown_ent", -1));
            if (!isdefined(entity)) {
                continue;
            }
            foreach (stub in stubs) {
                var_2b134a2a = function_d6ef7837(entity, stub);
                if (isdefined(var_2b134a2a)) {
                    box(var_2b134a2a.origin, var_b1317137, var_2ddf9795, var_2b134a2a.angles[1], (0, 1, 0), 1, 0, 10);
                    line(var_2b134a2a.origin, var_2b134a2a.origin + anglestoforward(var_2b134a2a.angles) * 32, (0, 1, 0), 1, 0, 10);
                    continue;
                }
                circle(stub.origin, 16, (1, 0, 0), 0, 0, 10);
            }
        }
    }

#/
