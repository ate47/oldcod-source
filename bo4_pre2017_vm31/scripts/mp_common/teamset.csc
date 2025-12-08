#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace teamset;

// Namespace teamset/teamset
// Params 0, eflags: 0x2
// Checksum 0x1bb7d101, Offset: 0xd8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "teamset_seals", &__init__, undefined, undefined );
}

// Namespace teamset/teamset
// Params 0
// Checksum 0x21f0e722, Offset: 0x118
// Size: 0x2c
function __init__()
{
    level.allies_team = "allies";
    level.axis_team = "axis";
}

