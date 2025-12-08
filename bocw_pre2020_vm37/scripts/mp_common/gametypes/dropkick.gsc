#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace dropkick;

// Namespace dropkick/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x37673644, Offset: 0x210
// Size: 0x28c
function event_handler[gametype_init] main( *eventstruct )
{
    globallogic::init();
    util::registerroundscorelimit( 0, 10000 );
    level.takelivesondeath = 1;
    level.var_8abcfbb8 = getgametypesetting( #"capturetime" );
    level.carryscore = getgametypesetting( #"carryscore" );
    assert( getgametypesetting( #"idleflagresettime" ) === getgametypesetting( #"bombtimer" ), "<dev string:x38>" );
    level.var_6ecc0fa6 = isdefined( getgametypesetting( #"idleflagresettime" ) ) ? getgametypesetting( #"idleflagresettime" ) : 0;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onrespawndelay = &onrespawndelay;
    level.onendround = &onendround;
    player::function_3c5cc656( &function_610d3790 );
    level.player_team_mask = getteammask( #"allies" );
    level.enemy_team_mask = getteammask( #"axis" );
    spawning::addsupportedspawnpointtype( "dropkick" );
    spawning::addsupportedspawnpointtype( "tdm" );
    spawning::function_32b97d1b( &spawning::function_90dee50d );
    spawning::function_adbbb58a( &spawning::function_c24e290c );
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0xe4a8b04, Offset: 0x4a8
// Size: 0x2c
function onstartgametype()
{
    level thread onscoreclosemusic();
    function_4e92a5e8();
}

// Namespace dropkick/dropkick
// Params 1
// Checksum 0xe3db30d6, Offset: 0x4e0
// Size: 0x34
function onendround( var_c1e98979 )
{
    if ( var_c1e98979 === 3 )
    {
        level thread function_47b8b2cb();
    }
}

// Namespace dropkick/dropkick
// Params 4
// Checksum 0xbb137c16, Offset: 0x520
// Size: 0x126
function function_610d3790( einflictor, victim, *idamage, weapon )
{
    attacker = self;
    
    if ( !isplayer( attacker ) || !isplayer( idamage ) || attacker.pers[ #"team" ] === idamage.pers[ #"team" ] )
    {
        return;
    }
    
    if ( attacker === level.var_1d402358 || idamage === level.var_1d402358 )
    {
        attacker challenges::function_2f462ffd( idamage, weapon, victim, level.var_bb695b91 );
        attacker.pers[ #"objectiveekia" ]++;
        attacker.objectiveekia = attacker.pers[ #"objectiveekia" ];
    }
}

// Namespace dropkick/dropkick
// Params 0, eflags: 0x4
// Checksum 0xb39b8de3, Offset: 0x650
// Size: 0x134
function private function_47b8b2cb()
{
    var_5ac13eb1 = struct::get_array( #"hash_4b493e0124411b31", "targetname" );
    
    if ( var_5ac13eb1.size == 0 )
    {
        var_5ac13eb1[ 0 ] = {};
        var_5ac13eb1[ 0 ].origin = level.mapcenter;
        var_5ac13eb1[ 0 ].angles = ( 0, 0, 0 );
    }
    
    var_a996ef6 = var_5ac13eb1[ randomint( var_5ac13eb1.size ) ];
    origin = var_a996ef6.origin;
    forward = anglestoforward( var_a996ef6.angles );
    up = anglestoup( var_a996ef6.angles );
    playfx( #"hash_76b02047787f0357", origin, forward, up, 1 );
}

// Namespace dropkick/dropkick
// Params 1
// Checksum 0x3a95fe0f, Offset: 0x790
// Size: 0x6c
function onspawnplayer( predictedspawn )
{
    if ( spawning::usestartspawns() && !level.ingraceperiod && !level.playerqueuedrespawn )
    {
        spawning::function_7a87efaa();
    }
    
    spawning::onspawnplayer( predictedspawn );
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0x71655f1a, Offset: 0x808
// Size: 0x44
function onrespawndelay()
{
    carrier = level.var_1d402358;
    
    if ( isdefined( self.team ) && self.team === carrier.team )
    {
        return 5;
    }
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0xb58214fd, Offset: 0x858
// Size: 0x19c
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
        
        foreach ( team, _ in level.teams )
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

// Namespace dropkick/dropkick
// Params 0
// Checksum 0x9fe12869, Offset: 0xa00
// Size: 0x3fc
function function_4e92a5e8()
{
    var_35c5fae0 = struct::get_array( "dropkick_football_location", "targetname" );
    
    if ( var_35c5fae0.size == 0 )
    {
        var_35c5fae0[ 0 ] = {};
        var_35c5fae0[ 0 ].origin = getclosestpointonnavmesh( level.mapcenter, 256, 32 );
        var_35c5fae0[ 0 ].angles = ( 0, 0, 0 );
    }
    
    var_791ffffd = var_35c5fae0[ randomint( var_35c5fae0.size ) ];
    trigger = spawn( "trigger_radius_use", var_791ffffd.origin, 0, 110, 110 );
    trigger triggerignoreteam();
    trigger setvisibletoall();
    trigger setteamfortrigger( #"none" );
    trigger function_682f34cf( -800 );
    trigger.trigger_offset = ( 0, 0, trigger.mins[ 2 ] - trigger.maxs[ 2 ] ) / 2;
    var_e9f2629a = [];
    var_e9f2629a[ 0 ] = spawn( "script_model", var_791ffffd.origin );
    var_e9f2629a[ 0 ] setmodel( #"wpn_t8_eqp_briefcase_bomb_view" );
    var_e9f2629a[ 0 ].angles = var_791ffffd.angles;
    var_4cabc96 = gameobjects::create_carry_object( #"neutral", trigger, var_e9f2629a, ( 0, 0, 0 ), #"dropkick_football" );
    var_4cabc96 gameobjects::allow_carry( #"group_all" );
    var_4cabc96 gameobjects::set_visible( #"group_all" );
    var_4cabc96 gameobjects::set_use_time( level.var_8abcfbb8 );
    var_4cabc96 gameobjects::set_objective_entity( var_4cabc96 );
    var_4cabc96 gameobjects::function_a8c842d6( 1, 1 );
    var_4cabc96 gameobjects::set_onpickup_event( &function_3dbc9c80 );
    var_4cabc96 gameobjects::function_13798243( &function_279b8022 );
    var_4cabc96 gameobjects::set_onbeginuse_event( &onbeginuse );
    var_4cabc96 gameobjects::set_onenduse_event( &onenduse );
    var_4cabc96.onreset = &onreset;
    var_4cabc96.objectiveonself = 1;
    var_4cabc96.allowweapons = 1;
    var_4cabc96.var_22389d70 = 0;
    
    if ( true )
    {
        var_4cabc96.enemyobjid = gameobjects::get_next_obj_id();
        objective_add( var_4cabc96.enemyobjid, "invisible", var_791ffffd.origin, #"hash_7a7d8800746ef2a5" );
    }
    
    level.var_bb695b91 = var_4cabc96;
}

// Namespace dropkick/dropkick
// Params 1
// Checksum 0x1581da10, Offset: 0xe08
// Size: 0x25c
function function_3dbc9c80( player )
{
    assert( isdefined( player ) && isdefined( player.team ) );
    ownerteam = player.team;
    var_4cabc96 = self;
    self gameobjects::set_owner_team( ownerteam );
    self.visuals[ 0 ] notsolid();
    
    if ( isdefined( self.enemyobjid ) )
    {
        self gameobjects::set_visible( #"group_friendly" );
        objective_setstate( self.enemyobjid, "active" );
        objective_setteam( self.enemyobjid, ownerteam );
        function_c939fac4( self.enemyobjid, ownerteam );
        self thread function_6e8c149a();
    }
    else
    {
        self gameobjects::set_visible( #"group_all" );
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger triggerenable( 0 );
    }
    
    player setmovespeedscale( 0.9 );
    player clientfield::set( "ctf_flag_carrier", 1 );
    player function_e9921723();
    player function_30fb31c6( 0 );
    remove_influencers( self, player );
    level.var_6c99ff95 = player influencers::create_entity_influencer( "dropkick_football", level.player_team_mask | level.enemy_team_mask );
    level.var_1d402358 = player;
    self thread function_a7574777();
}

// Namespace dropkick/dropkick
// Params 1
// Checksum 0xd5e84073, Offset: 0x1070
// Size: 0x1cc
function function_279b8022( player )
{
    self notify( #"hash_69b164cea4605785" );
    self gameobjects::set_owner_team( #"neutral" );
    self gameobjects::set_visible( #"group_all" );
    self.visuals[ 0 ] solid();
    
    if ( isdefined( self.enemyobjid ) )
    {
        objective_setvisibletoall( self.enemyobjid );
        objective_setstate( self.enemyobjid, "invisible" );
        objective_setteam( self.enemyobjid, #"none" );
    }
    
    player setmovespeedscale( 1 );
    player clientfield::set( "ctf_flag_carrier", 0 );
    player function_f58ec571();
    player function_30fb31c6( 1 );
    remove_influencers( self, player );
    level.var_adb77100 = self influencers::create_entity_influencer( "dropkick_football", level.player_team_mask | level.enemy_team_mask );
    level.var_1d402358 = undefined;
    self thread function_aa074770();
}

// Namespace dropkick/dropkick
// Params 1
// Checksum 0x9f8f7197, Offset: 0x1248
// Size: 0x24
function onbeginuse( *player )
{
    self function_3f367c2e();
}

// Namespace dropkick/dropkick
// Params 3
// Checksum 0xa86604e7, Offset: 0x1278
// Size: 0x54
function onenduse( *team, *player, success )
{
    if ( !success && self gameobjects::is_object_away_from_home() )
    {
        self thread function_aa074770();
    }
}

// Namespace dropkick/dropkick
// Params 1
// Checksum 0x3931114b, Offset: 0x12d8
// Size: 0x24
function onreset( *previousorigin )
{
    self function_3f367c2e();
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0xd5fd29c4, Offset: 0x1308
// Size: 0x148
function function_a7574777()
{
    self endon( #"hash_69b164cea4605785" );
    
    while ( true )
    {
        wait 1;
        hostmigration::waittillhostmigrationdone();
        team = self gameobjects::get_owner_team();
        
        if ( !isdefined( team ) )
        {
            return;
        }
        
        globallogic_score::giveteamscoreforobjective( team, level.carryscore );
        player = self.carrier;
        
        if ( isdefined( player ) )
        {
            if ( isdefined( player.pers[ #"objtime" ] ) )
            {
                player.pers[ #"objtime" ]++;
                player.objtime = player.pers[ #"objtime" ];
            }
            
            player stats::function_bb7eedf0( #"objective_time", 1 );
            player globallogic_score::incpersstat( #"objectivetime", 1, 0, 1 );
        }
    }
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0x4aac920, Offset: 0x1458
// Size: 0x156
function function_6e8c149a()
{
    self endon( #"hash_69b164cea4605785" );
    
    while ( true )
    {
        carrier = self gameobjects::get_carrier();
        
        if ( !isdefined( self.enemyobjid ) || !isdefined( carrier ) )
        {
            return;
        }
        
        var_e000301a = 0;
        stance = carrier getstance();
        
        if ( stance === "stand" )
        {
            height = 70;
            var_e000301a = height / 1.5;
        }
        else if ( stance === "crouch" )
        {
            height = 50;
            var_e000301a = height / 2;
        }
        else if ( stance === "prone" )
        {
            height = 30;
            var_e000301a = height / 2;
        }
        
        objectiveposition = carrier.origin + ( 0, 0, var_e000301a );
        objective_setposition( self.enemyobjid, objectiveposition );
        wait 3;
    }
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0x54d3899, Offset: 0x15b8
// Size: 0xea
function function_e9921723()
{
    primaryweapon = getweapon( #"pistol_semiauto_t9", "null" );
    self giveweapon( primaryweapon );
    self givestartammo( primaryweapon );
    self setblockweaponpickup( primaryweapon, 1 );
    self switchtoweapon( primaryweapon, 1 );
    self disableweaponcycling();
    self loadout::function_442539( "primary", primaryweapon );
    self.droppeddeathweapon = 1;
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0xfb896260, Offset: 0x16b0
// Size: 0x86
function function_f58ec571()
{
    primaryweapon = getweapon( #"pistol_semiauto_t9", "null" );
    
    if ( self hasweapon( primaryweapon ) )
    {
        self takeweapon( primaryweapon );
    }
    
    self enableweaponcycling();
    self.droppeddeathweapon = undefined;
}

// Namespace dropkick/dropkick
// Params 2
// Checksum 0x9c2f5a81, Offset: 0x1740
// Size: 0x96
function remove_influencers( var_4cabc96, carrier )
{
    if ( isdefined( level.var_adb77100 ) && isdefined( var_4cabc96 ) )
    {
        var_4cabc96 influencers::remove_influencer( level.var_adb77100 );
        level.var_adb77100 = undefined;
    }
    
    if ( isdefined( level.var_6c99ff95 ) && isdefined( carrier ) )
    {
        carrier influencers::remove_influencer( level.var_6c99ff95 );
        level.var_6c99ff95 = undefined;
    }
}

// Namespace dropkick/dropkick
// Params 1
// Checksum 0x4529bed4, Offset: 0x17e0
// Size: 0x5c
function function_30fb31c6( val )
{
    var_3b801af9 = self.gadget_health_regen_weapon;
    
    if ( !isdefined( var_3b801af9 ) )
    {
        return;
    }
    
    if ( !val )
    {
        self lockweapon( var_3b801af9 );
        return;
    }
    
    self unlockweapon( var_3b801af9 );
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0x591822f0, Offset: 0x1848
// Size: 0xb4
function function_aa074770()
{
    self endon( #"hash_656fdc4ee4edf47c" );
    timems = int( level.var_6ecc0fa6 * 1000 );
    setbombtimer( "A", gettime() + timems );
    setmatchflag( "bomb_timer_a", 1 );
    wait level.var_6ecc0fa6;
    
    if ( !isdefined( self.carrier ) )
    {
        self thread gameobjects::return_home();
    }
}

// Namespace dropkick/dropkick
// Params 0
// Checksum 0xad24c62b, Offset: 0x1908
// Size: 0x34
function function_3f367c2e()
{
    self notify( #"hash_656fdc4ee4edf47c" );
    setmatchflag( "bomb_timer_a", 0 );
}

