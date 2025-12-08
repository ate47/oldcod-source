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

#namespace namespace_a052577e;

// Namespace namespace_a052577e/level_preinit
// Params 1, eflags: 0x40
// Checksum 0xce59c637, Offset: 0x518
// Size: 0x8c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::trigger_init( &_trigger );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_a052577e/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0xe9b906d1, Offset: 0x5b0
// Size: 0x84
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    level.var_936dc3f3 = 0;
    snd::wait_init();
    snd::waitforplayers();
    thread function_5409e18e();
    level.player = snd::getplayerssafe()[ 0 ];
    level.var_cffe5f6f = &function_9c9fad4e;
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1, eflags: 0x4
// Checksum 0xb29f4ec9, Offset: 0x640
// Size: 0x162
function private _objective( objective )
{
    switch ( objective )
    {
        case #"tkdn_raid_bar":
            break;
        case #"tkdn_raid_gearup":
            break;
        case #"tkdn_raid_apt":
            break;
        case #"tkdn_raid_capture":
            break;
        case #"hash_7db5c2bb92c102ae":
            break;
        case #"tkdn_af_intro":
            break;
        case #"tkdn_af_hill":
            break;
        case #"tkdn_af_tarmac":
            break;
        case #"tkdn_af_chase":
            break;
        case #"tkdn_af_skid":
            break;
        case #"tkdn_af_wreck":
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

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 2, eflags: 0x4
// Checksum 0x5d21b3c7, Offset: 0x7b0
// Size: 0x48a
function private function_32ab045( ent, name )
{
    switch ( name )
    {
        case #"plr_chase_veh":
            level.plr_chase_veh = ent;
            ent waittill( #"death" );
            level.plr_chase_veh = undefined;
            break;
        case #"plr_chase_veh2":
            level.plr_chase_veh2 = ent;
            ent waittill( #"death" );
            level.plr_chase_veh2 = undefined;
            break;
        case #"hash_27056af31f83775d":
            level.var_d6277cd5 = snd::function_4b879845( level.var_d6277cd5, ent );
            ent waittill( #"death" );
            level.var_d6277cd5 = snd::varrayremove( level.var_d6277cd5, ent );
            break;
        case #"plr_rc_car":
            level.plr_rc_car = ent;
            ent waittill( #"death" );
            level.plr_rc_car = undefined;
            break;
        case #"enemy_chase_veh_tires":
            level.enemy_chase_veh_tires = snd::function_4b879845( level.enemy_chase_veh_tires, ent );
            ent waittill( #"death" );
            level.enemy_chase_veh_tires = snd::varrayremove( level.enemy_chase_veh_tires, ent );
            break;
        case #"hash_fa033e98386a767":
            level.var_b4ceccbd = snd::function_4b879845( level.var_b4ceccbd, ent );
            ent waittill( #"death" );
            level.var_b4ceccbd = snd::varrayremove( level.var_b4ceccbd, ent );
            break;
        case #"cargo_plane":
            level.var_a7c3bf6d = ent;
            ent waittill( #"death" );
            level.var_a7c3bf6d = undefined;
            break;
        case #"af_enemy_chase_veh":
            level.af_enemy_chase_veh = snd::function_4b879845( level.af_enemy_chase_veh, ent );
            thread function_eedefcf( ent, "veh_tkd_chase_npc_jeeps_high_lp" );
            ent waittill( #"death" );
            level.af_enemy_chase_veh = snd::varrayremove( level.af_enemy_chase_veh, ent );
            break;
        case #"adler":
            level.adler = ent;
            ent waittill( #"death" );
            level.adler = undefined;
            break;
        case #"hudson":
            level.hudson = ent;
            ent waittill( #"death" );
            level.hudson = undefined;
            break;
        case #"park":
            level.park = ent;
            ent waittill( #"death" );
            level.park = undefined;
            break;
        case #"woods":
            level.woods = ent;
            ent waittill( #"death" );
            level.woods = undefined;
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x60>" + snd::function_783b69( name, "<dev string:x5b>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 3, eflags: 0x4
// Checksum 0x11498549, Offset: 0xc48
// Size: 0xd2
function private _trigger( *player, trigger, *var_ec80d14b )
{
    trigger_name = snd::function_ea2f17d1( var_ec80d14b.script_ambientroom, "$default" );
    
    switch ( trigger_name )
    {
        case #"$default":
            break;
        case #"hash_d19cd1aa24166b3":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x85>" + trigger_name + "<dev string:x5b>" );
            #/
            
            break;
    }
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 2, eflags: 0x4
// Checksum 0x8b9713c, Offset: 0xd28
// Size: 0x712
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"cp_tkdn_intro_duck":
            audio::snd_set_snapshot( "cp_takedown_bar_intro" );
            break;
        case #"cp_tkdn_intro_complete":
            audio::snd_set_snapshot( "" );
            break;
        case #"intro_trans_out":
            level notify( #"intro_trans_out" );
            break;
        case #"hit3_fadein":
            thread function_8881654();
            break;
        case #"intro_ambience":
            thread intro_ambience();
            break;
        case #"cp_takedown_raid_af_transition":
            audio::snd_set_snapshot( "cp_takedown_raid_af_transition" );
            break;
        case #"cp_takedown_raid_af_transition_complete":
            audio::snd_set_snapshot( "" );
            break;
        case #"snd_overlook_scene":
            thread function_2f088c3f();
            thread function_9c9fad4e();
            break;
        case #"start_sniping":
            level notify( #"start_sniping" );
            break;
        case #"stop_cargo_plane_walla":
            level notify( #"stop_cargo_plane_walla" );
            break;
        case #"hash_44784851239c8ced":
            thread function_27059f64();
            thread function_2d5baabb();
            break;
        case #"hash_59fa1dfa8bec8836":
            thread function_4e08ef9b();
            break;
        case #"hash_444d03e74f4e7552":
            thread function_eedefcf( level.plr_chase_veh, "veh_tkd_chase_plr_jeep_high_lp" );
            break;
        case #"hash_654febf566d7e79e":
            thread function_eedefcf( level.adler, "wpn_tkd_rcxd_deploy_tires" );
            break;
        case #"hash_706ce4bbfd6f3342":
            if ( isdefined( level.af_enemy_chase_veh ) )
            {
                foreach ( veh in snd::function_f218bff5( level.af_enemy_chase_veh ) )
                {
                    thread function_eedefcf( veh, "veh_tkd_chase_npc_jeeps_high_lp" );
                }
            }
            
            break;
        case #"hash_55b5a5f81569910e":
            if ( isdefined( level.enemy_chase_veh_tires ) )
            {
                foreach ( veh in snd::function_f218bff5( level.enemy_chase_veh_tires ) )
                {
                    thread function_eedefcf( veh, "wpn_tkd_rcxd_deploy_tires" );
                }
            }
            
            break;
        case #"af_skid_starting":
            thread function_41798e8d();
            break;
        case #"af_skid_complete":
            level notify( #"hash_accff44c369c030" );
            break;
        case #"player_rc_car":
            thread function_eedefcf( level.plr_rc_car, "wpn_tkd_rcxd_high_lp" );
            break;
        case #"plane_startup":
            thread function_955f4842();
            break;
        case #"plane_idle":
            thread function_2d8bbe54( 0.5 );
            break;
        case #"start_plane_rev":
            thread function_e9cf99c1();
            break;
        case #"cargo_plane_takeoff":
            thread function_51ee8082();
            break;
        case #"hash_5ab7f237fe5d4da8":
            thread function_eedefcf( level.var_a7c3bf6d, "veh_tkd_af_cargo_plane_high_lyr1_lp" );
            thread function_eedefcf( level.var_a7c3bf6d, "veh_tkd_af_cargo_plane_high_lyr2_lp" );
            thread function_eedefcf( level.var_a7c3bf6d, "veh_tkd_af_cargo_plane_high_lyr3_lp" );
            level notify( #"hash_1c43601f4e93efcd" );
            break;
        case #"hash_34dc7852469cbf9f":
            break;
        case #"hash_164bf872d25545af":
            level notify( #"hash_2b1ea816682de37d" );
            level notify( #"hash_6f65948492627624" );
            thread function_b5f89c52( level.var_a7c3bf6d );
            thread function_b5f89c52( level.plr_chase_veh );
            thread function_b5f89c52( level.plr_rc_car );
            break;
        case #"end_fadeout":
            thread function_4df43a5e();
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:xa9>" + snd::function_783b69( msg, "<dev string:x5b>" ) );
            #/
            
            break;
    }
}

/#

    // Namespace namespace_a052577e/namespace_c0722ca1
    // Params 0
    // Checksum 0xf5102b39, Offset: 0x1448
    // Size: 0x96, Type: dev
    function xhair()
    {
        self endon( #"death" );
        self endon( #"hash_2caeecd393c68946" );
        
        while ( isdefined( self ) && isdefined( self.origin ) && isdefined( self.angles ) )
        {
            snd::debugcrosshair( self.origin, 24, self.angles, ( 1, 1, 1 ), 1, 0, 1 );
            waitframe( 1 );
        }
    }

#/

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x8f25c9ba, Offset: 0x14e8
// Size: 0x1c
function function_8881654()
{
    audio::snd_set_snapshot( "cp_tkdn_hit3_intro_fadein" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x1af65e27, Offset: 0x1510
// Size: 0x54
function function_2f088c3f()
{
    wait 5;
    function_5ea2c6e3( "cp_tkdn_af_hill" );
    level waittill( #"start_sniping" );
    function_ed62c9c2( "cp_tkdn_af_hill" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xffd6aae6, Offset: 0x1570
// Size: 0x130
function function_9c9fad4e()
{
    level endoncallback( &function_d111fa29, #"start_sniping" );
    player = getlocalplayers()[ 0 ];
    player endon( #"death" );
    function_5ea2c6e3( "cp_tkdn_af_hill_binoculars", 0, 0 );
    setsoundcontext( "vehicle", "interior" );
    
    while ( true )
    {
        camera_zoom = player waittill( #"camera_zoom" );
        function_672403ca( "cp_tkdn_af_hill_binoculars", float( player function_8e4cd43b() ) / 1000, camera_zoom.pct );
    }
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1
// Checksum 0x5816dae1, Offset: 0x16a8
// Size: 0x24
function function_d111fa29( *str_notify )
{
    function_ed62c9c2( "cp_tkdn_af_hill_binoculars" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x1957f481, Offset: 0x16d8
// Size: 0x64
function function_2d5baabb()
{
    level notify( #"hash_4611077995caeba5" );
    audio::snd_set_snapshot( "cp_tkdn_bullettime" );
    wait 0.4;
    audio::snd_set_snapshot( "" );
    thread function_913d2991();
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x7ad45a0c, Offset: 0x1748
// Size: 0x4c
function function_41798e8d()
{
    function_5ea2c6e3( "cp_tkdn_af_skid" );
    level waittill( #"hash_accff44c369c030" );
    function_ed62c9c2( "cp_tkdn_af_skid" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xb0e54a2d, Offset: 0x17a0
// Size: 0x1c
function function_4df43a5e()
{
    audio::snd_set_snapshot( "cp_tkdn_end_fadeout" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x80f724d1, Offset: 0x17c8
// Size: 0x4
function function_5409e18e()
{
    
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x16fd45aa, Offset: 0x17d8
// Size: 0x566
function intro_ambience()
{
    wait 3;
    air_vent = snd::play( [ "emt_air_vent_ext_lp" ], ( -51810, -55881, -25286 ) );
    var_8aee310c = snd::emitter( "emt_barbed_wire_rattle", ( -51695, -55914, -25302 ), [ 5, 10 ] );
    var_7d6395f7 = snd::emitter( "emt_barbed_wire_rattle", ( -51447, -55997, -25285 ), [ 5, 15 ] );
    var_69cc6ec1 = snd::emitter( "emt_barbed_wire_rattle", ( -52351, -56149, -25338 ), [ 5, 15 ] );
    var_f0b75857 = snd::emitter( "emt_fence_rattle", ( -51082, -56398, -25231 ), [ 3, 12 ] );
    var_df7535d3 = snd::emitter( "emt_fence_rattle", ( -51804, -56454, -25342 ), [ 4, 16 ] );
    var_860c0302 = snd::emitter( "emt_fence_rattle", ( -51584, -56438, -25313 ), [ 4, 16 ] );
    var_2e0f28a6 = snd::play( "emt_nighttime_crickets_lp", ( -51543, -55467, -24903 ) );
    var_e0196cfa = snd::emitter( "emt_sheetmetal_stress", ( -52120, -56117, -25311 ), [ 5, 15 ] );
    var_26f2175c = snd::emitter( "emt_foliage_rustle", ( -52305, -56353, -25250 ), [ 5, 15 ] );
    var_81a0ccb8 = snd::emitter( "emt_foliage_rustle", ( -51441, -56370, -25126 ), [ 2, 20 ] );
    var_6b52a01c = snd::emitter( "emt_foliage_rustle", ( -50724, -56196, -25070 ), [ 6, 30 ] );
    var_5e060583 = snd::emitter( "emt_foliage_rustle", ( -52512, -56266, -25330 ), [ 20, 35 ] );
    var_4b22dfb1 = snd::emitter( "emt_foliage_rustle", ( -50802, -55866, -25067 ), [ 8, 26 ] );
    var_3457b21b = snd::emitter( "emt_foliage_rustle", ( -52270, -56100, -25200 ), [ 10, 20 ] );
    var_26bd16e6 = snd::emitter( "emt_foliage_rustle", ( -51500, -55890, -25130 ), [ 8, 32 ] );
    var_39851209 = snd::play( "emt_truck_exhaust_idle_lp", ( -52030, -56398, -25344 ) );
    var_bd571d20 = snd::play( "emt_tarp_flap_runway_lp", ( -50019, -55118, -25163 ) );
    var_c7ed324c = snd::play( "emt_tarp_flap_runway_lp", ( -49783, -55643, -25163 ) );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x128cedba, Offset: 0x1d48
// Size: 0x5c
function function_cb00a128()
{
    var_18dbd2db = snd::play( "quad_tkd_af_dist_plane_wash_front_lp", 2 );
    level waittill( #"stop_cargo_plane_walla" );
    snd::stop( var_18dbd2db, 2 );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x4d733f70, Offset: 0x1db0
// Size: 0xdc
function function_755bfc95()
{
    walla = snd::play( "emt_tkd_walla_plane_workers_temp", [ level.var_a7c3bf6d, "tag_origin" ] );
    loaders = snd::play( "emt_tkd_cargo_loading_vehicles_lp", [ level.var_a7c3bf6d, "tag_origin" ] );
    level waittill( #"stop_cargo_plane_walla" );
    snd::stop( walla, 2 );
    snd::stop( loaders, 2 );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x98277a24, Offset: 0x1e98
// Size: 0x3c
function function_27059f64()
{
    snd::play( "evt_tkd_sniper_bullettime_main" );
    wait 0.183;
    snd::play( "evt_tkd_sniper_bullettime_impact" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x3366c5cd, Offset: 0x1ee0
// Size: 0x3e
function function_913d2991()
{
    wait 1.5;
    var_913d2991 = snd::play( "emt_tkd_walla_runway_panic_temp", ( -49618, -55463, -25053 ) );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xef40b742, Offset: 0x1f28
// Size: 0x6c
function function_955f4842()
{
    wait 5;
    start = snd::play( "veh_tkd_af_cargo_plane_start", [ level.var_a7c3bf6d, "tag_origin" ] );
    thread function_2d8bbe54( 2 );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1
// Checksum 0x26df0754, Offset: 0x1fa0
// Size: 0x134
function function_2d8bbe54( wait_time )
{
    wait_time = snd::function_ea2f17d1( wait_time, 0.5 );
    level.var_abe3f688 = snd::play( "veh_tkd_af_cargo_plane_idle_lp", [ level.var_a7c3bf6d, "tag_origin" ] );
    snd::set_volume( level.var_abe3f688, 0 );
    snd::set_pitch( level.var_abe3f688, 1 );
    thread function_755bfc95();
    thread function_cb00a128();
    wait wait_time;
    snd::set_volume( level.var_abe3f688, 1, 0.5 );
    level waittill( #"hash_1c43601f4e93efcd" );
    snd::stop( level.var_abe3f688, 5 );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x9118976f, Offset: 0x20e0
// Size: 0x7c
function function_e9cf99c1()
{
    snd::set_pitch( level.var_abe3f688, snd::function_d8b24901( 8 ), 1 );
    snd::play( "veh_tkd_af_cargo_plane_accelerate", [ level.var_a7c3bf6d, "tag_origin" ] );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x96e8b2e2, Offset: 0x2168
// Size: 0x4e
function function_51ee8082()
{
    snd = snd::play( "veh_tkd_af_cargo_plane_takeoff", [ level.var_a7c3bf6d, "tag_origin" ] );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xfcfe49ce, Offset: 0x21c0
// Size: 0x24
function function_4e08ef9b()
{
    wait 4;
    snd::play( "evt_tkd_chase_start_peel_out" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 2
// Checksum 0xac9b3374, Offset: 0x21f0
// Size: 0x664
function function_eedefcf( veh, name )
{
    if ( !isdefined( veh ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_9a09b851 ) )
    {
        level.var_9a09b851 = [];
    }
    
    if ( !isinarray( level.var_9a09b851, veh ) )
    {
        level.var_9a09b851[ level.var_9a09b851.size ] = veh;
    }
    else
    {
        return;
    }
    
    veh endon( #"hash_79d732c6bc0d7bd1" );
    frametime = snd::function_6cfa7975();
    playing = 0;
    snd = undefined;
    scale = 0.5;
    index = level.var_9a09b851.size;
    vol = 1;
    pitch = 1;
    
    while ( isentity( veh ) == 1 )
    {
        velocity = veh getvelocity();
        speed = length( velocity );
        
        if ( speed >= 5 && playing == 0 )
        {
            snd = snd::play( name, [ veh, "tag_origin" ] );
            playing = 1;
            veh.var_e59bc220 = snd;
        }
        else if ( speed < 5 && playing == 1 )
        {
            snd::stop( snd, 0.5 );
            playing = 0;
            snd = undefined;
            veh.var_e59bc220 = undefined;
        }
        
        if ( snd::function_a6779cbd( snd ) )
        {
            vol = snd::scalerp( speed, 0, 1000, 0.31, 1 );
            pitch = snd::scalerp( speed, 0, 1000, 0.7, 1 );
            snd::set_volume( snd, vol, frametime, "easeinout" );
            snd::set_pitch( snd, pitch, frametime );
        }
        
        /#
            scale = 1.25;
            count = 0;
            
            foreach ( var_c33fab45 in level.var_9a09b851 )
            {
                if ( var_c33fab45 == veh )
                {
                    break;
                }
                
                count++;
            }
            
            yy = 20 + count * 24 * scale * 4;
            
            if ( snd::function_d78e3644() )
            {
                snd::print3dplus( "<dev string:xc7>" + index, veh.origin + ( 0, 0, 32 ), scale, "<dev string:xcb>", ( 1, 0, 0 ), 1, ( 0, 0, 0 ), 1, ( 1, 1, 1 ), 1 );
                
                if ( isdefined( veh.name ) )
                {
                    snd::print3dplus( "<dev string:xc7>" + name, veh.origin + ( 0, 0, 0 ), scale, "<dev string:xcb>", ( 1, 0, 0 ), 1, ( 0, 0, 0 ), 1, ( 1, 1, 1 ), 1 );
                }
                
                var_bc6cbd8b = snd::printdecimalcount( speed * 0.0568182, 1 ) + "<dev string:xd0>" + snd::printdecimalcount( speed / 60, 1 ) + "<dev string:xdb>";
                snd::function_65bb0ccd( index + "<dev string:xe3>" + var_bc6cbd8b, 120, yy, scale, "<dev string:xef>", ( 1, 0, 0 ), 1, ( 0, 0, 0 ), 1, ( 1, 1, 1 ), 1 );
                yy += 24 * scale;
                snd::function_65bb0ccd( index + "<dev string:xf4>" + vol, 120, yy, scale, "<dev string:xef>", ( 1, 0, 0 ), 1, ( 0, 0, 0 ), 1, ( 1, 1, 1 ), 1 );
                yy += 24 * scale;
                snd::function_65bb0ccd( index + "<dev string:x100>" + pitch, 120, yy, scale, "<dev string:xef>", ( 1, 0, 0 ), 1, ( 0, 0, 0 ), 1, ( 1, 1, 1 ), 1 );
            }
        #/
        
        waitframe( 1 );
    }
    
    snd::stop( snd, 0.5 );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1
// Checksum 0x9e6698c6, Offset: 0x2860
// Size: 0x66
function function_b5f89c52( veh )
{
    if ( isdefined( veh ) && isdefined( veh.var_e59bc220 ) )
    {
        veh notify( #"hash_79d732c6bc0d7bd1" );
        snd::stop( veh.var_e59bc220, 0.5 );
        veh.var_e59bc220 = undefined;
    }
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 2
// Checksum 0xd4afc643, Offset: 0x28d0
// Size: 0x82
function function_b233d29e( wait_time = 1, fade_time = 0 )
{
    var_f3c1505b = snd::play( "wpn_tkd_rcxd_static_fuzz_lp" );
    wait wait_time;
    snd::stop( var_f3c1505b, fade_time );
    var_f3c1505b = undefined;
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1
// Checksum 0x4ffba71b, Offset: 0x2960
// Size: 0xf0
function function_1243d1ca( box )
{
    box endon( #"stationary", #"death" );
    wait 0.5;
    box thread function_d2ad8475();
    
    while ( true )
    {
        while ( abs( box.velocity ) > 5 )
        {
            waitframe( 1 );
        }
        
        /#
            snd::print3dplus( "<dev string:x10c>", box.origin + ( 0, 0, 32 ), 0.5, "<dev string:xcb>", ( 1, 0, 0 ), 1, ( 0, 0, 0 ), 1, ( 1, 1, 1 ), 60 );
        #/
    }
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1
// Checksum 0xa941ef71, Offset: 0x2a58
// Size: 0x5c
function function_d2ad8475( box )
{
    box endon( #"stationary", #"death" );
    
    while ( true )
    {
        box.velocity = self getvelocity();
        waitframe( 1 );
    }
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 2
// Checksum 0x7222a497, Offset: 0x2ac0
// Size: 0x17e
function function_95454c03( ent, alias )
{
    while ( !isdefined( level.plr_rc_car ) )
    {
        waitframe( 1 );
    }
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_8add257c ) )
    {
        level.var_8add257c = [];
    }
    
    if ( !isinarray( level.var_8add257c, ent ) )
    {
        level.var_8add257c[ level.var_8add257c.size ] = ent;
    }
    
    index = level.var_8add257c.size;
    ent endon( #"death" );
    level endon( #"hash_4cd47970be99bc1b" );
    thread function_fd157e6d( ent, alias );
    
    if ( snd::function_d78e3644() )
    {
        while ( true )
        {
            /#
                snd::print3dplus( "<dev string:x115>" + index, ent.origin + ( 0, 0, 32 ), 0.5, "<dev string:xcb>", ( 1, 0, 0 ), 1, ( 0, 0, 0 ), 1, ( 1, 1, 1 ), 1 );
            #/
            
            waitframe( 1 );
        }
    }
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 2
// Checksum 0x1c864873, Offset: 0x2c48
// Size: 0x21c
function function_fd157e6d( ent, alias )
{
    level.plr_rc_car endon( #"death" );
    level endon( #"hash_4cd47970be99bc1b" );
    distance = distance2d( ent.origin, level.plr_rc_car.origin );
    started = 0;
    timer = 0;
    debounce = 75;
    
    while ( isdefined( ent ) )
    {
        lastdistance = distance;
        distance = distance2d( level.plr_rc_car.origin, ent.origin );
        approachspeed = lastdistance - distance;
        
        if ( distance < 800 || timer < debounce )
        {
            if ( abs( approachspeed ) >= 25 && started == 0 && timer >= debounce )
            {
                started = 1;
                timer = 0;
                snd = snd::play( alias, level.plr_rc_car );
                vol = snd::scalerp( approachspeed, 25, 32, 0.05, 1 );
                snd::set_volume( snd, vol, 0.05 );
            }
            else if ( timer < debounce )
            {
                started = 0;
                timer += 1;
            }
        }
        else if ( started == 1 )
        {
            started = 0;
            timer = 0;
        }
        
        waitframe( 1 );
    }
}

