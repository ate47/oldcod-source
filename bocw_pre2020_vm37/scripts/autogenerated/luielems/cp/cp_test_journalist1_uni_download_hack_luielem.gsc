#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace cp_test_journalist1_uni_download_hack_luielem;

// Namespace cp_test_journalist1_uni_download_hack_luielem
// Method(s) 7 Total 14
class class_b201538a : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_b201538a/cp_test_journalist1_uni_download_hack_luielem
    // Params 2
    // Checksum 0x8df90c28, Offset: 0x2c8
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_b201538a/cp_test_journalist1_uni_download_hack_luielem
    // Params 1
    // Checksum 0xb29724f8, Offset: 0x310
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_b201538a/cp_test_journalist1_uni_download_hack_luielem
    // Params 0
    // Checksum 0x932de0d1, Offset: 0x250
    // Size: 0x6c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "cp_test_journalist1_uni_download_hack_luielem" );
        cluielem::add_clientfield( "_state", 1, 2, "int" );
        cluielem::add_clientfield( "download_progress", 1, 7, "float" );
    }

    // Namespace namespace_b201538a/cp_test_journalist1_uni_download_hack_luielem
    // Params 2
    // Checksum 0xf913c0de, Offset: 0x460
    // Size: 0x44
    function function_97bf49cb( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "download_progress", value );
    }

    // Namespace namespace_b201538a/cp_test_journalist1_uni_download_hack_luielem
    // Params 2
    // Checksum 0x9c53c366, Offset: 0x340
    // Size: 0x114
    function set_state( player, state_name )
    {
        if ( #"defaultstate" == state_name )
        {
            player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "_state", 0 );
            return;
        }
        
        if ( #"paused" == state_name )
        {
            player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "_state", 1 );
            return;
        }
        
        if ( #"finished" == state_name )
        {
            player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "_state", 2 );
            return;
        }
        
        assertmsg( "<dev string:x38>" );
    }

}

// Namespace cp_test_journalist1_uni_download_hack_luielem/cp_test_journalist1_uni_download_hack_luielem
// Params 0
// Checksum 0xa0da3374, Offset: 0x100
// Size: 0x34
function register()
{
    elem = new class_b201538a();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace cp_test_journalist1_uni_download_hack_luielem/cp_test_journalist1_uni_download_hack_luielem
// Params 2
// Checksum 0xcd520476, Offset: 0x140
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace cp_test_journalist1_uni_download_hack_luielem/cp_test_journalist1_uni_download_hack_luielem
// Params 1
// Checksum 0x2ecba694, Offset: 0x180
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_test_journalist1_uni_download_hack_luielem/cp_test_journalist1_uni_download_hack_luielem
// Params 1
// Checksum 0x12f52bff, Offset: 0x1a8
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace cp_test_journalist1_uni_download_hack_luielem/cp_test_journalist1_uni_download_hack_luielem
// Params 2
// Checksum 0xbc94c045, Offset: 0x1d0
// Size: 0x28
function set_state( player, state_name )
{
    [[ self ]]->set_state( player, state_name );
}

// Namespace cp_test_journalist1_uni_download_hack_luielem/cp_test_journalist1_uni_download_hack_luielem
// Params 2
// Checksum 0xc3df2568, Offset: 0x200
// Size: 0x28
function function_97bf49cb( player, value )
{
    [[ self ]]->function_97bf49cb( player, value );
}

