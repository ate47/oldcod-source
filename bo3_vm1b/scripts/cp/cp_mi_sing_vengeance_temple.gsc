#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai_shared;
#using scripts/shared/ai_sniper_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth_vo;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace vengeance_temple;

// Namespace vengeance_temple
// Params 2
// Checksum 0x3309bb5b, Offset: 0x13e0
// Size: 0x10a
function skipto_temple_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        vengeance_util::skipto_baseline( str_objective, b_starting );
        callback::on_spawned( &vengeance_util::give_hero_weapon );
        vengeance_util::init_hero( "hendricks", str_objective );
        level thread vengeance_util::function_cc6f3598();
        level thread vengeance_util::function_3f34106b();
        level thread namespace_9fd035::function_dad71f51();
        load::function_a2995f22();
        objectives::set( "cp_level_vengeance_rescue_kane" );
        objectives::set( "cp_level_vengeance_go_to_safehouse" );
        objectives::hide( "cp_level_vengeance_go_to_safehouse" );
    }
    
    temple_main( str_objective );
}

// Namespace vengeance_temple
// Params 1
// Checksum 0xedc71857, Offset: 0x14f8
// Size: 0x6cb
function temple_main( str_objective )
{
    stealth::reset();
    level.var_67e1f60e[ level.var_67e1f60e.size ] = &function_591ead63;
    level flag::set( "temple_begin" );
    setdvar( "scr_security_breach_lose_contact_distance", 36000 );
    setdvar( "scr_security_breach_lost_contact_distance", 72000 );
    level thread vengeance_accolades::function_a6fadcaa();
    level thread temple_vo();
    level.ai_hendricks thread setup_temple_hendricks();
    spawner::add_spawn_function_group( "temple_ambient_civilian", "script_noteworthy", &temple_ambient_civilian );
    level thread temple_wasps();
    level thread function_a86ac59d();
    level thread setup_breakable_garden_windows();
    vengeance_util::function_e00864bd( "office_umbra_gate", 0, "office_gate" );
    level.temple_patroller_spawners = spawner::simple_spawn( "temple_patroller_spawners", &function_e8f0e2bd );
    level thread dogleg_2_intro_trigger();
    level thread vengeance_util::function_e3420328( "temple_ambient_anims", "dogleg_2_at_end" );
    level thread scene::play( "cin_ven_05_20_pond_floaters_vign" );
    spawner::add_spawn_function_group( "drowncivilian_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_22_drowncivilian_civdeath_vign", "cin_ven_05_22_drowncivilian_enemyreact_vign", undefined );
    level thread scene::play( "cin_ven_05_22_drowncivilian_vign" );
    spawner::add_spawn_function_group( "rocksmash_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_21_rocksmash_civdeath_vign", "cin_ven_05_21_rocksmash_enemyreact_vign", "rocksmash_boulder" );
    var_6a07eb6c = [];
    var_6a07eb6c[ 0 ] = "rocksmash_civilian";
    scene::add_scene_func( "cin_ven_05_21_rocksmash_vign", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    level thread scene::play( "cin_ven_05_21_rocksmash_vign" );
    spawner::add_spawn_function_group( "slicendice_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_23_slicendice_civdeath_vign", undefined, "slicendice_machete" );
    var_6a07eb6c = [];
    var_6a07eb6c[ 0 ] = "slicendice_civilian";
    scene::add_scene_func( "cin_ven_05_23_slicendice_vign", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    level thread scene::play( "cin_ven_05_23_slicendice_vign" );
    spawner::add_spawn_function_group( "beatdown_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_26_beatdown_civdeath_vign", undefined, undefined );
    level thread scene::play( "cin_ven_05_26_beatdown_vign" );
    spawner::add_spawn_function_group( "execution_lineup_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_24_execution_lineup_civdeath_vign", undefined, undefined );
    level thread scene::play( "cin_ven_05_24_execution_lineup_vign" );
    spawner::add_spawn_function_group( "ammorestock_en3", "targetname", &function_558af5fd, undefined, undefined, "cin_ven_05_27_ammorestock_enemyreact_vign", undefined );
    level thread scene::play( "cin_ven_05_27_ammorestock_vign" );
    spawner::add_spawn_function_group( "grassstomp_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_28_grassstomp_civdeath_vign", undefined, undefined );
    level thread scene::play( "cin_ven_05_28_grassstomp_vign" );
    spawner::add_spawn_function_group( "railbeatdown_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_29_rail_beatdown_civdeath_vign", "cin_ven_05_29_rail_beatdown_enemyreact_vign", undefined );
    var_6a07eb6c = [];
    var_6a07eb6c[ 0 ] = "railbeatdown_civ";
    scene::add_scene_func( "cin_ven_05_29_rail_beatdown_vign", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    level thread scene::play( "cin_ven_05_29_rail_beatdown_vign" );
    spawner::add_spawn_function_group( "wallbeatdown_enemy1", "targetname", &function_558af5fd, undefined, "cin_ven_05_32_wall_beatdown_civdeath_vign", "cin_ven_05_32_wall_beatdown_enemyreact_vign", undefined );
    level thread scene::play( "cin_ven_05_32_wall_beatdown_vign" );
    level thread function_ea758541( "temple_rooftop_sniper_trigger", "targetname" );
    triggers = getentarray( "temple_stealth_checkpoint_trigger", "targetname" );
    
    foreach ( trigger in triggers )
    {
        trigger thread vengeance_util::function_f9c94344();
    }
    
    level thread function_68be9dc2();
    clips = getentarray( "temple_spawn_closet_door_pathing_clip", "targetname" );
    
    foreach ( clip in clips )
    {
        clip disconnectpaths();
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x2c2f29be, Offset: 0x1bd0
// Size: 0x193
function function_68be9dc2()
{
    wait 0.25;
    var_dd48cfe3 = [];
    var_dd48cfe3[ var_dd48cfe3.size ] = "drowncivilian_civilian";
    var_dd48cfe3[ var_dd48cfe3.size ] = "rocksmash_civilian";
    var_dd48cfe3[ var_dd48cfe3.size ] = "slicendice_civilian";
    var_dd48cfe3[ var_dd48cfe3.size ] = "beatdown_civilian";
    var_dd48cfe3[ var_dd48cfe3.size ] = "execution_lineup_civ1";
    var_dd48cfe3[ var_dd48cfe3.size ] = "execution_lineup_civ2";
    var_dd48cfe3[ var_dd48cfe3.size ] = "execution_lineup_civ3";
    var_dd48cfe3[ var_dd48cfe3.size ] = "execution_lineup_civ4";
    var_dd48cfe3[ var_dd48cfe3.size ] = "execution_lineup_civ5";
    var_dd48cfe3[ var_dd48cfe3.size ] = "execution_lineup_civ6";
    var_dd48cfe3[ var_dd48cfe3.size ] = "temple_butcher_civilian";
    var_dd48cfe3[ var_dd48cfe3.size ] = "gateroughup_civilian";
    var_dd48cfe3[ var_dd48cfe3.size ] = "grassstomp_civ";
    var_dd48cfe3[ var_dd48cfe3.size ] = "railbeatdown_civ";
    var_dd48cfe3[ var_dd48cfe3.size ] = "wallbeatdown_civilian";
    
    foreach ( var_aca1a7c8 in var_dd48cfe3 )
    {
        var_ad10cf41 = getentarray( var_aca1a7c8, "targetname" );
        
        foreach ( civ in var_ad10cf41 )
        {
            civ thread vengeance_util::function_f832e2fa();
        }
    }
}

// Namespace vengeance_temple
// Params 4
// Checksum 0x485427cb, Offset: 0x1d70
// Size: 0x16a
function function_558af5fd( var_7131db57, var_1f486a3b, react_scene, drop_object )
{
    self endon( #"death" );
    
    if ( isdefined( var_7131db57 ) )
    {
        self stealth_vo::function_4970c8b8( var_7131db57 );
    }
    
    self thread function_c2627018( var_1f486a3b, drop_object );
    self util::waittill_any( "alert", "damage" );
    
    if ( isdefined( self.script_aigroup ) )
    {
        group = getaiarray( self.script_aigroup, "script_aigroup" );
        
        foreach ( guy in group )
        {
            if ( isalive( guy ) && guy != self )
            {
                guy notify( #"alert", "combat" );
            }
        }
    }
    
    if ( isdefined( drop_object ) )
    {
        level thread function_54c1902c( drop_object );
    }
    
    if ( isdefined( react_scene ) )
    {
        self stopanimscripted();
        level thread scene::play( react_scene );
    }
}

// Namespace vengeance_temple
// Params 2
// Checksum 0xc21bad36, Offset: 0x1ee8
// Size: 0x6a
function function_c2627018( var_1f486a3b, drop_object )
{
    self util::waittill_any( "death", "alert", "damage" );
    
    if ( isdefined( drop_object ) )
    {
        level thread function_54c1902c( drop_object );
    }
    
    if ( isdefined( var_1f486a3b ) )
    {
        level thread scene::play( var_1f486a3b );
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x199a07cb, Offset: 0x1f60
// Size: 0xd2
function function_e0d6af75()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self thread function_64cea510();
    self util::waittill_any( "alert", "fake_alert" );
    self animation::fire_weapon();
    self stopanimscripted();
    civ = getent( "gunpoint_civilian_ai", "targetname" );
    
    if ( isdefined( civ ) && isalive( civ ) )
    {
        civ notify( #"fake_death" );
    }
    
    wait 0.1;
    self ai::set_ignoreme( 0 );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x4ed0d8cb, Offset: 0x2040
// Size: 0xfc
function function_64cea510()
{
    self waittill( #"death" );
    civ = getent( "gunpoint_civilian_ai", "targetname" );
    
    if ( isdefined( civ ) && isalive( civ ) )
    {
        civ notify( #"fake_death" );
    }
    
    if ( isdefined( self ) )
    {
        start_origin = self gettagorigin( "tag_flash" );
        
        if ( isdefined( start_origin ) )
        {
            end_origin = start_origin + anglestoforward( self gettagangles( "tag_flash" ) ) * 120;
            
            if ( isdefined( start_origin ) && isdefined( end_origin ) )
            {
                shot = magicbullet( getweapon( "shotgun_pump" ), start_origin, end_origin );
            }
        }
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x6b845874, Offset: 0x2148
// Size: 0x122
function function_bddcb39c()
{
    self endon( #"death" );
    self.team = "allies";
    self.civilian = 1;
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "panic", 0 );
    self.health = 1;
    self util::waittill_any( "damage", "alert", "fake_death" );
    guy = getent( "gunpoint_enemy_ai", "targetname" );
    
    if ( isdefined( guy ) && isalive( guy ) )
    {
        guy notify( #"fake_alert" );
    }
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        util::stop_magic_bullet_shield( self );
    }
    
    self.takedamage = 1;
    self.allowdeath = 1;
    self kill();
    self startragdoll();
}

// Namespace vengeance_temple
// Params 1
// Checksum 0x26d0e710, Offset: 0x2278
// Size: 0x62
function function_54c1902c( e_obj )
{
    if ( isdefined( e_obj ) )
    {
        e_obj = getent( e_obj, "targetname" );
        
        if ( isdefined( e_obj ) )
        {
            e_obj stopanimscripted();
            e_obj physicslaunch( e_obj.origin, ( 0, 0, 0.1 ) );
        }
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xbab21b5a, Offset: 0x22e8
// Size: 0x62
function temple_ambient_civilian()
{
    self endon( #"death" );
    self.team = "allies";
    self.civilian = 1;
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "panic", 0 );
    self.health = 1;
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xa64d01b5, Offset: 0x2358
// Size: 0x3a
function function_e8f0e2bd()
{
    self thread vengeance_util::setup_patroller();
    self playloopsound( "amb_patrol_walla" );
    self thread ai_sniper::agent_init();
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xec3b0253, Offset: 0x23a0
// Size: 0x32
function temple_wasps()
{
    level.temple_wasps = spawner::simple_spawn( "temple_wasps", &function_a044ee0 );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x47ea3df7, Offset: 0x23e0
// Size: 0x62
function function_a044ee0()
{
    temple_wasp_gv = getent( "temple_wasp_gv", "targetname" );
    
    if ( isdefined( temple_wasp_gv ) )
    {
        self clearforcedgoal();
        self cleargoalvolume();
        self setgoal( temple_wasp_gv );
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xe11a16d0, Offset: 0x2450
// Size: 0x10a
function setup_temple_hendricks()
{
    level endon( #"stealth_discovered" );
    self endon( #"death" );
    self thread function_f6b53854();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self colors::disable();
    self ai::set_behavior_attribute( "cqb", 1 );
    self.holdfire = 1;
    self battlechatter::function_d9f49fba( 0 );
    level scene::play( "cin_ven_05_10_templearrival_vign" );
    self.disablearrivals = 1;
    self.disableexits = 1;
    node = getnode( "temple_hendricks_node_05", "targetname" );
    self setgoal( node, 1 );
    level notify( #"temple_vo" );
    wait 1;
    self.disablearrivals = 0;
    self.disableexits = 0;
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xb5a72388, Offset: 0x2568
// Size: 0x21a
function function_f6b53854()
{
    level flag::wait_till( "stealth_discovered" );
    level flag::set( "temple_stealth_broken" );
    self.disablearrivals = 0;
    self.disableexits = 0;
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self.fixednode = 0;
    self clearforcedgoal();
    self ai::set_behavior_attribute( "cqb", 0 );
    self.holdfire = 0;
    self.var_df53bc6 = self.script_accuracy;
    self.script_accuracy = 0.1;
    objectives::set( "cp_level_vengeance_support", self );
    self thread vengeance_util::function_5a886ae0();
    level flag::wait_till_clear( "stealth_discovered" );
    self notify( #"hash_90a20e6d" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.holdfire = 1;
    self battlechatter::function_d9f49fba( 0 );
    self.script_accuracy = self.var_df53bc6;
    self clearforcedgoal();
    self cleargoalvolume();
    self colors::disable();
    temple_end_hendricks_node = getnode( "temple_end_hendricks_node", "targetname" );
    self.forcegoal = 1;
    self.fixednode = 1;
    self.goalradius = 32;
    self setgoalnode( temple_end_hendricks_node, 1 );
    level flag::clear( "stealth_combat" );
    self waittill( #"goal" );
    self.forcegoal = 0;
    self.fixednode = 0;
    level flag::set( "temple_hendricks_done" );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x32a8e4cf, Offset: 0x2790
// Size: 0x152
function function_4002969a()
{
    level flag::wait_till( "all_players_at_temple_exit" );
    
    if ( !level flag::get( "hendricks_near_dogleg_2" ) )
    {
        nodes = getnodearray( "hendricks_temple_end_teleport_node", "targetname" );
        node = arraygetclosest( level.ai_hendricks.origin, nodes );
        n_off_screen_dot = 0.75;
        
        if ( vengeance_util::any_player_looking_at( level.ai_hendricks.origin + ( 0, 0, 48 ), n_off_screen_dot, 1 ) )
        {
            level.ai_hendricks forceteleport( node.origin, node.angles );
            wait 0.1;
            temple_end_hendricks_node = getnode( "temple_end_hendricks_node", "targetname" );
            self.forcegoal = 1;
            self.fixednode = 1;
            self.goalradius = 32;
            self setgoalnode( temple_end_hendricks_node, 1 );
        }
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x37ad13b1, Offset: 0x28f0
// Size: 0x939
function function_578145a3()
{
    var_1044cded = 0;
    i = 3;
    
    for ( i = 3; i >= 2 ; i-- )
    {
        var_26b3981a = getent( "temple_axis_gv_0" + i, "targetname" );
        var_42cc32ad = function_f1c7b73f( var_26b3981a );
        
        if ( isdefined( var_42cc32ad ) && var_42cc32ad )
        {
            var_1044cded = 1;
            break;
        }
    }
    
    var_17994622 = getaiteamarray( "axis" );
    
    if ( isdefined( var_1044cded ) && var_1044cded )
    {
        ally_volume = getent( "temple_ally_gv_0" + i, "targetname" );
        var_a2d2b3b = getent( "temple_axis_gv_0" + i, "targetname" );
        var_fcf2483c = getent( "temple_axis_cleanup_volume_0" + i, "targetname" );
        level thread function_620fbb8a( var_17994622, var_fcf2483c );
    }
    else
    {
        ally_volume = getent( "temple_ally_gv_01", "targetname" );
        var_a2d2b3b = getent( "temple_axis_gv_01", "targetname" );
    }
    
    foreach ( guy in var_17994622 )
    {
        if ( isalive( guy ) )
        {
            guy clearforcedgoal();
            guy cleargoalvolume();
            guy setgoal( var_a2d2b3b );
        }
    }
    
    if ( isdefined( var_1044cded ) && var_1044cded )
    {
        nodes = getnodearray( "hendircks_forced_advance_0" + i, "targetname" );
        node = array::random( nodes );
        level.ai_hendricks forceteleport( node.origin, node.angles );
        wait 0.1;
    }
    
    level.ai_hendricks clearforcedgoal();
    level.ai_hendricks cleargoalvolume();
    level.ai_hendricks setgoal( ally_volume );
    ally_volume = getent( "temple_ally_gv_02", "targetname" );
    var_a2d2b3b = getent( "temple_axis_gv_02", "targetname" );
    
    while ( true )
    {
        if ( isdefined( var_1044cded ) && var_1044cded && i >= 2 )
        {
            break;
        }
        
        guys_left = getaiteamarray( "axis" );
        
        if ( isdefined( guys_left ) && guys_left.size <= var_17994622.size * 0.8 )
        {
            foreach ( guy in guys_left )
            {
                if ( isalive( guy ) )
                {
                    guy clearforcedgoal();
                    guy cleargoalvolume();
                    guy setgoal( var_a2d2b3b );
                }
            }
            
            level.ai_hendricks clearforcedgoal();
            level.ai_hendricks cleargoalvolume();
            level.ai_hendricks setgoal( ally_volume );
            break;
        }
        
        wait 0.1;
    }
    
    ally_volume = getent( "temple_ally_gv_03", "targetname" );
    var_a2d2b3b = getent( "temple_axis_gv_03", "targetname" );
    
    while ( true )
    {
        if ( isdefined( var_1044cded ) && var_1044cded && i >= 3 )
        {
            break;
        }
        
        guys_left = getaiteamarray( "axis" );
        
        if ( isdefined( guys_left ) && guys_left.size <= var_17994622.size * 0.6 )
        {
            foreach ( guy in guys_left )
            {
                if ( isalive( guy ) )
                {
                    guy clearforcedgoal();
                    guy cleargoalvolume();
                    guy setgoal( var_a2d2b3b );
                }
            }
            
            level.ai_hendricks clearforcedgoal();
            level.ai_hendricks cleargoalvolume();
            level.ai_hendricks setgoal( ally_volume );
            break;
        }
        
        wait 0.1;
    }
    
    ally_volume = getent( "temple_ally_gv_04", "targetname" );
    var_a2d2b3b = getent( "temple_axis_gv_04", "targetname" );
    
    while ( true )
    {
        guys_left = getaiteamarray( "axis" );
        
        if ( isdefined( guys_left ) && guys_left.size <= var_17994622.size * 0.4 )
        {
            foreach ( guy in guys_left )
            {
                if ( isalive( guy ) )
                {
                    guy clearforcedgoal();
                    guy cleargoalvolume();
                    guy setgoal( var_a2d2b3b );
                }
            }
            
            level.ai_hendricks clearforcedgoal();
            level.ai_hendricks cleargoalvolume();
            level.ai_hendricks setgoal( ally_volume );
            break;
        }
        
        wait 0.1;
    }
    
    while ( true )
    {
        guys_left = getaiteamarray( "axis" );
        
        if ( isdefined( guys_left ) && guys_left.size <= var_17994622.size * 0.2 )
        {
            foreach ( guy in guys_left )
            {
                if ( isdefined( guy ) && isalive( guy ) )
                {
                    if ( isvehicle( guy ) )
                    {
                        temple_wasp_retreat_nodes = struct::get_array( "temple_wasp_retreat_nodes", "targetname" );
                        node = array::random( temple_wasp_retreat_nodes );
                        guy thread vengeance_util::delete_ai_at_path_end( node );
                    }
                    
                    node = getnodearraysorted( "temple_retreat_nodes", "targetname", guy.origin, 4096 );
                    
                    if ( isdefined( node[ 0 ] ) )
                    {
                        if ( guy ai::has_behavior_attribute( "sprint" ) )
                        {
                            guy ai::set_behavior_attribute( "sprint", 1 );
                        }
                        
                        guy thread vengeance_util::delete_ai_at_path_end( node[ 0 ] );
                        continue;
                    }
                    
                    a_ai = array( guy );
                    level thread vengeance_util::delete_ai_when_out_of_sight( a_ai, 1024 );
                }
            }
            
            level flag::set( "combat_enemies_retreating" );
            level flag::set( "disable_temple_robot_triggers" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace vengeance_temple
// Params 1
// Checksum 0x118cdb95, Offset: 0x3238
// Size: 0x79, Type: bool
function function_f1c7b73f( trigger )
{
    foreach ( player in getplayers() )
    {
        if ( !player istouching( trigger ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace vengeance_temple
// Params 2
// Checksum 0x5f653d36, Offset: 0x32c0
// Size: 0xf2
function function_620fbb8a( raw\italian\sound\vox\scripted\pla\vox_pla_kls_cobra_enemy_03.SN65.xenon.snd, e_volume )
{
    a_ai = [];
    
    foreach ( ai in raw\italian\sound\vox\scripted\pla\vox_pla_kls_cobra_enemy_03.SN65.xenon.snd )
    {
        if ( isdefined( ai ) && isalive( ai ) && ai istouching( e_volume ) )
        {
            if ( !isdefined( a_ai ) )
            {
                a_ai = [];
            }
            else if ( !isarray( a_ai ) )
            {
                a_ai = array( a_ai );
            }
            
            a_ai[ a_ai.size ] = ai;
        }
    }
    
    level thread vengeance_util::delete_ai_when_out_of_sight( a_ai, 512 );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x40c4703, Offset: 0x33c0
// Size: 0x142
function temple_vo()
{
    level endon( #"stealth_discovered" );
    level.ai_hendricks endon( #"death" );
    level waittill( #"temple_vo" );
    
    foreach ( player in level.activeplayers )
    {
        player thread vengeance_util::function_51caee84( "temple_end" );
    }
    
    level flag::set( "show_temple_gather" );
    stealth::function_26f24c93( 1 );
    flag::wait_till( "tmeple_stealth_motivator_01" );
    vengeance_util::function_ee75acde( "hend_stick_to_the_shadows_0" );
    flag::wait_till( "tmeple_stealth_motivator_02" );
    vengeance_util::function_ee75acde( "hend_lots_of_movement_dow_1" );
    flag::wait_till( "tmeple_stealth_motivator_03" );
    vengeance_util::function_ee75acde( "hend_keep_moving_they_ha_0" );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x1987bf63, Offset: 0x3510
// Size: 0x1a2
function function_a86ac59d()
{
    level endon( #"temple_end" );
    level flag::wait_till( "stealth_discovered" );
    array::thread_all( getaiteamarray( "axis" ), &function_329c89f );
    level thread vengeance_util::function_e6399870( "temple_molotov_trigger", "script_noteworthy", 2 );
    level flag::set( "enable_temple_robot_triggers" );
    var_b264f09 = getentarray( "temple_robot_trigger", "targetname" );
    array::thread_all( var_b264f09, &function_dd797045 );
    stealth::function_26f24c93( 0 );
    level thread vengeance_util::function_80840124( &function_e4612dd6 );
    level thread function_578145a3();
    
    while ( true )
    {
        guys = getaiteamarray( "axis" );
        
        if ( isdefined( guys ) && guys.size <= 0 || !isdefined( guys ) )
        {
            break;
        }
        
        wait 0.1;
    }
    
    objectives::complete( "cp_level_vengeance_support", level.ai_hendricks );
    level flag::clear( "stealth_discovered" );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xbd4b3ea, Offset: 0x36c0
// Size: 0x12
function function_329c89f()
{
    self stopsounds();
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x127d0931, Offset: 0x36e0
// Size: 0x451
function function_dd797045()
{
    level endon( #"temple_end" );
    level endon( #"disable_temple_robot_triggers" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger" );
        guys = getaiteamarray( "axis" );
        guys = array::remove_dead( guys );
        
        if ( guys.size > 37 )
        {
            wait 2;
            continue;
        }
        
        volume = getent( self.target + "_volume", "targetname" );
        
        if ( isdefined( volume ) )
        {
            robots = getentarray( self.target, "targetname" );
            
            foreach ( robot in robots )
            {
                robot.ignoreall = 1;
                robot.ignoreme = 1;
            }
            
            doors = getentarray( "temple_spawn_closet_door", "targetname" );
            
            foreach ( door in doors )
            {
                var_6c37ffe1 = self.target + "_closet";
                
                if ( isdefined( door.script_noteworthy ) && door.script_noteworthy == var_6c37ffe1 )
                {
                    temple_spawn_closet_door = door;
                    break;
                }
            }
            
            var_d17d5da5 = getentarray( "temple_spawn_closet_door_clip", "targetname" );
            
            foreach ( clip in var_d17d5da5 )
            {
                var_35f2b287 = self.target + "_closet";
                
                if ( isdefined( clip.script_noteworthy ) && clip.script_noteworthy == var_35f2b287 )
                {
                    temple_spawn_closet_door_clip = clip;
                    break;
                }
            }
            
            var_6e15ff70 = getentarray( "temple_spawn_closet_door_pathing_clip", "targetname" );
            
            foreach ( clip in var_6e15ff70 )
            {
                var_35f2b287 = self.target + "_closet";
                
                if ( isdefined( clip.script_noteworthy ) && clip.script_noteworthy == var_35f2b287 )
                {
                    temple_spawn_closet_door_pathing_clip = clip;
                    break;
                }
            }
            
            if ( isdefined( temple_spawn_closet_door ) && isdefined( temple_spawn_closet_door_clip ) )
            {
                temple_spawn_closet_door_clip linkto( temple_spawn_closet_door );
            }
            
            if ( isdefined( temple_spawn_closet_door ) )
            {
                temple_spawn_closet_door rotateto( temple_spawn_closet_door.angles + ( 0, 90, 0 ), 1 );
            }
            
            wait 0.5;
            
            if ( isdefined( temple_spawn_closet_door_pathing_clip ) )
            {
                temple_spawn_closet_door_pathing_clip notsolid();
                wait 0.05;
                temple_spawn_closet_door_pathing_clip connectpaths();
            }
            
            foreach ( robot in robots )
            {
                if ( isalive( robot ) )
                {
                    robot.ignoreall = 0;
                    robot.ignoreme = 0;
                }
            }
            
            self triggerenable( 0 );
            break;
        }
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x790e0c4b, Offset: 0x3b40
// Size: 0xb2
function function_e4612dd6()
{
    level endon( #"temple_end" );
    level.ai_hendricks battlechatter::function_d9f49fba( 0 );
    var_eb6e35ef = [];
    var_eb6e35ef[ 0 ] = "hend_shifting_positions_0";
    var_eb6e35ef[ 1 ] = "hend_i_m_dropping_down_to_0";
    line = array::random( var_eb6e35ef );
    vengeance_util::function_ee75acde( line );
    vengeance_util::function_ee75acde( "hend_if_we_can_clear_the_0", 4 );
    level thread namespace_9fd035::function_14592f48();
    level.ai_hendricks battlechatter::function_d9f49fba( 1 );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x3c00
// Size: 0x2
function function_1a289333()
{
    
}

// Namespace vengeance_temple
// Params 4
// Checksum 0xb94c0cc7, Offset: 0x3c10
// Size: 0x6a
function skipto_temple_done( str_objective, b_starting, b_direct, player )
{
    level flag::set( "temple_end" );
    level thread cleanup_temple();
    level struct::delete_script_bundle( "scene", "cin_ven_hanging_body_loop_vign_civ07_ropeshort" );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xcde90cce, Offset: 0x3c88
// Size: 0xeb
function cleanup_temple()
{
    if ( isdefined( level.temple_patroller_spawners ) )
    {
        foreach ( enemy in level.temple_patroller_spawners )
        {
            if ( isdefined( enemy ) )
            {
                enemy stealth_status::function_180adb28();
                enemy delete();
            }
        }
    }
    
    if ( isdefined( level.temple_wasps ) )
    {
        foreach ( enemy in level.temple_wasps )
        {
            if ( isdefined( enemy ) )
            {
                enemy delete();
            }
        }
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xf8d3d09b, Offset: 0x3d80
// Size: 0x4a
function setup_breakable_garden_windows()
{
    breakable_garden_windows = getentarray( "breakable_garden_window", "targetname" );
    array::thread_all( breakable_garden_windows, &breakable_garden_window_watcher );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x89ecc768, Offset: 0x3dd8
// Size: 0x91
function breakable_garden_window_watcher()
{
    self setcandamage( 1 );
    self.health = 10;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker );
        
        if ( isdefined( attacker ) && isplayer( attacker ) && isdefined( damage ) )
        {
            self.health = self.health - damage;
            
            if ( self.health <= 0 )
            {
                self delete();
                break;
            }
        }
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xd1c755c8, Offset: 0x3e78
// Size: 0x29a
function dogleg_2_intro_trigger()
{
    dogleg_2_intro_obj_struct = struct::get( "dogleg_2_intro_obj_struct" );
    
    if ( isdefined( dogleg_2_intro_obj_struct ) )
    {
        objectives::set( "cp_level_vengeance_goto_dogleg_2", dogleg_2_intro_obj_struct );
    }
    
    objectives::hide( "cp_level_vengeance_goto_dogleg_2" );
    level flag::wait_till_any( array( "show_temple_gather", "stealth_discovered" ) );
    objectives::show( "cp_level_vengeance_goto_dogleg_2" );
    dogleg_2_intro_trigger = getent( "dogleg_2_intro_trigger", "script_noteworthy" );
    
    if ( isdefined( dogleg_2_intro_trigger ) )
    {
        level thread vengeance_util::stealth_combat_toggle_trigger_and_objective( dogleg_2_intro_trigger, "cp_level_vengeance_goto_dogleg_2", undefined, "all_players_at_temple_exit", "cp_level_vengeance_clear_area" );
    }
    
    level flag::wait_till( "all_players_at_temple_exit" );
    objectives::hide( "cp_level_vengeance_goto_dogleg_2" );
    
    if ( level flag::get( "temple_stealth_broken" ) )
    {
        level flag::wait_till( "temple_hendricks_done" );
    }
    
    level.ai_hendricks thread vengeance_util::function_5fbec645( "hend_open_it_up_i_ll_cov_0" );
    level thread function_cf782b84();
    s_anim_node = struct::get( "tag_align_dogleg_2", "targetname" );
    s_anim_node thread scene::play( "cin_ven_05_65_deadcivilians_vign" );
    n_node = getnode( "hendricks_dogleg_2_stairs", "targetname" );
    level waittill( #"dogleg_2_entry_door_opening" );
    level thread function_29e96a35();
    
    if ( level flag::get( "temple_stealth_broken" ) )
    {
        level waittill( #"hash_9fb1ff75" );
        level.ai_hendricks setgoal( n_node, 1 );
    }
    else
    {
        wait 1.5;
        level thread function_37d4d605();
        s_anim_node scene::init( "cin_ven_05_70_dogleg2_takedown_vign" );
    }
    
    level flag::set( "dogleg_2_begin" );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x9a104cb1, Offset: 0x4120
// Size: 0xb2
function function_29e96a35()
{
    level.ai_hendricks notify( #"hash_6f33cd57" );
    level.ai_hendricks.var_5d9fbd2d = 0;
    
    if ( level flag::get( "temple_stealth_broken" ) )
    {
        level waittill( #"hash_9fb1ff75" );
        level.ai_hendricks dialog::say( "hend_you_sure_you_don_t_w_0" );
    }
    else
    {
        level waittill( #"hash_132639c7" );
        level.ai_hendricks dialog::say( "hend_you_sure_you_don_t_w_0", 1 );
    }
    
    level dialog::player_say( "plyr_not_a_chance_hendri_0" );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x181dc5f2, Offset: 0x41e0
// Size: 0x142
function function_38bcd0()
{
    e_trigger = getent( "dogleg_2_door_entry_trigger", "targetname" );
    e_trigger triggerenable( 0 );
    var_71678477 = getent( "dogleg_2_entry_door_lf", "targetname" );
    var_1d746940 = getent( var_71678477.target, "targetname" );
    var_1d746940 disconnectpaths();
    var_b8e4988b = getent( "dogleg_2_entry_door_rt", "targetname" );
    var_4a669fbc = getent( var_b8e4988b.target, "targetname" );
    var_4a669fbc disconnectpaths();
    var_35a1e4f8 = struct::get( "tag_align_dogleg_2_door", "targetname" );
    var_35a1e4f8 thread scene::init( "cin_ven_05_60_officedoor_1st" );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x342e5a24, Offset: 0x4330
// Size: 0x2ea
function function_cf782b84()
{
    e_trigger = getent( "dogleg_2_door_entry_trigger", "targetname" );
    e_trigger triggerenable( 1 );
    e_door_use_object = util::init_interactive_gameobject( e_trigger, &"cp_prompt_enter_ven_doors", &"CP_MI_SING_VENGEANCE_HINT_OPEN", &function_863781f2 );
    objectives::set( "cp_level_vengeance_open_dogleg_2_menu" );
    level notify( #"hash_479fadce" );
    var_71678477 = getent( "dogleg_2_entry_door_lf", "targetname" );
    var_1d746940 = getent( var_71678477.target, "targetname" );
    var_71678477.animname = "dogleg_2_entry_door_lf";
    var_71678477.old_angles = var_71678477.angles;
    var_71678477.old_origin = var_71678477.origin;
    var_b8e4988b = getent( "dogleg_2_entry_door_rt", "targetname" );
    var_4a669fbc = getent( var_b8e4988b.target, "targetname" );
    var_b8e4988b.animname = "dogleg_2_entry_door_rt";
    var_b8e4988b.old_angles = var_b8e4988b.angles;
    var_b8e4988b.old_origin = var_b8e4988b.origin;
    var_1d746940 linkto( var_71678477 );
    var_4a669fbc linkto( var_b8e4988b );
    level thread vengeance_util::stealth_combat_toggle_trigger_and_objective( e_trigger, undefined, "cp_level_vengeance_open_dogleg_2_menu", "dogleg_2_entry_door_opening", "cp_level_vengeance_clear_area", e_door_use_object );
    level waittill( #"dogleg_2_entry_door_opening" );
    e_door_use_object gameobjects::disable_object();
    objectives::hide( "cp_level_vengeance_open_dogleg_2_menu" );
    level waittill( #"hash_c4bb0520" );
    
    if ( !level flag::get( "temple_stealth_broken" ) )
    {
        var_71678477 stopanimscripted();
        var_71678477.angles = var_71678477.old_angles;
        var_71678477.origin = var_71678477.old_origin;
        var_b8e4988b stopanimscripted();
        var_b8e4988b.angles = var_b8e4988b.old_angles;
        var_b8e4988b.origin = var_b8e4988b.old_origin;
        return;
    }
    
    var_1d746940 connectpaths();
    var_4a669fbc connectpaths();
}

// Namespace vengeance_temple
// Params 1
// Checksum 0x7a2b4a34, Offset: 0x4628
// Size: 0x137
function function_863781f2( e_player )
{
    level.var_67e1f60e = undefined;
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.var_b9e5210f ) )
        {
            player.var_b9e5210f = undefined;
        }
    }
    
    skipto::objective_completed( "temple" );
    var_35a1e4f8 = struct::get( "tag_align_dogleg_2_door", "targetname" );
    
    if ( level flag::get( "temple_stealth_broken" ) )
    {
        var_35a1e4f8 thread scene::play( "cin_ven_05_60_officedoor_1st", e_player );
    }
    else
    {
        vengeance_util::co_op_teleport_on_igc_end( "cin_ven_05_60_officedoor_1st_shared", "dogleg_2_entrance_teleport" );
        var_35a1e4f8 thread scene::play( "cin_ven_05_60_officedoor_1st_shared", e_player );
    }
    
    level notify( #"dogleg_2_entry_door_opening" );
    var_35a1e4f8 waittill( #"scene_done" );
    level notify( #"hash_9fb1ff75" );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x3290e9fe, Offset: 0x4768
// Size: 0xb3
function function_37d4d605()
{
    level waittill( #"hash_132639c7" );
    var_c13b7e2a = struct::get_array( "dogleg_2_glass_break", "targetname" );
    exploder::exploder( "dogleg_2_railing_break" );
    
    foreach ( var_d64f5bac in var_c13b7e2a )
    {
        glassradiusdamage( var_d64f5bac.origin, 38, -56, -81 );
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xa396525f, Offset: 0x4828
// Size: 0xbb
function function_ca660ef7()
{
    self endon( #"death" );
    level flag::wait_till( "stealth_discovered" );
    self.goalheight = 512;
    a_warlord_nodes = getnodearray( self.script_noteworthy, "targetname" );
    
    foreach ( node in a_warlord_nodes )
    {
        self warlordinterface::addpreferedpoint( node.origin, 4000, 8000 );
    }
}

// Namespace vengeance_temple
// Params 2
// Checksum 0xb676e246, Offset: 0x48f0
// Size: 0x4a
function function_ea758541( name, key )
{
    var_fc0a0636 = getentarray( name, key );
    array::thread_all( var_fc0a0636, &function_8f9d056c );
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xae84cb9c, Offset: 0x4948
// Size: 0xad
function function_3bb1295b()
{
    guys = getaiteamarray( "axis" );
    guys = arraysortclosest( guys, self.origin );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) && isalive( guy ) && isdefined( guy.lase_ent ) )
        {
            return guy;
        }
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0xab2d9e8b, Offset: 0x4a00
// Size: 0x5d
function function_8f9d056c()
{
    self endon( #"death" );
    level endon( #"stealth_discovered" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            self function_a1a65fdc( player );
        }
    }
}

// Namespace vengeance_temple
// Params 1
// Checksum 0x67c72fab, Offset: 0x4a68
// Size: 0x1fd
function function_a1a65fdc( player )
{
    player endon( #"death_or_disconnect" );
    
    if ( isdefined( player.var_15f789fb ) && player.var_15f789fb == self )
    {
        return;
    }
    
    var_c2918075 = gettime();
    
    if ( isdefined( player.var_496772e9 ) )
    {
        var_c2918075 = gettime() - player.var_496772e9;
    }
    
    var_d3e8dab = -1;
    
    if ( isdefined( player.var_18091778 ) )
    {
        var_d3e8dab = distancesquared( player.origin, player.var_18091778 );
    }
    
    player.var_15f789fb = self;
    player.var_496772e9 = gettime();
    player thread function_b321fac9( self );
    
    if ( var_c2918075 < 5000 && var_d3e8dab > 0 && var_d3e8dab > 10000 )
    {
        if ( !( isdefined( player.var_b9e5210f ) && player.var_b9e5210f ) )
        {
            var_2dd18bed = [];
            var_2dd18bed[ 0 ] = "hend_get_off_the_rooftops_0";
            var_2dd18bed[ 1 ] = "hend_stay_off_the_rooftop_0";
            var_2dd18bed[ 2 ] = "hend_they_re_going_to_spo_0";
            player thread vengeance_util::function_ee75acde( array::random( var_2dd18bed ), 0, undefined, player );
        }
        
        player.var_b9e5210f = 1;
        wait 4;
        
        if ( isdefined( player.var_15f789fb ) && !player istouching( player.var_15f789fb ) )
        {
            player.var_b9e5210f = 0;
            return;
        }
        
        guy = player function_3bb1295b();
        
        if ( isdefined( guy ) && isdefined( guy.lase_ent ) )
        {
            guy.lase_ent ai_sniper::function_b77b41d1( guy geteye(), player, guy );
        }
    }
}

// Namespace vengeance_temple
// Params 1
// Checksum 0xb7c543e6, Offset: 0x4c70
// Size: 0x65
function function_b321fac9( trigger )
{
    self notify( #"hash_b321fac9" );
    self endon( #"hash_b321fac9" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( self istouching( trigger ) )
        {
            self.var_18091778 = self.origin;
        }
        else
        {
            return;
        }
        
        wait 0.05;
    }
}

// Namespace vengeance_temple
// Params 0
// Checksum 0x1fdbbb9b, Offset: 0x4ce0
// Size: 0x6d, Type: bool
function function_591ead63()
{
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.var_b9e5210f ) && player.var_b9e5210f )
        {
            return false;
        }
    }
    
    return true;
}

