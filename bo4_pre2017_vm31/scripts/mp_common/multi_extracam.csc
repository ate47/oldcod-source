#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace multi_extracam;

// Namespace multi_extracam/multi_extracam
// Params 0, eflags: 0x2
// Checksum 0xfb5722, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "multi_extracam", &__init__, undefined, undefined );
}

// Namespace multi_extracam/multi_extracam
// Params 1
// Checksum 0xf800ec3c, Offset: 0x1b8
// Size: 0x2c
function __init__( localclientnum )
{
    callback::on_localclient_connect( &multi_extracam_init );
}

// Namespace multi_extracam/multi_extracam
// Params 1
// Checksum 0xb21fae38, Offset: 0x1f0
// Size: 0x196
function multi_extracam_init( localclientnum )
{
    triggers = getentarray( localclientnum, "multicam_enable", "targetname" );
    
    for ( i = 1; i <= 4 ; i++ )
    {
        camerastruct = struct::get( "extracam" + i, "targetname" );
        
        if ( isdefined( camerastruct ) )
        {
            camera_ent = spawn( localclientnum, camerastruct.origin, "script_origin" );
            camera_ent.angles = camerastruct.angles;
            width = isdefined( camerastruct.extracam_width ) ? camerastruct.extracam_width : -1;
            height = isdefined( camerastruct.extracam_height ) ? camerastruct.extracam_height : -1;
            camera_ent setextracam( i - 1, width, height );
        }
    }
}

