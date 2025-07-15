#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace village_surreal;

// Namespace village_surreal
// Params 0
// Checksum 0xbb543a1a, Offset: 0x350
// Size: 0x12
function main()
{
    init_clientfields();
}

// Namespace village_surreal
// Params 0
// Checksum 0xa4e868b5, Offset: 0x370
// Size: 0x18a
function init_clientfields()
{
    clientfield::register( "world", "infection_fold_debris_1", 1, 1, "counter", &infection_fold_debris_1, 0, 0 );
    clientfield::register( "world", "infection_fold_debris_2", 1, 1, "int", &infection_fold_debris_2, 0, 1 );
    clientfield::register( "world", "infection_fold_debris_3", 1, 1, "int", &infection_fold_debris_3, 0, 1 );
    clientfield::register( "world", "infection_fold_debris_4", 1, 1, "int", &infection_fold_debris_4, 0, 1 );
    clientfield::register( "world", "light_church_ext_window", 1, 1, "int", &callback_light_church_ext_window, 0, 1 );
    clientfield::register( "world", "light_church_int_all", 1, 1, "int", &callback_light_church_int_all, 0, 0 );
    clientfield::register( "world", "dynent_catcher", 1, 1, "int", &callback_dynent_catcher, 0, 0 );
}

// Namespace village_surreal
// Params 7
// Checksum 0x35e5c2db, Offset: 0x508
// Size: 0x52
function infection_fold_debris_1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread fold_debris( localclientnum, 1 );
    }
}

// Namespace village_surreal
// Params 7
// Checksum 0x1d3fe862, Offset: 0x568
// Size: 0x62
function infection_fold_debris_2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval && newval != 0 )
    {
        level thread fold_debris( localclientnum, 2 );
    }
}

// Namespace village_surreal
// Params 7
// Checksum 0xc05acdc1, Offset: 0x5d8
// Size: 0x62
function infection_fold_debris_3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval && newval != 0 )
    {
        level thread fold_debris( localclientnum, 3 );
    }
}

// Namespace village_surreal
// Params 7
// Checksum 0x1673aaf6, Offset: 0x648
// Size: 0x62
function infection_fold_debris_4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval && newval != 0 )
    {
        level thread fold_debris( localclientnum, 4 );
    }
}

// Namespace village_surreal
// Params 7
// Checksum 0xa076e82f, Offset: 0x6b8
// Size: 0x125
function callback_light_church_ext_window( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    a_skiptos = skipto::get_current_skiptos();
    
    if ( isdefined( a_skiptos ) )
    {
        switch ( a_skiptos[ 0 ] )
        {
            case "black_station":
            case "forest_intro":
            case "forest_sky_bridge":
            case "forest_surreal":
            case "forest_tunnel":
            case "forest_wolves":
            case "sgen_server_room":
            case "village":
            case "village_house":
            case "village_inception":
                if ( bnewent )
                {
                    level thread monitor_t_light_church_ext_window_off( localclientnum );
                }
                else if ( !binitialsnap )
                {
                    if ( newval != oldval && newval == 1 )
                    {
                        exploder::exploder( "light_church_ext_window" );
                    }
                    else
                    {
                        exploder::stop_exploder( "light_church_ext_window" );
                    }
                }
            default:
                break;
        }
    }
}

// Namespace village_surreal
// Params 7
// Checksum 0xe2ee5239, Offset: 0x7e8
// Size: 0x72
function callback_light_church_int_all( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::exploder( "light_church_int_all" );
        return;
    }
    
    exploder::stop_exploder( "light_church_int_all" );
}

// Namespace village_surreal
// Params 2
// Checksum 0x1a538d67, Offset: 0x868
// Size: 0x1e3
function fold_debris( localclientnum, n_path_id )
{
    debris = [];
    position = struct::get_array( "fold_debris" );
    
    for ( i = 0; i < position.size ; i++ )
    {
        if ( isdefined( position[ i ].model ) && position[ i ].script_index == n_path_id )
        {
            junk = spawn( localclientnum, position[ i ].origin, "script_model" );
            junk setmodel( position[ i ].model );
            junk.targetname = position[ i ].targetname;
            junk.speed = randomfloatrange( position[ i ].script_physics, position[ i ].script_physics + 50 );
            junk.speed_rotate = randomfloatrange( position[ i ].script_turnrate, position[ i ].script_turnrate + 0.5 );
            
            if ( isdefined( position[ i ].angles ) )
            {
                junk.angles = position[ i ].angles;
            }
            
            array::add( debris, junk, 0 );
        }
    }
    
    foreach ( junk in debris )
    {
        junk thread move_junk( localclientnum, n_path_id );
        junk thread sndjunkwhizby();
    }
}

