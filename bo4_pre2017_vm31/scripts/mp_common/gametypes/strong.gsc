#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/medals_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_defaults;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_spawn;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/spawnbeacon;
#using scripts/mp_common/userspawnselection;
#using scripts/mp_common/util;

#namespace mission_koth;

// Namespace mission_koth/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x5024e9bc, Offset: 0xce8
// Size: 0x608
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 2000 );
    util::registernumlives( 0, 100 );
    util::registerroundswitch( 0, 9 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registerscorelimit( 0, 5000 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    game.objective_gained_sound = "mpl_flagcapture_sting_friend";
    game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
    level.onstartgametype = &on_start_gametype;
    level.onspawnplayer = &on_spawn_player;
    level.onroundswitch = &on_round_switch;
    level.onplayerkilled = &on_player_killed;
    level.ontimelimit = &on_time_limit;
    level.onroundendgame = &function_4743c62a;
    level.gettimelimit = &gettimelimit;
    level.teambased = 1;
    level.doprematch = 1;
    level.overrideteamscore = 1;
    level.warstarttime = 0;
    level.var_b2e6979d = 1;
    level.scoreroundwinbased = getgametypesetting( "cumulativeRoundScores" ) == 0;
    level.zonespawntime = getgametypesetting( "objectiveSpawnTime" );
    level.capturetime = getgametypesetting( "captureTime" );
    level.destroytime = getgametypesetting( "destroyTime" );
    level.timepauseswheninzone = getgametypesetting( "timePausesWhenInZone" );
    level.delayplayer = getgametypesetting( "delayPlayer" );
    level.scoreperplayer = getgametypesetting( "scorePerPlayer" );
    level.neutralzone = getgametypesetting( "neutralZone" );
    level.zonecount = getgametypesetting( "zoneCount" );
    level.decaycapturedzones = getgametypesetting( "decayCapturedZones" );
    level.capdecay = getgametypesetting( "capDecay" );
    level.extratime = getgametypesetting( "extraTime" );
    level.timerpaused = 0;
    level.zonepauseinfo = [];
    level.numzonesoccupied = 0;
    globallogic_audio::set_leader_gametype_dialog( "startControl", "hcStartControl", "controlOrdersOfs", "controlOrdersDef" );
    register_clientfields();
    callback::on_connect( &on_player_connect );
    gameobjects::register_allowed_gameobject( level.gametype );
    level.audiocues = [];
    level.mission_bundle = getscriptbundle( "mission_settings_strong" );
    globallogic_spawn::addsupportedspawnpointtype( 16384 );
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "rolescore", "score", "kills", "deaths", "objtime", "defends" );
    }
    else
    {
        globallogic::setvisiblescoreboardcolumns( "rolescore", "score", "kills", "deaths", "objtime", "defends" );
    }
    
    level.audioplaybackthrottle = int( level.mission_bundle.msaudioplaybackthrottle );
    
    if ( !isdefined( level.audioplaybackthrottle ) )
    {
        level.audioplaybackthrottle = 5000;
    }
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0xcc5f5d4a, Offset: 0x12f8
// Size: 0xc4
function register_clientfields()
{
    clientfield::register( "world", "warzone", 1, 5, "int" );
    clientfield::register( "world", "warzonestate", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.missions.captureMultiplierStatus", 1, 2, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int" );
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0xb68ba355, Offset: 0x13c8
// Size: 0x17c
function on_time_limit()
{
    winner = game.defenders;
    
    if ( isdefined( level.neutralzone ) && level.neutralzone )
    {
        s1 = isdefined( globallogic_score::_getteamscore( game.attackers ) ) ? globallogic_score::_getteamscore( game.attackers ) : 0;
        s2 = isdefined( globallogic_score::_getteamscore( game.defenders ) ) ? globallogic_score::_getteamscore( game.defenders ) : 0;
        
        if ( s1 > s2 )
        {
            winner = game.attackers;
        }
        else if ( s2 > s1 )
        {
            winner = game.defenders;
        }
        else
        {
            winner = "tie";
        }
    }
    else
    {
        globallogic_score::giveteamscoreforobjective( game.defenders, 1 );
    }
    
    thread globallogic::endgame( winner, game.strings[ "time_limit_reached" ] );
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0xd2a524d2, Offset: 0x1550
// Size: 0x54
function on_spawn_player( predictedspawn )
{
    if ( level.usestartspawns && !level.ingraceperiod )
    {
        level.usestartspawns = 0;
    }
    
    spawning::onspawnplayer( predictedspawn );
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x7ee91ec1, Offset: 0x15b0
// Size: 0x2c
function on_round_switch()
{
    game.switchedsides = !game.switchedsides;
    userspawnselection::onroundchange();
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x3d31ee, Offset: 0x15e8
// Size: 0x46
function gettimelimit()
{
    timelimit = globallogic_defaults::default_gettimelimit();
    
    if ( level.usingextratime )
    {
        return ( timelimit + level.extratime );
    }
    
    return timelimit;
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0x4be4d694, Offset: 0x1638
// Size: 0x6c
function function_4743c62a( winningteam )
{
    if ( level.scoreroundwinbased )
    {
        globallogic_score::updateteamscorebyroundswon();
        winner = globallogic::determineteamwinnerbygamestat( "roundswon" );
    }
    else
    {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    
    return winner;
}

// Namespace mission_koth/strong
// Params 9
// Checksum 0x4fe26b1c, Offset: 0x16b0
// Size: 0x364
function on_player_killed( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isdefined( level.forward_spawn_on_player_killed ) )
    {
        [[ level.forward_spawn_on_player_killed ]]( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
    }
    
    livesleft = !( level.numlives && !self.pers[ "lives" ] ) && !( level.numteamlives && !game.lives[ self.team ] );
    
    if ( !( isdefined( livesleft ) && livesleft ) )
    {
        players = getplayers( self.team );
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isalive( players[ i ] ) )
            {
                var_3fe35a44 = 1;
                break;
            }
        }
        
        if ( !( isdefined( var_3fe35a44 ) && var_3fe35a44 ) )
        {
            level notify( #"out_of_lives" );
        }
    }
    
    if ( level.capturetime && !self.touchtriggers.size && ( !isplayer( attacker ) || !attacker.touchtriggers.size ) || attacker.pers[ "team" ] == self.pers[ "team" ] )
    {
        return;
    }
    
    medalgiven = 0;
    scoreeventprocessed = 0;
    ownerteam = undefined;
    zone = level.zone;
    
    if ( level.capturetime == 0 )
    {
        if ( !isdefined( zone ) )
        {
            return;
        }
        
        ownerteam = zone.gameobject.ownerteam;
        
        if ( !isdefined( ownerteam ) || ownerteam == "neutral" )
        {
            return;
        }
    }
    
    if ( level.capturetime == 0 && ( self.touchtriggers.size || self istouching( zone.trig ) ) )
    {
        if ( self.team == game.attackers && attacker.team == game.defenders )
        {
            scoreevents::processscoreevent( "war_killed_attacker_in_zone", attacker, undefined, weapon );
        }
    }
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0xc1ec548f, Offset: 0x1a20
// Size: 0xa0
function get_player_userate( use_object )
{
    use_rate_multiplier = 1;
    
    if ( isdefined( self.playerrole ) )
    {
        if ( self.team == game.attackers )
        {
            use_rate_multiplier = self.playerrole.attackercapturemultiplier;
        }
        else if ( self.team == game.defenders )
        {
            use_rate_multiplier = self.playerrole.defenddecaymultiplier;
        }
    }
    
    return use_rate_multiplier;
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x4b09fadf, Offset: 0x1ac8
// Size: 0x24
function on_player_connect()
{
    self gameobjects::setplayergametypeuseratecallback( &get_player_userate );
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x3a35d6e8, Offset: 0x1af8
// Size: 0x204
function on_start_gametype()
{
    globallogic_utils::switch_sides();
    level.usestartspawns = 1;
    level.usingextratime = 0;
    level.wartotalsecondsinzone = 0;
    setup_objectives();
    globallogic_score::resetteamscores();
    influencers::create_map_placed_influencers();
    level.zones = get_zone_array();
    level.zonemask = 0;
    level.zonestatemask = 0;
    setup_zone_spawns();
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.spawn_all = spawning::get_spawnpoint_array( "mp_tdm_spawn" );
    
    if ( !level.spawn_all.size )
    {
        println( "<dev string:x28>" );
        callback::abort_level();
        return;
    }
    
    userspawnselection::supressspawnselectionmenuforallplayers();
    setup_zones();
    thread set_ui_team();
    thread main_loop();
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x16d9496e, Offset: 0x1d08
// Size: 0x592
function setup_zones()
{
    if ( level.zones.size == 0 )
    {
        return;
    }
    
    if ( level.zonecount > 1 )
    {
        level.nzones = level.zones.size;
        trigs = getentarray( "stronghold_zone_trigger", "targetname" );
    }
    else
    {
        level.nzones = 1;
        trigs = getentarray( "stronghold_zone_trigger", "targetname" );
    }
    
    for ( zi = 0; zi < level.nzones ; zi++ )
    {
        zone = level.zones[ zi ];
        errored = 0;
        zone.trig = undefined;
        
        for ( j = 0; j < trigs.size ; j++ )
        {
            if ( zone istouching( trigs[ j ] ) )
            {
                if ( isdefined( zone.trig ) )
                {
                    globallogic_utils::add_map_error( "Zone at " + zone.origin + " is touching more than one \"zonetrigger\" trigger" );
                    errored = 1;
                    break;
                }
                
                zone.trig = trigs[ j ];
                break;
            }
        }
        
        if ( !isdefined( zone.trig ) )
        {
            if ( !errored )
            {
                globallogic_utils::add_map_error( "Zone at " + zone.origin + " is not inside any \"zonetrigger\" trigger" );
                return;
            }
        }
        
        assert( !errored );
        zone.trigorigin = zone.trig.origin;
        zone.objectiveanchor = spawn( "script_model", zone.origin );
        visuals = [];
        visuals[ 0 ] = zone;
        
        if ( isdefined( zone.target ) )
        {
            othervisuals = getentarray( zone.target, "targetname" );
            
            for ( j = 0; j < othervisuals.size ; j++ )
            {
                visuals[ visuals.size ] = othervisuals[ j ];
            }
        }
        
        ownerteam = game.defenders;
        
        if ( isdefined( level.neutralzone ) && level.neutralzone )
        {
            ownerteam = "neutral";
        }
        
        zone.gameobject = gameobjects::create_use_object( ownerteam, zone.trig, visuals, ( 0, 0, 0 ), istring( "strong_" + zi ) );
        zone.gameobject gameobjects::set_objective_entity( zone );
        zone.gameobject gameobjects::disable_object();
        zone.gameobject gameobjects::set_model_visibility( 0 );
        zone.gameobject.owningzone = zone;
        zone.trig.useobj = zone.gameobject;
        zone.trig.var_f52dc901 = 1;
        zone.gameobject.lastteamtoownzone = "neutral";
        zone.gameobject.currentlyunoccupied = 1;
        zone.scores = [];
        
        foreach ( team in level.teams )
        {
            zone.scores[ team ] = 0;
        }
        
        zone setup_zone_exclusions();
    }
    
    if ( globallogic_utils::print_map_errors() )
    {
        return 0;
    }
}

// Namespace mission_koth/strong
// Params 0, eflags: 0x4
// Checksum 0x29e87611, Offset: 0x22a8
// Size: 0x114
function private setup_zone_spawns()
{
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    level.spawnsystem.sideswitching = 0;
    spawning::clear_spawn_points();
    spawning::add_spawn_points( game.attackers, "mp_strong_spawn_attacker_region_1" );
    spawning::add_spawn_points( game.defenders, "mp_strong_spawn_defender_region_1" );
    spawning::updateallspawnpoints();
    
    if ( level.usestartspawns )
    {
        spawning::add_start_spawn_points( game.attackers, "mp_war_spawn_attacker_zone_1_start" );
        spawning::add_start_spawn_points( game.defenders, "mp_war_spawn_defender_zone_1_start" );
    }
    
    globallogic_spawn::addspawns();
}

// Namespace mission_koth/strong
// Params 2
// Checksum 0xc73f72e6, Offset: 0x23c8
// Size: 0x10e, Type: bool
function compare_zone_indicies( zone_a, zone_b )
{
    script_index_a = zone_a.script_index;
    script_index_b = zone_b.script_index;
    
    if ( !isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        return false;
    }
    
    if ( !isdefined( script_index_a ) && isdefined( script_index_b ) )
    {
        println( "<dev string:x50>" + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:x50>" + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0xca9893c3, Offset: 0x24e0
// Size: 0x376
function get_zone_array()
{
    if ( level.zonecount > 1 )
    {
        allzones = getentarray( "stronghold_zone_center", "targetname" );
        
        if ( !isdefined( allzones ) )
        {
            globallogic_utils::add_map_error( "Cannot find any zone entities" );
            return;
        }
        
        zoneindices = [];
        numberofzones = level.zonecount;
        
        for ( i = 0; i < numberofzones ; i++ )
        {
            fieldname = "zoneinfo" + numberofzones + i + 1;
            index = isdefined( level.mission_bundle.( fieldname ) ) ? level.mission_bundle.( fieldname ) : 0;
            zoneindices[ zoneindices.size ] = index;
        }
        
        zones = [];
        
        for ( i = 0; i < allzones.size ; i++ )
        {
            ind = allzones[ i ].script_index;
            
            if ( isdefined( ind ) )
            {
                for ( j = 0; j < zoneindices.size ; j++ )
                {
                    if ( zoneindices[ j ] == ind )
                    {
                        zones[ zones.size ] = allzones[ i ];
                        break;
                    }
                }
                
                continue;
            }
            
            globallogic_utils::add_map_error( "Zone with no script_index set" );
        }
    }
    else
    {
        zones = getentarray( "stronghold_zone_center", "targetname" );
    }
    
    if ( !isdefined( zones ) )
    {
        return undefined;
    }
    
    swapped = 1;
    
    for ( n = zones.size; swapped ; n-- )
    {
        swapped = 0;
        
        for ( i = 0; i < n - 1 ; i++ )
        {
            if ( compare_zone_indicies( zones[ i ], zones[ i + 1 ] ) )
            {
                temp = zones[ i ];
                zones[ i ] = zones[ i + 1 ];
                zones[ i + 1 ] = temp;
                swapped = 1;
            }
        }
    }
    
    for ( i = 0; i < zones.size ; i++ )
    {
        zones[ i ].zone_index = i;
    }
    
    return zones;
}

// Namespace mission_koth/strong
// Params 2
// Checksum 0xbab1c40, Offset: 0x2860
// Size: 0x104
function update_objective_hint_message( attackersmsg, defendersmsg )
{
    gametype = getdvarstring( "g_gametype" );
    
    foreach ( team in level.teams )
    {
        if ( team == game.attackers )
        {
            game.strings[ "objective_hint_" + team ] = attackersmsg;
            continue;
        }
        
        game.strings[ "objective_hint_" + team ] = defendersmsg;
    }
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x25db191f, Offset: 0x2970
// Size: 0x212
function setup_objectives()
{
    level.objectivehintpreparezone = &"MP_CONTROL_KOTH";
    level.objectivehintcapturezone = &"MP_CAPTURE_KOTH";
    level.objectivehintdefendhq = &"MP_DEFEND_KOTH";
    
    foreach ( team in level.teams )
    {
        util::setobjectivetext( team, &"OBJECTIVES_KOTH" );
        
        if ( level.splitscreen )
        {
            util::setobjectivescoretext( team, &"OBJECTIVES_KOTH" );
            continue;
        }
        
        util::setobjectivescoretext( team, &"OBJECTIVES_KOTH_SCORE" );
    }
    
    if ( level.zonespawntime )
    {
        update_objective_hint_message( level.objectivehintpreparezone );
    }
    else
    {
        update_objective_hint_message( level.objectivehintcapturezone );
    }
    
    game.strings[ game.attackers + "_mission_win" ] = &"OBJECTIVES_MISSION_KOTH_ATTACKER_WIN_HINT";
    game.strings[ game.attackers + "_mission_loss" ] = &"OBJECTIVES_MISSION_ATTACKER_LOSS_HINT";
    game.strings[ game.defenders + "_mission_win" ] = &"OBJECTIVES_MISSION_KOTH_DEFENDER_WIN_HINT";
    game.strings[ game.defenders + "_mission_loss" ] = &"OBJECTIVES_MISSION_KOTH_DEFENDER_LOSS_HINT";
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0x3980c22e, Offset: 0x2b90
// Size: 0xe4
function toggle_zone_effects( enabled )
{
    if ( enabled )
    {
        level.zonemask |= 1 << self.zone_index;
    }
    else
    {
        level.zonemask &= ~( 1 << self.zone_index );
    }
    
    level.zonestatemask &= ~( 3 << self.zone_index );
    level clientfield::set( "warzone", level.zonemask );
    level clientfield::set( "warzonestate", level.zonestatemask );
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x56e0647f, Offset: 0x2c80
// Size: 0x4a4
function main_loop()
{
    level endon( #"game_ended" );
    
    while ( level.inprematchperiod )
    {
        waitframe( 1 );
    }
    
    thread hide_timer_on_game_end();
    wait 1;
    sound::play_on_players( "mp_suitcase_pickup" );
    
    if ( level.zonespawntime && !( isdefined( level.neutralzone ) && level.neutralzone ) )
    {
        for ( i = 0; i < level.zonecount ; i++ )
        {
            level.zones[ i ].gameobject gameobjects::set_flags( 1 );
        }
        
        update_objective_hint_message( level.objectivehintpreparezone );
        wait level.zonespawntime;
        
        for ( i = 0; i < level.zonecount ; i++ )
        {
            level.zones[ i ].gameobject gameobjects::set_flags( 0 );
        }
    }
    
    waittillframeend();
    
    if ( isdefined( level.neutralzone ) && level.neutralzone )
    {
        update_objective_hint_message( &"MP_CAPTURE_STRONG", &"MP_CAPTURE_STRONG" );
    }
    else
    {
        update_objective_hint_message( &"MP_CAPTURE_STRONG", &"MP_DEFEND_STRONG" );
    }
    
    sound::play_on_players( "mpl_hq_cap_us" );
    thread globallogic::showobjectivenotificationuiforallplayers( &"mission_koth" );
    thread audio_loop();
    thread function_6c811005();
    
    for ( i = 0; i < level.zonecount ; i++ )
    {
        thread capture_loop( level.zones[ i ] );
    }
    
    level.capturedzones = 0;
    
    while ( level.capturedzones < level.zonecount )
    {
        res = level waittill( "zone_captured", "mission_timed_out", "out_of_lives" );
        
        if ( res._notify == "mission_timed_out" )
        {
            var_7764b0c1 = 1;
            break;
        }
        
        if ( res._notify == "out_of_lives" )
        {
            if ( !game.lives[ game.attackers ] )
            {
                level.enddefeatreasontext = game.strings[ game.attackers + "_eliminated" ];
                globallogic_score::giveteamscoreforobjective( game.defenders, 1 );
                level thread globallogic::endgame( game.defenders, game.strings[ game.defenders + "_win" ] );
                return;
            }
            
            level.enddefeatreasontext = game.strings[ game.defenders + "_eliminated" ];
            globallogic_score::giveteamscoreforobjective( game.attackers, 1 );
            level thread globallogic::endgame( game.attackers, game.strings[ game.attackers + "_win" ] );
            return;
        }
    }
    
    if ( !( isdefined( var_7764b0c1 ) && var_7764b0c1 ) )
    {
        level thread globallogic::endgame( game.attackers, game.strings[ game.attackers + "_win" ] );
    }
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x3d5e1006, Offset: 0x3130
// Size: 0xb4
function audio_loop()
{
    level endon( #"game_ended" );
    self notify( #"audio_loop_singleton" );
    self endon( #"audio_loop_singleton" );
    
    while ( true )
    {
        for ( i = 0; i < level.zonecount ; i++ )
        {
            if ( is_zone_contested( level.zones[ i ].gameobject ) )
            {
                sound::play_on_players( "mpl_zone_contested" );
                break;
            }
        }
        
        wait 1;
    }
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0xaea39d61, Offset: 0x31f0
// Size: 0xcc
function function_6c811005()
{
    level endon( #"game_ended" );
    self notify( #"hash_6c811005" );
    self endon( #"hash_6c811005" );
    
    while ( true )
    {
        for ( i = 0; i < level.zonecount ; i++ )
        {
            if ( is_zone_contested( level.zones[ i ].gameobject ) )
            {
                level.zonepauseinfo[ i ] = 1;
                pause_time();
            }
        }
        
        wait 0.1;
    }
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0x534d2568, Offset: 0x32c8
// Size: 0x6ac
function capture_loop( zone )
{
    level endon( #"game_ended" );
    level.warstarttime = gettime();
    zone.gameobject gameobjects::set_flags( 0 );
    zone.gameobject gameobjects::enable_object();
    objective_onentity( zone.gameobject.objectiveid, zone.objectiveanchor );
    zone.gameobject.capturecount = 0;
    zone.gameobject gameobjects::allow_use( "enemy" );
    zone.gameobject gameobjects::set_use_time( level.capturetime );
    zone.gameobject gameobjects::set_use_text( &"MP_CAPTURING_OBJECTIVE" );
    numtouching = zone.gameobject get_num_touching();
    zone.gameobject gameobjects::set_visible_team( "any" );
    zone.gameobject gameobjects::set_model_visibility( 1 );
    zone.gameobject gameobjects::must_maintain_claim( 0 );
    zone.gameobject gameobjects::can_contest_claim( 1 );
    zone.gameobject.decayprogress = 1;
    zone.gameobject gameobjects::set_decay_time( level.capturetime );
    
    if ( isdefined( level.neutralzone ) && level.neutralzone )
    {
        zone.gameobject.onuse = &on_zone_capture_neutral;
    }
    else
    {
        zone.gameobject.onuse = &on_zone_capture;
    }
    
    zone.gameobject.onbeginuse = &on_begin_use;
    zone.gameobject.onenduse = &on_end_use;
    zone.gameobject.ontouchuse = &on_touch_use;
    zone.gameobject.onendtouchuse = &on_end_touch_use;
    zone.gameobject.onresumeuse = &on_touch_use;
    zone.gameobject.stage = 1;
    
    if ( isdefined( level.neutralzone ) && level.neutralzone )
    {
        zone.gameobject.onuseupdate = &on_use_update_neutral;
    }
    else
    {
        zone.gameobject.onuseupdate = &on_use_update;
    }
    
    zone.gameobject.ondecaycomplete = &on_decay_complete;
    zone.gameobject.stage = 1;
    zone toggle_zone_effects( 1 );
    spawn_beacon::addprotectedzone( zone.trig );
    level waittill( "zone_captured" + zone.zone_index, "mission_timed_out" );
    ownerteam = zone.gameobject gameobjects::get_owner_team();
    
    if ( zone.gameobject.capturecount == 1 )
    {
        touchlist = [];
        touchkeys = getarraykeys( zone.gameobject.touchlist[ ownerteam ] );
        
        for ( i = 0; i < touchkeys.size ; i++ )
        {
            touchlist[ touchkeys[ i ] ] = zone.gameobject.touchlist[ ownerteam ][ touchkeys[ i ] ];
        }
        
        thread give_held_credit( touchlist );
    }
    
    zone.gameobject.lastcaptureteam = undefined;
    zone.gameobject gameobjects::disable_object();
    zone.gameobject gameobjects::allow_use( "none" );
    zone.gameobject gameobjects::set_owner_team( "neutral" );
    zone.gameobject gameobjects::set_model_visibility( 0 );
    zone.gameobject gameobjects::must_maintain_claim( 0 );
    zone.gameobject.decayprogress = 1;
    objective_setstate( zone.gameobject.objectiveid, "done" );
    zone toggle_zone_effects( 0 );
    spawn_beacon::removeprotectedzone( zone.trig );
}

// Namespace mission_koth/strong
// Params 0, eflags: 0x4
// Checksum 0x380d5f38, Offset: 0x3980
// Size: 0xa6
function private get_num_touching()
{
    numtouching = 0;
    
    foreach ( team in level.teams )
    {
        numtouching += self.numtouching[ team ];
    }
    
    return numtouching;
}

// Namespace mission_koth/strong
// Params 0, eflags: 0x4
// Checksum 0x5911b21a, Offset: 0x3a30
// Size: 0x4c
function private hide_timer_on_game_end()
{
    level notify( #"hide_timer_on_game_end" );
    level endon( #"hide_timer_on_game_end" );
    level waittill( "game_ended" );
    setmatchflag( "bomb_timer_a", 0 );
}

// Namespace mission_koth/strong
// Params 2, eflags: 0x4
// Checksum 0xc83e32c8, Offset: 0x3a88
// Size: 0xa2
function private give_held_credit( touchlist, team )
{
    wait 0.05;
    util::waittillslowprocessallowed();
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = touchlist[ players[ i ] ].player;
    }
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0xa8106abb, Offset: 0x3b38
// Size: 0x68
function private checkifshouldupdateattackerstatusplayback( player )
{
    if ( player.team != game.attackers )
    {
        return;
    }
    
    if ( !isdefined( self.lastteamtoownzone ) )
    {
        return;
    }
    
    if ( self.lastteamtoownzone == player.team )
    {
        return;
    }
    
    self.needsattackerstatusplayback = 1;
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0x909dfa51, Offset: 0x3ba8
// Size: 0x68
function private checkifshouldupdatedefenderstatusplayback( player )
{
    if ( player.team != game.defenders )
    {
        return;
    }
    
    if ( isdefined( self.lastteamtoownzone ) && self.lastteamtoownzone == player.team )
    {
        return;
    }
    
    self.needsdefenderstatusplayback = 1;
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0x8e8153a7, Offset: 0x3c18
// Size: 0x6c
function private checkifshouldupdatestatusplayback( player )
{
    if ( isdefined( level.neutralzone ) && level.neutralzone )
    {
        self.needsallstatusplayback = 1;
        return;
    }
    
    checkifshouldupdateattackerstatusplayback( player );
    checkifshouldupdatedefenderstatusplayback( player );
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0x940ddfe9, Offset: 0x3c90
// Size: 0x54
function private on_touch_use( player )
{
    player thread player_use_loop( self );
    self checkifshouldupdatestatusplayback( player );
    self update_team_client_field();
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0xc167ab10, Offset: 0x3cf0
// Size: 0x44
function private on_end_touch_use( player )
{
    player notify( "use_stopped" + self.owningzone.zone_index );
    self update_team_client_field();
}

// Namespace mission_koth/strong
// Params 3, eflags: 0x4
// Checksum 0x23391da8, Offset: 0x3d40
// Size: 0x54
function private on_end_use( team, player, success )
{
    player notify( "event_ended" + self.owningzone.zone_index );
    self update_team_client_field();
}

// Namespace mission_koth/strong
// Params 2, eflags: 0x4
// Checksum 0x29c630b8, Offset: 0x3da0
// Size: 0x94
function private play_objective_audio( audiocue, team )
{
    if ( isdefined( level.audiocues[ audiocue ] ) )
    {
        if ( level.audiocues[ audiocue ] + level.audioplaybackthrottle > gettime() )
        {
            return;
        }
    }
    
    level.audiocues[ audiocue ] = gettime();
    thread globallogic_audio::leader_dialog( audiocue, team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer" );
}

// Namespace mission_koth/strong
// Params 2, eflags: 0x4
// Checksum 0x3e510db9, Offset: 0x3e40
// Size: 0x2ea
function private process_zone_capture_audio( zone, capture_team )
{
    foreach ( team in level.teams )
    {
        if ( team == capture_team )
        {
            if ( !( isdefined( level.neutralzone ) && level.neutralzone ) )
            {
                if ( level.nzones > 1 )
                {
                    soundkey = "controlZ" + zone.zone_index + 1 + "TakenOfs";
                }
                else if ( level.nzones == 1 )
                {
                    soundkey = "controlLastZoneOfs";
                }
                else
                {
                    soundkey = "controlAllZonesCapOfs";
                }
                
                play_objective_audio( soundkey, team );
            }
            else if ( self.ownerteam == "neutral" )
            {
                play_objective_audio( "warCapturingOfs", team );
            }
            else
            {
                play_objective_audio( "warCapturedOfs", team );
            }
            
            thread sound::play_on_players( game.objective_gained_sound, team );
            continue;
        }
        
        if ( !( isdefined( level.neutralzone ) && level.neutralzone ) )
        {
            if ( level.nzones > 1 )
            {
                soundkey = "controlZ" + zone.zone_index + 1 + "LostDef";
            }
            else if ( level.nzones == 1 )
            {
                soundkey = "controlLastZoneDef";
            }
            else
            {
                soundkey = "controlAllZonesCapDef";
            }
            
            play_objective_audio( soundkey, team );
        }
        else if ( self.ownerteam == "neutral" )
        {
            play_objective_audio( "warCapturingDef", team );
        }
        else
        {
            play_objective_audio( "warCapturedDef", team );
        }
        
        thread sound::play_on_players( game.objective_lost_sound, team );
    }
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0x60acda15, Offset: 0x4138
// Size: 0x41a
function private on_zone_capture( player )
{
    level.nzones--;
    capture_team = player.pers[ "team" ];
    capturetime = gettime();
    string = &"MP_KOTH_CAPTURED_BY";
    
    if ( !isdefined( self.lastcaptureteam ) || self.lastcaptureteam != capture_team )
    {
        touchlist = [];
        touchkeys = getarraykeys( self.touchlist[ capture_team ] );
        
        for ( i = 0; i < touchkeys.size ; i++ )
        {
            touchlist[ touchkeys[ i ] ] = self.touchlist[ capture_team ][ touchkeys[ i ] ];
        }
        
        thread give_capture_credit( touchlist, string, capturetime, capture_team, self.lastcaptureteam );
    }
    
    level.warcapteam = capture_team;
    level.war_mission_succeeded = 1;
    self gameobjects::set_owner_team( capture_team );
    
    foreach ( team in level.teams )
    {
        if ( team == capture_team )
        {
            for ( index = 0; index < level.players.size ; index++ )
            {
                player = level.players[ index ];
                
                if ( player.pers[ "team" ] == team )
                {
                    if ( player.lastkilltime + 500 > gettime() )
                    {
                        player challenges::killedlastcontester();
                    }
                }
            }
        }
    }
    
    process_zone_capture_audio( self.owningzone, capture_team );
    self.capturecount++;
    self.lastcaptureteam = capture_team;
    self gameobjects::must_maintain_claim( 1 );
    self update_team_client_field();
    player recordgameevent( "hardpoint_captured" );
    level.capturedzones++;
    
    if ( level.capturedzones == 1 && [[ level.gettimelimit ]]() > 0 )
    {
        level.usingextratime = 1;
    }
    
    if ( level.zonecount == level.capturedzones )
    {
        wait 2.5;
        globallogic_score::giveteamscoreforobjective( game.attackers, 1 );
    }
    
    level notify( #"zone_captured" );
    level notify( "zone_captured" + capture_team );
    level notify( "zone_captured" + self.owningzone.zone_index );
    player notify( "event_ended" + self.owningzone.zone_index );
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0xa924e221, Offset: 0x4560
// Size: 0x416
function private on_zone_capture_neutral( player )
{
    capture_team = player.pers[ "team" ];
    capturetime = gettime();
    string = &"MP_KOTH_CAPTURED_BY";
    
    if ( !isdefined( self.lastcaptureteam ) || self.lastcaptureteam != capture_team )
    {
        touchlist = [];
        touchkeys = getarraykeys( self.touchlist[ capture_team ] );
        
        for ( i = 0; i < touchkeys.size ; i++ )
        {
            touchlist[ touchkeys[ i ] ] = self.touchlist[ capture_team ][ touchkeys[ i ] ];
        }
        
        thread give_capture_credit( touchlist, string, capturetime, capture_team, self.lastcaptureteam );
    }
    
    level.warcapteam = capture_team;
    level.war_mission_succeeded = 1;
    
    if ( !( isdefined( level.decaycapturedzones ) && level.decaycapturedzones ) )
    {
        if ( self.ownerteam != capture_team )
        {
            self thread award_capture_points_neutral( capture_team );
            self gameobjects::set_owner_team( capture_team );
        }
    }
    else
    {
        if ( self.ownerteam == "neutral" )
        {
            self gameobjects::set_owner_team( capture_team );
            self thread award_capture_points_neutral( capture_team );
        }
        
        if ( self.ownerteam != capture_team )
        {
            level notify( #"awardcapturepointsrunningneutral" );
            self gameobjects::set_owner_team( "neutral" );
        }
    }
    
    foreach ( team in level.teams )
    {
        if ( team == capture_team )
        {
            for ( index = 0; index < level.players.size ; index++ )
            {
                player = level.players[ index ];
                
                if ( player.pers[ "team" ] == team )
                {
                    if ( player.lastkilltime + 500 > gettime() )
                    {
                        player challenges::killedlastcontester();
                    }
                }
            }
        }
    }
    
    process_zone_capture_audio( self.owningzone, capture_team );
    self.capturecount++;
    self.lastcaptureteam = capture_team;
    self gameobjects::must_maintain_claim( 1 );
    self update_team_client_field();
    player recordgameevent( "hardpoint_captured" );
    player notify( "event_ended" + self.owningzone.zone_index );
}

// Namespace mission_koth/strong
// Params 5, eflags: 0x4
// Checksum 0x8acdd78d, Offset: 0x4980
// Size: 0x296
function private give_capture_credit( touchlist, string, capturetime, capture_team, lastcaptureteam )
{
    wait 0.05;
    util::waittillslowprocessallowed();
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = touchlist[ players[ i ] ].player;
        player update_caps_per_minute( lastcaptureteam );
        
        if ( !is_score_boosting( player ) )
        {
            player challenges::capturedobjective( capturetime, self.trigger );
            
            if ( level.warstarttime + 3000 > capturetime && level.warcapteam == capture_team )
            {
            }
            
            scoreevents::processscoreevent( "war_captured_zone", player );
            player recordgameevent( "capture" );
            level thread popups::displayteammessagetoall( string, player );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ]++;
                player.captures = player.pers[ "captures" ];
            }
            
            if ( level.warstarttime + 500 > capturetime )
            {
                player challenges::immediatecapture();
            }
            
            demo::bookmark( "event", gettime(), player );
            player addplayerstatwithgametype( "CAPTURES", 1 );
            continue;
        }
        
        /#
            player iprintlnbold( "<dev string:x76>" );
        #/
    }
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0x606549d3, Offset: 0x4c20
// Size: 0x5a, Type: bool
function private is_zone_contested( gameobject )
{
    if ( gameobject.touchlist[ game.attackers ].size > 0 && gameobject.touchlist[ game.defenders ].size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0x669a6b3f, Offset: 0x4c88
// Size: 0x130
function award_capture_points_neutral( team )
{
    level endon( #"game_ended" );
    level notify( "awardCapturePointsRunningNeutral" + self.owningzone.zone_index );
    level endon( "awardCapturePointsRunningNeutral" + self.owningzone.zone_index );
    seconds = int( level.mission_bundle.msscoreinterval );
    
    if ( !isdefined( seconds ) )
    {
        seconds = 4;
    }
    
    score = int( level.mission_bundle.msscorevalue );
    
    if ( !isdefined( score ) )
    {
        score = 5;
    }
    
    while ( !level.gameended )
    {
        wait seconds;
        hostmigration::waittillhostmigrationdone();
        globallogic_score::giveteamscoreforobjective( team, score );
    }
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0x8c758974, Offset: 0x4dc0
// Size: 0x206
function award_capture_points( team )
{
    level endon( #"game_ended" );
    level notify( #"awardcapturepointsrunning" );
    level endon( #"awardcapturepointsrunning" );
    seconds = 1;
    score = 1;
    
    while ( !level.gameended )
    {
        wait seconds;
        hostmigration::waittillhostmigrationdone();
        
        if ( !is_zone_contested( self ) )
        {
            if ( level.scoreperplayer )
            {
                score = self.numtouching[ team ];
            }
            
            globallogic_score::giveteamscoreforobjective( team, score );
            level.wartotalsecondsinzone++;
            
            foreach ( player in level.aliveplayers[ team ] )
            {
                if ( !isdefined( player.touchtriggers[ self.entnum ] ) )
                {
                    continue;
                }
                
                if ( isdefined( player.pers[ "objtime" ] ) )
                {
                    player.pers[ "objtime" ]++;
                    player.objtime = player.pers[ "objtime" ];
                }
                
                player addplayerstatwithgametype( "OBJECTIVE_TIME", 1 );
            }
        }
    }
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x5986c808, Offset: 0x4fd0
// Size: 0x140
function kill_while_contesting()
{
    self notify( #"kill_while_contesting" );
    self endon( #"kill_while_contesting" );
    self endon( #"disconnect" );
    killtime = gettime();
    playerteam = self.pers[ "team" ];
    
    if ( !isdefined( self.clearenemycount ) )
    {
        self.clearenemycount = 0;
    }
    
    self.clearenemycount++;
    var_b34f24c5 = level waittill( "zone_captured" + playerteam, "zone_captured", "death" );
    
    if ( var_b34f24c5._notify == "death" || playerteam != self.pers[ "team" ] )
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

// Namespace mission_koth/strong
// Params 0
// Checksum 0xd0c82530, Offset: 0x5118
// Size: 0x1fc
function setup_zone_exclusions()
{
    if ( !isdefined( level.levelwardisable ) )
    {
        return;
    }
    
    foreach ( nullzone in level.levelwardisable )
    {
        mindist = 1410065408;
        foundzone = undefined;
        
        foreach ( zone in level.zones )
        {
            distance = distancesquared( nullzone.origin, zone.origin );
            
            if ( distance < mindist )
            {
                foundzone = zone;
                mindist = distance;
            }
        }
        
        if ( isdefined( foundzone ) && foundzone == self )
        {
            if ( !isdefined( foundzone.gameobject.exclusions ) )
            {
                foundzone.gameobject.exclusions = [];
            }
            
            foundzone.gameobject.exclusions[ foundzone.gameobject.exclusions.size ] = nullzone;
        }
    }
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0x7b821a19, Offset: 0x5320
// Size: 0x3b0
function player_use_loop( gameobject )
{
    self notify( "player_use_loop_singleton" + gameobject.owningzone.zone_index );
    self endon( "player_use_loop_singleton" + gameobject.owningzone.zone_index );
    player = self;
    player endon( "use_stopped" + gameobject.owningzone.zone_index );
    player endon( "event_ended" + gameobject.owningzone.zone_index );
    player endon( #"death" );
    
    if ( !isdefined( player.playerrole ) )
    {
        return;
    }
    
    fast_capture_threshold = 1.5;
    fast_decay_threshold = 1;
    attacker_capture_multiplier = isdefined( player.playerrole.attackercapturemultiplier ) ? player.playerrole.attackercapturemultiplier : 1;
    defend_decay_multiplier = isdefined( player.playerrole.defenddecaymultiplier ) ? player.playerrole.defenddecaymultiplier : 1;
    
    if ( attacker_capture_multiplier <= fast_capture_threshold && defend_decay_multiplier <= fast_decay_threshold )
    {
        return;
    }
    
    while ( true )
    {
        while ( isdefined( gameobject.userate ) && ( !isdefined( gameobject.userate ) || gameobject.userate == 0 ) || gameobject.claimteam == "none" )
        {
            wait 0.2;
        }
        
        any_capture_progress = 0;
        any_decay_progress = 0;
        measure_progress_end_time = level.time + 5000;
        
        while ( level.time < measure_progress_end_time )
        {
            prev_progress = gameobject.curprogress;
            wait 1;
            
            if ( gameobject.curprogress > prev_progress )
            {
                any_capture_progress = 1;
                continue;
            }
            
            if ( gameobject.curprogress < prev_progress )
            {
                any_decay_progress = 1;
            }
        }
        
        if ( isdefined( gameobject.userate ) && gameobject.userate != 0 && gameobject.claimteam != "none" )
        {
            if ( any_capture_progress && player.pers[ "team" ] == game.attackers && attacker_capture_multiplier > fast_capture_threshold )
            {
                scoreevents::processscoreevent( "fast_capture_progress", player );
                continue;
            }
            
            if ( any_decay_progress && defend_decay_multiplier > fast_decay_threshold )
            {
                scoreevents::processscoreevent( "fast_decay_progress", player );
            }
        }
    }
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0x5ca320a8, Offset: 0x56d8
// Size: 0xdc
function private on_begin_use( player )
{
    ownerteam = self gameobjects::get_owner_team();
    
    if ( ownerteam == "neutral" )
    {
        player thread battlechatter::gametype_specific_battle_chatter( "hq_protect", player.pers[ "team" ] );
    }
    else
    {
        player thread battlechatter::gametype_specific_battle_chatter( "hq_attack", player.pers[ "team" ] );
    }
    
    self checkifshouldupdatestatusplayback( player );
    self update_team_client_field();
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0xcb209d6f, Offset: 0x57c0
// Size: 0x9a, Type: bool
function private isuserateelevated( touchlist )
{
    foreach ( touchinfo in touchlist )
    {
        if ( touchinfo.userate > 1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mission_koth/strong
// Params 2, eflags: 0x4
// Checksum 0xfa64bef5, Offset: 0x5868
// Size: 0xb2, Type: bool
function private isplayerinzonewithrole( touchlist, roletype )
{
    foreach ( touchinfo in touchlist )
    {
        if ( touchinfo.player.playerrole.rolename == roletype )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mission_koth/strong
// Params 1, eflags: 0x4
// Checksum 0x447cc0c, Offset: 0x5928
// Size: 0x1b4
function private update_team_userate_clientfield( zone )
{
    if ( is_zone_contested( zone ) )
    {
        clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 0 );
        zone.lastteamtoownzone = "contested";
        return;
    }
    
    if ( zone.touchlist[ game.attackers ].size > 0 )
    {
        if ( isplayerinzonewithrole( zone.touchlist[ game.attackers ], "objective" ) )
        {
            clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 1 );
        }
        
        zone.lastteamtoownzone = game.attackers;
        return;
    }
    
    if ( zone.touchlist[ game.defenders ].size > 0 && zone.curprogress > 0 )
    {
        if ( isplayerinzonewithrole( zone.touchlist[ game.defenders ], "objective" ) )
        {
            clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 2 );
        }
        
        zone.lastteamtoownzone = game.defenders;
        return;
    }
    
    clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 0 );
}

// Namespace mission_koth/strong
// Params 0, eflags: 0x4
// Checksum 0xba202a52, Offset: 0x5ae8
// Size: 0x2cc
function private update_team_client_field()
{
    level.zonestatemask = 0;
    
    for ( zi = 0; zi < level.zonecount ; zi++ )
    {
        gameobj = level.zones[ zi ].gameobject;
        ownerteam = gameobj gameobjects::get_owner_team();
        state = 0;
        flags = 0;
        
        if ( isdefined( level.neutralzone ) && level.neutralzone )
        {
            if ( gameobj.claimteam == "none" || !isdefined( level.teamindex[ gameobj.claimteam ] ) )
            {
                flags = 0;
            }
            else
            {
                flags = level.teamindex[ gameobj.claimteam ];
            }
        }
        else if ( is_zone_contested( gameobj ) )
        {
            state = 3;
        }
        else if ( gameobj.claimteam != "none" && gameobj.numtouching[ gameobj.claimteam ] > 0 )
        {
            if ( gameobj.claimteam == game.attackers )
            {
                state = 2;
                flags = level.teamindex[ gameobj.claimteam ];
            }
            else
            {
                state = 1;
            }
        }
        else if ( gameobj.numtouching[ ownerteam ] )
        {
            if ( ownerteam == game.attackers )
            {
                state = 2;
                flags = 1;
            }
            else
            {
                state = 1;
            }
        }
        
        level.zonestatemask |= state << zi * 2;
        gameobj gameobjects::set_flags( flags );
    }
    
    level clientfield::set( "warzonestate", level.zonestatemask );
    update_team_userate_clientfield( self );
}

// Namespace mission_koth/strong
// Params 1
// Checksum 0xb26814bf, Offset: 0x5dc0
// Size: 0x114
function update_caps_per_minute( lastownerteam )
{
    if ( !isdefined( self.capsperminute ) )
    {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    
    if ( !isdefined( lastownerteam ) || lastownerteam == "neutral" )
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

// Namespace mission_koth/strong
// Params 1
// Checksum 0x53663196, Offset: 0x5ee0
// Size: 0x44, Type: bool
function is_score_boosting( player )
{
    if ( !level.rankedmatch )
    {
        return false;
    }
    
    if ( player.capsperminute > level.playercapturelpm )
    {
        return true;
    }
    
    return false;
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x357a8ee9, Offset: 0x5f30
// Size: 0x34
function on_decay_complete()
{
    clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 0 );
    self gameobjects::set_flags( 0 );
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0xe1bc8c0e, Offset: 0x5f70
// Size: 0xde
function score_capture_progress()
{
    trig = self.owningzone.trig;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( player.team == game.attackers && player istouching( trig ) )
        {
            scoreevents::processscoreevent( "war_capture_progress", player );
        }
    }
}

// Namespace mission_koth/strong
// Params 3
// Checksum 0x24631a36, Offset: 0x6058
// Size: 0x474
function on_use_update( team, progress, change )
{
    if ( isdefined( level.capdecay ) && level.capdecay && !( isdefined( level.neutralzone ) && level.neutralzone ) )
    {
        if ( progress >= 0.666667 )
        {
            if ( self.stage == 2 )
            {
                self.decayprogressmin = int( 0.666667 * self.usetime );
                score_capture_progress();
                self.stage = 3;
            }
        }
        else if ( progress >= 0.333333 )
        {
            if ( self.stage == 1 )
            {
                self.decayprogressmin = int( 0.333333 * self.usetime );
                score_capture_progress();
                self.stage = 2;
            }
        }
    }
    
    if ( !( isdefined( level.neutralzone ) && level.neutralzone ) )
    {
        update_timer( self.owningzone.zone_index, change );
    }
    
    if ( change > 0 && self.currentlyunoccupied )
    {
        level.numzonesoccupied++;
        self.currentlyunoccupied = 0;
    }
    else if ( change == 0 && !self.currentlyunoccupied )
    {
        level.numzonesoccupied--;
        self.currentlyunoccupied = 1;
    }
    
    if ( progress > 0.05 )
    {
        if ( isdefined( self.needsattackerstatusplayback ) && change > 0 && self.needsattackerstatusplayback )
        {
            if ( !( isdefined( level.neutralzone ) && level.neutralzone ) )
            {
                if ( level.numzonesoccupied <= 1 )
                {
                    soundkeyofs = "controlZ" + self.owningzone.zone_index + 1 + "CapturingOfs";
                    soundkeydef = "controlZ" + self.owningzone.zone_index + 1 + "LosingDef";
                    play_objective_audio( soundkeyofs, game.attackers );
                    play_objective_audio( soundkeydef, game.defenders );
                }
                else
                {
                    play_objective_audio( "controlZMCapturingOfs", game.attackers );
                    play_objective_audio( "controlZMLosingDef", game.defenders );
                }
            }
            
            self.needsattackerstatusplayback = 0;
        }
        else if ( isdefined( self.needsdefenderstatusplayback ) && change < 0 && self.needsdefenderstatusplayback )
        {
            play_objective_audio( "warLosingProgressOfs", game.attackers );
            play_objective_audio( "warLosingProgressDef", game.defenders );
            self.needsdefenderstatusplayback = 0;
        }
    }
    
    if ( progress == 0.333333 || isdefined( self.decayprogressmin ) && change == 0 && progress == 0.666667 )
    {
        if ( clientfield::get_world_uimodel( "hudItems.missions.captureMultiplierStatus" ) != 0 )
        {
            clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 0 );
        }
    }
}

// Namespace mission_koth/strong
// Params 3
// Checksum 0x2a83cbd0, Offset: 0x64d8
// Size: 0x190
function on_use_update_neutral( team, progress, change )
{
    if ( progress > 0.05 )
    {
        if ( isdefined( self.needsallstatusplayback ) && self.needsallstatusplayback )
        {
            if ( change > 0 )
            {
                if ( self.ownerteam == "neutral" )
                {
                    play_objective_audio( "warCapturingOfs", team );
                    play_objective_audio( "warCapturingDef", util::getotherteam( team ) );
                    self.needsallstatusplayback = 0;
                }
                else
                {
                    play_objective_audio( "warLosingProgressDef", team );
                    play_objective_audio( "warLosingProgressOfs", util::getotherteam( team ) );
                    self.needsallstatusplayback = 0;
                }
                
                return;
            }
            
            if ( change < 0 )
            {
                play_objective_audio( "warLosingProgressOfs", team );
                play_objective_audio( "warLosingProgressDef", util::getotherteam( team ) );
                self.needsallstatusplayback = 0;
            }
        }
    }
}

// Namespace mission_koth/strong
// Params 0, eflags: 0x4
// Checksum 0x1e77d95, Offset: 0x6670
// Size: 0x7c
function private set_ui_team()
{
    wait 0.05;
    
    if ( isdefined( level.neutralzone ) && ( game.attackers == "allies" || level.neutralzone ) )
    {
        clientfield::set_world_uimodel( "hudItems.war.attackingTeam", 1 );
        return;
    }
    
    clientfield::set_world_uimodel( "hudItems.war.attackingTeam", 2 );
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0x2ef88c6e, Offset: 0x66f8
// Size: 0x54
function pause_time()
{
    if ( level.timepauseswheninzone && !( isdefined( level.timerpaused ) && level.timerpaused ) )
    {
        globallogic_utils::pausetimer();
        level.timerpaused = 1;
    }
}

// Namespace mission_koth/strong
// Params 0
// Checksum 0xdb0fe1c, Offset: 0x6758
// Size: 0x54
function resume_time()
{
    if ( isdefined( level.timerpaused ) && level.timepauseswheninzone && level.timerpaused )
    {
        globallogic_utils::resumetimer();
        level.timerpaused = 0;
    }
}

// Namespace mission_koth/strong
// Params 2
// Checksum 0xa3c09e5d, Offset: 0x67b8
// Size: 0x104
function update_timer( zoneindex, change )
{
    if ( change > 0 || is_zone_contested( level.zones[ zoneindex ].gameobject ) )
    {
        level.zonepauseinfo[ zoneindex ] = 1;
        pause_time();
        return;
    }
    
    level.zonepauseinfo[ zoneindex ] = 0;
    
    for ( zi = 0; zi < level.zonecount ; zi++ )
    {
        if ( isdefined( level.zonepauseinfo[ zi ] ) && level.zonepauseinfo[ zi ] )
        {
            return;
        }
    }
    
    resume_time();
}

