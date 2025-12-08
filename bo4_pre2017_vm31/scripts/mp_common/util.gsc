#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/util_shared;

#namespace util;

/#

    // Namespace util/util
    // Params 1
    // Checksum 0xabc7869c, Offset: 0x3b8
    // Size: 0x74, Type: dev
    function error( msg )
    {
        println( "^c*ERROR* ", msg );
        waitframe( 1 );
        
        if ( getdvarstring( "debug" ) != "1" )
        {
            assertmsg( "This is a forced error - attach the log file" );
        }
    }

    // Namespace util/util
    // Params 1
    // Checksum 0x87c983c0, Offset: 0x438
    // Size: 0x34, Type: dev
    function warning( msg )
    {
        println( "^1WARNING: " + msg );
    }

#/

// Namespace util/util
// Params 4
// Checksum 0xb7ae3c64, Offset: 0x478
// Size: 0xa2, Type: bool
function within_fov( start_origin, start_angles, end_origin, fov )
{
    normal = vectornormalize( end_origin - start_origin );
    forward = anglestoforward( start_angles );
    dot = vectordot( forward, normal );
    return dot >= fov;
}

// Namespace util/util
// Params 0
// Checksum 0x4f883419, Offset: 0x528
// Size: 0xa
function get_player_height()
{
    return 70;
}

// Namespace util/util
// Params 1
// Checksum 0xa0b5ee28, Offset: 0x540
// Size: 0x3c, Type: bool
function isbulletimpactmod( smeansofdeath )
{
    return issubstr( smeansofdeath, "BULLET" ) || smeansofdeath == "MOD_HEAD_SHOT";
}

// Namespace util/util
// Params 0
// Checksum 0xbcfe99cb, Offset: 0x588
// Size: 0x46
function waitrespawnbutton()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    
    while ( self usebuttonpressed() != 1 )
    {
        waitframe( 1 );
    }
}

// Namespace util/util
// Params 3
// Checksum 0xdde06558, Offset: 0x5d8
// Size: 0x21c
function setlowermessage( text, time, combinemessageandtimer )
{
    if ( !isdefined( self.lowermessage ) )
    {
        return;
    }
    
    if ( isdefined( self.lowermessageoverride ) && text != &"" )
    {
        text = self.lowermessageoverride;
        time = undefined;
    }
    
    self notify( #"lower_message_set" );
    self.lowermessage settext( text );
    
    if ( isdefined( time ) && time > 0 )
    {
        if ( !isdefined( combinemessageandtimer ) || !combinemessageandtimer )
        {
            self.lowertimer.label = &"";
        }
        else
        {
            self.lowermessage settext( "" );
            self.lowertimer.label = text;
        }
        
        self.lowertimer settimer( time );
    }
    else
    {
        self.lowertimer settext( "" );
        self.lowertimer.label = &"";
    }
    
    if ( self issplitscreen() )
    {
        self.lowermessage.fontscale = 1.4;
    }
    
    self.lowermessage fadeovertime( 0.05 );
    self.lowermessage.alpha = 1;
    self.lowertimer fadeovertime( 0.05 );
    self.lowertimer.alpha = 1;
}

// Namespace util/util
// Params 3
// Checksum 0xfce99127, Offset: 0x800
// Size: 0x23c
function setlowermessagevalue( text, value, combinemessage )
{
    if ( !isdefined( self.lowermessage ) )
    {
        return;
    }
    
    if ( isdefined( self.lowermessageoverride ) && text != &"" )
    {
        text = self.lowermessageoverride;
        time = undefined;
    }
    
    self notify( #"lower_message_set" );
    
    if ( !isdefined( combinemessage ) || !combinemessage )
    {
        self.lowermessage settext( text );
    }
    else
    {
        self.lowermessage settext( "" );
    }
    
    if ( isdefined( value ) && value > 0 )
    {
        if ( !isdefined( combinemessage ) || !combinemessage )
        {
            self.lowertimer.label = &"";
        }
        else
        {
            self.lowertimer.label = text;
        }
        
        self.lowertimer setvalue( value );
    }
    else
    {
        self.lowertimer settext( "" );
        self.lowertimer.label = &"";
    }
    
    if ( self issplitscreen() )
    {
        self.lowermessage.fontscale = 1.4;
    }
    
    self.lowermessage fadeovertime( 0.05 );
    self.lowermessage.alpha = 1;
    self.lowertimer fadeovertime( 0.05 );
    self.lowertimer.alpha = 1;
}

// Namespace util/util
// Params 1
// Checksum 0x91d6e8a8, Offset: 0xa48
// Size: 0xfc
function clearlowermessage( fadetime )
{
    if ( !isdefined( self.lowermessage ) )
    {
        return;
    }
    
    self notify( #"lower_message_set" );
    
    if ( !isdefined( fadetime ) || fadetime == 0 )
    {
        setlowermessage( &"" );
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"lower_message_set" );
    self.lowermessage fadeovertime( fadetime );
    self.lowermessage.alpha = 0;
    self.lowertimer fadeovertime( fadetime );
    self.lowertimer.alpha = 0;
    wait fadetime;
    self setlowermessage( "" );
}

// Namespace util/util
// Params 2
// Checksum 0x476cc83f, Offset: 0xb50
// Size: 0xe6
function printonteam( text, team )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintln( text );
        }
    }
}

