#using script_2cd384a0f7be5baf;
#using script_3dc93ca9902a9cda;
#using script_58524f08c3081cbb;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using script_8b6f2185feb33ac;
#using script_c36b776c6718540;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\event;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_73841f48;

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 2
// Checksum 0x3f3a0b86, Offset: 0xb88
// Size: 0x294
function function_599d30fb( *str_objective, var_50cc0d4f )
{
    objectives::complete( "obj_yamantau_1" );
    level thread objectives::scripted( "obj_yamantau_2", undefined, #"hash_282aa5eed264a248" );
    level thread namespace_7468806b::function_ac37051f();
    level thread function_bb3bfb17();
    level thread namespace_8a404420::function_876b3ae7();
    savegame::function_7790f03( 1 );
    
    if ( !namespace_b73b9191::function_315b14d6() )
    {
        level flag::set( "flg_bunker_crossbow_bolt_interacts_active" );
        namespace_b73b9191::function_6f1012dd( "bunker" );
    }
    
    level thread function_c5b389f1();
    var_1e11c2d3 = spawner::get_ai_group_ai( "zipline_helipad_enemies" );
    function_1eaaceab( var_1e11c2d3 );
    
    if ( var_50cc0d4f )
    {
        var_6b6b52d6 = spawner::simple_spawn( "sp_catwalk_helipad" );
    }
    
    level flag::wait_till( "flg_bunker_explore_flashlight_hint" );
    var_27fe3d30 = spawner::get_ai_group_ai( "zipline_helipad_enemies" );
    
    if ( var_27fe3d30.size > 0 )
    {
        foreach ( ai in var_27fe3d30 )
        {
            ai thread util::delayed_delete( 0.1 );
        }
    }
    
    level flag::wait_till( "flg_bunker_explore_encounter_start" );
    savegame::checkpoint_save( 1 );
    skipto::function_4e3ab877( "bunker_explore" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x1b0a1bbf, Offset: 0xe28
// Size: 0x44
function function_c5b389f1()
{
    level flag::wait_till( "flg_bunker_explore_entered" );
    level namespace_5d7a2dac::music( "6.0_tunnel" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x4ed7aa18, Offset: 0xe78
// Size: 0x9c
function function_4c079a93()
{
    level flag::wait_till( "flg_bunker_explore_stairwell_tease" );
    ai = spawner::simple_spawn_single( "sp_bunker_explore_elevator", &function_4e376bb9, "flg_bunker_encounter_end" );
    ai val::set( "stairwell", "ignoreall", 1 );
    ai thread namespace_7468806b::function_1bf4e6d0();
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0xe0eaf5fe, Offset: 0xf20
// Size: 0xa4
function function_bb3bfb17()
{
    level flag::wait_till( "flg_bunker_explore_elevator_creak" );
    namespace_b73b9191::function_15426f9d( "cull_outside_bunkerint" );
    exploder::exploder( "elev_dust_fall" );
    snd::play( "evt_yam_elevator_shift_lr", level.player );
    earthquake( 0.3, 1, level.player.origin, 150 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0x14c0e6d3, Offset: 0xfd0
// Size: 0x7c
function function_b2e9a7bb( weapon )
{
    self endon( #"death" );
    
    while ( self getweaponammoclip( weapon ) <= 0 && self getweaponammostock( weapon ) <= 0 )
    {
        waitframe( 1 );
    }
    
    self setlowready( 0 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0x4816ef3, Offset: 0x1058
// Size: 0x74
function function_c3ccbcc8( *str_objective )
{
    namespace_b73b9191::function_2683ec5d();
    var_b4bb921 = struct::get( "woods_bunker_explore", "targetname" );
    level.ai_woods forceteleport( var_b4bb921.origin, var_b4bb921.angles );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 4
// Checksum 0xeeb0275b, Offset: 0x10d8
// Size: 0x2a
function function_f46b6ef( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    waitframe( 1 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 2
// Checksum 0x275df31, Offset: 0x1110
// Size: 0x2fc
function function_eea0086d( *str_objective, *var_50cc0d4f )
{
    if ( isalive( level.ai_woods ) )
    {
        level.ai_woods delete();
    }
    
    var_c41d0234 = [];
    
    if ( !isdefined( var_c41d0234 ) )
    {
        var_c41d0234 = [];
    }
    else if ( !isarray( var_c41d0234 ) )
    {
        var_c41d0234 = array( var_c41d0234 );
    }
    
    var_c41d0234[ var_c41d0234.size ] = "flg_bunker_encounter_patrol_cleared";
    
    if ( !isdefined( var_c41d0234 ) )
    {
        var_c41d0234 = [];
    }
    else if ( !isarray( var_c41d0234 ) )
    {
        var_c41d0234 = array( var_c41d0234 );
    }
    
    var_c41d0234[ var_c41d0234.size ] = "flg_bunker_encounter_end";
    function_931a2938();
    level thread namespace_b73b9191::function_e79ede39( "flg_bunker_encounter_end" );
    level thread function_228e46b7();
    level thread function_10bdb4ab();
    level thread function_fd54f0f2();
    level thread function_d9018071();
    level thread function_e6316fa2();
    
    if ( !namespace_b73b9191::function_315b14d6() && !level flag::get( "flg_bunker_crossbow_bolt_interacts_active" ) )
    {
        namespace_b73b9191::function_6f1012dd( "bunker" );
    }
    
    level flag::wait_till( "flg_bunker_encounter_flashlight_tip" );
    savegame::checkpoint_save( 1 );
    level flag::wait_till( "flg_bunker_explore_encounter_arrive" );
    namespace_b73b9191::function_ee83e03a( "cull_outside_bunkerint" );
    level thread namespace_7468806b::function_4acd5495();
    level flag::wait_till( "flg_woods_regroup_callover_start" );
    level flag::set( "flg_bunker_encounter_end" );
    savegame::checkpoint_save( 1 );
    skipto::function_4e3ab877( "bunker_encounter" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x70ec168e, Offset: 0x1418
// Size: 0x54
function function_e6316fa2()
{
    level endon( #"flg_bunker_encounter_patrol_cleared" );
    level flag::wait_till( "flg_bunker_stealth_fail" );
    level namespace_5d7a2dac::music( "7.0_combat_3" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0xf84185d7, Offset: 0x1478
// Size: 0x4c
function function_8232a129()
{
    level flag::wait_till( "flg_bunker_encounter_patrol_cleared" );
    wait 3;
    level thread breadcrumb::function_61037c6c( #"hash_6191b396f75dbc49" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x10e5e26f, Offset: 0x14d0
// Size: 0x1b8
function function_228e46b7()
{
    var_37a49506 = spawner::simple_spawn( "sp_bunker_encounter_scavenger", &function_4e376bb9, "flg_bunker_encounter_end" );
    
    if ( level flag::get( "flg_bunker_stealth_fail" ) )
    {
        stealth_event::event_broadcast_generic( "explode", level.player.origin, 1500, level.player );
    }
    
    level flag::wait_till( "flg_bunker_explore_scavenger_move" );
    
    if ( !level flag::get( "flg_bunker_stealth_fail" ) )
    {
        level thread namespace_7468806b::function_d87fc317( var_37a49506[ 0 ], var_37a49506[ 1 ] );
    }
    
    level flag::wait_till( "flg_bunker_optional_key_found" );
    
    foreach ( ai in var_37a49506 )
    {
        if ( isalive( ai ) )
        {
            ai deletedelay();
        }
    }
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x191685c6, Offset: 0x1690
// Size: 0x3c
function function_10bdb4ab()
{
    level endon( #"flg_bunker_encounter_patrol_cleared" );
    level callback::on_weapon_fired( &function_50532818 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0xa272a8e8, Offset: 0x16d8
// Size: 0x4c
function function_50532818( *s_event )
{
    level flag::set( "flg_bunker_stealth_fail" );
    self callback::remove_on_weapon_fired( &function_50532818 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x65d9890b, Offset: 0x1730
// Size: 0x5c
function function_9137290b()
{
    level endon( #"flg_bunker_stealth_fail" );
    self endon( #"death" );
    self waittill( #"shoot" );
    level flag::set( "flg_bunker_stealth_fail" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x5510695b, Offset: 0x1798
// Size: 0xbc
function function_d9018071()
{
    level.player clientfield::set_to_player( "optional_objective_camera_fx", 0 );
    level thread scene::init( "scene_p8_weapon_locker_01_interact" );
    level thread function_d38043e4();
    level thread function_fc5823d5();
    level thread function_cb78f179();
    level flag::wait_till( "flg_bunker_optional_key_found" );
    thread function_9fd55cd1();
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x289ea666, Offset: 0x1860
// Size: 0xf4
function function_d38043e4()
{
    level endon( #"flg_bunker_optional_objective_completed" );
    level flag::wait_till( "flg_bunker_optional_obj_hint" );
    
    if ( !level flag::get( "flg_bunker_optional_key_found" ) )
    {
        objectives::scripted( #"hash_7c39160a497ca2e8", undefined, #"hash_2086d9cec982e919" );
        objectives::function_572778b9( #"hash_7c39160a497ca2e8" );
        level notify( #"hash_7e64e93d8fd00029" );
        
        if ( !level flag::get( "flg_bunker_optional_safe_found" ) )
        {
            level flag::set( "flg_bunker_optional_safe_found" );
        }
    }
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x67e2196e, Offset: 0x1960
// Size: 0x4cc
function function_fc5823d5()
{
    e_player = level.player;
    s_bunker_bonus_weapon = struct::get( "s_bunker_bonus_weapon", "targetname" );
    s_bunker_bonus_weapon.var_589053fc = 1;
    s_bunker_bonus_weapon util::create_cursor_hint( undefined, undefined, #"hash_17c01a9047648148", undefined, 1, &function_a0186be6, undefined, 1280, undefined, undefined, undefined, 0 );
    flag::wait_till( "flg_bunker_optional_key_found" );
    waitframe( 1 );
    s_bunker_bonus_weapon util::remove_cursor_hint();
    waitframe( 1 );
    s_bunker_bonus_weapon util::create_cursor_hint( undefined, undefined, #"hash_17c01a9047648148", undefined, 1, undefined, undefined, 1280 );
    s_bunker_bonus_weapon waittill( #"trigger" );
    level thread scene::play( "scene_p8_weapon_locker_01_interact" );
    s_bunker_bonus_weapon util::remove_cursor_hint();
    level flag::set( "flg_bunker_optional_objective_completed" );
    s_bunker_bonus_weapon.origin = s_bunker_bonus_weapon.origin;
    level thread namespace_7468806b::function_fc9043bb();
    objectives::complete( #"hash_40c6b4ca8deece21" );
    objectives::complete( #"hash_7b814bc685d7ca4" );
    s_bunker_bonus_weapon util::create_cursor_hint( undefined, undefined, #"hash_68f0a6648d0db4d1", undefined, 1, undefined, undefined, 400, undefined, undefined, 1 );
    s_bunker_bonus_weapon waittill( #"trigger" );
    s_bunker_bonus_weapon util::remove_cursor_hint();
    e_player thread namespace_b73b9191::function_d7ce9e77();
    var_64552073 = e_player getweaponslistprimaries();
    
    if ( var_64552073.size > 1 )
    {
        w_current = e_player getcurrentweapon();
        
        if ( !isdefined( w_current ) || !isdefined( w_current.inventorytype ) || w_current.inventorytype != "primary" )
        {
            w_current = var_64552073[ 0 ];
        }
        
        e_player dropitem( w_current, "tag_weapon_right" );
        waitframe( 1 );
    }
    
    var_cd8eef02 = getent( s_bunker_bonus_weapon.target, "targetname" );
    var_cd8eef02 delete();
    var_9eea9288 = getweapon( #"hash_165cf52ce418f5a1" );
    e_player giveweapon( var_9eea9288 );
    waitframe( 1 );
    e_player givemaxammo( var_9eea9288 );
    e_player switchtoweapon( var_9eea9288 );
    var_d4027fe0 = spawner::get_ai_group_sentient_count( "bunker_flashlight_patrol" );
    
    if ( var_d4027fe0 <= 0 )
    {
        e_trigger = getent( "bunker_return_dialog", "targetname" );
        e_trigger waittill( #"trigger" );
        a_ai = spawner::simple_spawn( "sp_bow_reinforcements", &function_4e376bb9, "flg_woods_regroup_woods_exiting" );
        doors::unlock( "bunker_situation_door", "targetname", 1 );
        a_ai[ 0 ] thread namespace_7468806b::function_20b65fc7();
    }
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0x39e7ad46, Offset: 0x1e38
// Size: 0x5e
function function_a0186be6( *s_info )
{
    snd::play( "evt_locker_locked", self );
    
    if ( is_true( self.var_589053fc ) )
    {
        level thread namespace_7468806b::function_aa09d92b();
        self.var_589053fc = 0;
    }
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x4fda1619, Offset: 0x1ea0
// Size: 0x21c
function function_cb78f179()
{
    e_bunker_optional_key = getent( "e_bunker_optional_key", "targetname" );
    s_bunker_optional_key_interact = struct::get( "s_bunker_optional_key_interact", "targetname" );
    s_bunker_optional_key_interact util::create_cursor_hint( undefined, undefined, #"hash_44460a497a8e27e4", 32, undefined, undefined, undefined, 32 );
    s_bunker_optional_key_interact waittill( #"trigger" );
    snd::play( "evt_yam_key_pickup", level.player );
    e_bunker_optional_key delete();
    level flag::set( "flg_bunker_optional_key_found" );
    
    if ( !level flag::get( "flg_bunker_optional_safe_found" ) )
    {
        objectives::scripted( #"hash_7b814bc685d7ca4", undefined, #"hash_18aacf4c2fd65f83" );
        objectives::function_572778b9( #"hash_7b814bc685d7ca4" );
        level thread namespace_7468806b::function_c21ee7c3();
        return;
    }
    
    objectives::complete( #"hash_7c39160a497ca2e8" );
    wait 0.5;
    objectives::scripted( #"hash_40c6b4ca8deece21", undefined, #"hash_68d32b65121ad78f" );
    objectives::function_572778b9( #"hash_40c6b4ca8deece21" );
    level thread namespace_7468806b::function_e9a2030c();
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0xc9b501f4, Offset: 0x20c8
// Size: 0xbc
function function_9fd55cd1()
{
    spawner::add_spawn_function_group( "sp_bunker_optional", "script_noteworthy", &function_4e376bb9, "flg_bunker_survey_interacted" );
    level flag::wait_till( "flg_bunker_optional_encounter_alert" );
    var_f01bc0fc = spawner::simple_spawn_single( "sp_bunker_optional_window" );
    var_f507e604 = spawner::simple_spawn_single( "sp_bunker_optional_safe" );
    level thread namespace_7468806b::function_9cfeeedb( var_f01bc0fc, var_f507e604 );
}

/#

    // Namespace namespace_73841f48/namespace_1d4ee4f8
    // Params 0
    // Checksum 0xb78f8c80, Offset: 0x2190
    // Size: 0x78, Type: dev
    function function_99854e6c()
    {
        e_bunker_optional_key = getent( "<dev string:x38>", "<dev string:x51>" );
        
        if ( isdefined( e_bunker_optional_key ) )
        {
            s_bunker_optional_key_interact = struct::get( "<dev string:x5f>", "<dev string:x51>" );
            s_bunker_optional_key_interact notify( #"trigger" );
        }
    }

    // Namespace namespace_73841f48/namespace_1d4ee4f8
    // Params 0
    // Checksum 0x20f3fda9, Offset: 0x2210
    // Size: 0x98, Type: dev
    function function_c54b46bc()
    {
        if ( !level flag::get( "<dev string:x81>" ) )
        {
            function_99854e6c();
            wait 1;
        }
        
        if ( !level flag::get( "<dev string:xa2>" ) )
        {
            s_bunker_bonus_weapon = struct::get( "<dev string:xcd>", "<dev string:x51>" );
            s_bunker_bonus_weapon notify( #"trigger" );
        }
    }

#/

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0xbbf0642e, Offset: 0x22b0
// Size: 0xec
function function_931a2938()
{
    level flag::set( "flg_bunker_stealth_overrides" );
    var_5d14e11e = [];
    var_5d14e11e[ #"prone" ] = 200;
    var_5d14e11e[ #"crouch" ] = 400;
    var_5d14e11e[ #"stand" ] = 750;
    var_8293536e = [];
    var_8293536e[ #"prone" ] = 8192;
    var_8293536e[ #"crouch" ] = 8192;
    var_8293536e[ #"stand" ] = 8192;
    namespace_979752dc::set_detect_ranges( var_5d14e11e, var_8293536e );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x66701d69, Offset: 0x23a8
// Size: 0x2ac
function function_fd54f0f2()
{
    level endon( #"flg_bunker_encounter_end" );
    level flag::wait_till( "flg_bunker_encounter_scout_spawn" );
    var_48cc222e = spawner::simple_spawn( "sp_flashlight_patrol_scout", &function_4e376bb9, "flg_bunker_encounter_end" );
    
    if ( level flag::get( "flg_bunker_stealth_fail" ) )
    {
        stealth_event::event_broadcast_generic( "explode", level.player.origin, 1500, level.player );
    }
    
    level flag::wait_till( "flg_bunker_encounter_flashlight_tip" );
    
    if ( !level flag::get( "flg_bunker_stealth_fail" ) )
    {
        var_48cc222e[ 0 ] thread namespace_7468806b::function_ca0f56e7();
    }
    
    level flag::wait_till( "flg_bunker_explore_encounter_arrive" );
    level.var_5ceb0850 = spawner::simple_spawn( "sp_flashlight_patrol", &function_4e376bb9, "flg_bunker_encounter_end" );
    level.var_20529448 = spawner::simple_spawn( "sp_flashlight_patrol_key", &function_4e376bb9, "flg_bunker_encounter_end" );
    
    if ( level flag::get( "flg_bunker_stealth_fail" ) )
    {
        var_f97a8179 = spawner::simple_spawn( "sp_flashlight_patrol_backup", &function_4e376bb9, "flg_bunker_encounter_end" );
        stealth_event::event_broadcast_generic( "explode", level.player.origin, 1500, level.player );
    }
    
    level thread namespace_7468806b::function_2712fa2e();
    spawner::waittill_ai_group_ai_count( "bunker_flashlight_patrol", 0 );
    level flag::set( "flg_bunker_encounter_patrol_cleared" );
    level namespace_5d7a2dac::music( "8.0_ireadyou", 3 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0x6e1dfae7, Offset: 0x2660
// Size: 0x184
function function_4e376bb9( flg_cleanup )
{
    self endon( #"death" );
    self ai::poi_enable( 1 );
    self thread function_9137290b();
    self namespace_979752dc::function_bf1fb16f();
    self.grenadeammo = 0;
    self.script_accuracy = 500;
    self thread function_3a9ba510( flg_cleanup );
    self.stealth.corpse_nexttime = 2147483647;
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    self.flashlightoverride = 1;
    self clientfield::set( "set_flashlight_fx", 1 );
    self util::delay( 0.2, "death", &flashlight::function_7c2f623b );
    self.var_1c936867 = 600;
    self waittill( #"stealth_combat", #"takedown_begin" );
    self ai::poi_enable( 0 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0x1e5b4340, Offset: 0x27f0
// Size: 0x54
function function_3a9ba510( flg_cleanup )
{
    self endon( #"death" );
    level flag::wait_till( flg_cleanup );
    self delete();
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0xc70480fd, Offset: 0x2850
// Size: 0x4c
function function_b47dd82e( *str_objective )
{
    objectives::complete( "obj_yamantau_1" );
    level thread objectives::scripted( "obj_yamantau_2", undefined, #"hash_282aa5eed264a248" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 4
// Checksum 0x5a13fdb9, Offset: 0x28a8
// Size: 0x8c
function function_511f3559( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( !namespace_b73b9191::function_315b14d6() )
    {
        level flag::clear( "flg_bunker_crossbow_bolt_interacts_active" );
        namespace_b73b9191::function_2e5072b5( "bunker" );
    }
    
    waitframe( 1 );
    namespace_b73b9191::function_ee83e03a( "cull_outside_bunkerint" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 2
// Checksum 0x36da83bb, Offset: 0x2940
// Size: 0x48c
function function_4e75b98e( *str_objective, *var_50cc0d4f )
{
    namespace_b73b9191::function_2683ec5d();
    var_a874ccde = struct::get( "woods_ladder_teleport", "targetname" );
    level.ai_woods forceteleport( var_a874ccde.origin, var_a874ccde.angles );
    scene::add_scene_func( "scene_yam_6010_grp_enter_react_dead_soldiers", &function_61ce8bd0 );
    level thread scene::play( "scene_yam_6010_grp_enter_react_dead_soldiers" );
    level thread namespace_9e8d4ac3::function_8cf4172f();
    level thread namespace_8a404420::function_94b72d13();
    level thread function_471879c2();
    level thread function_90350d0d();
    level flag::wait_till( "flg_woods_regroup_woods_exiting" );
    level namespace_5d7a2dac::music( "9.0_reunited" );
    level thread function_8dc5efb();
    var_b9e9c95f = getnode( "woods_office_enter", "targetname" );
    level.ai_woods setgoal( var_b9e9c95f );
    level flag::wait_till( "flg_bunker_office_approach" );
    level thread namespace_7468806b::function_1363110();
    level thread namespace_8a404420::function_2468cb92();
    level flag::wait_till( "flg_bunker_office_woods_anim_start" );
    level thread function_89f8f4f8();
    level.ai_woods function_9ae1c50();
    level thread namespace_8a404420::scene_yam_6010_grp_enter_react();
    namespace_b73b9191::function_ee83e03a( "cull_inside_finale" );
    namespace_b73b9191::function_ee83e03a( "cull_inside_excavation" );
    namespace_b73b9191::function_15426f9d( "cull_inside_bunkerext" );
    namespace_b73b9191::function_15426f9d( "cull_inside_satcom" );
    level flag::wait_till( "flg_bunker_office_entered" );
    level.ai_woods function_9ae1c50();
    savegame::checkpoint_save( 1 );
    objectives::complete( "obj_yamantau_2" );
    var_86b56671 = struct::get( "office_survey_interact_hint", "targetname" );
    level flag::wait_till( "flg_start_regroup_dialog" );
    level thread objectives::goto( "obj_yamantau_3", var_86b56671.origin, #"hash_61477572878e9580" );
    level thread namespace_c8bf7287::function_c17f029c();
    level flag::wait_till( "flg_bunker_survey_interacted" );
    level namespace_5d7a2dac::music( "10.0_surveying" );
    level thread function_a6b2668();
    level thread namespace_9e8d4ac3::function_f5ae4873();
    objectives::complete( "obj_yamantau_3" );
    level waittill( #"survey_equipment_completed" );
    skipto::function_4e3ab877( "woods_regroup" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x9914b9df, Offset: 0x2dd8
// Size: 0x7c
function function_89f8f4f8()
{
    tr_woods_survey_look = getent( "tr_woods_survey_look", "targetname" );
    tr_woods_survey_look thread trigger::look_trigger( tr_woods_survey_look );
    tr_woods_survey_look waittill( #"trigger_look" );
    level flag::set( "flg_bunker_office_seen" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0x22b4aa16, Offset: 0x2e60
// Size: 0x90
function function_61ce8bd0( a_ents )
{
    foreach ( ent in a_ents )
    {
        ent disableaimassist();
    }
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x828aa1cd, Offset: 0x2ef8
// Size: 0x74
function function_bfc063c6()
{
    level endon( #"flg_bunker_office_entered" );
    level.ai_woods waittill( #"goal" );
    level thread scene::play( "scene_yam_6010_grp_enter_react", "woods_table_idle", array( level.ai_woods ) );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0xca640323, Offset: 0x2f78
// Size: 0x34
function function_90350d0d()
{
    level thread breadcrumb::function_61037c6c( #"hash_4972f0176f3f0bff" );
    thread function_ea0c2bef();
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x93a25834, Offset: 0x2fb8
// Size: 0x44
function function_ea0c2bef()
{
    level flag::wait_till( "flg_bunker_office_approach" );
    level thread breadcrumb::function_61037c6c( #"hash_3b2d107a1774074b" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0xcdd800cf, Offset: 0x3008
// Size: 0xc8
function function_471879c2()
{
    self endon( #"flg_bunker_ladder_reached", #"flg_woods_regroup_look_at_woods" );
    s_woods_regroup_lookat = struct::get( "s_woods_regroup_lookat", "targetname" );
    
    while ( !level.player util::is_looking_at( s_woods_regroup_lookat.origin, 0.995 ) )
    {
        waitframe( 1 );
    }
    
    if ( !level flag::get( "flg_bunker_ladder_reached" ) )
    {
        level flag::set( "flg_woods_regroup_look_at_woods" );
    }
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0xdd2270fb, Offset: 0x30d8
// Size: 0x54
function function_4d07bf4e( *str_objective )
{
    level thread objectives::scripted( "obj_yamantau_2", undefined, #"hash_282aa5eed264a248" );
    level flag::set( "flg_bunker_encounter_end" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 4
// Checksum 0xa45cdb33, Offset: 0x3138
// Size: 0x8c
function function_53b51eb0( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    waitframe( 1 );
    namespace_b73b9191::function_ee83e03a( "cull_inside_finale" );
    namespace_b73b9191::function_ee83e03a( "cull_inside_excavation" );
    namespace_b73b9191::function_15426f9d( "cull_inside_bunkerext" );
    namespace_b73b9191::function_15426f9d( "cull_inside_satcom" );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0xbb1dbe4c, Offset: 0x31d0
// Size: 0x41a
function function_4a6ba207()
{
    level endon( #"survey_equipment_completed", #"survey_equipment_crane_line_said" );
    s_poi_crane = struct::get( "s_poi_crane", "targetname" );
    s_poi_bunker = struct::get( "s_poi_bunker", "targetname" );
    s_poi_loading = struct::get( "s_poi_loading", "targetname" );
    wait 2;
    objectives::scripted( #"hash_56fd03bb3b4f0273", undefined, #"hash_533823608d027914", 1 );
    level thread function_ab20f837( s_poi_crane.origin );
    
    while ( true )
    {
        if ( !is_true( level.var_fe1d813f ) && !level flag::get( "survey_equipment_crane_line_said" ) && level.player util::is_player_looking_at( s_poi_crane.origin, 0.99, 0 ) )
        {
            level.var_fe1d813f = 1;
            level thread namespace_7468806b::function_8cc6c411();
            var_d69de23d = gettime() - level.player.var_eb71bc34;
            level notify( #"hash_6b2091e6c001e49a", { #var_d69de23d:var_d69de23d } );
            objectives::complete( #"hash_56fd03bb3b4f0273" );
            objectives::complete( #"hash_177f2110897e65c0" );
            level flag::set( "survey_equipment_crane_line_said" );
            wait 2.5;
            level.var_fe1d813f = 0;
        }
        else if ( !is_true( level.var_fe1d813f ) && !level flag::get( "survey_equipment_bunker_located" ) && level.player util::is_player_looking_at( s_poi_bunker.origin, 0.99, 0 ) )
        {
            level.var_fe1d813f = 1;
            level thread namespace_7468806b::function_bb262760();
            wait 2;
            level flag::set( "survey_equipment_bunker_located" );
            wait 2.5;
            level.var_fe1d813f = 0;
        }
        else if ( !is_true( level.var_fe1d813f ) && !level flag::get( "survey_equipment_loading_dock_located" ) && level.player util::is_player_looking_at( s_poi_loading.origin, 0.99, 0 ) && level.player.var_df3bdc3 > 4 )
        {
            level.var_fe1d813f = 1;
            level thread namespace_7468806b::function_1e979ca1();
            wait 2;
            level flag::set( "survey_equipment_loading_dock_located" );
            wait 2.5;
            level.var_fe1d813f = 0;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 1
// Checksum 0xe2e171c8, Offset: 0x35f8
// Size: 0xbc
function function_ab20f837( var_d79d7bf4 )
{
    s_notify = level waittilltimeout( 7, #"hash_6b2091e6c001e49a" );
    
    if ( s_notify._notify == #"timeout" )
    {
        objectives::goto( #"hash_177f2110897e65c0", var_d79d7bf4, #"hash_3310fa1fd511e5ea", 1 );
        objectives::function_67f87f80( #"hash_177f2110897e65c0", undefined, #"hash_3310fa1fd511e5ea" );
    }
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x26c26b42, Offset: 0x36c0
// Size: 0x4c
function function_8dc5efb()
{
    var_107d17b4 = getent( "e_bunker_survey_door_closed_clip", "targetname" );
    var_107d17b4 movez( -1024, 0.1 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0x909efd8d, Offset: 0x3718
// Size: 0xdc
function function_a6b2668()
{
    var_fe3b4945 = getent( "e_bunker_survey_door_l_clip", "targetname" );
    var_8814d16d = getent( "e_bunker_survey_door_r_clip", "targetname" );
    var_107d17b4 = getent( "e_bunker_survey_door_closed_clip", "targetname" );
    var_fe3b4945 movez( -1024, 0.1 );
    var_8814d16d movez( -1024, 0.1 );
    var_107d17b4 movez( 1024, 0.1 );
}

// Namespace namespace_73841f48/namespace_1d4ee4f8
// Params 0
// Checksum 0xa7fcbaf4, Offset: 0x3800
// Size: 0x94
function function_38479ea0()
{
    var_fe3b4945 = getent( "e_bunker_survey_door_l_clip", "targetname" );
    var_8814d16d = getent( "e_bunker_survey_door_r_clip", "targetname" );
    var_fe3b4945 movez( -1024, 0.1 );
    var_8814d16d movez( -1024, 0.1 );
}

