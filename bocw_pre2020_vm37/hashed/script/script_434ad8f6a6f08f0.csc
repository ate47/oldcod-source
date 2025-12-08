#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace namespace_e1ccb37b;

// Namespace namespace_e1ccb37b/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x747bfea0, Offset: 0xc0
// Size: 0x8c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::trigger_init( &_trigger );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_e1ccb37b/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x3054f7f6, Offset: 0x158
// Size: 0x2c
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 2, eflags: 0x4
// Checksum 0x1be957f7, Offset: 0x190
// Size: 0x9a
function private function_32ab045( *ent, name )
{
    switch ( name )
    {
        case #"hash_65e6eae762f128ac":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69( name, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 3, eflags: 0x4
// Checksum 0xb8c2261, Offset: 0x238
// Size: 0xc2
function private _trigger( *player, trigger, *var_ec80d14b )
{
    trigger_name = snd::function_ea2f17d1( var_ec80d14b.script_ambientroom, "$default" );
    
    switch ( trigger_name )
    {
        case #"$default":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 2, eflags: 0x4
// Checksum 0x932c835e, Offset: 0x308
// Size: 0x9a
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"hash_65e6eae762f128ac":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69( msg, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_e1ccb37b/namespace_bf107587
// Params 1, eflags: 0x4
// Checksum 0x9a1d690, Offset: 0x3b0
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
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:xa4>" + objective + "<dev string:x5d>" );
            #/
            
            break;
    }
}

