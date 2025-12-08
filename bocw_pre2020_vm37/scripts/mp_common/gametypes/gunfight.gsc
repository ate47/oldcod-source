#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\util;

#namespace gunfight;

// Namespace gunfight/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xae8ed3e6, Offset: 0x138
// Size: 0x1a8
function event_handler[gametype_init] main( *eventstruct )
{
    globallogic::init();
    util::registerroundscorelimit( 0, 10000 );
    level.takelivesondeath = 1;
    level.var_f5a73a96 = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundswitch = &onroundswitch;
    level.ondeadevent = &ondeadevent;
    callback::on_spawned( &onspawned );
    spawning::addsupportedspawnpointtype( "tdm" );
    spawning::function_32b97d1b( &spawning::function_90dee50d );
    spawning::function_adbbb58a( &spawning::function_c24e290c );
    
    if ( !isdefined( game.var_96a8ff4a ) )
    {
        bundle = getscriptbundle( "mp_gunfight_loadouts" );
        assert( isdefined( bundle ) );
        game.var_96a8ff4a = array::randomize( bundle.defaultloadouts );
        game.var_b6beb735 = 0;
    }
}

// Namespace gunfight/gunfight
// Params 0
// Checksum 0xc5d7549a, Offset: 0x2e8
// Size: 0x1c
function onstartgametype()
{
    level thread onscoreclosemusic();
}

// Namespace gunfight/gunfight
// Params 1
// Checksum 0x875c2b5e, Offset: 0x310
// Size: 0x6c
function onspawnplayer( predictedspawn )
{
    if ( spawning::usestartspawns() && !level.ingraceperiod && !level.playerqueuedrespawn )
    {
        spawning::function_7a87efaa();
    }
    
    spawning::onspawnplayer( predictedspawn );
}

// Namespace gunfight/gunfight
// Params 0
// Checksum 0x94b8b18d, Offset: 0x388
// Size: 0x118
function onspawned()
{
    self takeallweapons();
    self clearperks();
    self cleartalents();
    self function_44244433( game.var_96a8ff4a[ game.var_b6beb735 ] );
    perks = self getloadoutperks( 0 );
    
    foreach ( perk in perks )
    {
        self setperk( perk );
    }
}

// Namespace gunfight/gunfight
// Params 1
// Checksum 0x6961831b, Offset: 0x4a8
// Size: 0x5c
function ondeadevent( team )
{
    if ( team == game.attackers )
    {
        globallogic::function_a3e3bd39( game.defenders, 6 );
        return;
    }
    
    globallogic::function_a3e3bd39( game.attackers, 6 );
}

// Namespace gunfight/gunfight
// Params 0
// Checksum 0x992ddd9d, Offset: 0x510
// Size: 0x74
function onroundswitch()
{
    gametype::on_round_switch();
    globallogic_score::function_9779ac61();
    
    if ( util::getroundsplayed() % 2 == 0 )
    {
        game.var_b6beb735++;
        
        if ( game.var_b6beb735 >= game.var_96a8ff4a.size )
        {
            game.var_b6beb735 = 0;
        }
    }
}

// Namespace gunfight/gunfight
// Params 0
// Checksum 0x47178718, Offset: 0x590
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

// Namespace gunfight/gunfight
// Params 1
// Checksum 0x551c547c, Offset: 0x738
// Size: 0x51c
function function_44244433( loadout )
{
    primary = loadout.primary;
    primaryattachments = function_8fdeea14( loadout.primaryattachments );
    secondary = loadout.secondary;
    secondaryattachments = function_8fdeea14( loadout.secondaryattachments );
    talents = loadout.talents;
    primarygrenade = loadout.primarygrenade;
    
    if ( is_true( loadout.var_1c89585f ) )
    {
        talents[ talents.size ] = { #talent:#"hash_25c2dcf9ec4c42e2" };
    }
    
    secondarygrenade = loadout.secondarygrenade;
    
    if ( is_true( loadout.var_285151c1 ) )
    {
        talents[ talents.size ] = { #talent:#"hash_1ef9a210c389803a" };
    }
    
    specialgrenade = loadout.specialgrenade;
    
    if ( isdefined( primary ) )
    {
        primaryweapon = getweapon( primary, primaryattachments );
        self giveweapon( primaryweapon );
        self givestartammo( primaryweapon );
        self setblockweaponpickup( primaryweapon, 1 );
        self switchtoweapon( primaryweapon, 1 );
        self loadout::function_442539( "primary", primaryweapon );
    }
    
    if ( isdefined( secondary ) )
    {
        secondaryweapon = getweapon( secondary, secondaryattachments );
        self giveweapon( secondaryweapon );
        self givestartammo( secondaryweapon );
        self setblockweaponpickup( secondaryweapon, 1 );
        self loadout::function_442539( "secondary", secondaryweapon );
    }
    
    if ( isdefined( talents ) )
    {
        foreach ( element in talents )
        {
            if ( isdefined( element.talent ) && element.talent != "weapon_null" )
            {
                self addtalent( element.talent );
            }
        }
    }
    
    if ( isdefined( primarygrenade ) )
    {
        var_8e797a67 = getweapon( primarygrenade );
        self giveweapon( var_8e797a67 );
        self givemaxammo( var_8e797a67 );
        self setblockweaponpickup( var_8e797a67, 1 );
        self loadout::function_442539( "primarygrenade", var_8e797a67 );
    }
    
    if ( isdefined( secondarygrenade ) )
    {
        var_a66b455e = getweapon( secondarygrenade );
        self giveweapon( var_a66b455e );
        self givemaxammo( var_a66b455e );
        self setblockweaponpickup( var_a66b455e, 1 );
        self loadout::function_442539( "secondarygrenade", var_a66b455e );
    }
    
    if ( isdefined( specialgrenade ) )
    {
        var_8b0bfce9 = getweapon( specialgrenade );
        self giveweapon( var_8b0bfce9 );
        self setblockweaponpickup( var_8b0bfce9, 1 );
        self loadout::function_442539( "specialgrenade", var_8b0bfce9 );
    }
}

// Namespace gunfight/gunfight
// Params 1
// Checksum 0x8a86c6ac, Offset: 0xc60
// Size: 0xce
function function_8fdeea14( var_b3d10ae7 )
{
    var_9fb603ac = [];
    
    if ( isdefined( var_b3d10ae7 ) )
    {
        foreach ( element in var_b3d10ae7 )
        {
            if ( isdefined( element.attachment ) && element.attachment != "weapon_null" )
            {
                var_9fb603ac[ var_9fb603ac.size ] = element.attachment;
            }
        }
    }
    
    return var_9fb603ac;
}

