#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\buddy_follow;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\util;

#namespace namespace_ba979a10;

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 0
// Checksum 0x840b1a10, Offset: 0x408
// Size: 0x324
function function_ee211e0d()
{
    var_c7325764 = getent( "obj_tundra_bunker_01", "targetname" );
    objectives::function_4eb5c04a( "search_01", var_c7325764.origin + ( 0, 0, 500 ), #"hash_25312f567bf1f18c" );
    objectives::function_6a5ca7ac( "search_01", undefined, #"search_and_kill_obj", undefined, 0 );
    waitframe( 1 );
    objectives::function_67f87f80( "search_01", undefined, #"hash_5f6c6d96184307e0" );
    level thread function_c7612635();
    var_b8923a10 = getent( "obj_tundra_bunker_02", "targetname" );
    objectives::function_4eb5c04a( "search_02", var_b8923a10.origin + ( 0, 0, 500 ), #"hash_253132567bf1f6a5" );
    objectives::function_6a5ca7ac( "search_02", undefined, #"search_and_kill_obj", undefined, 0 );
    waitframe( 1 );
    objectives::function_67f87f80( "search_02", undefined, #"hash_5f6c6d96184307e0" );
    level thread function_7f4315fa();
    var_c7555796 = getent( "obj_tundra_bunker_03", "targetname" );
    objectives::function_4eb5c04a( "search_03", var_c7555796.origin + ( 0, 0, 500 ), #"hash_253131567bf1f4f2" );
    objectives::function_6a5ca7ac( "search_03", undefined, #"search_and_kill_obj", undefined, 0 );
    waitframe( 1 );
    objectives::function_67f87f80( "search_03", undefined, #"hash_5f6c6d96184307e0" );
    level thread function_ecfd716d();
    level flag::wait_till( "tundra_vip_enemy_spawned" );
    waitframe( 1 );
    objectives::kill( "kill_vip", level.vip, undefined, undefined, undefined, undefined, #"hash_17f4660b06e37fdb" );
    level flag::wait_till( "flag_tundra_vip_killed" );
}

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 0
// Checksum 0xfd07bf22, Offset: 0x738
// Size: 0x7c
function function_c7612635()
{
    level flag::wait_till_all( array( "flag_obj_1_search_clear_1", "flag_obj_1_search_clear_2", "flag_obj_1_search_clear_3", "flag_obj_1_search_clear_4" ) );
    level flag::set( "search_objective_1_cleared" );
    objectives::complete( "search_01" );
}

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 0
// Checksum 0xc485da34, Offset: 0x7c0
// Size: 0x6c
function function_7f4315fa()
{
    level flag::wait_till_all( array( "flag_obj_2_search_clear_1", "flag_obj_2_search_clear_2" ) );
    level flag::set( "search_objective_2_cleared" );
    objectives::complete( "search_02" );
}

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 0
// Checksum 0x5be0ea1f, Offset: 0x838
// Size: 0x6c
function function_ecfd716d()
{
    level flag::wait_till_all( array( "flag_obj_3_search_clear_1", "flag_obj_3_search_clear_2" ) );
    level flag::set( "search_objective_3_cleared" );
    objectives::complete( "search_03" );
}

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 0
// Checksum 0x2c6fee0c, Offset: 0x8b0
// Size: 0x104
function function_aba9a175()
{
    if ( flag::get( "search_objective_1_cleared" ) && flag::get( "search_objective_3_cleared" ) )
    {
        objectives::complete( "search_02" );
        return;
    }
    
    if ( flag::get( "search_objective_1_cleared" ) && flag::get( "search_objective_2_cleared" ) )
    {
        objectives::complete( "search_03" );
        return;
    }
    
    if ( flag::get( "search_objective_2_cleared" ) && flag::get( "search_objective_3_cleared" ) )
    {
        objectives::complete( "search_01" );
    }
}

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 0
// Checksum 0x7d629b19, Offset: 0x9c0
// Size: 0x4cc
function function_78a1b9ef()
{
    level.vip = self;
    level flag::set( "tundra_vip_enemy_spawned" );
    level thread function_aba9a175();
    level.vip setmaxhealth( 500 );
    level.vip setnormalhealth( 1 );
    level.var_c1ec7c3d = level.vip.model;
    level.vip waittill( #"damage" );
    var_127eca1 = [ "j_spine4", "j_head", "j_shoulder_le", "j_shoulder_ri", "j_neck", "j_mainroot", "j_wrist_le", "j_wrist_ri" ];
    level.var_a4592423 = [];
    
    for ( i = 0; i < var_127eca1.size ; i++ )
    {
        level.var_a4592423[ i ] = util::spawn_model( "tag_origin", level.vip gettagorigin( var_127eca1[ i ] ) );
        level.var_a4592423[ i ] linkto( level.vip, var_127eca1[ i ], ( 0, 0, 8 ) );
    }
    
    level.vip startragdoll( 1 );
    level.vip setcontents( 0 );
    level.vip val::set( "vip_death", "ignoreme", 1 );
    level.vip val::set( "vip_death", "ignoreall", 1 );
    level.vip ai::gun_remove();
    level.vip val::set( "vip_death", "allowdeath", 0 );
    timeout = gettime() + 7000;
    var_f1e74dd2 = ( 0, 0, 0 );
    
    while ( timeout > gettime() && isdefined( level.vip ) && lengthsquared( var_f1e74dd2 - level.vip gettagorigin( "j_head" ) + level.vip gettagorigin( "j_wrist_le" ) + level.vip gettagorigin( "j_wrist_ri" ) ) > 3 )
    {
        var_f1e74dd2 = level.vip gettagorigin( "j_head" ) + level.vip gettagorigin( "j_wrist_le" ) + level.vip gettagorigin( "j_wrist_ri" );
        waitframe( 4 );
    }
    
    if ( isdefined( level.vip ) )
    {
        level.vip setentitypaused( 1 );
    }
    
    level flag::set( "flag_corpse_camera_tags_setup" );
    waitframe( 1 );
    level flag::wait_till( "flag_corpse_camera_tags_setup" );
    level flag::set( "flag_tundra_vip_killed" );
    objectives::complete( "search_and_kill_obj" );
    objectives::complete( "kill" );
}

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 1, eflags: 0x4
// Checksum 0xefb119b0, Offset: 0xe98
// Size: 0x7c
function private function_36578ff1( *parm )
{
    corpse = self;
    
    if ( corpse.model == level.var_c1ec7c3d )
    {
        level.var_b28ef69b = corpse;
        level flag::set( "flag_vip_became_corpse" );
        corpse callback::function_95ba5345( &function_36578ff1 );
    }
}

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 2
// Checksum 0x3283deba, Offset: 0xf20
// Size: 0x3c
function function_d3e635a9( set_flag, notification )
{
    self waittill( notification );
    level flag::set( set_flag );
}

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 0
// Checksum 0xdfe3b378, Offset: 0xf68
// Size: 0x64
function function_cb6a2e9b()
{
    /#
        function_b6c5e7fc();
    #/
    
    /#
        function_5c6bf555();
    #/
    
    /#
        function_cfcd9b92();
    #/
    
    /#
        function_5e3101b2();
    #/
}

/#

    // Namespace namespace_ba979a10/namespace_ba979a10
    // Params 0
    // Checksum 0x9dd489db, Offset: 0xfd8
    // Size: 0x13c, Type: dev
    function function_b6c5e7fc()
    {
        level.var_796fbc8 = newdebughudelem();
        level.var_796fbc8.elemtype = "<dev string:x38>";
        level.var_796fbc8.font = "<dev string:x40>";
        level.var_796fbc8.fontscale = 1;
        level.var_796fbc8.horzalign = "<dev string:x4d>";
        level.var_796fbc8.vertalign = "<dev string:x57>";
        level.var_796fbc8.alignx = "<dev string:x4d>";
        level.var_796fbc8.aligny = "<dev string:x57>";
        level.var_796fbc8.y = -187;
        level.var_796fbc8.sort = 2;
        level.var_796fbc8.alpha = 1;
        level.var_796fbc8.hidewheninmenu = 1;
        level.var_796fbc8 settext( "<dev string:x61>" );
    }

    // Namespace namespace_ba979a10/namespace_ba979a10
    // Params 0
    // Checksum 0x147b172c, Offset: 0x1120
    // Size: 0x11a, Type: dev
    function function_5c6bf555()
    {
        level.var_105512d3 = newdebughudelem();
        level.var_105512d3.elemtype = "<dev string:x38>";
        level.var_105512d3.font = "<dev string:x40>";
        level.var_105512d3.fontscale = 1.5;
        level.var_105512d3.horzalign = "<dev string:x4d>";
        level.var_105512d3.vertalign = "<dev string:x57>";
        level.var_105512d3.alignx = "<dev string:x4d>";
        level.var_105512d3.aligny = "<dev string:x57>";
        level.var_105512d3.y = -167;
        level.var_105512d3.sort = 2;
        level.var_105512d3.alpha = 1;
        level.var_105512d3.hidewheninmenu = 1;
    }

    // Namespace namespace_ba979a10/namespace_ba979a10
    // Params 0
    // Checksum 0xf67711bf, Offset: 0x1248
    // Size: 0x168, Type: dev
    function function_cfcd9b92()
    {
        level endon( #"flag_tundra_vip_killed" );
        level.n_timer = 600;
        
        while ( level.n_timer >= 0 )
        {
            var_81ffb4b5 = floor( level.n_timer / 60 );
            var_f168d6d2 = level.n_timer % 60;
            
            if ( var_f168d6d2 < 10 )
            {
                var_f168d6d2 = "<dev string:x74>" + var_f168d6d2;
            }
            
            /#
                level.var_105512d3 settext( var_81ffb4b5 + "<dev string:x79>" + var_f168d6d2 );
            #/
            
            if ( level.n_timer == 120 )
            {
                level.var_105512d3.color = ( 1, 0, 0 );
            }
            
            if ( level.n_timer == 0 )
            {
                wait 1;
                level thread function_94505a0b();
                break;
            }
            
            wait 1;
            
            if ( getdvar( #"hash_3cbb0c98822270b1", 0 ) == 0 )
            {
                level.n_timer--;
            }
        }
    }

    // Namespace namespace_ba979a10/namespace_ba979a10
    // Params 0
    // Checksum 0x1e8acd66, Offset: 0x13b8
    // Size: 0x6c, Type: dev
    function function_94505a0b()
    {
        level notify( #"hash_735d8a7a19186a9e" );
        level flag::set( "<dev string:x7e>" );
        function_5e3101b2();
        util::missionfailedwrapper( #"hash_12d28adaf4dfb7ab" );
    }

    // Namespace namespace_ba979a10/namespace_ba979a10
    // Params 0
    // Checksum 0xaafa1c1c, Offset: 0x1430
    // Size: 0x4c, Type: dev
    function function_5e3101b2()
    {
        level.var_796fbc8 settext( "<dev string:x94>" );
        level.var_105512d3 settext( "<dev string:x94>" );
    }

#/

// Namespace namespace_ba979a10/namespace_ba979a10
// Params 0
// Checksum 0xa7546b96, Offset: 0x1488
// Size: 0xf8
function setup_allies()
{
    util::function_268bdf4f( "woods" );
    level flag::wait_till( "tundra_intro_done" );
    setdvar( #"hash_7f1fd7271ba70c67", 1 );
    
    foreach ( hero in level.heroes )
    {
        hero thread hms_util::function_d370236e( level.player );
    }
}

