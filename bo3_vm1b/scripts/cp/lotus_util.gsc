#using scripts/codescripts/struct;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace lotus_util;

// Namespace lotus_util
// Params 2
// Checksum 0x2f244c98, Offset: 0xbf0
// Size: 0xa2
function function_3b6587d6( b_on, str_name )
{
    var_cecf22e2 = getent( str_name + "_switch", "targetname" );
    
    if ( b_on )
    {
        var_cecf22e2 show();
        var_cecf22e2 solid();
    }
    else
    {
        var_cecf22e2 ghost();
        var_cecf22e2 notsolid();
    }
    
    umbragate_set( str_name, !b_on );
}

// Namespace lotus_util
// Params 6
// Checksum 0xef9bc34f, Offset: 0xca0
// Size: 0x6a5
function mobile_shop_setup( str_groupname, b_armory, b_turret_off, b_model_turret, str_model_turret_override, b_minigun_hidden )
{
    if ( !isdefined( b_armory ) )
    {
        b_armory = 0;
    }
    
    if ( !isdefined( b_turret_off ) )
    {
        b_turret_off = 0;
    }
    
    if ( !isdefined( b_model_turret ) )
    {
        b_model_turret = 0;
    }
    
    if ( !isdefined( b_minigun_hidden ) )
    {
        b_minigun_hidden = 0;
    }
    
    a_mobile_parts = getentarray( str_groupname, "groupname" );
    
    if ( isarray( a_mobile_parts ) && a_mobile_parts.size >= 3 )
    {
        println( "<dev string:x28>" );
    }
    
    a_destructibles = [];
    a_models = [];
    a_weapons = [];
    
    foreach ( e_mobile_part in a_mobile_parts )
    {
        if ( e_mobile_part.classname == "script_brushmodel" )
        {
            if ( e_mobile_part.targetname === "mobile_destructible" )
            {
                if ( isdefined( e_mobile_part.a_destructibles ) && e_mobile_part.a_destructibles.size > 0 )
                {
                    e_mobile_part.a_destructibles = array::remove_undefined( e_mobile_part.a_destructibles );
                }
                
                e_mobile_part thread destructible_watch();
                
                if ( !isdefined( a_destructibles ) )
                {
                    a_destructibles = [];
                }
                else if ( !isarray( a_destructibles ) )
                {
                    a_destructibles = array( a_destructibles );
                }
                
                a_destructibles[ a_destructibles.size ] = e_mobile_part;
            }
            else
            {
                if ( isdefined( e_mobile_part.a_miniguns ) && e_mobile_part.a_miniguns.size > 0 )
                {
                    e_mobile_part.a_miniguns = array::remove_undefined( e_mobile_part.a_miniguns );
                }
                
                e_mobile_shop = e_mobile_part;
            }
            
            continue;
        }
        
        if ( e_mobile_part.classname == "script_model" )
        {
            if ( e_mobile_part.targetname === "mobile_weapon" )
            {
                if ( isdefined( e_mobile_part.a_weapons ) && e_mobile_part.a_weapons.size > 0 )
                {
                    e_mobile_part.a_weapons = array::remove_undefined( e_mobile_part.a_weapons );
                }
                
                e_mobile_part hide();
                
                if ( !isdefined( a_weapons ) )
                {
                    a_weapons = [];
                }
                else if ( !isarray( a_weapons ) )
                {
                    a_weapons = array( a_weapons );
                }
                
                a_weapons[ a_weapons.size ] = e_mobile_part;
                continue;
            }
            
            if ( isdefined( e_mobile_part.a_models ) && e_mobile_part.a_models.size > 0 && e_mobile_part.targetname != "minigun_auto" )
            {
                e_mobile_part.a_models = array::remove_undefined( e_mobile_part.a_models );
            }
            
            if ( !isdefined( a_models ) )
            {
                a_models = [];
            }
            else if ( !isarray( a_models ) )
            {
                a_models = array( a_models );
            }
            
            a_models[ a_models.size ] = e_mobile_part;
        }
    }
    
    arrayremovevalue( a_mobile_parts, e_mobile_shop );
    a_mobile_parts = array::exclude( a_mobile_parts, a_destructibles );
    a_mobile_parts = array::exclude( a_mobile_parts, a_models );
    a_mobile_parts = array::exclude( a_mobile_parts, a_weapons );
    e_mobile_shop.a_destructibles = a_destructibles;
    e_mobile_shop.a_models = a_models;
    e_mobile_shop.a_weapons = a_weapons;
    a_mobile_models = arraycombine( a_destructibles, a_models, 0, 0 );
    a_mobile_models = arraycombine( a_mobile_models, a_weapons, 0, 0 );
    
    foreach ( mdl_mobile_piece in a_mobile_models )
    {
        mdl_mobile_piece linkto( e_mobile_shop );
    }
    
    if ( isdefined( b_armory ) && b_armory )
    {
        foreach ( sp_minigun_auto in a_mobile_parts )
        {
            if ( isdefined( b_model_turret ) && b_model_turret )
            {
                if ( sp_minigun_auto.model != "wpn_t7_mingun_world" )
                {
                    if ( !isdefined( str_model_turret_override ) )
                    {
                        e_minigun_auto = util::spawn_model( "wpn_t7_mingun_world", sp_minigun_auto.origin, sp_minigun_auto.angles );
                    }
                    else
                    {
                        e_minigun_auto = util::spawn_model( str_model_turret_override, sp_minigun_auto.origin, sp_minigun_auto.angles );
                    }
                }
                else
                {
                    e_minigun_auto = sp_minigun_auto;
                }
            }
            else
            {
                e_minigun_auto = spawner::simple_spawn_single( sp_minigun_auto );
                
                if ( isdefined( b_turret_off ) && b_turret_off )
                {
                    e_minigun_auto vehicle_ai::turnoff();
                }
            }
            
            e_minigun_auto linkto( e_mobile_shop );
            
            if ( isdefined( b_minigun_hidden ) && b_minigun_hidden )
            {
                e_minigun_auto hide();
            }
            else
            {
                t_minigun_auto = e_minigun_auto minigun_usable( b_model_turret, b_minigun_hidden );
                t_minigun_auto linkto( e_mobile_shop );
            }
            
            if ( !isdefined( e_mobile_shop.a_miniguns ) )
            {
                e_mobile_shop.a_miniguns = [];
            }
            
            if ( !isdefined( e_mobile_shop.a_miniguns ) )
            {
                e_mobile_shop.a_miniguns = [];
            }
            else if ( !isarray( e_mobile_shop.a_miniguns ) )
            {
                e_mobile_shop.a_miniguns = array( e_mobile_shop.a_miniguns );
            }
            
            e_mobile_shop.a_miniguns[ e_mobile_shop.a_miniguns.size ] = e_minigun_auto;
        }
    }
    
    return e_mobile_shop;
}

// Namespace lotus_util
// Params 1
// Checksum 0x47287b16, Offset: 0x1350
// Size: 0xd4
function mobile_weapon_usable( str_weapon )
{
    self show();
    self oed::enable_keyline( 1 );
    t_weapon = spawn( "trigger_radius_use", self.origin );
    t_weapon triggerignoreteam();
    t_weapon sethintstring( &"CP_MI_CAIRO_LOTUS_GRAB_SMAW" );
    t_weapon setcursorhint( "HINT_NOICON" );
    t_weapon enablelinkto();
    t_weapon.targetname = "trig_weapon";
    self.t_weapon = t_weapon;
    self thread mobile_weapon_pickup( t_weapon, str_weapon );
    return t_weapon;
}

