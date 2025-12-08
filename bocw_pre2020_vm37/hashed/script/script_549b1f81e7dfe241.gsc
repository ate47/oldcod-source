#using script_20b8e1a789215df0;
#using script_3b7c3b99b28b21b7;
#using script_3c70d86dfe255354;
#using script_3dc93ca9902a9cda;
#using script_4b6505921addc7bc;
#using script_708fc8496e63a128;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace namespace_afd0968c;

// Namespace namespace_afd0968c/namespace_afd0968c
// Params 0
// Checksum 0x36a6be62, Offset: 0x528
// Size: 0x34
function function_22b7fffd()
{
    scene::add_scene_func( "scene_z_stk_electronics_store", &function_9df174aa, "init" );
}

// Namespace namespace_afd0968c/namespace_afd0968c
// Params 1
// Checksum 0x10b4726c, Offset: 0x568
// Size: 0x124
function start( *str_objective )
{
    player = getplayers()[ 0 ];
    player namespace_979752dc::set_disguised( 1 );
    level thread namespace_fba81a7f::function_37acd633();
    util::function_268bdf4f( "lazar", &namespace_11998b8f::function_2f0f0a84 );
    level.lazar val::set( "meetup", "ignoreme", 1 );
    level.lazar val::set( "meetup", "ignoreall", 1 );
    level scene::init( "scene_z_stk_electronics_store" );
    level thread namespace_11998b8f::function_de88eefd();
}

