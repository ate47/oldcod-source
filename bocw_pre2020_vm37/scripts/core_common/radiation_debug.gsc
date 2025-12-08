#using script_c8d806d2487b617;
#using scripts\core_common\radiation;
#using scripts\core_common\system_shared;

#namespace radiation_debug;

/#

    // Namespace radiation_debug/radiation_debug
    // Params 0, eflags: 0x6
    // Checksum 0x2ffce5c0, Offset: 0x78
    // Size: 0x4c, Type: dev
    function private autoexec __init__system__()
    {
        system::register( #"radiation_debug", &preinit, undefined, undefined, #"radiation" );
    }

    // Namespace radiation_debug/radiation_debug
    // Params 0, eflags: 0x4
    // Checksum 0x35d9bdeb, Offset: 0xd0
    // Size: 0x4c, Type: dev
    function private preinit()
    {
        if ( !namespace_956bd4dd::function_ab99e60c() )
        {
            return;
        }
        
        level thread _setup_devgui();
        level thread function_aa32646f();
    }

    // Namespace radiation_debug/radiation_debug
    // Params 0, eflags: 0x4
    // Checksum 0x14b6f406, Offset: 0x128
    // Size: 0x20c, Type: dev
    function private _setup_devgui()
    {
        while ( !canadddebugcommand() )
        {
            waitframe( 1 );
        }
        
        path = "<dev string:x38>";
        cmd = "<dev string:x5b>";
        adddebugcommand( "<dev string:x81>" + path + "<dev string:x8f>" + cmd + "<dev string:xa4>" );
        adddebugcommand( "<dev string:x81>" + path + "<dev string:xaa>" + cmd + "<dev string:xbf>" );
        adddebugcommand( "<dev string:x81>" + path + "<dev string:xc5>" + cmd + "<dev string:xdb>" );
        adddebugcommand( "<dev string:x81>" + path + "<dev string:xe2>" + cmd + "<dev string:xf8>" );
        adddebugcommand( "<dev string:x81>" + path + "<dev string:xff>" + cmd + "<dev string:x116>" );
        path = "<dev string:x11e>";
        adddebugcommand( "<dev string:x81>" + path + "<dev string:x143>" );
        adddebugcommand( "<dev string:x81>" + path + "<dev string:x191>" );
        adddebugcommand( "<dev string:x81>" + path + "<dev string:x1f1>" );
        adddebugcommand( "<dev string:x81>" + path + "<dev string:x243>" );
    }

    // Namespace radiation_debug/radiation_debug
    // Params 0, eflags: 0x4
    // Checksum 0x33829c9, Offset: 0x340
    // Size: 0x1de, Type: dev
    function private function_aa32646f()
    {
        while ( true )
        {
            player = level.players[ 0 ];
            
            if ( getdvarint( #"hash_60cd17873710c764", 0 ) != 0 )
            {
                if ( isplayer( player ) )
                {
                    radiation::function_2f76803d( player, getdvarint( #"hash_60cd17873710c764", 0 ) );
                }
                
                setdvar( #"hash_60cd17873710c764", 0 );
            }
            
            if ( getdvarstring( #"hash_efed3201a74da29", "<dev string:x297>" ) != "<dev string:x297>" )
            {
                if ( isplayer( player ) )
                {
                    sickness = hash( getdvarstring( #"hash_efed3201a74da29", "<dev string:x297>" ) );
                    radiationlevel = radiation::function_c9c6dda1( player );
                    
                    if ( isdefined( level.radiation.levels[ radiationlevel ].sickness[ sickness ] ) )
                    {
                        radiation::function_e2336716( player, radiationlevel, sickness );
                    }
                }
                
                setdvar( #"hash_efed3201a74da29", "<dev string:x297>" );
            }
            
            waitframe( 1 );
        }
    }

#/
