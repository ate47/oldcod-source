#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace sgen_server_room;

// Namespace sgen_server_room
// Params 0
// Checksum 0xd57797d9, Offset: 0x220
// Size: 0xaa
function main()
{
    clientfield::register( "world", "infection_sgen_server_debris", 1, 2, "int", &handle_sgen_server_debris, 1, 1 );
    clientfield::register( "world", "infection_sgen_xcam_models", 1, 1, "int", &handle_sgen_xcam_models, 1, 1 );
    clientfield::register( "actor", "infection_taylor_eye_shader", 1, 1, "int", &function_1b21c3a8, 0, 0 );
}

// Namespace sgen_server_room
// Params 7
// Checksum 0xaf1aaa96, Offset: 0x2d8
// Size: 0xa1
function handle_sgen_server_debris( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( newval ) )
    {
        return;
    }
    
    switch ( newval )
    {
        case 1:
            level thread sgen_server_debris_init( localclientnum );
            break;
        case 2:
            level notify( #"server_debris_fall" );
            break;
        case 3:
            level notify( #"sgen_server_debris_done" );
            break;
        default:
            break;
    }
}

// Namespace sgen_server_room
// Params 1
// Checksum 0xc2f78f5f, Offset: 0x388
// Size: 0x142
function sgen_server_debris_init( localclientnum )
{
    debris = [];
    position = struct::get_array( "sgen_server_debris" );
    
    for ( i = 0; i < position.size ; i++ )
    {
        if ( isdefined( position[ i ].model ) )
        {
            junk = spawn( localclientnum, position[ i ].origin, "script_model" );
            junk setmodel( position[ i ].model );
            junk.targetname = position[ i ].targetname;
            
            if ( isdefined( position[ i ].angles ) )
            {
                junk.angles = position[ i ].angles;
            }
            
            if ( isdefined( position[ i ].script_noteworthy ) )
            {
                junk.script_noteworthy = position[ i ].script_noteworthy;
            }
            
            array::add( debris, junk, 0 );
        }
    }
    
    level waittill( #"server_debris_fall" );
    array::thread_all( debris, &sgen_server_debris_move );
}

// Namespace sgen_server_room
// Params 0
// Checksum 0x33fc93df, Offset: 0x4d8
// Size: 0x122
function sgen_server_debris_move()
{
    drop_distance = self get_drop_distance();
    drop_time = drop_distance / 600;
    drop_time_min = drop_time;
    drop_time_max = drop_time_min * 1.25;
    n_accel_time = drop_time * 0.25;
    drop_time_temp = randomfloatrange( drop_time_min, drop_time_max );
    endpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - drop_distance );
    self moveto( endpos, drop_time_temp );
    self rotateto( self.angles + ( randomfloatrange( -45, 45 ), randomfloatrange( -45, 45 ), randomfloatrange( -45, 45 ) ), drop_time_temp );
    level waittill( #"sgen_server_debris_done" );
    self delete();
}

// Namespace sgen_server_room
// Params 0
// Checksum 0x3220cba7, Offset: 0x608
// Size: 0x77
function get_drop_distance()
{
    forest_tag = struct::get( "tag_align_bastogne_sarah_intro", "targetname" );
    v_start = self.origin;
    v_end = forest_tag.origin;
    n_drop_distance = ( v_start - v_end )[ 2 ];
    return abs( n_drop_distance ) + 64 + 40;
}

// Namespace sgen_server_room
// Params 7
// Checksum 0x4d00a8b1, Offset: 0x688
// Size: 0xc3
function handle_sgen_xcam_models( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    xcam_models = getentarray( localclientnum, "pallas_xcam_model", "targetname" );
    
    foreach ( xcam_model in xcam_models )
    {
        xcam_model delete();
    }
}

// Namespace sgen_server_room
// Params 7
// Checksum 0xd3ed8301, Offset: 0x758
// Size: 0x83
function callback_left_arm_shader( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    timegap = 1.33333;
    
    for ( i = 0; i < 3 ; i++ )
    {
        thread dni_pulse( 0.1 );
        wait timegap;
    }
}

// Namespace sgen_server_room
// Params 2
// Checksum 0x4723736, Offset: 0x7e8
// Size: 0x55
function dni_pulse( localclientnum, speed )
{
    pulselevel = 0;
    pulselevel = 0;
    
    while ( pulselevel <= 1 )
    {
        self mapshaderconstant( localclientnum, 0, "scriptVector1", pulselevel );
        pulselevel += speed;
    }
}

// Namespace sgen_server_room
// Params 7
// Checksum 0xaf81316d, Offset: 0x848
// Size: 0x6a
function function_1b21c3a8( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            self mapshaderconstant( localclientnum, 0, "scriptVector0", 1, 1, 0, 0 );
        }
    }
}

