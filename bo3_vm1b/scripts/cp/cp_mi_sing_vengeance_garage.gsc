#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/cp_mi_sing_vengeance_market;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace vengeance_garage;

// Namespace vengeance_garage
// Params 2
// Checksum 0x34a14b5c, Offset: 0xcb0
// Size: 0x332
function function_b17357cc( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        callback::on_spawned( &vengeance_util::give_hero_weapon );
        vengeance_util::init_hero( "hendricks", str_objective );
        objectives::set( "cp_level_vengeance_rescue_kane" );
        vengeance_util::function_e00864bd( "rear_garage_umbra_gate", 1, "rear_garage_gate" );
        thread vengeance_util::function_ffaf4723( "quad_tank_wall_umbra_vol", "bathroom_umbra_gate", "bathroom_gate", "noflag" );
        thread vengeance_util::function_ffaf4723( "quad_tank_wall_umbra_vol", "bathroom_ceiling_umbra_gate", "bathroom_ceiling_gate", "noflag" );
        garage_igc_scene_setup();
        scene::init( "cin_ven_06_15_parkingstructure_deadbodies" );
        scene::init( "cin_ven_06_10_parkingstructure_1st_shot01" );
        level util::set_streamer_hint( 4 );
        level.ai_hendricks battlechatter::function_d9f49fba( 0 );
        level.ai_hendricks setgoal( level.ai_hendricks.origin );
        load::function_a2995f22();
    }
    
    vengeance_util::function_4e8207e9( "garage_igc" );
    
    if ( isdefined( level.stealth ) )
    {
        level stealth::stop();
    }
    
    level thread function_9ca09589();
    level thread vengeance_market::function_3ae8447c();
    s_node = struct::get( "quad_battle_script_node", "targetname" );
    s_node thread scene::init( "cin_ven_07_11_openpath_wall_vign" );
    var_ecf5f255 = getentarray( "quad_tank_color_triggers", "script_noteworthy" );
    
    foreach ( e_trig in var_ecf5f255 )
    {
        e_trig triggerenable( 0 );
        e_trig.script_color_stay_on = 1;
    }
    
    level thread cp_mi_sing_vengeance_sound::function_34d7007d();
    level thread namespace_9fd035::function_c270e327();
    function_2636a01c();
    savegame::checkpoint_save();
    vengeance_accolades::function_2c3bbf49();
    level thread cp_mi_sing_vengeance_sound::garage_init();
    garage_main( str_objective, b_starting );
}

