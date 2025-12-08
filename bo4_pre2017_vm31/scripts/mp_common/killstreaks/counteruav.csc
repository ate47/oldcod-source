#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0, eflags: 0x2
// Checksum 0x8fdb0b04, Offset: 0x138
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "counteruav", &__init__, undefined, undefined );
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xe7c68175, Offset: 0x178
// Size: 0x4c
function __init__()
{
    clientfield::register( "toplayer", "counteruav", 1, 1, "int", &counteruavchanged, 0, 1 );
}

// Namespace counteruav/counteruav
// Params 7
// Checksum 0x8db20ab, Offset: 0x1d0
// Size: 0x94
function counteruavchanged( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    assert( isdefined( player ) );
    player setenemyglobalscrambler( newval );
}

