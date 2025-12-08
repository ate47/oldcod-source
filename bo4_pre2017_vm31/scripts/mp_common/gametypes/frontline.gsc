#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/dogtags;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_spawn;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/spawning;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/util;

#namespace frontline;

// Namespace frontline/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0xb3ebd918, Offset: 0x5e8
// Size: 0x4dc
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registerroundswitch( 0, 9 );
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 50000 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registernumlives( 0, 100 );
    level.protectedspawnregionsettings = spawnstruct();
    level.protectedspawnregionsettings.allieszone = getent( "protected_spawnzone_allies", "targetname" );
    level.protectedspawnregionsettings.allieszone.team = "allies";
    level.protectedspawnregionsettings.axiszone = getent( "protected_spawnzone_axis", "targetname" );
    level.protectedspawnregionsettings.axiszone.team = "axis";
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    level.scoreroundwinbased = getgametypesetting( "cumulativeRoundScores" ) == 0;
    level.teamscoreperkill = getgametypesetting( "teamScorePerKill" );
    level.teamscoreperdeath = getgametypesetting( "teamScorePerDeath" );
    level.teamscoreperheadshot = getgametypesetting( "teamScorePerHeadshot" );
    level.killstreaksgivegamescore = getgametypesetting( "killstreaksGiveGameScore" );
    level.teamscoreperkillinspawnzone = getgametypesetting( "killPointsInEnemyProtectedZone" );
    level.maxspawnhealthboostprct = getgametypesetting( "spawnHealthBoostPercent" );
    level.removespawnhealthboosttime = getgametypesetting( "spawnHealthBoostTime" );
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    level.onroundswitch = &onroundswitch;
    level.onplayerkilled = &onplayerkilled;
    level.frontlinesettings = spawnstruct();
    level.frontlinesettings.allieszone = getent( "protected_spawnzone_allies", "targetname" );
    level.frontlinesettings.axiszone = getent( "protected_spawnzone_axis", "targetname" );
    gameobjects::register_allowed_gameobject( level.gametype );
    globallogic_audio::set_leader_gametype_dialog( "startTeamDeathmatch", "hcStartTeamDeathmatch", "gameBoost", "gameBoost" );
    globallogic_spawn::addsupportedspawnpointtype( 8192 );
    globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "kdratio", "assists" );
    clientfield::register( "allplayers", "inProtectedZone", 1, 2, "int" );
}

// Namespace frontline/frontline
// Params 0
// Checksum 0x615af787, Offset: 0xad0
// Size: 0xd4
function setupspawns()
{
    spawning::add_spawn_points( "allies", "mp_frontline_allies_spawn" );
    spawning::add_spawn_points( "axis", "mp_frontline_axis_spawn" );
    spawning::add_start_spawn_points( "axis", "mp_frontline_spawn_axis_start" );
    spawning::add_start_spawn_points( "allies", "mp_frontline_spawn_allies_start" );
    spawning::place_spawn_points( "mp_frontline_allies_spawn" );
    spawning::place_spawn_points( "mp_frontline_axis_spawn" );
    spawning::updateallspawnpoints();
    globallogic_spawn::addspawns();
}

// Namespace frontline/frontline
// Params 0
// Checksum 0xd883d862, Offset: 0xbb0
// Size: 0x2ec
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    globallogic_utils::switch_sides();
    level.frontlinesettings.allieszone thread watchprotectedzoneforentry();
    level.frontlinesettings.axiszone thread watchprotectedzoneforentry();
    level.displayroundendtext = 0;
    influencers::create_map_placed_influencers();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    
    foreach ( team in level.teams )
    {
        util::setobjectivetext( team, &"OBJECTIVES_TDM" );
        util::setobjectivehinttext( team, &"OBJECTIVES_TDM_HINT" );
        
        if ( level.splitscreen )
        {
            util::setobjectivescoretext( team, &"OBJECTIVES_TDM" );
            continue;
        }
        
        util::setobjectivescoretext( team, &"OBJECTIVES_TDM_SCORE" );
    }
    
    setupspawns();
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level thread onscoreclosemusic();
    
    if ( !util::isoneround() )
    {
        level.displayroundendtext = 1;
        
        if ( level.scoreroundwinbased )
        {
            globallogic_score::resetteamscores();
        }
    }
    
    if ( isdefined( level.droppedtagrespawn ) && level.droppedtagrespawn )
    {
        level.numlives = 1;
    }
}

