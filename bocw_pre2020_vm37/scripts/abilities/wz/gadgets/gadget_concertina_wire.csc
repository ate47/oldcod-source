#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\system_shared;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x6
// Checksum 0x3c41d14b, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_concertina_wire", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x5 linked
// Checksum 0x66c7e705, Offset: 0xd8
// Size: 0x1c
function private function_70a657d8() {
    init_shared("concertina_wire_settings_wz");
}