// Namespace vengeance_garage
// Params 4
// Checksum 0xb2f48c87, Offset: 0xff0
// Size: 0x102
function function_608352d2( str_objective, b_starting, b_direct, player )
{
    level struct::delete_script_bundle( "scene", "cin_ven_06_10_parkingstructure_1st_shot01" );
    level struct::delete_script_bundle( "scene", "cin_ven_06_10_parkingstructure_3rd_shot02" );
    level struct::delete_script_bundle( "scene", "cin_ven_06_10_parkingstructure_3rd_shot03" );
    level struct::delete_script_bundle( "scene", "cin_ven_06_10_parkingstructure_3rd_shot04" );
    level struct::delete_script_bundle( "scene", "cin_ven_06_10_parkingstructure_3rd_shot05" );
    level struct::delete_script_bundle( "scene", "cin_ven_06_10_parkingstructure_3rd_shot06" );
    level struct::delete_script_bundle( "scene", "cin_ven_06_10_parkingstructure_3rd_shot07" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xed7f491a, Offset: 0x1100
// Size: 0x27a
function function_2636a01c()
{
    level.ai_hendricks setgoal( level.ai_hendricks.origin );
    
    foreach ( e_player in level.activeplayers )
    {
        e_player thread vengeance_util::function_b9785164();
    }
    
    level thread function_fb6f8da();
    vengeance_util::function_e00864bd( "rear_garage_umbra_gate", 1, "rear_garage_gate" );
    thread vengeance_util::function_ffaf4723( "quad_tank_wall_umbra_vol", "bathroom_umbra_gate", "bathroom_gate", "noflag" );
    thread vengeance_util::function_ffaf4723( "quad_tank_wall_umbra_vol", "bathroom_ceiling_umbra_gate", "bathroom_ceiling_gate", "noflag" );
    e_door = getent( "dogleg_2_exit_door_static", "targetname" );
    e_door hide();
    
    if ( isdefined( level.bzm_vengeancedialogue6_1callback ) )
    {
        level thread [[ level.bzm_vengeancedialogue6_1callback ]]();
    }
    
    if ( !isdefined( level.var_e82cf2ee ) )
    {
        level.var_e82cf2ee = level.players[ 0 ];
    }
    
    s_anim_node = struct::get( "garage_igc_script_node", "targetname" );
    s_anim_node thread scene::play( "cin_ven_06_15_parkingstructure_deadbodies" );
    s_anim_node thread scene::play( "cin_ven_06_10_parkingstructure_1st_shot01", level.var_e82cf2ee );
    vengeance_util::co_op_teleport_on_igc_end( "cin_ven_06_10_parkingstructure_1st_shot08", "garage", 0 );
    wait 1;
    level thread vengeance_util::function_5dbf4126();
    level waittill( #"hash_b0ca54ea" );
    e_door show();
    level.ai_hendricks setgoal( level.ai_hendricks.origin, 1 );
    level flag::set( "garage_igc_done" );
    util::clear_streamer_hint();
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x212ab786, Offset: 0x1388
// Size: 0x37a
function garage_igc_scene_setup()
{
    level thread function_f0f8ed9f();
    level thread function_d933bb38();
    level.var_29061a49 = vehicle::simple_spawn_single( "garage_technical_01" );
    level.var_29061a49 vehicle::lights_off();
    level.var_4f0894b2 = vehicle::simple_spawn_single( "garage_technical_02" );
    level.var_4f0894b2.animname = "technical_truck_2";
    level.var_4f0894b2 vehicle::lights_off();
    level.var_4f0894b2 hide();
    var_6a07eb6c = [];
    var_6a07eb6c[ 0 ] = "garage_civilian_a";
    var_6a07eb6c[ 1 ] = "garage_civilian_b";
    var_6a07eb6c[ 2 ] = "garage_civilian_c";
    var_6a07eb6c[ 3 ] = "garage_civilian_female_a";
    var_6a07eb6c[ 4 ] = "garage_civilian_female_b";
    var_6a07eb6c[ 5 ] = "noose_1";
    var_6a07eb6c[ 6 ] = "noose_2";
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_1st_shot01", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_1st_shot01", &function_159c75e4, "done" );
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_3rd_shot02", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_3rd_shot03", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_3rd_shot04", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_3rd_shot05", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_3rd_shot06", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_3rd_shot07", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    scene::add_scene_func( "cin_ven_06_10_parkingstructure_1st_shot08", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    spawner::add_spawn_function_ai_group( "garage_enemies", &function_724be02d );
    a_garage_police_cars = getentarray( "garage_police_cars", "script_noteworthy" );
    
    for ( i = 0; i < a_garage_police_cars.size ; i++ )
    {
        a_garage_police_cars[ i ] thread function_2b37bfcd();
    }
    
    spawner::add_spawn_function_ai_group( "garage_police", &function_d3d4580d );
}

// Namespace vengeance_garage
// Params 1
// Checksum 0xfa56a807, Offset: 0x1710
// Size: 0x13
function function_159c75e4( a_ents )
{
    level notify( #"hash_d933bb38" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xfd00414b, Offset: 0x1730
// Size: 0x6a
function function_d933bb38()
{
    level waittill( #"hash_d933bb38" );
    wait 1;
    level.ai_hendricks setgoal( level.ai_hendricks.origin, 1 );
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_hendricks ai::set_ignoreme( 1 );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x6d60d5c6, Offset: 0x17a8
// Size: 0xb2
function function_fb6f8da()
{
    level thread function_d20f6512();
    level thread function_ac0ceaa9();
    level thread function_860a7040();
    level thread function_901bc91f();
    level thread function_6a194eb6();
    level thread function_4416d44d();
    level thread function_1e1459e4();
    level thread function_2825b2c3();
    level thread function_223385a();
    level thread function_601474c6();
    level thread function_8616ef2f();
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x4c73cec7, Offset: 0x1868
// Size: 0x32
function function_d20f6512()
{
    level waittill( #"hash_9daf57a0" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::remote( "xiu0_i_swore_vengeance_0" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x578056e6, Offset: 0x18a8
// Size: 0x3a
function function_ac0ceaa9()
{
    level waittill( #"hash_a14e508d" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::remote( "xiu0_you_built_your_walls_0", 0, "no_dni" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xd7bae836, Offset: 0x18f0
// Size: 0x3a
function function_860a7040()
{
    level waittill( #"hash_1bf8f970" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::remote( "xiu0_today_the_children_0", 0, "no_dni" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x9599decb, Offset: 0x1938
// Size: 0x3a
function function_901bc91f()
{
    level waittill( #"hash_51de5a01" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::remote( "xiu0_you_brought_this_upo_0", 0, "no_dni" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xa4f7830, Offset: 0x1980
// Size: 0x32
function function_6a194eb6()
{
    level waittill( #"hash_d03db37a" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::player_say( "plyr_goh_xiulan_how_0" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x9be0d6eb, Offset: 0x19c0
// Size: 0x3a
function function_4416d44d()
{
    level waittill( #"hash_8f6177c0" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::remote( "tayr_i_gave_her_access_to_0", 0, "no_dni" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x8c19a2b, Offset: 0x1a08
// Size: 0x3a
function function_1e1459e4()
{
    level waittill( #"hash_a60e4185" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level.ai_hendricks thread vengeance_util::function_5fbec645( "hend_taylor_what_do_you_0" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xac87ec67, Offset: 0x1a50
// Size: 0x3a
function function_2825b2c3()
{
    level waittill( #"hash_cd7ed345" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::remote( "tayr_the_decision_the_r_0", 0, "no_dni" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x78091f75, Offset: 0x1a98
// Size: 0x3a
function function_223385a()
{
    level waittill( #"hash_44d70a3" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::remote( "tayr_i_want_to_find_them_0", 0, "no_dni" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x804da678, Offset: 0x1ae0
// Size: 0x3a
function function_601474c6()
{
    level waittill( #"hash_ea9a5e57" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level.ai_hendricks thread vengeance_util::function_5fbec645( "hend_why_0" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x19d75b4c, Offset: 0x1b28
// Size: 0x3a
function function_8616ef2f()
{
    level waittill( #"hash_af6fa39" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread dialog::remote( "tayr_i_need_to_know_how_d_0", 0, "no_dni" );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x7487c652, Offset: 0x1b70
// Size: 0x72
function function_20c804af()
{
    garage_igc_scene_setup();
    s_anim_node = struct::get( "garage_igc_script_node", "targetname" );
    s_anim_node scene::skipto_end( "cin_ven_06_10_parkingstructure_1st_shot08" );
    wait 0.1;
    level flag::set( "garage_igc_done" );
}

// Namespace vengeance_garage
// Params 2
// Checksum 0x82b5bb52, Offset: 0x1bf0
// Size: 0x32a
function function_63a4033a( str_objective, b_starting )
{
    if ( b_starting )
    {
        callback::on_spawned( &vengeance_util::give_hero_weapon );
        callback::on_spawned( &vengeance_util::function_b9785164 );
        vengeance_util::init_hero( "hendricks", str_objective );
        level.ai_hendricks battlechatter::function_d9f49fba( 0 );
        objectives::set( "cp_level_vengeance_rescue_kane" );
        level thread vengeance_market::function_3ae8447c();
        vengeance_util::function_e00864bd( "rear_garage_umbra_gate", 1, "rear_garage_gate" );
        thread vengeance_util::function_ffaf4723( "quad_tank_wall_umbra_vol", "bathroom_umbra_gate", "bathroom_gate", "noflag" );
        thread vengeance_util::function_ffaf4723( "quad_tank_wall_umbra_vol", "bathroom_ceiling_umbra_gate", "bathroom_ceiling_gate", "noflag" );
        level thread function_f0f8ed9f();
        level thread vengeance_util::function_5dbf4126();
        level thread function_9ca09589();
        s_node = struct::get( "quad_battle_script_node", "targetname" );
        s_node thread scene::init( "cin_ven_07_11_openpath_wall_vign" );
        var_ecf5f255 = getentarray( "quad_tank_color_triggers", "script_noteworthy" );
        
        foreach ( e_trig in var_ecf5f255 )
        {
            e_trig triggerenable( 0 );
            e_trig.script_color_stay_on = 1;
        }
        
        level function_20c804af();
        level.var_29061a49 = vehicle::simple_spawn_single( "garage_technical_01" );
        level.var_29061a49 vehicle::lights_off();
        level.var_4f0894b2 = vehicle::simple_spawn_single( "garage_technical_02" );
        level.var_4f0894b2 vehicle::lights_off();
        level.var_4f0894b2 hide();
        level.var_4f0894b2 notsolid();
        level flag::wait_till( "all_players_spawned" );
    }
    
    vengeance_accolades::function_2c3bbf49();
    level thread cp_mi_sing_vengeance_sound::garage_init();
    garage_main( str_objective, b_starting );
}

// Namespace vengeance_garage
// Params 4
// Checksum 0x716e1a64, Offset: 0x1f28
// Size: 0x22
function function_a55eff44( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace vengeance_garage
// Params 2
// Checksum 0xe249e3f0, Offset: 0x1f58
// Size: 0x16a
function garage_main( str_objective, b_starting )
{
    level.ai_hendricks thread garage_hendricks();
    level thread garage_enemies();
    level thread garage_police();
    level thread function_c3851a97();
    level thread function_5d001b91();
    level thread function_8d0e1d4c();
    level thread function_65592384();
    var_77d44b28 = getent( "garage_player_gather_trigger", "targetname" );
    var_77d44b28 triggerenable( 0 );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        level waittill( #"garage_enemies_dead" );
    }
    else
    {
        level util::waittill_multiple( "garage_snipers_dead", "garage_enemies_dead" );
    }
    
    if ( str_objective == "garage_igc" )
    {
        skipto::objective_completed( "garage_igc" );
    }
    else
    {
        skipto::objective_completed( "dev_garage" );
    }
    
    objectives::hide( "cp_level_vengeance_clear_garage" );
    vengeance_accolades::function_f766f1e0();
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xa559814f, Offset: 0x20d0
// Size: 0xf2
function garage_hendricks()
{
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.goalradius = 16;
    self setthreatbiasgroup( "garage_hendricks" );
    e_node = getnode( "hendricks_garage_start_node", "targetname" );
    self setgoal( e_node, 1 );
    self waittill( #"goal" );
    level flag::wait_till( "start_obj_technicals" );
    self colors::enable();
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    wait 0.05;
    trigger::use( "hendricks_sniper_color" );
}

// Namespace vengeance_garage
// Params 1
// Checksum 0x95c641e6, Offset: 0x21d0
// Size: 0x102
function function_f0f8ed9f( b_starting )
{
    createthreatbiasgroup( "garage_police" );
    createthreatbiasgroup( "garage_snipers" );
    createthreatbiasgroup( "garage_hendricks" );
    createthreatbiasgroup( "garage_players" );
    createthreatbiasgroup( "garage_ground" );
    
    if ( !isdefined( b_starting ) )
    {
        level flag::wait_till( "start_obj_technicals" );
    }
    
    setthreatbias( "garage_hendricks", "garage_snipers", 10 );
    setthreatbias( "garage_hendricks", "garage_ground", 10 );
    setthreatbias( "garage_police", "garage_snipers", 10000 );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xdb59c29, Offset: 0x22e0
// Size: 0x253
function garage_enemies()
{
    spawner::simple_spawn( "garage_snipers", &setup_sniper );
    spawner::simple_spawn( "garage_ground_enemies", &function_724be02d );
    level thread function_c0e699ed();
    wait 1;
    spawn_manager::enable( "garage_lower_sm" );
    spawn_manager::wait_till_ai_remaining( "garage_lower_sm", 3 );
    var_5171fbdf = spawner::get_ai_group_ai( "garage_enemies" );
    
    if ( var_5171fbdf.size > 0 )
    {
        foreach ( var_11b61923 in var_5171fbdf )
        {
            if ( isalive( var_11b61923 ) )
            {
                var_11b61923 thread vengeance_market::function_47370bbe();
            }
        }
    }
    
    a_enemies = spawner::get_ai_group_ai( "garage_enemies" );
    e_vol = getent( "garage_enemies_final_volume", "targetname" );
    
    foreach ( e_enemy in a_enemies )
    {
        if ( isalive( e_enemy ) )
        {
            e_enemy ai::set_behavior_attribute( "move_mode", "rambo" );
            e_enemy clearforcedgoal();
            e_enemy cleargoalvolume();
            e_enemy setgoal( e_vol, 1 );
        }
    }
    
    spawn_manager::wait_till_cleared( "garage_lower_sm" );
    level notify( #"garage_enemies_dead" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xaad0c65d, Offset: 0x2540
// Size: 0x72
function function_724be02d()
{
    self endon( #"death" );
    self.goalradius = 32;
    self setthreatbiasgroup( "garage_ground" );
    e_vol = getent( "garage_enemy_n_goalvolume", "targetname" );
    
    if ( !isdefined( self.target ) )
    {
        self setgoal( e_vol, 1 );
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x882d4f82, Offset: 0x25c0
// Size: 0x12b
function function_c0e699ed()
{
    spawner::waittill_ai_group_amount_killed( "garage_snipers", 1 );
    spawner::simple_spawn( "garage_snipers_reinforcements_1", &setup_sniper );
    spawner::waittill_ai_group_amount_killed( "garage_snipers", 3 );
    spawner::simple_spawn( "garage_snipers_reinforcements_2", &setup_sniper );
    spawner::waittill_ai_group_amount_killed( "garage_snipers", 1 );
    spawn_manager::enable( "garage_snipers_reinforcements_extra" );
    level thread spawn_manager::run_func_when_cleared( "garage_snipers_reinforcements_extra", &garage_extra_snipers_cleared );
    wait 0.1;
    level thread garage_main_snipers_cleared();
    level flag::wait_till_all( array( "garage_main_snipers_cleared", "garage_extra_snipers_cleared" ) );
    level notify( #"garage_snipers_dead" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xf60e894, Offset: 0x26f8
// Size: 0x32
function garage_main_snipers_cleared()
{
    spawner::waittill_ai_group_ai_count( "garage_snipers", 0 );
    level flag::set( "garage_main_snipers_cleared" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xeb734168, Offset: 0x2738
// Size: 0x1a
function garage_extra_snipers_cleared()
{
    level flag::set( "garage_extra_snipers_cleared" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x1e09fd49, Offset: 0x2760
// Size: 0xca
function setup_sniper()
{
    self endon( #"death" );
    self.goalradius = 8;
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.script_accuracy = 3.5;
    self setthreatbiasgroup( "garage_snipers" );
    self disableaimassist();
    self.overrideactordamage = &function_c95d9be1;
    self waittill( #"goal" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self.avoid_cover = 1;
    self function_dc89c930();
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xe8a2930c, Offset: 0x2838
// Size: 0x79
function function_dc89c930()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isplayer( self.enemy ) )
        {
            if ( self.enemy isinvehicle() )
            {
                self ai::shoot_at_target( "normal", self.enemy, "j_head", 3 );
                wait 5;
            }
        }
        
        wait 0.05;
    }
}

// Namespace vengeance_garage
// Params 12
// Checksum 0xcdf6cffd, Offset: 0x28c0
// Size: 0x83
function function_c95d9be1( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename )
{
    if ( isdefined( eattacker ) && !isplayer( eattacker ) )
    {
        idamage = 0;
    }
    
    return idamage;
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xf1378067, Offset: 0x2950
// Size: 0x72
function garage_police()
{
    level.police = spawner::simple_spawn( "garage_police" );
    wait 0.1;
    setthreatbias( "garage_snipers", "garage_police", 100000 );
    setthreatbias( "garage_ground", "garage_police", 10 );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x97787c07, Offset: 0x29d0
// Size: 0x2a
function function_d3d4580d()
{
    self.goalradius = 8;
    self.fixednode = 1;
    self setthreatbiasgroup( "garage_police" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x9060c5d7, Offset: 0x2a08
// Size: 0x7a
function function_2b37bfcd()
{
    self.old_origin = self.origin;
    self.old_angles = self.angles;
    level flag::wait_till( "garage_igc_done" );
    self.origin = self.old_origin;
    self.angles = self.old_angles;
    
    if ( self.targetname == "cop_car_2" )
    {
        self kill();
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x39e8da14, Offset: 0x2a90
// Size: 0x13b
function function_5d001b91()
{
    level endon( #"garage_snipers_dead" );
    level.var_4f0894b2 show();
    wait 0.75;
    level.var_4f0894b2 solid();
    level flag::wait_till( "start_obj_technicals" );
    objectives::set( "cp_level_vengeance_clear_garage" );
    
    foreach ( e_player in level.activeplayers )
    {
        e_player thread function_a28bf30a( level.var_29061a49, "technical_01_entered" );
        e_player thread function_a28bf30a( level.var_4f0894b2, "technical_02_entered" );
    }
    
    level flag::wait_till_any( array( "technical_01_entered", "technical_02_entered" ) );
    level notify( #"hash_ede342ab" );
}

// Namespace vengeance_garage
// Params 2
// Checksum 0xd0edcc85, Offset: 0x2bd8
// Size: 0xd3
function function_a28bf30a( technical, flag )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    technical endon( #"death" );
    vehicle = undefined;
    var_f1709cab = 0;
    
    if ( self isinvehicle() )
    {
        vehicle = self getvehicleoccupied();
        
        if ( isdefined( vehicle ) && vehicle == technical )
        {
            var_f1709cab = 1;
        }
    }
    
    if ( var_f1709cab == 1 )
    {
        level flag::set( flag );
    }
    else
    {
        technical waittill( #"enter_vehicle", player, seat );
        level flag::set( flag );
    }
    
    level notify( #"technical_used" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x4dc7c445, Offset: 0x2cb8
// Size: 0x52
function function_8d0e1d4c()
{
    level thread function_66454e44();
    util::waittill_any( "sniper_killed", "technical_used" );
    level waittill( #"garage_snipers_dead" );
    level flag::set( "kill_sniper_nags" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x1c6c287e, Offset: 0x2d18
// Size: 0x23
function function_66454e44()
{
    spawner::waittill_ai_group_amount_killed( "garage_snipers", 1 );
    level notify( #"sniper_killed" );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x5a6819b1, Offset: 0x2d48
// Size: 0x9b
function function_9ca09589()
{
    var_ab57d34a = getentarray( "garage_balcony_damage", "script_noteworthy" );
    
    foreach ( e_damage in var_ab57d34a )
    {
        e_damage hide();
        e_damage notsolid();
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x70d556f3, Offset: 0x2df0
// Size: 0x8b
function function_c3851a97()
{
    a_triggers = getentarray( "garage_damage_trigger", "targetname" );
    
    foreach ( e_trigger in a_triggers )
    {
        e_trigger thread garage_damage_trigger();
    }
}

// Namespace vengeance_garage
// Params 0
// Checksum 0x2e32ea0, Offset: 0x2e88
// Size: 0x29a
function garage_damage_trigger()
{
    e_org = spawn( "script_origin", self.origin + ( 0, 0, 64 ) );
    e_wall = getent( self.target, "targetname" );
    var_83442ffa = getentarray( self.script_noteworthy, "targetname" );
    var_7d044b82 = struct::get( e_wall.target, "targetname" );
    self waittill( #"trigger", e_other );
    playsoundatposition( "evt_garage_debris", self.origin );
    exploder::exploder( self.script_noteworthy );
    
    foreach ( e_damage in var_83442ffa )
    {
        e_damage show();
        e_damage solid();
    }
    
    level util::clientnotify( self.script_noteworthy );
    
    if ( math::cointoss() )
    {
        a_enemies = spawner::get_ai_group_ai( "garage_snipers" );
        
        foreach ( e_enemy in a_enemies )
        {
            if ( isalive( e_enemy ) && distance2d( var_7d044b82.origin, e_enemy.origin ) < 100 )
            {
                e_enemy thread throw_on_death( var_7d044b82 );
            }
        }
    }
    else
    {
        radiusdamage( e_org.origin, 100, 500, 500, e_other );
    }
    
    e_wall notsolid();
    e_wall delete();
    e_org delete();
}

// Namespace vengeance_garage
// Params 1
// Checksum 0x7ef8412a, Offset: 0x3130
// Size: 0xa2
function throw_on_death( struct )
{
    v_dir = anglestoforward( struct.angles ) + anglestoup( struct.angles ) * 0.5;
    v_dir *= 40;
    self.skipdeath = 1;
    self startragdoll();
    self launchragdoll( ( v_dir[ 0 ], v_dir[ 1 ], v_dir[ 2 ] + 32 ) );
    self kill();
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xd62a9b00, Offset: 0x31e0
// Size: 0xf2
function function_65592384()
{
    level flag::set( "start_obj_technicals" );
    
    foreach ( e_player in level.activeplayers )
    {
        if ( e_player isinvehicle() )
        {
            level flag::set( "in_veh_before_vo" );
        }
    }
    
    level thread function_1fab88a();
    
    if ( !level flag::get( "in_veh_before_vo" ) )
    {
        level.ai_hendricks function_73a79ca0( "hend_we_re_not_going_to_l_0", 6 );
    }
    
    level.ai_hendricks battlechatter::function_d9f49fba( 1 );
}

// Namespace vengeance_garage
// Params 0
// Checksum 0xd272d64a, Offset: 0x32e0
// Size: 0x72
function function_1fab88a()
{
    level waittill( #"garage_snipers_dead" );
    a_enemies = spawner::get_ai_group_ai( "garage_enemies" );
    
    if ( a_enemies.size > 0 )
    {
        level.ai_hendricks notify( #"hash_6f33cd57" );
        level.ai_hendricks.var_5d9fbd2d = 0;
        level.ai_hendricks function_73a79ca0( "hend_let_s_clear_out_the_0" );
    }
}

// Namespace vengeance_garage
// Params 2
// Checksum 0x5763a4e6, Offset: 0x3360
// Size: 0xa2
function function_73a79ca0( vo_line, n_delay )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0;
    }
    
    self endon( #"hash_6f33cd57" );
    self battlechatter::function_d9f49fba( 0 );
    
    if ( !isdefined( self.var_5d9fbd2d ) || self.var_5d9fbd2d == 0 )
    {
        self.var_5d9fbd2d = 1;
    }
    else
    {
        while ( self.var_5d9fbd2d == 1 )
        {
            wait 2.5;
        }
    }
    
    self vengeance_util::function_5fbec645( vo_line, n_delay );
    self battlechatter::function_d9f49fba( 1 );
    self.var_5d9fbd2d = 0;
}

