#using script_1b9f100b85b7e21d;
#using script_1fd2c6e5fc8cb1c3;
#using script_3dc93ca9902a9cda;
#using script_4ec222619bffcfd1;
#using script_7901e9dc8618be8a;
#using script_798f7d52f57a9c40;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\spawn_manager;

#namespace kgb_aslt_bunker_escape;

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 1
// Checksum 0xd9bb52d0, Offset: 0x4c8
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 2
// Checksum 0x1ad42a62, Offset: 0x4e0
// Size: 0x34c
function main( var_d3440450, var_50cc0d4f )
{
    level flag::set( "aslt_bunker_escape_begin" );
    
    if ( is_true( var_50cc0d4f ) )
    {
        level.adler = namespace_e77bf565::adler_spawn( var_d3440450, "adler_shotgun" );
        level thread scene::skipto_end_noai( "scene_kgb_door_kick", "Last_Frame", undefined, 1 );
        level thread scene::skipto_end_noai( "scene_kgb_utility_room_adler", "Door_Closed", undefined, 1 );
        level thread scene::play_from_time( "scene_kgb_open_vault", "Enemies_Breach_Vault", undefined, 1, 1, 1, 0, 0 );
        level thread scene::skipto_end( "scene_kgb_door_shoulder" );
        level thread kgb_aslt_vault::function_833a9413();
        level thread function_bfe40bf0();
        level thread kgb_aslt_vault::function_46fe3d22( undefined );
        level flag::set( "vault_breached" );
        level thread namespace_bed29d94::function_a0d18564();
        level thread kgb_aslt_vault::function_259d8d6f();
        level thread namespace_e77bf565::function_378ac0da( "vault_smod", 1, #"hash_57e5f9b4cc8f8907" );
        level thread kgb_aslt_vault::function_66b280b8();
    }
    
    level thread scene::init( "scene_kgb_tunnel_catwalk_transition" );
    level thread scene::init( "scene_kgb_lights_out" );
    spawner::set_ai_group_cleared_count( "bunker_escape_catwalk_enemies", 1 );
    level thread function_b735db01();
    wait 2;
    level thread function_d6861ec3();
    level thread namespace_e77bf565::escape_objective( var_d3440450, var_50cc0d4f );
    level flag::wait_till( "aslt_bunker_escape_complete" );
    level thread scene::stop( "scene_kgb_door_shoulder", 1 );
    level thread scene::init( "scene_kgb_tunnel_catwalk_transition" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 4
// Checksum 0xfb62871d, Offset: 0x838
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 0
// Checksum 0xee832598, Offset: 0x868
// Size: 0x44
function init_flags()
{
    level flag::init( "aslt_bunker_escape_begin" );
    level flag::init( "aslt_bunker_escape_complete" );
}

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 0
// Checksum 0x80f724d1, Offset: 0x8b8
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 0
// Checksum 0x80f724d1, Offset: 0x8c8
// Size: 0x4
function function_22b7fffd()
{
    
}

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 0
// Checksum 0x41ac5836, Offset: 0x8d8
// Size: 0x21c
function function_b735db01()
{
    bunker_escape_adler_start_node = getnode( "bunker_escape_adler_start_node", "targetname" );
    level.adler.fixednode = 1;
    level.adler thread spawner::go_to_node( bunker_escape_adler_start_node );
    level flag::wait_till( "bunker_escape_move_adler_10" );
    level.adler spawner::function_461ce3e9();
    level.adler.fixednode = 0;
    level.adler colors::set_force_color( "g" );
    level.adler colors::enable();
    level.adler thread dialogue::queue( "vox_cp_rkgb_04200_adlr_theyrelockingth_b2" );
    level thread savegame::checkpoint_save();
    level flag::wait_till( "bunker_escape_move_adler_20" );
    level thread savegame::checkpoint_save();
    level.adler thread dialogue::queue( "vox_cp_rkgb_04200_adlr_thisway_37" );
    level.adler colors::disable();
    scene::play( "scene_kgb_tunnel_catwalk_transition" );
    namespace_353d803e::music( "13.5_lockdown" );
    bunker_escape_adler_catwalk_node = getnode( "bunker_escape_adler_catwalk_node", "targetname" );
    level.adler thread spawner::go_to_node( bunker_escape_adler_catwalk_node );
    level flag::wait_till( "bunker_escape_catwalk_enemies_cleared" );
}

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 1
// Checksum 0x3fc04d29, Offset: 0xb00
// Size: 0xb4
function function_bfe40bf0( var_b1e77977 )
{
    vault_ai_nav_clip = getent( "vault_ai_nav_clip", "targetname" );
    
    if ( isdefined( vault_ai_nav_clip ) )
    {
        if ( is_true( var_b1e77977 ) )
        {
            vault_ai_nav_clip solid();
            vault_ai_nav_clip disconnectpaths();
            return;
        }
        
        vault_ai_nav_clip notsolid();
        vault_ai_nav_clip connectpaths();
    }
}

// Namespace kgb_aslt_bunker_escape/namespace_78895b98
// Params 0
// Checksum 0x2fddc677, Offset: 0xbc0
// Size: 0x2b4
function function_d6861ec3()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level endon( #"aslt_bunker_escape_complete" );
    var_772900d5 = struct::get_array( "no_escape_pa_vo_org", "targetname" );
    wait 4;
    org = arraygetclosest( player.origin, var_772900d5 );
    sndobj = snd::function_9ae4fc6f( "vox_cp_rkgb_04400_rms1_giveupyoucannot_7d", org );
    snd::function_2fdc4fb( sndobj );
    wait 8;
    org = arraygetclosest( player.origin, var_772900d5 );
    snd::function_9ae4fc6f( "vox_cp_rkgb_04400_rms1_surrenderyouwil_0c", org );
    snd::function_2fdc4fb( sndobj );
    wait 8;
    org = arraygetclosest( player.origin, var_772900d5 );
    snd::function_9ae4fc6f( "vox_cp_rkgb_04400_rms1_putyourweaponsd_54", org );
    snd::function_2fdc4fb( sndobj );
    wait 8;
    org = arraygetclosest( player.origin, var_772900d5 );
    snd::function_9ae4fc6f( "vox_cp_rkgb_04400_rms1_wehaveblockedal_50", org );
    snd::function_2fdc4fb( sndobj );
    wait 8;
    org = arraygetclosest( player.origin, var_772900d5 );
    snd::function_9ae4fc6f( "vox_cp_rkgb_04400_rms1_stoptryingtorun_2c", org );
    snd::function_2fdc4fb( sndobj );
    wait 8;
    org = arraygetclosest( player.origin, var_772900d5 );
    snd::function_9ae4fc6f( "vox_cp_rkgb_04400_rms1_escapeisimpossi_d2", org );
}

