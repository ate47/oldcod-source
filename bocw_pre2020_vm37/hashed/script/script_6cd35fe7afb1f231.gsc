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

#namespace namespace_b61bbd82;

// Namespace namespace_b61bbd82/level_preinit
// Params 1, eflags: 0x44
// Checksum 0xd56a67d4, Offset: 0xb8
// Size: 0x2c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_b61bbd82/event_cc819519
// Params 1, eflags: 0x44
// Checksum 0xfde283f9, Offset: 0xf0
// Size: 0x2c
function private event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1, eflags: 0x4
// Checksum 0x3798d5f8, Offset: 0x128
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

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0xbfc0d76, Offset: 0x1d0
// Size: 0x23c
function function_c10bf5c5()
{
    var_bc6eb41f = [ ( 2920, 940, -165 ), ( 2560, 1684, -165 ), ( 2560, 2547, -165 ), ( 3943, 2587, -165 ), ( 4261, 2246, -165 ), ( 4517, 2639, -245 ), ( 4462, 3461, -237 ), ( 5146, 2628, -237 ), ( 3989, 2169, -234 ), ( 3365, 2171, -229 ), ( 5355, 2244, -224 ), ( 3679, 3191, -128 ), ( 3906, 2988, -97 ), ( 3459, 2805, -97 ), ( 5592, 4572, 258 ), ( 5878, 4282, 258 ), ( 6766, 4282, 258 ), ( 7044, 4572, 258 ), ( 6222, 4324, 414 ), ( 10466, 2612, -176 ), ( 10358, 3198, -176 ), ( 11248, 3198, -176 ), ( 10954, 2514, -176 ) ];
    return var_bc6eb41f;
}

