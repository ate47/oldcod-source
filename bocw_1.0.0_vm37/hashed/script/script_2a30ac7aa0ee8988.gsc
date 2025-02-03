#using script_54f593f5beb1464a;
#using scripts\core_common\system_shared;

#namespace namespace_1c7b37c6;

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 0, eflags: 0x6
// Checksum 0x1b33630d, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_28a40055ae0e64e0", &preinit, undefined, undefined, undefined);
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 0, eflags: 0x2
// Checksum 0xfb005442, Offset: 0xb8
// Size: 0x14
function autoexec __init() {
    function_41453b43();
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xd8
// Size: 0x4
function private preinit() {
    
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 2, eflags: 0x0
// Checksum 0x2f6844a6, Offset: 0xe8
// Size: 0x34
function item_remover(func1, param1) {
    if (!isdefined(param1)) {
        return;
    }
    if (isdefined(func1)) {
        [[ func1 ]](param1);
    }
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 3, eflags: 0x0
// Checksum 0x79fc57b1, Offset: 0x128
// Size: 0x4a
function item_replacer(func1, list1, list2) {
    if (!isdefined(list1) || !isdefined(list2)) {
        return;
    }
    if (isdefined(func1)) {
        [[ func1 ]](list1, list2);
    }
}

// Namespace namespace_1c7b37c6/namespace_1c7b37c6
// Params 0, eflags: 0x0
// Checksum 0xdba575e3, Offset: 0x180
// Size: 0x4e
function function_41453b43() {
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
}

