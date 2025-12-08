#using script_1351b3cdb6539f9b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\weapons\cp\parabolic_mic;

#namespace namespace_84eb410;

// Namespace namespace_84eb410/namespace_84eb410
// Params 0
// Checksum 0x6d293786, Offset: 0x2b8
// Size: 0x2cc
function function_ebb89fc7()
{
    if ( !isdefined( level.parabolic_mic ) )
    {
        level.parabolic_mic = spawnstruct();
        level.parabolic_mic.weapon = getweapon( "eq_parabolic_mic" );
    }
    
    parabolic_mic::init( #"hash_7b8e2a8064bea068" );
    level.parabolic_mic.min_dist = 0;
    level.parabolic_mic.max_dist = 1000;
    level.parabolic_mic.dotlimit = -1;
    level.parabolic_mic.var_7b9d607e = 0.996;
    level.players[ 0 ] thread parabolic_mic::function_9a3bbf32();
    parabolic_mic::function_ce0dfadd( "ambient_convo_01", &function_158bd68e );
    parabolic_mic::function_ce0dfadd( "ambient_convo_02", &function_373519dc );
    parabolic_mic::function_ce0dfadd( "ambient_convo_03", &function_43773260 );
    parabolic_mic::function_ce0dfadd( "ambient_convo_04", &function_9148af2d );
    parabolic_mic::function_ce0dfadd( "ambient_convo_05", &function_f628f8ec );
    parabolic_mic::function_ce0dfadd( "ambient_convo_06", &function_158bd68e );
    parabolic_mic::function_ce0dfadd( "door_convo_01", &function_158bd68e );
    parabolic_mic::function_ce0dfadd( "door_convo_02", &function_373519dc );
    parabolic_mic::function_ce0dfadd( "door_convo_03", &function_43773260 );
    parabolic_mic::function_ce0dfadd( "door_convo_04", &function_158bd68e );
    parabolic_mic::function_ce0dfadd( "door_convo_05", &function_373519dc );
    parabolic_mic::function_ce0dfadd( "door_convo_06", &function_43773260 );
}

// Namespace namespace_84eb410/namespace_84eb410
// Params 0
// Checksum 0x1459dd16, Offset: 0x590
// Size: 0x14c
function function_604f4e2a()
{
    if ( isdefined( level.parabolic_mic ) )
    {
        parabolic_mic::function_afd5613e( "ambient_convo_01" );
        parabolic_mic::function_afd5613e( "ambient_convo_02" );
        parabolic_mic::function_afd5613e( "ambient_convo_03" );
        parabolic_mic::function_afd5613e( "ambient_convo_04" );
        parabolic_mic::function_afd5613e( "ambient_convo_05" );
        parabolic_mic::function_afd5613e( "door_convo_01" );
        parabolic_mic::function_afd5613e( "door_convo_02" );
        parabolic_mic::function_afd5613e( "door_convo_03" );
        parabolic_mic::function_afd5613e( "door_convo_04" );
        parabolic_mic::function_afd5613e( "door_convo_05" );
        parabolic_mic::function_afd5613e( "door_convo_06" );
        level notify( #"radial_sound_end" );
        level.parabolic_mic parabolic_mic::radial_sound_end();
    }
}

// Namespace namespace_84eb410/namespace_84eb410
// Params 0
// Checksum 0x6e69213, Offset: 0x6e8
// Size: 0x1d8
function function_9b42e21a()
{
    level notify( #"hash_3d4a1a25c821f315" );
    level endon( #"hash_3d4a1a25c821f315" );
    level.players[ 0 ] notifyonplayercommand( "weapon_mic", "+actionslot 4" );
    
    while ( true )
    {
        level.players[ 0 ] waittill( #"weapon_mic" );
        currentweapon = level.players[ 0 ] getcurrentweapon();
        level.players[ 0 ] parabolic_mic::function_765c50e5();
        level.players[ 0 ] switchtoweaponimmediate( level.parabolic_mic.weapon, 1 );
        level.players[ 0 ] disableweaponcycling();
        wait 0.25;
        level.players[ 0 ] waittill( #"weapon_mic" );
        level.players[ 0 ] takeweapon( level.parabolic_mic.weapon );
        level.players[ 0 ] switchtoweaponimmediate( currentweapon, 1 );
        level.players[ 0 ] enableweaponcycling();
        wait 0.25;
    }
}

// Namespace namespace_84eb410/namespace_84eb410
// Params 0
// Checksum 0xd422ba16, Offset: 0x8c8
// Size: 0x58
function function_158bd68e()
{
    data = spawnstruct();
    data.queue = [];
    data parabolic_mic::function_18b589f0( "tmp_walla_panic_int_panic_lp", undefined, undefined, "radial_sound_end" );
    return data;
}

// Namespace namespace_84eb410/namespace_84eb410
// Params 0
// Checksum 0x6dc4d479, Offset: 0x928
// Size: 0x58
function function_373519dc()
{
    data = spawnstruct();
    data.queue = [];
    data parabolic_mic::function_18b589f0( "tmp_walla_panic_int_worried_lp", undefined, undefined, "radial_sound_end" );
    return data;
}

// Namespace namespace_84eb410/namespace_84eb410
// Params 0
// Checksum 0xb1b1765d, Offset: 0x988
// Size: 0x58
function function_43773260()
{
    data = spawnstruct();
    data.queue = [];
    data parabolic_mic::function_18b589f0( "tmp_walla_startle_lp", undefined, undefined, "radial_sound_end" );
    return data;
}

// Namespace namespace_84eb410/namespace_84eb410
// Params 0
// Checksum 0xa3b93fbb, Offset: 0x9e8
// Size: 0x58
function function_f628f8ec()
{
    data = spawnstruct();
    data.queue = [];
    data parabolic_mic::function_18b589f0( "tmp_music_diegetic_rock_russian_lp", undefined, undefined, "radial_sound_end" );
    return data;
}

// Namespace namespace_84eb410/namespace_84eb410
// Params 0
// Checksum 0x6af9b1ec, Offset: 0xa48
// Size: 0x58
function function_9148af2d()
{
    data = spawnstruct();
    data.queue = [];
    data parabolic_mic::function_18b589f0( "tmp_music_diegetic_russian_ussr_lp", undefined, undefined, "radial_sound_end" );
    return data;
}

