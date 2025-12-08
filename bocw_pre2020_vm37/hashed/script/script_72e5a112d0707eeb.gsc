#using script_237e957844a8197c;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;

#namespace namespace_302d34db;

// Namespace namespace_302d34db/namespace_302d34db
// Params 1
// Checksum 0xbe6820e7, Offset: 0x820
// Size: 0xec
function start( *str_objective )
{
    level hms_util::function_ee1d1df6( "park", "Park", "park_rooftop_struct" );
    level hms_util::function_ee1d1df6( "lazar", "Lazar", "lazar_rooftop_struct" );
    level hms_util::function_ee1d1df6( "redshirt_1", "Redshirt 1", "redshirt_1_rooftop_struct" );
    level hms_util::function_ee1d1df6( "redshirt_2", "Redshirt 2", "redshirt_2_rooftop_struct" );
    level thread namespace_a789f8ae::function_ba3f106b( "rooftop_defend" );
}

// Namespace namespace_302d34db/namespace_302d34db
// Params 2
// Checksum 0xf3a3586c, Offset: 0x918
// Size: 0xd0c
function main( *str_objective, *var_50cc0d4f )
{
    /#
        hms_util::print( "<dev string:x38>" );
    #/
    
    var_b6ac0499 = struct::get( "defend_obj_pos", "targetname" );
    objectives::goto( "obj_defend", var_b6ac0499.origin, #"hash_5cdbcd16d36ae175" );
    hms_util::function_eaa0342e( "rooftop_containment_warnings", "rooftop_containment_fails" );
    savegame::checkpoint_save();
    level thread function_7f3b71b8();
    
    if ( isdefined( level.redshirt_1 ) && isalive( level.redshirt_1 ) )
    {
        level.redshirt_1 val::set( #"hash_34296d85d30e4cc7", "magic_bullet_shield", 0 );
        level.redshirt_1 colors::disable();
        level.redshirt_1.goalradius = 8;
        var_e5340d06 = getnode( "rooftop_redshirt_1_node", "targetname" );
        level.redshirt_1 setgoal( var_e5340d06 );
    }
    
    if ( isdefined( level.redshirt_2 ) && isalive( level.redshirt_2 ) )
    {
        level.redshirt_2 val::set( #"hash_34296d85d30e4cc7", "magic_bullet_shield", 0 );
        level.redshirt_2 colors::disable();
        level.redshirt_2.goalradius = 8;
        var_500edd5b = getnode( "rooftop_redshirt_2_node", "targetname" );
        level.redshirt_2 setgoal( var_500edd5b );
    }
    
    wait 5;
    var_90bf938d = spawner::simple_spawn( "rooftop_shooter_guy", &function_f6c194ca );
    level flag::wait_till( "flg_redshirts_killed" );
    level.park.ignoreall = 0;
    level.park.script_accuracy = 1;
    level.park colors::disable();
    var_7caf50bf = getnode( "rooftop_park_node", "targetname" );
    level.park setgoal( var_7caf50bf );
    level.lazar.ignoreall = 0;
    level.lazar.script_accuracy = 1;
    level.lazar colors::disable();
    var_cb77324d = getnode( "rooftop_lazar_node", "targetname" );
    level.lazar setgoal( var_cb77324d );
    var_71dc7937 = spawner::simple_spawn( "rooftop_defend_wave_1_1" );
    level thread function_dda2c76e( var_71dc7937 );
    var_a2b5e6b6 = spawner::simple_spawn( "rooftop_defend_wave_1_2" );
    var_ef4e7fe0 = arraycombine( var_71dc7937, var_a2b5e6b6 );
    var_ef4e7fe0 = arraycombine( var_71dc7937, var_90bf938d );
    ai::waittill_dead_or_dying( var_ef4e7fe0, 3, 25 );
    
    foreach ( guy in var_90bf938d )
    {
        if ( isalive( guy ) )
        {
            guy thread namespace_307260b8::function_10223871( "a_wave_catch_all_enemies_fallback", 1 );
        }
    }
    
    foreach ( guy in var_71dc7937 )
    {
        if ( isalive( guy ) )
        {
            guy thread namespace_307260b8::function_10223871( "a_wave_catch_all_enemies_fallback", 1 );
        }
    }
    
    wait randomfloatrange( 1.5, 2.5 );
    
    foreach ( guy in var_a2b5e6b6 )
    {
        if ( isalive( guy ) )
        {
            guy thread namespace_307260b8::function_10223871( "a_wave_catch_all_enemies_fallback", 1 );
        }
    }
    
    wait 3;
    level flag::set( "flg_wave_1_ended" );
    
    /#
        hms_util::print( "<dev string:x55>" );
    #/
    
    savegame::checkpoint_save();
    level thread function_860ecc4b();
    level.park.script_accuracy = 0.7;
    level.lazar.script_accuracy = 0.7;
    wait 2;
    
    if ( isdefined( level.redshirt_2 ) )
    {
        level.redshirt_2 val::set( #"hash_34296d85d30e4cc7", "magic_bullet_shield", 0 );
        var_8a7d768 = struct::get( "redshirt_2_bullet_origin", "targetname" );
        var_feeb1a4b = struct::get( "redshirt_2_bullet_end_1", "targetname" );
        var_7eca9a0c = struct::get( "redshirt_2_bullet_end_2", "targetname" );
        var_b1197ea9 = struct::get( "redshirt_2_bullet_end_3", "targetname" );
        eye_pos = level.redshirt_2 geteye();
        level.redshirt_2.health = 1;
        magicbullet( getweapon( #"ar_accurate_t9" ), var_8a7d768.origin, eye_pos );
        wait randomfloatrange( 0.4, 0.5 );
        magicbullet( getweapon( #"ar_accurate_t9" ), var_8a7d768.origin, var_feeb1a4b.origin );
        wait randomfloatrange( 0.2, 0.5 );
        magicbullet( getweapon( #"ar_accurate_t9" ), var_8a7d768.origin, var_7eca9a0c.origin );
        wait randomfloatrange( 0.3, 0.5 );
        magicbullet( getweapon( #"ar_accurate_t9" ), var_8a7d768.origin, var_b1197ea9.origin );
        
        if ( isalive( level.redshirt_2 ) )
        {
            level.redshirt_2 kill();
        }
    }
    
    level flag::set( "flg_wave_2_started" );
    var_f3a603f8 = spawner::simple_spawn( "rooftop_defend_wave_2_1" );
    var_8dfae19f = array::random( var_f3a603f8 );
    var_8dfae19f hms_util::dialogue( "vox_cp_cbcr_02300_csm1_laydownsuppress_c8" );
    wait randomfloatrange( 2, 3.5 );
    var_75c4d06a = spawner::simple_spawn( "rooftop_defend_wave_2_drones" );
    wait 9;
    var_b9943a82 = spawner::simple_spawn( "rooftop_defend_wave_2_2" );
    wait randomfloatrange( 2, 4.5 );
    var_4eaacd6c = spawner::simple_spawn( "rooftop_defend_wave_2_4" );
    wait randomfloatrange( 2.5, 4 );
    var_9bc52185 = spawner::simple_spawn( "rooftop_defend_wave_2_3" );
    var_cf35de07 = arraycombine( var_f3a603f8, var_b9943a82 );
    var_cf35de07 = arraycombine( var_cf35de07, var_9bc52185 );
    var_cf35de07 = arraycombine( var_cf35de07, var_4eaacd6c );
    ai::waittill_dead_or_dying( var_cf35de07, 9, 25 );
    
    foreach ( guy in var_cf35de07 )
    {
        if ( isalive( guy ) )
        {
            guy.script_accuracy = 0.4;
            guy.health = 75;
        }
    }
    
    level flag::set( "flg_wave_2_fallback" );
    level flag::wait_till( "flg_retreat_vo_ended" );
    level flag::set( "flg_defend_complete" );
    
    /#
        hms_util::print( "<dev string:x65>" );
    #/
    
    objectives::complete( "obj_defend" );
    skipto::function_4e3ab877( "rooftop_defend_1" );
}

// Namespace namespace_302d34db/namespace_302d34db
// Params 0
// Checksum 0xc8ade322, Offset: 0x1630
// Size: 0x19c
function function_f6c194ca()
{
    self val::set( #"hash_1182326d170ca509", "magic_bullet_shield", 1 );
    self.script_accuracy = 1000;
    self.goalradius = 8;
    self waittill( #"goal" );
    startpos = self gettagorigin( "tag_flash" );
    
    if ( isdefined( level.redshirt_1 ) )
    {
        eye_pos = level.redshirt_1 geteye();
        level.redshirt_1.health = 1;
        magicbullet( self.weapon, startpos, eye_pos, self );
        magicbullet( self.weapon, startpos, eye_pos, self );
        
        if ( isalive( level.redshirt_1 ) )
        {
            level.redshirt_1 kill();
        }
    }
    
    wait 2;
    self val::set( #"hash_1182326d170ca509", "magic_bullet_shield", 0 );
    self.script_accuracy = 0.8;
    level flag::set( "flg_redshirts_killed" );
}

// Namespace namespace_302d34db/namespace_302d34db
// Params 0
// Checksum 0x2d234140, Offset: 0x17d8
// Size: 0x254
function function_2f12941a()
{
    var_a64679e5 = spawner::simple_spawn_single( "rooftop_defend_wave_1_left_rpg" );
    var_a64679e5 val::set( #"hash_55bf25a0d284544d", "magic_bullet_shield", 1 );
    var_a64679e5.goalradius = 8;
    var_a64679e5 waittill( #"goal" );
    wait 2;
    startpos = var_a64679e5 gettagorigin( "tag_flash" );
    endpos = struct::get( "rooftop_RPG_dest", "targetname" );
    var_4a3daa0b = struct::get( "rooftop_rpg_lookat", "targetname" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos( 35 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    magicbullet( var_a64679e5.weapon, startpos, endpos.origin, var_a64679e5 );
    wait 2;
    var_a64679e5 val::set( #"hash_55bf25a0d284544d", "magic_bullet_shield", 0 );
    level flag::set( "flg_rooftop_magic_rpg_done" );
}

// Namespace namespace_302d34db/namespace_302d34db
// Params 3
// Checksum 0x149400df, Offset: 0x1a38
// Size: 0x9c
function function_1bdb683( var_9608b240, min_delay = 0.5, max_delay = 2.5 )
{
    self endon( #"death" );
    wait randomfloatrange( min_delay, max_delay );
    self ai::set_goal( var_9608b240, "targetname", 1 );
}

// Namespace namespace_302d34db/namespace_302d34db
// Params 0
// Checksum 0x15d7e5b9, Offset: 0x1ae0
// Size: 0x100
function function_860ecc4b()
{
    var_4409ee01 = struct::get_array( "wave_2_smoke", "targetname" );
    
    foreach ( var_10ed23ba in var_4409ee01 )
    {
        level.player magicgrenadeplayer( getweapon( #"willy_pete" ), var_10ed23ba.origin, ( 0, 0, 0 ) );
        wait randomfloatrange( 1, 3 );
    }
}

// Namespace namespace_302d34db/namespace_302d34db
// Params 0
// Checksum 0xbbbf18d6, Offset: 0x1be8
// Size: 0x25c
function function_7f3b71b8()
{
    level.player endon( #"death" );
    var_e534dcb = struct::get( "ai_alder_radio", "targetname" );
    level flag::wait_till( "flg_redshirts_killed" );
    var_e534dcb hms_util::dialogue( "vox_cp_cbcr_02200_adlr_headsupparkyoug_25", 1, "allies", "Adler" );
    level.park hms_util::dialogue( "vox_cp_cbcr_02200_park_copythat_8d", undefined, "allies", "Park" );
    level.park hms_util::dialogue( "vox_cp_cbcr_02200_park_belltakeoutthos_70", undefined, "allies", "Park" );
    wait 3;
    level.lazar hms_util::dialogue( "vox_cp_cbcr_01900_lazr_shittheyreevery_cc", undefined, "allies", "Lazar" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01900_park_usecontrolledbu_61", undefined, "allies", "Park" );
    level flag::wait_till( "flg_wave_1_ended" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01900_park_knowwhatlazarit_aa", undefined, "allies", "Park" );
    level.lazar hms_util::dialogue( "vox_cp_cbcr_01900_lazr_hadontteasemepa_99", undefined, "allies", "Lazar" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01900_park_butwellhavenone_4b", undefined, "allies", "Park" );
    level.lazar hms_util::dialogue( "vox_cp_cbcr_01900_lazr_getreadyherethe_d9", undefined, "allies", "Lazar" );
    level flag::set( "flg_retreat_vo_ended" );
}

/#

    // Namespace namespace_302d34db/namespace_302d34db
    // Params 4
    // Checksum 0x15d43515, Offset: 0x1e50
    // Size: 0x44, Type: dev
    function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
    {
        hms_util::print( "<dev string:x78>" );
    }

#/

// Namespace namespace_302d34db/namespace_302d34db
// Params 1
// Checksum 0xe4507499, Offset: 0x1ea0
// Size: 0x174
function function_dda2c76e( var_bf6c8bb9 )
{
    level endon( #"death" );
    var_a274dfb9 = array::random( var_bf6c8bb9 );
    var_879729fe = array::random( var_bf6c8bb9 );
    
    while ( isdefined( var_a274dfb9 ) && isdefined( var_879729fe ) )
    {
        var_a274dfb9 hms_util::dialogue( "vox_cp_cbcr_01800_csm1_iseethem_95" );
        var_879729fe hms_util::dialogue( "vox_cp_cbcr_01800_csm2_theyareontheroo_47" );
        var_879729fe hms_util::dialogue( "vox_cp_cbcr_01800_csm1_shootthemdonotl_25" );
        wait randomfloatrange( 0.5, 1.25 );
        var_a274dfb9 hms_util::dialogue( "vox_cp_cbcr_01800_csm2_rpgsbringupther_88" );
        var_879729fe hms_util::dialogue( "vox_cp_cbcr_01800_csm1_firefirenow_e2" );
        wait randomfloatrange( 0.5, 1.25 );
        var_a274dfb9 hms_util::dialogue( "vox_cp_cbcr_01800_csm1_aplaneiscomingq_5d" );
        break;
    }
}

