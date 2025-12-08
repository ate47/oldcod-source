#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/drown;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/util;

#namespace contracts;

// Namespace contracts/contracts
// Params 0, eflags: 0x2
// Checksum 0x6769f8d4, Offset: 0x690
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "contracts", &__init__, undefined, undefined );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0x27fa0b6, Offset: 0x6d0
// Size: 0x3c
function __init__()
{
    callback::on_start_gametype( &start_gametype );
    
    /#
        level thread watch_contract_debug();
    #/
}

// Namespace contracts/contracts
// Params 0
// Checksum 0xea7f05e9, Offset: 0x718
// Size: 0x2ac
function start_gametype()
{
    if ( !isdefined( level.challengescallbacks ) )
    {
        level.challengescallbacks = [];
    }
    
    util::init_player_contract_events();
    waittillframeend();
    
    if ( can_process_contracts() )
    {
        /#
            execdevgui( "<dev string:x28>" );
        #/
        
        challenges::registerchallengescallback( "playerKilled", &contract_kills );
        challenges::registerchallengescallback( "gameEnd", &function_ed438349 );
        globallogic_score::registercontractwinevent( &contract_win );
        scoreevents::register_hero_ability_kill_event( &on_hero_ability_kill );
        scoreevents::register_hero_ability_multikill_event( &function_40a4d808 );
        scoreevents::register_hero_weapon_multikill_event( &function_a997af9a );
        util::register_player_contract_event( "score", &on_player_score, 1 );
        util::register_player_contract_event( "killstreak_score", &function_2ef87fc8, 2 );
        util::register_player_contract_event( "offender_kill", &function_88a1d86d );
        util::register_player_contract_event( "defender_kill", &function_f14de7eb );
        util::register_player_contract_event( "headshot", &on_headshot_kill );
        util::register_player_contract_event( "killed_hero_ability_enemy", &function_f4746d43 );
        util::register_player_contract_event( "killed_hero_weapon_enemy", &function_62a41cad );
        util::register_player_contract_event( "earned_specialist_ability_medal", &function_97ca91fe );
    }
    
    callback::on_connect( &on_player_connect );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0xa6446613, Offset: 0x9d0
// Size: 0x1c
function function_f4746d43()
{
    self function_159cc09f( 1014 );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0x658d9323, Offset: 0x9f8
// Size: 0x1c
function function_62a41cad()
{
    self function_159cc09f( 1014 );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0x2ddecb0a, Offset: 0xa20
// Size: 0x3c
function on_player_connect()
{
    player = self;
    
    if ( can_process_contracts() )
    {
        player setup_player_contracts();
    }
}

// Namespace contracts/contracts
// Params 0
// Checksum 0xa902eea9, Offset: 0xa68
// Size: 0x42, Type: bool
function can_process_contracts()
{
    if ( getdvarint( "contracts_enabled_mp", 1 ) == 0 )
    {
        return false;
    }
    
    return challenges::canprocesschallenges();
}

// Namespace contracts/contracts
// Params 0
// Checksum 0xb8dff1f4, Offset: 0xab8
// Size: 0x1da
function setup_player_contracts()
{
    player = self;
    player.pers[ "contracts" ] = [];
    
    if ( player isbot() )
    {
        return;
    }
    
    for ( slot = 0; slot < 10 ; slot++ )
    {
        if ( get_contract_stat( slot, "active" ) && !get_contract_stat( slot, "award_given" ) )
        {
            var_62d51442 = get_contract_stat( slot, "index" );
            player.pers[ "contracts" ][ var_62d51442 ] = spawnstruct();
            player.pers[ "contracts" ][ var_62d51442 ].slot = slot;
            var_63cc7b72 = tablelookuprownum( "gamedata/tables/mp/mp_contractTable.csv", 0, var_62d51442 );
            player.pers[ "contracts" ][ var_62d51442 ].var_63cc7b72 = var_63cc7b72;
            player.pers[ "contracts" ][ var_62d51442 ].target_value = int( tablelookupcolumnforrow( "gamedata/tables/mp/mp_contractTable.csv", var_63cc7b72, 2 ) );
        }
    }
}

/#

    // Namespace contracts/contracts
    // Params 0
    // Checksum 0x159d2a86, Offset: 0xca0
    // Size: 0x678, Type: dev
    function watch_contract_debug()
    {
        level notify( #"watch_contract_debug_singleton" );
        level endon( #"watch_contract_debug_singleton" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x46>" ) > 0 )
            {
                if ( isdefined( level.players ) )
                {
                    new_index = getdvarint( "<dev string:x68>", 0 );
                    
                    foreach ( player in level.players )
                    {
                        if ( !isdefined( player ) )
                        {
                            continue;
                        }
                        
                        if ( player isbot() )
                        {
                            continue;
                        }
                        
                        for ( slot = 0; slot < 10 ; slot++ )
                        {
                            player function_4596db81( slot, "<dev string:x84>", 0 );
                        }
                        
                        iprintln( "<dev string:x8b>" + player.name );
                        player setup_player_contracts();
                    }
                }
                
                setdvar( "<dev string:x46>", 0 );
            }
            
            if ( getdvarint( "<dev string:x68>", 0 ) > 0 )
            {
                if ( isdefined( level.players ) )
                {
                    new_index = getdvarint( "<dev string:x68>", 0 );
                    
                    foreach ( player in level.players )
                    {
                        if ( !isdefined( player ) )
                        {
                            continue;
                        }
                        
                        if ( player isbot() )
                        {
                            continue;
                        }
                        
                        var_593adc20 = getdvarint( "<dev string:xaf>", 9 );
                        player function_4596db81( var_593adc20, "<dev string:x84>", 1 );
                        player function_4596db81( var_593adc20, "<dev string:xc7>", new_index );
                        player function_4596db81( var_593adc20, "<dev string:xcd>", 0 );
                        player function_4596db81( var_593adc20, "<dev string:xd6>", 0 );
                        player setup_player_contracts();
                        iprintln( "<dev string:xe2>" + var_593adc20 + "<dev string:xf1>" + new_index + "<dev string:x106>" + player.name + "<dev string:x10c>" );
                    }
                }
                
                setdvar( "<dev string:x68>", 0 );
            }
            
            if ( getdvarint( "<dev string:x11e>", 0 ) > 0 )
            {
                if ( isdefined( level.players ) )
                {
                    var_593adc20 = getdvarint( "<dev string:xaf>", 9 );
                    iprintln( "<dev string:x141>" );
                    
                    foreach ( player in level.players )
                    {
                        if ( !isdefined( player ) )
                        {
                            continue;
                        }
                        
                        if ( player isbot() )
                        {
                            continue;
                        }
                        
                        if ( var_593adc20 >= 3 )
                        {
                            player function_4596db81( var_593adc20, "<dev string:x84>", 0 );
                            player setup_player_contracts();
                            iprintln( "<dev string:xe2>" + var_593adc20 + "<dev string:x154>" + player.name );
                            continue;
                        }
                        
                        iprintln( "<dev string:xe2>" + var_593adc20 + "<dev string:x166>" + player.name );
                    }
                }
                
                setdvar( "<dev string:x11e>", 0 );
            }
            
            if ( getdvarint( "<dev string:x178>", 0 ) > 0 )
            {
                iprintln( "<dev string:x198>" );
                setdvar( "<dev string:x178>", 0 );
            }
            
            if ( getdvarint( "<dev string:x1c8>", 0 ) > 0 )
            {
                iprintln( "<dev string:x1e2>" );
                setdvar( "<dev string:x1c8>", 0 );
            }
            
            wait 0.5;
        }
    }

#/

// Namespace contracts/contracts
// Params 1
// Checksum 0xe6b3536a, Offset: 0x1320
// Size: 0x98, Type: bool
function is_contract_active( challenge_index )
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.pers[ "contracts" ] ) )
    {
        return false;
    }
    
    if ( !isdefined( self.pers[ "contracts" ][ challenge_index ] ) )
    {
        return false;
    }
    
    if ( self.pers[ "contracts" ][ challenge_index ].var_63cc7b72 == -1 )
    {
        return false;
    }
    
    return true;
}

// Namespace contracts/contracts
// Params 2
// Checksum 0xb0694623, Offset: 0x13c0
// Size: 0x4a
function on_hero_ability_kill( ability, victimability )
{
    player = self;
    
    if ( !isdefined( player ) || !isplayer( player ) )
    {
        return;
    }
}

// Namespace contracts/contracts
// Params 0
// Checksum 0xa191dd71, Offset: 0x1418
// Size: 0x6c
function function_97ca91fe()
{
    player = self;
    
    if ( !isdefined( player ) || !isplayer( player ) )
    {
        return;
    }
    
    player function_159cc09f( 1013 );
    player function_159cc09f( 3 );
}

// Namespace contracts/contracts
// Params 2
// Checksum 0xa7928f, Offset: 0x1490
// Size: 0x4a
function function_40a4d808( killcount, ability )
{
    player = self;
    
    if ( !isdefined( player ) || !isplayer( player ) )
    {
        return;
    }
}

// Namespace contracts/contracts
// Params 2
// Checksum 0x281641c4, Offset: 0x14e8
// Size: 0x4a
function function_a997af9a( killcount, weapon )
{
    player = self;
    
    if ( !isdefined( player ) || !isplayer( player ) )
    {
        return;
    }
}

// Namespace contracts/contracts
// Params 1
// Checksum 0xfe61a70, Offset: 0x1540
// Size: 0x4c
function on_player_score( delta_score )
{
    self function_159cc09f( 1009, delta_score );
    self function_159cc09f( 5, delta_score );
}

// Namespace contracts/contracts
// Params 2
// Checksum 0x587aba9d, Offset: 0x1598
// Size: 0x3c
function function_2ef87fc8( delta_score, var_19f0ea25 )
{
    if ( var_19f0ea25 )
    {
        self function_159cc09f( 1011, delta_score );
    }
}

// Namespace contracts/contracts
// Params 1
// Checksum 0x5e38a1dd, Offset: 0x15e0
// Size: 0x3cc
function contract_kills( data )
{
    victim = data.victim;
    attacker = data.attacker;
    player = attacker;
    weapon = data.weapon;
    time = data.time;
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        return;
    }
    
    if ( !isdefined( player ) || !isplayer( player ) )
    {
        return;
    }
    
    player function_159cc09f( 1015 );
    player function_159cc09f( 4 );
    
    if ( weapon.isheroweapon === 1 )
    {
        player function_159cc09f( 1012 );
        player function_159cc09f( 7 );
    }
    
    iskillstreak = isdefined( data.einflictor ) && isdefined( data.einflictor.killstreakid );
    
    if ( !iskillstreak && isdefined( level.iskillstreakweapon ) )
    {
        iskillstreakweapon = [[ level.iskillstreakweapon ]]( weapon );
    }
    
    if ( iskillstreak || iskillstreakweapon === 1 )
    {
        player function_159cc09f( 1010 );
        player function_159cc09f( 8 );
    }
    
    var_aedadde = weapon.statindex;
    
    if ( player isitempurchased( var_aedadde ) )
    {
        weaponclass = util::getweaponclass( weapon );
        
        switch ( weaponclass )
        {
            case #"weapon_assault":
                player function_159cc09f( 1019 );
                break;
            case #"weapon_smg":
                player function_159cc09f( 1020 );
                break;
            case #"weapon_sniper":
                player function_159cc09f( 1021 );
                break;
            case #"weapon_lmg":
                player function_159cc09f( 1022 );
                break;
            case #"weapon_cqb":
                player function_159cc09f( 1023 );
                break;
            case #"weapon_pistol":
                player function_159cc09f( 1024 );
                break;
            default:
                break;
        }
        
        var_ae1dbd9f = player gettotalunlockedweaponattachments( weapon );
        
        if ( var_ae1dbd9f >= 4 )
        {
            player function_159cc09f( 1025 );
        }
    }
}

