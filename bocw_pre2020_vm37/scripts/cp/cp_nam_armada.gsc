#using script_13209888df6eddf6;
#using script_1bc87bb1cbccfd6e;
#using script_25b0725f0d26dbf5;
#using script_25e5dde7b6917cfc;
#using script_32ff16d71b77016b;
#using script_3711e526ec2a3863;
#using script_3de47beee8436774;
#using script_47d08d7129406c5a;
#using script_4937c6974f43bb71;
#using script_5093e69067abcf4d;
#using script_701ab3cbf9eb8c3a;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_nam_armada_fx;
#using scripts\cp_common\ammo_resupply_crate;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\weapon_utils;

#namespace namespace_722cc932;

// Namespace namespace_722cc932/level_init
// Params 1, eflags: 0x40
// Checksum 0xa15ce25, Offset: 0x2160
// Size: 0x274
function event_handler[level_init] main( *eventstruct )
{
    level.destructible_callbacks[ #"destructible_explosive_incendiary_large" ] = &armada_mortar::function_1df2273d;
    clientfield::register( "toplayer", "ease_to_dialog_dof", 1, 1, "int" );
    clientfield::register( "toplayer", "lerp_fov", 1, 3, "int" );
    clientfield::register( "vehicle", "adler_chopper_mortar_village", 1, 1, "int" );
    clientfield::register( "world", "toggle_gameplay_character_visibility", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_script_vignette", 1, 2, "int" );
    namespace_9a981837::function_c44464c8();
    function_37dfd679();
    load::main();
    function_24de65ef();
    level thread namespace_a64c0f5b::main();
    level flag::clear( "stealth_enabled" );
    level.var_9c4a751d = 1;
    level.var_9317da1b = 1;
    setdvar( #"compassmaxrange", "2100" );
    setdvar( #"vehicle_switch_seat_delay", 36000000 );
    level thread namespace_9a981837::init_fx();
    level thread namespace_72b0499b::init_audio();
    function_22b7fffd();
    init_callbacks();
    
    /#
        level thread _setup_devgui();
    #/
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x867ed5f8, Offset: 0x23e0
// Size: 0x494
function function_37dfd679()
{
    skipto::function_eb91535d( "armada_intro", &namespace_e871b49a::intro_flow, &function_fb3e29d5, "Intro", &function_6e6c4f85 );
    skipto::add( "armada_flyin", &namespace_e871b49a::function_50d6beb5, &function_cf7ffedf, "Fly in", &function_6e6c4f85 );
    skipto::function_eb91535d( "armada_mortar_orbit", &armada_mortar::function_6ad1ac64, &function_9d4b09a, "Mortar - Orbit", &function_6e6c4f85 );
    skipto::function_eb91535d( "armada_mortar_start", &armada_mortar::function_94a21d8b, &function_5109008, "Mortar Village", &function_6e6c4f85 );
    skipto::function_eb91535d( "armada_mortar_exfil", &armada_mortar::function_997dda5e, &function_dfc4bc30, "Mortar Village Exfil", &function_6e6c4f85 );
    level.var_53bb8ef2 = spawnstruct();
    level.var_1f372b50 = spawnstruct();
    level.var_9051f4a3 = spawnstruct();
    level.var_539110f3 = spawnstruct();
    skipto::function_eb91535d( "player_controlled_huey_01", &function_5854aa8c, &function_64cad509, "Player Controlled Huey 01", &function_d6bbe091 );
    skipto::function_eb91535d( "player_controlled_huey_02", &function_f137e067, &function_d3e80e12, "Player Controlled Huey 02", &function_b839a88b );
    skipto::function_eb91535d( "defend_firebase_ripcord", &function_dc1d0dfb, &function_46c0f651, "Defend Firebase Ripcord", &function_d623578b );
    skipto::function_eb91535d( "secure_the_nuke", &function_2870229e, &function_47cfc791, "Secure The Nuke", &function_2ea27496 );
    skipto::function_eb91535d( "armada_crash_start", &armada_crash::function_945def6e, &function_860b1ca0, "Crash Start", &armada_crash::function_9eecfef5 );
    skipto::function_eb91535d( "armada_crash_part_1_gunner", &armada_crash::function_58ef8b05, &function_c1a2b1dd, "Crash - Gunner", &armada_crash::function_398bee81 );
    skipto::function_eb91535d( "armada_crash_part_4_laststand", &armada_crash::function_cd3c6f53, &function_df03d4dc, "Crash - Last Stand", &function_6e6c4f85 );
    skipto::function_46d8992a( "armada_intro" );
    
    /#
        skipto::add_dev( "<dev string:x38>", &function_c03bb520 );
        skipto::add_dev( "<dev string:x49>", &function_1061456b );
    #/
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x8f82caa0, Offset: 0x2880
// Size: 0x21c
function function_24de65ef()
{
    transient = savegame::function_6440b06b( #"transient" );
    var_aeeeaf96 = transient.var_bb451151;
    var_f241a404 = transient.var_8ffe00b6;
    var_e7679856 = transient.var_32839ab6;
    
    if ( isdefined( var_aeeeaf96 ) )
    {
        if ( var_aeeeaf96 )
        {
            flag::set( "flag_fly_to_branch_dialog_chose_mortar" );
        }
        else
        {
            flag::set( "flag_fly_to_branch_dialog_chose_bamboo" );
        }
    }
    
    while ( !isdefined( level.var_28c22d88 ) || level.var_28c22d88.size == 0 )
    {
        wait 0.05;
    }
    
    if ( array::contains( level.var_28c22d88, "armada_intro" ) )
    {
        return;
    }
    
    flag::set( "flag_intro_wave_take_off" );
    
    if ( array::contains( level.var_28c22d88, "armada_flyin" ) )
    {
        return;
    }
    
    if ( array::contains( level.var_28c22d88, "armada_flyin_beach" ) )
    {
        return;
    }
    
    if ( array::contains( level.var_28c22d88, "armada_mortar_orbit" ) )
    {
        return;
    }
    
    if ( array::contains( level.var_28c22d88, "armada_mortar_start" ) || array::contains( level.var_28c22d88, "armada_mortar_exfil" ) )
    {
        flag::set( "flag_mortar_orbit_complete" );
        flag::set( "flag_mortar_orbit_rappel_start" );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x4aebcb6f, Offset: 0x2bd0
// Size: 0x24
function function_ade9b040( var_d3440450 )
{
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0xe3c6e896, Offset: 0x2c00
// Size: 0x24
function function_6e6c4f85( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x7eed2b79, Offset: 0x2c30
// Size: 0x17c
function function_fb3e29d5( var_d3440450 )
{
    level.var_cb4dca51 = 4.3;
    level.var_c0c469ea = 1.5;
    level namespace_b7cfe907::function_6a03d24d( var_d3440450 );
    level flag::wait_till_all( [ "flag_armada_player_chopper_spawned", "flag_armada_vip_spawned", "flag_armada_buddy_spawned", "flag_armada_copilot_spawned", "flag_armada_pilot_spawned" ] );
    level.var_7466d419 setrotorspeed( 0.2 );
    level.player util::function_749362d7( 1 );
    level.player val::set( "armada_intro", "allow_crouch", 0 );
    level.player val::set( "armada_intro", "allow_prone", 0 );
    level.player thread namespace_b7cfe907::function_4b13f5b3( "flag_intro_adler_walk_talk_pos_1" );
    level namespace_82bfe441::fade( 1, "FadeImmediate" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x55ae0a21, Offset: 0x2db8
// Size: 0x14c
function function_cf7ffedf( var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    level namespace_b7cfe907::function_6a03d24d( var_d3440450 );
    level flag::wait_till_all( [ "flag_armada_player_chopper_spawned", "flag_armada_vip_spawned", "flag_armada_buddy_spawned", "flag_armada_copilot_spawned", "flag_armada_pilot_spawned" ] );
    level.player util::function_749362d7( 1 );
    level.player val::set( "armada_intro", "allow_crouch", 0 );
    level.player val::set( "armada_intro", "allow_prone", 0 );
    level.player thread namespace_b7cfe907::function_4b13f5b3();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x9d4dc942, Offset: 0x2f10
// Size: 0x84
function function_9c328bac( var_d3440450 )
{
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
    level flag::set( "flag_player_chopper_screenshake_active" );
    var_a129a5ee = getent( "trigger_oob_firebase_to_branch", "targetname" );
    var_a129a5ee triggerenable( 0 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x62f86dee, Offset: 0x2fa0
// Size: 0x12c
function function_62105860( var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
    thread namespace_e871b49a::function_d97a8605();
    level flag::set( "flag_player_chopper_screenshake_active" );
    level flag::set( "flag_firebase_base_intro_exploders" );
    level flag::set( "flag_firebase_base_enemy_trucks_start" );
    level flag::set( "flag_firebase_enemy_cliff_start" );
    var_a129a5ee = getent( "trigger_oob_firebase_to_branch", "targetname" );
    var_a129a5ee triggerenable( 0 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x6d5a5d14, Offset: 0x30d8
// Size: 0x84
function function_55dc2a68( var_d3440450 )
{
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
    level flag::set( "flag_player_chopper_screenshake_active" );
    var_a129a5ee = getent( "trigger_oob_firebase_to_branch", "targetname" );
    var_a129a5ee triggerenable( 0 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x403efb73, Offset: 0x3168
// Size: 0x44
function function_6b6544ba( var_d3440450 )
{
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
    level flag::set( "flag_vo_firebase_arrival_stabilize_complete" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x80a41ff4, Offset: 0x31b8
// Size: 0x24
function function_ce0ab1c0( var_d3440450 )
{
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xb31edf38, Offset: 0x31e8
// Size: 0x8c
function function_9d4b09a( *var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    level thread armada_mortar::function_110866d( 1 );
    armada_mortar::function_bea0c0d7( 0 );
    flag::set( "flag_mortar_arrival_scene_complete" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xadb02d8d, Offset: 0x3280
// Size: 0xdc
function function_5109008( *var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    level thread armada_mortar::function_110866d( 1 );
    armada_mortar::function_bea0c0d7( 1 );
    level flag::set( "flag_vo_mortar_arrival_orbit_complete" );
    flag::set( "mortar_team_a_hit" );
    flag::set( "mortar_team_b_hit" );
    flag::set( "mortar_team_e_hit" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x4f1481a5, Offset: 0x3368
// Size: 0x9c
function function_dfc4bc30( *var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    namespace_72b0499b::music( "tmp_mortar_village" );
    level.var_da566d53 = "upper_village";
    flag::set( "flag_bamboo_end_end" );
    flag::set( "armada_bamboo_end_completed" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xd1f523a6, Offset: 0x3410
// Size: 0x5c
function function_860b1ca0( var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x4cbccce, Offset: 0x3478
// Size: 0xac
function function_c1a2b1dd( var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    level armada_crash::function_7b315e60();
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
    
    while ( !isdefined( level.player ) )
    {
        waitframe( 1 );
    }
    
    namespace_82bfe441::fade( 1, "FadeImmediate" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x74fe09c1, Offset: 0x3530
// Size: 0x7c
function function_df03d4dc( var_d3440450 )
{
    namespace_82bfe441::fade( 1, "FadeFast" );
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    namespace_b7cfe907::function_6a03d24d( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x2f61e360, Offset: 0x35b8
// Size: 0x204
function function_22b7fffd()
{
    animation::add_notetrack_func( "armada_util::chopper_force_start_engine", &namespace_b7cfe907::function_53c06d6e );
    animation::add_notetrack_func( "SetRotorSpeed", &namespace_b7cfe907::function_388cae02 );
    animation::add_notetrack_func( "spawn_crew", &namespace_b7cfe907::function_9ac0bc90 );
    animation::add_notetrack_func( "spawn_boat_crew", &namespace_b7cfe907::function_80a8e837 );
    animation::add_notetrack_func( "despawn_crew_and_delete_self", &namespace_b7cfe907::function_a7574a48 );
    animation::add_notetrack_func( "despawn_crew", &namespace_b7cfe907::function_5677b6eb );
    animation::add_notetrack_func( "screenshake", &namespace_b7cfe907::function_ed1b0fb );
    animation::add_notetrack_func( "armada_fx::my_hide_viewmodel", &namespace_9a981837::function_fcea30b4 );
    animation::add_notetrack_func( "armada_fx::auto_dof_call", &namespace_9a981837::function_a9a0debb );
    animation::add_notetrack_func( "swap_hat_model", &namespace_b7cfe907::swap_hat_model );
    scene::add_scene_func( #"armada_intro", &namespace_e871b49a::function_70c35833, "init" );
    scene::add_scene_func( #"hash_30c1ba04c9ba0bf3", &armada_crash::smoke_signal, "outro" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x717ca1c8, Offset: 0x37c8
// Size: 0x44
function init_callbacks()
{
    callback::on_spawned( &function_56b5efa8 );
    callback::on_player_killed( &function_91c1bb33 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xc48914d6, Offset: 0x3818
// Size: 0x94
function function_56b5efa8()
{
    level.player = getplayers()[ 0 ];
    thread namespace_9a981837::function_7e002ff8();
    level thread namespace_9a981837::intro_dof();
    level.killstreaksenabled = 0;
    namespace_b7cfe907::function_9ebb66cb();
    level clientfield::set( "toggle_gameplay_character_visibility", 1 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x433da036, Offset: 0x38b8
// Size: 0xfc
function function_91c1bb33( *params )
{
    if ( isdefined( level.var_d42e271a ) )
    {
        level.var_d42e271a delete();
    }
    
    if ( isdefined( level.pilot ) )
    {
        level.pilot util::stop_magic_bullet_shield();
    }
    
    if ( isdefined( level.copilot ) )
    {
        level.copilot util::stop_magic_bullet_shield();
    }
    
    if ( isdefined( level.vip ) )
    {
        level.vip util::stop_magic_bullet_shield();
    }
    
    if ( isdefined( level.gunner ) )
    {
        level.gunner util::stop_magic_bullet_shield();
    }
    
    if ( isdefined( level.buddy ) )
    {
        level.buddy util::stop_magic_bullet_shield();
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x3e173a39, Offset: 0x39c0
// Size: 0x364
function function_a291d0f( var_d3440450, var_50cc0d4f )
{
    if ( level flag::get( #"hash_22a3c9d4c3c49987" ) )
    {
        return;
    }
    
    level flag::set( #"hash_22a3c9d4c3c49987" );
    
    if ( var_50cc0d4f )
    {
        switch ( var_d3440450 )
        {
            case #"player_controlled_huey_01":
                str_script_noteworthy = #"hash_44b941c1984f5dc6";
                break;
            case #"player_controlled_huey_02":
                str_script_noteworthy = #"hash_651a32ffba7e27b4";
                break;
            case #"defend_firebase_ripcord":
                str_script_noteworthy = #"hash_1668bd06b3baa8e2";
                break;
            case #"secure_the_nuke":
                str_script_noteworthy = #"hash_8f14f3cf9fd498a";
                break;
        }
        
        namespace_b7cfe907::function_27e76b4c( str_script_noteworthy, 0 );
        level thread namespace_b7cfe907::function_d5d40694();
        level thread namespace_b7cfe907::function_ed68628c( 1 );
        level thread namespace_b7cfe907::function_882e6973( 1 );
    }
    else
    {
        namespace_b7cfe907::function_d777fe61( 0 );
    }
    
    var_53bb8ef2 = level.var_53bb8ef2;
    var_53bb8ef2.var_78bd98cb = level.var_7466d419;
    var_53bb8ef2.var_cfa81957 = 2000;
    var_53bb8ef2.var_9df3157 = 0;
    var_53bb8ef2.var_78bd98cb turret::disable( 1 );
    var_53bb8ef2.var_78bd98cb turret::disable( 2 );
    var_53bb8ef2.var_57a6f59c = util::spawn_model( #"tag_origin" );
    var_53bb8ef2.var_78bd98cb.overridevehicledamage = &function_802c8975;
    level.overrideplayerdamage = &function_8b077075;
    level thread function_9be6ef5f();
    var_53bb8ef2.var_df6d4579 = getweapon( #"hash_1b226dddac770884" );
    level.var_9c483e1 = &function_cb853b3d;
    vehicle::add_spawn_function_by_type( #"hash_2bf574cefe3e6d9e", &function_f994e739, "tag_body" );
    vehicle::add_spawn_function_by_type( #"hash_4420cded39673048", &function_f994e739 );
    helicopter::function_2b057725();
    level.player setsunshadowsplitdistance( 10000 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 15
// Checksum 0xe07ace0f, Offset: 0x3d30
// Size: 0x2e8
function function_802c8975( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, *vpoint, *vdir, shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal )
{
    /#
        if ( getdvarint( #"hash_3b90a67ea0b6081b", 0 ) >= 2 || isgodmode( level.player ) )
        {
            return 0;
        }
    #/
    
    var_53bb8ef2 = level.var_53bb8ef2;
    
    if ( is_true( var_53bb8ef2.var_4ec7cb08 ) || !isdefined( vdamageorigin ) || !isdefined( partname ) || vdamageorigin util::is_on_side( self.team ) )
    {
        return 0;
    }
    
    var_d5788a84 = 0;
    var_83af05db = 0;
    
    if ( isdefined( modelindex ) )
    {
        if ( modelindex == "MOD_PROJECTILE" )
        {
            var_d5788a84 = 1;
        }
        else if ( is_true( var_53bb8ef2.var_b0bffa0a ) )
        {
            return 0;
        }
        else
        {
            var_53bb8ef2.var_b0bffa0a = 1;
            level thread function_902ac76();
            
            if ( !is_true( var_53bb8ef2.var_cafcae4c ) )
            {
                var_d5788a84 = 1;
                var_53bb8ef2.var_cafcae4c = 1;
                level thread function_1eaf3800();
            }
            else
            {
                earthquake( 0.15, 0.15, level.player.origin, 5000 );
            }
        }
    }
    
    var_53bb8ef2.var_cfa81957 -= psoffsettime;
    
    if ( var_53bb8ef2.var_cfa81957 <= 0 )
    {
        var_53bb8ef2.var_4ec7cb08 = 1;
        self thread function_ff36634b();
    }
    else
    {
        self thread function_8feeb0be();
    }
    
    if ( var_d5788a84 > 0 )
    {
        level.player dodamage( var_d5788a84, vdamageorigin.origin, var_53bb8ef2.var_57a6f59c, shitloc, vsurfacenormal, modelindex, damagefromunderneath, partname );
    }
    
    return var_83af05db;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 11
// Checksum 0x1cee5243, Offset: 0x4020
// Size: 0x94
function function_8b077075( *einflictor, eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex )
{
    if ( isdefined( psoffsettime ) && psoffsettime != level.var_53bb8ef2.var_57a6f59c )
    {
        return 0;
    }
    
    self.health++;
    return boneindex;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x26dae905, Offset: 0x40c0
// Size: 0x2e
function function_902ac76()
{
    wait 0.25;
    
    if ( isdefined( level.var_53bb8ef2 ) )
    {
        level.var_53bb8ef2.var_b0bffa0a = 0;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xdc7c1528, Offset: 0x40f8
// Size: 0x2a
function function_1eaf3800()
{
    wait 2;
    
    if ( isdefined( level.var_53bb8ef2 ) )
    {
        level.var_53bb8ef2.var_cafcae4c = 0;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x89316cf5, Offset: 0x4130
// Size: 0x170
function function_8feeb0be()
{
    self notify( "6ed9a37ec5d87d43" );
    self endon( "6ed9a37ec5d87d43" );
    self endon( #"death", #"hash_455ac689d741c96b" );
    self function_e7152de8();
    wait 5;
    var_53bb8ef2 = level.var_53bb8ef2;
    var_c62824cc = var_53bb8ef2.var_cfa81957;
    
    if ( var_c62824cc >= 2000 )
    {
        return;
    }
    
    var_61dc66d2 = 5 * ( 1 - var_c62824cc / 2000 );
    var_8fc81e63 = gettime();
    
    while ( true )
    {
        n_time_passed = float( gettime() - var_8fc81e63 ) / 1000;
        n_percent = min( 1, n_time_passed / var_61dc66d2 );
        var_53bb8ef2.var_cfa81957 = lerpfloat( var_c62824cc, 2000, n_percent );
        self function_e7152de8();
        
        if ( n_percent >= 1 )
        {
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xcd580f85, Offset: 0x42a8
// Size: 0x104
function function_e7152de8()
{
    var_53bb8ef2 = level.var_53bb8ef2;
    var_4cd42d59 = 0;
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( var_53bb8ef2.var_cfa81957 <= 2000 - 500 * i )
        {
            var_4cd42d59 = i;
        }
    }
    
    if ( var_4cd42d59 > 0 && var_53bb8ef2.var_9df3157 != var_4cd42d59 )
    {
        level flag::set( #"hash_586bf214c79238e2" );
        self vehicle::set_damage_fx_level( var_4cd42d59 );
        var_53bb8ef2.var_9df3157 = var_4cd42d59;
        
        /#
            iprintlnbold( "<dev string:x65>" + var_4cd42d59 );
        #/
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x2a846fd2, Offset: 0x43b8
// Size: 0x18c
function function_ff36634b()
{
    self endon( #"death" );
    earthquake( 0.5, 1, self.origin, 5000 );
    self notify( #"hash_455ac689d741c96b" );
    self thread namespace_c8fb02a7::function_2a0f9c3c();
    level thread helicopter::function_437dfc97();
    
    if ( isalive( level.player ) )
    {
        level.player.var_f5ebfda9 = 1;
        level.player cameraactivate( 1 );
        level.player startcameratween( 0.1 );
        level.player camerasetposition( level.player getplayercamerapos(), level.player getplayerangles() );
        level.overrideplayerdamage = undefined;
        level.player kill();
    }
    
    wait 2;
    self.overridevehicledamage = undefined;
    self kill();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xb3e31b6c, Offset: 0x4550
// Size: 0xf8
function function_9be6ef5f()
{
    self notify( "3918f757790a6381" );
    self endon( "3918f757790a6381" );
    level endon( #"hash_140019c0ef68a765" );
    
    while ( true )
    {
        level waittill( #"save_restore" );
        var_53bb8ef2 = level.var_53bb8ef2;
        
        if ( isdefined( var_53bb8ef2 ) )
        {
            var_53bb8ef2.var_b0bffa0a = 0;
            var_53bb8ef2.var_cafcae4c = 0;
            var_53bb8ef2.var_9df3157 = 0;
            var_53bb8ef2.var_cfa81957 = 2000;
            
            if ( isdefined( var_53bb8ef2.var_78bd98cb ) && level flag::get( #"hash_586bf214c79238e2" ) )
            {
                var_53bb8ef2.var_78bd98cb vehicle::set_damage_fx_level( 1 );
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 3
// Checksum 0x10cde765, Offset: 0x4650
// Size: 0x3f4
function function_6cf6a8c2( s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1 )
{
    self.script_int = s_spawn.script_int;
    self.script_noteworthy = s_spawn.script_noteworthy;
    self.var_214db6bf = s_spawn;
    self.var_bc2f081e = s_spawn.var_bc2f081e;
    
    if ( isactor( self ) )
    {
        var_562dce82 = self;
        
        if ( isdefined( s_spawn ) )
        {
            v_spawn = getclosestpointonnavmesh( s_spawn.origin );
            
            if ( !isdefined( v_spawn ) )
            {
                v_spawn = s_spawn.origin;
            }
            
            self forceteleport( v_spawn, s_spawn.angles );
            var_562dce82 = s_spawn;
        }
        
        if ( isdefined( var_562dce82.target ) )
        {
            goal = struct::get( var_562dce82.target );
            
            if ( !isdefined( goal ) )
            {
                goal = getnode( var_562dce82.target, "targetname" );
                
                if ( !isdefined( goal ) )
                {
                    goal = getent( var_562dce82.target, "targetname" );
                }
            }
            
            if ( isdefined( goal ) )
            {
                if ( var_86a56d5f )
                {
                    self thread spawner::go_to_node( goal );
                }
                else
                {
                    if ( isstruct( goal ) )
                    {
                        goal = goal.origin;
                    }
                    
                    self setgoal( goal, 1 );
                }
            }
        }
        
        if ( self util::is_on_side( #"axis" ) )
        {
            self.script_accuracy = 50;
            
            if ( var_9f1d53c7 )
            {
                self function_c9e47ce7();
            }
        }
    }
    
    if ( !function_8d8e91af( self ) )
    {
        if ( isactor( self ) )
        {
            self callback::function_d8abfc3d( #"on_ai_killed", &function_cb853b3d );
        }
        else if ( isvehicle( self ) )
        {
            self callback::function_d8abfc3d( #"on_vehicle_killed", &function_edf88bbb );
        }
    }
    
    if ( function_8d8e91af( self ) )
    {
        return;
    }
    
    if ( isvehicle( self ) )
    {
        if ( isdefined( s_spawn ) )
        {
            self.origin = s_spawn.origin;
            self.angles = s_spawn.angles;
        }
        
        var_8be533d2 = self.target;
        
        if ( isdefined( s_spawn.target ) )
        {
            var_8be533d2 = s_spawn.target;
        }
        
        if ( isdefined( var_8be533d2 ) && ( !isdefined( s_spawn ) || var_8be533d2 != s_spawn.targetname ) )
        {
            nd_path = getvehiclenode( var_8be533d2, "targetname" );
            
            if ( isdefined( nd_path ) )
            {
                if ( var_86a56d5f )
                {
                    self thread vehicle::get_on_and_go_path( nd_path );
                    return;
                }
                
                self vehicle::get_on_path( nd_path );
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x1952f112, Offset: 0x4a50
// Size: 0xf4
function function_cb853b3d( s_params )
{
    if ( s_params.weapon === level.var_53bb8ef2.var_df6d4579 )
    {
        level thread function_adc4e3e3( self );
    }
    
    if ( isplayer( s_params.eattacker ) )
    {
        var_9051f4a3 = level.var_9051f4a3;
        function_53c1b17f( s_params );
        
        if ( isdefined( self.var_1adf387f ) )
        {
            self.var_1adf387f.b_disabled = 1;
            
            if ( isdefined( var_9051f4a3.var_69fc4412[ self.var_1adf387f.var_c9a1df52 ] ) )
            {
                arrayremovevalue( var_9051f4a3.var_69fc4412[ self.var_1adf387f.var_c9a1df52 ], self.var_1adf387f );
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x80a4f3ae, Offset: 0x4b50
// Size: 0x1b4
function function_adc4e3e3( var_add480b6 )
{
    if ( isdefined( var_add480b6 ) )
    {
        wait 0.15;
        
        if ( isdefined( var_add480b6 ) )
        {
            v_launch = ( 0, 0, 0 );
            
            for ( i = 0; i < 3 ; i++ )
            {
                var_66732ef3 = randomfloatrange( 35, 80 );
                
                if ( i < 2 && math::cointoss() )
                {
                    var_66732ef3 *= -1;
                }
                
                switch ( i )
                {
                    case 0:
                        v_launch += ( var_66732ef3, 0, 0 );
                        break;
                    case 1:
                        v_launch += ( 0, var_66732ef3, 0 );
                        break;
                    case 2:
                        v_launch += ( 0, 0, var_66732ef3 );
                        break;
                }
            }
            
            var_add480b6 startragdoll();
            var_add480b6 launchragdoll( v_launch, array::random( [ "tag_origin", "j_spineupper", "j_spinelower", "j_head" ] ) );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xb17c0355, Offset: 0x4d10
// Size: 0x54
function function_edf88bbb( s_params )
{
    level thread function_53d20a8c( self, s_params );
    level thread function_a0d52507( self, s_params );
    function_53c1b17f( s_params );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x83335e69, Offset: 0x4d70
// Size: 0x116
function function_53d20a8c( vehicle, s_params )
{
    if ( isdefined( vehicle ) )
    {
        var_fff98e50 = function_e45cbe76( vehicle.origin, 512, #"axis" );
        
        foreach ( var_d32424f1 in var_fff98e50 )
        {
            if ( isalive( var_d32424f1 ) )
            {
                var_d32424f1 kill( var_d32424f1.origin, s_params.eattacker, s_params.einflictor, s_params.weapon );
                waitframe( 1 );
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x24b7da8a, Offset: 0x4e90
// Size: 0x2cc
function function_a0d52507( var_a485bd2b, s_params )
{
    if ( isdefined( var_a485bd2b ) )
    {
        switch ( var_a485bd2b.vehicletype )
        {
            default:
                return;
            case #"hash_2bf574cefe3e6d9e":
            case #"hash_3677daa34d36098a":
            case #"hash_3cdadb03ee525329":
                var_d1bcfb0f = 1100;
                var_88814cc1 = 1200;
                break;
        }
        
        var_a485bd2b vehicle::get_off_path();
        wait 0.15;
        
        if ( isdefined( var_a485bd2b ) )
        {
            v_up = anglestoup( var_a485bd2b.angles );
            v_launch = v_up * randomfloatrange( var_d1bcfb0f, var_88814cc1 );
            v_right = anglestoright( var_a485bd2b.angles );
            v_side = v_right;
            
            if ( isdefined( var_a485bd2b.var_bc2f081e ) )
            {
                if ( var_a485bd2b.var_bc2f081e == "left" )
                {
                    v_side *= -1;
                }
            }
            else if ( var_a485bd2b math::get_dot_right( s_params.eattacker.origin ) > 0 )
            {
                v_side *= -1;
            }
            
            v_launch += v_side * randomfloatrange( var_d1bcfb0f, var_88814cc1 );
            var_7caa77 = var_a485bd2b math::get_dot_forward( s_params.eattacker.origin );
            
            if ( abs( var_7caa77 ) > 0.5 )
            {
                v_forward = anglestoforward( var_a485bd2b.angles );
                
                if ( var_7caa77 > 0 )
                {
                    v_launch += v_forward * -1 * randomfloatrange( var_d1bcfb0f, var_88814cc1 );
                }
                else
                {
                    v_launch += v_forward * randomfloatrange( var_d1bcfb0f, var_88814cc1 );
                }
            }
            
            var_a485bd2b launchvehicle( v_launch, var_a485bd2b.origin, 0, 1 );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xc871510b, Offset: 0x5168
// Size: 0x64
function function_c9e47ce7()
{
    if ( isdefined( level.var_53bb8ef2.var_78bd98cb ) )
    {
        self clearentitytarget();
        self setentitytarget( level.var_53bb8ef2.var_78bd98cb, 1, "tag_body" );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x9f5eeafe, Offset: 0x51d8
// Size: 0x254
function function_f994e739( var_a9edb1ef )
{
    self endon( #"death" );
    self val::set( #"hash_5827a24ebe1f127", "ignoreme", 1 );
    self val::set( #"hash_5827a24ebe1f127", "ignoreall", 1 );
    waitframe( 1 );
    self turret::set_burst_parameters( 1, 2, 0.25, 0.5, 1 );
    self turret::enable( 1, 0 );
    self turret::function_41c79ce4( 1, 1 );
    self turret::function_9c04d437( 1, 1 );
    self turret::set_target( level.var_53bb8ef2.var_78bd98cb, ( 0, 0, 32 ), 1, 1 );
    self turret::function_49c3b892( level.var_53bb8ef2.var_78bd98cb, 1 );
    self turret::set_target_leading( 1, 0.1 );
    
    while ( true )
    {
        while ( !self function_df845383( var_a9edb1ef ) )
        {
            wait 0.1;
        }
        
        while ( self function_df845383( var_a9edb1ef ) )
        {
            self vehicle_ai::fire_for_time( randomfloatrange( 1, 2 ), 1 );
            wait randomfloatrange( 0.25, 0.5 );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xa175fb29, Offset: 0x5438
// Size: 0x12e, Type: bool
function function_df845383( var_a9edb1ef )
{
    /#
        if ( level.player isnotarget() )
        {
            return false;
        }
    #/
    
    var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;
    
    if ( !isdefined( var_78bd98cb ) )
    {
        return false;
    }
    
    v_trace_start = self getcentroid();
    
    if ( isdefined( var_a9edb1ef ) )
    {
        v_trace_start = self gettagorigin( var_a9edb1ef );
    }
    
    n_dist = distancesquared( self.origin, var_78bd98cb.origin );
    
    if ( n_dist <= sqr( 8000 ) )
    {
        b_trace_passed = bullettracepassed( v_trace_start, var_78bd98cb.origin, 0, self );
        
        if ( b_trace_passed )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x9e3952a9, Offset: 0x5570
// Size: 0x120
function function_fb080e60( var_b6fdd6f2, var_7af285a8 = 0 )
{
    if ( !isdefined( var_b6fdd6f2 ) )
    {
        var_b6fdd6f2 = [];
    }
    else if ( !isarray( var_b6fdd6f2 ) )
    {
        var_b6fdd6f2 = array( var_b6fdd6f2 );
    }
    
    foreach ( cleanup_ent in var_b6fdd6f2 )
    {
        if ( isdefined( cleanup_ent ) )
        {
            if ( var_7af285a8 && is_true( cleanup_ent.var_36ceff65 ) )
            {
                continue;
            }
            
            cleanup_ent delete();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 8
// Checksum 0xbda78a30, Offset: 0x5698
// Size: 0x1e2
function function_d305a607( var_3ba94e96, str_spawns, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3 )
{
    var_2199674d = [];
    a_spawners = getspawnerarray( var_3ba94e96, "targetname" );
    
    if ( !isdefined( str_spawns ) )
    {
        a_s_spawns = function_49a2ca0c( a_spawners );
    }
    else
    {
        a_s_spawns = function_49a2ca0c( str_spawns );
    }
    
    foreach ( s_spawn in a_s_spawns )
    {
        spawner = function_84228c0e( s_spawn, a_spawners );
        e_spawned = function_27d376a0( spawner, s_spawn, var_86a56d5f, var_9f1d53c7, spawn_func, arg1, arg2, arg3 );
        
        if ( !isdefined( var_2199674d ) )
        {
            var_2199674d = [];
        }
        else if ( !isarray( var_2199674d ) )
        {
            var_2199674d = array( var_2199674d );
        }
        
        var_2199674d[ var_2199674d.size ] = e_spawned;
    }
    
    return var_2199674d;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xd7e158ce, Offset: 0x5888
// Size: 0x34a
function function_49a2ca0c( source )
{
    var_3be3a3f8 = 0;
    
    if ( isarray( source ) )
    {
        var_3bc84e2 = [];
        
        foreach ( spawner in source )
        {
            foreach ( s_spawn in struct::get_array( spawner.target ) )
            {
                s_spawn.var_cd2ac598 = spawner;
                
                if ( !isdefined( var_3bc84e2 ) )
                {
                    var_3bc84e2 = [];
                }
                else if ( !isarray( var_3bc84e2 ) )
                {
                    var_3bc84e2 = array( var_3bc84e2 );
                }
                
                var_3bc84e2[ var_3bc84e2.size ] = s_spawn;
            }
        }
    }
    else
    {
        var_3be3a3f8 = 1;
        var_3bc84e2 = struct::get_array( source );
    }
    
    var_cc56247a = [];
    var_f9d15262 = [];
    
    foreach ( s_spawn in var_3bc84e2 )
    {
        if ( var_3be3a3f8 && !isdefined( s_spawn.var_d691a932 ) && !isdefined( s_spawn.var_bf2d3e18 ) )
        {
            continue;
        }
        
        if ( isdefined( s_spawn.script_int ) )
        {
            if ( !isdefined( var_cc56247a ) )
            {
                var_cc56247a = [];
            }
            else if ( !isarray( var_cc56247a ) )
            {
                var_cc56247a = array( var_cc56247a );
            }
            
            var_cc56247a[ var_cc56247a.size ] = s_spawn;
            continue;
        }
        
        if ( !isdefined( var_f9d15262 ) )
        {
            var_f9d15262 = [];
        }
        else if ( !isarray( var_f9d15262 ) )
        {
            var_f9d15262 = array( var_f9d15262 );
        }
        
        var_f9d15262[ var_f9d15262.size ] = s_spawn;
    }
    
    var_cc56247a = array::sort_by_script_int( var_cc56247a, 1 );
    a_s_spawns = arraycombine( var_cc56247a, var_f9d15262 );
    return a_s_spawns;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0xf6186dd3, Offset: 0x5be0
// Size: 0x106
function function_84228c0e( s_spawn, a_spawners )
{
    if ( isdefined( s_spawn.var_cd2ac598 ) )
    {
        return s_spawn.var_cd2ac598;
    }
    
    var_828a77d1 = s_spawn.var_d691a932;
    
    if ( !isdefined( var_828a77d1 ) )
    {
        var_828a77d1 = s_spawn.var_bf2d3e18;
    }
    
    if ( isdefined( var_828a77d1 ) )
    {
        foreach ( spawner in a_spawners )
        {
            var_b8e762a2 = spawner.var_d691a932;
            
            if ( !isdefined( var_b8e762a2 ) )
            {
                var_b8e762a2 = spawner.var_bf2d3e18;
            }
            
            if ( var_828a77d1 === var_b8e762a2 )
            {
                return spawner;
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 8
// Checksum 0xada00bc9, Offset: 0x5cf0
// Size: 0x18e
function function_27d376a0( spawner, s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3 )
{
    v_original_origin = spawner.origin;
    var_156222bf = spawner.angles;
    var_62c2f167 = spawner.target;
    
    if ( is_true( spawner.script_drone ) )
    {
        spawner.origin = s_spawn.origin;
        spawner.angles = s_spawn.angles;
        spawner.target = s_spawn.target;
    }
    
    while ( true )
    {
        e_spawned = spawner::simple_spawn_single( spawner, &function_6cf6a8c2, s_spawn, var_86a56d5f, var_9f1d53c7 );
        
        if ( isdefined( e_spawned ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    if ( isdefined( spawn_func ) )
    {
        util::single_thread( e_spawned, spawn_func, arg1, arg2, arg3 );
    }
    
    spawner.origin = v_original_origin;
    spawner.angles = var_156222bf;
    spawner.target = var_62c2f167;
    return e_spawned;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x9b831071, Offset: 0x5e88
// Size: 0x44
function function_a58d474d()
{
    level flag::set( #"flag_mortar_orbit_complete" );
    level flag::set( #"flag_mortar_village_complete" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 3
// Checksum 0xd0381ce8, Offset: 0x5ed8
// Size: 0x3cc
function function_4f34fd5a( var_d3440450 = "", var_7f6942d7 = "fighting_hind", var_74165b46 = "hind_destroyed" )
{
    var_1f372b50 = level.var_1f372b50;
    var_1f372b50 endon( #"skipped_01", #"skipped_02" );
    n_start = 0;
    var_cb8bae59 = 0;
    
    if ( var_d3440450 == "player_controlled_huey_02" )
    {
        n_start = 1;
    }
    
    for ( i = n_start; i < 5 ; i++ )
    {
        switch ( i )
        {
            case 0:
                str_struct = "obj_fly_3_return_01_m";
                str_flag = "flag_obj_fly_3_return_01_m";
                break;
            case 1:
                str_struct = "obj_fly_3_return_02";
                str_flag = "flag_obj_fly_3_return_02";
                break;
            case 2:
                str_struct = "obj_fly_3_return_03";
                str_flag = "flag_obj_fly_3_return_03";
                break;
            case 3:
                str_struct = "obj_fly_3_return_04";
                str_flag = "flag_obj_fly_3_return_04";
                break;
            case 4:
                str_struct = "obj_fly_3_return_05";
                str_flag = "flag_obj_fly_3_return_05";
                break;
            case 5:
                str_struct = "obj_firebase";
                str_trigger = "trig_reached_firebase";
                break;
        }
        
        var_1f372b50.s_waypoint = struct::get( str_struct );
        
        if ( flag::get( var_7f6942d7 ) )
        {
            if ( !var_cb8bae59 )
            {
                objectives::complete( "armada_obj_fly_to_firebase", var_1f372b50.s_waypoint );
                level thread objectives::kill( "armada_obj_kill_the_hind", level.enemy_heli, #"hash_17e6b740b76e28b8", undefined, undefined, undefined, #"hash_17f4660b06e37fdb" );
                var_cb8bae59 = 1;
            }
            
            if ( i < 5 )
            {
                level flag::wait_till_any( [ str_flag, var_74165b46 ] );
            }
            else
            {
                trigger::wait_till( str_trigger );
            }
            
            continue;
        }
        
        level thread objectives::function_4eb5c04a( "armada_obj_fly_to_firebase", var_1f372b50.s_waypoint, #"hash_5483ae2de22e69c8" );
        
        if ( i < 5 )
        {
            level flag::wait_till_any( [ str_flag, var_7f6942d7 ] );
        }
        else
        {
            trigger::wait_till( str_trigger );
        }
        
        objectives::complete( "armada_obj_fly_to_firebase", var_1f372b50.s_waypoint );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 3
// Checksum 0xc104933f, Offset: 0x62b0
// Size: 0x1b4
function function_fd9a75d2( s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1 )
{
    self function_6cf6a8c2( s_spawn, var_86a56d5f, var_9f1d53c7 );
    
    if ( !isdefined( level.var_1f372b50.var_b6fdd6f2 ) )
    {
        level.var_1f372b50.var_b6fdd6f2 = [];
    }
    else if ( !isarray( level.var_1f372b50.var_b6fdd6f2 ) )
    {
        level.var_1f372b50.var_b6fdd6f2 = array( level.var_1f372b50.var_b6fdd6f2 );
    }
    
    level.var_1f372b50.var_b6fdd6f2[ level.var_1f372b50.var_b6fdd6f2.size ] = self;
    
    if ( !isdefined( level.var_1f372b50.var_5b419be2 ) )
    {
        level.var_1f372b50.var_5b419be2 = [];
    }
    else if ( !isarray( level.var_1f372b50.var_5b419be2 ) )
    {
        level.var_1f372b50.var_5b419be2 = array( level.var_1f372b50.var_5b419be2 );
    }
    
    level.var_1f372b50.var_5b419be2[ level.var_1f372b50.var_5b419be2.size ] = self;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 3
// Checksum 0xf22faf1e, Offset: 0x6470
// Size: 0x1b4
function function_b3dd6259( s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1 )
{
    self function_6cf6a8c2( s_spawn, var_86a56d5f, var_9f1d53c7 );
    
    if ( !isdefined( level.var_1f372b50.var_b6fdd6f2 ) )
    {
        level.var_1f372b50.var_b6fdd6f2 = [];
    }
    else if ( !isarray( level.var_1f372b50.var_b6fdd6f2 ) )
    {
        level.var_1f372b50.var_b6fdd6f2 = array( level.var_1f372b50.var_b6fdd6f2 );
    }
    
    level.var_1f372b50.var_b6fdd6f2[ level.var_1f372b50.var_b6fdd6f2.size ] = self;
    
    if ( !isdefined( level.var_1f372b50.var_8b8c7c77 ) )
    {
        level.var_1f372b50.var_8b8c7c77 = [];
    }
    else if ( !isarray( level.var_1f372b50.var_8b8c7c77 ) )
    {
        level.var_1f372b50.var_8b8c7c77 = array( level.var_1f372b50.var_8b8c7c77 );
    }
    
    level.var_1f372b50.var_8b8c7c77[ level.var_1f372b50.var_8b8c7c77.size ] = self;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 8
// Checksum 0xe819049d, Offset: 0x6630
// Size: 0x264
function function_4a645aa9( var_3ba94e96, str_spawns, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3 )
{
    a_ai_spawned = function_d305a607( var_3ba94e96, str_spawns, var_86a56d5f, var_9f1d53c7, spawn_func, arg1, arg2, arg3 );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( !isdefined( level.var_1f372b50.var_b6fdd6f2 ) )
        {
            level.var_1f372b50.var_b6fdd6f2 = [];
        }
        else if ( !isarray( level.var_1f372b50.var_b6fdd6f2 ) )
        {
            level.var_1f372b50.var_b6fdd6f2 = array( level.var_1f372b50.var_b6fdd6f2 );
        }
        
        level.var_1f372b50.var_b6fdd6f2[ level.var_1f372b50.var_b6fdd6f2.size ] = ai_spawned;
        
        if ( !isdefined( level.var_1f372b50.var_5b419be2 ) )
        {
            level.var_1f372b50.var_5b419be2 = [];
        }
        else if ( !isarray( level.var_1f372b50.var_5b419be2 ) )
        {
            level.var_1f372b50.var_5b419be2 = array( level.var_1f372b50.var_5b419be2 );
        }
        
        level.var_1f372b50.var_5b419be2[ level.var_1f372b50.var_5b419be2.size ] = ai_spawned;
    }
    
    return a_ai_spawned;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 8
// Checksum 0xe6227770, Offset: 0x68a0
// Size: 0x264
function function_ca66dab0( var_3ba94e96, str_spawns, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3 )
{
    a_ai_spawned = function_d305a607( var_3ba94e96, str_spawns, var_86a56d5f, var_9f1d53c7, spawn_func, arg1, arg2, arg3 );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( !isdefined( level.var_1f372b50.var_b6fdd6f2 ) )
        {
            level.var_1f372b50.var_b6fdd6f2 = [];
        }
        else if ( !isarray( level.var_1f372b50.var_b6fdd6f2 ) )
        {
            level.var_1f372b50.var_b6fdd6f2 = array( level.var_1f372b50.var_b6fdd6f2 );
        }
        
        level.var_1f372b50.var_b6fdd6f2[ level.var_1f372b50.var_b6fdd6f2.size ] = ai_spawned;
        
        if ( !isdefined( level.var_1f372b50.var_8b8c7c77 ) )
        {
            level.var_1f372b50.var_8b8c7c77 = [];
        }
        else if ( !isarray( level.var_1f372b50.var_8b8c7c77 ) )
        {
            level.var_1f372b50.var_8b8c7c77 = array( level.var_1f372b50.var_8b8c7c77 );
        }
        
        level.var_1f372b50.var_8b8c7c77[ level.var_1f372b50.var_8b8c7c77.size ] = ai_spawned;
    }
    
    return a_ai_spawned;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0x68d6f602, Offset: 0x6b10
// Size: 0x38e
function function_d7c5193b( var_ff72be84, var_5986bd6d = 0, var_c6034837 = 0, var_3ac1a8ad = 0 )
{
    var_55804cd3 = [];
    
    if ( var_5986bd6d > 0 )
    {
        if ( !isdefined( var_55804cd3 ) )
        {
            var_55804cd3 = [];
        }
        else if ( !isarray( var_55804cd3 ) )
        {
            var_55804cd3 = array( var_55804cd3 );
        }
        
        var_55804cd3[ var_55804cd3.size ] = "ar";
    }
    
    if ( var_c6034837 > 0 )
    {
        if ( !isdefined( var_55804cd3 ) )
        {
            var_55804cd3 = [];
        }
        else if ( !isarray( var_55804cd3 ) )
        {
            var_55804cd3 = array( var_55804cd3 );
        }
        
        var_55804cd3[ var_55804cd3.size ] = "lmg";
    }
    
    if ( var_3ac1a8ad > 0 )
    {
        if ( !isdefined( var_55804cd3 ) )
        {
            var_55804cd3 = [];
        }
        else if ( !isarray( var_55804cd3 ) )
        {
            var_55804cd3 = array( var_55804cd3 );
        }
        
        var_55804cd3[ var_55804cd3.size ] = "rpg";
    }
    
    a_ai_spawned = [];
    var_b82f118 = var_5986bd6d;
    var_50ad5cf2 = var_c6034837;
    var_51702fb9 = var_3ac1a8ad;
    n_to_spawn = var_5986bd6d + var_c6034837 + var_3ac1a8ad;
    
    for ( i = 0; i < n_to_spawn ; i++ )
    {
        str_choice = array::random( var_55804cd3 );
        
        switch ( str_choice )
        {
            case #"ar":
                str_spawner = "sp_pch_convoy_01_ar";
                var_b82f118--;
                
                if ( var_b82f118 <= 0 )
                {
                    arrayremovevalue( var_55804cd3, "ar" );
                }
                
                break;
            case #"lmg":
                str_spawner = "sp_pch_convoy_01_lmg";
                var_50ad5cf2--;
                
                if ( var_50ad5cf2 <= 0 )
                {
                    arrayremovevalue( var_55804cd3, "lmg" );
                }
                
                break;
            case #"rpg":
                str_spawner = "sp_pch_convoy_01_rpg";
                var_51702fb9--;
                
                if ( var_51702fb9 <= 0 )
                {
                    arrayremovevalue( var_55804cd3, "rpg" );
                }
                
                break;
        }
        
        ai_spawned = spawner::simple_spawn_single( str_spawner, &function_f312a183, var_ff72be84, i );
        
        if ( !isdefined( a_ai_spawned ) )
        {
            a_ai_spawned = [];
        }
        else if ( !isarray( a_ai_spawned ) )
        {
            a_ai_spawned = array( a_ai_spawned );
        }
        
        a_ai_spawned[ a_ai_spawned.size ] = ai_spawned;
    }
    
    return a_ai_spawned;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x5c644c9c, Offset: 0x6ea8
// Size: 0x35e
function function_f312a183( var_ff72be84, n_index )
{
    self endon( #"death" );
    var_ff72be84 endon( #"death", #"reached_end_node" );
    self function_6cf6a8c2( undefined, undefined, 0 );
    self val::set( "pch_ignoreall", "ignoreall", 1 );
    v_forward = anglestoforward( var_ff72be84.angles );
    v_right = anglestoright( var_ff72be84.angles );
    
    switch ( n_index )
    {
        case 0:
        case 1:
            n_spacing = 128;
            break;
        case 2:
        case 3:
            n_spacing = 0;
            break;
        case 4:
        case 5:
            n_spacing = -128;
            break;
    }
    
    var_43e399ea = -1;
    
    if ( n_index % 2 > 0 )
    {
        var_43e399ea = 1;
    }
    
    var_2ed5776a = self getpathfindingradius();
    v_center = checknavmeshdirection( var_ff72be84.origin, vectornormalize( v_forward ), 180 + n_spacing, var_2ed5776a );
    v_spawn = checknavmeshdirection( v_center, vectornormalize( v_right * var_43e399ea ), 180, var_2ed5776a );
    self forceteleport( v_spawn, var_ff72be84.angles );
    
    while ( true )
    {
        v_forward = anglestoforward( var_ff72be84.angles );
        v_right = anglestoright( var_ff72be84.angles );
        v_center = checknavmeshdirection( var_ff72be84.origin, vectornormalize( v_forward ), 180 + n_spacing, var_2ed5776a );
        v_goal = checknavmeshdirection( v_center, vectornormalize( v_right * var_43e399ea ), 180, var_2ed5776a );
        self setgoal( v_goal, 1 );
        waitframe( 1 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0xe5ca35a3, Offset: 0x7210
// Size: 0x244
function function_e745d54c( var_ff72be84, var_5986bd6d = 0, var_c6034837 = 0, var_3ac1a8ad = 0 )
{
    a_ai_spawned = function_d7c5193b( var_ff72be84, var_5986bd6d, var_c6034837, var_3ac1a8ad );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( !isdefined( level.var_1f372b50.var_b6fdd6f2 ) )
        {
            level.var_1f372b50.var_b6fdd6f2 = [];
        }
        else if ( !isarray( level.var_1f372b50.var_b6fdd6f2 ) )
        {
            level.var_1f372b50.var_b6fdd6f2 = array( level.var_1f372b50.var_b6fdd6f2 );
        }
        
        level.var_1f372b50.var_b6fdd6f2[ level.var_1f372b50.var_b6fdd6f2.size ] = ai_spawned;
        
        if ( !isdefined( level.var_1f372b50.var_5b419be2 ) )
        {
            level.var_1f372b50.var_5b419be2 = [];
        }
        else if ( !isarray( level.var_1f372b50.var_5b419be2 ) )
        {
            level.var_1f372b50.var_5b419be2 = array( level.var_1f372b50.var_5b419be2 );
        }
        
        level.var_1f372b50.var_5b419be2[ level.var_1f372b50.var_5b419be2.size ] = ai_spawned;
    }
    
    return a_ai_spawned;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0x1af6512c, Offset: 0x7460
// Size: 0x244
function function_f987f9d0( var_ff72be84, var_5986bd6d = 0, var_c6034837 = 0, var_3ac1a8ad = 0 )
{
    a_ai_spawned = function_d7c5193b( var_ff72be84, var_5986bd6d, var_c6034837, var_3ac1a8ad );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( !isdefined( level.var_1f372b50.var_b6fdd6f2 ) )
        {
            level.var_1f372b50.var_b6fdd6f2 = [];
        }
        else if ( !isarray( level.var_1f372b50.var_b6fdd6f2 ) )
        {
            level.var_1f372b50.var_b6fdd6f2 = array( level.var_1f372b50.var_b6fdd6f2 );
        }
        
        level.var_1f372b50.var_b6fdd6f2[ level.var_1f372b50.var_b6fdd6f2.size ] = ai_spawned;
        
        if ( !isdefined( level.var_1f372b50.var_8b8c7c77 ) )
        {
            level.var_1f372b50.var_8b8c7c77 = [];
        }
        else if ( !isarray( level.var_1f372b50.var_8b8c7c77 ) )
        {
            level.var_1f372b50.var_8b8c7c77 = array( level.var_1f372b50.var_8b8c7c77 );
        }
        
        level.var_1f372b50.var_8b8c7c77[ level.var_1f372b50.var_8b8c7c77.size ] = ai_spawned;
    }
    
    return a_ai_spawned;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0xc4dab87f, Offset: 0x76b0
// Size: 0x108
function function_3b521a25( var_ff72be84, var_ada0b21 )
{
    if ( isdefined( var_ff72be84 ) )
    {
        var_ff72be84 waittill( #"death", #"reached_end_node" );
    }
    
    function_1eaaceab( var_ada0b21 );
    
    foreach ( var_46745ec4 in var_ada0b21 )
    {
        var_46745ec4 val::reset( "pch_ignoreall", "ignoreall" );
        var_46745ec4 function_c9e47ce7();
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x33fe3f23, Offset: 0x77c0
// Size: 0x54
function function_64cad509( *var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    function_a58d474d();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x1108a20f, Offset: 0x7820
// Size: 0x1ec
function function_5854aa8c( var_d3440450, var_50cc0d4f )
{
    var_1f372b50 = level.var_1f372b50;
    var_1f372b50 endon( #"skipped_01" );
    function_a291d0f( var_d3440450, var_50cc0d4f );
    namespace_72b0499b::music( "tmp_player_heli_start" );
    level snd::client_msg( #"hash_4a41082a1d97f925" );
    level snd::client_msg( #"hash_72dd94fb3a8887e5" );
    level snd::client_msg( #"hash_551e8554285c2305" );
    level thread function_4f34fd5a( var_d3440450 );
    level thread function_d66218b9();
    level thread function_49fec2ec();
    level thread function_e817bc24();
    level thread function_ad2fd586();
    level thread function_6c8d98bf();
    level thread function_360056d2();
    level thread function_56b0e932();
    level thread function_d499f214();
    level flag::wait_till( "flag_pch_complete_skipto_01" );
    var_1f372b50.var_6180054f = 1;
    skipto::function_4e3ab877( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x20b71366, Offset: 0x7a18
// Size: 0x64
function function_d66218b9()
{
    level.var_1f372b50 endon( #"skipped_01" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        level thread function_d00e7d6d( i );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x9fd15ff3, Offset: 0x7a88
// Size: 0xe4
function function_d00e7d6d( n_index )
{
    level.var_1f372b50 endon( #"skipped_01" );
    var_ff72be84 = spawner::simple_spawn_single( "sp_vh_pch_convoy_01", &function_a059d587, n_index );
    level flag::wait_till( "flag_pch_combat_02" );
    
    if ( isvehicle( var_ff72be84 ) )
    {
        var_a974a435 = var_ff72be84 vehicle::function_86c7bebb();
        function_fb080e60( var_a974a435 );
    }
    
    function_fb080e60( var_ff72be84 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xfe406902, Offset: 0x7b78
// Size: 0x94
function function_a059d587( n_index )
{
    self endon( #"death" );
    self function_fd9a75d2( undefined, 0 );
    var_8be533d2 = "nd_pch_convoy_01_0" + n_index + 1;
    nd_path = getvehiclenode( var_8be533d2, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_path );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xa6a616f7, Offset: 0x7c18
// Size: 0x118
function function_baf2710b()
{
    level.var_1f372b50 endon( #"skipped_01" );
    level flag::wait_till( "flag_pch_combat_01" );
    a_ai_spawned = function_4a645aa9( "sp_pch_runners_01" );
    level flag::wait_till( "flag_pch_runners_01_actors_cleanup" );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( isalive( ai_spawned ) )
        {
            ai_spawned kill();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x391c322a, Offset: 0x7d38
// Size: 0xac
function function_df1a44de()
{
    level.var_1f372b50 endon( #"skipped_01" );
    a_drones = function_4a645aa9( "sp_pch_runners_01_drones" );
    level flag::wait_till( "flag_pch_runners_01_drones" );
    level thread function_af0048eb( a_drones );
    level flag::wait_till( "flag_pch_combat_02" );
    function_fb080e60( a_drones );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x5bfeaa42, Offset: 0x7df0
// Size: 0x74
function function_ad2fd586()
{
    level.var_1f372b50 endon( #"skipped_01" );
    a_ai_spawned = function_4a645aa9( "sp_pch_runners_02" );
    level flag::wait_till( "flag_pch_combat_02" );
    function_fb080e60( a_ai_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x4aa43e98, Offset: 0x7e70
// Size: 0x188
function function_6c8d98bf()
{
    level.var_1f372b50 endon( #"skipped_01" );
    level flag::wait_till( "flag_pch_combat_01" );
    var_abc28788 = function_4a645aa9( "sp_pch_building_defenders_01", "s_pch_building_defenders_01_01" );
    level flag::wait_till( "flag_pch_building_defenders_01" );
    var_9817e033 = function_4a645aa9( "sp_pch_building_defenders_01", "s_pch_building_defenders_01_02" );
    level flag::wait_till( "flag_pch_building_defenders_01_cleanup" );
    a_ai_spawned = arraycombine( var_abc28788, var_9817e033, 0, 0 );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( isalive( ai_spawned ) )
        {
            ai_spawned kill();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x1d3a977b, Offset: 0x8000
// Size: 0x13c
function function_360056d2()
{
    level.var_1f372b50 endon( #"skipped_01" );
    level flag::wait_till( "flag_pch_combat_01" );
    a_spawned = spawner::simple_spawn( "sp_pch_parked_trucks_01", &function_fd9a75d2 );
    level flag::wait_till( "flag_pch_parked_trucks_01_cleanup" );
    
    foreach ( spawned in a_spawned )
    {
        if ( isalive( spawned ) )
        {
            spawned kill();
        }
    }
    
    function_fb080e60( a_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x19bc780, Offset: 0x8148
// Size: 0x74
function function_49fec2ec()
{
    level.var_1f372b50 endon( #"skipped_01" );
    a_ai_spawned = function_4a645aa9( "sp_pch_boat_01" );
    level flag::wait_till( "flag_pch_complete_skipto_01" );
    function_fb080e60( a_ai_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x1bbbb676, Offset: 0x81c8
// Size: 0x7c
function function_e817bc24()
{
    level.var_1f372b50 endon( #"skipped_01" );
    level flag::wait_till( "flag_pch_combat_01" );
    
    for ( i = 0; i < 2 ; i++ )
    {
        level thread function_22772241( i );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x1b2465e1, Offset: 0x8250
// Size: 0xe4
function function_22772241( n_index )
{
    level.var_1f372b50 endon( #"skipped_01" );
    var_ff72be84 = spawner::simple_spawn_single( "sp_vh_pch_convoy_02", &function_869b1ad9, n_index );
    level flag::wait_till( "flag_pch_skipto_01_cleanup" );
    
    if ( isvehicle( var_ff72be84 ) )
    {
        var_a974a435 = var_ff72be84 vehicle::function_86c7bebb();
        function_fb080e60( var_a974a435 );
    }
    
    function_fb080e60( var_ff72be84 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x1e1b68a2, Offset: 0x8340
// Size: 0x174
function function_869b1ad9( n_index )
{
    self endon( #"death" );
    self function_fd9a75d2( undefined, 0 );
    var_1f372b50 = level.var_1f372b50;
    
    if ( !isdefined( var_1f372b50.var_e66c9b5a ) )
    {
        var_1f372b50.var_e66c9b5a = [];
    }
    else if ( !isarray( var_1f372b50.var_e66c9b5a ) )
    {
        var_1f372b50.var_e66c9b5a = array( var_1f372b50.var_e66c9b5a );
    }
    
    var_1f372b50.var_e66c9b5a[ var_1f372b50.var_e66c9b5a.size ] = self;
    var_8be533d2 = "nd_pch_convoy_02_0" + n_index + 1;
    nd_path = getvehiclenode( var_8be533d2, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_path );
    self vehicle::pause_path();
    level flag::wait_till( "flag_pch_convoy_02" );
    self vehicle::resume_path();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x1eb7ba98, Offset: 0x84c0
// Size: 0x8e
function function_daa88d15()
{
    self endon( #"death" );
    
    while ( true )
    {
        self pathmode( "dont move" );
        self function_d4c687c9();
        self clearforcedgoal();
        self clearpath();
        waitframe( 1 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x3caed183, Offset: 0x8558
// Size: 0x188
function function_78af49ee()
{
    level.var_1f372b50 endon( #"skipped_01" );
    level flag::wait_till( "flag_pch_islanders_01_01" );
    var_abc28788 = function_4a645aa9( "sp_pch_islanders_01", "s_pch_islanders_01_01" );
    level flag::wait_till( "flag_pch_islanders_01_02" );
    var_9817e033 = function_4a645aa9( "sp_pch_islanders_01", "s_pch_islanders_01_02" );
    level flag::wait_till( "flag_pch_islanders_01_cleanup" );
    a_ai_spawned = arraycombine( var_abc28788, var_9817e033, 0, 0 );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( isalive( ai_spawned ) )
        {
            ai_spawned kill();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x2e9b4a2a, Offset: 0x86e8
// Size: 0x190
function function_5e6c3800()
{
    level.var_1f372b50 endon( #"skipped_01" );
    level flag::wait_till( "flag_pch_runners_03" );
    a_ai_spawned = function_4a645aa9( "sp_pch_runners_03" );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        ai_spawned function_d7886de2();
    }
    
    level flag::wait_till( "flag_pch_runners_03_cleanup" );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( isalive( ai_spawned ) )
        {
            ai_spawned kill();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x49f6c687, Offset: 0x8880
// Size: 0x28c
function function_c32e0e2c()
{
    level.var_1f372b50 endon( #"skipped_01" );
    level flag::wait_till( "flag_pch_runners_03_drones_spawn" );
    var_9e1bacc9 = function_4a645aa9( "sp_pch_runners_03_drones", "s_pch_runners_03_drones_01" );
    var_a965c35d = function_4a645aa9( "sp_pch_runners_03_drones", "s_pch_runners_03_drones_02" );
    var_bba267d6 = function_4a645aa9( "sp_pch_runners_03_drones", "s_pch_runners_03_drones_03" );
    var_1f6e8256 = struct::get( "s_pch_runners_03_drones_sort" );
    var_9e1bacc9 = arraysort( var_9e1bacc9, var_1f6e8256.origin, 0 );
    var_a965c35d = arraysort( var_a965c35d, var_1f6e8256.origin, 0 );
    var_bba267d6 = arraysort( var_bba267d6, var_1f6e8256.origin, 0 );
    var_11178ba5 = arraycombine( var_9e1bacc9, var_a965c35d );
    var_11178ba5 = arraycombine( var_11178ba5, var_bba267d6 );
    
    foreach ( drone in var_11178ba5 )
    {
        drone function_d7886de2();
    }
    
    level flag::wait_till( "flag_pch_runners_03_drones_move" );
    level thread function_af0048eb( var_9e1bacc9 );
    level thread function_af0048eb( var_a965c35d );
    level thread function_af0048eb( var_bba267d6 );
    level flag::wait_till( "flag_pch_skipto_01_cleanup" );
    function_fb080e60( var_11178ba5 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x176cb2, Offset: 0x8b18
// Size: 0xd8
function function_af0048eb( a_drones )
{
    level.var_1f372b50 endon( #"skipped_01", #"skipped_02" );
    
    foreach ( drone in a_drones )
    {
        if ( isdefined( drone ) )
        {
            drone notify( #"move" );
            waitframe( randomintrangeinclusive( 1, 3 ) );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x3a8beba3, Offset: 0x8bf8
// Size: 0x144
function function_56b0e932()
{
    level.var_1f372b50 endon( #"skipped_01" );
    level flag::wait_till( "flag_pch_combat_02" );
    var_27240fa9 = spawner::simple_spawn( "sp_vh_pch_bridge_sentry_01", &function_fd9a75d2 );
    var_abc28788 = function_4a645aa9( "sp_pch_bridge_sentry_01_01" );
    level flag::wait_till( "flag_pch_bridge_sentry_01" );
    var_9817e033 = spawner::simple_spawn( "sp_pch_bridge_sentry_01_02", &function_fd9a75d2 );
    level flag::wait_till( "flag_pch_bridge_sentry_01_cleanup" );
    function_fb080e60( var_27240fa9 );
    function_fb080e60( var_abc28788 );
    function_fb080e60( var_9817e033 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x7ecfaba, Offset: 0x8d48
// Size: 0xb4
function function_85d01673()
{
    if ( !isdefined( level.var_1f372b50.var_e66c9b5a ) )
    {
        level.var_1f372b50.var_e66c9b5a = [];
    }
    else if ( !isarray( level.var_1f372b50.var_e66c9b5a ) )
    {
        level.var_1f372b50.var_e66c9b5a = array( level.var_1f372b50.var_e66c9b5a );
    }
    
    level.var_1f372b50.var_e66c9b5a[ level.var_1f372b50.var_e66c9b5a.size ] = self;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xcfc18bc8, Offset: 0x8e08
// Size: 0xb4
function function_d7886de2()
{
    if ( !isdefined( level.var_1f372b50.var_c4a2f2c0 ) )
    {
        level.var_1f372b50.var_c4a2f2c0 = [];
    }
    else if ( !isarray( level.var_1f372b50.var_c4a2f2c0 ) )
    {
        level.var_1f372b50.var_c4a2f2c0 = array( level.var_1f372b50.var_c4a2f2c0 );
    }
    
    level.var_1f372b50.var_c4a2f2c0[ level.var_1f372b50.var_c4a2f2c0.size ] = self;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x359c3069, Offset: 0x8ec8
// Size: 0x124
function function_d499f214()
{
    var_1f372b50 = level.var_1f372b50;
    var_1f372b50 endon( #"skipped_01" );
    s_waitresult = level flag::wait_till_any( [ "flag_pch_island_fork_left_cleanup", "flag_pch_island_fork_right_cleanup" ] );
    
    if ( s_waitresult._notify == "flag_pch_island_fork_left_cleanup" )
    {
        var_1f372b50 notify( #"hash_185cafe726f8c276" );
        var_b6fdd6f2 = isdefined( var_1f372b50.var_e66c9b5a ) ? var_1f372b50.var_e66c9b5a : [];
    }
    else
    {
        var_1f372b50 notify( #"hash_704cc0aff7e3f92d" );
        var_b6fdd6f2 = isdefined( var_1f372b50.var_c4a2f2c0 ) ? var_1f372b50.var_c4a2f2c0 : [];
    }
    
    function_fb080e60( var_b6fdd6f2 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0xc135ef84, Offset: 0x8ff8
// Size: 0xf4
function function_d6bbe091( *var_d3440450, *var_50cc0d4f, var_aa1a6455, *e_player )
{
    if ( !e_player )
    {
        return;
    }
    
    var_1f372b50 = level.var_1f372b50;
    
    if ( !is_true( var_1f372b50.var_6180054f ) )
    {
        var_1f372b50 notify( #"skipped_01" );
        
        if ( isdefined( var_1f372b50.s_waypoint ) )
        {
            objectives::complete( "armada_obj_fly_to_firebase", var_1f372b50.s_waypoint );
        }
        
        level thread function_4f34fd5a( "player_controlled_huey_02" );
        
        if ( isdefined( var_1f372b50.var_5b419be2 ) )
        {
            level thread function_fb080e60( var_1f372b50.var_5b419be2 );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xf14aaafc, Offset: 0x90f8
// Size: 0x6c
function function_d3e80e12( var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
    function_a58d474d();
    level thread function_4f34fd5a( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x27b0c004, Offset: 0x9170
// Size: 0x22c
function function_f137e067( var_d3440450, var_50cc0d4f )
{
    var_1f372b50 = level.var_1f372b50;
    var_1f372b50 endon( #"skipped_02" );
    function_a291d0f( var_d3440450, var_50cc0d4f );
    level snd::client_msg( #"hash_4a41082a1d97f925" );
    level snd::client_msg( #"hash_551e8554285c2305" );
    level thread function_1f62aab9();
    level thread function_5bb16651();
    level thread function_8ecb23a6();
    level thread function_831cc5dd();
    level thread function_7114ce1c();
    level thread function_950dfa27();
    level thread function_bc837f16();
    level thread function_83bef370();
    level thread function_a07b71e6();
    level thread function_98eff2b2();
    level thread function_ebee939e();
    level thread function_e9c43f6();
    level thread function_95b8f3db();
    level thread function_1f9ef370();
    level flag::wait_till( "flag_pch_complete" );
    var_1f372b50.var_9055e2fa = 1;
    skipto::function_4e3ab877( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x71b42430, Offset: 0x93a8
// Size: 0x64
function function_1f62aab9()
{
    level.var_1f372b50 endon( #"skipped_02" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        level thread function_f8b8cec5( i );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x78010f66, Offset: 0x9418
// Size: 0xe4
function function_f8b8cec5( n_index )
{
    level.var_1f372b50 endon( #"skipped_02" );
    var_ff72be84 = spawner::simple_spawn_single( "sp_vh_pch_convoy_03", &function_125c7964, n_index );
    level flag::wait_till( "flag_pch_cleanup_post_bridge" );
    
    if ( isvehicle( var_ff72be84 ) )
    {
        var_a974a435 = var_ff72be84 vehicle::function_86c7bebb();
        function_fb080e60( var_a974a435 );
    }
    
    function_fb080e60( var_ff72be84 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x5a522ef5, Offset: 0x9508
// Size: 0x94
function function_125c7964( n_index )
{
    self endon( #"death" );
    self function_b3dd6259( undefined, 0 );
    var_8be533d2 = "nd_pch_convoy_03_0" + n_index + 1;
    nd_path = getvehiclenode( var_8be533d2, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_path );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xbfd7ce0f, Offset: 0x95a8
// Size: 0x31c
function function_1dcb11bb()
{
    level.var_1f372b50 endon( #"skipped_02" );
    level flag::wait_till( "flag_pch_dock_defenders_01" );
    a_ai_spawned = [];
    s_spawn = struct::get( "s_pch_dock_defenders_01_lmg_01" );
    var_76eba732 = spawner::simple_spawn_single( "sp_pch_dock_defenders_01_lmg", &function_b3dd6259, s_spawn );
    
    if ( !isdefined( a_ai_spawned ) )
    {
        a_ai_spawned = [];
    }
    else if ( !isarray( a_ai_spawned ) )
    {
        a_ai_spawned = array( a_ai_spawned );
    }
    
    a_ai_spawned[ a_ai_spawned.size ] = var_76eba732;
    wait 0.5;
    s_spawn = struct::get( "s_pch_dock_defenders_01_rpg_01" );
    var_ecd7dd18 = spawner::simple_spawn_single( "sp_pch_dock_defenders_01_rpg", &function_b3dd6259, s_spawn );
    
    if ( !isdefined( a_ai_spawned ) )
    {
        a_ai_spawned = [];
    }
    else if ( !isarray( a_ai_spawned ) )
    {
        a_ai_spawned = array( a_ai_spawned );
    }
    
    a_ai_spawned[ a_ai_spawned.size ] = var_ecd7dd18;
    wait 0.5;
    s_spawn = struct::get( "s_pch_dock_defenders_01_ar_01" );
    var_9adfb7ff = spawner::simple_spawn_single( "sp_pch_dock_defenders_01_ar", &function_b3dd6259, s_spawn );
    
    if ( !isdefined( a_ai_spawned ) )
    {
        a_ai_spawned = [];
    }
    else if ( !isarray( a_ai_spawned ) )
    {
        a_ai_spawned = array( a_ai_spawned );
    }
    
    a_ai_spawned[ a_ai_spawned.size ] = var_9adfb7ff;
    wait 0.5;
    s_spawn = struct::get( "s_pch_dock_defenders_01_ar_02" );
    var_8b219883 = spawner::simple_spawn_single( "sp_pch_dock_defenders_01_ar", &function_b3dd6259, s_spawn );
    
    if ( !isdefined( a_ai_spawned ) )
    {
        a_ai_spawned = [];
    }
    else if ( !isarray( a_ai_spawned ) )
    {
        a_ai_spawned = array( a_ai_spawned );
    }
    
    a_ai_spawned[ a_ai_spawned.size ] = var_8b219883;
    level flag::wait_till( "flag_pch_cleanup_post_bridge" );
    function_fb080e60( a_ai_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x87c50f77, Offset: 0x98d0
// Size: 0x25c
function function_2b782d15()
{
    level.var_1f372b50 endon( #"skipped_02" );
    a_ai_spawned = [];
    s_spawn = struct::get( "s_pch_dock_defenders_02_ar_01" );
    var_9adfb7ff = spawner::simple_spawn_single( "sp_pch_dock_defenders_02_ar", &function_b3dd6259, s_spawn );
    
    if ( !isdefined( a_ai_spawned ) )
    {
        a_ai_spawned = [];
    }
    else if ( !isarray( a_ai_spawned ) )
    {
        a_ai_spawned = array( a_ai_spawned );
    }
    
    a_ai_spawned[ a_ai_spawned.size ] = var_9adfb7ff;
    s_spawn = struct::get( "s_pch_dock_defenders_02_lmg_01" );
    var_76eba732 = spawner::simple_spawn_single( "sp_pch_dock_defenders_02_lmg", &function_b3dd6259, s_spawn );
    
    if ( !isdefined( a_ai_spawned ) )
    {
        a_ai_spawned = [];
    }
    else if ( !isarray( a_ai_spawned ) )
    {
        a_ai_spawned = array( a_ai_spawned );
    }
    
    a_ai_spawned[ a_ai_spawned.size ] = var_76eba732;
    s_spawn = struct::get( "s_pch_dock_defenders_02_rpg_01" );
    var_ecd7dd18 = spawner::simple_spawn_single( "sp_pch_dock_defenders_02_rpg", &function_b3dd6259, s_spawn, undefined, 0 );
    
    if ( !isdefined( a_ai_spawned ) )
    {
        a_ai_spawned = [];
    }
    else if ( !isarray( a_ai_spawned ) )
    {
        a_ai_spawned = array( a_ai_spawned );
    }
    
    a_ai_spawned[ a_ai_spawned.size ] = var_ecd7dd18;
    var_ecd7dd18 thread function_dbefbd4f();
    level flag::wait_till( "flag_pch_cleanup_post_bridge" );
    function_fb080e60( a_ai_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xc6a86468, Offset: 0x9b38
// Size: 0x11c
function function_dbefbd4f()
{
    self endon( #"death" );
    self val::set( "pch_ignoreall", "ignoreall", 1 );
    self setgoal( self.origin, 1 );
    level flag::wait_till( "flag_pch_dock_defenders_02" );
    nd_goal = getnode( "nd_pch_dock_defenders_02_rpg_01", "targetname" );
    self setgoal( nd_goal, 1 );
    self waittill( #"goal" );
    self val::reset( "pch_ignoreall", "ignoreall" );
    self function_c9e47ce7();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xff21593c, Offset: 0x9c60
// Size: 0x74
function function_5bb16651()
{
    level.var_1f372b50 endon( #"skipped_02" );
    a_ai_spawned = function_ca66dab0( "sp_pch_boat_02" );
    level flag::wait_till( "flag_pch_cleanup_post_bridge" );
    function_fb080e60( a_ai_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x952c9ef7, Offset: 0x9ce0
// Size: 0xbc
function function_8ecb23a6()
{
    level.var_1f372b50 endon( #"skipped_02" );
    var_27240fa9 = spawner::simple_spawn( "sp_vh_pch_village_defenders_01", &function_b3dd6259 );
    a_ai_spawned = function_ca66dab0( "sp_pch_village_defenders_01" );
    level flag::wait_till( "flag_pch_cleanup_post_bridge" );
    function_fb080e60( a_ai_spawned );
    function_fb080e60( var_27240fa9 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x84c20d65, Offset: 0x9da8
// Size: 0x74
function function_831cc5dd()
{
    level.var_1f372b50 endon( #"skipped_02" );
    a_ai_spawned = function_ca66dab0( "sp_pch_building_defenders_02" );
    level flag::wait_till( "flag_pch_cleanup_post_bridge" );
    function_fb080e60( a_ai_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xc7ee5d89, Offset: 0x9e28
// Size: 0x204
function function_f65c67e2()
{
    level.var_1f372b50 endon( #"skipped_02" );
    
    for ( i = 0; i < 2 ; i++ )
    {
        level thread function_c890913( i );
    }
    
    a_ai_spawned = function_ca66dab0( "sp_pch_runners_04" );
    
    foreach ( i, ai_spawned in a_ai_spawned )
    {
        ai_spawned thread function_b014a9f7( i );
    }
    
    level flag::wait_till( "flag_pch_runners_04_look_at" );
    var_71d2a694 = struct::get( "s_pch_runners_04_look_at" );
    
    while ( true )
    {
        if ( level.player util::is_player_looking_at( var_71d2a694.origin, undefined, 1, level.var_53bb8ef2.var_78bd98cb ) || level flag::get( "flag_pch_runners_04_move" ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    level flag::set( "flag_pch_runners_04_move" );
    level flag::wait_till( "flag_pch_runners_04_cleanup" );
    function_fb080e60( a_ai_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x8335ddb8, Offset: 0xa038
// Size: 0xe4
function function_c890913( n_index )
{
    level.var_1f372b50 endon( #"skipped_02" );
    var_ff72be84 = spawner::simple_spawn_single( "sp_vh_pch_runners_04", &function_6f5d3d68, n_index );
    level flag::wait_till( "flag_pch_runners_04_cleanup" );
    
    if ( isvehicle( var_ff72be84 ) )
    {
        var_a974a435 = var_ff72be84 vehicle::function_86c7bebb();
        function_fb080e60( var_a974a435 );
    }
    
    function_fb080e60( var_ff72be84 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x7ec7dd21, Offset: 0xa128
// Size: 0xe4
function function_6f5d3d68( n_index )
{
    self endon( #"death" );
    self function_b3dd6259( undefined, 0 );
    var_8be533d2 = "nd_pch_runners_04_trucks_0" + n_index + 1;
    nd_path = getvehiclenode( var_8be533d2, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_path );
    self vehicle::pause_path();
    level flag::wait_till( "flag_pch_runners_04_move" );
    self vehicle::resume_path();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x95f7d278, Offset: 0xa218
// Size: 0x2ec
function function_b014a9f7( n_index )
{
    self endon( #"death" );
    var_e6fe2893 = getnodearray( "nd_pch_runners_04_mid", "targetname" );
    var_ee1446ea = 0;
    var_f341ce5b = -1;
    
    while ( true )
    {
        var_7ca4c705 = var_f341ce5b - 0.01;
        var_6a0f072d = var_f341ce5b + 0.01;
        
        foreach ( var_c54ff397 in var_e6fe2893 )
        {
            n_dot = self math::get_dot_forward( var_c54ff397.origin );
            
            if ( n_dot >= max( -1, var_7ca4c705 ) && n_dot <= min( 0, var_6a0f072d ) )
            {
                var_ee1446ea = 1;
                break;
            }
        }
        
        if ( var_ee1446ea )
        {
            break;
        }
        
        var_f341ce5b += 0.01;
        
        if ( var_f341ce5b >= 0 )
        {
            var_c54ff397 = array::random( var_e6fe2893 );
            break;
        }
        
        waitframe( 1 );
    }
    
    var_903daa83 = getnodearray( "nd_pch_runners_04_end", "targetname" );
    var_903daa83 = array::sort_by_script_int( var_903daa83, 1 );
    nd_end = var_903daa83[ n_index + 1 ];
    level flag::wait_till( "flag_pch_runners_04_move" );
    self setgoal( var_c54ff397, 1 );
    
    while ( distance2dsquared( self.origin, var_c54ff397.origin ) >= sqr( 256 ) )
    {
        waitframe( 1 );
    }
    
    self setgoal( nd_end, 1 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xaa735be8, Offset: 0xa510
// Size: 0x7c
function function_7114ce1c()
{
    level.var_1f372b50 endon( #"skipped_02" );
    level flag::wait_till( "flag_pch_convoy_04_spawn" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        level thread function_6fb6b4a( i );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x1ab47fb5, Offset: 0xa598
// Size: 0x94
function function_6fb6b4a( n_index )
{
    level.var_1f372b50 endon( #"skipped_02" );
    var_ff72be84 = spawner::simple_spawn_single( "sp_vh_pch_convoy_04", &function_6a418e77, n_index );
    level flag::wait_till( "flag_pch_convoy_04_cleanup" );
    function_fb080e60( var_ff72be84 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x97c2d449, Offset: 0xa638
// Size: 0xe4
function function_6a418e77( n_index )
{
    self endon( #"death" );
    self function_b3dd6259( undefined, 0 );
    var_8be533d2 = "nd_pch_convoy_04_0" + n_index + 1;
    nd_path = getvehiclenode( var_8be533d2, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_path );
    self vehicle::pause_path();
    level flag::wait_till( "flag_pch_convoy_04_move" );
    self vehicle::resume_path();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x67498370, Offset: 0xa728
// Size: 0x2b4
function function_950dfa27()
{
    level.var_1f372b50 endon( #"skipped_02" );
    level flag::wait_till( "flag_pch_rpg_alley_01" );
    a_ai_spawned = function_ca66dab0( "sp_pch_rpg_alley_01" );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        ai_spawned callback::function_d8abfc3d( #"on_ai_killed", &function_7cedc5e );
    }
    
    var_1d108160 = getentarray( "t_pch_rpg_alley_01_damage", "targetname" );
    
    foreach ( t_damage in var_1d108160 )
    {
        t_damage thread function_689a7627( a_ai_spawned );
    }
    
    level flag::wait_till( "flag_pch_rpg_valley_01_cleanup" );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        while ( isalive( ai_spawned ) && level.player util::is_player_looking_at( ai_spawned.origin, undefined, 1, ai_spawned, level.var_53bb8ef2.var_78bd98cb ) )
        {
            waitframe( 1 );
        }
        
        function_fb080e60( ai_spawned );
    }
    
    function_fb080e60( var_1d108160 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x2baf1334, Offset: 0xa9e8
// Size: 0x6c
function function_7cedc5e( *s_params )
{
    self magicmissile( getweapon( #"launcher_standard_t9" ), self.origin + ( 0, 0, 32 ), anglestoup( self.angles ) * -2000 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x10cdb5ee, Offset: 0xaa60
// Size: 0x140
function function_689a7627( a_ai_spawned )
{
    self endon( #"death" );
    
    while ( true )
    {
        s_waitresult = self waittill( #"damage" );
        
        if ( isplayer( s_waitresult.attacker ) )
        {
            break;
        }
    }
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( isalive( ai_spawned ) && ai_spawned istouching( self ) )
        {
            ai_spawned kill( s_waitresult.position, s_waitresult.attacker, s_waitresult.inflictor, s_waitresult.weapon );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x43b6b8e5, Offset: 0xaba8
// Size: 0xfc
function function_bc837f16()
{
    level.var_1f372b50 endon( #"skipped_02" );
    level flag::wait_till( "flag_pch_village_defenders_02_01" );
    var_abc28788 = function_ca66dab0( "sp_pch_village_defenders_02", "s_pch_village_defenders_02_01" );
    level flag::wait_till( "flag_pch_village_defenders_02_02" );
    var_9817e033 = function_ca66dab0( "sp_pch_village_defenders_02", "s_pch_village_defenders_02_02" );
    level flag::wait_till( "flag_pch_village_defenders_02_cleanup" );
    function_fb080e60( var_abc28788 );
    function_fb080e60( var_9817e033 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xa72f27a1, Offset: 0xacb0
// Size: 0x154
function function_83bef370()
{
    level.var_1f372b50 endon( #"skipped_02" );
    level flag::wait_till( "flag_pch_convoy_05_spawn" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        level thread function_ed3237b8( i );
    }
    
    level flag::wait_till( "flag_pch_convoy_05_look_at" );
    var_71d2a694 = struct::get( "s_pch_convoy_05_look_at" );
    
    while ( true )
    {
        if ( level.player util::is_player_looking_at( var_71d2a694.origin, undefined, 1, level.var_53bb8ef2.var_78bd98cb ) || level flag::get( "flag_pch_convoy_05_move" ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    level flag::set( "flag_pch_convoy_05_move" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x88c0b81c, Offset: 0xae10
// Size: 0x5e
function function_ed3237b8( n_index )
{
    level.var_1f372b50 endon( #"skipped_02" );
    var_ff72be84 = spawner::simple_spawn_single( "sp_vh_pch_convoy_05", &function_4babc824, n_index );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xa2dd13f8, Offset: 0xae78
// Size: 0xe4
function function_4babc824( n_index )
{
    self endon( #"death" );
    self function_b3dd6259( undefined, 0 );
    var_8be533d2 = "nd_pch_convoy_05_0" + n_index + 1;
    nd_path = getvehiclenode( var_8be533d2, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_path );
    self vehicle::pause_path();
    level flag::wait_till( "flag_pch_convoy_05_move" );
    self vehicle::resume_path();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x6615cd46, Offset: 0xaf68
// Size: 0xb4
function function_eb45b20c()
{
    if ( !isdefined( level.var_1f372b50.var_e1f9d938 ) )
    {
        level.var_1f372b50.var_e1f9d938 = [];
    }
    else if ( !isarray( level.var_1f372b50.var_e1f9d938 ) )
    {
        level.var_1f372b50.var_e1f9d938 = array( level.var_1f372b50.var_e1f9d938 );
    }
    
    level.var_1f372b50.var_e1f9d938[ level.var_1f372b50.var_e1f9d938.size ] = self;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x3d5bc8cd, Offset: 0xb028
// Size: 0xb4
function function_56a193e6()
{
    if ( !isdefined( level.var_1f372b50.var_a17927ca ) )
    {
        level.var_1f372b50.var_a17927ca = [];
    }
    else if ( !isarray( level.var_1f372b50.var_a17927ca ) )
    {
        level.var_1f372b50.var_a17927ca = array( level.var_1f372b50.var_a17927ca );
    }
    
    level.var_1f372b50.var_a17927ca[ level.var_1f372b50.var_a17927ca.size ] = self;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x88f1e127, Offset: 0xb0e8
// Size: 0x124
function function_98eff2b2()
{
    var_1f372b50 = level.var_1f372b50;
    var_1f372b50 endon( #"skipped_02" );
    s_waitresult = level flag::wait_till_any( [ "flag_pch_left_pass_cleanup", "flag_pch_right_pass_cleanup" ] );
    
    if ( s_waitresult._notify == "flag_pch_left_pass_cleanup" )
    {
        var_1f372b50 notify( #"left_pass_cleanup" );
        var_b6fdd6f2 = isdefined( var_1f372b50.var_e1f9d938 ) ? var_1f372b50.var_e1f9d938 : [];
    }
    else
    {
        var_1f372b50 notify( #"right_pass_cleanup" );
        var_b6fdd6f2 = isdefined( var_1f372b50.var_a17927ca ) ? var_1f372b50.var_a17927ca : [];
    }
    
    function_fb080e60( var_b6fdd6f2 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x350d182a, Offset: 0xb218
// Size: 0x18c
function function_a07b71e6()
{
    level.var_1f372b50 endon( #"skipped_02", #"left_pass_cleanup" );
    level flag::wait_till( "flag_pch_bend_sentry_01" );
    var_ff72be84 = spawner::simple_spawn_single( "sp_vh_bend_sentry_01", &function_b3dd6259 );
    
    if ( isdefined( var_ff72be84 ) )
    {
        var_ff72be84 function_eb45b20c();
    }
    
    a_ai_spawned = function_ca66dab0( "sp_pch_bend_sentry_01" );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        ai_spawned function_eb45b20c();
    }
    
    level flag::wait_till( "flag_pch_bend_sentry_01_cleanup" );
    function_fb080e60( var_ff72be84 );
    function_fb080e60( a_ai_spawned );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x92c3282a, Offset: 0xb3b0
// Size: 0xf0
function function_ebee939e()
{
    level.var_1f372b50 endon( #"skipped_02", #"left_pass_cleanup" );
    level flag::wait_till( "flag_pch_left_pass_01" );
    a_ai_spawned = function_ca66dab0( "sp_pch_left_pass_01" );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        ai_spawned function_eb45b20c();
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xe637f912, Offset: 0xb4a8
// Size: 0x1fc
function function_e81b4b60()
{
    level.var_1f372b50 endon( #"skipped_02" );
    s_waitresult = level flag::wait_till_any( [ "flag_pch_runners_05_spawn", "flag_pch_runners_05_force" ] );
    a_ai_spawned = function_ca66dab0( "sp_pch_runners_05", undefined, 1, 0 );
    
    foreach ( i, ai_spawned in a_ai_spawned )
    {
        ai_spawned thread function_add898c5( i );
    }
    
    if ( s_waitresult._notify == "flag_pch_runners_05_spawn" )
    {
        level flag::wait_till( "flag_pch_runners_05_look_at" );
        var_71d2a694 = struct::get( "s_pch_runners_05_look_at" );
        
        while ( true )
        {
            if ( level.player util::is_player_looking_at( var_71d2a694.origin, undefined, 1, level.var_53bb8ef2.var_78bd98cb ) || level flag::get( "flag_pch_runners_05_move" ) )
            {
                break;
            }
            
            waitframe( 1 );
        }
    }
    
    level flag::set( "flag_pch_runners_05_move" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xabc7dbb1, Offset: 0xb6b0
// Size: 0x4a4
function function_add898c5( n_index )
{
    self endon( #"death" );
    self val::set( "pch_ignoreall", "ignoreall", 1 );
    var_59f6ca7 = undefined;
    var_dcc29aee = undefined;
    
    for ( i = 0; i < 2 ; i++ )
    {
        switch ( i )
        {
            case 0:
                var_98a868e9 = self;
                var_b9149645 = "nd_pch_runners_05_mid_01";
                break;
            case 1:
                var_98a868e9 = var_59f6ca7;
                var_b9149645 = "nd_pch_runners_05_mid_02";
                break;
        }
        
        var_e6fe2893 = getnodearray( var_b9149645, "targetname" );
        var_ee1446ea = 0;
        var_f341ce5b = -1;
        
        while ( true )
        {
            var_7ca4c705 = var_f341ce5b - 0.01;
            var_6a0f072d = var_f341ce5b + 0.01;
            
            foreach ( var_c54ff397 in var_e6fe2893 )
            {
                n_dot = var_98a868e9 math::get_dot_forward( var_c54ff397.origin );
                
                if ( n_dot >= max( -1, var_7ca4c705 ) && n_dot <= min( 0, var_6a0f072d ) )
                {
                    var_ee1446ea = 1;
                    break;
                }
            }
            
            if ( var_ee1446ea )
            {
                break;
            }
            
            var_f341ce5b += 0.01;
            
            if ( var_f341ce5b >= 0 )
            {
                var_c54ff397 = array::random( var_e6fe2893 );
                break;
            }
            
            waitframe( 1 );
        }
        
        switch ( i )
        {
            case 0:
                var_59f6ca7 = var_c54ff397;
                break;
            case 1:
                var_dcc29aee = var_c54ff397;
                break;
        }
    }
    
    var_903daa83 = getnodearray( "nd_pch_runners_05_end", "targetname" );
    var_903daa83 = array::sort_by_script_int( var_903daa83, 1 );
    nd_end = var_903daa83[ n_index + 1 ];
    level flag::wait_till( "flag_pch_runners_05_move" );
    
    for ( i = 0; i < 2 ; i++ )
    {
        switch ( i )
        {
            case 0:
                nd_goal = var_59f6ca7;
                break;
            case 1:
                self val::reset( "pch_ignoreall", "ignoreall" );
                nd_goal = var_dcc29aee;
                break;
        }
        
        self setgoal( nd_goal, 1 );
        
        while ( distance2dsquared( self.origin, nd_goal.origin ) >= sqr( 256 ) )
        {
            waitframe( 1 );
        }
    }
    
    self setgoal( nd_end, 1 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xb4b0033e, Offset: 0xbb60
// Size: 0x17c
function function_1f9ef370()
{
    assert( isdefined( getent( "<dev string:x77>", "<dev string:x8b>" ) ), "<dev string:x99>" );
    level.enemy_heli = vehicle::simple_spawn_single( "spawner_rus_heli" );
    flag::set( "fighting_hind" );
    level.enemy_heli thread function_c0841e82();
    level.enemy_heli thread function_f5d90d3c( level.var_53bb8ef2.var_78bd98cb );
    
    while ( !level flag::get( "hind_destroyed" ) )
    {
        if ( isdefined( level.var_53bb8ef2.var_78bd98cb ) )
        {
            if ( !isdefined( level.enemy_heli.favoriteenemy ) || level.enemy_heli.favoriteenemy != level.var_53bb8ef2.var_78bd98cb )
            {
                level.enemy_heli.favoriteenemy = level.var_53bb8ef2.var_78bd98cb;
            }
        }
        
        wait 1;
    }
    
    level flag::wait_till( "hind_destroyed" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xb22e16d2, Offset: 0xbce8
// Size: 0x54
function function_c0841e82()
{
    self waittill( #"death" );
    level flag::clear( "fighting_hind" );
    level flag::set( "hind_destroyed" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x8ba0fc5f, Offset: 0xbd48
// Size: 0x54
function function_f5d90d3c( enemy )
{
    self endon( #"death" );
    enemy waittill( #"death" );
    self vehicle_ai::set_state( "scripted" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0x7c4747a9, Offset: 0xbda8
// Size: 0x2e
function function_42907288( *var_d3440450, *var_50cc0d4f, var_aa1a6455, *e_player )
{
    if ( !e_player )
    {
        return;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0xbdcd4165, Offset: 0xbde0
// Size: 0x16c
function function_b839a88b( *var_d3440450, *var_50cc0d4f, var_aa1a6455, *e_player )
{
    if ( !e_player )
    {
        return;
    }
    
    var_1f372b50 = level.var_1f372b50;
    
    if ( !is_true( var_1f372b50.var_9055e2fa ) )
    {
        var_1f372b50 notify( #"skipped_02" );
        
        if ( isdefined( var_1f372b50.s_waypoint ) )
        {
            objectives::complete( "armada_obj_fly_to_firebase", var_1f372b50.s_waypoint );
        }
        
        s_teleport = struct::get( "heli_spawn_firebase_defend", "script_noteworthy" );
        level.var_53bb8ef2.var_78bd98cb.origin = s_teleport.origin;
        level.var_53bb8ef2.var_78bd98cb.angles = s_teleport.angles;
        
        if ( isdefined( var_1f372b50.var_8b8c7c77 ) )
        {
            level thread function_fb080e60( var_1f372b50.var_8b8c7c77 );
        }
    }
    
    if ( isdefined( var_1f372b50.var_b6fdd6f2 ) )
    {
        level thread function_fb080e60( var_1f372b50.var_b6fdd6f2 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 8
// Checksum 0xcdbcff3c, Offset: 0xbf58
// Size: 0x1e4
function function_aa2f407c( var_3ba94e96, str_spawns, var_86a56d5f = 1, var_9f1d53c7 = 1, spawn_func, arg1, arg2, arg3 )
{
    a_ai_spawned = function_d305a607( var_3ba94e96, str_spawns, var_86a56d5f, var_9f1d53c7, spawn_func, arg1, arg2, arg3 );
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( !isdefined( level.var_9051f4a3.var_b6fdd6f2 ) )
        {
            level.var_9051f4a3.var_b6fdd6f2 = [];
        }
        else if ( !isarray( level.var_9051f4a3.var_b6fdd6f2 ) )
        {
            level.var_9051f4a3.var_b6fdd6f2 = array( level.var_9051f4a3.var_b6fdd6f2 );
        }
        
        level.var_9051f4a3.var_b6fdd6f2[ level.var_9051f4a3.var_b6fdd6f2.size ] = ai_spawned;
        
        if ( isactor( ai_spawned ) )
        {
            ai_spawned thread function_a3c825cd();
        }
    }
    
    return a_ai_spawned;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xdc898de6, Offset: 0xc148
// Size: 0x44
function function_46c0f651( *var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x69411dda, Offset: 0xc198
// Size: 0x5f4
function function_dc1d0dfb( var_d3440450, var_50cc0d4f )
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    namespace_72b0499b::music( "tmp_player_heli_hillside", 2 );
    level snd::client_msg( #"hash_4a41082a1d97f925" );
    level snd::client_msg( #"hash_551e8554285c2305" );
    function_a291d0f( var_d3440450, var_50cc0d4f );
    
    if ( var_50cc0d4f )
    {
        /#
            if ( getdvarint( #"hash_3b90a67ea0b6081b", 0 ) >= 2 )
            {
                level.player val::set( #"hash_ca2667067306cf1", "<dev string:xdd>", 1 );
                level.player val::set( #"hash_ca2667067306cf1", "<dev string:xe9>", 0 );
                level.player val::set( #"hash_ca2667067306cf1", "<dev string:xf7>", 0 );
                n_seat = level.var_53bb8ef2.var_78bd98cb getoccupantseat( level.player );
                
                if ( isdefined( n_seat ) && n_seat >= 0 )
                {
                    level.var_53bb8ef2.var_78bd98cb usevehicle( level.player, n_seat );
                }
                
                var_f98108c1 = struct::get( #"hash_6839f84b984b36ff" );
                level.player setorigin( var_f98108c1.origin );
                level.player setplayerangles( var_f98108c1.angles );
            }
        #/
    }
    
    var_9051f4a3.var_b6fdd6f2 = [];
    var_9051f4a3.var_79de6b64 = [];
    level thread function_225a40cf();
    var_9051f4a3.var_fa4eb7a2[ #"allies" ] = [];
    var_9051f4a3.var_fa4eb7a2[ #"axis" ] = [];
    var_1eec0c8f = struct::get_array( #"hash_61e69f91e24777c8" );
    
    foreach ( var_73e7cb9a in var_1eec0c8f )
    {
        var_2cd0eff2 = util::spawn_model( #"tag_origin", var_73e7cb9a.origin );
        var_2cd0eff2 makesentient();
        var_2cd0eff2 setteam( #"allies" );
        
        if ( !isdefined( var_9051f4a3.var_fa4eb7a2[ #"allies" ] ) )
        {
            var_9051f4a3.var_fa4eb7a2[ #"allies" ] = [];
        }
        else if ( !isarray( var_9051f4a3.var_fa4eb7a2[ #"allies" ] ) )
        {
            var_9051f4a3.var_fa4eb7a2[ #"allies" ] = array( var_9051f4a3.var_fa4eb7a2[ #"allies" ] );
        }
        
        var_9051f4a3.var_fa4eb7a2[ #"allies" ][ var_9051f4a3.var_fa4eb7a2[ #"allies" ].size ] = var_2cd0eff2;
        
        if ( !isdefined( var_9051f4a3.var_b6fdd6f2 ) )
        {
            var_9051f4a3.var_b6fdd6f2 = [];
        }
        else if ( !isarray( var_9051f4a3.var_b6fdd6f2 ) )
        {
            var_9051f4a3.var_b6fdd6f2 = array( var_9051f4a3.var_b6fdd6f2 );
        }
        
        var_9051f4a3.var_b6fdd6f2[ var_9051f4a3.var_b6fdd6f2.size ] = var_2cd0eff2;
    }
    
    level thread function_2a10e512();
    level thread function_755d640();
    level thread function_2f5a4827();
    level thread function_1fcee01d();
    
    if ( var_50cc0d4f )
    {
        level thread function_e9c43f6( 0 );
        level thread function_95b8f3db( 0 );
    }
    
    level flag::wait_till( #"hash_494514617379bbdf" );
    var_9051f4a3.b_completed = 1;
    skipto::function_4e3ab877( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 3
// Checksum 0x37a6e0c8, Offset: 0xc798
// Size: 0x104
function function_158cdaa( s_spawn, var_86a56d5f = 1, var_9f1d53c7 = 1 )
{
    self function_6cf6a8c2( s_spawn, var_86a56d5f, var_9f1d53c7 );
    
    if ( !isdefined( level.var_9051f4a3.var_b6fdd6f2 ) )
    {
        level.var_9051f4a3.var_b6fdd6f2 = [];
    }
    else if ( !isarray( level.var_9051f4a3.var_b6fdd6f2 ) )
    {
        level.var_9051f4a3.var_b6fdd6f2 = array( level.var_9051f4a3.var_b6fdd6f2 );
    }
    
    level.var_9051f4a3.var_b6fdd6f2[ level.var_9051f4a3.var_b6fdd6f2.size ] = self;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x657b149e, Offset: 0xc8a8
// Size: 0xc4c
function function_225a40cf()
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    function_a98e77d5( #"hash_b834223b7fc2a04", 5, #"hash_376991c319a40802", #"hash_45eb3523a752609e", #"hash_45eb3423a7525eeb", "sp_ripcord_breach_01_01_vc", "vol_ripcord_breach_01_kill" );
    function_a98e77d5( #"hash_b834523b7fc2f1d", 5, #"hash_376991c319a40802", #"hash_6331e355463731b3", #"hash_6331e45546373366", "sp_ripcord_breach_01_02_vc", "vol_ripcord_breach_01_kill" );
    function_a98e77d5( #"hash_b834423b7fc2d6a", 5, #"hash_376991c319a40802", #"hash_1a3974af0f424030", #"hash_1a3977af0f424549", "sp_ripcord_breach_01_03_vc", "vol_ripcord_breach_01_kill" );
    function_a98e77d5( #"breach_02", 5, #"hash_44b60e500cfd1235", #"hash_3a28dc4da7ef3d85", #"hash_3a28d94da7ef386c", "sp_ripcord_breach_02_vc", "vol_ripcord_breach_02_kill" );
    function_a98e77d5( #"breach_03", 5, #"hash_7820f7ffc3673e84", #"hash_60b6e389af747cca", #"hash_60b6e289af747b17", "sp_ripcord_breach_03_vc", "vol_ripcord_breach_03_kill" );
    function_a98e77d5( #"breach_04", 5, #"hash_22e28bfd5bdc7bc7", #"hash_3b782f73edc28cdb", #"hash_3b783073edc28e8e", "sp_ripcord_breach_04_vc", "vol_ripcord_breach_04_kill" );
    function_a98e77d5( #"south_flank_runners", 5, #"hash_1d9525aee2777a29", #"hash_4e538981f4a67329", #"hash_4e538681f4a66e10", "sp_ripcord_south_flank_runners", "vol_ripcord_south_flank_runners_kill" );
    var_79de6b64 = struct::get_array( #"hash_cf5f0a7b582f11d", "script_noteworthy" );
    
    foreach ( s_mortar in var_79de6b64 )
    {
        s_mortar thread function_cffa5653();
    }
    
    level thread function_ef4f929e();
    level thread function_b72590f1();
    
    /#
        if ( getdvarint( #"hash_3b90a67ea0b6081b", 0 ) >= 2 )
        {
            level flag::set( #"hash_490bc7407722903d" );
        }
    #/
    
    level flag::wait_till( #"hash_490bc7407722903d" );
    objectives::scripted( #"hash_3e1e8f33287f0c8", undefined, #"hash_44e6ef7cc513f30a" );
    level flag::set( #"hash_2edfaf196e292488" );
    level thread function_aaa7f178( var_79de6b64 );
    level thread function_330ed1b();
    level flag::wait_till_all( [ #"hash_4677c88fea5b7ac1", #"hash_117c4bfa27ee83b7" ] );
    level notify( #"hash_92ae6c009d7f9e1" );
    level flag::set( #"hash_2c292d90841ea555" );
    level flag::set( #"hash_624585ec0b1e15fa" );
    level flag::set( #"hash_eeac05ac492404c" );
    level flag::set( #"hash_5b9375a85ac4aa60" );
    spawner::simple_spawn_single( "sp_ripcord_support_huey_04", &function_ca16a858 );
    wait 2;
    level thread savegame::checkpoint_save( 1 );
    objectives::scripted( #"hash_4456b15b5561ff72", undefined, #"hash_61eb08daf30d45b8" );
    objectives::function_6a5ca7ac( #"hash_4456b15b5561ff72", undefined, #"hash_3e1e8f33287f0c8" );
    s_obj = struct::get( #"hash_1e9c89c7e88596" );
    objectives::function_4eb5c04a( #"hash_2219bd003d6556ce", s_obj.origin );
    level thread function_330ed1b();
    level flag::set( #"hash_77c17e91c8956ded" );
    level flag::wait_till( #"hash_6dfec0bfb77bdbe9" );
    spawner::simple_spawn_single( "sp_ripcord_support_huey_05", &function_cfa8bf1a );
    var_d79d42a = struct::get( #"hash_2cf7bd8c70b57c23" );
    var_d79d42a thread function_e00566fd( undefined, 1 );
    var_fbcb30cd = struct::get( #"hash_2cf7be8c70b57dd6" );
    var_fbcb30cd thread function_e00566fd( undefined, 1 );
    var_b2f49f21 = struct::get( #"hash_2cf7bf8c70b57f89" );
    var_b2f49f21 thread function_e00566fd( undefined, 1 );
    level flag::set( #"hash_6262020fe28bc726" );
    level flag::set( #"hash_57c6ee97826e6249" );
    level thread function_c6b4b443();
    level thread function_1c6745b4();
    level thread function_2095821c();
    level thread function_330ed1b();
    level flag::wait_till_all( [ #"hash_655527a3d778dd1f", #"hash_60fbef66f73d44ea" ] );
    level notify( #"hash_92ae6c009d7f9e1" );
    level flag::set( #"hash_160f56c6d59d5917" );
    level thread function_4afd7dea();
    wait 2;
    level thread savegame::checkpoint_save( 1 );
    objectives::complete( #"hash_4456b15b5561ff72" );
    level flag::set( #"hash_250edc5195758370" );
    level thread function_330ed1b();
    level flag::wait_till( #"hash_9b54061312dc6ab" );
    level notify( #"hash_92ae6c009d7f9e1" );
    level flag::wait_till( #"hash_1ef3a1febf52c90e" );
    
    foreach ( str_name, s_breach in var_9051f4a3.var_6ae38a69 )
    {
        level flag::set( s_breach.var_62e5c9d9 );
        
        foreach ( var_4e75a347 in function_cf993931( str_name ) )
        {
            var_4e75a347 util::delay( randomfloatrange( 0.1, 2 ), undefined, &kill );
        }
    }
    
    foreach ( var_5b5d5258 in var_9051f4a3.var_79de6b64 )
    {
        if ( !var_5b5d5258 flag::get( #"destroyed" ) )
        {
            var_5b5d5258 thread function_e00566fd( undefined, 1 );
        }
    }
    
    level flag::wait_till( #"hash_2e43c4e93e07445c" );
    objectives::complete( #"hash_3e1e8f33287f0c8" );
    level flag::set( #"hash_494514617379bbdf" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x79296171, Offset: 0xd500
// Size: 0x2c
function function_1fcee01d()
{
    level.var_9051f4a3.var_8c393c78 = 0;
    level thread function_1b763158();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xc96e364d, Offset: 0xd538
// Size: 0x66
function function_53c1b17f( s_params )
{
    if ( isdefined( level.var_9051f4a3 ) && isplayer( s_params.eattacker ) && self.team === #"axis" )
    {
        level.var_9051f4a3.var_8c393c78 = 0;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0xf6d521dc, Offset: 0xd5a8
// Size: 0x11c
function function_56ca8045( n_damage, var_624c5691 = 1 )
{
    if ( !isdefined( n_damage ) )
    {
        return;
    }
    
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3.var_8c393c78 += n_damage;
    b_fail = 0;
    
    if ( var_624c5691 )
    {
        if ( var_9051f4a3.var_8c393c78 >= 12000 )
        {
            b_fail = 1;
        }
    }
    else if ( var_9051f4a3.var_8c393c78 >= 5000 )
    {
        b_fail = 1;
    }
    
    if ( b_fail )
    {
        level flag::set( #"hash_189bbc62bf947091" );
        level util::missionfailedwrapper( #"hash_73cee03662aa3257", #"hash_1dc08dcc638b30c0" );
        return;
    }
    
    level thread function_cdfbef90();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x20ce09b9, Offset: 0xd6d0
// Size: 0xe8
function function_1b763158()
{
    level endon( #"hash_189bbc62bf947091", #"hash_11ed3cb4b3a96f61" );
    level.var_9051f4a3 endon( #"skipped" );
    t_damage = getent( "t_ripcord_friendly_fire", "targetname" );
    
    while ( true )
    {
        s_waitresult = t_damage waittill( #"damage" );
        
        if ( isplayer( s_waitresult.attacker ) )
        {
            level thread function_56ca8045( s_waitresult.amount, 1 );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x72866532, Offset: 0xd7c0
// Size: 0xae
function function_cdfbef90()
{
    self notify( "63773bbc08e8e94a" );
    self endon( "63773bbc08e8e94a" );
    level endon( #"hash_189bbc62bf947091", #"hash_11ed3cb4b3a96f61" );
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    
    while ( var_9051f4a3.var_8c393c78 > 0 )
    {
        wait 1;
        var_9051f4a3.var_8c393c78 = max( 0, var_9051f4a3.var_8c393c78 - 250 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xa224df19, Offset: 0xd878
// Size: 0x8c
function function_330ed1b()
{
    self notify( "31bedb98cf31f3aa" );
    self endon( "31bedb98cf31f3aa" );
    level.var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_92ae6c009d7f9e1" );
    wait 120;
    level util::missionfailedwrapper( #"hash_3fe32a539067e0b5", #"hash_5ca05ccf36994b39" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x4374e552, Offset: 0xd910
// Size: 0x1be
function function_95b8f3db( var_d3479c0a = 1 )
{
    level.var_9051f4a3 endon( #"skipped" );
    
    if ( var_d3479c0a )
    {
        level flag::wait_till( #"hash_725325f3f3a86396" );
    }
    
    var_79aabf62 = spawnstruct();
    var_7233f141 = function_aa2f407c( "sp_ripcord_riverbank", #"hash_732ff4cd45a778b2", 0, 0, &function_9d49cee9, var_79aabf62 );
    level thread function_81f1554e( var_7233f141 );
    
    foreach ( s_targets in struct::get_array( #"hash_2627c72396ac93a2", "script_noteworthy" ) )
    {
        s_targets function_b369c458();
    }
    
    var_5073adc1 = function_aa2f407c( "sp_ripcord_riverbank", #"hash_732ff3cd45a776ff", 0, 0, &function_3e14be61 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x4d0b7b24, Offset: 0xdad8
// Size: 0x84
function function_81f1554e( var_549c5e7b )
{
    level.var_9051f4a3 endon( #"skipped" );
    level flag::wait_till( #"hash_2edfaf196e292488" );
    level thread function_8544c23e( var_549c5e7b, #"hash_5a9a73a0a639e2fc", #"hash_117c4bfa27ee83b7", 1 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0xe3830663, Offset: 0xdb68
// Size: 0x1b4
function function_8544c23e( var_549c5e7b, var_f95b722f, var_854f3b02, var_b253c927 = 0 )
{
    level.var_9051f4a3 endon( #"skipped" );
    function_1eaaceab( var_549c5e7b );
    
    if ( var_549c5e7b.size > 0 )
    {
        var_549c5e7b = array::sort_by_script_int( var_549c5e7b, 1 );
        objectives::kill( var_f95b722f, undefined, undefined, 0, 1, 0, #"hash_745f1c5e96b6668a" );
        
        foreach ( var_cd75ffd6 in var_549c5e7b )
        {
            if ( isalive( var_cd75ffd6 ) )
            {
                objectives::update_position( var_f95b722f, var_cd75ffd6 );
                var_cd75ffd6 waittill( #"death" );
                
                if ( var_b253c927 )
                {
                    break;
                }
            }
        }
        
        objectives::complete( var_f95b722f );
    }
    
    if ( isdefined( var_854f3b02 ) )
    {
        level flag::set( var_854f3b02 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xb4f8620a, Offset: 0xdd28
// Size: 0xdc
function function_9d49cee9( var_8d8a7b79 )
{
    self endon( #"death" );
    self function_1adc0121( var_8d8a7b79 );
    
    while ( !level flag::get( #"hash_6bb86ce8c2cb78e7" ) && !level.player util::is_player_looking_at( self.origin, 0.8, 1, self, level.var_53bb8ef2.var_78bd98cb ) )
    {
        waitframe( 1 );
    }
    
    level flag::set( #"hash_6bb86ce8c2cb78e7" );
    self vehicle::go_path();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xdf3f2a4e, Offset: 0xde10
// Size: 0x9c
function function_3e14be61()
{
    self endon( #"death" );
    self thread function_a7591bb2();
    level flag::wait_till( #"hash_6bb86ce8c2cb78e7" );
    self vehicle::go_path();
    level flag::wait_till( #"hash_6dfec0bfb77bdbe9" );
    self kill();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x699dd511, Offset: 0xdeb8
// Size: 0x8e
function function_a7591bb2()
{
    var_3a5fe677 = self.var_214db6bf.target;
    
    if ( isdefined( var_3a5fe677 ) )
    {
        var_990f249b = struct::get_array( var_3a5fe677 );
        
        if ( var_990f249b.size > 0 )
        {
            var_a974a435 = function_aa2f407c( "sp_ripcord_riverbank", var_3a5fe677, 1, 1, &function_88f16c5f, self );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x3ac9300, Offset: 0xdf50
// Size: 0x7c
function function_88f16c5f( var_ff72be84 )
{
    self endon( #"death" );
    self vehicle::get_in( self, var_ff72be84, "crew" );
    level flag::wait_till( #"hash_6dfec0bfb77bdbe9" );
    self thread ai::bloody_death();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x83b29f53, Offset: 0xdfd8
// Size: 0xfc
function function_b369c458()
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    
    if ( !isdefined( var_9051f4a3.var_a5757f71 ) )
    {
        var_9051f4a3.var_a5757f71 = [];
    }
    else if ( !isarray( var_9051f4a3.var_a5757f71 ) )
    {
        var_9051f4a3.var_a5757f71 = array( var_9051f4a3.var_a5757f71 );
    }
    
    var_9051f4a3.var_a5757f71[ var_9051f4a3.var_a5757f71.size ] = self;
    self.a_e_targets = function_aa2f407c( "sp_ripcord_riverbank", self.target );
    self thread function_bd1c6876();
    self thread function_947a3f54();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x2b720cdc, Offset: 0xe0e0
// Size: 0x1c4
function function_bd1c6876()
{
    level.var_9051f4a3 endon( #"skipped" );
    
    foreach ( struct in struct::get_array( self.target ) )
    {
        if ( struct.script_noteworthy === #"objective" )
        {
            s_obj = struct;
            break;
        }
    }
    
    if ( !isdefined( s_obj ) )
    {
        return;
    }
    
    level flag::wait_till( #"hash_2edfaf196e292488" );
    
    if ( !self flag::get( #"destroyed" ) )
    {
        var_f95b722f = s_obj.var_4f7ad985;
        objectives::kill( var_f95b722f, s_obj.origin, undefined, 0, 1, 0, #"hash_745f1c5e96b6668a" );
        self flag::wait_till( #"destroyed" );
        objectives::complete( var_f95b722f );
        
        if ( isdefined( level.player ) )
        {
            level.player thread objectives_ui::show_objectives();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xdef2bce5, Offset: 0xe2b0
// Size: 0x3ec
function function_947a3f54()
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    
    foreach ( ent in getentarray( self.target, "targetname", 1 ) )
    {
        if ( ent.script_noteworthy === #"trigger_damage" )
        {
            t_damage = ent;
            break;
        }
    }
    
    if ( !isdefined( t_damage ) )
    {
        return;
    }
    
    trigger::wait_till( t_damage.targetname, "targetname", level.player );
    self flag::set( #"destroyed" );
    function_1eaaceab( self.a_e_targets );
    
    foreach ( e_target in self.a_e_targets )
    {
        e_target util::delay( randomfloatrange( 0.1, 1 ), undefined, &kill, e_target.origin, level.player, level.player, level.var_53bb8ef2.var_df6d4579 );
    }
    
    var_888c72d = 1;
    
    foreach ( s_targets in var_9051f4a3.var_a5757f71 )
    {
        if ( !s_targets flag::get( #"destroyed" ) )
        {
            var_888c72d = 0;
            break;
        }
    }
    
    if ( var_888c72d )
    {
        level flag::set( #"hash_4677c88fea5b7ac1" );
    }
    
    foreach ( struct in struct::get_array( self.target ) )
    {
        if ( struct.script_noteworthy === #"explosion" )
        {
            var_85e471f5 = struct;
            break;
        }
    }
    
    if ( !isdefined( var_85e471f5 ) )
    {
        return;
    }
    
    wait 1;
    playfx( #"hash_68a62bc3d5b15568", var_85e471f5.origin );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x5dc5fe45, Offset: 0xe6a8
// Size: 0xe0
function function_aaa7f178( var_79de6b64 )
{
    level.var_9051f4a3 endon( #"skipped" );
    var_79de6b64 = array::sort_by_script_int( var_79de6b64, 1 );
    
    foreach ( s_mortar in var_79de6b64 )
    {
        s_mortar notify( #"mortars_fire" );
        wait randomfloatrange( 0.5, 1 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x15149cd9, Offset: 0xe790
// Size: 0x148
function function_c6b4b443()
{
    level.var_9051f4a3 endon( #"skipped" );
    var_19e82d16 = function_aa2f407c( "sp_ripcord_south_flank_rpg", #"hash_4560532c3c0eb3a1" );
    var_713e5bc1 = function_aa2f407c( "sp_ripcord_south_flank_rpg", #"hash_4560502c3c0eae88" );
    level flag::wait_till( #"hash_160f56c6d59d5917" );
    
    foreach ( ai_rpg in arraycombine( var_19e82d16, var_713e5bc1 ) )
    {
        if ( isalive( ai_rpg ) )
        {
            ai_rpg thread ai::bloody_death();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x730f2f3f, Offset: 0xe8e0
// Size: 0x128
function function_1c6745b4()
{
    level.var_9051f4a3 endon( #"skipped" );
    var_19e82d16 = function_aa2f407c( "sp_ripcord_reinf_rpgs_01" );
    var_713e5bc1 = function_aa2f407c( "sp_ripcord_reinf_rpgs_02" );
    level flag::wait_till( #"hash_3a020db7d8aa516c" );
    
    foreach ( ai_rpg in arraycombine( var_19e82d16, var_713e5bc1 ) )
    {
        if ( isalive( ai_rpg ) )
        {
            ai_rpg thread ai::bloody_death();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xa85c8cfc, Offset: 0xea10
// Size: 0x17c
function function_2095821c()
{
    level.var_9051f4a3 endon( #"skipped" );
    var_79aabf62 = spawnstruct();
    var_67c91b9f = spawnstruct();
    var_7233f141 = function_aa2f407c( "sp_ripcord_reinf_convoy_01", undefined, 1, 0, &function_1adc0121, var_79aabf62 );
    var_5073adc1 = function_aa2f407c( "sp_ripcord_reinf_convoy_02", undefined, 1, 0, &function_1adc0121, var_67c91b9f );
    objectives::complete( #"hash_2219bd003d6556ce" );
    level thread function_8544c23e( var_7233f141, #"ripcord_reinf_convoy_01", #"hash_655527a3d778dd1f", 1 );
    level thread function_8544c23e( var_5073adc1, #"ripcord_reinf_convoy_02", #"hash_60fbef66f73d44ea", 1 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x722050cf, Offset: 0xeb98
// Size: 0xaa
function function_1adc0121( var_8d8a7b79 )
{
    self.var_cea8bf15 = var_8d8a7b79;
    
    if ( !isdefined( var_8d8a7b79.var_549c5e7b ) )
    {
        var_8d8a7b79.var_549c5e7b = [];
    }
    else if ( !isarray( var_8d8a7b79.var_549c5e7b ) )
    {
        var_8d8a7b79.var_549c5e7b = array( var_8d8a7b79.var_549c5e7b );
    }
    
    var_8d8a7b79.var_549c5e7b[ var_8d8a7b79.var_549c5e7b.size ] = self;
    self.overridevehicledamage = &function_55affe8d;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 15
// Checksum 0xb67c67bb, Offset: 0xec50
// Size: 0x15c
function function_55affe8d( einflictor, eattacker, idamage, *idflags, *smeansofdeath, weapon, vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal )
{
    if ( self.health - modelindex <= 0 )
    {
        var_8d8a7b79 = self.var_cea8bf15;
        
        if ( !var_8d8a7b79 flag::get( #"destroyed" ) )
        {
            var_8d8a7b79 flag::set( #"destroyed" );
            s_params = { #einflictor:psoffsettime, #eattacker:damagefromunderneath, #weapon:partname, #vpoint:vsurfacenormal };
            var_8d8a7b79 thread function_646fc5f9( self, s_params );
        }
        
        return 0;
    }
    
    return modelindex;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0xd47e952a, Offset: 0xedb8
// Size: 0x2d4
function function_646fc5f9( var_c3ed6416, s_params )
{
    if ( !isdefined( self.var_549c5e7b ) )
    {
        self.var_549c5e7b = [];
    }
    
    if ( !isdefined( s_params.vpoint ) )
    {
        var_3a99b470 = var_c3ed6416;
    }
    else
    {
        var_3a99b470 = arraygetclosest( s_params.vpoint, self.var_549c5e7b );
    }
    
    var_aaed33f9 = var_3a99b470.script_int;
    var_3a99b470.overridevehicledamage = undefined;
    var_3a99b470 kill( s_params.vpoint, s_params.eattacker, s_params.einflictor, s_params.weapon );
    var_e6dbbe69 = [];
    var_97f60443 = [];
    var_549c5e7b = arraycopy( self.var_549c5e7b );
    arrayremovevalue( var_549c5e7b, var_3a99b470 );
    
    foreach ( var_cd75ffd6 in var_549c5e7b )
    {
        if ( isalive( var_cd75ffd6 ) )
        {
            if ( var_cd75ffd6.script_int < var_aaed33f9 )
            {
                if ( !isdefined( var_e6dbbe69 ) )
                {
                    var_e6dbbe69 = [];
                }
                else if ( !isarray( var_e6dbbe69 ) )
                {
                    var_e6dbbe69 = array( var_e6dbbe69 );
                }
                
                var_e6dbbe69[ var_e6dbbe69.size ] = var_cd75ffd6;
                continue;
            }
            
            if ( !isdefined( var_97f60443 ) )
            {
                var_97f60443 = [];
            }
            else if ( !isarray( var_97f60443 ) )
            {
                var_97f60443 = array( var_97f60443 );
            }
            
            var_97f60443[ var_97f60443.size ] = var_cd75ffd6;
        }
    }
    
    var_e6dbbe69 = array::sort_by_script_int( var_e6dbbe69, 0 );
    var_97f60443 = array::sort_by_script_int( var_97f60443, 1 );
    
    if ( var_e6dbbe69.size > 0 )
    {
        self thread function_ec2a0020( var_e6dbbe69, s_params );
    }
    
    if ( var_97f60443.size > 0 )
    {
        self thread function_ec2a0020( var_97f60443, s_params );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0xc0181754, Offset: 0xf098
// Size: 0x108
function function_ec2a0020( var_549c5e7b, s_params )
{
    foreach ( var_cd75ffd6 in var_549c5e7b )
    {
        if ( isalive( var_cd75ffd6 ) )
        {
            wait 0.2;
            
            if ( isalive( var_cd75ffd6 ) )
            {
                var_cd75ffd6.overridevehicledamage = undefined;
                var_cd75ffd6 kill( s_params.vpoint, s_params.eattacker, s_params.einflictor, s_params.weapon );
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x533a93f2, Offset: 0xf1a8
// Size: 0x16c
function function_ac5ebfa1()
{
    level.var_9051f4a3 endon( #"skipped" );
    a_spawners = getspawnerarray( "sp_ripcord_reinf_runners", "targetname" );
    
    for ( i = 0; i < 4 ; i++ )
    {
        switch ( i )
        {
            case 0:
                var_3ba94e96 = "sp_ripcord_reinf_runners_01";
                str_spawns = #"hash_661c0d6b54386759";
                break;
            case 1:
                var_3ba94e96 = "sp_ripcord_reinf_runners_02";
                str_spawns = #"hash_661c0a6b54386240";
                break;
            case 2:
                var_3ba94e96 = "sp_ripcord_reinf_runners_03";
                str_spawns = #"hash_661c0b6b543863f3";
                break;
            case 3:
                var_3ba94e96 = "sp_ripcord_reinf_runners_04";
                str_spawns = #"hash_661c106b54386c72";
                break;
        }
        
        level thread function_737ae2d0( var_3ba94e96, str_spawns );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x79539b4a, Offset: 0xf320
// Size: 0x1e0
function function_737ae2d0( var_3ba94e96, str_spawns )
{
    level.var_9051f4a3 endon( #"skipped" );
    a_spawners = getspawnerarray( var_3ba94e96, "targetname" );
    a_s_spawns = struct::get_array( str_spawns );
    a_s_spawns = array::randomize( a_s_spawns );
    
    foreach ( s_spawn in a_s_spawns )
    {
        spawner = array::random( a_spawners );
        spawner.origin = s_spawn.origin;
        spawner.angles = s_spawn.angles;
        spawner.target = s_spawn.target;
        
        while ( true )
        {
            var_4e75a347 = spawner::simple_spawn_single( spawner, &function_158cdaa );
            
            if ( isdefined( var_4e75a347 ) )
            {
                var_4e75a347 namespace_4e75a347::function_cab4b520( "ALERT" );
                break;
            }
            
            waitframe( 1 );
        }
        
        wait randomfloatrange( 0.4, 0.5 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xa65dab5e, Offset: 0xf508
// Size: 0x54c
function function_4afd7dea()
{
    level.var_9051f4a3 endon( #"skipped" );
    level thread function_226ff16b();
    var_273af5fa = function_aa2f407c( "sp_ripcord_east_flank_rpgs", #"hash_36cfe917966a1b00" );
    var_385f5dc0 = struct::get( #"hash_8d295ee06976887" );
    
    foreach ( var_fd57b633 in getcorpsearray( var_385f5dc0.origin, float( var_385f5dc0.radius ) ) )
    {
        var_fd57b633 delete();
    }
    
    var_5fd53a17 = function_aa2f407c( "sp_ripcord_north_flank_apcs", undefined, 1, 1, &function_286a4ce2 );
    var_a21e5c7c = function_aa2f407c( "sp_ripcord_north_flank_trucks", undefined, 1, 0, &function_286a4ce2 );
    a_vh_targets = arraycombine( var_5fd53a17, var_a21e5c7c );
    var_238b2d24 = function_aa2f407c( "sp_ripcord_north_flank_rpgs" );
    level flag::wait_till( #"hash_250edc5195758370" );
    objectives::scripted( #"hash_27f5175fca92a241", undefined, #"hash_ffb718cd7acca4b" );
    objectives::function_6a5ca7ac( #"hash_27f5175fca92a241", undefined, #"hash_3e1e8f33287f0c8" );
    s_obj = struct::get( #"hash_3ac1e621cd4abd1d" );
    objectives::function_4eb5c04a( #"hash_117a5c13253d75cd", s_obj.origin );
    level flag::wait_till( #"hash_3a020db7d8aa516c" );
    objectives::complete( #"hash_117a5c13253d75cd" );
    wait 1;
    function_1eaaceab( a_vh_targets );
    
    if ( a_vh_targets.size > 0 )
    {
        objectives::kill( #"hash_2d2e7426cedd97b8", a_vh_targets, undefined, 0, 1, 0, #"hash_745f1c5e96b6668a" );
        level flag::wait_till( #"hash_9b54061312dc6ab" );
        objectives::complete( #"hash_2d2e7426cedd97b8" );
    }
    
    level flag::set( #"hash_9b54061312dc6ab" );
    level flag::set( #"hash_71b417d2e25ac7c1" );
    level flag::set( #"hash_16d9badc5604cc63" );
    wait 2;
    level flag::set( #"hash_1ef3a1febf52c90e" );
    var_c3d060a6 = arraycombine( var_273af5fa, var_238b2d24 );
    function_1eaaceab( var_c3d060a6 );
    
    foreach ( ai_cleanup in var_c3d060a6 )
    {
        ai_cleanup thread ai::bloody_death( randomfloatrange( 0.1, 2 ) );
    }
    
    wait 2;
    objectives::complete( #"hash_27f5175fca92a241" );
    level flag::set( #"hash_2e43c4e93e07445c" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xdd9393d2, Offset: 0xfa60
// Size: 0x34
function function_6b9fe440()
{
    self callback::function_d8abfc3d( #"on_vehicle_killed", &function_93e29de4 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x70ab371, Offset: 0xfaa0
// Size: 0x154
function function_93e29de4( *s_params )
{
    var_9051f4a3 = level.var_9051f4a3;
    
    if ( !isdefined( var_9051f4a3.var_f6e94680 ) )
    {
        var_9051f4a3.var_f6e94680 = 0;
    }
    
    var_9051f4a3.var_f6e94680++;
    
    if ( var_9051f4a3.var_f6e94680 >= 2 )
    {
        level flag::set( #"hash_4a274f83454d05ce" );
    }
    
    if ( var_9051f4a3.var_f6e94680 >= 3 )
    {
        level flag::set( #"hash_6c173b3963bfc32e" );
        objectives::complete( #"hash_612d7344e062b101" );
    }
    
    if ( level flag::get( #"hash_77382d073ced2766" ) && !level flag::get( #"hash_3a020db7d8aa516c" ) && isdefined( level.player ) )
    {
        level.player thread objectives_ui::show_objectives();
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xe680076a, Offset: 0xfc00
// Size: 0x34
function function_286a4ce2()
{
    self callback::function_d8abfc3d( #"on_vehicle_killed", &function_9644639d );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x3b75e06f, Offset: 0xfc40
// Size: 0xa4
function function_9644639d( *s_params )
{
    var_9051f4a3 = level.var_9051f4a3;
    
    if ( !isdefined( var_9051f4a3.var_760fea00 ) )
    {
        var_9051f4a3.var_760fea00 = 0;
    }
    
    var_9051f4a3.var_760fea00++;
    
    if ( var_9051f4a3.var_760fea00 >= 6 )
    {
        level flag::set( #"hash_9b54061312dc6ab" );
    }
    
    level flag::set( #"hash_71b417d2e25ac7c1" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x8a174739, Offset: 0xfcf0
// Size: 0x47c
function function_cffa5653()
{
    if ( !isdefined( level.var_9051f4a3.var_79de6b64 ) )
    {
        level.var_9051f4a3.var_79de6b64 = [];
    }
    else if ( !isarray( level.var_9051f4a3.var_79de6b64 ) )
    {
        level.var_9051f4a3.var_79de6b64 = array( level.var_9051f4a3.var_79de6b64 );
    }
    
    level.var_9051f4a3.var_79de6b64[ level.var_9051f4a3.var_79de6b64.size ] = self;
    self.var_2199674d = [];
    self.var_447b1ac8 = [];
    self.var_972f9755 = [];
    
    foreach ( ent in getentarray( self.target, "targetname", 1 ) )
    {
        if ( ent.script_noteworthy === #"trigger_damage" )
        {
            self.t_damage = ent;
            self thread function_cff233c();
        }
    }
    
    var_2199674d = function_aa2f407c( self.target );
    
    foreach ( e_spawned in var_2199674d )
    {
        if ( !isdefined( self.var_2199674d ) )
        {
            self.var_2199674d = [];
        }
        else if ( !isarray( self.var_2199674d ) )
        {
            self.var_2199674d = array( self.var_2199674d );
        }
        
        self.var_2199674d[ self.var_2199674d.size ] = e_spawned;
        
        if ( e_spawned.script_noteworthy === #"crew" )
        {
            if ( !isdefined( self.var_447b1ac8 ) )
            {
                self.var_447b1ac8 = [];
            }
            else if ( !isarray( self.var_447b1ac8 ) )
            {
                self.var_447b1ac8 = array( self.var_447b1ac8 );
            }
            
            self.var_447b1ac8[ self.var_447b1ac8.size ] = e_spawned;
        }
    }
    
    foreach ( struct in struct::get_array( self.target ) )
    {
        switch ( struct.script_noteworthy )
        {
            case #"muzzle":
                if ( !isdefined( self.var_972f9755 ) )
                {
                    self.var_972f9755 = [];
                }
                else if ( !isarray( self.var_972f9755 ) )
                {
                    self.var_972f9755 = array( self.var_972f9755 );
                }
                
                self.var_972f9755[ self.var_972f9755.size ] = struct;
                break;
            case #"explosion":
                self.var_85e471f5 = struct;
                break;
        }
    }
    
    self thread function_94edfe20();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xbe5e8cac, Offset: 0x10178
// Size: 0xc4
function function_cff233c()
{
    self endon( #"destroyed" );
    
    while ( true )
    {
        s_waitresult = self.t_damage waittill( #"damage" );
        e_attacker = s_waitresult.attacker;
        
        if ( issentient( e_attacker ) && e_attacker getteam() == #"allies" )
        {
            break;
        }
    }
    
    self function_e00566fd( s_waitresult );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0xaea274ae, Offset: 0x10248
// Size: 0x1e4
function function_e00566fd( s_waitresult, b_cleanup = 0 )
{
    if ( isdefined( self.var_85e471f5 ) )
    {
        self thread function_86506afc();
    }
    
    foreach ( var_9663c8a6 in self.var_447b1ac8 )
    {
        if ( isdefined( var_9663c8a6 ) )
        {
            var_9663c8a6 kill( var_9663c8a6.origin, s_waitresult.attacker, s_waitresult.inflictor, s_waitresult.weapon );
        }
    }
    
    if ( b_cleanup )
    {
        foreach ( e_spawned in self.var_2199674d )
        {
            if ( isvehicle( e_spawned ) || function_8d8e91af( e_spawned ) )
            {
                e_spawned kill();
                continue;
            }
            
            e_spawned thread ai::bloody_death();
        }
    }
    
    self flag::set( #"destroyed" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xf0cc68f7, Offset: 0x10438
// Size: 0x3c
function function_86506afc()
{
    wait 1;
    playfx( #"hash_68a62bc3d5b15568", self.var_85e471f5.origin );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x30ddd34a, Offset: 0x10480
// Size: 0x1e2
function function_94edfe20()
{
    self endon( #"destroyed" );
    self waittill( #"mortars_fire" );
    var_972f9755 = array::randomize( self.var_972f9755 );
    
    foreach ( i, var_a2d4664b in var_972f9755 )
    {
        var_a2d4664b.var_5dcf77d6 = 0;
        self thread function_f91a9d15( var_a2d4664b );
        
        if ( i + 1 < var_972f9755.size )
        {
            wait 2;
        }
    }
    
    while ( true )
    {
        foreach ( var_a2d4664b in var_972f9755 )
        {
            n_delay = randomintrangeinclusive( 10, 20 );
            
            if ( var_a2d4664b.var_5dcf77d6 >= n_delay )
            {
                self thread function_f91a9d15( var_a2d4664b );
                var_a2d4664b.var_5dcf77d6 = 0;
                continue;
            }
            
            var_a2d4664b.var_5dcf77d6++;
        }
        
        wait 1;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x3f378da7, Offset: 0x10670
// Size: 0x2f4
function function_f91a9d15( var_a2d4664b )
{
    level.var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_494514617379bbdf" );
    s_target = struct::get( #"hash_2d5a030e61f3ef3d" );
    n_radius = float( s_target.radius );
    n_x = randomfloat( n_radius );
    
    if ( math::cointoss() )
    {
        n_x *= -1;
    }
    
    n_y = randomfloat( n_radius );
    
    if ( math::cointoss() )
    {
        n_y *= -1;
    }
    
    v_target = s_target.origin + ( n_x, n_y, 0 );
    a_trace = groundtrace( v_target, v_target - ( 0, 0, 2048 ), 0, level.var_53bb8ef2.var_78bd98cb );
    
    if ( isdefined( a_trace[ #"position" ] ) && !isdefined( a_trace[ #"entity" ] ) )
    {
        var_42ba4b31 = util::spawn_model( #"tag_origin", var_a2d4664b.origin );
        v_target = a_trace[ #"position" ];
        n_time = var_42ba4b31 function_a93c1395( v_target, float( var_a2d4664b.n_power ) );
        self thread function_50e34d79( n_time, v_target );
        
        if ( isdefined( var_a2d4664b.var_b135ee81 ) )
        {
            n_time -= float( var_a2d4664b.var_b135ee81 );
        }
        
        wait 0.1;
        playfxontag( #"hash_75dc71e69737c2b1", var_42ba4b31, "tag_origin" );
        
        if ( n_time - 0.1 > 0 )
        {
            wait n_time - 0.1;
        }
        
        var_42ba4b31 delete();
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x8b54077f, Offset: 0x10970
// Size: 0x1a8
function function_50e34d79( n_time, v_target )
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_494514617379bbdf" );
    wait n_time;
    v_angles = ( 270, 0, 0 );
    playfx( #"hash_7e60569db9c36606", v_target, anglestoforward( v_angles ), anglestoup( v_angles ) );
    var_ada0b21 = function_e16259ed( var_9051f4a3.var_72364dd7 );
    var_eb5353bb = arraysortclosest( var_ada0b21, v_target, undefined, 0, 300 );
    
    foreach ( var_4e7c260f in var_eb5353bb )
    {
        var_4e7c260f dodamage( 10, v_target, undefined, undefined, undefined, "MOD_EXPLOSIVE" );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x687678ab, Offset: 0x10b20
// Size: 0x120
function function_a93c1395( target_pos, power )
{
    start_pos = self.origin;
    gravity = getdvarint( #"bg_gravity", 0 ) * -1;
    dist = distance( start_pos, target_pos );
    time = dist / power;
    delta = target_pos - start_pos;
    drop = 0.5 * gravity * time * time;
    velocity = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
    self movegravity( velocity, time );
    return time;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x9710eeae, Offset: 0x10c48
// Size: 0x14c
function function_e9c43f6( var_d3479c0a = 1 )
{
    level.var_9051f4a3 endon( #"skipped" );
    
    if ( var_d3479c0a )
    {
        level flag::wait_till( #"hash_725325f3f3a86396" );
    }
    
    spawner::simple_spawn_single( "sp_ripcord_support_huey_01", &function_9f50131 );
    spawner::simple_spawn_single( "sp_ripcord_support_huey_02", &function_e6828e29 );
    spawner::simple_spawn_single( "sp_ripcord_support_huey_03", &function_432b55b );
    spawner::simple_spawn_single( "sp_ripcord_rpg_huey", &function_4112226 );
    spawner::simple_spawn_single( "sp_ripcord_reveal_huey_01", &function_45c28ee0 );
    spawner::simple_spawn_single( "sp_ripcord_reveal_huey_02", &function_ef3aeb5d );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xf56a95d2, Offset: 0x10da0
// Size: 0x11c
function function_4dee3ecb()
{
    if ( !isdefined( level.var_9051f4a3.var_b6fdd6f2 ) )
    {
        level.var_9051f4a3.var_b6fdd6f2 = [];
    }
    else if ( !isarray( level.var_9051f4a3.var_b6fdd6f2 ) )
    {
        level.var_9051f4a3.var_b6fdd6f2 = array( level.var_9051f4a3.var_b6fdd6f2 );
    }
    
    level.var_9051f4a3.var_b6fdd6f2[ level.var_9051f4a3.var_b6fdd6f2.size ] = self;
    self setrotorspeed( 1 );
    self.drivepath = 1;
    nd_start = getvehiclenode( self.target, "targetname" );
    self vehicle::get_on_path( nd_start );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x5b9e9e78, Offset: 0x10ec8
// Size: 0xf4
function function_45c28ee0()
{
    self endon( #"death" );
    self function_4dee3ecb();
    self setmaxpitchroll( 20, 50 );
    
    while ( !level flag::get( #"hash_490bc7407722903d" ) && !level.player util::is_player_looking_at( self.origin, 0.9, 1, self, level.var_53bb8ef2.var_78bd98cb ) )
    {
        waitframe( 1 );
    }
    
    level flag::set( #"hash_490bc7407722903d" );
    self vehicle::go_path();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x5e6e7f14, Offset: 0x10fc8
// Size: 0x9c
function function_ef3aeb5d()
{
    self endon( #"delete" );
    level.var_9051f4a3 endon( #"skipped" );
    self function_4dee3ecb();
    self setmaxpitchroll( 10, 40 );
    level flag::wait_till( #"hash_490bc7407722903d" );
    self vehicle::go_path();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x38a9f62c, Offset: 0x11070
// Size: 0x2a4
function function_1b0fcde7( var_6bff65c4 = 1, n_pitch = 20 )
{
    if ( !isdefined( level.var_9051f4a3.var_86c425b5 ) )
    {
        level.var_9051f4a3.var_86c425b5 = [];
    }
    else if ( !isarray( level.var_9051f4a3.var_86c425b5 ) )
    {
        level.var_9051f4a3.var_86c425b5 = array( level.var_9051f4a3.var_86c425b5 );
    }
    
    level.var_9051f4a3.var_86c425b5[ level.var_9051f4a3.var_86c425b5.size ] = self;
    self val::set( #"hash_3b9be08d33a28b30", "ignoreall", 1 );
    self val::set( #"hash_3b9be08d33a28b30", "ignoreme", 1 );
    self.overridevehicledamage = &function_fc619d52;
    
    if ( var_6bff65c4 )
    {
        level thread namespace_b7cfe907::function_68d5d346( self, [ 0, 1, 7, 8 ] );
        self callback::function_d8abfc3d( #"on_vehicle_killed", &function_ea8ebebc );
        self callback::function_d8abfc3d( #"on_deleted", &function_ea8ebebc );
    }
    
    self setrotorspeed( 1 );
    self setspeed( 50, 20, 10 );
    self setyawspeed( 50, 20, 10 );
    self vehclearlookat();
    self.var_964b76ab = n_pitch;
    self setdefaultpitch( self.var_964b76ab );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 15
// Checksum 0x3fdb2e0c, Offset: 0x11320
// Size: 0xce, Type: bool
function function_fc619d52( einflictor, eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal )
{
    if ( isplayer( modelindex ) || isplayer( partname ) )
    {
        level thread function_56ca8045( vsurfacenormal, 0 );
    }
    
    return false;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x69a8445d, Offset: 0x113f8
// Size: 0x24
function function_ea8ebebc( *s_params )
{
    self namespace_b7cfe907::function_5677b6eb();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 3
// Checksum 0x75fde265, Offset: 0x11428
// Size: 0x246
function function_22761cc0( s_start, var_7985d5b8 = 256, var_a35f50b = 1 )
{
    self notify( "43ccc9d434ac4a75" );
    self endon( "43ccc9d434ac4a75" );
    self endon( #"death", #"hash_29cc7e1c0557d2ea" );
    self notify( #"hash_211a124ebbd9dc00" );
    self.var_cb55c804 = var_7985d5b8;
    self setneargoalnotifydist( self.var_cb55c804 );
    self cleargoalyaw();
    self cleartargetyaw();
    s_goal = s_start;
    
    if ( !isstruct( s_goal ) )
    {
    }
    
    for ( s_goal = struct::get( s_goal ); true ; s_goal = struct::get( s_goal.target ) )
    {
        self.var_b0a8e2ae = s_goal;
        
        if ( var_a35f50b )
        {
            n_yaw = int( s_goal.angles[ 1 ] );
            self setgoalyaw( n_yaw );
            self settargetyaw( n_yaw );
        }
        
        self function_a57c34b7( s_goal.origin, 1 );
        self setgoal( s_goal.origin, 1 );
        self waittill( #"goal", #"near_goal" );
        
        if ( !isdefined( s_goal.target ) )
        {
            break;
        }
    }
    
    self notify( #"hash_5ac2aa2987e9f0e1" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xaf70cc94, Offset: 0x11678
// Size: 0x536
function function_34728c3a( s_center )
{
    self endon( #"death", #"hash_211a124ebbd9dc00" );
    
    if ( !isdefined( s_center ) )
    {
        if ( !isdefined( self.var_b0a8e2ae ) )
        {
            return;
        }
        
        s_center = self.var_b0a8e2ae;
    }
    
    if ( isstring( s_center ) || ishash( s_center ) )
    {
        s_center = struct::get( s_center );
    }
    
    self.var_b0a8e2ae = s_center;
    var_5d5bac89 = 0;
    var_b75bab4a = 0;
    var_6e9ae5a5 = 1;
    var_48fc7504 = 0;
    var_b14b572f = 0;
    v_center = s_center.origin;
    n_yaw = int( s_center.angles[ 1 ] );
    self setgoalyaw( n_yaw );
    self settargetyaw( n_yaw );
    v_up = anglestoup( s_center.angles );
    v_forward = anglestoforward( s_center.angles );
    v_right = anglestoright( s_center.angles );
    var_294c717c = v_center;
    self.var_cb55c804 = 32;
    self setneargoalnotifydist( self.var_cb55c804 );
    var_3d422bc1 = 0;
    
    while ( true )
    {
        if ( var_6e9ae5a5 )
        {
            var_3d422bc1 = 0;
            var_6e9ae5a5 = 0;
        }
        else
        {
            var_3d422bc1 += 30;
        }
        
        if ( math::cointoss( var_3d422bc1 ) )
        {
            var_6e9ae5a5 = 1;
            var_5d5bac89 = 0;
            var_b75bab4a = 0;
            
            if ( math::cointoss() )
            {
                var_6fd0c424 = v_forward;
                
                if ( var_b14b572f )
                {
                    var_6fd0c424 *= randomfloatrange( 512, 1024 );
                    var_6fd0c424 *= -1;
                }
                else
                {
                    var_6fd0c424 *= randomfloatrange( 256, 512 );
                }
                
                var_b14b572f = !var_b14b572f;
            }
            else
            {
                var_6fd0c424 = v_right * randomfloatrange( 256, 512 );
                
                if ( var_48fc7504 )
                {
                    var_6fd0c424 *= -1;
                }
                
                var_48fc7504 = !var_48fc7504;
            }
            
            var_294c717c = v_center + var_6fd0c424;
            self function_a57c34b7( var_294c717c, 1 );
            self setgoal( var_294c717c, 1 );
            self waittill( #"goal", #"near_goal" );
            continue;
        }
        
        var_6e9ae5a5 = 0;
        var_48fc7504 = 0;
        var_b14b572f = 0;
        var_2bdcb269 = v_right * randomfloat( 128 );
        
        if ( var_5d5bac89 )
        {
            var_2bdcb269 *= -1;
        }
        
        v_goal = var_294c717c + var_2bdcb269;
        var_5d5bac89 = !var_5d5bac89;
        
        if ( math::cointoss( 25 ) )
        {
            var_83dbc6c0 = v_up * randomfloat( 128 );
            
            if ( var_b75bab4a )
            {
                var_83dbc6c0 *= -1;
            }
            
            v_goal += var_83dbc6c0;
            var_b75bab4a = !var_b75bab4a;
        }
        
        self function_a57c34b7( v_goal, 1 );
        self setgoal( v_goal, 1 );
        self waittill( #"goal", #"near_goal" );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xe4d6216b, Offset: 0x11bb8
// Size: 0x138
function function_539a07b0( var_6776e7ab )
{
    self endon( #"death", #"hash_62eeba7b308527bd" );
    
    if ( isdefined( var_6776e7ab ) )
    {
        var_1d685f93 = getent( var_6776e7ab, "targetname" );
    }
    
    while ( true )
    {
        wait randomfloatrange( 3, 5 );
        
        if ( isdefined( var_1d685f93 ) && !self istouching( var_1d685f93 ) )
        {
            continue;
        }
        
        n_fire_time = randomfloatrange( 1, 3 );
        self thread vehicle_ai::fire_for_time( n_fire_time, 3 );
        self vehicle_ai::fire_for_time( n_fire_time, 4 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x4c7ec144, Offset: 0x11cf8
// Size: 0x178
function function_4d16e098( var_6776e7ab )
{
    self endon( #"death", #"hash_3ac6fa8c90fd94b3" );
    
    if ( isdefined( var_6776e7ab ) )
    {
        var_1d685f93 = getent( var_6776e7ab, "targetname" );
    }
    
    while ( true )
    {
        wait randomfloatrange( 5, 10 );
        n_rounds = randomintrangeinclusive( 1, 5 );
        var_7590fc14 = randomfloatrange( 0.25, 1 );
        
        for ( i = 0; i < n_rounds ; i++ )
        {
            if ( isdefined( var_1d685f93 ) && !self istouching( var_1d685f93 ) )
            {
                continue;
            }
            
            self function_c5c81070();
            
            if ( i + 1 < n_rounds )
            {
                wait var_7590fc14;
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xc81254e4, Offset: 0x11e78
// Size: 0x26c
function function_c5c81070( s_target )
{
    if ( !isdefined( self.var_5282fb88 ) )
    {
        self.var_5282fb88 = 0;
    }
    
    v_right = anglestoright( self.angles );
    v_forward = anglestoforward( self.angles );
    v_up = anglestoup( self.angles );
    var_bf584f29 = v_right * 70;
    
    if ( self.var_5282fb88 == 0 )
    {
        self.var_5282fb88 = 1;
        var_bf584f29 *= -1;
    }
    else
    {
        self.var_5282fb88 = 0;
    }
    
    var_bf584f29 += self.origin + v_forward * 40 + v_up * -100;
    v_velocity = v_forward * 3000;
    
    if ( isdefined( s_target ) )
    {
        if ( !isstruct( s_target ) )
        {
            s_target = struct::get( s_target );
        }
        
        v_target = s_target.origin;
        n_radius = isdefined( float( s_target.radius ) ) ? float( s_target.radius ) : 32;
        
        if ( self.var_5282fb88 == 0 )
        {
            v_target += v_right * randomfloat( n_radius );
        }
        else
        {
            v_target -= v_right * randomfloat( n_radius );
        }
        
        v_velocity = vectornormalize( v_target - var_bf584f29 ) * 3000;
    }
    
    self magicmissile( getweapon( #"hash_1b226dddac770884" ), var_bf584f29, v_velocity );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x452b06c6, Offset: 0x120f0
// Size: 0x100
function function_b7727676( var_4f7542 )
{
    var_a62d5aa5 = self.var_964b76ab;
    
    if ( var_a62d5aa5 == var_4f7542 )
    {
        return;
    }
    
    n_start_time = gettime();
    
    while ( isdefined( self ) )
    {
        n_current_time = gettime();
        n_time_passed = float( n_current_time - n_start_time ) / 1000;
        n_percent = min( 1, n_time_passed / 1 );
        self.var_964b76ab = lerpfloat( var_a62d5aa5, var_4f7542, n_percent );
        self setdefaultpitch( self.var_964b76ab );
        
        if ( n_percent >= 1 )
        {
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x1b6fd788, Offset: 0x121f8
// Size: 0x36c
function function_9f50131()
{
    self endon( #"death" );
    self function_1b0fcde7();
    self.var_83bc6615 = 1;
    self thread function_539a07b0();
    self thread function_4d16e098();
    self thread function_22761cc0( #"hash_199c58c9616c9e5f" );
    level flag::wait_till( #"hash_eeac05ac492404c" );
    self setspeed( 80, 40, 20 );
    self thread function_f686addf();
    self function_22761cc0( #"hash_46d30825e7d91a41" );
    self setspeed( 50, 20, 10 );
    self thread function_539a07b0();
    self thread function_4d16e098();
    self thread function_22761cc0( #"hash_70687984a0627a3e" );
    level flag::wait_till( #"hash_1ef3a1febf52c90e" );
    self thread function_1c6687fb();
    self notify( #"hash_62eeba7b308527bd" );
    self notify( #"hash_3ac6fa8c90fd94b3" );
    self setspeed( 20, 10, 5 );
    self setyawspeed( 20, 10, 5 );
    self setmaxpitchroll( 10, 30 );
    self thread function_b7727676( 0 );
    self function_22761cc0( #"hash_3818abf4b5c8811", 1024, 0 );
    self setspeed( 80, 30, 15 );
    self setyawspeed( 80, 30, 15 );
    self thread function_22761cc0( #"hash_604a37a673901470", 2048, 0 );
    level flag::wait_till_timeout( 15, #"hash_5b2bd051ba87df67" );
    
    while ( level.player util::is_player_looking_at( self.origin, 0.8, 0, self, level.var_53bb8ef2.var_78bd98cb ) )
    {
        waitframe( 1 );
    }
    
    self namespace_b7cfe907::function_5677b6eb();
    self deletedelay();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x9d5693fb, Offset: 0x12570
// Size: 0x224
function function_f686addf()
{
    self endon( #"death" );
    trigger::wait_till( "t_ripcord_support_huey_01_strafe_breach_01", "targetname", self );
    t_trigger = getent( "t_ripcord_support_huey_01_strafe_breach_01", "targetname" );
    t_trigger delete();
    self notify( #"hash_62eeba7b308527bd" );
    self notify( #"hash_3ac6fa8c90fd94b3" );
    self thread function_f1cf27a7();
    self function_c5c81070();
    wait 1;
    self function_c5c81070();
    wait 0.25;
    self function_c5c81070();
    wait 0.25;
    self function_c5c81070();
    wait 2;
    self function_c5c81070();
    wait 0.25;
    self function_c5c81070();
    wait 1;
    self function_c5c81070();
    wait 0.5;
    self function_c5c81070();
    wait 2;
    self function_c5c81070();
    wait 0.25;
    self function_c5c81070();
    wait 0.25;
    self function_c5c81070();
    wait 0.25;
    self function_c5c81070();
    wait 2;
    self function_c5c81070();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xdfc1b5cf, Offset: 0x127a0
// Size: 0x6c
function function_f1cf27a7()
{
    self endon( #"death" );
    self thread vehicle_ai::fire_for_time( 10, 3 );
    self vehicle_ai::fire_for_time( 10, 4 );
    self thread function_539a07b0();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x6c115feb, Offset: 0x12818
// Size: 0x6c
function function_1c6687fb()
{
    self endon( #"death" );
    level flag::wait_till( #"hash_4723793e58855abb" );
    self namespace_b7cfe907::function_5677b6eb();
    self delete();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xd2f73808, Offset: 0x12890
// Size: 0x364
function function_e6828e29()
{
    self endon( #"death" );
    self function_1b0fcde7();
    self.a_crash_zones = struct::get_array( #"ripcord_support_huey_02", "ripcord_heli_crash_zones" );
    self thread function_22761cc0( #"hash_571e6eb87af9dfe2" );
    level flag::wait_till( #"hash_490bc7407722903d" );
    wait 2;
    self cleargoalyaw();
    self cleartargetyaw();
    self.var_cb55c804 = 2048;
    self setneargoalnotifydist( self.var_cb55c804 );
    var_1bb57bae = struct::get( #"hash_571e6db87af9de2f" );
    self function_a57c34b7( var_1bb57bae.origin, 1 );
    self setgoal( var_1bb57bae.origin, 1 );
    self waittill( #"goal", #"near_goal" );
    
    if ( !level flag::get( #"hash_1eb15b1c688ad333" ) )
    {
        self thread function_22761cc0( #"hash_571e6db87af9de2f" );
        level flag::wait_till( #"hash_1eb15b1c688ad333" );
    }
    
    self thread function_b7727676( 0 );
    self thread function_22761cc0( #"hash_64ec0ad3e5ac1f84", 1024, 0 );
    wait 2.5;
    s_rpg = struct::get( #"hash_4421d602ca4050cd" );
    var_bf65d868 = util::spawn_model( #"tag_origin", s_rpg.origin );
    var_5b61a3b6 = function_6588ca82( var_bf65d868, self, 1, 0, 500 );
    var_5b61a3b6 setstablemissile( 1 );
    var_5b61a3b6 waittilltimeout( 1.5, #"death", #"explode" );
    
    if ( isdefined( var_5b61a3b6 ) )
    {
        var_5b61a3b6 detonate();
    }
    
    var_bf65d868 delete();
    self thread function_c97e7d1b( 8 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0xbab9541, Offset: 0x12c00
// Size: 0x14c
function function_c97e7d1b( n_delay, var_968d174e = 0 )
{
    self.overridevehicledamage = undefined;
    self vehicle_death::deathrollon();
    self kill();
    wait n_delay;
    
    if ( isdefined( self ) )
    {
        if ( var_968d174e )
        {
            playfx( #"hash_12469565edf5ff11", self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
            wait 1;
        }
        else
        {
            playfx( #"hash_764f5963981c5fec", self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
        }
        
        if ( isdefined( self ) )
        {
            self delete();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x2517ebf9, Offset: 0x12d58
// Size: 0x2dc
function function_432b55b()
{
    self endon( #"death" );
    self function_1b0fcde7( 1, 0 );
    self.a_crash_zones = struct::get_array( #"ripcord_support_huey_03", "ripcord_heli_crash_zones" );
    self function_a57c34b7( self.origin, 1 );
    self setgoal( self.origin, 1 );
    self setspeed( 100, 30, 15 );
    self setyawspeed( 50, 20, 10 );
    level flag::wait_till( #"hash_490bc7407722903d" );
    self function_22761cc0( #"hash_3a719158914fd1f9", 2048, 0 );
    
    if ( !level flag::get( #"hash_5b9375a85ac4aa60" ) )
    {
        level flag::wait_till( #"hash_5b9375a85ac4aa60" );
    }
    
    self thread function_22761cc0( #"hash_7a4fa54f08f048fb", 2048, 0 );
    self thread function_7b3c7bb1();
    wait 11;
    s_rpg = struct::get( #"hash_6238dc2db9dead4a" );
    var_bf65d868 = util::spawn_model( #"tag_origin", s_rpg.origin );
    var_5b61a3b6 = function_6588ca82( var_bf65d868, self, 1, 0, 500 );
    var_5b61a3b6 setstablemissile( 1 );
    var_5b61a3b6 waittilltimeout( 1, #"death", #"explode" );
    
    if ( isdefined( var_5b61a3b6 ) )
    {
        var_5b61a3b6 detonate();
    }
    
    var_bf65d868 delete();
    self thread function_c97e7d1b( 7 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xaa80a00b, Offset: 0x13040
// Size: 0xac
function function_7b3c7bb1()
{
    self endon( #"death" );
    var_c044e402 = struct::get( #"hash_3c4ef86ddc8eb161" );
    self turret::set_target( var_c044e402.origin, undefined, 2, 1 );
    wait 3;
    self vehicle_ai::fire_for_time( 8, 2 );
    self turretcleartarget( 2 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x30e64ee2, Offset: 0x130f8
// Size: 0x52c
function function_ca16a858()
{
    self endon( #"death" );
    self function_1b0fcde7( 1, 0 );
    self.var_83bc6615 = 1;
    self function_a57c34b7( self.origin, 1 );
    self setgoal( self.origin, 1 );
    self setspeed( 150, 50, 25 );
    self setyawspeed( 50, 25, 10 );
    self.var_cb55c804 = 1024;
    self setneargoalnotifydist( self.var_cb55c804 );
    var_1bb57bae = struct::get( #"hash_4b3cbb5b7b1b4b9e" );
    self function_a57c34b7( var_1bb57bae.origin, 1 );
    self setgoal( var_1bb57bae.origin, 1 );
    self waittill( #"goal", #"near_goal" );
    self setspeed( 100, 30, 15 );
    self setyawspeed( 50, 20, 10 );
    self thread function_b7727676( 30 );
    self thread function_22761cc0( var_1bb57bae );
    wait 2;
    level flag::wait_till( #"hash_5d4f3557dde7c0c8" );
    self thread function_e5ecc2aa();
    level flag::wait_till( #"hash_52d13ee4dded2faf" );
    self setspeed( 80, 30, 15 );
    self setyawspeed( 80, 30, 15 );
    self thread function_b7727676( 20 );
    self function_22761cc0( #"hash_2a4021bf052f68eb", 2048, 0 );
    self thread function_539a07b0();
    self thread function_4d16e098();
    self thread function_22761cc0( #"hash_3a86125ec1904c38" );
    level flag::wait_till( #"hash_1ef3a1febf52c90e" );
    self thread function_1c6687fb();
    self notify( #"hash_62eeba7b308527bd" );
    self notify( #"hash_3ac6fa8c90fd94b3" );
    wait 6;
    self setspeed( 20, 10, 5 );
    self setyawspeed( 20, 10, 5 );
    self setmaxpitchroll( 10, 30 );
    self thread function_b7727676( 0 );
    self function_22761cc0( #"hash_50f19b29908fa95e", 1024, 0 );
    self setspeed( 80, 30, 15 );
    self setyawspeed( 80, 30, 15 );
    self thread function_22761cc0( #"hash_66b73ce5b965b387", 2048, 0 );
    level flag::wait_till_timeout( 15, #"hash_5b2bd051ba87df67" );
    
    while ( level.player util::is_player_looking_at( self.origin, 0.8, 0, self, level.var_53bb8ef2.var_78bd98cb ) )
    {
        waitframe( 1 );
    }
    
    self namespace_b7cfe907::function_5677b6eb();
    self deletedelay();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x3f30a1ac, Offset: 0x13630
// Size: 0x214
function function_e5ecc2aa()
{
    self endon( #"death" );
    s_target = struct::get( #"hash_1227fcea601eb2a" );
    self function_c5c81070( s_target );
    wait 1;
    var_7c47616e = anglestoright( self.angles ) * 100;
    self turret::set_target( s_target.origin - var_7c47616e, undefined, 3 );
    self turret::set_target( s_target.origin + var_7c47616e, undefined, 4 );
    self thread vehicle_ai::fire_for_time( 3, 3 );
    self thread vehicle_ai::fire_for_time( 3, 4 );
    self function_c5c81070( s_target );
    wait 0.25;
    self function_c5c81070( s_target );
    wait 2;
    self function_c5c81070( s_target );
    wait 0.25;
    self function_c5c81070( s_target );
    wait 0.25;
    self function_c5c81070( s_target );
    wait 2;
    self turretcleartarget( 3 );
    self turretcleartarget( 4 );
    level flag::set( #"hash_52d13ee4dded2faf" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xc1088aba, Offset: 0x13850
// Size: 0x294
function function_cfa8bf1a()
{
    self endon( #"death" );
    self function_1b0fcde7( 1, 0 );
    self.a_crash_zones = struct::get_array( #"ripcord_support_huey_05", "ripcord_heli_crash_zones" );
    self function_22761cc0( #"hash_257d28ccd5ddab7d", 1024, 0 );
    self thread function_b7727676( 20 );
    self thread function_22761cc0( #"hash_53da0b359fa2b3c9" );
    wait 2;
    level flag::wait_till( #"hash_d6c4f4313d92a09" );
    self thread function_6b186654();
    level flag::wait_till( #"hash_7cc817743508fef0" );
    self thread function_b7727676( 0 );
    self thread function_22761cc0( #"hash_739bad9133512c45", 1024, 0 );
    wait 3;
    s_rpg = struct::get( #"hash_9c41a1a723d6464" );
    var_bf65d868 = util::spawn_model( #"tag_origin", s_rpg.origin );
    var_5b61a3b6 = function_6588ca82( var_bf65d868, self, 1, 0, 500 );
    var_5b61a3b6 setstablemissile( 1 );
    var_5b61a3b6 waittilltimeout( 1, #"death", #"explode" );
    
    if ( isdefined( var_5b61a3b6 ) )
    {
        var_5b61a3b6 detonate();
    }
    
    var_bf65d868 delete();
    self thread function_c97e7d1b( 4 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xd395ffd1, Offset: 0x13af0
// Size: 0x214
function function_6b186654()
{
    self endon( #"death" );
    s_target = struct::get( #"hash_1efd4dcf7cebc203" );
    self function_c5c81070( s_target );
    wait 1;
    var_7c47616e = anglestoright( self.angles ) * 100;
    self turret::set_target( s_target.origin - var_7c47616e, undefined, 3 );
    self turret::set_target( s_target.origin + var_7c47616e, undefined, 4 );
    self thread vehicle_ai::fire_for_time( 3, 3 );
    self thread vehicle_ai::fire_for_time( 3, 4 );
    self function_c5c81070( s_target );
    wait 0.25;
    self function_c5c81070( s_target );
    wait 2;
    self function_c5c81070( s_target );
    wait 0.25;
    self function_c5c81070( s_target );
    wait 0.25;
    self function_c5c81070( s_target );
    wait 2;
    self turretcleartarget( 3 );
    self turretcleartarget( 4 );
    level flag::set( #"hash_7cc817743508fef0" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x8de29ef4, Offset: 0x13d10
// Size: 0x30c
function function_4112226()
{
    self endon( #"death" );
    self function_1b0fcde7( 1, 10 );
    self.a_crash_zones = struct::get_array( #"ripcord_rpg_huey", "ripcord_heli_crash_zones" );
    self function_a57c34b7( self.origin, 1 );
    self setgoal( self.origin, 1 );
    self setspeed( 150, 50, 25 );
    self setyawspeed( 50, 25, 10 );
    self setmaxpitchroll( 0, 80 );
    
    while ( !level flag::get( #"hash_374dd1a0e9ce31c" ) && !level.player util::is_player_looking_at( self.origin, 0.8, 1, self, level.var_53bb8ef2.var_78bd98cb ) )
    {
        waitframe( 1 );
    }
    
    level flag::set( #"hash_374dd1a0e9ce31c" );
    self thread function_22761cc0( #"hash_77a539a0564e3ff5", 1024, 0 );
    wait 2.5;
    s_rpg = struct::get( #"hash_53d4da730fa16cd6" );
    var_bf65d868 = util::spawn_model( #"tag_origin", s_rpg.origin );
    var_5b61a3b6 = function_6588ca82( var_bf65d868, self, 1, 0, 500 );
    var_5b61a3b6 setstablemissile( 1 );
    var_5b61a3b6 waittilltimeout( 1.25, #"death", #"explode" );
    
    if ( isdefined( var_5b61a3b6 ) )
    {
        var_5b61a3b6 detonate();
    }
    
    var_bf65d868 delete();
    self thread function_b7727676( 0 );
    self thread function_c97e7d1b( 4.5, 1 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 5
// Checksum 0xfc2ccc86, Offset: 0x14028
// Size: 0x170
function function_6588ca82( e_source, e_target, var_c81911e = 0, var_855e955d = 1, var_66732ef3 = 2000 )
{
    var_f4de797f = getweapon( #"hash_1e25706a023b5e09" );
    v_source = e_source.origin;
    
    if ( isactor( e_source ) )
    {
        v_source = e_source function_204d1e9a();
    }
    
    v_velocity = vectornormalize( e_target.origin - v_source ) * var_66732ef3;
    
    if ( var_c81911e )
    {
        var_5b61a3b6 = e_source magicmissile( var_f4de797f, v_source, v_velocity, e_target );
    }
    else
    {
        var_5b61a3b6 = e_source magicmissile( var_f4de797f, v_source, v_velocity );
    }
    
    if ( var_855e955d )
    {
        level thread function_7d2ad92b( var_5b61a3b6 );
    }
    
    return var_5b61a3b6;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xd3c7842c, Offset: 0x141a0
// Size: 0x5c
function function_7d2ad92b( var_5b61a3b6 )
{
    if ( !isdefined( var_5b61a3b6 ) )
    {
        return;
    }
    
    var_5b61a3b6 endon( #"death", #"explode" );
    wait 2;
    var_5b61a3b6 detonate();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x3c4ade26, Offset: 0x14208
// Size: 0x24c
function function_a3c825cd()
{
    self notify( "60d6b0668835054f" );
    self endon( "60d6b0668835054f" );
    self endon( #"death", #"hash_276be8c3ece06e32" );
    
    /#
        if ( getdvarint( #"hash_3b90a67ea0b6081b", 0 ) >= 2 )
        {
            return;
        }
    #/
    
    var_f4de797f = getweapon( #"hash_1e25706a023b5e09" );
    
    if ( self.weapon != var_f4de797f )
    {
        return;
    }
    
    self.holdfire = 1;
    var_9051f4a3 = level.var_9051f4a3;
    var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;
    
    while ( true )
    {
        if ( !self isatgoal() )
        {
            self waittill( #"goal" );
            wait 1;
        }
        
        while ( !self function_8c4583b() )
        {
            wait 0.1;
        }
        
        while ( self function_8c4583b() )
        {
            if ( is_true( var_9051f4a3.var_6a3bc516 ) )
            {
                wait 0.1;
                continue;
            }
            
            var_9051f4a3.var_6a3bc516 = 1;
            level thread function_f14ccc68();
            
            if ( false )
            {
                var_5b61a3b6 = function_6588ca82( self, var_78bd98cb, 1 );
                var_9051f4a3.var_cf754a79 = 1;
                level thread function_945d2383( var_5b61a3b6 );
            }
            else
            {
                function_6588ca82( self, var_78bd98cb );
            }
            
            wait randomfloatrange( 4, 5 );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x516ea1b8, Offset: 0x14460
// Size: 0x10e, Type: bool
function function_8c4583b()
{
    if ( level.player isnotarget() )
    {
        return false;
    }
    
    var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;
    
    if ( !isdefined( var_78bd98cb ) )
    {
        return false;
    }
    
    if ( is_true( self.ignoreall ) || !self isatgoal() )
    {
        return false;
    }
    
    if ( distancesquared( self.origin, var_78bd98cb.origin ) > sqr( 8000 ) )
    {
        return false;
    }
    
    if ( !bullettracepassed( self function_204d1e9a(), var_78bd98cb.origin, 1, var_78bd98cb ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xebe30197, Offset: 0x14578
// Size: 0x4a
function function_204d1e9a()
{
    return self gettagorigin( "tag_flash" ) + anglestoforward( self.angles ) * 64;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x5e1e0019, Offset: 0x145d0
// Size: 0x46
function function_f14ccc68()
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    wait 0.6;
    var_9051f4a3.var_6a3bc516 = 0;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xfbfa9f79, Offset: 0x14620
// Size: 0x5e
function function_945d2383( var_5b61a3b6 )
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    
    while ( isdefined( var_5b61a3b6 ) )
    {
        waitframe( 1 );
    }
    
    wait 4;
    var_9051f4a3.var_cf754a79 = 0;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xc152ffea, Offset: 0x14688
// Size: 0x1e8
function function_ef4f929e()
{
    level.var_9051f4a3 endon( #"skipped" );
    var_27240fa9 = function_aa2f407c( "sp_vh_ripcord_cliff_defenders" );
    level flag::wait_till( #"hash_2c292d90841ea555" );
    a_ai_spawned = function_aa2f407c( "sp_ripcord_cliff_defenders", undefined, 0, 1, &function_7c5d5d43 );
    level flag::wait_till( #"hash_6262020fe28bc726" );
    
    foreach ( var_2e8e92e in var_27240fa9 )
    {
        if ( isalive( var_2e8e92e ) )
        {
            var_2e8e92e kill();
        }
    }
    
    foreach ( ai_spawned in a_ai_spawned )
    {
        if ( isalive( ai_spawned ) )
        {
            ai_spawned thread ai::bloody_death();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xa15e5608, Offset: 0x14878
// Size: 0x1e4
function function_7c5d5d43()
{
    self endon( #"death" );
    self val::set( #"hash_1836e54ed9ab516", "ignoreall", 1 );
    level flag::wait_till( #"hash_6aff13acab5241ed" );
    wait randomfloatrange( 0.1, 0.2 );
    self val::reset( #"hash_1836e54ed9ab516", "ignoreall" );
    self function_c9e47ce7();
    nd_current = self.goalnode;
    nd_next = getnode( nd_current.target, "targetname" );
    self setgoal( nd_next, 1 );
    self waittill( #"goal" );
    wait randomfloatrange( 0.1, 0.2 );
    level flag::wait_till( #"hash_5591beeee14423dd" );
    wait randomfloatrange( 0.1, 0.3 );
    nd_current = self.goalnode;
    var_df0210a2 = getnode( nd_current.target, "targetname" );
    self setgoal( var_df0210a2, 1 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xdc10de7a, Offset: 0x14a68
// Size: 0x288
function function_b72590f1()
{
    level.var_9051f4a3 endon( #"skipped" );
    var_2e0881c2 = function_aa2f407c( "sp_ripcord_rpgs_01" );
    var_a21e5c7c = function_aa2f407c( "sp_vh_ripcord_rpg_teams_north" );
    level flag::wait_till( #"hash_624585ec0b1e15fa" );
    var_9a845ac0 = function_aa2f407c( "sp_ripcord_rpg_teams_north" );
    var_ac45fe43 = function_aa2f407c( "sp_ripcord_rpg_team_north_01" );
    var_770793c7 = function_aa2f407c( "sp_ripcord_rpg_team_north_02" );
    level flag::wait_till( #"hash_57c6ee97826e6249" );
    
    foreach ( var_ff72be84 in var_a21e5c7c )
    {
        if ( isalive( var_ff72be84 ) )
        {
            var_ff72be84 kill();
        }
    }
    
    var_eb5353bb = arraycombine( var_2e0881c2, var_9a845ac0 );
    var_eb5353bb = arraycombine( var_eb5353bb, var_ac45fe43 );
    var_eb5353bb = arraycombine( var_eb5353bb, var_770793c7 );
    
    foreach ( var_4e7c260f in var_eb5353bb )
    {
        if ( isalive( var_4e7c260f ) )
        {
            var_4e7c260f thread ai::bloody_death();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x680666eb, Offset: 0x14cf8
// Size: 0x144
function function_2a10e512()
{
    level.var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_2dfb720e0ae80724" );
    
    while ( true )
    {
        wait 1;
        
        foreach ( var_4e75a347 in getfakeaiarray() )
        {
            if ( is_true( var_4e75a347.drone.isdead ) && !level.player util::is_player_looking_at( var_4e75a347.origin, 0.8, 1, var_4e75a347, level.var_53bb8ef2.var_78bd98cb ) )
            {
                var_4e75a347 delete();
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x4e2878c8, Offset: 0x14e48
// Size: 0x3c, Type: bool
function function_335f38a0( var_4e75a347 )
{
    return !isdefined( var_4e75a347 ) || is_true( var_4e75a347.drone.isdead );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x9a304d7a, Offset: 0x14e90
// Size: 0x80
function function_e16259ed( var_4180f434 )
{
    if ( !isdefined( var_4180f434 ) )
    {
        return [];
    }
    
    for ( i = 0; i < var_4180f434.size ; i++ )
    {
        if ( function_335f38a0( var_4180f434[ i ] ) )
        {
            var_4180f434[ i ] = -1;
        }
    }
    
    arrayremovevalue( var_4180f434, -1 );
    return var_4180f434;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 7
// Checksum 0x57b2547d, Offset: 0x14f18
// Size: 0xb4
function function_a98e77d5( str_name, var_de4a9f7a, var_62e5c9d9, var_f532cfce, var_9e70224a, var_3ba94e96, var_4a90b33c )
{
    s_breach = spawnstruct();
    s_breach.var_4180f434 = [];
    s_breach.var_de4a9f7a = var_de4a9f7a;
    s_breach.var_62e5c9d9 = var_62e5c9d9;
    level.var_9051f4a3.var_6ae38a69[ str_name ] = s_breach;
    level thread function_cece544c( str_name, var_62e5c9d9, var_f532cfce, var_9e70224a, var_3ba94e96, var_4a90b33c );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0x9cad9ef4, Offset: 0x14fd8
// Size: 0x46
function function_d1490330( str_name, var_de4a9f7a )
{
    s_breach = level.var_9051f4a3.var_6ae38a69[ str_name ];
    s_breach.var_de4a9f7a = var_de4a9f7a;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 6
// Checksum 0xba372b94, Offset: 0x15028
// Size: 0x4e0
function function_cece544c( str_name, var_62e5c9d9, var_f532cfce, var_9e70224a, var_3ba94e96, var_4a90b33c )
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_2dfb720e0ae80724", #"hash_6e5d171aabf4f2f9" );
    s_breach = var_9051f4a3.var_6ae38a69[ str_name ];
    var_7c192175 = struct::get_array( var_f532cfce );
    var_46e5370e = struct::get_array( var_9e70224a );
    a_spawners = getspawnerarray( var_3ba94e96, "targetname" );
    var_d36bacb3 = array::randomize( var_7c192175 );
    var_f766cd1c = array::randomize( var_46e5370e );
    
    if ( isdefined( var_4a90b33c ) )
    {
        var_2df413d3 = getent( var_4a90b33c, "targetname" );
    }
    
    while ( !level flag::get( var_62e5c9d9 ) )
    {
        arrayremovevalue( var_9051f4a3.var_b6fdd6f2, undefined );
        var_2b48934b = function_cf993931( str_name );
        var_de4a9f7a = function_6a618669( str_name );
        var_eabc4a23 = var_2b48934b.size;
        
        if ( var_eabc4a23 < var_de4a9f7a )
        {
            if ( math::cointoss() )
            {
                if ( var_d36bacb3.size <= 0 )
                {
                    var_d36bacb3 = array::randomize( var_7c192175 );
                }
                
                s_spawn = var_d36bacb3[ 0 ];
                arrayremoveindex( var_d36bacb3, 0 );
            }
            else
            {
                if ( var_f766cd1c.size <= 0 )
                {
                    var_f766cd1c = array::randomize( var_46e5370e );
                }
                
                s_spawn = var_f766cd1c[ 0 ];
                arrayremoveindex( var_f766cd1c, 0 );
            }
            
            spawner = array::random( a_spawners );
            spawner.origin = s_spawn.origin;
            spawner.angles = s_spawn.angles;
            spawner.target = s_spawn.target;
            spawner.script_moveplaybackrate = 0.75;
            var_4e75a347 = spawner::simple_spawn_single( spawner, &function_158cdaa, s_spawn );
            
            if ( isdefined( var_4e75a347 ) )
            {
                var_4e75a347.var_36ceff65 = 1;
                
                if ( !isdefined( var_9051f4a3.var_6ae38a69[ str_name ].var_4180f434 ) )
                {
                    var_9051f4a3.var_6ae38a69[ str_name ].var_4180f434 = [];
                }
                else if ( !isarray( var_9051f4a3.var_6ae38a69[ str_name ].var_4180f434 ) )
                {
                    var_9051f4a3.var_6ae38a69[ str_name ].var_4180f434 = array( var_9051f4a3.var_6ae38a69[ str_name ].var_4180f434 );
                }
                
                var_9051f4a3.var_6ae38a69[ str_name ].var_4180f434[ var_9051f4a3.var_6ae38a69[ str_name ].var_4180f434.size ] = var_4e75a347;
                var_4e75a347.var_1eca86c3 = str_name;
                
                if ( math::cointoss( 75 ) )
                {
                    var_4e75a347 namespace_4e75a347::function_cab4b520( "ALERT" );
                }
                else
                {
                    var_4e75a347 thread function_2176dc7e();
                }
                
                if ( isdefined( var_2df413d3 ) )
                {
                    var_4e75a347 thread function_21cf9a54( var_2df413d3 );
                }
            }
        }
        
        wait randomfloatrange( 0.05, 0.15 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x66aa06d9, Offset: 0x15510
// Size: 0x18e
function function_248d029()
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    var_78bd98cb = level.var_53bb8ef2.var_78bd98cb;
    
    foreach ( str_name, s_breach in var_9051f4a3.var_6ae38a69 )
    {
        var_2b48934b = function_cf993931( str_name );
        
        for ( var_de4a9f7a = function_6a618669( str_name ); var_2b48934b.size > 0 && var_2b48934b.size > var_de4a9f7a ; var_de4a9f7a = function_6a618669( str_name ) )
        {
            ai_cleanup = arraygetfarthest( var_78bd98cb.origin, var_2b48934b );
            ai_cleanup kill();
            waitframe( 1 );
            var_2b48934b = function_cf993931( var_2b48934b );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x8edffbe, Offset: 0x156a8
// Size: 0x62
function function_cf993931( str_name )
{
    s_breach = level.var_9051f4a3.var_6ae38a69[ str_name ];
    
    if ( !isdefined( s_breach ) )
    {
        return [];
    }
    
    s_breach.var_4180f434 = function_e16259ed( s_breach.var_4180f434 );
    return s_breach.var_4180f434;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x4297ab7e, Offset: 0x15718
// Size: 0x2a
function function_6a618669( str_name )
{
    return level.var_9051f4a3.var_6ae38a69[ str_name ].var_de4a9f7a;
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xbda18acb, Offset: 0x15750
// Size: 0xf4
function function_2176dc7e()
{
    self endon( #"death", #"hash_276eb2b6c51bf236" );
    
    while ( true )
    {
        wait randomfloatrange( 0.5, 1 );
        n_shots = randomintrangeinclusive( 1, 5 );
        
        for ( i = 0; i < n_shots ; i++ )
        {
            playfxontag( #"weapon/fx8_muz_ar_acc_3p", self, "tag_flash" );
            
            if ( i + 1 < n_shots )
            {
                wait 0.05;
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x5efe8a9b, Offset: 0x15850
// Size: 0xec
function function_21cf9a54( var_2df413d3 )
{
    self endon( #"death" );
    
    while ( !self istouching( var_2df413d3 ) )
    {
        waitframe( 1 );
    }
    
    var_2b7aa68e = randomfloatrange( 1, 5 );
    self thread function_49bddccd( var_2b7aa68e );
    self waittill( #"hash_276eb2b6c51bf236" );
    var_e57270d7 = randomfloatrange( 1, 4 );
    self thread function_49bddccd( var_e57270d7 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x5b839fcd, Offset: 0x15948
// Size: 0x54
function function_49bddccd( n_delay )
{
    self notify( "1dfe08d310c9112f" );
    self endon( "1dfe08d310c9112f" );
    self endon( #"death" );
    wait n_delay;
    self kill();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xb0d573d2, Offset: 0x159a8
// Size: 0x1b8
function function_e53ae863( str_spawns )
{
    a_s_spawns = struct::get_array( str_spawns );
    
    foreach ( s_spawn in a_s_spawns )
    {
        s_spawn.var_29894783 = util::spawn_model( #"tag_origin", s_spawn.origin, s_spawn.angles );
        playfxontag( #"hash_4aeb2425485e527", s_spawn.var_29894783, "tag_origin" );
        
        if ( !isdefined( level.var_9051f4a3.var_cd3317e9 ) )
        {
            level.var_9051f4a3.var_cd3317e9 = [];
        }
        else if ( !isarray( level.var_9051f4a3.var_cd3317e9 ) )
        {
            level.var_9051f4a3.var_cd3317e9 = array( level.var_9051f4a3.var_cd3317e9 );
        }
        
        level.var_9051f4a3.var_cd3317e9[ level.var_9051f4a3.var_cd3317e9.size ] = s_spawn;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x61b9ac17, Offset: 0x15b68
// Size: 0x100
function function_b7c8bf68( str_spawns )
{
    if ( !isdefined( str_spawns ) )
    {
        a_s_spawns = isdefined( level.var_9051f4a3.var_cd3317e9 ) ? level.var_9051f4a3.var_cd3317e9 : [];
    }
    else
    {
        a_s_spawns = struct::get_array( str_spawns );
    }
    
    foreach ( s_spawn in a_s_spawns )
    {
        if ( isdefined( s_spawn.var_29894783 ) )
        {
            s_spawn.var_29894783 delete();
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xfe998dfc, Offset: 0x15c70
// Size: 0x108
function function_9aecf345()
{
    var_c37e0cf5 = struct::get_array( #"hash_6bd970367d86682e" );
    var_c37e0cf5 = array::sort_by_script_int( var_c37e0cf5, 1 );
    
    foreach ( i, var_85e471f5 in var_c37e0cf5 )
    {
        playfx( #"hash_68a62bc3d5b15568", var_85e471f5.origin );
        
        if ( i == 0 )
        {
            wait 1;
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xe5ba7d2e, Offset: 0x15d80
// Size: 0x300
function function_43a56026()
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    a_spawners = getspawnerarray( "sp_ripcord_breach_02_line_battle", "targetname" );
    a_s_spawns = struct::get_array( #"hash_11242b0fdc2d3200" );
    a_s_remaining = array::randomize( a_s_spawns );
    var_b88b12ff = [];
    
    while ( !level flag::get( #"hash_44b60e500cfd1235" ) )
    {
        var_9051f4a3.var_8f7933bf = function_e16259ed( var_9051f4a3.var_8f7933bf );
        
        if ( var_b88b12ff.size < a_s_spawns.size && var_9051f4a3.var_8f7933bf.size < var_9051f4a3.var_3f0cf76d )
        {
            if ( a_s_remaining.size <= 0 )
            {
                a_s_remaining = array::randomize( a_s_spawns );
            }
            
            s_spawn = a_s_remaining[ 0 ];
            arrayremoveindex( a_s_remaining, 0 );
            spawner = array::random( a_spawners );
            spawner.origin = s_spawn.origin;
            spawner.angles = s_spawn.angles;
            spawner.target = s_spawn.target;
            spawner.script_moveplaybackrate = 0.75;
            var_4e75a347 = spawner::simple_spawn_single( spawner, &function_e5184fac );
            
            if ( isdefined( var_4e75a347 ) )
            {
                if ( !isdefined( var_b88b12ff ) )
                {
                    var_b88b12ff = [];
                }
                else if ( !isarray( var_b88b12ff ) )
                {
                    var_b88b12ff = array( var_b88b12ff );
                }
                
                var_b88b12ff[ var_b88b12ff.size ] = var_4e75a347;
                
                if ( !isdefined( var_9051f4a3.var_8f7933bf ) )
                {
                    var_9051f4a3.var_8f7933bf = [];
                }
                else if ( !isarray( var_9051f4a3.var_8f7933bf ) )
                {
                    var_9051f4a3.var_8f7933bf = array( var_9051f4a3.var_8f7933bf );
                }
                
                var_9051f4a3.var_8f7933bf[ var_9051f4a3.var_8f7933bf.size ] = var_4e75a347;
            }
        }
        
        wait randomfloatrange( 0.5, 1 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xf1e4bf39, Offset: 0x16088
// Size: 0x74
function function_e5184fac()
{
    self endon( #"death" );
    self function_158cdaa();
    self.var_1eca86c3 = #"breach_02";
    wait randomfloatrange( 10, 15 );
    self kill();
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xa0e865c9, Offset: 0x16108
// Size: 0xa8
function function_755d640()
{
    var_c37e0cf5 = struct::get_array( "s_ripcord_ambient_explosions" );
    
    foreach ( var_85e471f5 in var_c37e0cf5 )
    {
        var_85e471f5 thread function_ae163871();
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x49e214e2, Offset: 0x161b8
// Size: 0x260
function function_ae163871()
{
    level.var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_2dfb720e0ae80724", #"hash_1ef3a1febf52c90e" );
    self.radius = float( self.radius );
    v_angles = ( 270, 0, 0 );
    v_forward = anglestoforward( v_angles );
    v_up = anglestoup( v_angles );
    
    while ( true )
    {
        wait randomfloatrange( 30, 60 );
        n_x = randomfloat( self.radius );
        
        if ( math::cointoss() )
        {
            n_x *= -1;
        }
        
        n_y = randomfloat( self.radius );
        
        if ( math::cointoss() )
        {
            n_y *= -1;
        }
        
        v_trace = self.origin + ( n_x, n_y, 3000 );
        a_trace = groundtrace( v_trace, v_trace - ( 0, 0, 4000 ), 0, level.var_53bb8ef2.var_78bd98cb );
        
        if ( isdefined( a_trace[ #"position" ] ) && !isdefined( a_trace[ #"entity" ] ) )
        {
            playfx( #"hash_7e60569db9c36606", a_trace[ #"position" ], v_forward, v_up );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xc67a5678, Offset: 0x16420
// Size: 0x512
function function_faa719f()
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_2dfb720e0ae80724" );
    var_9051f4a3.var_69fc4412[ #"drone" ] = struct::get_array( #"hash_747ff813bf06bdb4" );
    var_9051f4a3.var_69fc4412[ #"drone_moving" ] = struct::get_array( #"hash_7af19991cf0b004b" );
    var_9051f4a3.var_69fc4412[ #"real" ] = struct::get_array( #"hash_4fb99e4c2563a902" );
    var_9051f4a3.var_69fc4412[ #"real_moving" ] = struct::get_array( #"hash_29dfe0db030ec589" );
    
    foreach ( str_type, a_s_spawns in var_9051f4a3.var_69fc4412 )
    {
        foreach ( s_spawn in a_s_spawns )
        {
            s_spawn.var_a1fc8c0d = gettime();
            s_spawn.var_c9a1df52 = str_type;
        }
    }
    
    var_f8308ae = getspawnerarray( "sp_ripcord_ambient_vc_drone", "targetname" );
    var_8a4dcdc9 = getspawnerarray( "sp_ripcord_ambient_vc_drone_moving", "targetname" );
    var_6219ad55 = getspawnerarray( "sp_ripcord_ambient_vc_real", "targetname" );
    
    while ( true )
    {
        foreach ( var_86e408fb in var_9051f4a3.var_69fc4412[ #"drone" ] )
        {
            function_bd6bc5e1( var_86e408fb, var_f8308ae );
        }
        
        foreach ( var_8f636700 in var_9051f4a3.var_69fc4412[ #"drone_moving" ] )
        {
            function_bd6bc5e1( var_8f636700, var_8a4dcdc9, 1 );
        }
        
        foreach ( var_87347f49 in var_9051f4a3.var_69fc4412[ #"real" ] )
        {
            function_977d452c( var_87347f49, var_6219ad55 );
        }
        
        foreach ( var_fc711531 in var_9051f4a3.var_69fc4412[ #"real_moving" ] )
        {
            function_977d452c( var_fc711531, var_6219ad55, 1 );
        }
        
        wait 1;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 3
// Checksum 0x9aaf2bbc, Offset: 0x16940
// Size: 0x3cc
function function_bd6bc5e1( s_spawn, a_spawners, var_e81f32c5 = 0 )
{
    var_9051f4a3 = level.var_9051f4a3;
    
    if ( is_true( s_spawn.b_disabled ) )
    {
        arrayremovevalue( var_9051f4a3.var_69fc4412[ s_spawn.var_c9a1df52 ], s_spawn );
        return;
    }
    
    if ( !isdefined( s_spawn.var_4e75a347 ) || is_true( s_spawn.var_4e75a347.drone.isdead ) )
    {
        n_dist = sqr( 8000 );
        
        if ( isdefined( level.var_53bb8ef2.var_78bd98cb ) )
        {
            n_dist = distance2dsquared( s_spawn.origin, level.var_53bb8ef2.var_78bd98cb.origin );
        }
        
        if ( n_dist >= sqr( 8000 ) || !level.player util::is_player_looking_at( s_spawn.origin, 0.8, 1, level.var_53bb8ef2.var_78bd98cb ) )
        {
            v_spawn = s_spawn.origin;
            
            if ( !var_e81f32c5 )
            {
                v_spawn -= ( 0, 0, 64 );
            }
            
            spawner = array::random( a_spawners );
            spawner.origin = v_spawn;
            spawner.angles = s_spawn.angles;
            spawner.target = s_spawn.target;
            s_spawn.var_4e75a347 = spawner::simple_spawn_single( spawner, &function_6cf6a8c2, s_spawn );
            
            if ( isdefined( s_spawn.var_4e75a347 ) )
            {
                if ( !isdefined( var_9051f4a3.var_b6fdd6f2 ) )
                {
                    var_9051f4a3.var_b6fdd6f2 = [];
                }
                else if ( !isarray( var_9051f4a3.var_b6fdd6f2 ) )
                {
                    var_9051f4a3.var_b6fdd6f2 = array( var_9051f4a3.var_b6fdd6f2 );
                }
                
                var_9051f4a3.var_b6fdd6f2[ var_9051f4a3.var_b6fdd6f2.size ] = s_spawn.var_4e75a347;
                s_spawn.var_4e75a347.var_36ceff65 = 1;
                s_spawn.var_4e75a347.var_1adf387f = s_spawn;
                
                if ( math::cointoss( 75 ) )
                {
                    s_spawn.var_4e75a347 namespace_4e75a347::function_cab4b520( "ALERT" );
                }
                
                s_spawn.var_a1fc8c0d = gettime();
                
                if ( var_e81f32c5 )
                {
                    s_spawn.var_4e75a347 thread function_69f58ded( s_spawn );
                }
            }
        }
        
        return;
    }
    
    n_lifetime = randomfloat( 120 );
    
    if ( float( gettime() - s_spawn.var_a1fc8c0d ) / 1000 >= n_lifetime )
    {
        s_spawn.var_4e75a347 kill();
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xb8143dd7, Offset: 0x16d18
// Size: 0x9e
function function_69f58ded( s_spawn )
{
    self endon( #"death" );
    self thread namespace_4e75a347::drone_fight( s_spawn.script_noteworthy );
    wait randomfloat( 5 );
    self notify( #"hash_1b1ebb63b6197fd7" );
    self animation::stop( 0, 1 );
    waitframe( 1 );
    self notify( #"move" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 3
// Checksum 0xa8ba1c2e, Offset: 0x16dc0
// Size: 0x334
function function_977d452c( s_spawn, a_spawners, var_e81f32c5 = 0 )
{
    var_9051f4a3 = level.var_9051f4a3;
    
    if ( is_true( s_spawn.b_disabled ) )
    {
        arrayremovevalue( var_9051f4a3.var_69fc4412[ s_spawn.var_c9a1df52 ], s_spawn );
        return;
    }
    
    if ( !isalive( s_spawn.ai_spawned ) )
    {
        n_dist = sqr( 8000 );
        
        if ( isdefined( level.var_53bb8ef2.var_78bd98cb ) )
        {
            n_dist = distance2dsquared( s_spawn.origin, level.var_53bb8ef2.var_78bd98cb.origin );
        }
        
        if ( n_dist >= sqr( 8000 ) || !level.player util::is_player_looking_at( s_spawn.origin, 0.8, 1, level.var_53bb8ef2.var_78bd98cb ) )
        {
            s_spawn.ai_spawned = spawner::simple_spawn_single( array::random( a_spawners ), &function_6cf6a8c2, s_spawn, !var_e81f32c5, 0 );
            
            if ( isdefined( s_spawn.ai_spawned ) )
            {
                if ( !isdefined( var_9051f4a3.var_b6fdd6f2 ) )
                {
                    var_9051f4a3.var_b6fdd6f2 = [];
                }
                else if ( !isarray( var_9051f4a3.var_b6fdd6f2 ) )
                {
                    var_9051f4a3.var_b6fdd6f2 = array( var_9051f4a3.var_b6fdd6f2 );
                }
                
                var_9051f4a3.var_b6fdd6f2[ var_9051f4a3.var_b6fdd6f2.size ] = s_spawn.ai_spawned;
                s_spawn.ai_spawned.var_36ceff65 = 1;
                s_spawn.ai_spawned.var_1adf387f = s_spawn;
                s_spawn.ai_spawned function_68c964c3( s_spawn );
                s_spawn.ai_spawned.grenadeammo = 0;
                s_spawn.var_a1fc8c0d = gettime();
                
                if ( var_e81f32c5 )
                {
                    s_spawn.ai_spawned thread function_59bffb65( s_spawn );
                }
            }
        }
        
        return;
    }
    
    n_lifetime = randomfloat( 120 );
    
    if ( float( gettime() - s_spawn.var_a1fc8c0d ) / 1000 >= n_lifetime )
    {
        s_spawn.ai_spawned kill();
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x910fc90b, Offset: 0x17100
// Size: 0x2a4
function function_59bffb65( s_spawn )
{
    self endon( #"death" );
    goal = struct::get( s_spawn.target );
    
    if ( !isdefined( goal ) )
    {
        goal = getnode( s_spawn.target, "targetname" );
    }
    
    if ( !isdefined( goal ) )
    {
        return;
    }
    
    self setdesiredspeed( "sprint" );
    var_f77fa2d4 = math::cointoss( 75 );
    
    if ( !var_f77fa2d4 )
    {
        var_4f401c38 = goal.target;
        
        while ( isdefined( var_4f401c38 ) )
        {
            next_goal = struct::get( var_4f401c38 );
            
            if ( !isdefined( next_goal ) )
            {
                next_goal = getnode( var_4f401c38, "targetname" );
            }
            
            if ( isdefined( next_goal.target ) )
            {
                var_4f401c38 = next_goal.target;
                continue;
            }
            
            break;
        }
        
        if ( !isdefined( var_4f401c38 ) )
        {
            var_4f401c38 = goal.targetname;
        }
        
        var_d55bf3de = struct::get( var_4f401c38 );
        
        if ( !isdefined( var_d55bf3de ) )
        {
            var_d55bf3de = getnode( var_4f401c38, "targetname" );
        }
    }
    
    wait randomfloat( 5 );
    
    if ( var_f77fa2d4 )
    {
        self clearentitytarget();
        self val::set( #"hash_1836e54ed9ab516", "ignoreall", 1 );
    }
    else if ( isdefined( var_d55bf3de ) )
    {
        self function_68c964c3( var_d55bf3de );
    }
    
    self thread spawner::go_to_node( goal );
    
    if ( var_f77fa2d4 )
    {
        self waittill( #"reached_path_end" );
        self function_68c964c3( self.goalnode );
        self val::reset( #"hash_1836e54ed9ab516", "ignoreall" );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0xb5979556, Offset: 0x173b0
// Size: 0x120
function function_68c964c3( var_8d075cb6 = self )
{
    var_fa4eb7a2 = level.var_9051f4a3.var_fa4eb7a2[ util::get_enemy_team( self.team ) ];
    arrayremovevalue( var_fa4eb7a2, undefined );
    
    foreach ( var_2cd0eff2 in var_fa4eb7a2 )
    {
        if ( var_8d075cb6 math::get_dot_forward( var_2cd0eff2.origin, 1 ) <= 0.3 )
        {
            self setignoreent( var_2cd0eff2, 1 );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xf534ae56, Offset: 0x174d8
// Size: 0x428
function function_c3e83ca1()
{
    level.var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_2dfb720e0ae80724" );
    var_417d6b44 = struct::get_array( #"hash_44e31e4fbb8893a7" );
    
    foreach ( var_91da74ae in var_417d6b44 )
    {
        var_91da74ae.n_time_since_last_shot = 0;
    }
    
    w_weapon = getweapon( #"hash_4ff481a4f55ed901" );
    var_7fa7e662 = util::spawn_model( #"tag_origin" );
    var_7fa7e662 setteam( #"allies" );
    
    while ( true )
    {
        foreach ( var_91da74ae in var_417d6b44 )
        {
            n_delay = randomfloatrange( 0.1, 1 );
            
            if ( var_91da74ae.n_time_since_last_shot >= n_delay )
            {
                v_source = var_91da74ae.origin;
                v_angles = var_91da74ae.angles;
                
                for ( i = 0; i < 2 ; i++ )
                {
                    v_offset = ( 0, 0, 0 );
                    
                    for ( j = 0; j < 3 ; j++ )
                    {
                        n_offset = randomfloat( 16 );
                        
                        if ( math::cointoss() )
                        {
                            n_offset *= -1;
                        }
                        
                        switch ( j )
                        {
                            case 0:
                                v_offset += ( n_offset, 0, 0 );
                                break;
                            case 1:
                                v_offset += ( 0, n_offset, 0 );
                                break;
                            case 2:
                                v_offset += ( 0, 0, n_offset );
                                break;
                        }
                    }
                    
                    switch ( i )
                    {
                        case 0:
                            v_source += v_offset;
                            break;
                        case 1:
                            v_angles += v_offset;
                            break;
                    }
                }
                
                magicbullet( w_weapon, v_source, v_source + anglestoforward( v_angles ) * 1024, var_7fa7e662 );
                var_91da74ae.n_time_since_last_shot = 0;
                continue;
            }
            
            var_91da74ae.n_time_since_last_shot += 0.1;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0xa565c5e, Offset: 0x17908
// Size: 0x660
function function_2f5a4827()
{
    var_9051f4a3 = level.var_9051f4a3;
    var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_2dfb720e0ae80724" );
    var_773577b4 = getspawnerarray( "sp_ripcord_ambient_runners", "targetname" );
    var_be4cdc25 = struct::get_array( #"hash_20ac5ee2789b6399" );
    
    foreach ( var_bd01b58f in var_be4cdc25 )
    {
        if ( !isdefined( var_bd01b58f.min_spawns ) )
        {
            var_bd01b58f.min_spawns = 1;
        }
        
        if ( !isdefined( var_bd01b58f.max_spawns ) )
        {
            var_bd01b58f.max_spawns = 2;
        }
        
        var_bd01b58f.min_spawns = int( var_bd01b58f.min_spawns );
        var_bd01b58f.max_spawns = int( var_bd01b58f.max_spawns );
        var_bd01b58f.var_a934617 = struct::get_array( var_bd01b58f.target );
        var_bd01b58f.var_831f3c76 = array::randomize( var_bd01b58f.var_a934617 );
    }
    
    var_9051f4a3.var_72364dd7 = [];
    
    while ( true )
    {
        foreach ( var_bd01b58f in var_be4cdc25 )
        {
            if ( !var_bd01b58f flag::get( #"engaged" ) && !var_bd01b58f flag::get( #"paused" ) )
            {
                if ( var_bd01b58f.var_831f3c76.size <= 0 )
                {
                    var_bd01b58f.var_831f3c76 = array::randomize( var_bd01b58f.var_a934617 );
                    
                    if ( isdefined( var_bd01b58f.var_3677c3bd ) )
                    {
                        arrayremovevalue( var_bd01b58f.var_831f3c76, var_bd01b58f.var_3677c3bd );
                    }
                }
                
                s_path = var_bd01b58f.var_831f3c76[ 0 ];
                arrayremoveindex( var_bd01b58f.var_831f3c76, 0 );
                var_bd01b58f.var_3677c3bd = s_path;
                
                if ( var_bd01b58f.min_spawns == var_bd01b58f.max_spawns )
                {
                    var_91152aeb = var_bd01b58f.max_spawns;
                }
                else
                {
                    var_91152aeb = randomintrangeinclusive( var_bd01b58f.min_spawns, var_bd01b58f.max_spawns );
                }
                
                var_9051f4a3.var_72364dd7 = function_e16259ed( var_9051f4a3.var_72364dd7 );
                
                while ( var_91152aeb > 0 && var_9051f4a3.var_72364dd7.size + var_91152aeb > 10 )
                {
                    var_91152aeb--;
                    var_9051f4a3.var_72364dd7 = function_e16259ed( var_9051f4a3.var_72364dd7 );
                }
                
                if ( var_91152aeb <= 0 )
                {
                    continue;
                }
                
                var_bd01b58f flag::set( #"engaged" );
                var_bd01b58f.var_ada0b21 = [];
                
                for ( i = 0; i < var_91152aeb ; i++ )
                {
                    var_e59e40b2 = array::random( var_773577b4 );
                    var_e59e40b2.origin = s_path.origin;
                    var_e59e40b2.angles = s_path.angles;
                    var_e59e40b2.target = s_path.target;
                    
                    while ( true )
                    {
                        var_46745ec4 = spawner::simple_spawn_single( var_e59e40b2, &function_158cdaa );
                        
                        if ( isdefined( var_46745ec4 ) )
                        {
                            var_46745ec4.var_36ceff65 = 1;
                            
                            if ( !isdefined( var_9051f4a3.var_72364dd7 ) )
                            {
                                var_9051f4a3.var_72364dd7 = [];
                            }
                            else if ( !isarray( var_9051f4a3.var_72364dd7 ) )
                            {
                                var_9051f4a3.var_72364dd7 = array( var_9051f4a3.var_72364dd7 );
                            }
                            
                            var_9051f4a3.var_72364dd7[ var_9051f4a3.var_72364dd7.size ] = var_46745ec4;
                            
                            if ( !isdefined( var_bd01b58f.var_ada0b21 ) )
                            {
                                var_bd01b58f.var_ada0b21 = [];
                            }
                            else if ( !isarray( var_bd01b58f.var_ada0b21 ) )
                            {
                                var_bd01b58f.var_ada0b21 = array( var_bd01b58f.var_ada0b21 );
                            }
                            
                            var_bd01b58f.var_ada0b21[ var_bd01b58f.var_ada0b21.size ] = var_46745ec4;
                            break;
                        }
                        
                        waitframe( 1 );
                    }
                }
                
                var_bd01b58f thread function_a3928a6c();
                var_bd01b58f thread function_51ba79bd();
            }
        }
        
        wait randomfloatrange( 2, 3 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x7c5f3acb, Offset: 0x17f70
// Size: 0x2a4
function function_a3928a6c()
{
    level.var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_2dfb720e0ae80724" );
    
    if ( self.var_ada0b21.size <= 1 )
    {
        foreach ( var_46745ec4 in self.var_ada0b21 )
        {
            var_46745ec4.var_c2c86d65 = 0;
            var_46745ec4 notify( #"move" );
        }
        
        return;
    }
    
    while ( true )
    {
        self.var_ada0b21 = function_e16259ed( self.var_ada0b21 );
        
        if ( self.var_ada0b21.size <= 0 )
        {
            return;
        }
        
        var_7dd9263b = self.var_ada0b21[ 0 ];
        arrayremoveindex( self.var_ada0b21, 0 );
        var_7dd9263b.var_c2c86d65 = 0;
        var_7dd9263b notify( #"move" );
        var_4936c2ce = var_7dd9263b.drone.run_speed;
        
        while ( !function_335f38a0( var_7dd9263b ) && !isdefined( var_4936c2ce ) )
        {
            var_4936c2ce = var_7dd9263b.drone.run_speed;
            waitframe( 1 );
        }
        
        if ( isdefined( var_4936c2ce ) )
        {
            break;
        }
    }
    
    foreach ( var_46745ec4 in self.var_ada0b21 )
    {
        wait randomfloatrange( 0.25, 2 );
        
        if ( !function_335f38a0( var_46745ec4 ) )
        {
            var_46745ec4.drone.run_speed = var_4936c2ce;
            var_46745ec4 notify( #"move" );
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x5f89cdde, Offset: 0x18220
// Size: 0x94
function function_51ba79bd()
{
    level.var_9051f4a3 endon( #"skipped" );
    level endon( #"hash_2dfb720e0ae80724" );
    
    while ( self.var_ada0b21.size > 0 )
    {
        self.var_ada0b21 = function_e16259ed( self.var_ada0b21 );
        wait 0.1;
    }
    
    self flag::clear( #"engaged" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x3156e7b3, Offset: 0x182c0
// Size: 0x2c
function function_a87fafa3()
{
    val::set( #"last_stand", "allowdeath", 0 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0x2b55f83e, Offset: 0x182f8
// Size: 0x168
function function_d623578b( *var_d3440450, *var_50cc0d4f, var_aa1a6455, *e_player )
{
    if ( !e_player )
    {
        return;
    }
    
    var_9051f4a3 = level.var_9051f4a3;
    
    if ( !is_true( var_9051f4a3.b_completed ) )
    {
        var_9051f4a3 notify( #"skipped" );
        
        if ( isdefined( var_9051f4a3.s_waypoint ) )
        {
            objectives::complete( "armada_obj_firebase_defend", var_9051f4a3.s_waypoint );
        }
        
        if ( isdefined( var_9051f4a3.var_b6fdd6f2 ) )
        {
            level thread function_fb080e60( var_9051f4a3.var_b6fdd6f2 );
        }
    }
    
    foreach ( var_5b5d5258 in var_9051f4a3.var_79de6b64 )
    {
        var_5b5d5258 flag::set( #"destroyed" );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x863c190f, Offset: 0x18468
// Size: 0x44
function function_47cfc791( *var_d3440450 )
{
    util::delay( 2, undefined, &snd::client_msg, #"hash_55704324b6ae9012" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 2
// Checksum 0xd921c715, Offset: 0x184b8
// Size: 0x91c
function function_2870229e( var_d3440450, var_50cc0d4f )
{
    var_539110f3 = level.var_539110f3;
    var_539110f3 endon( #"skipped" );
    function_a291d0f( var_d3440450, var_50cc0d4f );
    scene::function_27f5972e( #"hash_768798e8e7be9fe1" );
    scene::function_27f5972e( #"hash_72c6c90c740fc9de" );
    scene::function_27f5972e( #"armada_crash_start" );
    namespace_72b0499b::music( "tmp_grab_nuke" );
    var_96c2a0a6 = struct::get_array( #"hash_4483879458d31dab", "ripcord_ambient" );
    
    foreach ( var_bd01b58f in var_96c2a0a6 )
    {
        var_bd01b58f flag::set( #"paused" );
        
        if ( isdefined( var_bd01b58f.var_ada0b21 ) )
        {
            foreach ( var_46745ec4 in var_bd01b58f.var_ada0b21 )
            {
                if ( !function_335f38a0( var_46745ec4 ) )
                {
                    var_46745ec4 kill();
                }
            }
        }
    }
    
    if ( var_50cc0d4f )
    {
        spawner::simple_spawn_single( "sp_ripcord_landing_huey", &function_51a65f48 );
        level flag::set( #"hash_16d9badc5604cc63" );
    }
    
    /#
        if ( getdvarint( #"hash_3b90a67ea0b6081b", 0 ) >= 2 )
        {
            level.player val::set( #"hash_ca2667067306cf1", "<dev string:xdd>", 1 );
            level.player val::set( #"hash_ca2667067306cf1", "<dev string:xe9>", 0 );
            level.player val::set( #"hash_ca2667067306cf1", "<dev string:xf7>", 0 );
            n_seat = level.var_53bb8ef2.var_78bd98cb getoccupantseat( level.player );
            
            if ( isdefined( n_seat ) && n_seat >= 0 )
            {
                level.var_53bb8ef2.var_78bd98cb usevehicle( level.player, n_seat );
            }
            
            var_f98108c1 = struct::get( #"hash_6839f84b984b36ff" );
            level.player setorigin( var_f98108c1.origin );
            level.player setplayerangles( var_f98108c1.angles );
            return;
        }
    #/
    
    t_nuke_return = getent( "t_nuke_return", "targetname" );
    
    if ( !level.player istouching( t_nuke_return ) )
    {
        var_539110f3 = level.var_539110f3;
        var_539110f3.s_waypoint = struct::get( #"hash_2d00d540e2beca6b" );
        var_539110f3.var_805ed574 = #"nuke_return";
        level thread objectives::function_4eb5c04a( var_539110f3.var_805ed574, var_539110f3.s_waypoint, #"hash_7d1526cc7da37ff6", undefined, undefined, #"hash_5c53b6128244009d" );
        trigger::wait_till( "t_nuke_return", "targetname", level.player );
        objectives::complete( var_539110f3.var_805ed574, var_539110f3.s_waypoint );
        var_539110f3.s_waypoint = undefined;
    }
    
    level flag::set( #"hash_11ed3cb4b3a96f61" );
    function_208489a2( 1 );
    var_9051f4a3 = level.var_9051f4a3;
    
    if ( isdefined( var_9051f4a3.var_b6fdd6f2 ) )
    {
        level thread function_fb080e60( var_9051f4a3.var_b6fdd6f2, 1 );
    }
    
    if ( isdefined( level.var_53bb8ef2.var_78bd98cb ) )
    {
        level.var_53bb8ef2.var_78bd98cb vehicle::set_damage_fx_level( 0 );
    }
    
    level notify( #"hash_140019c0ef68a765" );
    objectives::scripted( #"nuke_secure", undefined, #"hash_616f95c1194ab2aa" );
    level clientfield::set( "toggle_gameplay_character_visibility", 0 );
    util::delay( 0.5, undefined, &helicopter::function_437dfc97 );
    util::delay( 0.5, undefined, &namespace_82bfe441::fade, 1, "FadeImmediate" );
    scene::add_scene_func( #"hash_768798e8e7be9fe1", &function_62f48e6c, "play" );
    level.player startcameratween( 0.5, 0, 1 );
    waitframe( 1 );
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level.var_7466d419 scene::play( #"hash_768798e8e7be9fe1", a_ents );
    
    if ( isdefined( level.var_7466d419.var_b01889cd ) )
    {
        level.var_7466d419.var_b01889cd delete();
    }
    
    scene::add_scene_func( #"hash_72c6c90c740fc9de", &function_372862d0, "done" );
    scene::add_scene_func( #"hash_72c6c90c740fc9de", &function_60899afd, "play" );
    a_ents = [];
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"vip" ] = level.vip;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level scene::play( #"hash_72c6c90c740fc9de", a_ents );
    var_539110f3.b_completed = 1;
    objectives::complete( #"nuke_secure" );
    skipto::function_4e3ab877( var_d3440450 );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x65c3e371, Offset: 0x18de0
// Size: 0x2dc
function function_62f48e6c( *a_ents )
{
    level.var_7466d419 setvehicletype( #"hash_308369147254321b" );
    level.var_7466d419 cleargoalyaw();
    level.var_7466d419 cleartargetyaw();
    level.var_7466d419 vehclearlookat();
    level.var_7466d419 setspeed( 100, 50, 50 );
    level.var_7466d419 setyawspeed( 100, 50, 50 );
    level.var_7466d419 setmaxpitchroll( 0, 0 );
    var_28437f5c = struct::get( #"hash_3dcc0da8f1013d06" );
    n_yaw = int( var_28437f5c.angles[ 1 ] );
    level.var_7466d419 setgoalyaw( n_yaw );
    level.var_7466d419 settargetyaw( n_yaw );
    level.var_7466d419 function_a57c34b7( var_28437f5c.origin, 1 );
    level.var_7466d419 setgoal( var_28437f5c.origin, 1 );
    level.var_7466d419.var_b01889cd = util::spawn_model( #"tag_origin", level.var_7466d419.origin, level.var_7466d419.angles );
    level.var_7466d419 linkto( level.var_7466d419.var_b01889cd );
    level.var_7466d419.var_b01889cd moveto( var_28437f5c.origin, 3, 0, 1 );
    wait 0.5;
    
    if ( isdefined( level.var_7466d419.var_b01889cd ) )
    {
        level.var_7466d419.var_b01889cd rotateto( var_28437f5c.angles, 3, 1, 2 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x7e453c2b, Offset: 0x190c8
// Size: 0xbc
function function_60899afd( *a_ents )
{
    level thread exploder::exploder( "fx_firebase_nukeretrieve_downdraft" );
    level thread exploder::exploder( "fx_firebase_nukeretrieve" );
    level waittill( #"hash_65c7da1490ee3c0e" );
    level flag::set( #"hash_5b2bd051ba87df67" );
    level waittill( #"hash_4870e2c44b745c0e" );
    level flag::set( #"hash_4723793e58855abb" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x2b4bbf71, Offset: 0x19190
// Size: 0x3c
function function_372862d0( *a_ents )
{
    exploder::kill_exploder( "fx_firebase_nukeretrieve_downdraft" );
    exploder::kill_exploder( "fx_firebase_nukeretrieve" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 1
// Checksum 0x66df914c, Offset: 0x191d8
// Size: 0x110
function function_208489a2( var_7af285a8 = 0 )
{
    var_9051f4a3 = level.var_9051f4a3;
    
    if ( isdefined( var_9051f4a3.var_86c425b5 ) )
    {
        foreach ( var_7c0a5f3 in var_9051f4a3.var_86c425b5 )
        {
            if ( isdefined( var_7c0a5f3 ) )
            {
                if ( var_7af285a8 && is_true( var_7c0a5f3.var_83bc6615 ) )
                {
                    continue;
                }
                
                var_7c0a5f3 namespace_b7cfe907::function_5677b6eb();
                var_7c0a5f3 delete();
            }
        }
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x15dbd590, Offset: 0x192f0
// Size: 0xbc
function function_226ff16b()
{
    level.var_9051f4a3 endon( #"skipped" );
    level flag::wait_till_all( [ #"hash_3a020db7d8aa516c", #"hash_71b417d2e25ac7c1" ] );
    
    while ( true )
    {
        var_78bd98cb = spawner::simple_spawn_single( "sp_ripcord_landing_huey", &function_51a65f48 );
        
        if ( isdefined( var_78bd98cb ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 0
// Checksum 0x5aa18f58, Offset: 0x193b8
// Size: 0x174
function function_51a65f48()
{
    self endon( #"death" );
    self function_1b0fcde7( 1, 0 );
    self.var_83bc6615 = 1;
    self setmaxpitchroll( 20, 50 );
    self setspeed( 15 );
    self sethoverparams( 0 );
    self function_22761cc0( #"hash_5e078e3a1b990615", undefined, 0 );
    self setyawspeed( 20, 10, 10 );
    self function_22761cc0( #"hash_78ec7e18023d667e", undefined, 0 );
    self thread function_22761cc0( #"hash_3f19bbf95dd0e44e" );
    level flag::wait_till( #"hash_16d9badc5604cc63" );
    self setspeed( 10 );
    self function_22761cc0( #"hash_fe4acd6bf3140ca" );
}

// Namespace namespace_722cc932/cp_nam_armada
// Params 4
// Checksum 0xa89b64d, Offset: 0x19538
// Size: 0x234
function function_2ea27496( *var_d3440450, *var_50cc0d4f, var_aa1a6455, *e_player )
{
    var_53bb8ef2 = level.var_53bb8ef2;
    
    if ( isdefined( var_53bb8ef2.var_78bd98cb ) )
    {
        var_53bb8ef2.var_78bd98cb.overridevehicledamage = undefined;
    }
    
    level.overrideplayerdamage = undefined;
    var_96c2a0a6 = struct::get_array( #"hash_4483879458d31dab", "ripcord_ambient" );
    
    foreach ( var_bd01b58f in var_96c2a0a6 )
    {
        var_bd01b58f flag::clear( #"paused" );
    }
    
    level flag::set( #"hash_2dfb720e0ae80724" );
    var_9051f4a3 = level.var_9051f4a3;
    
    if ( isdefined( var_9051f4a3.var_b6fdd6f2 ) )
    {
        level thread function_fb080e60( var_9051f4a3.var_b6fdd6f2 );
    }
    
    level notify( #"hash_140019c0ef68a765" );
    level clientfield::set( "toggle_gameplay_character_visibility", 0 );
    
    if ( !e_player )
    {
        return;
    }
    
    var_539110f3 = level.var_539110f3;
    
    if ( !is_true( var_539110f3.b_completed ) )
    {
        var_539110f3 notify( #"skipped" );
        
        if ( isdefined( var_539110f3.var_805ed574 ) )
        {
            objectives::complete( var_539110f3.var_805ed574, var_539110f3.s_waypoint );
        }
    }
}

/#

    // Namespace namespace_722cc932/cp_nam_armada
    // Params 2
    // Checksum 0xf8a2fe95, Offset: 0x19778
    // Size: 0x18, Type: dev
    function function_c03bb520( *var_d3440450, *var_50cc0d4f )
    {
        
    }

    // Namespace namespace_722cc932/cp_nam_armada
    // Params 2
    // Checksum 0x184519a0, Offset: 0x19798
    // Size: 0x34, Type: dev
    function function_1061456b( *var_d3440450, *var_50cc0d4f )
    {
        namespace_b7cfe907::function_27e76b4c( "<dev string:x105>", 0 );
    }

    // Namespace namespace_722cc932/cp_nam_armada
    // Params 0, eflags: 0x4
    // Checksum 0xf37d6bec, Offset: 0x197d8
    // Size: 0x4b6, Type: dev
    function private function_eaba72c9()
    {
        self notify( "<dev string:x124>" );
        self endon( "<dev string:x124>" );
        var_7f91fe17 = 0;
        
        while ( true )
        {
            if ( getdvarint( #"hash_2c2688d7152d1e56", 0 ) > 0 )
            {
                if ( !level scene::is_playing( "<dev string:x138>", "<dev string:x152>" ) )
                {
                    level thread scene::play( "<dev string:x138>", "<dev string:x152>" );
                }
                
                setdvar( #"hash_2c2688d7152d1e56", 0 );
            }
            
            if ( getdvarint( #"hash_28822a1bcce307da", 0 ) > 0 )
            {
                if ( !level scene::is_playing( "<dev string:x162>" ) )
                {
                    level thread scene::play( "<dev string:x162>" );
                }
                
                setdvar( #"hash_28822a1bcce307da", 0 );
            }
            
            if ( getdvarint( #"hash_63e4407ed222d81a", 0 ) > 0 )
            {
                function_c3963aed();
                setdvar( #"hash_63e4407ed222d81a", 0 );
            }
            
            if ( getdvarint( #"hash_78e74121d07eb3ff", 0 ) > 0 )
            {
                function_43339e00();
                setdvar( #"hash_63e4407ed222d81a", 0 );
            }
            
            if ( getdvarint( #"hash_2335341888db9443", 0 ) > 0 )
            {
                oobtriggers = getentarray( "<dev string:x180>", "<dev string:x199>" );
                
                foreach ( trig in oobtriggers )
                {
                    trig triggerenable( var_7f91fe17 );
                }
                
                var_7f91fe17 = !var_7f91fe17;
                level notify( #"hash_1cf48096c380b7cd" );
                setdvar( #"hash_2335341888db9443", 0 );
            }
            
            if ( getdvarint( #"hash_6607aa92eb9e51e1", 0 ) > 0 )
            {
                if ( isdefined( level.var_b99c0779 ) )
                {
                    if ( level.var_b99c0779 getheliheightlock() )
                    {
                        level.var_b99c0779 setheliheightlock( 0 );
                        level.var_b99c0779 setheliheightcap( 0 );
                    }
                    else
                    {
                        level.var_b99c0779 setheliheightlock( 1 );
                        level.var_b99c0779 setheliheightcap( 1 );
                    }
                }
                
                if ( isdefined( level.var_7466d419 ) )
                {
                    if ( level.var_7466d419 getheliheightlock() )
                    {
                        level.var_7466d419 setheliheightlock( 0 );
                        level.var_7466d419 setheliheightcap( 0 );
                    }
                    else
                    {
                        level.var_7466d419 setheliheightlock( 1 );
                        level.var_7466d419 setheliheightcap( 1 );
                    }
                }
                
                setdvar( #"hash_6607aa92eb9e51e1", 0 );
            }
            
            waitframe( 1 );
        }
    }

    // Namespace namespace_722cc932/cp_nam_armada
    // Params 0, eflags: 0x4
    // Checksum 0xddd2e66c, Offset: 0x19c98
    // Size: 0x22c, Type: dev
    function private function_c3963aed()
    {
        if ( isdefined( level.var_b99c0779 ) )
        {
            if ( level.var_b99c0779 getseatoccupant( 0 ) === level.player || level.var_b99c0779 getseatoccupant( 1 ) === level.player || level.var_b99c0779 getseatoccupant( 2 ) === level.player || level.var_b99c0779 getseatoccupant( 5 ) === level.player )
            {
                return;
            }
            
            level.var_b99c0779.origin = level.player.origin + ( 0, 0, 1024 );
            level.var_b99c0779.angles = level.player.angles;
            level.var_b99c0779 usevehicle( level.player, 0 );
            return;
        }
        
        var_e3b71bd = getent( "<dev string:x1a6>", "<dev string:x8b>" );
        
        if ( !isdefined( var_e3b71bd ) )
        {
            return;
        }
        
        chopper = vehicle::simple_spawn_single( "<dev string:x1a6>" );
        chopper.origin = level.player.origin + ( 0, 0, 1024 );
        chopper.angles = level.player.angles;
        chopper usevehicle( level.player, 0 );
        chopper makeusable();
        level.var_b99c0779 = chopper;
    }

    // Namespace namespace_722cc932/cp_nam_armada
    // Params 0, eflags: 0x4
    // Checksum 0xea5b615f, Offset: 0x19ed0
    // Size: 0x166, Type: dev
    function private function_43339e00()
    {
        if ( isdefined( level.var_7466d419 ) && isdefined( level.player ) )
        {
            var_a462bbef = level.var_7466d419 getoccupantseat( level.player );
            
            if ( isdefined( var_a462bbef ) )
            {
                if ( var_a462bbef != -1 )
                {
                    level.var_7466d419.var_2067b085 = var_a462bbef;
                    level.var_7466d419 usevehicle( level.player, var_a462bbef );
                    return;
                }
                
                if ( isdefined( level.var_7466d419.var_2067b085 ) )
                {
                    level.var_7466d419 usevehicle( level.player, level.var_7466d419.var_2067b085 );
                    level.var_7466d419.var_2067b085 = undefined;
                    return;
                }
                
                level.var_7466d419 setseatoccupied( 2, 0 );
                level.var_7466d419 usevehicle( level.player, 2 );
                level.var_7466d419.var_2067b085 = undefined;
            }
        }
    }

    // Namespace namespace_722cc932/cp_nam_armada
    // Params 0, eflags: 0x4
    // Checksum 0xaa5ea637, Offset: 0x1a040
    // Size: 0x14c, Type: dev
    function private _setup_devgui()
    {
        while ( !canadddebugcommand() )
        {
            waitframe( 1 );
        }
        
        mapname = util::get_map_name();
        adddebugcommand( "<dev string:x1ba>" + mapname + "<dev string:x1cb>" );
        adddebugcommand( "<dev string:x1ba>" + mapname + "<dev string:x219>" );
        adddebugcommand( "<dev string:x1ba>" + mapname + "<dev string:x26d>" );
        adddebugcommand( "<dev string:x1ba>" + mapname + "<dev string:x2bf>" );
        adddebugcommand( "<dev string:x1ba>" + mapname + "<dev string:x302>" );
        adddebugcommand( "<dev string:x1ba>" + mapname + "<dev string:x340>" );
        level thread function_eaba72c9();
    }

#/
