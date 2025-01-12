#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\system_shared;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x2
// Checksum 0x1817a4cf, Offset: 0x98
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"concertina_wire", &__init__, undefined, #"weapons");
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0xf6cf5943, Offset: 0xe8
// Size: 0x3c
function __init__() {
    init_shared("concertina_wire_settings_wz");
    function_a9398b3c(&onconcertinawireplaced);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x84fc9e90, Offset: 0x130
// Size: 0xc
function onconcertinawireplaced(concertinawire) {
    
}