// Namespace contracts/contracts
// Params 2
// Checksum 0xc691e39f, Offset: 0x19b8
// Size: 0x4c
function function_159cc09f( var_62d51442, delta )
{
    if ( self is_contract_active( var_62d51442 ) )
    {
        self function_393b42c0( var_62d51442, delta );
    }
}

// Namespace contracts/contracts
// Params 2
// Checksum 0xa1ee5b71, Offset: 0x1a10
// Size: 0x4a4
function function_393b42c0( var_62d51442, delta )
{
    if ( !isdefined( delta ) )
    {
        delta = 1;
    }
    
    slot = self.pers[ "contracts" ][ var_62d51442 ].slot;
    target_value = self.pers[ "contracts" ][ var_62d51442 ].target_value;
    
    /#
        if ( getdvarint( "<dev string:x208>", 0 ) > 0 )
        {
            delta *= getdvarint( "<dev string:x208>", 1 );
        }
    #/
    
    old_progress = get_contract_stat( slot, "progress" );
    new_progress = old_progress + delta;
    
    if ( new_progress > target_value )
    {
        new_progress = target_value;
    }
    
    if ( new_progress != old_progress )
    {
        self function_4596db81( slot, "progress", new_progress );
    }
    
    just_completed = 0;
    
    if ( old_progress < target_value && target_value <= new_progress )
    {
        just_completed = 1;
        event = &"mp_weekly_challenge_complete";
        var_4836ff5c = 0;
        
        if ( slot == 2 )
        {
            event = &"mp_daily_challenge_complete";
            var_4836ff5c = 1;
            self function_7f3b8f93( function_8020225b() );
            self function_4596db81( 2, "award_given", 1 );
        }
        else if ( slot == 0 || slot == 1 )
        {
            var_33bbd9b0 = 1;
            
            if ( slot == 1 )
            {
                var_33bbd9b0 = 0;
            }
            
            foreach ( var_38be1b03 in self.pers[ "contracts" ] )
            {
                if ( var_38be1b03.slot == var_33bbd9b0 )
                {
                    if ( var_38be1b03.target_value <= get_contract_stat( var_33bbd9b0, "progress" ) )
                    {
                        var_4836ff5c = 1;
                        self function_7f3b8f93( function_ad00e83() );
                        self function_4596db81( 0, "award_given", 1 );
                        self function_4596db81( 1, "award_given", 1 );
                    }
                    
                    break;
                }
            }
        }
        
        /#
            var_593adc20 = getdvarint( "<dev string:xaf>", 9 );
            
            if ( slot == var_593adc20 )
            {
                if ( var_62d51442 >= 1000 && var_62d51442 <= 2999 )
                {
                    event = &"<dev string:x226>";
                }
                
                var_4836ff5c = 1;
            }
        #/
        
        self luinotifyevent( event, 2, var_62d51442, var_4836ff5c );
    }
    
    /#
        if ( getdvarint( "<dev string:x242>", 0 ) > 0 )
        {
            iprintln( "<dev string:xe2>" + slot + "<dev string:x255>" + var_62d51442 + "<dev string:x263>" + new_progress + "<dev string:x26f>" + target_value );
        }
    #/
}

