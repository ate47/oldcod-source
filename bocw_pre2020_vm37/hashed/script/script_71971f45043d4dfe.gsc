#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace namespace_6479037a;

// Namespace namespace_6479037a/namespace_6479037a
// Params 0
// Checksum 0xa7026068, Offset: 0x438
// Size: 0x12c
function init()
{
    namespace_250e9486::function_252dff4d( "steiner", &function_a485d734, undefined );
    namespace_250e9486::function_252dff4d( "steiner_split_left_arm", &function_a485d734, undefined );
    namespace_250e9486::function_252dff4d( "steiner_split_right_arm", &function_a485d734, undefined );
    clientfield::register( "actor", "steiner_radiation_bomb_prepare_fire_clientfield", 1, 1, "int" );
    clientfield::register( "actor", "steiner_split_combine_fx_clientfield", 1, 1, "int" );
    function_a767bb1c( "zombie_steiner_split_radiation_blast_spawner", "split_blast" );
    function_a767bb1c( "zombie_steiner_split_radiation_bomb_spawner", "split_bomb" );
    registerbehaviorscriptfunctions();
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0
// Checksum 0xfef96822, Offset: 0x570
// Size: 0x33a
function function_a485d734()
{
    if ( !isdefined( level.doa.steiner ) )
    {
        level.doa.steiner = doa_enemy::function_d7c5adee( "steiner" );
        level.doa.var_c1781ccb = doa_enemy::function_d7c5adee( "steiner_split_left_arm" );
        level.doa.var_e6cf829d = doa_enemy::function_d7c5adee( "steiner_split_right_arm" );
    }
    
    self namespace_250e9486::function_25b2c8a9();
    
    if ( !isdefined( self.subarchetype ) )
    {
        self.maxhealth += 10000 + 5000 * getplayers().size;
        self.health = self.maxhealth;
        self.var_8d1d18aa = 1;
        self setblackboardattribute( "_run_n_gun_variation", "variation_forward" );
    }
    
    self.health = self.maxhealth;
    self.no_gib = 1;
    self.zombie_move_speed = "walk";
    self.var_216935f8 = 1;
    
    if ( !isdefined( self.subarchetype ) || self.subarchetype == #"hash_5653bbc44a034094" )
    {
        self.var_53bac70d = 1;
    }
    
    if ( !isdefined( self.subarchetype ) || self.subarchetype == #"hash_70162f4bc795092" )
    {
        self.var_22b8f534 = 1;
    }
    
    self.overrideactordamage = &function_aab3a5fc;
    self.var_3ad8ef86 = 0;
    self.var_b52fc691 = 0;
    self.var_fcca372 = 0;
    
    if ( !isdefined( self.ai ) )
    {
        self.ai = spawnstruct();
    }
    
    self.ai.var_a02f86e7 = 0;
    self.ai.var_5dc77566 = 0;
    self.ai.var_b13e6817 = 0;
    self.ai.var_76786d9c = 0;
    self.ai.var_fad877bf = 0;
    self.ai.currentskill = 0;
    self.ai.var_a29f9a91 = 0;
    self.ai.var_e93366a = 0;
    self.ai.var_3dbed9a0 = 0;
    self.ai.issplit = 0;
    self.ai.var_b90dccd6 = 0;
    self.ai.var_62741bfb = 0;
    
    if ( is_true( self.var_22b8f534 ) && !isdefined( level.var_879dbfb8 ) )
    {
        level.var_879dbfb8 = 0;
    }
    
    self.var_b077b73d = &function_b077b73d;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0xe62325bf, Offset: 0x8b8
// Size: 0xd54
function private registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &function_7a893a7 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_7280253b8045f3aa", &function_7a893a7 );
    assert( isscriptfunctionptr( &function_e6d0f1d4 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_25f6a58aa44b9b2a", &function_e6d0f1d4 );
    assert( isscriptfunctionptr( &function_99ab692d ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_59de9b23ef7ed486", &function_99ab692d );
    assert( isscriptfunctionptr( &function_b46c0796 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_79642ea6dc02eebd", &function_b46c0796 );
    assert( isscriptfunctionptr( &function_1dcf9f45 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_200340d1ad88d275", &function_1dcf9f45 );
    assert( isscriptfunctionptr( &function_15c1e3df ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_6ad94e79dd5192", &function_15c1e3df );
    assert( isscriptfunctionptr( &function_29744716 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_7a17e3794c739769", &function_29744716 );
    assert( isscriptfunctionptr( &function_52479a49 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4f21279adbfeb5c6", &function_52479a49 );
    assert( isscriptfunctionptr( &function_dcac38af ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_6ada226476fbbc5a", &function_dcac38af );
    assert( isscriptfunctionptr( &function_e6b7aa9d ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_50a4fe24c23b6d27", &function_e6b7aa9d );
    assert( isscriptfunctionptr( &function_dab44559 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_23c568af83b67b77", &function_dab44559 );
    assert( isscriptfunctionptr( &function_baffe829 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_1146baaf761ec6ed", &function_baffe829 );
    assert( isscriptfunctionptr( &function_fe1e617c ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_57c7c778e27ffa59", &function_fe1e617c );
    assert( isscriptfunctionptr( &function_4245d56f ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_98b56eef8e28325", &function_4245d56f );
    assert( isscriptfunctionptr( &function_45fabe41 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_1658d524a973ce91", &function_45fabe41 );
    assert( isscriptfunctionptr( &function_99608cba ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_1a163703acd2ed3f", &function_99608cba );
    assert( isscriptfunctionptr( &function_779b5a9 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2bb826405d693ccb", &function_779b5a9 );
    assert( isscriptfunctionptr( &function_363c063 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_f175e396e0073c6", &function_363c063 );
    assert( isscriptfunctionptr( &function_380fc4a5 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4f54754f71b9dd6e", &function_380fc4a5 );
    assert( isscriptfunctionptr( &function_545f48af ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_305325825d9f1ae9", &function_545f48af );
    assert( isscriptfunctionptr( &function_42d0830a ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_188114dd969b5dd5", &function_42d0830a );
    assert( isscriptfunctionptr( &function_bc86ecfb ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_3248e7c31b84322a", &function_bc86ecfb );
    assert( isscriptfunctionptr( &function_d94a4d59 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_61916b6e085cb852", &function_d94a4d59 );
    assert( isscriptfunctionptr( &function_5c25cce9 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_79093a39082de682", &function_5c25cce9 );
    assert( isscriptfunctionptr( &function_5070830c ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4544909102899fea", &function_5070830c );
    assert( isscriptfunctionptr( &function_d33f94e ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_170557ad6e763f0c", &function_d33f94e );
    assert( isscriptfunctionptr( &function_4b63f114 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_5676e5630fdedd2c", &function_4b63f114 );
    assert( isscriptfunctionptr( &function_46e10c70 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_7cb881b920ccf02e", &function_46e10c70 );
    assert( isscriptfunctionptr( &function_d778b630 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_1e786509dc63e8d5", &function_d778b630 );
    assert( isscriptfunctionptr( &function_56f72e3c ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_27dfca0196f711e7", &function_56f72e3c );
    assert( isscriptfunctionptr( &function_7b89edb0 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4a436c24681915c9", &function_7b89edb0 );
    animationstatenetwork::registernotetrackhandlerfunction( "steiner_blast_fire", &function_46f4d406 );
    animationstatenetwork::registernotetrackhandlerfunction( "steiner_bomb_fire", &function_fc9189dd );
    assert( isscriptfunctionptr( &function_829cfcc8 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_3bd518a057cb317c", &function_829cfcc8 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 12
// Checksum 0xa8cf8e5e, Offset: 0x1618
// Size: 0x88
function function_aab3a5fc( *inflictor, *attacker, damage, *dflags, *mod, *weapon, *point, *dir, *hitloc, *offsettime, *boneindex, *modelindex )
{
    if ( modelindex > self.health )
    {
        self thread function_4b193227();
    }
    
    return modelindex;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0xf074d008, Offset: 0x16a8
// Size: 0x22
function private get_enemy()
{
    return isdefined( self.favoriteenemy ) ? self.favoriteenemy : self.enemy;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x3e75d04, Offset: 0x16d8
// Size: 0x3e, Type: bool
function private function_b860fc37( enemy )
{
    return isalive( enemy ) && !enemy inlaststand();
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0xa1860005, Offset: 0x1720
// Size: 0xd2
function private function_4ee74b24()
{
    if ( !isdefined( self.var_4ee74b24 ) )
    {
        self.var_4ee74b24 = 0;
    }
    
    if ( !isdefined( self.var_6d5a7a2d ) )
    {
        self.var_6d5a7a2d = 0;
    }
    
    enemy = self get_enemy();
    
    if ( !isdefined( enemy ) )
    {
        self.var_4ee74b24 = 0;
    }
    else if ( self.var_6d5a7a2d < gettime() )
    {
        self.var_4ee74b24 = util::within_fov( self.origin, self.angles, enemy.origin, cos( 30 ) );
        self.var_6d5a7a2d = gettime() + 50;
    }
    
    return self.var_4ee74b24;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0xedaf1660, Offset: 0x1800
// Size: 0x9a
function private can_see_enemy()
{
    if ( !isdefined( self.can_see_enemy ) )
    {
        self.can_see_enemy = 0;
    }
    
    if ( !isdefined( self.var_6ed00311 ) )
    {
        self.var_6ed00311 = 0;
    }
    
    enemy = self get_enemy();
    
    if ( isdefined( enemy ) && self.var_6ed00311 < gettime() )
    {
        self.can_see_enemy = self cansee( enemy );
        self.var_6ed00311 = gettime() + 50;
    }
    
    return self.can_see_enemy;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0xf861dd06, Offset: 0x18a8
// Size: 0x16, Type: bool
function private function_880fad96()
{
    return self.ai.currentskill != 0;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x596c08c8, Offset: 0x18c8
// Size: 0x4e
function private function_1da02b50( var_b268a2ed )
{
    assert( var_b268a2ed >= 0 && var_b268a2ed <= 3 );
    self.ai.currentskill = var_b268a2ed;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0x5c930836, Offset: 0x1920
// Size: 0x56
function private function_9ee55afa()
{
    self.ai.currentskill = 0;
    self.var_fcca372 = gettime() + int( 3 * 1000 );
    self notify( #"hash_58f0b0e23afeccb9" );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0x73c0ac5d, Offset: 0x1980
// Size: 0x20, Type: bool
function private function_efd416d6()
{
    return !isdefined( self.var_fcca372 ) || self.var_fcca372 < gettime();
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1
// Checksum 0xe8248de5, Offset: 0x19a8
// Size: 0x6e
function function_af554aaf( enable )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_53bac70d = is_true( self.var_53bac70d );
    self.var_53bac70d = is_true( enable );
    
    if ( var_53bac70d != self.var_53bac70d )
    {
        self.var_3ad8ef86 = 0;
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xbdb43308, Offset: 0x1a20
// Size: 0x3a
function private function_7a893a7( entity )
{
    if ( !is_true( entity.var_53bac70d ) )
    {
        return 0;
    }
    
    return entity.ai.var_a02f86e7;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xcbee31c5, Offset: 0x1a68
// Size: 0x24
function private function_baffe829( entity )
{
    entity function_1da02b50( 1 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x6ab47698, Offset: 0x1a98
// Size: 0xbc
function private function_fe1e617c( entity )
{
    if ( isalive( entity ) )
    {
        var_16122b95 = 2 * 0.5;
        cooldown = randomintrange( 6, 8 );
        entity.var_3ad8ef86 = gettime() + int( ( var_16122b95 + cooldown ) * 1000 );
        entity.ai.var_a02f86e7 = 0;
        entity function_9ee55afa();
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xa8452c3e, Offset: 0x1b60
// Size: 0x18c
function private function_3aa93442( entity )
{
    level endon( #"end_game" );
    entity endon( #"death", #"entitydeleted" );
    weapon = getweapon( #"hash_2124b6f8fa3f7f43" );
    count = randomint( 3 ) + 1;
    
    while ( count )
    {
        if ( !isalive( entity ) )
        {
            return;
        }
        
        enemy = entity get_enemy();
        
        if ( function_b860fc37( enemy ) )
        {
            target_origin = enemy.origin;
            velocity = enemy getvelocity();
            target_origin += velocity;
            var_21e2ce99 = entity gettagorigin( "J_EyeBall_RI" );
            magicbullet( weapon, var_21e2ce99, target_origin, entity );
        }
        
        count--;
        
        if ( true )
        {
            wait 0.5;
        }
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 12, eflags: 0x4
// Checksum 0xb508f6c3, Offset: 0x1cf8
// Size: 0xc8
function private function_7709f2df( inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype )
{
    var_7aa37d9f = surfacetype;
    
    if ( isdefined( psoffsettime ) && isdefined( boneindex ) && isdefined( psoffsettime.team ) && isdefined( boneindex.team ) && psoffsettime.team == boneindex.team )
    {
        var_7aa37d9f = 0;
    }
    
    return var_7aa37d9f;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xacccce25, Offset: 0x1dc8
// Size: 0x3c
function private function_46f4d406( entity )
{
    if ( isalive( entity ) )
    {
        level thread function_3aa93442( entity );
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x79422ac0, Offset: 0x1e10
// Size: 0x236
function private function_829cfcc8( entity )
{
    if ( entity function_880fad96() )
    {
        return;
    }
    
    entity.ai.var_a02f86e7 = 0;
    entity.ai.var_5dc77566 = 0;
    entity.ai.var_b13e6817 = 0;
    
    if ( !entity function_efd416d6() )
    {
        return;
    }
    
    enemy = entity get_enemy();
    
    if ( !isdefined( enemy ) )
    {
        return;
    }
    
    var_eab3f54a = distance2dsquared( entity.origin, enemy.origin );
    
    if ( is_true( entity.var_22b8f534 ) && entity.var_b52fc691 < gettime() && !function_2bde9dfa( entity ) )
    {
        if ( var_eab3f54a <= 1000000 && entity function_4ee74b24() && entity can_see_enemy() )
        {
            entity.ai.var_b13e6817 = 1;
            entity.ai.var_5dc77566 = 1;
        }
        
        return;
    }
    
    if ( is_true( entity.var_53bac70d ) && entity.var_3ad8ef86 < gettime() && !function_2bde9dfa( entity ) )
    {
        if ( var_eab3f54a <= 1000000 && entity function_4ee74b24() && entity can_see_enemy() )
        {
            entity.ai.var_a02f86e7 = 1;
        }
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1
// Checksum 0x50dc1fe8, Offset: 0x2050
// Size: 0x6e
function function_16a8babd( enable )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_22b8f534 = is_true( self.var_22b8f534 );
    self.var_22b8f534 = is_true( enable );
    
    if ( var_22b8f534 != self.var_22b8f534 )
    {
        self.var_b52fc691 = 0;
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xb39c78ff, Offset: 0x20c8
// Size: 0x3a
function private function_99ab692d( entity )
{
    if ( !is_true( entity.var_22b8f534 ) )
    {
        return 0;
    }
    
    return entity.ai.var_b13e6817;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x98420f75, Offset: 0x2110
// Size: 0x54, Type: bool
function private function_e6d0f1d4( entity )
{
    if ( !is_true( entity.var_22b8f534 ) )
    {
        return false;
    }
    
    return entity.ai.var_5dc77566 && entity function_52562969();
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0x2f4fb35a, Offset: 0x2170
// Size: 0x38, Type: bool
function private function_52562969()
{
    if ( isdefined( self.var_90c3aec8 ) && self.var_90c3aec8.size >= 3 )
    {
        return false;
    }
    
    return level.var_879dbfb8 < 9;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xa9c1ebb6, Offset: 0x21b0
// Size: 0x82
function private function_99608cba( entity )
{
    if ( entity function_52562969() )
    {
        level.var_879dbfb8++;
        entity.var_4d0d199c = 1;
        entity clientfield::set( "steiner_radiation_bomb_prepare_fire_clientfield", 1 );
        entity function_1da02b50( 2 );
        return;
    }
    
    entity.var_4d0d199c = 0;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xfc497512, Offset: 0x2240
// Size: 0x1e
function private function_779b5a9( entity )
{
    entity.ai.var_b13e6817 = 0;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xfb9df1a7, Offset: 0x2268
// Size: 0xc
function private function_4245d56f( *entity )
{
    
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x796f8d95, Offset: 0x2280
// Size: 0xc4
function private function_45fabe41( entity )
{
    if ( is_true( entity.var_4d0d199c ) )
    {
        entity clientfield::set( "steiner_radiation_bomb_prepare_fire_clientfield", 0 );
        entity.var_4d0d199c = 0;
    }
    
    cooldown = randomintrange( 19, 21 );
    entity.var_b52fc691 = gettime() + int( cooldown * 1000 );
    entity.ai.var_5dc77566 = 0;
    entity function_9ee55afa();
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 12, eflags: 0x4
// Checksum 0x3d8c0e24, Offset: 0x2350
// Size: 0xc8
function private function_7ff0ce68( inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype )
{
    var_7aa37d9f = surfacetype;
    
    if ( isdefined( psoffsettime ) && isdefined( boneindex ) && isdefined( psoffsettime.team ) && isdefined( boneindex.team ) && psoffsettime.team == boneindex.team )
    {
        var_7aa37d9f = 0;
    }
    
    return var_7aa37d9f;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x9aee9ebc, Offset: 0x2420
// Size: 0x208, Type: bool
function private function_bf8080c1( entity )
{
    enemy = entity get_enemy();
    
    if ( !function_b860fc37( enemy ) )
    {
        return false;
    }
    
    var_6e3ad56b = enemy.origin;
    
    if ( isplayer( enemy ) )
    {
        velocity = enemy getvelocity();
        
        if ( length( velocity ) >= 0 )
        {
            var_6e3ad56b += vectorscale( velocity, 0.5 );
        }
    }
    
    target_pos = var_6e3ad56b;
    angles = vectortoangles( target_pos - entity.origin );
    dir = anglestoforward( angles );
    var_8598bad6 = entity gettagorigin( "tag_bombthrower_FX" );
    dist = distance( var_8598bad6, target_pos );
    velocity = vectorscale( dir, dist );
    velocity += ( 0, 0, 120 );
    grenade = entity magicgrenadetype( getweapon( #"hash_7e3de6b5b2134623" ), var_8598bad6, velocity );
    
    if ( isdefined( grenade ) )
    {
        grenade.owner = entity;
        grenade.team = entity.team;
        grenade thread function_a56050b0();
    }
    
    return true;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x7bb8e643, Offset: 0x2630
// Size: 0x46
function private function_2bde9dfa( entity )
{
    if ( entity.ai.var_5dc77566 || entity.ai.var_b13e6817 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0xcd79d23d, Offset: 0x2680
// Size: 0x164
function private function_a56050b0()
{
    level endon( #"end_game" );
    owner = self.owner;
    self waittill( #"grenade_explode", #"death" );
    
    if ( isalive( owner ) )
    {
        origin = self.origin;
        trace = bullettrace( origin + ( 0, 0, 50 ), origin + ( 0, 0, -50 ), 0, self );
        
        if ( trace[ #"fraction" ] < 1 )
        {
            origin = trace[ #"position" ];
        }
        
        var_b308e59c = namespace_ec06fe4a::spawnmodel( origin, "tag_origin" );
        
        if ( isdefined( var_b308e59c ) )
        {
            var_b308e59c.targetname = "steinerBomb";
            var_b308e59c.owner = owner;
            owner function_4d70c1d3( var_b308e59c );
            var_b308e59c thread function_fac064dc();
        }
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x5041ad5, Offset: 0x27f0
// Size: 0x8c
function private function_4d70c1d3( ent )
{
    if ( !isdefined( self.var_90c3aec8 ) )
    {
        self.var_90c3aec8 = [];
    }
    
    if ( !isdefined( self.var_90c3aec8 ) )
    {
        self.var_90c3aec8 = [];
    }
    else if ( !isarray( self.var_90c3aec8 ) )
    {
        self.var_90c3aec8 = array( self.var_90c3aec8 );
    }
    
    self.var_90c3aec8[ self.var_90c3aec8.size ] = ent;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 2, eflags: 0x4
// Checksum 0xd2216a61, Offset: 0x2888
// Size: 0xd0
function private function_f2cb8145( var_ec2c535e, *destroyed )
{
    if ( is_true( destroyed ) && isdefined( self.owner ) && isdefined( self.owner.var_90c3aec8 ) )
    {
        arrayremovevalue( self.owner.var_90c3aec8, self );
    }
    
    if ( is_true( self.var_5d15d0b2 ) )
    {
        return;
    }
    
    self namespace_ec06fe4a::function_52afe5df( 0.2 );
    
    if ( level.var_879dbfb8 > 0 )
    {
        level.var_879dbfb8--;
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0x17509836, Offset: 0x2960
// Size: 0x5e
function private function_4b193227()
{
    if ( !isdefined( self.var_90c3aec8 ) || !self.var_90c3aec8.size )
    {
        return;
    }
    
    array::thread_all( self.var_90c3aec8, &function_f2cb8145, 0 );
    self.var_90c3aec8 = [];
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0x472677aa, Offset: 0x29c8
// Size: 0x1c4
function private function_fac064dc()
{
    level endon( #"end_game" );
    self endon( #"death" );
    var_6f13bbe0 = gettime() + int( 4000 );
    origin = self.origin;
    owner = self.owner;
    
    while ( gettime() < var_6f13bbe0 )
    {
        self namespace_83eb6304::function_3ecfde67( "electrical_explo" );
        players = function_a1ef346b( undefined, origin, 48 );
        
        /#
        #/
        
        foreach ( player in players )
        {
            if ( isdefined( player.var_3de278ea ) && gettime() - player.var_3de278ea < 0.5 )
            {
                continue;
            }
            
            player dodamage( 20, origin, owner, self, undefined, "MOD_DOT" );
            player.var_3de278ea = gettime();
        }
        
        wait 0.5;
    }
    
    self thread function_f2cb8145( 1 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xd80f698, Offset: 0x2b98
// Size: 0x3c
function private function_fc9189dd( entity )
{
    if ( isalive( entity ) )
    {
        function_bf8080c1( entity );
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 2, eflags: 0x4
// Checksum 0xa0324793, Offset: 0x2be0
// Size: 0x106
function private function_a767bb1c( spawner_name, var_5c583e69 )
{
    if ( !isdefined( level.var_f88d42fc ) )
    {
        level.var_f88d42fc = [];
    }
    
    level.var_f88d42fc[ var_5c583e69 ] = getentarray( spawner_name, "script_noteworthy" );
    
    if ( level.var_f88d42fc[ var_5c583e69 ].size == 0 )
    {
        return;
    }
    
    foreach ( var_694b1d7b in level.var_f88d42fc[ var_5c583e69 ] )
    {
        var_694b1d7b.is_enabled = 1;
        var_694b1d7b.script_forcespawn = 1;
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0x2a8e0c1a, Offset: 0x2cf0
// Size: 0x2cc
function private function_ac56fb75()
{
    level endon( #"end_game" );
    self endon( #"death", #"entitydeleted" );
    
    if ( is_true( self.var_8576e0be ) || is_true( self.var_9b474709 ) )
    {
        return;
    }
    
    if ( self function_880fad96() )
    {
        self.var_9b474709 = 1;
        waitresult = self waittill( #"hash_58f0b0e23afeccb9", #"stop_wait_for_split" );
        
        if ( !isalive( self ) || waitresult._notify == "stop_wait_for_split" )
        {
            return;
        }
        
        self.var_9b474709 = 0;
    }
    
    self.var_8576e0be = 1;
    self function_1da02b50( 3 );
    health = int( ceil( self.health * 0.5 ) );
    right_angles = anglestoright( self.angles );
    var_7584b84b = ( right_angles[ 0 ], right_angles[ 1 ], 0 );
    var_53d254e5 = vectorscale( var_7584b84b, 15 );
    var_488052a8 = vectorscale( var_7584b84b, -15 );
    self thread function_eafb4701( level.doa.var_c1781ccb, self.origin, health, var_488052a8, self.enemy );
    self thread function_eafb4701( level.doa.var_e6cf829d, self.origin, health, var_53d254e5, self.enemy );
    self namespace_83eb6304::function_3ecfde67( "zombie_generator_die" );
    self namespace_83eb6304::function_3ecfde67( "nova_crawler_burst" );
    self namespace_ec06fe4a::function_8c808737();
    self thread namespace_ec06fe4a::function_570729f0( 0.4 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 5, eflags: 0x4
// Checksum 0x51cca0, Offset: 0x2fc8
// Size: 0x164
function private function_eafb4701( spawndef, location, health, offset, enemy )
{
    if ( !isdefined( spawndef ) )
    {
        return;
    }
    
    entity = doa_enemy::function_db55a448( spawndef, location, enemy );
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isdefined( location.angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    else
    {
        angles = location.angles;
    }
    
    entity.maxhealth = health;
    entity.health = health;
    entity setmaxhealth( health );
    var_99b76528 = 25;
    point = getclosestpointonnavmesh( location + offset, var_99b76528 );
    
    if ( !isdefined( point ) )
    {
        point = getclosestpointonnavmesh( location + offset, var_99b76528 * 4 );
    }
    
    if ( isdefined( point ) && tracepassedonnavmesh( location, point, 15 ) )
    {
        entity forceteleport( point, angles );
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x7d4eefdd, Offset: 0x3138
// Size: 0x9c
function private function_b46c0796( entity )
{
    if ( isalive( entity ) && is_true( entity.var_8d1d18aa ) && entity.health <= entity.maxhealth * 0.5 )
    {
        if ( !is_true( entity.var_8576e0be ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x23f35970, Offset: 0x31e0
// Size: 0xc
function private function_363c063( *entity )
{
    
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x11f91f9e, Offset: 0x31f8
// Size: 0x24
function private function_380fc4a5( entity )
{
    entity thread function_ac56fb75();
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xb92ef3a6, Offset: 0x3228
// Size: 0x3c
function private function_1dcf9f45( entity )
{
    if ( is_true( entity.ai.issplit ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x1a287330, Offset: 0x3270
// Size: 0xc
function private function_bc86ecfb( *entity )
{
    
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xbb1be397, Offset: 0x3288
// Size: 0x22
function private function_d94a4d59( entity )
{
    entity.ai.issplit = 1;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x2886d767, Offset: 0x32b8
// Size: 0x30
function private function_15c1e3df( entity )
{
    if ( entity.ai.var_fad877bf )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x270b7b5f, Offset: 0x32f0
// Size: 0xc
function private function_d33f94e( *entity )
{
    
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xb2c5cdbc, Offset: 0x3308
// Size: 0x1e
function private function_4b63f114( entity )
{
    entity.ai.var_fad877bf = 0;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1
// Checksum 0x63e43eae, Offset: 0x3330
// Size: 0x3c
function function_b077b73d( time )
{
    if ( !isdefined( time ) || time <= 0 )
    {
        return;
    }
    
    self thread function_392a816a( time );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xf2c9073e, Offset: 0x3378
// Size: 0x19e
function private function_392a816a( time )
{
    if ( is_true( self.var_8576e0be ) )
    {
        return;
    }
    
    if ( !is_true( self.var_8d1d18aa ) && !isdefined( self.var_e1f39584 ) )
    {
        return;
    }
    
    self notify( #"hash_1126b46a114399d" );
    self endon( #"death", #"hash_1126b46a114399d" );
    self.var_8d1d18aa = 0;
    
    if ( is_true( self.var_9b474709 ) )
    {
        self notify( #"stop_wait_for_split" );
        self.var_9b474709 = 0;
    }
    
    var_e1f39584 = gettime() + int( time * 1000 );
    
    if ( isdefined( self.var_e1f39584 ) )
    {
        self.var_e1f39584 = int( max( self.var_e1f39584, var_e1f39584 ) );
    }
    else
    {
        self.var_e1f39584 = var_e1f39584;
    }
    
    while ( isalive( self ) && isdefined( self.var_e1f39584 ) )
    {
        if ( gettime() >= self.var_e1f39584 )
        {
            self.var_8d1d18aa = 1;
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xc776a23b, Offset: 0x3520
// Size: 0x32
function private function_d778b630( entity )
{
    entity.ai.var_76786d9c = 0;
    entity.ai.var_80045105 = gettime();
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x211db44e, Offset: 0x3560
// Size: 0x5a
function private function_46e10c70( entity )
{
    if ( entity.ai.var_76786d9c )
    {
        entity.ai.var_fad877bf = 1;
        entity.ai.var_76786d9c = 0;
        return 4;
    }
    
    return 5;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xc08c94de, Offset: 0x35c8
// Size: 0x2c
function private function_56f72e3c( behaviortreeentity )
{
    behaviortreeentity asmsetanimationrate( 1.05 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x2c02ff11, Offset: 0x3600
// Size: 0x24
function private function_7b89edb0( behaviortreeentity )
{
    behaviortreeentity asmsetanimationrate( 1 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1
// Checksum 0x5af1a2c0, Offset: 0x3630
// Size: 0x34, Type: bool
function function_e6b7aa9d( behaviortreeentity )
{
    return behaviortreeentity getblackboardattribute( "_locomotion_speed_zombie" ) === "locomotion_speed_walk";
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1
// Checksum 0xb772ef91, Offset: 0x3670
// Size: 0x34, Type: bool
function function_dab44559( behaviortreeentity )
{
    return behaviortreeentity getblackboardattribute( "_locomotion_speed_zombie" ) === "locomotion_speed_run";
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x81889dd5, Offset: 0x36b0
// Size: 0x1ba
function private function_21746f2d( var_eab3f54a )
{
    var_533af8f8 = !is_true( self.ai.var_e93366a ) && var_eab3f54a > 722500;
    isrunning = self.zombie_move_speed == "run";
    
    if ( var_533af8f8 && !isrunning )
    {
        if ( !isdefined( self.ai.rundelay ) )
        {
            self.ai.rundelay = gettime() + randomintrange( 1000, 2000 );
        }
        
        if ( self.ai.rundelay > gettime() )
        {
            var_533af8f8 = 0;
        }
    }
    
    if ( self.ai.var_3dbed9a0 < gettime() && var_533af8f8 != isrunning )
    {
        if ( var_533af8f8 )
        {
            currentvelocity = self getvelocity();
            currentspeed = length( currentvelocity );
            
            if ( !isrunning || currentspeed > 0 )
            {
                self.ai.var_3dbed9a0 = gettime() + 2000;
                self.zombie_move_speed = "run";
                self.ai.rundelay = undefined;
            }
            
            return;
        }
        
        self.ai.var_3dbed9a0 = gettime() + 2000;
        self.zombie_move_speed = "walk";
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x82e92589, Offset: 0x3878
// Size: 0x1e
function private function_29744716( entity )
{
    return entity.ai.var_b90dccd6;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 2
// Checksum 0x9fefeb48, Offset: 0x38a0
// Size: 0xf6
function function_67a0e9a2( var_2fa3c4c9, location )
{
    level.var_f0c367c9 = location;
    level.var_8cc83376 = [];
    
    foreach ( split in var_2fa3c4c9 )
    {
        split.ai.var_b90dccd6 = 0;
        split.ai.var_62741bfb = 1;
        split setgoal( split.origin, 1 );
        split.ignoreall = 1;
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x150ec7c8, Offset: 0x39a0
// Size: 0x1e
function private function_52479a49( entity )
{
    return entity.ai.var_62741bfb;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xf730bf14, Offset: 0x39c8
// Size: 0x2c
function private function_5c25cce9( entity )
{
    entity clientfield::set( "steiner_split_combine_fx_clientfield", 1 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xdad6f324, Offset: 0x3a00
// Size: 0xa8
function private function_5070830c( entity )
{
    array::add( level.var_8cc83376, entity, 0 );
    entity clientfield::set( "steiner_split_combine_fx_clientfield", 0 );
    entity.ai.var_62741bfb = 0;
    
    if ( level.var_8cc83376.size == 2 )
    {
        level thread function_aed09e18( level.var_8cc83376, level.var_f0c367c9 );
        level.var_8cc83376 = [];
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x92749840, Offset: 0x3ab0
// Size: 0x1e
function private function_dcac38af( entity )
{
    return entity.ai.var_a29f9a91;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0x702264df, Offset: 0x3ad8
// Size: 0xc
function private function_545f48af( *entity )
{
    
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xd8d501e6, Offset: 0x3af0
// Size: 0x5a
function private function_42d0830a( entity )
{
    if ( entity.variant_type < 3 )
    {
        entity.variant_type += 1;
        return;
    }
    
    entity.variant_type = 0;
    entity.ai.var_a29f9a91 = 0;
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 2, eflags: 0x4
// Checksum 0x6fc2fa5a, Offset: 0x3b58
// Size: 0x1fc
function private function_aed09e18( var_2fa3c4c9, location )
{
    foreach ( split in var_2fa3c4c9 )
    {
        split hide();
        split deletedelay();
    }
    
    steiner = doa_enemy::function_db55a448( level.doa.steiner, location, undefined );
    
    if ( isdefined( steiner ) )
    {
        steiner forceteleport( location.origin, location.angles );
        steiner.team = #"allies";
        steiner.ignoreall = 1;
        steiner.ignoreme = 1;
        steiner.ignore_nuke = 1;
        steiner.ignore_all_poi = 1;
        steiner.cant_move_cb = &zombiebehavior::function_79fe956f;
        steiner.takedamage = 0;
        steiner.var_8d1d18aa = 0;
        steiner.ai.var_a29f9a91 = 1;
        steiner.variant_type = 0;
        steiner function_af554aaf( 0 );
        steiner function_16a8babd( 0 );
    }
    
    level flag::set( "steiner_merge_done" );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1
// Checksum 0x3a9f7fb2, Offset: 0x3d60
// Size: 0x84
function function_7e855c12( point )
{
    self.var_9ecae3b4 = 1;
    self.zombie_move_speed = "walk";
    self setgoal( point, 0 );
    self waittill( #"goal" );
    self.var_9ecae3b4 = undefined;
    self setgoal( self.origin, 1 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1
// Checksum 0xe15add1b, Offset: 0x3df0
// Size: 0x74
function function_c6579189( target )
{
    if ( !isdefined( target ) )
    {
        return;
    }
    
    v_to_target = target.origin - self.origin;
    v_angles = vectortoangles( v_to_target );
    self orientmode( "face angle", v_angles );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 0, eflags: 0x4
// Checksum 0xdf7de72f, Offset: 0x3e70
// Size: 0x132
function private function_46d99f6b()
{
    steiners = getaiarchetypearray( #"hash_7c0d83ac1e845ac2" );
    var_ddb534a3 = [];
    
    foreach ( steiner in steiners )
    {
        if ( isalive( steiner ) && steiner.team == #"allies" )
        {
            if ( !isdefined( var_ddb534a3 ) )
            {
                var_ddb534a3 = [];
            }
            else if ( !isarray( var_ddb534a3 ) )
            {
                var_ddb534a3 = array( var_ddb534a3 );
            }
            
            var_ddb534a3[ var_ddb534a3.size ] = steiner;
        }
    }
    
    return var_ddb534a3;
}

