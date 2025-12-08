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

#namespace namespace_72b0499b;

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x6a9af48c, Offset: 0x148
// Size: 0xa4
function init_audio()
{
    snd::function_d4ec748e( &function_f2a2832d );
    level thread function_35995965();
    level thread function_2c8b8f30();
    level thread function_89f1a26b();
    audio::snd_set_snapshot( "cp_nam_armada_intro" );
    setsoundcontext( "vehicle", "exterior" );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x105de921, Offset: 0x1f8
// Size: 0x34
function function_35995965()
{
    audio::playloopat( #"hash_1410fb209e305bb6", ( -10560, -71761, 1057 ) );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x870409bd, Offset: 0x238
// Size: 0x34
function function_2c8b8f30()
{
    audio::playloopat( #"amb_light", ( -10645, -71188, 1129 ) );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0xbeae9fec, Offset: 0x278
// Size: 0x34
function function_89f1a26b()
{
    audio::playloopat( #"hash_98b0f543b0899aa", ( -9706, -72793, 1158 ) );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 2, eflags: 0x4
// Checksum 0x4f59e22d, Offset: 0x2b8
// Size: 0x33a
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"hash_2402a22c6c4e796e":
            audio::snd_set_snapshot( "cp_nam_armada_intro" );
            break;
        case #"hash_55704324b6ae9012":
            audio::snd_set_snapshot( "" );
            break;
        case #"hash_394162110e28e4d1":
            audio::snd_set_snapshot( "" );
            break;
        case #"hash_391dd8e0fb7ccb35":
            audio::stoploopat( #"hash_1410fb209e305bb6", ( -9331, -71610, 1033 ) );
            level.var_d7e7f155 = playsound( 0, #"hash_52071a1618a9db55" );
            break;
        case #"hash_443b18ddc7cacdc4":
            audio::snd_set_snapshot( "cp_nam_armada_flyin_fade" );
            wait 2;
            stopsound( level.var_d7e7f155 );
            playsound( 0, #"hash_12f61c9ed705c06b", ( 0, 0, 0 ) );
            break;
        case #"hash_4a41082a1d97f925":
            setsoundcontext( "vehicle", "interior" );
            break;
        case #"hash_2086d5e690a6ff1b":
            setsoundcontext( "vehicle", "exterior" );
            break;
        case #"hash_551e8554285c2305":
            setsoundcontext( "plr_impact", "vehicle" );
            break;
        case #"hash_66209bfcf3bd11ca":
            setsoundcontext( "plr_impact", "flesh" );
            break;
        case #"hash_72dd94fb3a8887e5":
            function_5ea2c6e3( "cp_nam_armada_flyable_chopper", 0, 1 );
            break;
        case #"hash_763d59f6976503eb":
            function_ed62c9c2( "cp_nam_armada_flyable_chopper" );
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69( msg, "<dev string:x56>" ) );
            #/
            
            break;
    }
}