// Namespace contracts/contracts
// Params 2
// Checksum 0x674e1c35, Offset: 0x1ec0
// Size: 0x3a
function get_contract_stat( slot, stat_name )
{
    return self getdstat( "contracts", slot, stat_name );
}

// Namespace contracts/contracts
// Params 3
// Checksum 0x7956628c, Offset: 0x1f08
// Size: 0x42
function function_4596db81( slot, stat_name, stat_value )
{
    return self setdstat( "contracts", slot, stat_name, stat_value );
}

// Namespace contracts/contracts
// Params 1
// Checksum 0x21113b3d, Offset: 0x1f58
// Size: 0xac
function function_7f3b8f93( amount )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( amount <= 0 )
    {
        return;
    }
    
    current_amount = isdefined( self getdstat( "mp_loot_xp_due" ) ) ? self getdstat( "mp_loot_xp_due" ) : 0;
    new_amount = current_amount + amount;
    self setdstat( "mp_loot_xp_due", new_amount );
}

// Namespace contracts/contracts
// Params 2
// Checksum 0x94f2a12, Offset: 0x2010
// Size: 0x11a
function get_hero_weapon_mask( attacker, weapon )
{
    if ( !isdefined( weapon ) )
    {
        return 0;
    }
    
    switch ( weapon.name )
    {
        case #"hero_minigun":
            return 1;
        case #"hero_flamethrower":
            return 2;
        case #"hero_lightninggun":
        case #"hero_lightninggun_arc":
            return 4;
        case #"hero_chemicalgelgun":
        case #"hero_firefly_swarm":
            return 8;
        case #"hero_pineapple_grenade":
        case #"hero_pineapplegun":
            return 16;
        case #"hero_armblade":
            return 32;
        case #"hero_bowlauncher":
        case #"hero_bowlauncher2":
        case #"hero_bowlauncher3":
        case #"hero_bowlauncher4":
            return 64;
        case #"hero_gravityspikes":
            return 128;
        case #"hero_annihilator":
            return 256;
        default:
            return 0;
    }
}

