#using script_20b8e1a789215df0;
#using script_3919f386abede84;
#using script_3c70d86dfe255354;
#using script_4b6505921addc7bc;
#using script_549b1f81e7dfe241;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_fba81a7f;

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 1
// Checksum 0x591633c4, Offset: 0x678
// Size: 0xbc
function start( *str_objective )
{
    level flag::set( "informant_released" );
    level namespace_e6b6aea1::function_3141d875();
    level thread function_6b5a40ef();
    level thread function_37acd633();
    level thread function_47620ece();
    level thread namespace_11998b8f::stakeout_stow_weapon();
    level thread namespace_11998b8f::function_25120710();
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 2
// Checksum 0x99498bac, Offset: 0x740
// Size: 0x424
function main( str_objective, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        util::function_268bdf4f( "lazar", &namespace_11998b8f::function_2f0f0a84 );
        level.lazar val::set( "meetup", "ignoreme", 1 );
        level.lazar val::set( "meetup", "ignoreall", 1 );
        level thread scene::play( "scene_z_stk_electronics_store", "end_loops" );
        level thread namespace_afd0968c::function_36a9bec7( var_50cc0d4f );
    }
    
    if ( !isdefined( level.var_38f30672 ) )
    {
        level.var_38f30672 = struct::get( "tag_align_lobby_hall", "targetname" );
    }
    
    if ( !isdefined( level.var_54b83d35 ) )
    {
        level.var_54b83d35 = struct::get( "tag_align_target_apt_first_floor", "targetname" );
    }
    
    level thread namespace_3e1df757::function_fabce54();
    level thread function_4cb44581();
    level thread function_26abb5e9();
    level thread namespace_11998b8f::function_973a721b( "apt_street_car", "apt_street_done" );
    level thread namespace_11998b8f::function_973a721b( "apt_street_vista_car", "apt_street_done" );
    level thread function_7b1998a8();
    level thread namespace_e6b6aea1::function_fb12384e();
    level thread function_e05e8838();
    windows::lock( "apt_bedroom_window", "script_noteworthy" );
    level thread namespace_c80e7f5f::function_28def7d4();
    level thread namespace_c80e7f5f::function_a1d5baeb();
    level thread namespace_c80e7f5f::function_a9c3a1f0();
    level thread function_468b938d();
    level flag::wait_till( "start_apt_street_train" );
    level thread function_3dfe810();
    level flag::wait_till( "flag_dart_gun_ready" );
    player = getplayers()[ 0 ];
    player takeallweapons();
    level namespace_11998b8f::function_a73e6a64();
    waitframe( 1 );
    player thread namespace_11998b8f::function_d30792f2();
    level flag::wait_till( "apt_street_done" );
    skipto::function_4e3ab877( str_objective );
    level flag::wait_till( "flag_close_front_door" );
    util::unmake_hero( "lazar", 1 );
    util::unmake_hero( "park", 1 );
    level thread function_720adc4e();
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xa2053b78, Offset: 0xb70
// Size: 0xe4
function function_720adc4e()
{
    if ( isdefined( level.lobby_mail_woman ) )
    {
        level.lobby_mail_woman delete();
    }
    
    triggers = getentarray( "apt_street_triggers", "targetname" );
    array::delete_all( triggers );
    level scene::stop( "scene_z_stk_electronics_store" );
    waitframe( 1 );
    
    if ( isdefined( level.lazar ) )
    {
        level.lazar delete();
    }
    
    if ( isdefined( level.park ) )
    {
        level.park delete();
    }
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x12d95d43, Offset: 0xc60
// Size: 0xec
function function_26abb5e9()
{
    player = getplayers()[ 0 ];
    
    if ( !isdefined( level.stealth.disguised ) )
    {
        player namespace_979752dc::set_disguised( 1 );
    }
    
    player.takedown.disabled = 1;
    level flag::wait_till( "apt_street_done" );
    player.takedown.disabled = 0;
    player util::blend_movespeedscale( 0.5, 0.5 );
    player val::set( "apartment", "allow_sprint", 0 );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xb8eff2e9, Offset: 0xd58
// Size: 0xb0
function function_37acd633()
{
    level endon( #"apt_street_done" );
    
    while ( !level flag::get( "apt_street_done" ) )
    {
        level flag::wait_till( "stealth_spotted" );
        wait 3;
        
        if ( level flag::get( "stealth_spotted" ) )
        {
            util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_18b8caabd523d66b" );
        }
    }
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x8b3ad7e9, Offset: 0xe10
// Size: 0x64
function function_742bc3ab()
{
    spawner::add_spawn_function_group( "apt_street_police", "targetname", &function_e7549abc );
    spawner::add_spawn_function_group( "apt_street_police", "targetname", &function_26a2480e );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x10c7604c, Offset: 0xe80
// Size: 0x12
function function_e7549abc()
{
    self.var_c681e4c1 = 1;
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x9c1fecd4, Offset: 0xea0
// Size: 0x318
function function_47620ece()
{
    level.apt_street_police = spawner::simple_spawn( "apt_street_police" );
    level thread namespace_11998b8f::function_91a7f501( "apt_street_ambient_harass_loop", "apartment_2_done" );
    level.lobby_mail_woman = spawner::simple_spawn_single( "lobby_mail_woman", &lobby_mail_woman );
    ai_array = getaiteamarray( "axis" );
    
    foreach ( guy in ai_array )
    {
        guy val::set( "electronics_store", "ignoreall", 1 );
    }
    
    level flag::wait_till( "apt_street_first_guard_move" );
    scene::add_scene_func( "aib_vign_stakeout_harass_ask_questions", &function_79b92b87, "play" );
    level thread namespace_11998b8f::function_91a7f501( "apt_street_lobby_ambient_harass_loop", "flag_close_front_door" );
    level thread intro_civs();
    ai_array = getaiteamarray( "axis" );
    
    foreach ( guy in ai_array )
    {
        guy val::set( "electronics_store", "ignoreall", 1 );
    }
    
    level waittill( #"dart_gun_enabled" );
    ai_array = getaiteamarray( "axis" );
    
    foreach ( guy in ai_array )
    {
        guy val::reset( "electronics_store", "ignoreall" );
    }
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xe499152a, Offset: 0x11c0
// Size: 0x134
function function_6b5a40ef()
{
    while ( !isdefined( level.var_3559e9e ) )
    {
        waitframe( 1 );
    }
    
    level thread scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_surveillance_stove_smoking_edda_transition", level.var_3559e9e );
    kitchen_window_right_closed = getent( "kitchen_window_right_closed", "targetname" );
    kitchen_window_right_closed hide();
    kitchen_window_left_closed = getent( "kitchen_window_left_closed", "targetname" );
    kitchen_window_left_closed hide();
    
    while ( !isdefined( level.var_49a292bb ) )
    {
        waitframe( 1 );
    }
    
    level.var_bd5c9b86 = struct::get( "tag_align_target_apt_second_floor", "targetname" );
    level.var_49a292bb animation::last_frame( "z_stk_surveillance_desk_kraus_exit", level.var_bd5c9b86 );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x8391f403, Offset: 0x1300
// Size: 0x7c
function intro_civs()
{
    animnode = struct::get( "scared_civs_animnode", "targetname" );
    civs = spawner::simple_spawn( "apt_street_intro_civs", &function_34770465 );
    animnode scene::play( "aib_vign_stakeout_apt_street_hustle_across", civs );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xa635d84f, Offset: 0x1388
// Size: 0x4c
function function_34770465()
{
    self endon( #"death" );
    self.goalradius = 16;
    self waittill( #"goal" );
    self deletedelay();
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 1
// Checksum 0x420ac85e, Offset: 0x13e0
// Size: 0x7c
function function_d5cab286( a_ents )
{
    mailbox = a_ents[ #"hash_475ee55621b83ca0" ];
    var_e864861d = getent( "apt_mailbox_door", "targetname" );
    var_e864861d linkto( mailbox, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x4debdbe5, Offset: 0x1468
// Size: 0x114
function lobby_mail_woman()
{
    self val::set( "apt_street", "ignoreall", 1 );
    self val::set( "apt_street", "ignoreme", 1 );
    self.var_66f1a336 = &function_8266a99e;
    self setmodel( "body_civ_f_ger_berlin_05" );
    scene::add_scene_func( "aib_vign_stakeout_safehouse_mail_woman", &function_d5cab286, "init" );
    level scene::init( "aib_vign_stakeout_safehouse_mail_woman", self );
    level flag::wait_till( "apt_street_lobby_entry" );
    level thread scene::play( "aib_vign_stakeout_safehouse_mail_woman", self );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x8c3ddd85, Offset: 0x1588
// Size: 0x5c
function function_8266a99e()
{
    if ( isdefined( self ) )
    {
        self dialogue::function_47b06180();
    }
    
    wait 2;
    util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_b4302157d22e1af" );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xb2af555b, Offset: 0x15f0
// Size: 0x5c
function function_29c32c17()
{
    if ( isdefined( self ) )
    {
        self dialogue::function_47b06180();
    }
    
    wait 2;
    util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_4e9d4bf1d65f17f5" );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xa9c0e29c, Offset: 0x1658
// Size: 0x8c
function function_5aa8f217()
{
    level endon( #"flag_close_front_door" );
    self waittill( #"stealth_combat", #"stealth_investigate", #"set_alert_level" );
    wait 2;
    util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_4039ceec8d9c7c5e" );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 1
// Checksum 0xc718d4db, Offset: 0x16f0
// Size: 0xfe
function function_79b92b87( a_ents )
{
    foreach ( guy in a_ents )
    {
        if ( isai( guy ) )
        {
            if ( isdefined( guy.animname ) )
            {
                if ( issubstr( guy.animname, "guard" ) )
                {
                    guy.var_66f1a336 = &function_29c32c17;
                    guy thread function_5aa8f217();
                    continue;
                }
                
                guy.var_66f1a336 = &function_8266a99e;
            }
        }
    }
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xc14427ce, Offset: 0x17f8
// Size: 0x114
function function_7b1998a8()
{
    doors::waittill_door_opened( "tgt_apt_lobby_door" );
    level notify( #"lobby_door_opened" );
    level flag::wait_till( "flag_inside_lobby" );
    doors::lock( "tgt_apt_lobby_door" );
    var_b6ac0499 = struct::get( "obj_entry_apartment", "targetname" );
    objectives::goto( "obj_enter_apt", var_b6ac0499.origin, undefined, 0 );
    objectives::function_67f87f80( "obj_enter_apt", undefined, #"hash_5f670550d4e97f41" );
    level flag::wait_till( "apt_street_done" );
    objectives::complete( "obj_enter_apt" );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x3def721e, Offset: 0x1918
// Size: 0x44
function function_e05e8838()
{
    doors::waittill_door_opened( "tgt_apt_front_door" );
    wait 1.85;
    level flag::set( "apt_street_done" );
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xfb9cb876, Offset: 0x1968
// Size: 0x198
function function_3dfe810()
{
    level endon( #"apartment_2_done" );
    level scene::init( "apt_street_train_01", "targetname" );
    level scene::init( "apt_street_train_02", "targetname" );
    level scene::play_from_time( "apt_street_train_01", "targetname", undefined, 8, 0 );
    
    while ( true )
    {
        wait randomintrange( 35, 55 );
        trains = randomint( 3 );
        
        if ( trains == 0 )
        {
            level scene::play( "apt_street_train_01", "targetname" );
            continue;
        }
        
        if ( trains == 1 )
        {
            level scene::play( "apt_street_train_02", "targetname" );
            continue;
        }
        
        level thread scene::play( "apt_street_train_02", "targetname" );
        wait 2;
        level scene::play( "apt_street_train_01", "targetname" );
    }
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x5fb829fa, Offset: 0x1b08
// Size: 0x44
function function_468b938d()
{
    level endon( #"apt_street_done" );
    level flag::wait_till( "flag_inside_lobby" );
    savegame::checkpoint_save();
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0x8c849117, Offset: 0x1b58
// Size: 0x4c
function function_26a2480e()
{
    self endon( #"death" );
    level flag::wait_till( "apartment_2_done" );
    self deletedelay();
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 4
// Checksum 0x95950029, Offset: 0x1bb0
// Size: 0x8c
function function_f62cf54d( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player )
    {
        level flag::set( "flag_dart_gun_ready" );
        level flag::set( "apt_street_done" );
        level flag::set( "apt_street_lobby_entry" );
    }
}

// Namespace namespace_fba81a7f/namespace_fba81a7f
// Params 0
// Checksum 0xa38a48bd, Offset: 0x1c48
// Size: 0x2e
function function_4cb44581()
{
    var_f7ee01ca = struct::get( "temp_audio_stairwell_walla", "targetname" );
}

