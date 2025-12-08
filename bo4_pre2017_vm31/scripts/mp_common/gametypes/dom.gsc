#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace dom;

// Namespace dom/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0xc19fb309, Offset: 0xe48
// Size: 0x58c
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 2000 );
    util::registerroundscorelimit( 0, 2000 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registerroundswitch( 0, 9 );
    util::registernumlives( 0, 100 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    level.scoreroundwinbased = getgametypesetting( "cumulativeRoundScores" ) == 0;
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onprecachegametype = &onprecachegametype;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    gameobjects::register_allowed_gameobject( level.gametype );
    globallogic_audio::set_leader_gametype_dialog( "startDomination", "hcStartDomination", "objCapture", "objCapture" );
    game.dialog[ "securing_a" ] = "domFriendlySecuringA";
    game.dialog[ "securing_b" ] = "domFriendlySecuringB";
    game.dialog[ "securing_c" ] = "domFriendlySecuringC";
    game.dialog[ "secured_a" ] = "domFriendlySecuredA";
    game.dialog[ "secured_b" ] = "domFriendlySecuredB";
    game.dialog[ "secured_c" ] = "domFriendlySecuredC";
    game.dialog[ "secured_all" ] = "domFriendlySecuredAll";
    game.dialog[ "losing_a" ] = "domEnemySecuringA";
    game.dialog[ "losing_b" ] = "domEnemySecuringB";
    game.dialog[ "losing_c" ] = "domEnemySecuringC";
    game.dialog[ "lost_a" ] = "domEnemySecuredA";
    game.dialog[ "lost_b" ] = "domEnemySecuredB";
    game.dialog[ "lost_c" ] = "domEnemySecuredC";
    game.dialog[ "lost_all" ] = "domEnemySecuredAll";
    game.dialog[ "enemy_a" ] = "domEnemyHasA";
    game.dialog[ "enemy_b" ] = "domEnemyHasB";
    game.dialog[ "enemy_c" ] = "domEnemyHasC";
    game.dialogtime = [];
    game.dialogtime[ "securing_a" ] = 0;
    game.dialogtime[ "securing_b" ] = 0;
    game.dialogtime[ "securing_c" ] = 0;
    game.dialogtime[ "losing_a" ] = 0;
    game.dialogtime[ "losing_b" ] = 0;
    game.dialogtime[ "losing_c" ] = 0;
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "score", "kills", "captures", "defends", "deaths" );
        return;
    }
    
    globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "captures", "defends" );
}

// Namespace dom/dom
// Params 0
// Checksum 0x80f724d1, Offset: 0x13e0
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace dom/dom
// Params 0
// Checksum 0x1cb9d9c9, Offset: 0x13f0
// Size: 0xe2
function function_cc0cf07a()
{
    foreach ( team in level.teams )
    {
        spawnteam = game.switchedsides ? util::getotherteam( team ) : team;
        spawning::add_start_spawn_points( spawnteam, "mp_dom_spawn_" + team + "_start" );
    }
}

// Namespace dom/dom
// Params 0
// Checksum 0x4811e834, Offset: 0x14e0
// Size: 0x3dc
function onstartgametype()
{
    util::setobjectivetext( "allies", &"OBJECTIVES_DOM" );
    util::setobjectivetext( "axis", &"OBJECTIVES_DOM" );
    level.usestartspawns = 1;
    globallogic_utils::switch_sides();
    
    if ( level.splitscreen )
    {
        util::setobjectivescoretext( "allies", &"OBJECTIVES_DOM" );
        util::setobjectivescoretext( "axis", &"OBJECTIVES_DOM" );
    }
    else
    {
        util::setobjectivescoretext( "allies", &"OBJECTIVES_DOM_SCORE" );
        util::setobjectivescoretext( "axis", &"OBJECTIVES_DOM_SCORE" );
    }
    
    util::setobjectivehinttext( "allies", &"OBJECTIVES_DOM_HINT" );
    util::setobjectivehinttext( "axis", &"OBJECTIVES_DOM_HINT" );
    level.flagbasefxid = [];
    setclientnamemode( "auto_change" );
    influencers::create_map_placed_influencers();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    spawning::place_spawn_points( "mp_dom_spawn_allies_start" );
    spawning::place_spawn_points( "mp_dom_spawn_axis_start" );
    function_cc0cf07a();
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.spawn_all = spawning::get_spawnpoint_array( "mp_dom_spawn" );
    flagspawns = spawning::get_spawnpoint_array( "mp_dom_spawn_flag_a" );
    level.startpos[ "allies" ] = level.spawn_start[ "allies" ][ 0 ].origin;
    level.startpos[ "axis" ] = level.spawn_start[ "axis" ][ 0 ].origin;
    
    if ( !util::isoneround() && level.scoreroundwinbased )
    {
        globallogic_score::resetteamscores();
    }
    
    level.spawnsystem.sideswitching = 0;
    level thread watchforbflagcap();
    updategametypedvars();
    thread domflags();
    thread updatedomscores();
    level function_25cda323();
}

// Namespace dom/dom
// Params 1
// Checksum 0x36074155, Offset: 0x18c8
// Size: 0xfe
function onendgame( winningteam )
{
    for ( i = 0; i < level.domflags.size ; i++ )
    {
        domflag = level.domflags[ i ];
        domflag gameobjects::allow_use( "none" );
        
        if ( isdefined( domflag.singleowner ) && domflag.singleowner == 1 )
        {
            team = domflag gameobjects::get_owner_team();
            label = domflag gameobjects::get_label();
            challenges::holdflagentirematch( team, label );
        }
    }
}

// Namespace dom/dom
// Params 1
// Checksum 0x8f7bc1b4, Offset: 0x19d0
// Size: 0xd2
function onroundendgame( roundwinner )
{
    if ( level.scoreroundwinbased )
    {
        foreach ( team in level.teams )
        {
            [[ level._setteamscore ]]( team, game.stat[ "roundswon" ][ team ] );
        }
    }
    
    return [[ level.determinewinner ]]();
}

// Namespace dom/dom
// Params 0
// Checksum 0x6938f911, Offset: 0x1ab0
// Size: 0xf0
function updategametypedvars()
{
    level.flagcapturetime = getgametypesetting( "captureTime" );
    level.playercapturelpm = getgametypesetting( "maxPlayerEventsPerMinute" );
    level.flagcapturelpm = getgametypesetting( "maxObjectiveEventsPerMinute" );
    level.playeroffensivemax = getgametypesetting( "maxPlayerOffensive" );
    level.playerdefensivemax = getgametypesetting( "maxPlayerDefensive" );
    level.flagcanbeneutralized = getgametypesetting( "flagCanBeNeutralized" );
}

