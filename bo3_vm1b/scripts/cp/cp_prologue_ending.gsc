#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_player_sacrifice;
#using scripts/cp/cp_prologue_util;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace prologue_ending;

// Namespace prologue_ending
// Params 2
// Checksum 0xcd9e7051, Offset: 0x5e8
// Size: 0x1b2
function skipto_prologue_ending_init( objective, b_starting )
{
    cp_mi_eth_prologue::skipto_message( "objective_prologue_ending_init" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread cp_prologue_util::function_cfabe921();
        objectives::hide( "cp_level_prologue_goto_exfil" );
        objectives::complete( "cp_level_prologue_defend_pod" );
        objectives::set( "cp_level_prologue_get_out_alive" );
        level cp_prologue_util::spawn_coop_player_replacement( "skipto_end" );
        level.vh_apc = vehicle::simple_spawn_single( "apc" );
        level.vh_apc.animname = "apc_escape";
        level.ai_hendricks = util::get_hero( "hendricks" );
        load::function_a2995f22();
    }
    
    util::screen_fade_out( 0, "black", "cinematic_fader" );
    array::run_all( level.players, &util::set_low_ready, 1 );
    level thread namespace_21b2c1f2::play_outro_igc();
    level flag::set( "start_tower_collapse" );
    exploder::exploder( "light_exploder_igc_ending" );
    prologue_ending_main( b_starting );
}

// Namespace prologue_ending
// Params 3
// Checksum 0xd5ba5add, Offset: 0x7a8
// Size: 0x4d
function function_a12cfbf4( str_notetrack, n_damage, str_mod )
{
    level endon( #"hash_398b6127" );
    
    while ( true )
    {
        level waittill( str_notetrack );
        level thread function_cddb4b1f( n_damage, str_mod );
        wait 0.1;
    }
}

// Namespace prologue_ending
// Params 2
// Checksum 0xa7c51dfd, Offset: 0x800
// Size: 0xb3
function function_cddb4b1f( n_damage, str_mod )
{
    w_weapon = getweapon( "none" );
    
    foreach ( player in level.players )
    {
        player finishplayerdamage( level, level.var_63d6b172, n_damage, 0, str_mod, w_weapon, undefined, undefined, "ouchspot", undefined, 0, undefined, undefined );
    }
}

// Namespace prologue_ending
// Params 0
// Checksum 0x3c06524e, Offset: 0x8c0
// Size: 0x6b
function function_e476fc0a()
{
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "player_blood_splatter", 1 );
    }
}

// Namespace prologue_ending
// Params 1
// Checksum 0x79ac9319, Offset: 0x938
// Size: 0x73
function function_490f0dd8( var_84893de8 )
{
    if ( !isdefined( var_84893de8 ) )
    {
        var_84893de8 = 1;
    }
    
    foreach ( player in level.activeplayers )
    {
        player.allowdeath = var_84893de8;
    }
}

// Namespace prologue_ending
// Params 4
// Checksum 0x5e46bfbf, Offset: 0x9b8
// Size: 0x3a
function skipto_prologue_ending_complete( name, b_starting, b_direct, player )
{
    cp_mi_eth_prologue::skipto_message( "prologue_ending_done" );
}

