#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace namespace_353d803e;

// Namespace namespace_353d803e/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x2daa9d63, Offset: 0x7e0
// Size: 0x8c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::trigger_init( &_trigger );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_353d803e/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0xb66a7acf, Offset: 0x878
// Size: 0x60
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    function_4999d3f6();
    level.player = snd::getplayerssafe()[ 0 ];
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x384f84e8, Offset: 0x8e0
// Size: 0xf4
function function_4999d3f6()
{
    plr = undefined;
    var_d4262ab9 = [];
    snd::element_init( "$default", var_d4262ab9 );
    var_73f90778 = [ [ "amb_elm_door_distant", plr, [ 15, 30 ], [ 700, 1500 ], [ -15, 15 ] ] ];
    snd::element_init( "kgb_atrium", var_73f90778 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 2, eflags: 0x4
// Checksum 0xdcc1335e, Offset: 0x9e0
// Size: 0x11a
function private function_32ab045( ent, name )
{
    switch ( name )
    {
        case #"player":
            level.player = ent;
            level.player waittill( #"death", #"disconnect" );
            level.player = undefined;
            break;
        case #"veh_escape_vehicle":
            level.veh_escape_vehicle = ent;
            ent waittill( #"death" );
            level.escape_vehicle = undefined;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69( name, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 3, eflags: 0x4
// Checksum 0x5459de3b, Offset: 0xb08
// Size: 0x18a
function private _trigger( player, trigger, *var_ec80d14b )
{
    trigger_name = snd::function_ea2f17d1( var_ec80d14b.script_ambientroom, "$default" );
    
    switch ( trigger_name )
    {
        case #"$default":
            break;
        case #"hash_2c9d4ec293d7e4e":
        case #"hash_c205d7dcba49ef1":
        case #"hash_17e91a001ef73783":
        case #"hash_19ec6f609219919d":
        case #"hash_1e6f9008500856d2":
        case #"hash_2a286a23dcd8c8e0":
        case #"hash_3b88d5b7f1e5c437":
        case #"kgb_atrium":
        case #"hash_6a021f99de04f76a":
        case #"hash_76fa75b94c82dabe":
        case #"hash_790a9135c7f2630d":
            snd::set_element( trigger, trigger_name );
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 2, eflags: 0x4
// Checksum 0xe69e1ed5, Offset: 0xca0
// Size: 0x54a
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"hash_695d2aba2d66c4b2":
            thread function_f115b891();
            break;
        case #"hash_5bf4a52b6112c7b6":
            thread function_29719418();
            break;
        case #"hash_2d11b161cdd86645":
            thread function_c3979c82();
            break;
        case #"hash_4b5a6716aab86d8e":
            thread function_4f6ed87();
            break;
        case #"hash_72fda24008633c70":
            thread function_8d03afce();
            break;
        case #"hash_3d26d1914456dcbe":
            level notify( #"hash_2bc6846f8274a4c4" );
            break;
        case #"hash_3398664455247bac":
            thread function_3c3d7227();
            break;
        case #"hash_441b6b70aae75c67":
            thread function_6186bcc6();
            break;
        case #"hash_39ef84876415aee7":
            level notify( #"hash_39ef84876415aee7" );
            break;
        case #"hash_43c1a41f59a490d6":
            thread function_4df52367();
            break;
        case #"hash_4692f2d7c81a7c95":
            thread function_1dd0dad7();
            break;
        case #"hash_645d2b3398bf399c":
            thread function_dfe73855();
            break;
        case #"hash_1a618ec692a1e9e3":
            thread function_6ad4463a();
            break;
        case #"hash_3e2a2b64b78567ad":
            thread function_6ec08763();
            break;
        case #"hash_b676297e22090ca":
            thread function_cd7f78f6();
            break;
        case #"hash_2582bdd148041a03":
            thread function_acc47dc2();
            break;
        case #"hash_810337327e9b45d":
            thread function_71130ea6();
            break;
        case #"hash_2ef69949c5586784":
            thread function_b568c231();
            break;
        case #"hash_2520e050afad6b28":
            thread function_535461fd();
            break;
        case #"hash_134c64c3689b26d8":
            thread function_b9d77749();
            break;
        case #"hash_8fb789398a122bf":
            thread function_d005c58b();
            break;
        case #"hash_13de9c8b5a620fc3":
            thread function_3555a373();
            break;
        case #"hash_326d7039d6caf74":
            thread function_a8eb2830();
            break;
        case #"hash_6c7e5d8f2665fc0c":
            thread function_7ebfde85();
            break;
        case #"hash_50da385a52268cf2":
            thread function_126bd5a3();
            break;
        case #"hash_71b18c4ea1c4cea2":
            thread function_7ae3098e();
            break;
        case #"hash_2705a705c011de47":
            thread function_a3b23b0f();
            break;
        case #"hash_2d7e4cbd73ad29fb":
            level notify( #"hash_10c1d2c0d2f43070" );
            break;
        case #"exfil_car_pullup":
            exfil_car_pullup();
            break;
        case #"exfil_car_enter":
            thread exfil_car_enter();
            thread function_1f99f8ec();
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69( msg, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 1, eflags: 0x4
// Checksum 0xd0cb0f41, Offset: 0x11f8
// Size: 0x202
function private _objective( objective )
{
    switch ( objective )
    {
        case #"kgb_ins_activation":
            break;
        case #"kgb_ins_briefing":
            thread function_6186bcc6();
            break;
        case #"kgb_ins_tutorial":
            thread function_4df52367();
            break;
        case #"kgb_ins_prepare":
            thread function_4df52367();
            break;
        case #"kgb_ins_rv":
            break;
        case #"kgb_aslt_entry":
            break;
        case #"kgb_aslt_elev_down":
            break;
        case #"kgb_aslt_bunker":
            break;
        case #"hash_7453984dc507f5e4":
            break;
        case #"kgb_aslt_vault_breach":
            break;
        case #"kgb_aslt_vault":
            break;
        case #"kgb_aslt_bunker_escape":
            break;
        case #"kgb_aslt_bunker_escape_lights_out":
            break;
        case #"kgb_aslt_bunker_escape_deploy_gas":
            break;
        case #"kgb_aslt_exfil":
            break;
        case #"kgb_aslt_exfil_escape":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:xa4>" + objective + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x1408
// Size: 0x4
function function_fef24c06()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x1418
// Size: 0x4
function function_d0a16654()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x80f724d1, Offset: 0x1428
// Size: 0x4
function function_ba262375()
{
    
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x717335a4, Offset: 0x1438
// Size: 0xbc
function function_f115b891()
{
    wait 1.2;
    snd::play( "evt_use_computer_power_on_intro", ( -252, -713, 447 ) );
    thread function_8362159();
    wait 0.79;
    snd::play( "evt_kgb_computer_beep_02" );
    snd::play( "evt_kgb_compute_data_06" );
    wait 1.39;
    snd::play( "evt_kgb_compute_data_01" );
    wait 0.9;
    snd::play( "evt_kgb_computer_beep_01" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x3a9c13ed, Offset: 0x1500
// Size: 0x64
function function_8362159()
{
    var_88e5db8 = snd::play( "evt_use_computer_hum_lp_intro", ( -252, -713, 447 ) );
    level waittill( #"hash_6d1602671b9ea1a9" );
    snd::stop( var_88e5db8, 1 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xb90d303e, Offset: 0x1570
// Size: 0x1c
function function_29719418()
{
    snd::play( "evt_kgb_computer_line_beep" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x93b4983e, Offset: 0x1598
// Size: 0x1c
function function_c3979c82()
{
    snd::play( "evt_use_computer_line_keystroke" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x2a0cca93, Offset: 0x15c0
// Size: 0x15c
function function_4f6ed87()
{
    snd::play( "evt_kgb_intro_connect_lean" );
    wait 1.75;
    snd::play( "evt_use_computer_line_keystroke" );
    wait 0.8;
    snd::play( "evt_kgb_intro_encrypt_call" );
    wait 4.3;
    var_2a71664d = snd::play( "evt_kgb_intro_encryption_static_lp" );
    level waittill( #"hash_2bc6846f8274a4c4" );
    snd::play( "evt_use_computer_line_keystroke" );
    snd::play( "evt_kgb_computer_line_beep" );
    wait 0.8;
    snd::play( "evt_kgb_intro_disconnect_call" );
    snd::stop( var_2a71664d, 0.25 );
    wait 2.3;
    var_94d28648 = snd::play( "evt_kgb_intro_phone_dialtone" );
    wait 0.75;
    snd::stop( var_94d28648, 0.2 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xf73bd7a5, Offset: 0x1728
// Size: 0x34
function function_8d03afce()
{
    wait 0.3;
    snd::play( "evt_kgb_intro_door_knock", ( -157, -624, 440 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xec383d10, Offset: 0x1768
// Size: 0x64
function function_3c3d7227()
{
    wait 4.4;
    snd::play( "evt_kgb_intro_door_open", ( -157, -624, 440 ) );
    wait 0.35;
    snd::play( "tmp_kgb_intro_door_walla", ( -157, -624, 440 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x295a9421, Offset: 0x17d8
// Size: 0x194
function function_6186bcc6()
{
    wait 3.7;
    var_36d39ded = snd::play( "tmp_walla_atrium_med_lp", ( -29, 71, 615 ) );
    var_fa7f656e = snd::play( "amb_atrium_activity_busy_lp", ( -31, 113, 638 ) );
    var_2afb62c5 = snd::play( "tmp_walla_office_light_lp_01", ( 398, -429, 440 ) );
    var_8abcf52b = snd::play( "amb_office_activity_med_lp_02", ( 359, -444, 440 ) );
    var_87ed927d = snd::play( "amb_hallway_activity_med_lp_01", ( -250, -1037, 440 ) );
    level waittill( #"hash_39ef84876415aee7" );
    wait 0.5;
    snd::stop( var_36d39ded, 2 );
    snd::stop( var_fa7f656e, 2 );
    snd::stop( var_2afb62c5, 2 );
    snd::stop( var_8abcf52b, 2 );
    snd::stop( var_87ed927d, 2 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xd706b25a, Offset: 0x1978
// Size: 0xfe
function function_4df52367()
{
    wait 2;
    var_84cdfd7b = snd::play( "tmp_walla_atrium_med_lp", ( -29, 71, 615 ) );
    var_683f77ed = snd::play( "amb_atrium_activity_busy_lp", ( -31, 113, 638 ) );
    var_8399f466 = snd::play( "tmp_walla_office_light_lp_01", ( 398, -429, 440 ) );
    var_71941716 = snd::play( "amb_office_activity_med_lp_02", ( 359, -444, 440 ) );
    var_2bf95c8e = snd::play( "amb_hallway_activity_med_lp_01", ( -250, -1037, 440 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xacbdc4bf, Offset: 0x1a80
// Size: 0xac
function function_1dd0dad7()
{
    snd::play( "evt_use_computer_plr_enter" );
    wait 2.7;
    snd::play( "evt_use_computer_power_on", ( 1957, -755, 278 ) );
    var_e7a48d36 = snd::play( "evt_use_computer_hum_lp", ( 1957, -755, 278 ) );
    level waittill( #"hash_76fee64c370b1efe" );
    snd::stop( var_e7a48d36, 1 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x61de5740, Offset: 0x1b38
// Size: 0x2c
function function_dfe73855()
{
    snd::play( "evt_frame_charkov_remap_data", ( 1957, -755, 278 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x21be4265, Offset: 0x1b70
// Size: 0x2c
function function_6ad4463a()
{
    snd::play( "evt_frame_charkov_print_evidence", ( 1316, -1147, 321 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xbf21ad87, Offset: 0x1ba8
// Size: 0x3c
function function_cd7f78f6()
{
    snd::play( "evt_frame_charkov_printer_tear" );
    wait 0.5;
    snd::play( "evt_pickup_paper_item" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x1c1e6f7d, Offset: 0x1bf0
// Size: 0x6c
function function_6ec08763()
{
    wait 1.2;
    snd::play( "evt_use_computer_power_off", ( 1957, -755, 278 ) );
    level notify( #"hash_76fee64c370b1efe" );
    wait 0.54;
    snd::play( "evt_use_computer_plr_exit" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xe8fb071, Offset: 0x1c68
// Size: 0x5c
function function_71130ea6()
{
    snd::play( "evt_obj_program_checkpoint_buzzer", ( 796, 900, 457 ) );
    wait 0.5;
    snd::play( "evt_obj_program_armory_door_open", ( 631, 935, 503 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x4e1ab390, Offset: 0x1cd0
// Size: 0x1c
function function_b568c231()
{
    snd::play( "evt_obj_program_pickup_key" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xaa0000d0, Offset: 0x1cf8
// Size: 0x7c
function function_535461fd()
{
    snd::play( "evt_obj_program_checkpoint_button" );
    wait 0.25;
    snd::play( "evt_obj_program_checkpoint_buzzer", ( 796, 900, 457 ) );
    wait 0.5;
    snd::play( "evt_obj_program_armory_door_open", ( 631, 935, 503 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xdc7c14a2, Offset: 0x1d80
// Size: 0x1c
function function_acc47dc2()
{
    snd::play( "evt_obj_program_pickup_paperwork" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x54cc070f, Offset: 0x1da8
// Size: 0x1c
function function_7ebfde85()
{
    snd::play( "evt_obj_program_pickup_cigar" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xe3236e12, Offset: 0x1dd0
// Size: 0xac
function function_b9d77749()
{
    snd::play( "evt_use_computer_plr_enter" );
    wait 0.1;
    snd::play( "evt_use_computer_power_on", ( 1157, 278, 439 ) );
    var_4fa0df74 = snd::play( "evt_use_computer_hum_lp", ( 1157, 278, 439 ) );
    level waittill( #"hash_69d1b68cd250e0e0" );
    snd::stop( var_4fa0df74, 1 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x568f65e3, Offset: 0x1e88
// Size: 0x1c
function function_d005c58b()
{
    snd::play( "evt_kgb_compute_data_03" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0xa1e1fa70, Offset: 0x1eb0
// Size: 0x64
function function_3555a373()
{
    snd::play( "evt_use_computer_power_off", ( 1157, 278, 439 ) );
    level notify( #"hash_69d1b68cd250e0e0" );
    wait 1.66;
    snd::play( "evt_use_computer_plr_exit" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x1f207e0a, Offset: 0x1f20
// Size: 0x64
function function_a8eb2830()
{
    snd::play( "evt_use_computer_power_off", ( 1157, 278, 439 ) );
    level notify( #"hash_69d1b68cd250e0e0" );
    wait 0.4;
    snd::play( "evt_use_computer_plr_exit" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x8b89be7, Offset: 0x1f90
// Size: 0x1c
function function_126bd5a3()
{
    snd::play( "evt_obj_swipe_key_swipe_direct" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x1bcd855f, Offset: 0x1fb8
// Size: 0x12c
function function_7ae3098e()
{
    snd::play( "evt_c4_elevator_alarm", ( 837, 100, 462 ) );
    wait 0.58;
    snd::play( "evt_c4_elevator_close", ( 767, 102, 430 ) );
    wait 1.42;
    snd::play( "evt_c4_elevator_start" );
    var_566fc3f1 = snd::play( "evt_c4_elevator_lp" );
    wait 15.5;
    snd::stop( var_566fc3f1, 1 );
    snd::play( "evt_c4_elevator_open", ( 767, 102, 430 ) );
    wait 0.8;
    snd::play( "evt_c4_sldr_walla_elevator_open", ( 461, 101, 467 ) );
    thread function_65a78fed();
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x4f2a6aec, Offset: 0x20f0
// Size: 0x84
function function_65a78fed()
{
    wait 2;
    function_5ea2c6e3( "cp_rus_kgb_c4_slowmo", 0.5, 1 );
    level waittill( #"hash_10c1d2c0d2f43070" );
    snd::play( "evt_c4_slowmo_stop" );
    function_ed62c9c2( "cp_rus_kgb_c4_slowmo", 1 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x130cc23b, Offset: 0x2180
// Size: 0xec
function function_a3b23b0f()
{
    snd::play( "evt_c4_explo_blast" );
    snd::play( "evt_c4_explo_debris", ( 461, 101, 467 ) );
    var_bb843c0 = snd::play( "evt_c4_slowmo_lp" );
    level waittill( #"hash_10c1d2c0d2f43070" );
    snd::stop( var_bb843c0, 1 );
    wait 1;
    snd::play( "evt_c4_sldr_walla_slowmo_done", ( 125, 100, 464 ) );
    snd::play( "evt_c4_sldr_walla_atrium_lp", ( -11, 115, 658 ) );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x6f146c45, Offset: 0x2278
// Size: 0x84
function exfil_car_pullup()
{
    snd::play( "cin_exfil_car_pull_up", level.veh_escape_vehicle );
    wait 1.35;
    level.var_c29a15da = snd::play( [ 1.2, "cin_exfil_car_idle_lp", 0.2 ], level.veh_escape_vehicle );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x7c86d794, Offset: 0x2308
// Size: 0x1c4
function exfil_car_enter()
{
    snd::play( "cin_exfil_car_enter", level.player );
    wait 2.6;
    function_5ea2c6e3( "cp_rus_kgb_exfil", 0.25, 1 );
    snd::stop( level.var_c29a15da, 0.25 );
    level.var_e8a77cb2 = snd::play( [ 0, "cin_exfil_car_idle_interior_lp", 0.25 ], level.veh_escape_vehicle );
    level waittill( #"floor_it_drive" );
    wait 2.8;
    snd::play( "cin_exfil_car_drive", level.veh_escape_vehicle );
    wait 0.6;
    snd::stop( level.var_e8a77cb2, 1 );
    wait 4;
    function_5ea2c6e3( "cp_rus_kgb_exfil_crash", 2, 1 );
    setsoundcontext( "slowmo", "true" );
    wait 5.05;
    wait 3;
    function_ed62c9c2( "cp_rus_kgb_exfil_crash", 1 );
    setsoundcontext( "slowmo", "" );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x866028a2, Offset: 0x24d8
// Size: 0x94
function function_1f99f8ec()
{
    level waittill( #"hash_2c0beb312425c5c7" );
    function_5ea2c6e3( "cp_rus_kgb_exfil_slowmo", 0.25, 1 );
    snd::play( "cin_exfil_car_adler_slowmo" );
    level waittill( #"hash_6498bbe6e48dc96d" );
    function_ed62c9c2( "cp_rus_kgb_exfil_slowmo", 0.25 );
}

// Namespace namespace_353d803e/namespace_6b5b2aa3
// Params 0
// Checksum 0x6caf013c, Offset: 0x2578
// Size: 0x48
function function_f0a1a424()
{
    while ( true )
    {
        level waittill( #"hash_33f4e556bc4883" );
        
        /#
            snd::function_3ba3cecb( "<dev string:xc7>" );
        #/
    }
}

