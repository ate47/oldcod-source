#using script_13209888df6eddf6;
#using script_1b9f100b85b7e21d;
#using script_25b0725f0d26dbf5;
#using script_32ff16d71b77016b;
#using script_3711e526ec2a3863;
#using script_3dc93ca9902a9cda;
#using script_4a5e7e929ab4ac21;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_nam_armada;
#using scripts\cp\cp_nam_armada_fx;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace armada_mortar;

// Namespace armada_mortar/namespace_e6855491
// Params 2
// Checksum 0xa11cbfe6, Offset: 0x1910
// Size: 0x65c
function function_6ad1ac64( var_d3440450, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        level namespace_b7cfe907::function_6a03d24d( var_d3440450 );
        level util::screen_fade_out( 0, "black", "flyin_fade_out" );
    }
    
    level scene::init( #"hash_253ecfc6e16559a" );
    level scene::init( #"hash_276fd471a23c44bd" );
    level scene::init( #"hash_4b085675c2abcac4" );
    level.player val::set( #"hash_ed07d10944e0fd5", "freezecontrols", 1 );
    level clientfield::set( "toggle_gameplay_character_visibility", 1 );
    level snd::client_msg( #"hash_4a41082a1d97f925" );
    level flag::set( "flag_mortar_orbit_start" );
    level thread namespace_b7cfe907::function_d3acba36( #"allies" );
    level.var_52874eb2 = undefined;
    level function_6b5096fe();
    var_507c8182 = getvehiclenode( "mortar_orbit_landing", "targetname" );
    level util::delay( 1, undefined, &util::screen_fade_in, 2, "black", "flyin_fade_out" );
    level.player util::delay( 1, "death", &val::reset, #"hash_ed07d10944e0fd5", "freezecontrols" );
    level thread function_5f51bebf();
    level thread function_a1de7ea2( 1 );
    level thread vehicle::get_in( level.buddy, level.var_7466d419, "crew", 1 );
    level flag::clear( "flag_player_flying_ambience_start" );
    level flag::set( "flag_player_flying_ambience_kill" );
    level flag::set( "flag_vo_mortar_orbit_arrival_start" );
    mortar_orbit_player_start_node = getvehiclenode( "mortar_orbit_player_start_node", "targetname" );
    mortar_orbit_adler_start_node = getvehiclenode( "mortar_orbit_adler_start_node", "targetname" );
    level.var_52874eb2.origin = mortar_orbit_adler_start_node.origin;
    level.var_52874eb2.angles = mortar_orbit_adler_start_node.angles;
    level.var_52874eb2 setspeedimmediate( 60 );
    level.var_52874eb2.drivepath = 1;
    level.var_7466d419.origin = mortar_orbit_player_start_node.origin;
    level.var_7466d419.angles = mortar_orbit_player_start_node.angles;
    level.var_7466d419 setspeedimmediate( 62 );
    level.var_7466d419.drivepath = 1;
    namespace_72b0499b::music( "tmp_mortar_orbit", 12 );
    level objectives::scripted( #"hash_4911c9bd27e58ec4", undefined, #"hash_a1263ddeb213c22" );
    level thread function_5901663e();
    level thread function_285ff4e4();
    level.var_52874eb2 thread function_ba10e034();
    level.var_52874eb2 thread function_6cce8b8e();
    level.var_52874eb2 thread vehicle::get_on_and_go_path( mortar_orbit_adler_start_node );
    level namespace_b7cfe907::function_d777fe61( 2 );
    level util::delay( 0.5, undefined, &function_b1183adb );
    level.var_7466d419 thread function_6cce8b8e();
    level.var_7466d419 vehicle::get_on_and_go_path( mortar_orbit_player_start_node );
    level flag::set( "flag_orbit_mortar_allow_land" );
    level.var_7466d419 vehicle::detach_path();
    waitframe( 1 );
    level.var_7466d419 vehicle::get_on_and_go_path( var_507c8182 );
    level flag::set( "flag_mortar_orbit_complete" );
    level objectives::complete( #"hash_4911c9bd27e58ec4" );
    next_obj = "armada_mortar_start";
    level skipto::function_4e3ab877( "armada_mortar_orbit", 0 );
    level skipto::function_51726ac8( [ next_obj ], 0, level.player );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xe6bb1bfb, Offset: 0x1f78
// Size: 0x4c
function function_b1183adb()
{
    level.player setplayerangles( anglestoforward( level.var_7466d419 function_90d45d34( 2 ) ) );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x6c7d1811, Offset: 0x1fd0
// Size: 0xe4
function function_6cce8b8e()
{
    level endon( #"flag_mortar_orbit_complete" );
    self endon( #"death" );
    self setyawspeed( 15, 15, 15 );
    self setmaxpitchroll( 60, 60 );
    self waittill( #"hash_2717c5ec282f117c" );
    self setspeed( 20, 30, 30 );
    self waittill( #"hash_2717c8ec282f1695" );
    self setspeed( 15, 20, 20 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xc2573c22, Offset: 0x20c0
// Size: 0x1dc
function function_6acbfbb1()
{
    a_ents = [];
    a_ents[ #"player" ] = level.player;
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"pilot" ] = level.pilot;
    a_ents[ #"copilot" ] = level.copilot;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level namespace_b7cfe907::function_3af72756( level.var_7466d419, level.pilot, "driver" );
    level namespace_b7cfe907::function_3af72756( level.var_7466d419, level.copilot, "passenger1" );
    level function_d380c058();
    level function_7b3aab80();
    waitframe( 1 );
    level scene::play( #"hash_32b809763b13c282", a_ents );
    level.pilot util::stop_magic_bullet_shield();
    level.copilot util::stop_magic_bullet_shield();
    level.var_7466d419 delete();
    level.pilot delete();
    level.copilot delete();
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x61f48efd, Offset: 0x22a8
// Size: 0x94
function function_5f51bebf()
{
    level.player util::function_749362d7( 0 );
    level.player setmovespeedscale( 1 );
    level.player val::reset( "armada_intro", "allow_crouch" );
    level.player val::reset( "armada_intro", "allow_prone" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xbb9d956a, Offset: 0x2348
// Size: 0xdc
function function_7b3aab80()
{
    if ( level flag::get( "flag_player_chopper_screenshake_active" ) )
    {
        level flag::clear( "flag_player_chopper_screenshake_active" );
    }
    
    level.var_7466d419 makevehicleusable();
    level.var_7466d419 usevehicle( level.player, 2 );
    level.var_7466d419 setseatoccupied( 2, 1 );
    level.var_7466d419 makevehicleunusable();
    level flag::set( "flag_orbit_mortar_player_on_ground" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xba6321cc, Offset: 0x2430
// Size: 0x114
function function_d380c058()
{
    tele = struct::get( "mortar_buddy_teleport_landing_4", "targetname" );
    
    if ( isdefined( level.buddy ) )
    {
        level namespace_b7cfe907::function_3af72756( level.var_7466d419, level.buddy, "crew" );
        level.buddy thread namespace_b7cfe907::swap_hat_model();
    }
    else
    {
        namespace_b7cfe907::function_ed68628c( 0, tele, 1 );
    }
    
    level.buddy thread colors::set_force_color( "g" );
    level flag::set( "flag_enable_mortar_courtyard_color_chain" );
    
    /#
        level.buddy thread namespace_b7cfe907::function_becb869c( "<dev string:x38>", "<dev string:x40>" );
    #/
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xcf585049, Offset: 0x2550
// Size: 0x5c
function function_5901663e()
{
    level thread function_6610ecb5();
    level flag::wait_till( "flag_orbit_mortar_player_on_ground" );
    level flag::set( "flag_vo_mortar_orbit_landing_requested" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xa6e8dfdd, Offset: 0x25b8
// Size: 0x13c
function function_6610ecb5()
{
    level.var_7466d419 endon( #"death" );
    trigger::wait_till( "trigger_mortar_orbit_rpg_attack" );
    e_enemy = spawner::simple_spawn_single( "mortar_orbit_tower_rpg_enemy" );
    var_33d2e98f = struct::get( "mortar_orbit_tower_upper" );
    s_target = struct::get( "mortar_orbit_rpg_end_1" );
    var_98997b7 = getweapon( #"hash_513c26c6a751d20e" );
    v_velocity = vectornormalize( s_target.origin - var_33d2e98f.origin ) * 2000;
    
    for ( i = 0; i < 3 ; i++ )
    {
        e_enemy magicmissile( var_98997b7, var_33d2e98f.origin, v_velocity );
        wait 0.1;
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xc329b3f2, Offset: 0x2700
// Size: 0x64
function function_eedbf53e()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    self.favoriteenemy = level.player;
    level flag::wait_till( "flag_vo_mortar_orbit_landing_complete" );
    self deletedelay();
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x1d2c2062, Offset: 0x2770
// Size: 0x104
function function_f4b64f5a()
{
    level.var_390f44c5 = [];
    level function_1a495d54( "mortar_team_a" );
    level function_1a495d54( "mortar_team_b" );
    level function_1a495d54( "mortar_team_e" );
    callback::on_ai_killed( &function_3deece18 );
    var_b2584c71 = 0;
    var_f975276d = level.var_390f44c5.size;
    
    while ( true )
    {
        level waittill( #"hash_78b4cca87a5eb7f8" );
        var_b2584c71++;
        
        if ( var_b2584c71 >= var_f975276d )
        {
            break;
        }
    }
    
    callback::remove_on_ai_killed( &function_3deece18 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x8980f013, Offset: 0x2880
// Size: 0x114
function function_1a495d54( group )
{
    spawners = getspawnerarray( group, "targetname" );
    
    foreach ( spawner in spawners )
    {
        guy = spawner spawner::spawn( 1 );
        guy thread function_209facbc( group );
    }
    
    level flag::set( "flag_orbit_mortar_crews_spawned" );
    thread function_4d420085( group );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x3fdeee2b, Offset: 0x29a0
// Size: 0x86
function function_209facbc( group )
{
    self endon( #"death" );
    array::add( level.var_390f44c5, self, 0 );
    self.goalradius = 8;
    self.ignoreall = 1;
    level waittill( group + "_hit" );
    self.goalradius = 2048;
    self.ignoreall = 0;
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x5c1b3112, Offset: 0x2a30
// Size: 0x13c
function function_4d420085( group )
{
    trigger = getent( group + "_trig", "targetname" );
    
    while ( true )
    {
        waitresult = trigger waittill( #"damage" );
        
        if ( waitresult.attacker === level.player )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    var_c8cf119f = group + "_hit";
    level notify( var_c8cf119f );
    wait 2;
    
    if ( !flag::get( "flag_" + group + "_cleared" ) )
    {
        level flag::set( "flag_vo_mortar_orbit_mortar_flee" );
        level notify( group + "_cleared" );
    }
    
    wait 1;
    level flag::clear( "flag_vo_mortar_orbit_mortar_flee" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x29074ad6, Offset: 0x2b78
// Size: 0x3c
function function_3deece18()
{
    waitframe( 1 );
    function_1eaaceab( level.var_390f44c5 );
    var_3f52048 = level.var_390f44c5.size;
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xaa1680ef, Offset: 0x2bc0
// Size: 0x14c
function function_73e76e26()
{
    var_c837774d = [ struct::get( "obj_mortar_team_a" ), struct::get( "obj_mortar_team_b" ), struct::get( "obj_mortar_team_e" ) ];
    level objectives::kill( "armada_obj_mortar_orbit_clear_mortar", var_c837774d, #"hash_a1263ddeb213c22", 0, 0, 0 );
    level objectives::function_67f87f80( "armada_obj_mortar_orbit_clear_mortar", var_c837774d, #"hash_61b28ddb13f1d5b2" );
    level thread function_5e8e8bec( var_c837774d );
    level flag::wait_till( "flag_mortar_orbit_complete" );
    level objectives::complete( "armada_obj_mortar_orbit_clear_mortar", var_c837774d, 0 );
    level objectives::complete( "armada_obj_mortar_orbit_clear_mortar", undefined, 0 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x88426535, Offset: 0x2d18
// Size: 0x2d4
function function_5e8e8bec( var_c837774d )
{
    level endon( #"flag_orbit_mortar_allow_land" );
    level.var_74bc4f87 = 0;
    
    while ( true )
    {
        waitresult = level waittill( #"hash_34916b6efcb30af", #"hash_1984d363213cbb6e", #"hash_3e1eb91d3ac248cb" );
        var_3e637b27 = 0;
        
        switch ( waitresult._notify )
        {
            case #"hash_34916b6efcb30af":
                if ( flag::get( "flag_mortar_team_a_cleared" ) )
                {
                    var_3e637b27 = 1;
                }
                else
                {
                    level objectives::complete( "armada_obj_mortar_orbit_clear_mortar", var_c837774d[ 0 ], 0 );
                    flag::set( "flag_mortar_team_a_cleared" );
                }
                
                break;
            case #"hash_1984d363213cbb6e":
                if ( flag::get( "flag_mortar_team_b_cleared" ) )
                {
                    var_3e637b27 = 1;
                }
                else
                {
                    level objectives::complete( "armada_obj_mortar_orbit_clear_mortar", var_c837774d[ 1 ], 0 );
                    flag::set( "flag_mortar_team_b_cleared" );
                }
                
                break;
            case #"hash_3e1eb91d3ac248cb":
                if ( flag::get( "flag_mortar_team_e_cleared" ) )
                {
                    var_3e637b27 = 1;
                }
                else
                {
                    level objectives::complete( "armada_obj_mortar_orbit_clear_mortar", var_c837774d[ 2 ], 0 );
                    flag::set( "flag_mortar_team_e_cleared" );
                }
                
                break;
        }
        
        if ( var_3e637b27 )
        {
            continue;
        }
        
        level.var_74bc4f87++;
        level notify( #"hash_3eb3c24dcfb40680" );
        
        if ( level.var_74bc4f87 == 3 )
        {
            flag::set( "obj_flag_mortar_orbit_clear_mortars_complete" );
            flag::set( "flag_mortar_orbit_clear_min_mortars_complete" );
            level objectives::complete( "armada_obj_mortar_orbit_clear_mortar" );
            level flag::set( "flag_orbit_mortar_allow_land" );
            break;
        }
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xd455da65, Offset: 0x2ff8
// Size: 0x1fc
function function_bfff6d67()
{
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_team_a_1", undefined, 3, 5, "mortar_team_a_hit", "flag_mortar_orbit_complete" );
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_team_a_2", undefined, 3, 5, "mortar_team_a_hit", "flag_mortar_orbit_complete" );
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_team_a_3", undefined, 3, 5, "mortar_team_a_hit", "flag_mortar_orbit_complete" );
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_team_b_1", undefined, 3, 5, "mortar_team_b_hit", "flag_mortar_orbit_complete" );
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_team_b_2", undefined, 3, 5, "mortar_team_b_hit", "flag_mortar_orbit_complete" );
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_team_e_1", undefined, 3, 5, "mortar_team_e_hit", "flag_mortar_orbit_complete" );
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_team_e_2", undefined, 3, 5, "mortar_team_e_hit", "flag_mortar_orbit_complete" );
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_team_e_3", undefined, 3, 5, "mortar_team_e_hit", "flag_mortar_orbit_complete" );
    level thread namespace_b7cfe907::function_6a00dfe2( "mortar_objective_upper", "flag_firebase_checkin_complete", 3, 5, "mortar_site_upper_complete" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 2
// Checksum 0xdcb084d0, Offset: 0x3200
// Size: 0x334
function function_94a21d8b( var_d3440450, var_50cc0d4f )
{
    if ( !isdefined( level.var_86e3ed67 ) )
    {
        level.var_86e3ed67 = struct::get( var_d3440450 );
    }
    
    if ( var_50cc0d4f )
    {
        level thread function_a1de7ea2( 1 );
        level namespace_b7cfe907::function_6a03d24d( var_d3440450 );
        level function_6b5096fe();
        level.var_7466d419 vehicle::get_on_and_go_path( getvehiclenode( "mortar_orbit_landing", "targetname" ) );
    }
    
    level thread function_a3d29239();
    callback::on_ai_spawned( &function_5cce18fe );
    level.var_52874eb2 thread function_17cadeb1();
    level util::delay( 7.5, undefined, &function_8199c444 );
    namespace_72b0499b::music( "tmp_mortar_village", 7.5 );
    level function_6acbfbb1();
    level.player thread function_11e2bd76();
    level snd::client_msg( #"hash_2086d5e690a6ff1b" );
    level thread function_80089cc9();
    level thread function_b2d38e15();
    level flag::wait_till( "obj_flag_mortar_site_a" );
    iprintlnbold( "Time for exfil!" );
    callback::remove_on_ai_spawned( &function_5cce18fe );
    spawner::remove_spawn_function_ai_group( "mortar_ai", &function_af189a4c );
    spawner::remove_spawn_function_ai_group( "tea_house", &function_af189a4c );
    spawner::remove_spawn_function_ai_group( "mortar_ai_wave_3_right", &function_287230c8 );
    spawner::remove_spawn_function_ai_group( "mortar_ai_wave_3_left", &function_287230c8 );
    level skipto::function_4e3ab877( var_d3440450, 0 );
    level skipto::function_51726ac8( [ "armada_mortar_exfil" ], 0, level.player );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x647e5386, Offset: 0x3540
// Size: 0x6c
function function_b2d38e15()
{
    level endon( #"mortar_site_upper_complete" );
    level savegame::checkpoint_save( 1 );
    level flag::wait_till( "flag_set_teahouse_checkpoint" );
    level savegame::checkpoint_save( 1 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x564d4855, Offset: 0x35b8
// Size: 0x5a
function function_5cce18fe()
{
    if ( self.aitype === "spawner_bo5_human_enemy_vc_rpg_armada" || is_true( self.var_99b46f13 ) )
    {
        if ( isdefined( level.var_52874eb2 ) )
        {
            self.favoriteenemy = level.var_52874eb2;
        }
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x98f0faae, Offset: 0x3620
// Size: 0x74
function function_11e2bd76()
{
    self endon( #"death" );
    self val::set( #"hash_fbe5c5727eb30d7", "ignoreme", 1 );
    wait 8;
    self val::reset( #"hash_fbe5c5727eb30d7", "ignoreme" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xe7f3f56d, Offset: 0x36a0
// Size: 0xa4
function function_17cadeb1()
{
    level thread function_c26a3b4e( "flag_mortar_teahouse_chopper_attack", "mortar_town_chopper_attack_path_3", "s_attack_path_target_3", 1 );
    s_start = struct::get( "adler_chopper_starting_path_01" );
    self function_97519340( s_start );
    wait 5;
    self thread function_c1918a6b( 8 );
    self thread function_ab1c35d7();
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x53d56c21, Offset: 0x3750
// Size: 0x134
function function_97519340( nd_start )
{
    self.origin = nd_start.origin;
    self.angles = nd_start.angles;
    self setspeed( 0.01 );
    self.origin = nd_start.origin;
    self.angles = nd_start.angles;
    self setgoalyaw( ( 0, self.angles[ 1 ], 0 )[ 1 ] );
    self function_a57c34b7( self.origin + ( 0, 0, 4 ), 1, 0 );
    self setyawspeed( 120, 60, 60 );
    self setmaxpitchroll( 30, 60 );
    self.var_cb55c804 = 256;
    self setneargoalnotifydist( self.var_cb55c804 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x910acc37, Offset: 0x3890
// Size: 0x352
function function_ab1c35d7()
{
    level endon( #"hash_14c598f73c025763" );
    level.player endon( #"death" );
    self endon( #"death" );
    var_98576f20 = undefined;
    var_54081ff9 = undefined;
    var_a9ad8d56 = struct::get_array( "adler_heli_loop_anchor" );
    var_a9ad8d56 = array::sort_by_script_int( var_a9ad8d56, 1 );
    var_777b7e33 = struct::get_array( "adler_heli_hover_anchor" );
    var_777b7e33 = array::sort_by_script_int( var_777b7e33, 1 );
    s_anchor = var_777b7e33[ 0 ];
    self thread function_1e3fd6e0();
    self setspeedimmediate( 30 );
    
    while ( true )
    {
        if ( level flag::get( "flag_mortar_upper_mortar_building_reached" ) )
        {
            s_anchor = var_777b7e33[ 4 ];
        }
        else if ( level flag::get( "flag_mortar_courtyard_ai_cleared" ) )
        {
            s_anchor = var_777b7e33[ 1 ];
        }
        else if ( !isdefined( s_anchor ) )
        {
            s_anchor = function_506eaf20( var_777b7e33, var_a9ad8d56 );
        }
        
        if ( s_anchor.targetname === "adler_heli_loop_anchor" )
        {
            var_90df9642 = getvehiclenode( s_anchor.target, "targetname" );
            
            if ( isdefined( var_90df9642 ) )
            {
                self function_536cff7e( var_90df9642 );
                self function_f7dc2ff0( var_90df9642, s_anchor, var_777b7e33, var_a9ad8d56 );
            }
        }
        else if ( s_anchor.targetname === "adler_heli_hover_anchor" )
        {
            var_ab11eba4 = struct::get_array( s_anchor.target );
            
            if ( var_ab11eba4.size && isdefined( var_98576f20 ) )
            {
                arrayremovevalue( var_ab11eba4, var_98576f20 );
            }
            
            var_98576f20 = array::random( var_ab11eba4 );
            
            if ( isdefined( var_98576f20 ) )
            {
                if ( var_54081ff9 === s_anchor.script_int )
                {
                    var_1eea8080 = 0;
                }
                else
                {
                    var_54081ff9 = s_anchor.script_int;
                    var_1eea8080 = 1;
                }
                
                self function_5a365113( var_98576f20, var_1eea8080 );
                self waittilltimeout( randomfloatrange( 5, 8 ), #"damage" );
            }
        }
        
        waitframe( 1 );
        s_anchor = undefined;
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 2
// Checksum 0x90d071f2, Offset: 0x3bf0
// Size: 0xda
function function_506eaf20( var_777b7e33, var_a9ad8d56 )
{
    s_anchor = arraygetclosest( level.player.origin, var_777b7e33 );
    
    if ( !isdefined( s_anchor.radius ) )
    {
        s_anchor.radius = 800;
    }
    
    a_enemies = self getenemiesinradius( s_anchor.origin, s_anchor.radius );
    
    if ( a_enemies.size < 2 )
    {
        s_anchor = arraygetclosest( level.player.origin, var_a9ad8d56 );
    }
    
    return s_anchor;
}

// Namespace armada_mortar/namespace_e6855491
// Params 4
// Checksum 0x8b7befcd, Offset: 0x3cd8
// Size: 0x8e
function function_f7dc2ff0( var_90df9642, s_anchor, var_777b7e33, var_a9ad8d56 )
{
    self endon( #"death" );
    self vehicle::get_on_path( var_90df9642 );
    self thread function_7882569f( s_anchor, var_777b7e33, var_a9ad8d56 );
    self vehicle::go_path();
    self notify( #"loop_done" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 3
// Checksum 0x941098c7, Offset: 0x3d70
// Size: 0xc8
function function_7882569f( s_anchor, var_777b7e33, var_a9ad8d56 )
{
    self endon( #"death", #"loop_done", #"stop path" );
    
    while ( true )
    {
        var_ab252334 = function_506eaf20( var_777b7e33, var_a9ad8d56 );
        
        if ( s_anchor.targetname != var_ab252334.targetname || s_anchor.script_int != var_ab252334.script_int )
        {
            self notify( #"stop path" );
        }
        
        wait 1;
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 5
// Checksum 0x8954ca14, Offset: 0x3e40
// Size: 0xb4
function function_c26a3b4e( str_flag, str_node, str_target, var_34cfd35c = 0, n_delay = 0 )
{
    level endon( #"exfil_flyby_go" );
    level flag::wait_till( str_flag );
    wait n_delay;
    
    while ( !isdefined( level.var_52874eb2 ) )
    {
        wait 0.5;
    }
    
    level.var_52874eb2 function_b5439516( str_node, str_target, var_34cfd35c );
}

// Namespace armada_mortar/namespace_e6855491
// Params 3
// Checksum 0xd42e87da, Offset: 0x3f00
// Size: 0x14c
function function_b5439516( str_node, str_target, var_34cfd35c )
{
    self endon( #"death" );
    self notify( "37adf78fa26ea6c0" );
    self endon( "37adf78fa26ea6c0" );
    level endon( #"exfil_flyby_go" );
    
    if ( isdefined( str_target ) )
    {
        s_target = struct::get( str_target );
    }
    
    nd_start = getvehiclenode( str_node, "targetname" );
    
    if ( !isdefined( nd_start ) )
    {
        return;
    }
    
    level notify( #"hash_14c598f73c025763" );
    
    if ( var_34cfd35c )
    {
        self function_97519340( nd_start );
    }
    
    self function_536cff7e( nd_start );
    self thread function_82ba400e( s_target );
    self vehicle::get_on_and_go_path( nd_start );
    self thread function_ab1c35d7();
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x6cac6b7a, Offset: 0x4058
// Size: 0x1c4
function function_82ba400e( s_target )
{
    self endon( #"death" );
    self turret::enable( 1, 0 );
    self turret::enable( 3, 0 );
    self turret::enable( 4, 0 );
    self waittill( #"hash_3ea4db032aff8725" );
    
    if ( isdefined( s_target ) )
    {
        self function_8060162f( s_target.origin, 1 );
    }
    
    a_ai_enemies = getaiteamarray( #"axis" );
    
    foreach ( e_enemy in a_ai_enemies )
    {
        if ( is_true( e_enemy.var_99b46f13 ) )
        {
            e_target_1 = e_enemy;
            break;
        }
    }
    
    if ( !isdefined( e_target_1 ) )
    {
        e_target_1 = function_67565f43( 1 );
    }
    
    if ( isdefined( e_target_1 ) )
    {
        self thread function_8060162f( e_target_1.origin, 1 );
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 2
// Checksum 0x1d7ba801, Offset: 0x4228
// Size: 0x124
function function_8060162f( v_target, n_index = 1 )
{
    self endon( #"death" );
    var_9012c9b0 = getweapon( #"hash_73d955d55fddba26" );
    
    for ( i = 0; i < 50 ; i++ )
    {
        v_start = self gettagorigin( "tag_gunner_flash" + n_index );
        playfxontag( #"hash_6d6d720fe18d9609", self, "tag_gunner_flash" + n_index );
        magicbullet( var_9012c9b0, v_start, v_target );
        wait 0.05;
        magicbullet( var_9012c9b0, v_start, v_target );
        wait 0.1;
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x66778dca, Offset: 0x4358
// Size: 0x174
function function_1e3fd6e0()
{
    self notify( "809b9c7e4746a26" );
    self endon( "809b9c7e4746a26" );
    self endon( #"death" );
    level endon( #"hash_14c598f73c025763" );
    var_fc952c52 = struct::get_array( "adler_heli_attack_anchor" );
    self turret::function_41c79ce4( 1, 1 );
    self turret::clear_target( 1 );
    self turret::set_ignore_line_of_sight( 1, 1 );
    self turret::function_8bbe7822( 1, 1 );
    self turret::function_bb42e3e2( 1, 1 );
    self turret::set_burst_parameters( 1, 2, 0.25, 0.5, 1 );
    self turret::enable( 1, 0 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xe2e97ccd, Offset: 0x44d8
// Size: 0x8c
function function_c1918a6b( *n_time )
{
    self endon( #"death" );
    var_467de2d4 = ( 0, 0, 24 );
    self waittill( #"hash_147d5f5088eee4af" );
    wait 2;
    self turret::enable( 3, 0, var_467de2d4 );
    self turret::enable( 4, 0, var_467de2d4 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 2
// Checksum 0x98c8fe00, Offset: 0x4570
// Size: 0x1d2
function function_67565f43( n_index, var_2e91c04f )
{
    a_ai_enemies = getaiteamarray( #"axis" );
    
    if ( isdefined( var_2e91c04f ) )
    {
        arrayremovevalue( a_ai_enemies, var_2e91c04f );
    }
    
    var_20e463d4 = array::filter_classname( a_ai_enemies, 0, "actor_spawner_bo5_human_enemy_vc_rpg_armada" );
    
    foreach ( ai_enemy in var_20e463d4 )
    {
        if ( isalive( ai_enemy ) && self turret::can_hit_target( ai_enemy, n_index ) )
        {
            return ai_enemy;
        }
    }
    
    foreach ( ai_enemy in a_ai_enemies )
    {
        if ( isalive( ai_enemy ) && self turret::can_hit_target( ai_enemy, n_index ) )
        {
            return ai_enemy;
        }
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 2
// Checksum 0x6624146a, Offset: 0x4750
// Size: 0x1e4
function function_536cff7e( start_node, n_speed = 40 )
{
    self endon( #"death" );
    self setspeed( n_speed );
    self vehlookat( start_node.origin );
    self function_a57c34b7( start_node.origin, 1, 0 );
    self setgoalyaw( ( 0, start_node.angles[ 1 ], 0 )[ 1 ] );
    self settargetyaw( ( 0, start_node.angles[ 1 ], 0 )[ 1 ] );
    self waittill( #"goal", #"near_goal", #"reached_end_node", #"reached_node" );
    self vehclearlookat();
    self cleartargetyaw();
    self cleargoalyaw();
    self function_d4c687c9();
    self function_a57c34b7( self.origin + ( 0, 0, 4 ), 1, 0 );
    self setspeed( 30, 20, 20 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 2
// Checksum 0x40ef59fd, Offset: 0x4940
// Size: 0x2dc
function function_5a365113( var_7e2d8151, var_1eea8080 = 0 )
{
    self endon( #"death" );
    self vehicle_ai::clearallmovement();
    
    if ( var_1eea8080 )
    {
        self setspeed( 30, 20, 20 );
        self vehlookat( var_7e2d8151.origin );
        self function_a57c34b7( var_7e2d8151.origin + ( 0, 0, 500 ), 1, 0 );
        self.var_cb55c804 = 256;
        self setneargoalnotifydist( self.var_cb55c804 );
        self sethoverparams( 30, 20, 20 );
        self waittilltimeout( 10, #"near_goal", #"goal" );
        self vehclearlookat();
        self settargetyaw( ( 0, var_7e2d8151.angles[ 1 ], 0 )[ 1 ] );
        self setgoalyaw( ( 0, var_7e2d8151.angles[ 1 ], 0 )[ 1 ] );
        self notify( #"hash_147d5f5088eee4af" );
    }
    
    self setspeed( 30, 20, 20 );
    self function_a57c34b7( var_7e2d8151.origin, 1, 0 );
    self.var_cb55c804 = 256;
    self setneargoalnotifydist( self.var_cb55c804 );
    self sethoverparams( 30, 20, 20 );
    self waittilltimeout( 10, #"near_goal", #"goal" );
    self settargetyaw( ( 0, var_7e2d8151.angles[ 1 ], 0 )[ 1 ] );
    self setgoalyaw( ( 0, var_7e2d8151.angles[ 1 ], 0 )[ 1 ] );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x5361226, Offset: 0x4c28
// Size: 0xfc
function function_8199c444()
{
    spawner::add_spawn_function_ai_group( "mortar_ai", &function_af189a4c );
    spawner::add_spawn_function_ai_group( "tea_house", &function_af189a4c );
    spawner::add_spawn_function_ai_group( "mortar_ai_wave_3_right", &function_287230c8 );
    spawner::add_spawn_function_ai_group( "mortar_ai_wave_3_left", &function_287230c8 );
    level function_114d3739();
    level thread function_fb965703();
    level thread function_dcf0253();
    thread function_ded27710();
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xd4709caa, Offset: 0x4d30
// Size: 0xa4
function function_114d3739()
{
    array::delete_all( spawner::get_ai_group_ai( "mortar_orbit_ai" ) );
    array::delete_all( spawner::get_ai_group_ai( "mortar_team_a" ) );
    array::delete_all( spawner::get_ai_group_ai( "mortar_team_b" ) );
    array::delete_all( spawner::get_ai_group_ai( "mortar_team_e" ) );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xfb62e123, Offset: 0x4de0
// Size: 0x4c
function function_fb965703()
{
    spawner::simple_spawn( "mortar_enemy_landing_4", &function_af189a4c );
    wait 3;
    level flag::set( "start_vign_corner_spry_shoot_01" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xcd8e9fe1, Offset: 0x4e38
// Size: 0x94
function function_ded27710()
{
    level thread function_6dfe5db1();
    level thread function_f2cbcaaa();
    level thread function_81654d37();
    level thread function_d250e19f();
    level thread function_aaf84792();
    level thread function_eb90b3e8();
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x22737aa2, Offset: 0x4ed8
// Size: 0x44
function function_6dfe5db1()
{
    level flag::wait_till( "start_vign_corner_spry_shoot_01" );
    level scene::play( #"aib_t9_vign_tplt_ent_around_corner_l_2_stnd_spray_shoot_01" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xfdd3b22f, Offset: 0x4f28
// Size: 0x2c
function function_f2cbcaaa()
{
    spawner::simple_spawn( "mortar_landing_dth_fall_over_railing_f_01_guy", &function_291146ea );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xe5bd0977, Offset: 0x4f60
// Size: 0xdc
function function_291146ea()
{
    self val::set( #"hash_7766f548c20a2de7", "ignoreme", 1 );
    self.a.nodeath = 1;
    self.skipdeath = 1;
    self waittill( #"death" );
    self scene::play( #"hash_7766f548c20a2de7", "Shot 1", self );
    self val::reset( #"hash_7766f548c20a2de7", "ignoreme" );
    
    if ( isdefined( self ) )
    {
        self startragdoll( 1 );
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x7eddec6, Offset: 0x5048
// Size: 0x5c
function function_aaf84792()
{
    level endon( #"flag_mortar_upper_mortar_building_reached" );
    level flag::wait_till( "vignette_mortar_brks_wndw_1_base_1_flag" );
    spawner::simple_spawn( "mortar_brks_wndw_1_base_1_guy", &function_c25d3a03 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xc6c76f44, Offset: 0x50b0
// Size: 0x84
function function_c25d3a03()
{
    self endon( #"death" );
    self scene::play( #"hash_23d756fc375caf0b", "break_glass", self );
    level waittill( #"flag_mortar_upper_courtyard_reached", #"flag_mortar_upper_mortar_building_reached" );
    self kill();
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x96a0ee60, Offset: 0x5140
// Size: 0x4c
function function_81654d37()
{
    level flag::wait_till( "start_vignette_dth_against_wall_2_stairs" );
    spawner::simple_spawn( "vign_dth_against_wall_2_stairs_guy", &function_c98cbd4e );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xeb28049c, Offset: 0x5198
// Size: 0x134
function function_c98cbd4e()
{
    node = getnode( "vign_dth_against_wall_2_stairs_node", "targetname" );
    self spawner::go_to_node( node );
    waitresult = self waittill( #"damage", #"death" );
    
    if ( isdefined( self ) && isdefined( waitresult.attacker ) && isplayer( waitresult.attacker ) )
    {
        if ( isdefined( waitresult.weapon ) && waitresult.weapon.weapclass != "spread" )
        {
            self.a.nodeath = 1;
            self.var_c681e4c1 = 1;
            self scene::play( #"hash_63e7247bd535ac3", "Shot 2", self );
        }
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x555c798d, Offset: 0x52d8
// Size: 0xf4
function function_d250e19f()
{
    level endon( #"flag_mortar_reached_red_door" );
    level flag::wait_till( "init_vignette_react_surprise_doorway" );
    level scene::init( #"hash_4a1bc491fecb2cc1", "targetname" );
    level flag::wait_till( "flag_reached_tea_house_upper_floor" );
    level scene::add_scene_func( "aib_t9_vign_cust_arm_grp_react_surprise_doorway", &function_e9a58f7a, "done" );
    level flag::wait_till( "start_vignette_react_surprise_doorway" );
    level scene::play( #"hash_4a1bc491fecb2cc1", "targetname" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x34cdacca, Offset: 0x53d8
// Size: 0x19c
function function_e9a58f7a( ents )
{
    level endon( #"flag_mortar_reached_red_door" );
    var_adfb6bb7 = getent( "red_door_defend_vol", "targetname" );
    
    foreach ( ent in ents )
    {
        if ( isalive( ent ) )
        {
            ent thread ai::set_goal_ent( var_adfb6bb7 );
        }
    }
    
    trigger::wait_till( "trigger_mortar_upper_enemy_mortar_building_balcony_fodder" );
    function_1eaaceab( ents );
    a_enemies = array::get_touching( ents, var_adfb6bb7 );
    spawner::simple_spawn_single( "mortar_red_door_defender" );
    
    for ( i = a_enemies.size; i < 1 ; i++ )
    {
        spawner::simple_spawn_single( "mortar_red_door_defender" );
        wait 0.5;
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x1923c33f, Offset: 0x5580
// Size: 0x4c
function function_eb90b3e8()
{
    level flag::wait_till( "vign_cust_arm_engage_2_wall_death_01_flag" );
    spawner::simple_spawn( "vign_cust_arm_engage_2_wall_death_01_guy", &function_6c337113 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xec646e09, Offset: 0x55d8
// Size: 0x74
function function_6c337113()
{
    self.var_c681e4c1 = 1;
    self thread function_e12e064f();
    self scene::play( #"hash_28a87063776ee7d0", "init", self );
    self scene::play( #"hash_28a87063776ee7d0", "loop", self );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x44c0536b, Offset: 0x5658
// Size: 0xf4
function function_e12e064f()
{
    waitresult = self waittill( #"death" );
    
    if ( isdefined( waitresult.attacker ) && isplayer( waitresult.attacker ) && isdefined( waitresult.weapon ) )
    {
        if ( waitresult.weapon.weapclass == "spread" || waitresult.weapon.weapclass == "grenade" )
        {
            self.a.nodeath = 1;
            self.skipdeath = 1;
            self scene::play( #"hash_28a87063776ee7d0", "death", self );
        }
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x89102be0, Offset: 0x5758
// Size: 0x124
function function_dcf0253()
{
    level flag::set( "flag_mortar_start_upper" );
    spawner::simple_spawn( "mortar_upper_spawner_initial", &function_af189a4c );
    level thread function_9f638ce0( "trigger_mortar_right_path", "trigger_mortar_upper_right_path", "flag_mortar_right_path" );
    level thread function_9f638ce0( "trigger_mortar_left_path", "trigger_mortar_upper_left_path", "flag_mortar_left_path" );
    level thread function_de2d35ad();
    level thread function_24462154();
    level thread function_696dc659();
    level thread function_2f56897b();
    function_bea0c0d7( 1 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xe9af321d, Offset: 0x5888
// Size: 0xb4
function function_2f56897b()
{
    level endon( #"flag_mortar_upper_mortar_building_reached" );
    level flag::wait_till( "flag_spawn_mortar_upper_spawner_wave_3" );
    e_volume = getent( "vol_cleanup_mortar_alley", "targetname" );
    var_e8643004 = array::get_touching( level.player getenemies(), e_volume );
    array::run_all( var_e8643004, &kill );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x2c7a0ef7, Offset: 0x5948
// Size: 0x7c
function function_696dc659()
{
    level endon( #"flag_mortar_upper_mortar_building_reached" );
    level flag::wait_till( "flag_mortar_left_path" );
    e_trigger = getent( "mortar_center_alley_spawn_trig", "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger delete();
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 3
// Checksum 0xb192ec17, Offset: 0x59d0
// Size: 0xdc
function function_9f638ce0( str_trigger, var_d1f6ccc2, str_flag )
{
    level flag::wait_till_any( array( "flag_mortar_upper_mortar_building_reached", str_flag ) );
    e_trigger = getent( str_trigger, "targetname" );
    var_5122a7f4 = getent( var_d1f6ccc2, "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger delete();
    }
    
    if ( isdefined( var_5122a7f4 ) )
    {
        var_5122a7f4 delete();
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xe518ba7f, Offset: 0x5ab8
// Size: 0xe4
function function_24462154()
{
    level endon( #"hash_4bed89f9695b49f4", #"flag_mortar_upper_mortar_building_reached" );
    trigger::wait_till( "mg_spawn_go" );
    spawner::simple_spawn( "mortar_enemy_spawner_main_building", &function_6f2bf98c );
    level thread function_6d64338f();
    spawner::waittill_ai_group_ai_count( "mortar_ai_final_building", 5 );
    spawner::simple_spawn( "mortar_upper_spawner_wave_2", &function_6f2bf98c );
    level thread function_cee5e544();
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x1e323f20, Offset: 0x5ba8
// Size: 0x54
function function_6f2bf98c()
{
    self endon( #"death" );
    level flag::wait_till( "flag_mortar_upper_mortar_building_reached" );
    self ai::set_goal( "mortar_tea_house_vol" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x2ab83071, Offset: 0x5c08
// Size: 0xec
function function_cee5e544()
{
    level endon( #"flag_mortar_upper_mortar_building_reached" );
    level.buddy endon( #"death" );
    level flag::wait_till_all( array( "mortar_ai_final_building_cleared", "mortar_ai_wave_2_cleared", "mortar_ai_wave_3_cleared" ) );
    level flag::set( "flag_mortar_courtyard_ai_cleared" );
    level flag::clear( "flag_enable_mortar_courtyard_color_chain" );
    level.buddy colors::color_force_goal( getnode( "nd_mortar_tea_house_exterior", "targetname" ) );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x5de5a68c, Offset: 0x5d00
// Size: 0x12c
function function_6d64338f()
{
    level endon( #"hash_4bed89f9695b49f4" );
    s_waitresult = level flag::wait_till_any( array( "flag_mortar_right_path", "flag_mortar_left_path", "flag_mortar_upper_courtyard_reached", "flag_spawn_mortar_upper_spawner_wave_3" ) );
    
    if ( s_waitresult._notify === "flag_mortar_left_path" )
    {
        str_spawner = "right";
    }
    else
    {
        str_spawner = "left";
    }
    
    spawner::waittill_ai_group_ai_count( "mortar_ai_final_building", 3 );
    spawner::simple_spawn( "mortar_upper_spawner_wave_3_" + str_spawner );
    level flag::wait_till( "mortar_ai_wave_3_" + str_spawner + "_cleared" );
    level flag::set( "mortar_ai_wave_3_cleared" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x34ba9542, Offset: 0x5e38
// Size: 0x8c
function function_287230c8()
{
    self endon( #"death" );
    level flag::wait_till_all( array( "mortar_ai_final_building_cleared", "mortar_ai_wave_2_cleared" ) );
    self.grenadeammo = 0;
    self.health = 25;
    self.goalradius = 500;
    self thread ai::force_goal( level.player );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xf7f14913, Offset: 0x5ed0
// Size: 0x104
function function_de2d35ad()
{
    level endon( #"hash_4bed89f9695b49f4" );
    trigger::wait_till( "mg_spawn_go" );
    var_d93ed883 = getnode( "mortar_alley_turret_node", "targetname" );
    var_1280faf3 = function_1a2a3760( var_d93ed883 );
    var_5deea171 = spawner::simple_spawn_single( "mortar_combat_enemy_spawner_main_turret" );
    
    if ( isdefined( var_5deea171 ) )
    {
        var_5deea171.health *= 2;
        var_5deea171 thread function_250de527();
        var_5deea171 thread function_c7ceddcc();
    }
    
    var_1280faf3 thread function_ce707a4( var_d93ed883 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x464c2d5e, Offset: 0x5fe0
// Size: 0x84
function function_c7ceddcc()
{
    self endon( #"death" );
    self val::set( #"hash_31f9be3fd33c0a82", "ignoreme", 1 );
    wait randomfloatrange( 15, 20 );
    self val::reset( #"hash_31f9be3fd33c0a82", "ignoreme" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x774b1118, Offset: 0x6070
// Size: 0x60
function function_250de527()
{
    self waittill( #"death" );
    level notify( #"hash_443f87164a353a53" );
    wait randomfloatrange( 3, 5 );
    level notify( #"hash_2ddc22588860a7a5" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xcd68edfd, Offset: 0x60d8
// Size: 0x204
function function_ce707a4( var_d93ed883 )
{
    self endon( #"death" );
    self turret::_init_turret();
    self util::make_sentient();
    self setteam( #"axis" );
    self turret::set_on_target_angle( 5 );
    self turret::set_burst_parameters( 1, 2, 0.25, 0.5, 0 );
    self turret::set_target( level.player );
    self val::set( #"mg_turret", "ignoreme", 1 );
    self util::magic_bullet_shield();
    self thread function_7b37dd50( var_d93ed883 );
    level waittill( #"hash_443f87164a353a53" );
    setenablenode( var_d93ed883, 0 );
    s_weapon = struct::get( "mg42_weapon_spawn_loc" );
    var_e77bdd5f = util::spawn_model( s_weapon.model, s_weapon.origin, s_weapon.angles );
    waitframe( 1 );
    self util::stop_magic_bullet_shield();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x7340027f, Offset: 0x62e8
// Size: 0x120
function function_7b37dd50( var_d93ed883 )
{
    level endon( #"hash_443f87164a353a53" );
    self endon( #"death" );
    
    while ( true )
    {
        level function_ad03d12c( 1 );
        level function_ad03d12c( 0 );
        setenablenode( var_d93ed883, 0 );
        
        if ( issentient( self ) )
        {
            self function_60d50ea4();
        }
        
        wait randomintrange( 15, 20 );
        setenablenode( var_d93ed883, 1 );
        
        if ( !issentient( self ) )
        {
            self makesentient();
        }
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xa78da693, Offset: 0x6410
// Size: 0xa4
function function_ad03d12c( b_used )
{
    level endon( #"hash_443f87164a353a53" );
    
    if ( b_used )
    {
        level flag::wait_till( "flag_mortar_mg_turret_in_use" );
        level flag::clear( "flag_mortar_mg_turret_not_in_use" );
        return;
    }
    
    level flag::wait_till( "flag_mortar_mg_turret_not_in_use" );
    level flag::clear( "flag_mortar_mg_turret_in_use" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x80f724d1, Offset: 0x64c0
// Size: 0x4
function function_af189a4c()
{
    
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xc6d056b6, Offset: 0x64d0
// Size: 0x5c
function function_80089cc9()
{
    level thread mortar_objective_upper();
    level flag::wait_till( "obj_flag_mortar_site_a" );
    level objectives::complete( "armada_obj_mortar_orbit_clear_mortar" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xd0ad6b8d, Offset: 0x6538
// Size: 0x470
function mortar_objective_upper()
{
    var_e361d345 = struct::get( "obj_mortar_bunker_door", "targetname" );
    obj_mortar_bunker = struct::get( "obj_mortar_bunker", "targetname" );
    var_83809bc3 = struct::get( "obj_upper_mortar_dossier", "targetname" );
    level objectives::goto( "armada_obj_mortar_goto_red_door", struct::get( "obj_mortar_tea_house_exterior" ).origin, #"hash_56b4845f8e5f7fe6" );
    level objectives::function_67f87f80( "armada_obj_mortar_goto_red_door", undefined, #"hash_51461abc9db00516" );
    level flag::wait_till_any( array( "flag_mortar_upper_mortar_building_reached", "flag_mortar_reached_red_door" ) );
    level objectives::update_position( "armada_obj_mortar_goto_red_door", struct::get( "obj_mortar_tea_house_upper_floor" ).origin );
    level flag::wait_till_any( array( "flag_reached_tea_house_upper_floor", "flag_mortar_reached_red_door" ) );
    level objectives::update_position( "armada_obj_mortar_goto_red_door", var_e361d345.origin );
    var_e361d345 util::create_cursor_hint( undefined, ( 0, 0, 3 ), #"hash_725b894f542049b0" );
    var_e361d345 waittill( #"trigger" );
    level function_315508be();
    var_d1a55518 = getent( "mortar_brush_main_door_closed", "targetname" );
    var_d1a55518 notsolid();
    level objectives::complete( "armada_obj_mortar_goto_red_door" );
    level thread function_110866d();
    level thread function_766af271();
    level.player util::function_749362d7( 1 );
    level waittill( #"hash_e17270abc5bbc3a" );
    level objectives::goto( "armada_obj_mortar_pickup_dossier", var_83809bc3.origin, #"hash_6d35027c1e7e2463" );
    waitframe( 1 );
    var_83809bc3 util::create_cursor_hint( undefined, ( 0, 0, 3 ), #"hash_2830457a70bfc369" );
    var_83809bc3 waittill( #"trigger" );
    objectives::complete( "armada_obj_mortar_pickup_dossier" );
    iprintlnbold( "Objectives Complete" );
    level thread function_a1de7ea2();
    level waittill( #"hash_5084b114ffe7e4aa" );
    level.player util::function_749362d7( 0 );
    level savegame::function_7790f03( 1 );
    level waittill( #"hash_75b0c983ee63db5" );
    function_bea0c0d7( 0 );
    level flag::set( "obj_flag_mortar_site_a" );
    level flag::set( "flag_mortar_site_a_complete" );
    level notify( #"mortar_site_upper_complete" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xafaf5ae1, Offset: 0x69b0
// Size: 0x164
function function_e49e80d4()
{
    level objectives::goto( "armada_obj_board_huey", struct::get( "obj_courtyard_mortar", "targetname" ).origin, #"hash_7287f315f3148647" );
    level objectives::function_67f87f80( "armada_obj_board_huey", undefined, #"hash_328f8e17f92baffd" );
    level flag::wait_till( "flag_obj_mortar_exfil_coutryard" );
    level objectives::update_position( "armada_obj_board_huey", struct::get( "mortar_exfil_chopper_land_loc", "targetname" ).origin );
    level flag::wait_till( "obj_flag_mortar_exfil_location" );
    level objectives::update_position( "armada_obj_board_huey", level.var_7466d419 );
    level flag::wait_till( "obj_flag_mortar_exfil" );
    level objectives::complete( "armada_obj_board_huey" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xb570ea83, Offset: 0x6b20
// Size: 0xdc
function function_110866d( b_init = 0 )
{
    a_ents = [];
    a_ents[ #"player" ] = level.player;
    a_ents[ #"maindoor" ] = getent( "mortar_bunker_door", "targetname" );
    
    if ( b_init )
    {
        level scene::init( #"hash_604c13090504ecb1", a_ents );
        return;
    }
    
    level scene::play( #"hash_604c13090504ecb1", "open_door", a_ents );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xf5832096, Offset: 0x6c08
// Size: 0x8c
function function_766af271()
{
    a_ents = [];
    a_ents[ #"buddy" ] = level.buddy;
    level scene::add_scene_func( #"hash_5705e398ad93ac99", &function_acf5efe5, "play" );
    level scene::play( #"hash_5705e398ad93ac99", a_ents );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x7585ab2b, Offset: 0x6ca0
// Size: 0x84
function function_acf5efe5( a_ents )
{
    var_9958b68 = a_ents[ #"enemy1" ];
    var_89990b71 = a_ents[ #"enemy2" ];
    
    if ( isdefined( var_9958b68 ) )
    {
        var_9958b68 thread function_280849ab();
    }
    
    if ( isdefined( var_89990b71 ) )
    {
        var_89990b71 thread function_280849ab();
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x51d0244b, Offset: 0x6d30
// Size: 0x3c
function function_280849ab()
{
    self endon( #"death" );
    self waittill( #"kill" );
    self notsolid();
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x4179d6a4, Offset: 0x6d78
// Size: 0xe4
function function_bea0c0d7( b_enabled = 0 )
{
    var_bb94c74e = getent( "mortar_brush_exfil_door_closed", "targetname" );
    var_578687cc = getentarray( "mortar_brush_exfil_door_opened", "targetname" );
    
    if ( b_enabled )
    {
        var_bb94c74e solid();
        array::run_all( var_578687cc, &notsolid );
        return;
    }
    
    var_bb94c74e notsolid();
    array::run_all( var_578687cc, &solid );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xa0fafed2, Offset: 0x6e68
// Size: 0x254
function function_a1de7ea2( b_init = 0 )
{
    a_ents = [];
    a_ents[ #"player" ] = level.player;
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"hash_43d8e88908e5b103" ] = getent( "mortar_door_exfil_right", "targetname" );
    a_ents[ #"hash_123dc66ffa6dca8e" ] = getent( "mortar_door_exfil_left", "targetname" );
    
    if ( b_init )
    {
        level scene::add_scene_func( #"hash_7d15d57d22684df", &function_cd1dcfed, "sims_exit" );
        level scene::init( #"hash_7d15d57d22684df", a_ents );
        return;
    }
    
    level thread function_6896ea8a( 1 );
    level scene::stop( #"hash_5705e398ad93ac99" );
    level flag::set( "flag_start_mv_intell_collect_scene" );
    level flag::set( "flag_enable_mortar_exfil_color_chain" );
    level.buddy thread colors::color_force_goal( getnode( "nd_mortar_exfil_stairs", "targetname" ) );
    level thread scene::play( #"hash_7d15d57d22684df", "sims_exit", a_ents );
    level flag::wait_till( "flag_sims_moveto_stairs" );
    level thread function_262e8906();
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x125f8c3a, Offset: 0x70c8
// Size: 0xcc
function function_262e8906()
{
    a_ents = [];
    a_ents[ #"buddy" ] = level.buddy;
    level scene::play( #"hash_7d15d57d22684df", "sims_stairs", a_ents );
    level thread scene::play( #"hash_7d15d57d22684df", "sims_stairs_idle", a_ents );
    level flag::wait_till( "flag_sims_moveto_stairs_cover" );
    waitframe( 1 );
    level scene::stop( #"hash_7d15d57d22684df" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x9bfde382, Offset: 0x71a0
// Size: 0x7c
function function_cd1dcfed( ents )
{
    var_fe4a8480 = ents[ #"dossier" ];
    
    if ( isdefined( var_fe4a8480 ) )
    {
        var_fe4a8480 endon( #"death" );
        level waittill( #"hash_71953685356f645f" );
        var_fe4a8480 hide();
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xc56b3eb4, Offset: 0x7228
// Size: 0x34
function function_6896ea8a( var_43baa908 )
{
    spawner::simple_spawn_single( "aib_t9_vign_cust_arm_run_2_cover_guy", &function_cb65a5e8, var_43baa908 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0x95026414, Offset: 0x7268
// Size: 0xd4
function function_cb65a5e8( var_43baa908 )
{
    self val::set( #"hash_2cb3bfd28a6ec1d8", "ignoreme", 1 );
    self thread scene::play( #"hash_2cb3bfd28a6ec1d8", "Shot 1", self );
    
    if ( var_43baa908 )
    {
        level waittill( #"hash_75b0c983ee63db5" );
    }
    
    self scene::play( #"hash_2cb3bfd28a6ec1d8", "Shot 2", self );
    self val::reset( #"hash_2cb3bfd28a6ec1d8", "ignoreme" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x382f9850, Offset: 0x7348
// Size: 0x44
function function_315508be()
{
    array::run_all( getaiteamarray( #"axis" ), &delete );
}

// Namespace armada_mortar/namespace_e6855491
// Params 2
// Checksum 0xb4d6d385, Offset: 0x7398
// Size: 0x23c
function function_997dda5e( var_d3440450, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        level namespace_b7cfe907::function_6a03d24d( var_d3440450 );
        level function_6b5096fe();
        level.buddy thread colors::set_force_color( "g" );
        level thread function_262e8906();
        level thread function_6896ea8a( 0 );
        level flag::set( "flag_enable_mortar_exfil_color_chain" );
    }
    
    spawner::add_spawn_function_ai_group( "exfil_ambush_ai", &function_d4168442 );
    level thread function_b2b6c923();
    level thread function_e49e80d4();
    level flag::wait_till( "flag_mortar_exfil_fly_finished" );
    function_74f9a690();
    level notify( #"hash_6e24aaaa7d75b611" );
    level flag::set( "flag_mortar_village_complete" );
    transient = savegame::function_6440b06b( #"transient" );
    transient.var_32839ab6 = 1;
    level skipto::function_4e3ab877( var_d3440450, 0 );
    next_obj = "player_controlled_huey_01";
    level skipto::function_51726ac8( [ next_obj ], 0, level.player );
    level.buddy.script_careful = 0;
    level.buddy thread colors::set_force_color( "b" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xedbb933a, Offset: 0x75e0
// Size: 0xb4
function function_b2b6c923()
{
    level.player endon( #"death" );
    level function_2d9dc4d1();
    trigger::wait_till( "trigger_exfil_courtyard_enemies_1" );
    spawner::simple_spawn( "mortar_village_exfil_spawners" );
    level function_58771ad7();
    level function_bd16430c();
    level flag::set( "flag_mortar_exfil_fly_finished" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x3693f176, Offset: 0x76a0
// Size: 0x94
function function_79299255()
{
    level flag::clear( "flag_enable_mortar_exfil_color_chain" );
    self colors::color_force_goal( getnode( "sims_exfil_cover", "targetname" ) );
    self waittill( #"near_goal", #"goal" );
    level flag::set( "flag_village_exfil_sims_in_position" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xdf5dface, Offset: 0x7740
// Size: 0x17c
function function_5822bcf6()
{
    self turret::disable( 3 );
    self turret::disable( 4 );
    self turret::clear_target( 1 );
    self turret::set_ignore_line_of_sight( 1, 1 );
    self turret::function_8bbe7822( 1, 1 );
    self turret::function_bb42e3e2( 1, 1 );
    self turret::set_burst_parameters( 1, 2, 0.25, 0.5, 1 );
    self turret::enable( 1, 0 );
    level waittill( #"hash_2f6eb23c694e3a39" );
    self thread turret::function_41c79ce4( 1, 1 );
    level waittill( #"hash_78f5eb15e6763d58" );
    self turret::disable( 1 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x70eb6e2, Offset: 0x78c8
// Size: 0x18e
function function_7cbced04()
{
    self playsound( "evt_chopper_strafe_flyby" );
    a_ai_targets = arraysortclosest( getaiarray( "strafing_run_target", "script_noteworthy" ), getvehiclenode( "path_exfil_flyby", "targetname" ).origin );
    wait 0.5;
    self turret::enable( 3, 0 );
    self turret::enable( 4, 0 );
    self thread function_be014f32();
    
    foreach ( ai in a_ai_targets )
    {
        if ( isalive( ai ) )
        {
            self function_76be1d54( ai );
        }
    }
    
    self notify( #"hash_254e7fb941cc8d9d" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xef22937a, Offset: 0x7a60
// Size: 0x13c
function function_76be1d54( ai )
{
    var_9012c9b0 = getweapon( #"hash_73d955d55fddba26" );
    var_aa6dfaf6 = ai gettagorigin( "tag_eye" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        var_1c8839e = self gettagorigin( "tag_gunner_flash1" );
        playfxontag( #"hash_6d6d720fe18d9609", self, "tag_gunner_flash1" );
        magicbullet( var_9012c9b0, var_1c8839e, var_aa6dfaf6 );
        wait 0.05;
        magicbullet( var_9012c9b0, var_1c8839e, var_aa6dfaf6 );
        wait 0.1;
    }
    
    if ( isalive( ai ) )
    {
        ai kill();
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x6ddc7f8e, Offset: 0x7ba8
// Size: 0x9c
function function_be014f32()
{
    self playsound( "wpn_strafe_fire_start_npc" );
    self playloopsound( "wpn_strafe_fire_loop_npc" );
    self waittill( #"hash_254e7fb941cc8d9d" );
    wait 0.5;
    self playsound( "wpn_strafe_fire_stop_npc" );
    self stoploopsound( 1 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xd8dc8a1b, Offset: 0x7c50
// Size: 0x51c
function function_58771ad7()
{
    level notify( #"hash_78f5eb15e6763d58" );
    s_exfil = struct::get( "tag_align_mortar_exfil" );
    
    if ( isdefined( level.copilot ) )
    {
        level.copilot util::stop_magic_bullet_shield();
        level.copilot delete();
    }
    
    a_ents = [];
    a_ents[ #"pilot" ] = level.pilot;
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    a_ents[ #"player" ] = level.player;
    a_ents[ #"vip" ] = level.vip;
    a_ents[ #"gunner" ] = level.gunner;
    level flag::wait_till( #"exfil_flyby_go" );
    level.var_7466d419 makevehicleunusable();
    level namespace_b7cfe907::function_3af72756( level.var_7466d419, level.pilot, "driver" );
    level namespace_b7cfe907::function_3af72756( level.var_7466d419, level.vip, "crew" );
    level namespace_b7cfe907::function_3af72756( level.var_7466d419, level.gunner, "gunner1" );
    level.var_7466d419 thread function_7cbced04();
    level scene::play( #"hash_3ed153e5b694beab", "arrival", a_ents );
    level thread scene::play( #"hash_3ed153e5b694beab", "Hover", a_ents );
    level.var_7466d419 thread function_5822bcf6();
    level flag::set( "obj_flag_mortar_exfil_location" );
    level thread function_c09e7d39();
    level notify( #"hash_2f6eb23c694e3a39" );
    level.buddy thread function_79299255();
    namespace_72b0499b::music( "deactivate_tmp_mortar_village" );
    level notify( #"hash_403102f73a6c07f0" );
    level scene::play( #"hash_3ed153e5b694beab", "in", a_ents );
    level thread scene::play( #"hash_3ed153e5b694beab", "loop", a_ents );
    trigger::wait_till( "trigger_armada_exfil" );
    level flag::set( "obj_flag_mortar_exfil" );
    level scene::play( #"hash_3ed153e5b694beab", "out", a_ents );
    level thread vehicle::get_in( level.pilot, level.var_7466d419, "driver" );
    level thread vehicle::get_in( level.vip, level.var_7466d419, "crew" );
    level thread vehicle::get_in( level.buddy, level.var_7466d419, "crew" );
    level thread vehicle::get_in( level.gunner, level.var_7466d419, "gunner1" );
    level.var_7466d419 thread turret::disable( 1 );
    level.var_7466d419 thread turret::disable( 2 );
    level.var_7466d419 thread turret::disable( 3 );
    level.var_7466d419 thread turret::disable( 4 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x97f56ae0, Offset: 0x8178
// Size: 0xa6
function function_c09e7d39()
{
    foreach ( ai in spawner::get_ai_group_ai( "mortar_village_exfil" ) )
    {
        if ( isalive( ai ) )
        {
            ai.health = 25;
        }
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x970c37e2, Offset: 0x8228
// Size: 0x7c
function function_74f9a690()
{
    a_ents = [];
    a_ents[ #"player" ] = level.player;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level.var_7466d419 scene::play( #"hash_6ac8cd7e179894f6", a_ents );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x6df5d675, Offset: 0x82b0
// Size: 0xd4
function function_bd16430c()
{
    s_start = struct::get( "mortar_exfil_flyto" );
    level.var_7466d419 vehicle::script_resume_speed( "setspeed", 50 );
    level namespace_b7cfe907::function_d777fe61( 2 );
    level.var_7466d419 function_536cff7e( s_start, 50 );
    level.var_7466d419.origin = s_start.origin;
    level.var_7466d419.angles = s_start.angles;
    util::stop_magic_bullet_shield( level.var_7466d419 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xe83662f4, Offset: 0x8390
// Size: 0xe8
function function_6021f20f()
{
    thread function_d1db0694( 0.19 );
    var_8dfae36b = getent( "mortar_exfil_jet_01", "targetname" );
    jet_01 = var_8dfae36b spawnfromspawner();
    jet_01 thread vehicle::go_path();
    wait 0.75;
    jet_02 = var_8dfae36b spawnfromspawner();
    jet_02 thread vehicle::go_path();
    level waittill( #"hash_4c3fc37cb129bc5a" );
    level notify( #"hash_c71650e58a494b9" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xd769e59a, Offset: 0x8480
// Size: 0x134
function function_d1db0694( timer )
{
    wait timer;
    thread exploder::exploder( "mortar_building_explosions_from_upper" );
    level.player playrumbleonentity( "damage_heavy" );
    wait 0.1;
    level.player playrumbleonentity( "damage_heavy" );
    wait 0.1;
    level.player playrumbleonentity( "damage_heavy" );
    level notify( #"hash_58cbd171da71efd6" );
    wait 10.1;
    thread exploder::exploder( "mortar_building_explosions_from_upper_1" );
    wait 1.25;
    thread exploder::exploder( "mortar_building_explosions_from_upper_2" );
    wait 0.45;
    thread exploder::exploder( "mortar_building_explosions_from_upper_4" );
    level flag::set( "flag_vo_mortar_village_exfil_explosion" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xcff90dfe, Offset: 0x85c0
// Size: 0x8c
function function_d4168442()
{
    self endon( #"death" );
    self val::set( "exfil_ambush", "ignoreme", 1 );
    self setentitytarget( level.player );
    wait 3;
    self val::reset( "exfil_ambush", "ignoreme" );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xeb228a8b, Offset: 0x8658
// Size: 0x72c
function function_6b5096fe()
{
    if ( !isdefined( level.var_52874eb2 ) )
    {
        level.var_52874eb2 = vehicle::simple_spawn_single( "spawner_heli_adler" );
        level.var_52874eb2 thread namespace_b7cfe907::function_9ac0bc90( [ 0 ] );
        
        if ( !isdefined( level.gunner ) )
        {
            namespace_b7cfe907::function_166083c9( 0, undefined, 1 );
        }
        
        if ( isdefined( level.gunner ) )
        {
            vehicle::get_in( level.gunner, level.var_52874eb2, "gunner1", 1 );
        }
        
        if ( !isdefined( level.vip ) )
        {
            namespace_b7cfe907::function_882e6973( 0, undefined, 1 );
        }
        
        if ( isdefined( level.vip ) )
        {
            level.var_52874eb2 flag::set( "crew1_occupied" );
            vehicle::get_in( level.vip, level.var_52874eb2, "crew", 1 );
        }
        
        level.var_52874eb2 turret::_init_turret( 1 );
        level.var_52874eb2 turret::_init_turret( 2 );
        level.var_52874eb2 turret::_init_turret( 3 );
        level.var_52874eb2 turret::_init_turret( 4 );
        level.var_52874eb2 turret::set_team( #"allies", 1 );
        level.var_52874eb2 turret::set_team( #"allies", 2 );
        level.var_52874eb2 turret::set_team( #"allies", 3 );
        level.var_52874eb2 turret::set_team( #"allies", 4 );
        level.var_52874eb2 turret::set_burst_parameters( 1, 2, 0.25, 0.5, 1 );
        level.var_52874eb2 turret::set_burst_parameters( 1, 2, 0.25, 0.5, 2 );
        level.var_52874eb2 turret::set_burst_parameters( 1, 2, 0.25, 0.5, 3 );
        level.var_52874eb2 turret::set_burst_parameters( 1, 2, 0.25, 0.5, 4 );
        level.var_52874eb2 turret::set_torso_targetting( 1, -12 );
        level.var_52874eb2 turret::set_torso_targetting( 2, -12 );
        level.var_52874eb2 turret::set_torso_targetting( 3, -12 );
        level.var_52874eb2 turret::set_torso_targetting( 4, -12 );
        level.var_52874eb2 turret::set_target_leading( 1, 0.1 );
        level.var_52874eb2 turret::set_target_leading( 2, 0.1 );
        level.var_52874eb2 turret::set_target_leading( 3, 0.1 );
        level.var_52874eb2 turret::set_target_leading( 4, 0.1 );
    }
    
    level.var_52874eb2 setteam( #"allies" );
    util::magic_bullet_shield( level.var_52874eb2 );
    level.var_52874eb2 setvehicletype( #"hash_308369147254321b" );
    level.var_52874eb2.drivepath = 1;
    level.var_52874eb2.var_54b19f55 = 1;
    params = spawnstruct();
    params.no_clear_movement = 1;
    params.var_a22ee662 = 1;
    level.var_52874eb2.soundmod = "heli";
    level.var_52874eb2 vehicle_ai::set_state( "scripted", params );
    level.var_52874eb2 vehicle::toggle_sounds( 1 );
    level.var_52874eb2 setrotorspeed( 1 );
    level.var_52874eb2 cleartargetyaw();
    level.var_52874eb2 cleargoalyaw();
    level.var_52874eb2 setyawspeed( 20, 20, 20 );
    level.var_52874eb2 setmaxpitchroll( 60, 60 );
    level.var_52874eb2.var_cb55c804 = 256;
    level.var_52874eb2 setneargoalnotifydist( level.var_52874eb2.var_cb55c804 );
    level.var_52874eb2 turret::disable( 1 );
    level.var_52874eb2 turret::disable( 2 );
    level.var_52874eb2 turret::disable( 3 );
    level.var_52874eb2 turret::disable( 4 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x761048ec, Offset: 0x8d90
// Size: 0x15c
function function_2d9dc4d1()
{
    if ( isdefined( level.var_7466d419 ) )
    {
        level.var_7466d419 delete();
    }
    
    level.var_7466d419 = level.var_52874eb2;
    
    if ( is_true( level.var_7466d419.var_2295c5e7 ) )
    {
        level.var_7466d419 namespace_b7cfe907::function_5677b6eb();
    }
    
    level.var_7466d419 cleartargetyaw();
    level.var_7466d419 cleargoalyaw();
    level.var_7466d419 setyawspeed( 40, 20, 20 );
    level.var_7466d419 setmaxpitchroll( 10, 30 );
    level namespace_b7cfe907::function_882e6973( 1 );
    level namespace_b7cfe907::function_14a42357( 1 );
    level namespace_b7cfe907::function_166083c9( 1 );
    level namespace_b7cfe907::function_37fc8bb();
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x23fe230f, Offset: 0x8ef8
// Size: 0xd4
function function_ba10e034()
{
    self endon( #"death" );
    self waittill( #"hash_2717c5ec282f117c" );
    self turret::set_burst_parameters( 1, 2, 0.25, 0.5, 1 );
    self turret::set_torso_targetting( 1, -12 );
    self turret::set_target_leading( 1, 0.1 );
    self turret::enable( 1, 0 );
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0x20ce730f, Offset: 0x8fd8
// Size: 0x5c
function function_285ff4e4()
{
    for ( i = 0; i < 5 ; i++ )
    {
        spawner::simple_spawn_single( "sp_vh_pch_convoy_01", &function_13d13395, i );
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 1
// Checksum 0xd563393e, Offset: 0x9040
// Size: 0x11c
function function_13d13395( n_index )
{
    self endon( #"death" );
    self setteam( #"axis" );
    self callback::function_d8abfc3d( #"on_vehicle_killed", &namespace_722cc932::function_edf88bbb );
    var_8be533d2 = "nd_pch_convoy_01_0" + n_index + 1;
    nd_path = getvehiclenode( var_8be533d2, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_path );
    level flag::wait_till( "flag_mortar_orbit_site_b_enemies_spawn" );
    wait 5;
    self vehicle::detach_path();
    self deletedelay();
}

// Namespace armada_mortar/namespace_e6855491
// Params 7
// Checksum 0x7a13fd09, Offset: 0x9168
// Size: 0x10a
function function_1df2273d( *destructible_event, *attacker, *weapon, *piece_index, *point, *dir, *mod )
{
    if ( !isdefined( self.script_noteworthy ) )
    {
        return;
    }
    
    switch ( self.script_noteworthy )
    {
        case #"hash_6a47a6100e2db1d2":
            level scene::play( #"hash_253ecfc6e16559a" );
            break;
        case #"hash_6a47a5100e2db01f":
            level scene::play( #"hash_276fd471a23c44bd" );
            break;
        case #"hash_6a47a4100e2dae6c":
            level scene::play( #"hash_4b085675c2abcac4" );
            break;
    }
}

// Namespace armada_mortar/namespace_e6855491
// Params 0
// Checksum 0xded75cc8, Offset: 0x9280
// Size: 0x7c
function function_a3d29239()
{
    for ( i = 1; i <= 3 ; i++ )
    {
        str_scene = "p9_fxanim_cp_armada_town_rooves_0" + i + "_bundle";
        
        if ( !level scene::is_playing( str_scene ) )
        {
            level scene::stop( str_scene );
        }
    }
}

