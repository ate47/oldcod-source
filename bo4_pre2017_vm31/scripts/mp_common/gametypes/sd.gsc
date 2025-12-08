#using scripts/core_common/abilities/gadgets/gadget_resurrect;
#using scripts/core_common/demo_shared;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/medals_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/spectating;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/dogtags;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_defaults;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_spawn;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/util;

#namespace sd;

// Namespace sd/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x3fe39678, Offset: 0xc20
// Size: 0x384
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registerroundswitch( 0, 9 );
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 500 );
    util::registerroundlimit( 0, 12 );
    util::registerroundwinlimit( 0, 10 );
    util::registernumlives( 0, 100 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.playerspawnedcb = &sd_playerspawnedcb;
    level.onplayerkilled = &onplayerkilled;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.onroundswitch = &onroundswitch;
    level.getteamkillpenalty = &sd_getteamkillpenalty;
    level.getteamkillscore = &sd_getteamkillscore;
    level.iskillboosting = &sd_iskillboosting;
    level.figure_out_gametype_friendly_fire = &figureoutgametypefriendlyfire;
    level.var_4ec8f819 = 1;
    level.endgameonscorelimit = 0;
    gameobjects::register_allowed_gameobject( level.gametype );
    gameobjects::register_allowed_gameobject( "bombzone" );
    gameobjects::register_allowed_gameobject( "blocker" );
    globallogic_audio::set_leader_gametype_dialog( "startSearchAndDestroy", "hcStartSearchAndDestroy", "objDestroy", "objDefend" );
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "score", "kills", "plants", "defuses", "deaths" );
        return;
    }
    
    globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "plants", "defuses" );
}

// Namespace sd/sd
// Params 0
// Checksum 0xd294e265, Offset: 0xfb0
// Size: 0x2c
function onprecachegametype()
{
    game.bomb_dropped_sound = "fly_bomb_drop_plr";
    game.bomb_recovered_sound = "fly_bomb_pickup_plr";
}