// Namespace dom/dom
// Params 0
// Checksum 0x32611fbc, Offset: 0x1ba8
// Size: 0x83c
function domflags()
{
    level.laststatus[ "allies" ] = 0;
    level.laststatus[ "axis" ] = 0;
    level.flagmodel[ "allies" ] = "tag_origin";
    level.flagmodel[ "axis" ] = "tag_origin";
    level.flagmodel[ "neutral" ] = "tag_origin";
    primaryflags = getentarray( "flag_primary", "targetname" );
    
    if ( primaryflags.size < 2 )
    {
        println( "<dev string:x28>" );
        callback::abort_level();
        return;
    }
    
    level.flags = [];
    
    foreach ( dom_flag in primaryflags )
    {
        if ( isdefined( dom_flag.target ) )
        {
            trigger = getent( dom_flag.target, "targetname" );
            
            if ( isdefined( trigger ) )
            {
                trigger.visual = dom_flag;
                trigger.script_label = dom_flag.script_label;
            }
            else
            {
                /#
                    util::error( "<dev string:x56>" + dom_flag.script_label + "<dev string:x76>" + dom_flag.target );
                #/
            }
        }
        else
        {
            /#
                util::error( "<dev string:x56>" + dom_flag.script_label );
            #/
        }
        
        level.flags[ level.flags.size ] = trigger;
    }
    
    level.domflags = [];
    
    foreach ( trigger in level.flags )
    {
        trigger.visual setmodel( level.flagmodel[ "neutral" ] );
        name = istring( "dom" + trigger.visual.script_label );
        visuals = [];
        visuals[ 0 ] = trigger.visual;
        domflag = gameobjects::create_use_object( "neutral", trigger, visuals, ( 0, 0, 0 ), name );
        domflag gameobjects::allow_use( "enemy" );
        
        if ( level.flagcanbeneutralized )
        {
            domflag gameobjects::set_use_time( level.flagcapturetime / 2 );
        }
        else
        {
            domflag gameobjects::set_use_time( level.flagcapturetime );
        }
        
        domflag gameobjects::set_use_text( &"MP_CAPTURING_FLAG" );
        label = domflag gameobjects::get_label();
        domflag.label = label;
        domflag.flagindex = trigger.visual.script_index;
        domflag gameobjects::set_visible_team( "any" );
        domflag.onuse = &onuse;
        domflag.onbeginuse = &onbeginuse;
        domflag.onuseupdate = &onuseupdate;
        domflag.onenduse = &onenduse;
        domflag.onupdateuserate = &onupdateuserate;
        domflag.hasbeencaptured = 0;
        domflag gameobjects::set_objective_entity( visuals[ 0 ] );
        domflag gameobjects::set_owner_team( "neutral" );
        tracestart = visuals[ 0 ].origin + ( 0, 0, 32 );
        traceend = visuals[ 0 ].origin + ( 0, 0, -32 );
        trace = bullettrace( tracestart, traceend, 0, undefined );
        upangles = vectortoangles( trace[ "normal" ] );
        domflag.baseeffectforward = anglestoforward( upangles );
        domflag.baseeffectright = anglestoright( upangles );
        domflag.baseeffectpos = trace[ "position" ];
        trigger.useobj = domflag;
        trigger.adjflags = [];
        trigger.nearbyspawns = [];
        domflag.levelflag = trigger;
        level.domflags[ level.domflags.size ] = domflag;
    }
    
    level.bestspawnflag = [];
    level.bestspawnflag[ "allies" ] = getunownedflagneareststart( "allies", undefined );
    level.bestspawnflag[ "axis" ] = getunownedflagneareststart( "axis", level.bestspawnflag[ "allies" ] );
    
    for ( index = 0; index < level.domflags.size ; index++ )
    {
        level.domflags[ index ] createflagspawninfluencers();
    }
    
    flagsetup();
    
    /#
        thread domdebug();
    #/
}

// Namespace dom/dom
// Params 2
// Checksum 0x7799dd4e, Offset: 0x23f0
// Size: 0x136
function getunownedflagneareststart( team, excludeflag )
{
    best = undefined;
    bestdistsq = undefined;
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        flag = level.flags[ i ];
        
        if ( flag getflagteam() != "neutral" )
        {
            continue;
        }
        
        distsq = distancesquared( flag.origin, level.startpos[ team ] );
        
        if ( !isdefined( best ) || ( !isdefined( excludeflag ) || flag != excludeflag ) && distsq < bestdistsq )
        {
            bestdistsq = distsq;
            best = flag;
        }
    }
    
    return best;
}

/#

    // Namespace dom/dom
    // Params 0
    // Checksum 0x36061517, Offset: 0x2530
    // Size: 0x2b4, Type: dev
    function domdebug()
    {
        while ( true )
        {
            if ( getdvarstring( "<dev string:x88>" ) != "<dev string:x95>" )
            {
                wait 2;
                continue;
            }
            
            while ( true )
            {
                if ( getdvarstring( "<dev string:x88>" ) != "<dev string:x95>" )
                {
                    break;
                }
                
                for ( i = 0; i < level.flags.size ; i++ )
                {
                    for ( j = 0; j < level.flags[ i ].adjflags.size ; j++ )
                    {
                        line( level.flags[ i ].origin, level.flags[ i ].adjflags[ j ].origin, ( 1, 1, 1 ) );
                    }
                    
                    for ( j = 0; j < level.flags[ i ].nearbyspawns.size ; j++ )
                    {
                        line( level.flags[ i ].origin, level.flags[ i ].nearbyspawns[ j ].origin, ( 0.2, 0.2, 0.6 ) );
                    }
                    
                    if ( level.flags[ i ] == level.bestspawnflag[ "<dev string:x97>" ] )
                    {
                        print3d( level.flags[ i ].origin, "<dev string:x9e>" );
                    }
                    
                    if ( level.flags[ i ] == level.bestspawnflag[ "<dev string:xb5>" ] )
                    {
                        print3d( level.flags[ i ].origin, "<dev string:xba>" );
                    }
                }
                
                waitframe( 1 );
            }
        }
    }

#/

// Namespace dom/dom
// Params 1
// Checksum 0x36b77fa4, Offset: 0x27f0
// Size: 0xfe
function onbeginuse( player )
{
    ownerteam = self gameobjects::get_owner_team();
    self.didstatusnotify = 0;
    
    if ( ownerteam == "allies" )
    {
        otherteam = "axis";
    }
    else
    {
        otherteam = "allies";
    }
    
    if ( ownerteam == "neutral" )
    {
        otherteam = util::getotherteam( player.pers[ "team" ] );
        statusdialog( "securing" + self.label, player.pers[ "team" ], "objective" + self.label );
        return;
    }
}

