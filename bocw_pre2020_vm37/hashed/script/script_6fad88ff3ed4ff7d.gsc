#using script_5c325a0a637fdc2e;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\struct;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\util;

#namespace namespace_b73b9191;

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 0
// Checksum 0x1a702d22, Offset: 0x2d0
// Size: 0x1dc
function function_2683ec5d()
{
    if ( isdefined( level.var_28c22d88[ 0 ] ) )
    {
        switch ( level.var_28c22d88[ 0 ] )
        {
            case #"excavation_finale":
            case #"mountain_summit":
            case #"intro_heli":
            case #"server_reveal":
            case #"server_ascent":
            case #"zipline_intro":
            case #"bunker_explore":
            case #"ice_slide":
            case #"satcom_approach":
            case #"bunker_encounter":
            case #"satcom":
            case #"catwalks":
            case #"woods_regroup":
            case #"zipline_fall":
            case #"excavation":
                var_5b7b93ad = getspawnerarray( "woods_ar", "script_noteworthy" );
                break;
            default:
                var_5b7b93ad = getspawnerarray( "woods_ar", "script_noteworthy" );
                break;
        }
    }
    
    var_5b7b93ad[ 0 ] spawner::add_spawn_function( &function_2341d661 );
    level.ai_woods = var_5b7b93ad[ 0 ] spawner::spawn( 1 );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 0
// Checksum 0xa33c9a5d, Offset: 0x4b8
// Size: 0xac
function function_2341d661()
{
    self.goalradius = 64;
    self val::set( #"woods", "allowdeath", 0 );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self.name = "Woods";
    self.propername = #"hash_22f2861ded3918a8";
    self.attackeraccuracy = 0.1;
    self function_d432b47b();
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 0
// Checksum 0xb5a13652, Offset: 0x570
// Size: 0x37a
function function_d432b47b()
{
    if ( isdefined( level.var_28c22d88[ 0 ] ) )
    {
        switch ( level.var_28c22d88[ 0 ] )
        {
            case #"mountain_summit":
            case #"intro_heli":
            case #"zipline_intro":
            case #"bunker_explore":
            case #"ice_slide":
            case #"satcom_approach":
            case #"bunker_encounter":
            case #"satcom":
            case #"catwalks":
            case #"zipline_fall":
                w_primary = getweapon( #"ar_standard_t9", "reflex", "suppressed2" );
                w_secondary = getweapon( #"pistol_semiauto_t9", "suppressed" );
                self aiutility::setcurrentweapon( w_primary );
                self aiutility::setprimaryweapon( w_primary );
                self aiutility::setsecondaryweapon( w_secondary );
                self shared::placeweaponon( w_primary, "right" );
                break;
            case #"excavation_finale":
            case #"server_reveal":
            case #"server_ascent":
            case #"woods_regroup":
            case #"excavation":
                w_primary = getweapon( #"ar_standard_t9", "reflex" );
                w_secondary = getweapon( #"pistol_semiauto_t9" );
                self aiutility::setcurrentweapon( w_primary );
                self aiutility::setprimaryweapon( w_primary );
                self aiutility::setsecondaryweapon( w_secondary );
                self shared::placeweaponon( w_primary, "right" );
                break;
            default:
                w_primary = getweapon( #"ar_standard_t9", "reflex" );
                w_secondary = getweapon( #"pistol_semiauto_t9" );
                self aiutility::setcurrentweapon( w_primary );
                self aiutility::setprimaryweapon( w_primary );
                self aiutility::setsecondaryweapon( w_secondary );
                self shared::placeweaponon( w_primary, "right" );
                break;
        }
    }
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 0
// Checksum 0x9cd4db5a, Offset: 0x8f8
// Size: 0x54
function function_48a0851a()
{
    self endon( #"death" );
    
    while ( level.player === undefined )
    {
        waitframe( 1 );
    }
    
    self setgoal( level.player );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 3
// Checksum 0x81572518, Offset: 0x958
// Size: 0x64
function function_5d981106( var_8be63fee, n_count, str_flag )
{
    spawner::waittill_ai_group_ai_count( var_8be63fee, n_count );
    
    if ( isalive( level.player ) )
    {
        level flag::set( str_flag );
    }
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 1
// Checksum 0x953a81e2, Offset: 0x9c8
// Size: 0x68
function function_e79ede39( flag )
{
    level.var_9c4a751d = 0;
    
    while ( !stealth_manager::anyone_in_combat() && !flag::get( flag ) )
    {
        wait 0.2;
    }
    
    level.var_9c4a751d = 1;
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 3
// Checksum 0x7a4210b0, Offset: 0xa38
// Size: 0x254
function function_54b7084f( var_e2454fa1, var_84669fca, var_55e78e1d )
{
    while ( !isdefined( level.player ) )
    {
        waitframe( 1 );
    }
    
    if ( isdefined( var_e2454fa1 ) )
    {
        level waittill( var_e2454fa1 );
    }
    else if ( isdefined( var_84669fca ) )
    {
        wait var_84669fca;
    }
    
    if ( isdefined( var_55e78e1d ) )
    {
        n_damage = floor( level.player.health * var_55e78e1d );
    }
    else
    {
        n_damage = floor( level.player.health * 0.8 );
    }
    
    level.player dodamage( n_damage, level.player.origin );
    waitframe( 1 );
    
    if ( n_damage > 50 )
    {
        level.player.var_4d9b2bc3 = 0;
        level.player val::set( #"zipline_fall", "allow_jump", 0 );
        level.player val::set( #"zipline_fall", "allow_sprint", 0 );
        level.player setmovespeedscale( 0.7 );
        
        while ( level.player.health < 100 )
        {
            waitframe( 1 );
        }
        
        level.player val::reset( #"zipline_fall", "allow_jump" );
        level.player val::reset( #"zipline_fall", "allow_sprint" );
        level.player setmovespeedscale( 1 );
    }
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 1
// Checksum 0x9cf98b3e, Offset: 0xc98
// Size: 0xa4
function function_608217cf( var_97c45fa7 )
{
    self ai::disable_pain();
    self ai::set_behavior_attribute( "vignette_mode", "fast" );
    level flag::wait_till( var_97c45fa7 );
    self ai::enable_pain();
    self ai::set_behavior_attribute( "vignette_mode", "off" );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 5
// Checksum 0x4bd3d015, Offset: 0xd48
// Size: 0x264
function function_5c5b6ea7( var_13a1bfd8, var_d6acc33, var_1da4b8f4 = 0, b_ignoreall = 0, var_c0116a7f = 0 )
{
    level.ai_woods notify( #"new_goal" );
    level.ai_woods endon( #"new_goal" );
    
    if ( var_1da4b8f4 == 1 )
    {
        level.ai_woods.script_forcegoal = 1;
    }
    
    if ( b_ignoreall == 1 )
    {
        level.ai_woods.ignoreall = 1;
    }
    
    if ( isdefined( var_13a1bfd8 ) && isdefined( var_d6acc33 ) )
    {
        if ( var_d6acc33 == "node" )
        {
            nd_start = getnode( var_13a1bfd8, "targetname" );
            
            if ( isdefined( level.ai_woods.script_force_color ) )
            {
                level.ai_woods colors::color_force_goal( nd_start );
            }
            else
            {
                level.ai_woods spawner::go_to_node( nd_start );
            }
        }
        else if ( var_d6acc33 == "struct" )
        {
            s_start = struct::get( var_13a1bfd8, "targetname" );
            level.ai_woods spawner::go_to_node( s_start, "struct" );
        }
    }
    
    if ( var_c0116a7f == 1 )
    {
        waitframe( 1 );
        level.ai_woods.goalradius = 32;
        level.ai_woods.script_radius = 32;
    }
    
    if ( b_ignoreall == 1 )
    {
        level.ai_woods.ignoreall = 0;
    }
    
    if ( var_1da4b8f4 == 1 )
    {
        level.ai_woods.script_forcegoal = 0;
        level.ai_woods clearforcedgoal();
    }
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 3
// Checksum 0x443cfacd, Offset: 0xfb8
// Size: 0x88
function function_f206e65e( var_b3a058ca, *var_83d281d, var_86a56d5f = 1 )
{
    heli = vehicle::simple_spawn_single( var_83d281d, 1 );
    heli thread function_53c06d6e();
    
    if ( var_86a56d5f == 1 )
    {
        heli thread vehicle::go_path();
    }
    
    return heli;
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 3
// Checksum 0x66726b2, Offset: 0x1048
// Size: 0x2bc
function function_887fdde7( var_7954f958, e_target, var_34fc75ef )
{
    self endon( #"death" );
    var_876ccac = 0;
    var_446f64ef = 0.1;
    var_31ecd8a5 = 0.5;
    var_caad4850 = undefined;
    self turretsettarget( 0, e_target.origin );
    self turretsettarget( 1, e_target.origin );
    var_7060da37 = self gettagorigin( "tag_fx_light_wing_left" ) + ( 60, 200, -10 );
    var_dce1d2d1 = self gettagorigin( "tag_fx_light_wing_right" ) + ( -60, 200, -10 );
    
    while ( var_876ccac < var_34fc75ef )
    {
        if ( !isdefined( e_target ) && isdefined( var_caad4850 ) )
        {
            target_vector = var_caad4850;
        }
        else if ( !isdefined( e_target ) && !isdefined( var_caad4850 ) )
        {
            break;
        }
        else if ( isdefined( e_target ) )
        {
            target_vector = e_target.origin;
        }
        
        if ( var_7954f958 == "front" )
        {
            magicbullet( getweapon( "player_hind_gunner1_turret" ), self gettagorigin( "tag_gunner_flash1" ), target_vector, self );
            var_876ccac += var_446f64ef;
            wait var_446f64ef;
        }
        else if ( var_7954f958 == "side" )
        {
            magicbullet( getweapon( "player_hind_main_turret_3rd_person" ), var_7060da37, target_vector, self );
            magicbullet( getweapon( "player_hind_main_turret_3rd_person" ), var_dce1d2d1, target_vector, self );
            var_876ccac += var_31ecd8a5;
            wait var_31ecd8a5;
        }
        
        var_caad4850 = target_vector;
    }
    
    self turretcleartarget( 0 );
    self turretcleartarget( 1 );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 5
// Checksum 0xa9129af3, Offset: 0x1310
// Size: 0x2cc
function function_53c06d6e( var_80561a4a = 0, turn_on_lights = 1, var_dbce26d4 = 1, var_3f8e3ea9 = 1, var_52fa354e = 1 )
{
    var_8734dfd9 = undefined;
    var_7cb53dc = undefined;
    var_5e36f96c = undefined;
    var_d20a4380 = undefined;
    var_87c3ba4a = undefined;
    
    if ( isstring( var_80561a4a ) )
    {
        params = strtok( var_80561a4a, "," );
        
        if ( isdefined( params[ 0 ] ) )
        {
            var_8734dfd9 = params[ 0 ];
        }
        else
        {
            var_8734dfd9 = 0;
        }
        
        if ( isdefined( params[ 1 ] ) )
        {
            var_87c3ba4a = params[ 1 ];
        }
        else
        {
            var_87c3ba4a = turn_on_lights;
        }
        
        if ( isdefined( params[ 2 ] ) )
        {
            var_7cb53dc = params[ 2 ];
        }
        else
        {
            var_7cb53dc = var_dbce26d4;
        }
        
        if ( isdefined( params[ 3 ] ) )
        {
            var_5e36f96c = params[ 3 ];
        }
        else
        {
            var_5e36f96c = var_3f8e3ea9;
        }
        
        if ( isdefined( params[ 4 ] ) )
        {
            var_d20a4380 = params[ 4 ];
        }
        else
        {
            var_d20a4380 = var_52fa354e;
        }
    }
    else
    {
        var_8734dfd9 = var_80561a4a;
        var_87c3ba4a = turn_on_lights;
        var_7cb53dc = var_dbce26d4;
        var_5e36f96c = var_3f8e3ea9;
        var_d20a4380 = var_52fa354e;
    }
    
    if ( is_true( var_7cb53dc ) )
    {
        self vehicle::toggle_tread_fx( 1 );
    }
    
    if ( is_true( var_5e36f96c ) )
    {
        self vehicle::toggle_exhaust_fx( 1 );
    }
    
    if ( is_true( var_d20a4380 ) )
    {
        self thread function_7e3b4837( var_8734dfd9 );
    }
    
    self function_388cae02( 1 );
    
    if ( !is_true( self.nolights ) || is_true( var_87c3ba4a ) )
    {
        self vehicle::lights_on();
    }
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 1
// Checksum 0x51845f29, Offset: 0x15e8
// Size: 0x6c
function function_388cae02( speed )
{
    if ( !isdefined( speed ) )
    {
        return;
    }
    
    f_speed = speed;
    
    if ( isstring( speed ) )
    {
        f_speed = float( speed );
    }
    
    self setrotorspeed( f_speed );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 1
// Checksum 0x5c6c7723, Offset: 0x1660
// Size: 0x124
function function_7e3b4837( var_80561a4a )
{
    self endon( #"death", #"exit_vehicle" );
    
    if ( is_true( var_80561a4a ) )
    {
        if ( isdefined( self.var_42cfec27 ) && self.var_42cfec27 != "" )
        {
            var_b0c85051 = soundgetplaybacktime( self.var_42cfec27 ) * 0.001;
            var_b0c85051 -= 0.5;
            
            if ( var_b0c85051 > 0 )
            {
                var_b0c85051 = math::clamp( var_b0c85051, 0.25, 1.5 );
                self playsound( self.var_42cfec27 );
                wait var_b0c85051;
            }
        }
    }
    
    self vehicle::toggle_sounds( 1 );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 1
// Checksum 0xf5cba40d, Offset: 0x1790
// Size: 0x24
function function_15426f9d( name )
{
    clientfield::set( name, 2 );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 1
// Checksum 0xbda17ac, Offset: 0x17c0
// Size: 0x24
function function_ee83e03a( name )
{
    clientfield::set( name, 1 );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 1
// Checksum 0xfffc0adc, Offset: 0x17f0
// Size: 0xf8
function function_6f1012dd( str_location )
{
    var_d87261a4 = struct::get_array( "s_corpse_crossbow_bolt_interact", "targetname" );
    
    foreach ( var_350bdb56 in var_d87261a4 )
    {
        if ( var_350bdb56.str_location === str_location )
        {
            var_350bdb56 util::create_cursor_hint( undefined, undefined, #"hash_540e42ba8e5725e7" );
            var_350bdb56 thread function_700c9104();
        }
    }
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 0
// Checksum 0xb63dcd3f, Offset: 0x18f0
// Size: 0xd4
function function_700c9104()
{
    self endon( #"hash_36fff570c9861b" );
    self waittill( #"trigger" );
    level.player thread function_d7ce9e77();
    level flag::set( "flg_crossbow_bolt_corpse_interacted_with" );
    transient = savegame::function_6440b06b( #"transient" );
    transient.var_c99708b8 = 1;
    level thread namespace_7468806b::function_53be9a49();
    level thread function_2e5072b5( self.str_location );
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 1
// Checksum 0x26cd0b72, Offset: 0x19d0
// Size: 0xdc
function function_2e5072b5( str_location )
{
    var_d87261a4 = struct::get_array( "s_corpse_crossbow_bolt_interact", "targetname" );
    
    foreach ( var_350bdb56 in var_d87261a4 )
    {
        if ( var_350bdb56.str_location === str_location )
        {
            var_350bdb56 util::remove_cursor_hint();
            var_350bdb56 notify( #"hash_36fff570c9861b" );
        }
    }
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 0
// Checksum 0x58c768f6, Offset: 0x1ab8
// Size: 0x78, Type: bool
function function_315b14d6()
{
    transient = savegame::function_6440b06b( #"transient" );
    
    if ( level flag::get( "flg_crossbow_bolt_corpse_interacted_with" ) || is_true( transient.var_c99708b8 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_b73b9191/namespace_93d2f0f1
// Params 0
// Checksum 0x453f652b, Offset: 0x1b38
// Size: 0x64
function function_d7ce9e77()
{
    self endon( #"death" );
    self clientfield::set_to_player( "optional_objective_camera_fx", 1 );
    wait 3.5;
    self clientfield::set_to_player( "optional_objective_camera_fx", 0 );
}

