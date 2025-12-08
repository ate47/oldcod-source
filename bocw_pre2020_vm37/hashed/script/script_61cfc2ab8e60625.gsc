#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\util;

#namespace namespace_b100dd86;

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x7bede48, Offset: 0x3f0
// Size: 0x34
function init_clientfields()
{
    clientfield::register( "toplayer", "lerp_fov", 1, 3, "int" );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0xdb919af6, Offset: 0x430
// Size: 0xa2
function function_9109a1fe()
{
    level.adler = self;
    self.radius = 32;
    level thread util::magic_bullet_shield( self );
    a_ar = getweapon( #"hash_4ff481a4f55ed901" );
    self setweapon( a_ar );
    self ai::set_behavior_attribute( "useGrenades", 0 );
    self.script_forcecolor = "o";
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x3d2317ec, Offset: 0x4e0
// Size: 0x62
function function_87d56d50()
{
    level.woods = self;
    self.radius = 32;
    self ai::set_behavior_attribute( "useGrenades", 0 );
    level thread util::magic_bullet_shield( self );
    self.script_forcecolor = "c";
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x76183c7f, Offset: 0x550
// Size: 0xfc
function function_b61ea696()
{
    self.radius = 32;
    self.ignoresuppression = 1;
    self.forcesprint = 1;
    self val::set( "sprinter_guy", "ignoreme", 1 );
    self val::set( "sprinter_guy", "ignoreall", 1 );
    self ai::set_behavior_attribute( "sprint", 1 );
    self waittill( #"goal" );
    self val::reset( "sprinter_guy", "ignoreme" );
    self val::reset( "sprinter_guy", "ignoreall" );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0xf896032, Offset: 0x658
// Size: 0x44
function function_ea49bc9()
{
    level.wife = self;
    self.radius = 32;
    self.ignoreall = 1;
    level thread util::magic_bullet_shield( self );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x25ce4217, Offset: 0x6a8
// Size: 0x2a
function function_c3eb1449()
{
    level.police_chief = self;
    self.ignoreall = 1;
    self.ignoreme = 1;
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0xc395d641, Offset: 0x6e0
// Size: 0x10
function function_170c5fef()
{
    level.var_cb7eb1d8 = self;
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 2
// Checksum 0x1edfc067, Offset: 0x6f8
// Size: 0x44
function function_f82142f8( notify_str, body_model )
{
    if ( isdefined( notify_str ) )
    {
        level waittill( notify_str );
    }
    
    self setmodel( body_model );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 2
// Checksum 0x9b428d63, Offset: 0x748
// Size: 0xa2
function swap_head( notify_str, head_model )
{
    if ( isdefined( notify_str ) )
    {
        level waittill( notify_str );
    }
    
    if ( isdefined( self.hatmodel ) )
    {
        self detach( self.hatmodel );
    }
    
    if ( isdefined( self.head ) )
    {
        self detach( self.head );
    }
    
    self attach( head_model );
    self.head = head_model;
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0xe47a0799, Offset: 0x7f8
// Size: 0x1d4
function function_6578b894()
{
    self endon( #"death" );
    level notify( #"hash_530a04ce72c2c9" );
    self thread function_a0f1fa27();
    objectives::follow( "obj_takedown_qasim", self, undefined, undefined, 0, #"hash_29f1e9a2d045faaf" );
    self val::set( #"qasim", "ignoreall", 1 );
    self val::set( #"qasim", "ignoreme", 1 );
    self.forcesprint = 1;
    self disableaimassist();
    lmg = getweapon( #"lmg_light_t9" );
    self setweapon( lmg );
    self thread set_ignoreall();
    self thread function_b1518d0e();
    self waittill( #"reached_path_end" );
    objectives::remove( "obj_takedown_qasim" );
    level thread function_c212022b( 30 );
    self notify( #"hash_637416a1c8f37fe3" );
    self deletedelay();
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 1
// Checksum 0xdfd63213, Offset: 0x9d8
// Size: 0x4c
function function_c212022b( seconds )
{
    level endon( #"hash_530a04ce72c2c9" );
    wait seconds;
    util::missionfailedwrapper( #"hash_556f31329ba0db54" );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x89780504, Offset: 0xa30
// Size: 0x154
function function_a66feb27()
{
    self thread function_a0f1fa27();
    level notify( #"hash_530a04ce72c2c9" );
    objectives::follow( "obj_takedown_qasim", self, undefined, undefined, 0, #"hash_29f1e9a2d045faaf" );
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.forcesprint = 1;
    self disableaimassist();
    self ai::set_behavior_attribute( "sprint", 1 );
    level thread scene::play( "scene_tkd_hit2_qasim_vault", "Vault", self );
    self waittill( #"end_vault" );
    objectives::hide( "obj_takedown_qasim" );
    self notify( #"hash_637416a1c8f37fe3" );
    self deletedelay();
    level thread function_a3c6d04c();
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x48e42d4a, Offset: 0xb90
// Size: 0x9c
function function_a3c6d04c()
{
    objloc = struct::get( "obj_jump", "targetname" );
    objectives::follow( "obj_rooftop_jump", objloc.origin, undefined, undefined, 0, #"hash_579ea815337d21d3" );
    level flag::wait_till( "flag_start_roof_slide" );
    objectives::remove( "obj_rooftop_jump" );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0xff287689, Offset: 0xc38
// Size: 0x4c
function function_b1518d0e()
{
    self flag::wait_till( "ignoreall_false" );
    self val::reset( #"qasim", "ignoreall" );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x62097454, Offset: 0xc90
// Size: 0x54
function set_ignoreall()
{
    self flag::wait_till( "ignoreall_true" );
    self val::set( #"qasim", "ignoreall", 1 );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x6b6c4f63, Offset: 0xcf0
// Size: 0x4c
function function_a0f1fa27()
{
    self endon( #"hash_637416a1c8f37fe3" );
    self waittill( #"death" );
    util::missionfailedwrapper( #"hash_acfc290b8145de6" );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 1
// Checksum 0x2d5e5a5c, Offset: 0xd48
// Size: 0x13a
function function_3e6a0d68( str_aigroup )
{
    var_523ed269 = getspawnerarray( str_aigroup, "script_aigroup" );
    aiarray = array();
    
    foreach ( spawner in var_523ed269 )
    {
        guy = spawner spawner::spawn( 1 );
        
        if ( !isdefined( aiarray ) )
        {
            aiarray = [];
        }
        else if ( !isarray( aiarray ) )
        {
            aiarray = array( aiarray );
        }
        
        aiarray[ aiarray.size ] = guy;
    }
    
    return aiarray;
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 2
// Checksum 0x9587def5, Offset: 0xe90
// Size: 0x7c
function function_53531f27( key, val = "targetname" )
{
    trig = getent( key, val );
    
    if ( isdefined( trig ) && trig istriggerenabled() )
    {
        trig trigger::use();
    }
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x4e5377b3, Offset: 0xf18
// Size: 0x2d0
function function_5431431d()
{
    plane = getent( "cargo_plane", "targetname" );
    plane notsolid();
    things = getentarray( "af_plane_triggers", "targetname" );
    things = arraycombine( things, getentarray( "plane_floor_clip", "targetname" ) );
    things = arraycombine( things, getentarray( "plane_cargo", "targetname" ) );
    
    foreach ( thing in things )
    {
        thing enablelinkto();
        thing linkto( plane, "tag_body_animate" );
    }
    
    plane cp_takedown_fx::function_8e4c996d();
    plane cp_takedown_fx::function_b6cccb8();
    scene::add_scene_func( "scene_tkd_hit3_chase_plane", &function_d804fc99, "init" );
    plane thread scene::init( "scene_tkd_hit3_chase_plane" );
    thread function_d60a1c78( plane );
    level.af_plane = plane;
    thread scene::init( "scene_tkd_hit3_intro_overlook_arash", [ level.af_plane ] );
    level.var_c7b3a621 = util::spawn_model( "tag_origin", plane.origin - ( 200, 0, 175 ), plane.angles );
    level.var_c7b3a621 linkto( plane );
    function_c8381339( plane, 1 );
    return plane;
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 1
// Checksum 0x409c7af1, Offset: 0x11f0
// Size: 0x148
function function_d804fc99( a_ents )
{
    var_936fb5e7 = [ "Prop 1", "Prop 2", "Prop 3", "Prop 4" ];
    
    foreach ( prop in var_936fb5e7 )
    {
        if ( isdefined( a_ents[ prop ] ) && !isdefined( a_ents[ prop ].clip ) )
        {
            clip = getent( prop, "script_noteworthy" );
            a_ents[ prop ].clip = clip;
            clip linkto( a_ents[ prop ], undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
    }
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 2
// Checksum 0x123e2ed3, Offset: 0x1340
// Size: 0x33c
function function_c8381339( plane, var_857b0901 )
{
    probe = getent( "cargo_probe_1", "targetname" );
    
    if ( isdefined( probe ) )
    {
        probe linkto( plane, "tag_body_animate", ( -24, 0, 24 ), ( 0, 0, 0 ) );
    }
    
    probe = getent( "cargo_probe_2", "targetname" );
    
    if ( isdefined( probe ) )
    {
        probe linkto( plane, "tag_body_animate", ( -152, 0, 24 ), ( 0, 0, 0 ) );
    }
    
    probe = getent( "cargo_probe_3", "targetname" );
    
    if ( isdefined( probe ) )
    {
        probe linkto( plane, "tag_body_animate", ( -288, 0, 24 ), ( 0, 0, 0 ) );
    }
    
    probe = getent( "cargo_probe_4", "targetname" );
    
    if ( isdefined( probe ) )
    {
        probe linkto( plane, "tag_body_animate", ( -408, 0, -40 ), ( 0, 0, 0 ) );
    }
    
    if ( var_857b0901 )
    {
        probe = getent( "cargo_probe_5", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( -72, 0, -88 ), ( 0, 0, 0 ) );
        }
        
        probe = getent( "cargo_probe_6", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( 72, 280, -48 ), ( 0, 0, 0 ) );
        }
        
        probe = getent( "cargo_probe_7", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( 72, -280, -48 ), ( 0, 0, 0 ) );
        }
        
        probe = getent( "cargo_probe_8", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( -664, 200, -40 ), ( 0, 0, 0 ) );
        }
        
        probe = getent( "cargo_probe_9", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( -664, -200, -40 ), ( 0, 0, 0 ) );
        }
    }
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 1
// Checksum 0x35f95b9f, Offset: 0x1688
// Size: 0x64
function function_1c77193b( plane )
{
    level waittill( #"hash_1e1d8f91cb3b7e82" );
    plane cp_takedown_fx::function_675a8b8c();
    self waittill( #"start_slowmo" );
    plane cp_takedown_fx::function_ee23b003();
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 1
// Checksum 0x2db9986, Offset: 0x16f8
// Size: 0x6c
function function_d60a1c78( plane )
{
    wait 0.2;
    level.plane_mover = util::spawn_model( "tag_origin", plane.origin, plane.angles );
    plane linkto( level.plane_mover, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0xd3c6802b, Offset: 0x1770
// Size: 0xb8
function function_19919872()
{
    level.var_2e151cca = spawner::simple_spawn( "af_plane_guy" );
    
    foreach ( guy in level.var_2e151cca )
    {
        guy linkto( level.af_plane, "tag_body_animate" );
    }
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 1
// Checksum 0xf0f6e102, Offset: 0x1830
// Size: 0x11a
function setup_objectives( var_567f1ddd )
{
    switch ( var_567f1ddd )
    {
        case #"tkdn_heli_intro":
            level waittill( #"hash_428d72621587561a" );
        case #"tkdn_heli_convoy_aslt":
        case #"hash_75cfe0319f9e4615":
            objectives::scripted( "send_message", undefined, #"hash_793880ddf4ae5fc5", 0 );
            objectives::scripted( "hit1", undefined, #"hash_18dde4667d1baf57", 0 );
            objectives::function_6a5ca7ac( "hit1", undefined, "send_message" );
            break;
        default:
            objectives::scripted( "send_message", undefined, #"hash_793880ddf4ae5fc5", 0 );
            break;
    }
}

// Namespace namespace_b100dd86/namespace_5713a15b
// Params 0
// Checksum 0x443a4218, Offset: 0x1958
// Size: 0x44
function function_5aabc3fb()
{
    ents = getentarray( "intro_runway_lights", "targetname" );
    array::delete_all( ents );
}

