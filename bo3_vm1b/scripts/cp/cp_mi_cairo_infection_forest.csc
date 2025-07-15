#using scripts/codescripts/struct;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection_forest;

// Namespace cp_mi_cairo_infection_forest
// Params 0
// Checksum 0x8ef615f, Offset: 0x338
// Size: 0x22
function main()
{
    init_clientfields();
    level thread mortar_test();
}

// Namespace cp_mi_cairo_infection_forest
// Params 0
// Checksum 0x1f8133ea, Offset: 0x368
// Size: 0x18a
function init_clientfields()
{
    clientfield::register( "world", "forest_mortar_index", 1, 3, "int", &callback_mortar_index, 0, 0 );
    clientfield::register( "world", "forest_surreal_exposure", 1, 1, "int", &function_bcf75575, 0, 0 );
    clientfield::register( "toplayer", "pstfx_frost_up", 1, 1, "counter", &callback_pstfx_frost_up, 0, 0 );
    clientfield::register( "toplayer", "pstfx_frost_down", 1, 1, "counter", &callback_pstfx_frost_down, 0, 0 );
    clientfield::register( "scriptmover", "wfa_steam_sound", 1, 1, "counter", &function_1a244510, 0, 0 );
    clientfield::register( "scriptmover", "cp_infection_world_falls_break_rumble", 1, 1, "counter", &function_5d6ca4fb, 0, 0 );
    clientfield::register( "scriptmover", "cp_infection_world_falls_away_rumble", 1, 1, "counter", &function_5d6ca4fb, 0, 0 );
}

