#using script_1fd2c6e5fc8cb1c3;
#using script_3dc93ca9902a9cda;
#using script_44aef2868ad2e317;
#using script_4ec222619bffcfd1;
#using script_779f525443585713;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\ui\object_descriptions;
#using scripts\cp_common\util;

#namespace kgb_ins_briefing;

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 1
// Checksum 0xff582983, Offset: 0x500
// Size: 0x11c
function starting( *var_d3440450 )
{
    level thread scene::init( "scene_kgb_elevator_holdup" );
    level thread scene::init( "scene_kgb_walkup_adler" );
    level thread scene::init( "scene_kgb_poison_tea" );
    battlechatter::function_2ab9360b( 0 );
    level.checkpoint_clip = getent( "checkpoint_clip", "targetname" );
    level.checkpoint_clip notsolid();
    level.checkpoint_clip_right = getent( "checkpoint_clip_right", "targetname" );
    level.checkpoint_clip_right notsolid();
    level thread namespace_99e99ffa::function_1d90bc4a();
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 2
// Checksum 0x28d41c31, Offset: 0x628
// Size: 0x15c
function main( var_d3440450, var_50cc0d4f )
{
    level scene::add_scene_func( "scene_kgb_briefing", &function_20ecf97d );
    level scene::init( "scene_kgb_briefing" );
    level thread function_e526d368();
    level thread function_eca40f86();
    doors::function_f35467ac();
    namespace_353d803e::function_fef24c06();
    
    if ( is_true( var_50cc0d4f ) )
    {
        kgb_ins_prepare::function_52f0fcb3();
        kgb_ins_prepare::function_84d00884();
        level thread namespace_99e99ffa::function_99e99ffa( var_d3440450 );
        level thread namespace_e77bf565::function_ada6d016();
    }
    
    level flag::wait_till( "ins_briefing_complete" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 4
// Checksum 0x1b603044, Offset: 0x790
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0x5941f580, Offset: 0x7c0
// Size: 0xe4
function init_flags()
{
    level flag::init( "ins_briefing_complete" );
    level flag::init( "player_in_briefing_room" );
    level flag::init( "flag_briefing_choice_1" );
    level flag::init( "flag_briefing_choice_2" );
    level flag::init( "flag_briefing_choice_3" );
    level flag::init( "flag_player_outside_briefing" );
    level flag::init( "flag_briefing_started" );
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0x80f724d1, Offset: 0x8b0
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0x80f724d1, Offset: 0x8c0
// Size: 0x4
function function_22b7fffd()
{
    
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0xbc376a7f, Offset: 0x8d0
// Size: 0x124
function function_eca40f86()
{
    location = struct::get( "briefing_entrance", "targetname" );
    objectives::function_4eb5c04a( "obj_briefing", location.origin + ( 0, 0, 16 ), #"hash_396fd012409151c7" );
    level flag::wait_till( "flag_briefing_doorman" );
    wait 5;
    location = struct::get( "briefing_use_prompt", "targetname" );
    objectives::update_position( "obj_briefing", location.origin + ( 0, 0, 16 ) );
    level flag::wait_till( "flag_briefing_started" );
    objectives::complete( "obj_briefing" );
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0xa2c08f69, Offset: 0xa00
// Size: 0x704
function function_e526d368()
{
    player = getplayers()[ 0 ];
    briefing_clip = getent( "briefing_clip", "targetname" );
    briefing_clip notsolid();
    spot = struct::get( "briefing_use_prompt", "targetname" );
    level scene::init( "scene_kgb_briefing" );
    player thread objectives_ui::show_objectives();
    level thread scene::play( "scene_kgb_briefing", "Enter_Loop" );
    level thread function_823fd8b5();
    level flag::wait_till( "player_in_briefing_room" );
    level notify( #"hash_43fb421b5c84be9d" );
    level dialogue::function_3db52a33();
    level scene::play( "scene_kgb_briefing", "Enter_Start" );
    level thread scene::play( "scene_kgb_briefing", "Enter_Wait" );
    namespace_353d803e::function_d0a16654();
    tag = spawn( "script_model", spot.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_2700aa498f22c978" );
    tag waittill( #"trigger" );
    tag delete();
    namespace_353d803e::function_3106c0e1();
    level flag::set( "flag_briefing_started" );
    snd::client_msg( #"hash_39ef84876415aee7" );
    level scene::play( "scene_kgb_briefing", "Dialogue_Start" );
    level thread function_8007a343();
    level thread scene::play( "scene_kgb_briefing", "Dialogue_Choice" );
    level flag::wait_till_any( [ "flag_briefing_choice_1", "flag_briefing_choice_2", "flag_briefing_choice_3" ] );
    
    if ( level flag::get( "flag_briefing_choice_1" ) )
    {
        level scene::play( "scene_kgb_briefing", "Response1" );
    }
    
    if ( level flag::get( "flag_briefing_choice_2" ) )
    {
        level scene::play( "scene_kgb_briefing", "Response2" );
    }
    
    if ( level flag::get( "flag_briefing_choice_3" ) )
    {
        level scene::play( "scene_kgb_briefing", "Response3" );
    }
    
    level scene::play( "scene_kgb_briefing", "Question2" );
    level thread scene::play( "scene_kgb_briefing", "Dialogue_Choice2" );
    level thread function_e2236b33();
    level flag::wait_till_any( [ "flag_briefing_choice_4", "flag_briefing_choice_5", "flag_briefing_choice_6" ] );
    
    if ( level flag::get( "flag_briefing_choice_4" ) )
    {
        level scene::play( "scene_kgb_briefing", "Response4" );
    }
    
    if ( level flag::get( "flag_briefing_choice_5" ) )
    {
        level scene::play( "scene_kgb_briefing", "Response5" );
    }
    
    if ( level flag::get( "flag_briefing_choice_6" ) )
    {
        level scene::play( "scene_kgb_briefing", "Response6" );
    }
    
    level flag::set( "flag_doorman_open" );
    level scene::play( "scene_kgb_briefing", "Dialogue_End" );
    snd::client_msg( #"hash_43c1a41f59a490d6" );
    namespace_353d803e::music( "4.0_searching" );
    level thread scene::play( "scene_kgb_briefing", "Door_Hold" );
    level flag::wait_till( "flag_player_outside_briefing" );
    briefing_clip solid();
    level flag::set( "ins_briefing_complete" );
    level thread scene::play( "scene_kgb_briefing", "Door_Close" );
    namespace_353d803e::function_8dbac4c1();
    namespace_353d803e::function_fef24c06();
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0x4d9f0ad0, Offset: 0x1110
// Size: 0xd4
function function_8007a343()
{
    var_bddef49 = dialog_tree::new_tree( undefined, undefined, 1, 0 );
    var_bddef49 dialog_tree::add_option( #"hash_222f0df279f071e1", undefined, undefined, undefined, 1, "flag_briefing_choice_1" );
    var_bddef49 dialog_tree::add_option( #"hash_222f0af279f06cc8", undefined, undefined, undefined, 1, "flag_briefing_choice_2" );
    var_bddef49 dialog_tree::add_option( #"hash_222f0bf279f06e7b", undefined, undefined, undefined, 1, "flag_briefing_choice_3" );
    var_bddef49 dialog_tree::run();
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0x8766f5f8, Offset: 0x11f0
// Size: 0xd4
function function_e2236b33()
{
    var_bddef49 = dialog_tree::new_tree( undefined, undefined, 1, 0 );
    var_bddef49 dialog_tree::add_option( #"hash_1ae054f2762f2886", undefined, undefined, undefined, 1, "flag_briefing_choice_4" );
    var_bddef49 dialog_tree::add_option( #"hash_1ae053f2762f26d3", undefined, undefined, undefined, 1, "flag_briefing_choice_5" );
    var_bddef49 dialog_tree::add_option( #"hash_1ae052f2762f2520", undefined, undefined, undefined, 1, "flag_briefing_choice_6" );
    var_bddef49 dialog_tree::run();
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0xdaaefe3a, Offset: 0x12d0
// Size: 0x5c
function function_97cbbccf()
{
    self.ignoreme = 1;
    self.ignoreall = 1;
    gun = getweapon( #"noweapon" );
    self setweapon( gun );
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 0
// Checksum 0xc2e5def8, Offset: 0x1338
// Size: 0x244
function function_823fd8b5()
{
    while ( !isdefined( level.doorman ) )
    {
        waitframe( 1 );
    }
    
    level thread scene::play( "scene_kgb_briefing_doorman", "Start_Loop" );
    level flag::wait_till( "flag_briefing_doorman" );
    level scene::play( "scene_kgb_briefing_doorman", "Open" );
    namespace_353d803e::music( "3.0_meeting" );
    level thread scene::play( "scene_kgb_briefing_doorman", "Open_Loop" );
    level flag::wait_till( "flag_briefing_started" );
    level scene::play( "scene_kgb_briefing_doorman", "Close" );
    level flag::wait_till( "flag_doorman_open" );
    level scene::play( "scene_kgb_briefing_doorman", "Open" );
    level thread scene::play( "scene_kgb_briefing_doorman", "Open_Loop" );
    level flag::wait_till( "flag_player_outside_briefing" );
    level scene::play( "scene_kgb_briefing_doorman", "Close" );
    level scene::stop( "scene_kgb_briefing", 1 );
    level.player districts::function_930f8c81( [ "kgb_hq_conference_v2" ] );
    level thread scene::play( "scene_kgb_briefing_doorman", "Start_Loop" );
}

// Namespace kgb_ins_briefing/namespace_6ac6f208
// Params 1
// Checksum 0xd467bca4, Offset: 0x1588
// Size: 0x2b4
function function_20ecf97d( a_ents )
{
    var_1588c3c8 = a_ents[ #"hash_39b2b3e2b4b9deaa" ];
    var_1588c3c8 thread entname::add( #"hash_a566926dd89b47", #"axis" );
    var_7198a076 = a_ents[ #"hash_713540a10ff22151" ];
    var_7198a076 thread entname::add( #"hash_6a1195604c394694", #"axis" );
    kravchenko = a_ents[ #"kravchenko" ];
    kravchenko thread entname::add( #"hash_3a5989f4b42dab1e", #"axis" );
    general = a_ents[ #"hash_1b438d741661c069" ];
    general thread entname::add( #"hash_5adf117d46cc06f9", #"axis" );
    general = a_ents[ #"hash_1b438c741661beb6" ];
    general thread entname::add( #"hash_5adf127d46cc08ac", #"axis" );
    general = a_ents[ #"hash_1b438f741661c3cf" ];
    general thread entname::add( #"hash_5adf137d46cc0a5f", #"axis" );
    general = a_ents[ #"hash_1b438e741661c21c" ];
    general thread entname::add( #"hash_5adf147d46cc0c12", #"axis" );
    general = a_ents[ #"hash_1b4391741661c735" ];
    general thread entname::add( #"hash_5adf157d46cc0dc5", #"axis" );
    general = a_ents[ #"hash_1b4390741661c582" ];
    general thread entname::add( #"hash_5adf167d46cc0f78", #"axis" );
}

