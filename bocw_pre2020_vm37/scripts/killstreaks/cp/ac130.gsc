#using script_13114d8a31c6152a;
#using script_35ae72be7b4fec10;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#using scripts\killstreaks\ac130_shared;

#namespace namespace_8bcd067b;

// Namespace namespace_8bcd067b/ac130
// Params 0, eflags: 0x6
// Checksum 0x2e09cbe4, Offset: 0xf0
// Size: 0x54
function private autoexec __init__system__()
{
    system::register( #"ac130", &preinit, undefined, &function_3675de8b, #"killstreaks" );
}

// Namespace namespace_8bcd067b/ac130
// Params 0, eflags: 0x4
// Checksum 0xaffbee82, Offset: 0x150
// Size: 0x46
function private preinit()
{
    profilestart();
    level.var_f987766c = &spawnac130;
    level.var_36cf2603 = 3;
    ac130_shared::preinit( "killstreak_ac130_cp" );
    profilestop();
}

// Namespace namespace_8bcd067b/ac130
// Params 0, eflags: 0x4
// Checksum 0x3cdbf54a, Offset: 0x1a0
// Size: 0x14
function private function_3675de8b()
{
    ac130_shared::function_3675de8b();
}

// Namespace namespace_8bcd067b/ac130
// Params 0, eflags: 0x4
// Checksum 0x2ca47241, Offset: 0x1c0
// Size: 0xd8
function private spawnac130()
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    assert( !isdefined( level.ac130 ) );
    var_b0b764aa = ac130_shared::spawnac130();
    
    if ( is_true( level.var_43da6545 ) )
    {
        player setvehicledrivableduration( 0 );
    }
    
    if ( var_b0b764aa == 1 )
    {
        player thread function_a4b36d9a();
    }
    
    return var_b0b764aa;
}

// Namespace namespace_8bcd067b/ac130
// Params 0, eflags: 0x4
// Checksum 0xaa4fbd27, Offset: 0x2a0
// Size: 0x164
function private function_a4b36d9a()
{
    player = self;
    self notify( "485efef24bc199cf" );
    self endon( "485efef24bc199cf" );
    player thread util::function_658a8750( 1 );
    scripted_widgets::function_28027c42( #"ac130" );
    namespace_c8e236da::removelist();
    namespace_c8e236da::addprompt( #"hash_6b858da0d4834e81" );
    namespace_c8e236da::addprompt( #"hash_3825e88a25f4de9e" );
    namespace_c8e236da::addprompt( #"hash_67c7efa5abd7672f" );
    namespace_c8e236da::addprompt( #"hash_e3a80a6d16aa152" );
    util::waittill_any_ents( level, "game_ended", player, "disconnect", player, "death", player, "gunner_left" );
    namespace_c8e236da::removelist();
    scripted_widgets::function_4279fd02( #"ac130" );
}

// Namespace namespace_8bcd067b/ac130
// Params 3
// Checksum 0x7f95323, Offset: 0x410
// Size: 0xb4
function function_1c110d7a( var_c3fb6cc9, var_d836f7aa, var_a6a9d503 = undefined )
{
    var_14db8d05 = ( var_c3fb6cc9[ 0 ], var_c3fb6cc9[ 1 ], var_d836f7aa );
    traceresult = groundtrace( var_14db8d05, var_14db8d05 + ( 0, 0, var_d836f7aa * -1 ), 0, undefined );
    var_dd58c5bb = traceresult[ #"position" ];
    ac130_shared::function_672f2acd( var_14db8d05, var_dd58c5bb, var_a6a9d503 );
}

// Namespace namespace_8bcd067b/ac130
// Params 0
// Checksum 0xa5df89c5, Offset: 0x4d0
// Size: 0x74
function function_11d723b6()
{
    player = self;
    
    if ( isdefined( level.ac130 ) && isdefined( level.ac130.owner ) && player == level.ac130.owner )
    {
        ac130_shared::function_8721028e( player, 1, 0, 0 );
    }
}

/#

    // Namespace namespace_8bcd067b/ac130
    // Params 0
    // Checksum 0x4abdb349, Offset: 0x550
    // Size: 0xd8, Type: dev
    function function_2fc9f8f9()
    {
        self notify( "<dev string:x38>" );
        self endon( "<dev string:x38>" );
        
        while ( true )
        {
            waitframe( 1 );
            
            if ( isdefined( level.var_89350618 ) )
            {
                line( level.var_89350618.origin + ( 0, 0, -12000 ), level.var_89350618.origin, ( 1, 1, 0 ), 1, 0, 1 );
            }
            
            if ( isdefined( level.var_e2a77deb ) )
            {
                linesphere( level.var_e2a77deb, 64, ( 0, 1, 0 ), 1, 0, 10, 1 );
            }
        }
    }

#/
