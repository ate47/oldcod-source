#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/array_shared;
#using scripts/core_common/burnplayer;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/globallogic/globallogic_player;
#using scripts/core_common/globallogic/globallogic_score;
#using scripts/core_common/globallogic/globallogic_vehicle;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/killcam_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/medals_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/player_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/spectating;
#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/core_common/weapons/weapons;
#using scripts/core_common/weapons_shared;
#using scripts/mp_common/armor;
#using scripts/mp_common/behavior_tracker;
#using scripts/mp_common/challenges;
#using scripts/mp_common/contracts;
#using scripts/mp_common/draft;
#using scripts/mp_common/gamerep;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/deathicons;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_spawn;
#using scripts/mp_common/gametypes/globallogic_ui;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/hud_message;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/gametypes/menus;
#using scripts/mp_common/gametypes/weapons;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/laststand;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;
#using scripts/mp_common/vehicle;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x2
// Checksum 0xc961d8df, Offset: 0x26f8
// Size: 0x16c
function autoexec __init__()
{
    clientfield::register( "clientuimodel", "hudItems.lplevel.majorSlot1.level", 1, 3, "int" );
    clientfield::register( "clientuimodel", "hudItems.lplevel.majorSlot2.level", 1, 3, "int" );
    clientfield::register( "clientuimodel", "hudItems.lplevel.generalSlot1.level", 1, 3, "int" );
    clientfield::register( "clientuimodel", "hudItems.lplevel.generalSlot2.level", 1, 3, "int" );
    clientfield::register( "clientuimodel", "hudItems.lplevel.generalSlot3.level", 1, 3, "int" );
    clientfield::register( "clientuimodel", "hudItems.lplevel.generalSlot4.level", 1, 3, "int" );
    clientfield::register( "clientuimodel", "hudItems.lplevel.disableUI", 1, 1, "int" );
    
    /#
        level thread function_54719ee3();
    #/
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x240daf09, Offset: 0x2870
// Size: 0x5c
function on_joined_team()
{
    if ( !level.rankedmatch && !level.teambased )
    {
        level thread function_36b1aaf0();
    }
    
    function_5e7bd9e1();
    function_5e3d5a6d();
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xf8ea93af, Offset: 0x28d8
// Size: 0xc4
function freezeplayerforroundend()
{
    self util::clearlowermessage();
    self closeingamemenu();
    self util::freeze_player_controls( 1 );
    
    if ( !sessionmodeiszombiesgame() )
    {
        currentweapon = self getcurrentweapon();
        
        if ( killstreaks::is_killstreak_weapon( currentweapon ) && !currentweapon.iscarriedkillstreak )
        {
            self takeweapon( currentweapon );
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0x23f5b99d, Offset: 0x29a8
// Size: 0x8c
function arraytostring( inputarray )
{
    targetstring = "";
    
    for ( i = 0; i < inputarray.size ; i++ )
    {
        targetstring += inputarray[ i ];
        
        if ( i != inputarray.size - 1 )
        {
            targetstring += ",";
        }
    }
    
    return targetstring;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0xc98e9a0a, Offset: 0x2a40
// Size: 0x11b4
function function_c92849fa( player, result )
{
    lpselfnum = player getentitynumber();
    lpxuid = player getxuid( 1 );
    bbprint( "global_leave", "name %s client %s xuid %s", player.name, lpselfnum, lpxuid );
    weeklyacontractid = 0;
    weeklyacontracttarget = 0;
    weeklyacontractcurrent = 0;
    weeklyacontractcompleted = 0;
    weeklybcontractid = 0;
    weeklybcontracttarget = 0;
    weeklybcontractcurrent = 0;
    weeklybcontractcompleted = 0;
    dailycontractid = 0;
    dailycontracttarget = 0;
    dailycontractcurrent = 0;
    dailycontractcompleted = 0;
    specialcontractid = 0;
    specialcontracttarget = 0;
    specialcontractcurent = 0;
    specialcontractcompleted = 0;
    
    if ( player isbot() )
    {
        currxp = 0;
        prevxp = 0;
    }
    else
    {
        currxp = player rank::getrankxpstat();
        prevxp = player.pers[ "rankxp" ];
        
        if ( globallogic_score::canupdateweaponcontractstats() )
        {
            specialcontractid = 1;
            specialcontracttarget = getdvarint( "weapon_contract_target_value", 100 );
            specialcontractcurent = player getdstat( "weaponContractData", "currentValue" );
            
            if ( ( isdefined( player getdstat( "weaponContractData", "completeTimestamp" ) ) ? player getdstat( "weaponContractData", "completeTimestamp" ) : 0 ) != 0 )
            {
                specialcontractcompleted = 1;
            }
        }
        
        if ( player contracts::can_process_contracts() )
        {
            contractid = player contracts::get_contract_stat( 0, "index" );
            
            if ( player contracts::is_contract_active( contractid ) )
            {
                weeklyacontractid = contractid;
                weeklyacontracttarget = player.pers[ "contracts" ][ weeklyacontractid ].target_value;
                weeklyacontractcurrent = player contracts::get_contract_stat( 0, "progress" );
                weeklyacontractcompleted = player contracts::get_contract_stat( 0, "award_given" );
            }
            
            contractid = player contracts::get_contract_stat( 1, "index" );
            
            if ( player contracts::is_contract_active( contractid ) )
            {
                weeklybcontractid = contractid;
                weeklybcontracttarget = player.pers[ "contracts" ][ weeklybcontractid ].target_value;
                weeklybcontractcurrent = player contracts::get_contract_stat( 1, "progress" );
                weeklybcontractcompleted = player contracts::get_contract_stat( 1, "award_given" );
            }
            
            contractid = player contracts::get_contract_stat( 2, "index" );
            
            if ( player contracts::is_contract_active( contractid ) )
            {
                dailycontractid = contractid;
                dailycontracttarget = player.pers[ "contracts" ][ dailycontractid ].target_value;
                dailycontractcurrent = player contracts::get_contract_stat( 2, "progress" );
                dailycontractcompleted = player contracts::get_contract_stat( 2, "award_given" );
            }
        }
    }
    
    if ( !isdefined( prevxp ) )
    {
        return;
    }
    
    resultstr = result;
    
    if ( isdefined( player.team ) && result == player.team )
    {
        resultstr = "win";
    }
    else if ( result == "allies" || result == "axis" )
    {
        resultstr = "lose";
    }
    
    xpearned = currxp - prevxp;
    perkstr = arraytostring( player getperks() );
    primaryweaponname = "";
    primaryweaponattachstr = "";
    secondaryweaponname = "";
    secondaryweaponattachstr = "";
    grenadeprimaryname = "";
    grenadesecondaryname = "";
    
    if ( isdefined( player.primaryloadoutweapon ) )
    {
        primaryweaponname = player.primaryloadoutweapon.name;
        primaryweaponattachstr = arraytostring( getarraykeys( player.primaryloadoutweapon.attachments ) );
    }
    
    if ( isdefined( player.secondaryloadoutweapon ) )
    {
        secondaryweaponname = player.secondaryloadoutweapon.name;
        secondaryweaponattachstr = arraytostring( getarraykeys( player.secondaryloadoutweapon.attachments ) );
    }
    
    if ( isdefined( player.grenadetypeprimary ) )
    {
        grenadeprimaryname = player.grenadetypeprimary.name;
    }
    
    if ( isdefined( player.grenadetypesecondary ) )
    {
        grenadesecondaryname = player.grenadetypesecondary.name;
    }
    
    killstreakstr = arraytostring( player.killstreak );
    gamelength = game.timepassed / 1000;
    timeplayed = player globallogic::gettotaltimeplayed( gamelength );
    totalkills = player getdstat( "playerstatslist", "kills", "statValue" );
    totalhits = player getdstat( "playerstatslist", "hits", "statValue" );
    totaldeaths = player getdstat( "playerstatslist", "deaths", "statValue" );
    totalwins = player getdstat( "playerstatslist", "wins", "statValue" );
    totalxp = player getdstat( "playerstatslist", "rankxp", "statValue" );
    killcount = 0;
    hitcount = 0;
    
    if ( level.mpcustommatch )
    {
        killcount = player.kills;
        hitcount = player.shotshit;
    }
    else
    {
        if ( isdefined( player.startkills ) )
        {
            killcount = totalkills - player.startkills;
        }
        
        if ( isdefined( player.starthits ) )
        {
            hitcount = totalhits - player.starthits;
        }
    }
    
    bestscore = "0";
    
    if ( isdefined( player.pers[ "lastHighestScore" ] ) && player.score > player.pers[ "lastHighestScore" ] )
    {
        bestscore = "1";
    }
    
    bestkills = "0";
    
    if ( isdefined( player.pers[ "lastHighestKills" ] ) && killcount > player.pers[ "lastHighestKills" ] )
    {
        bestkills = "1";
    }
    
    totalmatchshots = 0;
    
    if ( isdefined( player.totalmatchshots ) )
    {
        totalmatchshots = player.totalmatchshots;
    }
    
    deaths = player.deaths;
    
    if ( deaths == 0 )
    {
        deaths = 1;
    }
    
    kdratio = player.kills * 1000 / deaths;
    bestkdratio = "0";
    
    if ( isdefined( player.pers[ "lastHighestKDRatio" ] ) && kdratio > player.pers[ "lastHighestKDRatio" ] )
    {
        bestkdratio = "1";
    }
    
    showcaseweapon = player getplayershowcaseweapon();
    recordcomscoreevent( "end_match", "match_id", getdemofileid(), "game_variant", "mp", "game_mode", level.gametype, "private_match", sessionmodeisprivate(), "esports_flag", level.leaguematch, "ranked_play_flag", level.arenamatch, "game_map", getdvarstring( "mapname" ), "player_xuid", player getxuid( 1 ), "player_ip", player getipaddress(), "match_kills", killcount, "match_deaths", player.deaths, "match_xp", xpearned, "match_score", player.score, "match_streak", player.pers[ "best_kill_streak" ], "match_captures", player.pers[ "captures" ], "match_defends", player.pers[ "defends" ], "match_headshots", player.pers[ "headshots" ], "match_longshots", player.pers[ "longshots" ], "match_objtime", player.pers[ "objtime" ], "match_plants", player.pers[ "plants" ], "match_defuses", player.pers[ "defuses" ], "match_throws", player.pers[ "throws" ], "match_carries", player.pers[ "carries" ], "match_returns", player.pers[ "returns" ], "prestige_max", player.pers[ "plevel" ], "level_max", player.pers[ "rank" ], "match_result", resultstr, "match_duration", timeplayed, "match_shots", totalmatchshots, "match_hits", hitcount, "player_gender", player getplayergendertype( currentsessionmode() ), "specialist_kills", player.heavyweaponkillcount, "specialist_used", player getmpdialogname(), "season_pass_owned", player hasseasonpass( 0 ), "loadout_perks", perkstr, "loadout_lethal", grenadeprimaryname, "loadout_tactical", grenadesecondaryname, "loadout_scorestreaks", killstreakstr, "loadout_primary_weapon", primaryweaponname, "loadout_secondary_weapon", secondaryweaponname, "dlc_owned", player getdlcavailable(), "loadout_primary_attachments", primaryweaponattachstr, "loadout_secondary_attachments", secondaryweaponattachstr, "best_score", bestscore, "best_kills", bestkills, "best_kd", bestkdratio, "total_kills", totalkills, "total_deaths", totaldeaths, "total_wins", totalwins, "total_xp", totalxp, "daily_contract_id", dailycontractid, "daily_contract_target", dailycontracttarget, "daily_contract_current", dailycontractcurrent, "daily_contract_completed", dailycontractcompleted, "weeklyA_contract_id", weeklyacontractid, "weeklyA_contract_target", weeklyacontracttarget, "weeklyA_contract_current", weeklyacontractcurrent, "weeklyA_contract_completed", weeklyacontractcompleted, "weeklyB_contract_id", weeklybcontractid, "weeklyB_contract_target", weeklybcontracttarget, "weeklyB_contract_current", weeklybcontractcurrent, "weeklyB_contract_completed", weeklybcontractcompleted, "special_contract_id ", specialcontractid, "special_contract_target", specialcontracttarget, "special_contract_curent", specialcontractcurent, "special_contract_completed", specialcontractcompleted, "specialist_power", player.heroabilityname, "specialist_head", player getcharacterhelmetmodel(), "specialist_body", player getcharacterbodymodel(), "specialist_taunt", player getplayerselectedtauntname( 0 ), "specialist_goodgame", player getplayerselectedgesturename( 0 ), "specialist_threaten", player getplayerselectedgesturename( 1 ), "specialist_boast", player getplayerselectedgesturename( 2 ), "specialist_showcase", showcaseweapon.weapon.name );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x32d6907f, Offset: 0x3c00
// Size: 0x21a
function player_monitor_travel_dist()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    waittime = 1;
    minimummovedistance = 16;
    wait 4;
    prevpos = self.origin;
    positionptm = self.origin;
    
    while ( true )
    {
        wait waittime;
        
        if ( self util::isusingremote() )
        {
            self waittill( "stopped_using_remote" );
            prevpos = self.origin;
            positionptm = self.origin;
            continue;
        }
        
        distance = distance( self.origin, prevpos );
        self.pers[ "total_distance_travelled" ] = self.pers[ "total_distance_travelled" ] + distance;
        self.pers[ "movement_Update_Count" ]++;
        prevpos = self.origin;
        
        if ( self.pers[ "movement_Update_Count" ] % 5 == 0 )
        {
            distancemoving = distance( self.origin, positionptm );
            positionptm = self.origin;
            
            if ( distancemoving > minimummovedistance )
            {
                self.pers[ "num_speeds_when_moving_entries" ]++;
                self.pers[ "total_speeds_when_moving" ] = self.pers[ "total_speeds_when_moving" ] + distancemoving / waittime;
                self.pers[ "time_played_moving" ] = self.pers[ "time_played_moving" ] + waittime;
            }
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xef9daaa8, Offset: 0x3e28
// Size: 0x20c
function record_special_move_data_for_life( killer )
{
    if ( !isdefined( self.lastswimmingstarttime ) || !isdefined( self.lastwallrunstarttime ) || !isdefined( self.lastslidestarttime ) || !isdefined( self.lastdoublejumpstarttime ) || !isdefined( self.timespentswimminginlife ) || !isdefined( self.timespentwallrunninginlife ) || !isdefined( self.numberofdoublejumpsinlife ) || !isdefined( self.numberofslidesinlife ) )
    {
        println( "<dev string:x28>" );
        return;
    }
    
    if ( isdefined( killer ) )
    {
        if ( !isdefined( killer.lastswimmingstarttime ) || !isdefined( killer.lastwallrunstarttime ) || !isdefined( killer.lastslidestarttime ) || !isdefined( killer.lastdoublejumpstarttime ) )
        {
            println( "<dev string:x68>" );
            return;
        }
        
        matchrecordlogspecialmovedataforlife( self, self.lastswimmingstarttime, self.lastwallrunstarttime, self.lastslidestarttime, self.lastdoublejumpstarttime, self.timespentswimminginlife, self.timespentwallrunninginlife, self.numberofdoublejumpsinlife, self.numberofslidesinlife, killer, killer.lastswimmingstarttime, killer.lastwallrunstarttime, killer.lastslidestarttime, killer.lastdoublejumpstarttime );
        return;
    }
    
    matchrecordlogspecialmovedataforlife( self, self.lastswimmingstarttime, self.lastwallrunstarttime, self.lastslidestarttime, self.lastdoublejumpstarttime, self.timespentswimminginlife, self.timespentwallrunninginlife, self.numberofdoublejumpsinlife, self.numberofslidesinlife );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x152883dc, Offset: 0x4040
// Size: 0x118
function function_716b3fd6()
{
    self endon( #"disconnect" );
    self notify( #"stop_player_monitor_wall_run" );
    self endon( #"stop_player_monitor_wall_run" );
    self.lastwallrunstarttime = 0;
    self.timespentwallrunninginlife = 0;
    
    while ( true )
    {
        notification = self waittill( "wallrun_begin", "death", "disconnect", "stop_player_monitor_wall_run" );
        
        if ( notification._notify == "death" )
        {
            break;
        }
        
        self.lastwallrunstarttime = gettime();
        notification = self waittill( "wallrun_end", "death", "disconnect", "stop_player_monitor_wall_run" );
        self.timespentwallrunninginlife += gettime() - self.lastwallrunstarttime;
        
        if ( notification._notify == "death" )
        {
            break;
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xe967ebb2, Offset: 0x4160
// Size: 0x118
function function_64aa4793()
{
    self endon( #"disconnect" );
    self notify( #"stop_player_monitor_swimming" );
    self endon( #"stop_player_monitor_swimming" );
    self.lastswimmingstarttime = 0;
    self.timespentswimminginlife = 0;
    
    while ( true )
    {
        notification = self waittill( "swimming_begin", "death", "disconnect", "stop_player_monitor_swimming" );
        
        if ( notification._notify == "death" )
        {
            break;
        }
        
        self.lastswimmingstarttime = gettime();
        notification = self waittill( "swimming_end", "death", "disconnect", "stop_player_monitor_swimming" );
        self.timespentswimminginlife += gettime() - self.lastswimmingstarttime;
        
        if ( notification._notify == "death" )
        {
            break;
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x556f8c5, Offset: 0x4280
// Size: 0x100
function function_9e98f49b()
{
    self endon( #"disconnect" );
    self notify( #"stop_player_monitor_slide" );
    self endon( #"stop_player_monitor_slide" );
    self.lastslidestarttime = 0;
    self.numberofslidesinlife = 0;
    
    while ( true )
    {
        notification = self waittill( "slide_begin", "death", "disconnect", "stop_player_monitor_slide" );
        
        if ( notification._notify == "death" )
        {
            break;
        }
        
        self.lastslidestarttime = gettime();
        self.numberofslidesinlife++;
        notification = self waittill( "slide_end", "death", "disconnect", "stop_player_monitor_slide" );
        
        if ( notification._notify == "death" )
        {
            break;
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x21527514, Offset: 0x4388
// Size: 0x100
function function_cf1cf1b3()
{
    self endon( #"disconnect" );
    self notify( #"stop_player_monitor_doublejump" );
    self endon( #"stop_player_monitor_doublejump" );
    self.lastdoublejumpstarttime = 0;
    self.numberofdoublejumpsinlife = 0;
    
    while ( true )
    {
        notification = self waittill( "doublejump_begin", "death", "disconnect", "stop_player_monitor_doublejump" );
        
        if ( notification._notify == "death" )
        {
            break;
        }
        
        self.lastdoublejumpstarttime = gettime();
        self.numberofdoublejumpsinlife++;
        notification = self waittill( "doublejump_end", "death", "disconnect", "stop_player_monitor_doublejump" );
        
        if ( notification._notify == "death" )
        {
            break;
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x104d4094, Offset: 0x4490
// Size: 0x8e
function player_monitor_inactivity()
{
    self endon( #"disconnect" );
    self notify( #"player_monitor_inactivity" );
    self endon( #"player_monitor_inactivity" );
    wait 10;
    
    while ( true )
    {
        if ( isdefined( self ) )
        {
            if ( self isremotecontrolling() || self util::isusingremote() )
            {
                self resetinactivitytimer();
            }
        }
        
        wait 5;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xb57ab922, Offset: 0x4528
// Size: 0xcfc
function function_a858463d()
{
    self globallogic_score::initpersstat( "score" );
    self globallogic_score::initpersstat( "roleScore" );
    
    if ( level.resetplayerscoreeveryround )
    {
        self.pers[ "score" ] = 0;
        self.pers[ "roleScore" ] = 0;
    }
    
    self.score = self.pers[ "score" ];
    self.rolescore = self.pers[ "roleScore" ];
    self globallogic_score::initpersstat( "pointstowin" );
    
    if ( level.scoreroundwinbased )
    {
        self.pers[ "pointstowin" ] = 0;
    }
    
    self.pointstowin = self.pers[ "pointstowin" ];
    self globallogic_score::initpersstat( "momentum", 0 );
    self.momentum = self globallogic_score::getpersstat( "momentum" );
    self globallogic_score::initpersstat( "suicides" );
    self.suicides = self globallogic_score::getpersstat( "suicides" );
    self globallogic_score::initpersstat( "headshots" );
    self.headshots = self globallogic_score::getpersstat( "headshots" );
    self globallogic_score::initpersstat( "challenges" );
    self.challenges = self globallogic_score::getpersstat( "challenges" );
    self globallogic_score::initpersstat( "kills" );
    self.kills = self globallogic_score::getpersstat( "kills" );
    self globallogic_score::initpersstat( "deaths" );
    self.deaths = self globallogic_score::getpersstat( "deaths" );
    self globallogic_score::initpersstat( "assists" );
    self.assists = self globallogic_score::getpersstat( "assists" );
    self globallogic_score::initpersstat( "defends", 0 );
    self.defends = self globallogic_score::getpersstat( "defends" );
    self globallogic_score::initpersstat( "offends", 0 );
    self.offends = self globallogic_score::getpersstat( "offends" );
    self globallogic_score::initpersstat( "plants", 0 );
    self.plants = self globallogic_score::getpersstat( "plants" );
    self globallogic_score::initpersstat( "defuses", 0 );
    self.defuses = self globallogic_score::getpersstat( "defuses" );
    self globallogic_score::initpersstat( "returns", 0 );
    self.returns = self globallogic_score::getpersstat( "returns" );
    self globallogic_score::initpersstat( "captures", 0 );
    self.captures = self globallogic_score::getpersstat( "captures" );
    self globallogic_score::initpersstat( "objtime", 0 );
    self.objtime = self globallogic_score::getpersstat( "objtime" );
    self globallogic_score::initpersstat( "carries", 0 );
    self.carries = self globallogic_score::getpersstat( "carries" );
    self globallogic_score::initpersstat( "throws", 0 );
    self.throws = self globallogic_score::getpersstat( "throws" );
    self globallogic_score::initpersstat( "destructions", 0 );
    self.destructions = self globallogic_score::getpersstat( "destructions" );
    self globallogic_score::initpersstat( "disables", 0 );
    self.disables = self globallogic_score::getpersstat( "disables" );
    self globallogic_score::initpersstat( "escorts", 0 );
    self.escorts = self globallogic_score::getpersstat( "escorts" );
    self globallogic_score::initpersstat( "sbtimeplayed", 0 );
    self.sbtimeplayed = self globallogic_score::getpersstat( "sbtimeplayed" );
    self globallogic_score::initpersstat( "backstabs", 0 );
    self.backstabs = self globallogic_score::getpersstat( "backstabs" );
    self globallogic_score::initpersstat( "longshots", 0 );
    self.longshots = self globallogic_score::getpersstat( "longshots" );
    self globallogic_score::initpersstat( "survived", 0 );
    self.survived = self globallogic_score::getpersstat( "survived" );
    self globallogic_score::initpersstat( "stabs", 0 );
    self.stabs = self globallogic_score::getpersstat( "stabs" );
    self globallogic_score::initpersstat( "tomahawks", 0 );
    self.tomahawks = self globallogic_score::getpersstat( "tomahawks" );
    self globallogic_score::initpersstat( "humiliated", 0 );
    self.humiliated = self globallogic_score::getpersstat( "humiliated" );
    self globallogic_score::initpersstat( "x2score", 0 );
    self.x2score = self globallogic_score::getpersstat( "x2score" );
    self globallogic_score::initpersstat( "agrkills", 0 );
    self.x2score = self globallogic_score::getpersstat( "agrkills" );
    self globallogic_score::initpersstat( "hacks", 0 );
    self.x2score = self globallogic_score::getpersstat( "hacks" );
    self globallogic_score::initpersstat( "killsconfirmed", 0 );
    self.killsconfirmed = self globallogic_score::getpersstat( "killsconfirmed" );
    self globallogic_score::initpersstat( "killsdenied", 0 );
    self.killsdenied = self globallogic_score::getpersstat( "killsdenied" );
    self globallogic_score::initpersstat( "rescues", 0 );
    self.rescues = self globallogic_score::getpersstat( "rescues" );
    self globallogic_score::initpersstat( "shotsfired", 0 );
    self.shotsfired = self globallogic_score::getpersstat( "shotsfired" );
    self globallogic_score::initpersstat( "shotshit", 0 );
    self.shotshit = self globallogic_score::getpersstat( "shotshit" );
    self globallogic_score::initpersstat( "shotsmissed", 0 );
    self.shotsmissed = self globallogic_score::getpersstat( "shotsmissed" );
    self globallogic_score::initpersstat( "victory", 0 );
    self.victory = self globallogic_score::getpersstat( "victory" );
    self globallogic_score::initpersstat( "sessionbans", 0 );
    self.sessionbans = self globallogic_score::getpersstat( "sessionbans" );
    self globallogic_score::initpersstat( "gametypeban", 0 );
    self globallogic_score::initpersstat( "time_played_total", 0 );
    self globallogic_score::initpersstat( "time_played_alive", 0 );
    self globallogic_score::initpersstat( "teamkills", 0 );
    self globallogic_score::initpersstat( "teamkills_nostats", 0 );
    self globallogic_score::initpersstat( "kill_distances", 0 );
    self globallogic_score::initpersstat( "num_kill_distance_entries", 0 );
    self globallogic_score::initpersstat( "time_played_moving", 0 );
    self globallogic_score::initpersstat( "total_speeds_when_moving", 0 );
    self globallogic_score::initpersstat( "num_speeds_when_moving_entries", 0 );
    self globallogic_score::initpersstat( "total_distance_travelled", 0 );
    self globallogic_score::initpersstat( "movement_Update_Count", 0 );
}

/#

    // Namespace globallogic_player/globallogic_player
    // Params 0
    // Checksum 0x391a63a8, Offset: 0x5230
    // Size: 0x30e, Type: dev
    function function_54719ee3()
    {
        self endon( #"disconnect" );
        
        while ( !isdefined( level.inprematchperiod ) || level.inprematchperiod )
        {
            waitframe( 10 );
        }
        
        while ( true )
        {
            tokens = getdvarint( "<dev string:xab>", 0 );
            lplevel = getdvarint( "<dev string:xbd>", 0 );
            
            if ( tokens > 0 )
            {
                foreach ( player in level.players )
                {
                    if ( !isplayer( player ) )
                    {
                        continue;
                    }
                    
                    player.pers[ "<dev string:xce>" ].tokens = tokens;
                    player clientfield::set_player_uimodel( "<dev string:xd7>", player.pers[ "<dev string:xce>" ].tokens );
                }
                
                setdvar( "<dev string:xab>", 0 );
                tokens = 0;
            }
            
            if ( lplevel > 0 )
            {
                foreach ( player in level.players )
                {
                    if ( !isplayer( player ) )
                    {
                        continue;
                    }
                    
                    player.pers[ "<dev string:xce>" ].lplevel = lplevel - 1;
                    player.lplevel = player.pers[ "<dev string:xce>" ].lplevel;
                    player clientfield::set_player_uimodel( "<dev string:xf5>", player.pers[ "<dev string:xce>" ].lplevel );
                }
                
                setdvar( "<dev string:xbd>", 0 );
                lplevel = 0;
            }
            
            waitframe( 5 );
        }
    }

#/

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x19632f30, Offset: 0x5548
// Size: 0x424
function function_93bcbc1e()
{
    if ( !isdefined( self.pers[ "lpSystem" ] ) )
    {
        self.pers[ "lpSystem" ] = spawnstruct();
        self.pers[ "lpSystem" ].slots = [];
        self.pers[ "lpSystem" ].slots[ "majorSlot1" ] = spawnstruct();
        self.pers[ "lpSystem" ].slots[ "majorSlot2" ] = spawnstruct();
        self.pers[ "lpSystem" ].slots[ "generalSlot1" ] = spawnstruct();
        self.pers[ "lpSystem" ].slots[ "generalSlot2" ] = spawnstruct();
        self.pers[ "lpSystem" ].slots[ "generalSlot3" ] = spawnstruct();
        self.pers[ "lpSystem" ].slots[ "generalSlot4" ] = spawnstruct();
        self.pers[ "lpSystem" ].var_44f5b513 = [];
        self.pers[ "lpSystem" ].var_44f5b513[ 0 ] = "major1";
        self.pers[ "lpSystem" ].var_44f5b513[ 1 ] = "major2";
        self.pers[ "lpSystem" ].var_44f5b513[ 2 ] = "general1";
        self.pers[ "lpSystem" ].var_44f5b513[ 3 ] = "general2";
        self.pers[ "lpSystem" ].var_44f5b513[ 4 ] = "general3";
        self.pers[ "lpSystem" ].var_44f5b513[ 5 ] = "general4";
        self.pers[ "lpSystem" ].var_b1a84bfe = [];
        self.pers[ "lpSystem" ].var_b1a84bfe[ "heroweapon" ] = spawnstruct();
        self.pers[ "lpSystem" ].var_b1a84bfe[ "secondary" ] = spawnstruct();
        self.pers[ "lpSystem" ].var_b1a84bfe[ "specialgrenade" ] = spawnstruct();
        self.pers[ "lpSystem" ].var_b1a84bfe[ "herogadget" ] = spawnstruct();
        self.pers[ "lpSystem" ].perks = [];
        function_5e7bd9e1();
    }
    
    self menus::register_menu_response_callback( "LevelUp", &function_f7e16a90 );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x40e766c9, Offset: 0x5978
// Size: 0x398
function function_5e7bd9e1()
{
    self.pers[ "lpSystem" ].lplevel = 0;
    self.pers[ "lpSystem" ].total = 0;
    self.pers[ "lpSystem" ].tokens = 0;
    self.var_14eb85c = 0;
    self.pers[ "lpSystem" ].var_b1a84bfe[ "heroweapon" ].slotname = "";
    self.pers[ "lpSystem" ].var_b1a84bfe[ "secondary" ].slotname = "";
    self.pers[ "lpSystem" ].var_b1a84bfe[ "specialgrenade" ].slotname = "";
    self.pers[ "lpSystem" ].var_b1a84bfe[ "herogadget" ].slotname = "";
    self.pers[ "lpSystem" ].var_b1a84bfe[ "heroweapon" ].weapon = level.weaponnone;
    self.pers[ "lpSystem" ].var_b1a84bfe[ "secondary" ].weapon = level.weaponnone;
    self.pers[ "lpSystem" ].var_b1a84bfe[ "specialgrenade" ].weapon = level.weaponnone;
    self.pers[ "lpSystem" ].var_b1a84bfe[ "herogadget" ].weapon = level.weaponnone;
    self.pers[ "lpSystem" ].slots[ "majorSlot1" ].var_8f2ea589 = 0;
    self.pers[ "lpSystem" ].slots[ "majorSlot2" ].var_8f2ea589 = 0;
    self.pers[ "lpSystem" ].slots[ "generalSlot1" ].var_8f2ea589 = 0;
    self.pers[ "lpSystem" ].slots[ "generalSlot2" ].var_8f2ea589 = 0;
    self.pers[ "lpSystem" ].slots[ "generalSlot3" ].var_8f2ea589 = 0;
    self.pers[ "lpSystem" ].slots[ "generalSlot4" ].var_8f2ea589 = 0;
    self.pers[ "lpSystem" ].perks = [];
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xd0a93832, Offset: 0x5d18
// Size: 0x1f6
function function_5e3d5a6d()
{
    self.var_14eb85c = globallogic_score::function_26d9328e( self );
    self clientfield::set_player_uimodel( "hudItems.lplevel.progress", isdefined( self.var_14eb85c ) ? self.var_14eb85c : 0 );
    self clientfield::set_player_uimodel( "hudItems.lplevel.level", self.pers[ "lpSystem" ].lplevel );
    self clientfield::set_player_uimodel( "hudItems.lplevel.unlockTokens", self.pers[ "lpSystem" ].tokens );
    self clientfield::set_player_uimodel( "hudItems.lplevel.majorSlot1.level", self.pers[ "lpSystem" ].slots[ "majorSlot1" ].var_8f2ea589 );
    self clientfield::set_player_uimodel( "hudItems.lplevel.majorSlot2.level", self.pers[ "lpSystem" ].slots[ "majorSlot2" ].var_8f2ea589 );
    
    for ( i = 1; i <= 4 ; i++ )
    {
        self clientfield::set_player_uimodel( "hudItems.lplevel.generalSlot" + i + ".level", self.pers[ "lpSystem" ].slots[ "generalSlot" + i ].var_8f2ea589 );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x423cd95e, Offset: 0x5f18
// Size: 0x2c0
function function_92347f11( unlockitem, slotname )
{
    var_377d9249 = 0;
    loadoutslotname = unlockitem.loadoutslotname;
    var_2494ec3d = self.pers[ "lpSystem" ].var_b1a84bfe[ loadoutslotname ].slotname;
    
    if ( var_2494ec3d != "" )
    {
        if ( self.pers[ "lpSystem" ].slots[ slotname ].var_8f2ea589 <= 0 )
        {
            self.pers[ "lpSystem" ].tokens--;
            var_377d9249 = 1;
        }
        
        if ( loadoutslotname != "secondary" || var_377d9249 )
        {
            self.pers[ "lpSystem" ].slots[ var_2494ec3d ].var_8f2ea589 = 1;
            self.pers[ "lpSystem" ].slots[ slotname ].var_8f2ea589 = 2;
            self clientfield::set_player_uimodel( "hudItems.lplevel." + var_2494ec3d + ".level", self.pers[ "lpSystem" ].slots[ var_2494ec3d ].var_8f2ea589 );
        }
        else if ( slotname != var_2494ec3d )
        {
            self.pers[ "lpSystem" ].var_b1a84bfe[ "secondary" ].var_2cc42d7 = var_2494ec3d;
        }
    }
    else
    {
        if ( self.pers[ "lpSystem" ].slots[ slotname ].var_8f2ea589 <= 0 )
        {
            self.pers[ "lpSystem" ].tokens--;
        }
        
        self.pers[ "lpSystem" ].slots[ slotname ].var_8f2ea589 = 2;
        var_377d9249 = 1;
    }
    
    self.pers[ "lpSystem" ].var_b1a84bfe[ loadoutslotname ].slotname = slotname;
    return var_377d9249;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xb58eb590, Offset: 0x61e0
// Size: 0xc6c
function function_f7e16a90( response )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.pers[ "lpSystem" ].blockui === 1 )
    {
        return;
    }
    
    args = strtok( response, "," );
    self luinotifyevent( &"levelup", 1, int( args[ 1 ] ) );
    unlockitem = getunlockableiteminfofromindex( int( args[ 1 ] ) );
    slotname = args[ 0 ];
    var_fb5e848e = int( args[ 2 ] );
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    
    if ( issubstr( unlockitem.loadoutslotname, "killstreak" ) )
    {
        self.pers[ "lpSystem" ].blockui = 1;
        
        if ( issubstr( unlockitem.name, "marker" ) )
        {
            weapon = getweapon( unlockitem.name );
            self giveweapon( weapon );
            self switchtoweapon( weapon );
            self givemaxammo( weapon );
        }
        else if ( unlockitem.name === "microwave_turret_deploy" )
        {
            thread killstreaks::usekillstreak( "microwave_turret", 0 );
        }
        else if ( unlockitem.name === "emp" )
        {
            thread killstreaks::usekillstreak( unlockitem.name, 0 );
        }
        else if ( unlockitem.name === "dart" )
        {
            weapon = getweapon( "inventory_dart" );
            self giveweapon( weapon );
            self switchtoweapon( weapon );
            self givemaxammo( weapon );
        }
        else
        {
            thread killstreaks::usekillstreak( unlockitem.name, 0 );
        }
        
        self.pers[ "lpSystem" ].tokens--;
    }
    else if ( unlockitem.loadoutslotname == "heroweapon" )
    {
        var_377d9249 = self function_92347f11( unlockitem, slotname );
        
        if ( isdefined( self.heavyweapon ) )
        {
            self takeweapon( self.heavyweapon );
        }
        
        weapon = getweapon( unlockitem.name );
        self giveweapon( weapon );
        self.heavyweapon = weapon;
        
        if ( var_377d9249 )
        {
            self gadgetpowerset( self gadgetgetslot( weapon ), 100 );
        }
        else
        {
            self gadgetpowerset( self gadgetgetslot( weapon ), 0 );
        }
        
        self.pers[ "lpSystem" ].var_b1a84bfe[ "heroweapon" ].weapon = weapon;
    }
    else if ( unlockitem.loadoutslotname == "secondary" )
    {
        var_377d9249 = self function_92347f11( unlockitem, slotname );
        weapon = getweapon( unlockitem.name );
        
        if ( var_377d9249 )
        {
            if ( isdefined( self.secondaryloadoutweapon ) )
            {
                self takeweapon( self.secondaryloadoutweapon );
            }
            else
            {
                self takeweapon( level.weaponbasemeleeheld );
            }
            
            secondaryweaponoptions = self calcweaponoptions( self.class_num, 1 );
            acvi = self getattachmentcosmeticvariantforweapon( self.class_num, "secondary" );
            self giveweapon( weapon, secondaryweaponoptions, acvi );
            self switchtoweapon( weapon );
        }
        
        self.secondaryloadoutweapon = weapon;
        self.var_f8a642e8 = weapon.altweapon;
        self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex( self.class_num, 1 );
        self.pers[ "lpSystem" ].var_b1a84bfe[ "secondary" ].weapon = weapon;
    }
    else if ( unlockitem.loadoutslotname == "specialgrenade" )
    {
        var_377d9249 = self function_92347f11( unlockitem, slotname );
        weapon = getweapon( unlockitem.name );
        
        if ( isdefined( self.grenadetypesecondary ) )
        {
            self takeweapon( self.grenadetypesecondary );
        }
        
        self giveweapon( weapon );
        
        if ( var_377d9249 )
        {
            self setweaponammoclip( weapon, weapon.startammo );
        }
        else
        {
            self setweaponammoclip( weapon, 0 );
        }
        
        self switchtooffhand( weapon );
        self.grenadetypesecondary = weapon;
        self.grenadetypesecondarycount = weapon.startammo;
        self.pers[ "lpSystem" ].var_b1a84bfe[ "specialgrenade" ].weapon = weapon;
    }
    else if ( unlockitem.loadoutslotname == "herogadget" )
    {
        var_377d9249 = self function_92347f11( unlockitem, slotname );
        
        if ( isdefined( self.var_66cb8722 ) )
        {
            self takeweapon( self.var_66cb8722 );
        }
        
        weapon = getweapon( unlockitem.name );
        self giveweapon( weapon );
        self setweaponammoclip( weapon, weapon.startammo );
        self switchtooffhand( weapon );
        self.var_66cb8722 = weapon;
        self.var_877b90bf = weapon.startammo;
        
        if ( var_377d9249 )
        {
            self gadgetpowerset( self gadgetgetslot( weapon ), 100 );
        }
        else
        {
            self gadgetpowerset( self gadgetgetslot( weapon ), 0 );
        }
        
        self.pers[ "lpSystem" ].var_b1a84bfe[ "herogadget" ].weapon = weapon;
    }
    else if ( unlockitem.itemgroupname == "specialty" )
    {
        if ( var_fb5e848e == 1 )
        {
            self.pers[ "lpSystem" ].slots[ slotname ].var_8f2ea589 = 2;
        }
        
        self.pers[ "lpSystem" ].tokens--;
        
        for ( i = 0; i < unlockitem.specialties.size ; i++ )
        {
            self setperk( unlockitem.specialties[ i ] );
            array::push_front( self.pers[ "lpSystem" ].perks, unlockitem.specialties[ i ] );
        }
        
        if ( self hasperk( "specialty_armor" ) || self hasperk( "specialty_armor_tier_two" ) || self hasperk( "specialty_armor_tier_three" ) )
        {
            self armor::function_b9712125();
            self.maxarmor = self.spawnarmor;
            self.armor = self.maxarmor;
        }
    }
    else
    {
        assertmsg( "<dev string:x10c>" + unlockitem.loadoutslotname );
    }
    
    self clientfield::set_player_uimodel( "hudItems.lplevel.unlockTokens", self.pers[ "lpSystem" ].tokens );
    self clientfield::set_player_uimodel( "hudItems.lplevel." + slotname + ".level", self.pers[ "lpSystem" ].slots[ slotname ].var_8f2ea589 );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x729ec5c3, Offset: 0x6e58
// Size: 0x1684
function callback_playerconnect()
{
    thread notifyconnecting();
    self.statusicon = "hud_status_connecting";
    self waittill( "begin" );
    
    if ( isdefined( level.reset_clientdvars ) )
    {
        self [[ level.reset_clientdvars ]]();
    }
    
    waittillframeend();
    self.statusicon = "";
    self.guid = self getguid();
    self.killstreak = [];
    self.leaderdialogqueue = [];
    self.killstreakdialogqueue = [];
    profilelog_begintiming( 4, "ship" );
    level notify( #"connected", { #player:self } );
    callback::callback( #"hash_eaffea17" );
    
    if ( self ishost() )
    {
        self thread globallogic::listenforgameend();
    }
    
    if ( !level.splitscreen && !isdefined( self.pers[ "score" ] ) )
    {
        iprintln( &"MP_CONNECTED", self );
    }
    
    if ( !isdefined( self.pers[ "score" ] ) )
    {
        self thread persistence::adjust_recent_stats();
        self persistence::set_after_action_report_stat( "valid", 0 );
        
        if ( gamemodeismode( 3 ) && !self ishost() )
        {
            self persistence::set_after_action_report_stat( "wagerMatchFailed", 1 );
        }
        else
        {
            self persistence::set_after_action_report_stat( "wagerMatchFailed", 0 );
        }
    }
    
    if ( ( level.rankedmatch || level.wagermatch || level.leaguematch ) && !isdefined( self.pers[ "matchesPlayedStatsTracked" ] ) )
    {
        gamemode = util::getcurrentgamemode();
        self globallogic::incrementmatchcompletionstat( gamemode, "played", "started" );
        
        if ( !isdefined( self.pers[ "matchesHostedStatsTracked" ] ) && self islocaltohost() )
        {
            self globallogic::incrementmatchcompletionstat( gamemode, "hosted", "started" );
            self.pers[ "matchesHostedStatsTracked" ] = 1;
        }
        
        self.pers[ "matchesPlayedStatsTracked" ] = 1;
        self thread persistence::upload_stats_soon();
    }
    
    self gamerep::gamerepplayerconnected();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    lpxuid = self getxuid( 1 );
    
    /#
        logprint( "<dev string:x129>" + lpguid + "<dev string:x12c>" + lpselfnum + "<dev string:x12c>" + self.name + "<dev string:x12e>" );
    #/
    
    bbprint( "global_joins", "name %s client %s xuid %s", self.name, lpselfnum, lpxuid );
    recordplayerstats( self, "codeClientNum", lpselfnum );
    
    if ( !sessionmodeiszombiesgame() )
    {
        self setclientuivisibilityflag( "hud_visible", 1 );
        self setclientuivisibilityflag( "weapon_hud_visible", 1 );
    }
    
    self setclientplayersprinttime( level.playersprinttime );
    self setclientnumlives( level.numlives );
    
    if ( level.hardcoremode )
    {
        self setclientdrawtalk( 3 );
    }
    
    level.escalationenabled = getgametypesetting( "escalationEnabled" );
    self function_a858463d();
    self function_93bcbc1e();
    self.teamkillpunish = 0;
    
    if ( level.minimumallowedteamkills >= 0 && self.pers[ "teamkills_nostats" ] > level.minimumallowedteamkills )
    {
        self thread function_a1ea27f6();
    }
    
    self behaviortracker::initialize();
    self.killedplayerscurrent = [];
    
    if ( !isdefined( self.pers[ "totalTimePlayed" ] ) )
    {
        self setentertime( gettime() );
        self.pers[ "totalTimePlayed" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "totalMatchBonus" ] ) )
    {
        self.pers[ "totalMatchBonus" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "best_kill_streak" ] ) )
    {
        self.pers[ "killed_players" ] = [];
        self.pers[ "killed_by" ] = [];
        self.pers[ "nemesis_tracking" ] = [];
        self.pers[ "artillery_kills" ] = 0;
        self.pers[ "dog_kills" ] = 0;
        self.pers[ "nemesis_name" ] = "";
        self.pers[ "nemesis_rank" ] = 0;
        self.pers[ "nemesis_rankIcon" ] = 0;
        self.pers[ "nemesis_xp" ] = 0;
        self.pers[ "nemesis_xuid" ] = "";
        self.pers[ "killed_players_with_specialist" ] = [];
        self.pers[ "best_kill_streak" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "music" ] ) )
    {
        self.pers[ "music" ] = spawnstruct();
        self.pers[ "music" ].spawn = 0;
        self.pers[ "music" ].inque = 0;
        self.pers[ "music" ].currentstate = "SILENT";
        self.pers[ "music" ].previousstate = "SILENT";
        self.pers[ "music" ].nextstate = "UNDERSCORE";
        self.pers[ "music" ].returnstate = "UNDERSCORE";
    }
    
    if ( self.team != "spectator" )
    {
        self thread globallogic_audio::set_music_on_player( "spawnPreLoop" );
    }
    
    if ( !isdefined( self.pers[ "cur_kill_streak" ] ) )
    {
        self.pers[ "cur_kill_streak" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "cur_total_kill_streak" ] ) )
    {
        self.pers[ "cur_total_kill_streak" ] = 0;
        self setplayercurrentstreak( 0 );
    }
    
    if ( !isdefined( self.pers[ "totalKillstreakCount" ] ) )
    {
        self.pers[ "totalKillstreakCount" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "killstreaksEarnedThisKillstreak" ] ) )
    {
        self.pers[ "killstreaksEarnedThisKillstreak" ] = 0;
    }
    
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers[ "killstreak_quantity" ] ) )
    {
        self.pers[ "killstreak_quantity" ] = [];
    }
    
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers[ "held_killstreak_ammo_count" ] ) )
    {
        self.pers[ "held_killstreak_ammo_count" ] = [];
    }
    
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers[ "held_killstreak_clip_count" ] ) )
    {
        self.pers[ "held_killstreak_clip_count" ] = [];
    }
    
    if ( !isdefined( self.pers[ "changed_class" ] ) )
    {
        self.pers[ "changed_class" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "lastroundscore" ] ) )
    {
        self.pers[ "lastroundscore" ] = 0;
    }
    
    self.lastkilltime = 0;
    self.cur_death_streak = 0;
    self disabledeathstreak();
    self.death_streak = 0;
    self.kill_streak = 0;
    self.gametype_kill_streak = 0;
    self.spawnqueueindex = -1;
    self.deathtime = 0;
    self.alivetimes = [];
    
    for ( index = 0; index < level.alivetimemaxcount ; index++ )
    {
        self.alivetimes[ index ] = 0;
    }
    
    self.alivetimecurrentindex = 0;
    
    if ( level.onlinegame && !( isdefined( level.freerun ) && level.freerun ) )
    {
        self.death_streak = self getdstat( "HighestStats", "death_streak" );
        self.kill_streak = self getdstat( "HighestStats", "kill_streak" );
        self.gametype_kill_streak = self persistence::function_2369852e( "kill_streak" );
    }
    
    self.lastgrenadesuicidetime = -1;
    self.teamkillsthisround = 0;
    
    if ( !isdefined( level.livesdonotreset ) || !level.livesdonotreset || !isdefined( self.pers[ "lives" ] ) )
    {
        self.pers[ "lives" ] = level.numlives;
    }
    
    if ( !level.teambased )
    {
        self.pers[ "team" ] = undefined;
    }
    
    self.hasspawned = 0;
    self.waitingtospawn = 0;
    self.wantsafespawn = 0;
    self.deathcount = 0;
    self.wasaliveatmatchstart = 0;
    level.players[ level.players.size ] = self;
    
    if ( level.splitscreen )
    {
        setdvar( "splitscreen_playerNum", level.players.size );
    }
    
    if ( game.state == "postgame" )
    {
        self.pers[ "needteam" ] = 1;
        self.pers[ "team" ] = "spectator";
        self.team = self.sessionteam;
        self setclientuivisibilityflag( "hud_visible", 0 );
        self [[ level.spawnintermission ]]();
        self closeingamemenu();
        profilelog_endtiming( 4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
        return;
    }
    
    if ( ( level.rankedmatch || level.wagermatch || level.leaguematch ) && !isdefined( self.pers[ "lossAlreadyReported" ] ) )
    {
        globallogic_score::updatelossstats( self );
        self.pers[ "lossAlreadyReported" ] = 1;
    }
    
    if ( ( level.rankedmatch || level.leaguematch ) && !isdefined( self.pers[ "lateJoin" ] ) )
    {
        if ( game.state == "playing" && !level.inprematchperiod )
        {
            self.pers[ "lateJoin" ] = 1;
        }
        else
        {
            self.pers[ "lateJoin" ] = 0;
        }
    }
    
    if ( !isdefined( self.pers[ "winstreakAlreadyCleared" ] ) )
    {
        self globallogic_score::backupandclearwinstreaks();
        self.pers[ "winstreakAlreadyCleared" ] = 1;
    }
    
    if ( self istestclient() )
    {
        recordplayerstats( self, "isBot", 1 );
    }
    
    if ( level.rankedmatch || level.leaguematch )
    {
        self persistence::set_after_action_report_stat( "demoFileID", "0" );
    }
    
    level endon( #"game_ended" );
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        self thread hostmigration::hostmigrationtimerthink();
    }
    
    if ( isdefined( self.pers[ "team" ] ) )
    {
        self.team = self.pers[ "team" ];
    }
    
    if ( isdefined( self.pers[ "class" ] ) )
    {
        self.curclass = self.pers[ "class" ];
    }
    
    if ( isdefined( self.pers[ "lpSystem" ] ) )
    {
        self.lplevel = self.pers[ "lpSystem" ].lplevel;
    }
    
    init_character_index();
    
    if ( !isdefined( self.pers[ "team" ] ) || isdefined( self.pers[ "needteam" ] ) )
    {
        self.pers[ "needteam" ] = undefined;
        self.pers[ "team" ] = "spectator";
        self.team = "spectator";
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        [[ level.autoassign ]]( 0 );
        
        if ( level.rankedmatch || level.leaguematch )
        {
            self thread globallogic_spawn::kickifdontspawn();
        }
        
        if ( self.pers[ "team" ] == "spectator" )
        {
            self.sessionteam = "spectator";
            self thread spectate_player_watcher();
        }
        
        if ( level.teambased )
        {
            self.sessionteam = self.pers[ "team" ];
            
            if ( !isalive( self ) )
            {
                self.statusicon = "hud_status_dead";
            }
            
            self thread spectating::set_permissions();
        }
    }
    else if ( self.pers[ "team" ] == "spectator" )
    {
        self setclientscriptmainmenu( game.menu[ "menu_start_menu" ] );
        [[ level.spawnspectator ]]();
        self.sessionteam = "spectator";
        self.sessionstate = "spectator";
        self thread spectate_player_watcher();
    }
    else
    {
        self.sessionteam = self.pers[ "team" ];
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        
        if ( !draft::is_draft_this_round() )
        {
            if ( globallogic_utils::isvalidclass( self.pers[ "class" ] ) )
            {
                self thread [[ level.spawnclient ]]();
            }
            else
            {
                self globallogic_ui::showmainmenuforteam();
            }
        }
        
        self thread spectating::set_permissions();
    }
    
    if ( self.sessionteam != "spectator" )
    {
        self thread spawning::onspawnplayer( 1 );
    }
    
    if ( level.forceradar == 1 )
    {
        self.pers[ "hasRadar" ] = 1;
        self.hasspyplane = 1;
        
        if ( level.teambased )
        {
            level.activeuavs[ self.team ]++;
        }
        else
        {
            level.activeuavs[ self getentitynumber() ]++;
        }
        
        level.activeplayeruavs[ self getentitynumber() ]++;
    }
    
    if ( level.forceradar == 2 )
    {
        self setclientuivisibilityflag( "g_compassShowEnemies", level.forceradar );
    }
    else
    {
        self setclientuivisibilityflag( "g_compassShowEnemies", 0 );
    }
    
    profilelog_endtiming( 4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
    
    if ( self isbot() )
    {
        return;
    }
    
    self record_global_mp_stats_for_player_at_match_start();
    num_con = getnumconnectedplayers();
    num_exp = getnumexpectedplayers();
    println( "<dev string:x130>", num_con, "<dev string:x161>", num_exp );
    
    if ( num_con == num_exp && num_exp != 0 )
    {
        level flag::set( "all_players_connected" );
    }
    
    globallogic_score::updateweaponcontractstart( self );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x9a85c2a6, Offset: 0x84e8
// Size: 0x64
function init_character_index()
{
    if ( !draft::is_draft_this_round() && player_role::is_valid( self.pers[ "characterIndex" ] ) )
    {
        player_role::set( self.pers[ "characterIndex" ] );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xcd87b481, Offset: 0x8558
// Size: 0x4d4
function record_global_mp_stats_for_player_at_match_start()
{
    if ( isdefined( level.disablestattracking ) && level.disablestattracking == 1 )
    {
        return;
    }
    
    startkills = self getdstat( "playerstatslist", "kills", "statValue" );
    startdeaths = self getdstat( "playerstatslist", "deaths", "statValue" );
    startwins = self getdstat( "playerstatslist", "wins", "statValue" );
    startlosses = self getdstat( "playerstatslist", "losses", "statValue" );
    starthits = self getdstat( "playerstatslist", "hits", "statValue" );
    startmisses = self getdstat( "playerstatslist", "misses", "statValue" );
    starttimeplayedtotal = self getdstat( "playerstatslist", "time_played_total", "statValue" );
    startscore = self getdstat( "playerstatslist", "score", "statValue" );
    startprestige = self getdstat( "playerstatslist", "plevel", "statValue" );
    startunlockpoints = self getdstat( "unlocks", 0 );
    ties = self getdstat( "playerstatslist", "ties", "statValue" );
    startgamesplayed = startwins + startlosses + ties;
    self.startkills = startkills;
    self.starthits = starthits;
    self.totalmatchshots = 0;
    recordplayerstats( self, "startKills", startkills );
    recordplayerstats( self, "startDeaths", startdeaths );
    recordplayerstats( self, "startWins", startwins );
    recordplayerstats( self, "startLosses", startlosses );
    recordplayerstats( self, "startHits", starthits );
    recordplayerstats( self, "startMisses", startmisses );
    recordplayerstats( self, "startTimePlayedTotal", starttimeplayedtotal );
    recordplayerstats( self, "startScore", startscore );
    recordplayerstats( self, "startPrestige", startprestige );
    recordplayerstats( self, "startUnlockPoints", startunlockpoints );
    recordplayerstats( self, "startGamesPlayed", startgamesplayed );
    lootxpbeforematch = self getdstat( "AfterActionReportStats", "lootXPBeforeMatch" );
    cryptokeysbeforematch = self getdstat( "AfterActionReportStats", "cryptoKeysBeforeMatch" );
    recordplayerstats( self, "lootXPBeforeMatch", lootxpbeforematch );
    recordplayerstats( self, "cryptoKeysBeforeMatch", cryptokeysbeforematch );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x85e73f6f, Offset: 0x8a38
// Size: 0x3fc
function record_global_mp_stats_for_player_at_match_end()
{
    if ( isdefined( level.disablestattracking ) && level.disablestattracking == 1 )
    {
        return;
    }
    
    endkills = self getdstat( "playerstatslist", "kills", "statValue" );
    enddeaths = self getdstat( "playerstatslist", "deaths", "statValue" );
    endwins = self getdstat( "playerstatslist", "wins", "statValue" );
    endlosses = self getdstat( "playerstatslist", "losses", "statValue" );
    endhits = self getdstat( "playerstatslist", "hits", "statValue" );
    endmisses = self getdstat( "playerstatslist", "misses", "statValue" );
    endtimeplayedtotal = self getdstat( "playerstatslist", "time_played_total", "statValue" );
    endscore = self getdstat( "playerstatslist", "score", "statValue" );
    endprestige = self getdstat( "playerstatslist", "plevel", "statValue" );
    endunlockpoints = self getdstat( "unlocks", 0 );
    ties = self getdstat( "playerstatslist", "ties", "statValue" );
    endgamesplayed = endwins + endlosses + ties;
    recordplayerstats( self, "endKills", endkills );
    recordplayerstats( self, "endDeaths", enddeaths );
    recordplayerstats( self, "endWins", endwins );
    recordplayerstats( self, "endLosses", endlosses );
    recordplayerstats( self, "endHits", endhits );
    recordplayerstats( self, "endMisses", endmisses );
    recordplayerstats( self, "endTimePlayedTotal", endtimeplayedtotal );
    recordplayerstats( self, "endScore", endscore );
    recordplayerstats( self, "endPrestige", endprestige );
    recordplayerstats( self, "endUnlockPoints", endunlockpoints );
    recordplayerstats( self, "endGamesPlayed", endgamesplayed );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xa2cceb9c, Offset: 0x8e40
// Size: 0x214
function record_misc_player_stats()
{
    if ( isdefined( level.disablestattracking ) && level.disablestattracking == 1 )
    {
        return;
    }
    
    recordplayerstats( self, "UTCEndTimeSeconds", getutc() );
    
    if ( isdefined( self.weaponpickupscount ) )
    {
        recordplayerstats( self, "weaponPickupsCount", self.weaponpickupscount );
    }
    
    if ( isdefined( self.killcamsskipped ) )
    {
        recordplayerstats( self, "totalKillcamsSkipped", self.killcamsskipped );
    }
    
    if ( isdefined( self.matchbonus ) )
    {
        recordplayerstats( self, "matchXp", self.matchbonus );
    }
    
    if ( isdefined( self.killsdenied ) )
    {
        recordplayerstats( self, "killsDenied", self.killsdenied );
    }
    
    if ( isdefined( self.killsconfirmed ) )
    {
        recordplayerstats( self, "killsConfirmed", self.killsconfirmed );
    }
    
    if ( self issplitscreen() )
    {
        recordplayerstats( self, "isSplitscreen", 1 );
    }
    
    if ( self.objtime )
    {
        recordplayerstats( self, "objectiveTime", self.objtime );
    }
    
    if ( self.escorts )
    {
        recordplayerstats( self, "escortTime", self.escorts );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xfa6cab14, Offset: 0x9060
// Size: 0x2dc
function spectate_player_watcher()
{
    self endon( #"disconnect" );
    
    if ( !level.splitscreen && !level.hardcoremode && getdvarint( "scr_showperksonspawn" ) == 1 && game.state != "postgame" && !isdefined( self.perkhudelem ) )
    {
        if ( level.perksenabled == 1 )
        {
            self hud::showperks();
        }
    }
    
    self.watchingactiveclient = 1;
    self.var_f2e9a21a = undefined;
    
    while ( true )
    {
        if ( self.pers[ "team" ] != "spectator" || level.gameended )
        {
            self hud_message::function_b17b90b9();
            
            if ( !( isdefined( level.inprematchperiod ) && level.inprematchperiod ) )
            {
                self val::reset( "spectate", "freezecontrols" );
            }
            
            self.watchingactiveclient = 0;
            break;
        }
        
        count = 0;
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ].team != "spectator" )
            {
                count++;
                break;
            }
        }
        
        if ( count > 0 )
        {
            if ( !self.watchingactiveclient )
            {
                self hud_message::function_b17b90b9();
                self val::reset( "spectate", "freezecontrols" );
                self luinotifyevent( &"player_spawned", 0 );
            }
            
            self.watchingactiveclient = 1;
        }
        else
        {
            if ( self.watchingactiveclient )
            {
                [[ level.onspawnspectator ]]();
                self val::set( "spectate", "freezecontrols", 1 );
                self hud_message::function_b5203d90();
            }
            
            self.watchingactiveclient = 0;
        }
        
        wait 0.5;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x8c08fa98, Offset: 0x9348
// Size: 0xcc
function callback_playermigrated()
{
    println( "<dev string:x178>" + self.name + "<dev string:x180>" + gettime() );
    
    if ( isdefined( self.connected ) && self.connected )
    {
        self globallogic_ui::updateobjectivetext();
    }
    
    level.hostmigrationreturnedplayercount++;
    
    if ( level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3 )
    {
        println( "<dev string:x19d>" );
        level notify( #"hostmigration_enoughplayers" );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x1f325e81, Offset: 0x9420
// Size: 0x7e4
function callback_playerdisconnect()
{
    profilelog_begintiming( 5, "ship" );
    
    if ( game.state != "postgame" && !level.gameended )
    {
        gamelength = game.timepassed;
        self globallogic::bbplayermatchend( gamelength, "MP_PLAYER_DISCONNECT", 0 );
        
        if ( util::isroundbased() )
        {
            recordplayerstats( self, "playerQuitRoundNumber", game.roundsplayed + 1 );
        }
        
        if ( level.teambased )
        {
            ourteam = self.team;
            
            if ( ourteam == "allies" || ourteam == "axis" )
            {
                theirteam = "";
                
                if ( ourteam == "allies" )
                {
                    theirteam = "axis";
                }
                else if ( ourteam == "axis" )
                {
                    theirteam = "allies";
                }
                
                recordplayerstats( self, "playerQuitTeamScore", getteamscore( ourteam ) );
                recordplayerstats( self, "playerQuitOpposingTeamScore", getteamscore( theirteam ) );
            }
        }
        
        function_c92849fa( self, "disconnect" );
    }
    
    self behaviortracker::finalize();
    arrayremovevalue( level.players, self );
    
    if ( level.splitscreen )
    {
        players = level.players;
        
        if ( players.size <= 1 )
        {
            level thread globallogic::forceend();
        }
        
        setdvar( "splitscreen_playerNum", players.size );
    }
    
    if ( isdefined( self.score ) && isdefined( self.pers[ "team" ] ) )
    {
        /#
            print( "<dev string:x1c4>" + self.pers[ "<dev string:x1d1>" ] + "<dev string:x1d6>" + self.score );
        #/
        
        level.dropteam += 1;
    }
    
    [[ level.onplayerdisconnect ]]();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    
    /#
        logprint( "<dev string:x1d8>" + lpguid + "<dev string:x12c>" + lpselfnum + "<dev string:x12c>" + self.name + "<dev string:x12e>" );
    #/
    
    self record_global_mp_stats_for_player_at_match_end();
    self record_special_move_data_for_life( undefined );
    self record_misc_player_stats();
    self gamerep::gamerepplayerdisconnected();
    
    for ( entry = 0; entry < level.players.size ; entry++ )
    {
        if ( level.players[ entry ] == self )
        {
            while ( entry < level.players.size - 1 )
            {
                level.players[ entry ] = level.players[ entry + 1 ];
                entry++;
            }
            
            level.players[ entry ] = undefined;
            break;
        }
    }
    
    for ( entry = 0; entry < level.players.size ; entry++ )
    {
        if ( isdefined( level.players[ entry ].pers[ "killed_players" ][ self.name ] ) )
        {
            level.players[ entry ].pers[ "killed_players" ][ self.name ] = undefined;
        }
        
        if ( isdefined( level.players[ entry ].pers[ "killed_players_with_specialist" ][ self.name ] ) )
        {
            level.players[ entry ].pers[ "killed_players_with_specialist" ][ self.name ] = undefined;
        }
        
        if ( isdefined( level.players[ entry ].killedplayerscurrent[ self.name ] ) )
        {
            level.players[ entry ].killedplayerscurrent[ self.name ] = undefined;
        }
        
        if ( isdefined( level.players[ entry ].pers[ "killed_by" ][ self.name ] ) )
        {
            level.players[ entry ].pers[ "killed_by" ][ self.name ] = undefined;
        }
        
        if ( isdefined( level.players[ entry ].pers[ "nemesis_tracking" ][ self.name ] ) )
        {
            level.players[ entry ].pers[ "nemesis_tracking" ][ self.name ] = undefined;
        }
        
        if ( level.players[ entry ].pers[ "nemesis_name" ] == self.name )
        {
            level.players[ entry ] choosenextbestnemesis();
        }
    }
    
    if ( level.gameended )
    {
        self globallogic::removedisconnectedplayerfromplacement();
    }
    
    level thread globallogic::updateteamstatus();
    level thread globallogic::updateallalivetimes();
    profilelog_endtiming( 5, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
}

// Namespace globallogic_player/globallogic_player
// Params 8
// Checksum 0x8083846e, Offset: 0x9c10
// Size: 0xcc
function callback_playermelee( eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind )
{
    hit = 1;
    
    if ( level.teambased && self.team == eattacker.team )
    {
        if ( level.friendlyfire == 0 )
        {
            hit = 0;
        }
    }
    
    self finishmeleehit( eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xb2fbd1e5, Offset: 0x9ce8
// Size: 0x24a
function choosenextbestnemesis()
{
    nemesisarray = self.pers[ "nemesis_tracking" ];
    nemesisarraykeys = getarraykeys( nemesisarray );
    nemesisamount = 0;
    nemesisname = "";
    
    if ( nemesisarraykeys.size > 0 )
    {
        for ( i = 0; i < nemesisarraykeys.size ; i++ )
        {
            nemesisarraykey = nemesisarraykeys[ i ];
            
            if ( nemesisarray[ nemesisarraykey ] > nemesisamount )
            {
                nemesisname = nemesisarraykey;
                nemesisamount = nemesisarray[ nemesisarraykey ];
            }
        }
    }
    
    self.pers[ "nemesis_name" ] = nemesisname;
    
    if ( nemesisname != "" )
    {
        for ( playerindex = 0; playerindex < level.players.size ; playerindex++ )
        {
            if ( level.players[ playerindex ].name == nemesisname )
            {
                nemesisplayer = level.players[ playerindex ];
                self.pers[ "nemesis_rank" ] = nemesisplayer.pers[ "rank" ];
                self.pers[ "nemesis_rankIcon" ] = nemesisplayer.pers[ "rankxp" ];
                self.pers[ "nemesis_xp" ] = nemesisplayer.pers[ "prestige" ];
                self.pers[ "nemesis_xuid" ] = nemesisplayer getxuid();
                break;
            }
        }
        
        return;
    }
    
    self.pers[ "nemesis_xuid" ] = "";
}

// Namespace globallogic_player/globallogic_player
// Params 7
// Checksum 0xb5c16576, Offset: 0x9f40
// Size: 0xec
function custom_gamemodes_modified_damage( victim, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc )
{
    if ( level.onlinegame && !sessionmodeisprivate() )
    {
        return idamage;
    }
    
    if ( isdefined( eattacker ) && isdefined( eattacker.damagemodifier ) )
    {
        idamage *= eattacker.damagemodifier;
    }
    
    if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" )
    {
        idamage = int( idamage * level.bulletdamagescalar );
    }
    
    return idamage;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0x8dcfd212, Offset: 0xa038
// Size: 0x164
function figure_out_attacker( eattacker )
{
    if ( isdefined( eattacker ) )
    {
        if ( isai( eattacker ) && isdefined( eattacker.script_owner ) )
        {
            team = self.team;
            
            if ( eattacker.script_owner.team != team )
            {
                eattacker = eattacker.script_owner;
            }
        }
        
        if ( eattacker.classname == "script_vehicle" && isdefined( eattacker.owner ) )
        {
            eattacker = eattacker.owner;
        }
        else if ( eattacker.classname == "auto_turret" && isdefined( eattacker.owner ) )
        {
            eattacker = eattacker.owner;
        }
        else if ( eattacker.classname == "actor_spawner_bo3_robot_grunt_assault_mp" && isdefined( eattacker.owner ) )
        {
            eattacker = eattacker.owner;
        }
    }
    
    return eattacker;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0xb2476615, Offset: 0xa1a8
// Size: 0x184
function function_b168504f( weapon, einflictor )
{
    if ( weapon == level.weaponnone && isdefined( einflictor ) )
    {
        if ( isdefined( einflictor.targetname ) && einflictor.targetname == "explodable_barrel" )
        {
            weapon = getweapon( "explodable_barrel" );
        }
        else if ( isdefined( einflictor.destructible_type ) && issubstr( einflictor.destructible_type, "vehicle_" ) )
        {
            weapon = getweapon( "destructible_car" );
        }
        else if ( isdefined( einflictor.scriptvehicletype ) )
        {
            veh_weapon = getweapon( einflictor.scriptvehicletype );
            
            if ( isdefined( veh_weapon ) )
            {
                weapon = veh_weapon;
            }
        }
    }
    
    if ( isdefined( einflictor ) && isdefined( einflictor.script_noteworthy ) )
    {
        if ( isdefined( level.overrideweaponfunc ) )
        {
            weapon = [[ level.overrideweaponfunc ]]( weapon, einflictor.script_noteworthy );
        }
    }
    
    return weapon;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0x8d701334, Offset: 0xa338
// Size: 0xa6
function figure_out_friendly_fire( victim )
{
    if ( level.hardcoremode && level.friendlyfire > 0 && isdefined( victim ) && victim.is_capturing_own_supply_drop === 1 )
    {
        return 2;
    }
    
    if ( killstreaks::is_ricochet_protected( victim ) )
    {
        return 2;
    }
    
    if ( isdefined( level.figure_out_gametype_friendly_fire ) )
    {
        return [[ level.figure_out_gametype_friendly_fire ]]( victim );
    }
    
    return level.friendlyfire;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0xe7c64ea8, Offset: 0xa3e8
// Size: 0x52
function function_f698740( eattacker, weapon )
{
    if ( level.hardcoremode )
    {
        return 0;
    }
    
    if ( !isdefined( eattacker ) )
    {
        return 0;
    }
    
    if ( self != eattacker )
    {
        return 0;
    }
    
    return weapon.donotdamageowner;
}

// Namespace globallogic_player/globallogic_player
// Params 4
// Checksum 0x90dc08b5, Offset: 0xa448
// Size: 0x1b6, Type: bool
function should_do_player_damage( eattacker, weapon, smeansofdeath, idflags )
{
    if ( game.state == "postgame" )
    {
        return false;
    }
    
    if ( self.sessionteam == "spectator" )
    {
        return false;
    }
    
    if ( isdefined( self.candocombat ) && !self.candocombat )
    {
        return false;
    }
    
    if ( isdefined( eattacker ) && isplayer( eattacker ) && isdefined( eattacker.candocombat ) && !eattacker.candocombat )
    {
        return false;
    }
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        return false;
    }
    
    if ( level.onlyheadshots )
    {
        if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" )
        {
            return false;
        }
    }
    
    if ( self vehicle::player_is_occupant_invulnerable( smeansofdeath ) )
    {
        return false;
    }
    
    if ( weapon.issupplydropweapon && !weapon.isgrenadeweapon && smeansofdeath != "MOD_TRIGGER_HURT" )
    {
        return false;
    }
    
    if ( self.scene_takedamage === 0 )
    {
        return false;
    }
    
    if ( idflags & 8 && self player::is_spawn_protected() )
    {
        return false;
    }
    
    return true;
}

// Namespace globallogic_player/globallogic_player
// Params 8
// Checksum 0xdcb18005, Offset: 0xa608
// Size: 0x238
function apply_damage_to_armor( einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc, friendlyfire, ignore_round_start_friendly_fire )
{
    victim = self;
    
    if ( friendlyfire && !function_35dc792c( ignore_round_start_friendly_fire ) )
    {
        return idamage;
    }
    
    idamage = victim armor::apply_damage( idamage );
    
    if ( isdefined( victim.lightarmorhp ) )
    {
        if ( weapon.ignoreslightarmor && smeansofdeath != "MOD_MELEE" )
        {
            return idamage;
        }
        else if ( weapon.meleeignoreslightarmor && smeansofdeath == "MOD_MELEE" )
        {
            return idamage;
        }
        else if ( isdefined( einflictor ) && isdefined( einflictor.stucktoplayer ) && einflictor.stucktoplayer == victim )
        {
            idamage = victim.health;
        }
        else if ( smeansofdeath != "MOD_FALLING" && !weapon_utils::ismeleemod( smeansofdeath ) && !globallogic_utils::isheadshot( weapon, shitloc, smeansofdeath, eattacker ) )
        {
            victim armor::setlightarmorhp( victim.lightarmorhp - idamage );
            idamage = 0;
            
            if ( victim.lightarmorhp <= 0 )
            {
                idamage = abs( victim.lightarmorhp );
                armor::unsetlightarmor();
            }
        }
    }
    
    return idamage;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x40a1db8e, Offset: 0xa848
// Size: 0xa2
function make_sure_damage_is_not_zero( idamage, armor_damaged )
{
    if ( idamage < 1 )
    {
        if ( ( armor_damaged || self ability_util::gadget_power_armor_on() ) && isdefined( self.maxhealth ) && self.health < self.maxhealth )
        {
            self.health += 1;
        }
        
        idamage = 1;
    }
    
    return int( idamage );
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xeeed7fb5, Offset: 0xa8f8
// Size: 0x74
function modify_player_damage_friendlyfire( idamage )
{
    friendlyfire = [[ level.figure_out_friendly_fire ]]( self );
    
    if ( friendlyfire == 2 || friendlyfire == 3 )
    {
        idamage = int( idamage * 0.5 );
    }
    
    return idamage;
}

// Namespace globallogic_player/globallogic_player
// Params 11
// Checksum 0x531ea37f, Offset: 0xa978
// Size: 0x362
function modify_player_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
    if ( isdefined( self.overrideplayerdamage ) )
    {
        idamage = self [[ self.overrideplayerdamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
    }
    else if ( isdefined( level.overrideplayerdamage ) )
    {
        idamage = self [[ level.overrideplayerdamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
    }
    
    assert( isdefined( idamage ), "<dev string:x1db>" );
    
    if ( isdefined( eattacker ) )
    {
        idamage = loadout::cac_modified_damage( self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc );
        
        if ( isdefined( eattacker.pickup_damage_scale ) && eattacker.pickup_damage_scale_time > gettime() )
        {
            idamage *= eattacker.pickup_damage_scale;
        }
    }
    
    idamage = custom_gamemodes_modified_damage( self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc );
    
    if ( level.onplayerdamage != &globallogic::blank )
    {
        modifieddamage = [[ level.onplayerdamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime );
        
        if ( isdefined( modifieddamage ) )
        {
            if ( modifieddamage <= 0 )
            {
                return;
            }
            
            idamage = modifieddamage;
        }
    }
    
    if ( level.onlyheadshots )
    {
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            idamage = 150;
        }
    }
    
    if ( weapon.damagealwayskillsplayer )
    {
        idamage = self.maxhealth + 1;
    }
    
    if ( shitloc == "riotshield" )
    {
        if ( idflags & 32 )
        {
            if ( !( idflags & 64 ) )
            {
                idamage *= 0;
            }
        }
        else if ( idflags & 128 )
        {
            if ( isdefined( einflictor ) && isdefined( einflictor.stucktoplayer ) && einflictor.stucktoplayer == self )
            {
                idamage = self.maxhealth + 1;
            }
        }
    }
    
    return int( idamage );
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0x7f798580, Offset: 0xace8
// Size: 0xd4
function modify_player_damage_meansofdeath( einflictor, eattacker, smeansofdeath, weapon, shitloc )
{
    if ( globallogic_utils::isheadshot( weapon, shitloc, smeansofdeath, einflictor ) && isplayer( eattacker ) && !weapon_utils::ismeleemod( smeansofdeath ) )
    {
        smeansofdeath = "MOD_HEAD_SHOT";
    }
    
    if ( isdefined( einflictor ) && isdefined( einflictor.script_noteworthy ) )
    {
        if ( einflictor.script_noteworthy == "ragdoll_now" )
        {
            smeansofdeath = "MOD_FALLING";
        }
    }
    
    return smeansofdeath;
}

// Namespace globallogic_player/globallogic_player
// Params 3
// Checksum 0xc2995306, Offset: 0xadc8
// Size: 0xbe
function function_1a949060( einflictor, eattacker, smeansofdeath )
{
    if ( isdefined( einflictor ) && isplayer( eattacker ) && eattacker == einflictor )
    {
        if ( smeansofdeath == "MOD_HEAD_SHOT" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" )
        {
            eattacker.hits++;
        }
    }
    
    if ( isplayer( eattacker ) )
    {
        eattacker.pers[ "participation" ]++;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 3
// Checksum 0x8ba79e03, Offset: 0xae90
// Size: 0x14e, Type: bool
function function_c4f6f66d( einflictor, weapon, smeansofdeath )
{
    if ( !self player::is_spawn_protected() )
    {
        return false;
    }
    
    if ( weapon.explosionradius == 0 )
    {
        return false;
    }
    
    distsqr = isdefined( einflictor ) && isdefined( self.lastspawnpoint ) ? distancesquared( einflictor.origin, self.lastspawnpoint.origin ) : 0;
    
    if ( distsqr < 250 * 250 )
    {
        if ( smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" )
        {
            return true;
        }
        
        if ( smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            return true;
        }
        
        if ( smeansofdeath == "MOD_EXPLOSIVE" )
        {
            return true;
        }
    }
    
    if ( killstreaks::is_killstreak_weapon( weapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 11
// Checksum 0x2dca49a3, Offset: 0xafe8
// Size: 0x5ae, Type: bool
function function_19a0a019( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
    is_explosive_damage = weapon_utils::isexplosivedamage( smeansofdeath );
    
    if ( is_explosive_damage )
    {
        if ( self function_c4f6f66d( einflictor, weapon, smeansofdeath ) )
        {
            return false;
        }
        
        if ( self function_f698740( eattacker, weapon ) )
        {
            return false;
        }
    }
    
    if ( smeansofdeath == "MOD_GAS" || isdefined( einflictor ) && is_explosive_damage )
    {
        self.explosiveinfo = [];
        self.explosiveinfo[ "damageTime" ] = gettime();
        self.explosiveinfo[ "damageId" ] = einflictor getentitynumber();
        self.explosiveinfo[ "originalOwnerKill" ] = 0;
        self.explosiveinfo[ "bulletPenetrationKill" ] = 0;
        self.explosiveinfo[ "chainKill" ] = 0;
        self.explosiveinfo[ "damageExplosiveKill" ] = 0;
        self.explosiveinfo[ "chainKill" ] = 0;
        self.explosiveinfo[ "cookedKill" ] = 0;
        self.explosiveinfo[ "weapon" ] = weapon;
        self.explosiveinfo[ "originalowner" ] = einflictor.originalowner;
        isfrag = weapon.rootweapon.name == "frag_grenade";
        
        if ( isdefined( eattacker ) && eattacker != self )
        {
            if ( weapon.name == "satchel_charge" || weapon.name == "claymore" || isdefined( eattacker ) && isdefined( einflictor.owner ) && weapon.name == "bouncingbetty" )
            {
                self.explosiveinfo[ "originalOwnerKill" ] = einflictor.owner == self;
                self.explosiveinfo[ "damageExplosiveKill" ] = isdefined( einflictor.wasdamaged );
                self.explosiveinfo[ "chainKill" ] = isdefined( einflictor.waschained );
                self.explosiveinfo[ "wasJustPlanted" ] = isdefined( einflictor.wasjustplanted );
                self.explosiveinfo[ "bulletPenetrationKill" ] = isdefined( einflictor.wasdamagedfrombulletpenetration );
                self.explosiveinfo[ "cookedKill" ] = 0;
            }
            
            if ( isdefined( einflictor ) && isdefined( einflictor.stucktoplayer ) && weapon.projexplosiontype == "grenade" )
            {
                self.explosiveinfo[ "stuckToPlayer" ] = einflictor.stucktoplayer;
            }
            
            if ( weapon.dostun )
            {
                self.laststunnedby = eattacker;
                self.laststunnedtime = self.idflagstime;
            }
            
            if ( isdefined( eattacker.lastgrenadesuicidetime ) && eattacker.lastgrenadesuicidetime >= gettime() - 50 && isfrag )
            {
                self.explosiveinfo[ "suicideGrenadeKill" ] = 1;
            }
            else
            {
                self.explosiveinfo[ "suicideGrenadeKill" ] = 0;
            }
        }
        
        if ( isfrag )
        {
            self.explosiveinfo[ "cookedKill" ] = isdefined( einflictor.iscooked );
            self.explosiveinfo[ "throwbackKill" ] = isdefined( einflictor.threwback );
        }
        
        if ( isdefined( eattacker ) && isplayer( eattacker ) && eattacker != self )
        {
            self globallogic_score::setinflictorstat( einflictor, eattacker, weapon );
        }
    }
    
    if ( smeansofdeath == "MOD_IMPACT" && isdefined( eattacker ) && isplayer( eattacker ) && eattacker != self )
    {
        if ( weapon != level.weaponballisticknife )
        {
            self globallogic_score::setinflictorstat( einflictor, eattacker, weapon );
        }
        
        if ( weapon.rootweapon.name == "hatchet" && isdefined( einflictor ) )
        {
            self.explosiveinfo[ "projectile_bounced" ] = isdefined( einflictor.bounced );
        }
    }
    
    return true;
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x83d381, Offset: 0xb5a0
// Size: 0x4c, Type: bool
function function_d71741f0()
{
    if ( level.friendlyfiredelay && level.friendlyfiredelaytime >= ( gettime() - level.starttime - level.discardtime ) / 1000 )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x12e10b8c, Offset: 0xb5f8
// Size: 0xb2, Type: bool
function function_5a53278d( eattacker, ignore_round_start_friendly_fire )
{
    if ( !isalive( eattacker ) )
    {
        return false;
    }
    
    friendlyfire = [[ level.figure_out_friendly_fire ]]( self );
    
    if ( friendlyfire == 1 )
    {
        if ( function_d71741f0() && ignore_round_start_friendly_fire == 0 )
        {
            return true;
        }
    }
    
    if ( friendlyfire == 2 )
    {
        return true;
    }
    
    if ( friendlyfire == 3 )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0x4183671, Offset: 0xb6b8
// Size: 0x7a, Type: bool
function function_35dc792c( ignore_round_start_friendly_fire )
{
    friendlyfire = [[ level.figure_out_friendly_fire ]]( self );
    
    if ( friendlyfire == 1 )
    {
        if ( function_d71741f0() && ignore_round_start_friendly_fire == 0 )
        {
            return false;
        }
        
        return true;
    }
    
    if ( friendlyfire == 3 )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0x7e1a26a8, Offset: 0xb740
// Size: 0x274
function function_c3e5e4ba( eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate )
{
    if ( ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" ) && !killstreaks::is_killstreak_weapon( weapon ) && !attackerishittingteammate )
    {
        if ( self.hasriotshieldequipped )
        {
            if ( isplayer( eattacker ) )
            {
                eattacker.lastattackedshieldplayer = self;
                eattacker.lastattackedshieldtime = gettime();
            }
            
            previous_shield_damage = self.shielddamageblocked;
            self.shielddamageblocked += idamage;
            
            if ( self.shielddamageblocked % 400 < previous_shield_damage % 400 )
            {
                score_event = "shield_blocked_damage";
                
                if ( self.shielddamageblocked > 2000 )
                {
                    score_event = "shield_blocked_damage_reduced";
                }
                
                characterindex = eattacker getspecialistindex();
                assert( player_role::is_valid( characterindex ) );
                role = getplayerrolecategory( characterindex, currentsessionmode() );
                
                if ( !isdefined( role ) )
                {
                    role = "prc_mp_slayer";
                }
                
                if ( isdefined( level.scoreinfo[ score_event ] ) && isdefined( level.scoreinfo[ score_event ][ role + "_sp" ] ) )
                {
                    self addweaponstat( level.weaponriotshield, "score_from_blocked_damage", level.scoreinfo[ score_event ][ role + "_sp" ] );
                }
                
                scoreevents::processscoreevent( score_event, self );
            }
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 6
// Checksum 0x1f60b54d, Offset: 0xb9c0
// Size: 0xd6, Type: bool
function does_player_completely_avoid_damage( idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath )
{
    if ( idflags & 8192 )
    {
        return true;
    }
    
    if ( friendlyfire && level.friendlyfire == 0 )
    {
        return true;
    }
    
    if ( shitloc == "riotshield" )
    {
        if ( !( idflags & 160 ) )
        {
            return true;
        }
    }
    
    if ( weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH" )
    {
        if ( self hasperk( "specialty_immuneemp" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 11
// Checksum 0xf1536880, Offset: 0xbaa0
// Size: 0x4ac
function player_damage_log( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
    pixbeginevent( "PlayerDamage log" );
    
    /#
        if ( getdvarint( "<dev string:x214>" ) )
        {
            println( "<dev string:x222>" + self getentitynumber() + "<dev string:x22a>" + self.health + "<dev string:x233>" + eattacker.clientid + "<dev string:x23e>" + isplayer( einflictor ) + "<dev string:x254>" + idamage + "<dev string:x25d>" + shitloc );
        }
    #/
    
    if ( self.sessionstate != "dead" )
    {
        lpselfnum = self getentitynumber();
        lpselfname = self.name;
        lpselfteam = self.team;
        lpselfguid = self getguid();
        lpattackerteam = "";
        lpattackerorigin = ( 0, 0, 0 );
        
        if ( isplayer( eattacker ) )
        {
            lpattacknum = eattacker getentitynumber();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.team;
            lpattackerorigin = eattacker.origin;
            isusingheropower = 0;
            
            if ( eattacker ability_player::is_using_any_gadget() )
            {
                isusingheropower = 1;
            }
            
            bbprint( "mpattacks", "gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), getplayerspawnid( eattacker ), weapon.name, lpattackerorigin, getplayerspawnid( self ), self.origin, idamage, smeansofdeath, shitloc, 0, isusingheropower );
        }
        else
        {
            lpattacknum = -1;
            lpattackguid = "";
            lpattackname = "";
            lpattackerteam = "world";
            bbprint( "mpattacks", "gametime %d attackerweapon %s victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), weapon.name, getplayerspawnid( self ), self.origin, idamage, smeansofdeath, shitloc, 0, 0 );
        }
        
        /#
            logprint( "<dev string:x266>" + lpselfguid + "<dev string:x12c>" + lpselfnum + "<dev string:x12c>" + lpselfteam + "<dev string:x12c>" + lpselfname + "<dev string:x12c>" + lpattackguid + "<dev string:x12c>" + lpattacknum + "<dev string:x12c>" + lpattackerteam + "<dev string:x12c>" + lpattackname + "<dev string:x12c>" + weapon.name + "<dev string:x12c>" + idamage + "<dev string:x12c>" + smeansofdeath + "<dev string:x12c>" + shitloc + "<dev string:x12e>" );
        #/
    }
    
    pixendevent();
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xde58d25f, Offset: 0xbf58
// Size: 0x34, Type: bool
function should_allow_postgame_damage( smeansofdeath )
{
    if ( smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_CRUSH" )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 13
// Checksum 0x70c0b75d, Offset: 0xbf98
// Size: 0xec
function do_post_game_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal )
{
    if ( game.state != "postgame" )
    {
        return;
    }
    
    if ( !should_allow_postgame_damage( smeansofdeath ) )
    {
        return;
    }
    
    self finishplayerdamage( einflictor, eattacker, idamage, idflags, "MOD_POST_GAME", weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
}

// Namespace globallogic_player/globallogic_player
// Params 13
// Checksum 0x94c46b0a, Offset: 0xc090
// Size: 0xc9c
function callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal )
{
    profilelog_begintiming( 6, "ship" );
    do_post_game_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
    
    if ( smeansofdeath == "MOD_CRUSH" && isdefined( einflictor ) && einflictor.deal_no_crush_damage === 1 )
    {
        return;
    }
    
    self.idflags = idflags;
    self.idflagstime = gettime();
    
    if ( !isplayer( eattacker ) && isdefined( eattacker ) && eattacker.owner === self )
    {
        treat_self_damage_as_friendly_fire = eattacker.treat_owner_damage_as_friendly_fire;
    }
    
    ignore_round_start_friendly_fire = isdefined( einflictor ) && smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT";
    eattacker = figure_out_attacker( eattacker );
    
    if ( isdefined( eattacker.laststand ) && isplayer( eattacker ) && eattacker.laststand )
    {
        return;
    }
    
    smeansofdeath = modify_player_damage_meansofdeath( einflictor, eattacker, smeansofdeath, weapon, shitloc );
    
    if ( !self should_do_player_damage( eattacker, weapon, smeansofdeath, idflags ) )
    {
        return;
    }
    
    function_1a949060( einflictor, eattacker, smeansofdeath );
    weapon = function_b168504f( weapon, einflictor );
    pixbeginevent( "PlayerDamage flags/tweaks" );
    
    if ( !isdefined( vdir ) )
    {
        idflags |= 4;
    }
    
    attackerishittingteammate = isplayer( eattacker ) && self util::isenemyplayer( eattacker ) == 0;
    attackerishittingself = isplayer( eattacker ) && self == eattacker;
    friendlyfire = level.teambased && !attackerishittingself && ( attackerishittingself && treat_self_damage_as_friendly_fire === 1 || attackerishittingteammate );
    pixendevent();
    idamage = modify_player_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
    
    if ( friendlyfire )
    {
        idamage = modify_player_damage_friendlyfire( idamage );
    }
    
    if ( isdefined( self.power_armor_took_damage ) && self.power_armor_took_damage )
    {
        idflags |= 1024;
    }
    
    if ( shitloc == "riotshield" )
    {
        function_c3e5e4ba( eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate );
    }
    
    if ( self does_player_completely_avoid_damage( idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath ) )
    {
        return;
    }
    
    params = spawnstruct();
    params.attacker = eattacker;
    self callback::callback( #"hash_ab5ecf6c", params );
    armor = self armor::function_3e7fdc00();
    idamage = apply_damage_to_armor( einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc, friendlyfire, ignore_round_start_friendly_fire );
    armor_damaged = armor != self armor::function_3e7fdc00();
    idamage = make_sure_damage_is_not_zero( idamage, armor_damaged );
    
    if ( armor_damaged )
    {
        idflags |= 2048;
    }
    
    if ( shitloc == "riotshield" )
    {
        shitloc = "none";
    }
    
    if ( !function_19a0a019( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex ) )
    {
        return;
    }
    
    prevhealthratio = self.health / self.maxhealth;
    
    if ( friendlyfire )
    {
        pixmarker( "BEGIN: PlayerDamage player" );
        
        if ( function_35dc792c( ignore_round_start_friendly_fire ) )
        {
            self.lastdamagewasfromenemy = 0;
            self finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
        }
        else if ( weapon.forcedamageshellshockandrumble )
        {
            self damageshellshockandrumble( eattacker, einflictor, weapon, smeansofdeath, idamage );
        }
        
        if ( function_5a53278d( eattacker, ignore_round_start_friendly_fire ) )
        {
            eattacker.lastdamagewasfromenemy = 0;
            eattacker.friendlydamage = 1;
            eattacker finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
            eattacker.friendlydamage = undefined;
        }
        
        pixmarker( "END: PlayerDamage player" );
    }
    else
    {
        behaviortracker::function_dbc71f52( eattacker, self, idamage );
        self.lastattackweapon = weapon;
        giveattackerandinflictorownerassist( eattacker, einflictor, idamage, smeansofdeath, weapon );
        
        if ( isdefined( eattacker ) )
        {
            level.lastlegitimateattacker = eattacker;
        }
        
        if ( ( smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" ) && isdefined( einflictor ) && isdefined( einflictor.iscooked ) )
        {
            self.wascooked = gettime();
        }
        else
        {
            self.wascooked = undefined;
        }
        
        self.lastdamagewasfromenemy = isdefined( eattacker ) && eattacker != self;
        
        if ( self.lastdamagewasfromenemy )
        {
            if ( isplayer( eattacker ) )
            {
                if ( isdefined( eattacker.damagedplayers[ self.clientid ] ) == 0 )
                {
                    eattacker.damagedplayers[ self.clientid ] = spawnstruct();
                }
                
                eattacker.damagedplayers[ self.clientid ].time = gettime();
                eattacker.damagedplayers[ self.clientid ].entity = self;
            }
        }
        
        if ( isplayer( eattacker ) && isdefined( weapon.gadget_type ) && weapon.gadget_type == 14 )
        {
            if ( isdefined( eattacker.heavyweaponhits ) )
            {
                eattacker.heavyweaponhits++;
            }
        }
        
        self finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
    }
    
    if ( isdefined( eattacker ) && !attackerishittingself )
    {
        if ( damagefeedback::dodamagefeedback( weapon, einflictor, idamage, smeansofdeath ) )
        {
            if ( idamage > 0 && self.health > 0 )
            {
                perkfeedback = function_6b151027( self, weapon, smeansofdeath, einflictor, armor_damaged );
            }
            
            eattacker thread damagefeedback::update( smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc );
        }
    }
    
    if ( isdefined( level.hardcoremode ) && ( !isdefined( eattacker ) || !friendlyfire || level.hardcoremode ) )
    {
        self battlechatter::pain_vox( smeansofdeath );
    }
    
    self.hasdonecombat = 1;
    
    if ( weapon.isemp && isdefined( weapon.statuseffect ) )
    {
        index = status_effect::status_effect_get_index_for_name( weapon.statuseffect );
        
        if ( isdefined( index ) )
        {
            self status_effect::status_effect_apply( index );
        }
    }
    else if ( weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH" )
    {
        if ( !self hasperk( "specialty_immuneemp" ) )
        {
            self notify( #"emp_grenaded", { #attacker:eattacker, #position:vpoint } );
        }
    }
    
    if ( isdefined( eattacker ) && eattacker != self && !friendlyfire )
    {
        level.usestartspawns = 0;
    }
    
    player_damage_log( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
    profilelog_endtiming( 6, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0x4964d4a0, Offset: 0xcd38
// Size: 0x1a8
function function_6b151027( player, weapon, smeansofdeath, einflictor, armor_damaged )
{
    perkfeedback = undefined;
    var_bb61b344 = loadout::function_bb61b344( player );
    hasflakjacket = player hasperk( "specialty_flakjacket" );
    isexplosivedamage = weapon_utils::isexplosivedamage( smeansofdeath );
    isflashorstundamage = weapon_utils::isflashorstundamage( weapon, smeansofdeath );
    
    if ( isflashorstundamage && var_bb61b344 )
    {
        perkfeedback = "tacticalMask";
    }
    else if ( player hasperk( "specialty_fireproof" ) && loadout::isfiredamage( weapon, smeansofdeath ) )
    {
        perkfeedback = "flakjacket";
    }
    else if ( isexplosivedamage && hasflakjacket && !weapon.ignoresflakjacket && !isaikillstreakdamage( weapon, einflictor ) )
    {
        perkfeedback = "flakjacket";
    }
    else if ( armor_damaged )
    {
        perkfeedback = "armor";
    }
    
    return perkfeedback;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x327f9643, Offset: 0xcee8
// Size: 0x5c, Type: bool
function isaikillstreakdamage( weapon, einflictor )
{
    if ( weapon.isaikillstreakdamage )
    {
        if ( weapon.name != "ai_tank_drone_rocket" || isdefined( einflictor.firedbyai ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 13
// Checksum 0xae12737b, Offset: 0xcf50
// Size: 0x2e4
function finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal )
{
    pixbeginevent( "finishPlayerDamageWrapper" );
    
    if ( !level.console && idflags & 8 && isplayer( eattacker ) )
    {
        println( "<dev string:x269>" + self getentitynumber() + "<dev string:x22a>" + self.health + "<dev string:x233>" + eattacker.clientid + "<dev string:x23e>" + isplayer( einflictor ) + "<dev string:x254>" + idamage + "<dev string:x25d>" + shitloc );
        eattacker addplayerstat( "penetration_shots", 1 );
    }
    
    if ( getdvarstring( "scr_csmode" ) != "" )
    {
        self shellshock( "damage_mp", 0.2 );
    }
    
    self damageshellshockandrumble( eattacker, einflictor, weapon, smeansofdeath, idamage );
    self ability_power::power_loss_event_took_damage( eattacker, einflictor, weapon, smeansofdeath, idamage );
    
    if ( isplayer( eattacker ) )
    {
        self.lastshotby = eattacker.clientid;
    }
    
    if ( smeansofdeath == "MOD_BURNED" )
    {
        self burnplayer::takingburndamage( eattacker, weapon, smeansofdeath );
    }
    
    self.gadget_was_active_last_damage = self gadgetisactive( 0 );
    self finishplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
    pixendevent();
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0xe52793ef, Offset: 0xd240
// Size: 0x364
function function_da9b1acd( attacker, weapon )
{
    if ( !isdefined( self.switching_teams ) )
    {
        if ( isplayer( attacker ) && level.teambased && attacker != self && self.team == attacker.team )
        {
            self.pers[ "cur_kill_streak" ] = 0;
            self.pers[ "cur_total_kill_streak" ] = 0;
            self.pers[ "totalKillstreakCount" ] = 0;
            self.pers[ "killstreaksEarnedThisKillstreak" ] = 0;
            self setplayercurrentstreak( 0 );
        }
        else
        {
            self globallogic_score::incpersstat( "deaths", 1, 1, 1 );
            self.deaths = self globallogic_score::getpersstat( "deaths" );
            self updatestatratio( "kdratio", "kills", "deaths" );
            
            if ( self.pers[ "cur_kill_streak" ] > self.pers[ "best_kill_streak" ] )
            {
                self.pers[ "best_kill_streak" ] = self.pers[ "cur_kill_streak" ];
            }
            
            self.pers[ "kill_streak_before_death" ] = self.pers[ "cur_kill_streak" ];
            self.pers[ "cur_kill_streak" ] = 0;
            self.pers[ "cur_total_kill_streak" ] = 0;
            self.pers[ "totalKillstreakCount" ] = 0;
            self.pers[ "killstreaksEarnedThisKillstreak" ] = 0;
            self setplayercurrentstreak( 0 );
            self.cur_death_streak++;
            
            if ( self.cur_death_streak > self.death_streak )
            {
                if ( level.rankedmatch && !level.disablestattracking )
                {
                    self setdstat( "HighestStats", "death_streak", self.cur_death_streak );
                }
                
                self.death_streak = self.cur_death_streak;
            }
            
            if ( self.cur_death_streak >= getdvarint( "perk_deathStreakCountRequired" ) )
            {
                self enabledeathstreak();
            }
        }
    }
    else
    {
        self.pers[ "totalKillstreakCount" ] = 0;
        self.pers[ "killstreaksEarnedThisKillstreak" ] = 0;
    }
    
    if ( !sessionmodeiszombiesgame() && killstreaks::is_killstreak_weapon( weapon ) )
    {
        level.globalkillstreaksdeathsfrom++;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 6
// Checksum 0x6ce0bd88, Offset: 0xd5b0
// Size: 0x4a4
function function_6c73fce1( attacker, weapon, smeansofdeath, wasinlaststand, var_a3ad44ab, inflictor )
{
    if ( level.teambased && ( !level.teambased || isplayer( attacker ) && attacker != self && self.team != attacker.team ) )
    {
        attackerweaponpickedup = 0;
        
        if ( isdefined( attacker.pickedupweapons ) && isdefined( attacker.pickedupweapons[ weapon ] ) )
        {
            attackerweaponpickedup = 1;
        }
        
        self addweaponstat( weapon, "deaths", 1, self.class_num, attackerweaponpickedup, undefined, self.primaryloadoutgunsmithvariantindex, self.secondaryloadoutgunsmithvariantindex );
        
        if ( wasinlaststand && isdefined( var_a3ad44ab ) )
        {
            victim_weapon = var_a3ad44ab;
        }
        else
        {
            victim_weapon = self.lastdroppableweapon;
        }
        
        if ( isdefined( victim_weapon ) )
        {
            victimweaponpickedup = 0;
            
            if ( isdefined( self.pickedupweapons ) && isdefined( self.pickedupweapons[ victim_weapon ] ) )
            {
                victimweaponpickedup = 1;
            }
            
            self addweaponstat( victim_weapon, "deathsDuringUse", 1, self.class_num, victimweaponpickedup, undefined, self.primaryloadoutgunsmithvariantindex, self.secondaryloadoutgunsmithvariantindex );
        }
        
        recordweaponstatkills = 1;
        
        if ( attacker.isthief === 1 && isdefined( weapon ) && weapon.isheroweapon === 1 )
        {
            recordweaponstatkills = 0;
        }
        
        if ( smeansofdeath != "MOD_FALLING" && recordweaponstatkills )
        {
            if ( weapon.name == "explosive_bolt" && isdefined( inflictor ) && isdefined( inflictor.ownerweaponatlaunch ) && inflictor.owneradsatlaunch )
            {
                inflictorownerweaponatlaunchpickedup = 0;
                
                if ( isdefined( attacker.pickedupweapons ) && isdefined( attacker.pickedupweapons[ inflictor.ownerweaponatlaunch ] ) )
                {
                    inflictorownerweaponatlaunchpickedup = 1;
                }
                
                attacker addweaponstat( inflictor.ownerweaponatlaunch, "kills", 1, attacker.class_num, inflictorownerweaponatlaunchpickedup, 1, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex );
            }
            else
            {
                attacker addweaponstat( weapon, "kills", 1, attacker.class_num, attackerweaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex );
            }
        }
        
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            attacker addweaponstat( weapon, "headshots", 1, attacker.class_num, attackerweaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex );
        }
        
        if ( smeansofdeath == "MOD_PROJECTILE" )
        {
            attacker addweaponstat( weapon, "direct_hit_kills", 1 );
        }
        
        victimisroulette = self.isroulette === 1;
        
        if ( self ability_player::gadget_checkheroabilitykill( attacker ) && !victimisroulette )
        {
            attacker addweaponstat( attacker.heroability, "kills_while_active", 1 );
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 4
// Checksum 0xa0c163aa, Offset: 0xda60
// Size: 0x35c
function function_caa6d8d5( attacker, einflictor, weapon, smeansofdeath )
{
    if ( isdefined( weapon ) && ( !isplayer( attacker ) || self util::isenemyplayer( attacker ) == 0 || killstreaks::is_killstreak_weapon( weapon ) ) )
    {
        level notify( #"reset_obituary_count" );
        level.lastobituaryplayercount = 0;
        level.lastobituaryplayer = undefined;
    }
    else
    {
        if ( isdefined( level.lastobituaryplayer ) && level.lastobituaryplayer == attacker )
        {
            level.lastobituaryplayercount++;
        }
        else
        {
            level notify( #"reset_obituary_count" );
            level.lastobituaryplayer = attacker;
            level.lastobituaryplayercount = 1;
        }
        
        level thread scoreevents::decrementlastobituaryplayercountafterfade();
        
        if ( level.lastobituaryplayercount >= 4 )
        {
            level notify( #"reset_obituary_count" );
            level.lastobituaryplayercount = 0;
            level.lastobituaryplayer = undefined;
            self thread scoreevents::uninterruptedobitfeedkills( attacker, weapon );
        }
    }
    
    if ( isdefined( weapon ) && ( !isplayer( attacker ) || !killstreaks::is_killstreak_weapon( weapon ) ) )
    {
        behaviortracker::function_702c6ee2( attacker, self );
    }
    
    overrideentitycamera = killstreaks::should_override_entity_camera_in_demo( attacker, weapon );
    
    if ( isdefined( einflictor ) && einflictor.archetype === "robot" )
    {
        if ( smeansofdeath == "MOD_HIT_BY_OBJECT" )
        {
            weapon = getweapon( "combat_robot_marker" );
        }
        
        smeansofdeath = "MOD_RIFLE_BULLET";
    }
    
    if ( level.teambased && isdefined( attacker.pers ) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0 )
    {
        obituary( self, self, weapon, smeansofdeath );
        demo::bookmark( "kill", gettime(), self, self, 0, einflictor, overrideentitycamera );
        return;
    }
    
    obituary( self, attacker, weapon, smeansofdeath );
    demo::bookmark( "kill", gettime(), attacker, self, 0, einflictor, overrideentitycamera );
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0x623cdf9b, Offset: 0xddc8
// Size: 0x3c8
function function_41055c90( einflictor, attacker, smeansofdeath, weapon, shitloc )
{
    awardassists = 0;
    self.suicide = 0;
    
    if ( isdefined( self.switching_teams ) )
    {
        if ( isdefined( level.teams[ self.leaving_team ] ) && isdefined( level.teams[ self.joining_team ] ) && !level.teambased && level.teams[ self.leaving_team ] != level.teams[ self.joining_team ] )
        {
            playercounts = self teams::count_players();
            playercounts[ self.leaving_team ]--;
            playercounts[ self.joining_team ]++;
            
            if ( playercounts[ self.joining_team ] - playercounts[ self.leaving_team ] > 1 )
            {
                scoreevents::processscoreevent( "suicide", self );
                self thread rank::giverankxp( "suicide" );
                self globallogic_score::incpersstat( "suicides", 1 );
                self.suicides = self globallogic_score::getpersstat( "suicides" );
                self.suicide = 1;
            }
        }
    }
    else
    {
        scoreevents::processscoreevent( "suicide", self );
        self globallogic_score::incpersstat( "suicides", 1 );
        self.suicides = self globallogic_score::getpersstat( "suicides" );
        
        if ( smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade )
        {
            self.lastgrenadesuicidetime = gettime();
        }
        
        if ( level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides )
        {
            self notify( #"teamkillkicked" );
            self function_361da015();
        }
        
        thread battlechatter::on_player_suicide_or_team_kill( self, "suicide" );
        awardassists = 1;
        self.suicide = 1;
    }
    
    if ( isdefined( self.friendlydamage ) )
    {
        self iprintln( &"MP_FRIENDLY_FIRE_WILL_NOT" );
        
        if ( level.teamkillpointloss )
        {
            scoresub = self [[ level.getteamkillscore ]]( einflictor, attacker, smeansofdeath, weapon );
            score = globallogic_score::_getplayerscore( attacker ) - scoresub;
            
            if ( score < 0 )
            {
                score = 0;
            }
            
            globallogic_score::_setplayerscore( attacker, score );
        }
    }
    
    return awardassists;
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0x4bd9f992, Offset: 0xe198
// Size: 0x30c
function function_d7a6cc2b( einflictor, attacker, smeansofdeath, weapon, shitloc )
{
    scoreevents::processscoreevent( "team_kill", attacker );
    self.teamkilled = 1;
    
    if ( !ignoreteamkills( weapon, smeansofdeath, einflictor ) )
    {
        teamkill_penalty = self [[ level.getteamkillpenalty ]]( einflictor, attacker, smeansofdeath, weapon );
        attacker globallogic_score::incpersstat( "teamkills_nostats", teamkill_penalty, 0 );
        attacker globallogic_score::incpersstat( "teamkills", 1 );
        attacker.teamkillsthisround++;
        
        if ( level.teamkillpointloss )
        {
            scoresub = self [[ level.getteamkillscore ]]( einflictor, attacker, smeansofdeath, weapon );
            score = globallogic_score::_getplayerscore( attacker ) - scoresub;
            
            if ( score < 0 )
            {
                score = 0;
            }
            
            globallogic_score::_setplayerscore( attacker, score );
        }
        
        if ( globallogic_utils::gettimepassed() < 5000 )
        {
            teamkilldelay = 1;
        }
        else if ( attacker.pers[ "teamkills_nostats" ] > 1 && globallogic_utils::gettimepassed() < 8000 + attacker.pers[ "teamkills_nostats" ] * 1000 )
        {
            teamkilldelay = 1;
        }
        else
        {
            teamkilldelay = attacker teamkilldelay();
        }
        
        if ( teamkilldelay > 0 )
        {
            attacker.teamkillpunish = 1;
            attacker thread wait_and_suicide();
            
            if ( attacker function_a4451c91( teamkilldelay ) )
            {
                attacker notify( #"teamkillkicked" );
                attacker thread function_b8f126c4();
            }
            
            attacker thread function_a1ea27f6();
        }
        
        if ( isplayer( attacker ) )
        {
            thread battlechatter::on_player_suicide_or_team_kill( attacker, "teamkill" );
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x7b588f99, Offset: 0xe4b0
// Size: 0x4c
function wait_and_suicide()
{
    self endon( #"disconnect" );
    self util::freeze_player_controls( 1 );
    wait 0.25;
    self suicide();
}

// Namespace globallogic_player/globallogic_player
// Params 4
// Checksum 0xee230dc2, Offset: 0xe508
// Size: 0x1e4
function function_3f735e1d( einflictor, attacker, weapon, lpattackteam )
{
    pixbeginevent( "PlayerKilled assists" );
    
    if ( isdefined( self.attackers ) )
    {
        for ( j = 0; j < self.attackers.size ; j++ )
        {
            player = self.attackers[ j ];
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player == attacker )
            {
                continue;
            }
            
            if ( player.team != lpattackteam )
            {
                continue;
            }
            
            damage_done = self.attackerdamage[ player.clientid ].damage;
            player thread globallogic_score::processassist( self, damage_done, self.attackerdamage[ player.clientid ].weapon );
        }
    }
    
    if ( level.teambased )
    {
        self globallogic_score::processkillstreakassists( attacker, einflictor, weapon );
    }
    
    if ( isdefined( self.lastattackedshieldplayer ) && isdefined( self.lastattackedshieldtime ) && self.lastattackedshieldplayer != attacker )
    {
        if ( gettime() - self.lastattackedshieldtime < 4000 )
        {
            self.lastattackedshieldplayer thread globallogic_score::processshieldassist( self );
        }
    }
    
    pixendevent();
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0xc9efdf78, Offset: 0xe6f8
// Size: 0x7c4
function function_489d248c( einflictor, attacker, smeansofdeath, weapon, shitloc )
{
    if ( isdefined( level.killstreaksgivegamescore ) && ( !isdefined( killstreaks::get_killstreak_for_weapon( weapon ) ) || level.killstreaksgivegamescore ) )
    {
        globallogic_score::inctotalkills( attacker.team );
    }
    
    attacker thread globallogic_score::givekillstats( smeansofdeath, weapon, self );
    killstreak = killstreaks::get_killstreak_for_weapon( weapon );
    
    if ( isdefined( killstreak ) )
    {
        if ( scoreevents::isregisteredevent( killstreak ) )
        {
            scoreevents::processscoreevent( killstreak, attacker, self, weapon );
        }
        
        if ( killstreak == "dart" || isdefined( einflictor ) && killstreak == "inventory_dart" )
        {
            einflictor notify( #"veh_collision" );
        }
    }
    else
    {
        scoreevents::processscoreevent( "kill", attacker, self, weapon );
        
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            scoreevents::processscoreevent( "headshot", attacker, self, weapon );
            attacker util::player_contract_event( "headshot" );
        }
        else if ( weapon_utils::ismeleemod( smeansofdeath ) )
        {
            scoreevents::processscoreevent( "melee_kill", attacker, self, weapon );
        }
    }
    
    if ( isalive( attacker ) )
    {
        pixbeginevent( "killstreak" );
        
        if ( !isdefined( einflictor ) || !isdefined( einflictor.requireddeathcount ) || attacker.deathcount == einflictor.requireddeathcount )
        {
            shouldgivekillstreak = killstreaks::should_give_killstreak( weapon );
            
            if ( shouldgivekillstreak )
            {
                attacker killstreaks::add_to_killstreak_count( weapon );
            }
            
            attacker.pers[ "cur_total_kill_streak" ]++;
            attacker setplayercurrentstreak( attacker.pers[ "cur_total_kill_streak" ] );
            
            if ( isdefined( level.killstreaks ) && shouldgivekillstreak )
            {
                attacker.pers[ "cur_kill_streak" ]++;
                
                if ( attacker.pers[ "cur_kill_streak" ] >= 2 )
                {
                    if ( attacker.pers[ "cur_kill_streak" ] == 10 )
                    {
                        attacker challenges::killstreakten();
                    }
                    
                    if ( attacker.pers[ "cur_kill_streak" ] <= 30 )
                    {
                        scoreevents::processscoreevent( "killstreak_" + attacker.pers[ "cur_kill_streak" ], attacker, self, weapon );
                        
                        if ( attacker.pers[ "cur_kill_streak" ] == 30 )
                        {
                            attacker challenges::killstreak_30_noscorestreaks();
                        }
                    }
                    else
                    {
                        scoreevents::processscoreevent( "killstreak_more_than_30", attacker, self, weapon );
                    }
                }
                
                if ( !isdefined( level.usingmomentum ) || !level.usingmomentum )
                {
                    attacker thread killstreaks::give_for_streak();
                }
            }
        }
        
        pixendevent();
    }
    
    if ( attacker.pers[ "cur_kill_streak" ] > attacker.kill_streak )
    {
        if ( level.rankedmatch && !level.disablestattracking )
        {
            attacker setdstat( "HighestStats", "kill_streak", attacker.pers[ "totalKillstreakCount" ] );
        }
        
        attacker.kill_streak = attacker.pers[ "cur_kill_streak" ];
    }
    
    if ( attacker.pers[ "cur_kill_streak" ] > attacker.gametype_kill_streak )
    {
        attacker persistence::function_e885624a( "kill_streak", attacker.pers[ "cur_kill_streak" ] );
        attacker.gametype_kill_streak = attacker.pers[ "cur_kill_streak" ];
    }
    
    attacker thread globallogic_score::trackattackerkill( self.name, self.pers[ "rank" ], self.pers[ "rankxp" ], self.pers[ "prestige" ], self getxuid(), weapon );
    attackername = attacker.name;
    self thread globallogic_score::trackattackeedeath( attackername, attacker.pers[ "rank" ], attacker.pers[ "rankxp" ], attacker.pers[ "prestige" ], attacker getxuid() );
    self thread medals::setlastkilledby( attacker );
    attacker thread globallogic_score::inckillstreaktracker( weapon );
    
    if ( level.teambased && attacker.team != "spectator" )
    {
        if ( isdefined( level.killstreaksgivegamescore ) && ( !isdefined( killstreak ) || level.killstreaksgivegamescore ) )
        {
            globallogic_score::giveteamscore( "kill", attacker.team, attacker, self );
        }
    }
    
    scoresub = level.deathpointloss;
    
    if ( scoresub != 0 )
    {
        globallogic_score::_setplayerscore( self, globallogic_score::_getplayerscore( self ) - scoresub );
    }
    
    level thread playkillbattlechatter( attacker, weapon, self, einflictor );
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xc45627e7, Offset: 0xeec8
// Size: 0x24, Type: bool
function should_allow_postgame_death( smeansofdeath )
{
    if ( smeansofdeath == "MOD_POST_GAME" )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 9
// Checksum 0x5ec149cb, Offset: 0xeef8
// Size: 0x18c
function function_8f2c8c07( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( !should_allow_postgame_death( smeansofdeath ) )
    {
        return;
    }
    
    self weapons::detach_carry_object_model();
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    clone_weapon = weapon;
    
    if ( weapon_utils::ismeleemod( smeansofdeath ) && clone_weapon.type != "melee" )
    {
        clone_weapon = level.weaponnone;
    }
    
    body = self cloneplayer( deathanimduration, clone_weapon, attacker );
    
    if ( isdefined( body ) )
    {
        self function_39d71623( attacker, idamage, smeansofdeath, weapon, shitloc, vdir, ( 0, 0, 0 ), deathanimduration, einflictor, body );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 10
// Checksum 0x6c9e24d9, Offset: 0xf090
// Size: 0x28c6
function callback_playerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration, enteredresurrect )
{
    if ( !isdefined( enteredresurrect ) )
    {
        enteredresurrect = 0;
    }
    
    profilelog_begintiming( 7, "ship" );
    self endon( #"spawned" );
    
    if ( game.state == "postgame" )
    {
        function_8f2c8c07( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
        return;
    }
    
    if ( self.sessionteam == "spectator" )
    {
        return;
    }
    
    self notify( #"killed_player" );
    self callback::callback( #"hash_bc435202" );
    self needsrevive( 0 );
    
    if ( isdefined( self.burning ) && self.burning == 1 )
    {
        self setburn( 0 );
    }
    
    self.suicide = 0;
    self.teamkilled = 0;
    
    if ( isdefined( level.takelivesondeath ) && level.takelivesondeath == 1 )
    {
        if ( self.pers[ "lives" ] )
        {
            self.pers[ "lives" ]--;
            
            if ( self.pers[ "lives" ] == 0 )
            {
                level notify( #"player_eliminated" );
                self notify( #"player_eliminated" );
            }
        }
        
        if ( game.lives[ self.team ] )
        {
            game.lives[ self.team ]--;
            
            if ( self.team == "allies" )
            {
                clientfield::set_world_uimodel( "hudItems.alliesLivesCount", game.lives[ self.team ] );
            }
            else if ( self.team == "axis" )
            {
                clientfield::set_world_uimodel( "hudItems.axisLivesCount", game.lives[ self.team ] );
            }
            
            if ( game.lives[ self.team ] == 0 )
            {
                level notify( #"player_eliminated" );
                self notify( #"player_eliminated" );
            }
        }
    }
    
    self thread globallogic_audio::flush_leader_dialog_key_on_player( "equipmentDestroyed" );
    weapon = updateweapon( einflictor, weapon );
    pixbeginevent( "PlayerKilled pre constants" );
    wasinlaststand = 0;
    bledout = 0;
    deathtimeoffset = 0;
    var_a3ad44ab = undefined;
    attackerstance = undefined;
    self.laststandthislife = undefined;
    self.vattackerorigin = undefined;
    weapon_at_time_of_death = self getcurrentweapon();
    
    if ( isdefined( self.uselaststandparams ) && enteredresurrect == 0 )
    {
        self.uselaststandparams = undefined;
        assert( isdefined( self.laststandparams ) );
        
        if ( !isdefined( attacker ) || !isplayer( attacker ) || attacker.team != self.team || !level.teambased || attacker == self )
        {
            einflictor = self.laststandparams.einflictor;
            attacker = self.laststandparams.attacker;
            attackerstance = self.laststandparams.attackerstance;
            idamage = self.laststandparams.idamage;
            smeansofdeath = self.laststandparams.smeansofdeath;
            weapon = self.laststandparams.sweapon;
            vdir = self.laststandparams.vdir;
            shitloc = self.laststandparams.shitloc;
            self.vattackerorigin = self.laststandparams.vattackerorigin;
            self.killcam_entity_info_cached = self.laststandparams.killcam_entity_info_cached;
            deathtimeoffset = ( gettime() - self.laststandparams.laststandstarttime ) / 1000;
            bledout = 1;
            
            if ( isdefined( self.var_54a2d6ec ) )
            {
                wasinlaststand = 1;
                var_a3ad44ab = self.var_54a2d6ec;
            }
        }
        
        self.laststandparams = undefined;
    }
    
    self stopsounds();
    bestplayer = undefined;
    bestplayermeansofdeath = undefined;
    obituarymeansofdeath = undefined;
    bestplayerweapon = undefined;
    obituaryweapon = weapon;
    assistedsuicide = 0;
    
    if ( ( isdefined( attacker.ismagicbullet ) && ( !isdefined( attacker ) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker.ismagicbullet == 1 ) || attacker == self ) && isdefined( self.attackers ) && !self isplayerunderwater() )
    {
        if ( !isdefined( bestplayer ) )
        {
            for ( i = 0; i < self.attackers.size ; i++ )
            {
                player = self.attackers[ i ];
                
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( !isdefined( self.attackerdamage[ player.clientid ] ) || !isdefined( self.attackerdamage[ player.clientid ].damage ) )
                {
                    continue;
                }
                
                if ( level.teambased && ( player == self || player.team == self.team ) )
                {
                    continue;
                }
                
                if ( self.attackerdamage[ player.clientid ].lasttimedamaged + 2500 < gettime() )
                {
                    continue;
                }
                
                if ( !allowedassistweapon( self.attackerdamage[ player.clientid ].weapon ) )
                {
                    continue;
                }
                
                if ( self.attackerdamage[ player.clientid ].damage > 1 && !isdefined( bestplayer ) )
                {
                    bestplayer = player;
                    bestplayermeansofdeath = self.attackerdamage[ player.clientid ].meansofdeath;
                    bestplayerweapon = self.attackerdamage[ player.clientid ].weapon;
                    continue;
                }
                
                if ( isdefined( bestplayer ) && self.attackerdamage[ player.clientid ].damage > self.attackerdamage[ bestplayer.clientid ].damage )
                {
                    bestplayer = player;
                    bestplayermeansofdeath = self.attackerdamage[ player.clientid ].meansofdeath;
                    bestplayerweapon = self.attackerdamage[ player.clientid ].weapon;
                }
            }
        }
        
        if ( isdefined( bestplayer ) )
        {
            scoreevents::processscoreevent( "assisted_suicide", bestplayer, self, weapon );
            self recordkillmodifier( "assistedsuicide" );
            assistedsuicide = 1;
        }
    }
    
    if ( isdefined( bestplayer ) )
    {
        attacker = bestplayer;
        obituarymeansofdeath = bestplayermeansofdeath;
        obituaryweapon = bestplayerweapon;
        
        if ( isdefined( bestplayerweapon ) )
        {
            weapon = bestplayerweapon;
        }
    }
    
    if ( isplayer( attacker ) )
    {
        attacker.damagedplayers[ self.clientid ] = undefined;
    }
    
    if ( enteredresurrect == 0 )
    {
        globallogic::doweaponspecifickilleffects( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime );
    }
    
    self.deathtime = gettime();
    
    if ( !level.teambased || attacker != self && attacker.team != self.team )
    {
        assert( isdefined( self.lastspawntime ) );
        self.alivetimes[ self.alivetimecurrentindex ] = self.deathtime - self.lastspawntime;
        self.alivetimecurrentindex = ( self.alivetimecurrentindex + 1 ) % level.alivetimemaxcount;
    }
    
    attacker = function_9cedb097( attacker, weapon );
    einflictor = function_1e4d3508( einflictor );
    smeansofdeath = self function_d7eade4e( attacker, einflictor, weapon, smeansofdeath, shitloc );
    
    if ( !isdefined( obituarymeansofdeath ) )
    {
        obituarymeansofdeath = smeansofdeath;
    }
    
    self.hasriotshield = 0;
    self.hasriotshieldequipped = 0;
    self thread function_117043();
    self function_6c73fce1( attacker, weapon, smeansofdeath, wasinlaststand, var_a3ad44ab, einflictor );
    
    if ( bledout == 0 )
    {
        self function_caa6d8d5( attacker, einflictor, obituaryweapon, obituarymeansofdeath );
    }
    
    if ( enteredresurrect == 0 )
    {
        self.sessionstate = "dead";
        self.statusicon = "hud_status_dead";
    }
    
    self.pers[ "weapon" ] = undefined;
    self.killedplayerscurrent = [];
    self.deathcount++;
    println( "<dev string:x275>" + self.clientid + "<dev string:x27e>" + self.deathcount );
    
    if ( bledout == 0 )
    {
        self function_da9b1acd( attacker, weapon );
    }
    
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpattackguid = "";
    lpattackname = "";
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackteam = "";
    lpattackorigin = ( 0, 0, 0 );
    lpattacknum = -1;
    awardassists = 0;
    wasteamkill = 0;
    wassuicide = 0;
    pixendevent();
    scoreevents::processscoreevent( "death", self, self, weapon );
    self.pers[ "resetMomentumOnSpawn" ] = level.scoreresetondeath;
    
    if ( isplayer( attacker ) )
    {
        lpattackguid = attacker getguid();
        lpattackname = attacker.name;
        lpattackteam = attacker.team;
        lpattackorigin = attacker.origin;
        
        if ( attacker == self || assistedsuicide == 1 )
        {
            dokillcam = 0;
            wassuicide = 1;
            awardassists = self function_41055c90( einflictor, attacker, smeansofdeath, weapon, shitloc );
            
            if ( assistedsuicide == 1 )
            {
                attacker thread globallogic_score::givekillstats( smeansofdeath, weapon, self );
            }
        }
        else
        {
            pixbeginevent( "PlayerKilled attacker" );
            lpattacknum = attacker getentitynumber();
            dokillcam = 1;
            
            if ( level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0 )
            {
            }
            else if ( level.teambased && self.team == attacker.team )
            {
                wasteamkill = 1;
                self function_d7a6cc2b( einflictor, attacker, smeansofdeath, weapon, shitloc );
            }
            else if ( bledout == 0 )
            {
                self function_489d248c( einflictor, attacker, smeansofdeath, weapon, shitloc );
                
                if ( level.teambased )
                {
                    awardassists = 1;
                }
            }
            
            pixendevent();
        }
    }
    else if ( attacker.classname == "trigger_hurt" || isdefined( attacker ) && attacker.classname == "worldspawn" )
    {
        dokillcam = 0;
        lpattacknum = -1;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        scoreevents::processscoreevent( "suicide", self );
        self globallogic_score::incpersstat( "suicides", 1 );
        self.suicides = self globallogic_score::getpersstat( "suicides" );
        self.suicide = 1;
        thread battlechatter::on_player_suicide_or_team_kill( self, "suicide" );
        awardassists = 1;
        
        if ( level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides )
        {
            self notify( #"teamkillkicked" );
            self function_361da015();
        }
    }
    else
    {
        dokillcam = 0;
        lpattacknum = -1;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        wassuicide = 1;
        
        if ( isdefined( einflictor ) && isdefined( einflictor.killcament ) )
        {
            dokillcam = 1;
            lpattacknum = self getentitynumber();
            wassuicide = 0;
        }
        
        if ( isdefined( attacker ) && isdefined( attacker.team ) && isdefined( level.teams[ attacker.team ] ) )
        {
            if ( attacker.team != self.team )
            {
                if ( level.teambased )
                {
                    if ( isdefined( level.killstreaksgivegamescore ) && ( !isdefined( killstreaks::get_killstreak_for_weapon( weapon ) ) || level.killstreaksgivegamescore ) )
                    {
                        globallogic_score::giveteamscore( "kill", attacker.team, attacker, self );
                    }
                }
                
                wassuicide = 0;
            }
        }
        
        awardassists = 1;
    }
    
    if ( !level.ingraceperiod && enteredresurrect == 0 )
    {
        if ( smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_EXPLOSIVE_SPLASH" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_FALLING" )
        {
            if ( weapon.name != "incendiary_fire" )
            {
                self weapons::drop_scavenger_for_death( attacker );
            }
        }
    }
    
    if ( awardassists )
    {
        self function_3f735e1d( einflictor, attacker, weapon, lpattackteam );
    }
    
    pixbeginevent( "PlayerKilled post constants" );
    self.lastattacker = attacker;
    self.lastdeathpos = self.origin;
    
    if ( !level.teambased || isdefined( attacker ) && isplayer( attacker ) && attacker != self && attacker.team != self.team )
    {
        attacker notify( #"killed_enemy_player", { #victim:self, #weapon:weapon, #time:gettime() } );
        self thread challenges::playerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance, bledout );
    }
    else
    {
        self notify( #"playerkilledchallengesprocessed" );
    }
    
    if ( isdefined( self.attackers ) )
    {
        self.attackers = [];
    }
    
    killerheropoweractive = 0;
    killer = undefined;
    killerloadoutindex = -1;
    killerwasads = 0;
    killerinvictimfov = 0;
    victiminkillerfov = 0;
    
    if ( isplayer( attacker ) )
    {
        attacker.lastkilltime = gettime();
        killer = attacker;
        killerloadoutindex = attacker.class_num;
        killerwasads = attacker playerads() >= 1;
        killerinvictimfov = util::within_fov( self.origin, self.angles, attacker.origin, self.fovcosine );
        victiminkillerfov = util::within_fov( attacker.origin, attacker.angles, self.origin, attacker.fovcosine );
        
        if ( attacker ability_player::is_using_any_gadget() )
        {
            killerheropoweractive = 1;
        }
        
        if ( killstreaks::is_killstreak_weapon( weapon ) )
        {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats( weapon );
            bbprint( "mpattacks", "gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d killstreak %s", gettime(), getplayerspawnid( attacker ), weapon.name, lpattackorigin, getplayerspawnid( self ), self.origin, idamage, smeansofdeath, shitloc, 1, killerheropoweractive, killstreak );
        }
        else
        {
            bbprint( "mpattacks", "gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), getplayerspawnid( attacker ), weapon.name, lpattackorigin, getplayerspawnid( self ), self.origin, idamage, smeansofdeath, shitloc, 1, killerheropoweractive );
        }
        
        attacker thread weapons::bestweapon_kill( weapon );
    }
    else
    {
        bbprint( "mpattacks", "gametime %d attackerweapon %s victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), weapon.name, getplayerspawnid( self ), self.origin, idamage, smeansofdeath, shitloc, 1, 0 );
    }
    
    victimweapon = undefined;
    victimweaponpickedup = 0;
    victimkillstreakweaponindex = 0;
    
    if ( isdefined( weapon_at_time_of_death ) )
    {
        victimweapon = weapon_at_time_of_death;
        
        if ( isdefined( self.pickedupweapons ) && isdefined( self.pickedupweapons[ victimweapon ] ) )
        {
            victimweaponpickedup = 1;
        }
        
        if ( killstreaks::is_killstreak_weapon( victimweapon ) )
        {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats( victimweapon );
            
            if ( isdefined( level.killstreaks[ killstreak ].menuname ) )
            {
                victimkillstreakweaponindex = level.killstreakindices[ level.killstreaks[ killstreak ].menuname ];
            }
        }
    }
    
    victimwasads = self playerads() >= 1;
    victimheropoweractive = self ability_player::is_using_any_gadget();
    killerweaponpickedup = 0;
    killerkillstreakweaponindex = 0;
    var_74580782 = 125;
    
    if ( isdefined( weapon ) )
    {
        if ( isdefined( killer ) && isdefined( killer.pickedupweapons ) && isdefined( killer.pickedupweapons[ weapon ] ) )
        {
            killerweaponpickedup = 1;
        }
        
        if ( killstreaks::is_killstreak_weapon( weapon ) )
        {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats( weapon );
            
            if ( isdefined( level.killstreaks[ killstreak ].menuname ) )
            {
                killerkillstreakweaponindex = level.killstreakindices[ level.killstreaks[ killstreak ].menuname ];
                
                if ( isdefined( killerkillstreakweaponindex ) && isdefined( killer.killstreakevents ) && isdefined( killer.killstreakevents[ killerkillstreakweaponindex ] ) )
                {
                    var_74580782 = killer.killstreakevents[ killerkillstreakweaponindex ];
                }
                else
                {
                    var_74580782 = 126;
                }
            }
        }
    }
    
    matchrecordlogadditionaldeathinfo( self, killer, victimweapon, weapon, self.class_num, victimweaponpickedup, victimwasads, killerloadoutindex, killerweaponpickedup, killerwasads, victimheropoweractive, killerheropoweractive, victiminkillerfov, killerinvictimfov, killerkillstreakweaponindex, victimkillstreakweaponindex, var_74580782 );
    self record_special_move_data_for_life( killer );
    self.pickedupweapons = [];
    
    /#
        logprint( "<dev string:x291>" + lpselfguid + "<dev string:x12c>" + lpselfnum + "<dev string:x12c>" + lpselfteam + "<dev string:x12c>" + lpselfname + "<dev string:x12c>" + lpattackguid + "<dev string:x12c>" + lpattacknum + "<dev string:x12c>" + lpattackteam + "<dev string:x12c>" + lpattackname + "<dev string:x12c>" + weapon.name + "<dev string:x12c>" + idamage + "<dev string:x12c>" + smeansofdeath + "<dev string:x12c>" + shitloc + "<dev string:x12e>" );
    #/
    
    attackerstring = "none";
    
    if ( isplayer( attacker ) )
    {
        attackerstring = attacker getxuid() + "(" + lpattackname + ")";
    }
    
    /#
        print( "<dev string:x294>" + smeansofdeath + "<dev string:x297>" + weapon.name + "<dev string:x299>" + attackerstring + "<dev string:x29e>" + idamage + "<dev string:x2a2>" + shitloc + "<dev string:x2a6>" + int( self.origin[ 0 ] ) + "<dev string:x2aa>" + int( self.origin[ 1 ] ) + "<dev string:x2aa>" + int( self.origin[ 2 ] ) );
    #/
    
    if ( !level.rankedmatch && !level.teambased )
    {
        level thread function_36b1aaf0();
    }
    
    level thread globallogic::updateteamstatus();
    level thread globallogic::updatealivetimes( self.team );
    
    if ( isdefined( self.killcam_entity_info_cached ) )
    {
        killcam_entity_info = self.killcam_entity_info_cached;
        self.killcam_entity_info_cached = undefined;
    }
    else
    {
        killcam_entity_info = killcam::get_killcam_entity_info( attacker, einflictor, weapon );
    }
    
    if ( isdefined( self.killstreak_delay_killcam ) )
    {
        dokillcam = 0;
    }
    
    self weapons::detach_carry_object_model();
    pixendevent();
    pixbeginevent( "PlayerKilled body and gibbing" );
    vattackerorigin = undefined;
    
    if ( isdefined( attacker ) )
    {
        vattackerorigin = attacker.origin;
    }
    
    if ( enteredresurrect == 0 )
    {
        clone_weapon = weapon;
        
        if ( weapon_utils::ismeleemod( smeansofdeath ) && clone_weapon.type != "melee" )
        {
            clone_weapon = level.weaponnone;
        }
        
        body = self cloneplayer( deathanimduration, clone_weapon, attacker );
        
        if ( isdefined( body ) )
        {
            self function_39d71623( attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body );
            self battlechatter::play_death_vox( body, attacker, weapon, smeansofdeath );
            globallogic::doweaponspecificcorpseeffects( body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime );
        }
    }
    
    pixendevent();
    
    if ( enteredresurrect )
    {
        thread globallogic_spawn::spawnqueuedclient( self.team, attacker );
    }
    
    self.switching_teams = undefined;
    self.joining_team = undefined;
    self.leaving_team = undefined;
    
    if ( bledout == 0 )
    {
        self thread [[ level.onplayerkilled ]]( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
    }
    
    for ( var_4eb9549 = 0; var_4eb9549 < level.onplayerkilledextraunthreadedcbs.size ; var_4eb9549++ )
    {
        self [[ level.onplayerkilledextraunthreadedcbs[ var_4eb9549 ] ]]( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
    }
    
    self.wantsafespawn = 0;
    perks = [];
    killstreaks = globallogic::getkillstreaks( attacker );
    
    if ( !isdefined( self.killstreak_delay_killcam ) )
    {
        self thread [[ level.spawnplayerprediction ]]();
    }
    
    profilelog_endtiming( 7, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
    
    if ( wasteamkill == 0 && assistedsuicide == 0 && smeansofdeath != "MOD_SUICIDE" && !( !isdefined( attacker ) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker == self || isdefined( attacker.disablefinalkillcam ) ) )
    {
        level thread killcam::record_settings( lpattacknum, self getentitynumber(), killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, attacker );
    }
    
    if ( enteredresurrect )
    {
        return;
    }
    
    wait 0.25;
    weaponclass = util::getweaponclass( weapon );
    
    if ( isdefined( weaponclass ) && weaponclass == "weapon_sniper" )
    {
        self thread battlechatter::killed_by_sniper( attacker );
    }
    else
    {
        self thread battlechatter::player_killed( attacker, killstreak );
    }
    
    self.cancelkillcam = 0;
    self thread killcam::cancel_on_use();
    self function_f9dae37e( weapon, smeansofdeath, deathanimduration );
    
    /#
        if ( getdvarint( "<dev string:x2ac>" ) != 0 )
        {
            dokillcam = 1;
            
            if ( lpattacknum < 0 )
            {
                lpattacknum = self getentitynumber();
            }
        }
    #/
    
    if ( game.state != "playing" )
    {
        return;
    }
    
    self.respawntimerstarttime = gettime();
    keep_deathcam = 0;
    
    if ( isdefined( self.overrideplayerdeadstatus ) )
    {
        keep_deathcam = self [[ self.overrideplayerdeadstatus ]]();
    }
    
    if ( !self.cancelkillcam && dokillcam && level.killcam && wasteamkill == 0 )
    {
        livesleft = !( level.numlives && !self.pers[ "lives" ] ) && !( level.numteamlives && !game.lives[ self.team ] );
        timeuntilspawn = globallogic_spawn::timeuntilspawn( 1 );
        willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn;
        self killcam::killcam( lpattacknum, self getentitynumber(), killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, willrespawnimmediately, globallogic_utils::timeuntilroundend(), perks, killstreaks, attacker, keep_deathcam );
    }
    else if ( self.cancelkillcam )
    {
        if ( isdefined( self.killcamsskipped ) )
        {
            self.killcamsskipped++;
        }
        else
        {
            self.killcamsskipped = 1;
        }
    }
    
    secondary_deathcam = 0;
    timeuntilspawn = globallogic_spawn::timeuntilspawn( 1 );
    shoulddoseconddeathcam = timeuntilspawn > 0;
    
    if ( shoulddoseconddeathcam && isdefined( self.secondarydeathcamtime ) )
    {
        secondary_deathcam = self [[ self.secondarydeathcamtime ]]();
    }
    
    if ( secondary_deathcam > 0 && !self.cancelkillcam )
    {
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        globallogic_utils::waitfortimeornotify( secondary_deathcam, "end_death_delay" );
        self notify( #"death_delay_finished" );
    }
    
    if ( !self.cancelkillcam && dokillcam && level.killcam && keep_deathcam )
    {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
    }
    
    if ( game.state != "playing" )
    {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamtargetentity = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        return;
    }
    
    function_188bdae1();
    userespawntime = 1;
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        userespawntime = 0;
    }
    
    hostmigration::waittillhostmigrationcountdown();
    
    if ( globallogic_utils::isvalidclass( self.curclass ) )
    {
        timepassed = undefined;
        
        if ( isdefined( self.respawntimerstarttime ) && userespawntime )
        {
            timepassed = ( gettime() - self.respawntimerstarttime ) / 1000;
        }
        
        self thread [[ level.spawnclient ]]( timepassed );
        self.respawntimerstarttime = undefined;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x296580a3, Offset: 0x11960
// Size: 0x2c6
function function_36b1aaf0()
{
    waittillframeend();
    
    if ( !level.players.size )
    {
        return;
    }
    
    placement = [];
    
    foreach ( player in level.players )
    {
        if ( player.team != "spectator" )
        {
            placement[ placement.size ] = player;
        }
    }
    
    for ( i = 1; i < placement.size ; i++ )
    {
        player = placement[ i ];
        playerscore = player.pointstowin;
        
        for ( j = i - 1; playerscore == placement[ j ].pointstowin && player.deaths == placement[ j ].deaths && ( playerscore == placement[ j ].pointstowin && ( playerscore > placement[ j ].pointstowin || player.deaths < placement[ j ].deaths ) || j >= 0 && player.lastkilltime > placement[ j ].lastkilltime ) ; j-- )
        {
            placement[ j + 1 ] = placement[ j ];
        }
        
        placement[ j + 1 ] = player;
    }
    
    cleartopscorers();
    
    for ( i = 0; i < placement.size && i < 3 ; i++ )
    {
        settopscorer( i, placement[ i ], 0, 0, 0, 0, level.weaponnone );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 3
// Checksum 0x735d502f, Offset: 0x11c30
// Size: 0xf2
function function_f9dae37e( weapon, smeansofdeath, deathanimduration )
{
    defaultplayerdeathwatchtime = 1.75;
    
    if ( smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime )
    {
        defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
    }
    else if ( 0 < weapon.deathcamtime )
    {
        defaultplayerdeathwatchtime = weapon.deathcamtime;
    }
    
    if ( isdefined( level.overrideplayerdeathwatchtimer ) )
    {
        defaultplayerdeathwatchtime = [[ level.overrideplayerdeathwatchtimer ]]( defaultplayerdeathwatchtime );
    }
    
    globallogic_utils::waitfortimeornotify( defaultplayerdeathwatchtime, "end_death_delay" );
    self notify( #"death_delay_finished" );
}

// Namespace globallogic_player/globallogic_player
// Params 4
// Checksum 0xb26394f4, Offset: 0x11d30
// Size: 0x8e, Type: bool
function should_drop_weapon_on_death( wasteamkill, wassuicide, current_weapon, smeansofdeath )
{
    if ( wasteamkill )
    {
        return false;
    }
    
    if ( wassuicide )
    {
        return false;
    }
    
    if ( smeansofdeath == "MOD_TRIGGER_HURT" && !self isonground() )
    {
        return false;
    }
    
    if ( isdefined( current_weapon ) && current_weapon.isheavyweapon )
    {
        return false;
    }
    
    return true;
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xa1d7d4b8, Offset: 0x11dc8
// Size: 0x2c
function function_117043()
{
    if ( self isbot() )
    {
        level.globallarryskilled++;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x400f2457, Offset: 0x11e00
// Size: 0x4c
function function_188bdae1()
{
    if ( isdefined( self.killstreak_delay_killcam ) )
    {
        while ( isdefined( self.killstreak_delay_killcam ) )
        {
            wait 0.1;
        }
        
        wait 2;
        self killstreaks::reset_killstreak_delay_killcam();
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xcbd76307, Offset: 0x11e58
// Size: 0x84
function function_361da015()
{
    self globallogic_score::incpersstat( "sessionbans", 1 );
    self endon( #"disconnect" );
    waittillframeend();
    globallogic::gamehistoryplayerkicked();
    ban( self getentitynumber() );
    globallogic_audio::leader_dialog( "gamePlayerKicked" );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xd4151f1f, Offset: 0x11ee8
// Size: 0x1ec
function function_b8f126c4()
{
    self globallogic_score::incpersstat( "sessionbans", 1 );
    self endon( #"disconnect" );
    waittillframeend();
    playlistbanquantum = tweakables::gettweakablevalue( "team", "teamkillerplaylistbanquantum" );
    playlistbanpenalty = tweakables::gettweakablevalue( "team", "teamkillerplaylistbanpenalty" );
    
    if ( playlistbanquantum > 0 && playlistbanpenalty > 0 )
    {
        timeplayedtotal = self getdstat( "playerstatslist", "time_played_total", "StatValue" );
        minutesplayed = timeplayedtotal / 60;
        freebees = 2;
        banallowance = int( floor( minutesplayed / playlistbanquantum ) ) + freebees;
        
        if ( self.sessionbans > banallowance )
        {
            self setdstat( "playerstatslist", "gametypeban", "StatValue", timeplayedtotal + playlistbanpenalty * 60 );
        }
    }
    
    globallogic::gamehistoryplayerkicked();
    ban( self getentitynumber() );
    globallogic_audio::leader_dialog( "gamePlayerKicked" );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xffac8936, Offset: 0x120e0
// Size: 0x80
function teamkilldelay()
{
    teamkills = self.pers[ "teamkills_nostats" ];
    
    if ( level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills )
    {
        return 0;
    }
    
    exceeded = teamkills - level.minimumallowedteamkills;
    return level.teamkillspawndelay * exceeded;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0x147f566, Offset: 0x12168
// Size: 0x6e, Type: bool
function function_a4451c91( teamkilldelay )
{
    if ( teamkilldelay && level.minimumallowedteamkills >= 0 )
    {
        if ( globallogic_utils::gettimepassed() >= 5000 )
        {
            return true;
        }
        
        if ( self.pers[ "teamkills_nostats" ] > 1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x3a1cfcf9, Offset: 0x121e0
// Size: 0xc8
function function_a1ea27f6()
{
    timeperoneteamkillreduction = 20;
    reductionpersecond = 1 / timeperoneteamkillreduction;
    
    while ( true )
    {
        if ( isalive( self ) )
        {
            self.pers[ "teamkills_nostats" ] = self.pers[ "teamkills_nostats" ] - reductionpersecond;
            
            if ( self.pers[ "teamkills_nostats" ] < level.minimumallowedteamkills )
            {
                self.pers[ "teamkills_nostats" ] = level.minimumallowedteamkills;
                break;
            }
        }
        
        wait 1;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 3
// Checksum 0x641b913b, Offset: 0x122b0
// Size: 0xfc, Type: bool
function ignoreteamkills( weapon, smeansofdeath, einflictor )
{
    if ( weapon_utils::ismeleemod( smeansofdeath ) )
    {
        return false;
    }
    
    if ( weapon.ignoreteamkills )
    {
        return true;
    }
    
    if ( isdefined( einflictor ) && einflictor.ignore_team_kills === 1 )
    {
        return true;
    }
    
    if ( isdefined( einflictor ) && isdefined( einflictor.destroyedby ) && isdefined( einflictor.owner ) && einflictor.destroyedby != einflictor.owner )
    {
        return true;
    }
    
    if ( isdefined( einflictor ) && einflictor.classname == "worldspawn" )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 9
// Checksum 0xf9c60251, Offset: 0x123b8
// Size: 0x84
function callback_playerlaststand( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    laststand::playerlaststand( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0x3c98da3a, Offset: 0x12448
// Size: 0x8c
function damageshellshockandrumble( eattacker, einflictor, weapon, smeansofdeath, idamage )
{
    self thread weapons::on_damage( eattacker, einflictor, weapon, smeansofdeath, idamage );
    
    if ( !self util::isusingremote() )
    {
        self playrumbleonentity( "damage_heavy" );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 10
// Checksum 0x5bb5a3ee, Offset: 0x124e0
// Size: 0x3cc
function function_39d71623( attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body )
{
    if ( smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone" )
    {
        self.body = body;
        
        if ( !isdefined( self.switching_teams ) )
        {
            thread deathicons::add( body, self, self.team );
        }
        
        return;
    }
    
    ragdoll_now = 0;
    
    if ( isdefined( self.usingvehicle ) && self.usingvehicle && isdefined( self.vehicleposition ) && self.vehicleposition == 1 )
    {
        ragdoll_now = 1;
    }
    
    if ( isdefined( level.ragdoll_override ) && self [[ level.ragdoll_override ]]( idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body ) )
    {
        return;
    }
    
    if ( ragdoll_now || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT" )
    {
        body startragdoll();
    }
    
    if ( !self isonground() && smeansofdeath != "MOD_FALLING" )
    {
        if ( getdvarint( "scr_disable_air_death_ragdoll" ) == 0 )
        {
            body startragdoll();
        }
    }
    
    if ( smeansofdeath == "MOD_MELEE_ASSASSINATE" && !attacker isonground() )
    {
        body start_death_from_above_ragdoll( vdir );
    }
    
    if ( self is_explosive_ragdoll( weapon, einflictor ) )
    {
        body start_explosive_ragdoll( vdir, weapon );
    }
    
    thread delaystartragdoll( body, shitloc, vdir, weapon, einflictor, smeansofdeath );
    
    if ( smeansofdeath == "MOD_CRUSH" )
    {
        body globallogic_vehicle::vehiclecrush();
    }
    
    self.body = body;
    
    if ( !isdefined( self.switching_teams ) )
    {
        thread deathicons::add( body, self, self.team );
    }
    
    params = spawnstruct();
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    self.body callback::callback( #"hash_aa09fd19" );
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x67afe4ee, Offset: 0x128b8
// Size: 0xb2, Type: bool
function is_explosive_ragdoll( weapon, inflictor )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    if ( weapon.name == "destructible_car" || weapon.name == "explodable_barrel" )
    {
        return true;
    }
    
    if ( weapon.projexplosiontype == "grenade" )
    {
        if ( isdefined( inflictor ) && isdefined( inflictor.stucktoplayer ) )
        {
            if ( inflictor.stucktoplayer == self )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x76d4ede7, Offset: 0x12978
// Size: 0x1b4
function start_explosive_ragdoll( dir, weapon )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    x = randomintrange( 50, 100 );
    y = randomintrange( 50, 100 );
    z = randomintrange( 10, 20 );
    
    if ( weapon.name == "sticky_grenade" || isdefined( weapon ) && weapon.name == "explosive_bolt" )
    {
        if ( isdefined( dir ) && lengthsquared( dir ) > 0 )
        {
            x = dir[ 0 ] * x;
            y = dir[ 1 ] * y;
        }
    }
    else
    {
        if ( math::cointoss() )
        {
            x *= -1;
        }
        
        if ( math::cointoss() )
        {
            y *= -1;
        }
    }
    
    self startragdoll();
    self launchragdoll( ( x, y, z ) );
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0x73c2c724, Offset: 0x12b38
// Size: 0x4c
function start_death_from_above_ragdoll( dir )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self startragdoll();
    self launchragdoll( ( 0, 0, -100 ) );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x97dabd0f, Offset: 0x12b90
// Size: 0x44
function notifyconnecting()
{
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        level notify( #"connecting", { #player:self } );
    }
    
    callback::callback( #"hash_fefe13f5" );
}

// Namespace globallogic_player/globallogic_player
// Params 6
// Checksum 0x3da4d9a7, Offset: 0x12be0
// Size: 0x194
function delaystartragdoll( ent, shitloc, vdir, weapon, einflictor, smeansofdeath )
{
    if ( isdefined( ent ) )
    {
        deathanim = ent getcorpseanim();
        
        if ( animhasnotetrack( deathanim, "ignore_ragdoll" ) )
        {
            return;
        }
    }
    
    waittillframeend();
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( ent isragdoll() )
    {
        return;
    }
    
    deathanim = ent getcorpseanim();
    startfrac = 0.35;
    
    if ( animhasnotetrack( deathanim, "start_ragdoll" ) )
    {
        times = getnotetracktimes( deathanim, "start_ragdoll" );
        
        if ( isdefined( times ) )
        {
            startfrac = times[ 0 ];
        }
    }
    
    waittime = startfrac * getanimlength( deathanim );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    if ( isdefined( ent ) )
    {
        ent startragdoll();
    }
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0xe43891a3, Offset: 0x12d80
// Size: 0xf2
function function_d7eade4e( attacker, einflictor, weapon, smeansofdeath, shitloc )
{
    if ( globallogic_utils::isheadshot( weapon, shitloc, smeansofdeath, einflictor ) && isplayer( attacker ) && !weapon_utils::ismeleemod( smeansofdeath ) )
    {
        return "MOD_HEAD_SHOT";
    }
    
    switch ( weapon.name )
    {
        case #"dog_bite":
            smeansofdeath = "MOD_PISTOL_BULLET";
            break;
        case #"destructible_car":
            smeansofdeath = "MOD_EXPLOSIVE";
            break;
        case #"explodable_barrel":
            smeansofdeath = "MOD_EXPLOSIVE";
            break;
    }
    
    return smeansofdeath;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x3d18edb9, Offset: 0x12e80
// Size: 0x304
function function_9cedb097( attacker, weapon )
{
    if ( isai( attacker ) && isdefined( attacker.script_owner ) )
    {
        if ( !level.teambased || attacker.script_owner.team != self.team )
        {
            attacker = attacker.script_owner;
        }
    }
    
    if ( attacker.classname == "script_vehicle" && isdefined( attacker.owner ) )
    {
        attacker notify( #"killed", { #victim:self } );
        attacker = attacker.owner;
    }
    
    if ( isai( attacker ) )
    {
        attacker notify( #"killed", { #victim:self } );
    }
    
    if ( isdefined( self.capturinglastflag ) && self.capturinglastflag == 1 )
    {
        attacker.lastcapkiller = 1;
    }
    
    if ( isdefined( attacker ) && attacker != self && isdefined( weapon ) )
    {
        if ( weapon.name == "planemortar" )
        {
            if ( !isdefined( attacker.planemortarbda ) )
            {
                attacker.planemortarbda = 0;
            }
            
            attacker.planemortarbda++;
        }
        else if ( weapon.name == "dart" || weapon.name == "dart_turret" )
        {
            if ( !isdefined( attacker.dartbda ) )
            {
                attacker.dartbda = 0;
            }
            
            attacker.dartbda++;
        }
        else if ( weapon.name == "straferun_rockets" || weapon.name == "straferun_gun" )
        {
            if ( isdefined( attacker.straferunbda ) )
            {
                attacker.straferunbda++;
            }
        }
        else if ( weapon.name == "remote_missile_missile" || weapon.name == "remote_missile_bomblet" )
        {
            if ( !isdefined( attacker.remotemissilebda ) )
            {
                attacker.remotemissilebda = 0;
            }
            
            attacker.remotemissilebda++;
        }
    }
    
    return attacker;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xcf0e75a7, Offset: 0x13190
// Size: 0x74
function function_1e4d3508( einflictor )
{
    if ( isdefined( einflictor ) && einflictor.classname == "script_vehicle" )
    {
        einflictor notify( #"killed", { #victim:self } );
        
        if ( isdefined( einflictor.bda ) )
        {
            einflictor.bda++;
        }
    }
    
    return einflictor;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0xcad1602a, Offset: 0x13210
// Size: 0xdc
function updateweapon( einflictor, weapon )
{
    if ( weapon == level.weaponnone && isdefined( einflictor ) )
    {
        if ( isdefined( einflictor.targetname ) && einflictor.targetname == "explodable_barrel" )
        {
            weapon = getweapon( "explodable_barrel" );
        }
        else if ( isdefined( einflictor.destructible_type ) && issubstr( einflictor.destructible_type, "vehicle_" ) )
        {
            weapon = getweapon( "destructible_car" );
        }
    }
    
    return weapon;
}

// Namespace globallogic_player/globallogic_player
// Params 4
// Checksum 0x11eec63d, Offset: 0x132f8
// Size: 0xa8
function playkillbattlechatter( attacker, weapon, victim, einflictor )
{
    if ( isplayer( attacker ) )
    {
        if ( !killstreaks::is_killstreak_weapon( weapon ) )
        {
            level thread battlechatter::say_kill_battle_chatter( attacker, weapon, victim, einflictor );
        }
    }
    
    if ( isdefined( einflictor ) )
    {
        einflictor notify( #"bhtn_action_notify", { #action:"attack_kill" } );
    }
}

