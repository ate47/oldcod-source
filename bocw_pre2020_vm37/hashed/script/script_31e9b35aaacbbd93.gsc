#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;

#namespace namespace_a052577e;

// Namespace namespace_a052577e/level_preinit
// Params 1, eflags: 0x44
// Checksum 0x146fe742, Offset: 0x678
// Size: 0x3c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
    snd::wait_init();
}

// Namespace namespace_a052577e/event_cc819519
// Params 1, eflags: 0x44
// Checksum 0xf87e494a, Offset: 0x6c0
// Size: 0x104
function private event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    players = undefined;
    
    while ( !isarray( players ) || players.size == 0 )
    {
        players = getplayers();
        waitframe( 1 );
    }
    
    assert( isarray( players ) && players.size > 0 );
    snd::client_targetname( players[ 0 ], "player" );
    cargo_plane = function_2b558b65();
    things = undefined;
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1, eflags: 0x4
// Checksum 0x15bb57e1, Offset: 0x7d0
// Size: 0x1ea
function private _objective( objective )
{
    if ( !snd::function_81fac19d( !isdefined( level.adler ), "no adler? :(" ) )
    {
        level.adler.battlechatterallowed = 0;
    }
    
    if ( !snd::function_81fac19d( !isdefined( level.woods ), "no woods? :(" ) )
    {
        level.woods.battlechatterallowed = 0;
    }
    
    battlechatter::function_2ab9360b( 0 );
    
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

/#

    // Namespace namespace_a052577e/namespace_c0722ca1
    // Params 0
    // Checksum 0xbbce2089, Offset: 0x9c8
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
// Params 2
// Checksum 0x7ba73b75, Offset: 0xa68
// Size: 0x1a4
function function_f29b1295( targetname, key )
{
    level endon( #"hash_29b28b273d377df6" );
    level endon( "stop_threaded_client_targetname_" + targetname );
    key = snd::function_ea2f17d1( key, "targetname" );
    ent = undefined;
    framecount = 0;
    
    while ( true )
    {
        /#
            snd::function_81fac19d( framecount % 60 == 0, "<dev string:x60>" + framecount + "<dev string:x86>" + targetname );
        #/
        
        ents = getentarray( targetname, key );
        
        if ( isarray( ents ) && ents.size > 0 )
        {
            foreach ( ent in ents )
            {
                snd::client_targetname( ent, targetname );
            }
            
            break;
        }
        
        framecount += 1;
        waitframe( 1 );
    }
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x27aacd06, Offset: 0xc18
// Size: 0x98
function function_2b558b65()
{
    cargo_plane = undefined;
    
    while ( !isdefined( cargo_plane ) )
    {
        cargo_plane = getent( "cargo_plane", "targetname" );
        waitframe( 1 );
    }
    
    assert( isentity( cargo_plane ) );
    snd::client_targetname( cargo_plane, "cargo_plane" );
    return cargo_plane;
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x5f5109d7, Offset: 0xcb8
// Size: 0x3c4
function function_e04b45ab()
{
    snd::emitter( "emt_dirt_debris_fall_sm", ( -33905, 21185, -125 ), [ 4, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -33960, 20940, -161 ), [ 5, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -34065, 20880, -162 ), [ 6, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -34716, 20938, -234 ), [ 3, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -34758, 21052, -168 ), [ 2, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -34713, 21248, 49 ), [ 1, 16 ] );
    snd::emitter( "emt_wood_debris_crumble_md", ( -34147, 21325, -120 ), [ 6, 12 ] );
    snd::emitter( "emt_wood_debris_crumble_md", ( -34254, 21132, -176 ), [ 8, 16 ] );
    snd::emitter( "emt_wood_debris_crumble_md", ( -34318, 20969, -128 ), [ 10, 20 ] );
    snd::emitter( "emt_wood_debris_crumble_md", ( -34881, 20946, -138 ), [ 6, 12 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34028, 21281, -179 ), [ 3, 9 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34229, 21204, -117 ), [ 6, 12 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34056, 20962, -233 ), [ 9, 18 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34595, 20885, -121 ), [ 22, 44 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34808, 21264, -171 ), [ 3, 9 ] );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xf490d7d1, Offset: 0x1088
// Size: 0x4c
function function_ec4a61d9()
{
    level flag::wait_till( "bustout_movement_mid_house" );
    snd::play( "tmp_evt_3d_tkdn_door_close_out_back", ( -34576, 21043, -172 ) );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 2
// Checksum 0x504bceff, Offset: 0x10e0
// Size: 0xbc
function function_6b5c2a3( bustout_driver, veh )
{
    snd::play( "tmp_tkdn_jeep_bustout", bustout_driver );
    level flag::wait_till( "bustout_start_slomo" );
    snd::play( "tmp_tkdn_to_bullettime", level.player );
    bustout_driver waittill( #"death" );
    snd::play( "tmp_evt_2d_tkdn_slowmo_kill_confirmed" );
    wait 0.5;
    snd::play( "tmp_tkdn_jeep_veer_off", veh );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xc1270fd7, Offset: 0x11a8
// Size: 0x1c
function function_b9b9189c()
{
    snd::client_msg( "cp_tkdn_intro_duck" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x455c6c8c, Offset: 0x11d0
// Size: 0x1c
function function_82bfce7c()
{
    snd::play( "tmp_evt_tkdn_lighter_intro" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x80f724d1, Offset: 0x11f8
// Size: 0x4
function function_60f59158()
{
    
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xdcc30d57, Offset: 0x1208
// Size: 0x84
function function_6591463()
{
    wait 1;
    var_8eddf3a6 = snd::play( "tmp_emt_police_scanner_dutch", ( 19695, 18941, 69 ) );
    level flag::wait_till( "flag_move_on_to_alley" );
    snd::stop( var_8eddf3a6, [ 1 ] );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x80f724d1, Offset: 0x1298
// Size: 0x4
function function_ddd8adc3()
{
    
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x8fca2724, Offset: 0x12a8
// Size: 0x1c
function function_2032c91c()
{
    music::setmusicstate( "1.0_approach" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x8a0cd67, Offset: 0x12d0
// Size: 0x1c
function function_11062617()
{
    music::setmusicstate( "none" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xab7bf4ee, Offset: 0x12f8
// Size: 0x1c
function function_1dc92e4f()
{
    music::setmusicstate( "2.0_assault" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x888bf0dd, Offset: 0x1320
// Size: 0x2c
function function_b26ed576()
{
    snd::play( "tmp_tkdn_drunk_singing_lp", ( 20334, 18307, 97 ) );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x1ac14ce7, Offset: 0x1358
// Size: 0x34
function function_f8f5f970()
{
    wait 0.7;
    snd::play( "tmp_tkdn_apartment_door_breach", ( 20753, 17182, 66 ) );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x80f724d1, Offset: 0x1398
// Size: 0x4
function function_bc76873()
{
    
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x84732b89, Offset: 0x13a8
// Size: 0x64
function function_fd7139f4()
{
    music::setmusicstate( "none" );
    snd::play( "evt_takedown_roofjump_slowmo" );
    level waittill( #"hash_35a786f9d88a2e60" );
    music::setmusicstate( "3.0_interrogation" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x58951b4d, Offset: 0x1418
// Size: 0x1c
function function_a5d5a125()
{
    music::setmusicstate( "none" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x80f724d1, Offset: 0x1440
// Size: 0x4
function function_9ac81c6b()
{
    
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x506ac208, Offset: 0x1450
// Size: 0x1c
function function_c2eee241()
{
    snd::play( "evt_tkdn_roof_slide" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x80f724d1, Offset: 0x1478
// Size: 0x4
function function_a7024b3c()
{
    
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xffa270ac, Offset: 0x1488
// Size: 0x24
function function_e88f8edb()
{
    wait 5;
    music::function_edda155f( "3.1_throw_stinger" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xd31dd8d7, Offset: 0x14b8
// Size: 0x34
function function_60c0a46b()
{
    snd::play( "evt_transition_roof_to_airfield_camera_pt1" );
    snd::client_msg( "cp_takedown_raid_af_transition" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xdcac4a6, Offset: 0x14f8
// Size: 0x34
function evt_transition_roof_to_airfield_camera_pt2()
{
    snd::play( "evt_transition_roof_to_airfield_camera_pt2" );
    snd::client_msg( "cp_takedown_raid_af_transition_complete" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x55c1cee2, Offset: 0x1538
// Size: 0x64
function function_dd4c9710()
{
    snd::client_msg( "hit3_fadein" );
    snd::client_msg( "intro_ambience" );
    snd::client_msg( "plane_startup" );
    flag::wait_till( "af_fade_in_complete" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x170a2523, Offset: 0x15a8
// Size: 0x64
function function_a42cfb58()
{
    cargo_plane = function_2b558b65();
    music::function_edda155f( "b1.5_airfield_reveal" );
    snd::client_msg( "intro_ambience" );
    snd::client_msg( "plane_idle" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1
// Checksum 0x7a26e7e9, Offset: 0x1618
// Size: 0x24
function function_92a6fd6a( plane )
{
    snd::play( "veh_tkd_airstrip_flyover", plane );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x9d1d5674, Offset: 0x1648
// Size: 0x7c
function function_4074e9b1()
{
    cargo_plane = function_2b558b65();
    music::setmusicstate( "b5.0_battle" );
    snd::client_msg( "intro_ambience" );
    snd::client_msg( "plane_idle" );
    snd::client_msg( "plane_chase_music" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xb66ed241, Offset: 0x16d0
// Size: 0x1c
function function_79270d32()
{
    music::setmusicstate( "b5.0_battle" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x26910c49, Offset: 0x16f8
// Size: 0x2c
function function_bbedb5ab()
{
    wait 2.5;
    level.var_79f25ee7 = snd::play( "quad_tkd_chase_ricochets_front_lp" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x54af4b6e, Offset: 0x1730
// Size: 0x1c
function function_7bd72cc0()
{
    music::setmusicstate( "mus_b6.0_rc_loop_0" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1
// Checksum 0x38fcb080, Offset: 0x1758
// Size: 0x7c
function function_b3b2671a( player )
{
    snd::stop( level.var_79f25ee7 );
    player waittill( #"blow_rc_car" );
    snd::play( "wpn_tkd_rcxd_detonate_trigger", [ level.rc_car, "tag_fx_light_rear" ] );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xb9821b1b, Offset: 0x17e0
// Size: 0x1c
function function_3dbad6f5()
{
    snd::client_msg( "af_skid_starting" );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 1
// Checksum 0x79fdaf4b, Offset: 0x1808
// Size: 0x14
function function_32f20d13( *veh )
{
    wait 0.15;
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0x80f724d1, Offset: 0x1828
// Size: 0x4
function function_fc52119f()
{
    
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xdcf41f0, Offset: 0x1838
// Size: 0x2c
function function_bee54a20()
{
    wait 0.4;
    snd::play( "sce_tkd_wreck_unconscious_whoosh", level.player );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xbf3c86ed, Offset: 0x1870
// Size: 0x21c
function function_cbae87a2()
{
    var_a27674c9 = snd::play( "emt_tkd_wreck_fire_01_lp", ( 10461, -54901, -25182 ) );
    var_d96e62bc = snd::play( "emt_tkd_wreck_fire_02_lp", ( 10738, -54523, -25136 ) );
    var_c6a73d2e = snd::play( "emt_tkd_wreck_fire_03_lp", ( 10648, -55102, -25155 ) );
    metal = snd::play( "emt_tkd_wreck_metal_lp", ( 10261, -54762, -25082 ) );
    var_47cd46cf = snd::play( "emt_tkd_wreck_sirens_01_lp", ( 10491, -53575, -25003 ) );
    var_630e7d51 = snd::play( "emt_tkd_wreck_sirens_02_lp", ( 15160, -54833, -24566 ) );
    var_f07a182a = snd::play( "emt_tkd_wreck_sirens_03_lp", ( -4034, -49059, -24440 ) );
    level flag::wait_till( "tkdn_af_wreck_completed" );
    snd::stop( var_a27674c9 );
    snd::stop( var_d96e62bc );
    snd::stop( var_c6a73d2e );
    snd::stop( metal );
    snd::stop( var_47cd46cf );
    snd::stop( var_630e7d51 );
    snd::stop( var_f07a182a );
}

// Namespace namespace_a052577e/namespace_c0722ca1
// Params 0
// Checksum 0xa860f686, Offset: 0x1a98
// Size: 0x1c
function function_4788a209()
{
    snd::client_msg( "end_fadeout" );
}