// Namespace contracts/contracts
// Params 1
// Checksum 0xf1d419c9, Offset: 0x2138
// Size: 0xe2
function get_hero_ability_mask( ability )
{
    if ( !isdefined( ability ) )
    {
        return 0;
    }
    
    switch ( ability.name )
    {
        case #"gadget_clone":
            return 1;
        case #"gadget_heat_wave":
            return 2;
        case #"gadget_flashback":
            return 4;
        case #"gadget_resurrect":
            return 8;
        case #"gadget_armor":
            return 16;
        case #"gadget_camo":
            return 32;
        case #"gadget_vision_pulse":
            return 64;
        case #"gadget_speed_burst":
            return 128;
        case #"gadget_combat_efficiency":
            return 256;
        default:
            return 0;
    }
}

// Namespace contracts/contracts
// Params 1
// Checksum 0x2e4a5403, Offset: 0x2228
// Size: 0xc
function function_ed438349( data )
{
    
}

// Namespace contracts/contracts
// Params 1
// Checksum 0xf212922c, Offset: 0x2240
// Size: 0xc4
function contract_win( winner )
{
    winner function_159cc09f( 1000 );
    winner function_159cc09f( 1 );
    
    if ( util::is_objective_game( level.gametype ) )
    {
        winner function_159cc09f( 2 );
    }
    
    if ( isarenamode() )
    {
        winner function_159cc09f( 1001 );
    }
    
    function_6bbf5440( winner );
}

