#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace namespace_63fe6111;

// Namespace namespace_63fe6111/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x2daa9d63, Offset: 0x490
// Size: 0x8c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::trigger_init( &_trigger );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_63fe6111/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x289972bd, Offset: 0x528
// Size: 0x84
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    function_befba10a();
    level.player = snd::getplayerssafe()[ 0 ];
    thread function_13069218();
    thread function_685d490e();
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 2, eflags: 0x4
// Checksum 0xf33ed31a, Offset: 0x5b8
// Size: 0xf2
function private function_32ab045( ent, name )
{
    switch ( name )
    {
        case #"audio_srv_heli":
            level.var_ebbd5cf8 = ent;
            thread function_f2ee7a27( ent );
            ent waittill( #"death" );
            level.var_ebbd5cf8 = undefined;
            break;
        case #"hash_65e6eae762f128ac":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69( name, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 3, eflags: 0x4
// Checksum 0x8cf25cc6, Offset: 0x6b8
// Size: 0x32a
function private _trigger( player, trigger, *var_ec80d14b )
{
    trigger_name = snd::function_ea2f17d1( var_ec80d14b.script_ambientroom, "$default" );
    
    switch ( trigger_name )
    {
        case #"$default":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_mountainside_half_open":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_sat_room_half_open":
            thread function_5e62b956();
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_dark_hall_tight":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_dark_hall_tight_wind":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_dark_hall_med_wind":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_dark_hall_stairwell":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_dark_hall_conference_room":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_dark_hall_office_room":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_half_open_tight":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_half_open_med":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_destroyed_room_open":
            snd::set_element( trigger, trigger_name );
            break;
        case #"yam_server_overlook_room":
            snd::set_element( trigger, trigger_name );
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 2, eflags: 0x4
// Checksum 0xea4fc4a7, Offset: 0x9f0
// Size: 0xc2
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"hash_42ab199f7f0a951a":
            thread function_d27488d();
            break;
        case #"hash_65e6eae762f128ac":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69( msg, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 1, eflags: 0x4
// Checksum 0x603ed6a7, Offset: 0xac0
// Size: 0x9a
function private _objective( objective )
{
    switch ( objective )
    {
        case #"hash_65e6eae762f128ac":
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

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 0
// Checksum 0x26933707, Offset: 0xb68
// Size: 0x22dc
function function_befba10a()
{
    plr = undefined;
    var_58602358 = [ [ "emt_elm_ext_wind_gusts_whistle", plr, [ 5, 8 ], [ 1, 1 ] ], [ "emt_elm_ext_wind_gusts_buffet_lr", plr, [ 1, 2 ], [ 1, 1 ] ] ];
    snd::element_init( "$default", var_58602358 );
    yam_mountainside_half_open = [ [ "emt_elm_int_dirt_debris_close", plr, [ 4, 6 ], [ 80, 400 ] ], [ "emt_elm_int_dirt_debris_dist", plr, [ 2, 6 ], [ 100, 600 ] ], [ "emt_elm_int_mtl_creak_close", plr, [ 2, 4 ], [ 100, 500 ] ], [ "emt_elm_metal_stress_creak_close", plr, [ 2, 6 ], [ 100, 300 ] ], [ "emt_elm_metal_stress_close", plr, [ 2, 4 ], [ 100, 200 ] ] ];
    snd::element_init( "yam_mountainside_half_open", yam_mountainside_half_open );
    yam_sat_room_half_open = [ [ "emt_elm_int_dirt_debris_close", plr, [ 4, 6 ], [ 80, 500 ] ], [ "emt_elm_int_dirt_debris_dist", plr, [ 2, 6 ], [ 100, 600 ] ], [ "emt_elm_int_mtl_creak", plr, [ 2, 6 ], [ 100, 600 ] ], [ "emt_elm_int_mtl_creak_close", plr, [ 4, 6 ], [ 100, 600 ] ], [ "emt_elm_int_mtl_stress", plr, [ 2, 4 ], [ 300, 800 ] ] ];
    snd::element_init( "yam_sat_room_half_open", yam_sat_room_half_open );
    yam_dark_hall_tight = [ [ "emt_elm_int_mtl_groan", plr, [ 3, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock", plr, [ 4, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock_rattle", plr, [ 3, 5 ], [ 200, 500 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 2, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_stress_tings", plr, [ 3, 5 ], [ 100, 700 ] ] ];
    snd::element_init( "yam_dark_hall_tight", yam_dark_hall_tight );
    yam_dark_hall_tight_wind = [ [ "emt_elm_int_mtl_groan", plr, [ 3, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock", plr, [ 4, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock_rattle", plr, [ 3, 5 ], [ 200, 500 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 2, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_stress_tings", plr, [ 3, 5 ], [ 100, 700 ] ] ];
    snd::element_init( "yam_dark_hall_tight_wind", yam_dark_hall_tight_wind );
    yam_dark_hall_med_wind = [ [ "emt_elm_int_mtl_groan", plr, [ 3, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock", plr, [ 4, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock_rattle", plr, [ 3, 5 ], [ 200, 500 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 2, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_stress_tings", plr, [ 3, 5 ], [ 100, 700 ] ] ];
    snd::element_init( "yam_dark_hall_med_wind", yam_dark_hall_med_wind );
    yam_dark_hall_stairwell = [ [ "emt_elm_int_mtl_groan", plr, [ 3, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock", plr, [ 2, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock_rattle", plr, [ 3, 5 ], [ 200, 500 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 2, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_stress_tings", plr, [ 5, 8 ], [ 100, 700 ] ] ];
    snd::element_init( "yam_dark_hall_stairwell", yam_dark_hall_stairwell );
    yam_dark_hall_conference_room = [ [ "emt_elm_int_mtl_groan", plr, [ 3, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock", plr, [ 4, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock_rattle", plr, [ 3, 5 ], [ 200, 500 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 2, 6 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_stress_tings", plr, [ 5, 8 ], [ 100, 700 ] ] ];
    snd::element_init( "yam_dark_hall_conference_room", yam_dark_hall_conference_room );
    yam_dark_hall_office_room = [ [ "emt_elm_int_dirt_debris_close", plr, [ 4, 6 ], [ 80, 500 ] ], [ "emt_elm_int_dirt_debris_dist", plr, [ 4, 6 ], [ 100, 500 ] ], [ "emt_elm_int_mtl_creak", plr, [ 4, 6 ], [ 100, 500 ] ], [ "emt_elm_int_mtl_creak_close", plr, [ 5, 8 ], [ 200, 500 ] ], [ "emt_elm_int_mtl_stress", plr, [ 5, 8 ], [ 300, 800 ] ], [ "emt_elm_int_mtl_groan", plr, [ 4, 8 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock", plr, [ 5, 9 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 4, 6 ], [ 100, 300 ] ] ];
    snd::element_init( "yam_dark_hall_office_room", yam_dark_hall_office_room );
    yam_half_open_tight = [ [ "emt_elm_int_dirt_debris_close", plr, [ 3, 6 ], [ 80, 500 ] ], [ "emt_elm_int_dirt_debris_dist", plr, [ 3, 6 ], [ 100, 500 ] ], [ "emt_elm_int_mtl_creak", plr, [ 4, 8 ], [ 100, 500 ] ], [ "emt_elm_int_mtl_stress", plr, [ 5, 8 ], [ 300, 800 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 4, 6 ], [ 200, 300 ] ], [ "emt_elm_metal_stress_creak_close", plr, [ 5, 7 ], [ 300, 500 ] ], [ "emt_elm_metal_stress_close", plr, [ 4, 6 ], [ 300, 500 ] ] ];
    snd::element_init( "yam_half_open_tight", yam_half_open_tight );
    yam_half_open_med = [ [ "emt_elm_int_dirt_debris_close", plr, [ 4, 6 ], [ 80, 500 ] ], [ "emt_elm_int_dirt_debris_dist", plr, [ 4, 6 ], [ 100, 500 ] ], [ "emt_elm_int_mtl_creak", plr, [ 4, 6 ], [ 100, 500 ] ], [ "emt_elm_int_mtl_creak_close", plr, [ 5, 8 ], [ 200, 500 ] ], [ "emt_elm_int_mtl_stress", plr, [ 5, 8 ], [ 300, 800 ] ], [ "emt_elm_int_mtl_groan", plr, [ 4, 8 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock", plr, [ 5, 9 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 4, 6 ], [ 100, 300 ] ] ];
    snd::element_init( "yam_half_open_med", yam_half_open_med );
    yam_server_overlook_room = [ [ "emt_elm_int_dirt_debris_close", plr, [ 4, 6 ], [ 80, 500 ] ], [ "emt_elm_int_dirt_debris_dist", plr, [ 4, 6 ], [ 100, 500 ] ], [ "emt_elm_int_mtl_creak", plr, [ 4, 6 ], [ 100, 500 ] ], [ "emt_elm_int_mtl_creak_close", plr, [ 5, 8 ], [ 200, 500 ] ], [ "emt_elm_int_mtl_stress", plr, [ 5, 8 ], [ 300, 800 ] ], [ "emt_elm_int_mtl_groan", plr, [ 4, 8 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_knock", plr, [ 5, 9 ], [ 100, 300 ] ], [ "emt_elm_int_mtl_stress_creak", plr, [ 4, 6 ], [ 100, 300 ] ] ];
    snd::element_init( "yam_server_overlook_room", yam_server_overlook_room );
    yam_destroyed_room_open = [ [ "emt_elm_int_dirt_debris_close", plr, [ 4, 6 ], [ 100, 500 ] ], [ "emt_elm_int_dirt_debris_dist", plr, [ 4, 6 ], [ 100, 500 ] ], [ "emt_elm_metal_stress_creak_close", plr, [ 5, 7 ], [ 100, 300 ] ], [ "emt_elm_metal_stress_close", plr, [ 4, 8 ], [ 100, 300 ] ] ];
    snd::element_init( "yam_destroyed_room_open", yam_destroyed_room_open );
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 0
// Checksum 0xa2043155, Offset: 0x2e50
// Size: 0x5c
function function_13069218()
{
    level.var_b4c2cf5b = snd::emitter( "emt_metal_creaks_canyon", [ ( 415, 2481, 2874 ) ], [ 8.5, 12 ] );
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 0
// Checksum 0x8838cf6a, Offset: 0x2eb8
// Size: 0x24
function function_5e62b956()
{
    snd::stop( level.var_b4c2cf5b, 2 );
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 0
// Checksum 0xe65592f0, Offset: 0x2ee8
// Size: 0x94
function function_685d490e()
{
    snd::play( "emt_frozen_waterfall", [ ( -4771, 5645, 2765 ) ] );
    snd::play( "emt_frozen_waterfall", [ ( -4644, 5611, 2852 ) ] );
    snd::play( "emt_frozen_waterfall", [ ( -4992, 5564, 2852 ) ] );
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 0
// Checksum 0xc9615c6b, Offset: 0x2f88
// Size: 0x44
function function_d27488d()
{
    wait 1.4;
    snd::play( "evt_yam_zipline_pre_break" );
    wait 4;
    snd::play( "evt_yam_zipline_break_lr" );
}

// Namespace namespace_63fe6111/namespace_63fe6111
// Params 1
// Checksum 0x703fedad, Offset: 0x2fd8
// Size: 0x18c
function function_f2ee7a27( ent )
{
    level waittill( #"hash_6dde5f256f8081a8" );
    snd::play( [ 0, "veh_yam_wz_hind_far", 0.25 ], ent );
    snd::play( [ 0, "veh_yam_wz_hind_mid", 0.25 ], ent );
    snd::play( [ 0, "veh_yam_wz_hind_close", 0.25 ], ent );
    snd::play( [ 0, "veh_yam_wz_hind_turbine", 0.25 ], ent );
    snd::play( [ 0, "veh_yam_wz_hind_lfe", 0.25 ], ent );
}

