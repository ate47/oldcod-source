#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace content_manager;

// Namespace content_manager/content_manager
// Params 0, eflags: 0x6
// Checksum 0xc6061cbb, Offset: 0xf0
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"content_manager", &preinit, undefined, &finalize, undefined );
}

// Namespace content_manager/content_manager
// Params 0, eflags: 0x4
// Checksum 0xad8ace3d, Offset: 0x140
// Size: 0x42
function private preinit()
{
    level.contentmanager = spawnstruct();
    level.contentmanager.registeredscripts = [];
    level.contentmanager.scriptcategories = [];
}

// Namespace content_manager/content_manager
// Params 0, eflags: 0x4
// Checksum 0x6508d26f, Offset: 0x190
// Size: 0x54
function private finalize()
{
    setup_destinations();
    setup_locations();
    level.contentmanager.spawnedinstances = [];
    
    /#
        level thread init_devgui();
    #/
}

// Namespace content_manager/content_manager
// Params 2
// Checksum 0xafef2820, Offset: 0x1f0
// Size: 0xfe
function register_script( scriptname, spawncallback )
{
    assert( isstring( scriptname ) || ishash( scriptname ) );
    assert( isfunctionptr( spawncallback ) );
    registeredscripts = level.contentmanager.registeredscripts;
    assert( !isdefined( registeredscripts[ scriptname ] ) );
    script = { #scriptname:scriptname, #spawncallback:spawncallback };
    registeredscripts[ scriptname ] = script;
    return script;
}

// Namespace content_manager/content_manager
// Params 1
// Checksum 0x837d2807, Offset: 0x2f8
// Size: 0x64
function get_script( scriptname )
{
    assert( isstring( scriptname ) || ishash( scriptname ) );
    return level.contentmanager.registeredscripts[ scriptname ];
}

// Namespace content_manager/content_manager
// Params 2
// Checksum 0x3889410c, Offset: 0x368
// Size: 0x1de
function function_31e8da78( destination, content_category )
{
    locations = array::randomize( get_children( destination ) );
    
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
        instances = array::randomize( get_children( location ) );
        
        foreach ( instance in instances )
        {
            if ( instance.content_script_name === content_category )
            {
                return instance;
            }
        }
    }
}