// Namespace dom/dom
// Params 3
// Checksum 0x4befd3fb, Offset: 0x28f8
// Size: 0x174
function onuseupdate( team, progress, change )
{
    if ( progress > 0.05 && change && !self.didstatusnotify )
    {
        ownerteam = self gameobjects::get_owner_team();
        
        if ( ownerteam == "neutral" )
        {
            otherteam = util::getotherteam( team );
            statusdialog( "securing" + self.label, team, "objective" + self.label );
        }
        else
        {
            statusdialog( "losing" + self.label, ownerteam, "objective" + self.label );
            statusdialog( "securing" + self.label, team, "objective" + self.label );
            globallogic_audio::flush_objective_dialog( "objective_all" );
        }
        
        self.didstatusnotify = 1;
    }
}

// Namespace dom/dom
// Params 0
// Checksum 0xc285f121, Offset: 0x2a78
// Size: 0x4c
function flushobjectiveflagdialog()
{
    globallogic_audio::flush_objective_dialog( "objective_a" );
    globallogic_audio::flush_objective_dialog( "objective_b" );
    globallogic_audio::flush_objective_dialog( "objective_c" );
}

// Namespace dom/dom
// Params 3
// Checksum 0xd3d59671, Offset: 0x2ad0
// Size: 0xf4
function statusdialog( dialog, team, objectivekey )
{
    dialogtime = game.dialogtime[ dialog ];
    
    if ( isdefined( dialogtime ) )
    {
        time = gettime();
        
        if ( dialogtime > time )
        {
            return;
        }
        
        game.dialogtime[ dialog ] = time + 10000;
    }
    
    dialogkey = game.dialog[ dialog ];
    
    if ( isdefined( objectivekey ) )
    {
        if ( objectivekey != "objective_all" )
        {
            dialogbufferkey = "domPointDialogBuffer";
        }
    }
    
    globallogic_audio::leader_dialog( dialogkey, team, undefined, objectivekey, undefined, dialogbufferkey );
}

// Namespace dom/dom
// Params 3
// Checksum 0x2ee00de9, Offset: 0x2bd0
// Size: 0x4c
function onenduse( team, player, success )
{
    if ( !success )
    {
        globallogic_audio::flush_objective_dialog( "objective" + self.label );
    }
}

// Namespace dom/dom
// Params 1
// Checksum 0xa02bf03a, Offset: 0x2c28
// Size: 0x1fc
function flagcapturedfromneutral( team )
{
    self.singleowner = 1;
    otherteam = util::getotherteam( team );
    thread util::printandsoundoneveryone( team, undefined, &"", undefined, "mp_war_objective_taken" );
    thread sound::play_on_players( "mus_dom_captured" + "_" + level.teampostfix[ team ] );
    
    if ( getteamflagcount( team ) == level.flags.size )
    {
        statusdialog( "secured_all", team, "objective_all" );
        statusdialog( "lost_all", otherteam, "objective_all" );
        flushobjectiveflagdialog();
        return;
    }
    
    statusdialog( "secured" + self.label, team, "objective" + self.label );
    statusdialog( "enemy" + self.label, otherteam, "objective" + self.label );
    globallogic_audio::flush_objective_dialog( "objective_all" );
    globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_enemy", otherteam );
    globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_friend", team );
}

// Namespace dom/dom
// Params 2
// Checksum 0x3ffb6f72, Offset: 0x2e30
// Size: 0x232
function flagcapturedfromteam( team, oldteam )
{
    self.singleowner = 0;
    thread util::printandsoundoneveryone( team, oldteam, &"", &"", "mp_war_objective_taken", "mp_war_objective_lost", "" );
    
    if ( getteamflagcount( team ) == level.flags.size )
    {
        statusdialog( "secured_all", team, "objective_all" );
        statusdialog( "lost_all", oldteam, "objective_all" );
        flushobjectiveflagdialog();
    }
    else
    {
        statusdialog( "secured" + self.label, team, "objective" + self.label );
        
        if ( randomint( 2 ) )
        {
            statusdialog( "lost" + self.label, oldteam, "objective" + self.label );
        }
        else
        {
            statusdialog( "enemy" + self.label, oldteam, "objective" + self.label );
        }
        
        globallogic_audio::flush_objective_dialog( "objective_all" );
        globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_enemy", oldteam );
        globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_friend", team );
    }
    
    level.bestspawnflag[ oldteam ] = self.levelflag;
}

// Namespace dom/dom
// Params 2
// Checksum 0x11af77cb, Offset: 0x3070
// Size: 0x144
function flagneutralized( team, oldteam )
{
    self.singleowner = 1;
    thread util::printandsoundoneveryone( "neutral", oldteam, &"", &"", "mp_war_objective_neutralized", "mp_war_objective_lost", "" );
    
    if ( getteamflagcount( team ) == level.flags.size )
    {
        statusdialog( "lost_all", oldteam, "objective_all" );
        flushobjectiveflagdialog();
        return;
    }
    
    statusdialog( "lost" + self.label, oldteam, "objective" + self.label );
    globallogic_audio::flush_objective_dialog( "objective_all" );
    globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_enemy", oldteam );
}

// Namespace dom/dom
// Params 2
// Checksum 0xcc9e045c, Offset: 0x31c0
// Size: 0x166
function getdomflagusestring( label, neutralized )
{
    string = &"";
    
    if ( neutralized )
    {
        switch ( label )
        {
            case #"_a":
                string = &"MP_DOM_FLAG_A_NEUTRALIZED_BY";
                break;
            case #"_b":
                string = &"MP_DOM_FLAG_B_NEUTRALIZED_BY";
                break;
            case #"_c":
                string = &"MP_DOM_FLAG_C_NEUTRALIZED_BY";
                break;
            case #"_d":
                string = &"MP_DOM_FLAG_D_NEUTRALIZED_BY";
                break;
            case #"_e":
                string = &"MP_DOM_FLAG_E_NEUTRALIZED_BY";
                break;
            default:
                break;
        }
    }
    else
    {
        switch ( label )
        {
            case #"_a":
                string = &"MP_DOM_FLAG_A_CAPTURED_BY";
                break;
            case #"_b":
                string = &"MP_DOM_FLAG_B_CAPTURED_BY";
                break;
            case #"_c":
                string = &"MP_DOM_FLAG_C_CAPTURED_BY";
                break;
            case #"_d":
                string = &"MP_DOM_FLAG_D_CAPTURED_BY";
                break;
            case #"_e":
                string = &"MP_DOM_FLAG_E_CAPTURED_BY";
                break;
            default:
                break;
        }
    }
    
    return string;
}

