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
class class_6fde4e6 {

    var claimed;
    var owner;
    var var_4f0ea1b5;
    var var_6f08706b;

    // Namespace class_6fde4e6/zm_lockdown_util
    // Params 0, eflags: 0x9 linked
    // Checksum 0xac85f1ad, Offset: 0x3e0
    // Size: 0x32
    constructor() {
        claimed = 0;
        var_4f0ea1b5 = 0;
        owner = undefined;
        var_6f08706b = undefined;
    }

}

// Namespace zm_lockdown_util
// Method(s) 2 Total 2
class class_b599a4bc {

    var entity;
    var var_f6d13e1b;

    // Namespace class_b599a4bc/zm_lockdown_util
    // Params 0, eflags: 0x9 linked
    // Checksum 0xbbcd4857, Offset: 0x4b8
    // Size: 0x1a
    constructor() {
        var_f6d13e1b = [];
        entity = undefined;
    }

}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x6
// Checksum 0x296dd566, Offset: 0x398
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_lockdown_util", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x5 linked
// Checksum 0xc0a456b7, Offset: 0x578
// Size: 0x144
function private function_70a657d8() {
    level thread function_b595044c();
    level thread function_ccf7ac87();
    level.var_492142a5 = [#"lockdown_stub_type_boards":&function_8850974b, #"lockdown_stub_type_crafting_tables":&function_d0e1d38c, #"lockdown_stub_type_magic_box":&function_e6761711, #"lockdown_stub_type_pap":&function_165e2bd6, #"lockdown_stub_type_perks":&function_db989a2a, #"lockdown_stub_type_traps":&function_d2ce5ac1, #"lockdown_stub_type_wallbuys":&function_9c7d5271];
    level.var_85c076ab = [];
    /#
        level function_946bb116();
    #/
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x5 linked
// Checksum 0xa3f89ec0, Offset: 0x6c8
// Size: 0x104
function private function_b595044c() {
    level endon(#"end_game");
    if (!isdefined(level.var_f17bdf53)) {
        level.var_f17bdf53 = [];
    }
    if (!isdefined(level.pap_lockdown_stubs)) {
        level.pap_lockdown_stubs = [];
    }
    if (!isdefined(level.var_9235b607)) {
        level.var_9235b607 = [];
    }
    if (!isdefined(level.var_16cfe3ef)) {
        level.var_16cfe3ef = [];
    }
    level flag::wait_till("start_zombie_round_logic");
    function_eeeb30d7();
    function_9559446b();
    function_f7bd473a();
    level flag::wait_till("pap_machine_active");
    function_2bdb235d();
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x5 linked
// Checksum 0xe4ae66dd, Offset: 0x7d8
// Size: 0x200
function private function_ccf7ac87() {
    level endon(#"end_game");
    if (!isdefined(level.var_2510f3e4)) {
        level.var_2510f3e4 = [];
    }
    level flag::wait_till("start_zombie_round_logic");
    traps = getentarray("zombie_trap", "targetname");
    foreach (trap in traps) {
        if (!isdefined(trap._trap_use_trigs)) {
            continue;
        }
        foreach (trap_trig in trap._trap_use_trigs) {
            if (!isdefined(trap_trig._trap)) {
                continue;
            }
            if (!isdefined(level.var_2510f3e4)) {
                level.var_2510f3e4 = [];
            } else if (!isarray(level.var_2510f3e4)) {
                level.var_2510f3e4 = array(level.var_2510f3e4);
            }
            level.var_2510f3e4[level.var_2510f3e4.size] = trap_trig;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x1 linked
// Checksum 0x589d1fa7, Offset: 0x9e0
// Size: 0x35a
function function_d67bafb5(stub, category) {
    if (!isdefined(stub) || !isdefined(category)) {
        return;
    }
    switch (category) {
    case #"lockdown_stub_type_wallbuys":
        if (!isdefined(level.var_f17bdf53)) {
            level.var_f17bdf53 = [];
        }
        if (!isinarray(level.var_f17bdf53, stub)) {
            if (!isdefined(level.var_f17bdf53)) {
                level.var_f17bdf53 = [];
            } else if (!isarray(level.var_f17bdf53)) {
                level.var_f17bdf53 = array(level.var_f17bdf53);
            }
            level.var_f17bdf53[level.var_f17bdf53.size] = stub;
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
        if (!isdefined(level.var_9235b607)) {
            level.var_9235b607 = [];
        }
        if (!isinarray(level.var_9235b607, stub)) {
            if (!isdefined(level.var_9235b607)) {
                level.var_9235b607 = [];
            } else if (!isarray(level.var_9235b607)) {
                level.var_9235b607 = array(level.var_9235b607);
            }
            level.var_9235b607[level.var_9235b607.size] = stub;
        }
        break;
    case #"lockdown_stub_type_crafting_tables":
        if (!isdefined(level.var_16cfe3ef)) {
            level.var_16cfe3ef = [];
        }
        if (!isinarray(level.var_16cfe3ef, stub)) {
            if (!isdefined(level.var_16cfe3ef)) {
                level.var_16cfe3ef = [];
            } else if (!isarray(level.var_16cfe3ef)) {
                level.var_16cfe3ef = array(level.var_16cfe3ef);
            }
            level.var_16cfe3ef[level.var_16cfe3ef.size] = stub;
        }
        break;
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x1 linked
// Checksum 0x52be2aab, Offset: 0xd48
// Size: 0x164
function function_6b9e848(stub) {
    function_77caff8b(stub);
    if (isdefined(level.var_f17bdf53) && isinarray(level.var_f17bdf53, stub)) {
        arrayremovevalue(level.var_f17bdf53, stub);
    }
    if (isdefined(level.pap_lockdown_stubs) && isinarray(level.pap_lockdown_stubs, stub)) {
        arrayremovevalue(level.pap_lockdown_stubs, stub);
    }
    if (isdefined(level.var_9235b607) && isinarray(level.var_9235b607, stub)) {
        arrayremovevalue(level.var_9235b607, stub);
    }
    if (isdefined(level.var_16cfe3ef) && isinarray(level.var_16cfe3ef, stub)) {
        arrayremovevalue(level.var_16cfe3ef, stub);
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x5 linked
// Checksum 0x73c07cd2, Offset: 0xeb8
// Size: 0xc8
function private function_b913ec1b(targetname, category) {
    foreach (stub in level._unitriggers.trigger_stubs) {
        if (isdefined(stub.targetname) && stub.targetname == targetname) {
            function_d67bafb5(stub, category);
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x5 linked
// Checksum 0xfacf705d, Offset: 0xf88
// Size: 0x44
function private function_eeeb30d7() {
    function_b913ec1b("weapon_upgrade", "lockdown_stub_type_wallbuys");
    function_b913ec1b("bowie_upgrade", "lockdown_stub_type_wallbuys");
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x5 linked
// Checksum 0x88ecd190, Offset: 0xfd8
// Size: 0x24
function private function_9559446b() {
    function_b913ec1b("perk_vapor_altar_stub", "lockdown_stub_type_perks");
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x5 linked
// Checksum 0x51fbea7e, Offset: 0x1008
// Size: 0x24
function private function_f7bd473a() {
    function_b913ec1b("crafting_trigger", "lockdown_stub_type_crafting_tables");
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd07178a5, Offset: 0x1038
// Size: 0x24
function function_2bdb235d() {
    function_b913ec1b("pap_machine_stub", "lockdown_stub_type_pap");
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x2259e78f, Offset: 0x1068
// Size: 0xe6
function private function_2bdff7e1(entity, stub, node) {
    var_5bd89846 = groundtrace(node.origin + (0, 0, 8), node.origin + (0, 0, -100000), 0, entity)[#"position"];
    var_66694b96 = {#origin:var_5bd89846, #angles:node.angles};
    if (!is_true(stub.var_7c2f9a8b)) {
        stub.var_66694b96 = var_66694b96;
    }
    return var_66694b96;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x0
// Checksum 0xdaa4d720, Offset: 0x1158
// Size: 0x374
function function_dab6d796(entity, stub) {
    if (!isdefined(stub)) {
        return undefined;
    }
    if (isdefined(stub.var_66694b96)) {
        return stub.var_66694b96;
    }
    if (isdefined(stub.target)) {
        node = getnode(stub.target, "targetname");
        if (isdefined(node)) {
            return function_2bdff7e1(entity, stub, node);
        }
    }
    radius = entity getpathfindingradius();
    height = entity function_6a9ae71();
    heightoffset = (0, 0, height * -1 / 2);
    var_e790dc87 = (radius, radius, height / 2);
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
    search_radius = max(max(maxs[0] + var_e790dc87[0], maxs[1] + var_e790dc87[1]), maxs[2] + var_e790dc87[2]);
    nodes = getnodearray("lockdown_alignment_node", "script_noteworthy");
    nodes = arraysortclosest(nodes, stub.origin + heightoffset, 1, 0, search_radius);
    fallback_node = undefined;
    foreach (node in nodes) {
        if (!isdefined(fallback_node)) {
            fallback_node = node;
        }
        if (node.script_noteworthy === "lockdown_alignment_node") {
            return function_2bdff7e1(entity, stub, node);
        }
    }
    if (isdefined(fallback_node)) {
        return function_2bdff7e1(entity, stub, fallback_node);
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0xb11a9151, Offset: 0x14d8
// Size: 0xf2
function function_da72073(stub) {
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
    if (isdefined(fxnode) && !is_true(stub.var_7e4bc0a2)) {
        stub.fxnode = fxnode;
    }
    return fxnode;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x6bd268da, Offset: 0x15d8
// Size: 0x184
function private function_9f952db3(stub, entity, maxheight) {
    if (entity.origin[2] > stub.origin[2]) {
        /#
            if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
                function_78eae22a(entity, stub, 7);
            }
        #/
        return false;
    }
    if (stub.origin[2] - entity.origin[2] > maxheight) {
        /#
            if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
                function_78eae22a(entity, stub, 11, stub.origin[2] - entity.origin[2]);
            }
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x5 linked
// Checksum 0xb6ffb65a, Offset: 0x1768
// Size: 0x34
function private function_adb36e84(stub) {
    self waittill(#"death");
    function_77caff8b(stub);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x1 linked
// Checksum 0xb9300310, Offset: 0x17a8
// Size: 0x64
function function_77caff8b(stub) {
    if (!isdefined(stub)) {
        return;
    }
    var_a0692a89 = function_fd31eb92(stub);
    if (isdefined(var_a0692a89) && var_a0692a89.claimed) {
        function_66941fc3(stub);
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x5 linked
// Checksum 0xe5d77d1f, Offset: 0x1818
// Size: 0xf4
function private function_66941fc3(stub) {
    for (var_77f297ef = 0; var_77f297ef < level.var_85c076ab.size; var_77f297ef++) {
        var_2943f1ec = level.var_85c076ab[var_77f297ef];
        for (index = 0; index < var_2943f1ec.var_f6d13e1b.size; index++) {
            if (var_2943f1ec.var_f6d13e1b[index].stub == stub) {
                var_2943f1ec.var_f6d13e1b = array::remove_index(var_2943f1ec.var_f6d13e1b, index);
                break;
            }
        }
        if (var_2943f1ec.var_f6d13e1b.size == 0) {
            level.var_85c076ab = array::remove_index(level.var_85c076ab, var_77f297ef);
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x5 linked
// Checksum 0x7cfd9a55, Offset: 0x1918
// Size: 0x11c
function private function_fd31eb92(stub) {
    foreach (var_2943f1ec in level.var_85c076ab) {
        foreach (var_f1e20c7f in var_2943f1ec.var_f6d13e1b) {
            if (var_f1e20c7f.stub === stub || var_f1e20c7f.var_6f08706b === stub) {
                return var_f1e20c7f;
            }
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x5 linked
// Checksum 0x15ee6fa7, Offset: 0x1a40
// Size: 0x96
function private function_f7315b07(entity) {
    foreach (var_2943f1ec in level.var_85c076ab) {
        if (var_2943f1ec.entity === entity) {
            return var_2943f1ec;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x5 linked
// Checksum 0x2783cf29, Offset: 0x1ae0
// Size: 0x124
function private function_4ad92a9a(entity) {
    foreach (var_2943f1ec in level.var_85c076ab) {
        if (var_2943f1ec.entity === entity) {
            foreach (var_f1e20c7f in var_2943f1ec.var_f6d13e1b) {
                if (is_true(var_f1e20c7f.claimed)) {
                    return var_f1e20c7f;
                }
            }
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x5 linked
// Checksum 0x25ceb8e6, Offset: 0x1c10
// Size: 0x54
function private function_e1f6d06a(stub) {
    var_f1e20c7f = function_fd31eb92(stub);
    return isdefined(var_f1e20c7f) && is_true(var_f1e20c7f.var_4f0ea1b5);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x5 linked
// Checksum 0xd8a54da8, Offset: 0x1c70
// Size: 0x6e
function private function_55d2ad24(stub, entity) {
    var_f1e20c7f = function_fd31eb92(stub);
    return isdefined(var_f1e20c7f) && is_true(var_f1e20c7f.claimed) && entity !== var_f1e20c7f.owner;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x27f51b51, Offset: 0x1ce8
// Size: 0x74
function private function_d3fbb5ec(entity, stub, current_zone) {
    if (isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone) {
        /#
            function_78eae22a(entity, stub, 2);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0xdad67d20, Offset: 0x1d68
// Size: 0x1ee
function private function_9c7d5271(entity, &registerlotus_right, range) {
    current_zone = entity zm_utility::get_current_zone();
    stubs = arraysortclosest(level.var_f17bdf53, entity.origin, undefined, 0, range);
    foreach (stub in stubs) {
        if (function_e1f6d06a(stub)) {
            /#
                function_78eae22a(entity, stub, 0);
            #/
            continue;
        }
        if (function_55d2ad24(stub, entity)) {
            /#
                function_78eae22a(entity, stub, 1);
            #/
            continue;
        }
        if (!function_d3fbb5ec(entity, stub, current_zone)) {
            continue;
        }
        stub.lockdowntype = "lockdown_stub_type_wallbuys";
        if (!isdefined(registerlotus_right)) {
            registerlotus_right = [];
        } else if (!isarray(registerlotus_right)) {
            registerlotus_right = array(registerlotus_right);
        }
        if (!isinarray(registerlotus_right, stub)) {
            registerlotus_right[registerlotus_right.size] = stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x857411d5, Offset: 0x1f60
// Size: 0xcc
function private function_fea6f0c0(entity, stub, current_zone) {
    if (isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone) {
        /#
            function_78eae22a(entity, stub, 2);
        #/
        return false;
    }
    if (isdefined(stub.var_3468124) && stub.var_3468124.var_2977c27 !== "on") {
        /#
            function_78eae22a(entity, stub, 17);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x499a416a, Offset: 0x2038
// Size: 0x1ee
function private function_db989a2a(entity, &registerlotus_right, range) {
    current_zone = entity zm_utility::get_current_zone();
    stubs = arraysortclosest(level.var_9235b607, entity.origin, undefined, 0, range);
    foreach (stub in stubs) {
        if (function_e1f6d06a(stub)) {
            /#
                function_78eae22a(entity, stub, 0);
            #/
            continue;
        }
        if (function_55d2ad24(stub, entity)) {
            /#
                function_78eae22a(entity, stub, 1);
            #/
            continue;
        }
        if (!function_fea6f0c0(entity, stub, current_zone)) {
            continue;
        }
        stub.lockdowntype = "lockdown_stub_type_perks";
        if (!isdefined(registerlotus_right)) {
            registerlotus_right = [];
        } else if (!isarray(registerlotus_right)) {
            registerlotus_right = array(registerlotus_right);
        }
        if (!isinarray(registerlotus_right, stub)) {
            registerlotus_right[registerlotus_right.size] = stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x9379d8a1, Offset: 0x2230
// Size: 0x74
function private function_ea677a9a(entity, stub, current_zone) {
    if (isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone) {
        /#
            function_78eae22a(entity, stub, 2);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0xc4ffa217, Offset: 0x22b0
// Size: 0x1ee
function private function_d0e1d38c(entity, &registerlotus_right, range) {
    current_zone = entity zm_utility::get_current_zone();
    stubs = arraysortclosest(level.var_16cfe3ef, entity.origin, undefined, 0, range);
    foreach (stub in stubs) {
        if (function_e1f6d06a(stub)) {
            /#
                function_78eae22a(entity, stub, 0);
            #/
            continue;
        }
        if (function_55d2ad24(stub, entity)) {
            /#
                function_78eae22a(entity, stub, 1);
            #/
            continue;
        }
        if (!function_ea677a9a(entity, stub, current_zone)) {
            continue;
        }
        stub.lockdowntype = "lockdown_stub_type_crafting_tables";
        if (!isdefined(registerlotus_right)) {
            registerlotus_right = [];
        } else if (!isarray(registerlotus_right)) {
            registerlotus_right = array(registerlotus_right);
        }
        if (!isinarray(registerlotus_right, stub)) {
            registerlotus_right[registerlotus_right.size] = stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x5 linked
// Checksum 0xf9e3e644, Offset: 0x24a8
// Size: 0x17c
function private function_95250640(entity, stub) {
    if (level flag::get("moving_chest_now")) {
        /#
            function_78eae22a(entity, stub.trigger_target, 15);
        #/
        return false;
    }
    if (is_true(stub.trigger_target.hidden)) {
        /#
            function_78eae22a(entity, stub.trigger_target, 3);
        #/
        return false;
    }
    if (is_true(stub.trigger_target._box_open)) {
        /#
            function_78eae22a(entity, stub.trigger_target, 4);
        #/
        return false;
    }
    if (is_true(stub.trigger_target.was_temp) || is_true(stub.trigger_target.being_removed)) {
        /#
            function_78eae22a(entity, stub.trigger_target, 13);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x9a7b9619, Offset: 0x2630
// Size: 0x1e6
function private function_e6761711(entity, &registerlotus_right, range) {
    chests = arraysortclosest(level.chests, entity.origin, undefined, 0, range);
    foreach (chest in chests) {
        if (!function_95250640(entity, chest.unitrigger_stub)) {
            continue;
        }
        if (function_e1f6d06a(chest.unitrigger_stub)) {
            /#
                function_78eae22a(entity, chest, 0);
            #/
            continue;
        }
        if (function_55d2ad24(chest.unitrigger_stub, entity)) {
            /#
                function_78eae22a(entity, chest, 1);
            #/
            continue;
        }
        chest.unitrigger_stub.lockdowntype = "lockdown_stub_type_magic_box";
        if (!isdefined(registerlotus_right)) {
            registerlotus_right = [];
        } else if (!isarray(registerlotus_right)) {
            registerlotus_right = array(registerlotus_right);
        }
        if (!isinarray(registerlotus_right, chest.unitrigger_stub)) {
            registerlotus_right[registerlotus_right.size] = chest.unitrigger_stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x5 linked
// Checksum 0xec05d4ff, Offset: 0x2820
// Size: 0xa4
function private function_790e3eb0(entity, trigger) {
    if (trigger.pap_machine.state !== "powered") {
        /#
            function_78eae22a(entity, trigger, 5);
        #/
        return false;
    }
    if (!trigger.pap_machine flag::get("pap_waiting_for_user")) {
        /#
            function_78eae22a(entity, trigger, 6);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x140d937d, Offset: 0x28d0
// Size: 0x1b6
function private function_165e2bd6(entity, &registerlotus_right, *range) {
    if (!level flag::get("pap_machine_active")) {
        return;
    }
    foreach (stub in level.pap_lockdown_stubs) {
        if (function_55d2ad24(stub, registerlotus_right)) {
            /#
                function_78eae22a(registerlotus_right, stub, 1);
            #/
            continue;
        }
        if (!function_790e3eb0(registerlotus_right, stub)) {
            continue;
        }
        if (function_e1f6d06a(stub)) {
            /#
                function_78eae22a(registerlotus_right, stub, 0);
            #/
            continue;
        }
        stub.lockdowntype = "lockdown_stub_type_pap";
        if (!isdefined(range)) {
            range = [];
        } else if (!isarray(range)) {
            range = array(range);
        }
        if (!isinarray(range, stub)) {
            range[range.size] = stub;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x5 linked
// Checksum 0xb2d8cb4a, Offset: 0x2a90
// Size: 0x5c
function private function_809ae5cb(entity, blocker) {
    if (zm_utility::all_chunks_destroyed(blocker, blocker.barrier_chunks)) {
        /#
            function_78eae22a(entity, blocker, 12);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0x7d9f90b9, Offset: 0x2af8
// Size: 0x1de
function private function_8850974b(entity, &registerlotus_right, range) {
    blockers = arraysortclosest(level.exterior_goals, entity.origin, undefined, 0, range);
    foreach (blocker in blockers) {
        if (function_55d2ad24(blocker, entity)) {
            /#
                function_78eae22a(entity, blocker, 1);
            #/
            continue;
        }
        if (function_e1f6d06a(blocker)) {
            /#
                function_78eae22a(entity, blocker, 0);
            #/
            continue;
        }
        if (!function_809ae5cb(entity, blocker)) {
            /#
                function_78eae22a(entity, blocker, 12);
            #/
            continue;
        }
        blocker.lockdowntype = "lockdown_stub_type_boards";
        if (!isdefined(registerlotus_right)) {
            registerlotus_right = [];
        } else if (!isarray(registerlotus_right)) {
            registerlotus_right = array(registerlotus_right);
        }
        if (!isinarray(registerlotus_right, blocker)) {
            registerlotus_right[registerlotus_right.size] = blocker;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x5 linked
// Checksum 0xc82b730f, Offset: 0x2ce0
// Size: 0x74
function private function_387fd27e(entity, trap_trig) {
    if (!trap_trig._trap._trap_in_use || !trap_trig._trap istriggerenabled()) {
        /#
            function_78eae22a(entity, trap_trig, 16);
        #/
        return false;
    }
    return true;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 3, eflags: 0x5 linked
// Checksum 0xee491504, Offset: 0x2d60
// Size: 0x18e
function private function_d2ce5ac1(entity, &registerlotus_right, range) {
    trap_trigs = arraysortclosest(level.var_2510f3e4, entity.origin, undefined, 0, range);
    foreach (trap_trig in trap_trigs) {
        if (function_55d2ad24(trap_trig, entity)) {
            /#
                function_78eae22a(entity, trap_trig, 1);
            #/
            continue;
        }
        if (!function_387fd27e(entity, trap_trig)) {
            continue;
        }
        trap_trig.lockdowntype = "lockdown_stub_type_traps";
        if (!isdefined(registerlotus_right)) {
            registerlotus_right = [];
        } else if (!isarray(registerlotus_right)) {
            registerlotus_right = array(registerlotus_right);
        }
        if (!isinarray(registerlotus_right, trap_trig)) {
            registerlotus_right[registerlotus_right.size] = trap_trig;
        }
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0x7c4797aa, Offset: 0x2ef8
// Size: 0xd2
function function_22aeb4e9(lockdowntype) {
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
// Checksum 0x52e1f94f, Offset: 0x2fd8
// Size: 0x40
function function_87c1193e(entity) {
    var_a0692a89 = function_4ad92a9a(entity);
    if (isdefined(var_a0692a89)) {
        return var_a0692a89.stub;
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x0
// Checksum 0x8426149e, Offset: 0x3020
// Size: 0x134
function function_50ba1eb0(entity, stub) {
    var_2943f1ec = function_f7315b07(entity);
    if (!isdefined(var_2943f1ec)) {
        var_2943f1ec = new class_b599a4bc();
        var_2943f1ec.entity = entity;
        array::add(level.var_85c076ab, var_2943f1ec);
    }
    var_f1e20c7f = function_fd31eb92(stub);
    if (!isdefined(var_f1e20c7f)) {
        var_f1e20c7f = new class_6fde4e6();
        var_f1e20c7f.stub = stub;
        var_f1e20c7f.owner = entity;
        var_f1e20c7f.claimed = 1;
        array::add(var_2943f1ec.var_f6d13e1b, var_f1e20c7f);
        /#
            function_78eae22a(entity, stub, 10);
        #/
    }
    entity thread function_adb36e84(stub);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 4, eflags: 0x0
// Checksum 0xbca914ca, Offset: 0x3160
// Size: 0x1e2
function function_9b84bb88(entity, stubtypes, var_d05e79c8, var_c7455683) {
    /#
        if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
            entity.var_d187874c = [];
        }
    #/
    registerlotus_right = [];
    foreach (stubtype in stubtypes) {
        [[ level.var_492142a5[stubtype] ]](entity, registerlotus_right, var_d05e79c8);
    }
    registerlotus_right = array::filter(registerlotus_right, 0, &function_9f952db3, entity, var_c7455683);
    /#
        if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
            function_6351d1c3(entity, registerlotus_right, var_d05e79c8);
        }
    #/
    return arraysortclosest(registerlotus_right, entity.origin);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 4, eflags: 0x0
// Checksum 0xc8a32eb0, Offset: 0x3350
// Size: 0x34e
function function_7258b5cc(entity, var_410a8c7, var_2baba799, unlockfunc) {
    var_a0692a89 = function_4ad92a9a(entity);
    if (!isdefined(var_a0692a89) || !isdefined(var_a0692a89.stub)) {
        return;
    }
    if (!function_c9105448(entity, var_a0692a89.stub)) {
        function_77caff8b(var_a0692a89.stub);
        return undefined;
    }
    stub = var_a0692a89.stub;
    if (stub.lockdowntype === "lockdown_stub_type_boards") {
        zm_blockers::open_zbarrier(stub);
        function_66941fc3(stub);
        return;
    }
    if (stub.lockdowntype === "lockdown_stub_type_traps") {
        stub._trap notify(#"trap_finished");
        function_66941fc3(stub);
        return;
    } else if (!isentity(stub)) {
        if (!isdefined(stub.var_a0fc37f6)) {
            stub.var_a0fc37f6 = stub.prompt_and_visibility_func;
        }
        stub.prompt_and_visibility_func = var_410a8c7;
        if (!isdefined(stub.var_492080a5)) {
            stub.var_492080a5 = stub.trigger_func;
        }
        stub.trigger_func = var_2baba799;
        zm_unitrigger::reregister_unitrigger(stub);
    } else {
        stub triggerenable(0);
        newstub = stub zm_unitrigger::function_9267812e(stub.maxs[0] - stub.mins[0], stub.maxs[1] - stub.mins[1], stub.maxs[2] - stub.mins[2]);
        newstub.prompt_and_visibility_func = var_410a8c7;
        newstub.var_6f08706b = stub;
        newstub.lockdowntype = stub.lockdowntype;
        newstub.script_string = stub.script_string;
        stub.lockdowntype = undefined;
        stub.lockdownstub = newstub;
        var_a0692a89.stub = newstub;
        var_a0692a89.var_6f08706b = stub;
        stub = newstub;
        zm_unitrigger::register_unitrigger(newstub, var_2baba799);
    }
    if (stub.lockdowntype === "lockdown_stub_type_perks") {
        stub.var_3468124 zm_perks::function_efd2c9e6();
    }
    stub.unlockfunc = unlockfunc;
    var_a0692a89.var_4f0ea1b5 = 1;
    var_a0692a89.claimed = 0;
    return stub;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0x20c4903e, Offset: 0x36a8
// Size: 0x24
function function_7bfa8895(entity) {
    return isdefined(function_4ad92a9a(entity));
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 1, eflags: 0x0
// Checksum 0xd5eb471f, Offset: 0x36d8
// Size: 0x48
function function_b5dd9241(stub) {
    var_a0692a89 = function_fd31eb92(stub);
    if (!isdefined(var_a0692a89)) {
        return false;
    }
    return var_a0692a89.var_4f0ea1b5 === 1;
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 2, eflags: 0x1 linked
// Checksum 0xf662c92f, Offset: 0x3728
// Size: 0x1aa
function function_c9105448(entity, stub) {
    switch (stub.lockdowntype) {
    case #"lockdown_stub_type_boards":
        return function_809ae5cb(entity, stub);
    case #"lockdown_stub_type_crafting_tables":
        current_zone = entity zm_utility::get_current_zone();
        return function_ea677a9a(entity, stub, current_zone);
    case #"lockdown_stub_type_magic_box":
        return function_95250640(entity, stub);
    case #"lockdown_stub_type_pap":
        return function_790e3eb0(entity, stub);
    case #"lockdown_stub_type_perks":
        current_zone = entity zm_utility::get_current_zone();
        return function_fea6f0c0(entity, stub, current_zone);
    case #"lockdown_stub_type_wallbuys":
        current_zone = entity zm_utility::get_current_zone();
        return function_d3fbb5ec(entity, stub, current_zone);
    case #"lockdown_stub_type_traps":
        return function_387fd27e(entity, stub);
    default:
        return 1;
    }
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x1 linked
// Checksum 0xa5ba1da9, Offset: 0x38e0
// Size: 0xf4
function function_ac6907ec() {
    var_a0692a89 = function_fd31eb92(self);
    if (isdefined(var_a0692a89)) {
        var_a0692a89.var_4f0ea1b5 = 2;
    }
    if (isdefined(self) && isdefined(self.unlockfunc)) {
        [[ self.unlockfunc ]](self);
    }
    self.prompt_and_visibility_func = self.var_a0fc37f6;
    self.trigger_func = self.var_492080a5;
    if (self.lockdowntype === "lockdown_stub_type_perks") {
        self.var_3468124 zm_perks::function_1e721859();
    }
    self.var_a0fc37f6 = undefined;
    self.var_492080a5 = undefined;
    function_66941fc3(self);
    zm_unitrigger::reregister_unitrigger(self);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd0b4c646, Offset: 0x39e0
// Size: 0xc4
function function_4de23f77() {
    var_a0692a89 = function_fd31eb92(self);
    if (isdefined(var_a0692a89)) {
        var_a0692a89.var_4f0ea1b5 = 2;
    }
    self.var_6f08706b.lockdownstub = undefined;
    if (isdefined(self) && isdefined(self.unlockfunc)) {
        [[ self.unlockfunc ]](self);
    }
    self.var_6f08706b triggerenable(1);
    function_66941fc3(self);
    zm_unitrigger::unregister_unitrigger(self);
}

// Namespace zm_lockdown_util/zm_lockdown_util
// Params 0, eflags: 0x0
// Checksum 0x4f937f, Offset: 0x3ab0
// Size: 0x96
function function_61a9bc58() {
    var_a0692a89 = function_fd31eb92(self);
    assert(isdefined(var_a0692a89));
    self.var_6156031a = 1;
    if (isdefined(self.var_6f08706b)) {
        self function_4de23f77();
    } else {
        self function_ac6907ec();
    }
    self.var_6156031a = undefined;
}

/#

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 4, eflags: 0x20 variadic
    // Checksum 0x4a51dd8d, Offset: 0x3b50
    // Size: 0x124
    function function_78eae22a(entity, stub, reason, ...) {
        if (getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
            if (!isdefined(entity.var_d187874c)) {
                entity.var_d187874c = [];
            } else if (!isarray(entity.var_d187874c)) {
                entity.var_d187874c = array(entity.var_d187874c);
            }
            entity.var_d187874c[entity.var_d187874c.size] = {#stub:stub, #reason:reason, #args:vararg};
        }
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 1, eflags: 0x0
    // Checksum 0x72862979, Offset: 0x3c80
    // Size: 0x520
    function function_f3cff6ff(entity) {
        if (!(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1)) {
            return;
        }
        if (!isdefined(entity.var_d187874c)) {
            return;
        }
        if (getdvarint(#"zm_lockdown_ent", -1) != entity getentitynumber()) {
            return;
        }
        foreach (var_ca00d79a in entity.var_d187874c) {
            text = entity getentitynumber() + "<dev string:x38>";
            color = (1, 0, 0);
            switch (var_ca00d79a.reason) {
            case 0:
                text += "<dev string:x3e>";
                break;
            case 1:
                text += "<dev string:x55>";
                break;
            case 2:
                text += "<dev string:x6f>";
                break;
            case 3:
                text += "<dev string:x7e>";
                break;
            case 4:
                text += "<dev string:x8c>";
                break;
            case 5:
                text += "<dev string:x9a>";
                break;
            case 6:
                text += "<dev string:xad>";
                break;
            case 8:
                text += "<dev string:xc3>" + var_ca00d79a.args[0];
                break;
            case 9:
                text += "<dev string:xd6>";
                break;
            case 7:
                text += "<dev string:xea>";
                break;
            case 11:
                text += "<dev string:xf5>" + var_ca00d79a.args[0];
                break;
            case 10:
                text += "<dev string:x104>";
                color = (0, 1, 0);
                break;
            case 13:
                text += "<dev string:x10f>";
                break;
            case 14:
                text += "<dev string:x11e>";
                recordstar(var_ca00d79a.args[0], (0, 1, 1));
                recordstar(var_ca00d79a.args[1].origin, (1, 0, 1));
                recordline(var_ca00d79a.args[1].origin, var_ca00d79a.args[1].origin + anglestoforward(var_ca00d79a.args[1].angles) * 10, (1, 1, 0));
                break;
            case 15:
                text += "<dev string:x144>";
                break;
            case 16:
                text += "<dev string:x155>";
                break;
            case 17:
                text += "<dev string:x168>";
                break;
            }
            recordstar(var_ca00d79a.stub.origin, (1, 1, 0));
            record3dtext(text, var_ca00d79a.stub.origin + (0, 0, 10), color);
        }
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 3, eflags: 0x4
    // Checksum 0x318b5c65, Offset: 0x41a8
    // Size: 0x100
    function private function_6351d1c3(entity, registerlotus_right, var_d05e79c8) {
        foreach (stub in registerlotus_right) {
            dist = distancesquared(entity.origin, stub.origin);
            if (dist > function_a3f6cdac(var_d05e79c8)) {
                function_78eae22a(entity, stub, 8, sqrt(dist));
            }
        }
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 0, eflags: 0x4
    // Checksum 0xd3f7dd15, Offset: 0x42b0
    // Size: 0xa4
    function private function_946bb116() {
        zm_devgui::add_custom_devgui_callback(&function_2765c63);
        adddebugcommand("<dev string:x17f>");
        adddebugcommand("<dev string:x1ba>");
        adddebugcommand("<dev string:x1e1>");
        adddebugcommand("<dev string:x21d>");
        adddebugcommand("<dev string:x27f>");
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 1, eflags: 0x4
    // Checksum 0x5c16794a, Offset: 0x4360
    // Size: 0xaa
    function private function_2765c63(cmd) {
        switch (cmd) {
        case #"hash_619d20b906a39230":
            level.var_cd20e41b = !is_true(level.var_cd20e41b);
            if (is_true(level.var_cd20e41b)) {
                level thread function_6e1690d5();
            } else {
                level notify(#"hash_52b90374b27fcb8a");
            }
            break;
        }
    }

    // Namespace zm_lockdown_util/zm_lockdown_util
    // Params 0, eflags: 0x4
    // Checksum 0xeeb703dc, Offset: 0x4418
    // Size: 0x3cc
    function private function_6e1690d5() {
        self notify("<dev string:x2e1>");
        self endon("<dev string:x2e1>");
        level endon(#"hash_52b90374b27fcb8a");
        stubs = arraycombine(level.exterior_goals, level.var_16cfe3ef, 0, 0);
        stubs = arraycombine(stubs, level.pap_lockdown_stubs, 0, 0);
        stubs = arraycombine(stubs, level.var_9235b607, 0, 0);
        stubs = arraycombine(stubs, level.var_2510f3e4, 0, 0);
        stubs = arraycombine(stubs, level.var_f17bdf53, 0, 0);
        foreach (chest in level.chests) {
            if (!isdefined(stubs)) {
                stubs = [];
            } else if (!isarray(stubs)) {
                stubs = array(stubs);
            }
            stubs[stubs.size] = chest.unitrigger_stub;
        }
        var_3bd3c0c1 = (-16, -16, 0);
        var_cbe5413e = (16, 16, 32);
        while (true) {
            wait 0.5;
            entity = getentbynum(getdvarint(#"zm_lockdown_ent", -1));
            if (!isdefined(entity)) {
                continue;
            }
            foreach (stub in stubs) {
                var_754b10b4 = function_dab6d796(entity, stub);
                if (isdefined(var_754b10b4)) {
                    box(var_754b10b4.origin, var_3bd3c0c1, var_cbe5413e, var_754b10b4.angles[1], (0, 1, 0), 1, 0, 10);
                    line(var_754b10b4.origin, var_754b10b4.origin + anglestoforward(var_754b10b4.angles) * 32, (0, 1, 0), 1, 0, 10);
                    continue;
                }
                circle(stub.origin, 16, (1, 0, 0), 0, 0, 10);
            }
        }
    }

#/
