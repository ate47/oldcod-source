#using script_309ce7f5a9a023de;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\system_shared;

#namespace character_unlock;

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x6
// Checksum 0xdc10ac8a, Offset: 0x80
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"character_unlock", &function_70a657d8, undefined, undefined, #"character_unlock_fixup");
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0xd0
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace character_unlock/character_unlock
// Params 3, eflags: 0x0
// Checksum 0xf1c2d980, Offset: 0xe0
// Size: 0x1c
function function_d2294476(*var_2ab9d3bd, *replacementcount, *var_3afaa57b) {
    
}

