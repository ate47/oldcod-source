#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_player;

#namespace zm_bgb_equip_mint;

// Namespace zm_bgb_equip_mint/zm_bgb_equip_mint
// Params 0, eflags: 0x2
// Checksum 0x5d580697, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bgb_equip_mint", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_equip_mint/zm_bgb_equip_mint
// Params 0, eflags: 0x0
// Checksum 0x95c78d49, Offset: 0xe8
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_equip_mint", "activated", 1, undefined, undefined, &validation, &activation);
}

// Namespace zm_bgb_equip_mint/zm_bgb_equip_mint
// Params 0, eflags: 0x0
// Checksum 0x2237b6fc, Offset: 0x168
// Size: 0x74
function activation() {
    w_lethal = self zm_loadout::get_player_lethal_grenade();
    if (w_lethal.isgadget) {
        n_slot = self gadgetgetslot(w_lethal);
        self gadgetpowerreset(n_slot, 0);
    }
}

// Namespace zm_bgb_equip_mint/zm_bgb_equip_mint
// Params 0, eflags: 0x0
// Checksum 0x95d51078, Offset: 0x1e8
// Size: 0xcc
function validation() {
    w_lethal = self zm_loadout::get_player_lethal_grenade();
    n_stock_size = self getweaponammostock(w_lethal);
    n_clip_size = self getweaponammoclipsize(w_lethal);
    n_slot = self gadgetgetslot(w_lethal);
    n_power = self gadgetpowerget(n_slot);
    if (n_stock_size < n_clip_size || n_power < 100) {
        return true;
    }
    return false;
}