// Namespace util/util
// Params 2
// Checksum 0x95a9a859, Offset: 0xc40
// Size: 0xe6
function printboldonteam( text, team )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintlnbold( text );
        }
    }
}

// Namespace util/util
// Params 3
// Checksum 0xd3ebc62a, Offset: 0xd30
// Size: 0xee
function printboldonteamarg( text, team, arg )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintlnbold( text, arg );
        }
    }
}

// Namespace util/util
// Params 3
// Checksum 0x6d989214, Offset: 0xe28
// Size: 0x1c
function printonteamarg( text, team, arg )
{
    
}

// Namespace util/util
// Params 2
// Checksum 0x5d8a0a88, Offset: 0xe50
// Size: 0xf6
function printonplayers( text, team )
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( team ) )
        {
            if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == team )
            {
                players[ i ] iprintln( text );
            }
            
            continue;
        }
        
        players[ i ] iprintln( text );
    }
}

// Namespace util/util
// Params 7
// Checksum 0x7a042e7, Offset: 0xf50
// Size: 0x536
function printandsoundoneveryone( team, enemyteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg )
{
    shoulddosounds = isdefined( soundfriendly );
    shoulddoenemysounds = 0;
    
    if ( isdefined( soundenemy ) )
    {
        assert( shoulddosounds );
        shoulddoenemysounds = 1;
    }
    
    if ( !isdefined( printarg ) )
    {
        printarg = "";
    }
    
    if ( level.splitscreen || !shoulddosounds )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            playerteam = player.pers[ "team" ];
            
            if ( isdefined( playerteam ) )
            {
                if ( playerteam == team && isdefined( printfriendly ) && printfriendly != &"" )
                {
                    player iprintln( printfriendly, printarg );
                    continue;
                }
                
                if ( isdefined( printenemy ) && printenemy != &"" )
                {
                    if ( isdefined( enemyteam ) && playerteam == enemyteam )
                    {
                        player iprintln( printenemy, printarg );
                        continue;
                    }
                    
                    if ( !isdefined( enemyteam ) && playerteam != team )
                    {
                        player iprintln( printenemy, printarg );
                    }
                }
            }
        }
        
        if ( shoulddosounds )
        {
            assert( level.splitscreen );
            level.players[ 0 ] playlocalsound( soundfriendly );
        }
        
        return;
    }
    
    assert( shoulddosounds );
    
    if ( shoulddoenemysounds )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            playerteam = player.pers[ "team" ];
            
            if ( isdefined( playerteam ) )
            {
                if ( playerteam == team )
                {
                    if ( isdefined( printfriendly ) && printfriendly != &"" )
                    {
                        player iprintln( printfriendly, printarg );
                    }
                    
                    player playlocalsound( soundfriendly );
                    continue;
                }
                
                if ( !isdefined( enemyteam ) && ( isdefined( enemyteam ) && playerteam == enemyteam || playerteam != team ) )
                {
                    if ( isdefined( printenemy ) && printenemy != &"" )
                    {
                        player iprintln( printenemy, printarg );
                    }
                    
                    player playlocalsound( soundenemy );
                }
            }
        }
        
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        playerteam = player.pers[ "team" ];
        
        if ( isdefined( playerteam ) )
        {
            if ( playerteam == team )
            {
                if ( isdefined( printfriendly ) && printfriendly != &"" )
                {
                    player iprintln( printfriendly, printarg );
                }
                
                player playlocalsound( soundfriendly );
                continue;
            }
            
            if ( isdefined( printenemy ) && printenemy != &"" )
            {
                if ( isdefined( enemyteam ) && playerteam == enemyteam )
                {
                    player iprintln( printenemy, printarg );
                    continue;
                }
                
                if ( !isdefined( enemyteam ) && playerteam != team )
                {
                    player iprintln( printenemy, printarg );
                }
            }
        }
    }
}

// Namespace util/util
// Params 1
// Checksum 0xea75dd0c, Offset: 0x1490
// Size: 0x4c
function _playlocalsound( soundalias )
{
    if ( level.splitscreen && !self ishost() )
    {
        return;
    }
    
    self playlocalsound( soundalias );
}

// Namespace util/util
// Params 1
// Checksum 0x7a549edc, Offset: 0x14e8
// Size: 0x74
function getotherteam( team )
{
    if ( team == "allies" )
    {
        return "axis";
    }
    else if ( team == "axis" )
    {
        return "allies";
    }
    else
    {
        return "allies";
    }
    
    assertmsg( "getOtherTeam: invalid team " + team );
}

// Namespace util/util
// Params 1
// Checksum 0x1a74464f, Offset: 0x1568
// Size: 0x64
function getteamenum( team )
{
    if ( team == "allies" )
    {
        return 1;
    }
    else if ( team == "axis" )
    {
        return 2;
    }
    
    assertmsg( "getTeamEnum: invalid team " + team );
}

