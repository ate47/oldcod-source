#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_61cfc2ab8e60625;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snipercam;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace tkdn_af_hill;

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0x50386688, Offset: 0x7e8
// Size: 0xfe
function starting( var_d3440450 )
{
    function_a2015343( var_d3440450 );
    plane = namespace_b100dd86::function_5431431d();
    namespace_b100dd86::function_c8381339( plane, 0 );
    namespace_b100dd86::function_5aabc3fb();
    exploder::exploder( "hit3_prop_mist" );
    player = getplayers()[ 0 ];
    player cp_takedown_fx::function_c8bc54e4();
    exploder::activate_radiant_exploder( "airfield_intro_lights" );
    thread namespace_a052577e::function_a42cfb58();
    plane_flyover = vehicle::simple_spawn_and_drive( "plane_flyover" );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 2
// Checksum 0x7d19a4b6, Offset: 0x8f0
// Size: 0xb14
function main( var_d3440450, *var_50cc0d4f )
{
    if ( !isdefined( level objectives::function_285e460( "af_follow_adler", level.adler ) ) )
    {
        level objectives::follow( "af_follow_adler", level.adler, undefined, 0, 0 );
    }
    
    setsaveddvar( #"hash_7bf40e4b6a830d11", 0 );
    vehicle::simple_spawn( "airport_truck_approach" );
    level thread scene::play( "scene_tkd_hit3_intro_overlook_adler", [ level.adler ] );
    level thread scene::play( "scene_tkd_hit3_intro_overlook_woods", [ level.woods ] );
    level thread scene::play( "scene_tkd_hit3_intro_overlook", "initial_loop" );
    level thread scene::play( "scene_tkd_hit3_intro_overlook_enemy4", "initial_loop" );
    level thread function_5dd4ff85();
    thread function_f7c7ce51();
    player = getplayers()[ 0 ];
    level.player = player;
    thread function_cc465a2( player );
    vehicle::add_spawn_function_group( "af_intro_vehicle", "targetname", &function_78bc26d5 );
    level.player val::set( #"overlook", "ignoreme", 1 );
    level.adler val::set( #"overlook", "ignoreme", 1 );
    setdvar( #"hash_135dec1a591c3c02", 0.05 );
    level.adler ai::set_behavior_attribute( "demeanor", "cqb" );
    level.woods ai::set_behavior_attribute( "demeanor", "cqb" );
    thread function_76b7bfa7();
    guys = ai::array_spawn( "af_unloader_guy" );
    level flag::wait_till( "af_start_overlook_scene" );
    level music::setmusicstate( "b2.0_recon", undefined, 6 );
    snd::client_msg( "snd_overlook_scene" );
    player waittill( #"camera_up" );
    level thread scene::play( "scene_tkd_hit3_intro_overlook_arash", "overlook_shot", [ level.arash ] );
    level thread scene::play( "scene_tkd_hit3_intro_overlook", "overlook_shot" );
    level thread scene::play( "scene_tkd_hit3_intro_overlook_adler", "overlook_shot", [ level.woods, level.adler ] );
    level thread util::delay( "play_b3.0_iced_mus", undefined, &music::function_edda155f, "b3.0_iced" );
    level thread util::delay( "play_b3.0_iced_mus", undefined, &music::setmusicstate, "b4.0_hold_fire" );
    level thread util::delay( "play_b4.1_identify_mus", undefined, &music::function_edda155f, "b4.1_identify" );
    level waittill( #"start_sniping", #"hash_380fe6172e5e75ed" );
    snd::client_msg( "start_sniping" );
    player enableweaponcycling();
    thread function_4bc0b384( player );
    thread function_7a77e3be( player );
    res = player waittilltimeout( 10, #"end_binocs", #"weapon_change" );
    
    if ( res._notify != #"timeout" )
    {
        res = player waittilltimeout( 10, #"weapon_fired" );
    }
    
    player notify( #"end_binocs" );
    
    if ( res._notify != #"timeout" )
    {
        level music::setmusicstate( "none" );
        level music::function_edda155f( "b4.2_shot" );
        var_7810080a = level.arash waittilltimeout( 0.5, #"hash_ae39942308147bf" );
    }
    
    level.arash snipercam::set_enabled( 0, 1, 2 );
    level.arash val::set( "hack", "takedamage", 0 );
    level thread scene::play( "scene_tkd_hit3_intro_overlook_arash", "hit", [ level.arash ] );
    thread function_254c9ae();
    level music::setmusicstate( "b5.0_battle" );
    guys = getaiarray();
    
    foreach ( guy in guys )
    {
        guy val::set( #"failed", "ignoreall", 0 );
        guy val::set( #"failed", "ignoreme", 0 );
        guy function_a3fcf9e0( "attack", player, player.origin );
    }
    
    if ( isdefined( var_7810080a ) && var_7810080a._notify == #"hash_ae39942308147bf" )
    {
        snd::client_msg( #"hash_44784851239c8ced" );
        level thread scene::play( "scene_tkd_hit3_intro_overlook_enemy4", "hit" );
        level.af_enemy2 stopanimscripted();
        level scene::play( "scene_tkd_hit3_intro_overlook", "hit", [ level.af_enemy2 ] );
    }
    else
    {
        level notify( #"hash_36f87644d590f542" );
        level thread scene::play( "scene_tkd_hit3_intro_overlook_enemy4", "miss" );
        level.af_enemy2 stopanimscripted();
        level scene::play( "scene_tkd_hit3_intro_overlook", "miss", [ level.af_enemy2 ] );
    }
    
    guys = getaiarray();
    
    foreach ( guy in guys )
    {
        guy ai::set_behavior_attribute( "demeanor", "combat" );
        guy val::set( #"failed", "ignoreall", 0 );
        guy val::set( #"failed", "ignoreme", 0 );
    }
    
    level flag::wait_till_any( [ "overlook_guys_done", "woods_to_truck" ] );
    
    if ( !level flag::get( "player_break_stealth_fired" ) )
    {
        level flag::set( "af_hill_complete" );
    }
    else
    {
        level flag::wait_till( "forever" );
    }
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0xbd7edcd8, Offset: 0x1410
// Size: 0x44
function function_5dd4ff85()
{
    level waittill( #"hash_59132013626fbab6" );
    level thread scene::play( "scene_tkd_hit3_intro_overlook_enemy4", "overlook_shot" );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0xc3d60ff9, Offset: 0x1460
// Size: 0x33c
function function_254c9ae()
{
    level flag::set( "keep_going" );
    primary_weapon = getweapon( #"hash_6fb64cfdd4c51dba" );
    
    if ( level.player hasweapon( primary_weapon ) )
    {
        level.player switchtoweapon( primary_weapon );
    }
    else
    {
        weaps = level.player getweaponslistprimaries();
        level.player switchtoweapon( weaps[ 0 ] );
    }
    
    level.player setmovespeedscale( 1 );
    level.player val::reset( #"overlook", "ignoreme" );
    level.adler val::reset( #"overlook", "ignoreme" );
    level.adler val::reset( #"radiant", "ignoreall" );
    level.adler val::reset( #"airfield", "ignoreall" );
    level.woods val::reset( #"overlook", "ignoreme" );
    level.woods val::reset( #"radiant", "ignoreall" );
    level.woods val::reset( #"airfield", "ignoreall" );
    level scene::play( "scene_tkd_hit3_intro_overlook_adler", "hit", [ level.woods, level.adler ] );
    level.adler stopanimscripted();
    level.woods stopanimscripted();
    level.adler colors::enable();
    level.woods colors::enable();
    waitframe( 1 );
    trigger::use( "approach_airstrip", "targetname", undefined, 0 );
    level flag::set( "overlook_guys_done" );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0x85a155e7, Offset: 0x17a8
// Size: 0xa6
function function_7a77e3be( player )
{
    player thread util::show_hint_text( #"hash_1e0dbfcb374f641c", 0, "end_binocs", -1 );
    
    while ( true )
    {
        if ( player weaponswitchbuttonpressed() || player buttonbitstate( "BUTTON_BIT_WEAPPREV" ) )
        {
            player notify( #"end_binocs" );
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0x6553ace7, Offset: 0x1858
// Size: 0x9c
function function_4bc0b384( player )
{
    player waittill( #"end_binocs" );
    player enableweaponcycling();
    player takeweapon( level.var_42db149f );
    sniper = getweapon( #"sniper_quickscope_t9" );
    player switchtoweapon( sniper );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x10ddb2fe, Offset: 0x1900
// Size: 0x98
function function_ef1d8a47()
{
    plane = getent( "cargo_plane", "targetname" );
    
    while ( plane != undefined )
    {
        org = plane gettagorigin( "tag_origin" );
        
        /#
            print3d( org, "<dev string:x38>", ( 1, 1, 1 ), 1, 0.25 );
        #/
        
        wait 0.05;
    }
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 4
// Checksum 0x4f325276, Offset: 0x19a0
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x39813c79, Offset: 0x19d0
// Size: 0x44
function init_flags()
{
    level flag::init( "af_hill_complete" );
    level flag::init( "af_fade_in_complete" );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x80f724d1, Offset: 0x1a20
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x53f81682, Offset: 0x1a30
// Size: 0xc4
function function_22b7fffd()
{
    scene::add_scene_func( "scene_tkd_hit3_intro_overlook", &function_2fc20b49, "initial_loop" );
    scene::add_scene_func( "scene_tkd_hit3_intro_overlook", &function_309e4828, "overlook_shot" );
    scene::add_scene_func( "scene_tkd_hit3_intro_overlook", &function_9b3565b1, "overlook_shot" );
    scene::add_scene_func( "scene_tkd_hit3_intro_overlook_enemy4", &function_f0cab8f5, "overlook_shot" );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0x25f8b0b9, Offset: 0x1b00
// Size: 0x4c
function function_2fc20b49( a_ents )
{
    thread function_94c3f34a( #"hash_2f5bf3e976fdd8ee", a_ents );
    thread function_94c3f34a( #"hash_f4e2cb35f1a71a6", a_ents );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0xd72d9e1c, Offset: 0x1b58
// Size: 0xbc
function function_309e4828( a_ents )
{
    if ( isdefined( a_ents[ #"driver" ] ) )
    {
        a_ents[ #"driver" ] val::set( #"hash_48aa53f40d892719", "ignoreme", 1 );
    }
    
    if ( isdefined( a_ents[ #"bell" ] ) )
    {
        a_ents[ #"bell" ] val::set( #"hash_48aa53f40d892719", "ignoreme", 1 );
    }
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0xa9a1886e, Offset: 0x1c20
// Size: 0xb4
function function_f0cab8f5( a_ents )
{
    level.var_2124e12b = a_ents[ #"hash_f4e2bb35f1a6ff3" ];
    
    if ( isdefined( a_ents[ #"af_enemy4" ] ) )
    {
        guy = a_ents[ #"af_enemy4" ];
        level waittill( #"hash_3da64fdb09072bf3" );
        guy thread cp_takedown_fx::function_f60520a9();
        level.arash thread cp_takedown_fx::function_f60520a9( 0.1, 1 );
    }
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0xa7358124, Offset: 0x1ce0
// Size: 0x8c
function function_9b3565b1( a_ents )
{
    level waittill( #"hash_4d3bb4cb42226cd8" );
    level.af_enemy2 = a_ents[ #"af_enemy2" ];
    thread scene::play( "scene_tkd_hit3_intro_overlook_guy2", "overlook_shot_part2", [ level.af_enemy2, level.var_2124e12b ] );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 2
// Checksum 0x921bf55a, Offset: 0x1d78
// Size: 0x74
function function_94c3f34a( name, ents )
{
    if ( isdefined( ents[ name ] ) )
    {
        thing = ents[ name ];
        thing waittill( #"hash_1e6fd05dff685aca" );
        thing linkto( level.af_plane, "tag_body_animate" );
    }
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x27aeab82, Offset: 0x1df8
// Size: 0x34
function function_78bc26d5()
{
    self vehicle::lights_on();
    self vehicle::toggle_force_driver_taillights( 1 );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x14358f3a, Offset: 0x1e38
// Size: 0x28
function function_f7c7ce51()
{
    level.arash = ai::array_spawn( "arash" )[ 0 ];
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x2cb4c59c, Offset: 0x1e68
// Size: 0x314
function function_dd77a447()
{
    level endoncallback( &function_8c38a6f0, #"car_arrive" );
    player = getplayers()[ 0 ];
    player util::show_hint_text( #"hash_a9076dcaa02f4e", 0, "camera_up", -1 );
    waitframe( 1 );
    player notifyonplayercommand( "binoculars", "+actionslot 4" );
    player waittill( #"binoculars" );
    player notifyonplayercommandremove( "binoculars", "+actionslot 4" );
    waitframe( 1 );
    player notify( #"camera_up" );
    waitframe( 1 );
    sniper = getweapon( #"sniper_quickscope_t9" );
    player giveweapon( sniper );
    player giveweapon( level.var_42db149f );
    var_796f04ff = level.var_42db149f;
    level.arash snipercam::set_enabled( 1, 1, 2 );
    level.var_9febe810 = player getcurrentweapon();
    player switchtoweapon( var_796f04ff );
    player disableweaponcycling();
    
    while ( player getcurrentweapon().name != "eq_binoculars" || !player adsbuttonpressed() )
    {
        waitframe( 1 );
    }
    
    wait 1;
    thread function_d75e55a1( struct::get( "cargo_bay_lookat", "targetname" ), "vox_cp_tdwn_07100_adlr_nosignofhiminth_ef", 6 );
    thread function_8c011eca();
    wait 7;
    guys = getentarray( "af_intro_enemies", "script_noteworthy", 1 );
    lines = [ "vox_cp_tdwn_07100_adlr_thatsnothim_fc", "vox_cp_tdwn_07100_adlr_nope_c0", "vox_cp_tdwn_07100_adlr_justaguard_88" ];
    thread function_d75e55a1( guys, lines );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1, eflags: 0x4
// Checksum 0xb9a7c74e, Offset: 0x2188
// Size: 0x44
function private function_8c38a6f0( *parms )
{
    getplayers()[ 0 ] notifyonplayercommandremove( "binoculars", "+actionslot 4" );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x6d327c3, Offset: 0x21d8
// Size: 0x7c
function function_76b7bfa7()
{
    level flag::wait_till( "af_start_overlook_scene" );
    level.adler dialogue::radio( "vox_cp_tdwn_07100_adlr_anysignofarash_3c" );
    wait 0.5;
    level.adler thread dialogue::radio( "vox_cp_tdwn_07100_adlr_masoncheckitout_eb" );
    thread function_dd77a447();
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x210691b7, Offset: 0x2260
// Size: 0x15c
function function_8c011eca()
{
    level endon( #"hash_5663f4acce350395" );
    targ = getent( "car_look_point", "targetname" );
    wait 1;
    car = getvehiclearray( "airport_truck_approach", "targetname" )[ 0 ];
    car vehicle::lights_on();
    car vehicle::toggle_force_driver_taillights( 1 );
    targ linkto( car, "tag_origin", ( 0, 0, 50 ) );
    level waittill( #"hash_5a1f3e30c78ae9a2" );
    thread function_d75e55a1( targ, "looked_at_car", 15 );
    level waittill( #"hash_3130ba431262d090" );
    
    if ( !level flag::get( "looked_at_car" ) )
    {
        level.adler dialogue::radio( "vox_cp_tdwn_07100_adlr_geteyesonitmaso_68" );
    }
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 0
// Checksum 0x723e15bc, Offset: 0x23c8
// Size: 0x7c
function function_9f929cf3()
{
    level flag::wait_till_any( [ "af_player_get_in_back", "af_player_get_in_left", "af_player_get_in_right" ] );
    self vehicle::lights_off();
    self vehicle::toggle_force_driver_taillights( 0 );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 4
// Checksum 0x30575a06, Offset: 0x2450
// Size: 0x342
function function_d75e55a1( targets, lines, fov = 2, var_dc8ec980 = 5 )
{
    level endon( #"player_break_stealth_fired" );
    level endon( #"player_break_stealth_tarmac" );
    level endon( #"car_arrive" );
    
    if ( !isarray( targets ) )
    {
        targets = [ targets ];
    }
    
    if ( !isarray( lines ) )
    {
        lines = [ lines ];
    }
    
    i = 0;
    player = getplayers()[ 0 ];
    
    while ( !isdefined( player.spy_camera ) )
    {
        waitframe( 1 );
    }
    
    var_dd9a54cd = cos( fov );
    
    while ( i < lines.size )
    {
        while ( player getcurrentweapon().name != "eq_binoculars" || !player adsbuttonpressed() )
        {
            waitframe( 1 );
        }
        
        var_32a7c3bf = undefined;
        
        while ( !isdefined( var_32a7c3bf ) )
        {
            eye_pos = player getplayercamerapos();
            eye_angles = player getplayerangles();
            eye_dir = anglestoforward( eye_angles );
            
            foreach ( targ in targets )
            {
                /#
                #/
                
                if ( !is_true( targ.var_181d1cf5 ) && targ function_e779ff3c( player, eye_pos, eye_angles, var_dd9a54cd, eye_dir, fov ) )
                {
                    var_32a7c3bf = targ;
                    break;
                }
            }
            
            waitframe( 1 );
        }
        
        var_32a7c3bf.var_181d1cf5 = 1;
        
        if ( soundexists( lines[ i ] ) )
        {
            level.adler dialogue::radio( lines[ i ] );
        }
        else
        {
            level flag::set( lines[ i ] );
        }
        
        wait var_dc8ec980;
        i++;
    }
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 6
// Checksum 0xd51d967b, Offset: 0x27a0
// Size: 0xee, Type: bool
function function_e779ff3c( player, eye_pos, eye_angles, var_dd9a54cd, *eye_dir, *fov )
{
    level endon( #"car_arrive" );
    self endon( #"death" );
    target_pos = self.origin + ( 0, 0, 30 );
    
    if ( eye_angles getcurrentweapon().name != "eq_binoculars" || !eye_angles adsbuttonpressed() )
    {
        return false;
    }
    
    if ( util::within_fov( var_dd9a54cd, eye_dir, target_pos, fov ) )
    {
        return true;
    }
    
    return false;
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0xac4aeb74, Offset: 0x2898
// Size: 0x5c
function function_b12fabe5( player )
{
    player endon( #"end_binocs" );
    player waittill( #"weapon_fired" );
    level flag::set( "player_break_stealth_fired" );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0x19a65479, Offset: 0x2900
// Size: 0x25c
function function_cc465a2( player )
{
    level endon( #"af_hill_complete" );
    level endon( #"start_sniping" );
    thread function_b12fabe5( player );
    level flag::wait_till_any( [ "player_break_stealth_fired", "player_break_stealth_tarmac" ] );
    level.woods thread dialogue::radio( "vox_cp_tdwn_07200_wood_masonno_1d" );
    level scene::stop( "scene_tkd_hit3_intro_overlook" );
    level scene::stop( "scene_tkd_hit3_intro_overlook_arash" );
    level scene::stop( "scene_tkd_hit3_intro_overlook_adler" );
    guys = getaiarray();
    
    foreach ( guy in guys )
    {
        guy ai::set_behavior_attribute( "demeanor", "combat" );
        guy val::set( #"failed", "ignoreall", 0 );
        guy val::set( #"failed", "ignoreme", 0 );
    }
    
    wait 3;
    level util::missionfailedwrapper( #"hash_4efe29bbbdba2730", #"hash_307e01d87701c37" );
    level.player notifyonplayercommandremove( "blow_rc_car", "+attack" );
}

// Namespace tkdn_af_hill/cp_takedown_af_hill
// Params 1
// Checksum 0xeec1606f, Offset: 0x2b68
// Size: 0x2c0
function function_a2015343( var_d3440450 )
{
    spawners = getspawnerarray( "af_adler", "targetname" );
    level.adler = spawners[ 0 ] spawner::spawn( 1 );
    level.adler val::set( #"airfield", "ignoreall", 1 );
    level thread util::magic_bullet_shield( level.adler );
    a_ar = getweapon( #"ar_accurate_t9" );
    level.adler setweapon( a_ar );
    spawners = getspawnerarray( "af_woods", "targetname" );
    level.woods = spawners[ 0 ] spawner::spawn( 1 );
    level.woods val::set( #"airfield", "ignoreall", 1 );
    level.woods util::magic_bullet_shield( level.woods );
    
    if ( isdefined( var_d3440450 ) )
    {
        start_spots = struct::get_array( var_d3440450 + "_start", "targetname" );
        
        foreach ( spot in start_spots )
        {
            if ( spot.script_noteworthy == "adler" )
            {
                level.adler forceteleport( spot.origin, spot.angles );
            }
            
            if ( spot.script_noteworthy == "woods" )
            {
                level.woods forceteleport( spot.origin, spot.angles );
            }
        }
    }
}