// Namespace contracts/contracts
// Params 1
// Checksum 0xee516ed6, Offset: 0x2310
// Size: 0x1c2
function function_6bbf5440( winner )
{
    switch ( level.gametype )
    {
        case #"tdm":
            winner function_159cc09f( 1002 );
            break;
        case #"ball":
            winner function_159cc09f( 1003 );
            break;
        case #"escort":
            winner function_159cc09f( 1004 );
            break;
        case #"conf":
            winner function_159cc09f( 1005 );
            break;
        case #"sd":
            winner function_159cc09f( 1006 );
            break;
        case #"koth":
            winner function_159cc09f( 1007 );
            break;
        case #"dom":
            winner function_159cc09f( 1008 );
            break;
        case #"ctf":
            winner function_159cc09f( 1026 );
            break;
        case #"dem":
            winner function_159cc09f( 1027 );
            break;
        case #"dm":
            winner function_159cc09f( 1028 );
            break;
        default:
            break;
    }
}

// Namespace contracts/contracts
// Params 0
// Checksum 0x17d967dd, Offset: 0x24e0
// Size: 0x34
function function_88a1d86d()
{
    self function_159cc09f( 1018 );
    self function_159cc09f( 6 );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0x580ba6ae, Offset: 0x2520
// Size: 0x34
function function_f14de7eb()
{
    self function_159cc09f( 1017 );
    self function_159cc09f( 6 );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0xb154b007, Offset: 0x2560
// Size: 0x24
function on_headshot_kill()
{
    self function_159cc09f( 1016, 1 );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0x2fa78377, Offset: 0x2590
// Size: 0x238
function function_d27143cc()
{
    player = self;
    
    if ( !isdefined( player.pers[ "contracts" ] ) )
    {
        return 0;
    }
    
    var_33894d1e = 0;
    var_fad2205f = 2;
    
    if ( get_contract_stat( var_fad2205f, "active" ) && !get_contract_stat( var_fad2205f, "award_given" ) )
    {
        if ( function_9771fff9( var_fad2205f ) )
        {
            var_33894d1e += player function_8020225b();
            player function_4596db81( var_fad2205f, "award_given", 1 );
        }
    }
    
    var_bfbff963 = 0;
    var_4db88a28 = 1;
    
    if ( get_contract_stat( var_bfbff963, "active" ) && !get_contract_stat( var_bfbff963, "award_given" ) && get_contract_stat( var_4db88a28, "active" ) && !get_contract_stat( var_4db88a28, "award_given" ) )
    {
        if ( function_9771fff9( var_bfbff963 ) && function_9771fff9( var_4db88a28 ) )
        {
            var_33894d1e += player function_ad00e83();
            player function_4596db81( var_bfbff963, "award_given", 1 );
            player function_4596db81( var_4db88a28, "award_given", 1 );
        }
    }
    
    return var_33894d1e;
}

// Namespace contracts/contracts
// Params 1
// Checksum 0x4a69f271, Offset: 0x27d0
// Size: 0xd2, Type: bool
function function_9771fff9( slot )
{
    player = self;
    var_62d51442 = get_contract_stat( slot, "index" );
    
    if ( !isdefined( player.pers[ "contracts" ][ var_62d51442 ] ) )
    {
        return false;
    }
    
    progress = player get_contract_stat( slot, "progress" );
    target_value = player.pers[ "contracts" ][ var_62d51442 ].target_value;
    return progress >= target_value;
}

// Namespace contracts/contracts
// Params 0
// Checksum 0x97c72e02, Offset: 0x28b0
// Size: 0x3c
function function_8020225b()
{
    return getdvarint( "daily_contract_cryptokey_reward_count", 10 ) * getdvarint( "loot_cryptokeyCost", 100 );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0x9e9d4604, Offset: 0x28f8
// Size: 0x54
function function_ad00e83()
{
    self function_84c79e8a();
    return getdvarint( "weekly_contract_cryptokey_reward_count", 30 ) * getdvarint( "loot_cryptokeyCost", 100 );
}

// Namespace contracts/contracts
// Params 0
// Checksum 0xabc57e1, Offset: 0x2958
// Size: 0x7c
function function_84c79e8a()
{
    contract_count = self getdstat( "blackjack_contract_count" );
    reward_count = getdvarint( "weekly_contract_blackjack_contract_reward_count", 1 );
    self setdstat( "blackjack_contract_count", contract_count + reward_count );
}

