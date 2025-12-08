#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_60a2f38d6d37fd6a;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_8c04284b;

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x711ffabc, Offset: 0x1a8
// Size: 0xec
function init()
{
    clientfield::register( "world", "flipCamera", 1, 2, "int", &flipcamera, 0, 0 );
    clientfield::register( "world", "setArena", 1, 5, "int", &setarena, 0, 0 );
    clientfield::register( "world", "setTOD", 1, 3, "int", &settod, 0, 0 );
    function_32d5e898();
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0xa06183c7, Offset: 0x2a0
// Size: 0x1ca
function function_32d5e898( *localclientnum )
{
    level.doa.arenas = [];
    level.doa.var_72b899ad = undefined;
    arenas = struct::get_array( "arena_center", "targetname" );
    var_7f6c6c04 = [];
    
    foreach ( arena in arenas )
    {
        order = int( arena.script_parameters );
        arena.var_13ea8aea = ( 75, 0, 0 );
        arena.var_46f3a17d = arena.var_13ea8aea + ( 0, 180, 0 );
        var_7f6c6c04[ order ] = arena;
    }
    
    id = 0;
    
    for ( index = 0; index < 100 ; index++ )
    {
        if ( isdefined( var_7f6c6c04[ index ] ) )
        {
            var_7f6c6c04[ index ].id = id;
            level.doa.arenas[ id ] = var_7f6c6c04[ index ];
            id++;
        }
    }
    
    level.doa.var_72b899ad = level.doa.arenas[ 0 ];
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 7
// Checksum 0x5debdec5, Offset: 0x478
// Size: 0x214
function flipcamera( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    level.doa.var_9d7a8c77 = bwastimejump;
    var_b2b025b1 = getlocalplayers()[ 0 ];
    height = namespace_ac2a80f5::function_ccf8a968( var_b2b025b1.doa.cameramode );
    
    if ( isdefined( level.doa.var_72b899ad.camera_max_height ) )
    {
        if ( height > level.doa.var_72b899ad.camera_max_height )
        {
            height = level.doa.var_72b899ad.camera_max_height;
        }
    }
    
    switch ( level.doa.var_9d7a8c77 )
    {
        case 0:
        case 1:
            level.doa.flipped = 0;
            namespace_ac2a80f5::function_278f20a3( level.doa.var_72b899ad.var_13ea8aea, height );
            level.doa.var_9d7a8c77 = 1;
            break;
        case 2:
            level.doa.flipped = 1;
            namespace_ac2a80f5::function_278f20a3( level.doa.var_72b899ad.var_46f3a17d, height );
            break;
    }
    
    level.var_2d592f5b = level.doa.camera_angles;
    cleanupspawneddynents();
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 7
// Checksum 0xa6e049eb, Offset: 0x698
// Size: 0xbc
function setarena( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    cleanupspawneddynents();
    level.doa.var_72b899ad = level.doa.arenas[ bwastimejump ];
    
    /#
        namespace_1e25ad94::debugmsg( "<dev string:x38>" + level.doa.var_72b899ad.script_noteworthy );
    #/
    
    namespace_9fc66ac::function_5beeba99();
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 7
// Checksum 0x27c7efdd, Offset: 0x760
// Size: 0x324
function settod( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( isdefined( level.doa.var_1fc44fbc ) )
    {
        stopradiantexploder( fieldname, level.doa.var_1fc44fbc );
        level.doa.var_1fc44fbc = undefined;
    }
    
    level.doa.var_3303cb0d = "morning";
    
    switch ( bwastimejump )
    {
        case 0:
            level.doa.var_3303cb0d = "morning";
            setworldfogactivebank( fieldname, 1 );
            break;
        case 1:
            level.doa.var_3303cb0d = "noon";
            setworldfogactivebank( fieldname, 2 );
            break;
        case 2:
            level.doa.var_3303cb0d = "dusk";
            setworldfogactivebank( fieldname, 4 );
            break;
        case 3:
            level.doa.var_3303cb0d = "night";
            setworldfogactivebank( fieldname, 8 );
            break;
        default:
            level.doa.var_3303cb0d = "morning";
            setworldfogactivebank( fieldname, 1 );
            break;
    }
    
    /#
        namespace_1e25ad94::debugmsg( "<dev string:x4a>" + level.doa.var_72b899ad.script_noteworthy + "<dev string:x54>" + level.doa.var_3303cb0d );
    #/
    
    level.doa.var_1fc44fbc = "fxexp_" + level.doa.var_72b899ad.script_noteworthy + "_" + level.doa.var_3303cb0d;
    
    /#
        namespace_1e25ad94::debugmsg( "<dev string:x6e>" + level.doa.var_1fc44fbc + "<dev string:x87>" + fieldname );
    #/
    
    playradiantexploder( fieldname, level.doa.var_1fc44fbc );
}