// Namespace util/util
// Params 1
// Checksum 0xcb023b2e, Offset: 0x15d8
// Size: 0x74
function getteammask( team )
{
    if ( !level.teambased || !isdefined( team ) || !isdefined( level.spawnsystem.ispawn_teammask[ team ] ) )
    {
        return level.spawnsystem.ispawn_teammask_free;
    }
    
    return level.spawnsystem.ispawn_teammask[ team ];
}

// Namespace util/util
// Params 1
// Checksum 0x949392dc, Offset: 0x1658
// Size: 0xc4
function getotherteamsmask( skip_team )
{
    mask = 0;
    
    foreach ( team in level.teams )
    {
        if ( team == skip_team )
        {
            continue;
        }
        
        mask |= getteammask( team );
    }
    
    return mask;
}

// Namespace util/util
// Params 5
// Checksum 0x8711c69b, Offset: 0x1728
// Size: 0x7c, Type: bool
function wait_endon( waittime, endonstring, endonstring2, endonstring3, endonstring4 )
{
    self endon( endonstring );
    
    if ( isdefined( endonstring2 ) )
    {
        self endon( endonstring2 );
    }
    
    if ( isdefined( endonstring3 ) )
    {
        self endon( endonstring3 );
    }
    
    if ( isdefined( endonstring4 ) )
    {
        self endon( endonstring4 );
    }
    
    wait waittime;
    return true;
}

/#

    // Namespace util/util
    // Params 5
    // Checksum 0xb42c1176, Offset: 0x17b0
    // Size: 0x10e, Type: dev
    function plot_points( plotpoints, r, g, b, timer )
    {
        lastpoint = plotpoints[ 0 ];
        
        if ( !isdefined( r ) )
        {
            r = 1;
        }
        
        if ( !isdefined( g ) )
        {
            g = 1;
        }
        
        if ( !isdefined( b ) )
        {
            b = 1;
        }
        
        if ( !isdefined( timer ) )
        {
            timer = 0.05;
        }
        
        for ( i = 1; i < plotpoints.size ; i++ )
        {
            line( lastpoint, plotpoints[ i ], ( r, g, b ), 1, timer );
            lastpoint = plotpoints[ i ];
        }
    }

#/

// Namespace util/util
// Params 1
// Checksum 0x776be6c9, Offset: 0x18c8
// Size: 0x5c
function getfx( fx )
{
    assert( isdefined( level._effect[ fx ] ), "Fx " + fx + " is not defined in level._effect." );
    return level._effect[ fx ];
}

// Namespace util/util
// Params 3
// Checksum 0x727ba0cf, Offset: 0x1930
// Size: 0x92
function set_dvar_if_unset( dvar, value, reset )
{
    if ( !isdefined( reset ) )
    {
        reset = 0;
    }
    
    if ( reset || getdvarstring( dvar ) == "" )
    {
        setdvar( dvar, value );
        return value;
    }
    
    return getdvarstring( dvar );
}

// Namespace util/util
// Params 3
// Checksum 0x60084be2, Offset: 0x19d0
// Size: 0x8a
function set_dvar_float_if_unset( dvar, value, reset )
{
    if ( !isdefined( reset ) )
    {
        reset = 0;
    }
    
    if ( reset || getdvarstring( dvar ) == "" )
    {
        setdvar( dvar, value );
    }
    
    return getdvarfloat( dvar );
}

// Namespace util/util
// Params 3
// Checksum 0xdcbbf84c, Offset: 0x1a68
// Size: 0xa2
function set_dvar_int_if_unset( dvar, value, reset )
{
    if ( !isdefined( reset ) )
    {
        reset = 0;
    }
    
    if ( reset || getdvarstring( dvar ) == "" )
    {
        setdvar( dvar, value );
        return int( value );
    }
    
    return getdvarint( dvar );
}

// Namespace util/util
// Params 1
// Checksum 0xdcaf2ec8, Offset: 0x1b18
// Size: 0x5a
function add_trigger_to_ent( ent )
{
    if ( !isdefined( ent._triggers ) )
    {
        ent._triggers = [];
    }
    
    ent._triggers[ self getentitynumber() ] = 1;
}

// Namespace util/util
// Params 1
// Checksum 0xb25a77ca, Offset: 0x1b80
// Size: 0x7a
function remove_trigger_from_ent( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( !isdefined( ent._triggers ) )
    {
        return;
    }
    
    if ( !isdefined( ent._triggers[ self getentitynumber() ] ) )
    {
        return;
    }
    
    ent._triggers[ self getentitynumber() ] = 0;
}

