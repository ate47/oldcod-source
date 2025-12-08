#using scripts\core_common\ai\archetype_mimic;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;

#namespace zm_ai_mimic;

// Namespace zm_ai_mimic/zm_ai_mimic
// Params 0, eflags: 0x6
// Checksum 0xd80e4003, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zm_ai_mimic", &preinit, undefined, undefined, undefined );
}

// Namespace zm_ai_mimic/zm_ai_mimic
// Params 0
// Checksum 0x534780d9, Offset: 0xd0
// Size: 0x64
function preinit()
{
    spawner::add_archetype_spawn_function( #"mimic", &function_76433e31 );
    spawner::function_89a2cd87( #"mimic", &function_820e5ac3 );
}

// Namespace zm_ai_mimic/zm_ai_mimic
// Params 0
// Checksum 0x80f724d1, Offset: 0x140
// Size: 0x4
function function_76433e31()
{
    
}

// Namespace zm_ai_mimic/zm_ai_mimic
// Params 0
// Checksum 0xf054f754, Offset: 0x150
// Size: 0x5c
function function_820e5ac3()
{
    if ( is_true( self.ai.var_870d0893 ) )
    {
        return;
    }
    
    self callback::function_d8abfc3d( #"on_entity_revealed", &function_7c591227 );
}

// Namespace zm_ai_mimic/zm_ai_mimic
// Params 1
// Checksum 0xf091688f, Offset: 0x1b8
// Size: 0x3a
function function_7c591227( params )
{
    random_activator = array::random( params.activators );
    self.favoriteenemy = random_activator;
}

