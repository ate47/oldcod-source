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

#namespace tdm;

// Namespace tdm/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x82b13534, Offset: 0x428
// Size: 0x2d4
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registerroundswitch( 0, 9 );
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 50000 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registernumlives( 0, 100 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    level.scoreroundwinbased = getgametypesetting( "cumulativeRoundScores" ) == 0;
    level.teamscoreperkill = getgametypesetting( "teamScorePerKill" );
    level.teamscoreperdeath = getgametypesetting( "teamScorePerDeath" );
    level.teamscoreperheadshot = getgametypesetting( "teamScorePerHeadshot" );
    level.killstreaksgivegamescore = getgametypesetting( "killstreaksGiveGameScore" );
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    level.onroundswitch = &onroundswitch;
    level.onplayerkilled = &onplayerkilled;
    gameobjects::register_allowed_gameobject( level.gametype );
    globallogic_audio::set_leader_gametype_dialog( "startTeamDeathmatch", "hcStartTeamDeathmatch", "gameBoost", "gameBoost" );
    globallogic_spawn::addsupportedspawnpointtype( 64 );
    globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "kdratio", "assists" );
}

// Namespace tdm/tdm
// Params 0
// Checksum 0x48d5e617, Offset: 0x708
// Size: 0x38c
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    globallogic_utils::switch_sides();
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
        }
        else
        {
            util::setobjectivescoretext( team, &"OBJECTIVES_TDM_SCORE" );
        }
        
        spawning::add_spawn_points( team, "mp_tdm_spawn" );
        spawning::place_spawn_points( spawning::gettdmstartspawnname( team ) );
    }
    
    spawning::updateallspawnpoints();
    
    foreach ( team in level.teams )
    {
        spawning::add_start_spawn_points( team, spawning::gettdmstartspawnname( team ) );
    }
    
    globallogic_spawn::addspawns();
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

// Namespace tdm/tdm
// Params 1
// Checksum 0xf26c7c8c, Offset: 0xaa0
// Size: 0x6c
function onspawnplayer( predictedspawn )
{
    self.usingobj = undefined;
    
    if ( level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn )
    {
        level.usestartspawns = 0;
    }
    
    spawning::onspawnplayer( predictedspawn );
}

// Namespace tdm/tdm
// Params 1
// Checksum 0xc295fc97, Offset: 0xb18
// Size: 0x4c
function onendgame( winningteam )
{
    if ( isdefined( winningteam ) && isdefined( level.teams[ winningteam ] ) )
    {
        globallogic_score::giveteamscoreforobjective( winningteam, 1 );
    }
}

// Namespace tdm/tdm
// Params 0
// Checksum 0x555d35ea, Offset: 0xb70
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

// Namespace tdm/tdm
// Params 1
// Checksum 0xaebd6a65, Offset: 0xc50
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

// Namespace tdm/tdm
// Params 0
// Checksum 0x41be7f94, Offset: 0xd30
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

// Namespace tdm/tdm
// Params 9
// Checksum 0xf02bb0da, Offset: 0xf10
// Size: 0x224
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
        attacker globallogic_score::giveteamscoreforobjective( attacker.team, level.teamscoreperkill );
        self globallogic_score::giveteamscoreforobjective( self.team, level.teamscoreperdeath * -1 );
        
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            attacker globallogic_score::giveteamscoreforobjective( attacker.team, level.teamscoreperheadshot );
        }
    }
}

