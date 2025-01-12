#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_hero_weapon;

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x6
// Checksum 0x2430760c, Offset: 0x118
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_hero_weapons", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x5 linked
// Checksum 0x4478c860, Offset: 0x160
// Size: 0x194
function private function_70a657d8() {
    clientfield::register_clientuimodel("zmhud.weaponLevel", #"zm_hud", #"weaponlevel", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("zmhud.weaponProgression", #"zm_hud", #"weaponprogression", 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("zmhud.swordEnergy", #"zm_hud", #"swordenergy", 1, 7, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("zmhud.swordState", #"zm_hud", #"swordstate", 1, 4, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("zmhud.swordChargeUpdate", #"zm_hud", #"swordchargeupdate", 1, 1, "counter", undefined, 0, 0);
}