// Namespace util/util
// Params 1
// Checksum 0x94e82a55, Offset: 0x1c08
// Size: 0x70, Type: bool
function ent_already_in_trigger( trig )
{
    if ( !isdefined( self._triggers ) )
    {
        return false;
    }
    
    if ( !isdefined( self._triggers[ trig getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( !self._triggers[ trig getentitynumber() ] )
    {
        return false;
    }
    
    return true;
}

// Namespace util/util
// Params 2
// Checksum 0x66e0cfc, Offset: 0x1c80
// Size: 0x44
function trigger_thread_death_monitor( ent, ender )
{
    ent waittill( "death" );
    self endon( ender );
    self remove_trigger_from_ent( ent );
}

// Namespace util/util
// Params 3
// Checksum 0x562824e9, Offset: 0x1cd0
// Size: 0x19e
function trigger_thread( ent, on_enter_payload, on_exit_payload )
{
    ent endon( #"death" );
    
    if ( ent ent_already_in_trigger( self ) )
    {
        return;
    }
    
    self add_trigger_to_ent( ent );
    ender = "end_trig_death_monitor" + self getentitynumber() + " " + ent getentitynumber();
    self thread trigger_thread_death_monitor( ent, ender );
    endon_condition = "leave_trigger_" + self getentitynumber();
    
    if ( isdefined( on_enter_payload ) )
    {
        self thread [[ on_enter_payload ]]( ent, endon_condition );
    }
    
    while ( isdefined( ent ) && ent istouching( self ) )
    {
        wait 0.01;
    }
    
    ent notify( endon_condition );
    
    if ( isdefined( ent ) && isdefined( on_exit_payload ) )
    {
        self thread [[ on_exit_payload ]]( ent );
    }
    
    if ( isdefined( ent ) )
    {
        self remove_trigger_from_ent( ent );
    }
    
    self notify( ender );
}

// Namespace util/util
// Params 2
// Checksum 0x3f82607, Offset: 0x1e78
// Size: 0x38, Type: bool
function isstrstart( string1, substr )
{
    return getsubstr( string1, 0, substr.size ) == substr;
}

// Namespace util/util
// Params 0
// Checksum 0x9e8ae541, Offset: 0x1eb8
// Size: 0x1e, Type: bool
function iskillstreaksenabled()
{
    return isdefined( level.killstreaksenabled ) && level.killstreaksenabled;
}

// Namespace util/util
// Params 2
// Checksum 0x21011348, Offset: 0x1ee0
// Size: 0xe2
function setusingremote( remotename, set_killstreak_delay_killcam )
{
    if ( !isdefined( set_killstreak_delay_killcam ) )
    {
        set_killstreak_delay_killcam = 1;
    }
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
    
    assert( !self isusingremote() );
    self.usingremote = remotename;
    
    if ( set_killstreak_delay_killcam )
    {
        self.killstreak_delay_killcam = remotename;
    }
    
    self disableoffhandweapons();
    self clientfield::set_player_uimodel( "hudItems.remoteKillstreakActivated", 1 );
    self notify( #"using_remote" );
}

// Namespace util/util
// Params 2
// Checksum 0x7f8e226b, Offset: 0x1fd0
// Size: 0x32
function setobjectivetext( team, text )
{
    game.strings[ "objective_" + team ] = text;
}

// Namespace util/util
// Params 2
// Checksum 0xcad8f5be, Offset: 0x2010
// Size: 0x32
function setobjectivescoretext( team, text )
{
    game.strings[ "objective_score_" + team ] = text;
}

// Namespace util/util
// Params 2
// Checksum 0xe8563340, Offset: 0x2050
// Size: 0x32
function setobjectivehinttext( team, text )
{
    game.strings[ "objective_hint_" + team ] = text;
}

// Namespace util/util
// Params 1
// Checksum 0xd7ec1a3, Offset: 0x2090
// Size: 0x24
function getobjectivetext( team )
{
    return game.strings[ "objective_" + team ];
}

// Namespace util/util
// Params 1
// Checksum 0x2a076a53, Offset: 0x20c0
// Size: 0x24
function getobjectivescoretext( team )
{
    return game.strings[ "objective_score_" + team ];
}

// Namespace util/util
// Params 1
// Checksum 0x7fb8ef54, Offset: 0x20f0
// Size: 0x24
function getobjectivehinttext( team )
{
    return game.strings[ "objective_hint_" + team ];
}

// Namespace util/util
// Params 2
// Checksum 0xb0a46e46, Offset: 0x2120
// Size: 0x70
function registerroundswitch( minvalue, maxvalue )
{
    level.roundswitch = math::clamp( getgametypesetting( "roundSwitch" ), minvalue, maxvalue );
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
}

// Namespace util/util
// Params 2
// Checksum 0x21b6db5d, Offset: 0x2198
// Size: 0x70
function registerroundlimit( minvalue, maxvalue )
{
    level.roundlimit = math::clamp( getgametypesetting( "roundLimit" ), minvalue, maxvalue );
    level.roundlimitmin = minvalue;
    level.roundlimitmax = maxvalue;
}

// Namespace util/util
// Params 2
// Checksum 0xa84d50e2, Offset: 0x2210
// Size: 0x70
function registerroundwinlimit( minvalue, maxvalue )
{
    level.roundwinlimit = math::clamp( getgametypesetting( "roundWinLimit" ), minvalue, maxvalue );
    level.roundwinlimitmin = minvalue;
    level.roundwinlimitmax = maxvalue;
}

// Namespace util/util
// Params 2
// Checksum 0xe26c3781, Offset: 0x2288
// Size: 0x94
function registerscorelimit( minvalue, maxvalue )
{
    level.scorelimit = math::clamp( getgametypesetting( "scoreLimit" ), minvalue, maxvalue );
    level.scorelimitmin = minvalue;
    level.scorelimitmax = maxvalue;
    setdvar( "ui_scorelimit", level.scorelimit );
}

// Namespace util/util
// Params 2
// Checksum 0xfa1f6551, Offset: 0x2328
// Size: 0x70
function registerroundscorelimit( minvalue, maxvalue )
{
    level.roundscorelimit = math::clamp( getgametypesetting( "roundScoreLimit" ), minvalue, maxvalue );
    level.roundscorelimitmin = minvalue;
    level.roundscorelimitmax = maxvalue;
}

// Namespace util/util
// Params 2
// Checksum 0x590c10c1, Offset: 0x23a0
// Size: 0xac
function registertimelimit( minvalue, maxvalue )
{
    level.timelimit = math::clamp( getgametypesetting( "timeLimit" ), minvalue, maxvalue );
    
    /#
        override_gts_timelimit();
    #/
    
    level.timelimitmin = minvalue;
    level.timelimitmax = maxvalue;
    setdvar( "ui_timelimit", level.timelimit );
}

// Namespace util/util
// Params 4
// Checksum 0xc9e343ba, Offset: 0x2458
// Size: 0x140
function registernumlives( minvalue, maxvalue, teamlivesminvalue, teamlivesmaxvalue )
{
    if ( !isdefined( teamlivesminvalue ) )
    {
        teamlivesminvalue = minvalue;
    }
    
    if ( !isdefined( teamlivesmaxvalue ) )
    {
        teamlivesmaxvalue = maxvalue;
    }
    
    level.numlives = math::clamp( getgametypesetting( "playerNumLives" ), minvalue, maxvalue );
    level.numlivesmin = minvalue;
    level.numlivesmax = maxvalue;
    level.numteamlives = math::clamp( getgametypesetting( "teamNumLives" ), teamlivesminvalue, teamlivesmaxvalue );
    level.numteamlivesmin = isdefined( teamlivesminvalue ) ? teamlivesminvalue : level.numlivesmin;
    level.numteamlivesmax = isdefined( teamlivesmaxvalue ) ? teamlivesmaxvalue : level.numlivesmax;
}

// Namespace util/util
// Params 1
// Checksum 0x7a36056b, Offset: 0x25a0
// Size: 0x8a
function getplayerfromclientnum( clientnum )
{
    if ( clientnum < 0 )
    {
        return undefined;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] getentitynumber() == clientnum )
        {
            return level.players[ i ];
        }
    }
    
    return undefined;
}

// Namespace util/util
// Params 0
// Checksum 0xc5c1f1a5, Offset: 0x2638
// Size: 0x4c, Type: bool
function ispressbuild()
{
    buildtype = getdvarstring( "buildType" );
    
    if ( isdefined( buildtype ) && buildtype == "press" )
    {
        return true;
    }
    
    return false;
}

// Namespace util/util
// Params 0
// Checksum 0xa19575e8, Offset: 0x2690
// Size: 0x20, Type: bool
function isflashbanged()
{
    return isdefined( self.flashendtime ) && gettime() < self.flashendtime;
}

// Namespace util/util
// Params 5
// Checksum 0xa76bc6b1, Offset: 0x26b8
// Size: 0xcc
function domaxdamage( origin, attacker, inflictor, headshot, mod )
{
    if ( isdefined( self.damagedtodeath ) && self.damagedtodeath )
    {
        return;
    }
    
    if ( isdefined( self.maxhealth ) )
    {
        damage = self.maxhealth + 1;
    }
    else
    {
        damage = self.health + 1;
    }
    
    self.damagedtodeath = 1;
    self dodamage( damage, origin, attacker, inflictor, headshot, mod );
}

// Namespace util/util
// Params 0
// Checksum 0xd658a6e5, Offset: 0x2790
// Size: 0x24
function self_delete()
{
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace util/util
// Params 5
// Checksum 0xb1dda5b7, Offset: 0x27c0
// Size: 0x604
function screen_message_create( string_message_1, string_message_2, string_message_3, n_offset_y, n_time )
{
    level notify( #"screen_message_create" );
    level endon( #"screen_message_create" );
    
    if ( isdefined( level.missionfailed ) && level.missionfailed )
    {
        return;
    }
    
    if ( getdvarint( "hud_missionFailed" ) == 1 )
    {
        return;
    }
    
    if ( !isdefined( n_offset_y ) )
    {
        n_offset_y = 0;
    }
    
    if ( !isdefined( level._screen_message_1 ) )
    {
        level._screen_message_1 = newhudelem();
        level._screen_message_1.elemtype = "font";
        level._screen_message_1.font = "objective";
        level._screen_message_1.fontscale = 1.8;
        level._screen_message_1.horzalign = "center";
        level._screen_message_1.vertalign = "middle";
        level._screen_message_1.alignx = "center";
        level._screen_message_1.aligny = "middle";
        level._screen_message_1.y = -60 + n_offset_y;
        level._screen_message_1.sort = 2;
        level._screen_message_1.color = ( 1, 1, 1 );
        level._screen_message_1.alpha = 1;
        level._screen_message_1.hidewheninmenu = 1;
    }
    
    level._screen_message_1 settext( string_message_1 );
    
    if ( isdefined( string_message_2 ) )
    {
        if ( !isdefined( level._screen_message_2 ) )
        {
            level._screen_message_2 = newhudelem();
            level._screen_message_2.elemtype = "font";
            level._screen_message_2.font = "objective";
            level._screen_message_2.fontscale = 1.8;
            level._screen_message_2.horzalign = "center";
            level._screen_message_2.vertalign = "middle";
            level._screen_message_2.alignx = "center";
            level._screen_message_2.aligny = "middle";
            level._screen_message_2.y = -33 + n_offset_y;
            level._screen_message_2.sort = 2;
            level._screen_message_2.color = ( 1, 1, 1 );
            level._screen_message_2.alpha = 1;
            level._screen_message_2.hidewheninmenu = 1;
        }
        
        level._screen_message_2 settext( string_message_2 );
    }
    else if ( isdefined( level._screen_message_2 ) )
    {
        level._screen_message_2 destroy();
    }
    
    if ( isdefined( string_message_3 ) )
    {
        if ( !isdefined( level._screen_message_3 ) )
        {
            level._screen_message_3 = newhudelem();
            level._screen_message_3.elemtype = "font";
            level._screen_message_3.font = "objective";
            level._screen_message_3.fontscale = 1.8;
            level._screen_message_3.horzalign = "center";
            level._screen_message_3.vertalign = "middle";
            level._screen_message_3.alignx = "center";
            level._screen_message_3.aligny = "middle";
            level._screen_message_3.y = -6 + n_offset_y;
            level._screen_message_3.sort = 2;
            level._screen_message_3.color = ( 1, 1, 1 );
            level._screen_message_3.alpha = 1;
            level._screen_message_3.hidewheninmenu = 1;
        }
        
        level._screen_message_3 settext( string_message_3 );
    }
    else if ( isdefined( level._screen_message_3 ) )
    {
        level._screen_message_3 destroy();
    }
    
    if ( isdefined( n_time ) && n_time > 0 )
    {
        wait n_time;
        screen_message_delete();
    }
}

// Namespace util/util
// Params 1
// Checksum 0x6e80ddcc, Offset: 0x2dd0
// Size: 0xac
function screen_message_delete( delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( level._screen_message_1 ) )
    {
        level._screen_message_1 destroy();
    }
    
    if ( isdefined( level._screen_message_2 ) )
    {
        level._screen_message_2 destroy();
    }
    
    if ( isdefined( level._screen_message_3 ) )
    {
        level._screen_message_3 destroy();
    }
}

// Namespace util/util
// Params 1
// Checksum 0xa5dfdba3, Offset: 0x2e88
// Size: 0x5c
function ghost_wait_show( wait_time )
{
    if ( !isdefined( wait_time ) )
    {
        wait_time = 0.1;
    }
    
    self endon( #"death" );
    self ghost();
    wait wait_time;
    self show();
}

// Namespace util/util
// Params 3
// Checksum 0x78b80cc5, Offset: 0x2ef0
// Size: 0x124
function ghost_wait_show_to_player( player, wait_time, self_endon_string1 )
{
    if ( !isdefined( wait_time ) )
    {
        wait_time = 0.1;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    self.abort_ghost_wait_show_to_player = undefined;
    
    if ( isdefined( player ) )
    {
        player endon( #"death" );
        player endon( #"disconnect" );
        player endon( #"joined_team" );
        player endon( #"joined_spectators" );
    }
    
    if ( isdefined( self_endon_string1 ) )
    {
        self endon( self_endon_string1 );
    }
    
    self ghost();
    self setinvisibletoall();
    self setvisibletoplayer( player );
    wait wait_time;
    
    if ( !isdefined( self.abort_ghost_wait_show_to_player ) )
    {
        self showtoplayer( player );
    }
}

// Namespace util/util
// Params 3
// Checksum 0x4749502d, Offset: 0x3020
// Size: 0x11c
function ghost_wait_show_to_others( player, wait_time, self_endon_string1 )
{
    if ( !isdefined( wait_time ) )
    {
        wait_time = 0.1;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    self.abort_ghost_wait_show_to_others = undefined;
    
    if ( isdefined( player ) )
    {
        player endon( #"death" );
        player endon( #"disconnect" );
        player endon( #"joined_team" );
        player endon( #"joined_spectators" );
    }
    
    if ( isdefined( self_endon_string1 ) )
    {
        self endon( self_endon_string1 );
    }
    
    self ghost();
    self setinvisibletoplayer( player );
    wait wait_time;
    
    if ( !isdefined( self.abort_ghost_wait_show_to_others ) )
    {
        self show();
        self setinvisibletoplayer( player );
    }
}

// Namespace util/util
// Params 0
// Checksum 0x730ae626, Offset: 0x3148
// Size: 0x4a
function use_button_pressed()
{
    assert( isplayer( self ), "Must call use_button_pressed() on a player." );
    return self usebuttonpressed();
}

// Namespace util/util
// Params 0
// Checksum 0x8e20454c, Offset: 0x31a0
// Size: 0x28
function waittill_use_button_pressed()
{
    while ( !self use_button_pressed() )
    {
        waitframe( 1 );
    }
}

// Namespace util/util
// Params 4
// Checksum 0x5cec7e02, Offset: 0x31d0
// Size: 0x18c
function show_hint_text( str_text_to_show, b_should_blink, str_turn_off_notify, n_display_time )
{
    if ( !isdefined( b_should_blink ) )
    {
        b_should_blink = 0;
    }
    
    if ( !isdefined( str_turn_off_notify ) )
    {
        str_turn_off_notify = "notify_turn_off_hint_text";
    }
    
    if ( !isdefined( n_display_time ) )
    {
        n_display_time = 4;
    }
    
    self endon( #"notify_turn_off_hint_text" );
    self endon( #"hint_text_removed" );
    
    if ( isdefined( self.hint_menu_handle ) )
    {
        hide_hint_text( 0 );
    }
    
    self.hint_menu_handle = self openluimenu( "MPHintText" );
    self setluimenudata( self.hint_menu_handle, "hint_text_line", str_text_to_show );
    
    if ( b_should_blink )
    {
        lui::play_animation( self.hint_menu_handle, "blinking" );
    }
    else
    {
        lui::play_animation( self.hint_menu_handle, "display_noblink" );
    }
    
    if ( n_display_time != -1 )
    {
        self thread hide_hint_text_listener( n_display_time );
        self thread fade_hint_text_after_time( n_display_time, str_turn_off_notify );
    }
}

// Namespace util/util
// Params 1
// Checksum 0x9903d05f, Offset: 0x3368
// Size: 0xc2
function hide_hint_text( b_fade_before_hiding )
{
    if ( !isdefined( b_fade_before_hiding ) )
    {
        b_fade_before_hiding = 1;
    }
    
    self endon( #"hint_text_removed" );
    
    if ( isdefined( self.hint_menu_handle ) )
    {
        if ( b_fade_before_hiding )
        {
            lui::play_animation( self.hint_menu_handle, "fadeout" );
            self waittilltimeout( 0.75, "kill_hint_text", "death", "hint_text_removed" );
        }
        
        self closeluimenu( self.hint_menu_handle );
        self.hint_menu_handle = undefined;
    }
    
    self notify( #"hint_text_removed" );
}

// Namespace util/util
// Params 2
// Checksum 0x245cac2f, Offset: 0x3438
// Size: 0x74
function fade_hint_text_after_time( n_display_time, str_turn_off_notify )
{
    self endon( #"hint_text_removed" );
    self endon( #"death" );
    self endon( #"kill_hint_text" );
    self waittilltimeout( n_display_time - 0.75, str_turn_off_notify, "hint_text_removed", "kill_hint_text" );
    hide_hint_text( 1 );
}

// Namespace util/util
// Params 1
// Checksum 0x452b67f9, Offset: 0x34b8
// Size: 0x64
function hide_hint_text_listener( n_time )
{
    self endon( #"hint_text_removed" );
    self endon( #"disconnect" );
    self waittilltimeout( n_time, "kill_hint_text", "death", "hint_text_removed", "disconnect" );
    hide_hint_text( 0 );
}

// Namespace util/util
// Params 2
// Checksum 0x55ad918, Offset: 0x3528
// Size: 0x74
function set_team_radar( team, value )
{
    if ( team == "allies" )
    {
        setmatchflag( "radar_allies", value );
        return;
    }
    
    if ( team == "axis" )
    {
        setmatchflag( "radar_axis", value );
    }
}

// Namespace util/util
// Params 0
// Checksum 0xc8f98658, Offset: 0x35a8
// Size: 0x24
function init_player_contract_events()
{
    if ( !isdefined( level.player_contract_events ) )
    {
        level.player_contract_events = [];
    }
}

// Namespace util/util
// Params 3
// Checksum 0xdfc2715, Offset: 0x35d8
// Size: 0x12a
function register_player_contract_event( event_name, event_func, max_param_count )
{
    if ( !isdefined( max_param_count ) )
    {
        max_param_count = 0;
    }
    
    if ( !isdefined( level.player_contract_events[ event_name ] ) )
    {
        level.player_contract_events[ event_name ] = spawnstruct();
        level.player_contract_events[ event_name ].param_count = max_param_count;
        level.player_contract_events[ event_name ].events = [];
    }
    
    assert( max_param_count == level.player_contract_events[ event_name ].param_count );
    level.player_contract_events[ event_name ].events[ level.player_contract_events[ event_name ].events.size ] = event_func;
}

// Namespace util/util
// Params 4
// Checksum 0xb19aa36c, Offset: 0x3710
// Size: 0x37e
function player_contract_event( event_name, param1, param2, param3 )
{
    if ( !isdefined( param1 ) )
    {
        param1 = undefined;
    }
    
    if ( !isdefined( param2 ) )
    {
        param2 = undefined;
    }
    
    if ( !isdefined( param3 ) )
    {
        param3 = undefined;
    }
    
    if ( !isdefined( level.player_contract_events[ event_name ] ) )
    {
        return;
    }
    
    param_count = isdefined( level.player_contract_events[ event_name ].param_count ) ? level.player_contract_events[ event_name ].param_count : 0;
    
    switch ( param_count )
    {
        case 0:
        default:
            foreach ( event_func in level.player_contract_events[ event_name ].events )
            {
                if ( isdefined( event_func ) )
                {
                    self [[ event_func ]]();
                }
            }
            
            break;
        case 1:
            foreach ( event_func in level.player_contract_events[ event_name ].events )
            {
                if ( isdefined( event_func ) )
                {
                    self [[ event_func ]]( param1 );
                }
            }
            
            break;
        case 2:
            foreach ( event_func in level.player_contract_events[ event_name ].events )
            {
                if ( isdefined( event_func ) )
                {
                    self [[ event_func ]]( param1, param2 );
                }
            }
            
            break;
        case 3:
            foreach ( event_func in level.player_contract_events[ event_name ].events )
            {
                if ( isdefined( event_func ) )
                {
                    self [[ event_func ]]( param1, param2, param3 );
                }
            }
            
            break;
    }
}

/#

    // Namespace util/util
    // Params 0
    // Checksum 0x69c4a10b, Offset: 0x3a98
    // Size: 0x54, Type: dev
    function debug_slow_heli_speed()
    {
        if ( getdvarint( "scr_slow_heli", 0 ) > 0 )
        {
            self setspeed( getdvarint( "scr_slow_heli" ) );
        }
    }

#/

// Namespace util/util
// Params 1
// Checksum 0x5879bbcb, Offset: 0x3af8
// Size: 0x5a
function is_objective_game( game_type )
{
    switch ( game_type )
    {
        case #"clean":
        case #"conf":
        case #"dm":
        case #"gun":
        case #"tdm":
            return 0;
        default:
            return 1;
    }
}

/#

    // Namespace util/util
    // Params 0
    // Checksum 0x7933e10a, Offset: 0x3b60
    // Size: 0x3c, Type: dev
    function check_art_mode()
    {
        if ( getdvarint( "art_mode", 0 ) > 0 )
        {
            init_map_art_dev();
        }
    }

    // Namespace util/util
    // Params 0
    // Checksum 0x963a3bdf, Offset: 0x3ba8
    // Size: 0x1c, Type: dev
    function apply_dev_overrides()
    {
        override_gts_timelimit();
    }

    // Namespace util/util
    // Params 0
    // Checksum 0x31549e45, Offset: 0x3bd0
    // Size: 0x4c, Type: dev
    function init_map_art_dev()
    {
        disable_gameplay_timers();
        disable_draft();
        disable_ui();
        enable_art_fps();
    }

    // Namespace util/util
    // Params 0
    // Checksum 0xc2d11263, Offset: 0x3c28
    // Size: 0x54, Type: dev
    function disable_gameplay_timers()
    {
        setdvar( "timelimitOverride", 0 );
        setdvar( "prematchPeriodOverride", 0 );
        setdvar( "preroundPeriodOverride", 0 );
    }

    // Namespace util/util
    // Params 0
    // Checksum 0x7e35ae68, Offset: 0x3c88
    // Size: 0x44, Type: dev
    function disable_draft()
    {
        setdvar( "draftEnabled", 0 );
        setdvar( "auto_select_character", 1 );
    }

    // Namespace util/util
    // Params 0
    // Checksum 0x81ea9e0e, Offset: 0x3cd8
    // Size: 0x24, Type: dev
    function disable_ui()
    {
        setdvar( "ui_enabled", 0 );
    }

    // Namespace util/util
    // Params 0
    // Checksum 0x58522ad, Offset: 0x3d08
    // Size: 0x7c, Type: dev
    function override_gts_timelimit()
    {
        timelimitoverride = getdvarint( "timelimitOverride", -1 );
        
        if ( timelimitoverride >= 0 )
        {
            if ( level.timelimit != timelimitoverride )
            {
                level.timelimit = timelimitoverride;
                setgametypesetting( "timeLimit", timelimitoverride );
            }
        }
    }

    // Namespace util/util
    // Params 0
    // Checksum 0x918da405, Offset: 0x3d90
    // Size: 0x44, Type: dev
    function enable_art_fps()
    {
        setdvar( "cg_drawFPS", 0 );
        setdvar( "cg_drawArtFPS", 1 );
    }

#/
