#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\weapons\ballistic_knife;

#namespace ballistic_knife;

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x2
// Checksum 0xf51a1615, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"ballistic_knife", &__init__, undefined, undefined);
}

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0x9873ba65, Offset: 0xd8
// Size: 0x14
function __init__() {
    init_shared();
}

