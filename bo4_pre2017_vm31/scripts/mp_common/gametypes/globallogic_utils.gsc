#using scripts/core_common/callbacks_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/hud_message;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/util;

#namespace globallogic_utils;

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xe72f8f35, Offset: 0x3c8
// Size: 0x98
function function_15b32a64()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        wait 10;
        var_b444826e = spawnstruct();
        var_b444826e.titletext = &"MP_CHALLENGE_COMPLETED";
        var_b444826e.var_da258253 = "wheee";
        var_b444826e.sound = "mp_challenge_complete";
        self thread hud_message::notifymessage( var_b444826e );
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x4a680be0, Offset: 0x468
// Size: 0xba
function testshock()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        wait 3;
        numshots = randomint( 6 );
        
        for ( i = 0; i < numshots ; i++ )
        {
            iprintlnbold( numshots );
            self shellshock( "frag_grenade_mp", 0.2 );
            wait 0.1;
        }
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x45b6f61e, Offset: 0x530
// Size: 0xd0
function testhps()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    hps = [];
    hps[ hps.size ] = "radar";
    hps[ hps.size ] = "artillery";
    hps[ hps.size ] = "dogs";
    
    for ( ;; )
    {
        hp = "radar";
        
        if ( self thread killstreaks::give( hp ) )
        {
            self playlocalsound( level.killstreaks[ hp ].informdialog );
        }
        
        wait 20;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x7edebb51, Offset: 0x608
// Size: 0x100
function timeuntilroundend()
{
    if ( level.gameended )
    {
        timepassed = ( gettime() - level.gameendtime ) / 1000;
        timeremaining = level.postroundtime - timepassed;
        
        if ( timeremaining < 0 )
        {
            return 0;
        }
        
        return timeremaining;
    }
    
    if ( level.inovertime )
    {
        return undefined;
    }
    
    if ( level.timelimit <= 0 )
    {
        return undefined;
    }
    
    if ( !isdefined( level.starttime ) )
    {
        return undefined;
    }
    
    timepassed = ( gettimepassed() - level.starttime ) / 1000;
    timeremaining = level.timelimit * 60 - timepassed;
    return timeremaining + level.postroundtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xb592fa84, Offset: 0x710
// Size: 0x2c
function gettimeremaining()
{
    return level.timelimit * 60 * 1000 - gettimepassed();
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xd771567a, Offset: 0x748
// Size: 0x4a
function registerpostroundevent( eventfunc )
{
    if ( !isdefined( level.postroundevents ) )
    {
        level.postroundevents = [];
    }
    
    level.postroundevents[ level.postroundevents.size ] = eventfunc;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2
// Checksum 0xff310e54, Offset: 0x7a0
// Size: 0x78
function executepostroundevents( winner, endreasontext )
{
    if ( !isdefined( level.postroundevents ) )
    {
        return;
    }
    
    for ( i = 0; i < level.postroundevents.size ; i++ )
    {
        [[ level.postroundevents[ i ] ]]( winner, endreasontext );
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 3
// Checksum 0xdb2587b4, Offset: 0x820
// Size: 0x52
function getvalueinrange( value, minvalue, maxvalue )
{
    if ( value > maxvalue )
    {
        return maxvalue;
    }
    
    if ( value < minvalue )
    {
        return minvalue;
    }
    
    return value;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 0
    // Checksum 0x3bc9af20, Offset: 0x880
    // Size: 0x2da, Type: dev
    function assertproperplacement()
    {
        numplayers = level.placement[ "<dev string:x28>" ].size;
        
        if ( level.teambased )
        {
            for ( i = 0; i < numplayers - 1 ; i++ )
            {
                if ( level.placement[ "<dev string:x28>" ][ i ].score < level.placement[ "<dev string:x28>" ][ i + 1 ].score )
                {
                    println( "<dev string:x2c>" );
                    
                    for ( i = 0; i < numplayers ; i++ )
                    {
                        player = level.placement[ "<dev string:x28>" ][ i ];
                        println( "<dev string:x3f>" + i + "<dev string:x42>" + player.name + "<dev string:x45>" + player.score );
                    }
                    
                    assertmsg( "<dev string:x48>" );
                    break;
                }
            }
            
            return;
        }
        
        for ( i = 0; i < numplayers - 1 ; i++ )
        {
            if ( level.placement[ "<dev string:x28>" ][ i ].pointstowin < level.placement[ "<dev string:x28>" ][ i + 1 ].pointstowin )
            {
                println( "<dev string:x2c>" );
                
                for ( i = 0; i < numplayers ; i++ )
                {
                    player = level.placement[ "<dev string:x28>" ][ i ];
                    println( "<dev string:x3f>" + i + "<dev string:x42>" + player.name + "<dev string:x45>" + player.pointstowin );
                }
                
                assertmsg( "<dev string:x48>" );
                break;
            }
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xa4c656da, Offset: 0xb68
// Size: 0x58, Type: bool
function isvalidclass( c )
{
    if ( sessionmodeiszombiesgame() )
    {
        assert( !isdefined( c ) );
        return true;
    }
    
    return isdefined( c ) && c != "";
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x78199744, Offset: 0xbc8
// Size: 0x128
function playtickingsound( gametype_tick_sound )
{
    self endon( #"death" );
    self endon( #"stop_ticking" );
    level endon( #"game_ended" );
    time = level.bombtimer;
    
    while ( true )
    {
        self playsound( gametype_tick_sound );
        
        if ( time > 10 )
        {
            time -= 1;
            wait 1;
        }
        else if ( time > 4 )
        {
            time -= 0.5;
            wait 0.5;
        }
        else if ( time > 1 )
        {
            time -= 0.4;
            wait 0.4;
        }
        else
        {
            time -= 0.3;
            wait 0.3;
        }
        
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xdfa7711d, Offset: 0xcf8
// Size: 0x12
function stoptickingsound()
{
    self notify( #"stop_ticking" );
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xe1d66800, Offset: 0xd18
// Size: 0x124
function gametimer()
{
    level endon( #"game_ended" );
    level waittill( "prematch_over" );
    level.starttime = gettime();
    level.discardtime = 0;
    
    if ( isdefined( game.roundmillisecondsalreadypassed ) )
    {
        level.starttime -= game.roundmillisecondsalreadypassed;
        game.roundmillisecondsalreadypassed = undefined;
    }
    
    prevtime = gettime() - 1000;
    
    while ( game.state == "playing" )
    {
        if ( !level.timerstopped )
        {
            game.timepassed += gettime() - prevtime;
        }
        
        if ( !level.playabletimerstopped )
        {
            game.playabletimepassed += gettime() - prevtime;
        }
        
        prevtime = gettime();
        wait 1;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x5c4fffc6, Offset: 0xe48
// Size: 0x74
function disableplayerroundstartdelay()
{
    player = self;
    player endon( #"death" );
    player endon( #"disconnect" );
    
    if ( getroundstartdelay() )
    {
        wait getroundstartdelay();
    }
    
    player disableroundstartdelay();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x4b9f1c58, Offset: 0xec8
// Size: 0x48
function getroundstartdelay()
{
    waittime = level.roundstartexplosivedelay - [[ level.gettimepassed ]]() / 1000;
    
    if ( waittime > 0 )
    {
        return waittime;
    }
    
    return 0;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x9cf9adca, Offset: 0xf18
// Size: 0x8c
function applyroundstartdelay()
{
    self endon( #"disconnect" );
    self endon( #"joined_spectators" );
    self endon( #"death" );
    
    if ( isdefined( level.prematch_over ) && level.prematch_over )
    {
        waitframe( 1 );
    }
    else
    {
        level waittill( "prematch_over" );
    }
    
    self enableroundstartdelay();
    self thread disableplayerroundstartdelay();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x91398712, Offset: 0xfb0
// Size: 0x6e
function gettimepassed()
{
    if ( !isdefined( level.starttime ) )
    {
        return 0;
    }
    
    if ( level.timerstopped )
    {
        return ( level.timerpausetime - level.starttime - level.discardtime );
    }
    
    return gettime() - level.starttime - level.discardtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xba01e1b8, Offset: 0x1028
// Size: 0x60
function pausetimer( pauseplayabletimer )
{
    if ( !isdefined( pauseplayabletimer ) )
    {
        pauseplayabletimer = 0;
    }
    
    level.playabletimerstopped = pauseplayabletimer;
    
    if ( level.timerstopped )
    {
        return;
    }
    
    level.timerstopped = 1;
    level.timerpausetime = gettime();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x4eefffc2, Offset: 0x1090
// Size: 0x5c
function resumetimer()
{
    if ( !level.timerstopped )
    {
        return;
    }
    
    level.timerstopped = 0;
    level.playabletimerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x4eef8465, Offset: 0x10f8
// Size: 0x3c
function resumetimerdiscardoverride( discardtime )
{
    if ( !level.timerstopped )
    {
        return;
    }
    
    level.timerstopped = 0;
    level.discardtime = discardtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xca1466e6, Offset: 0x1140
// Size: 0xa6
function getscoreremaining( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    scorelimit = level.scorelimit;
    
    if ( isplayer( self ) )
    {
        return ( scorelimit - globallogic_score::_getplayerscore( self ) );
    }
    
    return scorelimit - getteamscore( team );
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x2dbfbf32, Offset: 0x11f0
// Size: 0x72
function getteamscoreforround( team )
{
    if ( level.cumulativeroundscores && isdefined( game.lastroundscore[ team ] ) )
    {
        return ( getteamscore( team ) - game.lastroundscore[ team ] );
    }
    
    return getteamscore( team );
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x13aa7608, Offset: 0x1270
// Size: 0xba
function getscoreperminute( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    minutespassed = gettimepassed() / 60000 + 0.0001;
    
    if ( isplayer( self ) )
    {
        return ( globallogic_score::_getplayerscore( self ) / minutespassed );
    }
    
    return getteamscoreforround( team ) / minutespassed;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xd160a4f7, Offset: 0x1338
// Size: 0xa2
function getestimatedtimeuntilscorelimit( team )
{
    assert( isplayer( self ) || isdefined( team ) );
    scoreperminute = self getscoreperminute( team );
    scoreremaining = self getscoreremaining( team );
    
    if ( !scoreperminute )
    {
        return 999999;
    }
    
    return scoreremaining / scoreperminute;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x6f75cd49, Offset: 0x13e8
// Size: 0x40
function rumbler()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait 0.1;
        self playrumbleonentity( "damage_heavy" );
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 2
// Checksum 0x2cd4ed3b, Offset: 0x1430
// Size: 0x24
function waitfortimeornotify( time, notifyname )
{
    self endon( notifyname );
    wait time;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2
// Checksum 0xa56b7b5, Offset: 0x1460
// Size: 0x60
function waitfortimeornotifynoartillery( time, notifyname )
{
    self endon( notifyname );
    wait time;
    
    while ( isdefined( level.artilleryinprogress ) )
    {
        assert( level.artilleryinprogress );
        wait 0.25;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 4
// Checksum 0x994dd6fa, Offset: 0x14c8
// Size: 0xe2, Type: bool
function isheadshot( weapon, shitloc, smeansofdeath, einflictor )
{
    if ( shitloc != "head" && shitloc != "helmet" )
    {
        return false;
    }
    
    switch ( smeansofdeath )
    {
        case #"mod_melee":
        case #"mod_melee_assassinate":
            return false;
        case #"mod_impact":
            if ( weapon != level.weaponballisticknife )
            {
                return false;
            }
            
            break;
    }
    
    if ( killstreaks::is_killstreak_weapon( weapon ) )
    {
        if ( !isdefined( einflictor ) || !isdefined( einflictor.controlled ) || einflictor.controlled == 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xaa3331b0, Offset: 0x15b8
// Size: 0xd6
function gethitlocheight( shitloc )
{
    switch ( shitloc )
    {
        case #"head":
        case #"helmet":
        case #"neck":
            return 60;
        case #"gun":
        case #"left_arm_lower":
        case #"left_arm_upper":
        case #"left_hand":
        case #"right_arm_lower":
        case #"right_arm_upper":
        case #"right_hand":
        case #"torso_upper":
            return 48;
        case #"torso_lower":
            return 40;
        case #"left_leg_upper":
        case #"right_leg_upper":
            return 32;
        case #"left_leg_lower":
        case #"right_leg_lower":
            return 10;
        case #"left_foot":
        case #"right_foot":
            return 5;
    }
    
    return 48;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 2
    // Checksum 0xfb6e7b1a, Offset: 0x1698
    // Size: 0x64, Type: dev
    function debugline( start, end )
    {
        for ( i = 0; i < 50 ; i++ )
        {
            line( start, end );
            waitframe( 1 );
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 2
// Checksum 0xbc3a5846, Offset: 0x1708
// Size: 0x5a, Type: bool
function isexcluded( entity, entitylist )
{
    for ( index = 0; index < entitylist.size ; index++ )
    {
        if ( entity == entitylist[ index ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x8e894d2a, Offset: 0x1770
// Size: 0x62
function function_b59d6fa4( var_be260a2e )
{
    var_9a8af909 = gettime();
    waitedtime = ( gettime() - var_9a8af909 ) / 1000;
    
    if ( waitedtime < var_be260a2e )
    {
        wait var_be260a2e - waitedtime;
        return var_be260a2e;
    }
    
    return waitedtime;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 2
    // Checksum 0x1f8907e0, Offset: 0x17e0
    // Size: 0x114, Type: dev
    function logteamwinstring( wintype, winner )
    {
        log_string = wintype;
        
        if ( isdefined( winner ) )
        {
            log_string = log_string + "<dev string:x70>" + winner;
        }
        
        foreach ( team in level.teams )
        {
            log_string = log_string + "<dev string:x78>" + team + "<dev string:x45>" + game.stat[ "<dev string:x7b>" ][ team ];
        }
        
        print( log_string );
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xf395b7db, Offset: 0x1900
// Size: 0x4a
function add_map_error( msg )
{
    if ( !isdefined( level.maperrors ) )
    {
        level.maperrors = [];
    }
    
    level.maperrors[ level.maperrors.size ] = msg;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x4cab3139, Offset: 0x1958
// Size: 0xdc, Type: bool
function print_map_errors()
{
    if ( isdefined( level.maperrors ) && level.maperrors.size > 0 )
    {
        /#
            println( "<dev string:x86>" );
            
            for ( i = 0; i < level.maperrors.size ; i++ )
            {
                println( level.maperrors[ i ] );
            }
            
            println( "<dev string:xad>" );
            util::error( "<dev string:xd4>" );
        #/
        
        callback::abort_level();
        return true;
    }
    
    return false;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xc69fc127, Offset: 0x1a40
// Size: 0x84
function switch_sides()
{
    if ( !isdefined( game.switchedsides ) )
    {
        game.switchedsides = 0;
    }
    
    if ( game.switchedsides )
    {
        oldattackers = game.attackers;
        olddefenders = game.defenders;
        game.attackers = olddefenders;
        game.defenders = oldattackers;
    }
}

