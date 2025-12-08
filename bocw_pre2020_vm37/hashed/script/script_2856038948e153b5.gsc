#using script_1b9f100b85b7e21d;
#using script_1fd2c6e5fc8cb1c3;
#using script_3dc93ca9902a9cda;
#using script_4ec222619bffcfd1;
#using script_4fdb32cc1d125464;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_12aa0683;

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 1
// Checksum 0x6a973d3c, Offset: 0xa60
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 2
// Checksum 0x12aa3f0, Offset: 0xa78
// Size: 0x2d4
function main( var_d3440450, var_50cc0d4f )
{
    level flag::set( "aslt_bunker_escape_deploy_gas_begin" );
    
    if ( is_true( var_50cc0d4f ) )
    {
        level.adler = namespace_e77bf565::adler_spawn( var_d3440450, "adler_shotgun" );
        level thread scene::skipto_end_noai( "scene_kgb_door_kick", "Last_Frame", undefined, 1 );
        level thread scene::skipto_end_noai( "scene_kgb_utility_room_adler", "Door_Closed", undefined, 1 );
    }
    
    level thread namespace_e77bf565::escape_objective( var_d3440450, var_50cc0d4f );
    level thread function_b735db01();
    level thread function_d0ef0702( var_d3440450 );
    level thread kgb_aslt_exfil_escape::function_1f999428();
    spawner::add_spawn_function_ai_group( "elevator_exfil_intro_runners", &function_59dd75dc );
    spawner::add_spawn_function_ai_group( "gas_masked_shotgun_seekers", &function_92d72c13 );
    spawner::add_spawn_function_ai_group( "deploy_gas_initial_guys", &function_2adf5677 );
    spawner::add_spawn_function_ai_group( "deploy_gas_gassed_guys", &function_2f389b60 );
    level thread scene::init( "scene_kgb_elevator_intro" );
    level thread scene::init( "scene_kgb_lights_out" );
    level thread scene::init( "scene_kgb_elevator_exfil_intro_adler" );
    level thread scene::init( "scene_kgb_elevator_exfil_intro_insideman" );
    level thread function_15d8d7cd();
    level flag::set( "turn_on_elevator_alarm_light" );
    level flag::wait_till( "aslt_bunker_escape_deploy_gas_complete" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0x428242d9, Offset: 0xd58
// Size: 0x3c
function function_2adf5677()
{
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.var_c681e4c1 = 1;
    self namespace_e77bf565::function_4f71d4ee();
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0xb2c42c2c, Offset: 0xda0
// Size: 0x5c
function function_2f389b60()
{
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.var_c681e4c1 = 1;
    self ai::gun_remove();
    self.dontdropweapon = 1;
    self namespace_e77bf565::function_4f71d4ee();
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 4
// Checksum 0x3dcbc759, Offset: 0xe08
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0x7e7ee196, Offset: 0xe38
// Size: 0x184
function init_flags()
{
    level flag::init( "aslt_bunker_escape_deploy_gas_begin" );
    level flag::init( "aslt_bunker_escape_deploy_gas_complete" );
    level flag::init( "adler_at_deploy_gas_start_node" );
    level flag::init( "player_at_deploy_gas_door" );
    level flag::init( "gas_deployed" );
    level flag::init( "enable_inside_man_interact" );
    level flag::init( "enable_inside_man_rescue_objective" );
    level flag::init( "inside_man_rescued" );
    level flag::init( "inside_man_rescue_done" );
    level flag::init( "turn_on_elevator_alarm_light" );
    level flag::init( "player_gasmask_on" );
    level flag::init( "inside_man_rescue_objective_cleaned_up" );
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0x2100f6f8, Offset: 0xfc8
// Size: 0x34
function init_clientfields()
{
    clientfield::register( "toplayer", "set_player_pbg_bank", 1, 2, "int" );
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0x4fbc830d, Offset: 0x1008
// Size: 0xa4
function function_22b7fffd()
{
    animation::add_notetrack_func( "kgb_aslt_bunker_escape_deploy_gas::attach_gas_mask", &function_59dd75dc );
    animation::add_notetrack_func( "kgb_aslt_bunker_escape_deploy_gas::detach_gas_mask", &function_b5b663 );
    animation::add_notetrack_func( "kgb_aslt_bunker_escape_deploy_gas::pa_you_are_surrounded", &function_9074c842 );
    animation::add_notetrack_func( "kgb_aslt_bunker_escape_deploy_gas::player_rescue_anim_done", &function_c4fbab80 );
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 1
// Checksum 0x20d0842b, Offset: 0x10b8
// Size: 0x14c
function function_d0ef0702( var_d3440450 )
{
    level thread function_36e68765( var_d3440450 );
    level flag::wait_till( "player_at_deploy_gas_door" );
    namespace_353d803e::music( "13.7_holding_belikov" );
    thread namespace_353d803e::function_b6b29051();
    level flag::wait_till( "inside_man_rescue_done" );
    namespace_353d803e::music( "14.0b_full_alert" );
    level flag::wait_till( "heavy_gear_vo" );
    level.inside_man dialogue::queue( "vox_cp_rkgb_05300_blkv_thereareheavywe_b0" );
    wait 0.5;
    level.inside_man dialogue::queue( "vox_cp_rkgb_05300_blkv_weneedtoarmours_51" );
    wait 1;
    level.inside_man dialogue::queue( "vox_cp_rkgb_05300_blkv_keepmovingthege_d6" );
    level thread savegame::checkpoint_save();
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 1
// Checksum 0x5d4b7136, Offset: 0x1210
// Size: 0x66
function function_9074c842( *params )
{
    detonate_gas_speaker_org = struct::get( "detonate_gas_speaker_org", "targetname" );
    sndobj = snd::function_9ae4fc6f( "vox_cp_rkgb_05100_rms1_youaresurrounde_83", detonate_gas_speaker_org.origin );
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0x5e576a8e, Offset: 0x1280
// Size: 0xe6
function function_ba2191eb()
{
    level endon( #"gas_deployed" );
    wait 1;
    detonate_gas_speaker_org = struct::get( "detonate_gas_speaker_org", "targetname" );
    sndobj = snd::function_9ae4fc6f( "vox_cp_rkgb_05100_rms1_dropyourweapons_cf", detonate_gas_speaker_org.origin );
    snd::function_2fdc4fb( sndobj );
    wait 2;
    detonate_gas_speaker_org = struct::get( "detonate_gas_speaker_org", "targetname" );
    sndobj = snd::function_9ae4fc6f( "vox_cp_rkgb_05100_rms1_thisisyourfinal_f1", detonate_gas_speaker_org.origin );
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 1
// Checksum 0x95ba185a, Offset: 0x1370
// Size: 0x5c
function function_c4fbab80( *params )
{
    player = getplayers()[ 0 ];
    player val::reset( #"scene_kgb_inside_man_on_knees", "disable_weapons" );
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 1
// Checksum 0x8cb99306, Offset: 0x13d8
// Size: 0x51c
function function_36e68765( *var_d3440450 )
{
    level flag::wait_till( "adler_exit_walkup_loop" );
    wait 4.5;
    level.inside_man = namespace_e77bf565::function_e4660071( undefined, "inside_man_shotgun" );
    level.inside_man.primaryweapon = getweapon( #"shotgun_pump_t9" );
    level.gas_guards = spawner::simple_spawn( "gas_guards" );
    level thread scene::play( "scene_kgb_inside_man_on_knees", "Intro", level.gas_guards );
    level flag::wait_till( "gas_deployed" );
    level flag::wait_till( "player_gasmask_on" );
    level thread scene::play( "scene_kgb_inside_man_on_knees", "Outro", level.gas_guards );
    level flag::wait_till( "enable_inside_man_interact" );
    level.var_a910b1a = util::spawn_model( "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.var_a910b1a linkto( level.inside_man, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.var_a910b1a dontinterpolate();
    wait 0.05;
    level.var_a910b1a util::create_cursor_hint( "tag_origin", undefined, #"hash_47c6b9a9b0461df0", 96 );
    level flag::set( "enable_inside_man_rescue_objective" );
    s_result = level.var_a910b1a waittilltimeout( 20, #"trigger" );
    level.var_a910b1a util::remove_cursor_hint();
    function_1eaaceab( level.gas_guards );
    level thread scene::play( "scene_kgb_inside_man_on_knees", "Downed_Loop", level.gas_guards );
    
    if ( s_result._notify == #"trigger" )
    {
        player = getplayers()[ 0 ];
        player val::set( #"scene_kgb_inside_man_on_knees", "disable_weapons", 1 );
        level flag::set( "inside_man_rescued" );
        level thread scene::play( "scene_kgb_inside_man_on_knees", "rescue" );
        level.inside_man ai::set_behavior_attribute( "demeanor", "cqb" );
        level.inside_man colors::set_force_color( "g" );
        level.inside_man colors::enable();
        level.adler ai::set_behavior_attribute( "demeanor", "cqb" );
        level.adler colors::set_force_color( "g" );
        level.adler colors::enable();
        level thread savegame::checkpoint_save();
        level flag::wait_till( "inside_man_rescue_objective_cleaned_up" );
        level.var_a910b1a delete();
        return;
    }
    
    if ( s_result._notify == #"timeout" )
    {
        level.var_a910b1a delete();
        iprintlnbold( "Belikov was killed." );
        util::missionfailedwrapper( #"hash_7880a61f047fcad3", #"hash_7880a61f047fcad3" );
    }
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0xe2203c51, Offset: 0x1900
// Size: 0x424
function function_b735db01()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level.adler endon( #"death" );
    level.adler colors::disable();
    level.adler ai::set_behavior_attribute( "demeanor", "combat" );
    level.adler ai::set_behavior_attribute( "sprint", 1 );
    scene::play( "scene_kgb_detonate_gas", "Walkup" );
    level.adler ai::set_behavior_attribute( "sprint", 0 );
    level thread scene::play( "scene_kgb_detonate_gas", "Walkup_Loop" );
    level flag::set( "adler_in_walkup_loop" );
    level flag::wait_till( "adler_exit_walkup_loop" );
    scene::play( "scene_kgb_detonate_gas", "Intro" );
    level thread scene::play( "scene_kgb_detonate_gas", "Intro_Loop" );
    level flag::set( "adler_at_deploy_gas_start_node" );
    level flag::wait_till( "player_at_deploy_gas_door" );
    level thread function_ba2191eb();
    level thread function_7fa2d5b9();
    level thread function_ade558b6();
    level thread savegame::checkpoint_save();
    level flag::wait_till_timeout( 12.5, "gas_deployed" );
    
    if ( level flag::get( "gas_deployed" ) )
    {
        level flag::wait_till( "player_gasmask_on" );
        scene::play( "scene_kgb_detonate_gas", "Outro" );
        adler_idle_near_inside_man_node = getnode( "adler_idle_near_inside_man_node", "targetname" );
        level.adler.fixednode = 1;
        level.adler thread spawner::go_to_node( adler_idle_near_inside_man_node );
        level.adler thread function_d32b06fc();
        level.inside_man thread function_d32b06fc();
        return;
    }
    
    player notify( #"hash_5a2a78b8d7615e79" );
    level notify( #"hash_a883de88fd6a223" );
    level notify( #"hash_398eb960e1259f24" );
    level thread hint_tutorial::function_9f427d88();
    level thread scene::play( "scene_kgb_inside_man_on_knees", "death" );
    wait 1.5;
    util::missionfailedwrapper( #"hash_7880a61f047fcad3", #"hash_7880a61f047fcad3" );
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0xf6706fe8, Offset: 0x1d30
// Size: 0x92
function function_d32b06fc()
{
    self endon( #"death" );
    self.og_maxsightdistsqrd = self.maxsightdistsqrd;
    self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
    self.maxsightdistsqrd = 1000000;
    self.newenemyreactiondistsq = 1000000;
    level flag::wait_till( "reset_gas_masked_enemy_sighting" );
    self.maxsightdistsqrd = self.og_maxsightdistsqrd;
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0x8479e848, Offset: 0x1dd0
// Size: 0x4d4
function function_7fa2d5b9()
{
    level endon( #"hash_398eb960e1259f24" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_431bb046 = getweapon( #"hash_2d162e4568b88d1b" );
    player val::set( #"detonate_gas", "disable_weapon_fire", 1 );
    player val::set( #"detonate_gas", "disable_weapon_reload", 1 );
    player val::set( #"detonate_gas", "disable_weapon_cycling", 1 );
    player val::set( #"detonate_gas", "disable_offhand_weapons", 1 );
    player val::set( #"detonate_gas", "disable_offhand_special", 1 );
    player val::set( #"detonate_gas", "allow_ads", 0 );
    wait 0.5;
    player giveweapon( var_431bb046 );
    player switchtoweapon( var_431bb046, 1 );
    player gestures::function_b6cc48ed( "ges_t9_gas_detonator", undefined, 1, 0.2, undefined, 1, 1 );
    thread namespace_353d803e::function_62f3e8ea();
    wait 2.5;
    level thread hint_tutorial::function_4c2d4fc4( #"hash_1666923bbed40ff0", undefined, undefined, undefined, 2 );
    player notifyonplayercommand( "use_gas", "+smoke" );
    player waittill( #"use_gas" );
    player stopgestureviewmodel( "ges_t9_gas_detonator" );
    level thread namespace_353d803e::function_8960f1f9();
    player notifyonplayercommandremove( "use_gas", "+smoke" );
    player playsound( "tmp_interact_button_press_a" );
    player notify( #"hash_5a2a78b8d7615e79" );
    level notify( #"hash_a883de88fd6a223" );
    level thread hint_tutorial::function_9f427d88();
    level flag::set( "gas_deployed" );
    namespace_353d803e::music( "14.0_knockout" );
    wait 2;
    thread namespace_353d803e::function_47dcb676();
    thread namespace_353d803e::evt_kgb_deploygas_gas_mask_on();
    player takeweapon( var_431bb046 );
    gasmask = getweapon( #"hash_6d1b6f0f81006bf8" );
    player giveweapon( gasmask );
    player switchtoweaponimmediate( gasmask, 1 );
    player gestures::function_b6cc48ed( "ges_t9_gasmask_on", undefined, 1, 0.2, undefined, 0, 1 );
    wait 1.8;
    player namespace_e77bf565::gasmask_on( 1 );
    level flag::set( "player_gasmask_on" );
    exploder::exploder( "gas" );
    player clientfield::set_to_player( "set_player_pbg_bank", 2 );
    wait 1.6;
    player val::reset_all( #"detonate_gas" );
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 1
// Checksum 0x21a960a4, Offset: 0x22b0
// Size: 0x54
function function_59dd75dc( *params )
{
    if ( self haspart( "J_Helmet" ) )
    {
        self attach( "c_t9_rus_gasmask_wm_01", "J_Helmet" );
    }
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 1
// Checksum 0x8b7541ac, Offset: 0x2310
// Size: 0x5c
function function_b5b663( *params )
{
    if ( self isattached( "c_t9_rus_gasmask_wm_01", "J_Helmet" ) )
    {
        self detach( "c_t9_rus_gasmask_wm_01", "J_Helmet" );
    }
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0x3cc8fd08, Offset: 0x2378
// Size: 0x144
function function_ade558b6()
{
    level endon( #"hash_a883de88fd6a223" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_ade558b6 = [];
    var_ade558b6[ var_ade558b6.size ] = "vox_cp_rkgb_05100_adlr_belldetonatethe_fc";
    var_ade558b6[ var_ade558b6.size ] = "vox_cp_rkgb_05100_adlr_setoffthegas_71";
    var_ade558b6[ var_ade558b6.size ] = "vox_cp_rkgb_05100_adlr_triggerthegasbe_a9";
    wait 10;
    i = 0;
    
    while ( true )
    {
        player thread objectives_ui::show_objectives();
        hint_tutorial::function_4c2d4fc4( #"hash_1666923bbed40ff0", undefined, undefined, undefined, 2, 10 );
        level.adler dialogue::queue( "" + var_ade558b6[ i ] );
        i++;
        
        if ( i + 1 > var_ade558b6.size )
        {
            i = 0;
        }
        
        wait 15;
    }
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0x20c86008, Offset: 0x24c8
// Size: 0xf2
function function_92d72c13()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    self function_59dd75dc();
    self.og_maxsightdistsqrd = self.maxsightdistsqrd;
    self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
    self.maxsightdistsqrd = 1000000;
    self.newenemyreactiondistsq = 1000000;
    level flag::wait_till( "reset_gas_masked_enemy_sighting" );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self.maxsightdistsqrd = self.og_maxsightdistsqrd;
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}

// Namespace namespace_12aa0683/namespace_17fbbb5
// Params 0
// Checksum 0xac4bf2f, Offset: 0x25c8
// Size: 0x94
function function_15d8d7cd()
{
    level flag::wait_till( "start_elevator_escape_intro" );
    level thread scene::play( "scene_kgb_elevator_intro" );
    wait 0.25;
    level thread scene::play( "scene_kgb_elevator_exfil_armored_guy_entry" );
    wait 0.5;
    level thread scene::play( "scene_kgb_elevator_exfil_armored_guy_entry_02" );
}

