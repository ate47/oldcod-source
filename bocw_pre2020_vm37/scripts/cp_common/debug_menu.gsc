#namespace debug_menu;

/#

    // Namespace debug_menu/debug_menu
    // Params 7
    // Checksum 0x54d14716, Offset: 0x60
    // Size: 0x17a, Type: dev
    function set_hudelem( text, x, y, scale, alpha, sort, debug_hudelem )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( sort ) )
        {
            sort = 20;
        }
        
        if ( isdefined( level.player ) && !isdefined( debug_hudelem ) )
        {
            hud = newdebughudelem( level.player );
        }
        else
        {
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
        }
        
        hud.location = 0;
        hud.alignx = "<dev string:x38>";
        hud.aligny = "<dev string:x40>";
        hud.foreground = 1;
        hud.fontscale = scale;
        hud.sort = sort;
        hud.alpha = alpha;
        hud.x = x;
        hud.y = y;
        hud.og_scale = scale;
        
        if ( isdefined( text ) )
        {
            hud settext( text );
        }
        
        return hud;
    }

    // Namespace debug_menu/debug_menu
    // Params 5
    // Checksum 0x34859e7b, Offset: 0x1e8
    // Size: 0xc4, Type: dev
    function new_hud( hud_name, msg, x, y, scale )
    {
        if ( !isdefined( level.hud_array ) )
        {
            level.hud_array = [];
        }
        
        if ( !isdefined( level.hud_array[ hud_name ] ) )
        {
            level.hud_array[ hud_name ] = [];
        }
        
        hud = set_hudelem( msg, x, y, scale );
        level.hud_array[ hud_name ][ level.hud_array[ hud_name ].size ] = hud;
        return hud;
    }

    // Namespace debug_menu/debug_menu
    // Params 1
    // Checksum 0xac6db1b7, Offset: 0x2b8
    // Size: 0x8c, Type: dev
    function function_7cafeca( hud_name )
    {
        if ( !isdefined( level.hud_array[ hud_name ] ) )
        {
            return;
        }
        
        huds = level.hud_array[ hud_name ];
        
        for ( i = 0; i < huds.size ; i++ )
        {
            function_2a064f4f( huds[ i ] );
        }
        
        level.hud_array[ hud_name ] = undefined;
    }

    // Namespace debug_menu/debug_menu
    // Params 1
    // Checksum 0xb8ce92bb, Offset: 0x350
    // Size: 0x2c, Type: dev
    function function_2a064f4f( hud )
    {
        if ( isdefined( hud ) )
        {
            hud destroy();
        }
    }

#/
