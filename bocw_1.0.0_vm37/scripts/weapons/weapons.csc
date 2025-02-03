#using script_2c8f0cd222d353a3;
#using scripts\core_common\clientfield_shared;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x7ae0b09, Offset: 0xa0
// Size: 0x8c
function init_shared() {
    level.weaponnone = getweapon(#"none");
    clientfield::register_clientuimodel("hudItems.pickupHintWeaponIndex", #"hud_items", #"pickuphintweaponindex", 1, 10, "int", undefined, 0, 0);
    namespace_daf1661f::init();
}

