#using script_6e46300ab1cb7adb;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\cp_common\gametypes\save;

#namespace collectibles;

// Namespace collectibles/collectibles
// Params 0, eflags: 0x6
// Checksum 0xbb5befb5, Offset: 0x90
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"collectibles", &preinit, &postinit, undefined, undefined );
}

// Namespace collectibles/collectibles
// Params 0, eflags: 0x4
// Checksum 0x3077d1b3, Offset: 0xe8
// Size: 0x10
function private preinit()
{
    level.var_4ac1758e = [];
}

// Namespace collectibles/collectibles
// Params 0, eflags: 0x4
// Checksum 0xf2c2315, Offset: 0x100
// Size: 0x1c
function private postinit()
{
    level.var_19cf69db = function_5a395617();
}

// Namespace collectibles/collectibles
// Params 0
// Checksum 0xeed1596, Offset: 0x128
// Size: 0x380
function function_5a395617()
{
    var_e42fe869 = [];
    var_fe5aa0de = getscriptbundle( #"evidenceboardlist" );
    var_8f4db568 = var_fe5aa0de.var_48be729c;
    
    foreach ( var_eeb11904 in var_8f4db568 )
    {
        if ( isdefined( var_eeb11904.collectiblelist ) )
        {
            collectibles = var_eeb11904.collectiblelist;
            
            foreach ( item in collectibles )
            {
                collectible = getscriptbundle( item.collectible );
                UnlockType = collectible.UnlockType;
                
                if ( UnlockType === 3 )
                {
                    assert( isdefined( collectible.var_f3575c58 ) );
                    assert( isdefined( collectible.UnlockMap ) );
                    
                    if ( isdefined( collectible.var_f3575c58 ) && isdefined( collectible.UnlockMap ) )
                    {
                        if ( !isdefined( var_e42fe869[ collectible.UnlockMap ] ) )
                        {
                            var_e42fe869[ collectible.UnlockMap ] = [];
                        }
                        
                        if ( var_e42fe869[ collectible.UnlockMap ].size < 10 )
                        {
                            if ( !isdefined( var_e42fe869[ collectible.UnlockMap ][ collectible.var_f3575c58 ] ) )
                            {
                                var_e42fe869[ collectible.UnlockMap ][ collectible.var_f3575c58 ] = collectible;
                            }
                            else
                            {
                                var_91783c0f = var_e42fe869[ collectible.UnlockMap ][ collectible.var_f3575c58 ].name;
                                assert( 0, "<dev string:x38>" + function_9e72a96( collectible.UnlockMap ) + "<dev string:x60>" + collectible.var_f3575c58 + "<dev string:x6a>" + function_9e72a96( collectible.name ) + "<dev string:x70>" + function_9e72a96( var_91783c0f ) );
                            }
                            
                            continue;
                        }
                        
                        assert( 0, "<dev string:x77>" + function_9e72a96( collectible.UnlockMap ) + "<dev string:x9e>" + 10 );
                    }
                }
            }
        }
    }
    
    return var_e42fe869;
}

// Namespace collectibles/collectibles
// Params 1
// Checksum 0xd537f285, Offset: 0x4b0
// Size: 0x34
function function_28bfb57e( mission_name = savegame::function_8136eb5a() )
{
    return level.var_19cf69db[ mission_name ];
}

// Namespace collectibles/collectibles
// Params 3
// Checksum 0xf24510aa, Offset: 0x4f0
// Size: 0xdc
function function_c57acbc9( var_28c9f917, mission_name, value )
{
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    assert( isdefined( var_28c9f917 ) );
    
    if ( !isdefined( mission_name ) )
    {
        mission_name = savegame::function_8136eb5a();
    }
    
    if ( !isdefined( value ) )
    {
        value = 1;
    }
    
    player stats::set_stat( #"mapdata", mission_name, #"collectibles", var_28c9f917, value );
    uploadstats( player );
}

// Namespace collectibles/collectibles
// Params 2
// Checksum 0xb6afda8c, Offset: 0x5d8
// Size: 0xaa
function function_ab921f3d( var_28c9f917, mission_name )
{
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    assert( isdefined( var_28c9f917 ) );
    
    if ( !isdefined( mission_name ) )
    {
        mission_name = savegame::function_8136eb5a();
    }
    
    return player stats::get_stat( #"mapdata", mission_name, #"collectibles", var_28c9f917 );
}

// Namespace collectibles/collectibles
// Params 1
// Checksum 0x3894a491, Offset: 0x690
// Size: 0x5c, Type: bool
function function_e8d5de2c( mission_name = savegame::function_8136eb5a() )
{
    if ( isdefined( level.var_19cf69db[ mission_name ] ) && level.var_19cf69db[ mission_name ].size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace collectibles/collectibles
// Params 0
// Checksum 0x5b1b8660, Offset: 0x6f8
// Size: 0x9c
function function_9f455dbc()
{
    var_8a67c9a0 = 0;
    
    foreach ( mission_name in level.var_19cf69db )
    {
        var_8a67c9a0 += level.var_19cf69db[ mission_name ].size;
    }
    
    return var_8a67c9a0;
}

// Namespace collectibles/collectibles
// Params 1
// Checksum 0x58dab5a5, Offset: 0x7a0
// Size: 0x4e
function function_9f976c54( mission_name = savegame::function_8136eb5a() )
{
    if ( isdefined( level.var_19cf69db[ mission_name ] ) )
    {
        return level.var_19cf69db[ mission_name ].size;
    }
    
    return 0;
}

// Namespace collectibles/collectibles
// Params 0
// Checksum 0x46f47090, Offset: 0x7f8
// Size: 0x11c
function function_ee839c3b()
{
    var_9a849009 = 0;
    
    foreach ( mission_name in level.var_19cf69db )
    {
        foreach ( collectible in level.var_19cf69db[ mission_name ] )
        {
            var_9a849009 += function_7be39f53( mission_name );
        }
    }
    
    return var_9a849009;
}

// Namespace collectibles/collectibles
// Params 1
// Checksum 0xa2729b14, Offset: 0x920
// Size: 0x102
function function_7be39f53( mission_name = savegame::function_8136eb5a() )
{
    var_9a849009 = 0;
    
    if ( isdefined( level.var_19cf69db[ mission_name ] ) )
    {
        foreach ( collectible in level.var_19cf69db[ mission_name ] )
        {
            if ( is_true( function_ab921f3d( collectible.var_f3575c58, collectible.UnlockMap ) ) )
            {
                var_9a849009++;
            }
        }
    }
    
    return var_9a849009;
}

// Namespace collectibles/collectibles
// Params 1
// Checksum 0xed06789c, Offset: 0xa30
// Size: 0xa4
function function_6cd091d2( var_28c9f917 )
{
    mission_name = savegame::function_8136eb5a();
    
    if ( function_e8d5de2c( mission_name ) )
    {
        function_c57acbc9( var_28c9f917, mission_name, 1 );
        function_5b42ccea();
    }
    
    var_4bf53b01 = level.var_19cf69db[ mission_name ][ var_28c9f917 ].title;
    namespace_a43d1663::init( var_4bf53b01 );
}

// Namespace collectibles/collectibles
// Params 0
// Checksum 0x80f724d1, Offset: 0xae0
// Size: 0x4
function function_5b42ccea()
{
    
}

// Namespace collectibles/collectibles
// Params 2
// Checksum 0x6f4411f5, Offset: 0xaf0
// Size: 0x24
function add_callback( collectible, callback )
{
    level.var_4ac1758e[ collectible ] = callback;
}

// Namespace collectibles/collectibles
// Params 1
// Checksum 0x6d964461, Offset: 0xb20
// Size: 0x1e, Type: bool
function function_606a97af( collectible )
{
    return isdefined( level.var_4ac1758e[ collectible ] );
}

// Namespace collectibles/collectibles
// Params 1
// Checksum 0x71366f3a, Offset: 0xb48
// Size: 0x3e, Type: bool
function function_f539a1fa( collectible )
{
    if ( isdefined( level.var_4ac1758e[ collectible ] ) )
    {
        [[ level.var_4ac1758e[ collectible ] ]]();
        return true;
    }
    
    return false;
}

