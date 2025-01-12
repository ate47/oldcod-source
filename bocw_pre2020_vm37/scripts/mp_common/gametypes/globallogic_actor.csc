#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace globallogic_actor;

// Namespace globallogic_actor/globallogic_actor
// Params 0, eflags: 0x6
// Checksum 0x40bd3bb7, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"globallogic_actor", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace globallogic_actor/globallogic_actor
// Params 0, eflags: 0x5 linked
// Checksum 0xa05a29cf, Offset: 0xd8
// Size: 0x2c
function private function_70a657d8() {
    level._effect[#"rcbombexplosion"] = #"killstreaks/fx_rcxd_exp";
}

