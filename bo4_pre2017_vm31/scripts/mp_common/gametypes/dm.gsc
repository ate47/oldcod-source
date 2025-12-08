#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/util;

#namespace dm;

// Namespace dm/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x93576aba, Offset: 0x370
// Size: 0x254
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 50000 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registernumlives( 0, 100 );
    globallogic::registerfriendlyfiredelay( level.gametype, 0, 0, 1440 );
    level.scoreroundwinbased = getgametypesetting( "cumulativeRoundScores" ) == 0;
    level.teamscoreperkill = getgametypesetting( "teamScorePerKill" );
    level.teamscoreperdeath = getgametypesetting( "teamScorePerDeath" );
    level.teamscoreperheadshot = getgametypesetting( "teamScorePerHeadshot" );
    level.killstreaksgivegamescore = getgametypesetting( "killstreaksGiveGameScore" );
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &onplayerkilled;
    level.onspawnplayer = &onspawnplayer;
    gameobjects::register_allowed_gameobject( level.gametype );
    globallogic_audio::set_leader_gametype_dialog( "startFreeForAll", "hcStartFreeForAll", "gameBoost", "gameBoost" );
    globallogic::setvisiblescoreboardcolumns( "pointstowin", "kills", "deaths", "kdratio", "score" );
}

// Namespace dm/dm
// Params 1
// Checksum 0x94b71645, Offset: 0x5d0
// Size: 0xf0
function setupteam( team )
{
    util::setobjectivetext( team, &"OBJECTIVES_DM" );
    
    if ( level.splitscreen )
    {
        util::setobjectivescoretext( team, &"OBJECTIVES_DM" );
    }
    else
    {
        util::setobjectivescoretext( team, &"OBJECTIVES_DM_SCORE" );
    }
    
    util::setobjectivehinttext( team, &"OBJECTIVES_DM_HINT" );
    spawning::add_spawn_points( team, "mp_dm_spawn" );
    spawning::place_spawn_points( "mp_dm_spawn_start" );
    level.spawn_start = spawning::get_spawnpoint_array( "mp_dm_spawn_start" );
}

// Namespace dm/dm
// Params 0
// Checksum 0x7475746, Offset: 0x6c8
// Size: 0x1d0
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    influencers::create_map_placed_influencers();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    
    foreach ( team in level.teams )
    {
        setupteam( team );
    }
    
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.displayroundendtext = 0;
    level thread onscoreclosemusic();
    
    if ( !util::isoneround() )
    {
        level.displayroundendtext = 1;
    }
}

// Namespace dm/dm
// Params 1
// Checksum 0x57fdd71c, Offset: 0x8a0
// Size: 0x60
function onendgame( winningplayer )
{
    if ( isdefined( winningplayer ) && isplayer( winningplayer ) )
    {
        [[ level._setplayerscore ]]( winningplayer, winningplayer [[ level._getplayerscore ]]() + 1 );
    }
}

// Namespace dm/dm
// Params 0
// Checksum 0x42fb07ea, Offset: 0x908
// Size: 0xc4
function onscoreclosemusic()
{
    while ( !level.gameended )
    {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.9;
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            scorecheck = [[ level._getplayerscore ]]( level.players[ i ] );
            
            if ( scorecheck >= scorethreshold )
            {
                return;
            }
        }
        
        wait 0.5;
    }
}

// Namespace dm/dm
// Params 1
// Checksum 0xdaff5646, Offset: 0x9d8
// Size: 0x3c
function onspawnplayer( predictedspawn )
{
    if ( !level.inprematchperiod )
    {
        level.usestartspawns = 0;
    }
    
    spawning::onspawnplayer( predictedspawn );
}

// Namespace dm/dm
// Params 9
// Checksum 0xd6838f37, Offset: 0xa20
// Size: 0x12c
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( !isplayer( attacker ) || self == attacker )
    {
        return;
    }
    
    if ( isdefined( level.killstreaksgivegamescore ) && ( !isdefined( killstreaks::get_killstreak_for_weapon( weapon ) ) || level.killstreaksgivegamescore ) )
    {
        attacker globallogic_score::givepointstowin( level.teamscoreperkill );
        self globallogic_score::givepointstowin( level.teamscoreperdeath * -1 );
        
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            attacker globallogic_score::givepointstowin( level.teamscoreperheadshot );
        }
    }
}

