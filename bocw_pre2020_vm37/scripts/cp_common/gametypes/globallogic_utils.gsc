#using script_7f6cd71c43c45c57;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\weapons_shared;

#namespace globallogic_utils;

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xe354fdc4, Offset: 0xc0
// Size: 0xb8
function testshock()
{
    self endon( #"death", #"disconnect" );
    
    for ( ;; )
    {
        wait 3;
        numshots = randomint( 6 );
        
        for ( i = 0; i < numshots ; i++ )
        {
            iprintlnbold( numshots );
            self shellshock( #"frag_grenade_mp", 0.2 );
            wait 0.1;
        }
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xde16e753, Offset: 0x180
// Size: 0xf8
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
    
    timepassed = float( gettimepassed() - level.starttime ) / 1000;
    timeremaining = level.timelimit * 60 - timepassed;
    return timeremaining + level.postroundtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x533b3bf9, Offset: 0x280
// Size: 0x44
function gettimeremaining()
{
    if ( level.timelimit == 0 )
    {
        return undefined;
    }
    
    return level.timelimit * 60 * 1000 - gettimepassed();
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x5075bea7, Offset: 0x2d0
// Size: 0x44
function registerpostroundevent( eventfunc )
{
    if ( !isdefined( level.postroundevents ) )
    {
        level.postroundevents = [];
    }
    
    level.postroundevents[ level.postroundevents.size ] = eventfunc;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xc5895f2f, Offset: 0x320
// Size: 0x56
function executepostroundevents()
{
    if ( !isdefined( level.postroundevents ) )
    {
        return;
    }
    
    for ( i = 0; i < level.postroundevents.size ; i++ )
    {
        [[ level.postroundevents[ i ] ]]();
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 3
// Checksum 0xfcdba4ff, Offset: 0x380
// Size: 0x46
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
    // Checksum 0xf347562c, Offset: 0x3d0
    // Size: 0x2a0, Type: dev
    function assertproperplacement()
    {
        numplayers = level.placement[ #"all" ].size;
        
        if ( level.teambased )
        {
            for ( i = 0; i < numplayers - 1 ; i++ )
            {
                if ( level.placement[ #"all" ][ i ].score < level.placement[ #"all" ][ i + 1 ].score )
                {
                    println( "<dev string:x38>" );
                    
                    for ( i = 0; i < numplayers ; i++ )
                    {
                        player = level.placement[ #"all" ][ i ];
                        println( "<dev string:x4e>" + i + "<dev string:x54>" + player.name + "<dev string:x5a>" + player.score );
                    }
                    
                    assertmsg( "<dev string:x60>" );
                    break;
                }
            }
            
            return;
        }
        
        for ( i = 0; i < numplayers - 1 ; i++ )
        {
            if ( level.placement[ #"all" ][ i ].pointstowin < level.placement[ #"all" ][ i + 1 ].pointstowin )
            {
                println( "<dev string:x38>" );
                
                for ( i = 0; i < numplayers ; i++ )
                {
                    player = level.placement[ #"all" ][ i ];
                    println( "<dev string:x4e>" + i + "<dev string:x54>" + player.name + "<dev string:x5a>" + player.pointstowin );
                }
                
                assertmsg( "<dev string:x60>" );
                break;
            }
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x6b32622e, Offset: 0x678
// Size: 0x6a, Type: bool
function isvalidclass( c )
{
    if ( level.oldschool || sessionmodeiszombiesgame() )
    {
        assert( !isdefined( c ) );
        return true;
    }
    
    return isdefined( c ) && c != "";
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x406c31f8, Offset: 0x6f0
// Size: 0x104
function playtickingsound( gametype_tick_sound )
{
    self endon( #"death", #"stop_ticking" );
    level endon( #"game_ended" );
    time = level.bombtimer;
    
    while ( true )
    {
        self playsound( gametype_tick_sound );
        
        if ( time > 10 )
        {
            time -= 1;
            wait 1;
            continue;
        }
        
        if ( time > 4 )
        {
            time -= 0.5;
            wait 0.5;
            continue;
        }
        
        if ( time > 1 )
        {
            time -= 0.4;
            wait 0.4;
            continue;
        }
        
        time -= 0.3;
        wait 0.3;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0xcdaa5e2, Offset: 0x800
// Size: 0x16
function stoptickingsound()
{
    self notify( #"stop_ticking" );
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x1e4f3e2a, Offset: 0x820
// Size: 0xec
function gametimer()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_over" );
    level.starttime = gettime();
    level.discardtime = 0;
    
    if ( isdefined( game.roundmillisecondsalreadypassed ) )
    {
        level.starttime -= game.roundmillisecondsalreadypassed;
        game.roundmillisecondsalreadypassed = undefined;
    }
    
    prevtime = gettime();
    
    while ( game.state == "playing" )
    {
        if ( !level.timerstopped )
        {
            game.timepassed += gettime() - prevtime;
        }
        
        prevtime = gettime();
        wait 1;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x1f5fc334, Offset: 0x918
// Size: 0x66
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
// Params 0
// Checksum 0xf4a60e5, Offset: 0x988
// Size: 0x30
function pausetimer()
{
    if ( level.timerstopped )
    {
        return;
    }
    
    level.timerstopped = 1;
    level.timerpausetime = gettime();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0
// Checksum 0x3c1f71aa, Offset: 0x9c0
// Size: 0x44
function resumetimer()
{
    if ( !level.timerstopped )
    {
        return;
    }
    
    level.timerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xbd683273, Offset: 0xa10
// Size: 0x16
function getscoreremaining( *team )
{
    return level.scorelimit;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xdb1f15db, Offset: 0xa30
// Size: 0xe, Type: bool
function getteamscoreforround( *team )
{
    return false;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x64deec58, Offset: 0xa48
// Size: 0xe, Type: bool
function getscoreperminute( *team )
{
    return false;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0x10370f10, Offset: 0xa60
// Size: 0x96
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
// Checksum 0xb53197c2, Offset: 0xb00
// Size: 0x48
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
// Checksum 0xdb316959, Offset: 0xb50
// Size: 0x24
function waitfortimeornotify( time, notifyname )
{
    self endon( notifyname );
    wait time;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2
// Checksum 0xf3a2e83, Offset: 0xb80
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
// Checksum 0xe74d13ef, Offset: 0xbe8
// Size: 0xfe, Type: bool
function isheadshot( weapon, shitloc, smeansofdeath, *einflictor )
{
    if ( smeansofdeath != "head" && smeansofdeath != "helmet" )
    {
        return false;
    }
    
    switch ( einflictor )
    {
        case #"mod_melee_weapon_butt":
        case #"mod_melee_assassinate":
        case #"mod_melee":
            return false;
        case #"mod_impact":
            baseweapon = weapons::getbaseweapon( shitloc );
            
            if ( !shitloc.isballisticknife && baseweapon != level.weaponspecialcrossbow && baseweapon != level.weaponflechette )
            {
                return false;
            }
            
            break;
    }
    
    return true;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1
// Checksum 0xe6f3318a, Offset: 0xcf0
// Size: 0x166
function gethitlocheight( shitloc )
{
    switch ( shitloc )
    {
        case #"head":
        case #"helmet":
        case #"neck":
            return 60;
        case #"left_arm_lower":
        case #"left_arm_upper":
        case #"torso_upper":
        case #"right_arm_lower":
        case #"left_hand":
        case #"right_arm_upper":
        case #"gun":
        case #"right_hand":
            return 48;
        case #"torso_lower":
            return 40;
        case #"right_leg_upper":
        case #"left_leg_upper":
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
    // Checksum 0xe6398c4a, Offset: 0xe60
    // Size: 0x5a, Type: dev
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
// Checksum 0x18884e93, Offset: 0xec8
// Size: 0x10c
function logteamwinstring( wintype, winner )
{
    log_string = wintype;
    
    if ( isdefined( winner ) )
    {
        log_string = log_string + ", win: " + winner;
    }
    
    foreach ( team, str_team in level.teams )
    {
        log_string = log_string + ", " + str_team + ": " + game.stat[ #"teamscores" ][ team ];
    }
    
    /#
        print( log_string );
    #/
}

