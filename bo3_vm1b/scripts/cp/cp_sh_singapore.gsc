#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_safehouse;
#using scripts/cp/_util;
#using scripts/cp/cp_sh_singapore_fx;
#using scripts/cp/cp_sh_singapore_sound;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_sh_singapore;

// Namespace cp_sh_singapore
// Params 0
// Checksum 0x88be3244, Offset: 0x350
// Size: 0x52
function main()
{
    cp_sh_singapore_fx::main();
    cp_sh_singapore_sound::main();
    load::main();
    level thread set_ambient_state();
    level thread setup_vignettes();
}

// Namespace cp_sh_singapore
// Params 0
// Checksum 0x6cd7a060, Offset: 0x3b0
// Size: 0xb5
function set_ambient_state()
{
    level flag::wait_till( "all_players_connected" );
    
    switch ( level.next_map )
    {
        case "cp_mi_sing_blackstation":
            level util::set_lighting_state( 0 );
            break;
        case "cp_mi_sing_biodomes":
        case "cp_mi_sing_biodomes2":
            level util::set_lighting_state( 1 );
            break;
        case "cp_mi_sing_sgen":
            level util::set_lighting_state( 0 );
            break;
        default:
            level util::set_lighting_state( 2 );
            break;
    }
}

// Namespace cp_sh_singapore
// Params 0
// Checksum 0x54051e56, Offset: 0x470
// Size: 0x289
function setup_vignettes()
{
    function_82dd4dd2( "cin_ram_02_03_station_vign_readingipad_guy01" );
    a_str_scenes = [];
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_bloodmopping_clean";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_balcony_surveying_guy01";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_balcony_surveying_guy02";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_scaffold_inspecting";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_readingipad_guy01";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_saf_bla_armory_vign_repair_3dprinter";
    e_spawner = getent( "worker_spawner", "targetname" );
    a_str_scenes = array::randomize( a_str_scenes );
    n_vign_total = randomintrange( 3, 4 );
    
    /#
    #/
    
    for ( n_vign_index = 0; n_vign_index < n_vign_total ; n_vign_index++ )
    {
        str_scene = a_str_scenes[ n_vign_index ];
        level thread scene::play( str_scene, e_spawner );
    }
}

// Namespace cp_sh_singapore
// Params 1
// Checksum 0xb36f4794, Offset: 0x708
// Size: 0x81
function function_82dd4dd2( str_scene )
{
    foreach ( s_scenedef in struct::get_script_bundles( "scene" ) )
    {
        if ( s_scenedef.name === str_scene )
        {
            s_scenedef.aligntarget = undefined;
        }
    }
}

