#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\util;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x2
// Checksum 0xa3225cfc, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"concertina_wire", &__init__, undefined, undefined);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0xc9098c45, Offset: 0x108
// Size: 0x4a
function __init__() {
    init_shared("concertina_wire_settings");
    function_a9398b3c(&onconcertinawireplaced);
    level.var_a2ddb254 = 0;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x3e04e26b, Offset: 0x160
// Size: 0x3c
function onconcertinawireplaced(concertinawire) {
    self battlechatter::function_b505bc94(concertinawire.weapon, undefined, concertinawire.origin, concertinawire);
}