// Namespace prologue_ending
// Params 1
// Checksum 0xf0e4f1c2, Offset: 0xa00
// Size: 0x4a2
function prologue_ending_main( b_starting )
{
    a_t_ob = getentarray( "trigger_ob_defend", "targetname" );
    
    foreach ( t_ob in a_t_ob )
    {
        t_ob triggerenable( 0 );
    }
    
    cp_prologue_util::cleanup_enemies();
    
    if ( !b_starting )
    {
        if ( isdefined( level.bzm_prologuedialogue7callback ) )
        {
            level thread [[ level.bzm_prologuedialogue7callback ]]();
        }
    }
    
    foreach ( player in level.players )
    {
        player disableinvulnerability();
        player.health = 100;
        player.overrideplayerdamage = &function_886ee9f1;
    }
    
    level thread function_a12cfbf4( "leftarm", 25, "MOD_MELEE_WEAPON_BUTT" );
    level thread function_a12cfbf4( "rightarm", 25, "MOD_MELEE_WEAPON_BUTT" );
    level thread function_a12cfbf4( "rightleg", 20, "MOD_MELEE_WEAPON_BUTT" );
    level thread function_a12cfbf4( "robot_left_punch", 3, "MOD_MELEE_WEAPON_BUTT" );
    level thread function_a12cfbf4( "robot_right_punch", 3, "MOD_MELEE_WEAPON_BUTT" );
    scene::add_scene_func( "cin_pro_20_01_rippedapart_murder", &function_48d78725, "play" );
    scene::add_scene_func( "cin_pro_20_01_rippedapart_murder", &function_157cae6a, "play" );
    scene::add_scene_func( "cin_pro_20_01_rippedapart_murder", &function_398b6127, "done" );
    level thread scene::play( "cin_pro_20_01_rippedapart_murder" );
    level waittill( #"hash_be89995b" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread util::screen_fade_in( 1.9, "black", "cinematic_fader" );
    }
    
    if ( isdefined( level.bzm_prologuedialogue8callback ) )
    {
        level thread [[ level.bzm_prologuedialogue8callback ]]();
    }
    
    level waittill( #"hash_87c3e0ab" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level util::screen_fade_out( 0.1, "black", "cinematic_fader" );
        level util::screen_fade_in( 0.1, "black", "cinematic_fader" );
        wait 0.8;
        level util::screen_fade_out( 0.1, "black", "cinematic_fader" );
        level util::screen_fade_in( 0.2, "black", "cinematic_fader" );
        wait 0.8;
        level util::screen_fade_out( 1.4, "black", "cinematic_fader" );
        wait 2;
    }
    else
    {
        level thread util::player_lock_control();
    }
    
    level thread function_58c753e3();
    level scene::add_scene_func( "cin_pro_20_01_squished_1st_rippedapart_aftermath_pt1", &function_313d2f63 );
    level scene::play( "cin_pro_20_01_squished_1st_rippedapart_aftermath_pt1" );
    objectives::complete( "cp_level_prologue_get_out_alive" );
    level dialog::say( "tayr_it_s_gonna_be_okay_0" );
    level thread audio::unlockfrontendmusic( "mus_prologue_battle_intro" );
    level.allowhitmarkers = 1;
    level notify( #"hash_cbaff304" );
    wait 2;
    skipto::objective_completed( "skipto_prologue_ending" );
}

// Namespace prologue_ending
// Params 1
// Checksum 0xbbc61009, Offset: 0xeb0
// Size: 0x2a
function function_313d2f63( a_ents )
{
    a_ents[ "prometheus" ] sethighdetail( 1 );
}

// Namespace prologue_ending
// Params 1
// Checksum 0xea29c415, Offset: 0xee8
// Size: 0x3a
function function_48d78725( a_ents )
{
    e_player = a_ents[ "player 1" ];
    e_player shellshock( "default", 2 );
}

// Namespace prologue_ending
// Params 1
// Checksum 0x47c24654, Offset: 0xf30
// Size: 0x13
function function_398b6127( a_ents )
{
    level notify( #"hash_398b6127" );
}

// Namespace prologue_ending
// Params 1
// Checksum 0xad20fc20, Offset: 0xf50
// Size: 0x19a
function function_157cae6a( a_ents )
{
    level.var_63d6b172 = a_ents[ "robot" ];
    level.e_victim = a_ents[ "player 1" ];
    a_ents[ "rightarm" ] ghost();
    a_ents[ "leftarm" ] ghost();
    level waittill( #"leftarm" );
    
    foreach ( player in level.activeplayers )
    {
        var_d5c1dc47 = getcharacterbodystyleindex( 1, "Undercover Leftarm" );
        player setcharacterbodystyle( var_d5c1dc47 );
    }
    
    a_ents[ "leftarm" ] show();
    level waittill( #"rightarm" );
    
    foreach ( player in level.activeplayers )
    {
        var_d5c1dc47 = getcharacterbodystyleindex( 1, "Undercover Armsoff" );
        player setcharacterbodystyle( var_d5c1dc47 );
    }
    
    a_ents[ "rightarm" ] show();
}

// Namespace prologue_ending
// Params 13
// Checksum 0x93819a82, Offset: 0x10f8
// Size: 0x88
function function_886ee9f1( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, vsurfacenormal )
{
    if ( self.health <= idamage )
    {
        self.health = idamage;
        idamage = 0;
    }
    
    return idamage;
}

// Namespace prologue_ending
// Params 0
// Checksum 0x62550d8e, Offset: 0x1188
// Size: 0x9a
function function_58c753e3()
{
    while ( !scene::is_ready( "cin_pro_20_01_squished_1st_rippedapart_aftermath_pt1" ) )
    {
        wait 0.05;
    }
    
    level thread util::delay( 1, undefined, &util::screen_fade_in, 3, "black", "cinematic_fader" );
    level waittill( #"hash_9947aa2e" );
    level clientfield::set( "sndIGCsnapshot", 4 );
    level thread util::screen_fade_out( 1, "black", "cinematic_fader" );
}

