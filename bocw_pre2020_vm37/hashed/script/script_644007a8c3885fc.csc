#using script_309ce7f5a9a023de;
#using scripts\core_common\system_shared;

#namespace namespace_1c7b37c6;

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 0, eflags: 0x6
// Checksum 0xd20b89c3, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_28a40055ae0e64e0", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 0, eflags: 0x2
// Checksum 0x64813ec5, Offset: 0xb8
// Size: 0x14
function autoexec __init() {
    function_41453b43();
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0xd8
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 3, eflags: 0x0
// Checksum 0xe636520d, Offset: 0xe8
// Size: 0x52
function item_remover(func1, func2, param1) {
    if (!isdefined(param1)) {
        return;
    }
    if (isdefined(func1)) {
        [[ func1 ]](param1);
    }
    if (isdefined(func2)) {
        [[ func2 ]](param1);
    }
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 4, eflags: 0x1 linked
// Checksum 0x8907c956, Offset: 0x148
// Size: 0x68
function item_replacer(func1, func2, var_f3ef555b, var_e3c89f9) {
    if (!isdefined(var_f3ef555b) || !isdefined(var_e3c89f9)) {
        return;
    }
    if (isdefined(func1)) {
        [[ func1 ]](var_f3ef555b, var_e3c89f9);
    }
    if (isdefined(func2)) {
        [[ func2 ]](var_f3ef555b, var_e3c89f9);
    }
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 0, eflags: 0x1 linked
// Checksum 0x426584c4, Offset: 0x1b8
// Size: 0x96
function function_41453b43() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
}

