#using script_3dc93ca9902a9cda;
#using script_44b0b8420eabacad;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\gamedifficulty;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_spawn;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\globallogic_utils;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace coop;

// Namespace coop/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xd24e635, Offset: 0x398
// Size: 0x494
function event_handler[gametype_init] main( *eventstruct )
{
    clientfield::register( "playercorpse", "hide_body", 1, 1, "int" );
    clientfield::register( "toplayer", "killcam_menu", 1, 1, "int" );
    globallogic::init();
    level.gametype = util::get_game_type();
    level.var_837aa533 = hash( level.gametype );
    util::registerroundswitch( 0, 9 );
    util::registertimelimit( 0, 0 );
    util::registerscorelimit( 0, 0 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 0 );
    util::registernumlives( 0, 100 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    spawner::add_global_spawn_function( #"axis", &function_e89f60e2 );
    level.scoreroundwinbased = getgametypesetting( #"cumulativeroundscores" ) == 0;
    level.teamscoreperkill = getgametypesetting( #"teamscoreperkill" );
    level.teamscoreperdeath = getgametypesetting( #"teamscoreperdeath" );
    level.teamscoreperheadshot = getgametypesetting( #"teamscoreperheadshot" );
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onspawnplayerunified = undefined;
    level.onplayerkilled = &onplayerkilled;
    level.var_c3a79d20 = 1;
    level.takelivesondeath = 0;
    level.livesdonotreset = 1;
    level.ondeadevent = undefined;
    level.var_31c6ebd4 = &function_31c6ebd4;
    callback::on_bleedout( &function_27945f );
    callback::on_mission_failed( &on_mission_failed );
    level.var_84a50edd = &spawnedasspectator;
    level thread function_7f1305bc();
    level.endgameonscorelimit = 0;
    level.endgameontimelimit = 0;
    level.var_e23fea8c = &function_ddc47ed1;
    level.ontimelimit = &globallogic::blank;
    level.onscorelimit = &globallogic::blank;
    gameobjects::register_allowed_gameobject( level.gametype );
    game.dialog[ #"gametype" ] = "coop_start";
    game.dialog[ #"gametype_hardcore" ] = "hccoop_start";
    game.dialog[ #"offense_obj" ] = "generic_boost";
    game.dialog[ #"defense_obj" ] = "generic_boost";
    setdvar( #"hash_c9bd2003951a4a8", 1 );
}

// Namespace coop/coop
// Params 0
// Checksum 0x582e4093, Offset: 0x838
// Size: 0xc0
function on_mission_failed()
{
    level thread function_34459363( level.var_85b00b2b, level.var_30eb363 );
    
    foreach ( player in getplayers() )
    {
        bb::function_cd497743( "mission_fail", player );
    }
}

// Namespace coop/coop
// Params 0
// Checksum 0xdfd5e8f7, Offset: 0x900
// Size: 0x64
function function_e89f60e2()
{
    self influencers::create_influencer_generic( "enemy_spawn", self.origin, #"allies" );
    self influencers::create_influencer_generic( "enemy", self, #"allies", 1 );
}

// Namespace coop/coop
// Params 0
// Checksum 0x21d0113e, Offset: 0x970
// Size: 0x1f4
function function_45b62760()
{
    self matchrecordplayerspawned();
    skiptoindex = skipto::function_a002f769();
    
    if ( skiptoindex >= 0 )
    {
        self matchrecordsetcheckpointstat( skiptoindex, "checkpoint_restores", 1 );
    }
    
    primaryweapon = isdefined( self.primaryweapon ) ? self.primaryweapon : level.weaponnone;
    secondaryweapon = isdefined( self.secondaryweapon ) ? self.secondaryweapon : level.weaponnone;
    grenadetypeprimary = isdefined( self.grenadetypeprimary ) ? self.grenadetypeprimary : level.weaponnone;
    grenadetypesecondary = isdefined( self.grenadetypesecondary ) ? self.grenadetypesecondary : level.weaponnone;
    self.killstreak = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( level.loadoutkillstreaksenabled && isdefined( self.killstreak[ i ] ) && isdefined( level.killstreakindices[ self.killstreak[ i ] ] ) )
        {
            killstreaks[ i ] = level.killstreakindices[ self.killstreak[ i ] ];
            continue;
        }
        
        killstreaks[ i ] = 0;
    }
    
    self recordloadoutperksandkillstreaks( primaryweapon, secondaryweapon, grenadetypeprimary, grenadetypesecondary, killstreaks[ 0 ], killstreaks[ 1 ], killstreaks[ 2 ] );
}

// Namespace coop/coop
// Params 0
// Checksum 0x1be8d8dd, Offset: 0xb70
// Size: 0x2cc
function function_7f1305bc()
{
    while ( true )
    {
        level waittill( #"save_restore" );
        util::function_323d3227();
        level thread lui::screen_fade( 1.25, 0, 1, "black", 1 );
        matchrecorderincrementheaderstat( "checkpointRestoreCount", 1 );
        
        foreach ( player in level.players )
        {
            player closemenu( game.menu[ #"menu_start_menu" ] );
            
            if ( player flag::get( #"mobile_armory_in_use" ) )
            {
                player notify( #"menuresponse", { #menu:"mobile_armory_loadout", #response:"cancel", #intpayload:0 } );
            }
            
            player closemenu( game.menu[ #"menu_changeclass" ] );
            player closemenu( game.menu[ #"menu_changeclass_offline" ] );
            
            if ( player.sessionstate == "spectator" )
            {
                if ( !isdefined( player.curclass ) )
                {
                    player thread globallogic_ui::beginclasschoice();
                }
                else
                {
                    player thread globallogic_spawn::waitandspawnclient();
                }
            }
            
            player thread val::set_for_time( 3, "checkpoint_restore", "takedamage", 0 );
            
            if ( !is_true( world.var_b86bf11e ) )
            {
                world.var_b86bf11e = 1;
            }
            
            player function_45b62760();
        }
    }
}

// Namespace coop/coop
// Params 0
// Checksum 0xfcc55d95, Offset: 0xe48
// Size: 0x300
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game.switchedsides ) )
    {
        game.switchedsides = 0;
    }
    
    if ( game.switchedsides )
    {
        oldattackers = game.attackers;
        olddefenders = game.defenders;
        game.attackers = olddefenders;
        game.defenders = oldattackers;
    }
    
    level.displayroundendtext = 0;
    influencers::create_map_placed_influencers();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    
    foreach ( team in level.playerteams )
    {
        util::setobjectivetext( team, #"hash_6d9d9822a460249b" );
        util::setobjectivehinttext( team, #"hash_6800331814c69e15" );
        util::setobjectivescoretext( team, #"hash_6d9d9822a460249b" );
    }
    
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level thread function_5a6ac1d8();
    function_ddc47ed1();
    level flag::wait_till( "first_player_spawned" );
    
    foreach ( player in level.players )
    {
        bb::function_47cb52f6( "_level", player, "start" );
    }
}

// Namespace coop/coop
// Params 0
// Checksum 0x62260f52, Offset: 0x1150
// Size: 0x1c
function function_ddc47ed1()
{
    skipto::update_spawn_points( 1 );
}

// Namespace coop/coop
// Params 0, eflags: 0x4
// Checksum 0x705eb6ad, Offset: 0x1178
// Size: 0x5e
function private spawnplayer_internal()
{
    spawns = skipto::function_ffdc86a2( level.var_cd012e52 );
    self spawn( spawns[ 0 ].origin, spawns[ 0 ].angles );
    self.lastspawntime = gettime();
}

// Namespace coop/coop
// Params 2
// Checksum 0x31a2d90b, Offset: 0x11e0
// Size: 0x9c
function onspawnplayer( *predictedspawn, *question )
{
    pixbeginevent( #"hash_56e24560948d4d93" );
    self.usingobj = undefined;
    self spawnplayer_internal();
    self thread function_bb5fae75();
    self.var_2869a26a = 1;
    self thread gamedifficulty::function_c6f98249();
    pixendevent();
}

// Namespace coop/coop
// Params 0
// Checksum 0x920e66bc, Offset: 0x1288
// Size: 0x18e
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
        
        if ( scoredif <= scorethreshold && scorethresholdstart <= topscore )
        {
            return;
        }
        
        wait 1;
    }
}

// Namespace coop/coop
// Params 9
// Checksum 0x3ec7e61, Offset: 0x1420
// Size: 0x374
function onplayerkilled( *einflictor, *attacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration )
{
    self closemenu( game.menu[ #"menu_changeclass" ] );
    primaries = self getweaponslistprimaries();
    
    if ( isdefined( primaries ) )
    {
        foreach ( primary_weapon in primaries )
        {
            if ( primary_weapon !== self.secondaryloadoutweapon )
            {
                self._current_weapon = primary_weapon;
                break;
            }
        }
    }
    
    self player::take_weapons();
    self savegame::set_player_data( "saved_weapon", self._current_weapon.rootweapon.name );
    self savegame::set_player_data( "saved_weapon_attachments", util::function_2146bd83( self._current_weapon ) );
    self savegame::set_player_data( "saved_weapondata", self._weapons );
    self._weapons = undefined;
    self.gun_removed = undefined;
    
    if ( isdefined( level.var_5be43b2d ) )
    {
        return;
    }
    
    level.dead_player = self;
    
    if ( isdefined( level.var_85b00b2b ) )
    {
        var_f695d653 = level.var_85b00b2b;
    }
    
    if ( level.players.size == 1 )
    {
        self playsoundtoplayer( #"hash_7dcd120ea369ea68", self );
        
        if ( is_true( level.var_6cc58e4b ) )
        {
            self.var_e36aebf2 = 1;
            
            if ( is_true( level.var_41cd8311 ) && is_true( self.var_30a1aeee ) )
            {
                self thread function_ffac0e3();
            }
            
            self waittilltimeout( 5, #"hash_eb0317ca3976bf9" );
        }
        
        level thread function_34459363( var_f695d653, level.var_30eb363 );
        return;
    }
    
    if ( level.gameskill >= 2 )
    {
        playsoundatposition( #"hash_7dcd120ea369ea68", ( 0, 0, 0 ) );
        level thread function_34459363( var_f695d653, level.var_30eb363 );
    }
}

// Namespace coop/coop
// Params 2
// Checksum 0xc2129ca6, Offset: 0x17a0
// Size: 0x714
function function_34459363( var_e9724d01, var_d2b863b2 )
{
    level.var_5be43b2d = 1;
    setslowmotion( 1 );
    level flag::set( #"mission_failed" );
    
    foreach ( player in level.players )
    {
        player thread util::hide_hint_text( 0 );
        player val::set( #"load_checkpoint", "show_hud", 0 );
        bb::function_47cb52f6( level.var_b28c2c3a, player, "restart" );
        player val::set( #"hash_5677fd1c5f50cf38", "freezecontrols" );
        player.var_c071a13e = 1;
        player.var_c341be0e = player openluimenu( "CPMissionFailed" );
        delay = 2.8;
        
        if ( !isdefined( var_e9724d01 ) )
        {
            var_e9724d01 = #"";
        }
        
        player setluimenudata( player.var_c341be0e, #"missionfailreason", var_e9724d01 );
        
        if ( !isdefined( var_d2b863b2 ) )
        {
            var_d2b863b2 = #"";
            delay = 0;
        }
        
        globallogic_ui::function_9ed5232e( "hudItems.cpMissionFailedEntry.MissionFailHint", var_d2b863b2, 0, 1 );
        globallogic_ui::function_9ed5232e( "hudItems.cpMissionFailedEntry.MissionFailReason", var_e9724d01, 0, 1 );
        snd::play( "uin_cp_failure" );
        player setluimenudata( player.var_c341be0e, #"missionfailhint", var_d2b863b2 );
        wait delay;
    }
    
    var_effac39e = 1.25;
    
    if ( isdefined( level.dead_player ) )
    {
        if ( is_true( level.var_41cd8311 ) )
        {
            foreach ( player in level.players )
            {
                if ( is_true( player.var_8fc85657 ) )
                {
                    level.dead_player waittill( #"end_killcam", #"hash_769655bf42475c20" );
                    
                    if ( isdefined( level.dead_player.var_55180cd8 ) )
                    {
                        var_effac39e = level.dead_player.var_55180cd8;
                    }
                }
            }
        }
        
        level thread lui::screen_fade( var_effac39e, 1, 0, "black", 0 );
        wait var_effac39e;
        var_b80196ac = 1;
        
        if ( is_true( level.var_41cd8311 ) )
        {
            foreach ( player in level.players )
            {
                if ( is_true( player.var_8fc85657 ) )
                {
                    player clientfield::set_to_player( "killcam_menu", 0 );
                }
            }
        }
    }
    
    if ( !isdefined( var_b80196ac ) )
    {
        level thread lui::screen_fade( var_effac39e, 1, 0, "black", 0 );
        wait var_effac39e;
    }
    
    if ( is_true( level.gameended ) )
    {
        wait 1000;
    }
    
    foreach ( player in level.players )
    {
        player notify( #"hash_4bd20f5c626eb3f0" );
        player cameraactivate( 0 );
        player val::reset( #"hash_5677fd1c5f50cf38", "freezecontrols" );
    }
    
    if ( isdefined( level.heroes ) )
    {
        foreach ( key, hero in level.heroes )
        {
            util::unmake_hero( key );
        }
    }
    
    player = level.dead_player;
    
    if ( !isdefined( player ) )
    {
        player = level.players[ 0 ];
    }
    
    if ( issubstr( util::get_map_name(), "sidemission" ) )
    {
        globallogic_ui::function_e299661a( #"hash_3c9f47f5d871f55d" );
        return;
    }
    
    globallogic_ui::function_760546ce();
    globallogic_ui::function_cdbb5c49( 1 );
    function_f31af5ab();
}

// Namespace coop/coop
// Params 0
// Checksum 0x8d4861ee, Offset: 0x1ec0
// Size: 0xfe
function function_ffac0e3()
{
    self endon( #"disconnect", #"hash_4bd20f5c626eb3f0" );
    level endon( #"game_ended" );
    self clientfield::set_to_player( "killcam_menu", 1 );
    
    /#
        printtoprightln( "<dev string:x38>", ( 1, 0, 1 ) );
    #/
    
    while ( self usebuttonpressed() )
    {
        waitframe( 1 );
    }
    
    while ( !self usebuttonpressed() )
    {
        waitframe( 1 );
    }
    
    self.var_8fc85657 = 1;
    self clientfield::set_to_player( "killcam_menu", 0 );
    self notify( #"hash_149b5fe3276ace1c" );
}

/#

    // Namespace coop/coop
    // Params 0
    // Checksum 0x3969676c, Offset: 0x1fc8
    // Size: 0x186, Type: dev
    function function_c5eb768b()
    {
        if ( !isdefined( self.var_ca00be20 ) )
        {
            self.var_ca00be20 = newdebughudelem( self );
            self.var_ca00be20.archived = 0;
            self.var_ca00be20.x = 0;
            self.var_ca00be20.alignx = "<dev string:x50>";
            self.var_ca00be20.aligny = "<dev string:x5a>";
            self.var_ca00be20.horzalign = "<dev string:x50>";
            self.var_ca00be20.vertalign = "<dev string:x64>";
            self.var_ca00be20.sort = 1;
            self.var_ca00be20.font = "<dev string:x6e>";
        }
        
        if ( self issplitscreen() )
        {
            self.var_ca00be20.y = -100;
            self.var_ca00be20.fontscale = 1;
        }
        else
        {
            self.var_ca00be20.y = -180;
            self.var_ca00be20.fontscale = 1.5;
        }
        
        self.var_ca00be20 settext( #"hash_335a164eda0d56ff" );
        self.var_ca00be20.alpha = 1;
    }

#/

// Namespace coop/coop
// Params 0
// Checksum 0x515ff0c4, Offset: 0x2158
// Size: 0xe6
function function_31c6ebd4()
{
    self endon( #"disconnect", #"hash_4bd20f5c626eb3f0", #"end_respawn" );
    level endon( #"game_ended" );
    
    /#
        self function_c5eb768b();
        printtoprightln( "<dev string:x38>", ( 1, 0, 1 ) );
    #/
    
    while ( self usebuttonpressed() )
    {
        waitframe( 1 );
    }
    
    while ( !self usebuttonpressed() )
    {
        waitframe( 1 );
    }
    
    self.var_8fc85657 = 1;
    self.var_ca00be20.alpha = 0;
}

// Namespace coop/coop
// Params 0
// Checksum 0x5a35e1d2, Offset: 0x2248
// Size: 0x144
function function_27945f()
{
    if ( !is_true( level.var_ba2a141 ) )
    {
        foreach ( player in level.players )
        {
            if ( player != self && player.sessionstate != "dead" && player.sessionstate != "spectator" )
            {
                return;
            }
        }
    }
    
    if ( !is_true( level.level_ending ) )
    {
        level thread function_34459363();
    }
    
    level.level_ending = 1;
    
    /#
        if ( !is_true( level.level_ending ) )
        {
            errormsg( "<dev string:x7b>" );
        }
    #/
}

// Namespace coop/coop
// Params 0
// Checksum 0x6f2c1316, Offset: 0x2398
// Size: 0xc0, Type: bool
function wait_to_spawn()
{
    self notify( #"hash_6baa8d54b54f762e" );
    self endon( #"hash_6baa8d54b54f762e" );
    
    if ( is_true( level.inprematchperiod ) || !isdefined( self.var_56e5037e ) )
    {
        self.var_56e5037e = 1;
        return true;
    }
    
    hud_message::setlowermessage( game.strings[ #"waiting_to_spawn" ], 15 );
    level waittilltimeout( 15, #"objective_changed" );
    return true;
}

// Namespace coop/coop
// Params 0
// Checksum 0x6e0d16d3, Offset: 0x2460
// Size: 0x104
function function_5a6ac1d8()
{
    level flag::wait_till( "all_players_spawned" );
    
    while ( true )
    {
        level waittill( #"objective_changed" );
        
        foreach ( player in level.players )
        {
            if ( player.sessionstate == "spectator" && globallogic_utils::isvalidclass( player.curclass ) )
            {
                player globallogic_spawn::waitandspawnclient();
            }
        }
    }
}

// Namespace coop/coop
// Params 0
// Checksum 0xf098e1a7, Offset: 0x2570
// Size: 0x18, Type: bool
function spawnedasspectator()
{
    if ( !isdefined( self.var_56e5037e ) )
    {
        return true;
    }
    
    return false;
}

// Namespace coop/coop
// Params 0
// Checksum 0xb9130212, Offset: 0x2590
// Size: 0x2a2
function function_fd5dfc25()
{
    self endon( #"death", #"disconnect" );
    
    if ( is_true( self.currentweapon.isheavyweapon ) )
    {
        return;
    }
    
    a_weaponlist = self getweaponslist();
    var_4fd19a76 = [];
    
    foreach ( weapon in a_weaponlist )
    {
        if ( is_true( weapon.isheavyweapon ) )
        {
            if ( !isdefined( var_4fd19a76 ) )
            {
                var_4fd19a76 = [];
            }
            else if ( !isarray( var_4fd19a76 ) )
            {
                var_4fd19a76 = array( var_4fd19a76 );
            }
            
            var_4fd19a76[ var_4fd19a76.size ] = weapon;
        }
    }
    
    var_43dfbfaf = var_4fd19a76[ 0 ];
    
    if ( isdefined( var_43dfbfaf ) )
    {
        if ( self getweaponammoclip( var_43dfbfaf ) + self getweaponammostock( var_43dfbfaf ) > 0 )
        {
            if ( isdefined( self.var_444b2634 ) )
            {
                if ( gettime() - self.var_444b2634 > 90000 )
                {
                    switch ( var_43dfbfaf.rootweapon.name )
                    {
                        case #"launcher_standard":
                            if ( self.var_83f25fdb < 5 )
                            {
                                self util::show_hint_text( #"hash_3d4165067dc18a6b" );
                            }
                            
                            break;
                        case #"spike_launcher":
                            if ( self.var_83f25fdb < 10 )
                            {
                                self util::show_hint_text( #"hash_9b1201effcb0c57" );
                            }
                            
                            break;
                        case #"hash_7549b2fcdf36145a":
                            if ( self.var_83f25fdb < 10 )
                            {
                                self util::show_hint_text( #"hash_50d6975fce35fa60" );
                            }
                            
                            break;
                    }
                }
            }
        }
    }
}

// Namespace coop/coop
// Params 0
// Checksum 0x63b18ec0, Offset: 0x2840
// Size: 0x110
function function_bb5fae75()
{
    self notify( #"hash_1d6b9f8f1e2663d9" );
    self endon( #"death", #"hash_1d6b9f8f1e2663d9" );
    
    for ( var_543d6995 = 0; true ; var_543d6995 = 0 )
    {
        waitresult = self waittill( #"weapon_change" );
        
        if ( isdefined( waitresult.weapon ) )
        {
            if ( is_true( waitresult.weapon.isheavyweapon ) )
            {
                if ( !isdefined( self.var_83f25fdb ) )
                {
                    self.var_83f25fdb = 0;
                }
                
                self thread function_b296ed1c();
                var_543d6995 = 1;
                continue;
            }
            
            if ( var_543d6995 )
            {
                self.var_444b2634 = gettime();
            }
            
            self notify( #"hash_6afb6967ed216cca" );
        }
    }
}

// Namespace coop/coop
// Params 0
// Checksum 0xab135182, Offset: 0x2958
// Size: 0x84
function function_b296ed1c()
{
    self endon( #"death", #"hash_6afb6967ed216cca" );
    
    while ( true )
    {
        waitresult = self waittill( #"weapon_fired" );
        
        if ( is_true( waitresult.weapon.isheavyweapon ) )
        {
            self.var_83f25fdb++;
        }
    }
}

