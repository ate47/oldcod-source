#using script_155b17ff7c8b315c;
#using script_57d05cf093ffba5c;
#using script_97b74052c477c23;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lockpick;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace namespace_96add23c;

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1
// Checksum 0x71924f3c, Offset: 0x8f8
// Size: 0x64
function function_a5ad7a90( *str_objective )
{
    level function_b9596ad1();
    level flag::set( "flg_woods_radio" );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_perimeter", 1, 0 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 2
// Checksum 0xc5bac0e, Offset: 0x968
// Size: 0x104
function function_709fd94e( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level flag::set( #"flg_lockpick_start" );
    clientfield::set( "cull_allinterior", 1 );
    level thread function_39e166dc();
    level thread namespace_fc3e8cb::function_6fe40e14( "side_door_gun_rack1", "side_door_gun_rack2", "side_door_gun_rack3" );
    level function_bb9839d8();
    level flag::wait_till( #"hash_4af4527f816d9739" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 4
// Checksum 0x817ead03, Offset: 0xa78
// Size: 0x9c
function function_70073b6b( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level flag::clear( "flg_woods_radio" );
    doors::function_f35467ac( "e_lockpick_door" );
    clientfield::set( "cull_allinterior", 1 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_exterior", 1 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0, eflags: 0x4
// Checksum 0x93ba3c5e, Offset: 0xb20
// Size: 0xcc
function private function_39e166dc()
{
    s_obj_side_door_lockpick = struct::get( "s_obj_side_door_lockpick", "targetname" );
    
    if ( !isdefined( objectives::function_285e460( "obj_side_door_find_entrance" ) ) )
    {
        objectives::goto( "obj_side_door_find_entrance", s_obj_side_door_lockpick.origin, #"hash_783161cb2beea0a0" );
        level thread function_a0b22623();
        level flag::wait_till( "flg_side_door_scene_start" );
        objectives::complete( "obj_side_door_find_entrance" );
    }
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0xd5390797, Offset: 0xbf8
// Size: 0x9c
function function_a0b22623()
{
    level endon( #"flg_side_door_scene_start" );
    wait 20;
    objectives::convert( "obj_side_door_find_entrance", #"hash_6d05b1cec06f98c" );
    s_obj_side_door_lockpick = struct::get( "s_obj_side_door_lockpick", "targetname" );
    objectives::update_position( "obj_side_door_find_entrance", s_obj_side_door_lockpick.origin );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0x9d85b327, Offset: 0xca0
// Size: 0x1f4
function function_b9596ad1()
{
    var_d1a24548 = spawner::simple_spawn_single( "lockpick_scene_enemy_door", &function_87f353f6, #"c_t9_shg_npc_c_lutz" );
    var_d1a24548 setmodel( #"c_t9_cp_rus_kgb_guard_body_officer_a" );
    var_12baf921 = spawner::simple_spawn_single( "lockpick_scene_enemy_desk", &function_87f353f6, #"c_t9_shg_npc_e_reshetnikov" );
    var_12baf921.health = 1;
    level.var_eea5b22[ #"hash_65d78c2acf2a7732" ] = var_d1a24548;
    level.var_eea5b22[ #"hash_3c251f2afff5ae77" ] = var_12baf921;
    var_4c5366ee = doors::get_doors( "e_lockpick_door", "targetname" )[ 0 ];
    level.var_eea5b22[ #"door" ] = var_4c5366ee.c_door.m_e_door;
    level function_4f4f437b();
    animation::add_notetrack_func( "amerika_tunnels::lockpick_takedown_player_handler", &function_6fac81f3 );
    animation::add_notetrack_func( "amerika_tunnels:lockpick_takedown_player_shellshock", &function_8ad67270 );
    animation::add_notetrack_func( "amerika_tunnels:lockpick_takedown_player_slowmo", &function_29962dd8 );
    level scene::init( #"hash_24e544fc76d24b96", level.var_eea5b22 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0xfd19baf6, Offset: 0xea0
// Size: 0x1fc
function function_4f4f437b()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player.var_4d448bdb = util::spawn_player_clone( level.player );
    mdl_head = level.player startquantity();
    
    if ( isdefined( mdl_head ) && level.player.var_4d448bdb isattached( mdl_head ) )
    {
        level.player.var_4d448bdb detach( mdl_head );
    }
    
    var_60298582 = level.player function_92ea4100();
    
    if ( isdefined( var_60298582 ) && level.player.var_4d448bdb isattached( var_60298582 ) )
    {
        level.player.var_4d448bdb detach( var_60298582 );
    }
    
    level.player.var_4d448bdb function_1fac41e4( level.player function_19124308() );
    level.player.var_4d448bdb.anim_debug_name = level.player.name + " clone";
    level.player.var_4d448bdb hide();
    level.var_eea5b22[ #"player_clone" ] = level.player.var_4d448bdb;
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1, eflags: 0x4
// Checksum 0xa7b6f256, Offset: 0x10a8
// Size: 0x10c
function private function_87f353f6( mdl_head )
{
    self.name = "Guard";
    self.avoid_cover = 1;
    self val::set( #"hash_70f48a440e25a27c", "magic_bullet_shield", 1 );
    self val::set( #"hash_70f48a440e25a27c", "ignoreme", 1 );
    self val::set( #"hash_70f48a440e25a27c", "ignoreall", 1 );
    
    if ( isdefined( self.head ) && isdefined( mdl_head ) )
    {
        self detach( self.head );
        self.head = mdl_head;
        self attach( self.head );
    }
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0, eflags: 0x4
// Checksum 0xfe63d8a6, Offset: 0x11c0
// Size: 0x34c
function private function_bb9839d8()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.player flag::wait_till( #"lockpicking" );
    level thread function_2ea0a58();
    level function_db6f14d2();
    level function_e5368a6a();
    level.player val::set( #"hash_70f48a440e25a27c", "disable_weapons", 2 );
    level.player thread function_7eb32768();
    level.player.var_97c1c267.script_delete_on_fail = 1;
    level.player lockpick::cancel();
    doors::function_f35467ac( "e_lockpick_door" );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_exterior", 1 );
    level flag::set( #"flg_side_door_scene_start" );
    var_2a16bfbe = level.var_eea5b22[ #"hash_65d78c2acf2a7732" ];
    level scene::play( #"hash_24e544fc76d24b96", "open_door_start", level.var_eea5b22 );
    level flag::set( #"hash_525a26a0b7957925" );
    level scene::play( #"hash_24e544fc76d24b96", "weapon_aim", level.var_eea5b22 );
    level flag::set( #"hash_3dac34734cfb07f4" );
    
    if ( flag::get( #"hash_eff650e7e8aecc2" ) )
    {
        level scene::play( #"hash_24e544fc76d24b96", "fail_woods_shoot", level.var_eea5b22 );
    }
    
    arrayremoveindex( level.var_eea5b22, #"hash_3c251f2afff5ae77", 1 );
    level scene::play( #"hash_24e544fc76d24b96", "takedown_player_end", level.var_eea5b22 );
    level flag::set( #"hash_4939af0c2a6ea11d" );
    level flag::set( #"hash_4af4527f816d9739" );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0, eflags: 0x4
// Checksum 0x6279b1ae, Offset: 0x1518
// Size: 0x86
function private function_db6f14d2()
{
    var_60beb454 = 0;
    
    while ( true )
    {
        wait 0.25;
        
        if ( level.player flag::get( #"lockpicking" ) )
        {
            var_60beb454 += 0.25;
            
            if ( var_60beb454 >= 7 )
            {
                break;
            }
        }
    }
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0, eflags: 0x4
// Checksum 0x133e8417, Offset: 0x15a8
// Size: 0x14c
function private function_e5368a6a()
{
    var_b2e05f73 = level.player getcurrentweapon();
    var_9a528114 = spawn( "script_model", level.player.origin );
    
    if ( var_b2e05f73 != getweapon( #"none" ) )
    {
        var_9a528114 setmodel( var_b2e05f73.worldmodel );
    }
    else if ( level.player getweaponslistprimaries()[ 0 ] === level.var_e3f5eafc )
    {
        var_9a528114 setmodel( level.var_e3f5eafc.worldmodel );
    }
    
    if ( var_9a528114.model != #"" )
    {
        level.var_eea5b22[ #"weapon" ] = var_9a528114;
        return;
    }
    
    var_9a528114 delete();
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0, eflags: 0x4
// Checksum 0x3ec11f1e, Offset: 0x1700
// Size: 0x7c
function private function_2ea0a58()
{
    level.woods hms_util::function_cdc39aec();
    waitframe( 1 );
    level namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_perimeter", 1, 0 );
    level.var_eea5b22[ #"woods" ] = level.woods;
    level function_76ff663b();
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0, eflags: 0x4
// Checksum 0xf0001d99, Offset: 0x1788
// Size: 0xd0
function private function_76ff663b()
{
    s_result = level waittill( #"hash_2254d709726e6725", #"hash_eff650e7e8aecc2" );
    
    if ( s_result._notify === #"hash_2254d709726e6725" )
    {
        level thread namespace_4bd68414::function_b02f806b();
    }
    else
    {
        level thread namespace_4bd68414::function_862afde1();
    }
    
    level.woods waittill( #"hash_29b3a2bef162f375" );
    level thread namespace_4bd68414::function_7357ef4c();
    level.woods waittill( #"hash_5cb0d4dc82eb4c03" );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1, eflags: 0x4
// Checksum 0x926caf2c, Offset: 0x1860
// Size: 0x3fc
function private function_6fac81f3( *params )
{
    w_pistol = getweapon( #"pistol_semiauto_t9" );
    level.player function_77569ccb( w_pistol );
    level.player.var_4d448bdb util::delay( 0.5, undefined, &show );
    level.player hideviewmodel();
    var_2586eb45 = getweapon( #"eq_flash_grenade" );
    assert( var_2586eb45 != level.weaponnone );
    var_c3a1484c = 0;
    
    if ( level.player hasweapon( var_2586eb45 ) )
    {
        var_c3a1484c = level.player getweaponammoclip( var_2586eb45 );
        level.player takeweapon( var_2586eb45 );
        var_4f0f327c = 1;
    }
    
    level waittill( #"hash_30b0b368a6b10931" );
    level.player.var_4d448bdb hide();
    level.player val::reset( #"hash_70f48a440e25a27c", "disable_weapons" );
    level.player showviewmodel();
    level flag::wait_till( #"hash_3dac34734cfb07f4" );
    level.player util::function_749362d7( 1 );
    level waittill( #"hash_50d0ee914946a0ae" );
    level.player hideviewmodel();
    level.player val::set( #"hash_70f48a440e25a27c", "disable_weapons", 2 );
    level.player.var_4d448bdb show();
    level waittill( #"hash_30b0b368a6b10931" );
    level.player function_9f0dc392( w_pistol );
    level.player util::function_749362d7( 0 );
    level.player.var_4d448bdb hide();
    level.player val::reset( #"hash_70f48a440e25a27c", "disable_weapons" );
    level.player showviewmodel();
    level waittill( #"hash_3fdce2a6c2be9794" );
    
    if ( is_true( var_4f0f327c ) )
    {
        level.player giveweapon( var_2586eb45 );
        level.player setweaponammoclip( var_2586eb45, var_c3a1484c );
    }
    
    level.player function_7437ab12();
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0, eflags: 0x4
// Checksum 0xe7731ec7, Offset: 0x1c68
// Size: 0x244
function private function_7eb32768()
{
    self val::set( #"hash_70f48a440e25a27c", "freezecontrols", 1 );
    self val::set( #"hash_70f48a440e25a27c", "allow_crouch", 0 );
    self val::set( #"hash_70f48a440e25a27c", "allow_prone", 0 );
    self val::set( #"hash_70f48a440e25a27c", "show_weapon_hud", 0 );
    self sethighdetail( 1 );
    self playerlinktoblend( level.player.var_4d448bdb, "tag_player", 0.25, 0.25 * 0.5, 0, 0.25, 0.25 * 0.5, 0 );
    wait 0.25;
    self playerlinktodelta( level.player.var_4d448bdb, "tag_player", 1, 5, 5, 5, 5, 1, 0, 1 );
    self val::reset( #"hash_70f48a440e25a27c", "freezecontrols" );
    level flag::wait_till( #"hash_525a26a0b7957925" );
    self playerlinktodelta( level.player.var_4d448bdb, "tag_player", 1, 20, 15, 10, 10, 1, 0, 1 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0, eflags: 0x4
// Checksum 0x11f77aa9, Offset: 0x1eb8
// Size: 0x74
function private function_7437ab12()
{
    self val::reset_all( #"hash_70f48a440e25a27c" );
    self unlink();
    self sethighdetail( 0 );
    level.player.var_4d448bdb delete();
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1, eflags: 0x4
// Checksum 0x40cb244d, Offset: 0x1f38
// Size: 0xf4
function private function_77569ccb( var_bcf157b )
{
    self.var_6ced26c7 = self getweaponslistprimaries();
    self.var_eb242b12 = self getcurrentweapon();
    
    foreach ( var_2d7e01a in self.var_6ced26c7 )
    {
        self takeweapon( var_2d7e01a );
    }
    
    self giveweapon( var_bcf157b );
    self seteverhadweaponall( 1 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1, eflags: 0x4
// Checksum 0x4dc7fc4d, Offset: 0x2038
// Size: 0xc4
function private function_9f0dc392( var_bcf157b )
{
    self takeweapon( var_bcf157b );
    
    foreach ( var_2d7e01a in self.var_6ced26c7 )
    {
        self giveweapon( var_2d7e01a );
    }
    
    self switchtoweapon( self.var_eb242b12 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1, eflags: 0x4
// Checksum 0x813b6a4c, Offset: 0x2108
// Size: 0xec
function private function_8ad67270( *params )
{
    var_2a16bfbe = level.var_eea5b22[ #"hash_65d78c2acf2a7732" ];
    effect = getstatuseffect( #"blurred" );
    var_711343eb = level.player getnormalhealth() * 0.4;
    level.player setnormalhealth( var_711343eb );
    level.player status_effect::status_effect_apply( effect, level.player.currentweapon, var_2a16bfbe, undefined, 1500 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1, eflags: 0x4
// Checksum 0x7e6a0bac, Offset: 0x2200
// Size: 0x29c
function private function_29962dd8( *params )
{
    switch ( level.gameskill )
    {
        case 4:
            var_691d0722 = 0.85;
            break;
        case 3:
            var_691d0722 = 0.75;
            break;
        case 2:
            var_691d0722 = 0.5;
            break;
        case 0:
            var_691d0722 = 0.2;
            break;
        case 1:
        default:
            var_691d0722 = 0.3;
            break;
    }
    
    var_86514cc = level.var_eea5b22[ #"hash_3c251f2afff5ae77" ];
    var_86514cc val::reset( #"hash_70f48a440e25a27c", "magic_bullet_shield" );
    level.player clientfield::set_to_player( "slowmo_postfx", 1 );
    setslowmotion( 1, var_691d0722, 0.5 );
    s_result = var_86514cc waittilltimeout( 2, #"death" );
    
    if ( s_result._notify === #"death" )
    {
        level flag::set( #"hash_2254d709726e6725" );
    }
    else
    {
        var_86514cc.health = 9999;
        level flag::set( #"hash_eff650e7e8aecc2" );
        wait 2.2 - 2;
    }
    
    setslowmotion( var_691d0722, 1, 0.2 );
    level.player clientfield::set_to_player( "slowmo_postfx", 0 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1
// Checksum 0x6f591756, Offset: 0x24a8
// Size: 0x5c
function function_debfe625( *str_objective )
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_tunnels", 1, 0 );
    level thread namespace_fc3e8cb::function_6fe40e14( "side_door_gun_rack1", "side_door_gun_rack2", "side_door_gun_rack3" );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 2
// Checksum 0xac7190f0, Offset: 0x2510
// Size: 0xe4
function tunnels_main( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_52dbef3a();
    level.is_dark = 0;
    clientfield::set( "cull_helipad", 2 );
    level thread function_ff20ab50();
    level thread function_e174a8d1();
    level thread function_663b296d();
    flag::wait_till( "flg_tunnels_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 4
// Checksum 0x1380cabd, Offset: 0x2600
// Size: 0x8c
function tunnels_cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    clientfield::set( "cull_mainstreet", 1 );
    clientfield::set( "cull_helipad", 2 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_townsquare_keys", 1, "flg_terminal_end" );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0x5b6ae827, Offset: 0x2698
// Size: 0x6c
function function_52dbef3a()
{
    objectives::follow( "obj_tunnels_follow_woods", level.woods, #"hash_dd9c86df796a85b" );
    flag::wait_till( "flg_tunnels_end" );
    objectives::complete( "obj_tunnels_follow_woods", level.woods );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0x33080b5f, Offset: 0x2710
// Size: 0x5bc
function function_ff20ab50()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.woods endon( #"death" );
    level thread namespace_4bd68414::function_ef47326();
    level.woods.grenadeammo = 0;
    level.player util::blend_movespeedscale( 0.9, 1 );
    level flag::wait_till( "flg_tunnels_at_walkway" );
    level scene::play( #"hash_4f86426b62cd5b2a", "approach" );
    level thread scene::play( #"hash_4f86426b62cd5b2a", "loop" );
    level flag::wait_till_any( [ "flg_tunnels_at_overlook", "flg_tunnels_at_lower_level" ] );
    level flag::set( "flg_tunnels_at_lower_level" );
    
    if ( level flag::get( "flg_lockpick_alarm_button_player_interact" ) == 1 )
    {
        level thread namespace_4bd68414::function_a9537895();
    }
    else
    {
        level thread namespace_4bd68414::function_47262ea1();
    }
    
    if ( !level flag::get( #"flg_tunnels_enemies_alerted" ) )
    {
        level scene::play( #"hash_4f86426b62cd5b2a", "exit" );
        level scene::play( #"hash_10e85718db026016", "stairs" );
    }
    else
    {
        level scene::stop( #"hash_4f86426b62cd5b2a" );
        level.woods animation::stop();
    }
    
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_tunnels_woods_at_lower_level" );
    level flag::wait_till_any( [ "flg_tunnels_enemies_one_dead", "flg_tunnels_rush_guards" ] );
    level.woods namespace_fc3e8cb::function_d74bffa7( 0, 0 );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_tunnels_woods_rush_guards" );
    level flag::wait_till_any( [ "flg_tunnels_enemies_dead", "flg_tunnels_midpoint" ] );
    
    if ( level flag::get( "flg_tunnels_midpoint" ) == 1 )
    {
        level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_tunnels_woods_midpoint" );
    }
    
    level flag::wait_till( "flg_tunnels_enemies_dead" );
    wait 1;
    level thread namespace_4bd68414::function_2e47decc();
    
    if ( level flag::get( "flg_tunnels_rush_guards" ) == 0 )
    {
        wait 1;
    }
    
    var_928274e8 = getnode( "nd_tunnels_woods_at_exit_door", "targetname" );
    level.woods thread hms_util::function_2f50100e( "stay_ahead", var_928274e8.origin, "end_woods_tunnels_follow2" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_tunnels_woods_at_exit_door", 0, 1 );
    level.woods ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.woods ai::set_behavior_attribute( "disablepeek", 1 );
    level.woods ai::set_behavior_attribute( "disablelean", 1 );
    level.woods.battlechatterallowed = 0;
    level namespace_fc3e8cb::function_92dea087( "flg_tunnels_end", "flg_tunnels_midpoint" );
    level.woods notify( #"end_woods_tunnels_follow2" );
    level.woods.grenadeammo = 99;
    level scene::play( "scene_amk_3005_arc_approach", "arcade_approach" );
    level thread scene::play( "scene_amk_3005_arc_approach", "arcade_door_hold" );
    level flag::set( "flg_tunnels_woods_at_arcade_entrance" );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0x65cb1b7, Offset: 0x2cd8
// Size: 0x7c
function function_e174a8d1()
{
    level flag::wait_till( "flg_tunnels_enter_stairwell" );
    
    if ( level flag::get( "flg_lockpick_alarm_button_player_interact" ) == 1 )
    {
        level thread function_17a30454();
        return;
    }
    
    level thread function_3aa9edcc();
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0x15faf31c, Offset: 0x2d60
// Size: 0x1b4
function function_3aa9edcc()
{
    println( "<dev string:x38>" );
    var_d6376730 = spawner::simple_spawn( "ai_enemy_stealth_tunnels", &namespace_fc3e8cb::function_e57eea9a );
    var_ac125bf4 = spawner::simple_spawn( "ai_enemy_tunnels_trio_scene", &namespace_fc3e8cb::function_e57eea9a );
    var_d6376730 = arraycombine( var_d6376730, var_ac125bf4 );
    level thread namespace_fc3e8cb::function_85939627( var_d6376730, "flg_tunnels_enemies_one_dead", 1 );
    level thread namespace_fc3e8cb::function_85939627( var_d6376730, "flg_tunnels_enemies_dead" );
    level thread namespace_fc3e8cb::function_535e9168( var_d6376730, "flg_tunnels_enemies_alerted" );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_tunnels_end", var_d6376730 );
    level thread namespace_fc3e8cb::function_55a81eeb( "flg_lockpick_alarm_button_player_interact", var_d6376730 );
    level flag::wait_till_any( [ "flg_tunnels_at_overlook", "flg_tunnels_at_lower_level" ] );
    level thread namespace_4bd68414::function_26861bc8( var_ac125bf4 );
    level thread namespace_fc3e8cb::function_55a81eeb( "flg_tunnels_talking_trio_end", var_d6376730 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0xfb1afd86, Offset: 0x2f20
// Size: 0x1d4
function function_17a30454()
{
    println( "<dev string:x59>" );
    var_c68ae67f = spawner::simple_spawn( "ai_enemy_combat_tunnels_1", &function_345d7cd3 );
    level flag::wait_till( "flg_tunnels_at_overlook" );
    var_55aaa5e2 = spawner::simple_spawn( "ai_enemy_combat_tunnels_2", &function_345d7cd3 );
    function_1eaaceab( var_c68ae67f );
    var_c68ae67f = arraycombine( var_c68ae67f, var_55aaa5e2 );
    level thread namespace_fc3e8cb::function_85939627( var_c68ae67f, "flg_tunnels_enemies_one_dead", 1 );
    level flag::wait_till_any( [ "flg_tunnels_rush_guards", "flg_tunnels_enemies_one_dead" ] );
    var_a2d5c037 = spawner::simple_spawn( "ai_enemy_combat_tunnels_3", &function_345d7cd3 );
    function_1eaaceab( var_c68ae67f );
    var_c68ae67f = arraycombine( var_c68ae67f, var_a2d5c037 );
    level thread namespace_fc3e8cb::function_85939627( var_c68ae67f, "flg_tunnels_enemies_dead" );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_tunnels_end", var_c68ae67f );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0xfbac6fba, Offset: 0x3100
// Size: 0xe
function function_345d7cd3()
{
    self.grenadeammo = 0;
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 0
// Checksum 0xba72e958, Offset: 0x3118
// Size: 0x2bc
function function_663b296d()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_tunnels_end" );
    s_obj_tunnels_button_interact = struct::get( "s_obj_tunnels_button_interact", "targetname" );
    s_obj_tunnels_button_interact util::create_cursor_hint( undefined, undefined, #"hash_9afd0f1723f6f72", 40, 1, undefined, #"use", 40 );
    s_obj_tunnels_button_interact prompts::function_5698d1c9( #"use", 45 );
    level thread function_7c757661( s_obj_tunnels_button_interact );
    s_obj_tunnels_button_interact waittill( #"trigger" );
    level.player val::set( #"hash_75aefe15308514b7", "disable_weapons", 1 );
    level.player val::set( #"hash_75aefe15308514b7", "freezecontrols_allowlook", 1 );
    wait 0.5;
    s_scene = struct::get( "s_scene_lockpick_player_button_press", "targetname" );
    s_scene scene::play( "scene_amk_6090_stg_garage" );
    level.player val::reset_all( #"hash_75aefe15308514b7" );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_tunnel_alarm", 1 );
    snd::client_msg( "audio_tunnels_alarm" );
    level flag::set( "flg_lockpick_alarm_button_player_interact" );
    s_obj_tunnels_button_interact util::delay( 0.2, undefined, &util::remove_cursor_hint );
    level namespace_4bd68414::function_8d96d73c();
    level.woods namespace_fc3e8cb::function_d74bffa7( 0, 0 );
}

// Namespace namespace_96add23c/namespace_32f9a24b
// Params 1
// Checksum 0x49cf89e4, Offset: 0x33e0
// Size: 0x44
function function_7c757661( s_obj_tunnels_button_interact )
{
    level flag::wait_till( "flg_tunnels_end" );
    s_obj_tunnels_button_interact util::remove_cursor_hint();
}

