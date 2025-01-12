#using script_2c8f0cd222d353a3;
#using scripts\core_common\clientfield_shared;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x55ff7136, Offset: 0xa0
// Size: 0x8c
function init_shared() {
    level.weaponnone = getweapon(#"none");
    clientfield::register_clientuimodel("hudItems.pickupHintWeaponIndex", #"hash_6f4b11a0bee9b73d", #"pickuphintweaponindex", 1, 10, "int", undefined, 0, 0);
    namespace_daf1661f::init();
}

