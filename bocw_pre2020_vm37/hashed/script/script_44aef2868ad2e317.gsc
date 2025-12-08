#using script_13114d8a31c6152a;
#using script_146fc25c29195773;
#using script_1cdcb9e0e5c220f6;
#using script_1fd2c6e5fc8cb1c3;
#using script_35ae72be7b4fec10;
#using script_3626f1b2cf51a99c;
#using script_396062ed2667195d;
#using script_3dc93ca9902a9cda;
#using script_4134e1e2e7684c4c;
#using script_4ab78e327b76395f;
#using script_4ec222619bffcfd1;
#using script_52da18c20f45c56a;
#using script_5431e074c1428743;
#using script_779f525443585713;
#using script_7cc5fb39b97494c4;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\lockpick;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\group;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\ui\interactive_map;
#using scripts\cp_common\util;

#namespace kgb_ins_prepare;

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xb2e6bed, Offset: 0x3a68
// Size: 0x104
function starting( *var_d3440450 )
{
    level thread scene::init( "scene_kgb_poison_tea" );
    level thread scene::init( "scene_kgb_elevator_holdup" );
    level thread scene::init( "scene_kgb_walkup_adler" );
    level.checkpoint_clip = getent( "checkpoint_clip", "targetname" );
    level.checkpoint_clip notsolid();
    level.checkpoint_clip_right = getent( "checkpoint_clip_right", "targetname" );
    level.checkpoint_clip_right notsolid();
    level thread namespace_99e99ffa::function_1d90bc4a();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0xd1383134, Offset: 0x3b78
// Size: 0x40c
function main( var_d3440450, var_50cc0d4f )
{
    level.var_b3cae252 = 0;
    setdvar( #"hash_1f09fb5b6cdc92a6", 1 );
    setdvar( #"hash_9a20796273cbf1d", 1 );
    setdvar( #"hash_a794df2c802865c", 650 );
    setdvar( #"hash_4b04afdbb8712861", 750 );
    
    /#
        if ( getdvarint( #"hash_4aca8a00cde42180", 0 ) )
        {
            level flag::set( "<dev string:x38>" );
        }
    #/
    
    player = getplayers()[ 0 ];
    
    if ( is_true( var_50cc0d4f ) )
    {
        level function_52f0fcb3();
        level function_84d00884();
        level thread namespace_99e99ffa::function_99e99ffa( var_d3440450 );
        level thread namespace_e77bf565::function_ada6d016();
        
        if ( namespace_94c47ce5::function_11b2b847() )
        {
            level flag::set( "informant_alive" );
        }
        
        level flag::set( "flag_start_finding_ways" );
        level flag::set( "flag_poi_camera_done" );
        level flag::set( "flag_tutorial_map_complete" );
        level flag::set( "disable_all_cameras" );
        level thread function_7f81c6e4();
        level thread function_3b309153();
        level thread function_6cbe4283();
        player thread util::function_5b2f930e( 4, #"uie_ui_hud_cp_actionslot_icon_map" );
    }
    
    level thread function_a58aee07();
    level thread function_1c20e038();
    level flag::wait_till( "flag_keycard_acquired" );
    function_6bf59c81();
    namespace_353d803e::music( "6.0_basement" );
    bb::function_cd497743( "keycard_acquired", getplayers()[ 0 ] );
    objectives::remove( #"map_waypoint" );
    level thread kgb_ins_rv::function_1f4d29f8();
    level thread function_799b3854();
    level flag::wait_till( "flag_open_basement" );
    level thread function_c7476e69();
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x31bb6c5a, Offset: 0x3f90
// Size: 0x11c
function function_6cbe4283()
{
    function_dc6c4b5e();
    level thread function_33e0fa9c();
    level thread function_16e85ca5();
    level thread function_a8f549f8();
    level thread function_2930697c();
    level thread function_ed39356a();
    level thread namespace_e77bf565::function_23f254a8();
    level thread function_50d280db();
    level thread function_e873b4cd();
    level thread function_5b366e56();
    level thread function_7953c722();
    level thread function_2388bc70();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8c5896cc, Offset: 0x40b8
// Size: 0xd4
function function_a58aee07()
{
    blocker = getent( "frisk_blocker", "targetname" );
    blocker notsolid();
    level thread function_e7fcf8ef();
    level thread function_ada5392f();
    level thread function_682ba64c();
    level thread file_room();
    level thread function_c1a40cd6();
    level thread namespace_94c47ce5::function_9b596d4d();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 4
// Checksum 0x9b29eb2b, Offset: 0x4198
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5b988d2e, Offset: 0x41c8
// Size: 0x1484
function init_flags()
{
    level flag::init( "flag_in_dialogue" );
    level flag::init( "flag_tutorial_1" );
    level flag::init( "flag_tutorial_2" );
    level flag::init( "flag_tutorial_3" );
    level flag::init( "flag_attempted_lockpick" );
    level flag::init( "flag_camera_guy_dead" );
    level flag::init( "flag_tutorial_map_complete" );
    level flag::init( "ins_prepare_complete" );
    level flag::init( "flag_contacted" );
    level flag::init( "flag_got_keycard" );
    level flag::init( "flag_objective_keycard" );
    level flag::init( "flag_start_finding_ways" );
    level flag::init( "flag_weapon_fail" );
    level flag::init( "flag_social_stealth_hint" );
    level flag::init( "flag_hide_social_hint" );
    level flag::init( "flag_map_tutorial" );
    level flag::init( "flag_player_killed_someone" );
    level flag::init( "kgb_can_see" );
    level flag::init( "flag_detected_action" );
    level flag::init( "corpse_found" );
    level flag::init( "flag_send_front" );
    level flag::init( "flag_send_armory" );
    level flag::init( "flag_send_prison" );
    level flag::init( "flag_send_elevator" );
    level flag::init( "flag_room_chosen" );
    level flag::init( "ponderered_order" );
    level flag::init( "flag_picked_question" );
    level flag::init( "flag_pick_order" );
    level flag::init( "flag_first_chat" );
    level flag::init( "dialog_flag_send_front" );
    level flag::init( "dialog_flag_send_armory" );
    level flag::init( "dialog_flag_send_prison" );
    level flag::init( "dialog_flag_send_elevator" );
    level flag::init( "flag_guy_at_post" );
    level flag::init( "flag_guard_kill" );
    level flag::init( "flag_guard_swap" );
    level flag::init( "flag_guard_program" );
    level flag::init( "flag_start_swap_quest" );
    level flag::init( "flag_start_kill_quest" );
    level flag::init( "flag_start_program_quest" );
    level flag::init( "flag_general_prisoner_start" );
    level flag::init( "flag_general_returned" );
    level flag::init( "flag_secretary_done" );
    level flag::init( "flag_route_known" );
    level flag::init( "flag_ask_itinerary" );
    level flag::init( "flag_cup_poisoned" );
    level flag::init( "flag_start_secretary_loop" );
    level flag::init( "flag_secretary_busy" );
    level flag::init( "flag_influence_success" );
    level flag::init( "flag_prisoner_trap" );
    level flag::init( "flag_prisoner_complete" );
    level flag::init( "flag_hint_locked_file" );
    level flag::init( "flag_unlock_prison_door" );
    level flag::init( "flag_prison_guard_wait" );
    level flag::init( "flag_prison_guard_go_away" );
    level flag::init( "flag_prompt_cuffs" );
    level flag::init( "flag_family_options" );
    level flag::init( "flag_checkpoint_moment_done" );
    level flag::init( "flag_got_dummy_card" );
    level flag::init( "flag_start_hack" );
    level flag::init( "flag_hacked_success" );
    level flag::init( "flag_got_spare_card" );
    level flag::init( "flag_radio_cards" );
    level flag::init( "flag_keycard_acquired" );
    level flag::init( "obj_secretary_done" );
    level flag::init( "flag_obj_general_killed" );
    level flag::init( "flag_obj_dummy_keycard_obtained" );
    level flag::init( "in_camera_sight" );
    level flag::init( "flag_body_carry_fail" );
    level flag::init( "fake_civilian_sight" );
    level flag::init( "flag_has_poison" );
    level flag::init( "flag_has_cigar" );
    level flag::init( "flag_mail_sent" );
    level flag::init( "flag_removed_sign" );
    level flag::init( "unlock_door" );
    level flag::init( "flag_removed_vent" );
    level flag::init( "flag_file_room_chat" );
    level flag::init( "flag_unlock_armory" );
    level flag::init( "flag_request_armory" );
    level flag::init( "flag_armory_done" );
    level flag::init( "flag_has_paperwork" );
    level flag::init( "flag_charkov_in_scene" );
    level flag::init( "flag_armory_persuade_01_called" );
    level flag::init( "flag_armory_persuade_02_called" );
    level flag::init( "flag_armory_persuade_03_called" );
    level flag::init( "flag_armory_persuade_04_called" );
    level flag::init( "enable_armory_quest_dialog_cigar" );
    level flag::init( "flag_show_itinerary" );
    level flag::init( "flag_show_mail" );
    level flag::init( "flag_show_computer" );
    level flag::init( "flag_ask_popov" );
    level flag::init( "flag_popov_1" );
    level flag::init( "flag_popov_2" );
    level flag::init( "flag_armory_spoke" );
    level flag::init( "flag_denisov_talk" );
    level flag::init( "flag_denisov_done" );
    level flag::init( "flag_krav_convinced" );
    level flag::init( "flag_player_aware_popov" );
    level flag::init( "flag_player_aware_charkov_poison" );
    level flag::init( "flag_player_aware_secretary_poison" );
    level flag::init( "flag_player_aware_cigar" );
    level flag::init( "flag_player_aware_cigar_death" );
    level flag::init( "flag_poi_office_secretary" );
    level flag::init( "flag_poi_office_cigar" );
    level flag::init( "flag_poi_office_secretary_dead" );
    level flag::init( "flag_poi_office_mail_sent" );
    level flag::init( "flag_poi_office_charkov_dead" );
    level flag::init( "flag_poi_office_done" );
    level flag::init( "flag_poi_office_charkov_front" );
    level flag::init( "flag_poi_office_meeting" );
    level flag::init( "flag_poi_armory_popov_task" );
    level flag::init( "flag_poi_armory_guard" );
    level flag::init( "flag_poi_armory_paperwork" );
    level flag::init( "flag_poi_armory_done" );
    level flag::init( "flag_poi_armory_guy_dead" );
    level flag::init( "flag_poi_armory_open" );
    level flag::init( "flag_poi_data_computer" );
    level flag::init( "flag_poi_data_need_various" );
    level flag::init( "flag_poi_data_need_popov" );
    level flag::init( "flag_poi_data_card" );
    level flag::init( "flag_poi_data_done" );
    level flag::init( "flag_poi_records_file" );
    level flag::init( "flag_poi_records_locked" );
    level flag::init( "flag_poi_records_leverage" );
    level flag::init( "flag_poi_records_done" );
    level flag::init( "flag_poi_camera_done" );
    level flag::init( "flag_poi_mail_found" );
    level flag::init( "flag_poi_mail_cigar" );
    level flag::init( "flag_poi_mail_poison" );
    level flag::init( "flag_poi_mail_ready" );
    level flag::init( "flag_poi_mail_sent" );
    level flag::init( "flag_poi_mail_done" );
    level flag::init( "flag_poi_swap_need" );
    level flag::init( "flag_poi_swap_need_popov" );
    level flag::init( "flag_poi_swap_need_final" );
    level flag::init( "flag_poi_swap_have" );
    level flag::init( "flag_poi_swap_wait" );
    level flag::init( "flag_poi_swap_pass" );
    level flag::init( "flag_poi_swap_fail" );
    level flag::init( "flag_poi_swap_done" );
    level flag::init( "flag_poi_prison_done" );
    level flag::init( "flag_poi_interrogation_file" );
    level flag::init( "flag_poi_interrogation_leverage" );
    level flag::init( "flag_poi_interrogation_uncuff" );
    level flag::init( "flag_poi_interrogation_wait" );
    level flag::init( "flag_poi_interrogation_take" );
    level flag::init( "flag_poi_interrogation_done" );
    level flag::init( "flag_start_prisoner_breadcrumb" );
    level flag::init( "flag_picked_poison" );
    level flag::init( "flag_player_drink" );
    level flag::init( "flag_start_charkov_investigation" );
    level flag::init( "flag_start_tea_roulette" );
    level flag::init( "flag_charkov_looking" );
    level flag::init( "flag_chose_distract" );
    level flag::init( "player_sat_in_charkovs_office" );
    level flag::init( "charkov_has_cup_1" );
    level flag::init( "player_in_restricted_area" );
    level flag::init( "restricted_area_first_entered" );
    level flag::init( "false_intel_printed" );
    level flag::init( "has_false_intel" );
    level flag::init( "combination_lock_opened" );
    level flag::init( "combination_lock_exited" );
    level flag::init( "bunker_key_placed_in_world" );
    level flag::init( "file_clerk_dead" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x90e7efaa, Offset: 0x5658
// Size: 0x34
function init_clientfields()
{
    clientfield::register( "scriptmover", "set_camera_fx", 1, 1, "int" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x19c93880, Offset: 0x5698
// Size: 0xa4
function function_22b7fffd()
{
    level scene::add_scene_func( "scene_kgb_interrogation_room_door", &function_9e511069, "init" );
    level scene::init( "scene_kgb_interrogation_room_door" );
    level scene::add_scene_func( "scene_kgb_walkup_gate_guard", &function_5da2f302 );
    level scene::add_scene_func( "scene_kgb_generic_desk_guard", &function_6b524517 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x70ba8d3c, Offset: 0x5748
// Size: 0xb4
function function_c9965ab9( hide )
{
    player = getplayers()[ 0 ];
    
    if ( hide )
    {
        level flag::set( "disable_mental_map" );
        player thread util::function_658a8750( 4 );
        return;
    }
    
    level flag::clear( "disable_mental_map" );
    player thread util::function_5b2f930e( 4, #"uie_ui_hud_cp_actionslot_icon_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x26bbb166, Offset: 0x5808
// Size: 0x6c
function function_7f102a89( var_da1a882e )
{
    for ( i = 0; i < level.var_6d758088.size ; i++ )
    {
        if ( level.var_6d758088[ i ].script_noteworthy == var_da1a882e )
        {
            return level.var_6d758088[ i ].origin;
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x29795403, Offset: 0x5880
// Size: 0x11e, Type: bool
function function_506c6d6f()
{
    if ( !isdefined( level.player_in_restricted_area ) )
    {
        corpses = getcorpsearray();
        
        foreach ( body in corpses )
        {
            body delete();
        }
        
        return true;
    }
    
    corpses = getcorpsearray();
    
    if ( corpses.size )
    {
        for ( i = 0; i < corpses.size ; i++ )
        {
            if ( !corpses[ i ] namespace_e77bf565::function_127e0d08() )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd488f716, Offset: 0x59a8
// Size: 0x3fa
function function_16e85ca5()
{
    level.var_1b4de43 = [];
    
    while ( !level flag::get( "flag_keycard_acquired" ) )
    {
        level waittill( #"ping_map" );
        
        if ( !level flag::get_any( level.var_e9c8a6d4 ) && function_506c6d6f() )
        {
            savegame::function_7790f03();
        }
        
        if ( level flag::get( "flag_keycard_acquired" ) )
        {
            return;
        }
        
        if ( isdefined( level.var_1b4de43 ) )
        {
            foreach ( room in level.var_1b4de43 )
            {
                switch ( room )
                {
                    case #"office":
                        function_dfb343c2( "charkov_office" );
                        function_34b04d5f( "charkov_office", "generalsOfficeState" );
                        break;
                    case #"data":
                        function_dfb343c2( room );
                        function_34b04d5f( room, "technologiesRoomState" );
                        break;
                    case #"checkpoint":
                        function_dfb343c2( room );
                        function_34b04d5f( room, "securityState" );
                        break;
                    case #"interrogation":
                        function_dfb343c2( room );
                        function_34b04d5f( room, "interrogationState" );
                        break;
                    case #"camera":
                        function_dfb343c2( room );
                        function_34b04d5f( room, "cameraRoomState" );
                        break;
                    case #"prison":
                        function_dfb343c2( room );
                        function_34b04d5f( room, "kravchenkoOfficeState" );
                        break;
                    case #"informant":
                        if ( namespace_94c47ce5::function_11b2b847() )
                        {
                            function_34b04d5f( room, "kravchenkoOfficeState" );
                        }
                        
                        break;
                    default:
                        break;
                }
            }
        }
        
        waitframe( 1 );
        namespace_353d803e::function_5865b09e();
        level thread hint_tutorial::function_4c2d4fc4( #"hash_6a484d4f01f5f697", undefined, 8, undefined, 2, 3 );
        player = getplayers()[ 0 ];
        player thread util::function_ae1d1464( 4, 1 );
        level.var_1b4de43 = [];
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x6fdbfa32, Offset: 0x5db0
// Size: 0x17c
function function_dfb343c2( location )
{
    if ( level.quest_objectives[ #"poison_tea" ].tracked )
    {
        interactive_map::function_50121b9( function_7f102a89( "charkov_office" ) );
        return;
    }
    
    if ( level.quest_objectives[ #"making_a_mole" ].tracked )
    {
        interactive_map::function_50121b9( function_7f102a89( "checkpoint" ) );
        return;
    }
    
    if ( level.quest_objectives[ #"prisoner_persuasion" ].tracked )
    {
        interactive_map::function_50121b9( function_7f102a89( "interrogation" ) );
        return;
    }
    
    if ( level.quest_objectives[ #"key_reprogram" ].tracked )
    {
        interactive_map::function_50121b9( function_7f102a89( "data" ) );
        return;
    }
    
    if ( !isdefined( location ) )
    {
        return;
    }
    
    interactive_map::function_50121b9( function_7f102a89( location ) );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xcb151935, Offset: 0x5f38
// Size: 0xcc
function function_6bf59c81()
{
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player endon( #"death" );
    function_73f90a7f();
    namespace_353d803e::function_5865b09e();
    level thread hint_tutorial::function_4c2d4fc4( #"hash_6a484d4f01f5f697", undefined, 8, undefined, 2, 3 );
    player thread util::function_ae1d1464( 4, 1 );
    savegame::function_7790f03();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd70d921c, Offset: 0x6010
// Size: 0xc4
function function_4f55a6c5()
{
    objectives::remove( "obj_map_updated_mail" );
    objectives::remove( "obj_map_updated_armory" );
    objectives::remove( "obj_map_updated_office" );
    objectives::remove( "obj_map_updated_records" );
    objectives::remove( "obj_map_updated_data" );
    objectives::remove( "obj_map_updated_checkpoint" );
    objectives::remove( "obj_map_updated_prisoner" );
    objectives::remove( "obj_map_updated_camera" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb8f2fc7f, Offset: 0x60e0
// Size: 0x2b8
function function_3b309153()
{
    level.var_6d758088 = getentarray( "mental_map_poi", "targetname" );
    
    foreach ( point in level.var_6d758088 )
    {
        model_name = undefined;
        
        switch ( point.script_noteworthy )
        {
            case #"charkov_office":
                point.var_d9b5c896 = #"hash_2a572dd82dffa737";
                model_name = "generalsOfficeState";
                function_2c60d1ba( point );
                break;
            case #"data":
                point.var_d9b5c896 = #"hash_2bb6f605c5e7b52a";
                model_name = "technologiesRoomState";
                function_4ca4fd23( point );
                break;
            case #"camera":
                point.var_d9b5c896 = #"hash_1f3fb2e195d67274";
                function_7733f229( point );
                break;
            case #"checkpoint":
                point.var_d9b5c896 = #"hash_795ca66f92406381";
                model_name = "securityState";
                function_ef7b8da7( point );
                break;
            case #"interrogation":
                point.var_d9b5c896 = #"hash_17ba8a94dd34cf9b";
                model_name = "interrogationState";
                function_731ece55( point );
                break;
            case #"informant":
                if ( namespace_94c47ce5::function_11b2b847() )
                {
                    point.var_d9b5c896 = #"hash_531400ca1362803f";
                    model_name = "kravchenkoOfficeState";
                    function_31cd4ae0( point );
                }
                
                break;
        }
        
        if ( isdefined( model_name ) )
        {
            point interactive_map::function_9bc3d847( #"cursor_on", model_name, 0, 1 );
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc8dc3076, Offset: 0x63a0
// Size: 0x23e
function function_60e6f656()
{
    if ( !level flag::get( "flag_start_finding_ways" ) )
    {
        return;
    }
    
    foreach ( point in level.var_6d758088 )
    {
        switch ( point.script_noteworthy )
        {
            case #"charkov_office":
                point.var_d9b5c896 = #"hash_2a572dd82dffa737";
                model_name = "generalsOfficeState";
                function_2c60d1ba( point );
                break;
            case #"informant":
                if ( namespace_94c47ce5::function_11b2b847() )
                {
                    point.var_d9b5c896 = #"hash_531400ca1362803f";
                    model_name = "kravchenkoOfficeState";
                    function_31cd4ae0( point );
                }
                
                break;
            case #"data":
                point.var_d9b5c896 = #"hash_2bb6f605c5e7b52a";
                model_name = "technologiesRoomState";
                function_4ca4fd23( point );
                break;
            case #"checkpoint":
                point.var_d9b5c896 = #"hash_795ca66f92406381";
                model_name = "securityState";
                function_ef7b8da7( point );
                break;
            case #"interrogation":
                point.var_d9b5c896 = #"hash_17ba8a94dd34cf9b";
                model_name = "interrogationState";
                function_731ece55( point );
                break;
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 3
// Checksum 0xb33bfda0, Offset: 0x65e8
// Size: 0xc8
function function_34b04d5f( var_cbd7502c, model_name, *var_e91f21c1 )
{
    foreach ( point in level.var_6d758088 )
    {
        if ( point.script_noteworthy == model_name )
        {
            point interactive_map::function_9bc3d847( #"cursor_on", var_e91f21c1, 0, 1 );
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x9e32c0d8, Offset: 0x66b8
// Size: 0x198
function function_73f90a7f()
{
    foreach ( point in level.var_6d758088 )
    {
        model_name = undefined;
        
        switch ( point.script_noteworthy )
        {
            case #"charkov_office":
                model_name = "generalsOfficeState";
                break;
            case #"data":
                model_name = "technologiesRoomState";
                break;
            case #"checkpoint":
                model_name = "securityState";
                break;
            case #"interrogation":
                model_name = "interrogationState";
                break;
            case #"camera":
                model_name = "cameraRoomState";
                break;
            case #"informant":
                if ( namespace_94c47ce5::function_11b2b847() )
                {
                }
                
                break;
        }
        
        if ( isdefined( model_name ) )
        {
            point interactive_map::function_9bc3d847( #"cursor_on", model_name, 0, 0 );
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xf4a1ebee, Offset: 0x6858
// Size: 0x16a
function function_2c60d1ba( point )
{
    string = #"hash_1d4171274d456234";
    var_ec2c079e = "";
    
    if ( level flag::get( "flag_player_scheduled_meeting" ) )
    {
        string = #"hash_1d4172274d4563e7";
        var_ec2c079e = "";
    }
    
    if ( level flag::get( "flag_poi_mail_poison" ) )
    {
        string = #"hash_1d4173274d45659a";
        var_ec2c079e = "";
    }
    
    if ( level flag::get( "flag_poi_office_meeting" ) )
    {
        string = #"hash_1d4174274d45674d";
        var_ec2c079e = "";
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
    }
    
    updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return updated;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x5c52cef5, Offset: 0x69d0
// Size: 0x7a
function function_31cd4ae0( point )
{
    string = #"hash_e68f47da83d6ce4";
    
    if ( level flag::get( "flag_informant_killed" ) )
    {
        point.var_d9b5c896 = #"hash_154e518c3486a457";
        string = #"hash_e68f57da83d6e97";
    }
    
    point.var_94ca2a30 = string;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xe81d7733, Offset: 0x6a58
// Size: 0x1da
function function_ff544ce6( point )
{
    string = #"hash_14482609a6c3e71a";
    var_ec2c079e = "vox_cp_rkgb_01940_blkv_thearmoryhasrep_63";
    
    if ( level flag::get( "flag_poi_armory_guard" ) )
    {
        string = #"hash_14482709a6c3e8cd";
        var_ec2c079e = "vox_cp_rkgb_01940_blkv_theguardwontlet_09";
    }
    
    if ( level flag::get( "flag_poi_armory_paperwork" ) )
    {
        string = #"hash_14482409a6c3e3b4";
        var_ec2c079e = "vox_cp_rkgb_01940_blkv_ihavethepaperwo_ef";
    }
    
    if ( level flag::get( "flag_poi_armory_guy_dead" ) )
    {
        string = #"hash_14482509a6c3e567";
        var_ec2c079e = "vox_cp_rkgb_01940_blkv_nowthativedealt_8d";
    }
    
    if ( level flag::get( "flag_poi_armory_open" ) )
    {
        string = #"hash_3a7bf5665ede2932";
        var_ec2c079e = "vox_cp_rkgb_01940_blkv_thearmoryhasrep_63";
    }
    
    if ( level flag::get( "flag_poi_armory_done" ) )
    {
        string = #"hash_14482209a6c3e04e";
        var_ec2c079e = "vox_cp_rkgb_01940_blkv_nowthatihavethe_80";
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
    }
    
    updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return updated;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x8154f9e4, Offset: 0x6c40
// Size: 0x212
function function_4ca4fd23( point )
{
    string = #"hash_701c560151221bf0";
    var_ec2c079e = "vox_cp_rkgb_01930_blkv_icouldreprogram_34";
    
    if ( level flag::get( "flag_request_armory" ) )
    {
        string = #"hash_701c570151221da3";
    }
    
    if ( level flag::get( "flag_armory_persuade_03_called" ) )
    {
        string = #"hash_2245993cdcf890a6";
    }
    
    if ( level flag::get_any( [ "flag_has_cigar", "flag_has_paperwork" ] ) && level flag::get( "flag_request_armory" ) )
    {
        string = #"hash_701c580151221f56";
    }
    
    if ( level flag::get_any( [ "flag_poi_armory_open", "flag_poi_armory_guy_dead" ] ) )
    {
        string = #"hash_2248c13cdcfb0a75";
    }
    
    if ( level flag::get( "flag_got_spare_card" ) )
    {
        string = #"hash_701c590151222109";
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
    }
    
    updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return updated;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x941596ef, Offset: 0x6e60
// Size: 0xfa
function function_7733f229( point )
{
    string = #"hash_4082e645a7a60d6f";
    var_ec2c079e = "vox_cp_rkgb_01970_blkv_thecameracontro_34";
    
    if ( level flag::get( "flag_poi_camera_done" ) )
    {
        string = #"hash_4082e545a7a60bbc";
        var_ec2c079e = "vox_cp_rkgb_01930_blkv_inolongerhaveus_68";
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
    }
    
    updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return updated;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x6bd8da60, Offset: 0x6f68
// Size: 0xfc, Type: bool
function function_8d39c999( point )
{
    string = #"hash_93d7d1547a7789b";
    var_ec2c079e = "";
    
    if ( level flag::get( "false_intel_printed" ) )
    {
        string = #"hash_93d7c1547a776e8";
        var_ec2c079e = "";
    }
    
    if ( level flag::get( "has_false_intel" ) )
    {
        string = #"hash_93d7f1547a77c01";
        var_ec2c079e = "";
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "";
    }
    
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return false;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x499ce57a, Offset: 0x7070
// Size: 0x168, Type: bool
function function_3829cdfd( point )
{
    string = #"hash_3bb1ca1fd8dc18c1";
    var_ec2c079e = "vox_cp_rkgb_01950_blkv_themailroomprov_fc";
    
    if ( level flag::get( "combination_lock_exited" ) )
    {
        string = #"hash_3bb1c91fd8dc170e";
        var_ec2c079e = "vox_cp_rkgb_01930_blkv_inolongerhaveus_68";
    }
    
    if ( level flag::get( "combination_lock_opened" ) )
    {
        string = #"hash_3bb1c81fd8dc155b";
        var_ec2c079e = "vox_cp_rkgb_01930_blkv_inolongerhaveus_68";
    }
    
    if ( level flag::get( "flag_has_poison" ) )
    {
        string = #"hash_3bb1c71fd8dc13a8";
        var_ec2c079e = "vox_cp_rkgb_01930_blkv_inolongerhaveus_68";
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "";
    }
    
    updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return false;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xd7e2ba47, Offset: 0x71e0
// Size: 0x1da
function function_ef7b8da7( point )
{
    string = #"hash_d7a7566c2e78af2";
    var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
    
    if ( level flag::get( "flag_poi_krav_chat" ) )
    {
        string = #"hash_4ea0109d2f7077c9";
        var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
    }
    
    if ( level flag::get( "false_intel_printed" ) )
    {
        string = #"hash_d7a7666c2e78ca5";
        var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
    }
    
    if ( level flag::get( "has_false_intel" ) )
    {
        string = #"hash_d7a7366c2e7878c";
        var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
    }
    
    if ( level flag::get( "flag_poi_krav_wait" ) )
    {
        string = #"hash_d7a7466c2e7893f";
        var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
    }
    
    if ( level flag::get( "flag_poi_krav_opportunity" ) )
    {
        string = #"hash_d7a7166c2e78426";
        var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
    }
    
    updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return updated;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xe17e7367, Offset: 0x73c8
// Size: 0x8c, Type: bool
function function_79b1bbce( point )
{
    string = #"hash_213c1ae19515fbb7";
    var_ec2c079e = "vox_cp_rkgb_01650_blkv_adlerswaitingin_31";
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
    }
    
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return false;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x97407027, Offset: 0x7460
// Size: 0x1da
function function_731ece55( point )
{
    string = #"hash_5839f3936c6b6581";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_charkovisschedu_bb";
    
    if ( level flag::get( "flag_poi_interrogation_file" ) )
    {
        string = #"hash_5839f2936c6b63ce";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_theprisonerwont_82";
    }
    
    if ( level flag::get( "flag_poi_interrogation_leverage" ) )
    {
        string = #"hash_5839f1936c6b621b";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_nowthatiknowthe_2a";
    }
    
    if ( level flag::get( "flag_poi_interrogation_uncuff" ) )
    {
        string = #"hash_5839f0936c6b6068";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_innermonologuet_4b";
    }
    
    if ( level flag::get( "flag_poi_interrogation_wait" ) )
    {
        string = #"hash_5839f7936c6b6c4d";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_charkovwillbehe_7c";
    }
    
    if ( level flag::get( "flag_poi_interrogation_take" ) )
    {
        string = #"hash_5839f6936c6b6a9a";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_charkovisdeadis_aa";
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        string = #"hash_37f052990d63fe14";
        var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
    }
    
    updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
    point.var_ec2c079e = var_ec2c079e;
    point.var_94ca2a30 = string;
    return updated;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x89dcacf, Offset: 0x7648
// Size: 0xec
function function_aa7cd2d6()
{
    player = getplayers()[ 0 ];
    level flag::set( "flag_map_tutorial" );
    player val::set( "options_tutorial", "freezecontrols", 1 );
    level thread function_ae527cb0();
    level flag::wait_till( "flag_show_itinerary" );
    waitframe( 1 );
    level flag::wait_till_clear( "flag_show_itinerary" );
    player val::reset( "options_tutorial", "freezecontrols" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x955d4a0e, Offset: 0x7740
// Size: 0x188
function function_ae527cb0()
{
    player = getplayers()[ 0 ];
    hint_tutorial::function_4c2d4fc4( #"hash_c1552d7f7ecf9bb", #"hash_5a2cb100f420b36c", 2, #"hash_70f26bb1ab701ef8" );
    hint_tutorial::function_df08d48( 10 );
    level flag::wait_till( "flag_show_itinerary" );
    hint_tutorial::function_9f427d88( 0 );
    waitframe( 1 );
    player thread util::show_hint_text( #"hash_22e94f6cef70f4cd", 0, undefined, -1 );
    level flag::wait_till( "flag_tutorial_map_complete" );
    player notify( #"flag_tutorial_map_complete" );
    waitframe( 1 );
    player thread util::show_hint_text( #"hash_1d9e5bec877cc239", 0, "flag_show_itinerary", -1 );
    level flag::wait_till_clear( "flag_show_itinerary" );
    player notify( #"flag_show_itinerary" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x79c2c504, Offset: 0x78d0
// Size: 0x814
function function_399a3c34()
{
    level endon( #"mission_failed" );
    interactive_map::function_87f0056b();
    function_dfb343c2( undefined );
    player = getplayers()[ 0 ];
    function_60e6f656();
    interactive_map::open( #"hash_1981501d7d5644aa" );
    player interactive_map::add_object( #"player", #"uie_map_lubyanka_marker_player", 1, -90 );
    
    if ( !isdefined( level.var_dc5a0371 ) )
    {
        level.var_dc5a0371 = 0;
    }
    
    if ( isdefined( level.general ) )
    {
        level.general interactive_map::add_object( #"general", #"uie_map_lubyanka_marker_target", 0 );
    }
    
    if ( level.var_dc5a0371 && isdefined( level.informant ) )
    {
        level.informant interactive_map::add_object( #"kgb_informant_spawner", level.var_5fc836e5, 0 );
    }
    
    if ( !player gamepadusedlast() )
    {
        setdvar( #"ui_busyblockingamemenu", 1 );
    }
    
    corpses = getcorpsearray();
    tags = [];
    
    if ( corpses.size )
    {
        for ( i = 0; i < corpses.size ; i++ )
        {
            tags[ i ] = spawn( "script_model", corpses[ i ].origin );
            
            if ( !corpses[ i ] namespace_e77bf565::function_127e0d08() )
            {
                tags[ i ] interactive_map::add_object( "corpse" + string( i ), #"uie_map_lubyanka_marker_corpse", 0 );
            }
        }
    }
    
    var_b33f9bc7 = { #var_4ac77177:0, #var_de6f0004:0, #prompt_text:#"hash_4bba939c7b77a314", #complete_callback:&interactive_map::function_fabe437a, #var_be77841a:0 };
    level.var_a7c109a9 = { #var_4ac77177:0, #var_de6f0004:0, #prompt_text:#"hash_77bbd9b01cf5911d", #complete_callback:&function_1b3bebea, #var_be77841a:0 };
    var_384bed55 = { #var_4ac77177:0, #var_de6f0004:0, #prompt_text:#"hash_77bbd9b01cf5911d", #complete_callback:&function_eab15e43, #var_be77841a:0 };
    level.var_ac82c4c6 = { #var_4ac77177:0, #var_de6f0004:0, #prompt_text:#"hash_77bbd9b01cf5911d", #complete_callback:&function_5a785465, #var_be77841a:0 };
    
    if ( level flag::get( "flag_start_finding_ways" ) )
    {
        function_10fea201();
        level flag::get( "flag_poi_camera_done" );
        level flag::set( "flag_tutorial_map_complete" );
        function_3a103505();
    }
    else
    {
        hotspots = getentarray( "mental_map_poi", "targetname" );
        
        foreach ( hotspot in hotspots )
        {
            switch ( hotspot.script_noteworthy )
            {
                case #"camera":
                    hotspot.var_d9b5c896 = #"hash_1f3fb2e195d67274";
                    model_name = "cameraRoomState";
                    hotspot.var_94ca2a30 = #"hash_658c76bc4bf5be3e";
                    
                    if ( level flag::get( "flag_tutorial_1" ) )
                    {
                        hotspot.var_94ca2a30 = #"hash_658c77bc4bf5bff1";
                    }
                    
                    if ( level flag::get( "flag_tutorial_2" ) )
                    {
                        hotspot.var_94ca2a30 = #"hash_658c74bc4bf5bad8";
                    }
                    
                    if ( level flag::get( "flag_tutorial_3" ) )
                    {
                        hotspot.var_94ca2a30 = #"hash_658c75bc4bf5bc8b";
                    }
                    
                    if ( level flag::get( "flag_tutorial_4" ) )
                    {
                        hotspot.var_94ca2a30 = #"hash_658c7abc4bf5c50a";
                    }
                    
                    if ( !level flag::get( "flag_tutorial_map_complete" ) )
                    {
                        hotspot interactive_map::function_b5c2702b( #"confirm", var_384bed55 );
                    }
                    
                    hotspot interactive_map::function_9bc3d847( #"cursor_on", model_name, 0, 1 );
                    interactive_map::function_59b2a130( hotspots );
                    break;
                default:
                    break;
            }
        }
    }
    
    namespace_c8e236da::addprompt( #"hash_70a51dccafa85eb" );
    
    if ( level flag::get( "flag_tutorial_map_complete" ) )
    {
        namespace_c8e236da::addprompt( #"hash_3895e110abdb2bea" );
    }
    
    player thread util::function_658a8750( 4 );
    waitframe( 1 );
    function_b2058d81( player );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xcac07622, Offset: 0x80f0
// Size: 0x84
function function_b2058d81( player )
{
    level flag::wait_till( "flag_tutorial_map_complete" );
    player endon( #"show_itin" );
    
    while ( !player scripted_widgets::function_57fbd346() || !level flag::get( "flag_tutorial_map_complete" ) )
    {
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6afb9de1, Offset: 0x8180
// Size: 0x232
function function_bd719400()
{
    location = level.interactive_map.var_2c15274b.object.script_noteworthy;
    
    if ( isdefined( location ) )
    {
        switch ( location )
        {
            case #"charkov_office":
                if ( !level flag::get( "track_poison_quest" ) )
                {
                    function_3baa92ca();
                    level flag::set( "track_poison_quest" );
                    function_e59622fc();
                }
                
                break;
            case #"checkpoint":
                if ( !level flag::get( "track_mole_quest" ) )
                {
                    function_3baa92ca();
                    level flag::set( "track_mole_quest" );
                    function_112ccc00();
                }
                
                break;
            case #"interrogation":
                if ( !level flag::get( "track_persuade_quest" ) )
                {
                    function_3baa92ca();
                    level flag::set( "track_persuade_quest" );
                    function_3b6949e3();
                }
                
                break;
            case #"data":
                if ( !level flag::get( "track_reprogram_quest" ) )
                {
                    function_3baa92ca();
                    level flag::set( "track_reprogram_quest" );
                    function_7d2cd5a4();
                }
                
                break;
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0x83c0
// Size: 0x4
function function_76f6763d()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xafc33624, Offset: 0x83d0
// Size: 0x144
function function_3baa92ca()
{
    if ( level flag::get( "track_poison_quest" ) )
    {
        level flag::clear( "track_poison_quest" );
        function_6f694325();
    }
    
    if ( level flag::get( "track_reprogram_quest" ) )
    {
        level flag::clear( "track_reprogram_quest" );
        function_b2389c8a();
    }
    
    if ( level flag::get( "track_persuade_quest" ) )
    {
        level flag::clear( "track_persuade_quest" );
        function_13467c6e();
    }
    
    if ( level flag::get( "track_mole_quest" ) )
    {
        level flag::clear( "track_mole_quest" );
        function_9e96f7bb();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5f66e3ae, Offset: 0x8520
// Size: 0x11c
function function_10fea201()
{
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        function_3baa92ca();
        return;
    }
    
    if ( level flag::get( "track_poison_quest" ) )
    {
        function_e59622fc();
    }
    
    if ( level flag::get( "track_reprogram_quest" ) )
    {
        function_7d2cd5a4();
    }
    
    if ( level flag::get( "track_persuade_quest" ) )
    {
        function_3b6949e3();
    }
    
    if ( level flag::get( "track_mole_quest" ) )
    {
        function_112ccc00();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x318d9d20, Offset: 0x8648
// Size: 0x224
function function_e59622fc()
{
    if ( !level flag::get( "flag_player_scheduled_meeting" ) && !level flag::get( "flag_has_poison" ) && !level flag::get( "flag_start_charkov_investigation" ) )
    {
        level.secretary interactive_map::add_object( #"secretary", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( !level flag::get( "flag_has_poison" ) && !level flag::get( "flag_start_charkov_investigation" ) )
    {
        level.var_44c39802 = struct::get( "ins_restricted_area_locker_lock_interact", "targetname" );
        level.var_44c39802 interactive_map::add_object( #"poison", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( level flag::get( "flag_has_poison" ) && !level flag::get( "flag_start_charkov_investigation" ) )
    {
        level.secretary interactive_map::add_object( #"secretary", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    var_fe29c695 = struct::get( "poison_chat", "targetname" );
    var_fe29c695 interactive_map::add_object( #"hash_2410c0d0b3566fc3", level.var_5fc836e5, 0, undefined );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x42ffbc50, Offset: 0x8878
// Size: 0x64
function function_6f694325()
{
    interactive_map::remove_object( #"poison" );
    interactive_map::remove_object( #"secretary" );
    interactive_map::remove_object( #"hash_2410c0d0b3566fc3" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xcac7ed3f, Offset: 0x88e8
// Size: 0x3e4
function function_7d2cd5a4()
{
    if ( !level flag::get_any( [ "flag_poi_armory_guy_dead", "flag_armory_persuade_03_called", "flag_request_armory" ] ) )
    {
        level.armory_guard interactive_map::add_object( #"armory_guard", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( ( level flag::get( "flag_armory_persuade_03_called" ) || level flag::get( "flag_request_armory" ) ) && !level flag::get_any( [ "flag_has_cigar", "flag_has_paperwork", "flag_poi_armory_guy_dead" ] ) )
    {
        if ( level flag::get( "flag_armory_persuade_03_called" ) )
        {
            var_d02e0a4b = struct::get_array( "cigar", "targetname" );
            
            for ( i = 0; i < var_d02e0a4b.size ; i++ )
            {
                var_d02e0a4b[ i ] interactive_map::add_object( hash( "cigar_spot_" + string( i ) ), level.var_5fc836e5, 0, undefined );
            }
        }
        
        if ( level flag::get( "flag_request_armory" ) )
        {
            paperwork = struct::get( #"paperwork", "targetname" );
            paperwork interactive_map::add_object( #"paperwork", level.var_5fc836e5, 0, undefined );
        }
        
        return;
    }
    
    if ( level flag::get_any( [ "flag_has_cigar", "flag_has_paperwork" ] ) && !level flag::get( "flag_poi_armory_guy_dead" ) && !level flag::get( "flag_poi_armory_open" ) )
    {
        level.armory_guard interactive_map::add_object( #"armory_guard", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( !level flag::get( "flag_got_spare_card" ) )
    {
        var_31e7cd3f = struct::get( "spare_card", "targetname" );
        var_31e7cd3f interactive_map::add_object( #"hash_201b7686113c8dc4", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    computer = struct::get( "struct_computer_hack", "targetname" );
    computer interactive_map::add_object( #"reprogram_computer", level.var_5fc836e5, 0, undefined );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xefbf0015, Offset: 0x8cd8
// Size: 0xc4
function function_b2389c8a()
{
    interactive_map::remove_object( #"hash_201b7686113c8dc4" );
    interactive_map::remove_object( #"paperwork" );
    interactive_map::remove_object( #"hash_1f5e5467a23eec9d" );
    interactive_map::remove_object( #"hash_1f5e5367a23eeaea" );
    interactive_map::remove_object( #"armory_guard" );
    interactive_map::remove_object( #"reprogram_computer" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x96adfffd, Offset: 0x8da8
// Size: 0x20c
function function_3b6949e3()
{
    if ( !level flag::get( "flag_poi_records_file" ) && !level flag::get( "flag_show_family_choice" ) )
    {
        level.prisoner interactive_map::add_object( #"prisoner", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( level flag::get( "flag_poi_records_file" ) && !level flag::get( "flag_show_family_choice" ) )
    {
        records = struct::get( "prisoner_chat", "targetname" );
        records interactive_map::add_object( #"hash_5ae419835c5428b4", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( !level flag::get( "flag_prisoner_complete" ) )
    {
        level.prisoner interactive_map::add_object( #"prisoner", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( !level flag::get( "flag_poi_interrogation_take" ) )
    {
        level.var_fd2ed10f interactive_map::add_object( #"hash_6aa2aec455594750", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    level.general interactive_map::add_object( #"hash_5e264266f6f71bf2", level.var_5fc836e5, 0, undefined );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x30113862, Offset: 0x8fc0
// Size: 0x84
function function_13467c6e()
{
    interactive_map::remove_object( #"prisoner" );
    interactive_map::remove_object( #"hash_5ae419835c5428b4" );
    interactive_map::remove_object( #"hash_5e264266f6f71bf2" );
    interactive_map::remove_object( #"hash_6aa2aec455594750" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x382c909d, Offset: 0x9050
// Size: 0x224
function function_112ccc00()
{
    if ( !level flag::get( "flag_poi_krav_chat" ) && !level flag::get( "false_intel_printed" ) )
    {
        level.var_eede7a6 interactive_map::add_object( #"krav", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( !level flag::get( "false_intel_printed" ) )
    {
        computer = struct::get( "ins_restricted_area_computer_org", "targetname" );
        computer interactive_map::add_object( #"hash_2712d6284cb32b79", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( !level flag::get( "has_false_intel" ) )
    {
        printer = struct::get( "false_intel_org", "targetname" );
        printer interactive_map::add_object( #"false_intel", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    if ( !level flag::get( "flag_checkpoint_moment_done" ) )
    {
        level.var_eede7a6 interactive_map::add_object( #"krav", level.var_5fc836e5, 0, undefined );
        return;
    }
    
    struct = struct::get( "swipe_card", "targetname" );
    struct interactive_map::add_object( #"swipe_card", level.var_5fc836e5, 0, undefined );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xbcbd886c, Offset: 0x9280
// Size: 0x84
function function_9e96f7bb()
{
    interactive_map::remove_object( #"krav" );
    interactive_map::remove_object( #"false_intel" );
    interactive_map::remove_object( #"hash_2712d6284cb32b79" );
    interactive_map::remove_object( #"swipe_card" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x8d11f982, Offset: 0x9310
// Size: 0x4c
function room_select( *prompt )
{
    level.var_f6ee4380 = self;
    level.var_f6ee4380.occupant = level.var_bd2c25cc;
    level flag::set( "flag_room_chosen" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x7676771a, Offset: 0x9368
// Size: 0x32
function function_22af6992( *prompt_struct )
{
    if ( isdefined( self.var_ec2c079e ) )
    {
        level dialogue::function_3db52a33();
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x93278130, Offset: 0x93a8
// Size: 0xc4
function function_3bd00673()
{
    player = getplayers()[ 0 ];
    player unlink();
    interactive_map::close();
    namespace_c8e236da::removelist();
    setdvar( #"ui_busyblockingamemenu", 0 );
    player thread util::function_ae1d1464( 4, 0 );
    player thread util::function_5b2f930e( 4, #"uie_ui_hud_cp_actionslot_icon_map" );
}

/#

    // Namespace kgb_ins_prepare/namespace_bd1b12dd
    // Params 5
    // Checksum 0xfb494a36, Offset: 0x9478
    // Size: 0x156, Type: dev
    function function_951eb017( xoffset, yoffset, str, color = ( 0, 0, 0 ), visible = 1 )
    {
        item = newdebughudelem();
        item.alignx = "<dev string:x4b>";
        item.horzalign = "<dev string:x53>";
        item.x = xoffset;
        item.y = yoffset;
        item.fontscale = 1;
        item.color = color;
        item.str = str;
        item.visible = visible;
        
        if ( !isdefined( level.var_74a63e8b ) )
        {
            level.var_74a63e8b = [];
        }
        else if ( !isarray( level.var_74a63e8b ) )
        {
            level.var_74a63e8b = array( level.var_74a63e8b );
        }
        
        level.var_74a63e8b[ level.var_74a63e8b.size ] = item;
        return item;
    }

#/

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x90a539a7, Offset: 0x95d8
// Size: 0x260
function function_2930697c()
{
    player = getplayers()[ 0 ];
    player notifyonplayercommand( "show_itin", "+actionslot 4" );
    level.var_5fc836e5 = #"uie_map_lubyanka_marker_waypoint";
    
    while ( !level flag::get( "flag_player_swap" ) )
    {
        player waittill( #"show_itin" );
        bb::function_cd497743( "player_opened_map", player );
        
        if ( !level flag::get( "dialog_tree_active" ) && player actions::function_c11b51e1() && !level flag::get( "disable_mental_map" ) && !player flag::get( #"lockpicking" ) && !level flag::get( #"mission_failed" ) )
        {
            player notify( #"notify_turn_off_hint_text" );
            
            if ( level flag::get( "flag_player_swap" ) )
            {
                break;
            }
            
            level flag::set( "flag_show_itinerary" );
            function_30edf3ee();
            function_399a3c34();
            level thread function_3bd00673();
            thread function_e322b3b5();
            level flag::clear( "flag_show_itinerary" );
        }
        
        wait 0.5;
        waitframe( 1 );
    }
    
    player thread util::function_658a8750( 4 );
    var_bddef49 = undefined;
    waitframe( 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x4256110e, Offset: 0x9840
// Size: 0x2ac
function function_30edf3ee()
{
    waitframe( 1 );
    player = getplayers()[ 0 ];
    player actions::function_202ab848( 0 );
    namespace_e77bf565::function_f6eb250d( "cinematicmotion_kgb_computer" );
    player disableweaponcycling();
    
    if ( player getstance() == "stand" )
    {
        player allowcrouch( 0 );
        player allowprone( 0 );
    }
    else
    {
        player allowstand( 0 );
        player allowprone( 0 );
    }
    
    player val::set( #"hash_192dddd4b6f92f9", "show_hud", 0 );
    player.og_origin = player.origin;
    player.var_f49e4bb9 = player getplayerangles();
    var_f94cd7f4 = player getplayercamerapos();
    var_199c1dc2 = player getplayerangles();
    
    if ( player getstance() == "stand" )
    {
        offset = -60;
    }
    else
    {
        offset = -40;
    }
    
    spot = player.origin;
    level.var_cfd141ff = spawn( "script_model", spot );
    level.var_cfd141ff setmodel( "tag_origin" );
    level.var_cfd141ff.angles = player getplayerangles();
    level.var_cfd141ff dontinterpolate();
    player playerlinkto( level.var_cfd141ff, "tag_origin", 1, 0, 0, 0, 0, 1, undefined, 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xefa118bf, Offset: 0x9af8
// Size: 0x27c
function function_e322b3b5()
{
    player = getplayers()[ 0 ];
    a_flags = [];
    a_flags[ a_flags.size ] = "player_in_restricted_area";
    a_flags[ a_flags.size ] = "player_in_restricted_area_charkov_office";
    a_flags[ a_flags.size ] = "player_in_restricted_area_war_room";
    a_flags[ a_flags.size ] = "player_in_restricted_area_data_entry";
    a_flags[ a_flags.size ] = "player_in_restricted_area_records";
    a_flags[ a_flags.size ] = "player_in_restricted_area_office_1";
    a_flags[ a_flags.size ] = "player_in_restricted_maintenance_area";
    player thread objectives_ui::show_objectives();
    player enableweaponcycling();
    player val::set( #"hash_192dddd4b6f92f9", "show_hud" );
    player unlink();
    
    if ( player getstance() == "stand" )
    {
        player allowcrouch( 1 );
        
        if ( level flag::get_any( a_flags ) )
        {
            player allowprone( 1 );
        }
    }
    else
    {
        player allowstand( 1 );
        
        if ( level flag::get_any( a_flags ) )
        {
            player allowprone( 1 );
        }
    }
    
    level.var_cfd141ff delete();
    player setorigin( player.og_origin );
    player setplayerangles( player.var_f49e4bb9 );
    player actions::function_202ab848( 1 );
    namespace_e77bf565::function_f6eb250d();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x29c5bc24, Offset: 0x9d80
// Size: 0x10a
function function_93751453()
{
    player = getplayers()[ 0 ];
    var_8d147d15 = 0;
    var_779947cd = 4;
    
    while ( !level flag::get( "flag_player_swap" ) && var_8d147d15 < var_779947cd )
    {
        if ( player.stealth.maxthreat > 0.5 )
        {
            if ( player flag::get( "lockpicking" ) )
            {
                player clientfield::set_to_player( "lockpick_state", 0 );
                player dialogue::function_96171f6d( "vox_cp_rkgb_01650_blkv_ifimseenthiswou_cb" );
                var_8d147d15 += 1;
                wait 1;
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xaccf6b1f, Offset: 0x9e98
// Size: 0x12e
function function_70715735()
{
    level thread function_9705705e();
    
    while ( !level flag::get( "flag_player_swap" ) && !level flag::get( "kgb_fail_mission" ) )
    {
        level flag::wait_till_any( level.var_e9c8a6d4 );
        level flag::wait_till( "stealth_spotted" );
        level.var_f695d653 = function_37c2fed8();
        wait 2.5;
        
        if ( level flag::get( "stealth_spotted" ) )
        {
            if ( !level flag::get( "flag_player_swap" ) )
            {
                level flag::set( "kgb_fail_mission" );
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xdfadafb1, Offset: 0x9fd0
// Size: 0x134
function function_9705705e()
{
    level flag::wait_till( "kgb_fail_mission" );
    
    if ( level flag::get( "flag_player_swap" ) )
    {
        return;
    }
    
    level notify( #"hash_632b48ff65789b0b" );
    waitframe( 1 );
    level scene::stop( "scene_kgb_generals_office" );
    level thread function_9fde9426();
    player = getplayers()[ 0 ];
    
    if ( player flag::get( "lockpicking" ) )
    {
        player clientfield::set_to_player( "lockpick_state", 0 );
    }
    
    namespace_353d803e::function_45192a6c();
    util::missionfailedwrapper( #"hash_14c23141aa10eb00", level.var_f695d653 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe1e925e9, Offset: 0xa110
// Size: 0x10a
function function_37c2fed8()
{
    if ( level flag::get( "kgb_fail_mission" ) )
    {
        return;
    }
    
    var_8de2baee = #"hash_328d2a2104c392fe";
    player = getplayers()[ 0 ];
    player endon( #"death" );
    
    if ( player flag::get_any( [ "body_shield_active", "takedown_active" ] ) || player namespace_5f6e61d9::function_cad84e26() )
    {
        var_8de2baee = #"hash_48ce6cc8055a83cd";
    }
    
    if ( player flag::get( "lockpicking" ) )
    {
        var_8de2baee = #"hash_65c8e89921291224";
    }
    
    return var_8de2baee;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf31a7905, Offset: 0xa228
// Size: 0x110
function function_9fde9426()
{
    player = getplayers()[ 0 ];
    enemies = getaiarray();
    
    foreach ( guy in enemies )
    {
        if ( guy === player.takedown.body )
        {
            continue;
        }
        
        guy stopanimscripted( 1 );
        guy ai::set_behavior_attribute( "_human_demeanor", "ALERT" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8f9896a1, Offset: 0xa340
// Size: 0xbe
function function_d6e9514b()
{
    self endon( #"death" );
    
    while ( !level flag::get( "flag_player_swap" ) )
    {
        if ( self flag::get( "takedown_active" ) )
        {
            iprintlnbold( "murder" );
            
            while ( self flag::get( "takedown_active" ) )
            {
                waitframe( 1 );
            }
            
            iprintlnbold( "murder finished" );
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x542bd25f, Offset: 0xa408
// Size: 0xac
function function_e873b4cd()
{
    level endon( #"hash_632b48ff65789b0b" );
    level flag::wait_till( "flag_social_stealth_failed" );
    namespace_353d803e::music( "4.3_tension_stingers" );
    
    if ( !level flag::get( "flag_player_swap" ) )
    {
        util::missionfailedwrapper( #"hash_14c23141aa10eb00", #"hash_20fefa05167b6e6a" );
        namespace_353d803e::function_45192a6c();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xa5a8fb6, Offset: 0xa4c0
// Size: 0x184
function function_33e0fa9c()
{
    objectives::scripted( #"hash_65f30a0836d63c", undefined, #"hash_1e13d67a65b66f6d" );
    objectives::scripted( #"hash_2e6a6a9287f33bee", undefined, #"hash_20da149f9d0905a", 0 );
    objectives::function_6a5ca7ac( #"hash_2e6a6a9287f33bee", undefined, #"hash_65f30a0836d63c", undefined, 0 );
    objectives::scripted( #"hash_32c4531a044c1283", undefined, #"hash_25c43a7db98961f7", 0 );
    objectives::function_6a5ca7ac( #"hash_32c4531a044c1283", undefined, #"hash_65f30a0836d63c", undefined, 0 );
    level flag::wait_till( "flag_keycard_acquired" );
    objectives::complete( #"hash_65f30a0836d63c" );
    objectives::complete( #"hash_2e6a6a9287f33bee" );
    objectives::complete( #"hash_32c4531a044c1283" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xb6e66cce, Offset: 0xa650
// Size: 0x31a
function function_68e72c81( var_bc2b55eb )
{
    spot = struct::get( "quest_spot_" + var_bc2b55eb, "targetname" );
    
    if ( !isdefined( level.var_3e985254 ) )
    {
        level.var_3e985254 = spawn( "script_model", ( 0, 0, 0 ) );
        level.var_3e985254 setmodel( "tag_origin" );
        level.var_3e985254.origin = spot.origin;
        objectives::goto( "room_select", level.var_3e985254.origin );
    }
    else
    {
        objectives::complete( "room_select" );
        waitframe( 1 );
        level.var_3e985254.origin = spot.origin;
        objectives::goto( "room_select", level.var_3e985254.origin );
    }
    
    waitframe( 1 );
    
    switch ( var_bc2b55eb )
    {
        case #"office":
            objectives::function_67f87f80( "room_select", undefined, #"hash_2a572dd82dffa737" );
            break;
        case #"prison":
            objectives::function_67f87f80( "room_select", undefined, #"hash_17ba8a94dd34cf9b" );
            break;
        case #"records":
            objectives::function_67f87f80( "room_select", undefined, #"hash_33b2c3a1bf0da6ed" );
            break;
        case #"mail":
            objectives::function_67f87f80( "room_select", undefined, #"hash_7ecdd6ef6bf1a45c" );
            break;
        case #"computer":
            objectives::function_67f87f80( "room_select", undefined, #"hash_2bb6f605c5e7b52a" );
            break;
        case #"armory":
            objectives::function_67f87f80( "room_select", undefined, #"hash_4aefcb320601a091" );
            break;
        case #"basement":
            objectives::function_67f87f80( "room_select", undefined, #"hash_7faf04c65d2a58de" );
            break;
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb4b94dde, Offset: 0xa978
// Size: 0x16c
function function_52f0fcb3()
{
    while ( !isdefined( level.stealth ) )
    {
        waitframe( 1 );
    }
    
    player = getplayers()[ 0 ];
    level.stealth.fnsetdisguised = &function_d2e50cd;
    player.player_actions.enabled[ #"hash_4ee54ef61a0301b2" ] = 0;
    player.player_actions.enabled[ #"body_shield_grenade" ] = 0;
    spawner::simple_spawn( "kgb_hq_guard", &function_862e8bf9 );
    namespace_979752dc::set_disguised( 1 );
    level.armory_guard = spawner::simple_spawn_single( "armory_guard", &function_f632133 );
    level.doorman = spawner::simple_spawn_single( "doorman", &function_862e8bf9 );
    level.doorman thread function_23df39ab();
    level thread function_9adc9ad7();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x78ae3774, Offset: 0xaaf0
// Size: 0xac
function function_9adc9ad7()
{
    level endon( #"flag_player_swap" );
    level flag::wait_till( "player_in_restricted_area" );
    spawner::simple_spawn_single( "restricted_area_guard", &function_e9e9570d );
    spawner::simple_spawn_single( "restricted_server_guard_1", &function_e9e9570d );
    spawner::simple_spawn_single( "restricted_server_guard_2", &function_e9e9570d );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x3c94176e, Offset: 0xaba8
// Size: 0x10c
function function_87ca1959()
{
    self.dontdropweapon = 1;
    self.var_6eed8aea = 0;
    self.threatsight = 0;
    self.var_c681e4c1 = 1;
    self setteam( #"axis" );
    level thread scene::play( "scene_kgb_file_room_clerk_dt_setup", "Start_Loop" );
    self thread function_424c5c7b();
    self thread function_12c4b338();
    self thread function_3cf5b786();
    self thread function_7d7d8fd0();
    self waittill( #"death" );
    level flag::set( "file_clerk_dead" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x9513758a, Offset: 0xacc0
// Size: 0xc4
function function_f632133()
{
    self.dontdropweapon = 1;
    self.var_6eed8aea = 0;
    self.threatsight = 0;
    self.var_c681e4c1 = 1;
    self.propername = function_70594daa();
    self thread function_65cd1213();
    self thread function_424c5c7b();
    self thread function_12c4b338();
    self thread function_3cf5b786();
    self thread function_7d7d8fd0();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x90c2485b, Offset: 0xad90
// Size: 0x10c
function function_862e8bf9()
{
    if ( !isactor( self ) )
    {
        return;
    }
    
    self.dontdropweapon = 1;
    self.holdfire = 1;
    self thread function_12c4b338();
    self thread function_3cf5b786();
    
    if ( !isdefined( level.player_in_restricted_area ) )
    {
        self.var_6eed8aea = 0;
        self.threatsight = 0;
    }
    
    self.propername = function_70594daa();
    self thread function_7d7d8fd0();
    self setteam( #"axis" );
    self.var_c681e4c1 = 1;
    self thread function_424c5c7b();
    self namespace_e77bf565::function_3f2f4ef1();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x7d8bb247, Offset: 0xaea8
// Size: 0x62
function function_23df39ab()
{
    self endon( #"death" );
    self.ignoreme = 1;
    self.ignoreall = 1;
    level flag::wait_till( "flag_start_finding_ways" );
    self.ignoreme = 0;
    self.ignoreall = 0;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8e938d22, Offset: 0xaf18
// Size: 0x4c
function function_198d6c82()
{
    self waittill( #"death" );
    
    if ( !level flag::get( "flag_player_swap" ) )
    {
        namespace_353d803e::music( "4.2_search_stingers" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80d6b4f1, Offset: 0xaf70
// Size: 0x9a
function function_424c5c7b()
{
    self endon( #"death" );
    self.var_c681e4c1 = 1;
    level flag::wait_till( "flag_start_finding_ways" );
    self.var_c681e4c1 = 0;
    level flag::wait_till_any( [ "flag_player_swap", "flag_prep_elevator" ] );
    self.var_c681e4c1 = 1;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8207c6eb, Offset: 0xb018
// Size: 0x74
function function_7d7d8fd0()
{
    self endon( #"death" );
    self waittill( #"takedown_begin" );
    self notify( #"dialog_wait_cancel" );
    
    if ( !level flag::get( "flag_player_swap" ) )
    {
        namespace_353d803e::music( "4.2_search_stingers" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf103ec64, Offset: 0xb098
// Size: 0x2a2
function function_70594daa()
{
    if ( level flag::get_any( [ "flag_prep_elevator", "flag_player_swap" ] ) )
    {
        return;
    }
    
    a_names = [];
    a_names[ a_names.size ] = #"hash_7e4018280225e07b";
    a_names[ a_names.size ] = #"hash_7e4017280225dec8";
    a_names[ a_names.size ] = #"hash_7e401a280225e3e1";
    a_names[ a_names.size ] = #"hash_7e4019280225e22e";
    a_names[ a_names.size ] = #"hash_7e401c280225e747";
    a_names[ a_names.size ] = #"hash_7e401b280225e594";
    a_names[ a_names.size ] = #"hash_7e401e280225eaad";
    a_names[ a_names.size ] = #"hash_7e401d280225e8fa";
    a_names[ a_names.size ] = #"hash_7e4010280225d2e3";
    a_names[ a_names.size ] = #"hash_7e400f280225d130";
    a_names[ a_names.size ] = #"hash_7e3c92280222c6f2";
    a_names[ a_names.size ] = #"hash_7e3c93280222c8a5";
    a_names[ a_names.size ] = #"hash_7e3c90280222c38c";
    a_names[ a_names.size ] = #"hash_7e3c91280222c53f";
    a_names[ a_names.size ] = #"hash_7e3c8e280222c026";
    a_names[ a_names.size ] = #"hash_7e3c8f280222c1d9";
    a_names[ a_names.size ] = #"hash_7e3c8c280222bcc0";
    a_names[ a_names.size ] = #"hash_7e3c8d280222be73";
    a_names[ a_names.size ] = #"hash_7e3c9a280222d48a";
    a_names[ a_names.size ] = #"hash_7e3c9b280222d63d";
    a_names[ a_names.size ] = #"hash_7e398c28022086e9";
    a_names[ a_names.size ] = #"hash_7e398b2802208536";
    a_names[ a_names.size ] = #"hash_7e398a2802208383";
    a_names[ a_names.size ] = #"hash_7e398928022081d0";
    return array::random( a_names );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x9e154f48, Offset: 0xb348
// Size: 0x8c
function function_3cf5b786( flag_name = "flag_cleanup_kgb_hq" )
{
    self endon( #"death" );
    self endon( #"deleted" );
    self endon( #"entitydeleted" );
    level flag::wait_till( flag_name );
    waitframe( 1 );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x188a373, Offset: 0xb3e0
// Size: 0x74
function function_12c4b338()
{
    self endon( #"death" );
    self waittill( #"corpse_found", #"corpse_seen_claim" );
    
    if ( level flag::get( "flag_player_swap" ) )
    {
        return;
    }
    
    level flag::set( "flag_social_stealth_failed" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x82555c37, Offset: 0xb460
// Size: 0x5f8
function function_d2e50cd( disguised = 0 )
{
    a_flags = [];
    a_flags[ a_flags.size ] = "player_in_restricted_area";
    a_flags[ a_flags.size ] = "player_in_restricted_area_charkov_office";
    a_flags[ a_flags.size ] = "player_in_restricted_area_war_room";
    a_flags[ a_flags.size ] = "player_in_restricted_area_data_entry";
    a_flags[ a_flags.size ] = "player_in_restricted_area_records";
    a_flags[ a_flags.size ] = "player_in_restricted_area_office_1";
    a_flags[ a_flags.size ] = "player_in_restricted_maintenance_area";
    player = getplayers()[ 0 ];
    
    if ( disguised )
    {
        level.stealth.disguised = 1;
        level.stealth.threatsightratescale = 0;
        level.stealth.threatsightdistscale = 0;
        level.stealth.proximity_combat_radius_bump = 0;
        level.stealth.proximity_combat_radius_sight = 0;
        level.stealth.proximity_combat_radius_fake_sight = 0;
        setsaveddvar( #"hash_12c53cd4a01caff3", 0.25 );
        setsaveddvar( #"hash_5edb3c8437c5990e", cos( 90 ) );
        setsaveddvar( #"hash_30eedc859ec98ad", 0.025 );
        setsaveddvar( #"hash_5aaea648688ff01e", 0.25 );
        setsaveddvar( #"hash_7bf40e4b6a830d11", 0 );
        level.stealth.var_92ee0879 = "sentientevents_stealth_social";
        loadsentienteventparameters( level.stealth.var_92ee0879 );
    }
    else
    {
        level.stealth.disguised = undefined;
        
        if ( !level flag::get( "player_doing_stealth_action" ) && level flag::get_any( a_flags ) )
        {
            level.stealth.threatsightratescale = undefined;
            level.stealth.threatsightdistscale = 1;
        }
        else if ( !level flag::get_any( a_flags ) && !player flag::get( "lockpicking" ) )
        {
            level.stealth.threatsightratescale = 1.1;
            level.stealth.threatsightdistscale = 3;
        }
        else
        {
            level.stealth.threatsightratescale = 0.85;
            level.stealth.threatsightdistscale = 1;
        }
        
        level.stealth.proximity_combat_radius_bump = 32;
        level.stealth.proximity_combat_radius_sight = 150;
        level.stealth.proximity_combat_radius_fake_sight = 60;
        
        if ( !level flag::get( "flag_start_finding_ways" ) )
        {
            level.stealth.threatsightratescale = 0.25;
            level.stealth.threatsightdistscale = 0.25;
            level.stealth.proximity_combat_radius_bump = 0;
            level.stealth.proximity_combat_radius_sight = 0;
            level.stealth.proximity_combat_radius_fake_sight = 0;
        }
        
        setsaveddvar( #"hash_12c53cd4a01caff3", 0.95 );
        setsaveddvar( #"hash_5edb3c8437c5990e", cos( 180 ) );
        setsaveddvar( #"hash_7bf40e4b6a830d11", 1 );
        setsaveddvar( #"hash_30eedc859ec98ad", 0.025 );
        setsaveddvar( #"hash_5aaea648688ff01e", 0.25 );
    }
    
    ailist = getactorarray();
    
    foreach ( ai in ailist )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( isdefined( ai.stealth ) && isdefined( ai.stealth.threat_sight_state ) )
        {
            ai stealth_threat_sight::threat_sight_set_state_parameters();
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf2d5130c, Offset: 0xba60
// Size: 0x64
function function_dc6c4b5e()
{
    array[ #"sight_dist" ] = 2500;
    array[ #"detect_dist" ] = 32;
    array[ #"found_dist" ] = 32;
    namespace_cc4354b9::set_corpse_ranges( array );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd7e66311, Offset: 0xbad0
// Size: 0x5c
function function_84d00884()
{
    level thread function_b08d8aa7();
    level thread scene::play( "ambient_kgb", "targetname" );
    level thread function_7e1ccae4();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x2baab957, Offset: 0xbb38
// Size: 0x11c
function function_b08d8aa7()
{
    level.var_7261bb53 = scene::get_scenedefs();
    level.var_6b592ca6 = [];
    
    for ( i = 0; i < level.var_7261bb53.size ; i++ )
    {
        if ( issubstr( level.var_7261bb53[ i ].name, "ambient" ) && !issubstr( level.var_7261bb53[ i ].name, "fake" ) && !issubstr( level.var_7261bb53[ i ].name, "mail" ) )
        {
            level scene::add_scene_func( level.var_7261bb53[ i ].name, &function_4ccaa9ae );
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x503298ce, Offset: 0xbc60
// Size: 0xd0
function function_4ccaa9ae( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( isai( ent ) )
        {
            if ( isdefined( ent.team ) && ent.team != "axis" )
            {
                ent thread function_252c0591();
            }
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x7720d8ff, Offset: 0xbd38
// Size: 0x168
function function_252c0591()
{
    if ( level flag::get( "flag_player_swap" ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"deleted" );
    self endon( #"entitydeleted" );
    self setteam( "axis" );
    self.script_stealthgroup = "amb_civ";
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.var_c681e4c1 = 1;
    level flag::wait_till( "player_doing_stealth_action" );
    
    while ( isalive( self ) )
    {
        if ( level flag::get( "player_doing_stealth_action" ) && self function_102a262a() )
        {
            self.ignoreme = 0;
            self.ignoreall = 0;
            self function_13a62823();
            self.ignoreme = 1;
            self.ignoreall = 1;
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe605e6f8, Offset: 0xbea8
// Size: 0x84, Type: bool
function function_102a262a()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    dist_check = 1000000;
    player = getplayers()[ 0 ];
    civ = self;
    dist = distance2dsquared( self.origin, player.origin );
    return dist < dist_check;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x342bf696, Offset: 0xbf38
// Size: 0x5c
function function_13a62823()
{
    self endon( #"death" );
    level endon( #"hash_632b48ff65789b0b" );
    level endon( #"hash_ee5ce4556fbfba0" );
    level flag::wait_till_clear( "player_doing_stealth_action" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5cc3ff08, Offset: 0xbfa0
// Size: 0x44
function function_7e1ccae4()
{
    level flag::wait_till( "flag_cleanup_kgb_hq" );
    level scene::delete_scene_spawned_ents( "ambient_kgb" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6a815c2, Offset: 0xbff0
// Size: 0x7c
function function_2388bc70()
{
    level thread function_9cdcfd88();
    level.general = spawner::simple_spawn_single( "general", &function_6c654d7e );
    level.secretary = spawner::simple_spawn_single( "kgb_secretary", &function_74ad7322 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf2da148a, Offset: 0xc078
// Size: 0x23c
function function_6c654d7e()
{
    level endon( #"kgb_fail_mission" );
    self thread function_12c4b338();
    self thread function_3cf5b786();
    self.animname = "general";
    self.dontdropweapon = 1;
    self.propername = #"hash_50d58662d307f9c7";
    self thread function_bde19b69();
    self thread function_490a8713();
    level thread scene::play( "scene_kgb_generals_office", self );
    self waittill( #"death" );
    player = getplayers()[ 0 ];
    
    if ( !level flag::get( "flag_player_swap" ) && !level flag::get( "flag_keycard_acquired" ) )
    {
        level thread namespace_353d803e::music( "5.2_kill" );
        level scene::stop( "scene_kgb_generals_office" );
        wait 1;
        snd::client_msg( #"hash_75e3c63844a5eb53" );
        weapon = getweapon( #"hash_201ae1a63467400c" );
        player giveweapon( weapon );
        player switchtoweaponimmediate( weapon, 1 );
        player gestures::function_b6cc48ed( "ges_kgb_keycard_inspect", undefined, 1, 0, undefined, 0, 1 );
        level flag::set( "flag_keycard_acquired" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd13c5c78, Offset: 0xc2c0
// Size: 0x44
function function_4ba2815c()
{
    self endon( #"death" );
    self waittill( #"takedown_begin" );
    level flag::set( "flag_keycard_acquired" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x38b1264a, Offset: 0xc310
// Size: 0x17c
function function_bde19b69()
{
    level endon( #"flag_start_charkov_investigation" );
    self endon( #"death" );
    level endon( #"flag_player_swap" );
    player = getplayers()[ 0 ];
    level flag::wait_till( "flag_start_finding_ways" );
    dist_to_check = 122500;
    dist = distance2dsquared( self.origin, player.origin );
    
    while ( isdefined( self ) )
    {
        wait 0.5;
        
        if ( !player function_80d68e4d( self, cos( 25 ), 1 ) )
        {
            dist = distance2dsquared( self.origin, player.origin );
            
            if ( dist < dist_to_check )
            {
                break;
            }
        }
    }
    
    if ( !level flag::get( "flag_start_charkov_investigation" ) )
    {
        level thread dialogue::function_96171f6d( "vox_cp_rkgb_01650_blkv_thereischarkov_10" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x9468dceb, Offset: 0xc498
// Size: 0x64
function function_a1b228d5()
{
    player = getplayers()[ 0 ];
    self notify( #"dialog_wait_cancel" );
    waitframe( 1 );
    self kill( player.origin );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xa0c5260, Offset: 0xc508
// Size: 0xbc
function function_490a8713()
{
    a_flags = [ "flag_keycard_acquired" ];
    self endon( #"death" );
    self util::create_cursor_hint( "j_spine4", ( 0, 0, 0 ), #"hash_12aeefa638922fae", 72, undefined, &function_519cff6f, undefined, 128, undefined, undefined, undefined, 1, &function_3b01cf47 );
    level flag::wait_till( "flag_keycard_acquired" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xa3222230, Offset: 0xc5d0
// Size: 0x2c, Type: bool
function function_3b01cf47( *prompt )
{
    return !level flag::get( "flag_charkov_in_scene" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x7438c8a3, Offset: 0xc608
// Size: 0x114
function function_519cff6f( *prompt_struct )
{
    player = getplayers()[ 0 ];
    
    if ( !level flag::get( "flag_keycard_acquired" ) )
    {
        snd::client_msg( #"hash_75e3c63844a5eb53" );
        weapon = getweapon( #"hash_201ae1a63467400c" );
        player giveweapon( weapon );
        player switchtoweaponimmediate( weapon, 1 );
        player gestures::function_b6cc48ed( "ges_kgb_keycard_inspect", undefined, 1, 0, undefined, 0, 1 );
        level flag::set( "flag_keycard_acquired" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x9510c3c7, Offset: 0xc728
// Size: 0x82
function function_74ad7322()
{
    self thread function_12c4b338();
    self thread function_3cf5b786();
    self thread function_7d7d8fd0();
    self.var_c681e4c1 = 1;
    self thread function_ad70221();
    self.propername = function_70594daa();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xd4eae776, Offset: 0xc7b8
// Size: 0x44
function function_767b075a( guy )
{
    guy waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self util::remove_cursor_hint();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x2154c834, Offset: 0xc808
// Size: 0x4a4
function function_ad70221()
{
    secretary = self;
    self endon( #"death" );
    self endon( #"hash_ba0b8dc5bb1537b" );
    level thread scene::play( "scene_kgb_secretary_dt", "Front_Idle" );
    level flag::wait_till( "flag_start_finding_ways" );
    waitframe( 1 );
    doors::function_f35467ac( "charkov_fake_door", "targetname" );
    level.var_753658ee = dialog_tree::new_tree( &function_7abb420b, &function_5cdd5ba8, undefined, 1, "scene_kgb_secretary_dt" );
    level.var_753658ee dialog_tree::function_b82713b8( struct::get( "secretary_chat_front" ), "Intro_Front", "Choice_Loop" );
    level.var_753658ee dialog_tree::function_b82713b8( struct::get( "secretary_chat_side" ), "Intro_Left", "Choice_Loop", "Outro_Left" );
    vo_array = "vox_cp_rkgb_01600_rms3_thegeneralwillb_0c";
    level.var_753658ee dialog_tree::add_option( #"hash_20e53b05f35a27bb", vo_array, "Response_1", "Choice_Loop", undefined, "flag_player_scheduled_meeting" );
    level.var_753658ee dialog_tree::function_f5d1891( "flag_has_poison", #"hash_20e53c05f35a296e", undefined, undefined, undefined, 1, "flag_start_charkov_investigation", "flag_keycard_aquried", &function_61fd8024 );
    level.var_753658ee dialog_tree::function_bc7c03bf();
    level.var_753658ee dialog_tree::add_option( #"hash_246357eddf2857b8", "vox_cp_rkgb_01600_rms3_justletmeknowwh_68", "Outro_Front", undefined, 1, undefined, "flag_keycard_aquried", &function_c3977dda );
    a_flags = [ "flag_keycard_acquired", "flag_cup_poisoned", "flag_poi_krav_wait", "flag_player_swap", "flag_start_charkov_investigation", "flag_prisoner_complete" ];
    self thread function_1cca61db( a_flags );
    
    while ( !level flag::get_any( a_flags ) && isalive( self ) )
    {
        self dialog_tree::function_cfa96cee( level.var_753658ee, undefined, undefined, 64 );
        wait 1;
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) || level flag::get( "flag_prisoner_complete" ) || level flag::get( "flag_poi_krav_wait" ) )
    {
        return;
    }
    
    level.general_door = doors::function_73f09315( "charkov_fake_door", "targetname" );
    level scene::stop( "scene_kgb_secretary_dt" );
    self thread dialogue::queue( "vox_cp_rkgb_01600_rms3_ofcourserightth_29" );
    level thread scene::play( "scene_kgb_poison_tea", "Office_Intro" );
    level thread scene::play( "scene_kgb_poison_door", "Office_Intro", level.general_door );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x60a9a01, Offset: 0xccb8
// Size: 0xe8
function function_61fd8024()
{
    player = getplayers()[ 0 ];
    doors::unlock( "general_door", "targetname", 1, player );
    level flag::set( "flag_poi_office_meeting" );
    charkov_office_restricted_area_trigger = getent( "charkov_office_restricted_area_trigger", "targetname" );
    
    if ( isdefined( charkov_office_restricted_area_trigger ) )
    {
        charkov_office_restricted_area_trigger delete();
    }
    
    level.var_1b4de43[ level.var_1b4de43.size ] = "office";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x1f752edf, Offset: 0xcda8
// Size: 0x2c
function function_4c61e92b( *prompt )
{
    level.var_753658ee thread dialog_tree::run( level.secretary );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x1fd1c054, Offset: 0xcde0
// Size: 0x3c
function function_7abb420b()
{
    level flag::clear( "flag_start_secretary_loop" );
    level thread function_c9965ab9( 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x679a0d02, Offset: 0xce28
// Size: 0xa4
function function_5cdd5ba8()
{
    level thread function_c9965ab9( 0 );
    
    if ( !level flag::get( "flag_has_poison" ) )
    {
        level thread dialogue::function_96171f6d( "vox_cp_rkgb_01650_blkv_ihaveachancetok_29" );
    }
    
    if ( !level flag::get( "flag_start_charkov_investigation" ) )
    {
        level scene::play( "scene_kgb_secretary_dt", "Outro_Front" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xe771c820, Offset: 0xced8
// Size: 0x94, Type: bool
function function_e7f546e6( *prompt )
{
    a_flags = [ "flag_keycard_acquired", "flag_cup_poisoned", "flag_mail_sent", "flag_player_swap", "dialog_tree_active", "flag_secretary_busy" ];
    return !level flag::get_any( a_flags );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5ee5afd7, Offset: 0xcf78
// Size: 0x78
function function_2e2ec374()
{
    level flag::set( "flag_poi_interrogation_file" );
    level flag::set( "flag_poi_records_file" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "interrogation";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf532f77f, Offset: 0xcff8
// Size: 0x78
function function_c3977dda()
{
    level flag::set( "flag_poi_office_secretary" );
    level flag::set( "flag_start_secretary_loop" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "office";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xdb994e82, Offset: 0xd078
// Size: 0x3c
function function_2d5aaa39()
{
    level.secretary thread function_680c8cbe();
    level.secretary dialogue::queue( "vox_cp_rkgb_01610_mrsc_canihelpyou_00" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xbe3baaca, Offset: 0xd0c0
// Size: 0x24
function function_8aa2b4ee()
{
    level flag::set( "obj_secretary_done" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6a8abe2, Offset: 0xd0f0
// Size: 0x84
function function_349f7a90()
{
    self endon( #"death" );
    level flag::wait_till( "flag_mail_sent" );
    level scene::stop( "scene_kgb_poison_secretary_start" );
    
    if ( isdefined( self ) )
    {
        self notify( #"dialog_wait_cancel" );
    }
    
    self delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb642ada5, Offset: 0xd180
// Size: 0x7c
function function_ada5392f()
{
    level.guard = spawner::simple_spawn_single( "prison_guard", &function_c1e43496 );
    prisoner = spawner::simple_spawn_single( "prisoner", &function_c1fe873f );
    level thread function_254d4a95();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x7ebf4fd1, Offset: 0xd208
// Size: 0x82
function function_c1e43496()
{
    self.var_c681e4c1 = 1;
    self thread function_12c4b338();
    self thread function_3cf5b786();
    self thread function_7d7d8fd0();
    self thread function_32b152c2();
    self.propername = function_70594daa();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x696d7f55, Offset: 0xd298
// Size: 0x4bc
function function_32b152c2()
{
    self endon( #"death" );
    guy = self;
    level.var_fd2ed10f = self;
    level thread scene::play( "scene_kgb_influence_prisoner_guard_dt", "Loop", [ self ] );
    var_92a1f38a = dialog_tree::new_tree( undefined, undefined, undefined, 1, "scene_kgb_influence_prisoner_guard_dt" );
    var_92a1f38a dialog_tree::set_scriptbundle( "scene_kgb_influence_prisoner_guard_dt" );
    var_92a1f38a dialog_tree::function_b82713b8( struct::get( "struct_prison_guard_chat" ), "Intro", "Loop", "Outro" );
    var_92a1f38a dialog_tree::add_option( #"hash_586a246b93b5ac22", "vox_cp_rkgb_01650_rms1_comradebelikovi_3e", "Response1", "Loop", undefined, undefined, "flag_prisoner_complete_call" );
    var_92a1f38a dialog_tree::add_option( #"hash_66d10cbf3ef326e0", "vox_cp_rkgb_01650_rms1_hesdangerousand_eb", "Response2", "Loop", undefined, undefined, "flag_prisoner_complete_call" );
    var_92a1f38a dialog_tree::add_option( #"hash_7cffbc1082a46178", "vox_cp_rkgb_01650_rms1_yescomradeiveal_4a", "Response3", "Loop", undefined, undefined, "flag_unlock_prison_door", &function_5d0e53d2 );
    var_92a1f38a dialog_tree::add_option( #"hash_699c4e4234817fee", undefined, undefined, undefined, 1, undefined, "flag_prisoner_complete_call", &function_99796d90 );
    a_flags = [ "flag_prisoner_complete", "flag_keycard_acquired" ];
    self thread function_1cca61db( a_flags );
    
    while ( !level flag::get_any( a_flags ) && isalive( self ) )
    {
        guy dialog_tree::function_cfa96cee( var_92a1f38a, undefined, undefined, undefined, 96, undefined, 10 );
        wait 1;
    }
    
    level flag::set( "flag_charkov_in_scene" );
    level flag::wait_till( "flag_prison_guard_wait" );
    wait 30;
    level flag::set( "flag_poi_interrogation_take" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "interrogation";
    level notify( #"ping_map" );
    level thread function_8703e51a( struct::get( "check_body", "targetname" ) );
    var_181069db = dialog_tree::new_tree( &function_36beec55, &function_b5c2e9b8, undefined, 1, "scene_kgb_influence_prisoner_exit_dt" );
    var_181069db dialog_tree::set_scriptbundle( "scene_kgb_influence_prisoner_exit_dt" );
    var_181069db dialog_tree::function_b82713b8( struct::get( "struct_prison_guard_death_chat" ), "Intro", "Loop" );
    var_181069db dialog_tree::add_option( #"hash_45bdc476a351ac7f", undefined, "Outro", undefined, 1, "flag_prison_guard_go_away" );
    guy dialog_tree::function_cfa96cee( var_181069db, undefined, undefined, undefined, 64 );
    level thread scene::play( "scene_kgb_influence_prisoner_exit_dt", "Civ_Convo", guy );
    level thread function_d6c85c51();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe4c83ee5, Offset: 0xd760
// Size: 0x11c
function function_d6c85c51()
{
    struct = struct::get( "check_body", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_12aeefa638922fae", 64, undefined, &function_bda52e77, undefined, 128, undefined, 0, 1 );
    level flag::wait_till( "flag_keycard_acquired" );
    tag util::remove_cursor_hint();
    tag delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x3e6ee008, Offset: 0xd888
// Size: 0x84
function function_bda52e77( *prompt )
{
    level thread function_c9965ab9( 1 );
    level thread scene::play( "scene_kgb_influence_prisoner", "Grab_Card" );
    level thread function_c9965ab9( 0 );
    level flag::set( "flag_keycard_acquired" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x68f81ce8, Offset: 0xd918
// Size: 0x3c
function function_36beec55()
{
    self scene::stop( "scene_kgb_influence_prisoner" );
    level thread disable_mental_map();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe25a9d62, Offset: 0xd960
// Size: 0x74
function function_ec5d1bb7()
{
    self thread function_dbfe9c06( "struct_prison_guard_death_chat" );
    level scene::play( "scene_kgb_influence_prisoner_exit_dt", "Intro", self );
    level thread scene::play( "scene_kgb_influence_prisoner_exit_dt", "Loop", self );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf73d1192, Offset: 0xd9e0
// Size: 0x24
function function_5d0e53d2()
{
    level flag::set( "flag_unlock_prison_door" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0xda10
// Size: 0x4
function function_ad592f2c()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd0e88b2a, Offset: 0xda20
// Size: 0x66
function function_201b919()
{
    level flag::wait_till_any( [ "flag_keycard_acquired", "flag_prisoner_complete", "flag_checkpoint_moment_done" ] );
    
    if ( isdefined( self ) )
    {
        self notify( #"dialog_wait_cancel" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0xda90
// Size: 0x4
function function_99796d90()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf276b1a1, Offset: 0xdaa0
// Size: 0x3a4
function function_254d4a95()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level endon( #"flag_player_swap" );
    
    while ( true )
    {
        vol = getent( "prisoner_volume", "targetname" );
        
        if ( player istouching( vol ) )
        {
            var_b99293cd = struct::get( "struct_interrogation_open_inside", "targetname" );
        }
        else
        {
            var_b99293cd = struct::get( "struct_interrogation_open", "targetname" );
        }
        
        tag = spawn( "script_model", var_b99293cd.origin );
        tag setmodel( "tag_origin" );
        tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_1b2da47a0dd85d2d", 96, undefined, &function_46844241, undefined, undefined, 15 );
        level waittill( #"hash_45cc1be4c32503b7" );
        tag util::remove_cursor_hint();
        tag delete();
        level scene::play( "scene_kgb_interrogation_room_door", "Open" );
        
        if ( level flag::get( "flag_prisoner_complete" ) )
        {
            break;
        }
        
        var_50bc6cb5 = struct::get( "struct_interrogation_close", "targetname" );
        tag = spawn( "script_model", var_50bc6cb5.origin );
        tag setmodel( "tag_origin" );
        tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_4142e9454fccf28f", 80, undefined, &function_bb965821 );
        level waittill( #"hash_111341e49472de91" );
        tag util::remove_cursor_hint();
        tag delete();
        
        if ( level flag::get( "flag_prisoner_complete" ) )
        {
            break;
        }
        
        level scene::play( "scene_kgb_interrogation_room_door", "Close" );
    }
    
    level flag::wait_till( "flag_prison_guard_wait" );
    level scene::play( "scene_kgb_interrogation_room_door", "General_Kill" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x14a0a4f8, Offset: 0xde50
// Size: 0x8a
function function_9e511069( a_ents )
{
    door = a_ents[ #"prop 1" ];
    door attach( "p9_rus_door_placard_plastic_01", "door_plate_a" );
    waitframe( 1 );
    door attach( "p9_rus_door_placard_text_01_" + "interrogation", "door_plate_a" );
    waitframe( 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x99aae4d4, Offset: 0xdee8
// Size: 0x20
function function_bb965821( *prompt_struct )
{
    level notify( #"hash_111341e49472de91" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x5d996841, Offset: 0xdf10
// Size: 0x20
function function_46844241( *prompt_struct )
{
    level notify( #"hash_45cc1be4c32503b7" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x876a4165, Offset: 0xdf38
// Size: 0x6e4
function function_c1fe873f()
{
    self thread function_3cf5b786();
    self endon( #"death" );
    self thread function_201b919();
    level scene::init( "scene_kgb_influence_prisoner" );
    level thread function_b9aeac28();
    level thread scene::play( "scene_kgb_influence_prisoner", "Wait_Loop", self );
    level thread function_65935263();
    self detach( self.head );
    self attach( "c_t9_ger_civ_male_head01" );
    level.prisoner = self;
    guy = self;
    level.prisoner_chat = dialog_tree::new_tree( &function_3170644c, &function_f4f9e3d6, undefined, 1, "scene_kgb_influence_prisoner", 1 );
    guy thread function_88993dba();
    level.prisoner_chat dialog_tree::add_option( #"hash_7f36570537354d29", [ "Help? You need my help?!", "Save your breath" ], "Response_1", "Dialogue_Loop", undefined, "flag_show_file_option", "flag_show_file_option" );
    level.prisoner_chat dialog_tree::add_option( #"hash_7f36540537354810", [ "Dead men don't need vengeance.", "Leave me be..." ], "Response_1", "Dialogue_Loop", undefined, "flag_show_file_option", "flag_show_file_option" );
    level.var_7fdc75b1 = level.prisoner_chat dialog_tree::function_6bbbf87( "flag_show_family_choice", #"hash_2f4e958be6986c18", "vox_cp_rkgb_01585_rms2_whatgameareyout_f8", "Response_1", "Dialogue_Loop", undefined, "flag_family_options", "flag_family_options" );
    level.prisoner_chat dialog_tree::function_6bbbf87( "flag_family_options", #"hash_2f4e968be6986dcb", "vox_cp_rkgb_01585_rms2_whatbeatwhatmus_e3", "Response_1", "Dialogue_Loop", undefined, "flag_influence_success", "flag_influence_success" );
    level.prisoner_chat dialog_tree::function_6bbbf87( "flag_family_options", #"hash_2f4e978be6986f7e", "vox_cp_rkgb_01585_rms2_yespleasewhatdo_19", "Response_4", "Dialogue_Loop", undefined, "flag_influence_success", "flag_influence_success" );
    level.prisoner_chat dialog_tree::function_6bbbf87( "flag_influence_success", #"hash_67feba656a615798", "vox_cp_rkgb_01585_rms2_killhimifyourel_fe", "Response_2", "Dialogue_Loop", 1, undefined );
    level.prisoner_chat dialog_tree::add_option( #"hash_32081723b01a955f", undefined, undefined, undefined, 1, undefined, "flag_influence_success", &function_dfc86076 );
    level thread function_dfc86076();
    level flag::wait_till( "flag_influence_success" );
    level flag::set( "flag_poi_interrogation_uncuff" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "interrogation";
    level notify( #"ping_map" );
    
    if ( level flag::get( "flag_keycard_acquired" ) || level flag::get( "flag_mail_sent" ) )
    {
        return;
    }
    
    level thread function_3f0c6c34();
    level flag::wait_till( "flag_prisoner_complete_call" );
    level scene::stop( "scene_kgb_influence_prisoner" );
    level scene::play( "scene_kgb_influence_prisoner", "General_Kill_Enter", [ level.prisoner, level.guard, level.general ] );
    level thread scene::play( "scene_kgb_influence_prisoner", "General_Kill_Wait", [ level.prisoner, level.guard, level.general ] );
    vol = getent( "prisoner_volume", "targetname" );
    player = getplayers()[ 0 ];
    
    while ( player istouching( vol ) )
    {
        waitframe( 1 );
    }
    
    level.prisoner stealth_enemy::disable_player_headtracking();
    level flag::set( "flag_prison_guard_wait" );
    level thread scene::play( "scene_kgb_influence_prisoner", "General_Kill", [ level.prisoner, level.guard, level.general ] );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x402bc5af, Offset: 0xe628
// Size: 0x7c
function function_65935263()
{
    level flag::wait_till_any( [ "flag_show_family_choice", "flag_show_file_option" ] );
    level.prisoner_chat dialog_tree::function_bc7c03bf( level.var_7fdc75b1 );
    level flag::set( "flag_show_file_option" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x4d529422, Offset: 0xe6b0
// Size: 0xfc
function function_dfc86076()
{
    if ( level flag::get( "flag_influence_success" ) )
    {
        return;
    }
    
    struct = struct::get( "prisoner_start", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_2700aa498f22c978", 32, undefined, &function_c0a84859, undefined, undefined, undefined, undefined, undefined, undefined, &function_4831c198 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x5149f12f, Offset: 0xe7b8
// Size: 0x54, Type: bool
function function_4831c198( *prompt )
{
    return !level flag::get_any( [ "flag_keycard_acquired", "flag_start_charkov_investigation", "flag_poi_krav_wait" ] );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x26e170c8, Offset: 0xe818
// Size: 0x8c
function function_c0a84859( *prompt_struct )
{
    level thread function_c9965ab9( 1 );
    namespace_e77bf565::function_f6eb250d( "cinematicmotion_kgb_computer" );
    level.prisoner_chat thread dialog_tree::run( level.prisoner );
    self util::remove_cursor_hint();
    self delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xa5648e20, Offset: 0xe8b0
// Size: 0x7c
function function_3170644c()
{
    level thread function_680c8cbe();
    level notify( #"hash_111341e49472de91" );
    level scene::play( "scene_kgb_influence_prisoner", "Dialogue_Intro_L" );
    level thread scene::play( "scene_kgb_influence_prisoner", "Dialogue_Loop" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xebfbad1e, Offset: 0xe938
// Size: 0x19c
function function_f4f9e3d6()
{
    level thread function_589d3c34();
    level scene::play( "scene_kgb_influence_prisoner", "Dialogue_Outro" );
    namespace_e77bf565::function_f6eb250d();
    level thread scene::play( "scene_kgb_influence_prisoner", "Wait_Loop", [ level.prisoner ] );
    
    if ( level flag::get( "flag_influence_success" ) )
    {
        level flag::set( "flag_prompt_cuffs" );
    }
    else
    {
        if ( !level flag::get( "flag_show_family_choice" ) )
        {
            level thread dialogue::function_96171f6d( "vox_cp_rkgb_01650_blkv_ivanovwontcoope_ff" );
        }
        
        level flag::set( "flag_poi_interrogation_file" );
        level flag::set( "flag_poi_records_file" );
        level.var_1b4de43[ level.var_1b4de43.size ] = "interrogation";
        level notify( #"ping_map" );
    }
    
    level thread function_c9965ab9( 0 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x27ce6370, Offset: 0xeae0
// Size: 0x6e
function function_88993dba( a_flags = [ "flag_keycard_acquired" ] )
{
    self endon( #"death" );
    level flag::wait_till_any( a_flags );
    self notify( #"dialog_wait_cancel" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8bacd33d, Offset: 0xeb58
// Size: 0x188
function function_3f0c6c34()
{
    struct = struct::get( "cuffs", "targetname" );
    level flag::wait_till( "flag_prompt_cuffs" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_8210540516b78ab", 64, undefined, &function_9c0573b2 );
    level flag::wait_till( "flag_prisoner_complete" );
    level notify( #"hash_111341e49472de91" );
    tag util::remove_cursor_hint();
    tag delete();
    level flag::set( "flag_poi_interrogation_wait" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "interrogation";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x816a4d59, Offset: 0xece8
// Size: 0x54
function function_9c0573b2( *prompt_struct )
{
    level flag::set( "flag_prisoner_complete" );
    namespace_353d803e::function_7058432e();
    namespace_353d803e::music( "5.0_unlock" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x20a65986, Offset: 0xed48
// Size: 0x124
function function_b9aeac28()
{
    struct = struct::get( "prisoner_chat", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_6dad8ef761859b90", 40, undefined, &function_a1dee806 );
    level flag::wait_till_any( [ "flag_show_family_choice", "flag_keycard_acquired" ] );
    tag util::remove_cursor_hint();
    tag delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xaac99b9e, Offset: 0xee78
// Size: 0x24
function function_a1dee806( *prompt_struct )
{
    level thread function_ac832cf3();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x37b468d7, Offset: 0xeea8
// Size: 0x24c
function function_ac832cf3()
{
    player = getplayers()[ 0 ];
    player freezecontrols( 1 );
    level thread dialogue::function_96171f6d( "vox_cp_rkgb_01595_blkv_hisfamilyhasbee_4c" );
    hint_tutorial::function_4c2d4fc4( #"hash_5ba71d2989d3c856", #"hash_5a506faab86e53b", undefined, #"hash_7d0ad4e924d219af" );
    player notifyonplayercommandremove( "show_itin", "+actionslot 4" );
    player notifyonplayercommand( "exit", "+stance" );
    namespace_353d803e::function_28897188();
    player waittill( #"exit" );
    hint_tutorial::function_9f427d88( 0 );
    player notifyonplayercommandremove( "exit", "+stance" );
    player notifyonplayercommand( "show_itin", "+actionslot 4" );
    player freezecontrols( 0 );
    level flag::set( "flag_poi_records_leverage" );
    level flag::set( "flag_poi_interrogation_leverage" );
    level flag::set( "flag_show_family_choice" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "interrogation";
    level notify( #"ping_map" );
    namespace_353d803e::music( "4.3_tension_stingers" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb153d0f1, Offset: 0xf100
// Size: 0x54
function function_4562ce85()
{
    level.var_914fe418 += 1;
    
    if ( level.var_914fe418 >= 2 )
    {
        level flag::set( "flag_influence_success" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf4376f83, Offset: 0xf160
// Size: 0x84
function function_b30b4469()
{
    level flag::set( "flag_got_shiv" );
    level flag::set( "flag_chat_crime" );
    level flag::set( "flag_chat_general" );
    level flag::set( "flag_chat_family" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x9341c0bf, Offset: 0xf1f0
// Size: 0x98
function function_e1fa92da()
{
    level flag::set( "flag_poi_interrogation_file" );
    level flag::set( "flag_hint_locked_file" );
    level flag::set( "flag_poi_records_file" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "interrogation";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0xf290
// Size: 0x4
function file_room()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xa617b6ac, Offset: 0xf2a0
// Size: 0x570
function function_65cd1213()
{
    self endon( #"death" );
    self endon( #"takedown_begin" );
    level thread scene::play( "scene_kgb_armory_clerk_dt_setup", "Start_Loop" );
    level thread doors::function_f35467ac( "armory_door", "targetname" );
    level flag::wait_till( "flag_start_finding_ways" );
    level thread function_ded6605c();
    guy = self;
    guy thread function_72ad2b01();
    level.var_ae4c3d02 = dialog_tree::new_tree( &function_a99ab850, &function_3e8d1010, undefined, 1, "scene_kgb_armory_clerk_dt_setup" );
    level.var_ae4c3d02 dialog_tree::function_b82713b8( struct::get( "dialog_armory_front", "targetname" ), "Intro_Front", "Choice_Loop", "Outro_Front" );
    level.var_ae4c3d02 dialog_tree::function_b82713b8( struct::get( "dialog_armory_side", "targetname" ), "Intro_Left", "Choice_Loop", "Outro_Left" );
    level.var_ae4c3d02 dialog_tree::add_option( #"hash_1e2a48d585349dad", "vox_cp_rkgb_01665_rms3_imsorrycomradeb_69", "Response_2", "Choice_Loop", undefined, "flag_request_armory", undefined );
    level.var_ae4c3d02 dialog_tree::function_f5d1891( "flag_has_paperwork", #"hash_7209f1522432872", "vox_cp_rkgb_01665_rms3_myapologiesfort_c8", "Response_3", "Choice_Loop", 1, "flag_armory_done", "flag_armory_done", &function_e663b61e );
    level.var_ae4c3d02 dialog_tree::function_bc7c03bf();
    level.var_ae4c3d02 dialog_tree::function_6bbbf87( "flag_poi_armory_open", #"hash_7107c9b9a4459a64", undefined, "Response_3", undefined, 1, undefined, undefined, &function_e663b61e );
    level.var_ae4c3d02 dialog_tree::function_6bbbf87( "flag_request_armory", #"hash_18d0fbcb98d11b8e", "vox_cp_rkgb_01665_rms3_imsorryicantkra_47", "Response_2", "Choice_Loop", undefined, "flag_armory_persuade_01_called" );
    level.var_ae4c3d02 dialog_tree::function_6bbbf87( "flag_armory_persuade_01_called", #"hash_18d0facb98d119db", "vox_cp_rkgb_01665_rms3_howimportantisp_12", "Response_2", "Choice_Loop", undefined, "flag_armory_persuade_02_called" );
    level.var_ae4c3d02 dialog_tree::function_6bbbf87( "flag_armory_persuade_02_called", #"hash_18d0f9cb98d11828", "vox_cp_rkgb_01665_rms3_ahifonlyihadacu_13", "Response_2", "Choice_Loop", undefined, "flag_armory_persuade_03_called", undefined );
    level.var_ae4c3d02 dialog_tree::function_f5d1891( "flag_has_cigar", #"hash_18d100cb98d1240d", "vox_cp_rkgb_01665_rms3_wonderfulilllet_03", "Response_3", "Choice_Loop", 1, "flag_armory_persuade_04_called", "flag_unlock_armory", &function_e663b61e );
    level.var_ae4c3d02 dialog_tree::function_bc7c03bf();
    level.var_ae4c3d02 dialog_tree::add_option( #"hash_17539e81fe5effa1", undefined, undefined, undefined, 1, undefined, "flag_unlock_armory" );
    a_flags = [ "flag_keycard_acquired", "player_in_restricted_area_data_entry" ];
    guy thread function_1cca61db( a_flags, "player_in_restricted_area_data_entry" );
    
    while ( isalive( guy ) && !level flag::get_any( [ "flag_keycard_acquired" ] ) )
    {
        guy dialog_tree::function_cfa96cee( level.var_ae4c3d02, undefined, undefined, undefined, 80 );
        level flag::wait_till_clear( "player_in_restricted_area_data_entry" );
        wait 1;
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf5279581, Offset: 0xf818
// Size: 0x5c
function enable_armory_quest_dialog_cigar()
{
    level flag::wait_till_all( [ "flag_armory_persuade_03_called", "flag_has_cigar" ] );
    level flag::set( "enable_armory_quest_dialog_cigar" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6f5677dc, Offset: 0xf880
// Size: 0x24
function function_84d33cbb()
{
    level.var_ae4c3d02 dialog_tree::function_bc7c03bf( level.var_fd90324f );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd38c54cd, Offset: 0xf8b0
// Size: 0x24
function function_c7708dcf()
{
    level.var_ae4c3d02 dialog_tree::function_bc7c03bf( level.var_b14551da );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x8cf3a558, Offset: 0xf8e0
// Size: 0xb8
function function_b0e70405( a_ents )
{
    chair = a_ents[ #"chair" ];
    guard = a_ents[ #"armory_guard" ];
    level.var_51b002e1 = [ guard, chair ];
    paper = a_ents[ #"clipboard" ];
    pen = a_ents[ #"pen" ];
    level.var_2336c4f4 = a_ents;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x92b32c98, Offset: 0xf9a0
// Size: 0x64
function function_a99ab850()
{
    vo_lines = [ "vox_cp_rkgb_01665_rms3_howcanihelpyous_08", "vox_cp_rkgb_01665_rms3_sirwhatcanidofo_e1" ];
    level thread function_c9965ab9( 1 );
    self function_1948ba64( vo_lines );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x369a6efa, Offset: 0xfa10
// Size: 0xb4
function function_1948ba64( var_305d3956 )
{
    vo_line = array::random( var_305d3956 );
    
    if ( soundexists( vo_line ) )
    {
        self.var_e611d41e = snd::play( vo_line, [ self, "j_head" ] );
        snd::function_2fdc4fb( self.var_e611d41e );
        return;
    }
    
    iprintlnbold( vo_line );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd707faef, Offset: 0xfad0
// Size: 0x140
function function_3e8d1010()
{
    vo_lines = [ "vox_cp_rkgb_01665_rms3_gooddaysir_af", "vox_cp_rkgb_01665_rms3_sir_5c" ];
    self function_1948ba64( vo_lines );
    level thread function_c9965ab9( 0 );
    
    if ( !level flag::get( "flag_poi_armory_guard" ) )
    {
        level flag::set( "flag_poi_armory_guard" );
        
        if ( !level flag::get_any( [ "flag_poi_armory_open", "flag_has_paperwork", "flag_has_cigar" ] ) )
        {
            level thread dialogue::function_96171f6d( "vox_cp_rkgb_01650_blkv_theguardwontlet_df" );
        }
        
        level.var_1b4de43[ level.var_1b4de43.size ] = "data";
        level notify( #"ping_map" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xffdf202a, Offset: 0xfc18
// Size: 0x25c
function function_e663b61e()
{
    if ( !level flag::get( "flag_poi_armory_open" ) )
    {
        level flag::set( "flag_unlock_armory" );
        level flag::set( "flag_poi_armory_open" );
        doors::unlock( "armory_door", "targetname" );
        level.var_1b4de43[ level.var_1b4de43.size ] = "data";
        level notify( #"ping_map" );
        level.var_ae4c3d02 = dialog_tree::new_tree( undefined, undefined, undefined, 1, "scene_kgb_armory_clerk_dt_setup" );
        level.var_ae4c3d02 dialog_tree::function_b82713b8( struct::get( "dialog_armory_front", "targetname" ), "Intro_Front", "Choice_Loop", "Outro_Front" );
        level.var_ae4c3d02 dialog_tree::function_b82713b8( struct::get( "dialog_armory_side", "targetname" ), "Intro_Left", "Choice_Loop", "Outro_Front" );
        level.var_ae4c3d02 dialog_tree::add_option( #"hash_1e2a48d585349dad", [ "vox_cp_rkgb_01665_rms3_goaheadsirbutpl_c8" ], undefined, undefined, 1, undefined, "forever", &function_e663b61e );
        level.var_ae4c3d02 dialog_tree::add_option( #"hash_699c4e4234817fee", undefined, undefined, undefined, 1, undefined, "forever" );
    }
    
    level flag::set( "armory_door_opened" );
    snd::client_msg( #"hash_810337327e9b45d" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x4d198aee, Offset: 0xfe80
// Size: 0xe0
function function_ded6605c()
{
    level endon( #"flag_poi_armory_guy_dead" );
    
    while ( true )
    {
        level flag::wait_till( "armory_door_opened" );
        doors::open( "armory_door", "targetname" );
        level flag::wait_till( "close_armory_door" );
        doors::close( "armory_door", "targetname" );
        level flag::wait_till_clear( "close_armory_door" );
        level flag::clear( "armory_door_opened" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xaaa69f9b, Offset: 0xff68
// Size: 0x150
function function_72ad2b01()
{
    chair = getent( "armory_chair", "targetname" );
    self.var_a08ba405 = chair;
    self waittill( #"death", #"takedown_begin" );
    level scene::stop( "scene_kgb_armory_clerk_dt_setup" );
    waitframe( 1 );
    
    if ( isdefined( chair ) )
    {
        struct = struct::get( chair.target, "targetname" );
        chair moveto( struct.origin, 1 );
        chair rotateto( struct.angles, 1 );
    }
    
    level flag::set( "flag_poi_armory_guy_dead" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "data";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8f2271b6, Offset: 0x100c0
// Size: 0x36
function function_682ba64c()
{
    guard = spawner::simple_spawn_single( "checkpoint", &function_e1286843 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6cb51edf, Offset: 0x10100
// Size: 0x5a2
function function_e1286843()
{
    self thread function_12c4b338();
    self thread function_3cf5b786( "flag_player_swap" );
    self thread function_7d7d8fd0();
    self endon( #"death" );
    self thread function_201b919();
    self.propername = #"hash_48b2df68a781d0af";
    goon = spawner::simple_spawn_single( "krav_goon", &function_862e8bf9 );
    goon thread function_3cf5b786( "flag_player_swap" );
    level thread scene::play( "scene_kgb_frisk_general_guard_dt", "Loop" );
    level.var_eede7a6 = self;
    guy = self;
    level flag::wait_till( "flag_start_finding_ways" );
    var_e71b15ee = dialog_tree::new_tree( &function_a7cdd04, &function_d47c5461, undefined, 1, "scene_kgb_frisk_general_guard_dt" );
    var_e71b15ee dialog_tree::function_b82713b8( struct::get( "struct_frisk_start" ), "Intro", "Choice_Loop", "Outro" );
    var_71bb3984 = "vox_cp_rkgb_01680_krav_thenyoustillhav_8d";
    var_e71b15ee dialog_tree::add_option( #"hash_42d0527ab5d08788", var_71bb3984, "Response2", "Choice_Loop", undefined, "show_pre_exits" );
    var_f662796b = "vox_cp_rkgb_01680_krav_charkovthatsabs_15";
    var_e71b15ee dialog_tree::function_6bbbf87( "show_pre_exits", #"hash_6e4b44351840bbd7", var_f662796b, undefined, undefined, 1, "pre_dialog_done" );
    var_e71b15ee dialog_tree::function_6bbbf87( "show_pre_exits", #"hash_6e4b45351840bd8a", var_f662796b, undefined, undefined, 1, "pre_dialog_done" );
    var_92a1f38a = dialog_tree::new_tree( &function_a7cdd04, &function_4e78b39d, undefined, 1, "scene_kgb_frisk_general_guard_dt" );
    var_92a1f38a dialog_tree::function_b82713b8( struct::get( "struct_frisk_start" ), "Intro", "Choice_Loop", undefined );
    var_92a1f38a dialog_tree::add_option( #"hash_708c686d3b0db7b5", "vox_cp_rkgb_01680_krav_charkovthatsabs_15", "Response1", "Choice_Loop", undefined, undefined );
    var_92a1f38a dialog_tree::function_f5d1891( "has_false_intel", #"hash_708c656d3b0db29c", undefined, undefined, undefined, 1, "flag_checkpoint_moment_done", undefined );
    var_92a1f38a dialog_tree::function_bc7c03bf();
    var_92a1f38a dialog_tree::add_option( #"hash_6575b40f10d118ae", "vox_cp_rkgb_01680_krav_thenyoustillhav_8d", "Outro", undefined, 1, undefined, "flag_checkpoint_moment_done" );
    a_flags = [ "flag_keycard_acquired", "flag_checkpoint_moment_done", "flag_mail_sent", "flag_prisoner_complete", "flag_start_charkov_investigation" ];
    guy thread function_1cca61db( a_flags );
    
    while ( isalive( guy ) && !level flag::get_any( a_flags ) )
    {
        if ( !level flag::get_any( [ "has_false_intel", "pre_dialog_done" ] ) )
        {
            guy dialog_tree::function_cfa96cee( var_e71b15ee, undefined, undefined, undefined, 64 );
        }
        else
        {
            guy dialog_tree::function_cfa96cee( var_92a1f38a, undefined, undefined, undefined, 64 );
        }
        
        wait 1;
    }
    
    if ( level flag::get( "flag_keycard_acquired" ) || level flag::get( "flag_prisoner_complete" ) || level flag::get( "flag_start_charkov_investigation" ) )
    {
        return;
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe9d3916b, Offset: 0x106b0
// Size: 0x4e
function function_c682bb41()
{
    level endon( #"flag_keycard_acquired" );
    level flag::wait_till( "has_false_intel" );
    self.player_pos[ 0 ].var_60a7aecc = "Outro_Sucess";
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x7216af6d, Offset: 0x10708
// Size: 0x1c
function function_a7cdd04()
{
    level thread function_c9965ab9( 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5cec03d8, Offset: 0x10730
// Size: 0x160
function function_4e78b39d()
{
    level flag::set( "flag_poi_krav_chat" );
    
    if ( level flag::get( "flag_checkpoint_moment_done" ) )
    {
        level thread function_f0b5ab76( 12 );
        blocker = getent( "frisk_blocker", "targetname" );
        blocker solid();
        level scene::play( "scene_kgb_frisk_general_guard_dt", "Outro_Success" );
        level thread scene::play( "scene_kgb_frisk_general_guard_dt", "Outro_Success_Loop" );
        level thread function_d41f091c();
        return;
    }
    
    level thread function_c9965ab9( 0 );
    level.var_1b4de43[ level.var_1b4de43.size ] = "checkpoint";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x81143db, Offset: 0x10898
// Size: 0x60
function function_f0b5ab76( time )
{
    wait time;
    level thread function_c9965ab9( 0 );
    level.var_1b4de43[ level.var_1b4de43.size ] = "checkpoint";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xffda7814, Offset: 0x10900
// Size: 0x8c
function function_d47c5461()
{
    level flag::set( "flag_poi_krav_chat" );
    level thread function_c9965ab9( 0 );
    level.var_1b4de43[ level.var_1b4de43.size ] = "checkpoint";
    level notify( #"ping_map" );
    level thread function_752fba39( "vox_cp_rkgb_01650_blkv_illbeexposedsoo_81" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0x8a124e30, Offset: 0x10998
// Size: 0x44
function function_752fba39( line, time = 1 )
{
    wait time;
    level thread dialogue::function_96171f6d( line );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5f4fd847, Offset: 0x109e8
// Size: 0x24
function function_f9f3811c()
{
    level.var_eede7a6 dialogue::queue( "vox_cp_rkgb_01680_rms1_howcanihelpyouc_61" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x407faa9c, Offset: 0x10a18
// Size: 0x208
function function_d41f091c()
{
    blocker = getent( "frisk_blocker", "targetname" );
    blocker solid();
    struct = struct::get( "obj_checkpoint", "targetname" );
    level flag::set( "flag_poi_krav_wait" );
    level flag::wait_till( "flag_checkpoint_moment_done" );
    level flag::set( "flag_charkov_in_scene" );
    doors::close( "admin_door", "targetname" );
    doors::function_f35467ac( "admin_door", "targetname" );
    wait 1;
    level thread function_c9965ab9( 0 );
    level thread swipe_card();
    level scene::stop( "scene_kgb_frisk_general_guard_dt" );
    level scene::play( "scene_kgb_frisk_general", "Frisk" );
    level thread scene::play( "scene_kgb_frisk_general", "Loop" );
    level flag::set( "flag_poi_office_charkov_front" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "checkpoint";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xbcf850ad, Offset: 0x10c28
// Size: 0x1a4
function swipe_card()
{
    wait 31;
    level thread function_2410cb8e();
    struct = struct::get( "swipe_card", "targetname" );
    level thread function_8703e51a( struct );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    level flag::set( "flag_poi_krav_opportunity" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "checkpoint";
    level notify( #"ping_map" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_12aeefa638922fae", 64, 1, &function_f17f515c, undefined, undefined, undefined, 0, 1, 0 );
    level flag::wait_till( "flag_keycard_acquired" );
    tag util::remove_cursor_hint();
    tag delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc98a4b2f, Offset: 0x10dd8
// Size: 0x24
function function_2410cb8e()
{
    wait 19;
    level flag::set( "flag_allow_swipe" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xb88c48b7, Offset: 0x10e08
// Size: 0x11c
function function_f17f515c( *prompt_struct )
{
    if ( !level flag::get( "flag_allow_swipe" ) )
    {
        dialogue::function_96171f6d( "vox_cp_rkgb_01650_blkv_ifimseenthiswou_cb" );
        return;
    }
    
    level thread function_c9965ab9( 1 );
    level flag::set( "flag_keycard_acquired" );
    namespace_353d803e::function_aa5dd876();
    
    if ( level flag::get( "flag_back_checkpoint" ) )
    {
        level scene::play( "scene_kgb_frisk_general", "Back_Grab" );
    }
    else
    {
        level scene::play( "scene_kgb_frisk_general", "Front_Grab" );
    }
    
    level thread function_c9965ab9( 0 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6ed1060c, Offset: 0x10f30
// Size: 0x24
function disable_mental_map()
{
    level flag::set( "flag_in_dialogue" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x977810e9, Offset: 0x10f60
// Size: 0x24
function function_b5c2e9b8()
{
    level flag::clear( "flag_in_dialogue" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb1fd24d3, Offset: 0x10f90
// Size: 0xf8
function function_9cdcfd88()
{
    level thread function_bc6f8a15();
    level thread function_8a66687c();
    level thread function_3fb458b8();
    var_e7ebda92 = getentarray( "charkov_blinds_closed", "targetname" );
    
    foreach ( blind in var_e7ebda92 )
    {
        blind hide();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe230067, Offset: 0x11090
// Size: 0xb0
function function_bc6f8a15()
{
    var_6c4f3cf2 = struct::get_array( "cigar", "targetname" );
    
    foreach ( cigar in var_6c4f3cf2 )
    {
        cigar thread function_1a2c72f7();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x4cbc15db, Offset: 0x11148
// Size: 0x144
function function_1a2c72f7()
{
    var_4ac1f1f = util::spawn_anim_model( "p8_nt4_soviet_cigar_single", self.origin, self.angles );
    tag = spawn( "script_model", self.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 2 ), #"hash_263df1cb6b8d9de6", undefined, undefined, &function_a723656a );
    level flag::wait_till_any( [ "flag_has_cigar", "flag_keycard_acquired" ] );
    waitframe( 1 );
    tag util::remove_cursor_hint();
    tag delete();
    var_4ac1f1f delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xb35e05ad, Offset: 0x11298
// Size: 0xc4
function function_a723656a( *prompt_struct )
{
    level flag::set( "flag_has_cigar" );
    level flag::set( "flag_poi_office_cigar" );
    level flag::set( "flag_poi_mail_cigar" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "data";
    level notify( #"ping_map" );
    snd::client_msg( #"hash_6c7e5d8f2665fc0c" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xa20c4395, Offset: 0x11368
// Size: 0xb0
function function_8a66687c()
{
    bottles = getentarray( "poison", "targetname" );
    
    foreach ( poison in bottles )
    {
        poison thread function_9ec94e68();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xfa195df0, Offset: 0x11420
// Size: 0x11c
function function_9ec94e68()
{
    tag = spawn( "script_model", self.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 1 ), #"hash_71e50eca8e5ca22c", 64, undefined, &function_1e1cacf7, undefined, 128, undefined, undefined, 1 );
    level flag::wait_till_any( [ "flag_has_poison", "flag_keycard_acquired" ] );
    tag util::remove_cursor_hint();
    self delete();
    tag delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x1bce429d, Offset: 0x11548
// Size: 0x9c
function function_1e1cacf7( *prompt_struct )
{
    level flag::set( "flag_poi_mail_poison" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "office";
    level notify( #"ping_map" );
    namespace_353d803e::music( "4.3_tension_stingers" );
    level flag::set( "flag_has_poison" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb69180c2, Offset: 0x115f0
// Size: 0x5ec
function function_3fb458b8()
{
    level flag::wait_till( "flag_start_charkov_investigation" );
    level.general.var_c681e4c1 = 1;
    level flag::set( "flag_charkov_in_scene" );
    level scene::stop( "scene_kgb_generals_office" );
    chair = getent( "charkov_chair", "targetname" );
    chair delete();
    waitframe( 1 );
    level thread scene::play( "scene_kgb_poison_tea", "Intro_Loop" );
    struct = struct::get( "poison_chat", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_2700aa498f22c978", 40, undefined );
    tag waittill( #"trigger" );
    namespace_e77bf565::function_f6eb250d( "cinematicmotion_kgb_computer" );
    var_e7ebda92 = getentarray( "charkov_blinds_closed", "targetname" );
    
    foreach ( blind in var_e7ebda92 )
    {
        blind show();
    }
    
    var_fa02a280 = getentarray( "charkov_blinds_open", "targetname" );
    
    foreach ( blind in var_fa02a280 )
    {
        blind delete();
    }
    
    savegame::function_7790f03();
    level flag::set( "player_sat_in_charkovs_office" );
    level thread function_c9965ab9( 1 );
    level thread scene::play( "scene_kgb_poison_tea_player", "Player_Sit" );
    level scene::play( "scene_kgb_poison_tea", "DT_Intro" );
    level thread scene::play( "scene_kgb_poison_door", "DT_Intro", level.general_door );
    level thread scene::play( "scene_kgb_poison_tea", "DT_Intro_Loop" );
    level thread scene::play( "scene_kgb_poison_tea_player", "Player_Sit_Loop_1" );
    level thread scene::play( "scene_kgb_secretary_dt", "Front_Idle" );
    wait 1;
    level thread function_3e0c476c( "poison_right", 1 );
    level thread function_3e0c476c( "poison_left", 0 );
    level flag::wait_till( "flag_start_tea_roulette" );
    level scene::play( "scene_kgb_poison_tea", "DT_Greeting" );
    level thread scene::play( "scene_kgb_poison_tea", "DT_Choice_1_Loop" );
    function_7593f065();
    function_84770868();
    
    if ( !level flag::get( "flag_player_drink" ) )
    {
        function_4e3dfbd0();
    }
    
    if ( !level flag::get( "flag_player_drink" ) )
    {
        function_4e3dfbd0();
    }
    
    tag util::remove_cursor_hint();
    
    if ( !level flag::get( "flag_player_drink" ) )
    {
        function_6336c33f();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0xc2423d65, Offset: 0x11be8
// Size: 0x154
function function_3e0c476c( targetname, *b_right )
{
    struct = struct::get( b_right, "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag.script_noteworthy = b_right;
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_69b474496c3a9512", 128, undefined, &function_d09d1a07, undefined, undefined, 10, 0, 1 );
    level flag::wait_till( "flag_picked_poison" );
    tag util::remove_cursor_hint();
    thread namespace_353d803e::function_ecda5886();
    level flag::set( "flag_start_tea_roulette" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80bb93ac, Offset: 0x11d48
// Size: 0x17c
function function_7593f065()
{
    level flag::set( "flag_charkov_looking" );
    
    if ( level.var_c778a7d3 == "poison_right" )
    {
        level thread scene::play( "scene_kgb_poison_tea_player", "Pick_Right" );
        level scene::play( "scene_kgb_poison_tea", "Pick_Right" );
        level.var_76a74dd5 = 1;
        function_8839afce( "right" );
    }
    else
    {
        level thread scene::play( "scene_kgb_poison_tea_player", "Pick_Left" );
        level scene::play( "scene_kgb_poison_tea", "Pick_Left" );
        level.var_76a74dd5 = 0;
        function_8839afce( "left" );
    }
    
    level thread scene::play( "scene_kgb_poison_tea", "DT_Choice_2_Loop" );
    level thread scene::play( "scene_kgb_poison_tea_player", "Player_Sit_Loop_2" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x32626446, Offset: 0x11ed0
// Size: 0x6cc
function function_84770868()
{
    level flag::set( "flag_charkov_looking" );
    player = getplayers()[ 0 ];
    level.var_22af6992 = dialog_tree::new_tree( &function_70276075, undefined, 1, 1 );
    level.var_22af6992 dialog_tree::add_option( #"hash_502bd763ab64c62c", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "Map_Response_1" );
    level.var_22af6992 dialog_tree::add_option( #"hash_502bda63ab64cb45", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "Map_Response_2" );
    level.var_22af6992 dialog_tree::add_option( #"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, "flag_chose_distract" );
    level.var_22af6992 dialog_tree::add_option( #"hash_63e93fbb039d6cd1", undefined, undefined, undefined, 1, "flag_player_drink", "flag_player_drink", &function_b5ce1949 );
    level.var_c08dee2d = dialog_tree::new_tree( &function_70276075, undefined, 1, 1 );
    level.var_c08dee2d dialog_tree::add_option( #"hash_2740da147527d173", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "Wife_Response_1" );
    level.var_c08dee2d dialog_tree::add_option( #"hash_2740db147527d326", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "Wife_Response_2" );
    level.var_c08dee2d dialog_tree::add_option( #"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, "flag_chose_distract" );
    level.var_c08dee2d dialog_tree::add_option( #"hash_63e93fbb039d6cd1", undefined, undefined, undefined, 1, "flag_player_drink", "flag_player_drink", &function_b5ce1949 );
    level.var_73955179 = dialog_tree::new_tree( &function_70276075, undefined, 1, 1 );
    level.var_73955179 dialog_tree::add_option( #"hash_3d385886e4c2e706", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "War_Response_1" );
    level.var_73955179 dialog_tree::add_option( #"hash_3d385786e4c2e553", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "War_Response_2" );
    level.var_73955179 dialog_tree::add_option( #"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, "flag_chose_distract" );
    level.var_73955179 dialog_tree::add_option( #"hash_63e93fbb039d6cd1", undefined, undefined, undefined, 1, "flag_player_drink", "flag_player_drink", &function_b5ce1949 );
    level.var_e1220a0d = dialog_tree::new_tree( &function_70276075, undefined, 1, 1 );
    level.var_e1220a0d dialog_tree::add_option( #"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, "flag_chose_distract" );
    level.var_e1220a0d dialog_tree::add_option( #"hash_63e93fbb039d6cd1", undefined, undefined, undefined, 1, "flag_player_drink", "flag_player_drink", &function_b5ce1949 );
    level thread function_6ef38bf( "map_distract", level.var_22af6992 );
    level thread function_6ef38bf( "family_distract", level.var_c08dee2d );
    level thread function_6ef38bf( "war_distract", level.var_73955179 );
    level thread function_6ef38bf( "poison_swap", level.var_e1220a0d );
    level flag::wait_till( "flag_chose_distract" );
    waitframe( 1 );
    
    if ( level flag::get( "flag_player_drink" ) )
    {
        return;
    }
    
    level flag::clear( "flag_charkov_looking" );
    level scene::play( "scene_kgb_poison_tea", level.var_63df18e3 );
    level flag::set( "flag_charkov_looking" );
    level thread scene::play( "scene_kgb_poison_tea", "DT_Choice_2_Loop" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x81e43aea, Offset: 0x125a8
// Size: 0x1c
function function_27304cc( var_63df18e3 )
{
    level.var_63df18e3 = var_63df18e3;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x65bdb454, Offset: 0x125d0
// Size: 0x1c
function function_70276075()
{
    level thread function_d45e658e();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x4164fc42, Offset: 0x125f8
// Size: 0x64
function function_d45e658e()
{
    player = getplayers()[ 0 ];
    player freezecontrols( 1 );
    wait 1;
    player freezecontrols( 0 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0x643962a2, Offset: 0x12668
// Size: 0x134
function function_6ef38bf( var_bc2b55eb, var_162ecf2c )
{
    if ( level flag::get( "flag_player_drink" ) )
    {
        return;
    }
    
    player = getplayers()[ 0 ];
    struct = struct::get( var_bc2b55eb, "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag.var_162ecf2c = var_162ecf2c;
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), undefined, 256, undefined, &function_aa840d2b, undefined, undefined, 10, 0, 1, 0, &function_bc457fe3 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x4beb2ddf, Offset: 0x127a8
// Size: 0x24
function function_aa840d2b( *prompt )
{
    self thread function_ee04db37();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x7b534a12, Offset: 0x127d8
// Size: 0x2c
function function_ee04db37()
{
    wait 0.25;
    level.var_136bf433 = self.var_162ecf2c dialog_tree::run();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8ce2a0eb, Offset: 0x12810
// Size: 0x11c
function function_4e3dfbd0()
{
    level flag::clear( "flag_chose_distract" );
    
    if ( level flag::get( "flag_player_drink" ) )
    {
        return;
    }
    
    waitframe( 1 );
    level flag::wait_till( "flag_chose_distract" );
    waitframe( 1 );
    
    if ( level flag::get( "flag_player_drink" ) )
    {
        return;
    }
    
    level flag::clear( "flag_charkov_looking" );
    level scene::play( "scene_kgb_poison_tea", level.var_63df18e3 );
    level flag::set( "flag_charkov_looking" );
    level thread scene::play( "scene_kgb_poison_tea", "DT_Choice_2_Loop" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x9ac1711f, Offset: 0x12938
// Size: 0x6e, Type: bool
function function_bc457fe3( *prompt )
{
    return !level flag::get( "dialog_tree_active" ) && !level flag::get( "flag_player_drink" ) && !level flag::get( "flag_chose_distract" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x455572fe, Offset: 0x129b0
// Size: 0x1fc
function function_8839afce( pick )
{
    level.var_18430051 = getent( "cup_left", "targetname" );
    level.var_e471caeb = getent( "cup_right", "targetname" );
    level.var_18430051.poison = 0;
    level.var_e471caeb.poison = 0;
    
    if ( pick == "right" )
    {
        level flag::set( "charkov_has_cup_1" );
    }
    
    if ( level.var_c778a7d3 == "poison_right" )
    {
        level.var_e471caeb.poison = 1;
    }
    else
    {
        level.var_18430051.poison = 1;
    }
    
    function_19a8bc44( pick );
    struct = struct::get( "poison_swap", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_2c041cbe0390b7e9", 128, undefined, &function_d94f43d, undefined, undefined, 50, 0, 1, 0, &function_56b67116 );
    level thread function_cc8b4145();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8c3ae478, Offset: 0x12bb8
// Size: 0xb8
function function_cc8b4145()
{
    level endon( #"hash_69957c24329df643" );
    flag = "flag_charkov_turned";
    level flag::set( flag );
    
    while ( true )
    {
        level waittill( #"hash_305ab0b031ad6a1" );
        
        if ( level flag::get( flag ) )
        {
            level flag::clear( flag );
            continue;
        }
        
        level flag::set( flag );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x8a94ea14, Offset: 0x12c78
// Size: 0x4e, Type: bool
function function_56b67116( *prompt )
{
    return !level flag::get( "flag_charkov_looking" ) && !level flag::get( "flag_charkov_turned" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xa1e0dc9f, Offset: 0x12cd0
// Size: 0xac
function function_19a8bc44( var_4d5474d1 )
{
    if ( var_4d5474d1 == "left" )
    {
        level.var_62fb0005 = level.var_18430051;
        level.var_18430051 hide();
        level.var_e471caeb show();
        return;
    }
    
    level.var_62fb0005 = level.var_e471caeb;
    level.var_18430051 show();
    level.var_e471caeb hide();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf92aedbd, Offset: 0x12d88
// Size: 0x344
function function_6336c33f()
{
    if ( level.var_76a74dd5 )
    {
        level thread scene::play( "scene_kgb_poison_tea_player", "DT_Toast" );
        level scene::play( "scene_kgb_poison_tea", "DT_Toast" );
    }
    else
    {
        level thread scene::play( "scene_kgb_poison_tea_player", "DT_Toast" );
        level scene::play( "scene_kgb_poison_tea", "DT_Toast_Alt" );
    }
    
    level thread scene::play( "scene_kgb_poison_tea_player", "DT_Choice_5_Loop" );
    level thread scene::play( "scene_kgb_poison_tea", "DT_Choice_5_Loop" );
    var_bddef49 = dialog_tree::new_tree( undefined, undefined, 1, 1, "scene_kgb_poison_tea" );
    var_bddef49 dialog_tree::add_option( #"hash_71d14858321ea9dd", undefined, undefined, undefined, 1 );
    var_bddef49 dialog_tree::add_option( #"hash_71d14758321ea82a", undefined, undefined, undefined, 1 );
    var_bddef49 dialog_tree::add_option( #"hash_71d14658321ea677", undefined, undefined, undefined, 1 );
    choice = var_bddef49 dialog_tree::run();
    level endon( #"hash_69957c24329df643" );
    
    if ( !level.var_76a74dd5 )
    {
        level scene::play( "scene_kgb_poison_tea", "Confront" );
    }
    else
    {
        level scene::play( "scene_kgb_poison_tea", "Confront_Alt" );
    }
    
    level thread scene::play( "scene_kgb_poison_tea", "Confront_Loop" );
    var_bddef49 = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_bddef49 dialog_tree::add_option( #"hash_499e2e31cb265242", undefined, undefined, undefined, 1, undefined, undefined, &function_2aa3292b );
    var_bddef49 dialog_tree::add_option( #"hash_529f15be9602ad50", undefined, undefined, undefined, 1, undefined, undefined, &function_2aa3292b );
    var_bddef49 dialog_tree::add_option( #"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, undefined, &function_2aa3292b );
    var_bddef49 dialog_tree::run();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x92b62c2b, Offset: 0x130d8
// Size: 0x3c
function function_b5ce1949()
{
    level flag::set( "flag_player_drink" );
    level thread function_6336c33f();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd5f4d717, Offset: 0x13120
// Size: 0x30c
function function_2aa3292b()
{
    level flag::set( "flag_player_drink" );
    
    if ( level.var_62fb0005.poison )
    {
        level thread scene::play( "scene_kgb_poison_tea_player", "DT_Player_Dies" );
        level thread scene::play( "scene_kgb_poison_tea", "DT_Player_Dies" );
        namespace_353d803e::function_b93da28b();
        wait 2;
        util::missionfailedwrapper( #"hash_14c23141aa10eb00", #"hash_73348c6b5dccf418" );
        namespace_353d803e::function_45192a6c();
        return;
    }
    
    level.var_1b4de43[ level.var_1b4de43.size ] = "office";
    level notify( #"ping_map" );
    level flag::set( "flag_poi_office_charkov_dead" );
    level scene::stop( "scene_kgb_secretary_dt" );
    pen = getent( "secretary_pen", "targetname" );
    
    if ( isdefined( pen ) )
    {
        pen delete();
    }
    
    if ( level.var_76a74dd5 )
    {
        level thread scene::play( "scene_kgb_poison_tea", "DT_General_Dies" );
    }
    else
    {
        level thread scene::play( "scene_kgb_poison_tea", "DT_General_Dies_Alt" );
    }
    
    level.general notsolid();
    wait 4;
    level thread scene::play( "scene_kgb_poison_tea", "Player_Standup" );
    level scene::play( "scene_kgb_poison_tea_player", "Player_Standup" );
    namespace_e77bf565::function_f6eb250d();
    level flag::clear( "flag_charkov_in_scene" );
    level scene::stop( "scene_kgb_poison_door" );
    level.general_door unlink();
    doors::unlock_all( 0 );
    level thread function_c9965ab9( 0 );
    level flag::set( "flag_keycard_acquired" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x6e17e3d8, Offset: 0x13438
// Size: 0xe4
function function_8703e51a( struct )
{
    spot = struct.origin + ( 0, 0, 16 );
    objectives::function_4eb5c04a( #"hash_5e6b451a3d52cb04", spot );
    objectives_ui::function_49dec5b( #"hash_5e6b451a3d52cb04", undefined, #"hash_2eb5dbaa39d9d66a" );
    level flag::set( "bunker_key_placed_in_world" );
    level flag::wait_till( "flag_keycard_acquired" );
    objectives::complete( #"hash_5e6b451a3d52cb04" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xab9641f9, Offset: 0x13528
// Size: 0x98
function function_f9bc244e( *prompt )
{
    level.var_48be2c6f = 1;
    
    if ( level.var_2949fa57 )
    {
        level scene::play( "scene_kgb_poison_tea", "door_open" );
    }
    else
    {
        level scene::play( "scene_kgb_poison_tea", "door_close" );
    }
    
    level.var_2949fa57 = !level.var_2949fa57;
    level.var_48be2c6f = 0;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xbde30625, Offset: 0x135c8
// Size: 0x28, Type: bool
function function_5ea556b8( *prompt )
{
    return !level.var_48be2c6f && level.var_2949fa57;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x780a5256, Offset: 0x135f8
// Size: 0x2a, Type: bool
function function_f34d945b( *prompt )
{
    return !level.var_48be2c6f && !level.var_2949fa57;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x8160ef90, Offset: 0x13630
// Size: 0x134
function function_d94f43d( *prompt )
{
    if ( level.var_62fb0005 == level.var_18430051 )
    {
        function_19a8bc44( "right" );
    }
    else
    {
        function_19a8bc44( "left" );
    }
    
    level flag::set( "flag_charkov_looking" );
    
    if ( !level.var_76a74dd5 )
    {
        level thread scene::play( "scene_kgb_poison_tea_player", "Cup_Swap" );
        level thread scene::play( "scene_kgb_poison_tea", "Cup_Swap" );
    }
    else
    {
        level thread scene::play( "scene_kgb_poison_tea_player", "Cup_Swap" );
        level thread scene::play( "scene_kgb_poison_tea", "Cup_Swap_Alt" );
    }
    
    thread namespace_353d803e::function_f25a5965();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xa92613fd, Offset: 0x13770
// Size: 0xfa
function function_d09d1a07( *prompt_struct )
{
    level flag::set( "flag_picked_poison" );
    level.var_c778a7d3 = self.script_noteworthy;
    
    if ( level.var_c778a7d3 != "poison_right" )
    {
        level thread scene::play( "scene_kgb_poison_tea", "Poison_Tea_R" );
        level thread scene::play( "scene_kgb_poison_tea_player", "Poison_Tea_R" );
    }
    else
    {
        level thread scene::play( "scene_kgb_poison_tea", "Poison_Tea_L" );
        level thread scene::play( "scene_kgb_poison_tea_player", "Poison_Tea_L" );
    }
    
    wait 5;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xe82c04dd, Offset: 0x13878
// Size: 0x2c
function function_87e35005( *prompt_struct )
{
    level flag::set( "flag_keycard_acquired" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0x8db5660d, Offset: 0x138b0
// Size: 0x1c2, Type: bool
function function_5b602e4f( player, var_7b20e52b )
{
    if ( isdefined( self.targetname ) && self.targetname == "prisoner" )
    {
        return false;
    }
    
    if ( self.ignoreall )
    {
        return false;
    }
    
    angles = self gettagangles( "tag_eye" );
    v_forward = anglestoforward( angles );
    v_loc = player geteye();
    v_dir = vectornormalize( v_loc - self geteye() );
    dp = vectordot( v_forward, v_dir );
    
    if ( dp > 0.1 )
    {
        if ( is_true( var_7b20e52b ) )
        {
            v_loc = player.origin + ( 0, 0, 48 );
            
            if ( sighttracepassed( self geteye(), v_loc, 0, self ) )
            {
                dist = distance2dsquared( self geteye(), v_loc );
                
                if ( dist < 1960000 )
                {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    return false;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xfd817b5d, Offset: 0x13a80
// Size: 0x286
function function_2008b07b()
{
    a_flags = [];
    a_flags[ a_flags.size ] = "player_in_restricted_area";
    a_flags[ a_flags.size ] = "player_in_restricted_area_charkov_office";
    a_flags[ a_flags.size ] = "player_in_restricted_area_war_room";
    a_flags[ a_flags.size ] = "player_in_restricted_area_data_entry";
    a_flags[ a_flags.size ] = "player_in_restricted_area_records";
    a_flags[ a_flags.size ] = "player_in_restricted_area_office_1";
    a_flags[ a_flags.size ] = "player_in_restricted_maintenance_area";
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level endon( #"flag_player_swap" );
    player = getplayers()[ 0 ];
    
    while ( !level flag::get( "flag_player_swap" ) )
    {
        while ( !player function_70c7a9d0() )
        {
            waitframe( 1 );
        }
        
        level flag::set( "player_doing_stealth_action" );
        
        while ( player function_70c7a9d0() )
        {
            waitframe( 1 );
        }
        
        ailist = getactorarray();
        
        foreach ( ai in ailist )
        {
            if ( !isalive( ai ) )
            {
                continue;
            }
            
            if ( isdefined( ai.stealth ) && isdefined( ai.stealth.threat_sight_state ) )
            {
                ai stealth_threat_sight::threat_sight_set_state_parameters();
            }
        }
        
        level flag::clear( "player_doing_stealth_action" );
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc0f517de, Offset: 0x13d10
// Size: 0x64, Type: bool
function function_70c7a9d0()
{
    return self flag::get_any( [ "body_shield_active", "lockpicking", "takedown_active" ] ) || self namespace_5f6e61d9::function_cad84e26();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x31b03fa, Offset: 0x13d80
// Size: 0xa2
function function_19cebd64()
{
    var_f959417b = [];
    var_f959417b[ var_f959417b.size ] = "vox_cp_rkgb_01575_rms1_yessir_f9";
    var_f959417b[ var_f959417b.size ] = "vox_cp_rkgb_01575_rms1_affirmative_9c";
    var_37a23777 = [];
    var_37a23777[ var_37a23777.size ] = "vox_cp_rkgb_01575_rms2_ofcourse_94";
    var_37a23777[ var_37a23777.size ] = "vox_cp_rkgb_01575_rms2_onmyway_62";
    var_4a6a763f = [];
    var_4a6a763f[ var_4a6a763f.size ] = "vox_cp_rkgb_01575_rms3_immediately_a2";
    var_4a6a763f[ var_4a6a763f.size ] = "vox_cp_rkgb_01575_rms3_immediatelysir_3c";
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x39682fea, Offset: 0x13e30
// Size: 0x244
function function_6c5203f5()
{
    player = getplayers()[ 0 ];
    var_5f75397b = vectornormalize( player.origin - self.origin );
    v_forward = anglestoforward( self.angles );
    var_3f9826ab = vectordot( var_5f75397b, v_forward );
    v_right = anglestoright( self.angles );
    var_8ecbd20e = vectordot( var_5f75397b, v_right );
    
    if ( self haspath() )
    {
        var_186a9be1 = 1;
    }
    
    if ( is_true( var_186a9be1 ) )
    {
        if ( var_3f9826ab >= 0.5 )
        {
            if ( var_8ecbd20e <= -0.5 )
            {
                return "player_in_front_left_walking";
            }
            else if ( var_8ecbd20e >= 0.5 )
            {
                return "player_in_front_right_walking";
            }
            else
            {
                return "player_in_front_walking";
            }
        }
        else if ( var_3f9826ab <= -0.5 )
        {
            if ( var_8ecbd20e <= -0.5 )
            {
                return "player_in_back_left_walking";
            }
            else if ( var_8ecbd20e >= 0.5 )
            {
                return "player_in_back_right_walking";
            }
            else
            {
                return "player_in_back_walking";
            }
        }
        else if ( var_8ecbd20e <= -0.5 )
        {
            return "player_to_left_walking";
        }
        else
        {
            return "player_to_right_walking";
        }
        
        return;
    }
    
    if ( var_3f9826ab >= 0.7 )
    {
        return "player_in_front";
    }
    
    if ( var_3f9826ab <= -0.7 )
    {
        return "player_in_back";
    }
    
    if ( var_8ecbd20e <= -0.7 )
    {
        return "player_to_left";
    }
    
    return "player_to_right";
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd5a80f71, Offset: 0x14080
// Size: 0x4bc
function function_44cc7be0()
{
    player = getplayers()[ 0 ];
    level flag::set( "flag_in_dialogue" );
    player_direction = self function_6c5203f5();
    level flag::set( "flag_hide_social_hint" );
    fakeai = util::spawn_anim_model( self.model, self.origin, self.angles );
    fakeai makefakeai();
    fakeai hide();
    fakeai scene::play_from_time( "scene_kgb_hq_guard_generic_dialog", player_direction, [ fakeai ], 1, 1, 1 );
    fakeai dontinterpolate();
    wait 0.05;
    var_38d4ed7 = fakeai gettagorigin( "j_head" );
    self.var_a2d321ae = fakeai.origin;
    self.var_a28b010e = fakeai.angles;
    fakeai delete();
    self thread function_41bc2f44( var_38d4ed7 );
    self.var_5e564694 = spawner::function_461ce3e9();
    self scene::play( "scene_kgb_hq_guard_generic_dialog", player_direction, [ self ] );
    self thread scene::play( "scene_kgb_hq_guard_generic_dialog", "idle", [ self ] );
    self thread ai::look_at( getplayers()[ 0 ] getplayercamerapos() );
    
    if ( !level flag::get( "flag_first_chat" ) )
    {
        level flag::clear( "dialog_flag_send_front" );
        level flag::clear( "dialog_flag_send_armory" );
        level flag::clear( "dialog_flag_send_elevator" );
        level flag::clear( "flag_guy_at_post" );
        return;
    }
    
    level flag::clear( "flag_guy_at_post" );
    level flag::set( "dialog_flag_send_front" );
    level flag::set( "dialog_flag_send_armory" );
    level flag::set( "dialog_flag_send_elevator" );
    
    if ( level flag::get( "flag_send_front" ) )
    {
        level flag::clear( "dialog_flag_send_front" );
    }
    
    if ( level flag::get( "flag_send_armory" ) )
    {
        level flag::clear( "dialog_flag_send_armory" );
    }
    
    if ( level flag::get( "flag_send_elevator" ) )
    {
        level flag::clear( "dialog_flag_send_elevator" );
    }
    
    if ( self flag::get( "flag_send_front" ) || self flag::get( "flag_send_armory" ) || self flag::get( "flag_send_elevator" ) )
    {
        level flag::set( "flag_guy_at_post" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xf282f649, Offset: 0x14548
// Size: 0x19c
function function_dbfe9c06( s_targetname )
{
    spot = struct::get( s_targetname, "targetname" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    self endon( #"death" );
    player.animnode = player util::spawn_model( "tag_origin", spot.origin, spot.angles );
    blend_time = 1;
    var_73e95cd9 = 0.4;
    var_538574ac = 0.4;
    player thread clientfield::set_to_player( "set_fov", 2 );
    player thread clientfield::set_to_player( "set_dof", 2 );
    player playerlinktoblend( player.animnode, "tag_origin", blend_time, var_73e95cd9, var_538574ac );
    wait blend_time;
    player playerlinktodelta( player.animnode, "tag_origin", 1, 10, 10, 5, 5, 1, 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x2e8645ac, Offset: 0x146f0
// Size: 0x3f4
function function_41bc2f44( var_38d4ed7 )
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    self endon( #"death" );
    var_d77e2032 = 1;
    var_8b9f0a1a = 1;
    player function_1e785651();
    player_eye = player getplayercamerapos();
    var_57f29522 = var_38d4ed7;
    dist = distance( player_eye, var_57f29522 );
    height_diff = player_eye[ 2 ] - var_57f29522[ 2 ];
    var_dadcdf5 = 1;
    
    if ( height_diff < var_dadcdf5 )
    {
        height_diff = var_dadcdf5;
    }
    
    player.orig_origin = player.origin;
    player.animnode = player util::spawn_model( "tag_origin", player.origin, player.angles );
    player.animnode dontinterpolate();
    blend_time = 0.8;
    var_73e95cd9 = 0.4;
    var_538574ac = 0.4;
    var_56ec0c47 = height_diff * var_d77e2032;
    yaw_diff = vectortoangles( player getplayercamerapos() - var_38d4ed7 );
    player.animnode.angles = ( player.animnode.angles[ 0 ] + var_56ec0c47, yaw_diff[ 1 ] + 180, player.animnode.angles[ 2 ] );
    var_370455d2 = player function_f0108ec( player.animnode, self );
    
    if ( isdefined( var_370455d2 ) )
    {
        yaw_diff = vectortoangles( var_370455d2 - var_38d4ed7 );
        player.animnode.angles = ( player.animnode.angles[ 0 ] + var_56ec0c47, yaw_diff[ 1 ] + 180, player.animnode.angles[ 2 ] );
        player.animnode.origin = var_370455d2 - ( 0, 0, 1 );
        player.animnode dontinterpolate();
    }
    
    wait 0.05;
    player thread clientfield::set_to_player( "set_fov", 2 );
    player thread clientfield::set_to_player( "set_dof", 2 );
    player playerlinktoblend( player.animnode, "tag_origin", blend_time, var_73e95cd9, var_538574ac );
    wait blend_time;
    player playerlinktodelta( player.animnode, "tag_origin", 1, 10, 10, 5, 5, 1, 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0x54011b6c, Offset: 0x14af0
// Size: 0x20c
function function_f0108ec( animnode, guy )
{
    var_2f81ae48 = 52;
    var_7be0fa76 = 48;
    var_81adfce0 = 58;
    zoffset = ( 0, 0, 1 );
    start = guy.var_a2d321ae + zoffset;
    end = start + anglestoforward( guy.var_a28b010e ) * var_2f81ae48 + zoffset;
    
    if ( playerphysicstraceignoreent( start, end, guy ) == end )
    {
        start = self.origin + zoffset;
        
        if ( playerphysicstraceignoreent( start, end, self ) == end )
        {
            return end;
        }
    }
    
    var_d17e4076 = distance( self.origin, guy.var_a2d321ae );
    start = self.origin + ( 0, 0, 1 );
    
    if ( var_d17e4076 >= var_7be0fa76 && var_d17e4076 <= var_81adfce0 )
    {
        return undefined;
    }
    
    if ( var_d17e4076 > var_81adfce0 )
    {
        end = start + anglestoforward( animnode.angles ) * ( var_d17e4076 - var_81adfce0 ) + zoffset;
        return phys_trace( self, start, end, guy, var_7be0fa76, var_81adfce0 );
    }
    
    if ( var_d17e4076 < var_7be0fa76 )
    {
        end = start + anglestoforward( animnode.angles ) * ( var_d17e4076 - var_7be0fa76 ) + zoffset;
        return phys_trace( self, start, end, guy, var_7be0fa76, var_81adfce0 );
    }
    
    return undefined;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 6
// Checksum 0x84199074, Offset: 0x14d08
// Size: 0x5a
function phys_trace( player, start, end, *guy, *var_7be0fa76, *var_81adfce0 )
{
    var_95269084 = playerphysicstraceignoreent( var_7be0fa76, var_81adfce0, guy );
    return var_95269084;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5ebad693, Offset: 0x14d70
// Size: 0x84
function function_1e785651()
{
    stance = self getstance();
    
    if ( stance != "stand" )
    {
        self setstance( "stand" );
        
        while ( self getstance() != "stand" )
        {
            wait 0.05;
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xcd1a891c, Offset: 0x14e00
// Size: 0x17c
function function_1829fa5b()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level flag::clear( "flag_in_dialogue" );
    self scene::stop( "scene_kgb_hq_guard_generic_dialog" );
    self thread ai::look_at( undefined );
    
    if ( isdefined( self.var_e2e47219 ) )
    {
        self thread spawner::go_to_node( self.var_e2e47219 );
    }
    else if ( isdefined( self.var_96d56aea ) )
    {
        self thread spawner::go_to_node( self.var_580c6f79 );
        self.var_96d56aea = undefined;
    }
    else
    {
        self thread spawner::go_to_node( self.var_5e564694 );
    }
    
    player thread clientfield::set_to_player( "set_fov", 1 );
    player thread clientfield::set_to_player( "set_dof", 1 );
    player unlink();
    player.animnode delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x76db2a8e, Offset: 0x14f88
// Size: 0x6c
function function_6fa4e73d()
{
    self.var_c862dac6 = "flag_send_front";
    self flag::set( "flag_send_front" );
    self.var_e2e47219 = struct::get( "order_front", "targetname" );
    self thread function_968ada00( "flag_send_front" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x71b15635, Offset: 0x15000
// Size: 0x6c
function function_9d2789fe()
{
    self.var_c862dac6 = "flag_send_armory";
    self flag::set( "flag_send_armory" );
    self.var_e2e47219 = struct::get( "order_armory", "targetname" );
    self thread function_968ada00( "flag_send_armory" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x2deb21a7, Offset: 0x15078
// Size: 0x6c
function function_3d70555()
{
    self.var_c862dac6 = "flag_send_prison";
    self flag::set( "flag_send_prison" );
    self.var_e2e47219 = struct::get( "order_prison", "targetname" );
    self thread function_968ada00( "flag_send_prison" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd6b1a35c, Offset: 0x150f0
// Size: 0x6c
function function_eae4c276()
{
    self.var_c862dac6 = "flag_send_elevator";
    self flag::set( "flag_send_elevator" );
    self.var_e2e47219 = struct::get( "order_elevator", "targetname" );
    self thread function_968ada00( "flag_send_elevator" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf7c94c91, Offset: 0x15168
// Size: 0x54
function function_9bcfd04e()
{
    if ( isdefined( self.var_e2e47219 ) )
    {
        self.var_e2e47219 = undefined;
    }
    
    if ( isdefined( self.var_c862dac6 ) )
    {
        self.var_c862dac6 = undefined;
    }
    
    self.var_96d56aea = 1;
    self thread function_968ada00();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xd6cb68f6, Offset: 0x151c8
// Size: 0x130
function function_968ada00( flag_name )
{
    flag_array = [ "flag_send_front", "flag_send_armory", "flag_send_prison", "flag_send_elevator" ];
    
    if ( isdefined( flag_name ) )
    {
    }
    else
    {
        flag_name = "default";
    }
    
    foreach ( var_e007da5c in flag_array )
    {
        if ( var_e007da5c == flag_name )
        {
            continue;
        }
        
        if ( self flag::get( var_e007da5c ) )
        {
            self flag::clear( var_e007da5c );
            level flag::clear( var_e007da5c );
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8b332dd, Offset: 0x15300
// Size: 0x17c
function function_e27bae4()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level flag::clear( "flag_in_dialogue" );
    self scene::stop( "scene_kgb_hq_guard_generic_dialog" );
    self thread ai::look_at( undefined );
    
    if ( isdefined( self.var_e2e47219 ) )
    {
        self thread spawner::go_to_node( self.var_e2e47219 );
    }
    else if ( isdefined( self.var_96d56aea ) )
    {
        self thread spawner::go_to_node( self.var_580c6f79 );
        self.var_96d56aea = undefined;
    }
    else
    {
        self thread spawner::go_to_node( self.var_5e564694 );
    }
    
    player thread clientfield::set_to_player( "set_fov", 1 );
    player thread clientfield::set_to_player( "set_dof", 1 );
    player unlink();
    player.animnode delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf455e8f4, Offset: 0x15488
// Size: 0x12c
function function_27e21465()
{
    self waittill( #"death" );
    self util::remove_cursor_hint();
    
    if ( self flag::get( "flag_send_front" ) )
    {
        level flag::clear( "flag_send_front" );
    }
    
    if ( self flag::get( "flag_send_armory" ) )
    {
        level flag::clear( "flag_send_armory" );
    }
    
    if ( self flag::get( "flag_send_prison" ) )
    {
        level flag::clear( "flag_send_prison" );
    }
    
    if ( self flag::get( "flag_send_elevator" ) )
    {
        level flag::clear( "flag_send_elevator" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf66a1306, Offset: 0x155c0
// Size: 0xa
function function_50127970()
{
    waitframe( 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0x7a620fb5, Offset: 0x155d8
// Size: 0xa4
function function_1cca61db( flag_name, var_656138f9 )
{
    self endon( #"death" );
    level flag::wait_till_any( flag_name );
    self notify( #"dialog_wait_cancel" );
    self util::remove_cursor_hint();
    
    if ( isdefined( var_656138f9 ) )
    {
        level flag::wait_till_clear( var_656138f9 );
        function_1cca61db( flag_name );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x96c43a94, Offset: 0x15688
// Size: 0x44
function function_c76cf14c( flag_name )
{
    level flag::wait_till( flag_name );
    
    if ( isdefined( self ) )
    {
        self util::remove_cursor_hint();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf9bfc466, Offset: 0x156d8
// Size: 0x2e
function function_9aff7e5c()
{
    self waittill( #"death" );
    self notify( #"dialog_wait_cancel" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc6df8ebc, Offset: 0x15710
// Size: 0x17c
function function_e7fcf8ef()
{
    level thread spare_card();
    level thread function_57a55197();
    struct = struct::get( "struct_computer_hack", "targetname" );
    level scene::init( "scene_kgb_reprogram_computer" );
    level.var_9fe9f285 = spawn( "script_model", struct.origin );
    level.var_9fe9f285 setmodel( "tag_origin" );
    level.var_9fe9f285 util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_1d1e69534e69a425", 32, undefined, &function_6789cd2e );
    level flag::wait_till_any( [ "flag_hacked_done", "flag_keycard_acquired", "flag_prisoner_complete_call" ] );
    level.var_9fe9f285 util::remove_cursor_hint();
    level.var_9fe9f285 delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xd33f1f58, Offset: 0x15898
// Size: 0x1f4
function function_6789cd2e( *prompt_struct )
{
    level thread function_c9965ab9( 1 );
    namespace_e77bf565::function_f6eb250d( "cinematicmotion_kgb_computer" );
    snd::client_msg( #"hash_134c64c3689b26d8" );
    level scene::play( "scene_kgb_reprogram_computer", "Enter" );
    level thread scene::play( "scene_kgb_reprogram_computer", "Loop" );
    function_76fddb1d();
    var_bddef49 = dialog_tree::new_tree( &function_680c8cbe, &function_8392c914, 1, 1 );
    var_bddef49 dialog_tree::function_6bb91351( 1 );
    var_bddef49 dialog_tree::add_option( #"hash_5a27b68cde8bd03d", undefined, undefined, undefined, undefined, undefined, "flag_keycard_acquired", &function_7e5b34f7 );
    var_bddef49 dialog_tree::add_option( #"hash_310a3efc355e1ffb", undefined, undefined, undefined, 1, undefined, "flag_hacked_done", undefined );
    var_bddef49 dialog_tree::run();
    namespace_6f1d35e1::function_b2911127( 0 );
    level thread function_648033a2();
    var_bddef49 = undefined;
    namespace_e77bf565::function_f6eb250d();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xcc1fd961, Offset: 0x15a98
// Size: 0x1c4
function function_76fddb1d()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_1534c55e685d5b11" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    level waittill( #"typing_complete" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x1234a1fc, Offset: 0x15c68
// Size: 0x194
function function_736d0537()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_2a67834942ac9fe7" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xbe432fa2, Offset: 0x15e08
// Size: 0x234
function function_1e568a52()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_28aa991d9ef9b670" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 7, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 8, 20 );
    level waittill( #"typing_complete" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x74408814, Offset: 0x16048
// Size: 0x234
function function_48cb9056()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_5f87c1db1cef3dde" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 7, 20 );
    level waittill( #"typing_complete" );
    wait 1.7;
    namespace_6f1d35e1::function_4951a2c8( 8, 20 );
    level waittill( #"typing_complete" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc24a6c9b, Offset: 0x16288
// Size: 0x128
function function_648033a2()
{
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        snd::client_msg( #"hash_13de9c8b5a620fc3" );
        level scene::play( "scene_kgb_reprogram_computer", "Exit_Key" );
    }
    else
    {
        snd::client_msg( #"hash_326d7039d6caf74" );
        level scene::play( "scene_kgb_reprogram_computer", "Exit" );
    }
    
    level flag::set( "flag_poi_data_computer" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "data";
    level thread function_c9965ab9( 0 );
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0x163b8
// Size: 0x4
function function_a51fea1b()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x66ba8a86, Offset: 0x163c8
// Size: 0x84
function function_8392c914()
{
    level thread function_589d3c34();
    
    if ( level flag::get( "flag_keycard_acquired" ) )
    {
        return;
    }
    
    level.var_9fe9f285 util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_1d1e69534e69a425", 32, undefined, &function_6789cd2e );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xa3c6b6da, Offset: 0x16458
// Size: 0x14
function function_7e5b34f7()
{
    function_a9168808();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6cdee413, Offset: 0x16478
// Size: 0x1a4
function function_a9168808()
{
    if ( level flag::get( "flag_got_spare_card" ) )
    {
        function_1e568a52();
        level scene::play( "scene_kgb_reprogram_computer", "Insert" );
        level thread scene::play( "scene_kgb_reprogram_computer", "Loop" );
        function_48cb9056();
        level flag::set( "flag_keycard_acquired" );
        snd::client_msg( #"hash_8fb789398a122bf" );
        return;
    }
    
    function_736d0537();
    level flag::set( "flag_poi_data_need_popov" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "data";
    level notify( #"ping_map" );
    
    if ( level flag::get( "flag_popov_1" ) && level flag::get( "flag_popov_2" ) )
    {
        level flag::set( "flag_poi_data_need_various" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x1e8606e8, Offset: 0x16628
// Size: 0x1c
function function_8dccd5df()
{
    level thread function_875438fc();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb8b2ed81, Offset: 0x16650
// Size: 0x54
function function_875438fc()
{
    namespace_6f1d35e1::function_487b4340( #"hash_40151610fdd399a2" );
    namespace_6f1d35e1::function_5d2e6f6a( 2 );
    namespace_6f1d35e1::function_4951a2c8( 1, 40 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x548fba08, Offset: 0x166b0
// Size: 0x10c
function spare_card()
{
    tag = getent( "armory_spare_card", "targetname" );
    level scene::init( "scene_kgb_armory_keycard" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_460325cda2b5dc30", 48, undefined, &function_c7de39b1, undefined, undefined, undefined, 0, 0 );
    a_flags = [ "flag_got_spare_card", "flag_keycard_acquired" ];
    level flag::wait_till_any( a_flags );
    tag util::remove_cursor_hint();
    tag delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x9a145570, Offset: 0x167c8
// Size: 0x118
function function_c7de39b1( *prompt_struct )
{
    level flag::set( "flag_got_spare_card" );
    level flag::set( "flag_poi_armory_done" );
    level flag::set( "flag_poi_swap_have" );
    level flag::set( "flag_poi_data_card" );
    namespace_353d803e::music( "4.3_tension_stingers" );
    snd::client_msg( #"hash_2ef69949c5586784" );
    level scene::play( "scene_kgb_armory_keycard" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "data";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x99fa3949, Offset: 0x168e8
// Size: 0x14c
function function_57a55197()
{
    struct = struct::get( "armory_button", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    a_flags = [ "flag_unlock_armory", "flag_keycard_acquired" ];
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_6b548b89534b739b", 48, undefined, &armory_button, undefined, undefined, undefined, undefined, undefined, 0, &function_ad2e6f60 );
    level flag::wait_till_any( a_flags );
    tag util::remove_cursor_hint();
    tag delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xc0128e48, Offset: 0x16a40
// Size: 0x2a
function function_ad2e6f60( *prompt )
{
    return level flag::get( "player_in_restricted_area_data_entry" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x5b04fdf8, Offset: 0x16a78
// Size: 0xc4
function armory_button( *prompt_struct )
{
    snd::client_msg( #"hash_2520e050afad6b28" );
    level flag::set( "flag_unlock_armory" );
    level flag::set( "flag_poi_armory_open" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "data";
    level notify( #"ping_map" );
    doors::unlock( "armory_door", "targetname", 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5ff6bb88, Offset: 0x16b48
// Size: 0xb0
function function_c1a40cd6()
{
    structs = struct::get_array( "paperwork", "targetname" );
    
    foreach ( paper in structs )
    {
        paper thread function_e0ecf6aa();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe320a6ee, Offset: 0x16c00
// Size: 0x164
function function_66e85418()
{
    guy = spawner::simple_spawn_single( "paperwork_room_flashlight_look_guy", &function_862e8bf9 );
    guy thread function_3cf5b786( "flag_player_swap" );
    guy endon( #"death" );
    guy thread function_1c634e1d();
    level flag::wait_till( "flag_poi_armory_paperwork" );
    wait 1;
    scene::play( "war_room_flashlight_look", "patrol_to_flashlight", guy );
    scene::play( "war_room_flashlight_look", "flashlight_idle1", guy );
    scene::play( "war_room_flashlight_look", "flashlight_idle5", guy );
    scene::play( "war_room_flashlight_look", "flashlight_to_patrol", guy );
    node = getnode( guy.target, "targetname" );
    guy thread spawner::go_to_node( node );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x808fc9f4, Offset: 0x16d70
// Size: 0xbc
function function_1c634e1d()
{
    self endon( #"death" );
    self waittill( #"attach" );
    self clientfield::set( "set_flashlight_fx", 1 );
    self flashlight::function_7c2f623b();
    self flashlight::function_65e5c8c8( 1 );
    self waittill( #"detach" );
    self flashlight::light_off();
    self flashlight::function_bfffb3fe();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x3931f0f8, Offset: 0x16e38
// Size: 0x16c
function function_e0ecf6aa()
{
    level thread function_66e85418();
    struct = self;
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_60ccfb5dfa852713", 64, undefined, &function_2fb03191 );
    level flag::wait_till_any( [ "flag_has_paperwork", "flag_keycard_acquired" ] );
    level flag::set( "flag_poi_armory_paperwork" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "data";
    level notify( #"ping_map" );
    tag util::remove_cursor_hint();
    tag delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x3a6e0c9, Offset: 0x16fb0
// Size: 0x84
function function_2fb03191( *prompt )
{
    namespace_353d803e::music( "4.3_tension_stingers" );
    level thread dialogue::function_96171f6d( "vox_cp_rkgb_01940_blkv_nowthatihavethe_c3" );
    level flag::set( "flag_has_paperwork" );
    snd::client_msg( #"hash_2582bdd148041a03" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xbc97f1e8, Offset: 0x17040
// Size: 0x24
function function_aa7e876()
{
    level flag::wait_till( "flag_start_finding_ways" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x11ad6fe7, Offset: 0x17070
// Size: 0xde
function function_7f81c6e4()
{
    level flag::wait_till( "level_is_go" );
    wait 1;
    tvs = getentarray( "security_tv_on", "targetname" );
    
    foreach ( monitor in tvs )
    {
        monitor thread function_6d4b662c();
    }
    
    wait 3;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xdd0192f3, Offset: 0x17158
// Size: 0x8c
function function_6d4b662c()
{
    min_time = 0.25;
    max_time = 1.75;
    wait randomfloatrange( min_time, max_time );
    self setmodel( "p9_rus_security_monitor_01_off" );
    wait 0.5;
    self setmodel( "p9_rus_security_monitor_01_on" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb6cb0b3, Offset: 0x171f0
// Size: 0xb0
function function_7953c722()
{
    vols = getentarray( "camera_volume", "targetname" );
    
    foreach ( vol in vols )
    {
        vol thread function_c795eb22();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb9577f06, Offset: 0x172a8
// Size: 0x1d4
function function_c795eb22()
{
    self endon( #"deleted" );
    
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        var_4d0b1081 = struct::get( self.script_noteworthy, "targetname" );
    }
    else
    {
        var_4d0b1081 = struct::get( self.target, "targetname" );
    }
    
    camera = struct::get( var_4d0b1081.target, "targetname" );
    var_6df176fc = spawn( "script_model", camera.origin );
    var_6df176fc.angles = camera.angles;
    var_6df176fc setmodel( "tag_origin" );
    var_6df176fc clientfield::set( "set_camera_fx", 1 );
    a_flags = [ "disable_all_cameras", "flag_player_swap" ];
    level flag::wait_till( "disable_all_cameras" );
    var_6df176fc clientfield::set( "set_camera_fx", 0 );
    var_6df176fc delete();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x865e6c21, Offset: 0x17488
// Size: 0x7e, Type: bool
function function_3100088f()
{
    if ( self flag::get( "flag_camera" ) )
    {
        return false;
    }
    
    a_flags = [ "disable_all_cameras", "flag_player_swap" ];
    
    if ( level flag::get_any( a_flags ) )
    {
        return false;
    }
    
    return true;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8a2cd3da, Offset: 0x17510
// Size: 0x7e
function function_82583761()
{
    a_flags = [ "disable_all_cameras", "flag_player_swap" ];
    self endon( #"all_prompts_removed" );
    level flag::wait_till_any( a_flags );
    
    if ( isdefined( self ) )
    {
        self notify( #"disable" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0x17598
// Size: 0x4
function function_174e4073()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0x175a8
// Size: 0x4
function function_4d9d73d1()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xba34de7e, Offset: 0x175b8
// Size: 0xcc
function function_799b3854()
{
    level dialogue::function_96171f6d( "vox_cp_rkgb_02000_blkv_nowtoheadtotheb_d6" );
    level flag::wait_till_any( [ "flag_rv_bread_3", "flag_rv_bread_4" ] );
    level dialogue::function_96171f6d( "vox_cp_rkgb_02000_blkv_adlersteamwilln_a7" );
    function_ebf2af84();
    wait 1;
    level dialogue::function_96171f6d( "vox_cp_rkgb_02000_blkv_thisisbelikovin_a4" );
    level flag::set( "flag_allow_boiler_door" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x25a4a6d7, Offset: 0x17690
// Size: 0x15c
function function_ebf2af84()
{
    weapon = getweapon( #"hash_29f63236a13ced42" );
    player = getplayers()[ 0 ];
    level thread hint_tutorial::function_4c2d4fc4( #"hash_39f8c689d87e79ca", undefined, undefined, undefined, 2 );
    player notifyonplayercommand( "radio_guards", "+smoke" );
    player waittill( #"radio_guards" );
    player notifyonplayercommandremove( "radio_guards", "+smoke" );
    level hint_tutorial::function_9f427d88();
    player giveweapon( weapon );
    player switchtoweaponimmediate( weapon, 1 );
    player gestures::function_b6cc48ed( "ges_t9_radio_call_kgb", undefined, 1, 0, undefined, 0, 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0x2230fc71, Offset: 0x177f8
// Size: 0xec
function function_af2de12b( start = 1, dof = 2 )
{
    player = getplayers()[ 0 ];
    
    if ( start )
    {
        player thread clientfield::set_to_player( "set_fov", 2 );
        player thread clientfield::set_to_player( "set_dof", dof );
        return;
    }
    
    player thread clientfield::set_to_player( "set_fov", 1 );
    player thread clientfield::set_to_player( "set_dof", 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0x641014c5, Offset: 0x178f0
// Size: 0x8c
function function_680c8cbe( *start, *dof )
{
    level thread function_af2de12b( 1 );
    
    if ( isai( self ) && isdefined( self.stealth ) )
    {
        self thread ai::look_at( getplayers()[ 0 ] getplayercamerapos() );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xb70868cb, Offset: 0x17988
// Size: 0x1c
function function_f9603eed()
{
    function_680c8cbe( 1, 3 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x4423c106, Offset: 0x179b0
// Size: 0x5c
function function_589d3c34()
{
    level thread function_af2de12b( 0 );
    
    if ( isai( self ) && isdefined( self.stealth ) )
    {
        self thread ai::look_at( undefined );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x352db8b7, Offset: 0x17a18
// Size: 0x2b4
function function_e40b7715()
{
    player = getplayers()[ 0 ];
    
    if ( !level flag::get( "flag_prison_guard_wait" ) )
    {
        player_direction = "player_in_front";
    }
    else
    {
        player_direction = self function_6c5203f5();
    }
    
    fakeai = util::spawn_anim_model( self.model, self.origin, self.angles );
    fakeai makefakeai();
    fakeai hide();
    fakeai scene::play_from_time( "scene_kgb_hq_guard_generic_dialog", player_direction, [ fakeai ], 1, 1, 1 );
    fakeai dontinterpolate();
    wait 0.05;
    var_38d4ed7 = fakeai gettagorigin( "j_head" );
    self.var_a2d321ae = fakeai.origin;
    self.var_a28b010e = fakeai.angles;
    fakeai delete();
    
    if ( !level flag::get( "flag_prison_guard_wait" ) )
    {
        self thread function_dbfe9c06( "struct_prison_guard_chat" );
        self.var_5e564694 = spawner::function_461ce3e9();
        self scene::play( "scene_kgb_hq_guard_generic_dialog", player_direction, [ self ] );
        self thread scene::play( "scene_kgb_influence_prisoner_guard_dt", "Loop", [ self ] );
        return;
    }
    
    self thread function_41bc2f44( var_38d4ed7 );
    self scene::play( "scene_kgb_hq_guard_generic_dialog", player_direction, [ self ] );
    self thread scene::play( "scene_kgb_hq_guard_generic_dialog", "idle", [ self ] );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xdc49896c, Offset: 0x17cd8
// Size: 0x114
function function_44fddcaa()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    self thread ai::look_at( undefined );
    player thread clientfield::set_to_player( "set_fov", 1 );
    player thread clientfield::set_to_player( "set_dof", 1 );
    player unlink();
    player.animnode delete();
    
    if ( !level flag::get( "flag_prison_guard_wait" ) )
    {
        self thread scene::play( "scene_kgb_influence_prisoner_guard_dt", "Loop", [ self ] );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x81d8e8ed, Offset: 0x17df8
// Size: 0xb4
function function_c7476e69()
{
    level thread scene::play( "scene_kgb_walkup_hall_talk", "Loop" );
    level thread scene::play( "scene_kgb_walkup_stairs_duo", "Loop" );
    level flag::wait_till( "flag_player_swap" );
    level scene::stop( "scene_kgb_walkup_hall_talk", 1 );
    level scene::stop( "scene_kgb_walkup_stairs_duo", 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0x17eb8
// Size: 0x4
function function_5b366e56()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xd3f46c86, Offset: 0x17ec8
// Size: 0x2c
function function_6b524517( a_ents )
{
    a_ents[ #"hash_327479a1b6f1ed4a" ] notsolid();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc54ed52c, Offset: 0x17f00
// Size: 0x10c
function function_1c20e038()
{
    level thread function_6ed43003();
    level thread scene::play( "scene_kgb_walkup_gate_guard", "Shot 1" );
    level flag::wait_till( "flag_open_basement" );
    level thread scene::play( "scene_kgb_walkup_gate_guard", "Shot 2" );
    level thread scene::play( "scene_kgb_walkup_adler", "Open" );
    thread namespace_353d803e::function_1ef37bcf();
    wait 2;
    clip = getent( "prison_door_clip", "targetname" );
    clip notsolid();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x67f7ec6, Offset: 0x18018
// Size: 0x4c
function function_5da2f302( a_ents )
{
    a_ents[ #"guard01" ] thread entname::add( #"hash_5adf107d46cc0546", #"axis" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x82387db9, Offset: 0x18070
// Size: 0x10c
function function_6ed43003()
{
    struct = struct::get( "prison_door_interact", "targetname" );
    level.var_bbfad301 = spawn( "script_model", struct.origin );
    level.var_bbfad301 setmodel( "tag_origin" );
    level.var_bbfad301 util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"OBJECTIVES/TALK_TO", 72, undefined, &function_678d5d44 );
    level flag::wait_till( "flag_open_basement" );
    level.var_bbfad301 util::remove_cursor_hint();
    level.var_bbfad301 delete();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6715fe78, Offset: 0x18188
// Size: 0xf2
function function_678d5d44()
{
    var_bddef49 = dialog_tree::new_tree( &function_f9603eed, &function_a4756f23, 0, 1 );
    var_bddef49 dialog_tree::function_6bbbf87( "flag_keycard_acquired", #"hash_1da99e6790aaa1a7", undefined, undefined, undefined, 1, "flag_open_basement", "flag_open_basement" );
    var_bddef49 dialog_tree::function_bc7c03bf();
    var_bddef49 dialog_tree::add_option( #"hash_699c4e4234817fee", undefined, undefined, undefined, 1, undefined, "flag_open_basement", undefined );
    var_bddef49 dialog_tree::run();
    var_bddef49 = undefined;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x2920d584, Offset: 0x18288
// Size: 0x84
function function_a4756f23()
{
    level thread function_589d3c34();
    
    if ( level flag::get( "flag_open_basement" ) )
    {
        return;
    }
    
    level.var_bbfad301 util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"OBJECTIVES/TALK_TO", 72, undefined, &function_678d5d44 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x8f40255d, Offset: 0x18318
// Size: 0x44
function function_9d40e1c( *prompt )
{
    doors::unlock_all( 0 );
    level flag::set( "flag_got_key" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd65f022d, Offset: 0x18368
// Size: 0x1ae
function function_736e8e64()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    a_flags = [];
    a_flags[ a_flags.size ] = "player_basement_vent";
    a_flags[ a_flags.size ] = "player_data_vent";
    
    while ( !level flag::get( "flag_player_swap" ) )
    {
        if ( !player namespace_5f6e61d9::function_cad84e26() && level flag::get_any( a_flags ) )
        {
            level.var_9c4a751d = 1;
            player val::set( #"hash_74d0164cfdcf8bfe", "allow_prone", 0 );
            player thread util::blend_movespeedscale( 0.4, 1 );
            level flag::wait_till_clear_all( a_flags );
            level.var_9c4a751d = 0;
            player val::set( #"hash_74d0164cfdcf8bfe", "allow_prone", 1 );
            player thread util::blend_movespeedscale( 0.85, 1 );
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd34ec39e, Offset: 0x18520
// Size: 0x4bc
function function_5389a722()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level endon( #"flag_player_swap" );
    a_flags = [];
    a_flags[ a_flags.size ] = "player_in_restricted_area";
    a_flags[ a_flags.size ] = "player_in_restricted_area_charkov_office";
    a_flags[ a_flags.size ] = "player_in_restricted_area_war_room";
    a_flags[ a_flags.size ] = "player_in_restricted_area_data_entry";
    a_flags[ a_flags.size ] = "player_in_restricted_area_records";
    a_flags[ a_flags.size ] = "player_in_restricted_area_office_1";
    a_flags[ a_flags.size ] = "player_in_restricted_maintenance_area";
    
    while ( !level flag::get( "flag_player_swap" ) )
    {
        level flag::wait_till_any( level.var_e9c8a6d4 );
        
        if ( level flag::get_any( a_flags ) )
        {
            objectives_ui::function_b6d41b41( #"hash_2fed4b2a96944db4" );
        }
        else
        {
            objectives_ui::function_b6d41b41( #"hash_256e2a486b5f55cf" );
        }
        
        player val::reset( #"hash_bc68371784a550b", "allow_sprint" );
        player val::reset( #"hash_5029f31f15e64e63", "allow_jump" );
        player val::reset( #"hash_674e1e53ededa27f", "allow_prone" );
        
        if ( !player flag::get( "body_shield_active" ) )
        {
            player thread util::blend_movespeedscale( 0.85, 6 );
        }
        
        player namespace_979752dc::set_disguised( 0 );
        level thread restricted_area_first_entered();
        guys = getaiarray();
        
        foreach ( guy in guys )
        {
            guy.var_6eed8aea = 1;
            guy.threatsight = 1;
        }
        
        level.player_in_restricted_area = 1;
        level flag::wait_till_clear_all( level.var_e9c8a6d4 );
        objectives_ui::function_be5b472b();
        player val::set( #"hash_bc68371784a550b", "allow_sprint", 0 );
        player val::set( #"hash_5029f31f15e64e63", "allow_jump", 0 );
        player val::set( #"hash_674e1e53ededa27f", "allow_prone", 0 );
        player thread util::blend_movespeedscale( 0.7, 6 );
        namespace_979752dc::set_disguised( 1 );
        guys = getaiarray();
        
        foreach ( guy in guys )
        {
            guy.var_6eed8aea = 0;
            guy.threatsight = 0;
        }
        
        level.player_in_restricted_area = undefined;
    }
    
    namespace_979752dc::set_disguised( 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0xce0ecbac, Offset: 0x189e8
// Size: 0x1de
function function_9016f31d( *time, var_9be855ca = 0 )
{
    level flag::wait_till( "level_is_go" );
    doors = doors::get_doors( "stealth_door", "targetname" );
    
    foreach ( door in doors )
    {
        if ( isdefined( door.c_door.m_s_bundle.door_start_sound ) )
        {
            door.var_85c0f03 = door.c_door.m_s_bundle.door_start_sound;
        }
        
        if ( isdefined( door.c_door.m_s_bundle.door_start_sound ) )
        {
            door.var_fd8de6dd = door.c_door.m_s_bundle.door_stop_sound;
        }
        
        if ( var_9be855ca )
        {
            door.c_door.m_s_bundle.door_start_sound = door.var_85c0f03;
            door.c_door.m_s_bundle.door_stop_sound = door.var_fd8de6dd;
            continue;
        }
        
        door.c_door.m_s_bundle.door_start_sound = "tmp_interact_lever_a";
        door.c_door.m_s_bundle.door_stop_sound = "tmp_interact_lever_a";
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x1dd0256c, Offset: 0x18bd0
// Size: 0x124
function restricted_area_first_entered()
{
    player = getplayers()[ 0 ];
    
    if ( !level flag::get( "restricted_area_first_entered" ) && !level flag::get( "player_doing_stealth_action" ) )
    {
        player thread dialogue::function_96171f6d( "vox_cp_rkgb_01650_blkv_thisareaisrestr_de" );
        level flag::set( "restricted_area_first_entered" );
        return;
    }
    
    if ( level flag::get( "player_doing_stealth_action" ) && !level flag::get( "first_lockpick_warning" ) && level flag::get( "flag_start_finding_ways" ) )
    {
        level flag::set( "first_lockpick_warning" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x1ac7fac, Offset: 0x18d00
// Size: 0x1c4
function function_50d280db()
{
    level.var_e9c8a6d4 = [];
    level.var_e9c8a6d4[ level.var_e9c8a6d4.size ] = "player_in_restricted_area";
    level.var_e9c8a6d4[ level.var_e9c8a6d4.size ] = "player_in_restricted_area_charkov_office";
    level.var_e9c8a6d4[ level.var_e9c8a6d4.size ] = "player_in_restricted_area_war_room";
    level.var_e9c8a6d4[ level.var_e9c8a6d4.size ] = "player_in_restricted_area_data_entry";
    level.var_e9c8a6d4[ level.var_e9c8a6d4.size ] = "player_in_restricted_area_records";
    level.var_e9c8a6d4[ level.var_e9c8a6d4.size ] = "player_doing_stealth_action";
    level.var_e9c8a6d4[ level.var_e9c8a6d4.size ] = "player_in_restricted_area_office_1";
    level.var_e9c8a6d4[ level.var_e9c8a6d4.size ] = "player_in_restricted_maintenance_area";
    level thread function_70715735();
    level thread function_2008b07b();
    level thread function_5389a722();
    level thread function_736e8e64();
    level thread function_d3357b0e();
    level thread function_4facbf56();
    level thread function_5b17e90e();
    level thread function_6cee2b2b();
    level thread function_93751453();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x61dbfb08, Offset: 0x18ed0
// Size: 0x2c
function function_e9e9570d()
{
    self.dontdropweapon = 1;
    self thread function_3cf5b786( "flag_player_swap" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6cff4b62, Offset: 0x18f08
// Size: 0xa4
function function_6cee2b2b()
{
    level flag::wait_till_any( [ "flag_unlock_southeast_door", "flag_keycard_acquried" ] );
    doors::unlock( "below_atrium_stairwell_double_door_right", "targetname", 0 );
    doors::function_f35467ac( "below_atrium_stairwell_double_door_right", "targetname" );
    waitframe( 1 );
    doors::function_f5dd4f8f( "below_atrium_stairwell_double_door_right", "targetname" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8a196a37, Offset: 0x18fb8
// Size: 0x64
function function_5b17e90e()
{
    level thread function_15559a36();
    org = struct::get( "ins_restricted_area_locker_lock_interact", "targetname" );
    function_ca7fd487( org.origin );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x41bdb24e, Offset: 0x19028
// Size: 0x1e4
function function_15559a36()
{
    level scene::init( "scene_kgb_grab_poison_locker" );
    poison = getent( "ins_restricted_area_locker_poison", "targetname" );
    poison hide();
    level flag::wait_till( "flag_combination_correct" );
    thread namespace_353d803e::function_ca0f1dd6();
    level scene::play( "scene_kgb_grab_poison_locker", "Open" );
    poison util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_2f8d1816b48968eb", 40, undefined, undefined, undefined, undefined, undefined, 0, 1, 1, undefined );
    poison waittill( #"trigger" );
    namespace_353d803e::function_2ecd85bc();
    level scene::play( "scene_kgb_grab_poison_locker", "Grab" );
    level flag::set( "flag_poi_mail_poison" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "office";
    level notify( #"ping_map" );
    namespace_353d803e::music( "4.3_tension_stingers" );
    level flag::set( "flag_has_poison" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x33529567, Offset: 0x19218
// Size: 0x304
function function_ca7fd487( origin )
{
    tag = util::spawn_model( "tag_origin", origin, origin.angles );
    player = getplayers()[ 0 ];
    
    while ( true )
    {
        tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_6a3223c9e4640186", 40, undefined, &function_f5ee087c, undefined, undefined, undefined, undefined, undefined, 1, undefined );
        s_result = player waittill( #"exit", #"combination_correct" );
        namespace_e77bf565::function_f6eb250d();
        
        if ( s_result._notify == #"exit" )
        {
            function_c9965ab9( 0 );
            continue;
        }
        
        if ( s_result._notify == #"combination_correct" )
        {
            tag util::remove_cursor_hint();
            lock = getent( "ins_restricted_area_locker_lock", "targetname" );
            
            if ( isdefined( lock ) )
            {
                lock delete();
            }
            
            lock_pieces = getentarray( "lock_pieces", "targetname" );
            
            foreach ( piece in lock_pieces )
            {
                door = getent( piece.target, "targetname" );
                piece linkto( door );
            }
            
            wait 1;
            namespace_6fdcb0::function_838e9ba9();
            function_c9965ab9( 0 );
            level flag::set( "flag_combination_correct" );
            tag delete();
            break;
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6036ceeb, Offset: 0x19528
// Size: 0x2cc
function function_f5ee087c()
{
    player = getplayers()[ 0 ];
    player function_61f60c40();
    player notifyonplayercommandremove( "show_itin", "+actionslot 4" );
    player hide();
    function_c9965ab9( 1 );
    namespace_e77bf565::function_f6eb250d( "cinematicmotion_kgb_computer" );
    namespace_6fdcb0::function_912776e6( #"hash_1345b8c1d1ad23a9" );
    namespace_c8e236da::addprompt( #"hash_2c16a04fab0346fa" );
    namespace_c8e236da::addprompt( #"hash_87cb1efbc51f19b" );
    namespace_c8e236da::addprompt( #"hash_5c8c8fae13b36286" );
    namespace_c8e236da::addprompt( #"hash_68ecec68c06f225b" );
    namespace_c8e236da::addprompt( #"hash_7d0ad4e924d219af" );
    
    while ( true )
    {
        s_result = player waittill( #"exit", #"combination_correct" );
        
        if ( s_result._notify == #"exit" )
        {
            level flag::set( "combination_lock_exited" );
            self notify( #"exit" );
            break;
        }
        
        if ( s_result._notify == #"combination_correct" )
        {
            level flag::set( "combination_lock_opened" );
            combination_correct = 1;
            self notify( #"combination_correct" );
            break;
        }
        
        wait 0.05;
    }
    
    player function_a1af304b();
    player notifyonplayercommand( "show_itin", "+actionslot 4" );
    player show();
    namespace_c8e236da::removelist();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x43dc3d80, Offset: 0x19800
// Size: 0x124
function function_61f60c40()
{
    self setstance( "stand" );
    self freezecontrols( 1 );
    self val::set( #"hash_25ec54e9c679c85a", "show_hud", 0 );
    ins_restricted_area_locker_player_pos = struct::get( "ins_restricted_area_locker_player_pos", "targetname" );
    level.var_8deab66f = util::spawn_model( "tag_origin", ins_restricted_area_locker_player_pos.origin, ins_restricted_area_locker_player_pos.angles );
    level.var_8deab66f dontinterpolate();
    self playerlinktoblend( level.var_8deab66f, "tag_origin", 0.5, 0, 0, 0.5, 0, 0, 0 );
    wait 0.5;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x1ff2a853, Offset: 0x19930
// Size: 0x7c
function function_a1af304b()
{
    self val::reset( #"hash_25ec54e9c679c85a", "show_hud" );
    self unlink();
    level.var_8deab66f delete();
    wait 0.05;
    self freezecontrols( 0 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf709eb9f, Offset: 0x199b8
// Size: 0x30c
function function_d3357b0e()
{
    player = getplayers()[ 0 ];
    level.var_d177b2eb = dialog_tree::new_tree( undefined, undefined, 1, 1, undefined, 0 );
    level.var_d177b2eb dialog_tree::function_6bb91351( 1 );
    level.var_d177b2eb dialog_tree::add_option( #"hash_7d34d3de982050e9", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_c8954f13 );
    level.var_d177b2eb dialog_tree::add_option( #"hash_7d34d0de98204bd0", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_caa6a3ae );
    level.var_d177b2eb dialog_tree::add_option( #"hash_7d34d1de98204d83", undefined, undefined, undefined, 1, "flag_krav_computer_end", "flag_player_swap" );
    level.var_be570ce6 = dialog_tree::new_tree( undefined, undefined, 1, 1, undefined, 0 );
    level.var_be570ce6 dialog_tree::function_6bb91351( 1 );
    level.var_be570ce6 dialog_tree::add_option( #"hash_7d34d6de98205602", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_6144219f );
    level.var_c076dbe2 = dialog_tree::new_tree( undefined, undefined, 1, 1, undefined, 0 );
    level.var_c076dbe2 dialog_tree::function_6bb91351( 1 );
    level.var_c076dbe2 dialog_tree::add_option( #"hash_7d34d6de98205602", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_6144219f );
    struct = struct::get( "krav_computer_struct", "targetname" );
    tag = util::spawn_model( "tag_origin", struct.origin, struct.angles );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), undefined, 48, undefined, &function_4674ac30, undefined, undefined, undefined, undefined, undefined, 0 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xeb779ddf, Offset: 0x19cd0
// Size: 0x17c
function function_4674ac30( *prompt )
{
    level flag::clear( "flag_krav_computer_end" );
    namespace_e77bf565::function_f6eb250d( "cinematicmotion_kgb_computer" );
    level thread function_c9965ab9( 1 );
    snd::client_msg( #"hash_4692f2d7c81a7c95" );
    level scene::play( "scene_kgb_krav_computer", "Enter" );
    level thread scene::play( "scene_kgb_krav_computer", "Loop" );
    function_85aa7da();
    level.var_d177b2eb thread dialog_tree::run();
    level flag::wait_till( "flag_krav_computer_end" );
    namespace_6f1d35e1::function_b2911127( 0 );
    level scene::play( "scene_kgb_krav_computer", "Exit" );
    level thread function_c9965ab9( 0 );
    namespace_e77bf565::function_f6eb250d();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x3f786860, Offset: 0x19e58
// Size: 0x18c
function function_85aa7da()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_36b7601e290f25d6" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x6597b927, Offset: 0x19ff0
// Size: 0x21c
function function_c8954f13()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_57b8ffd5faae9aa" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 7, 20 );
    level waittill( #"typing_complete" );
    wait 2;
    level.var_be570ce6 thread dialog_tree::run();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x694a87fd, Offset: 0x1a218
// Size: 0x254
function function_caa6a3ae()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_6f5c0c413d982cf5" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 7, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 8, 20 );
    level waittill( #"typing_complete" );
    wait 2;
    level.var_c076dbe2 thread dialog_tree::run();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x66f0783b, Offset: 0x1a478
// Size: 0x34
function function_6144219f()
{
    function_85aa7da();
    wait 2;
    level.var_d177b2eb thread dialog_tree::run();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x1d67d116, Offset: 0x1a4b8
// Size: 0x5ac
function function_4facbf56()
{
    level.var_5b202469 = 10;
    level scene::init( "scene_kgb_restricted_area_hack" );
    level.var_a997edb = dialog_tree::new_tree( undefined, undefined, 1, 1, undefined, 0 );
    level.var_a997edb dialog_tree::function_6bb91351( 1 );
    level.var_a997edb dialog_tree::add_option( #"hash_309527a5b69f205e", undefined, undefined, undefined, 0, undefined, undefined, &function_c8feadcf );
    level.var_a997edb dialog_tree::function_9e36808( #"hash_309526a5b69f1eab", undefined, undefined, undefined, 0, undefined, undefined, &function_bded9011 );
    level.var_a997edb dialog_tree::function_9e36808( #"hash_309525a5b69f1cf8", undefined, undefined, undefined, 1, undefined, undefined, &function_4526244e );
    level.hack_start = dialog_tree::new_tree( undefined, undefined, 1, 1, undefined, 0 );
    level.hack_start dialog_tree::function_6bb91351( 1 );
    level.hack_start dialog_tree::add_option( #"hash_37bb5d17341c5dd9", undefined, undefined, undefined, 1, undefined, "flag_server_computer_done", &function_1788a45e, 1 );
    level.var_1788a45e = dialog_tree::new_tree( undefined, undefined, 1, 1, undefined, 0 );
    level.var_1788a45e dialog_tree::function_6bb91351( 1 );
    level.var_1788a45e dialog_tree::add_option( #"hash_aae848a2bc1cb06", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e );
    level.var_1788a45e dialog_tree::add_option( #"hash_aae838a2bc1c953", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e );
    level.var_1788a45e dialog_tree::add_option( #"hash_aae828a2bc1c7a0", undefined, undefined, undefined, 1, undefined, "flag_server_computer_done", &function_674ac3e5 );
    level.var_674ac3e5 = dialog_tree::new_tree( undefined, undefined, 1, 1, undefined, 0 );
    level.var_674ac3e5 dialog_tree::function_6bb91351( 1 );
    level.var_674ac3e5 dialog_tree::add_option( #"hash_285ef8a27471b17", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e );
    level.var_674ac3e5 dialog_tree::add_option( #"hash_285f08a27471cca", undefined, undefined, undefined, 1, undefined, "flag_server_computer_done", &function_44277d9b );
    level.var_674ac3e5 dialog_tree::add_option( #"hash_285f18a27471e7d", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e );
    level.var_44277d9b = dialog_tree::new_tree( undefined, undefined, 1, 1, undefined, 0 );
    level.var_44277d9b dialog_tree::function_6bb91351( 1 );
    level.var_44277d9b dialog_tree::add_option( #"hash_77d1368a20a2a8bc", undefined, undefined, undefined, 1, undefined, "flag_server_computer_done", &hack_done );
    level.var_44277d9b dialog_tree::add_option( #"hash_77d1398a20a2add5", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e );
    level.var_44277d9b dialog_tree::add_option( #"hash_77d1388a20a2ac22", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e );
    ins_restricted_area_computer_org = struct::get( "ins_restricted_area_computer_org", "targetname" );
    tag = util::spawn_model( "tag_origin", ins_restricted_area_computer_org.origin, ins_restricted_area_computer_org.angles );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), undefined, 48, undefined, &function_3f19c1c2, undefined, undefined, undefined, undefined, undefined, 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x4269c081, Offset: 0x1aa70
// Size: 0x74
function function_1788a45e( start = 0 )
{
    if ( !start )
    {
        function_dfa1824b( 0 );
    }
    else
    {
        function_9ee7f44b();
    }
    
    wait 2;
    level.var_1788a45e thread dialog_tree::run( undefined, undefined, undefined );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xf3844c3b, Offset: 0x1aaf0
// Size: 0x4c
function function_674ac3e5()
{
    function_dfa1824b( 1 );
    wait 2;
    level.var_674ac3e5 thread dialog_tree::run( undefined, undefined, level.var_5b202469 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5baa5b61, Offset: 0x1ab48
// Size: 0x4c
function function_44277d9b()
{
    function_dfa1824b( 1 );
    wait 2;
    level.var_44277d9b thread dialog_tree::run( undefined, undefined, level.var_5b202469 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd532293a, Offset: 0x1aba0
// Size: 0x34
function hack_done()
{
    function_23cd85cd();
    wait 2;
    level.var_a997edb thread dialog_tree::run();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x6b33fcf3, Offset: 0x1abe0
// Size: 0x134
function function_3f19c1c2( *prompt )
{
    level thread function_c9965ab9( 1 );
    namespace_e77bf565::function_f6eb250d( "cinematicmotion_kgb_computer" );
    snd::client_msg( #"hash_4692f2d7c81a7c95" );
    level scene::play( "scene_kgb_restricted_area_hack", "Enter" );
    level thread scene::play( "scene_kgb_restricted_area_hack", "Loop" );
    level.hack_start thread dialog_tree::run();
    level flag::wait_till( "false_intel_printed" );
    level scene::play( "scene_kgb_restricted_area_hack", "Exit" );
    level thread function_c9965ab9( 0 );
    namespace_e77bf565::function_f6eb250d();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xbe1651f4, Offset: 0x1ad20
// Size: 0x1c4
function function_c8feadcf()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_6064caa1b7a63903" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    level waittill( #"typing_complete" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x659304d4, Offset: 0x1aef0
// Size: 0x18c
function function_9ee7f44b()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_b3d19381fa4b284" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x2c5b0b46, Offset: 0x1b088
// Size: 0x234
function function_dfa1824b( success = 0 )
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_611c4961fbe7922d" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    
    if ( success )
    {
        namespace_6f1d35e1::function_4951a2c8( 2, 20 );
        level waittill( #"typing_complete" );
        wait 0.7;
    }
    else
    {
        namespace_6f1d35e1::function_4951a2c8( 3, 20 );
        level waittill( #"typing_complete" );
        wait 0.7;
    }
    
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    
    if ( success )
    {
        namespace_6f1d35e1::function_4951a2c8( 6, 20 );
        level waittill( #"typing_complete" );
        wait 0.7;
        return;
    }
    
    namespace_6f1d35e1::function_4951a2c8( 7, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xa50f169a, Offset: 0x1b2c8
// Size: 0x11c
function function_23cd85cd()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_b3d19381fa4b284" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 6, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 7, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 8, 20 );
    level waittill( #"typing_complete" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x2c896b34, Offset: 0x1b3f0
// Size: 0x1e4
function function_bded9011()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_7b2a28e49a6a92af" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 3, 30 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    snd::client_msg( #"hash_645d2b3398bf399c" );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.7;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    level waittill( #"typing_complete" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8077f12b, Offset: 0x1b5e0
// Size: 0x23c
function function_4526244e()
{
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.05;
    namespace_6f1d35e1::function_eea42dd9( #"hash_36ad27d8fa250b03" );
    namespace_6f1d35e1::function_487b4340( #"hash_7083c5b3995b2394" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 30 );
    level waittill( #"typing_complete" );
    wait 1;
    namespace_6f1d35e1::function_4951a2c8( 2, 20 );
    snd::client_msg( #"hash_1a618ec692a1e9e3" );
    level waittill( #"typing_complete" );
    wait 0.5;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 0.5;
    namespace_6f1d35e1::function_4951a2c8( 4, 20 );
    level waittill( #"typing_complete" );
    wait 0.5;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.5;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    snd::client_msg( #"hash_3e2a2b64b78567ad" );
    level waittill( #"typing_complete" );
    wait 0.5;
    namespace_6f1d35e1::function_b2911127( 0 );
    level thread function_19064ad8();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x7318fcd5, Offset: 0x1b828
// Size: 0x250
function function_19064ad8()
{
    false_intel_org = struct::get( "false_intel_org", "targetname" );
    false_intel = util::spawn_model( "p9_nic_paper_document_sheet_nova_1b", false_intel_org.origin, false_intel_org.angles );
    tag = util::spawn_model( "tag_origin", false_intel_org.origin, false_intel_org.angles );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_799cc020cae47520", undefined, undefined, undefined, undefined, undefined, undefined, 0, 1, 1, undefined );
    level flag::set( "false_intel_printed" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "checkpoint";
    level notify( #"ping_map" );
    objectives::function_4eb5c04a( #"hash_31de057f9d4529f0", tag.origin );
    level thread function_4bccd512();
    tag waittill( #"trigger" );
    snd::client_msg( #"hash_b676297e22090ca" );
    false_intel delete();
    tag delete();
    level flag::set( "has_false_intel" );
    level.var_eede7a6 notify( #"dialog_wait_cancel" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "checkpoint";
    level notify( #"ping_map" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x460c8ab0, Offset: 0x1ba80
// Size: 0x64
function function_4bccd512()
{
    level flag::wait_till_any( [ "has_false_intel", "flag_keycard_acquired" ] );
    objectives::complete( #"hash_31de057f9d4529f0", undefined, 0 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80a92c85, Offset: 0x1baf0
// Size: 0xac
function function_ed39356a()
{
    player = getplayers()[ 0 ];
    level flag::wait_till( "level_is_go" );
    level.quest_objectives = [];
    function_eb745490();
    function_b0a7c6ab();
    function_c66af6b6();
    function_f152863f();
    level thread function_940ae8f6();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xbf3df31b, Offset: 0x1bba8
// Size: 0x1f0
function function_940ae8f6()
{
    var_5626983c = [];
    var_5626983c[ var_5626983c.size ] = "bunker_key_placed_in_world";
    var_5626983c[ var_5626983c.size ] = "flag_keycard_acquired";
    level flag::wait_till_any( var_5626983c );
    hotspots = getentarray( "mental_map_poi", "targetname" );
    
    foreach ( hotspot in hotspots )
    {
        hotspot interactive_map::function_4b1a5235( #"alt1" );
    }
    
    if ( isdefined( level.quest_objectives ) )
    {
        keys = getarraykeys( level.quest_objectives );
        
        if ( isdefined( keys ) )
        {
            foreach ( key in keys )
            {
                id = objectives::function_285e460( key );
                
                if ( isdefined( id ) )
                {
                    objectives::remove( key );
                }
            }
        }
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xfccf5f34, Offset: 0x1bda0
// Size: 0x42c
function function_1b3bebea( prompt_struct )
{
    data = prompt_struct;
    namespace_353d803e::function_5865b09e();
    location = level.interactive_map.var_2c15274b.object.script_noteworthy;
    
    if ( isdefined( location ) )
    {
        switch ( location )
        {
            case #"hash_215b2b6854de7388":
            case #"charkov_office":
                objective_name = "poison_tea";
                break;
            case #"checkpoint":
            case #"server":
                objective_name = "making_a_mole";
                break;
            case #"interrogation":
            case #"records":
                objective_name = "prisoner_persuasion";
                break;
            case #"data":
            case #"armory":
                objective_name = "key_reprogram";
                break;
            default:
                break;
        }
    }
    
    keys = getarraykeys( level.quest_objectives );
    
    if ( !isdefined( level.quest_objectives[ objective_name ] ) )
    {
        return;
    }
    
    foreach ( key in keys )
    {
        if ( key == objective_name )
        {
            if ( isdefined( level.quest_objectives[ key ] ) )
            {
                level.quest_objectives[ key ].tracked = 1;
            }
            
            id = objectives::function_285e460( key );
            
            if ( isdefined( id ) )
            {
                thread objectives_ui::function_f3ac479c( id );
                objectives::show( key );
                
                if ( key == "key_reprogram" )
                {
                    var_aed3a664 = objectives::function_285e460( "key_reprogram_0" );
                    
                    if ( isdefined( var_aed3a664 ) )
                    {
                        thread objectives_ui::function_f3ac479c( var_aed3a664 );
                        var_b3aeaaf1 = objectives::function_285e460( "key_reprogram_0" );
                        thread objectives_ui::function_f3ac479c( var_b3aeaaf1 );
                        objectives::show( "key_reprogram_0" );
                        objectives::show( "key_reprogram_1" );
                    }
                }
            }
            
            continue;
        }
        
        if ( isdefined( level.quest_objectives[ key ] ) )
        {
            level.quest_objectives[ key ].tracked = 0;
        }
        
        id = objectives::function_285e460( key );
        
        if ( isdefined( id ) )
        {
            objectives::hide( key );
            
            if ( key == "key_reprogram" )
            {
                var_aed3a664 = objectives::function_285e460( "key_reprogram_0" );
                
                if ( isdefined( var_aed3a664 ) )
                {
                    objectives::hide( "key_reprogram_0" );
                    objectives::hide( "key_reprogram_1" );
                }
            }
        }
    }
    
    function_bd719400();
    function_3a103505();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xd435931a, Offset: 0x1c1d8
// Size: 0xf4
function function_5a785465( *prompt_struct )
{
    namespace_353d803e::function_5865b09e();
    level.var_dc5a0371 = !level.var_dc5a0371;
    
    if ( isdefined( level.informant ) )
    {
        if ( level.var_dc5a0371 )
        {
            level.informant interactive_map::add_object( #"kgb_informant_spawner", level.var_5fc836e5, 0 );
            objectives::show( #"hash_76daa952e81173e7" );
            return;
        }
        
        level.informant interactive_map::remove_object( #"kgb_informant_spawner" );
        objectives::hide( #"hash_76daa952e81173e7" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe34b4757, Offset: 0x1c2d8
// Size: 0x2dc
function function_3a103505()
{
    hotspots = getentarray( "mental_map_poi", "targetname" );
    
    for ( i = 0; i < hotspots.size ; i++ )
    {
        hotspots[ i ] interactive_map::function_4b1a5235( #"confirm" );
        
        switch ( hotspots[ i ].script_noteworthy )
        {
            case #"charkov_office":
                if ( !level.quest_objectives[ #"poison_tea" ].tracked )
                {
                    hotspots[ i ] interactive_map::function_b5c2702b( #"confirm", level.var_a7c109a9 );
                }
                
                break;
            case #"checkpoint":
                if ( !level.quest_objectives[ #"making_a_mole" ].tracked )
                {
                    hotspots[ i ] interactive_map::function_b5c2702b( #"confirm", level.var_a7c109a9 );
                }
                
                break;
            case #"interrogation":
                if ( !level.quest_objectives[ #"prisoner_persuasion" ].tracked )
                {
                    hotspots[ i ] interactive_map::function_b5c2702b( #"confirm", level.var_a7c109a9 );
                }
                
                break;
            case #"data":
                if ( !level.quest_objectives[ #"key_reprogram" ].tracked )
                {
                    hotspots[ i ] interactive_map::function_b5c2702b( #"confirm", level.var_a7c109a9 );
                }
                
                break;
            case #"informant":
                if ( namespace_94c47ce5::function_11b2b847() && !level flag::get( "flag_informant_killed" ) )
                {
                    hotspots[ i ] interactive_map::function_b5c2702b( #"confirm", level.var_ac82c4c6 );
                }
                
                break;
            default:
                break;
        }
    }
    
    interactive_map::function_59b2a130( hotspots );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5f215d5c, Offset: 0x1c5c0
// Size: 0x6c
function function_eb745490()
{
    objective_name = "poison_tea";
    level.quest_objectives[ objective_name ] = spawnstruct();
    level.quest_objectives[ objective_name ].tracked = 0;
    level thread function_3657d953( objective_name );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc1c0bf46, Offset: 0x1c638
// Size: 0x6c
function function_b0a7c6ab()
{
    objective_name = "making_a_mole";
    level.quest_objectives[ objective_name ] = spawnstruct();
    level.quest_objectives[ objective_name ].tracked = 0;
    level thread function_aecd702e( objective_name );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x981566, Offset: 0x1c6b0
// Size: 0x6c
function function_c66af6b6()
{
    objective_name = "prisoner_persuasion";
    level.quest_objectives[ objective_name ] = spawnstruct();
    level.quest_objectives[ objective_name ].tracked = 0;
    level thread function_240afef6( objective_name );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc5340567, Offset: 0x1c728
// Size: 0x6c
function function_f152863f()
{
    objective_name = "key_reprogram";
    level.quest_objectives[ objective_name ] = spawnstruct();
    level.quest_objectives[ objective_name ].tracked = 0;
    level thread function_88437b4d( objective_name );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xd12f18c7, Offset: 0x1c7a0
// Size: 0x25c
function function_3657d953( objective_name )
{
    level endon( #"flag_keycard_acquired" );
    
    while ( !isdefined( level.secretary ) )
    {
        waitframe( 1 );
    }
    
    loc = struct::get( "fake_secretary_chat", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    objectives_ui::function_49dec5b( objective_name, undefined, #"hash_b02843f7037ef32" );
    objectives::hide( objective_name );
    level flag::wait_till_any( [ "flag_has_poison", "flag_player_scheduled_meeting" ] );
    loc = struct::get( "ins_restricted_area_locker_lock_interact", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    objectives::hide( objective_name );
    level flag::wait_till( "flag_has_poison" );
    loc = struct::get( "fake_secretary_chat", "targetname" );
    objectives::update_position( objective_name, loc.origin );
    level flag::wait_till( "flag_poi_office_meeting" );
    loc = struct::get( "poison_chat", "targetname" );
    objectives::update_position( objective_name, loc.origin );
    level flag::wait_till( "player_sat_in_charkovs_office" );
    objectives::remove( objective_name );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x2bb134f6, Offset: 0x1ca08
// Size: 0x2ec
function function_aecd702e( objective_name )
{
    level endon( #"flag_keycard_acquired" );
    
    while ( !isdefined( level.var_eede7a6 ) )
    {
        waitframe( 1 );
    }
    
    loc = struct::get( "struct_obj_mule_guard", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    objectives_ui::function_49dec5b( objective_name, undefined, #"hash_5990a66ba2d79b35" );
    objectives::hide( objective_name );
    level flag::wait_till_any( [ "false_intel_printed", "flag_poi_krav_chat" ] );
    loc = struct::get( "ins_restricted_area_computer_org", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    level flag::wait_till( "false_intel_printed" );
    objectives::remove( objective_name );
    level flag::wait_till( "has_false_intel" );
    loc = struct::get( "struct_obj_mule_guard", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    
    if ( !level.quest_objectives[ objective_name ].tracked )
    {
        objectives::hide( objective_name );
    }
    else
    {
        objectives::show( objective_name );
    }
    
    objectives::update_position( objective_name, loc.origin );
    level flag::wait_till( "flag_checkpoint_moment_done" );
    loc = struct::get( "obj_checkpoint", "targetname" );
    objectives::update_position( objective_name, loc.origin );
    level flag::wait_till( "bunker_key_placed_in_world" );
    objectives::remove( objective_name );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x25b4a012, Offset: 0x1cd00
// Size: 0x3d4
function function_240afef6( objective_name )
{
    level endon( #"flag_keycard_acquired" );
    loc = struct::get( "prisoner_start", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    objectives_ui::function_49dec5b( objective_name, undefined, #"hash_585e9e16f7a506c6" );
    objectives::hide( objective_name );
    var_be11e544 = [];
    var_be11e544[ var_be11e544.size ] = "flag_poi_records_file";
    var_be11e544[ var_be11e544.size ] = "flag_poi_interrogation_file";
    var_be11e544[ var_be11e544.size ] = "flag_poi_interrogation_leverage";
    msg = level flag::wait_till_any( var_be11e544 );
    
    switch ( msg._notify )
    {
        case #"flag_poi_interrogation_file":
            loc = struct::get( "prisoner_chat", "targetname" );
            objectives::update_position( objective_name, loc.origin );
            level flag::wait_till( "flag_poi_interrogation_leverage" );
            break;
        case #"flag_poi_records_locked":
        case #"flag_poi_records_file":
            loc = struct::get( "prisoner_chat", "targetname" );
            objectives::update_position( objective_name, loc.origin );
            level flag::wait_till( "flag_poi_interrogation_leverage" );
            break;
        case #"flag_poi_interrogation_leverage":
            break;
        default:
            break;
    }
    
    loc = struct::get( "prisoner_start", "targetname" );
    objectives::update_position( objective_name, loc.origin );
    level flag::wait_till( "flag_poi_interrogation_uncuff" );
    loc = struct::get( "cuffs", "targetname" );
    objectives::update_position( objective_name, loc.origin );
    level flag::wait_till( "flag_prisoner_complete" );
    loc = struct::get( "outside_interrogation_room", "targetname" );
    objectives::update_position( objective_name, loc.origin );
    level flag::wait_till( "flag_poi_interrogation_take" );
    objectives::update_position( objective_name, level.var_fd2ed10f );
    level flag::wait_till( "flag_prison_guard_go_away" );
    objectives::remove( objective_name );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xa2d66ce0, Offset: 0x1d0e0
// Size: 0x64c
function function_88437b4d( objective_name )
{
    level endon( #"flag_keycard_acquired" );
    
    while ( !isdefined( level.armory_guard ) )
    {
        waitframe( 1 );
    }
    
    loc = struct::get( "armory_guard_obj", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    objectives_ui::function_49dec5b( objective_name, undefined, #"hash_649578d6e61c5747" );
    objectives::hide( objective_name );
    level flag::wait_till_any( [ "flag_poi_armory_guy_dead", "flag_armory_persuade_03_called", "flag_request_armory" ] );
    loc = struct::get( "spare_card", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    loc = struct::get( "spare_card", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    level flag::wait_till_any( [ "flag_poi_armory_guy_dead", "flag_poi_armory_guard" ] );
    loc = struct::get( "paperwork", "targetname" );
    objectives::update_position( objective_name, loc.origin );
    objectives_ui::function_49dec5b( objective_name, undefined, #"hash_770e19675ef089cb" );
    msg = level flag::wait_till_any( [ "flag_poi_armory_guy_dead", "flag_poi_armory_paperwork", "flag_has_cigar", "flag_armory_persuade_03_called" ] );
    
    if ( msg._notify == "flag_armory_persuade_03_called" )
    {
        var_d02e0a4b = struct::get_array( "cigar", "targetname" );
        
        for ( i = 0; i < var_d02e0a4b.size ; i++ )
        {
            var_d3d9d3b = objective_name + "_" + string( i );
            objectives::goto( var_d3d9d3b, var_d02e0a4b[ i ].origin, undefined, 0 );
            objectives_ui::function_49dec5b( var_d3d9d3b, undefined, #"hash_4b89c25b2524b4d2" );
            objectives::function_6a5ca7ac( var_d3d9d3b, undefined, objective_name );
        }
        
        level flag::wait_till_any( [ "flag_poi_armory_guy_dead", "flag_poi_armory_paperwork", "flag_has_cigar" ] );
    }
    
    if ( isdefined( var_d02e0a4b ) )
    {
        for ( i = 0; i < var_d02e0a4b.size ; i++ )
        {
            var_d3d9d3b = objective_name + "_" + string( i );
            objectives::complete( var_d3d9d3b );
        }
    }
    
    objectives_ui::function_49dec5b( objective_name, undefined, #"hash_649578d6e61c5747" );
    
    if ( !level flag::get( "flag_poi_armory_guy_dead" ) )
    {
        loc = struct::get( "armory_guard_obj", "targetname" );
        objectives::goto( objective_name, loc.origin, undefined, 0 );
    }
    else
    {
        struct = struct::get( "armory_button", "targetname" );
        objectives::goto( objective_name, loc.origin, undefined, 0 );
    }
    
    level flag::wait_till( "flag_poi_armory_open" );
    loc = struct::get( "spare_card", "targetname" );
    objectives::goto( objective_name, loc.origin, undefined, 0 );
    objectives_ui::function_49dec5b( objective_name, undefined, #"hash_649578d6e61c5747" );
    level flag::wait_till( "flag_got_spare_card" );
    loc = struct::get( "struct_computer_hack", "targetname" );
    objectives::update_position( objective_name, loc.origin );
    level flag::wait_till( "flag_hacked_done" );
    objectives::remove( objective_name );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x7553472, Offset: 0x1d738
// Size: 0xf4
function function_9202e546()
{
    objective_name = "key_reprogram";
    var_d02e0a4b = struct::get_array( "cigar", "targetname" );
    
    for ( i = 0; i < var_d02e0a4b.size ; i++ )
    {
        var_d3d9d3b = objective_name + "_" + string( i );
        objectives::goto( var_d3d9d3b, var_d02e0a4b[ i ].origin, undefined, 0 );
        objectives_ui::function_49dec5b( var_d3d9d3b, undefined, #"hash_4b89c25b2524b4d2" );
        objectives::function_6a5ca7ac( var_d3d9d3b, undefined, objective_name );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x80f724d1, Offset: 0x1d838
// Size: 0x4
function function_1e1716d5()
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x983f3de6, Offset: 0x1d848
// Size: 0x104
function function_a79c8909( *var_d3440450 )
{
    level thread scene::init( "scene_kgb_poison_tea" );
    level thread scene::init( "scene_kgb_elevator_holdup" );
    level thread scene::init( "scene_kgb_walkup_adler" );
    level.checkpoint_clip = getent( "checkpoint_clip", "targetname" );
    level.checkpoint_clip notsolid();
    level.checkpoint_clip_right = getent( "checkpoint_clip_right", "targetname" );
    level.checkpoint_clip_right notsolid();
    level thread namespace_99e99ffa::function_1d90bc4a();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 2
// Checksum 0x7feec9c7, Offset: 0x1d958
// Size: 0xcc
function function_79e00661( var_d3440450, var_50cc0d4f )
{
    if ( is_true( var_50cc0d4f ) )
    {
        level function_52f0fcb3();
        level function_84d00884();
        level thread namespace_99e99ffa::function_99e99ffa( var_d3440450 );
        level thread namespace_e77bf565::function_ada6d016();
    }
    
    level.var_1b4de43 = [];
    level function_b797bde9();
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 4
// Checksum 0x9a48cf8e, Offset: 0x1da30
// Size: 0x24
function function_b791ea12( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x65fca894, Offset: 0x1da60
// Size: 0x4a4
function function_b797bde9()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    level scene::init( "scene_kgb_camera_shutdown" );
    var_288bb012 = struct::get( "tutorial_button", "targetname" );
    tag = spawn( "script_model", var_288bb012.origin );
    tag setmodel( "tag_origin" );
    level.var_6d758088 = getentarray( "mental_map_poi", "targetname" );
    level thread function_9368d359();
    level thread function_aa7cd2d6();
    level thread function_6cbe4283();
    level flag::wait_till( "flag_show_itinerary" );
    player thread dialogue::function_96171f6d( "vox_cp_rkgb_01505_blkv_imbeingwatchedi_f3" );
    level thread namespace_353d803e::function_5f16d3f3();
    level thread namespace_353d803e::function_fe19f3c9();
    level flag::wait_till( "flag_tutorial_map_complete" );
    level thread savegame::checkpoint_save();
    doors::function_f5dd4f8f( "camera_room", "targetname" );
    doors::function_f5dd4f8f( "disable_camera_door", "targetname" );
    doors::function_f5dd4f8f( "camera_shutdown_door", "targetname" );
    level flag::wait_till( "player_in_restricted_maintenance_area" );
    setdvar( #"hash_a794df2c802865c", 300 );
    doors::close( "camera_room", "targetname" );
    doors::function_f35467ac( "disable_camera_door", "targetname" );
    doors::function_f35467ac( "camera_room", "targetname" );
    function_5536d46d();
    level flag::set( "flag_tutorial_2" );
    function_3035c80d();
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_37d2ed210df2f4d0", 32, undefined, undefined, undefined, 128, undefined, 0, 0 );
    tag waittill( #"trigger" );
    objectives::complete( "kgb_tutorial" );
    thread namespace_353d803e::function_ac0aa1e6();
    level notify( #"hash_1c1549a38fffb2f4" );
    level scene::play( "scene_kgb_camera_shutdown", "Shutdown" );
    level flag::set( "flag_poi_camera_done" );
    level flag::set( "disable_all_cameras" );
    namespace_353d803e::music( "4.3_tension_stingers" );
    level thread function_7f81c6e4();
    wait 4;
    level thread function_da84b47c();
    setdvar( #"hash_a794df2c802865c", 650 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x4cc4ab95, Offset: 0x1df10
// Size: 0x14c
function function_3035c80d()
{
    if ( level flag::get( "flag_camera_guy_dead" ) )
    {
        return;
    }
    
    objectives::hide( #"kgb_tutorial" );
    objectives::function_4eb5c04a( #"hash_2e1eda22f13a70ad", level.var_2f572cd9.origin + ( 0, 0, 48 ), undefined, undefined );
    objectives_ui::function_49dec5b( #"hash_2e1eda22f13a70ad", undefined, #"hash_7c372ef896016d27" );
    level flag::wait_till( "flag_camera_guy_dead" );
    objectives::complete( #"hash_2e1eda22f13a70ad" );
    level waittill( #"hash_7158dbd72a2043b0", #"hash_2e50440663441b0a" );
    objectives::show( #"kgb_tutorial" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xfec68c78, Offset: 0x1e068
// Size: 0xac
function function_3fe94b24()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    player endon( #"disconnect" );
    level endon( #"hash_5ff0398a6024007a" );
    level flag::wait_till( "flag_camera_guy_dead" );
    
    if ( isdefined( player ) )
    {
        player thread dialogue::function_96171f6d( "vox_cp_rkgb_01650_blkv_ishouldhidethis_86" );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x44ec9e4e, Offset: 0x1e120
// Size: 0x74
function function_a8f549f8()
{
    level flag::wait_till( "level_is_go" );
    doors::function_f35467ac();
    namespace_353d803e::function_f3d767c7();
    level flag::wait_till( "flag_start_finding_ways" );
    doors::function_f5dd4f8f();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xd94366eb, Offset: 0x1e1a0
// Size: 0x4c
function function_9368d359()
{
    level.var_2f572cd9 = spawner::simple_spawn_single( "tutorial_guy", &function_5b0a20a7 );
    level thread function_3fe94b24();
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xee463ef4, Offset: 0x1e1f8
// Size: 0x316
function function_5b0a20a7()
{
    player = getplayers()[ 0 ];
    self.dontdropweapon = 1;
    self.holdfire = 1;
    self.ignoreme = 1;
    self.ignoreall = 1;
    self endon( #"death" );
    
    if ( !isdefined( level.player_in_restricted_area ) )
    {
        self.var_6eed8aea = 0;
        self.threatsight = 0;
    }
    
    self.propername = function_70594daa();
    self.var_c681e4c1 = 1;
    self thread function_7d7d8fd0();
    self thread function_46b46212();
    self thread function_d76e3cea();
    level thread scene::play( "scene_kgb_tutorial_camera_guard", "Forward_Loop" );
    level flag::wait_till( "flag_tutorial_2" );
    self.var_c681e4c1 = 0;
    self.var_a08ba405 = getent( "tutorial_chair", "targetname" );
    self.ignoreme = 0;
    self.ignoreall = 0;
    self thread function_90ba5cf6();
    level endon( #"stealth_spotted" );
    
    while ( isalive( self ) )
    {
        if ( level flag::get( "player_in_restricted_maintenance_area" ) && isalive( self ) )
        {
            if ( isdefined( self ) && isalive( self ) )
            {
                level scene::play( "scene_kgb_tutorial_camera_guard", "Watch" );
                level thread scene::play( "scene_kgb_tutorial_camera_guard", "Watch_Loop" );
            }
            
            level flag::wait_till_clear_any( [ "player_in_restricted_maintenance_area" ] );
            
            if ( isdefined( self ) && isalive( self ) )
            {
                level scene::play( "scene_kgb_tutorial_camera_guard", "Unalert" );
                level thread scene::play( "scene_kgb_tutorial_camera_guard", "Forward_Loop" );
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xe519869f, Offset: 0x1e518
// Size: 0x5c
function function_90ba5cf6()
{
    self endon( #"death" );
    level flag::wait_till( "stealth_spotted" );
    level thread scene::play( "scene_kgb_tutorial_camera_guard", "Alerted" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x8d6210d6, Offset: 0x1e580
// Size: 0x34
function function_46b46212()
{
    self waittill( #"death" );
    level flag::set( "flag_camera_guy_dead" );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x5f3170b0, Offset: 0x1e5c0
// Size: 0xdc
function function_d76e3cea()
{
    chair = getent( "tutorial_chair", "targetname" );
    struct = struct::get( "camera_chair_struct", "targetname" );
    chair notsolid();
    self waittill( #"death", #"takedown_begin", #"hash_6ad935dd4ed0e19d" );
    level scene::stop( "scene_kgb_tutorial_camera_guard" );
    chair moveto( struct.origin, 1 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0x4ea255cf, Offset: 0x1e6a8
// Size: 0x1cc
function function_5536d46d()
{
    player = getplayers()[ 0 ];
    player freezecontrols( 1 );
    hint_tutorial::function_4c2d4fc4( #"hash_7538688156dd5b8b", #"hash_7f4b0f582eadb7c", 1, #"hash_7d0ad4e924d219af" );
    player notifyonplayercommandremove( "show_itin", "+actionslot 4" );
    player notifyonplayercommand( "exit", "+stance" );
    player notifyonplayercommand( "exit", "+activate" );
    player waittill( #"exit" );
    level notify( #"hash_5f12484bb8ff1fdf" );
    hint_tutorial::function_9f427d88( 0 );
    player notifyonplayercommandremove( "exit", "+stance" );
    player notifyonplayercommandremove( "exit", "+activate" );
    player notifyonplayercommand( "show_itin", "+actionslot 4" );
    player freezecontrols( 0 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0xb59e7b5a, Offset: 0x1e880
// Size: 0x1c4
function function_eab15e43( *prompt_struct )
{
    if ( level flag::get( "flag_tutorial_map_complete" ) )
    {
        return;
    }
    
    level flag::set( "flag_tutorial_map_complete" );
    namespace_c8e236da::addprompt( #"hash_3895e110abdb2bea" );
    spot = struct::get( "tutorial_goal", "targetname" );
    objectives::function_4eb5c04a( #"kgb_tutorial", spot.origin );
    objectives_ui::function_49dec5b( #"kgb_tutorial", undefined, #"hash_37d2ed210df2f4d0" );
    spot interactive_map::add_object( #"camera", level.var_5fc836e5, 0, undefined );
    hotspots = getentarray( "mental_map_poi", "targetname" );
    interactive_map::function_b2ece0a3();
    
    for ( i = 0; i < hotspots.size ; i++ )
    {
        hotspots[ i ] interactive_map::function_4b1a5235( #"confirm" );
    }
    
    interactive_map::function_59b2a130( hotspots );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xc854bcbc, Offset: 0x1ea50
// Size: 0x18c
function function_da84b47c()
{
    level flag::set( "flag_start_finding_ways" );
    level thread function_3b309153();
    wait 0.5;
    doors::function_f5dd4f8f( "camera_room", "targetname" );
    player = getplayers()[ 0 ];
    player freezecontrols( 1 );
    hint_tutorial::function_4c2d4fc4( #"hash_5e8c24c2263361fc", #"hash_25fcf94c023c66fd", 2, #"hash_70f26bb1ab701ef8" );
    hint_tutorial::function_df08d48( 10 );
    level flag::wait_till( "flag_show_itinerary" );
    level thread dialogue::function_96171f6d( "vox_cp_rkgb_01570_blkv_nowthatcharkovh_cd" );
    hint_tutorial::function_9f427d88( 0 );
    level flag::wait_till_clear( "flag_show_itinerary" );
    player freezecontrols( 0 );
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 0
// Checksum 0xea5e5f77, Offset: 0x1ebe8
// Size: 0xa2
function function_8629b5cf()
{
    self endon( #"death" );
    self endon( #"takedown_begin" );
    player = getplayers()[ 0 ];
    
    while ( true )
    {
        if ( player.stealth.maxthreat > 0.25 )
        {
            self notify( #"hash_6ad935dd4ed0e19d" );
            self stopanimscripted();
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_prepare/namespace_bd1b12dd
// Params 1
// Checksum 0x48db9cbc, Offset: 0x1ec98
// Size: 0x5c
function function_4a1580b6( a_ents )
{
    radio = a_ents[ #"prop 1" ];
    
    if ( !isdefined( radio ) )
    {
        return;
    }
    
    radio endon( #"delete" );
    radio physicslaunch();
}

