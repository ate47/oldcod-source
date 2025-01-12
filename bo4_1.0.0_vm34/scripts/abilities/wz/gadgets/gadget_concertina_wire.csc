#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\system_shared;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x2
// Checksum 0x2d64b593, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_concertina_wire", &__init__, undefined, undefined);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0x5e9b442a, Offset: 0xe0
// Size: 0x1c
function __init__() {
    init_shared("concertina_wire_settings_wz");
}
