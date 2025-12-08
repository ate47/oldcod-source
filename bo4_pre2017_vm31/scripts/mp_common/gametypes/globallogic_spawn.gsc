#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/player_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/spectating;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/armor;
#using scripts/mp_common/bots/mp_bot;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_defaults;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_ui;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/hud_message;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/userspawnselection;
#using scripts/mp_common/util;
#using scripts/mp_common/vehicle;

#namespace globallogic_spawn;

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x2
// Checksum 0x5c268851, Offset: 0x8f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "globallogic_spawn", &__init__, undefined, undefined );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x922ae2ef, Offset: 0x930
// Size: 0x12c
function __init__()
{
    level.requirespawnpointstoexistinlevel = 0;
    spawning::add_default_spawnlist( "auto_normal" );
    level.spawnentitytypes = [];
    array::add( level.spawnentitytypes, { #team:"all", #entityname:"mp_t8_spawn_point" } );
    array::add( level.spawnentitytypes, { #team:"allies", #entityname:"mp_t8_spawn_point_allies" } );
    array::add( level.spawnentitytypes, { #team:"axis", #entityname:"mp_t8_spawn_point_axis" } );
    level.allspawnpoints = [];
    callback::function_301fb71c( &function_301fb71c );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x1e563083, Offset: 0xa68
// Size: 0xe
function getspawnentitytypes()
{
    return level.spawnentitytypes;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x69b64f9e, Offset: 0xa80
// Size: 0xe
function getmpspawnpoints()
{
    return level.allspawnpoints;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0xa28ffc7a, Offset: 0xa98
// Size: 0x4c
function addsupportedspawnpointtype( spawnpointtype )
{
    if ( !isdefined( level.supportedspawntypes ) )
    {
        level.supportedspawntypes = [];
    }
    
    array::add( level.supportedspawntypes, spawnpointtype );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 3
// Checksum 0x872e9243, Offset: 0xaf0
// Size: 0x200
function addspawnsforteamname( teamname, searchentity, &spawnarray )
{
    rawspawns = struct::get_array( searchentity, "targetname" );
    
    foreach ( spawn in rawspawns )
    {
        array::add( level.allspawnpoints, spawn );
        
        foreach ( supportedspawntype in level.supportedspawntypes )
        {
            if ( !( isdefined( spawn.spawnflags ) && ( spawn.spawnflags & supportedspawntype ) == supportedspawntype ) )
            {
                continue;
            }
            
            teamname = getteamname( teamname );
            
            if ( !isdefined( spawnarray[ teamname ] ) )
            {
                spawnarray[ teamname ] = [];
            }
            
            if ( !isdefined( spawn.enabled ) )
            {
                spawn.enabled = -1;
            }
            
            array::add( spawnarray[ teamname ], spawn );
        }
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x1ccb77d7, Offset: 0xcf8
// Size: 0x322
function addspawns()
{
    clearspawnpoints( "auto_normal" );
    
    if ( !isdefined( level.supportedspawntypes ) )
    {
        println( "<dev string:x28>" );
        addsupportedspawnpointtype( 64 );
    }
    
    spawnstoadd = [];
    
    foreach ( spawnentitytype in level.spawnentitytypes )
    {
        addspawnsforteamname( spawnentitytype.team, spawnentitytype.entityname, spawnstoadd );
    }
    
    spawnteams = getarraykeys( spawnstoadd );
    
    foreach ( spawnteam in spawnteams )
    {
        if ( spawnteam == "all" )
        {
            foreach ( team in level.teams )
            {
                addspawnpoints( team, spawnstoadd[ spawnteam ], "auto_normal" );
                enablespawnpointlist( "auto_normal", util::getteammask( team ) );
            }
            
            continue;
        }
        
        teamforspawns = game.switchedsides ? util::getotherteam( spawnteam ) : spawnteam;
        addspawnpoints( teamforspawns, spawnstoadd[ spawnteam ], "auto_normal" );
        enablespawnpointlist( "auto_normal", util::getteammask( teamforspawns ) );
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0xe6fe463f, Offset: 0x1028
// Size: 0x14
function onstartgametype()
{
    addspawns();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0xd5685d86, Offset: 0x1048
// Size: 0x222
function timeuntilspawn( includeteamkilldelay )
{
    if ( level.ingraceperiod && !self.hasspawned )
    {
        return 0;
    }
    
    respawndelay = 0;
    
    if ( self.hasspawned )
    {
        result = self [[ level.onrespawndelay ]]();
        
        if ( isdefined( result ) )
        {
            respawndelay = result;
        }
        else
        {
            respawndelay = level.playerrespawndelay;
        }
        
        if ( isdefined( level.playerincrementalrespawndelay ) && isdefined( self.pers[ "spawns" ] ) )
        {
            respawndelay += level.playerincrementalrespawndelay * self.pers[ "spawns" ];
        }
        
        if ( isdefined( self.suicide ) && self.suicide && level.suicidespawndelay > 0 )
        {
            respawndelay += level.suicidespawndelay;
        }
        
        if ( isdefined( self.teamkilled ) && self.teamkilled && level.teamkilledspawndelay > 0 )
        {
            respawndelay += level.teamkilledspawndelay;
        }
        
        if ( isdefined( self.teamkillpunish ) && includeteamkilldelay && self.teamkillpunish )
        {
            respawndelay += globallogic_player::teamkilldelay();
        }
    }
    
    wavebased = level.waverespawndelay > 0;
    
    if ( wavebased )
    {
        return self timeuntilwavespawn( respawndelay );
    }
    
    if ( isdefined( self.usedresurrect ) && self.usedresurrect )
    {
        return 0;
    }
    
    return respawndelay;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0xa2fbc37e, Offset: 0x1278
// Size: 0x96, Type: bool
function allteamshaveexisted()
{
    foreach ( team in level.teams )
    {
        if ( !level.everexisted[ team ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x521838ba, Offset: 0x1318
// Size: 0x1e0, Type: bool
function mayspawn()
{
    if ( isdefined( level.mayspawn ) && !self [[ level.mayspawn ]]() )
    {
        return false;
    }
    
    if ( level.inovertime )
    {
        return false;
    }
    
    if ( level.playerqueuedrespawn && !isdefined( self.allowqueuespawn ) && !level.ingraceperiod && !level.usestartspawns )
    {
        return false;
    }
    
    if ( level.numlives || level.numteamlives )
    {
        if ( level.teambased )
        {
            gamehasstarted = allteamshaveexisted();
        }
        else
        {
            gamehasstarted = !util::isoneround() && ( level.maxplayercount > 1 || !util::isfirstround() );
        }
        
        if ( level.numteamlives && ( level.numlives && !self.pers[ "lives" ] || !game.lives[ self.team ] ) )
        {
            return false;
        }
        else if ( isdefined( level.var_4ec8f819 ) && gamehasstarted && level.var_4ec8f819 )
        {
            if ( !level.ingraceperiod && !self.hasspawned && !level.wagermatch )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x28542556, Offset: 0x1500
// Size: 0x12e
function timeuntilwavespawn( minimumwait )
{
    earliestspawntime = gettime() + minimumwait * 1000;
    lastwavetime = level.lastwave[ self.pers[ "team" ] ];
    wavedelay = level.wavedelay[ self.pers[ "team" ] ] * 1000;
    
    if ( wavedelay == 0 )
    {
        return 0;
    }
    
    numwavespassedearliestspawntime = ( earliestspawntime - lastwavetime ) / wavedelay;
    numwaves = ceil( numwavespassedearliestspawntime );
    timeofspawn = lastwavetime + numwaves * wavedelay;
    
    if ( isdefined( self.wavespawnindex ) )
    {
        timeofspawn += 50 * self.wavespawnindex;
    }
    
    return ( timeofspawn - gettime() ) / 1000;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0xad7ff524, Offset: 0x1638
// Size: 0x40
function stoppoisoningandflareonspawn()
{
    self endon( #"disconnect" );
    self.inpoisonarea = 0;
    self.inburnarea = 0;
    self.inflarevisionarea = 0;
    self.ingroundnapalm = 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x6e945415, Offset: 0x1680
// Size: 0xd0
function spawnplayerprediction()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"game_ended" );
    self endon( #"joined_spectators" );
    self endon( #"spawned" );
    livesleft = !( level.numlives && !self.pers[ "lives" ] ) && !( level.numteamlives && !game.lives[ self.team ] );
    
    if ( !livesleft )
    {
        return;
    }
    
    while ( true )
    {
        wait 0.5;
        spawning::onspawnplayer( 1 );
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x35fe6db7, Offset: 0x1758
// Size: 0x12c
function playmatchstartaudio( team )
{
    for ( index = 0; index < 5 ; index++ )
    {
        waitframe( 1 );
    }
    
    if ( self.pers[ "playedGameMode" ] !== 1 )
    {
        if ( level.hardcoremode )
        {
            self globallogic_audio::leader_dialog_on_player( level.leaderdialog.starthcgamedialog );
        }
        else
        {
            self globallogic_audio::leader_dialog_on_player( level.leaderdialog.startgamedialog );
        }
    }
    
    if ( team == game.attackers )
    {
        self globallogic_audio::leader_dialog_on_player( level.leaderdialog.offenseorderdialog );
        return;
    }
    
    self globallogic_audio::leader_dialog_on_player( level.leaderdialog.defenseorderdialog );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0xa7d9d31, Offset: 0x1890
// Size: 0x124
function doinitialspawnmessaging()
{
    self endon( #"disconnect" );
    self.playleaderdialog = 1;
    
    if ( isdefined( level.var_29d9f951 ) && level.var_29d9f951 )
    {
        return;
    }
    
    team = self.pers[ "team" ];
    thread hud_message::function_c0025cfc( team );
    
    while ( level.inprematchperiod )
    {
        waitframe( 1 );
    }
    
    if ( getdvarint( "mp_prototype" ) == 0 )
    {
        hintmessage = util::getobjectivehinttext( team );
        
        if ( isdefined( hintmessage ) )
        {
            self luinotifyevent( &"show_gametype_objective_hint", 1, hintmessage );
        }
    }
    
    if ( isdefined( level.leaderdialog ) )
    {
        self thread playmatchstartaudio( team );
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0xb998dbff, Offset: 0x19c0
// Size: 0x10
function resetattackersthisspawnlist()
{
    self.attackersthisspawn = [];
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0xc59a59ec, Offset: 0x19d8
// Size: 0xa4
function function_301fb71c( results )
{
    if ( self.sessionstate != "playing" )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        self.maxhealth = self.spawnhealth;
        self.health = self.maxhealth;
        self player_role::update_fields();
        self loadout::giveloadout( self.team, self.curclass, 1 );
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x5df64d8b, Offset: 0x1a88
// Size: 0xb34
function spawnplayer()
{
    pixbeginevent( "spawnPlayer_preUTS" );
    self endon( #"disconnect" );
    self endon( #"joined_spectators" );
    hadspawned = self.hasspawned;
    self player::spawn_player();
    
    if ( !isdefined( self.pers[ "resetMomentumOnSpawn" ] ) || self.pers[ "resetMomentumOnSpawn" ] )
    {
        self globallogic_score::resetplayermomentumonspawn();
        self.pers[ "resetMomentumOnSpawn" ] = 0;
    }
    
    if ( globallogic_utils::getroundstartdelay() )
    {
        self thread globallogic_utils::applyroundstartdelay();
    }
    
    if ( isdefined( self.spawnlightarmor ) && self.spawnlightarmor > 0 )
    {
        self thread armor::setlightarmor( self.spawnlightarmor );
    }
    
    self.nextkillstreakfree = undefined;
    self.deathmachinekills = 0;
    self resetattackersthisspawnlist();
    self.diedonvehicle = undefined;
    
    if ( !self.wasaliveatmatchstart )
    {
        if ( level.ingraceperiod || globallogic_utils::gettimepassed() < 20000 )
        {
            self.wasaliveatmatchstart = 1;
        }
    }
    
    pixbeginevent( "onSpawnPlayer" );
    self [[ level.onspawnplayer ]]( 0 );
    
    if ( isdefined( level.playerspawnedcb ) )
    {
        self [[ level.playerspawnedcb ]]();
    }
    
    pixendevent();
    pixendevent();
    level thread globallogic::updateteamstatus();
    pixbeginevent( "spawnPlayer_postUTS" );
    self thread stoppoisoningandflareonspawn();
    self.sensorgrenadedata = undefined;
    assert( globallogic_utils::isvalidclass( self.curclass ) );
    assert( player_role::is_valid( self player_role::get() ) );
    self.pers[ "momentum_at_spawn_or_game_end" ] = isdefined( self.pers[ "momentum" ] ) ? self.pers[ "momentum" ] : 0;
    
    if ( sessionmodeiszombiesgame() )
    {
        self loadout::giveloadoutlevelspecific( self.team, self.curclass );
    }
    else
    {
        globallogic_player::function_5e3d5a6d();
        self loadout::setclass( self.curclass );
        self loadout::giveloadout( self.team, self.curclass, 0 );
        
        if ( getdvarint( "tu11_enableClassicMode" ) == 1 )
        {
            if ( self.team == "allies" )
            {
                self setcharacterbodytype( 0 );
            }
            else
            {
                self setcharacterbodytype( 2 );
            }
        }
    }
    
    if ( level.inprematchperiod )
    {
        self util::freeze_player_controls( 1 );
        team = self.pers[ "team" ];
        
        if ( isdefined( self.pers[ "music" ].spawn ) && self.pers[ "music" ].spawn == 0 )
        {
            music = game.music[ "spawn_" + team ];
            
            if ( game.roundsplayed == 0 )
            {
                self thread function_a2c32efb( "spawnFull" );
            }
            else
            {
                self thread function_a2c32efb( "spawnShort" );
            }
            
            self.pers[ "music" ].spawn = 1;
        }
        
        if ( level.splitscreen )
        {
            if ( isdefined( level.playedstartingmusic ) )
            {
                music = undefined;
            }
            else
            {
                level.playedstartingmusic = 1;
            }
        }
        
        self thread doinitialspawnmessaging();
    }
    else
    {
        self util::freeze_player_controls( 0 );
        self enableweapons();
        
        if ( !hadspawned && game.state == "playing" )
        {
            pixbeginevent( "sound" );
            team = self.team;
            
            if ( isdefined( self.pers[ "music" ].spawn ) && self.pers[ "music" ].spawn == 0 )
            {
                music = game.music[ "spawn_" + team ];
                self thread function_a2c32efb( "spawnShort" );
                self.pers[ "music" ].spawn = 1;
            }
            
            if ( level.splitscreen )
            {
                if ( isdefined( level.playedstartingmusic ) )
                {
                    music = undefined;
                }
                else
                {
                    level.playedstartingmusic = 1;
                }
            }
            
            self thread doinitialspawnmessaging();
            pixendevent();
        }
    }
    
    if ( self hasperk( "specialty_anteup" ) )
    {
        anteup_bonus = getdvarint( "perk_killstreakAnteUpResetValue" );
        
        if ( self.pers[ "momentum_at_spawn_or_game_end" ] < anteup_bonus )
        {
            globallogic_score::_setplayermomentum( self, anteup_bonus, 0 );
        }
    }
    
    if ( getdvarstring( "scr_showperksonspawn" ) == "" )
    {
        setdvar( "scr_showperksonspawn", "0" );
    }
    
    if ( level.hardcoremode )
    {
        setdvar( "scr_showperksonspawn", "0" );
    }
    
    if ( getdvarint( "scr_showperksonspawn" ) == 1 && game.state != "postgame" )
    {
        pixbeginevent( "showperksonspawn" );
        
        if ( level.perksenabled == 1 )
        {
            self hud::showperks();
        }
        
        pixendevent();
    }
    
    if ( isdefined( self.pers[ "momentum" ] ) )
    {
        self.momentum = self.pers[ "momentum" ];
    }
    
    self thread function_7e08aae();
    self setsprintboost( 0 );
    pixendevent();
    waittillframeend();
    self notify( #"spawned_player" );
    callback::callback( #"hash_bc12b61f" );
    self thread globallogic_player::player_monitor_travel_dist();
    self thread globallogic_player::function_716b3fd6();
    self thread globallogic_player::function_64aa4793();
    self thread globallogic_player::function_9e98f49b();
    self thread globallogic_player::function_cf1cf1b3();
    self thread globallogic_player::player_monitor_inactivity();
    
    /#
        print( "<dev string:x82>" + self.origin[ 0 ] + "<dev string:x85>" + self.origin[ 1 ] + "<dev string:x85>" + self.origin[ 2 ] + "<dev string:x87>" );
    #/
    
    setdvar( "scr_selecting_location", "" );
    
    if ( !sessionmodeiszombiesgame() )
    {
        self thread killstreaks::killstreak_waiter_new();
        self thread killstreaks::killstreak_waiter_grenade();
    }
    
    /#
        if ( getdvarint( "<dev string:x89>" ) > 0 )
        {
            self thread globallogic_score::function_4e01d1c3();
        }
    #/
    
    if ( game.state == "postgame" )
    {
        assert( !level.intermission );
        self globallogic_player::freezeplayerforroundend();
    }
    
    self util::set_lighting_state();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x4d3fbc9e, Offset: 0x25c8
// Size: 0xa2
function function_7e08aae()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"joined_spectators" );
    self endon( #"joined_team" );
    self notify( #"hash_7e08aae" );
    self endon( #"hash_7e08aae" );
    level waittill( "game_ended" );
    self.pers[ "momentum_at_spawn_or_game_end" ] = isdefined( self.pers[ "momentum" ] ) ? self.pers[ "momentum" ] : 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x208c3740, Offset: 0x2678
// Size: 0x74
function function_a2c32efb( music )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( level.inprematchperiod )
    {
        waitframe( 1 );
    }
    
    if ( !( isdefined( level.freerun ) && level.freerun ) )
    {
        self thread globallogic_audio::set_music_on_player( music );
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2
// Checksum 0xcd7befd, Offset: 0x26f8
// Size: 0x4c
function spawnspectator( origin, angles )
{
    self notify( #"spawned" );
    self notify( #"end_respawn" );
    in_spawnspectator( origin, angles );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2
// Checksum 0x5b41b759, Offset: 0x2750
// Size: 0x2c
function respawn_asspectator( origin, angles )
{
    in_spawnspectator( origin, angles );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2
// Checksum 0x50d730b8, Offset: 0x2788
// Size: 0x1a4
function in_spawnspectator( origin, angles )
{
    pixmarker( "BEGIN: in_spawnSpectator" );
    self player::set_spawn_variables();
    
    if ( self.pers[ "team" ] == "spectator" )
    {
        self util::clearlowermessage();
    }
    
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    
    if ( self.pers[ "team" ] == "spectator" )
    {
        self.statusicon = "";
    }
    else
    {
        self.statusicon = "hud_status_dead";
    }
    
    spectating::set_permissions_for_machine();
    [[ level.onspawnspectator ]]( origin, angles );
    
    if ( level.teambased && !level.splitscreen )
    {
        self thread spectatorthirdpersonness();
    }
    
    level thread globallogic::updateteamstatus();
    pixmarker( "END: in_spawnSpectator" );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x74a347c2, Offset: 0x2938
// Size: 0x44
function spectatorthirdpersonness()
{
    self endon( #"disconnect" );
    self endon( #"spawned" );
    self notify( #"spectator_thirdperson_thread" );
    self endon( #"spectator_thirdperson_thread" );
    self.spectatingthirdperson = 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x3b32e763, Offset: 0x2988
// Size: 0x100
function forcespawn( time )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"spawned" );
    
    if ( !isdefined( time ) )
    {
        time = 60;
    }
    
    wait time;
    
    if ( self.hasspawned )
    {
        return;
    }
    
    if ( self.pers[ "team" ] == "spectator" )
    {
        return;
    }
    
    if ( !globallogic_utils::isvalidclass( self.pers[ "class" ] ) )
    {
        self.pers[ "class" ] = "CLASS_CUSTOM1";
        self.curclass = self.pers[ "class" ];
    }
    
    self globallogic_ui::closemenus();
    self thread [[ level.spawnclient ]]();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0xfa525771, Offset: 0x2a90
// Size: 0x5c
function kickifdontspawn()
{
    /#
        if ( getdvarint( "<dev string:x94>" ) == 1 )
        {
            return;
        }
    #/
    
    if ( self ishost() )
    {
        return;
    }
    
    self kickifidontspawninternal();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x38849fab, Offset: 0x2af8
// Size: 0x1f4
function kickifidontspawninternal()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"spawned" );
    waittime = 90;
    
    if ( getdvarstring( "scr_kick_time" ) != "" )
    {
        waittime = getdvarfloat( "scr_kick_time" );
    }
    
    mintime = 45;
    
    if ( getdvarstring( "scr_kick_mintime" ) != "" )
    {
        mintime = getdvarfloat( "scr_kick_mintime" );
    }
    
    starttime = gettime();
    kickwait( waittime );
    timepassed = ( gettime() - starttime ) / 1000;
    
    if ( timepassed < waittime - 0.1 && timepassed < mintime )
    {
        return;
    }
    
    if ( self.hasspawned )
    {
        return;
    }
    
    if ( sessionmodeisprivate() )
    {
        return;
    }
    
    if ( self.pers[ "team" ] == "spectator" )
    {
        return;
    }
    
    if ( !mayspawn() && self.pers[ "time_played_total" ] > 0 )
    {
        return;
    }
    
    globallogic::gamehistoryplayerkicked();
    kick( self getentitynumber(), "EXE_PLAYERKICKED_NOTSPAWNED" );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x8fb0e04, Offset: 0x2cf8
// Size: 0x34
function kickwait( waittime )
{
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithhostmigrationpause( waittime );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x3877c14d, Offset: 0x2d38
// Size: 0x144
function spawninterroundintermission()
{
    self notify( #"spawned" );
    self notify( #"end_respawn" );
    self player::set_spawn_variables();
    self util::clearlowermessage();
    self util::freeze_player_controls( 0 );
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    self globallogic_defaults::default_onspawnintermission();
    self setorigin( self.origin );
    self setplayerangles( self.angles );
    self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2
// Checksum 0xc84daf47, Offset: 0x2e88
// Size: 0x14c
function spawnintermission( usedefaultcallback, endgame )
{
    self notify( #"spawned" );
    self notify( #"end_respawn" );
    self endon( #"disconnect" );
    self player::set_spawn_variables();
    self util::clearlowermessage();
    self util::freeze_player_controls( 0 );
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    
    if ( isdefined( usedefaultcallback ) && usedefaultcallback )
    {
        globallogic_defaults::default_onspawnintermission();
    }
    else
    {
        [[ level.onspawnintermission ]]( endgame );
    }
    
    self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x92e2bca4, Offset: 0x2fe0
// Size: 0xe4
function spawnqueuedclientonteam( team )
{
    player_to_spawn = undefined;
    
    for ( i = 0; i < level.deadplayers[ team ].size ; i++ )
    {
        player = level.deadplayers[ team ][ i ];
        
        if ( player.waitingtospawn )
        {
            continue;
        }
        
        player_to_spawn = player;
        break;
    }
    
    if ( isdefined( player_to_spawn ) )
    {
        player_to_spawn.allowqueuespawn = 1;
        player_to_spawn globallogic_ui::closemenus();
        player_to_spawn thread [[ level.spawnclient ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2
// Checksum 0x3002ca45, Offset: 0x30d0
// Size: 0x152
function spawnqueuedclient( dead_player_team, killer )
{
    if ( !level.playerqueuedrespawn )
    {
        return;
    }
    
    util::waittillslowprocessallowed();
    spawn_team = undefined;
    
    if ( isdefined( killer ) && isdefined( killer.team ) && isdefined( level.teams[ killer.team ] ) )
    {
        spawn_team = killer.team;
    }
    
    if ( isdefined( spawn_team ) )
    {
        spawnqueuedclientonteam( spawn_team );
        return;
    }
    
    foreach ( team in level.teams )
    {
        if ( team == dead_player_team )
        {
            continue;
        }
        
        spawnqueuedclientonteam( team );
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0xa6e3073a, Offset: 0x3230
// Size: 0xe0, Type: bool
function allteamsnearscorelimit()
{
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( level.scorelimit <= 1 )
    {
        return false;
    }
    
    foreach ( team in level.teams )
    {
        if ( !( game.stat[ "teamScores" ][ team ] >= level.scorelimit - 1 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x1fca2ab2, Offset: 0x3318
// Size: 0x76, Type: bool
function shouldshowrespawnmessage()
{
    if ( util::waslastround() )
    {
        return false;
    }
    
    if ( util::isoneround() )
    {
        return false;
    }
    
    if ( isdefined( level.livesdonotreset ) && level.livesdonotreset )
    {
        return false;
    }
    
    if ( allteamsnearscorelimit() )
    {
        return false;
    }
    
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x36524632, Offset: 0x3398
// Size: 0x44
function default_spawnmessage()
{
    util::setlowermessage( game.strings[ "spawn_next_round" ] );
    self thread globallogic_ui::removespawnmessageshortly( 3 );
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x8459a1c1, Offset: 0x33e8
// Size: 0x2c
function showspawnmessage()
{
    if ( shouldshowrespawnmessage() )
    {
        self thread [[ level.spawnmessage ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x34c4354d, Offset: 0x3420
// Size: 0x1ac
function spawnclient( timealreadypassed )
{
    pixbeginevent( "spawnClient" );
    assert( isdefined( self.team ) );
    assert( globallogic_utils::isvalidclass( self.curclass ) );
    
    if ( !self mayspawn() && !( isdefined( self.usedresurrect ) && self.usedresurrect ) )
    {
        currentorigin = self.origin;
        currentangles = self.angles;
        self showspawnmessage();
        self thread [[ level.spawnspectator ]]( currentorigin + ( 0, 0, 60 ), currentangles );
        pixendevent();
        return;
    }
    
    if ( self.waitingtospawn )
    {
        pixendevent();
        return;
    }
    
    self.waitingtospawn = 1;
    self.allowqueuespawn = undefined;
    self waitandspawnclient( timealreadypassed );
    
    if ( isdefined( self ) )
    {
        self.waitingtospawn = 0;
    }
    
    pixendevent();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x643c7649, Offset: 0x35d8
// Size: 0x6d0
function waitandspawnclient( timealreadypassed )
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    level endon( #"game_ended" );
    
    if ( !isdefined( timealreadypassed ) )
    {
        timealreadypassed = 0;
    }
    
    spawnedasspectator = 0;
    
    if ( isdefined( self.teamkillpunish ) && self.teamkillpunish )
    {
        teamkilldelay = globallogic_player::teamkilldelay();
        
        if ( teamkilldelay > timealreadypassed )
        {
            teamkilldelay -= timealreadypassed;
            timealreadypassed = 0;
        }
        else
        {
            timealreadypassed -= teamkilldelay;
            teamkilldelay = 0;
        }
        
        if ( teamkilldelay > 0 )
        {
            util::setlowermessage( &"MP_FRIENDLY_FIRE_WILL_NOT", teamkilldelay );
            self thread respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );
            spawnedasspectator = 1;
            wait teamkilldelay;
        }
        
        self.teamkillpunish = 0;
    }
    
    if ( !isdefined( self.wavespawnindex ) && isdefined( level.waveplayerspawnindex[ self.team ] ) )
    {
        self.wavespawnindex = level.waveplayerspawnindex[ self.team ];
        level.waveplayerspawnindex[ self.team ]++;
    }
    
    timeuntilspawn = timeuntilspawn( 0 );
    
    if ( timeuntilspawn > timealreadypassed )
    {
        timeuntilspawn -= timealreadypassed;
        timealreadypassed = 0;
    }
    else
    {
        timealreadypassed -= timeuntilspawn;
        timeuntilspawn = 0;
    }
    
    if ( timeuntilspawn > 0 )
    {
        if ( level.playerqueuedrespawn )
        {
            util::setlowermessage( game.strings[ "you_will_spawn" ], timeuntilspawn );
        }
        else if ( self issplitscreen() )
        {
            util::setlowermessage( game.strings[ "waiting_to_spawn_ss" ], timeuntilspawn, 1 );
        }
        else
        {
            util::setlowermessage( game.strings[ "waiting_to_spawn" ], timeuntilspawn );
        }
        
        if ( !spawnedasspectator )
        {
            spawnorigin = self.origin + ( 0, 0, 60 );
            spawnangles = self.angles;
            
            if ( isdefined( level.useintermissionpointsonwavespawn ) && [[ level.useintermissionpointsonwavespawn ]]() == 1 )
            {
                spawnpoint = spawning::get_random_intermission_point();
                
                if ( isdefined( spawnpoint ) )
                {
                    spawnorigin = spawnpoint.origin;
                    spawnangles = spawnpoint.angles;
                }
            }
            
            self thread respawn_asspectator( spawnorigin, spawnangles );
        }
        
        spawnedasspectator = 1;
        self globallogic_utils::waitfortimeornotify( timeuntilspawn, "force_spawn" );
        self notify( #"stop_wait_safe_spawn_button" );
    }
    
    if ( isdefined( level.var_2b829c4e ) )
    {
        if ( !spawnedasspectator )
        {
            self thread respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );
        }
        
        spawnedasspectator = 1;
        
        if ( !self [[ level.var_2b829c4e ]]() )
        {
            self.waitingtospawn = 0;
            self util::clearlowermessage();
            self.wavespawnindex = undefined;
            self.respawntimerstarttime = undefined;
            return;
        }
    }
    
    wavebased = level.waverespawndelay > 0;
    
    if ( !level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn )
    {
        util::setlowermessage( game.strings[ "press_to_spawn" ] );
        
        if ( !spawnedasspectator )
        {
            self thread respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );
        }
        
        spawnedasspectator = 1;
        self waitrespawnorsafespawnbutton();
    }
    
    self.waitingtospawn = 0;
    self util::clearlowermessage();
    self.wavespawnindex = undefined;
    self.respawntimerstarttime = undefined;
    
    if ( isdefined( level.playerincrementalrespawndelay ) )
    {
        if ( isdefined( self.pers[ "spawns" ] ) )
        {
            self.pers[ "spawns" ]++;
        }
        else
        {
            self.pers[ "spawns" ] = 1;
        }
    }
    
    if ( userspawnselection::isspawnselectenabled() )
    {
        showmenu = self userspawnselection::shouldshowspawnselectionmenu();
        
        if ( showmenu )
        {
            specialistindex = self player_role::get();
            
            if ( player_role::is_valid( specialistindex ) )
            {
                self userspawnselection::openspawnselectionandwait();
            }
        }
        else
        {
            self userspawnselection::activatespawnselectionmenu();
        }
    }
    
    self thread [[ level.spawnplayer ]]();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x8a07d028, Offset: 0x3cb0
// Size: 0x4c
function waitrespawnorsafespawnbutton()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    
    while ( true )
    {
        if ( self usebuttonpressed() )
        {
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0
// Checksum 0x58fcb87c, Offset: 0x3d08
// Size: 0xa6
function waitinspawnqueue()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    
    if ( !level.ingraceperiod && !level.usestartspawns )
    {
        currentorigin = self.origin;
        currentangles = self.angles;
        self thread [[ level.spawnspectator ]]( currentorigin + ( 0, 0, 60 ), currentangles );
        self waittill( "queue_respawn" );
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0x656e6069, Offset: 0x3db8
// Size: 0xfc
function setthirdperson( value )
{
    if ( !level.console )
    {
        return;
    }
    
    if ( !isdefined( self.spectatingthirdperson ) || value != self.spectatingthirdperson )
    {
        self.spectatingthirdperson = value;
        
        if ( value )
        {
            self setclientthirdperson( 1 );
            self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
        }
        else
        {
            self setclientthirdperson( 0 );
            self setdepthoffield( 0, 0, 512, 4000, 4, 0 );
        }
        
        self resetfov();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1
// Checksum 0xcb9d5ee, Offset: 0x3ec0
// Size: 0x68
function getteamname( raw_team_str )
{
    returnstr = raw_team_str;
    
    if ( raw_team_str == "attackers" )
    {
        returnstr = game.attackers;
    }
    else if ( raw_team_str == "defenders" )
    {
        returnstr = game.defenders;
    }
    
    return returnstr;
}

