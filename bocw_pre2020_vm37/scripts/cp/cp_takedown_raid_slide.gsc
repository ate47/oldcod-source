#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_61cfc2ab8e60625;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\perks;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp\cp_takedown_raid_bar;
#using scripts\cp\cp_takedown_raid_capture;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace tkdn_raid_slide;

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 1
// Checksum 0xfe120b46, Offset: 0x5b0
// Size: 0x284
function starting( *var_d3440450 )
{
    player = getplayers()[ 0 ];
    var_8a3bb97c = getspawnerarray( "raid_adler", "targetname" );
    var_8a3bb97c[ 0 ] spawner::add_spawn_function( &namespace_b100dd86::function_9109a1fe );
    woods_spawner = getspawnerarray( "raid_woods", "targetname" );
    woods_spawner[ 0 ] spawner::add_spawn_function( &namespace_b100dd86::function_87d56d50 );
    var_3eba13ec = getspawnerarray( "qasim_final_rooftop", "targetname" );
    var_3eba13ec[ 0 ] spawner::add_spawn_function( &namespace_b100dd86::function_a66feb27 );
    level.adler = var_8a3bb97c[ 0 ] spawner::spawn( 1 );
    level.woods = woods_spawner[ 0 ] spawner::spawn( 1 );
    level.qasim = var_3eba13ec[ 0 ] spawner::spawn( 1 );
    var_fcbd93e0 = struct::get( "raid_slide_adler", "targetname" );
    var_1100faeb = struct::get( "raid_slide_woods", "targetname" );
    level.adler forceteleport( var_fcbd93e0.origin, var_fcbd93e0.angles );
    level.woods forceteleport( var_1100faeb.origin, var_1100faeb.angles );
    thread objectives::scripted( "obj_takedown_capture", undefined, #"hash_49c1d860c97e3792" );
    namespace_b100dd86::function_53531f27( "trig_qasim_roof_run3" );
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 2
// Checksum 0x3d4d3335, Offset: 0x840
// Size: 0xacc
function main( var_d3440450, *var_50cc0d4f )
{
    level thread tkdn_raid_capture::function_daaa52d5();
    level thread tkdn_raid_capture::function_b47183fb();
    player = getplayers()[ 0 ];
    player thread function_6178ec8f();
    level endon( #"hash_7d9928c92b67b6b2" );
    var_2b876e6f = getspawnerarray( "slide_enemy1", "targetname" );
    level.slide_enemy1 = var_2b876e6f[ 0 ] spawner::spawn( 1 );
    level.slide_enemy1.targetname = "slide_enemy1";
    level.slide_enemy1.health = 999;
    level.slide_enemy1 disableaimassist();
    var_b5c582ed = getspawnerarray( "slide_enemy2", "targetname" );
    level.slide_enemy2 = var_b5c582ed[ 0 ] spawner::spawn( 1 );
    level.slide_enemy2.targetname = "slide_enemy2";
    level.slide_enemy2.health = 999;
    level.slide_enemy2.var_c681e4c1 = 1;
    level.slide_enemy2 disableaimassist();
    var_ecae70ca = getspawnerarray( "slide_enemy3", "targetname" );
    level.slide_enemy3 = var_ecae70ca[ 0 ] spawner::spawn( 1 );
    level.slide_enemy3.targetname = "slide_enemy3";
    level.slide_enemy3.health = 999;
    level.slide_enemy3.var_c681e4c1 = 1;
    level.slide_enemy3 disableaimassist();
    battlechatter::function_2ab9360b( 0 );
    player util::blend_movespeedscale( 0.85, 1 );
    level.adler ai::set_behavior_attribute( "demeanor", "combat" );
    level.woods ai::set_behavior_attribute( "demeanor", "combat" );
    var_5ca6956f = getweapon( #"ar_accurate_t9" );
    w_pistol = getweapon( #"pistol_semiauto_t9", "steadyaim", "fastreload", "reflex_pistol" );
    thread function_1f6d0353();
    level flag::wait_till( "flag_qasim_roof_run3" );
    level thread function_e99afe47();
    level flag::wait_till( "flag_start_roof_slide" );
    level notify( #"hash_530a04ce72c2c9" );
    objectives::show( "obj_takedown_qasim" );
    player val::set( "slide", "allow_crouch", 0 );
    player val::set( "slide", "allow_prone", 0 );
    level function_bc2abab3();
    player thread function_624525f();
    thread namespace_a052577e::function_fd7139f4();
    weapon = getweapon( #"pistol_semiauto_t9" );
    level.adler aiutility::setprimaryweapon( weapon );
    level.adler ai::gun_switchto( weapon, "right" );
    level notify( #"hash_707e3fbcbfc9b954" );
    fake_player = util::spawn_player_clone( player );
    fake_player.targetname = "FakePlayer";
    fake_player hide();
    fake_player setinvisibletoall();
    player thread function_79b1e578();
    level thread function_4b1afed9();
    level thread scene::play( "scene_tkd_hit2_rooftop_slide", "Shot 1", [ fake_player ] );
    level.slide_enemy1 thread scene::play( "scene_tkd_hit2_rooftop_slide_enemy1", "Shot 1", [ level.slide_enemy1 ] );
    level.slide_enemy2 thread scene::play( "scene_tkd_hit2_rooftop_slide_enemy2", "Shot 1", [ level.slide_enemy2 ] );
    level.slide_enemy3 thread scene::play( "scene_tkd_hit2_rooftop_slide_enemy3", "Shot 1", [ level.slide_enemy3 ] );
    level.slide_enemy1 thread function_83cb8fb7();
    level.slide_enemy3 thread function_83cb8fb7();
    level.slide_enemy3 thread function_d6825a2e();
    level thread function_41a8d47e();
    level.qasim thread namespace_b100dd86::swap_head( undefined, "c_t9_cp_ira_militant_vip_qasim_head_nohat" );
    level.qasim thread namespace_b100dd86::swap_head( "qasim_punched", "c_t9_cp_ira_militant_vip_qasim_head_nohat_injured" );
    level.qasim thread namespace_b100dd86::function_f82142f8( undefined, "c_t9_cp_ira_militant_vip_qasim_tkd_body" );
    player playerlinktoblend( fake_player, "tag_player", 0.2 );
    player playgestureviewmodel( #"hash_629a852e56700e02", undefined, 1, 0.2, 0, 1, 1 );
    wait 0.2;
    fake_player show();
    player playerlinktoabsolute( fake_player, "tag_player" );
    level waittill( #"slowmo_start" );
    player thread give_player_max_ammo();
    player thread function_85757fc8();
    player playerlinktodelta( fake_player, "tag_player", 0.2, 50, 50, 25, 25, 1, 0, 1 );
    setslowmotion( 1, 0.2, 0.25, 1, 1 );
    player perks::perk_setperk( "specialty_fastads" );
    wait 0.1;
    player enableweapons();
    level waittill( #"slowmo_stop" );
    player disableweapons();
    player playerlinktoblend( fake_player, "tag_player", 0.2, 0, 0, 0.2, 0, 0, 1 );
    setslowmotion( 0.1, 1, 0.5, 1, 1 );
    level waittill( #"hash_35a786f9d88a2e60" );
    player perks::perk_unsetperk( "specialty_fastads" );
    player val::reset( "slide", "allow_crouch" );
    player val::reset( "slide", "allow_prone" );
    player unlink();
    fake_player delete();
    player enableweapons();
    player setlowready( 1 );
    player util::blend_movespeedscale( 0.5, 1 );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x790b97c1, Offset: 0x1318
// Size: 0x84
function function_85757fc8()
{
    level waittill( #"land_rumble" );
    self playrumbleonentity( "damage_heavy" );
    self clientfield::set_to_player( "lerp_fov", 7 );
    objectives::complete( "obj_takedown_qasim", level.qasim, 0 );
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0xfa2bb326, Offset: 0x13a8
// Size: 0xe8
function give_player_max_ammo()
{
    var_fd5bc72c = self getweaponslistprimaries();
    
    foreach ( weap in var_fd5bc72c )
    {
        self givemaxammo( weap );
        self setweaponammoclip( weap, weap.maxammo );
        self setweaponammostock( weap, weap.maxammo );
    }
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0xbd7c3489, Offset: 0x1498
// Size: 0xec
function function_624525f()
{
    level endon( #"shot_slide_enemy1" );
    var_b84b1bf9 = getent( "mb_slide_enemy1", "targetname" );
    level waittill( #"land_rumble" );
    
    if ( isalive( level.slide_enemy1 ) && !isdefined( level.slide_enemy1.var_b481f04a ) )
    {
        magicbullet( getweapon( #"ar_standard_t9" ), var_b84b1bf9.origin, level.slide_enemy1.origin + ( 0, 0, 50 ) );
    }
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0xc501ab2b, Offset: 0x1590
// Size: 0x40
function function_41a8d47e()
{
    level util::waittill_multiple( "shot_slide_enemy1", "shot_slide_enemy3" );
    level notify( #"slowmo_stop" );
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x5b94dd8c, Offset: 0x15d8
// Size: 0xb2
function function_e99afe47()
{
    level endon( #"hash_707e3fbcbfc9b954" );
    
    while ( true )
    {
        if ( flag::get( "flag_listen_for_slide" ) && level.var_962e7d10 == 0 )
        {
            level thread function_f9dfbac1();
        }
        else if ( flag::get( "flag_clear_listen_for_slide" ) )
        {
            level.var_962e7d10 = 0;
            level notify( #"hash_1480b995232f9d53" );
        }
        
        waitframe( 1 );
    }
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x9999c372, Offset: 0x1698
// Size: 0xa4
function function_6178ec8f()
{
    level flag::wait_till( "flag_ak74_hack" );
    var_2397b823 = getweapon( #"smg_heavy_t9", "steadyaim", "reflex" );
    self giveweapon( var_2397b823 );
    self switchtoweapon( var_2397b823 );
    self disableweaponcycling();
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0xa423db73, Offset: 0x1748
// Size: 0x34
function function_79b1e578()
{
    level waittill( #"postfx_start" );
    self cp_takedown_fx::function_febff01e();
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x4bccd04e, Offset: 0x1788
// Size: 0xc6
function function_f9dfbac1()
{
    player = getplayers()[ 0 ];
    level.var_962e7d10 = 1;
    level endon( #"hash_1480b995232f9d53" );
    namespace_a052577e::function_c2eee241();
    
    while ( true )
    {
        if ( player jumpbuttonpressed() && !player flag::get( "body_shield_active" ) )
        {
            level flag::set( "flag_start_roof_slide" );
        }
        
        waitframe( 1 );
    }
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x8193441e, Offset: 0x1858
// Size: 0x64
function function_1f6d0353()
{
    level notify( #"hash_5f84172c70d1eb4c" );
    level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_movequicklyweca_64" );
    wait 1;
    level.adler dialogue::queue( "vox_cp_tdwn_03800_adlr_weneedqasimaliv_e5" );
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x5d6b822, Offset: 0x18c8
// Size: 0x3c
function function_4b1afed9()
{
    level waittill( #"qasim_ready_for_interrogation" );
    level flag::set( "flag_qasim_ready_for_interrogation" );
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x6419b249, Offset: 0x1910
// Size: 0xc4
function function_d6825a2e()
{
    self endon( #"death" );
    self thread function_edf70272();
    level waittill( #"hash_34053632d960caf2" );
    self thread scene::play( "scene_tkd_hit2_rooftop_slide_enemy3", "interact" );
    level waittill( #"hash_6fec65520df29efc" );
    self thread scene::stop( "scene_tkd_hit2_rooftop_slide_enemy3" );
    self.allowdeath = 1;
    self kill();
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x7d996ba3, Offset: 0x19e0
// Size: 0x2e
function function_edf70272()
{
    level waittill( #"hash_3e5010fedda2bc6c" );
    self notify( #"fake_damage" );
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0xd322284f, Offset: 0x1a18
// Size: 0x130
function function_83cb8fb7()
{
    player = getplayers()[ 0 ];
    self waittill( #"damage", #"fake_damage" );
    
    if ( self == level.slide_enemy1 )
    {
        self thread scene::play( "scene_tkd_hit2_rooftop_slide_enemy1", "death" );
        player playhitmarker( undefined, 5, undefined, 1 );
        level notify( #"shot_slide_enemy1" );
        self.var_b481f04a = 1;
    }
    
    if ( self == level.slide_enemy3 )
    {
        self thread scene::play( "scene_tkd_hit2_rooftop_slide_enemy3", "death" );
        player playhitmarker( undefined, 5, undefined, 1 );
        level notify( #"shot_slide_enemy3" );
    }
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0xb1303d4a, Offset: 0x1b50
// Size: 0xfc
function function_bc2abab3()
{
    var_3eba13ec = getspawnerarray( "raid_qasim", "targetname" );
    level.qasim = var_3eba13ec[ 0 ] spawner::spawn( 1 );
    level.qasim.radius = 32;
    level.qasim.ignoreall = 1;
    level.qasim.ignoreme = 1;
    level.qasim.script_forcegoal = 1;
    level.qasim disableaimassist();
    objectives::follow( "obj_takedown_qasim", level.qasim, undefined, undefined, 0, #"hash_29f1e9a2d045faaf" );
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 4
// Checksum 0xa3a11aed, Offset: 0x1c58
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x84bb2a0c, Offset: 0x1c88
// Size: 0x24
function init_flags()
{
    level flag::init( "raid_approach_complete" );
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x80f724d1, Offset: 0x1cb8
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace tkdn_raid_slide/cp_takedown_raid_slide
// Params 0
// Checksum 0x80f724d1, Offset: 0x1cc8
// Size: 0x4
function function_22b7fffd()
{
    
}

