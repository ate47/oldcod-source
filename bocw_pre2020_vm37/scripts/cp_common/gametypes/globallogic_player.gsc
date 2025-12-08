#using script_725554a59d6a75b9;
#using script_db93c4bbed6e456;
#using scripts\abilities\ability_power;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\weapons_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\gamedifficulty;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_spawn;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\globallogic_utils;
#using scripts\cp_common\gametypes\loadout;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hazard;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x6
// Checksum 0xbe17052c, Offset: 0x898
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"globallogic_player", &preinit, undefined, undefined, undefined );
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x4
// Checksum 0x9752a1ab, Offset: 0x8e0
// Size: 0x94
function private preinit()
{
    level.var_fd81f309 = [ "MOD_PISTOL_BULLET", "MOD_RIFLE_BULLET", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_GRENADE" ];
    clientfield::register( "toplayer", "player_damage_type", 1, 1, "int" );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x67af2dd0, Offset: 0x980
// Size: 0x5c
function function_94865447()
{
    if ( isdefined( level.var_d7d201ba ) && !self flag::exists( level.var_d7d201ba ) )
    {
        self flag::init( level.var_d7d201ba );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 3
// Checksum 0xbce941c1, Offset: 0x9e8
// Size: 0x74
function function_5379a6ca( mapname, var_e29f1b52, var_33ff23e1 )
{
    var_b34e8e96 = self stats::get_stat( #"playerstatsbymap", mapname, var_e29f1b52 );
    
    if ( isdefined( var_b34e8e96 ) )
    {
        self recordcareerstatformap( var_33ff23e1, mapname, var_b34e8e96 );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 3
// Checksum 0xb0d402ba, Offset: 0xa68
// Size: 0x74
function function_20b68a46( mapname, var_e29f1b52, var_33ff23e1 )
{
    var_77b33741 = self stats::get_stat( #"playerstatsbymap", mapname, var_e29f1b52 );
    
    if ( isdefined( var_77b33741 ) )
    {
        self recordcareerflagformap( var_33ff23e1, mapname, var_77b33741 );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xa25e2ae6, Offset: 0xae8
// Size: 0x168
function function_3b6a335b()
{
    if ( !sessionmodeisonlinegame() )
    {
        return;
    }
    
    var_36b17068 = skipto::function_228558fd();
    
    foreach ( mapname in var_36b17068 )
    {
        self function_20b68a46( mapname, "hasBeenCompleted", "completed" );
        self function_5379a6ca( mapname, "firstTimeCompletedUTC", "firstTimeCompleted" );
        self function_5379a6ca( mapname, "lastCompletedUTC", "lastTimeCompleted" );
        self function_5379a6ca( mapname, "numCompletions", "numberTimesCompleted" );
        self function_20b68a46( mapname, "allAccoladesComplete", "allAccoladesComplete" );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xa3802e94, Offset: 0xc58
// Size: 0x21c
function function_eee2a9d2()
{
    if ( !sessionmodeisonlinegame() )
    {
        return;
    }
    
    self function_3b6a335b();
    var_a25c62f6 = self stats::get_stat( #"playerstatslist", #"hash_668c1bd08c419f31", #"statvalue" );
    self recordcareerstat( "duration_total_paused_seconds", var_a25c62f6 );
    var_cf196dd1 = self stats::get_stat( "PlayerStatsList", #"hash_b38ac686f0e8f63", #"statvalue" );
    self recordcareerstat( "duration_total_seconds", var_cf196dd1 );
    var_1ebfb2ab = self stats::get_stat( #"playerstatslist", #"kills", #"statvalue" );
    self recordcareerstat( "kills_Total", var_1ebfb2ab );
    var_d741995b = self stats::get_stat( #"playerstatslist", #"deaths", #"statvalue" );
    self recordcareerstat( "deaths_Total", var_d741995b );
    var_6fa2ecd1 = self stats::get_stat( #"hash_7dd9f1ac62a346d", #"hash_c159a616c8e909f" );
    self recordcareerstat( "deadOps_Total", var_6fa2ecd1 );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xe8291272, Offset: 0xe80
// Size: 0x8c
function init_character_index()
{
    bodytype = 0;
    
    if ( isbot( self ) )
    {
        bodytype = isdefined( player_role::function_c1f61ea2() ) ? player_role::function_c1f61ea2() : 0;
    }
    
    if ( player_role::is_valid( bodytype ) )
    {
        player_role::set( bodytype );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x3b6f0d08, Offset: 0xf18
// Size: 0x10f4
function callback_playerconnect()
{
    function_94865447();
    thread notifyconnecting();
    self.statusicon = "$default";
    self waittill( #"begin" );
    
    if ( isdefined( level.reset_clientdvars ) )
    {
        self [[ level.reset_clientdvars ]]();
    }
    
    if ( isbot( self ) )
    {
        level flag::wait_till( "all_players_connected" );
    }
    
    waittillframeend();
    self.statusicon = "";
    self.guid = self getguid();
    checkpointclear();
    savegame::checkpoint_save();
    self function_d4d27d5b();
    self thread function_f92e23de();
    profilelog_begintiming( 4, "ship" );
    
    if ( self ishost() )
    {
        self thread globallogic::listenforgameend();
    }
    
    if ( !level.splitscreen && !isdefined( self.pers[ #"score" ] ) )
    {
        iprintln( #"mp/connected", self );
    }
    
    if ( !isdefined( self.pers[ #"score" ] ) )
    {
        self thread persistence::adjust_recent_stats();
        self stats::function_7a850245( #"valid", 0 );
    }
    
    self.movementtracking = spawnstruct();
    self thread util::trackwallrunningdistance();
    self thread util::tracksprintdistance();
    self thread util::trackdoublejumpdistance();
    lpselfnum = self getentitynumber();
    lpxuid = self getxuid( 1 );
    bb::function_afcc007d( self.name, lpselfnum, lpxuid );
    init_character_index();
    self val::reset( #"player_connect", "show_hud" );
    self setclientuivisibilityflag( "weapon_hud_visible", 1 );
    
    if ( level.forceradar == 1 )
    {
        self.pers[ #"hasradar" ] = 1;
        level.activeuavs[ self getentitynumber() ] = 1;
    }
    
    if ( level.forceradar == 2 )
    {
        self setclientuivisibilityflag( "g_compassShowEnemies", level.forceradar );
    }
    else
    {
        self setclientuivisibilityflag( "g_compassShowEnemies", 0 );
    }
    
    self setclientplayersprinttime( level.playersprinttime );
    self setclientnumlives( level.numlives );
    self.lives = level.numlives;
    
    if ( level.hardcoremode )
    {
        self setclientdrawtalk( 3 );
    }
    
    self.killedplayerscurrent = [];
    
    if ( !isdefined( self.pers[ #"best_kill_streak" ] ) )
    {
        self.pers[ #"killed_players" ] = [];
        self.pers[ #"killed_by" ] = [];
        self.pers[ #"nemesis_tracking" ] = [];
        self.pers[ #"artillery_kills" ] = 0;
        self.pers[ #"dog_kills" ] = 0;
        self.pers[ #"nemesis_name" ] = "";
        self.pers[ #"nemesis_rank" ] = 0;
        self.pers[ #"nemesis_rankicon" ] = 0;
        self.pers[ #"nemesis_xp" ] = 0;
        self.pers[ #"nemesis_xuid" ] = "";
        self.pers[ #"best_kill_streak" ] = 0;
    }
    
    if ( !isdefined( self.pers[ #"music" ] ) )
    {
        self.pers[ #"music" ] = spawnstruct();
        self.pers[ #"music" ].spawn = 0;
        self.pers[ #"music" ].inque = 0;
        self.pers[ #"music" ].currentstate = "SILENT";
        self.pers[ #"music" ].previousstate = "SILENT";
        self.pers[ #"music" ].nextstate = "UNDERSCORE";
        self.pers[ #"music" ].returnstate = "UNDERSCORE";
    }
    
    self.leaderdialogqueue = [];
    self.leaderdialogactive = 0;
    self.leaderdialoggroups = [];
    self.currentleaderdialoggroup = "";
    self.currentleaderdialog = "";
    self.currentleaderdialogtime = 0;
    
    if ( !isdefined( self.pers[ #"cur_kill_streak" ] ) )
    {
        self.pers[ #"cur_kill_streak" ] = 0;
    }
    
    if ( !isdefined( self.pers[ #"cur_total_kill_streak" ] ) )
    {
        self.pers[ #"cur_total_kill_streak" ] = 0;
        self setplayercurrentstreak( 0 );
    }
    
    if ( !isdefined( self.pers[ #"totalkillstreakcount" ] ) )
    {
        self.pers[ #"totalkillstreakcount" ] = 0;
    }
    
    if ( !isdefined( self.pers[ #"killstreaksearnedthiskillstreak" ] ) )
    {
        self.pers[ #"killstreaksearnedthiskillstreak" ] = 0;
    }
    
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers[ #"killstreak_quantity" ] ) )
    {
        self.pers[ #"killstreak_quantity" ] = [];
    }
    
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers[ #"held_killstreak_ammo_count" ] ) )
    {
        self.pers[ #"held_killstreak_ammo_count" ] = [];
    }
    
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks && !isdefined( self.pers[ #"held_killstreak_clip_count" ] ) )
    {
        self.pers[ #"held_killstreak_clip_count" ] = [];
    }
    
    if ( !isdefined( self.pers[ #"changed_class" ] ) )
    {
        self.pers[ #"changed_class" ] = 0;
    }
    
    self.lastkilltime = 0;
    self.cur_death_streak = 0;
    self disabledeathstreak();
    self.death_streak = 0;
    self.kill_streak = 0;
    self.gametype_kill_streak = 0;
    self.spawnqueueindex = -1;
    self.deathtime = 0;
    player::init_heal( 1, 0 );
    self.lastgrenadesuicidetime = -1;
    self.teamkillsthisround = 0;
    
    if ( isdefined( world.player_lives ) )
    {
        self.pers[ #"lives" ] = world.player_lives;
    }
    else if ( !isdefined( level.livesdonotreset ) || !level.livesdonotreset || !isdefined( self.pers[ #"lives" ] ) )
    {
        self.pers[ #"lives" ] = level.numlives;
    }
    
    self.pers[ #"team" ] = undefined;
    self.hasspawned = 0;
    self.waitingtospawn = 0;
    self.wantsafespawn = 0;
    self.deathcount = 0;
    self.var_c2287847 = gettime();
    self.meleekills = 0;
    self.wasaliveatmatchstart = 0;
    self.grenadesused = 0;
    
    if ( level.splitscreen )
    {
        setdvar( #"splitscreen_playernum", level.players.size );
    }
    
    if ( game.state == "postgame" )
    {
        self.pers[ #"needteam" ] = 1;
        self.pers[ #"team" ] = "spectator";
        self.team = "spectator";
        self.sessionteam = "spectator";
        self val::set( #"player_connect", "show_hud", 0 );
        self [[ level.spawnintermission ]]();
        self closeingamemenu();
        profilelog_endtiming( 4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( level.oldschool )
    {
        self.pers[ #"class" ] = undefined;
        self.curclass = self.pers[ #"class" ];
    }
    
    if ( isdefined( self.pers[ #"team" ] ) )
    {
        self.team = self.pers[ #"team" ];
    }
    
    if ( isdefined( self.pers[ #"class" ] ) )
    {
        self.curclass = self.pers[ #"class" ];
    }
    
    if ( !isdefined( self.pers[ #"team" ] ) || isdefined( self.pers[ #"needteam" ] ) )
    {
        self.pers[ #"needteam" ] = undefined;
        self.pers[ #"team" ] = "spectator";
        self.team = "spectator";
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        [[ level.autoassign ]]( 0 );
        
        if ( level.rankedmatch || level.leaguematch )
        {
            self thread globallogic_spawn::kickifdontspawn();
        }
        
        if ( level.teambased )
        {
            self.sessionteam = self.pers[ #"team" ];
            
            if ( !isalive( self ) )
            {
                self.statusicon = "hud_status_dead";
            }
            
            self thread spectating::set_permissions();
        }
    }
    else
    {
        self.sessionteam = self.pers[ #"team" ];
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        
        if ( globallogic_utils::isvalidclass( self.pers[ #"class" ] ) )
        {
            self thread [[ level.spawnclient ]]();
        }
        else
        {
            self globallogic_ui::showmainmenuforteam();
        }
        
        self thread spectating::set_permissions();
    }
    
    if ( self.sessionteam != "spectator" )
    {
        self [[ level.onspawnplayer ]]( 1 );
    }
    
    profilelog_endtiming( 4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
    
    if ( !isdefined( level.players ) )
    {
        level.players = [];
    }
    else if ( !isarray( level.players ) )
    {
        level.players = array( level.players );
    }
    
    if ( !isinarray( level.players, self ) )
    {
        level.players[ level.players.size ] = self;
    }
    
    level.player = self;
    globallogic::updateteamstatus();
    self function_eee2a9d2();
    var_c0fcc1e2 = self stats::get_stat( #"zmcampaigndata", #"unlocked" );
    level notify( #"connected", { #player:self } );
    callback::callback( #"on_player_connect" );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x9d44fd31, Offset: 0x2018
// Size: 0xf4
function function_d4d27d5b()
{
    incaps = self stats::get_stat( #"playerstatslist", #"incaps", #"statvalue" );
    
    if ( !isdefined( incaps ) )
    {
        incaps = 0;
    }
    
    revives = self stats::get_stat( #"playerstatslist", #"revives", #"statvalue" );
    
    if ( !isdefined( revives ) )
    {
        revives = 0;
    }
    
    self setnoncheckpointdata( "INCAPS", incaps );
    self setnoncheckpointdata( "REVIVES", revives );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xb03cd495, Offset: 0x2118
// Size: 0x480
function function_f92e23de()
{
    self endon( #"disconnect" );
    var_11ffb46 = getrootmapname();
    
    if ( !isdefined( var_11ffb46 ) || is_true( level.disablestattracking ) )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( #"save_restore" );
        var_eeb08e4 = self getnoncheckpointdata( "INCAPS" );
        var_397a145d = self stats::get_stat( #"playerstatslist", #"incaps", #"statvalue" );
        var_ebf6c5c6 = self stats::get_stat( #"playerstatsbymap", var_11ffb46, #"currentstats", #"incaps" );
        
        if ( isdefined( var_eeb08e4 ) )
        {
            assert( var_eeb08e4 >= var_397a145d, "<dev string:x38>" );
            assert( var_eeb08e4 >= var_ebf6c5c6, "<dev string:x59>" );
            self stats::set_stat( #"playerstatslist", #"incaps", #"statvalue", var_eeb08e4 );
            self.incaps = var_eeb08e4 - self stats::get_stat( #"playerstatsbymap", var_11ffb46, #"currentstats", #"incaps" );
            self.pers[ #"incaps" ] = self.incaps;
        }
        
        var_cb9c2ac2 = self getnoncheckpointdata( "REVIVES" );
        var_a25504c0 = self stats::get_stat( #"playerstatslist", #"revives", #"statvalue" );
        var_939d065a = self stats::get_stat( #"playerstatsbymap", var_11ffb46, #"currentstats", #"revives" );
        
        if ( isdefined( var_cb9c2ac2 ) )
        {
            assert( var_cb9c2ac2 >= var_a25504c0, "<dev string:x77>" );
            assert( var_cb9c2ac2 >= var_939d065a, "<dev string:x93>" );
            self stats::set_stat( #"playerstatslist", #"revives", #"statvalue", var_cb9c2ac2 );
            self.revives = var_cb9c2ac2 - self stats::get_stat( #"playerstatsbymap", var_11ffb46, #"currentstats", #"revives" );
            assert( self.revives >= 0 );
            self.pers[ #"revives" ] = self.revives;
        }
        
        var_28f0970b = self getnoncheckpointdata( "lives" );
        
        if ( isdefined( var_28f0970b ) )
        {
            self.lives = var_28f0970b;
            self clearnoncheckpointdata( "lives" );
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x80f724d1, Offset: 0x25a0
// Size: 0x4
function callback_playermigrated()
{
    
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x13bd185f, Offset: 0x25b0
// Size: 0x426
function callback_playerdisconnect()
{
    profilestart();
    profilelog_begintiming( 5, "ship" );
    
    if ( game.state != "postgame" && !level.gameended )
    {
        gamelength = globallogic::getgamelength();
        self globallogic::bbplayermatchend( gamelength, "MP_PLAYER_DISCONNECT", 0 );
    }
    
    checkpointclear();
    savegame::checkpoint_save();
    arrayremovevalue( level.players, self );
    
    if ( level.splitscreen )
    {
        players = level.players;
        
        if ( players.size <= 1 )
        {
            level thread globallogic::forceend();
        }
        
        setdvar( #"splitscreen_playernum", players.size );
    }
    
    if ( isdefined( self.score ) && isdefined( self.pers[ #"team" ] ) )
    {
        /#
            print( "<dev string:xb3>" + self.pers[ #"team" ] + "<dev string:xc3>" + self.score );
        #/
        
        level.dropteam += 1;
    }
    
    [[ level.onplayerdisconnect ]]();
    lpselfnum = self getentitynumber();
    
    for ( entry = 0; entry < level.players.size ; entry++ )
    {
        if ( isdefined( level.players[ entry ].pers[ #"killed_players" ][ self.name ] ) )
        {
            level.players[ entry ].pers[ #"killed_players" ][ self.name ] = undefined;
        }
        
        if ( isdefined( level.players[ entry ].killedplayerscurrent[ self.name ] ) )
        {
            level.players[ entry ].killedplayerscurrent[ self.name ] = undefined;
        }
        
        if ( isdefined( level.players[ entry ].pers[ #"killed_by" ][ self.name ] ) )
        {
            level.players[ entry ].pers[ #"killed_by" ][ self.name ] = undefined;
        }
        
        if ( isdefined( level.players[ entry ].pers[ #"nemesis_tracking" ][ self.name ] ) )
        {
            level.players[ entry ].pers[ #"nemesis_tracking" ][ self.name ] = undefined;
        }
    }
    
    if ( level.gameended )
    {
        self globallogic::removedisconnectedplayerfromplacement();
    }
    
    globallogic::updateteamstatus();
    profilelog_endtiming( 5, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
    self clearallnoncheckpointdata();
    profilestop();
}

// Namespace globallogic_player/globallogic_player
// Params 8
// Checksum 0x63ffdb80, Offset: 0x29e0
// Size: 0xb4
function callback_playermelee( eattacker, *idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind )
{
    hit = 1;
    
    if ( level.teambased && self.team == idamage.team )
    {
        if ( level.friendlyfire == 0 )
        {
            hit = 0;
        }
    }
    
    self finishmeleehit( idamage, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind );
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0x216fda8b, Offset: 0x2aa0
// Size: 0xa4
function function_74b6d714( attacker, effectname, var_894859a2, durationoverride, weapon )
{
    var_20df3f41 = function_1115bceb( effectname );
    
    if ( isdefined( durationoverride ) && durationoverride > 0 )
    {
        duration = durationoverride;
    }
    else
    {
        duration = undefined;
    }
    
    self status_effect::status_effect_apply( var_20df3f41, weapon, attacker, undefined, duration, var_894859a2 );
}

// Namespace globallogic_player/globallogic_player
// Params 7
// Checksum 0xeb11aecc, Offset: 0x2b50
// Size: 0xda
function custom_gamemodes_modified_damage( *victim, eattacker, idamage, smeansofdeath, *weapon, *einflictor, *shitloc )
{
    if ( level.onlinegame && !sessionmodeisprivate() )
    {
        return einflictor;
    }
    
    if ( isdefined( weapon ) && isdefined( weapon.damagemodifier ) )
    {
        einflictor *= weapon.damagemodifier;
    }
    
    if ( shitloc == "MOD_PISTOL_BULLET" || shitloc == "MOD_RIFLE_BULLET" )
    {
        einflictor = int( einflictor * level.bulletdamagescalar );
    }
    
    return einflictor;
}

// Namespace globallogic_player/globallogic_player
// Params 3
// Checksum 0xd06609d7, Offset: 0x2c38
// Size: 0x11a, Type: bool
function function_c2a2b500( victim, dir, smeansofdeath )
{
    var_e3dbc335 = 0.64;
    
    if ( is_true( victim.var_108942e2 ) && isdefined( dir ) )
    {
        if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" )
        {
            axis = undefined;
            
            if ( isplayer( victim ) )
            {
                axis = anglestoaxis( victim getplayerangles() );
            }
            else
            {
                axis = anglestoaxis( victim.angles );
            }
            
            if ( vectordot( dir, axis.forward * -1 ) > var_e3dbc335 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x597bb405, Offset: 0x2d60
// Size: 0xe2
function function_601cae2a( weapon, einflictor )
{
    if ( weapon == level.weaponnone && isdefined( einflictor ) )
    {
        if ( isdefined( einflictor.targetname ) && einflictor.targetname == "explodable_barrel" )
        {
            weapon = getweapon( #"explodable_barrel" );
        }
        else if ( isdefined( einflictor.destructible_type ) && issubstr( einflictor.destructible_type, "vehicle_" ) )
        {
            weapon = getweapon( #"destructible_car" );
        }
    }
    
    return weapon;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0xa5e7da68, Offset: 0x2e50
// Size: 0x1e
function figureoutfriendlyfire( *victim, *eattacker )
{
    return level.friendlyfire;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x8283ae78, Offset: 0x2e78
// Size: 0x4a
function function_4b298d1f( eattacker, weapon )
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
// Params 0
// Checksum 0xdacf98c3, Offset: 0x2ed0
// Size: 0x90
function function_7681dccc()
{
    if ( self isinvehicle() )
    {
        vehicle = self getvehicleoccupied();
        
        if ( isdefined( vehicle ) && isdefined( vehicle.overrideplayerdamage ) )
        {
            return vehicle.overrideplayerdamage;
        }
    }
    
    if ( isdefined( self.overrideplayerdamage ) )
    {
        return self.overrideplayerdamage;
    }
    
    if ( isdefined( level.overrideplayerdamage ) )
    {
        return level.overrideplayerdamage;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 13
// Checksum 0x441c2feb, Offset: 0x2f68
// Size: 0x2244
function callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal )
{
    profilelog_begintiming( 6, "ship" );
    
    if ( game.state == "postgame" )
    {
        return;
    }
    
    if ( self.sessionteam == "spectator" )
    {
        return;
    }
    
    if ( self getinvulnerability() )
    {
        return;
    }
    
    if ( isdefined( self.candocombat ) && !self.candocombat )
    {
        return;
    }
    
    if ( level flag::get( #"chyron_active" ) )
    {
        return;
    }
    
    if ( scene::is_igc_active() && !scene::function_871087b6() )
    {
        return;
    }
    
    if ( self.scene_takedamage === 0 )
    {
        return;
    }
    
    if ( is_true( self.var_977d278d ) )
    {
        return;
    }
    
    if ( is_true( self.b_teleport_invulnerability ) )
    {
        return;
    }
    
    if ( isdefined( eattacker ) && isplayer( eattacker ) && isdefined( eattacker.candocombat ) && !eattacker.candocombat )
    {
        return;
    }
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        return;
    }
    
    if ( smeansofdeath === "MOD_TRIGGER_HURT" && isdefined( einflictor ) && isstring( einflictor.script_hazard ) )
    {
        if ( einflictor.script_hazard != "none" && einflictor.script_hazard != "false" )
        {
            var_e0445c07 = !isplayer( einflictor ) && is_true( einflictor.var_860eee77 );
            hideui = is_true( self.var_ac0c25c9 ) || var_e0445c07;
            hazard::do_damage( einflictor.script_hazard, idamage, einflictor, hideui );
            
            if ( !var_e0445c07 )
            {
                return;
            }
        }
    }
    
    weaponname = weapon.name;
    
    if ( ( weaponname == "ai_tank_drone_gun" || weaponname == "ai_tank_drone_rocket" ) && !level.hardcoremode )
    {
        if ( isdefined( eattacker ) && eattacker == self )
        {
            if ( isdefined( einflictor ) && isdefined( einflictor.from_ai ) )
            {
                return;
            }
        }
        
        if ( isdefined( eattacker ) && isdefined( eattacker.owner ) && eattacker.owner == self )
        {
            return;
        }
    }
    
    if ( weapon.isemp )
    {
        if ( self hasperk( #"specialty_immuneemp" ) )
        {
            return;
        }
        
        self notify( #"emp_grenaded", { #attacker:eattacker, #position:vpoint } );
    }
    
    if ( isdefined( eattacker ) && isplayer( eattacker ) && !weapons::ismeleemod( smeansofdeath ) )
    {
        var_8f516911 = function_b576d3d( weapon, shitloc );
        idamage *= var_8f516911;
    }
    
    overrideplayerdamage = function_7681dccc();
    idamage = int( idamage );
    unmodified = idamage;
    
    if ( isdefined( overrideplayerdamage ) )
    {
        modifieddamage = self [[ overrideplayerdamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
        
        if ( isdefined( modifieddamage ) )
        {
            if ( modifieddamage <= 0 )
            {
                return;
            }
            
            idamage = modifieddamage;
        }
    }
    
    assert( isdefined( idamage ), "<dev string:xc8>" );
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.idflags = idflags;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vpoint = vpoint;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.vdamageorigin = vdamageorigin;
    params.psoffsettime = psoffsettime;
    self.last_damaged_time = level.time;
    self callback::callback( #"on_player_damage", params );
    
    if ( isdefined( eattacker ) )
    {
        idamage = loadout::cac_modified_damage( self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc );
        
        if ( isdefined( modifieddamage ) )
        {
            if ( modifieddamage <= 0 )
            {
                return;
            }
            
            idamage = modifieddamage;
        }
    }
    
    if ( self hasperk( #"specialty_immuneparanoia" ) )
    {
        movementvector = self getvelocity();
        
        if ( lengthsquared( movementvector ) < 2500 )
        {
            idamage *= 0.5;
        }
    }
    
    if ( isdefined( eattacker ) && ( !isplayer( eattacker ) || is_true( isbot( eattacker ) ) ) )
    {
        if ( self flag::get( "player_is_invulnerable" ) && !self function_883dd64( idamage ) )
        {
            idamage = 0;
        }
    }
    
    idamage = custom_gamemodes_modified_damage( self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc );
    idamage = int( idamage );
    self.idflags = idflags;
    self.idflagstime = gettime();
    eattacker = figureoutattacker( eattacker );
    idamage = gamedifficulty::function_2aed7a44( self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath );
    idamage = gamedifficulty::function_23dcd1f6( self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath );
    idamage = int( idamage );
    pixbeginevent( #"hash_5a86c546901702e2" );
    
    if ( !isdefined( vdir ) )
    {
        idflags |= 4;
    }
    
    friendly = 0;
    
    if ( self.health != self.maxhealth )
    {
        self notify( #"hash_3ac4241a987b394f", { #mod:smeansofdeath } );
    }
    
    if ( isdefined( einflictor ) && isdefined( einflictor.script_noteworthy ) )
    {
        if ( einflictor.script_noteworthy == "ragdoll_now" )
        {
            smeansofdeath = "MOD_FALLING";
        }
        
        if ( isdefined( level.overrideweaponfunc ) )
        {
            weapon = [[ level.overrideweaponfunc ]]( weapon, einflictor.script_noteworthy );
        }
    }
    
    if ( weapons::isheadshot( weapon, shitloc, smeansofdeath ) && isplayer( eattacker ) )
    {
        smeansofdeath = "MOD_HEAD_SHOT";
    }
    
    if ( level.onplayerdamage != &globallogic::blank )
    {
        modifieddamage = [[ level.onplayerdamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime );
        
        if ( isdefined( modifieddamage ) )
        {
            if ( modifieddamage <= 0 )
            {
                pixendevent();
                return;
            }
            
            idamage = modifieddamage;
        }
    }
    
    if ( level.onlyheadshots )
    {
        if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" )
        {
            return;
        }
        else if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            idamage = 150;
        }
    }
    
    if ( self player_is_occupant_invulnerable( smeansofdeath ) )
    {
        pixendevent();
        return;
    }
    
    same_team = isdefined( eattacker ) && ( self.team === eattacker.team || util::function_9b7092ef( self.team, eattacker.team ) );
    
    if ( isdefined( eattacker ) && isplayer( eattacker ) && !same_team )
    {
        self.lastattackweapon = weapon;
    }
    
    weapon = function_601cae2a( weapon, einflictor );
    pixendevent();
    
    if ( isdefined( eattacker ) && isai( eattacker ) )
    {
        if ( self.team == eattacker.team && smeansofdeath == "MOD_MELEE" )
        {
            return;
        }
    }
    
    attackerishittingteammate = isplayer( eattacker ) && self util::isenemyplayer( eattacker ) == 0;
    
    if ( shitloc == "riotshield" )
    {
        if ( attackerishittingteammate && level.friendlyfire == 0 )
        {
            return;
        }
        
        if ( ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" ) && !attackerishittingteammate )
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
                    
                    score = rank::getscoreinfovalue( score_event );
                    
                    if ( score > 0 )
                    {
                        self stats::function_e24eec31( level.weaponriotshield, #"score_from_blocked_damage", score );
                    }
                }
            }
        }
        
        if ( idflags & 32 )
        {
            shitloc = "none";
            
            if ( !( idflags & 64 ) )
            {
                idamage *= 0;
            }
        }
        else if ( idflags & 128 )
        {
            if ( isdefined( einflictor ) && isdefined( einflictor.stucktoplayer ) && einflictor.stucktoplayer == self )
            {
                idamage = 101;
            }
            
            shitloc = "none";
        }
        else
        {
            return;
        }
    }
    
    if ( function_c2a2b500( self, vdir, smeansofdeath ) )
    {
        self notify( #"body_shield_damage", params );
        self.var_c3d9d4c9 = 1;
        blockeddamage = 1;
        idamage = 0;
    }
    
    if ( idamage > 0 )
    {
        self thread gamedifficulty::function_fef4c10f( gamedifficulty::function_52f56aea() );
    }
    
    if ( !( idflags & 8192 ) )
    {
        if ( isdefined( einflictor ) && ( smeansofdeath == "MOD_GAS" || weapons::isexplosivedamage( smeansofdeath ) ) )
        {
            if ( ( einflictor.classname == "grenade" || weaponname == "tabun_gas" ) && isdefined( self.lastspawnpoint ) && self.lastspawntime + 3500 > gettime() && distancesquared( einflictor.origin, self.lastspawnpoint.origin ) < 62500 )
            {
                return;
            }
            
            if ( self function_4b298d1f( eattacker, weapon ) )
            {
                return;
            }
            
            self.explosiveinfo = [];
            self.explosiveinfo[ #"damagetime" ] = gettime();
            self.explosiveinfo[ #"damageid" ] = einflictor getentitynumber();
            self.explosiveinfo[ #"originalownerkill" ] = 0;
            self.explosiveinfo[ #"bulletpenetrationkill" ] = 0;
            self.explosiveinfo[ #"chainkill" ] = 0;
            self.explosiveinfo[ #"damageexplosivekill" ] = 0;
            self.explosiveinfo[ #"chainkill" ] = 0;
            self.explosiveinfo[ #"cookedkill" ] = 0;
            self.explosiveinfo[ #"weapon" ] = weapon;
            self.explosiveinfo[ #"originalowner" ] = einflictor.originalowner;
            isfrag = weaponname == "frag_grenade";
            
            if ( isdefined( eattacker ) && eattacker != self )
            {
                if ( isdefined( eattacker ) && isdefined( einflictor.owner ) && ( weapon.name == #"satchel_charge" || weapon.name == #"claymore" || weapon.name == #"bouncingbetty" ) )
                {
                    self.explosiveinfo[ #"originalownerkill" ] = einflictor.owner == self;
                    self.explosiveinfo[ #"damageexplosivekill" ] = isdefined( einflictor.wasdamaged );
                    self.explosiveinfo[ #"chainkill" ] = isdefined( einflictor.waschained );
                    self.explosiveinfo[ #"wasjustplanted" ] = isdefined( einflictor.wasjustplanted );
                    self.explosiveinfo[ #"bulletpenetrationkill" ] = isdefined( einflictor.wasdamagedfrombulletpenetration );
                    self.explosiveinfo[ #"cookedkill" ] = 0;
                }
                
                if ( isdefined( einflictor ) && isdefined( einflictor.stucktoplayer ) && weapon.projexplosiontype == "grenade" )
                {
                    self.explosiveinfo[ #"stucktoplayer" ] = einflictor.stucktoplayer;
                }
                
                if ( weapon.isstun )
                {
                    self.laststunnedby = eattacker;
                    self.laststunnedtime = self.idflagstime;
                }
                
                if ( isdefined( eattacker.lastgrenadesuicidetime ) && eattacker.lastgrenadesuicidetime >= gettime() - 50 && isfrag )
                {
                    self.explosiveinfo[ #"suicidegrenadekill" ] = 1;
                }
                else
                {
                    self.explosiveinfo[ #"suicidegrenadekill" ] = 0;
                }
            }
            
            if ( isfrag )
            {
                self.explosiveinfo[ #"cookedkill" ] = isdefined( einflictor.iscooked );
                self.explosiveinfo[ #"throwbackkill" ] = isdefined( einflictor.throwback );
            }
        }
        
        if ( smeansofdeath == "MOD_IMPACT" && isdefined( eattacker ) && isplayer( eattacker ) && eattacker != self )
        {
            if ( weapon.name == #"hatchet" && isdefined( einflictor ) )
            {
                self.explosiveinfo[ #"projectile_bounced" ] = isdefined( einflictor.bounced );
            }
        }
        
        if ( isplayer( eattacker ) )
        {
            eattacker.pers[ #"participation" ]++;
        }
        
        prevhealthratio = self.health / self.maxhealth;
        
        if ( idamage >= self.health && isdefined( eattacker ) && eattacker != self && !same_team && !isplayer( eattacker ) )
        {
            if ( array::contains( level.var_fd81f309, smeansofdeath ) && self gamedifficulty::function_7dbe6a66() )
            {
                var_1e4afbfd = ( idamage - self.health ) * gamedifficulty::function_eb59c79() / 100;
                
                if ( !self function_883dd64( var_1e4afbfd ) )
                {
                    self gamedifficulty::function_2339ca92();
                    self setnormalhealth( 2 / self.maxhealth );
                    idamage = 1;
                }
            }
        }
        
        if ( weapon.parentweaponname === "riotshield" && self != eattacker && !same_team )
        {
            earthquake( 0.25, 0.1, self.origin, 16, self );
        }
        
        if ( level.teambased && issentient( eattacker ) && self != eattacker && same_team )
        {
            pixmarker( "BEGIN: PlayerDamage player" );
            
            if ( level.friendlyfire == 0 )
            {
                if ( weapon.forcedamageshellshockandrumble )
                {
                    self damageshellshockandrumble( eattacker, einflictor, weapon, smeansofdeath, idamage );
                }
                
                return;
            }
            else if ( level.friendlyfire == 1 )
            {
                if ( idamage < 1 )
                {
                    idamage = 1;
                }
                
                if ( level.friendlyfiredelay && level.friendlyfiredelaytime >= ( gettime() - level.starttime - level.discardtime ) / 1000 )
                {
                    eattacker.lastdamagewasfromenemy = 0;
                    eattacker.friendlydamage = 1;
                    eattacker finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
                    eattacker.friendlydamage = undefined;
                }
                else
                {
                    self.lastdamagewasfromenemy = 0;
                    self finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
                }
            }
            else if ( level.friendlyfire == 2 && isalive( eattacker ) )
            {
                idamage = int( idamage * 0.5 );
                
                if ( idamage < 1 )
                {
                    idamage = 1;
                }
                
                eattacker.lastdamagewasfromenemy = 0;
                eattacker.friendlydamage = 1;
                eattacker finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
                eattacker.friendlydamage = undefined;
            }
            else if ( level.friendlyfire == 3 && isalive( eattacker ) )
            {
                idamage = int( idamage * 0.5 );
                
                if ( idamage < 1 )
                {
                    idamage = 1;
                }
                
                self.lastdamagewasfromenemy = 0;
                eattacker.lastdamagewasfromenemy = 0;
                self finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
                eattacker.friendlydamage = 1;
                eattacker finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
                eattacker.friendlydamage = undefined;
            }
            
            friendly = 1;
            pixmarker( "END: PlayerDamage player" );
        }
        else
        {
            if ( idamage < 1 && !is_true( blockeddamage ) )
            {
                idamage = 1;
            }
            
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
            
            if ( is_true( blockeddamage ) )
            {
                self clientfield::set_to_player( "player_damage_type", 1 );
                self addtodamageindicator( 50, vdir );
            }
            else
            {
                self clientfield::set_to_player( "player_damage_type", 0 );
                self finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
            }
        }
        
        if ( isdefined( eattacker ) && isplayer( eattacker ) && eattacker != self )
        {
            if ( damagefeedback::dodamagefeedback( weapon, einflictor, idamage, smeansofdeath ) )
            {
                if ( idamage > 0 )
                {
                    if ( self.health > 0 )
                    {
                        perkfeedback = function_decf3cb1( self, weapon, smeansofdeath, einflictor );
                    }
                    
                    eattacker thread damagefeedback::update( smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc );
                }
            }
        }
        
        self.hasdonecombat = 1;
    }
    else
    {
        idamage = unmodified;
        self finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
    }
    
    time = gettime();
    regen_gadget = getweapon( #"gadget_health_regen" );
    slot = self gadgetgetslot( regen_gadget );
    
    if ( !isbot( self ) && !self function_8bc54983() && !self scene::is_igc_active() && !self isplayinganimscripted() && !self isinvehicle() && isdefined( slot ) && self gadgetisready( slot ) && self.health - idamage <= 50 && ( !isdefined( self.var_17a87fa6 ) || time >= self.var_17a87fa6 + 15000 ) && ( !isdefined( self.var_40bbb505 ) || self.var_40bbb505 < 3 ) )
    {
        self.var_17a87fa6 = time;
        
        if ( !isdefined( self.var_40bbb505 ) )
        {
            self.var_40bbb505 = 0;
        }
        
        self.var_40bbb505 += 1;
        self thread util::show_hint_text( #"hash_2ad0f26e2ff481b7", 0, "healing_preamble" );
    }
    
    pixbeginevent( #"playerdamage log" );
    
    /#
        if ( getdvarint( #"g_debugdamage", 0 ) )
        {
            if ( isdefined( eattacker.clientid ) )
            {
                println( "<dev string:x104>" + self getentitynumber() + "<dev string:x10f>" + self.health + "<dev string:x11b>" + eattacker.clientid + "<dev string:x129>" + isplayer( einflictor ) + "<dev string:x142>" + idamage + "<dev string:x14e>" + shitloc );
            }
            else if ( isdefined( eattacker ) )
            {
                println( "<dev string:x104>" + self getentitynumber() + "<dev string:x10f>" + self.health + "<dev string:x11b>" + eattacker getentitynumber() + "<dev string:x129>" + isplayer( einflictor ) + "<dev string:x142>" + idamage + "<dev string:x14e>" + shitloc );
            }
            
            loc = anglestoforward( self getplayerangles() ) * 128;
            color = ( 1, 1, 0 );
            dur = 15;
            height = ( 0, 0, 16 );
            
            if ( idamage >= 100 )
            {
                dur = 40;
                color = ( 1, 0, 0 );
                height = ( 0, 0, 32 );
            }
            else if ( idamage < 20 )
            {
                dur = 8;
                height = ( 0, 0, 0 );
                color = ( 0, 0, 1 );
            }
            
            loc += self getorigin() + height;
            print3d( loc, "<dev string:x15a>" + idamage, color, 1, 0.5, dur, 1 );
            
            if ( isdefined( eattacker.origin ) )
            {
                print3d( eattacker.origin + ( 0, 0, 72 ), "<dev string:x15a>" + idamage, color, 1, 1, dur, 1 );
                line( eattacker.origin + ( 0, 0, 72 ), loc, color, 1, 0, dur );
            }
        }
    #/
    
    if ( self.sessionstate != "dead" )
    {
        lpselfnum = self getentitynumber();
        lpselfname = self.name;
        lpselfteam = self.team;
        lpselfguid = self getguid();
        lpattackerteam = "";
        var_5a02d414 = 0;
        
        if ( isplayer( eattacker ) )
        {
            lpattacknum = eattacker getentitynumber();
            var_c8fa9c41 = eattacker getxuid();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.team;
        }
        else
        {
            var_74b485a4 = "world";
            lpattackerteam = "world";
            lpattacknum = -1;
            var_c8fa9c41 = 0;
            lpattackguid = "";
            lpattackname = "";
        }
        
        bb::logdamage( eattacker, self, weapon, idamage, smeansofdeath, shitloc, 0, var_5a02d414 );
    }
    
    pixendevent();
    profilelog_endtiming( 6, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xb42412e5, Offset: 0x51b8
// Size: 0x40, Type: bool
function function_883dd64( idamage )
{
    var_e561f9d9 = gamedifficulty::function_f4052850();
    
    if ( idamage / 100 < var_e561f9d9 )
    {
        return false;
    }
    
    return true;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xcc7d824c, Offset: 0x5200
// Size: 0x74
function player_is_occupant_invulnerable( *smeansofdeath )
{
    if ( self isremotecontrolling() )
    {
        return 0;
    }
    
    if ( !isdefined( level.vehicle_drivers_are_invulnerable ) )
    {
        level.vehicle_drivers_are_invulnerable = 0;
    }
    
    invulnerable = level.vehicle_drivers_are_invulnerable && self vehicle::player_is_driver();
    return invulnerable;
}

// Namespace globallogic_player/globallogic_player
// Params 4
// Checksum 0x68f60e4b, Offset: 0x5280
// Size: 0x12a
function function_decf3cb1( player, weapon, smeansofdeath, einflictor )
{
    perkfeedback = undefined;
    var_88c673cf = loadout::function_88c673cf( player );
    hasflakjacket = player hasperk( #"specialty_flakjacket" );
    isexplosivedamage = weapons::isexplosivedamage( smeansofdeath );
    isflashorstundamage = weapons::isflashorstundamage( weapon, smeansofdeath );
    
    if ( isflashorstundamage && var_88c673cf )
    {
        perkfeedback = "tacticalMask";
    }
    else if ( isexplosivedamage && hasflakjacket && !weapon.ignoresflakjacket && !isaikillstreakdamage( weapon, einflictor ) )
    {
        perkfeedback = "flakjacket";
    }
    
    return perkfeedback;
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x878dc66e, Offset: 0x53b8
// Size: 0x52, Type: bool
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
// Checksum 0x125373ef, Offset: 0x5418
// Size: 0x25c
function finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal )
{
    pixbeginevent( #"finishplayerdamagewrapper" );
    
    if ( !level.console && idflags & 8 && isplayer( eattacker ) )
    {
        println( "<dev string:x15e>" + self getentitynumber() + "<dev string:x10f>" + self.health + "<dev string:x11b>" + eattacker.clientid + "<dev string:x129>" + isplayer( einflictor ) + "<dev string:x142>" + idamage + "<dev string:x14e>" + shitloc );
        eattacker stats::function_dad108fa( #"penetration_shots", 1 );
    }
    
    if ( getdvarstring( #"scr_csmode" ) != "" )
    {
        self shellshock( #"damage_mp", 0.2 );
    }
    
    self damageshellshockandrumble( eattacker, einflictor, weapon, smeansofdeath, idamage );
    self ability_power::power_loss_event_took_damage( eattacker, einflictor, weapon, smeansofdeath, idamage );
    self finishplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
    pixendevent();
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0x163b9591, Offset: 0x5680
// Size: 0x14
function function_c90195f7( *attacker, *weapon )
{
    
}

// Namespace globallogic_player/globallogic_player
// Params 6
// Checksum 0x91dd8caa, Offset: 0x56a0
// Size: 0x25c
function function_4e570d77( attacker, weapon, smeansofdeath, wasinlaststand, var_31498810, inflictor )
{
    if ( isplayer( attacker ) && attacker != self && ( !level.teambased || level.teambased && self.team != attacker.team ) )
    {
        self stats::function_e24eec31( weapon, #"deaths", 1 );
        
        if ( wasinlaststand && isdefined( var_31498810 ) )
        {
            victim_weapon = var_31498810;
        }
        else
        {
            victim_weapon = self.lastdroppableweapon;
        }
        
        if ( isdefined( victim_weapon ) )
        {
            self stats::function_e24eec31( victim_weapon, #"deathsduringuse", 1 );
        }
        
        if ( smeansofdeath != "MOD_FALLING" )
        {
            if ( weapon.name == #"explosive_bolt" && isdefined( inflictor ) && isdefined( inflictor.ownerweaponatlaunch ) && inflictor.owneradsatlaunch )
            {
                attacker stats::function_eec52333( inflictor.ownerweaponatlaunch, #"kills", 1, attacker.class_num, 0, 1 );
            }
            else
            {
                attacker stats::function_eec52333( weapon, #"kills", 1, attacker.class_num );
            }
        }
        
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            attacker stats::function_e24eec31( weapon, #"headshots", 1 );
        }
        
        if ( smeansofdeath == "MOD_PROJECTILE" )
        {
            attacker stats::function_e24eec31( weapon, #"direct_hit_kills", 1 );
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 4
// Checksum 0x72367b8b, Offset: 0x5908
// Size: 0x254
function function_387cd7fb( attacker, einflictor, weapon, smeansofdeath )
{
    if ( !isplayer( attacker ) || self util::isenemyplayer( attacker ) == 0 )
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
        
        if ( level.lastobituaryplayercount >= 4 )
        {
            level notify( #"reset_obituary_count" );
            level.lastobituaryplayercount = 0;
            level.lastobituaryplayer = undefined;
        }
    }
    
    if ( level.teambased && isdefined( attacker.pers ) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0 )
    {
        if ( isplayer( attacker ) && level.gametype === "pvp" )
        {
            obituary( self, self, weapon, smeansofdeath );
        }
        
        demo::kill_bookmark( self, self, einflictor );
        return;
    }
    
    if ( isplayer( attacker ) && level.gametype === "pvp" )
    {
        obituary( self, attacker, weapon, smeansofdeath );
    }
    
    demo::kill_bookmark( self, attacker, einflictor );
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0xe3c6231e, Offset: 0x5b68
// Size: 0x110
function function_f520d796( *einflictor, *attacker, smeansofdeath, *weapon, shitloc )
{
    awardassists = 0;
    
    if ( weapon == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade )
    {
        self.lastgrenadesuicidetime = gettime();
    }
    
    if ( level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides )
    {
        self notify( #"teamkillkicked" );
        self function_a34ff774();
    }
    
    awardassists = 1;
    self.suicide = 1;
    
    if ( isdefined( self.friendlydamage ) )
    {
        self iprintln( #"mp/friendly_fire_will_not" );
    }
    
    return awardassists;
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xa3cb0e75, Offset: 0x5c80
// Size: 0x64
function wait_and_suicide()
{
    self endon( #"disconnect" );
    self val::set( #"suicide", "freezecontrols", 1 );
    wait 0.25;
    self suicide();
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0xc581c506, Offset: 0x5cf0
// Size: 0x46c
function function_2a11f244( einflictor, attacker, smeansofdeath, weapon, *shitloc )
{
    if ( isalive( smeansofdeath ) )
    {
        pixbeginevent( #"killstreak" );
        
        if ( !isdefined( attacker ) || !isdefined( attacker.requireddeathcount ) || smeansofdeath.deathcount == attacker.requireddeathcount )
        {
            smeansofdeath.pers[ #"cur_total_kill_streak" ]++;
            smeansofdeath setplayercurrentstreak( smeansofdeath.pers[ #"cur_total_kill_streak" ] );
            
            if ( isdefined( level.killstreaks ) )
            {
                smeansofdeath.pers[ #"cur_kill_streak" ]++;
                
                if ( smeansofdeath.pers[ #"cur_kill_streak" ] >= 2 )
                {
                    if ( smeansofdeath.pers[ #"cur_kill_streak" ] % 5 == 0 )
                    {
                        smeansofdeath activecamo::function_896ac347( shitloc, "killstreak_5", 1 );
                    }
                    
                    if ( smeansofdeath.pers[ #"cur_kill_streak" ] == 10 )
                    {
                        smeansofdeath challenges::killstreakten();
                    }
                }
            }
        }
        
        pixendevent();
    }
    
    if ( smeansofdeath.pers[ #"cur_kill_streak" ] > smeansofdeath.kill_streak )
    {
        if ( level.rankedmatch && !level.disablestattracking )
        {
            smeansofdeath stats::set_stat( #"higheststats", #"kill_streak", smeansofdeath.pers[ #"totalkillstreakcount" ] );
        }
        
        smeansofdeath.kill_streak = smeansofdeath.pers[ #"cur_kill_streak" ];
    }
    
    if ( smeansofdeath.pers[ #"cur_kill_streak" ] > smeansofdeath.gametype_kill_streak )
    {
        smeansofdeath stats::function_baa25a23( #"kill_streak", smeansofdeath.pers[ #"cur_kill_streak" ] );
        smeansofdeath.gametype_kill_streak = smeansofdeath.pers[ #"cur_kill_streak" ];
    }
    
    if ( weapon == "MOD_HEAD_SHOT" )
    {
    }
    else if ( weapon == "MOD_MELEE" || weapon == "MOD_MELEE_ASSASSINATE" )
    {
        if ( shitloc.isriotshield )
        {
            if ( isdefined( smeansofdeath.class_num ) )
            {
                var_6fa230fd = smeansofdeath getloadoutitem( smeansofdeath.class_num, "primary" );
                var_1997cb6f = smeansofdeath getloadoutitem( smeansofdeath.class_num, "secondary" );
                
                if ( var_6fa230fd && level.tbl_weaponids[ var_6fa230fd ][ #"reference" ] == "riotshield" && !var_1997cb6f || var_1997cb6f && level.tbl_weaponids[ var_1997cb6f ][ #"reference" ] == "riotshield" && !var_6fa230fd )
                {
                    smeansofdeath stats::function_e24eec31( shitloc, #"hash_63e17b42eb7cb8f5", 1 );
                }
            }
        }
    }
    
    attackername = smeansofdeath.name;
    self thread medals::setlastkilledby( smeansofdeath, attacker );
}

// Namespace globallogic_player/globallogic_player
// Params 9
// Checksum 0x3a69d851, Offset: 0x6168
// Size: 0x1c76
function callback_playerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    profilelog_begintiming( 7, "ship" );
    self endon( #"spawned" );
    self notify( #"killed_player" );
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = attacker;
    params.idamage = idamage;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.psoffsettime = psoffsettime;
    params.deathanimduration = deathanimduration;
    self callback::callback( #"on_player_killed", params );
    self flag::clear( #"loadout_given" );
    
    if ( self.sessionteam == "spectator" )
    {
        return;
    }
    
    if ( game.state == "postgame" )
    {
        return;
    }
    
    self needsrevive( 0 );
    
    if ( isdefined( self.revivetrigger ) )
    {
        self.revivetrigger delete();
    }
    
    self.revivetrigger = undefined;
    
    if ( isdefined( self.burning ) && self.burning == 1 )
    {
        self setburn( 0 );
    }
    
    self.canbemeleed = 1;
    self.suicide = 0;
    self.teamkilled = 0;
    self.meleeattackers = undefined;
    
    if ( isdefined( level.takelivesondeath ) && level.takelivesondeath == 1 )
    {
        if ( self.pers[ #"lives" ] )
        {
            self.pers[ #"lives" ]--;
            
            if ( self.pers[ #"lives" ] == 0 )
            {
                level notify( #"player_eliminated" );
                self notify( #"player_eliminated" );
            }
        }
    }
    
    weapon = updateweapon( einflictor, weapon );
    pixbeginevent( #"hash_47eb123ec5413349" );
    wasinlaststand = 0;
    deathtimeoffset = 0;
    var_31498810 = undefined;
    attackerstance = undefined;
    self.laststandthislife = undefined;
    self.vattackerorigin = undefined;
    
    if ( isdefined( self.uselaststandparams ) )
    {
        self.uselaststandparams = undefined;
        assert( isdefined( self.laststandparams ) );
        
        if ( !level.teambased || isdefined( self.laststandparams ) && ( !isdefined( attacker ) || !isplayer( attacker ) || attacker.team != self.team || attacker == self ) )
        {
            einflictor = self.laststandparams.einflictor;
            attacker = self.laststandparams.attacker;
            attackerstance = self.laststandparams.attackerstance;
            idamage = self.laststandparams.idamage;
            smeansofdeath = self.laststandparams.smeansofdeath;
            weapon = self.laststandparams.weapon;
            vdir = self.laststandparams.vdir;
            shitloc = self.laststandparams.shitloc;
            self.vattackerorigin = self.laststandparams.vattackerorigin;
            deathtimeoffset = ( gettime() - self.laststandparams.laststandstarttime ) / 1000;
            self.bleedout_time = math::clamp( self.var_84c0402e - deathtimeoffset, 0, self.var_84c0402e );
            
            if ( isdefined( self.var_f68bf742 ) )
            {
                wasinlaststand = 1;
                var_31498810 = self.var_f68bf742;
            }
            
            params.einflictor = einflictor;
            params.eattacker = attacker;
            params.idamage = idamage;
            params.smeansofdeath = smeansofdeath;
            params.weapon = weapon;
            params.vdir = vdir;
            params.shitloc = shitloc;
            self callback::callback( #"on_player_killed", params );
        }
        
        self.laststandparams = undefined;
    }
    
    bestplayer = undefined;
    bestplayermeansofdeath = undefined;
    obituarymeansofdeath = undefined;
    bestplayerweapon = undefined;
    obituaryweapon = weapon;
    assistedsuicide = 0;
    
    if ( ( !isdefined( attacker ) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || isdefined( attacker.ismagicbullet ) && attacker.ismagicbullet == 1 || attacker == self ) && isdefined( self.attackers ) )
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
                
                if ( player == self || level.teambased && player.team == self.team )
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
    
    self.deathtime = gettime();
    self.pers[ #"deathtime" ] = self.deathtime;
    attacker = function_ff093620( attacker, weapon );
    einflictor = function_f67af024( einflictor );
    smeansofdeath = self function_eedaefc( attacker, einflictor, weapon, smeansofdeath, shitloc );
    
    if ( !isdefined( obituarymeansofdeath ) )
    {
        obituarymeansofdeath = smeansofdeath;
    }
    
    if ( isdefined( self.hasriotshieldequipped ) && self.hasriotshieldequipped == 1 )
    {
        self.hasriotshield = 0;
        self.hasriotshieldequipped = 0;
    }
    
    self thread function_b709e8b8();
    self function_4e570d77( attacker, weapon, smeansofdeath, wasinlaststand, var_31498810, einflictor );
    self function_387cd7fb( attacker, einflictor, obituaryweapon, obituarymeansofdeath );
    self.sessionstate = "dead";
    self.statusicon = "hud_status_dead";
    self.pers[ #"weapon" ] = undefined;
    self.killedplayerscurrent = [];
    
    if ( !isdefined( self.deathcount ) )
    {
        self.deathcount = 0;
    }
    
    self.deathcount++;
    println( "<dev string:x16d>" + self.clientid + "<dev string:x179>" + self.deathcount );
    self function_c90195f7( attacker, weapon );
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpattackguid = "";
    lpattackname = "";
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackteam = "";
    lpattacknum = -1;
    var_c8fa9c41 = 0;
    wasteamkill = 0;
    wassuicide = 0;
    pixendevent();
    
    if ( isplayer( attacker ) )
    {
        lpattackguid = attacker getguid();
        lpattackname = attacker.name;
        lpattackteam = attacker.team;
        
        if ( attacker == self || assistedsuicide == 1 )
        {
            dokillcam = 0;
            wassuicide = 1;
            self function_f520d796( einflictor, attacker, smeansofdeath, weapon, shitloc );
        }
        else
        {
            pixbeginevent( #"hash_3c7e54851be0668" );
            lpattacknum = attacker getentitynumber();
            var_c8fa9c41 = attacker getxuid();
            dokillcam = 1;
            
            if ( level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0 )
            {
            }
            else
            {
                self function_2a11f244( einflictor, attacker, smeansofdeath, weapon, shitloc );
            }
            
            pixendevent();
        }
    }
    else if ( isdefined( attacker ) && ( attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" ) )
    {
        dokillcam = 0;
        lpattacknum = -1;
        var_c8fa9c41 = 0;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        self.suicides = 0;
        self.suicide = 1;
        
        if ( level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides )
        {
            self notify( #"teamkillkicked" );
            self function_a34ff774();
        }
    }
    else
    {
        dokillcam = 0;
        lpattacknum = -1;
        var_c8fa9c41 = 0;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        wassuicide = 1;
        
        if ( isdefined( einflictor ) && isdefined( einflictor.killcament ) )
        {
            lpattacknum = self getentitynumber();
            var_c8fa9c41 = self getxuid();
            wassuicide = 0;
        }
        
        if ( isdefined( attacker ) && isdefined( attacker.team ) && isdefined( level.teams[ attacker.team ] ) )
        {
            if ( attacker.team != self.team )
            {
                wassuicide = 0;
            }
        }
        
        if ( isai( attacker ) )
        {
            dokillcam = 1;
            lpattacknum = self getentitynumber();
            var_c8fa9c41 = 0;
        }
    }
    
    if ( !level.ingraceperiod )
    {
        if ( smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_EXPLOSIVE_SPLASH" && smeansofdeath != "MOD_PROJECTILE_SPLASH" )
        {
            self weapons::drop_scavenger_for_death( attacker );
        }
        
        if ( !wasteamkill && !wassuicide )
        {
            self weapons::drop_for_death( attacker, weapon, smeansofdeath );
        }
    }
    
    if ( !wasteamkill && !wassuicide )
    {
        self weapons::drop_for_death( attacker, weapon, smeansofdeath );
    }
    
    pixbeginevent( #"hash_6f37a114f9261138" );
    self.lastattacker = attacker;
    self.lastdeathpos = self.origin;
    
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker != self && ( !level.teambased || attacker.team != self.team ) )
    {
        self thread challenges::playerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance );
    }
    else
    {
        self notify( #"playerkilledchallengesprocessed" );
    }
    
    if ( isdefined( self.attackers ) )
    {
        self.attackers = [];
    }
    
    bb::logdamage( attacker, self, weapon, idamage, smeansofdeath, shitloc, 1, !wasinlaststand );
    bb::function_cd497743( "death", self );
    attackerstring = "none";
    
    if ( isplayer( attacker ) )
    {
        attackerstring = attacker getxuid() + "(" + lpattackname + ")";
    }
    
    println( "<dev string:x18f>" + smeansofdeath + "<dev string:x195>" + weapon.name + "<dev string:x19a>" + attackerstring + "<dev string:x1a2>" + idamage + "<dev string:x1a9>" + shitloc + "<dev string:x1b0>" + int( self.origin[ 0 ] ) + "<dev string:x1b7>" + int( self.origin[ 1 ] ) + "<dev string:x1b7>" + int( self.origin[ 2 ] ) );
    globallogic::updateteamstatus();
    self weapons::detach_carry_object_model();
    var_adfdd617 = 0;
    
    if ( is_true( self.var_78ca5055 ) )
    {
        var_adfdd617 = 1;
    }
    
    if ( isdefined( self.diedonvehicle ) )
    {
        var_adfdd617 = self.diedonvehicle;
    }
    
    var_11e21728 = 0;
    
    if ( isdefined( attacker ) && isdefined( attacker.targetname ) && attacker.targetname == "train" )
    {
        var_11e21728 = 1;
    }
    
    pixendevent();
    var_2a8c097d = function_58385b58( self.team );
    pixbeginevent( #"hash_6a07afbdee38d766" );
    
    if ( !var_adfdd617 && !var_11e21728 && ( !is_true( level.var_6cc58e4b ) || level.players.size > 1 ) )
    {
        vattackerorigin = undefined;
        
        if ( isdefined( attacker ) )
        {
            vattackerorigin = attacker.origin;
        }
        
        ragdoll_now = 0;
        
        if ( isdefined( self.usingvehicle ) && self.usingvehicle && isdefined( self.vehicleposition ) && self.vehicleposition == 1 )
        {
            ragdoll_now = 1;
        }
        
        var_d26b2156 = 0;
        
        if ( !attacker isonground() && smeansofdeath == "MOD_MELEE_ASSASSINATE" )
        {
            var_d26b2156 = 1;
        }
        
        body = self cloneplayer( deathanimduration, weapon, attacker, vdir );
        
        if ( isdefined( body ) )
        {
            self function_c29ad5cf( idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body, var_d26b2156 );
            self.var_f8271fa3 = body;
            
            if ( var_2a8c097d.size == 0 )
            {
                self battlechatter::play_death_vox( body, attacker, weapon, smeansofdeath );
            }
        }
    }
    
    pixendevent();
    thread globallogic_spawn::spawnqueuedclient( self.team, attacker );
    self.switching_teams = undefined;
    self.joining_team = undefined;
    self.leaving_team = undefined;
    self thread [[ level.onplayerkilled ]]( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
    
    for ( var_63f2aecc = 0; var_63f2aecc < level.onplayerkilledextraunthreadedcbs.size ; var_63f2aecc++ )
    {
        self [[ level.onplayerkilledextraunthreadedcbs[ var_63f2aecc ] ]]( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
    }
    
    self.wantsafespawn = 0;
    perks = [];
    killstreaks = globallogic::getkillstreaks( attacker );
    
    if ( !isdefined( self.var_52d662a9 ) )
    {
        self thread [[ level.spawnplayerprediction ]]();
    }
    
    profilelog_endtiming( 7, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame() );
    
    if ( !is_true( level.var_6cc58e4b ) || level.players.size > 1 )
    {
        defaultplayerdeathwatchtime = 4;
        
        if ( getdvarint( #"hash_62b8db0428755a32", 1 ) )
        {
            defaultplayerdeathwatchtime = getdvarfloat( #"defaultplayerdeathwatchtime", 2.5 );
        }
        
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
        
        if ( is_true( var_adfdd617 ) )
        {
            defaultplayerdeathwatchtime = 2;
            player_pos = self getplayercamerapos();
            var_cac40761 = self getplayerangles();
            
            if ( isdefined( self.var_80730518 ) )
            {
                camera_pos = self.var_80730518 gettagorigin( "tag_driver_camera" );
                
                if ( isdefined( camera_pos ) )
                {
                    player_pos = camera_pos;
                }
                
                var_cac40761 = self.var_80730518.angles;
            }
            
            self camerasetposition( player_pos, var_cac40761 );
            self cameraactivate( 1 );
            self healthoverlay::function_8335b12();
            self thread lui::screen_fade_out( defaultplayerdeathwatchtime, "black" );
            
            if ( isdefined( self.var_80730518 ) )
            {
                if ( is_true( self.var_80730518.var_4dba1441 ) )
                {
                    wait 0.3;
                    
                    if ( !isbot( self ) )
                    {
                        self.var_80730518 setinvisibletoall();
                        self.var_80730518 setvisibletoplayer( self );
                    }
                }
            }
        }
        
        wait defaultplayerdeathwatchtime;
        
        if ( is_true( var_adfdd617 ) )
        {
            self cameraactivate( 0 );
        }
    }
    else
    {
        if ( isdefined( body ) )
        {
            codesetclientfield( body, "hide_body", 1 );
        }
        
        self stats::function_dad108fa( #"incaps", 1 );
        var_787cae74 = self stats::get_stat( #"playerstatslist", #"incaps", #"statvalue" );
        self setnoncheckpointdata( "INCAPS", var_787cae74 );
        
        if ( !is_true( self.var_f5ebfda9 ) )
        {
            namespace_5443b356::function_906e8496( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
        }
        
        self waittilltimeout( 5, #"hash_eb0317ca3976bf9" );
    }
    
    self notify( #"death_delay_finished" );
    forcekillcam = 0;
    
    /#
        if ( getdvarint( #"scr_forcekillcam", 0 ) != 0 )
        {
            dokillcam = 1;
            forcekillcam = 1;
            
            if ( lpattacknum < 0 )
            {
                lpattacknum = self getentitynumber();
                var_c8fa9c41 = 0;
            }
        }
    #/
    
    self.respawntimerstarttime = gettime();
    
    if ( is_true( self.var_e36aebf2 ) )
    {
        self waittilltimeout( 5, #"hash_4bd20f5c626eb3f0" );
        self.var_e36aebf2 = undefined;
        return;
    }
    
    if ( game.state != "playing" )
    {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        return;
    }
    
    function_a6c8cee1();
    userespawntime = 1;
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        userespawntime = 0;
    }
    
    if ( isdefined( level.var_5be43b2d ) )
    {
        return;
    }
    
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
// Checksum 0x3f9c0c10, Offset: 0x7de8
// Size: 0x28
function function_b709e8b8()
{
    if ( isbot( self ) )
    {
        level.globallarryskilled++;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xbeaec7bc, Offset: 0x7e18
// Size: 0xd0
function function_a6c8cee1()
{
    if ( isdefined( self.var_52d662a9 ) )
    {
        starttime = gettime();
        waittime = self.var_52d662a9 * 1000;
        
        while ( gettime() < starttime + waittime && isdefined( self.var_52d662a9 ) )
        {
            wait 0.1;
        }
        
        var_5172a3b5 = 1;
        self.var_52d662a9 = undefined;
    }
    else if ( isdefined( self.killstreak_delay_killcam ) )
    {
        while ( isdefined( self.killstreak_delay_killcam ) )
        {
            wait 0.1;
        }
        
        var_5172a3b5 = 1;
    }
    
    if ( is_true( var_5172a3b5 ) )
    {
        wait 2;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xb151e9a3, Offset: 0x7ef0
// Size: 0x54
function function_a34ff774()
{
    self endon( #"disconnect" );
    waittillframeend();
    globallogic::gamehistoryplayerkicked();
    ban( self getentitynumber() );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0xb99934a1, Offset: 0x7f50
// Size: 0x1d4
function function_5d8aa031()
{
    self endon( #"disconnect" );
    waittillframeend();
    playlistbanquantum = tweakables::gettweakablevalue( "team", "teamkillerplaylistbanquantum" );
    playlistbanpenalty = tweakables::gettweakablevalue( "team", "teamkillerplaylistbanpenalty" );
    
    if ( playlistbanquantum > 0 && playlistbanpenalty > 0 )
    {
        timeplayedtotal = self stats::get_stat( #"playerstatslist", #"time_played_total", #"statvalue" );
        minutesplayed = timeplayedtotal / 60;
        freebees = 2;
        banallowance = int( floor( minutesplayed / playlistbanquantum ) ) + freebees;
        
        if ( self.sessionbans > banallowance )
        {
            self stats::set_stat( #"playerstatslist", #"gametypeban", #"statvalue", timeplayedtotal + playlistbanpenalty * 60 );
        }
    }
    
    globallogic::gamehistoryplayerkicked();
    ban( self getentitynumber() );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x454ca204, Offset: 0x8130
// Size: 0x7c
function teamkilldelay()
{
    teamkills = self.pers[ #"teamkills_nostats" ];
    
    if ( level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills )
    {
        return 0;
    }
    
    exceeded = teamkills - level.minimumallowedteamkills;
    return level.teamkillspawndelay * exceeded;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xc9f74d38, Offset: 0x81b8
// Size: 0x74, Type: bool
function function_c725caa8( teamkilldelay )
{
    if ( teamkilldelay && level.minimumallowedteamkills >= 0 )
    {
        if ( globallogic_utils::gettimepassed() >= 5000 )
        {
            return true;
        }
        
        if ( self.pers[ #"teamkills_nostats" ] > 1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x59938839, Offset: 0x8238
// Size: 0xda
function function_da080186()
{
    timeperoneteamkillreduction = 20;
    reductionpersecond = 1 / timeperoneteamkillreduction;
    
    while ( true )
    {
        if ( isalive( self ) )
        {
            self.pers[ #"teamkills_nostats" ] -= reductionpersecond;
            
            if ( self.pers[ #"teamkills_nostats" ] < level.minimumallowedteamkills )
            {
                self.pers[ #"teamkills_nostats" ] = level.minimumallowedteamkills;
                break;
            }
        }
        
        wait 1;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 9
// Checksum 0x9301621e, Offset: 0x8320
// Size: 0x4c
function callback_playerlaststand( *einflictor, *eattacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime, *delayoverride )
{
    
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0xcd66845e, Offset: 0x8378
// Size: 0x6c
function damageshellshockandrumble( eattacker, einflictor, weapon, smeansofdeath, idamage )
{
    self thread weapons::on_damage( eattacker, einflictor, weapon, smeansofdeath, idamage );
    self playrumbleonentity( "damage_heavy" );
}

// Namespace globallogic_player/globallogic_player
// Params 11
// Checksum 0x873a6a6, Offset: 0x83f0
// Size: 0x2d4
function function_c29ad5cf( idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body, var_d26b2156 )
{
    if ( smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone" )
    {
        self.body = body;
        return;
    }
    
    if ( isdefined( level.ragdoll_override ) && self [[ level.ragdoll_override ]]( idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body ) )
    {
        return;
    }
    
    if ( ragdoll_jib || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT" )
    {
        body startragdoll();
    }
    
    if ( !self isonground() )
    {
        if ( getdvarint( #"scr_disable_air_death_ragdoll", 0 ) == 0 )
        {
            body startragdoll();
        }
    }
    
    if ( smeansofdeath == "MOD_MELEE_ASSASSINATE" && isdefined( var_d26b2156 ) && var_d26b2156 )
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
    params = spawnstruct();
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    self.body callback::callback( #"on_player_corpse", params );
}

// Namespace globallogic_player/globallogic_player
// Params 2
// Checksum 0xfe16574e, Offset: 0x86d0
// Size: 0xb2, Type: bool
function is_explosive_ragdoll( weapon, inflictor )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    if ( weapon.name == #"destructible_car" || weapon.name == #"explodable_barrel" )
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
// Checksum 0xe129308e, Offset: 0x8790
// Size: 0x1a4
function start_explosive_ragdoll( dir, weapon )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    x = randomintrange( 50, 100 );
    y = randomintrange( 50, 100 );
    z = randomintrange( 10, 20 );
    
    if ( isdefined( weapon ) && ( weapon.name == #"sticky_grenade" || weapon.name == #"explosive_bolt" ) )
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
// Checksum 0xaeabde9, Offset: 0x8940
// Size: 0x4c
function start_death_from_above_ragdoll( *dir )
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
// Checksum 0xca91667e, Offset: 0x8998
// Size: 0x5c
function notifyconnecting()
{
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        level notify( #"connecting", { #player:self } );
        callback::callback( #"on_player_connecting" );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 6
// Checksum 0xedd712a2, Offset: 0x8a00
// Size: 0x31c
function delaystartragdoll( ent, shitloc, vdir, *weapon, *einflictor, smeansofdeath )
{
    if ( isdefined( vdir ) )
    {
        deathanim = vdir getcorpseanim();
        
        if ( isdefined( deathanim ) && animhasnotetrack( deathanim, "ignore_ragdoll" ) )
        {
            return;
        }
    }
    
    if ( level.oldschool )
    {
        if ( !isdefined( einflictor ) )
        {
            einflictor = ( 0, 0, 0 );
        }
        
        explosionpos = vdir.origin + ( 0, 0, globallogic_utils::gethitlocheight( weapon ) );
        explosionpos -= einflictor * 20;
        explosionradius = 40;
        var_10fb361d = 0.75;
        
        if ( smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_EXPLOSIVE" || issubstr( smeansofdeath, "MOD_GRENADE" ) || issubstr( smeansofdeath, "MOD_PROJECTILE" ) || weapon == "head" || weapon == "helmet" )
        {
            var_10fb361d = 2.5;
        }
        
        vdir startragdoll( 1 );
        waitframe( 1 );
        
        if ( !isdefined( vdir ) )
        {
            return;
        }
        
        physicsexplosionsphere( explosionpos, explosionradius, explosionradius / 2, var_10fb361d );
        return;
    }
    
    wait 0.2;
    
    if ( !isdefined( vdir ) )
    {
        return;
    }
    
    if ( vdir isragdoll() )
    {
        return;
    }
    
    deathanim = vdir getcorpseanim();
    
    if ( isdefined( deathanim ) && animhasnotetrack( deathanim, "ignore_ragdoll" ) )
    {
        return;
    }
    
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
    wait waittime;
    
    if ( isdefined( vdir ) )
    {
        vdir startragdoll( 1 );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 5
// Checksum 0x990bddda, Offset: 0x8d28
// Size: 0xe6
function function_eedaefc( attacker, *einflictor, weapon, smeansofdeath, shitloc )
{
    if ( weapons::isheadshot( weapon, shitloc, smeansofdeath ) && isplayer( einflictor ) )
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
// Checksum 0xbb0722d0, Offset: 0x8e18
// Size: 0x204
function function_ff093620( attacker, weapon )
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
    
    if ( isdefined( attacker ) && isdefined( weapon ) && weapon.statname == #"planemortar" )
    {
        if ( !isdefined( attacker.planemortarbda ) )
        {
            attacker.planemortarbda = 0;
        }
        
        attacker.planemortarbda++;
    }
    
    if ( isdefined( attacker ) && isdefined( weapon ) && ( weapon.name == #"straferun_rockets" || weapon.name == #"straferun_gun" ) )
    {
        if ( isdefined( attacker.straferunbda ) )
        {
            attacker.straferunbda++;
        }
    }
    
    return attacker;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0x6804a025, Offset: 0x9028
// Size: 0x78
function function_f67af024( einflictor )
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
// Checksum 0x6fd70104, Offset: 0x90a8
// Size: 0xe2
function updateweapon( einflictor, weapon )
{
    if ( weapon == level.weaponnone && isdefined( einflictor ) )
    {
        if ( isdefined( einflictor.targetname ) && einflictor.targetname == "explodable_barrel" )
        {
            weapon = getweapon( #"explodable_barrel" );
        }
        else if ( isdefined( einflictor.destructible_type ) && issubstr( einflictor.destructible_type, "vehicle_" ) )
        {
            weapon = getweapon( #"destructible_car" );
        }
    }
    
    return weapon;
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x9d8c26fb, Offset: 0x9198
// Size: 0x19c
function function_4d3e38fb()
{
    if ( self == level )
    {
        foreach ( player in level.players )
        {
            player function_4d3e38fb();
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        a_w_weapons = self getweaponslist();
        
        foreach ( weapon in a_w_weapons )
        {
            if ( is_true( weapon.isheavyweapon ) )
            {
                self savegame::set_player_data( savegame::function_8136eb5a() + "heavy_weapon", weapon.name );
                break;
            }
        }
    }
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x4
// Checksum 0xffff7bb7, Offset: 0x9340
// Size: 0x94
function private function_c674fc77( statname )
{
    var_c0b8f5fd = self stats::get_stat( #"playerstatsbymap", getrootmapname(), #"currentstats", statname );
    var_65442406 = self stats::get_stat( #"playerstatslist", statname, #"statvalue" );
    return var_65442406 - var_c0b8f5fd;
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0xfa79c07a, Offset: 0x93e0
// Size: 0x40c
function function_4b78690e( current_map )
{
    if ( !isdefined( current_map ) )
    {
        return;
    }
    
    for ( i = 1; i < 58 ; i++ )
    {
        var_813ca5ee = self getcurrentgunrank( i );
        
        if ( !isdefined( var_813ca5ee ) )
        {
            var_813ca5ee = 0;
        }
        
        self stats::set_stat( #"currentweaponlevels", i, var_813ca5ee );
    }
    
    var_e461ad1 = self stats::get_stat( #"playerstatslist", #"rankxp", #"statvalue" );
    self stats::set_stat( #"hash_6dcaad4976588a44", var_e461ad1 );
    var_797451ed = [];
    array::add( var_797451ed, "KILLS" );
    array::add( var_797451ed, "SCORE" );
    array::add( var_797451ed, "ASSISTS" );
    array::add( var_797451ed, "INCAPS" );
    array::add( var_797451ed, "REVIVES" );
    
    foreach ( stat in var_797451ed )
    {
        statvalue = self stats::get_stat( #"playerstatslist", stat, #"statvalue" );
        self stats::set_stat( #"playerstatsbymap", current_map, #"currentstats", stat, statvalue );
    }
    
    for ( i = 0; i < 6 ; i++ )
    {
        var_b69c01aa = self stats::get_stat( #"playerstatsbymap", current_map, #"hash_1e0160af4fd80dff", i );
        self stats::set_stat( #"playerstatsbymap", current_map, #"hash_518113a79b08988", i, var_b69c01aa );
        var_3f6b581d = self stats::get_stat( #"playerstatsbymap", current_map, #"hash_657891d65d881524", i );
        self stats::set_stat( #"playerstatsbymap", current_map, #"hash_233621878f97486b", i, var_3f6b581d );
    }
    
    for ( i = 0; i < 20 ; i++ )
    {
        var_d8bb48fd = self stats::get_stat( #"playercpdecorations", i );
        self stats::set_stat( #"hash_711b1260308620e7", i, var_d8bb48fd );
    }
    
    uploadstats( self );
}

// Namespace globallogic_player/globallogic_player
// Params 0
// Checksum 0x9e51437b, Offset: 0x97f8
// Size: 0xa8
function recordactiveplayersendgamematchrecordstats()
{
    foreach ( player in level.players )
    {
        recordplayermatchend( player );
        recordplayerstats( player, "present_at_end", 1 );
    }
}

// Namespace globallogic_player/globallogic_player
// Params 1
// Checksum 0x2a6f1cd5, Offset: 0x98a8
// Size: 0xc
function callback_playershielddamageblocked( *damage )
{
    
}