// Namespace sd/sd
// Params 4
// Checksum 0xea94c41e, Offset: 0xfe8
// Size: 0xa6
function sd_getteamkillpenalty( einflictor, attacker, smeansofdeath, weapon )
{
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty( einflictor, attacker, smeansofdeath, weapon );
    
    if ( isdefined( self.isplanting ) && ( isdefined( self.isdefusing ) && self.isdefusing || self.isplanting ) )
    {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    
    return teamkill_penalty;
}

// Namespace sd/sd
// Params 4
// Checksum 0x1cc1ca54, Offset: 0x1098
// Size: 0xb2
function sd_getteamkillscore( einflictor, attacker, smeansofdeath, weapon )
{
    teamkill_score = rank::getscoreinfovalue( "team_kill" );
    
    if ( isdefined( self.isplanting ) && ( isdefined( self.isdefusing ) && self.isdefusing || self.isplanting ) )
    {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    
    return int( teamkill_score );
}

// Namespace sd/sd
// Params 0
// Checksum 0xda403be3, Offset: 0x1158
// Size: 0x120
function onroundswitch()
{
    if ( !isdefined( game.switchedsides ) )
    {
        game.switchedsides = 0;
    }
    
    if ( game.stat[ "teamScores" ][ "allies" ] == level.scorelimit - 1 && game.stat[ "teamScores" ][ "axis" ] == level.scorelimit - 1 )
    {
        aheadteam = getbetterteam();
        
        if ( aheadteam != game.defenders )
        {
            game.switchedsides = !game.switchedsides;
        }
        
        level.halftimetype = "overtime";
        return;
    }
    
    level.halftimetype = "halftime";
    game.switchedsides = !game.switchedsides;
}

// Namespace sd/sd
// Params 0
// Checksum 0xb9af80c4, Offset: 0x1280
// Size: 0x212
function getbetterteam()
{
    kills[ "allies" ] = 0;
    kills[ "axis" ] = 0;
    deaths[ "allies" ] = 0;
    deaths[ "axis" ] = 0;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        team = player.pers[ "team" ];
        
        if ( team == "allies" || isdefined( team ) && team == "axis" )
        {
            kills[ team ] += player.kills;
            deaths[ team ] += player.deaths;
        }
    }
    
    if ( kills[ "allies" ] > kills[ "axis" ] )
    {
        return "allies";
    }
    else if ( kills[ "axis" ] > kills[ "allies" ] )
    {
        return "axis";
    }
    
    if ( deaths[ "allies" ] < deaths[ "axis" ] )
    {
        return "allies";
    }
    else if ( deaths[ "axis" ] < deaths[ "allies" ] )
    {
        return "axis";
    }
    
    if ( randomint( 2 ) == 0 )
    {
        return "allies";
    }
    
    return "axis";
}

// Namespace sd/sd
// Params 0
// Checksum 0x64e7c9aa, Offset: 0x14a0
// Size: 0x394
function onstartgametype()
{
    setbombtimer( "A", 0 );
    setmatchflag( "bomb_timer_a", 0 );
    setbombtimer( "B", 0 );
    setmatchflag( "bomb_timer_b", 0 );
    globallogic_utils::switch_sides();
    setclientnamemode( "manual_change" );
    game.strings[ "target_destroyed" ] = &"MP_TARGET_DESTROYED";
    game.strings[ "bomb_defused" ] = &"MP_BOMB_DEFUSED";
    level._effect[ "bombexplosion" ] = "explosions/fx_exp_bomb_demo_mp";
    util::setobjectivetext( game.attackers, &"OBJECTIVES_SD_ATTACKER" );
    util::setobjectivetext( game.defenders, &"OBJECTIVES_SD_DEFENDER" );
    
    if ( level.splitscreen )
    {
        util::setobjectivescoretext( game.attackers, &"OBJECTIVES_SD_ATTACKER" );
        util::setobjectivescoretext( game.defenders, &"OBJECTIVES_SD_DEFENDER" );
    }
    else
    {
        util::setobjectivescoretext( game.attackers, &"OBJECTIVES_SD_ATTACKER_SCORE" );
        util::setobjectivescoretext( game.defenders, &"OBJECTIVES_SD_DEFENDER_SCORE" );
    }
    
    util::setobjectivehinttext( game.attackers, &"OBJECTIVES_SD_ATTACKER_HINT" );
    util::setobjectivehinttext( game.defenders, &"OBJECTIVES_SD_DEFENDER_HINT" );
    level.alwaysusestartspawns = 1;
    influencers::create_map_placed_influencers();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    spawning::place_spawn_points( "mp_sd_spawn_attacker" );
    spawning::place_spawn_points( "mp_sd_spawn_defender" );
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    spawning::add_start_spawn_points( "axis", "mp_sd_spawn_defender" );
    spawning::add_start_spawn_points( "allies", "mp_sd_spawn_attacker" );
    thread updategametypedvars();
    thread bombs();
}

// Namespace sd/sd
// Params 1
// Checksum 0x47a492ba, Offset: 0x1840
// Size: 0x44
function onspawnplayer( predictedspawn )
{
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    spawning::onspawnplayer( predictedspawn );
}

// Namespace sd/sd
// Params 0
// Checksum 0x17ef3011, Offset: 0x1890
// Size: 0x14
function sd_playerspawnedcb()
{
    level notify( #"spawned_player" );
}

// Namespace sd/sd
// Params 9
// Checksum 0x9bd6f1a3, Offset: 0x18b0
// Size: 0x4f4
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    thread checkallowspectating();
    
    if ( isdefined( level.droppedtagrespawn ) && level.droppedtagrespawn )
    {
        should_spawn_tags = self dogtags::should_spawn_tags( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        
        if ( should_spawn_tags )
        {
            level thread dogtags::spawn_dog_tag( self, attacker, &dogtags::onusedogtag, 0 );
        }
    }
    
    if ( isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] )
    {
        scoreevents::processscoreevent( "kill_sd", attacker, self, weapon );
    }
    
    inbombzone = 0;
    
    for ( index = 0; index < level.bombzones.size ; index++ )
    {
        dist = distance2dsquared( self.origin, level.bombzones[ index ].curorigin );
        
        if ( dist < level.defaultoffenseradiussq )
        {
            inbombzone = 1;
            currentobjective = level.bombzones[ index ];
            break;
        }
    }
    
    if ( inbombzone && isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] )
    {
        if ( game.defenders == self.pers[ "team" ] )
        {
            attacker medals::offenseglobalcount();
            attacker thread challenges::killedbasedefender( currentobjective );
            self recordkillmodifier( "defending" );
            scoreevents::processscoreevent( "killed_defender", attacker, self, weapon );
        }
        else
        {
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ]++;
                attacker.defends = attacker.pers[ "defends" ];
            }
            
            attacker medals::defenseglobalcount();
            attacker thread challenges::killedbaseoffender( currentobjective, weapon );
            self recordkillmodifier( "assaulting" );
            scoreevents::processscoreevent( "killed_attacker", attacker, self, weapon );
        }
    }
    
    if ( isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] && isdefined( self.isbombcarrier ) && self.isbombcarrier == 1 )
    {
        self recordkillmodifier( "carrying" );
        attacker recordgameevent( "kill_carrier" );
    }
    
    if ( self.isplanting == 1 )
    {
        self recordkillmodifier( "planting" );
    }
    
    if ( self.isdefusing == 1 )
    {
        self recordkillmodifier( "defusing" );
    }
}

