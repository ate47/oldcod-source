#using script_58524f08c3081cbb;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using script_c36b776c6718540;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_94dc1844;

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x80f724d1, Offset: 0x638
// Size: 0x4
function function_afb0a04c()
{
    
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 2
// Checksum 0xdeb57891, Offset: 0x648
// Size: 0x14
function function_22e1ef3a( *str_objective, *var_50cc0d4f )
{
    
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 1
// Checksum 0x6deb53db, Offset: 0x668
// Size: 0x134
function function_cc91ce1f( *str_objective )
{
    var_5b7b93ad = getspawnerarray( "woods_ar", "script_noteworthy" );
    var_5b7b93ad[ 0 ] spawner::add_spawn_function( &function_dd87ddce );
    level.ai_woods = var_5b7b93ad[ 0 ] spawner::spawn( 1 );
    nd_woods_satcom_overlook = getnode( "nd_woods_satcom_overlook", "targetname" );
    level.ai_woods forceteleport( nd_woods_satcom_overlook.origin, nd_woods_satcom_overlook.angles );
    var_56f59f61 = spawn( "script_origin", nd_woods_satcom_overlook.origin );
    var_56f59f61.angles = nd_woods_satcom_overlook.angles;
    level.ai_woods linkto( var_56f59f61 );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x215301f0, Offset: 0x7a8
// Size: 0xac
function function_dd87ddce()
{
    self.goalradius = 64;
    self val::set( #"woods", "allowdeath", 0 );
    self ai::set_behavior_attribute( "demeanor", "patrol" );
    self.name = "Woods";
    self.propername = #"hash_22f2861ded3918a8";
    self.attackeraccuracy = 0.1;
    self namespace_b73b9191::function_d432b47b();
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 2
// Checksum 0xfce48acc, Offset: 0x860
// Size: 0x14c
function function_56b991c1( *str_objective, *var_50cc0d4f )
{
    level thread function_7233c5ee();
    level thread function_de27b0eb();
    level thread function_de26569a();
    level thread function_bd2f2746();
    level thread namespace_7468806b::function_62d575ad();
    level.ai_woods.var_742cee23 = 1;
    satcom_woods_node = getnode( "satcom_woods_node", "targetname" );
    level.ai_woods thread hms_util::function_2f50100e( "stay_even", satcom_woods_node.origin, "flg_satcom_approached" );
    level flag::wait_till( "flg_satcom_approach_end" );
    savegame::checkpoint_save( 1 );
    skipto::function_4e3ab877( "satcom_approach" );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0xfe59556f, Offset: 0x9b8
// Size: 0x1cc
function function_de27b0eb()
{
    str_flag = "";
    
    do
    {
        s_notify = level flag::wait_till_any( array( "flg_satcom_vista", "flg_intro_zipline_dismount" ) );
        str_flag = s_notify._notify;
        
        if ( !level flag::get( "flg_satcom_vista" ) )
        {
            if ( !level flag::get( "flg_zipline_intro_zipliner_killed" ) )
            {
                thread function_2573cfe4();
            }
            else
            {
                level namespace_7468806b::function_9bd1eb5e();
                level.allowbattlechatter[ #"axis" ] = 0;
            }
            
            level flag::clear( "flg_intro_zipline_dismount" );
        }
    }
    while ( str_flag != "flg_satcom_vista" );
    
    savegame::checkpoint_save( 1 );
    level thread namespace_7468806b::function_7163fd33();
    level thread breadcrumb::function_61037c6c( #"hash_4c535a07614a40af" );
    level flag::wait_till( "flg_satcom_exterior_approaching" );
    level.ai_woods ai::set_behavior_attribute( "demeanor", "combat" );
    level namespace_5d7a2dac::music( "5.0_combat_1" );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x739b4085, Offset: 0xb90
// Size: 0x124
function function_2573cfe4()
{
    if ( isalive( level.var_89f99146 ) && !is_true( level.var_89f99146.in_melee_death ) )
    {
        level.ai_woods ai::shoot_at_target( "kill_within_time", level.var_89f99146, undefined, 5, undefined, 1 );
    }
    
    level flag::wait_till_timeout( 5, "flg_zipline_intro_zipliner_killed" );
    
    if ( level flag::get( "flg_zipline_intro_zipliner_killed" ) && !level flag::get( "flg_satcom_vista" ) )
    {
        level namespace_7468806b::function_9bd1eb5e();
    }
    
    level.allowbattlechatter[ #"axis" ] = 0;
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x704c5424, Offset: 0xcc0
// Size: 0x3c
function function_de26569a()
{
    level flag::wait_till( "flg_satcom_approached" );
    level.ai_woods notify( #"flg_satcom_approached" );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x32f60bb9, Offset: 0xd08
// Size: 0x30c
function function_7233c5ee()
{
    thread function_dae43999();
    level.var_d71e48f7 = [];
    level flag::wait_till( "flg_satcom_spawn_exterior" );
    level thread namespace_b73b9191::function_e79ede39( "flg_satcom_exiting" );
    level thread function_4cd737f6();
    var_a83c59d7 = spawner::simple_spawn( "sp_rus_satcom_sniper", &function_500f511d );
    var_b4c1e6ce = spawner::simple_spawn( "sp_rus_satcom_ground", &function_98c3cbb8 );
    
    foreach ( ai in var_b4c1e6ce )
    {
        ai hms_util::function_22099452( 1 );
    }
    
    level thread function_c20f6fa3( var_b4c1e6ce );
    level.var_d71e48f7 = arraycombine( level.var_d71e48f7, var_b4c1e6ce );
    level.var_d71e48f7 = arraycombine( level.var_d71e48f7, var_a83c59d7 );
    level thread function_ef32b815();
    level thread function_b489670b();
    level.ai_woods thread function_cd0539f4();
    level flag::wait_till( "flg_satcom_approach_end" );
    level flag::wait_till( "flg_satcom_cleared" );
    level namespace_5d7a2dac::music( "5.8_tension_2" );
    
    if ( !level flag::get( "flg_satcom_exiting" ) )
    {
        if ( !level flag::get( "flg_satcom_stealth_broken" ) )
        {
            transient = savegame::function_6440b06b( #"transient" );
            transient.var_296ec611 = 1;
            return;
        }
        
        level thread breadcrumb::function_61037c6c( #"hash_29c606a3feaa95a" );
    }
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x56bbd851, Offset: 0x1020
// Size: 0x7c
function function_4cd737f6()
{
    level endon( #"game_ended" );
    level callback::on_weapon_fired( &function_f56c216d );
    level flag::wait_till( "flg_satcom_clear_sight_clip" );
    level callback::remove_on_weapon_fired( &function_f56c216d );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 1
// Checksum 0xc575bdc8, Offset: 0x10a8
// Size: 0x84
function function_f56c216d( *s_params )
{
    var_55fc9dba = struct::get( "satcom_vista_lookat_struct", "targetname" );
    
    if ( level.player util::is_looking_at( var_55fc9dba.origin, 0.8, 1 ) )
    {
        level flag::set( "flg_satcom_clear_sight_clip" );
    }
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x26e39324, Offset: 0x1138
// Size: 0x64
function function_b489670b()
{
    level flag::wait_till_any( array( "flg_satcom_stealth_broken", "flg_satcom_exiting" ) );
    level.allowbattlechatter[ #"allies" ] = 1;
    level.allowbattlechatter[ #"axis" ] = 1;
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0xd3203a5c, Offset: 0x11a8
// Size: 0xa4
function function_bd2f2746()
{
    level endon( #"flg_satcom_player_exiting" );
    nd_woods_satcom_overlook = getnode( "nd_woods_satcom_overlook", "targetname" );
    
    while ( distance2d( level.ai_woods.origin, nd_woods_satcom_overlook.origin ) > 20 )
    {
        waitframe( 1 );
    }
    
    level flag::set( "flg_satcom_woods_vantage_arrived" );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0xc6e9ef76, Offset: 0x1258
// Size: 0xdc
function function_ef32b815()
{
    level namespace_b73b9191::function_5d981106( "ai_satcom", 0, "flg_satcom_cleared" );
    level thread namespace_7468806b::function_c2968902();
    
    if ( !level flag::get( "flg_satcom_approached" ) )
    {
        trigger::use( "t_satcom_approach_clear", "targetname", level.player, 0 );
    }
    
    t_satcom_woods_ground_approach = getent( "t_satcom_woods_ground_approach", "targetname" );
    
    if ( isdefined( t_satcom_woods_ground_approach ) )
    {
        t_satcom_woods_ground_approach triggerenable( 0 );
    }
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x38dd2e1b, Offset: 0x1340
// Size: 0xcc
function function_dae43999()
{
    var_5d14e11e = [];
    var_5d14e11e[ #"prone" ] = 8192;
    var_5d14e11e[ #"crouch" ] = 8192;
    var_5d14e11e[ #"stand" ] = 8192;
    var_8293536e = [];
    var_8293536e[ #"prone" ] = 8192;
    var_8293536e[ #"crouch" ] = 8192;
    var_8293536e[ #"stand" ] = 8192;
    namespace_979752dc::set_detect_ranges( var_5d14e11e, var_8293536e );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 1
// Checksum 0x6cf9b9bd, Offset: 0x1418
// Size: 0x15c
function function_c20f6fa3( var_b4c1e6ce )
{
    level flag::wait_till( "flg_satcom_reinforce" );
    function_1eaaceab( var_b4c1e6ce, 0 );
    
    if ( var_b4c1e6ce.size < 1 )
    {
        var_8eeb3ab9 = spawner::simple_spawn( "sp_rus_satcom_ground_reinforce" );
        level.var_d71e48f7 = arraycombine( level.var_d71e48f7, var_8eeb3ab9 );
        
        while ( level.var_d71e48f7.size > 0 )
        {
            function_1eaaceab( level.var_d71e48f7, 0 );
            wait 0.1;
        }
        
        wait 1;
        
        if ( !level flag::get( "flg_satcom_approach_end" ) )
        {
            t_satcom_enter = getent( "t_satcom_enter", "targetname" );
            
            if ( isdefined( t_satcom_enter ) )
            {
                trigger::use( "t_satcom_enter", "targetname", level.player, 0 );
            }
        }
    }
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 1
// Checksum 0x1508b49e, Offset: 0x1580
// Size: 0x184
function function_98c3cbb8( var_7f952abc = 0 )
{
    self endon( #"death" );
    self.goalradius = 32;
    self thread function_396c7e23();
    self thread function_456cd67e();
    self thread function_7360246a();
    self.var_c5553760 = 1;
    
    if ( var_7f952abc == 1 )
    {
        self.var_7f952abc = 1;
        self callback::on_ai_killed( &function_dbc98faf );
    }
    
    level thread namespace_7468806b::function_3d0acc51( self );
    level flag::wait_till( "flg_satcom_stealth_broken" );
    self namespace_979752dc::enable_stealth_for_ai( 0 );
    level flag::wait_till( "flg_satcom_ground_push" );
    vol_satcom_ground_push = getent( "vol_satcom_ground_push", "targetname" );
    self setgoal( vol_satcom_ground_push, 1 );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0xcc0f8eb5, Offset: 0x1710
// Size: 0x104
function function_500f511d()
{
    self endon( #"death" );
    self.goalradius = 32;
    self val::set( "satcom_sniper", "attackeraccuracy", 0.1 );
    self namespace_979752dc::function_bf1fb16f();
    self thread function_396c7e23();
    self thread function_456cd67e();
    self thread function_7360246a();
    self.var_c5553760 = 1;
    self.script_accuracy = 1000;
    self.perfectaim = 1;
    self.favoriteenemy = level.player;
    level thread namespace_7468806b::function_3d0acc51( self );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x3fd323c2, Offset: 0x1820
// Size: 0x74
function function_396c7e23()
{
    self val::set( "satcom_snipers", "ignoreall" );
    level flag::wait_till( "flg_satcom_clear_sight_clip" );
    self val::reset( "satcom_snipers", "ignoreall" );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x6d4ba90e, Offset: 0x18a0
// Size: 0x64
function function_456cd67e()
{
    self endon( #"death" );
    self util::waittill_any_ents( self, "damage", self, "stealth_combat", self, "bulletwhizby" );
    level flag::set( "flg_satcom_stealth_broken" );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x926fe109, Offset: 0x1910
// Size: 0x88
function function_63fec104()
{
    self endon( #"death" );
    
    while ( !level flag::get( "flg_satcom_stealth_broken" ) )
    {
        if ( self.alertlevel == "low_alert" || self.alertlevel == "high_alert" )
        {
            level flag::set( "flg_satcom_stealth_broken" );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0xf287e8b2, Offset: 0x19a0
// Size: 0xb4
function function_7360246a()
{
    self endon( #"death" );
    level flag::wait_till( "flg_satcom_stealth_broken" );
    wait randomfloatrange( 1, 3 );
    self function_a3fcf9e0( "attack", level.player, level.player getplayercamerapos() );
    self getperfectinfo( level.player );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 1
// Checksum 0x9f9d78fd, Offset: 0x1a60
// Size: 0x44
function function_dbc98faf( *s_params )
{
    if ( isdefined( self.var_7f952abc ) && self.var_7f952abc == 1 )
    {
        self startragdoll( 1 );
    }
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x19ee8d49, Offset: 0x1ab0
// Size: 0xa4
function function_2f1fcaac()
{
    self endon( #"death" );
    level flag::wait_till( "flg_satcom_ambush_scene_done" );
    self namespace_979752dc::function_bf1fb16f();
    
    while ( true )
    {
        if ( self cansee( level.ai_woods ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    wait 0.2;
    self namespace_979752dc::enable_stealth_for_ai( 0 );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0xf564ced0, Offset: 0x1b60
// Size: 0x232
function function_cd0539f4()
{
    self endon( #"death" );
    level endon( #"hash_ef37a73be834016" );
    self val::set( #"woods", "ignoreall", 1 );
    self val::set( #"woods", "ignoreme", 1 );
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    self.goalradius = 64;
    level flag::wait_till_any( array( "flg_satcom_entered", "flg_satcom_stealth_broken" ) );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self val::reset( #"woods", "ignoreme" );
    self val::reset( #"woods", "ignoreall" );
    var_2e6fd2e = self.script_accuracy;
    self.script_accuracy = 0.2;
    
    if ( !level flag::get( "flg_satcom_stealth_broken" ) )
    {
        level flag::wait_till( "flg_satcom_stealth_broken" );
    }
    
    level thread namespace_7468806b::function_c4f4d5d3();
    level flag::wait_till( "flg_satcom_entered" );
    self val::reset( #"woods", "ignoreme" );
    self.script_accuracy = var_2e6fd2e;
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 1
// Checksum 0xb1595d8f, Offset: 0x1da0
// Size: 0x164
function function_c73772c6( *str_objective )
{
    function_afb0a04c();
    level thread objectives::scripted( "obj_yamantau_1", undefined, #"hash_423da80c752f859f" );
    namespace_b73b9191::function_2683ec5d();
    level flag::set( "flg_zipline_intro_zipliner_killed" );
    var_b4bb921 = struct::get( "woods_satcom_approach_teleport", "targetname" );
    level.ai_woods forceteleport( var_b4bb921.origin, var_b4bb921.angles );
    level thread namespace_7468806b::function_79af70ae( 1 );
    level thread namespace_7468806b::function_ba5a28f( 1 );
    level.allowbattlechatter[ #"allies" ] = 0;
    level.allowbattlechatter[ #"axis" ] = 0;
    level thread namespace_8a404420::function_517fe722();
    level flag::set( "flg_satcom_birds_trigger" );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 4
// Checksum 0xebe8e348, Offset: 0x1f10
// Size: 0x24
function function_844967aa( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 2
// Checksum 0x6557a41d, Offset: 0x1f40
// Size: 0x1ac
function function_8cc2cc25( *str_objective, *var_50cc0d4f )
{
    level thread function_a94c664a();
    level flag::wait_till( "flg_satcom_entered" );
    
    if ( level flag::get( "flg_satcom_cleared" ) )
    {
        level thread namespace_7468806b::function_967c94ee();
    }
    
    level.ai_woods ai::function_3a5e9945( 1 );
    level thread namespace_7468806b::function_a7286428();
    level thread namespace_b73b9191::function_6f1012dd( "satcom" );
    level flag::wait_till( "flg_satcom_woods_descend" );
    level.ai_woods ai::function_3a5e9945( 0 );
    level flag::wait_till( "flg_satcom_exiting" );
    
    if ( !level flag::get( "flg_crossbow_bolt_corpse_interacted_with" ) )
    {
        level thread namespace_b73b9191::function_2e5072b5( "satcom" );
    }
    
    savegame::checkpoint_save( 1 );
    skipto::function_4e3ab877( "satcom" );
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 0
// Checksum 0x36e6e281, Offset: 0x20f8
// Size: 0x124
function function_a94c664a()
{
    level endon( #"flg_satcom_woods_descend" );
    nd_satcom_int_woods_arrive = getnode( "nd_satcom_int_woods_arrive", "targetname" );
    
    while ( distance2d( level.ai_woods.origin, nd_satcom_int_woods_arrive.origin ) > 20 )
    {
        waitframe( 1 );
    }
    
    level flag::wait_till( "flg_satcom_entered" );
    wait randomfloatrange( 1.5, 3 );
    tr_satcom_interior = getent( "tr_satcom_interior", "targetname" );
    
    if ( isdefined( tr_satcom_interior ) )
    {
        trigger::use( "tr_satcom_interior", "targetname", level.player, 0 );
    }
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 1
// Checksum 0xbbcfe11, Offset: 0x2228
// Size: 0x170
function function_f6f8cdca( *str_objective )
{
    function_afb0a04c();
    level thread objectives::scripted( "obj_yamantau_1", undefined, #"hash_423da80c752f859f" );
    namespace_b73b9191::function_2683ec5d();
    var_b4bb921 = struct::get( "woods_satcom_teleport", "targetname" );
    level.ai_woods forceteleport( var_b4bb921.origin, var_b4bb921.angles );
    level thread namespace_7468806b::function_79af70ae( 1 );
    level thread namespace_7468806b::function_ba5a28f( 1 );
    level.allowbattlechatter[ #"allies" ] = 0;
    level.allowbattlechatter[ #"axis" ] = 0;
    level thread namespace_8a404420::function_517fe722();
    level flag::set( "flg_satcom_birds_trigger" );
    level flag::set( "flg_satcom_cleared" );
    level.var_13434d89 = [];
}

// Namespace namespace_94dc1844/namespace_4362807e
// Params 4
// Checksum 0xcfe262f9, Offset: 0x23a0
// Size: 0x44
function function_a46dc345( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level callback::remove_on_ai_killed( &function_dbc98faf );
}

