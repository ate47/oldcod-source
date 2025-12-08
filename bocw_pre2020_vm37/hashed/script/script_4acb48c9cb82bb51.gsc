#using script_1435f3c9fc699e04;
#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;

#namespace namespace_d03f485e;

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0x3760057d, Offset: 0x330
// Size: 0x134
function function_dc5b7ee6()
{
    globallogic::init();
    level.activezone = undefined;
    spawning::addsupportedspawnpointtype( "war" );
    spawning::function_754c78a6( &function_259770ba );
    level.shouldplayovertimeround = &shouldplayovertimeround;
    level.overtimetimelimit = getgametypesetting( #"overtimetimelimit" );
    level.gettimelimit = &gettimelimit;
    level.ontimelimit = &ontimelimit;
    clientfield::register( "world", "war_zone", 1, 5, "int" );
    clientfield::register( "scriptmover", "scriptid", 1, 5, "int" );
    function_97c413ba();
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0xf2f0eaed, Offset: 0x470
// Size: 0x134
function function_97c413ba()
{
    level.var_1845db12 = [];
    level.var_1845db12[ #"neutral" ] = { #losing:"warLosingNeutral", #var_c8bc87ae:"warTakingNeutral", #lost:"warLostNeutral" };
    level.var_1845db12[ #"friendly" ] = { #losing:"warLosingFriendly", #var_c8bc87ae:"warTakingFriendly", #lost:"warLostFriendly" };
    level.var_1845db12[ #"enemy" ] = { #losing:"warLosingEnemey", #var_c8bc87ae:"warTakingEnemey", #lost:"warLostEnemey" };
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0xabcb3fa8, Offset: 0x5b0
// Size: 0x76
function gettimelimit()
{
    timelimit = math::clamp( getgametypesetting( #"timelimit" ), level.timelimitmin, level.timelimitmax );
    
    if ( overtime::is_overtime_round() )
    {
        timelimit = level.overtimetimelimit;
    }
    
    return timelimit;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0x6fbe1af1, Offset: 0x630
// Size: 0x68, Type: bool
function shouldplayovertimeround()
{
    if ( game.overtime_round > 0 )
    {
        return false;
    }
    
    return game.stat[ #"teamscores" ][ #"allies" ] == game.stat[ #"teamscores" ][ #"axis" ];
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0x72cdad89, Offset: 0x6a0
// Size: 0x54
function function_b4530b39()
{
    level endon( #"game_ended" );
    
    while ( game.state != "playing" )
    {
        waitframe( 1 );
    }
    
    globallogic_audio::leader_dialog( "roundOvertime" );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0xb603df64, Offset: 0x700
// Size: 0xe0
function function_f6c3ee90()
{
    while ( game.state != "playing" )
    {
        waitframe( 1 );
    }
    
    timelimit = gettimelimit();
    
    if ( timelimit <= 0 )
    {
        return;
    }
    
    wait ( timelimit - 1 ) * 60;
    
    if ( !isdefined( level.var_57e2bc08 ) )
    {
        return;
    }
    
    thread [[ level.var_57e2bc08 ]]( "warRoundEndNearDraw", #"allies", "DraW", undefined, "war" );
    thread [[ level.var_57e2bc08 ]]( "warRoundEndNearDraw", #"axis", "DraW", undefined, "war" );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1
// Checksum 0x76497fb, Offset: 0x7e8
// Size: 0x84
function function_43811ed1( warzone )
{
    var_fea5c547 = getentarray( warzone.target, "targetname" );
    
    for ( counter = 0; counter < var_fea5c547.size ; counter++ )
    {
        var_fea5c547[ counter ] notsolid();
        var_fea5c547[ counter ] ghost();
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0xeebda61, Offset: 0x878
// Size: 0x26c
function function_1804ad1c()
{
    thread function_f6c3ee90();
    var_1b3b480b = getentarray( "war_zone", "targetname" );
    
    foreach ( warzone in var_1b3b480b )
    {
        function_43811ed1( warzone );
    }
    
    if ( overtime::is_overtime_round() )
    {
        function_7de91713();
        var_1871ddeb = function_582a1641();
        thread function_b4530b39();
    }
    else
    {
        function_7c88d456();
        var_1871ddeb = function_582a1641();
        
        foreach ( zoneindex in getarraykeys( level.var_1b3b480b ) )
        {
            if ( zoneindex == var_1871ddeb )
            {
                continue;
            }
            
            if ( zoneindex < var_1871ddeb )
            {
                level.var_1b3b480b[ zoneindex ].team = #"allies";
                continue;
            }
            
            if ( zoneindex > var_1871ddeb )
            {
                level.var_1b3b480b[ zoneindex ].team = #"axis";
            }
        }
    }
    
    spawning::function_fac242d0( 5, "war_zone_", &function_b11bd4e4 );
    thread function_2f51eb67();
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0xa8f7b5bb, Offset: 0xaf0
// Size: 0x64
function function_2f51eb67()
{
    while ( game.state != "playing" )
    {
        waitframe( 1 );
    }
    
    var_1871ddeb = function_582a1641();
    thread function_a8049ffd( var_1871ddeb, 10 );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0, eflags: 0x4
// Checksum 0x89fe536f, Offset: 0xb60
// Size: 0xf8
function private function_7de91713()
{
    if ( !isdefined( level.var_1b3b480b ) )
    {
        level.var_1b3b480b = [];
    }
    
    var_1b3b480b = getentarray( "war_zone", "targetname" );
    
    foreach ( warzone in var_1b3b480b )
    {
        if ( !isdefined( warzone.isOvertimeZone ) )
        {
            continue;
        }
        
        function_15b6cb2b( warzone );
        level.var_30c0a631 = warzone.script_index;
        break;
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0, eflags: 0x4
// Checksum 0x451ebf44, Offset: 0xc60
// Size: 0xf0
function private function_7c88d456()
{
    if ( !isdefined( level.var_1b3b480b ) )
    {
        level.var_1b3b480b = [];
    }
    
    var_1b3b480b = getentarray( "war_zone", "targetname" );
    
    foreach ( warzone in var_1b3b480b )
    {
        if ( is_true( warzone.ignoreRegular ) )
        {
            continue;
        }
        
        function_15b6cb2b( warzone );
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2, eflags: 0x4
// Checksum 0x9239c14a, Offset: 0xd58
// Size: 0xa0
function private function_4b6d5b40( zoneindex, target )
{
    var_fea5c547 = getentarray( target, "targetname" );
    
    for ( counter = 0; counter < var_fea5c547.size ; counter++ )
    {
        var_fea5c547[ counter ] notsolid();
        var_fea5c547[ counter ] clientfield::set( "scriptid", zoneindex + 1 );
    }
    
    return var_fea5c547;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x4
// Checksum 0x1de72c54, Offset: 0xe00
// Size: 0x2cc
function private function_15b6cb2b( capturezone )
{
    assert( isdefined( capturezone.script_index ) );
    assert( !isdefined( level.var_1b3b480b[ capturezone.script_index ] ) );
    name = "war_" + ( isdefined( capturezone.script_index ) ? "" + capturezone.script_index : "" );
    var_6b67c295 = gameobjects::create_use_object( #"neutral", capturezone, [], ( 0, 0, 0 ), name );
    var_6b67c295 gameobjects::set_use_text( #"mp/capturing_flag" );
    var_6b67c295 gameobjects::set_use_time( getgametypesetting( #"capturetime" ) );
    var_6b67c295 gameobjects::set_decay_time( getgametypesetting( #"capturetime" ) );
    var_6b67c295.decayprogress = isdefined( getgametypesetting( #"decayprogress" ) ) ? getgametypesetting( #"decayprogress" ) : 0;
    var_6b67c295.autodecaytime = isdefined( getgametypesetting( #"autodecaytime" ) ) ? getgametypesetting( #"autodecaytime" ) : undefined;
    var_6b67c295.onuse = &onzonecapture;
    var_6b67c295.onupdateuserate = &onupdateuserate;
    var_6b67c295.onuseupdate = &on_use_update;
    var_6b67c295.index = capturezone.script_index;
    
    if ( isdefined( capturezone.target ) )
    {
        var_6b67c295.var_142ad58e = function_4b6d5b40( capturezone.script_index, capturezone.target );
    }
    
    level.var_1b3b480b[ capturezone.script_index ] = var_6b67c295;
    var_6b67c295.var_48550e00 = #"neutral";
    deactivatezone( capturezone.script_index );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1
// Checksum 0x233e236e, Offset: 0x10d8
// Size: 0x2a4
function onzonecapture( sentient )
{
    nextzone = function_d018d4fb( level.activezone.index, sentient.team );
    level.activezone setteam( sentient.team );
    
    if ( nextzone >= level.var_1b3b480b.size || nextzone < 0 )
    {
        match::set_winner( sentient.team );
        thread globallogic::function_a3e3bd39( sentient.team, 1 );
        return;
    }
    
    otherteam = util::getotherteam( sentient.team );
    
    if ( self.var_48550e00 == #"neutral" )
    {
        function_7aa95c76( self, level.var_1845db12[ #"neutral" ].lost, otherteam );
    }
    else if ( self.var_48550e00 == sentient.team )
    {
        function_7aa95c76( self, level.var_1845db12[ #"enemy" ].lost, otherteam );
    }
    else
    {
        function_7aa95c76( self, level.var_1845db12[ #"friendly" ].lost, otherteam );
    }
    
    self.var_48550e00 = sentient.team;
    self gameobjects::set_owner_team( sentient.team );
    deactivatezone( level.activezone.index );
    thread function_a8049ffd( nextzone, 20 );
    user = self gameobjects::function_4e3386a8( sentient.team );
    self thread function_ef09febd( self.users[ user ].contributors, self.users[ user ].touching.players, "Capture", 0, 0, 0 );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1
// Checksum 0xebc8abe2, Offset: 0x1388
// Size: 0xac
function onupdateuserate( *sentient )
{
    var_beb65940 = self gameobjects::get_num_touching( game.attackers );
    var_d88c1173 = self gameobjects::get_num_touching( game.defenders );
    function_9fbbd002( self.objectiveid, var_beb65940, game.attackers );
    function_9fbbd002( self.objectiveid, var_d88c1173, game.defenders );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x4
// Checksum 0x54ab59f4, Offset: 0x1440
// Size: 0x64, Type: bool
function private is_zone_contested( gameobject )
{
    if ( gameobject gameobjects::get_num_touching( game.attackers ) > 0 && gameobject gameobjects::get_num_touching( game.defenders ) > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2
// Checksum 0xf95545d8, Offset: 0x14b0
// Size: 0x7a, Type: bool
function function_6f764775( zoneindex, team )
{
    if ( zoneindex == 0 && team == #"axis" )
    {
        return true;
    }
    
    if ( zoneindex == level.var_1b3b480b.size - 1 && team == #"allies" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 3, eflags: 0x4
// Checksum 0xad6846fe, Offset: 0x1538
// Size: 0xc6
function private function_7aa95c76( zone, dialog, team )
{
    if ( !isdefined( level.var_57e2bc08 ) )
    {
        return;
    }
    
    if ( !isdefined( zone.var_8ef53682[ team ][ dialog ] ) || zone.var_8ef53682[ team ][ dialog ] < gettime() )
    {
        globallogic_audio::leader_dialog( dialog, team, "zone" + zone.index, undefined, "war" );
        zone.var_8ef53682[ team ][ dialog ] = gettime() + int( 30 * 1000 );
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 5, eflags: 0x4
// Checksum 0x54cfd49d, Offset: 0x1608
// Size: 0x6c
function private function_7a4fcbfe( zone, var_b8522be2, team1, var_6f9b2d8c, team2 )
{
    function_7aa95c76( zone, var_b8522be2, team1 );
    
    if ( isdefined( var_6f9b2d8c ) && isdefined( team2 ) )
    {
        function_7aa95c76( zone, var_6f9b2d8c, team2 );
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 3
// Checksum 0xe350103f, Offset: 0x1680
// Size: 0x23c
function function_8df8131e( zone, team, progress )
{
    otherteam = util::getotherteam( team );
    
    if ( !isdefined( zone.var_42388c6f[ team ] ) && progress > 0.05 )
    {
        if ( function_6f764775( zone.index, team ) )
        {
            function_7a4fcbfe( zone, "warTakingFinal", team, "warLosingFinal", otherteam );
        }
        else
        {
            if ( zone.var_48550e00 == team )
            {
                var_ecdd36b6 = #"friendly";
                var_971743e7 = #"enemy";
            }
            else if ( zone.var_48550e00 == #"neutral" )
            {
                var_ecdd36b6 = #"neutral";
                var_971743e7 = #"neutral";
            }
            else
            {
                var_ecdd36b6 = #"enemy";
                var_971743e7 = #"friendly";
            }
            
            function_7a4fcbfe( zone, level.var_1845db12[ var_ecdd36b6 ].var_c8bc87ae, team, level.var_1845db12[ var_971743e7 ].losing, otherteam );
        }
        
        zone.var_42388c6f[ team ] = 1;
        return;
    }
    
    if ( function_6f764775( zone.index, team ) && progress > 0.5 && !isdefined( zone.var_4ebbe2f5 ) )
    {
        zone.var_4ebbe2f5 = 1;
        function_7a4fcbfe( zone, "warRoundEndNearWinningFinal", team, "warRoundEndNearLosingFinal", otherteam );
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 3
// Checksum 0xaabe9540, Offset: 0x18c8
// Size: 0xf4
function on_use_update( team, progress, *change )
{
    var_beb65940 = self gameobjects::get_num_touching( game.attackers );
    var_d88c1173 = self gameobjects::get_num_touching( game.defenders );
    function_8df8131e( self, progress, change );
    
    if ( progress == #"allies" )
    {
        objective_setgamemodeflags( self.objectiveid, 1 );
        return;
    }
    
    if ( progress == #"axis" )
    {
        objective_setgamemodeflags( self.objectiveid, 2 );
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2, eflags: 0x4
// Checksum 0x85a99837, Offset: 0x19c8
// Size: 0x50
function private function_d018d4fb( currentzoneindex, winningteam )
{
    if ( winningteam == #"allies" )
    {
        currentzoneindex++;
    }
    else if ( winningteam == #"axis" )
    {
        currentzoneindex--;
    }
    
    return currentzoneindex;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0, eflags: 0x4
// Checksum 0x6aca226f, Offset: 0x1a20
// Size: 0x52
function private function_582a1641()
{
    if ( overtime::is_overtime_round() && isdefined( level.var_30c0a631 ) )
    {
        return level.var_30c0a631;
    }
    
    return int( level.var_1b3b480b.size / 2 );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x4
// Checksum 0x8b49068f, Offset: 0x1a80
// Size: 0x140
function private deactivatezone( zoneindex )
{
    var_6b67c295 = level.var_1b3b480b[ zoneindex ];
    var_6b67c295 gameobjects::allow_use( #"group_none" );
    var_6b67c295 gameobjects::set_visible( #"group_none" );
    objective_setgamemodeflags( var_6b67c295.objectiveid, 3 );
    level clientfield::set( "war_zone", 5 );
    
    if ( isdefined( var_6b67c295.var_142ad58e ) )
    {
        foreach ( visual in var_6b67c295.var_142ad58e )
        {
            visual ghost();
        }
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2, eflags: 0x4
// Checksum 0x120aad19, Offset: 0x1bc8
// Size: 0x11c
function private function_a8049ffd( zoneindex, spawndelay )
{
    var_6b67c295 = level.var_1b3b480b[ zoneindex ];
    var_6b67c295 gameobjects::set_visible( #"group_all" );
    var_6b67c295 gameobjects::set_owner_team( #"neutral" );
    level.activezone = var_6b67c295;
    level clientfield::set( "war_zone", zoneindex );
    objective_setgamemodeflags( var_6b67c295.objectiveid, 3 );
    var_6b67c295.var_8ef53682 = [];
    var_6b67c295.var_8ef53682[ #"allies" ] = [];
    var_6b67c295.var_8ef53682[ #"axis" ] = [];
    var_6b67c295.var_42388c6f = [];
    function_98b8ad44( zoneindex, spawndelay );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2, eflags: 0x4
// Checksum 0x54fab81, Offset: 0x1cf0
// Size: 0x294
function private function_98b8ad44( zoneindex, waittimesec )
{
    var_6b67c295 = level.var_1b3b480b[ zoneindex ];
    timestarted = gettime();
    var_f5929597 = int( waittimesec * 1000 ) + timestarted;
    setbombtimer( "A", var_f5929597 );
    
    while ( gettime() < var_f5929597 )
    {
        wait waittimesec;
    }
    
    var_6b67c295 gameobjects::allow_use( #"group_enemy" );
    var_6b67c295 gameobjects::must_maintain_claim( 0 );
    var_6b67c295 gameobjects::can_contest_claim( 1 );
    objective_setgamemodeflags( var_6b67c295.objectiveid, 0 );
    objective_setprogress( var_6b67c295.objectiveid, 0 );
    
    if ( var_6b67c295.var_48550e00 == #"neutral" )
    {
        function_7a4fcbfe( var_6b67c295, "warZoneAvailable_WasNeutral", #"allies", "warZoneAvailable_WasNeutral", #"axis" );
    }
    else
    {
        otherteam = util::getotherteam( var_6b67c295.var_48550e00 );
        function_7a4fcbfe( var_6b67c295, "warZoneAvailable_WasFriendly", var_6b67c295.var_48550e00, "warZoneAvailable_WasEnemy", otherteam );
    }
    
    if ( isdefined( var_6b67c295.var_142ad58e ) )
    {
        foreach ( visual in var_6b67c295.var_142ad58e )
        {
            visual show();
        }
    }
    
    setbombtimer( "A", 0 );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0, eflags: 0x4
// Checksum 0xe40404ee, Offset: 0x1f90
// Size: 0x98
function private function_f04cf79a()
{
    foreach ( warzone in level.var_1b3b480b )
    {
        warzone gameobjects::allow_use( #"group_none" );
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x4
// Checksum 0x14de75da, Offset: 0x2030
// Size: 0x42
function private function_259770ba( *e_player )
{
    if ( spawning::usestartspawns() )
    {
        return undefined;
    }
    
    return function_b11bd4e4( level.activezone.index );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1, eflags: 0x4
// Checksum 0x902cafe6, Offset: 0x2080
// Size: 0xb2
function private function_b11bd4e4( var_f99d1b44 )
{
    switch ( var_f99d1b44 )
    {
        case 0:
            return "dom_a";
        case 1:
            return "dom_b";
        case 2:
            return "dom_c";
        case 3:
            return "dom_d";
        case 4:
            return "dom_e";
    }
    
    return "auto_normal";
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 0
// Checksum 0xbde30a6c, Offset: 0x2140
// Size: 0x7c
function ontimelimit()
{
    if ( overtime::is_overtime_round() )
    {
        round::set_winner( level.activezone gameobjects::function_14fccbd9() );
    }
    else
    {
        round::set_flag( "tie" );
    }
    
    thread globallogic::end_round( 2 );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 6
// Checksum 0xa89666f2, Offset: 0x21c8
// Size: 0x384
function function_ef09febd( var_1dbb2b2b, var_6d7ae157, string, var_24672ed6, var_81b74b24, neutralizing )
{
    time = gettime();
    waitframe( 1 );
    util::waittillslowprocessallowed();
    var_b4613aa2 = [];
    earliestplayer = undefined;
    
    foreach ( contribution in var_1dbb2b2b )
    {
        if ( isdefined( contribution ) )
        {
            contributor = contribution.player;
            
            if ( isdefined( contributor ) && isdefined( contribution.contribution ) )
            {
                percentage = 100 * contribution.contribution / self.usetime;
                contributor.var_759a143b = int( 0.5 + percentage );
                contributor.var_1aea8209 = contribution.starttime;
                
                if ( percentage < getgametypesetting( #"contributionmin" ) )
                {
                    continue;
                }
                
                if ( contribution.var_e22ea52b && ( !isdefined( earliestplayer ) || contributor.var_1aea8209 < earliestplayer.var_1aea8209 ) )
                {
                    earliestplayer = contributor;
                }
                
                if ( !isdefined( var_b4613aa2 ) )
                {
                    var_b4613aa2 = [];
                }
                else if ( !isarray( var_b4613aa2 ) )
                {
                    var_b4613aa2 = array( var_b4613aa2 );
                }
                
                var_b4613aa2[ var_b4613aa2.size ] = contributor;
            }
        }
    }
    
    foreach ( player in var_b4613aa2 )
    {
        var_a84f97bf = earliestplayer === player;
        var_af8f6146 = 0;
        
        foreach ( touch in var_6d7ae157 )
        {
            if ( !isdefined( touch ) )
            {
                continue;
            }
            
            if ( touch.player === player )
            {
                var_af8f6146 = 1;
                break;
            }
        }
        
        credit_player( player, string, var_24672ed6, var_81b74b24, neutralizing, time, var_a84f97bf, var_af8f6146 );
    }
    
    self gameobjects::function_bd47b0c7();
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 8
// Checksum 0x5c315da0, Offset: 0x2558
// Size: 0xbe
function credit_player( player, *string, *var_24672ed6, *var_81b74b24, *neutralizing, *time, *var_a84f97bf, *var_af8f6146 )
{
    var_af8f6146.pers[ #"objscore" ]++;
    var_af8f6146.objscore = var_af8f6146.pers[ #"objscore" ];
    var_af8f6146 luinotifyevent( #"waypoint_captured", 2, self.objectiveid, var_af8f6146.var_759a143b );
    var_af8f6146.var_759a143b = undefined;
}