// Namespace village_surreal
// Params 2
// Checksum 0x829d03ae, Offset: 0xa58
// Size: 0x1f2
function move_junk( localclientnum, n_path_id )
{
    s_current = struct::get( "fold_debris_path_" + n_path_id );
    offset = self.origin - s_current.origin;
    junk_rotater = util::spawn_model( localclientnum, "tag_origin", self.origin, self.angles );
    self linkto( junk_rotater );
    junk_mover = util::spawn_model( localclientnum, "tag_origin", self.origin, self.angles );
    junk_rotater linkto( junk_mover );
    self thread rotate_junk( junk_rotater );
    
    while ( isdefined( s_current.target ) )
    {
        s_next = struct::get( s_current.target );
        s_next.origin += offset;
        n_dist = distance( self.origin, s_next.origin );
        n_time = n_dist / self.speed;
        junk_mover moveto( s_next.origin, n_time, 0, 0 );
        junk_mover waittill( #"movedone" );
        s_current = s_next;
    }
    
    self notify( #"junk_path_end" );
    self unlink();
    self delete();
    junk_mover delete();
    junk_rotater delete();
}

// Namespace village_surreal
// Params 1
// Checksum 0xb3a5fbdd, Offset: 0xc58
// Size: 0x79
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
}

// Namespace village_surreal
// Params 0
// Checksum 0x1e2caf3a, Offset: 0xce0
// Size: 0xad
function sndjunkwhizby()
{
    self endon( #"junk_path_end" );
    self endon( #"death" );
    players = level.localplayers;
    
    while ( isdefined( self ) && isdefined( self.origin ) )
    {
        if ( isdefined( players[ 0 ] ) && isdefined( players[ 0 ].origin ) )
        {
            junkdistance = distancesquared( self.origin, players[ 0 ].origin );
            
            if ( junkdistance <= 90000 )
            {
                self playsound( 0, "amb_junk_flyby" );
                return;
            }
        }
        
        wait 0.2;
    }
}

// Namespace village_surreal
// Params 7
// Checksum 0xe11e4b2, Offset: 0xd98
// Size: 0x5f
function callback_dynent_catcher( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread dynent_catcher( localclientnum );
        return;
    }
    
    level notify( #"dynent_catcher_disable" );
}

// Namespace village_surreal
// Params 1
// Checksum 0xc97153f5, Offset: 0xe00
// Size: 0x169
function dynent_catcher( localclientnum )
{
    level endon( #"dynent_catcher_disable" );
    t_dynent_catcher = getent( localclientnum, "t_dynent_catcher", "targetname" );
    e_touch_test = spawn( localclientnum, ( 0, 0, 0 ), "script_origin" );
    e_touch_test setmodel( "tag_origin" );
    a_dynent_hidden = [];
    
    while ( true )
    {
        a_dynent_junks = getdynentarray( "fold_dynent" );
        
        foreach ( dynent_junk in a_dynent_junks )
        {
            e_touch_test.origin = dynent_junk.origin;
            
            if ( e_touch_test istouching( t_dynent_catcher ) )
            {
                if ( !isinarray( a_dynent_hidden, dynent_junk ) )
                {
                    array::add( a_dynent_hidden, dynent_junk );
                    setdynentenabled( dynent_junk, 0 );
                    wait 0.1;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace village_surreal
// Params 1
// Checksum 0x8918a542, Offset: 0xf78
// Size: 0x52
function monitor_t_light_church_ext_window_off( localclientnum )
{
    e_trigger = getent( localclientnum, "t_light_church_ext_window_off", "targetname" );
    e_trigger waittill( #"trigger" );
    exploder::stop_exploder( "light_church_ext_window" );
}

