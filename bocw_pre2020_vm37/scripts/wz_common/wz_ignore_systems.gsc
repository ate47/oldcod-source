#using scripts\core_common\system_shared;

#namespace wz_ignore_systems;

// Namespace wz_ignore_systems/wz_ignore_systems
// Params 0, eflags: 0x2
// Checksum 0x1bcfef4a, Offset: 0x68
// Size: 0x24
function autoexec ignore_systems() {
    system::ignore(#"armor_station");
}