// Namespace dom/dom
// Params 1
// Checksum 0x57435c0b, Offset: 0x3330
// Size: 0x4a4
function onusewithneutralizingflag( player )
{
    team = player.pers[ "team" ];
    oldteam = self gameobjects::get_owner_team();
    label = self gameobjects::get_label();
    
    /#
        print( "<dev string:xcf>" + self.label );
    #/
    
    level.usestartspawns = 0;
    assert( team != "<dev string:xdf>" );
    string = &"";
    
    if ( oldteam == "neutral" )
    {
        level notify( #"flag_captured" );
        string = getdomflagusestring( label, 0 );
        level.bestspawnflag[ oldteam ] = self.levelflag;
        self gameobjects::set_owner_team( team );
        self.visuals[ 0 ] setmodel( level.flagmodel[ team ] );
        setdvar( "scr_obj" + self gameobjects::get_label(), team );
        self update_spawn_influencers( team );
        self flagcapturedfromneutral( team );
    }
    else
    {
        level notify( #"flag_neutralized" );
        string = getdomflagusestring( label, 1 );
        self gameobjects::set_owner_team( "neutral" );
        self.visuals[ 0 ] setmodel( level.flagmodel[ "neutral" ] );
        setdvar( "scr_obj" + self gameobjects::get_label(), "neutral" );
        self update_spawn_influencers( "neutral" );
        self flagneutralized( team, oldteam );
    }
    
    assert( string != &"<dev string:xe7>" );
    touchlist = [];
    touchkeys = getarraykeys( self.touchlist[ team ] );
    
    for ( i = 0; i < touchkeys.size ; i++ )
    {
        touchlist[ touchkeys[ i ] ] = self.touchlist[ team ][ touchkeys[ i ] ];
    }
    
    isbflag = 0;
    
    if ( label == "_b" )
    {
        isbflag = 1;
    }
    
    if ( oldteam == "neutral" )
    {
        thread give_capture_credit( touchlist, string, oldteam, isbflag, 1 );
    }
    else
    {
        thread give_neutralized_credit( touchlist, string, oldteam, isbflag );
    }
    
    bbprint( "mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "dom_capture", label, team, player.origin );
    
    if ( dominated_challenge_check() )
    {
        level thread totaldomination( team );
    }
}

// Namespace dom/dom
// Params 1
// Checksum 0xc373a2a2, Offset: 0x37e0
// Size: 0x354
function onusewithoutneutralizingflag( player )
{
    level notify( #"flag_captured" );
    team = player.pers[ "team" ];
    oldteam = self gameobjects::get_owner_team();
    label = self gameobjects::get_label();
    
    /#
        print( "<dev string:xcf>" + self.label );
    #/
    
    self gameobjects::set_owner_team( team );
    self.visuals[ 0 ] setmodel( level.flagmodel[ team ] );
    setdvar( "scr_obj" + self gameobjects::get_label(), team );
    level.usestartspawns = 0;
    assert( team != "<dev string:xdf>" );
    isbflag = 0;
    
    if ( label == "_b" )
    {
        isbflag = 1;
    }
    
    string = getdomflagusestring( label, 0 );
    assert( string != &"<dev string:xe7>" );
    touchlist = [];
    touchkeys = getarraykeys( self.touchlist[ team ] );
    
    for ( i = 0; i < touchkeys.size ; i++ )
    {
        touchlist[ touchkeys[ i ] ] = self.touchlist[ team ][ touchkeys[ i ] ];
    }
    
    thread give_capture_credit( touchlist, string, oldteam, isbflag, 0 );
    bbprint( "mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "dom_capture", label, team, player.origin );
    
    if ( oldteam == "neutral" )
    {
        self flagcapturedfromneutral( team );
    }
    else
    {
        self flagcapturedfromteam( team, oldteam );
    }
    
    if ( dominated_challenge_check() )
    {
        level thread totaldomination( team );
    }
    
    self update_spawn_influencers( team );
}

// Namespace dom/dom
// Params 1
// Checksum 0xe9362c7d, Offset: 0x3b40
// Size: 0x6c
function onuse( player )
{
    if ( level.flagcanbeneutralized )
    {
        self onusewithneutralizingflag( player );
    }
    else
    {
        self onusewithoutneutralizingflag( player );
    }
    
    level function_25cda323();
}

// Namespace dom/dom
// Params 1
// Checksum 0xe33d0191, Offset: 0x3bb8
// Size: 0x44
function totaldomination( team )
{
    level endon( #"flag_captured" );
    level endon( #"game_ended" );
    wait 180;
    challenges::totaldomination( team );
}

// Namespace dom/dom
// Params 0
// Checksum 0x6b8e4530, Offset: 0x3c08
// Size: 0x78
function watchforbflagcap()
{
    level endon( #"game_ended" );
    level endon( #"endwatchforbflagcapaftertime" );
    level thread endwatchforbflagcapaftertime( 60 );
    
    for ( ;; )
    {
        waitresult = level waittill( "b_flag_captured" );
        waitresult.player challenges::capturedbfirstminute();
    }
}

// Namespace dom/dom
// Params 1
// Checksum 0x2e08ebf5, Offset: 0x3c88
// Size: 0x30
function endwatchforbflagcapaftertime( time )
{
    level endon( #"game_ended" );
    wait 60;
    level notify( #"endwatchforbflagcapaftertime" );
}

// Namespace dom/dom
// Params 5
// Checksum 0xd831570f, Offset: 0x3cc0
// Size: 0x336
function give_capture_credit( touchlist, string, lastownerteam, isbflag, neutralizing )
{
    time = gettime();
    waitframe( 1 );
    util::waittillslowprocessallowed();
    self updatecapsperminute( lastownerteam );
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player_from_touchlist = touchlist[ players[ i ] ].player;
        player_from_touchlist updatecapsperminute( lastownerteam );
        
        if ( !isscoreboosting( player_from_touchlist, self ) )
        {
            player_from_touchlist challenges::capturedobjective( time, self.levelflag );
            
            if ( isdefined( self.hasbeencaptured ) && lastownerteam == "neutral" && neutralizing && self.hasbeencaptured )
            {
                scoreevents::processscoreevent( "dom_point_secured_neutralizing", player_from_touchlist );
            }
            else if ( lastownerteam == "neutral" )
            {
                if ( isbflag )
                {
                    scoreevents::processscoreevent( "dom_point_neutral_b_secured", player_from_touchlist );
                }
                else
                {
                    scoreevents::processscoreevent( "dom_point_neutral_secured", player_from_touchlist );
                }
            }
            else
            {
                scoreevents::processscoreevent( "dom_point_secured", player_from_touchlist );
            }
            
            self.hasbeencaptured = 1;
            player_from_touchlist recordgameevent( "capture" );
            
            if ( isbflag )
            {
                level notify( #"b_flag_captured", { #player:player_from_touchlist } );
            }
            
            if ( isdefined( player_from_touchlist.pers[ "captures" ] ) )
            {
                player_from_touchlist.pers[ "captures" ]++;
                player_from_touchlist.captures = player_from_touchlist.pers[ "captures" ];
            }
            
            demo::bookmark( "event", gettime(), player_from_touchlist );
            player_from_touchlist addplayerstatwithgametype( "CAPTURES", 1 );
        }
        else
        {
            /#
                player_from_touchlist iprintlnbold( "<dev string:xe8>" );
            #/
        }
        
        level thread popups::displayteammessagetoall( string, player_from_touchlist );
    }
}

// Namespace dom/dom
// Params 4
// Checksum 0x544c4a1e, Offset: 0x4000
// Size: 0x1f6
function give_neutralized_credit( touchlist, string, lastownerteam, isbflag )
{
    time = gettime();
    waitframe( 1 );
    util::waittillslowprocessallowed();
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player_from_touchlist = touchlist[ players[ i ] ].player;
        player_from_touchlist updatecapsperminute( lastownerteam );
        
        if ( !isscoreboosting( player_from_touchlist, self ) )
        {
            scoreevents::processscoreevent( "dom_point_neutralized_neutralizing", player_from_touchlist );
            player_from_touchlist recordgameevent( "neutralized" );
            
            if ( isdefined( player_from_touchlist.pers[ "neutralizes" ] ) )
            {
                player_from_touchlist.pers[ "neutralizes" ]++;
                player_from_touchlist.captures = player_from_touchlist.pers[ "neutralizes" ];
            }
            
            demo::bookmark( "event", gettime(), player_from_touchlist );
        }
        else
        {
            /#
                player_from_touchlist iprintlnbold( "<dev string:xe8>" );
            #/
        }
        
        level thread popups::displayteammessagetoall( string, player_from_touchlist );
    }
}

// Namespace dom/dom
// Params 0
// Checksum 0x48acc0b8, Offset: 0x4200
// Size: 0x568
function updatedomscores()
{
    if ( level.roundscorelimit && !level.timelimit )
    {
        warningscore = max( 0, level.roundscorelimit - 12 );
    }
    else
    {
        warningscore = 0;
    }
    
    playednearendvo = 0;
    alliesroundstartscore = [[ level._getteamscore ]]( "allies" );
    axisroundstartscore = [[ level._getteamscore ]]( "axis" );
    
    while ( !level.gameended )
    {
        numownedflags = 0;
        scoring_teams = [];
        round_score_limit = util::get_current_round_score_limit();
        totalflags = getteamflagcount( "allies" ) + getteamflagcount( "axis" );
        
        if ( totalflags == 3 && game.stat[ "teamScores" ][ "allies" ] == round_score_limit - 1 && game.stat[ "teamScores" ][ "axis" ] == round_score_limit - 1 )
        {
            level.clampscorelimit = 0;
        }
        
        numflags = getteamflagcount( "allies" );
        numownedflags += numflags;
        
        if ( numflags )
        {
            scoring_teams[ scoring_teams.size ] = "allies";
            globallogic_score::giveteamscoreforobjective_delaypostprocessing( "allies", numflags );
        }
        
        numflags = getteamflagcount( "axis" );
        numownedflags += numflags;
        
        if ( numflags )
        {
            scoring_teams[ scoring_teams.size ] = "axis";
            globallogic_score::giveteamscoreforobjective_delaypostprocessing( "axis", numflags );
        }
        
        if ( numownedflags )
        {
            globallogic_score::postprocessteamscores( scoring_teams );
        }
        
        if ( warningscore && !playednearendvo )
        {
            winningteam = undefined;
            alliesroundscore = [[ level._getteamscore ]]( "allies" ) - alliesroundstartscore;
            axisroundscore = [[ level._getteamscore ]]( "axis" ) - axisroundstartscore;
            
            if ( alliesroundscore >= warningscore )
            {
                winningteam = "allies";
            }
            else if ( axisroundscore >= warningscore )
            {
                winningteam = "axis";
            }
            
            if ( isdefined( winningteam ) )
            {
                nearwinning = "nearWinning";
                nearlosing = "nearLosing";
                
                if ( util::isoneround() || util::islastround() )
                {
                    nearwinning = "nearWinningFinal";
                    nearlosing = "nearLosingFinal";
                }
                else
                {
                    if ( randomint( 4 ) < 3 )
                    {
                        nearwinning = "nearWinningFinal";
                    }
                    
                    if ( randomint( 4 ) < 1 )
                    {
                        nearlosing = "nearLosingFinal";
                    }
                }
                
                globallogic_audio::leader_dialog( nearwinning, winningteam );
                globallogic_audio::leader_dialog_for_other_teams( nearlosing, winningteam );
                playednearendvo = 1;
            }
        }
        
        onscoreclosemusic();
        timepassed = globallogic_utils::gettimepassed();
        
        if ( timepassed / 1000 > 300 && ( timepassed / 1000 > 120 && numownedflags < 2 || numownedflags < 3 ) && gamemodeismode( 0 ) )
        {
            thread globallogic::endgame( "tie", game.strings[ "time_limit_reached" ] );
            return;
        }
        
        wait 5;
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace dom/dom
// Params 0
// Checksum 0xaff983ae, Offset: 0x4770
// Size: 0x374
function onscoreclosemusic()
{
    axisscore = [[ level._getteamscore ]]( "axis" );
    alliedscore = [[ level._getteamscore ]]( "allies" );
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.1;
    scoredif = abs( axisscore - alliedscore );
    scorethresholdstart = abs( scorelimit - scorethreshold );
    scorelimitcheck = scorelimit - 10;
    
    if ( !isdefined( level.playingactionmusic ) )
    {
        level.playingactionmusic = 0;
    }
    
    if ( !isdefined( level.sndhalfway ) )
    {
        level.sndhalfway = 0;
    }
    
    if ( alliedscore > axisscore )
    {
        currentscore = alliedscore;
    }
    else
    {
        currentscore = axisscore;
    }
    
    /#
        if ( getdvarint( "<dev string:x12d>" ) > 0 )
        {
            println( "<dev string:x139>" + scoredif );
            println( "<dev string:x15d>" + axisscore );
            println( "<dev string:x182>" + alliedscore );
            println( "<dev string:x1a9>" + scorelimit );
            println( "<dev string:x1cf>" + currentscore );
            println( "<dev string:x1f7>" + scorethreshold );
            println( "<dev string:x139>" + scoredif );
            println( "<dev string:x221>" + scorethresholdstart );
        }
    #/
    
    if ( scoredif <= scorethreshold && scorethresholdstart <= currentscore && level.playingactionmusic != 1 )
    {
    }
    
    halfwayscore = scorelimit * 0.5;
    
    if ( isdefined( level.roundscorelimit ) )
    {
        halfwayscore = level.roundscorelimit * 0.5;
        
        if ( game.roundsplayed == 1 )
        {
            halfwayscore += level.roundscorelimit;
        }
    }
    
    if ( ( axisscore >= halfwayscore || alliedscore >= halfwayscore ) && !level.sndhalfway )
    {
        level notify( #"sndmusichalfway" );
        level.sndhalfway = 1;
    }
}

// Namespace dom/dom
// Params 0
// Checksum 0x8926aba7, Offset: 0x4af0
// Size: 0xc0
function onroundswitch()
{
    if ( !isdefined( game.switchedsides ) )
    {
        game.switchedsides = 0;
    }
    
    game.switchedsides = !game.switchedsides;
    
    if ( level.scoreroundwinbased )
    {
        [[ level._setteamscore ]]( "allies", game.stat[ "roundswon" ][ "allies" ] );
        [[ level._setteamscore ]]( "axis", game.stat[ "roundswon" ][ "axis" ] );
    }
}

// Namespace dom/dom
// Params 9
// Checksum 0x295e92c6, Offset: 0x4bb8
// Size: 0x79c
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        scoreeventprocessed = 0;
        
        if ( attacker.touchtriggers.size && attacker.pers[ "team" ] != self.pers[ "team" ] )
        {
            triggerids = getarraykeys( attacker.touchtriggers );
            ownerteam = attacker.touchtriggers[ triggerids[ 0 ] ].useobj.ownerteam;
            team = attacker.pers[ "team" ];
            
            if ( team != ownerteam )
            {
                scoreevents::processscoreevent( "kill_enemy_while_capping_dom", attacker, undefined, weapon );
                scoreeventprocessed = 1;
            }
        }
        
        for ( index = 0; index < level.flags.size ; index++ )
        {
            flagteam = "invalidTeam";
            inflagzone = 0;
            defendedflag = 0;
            offendedflag = 0;
            flagorigin = level.flags[ index ].origin;
            offenseradiussq = 90000;
            dist = distance2dsquared( self.origin, flagorigin );
            
            if ( dist < offenseradiussq )
            {
                inflagzone = 1;
                
                if ( level.flags[ index ] getflagteam() == attacker.pers[ "team" ] || level.flags[ index ] getflagteam() == "neutral" )
                {
                    defendedflag = 1;
                }
                else
                {
                    offendedflag = 1;
                }
            }
            
            dist = distance2dsquared( attacker.origin, flagorigin );
            
            if ( dist < offenseradiussq )
            {
                inflagzone = 1;
                
                if ( level.flags[ index ] getflagteam() == attacker.pers[ "team" ] || level.flags[ index ] getflagteam() == "neutral" )
                {
                    defendedflag = 1;
                }
                else
                {
                    offendedflag = 1;
                }
            }
            
            if ( inflagzone && isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] )
            {
                if ( offendedflag )
                {
                    if ( !isdefined( attacker.dom_defends ) )
                    {
                        attacker.dom_defends = 0;
                    }
                    
                    attacker.dom_defends++;
                    
                    if ( level.playerdefensivemax >= attacker.dom_defends )
                    {
                        attacker thread challenges::killedbasedefender( level.flags[ index ] );
                        
                        if ( !scoreeventprocessed )
                        {
                            scoreevents::processscoreevent( "killed_defender", attacker, undefined, weapon );
                        }
                        
                        self recordkillmodifier( "defending" );
                        break;
                    }
                    else
                    {
                        /#
                            attacker iprintlnbold( "<dev string:x250>" );
                        #/
                    }
                }
                
                if ( defendedflag )
                {
                    if ( !isdefined( attacker.dom_offends ) )
                    {
                        attacker.dom_offends = 0;
                    }
                    
                    attacker thread updateattackermultikills();
                    attacker.dom_offends++;
                    
                    if ( level.playeroffensivemax >= attacker.dom_offends )
                    {
                        attacker.pers[ "defends" ]++;
                        attacker.defends = attacker.pers[ "defends" ];
                        attacker thread challenges::killedbaseoffender( level.flags[ index ], weapon );
                        attacker recordgameevent( "return" );
                        attacker challenges::killedzoneattacker( weapon );
                        
                        if ( !scoreeventprocessed )
                        {
                            scoreevents::processscoreevent( "killed_attacker", attacker, undefined, weapon );
                        }
                        
                        self recordkillmodifier( "assaulting" );
                        break;
                    }
                    
                    /#
                        attacker iprintlnbold( "<dev string:x297>" );
                    #/
                }
            }
        }
        
        if ( self.touchtriggers.size && attacker.pers[ "team" ] != self.pers[ "team" ] )
        {
            triggerids = getarraykeys( self.touchtriggers );
            ownerteam = self.touchtriggers[ triggerids[ 0 ] ].useobj.ownerteam;
            team = self.pers[ "team" ];
            
            if ( team != ownerteam )
            {
                flag = self.touchtriggers[ triggerids[ 0 ] ].useobj;
                
                if ( isdefined( flag.contested ) && flag.contested == 1 )
                {
                    attacker killwhilecontesting( flag );
                }
            }
        }
    }
}

// Namespace dom/dom
// Params 1
// Checksum 0x2b108f1, Offset: 0x5360
// Size: 0x170
function killwhilecontesting( flag )
{
    self notify( #"killwhilecontesting" );
    self endon( #"killwhilecontesting" );
    self endon( #"disconnect" );
    killtime = gettime();
    playerteam = self.pers[ "team" ];
    
    if ( !isdefined( self.clearenemycount ) )
    {
        self.clearenemycount = 0;
    }
    
    self.clearenemycount++;
    flag waittill( "contest_over" );
    
    if ( isdefined( self.spawntime ) && ( playerteam != self.pers[ "team" ] || killtime < self.spawntime ) )
    {
        self.clearenemycount = 0;
        return;
    }
    
    if ( flag.ownerteam != playerteam && flag.ownerteam != "neutral" )
    {
        self.clearenemycount = 0;
        return;
    }
    
    if ( self.clearenemycount >= 2 && killtime + 200 > gettime() )
    {
        scoreevents::processscoreevent( "clear_2_attackers", self );
    }
    
    self.clearenemycount = 0;
}

// Namespace dom/dom
// Params 0
// Checksum 0xd8f7cf6a, Offset: 0x54d8
// Size: 0xa8
function updateattackermultikills()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"updatedomrecentkills" );
    self endon( #"updatedomrecentkills" );
    
    if ( !isdefined( self.recentdomattackerkillcount ) )
    {
        self.recentdomattackerkillcount = 0;
    }
    
    self.recentdomattackerkillcount++;
    wait 4;
    
    if ( self.recentdomattackerkillcount > 1 )
    {
        self challenges::domattackermultikill( self.recentdomattackerkillcount );
    }
    
    self.recentdomattackerkillcount = 0;
}

// Namespace dom/dom
// Params 1
// Checksum 0x2815f28b, Offset: 0x5588
// Size: 0x80
function getteamflagcount( team )
{
    score = 0;
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        if ( level.domflags[ i ] gameobjects::get_owner_team() == team )
        {
            score++;
        }
    }
    
    return score;
}

// Namespace dom/dom
// Params 0
// Checksum 0xd32e954c, Offset: 0x5610
// Size: 0x1a
function getflagteam()
{
    return self.useobj gameobjects::get_owner_team();
}

// Namespace dom/dom
// Params 0
// Checksum 0xd398f225, Offset: 0x5638
// Size: 0x112
function getboundaryflags()
{
    bflags = [];
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        for ( j = 0; j < level.flags[ i ].adjflags.size ; j++ )
        {
            if ( level.flags[ i ].useobj gameobjects::get_owner_team() != level.flags[ i ].adjflags[ j ].useobj gameobjects::get_owner_team() )
            {
                bflags[ bflags.size ] = level.flags[ i ];
                break;
            }
        }
    }
    
    return bflags;
}

// Namespace dom/dom
// Params 1
// Checksum 0xe560e9f9, Offset: 0x5758
// Size: 0xf6
function getboundaryflagspawns( team )
{
    spawns = [];
    bflags = getboundaryflags();
    
    for ( i = 0; i < bflags.size ; i++ )
    {
        if ( isdefined( team ) && bflags[ i ] getflagteam() != team )
        {
            continue;
        }
        
        for ( j = 0; j < bflags[ i ].nearbyspawns.size ; j++ )
        {
            spawns[ spawns.size ] = bflags[ i ].nearbyspawns[ j ];
        }
    }
    
    return spawns;
}

// Namespace dom/dom
// Params 1
// Checksum 0x985f3d5b, Offset: 0x5858
// Size: 0x146
function getspawnsboundingflag( avoidflag )
{
    spawns = [];
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        flag = level.flags[ i ];
        
        if ( flag == avoidflag )
        {
            continue;
        }
        
        isbounding = 0;
        
        for ( j = 0; j < flag.adjflags.size ; j++ )
        {
            if ( flag.adjflags[ j ] == avoidflag )
            {
                isbounding = 1;
                break;
            }
        }
        
        if ( !isbounding )
        {
            continue;
        }
        
        for ( j = 0; j < flag.nearbyspawns.size ; j++ )
        {
            spawns[ spawns.size ] = flag.nearbyspawns[ j ];
        }
    }
    
    return spawns;
}

// Namespace dom/dom
// Params 1
// Checksum 0xe63437e7, Offset: 0x59a8
// Size: 0x1d8
function getownedandboundingflagspawns( team )
{
    spawns = [];
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        if ( level.flags[ i ] getflagteam() == team )
        {
            for ( s = 0; s < level.flags[ i ].nearbyspawns.size ; s++ )
            {
                spawns[ spawns.size ] = level.flags[ i ].nearbyspawns[ s ];
            }
            
            continue;
        }
        
        for ( j = 0; j < level.flags[ i ].adjflags.size ; j++ )
        {
            if ( level.flags[ i ].adjflags[ j ] getflagteam() == team )
            {
                for ( s = 0; s < level.flags[ i ].nearbyspawns.size ; s++ )
                {
                    spawns[ spawns.size ] = level.flags[ i ].nearbyspawns[ s ];
                }
                
                break;
            }
        }
    }
    
    return spawns;
}

// Namespace dom/dom
// Params 1
// Checksum 0xb9675f91, Offset: 0x5b88
// Size: 0xea
function getownedflagspawns( team )
{
    spawns = [];
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        if ( level.flags[ i ] getflagteam() == team )
        {
            for ( s = 0; s < level.flags[ i ].nearbyspawns.size ; s++ )
            {
                spawns[ spawns.size ] = level.flags[ i ].nearbyspawns[ s ];
            }
        }
    }
    
    return spawns;
}

// Namespace dom/dom
// Params 0
// Checksum 0x56a75987, Offset: 0x5c80
// Size: 0x63a
function flagsetup()
{
    descriptorsbylinkname = [];
    descriptors = getentarray( "flag_descriptor", "targetname" );
    flags = level.flags;
    
    for ( i = 0; i < level.domflags.size ; i++ )
    {
        closestdist = undefined;
        closestdesc = undefined;
        
        for ( j = 0; j < descriptors.size ; j++ )
        {
            dist = distance( flags[ i ].origin, descriptors[ j ].origin );
            
            if ( !isdefined( closestdist ) || dist < closestdist )
            {
                closestdist = dist;
                closestdesc = descriptors[ j ];
            }
        }
        
        if ( !isdefined( closestdesc ) )
        {
            globallogic_utils::add_map_error( "there is no flag_descriptor in the map! see explanation in dom.gsc" );
            break;
        }
        
        if ( isdefined( closestdesc.flag ) )
        {
            globallogic_utils::add_map_error( "flag_descriptor with script_linkname \"" + closestdesc.script_linkname + "\" is nearby more than one flag; is there a unique descriptor near each flag?" );
            continue;
        }
        
        flags[ i ].descriptor = closestdesc;
        closestdesc.flag = flags[ i ];
        descriptorsbylinkname[ closestdesc.script_linkname ] = closestdesc;
    }
    
    if ( !isdefined( level.maperrors ) || level.maperrors.size == 0 )
    {
        for ( i = 0; i < flags.size ; i++ )
        {
            if ( isdefined( flags[ i ].descriptor.script_linkto ) )
            {
                adjdescs = strtok( flags[ i ].descriptor.script_linkto, " " );
            }
            else
            {
                adjdescs = [];
            }
            
            for ( j = 0; j < adjdescs.size ; j++ )
            {
                otherdesc = descriptorsbylinkname[ adjdescs[ j ] ];
                
                if ( !isdefined( otherdesc ) || otherdesc.targetname != "flag_descriptor" )
                {
                    globallogic_utils::add_map_error( "flag_descriptor with script_linkname \"" + flags[ i ].descriptor.script_linkname + "\" linked to \"" + adjdescs[ j ] + "\" which does not exist as a script_linkname of any other entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)" );
                    continue;
                }
                
                adjflag = otherdesc.flag;
                
                if ( adjflag == flags[ i ] )
                {
                    globallogic_utils::add_map_error( "flag_descriptor with script_linkname \"" + flags[ i ].descriptor.script_linkname + "\" linked to itself" );
                    continue;
                }
                
                flags[ i ].adjflags[ flags[ i ].adjflags.size ] = adjflag;
            }
        }
    }
    
    spawnpoints = spawning::get_spawnpoint_array( "mp_dom_spawn" );
    
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        if ( isdefined( spawnpoints[ i ].script_linkto ) )
        {
            desc = descriptorsbylinkname[ spawnpoints[ i ].script_linkto ];
            
            if ( !isdefined( desc ) || desc.targetname != "flag_descriptor" )
            {
                globallogic_utils::add_map_error( "Spawnpoint at " + spawnpoints[ i ].origin + "\" linked to \"" + spawnpoints[ i ].script_linkto + "\" which does not exist as a script_linkname of any entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)" );
                continue;
            }
            
            nearestflag = desc.flag;
        }
        else
        {
            nearestflag = undefined;
            nearestdist = undefined;
            
            for ( j = 0; j < flags.size ; j++ )
            {
                dist = distancesquared( flags[ j ].origin, spawnpoints[ i ].origin );
                
                if ( !isdefined( nearestflag ) || dist < nearestdist )
                {
                    nearestflag = flags[ j ];
                    nearestdist = dist;
                }
            }
        }
        
        nearestflag.nearbyspawns[ nearestflag.nearbyspawns.size ] = spawnpoints[ i ];
    }
    
    if ( globallogic_utils::print_map_errors() )
    {
        return 0;
    }
}

// Namespace dom/dom
// Params 0
// Checksum 0x9b65fe1e, Offset: 0x62c8
// Size: 0x134
function createflagspawninfluencers()
{
    ss = level.spawnsystem;
    
    for ( flag_index = 0; flag_index < level.flags.size ; flag_index++ )
    {
        if ( level.domflags[ flag_index ] == self )
        {
            break;
        }
    }
    
    self.owned_flag_influencer = self influencers::create_influencer( "dom_friendly", self.trigger.origin, 0 );
    self.neutral_flag_influencer = self influencers::create_influencer( "dom_neutral", self.trigger.origin, 0 );
    self.enemy_flag_influencer = self influencers::create_influencer( "dom_enemy", self.trigger.origin, 0 );
    self update_spawn_influencers( "neutral" );
}

// Namespace dom/dom
// Params 1
// Checksum 0x80c4072, Offset: 0x6408
// Size: 0x19c
function update_spawn_influencers( team )
{
    assert( isdefined( self.neutral_flag_influencer ) );
    assert( isdefined( self.owned_flag_influencer ) );
    assert( isdefined( self.enemy_flag_influencer ) );
    
    if ( team == "neutral" )
    {
        enableinfluencer( self.neutral_flag_influencer, 1 );
        enableinfluencer( self.owned_flag_influencer, 0 );
        enableinfluencer( self.enemy_flag_influencer, 0 );
        return;
    }
    
    enableinfluencer( self.neutral_flag_influencer, 0 );
    enableinfluencer( self.owned_flag_influencer, 1 );
    enableinfluencer( self.enemy_flag_influencer, 1 );
    setinfluencerteammask( self.owned_flag_influencer, util::getteammask( team ) );
    setinfluencerteammask( self.enemy_flag_influencer, util::getotherteamsmask( team ) );
}

// Namespace dom/dom
// Params 3
// Checksum 0x65e0503f, Offset: 0x65b0
// Size: 0x94
function addspawnpointsforflag( team, flag_team, flagspawnname )
{
    if ( game.switchedsides )
    {
        team = util::getotherteam( team );
    }
    
    otherteam = util::getotherteam( team );
    
    if ( flag_team != otherteam )
    {
        spawning::add_spawn_points( team, flagspawnname );
    }
}

// Namespace dom/dom
// Params 0
// Checksum 0x6c18883a, Offset: 0x6650
// Size: 0x23c
function function_25cda323()
{
    spawning::clear_spawn_points();
    spawning::add_spawn_points( "allies", "mp_dom_spawn" );
    spawning::add_spawn_points( "axis", "mp_dom_spawn" );
    function_cc0cf07a();
    var_5a5001b5 = level.flags.size;
    
    if ( dominated_check() )
    {
        for ( i = 0; i < var_5a5001b5 ; i++ )
        {
            label = level.flags[ i ].useobj gameobjects::get_label();
            flagspawnname = "mp_dom_spawn_flag" + label;
            spawning::add_spawn_points( "allies", flagspawnname );
            spawning::add_spawn_points( "axis", flagspawnname );
        }
    }
    else
    {
        for ( i = 0; i < var_5a5001b5 ; i++ )
        {
            label = level.flags[ i ].useobj gameobjects::get_label();
            flagspawnname = "mp_dom_spawn_flag" + label;
            flag_team = level.flags[ i ] getflagteam();
            addspawnpointsforflag( "allies", flag_team, flagspawnname );
            addspawnpointsforflag( "axis", flag_team, flagspawnname );
        }
    }
    
    spawning::updateallspawnpoints();
}

// Namespace dom/dom
// Params 0
// Checksum 0x2728cf6f, Offset: 0x6898
// Size: 0xf4, Type: bool
function dominated_challenge_check()
{
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    
    for ( i = 0; i < num_flags ; i++ )
    {
        flag_team = level.flags[ i ] getflagteam();
        
        if ( flag_team == "allies" )
        {
            allied_flags++;
        }
        else if ( flag_team == "axis" )
        {
            axis_flags++;
        }
        else
        {
            return false;
        }
        
        if ( allied_flags > 0 && axis_flags > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace dom/dom
// Params 0
// Checksum 0x722b0f9a, Offset: 0x6998
// Size: 0xec, Type: bool
function dominated_check()
{
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    
    for ( i = 0; i < num_flags ; i++ )
    {
        flag_team = level.flags[ i ] getflagteam();
        
        if ( flag_team == "allies" )
        {
            allied_flags++;
        }
        else if ( flag_team == "axis" )
        {
            axis_flags++;
        }
        
        if ( allied_flags > 0 && axis_flags > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace dom/dom
// Params 1
// Checksum 0x2233f9c5, Offset: 0x6a90
// Size: 0x10c
function updatecapsperminute( lastownerteam )
{
    if ( !isdefined( self.capsperminute ) )
    {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    
    if ( lastownerteam == "neutral" )
    {
        return;
    }
    
    self.numcaps++;
    minutespassed = globallogic_utils::gettimepassed() / 60000;
    
    if ( isplayer( self ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        minutespassed = self.timeplayed[ "total" ] / 60;
    }
    
    self.capsperminute = self.numcaps / minutespassed;
    
    if ( self.capsperminute > self.numcaps )
    {
        self.capsperminute = self.numcaps;
    }
}

// Namespace dom/dom
// Params 2
// Checksum 0x1658a332, Offset: 0x6ba8
// Size: 0x70, Type: bool
function isscoreboosting( player, flag )
{
    if ( !level.rankedmatch )
    {
        return false;
    }
    
    if ( player.capsperminute > level.playercapturelpm )
    {
        return true;
    }
    
    if ( flag.capsperminute > level.flagcapturelpm )
    {
        return true;
    }
    
    return false;
}

// Namespace dom/dom
// Params 0
// Checksum 0xc7c2276, Offset: 0x6c20
// Size: 0xd4
function onupdateuserate()
{
    if ( !isdefined( self.contested ) )
    {
        self.contested = 0;
    }
    
    numother = gameobjects::get_num_touching_except_team( self.ownerteam );
    numowners = self.numtouching[ self.claimteam ];
    previousstate = self.contested;
    
    if ( numother > 0 && numowners > 0 )
    {
        self.contested = 1;
        return;
    }
    
    if ( previousstate == 1 )
    {
        self notify( #"contest_over" );
    }
    
    self.contested = 0;
}

