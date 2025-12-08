#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;

#namespace cheat;

// Namespace cheat/cheat
// Params 0, eflags: 0x6
// Checksum 0x267a7aff, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"cheat", &preinit, undefined, undefined, undefined );
}

// Namespace cheat/cheat
// Params 0, eflags: 0x4
// Checksum 0xf35fce8, Offset: 0xe0
// Size: 0x5c
function private preinit()
{
    level.var_62079b93 = [];
    level.var_6722c38a = [];
    level.var_8c80c829 = [];
    level flag::init( "has_cheated" );
    level thread death_monitor();
}

// Namespace cheat/cheat
// Params 0
// Checksum 0x3861a913, Offset: 0x148
// Size: 0x1c
function player_init()
{
    self thread function_ae608e1a();
}

// Namespace cheat/cheat
// Params 0
// Checksum 0x5957dcc8, Offset: 0x170
// Size: 0x14
function death_monitor()
{
    function_e380068d();
}

// Namespace cheat/cheat
// Params 0
// Checksum 0x9e959e8c, Offset: 0x190
// Size: 0x6c
function function_e380068d()
{
    /#
        for ( index = 0; index < level.var_8c80c829.size ; index++ )
        {
            setdvar( level.var_8c80c829[ index ], level.var_62079b93[ level.var_8c80c829[ index ] ] );
        }
    #/
}

// Namespace cheat/cheat
// Params 2
// Checksum 0x5bc32a20, Offset: 0x208
// Size: 0x96
function function_8fb30e85( var_db66e5f5, var_beef13ae )
{
    /#
        setdvar( var_db66e5f5, 0 );
    #/
    
    level.var_62079b93[ var_db66e5f5 ] = getdvarint( var_db66e5f5, 0 );
    level.var_6722c38a[ var_db66e5f5 ] = var_beef13ae;
    
    if ( level.var_62079b93[ var_db66e5f5 ] )
    {
        [[ var_beef13ae ]]( level.var_62079b93[ var_db66e5f5 ] );
    }
}

// Namespace cheat/cheat
// Params 1
// Checksum 0xac2205f0, Offset: 0x2a8
// Size: 0x96
function function_7f7b42b7( var_db66e5f5 )
{
    var_d8568d2f = getdvarint( var_db66e5f5, 0 );
    
    if ( level.var_62079b93[ var_db66e5f5 ] == var_d8568d2f )
    {
        return;
    }
    
    if ( var_d8568d2f )
    {
        level flag::set( "has_cheated" );
    }
    
    level.var_62079b93[ var_db66e5f5 ] = var_d8568d2f;
    [[ level.var_6722c38a[ var_db66e5f5 ] ]]( var_d8568d2f );
}

// Namespace cheat/cheat
// Params 0
// Checksum 0xb8a2a8ea, Offset: 0x348
// Size: 0xb8
function function_ae608e1a()
{
    level endon( #"unloaded" );
    function_8fb30e85( "sf_use_ignoreammo", &function_b68f06ea );
    level.var_8c80c829 = getarraykeys( level.var_62079b93 );
    
    for ( ;; )
    {
        for ( index = 0; index < level.var_8c80c829.size ; index++ )
        {
            function_7f7b42b7( level.var_8c80c829[ index ] );
        }
        
        wait 0.5;
    }
}

// Namespace cheat/cheat
// Params 1
// Checksum 0xb58a22bb, Offset: 0x408
// Size: 0x64
function function_b68f06ea( var_d8568d2f )
{
    if ( var_d8568d2f )
    {
        setsaveddvar( #"player_sustainammo", 1 );
        return;
    }
    
    setsaveddvar( #"player_sustainammo", 0 );
}

// Namespace cheat/cheat
// Params 0
// Checksum 0x1a6cfa66, Offset: 0x478
// Size: 0x22
function is_cheating()
{
    return level flag::get( "has_cheated" );
}

