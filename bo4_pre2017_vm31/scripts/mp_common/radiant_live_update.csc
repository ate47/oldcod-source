#using scripts/core_common/system_shared;

#namespace radiant_live_update;

/#

    // Namespace radiant_live_update/radiant_live_update
    // Params 0, eflags: 0x2
    // Checksum 0x3351cb51, Offset: 0xa8
    // Size: 0x34, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "radiant_live_update", &__init__, undefined, undefined );
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 0
    // Checksum 0xc7382410, Offset: 0xe8
    // Size: 0x1c, Type: dev
    function __init__()
    {
        thread scriptstruct_debug_render();
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 0
    // Checksum 0x3f25be8, Offset: 0x110
    // Size: 0x7c, Type: dev
    function scriptstruct_debug_render()
    {
        while ( true )
        {
            waitresult = level waittill( "liveupdate" );
            
            if ( isdefined( waitresult.selected_struct ) )
            {
                level thread render_struct( waitresult.selected_struct );
                continue;
            }
            
            level notify( #"stop_struct_render" );
        }
    }

    // Namespace radiant_live_update/radiant_live_update
    // Params 1
    // Checksum 0xaa5a3e25, Offset: 0x198
    // Size: 0x96, Type: dev
    function render_struct( selected_struct )
    {
        self endon( #"stop_struct_render" );
        
        if ( !isdefined( selected_struct.origin ) )
        {
            return;
        }
        
        while ( isdefined( selected_struct ) )
        {
            box( selected_struct.origin, ( -16, -16, -16 ), ( 16, 16, 16 ), 0, ( 1, 0.4, 0.4 ) );
            waitframe( 1 );
        }
    }

#/
