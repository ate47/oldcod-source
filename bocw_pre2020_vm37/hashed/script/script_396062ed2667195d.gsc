#using script_4134e1e2e7684c4c;
#using script_44aef2868ad2e317;
#using script_4ec222619bffcfd1;
#using script_744ba1f2f99cf072;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\util;

#namespace namespace_94c47ce5;

// Namespace namespace_94c47ce5/namespace_9d0478f0
// Params 0
// Checksum 0xae03115b, Offset: 0x290
// Size: 0x27e
function function_ef6de0f0()
{
    level dialogue::function_96171f6d( "vox_cp_rkgb_01000_adlr_andonemorething_89" );
    
    /#
    #/
    
    namespace_6f1d35e1::function_487b4340( #"hash_3e13db919d477bb2" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 5, 50 );
    level waittill( #"typing_complete" );
    level dialogue::function_96171f6d( "vox_cp_rkgb_01000_adlr_heknowstoomucha_c9" );
    var_6ac302b4 = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_6ac302b4 dialog_tree::add_option( #"hash_32b4eefcf1a1af51", undefined, undefined, undefined, 1, undefined, undefined, &kgb_ins_activation::function_3d2a48a7, "vox_cp_rkgb_01000_adlr_goodmannowiknow_b0" );
    var_6ac302b4 dialog_tree::add_option( #"hash_32b4edfcf1a1ad9e", undefined, undefined, undefined, 1, undefined, undefined, &kgb_ins_activation::function_3d2a48a7, "vox_cp_rkgb_01000_adlr_understood_55" );
    var_6ac302b4 dialog_tree::add_option( #"hash_32b4ecfcf1a1abeb", undefined, undefined, undefined, 1, undefined, undefined, &kgb_ins_activation::function_3d2a48a7, "vox_cp_rkgb_01000_adlr_understood_55" );
    choice = var_6ac302b4 dialog_tree::run();
}

// Namespace namespace_94c47ce5/namespace_9d0478f0
// Params 0
// Checksum 0xed596efc, Offset: 0x518
// Size: 0x1e4
function function_9b596d4d()
{
    self endon( #"death" );
    
    if ( !function_11b2b847() )
    {
        return;
    }
    
    thread function_477a3a8();
    level.informant = spawner::simple_spawn_single( "kgb_informant_spawner", &function_429cb29f );
    objectives::goto( #"hash_76daa952e81173e7", level.informant.origin, #"hash_5da41b58c699fab8", 0 );
    struct = struct::get( "obj_informant_struct", "targetname" );
    objectives::update_position( #"hash_76daa952e81173e7", struct.origin );
    objectives_ui::function_49dec5b( #"hash_76daa952e81173e7", undefined, #"hash_7a9aa670bcff290" );
    objectives::hide( #"hash_76daa952e81173e7" );
    level.informant waittill( #"death" );
    level.var_1b4de43[ level.var_1b4de43.size ] = "informant";
    level notify( #"ping_map" );
    level flag::set( "flag_informant_killed" );
    objectives::complete( #"hash_76daa952e81173e7" );
}

// Namespace namespace_94c47ce5/namespace_9d0478f0
// Params 0
// Checksum 0x5a279ddc, Offset: 0x708
// Size: 0xd4
function function_429cb29f()
{
    self endon( #"death" );
    self thread kgb_ins_prepare::function_862e8bf9();
    level thread scene::play( "scene_kgb_office_informant", self );
    chair = getent( "informant_chair", "targetname" );
    self.var_a08ba405 = chair;
    self.var_c681e4c1 = 0;
    self.propername = #"hash_32ec1ebb26836258";
    level flag::wait_till( "flag_player_swap" );
    self delete();
}

// Namespace namespace_94c47ce5/namespace_9d0478f0
// Params 0
// Checksum 0x2438074f, Offset: 0x7e8
// Size: 0x11c
function function_477a3a8()
{
    struct = struct::get( "kgb_informant_file", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_563db985365ec0a9", undefined, undefined, &function_acea38c0, undefined, undefined, undefined, undefined, undefined, 0 );
    level flag::wait_till( "flag_player_swap" );
    tag util::remove_cursor_hint();
    tag delete();
}

// Namespace namespace_94c47ce5/namespace_9d0478f0
// Params 0
// Checksum 0x62547e86, Offset: 0x910
// Size: 0x17c
function function_acea38c0()
{
    player = getplayers()[ 0 ];
    player freezecontrols( 1 );
    hint_tutorial::function_4c2d4fc4( #"hash_ac8852205906c48", #"hash_2bcdb6fe407f47c1", undefined, #"hash_7d0ad4e924d219af" );
    player notifyonplayercommandremove( "show_itin", "+actionslot 4" );
    player notifyonplayercommand( "exit", "+stance" );
    namespace_353d803e::function_28897188();
    player waittill( #"exit" );
    hint_tutorial::function_9f427d88( 0 );
    player notifyonplayercommandremove( "exit", "+stance" );
    player notifyonplayercommand( "show_itin", "+actionslot 4" );
    player freezecontrols( 0 );
}

// Namespace namespace_94c47ce5/namespace_9d0478f0
// Params 0
// Checksum 0xdc004c6b, Offset: 0xa98
// Size: 0x74, Type: bool
function function_11b2b847()
{
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    return !player util::function_eed1baf3() || getdvarint( #"hash_54f70ad07bff8dfc", 0 );
}

