#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;

#namespace namespace_353d803e;

// Namespace namespace_353d803e/level_preinit
// Params 1, eflags: 0x44
// Checksum 0x1dcf490a, Offset: 0x1318
// Size: 0x3c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
    snd::wait_init();
}

// Namespace namespace_353d803e/event_cc819519
// Params 1, eflags: 0x44
// Checksum 0x8546f2d9, Offset: 0x1360
// Size: 0xfc
function private event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    players = snd::function_da785aa8();
    player = players[ 0 ];
    assert( isplayer( player ) );
    player thread function_a20133bd();
    snd::client_targetname( players[ 0 ], "player" );
    thread function_f48103c7();
    thread phone();
    thread function_3033a22c();
    function_440e3501();
    thread function_7932589a();
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 1, eflags: 0x4
// Checksum 0xab19be99, Offset: 0x1468
// Size: 0x2aa
function private _objective( objective )
{
    player = snd::function_da785aa8()[ 0 ];
    
    switch ( objective )
    {
        case #"kgb_ins_briefing":
        case #"kgb_ins_prepare":
        case #"kgb_ins_activation":
        case #"kgb_ins_tutorial":
            break;
        case #"kgb_ins_rv":
            music( "6.0_basement" );
            break;
        case #"kgb_aslt_entry":
            music( "8.0_undercover" );
            break;
        case #"kgb_aslt_elev_down":
            music( "9.0_infiltrating" );
            break;
        case #"kgb_aslt_bunker":
            level waittill( #"hash_49ad3ddc839a715c" );
            player notify( #"hash_7ad75056b30c451a" );
            level notify( #"hash_63850bb43dbc38de" );
            break;
        case #"kgb_aslt_vault_breach":
        case #"kgb_aslt_vault":
        case #"kgb_aslt_vault_approach":
            player notify( #"hash_7ad75056b30c451a" );
            break;
        case #"kgb_aslt_bunker_escape":
            music( "13.3_lockdown_tension" );
            player notify( #"hash_7ad75056b30c451a" );
            break;
        case #"kgb_aslt_bunker_escape_deploy_gas":
        case #"kgb_aslt_exfil":
        case #"kgb_aslt_exfil_escape":
        case #"kgb_aslt_bunker_escape_lights_out":
            player notify( #"hash_7ad75056b30c451a" );
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

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 2
// Checksum 0xb3ff653a, Offset: 0x1720
// Size: 0x3c
function music( str_msg, n_delay = 0 )
{
    level thread function_7edafa59( str_msg, n_delay );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 2
// Checksum 0x9acdf93f, Offset: 0x1768
// Size: 0x752
function function_7edafa59( str_msg, n_delay )
{
    switch ( str_msg )
    {
        case #"hash_2256b0dea87465d2":
        case #"9.0_infiltrating":
        case #"hash_d96dba6e7a99f85":
        case #"11.3_combat2":
        case #"13.5_lockdown":
        case #"hash_2d88f0176ae057fb":
        case #"hash_1d433b9a413139d4":
        case #"14.0_knockout":
        case #"8.0_undercover":
        case #"13.3_lockdown_tension":
        case #"hash_2910ae132ebdc558":
        case #"hash_35dacd4322564668":
        case #"14.0b_full_alert":
        case #"6.0_basement":
        case #"hash_3f88adcdc052e5b6":
        case #"7.0_tunnels":
        case #"11.0_sabotage":
        case #"13.7_holding_belikov":
        case #"5.0_unlock":
        case #"hash_78d371826c395268":
        case #"10.2_combat_loop":
        case #"10.0_combat_intro":
        case #"5.2_kill":
        case #"8.1_gate":
            music::setmusicstate( str_msg, undefined, n_delay );
            break;
        case #"4.3_tension_stingers":
        case #"4.2_search_stingers":
        case #"8.2_cello_stingers_1":
        case #"8.3_cello_stingers_2":
            music::function_2af5f0ec( str_msg );
            break;
        case #"7.1_attack_sting":
            music::function_edda155f( str_msg, n_delay );
            break;
        case #"deactivate_11.3_combat2":
        case #"hash_63d49b1407be692c":
        case #"hash_5cb44079caf0d925":
        case #"deactivate_6.0_basement":
        case #"hash_5cde78352f0969e3":
        case #"hash_33d1bd1987cf9ec5":
        case #"hash_5a5ac38c04395a49":
        case #"hash_2966b4a1e4a3a38d":
            music::setmusicstate( "none", undefined, n_delay );
            break;
        case #"kgb_ins_briefing":
            music::setmusicstate( "kgb_ins_briefing" );
            break;
        case #"kgb_ins_activation_01":
            music::setmusicstate( "kgb_ins_activation_01" );
            break;
        case #"kgb_ins_activation_02":
            music::setmusicstate( "kgb_ins_activation_02" );
            break;
        case #"kgb_ins_prepare_01":
            music::setmusicstate( "kgb_ins_prepare_01" );
            break;
        case #"kgb_ins_prepare_02":
            music::setmusicstate( "kgb_ins_prepare_02" );
            break;
        case #"kgb_ins_prepare_03":
            music::setmusicstate( "kgb_ins_prepare_03" );
            break;
        case #"kgb_ins_prepare_04":
            music::setmusicstate( "kgb_ins_prepare_04" );
            break;
        case #"kgb_ins_rv_01":
            music::setmusicstate( "kgb_ins_rv_01" );
            break;
        case #"kgb_ins_rv_02":
            music::setmusicstate( "kgb_ins_rv_02" );
            break;
        case #"kgb_ins_rv_03":
            music::setmusicstate( "kgb_ins_rv_03" );
            break;
        case #"kgb_ins_rv_04":
            music::setmusicstate( "kgb_ins_rv_04" );
            break;
        case #"kgb_ins_rv_05":
            music::setmusicstate( "kgb_ins_rv_05" );
            break;
        case #"kgb_aslt_elev_down":
            music::setmusicstate( "kgb_aslt_elev_down" );
            break;
        case #"kgb_aslt_bunker":
            music::setmusicstate( "kgb_aslt_bunker" );
            break;
        case #"kgb_aslt_vault_approach":
            music::setmusicstate( "kgb_aslt_vault_approach" );
            break;
        case #"kgb_aslt_vault_breach":
            music::setmusicstate( "kgb_aslt_vault_breach" );
            break;
        case #"kgb_aslt_vault":
            music::setmusicstate( "kgb_aslt_vault" );
            break;
        case #"kgb_aslt_bunker_escape":
            music::setmusicstate( "kgb_aslt_bunker_escape" );
            break;
        case #"kgb_aslt_bunker_escape_lights_out":
            music::setmusicstate( "kgb_aslt_bunker_escape_lights_out" );
            break;
        case #"kgb_aslt_bunker_escape_deploy_gas":
            music::setmusicstate( "kgb_aslt_bunker_escape_deploy_gas" );
            break;
        case #"kgb_aslt_exfil":
            music::setmusicstate( "kgb_aslt_bunker_escape_lights_out" );
            break;
        case #"kgb_aslt_exfil_escape":
            music::setmusicstate( "kgb_aslt_bunker_escape" );
            break;
        default:
            /#
                iprintlnbold( "<dev string:x60>" + str_msg + "<dev string:x72>" );
            #/
            
            break;
    }
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 1
// Checksum 0xac40e9c3, Offset: 0x1ec8
// Size: 0xf6
function function_c26120ff( ent )
{
    female_heads = [ #"c_t9_ger_civ_female_head01", #"c_t9_ger_civ_female_head02", #"c_t9_ger_civ_female_head03", #"c_t9_ger_civ_female_head04", #"c_t9_ger_civ_female_head05", #"c_t9_ger_civ_female_head06" ];
    head = ent.head;
    isfemale = array::contains( female_heads, head );
    
    if ( isfemale )
    {
        return "tmp_vox_nonverbal_female";
    }
    
    return "tmp_vox_nonverbal_male";
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x6974381a, Offset: 0x1fc8
// Size: 0x22a
function function_a20133bd()
{
    self notify( #"hash_7ad75056b30c451a" );
    self endon( #"hash_7ad75056b30c451a", #"death", #"disconnect" );
    var_88701456 = 0;
    
    while ( true )
    {
        view_origin = self snd::getplayervieworigin();
        var_839b8d61 = getentitiesinradius( view_origin, 1200, 15 );
        var_97d10723 = function_b6dd763( view_origin, 1200 );
        ents = arraycombine( var_839b8d61, var_97d10723, 0 );
        var_dcf355d7 = 0;
        var_bff726ab = min( 32, ents.size );
        
        while ( ents.size > 0 && var_dcf355d7 < var_bff726ab )
        {
            var_88701456 %= ents.size;
            ent = ents[ var_88701456 ];
            
            if ( isentity( ent ) && !ent ishidden() )
            {
                head = ent.head;
                
                if ( isdefined( head ) && head != "" && !isdefined( ent.var_2de4672c ) )
                {
                    ent thread snd::function_9299618( &function_c26120ff, [ 6, 60 ] );
                }
            }
            
            var_dcf355d7++;
            var_88701456++;
        }
        
        waitframe( 20 );
    }
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x2200
// Size: 0x4
function function_fef24c06()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x2210
// Size: 0x4
function function_d0a16654()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x2220
// Size: 0x4
function function_7932589a()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x8998c926, Offset: 0x2230
// Size: 0x8c
function function_4bbc8660()
{
    alias = "amb_emt_generator_01";
    positions = [ ( -3165, 2474, -1746 ), ( -3486, 2475, -1751 ), ( -3326, 2317, -1715 ) ];
    level.amb_emt_generator_01 = snd::play( alias, positions );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xf5aa1631, Offset: 0x22c8
// Size: 0x74
function function_5f7aaddc()
{
    alias = "amb_emt_generator_02";
    positions = [ ( -3195, 2002, -1752 ), ( -3455, 1996, -1752 ) ];
    level.amb_emt_generator_02 = snd::play( alias, positions );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x89944b14, Offset: 0x2348
// Size: 0x74
function function_3842df6d()
{
    alias = "amb_emt_generator_03";
    positions = [ ( -3212, 1690, -1752 ), ( -3437, 1690, -1752 ) ];
    level.amb_emt_generator_03 = snd::play( alias, positions );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x24f781a0, Offset: 0x23c8
// Size: 0xac
function function_47039dc8()
{
    snd::stop( level.amb_emt_generator_01, 0.5 );
    alias = "amb_emt_generator_01_stop";
    positions = [ ( -3165, 2474, -1746 ), ( -3486, 2475, -1751 ), ( -3326, 2317, -1715 ) ];
    level.amb_emt_generator_01_stop = snd::play( alias, positions );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x8cf96cf6, Offset: 0x2480
// Size: 0x94
function function_a26d549e()
{
    snd::stop( level.amb_emt_generator_02, 0.5 );
    alias = "amb_emt_generator_02_stop";
    positions = [ ( -3195, 2002, -1752 ), ( -3455, 1996, -1752 ) ];
    level.amb_emt_generator_02_stop = snd::play( alias, positions );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc54bc469, Offset: 0x2520
// Size: 0x94
function function_b4cf7962()
{
    snd::stop( level.amb_emt_generator_03, 0.5 );
    alias = "amb_emt_generator_03_stop";
    positions = [ ( -3212, 1690, -1752 ), ( -3437, 1690, -1752 ) ];
    level.amb_emt_generator_03_stop = snd::play( alias, positions );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc172d145, Offset: 0x25c0
// Size: 0x184
function function_5f16d3f3()
{
    level.amb_elm_polishradio = snd::play( "amb_elm_polishradio", ( -587, 147, 448 ) );
    level.amb_emt_tv_static_04 = snd::play( "amb_emt_tv_static_04", ( -587, 110, 3910 ) );
    level.amb_evt_aslt_vault_server_03 = snd::play( "amb_evt_aslt_vault_server_03", ( -665, -24, 440 ) );
    level.amb_emt_powerhum_01 = snd::play( "amb_emt_powerhum_01", ( -623, 83, 410 ) );
    level.amb_kgb_camroom_lp_01 = snd::play( "amb_kgb_camroom_lp_01", ( -576, 159, 461 ) );
    level.amb_kgb_camroom_lp_02 = snd::play( "amb_kgb_camroom_lp_02", ( -377, 104, 461 ) );
    level.amb_kgb_stakhanov_lp = snd::play( "amb_kgb_stakhanov_lp", ( -453, 165, 418 ) );
    level.amb_kgb_camroom_generator_lp = snd::play( "amb_kgb_camroom_generator_lp", ( -644, 95, 455 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc0e34f95, Offset: 0x2750
// Size: 0x104
function function_f3d767c7()
{
    snd::stop( level.amb_elm_polishradio, 0.5 );
    snd::stop( level.amb_emt_tv_static_04, 0.5 );
    snd::stop( level.amb_evt_aslt_vault_server_03, 0.5 );
    snd::stop( level.amb_emt_powerhum_01, 0.5 );
    snd::stop( level.amb_kgb_camroom_lp_01, 0.5 );
    snd::stop( level.amb_kgb_camroom_lp_02, 0.5 );
    snd::stop( level.amb_kgb_stakhanov_lp, 0.5 );
    snd::stop( level.amb_kgb_camroom_generator_lp, 0.5 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x37c4bd64, Offset: 0x2860
// Size: 0x28c
function function_ac0aa1e6()
{
    snd::play( "cin_kgb_camroom_switch_off", level.player );
    wait 1.3;
    snd::play( "cin_kgb_camroom_shtdwn_01", ( -437, -5, 453 ) );
    snd::play( "cin_kgb_camroom_shtdwn_02", ( -575, 105, 465 ) );
    snd::play( "cin_kgb_camroom_shtdwn_03", ( -561, -79, 440 ) );
    snd::play( "amb_kgb_camroom_generator_stdwn", ( -662, 95, 420 ) );
    snd::stop( level.amb_elm_polishradio, 0.7 );
    snd::stop( level.amb_emt_tv_static_04, 0.5 );
    snd::stop( level.amb_evt_aslt_vault_server_03, 0.3 );
    snd::stop( level.amb_emt_powerhum_01, 0.4 );
    snd::stop( level.amb_kgb_camroom_lp_01, 0.3 );
    snd::stop( level.amb_kgb_camroom_lp_02, 0.5 );
    snd::stop( level.amb_kgb_stakhanov_lp, 0.8 );
    snd::stop( level.amb_kgb_camroom_generator_lp, 0.5 );
    min_time = 0.25;
    max_time = 0.75;
    wait randomfloatrange( min_time, max_time );
    snd::play( "cin_kgb_camroom_shtdwn_screen_01", ( -544, 171, 448 ) );
    min_time = 0.25;
    max_time = 0.75;
    wait randomfloatrange( min_time, max_time );
    snd::play( "cin_kgb_camroom_shtdwn_screen_02", ( -373, 96, 454 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x6f3886b4, Offset: 0x2af8
// Size: 0x298
function function_fe19f3c9()
{
    level endon( #"hash_1c1549a38fffb2f4" );
    
    while ( true )
    {
        snd::play( "amb_kgb_seq_take_01", ( -549, 133, 406 ) );
        var_6fe72b06 = 0.6;
        var_84928e78 = 1;
        wait randomfloatrange( var_6fe72b06, var_84928e78 );
        snd::play( "amb_kgb_seq_take_02", ( -549, 133, 406 ) );
        var_bd9dc672 = 7.2;
        var_2123c798 = 9;
        wait randomfloatrange( var_bd9dc672, var_2123c798 );
        snd::play( "amb_kgb_seq_take_03", ( -549, 133, 406 ) );
        var_d959fdea = 2.4;
        var_2edb6307 = 4.1;
        wait randomfloatrange( var_d959fdea, var_2edb6307 );
        snd::play( "amb_kgb_seq_take_04", ( -549, 133, 406 ) );
        var_a70c194f = 4.4;
        var_cbbf9cd1 = 6;
        wait randomfloatrange( var_a70c194f, var_cbbf9cd1 );
        snd::play( "amb_kgb_seq_take_05", ( -549, 133, 406 ) );
        var_b4bd34b1 = 13.2;
        var_d9803852 = 15;
        wait randomfloatrange( var_b4bd34b1, var_d9803852 );
        snd::play( "amb_kgb_seq_take_06", ( -549, 133, 406 ) );
        var_46d53e4 = 2.2;
        var_76897282 = 3.5;
        wait randomfloatrange( var_46d53e4, var_76897282 );
    }
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x5abaa20a, Offset: 0x2d98
// Size: 0x24
function function_abeed983()
{
    snd::play( "tmp_sfx_kgb_terminal_convo_01", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x6803a914, Offset: 0x2dc8
// Size: 0x24
function function_bdbc7d1e()
{
    snd::play( "tmp_sfx_kgb_terminal_convo_02", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x9759c569, Offset: 0x2df8
// Size: 0x24
function function_c7719088()
{
    snd::play( "tmp_sfx_kgb_terminal_convo_03", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xf26d4a9f, Offset: 0x2e28
// Size: 0x24
function function_d9683475()
{
    snd::play( "tmp_sfx_kgb_terminal_convo_04", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xeaf74138, Offset: 0x2e58
// Size: 0x24
function function_c7469036()
{
    snd::play( "tmp_sfx_kgb_terminal_convo_05", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x92235718, Offset: 0x2e88
// Size: 0x24
function function_3106c0e1()
{
    snd::play( "tmp_sfx_kgb_conference_sitdown", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xb5e63be1, Offset: 0x2eb8
// Size: 0x24
function function_8dbac4c1()
{
    snd::play( "tmp_sfx_kgb_conference_doorshut", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xaf043c, Offset: 0x2ee8
// Size: 0x2c
function function_60fcb708()
{
    wait 3;
    snd::play( "tmp_sfx_kgb_conference_getup_dooropen", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x940aa6e5, Offset: 0x2f20
// Size: 0x24
function function_49d8d9d()
{
    snd::play( "tmp_sfx_kgb_computer_access_computer", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xbde4a824, Offset: 0x2f50
// Size: 0x24
function function_e2820c94()
{
    snd::play( "tmp_sfx_kgb_computer_lockpick_success", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xeea6828f, Offset: 0x2f80
// Size: 0x24
function function_486c67b()
{
    snd::play( "tmp_sfx_kgb_computer_lockpick_start", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 1
// Checksum 0xabace84, Offset: 0x2fb0
// Size: 0x2a
function function_f8d8b462( camera )
{
    camera.var_9a2ede48 = snd::play( "tmp_sfx_kgb_computer_camera_idle_lp", camera );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 1
// Checksum 0xef1f1062, Offset: 0x2fe8
// Size: 0x64
function function_c7dd32ac( camera )
{
    if ( isdefined( camera.var_9a2ede48 ) )
    {
        snd::stop( camera.var_9a2ede48, 0 );
        camera.var_9a2ede48 = undefined;
    }
    
    snd::play( "tmp_sfx_kgb_computer_camera_disable", camera );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x152b8127, Offset: 0x3058
// Size: 0x24
function function_f42d96e2()
{
    snd::play( "tmp_sfx_kgb_cigar_mail", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xde6f50f5, Offset: 0x3088
// Size: 0x24
function function_707fbb7()
{
    snd::play( "tmp_kgb_sfx_sideoffice_vent_open", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xfc354460, Offset: 0x30b8
// Size: 0x24
function function_d730e269()
{
    snd::play( "tmp_sfx_kgb_cigar_grab", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x5578fb9b, Offset: 0x30e8
// Size: 0x24
function function_4bf78aab()
{
    snd::play( "tmp_sfx_kgb_door_locked", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc07f6972, Offset: 0x3118
// Size: 0x24
function function_7621fb8d()
{
    snd::play( "tmp_sfx_kgb_close_blinds", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xeabfcc8, Offset: 0x3148
// Size: 0x24
function function_43002e1f()
{
    snd::play( "tmp_sfx_kgb_poison_guard_reacts", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x5a1c9fe4, Offset: 0x3178
// Size: 0x24
function function_49bf0754()
{
    snd::play( "tmp_sfx_kgb_poison_deploy", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xb07927ea, Offset: 0x31a8
// Size: 0x24
function function_89f4da45()
{
    snd::play( "tmp_sfx_kgb_poison_secretary_sip_coffee", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x86219e8, Offset: 0x31d8
// Size: 0x1c
function function_b1017f04()
{
    snd::play( "evt_kgb_prepare_projectnova_paper_pickup" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x2e053b6e, Offset: 0x3200
// Size: 0x24
function function_ca0f1dd6()
{
    wait 0.6;
    snd::play( "evt_kgb_prepare_poison_cabinet_open" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xaa932d2a, Offset: 0x3230
// Size: 0x1c
function function_2ecd85bc()
{
    snd::play( "evt_kgb_prepare_poison_cabinet_pickup" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xda0da00f, Offset: 0x3258
// Size: 0x24
function function_ecda5886()
{
    wait 1.5;
    snd::play( "cin_kgb_poison_charkov_tea" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x6a19a6e9, Offset: 0x3288
// Size: 0x24
function function_f25a5965()
{
    wait 0.8;
    snd::play( "cin_kgb_poison_swap_cup" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x517c5f96, Offset: 0x32b8
// Size: 0x24
function function_b67beca7()
{
    snd::play( "tmp_sfx_kgb_poison_secretary_drawer", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x3f20ce2a, Offset: 0x32e8
// Size: 0x24
function function_aa5dd876()
{
    snd::play( "tmp_sfx_kgb_computer_grab_keycard", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80681313, Offset: 0x3318
// Size: 0x24
function function_539a2341()
{
    snd::play( "snd_play_tmp_sfx_kgb_checkp_card_swipe", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc38db04a, Offset: 0x3348
// Size: 0x24
function function_8c26926d()
{
    snd::play( "cin_kgb_prepare_prisoner_file_fake", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x142f03a1, Offset: 0x3378
// Size: 0x24
function function_28897188()
{
    snd::play( "cin_kgb_prisoner_file_get", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x2de0df89, Offset: 0x33a8
// Size: 0x24
function function_7058432e()
{
    snd::play( "cin_kgb_prisoner_cuff_unlock", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc27a7fbf, Offset: 0x33d8
// Size: 0x24
function function_7526abf0()
{
    snd::play( "tmp_sfx_kgb_prisoner_file_cabinet", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x973359fc, Offset: 0x3408
// Size: 0x24
function function_e09dc15d()
{
    snd::play( "tmp_sfx_kgb_walkietalkie", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xe9a464cf, Offset: 0x3438
// Size: 0x1c
function function_45192a6c()
{
    snd::play( "tmp_kgb_vo_busted" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x2cd5dedf, Offset: 0x3460
// Size: 0x34
function function_1ef37bcf()
{
    wait 3.3;
    snd::play( "evt_kgb_prison_sliding_gate_open", ( -698, -1164, 440 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x17a491c7, Offset: 0x34a0
// Size: 0x1c
function function_b93da28b()
{
    snd::play( "evt_kgb_player_poison_death" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xe8ba0314, Offset: 0x34c8
// Size: 0x24
function function_f5f67fee()
{
    snd::play( "cin_kgb_rv_boiler_charswap", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x84aea831, Offset: 0x34f8
// Size: 0x24
function function_8ff37b64()
{
    snd::play( "tmp_sfx_kgb_rv_doubletakedown_action", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc9c29879, Offset: 0x3528
// Size: 0x24
function function_db3ecde()
{
    snd::play( "tmp_sfx_kgb_rv_switch_clothes", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xd89067e6, Offset: 0x3558
// Size: 0x24
function function_421ecccd()
{
    snd::play( "tmp_sfx_kgb_rv_adlerpass_cp", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x59b612f9, Offset: 0x3588
// Size: 0x24
function function_1a4fa92e()
{
    snd::play( "tmp_sfx_kgb_rv_playerfail_cp", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xbed69c4f, Offset: 0x35b8
// Size: 0x24
function function_72b6cf8b()
{
    snd::play( "tmp_sfx_kgb_rv_cp_scene_01", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x18cdc5c3, Offset: 0x35e8
// Size: 0x2c
function function_247e32ff()
{
    wait 12.5;
    snd::play( "tmp_sfx_kgb_rv_cp_scene_02", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x57c2aad5, Offset: 0x3620
// Size: 0x2c
function function_4e4906b0()
{
    wait 8;
    snd::play( "tmp_sfx_kgb_rv_cp_scene_03", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xe319421b, Offset: 0x3658
// Size: 0x24
function function_5d8bd082()
{
    snd::play( "tmp_sfx_kgb_elevator_adlerbutton", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc808beb1, Offset: 0x3688
// Size: 0x5c
function function_d2bfe6bd()
{
    wait 16;
    snd::play( "cin_kgb_elevdown_elev_start", level.player );
    wait 3;
    level.var_12c17d45 = snd::play( "cin_kgb_elevdown_elev_lp", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x777154ec, Offset: 0x36f0
// Size: 0x4c
function function_21e6fc96()
{
    wait 4.5;
    snd::play( "cin_kgb_elevdown_elev_end", level.player );
    snd::stop( level.var_12c17d45, 0.5 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x89b76a3e, Offset: 0x3748
// Size: 0x5c
function function_8b168679()
{
    wait 15;
    snd::play( "cin_kgb_elevdown_elev_start", level.player );
    wait 2;
    level.var_12c17d45 = snd::play( "cin_kgb_elevdown_elev_lp", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x8fb99208, Offset: 0x37b0
// Size: 0x94
function function_3e72b69a()
{
    snd::stop( level.var_12c17d45, 0.5 );
    snd::play( "cin_kgb_elevdown_elev_accel_base", level.player );
    snd::play( "cin_kgb_elevdown_elev_accel_sweet", level.player );
    wait 4.5;
    level.var_d7f3c673 = snd::play( "cin_kgb_elevdown_elev_fast_lp", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x72fcf62f, Offset: 0x3850
// Size: 0x44
function function_f3f9a760()
{
    snd::play( "cin_kgb_elevdown_elev_end", level.player );
    snd::stop( level.var_d7f3c673, 0.5 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x3ced979b, Offset: 0x38a0
// Size: 0x44
function function_7972eaf3()
{
    snd::play( "cin_kgb_elevdown_elev_end", level.player );
    snd::stop( level.var_12c17d45, 0.5 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x25e4a839, Offset: 0x38f0
// Size: 0x74
function function_8c558bef()
{
    wait 0.45;
    snd::play( "evt_kgb_vault_open_key" );
    wait 3.1;
    snd::play( "evt_kgb_vault_open_lever" );
    wait 0.9;
    snd::play( "evt_kgb_vault_open_door", ( -5747, 1796, -1603 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xd6e2da88, Offset: 0x3970
// Size: 0x2c
function cin_kgb_vault_lights_on()
{
    snd::play( "cin_kgb_vault_lights_on", ( -6107, 1796, -1603 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xb16b6c0, Offset: 0x39a8
// Size: 0x34
function function_3873d8bb()
{
    wait 1.8;
    snd::play( "cin_kgb_vault_door_close", ( -5747, 1796, -1603 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xe9dfa310, Offset: 0x39e8
// Size: 0x24
function evt_kgb_vault_key_computer()
{
    wait 0.64;
    snd::play( "evt_kgb_vault_key_computer" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x27f63425, Offset: 0x3a18
// Size: 0x2c
function function_df10a156()
{
    snd::play( "cin_kgb_vault_door_explosive_fail", ( -5800, 1796, -1603 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xad2b8586, Offset: 0x3a50
// Size: 0x5c
function function_33c1b7fa()
{
    snd::play( "cin_kgb_vault_door_cut_start", ( -5800, 1796, -1603 ) );
    level.var_97388b3 = snd::play( "cin_kgb_vault_door_cut_lp", ( -5800, 1796, -1603 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xe83c5e8a, Offset: 0x3ab8
// Size: 0x4c
function function_d9c39917()
{
    snd::play( "cin_kgb_vault_door_cut_stop", ( -5800, 1796, -1603 ) );
    snd::stop( level.var_97388b3, 0.5 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xe431b642, Offset: 0x3b10
// Size: 0x84
function function_15ad318b()
{
    pos = ( -6290, 1819, -1591 );
    snd::play( "cin_kgb_vault_floppy_disk_insert", pos );
    wait 1.7;
    snd::play( "cin_kgb_vault_copy_disk_start", pos );
    wait 1;
    level.var_a86b831b = snd::play( "cin_kgb_vault_copy_disk_lp", pos );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xf34311c5, Offset: 0x3ba0
// Size: 0x5c
function function_2f74668e()
{
    pos = ( -6290, 1819, -1591 );
    snd::stop( level.var_a86b831b, 0.5 );
    wait 1.6;
    snd::play( "cin_kgb_vault_floppy_disk_eject", pos );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xca470cb2, Offset: 0x3c08
// Size: 0x24
function function_942dc631()
{
    snd::play( "cin_kgb_plant_gas", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x32d54a59, Offset: 0x3c38
// Size: 0x24
function function_57670fa4()
{
    snd::play( "cin_kgb_plant_gas_bunkerdoor", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x461d40c3, Offset: 0x3c68
// Size: 0x24
function function_62f3e8ea()
{
    wait 0.3;
    snd::play( "evt_kgb_deploygas_remote_pullout" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc90221f0, Offset: 0x3c98
// Size: 0x4c
function evt_kgb_deploygas_gas_mask_on()
{
    wait 0.8;
    snd::play( "evt_kgb_deploygas_gas_mask_on" );
    wait 1.17;
    level.var_6530ddf1 = snd::play( "evt_kgb_gas_mask_breath_lp" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x9cd911fe, Offset: 0x3cf0
// Size: 0x24
function function_528de78b()
{
    snd::play( "tmp_sfx_kgb_deploygas_mask_adler", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x2b4cd55b, Offset: 0x3d20
// Size: 0x2c
function function_47dcb676()
{
    wait 1;
    snd::play( "tmp_sfx_kgb_deploygas_mask_player", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xcf711b5d, Offset: 0x3d58
// Size: 0x24
function function_9641c539()
{
    snd::play( "tmp_sfx_kgb_flashlight", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x76dc31fc, Offset: 0x3d88
// Size: 0x54
function function_b1bdc561()
{
    snd::play( "evt_kgb_lightsout_scream" );
    wait 7;
    snd::play( "evt_kgb_lightsoff_metal_fall", ( -3446.94, 515.201, -1737.84 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x6c054322, Offset: 0x3de8
// Size: 0x44
function function_d2c6a99f()
{
    snd::play( "cin_lightsout_switch_cascade_01", level.player );
    snd::play( "cin_lightsout_bassdrop", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x3971846e, Offset: 0x3e38
// Size: 0x24
function function_247bcd08()
{
    snd::play( "cin_lightsout_switch_cascade_02", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x207375d9, Offset: 0x3e68
// Size: 0x24
function function_3632f076()
{
    snd::play( "cin_lightsout_switch_cascade_03", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x5789a5e2, Offset: 0x3e98
// Size: 0x24
function function_9f617fd()
{
    snd::play( "cin_lightsout_switch_cascade_04", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xec46d958, Offset: 0x3ec8
// Size: 0x2c
function function_dbbab6cf()
{
    snd::play( "cin_lightsout_vo_fire", ( -3221, 1894, -1619 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xae78b564, Offset: 0x3f00
// Size: 0xbc
function function_ce54ff67()
{
    snd::play( "cin_lightsout_sneakyrussian_01", ( -3501, 2393, -1627 ) );
    wait 0.2;
    snd::play( "cin_lightsout_sneakyrussian_02", ( -3171, 2417, -1627 ) );
    wait 0.3;
    snd::play( "cin_lightsout_sneakyrussian_03", ( -3495, 2062, -1627 ) );
    wait 0.6;
    snd::play( "cin_lightsout_sneakyrussian_04", ( -3161, 2069, -1627 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc778dd99, Offset: 0x3fc8
// Size: 0x24
function function_f5f0b0df()
{
    snd::play( "tmp_sfx_kgb_lightsout_door", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x1738a4ce, Offset: 0x3ff8
// Size: 0x5c
function function_b6b29051()
{
    snd::play( "cin_kgb_deploygas_enemies_reload_01", ( -3149, -770, -1541 ) );
    wait 0.5;
    snd::play( "cin_kgb_deploygas_enemies_reload_02", ( -3397, -742, -1541 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x490fac9, Offset: 0x4060
// Size: 0xb4
function function_8960f1f9()
{
    snd::play( "evt_kgb_deploygas_remote_activate" );
    wait 1.5;
    level.var_f816bfbb = snd::play( "cin_kgb_deploygas_lp", ( -3250, -518, -1551 ) );
    wait 2.3;
    snd::play( "tmp_kgb_deploygas_cough_01", ( -3149, -770, -1541 ) );
    wait 3;
    snd::play( "tmp_kgb_deploygas_cough_02", ( -3397, -742, -1541 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x33dbe4c6, Offset: 0x4120
// Size: 0x1c
function function_d9da407c()
{
    snd::stop( level.var_f816bfbb );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xc539ac2c, Offset: 0x4148
// Size: 0x3c
function function_f1a71ddd()
{
    snd::play( "evt_kgb_exfil_ply_getgear" );
    snd::stop( level.var_6530ddf1, 3 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x57180a66, Offset: 0x4190
// Size: 0x24
function function_6556551a()
{
    wait 4.4;
    snd::play( "cin_kgb_exfil_rpd_charge" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x41c0
// Size: 0x4
function function_81b99645()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x746d4933, Offset: 0x41d0
// Size: 0x34
function function_d971429f()
{
    level.var_f2da7061 = snd::play( "tmp_sfx_exfil_door_banging_lp", ( -877, -194, 440 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x2d3f52b4, Offset: 0x4210
// Size: 0x1c
function function_28b20f7()
{
    snd::stop( level.var_f2da7061 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 1
// Checksum 0xdf136e09, Offset: 0x4238
// Size: 0x34
function function_d4ea305a( *player )
{
    snd::stop( level.var_bcd65e32 );
    function_2df0701e();
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x26c6af27, Offset: 0x4278
// Size: 0x16c
function function_2df0701e()
{
    snd::play( "amb_emt_klaxon_siren_02", ( 663, 725, 500 ) );
    snd::play( "amb_emt_klaxon_siren_02", ( 559, 219, 491 ) );
    snd::play( "amb_emt_klaxon_siren_02", ( 559, -16, 493 ) );
    snd::play( "amb_emt_klaxon_siren_01", ( 170, -243, 511 ) );
    snd::play( "amb_emt_klaxon_siren_01", ( -234, -234, 515 ) );
    snd::play( "amb_emt_klaxon_siren_02", ( -422, -219, 497 ) );
    snd::play( "amb_emt_klaxon_siren_01", ( -855, -164, 501 ) );
    snd::play( "amb_emt_klaxon_siren_02", ( -855, 654, 497 ) );
    snd::play( "amb_emt_klaxon_siren_01", ( -1349, -162, 517 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x1643ec72, Offset: 0x43f0
// Size: 0x34
function function_a645cbed()
{
    wait 6.2;
    snd::play( "evt_kgb_exfil_adler_grenade_pin", ( -1505, -156, 440 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xf95853ad, Offset: 0x4430
// Size: 0x2c
function function_ad8a133d()
{
    snd::play( "evt_kgb_exfil_adler_grenade_explode", ( -1505, -156, 440 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xbddafe8d, Offset: 0x4468
// Size: 0x3c
function function_f48103c7()
{
    level flag::wait_till( "sandwich_vo" );
    snd::play( "vox_cp_kgb_sandwich" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x44b0
// Size: 0x4
function function_440e3501()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x44c0
// Size: 0x4
function phone()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x44d0
// Size: 0x4
function function_3033a22c()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xbea7537d, Offset: 0x44e0
// Size: 0x24
function function_ff6e0dae()
{
    snd::play( "tmp_sfx_testtone", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xb70693e3, Offset: 0x4510
// Size: 0x24
function function_5865b09e()
{
    snd::play( "uin_cp_list_check", level.player );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 1
// Checksum 0xfe110c1d, Offset: 0x4540
// Size: 0x2c
function function_33b5f707( var_57b82bca )
{
    snd::play( var_57b82bca, level.player );
}

