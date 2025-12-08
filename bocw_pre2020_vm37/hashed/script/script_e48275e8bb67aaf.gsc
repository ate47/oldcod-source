#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\util;

#namespace namespace_186bf720;

// Namespace namespace_186bf720/namespace_186bf720
// Params 0, eflags: 0x6
// Checksum 0x465c4975, Offset: 0x138
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_597a663988c952c9", undefined, &init_postload, undefined, undefined );
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 0
// Checksum 0xe61305ad, Offset: 0x180
// Size: 0x44
function init_postload()
{
    var_7fb2012d = struct::get_array( "airburst_mortar_manager" );
    array::thread_all( var_7fb2012d, &function_d3906088 );
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 0
// Checksum 0xd8a79568, Offset: 0x1d0
// Size: 0x15c
function function_d3906088()
{
    a_s_parts = struct::get_array( self.target );
    
    foreach ( s_part in a_s_parts )
    {
        switch ( s_part.script_noteworthy )
        {
            case #"hash_554aec6e6a5c90b0":
                self.var_33d2e98f = s_part;
                break;
            case #"hash_1dd892217a7eb164":
                self.var_ac233b5e = s_part;
                break;
            case #"hash_4af7bca2c40a8459":
                self.s_exit = s_part;
                break;
        }
    }
    
    self.v_start_angles = self.var_ac233b5e.angles;
    self.var_cff86114 = getweapon( #"hash_597a663988c952c9" );
    self function_fa8e4994();
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 0
// Checksum 0xbb1d2d7c, Offset: 0x338
// Size: 0x54
function function_fa8e4994()
{
    self util::create_cursor_hint( undefined, undefined, #"hash_1ad6e9dc10695917", undefined, undefined, &function_f6772149, undefined, undefined, undefined, undefined, undefined, undefined, &function_121f8ec6 );
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 0
// Checksum 0xd5073b30, Offset: 0x398
// Size: 0x54
function function_3b660233()
{
    self util::create_cursor_hint( undefined, undefined, #"hash_1a09fa1aeabdea81", undefined, 1, &function_cd6d4856, undefined, undefined, undefined, undefined, undefined, undefined, &function_121f8ec6 );
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 1
// Checksum 0x6d2162c1, Offset: 0x3f8
// Size: 0x2c, Type: bool
function function_121f8ec6( s_info )
{
    return s_info.player getstance() == "stand";
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 1
// Checksum 0xeaf13c6a, Offset: 0x430
// Size: 0x554
function function_f6772149( s_info )
{
    player = s_info.player;
    player endon( #"death" );
    var_ac233b5e = self.var_ac233b5e;
    var_33d2e98f = self.var_33d2e98f;
    s_exit = self.s_exit;
    self.var_c45ecd77 = 1;
    e_tag = util::spawn_model( "tag_origin", var_ac233b5e.origin, var_ac233b5e.angles );
    player playerlinkto( e_tag, "tag_origin", 0, var_ac233b5e.var_b7ff6051, var_ac233b5e.var_1a919a07, var_ac233b5e.up_angle, var_ac233b5e.var_2e6497b5 );
    player setplayerangles( self.v_start_angles );
    player val::set( #"hash_597a663988c952c9", "disable_weapons", 1 );
    player val::set( #"hash_597a663988c952c9", "freezecontrols_allowlook", 1 );
    var_1d9ec7cc = player.attackeraccuracy;
    player.attackeraccuracy = 0.2;
    var_66502a87 = util::spawn_model( "p7_zm_zod_magic_circle_256_emissive" );
    var_66502a87 setscale( 1.5 );
    player thread function_44c7cfed( self );
    player util::show_hint_text( #"hash_264d7b5fa135d722", undefined, undefined, -1 );
    
    while ( player flag::get( #"hash_57c1a994d314a822" ) )
    {
        v_forward = anglestoforward( player getplayerangles() );
        v_start = player getplayercamerapos() + 100 * v_forward;
        v_end = v_start + 3000 * v_forward;
        a_trace = bullettrace( v_start, v_end, 0, player );
        v_hit = a_trace[ #"position" ] + ( 0, 0, 1 );
        var_66502a87.origin = v_hit;
        
        if ( player attackbuttonpressed() )
        {
            v_target = v_hit + ( 0, 0, 500 );
            v_launch = get_launch_velocity( var_33d2e98f.origin, v_target, 1000 );
            e_grenade = player magicgrenadeplayer( self.var_cff86114, var_33d2e98f.origin, v_launch );
            player playrumbleonentity( "damage_heavy" );
            e_grenade thread function_a5071c15( v_target );
            e_grenade thread function_4d15227c();
            player flag::clear( #"hash_57c1a994d314a822" );
            wait 0.2;
            self util::delay( 0.5, undefined, &function_3b660233 );
        }
        
        waitframe( 1 );
    }
    
    var_66502a87 delete();
    player notify( #"notify_turn_off_hint_text" );
    player.attackeraccuracy = var_1d9ec7cc;
    self.v_start_angles = player getplayerangles();
    player unlink();
    player setorigin( s_exit.origin );
    player setplayerangles( s_exit.angles );
    player val::reset( #"hash_597a663988c952c9", "disable_weapons" );
    player val::reset( #"hash_597a663988c952c9", "freezecontrols_allowlook" );
    e_tag delete();
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 1
// Checksum 0x4501c1fb, Offset: 0x990
// Size: 0x122
function function_44c7cfed( s_mortar )
{
    self endon( #"death" );
    self flag::set( #"hash_57c1a994d314a822" );
    
    while ( self usebuttonpressed() )
    {
        wait 0.1;
    }
    
    for ( var_749d77f0 = 0; self flag::get( #"hash_57c1a994d314a822" ) ; var_749d77f0 = 0 )
    {
        wait 0.1;
        
        if ( self usebuttonpressed() )
        {
            var_749d77f0++;
            
            if ( var_749d77f0 > 4 )
            {
                self flag::clear( #"hash_57c1a994d314a822" );
                s_mortar util::delay( 0.1, undefined, &function_fa8e4994 );
            }
            
            continue;
        }
    }
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 1
// Checksum 0x22f64f66, Offset: 0xac0
// Size: 0x54
function function_cd6d4856( s_info )
{
    self endon( #"death" );
    
    /#
        hms_util::print( "<dev string:x38>" );
    #/
    
    self thread function_f6772149( s_info );
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 1
// Checksum 0xe99a2141, Offset: 0xb20
// Size: 0x64
function function_a5071c15( v_target )
{
    self endon( #"death" );
    
    while ( self.origin[ 2 ] > v_target[ 2 ] )
    {
        waitframe( 1 );
    }
    
    self.origin = v_target;
    self detonate();
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 3
// Checksum 0xc98c60c, Offset: 0xb90
// Size: 0x102
function get_launch_velocity( v_source, v_target, n_power )
{
    n_distance = distance( v_source, v_target );
    n_time = n_distance / n_power;
    var_91418561 = getdvarint( #"bg_gravity", 0 ) * -1;
    n_drop = 0.5 * var_91418561 * sqr( n_time );
    v_delta = v_target - v_source;
    v_launch = ( v_delta[ 0 ] / n_time, v_delta[ 1 ] / n_time, ( v_delta[ 2 ] - n_drop ) / n_time );
    return v_launch;
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 0
// Checksum 0x43931ef8, Offset: 0xca0
// Size: 0x44
function function_4d15227c()
{
    self endon( #"death" );
    self waittill( #"explode" );
    level thread function_b4d19680( self );
}

// Namespace namespace_186bf720/namespace_186bf720
// Params 1
// Checksum 0x1fa63c22, Offset: 0xcf0
// Size: 0x1d2
function function_b4d19680( e_grenade )
{
    level endon( #"end_game" );
    var_b84a170a = getweapon( #"hash_7e94745566021fff" );
    var_740add51 = 72;
    var_2b9a525f = randomfloatrange( 0, var_740add51 );
    v_start = e_grenade.origin;
    player = e_grenade.owner;
    
    for ( i = 0; i < 5 ; i++ )
    {
        n_angle = var_2b9a525f + var_740add51 * i + randomfloatrange( -10, 10 );
        v_dir = anglestoforward( ( 0, n_angle, 0 ) );
        v_spawn = v_start + 5 * v_dir;
        var_497d8162 = randomintrangeinclusive( 100, 250 );
        var_36bc8509 = randomintrangeinclusive( 200, 1000 );
        v_launch = var_497d8162 * v_dir - ( 0, 0, var_36bc8509 );
        player magicgrenadeplayer( var_b84a170a, v_spawn, v_launch );
        waitframe( 1 );
    }
}

