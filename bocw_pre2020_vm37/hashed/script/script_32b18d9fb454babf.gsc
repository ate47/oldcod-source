#using script_130178aa44106ebb;
#using script_13d5d0aa9140d362;
#using script_1520735551406676;
#using script_16b1b77a76492c6a;
#using script_176597095ddfaa17;
#using script_1cd534c7e79b126f;
#using script_2618e0f3e5e11649;
#using script_355c6e84a79530cb;
#using script_5a525a75a8f1f7e4;
#using script_5ff9bbe37f3310b0;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\objective_manager;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_utility_zsurvival;
#using scripts\zm_common\zm_wallbuy;

#namespace namespace_18bbc38e;

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 0, eflags: 0x6
// Checksum 0xbbfbf506, Offset: 0x1e8
// Size: 0x54
function private autoexec __init__system__()
{
    system::register( #"hash_5bcba15330839867", &preinit, undefined, &finalize, #"content_manager" );
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 0, eflags: 0x4
// Checksum 0xa9b5448, Offset: 0x248
// Size: 0x46
function private preinit()
{
    level.contentmanager.preinit = 0;
    level flag::init( #"navmesh_loading", 0 );
    level.var_7de6c9f = undefined;
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 0, eflags: 0x4
// Checksum 0x49e1319a, Offset: 0x298
// Size: 0x2c
function private finalize()
{
    if ( !zm_utility::function_c200446c() )
    {
        level thread function_1975f7db();
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1
// Checksum 0xeb6a9c5b, Offset: 0x2d0
// Size: 0x7a
function function_123b048f( var_8a952bed )
{
    assert( isdefined( var_8a952bed ), "<dev string:x38>" );
    assert( var_8a952bed.variantname == #"content_destination", "<dev string:x38>" );
    level.contentmanager.var_5f2429b1 = var_8a952bed;
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 0
// Checksum 0xb06bf163, Offset: 0x358
// Size: 0x16
function function_2e165386()
{
    return level.contentmanager.var_d60029a6;
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 0, eflags: 0x4
// Checksum 0x626d12d3, Offset: 0x378
// Size: 0x4d2
function private function_d4de820e()
{
    if ( is_true( getdvarint( #"hash_688e3b3254c8a895", 0 ) ) )
    {
        var_89d7bd4 = [];
        var_eef00fc6 = getdvarstring( #"hash_68a0047e00d7d34c" );
        
        if ( var_eef00fc6 !== "" )
        {
            var_89d7bd4[ var_89d7bd4.size ] = var_eef00fc6;
        }
        
        var_53975913 = getdvarstring( #"hash_68a0077e00d7d865" );
        
        if ( var_53975913 !== "" )
        {
            var_89d7bd4[ var_89d7bd4.size ] = var_53975913;
        }
        
        var_6155748f = getdvarstring( #"hash_68a0067e00d7d6b2" );
        
        if ( var_6155748f !== "" )
        {
            var_89d7bd4[ var_89d7bd4.size ] = var_6155748f;
        }
        
        var_18386256 = getdvarstring( #"hash_68a0017e00d7ce33" );
        
        if ( var_18386256 !== "" )
        {
            var_89d7bd4[ var_89d7bd4.size ] = var_18386256;
        }
        
        var_4607bdf4 = getdvarstring( #"hash_68a0007e00d7cc80" );
        
        if ( var_4607bdf4 !== "" )
        {
            var_89d7bd4[ var_89d7bd4.size ] = var_4607bdf4;
        }
        
        var_2b588ed4 = 3;
    }
    else
    {
        var_2b588ed4 = isdefined( getgametypesetting( #"hash_352d47f1b1b17cc5" ) ) ? getgametypesetting( #"hash_352d47f1b1b17cc5" ) : 0;
    }
    
    if ( var_2b588ed4 )
    {
        switch ( var_2b588ed4 )
        {
            case 1:
                var_13f49a56 = array( "kill_hvt_zoo_avogadro", "objective_ski_defend_lodge", "objective_sanatorium_payload_teleport" );
                break;
            case 2:
                var_13f49a56 = array( "objective_sanatorium_defend_console", "objective_zoo_retrieval", "kill_hvt_ski_raz" );
                break;
            case 3:
                var_13f49a56 = var_89d7bd4;
                break;
            default:
                return;
        }
        
        var_a3c51b07 = [];
        
        for ( i = 0; i < var_13f49a56.size ; i++ )
        {
            instance = struct::get( var_13f49a56[ i ] );
            location = struct::get( instance.target );
            destination = struct::get( location.target );
            assert( destination.variantname == #"content_destination" );
            script = content_manager::get_script( instance.content_script_name );
            category = script.objectivecategory;
            destination.var_e859e591 = [];
            destination.var_e859e591[ category ] = array( instance );
            var_a3c51b07[ i ] = destination;
        }
        
        a_spawns = function_f3be07d7( var_a3c51b07[ 0 ] );
        var_58b02068 = struct::get( a_spawns[ 0 ].target, "targetname" );
        level.var_7767cea8 = array( var_58b02068 );
        level.var_7767cea8[ 0 ].spawns = a_spawns;
        function_123b048f( var_a3c51b07[ 0 ] );
        return var_a3c51b07;
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1
// Checksum 0x87ed6d92, Offset: 0x858
// Size: 0x16a
function function_f3be07d7( destination )
{
    if ( !isdefined( level.contentmanager.nextobjective ) )
    {
        objective_manager::function_b06af8e3( destination );
    }
    
    var_9200b8df = level.contentmanager.nextobjective.spawn_list;
    
    if ( isdefined( var_9200b8df ) )
    {
        var_f281f968 = array::random( strtok( var_9200b8df, "," ) );
        var_58b02068 = function_85e09141( level.contentmanager.nextobjective, var_f281f968 );
    }
    
    if ( !isdefined( var_58b02068 ) )
    {
        var_58b02068 = content_manager::function_31e8da78( destination, #"start_spawn" );
    }
    
    level.contentmanager.nextspawn = var_58b02068;
    level flag::set( #"hash_10679ff0bf4d6c8d" );
    var_842cdacd = content_manager::get_children( var_58b02068 );
    return array::randomize( var_842cdacd );
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 2
// Checksum 0x2b350ce5, Offset: 0x9d0
// Size: 0x204
function function_85e09141( instance, var_f281f968 )
{
    locations = array::randomize( content_manager::get_children( instance.location.destination ) );
    
    for ( i = 0; i < locations.size ; i++ )
    {
        if ( locations[ i ].variantname !== #"content_location" )
        {
            arrayremoveindex( locations, i, 1 );
        }
    }
    
    arrayremovevalue( locations, undefined );
    
    foreach ( location in locations )
    {
        instances = array::randomize( content_manager::get_children( location ) );
        
        foreach ( instance in instances )
        {
            if ( instance.content_script_name === #"start_spawn" && instance.script_int === var_f281f968 )
            {
                return instance;
            }
        }
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 0, eflags: 0x4
// Checksum 0x4d76a295, Offset: 0xbe0
// Size: 0x164
function private function_6f9efb66()
{
    var_9b06d3e2 = getdvarstring( #"hash_36112559be5dfe28" );
    var_4f146e5d = [];
    
    if ( !isdefined( var_9b06d3e2 ) || var_9b06d3e2 == "" )
    {
        a_destinations = level.contentmanager.destinations;
        var_4f146e5d = [];
        
        for ( i = 0; i < a_destinations.size ; i++ )
        {
            var_8a952bed = a_destinations[ i ];
            
            if ( is_true( var_8a952bed.var_8d629117 ) )
            {
                continue;
            }
            
            var_4f146e5d = function_f3be07d7( var_8a952bed );
            
            if ( var_4f146e5d.size )
            {
                var_9b06d3e2 = var_8a952bed.targetname;
                break;
            }
        }
    }
    else
    {
        var_8a952bed = struct::get( var_9b06d3e2 );
        assert( isdefined( var_8a952bed ), "<dev string:x84>" + var_9b06d3e2 );
    }
    
    if ( isdefined( var_8a952bed ) )
    {
        function_123b048f( var_8a952bed );
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 0, eflags: 0x4
// Checksum 0xc86c5c8, Offset: 0xd50
// Size: 0x4cc
function private function_1975f7db()
{
    destinations = [];
    categories = [];
    objective_manager::function_ef3a1d04( destinations, categories );
    objective_manager::function_c700a68b( categories );
    var_4191df0e = getdvarint( #"hash_688e3b3254c8a895", 0 );
    
    if ( !var_4191df0e )
    {
        function_6f9efb66();
    }
    
    /#
        if ( getdvarint( #"hash_33b0be96bf3cd69a", 0 ) )
        {
            level.contentmanager.var_d60029a6 = array( level.contentmanager.var_5f2429b1 );
            level.contentmanager.currentdestination = level.contentmanager.var_5f2429b1;
            level flag::set( #"hash_7ace2c0d668c5128" );
            
            while ( !isdefined( level.hotzones ) && getdvarint( #"hash_7f960fed9c1533f", 1 ) )
            {
                waitframe( 1 );
            }
            
            level thread function_7c05a985( level.contentmanager.var_5f2429b1 );
            return;
        }
        
        if ( getdvarint( #"hash_4fd21096bcb24e82", 0 ) )
        {
            level flag::set( #"hash_7ace2c0d668c5128" );
            return;
        }
    #/
    
    level.contentmanager.var_d60029a6 = function_d4de820e();
    
    if ( !isdefined( level.contentmanager.var_d60029a6 ) )
    {
        var_92a668db = getdvarint( #"hash_6c0d94ade91b07a8", 0 );
        
        if ( !var_92a668db || var_92a668db > level.contentmanager.destinations.size )
        {
            var_92a668db = level.contentmanager.destinations.size;
        }
        
        var_a3c51b07[ 0 ] = level.contentmanager.var_5f2429b1;
        arrayremovevalue( destinations, var_a3c51b07[ 0 ] );
        
        for ( i = 1; i < var_92a668db ; i++ )
        {
            var_918869fb = var_a3c51b07[ i - 1 ].adjacencies;
            
            if ( !isdefined( var_918869fb ) )
            {
                var_918869fb = arraycopy( destinations );
            }
            
            while ( destinations.size && var_918869fb.size )
            {
                var_c0335359 = array::random( var_918869fb );
                
                if ( !isdefined( var_c0335359.var_e859e591 ) || !var_c0335359.var_e859e591.size || isinarray( var_a3c51b07, var_c0335359 ) )
                {
                    arrayremovevalue( var_918869fb, var_c0335359 );
                    continue;
                }
                
                break;
            }
            
            if ( !destinations.size )
            {
                break;
            }
            
            arrayremovevalue( destinations, var_c0335359 );
            var_a3c51b07[ i ] = var_c0335359;
        }
        
        var_6067a19c = var_a3c51b07[ i - 1 ];
        
        if ( isdefined( var_6067a19c.var_e859e591[ #"final_battle" ] ) )
        {
            var_6067a19c.final_battle = 1;
        }
        
        level.contentmanager.var_d60029a6 = var_a3c51b07;
        
        if ( var_4191df0e )
        {
            function_6f9efb66();
        }
    }
    
    level thread function_786a9f4d( level.contentmanager.var_d60029a6 );
    level flag::set( #"hash_7ace2c0d668c5128" );
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1, eflags: 0x4
// Checksum 0x56b5ee8b, Offset: 0x1228
// Size: 0x39c
function private function_786a9f4d( destinations )
{
    level endon( #"game_ended" );
    level.contentmanager.var_46849b1b = 0;
    
    while ( destinations.size )
    {
        foreach ( destination in destinations )
        {
            level thread activate( destination );
            s_result = level waittill( #"objective_ended" );
            
            if ( s_result.completed === 0 && getdvarint( #"hash_15b141da1584bd0d", 1 ) )
            {
                gametype = hash( util::get_game_type() );
                
                if ( gametype == #"zsurvival" )
                {
                    zm_utility_zsurvival::end_match( 0 );
                }
                
                return;
            }
            
            level thread namespace_73df937d::spawn_safehouse( destination );
            level waittill( #"safehouse_claimed" );
            level thread function_7c05a985( destination );
            level.contentmanager.var_46849b1b++;
            
            if ( level.contentmanager.var_46849b1b >= destinations.size )
            {
                level.contentmanager.var_46849b1b = 0;
            }
            
            level waittill( #"portal_activated" );
            level callback::callback( #"portal_activated" );
            locations = destination.locations;
            
            foreach ( location in locations )
            {
                foreach ( instance in location.instances )
                {
                    instance callback::callback( #"portal_activated" );
                }
            }
            
            zm_utility_zsurvival::function_7c97e961( level.star_rating + 1 );
            deactivate( destination );
        }
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1
// Checksum 0x7edc336e, Offset: 0x15d0
// Size: 0x164
function function_7c05a985( destination )
{
    level endon( #"portal_activated" );
    
    if ( !is_false( getgametypesetting( #"hash_7d1368d8d487beed" ) ) || getdvarint( #"hash_33b0be96bf3cd69a", 0 ) )
    {
        exfil = function_5a957da0( destination );
        
        if ( isdefined( exfil ) )
        {
            content_manager::spawn_instance( exfil );
        }
        
        s_result = level waittill( #"objective_ended" );
    }
    
    gametype = hash( util::get_game_type() );
    
    if ( gametype == #"zclassic" )
    {
        level notify( #"end_game" );
        return;
    }
    
    zm_utility_zsurvival::end_match( s_result.completed );
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1, eflags: 0x4
// Checksum 0x782cd932, Offset: 0x1740
// Size: 0x22e
function private function_5a957da0( destination )
{
    locations = array::randomize( content_manager::get_children( destination ) );
    
    for ( i = 0; i < locations.size ; i++ )
    {
        if ( locations[ i ].variantname !== #"content_location" )
        {
            arrayremoveindex( locations, i, 1 );
        }
    }
    
    arrayremovevalue( locations, undefined );
    
    foreach ( location in locations )
    {
        instances = array::randomize( content_manager::get_children( location ) );
        
        foreach ( instance in instances )
        {
            if ( instance.content_script_name === #"exfil" )
            {
                if ( !isdefined( instance.var_a07fca34 ) || instances.size == 1 )
                {
                    return instance;
                }
                
                if ( instance.var_a07fca34 <= zm_utility::function_e3025ca5() )
                {
                    return instance;
                }
            }
        }
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1, eflags: 0x4
// Checksum 0xbc446c52, Offset: 0x1978
// Size: 0xa6
function private function_c62829da( destination )
{
    if ( function_d71c83a7() )
    {
        if ( isdefined( destination.contentgroups[ #"hash_3460aae6bb799a99" ] ) )
        {
            var_6c486d1a = destination.contentgroups[ #"hash_3460aae6bb799a99" ][ 0 ];
            
            if ( isdefined( var_6c486d1a ) )
            {
                var_f6b2bc6f = getent( var_6c486d1a.targetname, "target" );
                
                if ( isdefined( var_f6b2bc6f ) )
                {
                    return var_f6b2bc6f;
                }
            }
        }
    }
    
    return undefined;
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1
// Checksum 0x3256b953, Offset: 0x1a28
// Size: 0x114
function function_ab94c270( destination )
{
    if ( level flag::get( #"navmesh_loading" ) )
    {
        return;
    }
    
    ent = function_c62829da( destination );
    
    if ( level.var_7de6c9f === ent )
    {
        return;
    }
    
    if ( isdefined( ent ) )
    {
        level flag::set( #"navmesh_loading" );
        level.var_7de6c9f = undefined;
        var_ada19974 = function_dbe9e22e( ent );
        
        while ( var_ada19974.size > 0 )
        {
            var_ada19974 = function_8abb2f1a( var_ada19974 );
            waitframe( 1 );
        }
        
        level flag::clear( #"navmesh_loading" );
        level.var_7de6c9f = ent;
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1, eflags: 0x4
// Checksum 0x27ffa788, Offset: 0x1b48
// Size: 0x284
function private activate( destination )
{
    level.contentmanager.currentdestination = destination;
    level thread function_ab94c270( destination );
    level flag::wait_till_clear( #"navmesh_loading" );
    
    if ( zm_utility::is_survival() )
    {
        level flag::wait_till( #"hash_10679ff0bf4d6c8d" );
    }
    
    if ( !getdvarint( #"hash_4fd21096bcb24e82", 0 ) )
    {
        objective_manager::spawn_objective();
    }
    
    function_cef826da( destination );
    level thread namespace_e51c1e80::spawn_vehicles( destination );
    namespace_ce1f29cc::function_6b885d72( destination );
    
    if ( isdefined( level.contentmanager.nextspawn ) )
    {
        namespace_ce1f29cc::function_12c2f41f( level.contentmanager.nextspawn.origin, 2000 );
    }
    
    namespace_63c7213c::function_fb6230f6( destination );
    namespace_12a6a726::spawn_supply_drop( destination );
    namespace_78804a69::function_cd133a5e( destination );
    namespace_25297a8a::function_8adcc97a( destination );
    namespace_2c949ef8::function_c0966bb1( destination );
    level thread zm_magicbox::function_2dcb5cea( destination );
    level thread zm_wallbuy::function_669a830( destination );
    level thread namespace_c09ae6c3::function_7b19802a( destination );
    
    if ( is_true( getgametypesetting( #"hash_59854c1f30538261" ) ) )
    {
        announce = objective_manager::function_7bfeebe3() > 0;
        namespace_d0ab5955::function_d4dec4e8( destination, announce );
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1, eflags: 0x4
// Checksum 0x9e482225, Offset: 0x1dd8
// Size: 0x230
function private function_cef826da( destination )
{
    foreach ( location in destination.locations )
    {
        var_7ca1bc80 = location.instances[ #"explore_chests_large" ];
        
        if ( isdefined( var_7ca1bc80 ) )
        {
            content_manager::spawn_instance( var_7ca1bc80 );
        }
        
        var_20780a3a = location.instances[ #"explore_chests" ];
        
        if ( isdefined( var_20780a3a ) )
        {
            content_manager::spawn_instance( var_20780a3a );
        }
        
        var_20780a3a = location.instances[ #"explore_chests_small" ];
        
        if ( isdefined( var_20780a3a ) )
        {
            content_manager::spawn_instance( var_20780a3a );
        }
        
        var_bf74f01b = location.instances[ #"loot_pods" ];
        
        if ( isdefined( var_bf74f01b ) )
        {
            content_manager::spawn_instance( var_bf74f01b );
        }
        
        var_c3d93d9f = location.instances[ #"harvest_essence" ];
        
        if ( isdefined( var_c3d93d9f ) )
        {
            content_manager::spawn_instance( var_c3d93d9f );
        }
        
        var_c3d93d9f = location.instances[ #"harvest_essence_small" ];
        
        if ( isdefined( var_c3d93d9f ) )
        {
            content_manager::spawn_instance( var_c3d93d9f );
        }
        
        var_a1f9a8cd = location.instances[ #"harvest_scrap" ];
        
        if ( isdefined( var_a1f9a8cd ) )
        {
            content_manager::spawn_instance( var_a1f9a8cd );
        }
    }
}

// Namespace namespace_18bbc38e/namespace_18bbc38e
// Params 1
// Checksum 0x84ed06cb, Offset: 0x2010
// Size: 0x78
function deactivate( destination )
{
    namespace_ce1f29cc::deactivate_hotzones( destination );
    namespace_d0ab5955::function_f1ad7968( destination );
    content_manager::function_690c4abe();
    level thread namespace_e51c1e80::function_c772bd2c( destination );
    level notify( #"hash_3b28fcaa0b9b4489" );
}

