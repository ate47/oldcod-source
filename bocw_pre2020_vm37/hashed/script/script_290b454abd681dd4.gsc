#using script_1b9f100b85b7e21d;
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

#namespace namespace_c1cfab6c;

// Namespace namespace_c1cfab6c/level_preinit
// Params 1, eflags: 0x44
// Checksum 0xb31fc7, Offset: 0x118
// Size: 0x2c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_c1cfab6c/event_cc819519
// Params 1, eflags: 0x44
// Checksum 0x2d7b91ea, Offset: 0x150
// Size: 0x2c
function private event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
}

// Namespace namespace_c1cfab6c/namespace_c1cfab6c
// Params 1, eflags: 0x4
// Checksum 0xd7378673, Offset: 0x188
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

// Namespace namespace_c1cfab6c/namespace_c1cfab6c
// Params 0
// Checksum 0x5ab08e67, Offset: 0x230
// Size: 0x216
function function_f5421481()
{
    level flag::wait_till( "missile_strike_landed" );
    wait 0.5;
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( 766, 2521, 479 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( -861, 3063, 510 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( 67, 2413, 481 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( -2024, -816, 277 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( -1088, -771, 235 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( 42, -4052, 401 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( 285, -4832, 158 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( -484, -591, 438 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( -3022, 4241, 981 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( -2889, 3629, 409 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( -3951, -4451, 225 ) );
    alarm = snd::function_9ae4fc6f( "amb_emt_klaxon_siren_02", ( -4138, -5546, 213 ) );
}

// Namespace namespace_c1cfab6c/namespace_c1cfab6c
// Params 0
// Checksum 0xfe450915, Offset: 0x450
// Size: 0x36
function function_e8c1c3a9()
{
    missile = snd::function_9ae4fc6f( "tmp_cp_nam_pris_napalm_explode", ( -11130, -2935, 14820 ) );
}

