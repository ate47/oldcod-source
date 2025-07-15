#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/ai_sniper_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicles/_hunter;
#using scripts/shared/visionset_mgr_shared;

#namespace vengeance_util;

// Namespace vengeance_util
// Params 0, eflags: 0x2
// Checksum 0x33ecb15d, Offset: 0xd88
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "enemy_highlight", &function_c7e2a7f7, undefined, undefined );
}

// Namespace vengeance_util
// Params 0
// Checksum 0x1cc88228, Offset: 0xdc0
// Size: 0x2a
function function_c7e2a7f7()
{
    clientfield::register( "toplayer", "enemy_highlight", 1, 1, "int" );
}

// Namespace vengeance_util
// Params 3
// Checksum 0x46ceed4, Offset: 0xdf8
// Size: 0x19a
function init_hero( str_hero, str_objective, b_generic_start )
{
    hero = undefined;
    
    if ( str_hero == "hendricks" )
    {
        level.ai_hendricks = util::get_hero( "hendricks" );
        hero = level.ai_hendricks;
        level.ai_hendricks colors::set_force_color( "r" );
    }
    else if ( str_hero == "rachel" )
    {
        level.ai_rachel = util::get_hero( "rachel" );
        hero = level.ai_rachel;
        level.ai_rachel colors::set_force_color( "b" );
    }
    else
    {
        assertmsg( "<dev string:x28>" );
    }
    
    if ( isdefined( b_generic_start ) && b_generic_start )
    {
        skipto::teleport_ai( str_objective );
        return;
    }
    
    s_start = struct::get( str_objective + "_" + str_hero, "targetname" );
    
    if ( !isdefined( s_start ) )
    {
        assertmsg( "<dev string:x5c>" + str_hero + "<dev string:x73>" + str_objective + "<dev string:x83>" );
    }
    
    hero forceteleport( s_start.origin, s_start.angles, 1 );
}

// Namespace vengeance_util
// Params 0
// Checksum 0x287ff2f, Offset: 0xfa0
// Size: 0x1f
function player_count()
{
    a_players = getplayers();
    return a_players.size;
}

