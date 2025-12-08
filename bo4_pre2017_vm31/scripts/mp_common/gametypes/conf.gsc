#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/dogtags;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/spawning;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/util;

#namespace conf;

// Namespace conf/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0xa346a124, Offset: 0x458
// Size: 0x334
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 50000 );
    util::registerroundlimit( 0, 10 );
    util::registerroundswitch( 0, 9 );
    util::registerroundwinlimit( 0, 10 );
    util::registernumlives( 0, 100 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    level.scoreroundwinbased = 1;
    level.teambased = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.determinewinner = &determinewinner;
    level.overrideteamscore = 1;
    level.teamscoreperkill = getgametypesetting( "teamScorePerKill" );
    level.teamscoreperkillconfirmed = getgametypesetting( "teamScorePerKillConfirmed" );
    level.teamscoreperkilldenied = getgametypesetting( "teamScorePerKillDenied" );
    gameobjects::register_allowed_gameobject( level.gametype );
    globallogic_audio::set_leader_gametype_dialog( "startKillConfirmed", "hcCtartKillConfirmed", "gameBoost", "gameBoost" );
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "score", "kills", "killsconfirmed", "killsdenied", "deaths" );
        return;
    }
    
    globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "killsconfirmed", "killsdenied" );
}

// Namespace conf/conf
// Params 0
// Checksum 0x80f724d1, Offset: 0x798
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace conf/conf
// Params 0
// Checksum 0x6dbf0a60, Offset: 0x7a8
// Size: 0x324
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    globallogic_utils::switch_sides();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    
    foreach ( team in level.teams )
    {
        util::setobjectivetext( team, &"OBJECTIVES_CONF" );
        util::setobjectivehinttext( team, &"OBJECTIVES_CONF_HINT" );
        
        if ( level.splitscreen )
        {
            util::setobjectivescoretext( team, &"OBJECTIVES_CONF" );
        }
        else
        {
            util::setobjectivescoretext( team, &"OBJECTIVES_CONF_SCORE" );
        }
        
        spawning::place_spawn_points( spawning::gettdmstartspawnname( team ) );
        spawning::add_spawn_points( team, "mp_tdm_spawn" );
    }
    
    spawning::updateallspawnpoints();
    
    foreach ( team in level.teams )
    {
        spawning::add_start_spawn_points( team, spawning::gettdmstartspawnname( team ) );
    }
    
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    dogtags::init();
    
    if ( !util::isoneround() )
    {
        level.displayroundendtext = 1;
        
        if ( level.scoreroundwinbased )
        {
            globallogic_score::resetteamscores();
        }
    }
}

// Namespace conf/conf
// Params 9
// Checksum 0x80e85d34, Offset: 0xad8
// Size: 0x11c
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    level thread dogtags::spawn_dog_tag( self, attacker, &onuse, 1 );
    
    if ( isdefined( level.killstreaksgivegamescore ) && ( !isdefined( killstreaks::get_killstreak_for_weapon( weapon ) ) || level.killstreaksgivegamescore ) )
    {
        attacker globallogic_score::giveteamscoreforobjective( attacker.team, level.teamscoreperkill );
    }
}

// Namespace conf/conf
// Params 1
// Checksum 0xdd8667b, Offset: 0xc00
// Size: 0x260
function onuse( player )
{
    tacinsertboost = 0;
    
    if ( player.team != self.attackerteam )
    {
        tacinsertboost = self.tacinsert;
        
        if ( isdefined( self.attacker ) && self.attacker.team == self.attackerteam )
        {
            self.attacker luinotifyevent( &"player_callout", 2, &"MP_KILL_DENIED", player.entnum );
        }
        
        if ( !tacinsertboost )
        {
            player globallogic_score::giveteamscoreforobjective( player.team, level.teamscoreperkilldenied );
        }
    }
    else
    {
        /#
            assert( isdefined( player.lastkillconfirmedtime ) );
            assert( isdefined( player.lastkillconfirmedcount ) );
        #/
        
        player.pers[ "killsconfirmed" ]++;
        player.killsconfirmed = player.pers[ "killsconfirmed" ];
        player globallogic_score::giveteamscoreforobjective( player.team, level.teamscoreperkillconfirmed );
    }
    
    if ( !tacinsertboost )
    {
        currenttime = gettime();
        
        if ( player.lastkillconfirmedtime + 1000 > currenttime )
        {
            player.lastkillconfirmedcount++;
            
            if ( player.lastkillconfirmedcount >= 3 )
            {
                scoreevents::processscoreevent( "kill_confirmed_multi", player );
                player.lastkillconfirmedcount = 0;
            }
        }
        else
        {
            player.lastkillconfirmedcount = 1;
        }
        
        player.lastkillconfirmedtime = currenttime;
    }
}

// Namespace conf/conf
// Params 1
// Checksum 0xb611e8ab, Offset: 0xe68
// Size: 0x84
function onspawnplayer( predictedspawn )
{
    self.usingobj = undefined;
    
    if ( level.usestartspawns && !level.ingraceperiod )
    {
        level.usestartspawns = 0;
    }
    
    self.lastkillconfirmedtime = 0;
    self.lastkillconfirmedcount = 0;
    spawning::onspawnplayer( predictedspawn );
    dogtags::on_spawn_player();
}

// Namespace conf/conf
// Params 0
// Checksum 0x340a720f, Offset: 0xef8
// Size: 0x1c
function onroundswitch()
{
    game.switchedsides = !game.switchedsides;
}

// Namespace conf/conf
// Params 0
// Checksum 0x648eb112, Offset: 0xf20
// Size: 0x1a
function determinewinner()
{
    return globallogic::determineteamwinnerbygamestat( "roundswon" );
}

// Namespace conf/conf
// Params 1
// Checksum 0x431796b5, Offset: 0xf48
// Size: 0x22
function onroundendgame( roundwinner )
{
    return globallogic::determineteamwinnerbygamestat( "roundswon" );
}

