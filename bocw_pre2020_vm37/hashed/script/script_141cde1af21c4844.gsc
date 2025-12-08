#using script_335d0650ed05d36d;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\util;

#namespace namespace_df33b0b;

// Namespace namespace_df33b0b/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x5f18605, Offset: 0x200
// Size: 0x124
function event_handler[gametype_init] main( *eventstruct )
{
    globallogic::init();
    util::registerscorelimit( 0, 500 );
    spawning::addsupportedspawnpointtype( "ctf" );
    level.planttime = getgametypesetting( #"planttime" );
    level.defusetime = getgametypesetting( #"defusetime" );
    level.bombtimer = getgametypesetting( #"bombtimer" );
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundswitch = &onroundswitch;
    level.shouldplayovertimeround = &shouldplayovertimeround;
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 0
// Checksum 0x1c235e38, Offset: 0x330
// Size: 0xe4
function onstartgametype()
{
    level._effect[ #"bombexplosion" ] = #"explosions/fx_exp_bomb_demo_mp";
    level.var_f1654bf6 = 0;
    function_8fdfe223( "a", 0, 0 );
    function_8fdfe223( "b", 0, 0 );
    function_8fdfe223( "c", 0, 0 );
    
    if ( overtime::is_overtime_round() )
    {
        thread overtime();
        return;
    }
    
    level.ontimelimit = &globallogic::function_61e80d63;
    function_75735c97();
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 1
// Checksum 0xe18189a2, Offset: 0x420
// Size: 0x24
function onspawnplayer( predictedspawn )
{
    spawning::onspawnplayer( predictedspawn );
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 0
// Checksum 0x64a2b3ba, Offset: 0x450
// Size: 0x14
function onroundswitch()
{
    gametype::on_round_switch();
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 0
// Checksum 0xe2cf7eae, Offset: 0x470
// Size: 0x110
function function_75735c97()
{
    var_f0e10abd = struct::get_array( "false_alarm_missile_site", "targetname" );
    var_9d6d35b6 = var_f0e10abd[ randomint( var_f0e10abd.size ) ];
    
    foreach ( var_948752cf in var_f0e10abd )
    {
        if ( var_948752cf === var_9d6d35b6 )
        {
            var_948752cf function_947e3ad2( 1, var_948752cf.script_label );
            continue;
        }
        
        var_948752cf function_947e3ad2( 0, var_948752cf.script_label );
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 2
// Checksum 0x75ff39ee, Offset: 0x588
// Size: 0x626
function function_947e3ad2( var_9c9bc75c = 0, label = "a" )
{
    var_67c85b77 = spawn( "trigger_radius_use", self.origin + ( 0, 0, 10 ), 0, 150, 150 );
    var_67c85b77 setcursorhint( "HINT_INTERACTIVE_PROMPT" );
    defusetrigger = spawn( "trigger_radius_use", self.origin + ( 0, 0, 10 ), 0, 85, 150 );
    defusetrigger setcursorhint( "HINT_INTERACTIVE_PROMPT" );
    model = spawn( "script_model", self.origin );
    model.angles = self.angles;
    model setmodel( #"hash_7bf8bca264708ab9" );
    
    if ( label === "a" )
    {
        var_a38ea00f = 1;
        var_beb5c4ff = #"hash_58554cc940bb1b24";
    }
    else if ( label === "b" )
    {
        var_a38ea00f = 2;
        var_beb5c4ff = #"hash_58554fc940bb203d";
    }
    else
    {
        var_a38ea00f = 3;
        var_beb5c4ff = #"hash_58554ec940bb1e8a";
    }
    
    var_7139b124 = gameobjects::create_use_object( game.defenders, var_67c85b77, [], ( 0, 0, 0 ), #"hash_3c92bb8662617a67" );
    var_7139b124 gameobjects::allow_use( #"group_enemy" );
    var_7139b124 gameobjects::set_use_time( level.planttime );
    var_7139b124 gameobjects::function_1b4d64d8( 1 );
    var_7139b124 gameobjects::set_onbeginuse_event( &function_244093f1 );
    var_7139b124 gameobjects::set_onenduse_event( &function_49228915 );
    var_7139b124 gameobjects::set_onuse_event( &function_b10aa510 );
    var_7139b124 gameobjects::set_flags( var_a38ea00f );
    var_7139b124.useweapon = getweapon( #"briefcase_bomb" );
    var_477be7ed = gameobjects::create_use_object( game.attackers, defusetrigger, [], ( 0, 0, 0 ), var_beb5c4ff );
    var_477be7ed gameobjects::allow_use( #"group_enemy" );
    var_477be7ed gameobjects::set_use_time( level.defusetime );
    var_477be7ed gameobjects::function_1b4d64d8( 1 );
    var_477be7ed gameobjects::set_onbeginuse_event( &function_9bb9d450 );
    var_477be7ed gameobjects::set_onenduse_event( &function_bf0daf2d );
    var_477be7ed gameobjects::set_onuse_event( &function_6d15a420 );
    var_477be7ed function_c6a01b9b();
    var_477be7ed.useweapon = getweapon( #"briefcase_bomb_defuse" );
    
    if ( var_9c9bc75c )
    {
        var_7139b124 gameobjects::set_visible( #"group_enemy" );
        var_7139b124.var_11859809 = gameobjects::get_next_obj_id();
        objective_add( var_7139b124.var_11859809, "active", var_7139b124, #"hash_5627e24568b5bf14" );
        objective_setteam( var_7139b124.var_11859809, game.defenders );
        function_c939fac4( var_7139b124.var_11859809, game.attackers );
        objective_setgamemodeflags( var_7139b124.var_11859809, var_a38ea00f );
        var_477be7ed gameobjects::set_flags( 1 );
        var_477be7ed.var_379686cc = gameobjects::get_next_obj_id();
        objective_add( var_477be7ed.var_379686cc, "invisible", var_477be7ed, var_beb5c4ff );
        objective_setteam( var_477be7ed.var_379686cc, game.attackers );
        function_c939fac4( var_477be7ed.var_379686cc, game.defenders );
    }
    else
    {
        var_7139b124 gameobjects::set_visible( #"group_all" );
    }
    
    var_2c327cf8 = {};
    var_2c327cf8.var_7139b124 = var_7139b124;
    var_2c327cf8.var_477be7ed = var_477be7ed;
    var_2c327cf8.var_9c9bc75c = var_9c9bc75c;
    var_2c327cf8.var_95f894dc = model;
    var_2c327cf8.label = label;
    var_7139b124.var_2c327cf8 = var_2c327cf8;
    var_477be7ed.var_2c327cf8 = var_2c327cf8;
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 1
// Checksum 0x74d955, Offset: 0xbb8
// Size: 0xb4
function function_244093f1( player )
{
    timeremaining = globallogic_utils::gettimeremaining();
    
    if ( timeremaining <= int( level.planttime * 1000 ) )
    {
        function_f488fe7a();
    }
    
    player.isplanting = 1;
    player thread setbomboverheatingafterweaponchange( self, 0, 0 );
    player playsound( #"fly_bomb_raise_plr" );
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 3
// Checksum 0x1e21e759, Offset: 0xc78
// Size: 0x3e
function function_49228915( *team, player, success )
{
    if ( !success )
    {
        function_da922ded();
    }
    
    player.isplanting = 0;
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 1
// Checksum 0x98369980, Offset: 0xcc0
// Size: 0xc4
function function_9bb9d450( *player )
{
    self notify( #"hash_60e16ed54a079d38" );
    timeremaining = globallogic_utils::gettimeremaining();
    
    if ( timeremaining <= int( level.defusetime * 1000 ) )
    {
        function_f488fe7a();
    }
    
    if ( isdefined( self.var_2c327cf8 ) )
    {
        var_ec427e30 = self.var_2c327cf8.var_ec427e30;
        
        if ( isdefined( var_ec427e30 ) )
        {
            var_ec427e30 hide();
        }
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 3
// Checksum 0x8ea9b762, Offset: 0xd90
// Size: 0x94
function function_bf0daf2d( *team, *player, success )
{
    if ( !success )
    {
        function_da922ded();
        self notify( #"hash_41c7fc9fe7afac09" );
    }
    
    if ( isdefined( self.var_2c327cf8 ) && !success )
    {
        var_ec427e30 = self.var_2c327cf8.var_ec427e30;
        
        if ( isdefined( var_ec427e30 ) )
        {
            var_ec427e30 show();
        }
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 1
// Checksum 0x5768ab2c, Offset: 0xe30
// Size: 0x28c
function function_b10aa510( player )
{
    level endon( #"game_ended" );
    var_2c327cf8 = self.var_2c327cf8;
    var_7139b124 = self;
    var_477be7ed = var_2c327cf8.var_477be7ed;
    assert( isdefined( var_477be7ed ) );
    level.var_f1654bf6++;
    var_7139b124 function_c6a01b9b( var_7139b124.var_11859809 );
    var_477be7ed function_d6649915( var_477be7ed.var_379686cc );
    var_477be7ed gameobjects::set_owner_team( player.team );
    thread bombplanted( var_2c327cf8, player );
    level thread popups::displayteammessagetoall( #"hash_12473d7e6ed6e752", player );
    
    if ( isdefined( player.pers[ #"plants" ] ) )
    {
        player.pers[ #"plants" ]++;
        player.plants = player.pers[ #"plants" ];
    }
    
    player.pers[ #"objectives" ]++;
    player.objectives = player.pers[ #"objectives" ];
    player stats::function_bb7eedf0( #"plants", 1 );
    player stats::function_dad108fa( #"plants_defuses", 1 );
    player globallogic_score::incpersstat( #"objectivescore", 1, 0, 1 );
    scoreevents::processscoreevent( #"planted_bomb", player, undefined, undefined );
    globallogic_audio::leader_dialog( "bombPlanted" );
    util::function_a3f7de13( 4, player.team, player getentitynumber() );
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 2
// Checksum 0xef0fbbc5, Offset: 0x10c8
// Size: 0x49c
function bombplanted( var_2c327cf8, player )
{
    level endon( #"game_ended" );
    var_7139b124 = var_2c327cf8.var_7139b124;
    var_7139b124 endon( #"bomb_defused" );
    var_477be7ed = var_2c327cf8.var_477be7ed;
    var_95f894dc = var_2c327cf8.var_95f894dc;
    assert( isdefined( var_95f894dc ) );
    function_8fdfe223( var_2c327cf8.label, level.bombtimer, 1 );
    player setweaponoverheating( 1, 100, var_7139b124.useweapon );
    player playbombplant();
    tickingobject = var_95f894dc;
    tickingobject thread globallogic_utils::playtickingsound( #"mpl_sab_ui_suitcasebomb_timer" );
    var_2c327cf8.tickingobject = var_95f894dc;
    function_5bbda36a( var_2c327cf8, player );
    function_f488fe7a();
    var_477be7ed function_d2447ce2();
    
    if ( isdefined( tickingobject ) )
    {
        tickingobject globallogic_utils::stoptickingsound();
        damageradius = 100;
        damageamount = 125;
        
        if ( var_2c327cf8.var_9c9bc75c === 1 )
        {
            damageradius = 512;
            damageamount = 800;
        }
        
        tickingobject radiusdamage( var_7139b124.origin, damageradius, damageamount, damageamount, player, "MOD_EXPLOSIVE" );
    }
    
    theta = randomint( 360 );
    explosionorigin = var_7139b124.origin;
    explosioneffect = spawnfx( level._effect[ #"bombexplosion" ], explosionorigin + ( 0, 0, 50 ), ( 0, 0, 1 ), ( cos( theta ), sin( theta ), 0 ) );
    triggerfx( explosioneffect );
    thread sound::play_in_space( "mpl_sd_exp_suitcase_bomb_main", explosionorigin );
    function_8fdfe223( var_2c327cf8.label, 0, 0 );
    var_7139b124 function_c6a01b9b( var_7139b124.var_11859809 );
    var_7139b124 gameobjects::disable_object();
    var_477be7ed function_c6a01b9b( var_477be7ed.var_379686cc );
    var_477be7ed gameobjects::disable_object();
    var_95f894dc delete();
    var_2c327cf8.var_ec427e30 delete();
    
    if ( var_2c327cf8.var_9c9bc75c === 1 )
    {
        level thread popups::displayteammessagetoall( #"hash_74fa1e5aa0983f9", player );
        player stats::function_bb7eedf0( #"destructions", 1 );
        scoreevents::processscoreevent( #"bomb_detonated", player, undefined, undefined );
        setgameendtime( 0 );
        
        if ( level.roundending === 1 )
        {
            return;
        }
        
        wait 3;
        thread globallogic::function_a3e3bd39( player.team, 1 );
        return;
    }
    
    level.var_f1654bf6--;
    function_da922ded();
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 1
// Checksum 0x5b98e9b, Offset: 0x1570
// Size: 0x24c
function function_6d15a420( player )
{
    level endon( #"game_ended" );
    level.var_f1654bf6--;
    function_da922ded();
    var_2c327cf8 = self.var_2c327cf8;
    var_477be7ed = self;
    var_7139b124 = var_2c327cf8.var_7139b124;
    assert( isdefined( var_7139b124 ) );
    var_477be7ed function_c6a01b9b( var_477be7ed.var_379686cc );
    var_7139b124 function_d6649915( var_7139b124.var_11859809 );
    bombdefused( var_2c327cf8, player );
    level thread popups::displayteammessagetoall( #"mp/explosives_defused_by", player );
    
    if ( isdefined( player.pers[ #"defuses" ] ) )
    {
        player.pers[ #"defuses" ]++;
        player.defuses = player.pers[ #"defuses" ];
    }
    
    player.pers[ #"objectives" ]++;
    player.objectives = player.pers[ #"objectives" ];
    player stats::function_bb7eedf0( #"defuses", 1 );
    player stats::function_dad108fa( #"plants_defuses", 1 );
    player globallogic_score::incpersstat( #"objectivedefends", 1, 0, 1 );
    scoreevents::processscoreevent( #"defused_bomb", player, undefined, undefined );
    globallogic_audio::leader_dialog( "bombDefused" );
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 2
// Checksum 0x367721ab, Offset: 0x17c8
// Size: 0xf0
function bombdefused( var_2c327cf8, player )
{
    level endon( #"game_ended" );
    var_7139b124 = var_2c327cf8.var_7139b124;
    var_477be7ed = var_2c327cf8.var_477be7ed;
    player setweaponoverheating( 1, 100, var_477be7ed.useweapon );
    player playbombplant();
    function_8fdfe223( var_2c327cf8.label, 0, 0 );
    
    if ( isdefined( var_2c327cf8.tickingobject ) )
    {
        var_2c327cf8.tickingobject globallogic_utils::stoptickingsound();
    }
    
    var_7139b124 notify( #"bomb_defused" );
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 0
// Checksum 0x34df6156, Offset: 0x18c0
// Size: 0x3c
function function_f488fe7a()
{
    if ( level.timerpaused !== 1 )
    {
        globallogic_utils::pausetimer();
        level.timerpaused = 1;
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 0
// Checksum 0xbf118ce4, Offset: 0x1908
// Size: 0x48
function function_da922ded()
{
    if ( level.var_f1654bf6 > 0 )
    {
        return;
    }
    
    if ( level.timerpaused === 1 )
    {
        globallogic_utils::resumetimer();
        level.timerpaused = 0;
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 1
// Checksum 0xdc6e8306, Offset: 0x1958
// Size: 0x74
function function_c6a01b9b( var_f7936e13 )
{
    self gameobjects::allow_use( #"group_none" );
    self gameobjects::set_visible( #"group_none" );
    
    if ( isdefined( var_f7936e13 ) )
    {
        objective_setstate( var_f7936e13, "invisible" );
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 1
// Checksum 0xd5309fcf, Offset: 0x19d8
// Size: 0x9c
function function_d6649915( var_f7936e13 )
{
    self gameobjects::allow_use( #"group_enemy" );
    
    if ( isdefined( var_f7936e13 ) )
    {
        self gameobjects::set_visible( #"group_enemy" );
        objective_setstate( var_f7936e13, "active" );
        return;
    }
    
    self gameobjects::set_visible( #"group_all" );
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 0
// Checksum 0x5114a8a2, Offset: 0x1a80
// Size: 0x192
function function_d2447ce2()
{
    label = self.var_2c327cf8.label;
    assert( isdefined( label ) );
    var_81b5e7e2 = gettime() + int( level.bombtimer * 1000 );
    var_560c82d8 = level.bombtimer;
    
    for ( var_8393596d = 1; isdefined( self ) && var_8393596d ; var_8393596d = 0 )
    {
        result = self waittilltimeout( var_560c82d8, #"hash_60e16ed54a079d38" );
        
        if ( result._notify !== #"timeout" )
        {
            var_270d99db = var_81b5e7e2 - gettime();
            var_560c82d8 = float( var_270d99db ) / 1000;
            function_8fdfe223( label, var_560c82d8, 0 );
            self waittill( #"hash_41c7fc9fe7afac09" );
            var_81b5e7e2 = gettime() + var_270d99db;
            function_8fdfe223( label, var_560c82d8, 1 );
            continue;
        }
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 3
// Checksum 0xd721c94b, Offset: 0x1c20
// Size: 0xbc
function setbomboverheatingafterweaponchange( useobject, overheated, heat )
{
    self endon( #"death", #"disconnect", #"joined_team", #"joined_spectators" );
    waitresult = self waittill( #"weapon_change" );
    
    if ( waitresult.weapon === useobject.useweapon )
    {
        self setweaponoverheating( overheated, heat, waitresult.weapon );
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 2
// Checksum 0x85f35643, Offset: 0x1ce8
// Size: 0x202
function function_5bbda36a( var_2c327cf8, player )
{
    trace = bullettrace( player.origin + ( 0, 0, 20 ), player.origin - ( 0, 0, 2000 ), 0, player );
    tempangle = randomint( 360 );
    forward = ( cos( tempangle ), sin( tempangle ), 0 );
    forward = vectornormalize( forward - vectorscale( trace[ #"normal" ], vectordot( forward, trace[ #"normal" ] ) ) );
    dropangles = vectortoangles( forward );
    dropposition = trace[ #"position" ];
    var_2c327cf8.var_ec427e30 = spawn( "script_model", dropposition );
    var_2c327cf8.var_ec427e30.angles = dropangles;
    var_2c327cf8.var_ec427e30 setmodel( #"wpn_t8_eqp_briefcase_bomb_stow" );
    var_477be7ed = var_2c327cf8.var_477be7ed;
    
    if ( isdefined( var_477be7ed ) )
    {
        trigger = var_477be7ed.trigger;
        
        if ( isdefined( trigger ) )
        {
            var_477be7ed.trigger.origin = dropposition + ( 0, 0, 10 );
        }
    }
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 0
// Checksum 0x36bd4cf, Offset: 0x1ef8
// Size: 0x86, Type: bool
function shouldplayovertimeround()
{
    alliesroundswon = util::getroundswon( #"allies" );
    axisroundswon = util::getroundswon( #"axis" );
    
    if ( game.roundsplayed === level.roundlimit - 1 && alliesroundswon === axisroundswon )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 0
// Checksum 0x731c3f05, Offset: 0x1f88
// Size: 0x46a
function overtime()
{
    var_948752cf = struct::get( "false_alarm_missile_site_overtime", "targetname" );
    assert( isdefined( var_948752cf ) );
    var_67c85b77 = spawn( "trigger_radius_use", var_948752cf.origin + ( 0, 0, 10 ), 0, 140, 150 );
    var_67c85b77 setcursorhint( "HINT_INTERACTIVE_PROMPT" );
    defusetrigger = spawn( "trigger_radius_use", var_948752cf.origin + ( 0, 0, 10 ), 0, 85, 150 );
    defusetrigger setcursorhint( "HINT_INTERACTIVE_PROMPT" );
    model = spawn( "script_model", var_948752cf.origin );
    model.angles = var_948752cf.angles;
    model setmodel( #"hash_7bf8bca264708ab9" );
    var_7139b124 = gameobjects::create_use_object( #"neutral", var_67c85b77, [], ( 0, 0, 0 ), #"hash_3c92bb8662617a67" );
    var_7139b124 gameobjects::allow_use( #"group_all" );
    var_7139b124 gameobjects::set_visible( #"group_all" );
    var_7139b124 gameobjects::set_use_time( level.planttime );
    var_7139b124 gameobjects::function_1b4d64d8( 1 );
    var_7139b124 gameobjects::set_onbeginuse_event( &function_244093f1 );
    var_7139b124 gameobjects::set_onenduse_event( &function_49228915 );
    var_7139b124 gameobjects::set_onuse_event( &function_b10aa510 );
    var_7139b124 gameobjects::set_flags( 1 );
    var_7139b124.useweapon = getweapon( #"briefcase_bomb" );
    var_477be7ed = gameobjects::create_use_object( #"neutral", defusetrigger, [], ( 0, 0, 0 ), #"hash_58554cc940bb1b24" );
    var_477be7ed gameobjects::allow_use( #"group_enemy" );
    var_477be7ed gameobjects::set_use_time( level.defusetime );
    var_477be7ed gameobjects::function_1b4d64d8( 1 );
    var_477be7ed gameobjects::set_onbeginuse_event( &function_9bb9d450 );
    var_477be7ed gameobjects::set_onenduse_event( &function_bf0daf2d );
    var_477be7ed gameobjects::set_onuse_event( &function_6d15a420 );
    var_477be7ed function_c6a01b9b();
    var_477be7ed.useweapon = getweapon( #"briefcase_bomb_defuse" );
    var_2c327cf8 = {};
    var_2c327cf8.var_7139b124 = var_7139b124;
    var_2c327cf8.var_477be7ed = var_477be7ed;
    var_2c327cf8.var_9c9bc75c = 1;
    var_2c327cf8.var_95f894dc = model;
    var_2c327cf8.label = "a";
    var_7139b124.var_2c327cf8 = var_2c327cf8;
    var_477be7ed.var_2c327cf8 = var_2c327cf8;
}

// Namespace namespace_df33b0b/namespace_df33b0b
// Params 3
// Checksum 0x990c9714, Offset: 0x2400
// Size: 0xa4
function function_8fdfe223( label, timeinseconds, flag )
{
    var_22956b1 = toupper( label );
    timems = int( timeinseconds * 1000 );
    setbombtimer( var_22956b1, gettime() + timems );
    setmatchflag( "bomb_timer_" + label, flag );
}