// Namespace vengeance_util
// Params 0
// Checksum 0x41d45f4f, Offset: 0xfc8
// Size: 0xe2
function setup_patroller()
{
    self endon( #"death" );
    
    if ( isdefined( self.target ) )
    {
        patroller_start_node = getnode( self.target, "targetname" );
    }
    
    if ( !isdefined( patroller_start_node ) )
    {
        nodes = getnodesinradiussorted( self.origin, 1000, 1, 1000, "Path" );
    }
    
    if ( isdefined( nodes ) && nodes.size > 0 )
    {
        patroller_start_node = nodes[ 0 ];
    }
    
    if ( isdefined( patroller_start_node ) )
    {
        self.patroller_start_node = patroller_start_node;
    }
    else
    {
        assert( !isdefined( patroller_start_node ), "<dev string:x85>" );
    }
    
    self thread ai_sniper::agent_init();
    self thread ai::patrol( self.patroller_start_node );
}

// Namespace vengeance_util
// Params 3
// Checksum 0x15f9940b, Offset: 0x10b8
// Size: 0x9a
function skipto_baseline( str_objective, b_starting, var_6a8d0f35 )
{
    if ( !isdefined( var_6a8d0f35 ) )
    {
        var_6a8d0f35 = 0;
    }
    
    if ( !isdefined( str_objective ) )
    {
        str_objective = "";
    }
    
    if ( !isdefined( b_starting ) )
    {
        b_starting = 1;
    }
    
    if ( b_starting )
    {
        loadsentienteventparameters( "sentientevents_vengeance_default" );
        stealth::init();
        cp_mi_sing_vengeance_sound::function_47d9d5db();
        
        if ( var_6a8d0f35 )
        {
            callback::on_spawned( &function_51caee84 );
        }
    }
}

// Namespace vengeance_util
// Params 3
// Checksum 0x6516500b, Offset: 0x1160
// Size: 0xb3
function enable_nodes( str_key, str_val, b_enable )
{
    if ( !isdefined( str_val ) )
    {
        str_val = "targetname";
    }
    
    if ( !isdefined( b_enable ) )
    {
        b_enable = 1;
    }
    
    a_nodes = getnodearray( str_key, str_val );
    
    foreach ( nd_node in a_nodes )
    {
        setenablenode( nd_node, b_enable );
    }
}

// Namespace vengeance_util
// Params 3
// Checksum 0xfc70fc5, Offset: 0x1220
// Size: 0x72
function magic_bullet_shield_till_notify( str_kill_mbs, b_disable_w_player_shot, str_phalanx_scatter_notify )
{
    self endon( #"death" );
    util::magic_bullet_shield( self );
    
    if ( b_disable_w_player_shot )
    {
        self thread stop_magic_bullet_shield_on_player_damage( str_kill_mbs, str_phalanx_scatter_notify );
    }
    
    util::waittill_any_ents( level, str_kill_mbs, self, str_kill_mbs );
    util::stop_magic_bullet_shield( self );
}

// Namespace vengeance_util
// Params 2
// Checksum 0xc4cef09f, Offset: 0x12a0
// Size: 0x7b
function stop_magic_bullet_shield_on_player_damage( str_kill_mbs, str_phalanx_scatter_notify )
{
    self endon( #"ram_kill_mb" );
    self endon( str_kill_mbs );
    level endon( str_kill_mbs );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( isplayer( attacker ) )
        {
            if ( isdefined( str_phalanx_scatter_notify ) )
            {
                level notify( str_phalanx_scatter_notify );
                wait 0.05;
                level notify( str_kill_mbs );
            }
            
            self notify( str_kill_mbs );
        }
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x326a6e8a, Offset: 0x1328
// Size: 0xf3
function fire_fx()
{
    level._effect[ "civ_burn_j_elbow_le_loop" ] = "fire/fx_fire_ai_human_arm_left_loop_mature";
    level._effect[ "civ_burn_j_elbow_ri_loop" ] = "fire/fx_fire_ai_human_arm_right_loop_mature";
    level._effect[ "civ_burn_j_shoulder_le_loop" ] = "fire/fx_fire_ai_human_arm_left_loop_mature";
    level._effect[ "civ_burn_j_shoulder_ri_loop" ] = "fire/fx_fire_ai_human_arm_right_loop_mature";
    level._effect[ "civ_burn_j_spine4_loop" ] = "fire/fx_fire_ai_human_torso_loop_mature";
    level._effect[ "civ_burn_j_hip_le_loop" ] = "fire/fx_fire_ai_human_hip_left_loop_mature";
    level._effect[ "civ_burn_j_hip_ri_loop" ] = "fire/fx_fire_ai_human_hip_right_loop_mature";
    level._effect[ "civ_burn_j_knee_le_loop" ] = "fire/fx_fire_ai_human_leg_left_loop_mature";
    level._effect[ "civ_burn_j_knee_ri_loop" ] = "fire/fx_fire_ai_human_leg_right_loop_mature";
    level._effect[ "civ_burn_j_head_loop" ] = "fire/fx_fire_ai_human_head_loop_mature";
}

// Namespace vengeance_util
// Params 1
// Checksum 0xfc2350fd, Offset: 0x1428
// Size: 0x4da
function set_civilian_on_fire( b_cointoss )
{
    if ( !isdefined( b_cointoss ) )
    {
        b_cointoss = 1;
    }
    
    self endon( #"death" );
    playfxontag( level._effect[ "civ_burn_j_spine4_loop" ], self, "J_Spine4" );
    
    if ( isdefined( b_cointoss ) && b_cointoss == 0 )
    {
        wait 0.5;
        playfxontag( level._effect[ "civ_burn_j_head_loop" ], self, "J_Head" );
        wait randomfloatrange( 0.1, 2 );
        playfxontag( level._effect[ "civ_burn_j_shoulder_le_loop" ], self, "J_Shoulder_LE" );
        playfxontag( level._effect[ "civ_burn_j_shoulder_ri_loop" ], self, "J_Shoulder_RI" );
        wait randomfloatrange( 0.1, 2 );
        playfxontag( level._effect[ "civ_burn_j_hip_le_loop" ], self, "J_Hip_LE" );
        playfxontag( level._effect[ "civ_burn_j_hip_ri_loop" ], self, "J_Hip_RI" );
        wait randomfloatrange( 0.1, 2 );
        playfxontag( level._effect[ "civ_burn_j_elbow_le_loop" ], self, "J_Elbow_LE" );
        playfxontag( level._effect[ "civ_burn_j_elbow_ri_loop" ], self, "J_Elbow_RI" );
        wait randomfloatrange( 0.1, 2 );
        playfxontag( level._effect[ "civ_burn_j_knee_le_loop" ], self, "J_Knee_LE" );
        playfxontag( level._effect[ "civ_burn_j_knee_ri_loop" ], self, "J_Knee_RI" );
        return;
    }
    
    wait randomfloatrange( 0.1, 2 );
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_elbow_le_loop" ], self, "J_Elbow_LE" );
    }
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_elbow_ri_loop" ], self, "J_Elbow_RI" );
    }
    
    wait randomfloatrange( 0.1, 2 );
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_shoulder_le_loop" ], self, "J_Shoulder_LE" );
    }
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_shoulder_ri_loop" ], self, "J_Shoulder_RI" );
    }
    
    wait randomfloatrange( 0.1, 2 );
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_hip_le_loop" ], self, "J_Hip_LE" );
    }
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_hip_ri_loop" ], self, "J_Hip_RI" );
    }
    
    wait randomfloatrange( 0.1, 2 );
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_knee_le_loop" ], self, "J_Knee_LE" );
    }
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_knee_ri_loop" ], self, "J_Knee_RI" );
    }
    
    wait randomfloatrange( 0.1, 2 );
    
    if ( math::cointoss() )
    {
        playfxontag( level._effect[ "civ_burn_j_head_loop" ], self, "J_Head" );
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x21863928, Offset: 0x1910
// Size: 0x1e3
function function_3f34106b()
{
    trigger::wait_till( "sh_bridge_explosion", "targetname" );
    var_d2d4d1ec = getentarray( "sh_bridge_clean", "targetname" );
    var_1c396b4f = struct::get( "sh_missile_strike_start", "targetname" );
    var_83e914f = struct::get( "sh_missile_strike_end", "targetname" );
    fx_model = util::spawn_model( "tag_origin", var_1c396b4f.origin, var_1c396b4f.angles );
    fx_model fx::play( "fx_trail_missile_vista_veng", fx_model.origin, fx_model.angles, undefined, 1, "tag_origin", 1 );
    fx_model moveto( var_83e914f.origin, 0.75 );
    wait 0.75;
    playsoundatposition( "evt_bridge_explosion", fx_model.origin );
    fx_model delete();
    exploder::exploder( "sh_vista_bridge_explosion" );
    exploder::exploder( "sh_vista_bridge_fire" );
    
    foreach ( e_ent in var_d2d4d1ec )
    {
        e_ent delete();
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0xee3f209d, Offset: 0x1b00
// Size: 0x9b
function function_936cf9d0()
{
    var_d2d4d1ec = getentarray( "sh_bridge_clean", "targetname" );
    exploder::exploder( "sh_vista_bridge_fire" );
    
    foreach ( e_ent in var_d2d4d1ec )
    {
        e_ent delete();
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x846134cc, Offset: 0x1ba8
// Size: 0x153
function function_ef909043()
{
    var_9c327190 = getentarray( "sh_corner_clean", "targetname" );
    var_a4ff1499 = getentarray( "sh_corner_destroy", "targetname" );
    
    foreach ( e_ent in var_a4ff1499 )
    {
        e_ent hide();
    }
    
    trigger::wait_till( "sh_corner_explosion", "targetname" );
    exploder::exploder( "sh_corner_plaza_explosion" );
    wait 0.15;
    array::delete_all( var_9c327190 );
    
    foreach ( e_ent in var_a4ff1499 )
    {
        e_ent show();
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0xb01339dc, Offset: 0x1d08
// Size: 0x3a
function function_6bd25628()
{
    var_9c327190 = getentarray( "sh_corner_clean", "targetname" );
    array::delete_all( var_9c327190 );
}

// Namespace vengeance_util
// Params 0
// Checksum 0xdc255d46, Offset: 0x1d50
// Size: 0x9b
function refill_ammo()
{
    a_w_weapons = self getweaponslist();
    
    foreach ( w_weapon in a_w_weapons )
    {
        self givemaxammo( w_weapon );
        self setweaponammoclip( w_weapon, w_weapon.clipsize );
    }
}

// Namespace vengeance_util
// Params 7
// Checksum 0x67195eb3, Offset: 0x1df8
// Size: 0x1d2
function stealth_combat_toggle_trigger_and_objective( e_trigger, str_objective, var_ae801398, str_ender, var_65611d69, e_door_use_object, trigger_flag )
{
    e_trigger endon( #"death" );
    
    if ( isdefined( str_ender ) )
    {
        level endon( str_ender );
    }
    
    level flag::wait_till( "stealth_discovered" );
    e_trigger triggerenable( 0 );
    
    if ( isdefined( str_objective ) )
    {
        objectives::hide( str_objective );
    }
    
    if ( isdefined( var_ae801398 ) )
    {
        objectives::hide( var_ae801398 );
    }
    
    if ( isdefined( var_65611d69 ) )
    {
        objectives::set( var_65611d69 );
    }
    
    if ( isdefined( e_door_use_object ) )
    {
        e_door_use_object gameobjects::disable_object();
    }
    
    level flag::wait_till_clear( "stealth_discovered" );
    
    if ( isdefined( e_door_use_object ) && level.skipto_point === "temple" )
    {
        level flag::clear( "all_players_at_temple_exit" );
        objectives::show( "cp_level_vengeance_goto_dogleg_2" );
        level flag::wait_till( "all_players_at_temple_exit" );
        objectives::hide( "cp_level_vengeance_goto_dogleg_2" );
    }
    
    e_trigger triggerenable( 1 );
    
    if ( isdefined( var_65611d69 ) )
    {
        objectives::hide( var_65611d69 );
    }
    
    if ( isdefined( str_objective ) )
    {
        objectives::show( str_objective );
    }
    
    if ( isdefined( var_ae801398 ) )
    {
        objectives::show( var_ae801398 );
    }
    
    if ( isdefined( e_door_use_object ) )
    {
        e_door_use_object gameobjects::enable_object();
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x81eb6229, Offset: 0x1fd8
// Size: 0x25
function function_7c486b8c()
{
    self endon( #"death" );
    self waittillmatch( #"hash_d501c77c" );
    self.var_d501c77c = 1;
    self.var_2d1c9600 = undefined;
}

// Namespace vengeance_util
// Params 0
// Checksum 0xd7b8d949, Offset: 0x2008
// Size: 0x1e
function function_1095f52e()
{
    self endon( #"death" );
    self waittillmatch( #"hash_7bbfb522" );
    self.var_2d1c9600 = 1;
}

// Namespace vengeance_util
// Params 1
// Checksum 0x71c932b, Offset: 0x2030
// Size: 0x16b
function function_1ed65aa( a_objects )
{
    foreach ( e_obj in a_objects )
    {
        if ( !isdefined( e_obj ) )
        {
            continue;
        }
        
        e_obj thread function_7c486b8c();
        e_obj thread function_1095f52e();
    }
    
    self util::waittill_any( "death" );
    
    foreach ( e_obj in a_objects )
    {
        if ( !isdefined( e_obj ) )
        {
            continue;
        }
        
        if ( isdefined( e_obj.var_d501c77c ) && e_obj.var_d501c77c == 1 )
        {
            continue;
        }
        
        if ( isdefined( e_obj.var_2d1c9600 ) && e_obj.var_2d1c9600 == 1 )
        {
            e_obj stopanimscripted();
            e_obj physicslaunch( e_obj.origin, ( 0, 0, 0.1 ) );
            continue;
        }
        
        e_obj delete();
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0x1ee95a6a, Offset: 0x21a8
// Size: 0x173
function function_7122594d( a_objects )
{
    foreach ( e_obj in a_objects )
    {
        if ( !isdefined( e_obj ) )
        {
            continue;
        }
        
        e_obj thread function_7c486b8c();
        e_obj thread function_1095f52e();
    }
    
    self util::waittill_any( "death", "alert" );
    
    foreach ( e_obj in a_objects )
    {
        if ( !isdefined( e_obj ) )
        {
            continue;
        }
        
        if ( isdefined( e_obj.var_d501c77c ) && e_obj.var_d501c77c == 1 )
        {
            continue;
        }
        
        if ( isdefined( e_obj.var_2d1c9600 ) && e_obj.var_2d1c9600 == 1 )
        {
            e_obj stopanimscripted();
            e_obj physicslaunch( e_obj.origin, ( 0, 0, 0.1 ) );
            continue;
        }
        
        e_obj delete();
    }
}

// Namespace vengeance_util
// Params 3
// Checksum 0x300c4d0a, Offset: 0x2328
// Size: 0x8a
function function_57b69bd6( object, var_f0dc1d6d, var_a202d840 )
{
    if ( isdefined( var_f0dc1d6d ) )
    {
    }
    
    self util::waittill_any( "alert", "death", "fake_alert" );
    object unlink();
    
    if ( isdefined( var_f0dc1d6d ) )
    {
        wait 0.05;
    }
    
    object physicslaunch( object.origin, ( 0, 0, 0.1 ) );
}

// Namespace vengeance_util
// Params 1
// Checksum 0xf25318a6, Offset: 0x23c0
// Size: 0x3c
function function_394ba9b5( var_1ea83c75 )
{
    self util::waittill_any( "death", "alert" );
    
    if ( isdefined( var_1ea83c75 ) )
    {
        var_1ea83c75 notify( #"fake_alert" );
    }
}

// Namespace vengeance_util
// Params 3
// Checksum 0xf4a5814b, Offset: 0x2408
// Size: 0x75
function function_d468b73d( var_3390909e, a_ents, var_36ebf819 )
{
    self waittill( var_3390909e );
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent ) )
        {
            ent notify( var_36ebf819 );
        }
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x2fa82885, Offset: 0x2488
// Size: 0x51
function function_8ffbd7bf()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"alert", state );
        
        if ( isdefined( state ) && state == "combat" )
        {
            self ai::set_ignoreme( 0 );
            break;
        }
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0xd18c9a89, Offset: 0x24e8
// Size: 0x429
function function_75790dfc( str_objective )
{
    self endon( #"death" );
    self notify( #"end_movement_thread" );
    self endon( #"end_movement_thread" );
    self endon( #"alert" );
    self thread function_8ffbd7bf();
    constminsearchradius = 120;
    constmaxsearchradius = 800;
    minsearchradius = math::clamp( constminsearchradius, 0, self.goalradius );
    maxsearchradius = math::clamp( constmaxsearchradius, constminsearchradius, self.goalradius );
    halfheight = 400;
    innerspacing = 80;
    outerspacing = 50;
    maxgoaltimeout = 10;
    timeatsameposition = 2.5 + randomfloat( 1 );
    
    while ( true )
    {
        target = array::random( level.var_e418a31d );
        var_4b68b086 = ( self.origin[ 2 ] - target.origin[ 2 ] ) / 2;
        origin = target.origin + ( 0, 0, var_4b68b086 );
        queryresult = positionquery_source_navigation( origin, minsearchradius, maxsearchradius, halfheight, innerspacing, self, outerspacing );
        positionquery_filter_distancetogoal( queryresult, self );
        vehicle_ai::positionquery_filter_outofgoalanchor( queryresult );
        vehicle_ai::positionquery_filter_random( queryresult, 0, 10 );
        vehicle_ai::positionquery_postprocess_sortscore( queryresult );
        stayatgoal = timeatsameposition > 0.2;
        foundpath = 0;
        
        for ( i = 0; i < queryresult.data.size && !foundpath ; i++ )
        {
            goalpos = queryresult.data[ i ].origin;
            foundpath = self setvehgoalpos( goalpos, stayatgoal, 1 );
        }
        
        if ( foundpath )
        {
            self setlookatent( target );
            self setturrettargetent( target );
            msg = self util::waittill_any_timeout( maxgoaltimeout, "near_goal", "force_goal", "reached_end_node", "goal" );
            
            if ( stayatgoal )
            {
                if ( isdefined( target.script_noteworthy ) && target.script_noteworthy == "scan_location" )
                {
                    target.var_9ff2970a = getent( target.target, "targetname" );
                    self hunter_frontscanning( target.var_9ff2970a );
                }
                else
                {
                    if ( math::cointoss() )
                    {
                        level.var_93287d84 = arraysortclosest( level.var_93287d84, self.origin, 999, 512 );
                        
                        if ( isdefined( level.var_93287d84[ 0 ] ) )
                        {
                            self function_120671d3( level.var_93287d84[ 0 ] );
                        }
                    }
                    else
                    {
                        level.var_93287d84 = arraysortclosest( level.var_93287d84, self.origin, 999, 512 );
                        
                        if ( isdefined( level.var_93287d84[ 0 ] ) )
                        {
                            self function_6a382ad5( level.var_93287d84[ 0 ] );
                        }
                    }
                    
                    wait randomfloatrange( 0.5 * timeatsameposition, timeatsameposition );
                }
            }
            
            continue;
        }
        
        self clearturrettarget();
        self clearlookatent();
        wait 1;
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0xbf9b126b, Offset: 0x2920
// Size: 0x122
function function_120671d3( target )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"end_attack_thread" );
    self endon( #"alert" );
    self setlookatent( target );
    self setturrettargetent( target );
    self util::waittill_any_timeout( 2, "turret_on_target" );
    fire_time = 1.5 + randomfloat( 0.5 );
    self vehicle_ai::fire_for_time( fire_time );
    wait 1;
    
    if ( math::cointoss() )
    {
        fire_time = 1.5 + randomfloat( 0.5 );
        self vehicle_ai::fire_for_time( fire_time );
        wait 1;
    }
    
    self clearturrettarget();
    self clearlookatent();
}

// Namespace vengeance_util
// Params 1
// Checksum 0xe4a13749, Offset: 0x2a50
// Size: 0x152
function function_6a382ad5( target )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"end_attack_thread" );
    self endon( #"alert" );
    self setlookatent( target );
    self setturrettargetent( target );
    self util::waittill_any_timeout( 2, "turret_on_target" );
    self hunter::hunter_lockon_fx();
    wait 1;
    randomrange = 20;
    offset = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        offset[ i ] = ( randomfloatrange( randomrange * -1, randomrange ), randomfloatrange( randomrange * -1, randomrange ), randomfloatrange( randomrange * -1, randomrange ) );
    }
    
    self hunter::hunter_fire_one_missile( 0, target, offset[ 0 ], 1, 0.8 );
    wait 0.25;
    self hunter::hunter_fire_one_missile( 1, target, offset[ 1 ] );
    wait 1;
    self clearlookatent();
}

// Namespace vengeance_util
// Params 0
// Checksum 0xa4cd81f2, Offset: 0x2bb0
// Size: 0x13a
function hunter_scanner_init()
{
    self.frontscanner = spawn( "script_model", self gettagorigin( "tag_aim" ) );
    self.frontscanner setmodel( "tag_origin" );
    self.frontscanner.angles = self gettagangles( "tag_aim" );
    self.frontscanner linkto( self, "tag_aim" );
    self.frontscanner.owner = self;
    self.frontscanner.hastargetent = 0;
    self.frontscanner.sndscanningent = spawn( "script_origin", self.frontscanner.origin + anglestoforward( self.angles ) * 1000 );
    self.frontscanner.sndscanningent linkto( self.frontscanner );
}

// Namespace vengeance_util
// Params 0
// Checksum 0xc5ffa4f1, Offset: 0x2cf8
// Size: 0x6a
function function_45f7a75b()
{
    self hunter_scanner_clearlooktarget();
    
    if ( isdefined( self.frontscanner ) )
    {
        if ( isdefined( self.frontscanner.sndscanningent ) )
        {
            self.frontscanner.sndscanningent delete();
        }
        
        self.frontscanner delete();
    }
}

// Namespace vengeance_util
// Params 2
// Checksum 0x8705b823, Offset: 0x2d70
// Size: 0x6a
function hunter_scanner_settargetentity( targetent, offset )
{
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    if ( isdefined( targetent ) )
    {
        self.frontscanner.targetent = targetent;
        self.frontscanner.hastargetent = 1;
        self setgunnertargetent( self.frontscanner.targetent, offset, 2 );
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x905cd448, Offset: 0x2de8
// Size: 0x22
function hunter_scanner_clearlooktarget()
{
    self.frontscanner.hastargetent = 0;
    self cleargunnertarget( 2 );
}

// Namespace vengeance_util
// Params 1
// Checksum 0x2586408a, Offset: 0x2e18
// Size: 0x42
function hunter_scanner_settargetposition( targetpos )
{
    if ( isdefined( targetpos ) )
    {
        self.frontscanner.targetpos = targetpos;
        self setgunnertargetvec( self.frontscanner.targetpos, 2 );
    }
}

// Namespace vengeance_util
// Params 2
// Checksum 0xc229f0a7, Offset: 0x2e68
// Size: 0xe6
function is_point_in_view( point, do_trace )
{
    if ( !isdefined( point ) )
    {
        return 0;
    }
    
    scanner = self.frontscanner;
    vector_to_point = point - scanner.origin;
    in_view = lengthsquared( vector_to_point ) <= 1024 * 1024;
    
    if ( in_view )
    {
        in_view = util::within_fov( scanner.origin, scanner.angles, point, cos( 35 ) );
    }
    
    if ( isdefined( do_trace ) && in_view && do_trace && isdefined( self.enemy ) )
    {
        in_view = sighttracepassed( scanner.origin, point, 0, self.enemy );
    }
    
    return in_view;
}

// Namespace vengeance_util
// Params 2
// Checksum 0xd7a01981, Offset: 0x2f58
// Size: 0xcb
function is_valid_target( target, do_trace )
{
    target_is_valid = 1;
    
    if ( isdefined( target.ignoreme ) && target.ignoreme || target.health <= 0 )
    {
        target_is_valid = 0;
    }
    else if ( target isnotarget() || issentient( target ) && target ai::is_dead_sentient() )
    {
        target_is_valid = 0;
    }
    else if ( isdefined( target.origin ) && !is_point_in_view( target.origin, do_trace ) )
    {
        target_is_valid = 0;
    }
    
    return target_is_valid;
}

// Namespace vengeance_util
// Params 1
// Checksum 0xd2f56138, Offset: 0x3030
// Size: 0xd7
function get_enemies_in_view( do_trace )
{
    validenemyarray = [];
    enemyarray = getenemyarray( 1, 1 );
    
    foreach ( enemy in enemyarray )
    {
        if ( is_valid_target( enemy, do_trace ) )
        {
            if ( !isdefined( validenemyarray ) )
            {
                validenemyarray = [];
            }
            else if ( !isarray( validenemyarray ) )
            {
                validenemyarray = array( validenemyarray );
            }
            
            validenemyarray[ validenemyarray.size ] = enemy;
        }
    }
    
    return validenemyarray;
}

// Namespace vengeance_util
// Params 2
// Checksum 0x9fb4b3e8, Offset: 0x3110
// Size: 0xb6
function getenemyarray( include_ai, include_player )
{
    enemyarray = [];
    enemy_team = "allies";
    
    if ( isdefined( include_ai ) && include_ai )
    {
        aiarray = getaiteamarray( enemy_team );
        enemyarray = arraycombine( enemyarray, aiarray, 0, 0 );
    }
    
    if ( isdefined( include_player ) && include_player )
    {
        playerarray = getplayers( enemy_team );
        enemyarray = arraycombine( enemyarray, playerarray, 0, 0 );
    }
    
    return enemyarray;
}

// Namespace vengeance_util
// Params 1
// Checksum 0x5c1cae3a, Offset: 0x31d0
// Size: 0x1f2
function hunter_frontscanning( scanent )
{
    self endon( #"death_shut_off" );
    self endon( #"crash_done" );
    self endon( #"death" );
    self endon( #"end_movement_thread" );
    self endon( #"alert" );
    self hunter_scanner_init();
    var_c04ea392 = 0;
    var_161ae6a0 = 6;
    
    while ( var_c04ea392 < var_161ae6a0 )
    {
        if ( !isdefined( self.enemy ) )
        {
            self.frontscanner.sndscanningent playloopsound( "veh_hunter_scanner_loop", 1 );
            
            /#
                line( self gettagorigin( "<dev string:xae>" ), scanent.origin, ( 0, 1, 0 ), 1, 3 );
            #/
            
            offset = scanent.origin + ( randomfloatrange( 0, 40 ), randomfloatrange( 0, 40 ), randomfloatrange( 0, 40 ) );
            enemies = get_enemies_in_view( 1 );
            
            if ( enemies.size > 0 )
            {
                closest_enemy = arraygetclosest( self.origin, enemies );
                self.favoriteenemy = closest_enemy;
            }
        }
        else
        {
            if ( self hunter::is_point_in_view( self.enemy.origin, 1 ) )
            {
                self notify( #"hunter_lockontargetinsight" );
            }
            else
            {
                self notify( #"hunter_lockontargetoutsight" );
            }
            
            self.frontscanner.sndscanningent stoploopsound( 1 );
        }
        
        wait 0.1;
        var_c04ea392 += 0.1;
    }
    
    self function_45f7a75b();
}

// Namespace vengeance_util
// Params 3
// Checksum 0x81475347, Offset: 0x33d0
// Size: 0x75
function function_ab876b5a( video, start_notify, end_notify )
{
    level endon( #"hash_92bd0e81" );
    
    while ( true )
    {
        level waittill( start_notify );
        videostop( video );
        wait 3;
        videostart( video, 1 );
        level waittill( end_notify );
        videostop( video );
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x8a5528d0, Offset: 0x3450
// Size: 0x6a
function function_cc6f3598()
{
    trigger::wait_till( "temple_video" );
    videostop( "cp_vengeance_env_sign_dragon01" );
    wait 1;
    videostart( "cp_vengeance_env_sign_dragon01", 1 );
    level waittill( #"hash_42cabc57" );
    videostop( "cp_vengeance_env_sign_dragon01" );
}

// Namespace vengeance_util
// Params 0
// Checksum 0xc8b6b40e, Offset: 0x34c8
// Size: 0x62
function function_5dbf4126()
{
    videostop( "cp_vengeance_env_sign_parking01" );
    wait 1;
    videostart( "cp_vengeance_env_sign_parking01", 1 );
    level flag::wait_till( "plaza_cleared" );
    videostop( "cp_vengeance_env_sign_parking01" );
}

// Namespace vengeance_util
// Params 0
// Checksum 0xf0ff5ee7, Offset: 0x3538
// Size: 0xd3, Type: bool
function function_6bdeeb80()
{
    a_players = [];
    
    if ( isdefined( level.stealth.seek ) )
    {
        foreach ( ent in level.stealth.seek )
        {
            if ( isplayer( ent ) )
            {
                if ( !isdefined( a_players ) )
                {
                    a_players = [];
                }
                else if ( !isarray( a_players ) )
                {
                    a_players = array( a_players );
                }
                
                a_players[ a_players.size ] = ent;
            }
        }
    }
    
    return a_players.size >= 1;
}

// Namespace vengeance_util
// Params 0
// Checksum 0x43d28b22, Offset: 0x3618
// Size: 0x132
function function_76bdbf62()
{
    self endon( #"death" );
    self.team = "allies";
    self.civilian = 1;
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "panic", 0 );
    self.health = 1;
    
    if ( isdefined( self.script_linkto ) )
    {
        trigger = getent( self.script_linkto, "script_linkname" );
        
        if ( isdefined( trigger ) )
        {
            trigger::wait_till( trigger );
        }
    }
    
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    
    if ( isdefined( self.target ) )
    {
        node = getnode( self.target, "targetname" );
        self setgoal( node, 0, node.radius );
    }
    
    self ai::set_behavior_attribute( "panic", 1 );
}

// Namespace vengeance_util
// Params 4
// Checksum 0x48618180, Offset: 0x3758
// Size: 0x12a
function delete_ai_at_path_end( node, should_die, var_37730a64, distance )
{
    self endon( #"death" );
    self clearforcedgoal();
    self cleargoalvolume();
    self.goalradius = 32;
    self setgoal( node.origin, 1 );
    
    if ( isdefined( var_37730a64 ) && var_37730a64 == 1 )
    {
        result = self util::waittill_any( "goal", "near_goal", "bad_path" );
    }
    else
    {
        result = self util::waittill_any_timeout( 15, "goal", "near_goal", "bad_path" );
    }
    
    if ( result == "goal" || isdefined( result ) && result == "near_goal" )
    {
        delete_ai( self, should_die, distance );
        return;
    }
    
    delete_ai( self, undefined, distance );
}

// Namespace vengeance_util
// Params 3
// Checksum 0x4d3e417a, Offset: 0x3890
// Size: 0x72
function delete_ai( ai, should_die, distance )
{
    if ( isdefined( should_die ) && should_die )
    {
        ai kill();
        return;
    }
    
    a_ai = array( ai );
    level thread delete_ai_when_out_of_sight( a_ai, distance );
}

// Namespace vengeance_util
// Params 2
// Checksum 0x2e60e847, Offset: 0x3910
// Size: 0x157
function delete_ai_when_out_of_sight( a_ai, n_dist )
{
    if ( !isdefined( a_ai ) )
    {
        return;
    }
    
    n_off_screen_dot = 0.75;
    
    if ( !isdefined( n_dist ) )
    {
        n_dist = 512;
    }
    
    while ( a_ai.size > 0 )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            if ( !isdefined( a_ai[ i ] ) || !isalive( a_ai[ i ] ) )
            {
                arrayremovevalue( a_ai, a_ai[ i ] );
                continue;
            }
            
            if ( players_within_distance( n_dist, a_ai[ i ].origin ) )
            {
                continue;
            }
            
            if ( any_player_looking_at( a_ai[ i ].origin + ( 0, 0, 48 ), n_off_screen_dot, 1 ) )
            {
                continue;
            }
            
            if ( !( isdefined( a_ai[ i ].allowdeath ) && a_ai[ i ].allowdeath ) )
            {
                a_ai[ i ] util::stop_magic_bullet_shield();
            }
            
            a_ai[ i ] delete();
            arrayremovevalue( a_ai, a_ai[ i ] );
        }
        
        wait 1;
    }
}

// Namespace vengeance_util
// Params 2
// Checksum 0x13dfdbe6, Offset: 0x3a70
// Size: 0x6a, Type: bool
function players_within_distance( n_dist, v_org )
{
    n_dist_squared = n_dist * n_dist;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( distancesquared( v_org, level.players[ i ].origin ) < n_dist_squared )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vengeance_util
// Params 4
// Checksum 0x81ff722d, Offset: 0x3ae8
// Size: 0x68, Type: bool
function any_player_looking_at( v_org, n_dot, b_dot_only, e_ignore )
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] util::is_player_looking_at( v_org, n_dot, b_dot_only, e_ignore ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vengeance_util
// Params 1
// Checksum 0x4081ca36, Offset: 0x3b58
// Size: 0x13d
function function_80840124( var_f5d7a3f )
{
    level notify( #"hash_bab8795" );
    level endon( #"hash_bab8795" );
    var_17994622 = getaiteamarray( "axis" );
    var_60aeac6b = [];
    var_60aeac6b[ 0 ] = "hend_damn_they_re_onto_u_1";
    var_60aeac6b[ 1 ] = "hend_damn_they_know_we_r_0";
    var_60aeac6b[ 2 ] = "hend_shit_go_hot_they_r_0";
    line = array::random( var_60aeac6b );
    level function_ee75acde( line );
    
    if ( isdefined( var_f5d7a3f ) )
    {
        [[ var_f5d7a3f ]]();
    }
    
    wait 3;
    
    while ( true )
    {
        if ( level flag::get( "combat_enemies_retreating" ) )
        {
            level flag::clear( "combat_enemies_retreating" );
            break;
        }
        
        guys_left = getaiteamarray( "axis" );
        util::wait_endon( randomfloatrange( 15, 20 ), "combat_enemies_retreating" );
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x4a268f21, Offset: 0x3ca0
// Size: 0x35
function function_ee78c834()
{
    while ( true )
    {
        if ( isdefined( self.crashing ) && self.crashing == 1 )
        {
            level notify( #"hash_fec3c49" );
            break;
        }
        
        wait 1;
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0xbed66724, Offset: 0x3ce0
// Size: 0x8a
function function_12a1b6a0()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    weap = getweapon( "ar_marksman_veng_hero_weap" );
    
    while ( true )
    {
        if ( self getcurrentweapon() == weap )
        {
            break;
        }
        
        wait 0.05;
    }
    
    self waittill( #"weapon_change_complete", w_current );
    self thread function_51caee84( "dogleg_1_end" );
}

// Namespace vengeance_util
// Params 1
// Checksum 0xf553795d, Offset: 0x3d78
// Size: 0xb2
function function_51caee84( endon_flag )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"stealth_discovered" );
    
    if ( isdefined( endon_flag ) )
    {
        level endon( endon_flag );
    }
    
    weap = getweapon( "ar_marksman_veng_hero_weap" );
    
    if ( self getcurrentweapon() == weap )
    {
        while ( true )
        {
            self waittill( #"weapon_change_complete", w_current );
            
            if ( w_current == weap )
            {
                continue;
            }
            
            if ( w_current != weap )
            {
                break;
            }
        }
    }
    
    self thread util::show_hint_text( &"COOP_EQUIP_SHEIVASSW", undefined, undefined, 4 );
}

// Namespace vengeance_util
// Params 0
// Checksum 0xa3cc06ad, Offset: 0x3e38
// Size: 0x5b
function function_b9785164()
{
    self endon( #"disconnect" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"weapon_change_complete", w_current );
        
        if ( w_current.name == "launcher_standard" )
        {
            self thread take_hero_weapon();
            self notify( #"hash_b8804640" );
            break;
        }
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0x9bb37dcd, Offset: 0x3ea0
// Size: 0x7a
function give_hero_weapon( b_switch )
{
    weap = getweapon( "ar_marksman_veng_hero_weap" );
    
    if ( !self hasweapon( weap ) )
    {
        self giveweapon( weap );
    }
    
    if ( isdefined( b_switch ) && b_switch )
    {
        self switchtoweapon( weap );
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x7647a648, Offset: 0x3f28
// Size: 0x52
function take_hero_weapon()
{
    weap = getweapon( "ar_marksman_veng_hero_weap" );
    
    if ( self hasweapon( weap ) )
    {
        self takeweapon( weap );
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0xf0730b8, Offset: 0x3f88
// Size: 0x8a
function function_bce5a9e()
{
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.var_fb7ce72a = &function_a7507be6;
    level waittill( #"clonedentity", e_clone, vehentnum );
    
    if ( e_clone.targetname === "remote_snipers_ai" )
    {
        e_clone.owner thread function_749b8ef8();
    }
}

// Namespace vengeance_util
// Params 2
// Checksum 0x151960ef, Offset: 0x4020
// Size: 0x38
function function_a7507be6( player, weapon )
{
    if ( issubstr( weapon.name, "hijack" ) )
    {
        return 1;
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x80a681b8, Offset: 0x4060
// Size: 0x8a
function function_749b8ef8()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self thread function_80d50798();
    self allowads( 1 );
    wait 1;
    self clientfield::set_to_player( "enemy_highlight", 1 );
    
    while ( self isinvehicle() )
    {
        wait 0.05;
    }
    
    self clientfield::set_to_player( "enemy_highlight", 0 );
}

// Namespace vengeance_util
// Params 1
// Checksum 0xed0a6af5, Offset: 0x40f8
// Size: 0x302
function function_f4c1160( var_8c0019d7 )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !isvehicle( var_8c0019d7 ) )
    {
        return;
    }
    
    if ( isdefined( self.var_3a92cc8f ) )
    {
        return;
    }
    
    self thread function_bf611bcc( &"CP_MI_SING_VENGEANCE_ACTIVATING_REMOTE_SNIPER", 2.5 );
    self thread function_7a768ec( "hijack_static_effect", 0, 1, 2 );
    wait 2.5;
    var_8c0019d7.ignoreme = 1;
    playerstate = spawnstruct();
    self cybercom_gadget_security_breach::function_dc86efaa( playerstate, "begin" );
    self cybercom_gadget_security_breach::function_dc86efaa( playerstate, "cloak" );
    self cybercom_gadget_security_breach::function_dc86efaa( playerstate, "cloak_wait" );
    self.var_3a92cc8f = self.origin;
    self.var_5b921246 = self getplayerangles();
    self setorigin( var_8c0019d7.origin );
    self setplayerangles( var_8c0019d7 gettagangles( "tag_flash" ) );
    self thread function_7a768ec( "hijack_static_effect", 1, 0, 1.5 );
    wait 0.05;
    var_8c0019d7 usevehicle( self, 0 );
    var_8c0019d7 function_2821bb42( 0 );
    self thread function_c7ca0bfb();
    self thread function_80d50798();
    self allowads( 1 );
    self cybercom_gadget_security_breach::function_dc86efaa( playerstate, "return_wait" );
    
    if ( self.var_39b8096c )
    {
        var_8c0019d7 usevehicle( self, 0 );
    }
    
    self clientfield::set_to_player( "enemy_highlight", 0 );
    var_8c0019d7 function_2821bb42( 1 );
    self setorigin( self.var_3a92cc8f );
    self setplayerangles( self.var_5b921246 );
    self.var_3a92cc8f = undefined;
    self.var_5b921246 = undefined;
    self.var_a71359f0 = undefined;
    self thread cybercom_gadget_security_breach::_start_transition( 2 );
    self thread function_7a768ec( "hijack_static_effect", 0, 0, 0 );
    self cybercom_gadget_security_breach::function_dc86efaa( playerstate, "finish" );
    wait 0.05;
    visionset_mgr::deactivate( "visionset", "hijack_vehicle", self );
    visionset_mgr::deactivate( "visionset", "hijack_vehicle_blur", self );
}

// Namespace vengeance_util
// Params 4
// Checksum 0xad8ced09, Offset: 0x4408
// Size: 0x137
function function_7a768ec( fieldname, var_b67bfdce, var_2fcd0a39, timeseconds )
{
    assert( isplayer( self ) );
    self notify( "sniper_roost_trans_cf_" + fieldname );
    self endon( "sniper_roost_trans_cf_" + fieldname );
    self endon( #"disconnect" );
    self endon( #"death" );
    timems = float( timeseconds * 1000 );
    start = gettime();
    durationms = 0;
    var_b67bfdce = float( var_b67bfdce );
    var_2fcd0a39 = float( var_2fcd0a39 );
    
    while ( durationms <= timems )
    {
        value = var_2fcd0a39;
        
        if ( durationms < timems )
        {
            value = var_b67bfdce + ( var_2fcd0a39 - var_b67bfdce ) * durationms / timems;
        }
        
        self clientfield::set_to_player( fieldname, value );
        wait 0.05;
        durationms = float( gettime() - start );
    }
}

// Namespace vengeance_util
// Params 2
// Checksum 0xb8fbea81, Offset: 0x4548
// Size: 0x82
function function_bf611bcc( msg, duration )
{
    self notify( #"hash_bf611bcc" );
    self endon( #"hash_bf611bcc" );
    self endon( #"disconnect" );
    notifydata = spawnstruct();
    notifydata.notifytext2 = msg;
    notifydata.duration = duration;
    self hud_message::notifymessage( notifydata );
    wait duration;
    self hud_message::resetnotify();
}

// Namespace vengeance_util
// Params 0
// Checksum 0xbe87fd28, Offset: 0x45d8
// Size: 0xe7
function function_c7ca0bfb()
{
    self endon( #"disconnect" );
    self.var_39b8096c = 0;
    endtime = gettime() + 45000;
    
    while ( isdefined( self.usingvehicle ) && self.usingvehicle && !self.var_39b8096c )
    {
        self clientfield::set_to_player( "enemy_highlight", 1 );
        wait 0.05;
        self.var_39b8096c = isdefined( self.usingvehicle ) && self.usingvehicle && gettime() > endtime;
        
        if ( endtime - gettime() < 3000 )
        {
            self notify( #"hash_4efa2e41" );
            
            if ( !( isdefined( self.var_a71359f0 ) && self.var_a71359f0 ) )
            {
                self.var_a71359f0 = 1;
                self thread function_7a768ec( "hijack_static_effect", 0, 1, 2 );
            }
        }
    }
    
    self notify( #"return_to_body" );
}

// Namespace vengeance_util
// Params 0
// Checksum 0x36525fa, Offset: 0x46c8
// Size: 0x16d
function function_80d50798()
{
    self endon( #"return_to_body" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"killed_ai", victim, smeansofdeath, weapon );
        
        if ( isactor( victim ) )
        {
            if ( randomfloat( 100 ) > 50 )
            {
                gibserverutils::gibhead( victim );
            }
            
            if ( randomfloat( 100 ) > 50 )
            {
                gibserverutils::gibleftleg( victim );
            }
            
            if ( randomfloat( 100 ) > 50 )
            {
                gibserverutils::gibrightleg( victim );
            }
            
            if ( randomfloat( 100 ) > 50 )
            {
                gibserverutils::gibleftarm( victim );
            }
            else
            {
                gibserverutils::gibrightarm( victim );
            }
        }
        
        if ( isactor( victim ) )
        {
            physorigin = victim.origin - ( 0, 0, 50 );
            wait 0.05;
            physicsexplosionsphere( physorigin, 100, 10, 5000 );
        }
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0x8236d504, Offset: 0x4840
// Size: 0xfb
function function_2821bb42( visible )
{
    partlist = [];
    partlist[ partlist.size ] = "tag_turret";
    partlist[ partlist.size ] = "tag_turret_animate";
    partlist[ partlist.size ] = "tag_barrel";
    partlist[ partlist.size ] = "tag_barrel_animate";
    partlist[ partlist.size ] = "tag_sensor_animate";
    partlist[ partlist.size ] = "tag_ammo_belt_animate";
    partlist[ partlist.size ] = "tag_ammo_can_animate";
    partlist[ partlist.size ] = "tag_barrel_spin";
    partlist[ partlist.size ] = "tag_barrel_spin_animate";
    
    foreach ( part in partlist )
    {
        if ( visible )
        {
            self showpart( part );
            continue;
        }
        
        self hidepart( part );
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0x405c91ce, Offset: 0x4948
// Size: 0x235
function function_5a886ae0()
{
    self endon( #"death" );
    self notify( #"hash_90a20e6d" );
    self endon( #"hash_90a20e6d" );
    
    while ( true )
    {
        a_ai = [];
        var_dea76e58 = getaiteamarray( "axis" );
        
        foreach ( ai in var_dea76e58 )
        {
            if ( !isdefined( ai ) )
            {
                continue;
            }
            
            if ( !isalive( ai ) )
            {
                continue;
            }
            
            if ( isvehicle( ai ) )
            {
                continue;
            }
            
            if ( stealth::function_437e9eec( ai ) )
            {
                continue;
            }
            
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
        
        if ( isdefined( a_ai ) && a_ai.size > 0 )
        {
            a_ai = arraysortclosest( a_ai, self.origin, 2, 64, 800 );
            
            if ( isdefined( a_ai ) && a_ai.size > 0 )
            {
                switch ( randomint( 4 ) )
                {
                    case 0:
                        self thread cybercom::function_d240e350( "cybercom_fireflyswarm", a_ai );
                        break;
                    case 1:
                        self thread cybercom::function_d240e350( "cybercom_concussive" );
                        break;
                    case 2:
                        self thread cybercom::function_d240e350( "cybercom_systemoverload", a_ai );
                        break;
                    case 3:
                        self thread cybercom::function_d240e350( "cybercom_servoshortout", a_ai );
                        break;
                }
                
                wait randomfloatrange( 20, 30 );
            }
        }
        
        wait 2;
    }
}

// Namespace vengeance_util
// Params 3
// Checksum 0x8b602e09, Offset: 0x4b88
// Size: 0xbb
function function_e6399870( str_value, str_key, var_6971862e )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    assert( isdefined( var_6971862e ) );
    triggers = getentarray( str_value, str_key );
    
    foreach ( trigger in triggers )
    {
        trigger thread function_b88d5e7( var_6971862e );
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0xce8051b6, Offset: 0x4c50
// Size: 0x2b5
function function_b88d5e7( var_6971862e )
{
    targets = undefined;
    
    if ( isdefined( self.target ) )
    {
        targets = struct::get_array( self.target, "targetname" );
    }
    
    if ( !isdefined( targets ) && isdefined( self.target ) )
    {
        targets = getentarray( self.target, "targetname" );
    }
    
    if ( !isdefined( targets ) || targets.size == 0 )
    {
        /#
            iprintlnbold( "<dev string:xb6>" + self.origin );
        #/
        
        return;
    }
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        while ( targets.size > 0 )
        {
            aiarray = getaiteamarray( "axis" );
            aiarray = arraysortclosest( aiarray, self.origin, 64, 0, 1000 );
            
            foreach ( ai in aiarray )
            {
                if ( targets.size <= 0 )
                {
                    break;
                }
                
                if ( !isdefined( ai ) || !isactor( ai ) || !isalive( ai ) )
                {
                    continue;
                }
                
                if ( isdefined( ai.var_25ce4365 ) )
                {
                    continue;
                }
                
                if ( ai istouching( self ) )
                {
                    continue;
                }
                
                foreach ( index, tgt in targets )
                {
                    if ( !isdefined( ai ) || !isactor( ai ) || !isalive( ai ) )
                    {
                        break;
                    }
                    
                    molotov = ai function_25ce4365( tgt.origin );
                    
                    if ( isdefined( molotov ) )
                    {
                        tgt thread function_9856bfc7( molotov );
                        targets[ index ] = undefined;
                        break;
                    }
                }
            }
            
            if ( targets.size > 0 )
            {
                wait 1;
            }
        }
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0x6fc49d7f, Offset: 0x4f10
// Size: 0x3a
function function_9856bfc7( molotov )
{
    molotov waittill( #"death" );
    
    if ( isdefined( self.script_parameters ) )
    {
        exploder::exploder( self.script_parameters );
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0x6508483f, Offset: 0x4f58
// Size: 0x5d
function function_c7b05b81( var_6971862e )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player thread function_18538df( self, var_6971862e );
    }
}

// Namespace vengeance_util
// Params 2
// Checksum 0x51e939c4, Offset: 0x4fc0
// Size: 0xbd
function function_18538df( trigger, var_6971862e )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self notify( "molotov_trigger_damage_thread_" + trigger getentitynumber() );
    self endon( "molotov_trigger_damage_thread_" + trigger getentitynumber() );
    
    if ( !isdefined( self.var_c8adaf48 ) )
    {
        self.var_c8adaf48 = 0;
    }
    
    while ( self istouching( trigger ) )
    {
        if ( gettime() - self.var_c8adaf48 >= 1000 )
        {
            self.var_c8adaf48 = gettime();
            self dodamage( var_6971862e, self.origin );
        }
        
        wait 0.05;
    }
}

// Namespace vengeance_util
// Params 2
// Checksum 0xd676e6c0, Offset: 0x5088
// Size: 0x21b
function function_25ce4365( targetposition, b_ignoreme )
{
    self endon( #"death" );
    assert( isactor( self ) );
    assert( isdefined( targetposition ) );
    assert( isvec( targetposition ) );
    self.var_25ce4365 = 1;
    weap = getweapon( "molotov_vengeance" );
    grenadeent = undefined;
    
    if ( isdefined( weap ) )
    {
        grenadeent = self magicgrenade( self geteye(), targetposition, 10, weap );
        
        if ( !isdefined( grenadeent ) )
        {
            self.var_25ce4365 = undefined;
            return undefined;
        }
        else
        {
            grenadeent thread delayed_delete( 0.05 );
            grenadeent = undefined;
        }
        
        ents = [];
        ents[ 0 ] = self;
        var_521db653 = spawnstruct();
        var_521db653.origin = self.origin;
        var_521db653.angles = ( 0, vectortoangles( targetposition - self.origin )[ 1 ], 0 );
        
        if ( isalive( self ) )
        {
            var_521db653 thread scene::play( ents, "cin_ven_gen_grenade_throw_a" );
            self waittill( #"grenade_throw" );
            frompoint = self gettagorigin( "J_Thumb_RI_1" );
            grenadeent = self magicgrenade( frompoint, targetposition, 10, weap );
            self.var_1fd9293d = grenadeent;
            
            if ( isdefined( b_ignoreme ) && b_ignoreme )
            {
                self thread function_85c2c12();
            }
        }
    }
    
    self.var_25ce4365 = undefined;
    return grenadeent;
}

// Namespace vengeance_util
// Params 0
// Checksum 0x4cda6377, Offset: 0x52b0
// Size: 0x52
function function_85c2c12()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    
    if ( isdefined( self.var_1fd9293d ) )
    {
        self.var_1fd9293d waittill( #"death" );
        wait 0.5;
    }
    
    self ai::set_ignoreme( 0 );
}

// Namespace vengeance_util
// Params 1
// Checksum 0x2b5beeb7, Offset: 0x5310
// Size: 0x2a
function delayed_delete( time )
{
    self endon( #"death" );
    wait time;
    self delete();
}

// Namespace vengeance_util
// Params 0
// Checksum 0xe2dfbf5a, Offset: 0x5348
// Size: 0x2a
function function_f9c94344()
{
    level endon( #"stealth_discovered" );
    self endon( #"death" );
    self waittill( #"trigger" );
    stealth::function_9aa26b41();
}

// Namespace vengeance_util
// Params 2
// Checksum 0x99b88ef1, Offset: 0x5380
// Size: 0x4a
function function_e3420328( scene, endon_flag )
{
    level thread scene::play( scene );
    level flag::wait_till( endon_flag );
    level thread scene::stop( scene, 1 );
}

// Namespace vengeance_util
// Params 2
// Checksum 0xcf82485f, Offset: 0x53d8
// Size: 0xd3
function function_65a61b78( a_ents, var_6a07eb6c )
{
    foreach ( e_player in level.players )
    {
        foreach ( object_name in var_6a07eb6c )
        {
            if ( isdefined( a_ents[ object_name ] ) )
            {
                a_ents[ object_name ] clientfield::set( "mature_hide", 1 );
            }
        }
    }
}

// Namespace vengeance_util
// Params 1
// Checksum 0x22ad5d0e, Offset: 0x54b8
// Size: 0xc2
function function_638bf7ab( endon_flag )
{
    model = spawn( "script_model", self.origin );
    model.angles = self.angles;
    model setmodel( self.model );
    model thread scene::play( self.script_noteworthy, model );
    wait 0.1;
    model animation::detach_weapon();
    level flag::wait_till( endon_flag );
    
    if ( isdefined( model ) )
    {
        model stopanimscripted();
        model delete();
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0xa1db3a34, Offset: 0x5588
// Size: 0x12
function function_a084a58f()
{
    savegame::checkpoint_save();
}

// Namespace vengeance_util
// Params 3
// Checksum 0xcad0e816, Offset: 0x55a8
// Size: 0xa2
function co_op_teleport_on_igc_end( str_scene, str_teleport_name, b_save )
{
    if ( !isdefined( b_save ) )
    {
        b_save = 1;
    }
    
    assert( isdefined( str_scene ), "<dev string:xd5>" );
    assert( isdefined( str_teleport_name ), "<dev string:xec>" );
    scene::add_scene_func( str_scene, &teleport_co_op_players_on_scene_done, "players_done" );
    level thread wait_for_scene_done( str_scene, str_teleport_name, b_save );
}

// Namespace vengeance_util
// Params 1
// Checksum 0x26f1fefa, Offset: 0x5658
// Size: 0x13
function teleport_co_op_players_on_scene_done( a_ents )
{
    level notify( #"teleport_players" );
}

// Namespace vengeance_util
// Params 3
// Checksum 0x736c827a, Offset: 0x5678
// Size: 0x112
function wait_for_scene_done( str_scene, str_teleport_name, b_save )
{
    level waittill( #"teleport_players" );
    
    foreach ( player in level.players )
    {
        player ghost();
    }
    
    util::teleport_players_igc( str_teleport_name );
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player show();
    }
    
    if ( isdefined( b_save ) && b_save )
    {
        savegame::checkpoint_save();
    }
}

// Namespace vengeance_util
// Params 2
// Checksum 0xb3440e7e, Offset: 0x5798
// Size: 0x3a
function function_4e8207e9( str_skipto, b_enable )
{
    if ( !isdefined( b_enable ) )
    {
        b_enable = 1;
    }
    
    level clientfield::set( "fxanims_" + str_skipto, b_enable );
}

// Namespace vengeance_util
// Params 2
// Checksum 0x99f21f8a, Offset: 0x57e0
// Size: 0x52
function function_1c347e72( str_targetname, var_bb76866b )
{
    hidemiscmodels( str_targetname );
    a_models = getentarray( var_bb76866b, "targetname" );
    array::delete_all( a_models );
}

// Namespace vengeance_util
// Params 2
// Checksum 0xddb50064, Offset: 0x5840
// Size: 0x22
function function_ba7c52d5( a_ents, str_targetname )
{
    showmiscmodels( str_targetname );
}

// Namespace vengeance_util
// Params 2
// Checksum 0x8d8985fa, Offset: 0x5870
// Size: 0x9b
function function_a72c2dda( a_ents, str_targetname )
{
    showmiscmodels( str_targetname );
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent ) && !issentient( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace vengeance_util
// Params 0
// Checksum 0xf0850fe5, Offset: 0x5918
// Size: 0x92
function function_f832e2fa()
{
    if ( isactor( self ) )
    {
        return;
    }
    
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.team = "allies";
    self clientfield::set( "thermal_active", 1 );
    self util::waittill_any( "death", "cleanup" );
    
    if ( isdefined( self ) )
    {
        self clientfield::set( "thermal_active", 0 );
    }
}

// Namespace vengeance_util
// Params 4
// Checksum 0x4ced5cd1, Offset: 0x59b8
// Size: 0x3a
function function_5fbec645( str_vo_line, delay, priority, toplayer )
{
    self function_6ac438( 0, str_vo_line, delay, priority, toplayer );
}

// Namespace vengeance_util
// Params 4
// Checksum 0xf28a6fbd, Offset: 0x5a00
// Size: 0x3a
function function_ee75acde( str_vo_line, delay, priority, toplayer )
{
    self function_6ac438( 1, str_vo_line, delay, priority, toplayer );
}

// Namespace vengeance_util
// Params 5, eflags: 0x4
// Checksum 0x2a95d9a9, Offset: 0x5a48
// Size: 0x1a1
function private function_6ac438( remote, str_vo_line, delay, priority, toplayer )
{
    a_script_id = strtok( str_vo_line, "_" );
    character = a_script_id[ 0 ];
    
    if ( !isdefined( level.stealth ) || character != "hend" )
    {
        if ( remote )
        {
            self dialog::remote( str_vo_line, delay, undefined, toplayer );
            return;
        }
        
        self dialog::say( str_vo_line, delay, undefined, toplayer );
        return;
    }
    
    var_1f09bc21 = [];
    
    foreach ( player in level.players )
    {
        if ( !isdefined( toplayer ) || player == toplayer )
        {
            self thread function_cb760154( remote, str_vo_line, delay, priority, player );
            var_1f09bc21[ var_1f09bc21.size ] = player;
        }
    }
    
    while ( var_1f09bc21.size )
    {
        for ( i = var_1f09bc21.size - 1; i >= 0 ; i-- )
        {
            if ( !isdefined( var_1f09bc21[ i ] ) || !isdefined( var_1f09bc21[ i ].var_90180902 ) || !isdefined( var_1f09bc21[ i ].var_90180902[ character ] ) )
            {
                var_1f09bc21[ i ] = undefined;
            }
        }
        
        wait 0.05;
    }
}

// Namespace vengeance_util
// Params 5, eflags: 0x4
// Checksum 0xd53ed7f4, Offset: 0x5bf8
// Size: 0x13e
function private function_cb760154( remote, str_vo_line, delay, priority, toplayer )
{
    toplayer endon( #"disconnect" );
    assert( isplayer( toplayer ) );
    a_script_id = strtok( str_vo_line, "_" );
    character = a_script_id[ 0 ];
    
    if ( !isdefined( priority ) )
    {
        priority = 0;
    }
    
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    if ( !isdefined( toplayer.var_90180902 ) )
    {
        toplayer.var_90180902 = [];
    }
    
    var_a5b0e2ce = -1;
    
    if ( isdefined( toplayer.var_90180902[ character ] ) )
    {
        var_a5b0e2ce = toplayer.var_90180902[ character ];
    }
    
    if ( var_a5b0e2ce > -1 )
    {
        return;
    }
    
    toplayer.var_90180902[ character ] = priority;
    
    if ( remote )
    {
        self dialog::remote( str_vo_line, delay, undefined, toplayer );
    }
    else
    {
        self dialog::say( str_vo_line, delay, undefined, toplayer );
    }
    
    toplayer.var_90180902[ character ] = undefined;
}

// Namespace vengeance_util
// Params 3
// Checksum 0xe2fe6102, Offset: 0x5d40
// Size: 0x72
function function_e00864bd( gate, state, id )
{
    var_50bda1f6 = getent( gate, "targetname" );
    wait 0.1;
    var_50bda1f6 ghost();
    var_50bda1f6 notsolid();
    umbragate_set( id, state );
}

// Namespace vengeance_util
// Params 4
// Checksum 0x307a4d3b, Offset: 0x5dc0
// Size: 0x11d
function function_ffaf4723( vol, gate, id, flag )
{
    level endon( flag );
    var_88cf688e = getent( vol, "targetname" );
    var_50bda1f6 = getent( gate, "targetname" );
    var_50bda1f6 ghost();
    var_50bda1f6 notsolid();
    
    while ( true )
    {
        var_2d00103e = 0;
        
        foreach ( player in level.activeplayers )
        {
            if ( player istouching( var_88cf688e ) )
            {
                var_2d00103e = 1;
                break;
            }
        }
        
        umbragate_set( id, var_2d00103e );
        wait 0.1;
    }
}

