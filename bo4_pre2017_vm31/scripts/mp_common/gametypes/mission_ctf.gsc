#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_defaults;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hud_message;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace mission_ctf;

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x99507aad, Offset: 0xc98
// Size: 0x278
function init( settings_bundle )
{
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    
    if ( getdvarstring( "scr_ctf_spawnPointFacingAngle" ) == "" )
    {
        setdvar( "scr_ctf_spawnPointFacingAngle", "0" );
    }
    
    level.teambased = 1;
    level.ctfreturnflag = &returnflag;
    globallogic_audio::set_leader_gametype_dialog( "startCtf", "hcStartCtf", "objCapture", "objCapture" );
    level.lastdialogtime = gettime();
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "rolescore", "score", "kills", "captures", "returns", "deaths" );
    }
    else
    {
        globallogic::setvisiblescoreboardcolumns( "rolescore", "score", "kills", "deaths", "captures", "returns" );
    }
    
    game.flag_dropped_sound = "mp_war_objective_lost";
    game.flag_recovered_sound = "mp_war_objective_taken";
    game.strings[ "score_limit_reached" ] = &"MP_CAP_LIMIT_REACHED";
    level.var_df6e4604 = 0;
    level.var_c87ed430 = getgametypesetting( "capturesPerReturnSite" );
    
    if ( isdefined( settings_bundle ) )
    {
        level.mission_bundle = settings_bundle;
        return;
    }
    
    level.mission_bundle = getscriptbundle( "mission_settings_core" );
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0xf771af2d, Offset: 0xf18
// Size: 0x206
function setup_objectives()
{
    foreach ( team in level.teams )
    {
        util::setobjectivetext( team, &"OBJECTIVES_CTF" );
        
        if ( level.splitscreen )
        {
            util::setobjectivescoretext( team, &"OBJECTIVES_CTF" );
            continue;
        }
        
        util::setobjectivescoretext( team, &"OBJECTIVES_CTF_SCORE" );
    }
    
    util::setobjectivehinttext( game.attackers, &"OBJECTIVES_CTO_ATTACKERS_HINT" );
    util::setobjectivehinttext( game.defenders, &"OBJECTIVES_CTO_DEFENDERS_HINT" );
    level.flagcapturetime = 0.1;
    level.flagtouchreturntime = 0;
    level.idleflagreturntime = 0;
    game.strings[ game.attackers + "_mission_win" ] = &"OBJECTIVES_MISSION_CTF_ATTACKER_WIN_HINT";
    game.strings[ game.attackers + "_mission_loss" ] = &"OBJECTIVES_MISSION_ATTACKER_LOSS_HINT";
    game.strings[ game.defenders + "_mission_win" ] = &"OBJECTIVES_MISSION_CTF_DEFENDER_WIN_HINT";
    game.strings[ game.defenders + "_mission_loss" ] = &"OBJECTIVES_MISSION_CTF_DEFENDER_LOSS_HINT";
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x2607eff2, Offset: 0x1128
// Size: 0x44
function on_spawn_player( predictedspawn )
{
    self.isflagcarrier = 0;
    self.flagcarried = undefined;
    self clientfield::set( "ctf_flag_carrier", 0 );
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0xc695dae5, Offset: 0x1178
// Size: 0x4e0
function function_ede8a483()
{
    self endon( #"death" );
    self endon( #"delete" );
    
    while ( true )
    {
        waitresult = self waittill( "damage" );
        damage = waitresult.amount;
        weapon = waitresult.weapon;
        attacker = waitresult.attacker;
        
        if ( !self.gameobject gameobjects::is_object_away_from_home() )
        {
            self.health = self.maxhealth;
            
            foreach ( player in level.players )
            {
                player.var_61edcaa2 = undefined;
            }
            
            continue;
        }
        
        if ( !isdefined( attacker.var_61edcaa2 ) )
        {
            attacker.var_61edcaa2 = 0;
        }
        
        attacker.var_61edcaa2 += damage;
        
        if ( level.teambased && self.gameobject.ownerteam != attacker.team )
        {
            if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
            {
                attacker damagefeedback::update();
            }
        }
        
        if ( isdefined( attacker.team ) && game.defenders == attacker.team )
        {
            if ( self.health <= self.minhealth )
            {
                self.health = self.maxhealth;
                self.gameobject gameobjects::return_home();
                globallogic_audio::leader_dialog( "warCellDestroyOfs", game.attackers, undefined, "ctf_battery" );
                globallogic_audio::leader_dialog( "warCellDestroyDef", game.defenders, undefined, "ctf_battery_enemy" );
                scoreevents::processscoreevent( "war_power_cell_destroyed", attacker );
                clientfield::set_world_uimodel( "hudItems.war.batteryState" + self.gameobject.var_4a8e97c0, 0 );
                
                foreach ( player in level.players )
                {
                    if ( player == attacker || player.team == game.attackers || !isdefined( player.var_61edcaa2 ) )
                    {
                        continue;
                    }
                    
                    shutdowndamage = self.maxhealth - self.minhealth;
                    damagepercent = player.var_61edcaa2 / shutdowndamage;
                    
                    if ( damagepercent >= 0.2 )
                    {
                        scoreevents::processscoreevent( "power_cell_destroy_assist", player );
                    }
                    
                    player.var_61edcaa2 = undefined;
                }
            }
        }
        
        delta = self.health - self.minhealth;
        max_delta = self.maxhealth - self.minhealth;
        percent = min( 1, delta / max_delta );
        objective_setprogress( self.gameobject.objectiveid, percent );
    }
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x9456b242, Offset: 0x1660
// Size: 0x198
function function_64054d25( trigger )
{
    visuals = [];
    
    if ( isdefined( trigger ) && isdefined( trigger.target ) )
    {
        targets = getentarray( trigger.target, "targetname" );
        
        if ( targets.size > 0 )
        {
            best_dist2 = distancesquared( targets[ 0 ].origin, trigger.origin );
            visuals[ 0 ] = targets[ 0 ];
            
            foreach ( obj in targets )
            {
                if ( isdefined( obj ) )
                {
                    dist2 = distancesquared( obj.origin, trigger.origin );
                    
                    if ( dist2 < best_dist2 )
                    {
                        best_dist2 = dist2;
                        visuals[ 0 ] = obj;
                    }
                }
            }
        }
    }
    
    return visuals;
}

// Namespace mission_ctf/mission_ctf
// Params 2
// Checksum 0x4bb48717, Offset: 0x1800
// Size: 0x4c2
function function_48b93264( trigger, objective_name )
{
    visuals = function_64054d25( trigger );
    entityteam = game.attackers;
    visuals[ 0 ] setmodel( "wpn_t7_prp_unobtainium_box_small" );
    visuals[ 0 ] setteam( entityteam );
    battery = gameobjects::create_carry_object( entityteam, trigger, visuals, ( 0, 0, 0 ), objective_name );
    battery.bundle = getscriptbundle( "gameobject_battery" );
    
    if ( !isdefined( battery.bundle.n_trigger_use_time ) )
    {
        battery.bundle.n_trigger_use_time = 3;
    }
    
    battery gameobjects::set_use_time( battery.bundle.n_trigger_use_time );
    battery gameobjects::set_team_use_time( "friendly", level.flagtouchreturntime );
    battery gameobjects::set_team_use_time( "enemy", level.flagcapturetime );
    battery gameobjects::set_objective_entity( visuals[ 0 ] );
    battery gameobjects::set_use_hint_text( &"PLATFORM_GAMEOBJECT_BATTERY" );
    trigger setcursorhint( "HINT_ACTIVATE" );
    battery gameobjects::allow_carry( "friendly" );
    battery gameobjects::set_visible_team( "any" );
    battery gameobjects::set_visible_carrier_model( teams::get_flag_carry_model( entityteam ) );
    battery gameobjects::set_2d_icon( "friendly", level.icondefend2d );
    battery gameobjects::set_3d_icon( "friendly", level.icondefend3d );
    battery gameobjects::set_2d_icon( "enemy", level.iconcapture2d );
    battery gameobjects::set_3d_icon( "enemy", level.iconcapture3d );
    visuals[ 0 ].gameobject = battery;
    visuals[ 0 ] setcandamage( 1 );
    visuals[ 0 ].maxhealth = 20000;
    visuals[ 0 ].minhealth = visuals[ 0 ].maxhealth - 1000;
    visuals[ 0 ].health = visuals[ 0 ].maxhealth;
    objective_setprogress( battery.objectiveid, 1 );
    visuals[ 0 ] thread function_ede8a483();
    battery.objidpingfriendly = 1;
    battery.allowweapons = 0;
    battery.droponusebutton = 1;
    battery.onpickup = &onpickup;
    battery.onpickupfailed = &onpickup;
    battery.ondrop = &ondrop;
    battery.onreset = &onreset;
    
    if ( level.idleflagreturntime > 0 )
    {
        battery.autoresettime = level.idleflagreturntime;
    }
    else
    {
        battery.autoresettime = undefined;
    }
    
    return battery;
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0xf35105c0, Offset: 0x1cd0
// Size: 0x1e8
function createflagzone( trigger )
{
    visuals = function_64054d25( trigger );
    entityteam = game.defenders;
    flagzone = gameobjects::create_use_object( entityteam, trigger, visuals, ( 0, 0, 0 ), &"war_ctf_deposit" );
    flagzone gameobjects::allow_use( "enemy" );
    flagzone gameobjects::set_use_time( 0.2 );
    flagzone gameobjects::set_use_text( &"MP_CAPTURING_FLAG" );
    flagzone gameobjects::set_visible_team( "any" );
    flagzone gameobjects::set_model_visibility( 0 );
    flagzone gameobjects::set_use_hint_text( &"PLATFORM_GAMEOBJECT_BATTERY" );
    trigger setcursorhint( "HINT_ACTIVATE" );
    enemyteam = util::getotherteam( entityteam );
    flagzone gameobjects::set_key_object( level.batteries );
    flagzone.onuse = &oncapture;
    flagzone createflagspawninfluencer( entityteam );
    flagzone.var_9a048e13 = 0;
    return flagzone;
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x84e1c103, Offset: 0x1ec0
// Size: 0x364
function start( zone )
{
    setup_callbacks( zone );
    setup_objectives();
    level.batteries = [];
    level.flagzones = [];
    level.teamflagzones = [];
    var_caa2c308 = getentarray( "war_battery_pickup_trigger", "targetname" );
    
    if ( !isdefined( var_caa2c308 ) )
    {
        /#
            util::error( "<dev string:x28>" );
        #/
        
        return;
    }
    
    level.batteries = [];
    
    for ( index = 0; index < var_caa2c308.size ; index++ )
    {
        trigger = var_caa2c308[ index ];
        objectivestr = istring( "war_ctf_pickup_" + index + 1 );
        battery = function_48b93264( trigger, objectivestr );
        battery.var_4a8e97c0 = index + 1;
        clientfield::set_world_uimodel( "hudItems.war.batteryState" + battery.var_4a8e97c0, 0 );
        team = battery gameobjects::get_owner_team();
        level.batteries[ level.batteries.size ] = battery;
    }
    
    var_8c485d0d = getentarray( "war_battery_deposit_trigger", "targetname" );
    
    if ( !isdefined( var_8c485d0d ) )
    {
        /#
            util::error( "<dev string:x70>" );
        #/
        
        return;
    }
    
    for ( index = 0; index < var_8c485d0d.size ; index++ )
    {
        trigger = var_8c485d0d[ index ];
        flagzone = createflagzone( trigger );
        team = flagzone gameobjects::get_owner_team();
        level.flagzones[ level.flagzones.size ] = flagzone;
        level.teamflagzones[ team ] = flagzone;
        facing_angle = getdvarint( "scr_ctf_spawnPointFacingAngle" );
        setspawnpointsbaseweight( util::getotherteamsmask( team ), trigger.origin, facing_angle, level.spawnsystem.objective_facing_bonus );
    }
    
    function_2c0ba61c();
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x57f6b20e, Offset: 0x2230
// Size: 0x58
function setup_callbacks( zone )
{
    zone.main_loop = &main_loop;
    zone.on_spawn_player = &on_spawn_player;
    zone.on_player_killed = &on_player_killed;
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0x357ca158, Offset: 0x2290
// Size: 0x11e
function removeinfluencers()
{
    if ( isdefined( self.spawn_influencer_enemy_carrier ) )
    {
        self influencers::remove_influencer( self.spawn_influencer_enemy_carrier );
        self.spawn_influencer_enemy_carrier = undefined;
    }
    
    if ( isdefined( self.spawn_influencer_friendly_carrier ) )
    {
        self influencers::remove_influencer( self.spawn_influencer_friendly_carrier );
        self.spawn_influencer_friendly_carrier = undefined;
    }
    
    if ( isdefined( self.spawn_influencer_dropped ) )
    {
        self.trigger influencers::remove_influencer( self.spawn_influencer_dropped );
        self.spawn_influencer_dropped = undefined;
    }
    
    if ( isdefined( self.spawn_influencer_enemy ) )
    {
        self influencers::remove_influencer( self.spawn_influencer_enemy );
        self.spawn_influencer_enemy = undefined;
    }
    
    if ( isdefined( self.spawn_influencer_friendly ) )
    {
        self influencers::remove_influencer( self.spawn_influencer_friendly );
        self.spawn_influencer_friendly = undefined;
    }
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0xcfaf6c07, Offset: 0x23b8
// Size: 0x4a4
function ondrop( player )
{
    origin = ( 0, 0, 0 );
    
    if ( isdefined( player ) )
    {
        player clientfield::set( "ctf_flag_carrier", 0 );
        origin = player.origin;
    }
    
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam( team );
    bbprint( "mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagdropped", team, origin );
    
    if ( isdefined( player ) )
    {
        util::printandsoundoneveryone( team, undefined, &"", undefined, "mp_war_objective_lost" );
        level thread popups::displayteammessagetoteam( &"MP_FRIENDLY_FLAG_DROPPED", player, team );
        level thread popups::displayteammessagetoteam( &"MP_ENEMY_FLAG_DROPPED", player, otherteam );
    }
    else
    {
        util::printandsoundoneveryone( team, undefined, &"", undefined, "mp_war_objective_lost" );
    }
    
    globallogic_audio::leader_dialog( "warCellDropOfs", team, undefined, "ctf_battery" );
    globallogic_audio::leader_dialog( "warCellDropDef", otherteam, undefined, "ctf_battery_enemy" );
    
    if ( isdefined( player ) )
    {
        player playlocalsound( "mpl_flag_drop_plr" );
    }
    
    self gameobjects::set_flags( 1 );
    globallogic_audio::play_2d_on_team( "mpl_flagdrop_sting_friend", otherteam );
    globallogic_audio::play_2d_on_team( "mpl_flagdrop_sting_enemy", team );
    self gameobjects::set_3d_icon( "friendly", level.icondropped3d );
    self gameobjects::set_2d_icon( "friendly", level.icondropped2d );
    self gameobjects::set_visible_team( "any" );
    self gameobjects::set_3d_icon( "enemy", level.iconcapture3d );
    self gameobjects::set_2d_icon( "enemy", level.iconcapture2d );
    thread sound::play_on_players( game.flag_dropped_sound, game.attackers );
    self thread function_2afd3059( level.idleflagreturntime );
    
    if ( isdefined( player ) )
    {
        player removeinfluencers();
    }
    
    ss = level.spawnsystem;
    player_team_mask = util::getteammask( otherteam );
    enemy_team_mask = util::getteammask( team );
    
    if ( isdefined( player ) )
    {
        var_fea0b904 = player.origin;
    }
    else
    {
        var_fea0b904 = self.curorigin;
    }
    
    self.spawn_influencer_dropped = self.trigger influencers::create_entity_influencer( "ctf_flag_dropped", player_team_mask | enemy_team_mask );
    setinfluencertimeout( self.spawn_influencer_dropped, level.idleflagreturntime );
    clientfield::set_world_uimodel( "hudItems.war.batteryState" + self.var_4a8e97c0, 3 );
    self function_2ac9a02d();
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x9d795efc, Offset: 0x2868
// Size: 0xac
function function_1ae7f54d( player )
{
    assert( self.var_4a8e97c0 > 0 );
    assert( level.flagzones.size > self.var_4a8e97c0 - 1 );
    flag_zone = level.flagzones[ self.var_4a8e97c0 - 1 ];
    flag_zone gameobjects::show_waypoint( player );
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x99b4ccc5, Offset: 0x2920
// Size: 0x9a
function function_e8f85bce( player )
{
    foreach ( flag_zone in level.flagzones )
    {
        flag_zone gameobjects::set_flags( 1 );
    }
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0x7a85a9b5, Offset: 0x29c8
// Size: 0x142
function function_2ac9a02d()
{
    foreach ( flag_zone in level.flagzones )
    {
        flag_zone gameobjects::set_flags( 0 );
    }
    
    foreach ( battery in level.batteries )
    {
        if ( isdefined( battery gameobjects::get_carrier() ) )
        {
            function_e8f85bce( battery.carrier );
        }
    }
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0xde756b47, Offset: 0x2b18
// Size: 0x9c
function function_efa1a078()
{
    assert( self.var_4a8e97c0 > 0 );
    assert( level.flagzones.size > self.var_4a8e97c0 - 1 );
    flag_zone = level.flagzones[ self.var_4a8e97c0 - 1 ];
    flag_zone gameobjects::hide_waypoint();
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0xb51d26bd, Offset: 0x2bc0
// Size: 0x4dc
function onpickup( player )
{
    carrierkilledby = self.carrierkilledby;
    self.carrierkilledby = undefined;
    
    if ( isdefined( self.spawn_influencer_dropped ) )
    {
        self.trigger influencers::remove_influencer( self.spawn_influencer_dropped );
        self.spawn_influencer_dropped = undefined;
    }
    
    player addplayerstatwithgametype( "PICKUPS", 1 );
    self removeinfluencers();
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam( team );
    self function_34d1619d();
    bbprint( "mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagpickup", team, player.origin );
    player recordgameevent( "pickup" );
    demo::bookmark( "event", gettime(), player );
    util::printandsoundoneveryone( otherteam, undefined, &"", undefined, "mp_obj_taken", "mp_enemy_obj_taken" );
    level thread popups::displayteammessagetoteam( &"MP_FRIENDLY_FLAG_TAKEN", player, team );
    level thread popups::displayteammessagetoteam( &"MP_ENEMY_FLAG_TAKEN", player, otherteam );
    player.isflagcarrier = 1;
    player.flagcarried = self;
    player playlocalsound( "mpl_flag_pickup_plr" );
    player clientfield::set( "ctf_flag_carrier", 1 );
    self gameobjects::set_flags( 0 );
    globallogic_audio::play_2d_on_team( "mpl_flagget_sting_friend", otherteam );
    globallogic_audio::play_2d_on_team( "mpl_flagget_sting_enemy", team );
    globallogic_audio::leader_dialog( "warCellPickupOfs", game.attackers, undefined, "ctf_battery" );
    globallogic_audio::leader_dialog( "warCellPickupDef", game.defenders, undefined, "ctf_battery" );
    self gameobjects::set_visible_team( "any" );
    self gameobjects::set_2d_icon( "friendly", level.iconkill2d );
    self gameobjects::set_3d_icon( "friendly", level.iconkill3d );
    self gameobjects::set_2d_icon( "enemy", level.iconescort2d );
    self gameobjects::set_3d_icon( "enemy", level.iconescort3d );
    player resetflashback();
    ss = level.spawnsystem;
    player_team_mask = util::getteammask( otherteam );
    enemy_team_mask = util::getteammask( team );
    player.spawn_influencer_friendly_carrier = player influencers::create_entity_influencer( "ctf_carrier_friendly", player_team_mask );
    player.spawn_influencer_enemy_carrier = player influencers::create_entity_influencer( "ctf_carrier_enemy", enemy_team_mask );
    self function_e8f85bce( player );
    clientfield::set_world_uimodel( "hudItems.war.batteryState" + self.var_4a8e97c0, 2 );
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0x8717a5aa, Offset: 0x30a8
// Size: 0x224
function returnflag()
{
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam( team );
    globallogic_audio::play_2d_on_team( "mpl_flagreturn_sting", team );
    globallogic_audio::play_2d_on_team( "mpl_flagreturn_sting", otherteam );
    level.teamflagzones[ otherteam ] gameobjects::allow_use( "friendly" );
    level.teamflagzones[ otherteam ] gameobjects::set_visible_team( "friendly" );
    self gameobjects::return_home();
    self gameobjects::set_visible_team( "any" );
    self gameobjects::set_3d_icon( "friendly", level.icondefend3d );
    self gameobjects::set_2d_icon( "friendly", level.icondefend2d );
    self gameobjects::set_3d_icon( "enemy", level.iconcapture3d );
    self gameobjects::set_2d_icon( "enemy", level.iconcapture2d );
    globallogic_audio::leader_dialog( "warCellDestroyOfs", team, undefined, "ctf_battery" );
    globallogic_audio::leader_dialog( "warCellDestroyDef", otherteam, undefined, "ctf_battery_enemy" );
    self function_2ac9a02d();
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x4301fdae, Offset: 0x32d8
// Size: 0x4e0
function oncapture( player )
{
    team = player.pers[ "team" ];
    enemyteam = util::getotherteam( team );
    time = gettime();
    
    if ( !isdefined( player.carryobject ) )
    {
        return;
    }
    
    util::printandsoundoneveryone( team, undefined, &"", undefined, "mp_obj_captured", "mp_enemy_obj_captured" );
    bbprint( "mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", time, "ctf_flagcapture", enemyteam, player.origin );
    game.challenge[ team ][ "capturedFlag" ] = 1;
    
    if ( isdefined( player.pers[ "captures" ] ) )
    {
        player.pers[ "captures" ]++;
        player.captures = player.pers[ "captures" ];
    }
    
    demo::bookmark( "event", gettime(), player );
    player addplayerstatwithgametype( "CAPTURES", 1 );
    level thread popups::displayteammessagetoteam( &"MP_ENEMY_FLAG_CAPTURED", player, team );
    level thread popups::displayteammessagetoteam( &"MP_FRIENDLY_FLAG_CAPTURED", player, enemyteam );
    globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_enemy", enemyteam );
    globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_friend", team );
    player giveflagcapturexp( player );
    battery = player.carryobject;
    player challenges::capturedobjective( time, battery.trigger );
    self.var_9a048e13++;
    battery.dontannouncereturn = 1;
    battery gameobjects::return_home();
    battery.dontannouncereturn = undefined;
    battery gameobjects::allow_use( "none" );
    battery gameobjects::allow_carry( "none" );
    battery gameobjects::set_visible_team( "none" );
    battery gameobjects::set_model_visibility( 0 );
    self gameobjects::allow_use( "none" );
    self gameobjects::set_visible_team( "none" );
    self gameobjects::set_model_visibility( 1 );
    
    if ( level.var_df6e4604 == 0 )
    {
        globallogic_audio::leader_dialog( "warCellDeliveredOfs", team, undefined, "ctf_flag_enemy" );
        globallogic_audio::leader_dialog( "warCellDeliveredDef", enemyteam, undefined, "ctf_flag" );
    }
    
    player.isflagcarrier = 0;
    player.flagcarried = undefined;
    player clientfield::set( "ctf_flag_carrier", 0 );
    globallogic_score::giveteamscoreforobjective( team, 1 );
    battery removeinfluencers();
    player removeinfluencers();
    clientfield::set_world_uimodel( "hudItems.war.batteryState" + battery.var_4a8e97c0, 1 );
    self function_2ac9a02d();
    level.var_df6e4604++;
    level notify( #"battery_captured" );
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x8dc2669c, Offset: 0x37c0
// Size: 0x4c
function giveflagcapturexp( player )
{
    scoreevents::processscoreevent( "war_power_cell_delivery", player );
    player recordgameevent( "capture" );
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0x5a268962, Offset: 0x3818
// Size: 0x16c
function onreset()
{
    team = self gameobjects::get_owner_team();
    self gameobjects::set_visible_team( "any" );
    self gameobjects::set_3d_icon( "friendly", level.icondefend3d );
    self gameobjects::set_2d_icon( "friendly", level.icondefend2d );
    self gameobjects::set_3d_icon( "enemy", level.iconcapture3d );
    self gameobjects::set_2d_icon( "enemy", level.iconcapture2d );
    self gameobjects::set_flags( 0 );
    self function_34d1619d();
    self removeinfluencers();
    self function_2ac9a02d();
    clientfield::set_world_uimodel( "hudItems.war.batteryState" + self.var_4a8e97c0, 0 );
}

// Namespace mission_ctf/mission_ctf
// Params 9
// Checksum 0x1476bfd0, Offset: 0x3990
// Size: 0x604
function on_player_killed( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        for ( index = 0; index < level.batteries.size ; index++ )
        {
            flagteam = "invalidTeam";
            inflagradius = 0;
            defendedflag = 0;
            offendedflag = 0;
            flagcarrier = level.batteries[ index ].carrier;
            
            if ( isdefined( flagcarrier ) )
            {
                if ( isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] )
                {
                    if ( isdefined( level.batteries[ index ].carrier.attackerdata ) )
                    {
                        if ( level.batteries[ index ].carrier != attacker )
                        {
                            if ( isdefined( level.batteries[ index ].carrier.attackerdata[ self.clientid ] ) )
                            {
                                scoreevents::processscoreevent( "war_power_cell_carrier_rescue", attacker, undefined, weapon );
                            }
                        }
                    }
                }
                
                if ( isdefined( attacker.isflagcarrier ) && attacker !== self && attacker.isflagcarrier )
                {
                    scoreevents::processscoreevent( "war_power_cell_carry_kill", attacker, undefined, weapon );
                }
            }
        }
        
        if ( isdefined( self.isflagcarrier ) && attacker !== self && self.isflagcarrier )
        {
            scoreevents::processscoreevent( "war_power_cell_carrier_kill", attacker, undefined, weapon );
        }
        
        victim = self;
        
        foreach ( flag_zone in level.flagzones )
        {
            if ( isdefined( attacker.team ) && attacker != victim && isdefined( victim.team ) )
            {
                dist_to_zone_origin = distance2dsquared( attacker.origin, flag_zone.origin );
                victim_dist_to_zone_origin = distance2dsquared( victim.origin, flag_zone.origin );
                
                if ( victim_dist_to_zone_origin < level.defaultoffenseradiussq || dist_to_zone_origin < level.defaultoffenseradiussq )
                {
                    if ( victim.team == flag_zone.team )
                    {
                        attacker thread challenges::killedbasedefender( flag_zone.trigger );
                        continue;
                    }
                    
                    attacker thread challenges::killedbaseoffender( flag_zone.trigger, weapon );
                }
            }
        }
    }
    
    if ( !isdefined( self.isflagcarrier ) || !self.isflagcarrier )
    {
        return;
    }
    
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] )
    {
        if ( isdefined( self.flagcarried ) )
        {
            for ( index = 0; index < level.batteries.size ; index++ )
            {
                currentflag = level.batteries[ index ];
                
                if ( currentflag.ownerteam == self.team )
                {
                    if ( currentflag.curorigin == currentflag.trigger.baseorigin )
                    {
                        dist = distance2dsquared( self.origin, currentflag.curorigin );
                        
                        if ( dist < level.defaultoffenseradiussq )
                        {
                            self.flagcarried.carrierkilledby = attacker;
                            break;
                        }
                    }
                }
            }
        }
        
        attacker recordgameevent( "kill_carrier" );
        self recordkillmodifier( "carrying" );
    }
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0xd64bfe9a, Offset: 0x3fa0
// Size: 0x474
function function_2c0ba61c()
{
    level.var_5d0c9f44 = [];
    level.var_5d0c9f44[ "allies" ][ "axis" ] = hud::createservertimer( "objective", 1.4, "allies" );
    level.var_5d0c9f44[ "allies" ][ "axis" ] hud::setpoint( "TOPRIGHT", "TOPRIGHT", 0, 0 );
    level.var_5d0c9f44[ "allies" ][ "axis" ].label = &"MP_ENEMY_FLAG_RETURNING_IN";
    level.var_5d0c9f44[ "allies" ][ "axis" ].alpha = 0;
    level.var_5d0c9f44[ "allies" ][ "axis" ].archived = 0;
    level.var_5d0c9f44[ "allies" ][ "allies" ] = hud::createservertimer( "objective", 1.4, "allies" );
    level.var_5d0c9f44[ "allies" ][ "allies" ] hud::setpoint( "TOPRIGHT", "TOPRIGHT", 0, 20 );
    level.var_5d0c9f44[ "allies" ][ "allies" ].label = &"MP_YOUR_FLAG_RETURNING_IN";
    level.var_5d0c9f44[ "allies" ][ "allies" ].alpha = 0;
    level.var_5d0c9f44[ "allies" ][ "allies" ].archived = 0;
    level.var_5d0c9f44[ "axis" ][ "allies" ] = hud::createservertimer( "objective", 1.4, "axis" );
    level.var_5d0c9f44[ "axis" ][ "allies" ] hud::setpoint( "TOPRIGHT", "TOPRIGHT", 0, 0 );
    level.var_5d0c9f44[ "axis" ][ "allies" ].label = &"MP_ENEMY_FLAG_RETURNING_IN";
    level.var_5d0c9f44[ "axis" ][ "allies" ].alpha = 0;
    level.var_5d0c9f44[ "axis" ][ "allies" ].archived = 0;
    level.var_5d0c9f44[ "axis" ][ "axis" ] = hud::createservertimer( "objective", 1.4, "axis" );
    level.var_5d0c9f44[ "axis" ][ "axis" ] hud::setpoint( "TOPRIGHT", "TOPRIGHT", 0, 20 );
    level.var_5d0c9f44[ "axis" ][ "axis" ].label = &"MP_YOUR_FLAG_RETURNING_IN";
    level.var_5d0c9f44[ "axis" ][ "axis" ].alpha = 0;
    level.var_5d0c9f44[ "axis" ][ "axis" ].archived = 0;
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x262f50e4, Offset: 0x4420
// Size: 0x98
function function_2afd3059( time )
{
    if ( level.idleflagreturntime == 0 )
    {
        return;
    }
    
    self notify( #"hash_2afd3059" );
    self endon( #"hash_2afd3059" );
    result = function_5badced4( time );
    self removeinfluencers();
    self function_34d1619d();
    
    if ( !isdefined( result ) )
    {
        return;
    }
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x80dce7f9, Offset: 0x44c0
// Size: 0x192, Type: bool
function function_5badced4( time )
{
    self endon( #"picked_up" );
    level endon( #"game_ended" );
    ownerteam = self gameobjects::get_owner_team();
    assert( !level.var_5d0c9f44[ "<dev string:xb9>" ][ ownerteam ].alpha );
    level.var_5d0c9f44[ "axis" ][ ownerteam ].alpha = 1;
    level.var_5d0c9f44[ "axis" ][ ownerteam ] settimer( time );
    assert( !level.var_5d0c9f44[ "<dev string:xbe>" ][ ownerteam ].alpha );
    level.var_5d0c9f44[ "allies" ][ ownerteam ].alpha = 1;
    level.var_5d0c9f44[ "allies" ][ ownerteam ] settimer( time );
    
    if ( time <= 0 )
    {
        return false;
    }
    else
    {
        wait time;
    }
    
    return true;
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0x277cb84b, Offset: 0x4660
// Size: 0xb8
function function_34d1619d()
{
    ownerteam = self gameobjects::get_owner_team();
    
    if ( isdefined( level.var_5d0c9f44[ "allies" ][ ownerteam ] ) )
    {
        level.var_5d0c9f44[ "allies" ][ ownerteam ].alpha = 0;
    }
    
    if ( isdefined( level.var_5d0c9f44[ "axis" ][ ownerteam ] ) )
    {
        level.var_5d0c9f44[ "axis" ][ ownerteam ].alpha = 0;
    }
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x8a05d157, Offset: 0x4720
// Size: 0xe4
function createflagspawninfluencer( entityteam )
{
    otherteam = util::getotherteam( entityteam );
    team_mask = util::getteammask( entityteam );
    other_team_mask = util::getteammask( otherteam );
    self.spawn_influencer_friendly = self influencers::create_influencer( "ctf_base_friendly", self.trigger.origin, team_mask );
    self.spawn_influencer_enemy = self influencers::create_influencer( "ctf_base_friendly", self.trigger.origin, other_team_mask );
}

// Namespace mission_ctf/mission_ctf
// Params 1
// Checksum 0x33c981e9, Offset: 0x4810
// Size: 0x16c
function main_loop( zone )
{
    level endon( #"game_ended" );
    level endon( #"mission_ended" );
    var_58f054c1 = level.mission_bundle.msbatterycount;
    
    if ( !isdefined( var_58f054c1 ) )
    {
        var_58f054c1 = 2;
    }
    
    thread globallogic::showobjectivenotificationuiforallplayers( &"mission_ctf" );
    
    while ( level.var_df6e4604 < var_58f054c1 )
    {
        msg = level waittill( "battery_captured", "mission_timed_out" );
        
        if ( msg._notify === "mission_timed_out" )
        {
            break;
        }
    }
    
    if ( level.var_df6e4604 == var_58f054c1 )
    {
        level.war_mission_succeeded = 1;
        globallogic_audio::leader_dialog( "warCellFinalDeliveredOfs", game.attackers, undefined, "ctf_battery" );
        globallogic_audio::leader_dialog( "warCellFinalDeliveredDef", game.defenders, undefined, "ctf_battery_enemy" );
    }
    
    function_f15912dd();
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0x629bc873, Offset: 0x4988
// Size: 0xec
function function_f15912dd()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            if ( isdefined( player.carryobject ) )
            {
                player.carryobject gameobjects::set_dropped();
            }
            
            player removeinfluencers();
        }
    }
    
    function_bcc85d64();
    function_7b35d359();
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0xfc12350d, Offset: 0x4a80
// Size: 0x11e
function function_bcc85d64()
{
    foreach ( battery in level.batteries )
    {
        if ( !isdefined( battery ) )
        {
            continue;
        }
        
        battery removeinfluencers();
        battery gameobjects::disable_object();
        battery gameobjects::allow_use( "none" );
        battery gameobjects::set_owner_team( "neutral" );
        battery gameobjects::set_model_visibility( 0 );
        battery.decayprogress = 1;
    }
}

// Namespace mission_ctf/mission_ctf
// Params 0
// Checksum 0x4ebce790, Offset: 0x4ba8
// Size: 0x10a
function function_7b35d359()
{
    foreach ( flagzone in level.flagzones )
    {
        if ( !isdefined( flagzone ) )
        {
            continue;
        }
        
        flagzone removeinfluencers();
        flagzone gameobjects::disable_object();
        flagzone gameobjects::allow_use( "none" );
        flagzone gameobjects::set_owner_team( "neutral" );
        flagzone gameobjects::set_model_visibility( 0 );
    }
}