// Namespace namespace_afd0968c/namespace_afd0968c
// Params 2
// Checksum 0xb002489c, Offset: 0x698
// Size: 0x554
function main( str_objective, var_50cc0d4f )
{
    player = getplayers()[ 0 ];
    
    if ( var_50cc0d4f )
    {
        level thread namespace_11998b8f::function_cdb7cc7e();
        player spy_camera::function_6de171e9();
    }
    
    if ( level flag::get( "flag_go_in_store" ) )
    {
        level scene::play( "scene_z_stk_electronics_store", "rr_door_lazar_branch" );
    }
    else
    {
        level scene::play( "scene_z_stk_electronics_store", "rr_ext" );
        level thread scene::play( "scene_z_stk_electronics_store", "rr_wait_loop" );
        level flag::wait_till( "flag_go_in_store" );
        level scene::play( "scene_z_stk_electronics_store", "repair_room_enter" );
    }
    
    level thread namespace_11998b8f::function_973a721b( "alley_3_car" );
    level flag::set( "flag_show_vista_tower_03" );
    level thread function_8d76ed51();
    level thread namespace_fba81a7f::function_37acd633();
    level thread namespace_fba81a7f::function_47620ece();
    doors::lock( "door_electronics_store" );
    level scene::play( "scene_z_stk_electronics_store", "lazar_traversal" );
    
    if ( level flag::get( "flag_meetup_park" ) )
    {
        level scene::play( "scene_z_stk_electronics_store", "call_listen_branch" );
    }
    else
    {
        level scene::play( "scene_z_stk_electronics_store", "shop_wait_intro" );
        level thread scene::play( "scene_z_stk_electronics_store", "shop_wait_loop" );
        level flag::wait_till( "flag_meetup_park" );
        level scene::play( "scene_z_stk_electronics_store", "shop_wait_exit" );
    }
    
    level thread function_6b2b504d();
    level thread function_36a9bec7();
    level thread util::delay( 6, undefined, &namespace_11998b8f::function_973a721b, "meetup_car" );
    level thread scene::play( "scene_z_stk_electronics_store", "call_listen_intro" );
    level flag::set( "stop_supressed_hint" );
    
    if ( player getcurrentweapon() == level.var_e3f5eafc )
    {
        level.var_e3f5eafc.var_f91a82ef = 0;
        
        if ( isdefined( player.var_d069ac67 ) )
        {
            player.var_d069ac67 = getweapon( #"hash_5dbab0bd6a78c6e5" );
        }
        
        if ( isdefined( player.var_2e4ec491 ) )
        {
            player.var_2e4ec491 = undefined;
            player.var_2e4ec491[ 0 ] = getweapon( #"hash_5dbab0bd6a78c6e5" );
        }
    }
    else
    {
        player takeallweapons();
        var_bd1c473f = getweapon( #"hash_5dbab0bd6a78c6e5" );
        player giveweapon( var_bd1c473f );
    }
    
    level flag::wait_till( "meetup_done" );
    level thread namespace_11998b8f::stakeout_stow_weapon();
    player spy_camera::function_b83af2a9();
    level thread namespace_11998b8f::function_25120710();
    level thread scene::play( "scene_z_stk_electronics_store", "end_loops" );
    skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_afd0968c/namespace_afd0968c
// Params 1
// Checksum 0xa2e0a66b, Offset: 0xbf8
// Size: 0x28
function function_9df174aa( a_ents )
{
    level.park = a_ents[ #"park" ];
}

// Namespace namespace_afd0968c/namespace_afd0968c
// Params 0
// Checksum 0x99548557, Offset: 0xc28
// Size: 0x19c
function function_8d76ed51()
{
    level namespace_e6b6aea1::function_3141d875();
    level thread scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_surveillance_stove_smoking_edda_transition", level.var_3559e9e );
    kitchen_window_right_closed = getent( "kitchen_window_right_closed", "targetname" );
    kitchen_window_right_closed hide();
    kitchen_window_left_closed = getent( "kitchen_window_left_closed", "targetname" );
    kitchen_window_left_closed hide();
    level flag::wait_till( "flag_meetup_park" );
    level thread scene::play( "aib_vign_stakeout_safehouse_surveillance_kraus", "kraus_phone_start", level.var_49a292bb );
    level flag::wait_till( "flag_meetup_kraus_done" );
    level scene::play( "aib_vign_stakeout_safehouse_surveillance_kraus", "kraus_desk_exit", level.var_49a292bb );
    level.var_49a292bb animation::last_frame( #"z_stk_surveillance_desk_kraus_exit", level.var_bd5c9b86 );
}

// Namespace namespace_afd0968c/namespace_afd0968c
// Params 4
// Checksum 0xa6df59c0, Offset: 0xdd0
// Size: 0x8c
function function_7451d8da( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player )
    {
        level flag::set( "flag_meetup_park" );
        level flag::set( "flag_show_vista_tower_03" );
        level flag::set( "stop_supressed_hint" );
    }
}

// Namespace namespace_afd0968c/namespace_afd0968c
// Params 0
// Checksum 0xafff3958, Offset: 0xe68
// Size: 0x6c
function function_6b2b504d()
{
    level waittill( #"hash_7fc364091853e016" );
    level.lazar util::dialog_gender_vo( "vox_cp_stkt_09100_lazr_whilehesdoingth_e2", "vox_cp_stkt_09100_lazr_whileshesdoingt_55", "vox_cp_stkt_09100_lazr_whilebellsdoing_94" );
    level flag::set( "give_meetup_obj" );
}

// Namespace namespace_afd0968c/namespace_afd0968c
// Params 1
// Checksum 0xe618e2a, Offset: 0xee0
// Size: 0x194
function function_36a9bec7( var_50cc0d4f )
{
    if ( !is_true( var_50cc0d4f ) )
    {
        level flag::wait_till( "give_meetup_obj" );
        doors::unlock( "door_electronics_store", undefined, 0 );
    }
    
    var_b6ac0499 = struct::get( "obj_entry_lobby", "targetname" );
    objectives::scripted( "obj_enter_apt", undefined, #"hash_133aa27126e740cc" );
    
    if ( !level flag::get( "apt_street_lobby_entry" ) )
    {
        objectives::goto( "obj_enter_lobby", var_b6ac0499.origin, undefined, 0 );
        objectives::function_67f87f80( "obj_enter_lobby", undefined, #"hash_5f670550d4e97f41" );
        level flag::wait_till( "apt_street_lobby_entry" );
        objectives::complete( "obj_enter_lobby" );
    }
    
    level flag::wait_till( "apt_street_done" );
    objectives::complete( "obj_enter_apt" );
}