// Namespace sd/sd
// Params 0
// Checksum 0xc9ef87b0, Offset: 0x1db0
// Size: 0x12c
function checkallowspectating()
{
    self endon( #"disconnect" );
    waitframe( 1 );
    update = 0;
    livesleft = !( level.numlives && !self.pers[ "lives" ] );
    
    if ( !level.alivecount[ game.attackers ] && !livesleft )
    {
        level.spectateoverride[ game.attackers ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( !level.alivecount[ game.defenders ] && !livesleft )
    {
        level.spectateoverride[ game.defenders ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( update )
    {
        spectating::update_settings();
    }
}

// Namespace sd/sd
// Params 2
// Checksum 0xd9631816, Offset: 0x1ee8
// Size: 0x54
function sd_endgame( winningteam, endreasontext )
{
    if ( isdefined( winningteam ) )
    {
        globallogic_score::giveteamscoreforobjective_delaypostprocessing( winningteam, 1 );
    }
    
    thread globallogic::endgame( winningteam, endreasontext );
}

// Namespace sd/sd
// Params 2
// Checksum 0x42bc6b95, Offset: 0x1f48
// Size: 0x2c
function function_71bf3665( winningteam, endreasontext )
{
    sd_endgame( winningteam, endreasontext );
}

// Namespace sd/sd
// Params 1
// Checksum 0xd7ca93ff, Offset: 0x1f80
// Size: 0x184
function ondeadevent( team )
{
    if ( level.bombexploded || level.bombdefused )
    {
        return;
    }
    
    if ( team == "all" )
    {
        if ( level.bombplanted )
        {
            function_71bf3665( game.attackers, game.strings[ game.defenders + "_eliminated" ] );
        }
        else
        {
            function_71bf3665( game.defenders, game.strings[ game.attackers + "_eliminated" ] );
        }
        
        return;
    }
    
    if ( team == game.attackers )
    {
        if ( level.bombplanted )
        {
            return;
        }
        
        function_71bf3665( game.defenders, game.strings[ game.attackers + "_eliminated" ] );
        return;
    }
    
    if ( team == game.defenders )
    {
        function_71bf3665( game.attackers, game.strings[ game.defenders + "_eliminated" ] );
    }
}

// Namespace sd/sd
// Params 1
// Checksum 0xa3d3b3df, Offset: 0x2110
// Size: 0x44
function ononeleftevent( team )
{
    if ( level.bombexploded || level.bombdefused )
    {
        return;
    }
    
    warnlastplayer( team );
}

// Namespace sd/sd
// Params 0
// Checksum 0x6f44de26, Offset: 0x2160
// Size: 0x74
function ontimelimit()
{
    if ( level.teambased )
    {
        sd_endgame( game.defenders, game.strings[ "time_limit_reached" ] );
        return;
    }
    
    sd_endgame( undefined, game.strings[ "time_limit_reached" ] );
}

// Namespace sd/sd
// Params 1
// Checksum 0x1099c05f, Offset: 0x21e0
// Size: 0x174
function warnlastplayer( team )
{
    if ( !isdefined( level.warnedlastplayer ) )
    {
        level.warnedlastplayer = [];
    }
    
    if ( isdefined( level.warnedlastplayer[ team ] ) )
    {
        return;
    }
    
    level.warnedlastplayer[ team ] = 1;
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team && isdefined( player.pers[ "class" ] ) )
        {
            if ( player.sessionstate == "playing" && !player.afk )
            {
                break;
            }
        }
    }
    
    if ( i == players.size )
    {
        return;
    }
    
    players[ i ] thread givelastattackerwarning( team );
}

// Namespace sd/sd
// Params 1
// Checksum 0x81fce5e9, Offset: 0x2360
// Size: 0x164
function givelastattackerwarning( team )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    fullhealthtime = 0;
    interval = 0.05;
    self.lastmansd = 1;
    enemyteam = game.defenders;
    
    if ( team == enemyteam )
    {
        enemyteam = game.attackers;
    }
    
    if ( level.alivecount[ enemyteam ] > 2 )
    {
        self.lastmansddefeat3enemies = 1;
    }
    
    while ( true )
    {
        if ( self.health != self.maxhealth )
        {
            fullhealthtime = 0;
        }
        else
        {
            fullhealthtime += interval;
        }
        
        wait interval;
        
        if ( self.health == self.maxhealth && fullhealthtime >= 3 )
        {
            break;
        }
    }
    
    self globallogic_audio::leader_dialog_on_player( "roundEncourageLastPlayer" );
    self playlocalsound( "mus_last_stand" );
}

// Namespace sd/sd
// Params 0
// Checksum 0xc759476f, Offset: 0x24d0
// Size: 0x140
function updategametypedvars()
{
    level.planttime = getgametypesetting( "plantTime" );
    level.defusetime = getgametypesetting( "defuseTime" );
    level.bombtimer = getgametypesetting( "bombTimer" );
    level.multibomb = getgametypesetting( "multiBomb" );
    level.teamkillpenaltymultiplier = getgametypesetting( "teamKillPenalty" );
    level.teamkillscoremultiplier = getgametypesetting( "teamKillScore" );
    level.playerkillsmax = getgametypesetting( "playerKillsMax" );
    level.totalkillsmax = getgametypesetting( "totalKillsMax" );
}

// Namespace sd/sd
// Params 0
// Checksum 0x70a2b655, Offset: 0x2618
// Size: 0x8b6
function bombs()
{
    level.bombplanted = 0;
    level.bombdefused = 0;
    level.bombexploded = 0;
    trigger = getent( "sd_bomb_pickup_trig", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        /#
            util::error( "<dev string:x28>" );
        #/
        
        return;
    }
    
    visuals[ 0 ] = getent( "sd_bomb", "targetname" );
    
    if ( !isdefined( visuals[ 0 ] ) )
    {
        /#
            util::error( "<dev string:x55>" );
        #/
        
        return;
    }
    
    if ( !level.multibomb )
    {
        level.sdbomb = gameobjects::create_carry_object( game.attackers, trigger, visuals, ( 0, 0, 32 ), &"sd_bomb" );
        level.sdbomb gameobjects::allow_carry( "friendly" );
        level.sdbomb gameobjects::set_visible_team( "friendly" );
        level.sdbomb gameobjects::set_carry_icon( "hud_suitcase_bomb" );
        level.sdbomb gameobjects::set_use_time( 0 );
        level.sdbomb.allowweapons = 1;
        level.sdbomb.onpickup = &onpickup;
        level.sdbomb.ondrop = &ondrop;
        
        foreach ( visual in level.sdbomb.visuals )
        {
            visual.team = "free";
        }
    }
    else
    {
        trigger delete();
        visuals[ 0 ] delete();
    }
    
    level.bombzones = [];
    bombzones = getentarray( "bombzone", "targetname" );
    
    for ( index = 0; index < bombzones.size ; index++ )
    {
        trigger = bombzones[ index ];
        visuals = getentarray( bombzones[ index ].target, "targetname" );
        name = istring( "sd" + trigger.script_label );
        bombzone = gameobjects::create_use_object( game.defenders, trigger, visuals, ( 0, 0, 0 ), name, 1, 1 );
        bombzone gameobjects::allow_use( "enemy" );
        bombzone gameobjects::set_use_time( level.planttime );
        bombzone gameobjects::set_use_text( &"MP_PLANTING_EXPLOSIVE" );
        bombzone gameobjects::set_use_hint_text( &"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES" );
        
        if ( !level.multibomb )
        {
            bombzone gameobjects::set_key_object( level.sdbomb );
        }
        
        label = bombzone gameobjects::get_label();
        bombzone.label = label;
        bombzone gameobjects::set_visible_team( "any" );
        bombzone.onbeginuse = &onbeginuse;
        bombzone.onenduse = &onenduse;
        bombzone.onuse = &onuseplantobject;
        bombzone.oncantuse = &oncantuse;
        bombzone.useweapon = getweapon( "briefcase_bomb" );
        bombzone.visuals[ 0 ].killcament = spawn( "script_model", bombzone.visuals[ 0 ].origin + ( 0, 0, 128 ) );
        
        if ( isdefined( level.bomb_zone_fixup ) )
        {
            [[ level.bomb_zone_fixup ]]( bombzone );
        }
        
        if ( !level.multibomb )
        {
            bombzone.trigger setinvisibletoall();
        }
        
        for ( i = 0; i < visuals.size ; i++ )
        {
            if ( isdefined( visuals[ i ].script_exploder ) )
            {
                bombzone.exploderindex = visuals[ i ].script_exploder;
                break;
            }
        }
        
        foreach ( visual in bombzone.visuals )
        {
            visual.team = "free";
        }
        
        level.bombzones[ level.bombzones.size ] = bombzone;
        bombzone.bombdefusetrig = getent( visuals[ 0 ].target, "targetname" );
        assert( isdefined( bombzone.bombdefusetrig ) );
        bombzone.bombdefusetrig.origin += ( 0, 0, -10000 );
        bombzone.bombdefusetrig.label = label;
    }
    
    for ( index = 0; index < level.bombzones.size ; index++ )
    {
        array = [];
        
        for ( otherindex = 0; otherindex < level.bombzones.size ; otherindex++ )
        {
            if ( otherindex != index )
            {
                array[ array.size ] = level.bombzones[ otherindex ];
            }
        }
        
        level.bombzones[ index ].otherbombzones = array;
    }
}

// Namespace sd/sd
// Params 3
// Checksum 0xe6608392, Offset: 0x2ed8
// Size: 0xac
function setbomboverheatingafterweaponchange( useobject, overheated, heat )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    waitresult = self waittill( "weapon_change" );
    
    if ( waitresult.weapon == useobject.useweapon )
    {
        self setweaponoverheating( overheated, heat, waitresult.weapon );
    }
}

// Namespace sd/sd
// Params 1
// Checksum 0x9fbcd563, Offset: 0x2f90
// Size: 0x1cc
function onbeginuse( player )
{
    if ( self gameobjects::is_friendly_team( player.pers[ "team" ] ) )
    {
        player playsound( "mpl_sd_bomb_defuse" );
        player.isdefusing = 1;
        player thread setbomboverheatingafterweaponchange( self, 0, 0 );
        player thread battlechatter::gametype_specific_battle_chatter( "sd_enemyplant", player.pers[ "team" ] );
        
        if ( isdefined( level.sdbombmodel ) )
        {
            level.sdbombmodel hide();
        }
    }
    else
    {
        player.isplanting = 1;
        player thread setbomboverheatingafterweaponchange( self, 0, 0 );
        player thread battlechatter::gametype_specific_battle_chatter( "sd_friendlyplant", player.pers[ "team" ] );
        
        if ( level.multibomb )
        {
            for ( i = 0; i < self.otherbombzones.size ; i++ )
            {
                self.otherbombzones[ i ] gameobjects::disable_object();
            }
        }
    }
    
    player playsound( "fly_bomb_raise_plr" );
}

// Namespace sd/sd
// Params 3
// Checksum 0xd242375d, Offset: 0x3168
// Size: 0x12e
function onenduse( team, player, result )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.isdefusing = 0;
    player.isplanting = 0;
    player notify( #"event_ended" );
    
    if ( self gameobjects::is_friendly_team( player.pers[ "team" ] ) )
    {
        if ( isdefined( level.sdbombmodel ) && !result )
        {
            level.sdbombmodel show();
        }
        
        return;
    }
    
    if ( level.multibomb && !result )
    {
        for ( i = 0; i < self.otherbombzones.size ; i++ )
        {
            self.otherbombzones[ i ] gameobjects::enable_object();
        }
    }
}

// Namespace sd/sd
// Params 1
// Checksum 0x2fb12c42, Offset: 0x32a0
// Size: 0x2c
function oncantuse( player )
{
    player iprintlnbold( &"MP_CANT_PLANT_WITHOUT_BOMB" );
}

// Namespace sd/sd
// Params 1
// Checksum 0x2587f58a, Offset: 0x32d8
// Size: 0x28c
function onuseplantobject( player )
{
    if ( !self gameobjects::is_friendly_team( player.pers[ "team" ] ) )
    {
        self gameobjects::set_flags( 1 );
        level thread bombplanted( self, player );
        
        /#
            print( "<dev string:x7b>" + self.label );
        #/
        
        for ( index = 0; index < level.bombzones.size ; index++ )
        {
            if ( level.bombzones[ index ] == self )
            {
                level.bombzones[ index ].isplanted = 1;
                continue;
            }
            
            level.bombzones[ index ] gameobjects::disable_object();
        }
        
        thread sound::play_on_players( "mus_sd_planted" + "_" + level.teampostfix[ player.pers[ "team" ] ] );
        player notify( #"bomb_planted" );
        level thread popups::displayteammessagetoall( &"MP_EXPLOSIVES_PLANTED_BY", player );
        
        if ( isdefined( player.pers[ "plants" ] ) )
        {
            player.pers[ "plants" ]++;
            player.plants = player.pers[ "plants" ];
        }
        
        demo::bookmark( "event", gettime(), player );
        player addplayerstatwithgametype( "PLANTS", 1 );
        globallogic_audio::leader_dialog( "bombPlanted" );
        scoreevents::processscoreevent( "planted_bomb", player );
        player recordgameevent( "plant" );
    }
}

// Namespace sd/sd
// Params 1
// Checksum 0xba4ce4b0, Offset: 0x3570
// Size: 0x2c4
function onusedefuseobject( player )
{
    self gameobjects::set_flags( 0 );
    player notify( #"bomb_defused" );
    
    /#
        print( "<dev string:x8a>" + self.label );
    #/
    
    bbprint( "mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "sd_bombdefuse", self.label, player.pers[ "team" ], player.origin );
    level thread bombdefused( self, player );
    self gameobjects::disable_object();
    
    for ( index = 0; index < level.bombzones.size ; index++ )
    {
        level.bombzones[ index ].isplanted = 0;
    }
    
    level thread popups::displayteammessagetoall( &"MP_EXPLOSIVES_DEFUSED_BY", player );
    
    if ( isdefined( player.pers[ "defuses" ] ) )
    {
        player.pers[ "defuses" ]++;
        player.defuses = player.pers[ "defuses" ];
    }
    
    player addplayerstatwithgametype( "DEFUSES", 1 );
    demo::bookmark( "event", gettime(), player );
    globallogic_audio::leader_dialog( "bombDefused" );
    
    if ( player.lastmansd === 1 && level.alivecount[ game.attackers ] > 0 )
    {
        scoreevents::processscoreevent( "defused_bomb_last_man_alive", player );
        player addplayerstat( "defused_bomb_last_man_alive", 1 );
    }
    else
    {
        scoreevents::processscoreevent( "defused_bomb", player );
    }
    
    player recordgameevent( "defuse" );
}

// Namespace sd/sd
// Params 1
// Checksum 0xe15138ea, Offset: 0x3840
// Size: 0x108
function ondrop( player )
{
    if ( !level.bombplanted )
    {
        globallogic_audio::leader_dialog( "bombFriendlyDropped", game.attackers );
        
        /#
            if ( isdefined( player ) )
            {
                print( "<dev string:x99>" );
            }
            else
            {
                print( "<dev string:x99>" );
            }
        #/
    }
    
    player notify( #"event_ended" );
    self gameobjects::set_3d_icon( "friendly", "waypoint_bomb" );
    sound::play_on_players( game.bomb_dropped_sound, game.attackers );
    
    if ( isdefined( level.bombdropbotevent ) )
    {
        [[ level.bombdropbotevent ]]();
    }
}

// Namespace sd/sd
// Params 1
// Checksum 0x71bb5510, Offset: 0x3950
// Size: 0x20c
function onpickup( player )
{
    player.isbombcarrier = 1;
    player recordgameevent( "pickup" );
    self gameobjects::set_3d_icon( "friendly", "waypoint_defend" );
    
    if ( !level.bombdefused )
    {
        if ( isdefined( player ) && isdefined( player.name ) )
        {
            player addplayerstatwithgametype( "PICKUPS", 1 );
        }
        
        team = self gameobjects::get_owner_team();
        otherteam = util::getotherteam( team );
        globallogic_audio::leader_dialog( "bombFriendlyTaken", game.attackers );
        
        /#
            print( "<dev string:xa6>" );
        #/
    }
    
    player playsound( "fly_bomb_pickup_plr" );
    
    for ( i = 0; i < level.bombzones.size ; i++ )
    {
        level.bombzones[ i ].trigger setinvisibletoall();
        level.bombzones[ i ].trigger setvisibletoplayer( player );
    }
    
    if ( isdefined( level.bombpickupbotevent ) )
    {
        [[ level.bombpickupbotevent ]]();
    }
}

// Namespace sd/sd
// Params 0
// Checksum 0x80f724d1, Offset: 0x3b68
// Size: 0x4
function onreset()
{
    
}

// Namespace sd/sd
// Params 0
// Checksum 0x9fab8aa6, Offset: 0x3b78
// Size: 0xa4
function bombplantedmusicdelay()
{
    level endon( #"bomb_defused" );
    time = level.bombtimer - 30;
    
    /#
        if ( getdvarint( "<dev string:xb1>" ) > 0 )
        {
            println( "<dev string:xbd>" + time );
        }
    #/
    
    if ( time > 1 )
    {
        wait time;
        thread globallogic_audio::set_music_on_team( "timeOutQuiet" );
    }
}

// Namespace sd/sd
// Params 2
// Checksum 0x6ff387be, Offset: 0x3c28
// Size: 0xc84
function bombplanted( destroyedobj, player )
{
    globallogic_utils::pausetimer();
    level.bombplanted = 1;
    player setweaponoverheating( 1, 100, destroyedobj.useweapon );
    team = player.pers[ "team" ];
    destroyedobj.visuals[ 0 ] thread globallogic_utils::playtickingsound( "mpl_sab_ui_suitcasebomb_timer" );
    level thread bombplantedmusicdelay();
    level.tickingobject = destroyedobj.visuals[ 0 ];
    level.timelimitoverride = 1;
    setgameendtime( int( gettime() + level.bombtimer * 1000 ) );
    label = destroyedobj gameobjects::get_label();
    setmatchflag( "bomb_timer" + label, 1 );
    
    if ( label == "_a" )
    {
        setbombtimer( "A", int( gettime() + level.bombtimer * 1000 ) );
        setmatchflag( "bomb_timer_a", 1 );
    }
    else
    {
        setbombtimer( "B", int( gettime() + level.bombtimer * 1000 ) );
        setmatchflag( "bomb_timer_b", 1 );
    }
    
    bbprint( "mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "sd_bombplant", label, team, player.origin );
    
    if ( !level.multibomb )
    {
        level.sdbomb gameobjects::allow_carry( "none" );
        level.sdbomb gameobjects::set_visible_team( "none" );
        level.sdbomb gameobjects::set_dropped();
        level.sdbombmodel = level.sdbomb.visuals[ 0 ];
    }
    else
    {
        for ( index = 0; index < level.players.size ; index++ )
        {
            if ( isdefined( level.players[ index ].carryicon ) )
            {
                level.players[ index ].carryicon hud::destroyelem();
            }
        }
        
        trace = bullettrace( player.origin + ( 0, 0, 20 ), player.origin - ( 0, 0, 2000 ), 0, player );
        tempangle = randomfloat( 360 );
        forward = ( cos( tempangle ), sin( tempangle ), 0 );
        forward = vectornormalize( forward - vectorscale( trace[ "normal" ], vectordot( forward, trace[ "normal" ] ) ) );
        dropangles = vectortoangles( forward );
        level.sdbombmodel = spawn( "script_model", trace[ "position" ] );
        level.sdbombmodel.angles = dropangles;
        level.sdbombmodel setmodel( "p7_mp_suitcase_bomb" );
    }
    
    destroyedobj gameobjects::allow_use( "none" );
    destroyedobj gameobjects::set_visible_team( "none" );
    label = destroyedobj gameobjects::get_label();
    trigger = destroyedobj.bombdefusetrig;
    trigger.origin = level.sdbombmodel.origin;
    visuals = [];
    defuseobject = gameobjects::create_use_object( game.defenders, trigger, visuals, ( 0, 0, 32 ), istring( "sd_defuse" + label ), 1, 1 );
    defuseobject gameobjects::allow_use( "friendly" );
    defuseobject gameobjects::set_use_time( level.defusetime );
    defuseobject gameobjects::set_use_text( &"MP_DEFUSING_EXPLOSIVE" );
    defuseobject gameobjects::set_use_hint_text( &"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES" );
    defuseobject gameobjects::set_visible_team( "any" );
    defuseobject gameobjects::set_flags( 1 );
    defuseobject.label = label;
    defuseobject.onbeginuse = &onbeginuse;
    defuseobject.onenduse = &onenduse;
    defuseobject.onuse = &onusedefuseobject;
    defuseobject.useweapon = getweapon( "briefcase_bomb_defuse" );
    player.isbombcarrier = 0;
    player playbombplant();
    bombtimerwait();
    setbombtimer( "A", 0 );
    setbombtimer( "B", 0 );
    setmatchflag( "bomb_timer_a", 0 );
    setmatchflag( "bomb_timer_b", 0 );
    destroyedobj.visuals[ 0 ] globallogic_utils::stoptickingsound();
    
    if ( level.gameended || level.bombdefused )
    {
        return;
    }
    
    level.bombexploded = 1;
    origin = ( 0, 0, 0 );
    
    if ( isdefined( player ) )
    {
        origin = player.origin;
    }
    
    bbprint( "mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "sd_bombexplode", label, team, origin );
    explosionorigin = level.sdbombmodel.origin + ( 0, 0, 12 );
    level.sdbombmodel hide();
    
    if ( isdefined( player ) )
    {
        destroyedobj.visuals[ 0 ] radiusdamage( explosionorigin, 512, 200, 20, player, "MOD_EXPLOSIVE", getweapon( "briefcase_bomb" ) );
        level thread popups::displayteammessagetoall( &"MP_EXPLOSIVES_BLOWUP_BY", player );
        scoreevents::processscoreevent( "bomb_detonated", player );
        player addplayerstatwithgametype( "DESTRUCTIONS", 1 );
        player addplayerstatwithgametype( "captures", 1 );
        player recordgameevent( "destroy" );
    }
    else
    {
        destroyedobj.visuals[ 0 ] radiusdamage( explosionorigin, 512, 200, 20, undefined, "MOD_EXPLOSIVE", getweapon( "briefcase_bomb" ) );
    }
    
    rot = randomfloat( 360 );
    explosioneffect = spawnfx( level._effect[ "bombexplosion" ], explosionorigin + ( 0, 0, 50 ), ( 0, 0, 1 ), ( cos( rot ), sin( rot ), 0 ) );
    triggerfx( explosioneffect );
    thread sound::play_in_space( "mpl_sd_exp_suitcase_bomb_main", explosionorigin );
    
    if ( isdefined( destroyedobj.exploderindex ) )
    {
        exploder::exploder( destroyedobj.exploderindex );
    }
    
    defuseobject gameobjects::destroy_object();
    
    foreach ( zone in level.bombzones )
    {
        zone gameobjects::disable_object();
    }
    
    setgameendtime( 0 );
    wait 3;
    sd_endgame( game.attackers, game.strings[ "target_destroyed" ] );
}

// Namespace sd/sd
// Params 0
// Checksum 0xf50e3137, Offset: 0x48b8
// Size: 0x3c
function bombtimerwait()
{
    level endon( #"game_ended" );
    level endon( #"bomb_defused" );
    hostmigration::waitlongdurationwithgameendtimeupdate( level.bombtimer );
}

// Namespace sd/sd
// Params 2
// Checksum 0xa4dd7493, Offset: 0x4900
// Size: 0x15c
function bombdefused( defusedobject, player )
{
    level.tickingobject globallogic_utils::stoptickingsound();
    level.bombdefused = 1;
    player setweaponoverheating( 1, 100, defusedobject.useweapon );
    setbombtimer( "A", 0 );
    setbombtimer( "B", 0 );
    setmatchflag( "bomb_timer_a", 0 );
    setmatchflag( "bomb_timer_b", 0 );
    player playbombdefuse();
    level notify( #"bomb_defused" );
    thread globallogic_audio::set_music_on_team( "silent" );
    wait 1.5;
    setgameendtime( 0 );
    sd_endgame( game.defenders, game.strings[ "bomb_defused" ] );
}

// Namespace sd/sd
// Params 0
// Checksum 0x4255de8e, Offset: 0x4a68
// Size: 0x10c, Type: bool
function sd_iskillboosting()
{
    roundsplayed = util::getroundsplayed();
    
    if ( level.playerkillsmax == 0 )
    {
        return false;
    }
    
    if ( game.totalkills > level.totalkillsmax * ( roundsplayed + 1 ) )
    {
        return true;
    }
    
    if ( self.kills > level.playerkillsmax * ( roundsplayed + 1 ) )
    {
        return true;
    }
    
    if ( self.team == "allies" || level.teambased && self.team == "axis" )
    {
        if ( game.totalkillsteam[ self.team ] > level.playerkillsmax * ( roundsplayed + 1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace sd/sd
// Params 1
// Checksum 0x6b465f8e, Offset: 0x4b80
// Size: 0x7a
function figureoutgametypefriendlyfire( victim )
{
    if ( victim.isplanting === 1 || level.hardcoremode && level.friendlyfire > 0 && isdefined( victim ) && victim.isdefusing === 1 )
    {
        return 2;
    }
    
    return level.friendlyfire;
}

