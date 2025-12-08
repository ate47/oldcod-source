#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;

#namespace namespace_4ed3ce47;

// Namespace namespace_4ed3ce47/level_preinit
// Params 1, eflags: 0x44
// Checksum 0x6894b2a0, Offset: 0x5e0
// Size: 0x3c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
    snd::wait_init();
}

// Namespace namespace_4ed3ce47/event_cc819519
// Params 1, eflags: 0x44
// Checksum 0xfa17b19d, Offset: 0x628
// Size: 0x4c
function private event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    level.var_629f8c1e = [];
    thread function_f58905f1();
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 1
// Checksum 0xbfb9b995, Offset: 0x680
// Size: 0x48
function function_5bae4a7e( alias )
{
    level.var_629f8c1e[ alias ] = snd::play( alias, ( -299.926, 134.423, 33.9824 ) );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 1
// Checksum 0x90519b46, Offset: 0x6d0
// Size: 0x54
function function_1ca6cc19( alias )
{
    if ( isdefined( level.var_629f8c1e[ alias ] ) )
    {
        snd::stop( level.var_629f8c1e[ alias ] );
        level.var_629f8c1e[ alias ] = undefined;
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x72d1c88d, Offset: 0x730
// Size: 0x7c
function function_90b786f0()
{
    function_1ca6cc19( "emt_tapemach_nagra_play_lp" );
    function_1ca6cc19( "emt_tapemach_nagra_rew_lp" );
    function_1ca6cc19( "emt_tapemach_nagra_ff_lp" );
    function_1ca6cc19( "emt_tapemach_nagra_rec_lp" );
    function_1ca6cc19( "emt_tapemach_nagra_idle_lp" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x698edc49, Offset: 0x7b8
// Size: 0x108
function function_f58905f1()
{
    while ( true )
    {
        var_c5e8d21e = function_9b8a74e0( self, "nagra_play", "nagra_rew", "nagra_ff", "nagra_stop", "nagra_rec" );
        function_90b786f0();
        function_5bae4a7e( "emt_tapemach_" + var_c5e8d21e + "_lp" );
        snd::play( "emt_tapemach_nagra_trans_button_push", ( -299.926, 134.423, 33.9824 ) );
        snd::play( "emt_tapemach_" + var_c5e8d21e + "_mech", ( -299.926, 134.423, 33.9824 ) );
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 6
// Checksum 0x38318f71, Offset: 0x8c8
// Size: 0x19a
function function_9b8a74e0( otherent, string1, string2, string3, string4, string5 )
{
    otherent endon( #"death" );
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        level thread util::waittill_level_string( string1, ent, otherent );
    }
    
    if ( isdefined( string2 ) )
    {
        level thread util::waittill_level_string( string2, ent, otherent );
    }
    
    if ( isdefined( string3 ) )
    {
        level thread util::waittill_level_string( string3, ent, otherent );
    }
    
    if ( isdefined( string4 ) )
    {
        level thread util::waittill_level_string( string4, ent, otherent );
    }
    
    if ( isdefined( string5 ) )
    {
        level thread util::waittill_level_string( string5, ent, otherent );
    }
    
    if ( isdefined( otherent ) )
    {
        otherent thread util::waittill_string( "death", ent );
    }
    
    waitresult = ent waittill( #"returned" );
    ent notify( #"die" );
    return waitresult.msg;
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 1, eflags: 0x4
// Checksum 0x829953c1, Offset: 0xa70
// Size: 0x1d2
function private _objective( objective )
{
    level thread allies_init();
    
    switch ( objective )
    {
        case #"chapter_selection":
            break;
        case #"post_takedown":
        case #"post_takedown_skip_briefing":
            while ( !isdefined( level.adler ) )
            {
                waitframe( 1 );
            }
            
            level.adler waittill( #"dialog_ready" );
            level thread function_8a58b4f();
            break;
        case #"post_armada":
        case #"post_armada_skip_briefing":
            break;
        case #"post_yamantau":
        case #"post_yamantau_skip_briefing":
            break;
        case #"post_kgb":
        case #"post_kgb_skip_briefing":
            break;
        case #"post_cuba":
        case #"hash_6245569317a5039e":
            break;
        case #"post_prisoner":
        case #"hash_65bc9e5b3b128daf":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>" );
            #/
            
            break;
    }
}

// Namespace namespace_4ed3ce47/runnotetrackhandler
// Params 1, eflags: 0x44
// Checksum 0xa82317eb, Offset: 0xc50
// Size: 0x9c
function private event_handler[runnotetrackhandler] runnotetrackhandler( eventstruct )
{
    assert( isarray( eventstruct.notetracks ) );
    
    for ( index = 0; index < eventstruct.notetracks.size ; index++ )
    {
        ent = eventstruct.entity;
        notetrack = eventstruct.notetracks[ index ];
        
        if ( isdefined( notetrack ) )
        {
        }
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x128a9dc7, Offset: 0xcf8
// Size: 0x1e8
function allies_init()
{
    level.var_dafd41b2 = [];
    snd::waitforplayers();
    
    while ( !isdefined( level.adler ) )
    {
        waitframe( 1 );
    }
    
    level.var_dafd41b2[ level.var_dafd41b2.size ] = level.adler;
    level.var_dafd41b2[ level.var_dafd41b2.size ] = level.lazar;
    level.var_dafd41b2[ level.var_dafd41b2.size ] = level.park;
    level.var_dafd41b2[ level.var_dafd41b2.size ] = level.sims;
    level.var_dafd41b2[ level.var_dafd41b2.size ] = level.hudson;
    level.var_dafd41b2[ level.var_dafd41b2.size ] = level.woods;
    level.var_dafd41b2[ level.var_dafd41b2.size ] = level.mason;
    arrayremovevalue( level.var_dafd41b2, undefined );
    
    foreach ( ally in level.var_dafd41b2 )
    {
        if ( isstring( ally.targetname ) )
        {
            snd::client_targetname( ally, ally.targetname );
        }
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 1
// Checksum 0xf9973f43, Offset: 0xee8
// Size: 0x4e
function function_c26120ff( ent )
{
    name = ent.targetname;
    
    if ( isdefined( name ) && name == "park" )
    {
        return "tmp_vox_nonverbal_female";
    }
    
    return "tmp_vox_nonverbal_male";
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x133732ec, Offset: 0xf40
// Size: 0xc8
function function_8a58b4f()
{
    foreach ( ally in level.var_dafd41b2 )
    {
        if ( !isdefined( ally.var_2de4672c ) )
        {
            ally thread snd::function_9299618( &function_c26120ff, [ 6, 60 ] );
        }
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x6451a9d4, Offset: 0x1010
// Size: 0x1c
function dia_focus_on()
{
    snd::client_msg( "dia_focus_on" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xa9332352, Offset: 0x1038
// Size: 0x1c
function dia_focus_off()
{
    snd::client_msg( "dia_focus_off" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x30264b25, Offset: 0x1060
// Size: 0x1c
function ambient_override_return_to_normal()
{
    snd::client_msg( "ambient_override_return_to_normal" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x2dbb8d7a, Offset: 0x1088
// Size: 0x1c
function ambient_ext_override()
{
    snd::client_msg( "ambient_ext_override" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xd7bc2b5e, Offset: 0x10b0
// Size: 0x1c
function ambient_int_override()
{
    snd::client_msg( "ambient_int_override" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xb83d212d, Offset: 0x10d8
// Size: 0x194
function function_e81e970a()
{
    snd::play( "tmp_cp_ger_hub_ham_radio_scanner", ( -118, 153, 61 ) );
    snd::play( "tmp_cp_ger_hub_tape_mach_interview", ( -306, 167, 56 ) );
    snd::play( "evt_tape_machine_reels_lp", ( -292, 101, 60 ) );
    snd::play( "env_wall_clock_single_tick_lp", ( -5, 583, 99 ) );
    snd::play( "env_wall_clocks_board_tick_lp", ( -40, 133, 97 ) );
    snd::play( "evt_fluorescent_light", ( -240, -1108, 118 ) );
    snd::play( "evt_fluorescent_light", ( -240, -810, 118 ) );
    snd::play( "evt_fluorescent_light", ( -81, -577, 145 ) );
    snd::play( "evt_fluorescent_light", ( 76, -580, 146 ) );
    snd::play( "evt_fridge_hum_low", ( -63, 177, 10 ) );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xd6757deb, Offset: 0x1278
// Size: 0x194
function function_3c39b015()
{
    snd::play( "tmp_cp_ger_hub_ham_radio_scanner", ( -118, 153, 61 ) );
    snd::play( "tmp_cp_ger_hub_tape_mach_interview", ( -306, 167, 56 ) );
    snd::play( "evt_tape_machine_reels_lp", ( -292, 101, 60 ) );
    snd::play( "env_wall_clock_single_tick_lp", ( -5, 583, 99 ) );
    snd::play( "env_wall_clocks_board_tick_lp", ( -40, 133, 97 ) );
    snd::play( "evt_fluorescent_light", ( -240, -1108, 118 ) );
    snd::play( "evt_fluorescent_light", ( -240, -810, 118 ) );
    snd::play( "evt_fluorescent_light", ( -81, -577, 145 ) );
    snd::play( "evt_fluorescent_light", ( 76, -580, 146 ) );
    snd::play( "evt_fridge_hum_low", ( -63, 177, 10 ) );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x284ecae1, Offset: 0x1418
// Size: 0x194
function function_b7c50de7()
{
    snd::play( "tmp_cp_ger_hub_ham_radio_scanner", ( -118, 153, 61 ) );
    snd::play( "tmp_cp_ger_hub_tape_mach_interview", ( -306, 167, 56 ) );
    snd::play( "evt_tape_machine_reels_lp", ( -292, 101, 60 ) );
    snd::play( "env_wall_clock_single_tick_lp", ( -5, 583, 99 ) );
    snd::play( "env_wall_clocks_board_tick_lp", ( -40, 133, 97 ) );
    snd::play( "evt_fluorescent_light", ( -240, -1108, 118 ) );
    snd::play( "evt_fluorescent_light", ( -240, -810, 118 ) );
    snd::play( "evt_fluorescent_light", ( -81, -577, 145 ) );
    snd::play( "evt_fluorescent_light", ( 76, -580, 146 ) );
    snd::play( "evt_fridge_hum_low", ( -63, 177, 10 ) );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x5dec00be, Offset: 0x15b8
// Size: 0x1c
function function_d2bce2b8()
{
    snd::play( "uin_transition_evidence_board_enter" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xfe8f277c, Offset: 0x15e0
// Size: 0x1c
function function_dd520714()
{
    snd::play( "uin_transition_evidence_board_exit" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xa2a6113c, Offset: 0x1608
// Size: 0x1c
function function_6fe99ae0()
{
    snd::play( "uin_map_whoosh_paper" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xdd1d06f8, Offset: 0x1630
// Size: 0x1c
function function_f60575fd()
{
    snd::play( "uin_map_camera_move_whoosh" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x7f34853d, Offset: 0x1658
// Size: 0x2c
function function_dc08e48d()
{
    snd::play( "evt_fan_portable_switch_on", ( 57, -448, 19 ) );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 1
// Checksum 0x8af4dbee, Offset: 0x1690
// Size: 0x2aa
function function_7edafa59( str_msg )
{
    if ( isdefined( level.var_41fc1341 ) )
    {
        if ( level.var_41fc1341 != str_msg )
        {
            level.var_2c9b406b = level.var_41fc1341;
        }
    }
    
    switch ( str_msg )
    {
        case #"ambient":
            level.var_41fc1341 = str_msg;
            music::setmusicstate( "ambient" );
            break;
        case #"evidence_board_main":
            level.var_41fc1341 = str_msg;
            music::setmusicstate( "evidence_board_main" );
            break;
        case #"hash_75e670280bd9b6de":
            level.var_41fc1341 = str_msg;
            break;
        case #"post_takedown_briefing":
            level.var_41fc1341 = str_msg;
            music::setmusicstate( "briefing_takedown" );
            break;
        case #"post_armada_briefing":
            level.var_41fc1341 = str_msg;
            music::setmusicstate( "briefing_armada" );
            break;
        case #"post_yamantau_briefing":
            level.var_41fc1341 = str_msg;
            music::setmusicstate( "briefing_yamantau" );
            break;
        case #"post_kgb_briefing":
            level.var_41fc1341 = str_msg;
            music::setmusicstate( "briefing_kgb" );
            break;
        case #"post_cuba_briefing":
            level.var_41fc1341 = str_msg;
            music::setmusicstate( "briefing_cuba" );
            break;
        case #"hash_210b4ac6f58c7279":
            level.var_41fc1341 = str_msg;
            music::setmusicstate( "briefing_prisoner" );
            break;
        default:
            /#
                iprintlnbold( "<dev string:x60>" + str_msg + "<dev string:x72>" );
            #/
            
            break;
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xde4130e7, Offset: 0x1948
// Size: 0x1c
function function_44ce38f6()
{
    snd::play( "uin_transition_lowender_takedown" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x30ad0ed1, Offset: 0x1970
// Size: 0x9c
function tv_abstract_on()
{
    var_c50d49d8 = getent( "flashback_tv_screen", "targetname" );
    level.var_b07c33dd = snd::play( "event_tv_abstracts_tension_render_lp", var_c50d49d8 );
    snd::play( "event_tv_abstract_start", var_c50d49d8 );
    snd::play( "event_tv_abstract_on", var_c50d49d8 );
    snd::client_msg( "tv_abstract_on" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xcc4f75c5, Offset: 0x1a18
// Size: 0x7c
function tv_abstract_off()
{
    var_c50d49d8 = getent( "flashback_tv_screen", "targetname" );
    snd::stop( level.var_b07c33dd );
    snd::play( "event_tv_abstract_off", var_c50d49d8 );
    snd::client_msg( "tv_abstract_off" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x1fb60820, Offset: 0x1aa0
// Size: 0x64
function function_3b211e90()
{
    var_c50d49d8 = getent( "flashback_tv_screen", "targetname" );
    snd::stop( level.var_b07c33dd );
    snd::client_msg( "tv_abstract_off" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x5108a78f, Offset: 0x1b10
// Size: 0x3c
function function_e043da15()
{
    level waittill( #"hash_30a43574a5dc7eaf" );
    level thread function_7edafa59( "ambient" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x4dfe61c4, Offset: 0x1b58
// Size: 0x3c
function function_9ac95ec9()
{
    level waittill( #"hash_1c9f12be6eb51878" );
    level thread function_7edafa59( "ambient" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x79a3465, Offset: 0x1ba0
// Size: 0x3c
function function_37c997de()
{
    level waittill( #"hash_55da63f0f51c5d6c" );
    level thread function_7edafa59( "ambient" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xca024abe, Offset: 0x1be8
// Size: 0x3c
function function_4aa573e7()
{
    level waittill( #"hash_2a423f7844789ffa" );
    level thread function_7edafa59( "ambient" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x7c0a7bab, Offset: 0x1c30
// Size: 0x3c
function function_d89aa829()
{
    level waittill( #"hash_117dd9247812a234" );
    level thread function_7edafa59( "ambient" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xd85664ee, Offset: 0x1c78
// Size: 0x3c
function function_46f173b2()
{
    level waittill( #"hash_3b68231254fe41c0" );
    level thread function_7edafa59( "ambient" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x4d1b1f2c, Offset: 0x1cc0
// Size: 0x3c
function function_849d7772()
{
    level waittill( #"hash_62067a3d17f16ce0" );
    level thread function_7edafa59( "ambient" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x80606eae, Offset: 0x1d08
// Size: 0x24
function duck_evidence_board_enter()
{
    snd::client_msg( #"hash_774f81b7fe6ee1f6" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x699f8026, Offset: 0x1d38
// Size: 0x24
function duck_evidence_board_exit()
{
    snd::client_msg( #"hash_3f89f51c820e2ec0" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x2fbfe7, Offset: 0x1d68
// Size: 0x1c
function function_ef676505()
{
    snd::client_msg( "post_armada" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x440b6326, Offset: 0x1d90
// Size: 0x1c
function function_2d62fc6f()
{
    snd::client_msg( "post_kgb" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xcdcbf723, Offset: 0x1db8
// Size: 0x1c
function function_d6c61f8()
{
    snd::client_msg( "post_cuba" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xc00024e, Offset: 0x1de0
// Size: 0x1c
function function_dd79396d()
{
    snd::client_msg( "post_prisoner" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x828220, Offset: 0x1e08
// Size: 0x1c
function function_c7f31c4b()
{
    snd::client_msg( "post_takedown" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xf23464f3, Offset: 0x1e30
// Size: 0x1c
function function_938891c9()
{
    snd::client_msg( "post_yamantau" );
}

