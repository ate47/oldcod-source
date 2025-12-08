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

#namespace namespace_b61bbd82;

// Namespace namespace_b61bbd82/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x97c78f6e, Offset: 0x6e8
// Size: 0x8c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::trigger_init( &_trigger );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_b61bbd82/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x48ddb4b2, Offset: 0x780
// Size: 0xbc
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    var_d4b173d0 = undefined;
    
    while ( !isdefined( var_d4b173d0 ) )
    {
        var_d4b173d0 = getent( 0, "audio_cricket_trigger", "targetname" );
        waitframe( 1 );
    }
    
    var_d4b173d0 thread function_91836779( level.player );
    function_befba10a();
    thread function_bb691cfa();
    thread function_f958a41b();
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 2, eflags: 0x4
// Checksum 0xe48c795e, Offset: 0x848
// Size: 0x3b2
function private function_32ab045( ent, name )
{
    switch ( name )
    {
        case #"evt_audio_vig_forest_flyby":
            vh_heli = ent;
            thread function_a5ecad0d( ent );
            ent waittill( #"death" );
            vh_heli = undefined;
            break;
        case #"audio_side_door_apc_go":
            var_127d9a14 = ent;
            thread audio_side_door_apc_go( ent );
            ent waittill( #"death" );
            level notify( #"hash_74a73f5954822211" );
            var_f712b673 = undefined;
            break;
        case #"audio_side_door_apc_stop":
            var_127d9a14 = ent;
            thread audio_side_door_apc_stop( ent );
            ent waittill( #"death" );
            level notify( #"hash_74a73f5954822211" );
            var_f712b673 = undefined;
            break;
        case #"evt_audio_main_street_truck_drive_up":
            var_4e65d853 = ent;
            thread function_db555295( ent );
            ent waittill( #"death" );
            var_4e65d853 = undefined;
            break;
        case #"audio_motorpool_truck_01":
            var_caac7c01 = ent;
            thread function_88dc1a44();
            ent waittill( #"death" );
            var_caac7c01 = undefined;
            break;
        case #"audio_motorpool_truck_02":
            var_73da4e5e = ent;
            thread function_806e052f();
            ent waittill( #"death" );
            var_73da4e5e = undefined;
            break;
        case #"evt_tower_elevator_audio":
            var_d5535d9a = ent;
            thread function_845469bf( ent );
            ent waittill( #"death" );
            var_d5535d9a = undefined;
            break;
        case #"evt_tower_elevator_up_audio":
            var_d5535d9a = ent;
            thread function_1a0fd7ea( ent );
            ent waittill( #"death" );
            var_d5535d9a = undefined;
            break;
        case #"evt_ai_open_terminal_door_audio":
            e_terminal_entrance_door_org = ent;
            thread evt_ai_open_terminal_door_audio( ent );
            ent waittill( #"death" );
            e_terminal_entrance_door_org = undefined;
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69( name, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 3, eflags: 0x4
// Checksum 0xfea7acf, Offset: 0xc08
// Size: 0x1ea
function private _trigger( player, trigger, *var_ec80d14b )
{
    trigger_name = snd::function_ea2f17d1( var_ec80d14b.script_ambientroom, "$default" );
    
    switch ( trigger_name )
    {
        case #"$default":
            snd::set_element( trigger, trigger_name );
            break;
        case #"hash_f14cb3bf30d26a3":
            thread function_bda0d0f7();
            break;
        case #"hash_2ef3e4f4d4afaed3":
            level flag::set( "exterior_sounds_cleanup" );
            break;
        case #"facility_tunnels":
            snd::set_element( trigger, trigger_name );
            break;
        case #"arcade":
            snd::set_element( trigger, trigger_name );
            thread function_329bafc9();
            break;
        case #"video_store":
            level notify( #"hash_cead01409a49817" );
            level notify( #"hash_c67feccc2a013c6" );
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 2, eflags: 0x4
// Checksum 0xc6079ea4, Offset: 0xe00
// Size: 0x25a
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"flg_audio_perimeter_heli_spawned":
            level notify( #"perimeter_heli_spawned" );
            break;
        case #"audio_tunnels_alarm":
            thread function_545dfe3b();
            break;
        case #"flg_arcade_audio_emitters_start":
            thread function_7547ed65();
            break;
        case #"flg_heli_rappel_alarm":
            thread evt_heli_rappel_alarm();
            break;
        case #"flg_audio_truck_engine_idle_stop":
            level notify( #"flg_audio_truck_engine_idle_stop" );
            break;
        case #"flg_main_street_elevator_reached_ground":
            level notify( #"flg_main_street_elevator_reached_ground" );
            break;
        case #"flg_control_tower_elevator_at_top":
            level notify( #"flg_control_tower_elevator_at_top" );
            break;
        case #"audio_motor_pool_rollup_door":
            thread function_c8cd1f84();
            break;
        case #"flg_audio_apc_ride_town_square_start":
            thread function_85f15df8();
            break;
        case #"flg_audio_apc_ride_mall_transition_start":
            thread function_4c2bbef4();
            break;
        case #"outro_movie":
            level notify( #"hash_6163ece11287ae21" );
            audio::snd_set_snapshot( "cmn_duck_all_but_movie" );
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69( msg, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1, eflags: 0x4
// Checksum 0xc2295fe2, Offset: 0x1068
// Size: 0x29a
function private _objective( objective )
{
    switch ( objective )
    {
        case #"forest":
            thread function_7ecccb98();
            break;
        case #"perimeter":
            thread function_bda0d0f7();
            thread function_7ecccb98();
            break;
        case #"helipad":
            thread function_bda0d0f7();
            thread function_7ecccb98();
            break;
        case #"side_door":
            break;
        case #"lockpick":
            break;
        case #"tunnels":
            break;
        case #"arcade":
            break;
        case #"video_store":
            break;
        case #"main_street":
            thread function_55f97b00();
            break;
        case #"elevator_fight":
            thread function_55f97b00();
            break;
        case #"elevator":
            break;
        case #"terminal":
            break;
        case #"observation":
            break;
        case #"Facades":
            break;
        case #"Rooftops":
            break;
        case #"storage":
            break;
        case #"motor_pool":
            break;
        case #"apc_turret":
            break;
        case #"apc_townsquare":
            break;
        case #"apc_mall":
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

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0xb9f7f207, Offset: 0x1310
// Size: 0xb4
function function_91836779( player )
{
    trigger = self;
    
    while ( true )
    {
        waitresult = trigger waittill( #"trigger" );
        trigger_player = waitresult.activator;
        
        if ( trigger_player == player )
        {
            level thread function_7a945b02();
            level thread function_123c2ccb();
            level thread function_8ce67015();
            break;
        }
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 4, eflags: 0x4
// Checksum 0x54621993, Offset: 0x13d0
// Size: 0x184
function private function_e098a17a( alias, v_position, var_7423a2af, var_ed8c72a9 )
{
    level.player endon( #"death" );
    assert( isarray( var_7423a2af ) );
    assert( isarray( var_ed8c72a9 ) );
    
    while ( true )
    {
        var_3b71b6c3 = array::random( var_7423a2af );
        
        for ( i = 0; i < var_3b71b6c3 ; i++ )
        {
            var_c576baf0 = snd::play( alias, v_position );
            snd::function_2fdc4fb( var_c576baf0 );
            wait randomfloatrange( 0, 0.7 );
        }
        
        wait randomfloatrange( var_ed8c72a9[ 0 ], var_ed8c72a9[ 1 ] );
        
        if ( level flag::get( "flg_cricket_stop" ) == 1 )
        {
            break;
        }
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x22f012fa, Offset: 0x1560
// Size: 0x106
function function_37294a47( var_47544845 )
{
    self endon( #"death" );
    
    while ( true )
    {
        var_2564fee0 = var_47544845.origin + anglestoright( var_47544845.angles ) * 12;
        var_2564fee0 += anglestoup( var_47544845.angles ) * 10;
        self.origin = var_2564fee0;
        
        /#
            debugstar( var_47544845.origin, 5, ( 1, 0, 0 ) );
            debugstar( var_2564fee0, 5 );
        #/
        
        if ( var_47544845.health <= 0 )
        {
            self delete();
        }
        
        waitframe( 5 );
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0xebb01d10, Offset: 0x1670
// Size: 0x25c
function function_befba10a()
{
    plr = undefined;
    var_58602358 = [];
    snd::element_init( "$default", var_58602358 );
    facility_tunnels = [ [ "emt_metal_deep_stress", plr, [ 8, 11 ], [ 325, 500 ] ], [ "emt_metal_dist_knock", plr, [ 9, 11 ], [ 425, 600 ] ], [ "emt_metal_knock_light", plr, [ 10, 12 ], [ 325, 500 ] ], [ "emt_elm_int_mtl_knock", plr, [ 8, 11 ], [ 325, 500 ] ] ];
    snd::element_init( "facility_tunnels", facility_tunnels );
    arcade = [];
    snd::element_init( "arcade", arcade );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x7acd3755, Offset: 0x18d8
// Size: 0xe8
function function_7ecccb98()
{
    if ( level flag::get( "flg_audio_distant_thunder_playing" ) == 1 )
    {
        return;
    }
    
    var_7ecccb98 = snd::emitter( "emt_amerika_distant_thunder", [ ( -1340, 1663, 1259 ) ], [ 25, 40 ] );
    
    if ( isdefined( var_7ecccb98 ) )
    {
        level flag::set( "flg_audio_distant_thunder_playing" );
        level flag::wait_till( "exterior_sounds_cleanup" );
        var_7ecccb98 notify( #"snd_emitter_stop" );
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x87cb3205, Offset: 0x19c8
// Size: 0x44
function function_bb691cfa()
{
    level waittill( #"hash_7aaf15b1dddd49ef" );
    snd::play( "evt_forest_intro_heli_dist_3d", ( -6553, -6179, 558 ) );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x7edd21c3, Offset: 0x1a18
// Size: 0x74
function function_a5ecad0d( ent )
{
    audio::snd_set_snapshot( "cp_rus_amerika_heli_intro" );
    var_51b965c9 = snd::play( "evt_forest_intro_heli_02", ent );
    level waittill( #"perimeter_heli_spawned" );
    audio::snd_set_snapshot( "" );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0xc9e7127a, Offset: 0x1a98
// Size: 0x5ec
function function_7a945b02()
{
    level.player endon( #"death" );
    
    if ( level flag::get( "flg_audio_forest_crickets_playing" ) == 1 )
    {
        return;
    }
    
    if ( isdefined( level.player ) )
    {
        level flag::set( "flg_audio_forest_crickets_playing" );
        level waittill( #"hash_63d9c03656bf9e3f" );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -6555, -5873, 380 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -6102, -5014, 430 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -6825, -6884, 450 ), [ 1, 2, 3, 5 ], [ 3, 11 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -6244, -5250, 430 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -6020, -4754, 430 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -6394, -6410, 380 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -6421, -5630, 430 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -6586, -6211, 380 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -6366, -5182, 430 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -5661, -4605, 410 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -6413, -6987, 450 ), [ 1 ], [ 7, 15 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -5728, -4702, 425 ), [ 1 ], [ 7, 15 ] );
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x93f4fda5, Offset: 0x2090
// Size: 0x1274
function function_123c2ccb()
{
    level.player endon( #"death" );
    
    if ( level flag::get( "flg_audio_perimeter_crickets_playing" ) == 1 )
    {
        return;
    }
    
    if ( isdefined( level.player ) )
    {
        level flag::set( "flg_audio_perimeter_crickets_playing" );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -4635, -4384, 80 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -4394, -4959, 80 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -4394, -4959, 80 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -5056, -2845, 54 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -4744, -4120, 80 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -5046, -4564, 149 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -5318, -3243, 65 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -5318, -3243, 65 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -5287, -2446, 30 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -4959, -3817, 80 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -4335, -4356, 80 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -3705, -5571, 80 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -5782, -3313, 65 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -5408, -1983, 40 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -5368, -4078, 102 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -4097, -4657, 80 ), [ 1, 2, 3, 5 ], [ 4, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -2774, -5801, 80 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -5827, -2161, 30 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -4706, -4254, 80 ), [ 1 ], [ 10, 20 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -5093, -3124, 60 ), [ 1 ], [ 10, 20 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -5056, -1784, 20 ), [ 1 ], [ 10, 20 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -3761, -4116, 60 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -2588, -4229, 60 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -1916, -4827, 60 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -4280, -4061, 60 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -2898, -3539, 20 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -3291, -4656, 60 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -2117, -3911, 50 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -3399, -3899, 60 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -2500, -3787, 60 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -2146, -4409, 60 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -3506, -4323, 20 ), [ 1 ], [ 7, 15 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -4793, -2026, 20 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -4134, -3660, 20 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -4249, -2231, 20 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -4143, -2638, 20 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -3940, -3800, 20 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -4377, -2687, 20 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -4140, -2267, 20 ), [ 1 ], [ 7, 15 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -4646, -2312, 20 ), [ 1 ], [ 10, 20 ] );
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x431712c3, Offset: 0x3310
// Size: 0xc4
function function_bda0d0f7()
{
    if ( level flag::get( "flg_audio_heli_idle_playing" ) == 1 )
    {
        return;
    }
    
    var_98f7f290 = snd::play( "emt_helicopter_large_idle", ( -2925, -1952, 199 ) );
    level flag::set( "flg_audio_heli_idle_playing" );
    level flag::wait_till( "exterior_sounds_cleanup" );
    snd::stop( var_98f7f290, 1 );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x3936393b, Offset: 0x33e0
// Size: 0xcc
function audio_side_door_apc_go( ent )
{
    snd::stop( level.var_fcf043d9, 2 );
    snd::play( "evt_veh_apc_drive_close_accelerate", ent );
    level.var_6cb78143 = snd::play( [ 0, "evt_veh_apc_drive_close_lp", 4 ], ent );
    level waittill( #"hash_74a73f5954822211" );
    snd::stop( level.var_6cb78143, 5 );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x1874bedd, Offset: 0x34b8
// Size: 0xcc
function audio_side_door_apc_stop( ent )
{
    snd::stop( level.var_6cb78143, 2 );
    snd::play( "evt_veh_apc_drive_close_decelerate", ent );
    level.var_fcf043d9 = snd::play( [ 0, "evt_veh_apc_drive_close_idle_lp", 1.5 ], ent );
    level waittill( #"hash_74a73f5954822211" );
    snd::stop( level.var_fcf043d9, 5 );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x1a58352, Offset: 0x3590
// Size: 0x8c4
function function_8ce67015()
{
    level.player endon( #"death" );
    
    if ( level flag::get( "flg_audio_sidedoor_crickets_playing" ) == 1 )
    {
        return;
    }
    
    if ( isdefined( level.player ) )
    {
        level flag::set( "flg_audio_sidedoor_crickets_playing" );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -654, -1226, 10 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -4071, -524, 20 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_01", ( -2616, 46, 20 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -1165, -750, 10 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -3984, -783, 10 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -1951, -56, 10 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_02", ( -76, 101, 10 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( 302, -1206, 10 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -3460, -332, 10 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -2451, -341, 10 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_03", ( -973, 84, 10 ), [ 1, 2, 3, 5 ], [ 2, 10 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -95, -1203, 10 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -2919, -375, 10 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( -670, -102, 10 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_single_04", ( 144, -173, 10 ), [ 1, 2, 3, 5 ], [ 2, 12 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -711, -748, 10 ), [ 1 ], [ 20, 30 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -3313, 41, 10 ), [ 1 ], [ 15, 25 ] );
        self thread function_e098a17a( "emt_cricket_chirp_pattern_01", ( -1182, -344, 10 ), [ 1 ], [ 15, 25 ] );
        level flag::wait_till( "exterior_sounds_cleanup" );
        level flag::set( "flg_cricket_stop" );
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0xacc42ebd, Offset: 0x3e60
// Size: 0x24
function function_545dfe3b()
{
    wait 0.2;
    snd::play( "evt_lockpick_room_alarm_lr" );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x913183b5, Offset: 0x3e90
// Size: 0x4b0
function function_7547ed65()
{
    var_941e5193 = [ "emt_arcade_game_01", "emt_arcade_game_02", "emt_arcade_game_03", "emt_arcade_game_04", "emt_pinball_idle_01", "emt_pinball_idle_02" ];
    var_355193d1 = [ [ ( 1677, 1636, -264 ), ( 1913, 1556, -264 ), ( 1930, 1848, -264 ), ( 2021, 1777, -264 ), ( 1849, 1327, -264 ), ( 2272, 1417, -264 ) ], [ ( 1695, 1465, -264 ), ( 2013, 1597, -264 ), ( 1757, 1719, -264 ), ( 1819, 1667, -264 ), ( 1512, 1351, -264 ), ( 1582, 1467, -264 ), ( 1600, 1736, -264 ), ( 2104, 1676, -264 ) ], [ ( 1787, 1434, -264 ), ( 1939, 1624, -264 ), ( 1937, 1739, -264 ), ( 1790, 1711, -264 ), ( 2262, 1538, -264 ), ( 1583, 1545, -264 ) ], [ ( 1686, 1713, -264 ), ( 1684, 1539, -264 ), ( 1921, 1322, -264 ), ( 1824, 1481, -264 ), ( 1949, 1538, -264 ), ( 1849, 1644, -264 ), ( 2265, 1462, -264 ), ( 2011, 1853, -264 ) ], [ ( 1805, 1826, -256 ) ], [ ( 1734, 1834, -256 ) ] ];
    level.var_28f2e8d6 = [];
    level waittill( #"hash_3e20e66e1130f5e0" );
    thread function_fdeb5ec6();
    wait 0.5;
    
    foreach ( index, alias in var_941e5193 )
    {
        level.var_28f2e8d6[ index ] = snd::emitter( alias, var_355193d1[ index ], [ 0, 2, 5, 5 ] );
    }
    
    level waittill( #"hash_cead01409a49817" );
    level notify( #"snd_emitter_stop" );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x4d3521a5, Offset: 0x4348
// Size: 0x74
function function_fdeb5ec6()
{
    wait 0.5;
    var_6edcb89c = snd::play( "emt_arcade_door_blend", ( 1556, 1831, -216 ) );
    level waittill( #"hash_cead01409a49817" );
    snd::stop( var_6edcb89c, 0.25 );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x567e416c, Offset: 0x43c8
// Size: 0xc2
function evt_heli_rappel_alarm()
{
    snd::play( "evt_heli_rappel_alarm", ( 2914, 2314, 64 ) );
    wait 2;
    snd::play( "evt_heli_rappel_alarm", ( 2914, 2314, 64 ) );
    wait 2;
    snd::play( "evt_heli_rappel_alarm", ( 2914, 2314, 64 ) );
    wait 2;
    snd::play( "evt_heli_rappel_alarm", ( 2914, 2314, 64 ) );
    wait 2;
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0xd5d7ea12, Offset: 0x4498
// Size: 0x8c
function function_329bafc9()
{
    if ( flag::get( "moving_targets_ducked" ) == 1 )
    {
        return;
    }
    
    flag::set( "moving_targets_ducked" );
    audio::snd_set_snapshot( "cp_rus_amerika_moving_targets" );
    level waittill( #"hash_c67feccc2a013c6" );
    audio::snd_set_snapshot( "" );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x74316e47, Offset: 0x4530
// Size: 0xb4
function function_db555295( ent )
{
    wait 0.5;
    snd::play( "evt_enemy_truck_drive_up", ent );
    var_76a03a09 = snd::play( [ 2.1, "evt_enemy_truck_drive_up_idle", 0.25 ], ent );
    level waittill( #"flg_audio_truck_engine_idle_stop" );
    snd::stop( var_76a03a09, 0.25 );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0xb4cf0f16, Offset: 0x45f0
// Size: 0x120
function function_55f97b00()
{
    if ( level flag::get( "flg_audio_tv_store_tvs" ) == 1 )
    {
        return;
    }
    
    level flag::set( "flg_audio_tv_store_tvs" );
    var_136b3fde = getdynentarray( "audio_tv_store_tv_dyent" );
    
    foreach ( var_21f452ad in var_136b3fde )
    {
        var_e9853265 = snd::play( "dst_amk_tv_lp", var_21f452ad.origin );
        var_e9853265 thread function_37294a47( var_21f452ad );
    }
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x2017bec8, Offset: 0x4718
// Size: 0xb4
function function_845469bf( ent )
{
    snd::play( "evt_tower_elevator_start_lr", ent );
    var_12c17d45 = snd::play( [ 0.5, "evt_tower_elevator_lp_lr" ], ent );
    level waittill( #"flg_main_street_elevator_reached_ground" );
    snd::stop( var_12c17d45, 0.5 );
    snd::play( "evt_tower_elevator_stop_lr", ent );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0xfd118a6e, Offset: 0x47d8
// Size: 0xbc
function function_1a0fd7ea( ent )
{
    snd::play( "evt_tower_elevator_start_lr", ent );
    var_12c17d45 = snd::play( [ 0.5, "evt_tower_elevator_lp_lr" ], ent );
    level waittill( #"flg_control_tower_elevator_at_top" );
    wait 4.65;
    snd::stop( var_12c17d45, 0.5 );
    snd::play( "evt_tower_elevator_stop_lr", ent );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x8cac1530, Offset: 0x48a0
// Size: 0x24
function evt_ai_open_terminal_door_audio( ent )
{
    snd::play( "evt_ai_open_terminal_door", ent );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0xfa3f65e5, Offset: 0x48d0
// Size: 0x2c
function function_c8cd1f84()
{
    snd::play( "evt_motor_pool_rollup_door", ( 9674, 1318, -403 ) );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x683bf49d, Offset: 0x4908
// Size: 0x24
function function_88dc1a44( ent )
{
    snd::play( "evt_enemy_jeep_01_drive_up", ent );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 1
// Checksum 0x795802d5, Offset: 0x4938
// Size: 0x24
function function_806e052f( ent )
{
    snd::play( "evt_enemy_jeep_02_drive_up", ent );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x1c828647, Offset: 0x4968
// Size: 0x84
function function_f958a41b()
{
    level waittill( #"hash_3ebf6e122c1624b6" );
    
    if ( level flag::get( "flg_audio_apc_started" ) == 1 )
    {
        return;
    }
    
    level flag::set( "flg_audio_apc_started" );
    wait 2;
    snd::play( "veh_apc_ride_full" );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0xb99a0642, Offset: 0x49f8
// Size: 0x8c
function function_85f15df8()
{
    if ( level flag::get( "flg_audio_apc_started" ) == 1 )
    {
        return;
    }
    
    level flag::set( "flg_audio_apc_started" );
    snd::play( [ 0, "veh_apc_ride_courtyard", 0.5 ] );
}

// Namespace namespace_b61bbd82/namespace_42ffcf38
// Params 0
// Checksum 0x79382689, Offset: 0x4a90
// Size: 0x8c
function function_4c2bbef4()
{
    if ( level flag::get( "flg_audio_apc_started" ) == 1 )
    {
        return;
    }
    
    level flag::set( "flg_audio_apc_started" );
    snd::play( [ 0, "veh_apc_ride_mall", 0.5 ] );
}

