#using script_268625b0934ee2ce;
#using script_3919f386abede84;
#using script_3c70d86dfe255354;
#using script_3dc93ca9902a9cda;
#using script_549b1f81e7dfe241;
#using script_6f92dbd09c4e8204;
#using script_708fc8496e63a128;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\player;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_ger_stakeout_fx;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace namespace_4dc9a074;

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x80f724d1, Offset: 0x10c0
// Size: 0x4
function function_4bf845e0()
{
    
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0xbce4c1f8, Offset: 0x10d0
// Size: 0xa4
function function_9de162de( *str_objective )
{
    player = getplayers()[ 0 ];
    player spy_camera::function_6de171e9();
    namespace_11998b8f::stakeout_stow_weapon();
    player setmovespeedscale( 0.8 );
    player namespace_979752dc::set_disguised( 1 );
    doors::lock( "bar_bathroom_door" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 2
// Checksum 0x57d33e7, Offset: 0x1180
// Size: 0x264
function function_b3837ddc( str_objective, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        level thread function_da707a70();
        level scene::init( "scene_z_stk_bar_amb" );
    }
    
    level.var_4e5a623b = 0;
    level.var_6eed8aea = 1;
    level flag::set( "flag_show_vista_tower_02" );
    level thread function_341ad0ec();
    level thread function_2855eba1();
    level thread scene::add_scene_func( "scene_z_stk_bar_alley", &function_897a03dd, "play" );
    level thread scene::play( "scene_z_stk_bar_alley" );
    level thread namespace_3e1df757::function_b8875614();
    level thread function_92e02d40();
    level flag::wait_till( "alley_1_clear_stealth" );
    var_51e951ef = spawner::simple_spawn_single( "alley_1_shop_enemy" );
    level thread scene::play( "scene_rev_0000_ambient_cower2", "cower_loop" );
    
    if ( scene::is_active( "scene_z_stk_bar_alley" ) )
    {
        level scene::stop( "scene_z_stk_bar_alley" );
    }
    
    if ( isdefined( level.var_469d2832 ) )
    {
        level.var_469d2832 deletedelay();
    }
    
    if ( isdefined( level.var_346203bc ) )
    {
        level.var_346203bc deletedelay();
    }
    
    level flag::wait_till( "alley_1_done" );
    skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 4
// Checksum 0xe841b78, Offset: 0x13f0
// Size: 0x4c
function function_4f2cda6a( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player )
    {
        level flag::set( "flag_show_vista_tower_02" );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0xdc3ca0c6, Offset: 0x1448
// Size: 0x15c
function function_897a03dd( a_ents )
{
    level.var_d171f280 = a_ents[ #"hash_2be22c6d5eea9d0c" ];
    level.var_c338560d = a_ents[ #"hash_2be22f6d5eeaa225" ];
    level.var_469d2832 = a_ents[ #"civ1" ];
    level.var_346203bc = a_ents[ #"civ2" ];
    level.var_d171f280 thread function_a1c3157d( "alley_1_stasi_1_node" );
    level.var_c338560d thread function_a1c3157d( "alley_1_stasi_2_node" );
    level.var_469d2832 thread function_df4cd546();
    level.var_346203bc thread function_df4cd546();
    var_f430b579 = level function_953d6fd0();
    
    if ( isdefined( var_f430b579 ) )
    {
        level flag::wait_till( "alley_1_start_harass_vo" );
        level thread function_aad87078( level.var_d171f280, level.var_469d2832, level.var_346203bc, var_f430b579 );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xdec9e9fc, Offset: 0x15b0
// Size: 0x1fa
function function_953d6fd0()
{
    var_f430b579 = [];
    voline = spawnstruct();
    voline.alias = "vox_cp_stkt_07110_gmc3_mybuildingisrig_33";
    voline.ent = level.var_469d2832;
    voline.postdelay = 0.5;
    var_f430b579[ var_f430b579.size ] = voline;
    voline = spawnstruct();
    voline.alias = "vox_cp_stkt_07110_gms2_andyou_cf";
    voline.ent = level.var_d171f280;
    voline.postdelay = 1.5;
    var_f430b579[ var_f430b579.size ] = voline;
    voline = spawnstruct();
    voline.alias = "vox_cp_stkt_07110_gmc1_iamstayingwithm_ab";
    voline.ent = level.var_346203bc;
    voline.postdelay = 1;
    var_f430b579[ var_f430b579.size ] = voline;
    voline = spawnstruct();
    voline.alias = "vox_cp_stkt_07110_gms2_yourpapersbotho_d5";
    voline.ent = level.var_d171f280;
    voline.postdelay = 1;
    var_f430b579[ var_f430b579.size ] = voline;
    voline = spawnstruct();
    voline.alias = "vox_cp_stkt_07110_gmc3_finefinebutyouc_17";
    voline.ent = level.var_469d2832;
    voline.postdelay = 1.5;
    var_f430b579[ var_f430b579.size ] = voline;
    voline = spawnstruct();
    voline.alias = "vox_cp_stkt_07110_gms2_iwontaskyouagai_56";
    voline.ent = level.var_d171f280;
    voline.postdelay = 1;
    var_f430b579[ var_f430b579.size ] = voline;
    return var_f430b579;
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 4
// Checksum 0xea57b1fa, Offset: 0x17b8
// Size: 0x184
function function_aad87078( guard, guy1, guy2, var_f430b579 )
{
    guard endon( #"death", #"hash_81580761b9ce6a5" );
    guy1 endon( #"death", #"hash_81580761b9ce6a5" );
    guy2 endon( #"death", #"hash_81580761b9ce6a5" );
    
    foreach ( var_1b73eecc in var_f430b579 )
    {
        if ( !isdefined( var_1b73eecc.ent ) )
        {
            return;
        }
        
        voline = snd::play( var_1b73eecc.alias, [ var_1b73eecc.ent, "j_head" ] );
        snd::function_2fdc4fb( voline );
        wait var_1b73eecc.postdelay;
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0xc5d55b53, Offset: 0x1948
// Size: 0x1dc
function function_a1c3157d( node )
{
    self endon( #"death" );
    self.delete_on_path_end = 1;
    util::waittill_any_ents_two( self, "stealth_attack", level, "alley_1_clear_stealth" );
    level notify( #"hash_743b0b8dcee5f15e" );
    
    if ( level flag::get( "alley_1_clear_stealth" ) )
    {
        self deletedelay();
        return;
    }
    
    self scene::stop();
    self notify( #"hash_81580761b9ce6a5" );
    self dialogue::function_47b06180();
    self namespace_979752dc::enable_stealth_for_ai( 0 );
    goal = getnode( node, "targetname" );
    self spawner::go_to_node( goal );
    level flag::wait_till( "alley_1_clear_stealth" );
    
    if ( level flag::get( "stealth_spotted" ) )
    {
        level flag::clear( "stealth_spotted" );
    }
    
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    self ai::set_behavior_attribute( "sprint", 1 );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xd77f07ab, Offset: 0x1b30
// Size: 0x94
function function_df4cd546()
{
    self endon( #"death" );
    level waittill( #"hash_743b0b8dcee5f15e" );
    self scene::stop();
    self notify( #"hash_81580761b9ce6a5" );
    self dialogue::function_47b06180();
    self ai::set_behavior_attribute( #"_civ_mode", "panic" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x5a46d690, Offset: 0x1bd0
// Size: 0x34c
function function_2855eba1()
{
    bar_bathroom_window_cursor_hint_org = struct::get( "bar_bathroom_window_cursor_hint_org" );
    bar_bathroom_window_cursor_hint_org util::create_cursor_hint( undefined, ( 0, 0, -32 ), #"hash_65c0b59d247abbb7" );
    level scene::init( "cin_stakeout_alley1_bar_alley" );
    bar_bathroom_window_cursor_hint_org waittill( #"trigger" );
    level thread music::setmusicstate( "null", undefined, 3 );
    level thread namespace_5ceacc03::function_d494f15();
    level scene::play( "cin_stakeout_alley1_bar_alley" );
    exploder::stop_exploder( "fx_exp_bar_window_rain" );
    player = getplayers()[ 0 ];
    player val::reset( "alley1", "allow_melee" );
    player val::reset( "alley1", "allow_sprint" );
    wait 0.75;
    level thread hint_tutorial::function_4c2d4fc4( #"hash_61ebb02e310a3103", #"hash_249532bf0905ba7", 1, undefined, 1, 3 );
    level thread hint_tutorial::pause( undefined, undefined, undefined, undefined, "continue" );
    level waittill( #"continue" );
    level flag::set( "get_to_safehouse_meetup_breadcrumb_01_org_reached" );
    wait 1.25;
    namespace_11998b8f::function_a73e6a64();
    namespace_11998b8f::function_cdb7cc7e( 0 );
    player util::blend_movespeedscale_default( 0.2 );
    player namespace_979752dc::set_disguised( 0 );
    level thread function_c5a860f1();
    wait 1;
    level thread music::setmusicstate( "7.0_takedown" );
    
    if ( level scene::is_active( "scene_z_stk_bar_amb" ) )
    {
        level scene::stop( "scene_z_stk_bar_amb" );
    }
    
    if ( isdefined( level.var_221cd219 ) )
    {
        level.var_221cd219 delete();
    }
    
    if ( isdefined( level.var_305cee99 ) )
    {
        level.var_305cee99 delete();
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x4fa25f40, Offset: 0x1f28
// Size: 0xdc
function function_92e02d40()
{
    dialogue::radio( "vox_cp_stkt_06400_adlr_belltheyreflood_31" );
    level flag::wait_till( "get_to_safehouse_meetup_breadcrumb_01_org_reached" );
    wait 3.25;
    dialogue::radio( "vox_cp_stkt_07100_adlr_changeofplansbe_67" );
    wait 1;
    dialogue::radio( "vox_cp_stkt_07100_adlr_rallyupwithlaza_97" );
    wait 1.75;
    
    if ( !level flag::get( "alley_1_clear_stealth" ) )
    {
        level flag::wait_till( "alley_1_clear_stealth" );
        dialogue::radio( "vox_cp_stkt_07200_lazr_carefulbellthes_39" );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xbcfeb70d, Offset: 0x2010
// Size: 0x64
function function_341ad0ec()
{
    var_355c4095 = getentarray( "rotating_fan", "targetname" );
    
    if ( isdefined( var_355c4095 ) )
    {
        array::thread_all( var_355c4095, &namespace_11998b8f::function_638d18a, "alley_2_done", 2 );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0xe9d452cd, Offset: 0x2080
// Size: 0x2c
function function_2d6c81be( *str_objective )
{
    level flag::set( "force_informant_objective_active" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 2
// Checksum 0x15c0554a, Offset: 0x20b8
// Size: 0x39c
function function_34ee80b8( str_objective, var_50cc0d4f )
{
    player = getplayers()[ 0 ];
    
    if ( var_50cc0d4f )
    {
        level thread function_c5a860f1( 1 );
        level thread function_da707a70( 1 );
        namespace_11998b8f::function_cdb7cc7e();
        player spy_camera::function_6de171e9();
        level thread function_341ad0ec();
    }
    
    level.var_4e5a623b = 0;
    level.var_6eed8aea = 1;
    level flag::set( "alley_2_begin" );
    level thread namespace_11998b8f::function_489032c9();
    level thread function_2bebd40b();
    level thread music::setmusicstate( "9.0_informant_safehouse_2" );
    level thread function_2470214();
    level thread function_fa0e91cf();
    wait 0.1;
    level thread function_3e93882();
    level thread function_b75e3865();
    level thread function_9f5019a();
    level thread function_f1d4ab4b();
    level thread namespace_11998b8f::function_91a7f501( "alley_2_ambient_harass_loop", "alley_2_done" );
    level thread namespace_11998b8f::function_a34d0dd3( "alley_2_one_off", "alley_2_done" );
    level.var_364e83ee = spawner::simple_spawn( "alley_2_enemies_hunt", &function_8ed10706 );
    doors::waittill_door_opened( "alley_rooftop_door" );
    level.var_364e83ee = arraycombine( level.var_364e83ee, level.var_ded3c3a4, 0, 0 );
    level thread function_1b5a6cdf();
    level thread function_e192b067();
    level thread function_b9a028e4( "alley_bldg_01_door_01", "flag_alley_2_right_stasi_door" );
    level thread function_b9a028e4( "alley_bldg_01_door_02", "flag_alley_2_right_stasi_door" );
    level thread function_c12e00();
    level flag::wait_till( "alley_2_done" );
    player thread spy_camera::function_c11bdcc0();
    level thread function_d7595334();
    skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x6179049d, Offset: 0x2460
// Size: 0x24c
function function_d7595334()
{
    level flag::wait_till( "flag_alley_3_lazar_close_door" );
    function_1eaaceab( level.var_364e83ee );
    
    foreach ( enemy in level.var_364e83ee )
    {
        if ( !enemy scene::function_c935c42() )
        {
            enemy delete();
        }
    }
    
    if ( isdefined( level.var_cac5e635 ) )
    {
        array::delete_all( level.var_cac5e635 );
    }
    
    if ( isdefined( level.informant_enemies ) )
    {
        array::delete_all( level.informant_enemies );
    }
    
    if ( isdefined( level.informant ) )
    {
        level.informant delete();
    }
    
    ai = getaiteamarray( "axis" );
    
    foreach ( guy in ai )
    {
        if ( guy scene::function_c935c42() )
        {
            guy scene::stop();
        }
        
        guy delete();
    }
    
    waitframe( 1 );
    level flag::clear( "stealth_spotted" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x93dfc8cf, Offset: 0x26b8
// Size: 0xcc
function function_c12e00()
{
    level endon( #"alley_2_done" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level flag::wait_till_all( array( "stealth_spotted", "flag_alley_reinforcements" ) );
    reinforcements = spawner::simple_spawn( "alley_2_enemies_reinforcements" );
    level.var_364e83ee = arraycombine( level.var_364e83ee, reinforcements, 0, 0 );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x6d9e1bee, Offset: 0x2790
// Size: 0x84
function function_8ed10706()
{
    if ( self.archetype == #"civilian" )
    {
        return;
    }
    
    if ( self.script_parameters === "flashlight" )
    {
        self.flashlightoverride = 1;
    }
    
    if ( self.team == "axis" )
    {
        self.goalradius = 32;
        self namespace_979752dc::set_default_patrol_style( "alert" );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x4dc46ff9, Offset: 0x2820
// Size: 0x12
function function_6d36d51()
{
    self.goalradius = 32;
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xae91c2e9, Offset: 0x2840
// Size: 0x7c
function function_16cb86fb()
{
    if ( !isdefined( level.var_cac5e635 ) )
    {
        level.var_cac5e635 = [];
    }
    else if ( !isarray( level.var_cac5e635 ) )
    {
        level.var_cac5e635 = array( level.var_cac5e635 );
    }
    
    level.var_cac5e635[ level.var_cac5e635.size ] = self;
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xa639a2ba, Offset: 0x28c8
// Size: 0xe4
function function_b75e3865()
{
    level endon( #"stealth_spotted" );
    scene::add_scene_func( "scene_z_stk_courtyard_harass", &namespace_11998b8f::function_e24505b7, "init" );
    level.alley_2_enemies_harass_intro = spawner::simple_spawn( "alley_2_enemies_harass_intro", &function_8ed10706 );
    level scene::init( "scene_z_stk_courtyard_harass", level.alley_2_enemies_harass_intro );
    doors::waittill_door_opened( "alley_rooftop_door" );
    level thread scene::play( "scene_z_stk_courtyard_harass", level.alley_2_enemies_harass_intro );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xfc90141c, Offset: 0x29b8
// Size: 0x1ec
function function_9f5019a()
{
    scene::add_scene_func( "scene_z_stk_alley_harass_police_arrival", &namespace_11998b8f::function_c1bc96cf, "play" );
    scene::add_scene_func( "scene_z_stk_alley_harass_police_arrival", &function_1b2bbf03, "play" );
    level.var_ded3c3a4 = spawner::simple_spawn( "alley_2_enemies_intro", &function_8ed10706 );
    var_b1244cc9 = getentarray( "alley_2_police_cars", "targetname" );
    
    foreach ( car in var_b1244cc9 )
    {
        if ( !isdefined( car.script_animname ) )
        {
            arrayremovevalue( var_b1244cc9, car );
        }
    }
    
    scene_ents = arraycombine( level.var_ded3c3a4, var_b1244cc9, 0, 0 );
    level scene::init( "scene_z_stk_alley_harass_police_arrival", scene_ents );
    doors::waittill_door_opened( "alley_rooftop_door" );
    thread namespace_5ceacc03::function_151612f4();
    wait 0.75;
    level thread scene::play( "scene_z_stk_alley_harass_police_arrival", scene_ents );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0x4a5aeee2, Offset: 0x2bb0
// Size: 0x168
function function_1b2bbf03( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent.script_animname ) && ent.script_animname == "policecar1" )
        {
            ent thread function_2c29df3d( 1, undefined, "stop_lights" );
        }
        
        if ( isdefined( ent.script_animname ) && ent.script_animname == "policecar2" )
        {
            ent thread function_2c29df3d( 1, undefined, "stop_lights" );
        }
        
        if ( isdefined( ent.script_animname ) && ent.script_animname == "policecar3" )
        {
            ent thread function_2c29df3d( 1, 1, undefined, "flag_alley_3_lazar_close_door" );
        }
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 4
// Checksum 0x5aae057, Offset: 0x2d20
// Size: 0x10c
function function_2c29df3d( lights, var_686a32c8, var_3e3521f8, var_ae14ed6b )
{
    if ( is_true( lights ) )
    {
        self thread cp_ger_stakeout_fx::function_93e3e68a( 1 );
    }
    
    if ( is_true( var_686a32c8 ) )
    {
        self thread cp_ger_stakeout_fx::function_ad03f35b( 1 );
    }
    
    if ( isdefined( var_3e3521f8 ) )
    {
        self waittill( var_3e3521f8 );
    }
    
    if ( isdefined( var_ae14ed6b ) )
    {
        level waittill( var_ae14ed6b );
    }
    
    if ( is_true( lights ) )
    {
        self thread cp_ger_stakeout_fx::function_93e3e68a();
    }
    
    if ( is_true( var_686a32c8 ) )
    {
        self thread cp_ger_stakeout_fx::function_ad03f35b();
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x680e4620, Offset: 0x2e38
// Size: 0xe4
function function_f1d4ab4b()
{
    scene::add_scene_func( "scene_z_stk_amb_curtain_close", &function_83c96fe5, "init" );
    scene::add_scene_func( "scene_z_stk_amb_window_peek", &function_65090e11, "init" );
    level thread scene::play( "scene_z_stk_amb_window_peek" );
    level scene::init( "scene_z_stk_amb_curtain_close" );
    level flag::wait_till( "flag_alley_2_close_curtains" );
    level scene::play( "scene_z_stk_amb_curtain_close" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0xf7ef2da0, Offset: 0x2f28
// Size: 0xbc
function function_83c96fe5( a_ents )
{
    level flag::wait_till( "alley_2_done" );
    
    if ( isdefined( a_ents[ #"civ" ] ) )
    {
        level scene::stop( "scene_z_stk_amb_curtain_close" );
        a_ents[ #"civ" ] delete();
    }
    
    if ( isdefined( a_ents[ #"curtains" ] ) )
    {
        a_ents[ #"curtains" ] delete();
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0x1592ae55, Offset: 0x2ff0
// Size: 0xbc
function function_65090e11( a_ents )
{
    level flag::wait_till( "alley_2_done" );
    level thread scene::stop( "scene_z_stk_amb_window_peek" );
    
    if ( isdefined( a_ents[ #"civ1" ] ) )
    {
        a_ents[ #"civ1" ] delete();
    }
    
    if ( isdefined( a_ents[ #"civ2" ] ) )
    {
        a_ents[ #"civ2" ] delete();
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 2
// Checksum 0xc0575672, Offset: 0x30b8
// Size: 0x54
function function_b9a028e4( door, flag )
{
    if ( !isdefined( door ) )
    {
        return;
    }
    
    doors::waittill_door_opened( door );
    
    if ( !isdefined( flag ) )
    {
        return;
    }
    
    level flag::set( flag );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x2017bbaa, Offset: 0x3118
// Size: 0x7c
function function_e192b067()
{
    level flag::wait_till( "flag_alley_gunshots" );
    exploder::exploder( "fx_exp_alley_gunshot" );
    wait 2;
    exploder::exploder( "fx_exp_alley_gunshot" );
    wait 0.2;
    exploder::exploder( "fx_exp_alley_gunshot" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x38336777, Offset: 0x31a0
// Size: 0xfc
function function_1b5a6cdf()
{
    level endon( #"alley_2_done" );
    level endon( #"stealth_spotted" );
    wait 3;
    player = getplayers()[ 0 ];
    player thread spy_camera::function_69190c4e();
    player util::show_hint_text( #"hash_781598921bc9b69e", undefined, undefined, 4 );
    player waittill( #"enter_camera_ads" );
    player util::hide_hint_text();
    wait 2;
    player util::show_hint_text( #"hash_15f6e99dbddd12f3", undefined, undefined, 4 );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0, eflags: 0x4
// Checksum 0xd8c29256, Offset: 0x32a8
// Size: 0x10a, Type: bool
function private function_9a62b273()
{
    self endon( #"death" );
    enemies = getaiarray( "axis" );
    function_1eaaceab( enemies );
    arrayremovevalue( enemies, self );
    
    if ( enemies.size > 0 )
    {
        foreach ( enemy in enemies )
        {
            if ( enemy cansee( self ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0, eflags: 0x4
// Checksum 0xac4efd38, Offset: 0x33c0
// Size: 0x150, Type: bool
function private function_cc2a7cde()
{
    self endon( #"death" );
    enemies = getaiarray( "axis" );
    function_1eaaceab( enemies );
    arrayremovevalue( enemies, self );
    
    if ( enemies.size > 0 )
    {
        foreach ( enemy in enemies )
        {
            if ( isdefined( level.stealth.damage_auto_range ) && distancesquared( self.origin, enemy.origin ) <= level.stealth.damage_auto_range * level.stealth.damage_auto_range )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x78871e1a, Offset: 0x3518
// Size: 0x74
function function_2470214()
{
    doors::waittill_door_opened( "alley_rooftop_door" );
    dialogue::radio( "vox_cp_stkt_07200_lazr_meetmeattheapar_13" );
    level flag::set( "alley_2_ping_lazar" );
    wait 1;
    dialogue::radio( "vox_cp_stkt_07200_lazr_illprovideoverw_93" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x1a73ccf8, Offset: 0x3598
// Size: 0xb4
function function_fa0e91cf()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level flag::wait_till( "start_alley_2_mid_team_checkin_vo" );
    dialogue::radio( "vox_cp_stkt_07286_adlr_parkgimmeasitre_4f" );
    dialogue::radio( "vox_cp_stkt_07286_park_krausjustarrive_28" );
    dialogue::radio( "vox_cp_stkt_07286_adlr_thestasiarecomb_8d" );
    dialogue::radio( "vox_cp_stkt_07286_adlr_bellgettoparkan_22" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 2
// Checksum 0xa2fd7355, Offset: 0x3658
// Size: 0x14
function function_27da16fb( *name, *type )
{
    
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x734c1a55, Offset: 0x3678
// Size: 0x7c
function function_14f12d60()
{
    spawner::add_spawn_function_group( "generic_stealth_civ", "script_noteworthy", &function_3b8e249 );
    level flag::wait_till( "alley_3_done" );
    
    if ( isdefined( level.generic_stealth_civ ) )
    {
        array::delete_all( level.generic_stealth_civ );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xd1d580d3, Offset: 0x3700
// Size: 0xfa
function function_3b8e249()
{
    if ( !isdefined( level.generic_stealth_civ ) )
    {
        level.generic_stealth_civ = [];
    }
    else if ( !isarray( level.generic_stealth_civ ) )
    {
        level.generic_stealth_civ = array( level.generic_stealth_civ );
    }
    
    level.generic_stealth_civ[ level.generic_stealth_civ.size ] = self;
    assert( isdefined( self.target ), "<dev string:x38>" );
    
    if ( isdefined( self.script_parameters ) )
    {
        switch ( self.script_parameters )
        {
            case #"hash_7724080f9c46a69":
                self.var_1c874b1d = 1;
                break;
            default:
                break;
        }
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xa08c0b85, Offset: 0x3808
// Size: 0xdc
function function_2bebd40b()
{
    var_9a690256 = getent( "collectible_reel", "targetname" );
    
    if ( collectibles::function_ab921f3d( 2 ) )
    {
        var_9a690256 delete();
        return;
    }
    
    var_9a690256 util::create_cursor_hint( "tag_origin", ( 0, 0, 4 ), #"hash_7993f62965290e3a" );
    var_9a690256 waittill( #"trigger" );
    var_9a690256 delete();
    collectibles::function_6cd091d2( 2 );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0x68fbb64, Offset: 0x38f0
// Size: 0x154
function function_5e8eb7c1( skipto )
{
    if ( !is_true( skipto ) )
    {
        level flag::wait_till( "alley_1_done" );
    }
    
    if ( isdefined( objectives::function_285e460( "obj_informant" ) ) )
    {
        position = struct::get( "alley_stasi_field_house_obj_org_01", "targetname" );
        objectives::show( "obj_informant" );
        objectives::update_position( "obj_informant", position.origin );
        objectives::function_67f87f80( "obj_informant", undefined, #"hash_3f0ff8958b0e0afa" );
        level thread function_d5bb4d12();
    }
    
    level thread function_b6b34597();
    level thread function_51bd3310();
    level flag::wait_till( "alley_2_done" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x8ae600a8, Offset: 0x3a50
// Size: 0x148
function function_d5bb4d12()
{
    level endon( #"alley_2_done", #"informant_released", #"informant_killed" );
    
    while ( true )
    {
        level flag::wait_till( "alley_stasi_field_house_reached" );
        
        if ( isdefined( objectives::function_285e460( "obj_informant" ) ) )
        {
            objectives::update_position( "obj_informant", level.informant.origin + ( 0, 0, 64 ) );
        }
        
        level flag::wait_till_clear( "alley_stasi_field_house_reached" );
        
        if ( isdefined( objectives::function_285e460( "obj_informant" ) ) )
        {
            position = struct::get( "alley_stasi_field_house_obj_org_01", "targetname" );
            objectives::update_position( "obj_informant", position.origin );
        }
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x1ceac55d, Offset: 0x3ba0
// Size: 0xf0
function function_51bd3310()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    stasi_field_house_note_01 = getent( "stasi_field_house_note_01", "targetname" );
    stasi_field_house_note_01 util::create_cursor_hint( undefined, undefined, #"hash_278936de1fc46bb3" );
    
    while ( true )
    {
        stasi_field_house_note_01 waittill( #"trigger" );
        
        /#
            iprintlnbold( "<dev string:x66>" );
        #/
        
        level flag::set( "player_read_stasi_field_house_note" );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x3d201da8, Offset: 0x3c98
// Size: 0x84
function function_b6b34597()
{
    level flag::wait_till( "flag_spawn_informant_room" );
    level.informant_enemies = spawner::simple_spawn( "informant_enemies", &function_d29b9236 );
    level.informant = spawner::simple_spawn_single( "informant", &function_dfd339e4 );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x9f4e11da, Offset: 0x3d28
// Size: 0x2a
function function_d29b9236()
{
    self.health = 50;
    self.var_66f1a336 = &function_71e39bbd;
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xbbbbf2b7, Offset: 0x3d60
// Size: 0x102
function function_71e39bbd()
{
    self.var_c681e4c1 = 1;
    self.skipdeath = 1;
    self.a.nodeath = 1;
    
    if ( isdefined( self.script_noteworthy ) )
    {
        switch ( self.script_noteworthy )
        {
            case #"hash_1b55b7fda239e812":
                level thread scene::play( "aib_vign_reb_stl_idle_sit_laptop", "death", self );
                break;
            case #"hash_3bb5ea4a0cfc5400":
                level thread scene::play( "aib_vign_reb_stl_idle_sit_sleeping_idle", "death", self );
                break;
            case #"hash_249cfaf1cb382b51":
                level thread scene::play( "aib_vign_reb_stl_idle_sit_gunmaintenance", "death", self );
                break;
        }
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x5482aa6d, Offset: 0x3e70
// Size: 0x204
function function_dfd339e4()
{
    level endon( #"mission_failed" );
    self endon( #"death" );
    self.targetname = "actor_informant";
    self.team = "axis";
    self setcandamage( 1 );
    self.var_c681e4c1 = 1;
    self.skipdeath = 1;
    self.var_2609b537 = 1;
    self.health = 100000;
    self.name = "Informant";
    level scene::init( "aib_vign_stakeout_alley2_informant" );
    self thread function_1bad6781();
    self thread function_761b250d();
    
    if ( !level flag::get( "informant_released" ) )
    {
        self thread function_1b6d2916();
    }
    
    self waittill( #"hash_4d9e21fd0dcc04a9" );
    level thread function_35612e24();
    self thread function_90382186();
    self setcandamage( 1 );
    self.skipdeath = 0;
    self.health = 10;
    self.favoriteenemy = getplayers()[ 0 ];
    self waittill( #"released" );
    self thread function_e92085b3();
    self util::auto_delete( undefined, undefined, 1000 );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xc011b0c, Offset: 0x4080
// Size: 0x84
function function_90382186()
{
    self endon( #"death" );
    level waittill( #"hash_53933f4c3658c33c" );
    self.fixednode = 1;
    var_f6c40dcd = getent( "informant_gv", "targetname" );
    
    if ( isdefined( var_f6c40dcd ) )
    {
        self setgoal( var_f6c40dcd );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x202b1ba0, Offset: 0x4110
// Size: 0x7c
function function_35612e24()
{
    if ( isdefined( objectives::function_285e460( "obj_informant" ) ) )
    {
        objectives::complete( "obj_informant" );
    }
    
    level flag::set( "informant_released" );
    level thread music::function_edda155f( "9.0_informant_safehouse_stinger" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xa41c8313, Offset: 0x4198
// Size: 0xe4
function function_1bad6781()
{
    self endon( #"death", #"hash_4d9e21fd0dcc04a9" );
    s_result = self waittill( #"damage" );
    self notify( #"informant_death" );
    self lookatentity();
    self val::set( "informant_death", "takedamage", 0 );
    level scene::play( "aib_vign_stakeout_alley2_informant", "death" );
    
    /#
        iprintlnbold( "<dev string:xa5>" );
    #/
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x5da5fd65, Offset: 0x4288
// Size: 0x64
function function_eb384519()
{
    self endon( #"released" );
    self waittill( #"damage", #"death" );
    
    if ( self scene::function_c935c42() )
    {
        self scene::stop();
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xd05f4618, Offset: 0x42f8
// Size: 0xc4
function function_e92085b3()
{
    self endon( #"death" );
    
    while ( true )
    {
        s_result = self waittill( #"damage" );
        
        if ( isplayer( s_result.attacker ) )
        {
            self.var_2e3fa910 = 1;
            self.favoriteenemy = s_result.attacker;
            self val::reset_radiant( "ignoreall" );
            self val::reset_radiant( "ignoreme" );
            self.skipdeath = 0;
            return;
        }
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x78582b02, Offset: 0x43c8
// Size: 0x20c
function function_761b250d()
{
    player = getplayers()[ 0 ];
    s_result = self waittill( #"death", #"informant_death" );
    
    if ( ( isdefined( self.health ) ? self.health : 0 ) > 0 )
    {
        level flag::set( "informant_deleted" );
    }
    
    waitframe( 1 );
    
    if ( level flag::get( "informant_deleted" ) )
    {
        if ( level flag::get( "informant_released" ) )
        {
            player util::function_f3b8529c( 0 );
        }
        else
        {
            level flag::set( "informant_killed" );
            player util::function_f3b8529c( 1 );
            level flag::clear( "informant_released" );
            
            if ( isdefined( objectives::function_285e460( "obj_informant" ) ) )
            {
                objectives::remove( "obj_informant" );
            }
        }
        
        return;
    }
    
    level flag::set( "informant_killed" );
    player util::function_f3b8529c( 1 );
    level flag::clear( "informant_released" );
    
    if ( isdefined( objectives::function_285e460( "obj_informant" ) ) )
    {
        objectives::complete( "obj_informant" );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xc20ff12b, Offset: 0x45e0
// Size: 0x2d8
function function_1b6d2916()
{
    self endon( #"death" );
    self thread function_9dd751e9();
    var_6e695d6d = #"hash_534ff4023162856c";
    var_f1b13556 = #"hash_75dbd9e94f49c2d8";
    var_314be333 = #"hash_534ff70231628a85";
    var_41dc8454 = #"hash_534ff602316288d2";
    var_f98ce627 = #"hash_656b6f2304158027";
    var_d1de180 = #"hash_11f0e4dd5bf7075b";
    var_87b83dca = dialog_tree::new_tree( &function_88724c2d, undefined, 1, 1, "aib_vign_stakeout_alley2_informant" );
    var_87b83dca thread dialog_tree::function_a3a3ea7d( var_d1de180, "informant_enemies_cleared" );
    var_dfc957f2 = var_87b83dca dialog_tree::add_option( var_6e695d6d, "vox_cp_stkt_07300_info_ivebeenmonitori_73", undefined, undefined, 0, undefined, undefined, &function_9a8402c8 );
    var_87b83dca dialog_tree::function_da884b08( var_dfc957f2, "unlock_informant_dialog_choice_01_a", var_f1b13556, "vox_cp_stkt_07300_info_idontknowwherey_34", undefined, undefined, 0, undefined, undefined, &function_e97a2940 );
    var_87b83dca dialog_tree::function_da884b08( var_dfc957f2, "informant_dialog_choice_01_finished", var_314be333, "vox_cp_stkt_07300_info_thankyouforsavi_ee", undefined, undefined, 1, undefined, undefined, &function_ac42a645 );
    var_87b83dca dialog_tree::function_da884b08( var_dfc957f2, "informant_dialog_choice_01_finished", var_41dc8454, "vox_cp_stkt_07300_info_pleaseyoucantdo_41", undefined, undefined, 0, undefined, undefined, &function_2c76269e );
    var_87b83dca dialog_tree::add_option( var_f98ce627, undefined, undefined, undefined, 1, undefined, "forever", &function_52cc8d82 );
    
    while ( true )
    {
        if ( !isalive( level.informant ) )
        {
            return;
        }
        
        if ( level flag::get_any( array( "informant_released", "informant_killed" ) ) )
        {
            return;
        }
        
        self dialog_tree::function_cfa96cee( var_87b83dca, undefined, undefined, "informant_death", undefined, undefined, undefined, undefined, 1 );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x11931f65, Offset: 0x48c0
// Size: 0xc4
function function_9dd751e9()
{
    self endon( #"death", #"informant_death", #"delete", #"released" );
    level flag::wait_till_any( array( "informant_enemies_stealth_spotted", "informant_enemies_cleared" ) );
    self lookatentity( getplayers()[ 0 ] );
    self dialogue::queue( "vox_cp_stkt_07300_info_youiveseenyourp_59" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x168f9c3a, Offset: 0x4990
// Size: 0x24
function function_88724c2d()
{
    level thread scene::play( "aib_vign_stakeout_alley2_informant_player" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x200314dd, Offset: 0x49c0
// Size: 0x64
function function_9a8402c8()
{
    level flag::set( "informant_dialog_choice_01_finished" );
    
    if ( level flag::get( "player_read_stasi_field_house_note" ) )
    {
        level flag::set( "unlock_informant_dialog_choice_01_a" );
    }
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x80f724d1, Offset: 0x4a30
// Size: 0x4
function function_e97a2940()
{
    
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x1a1981ec, Offset: 0x4a40
// Size: 0xcc
function function_ac42a645()
{
    level.informant endon( #"death" );
    level.informant notify( #"hash_4d9e21fd0dcc04a9" );
    level.informant thread function_eb384519();
    level.informant lookatentity();
    level thread scene::play( "aib_vign_stakeout_alley2_informant_player", "exit" );
    level scene::play( "aib_vign_stakeout_alley2_informant", "release" );
    level.informant notify( #"released" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x80f724d1, Offset: 0x4b18
// Size: 0x4
function function_2c76269e()
{
    
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x92dfea2c, Offset: 0x4b28
// Size: 0x2c
function function_52cc8d82()
{
    level thread scene::play( "aib_vign_stakeout_alley2_informant_player", "exit" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0x8c7eef98, Offset: 0x4b60
// Size: 0x24
function function_8262abe1( *str_objective )
{
    level thread function_14f12d60();
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 2
// Checksum 0x9d25ac77, Offset: 0x4b90
// Size: 0x404
function function_b4ae0031( str_objective, var_50cc0d4f )
{
    player = getplayers()[ 0 ];
    
    if ( var_50cc0d4f )
    {
        level thread function_c5a860f1( 1 );
        namespace_11998b8f::function_cdb7cc7e();
        player spy_camera::function_6de171e9();
        level function_3e93882( var_50cc0d4f );
    }
    
    level thread function_fe7e195a();
    level thread scene::play( "scene_z_stk_lazar_meetup", "door_start_loop" );
    level scene::play( "scene_z_stk_lazar_meetup", "open_door" );
    
    if ( !level flag::get( "flag_alley_3_lazar_close_door" ) )
    {
        level thread scene::play( "scene_z_stk_lazar_meetup", "open_door_loop" );
        level flag::wait_till( "flag_alley_3_lazar_close_door" );
    }
    
    level thread function_9f4c9a02();
    scene::add_scene_func( "scene_z_stk_electronics_store", &namespace_afd0968c::function_9df174aa, "init" );
    level scene::init( "scene_z_stk_electronics_store" );
    level scene::play( "scene_z_stk_lazar_meetup", "hall_walk" );
    
    if ( level flag::get( "flag_alley_3_courtyard_door" ) )
    {
        thread namespace_5ceacc03::function_7e88a33b();
        level scene::play( "scene_z_stk_lazar_meetup", "courtyard_branch" );
    }
    else
    {
        level scene::play( "scene_z_stk_lazar_meetup", "lazar_traversal" );
        level thread scene::play( "scene_z_stk_lazar_meetup", "courtyard_door_loop" );
        level flag::wait_till( "flag_alley_3_courtyard_door" );
        thread namespace_5ceacc03::function_7e88a33b();
        level scene::play( "scene_z_stk_lazar_meetup", "enter_courtyard" );
    }
    
    level thread function_af6b3208();
    level flag::clear( "stealth_spotted" );
    ai = getaiarray();
    player namespace_979752dc::set_disguised( 1 );
    level thread namespace_11998b8f::function_de88eefd();
    level thread namespace_fba81a7f::function_37acd633();
    level scene::play( "scene_z_stk_lazar_meetup", "courtyard_walk" );
    level flag::set( "alley_3_done" );
    level skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0x9a32231f, Offset: 0x4fa0
// Size: 0x114
function function_3e93882( var_50cc0d4f )
{
    if ( !is_true( var_50cc0d4f ) )
    {
        level flag::wait_till( "alley_2_spawn_lazar" );
    }
    
    util::function_268bdf4f( "lazar", &namespace_11998b8f::function_2f0f0a84 );
    level.lazar val::set( "alley_3", "ignoreme", 1 );
    level.lazar val::set( "alley_3", "ignoreall", 1 );
    level.lazar.holdfire = 1;
    level.lazar.goalradius = 32;
    level scene::init( "scene_z_stk_lazar_meetup" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xe4809b6a, Offset: 0x50c0
// Size: 0x84
function function_fe7e195a()
{
    level waittill( #"hash_2b937901ed36ac46" );
    
    if ( !level flag::get( "stealth_spotted" ) )
    {
        level.lazar dialogue::queue( "vox_cp_stkt_07300_lazr_niceworkbellfol_e2" );
        return;
    }
    
    level.lazar dialogue::queue( "vox_cp_stkt_07300_lazr_ifthatsyourlowp_1e" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0xbea9256f, Offset: 0x5150
// Size: 0x44
function function_af6b3208()
{
    level flag::wait_till( "flag_alley_3_vista_car" );
    level thread namespace_11998b8f::function_973a721b( "alley_3_car_1" );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0xc07c1dec, Offset: 0x51a0
// Size: 0x1d4
function function_c5a860f1( skipto )
{
    var_8a7843d = struct::get( "get_to_safehouse_meetup_breadcrumb_02_org", "targetname" );
    position = struct::get( "get_to_safehouse_meetup_obj_org", "targetname" );
    
    if ( is_true( skipto ) )
    {
        objectives::goto( "obj_meet_lazar", position.origin, #"hash_4c52ece55785d7cd", 1, 0 );
        objectives::function_67f87f80( "obj_meet_lazar", undefined, #"hash_31d26c6e0c54bbbc" );
    }
    else
    {
        objectives::goto( "obj_meet_lazar", var_8a7843d.origin, #"hash_4c52ece55785d7cd", 1, 0 );
        objectives::function_67f87f80( "obj_meet_lazar", undefined, #"hash_31d26c6e0c54bbbc" );
        level flag::wait_till( "update_lazar_obj_position" );
        objectives::update_position( "obj_meet_lazar", position.origin );
    }
    
    level flag::wait_till( "alley_2_ping_lazar" );
    player = getplayers()[ 0 ];
    player thread objectives_ui::show_objectives( 1 );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 1
// Checksum 0x1902da87, Offset: 0x5380
// Size: 0x9c
function function_da707a70( skipto )
{
    objectives::goto( "obj_informant", undefined, #"hash_e6075ef87c0c55b", 1, 0 );
    objectives::function_572778b9( "obj_informant" );
    
    if ( !is_true( skipto ) )
    {
        objectives::hide( "obj_informant" );
    }
    
    level thread function_5e8eb7c1( skipto );
}

// Namespace namespace_4dc9a074/namespace_4dc9a074
// Params 0
// Checksum 0x734720c9, Offset: 0x5428
// Size: 0x9c
function function_9f4c9a02()
{
    objectives::hide( "obj_meet_lazar" );
    objectives::follow( "follow_lazar", level.lazar, undefined, 0, 0 );
    level flag::wait_till( "alley_3_done" );
    objectives::complete( "follow_lazar", level.lazar );
    objectives::complete( "obj_meet_lazar" );
}