// Namespace content_manager/content_manager
// Params 0, eflags: 0x4
// Checksum 0x6dcd9d85, Offset: 0x550
// Size: 0xa8a
function private setup_destinations()
{
    mapdestinations = struct::get_array( #"content_destination", "variantname" );
    destinations = [];
    level.contentmanager.destinations = destinations;
    
    foreach ( destination in mapdestinations )
    {
        assert( isdefined( destination.targetname ) );
        assert( !isdefined( destinations[ destination.targetname ] ) );
        destinations[ destination.targetname ] = destination;
        function_656a32f0( destination );
        locations = [];
        destination.locations = locations;
        children = get_children( destination );
        
        foreach ( child in children )
        {
            if ( child.variantname != #"content_location" )
            {
                continue;
            }
            
            assert( isdefined( child.targetname ) );
            assert( !isdefined( locations[ child.targetname ] ) );
            locations[ child.targetname ] = child;
        }
    }
    
    if ( isdefined( level.var_2da0be29 ) )
    {
        [[ level.var_2da0be29 ]]();
        var_42d2e0bf = arraycopy( destinations );
        
        foreach ( destination in destinations )
        {
            if ( !isdefined( destination.adjacencies ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== destination.targetname )
            {
                arrayremovevalue( var_42d2e0bf, destination );
            }
        }
        
        var_53be964f = array::randomize( var_42d2e0bf );
    }
    else
    {
        var_53be964f = destinations;
    }
    
    if ( is_false( getgametypesetting( #"hash_3a16dccdcb82e664" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"destination_zoo" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"destination_zoo" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_4eabe0978dc92ef7" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"destination_sanatorium" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"destination_sanatorium" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_45f866da7af3a609" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"destination_forest" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"destination_forest" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_d9c18f112ff4552" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"destination_golova" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"destination_golova" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_15e3cdab677aed" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"destination_ski" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"destination_ski" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_7fafd95fb5eeb3cd" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"hash_2041750e8a960d7d" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"hash_2041750e8a960d7d" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_7322ca6ba3d467f0" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"hash_677d5923437f98ef" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"hash_677d5923437f98ef" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_6b4d9c563903b948" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"hash_5377c6139b94f878" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"hash_5377c6139b94f878" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_19c3b46e9dd9d7c5" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"hash_607058eb6f433e35" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"hash_607058eb6f433e35" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_64069be594107ddf" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"hash_725519cecb127be4" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"hash_725519cecb127be4" ) );
    }
    
    if ( is_false( getgametypesetting( #"hash_444f9d0410b85ddf" ) ) && getdvarstring( #"hash_36112559be5dfe28", "" ) !== #"destination_duga" )
    {
        arrayremovevalue( var_53be964f, struct::get( #"destination_duga" ) );
    }
    
    level.contentmanager.destinations = array::randomize( var_53be964f );
}

// Namespace content_manager/content_manager
// Params 2
// Checksum 0xf7b41c45, Offset: 0xfe8
// Size: 0x144
function setup_adjacencies( str_destination, var_2d26f85c )
{
    assert( isdefined( level.contentmanager.destinations[ str_destination ] ) && isdefined( "<dev string:x38>" + str_destination ) );
    i = 0;
    
    foreach ( var_fc091632 in var_2d26f85c )
    {
        adjacency = struct::get( var_fc091632 );
        assert( isdefined( adjacency ) && isdefined( "<dev string:x67>" + var_fc091632 ) );
        level.contentmanager.destinations[ str_destination ].adjacencies[ i ] = adjacency;
        i++;
    }
}

// Namespace content_manager/content_manager
// Params 1
// Checksum 0x705afd17, Offset: 0x1138
// Size: 0x9e
function function_fe9fb6fd( location )
{
    assert( isstruct( location ) );
    assert( location.variantname == #"content_location" );
    spawned_instances = isarray( location.spawnedinstances ) && location.spawnedinstances.size > 0;
    return spawned_instances;
}

// Namespace content_manager/content_manager
// Params 0, eflags: 0x4
// Checksum 0xb37d1e53, Offset: 0x11e0
// Size: 0x2ba
function private setup_locations()
{
    maplocations = struct::get_array( #"content_location", "variantname" );
    locations = [];
    level.contentmanager.locations = locations;
    
    foreach ( location in maplocations )
    {
        assert( isdefined( location.targetname ) );
        assert( !isdefined( locations[ location.targetname ] ) );
        locations[ location.targetname ] = location;
        
        if ( isdefined( location.target ) )
        {
            parent = struct::get( location.target );
            
            if ( parent.variantname == #"content_destination" )
            {
                location.destination = parent;
            }
        }
        
        function_656a32f0( location );
        instances = [];
        location.instances = instances;
        children = get_children( location );
        
        foreach ( child in children )
        {
            if ( child.variantname != #"content_instance" )
            {
                continue;
            }
            
            assert( isdefined( child.content_script_name ) );
            assert( !isdefined( instances[ child.content_script_name ] ) );
            instances[ child.content_script_name ] = child;
            child.location = location;
        }
    }
}

// Namespace content_manager/content_manager
// Params 1
// Checksum 0xf0f2ce0b, Offset: 0x14a8
// Size: 0x164
function spawn_instance( instance )
{
    assert( isstruct( instance ) );
    assert( instance.variantname == #"content_instance" );
    assert( isstring( instance.content_script_name ) || ishash( instance.content_script_name ) );
    assert( isstruct( instance.location ) );
    function_656a32f0( instance );
    script = level.contentmanager.registeredscripts[ instance.content_script_name ];
    
    if ( isdefined( script.spawncallback ) )
    {
        level thread [[ script.spawncallback ]]( instance );
    }
    
    function_130f0da3( instance );
}

// Namespace content_manager/content_manager
// Params 1
// Checksum 0xd3984f7b, Offset: 0x1618
// Size: 0xfc, Type: bool
function function_1c78a45d( instance )
{
    assert( isstruct( instance ) );
    assert( instance.variantname == #"content_instance" );
    assert( isstring( instance.content_script_name ) || ishash( instance.content_script_name ) );
    assert( isstruct( instance.location ) );
    return !function_fe9fb6fd( instance.location );
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x4
// Checksum 0x37721faf, Offset: 0x1720
// Size: 0xfe
function private function_130f0da3( instance )
{
    assert( isarray( level.contentmanager.spawnedinstances ) );
    
    if ( !isdefined( instance.location.spawnedinstances ) )
    {
        instance.location.spawnedinstances = [];
    }
    
    instance.location.spawnedinstances[ instance.location.spawnedinstances.size ] = instance;
    spawnedinstances = level.contentmanager.spawnedinstances;
    
    if ( !isdefined( spawnedinstances[ instance.content_script_name ] ) )
    {
        spawnedinstances[ instance.content_script_name ] = [];
    }
    
    instances = spawnedinstances[ instance.content_script_name ];
    instances[ instances.size ] = instance;
}

// Namespace content_manager/content_manager
// Params 4
// Checksum 0x79c9019e, Offset: 0x1828
// Size: 0x152
function function_76c93f39( contentstructs, usecallback, hintstring, radius )
{
    assert( isarray( contentstructs ) );
    assert( isfunctionptr( usecallback ) );
    assert( ishash( hintstring ) );
    triggers = [];
    
    foreach ( struct in contentstructs )
    {
        trigger = spawn_interact( struct, usecallback, hintstring, undefined, radius );
        triggers[ trigger.size ] = trigger;
    }
    
    return triggers;
}

// Namespace content_manager/content_manager
// Params 9
// Checksum 0x70836442, Offset: 0x1988
// Size: 0x240
function spawn_interact( struct, usecallback, hintstring, var_e0355bdc, radius = 64, height = 128, centered = 0, offset = ( 0, 0, 0 ), var_499de507 )
{
    assert( isstruct( struct ) );
    assert( isfunctionptr( usecallback ) );
    assert( ishash( hintstring ) );
    
    if ( isdefined( struct.radius ) )
    {
        radius = struct.radius;
    }
    
    usetrigger = spawn( "trigger_radius_use", struct.origin + offset, 0, radius, height, centered );
    usetrigger triggerignoreteam();
    usetrigger setcursorhint( "HINT_NOICON" );
    usetrigger usetriggerrequirelookat();
    
    if ( isdefined( var_e0355bdc ) && isdefined( var_499de507 ) )
    {
        usetrigger sethintstring( hintstring, var_e0355bdc, var_499de507 );
    }
    else if ( isdefined( var_e0355bdc ) )
    {
        usetrigger sethintstring( hintstring, var_e0355bdc );
    }
    else
    {
        usetrigger sethintstring( hintstring );
    }
    
    usetrigger callback::on_trigger( usecallback );
    return usetrigger;
}

// Namespace content_manager/content_manager
// Params 3
// Checksum 0xfc23e192, Offset: 0x1bd0
// Size: 0xda
function function_cfa4f1a0( contentstructs, modelname, var_bfbc537c = 0 )
{
    models = [];
    
    foreach ( struct in contentstructs )
    {
        model = spawn_script_model( struct, modelname, var_bfbc537c );
        models[ models.size ] = model;
    }
    
    return models;
}

// Namespace content_manager/content_manager
// Params 3
// Checksum 0x2ef8cfc7, Offset: 0x1cb8
// Size: 0x19a
function spawn_script_model( struct, modelname, var_bfbc537c = 0 )
{
    model = spawn( "script_model", struct.origin );
    model.angles = struct.angles;
    model setmodel( modelname );
    
    if ( var_bfbc537c )
    {
        model disconnectpaths();
    }
    
    parent = struct;
    
    while ( true )
    {
        if ( parent.variantname === #"content_instance" )
        {
            if ( !isdefined( parent.a_models ) )
            {
                parent.a_models = [];
            }
            else if ( !isarray( parent.a_models ) )
            {
                parent.a_models = array( parent.a_models );
            }
            
            if ( !isinarray( parent.a_models, model ) )
            {
                parent.a_models[ parent.a_models.size ] = model;
            }
            
            break;
        }
        
        parent = struct::get( parent.target );
        
        if ( !isdefined( parent ) )
        {
            break;
        }
    }
    
    return model;
}

// Namespace content_manager/content_manager
// Params 3
// Checksum 0x23a6f86f, Offset: 0x1e60
// Size: 0x182
function spawn_zbarrier( struct, zbarrier_classname, var_e546275c = 0 )
{
    zbarrier = spawn( zbarrier_classname, struct.origin );
    zbarrier.angles = struct.angles;
    
    if ( var_e546275c )
    {
        zbarrier disconnectpaths();
    }
    
    parent = struct;
    
    while ( true )
    {
        if ( parent.variantname === #"content_instance" )
        {
            if ( !isdefined( parent.a_models ) )
            {
                parent.a_models = [];
            }
            else if ( !isarray( parent.a_models ) )
            {
                parent.a_models = array( parent.a_models );
            }
            
            if ( !isinarray( parent.a_models, zbarrier ) )
            {
                parent.a_models[ parent.a_models.size ] = zbarrier;
            }
            
            break;
        }
        
        parent = struct::get( parent.target );
        
        if ( !isdefined( parent ) )
        {
            break;
        }
    }
    
    return zbarrier;
}

// Namespace content_manager/content_manager
// Params 0
// Checksum 0xfd776e3e, Offset: 0x1ff0
// Size: 0x324
function function_690c4abe()
{
    level notify( #"hash_4a140b223cb0019d" );
    
    foreach ( group in level.contentmanager.spawnedinstances )
    {
        foreach ( instance in group )
        {
            if ( isdefined( instance.a_models ) )
            {
                foreach ( model in instance.a_models )
                {
                    if ( isdefined( model ) )
                    {
                        if ( isdefined( model.trigger ) )
                        {
                            model.trigger delete();
                        }
                        
                        if ( isdefined( model.var_e55c8b4e ) )
                        {
                            objective_delete( model.var_e55c8b4e );
                            gameobjects::release_obj_id( model.var_e55c8b4e );
                        }
                        
                        if ( isdefined( model.objectiveid ) )
                        {
                            objective_delete( model.objectiveid );
                            gameobjects::release_obj_id( model.objectiveid );
                        }
                        
                        model scene::stop();
                        model delete();
                    }
                }
                
                arrayremovevalue( instance.a_models, undefined );
            }
            
            arrayremovevalue( group, instance, 1 );
            arrayremovevalue( instance.location.spawnedinstances, instance, 1 );
        }
        
        arrayremovevalue( group, undefined );
        arrayremovevalue( level.contentmanager.spawnedinstances, group, 1 );
    }
    
    arrayremovevalue( level.contentmanager.spawnedinstances, undefined );
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x4
// Checksum 0xb8bd0270, Offset: 0x2320
// Size: 0x120
function private function_656a32f0( parent )
{
    children = get_children( parent );
    contentgroups = function_bedd4c47( children );
    parent.contentgroups = contentgroups;
    
    foreach ( child in children )
    {
        if ( child.variantname != #"content_struct" || !isdefined( child.content_key ) )
        {
            continue;
        }
        
        child.parent = parent;
        function_656a32f0( child );
    }
}

// Namespace content_manager/content_manager
// Params 1, eflags: 0x4
// Checksum 0x4fcd326c, Offset: 0x2448
// Size: 0x10a
function private function_bedd4c47( children )
{
    groups = [];
    
    foreach ( child in children )
    {
        if ( child.variantname != #"content_struct" || !isdefined( child.content_key ) )
        {
            continue;
        }
        
        if ( !isdefined( groups[ child.content_key ] ) )
        {
            groups[ child.content_key ] = [];
        }
        
        group = groups[ child.content_key ];
        group[ group.size ] = child;
    }
    
    return groups;
}

// Namespace content_manager/content_manager
// Params 1
// Checksum 0x5e09f724, Offset: 0x2560
// Size: 0x42
function get_children( parent )
{
    if ( !isdefined( parent.targetname ) )
    {
        return [];
    }
    
    return struct::get_array( parent.targetname, "target" );
}

/#

    // Namespace content_manager/content_manager
    // Params 0, eflags: 0x4
    // Checksum 0xe041ef00, Offset: 0x25b0
    // Size: 0x3dc, Type: dev
    function private init_devgui()
    {
        util::waittill_can_add_debug_command();
        adddebugcommand( "<dev string:xa0>" );
        util::add_devgui( devgui_path( "<dev string:xcd>", 0 ), "<dev string:xe2>" );
        
        foreach ( destination in level.contentmanager.destinations )
        {
            foreach ( location in destination.locations )
            {
                foreach ( instance in location.instances )
                {
                    instancekey = location.targetname + "<dev string:x10b>" + instance.content_script_name;
                    path = devgui_path( "<dev string:x110>", 1, destination.targetname, location.targetname, instance.content_script_name );
                    util::add_devgui( path, "<dev string:x120>" + instancekey );
                }
            }
        }
        
        foreach ( location in level.contentmanager.locations )
        {
            foreach ( instance in location.instances )
            {
                instancekey = location.targetname + "<dev string:x10b>" + instance.content_script_name;
                path = devgui_path( "<dev string:x145>", 2, location.targetname, instance.content_script_name );
                util::add_devgui( path, "<dev string:x120>" + instancekey );
            }
        }
        
        level thread debug_draw();
        level thread function_b3843ca7();
    }

    // Namespace content_manager/content_manager
    // Params 1, eflags: 0x20 variadic
    // Checksum 0xde314885, Offset: 0x2998
    // Size: 0xd8, Type: dev
    function devgui_path( ... )
    {
        path = "<dev string:x152>";
        
        foreach ( arg in vararg )
        {
            if ( isint( arg ) )
            {
                path += "<dev string:x10b>";
            }
            else
            {
                path += "<dev string:x16c>";
            }
            
            path += arg;
        }
        
        return path;
    }

    // Namespace content_manager/content_manager
    // Params 0, eflags: 0x4
    // Checksum 0x924e51e6, Offset: 0x2a78
    // Size: 0x158, Type: dev
    function private function_b3843ca7()
    {
        while ( true )
        {
            setdvar( #"hash_6d5a45dcdc3af9b5", "<dev string:x171>" );
            waitframe( 1 );
            instancekey = getdvarstring( #"hash_6d5a45dcdc3af9b5", "<dev string:x171>" );
            
            if ( instancekey == "<dev string:x171>" )
            {
                continue;
            }
            
            keys = strtok( instancekey, "<dev string:x10b>" );
            
            if ( keys.size != 2 )
            {
                continue;
            }
            
            location = level.contentmanager.locations[ keys[ 0 ] ];
            
            if ( !isdefined( location ) )
            {
                continue;
            }
            
            if ( isdefined( location.spawnedinstance ) )
            {
                continue;
            }
            
            instance = location.instances[ keys[ 1 ] ];
            
            if ( !isdefined( instance ) )
            {
                continue;
            }
            
            spawn_instance( instance );
        }
    }

    // Namespace content_manager/content_manager
    // Params 0, eflags: 0x4
    // Checksum 0x71096513, Offset: 0x2bd8
    // Size: 0x162, Type: dev
    function private debug_draw()
    {
        while ( true )
        {
            if ( getdvarint( #"hash_55e098bf3549b14d", 0 ) )
            {
                foreach ( destination in level.contentmanager.destinations )
                {
                    draw_destination( destination );
                }
                
                foreach ( location in level.contentmanager.locations )
                {
                    draw_location( location, location.destination );
                }
            }
            
            waitframe( 1 );
        }
    }

    // Namespace content_manager/content_manager
    // Params 1
    // Checksum 0xce8f3350, Offset: 0x2d48
    // Size: 0x34, Type: dev
    function draw_destination( destination )
    {
        draw_struct( destination, ( 0, 1, 0 ), undefined, destination.targetname );
    }

    // Namespace content_manager/content_manager
    // Params 2
    // Checksum 0x398b5421, Offset: 0x2d88
    // Size: 0xe0, Type: dev
    function draw_location( location, destination )
    {
        if ( !isdefined( destination ) )
        {
            destination = undefined;
        }
        
        draw_struct( location, ( 0, 1, 1 ), destination, location.targetname );
        
        foreach ( instance in location.instances )
        {
            draw_instance( instance, location );
        }
    }

    // Namespace content_manager/content_manager
    // Params 2
    // Checksum 0xcc2b0310, Offset: 0x2e70
    // Size: 0x5c, Type: dev
    function draw_instance( instance, location )
    {
        if ( !isdefined( location ) )
        {
            location = undefined;
        }
        
        draw_struct( instance, ( 0, 0, 1 ), location );
        function_b2b08c09( instance );
    }

    // Namespace content_manager/content_manager
    // Params 1
    // Checksum 0xbaa93d9c, Offset: 0x2ed8
    // Size: 0x13c, Type: dev
    function function_b2b08c09( node )
    {
        if ( isarray( node.contentgroups ) )
        {
            foreach ( group in node.contentgroups )
            {
                foreach ( child in group )
                {
                    draw_struct( child, ( 1, 0, 1 ), node );
                    function_b2b08c09( child );
                }
            }
        }
    }

    // Namespace content_manager/content_manager
    // Params 4
    // Checksum 0x9d683a76, Offset: 0x3020
    // Size: 0x13c, Type: dev
    function draw_struct( struct, color, parent, extrastr )
    {
        if ( !isdefined( parent ) )
        {
            parent = undefined;
        }
        
        if ( !isdefined( extrastr ) )
        {
            extrastr = undefined;
        }
        
        debugstr = undefined;
        debugstr = function_4636f4cb( debugstr, struct.variantname );
        debugstr = function_4636f4cb( debugstr, struct.content_script_name );
        debugstr = function_4636f4cb( debugstr, struct.content_key );
        debugstr = function_4636f4cb( debugstr, extrastr );
        
        if ( isdefined( parent ) )
        {
            line( struct.origin, parent.origin, color );
        }
        
        sphere( struct.origin, 8, color );
        print3d( struct.origin, debugstr );
    }

    // Namespace content_manager/content_manager
    // Params 2
    // Checksum 0x356c99d9, Offset: 0x3168
    // Size: 0x7a, Type: dev
    function function_4636f4cb( str, append )
    {
        if ( ishash( append ) )
        {
            append = function_9e72a96( append );
        }
        
        if ( !isdefined( str ) )
        {
            return append;
        }
        else if ( isdefined( append ) )
        {
            return ( str + "<dev string:x175>" + append );
        }
        
        return str;
    }

#/
