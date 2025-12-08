#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\util;

#namespace evac;

// Namespace evac/evac
// Params 0
// Checksum 0xbe89fc87, Offset: 0x398
// Size: 0x14
function setup()
{
    init_flags();
}

// Namespace evac/evac
// Params 0, eflags: 0x4
// Checksum 0x9c5a7c9e, Offset: 0x3b8
// Size: 0xa4
function private init_flags()
{
    level flag::init( "flag_evac_hint_stop" );
    level flag::init( "flag_evac_defend_start" );
    level flag::init( "flag_evac_exfil_ready" );
    level flag::init( "flag_evac_helicopter_load" );
    level flag::init( "flag_evac_helicopter_board" );
}

// Namespace evac/evac
// Params 9
// Checksum 0xc26c21f0, Offset: 0x468
// Size: 0x1fc
function main( var_834e775, var_d12d84db, var_eb954041, var_5859bbb4, var_3e8a01bb, var_115eeb93, var_3f0bbf52, var_f771f6f2, var_3618156 )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x38>" + self );
    }
    
    if ( !isdefined( var_834e775 ) )
    {
        var_834e775 = self function_b99870d0();
        var_f771f6f2 = 1;
        childthread function_d1e14c76( var_834e775 );
    }
    
    var_edfdb06f = 0;
    
    if ( !isdefined( var_eb954041 ) )
    {
        var_eb954041 = var_834e775;
    }
    else
    {
        var_edfdb06f = 1;
    }
    
    if ( !isdefined( var_f771f6f2 ) )
    {
        var_f771f6f2 = 1;
    }
    
    level flag::set( "flag_evac_defend_start" );
    
    if ( !isdefined( level.var_5e56e2a8 ) )
    {
        level.var_5e56e2a8 = 1200;
    }
    
    if ( is_true( var_f771f6f2 ) )
    {
        self childthread helicopter( var_eb954041, var_edfdb06f, var_d12d84db );
    }
    
    self childthread function_2795b4f9( var_834e775, var_5859bbb4, var_3e8a01bb );
    
    if ( !isdefined( var_3618156 ) || !is_true( var_3618156 ) )
    {
        self childthread function_c878abd2( var_834e775 );
    }
    
    self childthread function_f3b365e9( var_834e775, var_3f0bbf52 );
    self function_604a7e5d( var_115eeb93 );
}

