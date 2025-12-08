#using script_12a356e85208ae89;
#using script_18910f59cc847b42;
#using script_20b40cfe13d341c4;
#using script_20d6a8a1b41c0add;
#using script_245f38df21b701ca;
#using script_2fbf885102bafd03;
#using script_30c7fb449869910;
#using script_30efbc1e0156ebae;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_41540e991952b0c1;
#using script_42cbbdcd1e160063;
#using script_43e930c786cc935;
#using script_45a4ac4fad69575c;
#using script_4adf64e112e9afec;
#using script_5965abece570193b;
#using script_60a2f38d6d37fd6a;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6872cf0845191c15;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_75e0a2c8a5c12652;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using script_7bf1bd99605135bf;
#using script_87f762606a9546;
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

#namespace namespace_4dae815d;

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0xc45bec7a, Offset: 0x250
// Size: 0x23c
function init()
{
    level thread function_170b90e5();
    level.var_43cd3fe5 = doa_keytrade::register();
    clientfield::register( "world", "world_state", 1, 3, "int", &function_fefe581c, 0, 0 );
    clientfield::register( "world", "doafps", 1, 1, "int", &function_8a19ab89, 0, 0 );
    clientfield::register( "world", "roundNumber", 1, 10, "int", &function_5b2f0c51, 0, 0 );
    clientfield::function_5b7d846d( "DOA_GLOBALUIMODEL_WORLDSTATE", #"doa_world", #"worldstate", 1, 3, "int", undefined, 0, 0 );
    clientfield::function_5b7d846d( "DOA_GLOBALUIMODEL_COUNTDOWN", #"doa_world", #"countdown", 1, 5, "int", undefined, 0, 0 );
    clientfield::function_5b7d846d( "DOA_GLOBALUIMODEL_ARENANUMBER", #"doa_world", #"arenanumber", 1, 4, "int", undefined, 0, 0 );
    level.doa.var_99ee4341 = &function_c69e4ad3;
    setsaveddvar( #"cg_disableearthquake", 1 );
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0x355d2255, Offset: 0x498
// Size: 0x164
function function_170b90e5()
{
    function_32d5e898();
    namespace_981c1f3c::init();
    namespace_8c04284b::init();
    namespace_77eccc4f::init();
    doa_banner::init();
    namespace_5a917022::init();
    namespace_ac2a80f5::init();
    doa_enemy::init();
    namespace_250e9486::init();
    namespace_1c2a96f9::init();
    namespace_ed80aead::init();
    namespace_268747c0::init();
    namespace_6e90e490::init();
    namespace_dfc652ee::init();
    doa_player::init();
    namespace_83eb6304::init();
    namespace_eccff4fb::init();
    namespace_e32bb68::init();
    namespace_9fc66ac::init();
    namespace_c85a46fe::init();
    doa_wild::init();
    namespace_491fa2b2::init();
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 7
// Checksum 0x1491783c, Offset: 0x608
// Size: 0x168
function function_fefe581c( localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    level notify( #"hash_6c5fd7c95b05ac71" );
    
    if ( fieldname == 1 && bwastimejump == 0 )
    {
        function_32d5e898( binitialsnap, 1 );
    }
    
    level.doa.world_state = bwastimejump;
    namespace_9fc66ac::function_65fcd877();
    level.var_fb0679ad = 0;
    
    if ( level.doa.world_state == 2 )
    {
        player = getplayers( binitialsnap )[ 0 ];
        player thread namespace_7f5aeb59::function_4d692cc4( binitialsnap, "default" );
    }
    
    if ( level.doa.world_state == 1 )
    {
        if ( isdefined( level.doa.var_99ee4341 ) )
        {
            level thread [[ level.doa.var_99ee4341 ]]( binitialsnap );
        }
    }
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 7
// Checksum 0x7fb54f17, Offset: 0x778
// Size: 0x64
function function_5b2f0c51( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    level.doa.roundnumber = bwastimejump;
    namespace_9fc66ac::function_2fc07d61();
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 2
// Checksum 0xcbd2c2ab, Offset: 0x7e8
// Size: 0x25c
function function_32d5e898( localclientnum = 0, restart = 0 )
{
    if ( !isdefined( level.doa ) )
    {
        level.doa = spawnstruct();
    }
    
    level.doa.world_state = 0;
    level.var_fb0679ad = 0;
    level.doa.cutscene = 0;
    
    if ( restart )
    {
        namespace_8c04284b::function_32d5e898( localclientnum );
        namespace_77eccc4f::function_32d5e898( localclientnum );
        doa_banner::function_32d5e898( localclientnum );
        namespace_5a917022::function_32d5e898( localclientnum );
        namespace_ac2a80f5::function_32d5e898( localclientnum );
        doa_enemy::function_32d5e898( localclientnum );
        namespace_250e9486::function_32d5e898( localclientnum );
        namespace_ed80aead::function_32d5e898( localclientnum );
        namespace_1c2a96f9::function_32d5e898( localclientnum );
        namespace_268747c0::function_32d5e898( localclientnum );
        namespace_6e90e490::function_32d5e898( localclientnum );
        namespace_dfc652ee::function_32d5e898( localclientnum );
        doa_player::function_32d5e898( localclientnum );
        namespace_eccff4fb::function_32d5e898( localclientnum );
        namespace_e32bb68::function_32d5e898( localclientnum );
        namespace_9fc66ac::function_32d5e898( localclientnum );
        namespace_c85a46fe::function_32d5e898( localclientnum );
        doa_wild::function_32d5e898( localclientnum );
        namespace_491fa2b2::function_32d5e898( localclientnum );
    }
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 7
// Checksum 0xa80a78b1, Offset: 0xa50
// Size: 0x21e
function function_8a19ab89( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    /#
        namespace_1e25ad94::debugmsg( "<dev string:x38>" + bwastimejump );
    #/
    
    if ( bwastimejump )
    {
        if ( bwastimejump && getlocalplayers().size > 1 )
        {
            setdvar( #"r_splitscreenexpandfull", 0 );
        }
        
        if ( isdefined( level.doa.var_d1aae7e4 ) )
        {
            stopradiantexploder( fieldname, level.doa.var_d1aae7e4 );
            level.doa.var_d1aae7e4 = undefined;
        }
        
        level.doa.var_d1aae7e4 = "fxexp_" + level.doa.var_72b899ad.script_noteworthy + "_FPS";
        
        /#
            namespace_1e25ad94::debugmsg( "<dev string:x47>" + level.doa.var_d1aae7e4 + "<dev string:x60>" + fieldname );
        #/
        
        playradiantexploder( fieldname, level.doa.var_d1aae7e4 );
        return;
    }
    
    setdvar( #"r_splitscreenexpandfull", 1 );
    
    if ( isdefined( level.doa.var_d1aae7e4 ) )
    {
        stopradiantexploder( fieldname, level.doa.var_d1aae7e4 );
        level.doa.var_d1aae7e4 = undefined;
    }
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 1
// Checksum 0x5e9d41a3, Offset: 0xc78
// Size: 0xc
function function_c69e4ad3( *localclientnum )
{
    
}

