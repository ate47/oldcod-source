#using script_1351b3cdb6539f9b;
#using script_2c735a5dfef64a44;
#using script_5a7c9cfbe3d9580c;
#using script_61fee52bb750ac99;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_b092382c;

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x66e3c349, Offset: 0x1840
// Size: 0x304
function function_c26b0bc0()
{
    level flag::init( "player_in_infinite_hallway" );
    level flag::init( "infinite_hallway_visit_1" );
    level flag::init( "infinite_hallway_visit_2" );
    level flag::init( "infinite_hallway_visit_3" );
    level flag::init( "infinite_hallway_visit_4" );
    level flag::init( "infinite_hallway_corridor_loop_1" );
    level flag::init( "infinite_hallway_corridor_loop_2" );
    level flag::init( "infinite_hallway_corridor_loop_3" );
    level flag::init( "infinite_hallway_corridor_loop_4" );
    level flag::init( "infinite_hallway_visit_door_jump" );
    level flag::init( "infinite_hallway_visit_loop" );
    level flag::init( "infinite_hallway_visit_lab" );
    level flag::init( "infinite_hallway_visit_loop_complete" );
    level flag::init( "flag_injection_response_vo_said" );
    level flag::init( "flag_infinite_hallway_corridor_blocker_1" );
    level flag::init( "flag_infinite_hallway_corridor_blocker_2" );
    level flag::init( "flag_infinite_hallway_loop_door_blocker" );
    level flag::init( "flag_exit_door_pos_1_wall" );
    level flag::init( "flag_exit_door_pos_2_wall" );
    level flag::init( "flag_exit_door_pos_3_wall" );
    level flag::init( "flag_exit_door_pos_4_wall" );
    level flag::init( "flag_delete_shrinking_loop" );
    level flag::init( "infinite_hallway_exit_ready" );
    level flag::init( "infinite_hallway_exited" );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x67df5582, Offset: 0x1b50
// Size: 0x47c
function function_4d08a806()
{
    level flag::wait_till( "player_in_infinite_hallway" );
    
    if ( !isdefined( level.var_2ae942a4 ) || isdefined( level.var_2ae942a4 ) && level.var_2ae942a4 == 0 )
    {
        while ( !isdefined( level.var_2ae942a4 ) || isdefined( level.var_2ae942a4 ) && level.var_2ae942a4 == 0 )
        {
            wait 0.05;
        }
    }
    
    if ( level.var_2ae942a4 == 1 )
    {
        dialogue::radio( "vox_cp_prsn_09000_adlr_idontcareifthed_de" );
        level childthread namespace_d9b153b9::function_f6cbf7fd( &function_aecd6152, 1, 10, "infinite_hallway_visit_door_jump" );
        level flag::wait_till( "infinite_hallway_visit_door_jump" );
    }
    
    if ( level.var_2ae942a4 == 2 )
    {
        namespace_d9b153b9::function_f76551eb( "vox_cp_prsn_09000_adlr_parkgivebellano_46", "vox_cp_prsn_09000_adlr_lazargivebellan_b2", "vox_cp_prsn_09000_adlr_simsgivebellano_54" );
        level thread function_87dcd561();
        level flag::wait_till_any( array( "flag_start_injection_failsafe", "flag_injection_response_vo_said" ) );
        level thread dialogue::radio( "vox_cp_prsn_09000_adlr_doitnow_53", undefined, undefined, 1 );
        
        if ( level flag::get( "flag_start_injection_failsafe" ) )
        {
            wait 1.25;
        }
        else
        {
            level flag::wait_till( "flag_start_injection_failsafe" );
        }
        
        level notify( #"hash_3b491810b066469a" );
        wait 3;
        namespace_d9b153b9::function_f76551eb( "vox_cp_prsn_09000_park_heartrateisspik_04", "vox_cp_prsn_09000_lazr_thosearesomeser_6f", "vox_cp_prsn_09000_sims_thisissomefucke_67" );
        level flag::wait_till( "flag_start_door_jump_3" );
        wait 2;
        namespace_d9b153b9::function_f76551eb( "vox_cp_prsn_09000_park_goodeverythings_77", "vox_cp_prsn_09000_lazr_waititlookslike_a2", "vox_cp_prsn_09000_sims_hangintherebell_c3" );
        level flag::wait_till( "infinite_hallway_visit_loop" );
    }
    
    if ( level.var_2ae942a4 == 3 )
    {
        level waittilltimeout( 60, #"corridor_1_door_3" );
        dialogue::radio( "vox_cp_prsn_09000_adlr_bellgothroughad_38" );
        
        while ( true )
        {
            level flag::wait_till( "corridor_2_activate" );
            
            if ( level.var_f668e14a == 2 )
            {
                break;
            }
            
            wait 0.1;
        }
        
        str_vo = util::function_3ac6fa36( "vox_cp_prsn_09000_adlr_whyisbellrepeat_f9", "vox_cp_prsn_09000_adlr_whyisbellrepeat_fa", "vox_cp_prsn_09000_adlr_whyisbellrepeat_56" );
        dialogue::radio( str_vo );
        level thread function_985e188();
        level flag::wait_till( "infinite_hallway_visit_lab" );
    }
    
    if ( level.var_2ae942a4 == 4 )
    {
        dialogue::radio( "vox_cp_prsn_09000_adlr_whatthelabagain_19" );
        level flag::wait_till_any( array( "flag_drop_player_through_floor_vo", "flag_start_memory_perseus" ) );
        
        if ( level flag::get( "flag_drop_player_through_floor_vo" ) )
        {
            dialogue::radio( "vox_cp_prsn_09000_adlr_bellforgetabout_a3" );
        }
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x74dd3711, Offset: 0x1fd8
// Size: 0x84
function function_87dcd561()
{
    level endon( #"flag_start_injection_failsafe" );
    
    if ( !level flag::get( "flag_start_injection_failsafe" ) )
    {
        level namespace_d9b153b9::function_f76551eb( "vox_cp_prsn_09000_park_thatcouldbeleth_ec", "vox_cp_prsn_09000_lazr_idontknowifthat_05", "vox_cp_prsn_09000_sims_yousurebellshea_fc" );
        level flag::set( "flag_injection_response_vo_said" );
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0xef06d18d, Offset: 0x2068
// Size: 0x1c
function function_aecd6152()
{
    dialogue::radio( "vox_cp_prsn_09000_adlr_aghjustforgetit_90" );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x987a770f, Offset: 0x2090
// Size: 0xe4
function function_985e188()
{
    level.infinite_hallway_loop_unlock_door_struct.door_interact endon( #"trigger" );
    level endon( #"infinite_hallway_visit_lab" );
    level endon( #"infinite_hallway_visit_loop_complete" );
    level flag::wait_till( "flag_player_exiting_shrinking_loop" );
    dialogue::radio( "vox_cp_prsn_09000_adlr_bellstopspeakin_2d" );
    wait randomintrange( 8, 12 );
    dialogue::radio( "vox_cp_prsn_09000_adlr_stopwastingmyti_8c" );
    wait randomintrange( 8, 12 );
    dialogue::radio( "vox_cp_prsn_09000_adlr_turnaroundbell_4b" );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x9c4e04dd, Offset: 0x2180
// Size: 0xf68
function function_ce927147()
{
    level.infinite_hallway_exit_unlock_door_struct = namespace_d9b153b9::door_setup( "infinite_hallway_exit_unlock_door_struct", undefined, 1 );
    level.infinite_hallway_loop_unlock_door_struct = namespace_d9b153b9::door_setup( "infinite_hallway_loop_unlock_door_struct" );
    level.infinite_hallway_loop_unlock_door_struct thread function_906a95e5();
    level flag::clear( "flag_exit_door_pos_1_wall" );
    level flag::set( "flag_exit_door_pos_2_wall" );
    level flag::set( "flag_exit_door_pos_3_wall" );
    level flag::set( "flag_exit_door_pos_4_wall" );
    level flag::clear( "flag_infinite_hallway_loop_door_blocker" );
    level flag::set( "flag_infinite_hallway_corridor_blocker_1" );
    level flag::set( "flag_infinite_hallway_corridor_blocker_2" );
    level.infinite_hallway_exit_door_facade = getentarray( "infinite_hallway_exit_door_facade", "script_noteworthy" );
    level.infinite_hallway_loop_door_facade = getentarray( "infinite_hallway_loop_door_facade", "script_noteworthy" );
    level.var_5ab10178 = [];
    level.var_4adb0f8 = struct::get_array( "infinite_hallway_hallway_door_struct", "targetname" );
    
    foreach ( struct in level.var_4adb0f8 )
    {
        struct = namespace_d9b153b9::door_setup( undefined, struct );
        struct.original_origin = struct.origin;
        struct.original_angles = struct.angles;
        struct thread function_801debe2();
        
        if ( isdefined( struct.script_noteworthy ) )
        {
            if ( struct.script_noteworthy == "corridor_1_door_1" || struct.script_noteworthy == "corridor_1_door_2" )
            {
                if ( isdefined( struct.door_left ) )
                {
                    if ( !isdefined( level.var_5ab10178 ) )
                    {
                        level.var_5ab10178 = [];
                    }
                    else if ( !isarray( level.var_5ab10178 ) )
                    {
                        level.var_5ab10178 = array( level.var_5ab10178 );
                    }
                    
                    level.var_5ab10178[ level.var_5ab10178.size ] = struct.door_left;
                }
                
                if ( isdefined( struct.door_frame ) )
                {
                    if ( !isdefined( level.var_5ab10178 ) )
                    {
                        level.var_5ab10178 = [];
                    }
                    else if ( !isarray( level.var_5ab10178 ) )
                    {
                        level.var_5ab10178 = array( level.var_5ab10178 );
                    }
                    
                    level.var_5ab10178[ level.var_5ab10178.size ] = struct.door_frame;
                }
            }
            
            struct.var_3deb0c3d = struct::get( struct.script_noteworthy + "_shrinking_pos", "targetname" );
        }
    }
    
    level.infinite_hallway_lab_backtrack_blocker = getent( "infinite_hallway_lab_backtrack_blocker", "targetname" );
    level.infinite_hallway_lab_floor = getentarray( "infinite_hallway_lab_floor", "targetname" );
    level.infinite_hallway_bunker_ceiling = getentarray( "infinite_hallway_bunker_ceiling", "targetname" );
    level.corridor_1_pipe_script_brushmodels = getentarray( "corridor_1_pipe_script_brushmodels", "targetname" );
    level.corridor_2_corner_pipe_script_brushmodels = getentarray( "corridor_2_corner_pipe_script_brushmodels", "targetname" );
    level.corridor_2_pipe_script_brushmodels = getentarray( "corridor_2_pipe_script_brushmodels", "targetname" );
    level.corridor_3_pipe_script_brushmodels = getentarray( "corridor_3_pipe_script_brushmodels", "targetname" );
    level.player_exiting_shrinking_loop_trigger = getent( "player_exiting_shrinking_loop_trigger", "targetname" );
    level.player_exiting_shrinking_loop_trigger triggerenable( 0 );
    level.player_exiting_shrinking_loop_trigger.trigger_off = 1;
    level.var_57e54c86 = getentarray( "corridor_1_corner", "targetname" );
    level.var_4620ea49 = getentarray( "corridor_1_hall", "targetname" );
    level.var_cf2a2b72 = struct::get( "corridor_1_corner_start", "targetname" );
    level.var_2a353790 = spawn( "script_model", struct::get( "corridor_1_corner_original_struct", "targetname" ).origin );
    level.var_2a353790 setmodel( #"tag_origin" );
    
    foreach ( ent in level.var_4620ea49 )
    {
        if ( isdefined( ent ) )
        {
            ent linkto( level.var_2a353790, "tag_origin" );
        }
    }
    
    level.var_be8a7ed0 = getentarray( "corridor_2_corner", "targetname" );
    level.var_30d625b7 = getentarray( "corridor_2_hall", "targetname" );
    level.var_dcfead6b = struct::get( "corridor_2_corner_start", "targetname" );
    level.var_3814631a = spawn( "script_model", struct::get( "corridor_2_corner_original_struct", "targetname" ).origin );
    level.var_3814631a setmodel( #"tag_origin" );
    level.var_a77dd496 = spawn( "script_model", struct::get( "corridor_2_corner_original_struct", "targetname" ).origin );
    level.var_a77dd496 setmodel( #"tag_origin" );
    
    foreach ( ent in level.var_be8a7ed0 )
    {
        if ( isdefined( ent ) )
        {
            ent linkto( level.var_3814631a, "tag_origin" );
        }
    }
    
    foreach ( ent in level.var_30d625b7 )
    {
        if ( isdefined( ent ) )
        {
            ent linkto( level.var_a77dd496, "tag_origin" );
        }
    }
    
    level.var_340b140b = getentarray( "corridor_3_corner", "targetname" );
    level.var_723c531e = getentarray( "corridor_3_hall", "targetname" );
    level.var_9bae4ba1 = struct::get( "corridor_3_corner_start", "targetname" );
    level.var_1193c77e = spawn( "script_model", struct::get( "corridor_3_corner_original_struct", "targetname" ).origin );
    level.var_1193c77e setmodel( #"tag_origin" );
    level.var_a47ab6eb = spawn( "script_model", struct::get( "corridor_3_corner_original_struct", "targetname" ).origin );
    level.var_a47ab6eb setmodel( #"tag_origin" );
    
    foreach ( ent in level.var_340b140b )
    {
        if ( isdefined( ent ) )
        {
            ent linkto( level.var_1193c77e, "tag_origin" );
        }
    }
    
    foreach ( ent in level.var_723c531e )
    {
        if ( isdefined( ent ) )
        {
            ent linkto( level.var_a47ab6eb, "tag_origin" );
        }
    }
    
    level.var_8f1b4e46 = getentarray( "corridor_4_corner", "targetname" );
    level.var_624718c0 = getentarray( "corridor_4_hall", "targetname" );
    level.var_9c6cfa20 = struct::get( "corridor_4_corner_start", "targetname" );
    level.var_92bf0856 = spawn( "script_model", struct::get( "corridor_4_corner_original_struct", "targetname" ).origin );
    level.var_92bf0856 setmodel( #"tag_origin" );
    level.var_ff9012a = spawn( "script_model", struct::get( "corridor_4_corner_original_struct", "targetname" ).origin );
    level.var_ff9012a setmodel( #"tag_origin" );
    
    foreach ( ent in level.var_8f1b4e46 )
    {
        if ( isdefined( ent ) )
        {
            ent linkto( level.var_92bf0856, "tag_origin" );
        }
    }
    
    foreach ( ent in level.var_624718c0 )
    {
        if ( isdefined( ent ) )
        {
            ent linkto( level.var_ff9012a, "tag_origin" );
        }
    }
    
    level.corner_1_curved_geo = getentarray( "corner_1_curved_geo", "targetname" );
    
    foreach ( ent in level.corner_1_curved_geo )
    {
        if ( isdefined( ent ) )
        {
            ent hide();
        }
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x6cd49448, Offset: 0x30f0
// Size: 0x8c
function function_906a95e5()
{
    level flag::wait_till( "infinite_hallway_exit_ready" );
    self.door_left setmodel( "p9_vnm_door_bunker_metal_01c" );
    self thread namespace_d9b153b9::function_736b8a03( 1 );
    self thread namespace_b6fe1dbe::function_2982df9f();
    level thread function_dbcfb3e2( self );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0xcf0fc010, Offset: 0x3188
// Size: 0x384
function function_6716d9ce()
{
    level.var_464aabd3 = 0;
    tv = spawn( "script_model", self.origin );
    tv.angles = self.angles;
    tv setmodel( "cp_disco_tv_crt_01_off" );
    
    if ( isdefined( self.script_noteworthy ) && ( issubstr( self.script_noteworthy, "1" ) || issubstr( self.script_noteworthy, "3" ) ) )
    {
        level flag::wait_till( "infinite_hallway_visit_2" );
    }
    else if ( isdefined( self.script_noteworthy ) && issubstr( self.script_noteworthy, "2" ) )
    {
        level flag::wait_till( "infinite_hallway_visit_3" );
    }
    
    tv.usable = spawn( "script_model", self.origin );
    tv.usable setmodel( "tag_origin" );
    fwd = anglestoforward( self.angles + ( 0, -90, 0 ) );
    offset = ( fwd[ 0 ] * 12, fwd[ 1 ] * 12, 8 );
    tv.usable util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ) + offset, #"hash_19a0613cf790542e" );
    util::waittill_any_ents( tv.usable, "trigger", level, "infinite_hallway_exited", level, "infinite_hallway_visit_loop" );
    
    if ( !level flag::get( "infinite_hallway_visit_loop" ) && !level flag::get( "infinite_hallway_exited" ) )
    {
        tv setmodel( "cp_disco_tv_crt_01_on" );
        level.var_464aabd3++;
    }
    
    tv.usable util::remove_cursor_hint();
    
    if ( level.var_464aabd3 == 3 )
    {
        level flag::set( "infinite_hallway_exit_ready" );
    }
    
    if ( !level flag::get( "infinite_hallway_exited" ) )
    {
        level flag::wait_till( "infinite_hallway_exited" );
    }
    
    if ( isdefined( tv.usable ) )
    {
        tv.usable delete();
    }
    
    if ( isdefined( tv ) )
    {
        tv delete();
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0xef90cace, Offset: 0x3518
// Size: 0xec
function function_801debe2()
{
    self thread namespace_d9b153b9::ent_cleanup( "infinite_hallway_exited", 1 );
    
    if ( isdefined( self.script_noteworthy ) )
    {
        clip = getent( self.script_noteworthy + "_clip", "targetname" );
        
        if ( isdefined( clip ) )
        {
            clip linkto( self.door_left );
            clip thread namespace_d9b153b9::ent_cleanup( "infinite_hallway_exited", 1 );
        }
    }
    
    level waittill( #"hash_aeb81dcad8cbb5d" );
    self.door_left thread function_3f816598( 1, 0.05 );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 4
// Checksum 0x54f80aeb, Offset: 0x3610
// Size: 0x172
function function_3f816598( open, time, sfx, var_e0b06bb2 )
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0.5;
    }
    
    if ( isdefined( open ) )
    {
        if ( !isdefined( self.open ) )
        {
            self.open = 1;
            fwd = anglestoforward( self.angles );
            self rotateyaw( fwd[ 1 ] + 90, time );
            wait time;
        }
        
        return;
    }
    
    if ( isdefined( self.open ) )
    {
        self.open = undefined;
        fwd = anglestoforward( self.angles );
        self rotateyaw( fwd[ 1 ] + -90, time );
        
        if ( isdefined( sfx ) )
        {
            level thread namespace_b6fe1dbe::tmp_cp_nam_bunk_door_slam( self );
        }
        
        wait time;
        
        if ( isdefined( var_e0b06bb2 ) && isstring( var_e0b06bb2 ) )
        {
            level notify( var_e0b06bb2 );
        }
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x2870be8e, Offset: 0x3790
// Size: 0x448
function infinite_hallway()
{
    level thread savegame::checkpoint_save();
    level.var_3f5c80c8 = "infinite_hallway";
    level thread namespace_b6fe1dbe::pre_injection_hallway_sfx();
    level function_ce927147();
    level.infinite_hallway_loop_unlock_door_struct scene::init( "scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left );
    
    if ( !isdefined( level.var_2ae942a4 ) )
    {
        level.var_2ae942a4 = 0;
        level.infinite_hallway_exit_unlock_door_struct scene::init( "scene_pri_bunker_open_locked", array( level.infinite_hallway_exit_unlock_door_struct.door_left, level.players[ 0 ] ) );
        level.infinite_hallway_exit_unlock_door_struct scene::play( "scene_pri_bunker_open_locked" );
    }
    
    level flag::set( "player_in_infinite_hallway" );
    level endon( #"infinite_hallway_exited" );
    level.infinite_hallway_loop_unlock_door_struct.door_left.original_origin = level.infinite_hallway_loop_unlock_door_struct.door_left.origin;
    level.infinite_hallway_loop_unlock_door_struct.door_left.original_angles = level.infinite_hallway_loop_unlock_door_struct.door_left.angles;
    
    while ( true )
    {
        level thread function_c51fa7f2();
        
        if ( level.var_2ae942a4 != 4 )
        {
            level.infinite_hallway_loop_unlock_door_struct thread namespace_b6fe1dbe::function_2982df9f();
        }
        
        level.infinite_hallway_loop_unlock_door_struct.door_interact waittill( #"trigger" );
        level.infinite_hallway_exit_unlock_door_struct.door_left hide();
        
        if ( isdefined( level.var_ffd4e184 ) )
        {
            level.var_ffd4e184 scene::play( "scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left );
        }
        else
        {
            level.infinite_hallway_loop_unlock_door_struct scene::play( "scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left );
        }
        
        level notify( #"hash_74917a0c21f8e670" );
        
        if ( level.var_2ae942a4 == 3 )
        {
            infinite_hallway_lab_unlock_door_struct = struct::get( "infinite_hallway_lab_unlock_door_struct", "targetname" );
            level function_7841bdbc( infinite_hallway_lab_unlock_door_struct, "p9_vnm_door_bunker_metal_01c", undefined, "scene_pri_bunker_open" );
        }
        else
        {
            infinite_hallway_loop_open_door_struct = struct::get( "infinite_hallway_loop_open_door_struct", "targetname" );
            level function_7841bdbc( infinite_hallway_loop_open_door_struct, "p9_vnm_door_bunker_metal_01c", undefined, "scene_pri_bunker_open" );
        }
        
        level.infinite_hallway_exit_unlock_door_struct.door_left show();
        level.infinite_hallway_exit_unlock_door_struct scene::init( "scene_pri_bunker_unlock", level.infinite_hallway_exit_unlock_door_struct.door_left );
        
        if ( level.var_2ae942a4 == 2 )
        {
            level.infinite_hallway_loop_unlock_door_struct waittill( #"hash_4c6b60cd2908ac8" );
        }
        
        level.infinite_hallway_loop_unlock_door_struct scene::init( "scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left );
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 4
// Checksum 0x5c16423e, Offset: 0x3be0
// Size: 0x144
function function_7841bdbc( door_struct, door_model, var_139422, var_7360fbce )
{
    var_e4697d75 = spawn( "script_model", door_struct.origin );
    var_e4697d75.angles = door_struct.angles;
    var_e4697d75 setmodel( door_model );
    
    if ( isdefined( var_139422 ) )
    {
        var_9e32ce68 = spawn( "script_model", door_struct.origin );
        var_9e32ce68.angles = door_struct.angles;
        var_9e32ce68 setmodel( var_139422 );
    }
    
    door_struct scene::init( var_7360fbce, var_e4697d75 );
    door_struct scene::play( var_7360fbce, var_e4697d75 );
    level notify( #"hash_5d251e3bf4fc5f57" );
    var_e4697d75 delete();
    
    if ( isdefined( var_139422 ) )
    {
        var_9e32ce68 delete();
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0xa08bc897, Offset: 0x3d30
// Size: 0x174
function function_c51fa7f2()
{
    level.var_2ae942a4++;
    flag = "infinite_hallway_visit_" + level.var_2ae942a4;
    
    if ( level flag::exists( flag ) )
    {
        level flag::set( flag );
    }
    
    if ( level.var_2ae942a4 == 1 )
    {
        level thread infinite_hallway_visit_1();
        level thread namespace_b6fe1dbe::function_c635eb23( 1 );
        return;
    }
    
    if ( level.var_2ae942a4 == 2 )
    {
        level thread infinite_hallway_visit_2();
        level thread namespace_b6fe1dbe::function_c635eb23( 2 );
        return;
    }
    
    if ( level.var_2ae942a4 == 3 )
    {
        level thread infinite_hallway_visit_3();
        level thread namespace_b6fe1dbe::function_c635eb23( 3 );
        return;
    }
    
    if ( level.var_2ae942a4 == 4 )
    {
        level thread infinite_hallway_visit_4();
        level thread namespace_b6fe1dbe::function_c635eb23( 4 );
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x7505c2f6, Offset: 0x3eb0
// Size: 0x3d4
function infinite_hallway_visit_1()
{
    var_4dd78966 = [];
    is_offscreen = 0;
    
    while ( !is_offscreen )
    {
        foreach ( ent in level.infinite_hallway_exit_door_facade )
        {
            if ( !util::within_fov( level.players[ 0 ].origin, level.players[ 0 ].angles, ent.origin, cos( 70 ) ) )
            {
                if ( !isinarray( var_4dd78966, ent ) )
                {
                    if ( !isdefined( var_4dd78966 ) )
                    {
                        var_4dd78966 = [];
                    }
                    else if ( !isarray( var_4dd78966 ) )
                    {
                        var_4dd78966 = array( var_4dd78966 );
                    }
                    
                    if ( !isinarray( var_4dd78966, ent ) )
                    {
                        var_4dd78966[ var_4dd78966.size ] = ent;
                    }
                }
                
                continue;
            }
            
            if ( array::contains( ent ) )
            {
                arrayremovevalue( var_4dd78966, ent );
            }
        }
        
        if ( var_4dd78966.size == level.infinite_hallway_exit_door_facade.size )
        {
            is_offscreen = 1;
            continue;
        }
        
        wait 0.1;
    }
    
    foreach ( ent in level.infinite_hallway_exit_door_facade )
    {
        if ( isdefined( ent ) )
        {
            ent hide();
        }
    }
    
    level flag::set( "flag_exit_door_pos_1_wall" );
    level thread namespace_b508dca::function_ed113f39( 1, "infinite_hallway_exit_unlock_door_struct" );
    level.infinite_hallway_loop_unlock_door_struct.door_interact waittill( #"trigger" );
    level flag::clear( "flag_exit_door_pos_1_wall" );
    level waittill( #"hash_5d251e3bf4fc5f57" );
    
    foreach ( ent in level.infinite_hallway_exit_door_facade )
    {
        if ( isdefined( ent ) )
        {
            ent show();
        }
    }
    
    level thread namespace_b508dca::function_ed113f39( undefined, "infinite_hallway_exit_unlock_door_struct" );
    level.infinite_hallway_exit_unlock_door_struct thread namespace_d9b153b9::function_736b8a03();
    level.infinite_hallway_exit_unlock_door_struct.door_left setmodel( "p9_vnm_door_bunker_metal_01c_gray" );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 1
// Checksum 0x315a8066, Offset: 0x4290
// Size: 0x198
function function_19d60154( var_35b4eb77 )
{
    level.var_ffd4e184 = spawn( "script_model", self.origin );
    level.var_ffd4e184.angles = self.angles;
    
    foreach ( ent in self.linked_ents )
    {
        if ( isdefined( ent ) )
        {
            ent enablelinkto();
            ent linkto( level.var_ffd4e184 );
        }
    }
    
    foreach ( ent in var_35b4eb77 )
    {
        if ( isdefined( ent ) )
        {
            ent enablelinkto();
            ent linkto( level.var_ffd4e184 );
        }
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x1275d405, Offset: 0x4430
// Size: 0x4cc
function infinite_hallway_visit_2()
{
    level endon( #"infinite_hallway_exited" );
    level flag::set( "infinite_hallway_visit_door_jump" );
    level.infinite_hallway_loop_unlock_door_struct namespace_d9b153b9::function_736b8a03( 1 );
    level thread function_45d4b385();
    level flag::wait_till( "flag_start_door_jump_1" );
    
    if ( !isdefined( level.var_ffd4e184 ) )
    {
        level.infinite_hallway_loop_unlock_door_struct function_19d60154( level.infinite_hallway_loop_door_facade );
    }
    
    infinite_hallway_jump_1 = struct::get( "infinite_hallway_jump_1", "targetname" );
    level.var_ffd4e184.origin = infinite_hallway_jump_1.origin;
    level thread namespace_b6fe1dbe::tmp_cp_nam_bunk_door_jumpback_01();
    level flag::wait_till( "flag_start_door_jump_2" );
    infinite_hallway_jump_2 = struct::get( "infinite_hallway_jump_2", "targetname" );
    level.var_ffd4e184.origin = infinite_hallway_jump_2.origin;
    level thread namespace_b6fe1dbe::tmp_cp_nam_bunk_door_jumpback_02();
    level thread exploder::exploder( "lgt_hallway_doorjump_02" );
    level flag::wait_till( "flag_start_door_jump_3" );
    infinite_hallway_jump_3 = struct::get( "infinite_hallway_jump_3", "targetname" );
    level.var_ffd4e184.origin = infinite_hallway_jump_3.origin;
    level thread namespace_b6fe1dbe::tmp_cp_nam_bunk_door_jumpback_03();
    level thread exploder::stop_exploder( "lgt_hallway_doorjump_02" );
    level thread exploder::exploder( "lgt_hallway_doorjump" );
    level.infinite_hallway_loop_unlock_door_struct.door_interact waittill( #"trigger" );
    level notify( #"hash_aeb81dcad8cbb5d" );
    level waittill( #"hash_5d251e3bf4fc5f57" );
    level.infinite_hallway_loop_unlock_door_struct scene::stop( "scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left );
    wait 0.1;
    level.var_ffd4e184.origin = level.infinite_hallway_loop_unlock_door_struct.origin;
    wait 0.1;
    
    foreach ( ent in level.infinite_hallway_loop_unlock_door_struct.linked_ents )
    {
        if ( isdefined( ent ) )
        {
            ent unlink();
        }
    }
    
    foreach ( ent in level.infinite_hallway_loop_door_facade )
    {
        if ( isdefined( ent ) )
        {
            ent unlink();
        }
    }
    
    wait 0.1;
    level.var_ffd4e184 delete();
    level.infinite_hallway_loop_unlock_door_struct.door_left.origin = level.infinite_hallway_loop_unlock_door_struct.door_left.original_origin;
    waitframe( 1 );
    level.infinite_hallway_loop_unlock_door_struct notify( #"hash_4c6b60cd2908ac8" );
    level thread exploder::stop_exploder( "lgt_hallway_doorjump" );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x4ac40e5d, Offset: 0x4908
// Size: 0xf4
function function_45d4b385()
{
    level waittill( #"hash_3b491810b066469a" );
    player = level.players[ 0 ];
    player util::blend_movespeedscale( 0.4, 0.05 );
    player namespace_d9b153b9::pstfx_injection( 1 );
    level flag::wait_till( "flag_start_door_jump_2" );
    level flag::wait_till( "flag_start_door_jump_3" );
    player namespace_d9b153b9::pstfx_injection( 0 );
    player util::blend_movespeedscale( 1, 2 );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x50fa0419, Offset: 0x4a08
// Size: 0x73c
function infinite_hallway_visit_3()
{
    level endon( #"infinite_hallway_exited" );
    level flag::set( "infinite_hallway_visit_loop" );
    level thread namespace_b508dca::function_ed113f39( 1, "infinite_hallway_loop_unlock_door_struct" );
    level.infinite_hallway_loop_unlock_door_struct.hidden = 1;
    
    foreach ( ent in level.infinite_hallway_loop_door_facade )
    {
        if ( isdefined( ent ) )
        {
            ent hide();
        }
    }
    
    level thread function_14147c77();
    level thread function_87b67c58();
    level flag::set( "flag_infinite_hallway_loop_door_blocker" );
    level flag::clear( "flag_infinite_hallway_corridor_blocker_1" );
    level flag::wait_till( "unblock_infinite_hallway_corridor_blocker_2" );
    level flag::clear( "flag_infinite_hallway_corridor_blocker_2" );
    level flag::set( "flag_infinite_hallway_corridor_1_corner_geo" );
    
    foreach ( ent in level.corner_1_curved_geo )
    {
        if ( isdefined( ent ) )
        {
            ent show();
        }
    }
    
    wait 0.25;
    level thread namespace_b508dca::function_ed113f39( 1, "infinite_hallway_exit_unlock_door_struct" );
    level.infinite_hallway_exit_unlock_door_struct.hidden = 1;
    
    foreach ( ent in level.infinite_hallway_exit_door_facade )
    {
        if ( isdefined( ent ) )
        {
            ent hide();
        }
    }
    
    level flag::set( "flag_exit_door_pos_1_wall" );
    level thread function_7e5818d6();
    level.infinite_hallway_loop_unlock_door_struct.door_interact waittill( #"trigger" );
    level waittill( #"hash_74917a0c21f8e670" );
    level.infinite_hallway_loop_unlock_door_struct.door_left hide();
    
    foreach ( ent in level.infinite_hallway_exit_door_facade )
    {
        if ( isdefined( ent ) )
        {
            ent show();
        }
    }
    
    level flag::clear( "flag_exit_door_pos_1_wall" );
    level flag::clear( "flag_infinite_hallway_loop_door_blocker" );
    level flag::set( "flag_infinite_hallway_corridor_blocker_1" );
    level flag::set( "flag_infinite_hallway_corridor_blocker_2" );
    level.var_ffd4e184.origin = level.infinite_hallway_loop_unlock_door_struct.origin;
    level.var_ffd4e184.angles = level.infinite_hallway_loop_unlock_door_struct.angles;
    
    if ( isdefined( level.var_74dde09e ) )
    {
        foreach ( ent in level.var_74dde09e )
        {
            if ( isdefined( ent.linkname ) && ent.linkname != "exit_door_pos_1_wall" )
            {
                flag = "flag_" + ent.linkname;
                
                if ( level flag::exists( flag ) && !level flag::get( flag ) )
                {
                    level flag::set( flag );
                }
            }
        }
    }
    
    level waittill( #"hash_5d251e3bf4fc5f57" );
    level thread namespace_b508dca::function_ed113f39( undefined, "infinite_hallway_exit_unlock_door_struct" );
    level.infinite_hallway_loop_unlock_door_struct.door_left scene::stop();
    level.infinite_hallway_loop_unlock_door_struct.door_left.origin = level.infinite_hallway_loop_unlock_door_struct.door_left.original_origin;
    level.infinite_hallway_loop_unlock_door_struct.door_left.angles = level.infinite_hallway_loop_unlock_door_struct.door_left.original_angles;
    level.infinite_hallway_loop_unlock_door_struct scene::init( "scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left );
    level.infinite_hallway_loop_unlock_door_struct.door_left show();
    level flag::clear( "flag_infinite_hallway_corridor_1_corner_geo" );
    level flag::set( "infinite_hallway_visit_loop_complete" );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 1
// Checksum 0xc70cf224, Offset: 0x5150
// Size: 0x524
function function_24c67e2a( var_d5ebd613 )
{
    struct = struct::get( "exit_door_pos_" + var_d5ebd613 + "_struct", "targetname" );
    flag = "flag_update_exit_door_to_pos_" + var_d5ebd613;
    
    while ( level flag::get( flag ) )
    {
        if ( !util::within_fov( level.players[ 0 ].origin, level.players[ 0 ].angles, struct.origin + ( 0, 0, 64 ), cos( 70 ) ) && !util::within_fov( level.players[ 0 ].origin, level.players[ 0 ].angles, self.door_left.origin + ( 0, 0, 64 ), cos( 70 ) ) )
        {
            self.door_left scene::stop();
            
            if ( !isdefined( level.var_ffd4e184 ) )
            {
                self function_19d60154( level.infinite_hallway_loop_door_facade );
            }
            
            door_struct = struct::get( "exit_door_pos_" + var_d5ebd613 + "_door_struct", "targetname" );
            level.var_ffd4e184.origin = door_struct.origin;
            level.var_ffd4e184.angles = door_struct.angles;
            
            if ( isdefined( self.hidden ) )
            {
                level thread namespace_b508dca::function_ed113f39( undefined, "infinite_hallway_loop_unlock_door_struct" );
                level.infinite_hallway_loop_unlock_door_struct.hidden = undefined;
                
                foreach ( ent in level.infinite_hallway_loop_door_facade )
                {
                    if ( isdefined( ent ) )
                    {
                        ent show();
                    }
                }
            }
            
            if ( isdefined( level.var_74dde09e ) )
            {
                foreach ( ent in level.var_74dde09e )
                {
                    if ( isdefined( ent.linkname ) )
                    {
                        flag = "flag_" + ent.linkname;
                        
                        if ( level flag::exists( flag ) && !level flag::get( flag ) )
                        {
                            level flag::set( flag );
                        }
                    }
                }
            }
            
            level.var_74dde09e = getentarray( "exit_door_pos_" + var_d5ebd613 + "_wall", "script_noteworthy" );
            
            foreach ( ent in level.var_74dde09e )
            {
                if ( isdefined( ent.linkname ) )
                {
                    flag = "flag_" + ent.linkname;
                    
                    if ( level flag::exists( flag ) && level flag::get( flag ) )
                    {
                        level flag::clear( flag );
                    }
                }
            }
            
            level.var_ffd4e184 scene::init( "scene_pri_bunker_unlock", self.door_left );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x789323d8, Offset: 0x5680
// Size: 0x148
function function_7e5818d6()
{
    level.infinite_hallway_loop_unlock_door_struct.door_interact endon( #"trigger" );
    var_2bcd20d6 = "flag_update_exit_door_to_pos_4";
    
    while ( true )
    {
        level flag::wait_till( "flag_update_exit_door_to_pos_1" );
        level.infinite_hallway_loop_unlock_door_struct function_24c67e2a( 1 );
        level flag::wait_till( "flag_update_exit_door_to_pos_2" );
        level.infinite_hallway_loop_unlock_door_struct function_24c67e2a( 2 );
        level flag::wait_till( "flag_update_exit_door_to_pos_3" );
        level.infinite_hallway_loop_unlock_door_struct function_24c67e2a( 3 );
        level flag::wait_till( "flag_update_exit_door_to_pos_4" );
        level.infinite_hallway_loop_unlock_door_struct function_24c67e2a( 4 );
        wait 0.05;
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 2
// Checksum 0xb479bc08, Offset: 0x57d0
// Size: 0x17c
function function_5f2165df( hide, var_6cd0b669 )
{
    if ( isdefined( hide ) )
    {
        if ( isstruct( self ) )
        {
            if ( isdefined( self.targetname ) && issubstr( self.targetname, var_6cd0b669 ) )
            {
                if ( !isdefined( self.var_8cfd0ab2 ) )
                {
                    self.var_8cfd0ab2 = spawn( "script_model", self.origin );
                    self.var_8cfd0ab2.angles = self.angles;
                    self.var_8cfd0ab2 setmodel( self.model );
                    self.var_8cfd0ab2 thread namespace_d9b153b9::ent_cleanup( "infinite_hallway_exited", 1 );
                }
                
                self.var_8cfd0ab2 show();
            }
        }
        
        return;
    }
    
    if ( isstruct( self ) )
    {
        if ( isdefined( self.targetname ) && isdefined( self.var_8cfd0ab2 ) && issubstr( self.targetname, var_6cd0b669 ) )
        {
            self.var_8cfd0ab2 hide();
        }
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 3
// Checksum 0x526d90f2, Offset: 0x5958
// Size: 0x253c
function function_bf2933ed( var_158dfaa2, loop_count, activate )
{
    level endon( #"infinite_hallway_visit_loop_complete" );
    var_6dcda4d1 = getent( "corridor_" + var_158dfaa2 + "_volume", "targetname" );
    var_5f7546ed = "infinite_hallway_corridor_loop_" + loop_count;
    var_c79810e5 = struct::get_array( var_5f7546ed, "targetname" );
    var_6cd0b669 = "infinite_hallway_corridor_" + var_158dfaa2 + "_loop_" + loop_count;
    var_7525f383 = struct::get_array( "infinite_hallway_corridor_" + var_158dfaa2 + "_loop_" + loop_count, "targetname" );
    
    if ( isdefined( activate ) )
    {
        array::thread_all( var_7525f383, &function_5f2165df, 1, var_6cd0b669 );
        
        if ( loop_count == 1 )
        {
            foreach ( struct in level.var_4adb0f8 )
            {
                if ( isdefined( struct.door_left ) && isdefined( var_6dcda4d1 ) && struct.door_left istouching( var_6dcda4d1 ) )
                {
                    str = "corridor_" + var_158dfaa2;
                    
                    if ( issubstr( struct.script_noteworthy, str ) )
                    {
                        struct.door_left function_3f816598( 1, 0.05 );
                        wait 0.05;
                        struct thread function_acfb9b2d( var_5f7546ed );
                    }
                }
            }
            
            if ( var_158dfaa2 == 3 )
            {
                level thread scene::play( "scene_pri_hallway_loop_adler" );
                level thread namespace_b6fe1dbe::function_d4255748();
                setdvar( #"r_motionblurstrength", 1 );
                level thread exploder::exploder( "FX_hallway_shaky_head_adler" );
            }
            
            if ( var_158dfaa2 == 4 )
            {
            }
        }
        else if ( loop_count == 2 )
        {
            if ( var_158dfaa2 == 1 )
            {
                level.var_2ac670e8 = 1;
                
                if ( isdefined( level.var_3814631a ) )
                {
                    level.var_3814631a.origin = level.var_dcfead6b.origin;
                    
                    foreach ( brushmodel in level.var_be8a7ed0 )
                    {
                        if ( isdefined( brushmodel ) )
                        {
                            brushmodel show();
                        }
                    }
                    
                    level.var_f0d3e73b = level.var_dcfead6b.origin;
                    level.var_2a353790.origin = level.var_cf2a2b72.origin;
                    
                    foreach ( brushmodel in level.var_4620ea49 )
                    {
                        if ( isdefined( brushmodel ) )
                        {
                            brushmodel show();
                        }
                    }
                    
                    level namespace_d9b153b9::function_cf0f5dc6( level.var_5ab10178, 1 );
                    level util::function_bfa9c188( "corridor_1_dynmodel", 1 );
                    level namespace_d9b153b9::function_cf0f5dc6( level.corridor_1_pipe_script_brushmodels, 1 );
                    level util::function_bfa9c188( "corridor_2_corner_dynmodel", 1 );
                    level namespace_d9b153b9::function_cf0f5dc6( level.corridor_2_corner_pipe_script_brushmodels, 1 );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_02" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_02" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_03" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_03" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_03" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_04" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_04" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_04" );
                    level exploder::exploder( "lgt_shrinkhall_01" );
                }
            }
            
            if ( var_158dfaa2 == 2 )
            {
                level.var_4196ac75 = 1;
                
                if ( isdefined( level.var_1193c77e ) )
                {
                    level.var_1193c77e.origin = level.var_9bae4ba1.origin;
                    
                    foreach ( brushmodel in level.var_340b140b )
                    {
                        if ( isdefined( brushmodel ) )
                        {
                            brushmodel show();
                        }
                    }
                    
                    level.var_26e508a8 = level.var_9bae4ba1.origin;
                    level.var_a77dd496.origin = level.var_dcfead6b.origin;
                    
                    foreach ( brushmodel in level.var_30d625b7 )
                    {
                        if ( isdefined( brushmodel ) )
                        {
                            brushmodel show();
                        }
                    }
                    
                    level util::function_bfa9c188( "corridor_2_dynmodel", 1 );
                    level namespace_d9b153b9::function_cf0f5dc6( level.corridor_2_pipe_script_brushmodels, 1 );
                    corridor_2_corner = getentarray( "infinite_hallway_loop_door_blocker", "script_noteworthy" );
                    
                    foreach ( ent in corridor_2_corner )
                    {
                        if ( isdefined( ent.model ) && ent.model == "p9_vnm_laboratory_ceiling_02" )
                        {
                            ent hide();
                        }
                    }
                    
                    var_ce0740d0 = getentarray( "corridor_2_ceiling_pieces", "script_noteworthy" );
                    
                    foreach ( ent in var_ce0740d0 )
                    {
                        if ( isdefined( ent.model ) && ent.model == "p9_vnm_lab_ceiling_scripted_01" )
                        {
                            ent hide();
                        }
                    }
                    
                    level util::function_bfa9c188( "corridor_3_corner_dynmodel", 1 );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_05" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_05" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_06" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_06" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_06" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_07" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_07" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_07" );
                    level exploder::exploder( "lgt_shrinkhall_02" );
                    level thread namespace_b6fe1dbe::shrinking_hallway_start();
                    level thread namespace_b6fe1dbe::shrinking_hallway_unhide();
                }
            }
            
            if ( var_158dfaa2 == 3 )
            {
                level.var_2ade2100 = 1;
                
                if ( isdefined( level.var_92bf0856 ) )
                {
                    level.var_92bf0856.origin = level.var_9c6cfa20.origin;
                    
                    foreach ( brushmodel in level.var_8f1b4e46 )
                    {
                        if ( isdefined( brushmodel ) )
                        {
                            brushmodel show();
                        }
                    }
                    
                    level.var_60000886 = level.var_9c6cfa20.origin;
                    level.var_a47ab6eb.origin = level.var_9bae4ba1.origin;
                    
                    foreach ( brushmodel in level.var_723c531e )
                    {
                        if ( isdefined( brushmodel ) )
                        {
                            brushmodel show();
                        }
                    }
                    
                    level util::function_bfa9c188( "corridor_3_dynmodel", 1 );
                    level namespace_d9b153b9::function_cf0f5dc6( level.corridor_3_pipe_script_brushmodels, 1 );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_08" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_08" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_09" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_09" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_09" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_10" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_10" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_10" );
                    level exploder::exploder( "lgt_shrinkhall_03" );
                    level thread namespace_b6fe1dbe::shrinking_hallway_unhide();
                }
            }
            
            if ( var_158dfaa2 == 4 )
            {
                if ( isdefined( level.var_ff9012a ) )
                {
                    level.var_ff9012a.origin = level.var_9c6cfa20.origin;
                    
                    foreach ( brushmodel in level.var_624718c0 )
                    {
                        if ( isdefined( brushmodel ) )
                        {
                            brushmodel show();
                        }
                    }
                    
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_11" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_11" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_01" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_01" );
                    level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_01" );
                    level exploder::exploder( "lgt_shrinkhall_04" );
                    level thread namespace_b6fe1dbe::shrinking_hallway_unhide();
                }
            }
        }
        else if ( loop_count == 3 )
        {
            if ( var_158dfaa2 == 1 )
            {
                foreach ( brushmodel in level.var_be8a7ed0 )
                {
                    if ( isdefined( brushmodel ) )
                    {
                        brushmodel hide();
                    }
                }
                
                foreach ( brushmodel in level.var_4620ea49 )
                {
                    if ( isdefined( brushmodel ) )
                    {
                        brushmodel hide();
                    }
                }
                
                if ( !level flag::get( "infinite_hallway_visit_loop_complete" ) )
                {
                    level namespace_d9b153b9::function_cf0f5dc6( level.var_5ab10178 );
                    level util::function_bfa9c188( "corridor_1_dynmodel", 0 );
                    level namespace_d9b153b9::function_cf0f5dc6( level.corridor_1_pipe_script_brushmodels );
                    level util::function_bfa9c188( "corridor_2_corner_dynmodel", 0 );
                    level namespace_d9b153b9::function_cf0f5dc6( level.corridor_2_corner_pipe_script_brushmodels );
                    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_02" );
                    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_02" );
                    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_03" );
                    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_03" );
                    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_03" );
                    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_04" );
                    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_04" );
                    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_04" );
                    level exploder::stop_exploder( "lgt_shrinkhall_01" );
                    level thread namespace_b6fe1dbe::shrinking_hallway_unhide();
                }
                
                if ( isdefined( level.player_exiting_shrinking_loop_trigger.trigger_off ) )
                {
                    level.player_exiting_shrinking_loop_trigger triggerenable( 1 );
                    level.player_exiting_shrinking_loop_trigger.trigger_off = undefined;
                    level flag::set( "flag_enable_corridor_loop_cleanup" );
                }
            }
        }
        
        return;
    }
    
    if ( level.var_f668e14a == loop_count )
    {
        array::thread_all( var_7525f383, &function_5f2165df, undefined, var_6cd0b669 );
    }
    
    if ( loop_count == 1 )
    {
        foreach ( struct in level.var_4adb0f8 )
        {
            if ( isdefined( struct.door_left ) && isdefined( var_6dcda4d1 ) && struct.door_left istouching( var_6dcda4d1 ) )
            {
                struct.door_left thread function_3f816598();
            }
        }
        
        if ( level.var_f668e14a != loop_count && var_158dfaa2 == 2 )
        {
            if ( level scene::is_active( "scene_pri_hallway_loop_adler" ) )
            {
                level thread scene::stop( "scene_pri_hallway_loop_adler" );
                level scene::delete_scene_spawned_ents( "scene_pri_hallway_loop_adler" );
                setdvar( #"r_motionblurstrength", 0.2 );
                level thread exploder::kill_exploder( "FX_hallway_shaky_head_adler" );
            }
        }
        
        return;
    }
    
    if ( loop_count == 2 )
    {
        if ( level.var_f668e14a == loop_count && var_158dfaa2 == 1 )
        {
            foreach ( brushmodel in level.var_be8a7ed0 )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel hide();
                }
            }
            
            foreach ( brushmodel in level.var_4620ea49 )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel hide();
                }
            }
            
            if ( !level flag::get( "infinite_hallway_visit_loop_complete" ) )
            {
                level namespace_d9b153b9::function_cf0f5dc6( level.var_5ab10178 );
                level util::function_bfa9c188( "corridor_1_dynmodel", 0 );
                level namespace_d9b153b9::function_cf0f5dc6( level.corridor_1_pipe_script_brushmodels );
                level util::function_bfa9c188( "corridor_2_corner_dynmodel", 0 );
                level namespace_d9b153b9::function_cf0f5dc6( level.corridor_2_corner_pipe_script_brushmodels );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_02" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_02" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_03" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_03" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_03" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_04" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_04" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_04" );
                level exploder::stop_exploder( "lgt_shrinkhall_01" );
                level thread namespace_b6fe1dbe::shrinking_hallway_hide();
            }
        }
        else if ( level.var_f668e14a != loop_count && var_158dfaa2 == 1 )
        {
        }
        
        if ( level.var_f668e14a == loop_count && var_158dfaa2 == 2 )
        {
            foreach ( brushmodel in level.var_340b140b )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel hide();
                }
            }
            
            foreach ( brushmodel in level.var_30d625b7 )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel hide();
                }
            }
            
            if ( !level flag::get( "infinite_hallway_visit_loop_complete" ) )
            {
                level util::function_bfa9c188( "corridor_2_dynmodel", 0 );
                corridor_2_corner = getentarray( "infinite_hallway_loop_door_blocker", "script_noteworthy" );
                
                foreach ( ent in corridor_2_corner )
                {
                    if ( isdefined( ent.model ) && ent.model == "p9_vnm_laboratory_ceiling_02" )
                    {
                        ent show();
                    }
                }
                
                var_ce0740d0 = getentarray( "corridor_2_ceiling_pieces", "script_noteworthy" );
                
                foreach ( ent in var_ce0740d0 )
                {
                    if ( isdefined( ent.model ) && ent.model == "p9_vnm_lab_ceiling_scripted_01" )
                    {
                        ent show();
                    }
                }
                
                level util::function_bfa9c188( "corridor_3_corner_dynmodel", 0 );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_05" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_05" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_06" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_06" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_06" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_07" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_07" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_07" );
                level exploder::stop_exploder( "lgt_shrinkhall_02" );
                level thread namespace_b6fe1dbe::shrinking_hallway_hide();
            }
        }
        
        if ( level.var_f668e14a == loop_count && var_158dfaa2 == 3 )
        {
            foreach ( brushmodel in level.var_8f1b4e46 )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel hide();
                }
            }
            
            foreach ( brushmodel in level.var_723c531e )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel hide();
                }
            }
            
            if ( !level flag::get( "infinite_hallway_visit_loop_complete" ) )
            {
                level util::function_bfa9c188( "corridor_3_dynmodel", 0 );
                level namespace_d9b153b9::function_cf0f5dc6( level.corridor_3_pipe_script_brushmodels );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_08" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_08" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_09" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_09" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_09" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_10" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_10" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_10" );
                level exploder::stop_exploder( "lgt_shrinkhall_03" );
                level thread namespace_b6fe1dbe::shrinking_hallway_hide();
            }
        }
        
        if ( level.var_f668e14a == loop_count && var_158dfaa2 == 4 )
        {
            foreach ( brushmodel in level.var_624718c0 )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel hide();
                }
            }
            
            if ( !level flag::get( "infinite_hallway_visit_loop_complete" ) )
            {
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_11" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_11" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_01" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_01" );
                level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_01" );
                level exploder::stop_exploder( "lgt_shrinkhall_04" );
                level thread namespace_b6fe1dbe::shrinking_hallway_unhide();
            }
        }
        
        return;
    }
    
    if ( loop_count == 3 )
    {
        if ( level.var_f668e14a == loop_count && var_158dfaa2 == 1 )
        {
            foreach ( brushmodel in level.var_be8a7ed0 )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel show();
                }
            }
            
            foreach ( brushmodel in level.var_4620ea49 )
            {
                if ( isdefined( brushmodel ) )
                {
                    brushmodel show();
                }
            }
            
            if ( !level flag::get( "infinite_hallway_visit_loop_complete" ) )
            {
                level namespace_d9b153b9::function_cf0f5dc6( level.var_5ab10178, 1 );
                level util::function_bfa9c188( "corridor_1_dynmodel", 1 );
                level namespace_d9b153b9::function_cf0f5dc6( level.corridor_1_pipe_script_brushmodels, 1 );
                level util::function_bfa9c188( "corridor_2_corner_dynmodel", 1 );
                level namespace_d9b153b9::function_cf0f5dc6( level.corridor_2_corner_pipe_script_brushmodels, 1 );
                level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_02" );
                level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_02" );
                level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_03" );
                level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_03" );
                level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_03" );
                level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_key_04" );
                level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_ballast_04" );
                level thread namespace_d9b153b9::function_c318ce4a( "lgt_infhall_kick_04" );
                level exploder::exploder( "lgt_shrinkhall_01" );
                level thread namespace_b6fe1dbe::shrinking_hallway_unhide();
            }
            
            if ( !isdefined( level.player_exiting_shrinking_loop_trigger.trigger_off ) )
            {
                level.player_exiting_shrinking_loop_trigger triggerenable( 0 );
                level.player_exiting_shrinking_loop_trigger.trigger_off = 1;
            }
            
            level flag::clear( "flag_enable_corridor_loop_cleanup" );
        }
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 2
// Checksum 0x60f28a22, Offset: 0x7ea0
// Size: 0x4d6
function function_b9455f01( modelscale, var_158dfaa2 )
{
    if ( level flag::get( "flag_delete_shrinking_loop" ) )
    {
        return;
    }
    
    if ( isdefined( modelscale ) )
    {
        foreach ( struct in level.var_4adb0f8 )
        {
            if ( isdefined( struct.script_noteworthy ) && issubstr( struct.script_noteworthy, "corridor_" + var_158dfaa2 ) )
            {
                if ( isdefined( struct.var_3deb0c3d ) )
                {
                    if ( isdefined( struct.door_frame ) )
                    {
                        if ( isdefined( struct.linked_ents ) )
                        {
                            foreach ( linked_ent in struct.linked_ents )
                            {
                                if ( isdefined( linked_ent.script_noteworthy ) && linked_ent.script_noteworthy != "door_frame" )
                                {
                                    linked_ent linkto( struct.door_frame );
                                }
                                
                                if ( isdefined( struct.var_3deb0c3d.script_parameters ) && ( linked_ent.script_noteworthy == "door_left" || linked_ent.script_noteworthy == "door_frame" || linked_ent.script_noteworthy == "door_script_brushmodels" ) )
                                {
                                    linked_ent setscale( float( struct.var_3deb0c3d.script_parameters ) );
                                }
                            }
                        }
                    }
                    
                    struct.door_frame.origin = ( struct.var_3deb0c3d.origin[ 0 ], struct.var_3deb0c3d.origin[ 1 ], struct.door_frame.origin[ 2 ] );
                    struct.door_frame.angles = struct.var_3deb0c3d.angles;
                }
            }
        }
        
        return;
    }
    
    foreach ( struct in level.var_4adb0f8 )
    {
        if ( isdefined( struct.script_noteworthy ) && issubstr( struct.script_noteworthy, "corridor_" + var_158dfaa2 ) )
        {
            if ( isdefined( struct.var_3deb0c3d ) )
            {
                if ( isdefined( struct.door_frame ) )
                {
                    if ( isdefined( struct.linked_ents ) )
                    {
                        foreach ( linked_ent in struct.linked_ents )
                        {
                            if ( isdefined( struct.var_3deb0c3d.script_parameters ) && ( linked_ent.script_noteworthy == "door_left" || linked_ent.script_noteworthy == "door_frame" || linked_ent.script_noteworthy == "door_script_brushmodels" ) )
                            {
                                linked_ent setscale( 1 );
                            }
                        }
                    }
                }
                
                struct.door_frame.origin = struct.original_origin;
                struct.door_frame.angles = struct.original_angles;
            }
        }
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0xe82ebb1e, Offset: 0x8380
// Size: 0xbc4
function function_87b67c58()
{
    level flag::wait_till_any( array( "flag_player_exiting_shrinking_loop", "infinite_hallway_visit_loop_complete" ) );
    
    if ( !level flag::get( "infinite_hallway_visit_loop_complete" ) )
    {
        var_7fb8936 = [];
        is_offscreen = 0;
        
        while ( !is_offscreen && !level flag::get( "corridor_2_activate" ) )
        {
            foreach ( brushmodel in level.var_624718c0 )
            {
                if ( isdefined( brushmodel ) )
                {
                    if ( !util::within_fov( level.players[ 0 ].origin, level.players[ 0 ].angles, brushmodel.origin, cos( 70 ) ) && level flag::get( "flag_infinite_hallway_player_near_door" ) )
                    {
                        if ( !isdefined( var_7fb8936 ) )
                        {
                            var_7fb8936 = [];
                        }
                        else if ( !isarray( var_7fb8936 ) )
                        {
                            var_7fb8936 = array( var_7fb8936 );
                        }
                        
                        var_7fb8936[ var_7fb8936.size ] = brushmodel;
                        continue;
                    }
                    
                    var_7fb8936 = [];
                }
            }
            
            if ( var_7fb8936.size == level.var_624718c0.size )
            {
                is_offscreen = 1;
            }
            
            wait 0.1;
        }
    }
    
    if ( level flag::get( "infinite_hallway_visit_loop_complete" ) )
    {
        level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_02" );
        level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_02" );
        level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_03" );
        level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_03" );
        level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_03" );
        level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_04" );
        level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_04" );
        level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_04" );
        level exploder::stop_exploder( "lgt_shrinkhall_01" );
        level util::function_bfa9c188( "corridor_1_dynmodel", 0 );
        level util::function_bfa9c188( "corridor_2_corner_dynmodel", 0 );
        level namespace_d9b153b9::function_cf0f5dc6( level.var_5ab10178 );
    }
    
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_05" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_05" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_06" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_06" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_06" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_07" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_07" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_07" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_08" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_08" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_09" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_09" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_09" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_10" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_10" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_10" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_11" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_11" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_key_01" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_ballast_01" );
    level thread namespace_d9b153b9::function_b96db417( "lgt_infhall_kick_01" );
    level exploder::stop_exploder( "lgt_shrinkhall_02" );
    level exploder::stop_exploder( "lgt_shrinkhall_03" );
    level exploder::stop_exploder( "lgt_shrinkhall_04" );
    level util::function_bfa9c188( "corridor_2_dynmodel", 0 );
    level util::function_bfa9c188( "corridor_3_dynmodel", 0 );
    level util::function_bfa9c188( "corridor_3_corner_dynmodel", 0 );
    corridor_2_corner = getentarray( "infinite_hallway_loop_door_blocker", "script_noteworthy" );
    
    foreach ( ent in corridor_2_corner )
    {
        if ( isdefined( ent.model ) && ent.model == "p9_vnm_laboratory_ceiling_02" )
        {
            ent show();
        }
    }
    
    var_ce0740d0 = getentarray( "corridor_2_ceiling_pieces", "script_noteworthy" );
    
    foreach ( ent in var_ce0740d0 )
    {
        if ( isdefined( ent.model ) && ent.model == "p9_vnm_lab_ceiling_scripted_01" )
        {
            ent show();
        }
    }
    
    array::thread_all( level.var_57e54c86, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_4620ea49, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_be8a7ed0, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_30d625b7, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_340b140b, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_723c531e, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_8f1b4e46, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_624718c0, &namespace_d9b153b9::ent_cleanup );
    
    if ( !isdefined( level.player_exiting_shrinking_loop_trigger.trigger_off ) )
    {
        level.player_exiting_shrinking_loop_trigger triggerenable( 0 );
        level.player_exiting_shrinking_loop_trigger.trigger_off = 1;
    }
    
    if ( isdefined( level.var_ab6fa9fc ) )
    {
        level.var_ab6fa9fc delete();
    }
    
    if ( isdefined( level.var_2a353790 ) )
    {
        level.var_2a353790 delete();
    }
    
    if ( isdefined( level.var_3814631a ) )
    {
        level.var_3814631a delete();
    }
    
    if ( isdefined( level.var_a77dd496 ) )
    {
        level.var_a77dd496 delete();
    }
    
    if ( isdefined( level.var_1193c77e ) )
    {
        level.var_1193c77e delete();
    }
    
    if ( isdefined( level.var_a47ab6eb ) )
    {
        level.var_a47ab6eb delete();
    }
    
    if ( isdefined( level.var_92bf0856 ) )
    {
        level.var_92bf0856 delete();
    }
    
    if ( isdefined( level.var_ff9012a ) )
    {
        level.var_ff9012a delete();
    }
    
    level flag::set( "flag_delete_shrinking_loop" );
    level thread namespace_b6fe1dbe::shrinking_hallway_end();
}

/#

    // Namespace namespace_b092382c/namespace_b092382c
    // Params 0
    // Checksum 0x7faa5d02, Offset: 0x8f50
    // Size: 0x160, Type: dev
    function function_e5fea6b0()
    {
        xoffset = 15;
        yoffset = 175;
        var_981bb6ec = 15;
        namespace_d9b153b9::function_6c8fccf2( "<dev string:x38>", xoffset, yoffset + var_981bb6ec * 12 );
        
        while ( true )
        {
            foreach ( var_86275d63 in level.var_86275d63 )
            {
                if ( issubstr( tolower( var_86275d63.str ), "<dev string:x55>" ) )
                {
                    var_86275d63 settext( var_86275d63.str + level.var_f668e14a );
                }
                
                level waittilltimeout( 5, #"hash_7e0ec26676ae3d41" );
            }
        }
    }

#/

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x56456a77, Offset: 0x90b8
// Size: 0x588
function function_14147c77()
{
    level endon( #"infinite_hallway_exited" );
    level endon( #"infinite_hallway_visit_loop_complete" );
    level.var_f668e14a = 0;
    var_bdceaa3e = 0;
    last_trigger = 0;
    last_trigger = "corridor_4_activate";
    level flag::set( "corridor_1_activate" );
    level thread util::delay( 0.1, undefined, &flag::clear, "corridor_1_activate" );
    
    while ( true )
    {
        level flag::wait_till_any( array( "corridor_1_activate", "corridor_2_activate", "corridor_3_activate", "corridor_4_activate" ) );
        
        if ( level flag::get( "corridor_1_activate" ) )
        {
            if ( last_trigger != "corridor_1_activate" )
            {
                if ( last_trigger == "corridor_4_activate" )
                {
                    level.var_f668e14a++;
                    level notify( #"hash_7e0ec26676ae3d41" );
                    flag = "infinite_hallway_corridor_loop_" + level.var_f668e14a;
                    
                    if ( level flag::exists( flag ) )
                    {
                        level flag::set( flag );
                    }
                    
                    var_bdceaa3e = 1;
                    level thread function_bf2933ed( 2, level.var_f668e14a - 1 );
                    level thread function_bf2933ed( 1, level.var_f668e14a, 1 );
                }
                else if ( last_trigger == "corridor_2_activate" )
                {
                    if ( var_bdceaa3e > 0 )
                    {
                        var_bdceaa3e--;
                    }
                    
                    level thread function_bf2933ed( 2, level.var_f668e14a );
                }
                
                last_trigger = "corridor_1_activate";
            }
        }
        else if ( level flag::get( "corridor_2_activate" ) )
        {
            if ( last_trigger != "corridor_2_activate" )
            {
                if ( last_trigger == "corridor_1_activate" )
                {
                    var_bdceaa3e++;
                    level thread function_bf2933ed( 3, level.var_f668e14a - 1 );
                    level thread function_bf2933ed( 2, level.var_f668e14a, 1 );
                }
                else if ( last_trigger == "corridor_3_activate" )
                {
                    if ( var_bdceaa3e > 0 )
                    {
                        var_bdceaa3e--;
                    }
                    
                    level thread function_bf2933ed( 3, level.var_f668e14a );
                }
                
                last_trigger = "corridor_2_activate";
            }
        }
        else if ( level flag::get( "corridor_3_activate" ) )
        {
            if ( last_trigger != "corridor_3_activate" )
            {
                if ( last_trigger == "corridor_2_activate" )
                {
                    var_bdceaa3e++;
                    level thread function_bf2933ed( 4, level.var_f668e14a - 1 );
                    level thread function_bf2933ed( 3, level.var_f668e14a, 1 );
                }
                else if ( last_trigger == "corridor_4_activate" )
                {
                    if ( var_bdceaa3e > 0 )
                    {
                        var_bdceaa3e--;
                    }
                    
                    level thread function_bf2933ed( 4, level.var_f668e14a );
                }
                
                last_trigger = "corridor_3_activate";
            }
        }
        else if ( level flag::get( "corridor_4_activate" ) )
        {
            if ( last_trigger != "corridor_4_activate" )
            {
                if ( last_trigger == "corridor_3_activate" )
                {
                    var_bdceaa3e++;
                    level thread function_bf2933ed( 1, level.var_f668e14a - 1 );
                    level thread function_bf2933ed( 4, level.var_f668e14a, 1 );
                }
                else if ( last_trigger == "corridor_1_activate" )
                {
                    level notify( #"hash_7e0ec26676ae3d41" );
                    flag = "infinite_hallway_corridor_loop_" + level.var_f668e14a;
                    
                    if ( level flag::exists( flag ) )
                    {
                        level flag::clear( flag );
                    }
                    
                    var_bdceaa3e = 4;
                    level thread function_bf2933ed( 1, level.var_f668e14a );
                    
                    if ( level.var_f668e14a > 0 )
                    {
                        level.var_f668e14a--;
                    }
                }
                
                last_trigger = "corridor_4_activate";
            }
        }
        
        wait 0.05;
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 1
// Checksum 0xb41399eb, Offset: 0x9648
// Size: 0x1ce
function function_acfb9b2d( var_5f7546ed )
{
    level endon( #"infinite_hallway_exited" );
    level endon( var_5f7546ed );
    self.door_left thread namespace_b6fe1dbe::function_46e4b64f();
    var_1403135a = struct::get( self.script_noteworthy + "_magicbullet_start", "targetname" );
    
    while ( true )
    {
        distance = distancesquared( level.players[ 0 ].origin, self.door_left.origin );
        
        if ( distance < 36100 )
        {
            if ( isdefined( var_1403135a ) )
            {
                if ( !isdefined( self.var_b67257e7 ) )
                {
                    self.var_b67257e7 = 1;
                    self thread function_15a302bb( var_1403135a );
                }
            }
        }
        
        if ( distance < 30625 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    var_e0b06bb2 = undefined;
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "corridor_1_door_3" )
    {
        level notify( #"corridor_1_door_3" );
    }
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "corridor_3_door_4" )
    {
        var_e0b06bb2 = self.script_noteworthy;
    }
    
    self.door_left thread function_3f816598( undefined, 0.5, 1, var_e0b06bb2 );
    self.var_b67257e7 = undefined;
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 1
// Checksum 0x273db517, Offset: 0x9820
// Size: 0x15c
function function_15a302bb( start_struct )
{
    end_struct = struct::get( start_struct.target, "targetname" );
    magicbullet( getweapon( #"hash_4ff481a4f55ed901" ), start_struct.origin, end_struct.origin + ( -10, 0, -40 ) );
    wait randomfloatrange( 0.1, 0.15 );
    magicbullet( getweapon( #"hash_4ff481a4f55ed901" ), start_struct.origin, end_struct.origin + ( 5, 0, -20 ) );
    wait randomfloatrange( 0.1, 0.15 );
    magicbullet( getweapon( #"hash_4ff481a4f55ed901" ), start_struct.origin, end_struct.origin );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x29bd64a6, Offset: 0x9988
// Size: 0x53c
function infinite_hallway_visit_4()
{
    level endon( #"infinite_hallway_exited" );
    level thread scene::init( "scene_pri_lab_floor" );
    level flag::set( "infinite_hallway_visit_lab" );
    level flag::set( "infinite_hallway_exit_ready" );
    level.infinite_hallway_loop_unlock_door_struct namespace_d9b153b9::function_736b8a03( 1 );
    level.infinite_hallway_exit_unlock_door_struct thread namespace_d9b153b9::function_736b8a03();
    level flag::set( "flag_infinite_hallway_lab_door" );
    level.infinite_hallway_lab_backtrack_blocker notsolid();
    level.player setmovespeedscale( 0.75 );
    level flag::wait_till( "flag_player_not_at_floor_fall" );
    level thread namespace_b6fe1dbe::stop_hallway_sfx();
    level flag::wait_till_clear( "flag_player_not_at_floor_fall" );
    level.player setmovespeedscale( 0.5 );
    level thread namespace_b6fe1dbe::tmp_cp_nam_bunk_trap_floor();
    level thread namespace_b6fe1dbe::music( "tunnel_part3_fallen" );
    level thread scene::play( "scene_pri_lab_floor" );
    level thread exploder::exploder( "CinFX_InfHall_FloorCollapse" );
    screenshake( level.player.origin, 1, 0, 1, 2, 0, -1, 0, 4, 0, 7, 2 );
    level.player playrumbleonentity( "damage_heavy" );
    level thread function_6a361dc1();
    level.infinite_hallway_lab_backtrack_blocker solid();
    wait 0.45;
    
    foreach ( ent in level.infinite_hallway_lab_floor )
    {
        if ( isdefined( ent ) )
        {
            if ( !isdefined( ent.script_noteworthy ) )
            {
                ent hide();
            }
            
            ent notsolid();
        }
    }
    
    foreach ( ent in level.infinite_hallway_bunker_ceiling )
    {
        if ( isdefined( ent ) )
        {
            ent hide();
            ent notsolid();
        }
    }
    
    level.player setmovespeedscale( 1 );
    level.player allowsprint( 1 );
    level flag::wait_till( "flag_player_floor_collapse_camshake_impact" );
    level.player playrumbleonentity( "damage_heavy" );
    screenshake( level.player.origin, 3.4, 0.3, 1, 1, 0, 0.8, 0, 5, 1, 4, 2 );
    level.infinite_hallway_loop_unlock_door_struct.door_interact waittill( #"trigger" );
    level flag::clear( "flag_infinite_hallway_lab_door" );
    level thread scene::stop( "scene_pri_lab_floor" );
    level scene::delete_scene_spawned_ents( "scene_pri_lab_floor" );
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x2cd78034, Offset: 0x9ed0
// Size: 0xd4
function function_6a361dc1()
{
    level endon( #"infinite_hallway_exited" );
    level.player enableinvulnerability();
    corridor_2_volume = getent( "corridor_2_volume", "targetname" );
    count = 0;
    
    while ( !level.player istouching( corridor_2_volume ) || count > 150 )
    {
        count++;
        wait 0.1;
    }
    
    wait 1;
    level.player disableinvulnerability();
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 1
// Checksum 0x8d726cbe, Offset: 0x9fb0
// Size: 0x14c
function function_dbcfb3e2( door_struct )
{
    door_struct.door_interact waittill( #"trigger" );
    level thread namespace_b6fe1dbe::infinite_hallway_ambience_end();
    level thread namespace_d9b153b9::pstfx_teleport( 1, 0, "door" );
    
    if ( isdefined( level.var_ffd4e184 ) )
    {
        level.var_ffd4e184 scene::play( "scene_pri_bunker_unlock", door_struct.door_left );
    }
    else
    {
        door_struct scene::play( "scene_pri_bunker_unlock", door_struct.door_left );
    }
    
    level flag::set( "flag_clear_teleport_fx" );
    level flag::set( "infinite_hallway_exited" );
    level thread namespace_b6fe1dbe::music( "tunnel_part3_final_walkdown" );
    
    if ( isdefined( level.infinite_hallway ) )
    {
        level.var_ffd4e184 delete();
    }
}

// Namespace namespace_b092382c/namespace_b092382c
// Params 0
// Checksum 0x7f68a6c3, Offset: 0xa108
// Size: 0xbbc
function function_be61f4c4()
{
    if ( level flag::exists( "flag_exit_door_pos_1_wall" ) && level flag::get( "flag_exit_door_pos_1_wall" ) )
    {
        level flag::clear( "flag_exit_door_pos_1_wall" );
    }
    
    if ( level flag::exists( "flag_exit_door_pos_2_wall" ) && level flag::get( "flag_exit_door_pos_2_wall" ) )
    {
        level flag::clear( "flag_exit_door_pos_2_wall" );
    }
    
    if ( level flag::exists( "flag_exit_door_pos_3_wall" ) && level flag::get( "flag_exit_door_pos_3_wall" ) )
    {
        level flag::clear( "flag_exit_door_pos_3_wall" );
    }
    
    if ( level flag::exists( "flag_exit_door_pos_4_wall" ) && level flag::get( "flag_exit_door_pos_4_wall" ) )
    {
        level flag::clear( "flag_exit_door_pos_4_wall" );
    }
    
    if ( level flag::exists( "flag_infinite_hallway_loop_door_blocker" ) && level flag::get( "flag_infinite_hallway_loop_door_blocker" ) )
    {
        level flag::clear( "flag_infinite_hallway_loop_door_blocker" );
    }
    
    if ( level flag::exists( "flag_infinite_hallway_corridor_blocker_1" ) && level flag::get( "flag_infinite_hallway_corridor_blocker_1" ) )
    {
        level flag::clear( "flag_infinite_hallway_corridor_blocker_1" );
    }
    
    if ( level flag::exists( "flag_infinite_hallway_corridor_blocker_2" ) && level flag::get( "flag_infinite_hallway_corridor_blocker_2" ) )
    {
        level flag::clear( "flag_infinite_hallway_corridor_blocker_2" );
    }
    
    if ( level flag::exists( "flag_infinite_hallway_corridor_1_corner_geo" ) && level flag::get( "flag_infinite_hallway_corridor_1_corner_geo" ) )
    {
        level flag::clear( "flag_infinite_hallway_corridor_1_corner_geo" );
    }
    
    if ( !isdefined( level.infinite_hallway_exit_unlock_door_struct ) )
    {
        level.infinite_hallway_exit_unlock_door_struct = namespace_d9b153b9::door_setup( "infinite_hallway_exit_unlock_door_struct", 1, 1 );
    }
    
    level.infinite_hallway_exit_unlock_door_struct thread namespace_d9b153b9::ent_cleanup();
    
    if ( !isdefined( level.infinite_hallway_loop_unlock_door_struct ) )
    {
        level.infinite_hallway_loop_unlock_door_struct = namespace_d9b153b9::door_setup( "infinite_hallway_loop_unlock_door_struct", 1, 1 );
    }
    
    level.infinite_hallway_loop_unlock_door_struct thread namespace_d9b153b9::ent_cleanup();
    infinite_hallway_wall_blockers = getentarray( "infinite_hallway_wall_blockers", "targetname" );
    array::thread_all( infinite_hallway_wall_blockers, &namespace_d9b153b9::ent_cleanup );
    infinite_hallway_door_facades = getentarray( "infinite_hallway_door_facades", "targetname" );
    array::thread_all( infinite_hallway_door_facades, &namespace_d9b153b9::ent_cleanup );
    
    if ( !isdefined( level.infinite_hallway_lab_backtrack_blocker ) )
    {
        level.infinite_hallway_lab_backtrack_blocker = getent( "infinite_hallway_lab_backtrack_blocker", "targetname" );
    }
    
    level.infinite_hallway_lab_backtrack_blocker thread namespace_d9b153b9::ent_cleanup();
    
    if ( !isdefined( level.infinite_hallway_lab_floor ) )
    {
        level.infinite_hallway_lab_floor = getentarray( "infinite_hallway_lab_floor", "targetname" );
    }
    
    array::thread_all( level.infinite_hallway_lab_floor, &namespace_d9b153b9::ent_cleanup );
    
    if ( !isdefined( level.infinite_hallway_bunker_ceiling ) )
    {
        level.infinite_hallway_bunker_ceiling = getentarray( "infinite_hallway_bunker_ceiling", "targetname" );
    }
    
    array::thread_all( level.infinite_hallway_bunker_ceiling, &namespace_d9b153b9::ent_cleanup );
    
    if ( !isdefined( level.var_57e54c86 ) )
    {
        level.var_57e54c86 = getentarray( "corridor_1_corner", "targetname" );
    }
    
    if ( !isdefined( level.var_4620ea49 ) )
    {
        level.var_4620ea49 = getentarray( "corridor_1_hall", "targetname" );
    }
    
    if ( !isdefined( level.var_be8a7ed0 ) )
    {
        level.var_be8a7ed0 = getentarray( "corridor_2_corner", "targetname" );
    }
    
    if ( !isdefined( level.var_30d625b7 ) )
    {
        level.var_30d625b7 = getentarray( "corridor_2_hall", "targetname" );
    }
    
    if ( !isdefined( level.var_340b140b ) )
    {
        level.var_340b140b = getentarray( "corridor_3_corner", "targetname" );
    }
    
    if ( !isdefined( level.var_723c531e ) )
    {
        level.var_723c531e = getentarray( "corridor_3_hall", "targetname" );
    }
    
    if ( !isdefined( level.var_8f1b4e46 ) )
    {
        level.var_8f1b4e46 = getentarray( "corridor_4_corner", "targetname" );
    }
    
    if ( !isdefined( level.var_624718c0 ) )
    {
        level.var_624718c0 = getentarray( "corridor_4_hall", "targetname" );
    }
    
    if ( !isdefined( level.corridor_1_pipe_script_brushmodels ) )
    {
        level.corridor_1_pipe_script_brushmodels = getentarray( "corridor_1_pipe_script_brushmodels", "targetname" );
    }
    
    if ( !isdefined( level.corridor_2_corner_pipe_script_brushmodels ) )
    {
        level.corridor_2_corner_pipe_script_brushmodels = getentarray( "corridor_2_corner_pipe_script_brushmodels", "targetname" );
    }
    
    if ( !isdefined( level.corridor_2_pipe_script_brushmodels ) )
    {
        level.corridor_2_pipe_script_brushmodels = getentarray( "corridor_2_pipe_script_brushmodels", "targetname" );
    }
    
    if ( !isdefined( level.corridor_3_pipe_script_brushmodels ) )
    {
        level.corridor_3_pipe_script_brushmodels = getentarray( "corridor_3_pipe_script_brushmodels", "targetname" );
    }
    
    array::thread_all( level.var_57e54c86, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_4620ea49, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_be8a7ed0, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_30d625b7, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_340b140b, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_723c531e, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_8f1b4e46, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.var_624718c0, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.corridor_1_pipe_script_brushmodels, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.corridor_2_corner_pipe_script_brushmodels, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.corridor_2_pipe_script_brushmodels, &namespace_d9b153b9::ent_cleanup );
    array::thread_all( level.corridor_3_pipe_script_brushmodels, &namespace_d9b153b9::ent_cleanup );
    level util::function_bfa9c188( "corridor_1_dynmodel", 1 );
    level util::function_bfa9c188( "corridor_2_corner_dynmodel", 1 );
    level util::function_bfa9c188( "corridor_2_dynmodel", 1 );
    level util::function_bfa9c188( "corridor_3_corner_dynmodel", 1 );
    level util::function_bfa9c188( "corridor_3_dynmodel", 1 );
    
    if ( !isdefined( level.corner_1_curved_geo ) )
    {
        level.corner_1_curved_geo = getentarray( "corner_1_curved_geo", "targetname" );
    }
    
    array::thread_all( level.corner_1_curved_geo, &namespace_d9b153b9::ent_cleanup );
    infinite_hallway_triggers = getentarray( "infinite_hallway_triggers", "script_noteworthy" );
    array::thread_all( infinite_hallway_triggers, &namespace_d9b153b9::ent_cleanup );
    infinite_hallway_volumes = getentarray( "infinite_hallway_volumes", "script_noteworthy" );
    array::thread_all( infinite_hallway_volumes, &namespace_d9b153b9::ent_cleanup );
    infinite_hallway_lights = getentarray( "infinite_hallway_lights", "script_noteworthy" );
    array::thread_all( infinite_hallway_lights, &namespace_d9b153b9::ent_cleanup );
    level flag::clear( "infinite_hallway_exited" );
}

