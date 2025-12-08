#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;

#namespace namespace_e1ccb37b;

// Namespace namespace_e1ccb37b/level_preinit
// Params 1, eflags: 0x44
// Checksum 0x3fafd5b0, Offset: 0x150
// Size: 0x2c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_e1ccb37b/event_cc819519
// Params 1, eflags: 0x44
// Checksum 0x2daf1d15, Offset: 0x188
// Size: 0x2c
function private event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 1, eflags: 0x4
// Checksum 0x7832d6a, Offset: 0x1c0
// Size: 0x9a
function private _objective( objective )
{
    switch ( objective )
    {
        case #"hash_65e6eae762f128ac":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>" );
            #/
            
            break;
    }
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 0
// Checksum 0x7fbd016c, Offset: 0x268
// Size: 0x1c
function function_64c39708()
{
    music::setmusicstate( "4.0_searching" );
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 0
// Checksum 0x5138adb8, Offset: 0x290
// Size: 0x1c
function function_e062d70c()
{
    music::setmusicstate( "7.1_attack_sting" );
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 0
// Checksum 0x8038811d, Offset: 0x2b8
// Size: 0x1c
function function_1890889d()
{
    music::setmusicstate( "10.2_combat_loop" );
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 0
// Checksum 0xd7fe199f, Offset: 0x2e0
// Size: 0x1c
function function_b8f05dfb()
{
    music::setmusicstate( "3.0_meeting" );
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 0
// Checksum 0x473b366d, Offset: 0x308
// Size: 0x8c
function function_b9cce48d()
{
    music::setmusicstate( "" );
    music::function_2af5f0ec( "8.2_cello_stingers_1" );
    str_result = level flag::wait_till_any( [ "flag_tappy_succusseful", "flag_tappy_failed" ] );
    music::setmusicstate( "" );
}

