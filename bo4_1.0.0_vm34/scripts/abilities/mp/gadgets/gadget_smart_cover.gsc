#using scripts\abilities\gadgets\gadget_smart_cover;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\util;

#namespace smart_cover;

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x2
// Checksum 0xb028d62a, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"smart_cover", &__init__, undefined, undefined);
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x898e90da, Offset: 0xe8
// Size: 0x34
function __init__() {
    init_shared();
    function_a2d000d3(&onsmartcoverplaced);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x33c07816, Offset: 0x128
// Size: 0x3c
function onsmartcoverplaced(smartcover) {
    self battlechatter::function_b505bc94(smartcover.weapon, undefined, smartcover.origin, smartcover);
}

