#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace globallogic;

// Namespace globallogic/globallogic
// Params 0, eflags: 0x6
// Checksum 0x607b75c3, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"globallogic", &function_70a657d8, undefined, undefined, #"visionset_mgr");
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x5 linked
// Checksum 0xb61381ec, Offset: 0x130
// Size: 0x8c
function private function_70a657d8() {
    visionset_mgr::register_visionset_info("crithealth", 1, 25, undefined, "critical_health");
    clientfield::register_clientuimodel("hudItems.armorIsOnCooldown", #"hash_6f4b11a0bee9b73d", #"armorisoncooldown", 1, 1, "int", undefined, 0, 0);
    level.new_health_model = 1;
}

