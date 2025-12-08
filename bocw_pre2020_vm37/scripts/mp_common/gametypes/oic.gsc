#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_weapons;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;

#namespace oic;

// Namespace oic/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xe048c02a, Offset: 0x310
// Size: 0x30c
function event_handler[gametype_init] main( *eventstruct )
{
    globallogic::init();
    level.pointsperweaponkill = getgametypesetting( "pointsPerWeaponKill" ) * 10;
    level.pointspermeleekill = getgametypesetting( "pointsPerMeleeKill" ) * 10;
    level.pointsforsurvivalbonus = getgametypesetting( "pointsForSurvivalBonus" ) * 10;
    level.var_18823aed = 60;
    util::registerscorelimit( 0, 50000 );
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.givecustomloadout = &givecustomloadout;
    level.onplayerdamage = &onplayerdamage;
    level.onendgame = &onendgame;
    player::function_cf3aa03d( &onplayerkilled );
    oic_perks = [];
    
    if ( !isdefined( oic_perks ) )
    {
        oic_perks = [];
    }
    else if ( !isarray( oic_perks ) )
    {
        oic_perks = array( oic_perks );
    }
    
    oic_perks[ oic_perks.size ] = "specialty_sprint";
    
    if ( !isdefined( oic_perks ) )
    {
        oic_perks = [];
    }
    else if ( !isarray( oic_perks ) )
    {
        oic_perks = array( oic_perks );
    }
    
    oic_perks[ oic_perks.size ] = "specialty_slide";
    level.oic_perks = oic_perks;
    spawning::addsupportedspawnpointtype( "ffa" );
    var_1f99b9e8 = [];
    
    if ( !isdefined( var_1f99b9e8 ) )
    {
        var_1f99b9e8 = [];
    }
    else if ( !isarray( var_1f99b9e8 ) )
    {
        var_1f99b9e8 = array( var_1f99b9e8 );
    }
    
    var_1f99b9e8[ var_1f99b9e8.size ] = getweapon( #"pistol_semiauto_t9", "" );
    level.gunselection = getgametypesetting( #"gunselection" );
    level.var_bf82f6b0 = var_1f99b9e8[ level.gunselection ];
    level.takelivesondeath = 1;
}

// Namespace oic/oic
// Params 10
// Checksum 0xdb6d9a0f, Offset: 0x628
// Size: 0xbc
function onplayerdamage( *einflictor, *eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime )
{
    if ( level.gunselection === 7 )
    {
        return shitloc;
    }
    
    if ( psoffsettime == "MOD_PISTOL_BULLET" || psoffsettime == "MOD_RIFLE_BULLET" || psoffsettime == "MOD_HEAD_SHOT" )
    {
        shitloc = self.maxhealth + 1;
    }
    
    return shitloc;
}

// Namespace oic/oic
// Params 0
// Checksum 0x741357b0, Offset: 0x6f0
// Size: 0x398
function givecustomloadout()
{
    loadout::init_player( 1 );
    loadout::function_f436358b( self.curclass );
    actionslot3 = getdvarint( #"hash_449fa75f87a4b5b4", 0 ) < 0 ? "flourish_callouts" : "ping_callouts";
    self setactionslot( 3, actionslot3 );
    actionslot4 = getdvarint( #"hash_23270ec9008cb656", 0 ) < 0 ? "scorestreak_wheel" : "sprays_boasts";
    self setactionslot( 4, actionslot4 );
    weapon = level.var_bf82f6b0;
    self giveweapon( weapon );
    self switchtoweapon( weapon );
    clipammo = 1;
    
    if ( isdefined( self.pers[ #"clip_ammo" ] ) )
    {
        clipammo = self.pers[ #"clip_ammo" ];
        self.pers[ #"clip_ammo" ] = undefined;
    }
    
    self setweaponammoclip( weapon, clipammo );
    stockammo = 0;
    
    if ( isdefined( self.pers[ #"stock_ammo" ] ) )
    {
        stockammo = self.pers[ #"stock_ammo" ];
        self.pers[ #"stock_ammo" ] = undefined;
    }
    
    self setweaponammostock( weapon, stockammo );
    self setspawnweapon( weapon );
    self giveperks();
    e_whippings = isdefined( getgametypesetting( #"hash_4ca06c610b5d53bd" ) ) ? getgametypesetting( #"hash_4ca06c610b5d53bd" ) : 0;
    
    if ( !e_whippings )
    {
        secondaryoffhand = getweapon( #"gadget_health_regen" );
        secondaryoffhandcount = 1;
        self giveweapon( secondaryoffhand );
        self setweaponammoclip( secondaryoffhand, secondaryoffhandcount );
        self switchtooffhand( secondaryoffhand );
        loadout = self loadout::get_loadout_slot( "specialgrenade" );
        loadout.weapon = secondaryoffhand;
        loadout.count = secondaryoffhandcount;
        self ability_util::gadget_power_full( secondaryoffhand );
    }
    
    return weapon;
}

// Namespace oic/oic
// Params 0
// Checksum 0xa2f07000, Offset: 0xa90
// Size: 0xc0
function giveperks()
{
    self clearperks();
    
    foreach ( perkname in level.oic_perks )
    {
        if ( !self hasperk( perkname ) )
        {
            self setperk( perkname );
        }
    }
}

// Namespace oic/oic
// Params 0
// Checksum 0x539a2568, Offset: 0xb58
// Size: 0x3c
function onstartgametype()
{
    allowed[ 0 ] = "oic";
    level.displayroundendtext = 0;
    level thread watchelimination();
}

// Namespace oic/oic
// Params 1
// Checksum 0x9ce9455d, Offset: 0xba0
// Size: 0xa4
function onspawnplayer( predictedspawn )
{
    if ( !level.inprematchperiod )
    {
        spawning::function_7a87efaa();
    }
    
    spawning::onspawnplayer( predictedspawn );
    clientfield::set_player_uimodel( "hudItems.playerLivesCount", level.numlives - self.var_a7d7e50a );
    
    if ( self.pers[ #"lives" ] == 1 )
    {
        globallogic_audio::leader_dialog_on_player( "oicLastLife" );
    }
}

// Namespace oic/oic
// Params 1
// Checksum 0xc070e91e, Offset: 0xc50
// Size: 0x3c
function onendgame( *var_c1e98979 )
{
    player = round::function_b5f4c9d8();
    match::set_winner( player );
}

// Namespace oic/oic
// Params 0
// Checksum 0x93a956bf, Offset: 0xc98
// Size: 0xfc
function saveoffallplayersammo()
{
    wait 1;
    
    for ( playerindex = 0; playerindex < level.players.size ; playerindex++ )
    {
        player = level.players[ playerindex ];
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.pers[ #"lives" ] == 0 )
        {
            continue;
        }
        
        currentweapon = player getcurrentweapon();
        player.pers[ #"clip_ammo" ] = player getweaponammoclip( currentweapon );
        player.pers[ #"stock_ammo" ] = player getweaponammostock( currentweapon );
    }
}

// Namespace oic/oic
// Params 1
// Checksum 0x67b3e948, Offset: 0xda0
// Size: 0x4a, Type: bool
function isplayereliminated( player )
{
    return isdefined( player.pers[ #"lives" ] ) && player.pers[ #"lives" ] <= 0;
}

// Namespace oic/oic
// Params 0
// Checksum 0x4f1be5d1, Offset: 0xdf8
// Size: 0x8e
function getplayersleft()
{
    playersremaining = [];
    
    for ( playerindex = 0; playerindex < level.players.size ; playerindex++ )
    {
        player = level.players[ playerindex ];
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isplayereliminated( player ) )
        {
            playersremaining[ playersremaining.size ] = player;
        }
    }
    
    return playersremaining;
}

// Namespace oic/oic
// Params 9
// Checksum 0x5e4a1919, Offset: 0xe90
// Size: 0x254
function onplayerkilled( *einflictor, attacker, *idamage, smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration )
{
    if ( isdefined( shitloc ) && isplayer( shitloc ) && self != shitloc )
    {
        deathanimduration = level.var_bf82f6b0;
        attackerammo = shitloc getammocount( deathanimduration );
        victimammo = self getammocount( deathanimduration );
        
        if ( attackerammo < 3 )
        {
            shitloc giveammo( 1 );
        }
        
        shitloc playlocalsound( "mpl_oic_bullet_pickup" );
        
        if ( psoffsettime == "MOD_MELEE" || psoffsettime == "MOD_MELEE_WEAPON_BUTT" )
        {
            shitloc globallogic_score::givepointstowin( level.pointspermeleekill );
            
            if ( attackerammo > 0 )
            {
                scoreevents::processscoreevent( #"knife_with_ammo_oic", shitloc, self, deathanimduration );
            }
            
            if ( victimammo > attackerammo )
            {
                scoreevents::processscoreevent( #"kill_enemy_with_more_ammo_oic", shitloc, self, deathanimduration );
            }
        }
        else
        {
            shitloc globallogic_score::givepointstowin( level.pointsperweaponkill );
            
            if ( victimammo > attackerammo + 1 )
            {
                scoreevents::processscoreevent( #"kill_enemy_with_more_ammo_oic", shitloc, self, deathanimduration );
            }
        }
        
        if ( self.pers[ #"lives" ] == 0 )
        {
            scoreevents::processscoreevent( #"eliminated_enemy", shitloc, self, deathanimduration );
        }
    }
}

// Namespace oic/oic
// Params 1
// Checksum 0xfd96239, Offset: 0x10f0
// Size: 0x6c
function giveammo( amount )
{
    currentweapon = self getcurrentweapon();
    clipammo = self getweaponammoclip( currentweapon );
    self setweaponammoclip( currentweapon, clipammo + amount );
}

// Namespace oic/oic
// Params 0
// Checksum 0xe3596cd0, Offset: 0x1168
// Size: 0x56, Type: bool
function shouldreceivesurvivorbonus()
{
    if ( isalive( self ) )
    {
        return true;
    }
    
    if ( self.hasspawned && self.pers[ #"lives" ] > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace oic/oic
// Params 0
// Checksum 0xca946d2a, Offset: 0x11c8
// Size: 0x188
function watchelimination()
{
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        level waittill( #"player_eliminated" );
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isdefined( players[ i ] ) && players[ i ] shouldreceivesurvivorbonus() )
            {
                players[ i ].pers[ #"survived" ]++;
                players[ i ].survived = players[ i ].pers[ #"survived" ];
                scoreevents::processscoreevent( #"survivor", players[ i ] );
                players[ i ] globallogic_score::givepointstowin( level.pointsforsurvivalbonus );
            }
        }
        
        survivors = getplayersleft();
        
        if ( survivors.size == 2 )
        {
            level thread function_ce7ffccb();
            continue;
        }
        
        if ( survivors.size < 2 )
        {
            thread globallogic::end_round( 6 );
        }
    }
}

// Namespace oic/oic
// Params 1, eflags: 0x4
// Checksum 0xf808430f, Offset: 0x1358
// Size: 0xec
function private function_ce7ffccb( *winner )
{
    if ( globallogic_utils::gettimeremaining() <= int( level.var_18823aed * 1000 ) )
    {
        return;
    }
    
    if ( level.var_18823aed > 0 )
    {
        level.timelimitoverride = 1;
        setgameendtime( gettime() + int( level.var_18823aed * 1000 ) );
        hostmigration::waitlongdurationwithgameendtimeupdate( level.var_18823aed );
        
        if ( game.state != "playing" )
        {
            return;
        }
    }
    
    thread globallogic::end_round( 2 );
}

