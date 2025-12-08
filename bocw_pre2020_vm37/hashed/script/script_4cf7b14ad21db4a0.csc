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

#namespace namespace_c1cfab6c;

// Namespace namespace_c1cfab6c/level_preinit
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

// Namespace namespace_c1cfab6c/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0xd8d62c68, Offset: 0x158
// Size: 0x50
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    level.player = snd::getplayerssafe()[ 0 ];
}

// Namespace namespace_c1cfab6c/namespace_c1cfab6c
// Params 2, eflags: 0x4
// Checksum 0xd98b6a17, Offset: 0x1b0
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

// Namespace namespace_c1cfab6c/namespace_c1cfab6c
// Params 3, eflags: 0x4
// Checksum 0x83f25001, Offset: 0x258
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

// Namespace namespace_c1cfab6c/namespace_c1cfab6c
// Params 2, eflags: 0x4
// Checksum 0xba03b8cb, Offset: 0x328
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

// Namespace namespace_c1cfab6c/namespace_c1cfab6c
// Params 1, eflags: 0x4
// Checksum 0xa0a6ba6, Offset: 0x3d0
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

