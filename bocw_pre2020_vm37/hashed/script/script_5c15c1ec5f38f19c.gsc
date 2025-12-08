#using script_35ae72be7b4fec10;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\util;

#namespace namespace_46c3c08e;

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0, eflags: 0x6
// Checksum 0xdc52c1c8, Offset: 0x230
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_14bc2f7d024f30c0", &preload, undefined, undefined, undefined );
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0, eflags: 0x4
// Checksum 0xbc4c5d4e, Offset: 0x278
// Size: 0xcc
function private preload()
{
    callback::on_spawned( &on_player_spawned );
    collectibles::add_callback( "red_circus_kraus_ledger", &function_8806cc63 );
    collectibles::add_callback( "red_circus_audio_tape", &function_be9f0a9e );
    collectibles::add_callback( "red_circus_dead_drop_list", &function_a084acb9 );
    
    /#
        util::init_dvar( "<dev string:x38>", 0, &function_6b507fee );
    #/
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0, eflags: 0x4
// Checksum 0x4aa1821d, Offset: 0x350
// Size: 0x3c
function private on_player_spawned()
{
    level flag::wait_till( #"gameplay_started" );
    generate_solution( 0 );
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 1, eflags: 0x4
// Checksum 0x51aefb34, Offset: 0x398
// Size: 0x814
function private generate_solution( reset )
{
    if ( isdefined( level.var_60eee92e ) )
    {
        return;
    }
    
    seed = savegame::function_2ee66e93( #"hash_6a83b769c50b79d2", undefined );
    
    if ( !isdefined( seed ) || is_true( reset ) )
    {
        seed = int( ( function_b6db3f71() + randomint( 2147483647 ) ) % 2147483647 );
        savegame::set_player_data( #"hash_6a83b769c50b79d2", seed );
    }
    
    function_68b722e5();
    var_48686aa8 = level.var_60eee92e.locations;
    var_8c5afe89 = level.var_60eee92e.var_c363cb12;
    var_687f51a8 = [];
    var_df0623ff = [];
    
    for ( i = 0; i < var_48686aa8.size ; i++ )
    {
        if ( is_true( var_48686aa8[ i ].var_59a4d624 ) )
        {
            if ( !isdefined( var_687f51a8 ) )
            {
                var_687f51a8 = [];
            }
            else if ( !isarray( var_687f51a8 ) )
            {
                var_687f51a8 = array( var_687f51a8 );
            }
            
            var_687f51a8[ var_687f51a8.size ] = i;
            continue;
        }
        
        if ( !isdefined( var_df0623ff ) )
        {
            var_df0623ff = [];
        }
        else if ( !isarray( var_df0623ff ) )
        {
            var_df0623ff = array( var_df0623ff );
        }
        
        var_df0623ff[ var_df0623ff.size ] = i;
    }
    
    var_4abd20f4 = [];
    
    for ( i = 0; i < var_687f51a8.size ; i++ )
    {
        for ( j = i + 1; j < var_687f51a8.size ; j++ )
        {
            var_7df2d0a6 = function_67e3f98e( var_687f51a8[ i ], var_687f51a8[ j ] );
            
            if ( !isdefined( var_4abd20f4 ) )
            {
                var_4abd20f4 = [];
            }
            else if ( !isarray( var_4abd20f4 ) )
            {
                var_4abd20f4 = array( var_4abd20f4 );
            }
            
            var_4abd20f4[ var_4abd20f4.size ] = var_7df2d0a6;
        }
    }
    
    assert( var_4abd20f4.size > var_8c5afe89.size );
    randresult = function_cd12badd( seed, getarraykeys( var_8c5afe89 ) );
    seed = randresult.seed;
    var_74a258da = randresult.scrambled;
    randresult = function_cd12badd( seed, var_687f51a8 );
    seed = randresult.seed;
    var_9b5a7338 = randresult.scrambled;
    assert( var_9b5a7338.size >= 9 );
    
    for ( i = 0; i < 3 ; i++ )
    {
        var_c7696383 = var_74a258da[ i ];
        agent = var_8c5afe89[ var_c7696383 ];
        agent.var_11faa37b = i;
        assert( agent.var_11faa37b < level.var_60eee92e.agents.size );
        var_e380d76b = var_9b5a7338[ i * 2 ];
        function_3029b4d5( agent, var_e380d76b );
        var_1edddb3d = var_9b5a7338[ i * 2 + 1 ];
        function_3029b4d5( agent, var_1edddb3d );
        var_7df2d0a6 = function_67e3f98e( var_e380d76b, var_1edddb3d );
        arrayremovevalue( var_4abd20f4, var_7df2d0a6 );
        var_b83c8859 = var_74a258da[ 3 + i ];
        var_37526c30 = var_8c5afe89[ var_b83c8859 ];
        var_37526c30.var_5e0151b9 = var_c7696383;
        
        if ( var_37526c30.gender == agent.gender )
        {
            function_3029b4d5( var_37526c30, var_e380d76b );
            var_3bc2777f = var_9b5a7338[ 6 + i ];
            function_3029b4d5( var_37526c30, var_3bc2777f );
            var_7df2d0a6 = function_67e3f98e( var_e380d76b, var_3bc2777f );
            arrayremovevalue( var_4abd20f4, var_7df2d0a6 );
            continue;
        }
        
        function_3029b4d5( var_37526c30, var_e380d76b );
        function_3029b4d5( var_37526c30, var_1edddb3d );
    }
    
    var_e7868f06 = 6;
    
    for ( i = var_e7868f06; i < var_74a258da.size ; i++ )
    {
        var_9af06a57 = var_8c5afe89[ var_74a258da[ i ] ];
        rand = function_c9e9e505( seed, var_4abd20f4.size );
        seed = rand.seed;
        var_6eb170c5 = rand.rand;
        var_7df2d0a6 = var_4abd20f4[ var_6eb170c5 ];
        arrayremoveindex( var_4abd20f4, var_6eb170c5, 0 );
        var_fe37e068 = function_5bae38de( var_7df2d0a6 );
        function_3029b4d5( var_9af06a57, var_fe37e068[ 0 ] );
        function_3029b4d5( var_9af06a57, var_fe37e068[ 1 ] );
    }
    
    randresult = function_cd12badd( seed, var_df0623ff );
    seed = randresult.seed;
    var_4c3294fc = randresult.scrambled;
    var_c39fbc24 = 0;
    
    for ( i = 0; i < var_8c5afe89.size ; i++ )
    {
        var_9af06a57 = var_8c5afe89[ i ];
        function_3029b4d5( var_9af06a57, var_4c3294fc[ var_c39fbc24 ] );
        var_c39fbc24 = ( var_c39fbc24 + 1 ) % var_4c3294fc.size;
        rand = function_c9e9e505( seed, 100 );
        seed = rand.seed;
        var_8654a011 = rand.rand < 50;
        
        if ( var_8654a011 )
        {
            function_3029b4d5( var_9af06a57, var_4c3294fc[ var_c39fbc24 ] );
            var_c39fbc24 = ( var_c39fbc24 + 1 ) % var_4c3294fc.size;
        }
    }
    
    /#
        function_5909fc47();
        function_ce468ae0();
    #/
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0, eflags: 0x4
// Checksum 0x8d1ad20b, Offset: 0xbb8
// Size: 0xec
function private function_68b722e5()
{
    level.var_60eee92e = getscriptbundle( #"hash_2751bd581e249cb1" );
    
    foreach ( var_9af06a57 in level.var_60eee92e.var_c363cb12 )
    {
        if ( !isdefined( var_9af06a57.gender ) )
        {
            var_9af06a57.gender = 0;
        }
    }
    
    assert( 32 >= level.var_60eee92e.locations.size );
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 2, eflags: 0x4
// Checksum 0xccc32399, Offset: 0xcb0
// Size: 0xd4
function private function_cd12badd( seed, array )
{
    arraysize = array.size;
    
    for ( i = 0; i < arraysize ; i++ )
    {
        rand = function_c9e9e505( seed, array.size );
        seed = rand.seed;
        temp = array[ i ];
        array[ i ] = array[ rand.rand ];
        array[ rand.rand ] = temp;
    }
    
    return { #scrambled:array, #seed:seed };
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 2, eflags: 0x4
// Checksum 0x28250f43, Offset: 0xd90
// Size: 0x13c
function private function_3029b4d5( var_9af06a57, locationindex )
{
    if ( !isdefined( var_9af06a57.var_19c811ef ) )
    {
        var_9af06a57.var_19c811ef = [ locationindex ];
        return;
    }
    
    inserted = 0;
    
    for ( i = 0; i < var_9af06a57.var_19c811ef.size ; i++ )
    {
        if ( locationindex < var_9af06a57.var_19c811ef[ i ] )
        {
            arrayinsert( var_9af06a57.var_19c811ef, locationindex, i );
            inserted = 1;
            break;
        }
    }
    
    if ( !inserted )
    {
        if ( !isdefined( var_9af06a57.var_19c811ef ) )
        {
            var_9af06a57.var_19c811ef = [];
        }
        else if ( !isarray( var_9af06a57.var_19c811ef ) )
        {
            var_9af06a57.var_19c811ef = array( var_9af06a57.var_19c811ef );
        }
        
        var_9af06a57.var_19c811ef[ var_9af06a57.var_19c811ef.size ] = locationindex;
    }
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 2, eflags: 0x4
// Checksum 0xf3a929f, Offset: 0xed8
// Size: 0x44
function private function_67e3f98e( var_bf78d6e8, var_7a1b4c82 )
{
    if ( var_bf78d6e8 < var_7a1b4c82 )
    {
        return ( ( var_bf78d6e8 << 5 ) + var_7a1b4c82 );
    }
    
    return ( var_7a1b4c82 << 5 ) + var_bf78d6e8;
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 1, eflags: 0x4
// Checksum 0xb2d19d08, Offset: 0xf28
// Size: 0x58
function private function_5bae38de( var_3f1daf6b )
{
    var_bf78d6e8 = var_3f1daf6b >> 5;
    var_7a1b4c82 = var_3f1daf6b & 32 - 1;
    return [ var_bf78d6e8, var_7a1b4c82 ];
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0
// Checksum 0x8a0233d, Offset: 0xf88
// Size: 0x654
function function_eadf5d0b()
{
    if ( scripted_widgets::exists( #"hash_34f10865afcf9af7" ) )
    {
        function_2340e15a();
    }
    
    scripted_widgets::create( #"hash_34f10865afcf9af7", #"hash_71e7e2f7f0dd39e" );
    scripted_widgets::function_d3c3e5c3( #"hash_34f10865afcf9af7", #"interactive_map" );
    assert( isdefined( level.var_60eee92e ) );
    var_2b322539 = level.var_60eee92e.var_c363cb12;
    var_8c78fd5a = level.var_60eee92e.locations;
    scripted_widgets::function_9ade1d9b( #"hash_34f10865afcf9af7", "SuspectName", #"" );
    scripted_widgets::function_9ade1d9b( #"hash_34f10865afcf9af7", "Alias", #"" );
    scripted_widgets::function_9ade1d9b( #"hash_34f10865afcf9af7", "Gender", #"" );
    scripted_widgets::function_9ade1d9b( #"hash_34f10865afcf9af7", "DateOfBirth", #"" );
    scripted_widgets::function_9ade1d9b( #"hash_34f10865afcf9af7", "IsMarked", 0 );
    scripted_widgets::function_9ade1d9b( #"hash_34f10865afcf9af7", "IsCompleted", 0 );
    globallogic_ui::function_9ed5232e( "evidenceboard_review_suspect.numSuspectsMarked", 0 );
    var_8f36ce4a = 0;
    var_a24e9150 = savegame::function_2ee66e93( #"hash_470832ca3fa7ae83" );
    
    if ( !isdefined( var_a24e9150 ) )
    {
        var_a24e9150 = [];
    }
    
    foreach ( index, var_7253f96e in var_2b322539 )
    {
        if ( !isdefined( var_a24e9150[ index ] ) )
        {
            var_a24e9150[ index ] = spawnstruct();
            var_a24e9150[ index ].ismarked = 0;
        }
        
        is_marked = is_true( var_a24e9150[ index ].ismarked );
        
        if ( is_marked )
        {
            var_8f36ce4a++;
        }
        
        scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", index, "IsMarked", is_marked );
        scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", index, "IsCompleted", 0 );
        scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", index, "SuspectName", var_7253f96e.name );
        scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", index, "Alias", var_7253f96e.alias );
        var_835e07cd = #"hash_382e77cb4d185802";
        
        if ( var_7253f96e.gender == 0 )
        {
            var_835e07cd = #"hash_690977d15de371cb";
        }
        
        scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", index, "Gender", var_835e07cd );
        scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", index, "DateOfBirth", var_7253f96e.dateofbirth );
        scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", index, "Thumbnail", var_7253f96e.thumbnail );
        
        foreach ( list_index, location_index in var_7253f96e.var_19c811ef )
        {
            location_data = var_8c78fd5a[ location_index ];
            scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", index, "Location" + list_index, location_data.var_2f94fe81 );
        }
    }
    
    self globallogic_ui::function_9ed5232e( "evidenceboard_review_suspect.numSuspectsMarked", var_8f36ce4a );
    self globallogic_ui::function_9ed5232e( "evidenceboard_review_suspect.maxSuspectsMarked", var_8f36ce4a >= 3 );
    savegame::set_player_data( #"hash_470832ca3fa7ae83", var_a24e9150 );
    scripted_widgets::set_focus( #"hash_34f10865afcf9af7", 1 );
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0
// Checksum 0x1126c045, Offset: 0x15e8
// Size: 0x6c
function function_2340e15a()
{
    if ( scripted_widgets::exists( #"hash_34f10865afcf9af7" ) )
    {
        scripted_widgets::set_focus( #"hash_34f10865afcf9af7", 0 );
        scripted_widgets::remove( #"hash_34f10865afcf9af7" );
    }
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0
// Checksum 0xcb8b422d, Offset: 0x1660
// Size: 0x34
function function_f9edf6c2()
{
    if ( isdefined( level.var_60eee92e.var_c363cb12 ) )
    {
        return level.var_60eee92e.var_c363cb12.size;
    }
    
    return 0;
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 1
// Checksum 0xb24b4687, Offset: 0x16a0
// Size: 0x17c
function function_407ee527( var_5a95d718 )
{
    var_8f36ce4a = globallogic_ui::function_f053dcd4( "evidenceboard_review_suspect.numSuspectsMarked" );
    var_8f86ece5 = var_8f36ce4a >= 3;
    is_marked = scripted_widgets::function_82e355ff( #"hash_34f10865afcf9af7", "list." + var_5a95d718 + ".IsMarked" );
    
    if ( isdefined( var_8f86ece5 ) && isdefined( is_marked ) )
    {
        if ( !var_8f86ece5 || is_marked )
        {
            if ( !is_marked )
            {
                var_8f36ce4a++;
            }
            else
            {
                var_8f36ce4a--;
            }
            
            is_marked = !is_marked;
        }
    }
    
    scripted_widgets::function_f2a9266( #"hash_34f10865afcf9af7", var_5a95d718, "IsMarked", is_marked );
    var_a24e9150 = savegame::function_2ee66e93( #"hash_470832ca3fa7ae83" );
    var_a24e9150[ var_5a95d718 ].ismarked = is_marked;
    self globallogic_ui::function_9ed5232e( "evidenceboard_review_suspect.numSuspectsMarked", var_8f36ce4a );
    self globallogic_ui::function_9ed5232e( "evidenceboard_review_suspect.maxSuspectsMarked", var_8f36ce4a >= 3 );
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0
// Checksum 0x463e3c1, Offset: 0x1828
// Size: 0xa4
function function_8806cc63()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_bd597cf5 = function_c83dffcf();
    player function_67355ff9( #"ledger", var_bd597cf5[ 0 ].var_45f26a8c, var_bd597cf5[ 1 ].var_45f26a8c, var_bd597cf5[ 2 ].var_45f26a8c );
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0
// Checksum 0x9c67755, Offset: 0x18d8
// Size: 0xa4
function function_be9f0a9e()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_bd597cf5 = function_c83dffcf();
    player function_67355ff9( #"hash_c2786a93a546ce9", var_bd597cf5[ 0 ].var_8ef24e96, var_bd597cf5[ 1 ].var_8ef24e96, var_bd597cf5[ 2 ].var_8ef24e96 );
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0
// Checksum 0xffec968, Offset: 0x1988
// Size: 0xa4
function function_a084acb9()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_bd597cf5 = function_c83dffcf();
    player function_67355ff9( #"deaddrop", var_bd597cf5[ 0 ].var_ae185984, var_bd597cf5[ 1 ].var_ae185984, var_bd597cf5[ 2 ].var_ae185984 );
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 0, eflags: 0x4
// Checksum 0xb03b9ac9, Offset: 0x1a38
// Size: 0x1f8
function private function_c83dffcf()
{
    var_9bd695ca = [];
    
    for ( var_9e5e6a99 = 0; var_9e5e6a99 < level.var_60eee92e.var_c363cb12.size ; var_9e5e6a99++ )
    {
        var_9af06a57 = level.var_60eee92e.var_c363cb12[ var_9e5e6a99 ];
        
        if ( !isdefined( var_9af06a57.var_11faa37b ) )
        {
            continue;
        }
        
        var_38f902ab = level.var_60eee92e.agents[ var_9af06a57.var_11faa37b ];
        keyinfo = {};
        
        if ( var_9af06a57.gender == 0 )
        {
            keyinfo.var_8ef24e96 = var_38f902ab.var_12e0f108;
        }
        else
        {
            keyinfo.var_8ef24e96 = var_38f902ab.var_389ce4eb;
        }
        
        for ( var_3bca6920 = 0; var_3bca6920 < var_9af06a57.var_19c811ef.size ; var_3bca6920++ )
        {
            var_6cbd0d9c = var_9af06a57.var_19c811ef[ var_3bca6920 ];
            locationdata = level.var_60eee92e.locations[ var_6cbd0d9c ];
            
            if ( is_true( locationdata.var_59a4d624 ) )
            {
                if ( !isdefined( keyinfo.var_45f26a8c ) )
                {
                    keyinfo.var_45f26a8c = locationdata.var_2f94fe81;
                    continue;
                }
                
                assert( !isdefined( keyinfo.var_ae185984 ) );
                keyinfo.var_ae185984 = locationdata.var_2f94fe81;
            }
        }
        
        assert( !isdefined( var_9bd695ca[ var_9af06a57.var_11faa37b ] ) );
        var_9bd695ca[ var_9af06a57.var_11faa37b ] = keyinfo;
    }
    
    return var_9bd695ca;
}

// Namespace namespace_46c3c08e/namespace_46c3c08e
// Params 4, eflags: 0x4
// Checksum 0x46088981, Offset: 0x1c38
// Size: 0x16c
function private function_67355ff9( evidenceType, beardedLadyLocString, strongManLocString, jugglerLocString )
{
    player = self;
    scripted_widgets::create( #"hash_5fbe0a5a2e82c156", #"hash_780065c4d8d28b79" );
    scripted_widgets::function_d3c3e5c3( #"hash_5fbe0a5a2e82c156", #"interactive_map" );
    scripted_widgets::function_9ade1d9b( #"hash_5fbe0a5a2e82c156", "evidenceType", evidenceType );
    scripted_widgets::function_9ade1d9b( #"hash_5fbe0a5a2e82c156", "beardedLadyLocString", beardedLadyLocString );
    scripted_widgets::function_9ade1d9b( #"hash_5fbe0a5a2e82c156", "strongManLocString", strongManLocString );
    scripted_widgets::function_9ade1d9b( #"hash_5fbe0a5a2e82c156", "jugglerLocString", jugglerLocString );
    player waittill( #"ui_cancel" );
    scripted_widgets::remove( #"hash_5fbe0a5a2e82c156" );
}

/#

    // Namespace namespace_46c3c08e/namespace_46c3c08e
    // Params 1, eflags: 0x4
    // Checksum 0x11cf6790, Offset: 0x1db0
    // Size: 0x12c, Type: dev
    function private function_6b507fee( params )
    {
        if ( params.value > 0 )
        {
            setdvar( #"hash_35aadcf302a6bd3a", 0 );
            
            if ( isdefined( level.var_60eee92e ) )
            {
                foreach ( var_9af06a57 in level.var_60eee92e.var_c363cb12 )
                {
                    var_9af06a57.var_19c811ef = undefined;
                    var_9af06a57.var_11faa37b = undefined;
                    var_9af06a57.var_5e0151b9 = undefined;
                }
                
                level.var_60eee92e = undefined;
            }
            
            var_56ce02e1 = params.value > 1;
            generate_solution( var_56ce02e1 );
        }
    }

    // Namespace namespace_46c3c08e/namespace_46c3c08e
    // Params 0, eflags: 0x4
    // Checksum 0x2db2d542, Offset: 0x1ee8
    // Size: 0x3d4, Type: dev
    function private function_5909fc47()
    {
        println( "<dev string:x51>" );
        println( "<dev string:x82>" );
        println( "<dev string:xac>" + savegame::function_2ee66e93( #"hash_6a83b769c50b79d2", "<dev string:xb7>" ) + "<dev string:xbc>" );
        println( "<dev string:x51>" );
        
        for ( var_9e5e6a99 = 0; var_9e5e6a99 < level.var_60eee92e.var_c363cb12.size ; var_9e5e6a99++ )
        {
            var_9af06a57 = level.var_60eee92e.var_c363cb12[ var_9e5e6a99 ];
            println( "<dev string:xc1>" + var_9e5e6a99 + "<dev string:xc9>" );
            
            if ( isdefined( var_9af06a57.var_11faa37b ) )
            {
                alias = level.var_60eee92e.agents[ var_9af06a57.var_11faa37b ].alias;
                println( "<dev string:xd1>" + makelocalizedstring( alias ) + "<dev string:xbc>" );
            }
            
            if ( isdefined( var_9af06a57.var_5e0151b9 ) )
            {
                var_401f3c2b = level.var_60eee92e.var_c363cb12[ var_9af06a57.var_5e0151b9 ];
                assert( isdefined( var_401f3c2b.var_11faa37b ) );
                alias = level.var_60eee92e.agents[ var_401f3c2b.var_11faa37b ].alias;
                println( "<dev string:xdc>" + makelocalizedstring( alias ) + "<dev string:xbc>" );
            }
            
            println( "<dev string:xf2>" + makelocalizedstring( var_9af06a57.name ) );
            
            if ( var_9af06a57.gender == 0 )
            {
                println( "<dev string:xfc>" );
            }
            else
            {
                println( "<dev string:x109>" );
            }
            
            println( "<dev string:x116>" );
            
            for ( var_3bca6920 = 0; var_3bca6920 < var_9af06a57.var_19c811ef.size ; var_3bca6920++ )
            {
                var_6cbd0d9c = var_9af06a57.var_19c811ef[ var_3bca6920 ];
                locationdata = level.var_60eee92e.locations[ var_6cbd0d9c ];
                var_5eda5d43 = "<dev string:x129>";
                
                if ( is_true( locationdata.var_59a4d624 ) )
                {
                    var_5eda5d43 = "<dev string:x12d>";
                }
                
                println( "<dev string:x135>" + var_6cbd0d9c + "<dev string:x145>" + makelocalizedstring( locationdata.var_2f94fe81 ) + var_5eda5d43 );
            }
            
            println( "<dev string:x14b>" );
        }
    }

    // Namespace namespace_46c3c08e/namespace_46c3c08e
    // Params 0, eflags: 0x4
    // Checksum 0x885bf2d, Offset: 0x22c8
    // Size: 0x2f4, Type: dev
    function private function_ce468ae0()
    {
        println( "<dev string:x51>" );
        println( "<dev string:x150>" );
        println( "<dev string:x51>" );
        var_3dc3d90a = level.var_60eee92e.var_c363cb12;
        
        for ( var_49d3a37d = 0; var_49d3a37d < var_3dc3d90a.size ; var_49d3a37d++ )
        {
            for ( var_d977e4b9 = var_49d3a37d + 1; var_d977e4b9 < var_3dc3d90a.size ; var_d977e4b9++ )
            {
                var_960966f2 = var_3dc3d90a[ var_49d3a37d ];
                var_ed14221d = var_3dc3d90a[ var_d977e4b9 ];
                
                if ( var_960966f2.gender == var_ed14221d.gender )
                {
                    var_b960cd6c = [];
                    
                    for ( i = 0; i < var_960966f2.var_19c811ef.size ; i++ )
                    {
                        locindex = var_960966f2.var_19c811ef[ i ];
                        
                        if ( is_true( level.var_60eee92e.locations[ locindex ].var_59a4d624 ) )
                        {
                            if ( !isdefined( var_b960cd6c ) )
                            {
                                var_b960cd6c = [];
                            }
                            else if ( !isarray( var_b960cd6c ) )
                            {
                                var_b960cd6c = array( var_b960cd6c );
                            }
                            
                            var_b960cd6c[ var_b960cd6c.size ] = locindex;
                        }
                    }
                    
                    var_bf580ad5 = [];
                    
                    for ( i = 0; i < var_ed14221d.var_19c811ef.size ; i++ )
                    {
                        locindex = var_ed14221d.var_19c811ef[ i ];
                        
                        if ( is_true( level.var_60eee92e.locations[ locindex ].var_59a4d624 ) )
                        {
                            if ( !isdefined( var_bf580ad5 ) )
                            {
                                var_bf580ad5 = [];
                            }
                            else if ( !isarray( var_bf580ad5 ) )
                            {
                                var_bf580ad5 = array( var_bf580ad5 );
                            }
                            
                            var_bf580ad5[ var_bf580ad5.size ] = locindex;
                        }
                    }
                    
                    if ( var_b960cd6c[ 0 ] == var_bf580ad5[ 0 ] && var_b960cd6c[ 1 ] == var_bf580ad5[ 1 ] )
                    {
                        assertmsg( "<dev string:x17c>" + var_49d3a37d + "<dev string:x1aa>" + var_d977e4b9 + "<dev string:x1b5>" );
                    }
                }
            }
        }
        
        println( "<dev string:x1c1>" );
    }

#/
