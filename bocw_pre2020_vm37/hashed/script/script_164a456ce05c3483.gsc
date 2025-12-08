#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_4611af4073d18808;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_7f5aeb59;

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x5a34db2f, Offset: 0x6b0
// Size: 0x1cc
function function_f3143608()
{
    self namespace_ec06fe4a::function_4f72130c();
    
    if ( !isdefined( self.entnum ) )
    {
        self.entnum = self getentitynumber();
    }
    
    namespace_1e25ad94::debugmsg( "Setting player bodytype to: " + self.entnum );
    self setcharacterbodytype( self.entnum );
    self.doa = spawnstruct();
    self function_fcc90081( 1 );
    self enablelinkto();
    
    if ( isdefined( level.doa ) && isdefined( level.doa.var_5c6568f4 ) )
    {
        self thread [[ level.doa.var_5c6568f4 ]]();
    }
    
    self thread function_d09d2055();
    self thread function_bfdc540a();
    spawn_points = struct::get_array( "info_player_start", "targetname" );
    entnumber = self getentitynumber();
    
    if ( spawn_points.size > entnumber )
    {
        self setorigin( spawn_points[ entnumber ].origin );
    }
    
    self thread function_c0310e2a();
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x90a8f9f0, Offset: 0x888
// Size: 0x7a
function function_d09d2055()
{
    self endon( #"disconnect" );
    level endon( #"game_over" );
    
    while ( array::contains( function_a1ef346b(), self ) == 0 )
    {
        self.ignoreme = 1;
        waitframe( 1 );
    }
    
    self.ignoreme = 0;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0xd09a2091, Offset: 0x910
// Size: 0x114
function function_b1a82efa( on )
{
    self setclientuivisibilityflag( "weapon_hud_visible", 0 );
    self setclientuivisibilityflag( "g_compassShowEnemies", 0 );
    self setclientuivisibilityflag( "hud_visible", 0 );
    self setclientuivisibilityflag( "radar_client", 0 );
    self setclientuivisibilityflag( "killcam_nemesis", 0 );
    
    if ( on )
    {
        self setclientuivisibilityflag( "hud_visible", 1 );
        self setclientuivisibilityflag( "radar_client", 1 );
        self setclientuivisibilityflag( "g_compassShowEnemies", 1 );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0xec809ca3, Offset: 0xa30
// Size: 0x518
function function_fcc90081( var_45b95f80 = 0 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( var_45b95f80 )
    {
        self.doa.entnum = self getentitynumber();
        self.topdowncamera = 1;
        self.doa.weapontype = 0;
        self.doa.weaponlevel = 0;
        self.doa.var_fd5fcb75 = "";
        self.doa.var_484cc88b = 0;
        self.doa.color = getplayercolor( self );
        self.doa.var_d6b75dff = 0;
        self.doa.weapontime = 0;
        self.doa.var_d8955419 = 0;
        self.doa.var_e5805edb = 1;
        self.doa.var_77c8b9d4 = 0;
        self.doa.var_99c6ee47 = 0;
        self.doa.var_82fb5d17 = 0;
        self.doa.var_f583234e = 0;
        self.doa.hintmask = 0;
        self thread namespace_83eb6304::function_3ecfde67( "player_trail_" + self.doa.color );
        self.doa.var_ed8fde10 = "zombietron_lmg";
        self.lastnonkillstreakweapon = getweapon( self.doa.var_ed8fde10 );
        self.doa.var_6b4163f1 = randomint( 250 );
        self.doa.var_ad888d1f = [];
        self setmovespeedscale( self.doa.var_e5805edb );
        self function_b1a82efa( 1 );
        self.health = 150;
        self.maxhealth = 150;
        
        if ( isdefined( level.doa.var_d0b39b1a ) )
        {
            self [[ level.doa.var_d0b39b1a ]]();
        }
        
        if ( isdefined( level.doa.var_3bc55386 ) )
        {
            self [[ level.doa.var_3bc55386 ]]();
        }
        
        self.doa.var_11abc438 = self.origin;
        namespace_1e25ad94::debugmsg( "Setting player bodytype to: " + self.entnum );
        self setcharacterbodytype( self.entnum );
        self setperk( "specialty_sprint" );
        self setperk( "specialty_seethroughjammer" );
        self setperk( "specialty_sprintreload" );
        self setperk( "specialty_slide" );
        self.var_f07d3654 = 1;
        self thread function_77785447( 0, 1 );
        self thread namespace_491fa2b2::function_ebbc302();
        self hud_message::clearlowermessage();
    }
    
    self.ignoreme = 0;
    self.ignoremelee = 0;
    self.laststand = 0;
    self.takedamage = 1;
    self.doa.var_d524abd8 = 0;
    self namespace_41cb996::function_6c4d9896( self.doa.var_ed8fde10 );
    self setplayercollision( 1 );
    self cleardamageindicator();
    self thread function_d690f109();
    
    /#
        if ( isdefined( self.hud_damagefeedback ) )
        {
            self.hud_damagefeedback destroy();
            self.hud_damagefeedback = undefined;
        }
    #/
    
    self function_fae39d88();
    self thread function_e2104e07();
    
    if ( isdefined( level.var_cee39136 ) )
    {
        [[ level.var_cee39136 ]]( var_45b95f80 );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x40fbe473, Offset: 0xf50
// Size: 0x3c
function function_d690f109()
{
    self endon( #"disconnect" );
    waitframe( 1 );
    self clientfield::increment_to_player( "controlBinding" );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x3ef03767, Offset: 0xf98
// Size: 0x60
function function_e2104e07()
{
    self endon( #"disconnect" );
    self notify( "7f39cc75d9f9384d" );
    self endon( "7f39cc75d9f9384d" );
    
    while ( true )
    {
        wait 0.25;
        self function_8fef418b();
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xa8fd6571, Offset: 0x1000
// Size: 0x332
function function_8fef418b()
{
    if ( !isdefined( self.last_valid_position ) )
    {
        self.last_valid_position = getclosestpointonnavmesh( self.origin, 2048, 0 );
    }
    
    if ( !isdefined( self.last_valid_position ) )
    {
        return;
    }
    
    playerradius = self getpathfindingradius();
    
    if ( ispointonnavmesh( self.last_valid_position ) && distance2dsquared( self.origin, self.last_valid_position ) < sqr( playerradius ) && sqr( self.origin[ 2 ] - self.last_valid_position[ 2 ] ) < sqr( 16 ) )
    {
        return;
    }
    
    if ( self isplayerswimming() )
    {
        if ( isdefined( self.var_5d991645 ) )
        {
            if ( distancesquared( self.origin, self.var_5d991645 ) < sqr( playerradius ) )
            {
                return;
            }
        }
        
        ground_pos = groundtrace( self.origin + ( 0, 0, 8 ), self.origin + ( 0, 0, -100000 ), 0, self )[ #"position" ];
        
        if ( !isdefined( ground_pos ) )
        {
            return;
        }
        
        position = getclosestpointonnavmesh( ground_pos, 100, playerradius );
        
        if ( isdefined( position ) )
        {
            self.last_valid_position = position;
            self.var_5d991645 = self.origin;
        }
        
        return;
    }
    
    if ( ispointonnavmesh( self.origin, self ) )
    {
        self.last_valid_position = self.origin;
        return;
    }
    
    if ( !ispointonnavmesh( self.origin, self ) && ispointonnavmesh( self.last_valid_position, self ) && distance2dsquared( self.origin, self.last_valid_position ) < sqr( 32 ) && sqr( self.origin[ 2 ] - self.last_valid_position[ 2 ] ) < sqr( 32 ) )
    {
        return;
    }
    
    position = getclosestpointonnavmesh( self.origin, 100, playerradius );
    
    if ( isdefined( position ) )
    {
        self.last_valid_position = position;
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x865339da, Offset: 0x1340
// Size: 0x174
function function_fae39d88()
{
    if ( !is_true( level.var_fdf900b7 ) )
    {
        self disableweaponcycling();
    }
    
    self allowjump( is_true( self.doa.infps ) );
    self allowcrouch( 0 );
    self allowprone( 0 );
    self allowslide( 0 );
    self allowdoublejump( 0 );
    self allowwallrun( 0 );
    self allowsprint( is_true( self.doa.infps ) );
    self allowads( is_true( self.doa.infps ) );
    self setstance( "stand" );
    self function_205350ab();
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0x371c36de, Offset: 0x14c0
// Size: 0x1c2
function getplayercolor( player )
{
    i = 0;
    
    if ( is_true( level.var_29628b5f ) )
    {
        if ( self.team == #"allies" )
        {
            return "blue";
        }
        else if ( self.team == #"axis" )
        {
            return "red";
        }
        else if ( self.team == #"team3" )
        {
            return "green";
        }
        else if ( self.team == #"team4" )
        {
            return "yellow";
        }
        else
        {
            return "yellow";
        }
    }
    else
    {
        i = player.entnum;
    }
    
    if ( is_true( level.var_4ed7ab1b ) )
    {
        i %= 4;
    }
    
    switch ( i )
    {
        case 0:
            return "green";
        case 1:
            return "blue";
        case 2:
            return "red";
        case 3:
            return "yellow";
        default:
            assert( 0, "<dev string:x38>" );
            break;
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0x82fac4c0, Offset: 0x1690
// Size: 0x102
function function_7781556b( origin, var_396c606d = 0 )
{
    valid_player_found = 0;
    players = getplayers();
    
    if ( players.size > 1 )
    {
        players = arraysortclosest( players, origin );
    }
    
    foreach ( player in players )
    {
        if ( isplayervalid( player, var_396c606d ) )
        {
            return player;
        }
    }
    
    return undefined;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0xe3d74028, Offset: 0x17a0
// Size: 0xb0, Type: bool
function isplayervalid( player, var_396c606d = 0 )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( var_396c606d && is_true( player.ignoreme ) )
    {
        return false;
    }
    
    if ( player.sessionstate == "spectator" )
    {
        return false;
    }
    
    if ( player.sessionstate == "intermission" )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0x1360eb26, Offset: 0x1858
// Size: 0xb2, Type: bool
function function_2e8dc9d3( volume )
{
    players = function_23e1f90f();
    
    foreach ( player in players )
    {
        if ( !player istouching( volume ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xd2353439, Offset: 0x1918
// Size: 0xb4
function function_23e1f90f()
{
    players = [];
    
    foreach ( player in getplayers() )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.doa ) )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xb14fe76e, Offset: 0x19d8
// Size: 0xd4
function function_518c4c78()
{
    players = [];
    
    foreach ( player in getplayers() )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( is_true( player.laststand ) )
        {
            continue;
        }
        
        if ( isdefined( player.doa ) )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x165a1335, Offset: 0x1ab8
// Size: 0x24
function function_f08b75c1()
{
    players = function_23e1f90f();
    return players.size;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 3
// Checksum 0xffbce3d0, Offset: 0x1ae8
// Size: 0x72
function function_519ae1ed( origin, &entarray, maxdist = 2048 )
{
    if ( !isdefined( entarray ) )
    {
        return;
    }
    
    if ( entarray.size == 0 )
    {
        return;
    }
    
    if ( entarray.size == 1 )
    {
        return entarray[ 0 ];
    }
    
    return arraygetclosest( origin, entarray, maxdist );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xad774115, Offset: 0x1b68
// Size: 0xb8
function function_19616199()
{
    self endon( #"disconnect" );
    level endon( #"game_over" );
    self notify( "11c2206e28d46cba" );
    self endon( "11c2206e28d46cba" );
    
    while ( is_true( level.doa.var_2e491399 ) )
    {
        waitframe( 1 );
        
        if ( is_true( self.doa.var_221ef439 ) )
        {
            namespace_1e25ad94::function_e8f2d12c( self.origin, 60, 72, 1, ( 1, 0, 0 ) );
        }
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0x84e9a00b, Offset: 0x1c28
// Size: 0x30c
function function_77785447( on, clear = 0 )
{
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    namespace_1e25ad94::debugmsg( "Player(" + self.doa.color + ") playerInvulnerability active: " + ( on ? "true" : "false" ) + "  clear: " + ( clear ? "true" : "false" ) );
    
    if ( clear && !isdefined( self.doa.var_8b493af7 ) )
    {
        self.doa.var_221ef439 = undefined;
        self disableinvulnerability();
        self.takedamage = 1;
    }
    
    if ( getdvarint( #"hash_56a6b1d074ad2f5d", 0 ) )
    {
        self thread function_19616199();
    }
    
    if ( on )
    {
        if ( !isdefined( self.doa.var_221ef439 ) )
        {
            self.doa.var_221ef439 = 1;
            self enableinvulnerability();
            self.takedamage = 0;
        }
        else
        {
            assert( self.doa.var_221ef439 > 0 );
            self.doa.var_221ef439++;
            self enableinvulnerability();
            self.takedamage = 0;
        }
    }
    else
    {
        if ( isdefined( self.doa.var_221ef439 ) )
        {
            self.doa.var_221ef439--;
        }
        
        if ( !isdefined( self.doa.var_221ef439 ) || self.doa.var_221ef439 == 0 )
        {
            self.doa.var_221ef439 = undefined;
            self disableinvulnerability();
            self.takedamage = 1;
            assert( !isdefined( self.doa.var_8b493af7 ), "<dev string:x5a>" );
        }
    }
    
    namespace_1e25ad94::debugmsg( "Player(" + self.doa.color + ") invulRefCount: " + ( isdefined( self.doa.var_221ef439 ) ? self.doa.var_221ef439 : "undefined" ) );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0, eflags: 0x4
// Checksum 0xed975068, Offset: 0x1f40
// Size: 0x5e
function private function_d2b9d1f2()
{
    self endon( #"death" );
    level endon( #"game_over" );
    
    while ( true )
    {
        namespace_1e25ad94::function_e8f2d12c( self.origin, 85, 60 );
        waitframe( 1 );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0xf3172b5d, Offset: 0x1fa8
// Size: 0x184
function function_b50050f5( trigger )
{
    self endon( #"disconnect" );
    trigger thread namespace_ec06fe4a::function_ae010bb4( self );
    trigger thread namespace_ec06fe4a::function_d55f042c( self, "enter_vehicle" );
    trigger thread namespace_ec06fe4a::function_d55f042c( self, "turnPlayerShieldOn" );
    trigger thread namespace_ec06fe4a::function_d55f042c( self, "turnPlayerShieldOff" );
    trigger thread namespace_ec06fe4a::function_d55f042c( self, "doa_respawn_player" );
    trigger thread namespace_ec06fe4a::function_d55f042c( level, "game_reset" );
    trigger thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
    trigger waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self.doa.var_8b493af7 = undefined;
        self function_77785447( 0 );
        self thread namespace_83eb6304::turnofffx( "player_shield_short" );
        self thread namespace_83eb6304::turnofffx( "player_shield_long" );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0x348331e0, Offset: 0x2138
// Size: 0x2fe
function turnplayershieldon( var_b5c21d1f = 1 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"enter_vehicle" );
    self notify( #"turnplayershieldon" );
    self endon( #"turnplayershieldon" );
    
    if ( !isdefined( self.doa ) || isdefined( self.doa.vehicle ) )
    {
        return;
    }
    
    self function_77785447( 1 );
    
    if ( isdefined( self.doa.var_8b493af7 ) )
    {
        self notify( #"turnPlayerShieldOff" );
        waittillframeend();
    }
    else
    {
        if ( !is_true( self.doa.var_c026f7c9 ) )
        {
            self namespace_e32bb68::function_3a59ec34( "evt_doa_player_shield_start" );
        }
        
        if ( !var_b5c21d1f )
        {
            self namespace_e32bb68::function_3a59ec34( "evt_doa_player_shield_full" );
        }
    }
    
    trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", self.origin, 1 | 512 | 8 | 16, 60, 72 );
    
    if ( isdefined( trigger ) )
    {
        trigger.targetname = "turnPlayerShieldOn";
        self.doa.var_8b493af7 = trigger;
        trigger enablelinkto();
        trigger linkto( self );
        trigger thread function_19f387a( self );
        self thread function_b50050f5( trigger );
        trigger thread namespace_ec06fe4a::function_52afe5df( 9.85 );
        util::wait_network_frame();
    }
    
    if ( var_b5c21d1f )
    {
        self thread namespace_83eb6304::function_3ecfde67( "player_shield_short" );
    }
    else
    {
        self thread namespace_83eb6304::function_3ecfde67( "player_shield_long" );
        wait 6;
    }
    
    self namespace_e32bb68::function_3a59ec34( "evt_doa_player_shield_half" );
    wait 3;
    self namespace_e32bb68::function_3a59ec34( "evt_doa_player_shield_stop" );
    wait 0.5;
    self notify( #"turnPlayerShieldOff" );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 3
// Checksum 0x9d032403, Offset: 0x2440
// Size: 0x454
function function_19f387a( player, var_ca85cba1, thresh )
{
    self endon( #"death" );
    self thread function_e93fae6f( player );
    self.player = player;
    
    while ( isdefined( player ) )
    {
        waitresult = self waittill( #"trigger" );
        guy = waitresult.activator;
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( isplayer( guy ) )
        {
            continue;
        }
        
        if ( isdefined( guy.launched ) )
        {
            continue;
        }
        
        if ( !issentient( guy ) )
        {
            continue;
        }
        
        if ( !is_true( guy.takedamage ) )
        {
            continue;
        }
        
        if ( is_true( guy.boss ) )
        {
            continue;
        }
        
        if ( guy.team == player.team )
        {
            continue;
        }
        
        ok = 1;
        
        if ( isdefined( var_ca85cba1 ) )
        {
            v_velocity = var_ca85cba1 getvelocity();
            speed = lengthsquared( v_velocity );
            
            /#
            #/
            
            ok = speed < sqr( thresh );
        }
        
        if ( !ok )
        {
            continue;
        }
        
        guy setplayercollision( 0 );
        
        if ( !isvehicle( guy ) )
        {
            if ( !is_true( guy.var_e66cd6fb ) )
            {
                guy.launched = 1;
                
                if ( randomint( 100 ) < 85 )
                {
                    velocity = namespace_ec06fe4a::function_9d713536( player getvelocity() );
                    
                    if ( velocity > 30 && !is_true( guy.no_gib ) )
                    {
                        guy thread namespace_83eb6304::function_3ecfde67( "boost_explode" );
                        namespace_ed80aead::trygibbinglimb( guy, 5000 );
                        namespace_ed80aead::trygibbinglegs( guy, 5000, undefined, 1, player );
                    }
                    
                    assert( !is_true( guy.boss ) );
                    guy thread namespace_ec06fe4a::function_5678f0d( ( 0, 0, 220 ), 180, 0.3 );
                    guy thread namespace_ec06fe4a::function_570729f0( 0.2, player );
                    guy namespace_e32bb68::function_3a59ec34( "zmb_ragdoll_launched" );
                }
                else
                {
                    guy dodamage( guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE" );
                }
            }
            else
            {
                guy dodamage( guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE" );
            }
            
            continue;
        }
        
        guy thread namespace_ec06fe4a::function_570729f0( 0, player );
    }
    
    self delete();
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1, eflags: 0x4
// Checksum 0x75e14532, Offset: 0x28a0
// Size: 0x124
function private function_e93fae6f( *player )
{
    self endon( #"death" );
    
    if ( !isdefined( level.doa ) || !isdefined( level.doa.var_f9c9c0 ) )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( hazard in level.doa.var_f9c9c0 )
        {
            if ( isdefined( hazard ) && self istouching( hazard ) && isdefined( hazard.death_func ) )
            {
                hazard thread [[ hazard.death_func ]]();
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0x6eb028f5, Offset: 0x29d0
// Size: 0x100
function function_a8b57c52( var_2784b779, angles )
{
    players = function_23e1f90f();
    offset = ( 20, -20, 0 );
    
    foreach ( player in players )
    {
        player setorigin( var_2784b779 );
        player setplayerangles( angles );
        var_2784b779 += offset;
        offset *= -1;
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xd8e4af7c, Offset: 0x2ad8
// Size: 0x45e
function function_c0310e2a()
{
    /#
        if ( !getdvarint( #"hash_2364dfae0e289844", 0 ) )
        {
            return;
        }
        
        while ( true )
        {
            if ( self stancebuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x86>" );
            }
            
            if ( self fragbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:xa7>" );
            }
            
            if ( self reloadbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:xc6>" );
            }
            
            if ( self secondaryoffhandbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:xe7>" );
            }
            
            if ( self inventorybuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x112>" );
            }
            
            if ( self offhandspecialbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x136>" );
            }
            
            if ( self weaponswitchbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x15f>" );
            }
            
            if ( self vehiclemoveupbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x186>" );
            }
            
            if ( self actionbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x1ae>" );
            }
            
            if ( self jumpbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x1cf>" );
            }
            
            if ( self sprintbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x1ee>" );
            }
            
            if ( self meleebuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x20f>" );
            }
            
            if ( self throwbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x22f>" );
            }
            
            if ( self adsbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x24f>" );
            }
            
            if ( self actionslotfourbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x26d>" );
            }
            
            if ( self actionslotthreebuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x296>" );
            }
            
            if ( self actionslottwobuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x2c0>" );
            }
            
            if ( self actionslotonebuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x2e8>" );
            }
            
            if ( self attackbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x310>" );
            }
            
            if ( self boostbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x331>" );
            }
            
            if ( self changeseatbuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x351>" );
            }
            
            if ( self usebuttonpressed() )
            {
                namespace_1e25ad94::debugmsg( "<dev string:x376>" );
            }
            
            waitframe( 1 );
        }
    #/
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x4538c3b2, Offset: 0x2f40
// Size: 0x15e
function function_5ed5daa7()
{
    assert( isdefined( self.doa ) );
    
    if ( self namespace_1c2a96f9::function_d17f9bcb() )
    {
        self.doa.score.boosts = int( max( self.doa.score.boosts, 2 ) );
    }
    else
    {
        self.doa.score.boosts = int( max( self.doa.score.boosts, 1 ) );
    }
    
    self.doa.score.bombs = int( max( self.doa.score.bombs, 1 ) );
    self.health = self.maxhealth;
    self.ignoreme = 0;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0x7c47c854, Offset: 0x30a8
// Size: 0x1c0
function function_d0251f76( var_8987df35 = 1 )
{
    players = function_23e1f90f();
    
    foreach ( player in players )
    {
        if ( !isalive( player ) || is_true( player.doa.respawning ) )
        {
            player function_513831e1();
        }
        
        if ( is_true( var_8987df35 ) )
        {
            player function_5ed5daa7();
        }
        
        player namespace_83eb6304::turnofffx( "lantern_fade" );
        player namespace_83eb6304::turnofffx( "lantern" );
        player.doa.var_deaabc77 = 0;
        player.doa.var_f583234e = 0;
        player clientfield::set_to_player( "toggleflashlight", player.doa.var_f583234e );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0x572ba8b3, Offset: 0x3270
// Size: 0x324
function function_513831e1( var_c4b5b87c = 0, spot = undefined )
{
    self endon( #"disconnect" );
    level endon( #"game_over" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( isdefined( self.doa ) );
    namespace_1e25ad94::debugmsg( "player respawning now" );
    self.doa.respawning = 0;
    self namespace_ec06fe4a::function_4f72130c();
    self notify( #"doa_respawn_player" );
    self undolaststand();
    self clientfield::set_to_player( "lastStand", 0 );
    self.doa.var_fd5fcb75 = "";
    self laststand_enable_player_weapons();
    self reviveplayer();
    self.health = 150;
    
    if ( !isdefined( spot ) )
    {
        spot = self.origin;
    }
    
    if ( isdefined( self.revivetrigger ) )
    {
        self.revivetrigger delete();
    }
    
    self setorigin( spot );
    
    if ( mayspawnentity() )
    {
        self playsound( "zmb_player_respawn" );
    }
    
    self thread namespace_83eb6304::function_3ecfde67( "player_respawn_" + self.doa.color );
    assert( !isdefined( self.doa.var_8b493af7 ) );
    self function_77785447( 0, 1 );
    
    if ( !var_c4b5b87c )
    {
        self thread turnplayershieldon( 0 );
        waitframe( 1 );
    }
    
    self thread function_fcc90081( var_c4b5b87c );
    self setplayercollision( 1 );
    self freezecontrols( 0 );
    self.dead = undefined;
    self notify( #"player_respawned" );
    
    if ( !var_c4b5b87c && self.doa.score.lives )
    {
        self.doa.score.lives--;
    }
    
    namespace_1e25ad94::debugmsg( "player respawn done" );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xadbb9386, Offset: 0x35a0
// Size: 0xe8
function function_ebcb2cca()
{
    self notify( "4f283bc448eafd41" );
    self endon( "4f283bc448eafd41" );
    self endon( #"hash_79990404aaa9d9df" );
    level endon( #"game_over" );
    
    while ( isdefined( self ) )
    {
        if ( level.doa.world_state != 4 )
        {
            if ( self.health < self.maxhealth && !is_true( self.doa.respawning ) )
            {
                self.health += 1;
                
                if ( self.health > self.maxhealth )
                {
                    self.health = self.maxhealth;
                }
            }
        }
        
        wait 2;
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xeb67cab, Offset: 0x3690
// Size: 0x92
function function_5934bbc8()
{
    switch ( self.doa.color )
    {
        case #"green":
            return ( 0, 1, 0 );
        case #"blue":
            return ( 0, 0, 1 );
        case #"red":
            return ( 1, 0, 0 );
        case #"yellow":
            return ( 1, 1, 0 );
        default:
            return ( 1, 1, 1 );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0xa82cd68, Offset: 0x3730
// Size: 0x146
function function_67f054d7( duration )
{
    if ( is_true( level.var_b62ca8c ) )
    {
        return;
    }
    
    self notify( "3790fa90147c1f8f" );
    self endon( "3790fa90147c1f8f" );
    level notify( #"hash_7893364bd228d63e" );
    players = getplayers();
    
    foreach ( player in players )
    {
        player freezecontrols( 1 );
        player thread lui::screen_fade_out( duration );
    }
    
    wait duration;
    util::wait_network_frame();
    self notify( #"hash_1b322de3d2e3e781" );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xfccfb508, Offset: 0x3880
// Size: 0xc8
function function_ec758d18()
{
    players = getplayers();
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.birthtime == gettime() )
        {
            waitframe( 1 );
        }
        
        player clientfield::increment_to_player( "controlBinding" );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0x7703ffa6, Offset: 0x3950
// Size: 0x126
function function_836aeb74( duration )
{
    if ( is_true( level.var_b62ca8c ) )
    {
        return;
    }
    
    self notify( "22022c1582901a8c" );
    self endon( "22022c1582901a8c" );
    level notify( #"hash_7893364bd228d63e" );
    players = getplayers();
    
    foreach ( player in players )
    {
        player freezecontrols( 0 );
        player thread lui::function_a6eb5334( duration );
    }
    
    wait duration;
    self notify( #"hash_58caf0ade03043bb" );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1, eflags: 0x4
// Checksum 0x36140656, Offset: 0x3a80
// Size: 0x164
function private function_f83ea3c( var_832465bf = 0 )
{
    self notify( "7c3059a644d43ba6" );
    self endon( "7c3059a644d43ba6" );
    self endon( #"disconnect" );
    self waittill( #"speed_change", #"entering_last_stand", #"speed_expired" );
    
    if ( !var_832465bf )
    {
        self.doa.fast_feet = undefined;
        self thread namespace_83eb6304::turnofffx( "boots" );
        self namespace_e32bb68::function_ae271c0b( "evt_doa_pickup_boots_active_lp" );
    }
    else
    {
        self.doa.var_51a3bdbd = undefined;
        self thread namespace_83eb6304::turnofffx( "nova_crawler_aura_fx" );
        self namespace_e32bb68::function_ae271c0b( "zmb_pwup_slowspeed_loop" );
        self namespace_e32bb68::function_3a59ec34( "zmb_pwup_slowspeed_end" );
    }
    
    self setmovespeedscale( self.doa.var_e5805edb );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0x8c38e547, Offset: 0x3bf0
// Size: 0x146
function function_ec9a307f( time = 5, rate = 0.7 )
{
    self endon( #"disconnect" );
    self notify( "3ec2f6a9f16d03c5" );
    self endon( "3ec2f6a9f16d03c5" );
    waitframe( 1 );
    
    if ( !is_true( self.doa.var_51a3bdbd ) )
    {
        self notify( #"speed_change" );
        self thread function_f83ea3c( 1 );
        self namespace_e32bb68::function_3a59ec34( "zmb_pwup_slowspeed_loop" );
        self namespace_83eb6304::function_3ecfde67( "nova_crawler_aura_fx" );
    }
    
    self setmovespeedscale( rate );
    self.doa.fast_feet = undefined;
    self.doa.var_51a3bdbd = 1;
    wait time;
    self notify( #"speed_expired" );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0xf501bc97, Offset: 0x3d40
// Size: 0x146
function function_a99cfd4f( time = 25, rate = 1.5 )
{
    self endon( #"disconnect" );
    self notify( "3ca30954de66503c" );
    self endon( "3ca30954de66503c" );
    waitframe( 1 );
    
    if ( !is_true( self.doa.fast_feet ) )
    {
        self notify( #"speed_change" );
        self thread function_f83ea3c();
        self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_boots_active_lp" );
        self thread namespace_83eb6304::function_3ecfde67( "boots" );
    }
    
    self setmovespeedscale( rate );
    self.doa.fast_feet = 1;
    self.doa.var_51a3bdbd = undefined;
    wait time;
    self notify( #"speed_expired" );
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x5f54bf3a, Offset: 0x3e90
// Size: 0x94
function laststand_disable_player_weapons()
{
    self giveweapon( level.laststandweapon );
    self givemaxammo( level.laststandweapon );
    self switchtoweaponimmediate( level.laststandweapon, 1 );
    self disableweaponcycling();
    self disableoffhandweapons();
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0x81023973, Offset: 0x3f30
// Size: 0xa4
function laststand_enable_player_weapons()
{
    self endon( #"disconnect" );
    self takeweapon( level.laststandweapon );
    self enableweaponcycling();
    self enableoffhandweapons();
    self enableusability();
    self namespace_41cb996::function_6c4d9896( self.doa.var_ed8fde10 );
}

/#

    // Namespace namespace_7f5aeb59/namespace_7f5aeb59
    // Params 1
    // Checksum 0x836b7a2c, Offset: 0x3fe0
    // Size: 0x1c4, Type: dev
    function function_884143e( attacker )
    {
        if ( isdefined( attacker ) )
        {
            level thread namespace_1e25ad94::debugcircle( attacker.origin + ( 0, 0, 12 ), 40, 10, ( 1, 0, 0 ) );
            level thread namespace_1e25ad94::debugline( self.origin + ( 0, 0, 12 ), attacker.origin + ( 0, 0, 12 ), 10, ( 1, 0, 0 ) );
            attacker thread namespace_1e25ad94::debugorigin( 10, 24, ( 1, 0, 0 ) );
            
            if ( isdefined( attacker.zombie_type ) )
            {
                text = attacker.zombie_type;
            }
            else if ( isdefined( attacker.var_fd5301f9 ) )
            {
                text = attacker.var_fd5301f9;
            }
            else if ( isdefined( attacker.model ) )
            {
                text = function_9e72a96( attacker.model );
            }
            else if ( isdefined( attacker.targetname ) )
            {
                text = function_9e72a96( attacker.targetname );
            }
            else if ( isdefined( attacker.classname ) )
            {
                text = function_9e72a96( attacker.classname );
            }
            else
            {
                text = "<dev string:x394>";
            }
            
            level thread namespace_1e25ad94::function_75ebaff2( text, 10, attacker );
        }
    }

#/

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0xc4b1f1b, Offset: 0x41b0
// Size: 0x100
function function_52392bd1( long = 0 )
{
    self endon( #"disconnect" );
    level endon( #"game_over" );
    
    if ( !long )
    {
        self thread namespace_6e90e490::function_47e11416( 2, undefined, 1 );
        return;
    }
    
    while ( is_true( self.laststand ) )
    {
        wait randomint( 15 );
        
        if ( level flag::get( "doa_round_paused" ) )
        {
            continue;
        }
        
        if ( is_true( self.laststand ) )
        {
            self thread namespace_6e90e490::function_47e11416( 3 );
        }
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 2
// Checksum 0xc8337977, Offset: 0x42b8
// Size: 0x35c
function function_12bdee53( clone, player )
{
    if ( isplayer( player ) && isai( clone ) )
    {
        if ( player function_390cb543() )
        {
            var_1749f1e8 = player function_92ea4100();
            
            if ( isdefined( var_1749f1e8 ) )
            {
                clone setmodel( var_1749f1e8 );
            }
            
            headmodel = player startquantity();
            
            if ( isdefined( headmodel ) )
            {
                if ( isdefined( clone.head ) )
                {
                    clone detach( clone.head );
                }
                
                clone attach( headmodel );
            }
            
            if ( isdefined( clone.legs ) )
            {
                clone detach( clone.legs );
            }
            
            if ( isdefined( clone.torso ) )
            {
                clone detach( clone.torso );
            }
        }
        else
        {
            var_41206ae3 = player function_5d23af5b();
            
            if ( isdefined( var_41206ae3 ) )
            {
                clone setmodel( var_41206ae3 );
            }
            
            headmodel = player startquantity();
            
            if ( isdefined( headmodel ) && headmodel != #"tag_origin" )
            {
                if ( isdefined( clone.head ) )
                {
                    clone detach( clone.head );
                }
                
                clone attach( headmodel );
            }
            
            var_b4d88433 = player function_cde23658();
            
            if ( isdefined( var_b4d88433 ) && var_b4d88433 != #"tag_origin" )
            {
                if ( isdefined( clone.legs ) )
                {
                    clone detach( clone.legs );
                }
                
                clone attach( var_b4d88433 );
            }
            
            var_1749f1e8 = player function_92ea4100();
            
            if ( isdefined( var_1749f1e8 ) && var_1749f1e8 != #"tag_origin" )
            {
                if ( isdefined( clone.torso ) )
                {
                    clone detach( clone.torso );
                }
                
                clone attach( var_1749f1e8 );
            }
        }
        
        clone function_1fac41e4( player function_19124308() );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1
// Checksum 0xfc62d3f5, Offset: 0x4620
// Size: 0x94
function function_31df67c1( player )
{
    clone = self;
    playerweapon = player getcurrentweapon();
    
    if ( isdefined( playerweapon.worldmodel ) )
    {
        weapon = playerweapon;
    }
    else
    {
        weapon = _chooseweapon( player );
    }
    
    if ( isdefined( weapon ) )
    {
        clone shared::placeweaponon( weapon, "right" );
    }
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 1, eflags: 0x4
// Checksum 0xedc26f5c, Offset: 0x46c0
// Size: 0xa0
function private _chooseweapon( player )
{
    classnum = randomint( 10 );
    
    for ( i = 0; i < 10 ; i++ )
    {
        weapon = player getloadoutweapon( ( i + classnum ) % 10, "primary" );
        
        if ( weapon != level.weaponnone )
        {
            break;
        }
    }
    
    return weapon;
}

// Namespace namespace_7f5aeb59/namespace_7f5aeb59
// Params 0
// Checksum 0xd664e653, Offset: 0x4768
// Size: 0x1ac
function function_bfdc540a()
{
    self notify( "2c8d5f292d835ce5" );
    self endon( "2c8d5f292d835ce5" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.doa.var_dac166c ) )
    {
        self.doa.var_dac166c = 0;
    }
    
    while ( true )
    {
        time = gettime();
        
        if ( time > self.doa.var_dac166c || !isdefined( self.doa.predicted_pos ) || distancesquared( self.origin, self.doa.predicted_pos ) > 16 )
        {
            self.doa.var_dac166c = time + 500;
            velocity = self getvelocity();
            self.doa.predicted_pos = self.origin + velocity * 0.3;
            self.doa.closestpointonnavmesh = undefined;
        }
        
        if ( !isdefined( self.doa.closestpointonnavmesh ) )
        {
            spot = getclosestpointonnavmesh( self.doa.predicted_pos, 25, 18 );
            
            if ( isdefined( spot ) )
            {
                self.doa.closestpointonnavmesh = spot;
            }
        }
        
        waitframe( 1 );
    }
}

