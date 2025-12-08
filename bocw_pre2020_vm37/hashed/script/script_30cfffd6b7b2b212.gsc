#using script_37f9ff47f340fbe8;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\debug;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\util;

#namespace namespace_42da7c51;

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 0
// Checksum 0x72ad0162, Offset: 0x3c0
// Size: 0x34
function init_clientfields()
{
    clientfield::register( "toplayer", "lerp_fov", 1, 3, "int" );
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 2
// Checksum 0xb630678c, Offset: 0x400
// Size: 0xa2
function swap_head( notify_str, head_model )
{
    if ( isdefined( notify_str ) )
    {
        level waittill( notify_str );
    }
    
    if ( isdefined( self.hatmodel ) )
    {
        self detach( self.hatmodel );
    }
    
    if ( isdefined( self.head ) )
    {
        self detach( self.head );
    }
    
    self attach( head_model );
    self.head = head_model;
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 2
// Checksum 0x82bc5136, Offset: 0x4b0
// Size: 0x7c
function function_53531f27( key, val = "targetname" )
{
    trig = getent( key, val );
    
    if ( isdefined( trig ) && trig istriggerenabled() )
    {
        trig trigger::use();
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 1
// Checksum 0x37882b78, Offset: 0x538
// Size: 0xfa
function setup_objectives( var_567f1ddd )
{
    switch ( var_567f1ddd )
    {
        case #"tkdn_heli_intro":
            level waittill( #"hash_428d72621587561a" );
        case #"tkdn_heli_trailer_park":
        case #"tkdn_heli_convoy_aslt":
        case #"hash_75cfe0319f9e4615":
            level thread function_ea61a18();
            break;
        case #"tkdn_heli_hotel_breach":
            level thread function_ea61a18();
            break;
        default:
            objectives::scripted( "send_message", undefined, #"hash_53989aa56aa8e6d8", 0 );
            break;
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 0
// Checksum 0x88df3b6d, Offset: 0x640
// Size: 0xac
function function_ea61a18()
{
    objectives::scripted( "send_message", undefined, #"hash_53989aa56aa8e6d8", 0 );
    objectives::scripted( "hit1", undefined, #"hash_453bbd10dbdaa6ea", 0 );
    objectives::function_6a5ca7ac( "hit1", undefined, "send_message" );
    level flag::wait_till( #"hash_5601fb6019314f30" );
    objectives::complete( "hit1" );
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 0
// Checksum 0x67e415bb, Offset: 0x6f8
// Size: 0x254
function function_6154e4c2()
{
    var_4f2ba130 = self getweaponslist();
    
    foreach ( e_w in var_4f2ba130 )
    {
        self takeweapon( e_w );
    }
    
    frag = getweapon( #"frag_grenade" );
    
    if ( !self hasweapon( frag ) )
    {
        self giveweapon( frag );
        self setweaponammoclip( frag, 3 );
        self setweaponammostock( frag, 3 );
    }
    
    secondary_weapon = getweapon( #"sniper_quickscope_t9", array( "smoothzoom", "grip" ) );
    primary_weapon = getweapon( #"ar_accurate_t9", array( "acog", "fastreload" ) );
    self giveweapon( primary_weapon );
    self giveweapon( secondary_weapon );
    self givemaxammo( primary_weapon );
    self givemaxammo( secondary_weapon );
    self switchtoweapon( primary_weapon );
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 0
// Checksum 0x85276b12, Offset: 0x958
// Size: 0x19c
function function_fbb0d73f()
{
    self endon( #"death" );
    self setrotorspeed( 1 );
    self.soundmod = "heli";
    self val::set( "heli", "ignoreme", 1 );
    self vehicle::toggle_tread_fx( 1 );
    self vehicle::toggle_exhaust_fx( 1 );
    self vehicle::toggle_sounds( 1 );
    self vehicle::lights_on();
    self turret::_init_turret( 1 );
    self turret::_init_turret( 2 );
    self turret::set_burst_parameters( 1, 2, 5, 8, 1 );
    self turret::set_burst_parameters( 1, 2, 5, 8, 2 );
    params = { #no_clear_movement:1, #var_a22ee662:1 };
    self vehicle_ai::set_state( "scripted", params );
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 0
// Checksum 0x136425fd, Offset: 0xb00
// Size: 0x340
function function_3cebcd1b()
{
    self endon( #"death" );
    level endon( #"bustout_start_shooting_house" );
    var_979d3fe0 = [ #"hit1_truck_rear", #"hit1_truck_house", #"hit1_truck_mid", #"hit1_truck_front", #"heli_focus_mid_house", #"heli_focus_rear_house", #"heli_focus_door_breach", #"heli_focus_gas_garage" ];
    var_f01b798 = [ "hit1_truck_rear", "hit1_truck_house", "hit1_truck_mid", "hit1_truck_front", "heli_focus_mid_house", "heli_focus_rear_house", "heli_focus_door_breach", "heli_focus_gas_garage" ];
    
    while ( true )
    {
        ret = level waittill( #"hit1_truck_rear", #"hit1_truck_house", #"hit1_truck_mid", #"hit1_truck_front", #"heli_focus_mid_house", #"heli_focus_rear_house", #"heli_focus_door_breach", #"heli_focus_gas_garage" );
        var_87c48267 = "GetEntDislikesHashStrings";
        
        for ( i = 0; i < var_979d3fe0.size ; i++ )
        {
            if ( var_979d3fe0[ i ] == ret._notify )
            {
                var_87c48267 = var_f01b798[ i ];
                break;
            }
        }
        
        var_4cd99adc = getent( var_87c48267, "script_noteworthy", 1 );
        
        if ( !isdefined( var_4cd99adc ) )
        {
            var_4cd99adc = struct::get( var_87c48267, "targetname" );
        }
        
        if ( isdefined( var_4cd99adc ) )
        {
            self thread function_cbe25a41( var_4cd99adc, "tag_searchlight_fx", 1 );
            level.var_7c11765c = gettime() + 2000;
            continue;
        }
        
        /#
            iprintlnbold( "<dev string:x38>" + var_87c48267 );
        #/
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 4
// Checksum 0xc7518160, Offset: 0xe48
// Size: 0x144
function function_f97ce389( heli, tag, var_2d65f507, var_5525c0b0 )
{
    heli.light = util::spawn_model( "tag_origin", heli gettagorigin( tag ) + ( 0, 0, -84 ), heli gettagangles( tag ) + var_2d65f507 );
    
    if ( var_5525c0b0 )
    {
        util::delay( 0.3, undefined, &playfxontag, #"hash_f80473c70ea6ee3", heli.light, "tag_origin" );
    }
    else
    {
        playfxontag( #"hash_7d057d370983507f", heli.light, "tag_origin" );
    }
    
    heli.light linkto( heli, "tag_searchlight_fx", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 8
// Checksum 0x6d802b6f, Offset: 0xf98
// Size: 0x1f4
function heli_light( heli, tname, tag, var_2d65f507, var_ba240678, var_fa2357fe = 0, var_1a67724f = 0, var_5525c0b0 = 0 )
{
    fx_light = 1;
    heli endon( #"death" );
    heli waittill( #"lights_on" );
    heli.col_hack = ( 1, 0, 0 );
    
    if ( !isdefined( level.var_eaf95d92 ) )
    {
        level.var_eaf95d92 = [];
    }
    
    if ( !isdefined( level.var_eaf95d92[ tname ] ) )
    {
        if ( fx_light )
        {
            if ( !var_1a67724f )
            {
                function_f97ce389( heli, tag, var_2d65f507, var_5525c0b0 );
            }
        }
        else
        {
            heli.light = getent( tname, "targetname" );
            
            if ( !isdefined( heli.light ) )
            {
                heli.light = getent( tname + "_temp", "targetname" );
            }
        }
        
        if ( isdefined( heli.light ) )
        {
            heli.light linkto( heli, tag, ( 0, 0, -64 ), var_2d65f507 );
            level.var_eaf95d92[ tname ] = heli.light;
        }
    }
    
    if ( isdefined( var_ba240678 ) )
    {
        heli thread function_cbe25a41( var_ba240678, tag, var_fa2357fe, var_1a67724f, var_5525c0b0 );
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 0
// Checksum 0x3f3daf92, Offset: 0x1198
// Size: 0x9e
function function_336e9e88()
{
    self endon( #"death" );
    
    while ( true )
    {
        /#
            sphere( self.origin + ( 0, 0, 12 ), 4, ( 1, 1, 0 ), 1, 0, 10, 1 );
            sphere( self.origin, 8, ( 1, 1, 0 ), 1, 0, 10, 1 );
        #/
        
        waitframe( 1 );
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 6
// Checksum 0xf7e3ec68, Offset: 0x1240
// Size: 0xa2a
function function_cbe25a41( var_4cd99adc, tag = "tag_origin", var_fa2357fe = 0, var_1a67724f = 0, var_5525c0b0 = 0, var_2526f86c = 0 )
{
    self endon( #"death" );
    self endon( #"hash_48aad0ddc0d9bf5d" );
    var_869cc293 = "tag_missle_target";
    
    if ( isdefined( self.var_ba240678 ) )
    {
        self.var_ba240678.tracking = var_4cd99adc;
        self.var_9fa13062 = 0;
        self.var_c7d51a18 = 0;
        
        if ( self.var_1a67724f || is_true( self.var_2526f86c ) )
        {
            self.var_ba240678 unlink();
        }
        
        self.var_1a67724f = var_1a67724f;
        self.var_2526f86c = var_2526f86c;
        
        if ( self.var_1a67724f )
        {
            self.var_ba240678 linkto( self, var_869cc293, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
        else if ( self.var_2526f86c )
        {
            self.var_ba240678 linkto( var_4cd99adc, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
        
        n_radius = 75;
        n_speed = 100;
        n_accel = 50;
        self sethoverparams( n_radius, n_speed, n_accel );
        return;
    }
    
    self.var_9fa13062 = 0;
    self.var_c7d51a18 = 0;
    self.var_19a7fb91 = 32 + randomfloat( 64 );
    self.var_19a7fb91 = 96;
    self.var_ba240678 = util::spawn_model( "tag_origin", var_4cd99adc.origin, var_4cd99adc.angles );
    self.var_113b6995 = 2;
    self.var_35f26704 = 0;
    self.var_43643137 = ( 0, 0, 36 );
    self.forward_scalar = 128;
    self.var_1a67724f = var_1a67724f;
    self.var_ba240678 endon( #"death" );
    
    if ( self.var_1a67724f || !isdefined( self.light ) )
    {
        self.var_ba240678 linkto( self, var_869cc293, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        function_f97ce389( self, tag, ( 0, 0, 0 ), var_5525c0b0 );
    }
    
    self.light endon( #"death" );
    var_61bc4e7 = 0;
    
    if ( var_fa2357fe )
    {
        var_8c29c159 = getent( "light_ally_helispot_bnc", "targetname" );
        
        if ( isdefined( var_8c29c159 ) )
        {
            var_8c29c159.var_6da8d78a = 1;
            var_8c29c159 linkto( self.var_ba240678, "tag_origin", ( 0, 0, -200 ), ( 0, 0, 0 ) );
            
            if ( var_61bc4e7 )
            {
                var_8c29c159 thread function_336e9e88();
            }
        }
    }
    
    self.var_ba240678.tracking = var_4cd99adc;
    self clientfield::set( "hit1_helispotlight", 1 );
    waitframe( 1 );
    self.light clientfield::set( "hit1_light", 1 );
    waitframe( 1 );
    self.var_ba240678 clientfield::set( "hit1_track_ent", 1 );
    waitframe( 1 );
    
    if ( isvehicle( self.var_ba240678.tracking ) )
    {
        self.var_ba240678.tracking clientfield::set( "hit1_track_vehicle", 1 );
    }
    else
    {
        self.var_ba240678.tracking clientfield::set( "hit1_tracking", 1 );
    }
    
    var_13ad4669 = 0.05;
    n_radius = 75;
    n_speed = 100;
    n_accel = 50;
    self sethoverparams( n_radius, n_speed, n_accel );
    self.var_2791e894 = 0;
    
    while ( true )
    {
        if ( !isdefined( self.var_ba240678.tracking ) && self.var_1a67724f == 0 )
        {
            waitframe( 1 );
            continue;
        }
        
        /#
            if ( is_true( var_61bc4e7 ) )
            {
                sphere( self.var_ba240678.origin, 8, ( 1, 0, 0 ), 1, 0, 10, 1 );
                sphere( self.var_ba240678.tracking.origin, 4, ( 0, 0, 1 ), 1, 0, 10, 1 );
            }
        #/
        
        if ( !( self.var_1a67724f || self.var_2526f86c ) )
        {
            end_point = self.var_ba240678.tracking.origin + self.var_43643137 + anglestoforward( self.var_ba240678.tracking.angles ) * self.forward_scalar;
            dist = distance( self.var_ba240678.origin, end_point );
            
            if ( !self.var_9fa13062 && !self.var_c7d51a18 )
            {
                if ( dist > self.var_19a7fb91 )
                {
                    self.var_9fa13062 = 1;
                    self.var_c1cda03b = 0.025;
                    self.var_ab0fdcd8 = self.var_c1cda03b;
                    self.var_7c772b29 = self.var_ba240678.origin;
                    
                    /#
                        if ( is_true( var_61bc4e7 ) )
                        {
                            sphere( end_point, 4, ( 0, 0, 1 ), 1, 0, 10, 40 );
                        }
                    #/
                    
                    self.var_ba240678 thread easing::ease_origin( end_point, self.var_113b6995, #"back", undefined, 0, 1, 1, [ 0.35, 3.5 ] );
                    self.var_35f26704 = gettime() + self.var_113b6995 * 1000;
                    self sethoverparams( 75, 100, 50 );
                }
            }
            else if ( self.var_9fa13062 && self.var_35f26704 < gettime() )
            {
                self.var_9fa13062 = 0;
                
                if ( dist < self.var_19a7fb91 )
                {
                    self.var_35f26704 = gettime() + self.var_113b6995 * 1000 / 3;
                    self.var_c7d51a18 = 1;
                    end_point = self.var_ba240678.tracking.origin + self.var_43643137 + anglestoforward( self.var_ba240678.tracking.angles ) * self.forward_scalar;
                    
                    /#
                        if ( is_true( var_61bc4e7 ) )
                        {
                            sphere( end_point, 4, ( 1, 0, 0 ), 1, 0, 10, 20 );
                        }
                    #/
                    
                    self.var_ba240678 thread easing::ease_origin( end_point, self.var_113b6995 / 3, #"sine", undefined, 0, 1, 1 );
                }
            }
            else if ( self.var_c7d51a18 )
            {
                if ( self.var_35f26704 < gettime() )
                {
                    self.var_c7d51a18 = 0;
                }
            }
        }
        
        tag_ang = self gettagangles( tag );
        org = self gettagorigin( tag ) + ( 0, 0, -10 );
        to = vectortoangles( self.var_ba240678.origin - org );
        var_172edc78 = to - tag_ang;
        waitframe( 1 );
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 1
// Checksum 0x2de2b00, Offset: 0x1c78
// Size: 0x134
function function_aa3c5fab( params )
{
    if ( !isdefined( level.var_9a3944f4 ) )
    {
        return;
    }
    
    level.var_9a3944f4.forward_scalar = 1;
    attacker = params.eattacker;
    
    if ( isdefined( attacker ) && isai( attacker ) )
    {
        if ( attacker == level.last_player_attacker )
        {
            level.var_9a3944f4 thread function_cbe25a41( attacker, "tag_searchlight_fx", 1 );
            level.var_7c11765c = gettime();
            return;
        }
        
        if ( level.var_7c11765c < gettime() - 3000 || !isalive( level.last_player_attacker ) )
        {
            level.var_7c11765c = gettime();
            level.last_player_attacker = attacker;
            level.var_9a3944f4 thread function_cbe25a41( attacker, "tag_searchlight_fx", 1 );
        }
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 4
// Checksum 0xac622618, Offset: 0x1db8
// Size: 0x1d4
function function_48f9ff4e( var_b5175c20, str_flag, n_movetime = 1.5, var_1356d773 = 1 )
{
    self endon( #"death" );
    var_2cd170e0 = struct::get( var_b5175c20, "targetname" );
    e_mover = util::spawn_model( "tag_origin", var_2cd170e0.origin, var_2cd170e0.angles );
    e_mover thread function_c38d67b4( var_2cd170e0, n_movetime );
    self turretsettarget( var_1356d773, e_mover );
    var_af2a1727 = [ ( 0, 0, 100 ), ( -100, -100, -100 ) ];
    
    while ( !level flag::get( str_flag ) )
    {
        self fireweapon( var_1356d773 );
        waitframe( 1 );
        self fireweapon( var_1356d773, undefined, var_af2a1727[ randomint( var_af2a1727.size ) ] );
        waitframe( 1 );
    }
    
    self stopfireweapon();
    self turretcleartarget( var_1356d773 );
    e_mover delete();
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 1
// Checksum 0xf1f999a4, Offset: 0x1f98
// Size: 0x1c4
function function_e6d1297a( ent )
{
    self endon( #"death" );
    e_mover = util::spawn_model( "tag_origin", self gettagorigin( "j_spine4" ), self gettagangles( "j_spine4" ) );
    e_mover linkto( ent, "j_spine4" );
    var_1356d773 = 1;
    self stopfireweapon();
    self turretcleartarget( var_1356d773 );
    self turretsettarget( var_1356d773, e_mover );
    
    while ( isalive( ent ) )
    {
        var_3c84e44c = ent getvelocity();
        self fireweapon( var_1356d773, e_mover );
        
        /#
            if ( isdefined( ent ) )
            {
                line( self.origin, ent.origin );
            }
        #/
        
        waitframe( 1 );
    }
    
    self stopfireweapon();
    self turretcleartarget( var_1356d773 );
    e_mover delete();
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 2
// Checksum 0xebc349d1, Offset: 0x2168
// Size: 0x11c
function function_c38d67b4( var_d4cf58ab, n_move_time )
{
    self endon( #"death" );
    var_55555ae4 = [];
    var_55555ae4[ var_55555ae4.size ] = var_d4cf58ab;
    var_d5c428c9 = var_55555ae4[ 0 ];
    
    while ( isdefined( var_d5c428c9.target ) )
    {
        s = struct::get( var_d5c428c9.target, "targetname" );
        var_55555ae4[ var_55555ae4.size ] = s;
        var_d5c428c9 = s;
        waitframe( 1 );
    }
    
    for ( i = 1; true ; i = 0 )
    {
        self moveto( var_55555ae4[ i ].origin, n_move_time, n_move_time * 0.33, n_move_time * 0.33 );
        wait n_move_time;
        i++;
        
        if ( i == var_55555ae4.size )
        {
        }
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 4
// Checksum 0x653488a3, Offset: 0x2290
// Size: 0x54
function function_d6fedf97( guys, killcount, sflag, timeout )
{
    ai::waittill_dead_or_dying( guys, killcount, timeout );
    level flag::set( sflag );
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 4
// Checksum 0xfe190f43, Offset: 0x22f0
// Size: 0x2a4
function function_603d935( var_c5827a95, n_goalradius = 200, var_dd47e22 = 0.1, var_27ff9e4 = 0.4 )
{
    self endon( #"death" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy === "run_to_delete" )
    {
        a_nodes = getnodearraysorted( "delete_runner_node", "targetname", self.origin, 2048 );
        
        if ( a_nodes.size )
        {
            self ai::force_goal( a_nodes[ 0 ], 0 );
            self waittill( #"goal" );
            self deletedelay();
            return;
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x57>" );
            #/
        }
    }
    
    e_vol = getent( var_c5827a95, "targetname" );
    wait randomfloatrange( var_dd47e22, var_27ff9e4 );
    self notify( #"stop_going_to_node" );
    self val::set( #"hash_4629ea2949a36bbb", "goalradius", n_goalradius );
    var_11ac69bf = undefined;
    
    if ( math::cointoss() )
    {
        var_11ac69bf = 1;
    }
    
    self thread ai::force_goal( e_vol, var_11ac69bf );
    self.ignoresuppression = 1;
    self.grenadeawareness = 0;
    self ai::set_behavior_attribute( "sprint", 1 );
    self waittill( #"reached_path_end" );
    self.ignoresuppression = 0;
    self.grenadeawareness = 1;
    self ai::set_behavior_attribute( "sprint", 0 );
    self val::reset_all( #"hash_4629ea2949a36bbb" );
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 3
// Checksum 0x4705f88, Offset: 0x25a0
// Size: 0x1f2
function function_ed760ecb( var_a7f24c3d, var_b895b611 = 1, var_d3440450 = level.var_28c22d88[ 0 ] )
{
    ai = getent( var_a7f24c3d, "targetname", 1 );
    
    if ( !isalive( ai ) )
    {
        var_e582d78a = getent( var_a7f24c3d, "targetname" );
        ai = spawner::simple_spawn_single( var_e582d78a );
    }
    
    ai val::set( #"hash_6ac19077c919e860", "allowdeath", 0 );
    
    if ( !isdefined( level.allies ) )
    {
        level.allies = [];
    }
    else if ( !isarray( level.allies ) )
    {
        level.allies = array( level.allies );
    }
    
    if ( !isinarray( level.allies, ai ) )
    {
        level.allies[ level.allies.size ] = ai;
    }
    
    if ( is_true( var_b895b611 ) )
    {
        ai function_55623c92( var_d3440450, var_a7f24c3d );
    }
    
    ai setgoal( ai.origin );
    level.( var_a7f24c3d ) = ai;
    return ai;
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 2
// Checksum 0x24de70d5, Offset: 0x27a0
// Size: 0x134
function function_55623c92( var_d3440450 = level.var_28c22d88[ 0 ], str_name = self.targetname )
{
    var_142cfe56 = var_d3440450 + "_" + str_name;
    s_org = struct::get( var_142cfe56, "targetname" );
    
    if ( isdefined( s_org ) )
    {
        self forceteleport( s_org.origin, s_org.angles );
    }
    else
    {
        /#
            iprintln( "<dev string:xa8>" + str_name + "<dev string:xaf>" + level.var_c2ccaeac + "<dev string:xd8>" );
        #/
    }
    
    if ( isdefined( s_org.target ) )
    {
        self ai::set_goal( s_org.target, "targetname" );
    }
}

// Namespace namespace_42da7c51/namespace_1b8002ec
// Params 0
// Checksum 0xcdd85c6c, Offset: 0x28e0
// Size: 0x1c
function function_2afe54()
{
    self delete();
}

