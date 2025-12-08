#using script_18077945bb84ede7;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_utility;

#namespace namespace_d4ecbbf0;

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 0, eflags: 0x6
// Checksum 0x91e13f50, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_6750752a31e788e2", &preinit, undefined, undefined, undefined );
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 0, eflags: 0x4
// Checksum 0x6c0e8866, Offset: 0x118
// Size: 0x74
function private preinit()
{
    callback::on_item_pickup( &on_item_pickup );
    callback::add_callback( #"objective_ended", &function_37c1c391 );
    callback::function_74872db6( &function_74872db6 );
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 2, eflags: 0x4
// Checksum 0xe7d4ab8c, Offset: 0x198
// Size: 0x4c
function private function_2ea9419c( type, amount = 1 )
{
    self stats::inc_stat( #"hash_65febbdf3f1ab4d7", type, amount );
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 1
// Checksum 0x19e6b30b, Offset: 0x1f0
// Size: 0x3c
function function_d59d7b74( amount = 1 )
{
    function_2ea9419c( #"rare", amount );
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 1
// Checksum 0xc3495ac6, Offset: 0x238
// Size: 0x3c
function function_89a45cd4( amount = 1 )
{
    function_2ea9419c( #"epic", amount );
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 1
// Checksum 0xcdd7ef8b, Offset: 0x280
// Size: 0x3c
function function_74f5b460( amount = 1 )
{
    function_2ea9419c( #"legendary", amount );
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 0
// Checksum 0xd3da85c6, Offset: 0x2c8
// Size: 0xa0
function function_37c1c391()
{
    players = getplayers();
    
    foreach ( player in players )
    {
        player function_73cddc69();
    }
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 0
// Checksum 0x3218305e, Offset: 0x370
// Size: 0xb8
function function_74872db6()
{
    if ( level.round_number % 5 == 0 )
    {
        players = getplayers();
        
        foreach ( player in players )
        {
            player function_73cddc69();
        }
    }
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 0
// Checksum 0xda6a472d, Offset: 0x430
// Size: 0x48c
function function_73cddc69()
{
    self iprintlnbold( "MILESTONE REACHED, DARK AETHER REWARDED" );
    
    if ( zm_utility::is_survival() )
    {
        star_rating = zm_utility::function_e3025ca5();
        var_ef5aac55 = star_rating * 500;
        var_ef5aac55 = math::clamp( var_ef5aac55, 0, 5000 );
        sr_scrap::function_afab250a( var_ef5aac55 );
        
        if ( star_rating >= 4 )
        {
            amount = int( star_rating / 4 ) * 2;
            amount = math::clamp( amount, 1, 10 );
            self function_d59d7b74( amount );
        }
        else
        {
            self function_d59d7b74();
        }
        
        if ( is_true( getgametypesetting( #"hash_534a70940dadf3e7" ) ) )
        {
            if ( star_rating >= 3 )
            {
                mod = star_rating - 2;
                chance = 10 * mod;
                chance = math::clamp( chance, 0, 100 );
                
                if ( math::cointoss( chance ) )
                {
                    function_89a45cd4();
                }
            }
            
            if ( star_rating >= 6 )
            {
                mod = star_rating - 5;
                chance = 5 * mod;
                chance = math::clamp( chance, 0, 100 );
                
                if ( math::cointoss( chance ) )
                {
                    function_74f5b460();
                }
            }
        }
        
        return;
    }
    
    round = level.round_number;
    milestones = level.round_number / 5;
    var_ef5aac55 = milestones * 500;
    var_ef5aac55 = math::clamp( var_ef5aac55, 0, 5000 );
    sr_scrap::function_afab250a( var_ef5aac55 );
    
    if ( round >= 20 )
    {
        amount = int( round / 20 ) * 2;
        amount = math::clamp( amount, 1, 10 );
        self function_d59d7b74( amount );
    }
    else
    {
        self function_d59d7b74();
    }
    
    if ( is_true( getgametypesetting( #"hash_534a70940dadf3e7" ) ) )
    {
        if ( round >= 15 )
        {
            mod = ( round - 15 ) / 5 + 1;
            chance = 10 * mod;
            chance = math::clamp( chance, 0, 100 );
            
            if ( math::cointoss( chance ) )
            {
                function_89a45cd4();
            }
        }
        
        if ( round >= 30 )
        {
            mod = ( round - 30 ) / 5 + 1;
            chance = 10 * mod;
            chance = math::clamp( chance, 0, 100 );
            
            if ( math::cointoss( chance ) )
            {
                function_74f5b460();
            }
        }
    }
}

// Namespace namespace_d4ecbbf0/namespace_d4ecbbf0
// Params 1
// Checksum 0x4a68515c, Offset: 0x8c8
// Size: 0x11a
function on_item_pickup( params )
{
    item = params.item;
    
    if ( isplayer( self ) )
    {
        if ( isdefined( item.itementry ) )
        {
            if ( item.itementry.itemtype === #"hash_6a8c9b279aa1c2c5" )
            {
                if ( isdefined( item.itementry.rarity ) )
                {
                    switch ( item.itementry.rarity )
                    {
                        case #"rare":
                            self function_d59d7b74();
                            break;
                        case #"epic":
                            self function_89a45cd4();
                            break;
                        case #"legendary":
                            self function_74f5b460();
                            break;
                    }
                }
            }
        }
    }
}

