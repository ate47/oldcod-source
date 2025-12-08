#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\core_common\vehicles\player_vehicle;

#namespace player_helicopter_huey;

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x6
// Checksum 0xb161d1c, Offset: 0x358
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"player_helicopter_huey", &preinit, undefined, undefined, #"player_vehicle" );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0x4045ede2, Offset: 0x3a8
// Size: 0x2c
function private preinit()
{
    vehicle::add_main_callback( "player_helicopter_huey", &function_de7295bc );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0x162eea6e, Offset: 0x3e0
// Size: 0x52c
function private function_de7295bc()
{
    self.death_type = "gibbed";
    self disabledriverfiring( 1 );
    
    /#
        self.var_41d0c729 = 1;
    #/
    
    self callback::function_d8abfc3d( #"on_vehicle_spawned", &function_89c08ee4 );
    self player_vehicle::function_bc79899e();
    
    if ( !isdefined( self ) || function_3132f113( self ) )
    {
        return;
    }
    
    callback::function_d8abfc3d( #"hash_666d48a558881a36", &function_1b957284 );
    callback::function_d8abfc3d( #"hash_55f29e0747697500", &function_a7401191 );
    callback::function_d8abfc3d( #"hash_2c1cafe2a67dfef8", &function_e2d16bde );
    self vehicle_ai::get_state_callbacks( "off" ).enter_func = &function_6d4df083;
    self vehicle_ai::get_state_callbacks( "off" ).exit_func = &function_b488602f;
    self vehicle_ai::get_state_callbacks( "death" ).enter_func = &function_d43d2b06;
    self vehicle_ai::get_state_callbacks( "death" ).update_func = &function_6ed31d89;
    self vehicle_ai::get_state_callbacks( "driving" ).enter_func = &function_c0745670;
    self vehicle_ai::get_state_callbacks( "driving" ).update_func = &function_b51c1995;
    self vehicle_ai::get_state_callbacks( "driving" ).exit_func = &function_a9ad737b;
    self vehicle_ai::get_state_callbacks( "scripted" ).enter_func = &function_3a367b9a;
    self vehicle_ai::get_state_callbacks( "scripted" ).update_func = undefined;
    self vehicle_ai::get_state_callbacks( "scripted" ).exit_func = &function_bf42edb7;
    self vehicle_ai::add_state( "landing", &function_200c3bd0, &function_3a7426cf, undefined );
    self vehicle_ai::add_state( "landed", &function_d39845f, &function_b705c816, undefined );
    
    if ( false )
    {
        self vehicle_ai::add_state( "spiral", &function_1f014f43, &function_2e3fb54c, &function_aaa84ac );
        self vehicle_ai::add_state( "recovery", &function_d344c3f, &function_e291246d, &function_ad15f5e8 );
    }
    
    self vehicle_ai::function_b94a7666( "driving", "exit_vehicle" );
    self vehicle_ai::function_b94a7666( "off", "enter_vehicle" );
    self vehicle_ai::add_interrupt_connection( "landing", "driving", "enter_vehicle", &function_329f45a4 );
    self vehicle_ai::add_interrupt_connection( "off", "landed", "enter_vehicle", &function_329f45a4 );
    self vehicle_ai::add_interrupt_connection( "landed", "off", "exit_vehicle", &function_a1fd6110 );
    self callback::on_vehicle_collision( &function_4885ce1 );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0xc00bfd5e, Offset: 0x918
// Size: 0x44
function private function_89c08ee4()
{
    self.vehkilloccupantsondeath = 1;
    self.var_ffdf490c = 1;
    
    /#
        self thread player_vehicle::deletemeonnotify( level, "<dev string:x38>" );
    #/
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xf40cc043, Offset: 0x968
// Size: 0x2a
function private function_b985a0f1( player )
{
    self notify( #"pilot_enter" );
    self.owner = player;
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xd3e361b, Offset: 0x9a0
// Size: 0x104
function private function_2205f6bf( *player )
{
    state = self vehicle_ai::get_current_state();
    self notify( #"hash_3c7ae83e462fe4e2" );
    self notify( #"pilot_exit" );
    self setheliheightcap( 0 );
    self setheliheightlock( 0 );
    
    if ( isdefined( self.owner ) )
    {
        self.owner = undefined;
    }
    
    if ( state === "landed" || state === "off" || state === "scripted" )
    {
        return;
    }
    
    if ( state === "spiral" )
    {
        self.var_4e76046a = 1;
        return;
    }
    
    self function_d929b41();
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0x3b346bca, Offset: 0xab0
// Size: 0x10a
function private function_1b957284( params )
{
    player = params.player;
    eventstruct = params.eventstruct;
    seatindex = eventstruct.seat_index;
    
    if ( seatindex === 0 )
    {
        self function_b985a0f1( player );
    }
    
    player setsunshadowsplitdistance( 6000 );
    
    if ( eventstruct.seat_index === 1 || eventstruct.seat_index === 2 )
    {
        player thread function_5bce3f3a( self, eventstruct.seat_index );
        player thread update_turret_fire( self, eventstruct.seat_index );
        return;
    }
    
    if ( eventstruct.seat_index === 0 )
    {
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xe57b319, Offset: 0xbc8
// Size: 0x9c
function private function_a7401191( params )
{
    player = params.player;
    eventstruct = params.eventstruct;
    seatindex = eventstruct.seat_index;
    
    if ( seatindex === 0 )
    {
        self function_2205f6bf( player );
    }
    
    player setsunshadowsplitdistance( 0 );
    player function_6adf512b();
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0x54c59708, Offset: 0xc70
// Size: 0x146
function private function_e2d16bde( params )
{
    player = params.player;
    eventstruct = params.eventstruct;
    seatindex = eventstruct.seat_index;
    oldseatindex = eventstruct.old_seat_index;
    
    if ( oldseatindex === 0 )
    {
        self function_2205f6bf( player );
    }
    else if ( seatindex === 0 )
    {
        self function_b985a0f1( player );
    }
    
    if ( eventstruct.seat_index === 1 || eventstruct.seat_index === 2 )
    {
        player thread function_5bce3f3a( self, eventstruct.seat_index );
        player thread update_turret_fire( self, eventstruct.seat_index );
        return;
    }
    
    player function_6adf512b();
    
    if ( eventstruct.seat_index === 0 )
    {
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xc5af5181, Offset: 0xdc0
// Size: 0xe0
function private function_c0745670( params )
{
    params.driver = self getseatoccupant( 0 );
    
    if ( isdefined( params.driver ) )
    {
        self disableaimassist();
        self.turretrotscale = 1;
        
        if ( hasasm( self ) )
        {
            self asmrequestsubstate( #"locomotion@movement" );
        }
        
        vehicle_ai::clearalllookingandtargeting();
        vehicle_ai::clearallmovement();
        self cancelaimove();
        self returnplayercontrol();
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x3311bf08, Offset: 0xea8
// Size: 0xc
function function_b51c1995( *params )
{
    
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x6ca9451f, Offset: 0xec0
// Size: 0x44
function function_a9ad737b( *params )
{
    self enableaimassist();
    self.turretrotscale = 1;
    self takeplayercontrol();
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 4
// Checksum 0x894adb5c, Offset: 0xf10
// Size: 0x6e, Type: bool
function function_329f45a4( *current_state, *to_state, *connection, *params )
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    driver = self getseatoccupant( 0 );
    
    if ( isplayer( driver ) )
    {
        return true;
    }
    
    return false;
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 4, eflags: 0x4
// Checksum 0xfb1fd34, Offset: 0xf88
// Size: 0x44, Type: bool
function private function_a1fd6110( current_state, to_state, connection, params )
{
    return !function_329f45a4( current_state, to_state, connection, params );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0xcf9c9357, Offset: 0xfd8
// Size: 0x13c
function function_3a367b9a( params )
{
    if ( params.no_clear_movement !== 1 )
    {
        vehicle_ai::clearalllookingandtargeting();
        vehicle_ai::clearallmovement();
        
        if ( hasasm( self ) )
        {
            self asmrequestsubstate( #"locomotion@movement" );
        }
        
        self resumespeed();
    }
    
    if ( params.var_a22ee662 === 1 )
    {
        self vehicle::toggle_tread_fx( 1 );
        self vehicle::toggle_exhaust_fx( 1 );
        self thread vehicle_ai::nudge_collision();
        self setrotorspeed( 1 );
        
        if ( !is_true( self.nolights ) )
        {
            self vehicle::lights_on();
        }
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x135f9723, Offset: 0x1120
// Size: 0x44
function function_bf42edb7( params )
{
    if ( params.no_clear_movement !== 1 )
    {
        vehicle_ai::clearalllookingandtargeting();
        vehicle_ai::clearallmovement();
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xc1073a02, Offset: 0x1170
// Size: 0x184
function private function_6d4df083( params )
{
    self setvehvelocity( ( 0, 0, 0 ) );
    self setangularvelocity( ( 0, 0, 0 ) );
    self setphysacceleration( ( 0, 0, 0 ) );
    self sethoverparams( 0 );
    self setgoal( self.origin, 1, 0 );
    self setrotorspeed( 0 );
    self vehicle::toggle_tread_fx( 0 );
    self vehicle::toggle_exhaust_fx( 0 );
    self vehicle::toggle_sounds( 0 );
    self vehicle::function_bbc1d940( 0 );
    self disableaimassist();
    vehicle_ai::turnoffallambientanims();
    vehicle_ai::clearalllookingandtargeting();
    vehicle_ai::clearallmovement();
    
    if ( !is_true( params.isinitialstate ) )
    {
        self vehicle::function_7f0bbde3();
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0x46cb8d1, Offset: 0x1300
// Size: 0x15c
function private function_b488602f( params )
{
    params.var_32a85fa1 = 2;
    params.var_1751c737 = 1;
    params.var_da88902a = 1;
    params.var_30a04b16 = 1;
    self vehicle::toggle_tread_fx( 1 );
    self vehicle::toggle_exhaust_fx( 1 );
    self thread vehicle::function_fa4236af( params );
    self enableaimassist();
    self setphysacceleration( ( 0, 0, 0 ) );
    self thread vehicle_ai::nudge_collision();
    self setrotorspeed( 1 );
    
    if ( isdefined( level.enable_thermal ) )
    {
        if ( self vehicle_ai::get_next_state() !== "death" )
        {
            [[ level.enable_thermal ]]();
        }
    }
    
    if ( !is_true( self.nolights ) )
    {
        self vehicle::lights_on();
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xd4d7384f, Offset: 0x1468
// Size: 0xc4
function private function_d43d2b06( params )
{
    riders = self vehicle::function_86c7bebb();
    
    foreach ( rider in riders )
    {
        rider util::stop_magic_bullet_shield();
    }
    
    self vehicle_ai::defaultstate_death_enter( params );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xa992683c, Offset: 0x1538
// Size: 0x234
function private function_6ed31d89( params )
{
    self endon( #"death" );
    
    if ( isdefined( level.vehicle_destructer_cb ) )
    {
        [[ level.vehicle_destructer_cb ]]( self );
    }
    
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage( "MOD_EXPLOSIVE", params.attacker );
    self vehicle::do_death_dynents();
    self notsolid();
    self ghost();
    
    if ( isdefined( self.deathmodel ) )
    {
        if ( !isdefined( level.var_35182065 ) )
        {
            level.var_35182065 = [];
        }
        
        util::wait_network_frame();
        deathmodel = spawn( "script_model", self.origin );
        deathmodel.targetname = "heli_deathmodel";
        deathmodel setmodel( self.deathmodel );
        deathmodel.angles = self.angles;
        deathmodel physicslaunch( ( 0, 0, 0 ), self getvelocity() * 0.8 );
        
        if ( !isdefined( level.var_35182065 ) )
        {
            level.var_35182065 = [];
        }
        else if ( !isarray( level.var_35182065 ) )
        {
            level.var_35182065 = array( level.var_35182065 );
        }
        
        level.var_35182065[ level.var_35182065.size ] = deathmodel;
    }
    
    vehicle_death::deletewhensafe();
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x3c8bbc1b, Offset: 0x1778
// Size: 0x9c
function function_1f014f43( params )
{
    if ( !isdefined( params.rotorspeed ) )
    {
        params.rotorspeed = 0.7;
    }
    
    occupants = self getvehoccupants();
    
    if ( occupants.size == 0 )
    {
        params.maxtilt = 60;
    }
    
    self setrotorspeed( params.rotorspeed );
    self takeplayercontrol();
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x8b633402, Offset: 0x1820
// Size: 0x35e
function function_2e3fb54c( params )
{
    self endon( #"change_state", #"death" );
    
    if ( !isdefined( params.maxtilt ) )
    {
        params.maxtilt = 25;
    }
    
    if ( is_true( params.var_6249a386 ) )
    {
        params.nopitch = 1;
        params.var_96a3f4c7 = 1;
    }
    
    targetyaw = randomintrange( 50, 150 );
    
    if ( targetyaw % 2 == 0 )
    {
        targetyaw *= -1;
    }
    
    pitch = 0;
    roll = 0;
    yaw = 0;
    
    if ( !is_true( params.var_96a3f4c7 ) )
    {
        roll = targetyaw * -1 * randomfloatrange( 0.125, 0.25 );
    }
    
    if ( !is_true( params.nopitch ) )
    {
        pitch = abs( targetyaw ) * randomfloatrange( 0.075, 0.15 );
    }
    
    starttime = gettime();
    
    while ( true )
    {
        if ( abs( yaw ) < abs( targetyaw ) )
        {
            yaw = lerpfloat( 0, targetyaw, ( gettime() - starttime ) / 3000 );
        }
        
        if ( ( pitch || roll ) && asin( anglestoup( self.angles )[ 2 ] ) < 90 - params.maxtilt )
        {
            pitch = 0;
            roll = 0;
        }
        
        self setangularvelocity( ( pitch, yaw, roll ) );
        up = anglestoup( self.angles );
        accel = 1200;
        
        if ( params.maxtilt < 45 )
        {
            accel = 1600;
        }
        
        self setphysacceleration( ( up[ 0 ] * accel, up[ 1 ] * accel, -386 * max( 0.4, 1.2 - up[ 2 ] ) ) );
        waitframe( 1 );
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0xd3e4e2ef, Offset: 0x1b88
// Size: 0xc
function function_aaa84ac( *params )
{
    
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x3644d941, Offset: 0x1ba0
// Size: 0x44
function function_d344c3f( *params )
{
    self setrotorspeed( 1 );
    self takeplayercontrol();
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x403db5b9, Offset: 0x1bf0
// Size: 0x15a
function function_e291246d( *params )
{
    self endon( #"death", #"change_state" );
    
    while ( true )
    {
        pilot = self getseatoccupant( 0 );
        
        if ( !isdefined( pilot ) )
        {
            self vehicle_ai::set_state( "spiral" );
            break;
        }
        
        move = pilot getnormalizedmovement();
        
        if ( pilot vehiclemoveupbuttonpressed() || isdefined( move ) && ( abs( move[ 0 ] ) > 0.2 || abs( move[ 1 ] ) > 0.2 ) )
        {
            self.var_4e76046a = undefined;
            self returnplayercontrol();
            self vehicle_ai::set_state( "driving" );
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x4d8ad38e, Offset: 0x1d58
// Size: 0xc
function function_ad15f5e8( *params )
{
    
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0xbcb877c6, Offset: 0x1d70
// Size: 0x5c
function function_200c3bd0( *params )
{
    self setvehvelocity( ( 0, 0, 0 ) );
    self setangularvelocity( ( 0, 0, 0 ) );
    self setphysacceleration( ( 0, 0, -386 ) );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x83648fef, Offset: 0x1dd8
// Size: 0xe8
function function_3a7426cf( *params )
{
    self endon( #"change_state", #"death" );
    damagetime = gettime() + 15000;
    
    while ( true )
    {
        wait 0.25;
        
        if ( self function_479389f3() )
        {
            self vehicle_ai::set_state( "landed" );
            return;
        }
        else
        {
            function_3b841f4();
        }
        
        if ( gettime() > damagetime )
        {
            self dodamage( 250, self.origin, undefined, undefined, "", "MOD_IMPACT" );
        }
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0xf56012c1, Offset: 0x1ec8
// Size: 0xc
function function_3b1d3bf1( *params )
{
    
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x351f34bf, Offset: 0x1ee0
// Size: 0xdc
function function_d39845f( *params )
{
    self takeplayercontrol();
    self setvehvelocity( ( 0, 0, 0 ) );
    self setangularvelocity( ( 0, 0, 0 ) );
    self setphysacceleration( ( 0, 0, 0 ) );
    self sethoverparams( 0 );
    self setgoal( self.origin, 1, 0 );
    self thread function_6c8cff7e( self.var_67136cb0, self.helilandingorigin, self.var_6fac6f50 );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x877c6dbb, Offset: 0x1fc8
// Size: 0x25a
function function_b705c816( params )
{
    self endon( #"death", #"state_changed" );
    
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    if ( is_true( self.jammed ) )
    {
        params.var_c1273f91 = 1;
        self vehicle_ai::set_state( "off", params );
        return;
    }
    
    if ( self vehicle_ai::get_previous_state() === "off" )
    {
        wait 2;
    }
    
    while ( true )
    {
        if ( is_true( self.jammed ) )
        {
            params.var_c1273f91 = 1;
            self vehicle_ai::set_state( "off", params );
            break;
        }
        
        if ( is_true( self.var_b3e4af16 ) )
        {
            waitframe( 1 );
            continue;
        }
        
        player = self getseatoccupant( 0 );
        
        if ( !isdefined( player ) )
        {
            params.no_falling = 1;
            params.var_c1273f91 = 1;
            self vehicle_ai::set_state( "off", params );
            break;
        }
        
        move = player getnormalizedmovement();
        
        if ( player vehiclemoveupbuttonpressed() || isdefined( move ) && ( abs( move[ 0 ] ) > 0.2 || abs( move[ 1 ] ) > 0.2 ) )
        {
            self vehicle_ai::set_state( "driving" );
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x44c840a9, Offset: 0x2230
// Size: 0x8c
function function_7db28345( *params )
{
    if ( vehicle_ai::function_329f45a4() )
    {
        self notify( #"hash_7f30c56005fe2b32" );
        self returnplayercontrol();
        
        if ( isdefined( self.rotatemover ) )
        {
            self.rotatemover delete();
            self.rotatemover = undefined;
        }
    }
    
    self function_f4d358df();
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0x30f9c31c, Offset: 0x22c8
// Size: 0x65a, Type: bool
function private function_479389f3()
{
    height = self.height;
    assert( isdefined( self.radius ) );
    assert( isdefined( self.height ) );
    var_33a206d0 = [];
    var_33a206d0[ #"leftrear" ] = self gettagorigin( "tag_ground_contact_left_rear" );
    var_33a206d0[ #"leftmiddle" ] = self gettagorigin( "tag_ground_contact_left_middle" );
    var_33a206d0[ #"leftfront" ] = self gettagorigin( "tag_ground_contact_left_front" );
    var_8fc02d3b = [];
    var_8fc02d3b[ #"rightrear" ] = self gettagorigin( "tag_ground_contact_right_rear" );
    var_8fc02d3b[ #"rightmiddle" ] = self gettagorigin( "tag_ground_contact_right_middle" );
    var_8fc02d3b[ #"rightfront" ] = self gettagorigin( "tag_ground_contact_right_front" );
    var_df47b913 = [];
    
    foreach ( tag, origin in var_33a206d0 )
    {
        if ( !isdefined( origin ) )
        {
            return false;
        }
        
        var_df47b913[ tag ] = physicstrace( origin + ( 0, 0, 25 ), origin - ( 0, 0, 75 ), ( 0, 0, 0 ), ( 0, 0, 0 ), self, 2 );
    }
    
    var_dc8469e2 = [];
    
    foreach ( tag, origin in var_8fc02d3b )
    {
        if ( !isdefined( origin ) )
        {
            return false;
        }
        
        var_dc8469e2[ tag ] = physicstrace( origin + ( 0, 0, 25 ), origin - ( 0, 0, 75 ), ( 0, 0, 0 ), ( 0, 0, 0 ), self, 2 );
    }
    
    var_d643c4fc = 0;
    var_e10b67f7 = [];
    var_b0e8278f = ( 0, 0, 0 );
    avgnormal = ( 0, 0, 0 );
    var_4c962569 = 0;
    
    foreach ( tag, trace in var_df47b913 )
    {
        if ( isdefined( trace[ #"entity" ] ) )
        {
            var_d643c4fc = 1;
            continue;
        }
        
        if ( trace[ #"fraction" ] < 1 )
        {
            var_b0e8278f += var_33a206d0[ tag ];
            var_4c962569 += trace[ #"position" ][ 2 ] - var_33a206d0[ tag ][ 2 ];
            avgnormal += trace[ #"normal" ];
            var_e10b67f7[ tag ] = trace;
        }
    }
    
    var_d3532cfe = [];
    
    foreach ( tag, trace in var_dc8469e2 )
    {
        if ( isdefined( trace[ #"entity" ] ) )
        {
            var_d643c4fc = 1;
            continue;
        }
        
        if ( trace[ #"fraction" ] < 1 )
        {
            var_b0e8278f += var_8fc02d3b[ tag ];
            var_4c962569 += trace[ #"position" ][ 2 ] - var_8fc02d3b[ tag ][ 2 ];
            avgnormal += trace[ #"normal" ];
            var_d3532cfe[ tag ] = trace;
        }
    }
    
    if ( var_e10b67f7.size > 0 || var_d3532cfe.size > 0 )
    {
        avgnormal /= var_d3532cfe.size + var_e10b67f7.size;
        self.var_eb4e4182 = avgnormal;
    }
    
    if ( avgnormal[ 2 ] < 0.94 )
    {
        return false;
    }
    
    if ( var_e10b67f7.size == 0 || var_d3532cfe.size == 0 || var_d3532cfe.size + var_e10b67f7.size < 3 )
    {
        return false;
    }
    
    if ( var_d643c4fc )
    {
        return false;
    }
    
    var_4c962569 /= var_d3532cfe.size + var_e10b67f7.size + 1;
    
    if ( var_4c962569 > 20 )
    {
        return false;
    }
    
    var_b0e8278f /= var_d3532cfe.size + var_e10b67f7.size;
    self.helilandingorigin = var_b0e8278f;
    self.var_6fac6f50 = var_4c962569;
    self.var_67136cb0 = avgnormal;
    return true;
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xbe3db9cd, Offset: 0x2930
// Size: 0x55c
function private function_4885ce1( params )
{
    if ( params.stype === "player" )
    {
        return;
    }
    
    if ( isdefined( params.entity ) && isvehicle( params.entity ) && params.entity function_dcef0ba1( 0 ) && !params.entity isvehicleseatoccupied( 0 ) )
    {
        force = vectornormalize( params.entity.origin - self.origin ) * 1.2;
        params.entity launchvehicle( force );
    }
    
    if ( is_true( self.var_4e76046a ) )
    {
        self dodamage( self.health, self.origin, undefined, undefined, "", "MOD_IMPACT" );
        return;
    }
    
    if ( !is_true( self.var_4dab0a63 ) )
    {
        var_1fdf316c = 25;
        var_a7796a79 = 100;
        mindamage = 150;
        maxdamage = 5000;
        speed = self getspeedmph();
        
        if ( isdefined( params.entity ) && isvehicle( params.entity ) )
        {
            var_b219fafb = params.entity getspeedmph();
            
            if ( var_b219fafb > speed )
            {
                speed = var_b219fafb;
            }
        }
        
        if ( speed > var_1fdf316c )
        {
            applydamage = mapfloat( var_1fdf316c, var_a7796a79, mindamage, maxdamage, speed );
            normal = params.normal;
            sourceposition = self.origin - 100 * normal;
            
            if ( isdefined( params.entity ) && isvehicle( params.entity ) )
            {
                riders = params.entity getvehoccupants();
                
                if ( isdefined( riders ) && isdefined( riders[ 0 ] ) )
                {
                    attacker = riders[ 0 ];
                }
            }
            
            self dodamage( applydamage, sourceposition, attacker );
        }
    }
    
    state = self vehicle_ai::get_current_state();
    
    if ( state === "driving" )
    {
        player = self getseatoccupant( 0 );
        
        if ( !isdefined( player ) || !player vehiclemovedownbuttonpressed() )
        {
            return;
        }
        
        move = player getnormalizedmovement();
        
        if ( isdefined( move ) && ( abs( move[ 0 ] ) > 0.2 || abs( move[ 1 ] ) > 0.2 ) )
        {
            return;
        }
        
        if ( isdefined( params.entity ) )
        {
            return;
        }
        
        if ( self function_479389f3() )
        {
            self vehicle_ai::set_state( "landed", params );
        }
        else
        {
            player clientfield::set_player_uimodel( "vehicle.invalidLanding", 1 );
        }
        
        return;
    }
    
    if ( state === "landing" || state === "spiral" )
    {
        self function_479389f3();
        
        if ( isdefined( self.var_67136cb0 ) )
        {
            self vehicle_ai::set_state( "landed" );
            return;
        }
        
        if ( isdefined( self.var_eb4e4182 ) )
        {
            if ( self vehicle_ai::get_current_state() === "spiral" )
            {
                self vehicle_ai::set_state( "landing" );
            }
            
            self function_9dd58750();
        }
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0
// Checksum 0x1accfc52, Offset: 0x2e98
// Size: 0xac
function function_9dd58750()
{
    if ( !isdefined( self.var_eb4e4182 ) )
    {
        return;
    }
    
    if ( self.var_eb4e4182[ 2 ] < 0.99 )
    {
        verticalspeed = self getvelocity()[ 2 ];
        slidemove = ( self.var_eb4e4182[ 0 ] * 300, self.var_eb4e4182[ 1 ] * 300, verticalspeed );
    }
    else
    {
        slidemove = ( 1, 0, 0 ) * 300;
    }
    
    self setvehvelocity( slidemove );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 3
// Checksum 0x89bf0c4f, Offset: 0x2f50
// Size: 0x2b4
function function_6c8cff7e( normal, origin = self.origin, offset = 0 )
{
    self notify( "71be530b09203ff8" );
    self endon( "71be530b09203ff8" );
    self endon( #"death", #"hash_7f30c56005fe2b32" );
    
    if ( !isdefined( normal ) )
    {
        return;
    }
    
    if ( isdefined( self.rotatemover ) )
    {
        self.rotatemover delete();
        self.rotatemover = undefined;
    }
    
    self.rotatemover = spawn( "script_model", origin );
    self.rotatemover.targetname = "heli_rotatemover";
    
    if ( isdefined( self.rotatemover ) )
    {
        self.rotatemover thread player_vehicle::deletemeonnotify( self, "death" );
        self.rotatemover.angles = self.angles;
        targetangles = function_c1fa62a2( self.rotatemover.angles, normal );
        self linkto( self.rotatemover );
        self.rotatemover rotateto( targetangles, 0.5, 0, 0.5 );
        self.rotatemover moveto( origin + ( 0, 0, offset ), 0.5, 0, 0.5 );
        self.rotatemover waittill( #"rotatedone" );
        self.rotatemover delete();
        self.rotatemover = undefined;
    }
    
    self setvehvelocity( ( 0, 0, 0 ) );
    self setangularvelocity( ( 0, 0, 0 ) );
    self setphysacceleration( ( 0, 0, 0 ) );
    self sethoverparams( 0 );
    self setgoal( self.origin, 1, 0 );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0x2e977e5b, Offset: 0x3210
// Size: 0x2a
function private function_f4d358df()
{
    self.var_c1764af8 = 0;
    self.var_4dab0a63 = 0;
    self.var_67136cb0 = undefined;
    self.var_6fac6f50 = undefined;
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0x98fe3b62, Offset: 0x3248
// Size: 0x19c
function private function_d929b41()
{
    self.var_4dab0a63 = 0;
    speed = self getspeedmph();
    heighttrace = physicstrace( self.origin, self.origin - ( 0, 0, 1536 ), ( 0, 0, 0 ), ( 0, 0, 0 ), self, 2 );
    
    if ( speed < 15 && heighttrace[ #"fraction" ] < 0.260417 )
    {
        self.var_4dab0a63 = 1;
        self.var_c1764af8 = 1;
        self vehicle_ai::set_state( "landing" );
        return;
    }
    
    if ( false )
    {
        if ( speed < 80 && heighttrace[ #"fraction" ] < 1 )
        {
            self.var_c1764af8 = 1;
            params = spawnstruct();
            params.var_6249a386 = 1;
            self vehicle_ai::set_state( "spiral", params );
            return;
        }
        
        self.var_4e76046a = 1;
        self vehicle_ai::set_state( "spiral" );
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0x4d7479cb, Offset: 0x33f0
// Size: 0x114
function private function_3b841f4()
{
    if ( false )
    {
        heighttrace = physicstrace( self.origin, self.origin - ( 0, 0, 1536 ), ( 0, 0, 0 ), ( 0, 0, 0 ), self, 2 );
        
        if ( heighttrace[ #"fraction" ] >= 1 )
        {
            self.var_4e76046a = 1;
            self vehicle_ai::set_state( "spiral" );
            return;
        }
        
        if ( heighttrace[ #"fraction" ] > 0.260417 )
        {
            self.var_c1764af8 = 1;
            params = spawnstruct();
            params.var_6249a386 = 1;
            self vehicle_ai::set_state( "spiral", params );
        }
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0x16857a3a, Offset: 0x3510
// Size: 0x1b6
function private function_6d399643()
{
    if ( !isdefined( self.var_761c973 ) || !isdefined( self.var_761c973.riders ) )
    {
        return;
    }
    
    self endon( #"death" );
    self.var_d53c0518 = 0;
    self.var_74d470ff = 0;
    
    while ( true )
    {
        gunner1 = self.var_761c973.riders[ #"gunner1" ];
        gunner2 = self.var_761c973.riders[ #"gunner2" ];
        
        if ( isdefined( gunner1 ) )
        {
            if ( !self.var_d53c0518 )
            {
                self.var_d53c0518 = 1;
                self thread function_9bb1cff6( 1 );
            }
        }
        else if ( self.var_d53c0518 )
        {
            self.var_d53c0518 = 0;
            self notify( "stop_firing_turret" + 1 );
            self turretcleartarget( 1 );
        }
        
        if ( isdefined( gunner2 ) )
        {
            if ( !self.var_74d470ff )
            {
                self.var_74d470ff = 1;
                self thread function_9bb1cff6( 2 );
            }
        }
        else if ( self.var_74d470ff )
        {
            self.var_74d470ff = 0;
            self notify( "stop_firing_turret" + 2 );
            self turretcleartarget( 2 );
        }
        
        wait 1;
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xd1d2e3be, Offset: 0x36d0
// Size: 0x120
function private function_9bb1cff6( var_2d58d1bd )
{
    self notify( "turret " + var_2d58d1bd + " firing" );
    self endon( "turret " + var_2d58d1bd + " firing" );
    self endon( #"death" );
    self endon( "stop_firing_turret" + var_2d58d1bd );
    
    while ( true )
    {
        enemy = self.enemy;
        
        if ( isdefined( enemy ) )
        {
            if ( self cansee( enemy ) )
            {
                self turretsettarget( var_2d58d1bd, enemy );
                self vehicle_ai::fire_for_time( randomfloatrange( 0.75, 1.5 ), var_2d58d1bd, enemy );
            }
        }
        else
        {
            self turretcleartarget( var_2d58d1bd );
        }
        
        wait 0.4;
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 2
// Checksum 0x9204c541, Offset: 0x37f8
// Size: 0x15e
function function_5bce3f3a( vehicle, seat_index )
{
    self endon( #"death", #"disconnect", #"exit_vehicle", #"change_seat" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        heatvalue = vehicle getturretheatvalue( seat_index );
        var_62e4ee3 = heatvalue / 100;
        
        if ( var_62e4ee3 < 0 )
        {
            var_62e4ee3 = 0;
        }
        else if ( var_62e4ee3 > 1 )
        {
            var_62e4ee3 = 1;
        }
        
        var_24139930 = vehicle isvehicleturretoverheating( seat_index );
        
        if ( var_24139930 )
        {
            vehicle clientfield::set( "overheat_fx", 1 );
        }
        else
        {
            vehicle clientfield::set( "overheat_fx", 0 );
        }
        
        waitframe( 1 );
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0x6ea51c38, Offset: 0x3960
// Size: 0xaa
function private function_41cb03eb( seat_index )
{
    switch ( seat_index )
    {
        case 0:
            return "tag_turret";
        case 1:
            return "tag_gunner_turret1";
        case 2:
            return "tag_gunner_turret2";
        case 3:
            return "tag_gunner_turret3";
        case 4:
            return "tag_gunner_turret4";
        default:
            return undefined;
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 2
// Checksum 0x9387b4da, Offset: 0x3a18
// Size: 0xca
function update_turret_fire( vehicle, seat_index )
{
    self endon( #"death", #"disconnect", #"exit_vehicle", #"change_seat" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        params = vehicle waittill( #"gunner_weapon_fired" );
        
        if ( params.gunner_index === seat_index )
        {
            var_251a3d58 = function_41cb03eb( seat_index );
        }
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1
// Checksum 0x600f6b0f, Offset: 0x3af0
// Size: 0x64
function function_388973e4( disable )
{
    self disabledriverfiring( disable );
    
    for ( gunnerindex = 0; gunnerindex < 4 ; gunnerindex++ )
    {
        self disablegunnerfiring( gunnerindex, disable );
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0
// Checksum 0x80f724d1, Offset: 0x3b60
// Size: 0x4
function function_6adf512b()
{
    
}

/#

    // Namespace player_helicopter_huey/player_helicopter_huey
    // Params 2
    // Checksum 0xf6b04840, Offset: 0x3b70
    // Size: 0x1e8, Type: dev
    function function_4b35a9ab( helicopter, *eventstruct )
    {
        self endon( #"death", #"disconnect", #"exit_vehicle", #"change_seat" );
        eventstruct endon( #"pilot_exit" );
        self notify( "<dev string:x4f>" );
        self endon( "<dev string:x4f>" );
        iprintlnbold( "<dev string:x63>" );
        enabled = 0;
        
        while ( true )
        {
            if ( self actionslotonebuttonpressed() && eventstruct.var_41d0c729 )
            {
                enabled = !enabled;
                
                if ( enabled )
                {
                    iprintlnbold( "<dev string:x8d>" );
                    eventstruct setheliheightlock( 1 );
                    eventstruct setheliheightcap( 1 );
                    setdvar( #"g_vehicledebug", 4 );
                }
                else
                {
                    iprintlnbold( "<dev string:xc9>" );
                    eventstruct setheliheightlock( 0 );
                    eventstruct setheliheightcap( 0 );
                    setdvar( #"g_vehicledebug", 0 );
                }
                
                do
                {
                    waitframe( 1 );
                }
                while ( self actionslotonebuttonpressed() );
            }
            
            waitframe( 1 );
        }
    }

    // Namespace player_helicopter_huey/player_helicopter_huey
    // Params 2
    // Checksum 0x3769f821, Offset: 0x3d60
    // Size: 0x288, Type: dev
    function function_52dc2b28( helicopter, *eventstruct )
    {
        self endon( #"death", #"disconnect", #"exit_vehicle", #"change_seat" );
        eventstruct endon( #"pilot_exit" );
        self notify( "<dev string:xe6>" );
        self endon( "<dev string:xe6>" );
        var_c3de1760 = [];
        var_db7f7f7c = function_951b4205();
        
        foreach ( asset in var_db7f7f7c )
        {
            if ( isdefined( asset.name ) )
            {
                if ( asset.name == "<dev string:xfa>" )
                {
                    array::add( var_c3de1760, "<dev string:xfa>" );
                    continue;
                }
                
                if ( asset.name == "<dev string:x12a>" )
                {
                    array::add( var_c3de1760, "<dev string:x12a>" );
                }
            }
        }
        
        if ( var_c3de1760.size < 2 )
        {
            return;
        }
        
        iprintlnbold( "<dev string:x162>" );
        var_86daccc8 = 0;
        
        if ( isdefined( eventstruct.vehicletype ) )
        {
            var_86daccc8 = array::find( var_c3de1760, eventstruct.vehicletype );
        }
        
        while ( true )
        {
            if ( self actionslottwobuttonpressed() && eventstruct.var_41d0c729 )
            {
                var_86daccc8++;
                
                if ( var_86daccc8 > var_c3de1760.size - 1 )
                {
                    var_86daccc8 = 0;
                }
                
                eventstruct setvehicletype( var_c3de1760[ var_86daccc8 ] );
                
                do
                {
                    waitframe( 1 );
                }
                while ( self actionslottwobuttonpressed() );
            }
            
            waitframe( 1 );
        }
    }

#/