// Namespace frontline/frontline
// Params 0
// Checksum 0x6e2595a1, Offset: 0xea8
// Size: 0x5c
function removespawnboost()
{
    normalhealth = self getnormalhealth();
    self setmaxhealth( self.spawnhealth );
    self setnormalhealth( normalhealth );
}

// Namespace frontline/frontline
// Params 0
// Checksum 0x816eae8f, Offset: 0xf10
// Size: 0x7a
function watchforplayertoleavezone()
{
    self endon( #"death" );
    
    while ( self istouchingswept( self.currentspawnprotectionzone ) )
    {
        waitframe( 1 );
    }
    
    self removespawnboost();
    self clientfield::set( "inProtectedZone", 0 );
    self notify( #"left_protection_zone" );
}

// Namespace frontline/frontline
// Params 1
// Checksum 0x662fc3ce, Offset: 0xf98
// Size: 0x68
function watchforplayertoleaveenemyzone( protectedzone )
{
    self endon( #"death" );
    
    while ( self istouchingswept( protectedzone ) )
    {
        waitframe( 1 );
    }
    
    self clientfield::set( "inProtectedZone", 0 );
    self.inenemyprotectedzone = 0;
}

// Namespace frontline/frontline
// Params 0
// Checksum 0xf0d82825, Offset: 0x1008
// Size: 0xe8
function watchprotectedzoneforentry()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitresult = self waittill( "trigger" );
        player = waitresult.activator;
        
        if ( isdefined( player.inenemyprotectedzone ) && player.team != self.team && !player.inenemyprotectedzone )
        {
            player.inenemyprotectedzone = 1;
            player clientfield::set( "inProtectedZone", 2 );
            player thread watchforplayertoleaveenemyzone( self );
        }
    }
}

// Namespace frontline/frontline
// Params 1
// Checksum 0x61cb136, Offset: 0x10f8
// Size: 0x3c
function removehealthaftersettime( timetowait )
{
    self endon( #"left_protection_zone", #"death" );
    wait timetowait;
    self removespawnboost();
}

// Namespace frontline/frontline
// Params 1
// Checksum 0xd715b278, Offset: 0x1140
// Size: 0x104
function onspawnplayer( predictedspawn )
{
    self.usingobj = undefined;
    
    if ( level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn )
    {
        level.usestartspawns = 0;
    }
    
    spawning::onspawnplayer( predictedspawn );
    playerspawnregion = getspawnzoneforteam( self.team );
    self.currentspawnprotectionzone = playerspawnregion;
    self.inenemyprotectedzone = 0;
    self clientfield::set( "inProtectedZone", 1 );
    self thread watchforplayertoleavezone();
    self thread removehealthaftersettime( level.removespawnhealthboosttime );
}

// Namespace frontline/frontline
// Params 1
// Checksum 0x254fa240, Offset: 0x1250
// Size: 0x4c
function onendgame( winningteam )
{
    if ( isdefined( winningteam ) && isdefined( level.teams[ winningteam ] ) )
    {
        globallogic_score::giveteamscoreforobjective( winningteam, 1 );
    }
}

// Namespace frontline/frontline
// Params 0
// Checksum 0x872d3f1e, Offset: 0x12a8
// Size: 0xd2
function onroundswitch()
{
    game.switchedsides = !game.switchedsides;
    
    if ( level.scoreroundwinbased )
    {
        foreach ( team in level.teams )
        {
            [[ level._setteamscore ]]( team, game.stat[ "roundswon" ][ team ] );
        }
    }
}

// Namespace frontline/frontline
// Params 1
// Checksum 0x25f2eff3, Offset: 0x1388
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

// Namespace frontline/frontline
// Params 0
// Checksum 0xb537a5ad, Offset: 0x1468
// Size: 0x1d4
function onscoreclosemusic()
{
    teamscores = [];
    
    while ( !level.gameended )
    {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.1;
        scorethresholdstart = abs( scorelimit - scorethreshold );
        scorelimitcheck = scorelimit - 10;
        topscore = 0;
        runnerupscore = 0;
        
        foreach ( team in level.teams )
        {
            score = [[ level._getteamscore ]]( team );
            
            if ( score > topscore )
            {
                runnerupscore = topscore;
                topscore = score;
                continue;
            }
            
            if ( score > runnerupscore )
            {
                runnerupscore = score;
            }
        }
        
        scoredif = topscore - runnerupscore;
        
        if ( topscore >= scorelimit * 0.5 )
        {
            level notify( #"sndmusichalfway" );
            return;
        }
        
        wait 1;
    }
}

// Namespace frontline/frontline
// Params 1
// Checksum 0x98374d8e, Offset: 0x1648
// Size: 0xcc
function getspawnzoneforteam( team )
{
    returnzone = undefined;
    
    if ( team == "axis" )
    {
        if ( game.switchedsides )
        {
            returnzone = level.protectedspawnregionsettings.allieszone;
        }
        else
        {
            returnzone = level.protectedspawnregionsettings.axiszone;
        }
    }
    else if ( team == "allies" )
    {
        if ( game.switchedsides )
        {
            returnzone = level.protectedspawnregionsettings.axiszone;
        }
        else
        {
            returnzone = level.protectedspawnregionsettings.allieszone;
        }
    }
    
    return returnzone;
}

// Namespace frontline/frontline
// Params 2
// Checksum 0x2769c2c2, Offset: 0x1720
// Size: 0xae, Type: bool
function shouldgivereducedkillpoints( attacker, victim )
{
    victimhomezone = getspawnzoneforteam( victim.team );
    attackerhomezone = getspawnzoneforteam( attacker.team );
    
    if ( victim istouchingswept( victimhomezone ) )
    {
        return true;
    }
    
    if ( attacker istouchingswept( attackerhomezone ) )
    {
        return true;
    }
    
    return false;
}

// Namespace frontline/frontline
// Params 9
// Checksum 0x2afdac87, Offset: 0x17d8
// Size: 0x274
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isdefined( level.droppedtagrespawn ) && level.droppedtagrespawn )
    {
        thread dogtags::checkallowspectating();
        should_spawn_tags = self dogtags::should_spawn_tags( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        
        if ( should_spawn_tags )
        {
            level thread dogtags::spawn_dog_tag( self, attacker, &dogtags::onusedogtag, 0 );
        }
    }
    
    if ( isplayer( attacker ) == 0 || attacker.team == self.team )
    {
        return;
    }
    
    if ( isdefined( level.killstreaksgivegamescore ) && ( !isdefined( killstreaks::get_killstreak_for_weapon( weapon ) ) || level.killstreaksgivegamescore ) )
    {
        killpoints = 0;
        
        if ( shouldgivereducedkillpoints( attacker, self ) )
        {
            killpoints = level.teamscoreperkillinspawnzone;
        }
        else
        {
            killpoints = level.teamscoreperkill;
        }
        
        attacker globallogic_score::giveteamscoreforobjective( attacker.team, killpoints );
        self globallogic_score::giveteamscoreforobjective( self.team, level.teamscoreperdeath * -1 );
        
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            attacker globallogic_score::giveteamscoreforobjective( attacker.team, level.teamscoreperheadshot );
        }
    }
}

