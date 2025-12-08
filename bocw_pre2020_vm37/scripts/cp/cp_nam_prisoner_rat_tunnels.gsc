#using script_1351b3cdb6539f9b;
#using script_3dc93ca9902a9cda;
#using script_5a7c9cfbe3d9580c;
#using script_61fee52bb750ac99;
#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_nam_prisoner;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\util;

#namespace cp_nam_prisoner_rat_tunnels;

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0xc9e2a9dc, Offset: 0x728
// Size: 0x2c
function start( *str_objective )
{
    level thread function_4b429874( "rat_tunnels" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 2
// Checksum 0x5878fa87, Offset: 0x760
// Size: 0x11c
function main( str_objective, *var_50cc0d4f )
{
    if ( level.var_731c10af.var_42659717 == 0 )
    {
        next_obj = "path_end_1";
    }
    
    if ( level.var_731c10af.var_42659717 == 1 )
    {
        next_obj = "path_end_2";
    }
    
    if ( level.var_731c10af.var_42659717 == 2 )
    {
        next_obj = "path_end_3";
    }
    
    if ( level.var_731c10af.var_42659717 == 3 )
    {
        next_obj = "path_end_4";
    }
    
    level thread cp_nam_prisoner::function_1f911b89( next_obj );
    flag = "rat_tunnels";
    level flag::wait_till( flag + "_complete" );
    level skipto::function_4e3ab877( var_50cc0d4f, 0 );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 4
// Checksum 0x2d5b58e9, Offset: 0x888
// Size: 0x144
function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    wait 1;
    enemy_rat_tunnels_large = getentarray( "enemy_rat_tunnels_large", "targetname" );
    array::thread_all( enemy_rat_tunnels_large, &namespace_d9b153b9::ent_cleanup );
    enemy_rat_tunnels_hall = getentarray( "enemy_rat_tunnels_hall", "targetname" );
    array::thread_all( enemy_rat_tunnels_hall, &namespace_d9b153b9::ent_cleanup );
    rat_tunnels_triggers = getentarray( "rat_tunnels_triggers", "script_noteworthy" );
    array::thread_all( rat_tunnels_triggers, &namespace_d9b153b9::ent_cleanup );
    door_struct = namespace_d9b153b9::door_setup( "rat_tunnels_door_struct", 1, 1 );
    door_struct thread namespace_d9b153b9::ent_cleanup();
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xbbed5fb9, Offset: 0x9d8
// Size: 0xa4
function function_c26b0bc0()
{
    level flag::init( "rat_tunnels_complete" );
    level flag::init( "flag_rat_tunnels_obj_on" );
    level flag::init( "flag_disable_rat_tunnel_trap" );
    level flag::init( "flag_enable_rat_tunnel_trap_damage" );
    level flag::init( "flag_rat_tunnels_player_dead" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x7fa760f1, Offset: 0xa88
// Size: 0x194
function rat_tunnels()
{
    level endon( #"start_outro" );
    var_c79d614f = "rat_tunnels";
    level flag::wait_till( "flag_" + var_c79d614f );
    level.var_3f5c80c8 = "rat_tunnels";
    level thread savegame::checkpoint_save();
    var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
    str = "visit_" + var_2cf9fe23 + "_" + var_c79d614f;
    bb::function_cd497743( str, level.player );
    
    while ( true )
    {
        level thread namespace_d9b153b9::function_a57f6629( var_c79d614f );
        level function_a7ec2e8f( var_c79d614f );
        
        if ( level flag::get( var_c79d614f + "_complete" ) )
        {
            break;
        }
        
        wait 0.5;
        level flag::wait_till( "flag_" + var_c79d614f );
    }
    
    level thread scene::init( "scene_rat_tunnel_entrance" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0x52672a7, Offset: 0xc28
// Size: 0x174
function function_4b429874( var_c79d614f )
{
    level thread scene::init( "scene_rat_tunnel_entrance" );
    var_378b332b = struct::get( "struct_rat_tunnel_trap_door", "targetname" );
    var_271a2988 = spawn( "script_model", var_378b332b.origin );
    var_271a2988 setmodel( "tag_origin" );
    var_271a2988 util::create_cursor_hint( "tag_origin", ( 0, 0, 8 ), #"hash_4aba34f692d535a6", 300, undefined, undefined, undefined, 512 );
    thread function_c4c216b0( var_271a2988 );
    var_271a2988 waittill( #"trigger" );
    level flag::set( "flag_rat_tunnels" );
    thread namespace_b6fe1dbe::function_1e0e9b39( var_c79d614f );
    wait 2;
    level thread dialogue::radio( "vox_cp_prsn_02200_adlr_whyisfacingaway_ab" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0xbe3b7892, Offset: 0xda8
// Size: 0x64
function function_c4c216b0( var_271a2988 )
{
    var_271a2988 util::waittill_any_ents( var_271a2988, "trigger", level, "visit_restart" );
    var_271a2988 util::remove_cursor_hint();
    var_271a2988 delete();
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0xe3c75e7f, Offset: 0xe18
// Size: 0x18c
function function_a7ec2e8f( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( var_c79d614f + "_end" );
    level.disableweapondrop = 1;
    level thread function_a1c9e125();
    level thread function_6deb6ac2();
    level thread function_9bea58bf();
    level thread function_1fd8aab8( var_c79d614f );
    level thread function_782d78d1( var_c79d614f );
    level function_4e2f193b();
    level function_c0073eb7();
    level.disableweapondrop = 0;
    level flag::wait_till( var_c79d614f + "_door_opened" );
    namespace_d9b153b9::function_e106e062( var_c79d614f );
    level flag::set( var_c79d614f + "_complete" );
    level flag::set( var_c79d614f + "_exited" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0x874491f8, Offset: 0xfb0
// Size: 0x224
function function_1fd8aab8( *var_c79d614f )
{
    level thread namespace_d9b153b9::force_weapon_loadout( "rat_tunnels_fall" );
    var_4c7200d2 = getent( "clip_rat_tunnel_ladder", "targetname" );
    var_a5cfc1d9 = getentarray( "model_rat_tunnels_ladder", "targetname" );
    level thread namespace_b6fe1dbe::function_3047c3a4();
    var_4c7200d2 delete();
    
    foreach ( e_model in var_a5cfc1d9 )
    {
        e_model delete();
    }
    
    level.player enableinvulnerability();
    level scene::play( "scene_rat_tunnel_entrance", "shot 1" );
    level.player playrumbleonentity( "damage_heavy" );
    wait 1;
    level.player val::set( #"rat_tunnels_fall", "freezecontrols", 1 );
    level.player setstance( "crouch" );
    level.player disableinvulnerability();
    level flag::set( "flag_rat_tunnels_entrance_progression" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0x63a107b4, Offset: 0x11e0
// Size: 0x164
function function_782d78d1( var_c79d614f )
{
    level flag::wait_till( "flag_rat_tunnels_entrance_progression" );
    level thread namespace_b6fe1dbe::music( "9.0_zombies" );
    wait 1;
    level thread function_ef3d3d18( var_c79d614f );
    wait 3;
    level.player val::set( #"rat_tunnels_fall", "freezecontrols", 0 );
    level thread namespace_d9b153b9::force_weapon_loadout( "rat_tunnels" );
    level.player.var_cef36b49 = 0;
    level.player function_6afceef5();
    level.player thread function_441539b();
    level flag::wait_till( "flag_rat_tunnels_entrance_map" );
    level flag::wait_till( "flag_rat_tunnels_entrance_tunnel" );
    function_2c200d72( var_c79d614f );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0x750cbf78, Offset: 0x1350
// Size: 0xac
function function_2c200d72( *var_c79d614f )
{
    var_f1653cd7 = spawner::simple_spawn_single( "enemy_rat_tunnels_hall", &function_b331c583 );
    thread namespace_b6fe1dbe::function_8c05dc42( var_f1653cd7 );
    thread namespace_b6fe1dbe::rat_tunnels_amb_zombies();
    wait 2;
    
    if ( isalive( var_f1653cd7 ) )
    {
        util::stop_magic_bullet_shield( var_f1653cd7 );
        var_f1653cd7 delete();
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xc9f5977a, Offset: 0x1408
// Size: 0x9c
function function_9bea58bf()
{
    level thread namespace_d9b153b9::function_c318ce4a( "light_rat_tunnel_torch" );
    level thread namespace_d9b153b9::function_c318ce4a( "light_rat_tunnel_door" );
    level thread namespace_b508dca::function_ed113f39( 1, "rat_tunnels_door_struct" );
    level flag::wait_till( "flag_rat_tunnels_large_enter" );
    wait 3;
    thread namespace_b6fe1dbe::rat_tunnels_throb_high();
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xa9a4cb8c, Offset: 0x14b0
// Size: 0xd4
function function_6deb6ac2()
{
    e_model = getent( "model_rat_tunnel_rock_blocker", "targetname" );
    e_clip = getent( "clip_rat_tunnel_blocker", "targetname" );
    e_model hide();
    e_clip hide();
    level flag::wait_till( "flag_rat_tunnels_large_enter" );
    e_model show();
    e_clip show();
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xbb5668ca, Offset: 0x1590
// Size: 0xd4
function function_4e2f193b()
{
    level flag::wait_till( "flag_rat_tunnels_large_enter" );
    level thread savegame::checkpoint_save();
    level notify( #"hash_1f23b5e993149d88" );
    level.player val::set( "rat_fight", "allowdeath", 0 );
    callback::on_player_damage( &function_6b6ab2a9 );
    level childthread function_7c0058e9();
    wait 10;
    level function_67ae9ffa();
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xb74f59e2, Offset: 0x1670
// Size: 0xf2
function function_7c0058e9()
{
    i = 0;
    
    for ( wait_time = 6; true ; wait_time = 1 )
    {
        var_97f2da81 = function_152d5ce7();
        var_6758a09d = function_a7dd4e7f( var_97f2da81 );
        
        if ( level flag::get( "flag_rat_tunnels_player_dead" ) )
        {
            break;
        }
        
        if ( !isdefined( var_6758a09d ) )
        {
            waitframe( 1 );
            continue;
        }
        
        snd::play( "amb_rat_tunnels_zomb_amb", var_6758a09d.origin );
        wait wait_time;
        i += wait_time;
        wait_time -= 2;
        
        if ( wait_time < 1 )
        {
        }
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x433ecb86, Offset: 0x1770
// Size: 0x200
function function_67ae9ffa()
{
    thread function_a8e922fd();
    wait 5;
    thread function_a8e922fd();
    wait 5;
    i = 0;
    
    while ( i < 5 )
    {
        if ( level flag::get( "flag_rat_tunnels_player_dead" ) )
        {
            break;
        }
        
        thread function_a8e922fd();
        i++;
        
        if ( level flag::get( "flag_rat_tunnels_player_dead" ) )
        {
            break;
        }
        
        wait randomfloatrange( 2.5, 4 );
    }
    
    i = 0;
    
    while ( true )
    {
        if ( level flag::get( "flag_rat_tunnels_player_dead" ) )
        {
            break;
        }
        
        thread function_a8e922fd();
        i++;
        
        if ( level flag::get( "flag_rat_tunnels_player_dead" ) )
        {
            break;
        }
        
        if ( i >= 5 )
        {
            wait 0.25;
            thread function_a8e922fd();
            i++;
        }
        
        if ( level flag::get( "flag_rat_tunnels_player_dead" ) )
        {
            break;
        }
        
        if ( i >= 12 )
        {
            wait 0.25;
            thread function_a8e922fd();
            i++;
        }
        
        if ( level flag::get( "flag_rat_tunnels_player_dead" ) )
        {
            break;
        }
        
        wait randomfloatrange( 0.5, 3 );
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xb925f997, Offset: 0x1978
// Size: 0xc4
function function_a8e922fd()
{
    var_4caaf0f5 = function_bc8dde2();
    a_e_enemies = getaiteamarray( "axis" );
    
    if ( var_4caaf0f5.size - 1 > 0 && a_e_enemies.size <= 10 )
    {
        var_a881a891 = function_a7dd4e7f( var_4caaf0f5 );
        e_enemies = spawner::simple_spawn( var_a881a891, &function_4dab8b6d );
        ai::waittill_dead( e_enemies );
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x7dc7a3a6, Offset: 0x1a48
// Size: 0x52
function function_bc8dde2()
{
    var_b162e4f3 = getspawnerarray( "enemy_rat_tunnels_large", "targetname" );
    var_4caaf0f5 = function_f2189eab( var_b162e4f3 );
    return var_4caaf0f5;
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x921e67e1, Offset: 0x1aa8
// Size: 0x52
function function_152d5ce7()
{
    var_48dd9943 = struct::get_array( "struct_rat_tunnels_large", "targetname" );
    var_7aae50ea = function_f2189eab( var_48dd9943 );
    return var_7aae50ea;
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0x12363df5, Offset: 0x1b08
// Size: 0x112
function function_f2189eab( var_32ec319a )
{
    var_785516d0 = [];
    
    foreach ( s_object in var_32ec319a )
    {
        var_bdfc75d9 = level.player util::point_in_fov( s_object.origin, 0.423, 1 );
        
        if ( !var_bdfc75d9 )
        {
            if ( !isdefined( var_785516d0 ) )
            {
                var_785516d0 = [];
            }
            else if ( !isarray( var_785516d0 ) )
            {
                var_785516d0 = array( var_785516d0 );
            }
            
            var_785516d0[ var_785516d0.size ] = s_object;
        }
    }
    
    return var_785516d0;
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0x1bd7e53b, Offset: 0x1c28
// Size: 0x52
function function_a7dd4e7f( var_32ec319a )
{
    if ( var_32ec319a.size - 1 > 0 )
    {
        s_object = var_32ec319a[ randomint( var_32ec319a.size - 1 ) ];
        return s_object;
    }
    
    return undefined;
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0xf021f4bf, Offset: 0x1c88
// Size: 0x3cc
function function_6b6ab2a9( *params )
{
    var_7639372f = level.player getnormalhealth();
    
    if ( var_7639372f <= 0.25 )
    {
        level thread callback::remove_on_player_damage( &function_6b6ab2a9 );
        level.player.health = 1;
        level.player setstance( "prone" );
        level.player val::set( "teleport_controls", "freezecontrols", 1 );
        level thread lui::screen_fade_out( 0.5, "black" );
        level notify( #"hash_6092ec21fbb6a05" );
        level flag::set( "flag_rat_tunnels_player_dead" );
        wait 0.55;
        a_e_enemies = getactorarray( "axis" );
        
        foreach ( e_enemy in a_e_enemies )
        {
            if ( isalive( e_enemy ) )
            {
                e_enemy delete();
            }
        }
        
        util::function_323d3227();
        s_teleport = struct::get( "struct_rat_tunnels2_lookat_door", "targetname" );
        e_teleport = util::spawn_model( "tag_origin", s_teleport.origin, s_teleport.angles );
        level.player setorigin( e_teleport.origin );
        level.player playerlinktodelta( e_teleport, "tag_origin", 0, 0, 0, 0, 0 );
        thread namespace_b6fe1dbe::rat_tunnels_ambience_fade_out();
        level notify( #"rat_tunnels_ambience_fade_out" );
        wait 7;
        level thread lui::screen_fade_in( 0.5, "black" );
        wait 0.25;
        e_teleport delete();
        level.player unlink();
        level.player disableinvulnerability();
        level.player setstance( "stand" );
        level.player val::set( "teleport_controls", "freezecontrols", 0 );
        level.player val::set( "rat_fight", "allowdeath", 1 );
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x656c747e, Offset: 0x2060
// Size: 0x74
function function_c0073eb7()
{
    if ( level.player.var_cef36b49 )
    {
        level.player function_6afceef5();
    }
    
    level thread namespace_d9b153b9::function_b96db417( "light_rat_tunnel_door" );
    level thread namespace_b508dca::function_ed113f39( undefined, "rat_tunnels_door_struct" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xeedfc59b, Offset: 0x20e0
// Size: 0x7a
function function_b331c583()
{
    self.goalradius = 16;
    self.grenadeammo = 0;
    self.holdfire = 1;
    self.ignoreall = 1;
    self setdesiredspeed( 150 );
    self.forcesprint = 1;
    util::magic_bullet_shield( self );
    self.var_c681e4c1 = 1;
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x6f0b259, Offset: 0x2168
// Size: 0x17e
function function_4dab8b6d()
{
    self.goalradius = 16;
    self.grenadeammo = 0;
    self.holdfire = 1;
    self.forcesprint = 1;
    self.dontdropweapon = 1;
    self.var_c681e4c1 = 1;
    self.zombie_move_speed = "sprint";
    self setdesiredspeed( 250 );
    self ai::set_behavior_attribute( "disablearrivals", 1 );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self zombie_eye_glow::function_b43f92cd( 1 );
    self thread function_c82c7ffe();
    self thread function_42ac3805();
    
    while ( isalive( self ) )
    {
        if ( isdefined( level.player ) )
        {
            var_1c7be65d = getclosestpointonnavmesh( level.player.origin, 64, 16 );
            self thread ai::force_goal( var_1c7be65d );
        }
        
        waitframe( 1 );
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x327bff33, Offset: 0x22f0
// Size: 0x70
function function_c82c7ffe()
{
    while ( isalive( self ) )
    {
        snd::play( "amb_rat_tunnels_zomb_scream", [ self, "j_head" ] );
        wait randomfloatrange( 2, 6 );
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x7041042d, Offset: 0x2368
// Size: 0x78
function function_42ac3805()
{
    while ( isalive( self ) )
    {
        snd::play( "amb_rat_tunnels_zomb_step", [ self, "tag_origin" ] );
        wait randomfloatrange( 0.2, 0.3 );
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x34d2b66c, Offset: 0x23e8
// Size: 0xc8
function function_15ea2f81()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    self.var_c681e4c1 = 1;
    level flag::wait_till( "flag_rat_tunnels_alcove1" );
    
    while ( true )
    {
        level scene::play( "scene_rat_tunnels2_first_tunnel_alcove", "shot 3", self );
        level thread scene::play( "scene_rat_tunnels2_first_tunnel_alcove", "shot 2", self );
        wait randomfloatrange( 1.5, 3.25 );
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x4dd2aece, Offset: 0x24b8
// Size: 0x34
function function_441539b()
{
    level endon( #"hash_6092ec21fbb6a05" );
    level.player function_2d7d736();
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xa2dd4f22, Offset: 0x24f8
// Size: 0x38
function function_4f5b7f27()
{
    while ( !level.player.var_cef36b49 )
    {
        waitframe( 1 );
    }
    
    level notify( #"hash_24e533c13c2740b6" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0xbe2f753f, Offset: 0x2538
// Size: 0x30
function function_a1c9e125()
{
    level notify( #"waterfall_end_vo_idle" );
    level notify( #"hash_411bceb4b6375aff" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 1
// Checksum 0x380a2192, Offset: 0x2570
// Size: 0x136
function function_ef3d3d18( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( var_c79d614f + "_end" );
    dark = 1;
    dialogue::radio( "vox_cp_prsn_13500_adlr_atunnelyouuhyou_c8" );
    level flag::wait_till( "flag_rat_tunnels_entrance_map" );
    childthread namespace_d9b153b9::function_f6cbf7fd( &function_d727891e, 1, 15, "flag_rat_tunnels_large_enter" );
    level flag::wait_till( "flag_rat_tunnels_player_dead" );
    wait 1;
    thread dialogue::radio( "vox_cp_prsn_14900_adlr_stoplyingbellst_cc" );
    thread namespace_b6fe1dbe::rat_tunnels_ambience_fade_out();
    level notify( #"rat_tunnels_ambience_fade_out" );
    wait 7;
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x64db8f85, Offset: 0x26b0
// Size: 0x7c
function function_d727891e()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( #"hash_6404f5fcf0805b8e" );
    level endon( #"hash_1f23b5e993149d88" );
    dialogue::radio( "vox_cp_prsn_14900_adlr_thisisallextrem_0e" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x4d3cf2b4, Offset: 0x2738
// Size: 0xfe
function function_2d7d736()
{
    self endon( #"death" );
    
    while ( true )
    {
        /#
            if ( self actionslotfourbuttonpressed() && !self sprintbuttonpressed() )
            {
                self function_6afceef5();
                
                while ( self actionslotfourbuttonpressed() )
                {
                    waitframe( 1 );
                }
                
                continue;
            }
            else
            {
                waitframe( 1 );
                continue;
            }
        #/
        
        if ( self actionslotfourbuttonpressed() )
        {
            self function_6afceef5();
            
            while ( self actionslotfourbuttonpressed() )
            {
                waitframe( 1 );
            }
            
            continue;
        }
        
        waitframe( 1 );
    }
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x84927f10, Offset: 0x2840
// Size: 0x6a
function function_6afceef5()
{
    if ( self.var_cef36b49 )
    {
        self clientfield::set_to_player( "rt_flashlight", 0 );
        self.var_cef36b49 = 0;
        return;
    }
    
    self clientfield::set_to_player( "rt_flashlight", 1 );
    self.var_cef36b49 = 1;
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x16c3fd98, Offset: 0x28b8
// Size: 0x24
function function_73fb7422()
{
    util::show_hint_text( #"hash_2c629fcbcbf5093" );
}

// Namespace cp_nam_prisoner_rat_tunnels/cp_nam_prisoner_rat_tunnels
// Params 0
// Checksum 0x79841a9, Offset: 0x28e8
// Size: 0x1c
function function_8e1cdc07()
{
    wait 1;
    util::hide_hint_text();
}

