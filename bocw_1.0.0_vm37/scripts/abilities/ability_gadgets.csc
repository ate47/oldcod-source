#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace ability_gadgets;

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x6
// Checksum 0xf0cadbf2, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ability_gadgets", &preinit, undefined, undefined, undefined);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x4
// Checksum 0x26f025a, Offset: 0x110
// Size: 0xa4
function private preinit() {
    clientfield::register_clientuimodel("huditems.abilityHoldToActivate", #"hud_items", #"abilityholdtoactivate", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("huditems.abilityDelayProgress", #"hud_items", #"abilitydelayprogress", 1, 5, "float", undefined, 0, 0);
}

