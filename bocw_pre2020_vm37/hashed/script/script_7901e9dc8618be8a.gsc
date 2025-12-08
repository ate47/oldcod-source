#using script_1fd2c6e5fc8cb1c3;
#using script_4ec222619bffcfd1;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace kgb_aslt_bunker_escape_lights_out;

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 1
// Checksum 0x6a973d3c, Offset: 0x538
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 2
// Checksum 0xaaceea14, Offset: 0x550
// Size: 0x254
function main( var_d3440450, var_50cc0d4f )
{
    level flag::set( "aslt_bunker_escape_lights_out_begin" );
    setsaveddvar( #"hash_7bf40e4b6a830d11", 0 );
    
    if ( is_true( var_50cc0d4f ) )
    {
        level.adler = namespace_e77bf565::adler_spawn( var_d3440450, "adler_shotgun" );
        level thread scene::skipto_end_noai( "scene_kgb_door_kick", "Last_Frame", undefined, 1 );
        level thread scene::skipto_end_noai( "scene_kgb_utility_room_adler", "Door_Closed", undefined, 1 );
        level thread scene::init( "scene_kgb_tunnel_catwalk_transition" );
        level thread scene::init( "scene_kgb_lights_out" );
        level thread function_a0d18564();
    }
    
    spawner::add_spawn_function_group( "ambient_cqb_searcher", "script_noteworthy", &function_dfeaa423 );
    spawner::add_spawn_function_group( "ambusher", "script_noteworthy", &function_adbd78ad );
    level thread namespace_e77bf565::escape_objective( var_d3440450, var_50cc0d4f );
    level thread function_5b6d6f91();
    level thread spawn_ambient_cqb_searchers();
    exploder::exploder( "lights_out" );
    level flag::wait_till( "aslt_bunker_escape_lights_out_complete" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 4
// Checksum 0xb1a27b3e, Offset: 0x7b0
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x674a7f9d, Offset: 0x7e0
// Size: 0x64
function init_flags()
{
    level flag::init( "aslt_bunker_escape_lights_out_begin" );
    level flag::init( "aslt_bunker_escape_lights_out_complete" );
    level flag::init( "lights_out_done" );
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x9f7c95e, Offset: 0x850
// Size: 0x34
function init_clientfields()
{
    clientfield::register( "actor", "set_flashlight_fx", 1, 1, "int" );
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x80f724d1, Offset: 0x890
// Size: 0x4
function function_22b7fffd()
{
    
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x85fbbd01, Offset: 0x8a0
// Size: 0xdc
function function_a0d18564()
{
    exploder::exploder( "lights_out_group_back_100" );
    exploder::exploder( "lights_out_group_back_90" );
    exploder::exploder( "lights_out_group_back_80" );
    exploder::exploder( "lights_out_group_back_70" );
    exploder::exploder( "lights_out_group_back_60" );
    exploder::exploder( "lights_out_group_20" );
    exploder::exploder( "lights_out_group_40" );
    exploder::exploder( "lights_out_group_60" );
    exploder::exploder( "lights_out_group_80" );
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 1
// Checksum 0xca1f6bb, Offset: 0x988
// Size: 0x1c4
function function_c39765b2( start_delay )
{
    wait start_delay;
    var_5abcb701 = 0.5;
    thread namespace_353d803e::function_b1bdc561();
    exploder::stop_exploder( "lights_out_group_back_100" );
    exploder::stop_exploder( "lights_out_group_back_90" );
    wait var_5abcb701;
    exploder::stop_exploder( "lights_out_group_back_80" );
    exploder::stop_exploder( "lights_out_group_back_70" );
    namespace_353d803e::function_9f617fd();
    wait var_5abcb701;
    exploder::stop_exploder( "lights_out_group_back_60" );
    exploder::stop_exploder( "lights_out_group_20" );
    namespace_353d803e::function_247bcd08();
    wait var_5abcb701;
    exploder::stop_exploder( "lights_out_group_40" );
    exploder::stop_exploder( "lights_out_group_60" );
    namespace_353d803e::function_3632f076();
    wait var_5abcb701;
    namespace_353d803e::function_d2c6a99f();
    exploder::stop_exploder( "lights_out_group_80" );
    exploder::stop_exploder( "lights_out" );
    level flag::set( "lights_out_done" );
    level thread savegame::checkpoint_save();
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x74e0f172, Offset: 0xb58
// Size: 0x10e
function function_85e771d4()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    self endon( #"death" );
    self.forcefire = 1;
    self.fixednode = 1;
    self.grenadeammo = 0;
    self clientfield::set( "set_flashlight_fx", 1 );
    self flashlight::function_32fb7a97( "tag_flash" );
    self flashlight::function_7c2f623b();
    self flashlight::function_65e5c8c8( 1 );
    wait randomfloatrange( 6, 10 );
    self.fixednode = 0;
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0xbf200d1c, Offset: 0xc70
// Size: 0x2bc
function function_5b6d6f91()
{
    level.adler ai::set_behavior_attribute( "demeanor", "cqb" );
    level scene::play( "scene_kgb_lights_out", "intro" );
    level thread scene::play( "scene_kgb_lights_out", "intro_loop" );
    level flag::set( "adler_idling_at_lights_out_door" );
    level flag::wait_till( "start_lights_out_scene" );
    namespace_353d803e::music( "deactivate_13.5_lockdown" );
    player = getplayers()[ 0 ];
    player thread util::blend_movespeedscale( 0.5, 1 );
    level scene::play( "scene_kgb_lights_out", "lights_out" );
    
    if ( flag::get( "start_lights_out_moment" ) )
    {
        level thread function_c39765b2( 1.9 );
        level scene::play( "scene_kgb_lights_out", "ambush_immediate" );
    }
    else
    {
        level scene::play( "scene_kgb_lights_out", "ambush_delayed_intro" );
        level thread scene::play( "scene_kgb_lights_out", "ambush_delayed_loop" );
        level flag::wait_till( "start_lights_out_moment" );
        level thread function_c39765b2( 1.9 );
        level scene::play( "scene_kgb_lights_out", "ambush_delayed_outro" );
    }
    
    namespace_353d803e::music( "13.6_lockdown_2", 3 );
    level thread function_b735db01();
    wait 2;
    player thread util::blend_movespeedscale_default( 5 );
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x73115c44, Offset: 0xf38
// Size: 0xe4
function function_b735db01()
{
    level.adler thread dialogue::queue( "vox_cp_rkgb_05050_adlr_keepmovingwenee_57" );
    lights_out_adler_start_node = getnode( "lights_out_adler_start_node", "targetname" );
    level.adler spawner::go_to_node( lights_out_adler_start_node );
    level.adler colors::set_force_color( "g" );
    level.adler colors::enable();
    level thread savegame::checkpoint_save();
    wait 1;
    level flag::set( "spawn_ambient_cqb_searchers" );
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0xd6250b4b, Offset: 0x1028
// Size: 0x3c
function spawn_ambient_cqb_searchers()
{
    level flag::wait_till( "spawn_ambient_cqb_searchers" );
    spawner::simple_spawn( "ambient_cqb_searcher" );
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x22c31ef6, Offset: 0x1070
// Size: 0x9c
function function_dfeaa423()
{
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    self clientfield::set( "set_flashlight_fx", 1 );
    self flashlight::function_32fb7a97( "tag_flash" );
    self flashlight::function_7c2f623b();
    self flashlight::function_65e5c8c8( 1 );
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x91e3a40, Offset: 0x1118
// Size: 0x264
function function_adbd78ad()
{
    self endon( #"death" );
    level.player endon( #"death" );
    self ai::set_behavior_attribute( "disablepeek", 1 );
    self ai::set_behavior_attribute( "disablelean", 1 );
    self.fixednode = 1;
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    self.ignoresuppression = 1;
    self.grenadeammo = 0;
    self.ignoreme = 1;
    self.ignoreall = 1;
    self thread function_411f4f72();
    self thread function_5b8d4a66();
    self thread function_be67f4dc();
    self thread function_2f5a3b31();
    enemy = undefined;
    waitresult = self waittill( #"ambush", #"grenadedanger" );
    
    if ( isdefined( waitresult.target ) )
    {
        enemy = waitresult.target;
    }
    
    if ( isdefined( waitresult.owner ) )
    {
        enemy = waitresult.owner;
    }
    
    self.ignoreme = 0;
    self.ignoreall = 0;
    self ai::set_behavior_attribute( "disablepeek", 0 );
    self ai::set_behavior_attribute( "disablelean", 0 );
    
    if ( isdefined( enemy ) )
    {
        self.fixednode = 0;
        self getenemyinfo( enemy );
        self.goalradius = 250;
        self setgoal( enemy, 1 );
        self thread function_ba241b07();
    }
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x6f944d87, Offset: 0x1388
// Size: 0x54
function function_2f5a3b31()
{
    self waittill( #"ambush", #"death" );
    
    if ( isdefined( self.var_8f8a8e65 ) )
    {
        self.var_8f8a8e65 delete();
    }
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0xcb136eb2, Offset: 0x13e8
// Size: 0xce
function function_5b8d4a66()
{
    self endon( #"death" );
    self endon( #"ambush" );
    level.player endon( #"death" );
    node = getnode( self.target, "targetname" );
    waitresult = self waittill( #"damage" );
    
    if ( isdefined( waitresult.inflictor ) )
    {
        self notify( #"ambush", { #target:waitresult.inflictor } );
    }
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0xd153ebc5, Offset: 0x14c0
// Size: 0x156
function function_411f4f72()
{
    self endon( #"death" );
    self endon( #"ambush" );
    level.player endon( #"death" );
    node = getnode( self.target, "targetname" );
    
    if ( !isdefined( node ) )
    {
        return;
    }
    
    self.var_8f8a8e65 = spawn( "trigger_radius", node.origin, 98311, 300, 128 );
    self.var_8f8a8e65 setvisibletoall();
    self.var_8f8a8e65 setteamfortrigger( #"allies" );
    waitresult = self.var_8f8a8e65 waittill( #"trigger" );
    
    if ( isdefined( waitresult.activator ) )
    {
        self notify( #"ambush", { #target:waitresult.activator } );
    }
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0x393b4919, Offset: 0x1620
// Size: 0xa4
function function_be67f4dc()
{
    self endon( #"death" );
    self waittill( #"ambush" );
    wait 0.5;
    self clientfield::set( "set_flashlight_fx", 1 );
    self flashlight::function_32fb7a97( "tag_flash" );
    self flashlight::function_7c2f623b();
    self flashlight::function_65e5c8c8( 1 );
}

// Namespace kgb_aslt_bunker_escape_lights_out/namespace_862e843c
// Params 0
// Checksum 0xd6ef647b, Offset: 0x16d0
// Size: 0x190
function function_ba241b07()
{
    self endon( #"death" );
    level.player endon( #"death" );
    var_e3c067a4 = randomintrangeinclusive( 1, 3 );
    shots_fired = 0;
    start_time = gettime();
    
    while ( true )
    {
        current_time = gettime();
        timeout = 3000;
        
        if ( current_time >= start_time + timeout )
        {
            break;
        }
        
        if ( shots_fired >= var_e3c067a4 )
        {
            break;
        }
        
        if ( isdefined( self.enemy ) && self cansee( self.enemy ) && util::within_fov( self gettagorigin( "tag_flash" ), self gettagangles( "tag_flash" ), self.enemy geteye(), cos( 15 ) ) )
        {
            self shoot();
            shots_fired++;
            wait 0.2;
            continue;
        }
        
        wait 0.05;
    }
}

