#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/spectating;
#using scripts/core_common/util_shared;
#using scripts/mp_common/bots/mp_bot;
#using scripts/mp_common/draft;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/userspawnselection;
#using scripts/mp_common/util;

#namespace globallogic_ui;

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x80f724d1, Offset: 0x410
// Size: 0x4
function init()
{
    
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x349b3781, Offset: 0x420
// Size: 0x98
function setupcallbacks()
{
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &menuclass;
    level.teammenu = &menuteam;
    level.draftmenu = &menupositiondraft;
    level.autocontrolplayer = &menuautocontrolplayer;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x4152b733, Offset: 0x4c0
// Size: 0x2ac
function freegameplayhudelems()
{
    if ( isdefined( self.perkicon ) )
    {
        for ( numspecialties = 0; numspecialties < level.maxspecialties ; numspecialties++ )
        {
            if ( isdefined( self.perkicon[ numspecialties ] ) )
            {
                self.perkicon[ numspecialties ] hud::destroyelem();
                self.perkname[ numspecialties ] hud::destroyelem();
            }
        }
    }
    
    if ( isdefined( self.perkhudelem ) )
    {
        self.perkhudelem hud::destroyelem();
    }
    
    if ( isdefined( self.killstreakicon ) )
    {
        if ( isdefined( self.killstreakicon[ 0 ] ) )
        {
            self.killstreakicon[ 0 ] hud::destroyelem();
        }
        
        if ( isdefined( self.killstreakicon[ 1 ] ) )
        {
            self.killstreakicon[ 1 ] hud::destroyelem();
        }
        
        if ( isdefined( self.killstreakicon[ 2 ] ) )
        {
            self.killstreakicon[ 2 ] hud::destroyelem();
        }
        
        if ( isdefined( self.killstreakicon[ 3 ] ) )
        {
            self.killstreakicon[ 3 ] hud::destroyelem();
        }
        
        if ( isdefined( self.killstreakicon[ 4 ] ) )
        {
            self.killstreakicon[ 4 ] hud::destroyelem();
        }
    }
    
    if ( isdefined( self.lowermessage ) )
    {
        self.lowermessage hud::destroyelem();
    }
    
    if ( isdefined( self.lowertimer ) )
    {
        self.lowertimer hud::destroyelem();
    }
    
    if ( isdefined( self.proxbar ) )
    {
        self.proxbar hud::destroyelem();
    }
    
    if ( isdefined( self.proxbartext ) )
    {
        self.proxbartext hud::destroyelem();
    }
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon hud::destroyelem();
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 1
// Checksum 0xe4cea39a, Offset: 0x778
// Size: 0xca, Type: bool
function teamplayercountsequal( playercounts )
{
    count = undefined;
    
    foreach ( team in level.teams )
    {
        if ( !isdefined( count ) )
        {
            count = playercounts[ team ];
            continue;
        }
        
        if ( count != playercounts[ team ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 2
// Checksum 0x4594fd36, Offset: 0x850
// Size: 0xde
function teamwithlowestplayercount( playercounts, ignore_team )
{
    count = 9999;
    lowest_team = undefined;
    
    foreach ( team in level.teams )
    {
        if ( count > playercounts[ team ] )
        {
            count = playercounts[ team ];
            lowest_team = team;
        }
    }
    
    return lowest_team;
}

// Namespace globallogic_ui/globallogic_ui
// Params 2
// Checksum 0x5f5306ad, Offset: 0x938
// Size: 0xc6, Type: bool
function function_76c7989e( teamname, comingfrommenu )
{
    if ( level.rankedmatch )
    {
        return false;
    }
    
    if ( level.inprematchperiod )
    {
        return false;
    }
    
    if ( teamname != "free" )
    {
        return false;
    }
    
    if ( comingfrommenu )
    {
        return false;
    }
    
    if ( self ishost() )
    {
        return false;
    }
    
    if ( level.forceautoassign )
    {
        return false;
    }
    
    if ( self isbot() )
    {
        return false;
    }
    
    if ( self issplitscreen() )
    {
        return false;
    }
    
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 1
// Checksum 0x696994f1, Offset: 0xa08
// Size: 0x664
function menuautoassign( comingfrommenu )
{
    teamkeys = getarraykeys( level.teams );
    assignment = teamkeys[ randomint( teamkeys.size ) ];
    
    if ( getdvarint( "mp_prototype" ) == 0 )
    {
        self closemenus();
    }
    
    self luinotifyevent( &"clear_notification_queue" );
    
    if ( level.teambased )
    {
        teamname = getassignedteamname( self );
        
        if ( isdefined( teamname ) && teamname != "free" && !comingfrommenu )
        {
            assignment = teamname;
        }
        else if ( function_76c7989e( teamname, comingfrommenu ) )
        {
            assignment = "spectator";
        }
        else
        {
            playercounts = self teams::count_players();
            
            if ( teamplayercountsequal( playercounts ) )
            {
                if ( !level.splitscreen && self issplitscreen() )
                {
                    assignment = self get_splitscreen_team();
                    
                    if ( assignment == "" )
                    {
                        assignment = pickteamfromscores( teamkeys );
                    }
                }
                else
                {
                    assignment = pickteamfromscores( teamkeys );
                }
            }
            else
            {
                assignment = teamwithlowestplayercount( playercounts, "none" );
            }
        }
        
        if ( self.sessionstate == "playing" || assignment == self.pers[ "team" ] && self.sessionstate == "dead" )
        {
            self beginclasschoice( 0 );
            return;
        }
    }
    else
    {
        if ( !comingfrommenu )
        {
            assignment = self.sessionteam;
        }
        else
        {
            clientnum = self getentitynumber();
            count = 0;
            
            foreach ( team in level.teams )
            {
                if ( team == "free" )
                {
                    continue;
                }
                
                count++;
                
                if ( count == clientnum + 1 )
                {
                    assignment = team;
                    break;
                }
            }
        }
        
        if ( self.sessionstate == "playing" || self.sessionstate == "dead" )
        {
            return;
        }
    }
    
    /#
        assignmentoverride = getdvarstring( "<dev string:x28>" );
        
        if ( assignmentoverride != "<dev string:x37>" )
        {
            assignment = assignmentoverride;
        }
    #/
    
    if ( assignment == "spectator" && !level.forceautoassign )
    {
        self.pers[ "team" ] = assignment;
        self.team = assignment;
        self.sessionteam = assignment;
        self setclientscriptmainmenu( game.menu[ "menu_start_menu" ] );
        return;
    }
    
    if ( self.sessionstate == "playing" || assignment != self.pers[ "team" ] && self.sessionstate == "dead" )
    {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = assignment;
        self.leaving_team = self.pers[ "team" ];
        self suicide();
    }
    
    self.pers[ "team" ] = assignment;
    self.team = assignment;
    self.pers[ "class" ] = undefined;
    self.curclass = undefined;
    self.pers[ "weapon" ] = undefined;
    self.pers[ "savedmodel" ] = undefined;
    self updateobjectivetext();
    self.sessionteam = assignment;
    
    if ( !isalive( self ) )
    {
        self.statusicon = "hud_status_dead";
    }
    
    self notify( #"joined_team" );
    level notify( #"joined_team" );
    callback::callback( #"hash_95a6c4c0" );
    self notify( #"end_respawn" );
    self beginclasschoice( comingfrommenu );
    self setclientscriptmainmenu( game.menu[ "menu_start_menu" ] );
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x8d1e1f29, Offset: 0x1078
// Size: 0xd6, Type: bool
function teamscoresequal()
{
    score = undefined;
    
    foreach ( team in level.teams )
    {
        if ( !isdefined( score ) )
        {
            score = getteamscore( team );
            continue;
        }
        
        if ( score != getteamscore( team ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x27da8fd7, Offset: 0x1158
// Size: 0xcc
function teamwithlowestscore()
{
    score = 99999999;
    lowest_team = undefined;
    
    foreach ( team in level.teams )
    {
        if ( score > getteamscore( team ) )
        {
            lowest_team = team;
        }
    }
    
    return lowest_team;
}

// Namespace globallogic_ui/globallogic_ui
// Params 1
// Checksum 0x3da3b3f, Offset: 0x1230
// Size: 0x74
function pickteamfromscores( teams )
{
    assignment = "allies";
    
    if ( teamscoresequal() )
    {
        assignment = teams[ randomint( teams.size ) ];
    }
    else
    {
        assignment = teamwithlowestscore();
    }
    
    return assignment;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x96f8c320, Offset: 0x12b0
// Size: 0xe2
function get_splitscreen_team()
{
    for ( index = 0; index < level.players.size ; index++ )
    {
        if ( !isdefined( level.players[ index ] ) )
        {
            continue;
        }
        
        if ( level.players[ index ] == self )
        {
            continue;
        }
        
        if ( !self isplayeronsamemachine( level.players[ index ] ) )
        {
            continue;
        }
        
        team = level.players[ index ].sessionteam;
        
        if ( team != "spectator" )
        {
            return team;
        }
    }
    
    return "";
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x5a9831b4, Offset: 0x13a0
// Size: 0xd4
function updateobjectivetext()
{
    if ( self.pers[ "team" ] == "spectator" )
    {
        self setclientcgobjectivetext( "" );
        return;
    }
    
    if ( level.scorelimit > 0 || level.roundscorelimit > 0 )
    {
        self setclientcgobjectivetext( util::getobjectivescoretext( self.pers[ "team" ] ) );
        return;
    }
    
    self setclientcgobjectivetext( util::getobjectivetext( self.pers[ "team" ] ) );
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x7235d33d, Offset: 0x1480
// Size: 0x1c
function closemenus()
{
    self closeingamemenu();
}

// Namespace globallogic_ui/globallogic_ui
// Params 1
// Checksum 0x73c71f25, Offset: 0x14a8
// Size: 0x23c
function beginclasschoice( comingfrommenu )
{
    assert( isdefined( level.teams[ self.pers[ "<dev string:x38>" ] ] ) );
    team = self.pers[ "team" ];
    
    if ( level.disableclassselection == 1 || getdvarint( "migration_soak" ) == 1 )
    {
        self player_role::set( getdvarint( "auto_select_character", 1 ) );
        started_waiting = gettime();
        
        while ( !self isstreamerready( -1, 1 ) && started_waiting + 90000 > gettime() )
        {
            waitframe( 1 );
        }
        
        self.pers[ "class" ] = level.defaultclass;
        self.curclass = level.defaultclass;
        
        if ( self.sessionstate != "playing" && game.state == "playing" )
        {
            self thread [[ level.spawnclient ]]();
        }
        
        level thread globallogic::updateteamstatus();
        self thread spectating::set_permissions_for_machine();
        return;
    }
    
    util::wait_network_frame();
    
    if ( comingfrommenu && ( !draft::is_enabled() || !self istestclient() ) )
    {
        [[ level.spawnspectator ]]();
        self draft::open();
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x92d2c298, Offset: 0x16f0
// Size: 0x84
function showmainmenuforteam()
{
    assert( isdefined( level.teams[ self.pers[ "<dev string:x38>" ] ] ) );
    team = self.pers[ "team" ];
    self openmenu( game.menu[ "menu_changeclass_" + team ] );
}

// Namespace globallogic_ui/globallogic_ui
// Params 1
// Checksum 0x921c8c21, Offset: 0x1780
// Size: 0x2cc
function menuteam( team )
{
    if ( getdvarint( "mp_prototype", 0 ) == 0 )
    {
        self closeingamemenu();
    }
    
    if ( isdefined( self.hasdonecombat ) && !level.console && level.allow_teamchange == "0" && self.hasdonecombat )
    {
        return;
    }
    
    if ( self.pers[ "team" ] != team )
    {
        if ( !isdefined( self.hasdonecombat ) || level.ingraceperiod && !self.hasdonecombat )
        {
            self.hasspawned = 0;
        }
        
        if ( self.sessionstate == "playing" )
        {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = team;
            self.leaving_team = self.pers[ "team" ];
            self suicide();
        }
        
        self userspawnselection::clearcacheforplayer();
        self luinotifyevent( &"clear_notification_queue" );
        self.pers[ "team" ] = team;
        self.team = team;
        self.pers[ "class" ] = undefined;
        self.curclass = undefined;
        self.pers[ "weapon" ] = undefined;
        self.pers[ "savedmodel" ] = undefined;
        self updateobjectivetext();
        
        if ( !level.rankedmatch && !level.leaguematch )
        {
            self.sessionstate = "spectator";
        }
        
        self.sessionteam = team;
        self setclientscriptmainmenu( game.menu[ "menu_start_menu" ] );
        self notify( #"joined_team" );
        level notify( #"joined_team" );
        callback::callback( #"hash_95a6c4c0" );
        self notify( #"end_respawn" );
    }
    
    self beginclasschoice( 1 );
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0xfd9c18c4, Offset: 0x1a58
// Size: 0x1b4
function menuspectator()
{
    self closemenus();
    
    if ( self.pers[ "team" ] != "spectator" )
    {
        if ( isalive( self ) )
        {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = "spectator";
            self.leaving_team = self.pers[ "team" ];
            self suicide();
        }
        
        self.pers[ "team" ] = "spectator";
        self.team = "spectator";
        self.pers[ "class" ] = undefined;
        self.curclass = undefined;
        self.pers[ "weapon" ] = undefined;
        self.pers[ "savedmodel" ] = undefined;
        self updateobjectivetext();
        self.sessionteam = "spectator";
        [[ level.spawnspectator ]]();
        self thread globallogic_player::spectate_player_watcher();
        self setclientscriptmainmenu( game.menu[ "menu_start_menu" ] );
        self notify( #"joined_spectators" );
        callback::callback( #"hash_4c5ae192" );
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 4
// Checksum 0x3ac6ef70, Offset: 0x1c18
// Size: 0x450, Type: bool
function menuclass( response, forcedclass, updatecharacterindex, closemenus )
{
    if ( getdvarint( "mp_prototype" ) == 0 )
    {
        self closemenus();
    }
    
    if ( !isdefined( self.pers[ "team" ] ) || !isdefined( level.teams[ self.pers[ "team" ] ] ) )
    {
        return false;
    }
    
    if ( !isdefined( forcedclass ) )
    {
        playerclass = self loadout::getclasschoice( response );
    }
    else
    {
        playerclass = forcedclass;
    }
    
    if ( isdefined( self.pers[ "class" ] ) && self.pers[ "class" ] == playerclass )
    {
        return true;
    }
    
    self.pers[ "changed_class" ] = 1;
    self notify( #"changed_class" );
    
    if ( isdefined( self.curclass ) && self.curclass == playerclass )
    {
        self.pers[ "changed_class" ] = 0;
    }
    
    self.pers[ "class" ] = playerclass;
    self.curclass = playerclass;
    self.pers[ "weapon" ] = undefined;
    
    if ( game.state == "postgame" )
    {
        return false;
    }
    
    if ( self.sessionstate != "playing" )
    {
        if ( self.sessionstate != "spectator" )
        {
            if ( self isinvehicle() )
            {
                return false;
            }
            
            if ( self isremotecontrolling() )
            {
                return false;
            }
            
            if ( self isweaponviewonlylinked() )
            {
                return false;
            }
        }
        
        if ( game.state == "playing" )
        {
            timepassed = undefined;
            
            if ( isdefined( self.respawntimerstarttime ) )
            {
                timepassed = ( gettime() - self.respawntimerstarttime ) / 1000;
            }
            
            self thread [[ level.spawnclient ]]( timepassed );
            self.respawntimerstarttime = undefined;
        }
    }
    
    if ( self.sessionstate == "playing" )
    {
        supplystationclasschange = isdefined( self.usingsupplystation ) && self.usingsupplystation;
        self.usingsupplystation = 0;
        
        if ( isdefined( supplystationclasschange ) && ( isdefined( level.ingraceperiod ) && level.ingraceperiod && !( isdefined( self.hasdonecombat ) && self.hasdonecombat ) || supplystationclasschange ) || getdvarint( "mp_prototype" ) != 0 )
        {
            self loadout::setclass( self.pers[ "class" ] );
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            self loadout::giveloadout( self.pers[ "team" ], self.pers[ "class" ], 0 );
            self killstreaks::give_owned();
        }
        else if ( !self issplitscreen() )
        {
            self iprintlnbold( game.strings[ "change_class" ] );
        }
    }
    
    level thread globallogic::updateteamstatus();
    self thread spectating::set_permissions_for_machine();
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0
// Checksum 0x46bf6611, Offset: 0x2070
// Size: 0x4c
function menuautocontrolplayer()
{
    self closemenus();
    
    if ( self.pers[ "team" ] != "spectator" )
    {
        toggleplayercontrol( self );
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 1
// Checksum 0x4187867c, Offset: 0x20c8
// Size: 0x10c
function menupositiondraft( response )
{
    if ( response == "changecharacter" )
    {
        self player_role::clear();
        return;
    }
    
    if ( response == "randomcharacter" )
    {
        self player_role::clear();
        draft::assign_remaining_players( self );
        
        if ( !( isdefined( level.inprematchperiod ) && level.inprematchperiod ) )
        {
            self draft::close();
            self closeingamemenu();
        }
        
        return;
    }
    
    if ( response == "opendraft" )
    {
        self draft::open();
        return;
    }
    
    if ( response == "closedraft" )
    {
        self draft::close();
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 1
// Checksum 0x3081c3ae, Offset: 0x21e0
// Size: 0x4c
function removespawnmessageshortly( delay )
{
    self endon( #"disconnect" );
    waittillframeend();
    self endon( #"end_respawn" );
    wait delay;
    self util::clearlowermessage( 2 );
}

