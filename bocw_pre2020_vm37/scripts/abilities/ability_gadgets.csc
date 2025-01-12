#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace ability_gadgets;

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x6
// Checksum 0x7fccc33f, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ability_gadgets", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x5 linked
// Checksum 0x3e800eab, Offset: 0x128
// Size: 0xf4
function private function_70a657d8() {
    clientfield::register_clientuimodel("huditems.abilityHoldToActivate", #"hash_6f4b11a0bee9b73d", #"abilityholdtoactivate", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("huditems.abilityDelayProgress", #"hash_6f4b11a0bee9b73d", #"abilitydelayprogress", 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.abilityHintIndex", #"hash_6f4b11a0bee9b73d", #"abilityhintindex", 1, 4, "int", undefined, 0, 0);
}

