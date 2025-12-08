#using script_2b063a830b337a1d;
#using script_2d443451ce681a;
#using script_35ae72be7b4fec10;
#using script_3626f1b2cf51a99c;
#using script_3d18e87594285298;
#using script_44aef2868ad2e317;
#using script_4ab78e327b76395f;
#using script_52da18c20f45c56a;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\ui\object_descriptions;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace namespace_e77bf565;

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xe3c56276, Offset: 0x1578
// Size: 0x18c
function init_clientfields()
{
    level.var_c1ef80d2 = spawnstruct();
    level.var_c1ef80d2.var_4bf20be4 = evidence_board_mission_preview::register();
    clientfield::register( "toplayer", "set_fov", 1, 3, "int" );
    clientfield::register( "toplayer", "set_dof", 1, 3, "int" );
    clientfield::register( "scriptmover", "clf_rob_char_burn", 1, 1, "int" );
    clientfield::register( "scriptmover", "clf_rob_torch_cut", 1, 1, "int" );
    clientfield::register( "toplayer", "gasmask_clf", 1, 1, "int" );
    clientfield::register( "toplayer", "exfilmask_clf", 1, 1, "int" );
    clientfield::register( "toplayer", "stream_elevator_exfil_assets", 1, 1, "int" );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x118c58d4, Offset: 0x1710
// Size: 0x7c
function function_22b7fffd()
{
    animation::add_notetrack_func( "kgb_util::show_hit_marker_on_damage_from_player", &function_249a18d5 );
    animation::add_notetrack_func( "kgb_util::inside_man_head_swap_gasmask_to_injured", &function_6f6eae4 );
    animation::add_notetrack_func( "kgb_util::inside_man_head_swap_injured_to_gasmask", &function_89dd500 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xb706c590, Offset: 0x1798
// Size: 0x21c
function function_26312171()
{
    spawner::add_spawn_function_group( "adler", "targetname", &function_38dbfbad );
    spawner::add_spawn_function_group( "adler_shotgun", "targetname", &function_38dbfbad );
    spawner::add_spawn_function_group( "adler_casual_killer", "targetname", &function_38dbfbad, "casual_killer" );
    spawner::add_spawn_function_group( "inside_man", "targetname", &function_7c790364 );
    spawner::add_spawn_function_group( "inside_man_shotgun", "targetname", &function_7c790364 );
    spawner::add_spawn_function_group( "inside_man_casual_killer", "targetname", &function_7c790364 );
    spawner::add_spawn_function_group( "ignoreall_until_damage", "script_noteworthy", &ignoreall_until_damage );
    spawner::add_spawn_function_group( "ignoreall_until_goal", "script_noteworthy", &ignoreall_until_goal );
    spawner::add_spawn_function_group( "ignoreall_until_damage_or_goal", "script_noteworthy", &ignoreall_until_damage_or_goal );
    spawner::add_spawn_function_group( "player_seek", "script_noteworthy", &player_seek );
    spawner::add_spawn_function_group( "player_seek_flashlight", "script_noteworthy", &player_seek_flashlight );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0xc1709aa6, Offset: 0x19c0
// Size: 0xb0
function adler_spawn( var_d3440450, spawner = "adler" )
{
    adler = spawner::simple_spawn_single( spawner );
    
    if ( isdefined( var_d3440450 ) )
    {
        loc = struct::get( var_d3440450 + "_adler_start", "targetname" );
        
        if ( isdefined( loc ) )
        {
            adler forceteleport( loc.origin, loc.angles );
        }
    }
    
    return adler;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0x72b166dc, Offset: 0x1a78
// Size: 0xb0
function function_e4660071( var_d3440450, spawner = "inside_man" )
{
    inside_man = spawner::simple_spawn_single( spawner );
    
    if ( isdefined( var_d3440450 ) )
    {
        loc = struct::get( var_d3440450 + "_inside_man_start", "targetname" );
        
        if ( isdefined( loc ) )
        {
            inside_man forceteleport( loc.origin, loc.angles );
        }
    }
    
    return inside_man;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xa34943be, Offset: 0x1b30
// Size: 0x5c
function function_38dbfbad( *type )
{
    self.enableterrainik = 1;
    self util::magic_bullet_shield();
    self val::set( #"hash_23a4a81adc3fc092", "push_player", 1 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xf755f80d, Offset: 0x1b98
// Size: 0x54
function function_7c790364()
{
    self.enableterrainik = 1;
    self util::magic_bullet_shield();
    self val::set( #"hash_23a4a81adc3fc092", "push_player", 1 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x223d689b, Offset: 0x1bf8
// Size: 0x46
function ignoreall_until_damage()
{
    self endon( #"death" );
    self.ignoreall = 1;
    self waittill( #"damage" );
    self.ignoreall = 0;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xaa128e8b, Offset: 0x1c48
// Size: 0x46
function ignoreall_until_goal()
{
    self endon( #"death" );
    self.ignoreall = 1;
    self waittill( #"goal" );
    self.ignoreall = 0;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x2c208d59, Offset: 0x1c98
// Size: 0x56
function ignoreall_until_damage_or_goal()
{
    self endon( #"death" );
    self.ignoreall = 1;
    self waittill( #"damage", #"goal" );
    self.ignoreall = 0;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x843303bd, Offset: 0x1cf8
// Size: 0x64
function player_seek()
{
    self.ignoresuppression = 1;
    self.goalradius = 350;
    self setgoal( level.players[ 0 ] );
    self ai::set_behavior_attribute( "demeanor", "cqb" );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xae403b66, Offset: 0x1d68
// Size: 0x34
function player_seek_flashlight()
{
    self player_seek();
    self flashlight::function_7c2f623b();
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 3
// Checksum 0xf0a347cf, Offset: 0x1da8
// Size: 0x4c
function function_23705b46( aigroup, count, flag )
{
    spawner::waittill_ai_group_count( aigroup, count );
    level flag::set( flag );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0x17246920, Offset: 0x1e00
// Size: 0x74
function function_acd27ffb( var_678713c9, setflag )
{
    assert( isarray( var_678713c9 ), "<dev string:x38>" );
    flag::wait_till_any( var_678713c9 );
    flag::set( setflag );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0x168503fb, Offset: 0x1e80
// Size: 0x74
function function_ae7c9137( var_ec216292, setflag )
{
    assert( isarray( var_ec216292 ), "<dev string:x38>" );
    flag::wait_till_all( var_ec216292 );
    flag::set( setflag );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x49742d60, Offset: 0x1f00
// Size: 0x44
function function_85d3a678()
{
    function_5dfd7fb1( "adler_exfil_nodes", "script_noteworthy", 0 );
    function_5dfd7fb1( "exfil_escape_nodes", "script_noteworthy", 0 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 3
// Checksum 0xbf7d7310, Offset: 0x1f50
// Size: 0xc8
function function_5dfd7fb1( nodename, nodekey, benabled )
{
    nodes = getnodearray( nodename, nodekey );
    
    if ( isdefined( nodes ) )
    {
        foreach ( node in nodes )
        {
            setenablenode( node, benabled );
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x12d08bd6, Offset: 0x2020
// Size: 0x2bc
function function_95feac9c()
{
    level.elevator = getent( "elevator", "targetname" );
    level thread function_c0dcd012();
    level.elevator_body_clip = getent( "elevator_body_clip", "targetname" );
    level.elevator_body_clip linkto( level.elevator );
    level.elevator_left_door_clip = getent( "elevator_left_door_clip", "targetname" );
    level.elevator_left_door_clip linkto( level.elevator );
    level.elevator_right_door_clip = getent( "elevator_right_door_clip", "targetname" );
    level.elevator_right_door_clip linkto( level.elevator );
    level.elevator_doorway_player_clip = getent( "elevator_doorway_player_clip", "targetname" );
    level.elevator_doorway_player_clip linkto( level.elevator );
    level.elevator_lights = getentarray( "elevator_light", "targetname" );
    
    if ( isdefined( level.elevator_lights ) && level.elevator_lights.size > 0 )
    {
        foreach ( light in level.elevator_lights )
        {
            light linkto( level.elevator );
        }
    }
    
    level flag::set( "elevator_clips_ready" );
    level thread function_c6e1b306();
    level.elevator_probe = getent( "elevator_probe", "targetname" );
    level.elevator_probe linkto( level.elevator );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x4673ea49, Offset: 0x22e8
// Size: 0xb4
function function_c0dcd012()
{
    exfil_escape_alarm_light_elevator = getent( "exfil_escape_alarm_light_elevator", "targetname" );
    
    if ( isdefined( exfil_escape_alarm_light_elevator ) )
    {
        exfil_escape_alarm_light_elevator linkto( level.elevator, "tag_origin", ( 0, 46, 85 ), ( 0, 90, -90 ) );
        level flag::wait_till( "turn_on_elevator_alarm_light" );
        exfil_escape_alarm_light_elevator setlightintensity( 12000000 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xf9994d64, Offset: 0x23a8
// Size: 0xc0
function function_c6e1b306()
{
    while ( true )
    {
        msg = level waittill( #"hash_33452e25c7f8048c", #"hash_75603f5b1241ba55" );
        
        if ( msg._notify == #"hash_33452e25c7f8048c" )
        {
            level.elevator_doorway_player_clip solid();
            continue;
        }
        
        if ( msg._notify == #"hash_75603f5b1241ba55" )
        {
            level.elevator_doorway_player_clip notsolid();
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0x4622d4ac, Offset: 0x2470
// Size: 0xc4
function toggle_light( tname, var_b1e77977 )
{
    light = getent( tname, "targetname" );
    
    if ( isdefined( light ) )
    {
        if ( is_true( var_b1e77977 ) )
        {
            if ( isdefined( light.default_intensity ) )
            {
                light setlightintensity( light.default_intensity );
            }
            
            return;
        }
        
        light.default_intensity = light getlightintensity();
        light setlightintensity( 0 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x4cdbfd26, Offset: 0x2540
// Size: 0x54
function function_fde96a47()
{
    var_5bac8498 = getentarray( "rotating_fan", "targetname" );
    
    if ( isdefined( var_5bac8498 ) )
    {
        array::thread_all( var_5bac8498, &rotating_fan );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xb840a135, Offset: 0x25a0
// Size: 0xde
function rotating_fan()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.var_a1a5e6bc == "yaw" )
        {
            self rotateyaw( 360, self.var_b1c6f60c );
        }
        else if ( self.var_a1a5e6bc == "roll" )
        {
            self rotateroll( 360, self.var_b1c6f60c );
        }
        else if ( self.var_a1a5e6bc == "pitch" )
        {
            self rotatepitch( 360, self.var_b1c6f60c );
        }
        
        self waittill( #"rotatedone" );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0x2aef1fd0, Offset: 0x2688
// Size: 0x4b2
function function_7feb07bb( var_d3440450, *var_50cc0d4f )
{
    if ( var_50cc0d4f == "kgb_aslt_bunker" )
    {
        level flag::wait_till( "aslt_bunker_begin" );
    }
    
    id = objectives::function_285e460( "obj_retrieve_intel" );
    
    if ( !isdefined( id ) )
    {
        objectives::scripted( "obj_retrieve_intel", undefined, #"hash_2f94fe6c683f39ef" );
    }
    
    switch ( var_50cc0d4f )
    {
        case #"kgb_aslt_bunker":
            level flag::wait_till( "bunker_intro_security_cleared" );
            objectives::follow( "follow_adler", level.adler );
            level flag::wait_till( "aslt_bunker_complete" );
            objectives::complete( "follow_adler", level.adler );
            return;
        case #"kgb_aslt_vault_approach":
            assault_plant_gas_org = struct::get( "assault_plant_gas_org", "targetname" );
            objectives::goto( "obj_goto", assault_plant_gas_org.origin );
            level flag::wait_till( "player_planted_gas" );
            objectives::complete( "obj_goto" );
            objectives::follow( "follow_adler", level.adler );
            return;
        case #"kgb_aslt_vault_breach":
            while ( !isdefined( level.adler ) )
            {
                wait 0.05;
            }
            
            id = objectives::function_285e460( "follow_adler", level.adler );
            
            if ( !isdefined( id ) )
            {
                objectives::follow( "follow_adler", level.adler );
            }
            
            level flag::wait_till( "update_objective_position_on_vault_door" );
            objectives::complete( "follow_adler", level.adler );
            vault_breach_obj_org = struct::get( "vault_breach_obj_org", "targetname" );
            objectives::goto( "obj_goto", vault_breach_obj_org.origin );
            level flag::wait_till( "vault_breach_started" );
            objectives::complete( "obj_goto" );
            return;
        case #"kgb_aslt_vault":
            macguffin_org = struct::get( "macguffin_org", "targetname" );
            objectives::goto( "obj_goto", macguffin_org.origin );
            level flag::wait_till( "macguffin_download_started" );
            objectives::complete( "obj_goto" );
            level flag::wait_till( "player_exited_computer" );
            objectives::follow( "support_adler", level.adler );
            objectives::function_67f87f80( "support_adler", [ level.adler ], #"hash_51de8bc6710f2a2e" );
            level flag::wait_till( "aslt_vault_complete" );
            objectives::complete( "support_adler", level.adler );
            objectives::complete( "obj_retrieve_intel" );
            return;
        default:
            break;
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0xe8201b7c, Offset: 0x2b48
// Size: 0x682
function escape_objective( var_d3440450, *var_50cc0d4f )
{
    id = objectives::function_285e460( "obj_escape" );
    
    if ( !isdefined( id ) )
    {
        objectives::scripted( "obj_escape", undefined, #"hash_3c61b0f317a4032c" );
    }
    
    switch ( var_50cc0d4f )
    {
        case #"kgb_aslt_bunker_escape":
            while ( !isdefined( level.adler ) )
            {
                wait 0.05;
            }
            
            id = objectives::function_285e460( "follow_adler", level.adler );
            
            if ( !isdefined( id ) )
            {
                objectives::follow( "follow_adler", level.adler );
            }
            
            return;
        case #"hash_6139e6d0cf6b6169":
            while ( !isdefined( level.adler ) )
            {
                wait 0.05;
            }
            
            id = objectives::function_285e460( "follow_adler", level.adler );
            
            if ( !isdefined( id ) )
            {
                objectives::follow( "follow_adler", level.adler );
            }
            
            level flag::wait_till( "lights_out_done" );
            objectives::complete( "follow_adler", level.adler );
            lights_out_obj_org = struct::get( "lights_out_obj_org", "targetname" );
            objectives::goto( "obj_goto", lights_out_obj_org.origin );
            level flag::wait_till( "aslt_bunker_escape_lights_out_complete" );
            objectives::complete( "obj_goto" );
            return;
        case #"hash_95c7f85d780075a":
            while ( !isdefined( level.adler ) )
            {
                wait 0.05;
            }
            
            id = objectives::function_285e460( "follow_adler", level.adler );
            
            if ( !isdefined( id ) )
            {
                objectives::follow( "follow_adler", level.adler );
            }
            
            level flag::wait_till( "enable_inside_man_rescue_objective" );
            objectives::complete( "follow_adler", level.adler );
            objectives::function_4eb5c04a( "obj_goto", level.var_a910b1a );
            level flag::wait_till( "inside_man_rescued" );
            objectives::complete( "obj_goto", level.var_a910b1a );
            objectives::follow( "follow_adler", level.adler );
            level flag::set( "inside_man_rescue_objective_cleaned_up" );
            return;
        case #"kgb_aslt_exfil":
            while ( !isdefined( level.adler ) )
            {
                wait 0.05;
            }
            
            id = objectives::function_285e460( "follow_adler", level.adler );
            
            if ( !isdefined( id ) )
            {
                objectives::follow( "follow_adler", level.adler );
            }
            
            level flag::wait_till( "enable_gas_mask_interact" );
            objectives::complete( "follow_adler", level.adler );
            exfil_player_grab_armor_org = struct::get( "exfil_player_grab_armor_org", "targetname" );
            objectives::function_4eb5c04a( "obj_goto", exfil_player_grab_armor_org.origin );
            level flag::wait_till( "player_grabbed_armor" );
            objectives::complete( "obj_goto" );
            return;
        case #"kgb_aslt_exfil_escape":
            level flag::wait_till( "escape_follow_adler" );
            exfil_escape_door_obj_org = struct::get( "exfil_escape_door_obj_org", "targetname" );
            objectives::goto( "obj_goto", exfil_escape_door_obj_org.origin );
            level flag::wait_till_any( [ "player_opened_exfil_tunnel_door", "scene_kgb_exfil_door_kick_played" ] );
            objectives::complete( "obj_goto" );
            level flag::wait_till( "escape_enable_car_interact_waypoint" );
            objectives::function_4eb5c04a( "obj_goto", level.var_ea185900 );
            level flag::wait_till( "player_started_car_escape" );
            objectives::complete( "obj_goto", level.var_ea185900 );
            level flag::wait_till( "aslt_exfil_escape_complete" );
            objectives::complete( "obj_escape" );
            return;
        default:
            break;
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 3
// Checksum 0xe0b86e54, Offset: 0x31d8
// Size: 0x198
function function_7d2d1987( distsquared = 640000, fov = cos( 45 ), var_e6208e62 = 0 )
{
    self endon( #"death" );
    
    if ( is_true( self.var_204d3cd5 ) )
    {
        return;
    }
    
    self.var_204d3cd5 = 1;
    
    if ( is_false( var_e6208e62 ) )
    {
        self waittill( #"reached_path_end" );
    }
    
    player = getplayers()[ 0 ];
    player endon( #"death" );
    
    while ( true )
    {
        wait 0.1;
        
        if ( distancesquared( player.origin, self.origin ) < distsquared )
        {
            continue;
        }
        
        if ( !util::within_fov( player geteye(), player getplayerangles(), self geteye(), fov ) )
        {
            self delete();
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x3571351f, Offset: 0x3378
// Size: 0x74
function function_bf9d2fd0( node )
{
    self endon( #"death" );
    
    if ( is_true( self.var_e1176e19 ) )
    {
        return;
    }
    
    self.var_e1176e19 = 1;
    self.delete_on_path_end = 1;
    self spawner::go_to_node( node );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x361baa50, Offset: 0x33f8
// Size: 0x1c
function function_4f71d4ee()
{
    self.allowbattlechatter[ #"bc" ] = 0;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x11815c64, Offset: 0x3420
// Size: 0x4c
function function_74daa06d()
{
    level.var_790adaef = spawnstruct();
    level.var_790adaef function_57602bf2( level.players[ 0 ], level.var_790adaef );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xc2fd4c78, Offset: 0x3478
// Size: 0x3ee
function function_be59e982()
{
    level endon( #"hash_5bf1b18a13fba9d6" );
    var_66a6442a = 18;
    var_deffc19e = 12;
    n_move_speed = var_66a6442a / 0.8;
    var_80778410 = ( 0, 0, 0 );
    level.var_790adaef.var_edb90184.origin = level.papers.origin;
    level.var_790adaef.s_center = level.papers.origin;
    level.var_310cb1c8 = "";
    level.var_4e5aead8 = "";
    function_eba401f9();
    
    while ( true )
    {
        if ( self stancebuttonpressed() )
        {
            self.var_65558489 = 1;
            self.var_c2b6a937 = 1;
            function_8042f1e();
            level notify( #"hash_5bf1b18a13fba9d6" );
        }
        
        if ( self actionbuttonpressed() )
        {
            level notify( #"hash_17ce3d216237a444" );
            function_297750f1();
        }
        
        if ( self weaponswitchbuttonpressed() )
        {
            function_cd611120();
        }
        
        var_da679a67 = util::function_63320ea1( self getnormalizedmovement(), 0.1, 0 );
        
        if ( var_da679a67 != ( 0, 0, 0 ) )
        {
            var_80778410 += ( 0, var_da679a67[ 1 ] * -1, var_da679a67[ 0 ] );
            var_80778410 = ( var_80778410[ 0 ], math::clamp( var_80778410[ 1 ], var_66a6442a * -1, var_66a6442a ), var_80778410[ 2 ] );
            var_80778410 = ( var_80778410[ 0 ], var_80778410[ 1 ], math::clamp( var_80778410[ 2 ], var_deffc19e * -1, var_deffc19e ) );
            var_b6fbbafc = rotatepointaroundaxis( var_80778410, ( 0, 0, 1 ), self getplayerangles()[ 1 ] );
            level.var_790adaef.var_edb90184.origin = level.var_790adaef.s_center + var_b6fbbafc * n_move_speed * float( function_60d95f53() ) / 1000;
        }
        
        /#
            if ( function_48a5aeda() )
            {
                level.var_5e433b92 settext( level.var_4e5aead8 );
                level.var_7d7f0e5d settext( level.var_310cb1c8 );
            }
            else
            {
                level.var_5e433b92 settext( "<dev string:x5d>" );
                level.var_7d7f0e5d settext( "<dev string:x5d>" );
            }
        #/
        
        waitframe( 1 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x7a8772ae, Offset: 0x3870
// Size: 0x292
function function_48a5aeda()
{
    touching = 0;
    
    foreach ( trig in level.var_94b40a18 )
    {
        if ( level.var_790adaef.var_edb90184 istouching( trig ) )
        {
            touching = 1;
            
            switch ( trig.script_noteworthy )
            {
                case #"office":
                    level.var_4e5aead8 = "Charkov's Office";
                    level.var_310cb1c8 = function_dd5acf7a();
                    break;
                case #"prison":
                    level.var_4e5aead8 = "Interrogation";
                    level.var_310cb1c8 = function_a3a0e956();
                    break;
                case #"records":
                    level.var_4e5aead8 = "Records";
                    level.var_310cb1c8 = function_f01fac26();
                    break;
                case #"hash_1f5964a2ce98072e":
                    level.var_4e5aead8 = "Central Mail";
                    level.var_310cb1c8 = function_3aa37c73();
                    break;
                case #"computer":
                    level.var_4e5aead8 = "Information Room";
                    level.var_310cb1c8 = function_5a960ea4();
                    break;
                case #"armory":
                    level.var_4e5aead8 = "Armory";
                    level.var_310cb1c8 = function_7d914338();
                    break;
                case #"basement":
                    level.var_4e5aead8 = "Basement Prison";
                    level.var_310cb1c8 = function_cbbf2dd1();
                    break;
            }
        }
    }
    
    return touching;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x1e57a16a, Offset: 0x3b10
// Size: 0x13a
function function_716786f()
{
    spot = level.papers.origin;
    
    foreach ( trigger in level.var_94b40a18 )
    {
        if ( trigger.script_noteworthy == "office" )
        {
            spot = trigger.origin;
        }
    }
    
    foreach ( trigger in level.var_94b40a18 )
    {
        if ( trigger.var_fd766919 )
        {
            spot = trigger.origin;
        }
    }
    
    return spot;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x3fe967ea, Offset: 0x3c58
// Size: 0xd8
function function_cd611120()
{
    foreach ( trig in level.var_94b40a18 )
    {
        if ( level.var_790adaef.var_edb90184 istouching( trig ) )
        {
            level kgb_ins_prepare::function_68e72c81( trig.script_noteworthy );
            function_64233874( trig );
            wait 0.5;
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x10852e34, Offset: 0x3d38
// Size: 0x150
function function_64233874( var_2dca3240 )
{
    foreach ( trigger in level.var_94b40a18 )
    {
        trigger.var_fd766919 = 0;
    }
    
    if ( isdefined( var_2dca3240 ) )
    {
        var_2dca3240.var_fd766919 = 1;
    }
    
    foreach ( trigger in level.var_94b40a18 )
    {
        if ( trigger.var_fd766919 )
        {
            trigger.ring show();
            continue;
        }
        
        trigger.ring hide();
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xd5fba2d6, Offset: 0x3e90
// Size: 0x90
function function_8042f1e()
{
    foreach ( trigger in level.var_94b40a18 )
    {
        trigger.ring hide();
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x2b8e5126, Offset: 0x3f28
// Size: 0xc0
function function_eba401f9()
{
    foreach ( trigger in level.var_94b40a18 )
    {
        if ( trigger.var_fd766919 )
        {
            trigger.ring show();
            continue;
        }
        
        trigger.ring hide();
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xa77fb937, Offset: 0x3ff0
// Size: 0x2a2
function function_297750f1()
{
    b_touching = 0;
    trigs = getentarray( "trig_map", "targetname" );
    
    foreach ( trig in trigs )
    {
        if ( level.var_790adaef.var_edb90184 istouching( trig ) )
        {
            b_touching = 1;
            
            switch ( trig.script_noteworthy )
            {
                case #"office":
                    level thread dialogue::radio( function_3c7d574e() );
                    break;
                case #"prison":
                    level thread dialogue::radio( function_640ac058() );
                    break;
                case #"records":
                    level thread dialogue::radio( function_b1866279() );
                    break;
                case #"hash_1f5964a2ce98072e":
                    level thread dialogue::radio( function_d4bdad20() );
                    break;
                case #"computer":
                    level thread dialogue::radio( function_843ec6d3() );
                    break;
                case #"armory":
                    level thread dialogue::radio( function_5e4be0e6() );
                    break;
                case #"basement":
                    level thread dialogue::radio( function_aa162a18() );
                    break;
            }
        }
    }
    
    if ( !b_touching )
    {
        iprintlnbold( "Move cursor to select a room" );
    }
    
    wait 1;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0xdbd494b0, Offset: 0x42a0
// Size: 0x296
function function_57602bf2( player, s_eboard )
{
    s_pos = level.papers;
    
    if ( !isdefined( s_eboard.var_bb194ec6 ) )
    {
        s_eboard.var_bb194ec6 = util::spawn_model( "tag_origin", s_pos.origin, s_pos.angles );
    }
    
    s_center = level.papers;
    s_eboard.s_center = s_center.origin;
    
    if ( !isdefined( s_eboard.var_edb90184 ) )
    {
        s_eboard.var_edb90184 = spawn( "script_model", s_eboard.s_center );
        level.var_c1ef80d2.var_b4185011 = spawn( "script_origin", s_eboard.var_edb90184.origin );
        level.var_c1ef80d2.var_b4185011 linkto( s_eboard.var_edb90184 );
        entnum = s_eboard.var_edb90184 getentitynumber();
        level.var_c1ef80d2.var_4bf20be4 evidence_board_mission_preview::set_entnum( player, entnum );
        level.var_c1ef80d2.var_4bf20be4 evidence_board_mission_preview::open( player );
        level.var_c1ef80d2.var_4bf20be4 evidence_board_mission_preview::function_57d3362b( player, 0 );
    }
    
    s_eboard.var_fa32835f = 0.75;
    s_eboard.var_5e93e3a6 = undefined;
    s_eboard.var_a9b3741b = undefined;
    s_eboard.var_c7c95830 = undefined;
    s_eboard.var_32f26e79 = undefined;
    s_eboard.var_27d52210 = 0.5;
    s_eboard.var_d0401fc8 = 0.5;
    s_eboard.var_61992e19 = undefined;
    s_eboard.var_c311ad4d = undefined;
    s_eboard.var_c2a4938f = undefined;
    s_eboard.var_c72514a7 = undefined;
    s_eboard.var_c6a7eb4e = undefined;
    s_eboard.var_a3ae6fbc = -16;
    s_eboard.var_d3f12b87 = 0.05;
    s_eboard.var_17178bb3 = 0.2;
    s_eboard.var_5fdf77de = "";
    return s_eboard;
}

/#

    // Namespace namespace_e77bf565/namespace_1b5c93f4
    // Params 0
    // Checksum 0x9b2a2eba, Offset: 0x4540
    // Size: 0x1aa, Type: dev
    function function_27d8c6e3()
    {
        xoffset = 125;
        yoffset = 95;
        var_981bb6ec = 15;
        level.var_5e433b92 = newdebughudelem();
        level.var_5e433b92.alignx = "<dev string:x61>";
        level.var_5e433b92.horzalign = "<dev string:x61>";
        level.var_5e433b92.x = xoffset;
        level.var_5e433b92.y = yoffset;
        level.var_5e433b92.fontscale = 1.5;
        level.var_5e433b92.color = ( 1, 1, 1 );
        level.var_5e433b92.str = "<dev string:x5d>";
        level.var_7d7f0e5d = newdebughudelem();
        level.var_7d7f0e5d.alignx = "<dev string:x61>";
        level.var_7d7f0e5d.horzalign = "<dev string:x61>";
        level.var_7d7f0e5d.x = xoffset;
        level.var_7d7f0e5d.y = yoffset + 20;
        level.var_7d7f0e5d.fontscale = 1;
        level.var_7d7f0e5d.color = ( 1, 1, 1 );
        level.var_7d7f0e5d.str = "<dev string:x5d>";
    }

#/

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xa69211d0, Offset: 0x46f8
// Size: 0x14e
function function_3aa37c73()
{
    var_f788b926 = "Optional - Find a way to use mail to kill Charkov";
    
    if ( level flag::get( "flag_show_mail" ) )
    {
        var_f788b926 = "Optional - Find a cigar and poison and mail it";
        
        if ( level flag::get( "flag_has_poison" ) && !level flag::get( "flag_has_cigar" ) )
        {
            var_f788b926 = "Optional - Find a cigar to poison and mail";
        }
        
        if ( !level flag::get( "flag_has_poison" ) && level flag::get( "flag_has_cigar" ) )
        {
            var_f788b926 = "Optional - Find poison and then mail cigar";
        }
        
        if ( level flag::get( "flag_has_poison" ) && level flag::get( "flag_has_cigar" ) )
        {
            var_f788b926 = "Optional - Mail the poisoned cigar";
        }
        
        if ( level flag::get( "flag_mail_sent" ) )
        {
            var_f788b926 = "Optional - Return to Charkov's office";
        }
    }
    
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x3aedfcfb, Offset: 0x4850
// Size: 0x6e
function function_f01fac26()
{
    var_f788b926 = "Optional - Investigate file room";
    
    if ( level flag::get( "flag_hint_locked_file" ) )
    {
        var_f788b926 = "Optional - Find Prisoner's file or investigate room for opportunity";
    }
    
    if ( level flag::get( "flag_file_room_chat" ) )
    {
        var_f788b926 = "Optional - Charkov is in the records room";
    }
    
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xe4c97174, Offset: 0x48c8
// Size: 0x6e
function function_5a960ea4()
{
    var_f788b926 = "Optional - Investigate Information Room";
    
    if ( level flag::get( "flag_radio_cards" ) )
    {
        var_f788b926 = "Optional - find missing briefcase or get into armory";
    }
    
    if ( level flag::get( "flag_got_spare_card" ) )
    {
        var_f788b926 = "Optional - reprogram the spare card";
    }
    
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xd68af1bb, Offset: 0x4940
// Size: 0x12a
function function_dd5acf7a()
{
    var_f788b926 = "Optional - Find a way into his office";
    
    if ( level flag::get( "flag_start_secretary_loop" ) && !level flag::get_any( [ "flag_cup_poisoned", "flag_mail_sent" ] ) )
    {
        var_f788b926 = "Optional - Deal with the secretary or find another way in";
    }
    
    if ( level flag::get( "flag_file_room_chat" ) )
    {
        var_f788b926 = "Optional - Charkov is in the records room";
    }
    
    if ( level flag::get( "flag_sent_mail" ) )
    {
        var_f788b926 = "Optional - Wait for Charkkov to take the bait";
    }
    
    if ( level flag::get( "flag_cup_poisoned" ) && !level flag::get( "flag_sent_mail" ) )
    {
        var_f788b926 = "Optional - The secretary is no longer stopping me from going in";
    }
    
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x89eeb58e, Offset: 0x4a78
// Size: 0x6e
function function_a3a0e956()
{
    var_f788b926 = "Optional - See if the prisoner can be persuaded";
    
    if ( level flag::get( "flag_hint_locked_file" ) )
    {
        var_f788b926 = "Optional - search records for a file";
    }
    
    if ( level flag::get( "flag_show_family_choice" ) )
    {
        var_f788b926 = "Optional - use his family as leverage";
    }
    
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xd95000f3, Offset: 0x4af0
// Size: 0x1a
function function_cbbf2dd1()
{
    var_f788b926 = "Get Keycard and then let in Adler's team";
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x162e9908, Offset: 0x4b18
// Size: 0x46
function function_7d914338()
{
    var_f788b926 = "Optional - Investigate armory";
    
    if ( level flag::get( "flag_radio_cards" ) )
    {
        var_f788b926 = "Optional - reporgrammable cards are in a locker";
    }
    
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x82623542, Offset: 0x4b68
// Size: 0xb6
function function_3c7d574e()
{
    var_f788b926 = "vox_cp_rkgb_01570_blkv_sincecharkoviss_65";
    
    if ( level flag::get( "flag_start_secretary_loop" ) && !level flag::get_any( [ "flag_cup_poisoned", "flag_mail_sent" ] ) )
    {
        var_f788b926 = "vox_cp_rkgb_01600_blkv_togetthroughhis_9a";
    }
    
    if ( level flag::get( "flag_mail_sent" ) )
    {
        var_f788b926 = "vox_cp_rkgb_01650_blkv_nowtoseeifchark_f8";
    }
    
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xa8cd9207, Offset: 0x4c28
// Size: 0x1a
function function_b1866279()
{
    var_f788b926 = "vox_cp_rkgb_01570_blkv_charkovwillbesh_af";
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xa9844ec0, Offset: 0x4c50
// Size: 0x1a
function function_5e4be0e6()
{
    var_f788b926 = "vox_cp_rkgb_01650_blkv_thearmoryislock_79";
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xa200f009, Offset: 0x4c78
// Size: 0x1a
function function_843ec6d3()
{
    var_f788b926 = "vox_cp_rkgb_01665_blkv_thecomputerroom_7f";
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x164bff9b, Offset: 0x4ca0
// Size: 0x6e
function function_640ac058()
{
    var_f788b926 = "vox_cp_rkgb_01570_blkv_charkovisschedu_80";
    
    if ( level flag::get( "flag_hint_locked_file" ) )
    {
        var_f788b926 = "vox_cp_rkgb_01585_blkv_hisfileisprobab_34";
    }
    
    if ( level flag::get( "flag_show_family_choice" ) )
    {
        var_f788b926 = "vox_cp_rkgb_01595_blkv_hisfamilyisthep_ef";
    }
    
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x7880258e, Offset: 0x4d18
// Size: 0x1a
function function_aa162a18()
{
    var_f788b926 = "vox_cp_rkgb_01650_blkv_adlerswaitingin_31";
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x2882e87, Offset: 0x4d40
// Size: 0x1a
function function_d4bdad20()
{
    var_f788b926 = "vox_cp_rkgb_01650_blkv_icouldmailpoiso_6d";
    return var_f788b926;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x64f6a51c, Offset: 0x4d68
// Size: 0x22c
function function_5770c74( var_d5783b32 = "kgb" )
{
    if ( var_d5783b32 == "civ" )
    {
        self setmodel( "c_t9_usa_hero_adler_civ_amsterdam_body" );
        
        if ( self isattached( "c_t9_cp_usa_hero_adler_head1_kgb_officer" ) )
        {
            self detach( "c_t9_cp_usa_hero_adler_head1_kgb_officer" );
        }
        
        if ( !self isattached( "c_t9_cp_usa_hero_adler_head1" ) )
        {
            self attach( "c_t9_cp_usa_hero_adler_head1" );
        }
    }
    
    if ( var_d5783b32 == "kgb" )
    {
        self setmodel( "c_t9_rus_kgb_hq_officer_body1" );
        
        if ( self isattached( "c_t9_cp_usa_hero_adler_head1" ) )
        {
            self detach( "c_t9_cp_usa_hero_adler_head1" );
        }
        
        if ( !self isattached( "c_t9_cp_usa_hero_adler_head1_kgb_officer" ) )
        {
            self attach( "c_t9_cp_usa_hero_adler_head1_kgb_officer" );
        }
    }
    
    if ( var_d5783b32 == "assault" )
    {
        self setmodel( "c_t9_cp_usa_hero_adler_kgb_exfil_body" );
        
        if ( self isattached( "c_t9_cp_usa_hero_adler_head1_kgb_officer" ) )
        {
            self detach( "c_t9_cp_usa_hero_adler_head1_kgb_officer" );
        }
        
        if ( !self isattached( "c_t9_cp_usa_hero_adler_head1" ) )
        {
            self attach( "c_t9_cp_usa_hero_adler_head1" );
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x81edf351, Offset: 0x4fa0
// Size: 0xe0
function function_363ebd5a( tname )
{
    lights = getentarray( tname, "targetname" );
    
    if ( !isdefined( lights ) )
    {
        return;
    }
    
    foreach ( light in lights )
    {
        light.default_intensity = light getlightintensity();
        light setlightintensity( 0 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0x1cd8bcc6, Offset: 0x5088
// Size: 0x158
function function_2fa39d6d( tname, var_50cc0d4f )
{
    lights = getentarray( tname, "targetname" );
    
    if ( !isdefined( lights ) )
    {
        return;
    }
    
    foreach ( light in lights )
    {
        if ( isdefined( light.default_intensity ) )
        {
            if ( isdefined( light.script_noteworthy ) && light.script_noteworthy == "flicker_on" )
            {
                if ( is_true( var_50cc0d4f ) )
                {
                    light setlightintensity( light.default_intensity );
                }
                else
                {
                    light thread function_7c64b9aa();
                }
                
                continue;
            }
            
            light setlightintensity( light.default_intensity );
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x7f352c9e, Offset: 0x51e8
// Size: 0x25c
function function_7c64b9aa()
{
    var_371b4a6d = self.default_intensity * 0.1;
    self setlightintensity( var_371b4a6d );
    wait randomfloatrange( 0.1, 0.3 );
    self setlightintensity( 0 );
    wait randomfloatrange( 0.1, 0.3 );
    var_371b4a6d = self.default_intensity * 0.3;
    self setlightintensity( var_371b4a6d );
    wait randomfloatrange( 0.1, 0.3 );
    self setlightintensity( self.default_intensity * 0.1 );
    wait randomfloatrange( 0.1, 0.3 );
    var_371b4a6d = self.default_intensity * 0.6;
    self setlightintensity( var_371b4a6d );
    wait randomfloatrange( 0.1, 0.3 );
    self setlightintensity( self.default_intensity * 0.3 );
    wait randomfloatrange( 0.1, 0.3 );
    var_371b4a6d = self.default_intensity * 0.8;
    self setlightintensity( var_371b4a6d );
    wait randomfloatrange( 0.1, 0.3 );
    self setlightintensity( self.default_intensity * 0.6 );
    wait randomfloatrange( 0.1, 0.3 );
    var_371b4a6d = self.default_intensity;
    self setlightintensity( var_371b4a6d );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x38496f49, Offset: 0x5450
// Size: 0xf0
function function_7264e049( *params )
{
    self endon( #"death" );
    self endon( #"hash_67c64045f0256f7b" );
    
    while ( true )
    {
        startpos = self gettagorigin( "tag_flash" );
        angles = self gettagangles( "tag_flash" );
        forward = anglestoforward( angles );
        endpos = startpos + vectorscale( forward, 1000 );
        magicbullet( self.weapon, startpos, endpos, self );
        wait 0.09;
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x1ba8127f, Offset: 0x5548
// Size: 0x4b0
function function_27006ab9()
{
    var_5c62def3 = getentarray( "camera_volume", "targetname" );
    
    foreach ( vol in var_5c62def3 )
    {
        vol delete();
    }
    
    var_299f6389 = getentarray( "trig_locked_room", "targetname" );
    
    foreach ( trig in var_299f6389 )
    {
        trig delete();
    }
    
    mental_map_poi = getentarray( "mental_map_poi", "targetname" );
    
    foreach ( poi in mental_map_poi )
    {
        poi delete();
    }
    
    props = getentarray( "ins_anim_prop", "script_noteworthy" );
    
    foreach ( thing in props )
    {
        thing delete();
    }
    
    ai_spawners = getentarray( "civs", "targetname" );
    
    foreach ( thing in ai_spawners )
    {
        thing delete();
    }
    
    ai_spawners = getentarray( "kgb_hq_guard", "targetname" );
    
    foreach ( thing in ai_spawners )
    {
        thing delete();
    }
    
    sounds = getentarray( "snd tmp_sfx_kgb_computer_camera_idle_lp", "targetname" );
    
    foreach ( thing in sounds )
    {
        thing delete();
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x90d4df0, Offset: 0x5a00
// Size: 0x2f4
function function_46606f13()
{
    level flag::wait_till( "level_is_go" );
    counter = 0;
    var_1d96ee7e = doors::get_doors( undefined, undefined, 1 );
    
    for ( i = 0; i < var_1d96ee7e.size ; i++ )
    {
        if ( isdefined( var_1d96ee7e[ i ] ) && isdefined( var_1d96ee7e[ i ].script_noteworthy ) && issubstr( var_1d96ee7e[ i ].script_noteworthy, "%" ) )
        {
            placement = getsubstr( var_1d96ee7e[ i ].script_noteworthy, 0, 1 );
            model_str = getsubstr( var_1d96ee7e[ i ].script_noteworthy, 2 );
            var_52a1179e = var_1d96ee7e[ i ] doors::function_73f09315();
            
            if ( model_str == "surveillance" || model_str == "armory" || model_str == "interrogation" )
            {
                var_52a1179e attach( "p9_rus_door_placard_plastic_01", "door_plate_" + placement );
            }
            else
            {
                var_52a1179e attach( "p9_rus_door_placard_gold_01", "door_plate_" + placement );
            }
            
            counter++;
            waitframe( 1 );
            var_52a1179e attach( "p9_rus_door_placard_text_01_" + model_str, "door_plate_" + placement );
            waitframe( 1 );
            var_52a1179e function_aa042bc7( model_str, "door_plate_" + placement, i );
        }
        
        waitframe( 1 );
    }
    
    armory_door = doors::function_73f09315( "armory_door", "targetname" );
    armory_door attach( "p9_rus_door_placard_plastic_01", "door_plate_b" );
    waitframe( 1 );
    armory_door attach( "p9_rus_door_placard_text_01_" + "armory", "door_plate_b" );
    waitframe( 1 );
    armory_door function_aa042bc7( "armory", "door_plate_b", 72 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xa5358d71, Offset: 0x5d00
// Size: 0x2c
function function_9c6f33d9( *params )
{
    self clientfield::set( "clf_rob_char_burn", 1 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x2165cdc1, Offset: 0x5d38
// Size: 0x2c
function function_5dadde51( *params )
{
    self clientfield::set( "clf_rob_torch_cut", 1 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xa6ba2251, Offset: 0x5d70
// Size: 0x5c
function function_ada6d016()
{
    videostart( "cp_rus_kgb_screen_ambient_grid", 1 );
    level flag::wait_till( "flag_cleanup_kgb_hq" );
    videostop( "cp_rus_kgb_screen_ambient_grid" );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x2096815e, Offset: 0x5dd8
// Size: 0x100
function function_249a18d5( *params )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitresult = self waittill( #"damage" );
        
        if ( isdefined( waitresult.attacker ) && isplayer( waitresult.attacker ) )
        {
            if ( waitresult.amount > 0 && damagefeedback::dodamagefeedback( waitresult.weapon, waitresult.attacker ) )
            {
                waitresult.attacker damagefeedback::update( waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self );
            }
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x76bb6c89, Offset: 0x5ee0
// Size: 0x5c
function function_8191bcdc( var_50cc0d4f = 0 )
{
    if ( var_50cc0d4f )
    {
        level flag::wait_till( "level_is_go" );
    }
    
    doors::close_all();
    doors::function_f35467ac();
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x3aa9f770, Offset: 0x5f48
// Size: 0xf2
function function_c2c71c9f()
{
    level flag::wait_till( "level_is_go" );
    level.var_31c52203 = getentarray( "translate_trig", "targetname" );
    
    for ( i = 0; i < level.var_31c52203.size ; i++ )
    {
        string = "poi_trig" + string( i );
        namespace_93648050::register_trigger( hash( string ), level.var_31c52203[ i ], function_50de5cd0( level.var_31c52203[ i ] ), 256 );
        waitframe( 1 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xe6bffa56, Offset: 0x6048
// Size: 0x19a
function function_50de5cd0( poi )
{
    switch ( poi.script_noteworthy )
    {
        case #"hash_18d800872b06dc78":
            return #"hash_bf89fcd37dbdd7e";
        case #"hash_69474b7b1e2c98d1":
            return #"hash_5ec53fb034c31e3";
        case #"hash_687373550dc300ce":
            return #"hash_3029a65b4a3023cc";
        case #"hash_589ccf1c22b789d9":
            return #"hash_1a19a8fc42fd1e5b";
        case #"hash_37631412a3176b69":
            return #"hash_662c750fc4498163";
        case #"hash_33d0a3692293faf5":
            return #"hash_14a60afd57606417";
        case #"hash_6f8388bf8f055655":
            return #"hash_6a7f700f0af3ee03";
        case #"checkpoint":
            return #"hash_4fbba325ec087684";
        case #"checkin":
            return #"hash_2b60ed399e083c9d";
        case #"hash_2f1f3dc2c2b06f6a":
            return #"hash_7b2a4429e4988509";
        case #"hash_2f1f3cc2c2b06db7":
            return #"hash_7b2a4129e4987ff0";
    }
    
    return #"hash_bf89fcd37dbdd7e";
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 4
// Checksum 0x63b459e6, Offset: 0x61f0
// Size: 0x394
function function_aa042bc7( model_str, tag, count, struct )
{
    door = self;
    string = #"hash_1052bba5d3331092";
    
    switch ( model_str )
    {
        case #"administration":
            string = #"hash_4a19f90f2c521912";
            break;
        case #"armory":
            string = #"hash_80aa6423a7c88a1";
            break;
        case #"generals_office":
            string = #"hash_37ff45ed9912fbb9";
            break;
        case #"interrogation":
            string = #"hash_87f830cf1e9423b";
            break;
        case #"hash_1f5964a2ce98072e":
            string = #"hash_253552a0d5afc38c";
            break;
        case #"hash_36cbe57b5bdfd2fd":
            string = #"hash_f5589b0a07b3af3";
            break;
        case #"security_room":
            string = #"hash_544de4095edc91a5";
            break;
        case #"hash_4c9bb3622c7037":
            string = #"hash_13ac61f9b529bc8e";
            break;
        case #"surveillance":
            string = #"hash_5cfbfb53294091e7";
            break;
        case #"hash_1ca67e40febfcfba":
            string = #"hash_70ab4a44d4c451f6";
            break;
        case #"conference_room":
            string = #"hash_9cd6829ef3f06bd";
            break;
        case #"hash_7384a5c9db2004f6":
            string = #"hash_b6c6b6537e726cb";
            break;
        case #"lavatory":
            string = #"hash_1049106f475a8ac1";
            break;
        case #"hash_7a5dd5c637b247f7":
            string = #"hash_1052bba5d3331092";
            break;
        case #"war_room":
            string = #"hash_34ef3274188fa633";
            break;
    }
    
    if ( !isdefined( struct ) )
    {
        struct = spawnstruct();
        struct.origin = door gettagorigin( tag );
        angles = door gettagangles( tag );
        struct.angles = ( angles[ 0 ], angles[ 1 ] - 90, 0 );
    }
    
    namespace_93648050::register_rect( hash( model_str + string( count ) ), struct.origin, struct.angles, 40, 32, string, 128, door );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xc3d709cf, Offset: 0x6590
// Size: 0x134
function function_3f2f4ef1()
{
    player = getplayers()[ 0 ];
    self endon( #"death" );
    
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    blend_time = 1;
    wait_time = 1;
    level flag::wait_till( "flag_start_finding_ways" );
    
    while ( isalive( self ) )
    {
        if ( self cansee( player ) )
        {
            self lookatentity( player, 1, 0, 0, blend_time );
            wait blend_time;
            
            while ( self cansee( player ) )
            {
                wait 0.5;
            }
            
            self lookatentity();
            wait wait_time;
        }
        
        wait wait_time;
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xefc5fc2d, Offset: 0x66d0
// Size: 0xfc
function gasmask_on( var_f6c2c3e8 = 0 )
{
    if ( is_true( self.gasmask_on ) )
    {
        return;
    }
    
    if ( is_true( var_f6c2c3e8 ) )
    {
        level lui::screen_fade_out( 0.3, "black" );
    }
    
    self function_123fe6d1();
    self.gasmask_on = 1;
    self clientfield::set_to_player( "gasmask_clf", 1 );
    
    if ( is_true( var_f6c2c3e8 ) )
    {
        wait 0.1;
        level thread lui::screen_fade_in( 0.3 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x4fe0753b, Offset: 0x67d8
// Size: 0x4c
function function_eeb18216()
{
    if ( is_false( self.gasmask_on ) )
    {
        return;
    }
    
    self.gasmask_on = undefined;
    self clientfield::set_to_player( "gasmask_clf", 0 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xd0771645, Offset: 0x6830
// Size: 0x64
function function_622fd34b()
{
    if ( is_true( self.var_622fd34b ) )
    {
        return;
    }
    
    self function_eeb18216();
    self.var_622fd34b = 1;
    self clientfield::set_to_player( "exfilmask_clf", 1 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xaea790a4, Offset: 0x68a0
// Size: 0x4c
function function_123fe6d1()
{
    if ( is_false( self.var_622fd34b ) )
    {
        return;
    }
    
    self.var_622fd34b = undefined;
    self clientfield::set_to_player( "exfilmask_clf", 0 );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xde923eee, Offset: 0x68f8
// Size: 0x8c
function function_6f6eae4( *params )
{
    if ( self isattached( "c_t9_cp_rus_kgb_hq_vip_belikov_head_gasmask" ) )
    {
        self detach( "c_t9_cp_rus_kgb_hq_vip_belikov_head_gasmask" );
    }
    
    if ( !self isattached( "c_t9_cp_rus_kgb_hq_vip_belikov_head_injured" ) )
    {
        self attach( "c_t9_cp_rus_kgb_hq_vip_belikov_head_injured" );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xedaa540b, Offset: 0x6990
// Size: 0x8c
function function_89dd500( *params )
{
    if ( self isattached( "c_t9_cp_rus_kgb_hq_vip_belikov_head_injured" ) )
    {
        self detach( "c_t9_cp_rus_kgb_hq_vip_belikov_head_injured" );
    }
    
    if ( !self isattached( "c_t9_cp_rus_kgb_hq_vip_belikov_head_gasmask" ) )
    {
        self attach( "c_t9_cp_rus_kgb_hq_vip_belikov_head_gasmask" );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x7aed9267, Offset: 0x6a28
// Size: 0x1a2
function function_23f254a8()
{
    level endon( #"flag_keycard_acquired" );
    level flag::wait_till( "level_is_go" );
    level.var_74226976 = 0;
    level.var_7247a717 = getentarray( "vol_body_hide", "targetname" );
    player = getplayers()[ 0 ];
    
    for ( i = 0; i < level.var_7247a717.size ; i++ )
    {
        level.var_7247a717[ i ] thread function_8017ace8( i );
    }
    
    while ( !level flag::get( "flag_player_swap" ) )
    {
        corpses = getcorpsearray();
        
        if ( isdefined( corpses ) && corpses.size && !player namespace_5f6e61d9::function_cad84e26() )
        {
            for ( i = 0; i < corpses.size ; i++ )
            {
                if ( !isdefined( corpses[ i ].var_da8f250b ) )
                {
                    corpses[ i ] thread function_9faff133();
                }
                
                waitframe( 1 );
            }
            
            corpses = [];
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x3f62080, Offset: 0x6bd8
// Size: 0x336
function function_9faff133()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    level.var_74226976 += 1;
    count = 0;
    var_115f509b = hash( "dead_body" + string( count ) );
    
    for ( result = objectives::function_285e460( var_115f509b ); isdefined( result ) ; result = objectives::function_285e460( var_115f509b ) )
    {
        count += 1;
        var_115f509b = hash( "dead_body" + string( count ) );
    }
    
    self.var_da8f250b = 1;
    player = getplayers()[ 0 ];
    player endon( #"death" );
    self.var_da8f250b = self function_127e0d08();
    
    if ( !self function_127e0d08() )
    {
        objectives::function_4eb5c04a( var_115f509b, self.origin, undefined, 0 );
        objectives_ui::function_49dec5b( var_115f509b, undefined, #"hash_5388b954d3f585fd" );
        
        while ( !self function_127e0d08() && !level flag::get( "flag_keycard_acquired" ) )
        {
            if ( player namespace_5f6e61d9::function_cad84e26() || function_749b1301( self ) )
            {
                objectives::hide( var_115f509b );
                
                while ( player namespace_5f6e61d9::function_cad84e26() || function_749b1301( self ) )
                {
                    waitframe( 1 );
                }
                
                objectives::show( var_115f509b );
                
                if ( self function_127e0d08() )
                {
                    break;
                }
            }
            
            if ( self function_127e0d08() )
            {
                break;
            }
            else if ( isdefined( self getcorpsephysicsorigin() ) )
            {
                objectives::update_position( var_115f509b, self getcorpsephysicsorigin() + ( 0, 0, 4 ) );
            }
            
            waitframe( 1 );
        }
        
        waitframe( 1 );
        objectives::remove( var_115f509b );
    }
    
    if ( isdefined( self ) )
    {
        self.var_da8f250b = undefined;
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x412b8a67, Offset: 0x6f18
// Size: 0x128, Type: bool
function function_749b1301( body )
{
    if ( !isdefined( body ) )
    {
        return true;
    }
    
    player = getplayers()[ 0 ];
    corpse_origin = body getcorpsephysicsorigin();
    
    if ( !isdefined( body ) )
    {
        return true;
    }
    
    var_1ba06d7d = getdvarint( #"hash_4b04afdbb8712861", 2048 );
    z_max = 128;
    var_1f7b35d3 = z_max > abs( player.origin[ 2 ] - corpse_origin[ 2 ] );
    dist_to_check = distance2dsquared( corpse_origin, player.origin );
    var_b31cc77f = var_1ba06d7d * var_1ba06d7d;
    
    if ( var_b31cc77f < dist_to_check )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xa7f3fbec, Offset: 0x7048
// Size: 0x324
function function_8017ace8( count )
{
    vol = self;
    
    if ( isdefined( vol.target ) )
    {
        scene = "bodystash_locker_a_locker";
        struct = struct::get( vol.target, "targetname" );
        
        if ( isdefined( struct.script_noteworthy ) && issubstr( struct.script_noteworthy, "cabinet" ) )
        {
            scene = "bodystash_cabinet_a_cabinet";
        }
        
        vol.locker = getent( struct.target, "targetname" );
        vol.locker useanimtree( "generic" );
        vol.locker animation::first_frame( scene, struct.origin, struct.angles );
    }
    
    player = getplayers()[ 0 ];
    
    while ( !player function_21a15560() )
    {
        waitframe( 1 );
    }
    
    obj_string = hash( "dead_body_closet" + string( count ) );
    objectives::function_4eb5c04a( obj_string, self.origin + ( 0, 0, 16 ), undefined, 0 );
    objectives_ui::function_49dec5b( obj_string, undefined, #"hash_558176fc056a712d" );
    objectives::hide( obj_string );
    vol.door = function_3203f263();
    vol.occupied = 0;
    
    if ( isdefined( vol.target ) )
    {
        vol thread function_90df6efd();
    }
    
    while ( !level flag::get( "flag_player_swap" ) && !self.occupied )
    {
        waitframe( 1 );
        
        if ( !self.occupied && player function_21a15560() && function_9dc3052d( self ) )
        {
            objectives::show( obj_string );
            player function_152a4ed7( self );
            objectives::hide( obj_string );
        }
        
        waitframe( 1 );
    }
    
    objectives::hide( obj_string );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xb9cc0873, Offset: 0x7378
// Size: 0x6a
function function_152a4ed7( vol )
{
    player = self;
    player endon( #"hash_4dff86580406a1af" );
    
    while ( player function_21a15560() && function_9dc3052d( vol ) )
    {
        waitframe( 1 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x50d556b8, Offset: 0x73f0
// Size: 0x22
function function_21a15560()
{
    player = self;
    return player namespace_5f6e61d9::function_cad84e26();
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x5883dfec, Offset: 0x7420
// Size: 0x12c
function function_90df6efd()
{
    vol = self;
    struct = struct::get( vol.target, "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag.vol = vol;
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 38 ), #"hash_2ad0d508321e892a", 48, undefined, &function_4b6604fa, undefined, 128, undefined, 0, 1, 1, &function_fd36eef2 );
    tag prompts::function_3171730f( #"use", #"body_carry" );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x9560c148, Offset: 0x7558
// Size: 0x84
function function_4b6604fa( *prompt )
{
    player = getplayers()[ 0 ];
    
    if ( player flag::get( "body_shield_active" ) )
    {
        player function_afe4fe22( self );
        return;
    }
    
    player function_4afadee4( self );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xcc2ca385, Offset: 0x75e8
// Size: 0x160
function function_4afadee4( prompt )
{
    player = self;
    vol = prompt.vol;
    scene = "scene_kgb_stash_body_locker";
    struct = struct::get( vol.target, "targetname" );
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        scene = struct.script_noteworthy;
    }
    
    vol.locker.targetname = "stash_locker";
    player namespace_5f6e61d9::function_d0cb2574( scene, struct );
    player.var_9ebbaa46.var_7e5a6cf9 = 1;
    player notify( #"hash_4dff86580406a1af" );
    vol.occupied = 1;
    player waittill( #"hash_51c6ae96a7e40432" );
    player.var_9ebbaa46.var_7e5a6cf9 = undefined;
    player namespace_5f6e61d9::function_b5b485f1();
    vol.locker.targetname = "used_locker";
    level notify( #"hash_7158dbd72a2043b0" );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x1cbb65b7, Offset: 0x7750
// Size: 0x1d8
function function_afe4fe22( prompt )
{
    player = self;
    vol = prompt.vol;
    scene = "scene_kgb_stash_body_locker";
    struct = struct::get( vol.target, "targetname" );
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        scene = struct.script_noteworthy;
    }
    
    vol.locker.targetname = "stash_locker";
    var_38e7c2dd = spawnstruct();
    var_38e7c2dd.scene_root = struct;
    var_38e7c2dd.var_4a561920 = scene;
    var_38e7c2dd.var_a19f500a = 1;
    actor = player.takedown.body_shield.actor;
    actor stopanimscripted();
    player actions::function_d0cba98( "body_shield", var_38e7c2dd );
    player actions::function_8488e359( "stance" );
    vol.occupied = 1;
    wait 7.5;
    player actions::function_d0cba98( "body_shield", undefined );
    vol.locker.targetname = "used_locker";
    
    if ( isdefined( actor ) )
    {
        actor delete();
    }
    
    level notify( #"hash_7158dbd72a2043b0" );
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x596faa89, Offset: 0x7930
// Size: 0x5a, Type: bool
function function_fd36eef2( *prompt )
{
    player = getplayers()[ 0 ];
    return player function_21a15560() && !self.vol.occupied;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0x93e69fea, Offset: 0x7998
// Size: 0x19e, Type: bool
function function_9dc3052d( vol )
{
    player = getplayers()[ 0 ];
    var_c1fbe4bf = getdvarint( #"hash_a794df2c802865c", 2048 );
    z_max = 128;
    var_1f7b35d3 = z_max > abs( player.origin[ 2 ] - vol.origin[ 2 ] );
    
    if ( var_c1fbe4bf * var_c1fbe4bf > distance2dsquared( vol.origin, player.origin ) && var_1f7b35d3 )
    {
        return true;
    }
    
    var_5d7caad2 = [];
    
    for ( i = 0; i < level.var_7247a717.size ; i++ )
    {
        if ( !level.var_7247a717[ i ].occupied )
        {
            var_5d7caad2[ var_5d7caad2.size ] = level.var_7247a717[ i ];
        }
    }
    
    areas = array::quick_sort( var_5d7caad2, &function_e20ca101 );
    
    if ( areas[ 0 ] == vol )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 2
// Checksum 0x796e5e66, Offset: 0x7b40
// Size: 0x9c, Type: bool
function function_e20ca101( left, right )
{
    player = getplayers()[ 0 ];
    var_a7e7fc15 = distance2dsquared( player.origin, left.origin );
    var_a0e7d4aa = distance2dsquared( player.origin, right.origin );
    return var_a7e7fc15 < var_a0e7d4aa;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x9d442b23, Offset: 0x7be8
// Size: 0x110, Type: bool
function function_127e0d08()
{
    if ( !isdefined( self ) )
    {
        return true;
    }
    
    for ( i = 0; i < level.var_7247a717.size ; i++ )
    {
        if ( isdefined( self ) && istouching( self getcorpsephysicsorigin(), level.var_7247a717[ i ] ) && !level.var_7247a717[ i ] function_cb587437() && !isdefined( level.var_7247a717[ i ].target ) )
        {
            return true;
        }
    }
    
    if ( !ispointonnavmesh( self getcorpsephysicsorigin() ) )
    {
        level notify( #"hash_2e50440663441b0a" );
        return true;
    }
    
    return false;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x6834523a, Offset: 0x7d00
// Size: 0xc8
function function_3203f263()
{
    vol = self;
    doors = doors::get_doors();
    
    foreach ( door in doors )
    {
        if ( door.c_door.m_e_door istouching( vol ) )
        {
            return door;
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xeba545bb, Offset: 0x7dd0
// Size: 0x3a
function function_cb587437()
{
    vol = self;
    
    if ( !isdefined( vol.door ) )
    {
        return 0;
    }
    
    return vol.door doors::is_open();
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xa8c654e1, Offset: 0x7e18
// Size: 0xb0
function function_6921f511()
{
    player = self;
    
    for ( i = 0; i < level.var_7247a717.size ; i++ )
    {
        if ( player istouching( level.var_7247a717[ i ] ) && isdefined( level.var_7247a717[ i ].target ) && !level.var_7247a717[ i ].occupied )
        {
            return level.var_7247a717[ i ];
        }
    }
    
    return undefined;
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xdb32f956, Offset: 0x7ed0
// Size: 0xe2
function function_131346ae()
{
    player = self;
    
    for ( i = 0; i < level.var_7247a717.size ; i++ )
    {
        if ( player istouching( level.var_7247a717[ i ] ) && !level.var_7247a717[ i ].occupied )
        {
            if ( isdefined( level.var_7247a717[ i ].target ) )
            {
                return struct::get( level.var_7247a717[ i ].target, "targetname" );
            }
            
            return level.var_7247a717[ i ];
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0xc265f721, Offset: 0x7fc0
// Size: 0x32
function function_b1a085b4()
{
    player = self;
    
    while ( isdefined( player function_6921f511() ) )
    {
        waitframe( 1 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x1ae7e268, Offset: 0x8000
// Size: 0xaa
function function_c4de67de()
{
    a_enemies = getaiarray( "axis" );
    
    foreach ( ai in a_enemies )
    {
        if ( isdefined( ai.propername ) )
        {
            ai.propername = undefined;
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 3
// Checksum 0x2754eb3b, Offset: 0x80b8
// Size: 0xf0
function function_378ac0da( targetname, n_rate = 1, str_anim = undefined )
{
    var_cf034495 = getentarray( targetname, "targetname" );
    
    if ( isdefined( var_cf034495 ) )
    {
        foreach ( e_model in var_cf034495 )
        {
            if ( isdefined( str_anim ) )
            {
                e_model thread animation::play_siege( str_anim, n_rate );
            }
        }
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 0
// Checksum 0x571f4da1, Offset: 0x81b0
// Size: 0x128
function placed_suspended_weapons()
{
    placed_suspended_weapons_linker_org = struct::get( "placed_suspended_weapons_linker_org", "targetname" );
    var_e777609 = util::spawn_model( "tag_origin", placed_suspended_weapons_linker_org.origin, placed_suspended_weapons_linker_org.angles );
    var_e777609 hide();
    placed_suspended_weapons = getentarray( "placed_suspended_weapons", "script_noteworthy" );
    
    foreach ( weapon in placed_suspended_weapons )
    {
        weapon linkto( var_e777609 );
    }
}

// Namespace namespace_e77bf565/namespace_1b5c93f4
// Params 1
// Checksum 0xa8a3da2c, Offset: 0x82e0
// Size: 0x5c
function function_f6eb250d( state = "cinematicmotion_kgb" )
{
    player = getplayers()[ 0 ];
    player setcinematicmotionoverride( state );
}