// Namespace lotus_util
// Params 2
// Checksum 0x93a7510d, Offset: 0x1430
// Size: 0xf3
function mobile_weapon_pickup( t_weapon, str_weapon )
{
    self endon( #"death" );
    self thread mobile_weapon_cleanup();
    t_weapon waittill( #"trigger", player );
    w_weapon = getweapon( str_weapon );
    n_ammo_total = w_weapon.clipsize + w_weapon.maxammo;
    n_ammo = player getammocount( w_weapon );
    
    if ( player hasweapon( w_weapon ) && n_ammo >= n_ammo_total )
    {
        self thread mobile_weapon_pickup( t_weapon, str_weapon );
        return;
    }
    
    t_weapon delete();
    player thread mobile_weapon_give( str_weapon );
    self notify( #"mobile_weapon_cleanup" );
}

// Namespace lotus_util
// Params 0
// Checksum 0x9cb751dd, Offset: 0x1530
// Size: 0x42
function mobile_weapon_cleanup()
{
    self endon( #"death" );
    self waittill( #"mobile_weapon_cleanup" );
    self hide();
    
    if ( isdefined( self.t_weapon ) )
    {
        self.t_weapon delete();
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0xd380c491, Offset: 0x1580
// Size: 0xba
function mobile_weapon_give( str_weapon )
{
    self endon( #"death" );
    w_weapon = getweapon( str_weapon );
    
    if ( self hasweapon( w_weapon ) )
    {
        self givemaxammo( w_weapon );
        self setweaponammoclip( w_weapon, w_weapon.clipsize );
        return;
    }
    
    self giveweapon( w_weapon );
    self switchtoweapon( w_weapon );
    self notify( #"weapon_given" );
    self thread function_d3cb8a55();
}

// Namespace lotus_util
// Params 0
// Checksum 0x780a3b38, Offset: 0x1648
// Size: 0x179
function function_d3cb8a55()
{
    self notify( #"hash_b729e030" );
    self endon( #"hash_b729e030" );
    self endon( #"death" );
    var_67aa166f = 0;
    var_90911853 = getweapon( "launcher_standard" );
    w_minigun = getweapon( "minigun_lotus" );
    self.var_271f03e = 0;
    
    while ( self hasweapon( var_90911853, 1 ) )
    {
        self waittill( #"weapon_fired" );
        
        if ( !level flag::get( "gunship_high_out_of_battle" ) )
        {
            if ( self getcurrentweapon() == var_90911853 && self getammocount( var_90911853 ) > 0 )
            {
                self.var_271f03e = 0;
            }
            
            if ( self getcurrentweapon() != var_90911853 && self getcurrentweapon() != w_minigun && self getammocount( var_90911853 ) > 0 )
            {
                self.var_271f03e = self.var_271f03e + 1;
            }
            
            if ( self.var_271f03e >= 10 )
            {
                self util::show_hint_text( &"COOP_EQUIP_XM53", 0 );
                var_67aa166f += 1;
                self.var_271f03e = 0;
                wait 10;
                
                if ( var_67aa166f >= 3 )
                {
                    return;
                }
            }
        }
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x63b0117a, Offset: 0x17d0
// Size: 0x18b
function function_6fc3995f()
{
    a_str_types = array( "casino", "medical", "merchant", "restaurant", "tattoo" );
    
    foreach ( str_type in a_str_types )
    {
        switch ( str_type )
        {
            case "casino":
                var_2e3ccdfd = 5;
                break;
            case "medical":
                var_2e3ccdfd = 1;
                break;
            case "merchant":
                var_2e3ccdfd = 2;
                break;
            case "restaurant":
                var_2e3ccdfd = 4;
                break;
            default:
                var_2e3ccdfd = 3;
                break;
        }
        
        var_989cfb0 = getentarray( str_type + "_shop", "script_noteworthy" );
        
        foreach ( var_6ff04f8d in var_989cfb0 )
        {
            var_6ff04f8d clientfield::set( "mobile_shop_fxanims", var_2e3ccdfd );
            util::wait_network_frame();
        }
    }
}

// Namespace lotus_util
// Params 2
// Checksum 0x69eb84e, Offset: 0x1968
// Size: 0x185
function minigun_usable( b_model_turret, b_minigun_hidden )
{
    if ( isdefined( b_minigun_hidden ) && b_minigun_hidden )
    {
        self show();
    }
    
    self oed::enable_keyline( 1 );
    t_minigun_auto = spawn( "trigger_radius_use", self.origin );
    t_minigun_auto triggerignoreteam();
    t_minigun_auto sethintstring( &"CP_MI_CAIRO_LOTUS_GRAB_MINIGUN" );
    t_minigun_auto setcursorhint( "HINT_NOICON" );
    t_minigun_auto enablelinkto();
    t_minigun_auto.targetname = "trig_minigun";
    self.t_minigun_auto = t_minigun_auto;
    self thread minigun_pickup( t_minigun_auto, b_model_turret, b_minigun_hidden );
    w_minigun = getweapon( "minigun_lotus" );
    
    foreach ( player in level.players )
    {
        if ( player hasweapon( w_minigun ) )
        {
            t_minigun_auto setinvisibletoplayer( player );
        }
    }
    
    return t_minigun_auto;
}

// Namespace lotus_util
// Params 3
// Checksum 0x8cf99b4a, Offset: 0x1af8
// Size: 0x15b
function minigun_pickup( t_minigun_auto, b_model_turret, b_minigun_hidden )
{
    self endon( #"death" );
    self thread minigun_turret_cleanup( b_model_turret, b_minigun_hidden );
    t_minigun_auto waittill( #"trigger", player );
    w_minigun = getweapon( "minigun_lotus" );
    
    if ( player hasweapon( w_minigun ) )
    {
        self thread minigun_pickup( t_minigun_auto, b_model_turret, b_minigun_hidden );
        return;
    }
    
    t_minigun_auto delete();
    player thread minigun_give();
    self notify( #"minigun_picked_up" );
    level notify( #"minigun_turret_picked_up" );
    a_minigun_triggers = getentarray( "trig_minigun", "targetname" );
    
    foreach ( t_minigun in a_minigun_triggers )
    {
        t_minigun setinvisibletoplayer( player );
    }
    
    self notify( #"minigun_turret_cleanup" );
}

// Namespace lotus_util
// Params 2
// Checksum 0xc45865dd, Offset: 0x1c60
// Size: 0x92
function minigun_turret_cleanup( b_model_turret, b_minigun_hidden )
{
    self endon( #"death" );
    self waittill( #"minigun_turret_cleanup" );
    
    if ( isdefined( b_model_turret ) && b_model_turret )
    {
        if ( isdefined( b_minigun_hidden ) && b_minigun_hidden )
        {
            self hide();
        }
        else
        {
            self delete();
        }
        
        return;
    }
    
    self.delete_on_death = 1;
    self notify( #"death" );
    
    if ( !isalive( self ) )
    {
        self delete();
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0xb83e23ad, Offset: 0x1d00
// Size: 0x72
function minigun_give( n_minigun_ammo )
{
    self endon( #"death" );
    w_minigun = getweapon( "minigun_lotus" );
    self giveweapon( w_minigun );
    self switchtoweapon( w_minigun );
    self notify( #"minigun_given" );
    self thread function_a6145523();
}

// Namespace lotus_util
// Params 1
// Checksum 0x4094a302, Offset: 0x1d80
// Size: 0x6e
function keeping_up_with_minigun_ammo_count( w_weapon )
{
    self endon( #"death" );
    self endon( #"drop_minigun" );
    n_ammo = self getammocount( w_weapon );
    
    while ( n_ammo > 0 )
    {
        self.n_minigun_ammo = n_ammo;
        n_ammo = self getammocount( w_weapon );
        wait 0.05;
    }
    
    self.n_minigun_ammo = n_ammo;
}

// Namespace lotus_util
// Params 0
// Checksum 0xe3067776, Offset: 0x1df8
// Size: 0x2f
function waittill_minigun_need_to_drop()
{
    self endon( #"death" );
    self endon( #"drop_minigun" );
    self waittill( #"weapon_change" );
    self waittill( #"weapon_change" );
    self notify( #"drop_minigun" );
}

// Namespace lotus_util
// Params 1
// Checksum 0x5a285744, Offset: 0x1e30
// Size: 0x132
function minigun_drop( n_minigun_ammo )
{
    self endon( #"death" );
    w_weapon = getweapon( "minigun_lotus" );
    self takeweapon( w_weapon );
    self notify( #"minigun_took_away" );
    m_minigun = util::spawn_model( "wpn_t7_mingun_world", self.origin + ( 0, 0, 12 ), self.angles );
    m_minigun physicslaunch( m_minigun.origin, ( 0, 0, 0 ) );
    m_minigun.n_minigun_ammo = self.n_minigun_ammo;
    self.n_minigun_ammo = undefined;
    t_minigun = spawn( "trigger_radius_use", m_minigun.origin );
    t_minigun triggerignoreteam();
    t_minigun setcursorhint( "HINT_NOICON" );
    t_minigun enablelinkto();
    t_minigun linkto( m_minigun );
}

// Namespace lotus_util
// Params 0
// Checksum 0xaad6f28, Offset: 0x1f70
// Size: 0x179
function function_a6145523()
{
    self notify( #"hash_763a826a" );
    self endon( #"hash_763a826a" );
    self endon( #"death" );
    var_1b2c2712 = 0;
    w_minigun = getweapon( "minigun_lotus" );
    var_90911853 = getweapon( "launcher_standard" );
    self.var_3bb3fc6d = 0;
    
    while ( self hasweapon( w_minigun, 1 ) )
    {
        self waittill( #"weapon_fired" );
        
        if ( !level flag::get( "gunship_high_out_of_battle" ) )
        {
            if ( self getcurrentweapon() == w_minigun && self getammocount( w_minigun ) > 0 )
            {
                self.var_3bb3fc6d = 0;
            }
            
            if ( self getcurrentweapon() != w_minigun && self getcurrentweapon() != var_90911853 && self getammocount( w_minigun ) > 0 )
            {
                self.var_3bb3fc6d = self.var_3bb3fc6d + 1;
            }
            
            if ( self.var_3bb3fc6d >= 10 )
            {
                self util::show_hint_text( &"CP_MI_CAIRO_LOTUS_MINIGUN_REMINDER", 0 );
                var_1b2c2712 += 1;
                self.var_3bb3fc6d = 0;
                wait 10;
                
                if ( var_1b2c2712 >= 3 )
                {
                    return;
                }
            }
        }
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0xf802812c, Offset: 0x20f8
// Size: 0x63
function function_5408b0dd()
{
    foreach ( player in level.players )
    {
        player thread function_ac865287();
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0xc4b4f0dc, Offset: 0x2168
// Size: 0x97
function function_ac865287()
{
    self notify( #"hash_68eb28e6" );
    self endon( #"hash_68eb28e6" );
    self endon( #"death" );
    w_current = self getcurrentweapon();
    w_juiced_shotgun = getweapon( "shotgun_pump_taser" );
    
    while ( self hasweapon( w_juiced_shotgun, 1 ) )
    {
        if ( w_current == w_juiced_shotgun )
        {
            wait 20;
            continue;
        }
        
        wait 2;
        self util::show_hint_text( &"CP_MI_CAIRO_LOTUS_SHOTGUN_REMINDER", 0 );
        return;
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x545f71c7, Offset: 0x2208
// Size: 0xb3
function juiced_shotgun_trigger_setup()
{
    a_triggers = getentarray( "trig_juiced_shotgun", "targetname" );
    
    foreach ( t_juiced_shotgun in a_triggers )
    {
        t_juiced_shotgun triggerenable( 1 );
        t_juiced_shotgun sethintstring( &"CP_MI_CAIRO_LOTUS_GRAB_SHOTGUN" );
        t_juiced_shotgun thread juiced_shotgun_watcher();
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x74e2790d, Offset: 0x22c8
// Size: 0x85
function juiced_shotgun_watcher()
{
    self endon( #"death" );
    w_juiced_shotgun = getweapon( "shotgun_pump_taser" );
    
    while ( true )
    {
        self waittill( #"trigger", e_player );
        
        if ( !e_player hasweapon( w_juiced_shotgun ) )
        {
            e_player giveweapon( w_juiced_shotgun );
        }
        
        e_player switchtoweapon( w_juiced_shotgun );
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0xf95c3d5e, Offset: 0x2358
// Size: 0x22a
function spawn_funcs_generic_rogue_control()
{
    spawner::add_spawn_function_group( "robot_level_1", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "level_1" );
    spawner::add_spawn_function_group( "robot_level_2", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "level_2" );
    spawner::add_spawn_function_group( "robot_level_3", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "level_3" );
    spawner::add_spawn_function_group( "robot_forced_level_1", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "forced_level_1" );
    spawner::add_spawn_function_group( "robot_forced_level_2", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "forced_level_2" );
    spawner::add_spawn_function_group( "robot_forced_level_3", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "forced_level_3" );
    spawner::add_spawn_function_group( "climber_robot_forced_level_1", "script_noteworthy", &function_b4c5517f, "forced_level_1" );
    spawner::add_spawn_function_group( "climber_robot_forced_level_2", "script_noteworthy", &function_b4c5517f, "forced_level_2" );
    spawner::add_spawn_function_group( "climber_robot_forced_level_3", "script_noteworthy", &function_b4c5517f, "forced_level_3" );
}

// Namespace lotus_util
// Params 1
// Checksum 0xc6c643ea, Offset: 0x2590
// Size: 0x2a
function function_b4c5517f( var_66674d1 )
{
    self waittill( #"scriptedanim" );
    self ai::set_behavior_attribute( "rogue_control", var_66674d1 );
}

// Namespace lotus_util
// Params 1
// Checksum 0x876dc81a, Offset: 0x25c8
// Size: 0x1ad
function destructible_watch( var_e6795c86 )
{
    if ( !isdefined( var_e6795c86 ) )
    {
        var_e6795c86 = undefined;
    }
    
    self endon( #"death" );
    self setcandamage( 1 );
    self.health = 10000;
    
    if ( isdefined( self.script_fxid ) )
    {
        if ( isdefined( self.script_noteworthy ) )
        {
            var_a178d2fe = function_8108bdb8( self.script_fxid, self.script_noteworthy, self );
            
            if ( isdefined( var_a178d2fe ) )
            {
                var_a178d2fe hide();
            }
        }
        
        if ( isdefined( self.script_label ) )
        {
            var_3e1ea936 = function_8108bdb8( self.script_fxid, self.script_label, self );
            
            if ( isdefined( var_3e1ea936 ) )
            {
                var_3e1ea936 hide();
            }
        }
    }
    
    b_destroyed = 0;
    
    while ( !b_destroyed )
    {
        self waittill( #"damage", n_damage, e_attacker, v_vector, v_point, str_means_of_death, str_string_1, str_string_2, str_string_3, w_weapon );
        
        if ( str_means_of_death == "MOD_PROJECTILE" || e_attacker.vehicletype === "veh_bo3_mil_gunship_nrc" && str_means_of_death == "MOD_PROJECTILE_SPLASH" )
        {
            self function_aabc561a( var_e6795c86 );
            b_destroyed = 1;
        }
        
        self.health = 10000;
        wait 0.05;
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0x4e1a81c2, Offset: 0x2780
// Size: 0x23a
function function_aabc561a( var_e6795c86 )
{
    if ( !isdefined( var_e6795c86 ) )
    {
        var_e6795c86 = undefined;
    }
    
    if ( self.script_ignoreme === 0 )
    {
        self notsolid();
        self hide();
        
        if ( isdefined( self.script_fxid ) )
        {
            var_6bcf377a = self.script_fxid + "_" + self.targetname;
            s_fx = struct::get( var_6bcf377a, "targetname" );
            
            if ( isdefined( s_fx ) )
            {
                s_fx thread scene::play();
                
                if ( isdefined( var_e6795c86 ) )
                {
                    s_fx thread fx::play( var_e6795c86 );
                }
            }
            
            if ( isdefined( self.script_parameters ) )
            {
                var_54a0ec88 = function_8108bdb8( self.script_fxid, self.script_parameters, self );
                
                if ( isdefined( var_54a0ec88 ) )
                {
                    var_54a0ec88 notsolid();
                    var_54a0ec88 hide();
                    var_54a0ec88 delete();
                }
            }
            
            if ( isdefined( self.target ) )
            {
                var_dc0bfd76 = function_8108bdb8( self.script_fxid, self.target, self );
                
                if ( isdefined( var_dc0bfd76 ) )
                {
                    var_dc0bfd76 function_8effc214();
                }
            }
        }
        
        if ( isdefined( self.script_noteworthy ) )
        {
            var_a178d2fe = function_8108bdb8( self.script_fxid, self.script_noteworthy, self );
            
            if ( isdefined( var_a178d2fe ) )
            {
                var_a178d2fe show();
            }
        }
        
        if ( isdefined( self.script_label ) )
        {
            var_3e1ea936 = function_8108bdb8( self.script_fxid, self.script_label, self );
            
            if ( isdefined( var_3e1ea936 ) )
            {
                var_3e1ea936 notsolid();
                var_3e1ea936 hide();
            }
        }
        
        if ( isdefined( self.script_ignoreme ) )
        {
            self.script_ignoreme = 1;
        }
        
        self delete();
    }
}

// Namespace lotus_util
// Params 3
// Checksum 0xe905a5e4, Offset: 0x29c8
// Size: 0xb3
function function_8108bdb8( var_700327f8, str_targetname, refobj )
{
    if ( !isdefined( refobj ) )
    {
        refobj = undefined;
    }
    
    var_442c186f = undefined;
    a_mdls = getentarray( str_targetname, "targetname" );
    
    foreach ( var_f582979c in a_mdls )
    {
        if ( var_f582979c.script_fxid === var_700327f8 )
        {
            var_442c186f = var_f582979c;
        }
    }
    
    return var_442c186f;
}

// Namespace lotus_util
// Params 2
// Checksum 0xf5df4db2, Offset: 0x2a88
// Size: 0xba
function function_8effc214( var_449c8315, var_217954db )
{
    if ( !isdefined( var_449c8315 ) )
    {
        var_449c8315 = 0;
    }
    
    if ( !isdefined( var_217954db ) )
    {
        var_217954db = 0;
    }
    
    if ( isdefined( self.script_ignoreme ) && self.script_ignoreme == 0 && isdefined( self.script_label ) && isdefined( self.script_fxid ) )
    {
        var_a788dff4 = function_8108bdb8( self.script_fxid, self.script_label, self );
        var_a788dff4 show();
        
        if ( var_217954db )
        {
            var_a788dff4 thread destructible_watch();
        }
        
        if ( var_449c8315 )
        {
            self hide();
        }
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0xc123c13e, Offset: 0x2b50
// Size: 0x20a
function enemy_on_fire( do_the_robot )
{
    if ( do_the_robot )
    {
        type = "robot";
    }
    else
    {
        type = "human";
    }
    
    playfxontag( level._effect[ "burn_loop_" + type + "_left_arm" ], self, "j_shoulder_le_rot" );
    playfxontag( level._effect[ "burn_loop_" + type + "_left_arm" ], self, "j_elbow_le_rot" );
    playfxontag( level._effect[ "burn_loop_" + type + "_right_arm" ], self, "j_shoulder_ri_rot" );
    playfxontag( level._effect[ "burn_loop_" + type + "_right_arm" ], self, "j_elbow_ri_rot" );
    playfxontag( level._effect[ "burn_loop_" + type + "_left_leg" ], self, "j_hip_le" );
    playfxontag( level._effect[ "burn_loop_" + type + "_left_leg" ], self, "j_knee_le" );
    playfxontag( level._effect[ "burn_loop_" + type + "_right_leg" ], self, "j_hip_ri" );
    playfxontag( level._effect[ "burn_loop_" + type + "_right_leg" ], self, "j_knee_ri" );
    playfxontag( level._effect[ "burn_loop_" + type + "_head" ], self, "j_head" );
    playfxontag( level._effect[ "burn_loop_" + type + "_torso" ], self, "j_mainroot" );
}

// Namespace lotus_util
// Params 2
// Checksum 0xed1189b5, Offset: 0x2d68
// Size: 0x32
function function_2838f054( var_dd528041, var_bb4455a6 )
{
    function_c9fa49c2( var_dd528041, var_bb4455a6 );
    objectives::breadcrumb( var_bb4455a6 );
}

// Namespace lotus_util
// Params 2
// Checksum 0x2982c662, Offset: 0x2da8
// Size: 0x55
function function_c9fa49c2( var_dd528041, str_trigger_name )
{
    t_breadcrumb = getent( str_trigger_name, "targetname" );
    
    if ( isdefined( t_breadcrumb ) )
    {
        objectives::set( var_dd528041, t_breadcrumb.origin );
    }
}

// Namespace lotus_util
// Params 3
// Checksum 0xeaf07fc6, Offset: 0x2e08
// Size: 0x5a
function function_50ae49cd( var_46c42db4, b_debug, var_fc275254 )
{
    if ( !isdefined( b_debug ) )
    {
        b_debug = 1;
    }
    
    for ( var_17688fb5 = var_46c42db4; isdefined( var_17688fb5 ) ; var_17688fb5 = function_20fc45fd( var_17688fb5, b_debug ) )
    {
    }
    
    if ( isdefined( var_fc275254 ) )
    {
        level notify( var_fc275254 );
    }
}

// Namespace lotus_util
// Params 2
// Checksum 0xb8ae85c4, Offset: 0x2e70
// Size: 0x114
function function_20fc45fd( var_17688fb5, b_debug )
{
    t_current = getent( var_17688fb5, "targetname" );
    
    if ( isdefined( t_current ) )
    {
        v_position = t_current.origin;
        
        if ( isdefined( t_current.target ) )
        {
            s_current = struct::get( t_current.target, "targetname" );
            
            if ( isdefined( s_current ) )
            {
                v_position = s_current.origin;
            }
        }
        
        objectives::set( "cp_waypoint_breadcrumb", v_position );
        trigger::wait_till( var_17688fb5 );
        objectives::complete( "cp_waypoint_breadcrumb" );
        var_c15deb89 = t_current.target;
    }
    
    /#
        if ( isdefined( var_c15deb89 ) && b_debug )
        {
            iprintlnbold( var_c15deb89 );
        }
    #/
    
    return var_c15deb89;
}

// Namespace lotus_util
// Params 1
// Checksum 0x48e60234, Offset: 0x2f90
// Size: 0xea
function function_393c81a5( a_ents )
{
    self endon( #"scene_done" );
    array::thread_all( a_ents, &function_5a92c897, self );
    array::thread_all( a_ents, &function_27e365e2, "killed_by_nrc", "axis" );
    array::wait_any( a_ents, "damage" );
    util::wait_network_frame();
    
    foreach ( ent in a_ents )
    {
        ent notify( #"hash_9ac59272" );
    }
    
    self scene::stop();
}

// Namespace lotus_util
// Params 1
// Checksum 0xd2f56abf, Offset: 0x3088
// Size: 0xea
function function_f2596cbe( a_ents )
{
    self endon( #"scene_done" );
    array::thread_all( a_ents, &function_5a92c897, self );
    array::wait_any( a_ents, "death" );
    util::wait_network_frame();
    
    foreach ( ent in a_ents )
    {
        if ( isai( ent ) )
        {
            ent ai::set_ignoreall( 0 );
            ent ai::set_ignoreme( 0 );
        }
    }
    
    self scene::stop();
}

// Namespace lotus_util
// Params 1
// Checksum 0x948e1040, Offset: 0x3180
// Size: 0xda
function function_5a92c897( e_root )
{
    self endon( #"death" );
    
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( self.team === "allies" )
    {
        self thread function_6c396cfa( 1 );
    }
    else
    {
        self thread function_6c396cfa( 1 );
        self thread ai::set_behavior_attribute( "can_be_meleed", 0 );
    }
    
    e_root waittill( #"scene_done" );
    
    if ( self.team === "allies" )
    {
        self thread function_6c396cfa( 0 );
        return;
    }
    
    self thread function_6c396cfa( 0 );
    self thread ai::set_behavior_attribute( "can_be_meleed", 1 );
}

// Namespace lotus_util
// Params 1
// Checksum 0xcc6d41f5, Offset: 0x3268
// Size: 0x26
function function_6c396cfa( var_c5d9e0f5 )
{
    if ( isai( self ) )
    {
        self.ignoreme = var_c5d9e0f5;
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0xeb7ec80, Offset: 0x3298
// Size: 0x16b
function function_5da90c71( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( isai( ent ) )
        {
            ent ai::set_ignoreme( 1 );
            ent ai::set_ignoreall( 1 );
            ent util::magic_bullet_shield();
        }
    }
    
    while ( scene::is_active( self.scriptbundlename ) )
    {
        wait 0.05;
    }
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent ) && isai( ent ) && isalive( ent ) )
        {
            ent ai::set_ignoreme( 0 );
            ent ai::set_ignoreall( 0 );
            ent util::stop_magic_bullet_shield();
        }
    }
}

// Namespace lotus_util
// Params 2
// Checksum 0x2a3797e2, Offset: 0x3410
// Size: 0x141
function gather_point_wait( should_delete, a_ai )
{
    if ( !isdefined( a_ai ) )
    {
        a_ai = [];
    }
    
    while ( true )
    {
        n_player_ready = 0;
        n_ai_ready = 0;
        
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                n_player_ready++;
            }
        }
        
        foreach ( ai in a_ai )
        {
            if ( ai istouching( self ) )
            {
                n_ai_ready++;
            }
        }
        
        if ( n_player_ready == level.players.size && n_ai_ready == a_ai.size )
        {
            if ( isdefined( should_delete ) && should_delete )
            {
                self util::self_delete();
            }
            
            break;
        }
        
        wait 0.1;
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0xc640204c, Offset: 0x3560
// Size: 0x12a
function function_d720c23e( str_name )
{
    level flag::wait_till( "all_players_spawned" );
    e_trigger = getent( "ambient_mobile_" + str_name + "_trigger", "script_noteworthy" );
    
    if ( !isdefined( e_trigger ) )
    {
        e_trigger = getent( "ambient_mobile_" + str_name + "_0_trigger", "script_noteworthy" );
    }
    
    if ( isdefined( e_trigger ) )
    {
        var_2e308a20 = getentarray( e_trigger.target, "targetname" );
        
        foreach ( e_piece in var_2e308a20 )
        {
            e_piece.groupname = str_name;
        }
        
        mobile_shop_setup( str_name );
        e_trigger trigger::use();
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0xeda9017a, Offset: 0x3698
// Size: 0xea
function function_14be4cad( var_1d3f7e09 )
{
    if ( !isdefined( var_1d3f7e09 ) )
    {
        var_1d3f7e09 = 0;
    }
    
    level thread function_d720c23e( "bb_n_mshop_a" );
    level thread function_d720c23e( "bb_s_mshop_a" );
    level thread function_d720c23e( "bb_s_mshop_b" );
    level thread function_d720c23e( "bb_s_mshop_c" );
    level thread function_d720c23e( "center_mshop" );
    wait 7;
    function_fe64b86b( "rainman", struct::get( "bridge_battle_corpse_drop" ), 0 );
    wait 25;
    function_fe64b86b( "rainman", struct::get( "bridge_battle_corpse_drop2" ), 0 );
}

// Namespace lotus_util
// Params 0
// Checksum 0x34a8eb56, Offset: 0x3790
// Size: 0xf9
function function_ba1b651d()
{
    str_shop_name = "bridge_battle_mobile_shop";
    var_5bed9cb6 = "mshop_n_entrance_a_01";
    var_bef0b623 = function_c7bebe99( str_shop_name, var_5bed9cb6, 15, undefined, 10, 0, 0 );
    var_27d8849a = [[ var_bef0b623 ]]->get_platform_vehicle();
    var_a175a10b = util::spawn_model( "tag_origin", var_27d8849a.origin, var_27d8849a.angles );
    
    while ( true )
    {
        /#
            iprintlnbold( "<dev string:x61>" );
        #/
        
        level function_de4512ae( var_bef0b623, "mshop_n_entrance_a_01" );
        trigger::use( str_shop_name, "target" );
        level waittill( "vehicle_platform_" + str_shop_name + "_stop" );
    }
}

// Namespace lotus_util
// Params 7
// Checksum 0xf776b52f, Offset: 0x3898
// Size: 0x9c
function function_c7bebe99( str_shop_name, var_9a2454dd, n_shop_speed, str_waittill, n_wait_amount, b_hop_on, n_after_spawn_wait_amount )
{
    if ( !isdefined( b_hop_on ) )
    {
        b_hop_on = 0;
    }
    
    if ( !isdefined( n_after_spawn_wait_amount ) )
    {
        n_after_spawn_wait_amount = 0;
    }
    
    var_bef0b623 = new cvehicleplatform();
    [[ var_bef0b623 ]]->init( str_shop_name, var_9a2454dd );
    var_27d8849a = [[ var_bef0b623 ]]->get_platform_vehicle();
    var_27d8849a.takedamage = 0;
    return var_bef0b623;
}

// Namespace lotus_util
// Params 2
// Checksum 0x7ae742c3, Offset: 0x3940
// Size: 0x46
function function_de4512ae( o_mobile_shop, var_5bed9cb6 )
{
    vh_mobile = [[ o_mobile_shop ]]->get_platform_vehicle();
    vh_mobile clearvehgoalpos();
    [[ o_mobile_shop ]]->set_node_start( var_5bed9cb6 );
}

// Namespace lotus_util
// Params 4
// Checksum 0x369fb586, Offset: 0x3990
// Size: 0x13a
function function_99514074( var_3c3195e7, str_spawner, var_2a151a84, n_delay )
{
    if ( !isdefined( var_2a151a84 ) )
    {
        var_2a151a84 = undefined;
    }
    
    if ( !isdefined( n_delay ) )
    {
        n_delay = undefined;
    }
    
    var_253fcf81 = struct::get( var_3c3195e7, "targetname" );
    var_d3c173bf = getent( str_spawner, "targetname" );
    assert( isdefined( var_253fcf81 ) && isdefined( var_d3c173bf ), "<dev string:x86>" );
    
    if ( !isactor( var_d3c173bf ) )
    {
        var_4c5a6632 = spawner::simple_spawn_single( str_spawner );
    }
    else
    {
        var_4c5a6632 = var_d3c173bf;
    }
    
    if ( isdefined( n_delay ) || isdefined( var_2a151a84 ) )
    {
        var_253fcf81 scene::init( var_4c5a6632 );
        
        if ( isdefined( var_2a151a84 ) )
        {
            level flag::wait_till( var_2a151a84 );
        }
        
        if ( isdefined( n_delay ) && n_delay > 0 )
        {
            wait n_delay;
        }
    }
    
    if ( isalive( var_4c5a6632 ) )
    {
        var_253fcf81 scene::play( var_4c5a6632 );
    }
}

// Namespace lotus_util
// Params 4
// Checksum 0xe2cee417, Offset: 0x3ad8
// Size: 0x24a
function function_c7cc24f8( var_3c3195e7, a_str_spawners, var_8556dacc, n_delay )
{
    if ( !isdefined( var_8556dacc ) )
    {
        var_8556dacc = undefined;
    }
    
    if ( !isdefined( n_delay ) )
    {
        n_delay = undefined;
    }
    
    var_253fcf81 = struct::get( var_3c3195e7, "targetname" );
    b_ok = 1;
    var_629f93f0 = [];
    a_actors = [];
    
    for ( i = 0; i < a_str_spawners.size ; i++ )
    {
        var_629f93f0[ i ] = getent( a_str_spawners[ i ], "targetname" );
        
        if ( !isdefined( var_629f93f0[ i ] ) )
        {
            b_ok = 0;
            continue;
        }
        
        a_actors[ i ] = spawner::simple_spawn_single( a_str_spawners[ i ] );
    }
    
    if ( isdefined( var_253fcf81 ) && b_ok )
    {
        var_2c4dc501 = var_253fcf81.scriptbundlename;
        var_253fcf81 thread function_e3b58585( a_actors );
        
        if ( isdefined( n_delay ) || isdefined( var_8556dacc ) )
        {
            var_253fcf81 scene::init( a_actors );
            
            if ( isdefined( var_8556dacc ) && flag::exists( var_8556dacc ) )
            {
                level flag::wait_till( var_8556dacc );
            }
            else if ( !flag::exists( var_8556dacc ) )
            {
                /#
                    iprintlnbold( "<dev string:xb0>" );
                #/
            }
            
            if ( isdefined( n_delay ) )
            {
                wait n_delay;
            }
        }
        
        var_7d90afcb = 1;
        
        foreach ( ai_actor in a_actors )
        {
            if ( !isalive( ai_actor ) )
            {
                var_7d90afcb = 0;
            }
        }
        
        if ( var_7d90afcb )
        {
            var_253fcf81 scene::play( a_actors );
        }
        
        return;
    }
    
    /#
        iprintlnbold( "<dev string:xe5>" );
    #/
}

// Namespace lotus_util
// Params 5
// Checksum 0xf24bd9e1, Offset: 0x3d30
// Size: 0x382
function function_c92cb5b( var_3c3195e7, var_b79165e6, var_fddd6a7f, str_key, var_2a151a84 )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "script_noteworthy";
    }
    
    if ( !isdefined( var_2a151a84 ) )
    {
        var_2a151a84 = undefined;
    }
    
    s_scene = struct::get( var_3c3195e7, "targetname" );
    var_2c4dc501 = s_scene.scriptbundlename;
    
    /#
        str_intro = var_2c4dc501 + "<dev string:x10b>" + var_b79165e6 + "<dev string:x10f>" + var_fddd6a7f;
        iprintlnbold( str_intro );
    #/
    
    v_death = s_scene.origin;
    a_enemies = getaiarray( var_fddd6a7f, str_key );
    ai_human = arraygetclosest( v_death, a_enemies );
    
    if ( isalive( ai_human ) )
    {
        ai_human ai::set_ignoreme( 1 );
        ai_human setgoal( v_death, 1 );
        ai_human.b_in_animation = 1;
        ai_human.goalradius = 48;
        ai_human waittill( #"goal" );
        
        if ( isdefined( var_2a151a84 ) )
        {
            level flag::wait_till( var_2a151a84 );
        }
        
        a_enemies = getaiarray( var_b79165e6, str_key );
        ai_robot = arraygetclosest( v_death, a_enemies );
        
        if ( isalive( ai_robot ) && isalive( ai_human ) )
        {
            ai_robot ai::set_ignoreall( 1 );
            ai_robot ai::set_ignoreme( 1 );
            ai_human setignoreent( ai_robot, 1 );
            ai_robot setignoreent( ai_human, 1 );
            ai_robot ai::set_behavior_attribute( "rogue_control_speed", "run" );
            ai_robot.b_in_animation = 1;
            a_enemies = array( ai_robot, ai_human );
            s_scene thread scene::play( a_enemies );
            
            while ( isalive( ai_robot ) && isalive( ai_human ) && s_scene scene::is_playing() )
            {
                wait 0.1;
            }
        }
    }
    
    if ( s_scene scene::is_playing() )
    {
        s_scene scene::stop();
    }
    
    if ( isalive( ai_robot ) )
    {
        ai_robot.b_end_fight = 1;
        ai_robot ai::set_ignoreall( 0 );
        ai_robot ai::set_ignoreme( 0 );
        ai_robot cleargoalvolume();
    }
    
    if ( isalive( ai_human ) )
    {
        ai_human ai::set_ignoreall( 0 );
        ai_human ai::set_ignoreme( 0 );
    }
}

// Namespace lotus_util
// Params 6
// Checksum 0x72bb0c19, Offset: 0x40c0
// Size: 0x1e2
function function_283fcbc5( var_3c3195e7, var_27f9c50e, var_2a151a84, n_delay, var_af5ecc04, str_endon )
{
    if ( !isdefined( var_2a151a84 ) )
    {
        var_2a151a84 = undefined;
    }
    
    if ( !isdefined( n_delay ) )
    {
        n_delay = undefined;
    }
    
    if ( !isdefined( var_af5ecc04 ) )
    {
        var_af5ecc04 = 0;
    }
    
    if ( !isdefined( str_endon ) )
    {
        str_endon = undefined;
    }
    
    ai_robot = spawner::simple_spawn_single( var_27f9c50e, &function_986d0100, "forced_level_2", 1 );
    s_cin = struct::get( var_3c3195e7, "targetname" );
    ai_robot ai::set_ignoreall( 1 );
    ai_robot ai::set_ignoreme( 1 );
    level.ai_hendricks setignoreent( ai_robot, 1 );
    
    if ( !var_af5ecc04 )
    {
        ai_robot setgoal( s_cin.origin, 1 );
        ai_robot waittill( #"goal" );
    }
    else
    {
        ai_robot teleport( s_cin.origin );
    }
    
    a_actors = array( level.ai_hendricks, ai_robot );
    a_actors = array( level.ai_hendricks, ai_robot );
    s_cin thread function_e3b58585( a_actors );
    
    if ( isdefined( var_2a151a84 ) || isdefined( n_delay ) )
    {
        s_cin scene::init( a_actors );
        
        if ( isdefined( var_2a151a84 ) )
        {
            flag::wait_till( var_2a151a84 );
        }
        
        if ( isdefined( n_delay ) && n_delay > 0 )
        {
            wait n_delay;
        }
    }
    
    s_cin scene::play( a_actors );
}

// Namespace lotus_util
// Params 4
// Checksum 0xf380e4d, Offset: 0x42b0
// Size: 0x172
function function_90b3f11f( var_a31fd6f4, str_target, n_range, str_endon )
{
    if ( !isdefined( n_range ) )
    {
        n_range = 300;
    }
    
    if ( !isdefined( str_endon ) )
    {
        str_endon = undefined;
    }
    
    ai_target = getent( str_target, "targetname" );
    
    if ( isdefined( ai_target ) )
    {
        if ( isspawner( ai_target ) )
        {
            ai_target = spawner::simple_spawn_single( str_target, &function_986d0100 );
        }
        
        if ( isactor( ai_target ) )
        {
            level.ai_hendricks setignoreent( ai_target, 1 );
            ai_target ai::force_goal( level.ai_hendricks );
            s_scene = struct::get( var_a31fd6f4, "targetname" );
            level thread function_bc628f1d( s_scene, level.ai_hendricks, ai_target, n_range, str_endon );
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x115>" + ai_target.targetname + "<dev string:x147>" );
            #/
        }
        
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x168>" + str_target + "<dev string:x190>" );
    #/
}

// Namespace lotus_util
// Params 5
// Checksum 0xed3dfb5b, Offset: 0x4430
// Size: 0x1ca
function function_bc628f1d( s_scene, ai_attacker, ai_target, n_range, str_endon )
{
    if ( !isdefined( n_range ) )
    {
        n_range = 300;
    }
    
    if ( !isdefined( str_endon ) )
    {
        str_endon = undefined;
    }
    
    if ( isdefined( str_endon ) )
    {
        self endon( str_endon );
    }
    
    while ( isalive( ai_attacker ) && isalive( ai_target ) && distance2d( ai_target.origin, ai_attacker.origin ) > n_range )
    {
        wait 0.1;
    }
    
    if ( isalive( ai_attacker ) && isalive( ai_target ) )
    {
        ai_target ai::force_goal( ai_target.origin, 100, 1 );
        s_scene.origin = ai_target.origin;
        s_scene.angles = ai_target.angles;
        a_actors = array( ai_attacker, ai_target );
        s_scene scene::init( s_scene.scriptbundlename, a_actors );
        s_scene thread scene::play( a_actors );
        
        while ( isalive( ai_attacker ) && isalive( ai_target ) )
        {
            wait 0.1;
        }
        
        if ( s_scene scene::is_playing() )
        {
            s_scene scene::stop();
        }
    }
}

// Namespace lotus_util
// Params 2
// Checksum 0xd9d7d728, Offset: 0x4608
// Size: 0x92
function function_986d0100( var_9bed3c76, b_sprint )
{
    if ( !isdefined( var_9bed3c76 ) )
    {
        var_9bed3c76 = "forced_level_2";
    }
    
    if ( !isdefined( b_sprint ) )
    {
        b_sprint = 0;
    }
    
    self endon( #"death" );
    self.goalradius = 512;
    
    if ( b_sprint )
    {
        self ai::set_behavior_attribute( "rogue_control_speed", "sprint" );
    }
    
    self ai::set_behavior_attribute( "rogue_allow_pregib", 0 );
    self ai::set_behavior_attribute( "rogue_control", var_9bed3c76 );
}

// Namespace lotus_util
// Params 5
// Checksum 0x47a63cc9, Offset: 0x46a8
// Size: 0x25a
function function_df89b05b( str_basename, var_177a81e1, str_flag, n_delay, str_endon )
{
    if ( !isdefined( var_177a81e1 ) )
    {
        var_177a81e1 = undefined;
    }
    
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0;
    }
    
    if ( !isdefined( str_endon ) )
    {
        str_endon = undefined;
    }
    
    if ( isdefined( str_endon ) )
    {
        self endon( str_endon );
    }
    
    ai_robot = spawner::simple_spawn_single( str_basename + "_robot", &function_986d0100, var_177a81e1 );
    ai_human = spawner::simple_spawn_single( str_basename + "_human" );
    ai_human ai::set_ignoreme( 1 );
    ai_robot ai::set_ignoreme( 1 );
    a_actors = array( ai_robot, ai_human );
    s_scene = struct::get( str_basename, "targetname" );
    s_scene thread function_c37d1015( ai_robot, ai_human );
    
    if ( function_91986f4b( a_actors ) )
    {
        s_scene scene::init( a_actors );
    }
    else
    {
        if ( isalive( ai_human ) )
        {
            ai_human ai::set_ignoreme( 0 );
        }
        
        if ( isalive( ai_robot ) )
        {
            ai_robot ai::set_ignoreme( 0 );
        }
        
        return;
    }
    
    if ( isdefined( str_flag ) && flag::exists( str_flag ) )
    {
        level flag::wait_till( str_flag );
    }
    
    if ( n_delay !== 0 )
    {
        wait n_delay;
    }
    
    if ( function_91986f4b( a_actors ) )
    {
        s_scene scene::play( a_actors );
    }
    
    if ( isalive( ai_human ) )
    {
        /#
            iprintln( "<dev string:x1a9>" + s_scene.targetname + "<dev string:x1b8>" );
        #/
        
        ai_human startragdoll();
        ai_human kill();
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0x7249e591, Offset: 0x4910
// Size: 0x83
function function_91986f4b( a_actors )
{
    var_7d90afcb = 1;
    
    foreach ( ai_actor in a_actors )
    {
        if ( !isdefined( ai_actor ) || !isalive( ai_actor ) )
        {
            var_7d90afcb = 0;
        }
    }
    
    return var_7d90afcb;
}

// Namespace lotus_util
// Params 2
// Checksum 0xaf30a635, Offset: 0x49a0
// Size: 0xf2
function function_c37d1015( ai_robot, ai_human )
{
    self endon( #"done" );
    
    while ( isalive( ai_robot ) && isalive( ai_human ) )
    {
        wait 0.05;
    }
    
    self scene::stop();
    
    if ( isalive( ai_human ) )
    {
        /#
            iprintlnbold( "<dev string:x1d3>" );
        #/
        
        ai_human startragdoll();
        ai_human kill();
    }
    
    if ( isalive( ai_robot ) )
    {
        /#
            iprintlnbold( "<dev string:x1f1>" );
        #/
        
        ai_robot ai::set_ignoreme( 0 );
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0x6fb2c0e2, Offset: 0x4aa0
// Size: 0xd2
function function_e3b58585( a_actors )
{
    self endon( #"done" );
    var_cde0e1c7 = 1;
    
    while ( var_cde0e1c7 )
    {
        foreach ( ai_actor in a_actors )
        {
            if ( !isalive( ai_actor ) )
            {
                var_cde0e1c7 = 0;
            }
        }
        
        wait 0.1;
    }
    
    self scene::stop();
    
    /#
        iprintln( "<dev string:x210>" );
        iprintln( "<dev string:x21c>" );
    #/
}

// Namespace lotus_util
// Params 0
// Checksum 0x56ae25b4, Offset: 0x4b80
// Size: 0x1a
function function_e58f5689()
{
    exploder::exploder( "fx_vista_read_int_haboob" );
}

// Namespace lotus_util
// Params 0
// Checksum 0xee2ebcb6, Offset: 0x4ba8
// Size: 0x1a
function function_176c92fd()
{
    exploder::exploder( "fx_vista_read_haboob1" );
}

// Namespace lotus_util
// Params 1
// Checksum 0xffeb21a8, Offset: 0x4bd0
// Size: 0x62
function function_f80cafbd( b_show )
{
    var_cb5f3fd1 = getent( "skybridge_cloud_coverage", "targetname" );
    
    if ( b_show )
    {
        var_cb5f3fd1 show();
        return;
    }
    
    var_cb5f3fd1 hide();
}

// Namespace lotus_util
// Params 2
// Checksum 0x35982eef, Offset: 0x4c40
// Size: 0x19a
function wait_to_delete( n_dist, n_delay )
{
    self endon( #"death" );
    b_can_delete = 0;
    
    if ( self flagsys::get( "scriptedanim" ) )
    {
        self flagsys::wait_till_clear( "scriptedanim" );
    }
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    while ( b_can_delete == 0 )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( isvehicle( self ) )
            {
                b_can_see_player = self vehcansee( player );
            }
            else if ( isactor( self ) )
            {
                b_can_see_player = self cansee( player );
            }
            else
            {
                assertmsg( "<dev string:x238>" );
                return;
            }
            
            if ( b_can_see_player == 0 && distance( self.origin, player.origin ) > n_dist && player util::is_player_looking_at( self.origin, undefined, 0 ) == 0 )
            {
                b_can_delete = 1;
            }
        }
    }
    
    self delete();
}

// Namespace lotus_util
// Params 2
// Checksum 0x154fe7d6, Offset: 0x4de8
// Size: 0x42
function function_27e365e2( str_notify, var_46368a9d )
{
    if ( self.team !== var_46368a9d )
    {
        self endon( #"death" );
        self endon( #"hash_9ac59272" );
        self waittill( str_notify );
        self function_3e9f1592();
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0x6518b13f, Offset: 0x4e38
// Size: 0x7b
function function_510331a4( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( ent.team == "axis" )
        {
            ent thread function_3e9f1592();
        }
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x3ff9e8fb, Offset: 0x4ec0
// Size: 0x6a
function function_3e9f1592()
{
    self endon( #"death" );
    
    while ( isdefined( self.current_scene ) )
    {
        wait 0.05;
    }
    
    if ( isdefined( self ) )
    {
        self util::stop_magic_bullet_shield();
        self notsolid();
        self startragdoll( 1 );
        self kill();
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x6b8922d3, Offset: 0x4f38
// Size: 0x7a
function function_5b57004a()
{
    self endon( #"death" );
    self waittill( #"damage", n_damage, e_attacker );
    wait 0.05;
    self util::stop_magic_bullet_shield();
    self notsolid();
    self startragdoll( 1 );
    self kill( self.origin, e_attacker );
}

// Namespace lotus_util
// Params 0
// Checksum 0x6dcab45a, Offset: 0x4fc0
// Size: 0x52
function function_a7dc2319()
{
    while ( !isdefined( self.finished_scene ) )
    {
        wait 0.05;
    }
    
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self thread wait_to_delete( 500 );
}

// Namespace lotus_util
// Params 1
// Checksum 0xa4daf454, Offset: 0x5020
// Size: 0xa3
function function_484bc3aa( b_enable )
{
    level flag::wait_till( "all_players_spawned" );
    var_9dff5377 = b_enable ? 1 : 0;
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "player_dust_fx", var_9dff5377 );
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x72b56d93, Offset: 0x50d0
// Size: 0xc9
function corpse_cleanup()
{
    var_b18bb272 = [];
    
    foreach ( e_corpse in getcorpsearray() )
    {
        if ( isdefined( e_corpse.birthtime ) && e_corpse.birthtime + 200000 < gettime() )
        {
            var_b18bb272[ var_b18bb272.size ] = e_corpse;
        }
    }
    
    for ( index = 0; index < var_b18bb272.size ; index++ )
    {
        var_b18bb272[ index ] delete();
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x4852c7bf, Offset: 0x51a8
// Size: 0x105
function its_raining_men()
{
    level notify( #"raining_men" );
    level endon( #"raining_men" );
    
    if ( level.skipto_point == "mobile_shop_ride2" || level.skipto_point == "bridge_battle" || level.skipto_point == "up_to_detention_center" || level.skipto_point == "stand_down" || level.skipto_point == "pursuit" )
    {
        level thread function_a76d24ab();
    }
    
    while ( true )
    {
        a_drops = struct::get_array( "corpse_drop" );
        s_drop = a_drops[ randomint( a_drops.size ) ];
        function_fe64b86b( "rainman", s_drop );
        wait randomfloatrange( 8, 17 );
    }
}

// Namespace lotus_util
// Params 3
// Checksum 0xd0e6c683, Offset: 0x52b8
// Size: 0xe2
function function_fe64b86b( str_targetname, s_struct, b_randomize )
{
    if ( !isdefined( b_randomize ) )
    {
        b_randomize = 1;
    }
    
    ai_corpse = spawner::simple_spawn_single( str_targetname );
    
    if ( !isdefined( ai_corpse ) )
    {
        return;
    }
    
    if ( b_randomize )
    {
        ai_corpse forceteleport( s_struct.origin + ( randomintrange( -200, -56 ), randomintrange( -200, -56 ), 0 ), s_struct.angles );
    }
    else
    {
        ai_corpse forceteleport( s_struct.origin, s_struct.angles );
    }
    
    ai_corpse startragdoll();
    ai_corpse kill();
}

// Namespace lotus_util
// Params 0
// Checksum 0x85ae2dc0, Offset: 0x53a8
// Size: 0xd5
function function_a76d24ab()
{
    level endon( #"raining_men" );
    
    while ( true )
    {
        a_corpses = getcorpsearray();
        n_current_time = gettime();
        
        foreach ( e_corpse in a_corpses )
        {
            if ( e_corpse.origin[ 2 ] > 18500 )
            {
                if ( n_current_time - e_corpse.birthtime > 5500 )
                {
                    e_corpse delete();
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace lotus_util
// Params 3
// Checksum 0x738d951f, Offset: 0x5488
// Size: 0x19f
function function_a516f0de( str_targetname, var_f2ce48d2, var_9fd93917 )
{
    if ( !isdefined( var_f2ce48d2 ) )
    {
        var_f2ce48d2 = 7;
    }
    
    if ( !isdefined( var_9fd93917 ) )
    {
        var_9fd93917 = 3;
    }
    
    level endon( #"hash_fb8a92fd" );
    level notify( #"hash_c087d549", 1 );
    function_b9976e82();
    level flag::wait_till( "all_players_spawned" );
    var_522ce6c6 = 0;
    wait 1;
    
    while ( true )
    {
        var_50042eb8 = getentarray( str_targetname, "targetname" );
        
        if ( var_50042eb8.size == 0 )
        {
            return;
        }
        
        if ( var_50042eb8[ 0 ].script_parameters === "vertical" )
        {
            var_1c660783 = array( 2, 4, 5 );
        }
        else
        {
            var_1c660783 = array( 1, 3, 6 );
        }
        
        var_983e0b02 = "cp_lotus_projection_ravengrafitti" + var_1c660783[ randomint( var_1c660783.size ) ];
        level thread function_545a568f( var_f2ce48d2, var_983e0b02 );
        videostart( var_983e0b02 );
        function_67212ab4( var_50042eb8, 1 );
        var_522ce6c6++;
        level waittill( #"hash_c087d549", var_90bf3c0b );
        
        if ( var_90bf3c0b === 1 || var_522ce6c6 >= var_9fd93917 )
        {
            videostop( var_983e0b02 );
            function_67212ab4( var_50042eb8, 1 );
            return;
        }
    }
}

// Namespace lotus_util
// Params 2
// Checksum 0x7468ed79, Offset: 0x5630
// Size: 0x67
function function_545a568f( var_f2ce48d2, var_983e0b02 )
{
    level endon( #"hash_c087d549" );
    
    if ( var_f2ce48d2 < 3 )
    {
        var_f2ce48d2 = 3 + 1;
    }
    
    wait 5;
    wait randomintrange( 3, var_f2ce48d2 + 1 );
    videostop( var_983e0b02 );
    wait 1;
    level notify( #"hash_c087d549" );
}

// Namespace lotus_util
// Params 0
// Checksum 0xd99c82f8, Offset: 0x56a0
// Size: 0x42
function function_b9976e82()
{
    var_50042eb8 = getentarray( "raven_video_loc", "script_noteworthy" );
    function_67212ab4( var_50042eb8, 0 );
}

// Namespace lotus_util
// Params 3
// Checksum 0x31b5fa6d, Offset: 0x56f0
// Size: 0x182
function function_511cba45( str_identifier, n_delay, var_983e0b02 )
{
    level endon( #"hash_fb8a92fd" );
    level notify( #"hash_c18cb916" );
    function_b9976e82();
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    var_cb3e8a32 = getentarray( "raven_video_loc", "script_noteworthy" );
    var_50042eb8 = [];
    
    foreach ( e_loc in var_cb3e8a32 )
    {
        if ( isstring( e_loc.targetname ) && issubstr( e_loc.targetname, str_identifier ) )
        {
            array::add( var_50042eb8, e_loc );
        }
    }
    
    if ( !isdefined( var_983e0b02 ) )
    {
        var_983e0b02 = "cp_lotus_projection_ravengrafitti" + randomintrange( 1, 6 );
    }
    
    videostart( var_983e0b02 );
    function_67212ab4( var_50042eb8, 1 );
    wait 7;
    videostop( var_983e0b02 );
    function_67212ab4( var_50042eb8, 0 );
}

// Namespace lotus_util
// Params 3
// Checksum 0x62ea6d98, Offset: 0x5880
// Size: 0x17b
function function_67212ab4( var_50042eb8, b_show, b_remove )
{
    if ( !isdefined( b_remove ) )
    {
        b_remove = 0;
    }
    
    if ( b_show )
    {
        foreach ( e_loc in var_50042eb8 )
        {
            if ( isdefined( e_loc ) )
            {
                if ( e_loc.script_string === "decal" )
                {
                    e_loc clientfield::set( "raven_decal", 1 );
                    continue;
                }
                
                e_loc show();
            }
        }
        
        return;
    }
    
    foreach ( e_loc in var_50042eb8 )
    {
        if ( isdefined( e_loc ) )
        {
            if ( e_loc.script_string === "decal" )
            {
                if ( b_remove )
                {
                    e_loc.script_noteworthy = undefined;
                }
                
                e_loc clientfield::set( "raven_decal", 0 );
                continue;
            }
            
            if ( b_remove )
            {
                e_loc delete();
                continue;
            }
            
            e_loc hide();
        }
    }
}

// Namespace lotus_util
// Params 4
// Checksum 0xf152e166, Offset: 0x5a08
// Size: 0x2aa
function function_e577c596( var_a55eb7ca, trigger, var_c1afab5f, var_983e0b02 )
{
    if ( isdefined( trigger ) )
    {
        trigger trigger::wait_till();
    }
    
    foreach ( player in level.players )
    {
        player thread function_c90abe1a();
        visionset_mgr::activate( "visionset", "cp_raven_hallucination", player );
        player playsoundtoplayer( "vox_dying_infected_after", player );
        player playsoundtoplayer( "evt_dni_interrupt", player );
    }
    
    a_scenes = struct::get_array( var_a55eb7ca );
    
    foreach ( s_scene in a_scenes )
    {
        if ( s_scene.scriptbundlename === "cin_gen_traversal_raven_fly_away" )
        {
            s_scene util::delay( randomfloat( 5 ), undefined, &scene::play );
            continue;
        }
        
        s_scene thread scene::play();
    }
    
    if ( isdefined( var_c1afab5f ) )
    {
        level thread function_511cba45( var_c1afab5f, undefined, var_983e0b02 );
    }
    
    wait 7;
    
    foreach ( player in level.players )
    {
        player thread function_c90abe1a();
        player playsoundtoplayer( "evt_dni_interrupt", player );
        util::delay( 0.75, undefined, &visionset_mgr::deactivate, "visionset", "cp_raven_hallucination", player );
    }
    
    level thread scene::stop( var_a55eb7ca, "targetname" );
    
    if ( isdefined( var_983e0b02 ) )
    {
        videostop( var_983e0b02 );
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x4e794fab, Offset: 0x5cc0
// Size: 0x62
function function_c90abe1a()
{
    self endon( #"death" );
    self clientfield::increment_to_player( "postfx_ravens", 1 );
    self clientfield::set_to_player( "hijack_static_effect", 1 );
    wait 0.5;
    self clientfield::set_to_player( "hijack_static_effect", 0 );
}

// Namespace lotus_util
// Params 0
// Checksum 0xa8bda893, Offset: 0x5d30
// Size: 0x10a
function function_77bfc3b2()
{
    level scene::add_scene_func( "cin_gen_ambient_raven_idle", &function_e547724d, "init" );
    level scene::add_scene_func( "cin_gen_ambient_raven_idle_eating_raven", &function_e547724d, "init" );
    level scene::add_scene_func( "cin_gen_traversal_raven_fly_away", &function_e547724d, "init" );
    level scene::add_scene_func( "cin_gen_ambient_raven_idle", &function_3f6f483d );
    level scene::add_scene_func( "cin_gen_ambient_raven_idle_eating_raven", &function_3f6f483d );
    level scene::add_scene_func( "cin_gen_traversal_raven_fly_away", &function_86b1cd8a );
}

// Namespace lotus_util
// Params 1
// Checksum 0x619ed7da, Offset: 0x5e48
// Size: 0x22
function function_e547724d( a_ents )
{
    a_ents[ "raven" ] hide();
}

// Namespace lotus_util
// Params 1
// Checksum 0xf95b2926, Offset: 0x5e78
// Size: 0x22
function function_3f6f483d( a_ents )
{
    a_ents[ "raven" ] show();
}

// Namespace lotus_util
// Params 1
// Checksum 0x7ed8ba6d, Offset: 0x5ea8
// Size: 0x6a
function function_86b1cd8a( a_ents )
{
    if ( self.targetname === "hakim_door_raven_fly_away" )
    {
        return;
    }
    
    a_ents[ "raven" ] ghost();
    a_ents[ "raven" ] waittill( #"hash_db8335ba" );
    a_ents[ "raven" ] show();
}

// Namespace lotus_util
// Params 1
// Checksum 0x8ea8c3b7, Offset: 0x5f20
// Size: 0xfa
function function_78805698( str_location )
{
    foreach ( player in level.activeplayers )
    {
        player util::delay( 1.5, undefined, &clientfield::set, "player_frost_breath", 1 );
        player thread function_5157e72f( str_location );
    }
    
    callback::on_spawned( &function_6edd9874 );
    callback::on_spawned( &function_5157e72f );
    level.ai_hendricks clientfield::set( "hendricks_frost_breath", 1 );
}

// Namespace lotus_util
// Params 0
// Checksum 0x845cc78b, Offset: 0x6028
// Size: 0x42
function function_6edd9874()
{
    self clientfield::set( "player_frost_breath", 1 );
    
    if ( self.var_6e127f9d === 1 )
    {
        self clientfield::set_to_player( "frost_post_fx", 1 );
    }
}

// Namespace lotus_util
// Params 1
// Checksum 0xed6b9d36, Offset: 0x6078
// Size: 0x22b
function function_5157e72f( str_location )
{
    if ( !isdefined( str_location ) )
    {
        str_location = "";
    }
    
    self endon( #"death" );
    trigger = getent( "trig_snow_fog_begin_" + str_location, "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger trigger::wait_till( undefined, undefined, self );
    }
    
    if ( self.var_6e127f9d !== 0 )
    {
        self util::delay( 1.5, undefined, &clientfield::set_to_player, "frost_post_fx", 1 );
    }
    
    level notify( #"hash_23be1ef" );
    self clientfield::set_to_player( "snow_fog", 1 );
    self clientfield::set_to_player( "player_dust_fx", 0 );
    self clientfield::increment_to_player( "postfx_frozen_forest", 1 );
    self.var_4cf41af4 = 1;
    
    if ( self flag::exists( "end_snow_fx" ) )
    {
        self flag::clear( "end_snow_fx" );
    }
    else
    {
        self flag::init( "end_snow_fx" );
    }
    
    self playsound( "evt_dni_glitch" );
    self playloopsound( "evt_snowverlay" );
    
    if ( self.var_5b9f1ca7 !== 1 )
    {
        self thread function_c7402e23();
    }
    
    trigger = getent( "trig_snow_fog_end_" + str_location, "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger trigger::wait_till( undefined, undefined, self );
        self thread function_3684f44b();
        self function_f21ea22f();
        self stoploopsound( 1 );
        self playsound( "evt_dni_delusion_outro" );
        level notify( #"hash_d77cf6d0" );
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0xbba9fe27, Offset: 0x62b0
// Size: 0xe1
function function_f21ea22f()
{
    self clientfield::set( "player_frost_breath", 0 );
    
    if ( !self flag::exists( "end_snow_fx" ) )
    {
        self flag::init( "end_snow_fx" );
        level flag::init( "end_snow_videos" );
    }
    
    self flag::set( "end_snow_fx" );
    level flag::set( "end_snow_videos" );
    self clientfield::set_to_player( "snow_fog", 0 );
    self clientfield::set_to_player( "frost_post_fx", 0 );
    self clientfield::set_to_player( "player_dust_fx", 1 );
    self.var_4cf41af4 = undefined;
}

// Namespace lotus_util
// Params 0
// Checksum 0x72543369, Offset: 0x63a0
// Size: 0x85
function function_c7402e23()
{
    self notify( #"hash_7507ad85" );
    self endon( #"hash_7507ad85" );
    self endon( #"hash_d3d93f76" );
    self endon( #"death" );
    self thread function_f15e5e64();
    self.var_5b9f1ca7 = 1;
    
    do
    {
        playfxoncamera( level._effect[ "fx_snow_lotus" ], ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
        wait 0.05;
    }
    while ( !self flag::get( "end_snow_fx" ) );
}

// Namespace lotus_util
// Params 0
// Checksum 0xfdf91ed, Offset: 0x6430
// Size: 0x6d
function function_f15e5e64()
{
    self endon( #"hash_7507ad85" );
    self endon( #"end_snow_fx" );
    self endon( #"death" );
    
    while ( true )
    {
        trigger::wait_till( "trig_pause_snow_camera_fx", undefined, undefined, 0 );
        self notify( #"hash_d3d93f76" );
        trigger::wait_till( "trig_snow_fog_begin_pursuit", undefined, undefined, 0 );
        self thread function_c7402e23();
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0x5669f2f1, Offset: 0x64a8
// Size: 0xc5
function function_cf37ec3()
{
    if ( !level flag::exists( "end_snow_videos" ) )
    {
        level flag::init( "end_snow_videos" );
    }
    
    while ( !level flag::get( "end_snow_videos" ) )
    {
        for ( i = 1; i < 5 ; i++ )
        {
            var_983e0b02 = "cp_lotus_projection_salem" + i;
            videostart( var_983e0b02 );
            wait randomintrange( 3, 5 ) + 5;
            videostop( var_983e0b02 );
            wait 1.5;
        }
    }
}

// Namespace lotus_util
// Params 0
// Checksum 0xa3b11f6b, Offset: 0x6578
// Size: 0x42
function function_3684f44b()
{
    self endon( #"death" );
    self clientfield::set_to_player( "hijack_static_effect", 1 );
    wait 1.2;
    self clientfield::set_to_player( "hijack_static_effect", 0 );
}

