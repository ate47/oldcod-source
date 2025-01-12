#using scripts\abilities\gadgets\gadget_radiation_field;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\util;

#namespace gadget_radiation_field;

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x2
// Checksum 0xcdfbeba4, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_radiation_field", &__init__, undefined, undefined);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0x71bb6c6b, Offset: 0xe8
// Size: 0x34
function __init__() {
    init_shared();
    function_16e396e9(&function_b8682531);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x901ec5ca, Offset: 0x128
// Size: 0x3c
function function_b8682531(var_ec57206e) {
    self battlechatter::function_b505bc94(var_ec57206e, undefined, self geteye(), self);
}

