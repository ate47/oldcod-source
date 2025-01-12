#using script_54f593f5beb1464a;

#namespace warzone_fixup;

// Namespace warzone_fixup/warzone_fixup
// Params 0, eflags: 0x2
// Checksum 0x85251fbc, Offset: 0x68
// Size: 0x124
function autoexec __init__() {
    waitframe(1);
    maxteamplayers = isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;
    switch (maxteamplayers) {
    case 1:
        function_d0dc6619();
        break;
    case 2:
        function_f16631fc();
        break;
    case 4:
    default:
        function_91d1fd09();
        break;
    }
    function_4305a789();
    function_c94723bd();
}

// Namespace warzone_fixup/warzone_fixup
// Params 0, eflags: 0x5 linked
// Checksum 0xfd3b574e, Offset: 0x198
// Size: 0x1c
function private function_4305a789() {
    function_9b8d4d02(1);
}

// Namespace warzone_fixup/warzone_fixup
// Params 0, eflags: 0x5 linked
// Checksum 0x7139ce62, Offset: 0x1c0
// Size: 0x104
function private function_c94723bd() {
    var_d1d7eefb = isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0;
    if (!var_d1d7eefb) {
        function_9b8d4d02();
    }
    if (!(isdefined(getgametypesetting(#"hash_1d02e28ba907a343")) ? getgametypesetting(#"hash_1d02e28ba907a343") : 0)) {
        item_world_fixup::function_96ff7b88(#"perk_item_bloody_tracker");
        item_world_fixup::remove_item(#"perk_item_bloody_tracker");
    }
}

// Namespace warzone_fixup/warzone_fixup
// Params 1, eflags: 0x5 linked
// Checksum 0x822877b6, Offset: 0x2d0
// Size: 0x100
function private function_9b8d4d02(prematch = 0) {
    var_3a1737b4 = getscriptbundles(#"itemspawnentry");
    foreach (var_1461de43, var_28f8f6a9 in var_3a1737b4) {
        if (var_28f8f6a9.itemtype == #"quest") {
            if (prematch) {
                item_world_fixup::function_96ff7b88(var_1461de43);
                continue;
            }
            item_world_fixup::remove_item(var_1461de43);
        }
    }
}

// Namespace warzone_fixup/warzone_fixup
// Params 0, eflags: 0x5 linked
// Checksum 0x178b5c1c, Offset: 0x3d8
// Size: 0x44
function private function_d0dc6619() {
    item_world_fixup::function_96ff7b88(#"perk_item_squadlink");
    item_world_fixup::remove_item(#"perk_item_squadlink");
}

// Namespace warzone_fixup/warzone_fixup
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x428
// Size: 0x4
function private function_f16631fc() {
    
}

// Namespace warzone_fixup/warzone_fixup
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x438
// Size: 0x4
function private function_91d1fd09() {
    
}

