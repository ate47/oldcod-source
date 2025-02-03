#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\system_shared;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x6
// Checksum 0xf5793b85, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_concertina_wire", &preinit, undefined, undefined, undefined);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x4
// Checksum 0x4c48d707, Offset: 0xd8
// Size: 0x1c
function private preinit() {
    init_shared("concertina_wire_settings_wz");
}

