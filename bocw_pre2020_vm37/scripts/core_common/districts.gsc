#using script_1fa63e6c62e170a3;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace districts;

// Namespace districts/districts
// Params 0, eflags: 0x6
// Checksum 0xc3beb144, Offset: 0xd8
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "cp_districts_system", &preinit, undefined, undefined, undefined );
}

// Namespace districts/districts
// Params 0, eflags: 0x4
// Checksum 0xd0b580f9, Offset: 0x118
// Size: 0x44
function private preinit()
{
    clientfield::register( "world", "district_bitfield", 1, 16, "int" );
    namespace_aff1f617::function_41e5864f();
}

// Namespace districts/districts
// Params 2
// Checksum 0xe5ab9d52, Offset: 0x168
// Size: 0x154
function function_a7d79fcb( names, exclusive = 0 )
{
    if ( !isdefined( names ) )
    {
        names = [];
    }
    else if ( !isarray( names ) )
    {
        names = array( names );
    }
    
    var_8f63b4bd = level.var_59cd6d34.var_cd7d2e9f;
    
    if ( exclusive )
    {
        var_8f63b4bd = 0;
    }
    
    foreach ( name in names )
    {
        bit = function_da432d39( name );
        
        if ( bit >= 0 )
        {
            var_8f63b4bd |= 1 << bit;
        }
    }
    
    level function_1e34097d( var_8f63b4bd );
}

// Namespace districts/districts
// Params 2
// Checksum 0x6de4185f, Offset: 0x2c8
// Size: 0x164
function function_930f8c81( names, exclusive = 0 )
{
    if ( !isdefined( names ) )
    {
        names = [];
    }
    else if ( !isarray( names ) )
    {
        names = array( names );
    }
    
    var_8f63b4bd = level.var_59cd6d34.var_cd7d2e9f;
    
    if ( exclusive )
    {
        var_8f63b4bd = 65535;
    }
    
    foreach ( name in names )
    {
        bit = function_da432d39( name );
        
        if ( bit >= 0 )
        {
            mask = ~( 1 << bit );
            var_8f63b4bd &= mask;
        }
    }
    
    level function_1e34097d( var_8f63b4bd );
}

// Namespace districts/districts
// Params 1, eflags: 0x4
// Checksum 0x39ef5f57, Offset: 0x438
// Size: 0x42
function private function_da432d39( name )
{
    index = level.var_59cd6d34.var_2844be06[ name ];
    
    if ( isdefined( index ) )
    {
        return index;
    }
    
    return -1;
}

// Namespace districts/districts
// Params 1, eflags: 0x4
// Checksum 0xffd8528b, Offset: 0x488
// Size: 0x74
function private function_1e34097d( var_8f63b4bd )
{
    assert( var_8f63b4bd < 65536 );
    level.var_59cd6d34.var_cd7d2e9f = var_8f63b4bd;
    level clientfield::set( "district_bitfield", level.var_59cd6d34.var_cd7d2e9f );
}