// Namespace evac/evac
// Params 0, eflags: 0x4
// Checksum 0xa9d26c3e, Offset: 0x670
// Size: 0x196
function private function_b99870d0()
{
    self notifyonplayercommand( "evac_signal", "+actionslot 2" );
    var_b6f06448 = 0;
    trace = [];
    
    /#
        iprintlnbold( "<dev string:x6a>" );
    #/
    
    while ( !var_b6f06448 )
    {
        self waittill( #"evac_signal" );
        trace = beamtrace( self.origin + ( 0, 0, 128 ), self.origin + ( 0, 0, 512 ), 1, self );
        
        if ( trace[ #"surfacetype" ] == "none" )
        {
            /#
                iprintlnbold( "<dev string:x81>" );
            #/
            
            var_834e775 = self.origin;
            var_b6f06448 = 1;
            level flag::set( "flag_evac_hint_stop" );
            self notify( #"flag_evac_hint_stop" );
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x9c>" );
            #/
            
            level notify( #"hash_367dfd7dedd4ef13" );
        }
        
        waitframe( 1 );
    }
    
    return var_834e775;
}

// Namespace evac/evac
// Params 1
// Checksum 0x4402ebe3, Offset: 0x810
// Size: 0x84
function function_d1e14c76( var_1b6599c9 )
{
    var_c39b3c14 = function_787dbb94( var_1b6599c9, ( -90, 0, 0 ), undefined, "tag_origin" );
    playfxontag( "smoke/fx9_smk_grenade_green_windy", var_c39b3c14, "tag_origin" );
    level thread function_a64f1050( var_c39b3c14 );
}

// Namespace evac/evac
// Params 1, eflags: 0x4
// Checksum 0x9b0316a8, Offset: 0x8a0
// Size: 0x44
function private function_a64f1050( var_c39b3c14 )
{
    level flag::wait_till( "flag_evac_stop_smoke" );
    var_c39b3c14 delete();
}

// Namespace evac/evac
// Params 3, eflags: 0x4
// Checksum 0x9a884dc2, Offset: 0x8f0
// Size: 0x39c
function private helicopter( var_eb954041, var_edfdb06f, var_d12d84db )
{
    if ( isdefined( var_d12d84db ) )
    {
        flag::wait_till( var_d12d84db );
    }
    
    level flag::wait_till( "flag_evac_exfil_ready" );
    iprintlnbold( "Chopper is on final approach!" );
    
    if ( isdefined( level.var_a16d9e19 ) )
    {
        var_eb954041 = level.var_a16d9e19;
    }
    
    var_52d7f450 = vehicle::simple_spawn( "vehicle_evac_heli" );
    var_b4a49886 = var_52d7f450[ 0 ];
    var_b4a49886 setrotorspeed( 1 );
    var_b4a49886 vehicle::god_on();
    var_b4a49886 vehicle::toggle_tread_fx( 1 );
    var_b4a49886 vehicle::toggle_exhaust_fx( 1 );
    level.vehicle_evac_heli = var_b4a49886;
    var_b4a49886 setspeed( 30, 25, 25 );
    var_b4a49886 endon( #"death" );
    var_5358032b = struct::get_array( "struct_heli_lz", "targetname" );
    
    if ( var_5358032b.size )
    {
        var_8ef93e88 = array::get_all_closest( var_eb954041, var_5358032b );
        lz = var_8ef93e88[ 0 ];
    }
    
    if ( is_true( var_edfdb06f ) )
    {
        var_b4a49886 vehicle::set_goal_pos( lz.origin, 1 );
        var_b4a49886 setgoalyaw( lz.angles[ 1 ] );
        var_b4a49886 waittill( #"goal" );
    }
    else
    {
        var_b4a49886 vehicle::set_goal_pos( var_eb954041 + ( 0, 0, 1024 ), 1 );
        var_b4a49886 waittill( #"goal" );
    }
    
    level flag::wait_till( "flag_evac_exfil_ready" );
    
    if ( !isalive( var_b4a49886 ) )
    {
        return;
    }
    
    if ( isdefined( lz.script_parameters ) )
    {
        switch ( lz.script_parameters )
        {
            case #"hover":
                self function_b064c2b3( 0, var_b4a49886 );
                break;
            case #"land":
            default:
                self function_f724246e( var_b4a49886, lz );
                break;
        }
        
        return;
    }
    
    self function_f724246e( var_b4a49886, lz );
}

// Namespace evac/evac
// Params 2, eflags: 0x4
// Checksum 0x5f320cc6, Offset: 0xc98
// Size: 0xe4
function private function_f724246e( var_b4a49886, lz )
{
    var_b4a49886 vehicle::set_goal_pos( lz.origin + ( 0, 0, 1024 ), 1 );
    var_b4a49886 waittill( #"goal" );
    var_b4a49886 setgoalyaw( lz.angles[ 1 ] );
    var_b4a49886 function_f4db9f04();
    self function_b064c2b3( 1, var_b4a49886 );
    var_b4a49886 setspeed( 5 );
    var_b4a49886 vehicle::liftoff( 512 );
}

// Namespace evac/evac
// Params 0, eflags: 0x4
// Checksum 0xb474c274, Offset: 0xd88
// Size: 0x2a8
function private function_f4db9f04()
{
    ground_pos = groundtrace( self.origin + ( 0, 0, 8 ), self.origin + ( 0, 0, -100000 ), 0, self )[ #"position" ];
    var_c7f41a78 = self.origin;
    level flag::set( "flag_evac_stop_smoke" );
    self setneargoalnotifydist( 2 );
    self sethoverparams( 0, 0, 10 );
    self cleargoalyaw();
    self settargetyaw( ( 0, self.angles[ 1 ], 0 )[ 1 ] );
    self thread function_76525803( ground_pos, [ level.player ], 500 );
    
    while ( !level flag::get( "evac_chopper_landed" ) )
    {
        if ( level flag::get( "landing_obstructed" ) )
        {
            self notify( #"hash_649de7ef40beeba1" );
            self vehicle::set_goal_pos( var_c7f41a78, 1 );
            
            if ( isdefined( level.var_5bb760e8 ) )
            {
                level.player thread util::show_hint_text( #"hash_375f464aa679494f", 1, "stop_landing_clear_hint", 99 );
            }
            
            level flag::wait_till_clear( "landing_obstructed" );
            level.player notify( #"stop_landing_clear_hint" );
        }
        
        self vehicle::set_goal_pos( ground_pos + ( 0, 0, 110 ), 1 );
        thread function_9e39f358();
        level flag::wait_till_any( [ "evac_chopper_landed", "landing_obstructed" ] );
    }
}

// Namespace evac/evac
// Params 3
// Checksum 0x1c61c4ae, Offset: 0x1038
// Size: 0x220
function function_76525803( var_ad1ba59d, var_9b1de80a, var_8db0ea88 )
{
    level endon( #"evac_chopper_landed" );
    var_568798 = var_8db0ea88 * var_8db0ea88;
    var_1cea5425 = 25;
    var_b90d30a9 = 1;
    badplace_cylinder( "evac_badplace", -1, var_ad1ba59d + ( 0, 0, -32 ), var_8db0ea88 + var_1cea5425, 128, #"any" );
    
    while ( true )
    {
        set = 0;
        var_b90d30a9 = -1;
        
        if ( level flag::get( "landing_obstructed" ) )
        {
            var_568798 = var_8db0ea88 + var_1cea5425;
        }
        else
        {
            var_568798 = var_8db0ea88 - var_1cea5425;
        }
        
        var_568798 *= var_568798;
        
        foreach ( ob in var_9b1de80a )
        {
            if ( distancesquared( var_ad1ba59d, ob.origin ) < var_568798 )
            {
                set = 1;
                break;
            }
        }
        
        if ( set )
        {
            level flag::set( "landing_obstructed" );
        }
        else
        {
            level flag::clear( "landing_obstructed" );
        }
        
        if ( !set && self.origin[ 2 ] - var_ad1ba59d[ 2 ] < 300 )
        {
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace evac/evac
// Params 0
// Checksum 0xc8964697, Offset: 0x1260
// Size: 0x5c
function function_9e39f358()
{
    self endon( #"hash_649de7ef40beeba1" );
    self waittill( #"goal" );
    level flag::set( "evac_chopper_landed" );
    badplace_delete( "evac_badplace" );
}

// Namespace evac/evac
// Params 2, eflags: 0x4
// Checksum 0x6b324455, Offset: 0x12c8
// Size: 0x22c
function private function_b064c2b3( var_b12eb97e, var_b4a49886 )
{
    if ( is_true( var_b12eb97e ) )
    {
        iprintlnbold( "Chopper is on the ground! Get on Board!" );
        thread function_172759f0( var_b4a49886, "tag_enter_passenger1" );
        thread function_172759f0( var_b4a49886, "tag_enter_passenger2" );
        level waittill( #"evac_helicopter_board_trigger" );
    }
    else
    {
        level flag::wait_till( "flag_evac_helicopter_load" );
    }
    
    var_354d59b2 = var_b4a49886 gettagorigin( "tag_rider1" );
    var_81a8490e = var_b4a49886 gettagorigin( "tag_rider3" );
    var_b6da2acf = distance2dsquared( self.origin, var_354d59b2 );
    var_331f2810 = distance2dsquared( self.origin, var_81a8490e );
    var_9425642c = "tag_rider1";
    
    if ( var_b6da2acf > var_331f2810 )
    {
        var_9425642c = "tag_rider3";
    }
    
    var_b4a49886 makevehicleusable();
    var_b4a49886 setseatoccupied( 0, 1 );
    seat = 2;
    var_b4a49886 usevehicle( level.players[ 0 ], seat );
    var_b4a49886 makevehicleunusable();
    level flag::set( "flag_evac_helicopter_board" );
}

// Namespace evac/evac
// Params 2
// Checksum 0xb75e0fba, Offset: 0x1500
// Size: 0xe0
function function_172759f0( var_b4a49886, str_tag )
{
    e_origin = function_787dbb94( var_b4a49886 gettagorigin( str_tag ), var_b4a49886 gettagangles( str_tag ), undefined, "tag_origin" );
    e_origin util::create_cursor_hint( "tag_origin", ( 0, 0, 48 ), #"hash_62df17fd9f467834" );
    e_origin util::waittill_any_ents( e_origin, "trigger", level, "evac_helicopter_board_trigger" );
    level notify( #"evac_helicopter_board_trigger" );
}

// Namespace evac/evac
// Params 4
// Checksum 0x1e4bf01f, Offset: 0x15e8
// Size: 0x98
function function_787dbb94( v_location, v_angles, v_offset = ( 0, 0, 0 ), str_model )
{
    e_origin = spawn( "script_model", v_location + v_offset );
    e_origin.origin = v_location + v_offset;
    e_origin.angles = v_angles;
    e_origin setmodel( str_model );
    return e_origin;
}

// Namespace evac/evac
// Params 2, eflags: 0x4
// Checksum 0xd70671b0, Offset: 0x1688
// Size: 0x118
function private function_f3b365e9( var_834e775, var_3f0bbf52 )
{
    if ( isdefined( level.var_e07323b5 ) && isalive( level.var_e07323b5 ) )
    {
        level.var_e07323b5 thread function_4e3254e1( var_834e775, var_3f0bbf52 );
        return;
    }
    
    if ( isdefined( level.var_e07323b5 ) && level.var_e07323b5.size )
    {
        foreach ( asset in level.var_e07323b5 )
        {
            if ( isdefined( asset ) )
            {
                asset thread function_4e3254e1( var_834e775, var_3f0bbf52 );
            }
        }
    }
}

// Namespace evac/evac
// Params 2, eflags: 0x4
// Checksum 0x9749cb2f, Offset: 0x17a8
// Size: 0x8c
function private function_4e3254e1( var_834e775, var_3f0bbf52 )
{
    self endon( #"death" );
    self.goalradius = 64;
    self ai::set_behavior_attribute( "demeanor", "frantic" );
    
    if ( !isdefined( var_3f0bbf52 ) )
    {
        var_3f0bbf52 = 512;
    }
    
    self thread function_5986f4a1( var_834e775, var_3f0bbf52, 64, 64 );
}

// Namespace evac/evac
// Params 1, eflags: 0x4
// Checksum 0x8b7a730, Offset: 0x1840
// Size: 0xe8
function private function_c878abd2( var_834e775 )
{
    if ( is_true( level.var_fe86dfc1 ) )
    {
        return;
    }
    
    allies = getaiarray( "allies" );
    
    foreach ( guy in allies )
    {
        guy.goalradius = 192;
        guy thread function_5986f4a1( var_834e775, 512, 64, 256 );
    }
}

// Namespace evac/evac
// Params 4, eflags: 0x4
// Checksum 0xa3479014, Offset: 0x1930
// Size: 0x94
function private function_5986f4a1( var_834e775, var_3f0bbf52, var_71dc0c70, var_1ecc7105 )
{
    nodes = getnodesinradius( var_834e775, var_3f0bbf52, var_71dc0c70, var_1ecc7105 );
    
    if ( nodes.size )
    {
        self setgoal( array::random( nodes ) );
        return;
    }
    
    self setgoal( var_834e775 );
}

// Namespace evac/evac
// Params 3
// Checksum 0xc95e1b2b, Offset: 0x19d0
// Size: 0x38c
function function_2795b4f9( var_834e775, var_5859bbb4, var_3e8a01bb )
{
    level endon( #"hash_659b6dc260129701" );
    level.var_dc8cac2a = [];
    e_vol = getent( "volume_evac_loc", "targetname" );
    
    if ( isdefined( e_vol ) )
    {
        e_vol.origin = var_834e775;
    }
    
    level.var_dc8cac2a[ level.var_dc8cac2a.size ] = getplayers()[ 0 ];
    
    if ( isdefined( level.heroes ) )
    {
        foreach ( guy in level.heroes )
        {
            level.var_dc8cac2a[ level.var_dc8cac2a.size ] = guy;
        }
    }
    
    spawner::add_spawn_function_group( "evac_enemy", "targetname", &function_b5b9e9e8, e_vol );
    
    if ( !isdefined( var_5859bbb4 ) )
    {
        var_5859bbb4 = 30;
    }
    
    if ( !isdefined( var_3e8a01bb ) )
    {
        var_3e8a01bb = 5;
    }
    
    /#
        iprintlnbold( "<dev string:xc3>" );
    #/
    
    wait var_3e8a01bb;
    a_spawners = [];
    a_spawners = getentarray( "evac_enemy", "targetname" );
    self function_524bc520( a_spawners );
    
    while ( !flag::get( "flag_evac_exfil_ready" ) )
    {
        var_1647b5dc = getaiarray( "evac_enemy", "targetname" );
        
        /#
            iprintln( var_1647b5dc.size );
        #/
        
        if ( var_1647b5dc.size < var_5859bbb4 || level flag::get( "evac_start_next_wave" ) )
        {
            if ( !level flag::get( "evac_start_next_wave" ) && isdefined( level.var_5fc12b72 ) )
            {
                /#
                    iprintln( "<dev string:xd8>" + level.var_5fc12b72 + "<dev string:xeb>" );
                #/
                
                level waittilltimeout( level.var_5fc12b72, #"evac_start_next_wave" );
            }
            
            level notify( #"hash_c3e7fb6791a728b" );
            self function_524bc520( a_spawners );
            level flag::clear( "evac_start_next_wave" );
        }
        
        level waittilltimeout( 1, #"evac_start_next_wave" );
    }
}

// Namespace evac/evac
// Params 1, eflags: 0x4
// Checksum 0xac42b290, Offset: 0x1d68
// Size: 0xb4
function private function_b5b9e9e8( e_vol )
{
    if ( isdefined( level.var_dc8cac2a ) )
    {
        self setgoal( level.var_dc8cac2a[ randomint( level.var_dc8cac2a.size ) ], 0, level.var_5e56e2a8 );
        return;
    }
    
    if ( isdefined( e_vol ) )
    {
        self setgoal( e_vol );
        return;
    }
    
    self setgoal( getplayers()[ 0 ], 0, level.var_5e56e2a8 );
}

// Namespace evac/evac
// Params 1, eflags: 0x4
// Checksum 0xc39bf8a4, Offset: 0x1e28
// Size: 0x34
function private function_524bc520( a_spawners )
{
    self function_7cb7ee37( self function_767a70b6(), a_spawners );
}

// Namespace evac/evac
// Params 0, eflags: 0x4
// Checksum 0x586f8c2e, Offset: 0x1e68
// Size: 0xf8
function private function_767a70b6()
{
    a_vols = getentarray( "volume_evac_defend", "targetname" );
    str_zone_name = undefined;
    var_5749d3e1 = undefined;
    
    for ( i = 0; i < a_vols.size ; i++ )
    {
        if ( isdefined( a_vols[ i ].script_noteworthy ) && a_vols[ i ].script_noteworthy == "default_evac_spawns" )
        {
            str_zone_name = a_vols[ i ].target;
        }
        
        if ( self istouching( a_vols[ i ] ) )
        {
            str_zone_name = a_vols[ i ].target;
            break;
        }
    }
    
    /#
        iprintln( str_zone_name );
    #/
    
    return str_zone_name;
}

/#

    // Namespace evac/evac
    // Params 1
    // Checksum 0x4717a356, Offset: 0x1f68
    // Size: 0xf0, Type: dev
    function debug_spawnpoints( locs )
    {
        foreach ( loc in locs )
        {
            sphere( loc.origin, 12, ( 0, 0, 1 ), 1, 0, 10, 19980 );
            line( loc.origin, loc.origin + ( 0, 0, 2048 ), ( 0, 0, 1 ), 1, 0, 19980 );
        }
    }

#/

// Namespace evac/evac
// Params 3, eflags: 0x4
// Checksum 0x96c16ae7, Offset: 0x2060
// Size: 0x1ba
function private function_7cb7ee37( str_zone_name, a_spawners, var_ce4e368a = 0 )
{
    var_e16917a1 = struct::get_array( str_zone_name, "targetname" );
    var_e16917a1 = array::randomize( var_e16917a1 );
    wave_size = a_spawners.size;
    
    if ( isdefined( level.var_dd0b1f89 ) )
    {
        wave_size = level.var_dd0b1f89;
    }
    
    if ( var_ce4e368a )
    {
        wave_size = max( 1, wave_size - getaiarray( "evac_enemy", "targetname" ).size );
    }
    
    for ( i = 0; i < wave_size ; i++ )
    {
        if ( !isspawner( a_spawners[ i % a_spawners.size ] ) )
        {
            waitframe( 1 );
            continue;
        }
        
        counter = i % var_e16917a1.size;
        
        if ( i > counter )
        {
            wait 0.25;
        }
        
        enemy = a_spawners[ i % a_spawners.size ] spawnfromspawner();
        
        if ( isdefined( enemy ) )
        {
            enemy forceteleport( var_e16917a1[ counter ].origin, var_e16917a1[ counter ].angles );
        }
        else
        {
            i--;
        }
        
        waitframe( 1 );
    }
}

// Namespace evac/evac
// Params 1, eflags: 0x4
// Checksum 0xe45e0469, Offset: 0x2228
// Size: 0x74
function private function_604a7e5d( var_115eeb93 = 60 )
{
    /#
        if ( isdefined( level.var_fe030804 ) )
        {
            var_115eeb93 = level.var_fe030804;
        }
    #/
    
    level thread function_179db8b3( var_115eeb93 );
    wait var_115eeb93;
    level flag::set( "flag_evac_exfil_ready" );
}

// Namespace evac/evac
// Params 1, eflags: 0x4
// Checksum 0xea71c82, Offset: 0x22a8
// Size: 0xe4
function private function_179db8b3( var_115eeb93 )
{
    if ( var_115eeb93 > 30 )
    {
        wait var_115eeb93 - 30;
    }
    
    if ( isdefined( level.var_84790ecd ) )
    {
        level thread dialogue::radio( level.var_84790ecd );
    }
    
    if ( var_115eeb93 > 20 )
    {
        wait 10;
    }
    
    level notify( #"hash_96dccf37ba89a2" );
    
    if ( isdefined( level.var_d2f39d7c ) )
    {
        level thread dialogue::radio( level.var_d2f39d7c );
    }
    
    if ( var_115eeb93 > 10 )
    {
        wait 10;
    }
    
    if ( isdefined( level.var_6ae39cd0 ) )
    {
        level thread dialogue::radio( level.var_6ae39cd0 );
    }
}

