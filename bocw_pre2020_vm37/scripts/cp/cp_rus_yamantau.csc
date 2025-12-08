#using script_2ca39e1874a13738;
#using script_33f9a308adf6fa4f;
#using script_616d0f01498f9128;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#using scripts\cp\cp_rus_yamantau_flashlight;
#using scripts\cp_common\util;

#namespace cp_rus_yamantau;

// Namespace cp_rus_yamantau/level_init
// Params 1, eflags: 0x40
// Checksum 0xc45504b4, Offset: 0x138
// Size: 0x1ac
function event_handler[level_init] main( *eventstruct )
{
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    level util::function_d96391ba();
    level namespace_1d4ee4f8::preload();
    level cp_rus_yamantau_flashlight::preload();
    level namespace_c8bf7287::preload();
    init_clientfields();
    load::main();
    level namespace_1d4ee4f8::postload();
    level thread cp_rus_yamantau_flashlight::postload();
    level namespace_c8bf7287::postload();
    util::waitforclient( 0 );
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 0
// Checksum 0xc324e126, Offset: 0x2f0
// Size: 0x16c
function init_clientfields()
{
    clientfield::register( "world", "cull_inside_satcom", 1, 2, "int", &function_83837ec4, 0, 0 );
    clientfield::register( "world", "cull_inside_finale", 1, 2, "int", &function_90f6a161, 0, 0 );
    clientfield::register( "world", "cull_inside_bunkerext", 1, 2, "int", &function_a2252c80, 0, 0 );
    clientfield::register( "world", "cull_outside_bunkerint", 1, 2, "int", &function_53905217, 0, 0 );
    clientfield::register( "world", "cull_inside_excavation", 1, 2, "int", &function_b3cdd37c, 0, 0 );
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 7
// Checksum 0x657a7632, Offset: 0x468
// Size: 0x84
function function_83837ec4( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 2 )
    {
        function_93620041( fieldname, "cull_inside_satcom" );
        return;
    }
    
    function_9362afb8( fieldname, "cull_inside_satcom" );
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 7
// Checksum 0xbad2eab5, Offset: 0x4f8
// Size: 0x84
function function_90f6a161( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 2 )
    {
        function_93620041( fieldname, "cull_inside_finale" );
        return;
    }
    
    function_9362afb8( fieldname, "cull_inside_finale" );
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 7
// Checksum 0x40ad803b, Offset: 0x588
// Size: 0x84
function function_a2252c80( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 2 )
    {
        function_93620041( fieldname, "cull_inside_bunkerext" );
        return;
    }
    
    function_9362afb8( fieldname, "cull_inside_bunkerext" );
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 7
// Checksum 0x8f5c1bfd, Offset: 0x618
// Size: 0x84
function function_53905217( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 2 )
    {
        function_93620041( fieldname, "cull_outside_bunkerint" );
        return;
    }
    
    function_9362afb8( fieldname, "cull_outside_bunkerint" );
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 7
// Checksum 0x6da568a2, Offset: 0x6a8
// Size: 0x84
function function_b3cdd37c( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 2 )
    {
        function_93620041( fieldname, "cull_inside_excavation" );
        return;
    }
    
    function_9362afb8( fieldname, "cull_inside_excavation" );
}