// Namespace cp_mi_cairo_infection_forest
// Params 7
// Checksum 0x4180b4d7, Offset: 0x500
// Size: 0x71
function callback_mortar_index( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 0 )
    {
        level.mortar_start = 0;
        return;
    }
    
    if ( newval )
    {
        level.mortar_start = 1;
        level.mortar_index = newval;
        level.mortar_index_randomize = 1;
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 0
// Checksum 0x960ce755, Offset: 0x580
// Size: 0x299
function mortar_test()
{
    if ( !isdefined( level.mortar_index ) )
    {
        level.mortar_index = 0;
        level.mortar_index_randomize = 1;
    }
    
    index = 0;
    delay = 3;
    
    while ( true )
    {
        while ( !( isdefined( level.mortar_start ) && level.mortar_start ) )
        {
            wait 1;
        }
        
        switch ( level.mortar_index )
        {
            case 0:
                a_struct = struct::get_array( "s_background_mortar_0", "targetname" );
                delay = randomfloatrange( 0.5, 1 );
                break;
            case 1:
                a_struct = struct::get_array( "s_background_mortar_1", "targetname" );
                delay = randomfloatrange( 1.5, 2.5 );
                break;
            case 2:
                a_struct = struct::get_array( "s_background_mortar_2", "targetname" );
                delay = randomfloatrange( 1.5, 2 );
                break;
            case 3:
                a_struct = struct::get_array( "s_background_mortar_3", "targetname" );
                delay = randomfloatrange( 1.5, 2.5 );
                break;
            case 4:
                a_struct = struct::get_array( "s_background_mortar_4", "targetname" );
                delay = randomfloatrange( 5, 8 );
                break;
            case 5:
                a_struct = struct::get_array( "s_background_mortar_5", "targetname" );
                delay = randomfloatrange( 5, 8 );
                break;
            case 6:
            default:
                return;
        }
        
        if ( isdefined( level.mortar_index_randomize ) )
        {
            index = randomint( a_struct.size );
            level.mortar_index_randomize = undefined;
        }
        
        playfx( 0, "explosions/fx_exp_mortar_snow_reverse", a_struct[ index ].origin );
        index++;
        
        if ( index >= a_struct.size )
        {
            index = 0;
        }
        
        wait delay;
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7
// Checksum 0x3bf2521c, Offset: 0x828
// Size: 0xaf
function callback_forest_sgen_falling_debris( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread forest_debris_manager( localclientnum, 1, 0.4 );
        level thread forest_debris_manager( localclientnum, 5, 0.4 );
        level thread forest_debris_manager( localclientnum, 9, 0.4 );
        level thread forest_debris_manager( localclientnum, 12, 0.4 );
        return;
    }
    
    level notify( #"sgen_debris_cleanup" );
}

// Namespace cp_mi_cairo_infection_forest
// Params 3
// Checksum 0xc923c935, Offset: 0x8e0
// Size: 0x8b
function forest_debris_manager( localclientnum, start_index, delay )
{
    level endon( #"sgen_debris_cleanup" );
    
    for ( debris_num = start_index; true ; debris_num = 1 )
    {
        level thread forest_debris( localclientnum, debris_num );
        wait_time = delay + randomfloatrange( delay * -1 / 4, delay / 4 );
        wait wait_time;
        debris_num++;
        
        if ( debris_num > 15 )
        {
        }
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 2
// Checksum 0x2db059de, Offset: 0x978
// Size: 0x1db
function forest_debris( localclientnum, n_path_id )
{
    debris = [];
    a_debris_s = struct::get_array( "forest_debris" );
    
    for ( i = 0; i < a_debris_s.size ; i++ )
    {
        if ( isdefined( a_debris_s[ i ].model ) && a_debris_s[ i ].script_index == n_path_id )
        {
            junk = spawn( localclientnum, a_debris_s[ i ].origin, "script_model" );
            junk setmodel( a_debris_s[ i ].model );
            junk.targetname = a_debris_s[ i ].targetname;
            speed = a_debris_s[ i ].script_physics;
            speed = 120;
            junk.speed = randomfloatrange( speed, speed + -106 );
            junk.speed_rotate = randomfloatrange( a_debris_s[ i ].script_turnrate, a_debris_s[ i ].script_turnrate + 1.5 );
            
            if ( isdefined( a_debris_s[ i ].angles ) )
            {
                junk.angles = a_debris_s[ i ].angles;
            }
            
            array::add( debris, junk, 0 );
        }
    }
    
    foreach ( junk in debris )
    {
        junk thread move_junk( localclientnum, n_path_id );
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 2
// Checksum 0x3e9a22a8, Offset: 0xb60
// Size: 0x1d2
function move_junk( localclientnum, n_path_id )
{
    s_current = struct::get( "forest_debris_path_" + n_path_id );
    junk_rotater = util::spawn_model( localclientnum, "tag_origin", self.origin, self.angles );
    self linkto( junk_rotater );
    junk_mover = util::spawn_model( localclientnum, "tag_origin", s_current.origin, self.angles );
    junk_rotater linkto( junk_mover );
    self thread rotate_junk( junk_rotater );
    
    while ( isdefined( s_current.target ) )
    {
        s_next = struct::get( s_current.target );
        n_dist = distance( s_current.origin, s_next.origin );
        n_time = n_dist / self.speed;
        junk_mover moveto( s_next.origin, n_time, 0, 0 );
        junk_mover waittill( #"movedone" );
        s_current = s_next;
    }
    
    self notify( #"junk_path_end" );
    self unlink();
    pos = self.origin;
    angles = self.angles;
    self delete();
    junk_mover delete();
}

// Namespace cp_mi_cairo_infection_forest
// Params 1
// Checksum 0x1e4dc293, Offset: 0xd40
// Size: 0x8a
function rotate_junk( junk_rotater )
{
    self endon( #"junk_path_end" );
    n_revolution = 1000;
    n_rotation = 360 * n_revolution;
    n_time = n_rotation / 360 * self.speed_rotate;
    
    while ( true )
    {
        junk_rotater rotateroll( n_rotation, n_time, 0, 0 );
        junk_rotater waittill( #"rotatedone" );
    }
    
    junk_rotater delete();
}

// Namespace cp_mi_cairo_infection_forest
// Params 7
// Checksum 0x3194e678, Offset: 0xdd8
// Size: 0xa2
function callback_pstfx_frost_up( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    
    if ( !isdefined( player.pstfx_frost ) )
    {
        player.pstfx_frost = 0;
    }
    
    if ( player.pstfx_frost == 0 )
    {
        player.pstfx_frost = 1;
        player postfx::playpostfxbundle( "pstfx_frost_loop" );
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7
// Checksum 0xab6e990, Offset: 0xe88
// Size: 0x82
function callback_pstfx_frost_down( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    
    if ( player.pstfx_frost === 1 )
    {
        player.pstfx_frost = 0;
        player thread postfx::exitpostfxbundle();
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7
// Checksum 0x3a427eaa, Offset: 0xf18
// Size: 0x5a
function function_1a244510( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        playsound( localclientnum, "evt_small_flyaway_steam", self.origin );
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7
// Checksum 0x983e7c66, Offset: 0xf80
// Size: 0x5a
function function_5d6ca4fb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        playrumbleonposition( localclientnum, fieldname, self.origin );
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7
// Checksum 0xebe37e9e, Offset: 0xfe8
// Size: 0x5a
function function_bcf75575( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval && newval != oldval )
    {
        level thread function_3d919555( localclientnum );
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 1
// Checksum 0xace8ebbf, Offset: 0x1050
// Size: 0x32
function function_3d919555( localclientnum )
{
    setexposureactivebank( localclientnum, 2 );
    wait 1;
    setexposureactivebank( localclientnum, 1 );
}

