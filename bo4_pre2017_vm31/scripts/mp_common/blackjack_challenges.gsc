#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/drown;
#using scripts/core_common/player_role;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/util;

#namespace blackjack_challenges;

// Namespace blackjack_challenges/blackjack_challenges
// Params 0, eflags: 0x2
// Checksum 0x43699c62, Offset: 0x560
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "blackjack_challenges", &__init__, undefined, undefined );
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 0
// Checksum 0xe4c708a6, Offset: 0x5a0
// Size: 0x24
function __init__()
{
    callback::on_start_gametype( &start_gametype );
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 0
// Checksum 0xdc7b8a58, Offset: 0x5d0
// Size: 0xf4
function start_gametype()
{
    if ( !isdefined( level.challengescallbacks ) )
    {
        level.challengescallbacks = [];
    }
    
    waittillframeend();
    
    if ( challenges::canprocesschallenges() )
    {
        challenges::registerchallengescallback( "playerKilled", &challenge_kills );
        challenges::registerchallengescallback( "roundEnd", &challenge_round_ended );
        challenges::registerchallengescallback( "gameEnd", &challenge_game_ended );
        scoreevents::register_hero_ability_kill_event( &on_hero_ability_kill );
    }
    
    callback::on_connect( &on_player_connect );
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 0
// Checksum 0x10e71678, Offset: 0x6d0
// Size: 0x19a
function on_player_connect()
{
    player = self;
    
    if ( challenges::canprocesschallenges() )
    {
        specialistindex = player player_role::get();
        isblackjack = specialistindex == 9;
        
        if ( isblackjack )
        {
            player thread track_blackjack_consumable();
            
            if ( !isdefined( self.pers[ "blackjack_challenge_active" ] ) )
            {
                remaining_time = player consumableget( "blackjack", "awarded" ) - player consumableget( "blackjack", "consumed" );
                
                if ( remaining_time > 0 )
                {
                    special_card_earned = player get_challenge_stat( "special_card_earned" );
                    
                    if ( !special_card_earned )
                    {
                        player.pers[ "blackjack_challenge_active" ] = 1;
                        player.pers[ "blackjack_unique_specialist_kills" ] = 0;
                        player.pers[ "blackjack_specialist_kills" ] = 0;
                        player.pers[ "blackjack_unique_weapon_mask" ] = 0;
                        player.pers[ "blackjack_unique_ability_mask" ] = 0;
                    }
                }
            }
        }
    }
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 0
// Checksum 0x14c447ec, Offset: 0x878
// Size: 0x1a, Type: bool
function is_challenge_active()
{
    return self.pers[ "blackjack_challenge_active" ] === 1;
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 2
// Checksum 0x8b564e5a, Offset: 0x8a0
// Size: 0x164
function on_hero_ability_kill( ability, victimability )
{
    player = self;
    
    if ( !isdefined( player ) || !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.isroulette ) || !player.isroulette )
    {
        return;
    }
    
    if ( player is_challenge_active() )
    {
        player.pers[ "blackjack_specialist_kills" ]++;
        currentheroabilitymask = player.pers[ "blackjack_unique_ability_mask" ];
        heroabilitymask = get_hero_ability_mask( ability );
        newheroabilitymask = heroabilitymask | currentheroabilitymask;
        
        if ( newheroabilitymask != currentheroabilitymask )
        {
            player.pers[ "blackjack_unique_specialist_kills" ]++;
            player.pers[ "blackjack_unique_ability_mask" ] = newheroabilitymask;
        }
        
        player check_blackjack_challenge();
    }
}

/#

    // Namespace blackjack_challenges/blackjack_challenges
    // Params 0
    // Checksum 0x52f18cff, Offset: 0xa10
    // Size: 0x44, Type: dev
    function debug_print_already_earned()
    {
        if ( getdvarint( "<dev string:x28>", 0 ) == 0 )
        {
            return;
        }
        
        iprintln( "<dev string:x44>" );
    }

    // Namespace blackjack_challenges/blackjack_challenges
    // Params 0
    // Checksum 0x331f3956, Offset: 0xa60
    // Size: 0x8c, Type: dev
    function debug_print_kill_info()
    {
        if ( getdvarint( "<dev string:x28>", 0 ) == 0 )
        {
            return;
        }
        
        player = self;
        iprintln( "<dev string:x71>" + player.pers[ "<dev string:x8c>" ] + "<dev string:xa7>" + player.pers[ "<dev string:xb3>" ] );
    }

    // Namespace blackjack_challenges/blackjack_challenges
    // Params 0
    // Checksum 0x7866b5f7, Offset: 0xaf8
    // Size: 0x44, Type: dev
    function debug_print_earned()
    {
        if ( getdvarint( "<dev string:x28>", 0 ) == 0 )
        {
            return;
        }
        
        iprintln( "<dev string:xd5>" );
    }

#/

// Namespace blackjack_challenges/blackjack_challenges
// Params 0
// Checksum 0x925532ad, Offset: 0xb48
// Size: 0x10c
function check_blackjack_challenge()
{
    player = self;
    
    /#
        debug_print_kill_info();
    #/
    
    special_card_earned = player get_challenge_stat( "special_card_earned" );
    
    if ( special_card_earned )
    {
        /#
            debug_print_already_earned();
        #/
        
        return;
    }
    
    if ( player.pers[ "blackjack_specialist_kills" ] >= 4 && player.pers[ "blackjack_unique_specialist_kills" ] >= 2 )
    {
        player set_challenge_stat( "special_card_earned", 1 );
        player addplayerstat( "blackjack_challenge", 1 );
        
        /#
            debug_print_earned();
        #/
    }
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 1
// Checksum 0x603291bb, Offset: 0xc60
// Size: 0x23c
function challenge_kills( data )
{
    attackeristhief = data.attackeristhief;
    attackerisroulette = data.attackerisroulette;
    attackeristhieforroulette = attackeristhief || attackerisroulette;
    
    if ( !attackeristhieforroulette )
    {
        return;
    }
    
    victim = data.victim;
    attacker = data.attacker;
    player = attacker;
    weapon = data.weapon;
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        return;
    }
    
    if ( !isdefined( player ) || !isplayer( player ) )
    {
        return;
    }
    
    if ( attackeristhief )
    {
        if ( weapon.isheroweapon === 1 )
        {
            if ( player is_challenge_active() )
            {
                player.pers[ "blackjack_specialist_kills" ]++;
                currentheroweaponmask = player.pers[ "blackjack_unique_weapon_mask" ];
                heroweaponmask = get_hero_weapon_mask( attacker, weapon );
                newheroweaponmask = heroweaponmask | currentheroweaponmask;
                
                if ( newheroweaponmask != currentheroweaponmask )
                {
                    player.pers[ "blackjack_unique_specialist_kills" ] = player.pers[ "blackjack_unique_specialist_kills" ] + 1;
                    player.pers[ "blackjack_unique_weapon_mask" ] = newheroweaponmask;
                }
                
                player check_blackjack_challenge();
            }
        }
    }
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 1
// Checksum 0xffdf8537, Offset: 0xea8
// Size: 0x2a
function get_challenge_stat( stat_name )
{
    return self getdstat( "tenthspecialistcontract", stat_name );
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 2
// Checksum 0xac145817, Offset: 0xee0
// Size: 0x3a
function set_challenge_stat( stat_name, stat_value )
{
    return self setdstat( "tenthspecialistcontract", stat_name, stat_value );
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 2
// Checksum 0xc89d1d6e, Offset: 0xf28
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

// Namespace blackjack_challenges/blackjack_challenges
// Params 1
// Checksum 0x1f74449d, Offset: 0x1050
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

// Namespace blackjack_challenges/blackjack_challenges
// Params 1
// Checksum 0xf6a02fb, Offset: 0x1140
// Size: 0x9c
function challenge_game_ended( data )
{
    if ( !isdefined( data ) )
    {
        return;
    }
    
    player = data.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player isbot() )
    {
        return;
    }
    
    if ( !player is_challenge_active() )
    {
        return;
    }
    
    player report_consumable();
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 1
// Checksum 0x6e484138, Offset: 0x11e8
// Size: 0x9c
function challenge_round_ended( data )
{
    if ( !isdefined( data ) )
    {
        return;
    }
    
    player = data.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player isbot() )
    {
        return;
    }
    
    if ( !player is_challenge_active() )
    {
        return;
    }
    
    player report_consumable();
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 0
// Checksum 0x62017033, Offset: 0x1290
// Size: 0xe0
function track_blackjack_consumable()
{
    level endon( #"game_ended" );
    self notify( #"track_blackjack_consumable_singleton" );
    self endon( #"track_blackjack_consumable_singleton" );
    self endon( #"disconnect" );
    player = self;
    
    if ( !isdefined( player.last_blackjack_consumable_time ) )
    {
        player.last_blackjack_consumable_time = 0;
    }
    
    while ( isdefined( player ) )
    {
        random_wait_time = getdvarfloat( "mp_blackjack_consumable_wait", 20 ) + randomfloatrange( -5, 5 );
        wait random_wait_time;
        player report_consumable();
    }
}

// Namespace blackjack_challenges/blackjack_challenges
// Params 0
// Checksum 0xaae607fc, Offset: 0x1378
// Size: 0x178
function report_consumable()
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.timeplayed ) || !isdefined( player.timeplayed[ "total" ] ) )
    {
        return;
    }
    
    current_time_played = player.timeplayed[ "total" ];
    time_to_report = current_time_played - player.last_blackjack_consumable_time;
    
    if ( time_to_report > 0 )
    {
        max_time_to_report = player consumableget( "blackjack", "awarded" ) - player consumableget( "blackjack", "consumed" );
        consumable_increment = int( min( time_to_report, max_time_to_report ) );
        
        if ( consumable_increment > 0 )
        {
            player consumableincrement( "blackjack", "consumed", consumable_increment );
        }
    }
    
    player.last_blackjack_consumable_time = current_time_played;
}

