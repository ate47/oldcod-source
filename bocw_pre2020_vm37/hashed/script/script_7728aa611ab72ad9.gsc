#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_307260b8;

// Namespace namespace_307260b8/namespace_f80fca07
// Params 3
// Checksum 0xea61f9db, Offset: 0x100
// Size: 0x172
function spawn_allies( var_58d5c920, str_key = "targetname", var_e565b364 = 0 )
{
    a_ai = [];
    a_spawners = getentarray( var_58d5c920, str_key );
    
    foreach ( spawner in a_spawners )
    {
        ai = spawner::simple_spawn_single( spawner );
        
        if ( isdefined( ai ) )
        {
            if ( var_e565b364 )
            {
                ai util::magic_bullet_shield();
            }
            
            if ( !isdefined( a_ai ) )
            {
                a_ai = [];
            }
            else if ( !isarray( a_ai ) )
            {
                a_ai = array( a_ai );
            }
            
            a_ai[ a_ai.size ] = ai;
        }
    }
    
    return a_ai;
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 2
// Checksum 0xdb949b4c, Offset: 0x280
// Size: 0x1c2
function function_2683ec5d( var_58d5c920, str_key = "targetname" )
{
    ai_woods = getent( "hero_woods", "targetname", 1 );
    
    if ( !isalive( ai_woods ) )
    {
        var_5b7b93ad = getent( var_58d5c920, str_key );
        
        if ( isdefined( var_5b7b93ad ) )
        {
            ai_woods = spawner::simple_spawn_single( var_5b7b93ad );
            assert( isdefined( ai_woods ) && isalive( ai_woods ) );
            
            if ( !isdefined( level.allies ) )
            {
                level.allies = [];
            }
            else if ( !isarray( level.allies ) )
            {
                level.allies = array( level.allies );
            }
            
            if ( !isinarray( level.allies, ai_woods ) )
            {
                level.allies[ level.allies.size ] = ai_woods;
            }
            
            ai_woods util::magic_bullet_shield();
            ai_woods.script_friendname = "Woods";
            ai_woods.targetname = "hero_woods";
            ai_woods.goalradius = 16;
        }
    }
    
    return ai_woods;
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 3
// Checksum 0x4cab3e82, Offset: 0x450
// Size: 0x6c
function function_85939627( ai_array, var_335a8dcc, var_91e1c669 )
{
    if ( !isdefined( var_91e1c669 ) || var_91e1c669 > ai_array.size )
    {
        var_91e1c669 = ai_array.size;
    }
    
    ai::waittill_dead_or_dying( ai_array, var_91e1c669 );
    flag::set( var_335a8dcc );
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 1
// Checksum 0x183b6487, Offset: 0x4c8
// Size: 0x64
function function_2b6287f4( str_targetname )
{
    t_trigger = getent( str_targetname, "targetname" );
    t_trigger endon( #"death" );
    t_trigger waittill( #"trigger" );
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 6
// Checksum 0x75dd35ec, Offset: 0x538
// Size: 0xac
function function_14ed6910( var_40797835, var_3e03fc9e, var_b7977404, var_4c8979d, var_15e3405a, var_27a72999 )
{
    s_info = { #var_40797835:var_40797835, #var_3e03fc9e:var_3e03fc9e, #var_b7977404:var_b7977404, #var_4c8979d:var_4c8979d, #var_15e3405a:var_15e3405a, #var_27a72999:var_27a72999 };
    return s_info;
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 3
// Checksum 0xf5fcdd3e, Offset: 0x5f0
// Size: 0x1c4
function function_cc05cde5( str_targetname, str_endon, s_info )
{
    level endon( str_endon, #"end_game" );
    var_73ff4480 = getentarray( str_targetname, "targetname" );
    n_spawn_count = 0;
    var_9fae15e6 = randomintrangeinclusive( s_info.var_40797835, s_info.var_3e03fc9e );
    
    while ( true )
    {
        var_73ff4480 = array::randomize( var_73ff4480 );
        
        foreach ( var_a39c6b5d in var_73ff4480 )
        {
            spawner::simple_spawn( var_a39c6b5d );
            n_spawn_count++;
            
            if ( n_spawn_count >= var_9fae15e6 )
            {
                n_spawn_count = 0;
                var_9fae15e6 = randomintrangeinclusive( s_info.var_40797835, s_info.var_3e03fc9e );
                wait randomfloatrange( s_info.var_15e3405a, s_info.var_27a72999 );
                continue;
            }
            
            wait randomfloatrange( s_info.var_b7977404, s_info.var_4c8979d );
        }
    }
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 2
// Checksum 0x196548, Offset: 0x7c0
// Size: 0xac
function function_10223871( str_volume, var_39a39241 = 0 )
{
    self endon( #"death" );
    vol_fallback = getent( str_volume, "targetname" );
    self ai::force_goal( vol_fallback, 0 );
    
    if ( var_39a39241 )
    {
        self waittill( #"goal" );
        self deletedelay();
    }
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 1
// Checksum 0x2b6ea11a, Offset: 0x878
// Size: 0x54
function function_ef432971( b_on = 1 )
{
    level.player notify( #"hash_11cfa7c80189fe2d" );
    
    if ( b_on )
    {
        level.player thread function_f3dbf0a0();
    }
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 0, eflags: 0x4
// Checksum 0x5aaad096, Offset: 0x8d8
// Size: 0x7e
function private function_f3dbf0a0()
{
    self endon( #"death", #"hash_11cfa7c80189fe2d" );
    
    while ( true )
    {
        w_current = self getcurrentweapon();
        self setweaponammoclip( w_current, w_current.clipsize );
        wait 1;
    }
}

// Namespace namespace_307260b8/namespace_f80fca07
// Params 0
// Checksum 0x12fb6663, Offset: 0x960
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

// Namespace namespace_307260b8/namespace_f80fca07
// Params 0
// Checksum 0x6cd4f59d, Offset: 0xa20
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

// Namespace namespace_307260b8/namespace_f80fca07
// Params 0
// Checksum 0x17e24bf5, Offset: 0xa70
// Size: 0xb6
function function_7d7f8f59()
{
    self endon( #"death" );
    self notify( "78d9de7174daa9b0" );
    self endon( "78d9de7174daa9b0" );
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

// Namespace namespace_307260b8/namespace_f80fca07
// Params 0
// Checksum 0x706f1c66, Offset: 0xb30
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

// Namespace namespace_307260b8/namespace_f80fca07
// Params 0
// Checksum 0x8780269, Offset: 0xbd8
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

// Namespace namespace_307260b8/namespace_f80fca07
// Params 2
// Checksum 0xaa384f02, Offset: 0xd68
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

// Namespace namespace_307260b8/namespace_f80fca07
// Params 2
// Checksum 0x42353a8c, Offset: 0xe20
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

    // Namespace namespace_307260b8/namespace_f80fca07
    // Params 0
    // Checksum 0x1b582124, Offset: 0xf30
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
