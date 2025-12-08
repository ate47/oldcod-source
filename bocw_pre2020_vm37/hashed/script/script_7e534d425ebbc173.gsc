#using script_1b9f100b85b7e21d;
#using script_237e957844a8197c;
#using script_35ae72be7b4fec10;
#using script_6bb8615992324ccf;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_nic_revolucion_fx;
#using scripts\cp_common\cctv;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace namespace_b16b5bf9;

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0x3138cca0, Offset: 0x858
// Size: 0x13c
function start( *str_objective )
{
    level hms_util::function_ee1d1df6( "park", "Park", "park_floor_one_cctv_start" );
    level hms_util::function_ee1d1df6( "lazar", "Lazar", "lazar_floor_one_cctv_start" );
    var_6704072a = doors::get_doors( "cctv_entrance_door_01" )[ 0 ];
    var_6704072a doors::open();
    cctv_entrance_door_clip = getent( "cctv_entrance_door_clip", "targetname" );
    cctv_entrance_door_clip hide();
    cctv_entrance_door_clip notsolid();
    level thread namespace_a789f8ae::function_c9b603f3( "floor_one_cctv" );
    level thread namespace_a789f8ae::function_8d918610( "floor_one_cctv" );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 2
// Checksum 0xc8d7b24b, Offset: 0x9a0
// Size: 0x35c
function main( *str_objective, *var_50cc0d4f )
{
    /#
        hms_util::print( "<dev string:x38>" );
    #/
    
    function_cd7802ed();
    level thread function_4e1b35c5();
    level.player clientfield::set_to_player( "cull_outside_nuke_room", 0 );
    var_ec749756 = struct::get( "s_security_room_objective", "targetname" );
    var_97da65ea = struct::get( "s_stairwell_objective", "targetname" );
    var_8ee8e2ae = struct::get( "plant_c4_pos", "targetname" );
    objectives::goto( #"hash_17cf8fe57da0ba5b", var_ec749756.origin, #"hash_690aab6987e4073f" );
    savegame::checkpoint_save();
    level flag::wait_till( "flg_cctv_finished" );
    objectives::complete( #"hash_17cf8fe57da0ba5b" );
    savegame::checkpoint_save();
    objectives::goto( "obj_first_floor_stairwell", var_97da65ea.origin, #"hash_661a49377832d6e0" );
    level flag::wait_till( "flg_ready_to_plant_c4" );
    objectives::complete( "obj_first_floor_stairwell" );
    level thread function_1bcc08b8();
    objectives::goto( #"hash_52f6c243fa81b016", var_8ee8e2ae.origin, #"hash_49beec353dd041ea" );
    level flag::wait_till( "flg_door_breached_to_second_floor" );
    var_2cdf7dae = getaiteamarray( "axis" );
    
    foreach ( guy in var_2cdf7dae )
    {
        guy util::stop_magic_bullet_shield();
        guy deletedelay();
    }
    
    objectives::complete( #"hash_52f6c243fa81b016" );
    skipto::function_4e3ab877( "1st_floor_cctv" );
}

/#

    // Namespace namespace_b16b5bf9/namespace_b16b5bf9
    // Params 4
    // Checksum 0x7233ae55, Offset: 0xd08
    // Size: 0x44, Type: dev
    function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
    {
        hms_util::print( "<dev string:x53>" );
    }

#/

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0x19dcac93, Offset: 0xd58
// Size: 0x134
function function_4e1b35c5()
{
    level.player endon( #"death" );
    var_e534dcb = struct::get( "ai_alder_radio", "targetname" );
    level flag::wait_till( "flg_cctv_finished" );
    wait 0.25;
    level.park hms_util::dialogue( "vox_cp_cbcr_02200_park_secondfloorcent_3e" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01400_park_upstairsletsmov_27" );
    var_e534dcb hms_util::dialogue( "vox_cp_cbcr_01400_adlr_meetyouthere_61", 1, "allies", "Adler" );
    level flag::wait_till( "flg_ready_to_plant_c4" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01400_park_bellusethec4_3e" );
    level thread function_b6624d37();
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0xa3480270, Offset: 0xe98
// Size: 0xda
function function_813d6578()
{
    level endon( #"c4_planted" );
    level endon( #"1st_floor_cctv" );
    var_16bf64d2 = randomintrangeinclusive( 0, 1 );
    
    switch ( var_16bf64d2 )
    {
        case 0:
            level.park hms_util::dialogue( "vox_cp_cbcr_01400_park_bellblowthatgat_04" );
            break;
        case 1:
            level.park hms_util::dialogue( "vox_cp_cbcr_01400_park_belluseyourc4_bf" );
            break;
    }
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0x9de041c7, Offset: 0xf80
// Size: 0x12e
function function_b6624d37()
{
    level.player endon( #"death" );
    level endon( #"c4_planted" );
    level endon( #"1st_floor_cctv" );
    var_3c3f5e50 = getent( "c4_should_nag", "targetname" );
    
    while ( true )
    {
        if ( isdefined( var_3c3f5e50 ) )
        {
            if ( level.player istouching( var_3c3f5e50 ) )
            {
                wait 7;
                
                /#
                    hms_util::print( "<dev string:x6c>" );
                #/
                
                level function_813d6578();
            }
            else if ( !level.player istouching( var_3c3f5e50 ) )
            {
                /#
                    hms_util::print( "<dev string:x7d>" );
                #/
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0x49b29a8a, Offset: 0x10b8
// Size: 0x43c
function function_cd7802ed()
{
    var_192f645a = struct::get( "cctv_interact", "targetname" );
    var_192f645a.var_ab2bc4e8 = [];
    var_192f645a.var_b785b365 = [];
    var_121737f7 = getvehiclearray( "cctv_camera", "targetname" );
    var_121737f7 = hms_util::function_a7607f( var_121737f7, "script_int" );
    var_121737f7[ 0 ] turretsettargetangles( 0, ( 8, -10, 0 ) );
    var_121737f7[ 1 ] turretsettargetangles( 0, ( 21, -13, 0 ) );
    var_121737f7[ 2 ] turretsettargetangles( 0, ( 29, 5, 0 ) );
    var_121737f7[ 3 ] turretsettargetangles( 0, ( 21, -10, 0 ) );
    var_192f645a.var_ab2bc4e8[ 0 ] = { #var_cb0e9f8e:var_121737f7[ 1 ], #var_9f8f8d9c:"play_scene_civ_execute", #str_loc:#"hash_662777978e4da185" };
    var_192f645a.var_ab2bc4e8[ 1 ] = { #var_cb0e9f8e:var_121737f7[ 2 ], #var_9f8f8d9c:"play_scene_civ_ground", #str_loc:#"hash_662774978e4d9c6c" };
    var_192f645a.var_ab2bc4e8[ 2 ] = { #var_cb0e9f8e:var_121737f7[ 3 ], #var_9f8f8d9c:"flg_VIP_spotted_in_cctv", #str_loc:#"hash_662776978e4d9fd2", #var_3b88bfc:1 };
    var_192f645a.var_b785b365[ 0 ] = { #var_cb0e9f8e:var_121737f7[ 0 ], #var_9f8f8d9c:"flg_lobby_camera", #str_name:#"hash_39eb5d8aff350df5", #str_loc:#"hash_662775978e4d9e1f" };
    var_192f645a.var_b785b365[ 1 ] = { #str_name:#"hash_39eb5a8aff3508dc" };
    var_192f645a.var_b785b365[ 2 ] = { #str_name:#"hash_39eb5b8aff350a8f" };
    var_192f645a.var_b785b365[ 3 ] = { #str_name:#"hash_39eb588aff350576" };
    var_192f645a.var_47c25f3a = 0;
    var_192f645a.var_cec44276 = 0;
    var_192f645a util::create_cursor_hint( undefined, undefined, #"hash_5e5ae431113fb2a0", 64, undefined, &function_89cbd640 );
    level thread namespace_a789f8ae::function_48e82918();
    level thread namespace_a789f8ae::function_fedf7c();
    level thread namespace_a789f8ae::function_604a3e80();
    level thread namespace_a789f8ae::function_c54af28a();
    level thread namespace_a789f8ae::function_78f15dd1();
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0x58697b96, Offset: 0x1500
// Size: 0x204
function function_89cbd640( s_info )
{
    var_16316075 = 2;
    var_ba61c107 = self.var_ab2bc4e8[ var_16316075 ];
    
    if ( isdefined( var_ba61c107.var_cb0e9f8e ) )
    {
        level util::create_streamer_hint( var_ba61c107.var_cb0e9f8e.origin, var_ba61c107.var_cb0e9f8e.angles, 1 );
    }
    
    self.e_user = s_info.player;
    self.e_user playgestureviewmodel( #"ges_drophand" );
    wait 0.35;
    cctv::function_c238a64a();
    var_9e659f52 = int( float( gettime() ) / 1000 );
    
    if ( var_9e659f52 > 1800 )
    {
        var_9e659f52 = 1800 - randomintrange( 0, 60 );
    }
    
    cctv::function_6e6cbceb( #"hash_1f55281c1c11158a", 51180 + var_9e659f52 );
    self function_5839f96b( self.var_47c25f3a );
    self.e_user thread function_2d03467( self );
    self thread function_ed61bebf();
    snd::client_msg( "flg_cctv_cam_start_audio" );
    prompts::function_e79f51ec( #"panic_room" );
    level flag::set( "flg_cctv_int" );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0x7ed0b2e, Offset: 0x1710
// Size: 0x1fa
function function_5839f96b( n_index )
{
    s_cam = self.var_b785b365[ n_index ];
    
    if ( !isdefined( s_cam.var_cb0e9f8e ) )
    {
        s_cam function_7792a165( self );
    }
    
    self.e_user cp_nic_revolucion_fx::function_383d3084();
    var_38e89473 = self.var_b785b365[ self.var_47c25f3a ];
    
    if ( isdefined( var_38e89473.var_3b88bfc ) )
    {
        level.player clientfield::set_to_player( "cull_outside_nuke_room", 0 );
        
        if ( level flag::get( #"hash_65c39e513e3e4b48" ) )
        {
            self.e_user function_8b835fbf( 0 );
        }
    }
    else if ( isdefined( s_cam.var_3b88bfc ) )
    {
        level.player clientfield::set_to_player( "cull_outside_nuke_room", 1 );
        
        if ( level flag::get( #"hash_65c39e513e3e4b48" ) )
        {
            self.e_user function_8b835fbf( 2 );
        }
    }
    
    self.e_user namespace_7b8a8e22::function_6186baa2( s_cam.var_cb0e9f8e );
    cctv::function_bd2b7003( s_cam.str_name, s_cam.str_loc );
    
    if ( !level flag::get( s_cam.var_9f8f8d9c ) )
    {
        level flag::set( s_cam.var_9f8f8d9c );
    }
    
    self.var_47c25f3a = n_index;
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0x810f86ed, Offset: 0x1918
// Size: 0x6e
function function_7792a165( var_abfda0e9 )
{
    s_info = array::pop_front( var_abfda0e9.var_ab2bc4e8 );
    self.var_cb0e9f8e = s_info.var_cb0e9f8e;
    self.var_9f8f8d9c = s_info.var_9f8f8d9c;
    self.str_loc = s_info.str_loc;
    self.var_3b88bfc = s_info.var_3b88bfc;
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0xdd05b82b, Offset: 0x1990
// Size: 0x5c
function function_cc8891cc( var_a6d518ba )
{
    n_index = hms_util::function_65ec34cf( self.var_47c25f3a, var_a6d518ba, 0, self.var_b785b365.size - 1 );
    self function_5839f96b( n_index );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0xdffc38c0, Offset: 0x19f8
// Size: 0x4ac
function function_2d03467( var_abfda0e9 )
{
    self endon( #"death" );
    self val::set( #"cctv", "allow_crouch", 0 );
    self val::set( #"cctv", "allow_prone", 0 );
    level trigger::use( "allies_cctv_stack_up_color_trig", "targetname" );
    cctv_entrance_door_clip = getent( "cctv_entrance_door_clip", "targetname" );
    wait 2;
    self util::show_hint_text( #"hash_69591e6984149ba7", undefined, undefined, -1 );
    
    while ( !var_abfda0e9.var_cec44276 || !self vehiclemovedownbuttonpressed() )
    {
        if ( self vehicleattackbuttonpressed() )
        {
            var_abfda0e9 function_cc8891cc( 1 );
            self function_ff7f3030( var_abfda0e9 );
            self hms_util::function_7051ec77( &vehicleattackbuttonpressed, 0 );
        }
        else if ( self function_e01d381a() )
        {
            var_abfda0e9 function_cc8891cc( -1 );
            self function_ff7f3030( var_abfda0e9 );
            self hms_util::function_7051ec77( &function_e01d381a, 0 );
        }
        
        waitframe( 1 );
    }
    
    self cp_nic_revolucion_fx::function_383d3084();
    self util::hide_hint_text( 0 );
    self namespace_7b8a8e22::function_c168eb01();
    cctv::function_173bb173( 0 );
    self function_8b835fbf( 0 );
    self util::delay( 0.1, undefined, &val::reset_all, #"cctv" );
    level util::wait_clear_streamer_hint( 0.1 );
    level flag::set( "flag_stairwell_update" );
    level flag::set( "flg_cctv_finished" );
    snd::client_msg( "flg_cctv_cam_stop_audio" );
    prompts::function_398ab9eb();
    var_67913fff = struct::get( "lazar_gate_struct_path", "targetname" );
    var_3a5133cb = struct::get( "park_gate_struct_path", "targetname" );
    level.lazar colors::disable();
    level.park colors::disable();
    level.lazar thread spawner::go_to_struct( var_67913fff );
    level.lazar setdesiredspeed( "sprint" );
    wait 1.75;
    level.park ai::set_behavior_attribute( "disablepeek", 0 );
    level.park ai::set_behavior_attribute( "disablelean", 0 );
    level.park thread spawner::go_to_struct( var_3a5133cb );
    level.park ai::function_3a5e9945( 1 );
    level.lazar ai::function_3a5e9945( 1 );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0x53595160, Offset: 0x1eb0
// Size: 0x84
function function_ff7f3030( var_abfda0e9 )
{
    self util::hide_hint_text( 1 );
    wait 2;
    str_hint = #"hash_69591e6984149ba7";
    
    if ( var_abfda0e9.var_cec44276 )
    {
        str_hint = #"hash_69591f6984149d5a";
    }
    
    self util::show_hint_text( str_hint, undefined, undefined, -1 );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0x75b85df9, Offset: 0x1f40
// Size: 0x14a
function function_ed61bebf()
{
    level flag::wait_till( "flg_VIP_spotted_in_cctv" );
    self thread function_944ac60c();
    var_408407f9 = getnode( "cctv_park_exit_post", "targetname" );
    level.park animation::stop();
    level.park teleport( var_408407f9.origin );
    level.park setgoal( var_408407f9 );
    level.park ai::set_behavior_attribute( "disablepeek", 1 );
    level.park ai::set_behavior_attribute( "disablelean", 1 );
    level thread function_2d471b16();
    function_99a96eac();
    self.var_cec44276 = 1;
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0x49bb09e4, Offset: 0x2098
// Size: 0xa4
function function_944ac60c()
{
    self endon( #"death" );
    level waittill( #"hash_1d8ebf8f6d683686" );
    
    if ( isdefined( self.var_b785b365[ self.var_47c25f3a ].var_3b88bfc ) )
    {
        snd::client_msg( "flg_cctv_cam_broken_static" );
        self.e_user function_8b835fbf( 1 );
    }
    
    level flag::set( #"hash_65c39e513e3e4b48" );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0x315dbeeb, Offset: 0x2148
// Size: 0xb0
function function_99a96eac()
{
    a_blockers = getentarray( "cctv_approach_blockade", "targetname" );
    
    foreach ( e_block in a_blockers )
    {
        e_block delete();
    }
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0x5f40111a, Offset: 0x2200
// Size: 0xbc
function function_8b835fbf( n_type )
{
    self cp_nic_revolucion_fx::function_476c025a( n_type );
    
    if ( n_type > 0 )
    {
        self val::set( #"cctv", "freezecontrols", 1 );
        self namespace_7b8a8e22::block_zoom_input( 1 );
        return;
    }
    
    self val::reset( #"cctv", "freezecontrols" );
    self namespace_7b8a8e22::block_zoom_input( 0 );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0xc5ea7856, Offset: 0x22c8
// Size: 0x12c
function function_2d471b16()
{
    level flag::wait_till( "flg_cctv_finished" );
    
    if ( isdefined( level.adler ) )
    {
        level.adler val::set( #"hash_560c4896165681a2", "magic_bullet_shield", 0 );
        level.adler deletedelay();
    }
    
    if ( isdefined( level.mason ) )
    {
        level.mason val::set( #"hash_560c4896165681a2", "magic_bullet_shield", 0 );
        level.mason deletedelay();
    }
    
    if ( isdefined( level.woods ) )
    {
        level.woods val::set( #"hash_560c4896165681a2", "magic_bullet_shield", 0 );
        level.woods deletedelay();
    }
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0xb52969c, Offset: 0x2400
// Size: 0x4dc
function function_1bcc08b8()
{
    var_a688c776 = getent( "ready_to_plant_trig", "targetname" );
    var_bd11e136 = getent( "second_floor_stairway_door", "targetname" );
    var_f103298 = getent( "second_floor_stairway_door_clip", "targetname" );
    var_c6b0b733 = struct::get( "door_breach_fx_pos", "targetname" );
    
    if ( isdefined( var_bd11e136 ) )
    {
        var_f103298 linkto( var_bd11e136 );
        var_bd11e136 disconnectpaths();
    }
    
    var_a688c776 waittill( #"trigger" );
    var_c10cf4b6 = struct::get( "floor_one_plant_c4_org", "targetname" );
    var_93e9d0ab = util::spawn_model( "tag_origin", var_c10cf4b6.origin, var_c10cf4b6.angles );
    var_93e9d0ab util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_21e03d8b9de211b7", 64 );
    var_93e9d0ab prompts::function_cf884581( #"use", 135 );
    var_93e9d0ab prompts::function_5698d1c9( #"use", 225 );
    var_93e9d0ab waittill( #"trigger" );
    var_93e9d0ab util::remove_cursor_hint();
    namespace_a789f8ae::function_dde2e307();
    level flag::set( "c4_planted" );
    var_2b96c77c = struct::get( "scene_c4_gate" );
    var_2b96c77c.scene_ents[ #"bomb" ] thread function_9f9e880e();
    wait 1.5;
    level notify( #"hud_icon_c4_red" );
    wait 1.5;
    var_6becf11c = getent( "bridge_gate_phys_impulse", "targetname" );
    physicsexplosionsphere( var_6becf11c.origin, 290, 0, 2 );
    level notify( #"hash_1ebf62c7b43dbd5e" );
    level flag::set( "flg_door_breached_to_second_floor" );
    playfx( level._effect[ #"hash_70902b0842168222" ], var_c6b0b733.origin );
    snd::client_targetname( var_bd11e136, "audio_gate_breach_explosion" );
    earthquake( 0.25, 0.25, var_93e9d0ab.origin, 350 );
    var_93e9d0ab delete();
    
    if ( isdefined( var_bd11e136 ) )
    {
        var_bd11e136 connectpaths();
    }
    
    if ( isdefined( var_f103298 ) )
    {
        var_f103298 delete();
    }
    
    level.park ai::function_3a5e9945( 0 );
    level.lazar ai::function_3a5e9945( 0 );
    trigger::use( "floor_two_allies_initial_color_trig", "targetname" );
    level.lazar colors::enable();
    wait 1.5;
    level.park colors::enable();
    level.lazar setdesiredspeed( "jog" );
    level.park setdesiredspeed( "jog" );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0xc631e0ce, Offset: 0x28e8
// Size: 0x114
function function_9f9e880e()
{
    wait 0.5;
    uid = level scripted_widgets::create_waypoint( "c4", self, #"hud_icon_c4", undefined, ( 0, 0, 0 ), undefined, 0 );
    scripted_widgets::function_fdb73881( uid, 0, 250 );
    scripted_widgets::set_state( uid, 1 );
    level waittill( #"hud_icon_c4_red" );
    scripted_widgets::function_309bf7c2( uid, #"hud_icon_c4_red" );
    snd::client_msg( "audio_c4_beeps" );
    level waittill( #"hash_1ebf62c7b43dbd5e" );
    scripted_widgets::remove( uid );
    self delete();
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 1
// Checksum 0x1ae65588, Offset: 0x2a08
// Size: 0x20, Type: bool
function function_26ddb694( *s_info )
{
    return isdefined( level.player.var_80730518 );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0xa74be38e, Offset: 0x2a30
// Size: 0x304
function function_581e59c1()
{
    level flag::wait_till( "flg_panic_room_camera" );
    level thread function_40d6f2bd();
    var_53b31d6b = struct::get( "panic_room_lookat", "targetname" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_53b31d6b.origin, cos( 15 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), var_53b31d6b.origin, 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    var_35c66d32 = util::spawn_model( "tag_origin", var_53b31d6b.origin, var_53b31d6b.angles );
    var_35c66d32 util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_77f2f4b5474df6a1", 5000, undefined, undefined, undefined, 5000, 5, 1, undefined, undefined, &function_26ddb694 );
    var_35c66d32 prompts::function_3171730f( #"use", #"panic_room" );
    var_35c66d32 waittill( #"trigger" );
    objectives::scripted( "obj_panic_room", undefined, #"hash_a04fb95d36cb44" );
    objectives::function_572778b9( "obj_panic_room" );
    var_7b2ec835 = getent( "panic_room_door", "targetname" );
    var_68de788c = struct::get( "panic_room_door_moveto", "targetname" );
    var_7b2ec835 moveto( var_68de788c.origin, 5 );
    namespace_307260b8::function_2b6287f4( "panic_room_obj_complete" );
    objectives::complete( "obj_panic_room" );
}

// Namespace namespace_b16b5bf9/namespace_b16b5bf9
// Params 0
// Checksum 0x8897884d, Offset: 0x2d40
// Size: 0x1b4
function function_40d6f2bd()
{
    t_spawn = getent( "panic_room_encounter_trig", "targetname" );
    t_spawn waittill( #"trigger" );
    var_7f176a87 = struct::get( "panic_room_enemies_lookat", "targetname" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_7f176a87.origin, cos( 15 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), var_7f176a87.origin, 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    var_3665bea = spawner::simple_spawn( "panic_room_encounter_enemies" );
    var_8dfae19f = array::random( var_3665bea );
    var_8dfae19f hms_util::dialogue( "vox_cp_cbcr_01200_csm2_ididntsignupfor_ad" );
}

