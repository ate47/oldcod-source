#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace mimic_prop_spawn;

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 0
// Checksum 0xcddd257e, Offset: 0x120
// Size: 0x20
function init()
{
    if ( !isdefined( level.var_b7c1e1d2 ) )
    {
        level.var_b7c1e1d2 = [];
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 3
// Checksum 0xac63afd8, Offset: 0x148
// Size: 0x52
function function_8743cb1d( origin, radius, num_props )
{
    prop_array = function_4cc90533( origin, radius, num_props );
    return function_913ecbbc( prop_array );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2
// Checksum 0xc8a08176, Offset: 0x1a8
// Size: 0x4a
function function_8c6c017a( &spawn_points, num_props )
{
    prop_array = spawn_props( spawn_points, num_props );
    return function_913ecbbc( prop_array );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1
// Checksum 0x266cac18, Offset: 0x200
// Size: 0x178
function function_913ecbbc( &prop_array )
{
    if ( !prop_array.size )
    {
        return;
    }
    
    mimic = spawnactor( #"spawner_bo5_mimic", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_faa3dbdd = array::randomize( prop_array );
    trap_prop = undefined;
    
    foreach ( prop in var_faa3dbdd )
    {
        if ( is_true( prop.var_3e64167 ) )
        {
            trap_prop = prop;
            break;
        }
    }
    
    if ( !isdefined( trap_prop ) )
    {
        trap_prop = var_faa3dbdd[ 0 ];
    }
    
    if ( !isdefined( trap_prop ) )
    {
        return;
    }
    
    function_cad34798( mimic, prop_array );
    function_4540d40c( mimic, trap_prop );
    function_80335b6( trap_prop, prop_array );
    return trap_prop;
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1
// Checksum 0xbf1d0f56, Offset: 0x380
// Size: 0x9e
function function_4237218( pause )
{
    foreach ( prop in function_2e8c33f6() )
    {
        prop.pause_trap = is_true( pause );
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 0
// Checksum 0x13a21852, Offset: 0x428
// Size: 0xd2
function function_2e8c33f6()
{
    arrayremovevalue( level.var_b7c1e1d2, undefined );
    var_2a1f535d = [];
    
    foreach ( prop in level.var_b7c1e1d2 )
    {
        if ( is_true( prop.var_3e64167 ) )
        {
            var_2a1f535d[ var_2a1f535d.size ] = prop;
        }
    }
    
    return var_2a1f535d;
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 3
// Checksum 0xf1bdf3b, Offset: 0x508
// Size: 0x7a
function function_4cc90533( origin, radius, num_props )
{
    var_79422067 = struct::get_array( "mimic_prop_spawn", "targetname" );
    var_79422067 = function_72d3bca6( var_79422067, origin, undefined, undefined, radius );
    return spawn_props( var_79422067, num_props );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2
// Checksum 0xfba70b5, Offset: 0x590
// Size: 0x1b0
function spawn_props( &spawn_points, num_props )
{
    arrayremovevalue( level.var_b7c1e1d2, undefined );
    prop_array = [];
    
    if ( 20 - level.var_b7c1e1d2.size < num_props )
    {
        /#
            if ( is_true( level.var_bce8fb65 ) )
            {
                println( "<dev string:x38>" + "<dev string:x45>" + 20 - level.var_b7c1e1d2.size + "<dev string:x65>" + num_props );
            }
        #/
        
        return prop_array;
    }
    
    if ( !spawn_points.size )
    {
        /#
            if ( is_true( level.var_bce8fb65 ) )
            {
                println( "<dev string:x38>" + "<dev string:x75>" );
            }
        #/
        
        return prop_array;
    }
    
    spawn_points = array::randomize( spawn_points );
    
    for ( index = 0; index < num_props ; index++ )
    {
        loc = spawn_points[ index ];
        prop = spawn_prop( loc );
        prop_array[ prop_array.size ] = prop;
        level.var_b7c1e1d2[ level.var_b7c1e1d2.size ] = prop;
    }
    
    return prop_array;
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1
// Checksum 0xa7518932, Offset: 0x748
// Size: 0x3a
function spawn_prop( spawn_loc )
{
    return util::spawn_anim_model( #"barrel_rust_01_green", spawn_loc.origin, spawn_loc.angles );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2
// Checksum 0xd5788e87, Offset: 0x790
// Size: 0x54
function function_cad34798( entity, &prop_array )
{
    entity.prop_array = prop_array;
    entity callback::function_d8abfc3d( #"on_ai_killed", &function_1187de9 );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 3
// Checksum 0xe7bdd4bc, Offset: 0x7f0
// Size: 0xb4
function function_80335b6( prop, &prop_array, condition_func = &function_708fe162 )
{
    prop.var_3e64167 = 1;
    prop thread trap_thread( prop_array, condition_func );
    prop.health = 50000;
    prop.takedamage = 1;
    prop.tracked_damage = 0;
    prop.var_b31a1e22 = 0;
    callback::on_scriptmover_damage( &function_24811d29, prop );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 0
// Checksum 0x580f3580, Offset: 0x8b0
// Size: 0x22
function function_708fe162()
{
    return getplayers( undefined, self.origin, 96 );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2
// Checksum 0x7adaf0d6, Offset: 0x8e0
// Size: 0xba
function trap_thread( &prop_array, condition_func )
{
    self endon( #"death", #"damage_transform" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitframe( 1 );
        
        if ( is_true( self.pause_trap ) )
        {
            continue;
        }
        
        activators = self [[ condition_func ]]();
        
        if ( activators.size )
        {
            transform_spawn( self, activators );
            return;
        }
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2
// Checksum 0x7a38bb5e, Offset: 0x9a8
// Size: 0x176
function function_24811d29( prop, s_info )
{
    prop.health = 50000;
    
    if ( is_true( self.pause_trap ) )
    {
        return;
    }
    
    if ( !isplayer( s_info.einflictor ) && !isplayer( s_info.eattacker ) )
    {
        return;
    }
    
    if ( gettime() - prop.var_b31a1e22 > int( 3 * 1000 ) )
    {
        prop.tracked_damage = 0;
    }
    
    prop.tracked_damage += s_info.idamage;
    prop.var_b31a1e22 = gettime();
    
    if ( prop.tracked_damage >= 100 )
    {
        player = isplayer( s_info.einflictor ) ? s_info.einflictor : s_info.eattacker;
        prop notify( #"damage_transform" );
        profilestart();
        transform_spawn( prop, [ player ] );
        profilestop();
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2
// Checksum 0xbe114390, Offset: 0xb28
// Size: 0x154
function transform_spawn( prop, &activators )
{
    if ( isdefined( prop.var_3c964886 ) )
    {
        [[ prop.var_3c964886 ]]( prop );
    }
    
    if ( !isdefined( prop.hidden_entities ) )
    {
        return;
    }
    
    foreach ( entity in prop.hidden_entities )
    {
        entity callback::callback( #"on_entity_revealed", { #activators:activators } );
    }
    
    prop val::set( #"mimic_spawn", "hide", 1 );
    prop notsolid();
    callback::remove_on_scriptmover_damage( &function_24811d29, prop );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2
// Checksum 0x9688e749, Offset: 0xc88
// Size: 0x1b8
function function_4540d40c( entity, prop )
{
    entity endon( #"death" );
    prop endon( #"death" );
    entity.var_83fa6083 = 1;
    entity val::set( #"hash_263a780666aef25", "hide", 1 );
    entity notsolid();
    entity pathmode( "dont move", 1 );
    entity dontinterpolate();
    entity forceteleport( prop.origin, prop.angles );
    entity setentitypaused( 1 );
    entity callback::callback( #"on_entity_hidden_in_prop", { #prop:prop } );
    entity callback::function_d8abfc3d( #"on_entity_revealed", &function_7c591227, undefined, [ prop ] );
    
    if ( !isdefined( prop.hidden_entities ) )
    {
        prop.hidden_entities = [];
    }
    
    prop.hidden_entities[ prop.hidden_entities.size ] = entity;
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 2
// Checksum 0x905553d2, Offset: 0xe48
// Size: 0xec
function function_7c591227( *params, prop )
{
    if ( self ispaused() )
    {
        self setentitypaused( 0 );
    }
    
    self solid();
    self pathmode( "move allowed" );
    self val::reset( #"hash_263a780666aef25", "hide" );
    self animscripted( "ai_t9_zm_mimic_com_emerge_prop_quick_f_01", prop.origin, prop.angles, "ai_t9_zm_mimic_com_emerge_prop_quick_f_01", "normal" );
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1
// Checksum 0x665d1392, Offset: 0xf40
// Size: 0xc8
function function_1187de9( *params )
{
    arrayremovevalue( self.prop_array, undefined );
    
    foreach ( prop in self.prop_array )
    {
        if ( isdefined( prop.var_33960526 ) )
        {
            [[ prop.var_33960526 ]]();
        }
        
        prop deletedelay();
    }
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 1
// Checksum 0x23bdb32a, Offset: 0x1010
// Size: 0xfc
function clean_up_prop( prop )
{
    if ( isdefined( prop.hidden_entities ) )
    {
        function_1eaaceab( prop.hidden_entities );
        
        foreach ( hidden_entity in prop.hidden_entities )
        {
            if ( hidden_entity ispaused() )
            {
                hidden_entity setentitypaused( 0 );
            }
            
            hidden_entity deletedelay();
        }
    }
    
    prop deletedelay();
}

// Namespace mimic_prop_spawn/namespace_4aff7b6b
// Params 0
// Checksum 0x9d80deff, Offset: 0x1118
// Size: 0xa8
function function_fd24f982()
{
    arrayremovevalue( level.var_b7c1e1d2, undefined );
    
    foreach ( prop in level.var_b7c1e1d2 )
    {
        clean_up_prop( prop );
    }
}

