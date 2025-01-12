#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_bonfire_sale;

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 0, eflags: 0x6
// Checksum 0xac1beb60, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_bonfire_sale", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_bonfire_sale/zm_powerup_bonfire_sale
// Params 0, eflags: 0x5 linked
// Checksum 0xa4d9339f, Offset: 0xe8
// Size: 0x4c
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("bonfire_sale");
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("bonfire_sale", "powerup_bon_fire");
    }
}

