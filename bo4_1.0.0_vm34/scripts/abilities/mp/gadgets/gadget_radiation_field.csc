#using scripts\abilities\gadgets\gadget_radiation_field;
#using scripts\core_common\system_shared;

#namespace gadget_radiation_field;

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x2
// Checksum 0x14bb3954, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_radiation_field", &__init__, undefined, undefined);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0x692efb88, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}

