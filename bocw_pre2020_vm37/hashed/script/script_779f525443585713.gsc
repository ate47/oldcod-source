#using script_1fd2c6e5fc8cb1c3;
#using script_210ec734a4149bac;
#using script_2d443451ce681a;
#using script_32ff16d71b77016b;
#using script_44aef2868ad2e317;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\util;

#namespace namespace_99e99ffa;

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x701695a9, Offset: 0xa08
// Size: 0x3c
function function_1d90bc4a()
{
    level thread scene::init_streamer( #"scene_kgb_ambient_atrium_talk", getplayers() );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0xa3ece3ba, Offset: 0xa50
// Size: 0x84
function function_25482400()
{
    level flag::init( "flag_atrium_ambient_scenes_clear" );
    level flag::init( "flag_lobby_and_checkpoint_ambient_scenes_clear" );
    level flag::init( "player_entering_atrium_clear" );
    level flag::init( "flag_shot_2_single_anim_over" );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0xd374d8a9, Offset: 0xae0
// Size: 0x39c
function function_99e99ffa( *var_d3440450 )
{
    function_25482400();
    spawner::add_spawn_function_group( "atrium_civ_walker", "targetname", &function_8828fcf4 );
    spawner::add_spawn_function_group( "standing_armed_a", "script_noteworthy", &kgb_ins_prepare::function_862e8bf9 );
    spawner::add_spawn_function_group( "standing_armed_b", "script_noteworthy", &kgb_ins_prepare::function_862e8bf9 );
    scene::add_scene_func( "scene_kgb_ambient_walk_briefcase_b", &function_612a0725 );
    scene::add_scene_func( "scene_kgb_ambient_walk_briefcase_a", &function_612a0725 );
    scene::add_scene_func( "scene_kgb_ambient_walk_and_talk_duo_a", &function_612a0725 );
    scene::add_scene_func( "scene_kgb_ambient_walk_folder_a", &function_612a0725 );
    level.var_31a33946 = [];
    level.var_fdb0359e = spawnstruct();
    level.var_fdb0359e.section = [];
    level thread function_3cb2286e();
    level thread function_eb4c6bd2();
    level thread function_d6754bb5();
    level thread function_575ad786( "atrium" );
    level thread function_575ad786( "atrium_2nd_floor", "flag_atrium_ambient_scenes" );
    level thread function_575ad786( "lobby_and_checkpoint" );
    level thread function_575ad786( "west_hall" );
    level thread function_575ad786( "interrogation" );
    
    if ( !level flag::get( "kgb_ins_prepare_completed" ) )
    {
        level thread function_24a7c694();
        level thread function_59bafa47( "east_hall" );
        level thread function_59bafa47( "west_hall", "flag_west_hall_civ_walker" );
    }
    
    level thread function_9da2d35a();
    level thread function_176a7f2();
    level thread function_3bf9566c();
    
    if ( isdefined( level.var_28c22d88 ) && array::contains( level.var_28c22d88, "kgb_ins_activation" ) )
    {
        level thread function_ea21fe3e();
        level thread function_92169709();
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x8eee3a79, Offset: 0xe88
// Size: 0x1bc
function function_8828fcf4()
{
    wait 0.1;
    
    if ( !isdefined( level.var_fdb0359e.section[ #"east_hall" ].var_cd964f83 ) || isdefined( level.var_fdb0359e.section[ #"east_hall" ].var_cd964f83 ) && !array::contains( level.var_fdb0359e.section[ #"east_hall" ].var_cd964f83, self ) && isdefined( self.var_639fbd40 ) && self.var_639fbd40 != "atrium" )
    {
        if ( math::cointoss() )
        {
            if ( math::cointoss() )
            {
                self namespace_f592a7b::function_7bd21c92( "BRIEFCASE_LEFT" );
            }
            else
            {
                self namespace_f592a7b::function_7bd21c92( "BRIEFCASE_RIGHT" );
            }
            
            waitresult = self waittill( #"death", #"delete", #"entitydeleted", #"hash_7cbff9b55c2727" );
            
            if ( isdefined( self ) )
            {
                self namespace_f592a7b::function_7bd21c92( "NONE" );
            }
        }
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0xe7ad45f6, Offset: 0x1050
// Size: 0x87c
function function_3bf9566c()
{
    level endon( #"kgb_fail_mission" );
    
    if ( level flag::get( "kgb_ins_prepare_completed" ) )
    {
        return;
    }
    
    level flag::wait_till( "kgb_ins_tutorial_completed" );
    var_61d8cb78 = struct::get_array( "atrium_hall_struct", "targetname" );
    scene::add_scene_func( "scene_kgb_ambient_corner_talk_duo_a", &function_4be4b3bc, "Shot 4" );
    scene_shots = scene::get_all_shot_names( "scene_kgb_ambient_corner_talk_duo_a" );
    var_26a0c491 = "Shot 1";
    var_2b1d17ff = 1;
    
    while ( true )
    {
        level flag::wait_till_any( array( "flag_atrium_ambient_scenes", "kgb_ins_rv_completed" ) );
        
        if ( level flag::get( "kgb_ins_rv_completed" ) )
        {
            break;
        }
        
        player = getplayers()[ 0 ];
        var_8df68fc1 = arraygetclosest( player.origin, var_61d8cb78 );
        
        if ( isdefined( var_8df68fc1.script_noteworthy ) && !issubstr( var_8df68fc1.script_noteworthy, "east" ) )
        {
            if ( !scene::is_active( "scene_kgb_ambient_corner_talk_duo_a" ) )
            {
                level thread scene::play( "scene_kgb_ambient_corner_talk_duo_a", var_26a0c491 );
            }
            
            level flag::function_4bf6d64f( array( "player_entering_atrium" ), array( "flag_atrium_ambient_scenes" ) );
            
            if ( !level flag::get( "flag_atrium_ambient_scenes" ) )
            {
                var_8df68fc1 = arraygetclosest( player.origin, var_61d8cb78 );
                
                if ( isdefined( var_8df68fc1.script_noteworthy ) && !issubstr( var_8df68fc1.script_noteworthy, "east" ) )
                {
                    level thread scene::stop( "scene_kgb_ambient_corner_talk_duo_a", 1 );
                }
                else
                {
                    level flag::function_4bf6d64f( array( "flag_atrium_ambient_scenes" ), array( "flag_east_hall_ambient_scenes" ) );
                    
                    if ( !level flag::get( "flag_east_hall_ambient_scenes" ) )
                    {
                        level thread scene::stop( "scene_kgb_ambient_corner_talk_duo_a", 1 );
                    }
                }
                
                wait 0.1;
                continue;
            }
            else
            {
                var_8df68fc1 = arraygetclosest( player.origin, var_61d8cb78 );
                
                if ( isdefined( var_8df68fc1.script_noteworthy ) && !issubstr( var_8df68fc1.script_noteworthy, "east" ) )
                {
                    var_2b1d17ff++;
                    
                    while ( true )
                    {
                        if ( scene::is_active( "scene_kgb_ambient_corner_talk_duo_a" ) )
                        {
                            if ( var_26a0c491 != "Shot " + var_2b1d17ff )
                            {
                                var_26a0c491 = "Shot " + var_2b1d17ff;
                                
                                if ( var_26a0c491 == "Shot 4" )
                                {
                                    wait 2;
                                }
                                
                                level thread scene::play( "scene_kgb_ambient_corner_talk_duo_a", var_26a0c491 );
                                wait 1;
                            }
                        }
                        
                        if ( var_26a0c491 == "Shot 2" )
                        {
                            level thread function_ae19bb1f();
                            level flag::function_4bf6d64f( array( "flag_shot_2_single_anim_over" ), array( "flag_atrium_ambient_scenes" ) );
                            var_2b1d17ff++;
                            var_26a0c491 = "Shot " + var_2b1d17ff;
                        }
                        
                        if ( var_26a0c491 == "Shot 4" )
                        {
                            break;
                        }
                        
                        level flag::wait_till_clear( "player_entering_atrium" );
                        level flag::function_4bf6d64f( array( "player_entering_atrium" ), array( "flag_atrium_ambient_scenes" ) );
                        
                        if ( level flag::get( "player_entering_atrium" ) )
                        {
                            var_8df68fc1 = arraygetclosest( player.origin, var_61d8cb78 );
                            
                            if ( isdefined( var_8df68fc1.script_noteworthy ) && !issubstr( var_8df68fc1.script_noteworthy, "east" ) )
                            {
                                var_2b1d17ff++;
                            }
                            
                            wait 0.1;
                            continue;
                        }
                        else if ( !level flag::get( "flag_atrium_ambient_scenes" ) )
                        {
                            var_8df68fc1 = arraygetclosest( player.origin, var_61d8cb78 );
                            
                            if ( isdefined( var_8df68fc1.script_noteworthy ) && !issubstr( var_8df68fc1.script_noteworthy, "east" ) )
                            {
                                level thread scene::stop( "scene_kgb_ambient_corner_talk_duo_a", 1 );
                            }
                            else
                            {
                                level flag::function_4bf6d64f( array( "flag_atrium_ambient_scenes" ), array( "flag_east_hall_ambient_scenes" ) );
                                
                                if ( !level flag::get( "flag_east_hall_ambient_scenes" ) )
                                {
                                    level thread scene::stop( "scene_kgb_ambient_corner_talk_duo_a", 1 );
                                }
                            }
                            
                            wait 0.1;
                            break;
                        }
                        
                        wait 0.1;
                    }
                }
            }
        }
        else
        {
            level flag::wait_till_clear( "flag_atrium_ambient_scenes" );
        }
        
        if ( var_2b1d17ff >= scene_shots.size )
        {
            break;
        }
        
        wait 0.1;
    }
    
    if ( !level flag::get( "kgb_ins_rv_completed" ) )
    {
        if ( isdefined( level.var_fe04fe12 ) )
        {
            level.var_fe04fe12 thread function_e21cd128();
        }
        
        level flag::function_4bf6d64f( array( "flag_corner_talk_duo_out_of_sight" ), array( "flag_atrium_ambient_scenes" ) );
        var_8df68fc1 = arraygetclosest( player.origin, var_61d8cb78 );
        
        if ( !level flag::get( "flag_atrium_ambient_scenes" ) && isdefined( var_8df68fc1.script_noteworthy ) && issubstr( var_8df68fc1.script_noteworthy, "east" ) )
        {
            level flag::wait_till( "flag_corner_talk_duo_out_of_sight" );
        }
    }
    
    level thread scene::stop( "scene_kgb_ambient_corner_talk_duo_a", 1 );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0xe2a45cc8, Offset: 0x18d8
// Size: 0x6c
function function_ae19bb1f()
{
    level endon( #"flag_atrium_ambient_scenes_clear" );
    level endon( #"flag_shot_2_single_anim_over" );
    level waittill( #"shot_2_single_anim_over" );
    level flag::set( "flag_shot_2_single_anim_over" );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0xb46a6753, Offset: 0x1950
// Size: 0x6c
function function_4be4b3bc( a_ents )
{
    level.var_fe04fe12 = a_ents[ #"actor 1" ];
    level.var_cccf1ba7 = a_ents[ #"actor 2" ];
    wait 4;
    
    if ( isdefined( level.var_cccf1ba7 ) )
    {
        level.var_cccf1ba7 delete();
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x3d4db7af, Offset: 0x19c8
// Size: 0x6c
function function_e21cd128()
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    level endon( #"flag_corner_talk_duo_out_of_sight" );
    self function_6353b83d();
    level flag::set( "flag_corner_talk_duo_out_of_sight" );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x87f7a195, Offset: 0x1a40
// Size: 0xc4
function function_ea21fe3e()
{
    level endon( #"kgb_fail_mission" );
    level flag::wait_till( "kgb_ins_activation_completed" );
    level scene::play( "scene_talk_duo_b", "Shot 2" );
    level thread scene::play( "scene_talk_duo_b", "Shot 3" );
    level flag::wait_till( "player_in_briefing_room" );
    level scene::stop( "scene_talk_duo_b", 1 );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0xd9597380, Offset: 0x1b10
// Size: 0x74
function function_92169709()
{
    level endon( #"kgb_fail_mission" );
    level waittill( #"hash_b7d623ab42e754a" );
    wait 10;
    level scene::play( "kgb_ins_activation_walk_briefcase_a" );
    level scene::stop( "kgb_ins_activation_walk_briefcase_a", 1 );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x5e2a908c, Offset: 0x1b90
// Size: 0x186
function function_9da2d35a()
{
    level endon( #"kgb_fail_mission" );
    spawner::add_spawn_function_group( "security_guard_splitup", "script_noteworthy", &kgb_ins_prepare::function_862e8bf9 );
    
    if ( isdefined( level.var_28c22d88 ) && array::contains( level.var_28c22d88, "kgb_ins_activation" ) || array::contains( level.var_28c22d88, "kgb_ins_briefing" ) || array::contains( level.var_28c22d88, "kgb_ins_tutorial" ) )
    {
        level flag::wait_till( "kgb_ins_briefing_completed" );
        level flag::wait_till( "flag_tutorial_map_complete" );
        level thread scene::play( "scene_kgb_ambient_security_guard_splitup", "Shot 3" );
        return;
    }
    
    var_66cf70ea = getspawnerarray( "security_guard_splitup", "script_noteworthy" );
    var_ac70b3e5 = spawner::simple_spawn( var_66cf70ea );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0xaf950abd, Offset: 0x1d20
// Size: 0x3f4
function function_176a7f2()
{
    level endon( #"kgb_fail_mission" );
    
    if ( level flag::get( "kgb_ins_rv_completed" ) )
    {
        return;
    }
    
    if ( isdefined( level.var_28c22d88 ) && array::contains( level.var_28c22d88, "kgb_ins_activation" ) || array::contains( level.var_28c22d88, "kgb_ins_briefing" ) || array::contains( level.var_28c22d88, "kgb_ins_tutorial" ) || array::contains( level.var_28c22d88, "kgb_ins_prepare" ) )
    {
        level flag::wait_till( "flag_atrium_ambient_scenes" );
        level thread scene::play( "scene_kgb_ambient_atrium_talk", "Shot 1" );
        level flag::wait_till_clear( "flag_atrium_ambient_scenes" );
        level scene::stop( "scene_kgb_ambient_atrium_talk", 1 );
        
        while ( true )
        {
            level flag::wait_till( "flag_atrium_ambient_scenes" );
            level thread scene::play( "scene_kgb_ambient_atrium_talk", "Shot 1" );
            level flag::function_4bf6d64f( array( "player_entering_atrium" ), array( "flag_atrium_ambient_scenes" ) );
            
            if ( level flag::get( "player_entering_atrium" ) )
            {
                break;
            }
            else
            {
                level scene::stop( "scene_kgb_ambient_atrium_talk", 1 );
            }
            
            wait 0.1;
        }
        
        level thread scene::play( "scene_kgb_ambient_atrium_talk", "Shot 2" );
        level flag::wait_till_clear( "flag_atrium_ambient_scenes" );
        level scene::stop( "scene_kgb_ambient_atrium_talk", 1 );
    }
    
    while ( true )
    {
        level flag::wait_till_any( array( "flag_atrium_ambient_scenes", "kgb_ins_rv_completed" ) );
        
        if ( level flag::get( "kgb_ins_rv_completed" ) )
        {
            break;
        }
        
        level thread scene::play( "scene_kgb_ambient_atrium_talk", "Shot 3" );
        level flag::function_4bf6d64f( array( "kgb_ins_rv_completed" ), array( "flag_atrium_ambient_scenes" ) );
        level scene::stop( "scene_kgb_ambient_atrium_talk", 1 );
        
        if ( level flag::get( "kgb_ins_rv_completed" ) )
        {
            break;
        }
    }
    
    if ( scene::is_active( "scene_kgb_ambient_atrium_talk" ) )
    {
        level scene::stop( "scene_kgb_ambient_atrium_talk", 1 );
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x3ecbd142, Offset: 0x2120
// Size: 0x5b0
function function_d6754bb5()
{
    level endon( #"kgb_ins_rv_completed" );
    level endon( #"flag_cleanup_kgb_hq" );
    level endon( #"kgb_fail_mission" );
    player = getplayers()[ 0 ];
    var_61d8cb78 = struct::get_array( "atrium_hall_struct", "targetname" );
    
    while ( true )
    {
        level flag::wait_till( "player_entering_atrium" );
        level flag::clear( "player_entering_atrium_clear" );
        level.var_8df68fc1 = arraygetclosest( player.origin, var_61d8cb78 );
        var_2795d954 = arraygetfarthest( player.origin, var_61d8cb78 );
        
        if ( level.var_8df68fc1.script_noteworthy == "atrium_hall_east" )
        {
            var_91985f47 = [];
            
            foreach ( struct in var_61d8cb78 )
            {
                if ( struct != var_2795d954 )
                {
                    if ( !isdefined( var_91985f47 ) )
                    {
                        var_91985f47 = [];
                    }
                    else if ( !isarray( var_91985f47 ) )
                    {
                        var_91985f47 = array( var_91985f47 );
                    }
                    
                    if ( !isinarray( var_91985f47, struct ) )
                    {
                        var_91985f47[ var_91985f47.size ] = struct;
                    }
                }
            }
            
            var_7153b954 = arraygetfarthest( player.origin, var_91985f47 );
            str = var_7153b954.script_noteworthy + "_scene";
            var_3d7dd6bd = struct::get_array( str, "script_noteworthy" );
            var_75307276 = array::random( var_3d7dd6bd );
            
            if ( isdefined( level.var_31fbb1c5 ) && level.var_31fbb1c5 == var_75307276.scriptbundlename )
            {
                while ( true )
                {
                    if ( level.var_31fbb1c5 == var_75307276.scriptbundlename )
                    {
                        var_75307276 = array::random( var_3d7dd6bd );
                    }
                    else
                    {
                        break;
                    }
                    
                    wait 0.05;
                }
            }
            
            level.var_31fbb1c5 = var_75307276.scriptbundlename;
            level thread function_3fe5e74f( var_7153b954, var_75307276 );
            wait 0.25;
        }
        
        str = var_2795d954.script_noteworthy + "_scene";
        var_d73d7664 = struct::get_array( str, "script_noteworthy" );
        var_bb266cc8 = array::random( var_d73d7664 );
        
        if ( isdefined( level.var_31fbb1c5 ) && level.var_31fbb1c5 == var_bb266cc8.scriptbundlename )
        {
            while ( true )
            {
                if ( level.var_31fbb1c5 == var_bb266cc8.scriptbundlename )
                {
                    var_bb266cc8 = array::random( var_d73d7664 );
                }
                else
                {
                    break;
                }
                
                wait 0.05;
            }
        }
        
        level.var_31fbb1c5 = var_bb266cc8.scriptbundlename;
        level thread function_3fe5e74f( var_2795d954, var_bb266cc8 );
        clear_flag = "flag_atrium_ambient_scenes_clear";
        
        if ( !isdefined( level.var_fdb0359e.section[ #"atrium" ].var_5a6384fe ) && level flag::exists( "kgb_ins_rv_completed" ) && !level flag::get( "kgb_ins_rv_completed" ) )
        {
            level thread function_592da021( "atrium", clear_flag );
        }
        
        level flag::wait_till_clear_timeout( 30, "player_entering_atrium" );
        
        if ( !level flag::get( "player_entering_atrium" ) )
        {
            wait 5;
        }
        
        if ( !level flag::get( "player_entering_atrium" ) )
        {
            level flag::set( "player_entering_atrium_clear" );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 3
// Checksum 0xa9f56515, Offset: 0x26d8
// Size: 0x3cc
function function_3fe5e74f( var_5d4d655a, scene, delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    player = getplayers()[ 0 ];
    volume = getent( var_5d4d655a.script_noteworthy + "_volume", "targetname" );
    
    if ( isdefined( volume ) )
    {
        var_4014838e = volume ai::function_18c4ff86( "all" );
        
        foreach ( ai in var_4014838e )
        {
            if ( ai istouchingvolume( volume.origin, volume getmins(), volume getmaxs() ) )
            {
                if ( isdefined( ai.archetype ) && isdefined( ai.targetname ) )
                {
                    if ( ai.archetype != #"civilian" && ai.targetname == "kgb_hq_guard" )
                    {
                        return;
                    }
                    
                    var_7f9418b3 = issubstr( ai.targetname, "walker" );
                    
                    if ( ai.archetype == #"civilian" && issubstr( ai.targetname, "walker" ) && !isdefined( ai.reached_path_end ) )
                    {
                        return;
                    }
                }
            }
        }
        
        corpses = getcorpsearray();
        
        foreach ( corpse in corpses )
        {
            if ( corpse istouchingvolume( volume.origin, volume getmins(), volume getmaxs() ) )
            {
                return;
            }
        }
    }
    
    if ( !level flag::get( "player_exiting_atrium" ) )
    {
        max_distance = 950625;
    }
    else
    {
        max_distance = 842724;
    }
    
    distance = distancesquared( player.origin, var_5d4d655a.origin );
    
    if ( distance < max_distance )
    {
        return;
    }
    
    level scene::play( scene.targetname );
    level notify( #"hash_ee5ce4556fbfba0" );
    waitframe( 1 );
    level scene::delete_scene_spawned_ents( scene.targetname );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0xeee00b32, Offset: 0x2ab0
// Size: 0x30c
function function_612a0725( a_ents )
{
    walk_and_delete_ai_volumes = getentarray( "walk_and_delete_ai_volumes", "script_noteworthy" );
    count = 0;
    
    foreach ( volume in walk_and_delete_ai_volumes )
    {
        foreach ( ent in a_ents )
        {
            if ( ent istouching( volume ) )
            {
                count++;
            }
            
            if ( isdefined( ent._scene_object._o_scene._e_root.targetname ) )
            {
                var_8041f35c = ent._scene_object._o_scene._e_root.targetname;
            }
        }
        
        if ( a_ents.size == count )
        {
            var_6df840cd = volume;
            break;
        }
    }
    
    if ( !isdefined( var_6df840cd ) )
    {
        return;
    }
    
    while ( a_ents.size > 0 )
    {
        var_3cf3d283 = 0;
        function_1eaaceab( a_ents );
        
        if ( a_ents.size == 0 )
        {
            return;
        }
        
        foreach ( ent in a_ents )
        {
            if ( isdefined( ent ) )
            {
                if ( !ent istouching( var_6df840cd ) )
                {
                    var_3cf3d283++;
                }
                
                continue;
            }
            
            function_1eaaceab( a_ents );
        }
        
        if ( var_3cf3d283 == a_ents.size )
        {
            break;
        }
        
        wait 0.05;
    }
    
    if ( isdefined( var_8041f35c ) )
    {
        level notify( #"hash_ee5ce4556fbfba0" );
        waitframe( 1 );
        level scene::stop( var_8041f35c );
        level scene::delete_scene_spawned_ents( var_8041f35c );
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 2
// Checksum 0xbd1786cb, Offset: 0x2dc8
// Size: 0xd64
function function_575ad786( var_c79d614f, section_flag )
{
    level endon( #"kgb_fail_mission" );
    player = getplayers()[ 0 ];
    
    if ( !isdefined( level.var_fdb0359e.section[ var_c79d614f ] ) )
    {
        level.var_fdb0359e.section[ var_c79d614f ] = spawnstruct();
    }
    
    level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c = struct::get_array( var_c79d614f + "_scene", "script_noteworthy" );
    var_54d74f4b = getspawnerarray( var_c79d614f + "_civ_walker_drone", "targetname" );
    
    if ( isdefined( var_54d74f4b ) && var_54d74f4b.size > 0 )
    {
        level.var_fdb0359e.section[ var_c79d614f ].var_23789e35 = 1;
    }
    
    flag = "flag_" + var_c79d614f + "_ambient_scenes";
    
    if ( isdefined( section_flag ) )
    {
        flag = section_flag;
    }
    
    clear_flag = "flag_" + var_c79d614f + "_ambient_scenes_clear";
    
    while ( true )
    {
        level flag::wait_till_any( array( flag, "flag_cleanup_kgb_hq" ) );
        
        if ( level flag::exists( clear_flag ) && level flag::get( clear_flag ) )
        {
            level flag::clear( clear_flag );
        }
        
        if ( level flag::get( "flag_cleanup_kgb_hq" ) )
        {
            return;
        }
        
        level function_49dbc9a2( var_c79d614f );
        
        if ( isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_23789e35 ) && level.var_fdb0359e.section[ var_c79d614f ].var_23789e35 == 1 )
        {
            level thread function_28ace0ef( var_c79d614f, clear_flag );
        }
        
        var_b83afef6 = [];
        var_984196ca = [];
        var_6c775558 = undefined;
        level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c = array::randomize( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c );
        
        foreach ( scene_struct in level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c )
        {
            if ( isdefined( scene_struct.script_parameters ) && issubstr( scene_struct.script_parameters, "permanent" ) )
            {
                if ( isdefined( scene_struct.script_parameters ) && issubstr( scene_struct.script_parameters, "multiple_positions" ) )
                {
                    if ( !isdefined( var_6c775558 ) )
                    {
                        var_6c775558 = scene_struct;
                    }
                    
                    if ( isdefined( var_6c775558 ) && !array::contains( var_984196ca, var_6c775558 ) )
                    {
                        if ( !isdefined( var_984196ca ) )
                        {
                            var_984196ca = [];
                        }
                        else if ( !isarray( var_984196ca ) )
                        {
                            var_984196ca = array( var_984196ca );
                        }
                        
                        var_984196ca[ var_984196ca.size ] = var_6c775558;
                    }
                }
                else
                {
                    if ( !isdefined( var_984196ca ) )
                    {
                        var_984196ca = [];
                    }
                    else if ( !isarray( var_984196ca ) )
                    {
                        var_984196ca = array( var_984196ca );
                    }
                    
                    var_984196ca[ var_984196ca.size ] = scene_struct;
                }
                
                continue;
            }
            
            if ( !array::contains( level.var_fdb0359e.section[ var_c79d614f ].var_7617d471, scene_struct ) )
            {
                if ( !isdefined( var_b83afef6 ) )
                {
                    var_b83afef6 = [];
                }
                else if ( !isarray( var_b83afef6 ) )
                {
                    var_b83afef6 = array( var_b83afef6 );
                }
                
                var_b83afef6[ var_b83afef6.size ] = scene_struct;
            }
        }
        
        level.var_fdb0359e.section[ var_c79d614f ].var_7617d471 = [];
        var_85492b3c = [];
        random_int = randomintrange( 2, 4 );
        
        if ( var_b83afef6.size < random_int )
        {
            random_int = var_b83afef6.size - 1;
        }
        
        while ( var_85492b3c.size < random_int )
        {
            var_3b33ad8f = array::random( var_b83afef6 );
            var_cff12aa9 = [];
            
            foreach ( scene_struct in var_b83afef6 )
            {
                if ( scene_struct != var_3b33ad8f )
                {
                    if ( !isdefined( var_cff12aa9 ) )
                    {
                        var_cff12aa9 = [];
                    }
                    else if ( !isarray( var_cff12aa9 ) )
                    {
                        var_cff12aa9 = array( var_cff12aa9 );
                    }
                    
                    var_cff12aa9[ var_cff12aa9.size ] = scene_struct;
                }
            }
            
            var_b83afef6 = var_cff12aa9;
            
            if ( !isdefined( var_85492b3c ) )
            {
                var_85492b3c = [];
            }
            else if ( !isarray( var_85492b3c ) )
            {
                var_85492b3c = array( var_85492b3c );
            }
            
            var_85492b3c[ var_85492b3c.size ] = var_3b33ad8f;
            
            if ( isdefined( var_3b33ad8f.script_parameters ) && issubstr( var_3b33ad8f.script_parameters, "multiple_positions" ) )
            {
                var_78e26e2b = [];
                
                foreach ( scene_struct in var_b83afef6 )
                {
                    if ( scene_struct.scriptbundlename != var_3b33ad8f.scriptbundlename )
                    {
                        if ( !isdefined( var_78e26e2b ) )
                        {
                            var_78e26e2b = [];
                        }
                        else if ( !isarray( var_78e26e2b ) )
                        {
                            var_78e26e2b = array( var_78e26e2b );
                        }
                        
                        var_78e26e2b[ var_78e26e2b.size ] = scene_struct;
                    }
                }
                
                var_b83afef6 = var_78e26e2b;
            }
            
            if ( var_b83afef6.size == 0 && var_85492b3c.size < random_int )
            {
                break;
            }
            
            wait 0.05;
        }
        
        var_888e604f = arraycombine( var_984196ca, var_85492b3c );
        
        foreach ( scene_struct in var_888e604f )
        {
            if ( isdefined( scene_struct.script_parameters ) && issubstr( scene_struct.script_parameters, "multiple_shots" ) )
            {
                if ( !isdefined( scene_struct.str_shots ) )
                {
                    scene_struct.str_shots = scene::get_all_shot_names( scene_struct.scriptbundlename );
                }
                
                if ( !isdefined( scene_struct.var_3e2c43ab ) )
                {
                    scene_struct.var_3e2c43ab = [];
                }
                
                if ( scene_struct.str_shots.size == scene_struct.var_3e2c43ab.size )
                {
                    scene_struct.var_689ecfec = scene_struct.str_shots[ scene_struct.str_shots.size - 1 ];
                }
                else
                {
                    foreach ( str_shot in scene_struct.str_shots )
                    {
                        if ( !array::contains( scene_struct.var_3e2c43ab, str_shot ) )
                        {
                            scene_struct.var_689ecfec = str_shot;
                            
                            if ( !isdefined( scene_struct.var_3e2c43ab ) )
                            {
                                scene_struct.var_3e2c43ab = [];
                            }
                            else if ( !isarray( scene_struct.var_3e2c43ab ) )
                            {
                                scene_struct.var_3e2c43ab = array( scene_struct.var_3e2c43ab );
                            }
                            
                            scene_struct.var_3e2c43ab[ scene_struct.var_3e2c43ab.size ] = str_shot;
                            break;
                        }
                    }
                }
                
                level thread scene::play( scene_struct.targetname, scene_struct.var_689ecfec );
            }
            else
            {
                level thread scene::play( scene_struct.targetname );
            }
            
            if ( !isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_7617d471 ) )
            {
                level.var_fdb0359e.section[ var_c79d614f ].var_7617d471 = [];
            }
            else if ( !isarray( level.var_fdb0359e.section[ var_c79d614f ].var_7617d471 ) )
            {
                level.var_fdb0359e.section[ var_c79d614f ].var_7617d471 = array( level.var_fdb0359e.section[ var_c79d614f ].var_7617d471 );
            }
            
            level.var_fdb0359e.section[ var_c79d614f ].var_7617d471[ level.var_fdb0359e.section[ var_c79d614f ].var_7617d471.size ] = scene_struct;
        }
        
        level function_eb07c311( flag, clear_flag, var_c79d614f );
        level notify( #"hash_ee5ce4556fbfba0" );
        waitframe( 1 );
        
        foreach ( struct in level.var_fdb0359e.section[ var_c79d614f ].var_7617d471 )
        {
            level scene::stop( struct.targetname );
            level scene::delete_scene_spawned_ents( struct.targetname );
        }
        
        if ( level flag::get( "flag_cleanup_kgb_hq" ) )
        {
            return;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 3
// Checksum 0xe92de5e8, Offset: 0x3b38
// Size: 0x230
function function_eb07c311( flag, var_1609866b, var_c79d614f )
{
    while ( true )
    {
        level flag::function_4bf6d64f( array( "flag_cleanup_kgb_hq" ), array( flag ) );
        
        if ( isdefined( var_c79d614f ) )
        {
            level function_49dbc9a2( var_c79d614f );
        }
        
        if ( isdefined( var_1609866b ) )
        {
            if ( level flag::exists( var_1609866b ) && !level flag::get( var_1609866b ) )
            {
                level flag::set( var_1609866b );
            }
        }
        
        if ( level flag::get( "flag_cleanup_kgb_hq" ) )
        {
            break;
        }
        
        level flag::wait_till_any_timeout( 10, array( flag, "flag_cleanup_kgb_hq" ) );
        
        if ( isdefined( var_c79d614f ) )
        {
            level function_49dbc9a2( var_c79d614f );
        }
        
        if ( level flag::get( flag ) || level flag::get( "flag_cleanup_kgb_hq" ) )
        {
            if ( isdefined( var_1609866b ) )
            {
                if ( level flag::exists( var_1609866b ) && level flag::get( var_1609866b ) )
                {
                    level flag::clear( var_1609866b );
                }
            }
            
            if ( level flag::get( "flag_cleanup_kgb_hq" ) )
            {
                break;
            }
        }
        else
        {
            break;
        }
        
        wait 0.05;
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0x287d4c75, Offset: 0x3d70
// Size: 0x1c0
function function_49dbc9a2( var_c79d614f )
{
    if ( level flag::get( "kgb_ins_briefing_completed" ) && !level flag::get( "kgb_ins_rv_completed" ) )
    {
        if ( isdefined( var_c79d614f ) && var_c79d614f == "atrium" )
        {
            level thread function_2bcb6fed( struct::get( "atrium_trio_standing_armed_a", "targetname" ), "atrium", undefined, "add" );
        }
    }
    
    if ( level flag::get( "kgb_ins_rv_completed" ) )
    {
        if ( isdefined( var_c79d614f ) && var_c79d614f == "atrium" && !isdefined( level.atrium_scene_post_kgb_ins_rv ) )
        {
            level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c = struct::get_array( "atrium_scene_post_kgb_ins_rv", "script_noteworthy" );
            level.atrium_scene_post_kgb_ins_rv = 1;
        }
        
        if ( isdefined( var_c79d614f ) && var_c79d614f == "lobby_and_checkpoint" && !isdefined( level.lobby_and_checkpoint_scene_post_kgb_ins_rv ) )
        {
            level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c = struct::get_array( "lobby_and_checkpoint_scene_post_kgb_ins_rv", "script_noteworthy" );
            level.lobby_and_checkpoint_scene_post_kgb_ins_rv = 1;
        }
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 4
// Checksum 0x296651a5, Offset: 0x3f38
// Size: 0x2bc
function function_2bcb6fed( scene_struct, var_c79d614f, flag, var_c3c17d54 )
{
    level endon( #"flag_cleanup_kgb_hq" );
    level endon( #"kgb_fail_mission" );
    
    if ( isdefined( var_c3c17d54 ) )
    {
        if ( var_c3c17d54 == "add" )
        {
            if ( isdefined( flag ) )
            {
                level flag::wait_till( flag );
            }
            
            if ( isdefined( scene_struct ) && isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c ) && !array::contains( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c, scene_struct ) )
            {
                if ( !isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c ) )
                {
                    level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c = [];
                }
                else if ( !isarray( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c ) )
                {
                    level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c = array( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c );
                }
                
                level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c[ level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c.size ] = scene_struct;
            }
        }
        
        if ( var_c3c17d54 == "remove" )
        {
            if ( isdefined( flag ) )
            {
                level flag::wait_till( flag );
            }
            
            if ( isdefined( scene_struct ) && isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c ) && array::contains( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c, scene_struct ) )
            {
                arrayremovevalue( level.var_fdb0359e.section[ var_c79d614f ].var_4c49141c, scene_struct );
            }
        }
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 2
// Checksum 0x155055c4, Offset: 0x4200
// Size: 0x220
function function_28ace0ef( var_c79d614f, flag )
{
    level endon( flag );
    var_54d74f4b = getspawnerarray( var_c79d614f + "_civ_walker_drone", "targetname" );
    var_b16d80e2 = struct::get_array( var_c79d614f + "_civ_walker_drone_start", "targetname" );
    
    while ( true )
    {
        var_7bc9a81c = var_b16d80e2.size + 2;
        var_d20d3998 = randomintrange( 1, var_7bc9a81c );
        var_b16d80e2 = array::randomize( var_b16d80e2 );
        var_6917cb = [];
        var_6917cb = arraycombine( var_6917cb, var_b16d80e2 );
        
        for ( count = 0; count < var_d20d3998 ; count++ )
        {
            time = randomintrange( 2, 5 );
            wait time;
            spawner = array::random( var_54d74f4b );
            
            if ( isdefined( var_6917cb ) && var_6917cb.size != 0 )
            {
                var_784e2752 = array::random( var_6917cb );
            }
            else
            {
                var_784e2752 = array::random( var_b16d80e2 );
            }
            
            arrayremovevalue( var_6917cb, var_784e2752 );
            level thread function_a9a4fcb1( spawner, var_784e2752, flag );
        }
        
        time = randomintrange( 15, 20 );
        wait time;
        wait 0.1;
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 3
// Checksum 0xa0096288, Offset: 0x4428
// Size: 0x104
function function_a9a4fcb1( spawner, struct, flag )
{
    spawner.origin = struct.origin;
    spawner.angles = struct.angles;
    spawner.target = struct.target;
    drone = spawner::simple_spawn_single( spawner, &function_226f8d50 );
    util::waittill_any_ents( level, flag, drone, "death", drone, "entitydeleted", level, "flag_cleanup_kgb_hq" );
    
    if ( level flag::get( flag ) || level flag::get( "flag_cleanup_kgb_hq" ) )
    {
        if ( isdefined( drone ) )
        {
            drone delete();
        }
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x9c71a6d8, Offset: 0x4538
// Size: 0x174
function function_226f8d50()
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    level endon( #"flag_cleanup_kgb_hq" );
    
    if ( !isai( self ) )
    {
        self namespace_4e75a347::function_cab4b520( "calm" );
        return;
    }
    
    wait 1;
    
    if ( isdefined( self.var_639fbd40 ) && self.var_639fbd40 == "lobby" )
    {
        if ( !isdefined( level.var_31a33946 ) )
        {
            level.var_31a33946 = [];
        }
        else if ( !isarray( level.var_31a33946 ) )
        {
            level.var_31a33946 = array( level.var_31a33946 );
        }
        
        level.var_31a33946[ level.var_31a33946.size ] = self;
        self callback::function_d8abfc3d( #"on_ai_killed", &function_79dc78b0 );
        self callback::function_d8abfc3d( #"on_entity_deleted", &function_79dc78b0 );
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0x7d830462, Offset: 0x46b8
// Size: 0x44
function function_79dc78b0( *str_notify )
{
    arrayremovevalue( level.var_31a33946, self );
    function_1eaaceab( level.var_31a33946 );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 2
// Checksum 0x1e71c3ae, Offset: 0x4708
// Size: 0x2e6
function function_592da021( var_c79d614f, flag )
{
    level endon( #"kgb_fail_mission" );
    
    if ( level.var_31a33946.size == 0 )
    {
        if ( isdefined( level.var_8df68fc1.script_noteworthy ) )
        {
            if ( issubstr( level.var_8df68fc1.script_noteworthy, "north" ) || issubstr( level.var_8df68fc1.script_noteworthy, "south" ) )
            {
                var_bacd35ee = var_c79d614f + "_east_and_west_start";
            }
            else if ( issubstr( level.var_8df68fc1.script_noteworthy, "east" ) || issubstr( level.var_8df68fc1.script_noteworthy, "west" ) )
            {
                var_bacd35ee = var_c79d614f + "_north_and_south_start";
            }
        }
        
        var_b16d80e2 = struct::get_array( var_bacd35ee, "targetname" );
        
        foreach ( struct in var_b16d80e2 )
        {
            if ( isdefined( struct.script_parameters ) && level flag::exists( struct.script_parameters ) && !level flag::get( struct.script_parameters ) )
            {
                arrayremovevalue( var_b16d80e2, struct );
            }
        }
        
        var_b16d80e2 = array::randomize( var_b16d80e2 );
        level function_6feed719( var_c79d614f, var_b16d80e2, flag );
    }
    
    level flag::wait_till_clear( "player_entering_atrium" );
    level flag::wait_till( "player_entering_atrium_clear" );
    
    if ( level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83.size == 0 )
    {
        level.var_fdb0359e.section[ var_c79d614f ].var_5a6384fe = undefined;
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 2
// Checksum 0xdb32a85c, Offset: 0x49f8
// Size: 0x102
function function_27e034fe( var_c79d614f, start_struct )
{
    var_e0213fec = getspawnerarray( var_c79d614f + "_civ_walker", "targetname" );
    
    if ( !isdefined( var_e0213fec ) || var_e0213fec.size == 0 )
    {
        var_e0213fec = getspawnerarray( "atrium_civ_walker", "targetname" );
    }
    
    spawner = array::random( var_e0213fec );
    spawner.origin = start_struct.origin;
    spawner.angles = start_struct.angles;
    spawner.target = start_struct.target;
    var_15e1308b = spawner::simple_spawn_single( spawner, &function_226f8d50 );
    return var_15e1308b;
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 3
// Checksum 0x9df4acce, Offset: 0x4b08
// Size: 0x4ec
function function_6feed719( var_c79d614f, var_b16d80e2, flag )
{
    var_b16d80e2 = array::randomize( var_b16d80e2 );
    var_784e2752 = array::random( var_b16d80e2 );
    
    if ( !isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_725c68b3 ) )
    {
        level.var_fdb0359e.section[ var_c79d614f ].var_725c68b3 = var_784e2752;
    }
    else
    {
        if ( level.var_fdb0359e.section[ var_c79d614f ].var_725c68b3 == var_784e2752 )
        {
            while ( level.var_fdb0359e.section[ var_c79d614f ].var_725c68b3 == var_784e2752 )
            {
                var_784e2752 = array::random( var_b16d80e2 );
                wait 0.05;
            }
        }
        
        level.var_fdb0359e.section[ var_c79d614f ].var_725c68b3 = var_784e2752;
    }
    
    if ( !isai( self ) )
    {
        var_15e1308b = function_27e034fe( var_c79d614f, var_784e2752 );
    }
    else
    {
        var_15e1308b = self;
    }
    
    var_15e1308b.start_struct = var_784e2752;
    
    if ( isdefined( var_784e2752.script_noteworthy ) )
    {
        var_15e1308b.var_639fbd40 = var_784e2752.script_noteworthy;
    }
    
    if ( !isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 ) )
    {
        level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 = [];
    }
    
    if ( !isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 ) )
    {
        level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 = [];
    }
    else if ( !isarray( level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 ) )
    {
        level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 = array( level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 );
    }
    
    level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83[ level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83.size ] = var_15e1308b;
    level.var_fdb0359e.section[ var_c79d614f ].var_5a6384fe = 1;
    var_15e1308b thread function_13c0420d( flag );
    waitresult = var_15e1308b waittill( #"hash_7b78d67b14e33012", #"reached_path_end", #"hash_4f8182e08dbeba2", #"hash_32280351cf5d49ba", #"death", #"entitydeleted" );
    
    if ( !isdefined( var_15e1308b ) )
    {
        return;
    }
    
    if ( isdefined( var_15e1308b.var_639fbd40 ) && var_15e1308b.var_639fbd40 == "atrium" )
    {
        level function_eb07c311( "flag_atrium_ambient_scenes" );
    }
    else
    {
        var_15e1308b function_6353b83d();
    }
    
    level notify( #"hash_ee5ce4556fbfba0" );
    waitframe( 1 );
    
    if ( var_15e1308b scene::function_c935c42() )
    {
        if ( isdefined( var_15e1308b._scene_object._o_scene._e_root.targetname ) )
        {
            level scene::stop( var_15e1308b._scene_object._o_scene._e_root.targetname, 1 );
        }
    }
    
    if ( isdefined( var_15e1308b ) )
    {
        var_15e1308b delete();
    }
    
    function_1eaaceab( level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x3b58f593, Offset: 0x5000
// Size: 0x2a6
function function_6353b83d()
{
    level endon( #"kgb_fail_mission" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player endon( #"death" );
    count = 0;
    min_time = 50;
    max_time = 100;
    var_d0326866 = 640000;
    max_distance = 250000;
    min_distance = 40000;
    
    while ( isdefined( player ) )
    {
        distance = distancesquared( player.origin, self.origin );
        eye_pos = player getplayercamerapos();
        eye_angles = player getplayerangles();
        eye_dir = anglestoforward( eye_angles );
        var_dd9a54cd = cos( 45 );
        target_pos = self.origin + ( 0, 0, 30 );
        
        if ( util::within_fov( eye_pos, eye_angles, target_pos, var_dd9a54cd ) )
        {
            if ( distance > max_distance )
            {
                var_d94cabb4 = sighttracepassed( player geteye(), target_pos, 0, undefined );
                
                if ( !var_d94cabb4 )
                {
                    if ( count >= max_time )
                    {
                        break;
                    }
                    else
                    {
                        count++;
                        
                        /#
                        #/
                    }
                }
                else
                {
                    count = 0;
                }
            }
        }
        else if ( distance > var_d0326866 )
        {
            break;
        }
        else if ( distance > max_distance )
        {
            if ( count >= max_time )
            {
                break;
            }
            else
            {
                count++;
                
                /#
                #/
            }
        }
        else
        {
            count = 0;
        }
        
        wait 0.1;
    }
    
    self notify( #"hash_7cbff9b55c2727" );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x4616887e, Offset: 0x52b0
// Size: 0x208
function function_ff82cb1a()
{
    level endon( #"kgb_fail_mission" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player endon( #"death" );
    min_time = 1;
    max_time = 10;
    var_eb103505 = 2500;
    var_2a44f703 = 5625;
    lastposition = self.origin - var_eb103505;
    
    while ( isdefined( player ) )
    {
        newposition = self.origin;
        distancetraveled = distancesquared( newposition, lastposition );
        distancefromplayer = distancesquared( player.origin, self.origin );
        
        if ( self cansee( player ) && distancetraveled < var_eb103505 && distancefromplayer < var_2a44f703 )
        {
            self lookatentity( player, 1 );
            self dialogue::queue( "vox_cp_rkgb_02520_rms1_thankyoucomrade_a8" );
            wait 10;
            self lookatentity();
            lastposition = newposition;
            continue;
        }
        
        lastposition = newposition;
        wait 1;
        println( "<dev string:x38>" + self.origin );
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0x10414b58, Offset: 0x54c0
// Size: 0x6e
function function_13c0420d( flag )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    level flag::wait_till_any( array( flag, "flag_cleanup_kgb_hq" ) );
    self notify( #"hash_7b78d67b14e33012" );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0xe3ccfbd6, Offset: 0x5538
// Size: 0x9c
function function_24a7c694()
{
    level endon( #"flag_west_hall_civ_walker" );
    trigger = getent( "west_hall_civ_walker_trigger", "targetname" );
    trigger.door = trigger namespace_e77bf565::function_3203f263();
    trigger.door doors::waittill_door_opened();
    level flag::set( "flag_west_hall_civ_walker" );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 2
// Checksum 0x7d6b3133, Offset: 0x55e0
// Size: 0x3d2
function function_59bafa47( var_c79d614f, flag )
{
    level endon( #"flag_cleanup_kgb_hq" );
    level endon( #"kgb_fail_mission" );
    level endon( #"kgb_ins_rv_completed" );
    
    if ( !isdefined( flag ) )
    {
        flag = "flag_" + var_c79d614f + "_ambient_scenes";
    }
    
    level flag::wait_till( flag );
    var_9e9e1837 = struct::get_array( var_c79d614f + "_start_1", "targetname" );
    var_cd5c75b3 = struct::get_array( var_c79d614f + "_start_2", "targetname" );
    
    if ( !isdefined( level.var_fdb0359e.section[ var_c79d614f ] ) )
    {
        level.var_fdb0359e.section[ var_c79d614f ] = spawnstruct();
    }
    
    if ( var_c79d614f == "east_hall" )
    {
        scene::add_scene_func( "scene_kgb_ambient_stop_and_chat_duo_b", &function_5838a1f4 );
        level thread scene::play( "scene_kgb_ambient_stop_and_chat_duo_b" );
        wait 0.1;
        
        if ( isdefined( level.var_94737018 ) )
        {
            level.var_94737018 thread function_6feed719( var_c79d614f, var_cd5c75b3, flag );
            
            if ( isdefined( level.var_94737018.start_struct ) )
            {
                level.var_94737018.target = level.var_94737018.start_struct.targetname;
                level.var_94737018 thread spawner::go_to_node( level.var_94737018.start_struct );
                level.var_94737018 thread function_226f8d50();
            }
        }
        
        if ( isdefined( level.var_86b4d49b ) )
        {
            level.var_86b4d49b thread function_6feed719( var_c79d614f, var_9e9e1837, flag );
            
            if ( isdefined( level.var_86b4d49b.start_struct ) )
            {
                level.var_86b4d49b.target = level.var_86b4d49b.start_struct.targetname;
                level.var_86b4d49b thread spawner::go_to_node( level.var_86b4d49b.start_struct );
                level.var_86b4d49b thread function_226f8d50();
            }
        }
    }
    else
    {
        level thread function_6feed719( var_c79d614f, var_9e9e1837, flag );
        wait 0.1;
        level thread function_6feed719( var_c79d614f, var_cd5c75b3, flag );
    }
    
    wait 1;
    
    while ( isdefined( level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83 ) && level.var_fdb0359e.section[ var_c79d614f ].var_cd964f83.size > 0 )
    {
        wait 1;
    }
    
    level.var_fdb0359e.section[ var_c79d614f ].var_5a6384fe = undefined;
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0x9ee3cea8, Offset: 0x59c0
// Size: 0x40
function function_5838a1f4( a_ents )
{
    level.var_94737018 = a_ents[ #"hash_564e9bf9aa88538f" ];
    level.var_86b4d49b = a_ents[ #"hash_564e9cf9aa885542" ];
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0xc59b71a1, Offset: 0x5a08
// Size: 0x5c
function function_3cb2286e()
{
    level endon( #"flag_cleanup_kgb_hq" );
    level endon( #"kgb_fail_mission" );
    scene::add_scene_func( "scene_kgb_ambient_harass_zakhaev_kravchenko", &function_645c6620 );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0x550c3e2f, Offset: 0x5a70
// Size: 0xcc
function function_645c6620( a_ents )
{
    level endon( #"hash_184a766cab2b78a7" );
    var_7198a076 = a_ents[ #"hash_713540a10ff22151" ];
    kravchenko = a_ents[ #"kravchenko" ];
    var_7198a076 endon( #"death", #"delete" );
    kravchenko endon( #"death", #"delete" );
    thread function_fe077ca7( var_7198a076, kravchenko );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 2
// Checksum 0x65712d00, Offset: 0x5b48
// Size: 0x110
function function_fe077ca7( var_7198a076, kravchenko )
{
    var_633aa908 = spawn( "trigger_radius", var_7198a076.origin + ( 0, 224, 0 ), 0, 96, 64 );
    var_7198a076.var_633aa908 = var_633aa908;
    var_633aa908 waittill( #"trigger" );
    var_7198a076 lookatentity( getplayers()[ 0 ] );
    kravchenko lookatentity( getplayers()[ 0 ] );
    wait 1;
    dialogue::function_47b06180();
    level notify( #"hash_184a766cab2b78a7" );
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0x8e31e4d4, Offset: 0x5c60
// Size: 0x250
function function_382a2785( a_ents )
{
    civ_male = a_ents[ #"civ_male" ];
    var_6c6006 = a_ents[ #"hash_6e83c9503d67b052" ];
    civ_male endon( #"death", #"delete" );
    var_6c6006 endon( #"death", #"delete" );
    trigger = spawn( "trigger_radius", civ_male.origin, 0, 256, 64 );
    civ_male.trigger = trigger;
    civ_male callback::function_d8abfc3d( #"on_ai_killed", &function_dc6db93b );
    civ_male callback::function_d8abfc3d( #"on_entity_deleted", &function_dc6db93b );
    var_6c6006.trigger = trigger;
    var_6c6006 callback::function_d8abfc3d( #"on_ai_killed", &function_dc6db93b );
    var_6c6006 callback::function_d8abfc3d( #"on_entity_deleted", &function_dc6db93b );
    
    while ( true )
    {
        trigger waittill( #"trigger" );
        civ_male dialogue::queue( "vox_cp_rkgb_02520_rms1_comradeplaceyou_5a" );
        var_6c6006 dialogue::queue( "vox_cp_rkgb_02520_adlr_theresnoneedfor_d7" );
        civ_male dialogue::queue( "vox_cp_rkgb_02520_rms1_donttakeitperso_5e" );
        wait randomfloatrange( 5, 10 );
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 1
// Checksum 0xd6444321, Offset: 0x5eb8
// Size: 0x3b8
function function_838eb65b( a_ents )
{
    var_bfb1d8a6 = a_ents[ #"hash_466e7d5eb78abd77" ];
    var_6a5eae01 = a_ents[ #"hash_466e7e5eb78abf2a" ];
    var_bfb1d8a6 endon( #"death", #"delete" );
    var_6a5eae01 endon( #"death", #"delete" );
    trigger = spawn( "trigger_radius", var_bfb1d8a6.origin, 0, 256, 64 );
    var_bfb1d8a6.trigger = trigger;
    var_bfb1d8a6 callback::function_d8abfc3d( #"on_ai_killed", &function_dc6db93b );
    var_bfb1d8a6 callback::function_d8abfc3d( #"on_entity_deleted", &function_dc6db93b );
    var_6a5eae01.trigger = trigger;
    var_6a5eae01 callback::function_d8abfc3d( #"on_ai_killed", &function_dc6db93b );
    var_6a5eae01 callback::function_d8abfc3d( #"on_entity_deleted", &function_dc6db93b );
    
    if ( isdefined( var_bfb1d8a6._scene_object._o_scene._e_root.targetname ) && issubstr( var_bfb1d8a6._scene_object._o_scene._e_root.targetname, "atrium" ) )
    {
        while ( true )
        {
            trigger waittill( #"trigger" );
            var_bfb1d8a6 dialogue::queue( "vox_cp_rkgb_02520_rms1_comradeplaceyou_5a" );
            var_6a5eae01 dialogue::queue( "vox_cp_rkgb_02520_adlr_theresnoneedfor_d7" );
            var_bfb1d8a6 dialogue::queue( "vox_cp_rkgb_02520_rms1_donttakeitperso_5e" );
            wait randomfloatrange( 50, 120 );
        }
        
        return;
    }
    
    if ( isdefined( var_bfb1d8a6._scene_object._o_scene._e_root.targetname ) && issubstr( var_bfb1d8a6._scene_object._o_scene._e_root.targetname, "lobby_and_checkpoint" ) )
    {
        while ( true )
        {
            trigger waittill( #"trigger" );
            var_bfb1d8a6 dialogue::queue( "vox_cp_rkgb_02520_blkv_comradeyouarene_33" );
            var_6a5eae01 dialogue::queue( "vox_cp_rkgb_02520_rms1_thankyoucomrade_a8" );
            var_bfb1d8a6 dialogue::queue( "vox_cp_rkgb_02520_blkv_iwasheldup_a4" );
            wait randomfloatrange( 50, 120 );
        }
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x3a60074d, Offset: 0x6278
// Size: 0x2c
function function_dc6db93b()
{
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
}

// Namespace namespace_99e99ffa/namespace_a1c9ba7c
// Params 0
// Checksum 0x59c3132c, Offset: 0x62b0
// Size: 0x64
function function_eb4c6bd2()
{
    var_8b2c48f = getent( "lobby_and_checkpoint_playercollision", "targetname" );
    level flag::wait_till( "kgb_ins_rv_completed" );
    var_8b2c48f delete();
}

