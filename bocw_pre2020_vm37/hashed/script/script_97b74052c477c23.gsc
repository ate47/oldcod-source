#using script_155b17ff7c8b315c;
#using script_1b9f100b85b7e21d;
#using script_32ff16d71b77016b;
#using script_3dc93ca9902a9cda;
#using script_446752c03c555e16;
#using script_6cd35fe7afb1f231;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\debug_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace namespace_fc3e8cb;

/#

    // Namespace namespace_fc3e8cb/namespace_30614c90
    // Params 1
    // Checksum 0xc399072d, Offset: 0xb40
    // Size: 0xac, Type: dev
    function function_44a6fc04( str_objective )
    {
        var_72d16a3 = level.var_965c6227[ str_objective ];
        hms_util::print( "<dev string:x38>" + var_72d16a3[ 0 ] );
        hms_util::print( "<dev string:x43>" + var_72d16a3[ 1 ] + "<dev string:x4e>" + var_72d16a3[ 2 ] );
        hms_util::print( "<dev string:x5d>" + var_72d16a3[ 3 ] );
    }

#/

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0xa778fdd0, Offset: 0xbf8
// Size: 0xcc
function setup_player()
{
    if ( !isdefined( level.player ) )
    {
        level.player = self;
    }
    
    level.player setcharacterbodytype( 1 );
    level.player setcharacteroutfit( 1 );
    level.player util::function_a5318821();
    level flag::delay_set( 0.1, "flg_amk_player_spawned" );
    
    /#
        level thread hms_util::function_32397759();
        level thread hms_util::function_5056f90d();
    #/
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0xfc033012, Offset: 0xcd0
// Size: 0x2a4
function function_2e7c81f6( b_sniper = 1 )
{
    self notify( "70fbe8e51e22a387" );
    self endon( "70fbe8e51e22a387" );
    level flag::wait_till( "flg_amk_player_spawned" );
    
    if ( b_sniper == 1 )
    {
        var_a7167363 = getweapon( #"tr_damagesemi_t9", "scope4x", "suppressed" );
        w_pistol = getweapon( #"pistol_semiauto_t9", "suppressed" );
        var_70944588 = getweapon( #"hatchet" );
        var_efedf7ab = getweapon( #"eq_flash_grenade" );
        level.player hms_util::function_2e7c81f6( var_a7167363, w_pistol, var_70944588, var_efedf7ab );
        level.player setweaponammostock( var_a7167363, var_a7167363.clipsize );
    }
    else
    {
        var_a7167363 = getweapon( #"ar_accurate_t9", "acog", "suppressed" );
        w_pistol = getweapon( #"pistol_burst_t9", "suppressed" );
        var_c6d90c31 = getweapon( #"frag_grenade" );
        var_efedf7ab = getweapon( #"eq_flash_grenade" );
        level.player hms_util::function_2e7c81f6( var_a7167363, w_pistol, var_c6d90c31, var_efedf7ab );
    }
    
    if ( skipto::function_a002f769() > skipto::function_3a4ee594( #"forest" ) )
    {
        level function_4c2899e3();
        return;
    }
    
    level.player spy_camera::function_b83af2a9();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x30e10013, Offset: 0xf80
// Size: 0x5c
function function_60c0a6d5()
{
    assert( isdefined( level.player ) );
    level.player val::set( #"hash_4ee58d2f2fe9f3c2", "disable_weapons", 1 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x6e301549, Offset: 0xfe8
// Size: 0x54
function function_2e910b9e()
{
    assert( isdefined( level.player ) );
    level.player val::reset( #"hash_4ee58d2f2fe9f3c2", "disable_weapons" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0x260914b8, Offset: 0x1048
// Size: 0x1a8, Type: bool
function function_bcdd0822( var_faa5f280 )
{
    if ( isarray( var_faa5f280 ) )
    {
        a_vols = var_faa5f280;
    }
    else
    {
        a_vols = getentarray( var_faa5f280, "targetname" );
    }
    
    foreach ( vol in a_vols )
    {
        if ( level.player istouching( vol ) )
        {
            stance = level.player getstance();
            
            if ( !isdefined( vol.script_noteworthy ) )
            {
                vol.script_noteworthy = "none";
            }
            
            switch ( vol.script_noteworthy )
            {
                case #"hash_1552d5a025d14bda":
                    return ( stance == "crouch" || stance == "prone" );
                case #"prone_only":
                    return ( stance == "prone" );
                case #"none":
                    return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0x7e797c00, Offset: 0x11f8
// Size: 0xc2
function function_92dea087( var_77bf059, var_f99e65cb )
{
    level.player endon( #"death" );
    level endon( var_77bf059 );
    
    if ( level flag::get( var_77bf059 ) == 1 )
    {
        return;
    }
    
    while ( level flag::get( var_77bf059 ) == 0 )
    {
        if ( level.player issprinting() && level flag::get( var_f99e65cb ) == 1 )
        {
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x55788f30, Offset: 0x12c8
// Size: 0x164
function function_9cdd44af( var_77bf059, ai_ally, n_dist )
{
    level.player endon( #"death" );
    
    if ( level flag::get( var_77bf059 ) == 1 )
    {
        return;
    }
    
    var_940ac4fc = sqr( n_dist );
    
    while ( level flag::get( var_77bf059 ) == 0 )
    {
        var_63ffbf62 = distance2dsquared( level.player getplayercamerapos(), ai_ally.origin );
        var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), ai_ally geteye(), 0.866025 );
        
        if ( var_63ffbf62 < var_940ac4fc && var_e88b5bd1 == 1 )
        {
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x76110ec3, Offset: 0x1438
// Size: 0x64
function function_4c2899e3()
{
    level.player spy_camera::function_6de171e9();
    level thread function_acc7034f();
    level thread function_892ec10f();
    level.player spy_camera::function_69190c4e();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1, eflags: 0x4
// Checksum 0xb460e8e4, Offset: 0x14a8
// Size: 0x1e4
function private function_acc7034f( *var_40c5518a )
{
    level.var_81357431 = spawnstruct();
    level.var_81357431.n_progress = 0;
    level.var_81357431.var_e8adad29 = getentarray( "e_obj_optional_photo", "targetname" );
    level.var_81357431.n_total = level.var_81357431.var_e8adad29.size;
    level.var_81357431.var_3b9a24cf = undefined;
    level function_c2bda416( level.var_81357431.var_e8adad29 );
    level.var_81357431.var_e8adad29 = array::sort_by_script_int( level.var_81357431.var_e8adad29, 1 );
    objectives::scripted( #"hash_501dd5bd78d2273", undefined, undefined, 1, 1 );
    objectives::function_572778b9( #"hash_501dd5bd78d2273" );
    
    foreach ( e_location in level.var_81357431.var_e8adad29 )
    {
        e_location thread function_9927587f();
    }
    
    level thread function_82b49ecb();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1, eflags: 0x4
// Checksum 0x51432f1a, Offset: 0x1698
// Size: 0x104
function private function_c2bda416( var_e8adad29 )
{
    transient = savegame::function_6440b06b( #"transient" );
    
    if ( !isdefined( transient.var_b9609b2d ) )
    {
        transient.var_b9609b2d = [];
        
        foreach ( e_location in var_e8adad29 )
        {
            assert( isdefined( e_location.script_int ), "<dev string:x69>" + e_location.origin );
            transient.var_b9609b2d[ e_location.script_int ] = 0;
        }
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0xab52e8a2, Offset: 0x17a8
// Size: 0x32c
function private function_9927587f()
{
    transient = savegame::function_6440b06b( #"transient" );
    self clientfield::set( "spy_camera_entity_highlight", 1 );
    
    if ( transient.var_b9609b2d[ self.script_int ] == 0 )
    {
        level.player spy_camera::function_f785d9e9( self );
        
        while ( distance2dsquared( level.player getplayercamerapos(), self.origin ) > 1000000 )
        {
            wait 1;
        }
        
        self thread function_3b12ac8b();
        self waittill( #"photo_taken" );
        self clientfield::set( "spy_camera_entity_highlight", 1 );
        level.player notify( #"hash_39e8eb6815359328" );
        level.player flag::clear( "flg_random_photo_taken" );
        level.player spy_camera::function_b28ab5a9( self );
        level thread namespace_4bd68414::function_b27f23a4();
        transient.var_b9609b2d[ self.script_int ] = 1;
    }
    
    self.var_1c63e4ff = 1;
    wait self.script_int * 0.1;
    n_obj_id = objectives::function_285e460( #"hash_501dd5bd78d2273" );
    
    if ( !objectives_ui::function_1fe5876a( n_obj_id ) )
    {
        objectives::remove( #"hash_501dd5bd78d2273" );
        objectives::scripted( #"hash_501dd5bd78d2273", undefined, #"hash_7797d67a445d078b", 1, 1 );
    }
    
    level.var_81357431.n_progress += 1;
    
    if ( level.var_81357431.n_progress >= 3 )
    {
        collectibles::function_6cd091d2( 1 );
    }
    
    objectives::function_1de88d60( #"hash_501dd5bd78d2273", undefined, level.var_81357431.n_progress, level.var_81357431.n_total );
    level thread objectives_ui::function_8d9f9a22( n_obj_id );
    level objectives_ui::function_1c6b4aeb();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0x8398deac, Offset: 0x1ae0
// Size: 0x1d2
function private function_3b12ac8b()
{
    self endon( #"photo_taken" );
    var_8d303950 = 0;
    var_d0f490e6 = 0;
    
    while ( true )
    {
        if ( level.player clientfield::get_to_player( "spy_camera_state" ) === 1 && distance2dsquared( level.player getplayercamerapos(), self.origin ) < 1000000 )
        {
            if ( util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), self.origin, cos( 7 ) ) )
            {
                if ( !var_d0f490e6 )
                {
                    self clientfield::set( "spy_camera_entity_highlight", 2 );
                    var_d0f490e6 = 1;
                    var_8d303950 = 0;
                }
            }
            else if ( !var_8d303950 )
            {
                self clientfield::set( "spy_camera_entity_highlight", 0 );
                var_8d303950 = 1;
                var_d0f490e6 = 0;
            }
        }
        else if ( var_8d303950 || var_d0f490e6 )
        {
            self clientfield::set( "spy_camera_entity_highlight", 1 );
            var_8d303950 = 0;
            var_d0f490e6 = 0;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0x224f3a8d, Offset: 0x1cc0
// Size: 0x46a
function private function_82b49ecb()
{
    if ( !isdefined( level.var_81357431.var_e8adad29 ) || level.var_81357431.var_e8adad29.size == 0 )
    {
        return;
    }
    
    level.player endon( #"death" );
    var_9b61a419 = 0;
    var_fae275b = 0;
    level.var_81357431.var_3b9a24cf = level.var_81357431.var_e8adad29[ 0 ];
    var_c1a11a19 = isdefined( level.var_81357431.var_3b9a24cf.radius ) ? level.var_81357431.var_3b9a24cf.radius : 120;
    objectives::function_64eaa790( #"hash_501dd5bd78d2273", level.var_81357431.var_3b9a24cf.origin, var_c1a11a19 );
    level childthread function_a78e7616();
    
    while ( !var_9b61a419 )
    {
        var_9b61a419 = 1;
        
        foreach ( index, e_location in level.var_81357431.var_e8adad29 )
        {
            var_9b61a419 = var_9b61a419 && is_true( e_location.var_1c63e4ff );
            
            if ( level.var_81357431.var_3b9a24cf === e_location && is_true( e_location.var_1c63e4ff ) )
            {
                next_index = int( index + 1 ) % level.var_81357431.var_e8adad29.size;
                level.var_81357431.var_3b9a24cf = level.var_81357431.var_e8adad29[ next_index ];
                var_fae275b = 1;
            }
            
            if ( is_true( e_location.var_1c63e4ff ) || level.var_81357431.var_3b9a24cf === e_location )
            {
                continue;
            }
            
            n_dist_sq = distancesquared( level.player.origin, e_location.origin );
            
            if ( var_fae275b || n_dist_sq < 2250000 )
            {
                var_ffb8b091 = distancesquared( level.player.origin, level.var_81357431.var_3b9a24cf.origin );
                
                if ( var_fae275b || n_dist_sq < var_ffb8b091 )
                {
                    level.var_81357431.var_3b9a24cf = e_location;
                    var_c1a11a19 = isdefined( level.var_81357431.var_3b9a24cf.radius ) ? level.var_81357431.var_3b9a24cf.radius : 120;
                    objectives::function_64eaa790( #"hash_501dd5bd78d2273", level.var_81357431.var_3b9a24cf.origin, var_c1a11a19 );
                    var_fae275b = 0;
                    level.player flag::set( #"hash_45382cf2204384c6" );
                }
            }
        }
        
        wait 2;
    }
    
    level notify( "objective_search_area_" + #"hash_501dd5bd78d2273" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0x7e0df58d, Offset: 0x2138
// Size: 0x140
function private function_a78e7616()
{
    var_b4af06 = array( 2, 4 );
    
    while ( true )
    {
        level.player flag::wait_till( #"hash_45382cf2204384c6" );
        wait 2;
        
        if ( array::contains( var_b4af06, level.var_81357431.var_3b9a24cf.script_int ) )
        {
            if ( !level.woods function_5b19aae2() && is_true( globallogic_ui::function_f053dcd4( "hudItems.cpObjectiveUiData.inObjectiveArea", 1 ) ) )
            {
                level.player flag::clear( #"hash_45382cf2204384c6" );
            }
            
            continue;
        }
        
        level.player flag::clear( #"hash_45382cf2204384c6" );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x11f9b6, Offset: 0x2280
// Size: 0x144
function function_7c239699()
{
    assert( isdefined( self ), "<dev string:xa5>" );
    self endon( #"death" );
    level endon( #"hash_62739f932c524e7e" );
    n_counter = 0;
    level.woods clientfield::set( "spy_camera_photo_reset", 1 );
    
    while ( isdefined( self ) )
    {
        self waittillmatch( { #var_aad36d51:0, #fieldvalue:1 }, #"hash_72a5fe161eb7a0ce" );
        level.player flag::clear( "flg_random_photo_taken" );
        
        if ( !self function_5b19aae2() && !self flag::get( "flg_pause_photo_react" ) )
        {
            level namespace_4bd68414::function_4c8c8596( n_counter );
            n_counter++;
            wait 3;
        }
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x3642b188, Offset: 0x23d0
// Size: 0x130
function function_892ec10f()
{
    level.player endon( #"death" );
    
    while ( isdefined( level.player ) )
    {
        level.player flag::set( "flg_random_photo_taken" );
        level.player waittill( #"take_picture" );
        waitresult = level.player flag::wait_till_clear_timeout( 0.25, "flg_random_photo_taken" );
        var_fad6b56b = level.player flag::get( "flg_random_photo_taken" ) && !level.woods flag::get( "flg_pause_photo_react" );
        
        if ( var_fad6b56b && !level.woods function_5b19aae2() )
        {
            level namespace_4bd68414::general_woods_take_random_photo_react_dialogue();
        }
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0xf6ced0c8, Offset: 0x2508
// Size: 0x72, Type: bool
function function_5b19aae2( var_6488ee49 = 5 )
{
    assert( isdefined( self ), "<dev string:xc7>" );
    
    if ( isdefined( self.lastsaytime ) )
    {
        n_elapsed_time = ( gettime() - self.lastsaytime ) * 0.001;
        return ( n_elapsed_time <= var_6488ee49 );
    }
    
    return false;
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x8ba0a873, Offset: 0x2588
// Size: 0xbc
function function_e610d177()
{
    if ( !isdefined( level.park ) )
    {
        level.park = spawn( "script_origin", ( 0, 0, 0 ) );
        level.park.team = "allies";
        level.park.propername = #"hash_a0d642b09afc71a";
        level.park.name = #"hash_a0d642b09afc71a";
        animation::add_notetrack_func( "amerika_util::park_scene_radio_dialogue_play", &function_4bf8c9de );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0xd304a6e8, Offset: 0x2650
// Size: 0x2c
function function_4bf8c9de( var_8a9a3456 )
{
    level.park hms_util::dialogue( var_8a9a3456, 1 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0xf13c52ca, Offset: 0x2688
// Size: 0x1c4
function function_2987fd4c( var_ad992a98, b_stealth = 0, b_sniper = 1 )
{
    if ( !isdefined( level.woods ) )
    {
        var_58d5c920 = b_sniper ? "woods_sniper" : "woods_smg";
        hms_util::function_ee1d1df6( "woods", #"hash_22f2861ded3918a8", var_ad992a98, undefined, var_58d5c920 );
    }
    
    var_148fe77c = getweapon( #"sniper_quickscope_t9", "suppressed" );
    var_5ca6956f = getweapon( #"smg_standard_t9", "suppressed" );
    var_8cb34e5a = b_sniper ? var_148fe77c : var_5ca6956f;
    level.woods hms_util::function_65d14a19( var_8cb34e5a );
    level.woods.goalradius = 32;
    level.woods.script_radius = 32;
    
    if ( b_stealth )
    {
        level.woods function_4171ba27();
    }
    else
    {
        level.woods function_d74bffa7();
    }
    
    level.woods thread function_7c239699();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0xac11c1e3, Offset: 0x2858
// Size: 0x86
function function_4171ba27()
{
    self.grenadeammo = 0;
    self val::set( #"hash_7f4af3d9057acdb8", "ignoreme", 1 );
    self ai::set_pacifist( 1 );
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    self.battlechatterallowed = 0;
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0xc9787820, Offset: 0x28e8
// Size: 0xf4
function function_d74bffa7( var_5c93d2e9 = 1, var_60a8206b = 1 )
{
    if ( var_5c93d2e9 == 1 )
    {
        self.grenadeammo = 10;
    }
    else
    {
        self.grenadeammo = 0;
    }
    
    if ( var_60a8206b == 1 )
    {
        self.battlechatterallowed = 1;
    }
    else
    {
        self.battlechatterallowed = 0;
    }
    
    self val::reset( #"hash_7f4af3d9057acdb8", "ignoreme" );
    self ai::set_pacifist( 0 );
    self ai::set_behavior_attribute( "demeanor", "combat" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x107f2ce1, Offset: 0x29e8
// Size: 0x166
function function_5c5b6ea7( var_4f8a118b, b_ignoreall = 0, b_sprint = 0 )
{
    level.woods endon( #"death" );
    level.woods notify( #"amk_woods_new_goal" );
    level.woods clearforcedgoal();
    
    if ( !isalive( level.woods ) )
    {
        return;
    }
    
    nd_goal = getnode( var_4f8a118b, "targetname" );
    level.woods ai::force_goal( nd_goal, !b_ignoreall, "amk_woods_new_goal", 0, b_sprint );
    
    if ( isdefined( nd_goal.script_flag_set ) )
    {
        level flag::set( nd_goal.script_flag_set );
    }
    
    waitframe( 1 );
    
    if ( isalive( level.woods ) )
    {
        level.woods.goalradius = 32;
        level.woods.script_radius = 32;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x908bc227, Offset: 0x2b58
// Size: 0x27a
function function_384c3b4b( var_6ff64ad8, var_f65fa869, var_bd18358e )
{
    level.player endon( #"death" );
    level.woods endon( #"death" );
    var_583c5a3b = 0.5;
    
    if ( isdefined( var_bd18358e ) )
    {
        level flag::wait_till_any( var_bd18358e );
    }
    
    wait 0.5;
    function_1eaaceab( var_6ff64ad8 );
    
    if ( var_6ff64ad8.size == 0 )
    {
        return;
    }
    
    var_1dcd05ba = level.woods.script_accuracy;
    level.woods aimatentityik( array::random( var_6ff64ad8 ) );
    
    while ( level flag::get( var_f65fa869 ) == 0 )
    {
        function_1eaaceab( var_6ff64ad8 );
        
        if ( isdefined( var_6ff64ad8[ 0 ] ) )
        {
            level.woods aimatentityik( var_6ff64ad8[ 0 ] );
            level.woods ai::set_pacifist( 0 );
            level.woods.script_accuracy = 1000;
            level.woods ai::shoot_at_target( "kill_within_time", var_6ff64ad8[ 0 ], "tag_eye", var_583c5a3b, 10, 1 );
        }
        else
        {
            break;
        }
        
        if ( level flag::get( var_f65fa869 ) == 0 )
        {
            wait randomfloatrange( 0.5, 1.5 );
            continue;
        }
        
        wait 0.1;
    }
    
    level.woods aimatentityik();
    level.woods ai::set_pacifist( 1 );
    level.woods.script_accuracy = var_1dcd05ba;
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0xe28fdee, Offset: 0x2de0
// Size: 0x94
function function_290225d9( ai, var_583c5a3b )
{
    ai endon( #"death" );
    level.player endon( #"death" );
    wait var_583c5a3b + 0.1;
    ai.health = 10;
    self shoot( 1, ai geteye() );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x87f11ce5, Offset: 0x2e80
// Size: 0x72
function function_a47a7ec()
{
    if ( !isdefined( level.var_cf584ebf ) )
    {
        level.var_cf584ebf = {};
        level.var_cf584ebf.team = "axis";
        level.var_cf584ebf.name = "Loudspeaker";
        level.var_cf584ebf.locations = namespace_b61bbd82::function_c10bf5c5();
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x69b86b8f, Offset: 0x2f00
// Size: 0xba
function function_e57eea9a()
{
    switch ( level.gameskill )
    {
        case 0:
            self.var_1c936867 = 550;
            break;
        case 1:
            self.var_1c936867 = 650;
            break;
        case 2:
            self.var_1c936867 = 750;
            break;
        case 3:
            self.var_1c936867 = 850;
            break;
        default:
            self.var_1c936867 = 850;
            break;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x4aa20582, Offset: 0x2fc8
// Size: 0x84
function function_aa5f0d6b()
{
    self.grenadeammo = 0;
    self.health = 10;
    self.goalradius = 32;
    self val::set( #"hash_608ec07467e56d9c", "ignoreme", 1 );
    self val::set( #"hash_608ec07467e56d9c", "ignoreall", 1 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x64e9c1, Offset: 0x3058
// Size: 0xcc
function function_a23603cf()
{
    hidden = [];
    hidden[ #"prone" ] = 200;
    hidden[ #"crouch" ] = 600;
    hidden[ #"stand" ] = 800;
    spotted = [];
    spotted[ #"prone" ] = 800;
    spotted[ #"crouch" ] = 1200;
    spotted[ #"stand" ] = 1600;
    namespace_979752dc::set_detect_ranges( hidden, spotted );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x5fa2f33e, Offset: 0x3130
// Size: 0xb4
function function_85939627( ai_array, var_335a8dcc, var_91e1c669 )
{
    if ( !isdefined( ai_array ) )
    {
        ai_array = [];
    }
    else if ( !isarray( ai_array ) )
    {
        ai_array = array( ai_array );
    }
    
    if ( !isdefined( var_91e1c669 ) || var_91e1c669 > ai_array.size )
    {
        var_91e1c669 = ai_array.size;
    }
    
    ai::waittill_dead_or_dying( ai_array, var_91e1c669 );
    flag::set( var_335a8dcc );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 4
// Checksum 0xb84e487, Offset: 0x31f0
// Size: 0x108
function function_535e9168( ai_array, var_335a8dcc, var_d0568a36 = 0, var_9d4ecd2b = undefined )
{
    if ( !isdefined( ai_array ) )
    {
        ai_array = [];
    }
    else if ( !isarray( ai_array ) )
    {
        ai_array = array( ai_array );
    }
    
    foreach ( ai in ai_array )
    {
        ai thread function_e193f7f( var_335a8dcc, var_d0568a36, var_9d4ecd2b );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x3821654c, Offset: 0x3300
// Size: 0x23c
function function_e193f7f( var_335a8dcc, var_d0568a36 = 0, var_9d4ecd2b = undefined )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( var_335a8dcc );
    
    if ( var_d0568a36 == 0 )
    {
        self endon( #"death" );
    }
    
    while ( true )
    {
        if ( var_d0568a36 == 0 )
        {
            s_event = self waittill( #"stealth_spotted", #"damage", #"player_sighted", #"bulletwhizby" );
            wait 0.5;
            
            if ( self.health <= 0 )
            {
                return;
            }
            
            if ( s_event._notify == "damage" && s_event.attacker != level.player )
            {
                waitframe( 1 );
                continue;
            }
            else
            {
                break;
            }
        }
        else
        {
            s_event = self waittill( #"stealth_spotted", #"damage", #"player_sighted", #"bulletwhizby", #"death" );
            
            if ( s_event._notify == "damage" && s_event.attacker != level.player )
            {
                waitframe( 1 );
                continue;
            }
            else
            {
                break;
            }
        }
        
        waitframe( 1 );
    }
    
    if ( isdefined( var_9d4ecd2b ) )
    {
        var_9d4ecd2b.guy = self;
    }
    
    level flag::set( var_335a8dcc );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0xa1fcdf89, Offset: 0x3548
// Size: 0xa4
function function_18e5080e( var_69089a71, a_array )
{
    if ( !isdefined( a_array ) || a_array.size <= 0 )
    {
        return;
    }
    
    level flag::wait_till( var_69089a71 );
    
    if ( !isdefined( a_array ) )
    {
        a_array = [];
    }
    else if ( !isarray( a_array ) )
    {
        a_array = array( a_array );
    }
    
    array::delete_all( a_array );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 5
// Checksum 0x2a79fc3b, Offset: 0x35f8
// Size: 0x290
function function_55a81eeb( var_778920ed, a_array, var_3f01ab8a = 1, var_4762a02d = 1, var_9d4ecd2b = undefined )
{
    if ( !isdefined( a_array ) || a_array.size <= 0 )
    {
        return;
    }
    
    if ( isarray( var_778920ed ) )
    {
        level flag::wait_till_any( var_778920ed );
    }
    else
    {
        level flag::wait_till( var_778920ed );
    }
    
    waitframe( 1 );
    
    if ( !isdefined( a_array ) )
    {
        a_array = [];
    }
    else if ( !isarray( a_array ) )
    {
        a_array = array( a_array );
    }
    
    function_1eaaceab( a_array );
    
    if ( isdefined( var_9d4ecd2b ) && isdefined( var_9d4ecd2b.guy ) )
    {
        a_array = array::get_all_closest( var_9d4ecd2b.guy.origin, a_array );
        b_delay = 1;
    }
    else
    {
        b_delay = 0;
    }
    
    foreach ( ai in a_array )
    {
        if ( isdefined( ai ) )
        {
            ai thread namespace_979752dc::enable_stealth_for_ai( 0, 1 );
            
            if ( var_3f01ab8a )
            {
                ai getenemyinfo( level.player );
            }
            
            if ( var_4762a02d )
            {
                ai.battlechatterallowed = 1;
            }
            else
            {
                ai.battlechatterallowed = 0;
            }
            
            if ( b_delay == 1 )
            {
                wait randomfloatrange( 0.5, 1.5 );
            }
        }
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 6
// Checksum 0xba99ce65, Offset: 0x3890
// Size: 0x104
function function_940ffdb0( var_3195dfe3, var_758b7f39, var_69747751, var_ca838126, var_1140c6d6 = 1, var_2385fea0 = 1 )
{
    level.player endon( #"death" );
    
    if ( isarray( var_3195dfe3 ) )
    {
        level flag::wait_till_any( var_3195dfe3 );
    }
    else
    {
        level flag::wait_till( var_3195dfe3 );
    }
    
    function_1eaaceab( var_758b7f39 );
    
    if ( var_758b7f39.size <= 0 )
    {
        return;
    }
    
    level thread function_8e158d78( var_758b7f39, var_69747751, var_ca838126, var_1140c6d6, var_2385fea0 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 5
// Checksum 0x52811fbd, Offset: 0x39a0
// Size: 0x3b8
function function_8e158d78( var_758b7f39, var_69747751, var_ca838126, var_1140c6d6 = 1, var_2385fea0 = 1 )
{
    level.player endon( #"death" );
    
    if ( !isdefined( var_ca838126 ) )
    {
        var_ca838126 = var_758b7f39.size;
    }
    
    foreach ( var_6f3ceb1f, ai in var_758b7f39 )
    {
        if ( !isalive( ai ) || isvehicle( ai ) )
        {
            continue;
        }
        
        if ( isdefined( ai.script_noteworthy ) )
        {
            ent = getent( "e_" + ai.script_noteworthy, "targetname" );
            
            if ( isdefined( ent ) )
            {
                var_b0409175 = ent;
            }
            else
            {
                vol = getent( "vol_" + ai.script_noteworthy, "targetname" );
                
                if ( isdefined( vol ) )
                {
                    var_b0409175 = vol;
                }
                else
                {
                    node = getnode( "nd_" + ai.script_noteworthy, "targetname" );
                    
                    if ( isdefined( node ) )
                    {
                        var_b0409175 = node;
                    }
                    else
                    {
                        struct = struct::get( "s_" + ai.script_noteworthy, "targetname" );
                        
                        if ( isdefined( struct ) )
                        {
                            var_b0409175 = struct;
                        }
                    }
                }
            }
        }
        
        if ( isdefined( var_b0409175 ) || isdefined( var_69747751 ) )
        {
            if ( isdefined( var_b0409175 ) )
            {
                ai setgoal( var_b0409175, var_2385fea0 );
                ai ai::function_54115a91( var_b0409175 );
                goal = var_b0409175;
            }
            else
            {
                goal = ai ai::set_goal( var_69747751, "targetname", var_2385fea0 );
            }
            
            if ( var_2385fea0 == 1 )
            {
                if ( isstruct( goal ) )
                {
                    goal = goal.origin;
                }
                
                ai ai::force_goal( goal, 1, undefined, 1, 1 );
            }
        }
        else
        {
            ai setgoal( level.player, var_2385fea0, 512 );
            ai ai::function_620eeb6b( level.player );
        }
        
        if ( var_6f3ceb1f > var_ca838126 )
        {
            break;
        }
        
        if ( var_1140c6d6 == 1 )
        {
            wait randomfloatrange( 0.5, 1.5 );
        }
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0x11edb762, Offset: 0x3d60
// Size: 0x1c2
function function_c753545e( var_2963bf2f, _gen_zipline_traversal = 1 )
{
    level endon( #"hash_1f3f93cdb790bdca" );
    level.player endon( #"death" );
    function_1eaaceab( var_2963bf2f );
    
    if ( var_2963bf2f.size <= 0 )
    {
        return;
    }
    
    foreach ( ai in var_2963bf2f )
    {
        ai.var_38754eac = level.player.origin;
    }
    
    for ( var_41db60bc = 0; var_41db60bc < _gen_zipline_traversal ; var_41db60bc++ )
    {
        array::wait_any( var_2963bf2f, "grenade_fire" );
    }
    
    function_1eaaceab( var_2963bf2f );
    
    foreach ( ai in var_2963bf2f )
    {
        ai.var_38754eac = undefined;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0x9e39190f, Offset: 0x3f30
// Size: 0x8c
function function_a7c9ed68( goal, var_695263e8 = 0 )
{
    self endon( #"death" );
    self waittill( #"hash_542161c43bda2568" );
    
    if ( var_695263e8 == 1 )
    {
        self getenemyinfo( level.player );
    }
    
    self ai::force_goal( goal );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0x1c38c3d7, Offset: 0x3fc8
// Size: 0xd4
function function_fa5905d0( var_11019c24 )
{
    s_origin = struct::get( var_11019c24, "targetname" );
    v_fwd = anglestoforward( s_origin.angles );
    v_up = anglestoup( s_origin.angles );
    playfx( level._effect[ #"hash_a767caa536ae153" ], s_origin.origin, v_fwd, v_up );
    snd::client_msg( "flg_heli_rappel_alarm" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 7
// Checksum 0x4423b97a, Offset: 0x40a8
// Size: 0x300
function function_1c62d05e( var_b3a058ca, var_8d888516, var_290b108c = 1, n_min_delay = 3, n_max_delay = 6, var_3c0eec56 = 1, var_84e3f01 = undefined )
{
    a_spawners = getspawnerarray( var_b3a058ca, "targetname" );
    a_drones = [];
    current_spawner = undefined;
    last_spawner = undefined;
    
    while ( level flag::get( var_8d888516 ) == 0 )
    {
        if ( level flag::get( var_84e3f01 ) == 1 )
        {
            break;
        }
        
        current_spawner = array::random( a_spawners );
        
        if ( a_spawners.size > 1 && current_spawner === last_spawner )
        {
            waitframe( 1 );
            continue;
        }
        
        drone = spawner::simple_spawn_single( current_spawner, &function_6fd49fc6, var_290b108c );
        array::add( a_drones, drone );
        
        if ( isdefined( drone ) && isdefined( var_84e3f01 ) )
        {
            drone thread function_72e64c7b( var_84e3f01 );
        }
        
        wait randomfloatrange( n_min_delay, n_max_delay );
    }
    
    foreach ( spawner in a_spawners )
    {
        if ( isdefined( spawner ) )
        {
            spawner deletedelay();
        }
    }
    
    if ( var_3c0eec56 == 1 )
    {
        foreach ( drone in a_drones )
        {
            if ( isdefined( drone ) )
            {
                drone deletedelay();
            }
        }
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0xb82e08a8, Offset: 0x43b0
// Size: 0x8c
function function_72e64c7b( var_84e3f01 )
{
    level endon( var_84e3f01 );
    self endon( #"death" );
    waitresult = self waittill( #"damage" );
    attacker = waitresult.attacker;
    
    if ( attacker === level.player )
    {
        level flag::set( var_84e3f01 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0xb8caadcd, Offset: 0x4448
// Size: 0xdc
function function_6fd49fc6( var_290b108c = 1 )
{
    self endon( #"death" );
    self val::set( #"hash_608ec07467e56d9c", "ignoreme", 1 );
    self val::set( #"hash_608ec07467e56d9c", "ignoreall", 1 );
    
    if ( var_290b108c == 1 )
    {
        self namespace_4e75a347::function_cab4b520( "alert" );
    }
    
    self waittill( #"goal" );
    self deletedelay();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 6
// Checksum 0x3b89c3ff, Offset: 0x4530
// Size: 0x150
function function_594838c( var_ca230c69, flag_name, var_22da929b = 1, var_c652f333 = 0, str_fx = #"hash_1f520075c2af377e", var_39703059 = 0 )
{
    if ( isdefined( flag_name ) )
    {
        level flag::wait_till( flag_name );
        println( flag_name + "<dev string:x10f>" + var_ca230c69 );
    }
    
    vh_heli = vehicle::simple_spawn_single_and_drive( var_ca230c69 );
    vh_heli hms_util::function_150e9e66();
    
    if ( var_ca230c69 == "vh_forest_vig_heli_start_flyby" )
    {
        snd::function_9ae4fc6f( "tmp_veh_helicopter_flyby_med_fast", vh_heli );
    }
    
    if ( var_22da929b )
    {
        vh_heli thread function_b510a5de( var_c652f333, str_fx, var_39703059 );
    }
    
    return vh_heli;
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x1a47afb, Offset: 0x4688
// Size: 0x1a4
function function_b510a5de( var_c652f333 = 1, str_fx = #"hash_1f520075c2af377e", var_39703059 = 0 )
{
    if ( var_39703059 )
    {
        self flag::set( #"hash_2162416b46fca89a" );
    }
    
    light_origin = self gettagorigin( "tag_searchlight_fx" );
    light_angles = self gettagangles( "tag_searchlight_fx" ) + ( 90, 0, 0 );
    m_fx = util::spawn_model( "tag_origin", light_origin, light_angles );
    m_fx linkto( self, "tag_searchlight_fx" );
    playfxontag( fx::get( str_fx ), m_fx, "tag_origin" );
    m_fx thread function_cc95cb46( self, var_c652f333 );
    self waittill( #"death", #"hash_63fe58da4b00d989" );
    m_fx deletedelay();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x2378df92, Offset: 0x4838
// Size: 0x24
function function_621fafb2()
{
    self flag::clear( #"hash_2162416b46fca89a" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2, eflags: 0x4
// Checksum 0x1e8c2c61, Offset: 0x4868
// Size: 0x4a2
function private function_cc95cb46( vh_heli, var_c652f333 )
{
    self endon( #"death" );
    var_7129bbde = self.angles;
    self rotateto( var_7129bbde, 0.1 );
    
    if ( var_c652f333 == 1 )
    {
        return;
    }
    
    var_6b87488d = gettime();
    var_75bbc132 = 0.2;
    var_af1ba7ee = 0;
    var_bc7ea8c = vh_heli.health;
    var_12d524f0 = struct::get_array( "s_heli_look_at_point", "targetname" );
    var_1917b15f = undefined;
    var_6dffb3ad = undefined;
    
    while ( true )
    {
        var_1917b15f = arraygetclosest( self.origin, var_12d524f0, 1500 );
        
        if ( isdefined( var_1917b15f ) && gettime() - var_6b87488d > var_75bbc132 )
        {
            if ( var_1917b15f === var_6dffb3ad )
            {
                var_75bbc132 = 0.2 * 1000;
            }
            else
            {
                var_75bbc132 = 0.2 * 3000;
            }
            
            var_61d3598c = vectornormalize( var_1917b15f.origin - self.origin );
            var_29d5113a = vectortoangles( var_61d3598c );
            self rotateto( var_29d5113a, var_75bbc132 );
            var_6dffb3ad = var_1917b15f;
            var_6b87488d = gettime();
        }
        else if ( gettime() - var_6b87488d > 3000 )
        {
            var_647d3a14 = randomintrange( -1 * 60, 60 );
            random_yaw = randomintrange( -1 * 60, 60 );
            random_angle = var_7129bbde + ( var_647d3a14, random_yaw, 0 );
            random_time = randomfloatrange( 1, 1 * 2 );
            self rotateto( random_angle, random_time );
            var_6b87488d = gettime();
        }
        
        if ( isalive( level.player ) && isdefined( var_61d3598c ) )
        {
            v_player_pos = level.player getplayercamerapos();
            var_b7f6eb31 = vectornormalize( v_player_pos - self.origin );
            var_aa19e187 = distance2dsquared( v_player_pos, self.origin );
            
            if ( vh_heli flag::get( #"hash_2162416b46fca89a" ) )
            {
                if ( var_bc7ea8c > vh_heli.health )
                {
                    var_af1ba7ee++;
                    
                    if ( var_af1ba7ee >= 1 )
                    {
                        level flag::set( "flg_vig_heli_attacked" );
                        self function_c163ea10( vh_heli );
                        var_bc7ea8c = vh_heli.health;
                    }
                }
                else if ( var_aa19e187 < 4000000 && vh_heli function_bec6c171( v_player_pos ) )
                {
                    var_af1ba7ee++;
                    
                    if ( var_af1ba7ee >= 1 )
                    {
                        var_6bb207b7 = gettime() - var_6b87488d;
                        self function_c163ea10( vh_heli );
                        var_6b87488d = gettime() - var_6bb207b7;
                    }
                }
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1, eflags: 0x4
// Checksum 0x81303903, Offset: 0x4d18
// Size: 0x23c
function private function_c2fdde27( vh_heli )
{
    var_7bed3696 = 8000 * 0.001 * 0.0625;
    var_b7f6eb31 = undefined;
    var_5334d4d1 = gettime();
    var_7aba1a2f = 0;
    var_13e2baa2 = 0;
    vh_heli setspeed( 10, 5, 5 );
    
    while ( gettime() - var_5334d4d1 <= 8000 )
    {
        v_player_pos = level.player getplayercamerapos();
        var_b7f6eb31 = vectornormalize( v_player_pos - self.origin );
        var_29d5113a = vectortoangles( var_b7f6eb31 );
        self function_d384d0b3( var_7bed3696 );
        
        if ( !vh_heli function_bec6c171( v_player_pos ) )
        {
            var_13e2baa2 += var_7bed3696;
            
            if ( var_13e2baa2 >= 4 )
            {
                var_7aba1a2f = 1;
                break;
            }
        }
        
        wait var_7bed3696;
    }
    
    if ( !var_7aba1a2f )
    {
        v_player_pos = level.player getplayercamerapos();
        var_8ebb97d4 = vectornormalize( v_player_pos - self.origin );
        var_f38bb4f3 = vectordot( var_b7f6eb31, var_8ebb97d4 );
        
        if ( var_f38bb4f3 > 0.95 && vh_heli function_bec6c171( v_player_pos ) )
        {
            self function_c163ea10( vh_heli );
        }
    }
    
    vh_heli resumespeed( 100 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1, eflags: 0x4
// Checksum 0x70bdd43a, Offset: 0x4f60
// Size: 0x8c
function private function_d384d0b3( var_20995ecd )
{
    var_b7f6eb31 = vectornormalize( level.player getplayercamerapos() - self.origin );
    var_29d5113a = vectortoangles( var_b7f6eb31 );
    self rotateto( var_29d5113a, var_20995ecd );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1, eflags: 0x4
// Checksum 0xfe912cee, Offset: 0x4ff8
// Size: 0x24c
function private function_c163ea10( vh_heli )
{
    level.player endon( #"death" );
    var_ee8c7f3 = 25;
    var_203a2093 = 0;
    level.var_85b00b2b = #"hash_4fa39beaac8ad1d0";
    level.var_30eb363 = #"hash_2d80edd53253ecf1";
    level flag::set( "flg_vig_heli_shooting_player" );
    doors::function_f35467ac( "e_lockpick_door" );
    self rotateto( self.angles, float( function_60d95f53() ) / 1000 );
    self function_d384d0b3( 0.75 );
    wait 0.75;
    var_5334d4d1 = gettime();
    
    while ( true )
    {
        self function_d384d0b3( 0.1 );
        
        if ( gettime() - var_5334d4d1 > 1000 )
        {
            if ( !var_203a2093 )
            {
                var_203a2093 = 1;
                vh_heli util::delay( 2, undefined, &function_c6dc514e );
            }
            
            v_offset = var_ee8c7f3 == 0 ? ( 0, 0, 0 ) : math::random_vector( var_ee8c7f3 );
            var_a6be6a4f = level.player getplayercamerapos() + v_offset;
            vh_heli function_a8c8444c( var_a6be6a4f );
            var_ee8c7f3 = max( 0, var_ee8c7f3 - 4 );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1, eflags: 0x4
// Checksum 0x42ec1232, Offset: 0x5250
// Size: 0xdc
function private function_a8c8444c( var_a6be6a4f )
{
    if ( self function_bec6c171( var_a6be6a4f ) )
    {
        var_9012c9b0 = getweapon( #"hash_161ca1bfb05ce95c" );
        var_1c8839e = self gettagorigin( "tag_gunner_flash1" );
        playfxontag( level._effect[ #"hash_7fa91cf654f23aa0" ], self, "tag_gunner_flash1" );
        magicbullet( var_9012c9b0, var_1c8839e, var_a6be6a4f );
        wait 0.05;
        magicbullet( var_9012c9b0, var_1c8839e, var_a6be6a4f );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0x35c81d3b, Offset: 0x5338
// Size: 0x1d4
function private function_c6dc514e()
{
    if ( !isalive( level.player ) )
    {
        return;
    }
    
    level.player endon( #"death" );
    var_9012c9b0 = getweapon( #"hash_161ca1bfb05ce95c" );
    v_player_pos = level.player getplayercamerapos();
    var_1c8839e = v_player_pos + ( 0, 0, 16 );
    
    if ( level.player flag::get( "takedown_active" ) )
    {
        level.player flag::wait_till_clear( "takedown_active" );
    }
    
    if ( !self function_bec6c171( v_player_pos ) )
    {
        level thread namespace_4bd68414::function_d4e6ea3d();
        level lui::screen_fade_out( 0.5, "black" );
    }
    else
    {
        playfxontag( level._effect[ #"hash_7fa91cf654f23aa0" ], self, "tag_searchlight_fx" );
        magicbullet( var_9012c9b0, var_1c8839e, v_player_pos );
    }
    
    level.player util::stop_magic_bullet_shield();
    level.player disableinvulnerability();
    level.player kill();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1, eflags: 0x4
// Checksum 0x8b216afc, Offset: 0x5518
// Size: 0x8c
function private function_bec6c171( v_player_pos )
{
    if ( level.player function_bcdd0822( "vol_side_door_hidden" ) )
    {
        return 0;
    }
    
    var_f1e2d68b = self gettagorigin( "tag_searchlight_fx" ) + ( 0, 0, 10 );
    return sighttracepassed( var_f1e2d68b, v_player_pos, 0, undefined );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 4
// Checksum 0xe4e15754, Offset: 0x55b0
// Size: 0x15c
function function_ffc69c66( var_ca230c69, var_4ecfd1cd, var_8e56e9f0, var_1ccb6295 = 1 )
{
    if ( isdefined( var_4ecfd1cd ) )
    {
        flag::wait_till( var_4ecfd1cd );
        println( var_4ecfd1cd + "<dev string:x134>" + var_ca230c69 );
    }
    
    var_a21e5c7c = vehicle::simple_spawn_and_drive( var_ca230c69 );
    
    if ( var_1ccb6295 )
    {
        foreach ( var_ff72be84 in var_a21e5c7c )
        {
            var_ff72be84 thread function_6fdf0945();
        }
    }
    
    if ( isdefined( var_8e56e9f0 ) )
    {
        flag::wait_till( var_8e56e9f0 );
        array::delete_all( var_a21e5c7c );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0x906ce077, Offset: 0x5718
// Size: 0x104
function function_6fdf0945( var_332f16b5 = 0 )
{
    self endon( #"death" );
    self thread vehicle::lights_on();
    self thread vehicle::toggle_tread_fx( 1 );
    
    if ( var_332f16b5 == 1 )
    {
        self.exhaustfxtag1 = #"tag_fx_exhaust_left";
        self.exhaustfxname = #"hash_4bfe81be0f573831";
        self.exhaust_fx = level._effect[ self.exhaustfxname ];
        waitframe( 1 );
        self thread vehicle::toggle_exhaust_fx( 1 );
        self thread vehicle::toggle_sounds( 1 );
        self thread function_975f3452();
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0xbf8a7254, Offset: 0x5828
// Size: 0xd8
function function_975f3452()
{
    self endon( #"death" );
    var_f4a05f17 = 0;
    
    while ( true )
    {
        mph = self getspeedmph();
        
        if ( var_f4a05f17 == 0 && mph <= 5 )
        {
            self vehicle::toggle_force_driver_taillights( 1 );
            var_f4a05f17 = 1;
        }
        
        if ( var_f4a05f17 == 1 && mph > 5 )
        {
            self vehicle::toggle_force_driver_taillights( 0 );
            var_f4a05f17 = 0;
        }
        
        wait 0.2;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x26db6f1e, Offset: 0x5908
// Size: 0x1d4
function function_3e1ec1b6( flag_name, var_58470915, n_time = 5 )
{
    flag::wait_till( flag_name );
    println( flag_name + "<dev string:x15c>" + var_58470915 );
    s_start = struct::get( var_58470915, "targetname" );
    s_end = struct::get( s_start.target, "targetname" );
    var_96a2f546 = util::spawn_model( "tag_origin", s_start.origin );
    var_96a2f546.angles = s_start.angles;
    var_59c586ad = var_96a2f546 fx::play( "maps/cp_rus_amerika/fx9_amerika_lgt_heli_vista", var_96a2f546.origin, var_96a2f546.angles, undefined, 1, "tag_origin" );
    var_96a2f546 moveto( s_end.origin, n_time, 0.1, 0.1 );
    var_96a2f546 rotateto( s_end.angles, n_time, 0.1, 0.1 );
    wait n_time;
    var_59c586ad deletedelay();
    var_96a2f546 deletedelay();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 4
// Checksum 0x5c95316e, Offset: 0x5ae8
// Size: 0xde
function function_8a263f80( n_move_x, var_a6fa9fe7, var_26cb1f8e, n_move_time )
{
    self endon( #"damage" );
    
    while ( true )
    {
        self moveto( self.origin - ( n_move_x, var_a6fa9fe7, var_26cb1f8e ), n_move_time, 0.25, 0.25 );
        wait 2;
        self moveto( self.origin + ( n_move_x, var_a6fa9fe7, var_26cb1f8e ), n_move_time, 0.25, 0.25 );
        wait 2;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0x59b94220, Offset: 0x5bd0
// Size: 0x24
function function_e9f3f20( var_77bf059 )
{
    self flag::set( var_77bf059 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0x15849700, Offset: 0x5c00
// Size: 0x24
function function_cafa23ec( var_77bf059 )
{
    self flag::clear( var_77bf059 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x98a33344, Offset: 0x5c30
// Size: 0xdc
function function_634f458e()
{
    self endon( #"death" );
    
    while ( self getspeedmph() > 5 )
    {
        var_99352089 = int( self getspeedmph() * 0.25 );
        n_accel = var_99352089 * 0.5;
        var_99997505 = n_accel * 0.5;
        self setspeed( var_99352089, n_accel, var_99997505 );
        wait 0.1;
    }
    
    self vehicle::pause_path();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0x6af9e1cb, Offset: 0x5d18
// Size: 0x404
function elevator_descend( var_a911450f = 0 )
{
    var_d5535d9a = getvehiclearray( "control_tower_elevator", "targetname" )[ 0 ];
    var_ae07a10a = getentarray( "e_elevator_floor_clip", "targetname" );
    
    foreach ( clip in var_ae07a10a )
    {
        clip linkto( var_d5535d9a );
    }
    
    var_a6d70f94 = getentarray( "elevator_player_clip", "targetname" );
    
    foreach ( clip in var_a6d70f94 )
    {
        clip linkto( var_d5535d9a );
        clip hide();
    }
    
    var_d5535d9a setmovingplatformenabled( 1, 1, 1 );
    
    if ( var_a911450f == 0 )
    {
        snd::client_targetname( var_d5535d9a, "evt_tower_elevator_audio" );
        var_d5535d9a vehicle::get_on_and_go_path( "nd_elevator_down_path_start" );
    }
    else
    {
        var_d5535d9a vehicle::get_on_path( "nd_elevator_up_path_start" );
    }
    
    var_f59c7284 = getnodearray( "control_tower_floor1_node", "targetname" );
    
    foreach ( var_27fe3e2a in var_f59c7284 )
    {
        linktraversal( var_27fe3e2a );
    }
    
    var_6a55bccc = getnodearray( "nd_control_tower_elevator", "targetname" );
    
    foreach ( elevator_node in var_6a55bccc )
    {
        setenablenode( elevator_node, 0 );
    }
    
    if ( var_a911450f == 0 )
    {
        level flag::wait_till( "flg_main_street_elevator_reached_ground" );
        snd::client_msg( "flg_main_street_elevator_reached_ground" );
        return;
    }
    
    level flag::set( "flg_main_street_elevator_reached_ground" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x997f57de, Offset: 0x6128
// Size: 0x454
function function_bd7f6a68()
{
    level.player endon( #"death" );
    
    if ( level flag::get( "flg_elevator_ready" ) == 1 )
    {
        return;
    }
    
    var_d5535d9a = getvehiclearray( "control_tower_elevator", "targetname" )[ 0 ];
    var_d5535d9a setmovingplatformenabled( 1, 1, 1 );
    var_f59c7284 = getnodearray( "control_tower_floor1_node", "targetname" );
    
    foreach ( var_27fe3e2a in var_f59c7284 )
    {
        linktraversal( var_27fe3e2a );
    }
    
    level flag::set( "flg_elevator_ready" );
    s_obj_elevator_interact = struct::get( "s_obj_elevator_interact", "targetname" );
    s_obj_elevator_interact util::create_cursor_hint( undefined, undefined, #"hash_4c2e469acdab8219" );
    s_obj_elevator_interact waittill( #"trigger" );
    level flag::set( "flg_elevator_player_interact" );
    level.player playgestureviewmodel( #"ges_drophand" );
    s_obj_elevator_interact util::delay( 0.2, undefined, &util::remove_cursor_hint );
    
    foreach ( var_27fe3e2a in var_f59c7284 )
    {
        unlinktraversal( var_27fe3e2a );
    }
    
    var_a6d70f94 = getentarray( "elevator_player_clip", "targetname" );
    level array::run_all( var_a6d70f94, &show );
    level flag::wait_till( "flg_control_tower_woods_on_elevator" );
    snd::client_targetname( var_d5535d9a, "evt_tower_elevator_up_audio" );
    var_d5535d9a vehicle::get_on_and_go_path( "nd_elevator_up_path_start" );
    var_d5535d9a setspeed( 0 );
    level array::run_all( var_a6d70f94, &hide );
    var_b4dcc445 = getnode( "control_tower_floor2_node", "targetname" );
    linktraversal( var_b4dcc445 );
    level flag::wait_till( "flg_terminal_end" );
    wait 1;
    var_d5535d9a delete();
    level array::run_all( var_a6d70f94, &delete );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0xc730ae9b, Offset: 0x6588
// Size: 0xdc
function function_f87024e0( var_a77bb7f1, var_a5a6c25b = "suspend" )
{
    if ( !isdefined( level.vh_town_square_apc ) )
    {
        level.vh_town_square_apc = hms_util::function_a3bb1e9c( "vh_town_square_apc", var_a5a6c25b, 0 );
        level.vh_town_square_apc thread hms_util::function_7b8ccc06();
        level.vh_town_square_apc thread hms_util::function_ca8302de();
    }
    
    if ( isdefined( var_a77bb7f1 ) )
    {
        var_24782345 = getvehiclenode( var_a77bb7f1, "targetname" );
        level.vh_town_square_apc thread vehicle::get_on_and_go_path( var_24782345 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0x5fdaa571, Offset: 0x6670
// Size: 0x170
function function_a57ce26d( a_targets, str_endon )
{
    self endon( str_endon, #"death" );
    var_e3dd3903 = getweapon( #"hash_161ca1bfb05ce95c" );
    
    foreach ( target in a_targets )
    {
        self waittill( #"gunner_weapon_fired" );
        waitframe( 1 );
        v_pos = target.origin;
        var_53edfe53 = target.script_noteworthy;
        self thread hms_util::function_cef95010( v_pos, var_53edfe53 );
        radiusdamage( v_pos, 32, 100, 1, level.player, "MOD_PROJECTILE_SPLASH", var_e3dd3903 );
        physicsexplosionsphere( v_pos, 32, 1, 1 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0x19a3dafd, Offset: 0x67e8
// Size: 0x1ec
function function_649019cf( var_7928fb3d )
{
    level endon( var_7928fb3d );
    var_6bf552b5 = sqr( 400 );
    
    if ( isdefined( self.radius ) )
    {
        var_6bf552b5 = self.radius * self.radius;
    }
    
    var_59646c64 = var_6bf552b5 * 0.5;
    
    while ( level flag::get( var_7928fb3d ) == 0 )
    {
        if ( isdefined( level.vh_town_square_apc.var_df85ad4e ) && ( level.vh_town_square_apc.var_df85ad4e == "suspend" || level.vh_town_square_apc.var_df85ad4e == "scripted" ) )
        {
            wait 0.1;
            continue;
        }
        
        var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), self.origin, 0.707107 );
        var_aa19e187 = distance2dsquared( level.player.origin, self.origin );
        
        if ( var_aa19e187 < var_59646c64 || var_aa19e187 < var_6bf552b5 && var_e88b5bd1 == 1 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    level.vh_town_square_apc hms_util::function_b5da96ca( self.origin, undefined, 1, self.script_noteworthy );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0xcb50e9f8, Offset: 0x69e0
// Size: 0x474
function function_61774174( var_7928fb3d )
{
    level.player endon( #"death" );
    level.vh_town_square_apc endon( #"death" );
    level flag::set_val( "flg_courtyard_player_slow", 0 );
    var_56cc9db7 = level.player.origin;
    var_843c2e0a = 0;
    var_7b307e50 = 10;
    n_check_time = 5000;
    var_7c67fe3a = undefined;
    var_6ec9f349 = 999999;
    
    switch ( level.gameskill )
    {
        case 0:
            n_check_time = 7500;
            break;
        case 1:
            n_check_time = 6000;
            break;
        case 2:
            n_check_time = 4500;
            break;
        case 3:
            n_check_time = 3000;
            break;
        default:
            n_check_time = 6000;
            break;
    }
    
    while ( level flag::get( var_7928fb3d ) == 0 )
    {
        if ( isdefined( level.vh_town_square_apc.var_df85ad4e ) && ( level.vh_town_square_apc.var_df85ad4e == "suspend" || level.vh_town_square_apc.var_df85ad4e == "scripted" ) )
        {
            var_7c67fe3a = undefined;
            var_6ec9f349 = 999999;
            var_843c2e0a = 0;
            wait 0.1;
            continue;
        }
        
        var_ab436758 = level.player.origin;
        var_d2d03842 = distance2dsquared( var_ab436758, var_56cc9db7 );
        var_20955b61 = level.vh_town_square_apc turret::can_hit_target( level.player, 0 );
        
        if ( var_20955b61 == 0 && var_843c2e0a == 1 )
        {
            if ( isdefined( var_7c67fe3a ) )
            {
                var_7c67fe3a = undefined;
                var_6ec9f349 = 999999;
            }
            
            var_d2d03842 = 999999;
            var_843c2e0a = 0;
        }
        
        if ( var_d2d03842 <= sqr( var_7b307e50 ) && var_843c2e0a == 0 )
        {
            if ( !isdefined( var_7c67fe3a ) )
            {
                var_7c67fe3a = gettime();
            }
            
            var_6ec9f349 = n_check_time - gettime() - var_7c67fe3a;
            
            if ( var_6ec9f349 <= 0 )
            {
                level.vh_town_square_apc hms_util::function_c21ef1d8( "kill_player" );
                level flag::set_val( "flg_courtyard_player_slow", 1 );
                var_843c2e0a = 1;
            }
        }
        
        if ( var_d2d03842 > sqr( var_7b307e50 ) && var_843c2e0a == 1 )
        {
            if ( isdefined( var_7c67fe3a ) )
            {
                var_7c67fe3a = undefined;
                var_6ec9f349 = 999999;
            }
            
            level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_player" );
            level flag::set_val( "flg_courtyard_player_slow", 0 );
            var_843c2e0a = 0;
        }
        
        var_56cc9db7 = var_ab436758;
        wait 0.1;
    }
    
    level flag::set_val( "flg_courtyard_player_slow", 0 );
    
    if ( isdefined( level.vh_town_square_apc.var_df85ad4e ) && level.vh_town_square_apc.var_df85ad4e == "kill_player" )
    {
        level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_player" );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1
// Checksum 0x57f6a81, Offset: 0x6e60
// Size: 0x20c
function function_7c1777d1( var_7928fb3d )
{
    level endon( var_7928fb3d );
    level.player endon( #"death" );
    var_6bf552b5 = 9216;
    
    if ( isdefined( self.radius ) )
    {
        var_6bf552b5 = self.radius * self.radius;
    }
    
    var_59646c64 = var_6bf552b5 * 0.5;
    var_f629e9ea = undefined;
    
    while ( level flag::get( var_7928fb3d ) == 0 )
    {
        var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), self.origin, 0.707107 );
        var_aa19e187 = distance2dsquared( level.player.origin, self.origin );
        
        if ( var_aa19e187 < var_59646c64 || var_aa19e187 < var_6bf552b5 && var_e88b5bd1 == 1 )
        {
            var_f629e9ea = self function_57924c81();
            
            if ( isdefined( var_f629e9ea ) )
            {
                break;
            }
        }
        
        wait 0.1;
    }
    
    e_target = spawn( "script_model", self.origin );
    var_f629e9ea ai::shoot_at_target( "normal", e_target, "tag_origin", 1, 10 );
    wait 2;
    e_target delete();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0xccb88078, Offset: 0x7078
// Size: 0xf2
function function_57924c81()
{
    a_ai_enemies = getaiteamarray( "axis" );
    a_ai_enemies = arraysortclosest( a_ai_enemies, level.player getplayercamerapos(), undefined, 256 );
    
    foreach ( ai in a_ai_enemies )
    {
        if ( ai canshoot( self.origin ) )
        {
            return ai;
        }
    }
    
    return undefined;
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0x442ee2dc, Offset: 0x7178
// Size: 0x304
function function_f35ed3bb( var_c90e28bf, var_8fe28ab0 = 1 )
{
    if ( var_8fe28ab0 == 1 )
    {
        self endon( #"death" );
    }
    
    if ( isdefined( var_c90e28bf ) )
    {
        current_node = getvehiclenode( var_c90e28bf, "targetname" );
    }
    else
    {
        current_node = getvehiclenode( self.target, "targetname" );
    }
    
    self.origin = current_node.origin;
    self.angles = current_node.angles;
    var_1f7031e0 = spawn( "script_origin", self.origin );
    var_1f7031e0.angles = self.angles;
    self linkto( var_1f7031e0 );
    self notify( #"hash_1b298f3e92789f25" );
    println( "<dev string:x188>" );
    move_time = 5;
    
    while ( true )
    {
        if ( isdefined( current_node.target ) )
        {
            next_node = getvehiclenode( current_node.target, "targetname" );
        }
        else
        {
            break;
        }
        
        var_936ddb6c = distance2d( current_node.origin, next_node.origin );
        move_time = var_936ddb6c / next_node.speed;
        var_1f7031e0 moveto( next_node.origin, move_time, 0, 0 );
        var_1f7031e0 rotateto( next_node.angles, move_time, 0, 0 );
        wait move_time;
        
        if ( isdefined( self ) )
        {
            self notify( #"hash_4909aa116e2fe105" );
        }
        
        if ( isdefined( next_node.script_flag_set ) )
        {
            level flag::set( next_node.script_flag_set );
        }
        
        if ( isdefined( next_node.script_delay ) )
        {
            wait next_node.script_delay;
        }
        
        if ( isdefined( next_node.script_flag_wait ) )
        {
            level flag::wait_till( next_node.script_flag_wait );
        }
        
        current_node = next_node;
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_62cbb91ba73d1bbc" );
    }
    
    println( "<dev string:x19b>" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0xa62a2d9d, Offset: 0x7488
// Size: 0x16c
function function_a9674e4a( n_accuracy = 100, n_health = 10 )
{
    self endon( #"death" );
    level.player endon( #"death" );
    level.vh_escape_apc endon( #"death" );
    self.health = n_health;
    self.grenadeammo = 0;
    level flag::wait_till( "all_players_spawned" );
    self.script_accuracy = n_accuracy;
    self thread function_8065702();
    
    if ( isdefined( level.vh_escape_apc ) && level flag::get( "flg_escape_player_in_apc" ) == 1 )
    {
        self ai::shoot_at_target( "shoot_until_target_dead", level.vh_escape_apc, undefined, undefined, undefined, 1 );
        return;
    }
    
    self ai::shoot_at_target( "shoot_until_target_dead", level.player, "j_head", undefined, undefined, 1 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x4045a8a4, Offset: 0x7600
// Size: 0x18a
function function_8065702()
{
    level endon( #"flg_apc_ride_end", #"flg_apc_ride_apc_destroyed" );
    self endon( #"death" );
    
    if ( self.var_c9174d59 === 1 )
    {
        return;
    }
    
    var_c6d90c31 = getweapon( #"frag_grenade" );
    var_a8f62552 = sqr( 64 );
    level flag::wait_till( "flg_apc_ride_town_square_start" );
    
    while ( true )
    {
        n_dist = distance2dsquared( self.origin, level.vh_escape_apc.var_dd39434b.origin );
        
        if ( n_dist < var_a8f62552 )
        {
            level thread function_7898ea4c( "light" );
            self dodamage( self.health + 1000, level.vh_escape_apc.origin, level.player, level.vh_escape_apc, "torso_upper", "MOD_IMPACT", 0, var_c6d90c31 );
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0xd8fdf20f, Offset: 0x7798
// Size: 0xec
function function_cdc5208b()
{
    level endon( #"flg_apc_ride_end", #"flg_apc_ride_apc_destroyed" );
    level.player endon( #"death" );
    self endon( #"death" );
    var_c6d90c31 = getweapon( #"frag_grenade" );
    self waittill( #"bulletwhizby" );
    self dodamage( self.health + 10, level.vh_escape_apc.origin, level.player, level.vh_escape_apc, "torso_upper", "MOD_PROJECTILE", 0, var_c6d90c31 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0x622d0b0d, Offset: 0x7890
// Size: 0x77a
function function_7898ea4c( var_61ad3e0, n_delay )
{
    if ( !isdefined( level.player ) )
    {
        return;
    }
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    switch ( var_61ad3e0 )
    {
        case #"start":
            level.player playrumbleonentity( "damage_light" );
            screenshake( level.player.origin, 0.5, 0.2, 0.2, 4, 0.5, 3, 0, 20, 10, 10, 2 );
            break;
        case #"light":
            earthquake( 0.3, 0.3, level.player.origin, 200 );
            break;
        case #"medium":
            level.player playrumbleonentity( "damage_light" );
            screenshake( level.player.origin, 1, 0.5, 0.5, 0.4, 0, 0.2, 0, 5, 2, 2, 2 );
            break;
        case #"heavy":
            level.player playrumbleonentity( "grenade_rumble" );
            screenshake( level.player.origin, 3, 1.5, 1.5, 0.7, 0, 0.5, 0, 4, 1, 1, 2 );
            level.player shellshock( #"default", 0.5 );
            a_ai_enemies = getaiteamarray( "axis" );
            
            if ( a_ai_enemies.size > 0 )
            {
                var_3ab20323 = getstatuseffect( #"hash_18a614e9da539cfc" );
                weapon = getweapon( #"frag_grenade" );
                level.player status_effect::status_effect_apply( var_3ab20323, weapon, a_ai_enemies[ 0 ], undefined, 1000 );
            }
            
            break;
        case #"crash1":
            level.player playrumbleonentity( "damage_heavy" );
            screenshake( level.player.origin, 8, 5, 5, 1, 0, 0.8, 0, 2, 0.5, 0.5, 2 );
            a_ai_enemies = getaiteamarray( "axis" );
            
            if ( a_ai_enemies.size > 0 )
            {
                var_a3aa55f = getstatuseffect( #"blurred" );
                var_3ab20323 = getstatuseffect( #"hash_18a614e9da539cfc" );
                var_711343eb = level.player getnormalhealth() * 0.8;
                level.player setnormalhealth( var_711343eb );
                weapon = getweapon( #"frag_grenade" );
                level.player status_effect::status_effect_apply( var_a3aa55f, weapon, a_ai_enemies[ 0 ], undefined, 1000 );
                level.player status_effect::status_effect_apply( var_3ab20323, weapon, a_ai_enemies[ 0 ], undefined, 1500 );
            }
            
            break;
        case #"crash2":
            level.player playrumbleonentity( "damage_heavy" );
            screenshake( level.player.origin, 12, 6, 6, 1.5, 0, 0.8, 0, 2, 0.5, 0.5, 2 );
            level.player playgestureviewmodel( #"hash_5723248289b2a00b" );
            a_ai_enemies = getaiteamarray( "axis" );
            
            if ( a_ai_enemies.size > 0 )
            {
                var_a3aa55f = getstatuseffect( #"hash_43002ea60b520663" );
                var_3ab20323 = getstatuseffect( #"explosive_damage" );
                var_711343eb = level.player getnormalhealth() * 0.6;
                level.player setnormalhealth( var_711343eb );
                weapon = getweapon( #"frag_grenade" );
                level.player status_effect::status_effect_apply( var_a3aa55f, weapon, a_ai_enemies[ 0 ], undefined, 1500 );
                level.player status_effect::status_effect_apply( var_3ab20323, weapon, a_ai_enemies[ 0 ], undefined, 2500 );
            }
            
            break;
        case #"uber":
            level.player playrumbleonentity( "damage_heavy" );
            earthquake( 1.5, 1.5, level.player.origin, 200 );
            level.player shellshock( #"pain", 1 );
            break;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x45b5a5d7, Offset: 0x8018
// Size: 0x168
function function_38b40877( v_org, n_radius = 600, n_delay )
{
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    a_ai_enemies = getaiteamarray( "axis" );
    a_ai_enemies = function_72d3bca6( a_ai_enemies, v_org, undefined, undefined, n_radius );
    var_c6d90c31 = getweapon( #"frag_grenade" );
    
    foreach ( ai_enemy in a_ai_enemies )
    {
        if ( isdefined( ai_enemy ) )
        {
            ai_enemy dodamage( ai_enemy.health + 1000, v_org, level.player, level.player, "torso_upper", "MOD_EXPLOSIVE", 0, var_c6d90c31 );
        }
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x9767bb02, Offset: 0x8188
// Size: 0x34
function function_a96c8ec0()
{
    level thread function_7741d5e0();
    level thread function_7fae969d();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0x912689b7, Offset: 0x81c8
// Size: 0x2c4
function private function_7741d5e0()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    var_e390015e = getentarray( "amk_moving_target", "targetname" );
    
    foreach ( var_a40461ff in var_e390015e )
    {
        assert( isdefined( var_a40461ff.target ) && isdefined( "<dev string:x1ac>" ) );
        var_540465ae = getent( var_a40461ff.target, "targetname" );
        var_a40461ff.base = var_540465ae;
        
        if ( !isdefined( level.var_ea773f78 ) )
        {
            level.var_ea773f78 = [];
        }
        else if ( !isarray( level.var_ea773f78 ) )
        {
            level.var_ea773f78 = array( level.var_ea773f78 );
        }
        
        level.var_ea773f78[ level.var_ea773f78.size ] = var_a40461ff;
        
        if ( !isdefined( level.var_ea773f78 ) )
        {
            level.var_ea773f78 = [];
        }
        else if ( !isarray( level.var_ea773f78 ) )
        {
            level.var_ea773f78 = array( level.var_ea773f78 );
        }
        
        level.var_ea773f78[ level.var_ea773f78.size ] = var_540465ae;
        var_a40461ff function_5f1cc91f( 1 );
        var_a40461ff enableobstacle( 1 );
        var_a40461ff thread function_e5f40709();
        var_a40461ff thread function_4ef22278( 1 );
        wait randomfloatrange( 0.25, 1 );
    }
    
    level flag::set( #"hash_7494f51e12978435" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0xcf06ffda, Offset: 0x8498
// Size: 0x39a
function private function_e5f40709()
{
    self endon( #"hash_36e5ad51c63fc1c" );
    
    if ( !isdefined( self.script_speed ) )
    {
        self.script_speed = 80;
    }
    
    var_835a71e = self.base function_745817b2();
    assert( var_835a71e.size > 1, "<dev string:x1e4>" );
    var_6517048f = distance2d( var_835a71e[ 0 ].origin, var_835a71e[ var_835a71e.size - 1 ].origin );
    assert( var_6517048f > 36, "<dev string:x235>" );
    n_move_time = var_6517048f / self.script_speed;
    
    if ( isdefined( self.var_f0979e33 ) && self.var_f0979e33 != 0 )
    {
        self rotateroll( -1 * self.var_f0979e33, 0.1 );
        wait 0.15;
    }
    
    if ( isdefined( self.script_flag_wait ) )
    {
        level flag::wait_till( self.script_flag_wait );
    }
    
    if ( isdefined( self.var_f0979e33 ) && self.var_f0979e33 != 0 )
    {
        self rotateroll( self.var_f0979e33, 0.2 );
        wait 0.25;
    }
    
    self linkto( self.base );
    
    while ( true )
    {
        foreach ( index, s_point in var_835a71e )
        {
            if ( index == 0 )
            {
                continue;
            }
            
            var_a439f3f8 = s_point.origin;
            var_2426881b = index == 1;
            var_8734b4ac = index == var_835a71e.size - 1;
            var_6a22734d = var_2426881b ? n_move_time * 0.2 : 0;
            var_8314bbf = var_8734b4ac ? n_move_time * 0.2 : 0;
            self.base moveto( var_a439f3f8, n_move_time, var_6a22734d, var_8314bbf );
            var_30da3c75 = snd::play( "amb_prop_moving_target_movement", self.base );
            wait n_move_time;
            snd::stop( var_30da3c75 );
            snd::play( "amb_prop_moving_target_stop", self.base );
        }
        
        var_835a71e = array::reverse( var_835a71e );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0xb1e334e2, Offset: 0x8840
// Size: 0xe6
function private function_745817b2()
{
    var_835a71e = [];
    var_dd580e2 = self.target;
    assert( isdefined( self.target ) && isdefined( "<dev string:x28c>" ) );
    
    while ( isdefined( var_dd580e2 ) )
    {
        var_372ed6d2 = struct::get( var_dd580e2, "targetname" );
        
        if ( !isdefined( var_835a71e ) )
        {
            var_835a71e = [];
        }
        else if ( !isarray( var_835a71e ) )
        {
            var_835a71e = array( var_835a71e );
        }
        
        var_835a71e[ var_835a71e.size ] = var_372ed6d2;
        var_dd580e2 = var_372ed6d2.target;
    }
    
    return var_835a71e;
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0xb8afdffc, Offset: 0x8930
// Size: 0x18c
function private function_7fae969d()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    var_8d236d2 = getentarray( "amk_spring_loaded_target", "targetname" );
    
    foreach ( var_92aa6fec in var_8d236d2 )
    {
        if ( !isdefined( level.var_ea773f78 ) )
        {
            level.var_ea773f78 = [];
        }
        else if ( !isarray( level.var_ea773f78 ) )
        {
            level.var_ea773f78 = array( level.var_ea773f78 );
        }
        
        level.var_ea773f78[ level.var_ea773f78.size ] = var_92aa6fec;
        var_92aa6fec thread function_4793fdc3();
        wait randomfloatrange( 0.25, 1 );
    }
    
    level flag::set( #"hash_300f70218a8afd26" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0, eflags: 0x4
// Checksum 0x9aa9000f, Offset: 0x8ac8
// Size: 0x140
function private function_4793fdc3()
{
    self endon( #"hash_36e5ad51c63fc1c" );
    
    if ( !isdefined( self.var_f0979e33 ) )
    {
        self.var_f0979e33 = 90;
    }
    
    var_316d0de0 = self.angles;
    self rotateroll( -1 * self.var_f0979e33, 0.1 );
    
    if ( isdefined( self.script_flag_wait ) )
    {
        level flag::wait_till( self.script_flag_wait );
    }
    
    if ( self.var_2ce4392f == -1 )
    {
        self function_4ef22278();
    }
    
    while ( self.var_2ce4392f != -1 )
    {
        self rotateto( var_316d0de0, 0.2 );
        self function_4ef22278();
        wait self.var_2ce4392f;
        self.var_77aff7ae = 0;
        self.var_1b7a5aa9 = undefined;
        self solid();
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 1, eflags: 0x4
// Checksum 0xfa4d80ab, Offset: 0x8c10
// Size: 0xc8
function private function_4ef22278( var_9eb20bae )
{
    self endon( #"hash_6673f13305b11f73" );
    
    while ( !is_true( self.var_77aff7ae ) )
    {
        var_be5da59d = self waittill( #"damage" );
        
        if ( is_true( var_9eb20bae ) )
        {
            self notify( #"hash_36e5ad51c63fc1c" );
        }
        
        self function_c7450333( var_9eb20bae, var_be5da59d );
        snd::play( "amb_prop_moving_target_impact", self );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2, eflags: 0x4
// Checksum 0x5feacf19, Offset: 0x8ce0
// Size: 0x3ca
function private function_c7450333( var_9eb20bae, var_be5da59d )
{
    var_7903b3a5 = 1;
    
    if ( is_true( var_9eb20bae ) )
    {
        self.base moveto( self.base.origin, 0.05, 0, 0 );
        self unlink();
    }
    
    if ( !isdefined( self.var_78a1032b ) )
    {
        self.var_78a1032b = 100;
    }
    
    if ( is_true( var_9eb20bae ) && isdefined( self.script_noteworthy ) )
    {
        var_3c34a87d = getent( self.script_noteworthy, "targetname" );
        assert( isdefined( var_3c34a87d ), "<dev string:x2bf>" + self.origin );
        
        if ( self istouching( var_3c34a87d ) )
        {
            self.var_78a1032b = 5;
        }
    }
    
    var_19b46146 = vectornormalize( anglestoright( self.angles ) );
    var_d44dbf88 = vectornormalize( self.origin - var_be5da59d.attacker.origin );
    dir = math::sign( vectordot( var_d44dbf88, var_19b46146 ) );
    var_5227df55 = dir < 0 ? -1 * self.var_78a1032b : self.var_4b38ad7d;
    var_8088c8f5 = math::clamp( abs( var_5227df55 ), 15, 80 );
    var_7903b3a5 = 0.5 + 0.5 * ( var_8088c8f5 - 15 ) * 0.01538;
    self.var_77aff7ae = abs( var_5227df55 ) > self.var_7da8e72f;
    
    if ( self.var_77aff7ae )
    {
        if ( isdefined( self.var_1b7a5aa9 ) )
        {
            self rotateroll( -1 * self.var_1b7a5aa9, 0.05 );
        }
        
        self rotateroll( var_5227df55, 0.32 * var_7903b3a5, 0.1 * var_7903b3a5, 0.2 * var_7903b3a5 );
        self notsolid();
        return;
    }
    
    if ( !self.var_77aff7ae && !isdefined( self.var_1b7a5aa9 ) )
    {
        self rotateroll( var_5227df55, 0.32 * var_7903b3a5, 0.1 * var_7903b3a5, 0.2 * var_7903b3a5 );
        self.var_1b7a5aa9 = var_5227df55;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0xdbf639d3, Offset: 0x90b8
// Size: 0xcc
function function_f7e2346()
{
    level flag::wait_till_all( [ #"hash_7494f51e12978435", #"hash_300f70218a8afd26" ] );
    
    if ( isdefined( level.var_ea773f78 ) )
    {
        array::notify_all( level.var_ea773f78, #"hash_36e5ad51c63fc1c" );
        array::notify_all( level.var_ea773f78, #"hash_6673f13305b11f73" );
        waitframe( 1 );
        array::delete_all( level.var_ea773f78 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 5
// Checksum 0x94483efb, Offset: 0x9190
// Size: 0x1e0
function function_2b932827( targetname, var_80363d0b = 20, var_ace731a8 = 30, var_7f3080e3 = 10, var_3d6ebd90 = 15 )
{
    var_35bfb86b = getent( targetname, "targetname" );
    start = struct::get( var_35bfb86b.target );
    end = struct::get( start.target );
    
    while ( true )
    {
        move_time = randomfloatrange( var_80363d0b, var_ace731a8 );
        var_35bfb86b moveto( start.origin, move_time, move_time * 0.5, move_time * 0.25 );
        wait_time = randomfloatrange( var_7f3080e3, var_3d6ebd90 );
        wait wait_time;
        move_time = randomfloatrange( var_80363d0b, var_ace731a8 );
        var_35bfb86b moveto( end.origin, move_time, move_time * 0.5, move_time * 0.25 );
        wait_time = randomfloatrange( var_7f3080e3, var_3d6ebd90 );
        wait wait_time;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0xb93f1b0c, Offset: 0x9378
// Size: 0x44
function function_56dd5180()
{
    level thread function_2b932827( "amerika_hanging_moving_machinery_2" );
    level thread function_2b932827( "amerika_hanging_moving_machinery_3" );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x6a93820e, Offset: 0x93c8
// Size: 0x32c
function function_869f213d()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    
    if ( level flag::get( "flg_control_tower_vig_scene_playing" ) == 1 )
    {
        return;
    }
    
    level flag::set( "flg_control_tower_vig_scene_playing" );
    s_scene_command_window_01 = struct::get( "s_scene_command_window_01", "targetname" );
    s_scene_command_window_02 = struct::get( "s_scene_command_window_02", "targetname" );
    s_scene_command_window_01 scene::init( "scene_amk_0000_command_window_02" );
    s_scene_command_window_02 scene::init( "scene_amk_0000_command_window_02" );
    s_scene_command_window_01 thread scene::play( "scene_amk_0000_command_window_01" );
    s_scene_command_window_02 thread scene::play( "scene_amk_0000_command_window_02" );
    level flag::wait_till( "flg_stop_corner_area_main_street_optional_spawns" );
    s_command_window_fov = struct::get( "s_command_window_fov", "targetname" );
    
    while ( level flag::get_any( [ "flg_elevator_fight_jugg_intro_complete", "flg_elevator_player_interact" ] ) == 0 )
    {
        var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), s_command_window_fov.origin, 0.95 );
        
        if ( var_e88b5bd1 == 1 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    s_scene_command_window_01 thread scene::play( "scene_amk_0000_command_window_01", "react" );
    s_scene_command_window_02 thread scene::play( "scene_amk_0000_command_window_02", "react" );
    waitframe( 1 );
    var_fbf05a7d = s_scene_command_window_01.scene_ents[ #"actor 1" ];
    var_23b6713 = s_scene_command_window_02.scene_ents[ #"actor 2" ];
    var_7e5397d0 = [ var_fbf05a7d, var_23b6713 ];
    array::thread_all( var_7e5397d0, &function_b79d77ed );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x510323d6, Offset: 0x9700
// Size: 0x84
function function_b79d77ed()
{
    self endon( #"death" );
    self function_aa5f0d6b();
    nd_command_window_goal = getnode( "nd_command_window_goal", "targetname" );
    self spawner::go_to_node( nd_command_window_goal );
    self deletedelay();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0xf4afbfad, Offset: 0x9790
// Size: 0xf6
function function_d6dd25df( color = ( 0, 1, 0 ), n_size = 8, v_sphere )
{
    self endon( #"death" );
    
    for ( ;; )
    {
        if ( isdefined( v_sphere ) )
        {
            v_pos = v_sphere;
        }
        else
        {
            v_pos = self gettagorigin( "tag_eye" );
            
            if ( !isdefined( v_pos ) )
            {
                v_pos = self.origin;
            }
            else
            {
                v_pos += ( 0, 0, 24 );
            }
        }
        
        /#
            sphere( v_pos, n_size, color, 1, 0, 10, 1 );
        #/
        
        waitframe( 1 );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 3
// Checksum 0x983170b4, Offset: 0x9890
// Size: 0x104
function function_6fe40e14( var_9d73e535, var_e4d8f3fe, var_da13de74 )
{
    var_8838c9ec = getent( var_9d73e535, "targetname" );
    var_2d81147e = getent( var_e4d8f3fe, "targetname" );
    var_3bb2b0e1 = getent( var_da13de74, "targetname" );
    var_def5cad3 = getent( "so_gun_racks", "targetname" );
    var_8838c9ec linkto( var_def5cad3 );
    var_2d81147e linkto( var_def5cad3 );
    var_3bb2b0e1 linkto( var_def5cad3 );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x5564bb81, Offset: 0x99a0
// Size: 0xb4
function function_55e17e75()
{
    self util::make_sentient();
    self setteam( #"axis" );
    self turretsetontargettolerance( 0, 2 );
    self turret::set_burst_parameters( 1, 2, 0.25, 0.5, 0 );
    self thread function_65e413d0();
    self thread function_67a0684a();
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0xcb8d0665, Offset: 0x9a60
// Size: 0x48
function function_67a0684a()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"has_new_target" );
        self thread function_7d7f8f59();
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x56268f2e, Offset: 0x9ab0
// Size: 0xb6
function function_7d7f8f59()
{
    self endon( #"death" );
    self notify( "16fd3552ade86100" );
    self endon( "16fd3552ade86100" );
    n_time = 0;
    self.script_accuracy = 0.2;
    
    while ( n_time < 2 )
    {
        wait 0.1;
        n_time += 0.1;
        n_lerp = n_time / 2;
        self.script_accuracy = lerpfloat( 0.2, 1, n_lerp );
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x47468c20, Offset: 0x9b70
// Size: 0x9c
function function_65e413d0()
{
    self endon( #"death" );
    
    /#
        if ( getdvarint( #"hash_7d07ba1da757787f", 0 ) > 0 )
        {
            self thread function_81e3ae7f();
        }
    #/
    
    while ( true )
    {
        var_8f5a96c3 = self function_1596d78c();
        wait var_8f5a96c3 ? 3 : 0.5;
    }
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 0
// Checksum 0x5ad7268c, Offset: 0x9c18
// Size: 0x188, Type: bool
function function_1596d78c()
{
    a_targets = getaiteamarray( #"allies" );
    
    if ( isdefined( level.player ) )
    {
        if ( !isdefined( a_targets ) )
        {
            a_targets = [];
        }
        else if ( !isarray( a_targets ) )
        {
            a_targets = array( a_targets );
        }
        
        a_targets[ a_targets.size ] = level.player;
    }
    
    a_targets = array::filter( a_targets, 0, &function_25a66d7d, self );
    a_targets = arraysort( a_targets, self.origin, 1, undefined, 3000 );
    var_ab2a8fcc = self turret::get_favorite_enemy();
    var_6721ae4f = undefined;
    
    if ( a_targets.size > 0 )
    {
        if ( array::contains( a_targets, level.player ) )
        {
            var_6721ae4f = level.player;
        }
        else
        {
            var_6721ae4f = a_targets[ 0 ];
        }
    }
    
    self turret::function_49c3b892( var_6721ae4f );
    
    if ( isdefined( var_6721ae4f ) && var_6721ae4f !== var_ab2a8fcc )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0xc5aa201e, Offset: 0x9da8
// Size: 0xaa
function function_25a66d7d( target, var_1280faf3 )
{
    v_start = var_1280faf3 gettagorigin( "tag_barrel" );
    
    if ( isplayer( target ) )
    {
        v_target = target getplayercamerapos();
    }
    else
    {
        v_target = target geteyeapprox();
    }
    
    return sighttracepassed( v_start, v_target, 0, var_1280faf3, target );
}

// Namespace namespace_fc3e8cb/namespace_30614c90
// Params 2
// Checksum 0x783ad050, Offset: 0x9e60
// Size: 0x106
function function_516b7ec( str_spawner, str_node )
{
    var_d93ed883 = getnode( str_node, "targetname" );
    var_1280faf3 = function_1a2a3760( var_d93ed883 );
    var_1280faf3 function_55e17e75();
    var_5deea171 = spawner::simple_spawn_single( str_spawner );
    var_5deea171 setgoal( var_d93ed883, 1, 64 );
    var_5deea171 val::set( #"turret_gunner", "ignoreme", 1 );
    var_5deea171.maxhealth = 125;
    var_5deea171.health = var_5deea171.maxhealth;
    return var_5deea171;
}

/#

    // Namespace namespace_fc3e8cb/namespace_30614c90
    // Params 0
    // Checksum 0x959942d3, Offset: 0x9f70
    // Size: 0x76, Type: dev
    function function_81e3ae7f()
    {
        self endon( #"death" );
        
        while ( true )
        {
            var_601d6bbd = self turret::get_favorite_enemy();
            
            if ( isdefined( var_601d6bbd ) )
            {
                line( self.origin, var_601d6bbd.origin, ( 1, 0, 0 ) );
            }
            
            waitframe( 1 );
        }
    }

#/
