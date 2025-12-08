#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace autoturret;

// Namespace autoturret/mini_turret
// Params 0, eflags: 0x2
// Checksum 0x462d84be, Offset: 0x1e0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "mini_turret", &__init__, undefined, undefined );
}

// Namespace autoturret/mini_turret
// Params 0
// Checksum 0xd95c3225, Offset: 0x220
// Size: 0xdc
function __init__()
{
    clientfield::register( "vehicle", "mini_turret_open", 1, 1, "int", &turret_open, 0, 0 );
    clientfield::register( "scriptmover", "mini_turret_init", 1, 1, "int", &turret_init_anim, 0, 0 );
    clientfield::register( "scriptmover", "mini_turret_close", 1, 1, "int", &turret_close_anim, 0, 0 );
}

#using_animtree( "mp_autoturret" );

// Namespace autoturret/mini_turret
// Params 7
// Checksum 0xc4481001, Offset: 0x308
// Size: 0xc4
function turret_init_anim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
    
    self useanimtree( #animtree );
    self setanimrestart( %o_turret_sentry_close, 1, 0, 1 );
    self setanimtime( %o_turret_sentry_close, 1 );
}

// Namespace autoturret/mini_turret
// Params 7
// Checksum 0x7be4472a, Offset: 0x3d8
// Size: 0x9c
function turret_open( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
    
    self useanimtree( #animtree );
    self setanimrestart( %o_turret_sentry_deploy, 1, 0, 1 );
}

// Namespace autoturret/mini_turret
// Params 7
// Checksum 0x5470d4b9, Offset: 0x480
// Size: 0x9c
function turret_close_anim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
    
    self useanimtree( #animtree );
    self setanimrestart( %o_turret_sentry_close, 1, 0, 1 );
}

