#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/dev;
#using scripts/mp_common/util;

#namespace dev_class;

/#

    // Namespace dev_class/dev_class
    // Params 0
    // Checksum 0xa9e05084, Offset: 0x108
    // Size: 0x638, Type: dev
    function dev_cac_init()
    {
        dev_cac_overlay = 0;
        dev_cac_camera_on = 0;
        level thread dev_cac_gdt_update_think();
        
        for ( ;; )
        {
            wait 0.5;
            reset = 1;
            
            if ( getdvarstring( "<dev string:x28>" ) != "<dev string:x3a>" )
            {
                continue;
            }
            
            host = util::gethostplayer();
            
            if ( !isdefined( level.dev_cac_player ) )
            {
                level.dev_cac_player = host;
            }
            
            switch ( getdvarstring( "<dev string:x3b>" ) )
            {
                case #"":
                    reset = 0;
                    break;
                case #"dpad_body":
                    host thread dev_cac_dpad_think( "<dev string:x54>", &dev_cac_cycle_body, "<dev string:x3a>" );
                    break;
                case #"dpad_head":
                    host thread dev_cac_dpad_think( "<dev string:x63>", &dev_cac_cycle_head, "<dev string:x3a>" );
                    break;
                case #"dpad_character":
                    host thread dev_cac_dpad_think( "<dev string:x77>", &dev_cac_cycle_character, "<dev string:x3a>" );
                    break;
                case #"next_player":
                    dev_cac_cycle_player( 1 );
                    break;
                case #"prev_player":
                    dev_cac_cycle_player( 0 );
                    break;
                case #"cac_overlay":
                    level notify( #"dev_cac_overlay_think" );
                    
                    if ( !dev_cac_overlay )
                    {
                        level thread dev_cac_overlay_think();
                    }
                    
                    dev_cac_overlay = !dev_cac_overlay;
                    break;
                case #"best_bullet_armor":
                    dev_cac_set_model_range( &sort_greatest, "<dev string:xb7>" );
                    break;
                case #"worst_bullet_armor":
                    dev_cac_set_model_range( &sort_least, "<dev string:xb7>" );
                    break;
                case #"best_explosive_armor":
                    dev_cac_set_model_range( &sort_greatest, "<dev string:xec>" );
                    break;
                case #"worst_explosive_armor":
                    dev_cac_set_model_range( &sort_least, "<dev string:xec>" );
                    break;
                case #"best_mobility":
                    dev_cac_set_model_range( &sort_greatest, "<dev string:x120>" );
                    break;
                case #"worst_mobility":
                    dev_cac_set_model_range( &sort_least, "<dev string:x120>" );
                    break;
                case #"camera":
                    dev_cac_camera_on = !dev_cac_camera_on;
                    dev_cac_camera( dev_cac_camera_on );
                    break;
                case #"dpad_camo":
                    host thread dev_cac_dpad_think( "<dev string:x149>", &dev_cac_cycle_render_options, "<dev string:x149>" );
                    break;
                case #"dpad_meleecamo":
                    host thread dev_cac_dpad_think( "<dev string:x15d>", &dev_cac_cycle_render_options, "<dev string:x15d>" );
                    break;
                case #"dpad_lens":
                    host thread dev_cac_dpad_think( "<dev string:x171>", &dev_cac_cycle_render_options, "<dev string:x171>" );
                    break;
                case #"dpad_reticle":
                    host thread dev_cac_dpad_think( "<dev string:x183>", &dev_cac_cycle_render_options, "<dev string:x183>" );
                    break;
                case #"dpad_reticle_color":
                    host thread dev_cac_dpad_think( "<dev string:x19e>", &dev_cac_cycle_render_options, "<dev string:x1ac>" );
                    break;
                case #"dpad_emblem":
                    host thread dev_cac_dpad_think( "<dev string:x1c6>", &dev_cac_cycle_render_options, "<dev string:x1c6>" );
                    break;
                case #"dpad_tag":
                    host thread dev_cac_dpad_think( "<dev string:x1d6>", &dev_cac_cycle_render_options, "<dev string:x1d6>" );
                    break;
                case #"dpad_facepaint_pattern":
                    host thread dev_cac_dpad_think( "<dev string:x1f1>", &dev_cac_cycle_render_options, "<dev string:x203>" );
                    break;
                case #"dpad_facepaint_color":
                    host thread dev_cac_dpad_think( "<dev string:x22a>", &dev_cac_cycle_render_options, "<dev string:x23a>" );
                    break;
                case #"dpad_reset":
                    host notify( #"dev_cac_dpad_think" );
                    break;
            }
            
            if ( reset )
            {
                setdvar( "<dev string:x3b>", "<dev string:x3a>" );
            }
        }
    }

    // Namespace dev_class/dev_class
    // Params 1
    // Checksum 0x5d5913af, Offset: 0x748
    // Size: 0xdc, Type: dev
    function dev_cac_camera( on )
    {
        if ( on )
        {
            self setclientthirdperson( 1 );
            setdvar( "<dev string:x255>", "<dev string:x269>" );
            setdvar( "<dev string:x26d>", "<dev string:x281>" );
            setdvar( "<dev string:x285>", "<dev string:x28c>" );
            return;
        }
        
        self setclientthirdperson( 0 );
        setdvar( "<dev string:x285>", getdvarstring( "<dev string:x28f>" ) );
    }

    // Namespace dev_class/dev_class
    // Params 3
    // Checksum 0x58089fdc, Offset: 0x830
    // Size: 0x208, Type: dev
    function dev_cac_dpad_think( part_name, cycle_function, tag )
    {
        self notify( #"dev_cac_dpad_think" );
        self endon( #"dev_cac_dpad_think" );
        self endon( #"disconnect" );
        iprintln( "<dev string:x29e>" + part_name + "<dev string:x2a8>" );
        iprintln( "<dev string:x2bd>" + part_name + "<dev string:x2c3>" );
        dpad_left = 0;
        dpad_right = 0;
        level.dev_cac_player thread highlight_player();
        
        for ( ;; )
        {
            self setactionslot( 3, "<dev string:x3a>" );
            self setactionslot( 4, "<dev string:x3a>" );
            
            if ( !dpad_left && self buttonpressed( "<dev string:x2d9>" ) )
            {
                [[ cycle_function ]]( 0, tag );
                dpad_left = 1;
            }
            else if ( !self buttonpressed( "<dev string:x2d9>" ) )
            {
                dpad_left = 0;
            }
            
            if ( !dpad_right && self buttonpressed( "<dev string:x2e3>" ) )
            {
                [[ cycle_function ]]( 1, tag );
                dpad_right = 1;
            }
            else if ( !self buttonpressed( "<dev string:x2e3>" ) )
            {
                dpad_right = 0;
            }
            
            waitframe( 1 );
        }
    }

    // Namespace dev_class/dev_class
    // Params 2
    // Checksum 0xdb4c34e1, Offset: 0xa40
    // Size: 0xb2, Type: dev
    function next_in_list( value, list )
    {
        if ( !isdefined( value ) )
        {
            return list[ 0 ];
        }
        
        for ( i = 0; i < list.size ; i++ )
        {
            if ( value == list[ i ] )
            {
                if ( isdefined( list[ i + 1 ] ) )
                {
                    value = list[ i + 1 ];
                }
                else
                {
                    value = list[ 0 ];
                }
                
                break;
            }
        }
        
        return value;
    }

    // Namespace dev_class/dev_class
    // Params 2
    // Checksum 0xc6e9ad48, Offset: 0xb00
    // Size: 0xbc, Type: dev
    function prev_in_list( value, list )
    {
        if ( !isdefined( value ) )
        {
            return list[ 0 ];
        }
        
        for ( i = 0; i < list.size ; i++ )
        {
            if ( value == list[ i ] )
            {
                if ( isdefined( list[ i - 1 ] ) )
                {
                    value = list[ i - 1 ];
                }
                else
                {
                    value = list[ list.size - 1 ];
                }
                
                break;
            }
        }
        
        return value;
    }

    // Namespace dev_class/dev_class
    // Params 0
    // Checksum 0xfe5456c8, Offset: 0xbc8
    // Size: 0x1a, Type: dev
    function dev_cac_set_player_model()
    {
        self.tag_stowed_back = undefined;
        self.tag_stowed_hip = undefined;
    }

    // Namespace dev_class/dev_class
    // Params 2
    // Checksum 0xed1caada, Offset: 0xbf0
    // Size: 0xfc, Type: dev
    function dev_cac_cycle_body( forward, tag )
    {
        if ( !dev_cac_player_valid() )
        {
            return;
        }
        
        player = level.dev_cac_player;
        keys = getarraykeys( level.cac_functions[ "<dev string:x2ee>" ] );
        
        if ( forward )
        {
            player.cac_body_type = next_in_list( player.cac_body_type, keys );
        }
        else
        {
            player.cac_body_type = prev_in_list( player.cac_body_type, keys );
        }
        
        player dev_cac_set_player_model();
    }

    // Namespace dev_class/dev_class
    // Params 2
    // Checksum 0x1ba28de0, Offset: 0xcf8
    // Size: 0x114, Type: dev
    function dev_cac_cycle_head( forward, tag )
    {
        if ( !dev_cac_player_valid() )
        {
            return;
        }
        
        player = level.dev_cac_player;
        keys = getarraykeys( level.cac_functions[ "<dev string:x2fd>" ] );
        
        if ( forward )
        {
            player.cac_head_type = next_in_list( player.cac_head_type, keys );
        }
        else
        {
            player.cac_head_type = prev_in_list( player.cac_head_type, keys );
        }
        
        player.cac_hat_type = "<dev string:x30c>";
        player dev_cac_set_player_model();
    }

    // Namespace dev_class/dev_class
    // Params 2
    // Checksum 0x5b8fd28c, Offset: 0xe18
    // Size: 0x114, Type: dev
    function dev_cac_cycle_character( forward, tag )
    {
        if ( !dev_cac_player_valid() )
        {
            return;
        }
        
        player = level.dev_cac_player;
        keys = getarraykeys( level.cac_functions[ "<dev string:x2ee>" ] );
        
        if ( forward )
        {
            player.cac_body_type = next_in_list( player.cac_body_type, keys );
        }
        else
        {
            player.cac_body_type = prev_in_list( player.cac_body_type, keys );
        }
        
        player.cac_hat_type = "<dev string:x30c>";
        player dev_cac_set_player_model();
    }

    // Namespace dev_class/dev_class
    // Params 2
    // Checksum 0xaf0983df, Offset: 0xf38
    // Size: 0x54, Type: dev
    function dev_cac_cycle_render_options( forward, tag )
    {
        if ( !dev_cac_player_valid() )
        {
            return;
        }
        
        level.dev_cac_player nextplayerrenderoption( tag, forward );
    }

    // Namespace dev_class/dev_class
    // Params 0
    // Checksum 0x9d526855, Offset: 0xf98
    // Size: 0x36, Type: dev
    function dev_cac_player_valid()
    {
        return isdefined( level.dev_cac_player ) && level.dev_cac_player.sessionstate == "<dev string:x311>";
    }

    // Namespace dev_class/dev_class
    // Params 1
    // Checksum 0xc847ddc4, Offset: 0xfd8
    // Size: 0x102, Type: dev
    function dev_cac_cycle_player( forward )
    {
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( forward )
            {
                level.dev_cac_player = next_in_list( level.dev_cac_player, players );
            }
            else
            {
                level.dev_cac_player = prev_in_list( level.dev_cac_player, players );
            }
            
            if ( dev_cac_player_valid() )
            {
                level.dev_cac_player thread highlight_player();
                return;
            }
        }
        
        level.dev_cac_player = undefined;
    }

    // Namespace dev_class/dev_class
    // Params 0
    // Checksum 0xb6e52498, Offset: 0x10e8
    // Size: 0x44, Type: dev
    function highlight_player()
    {
        self sethighlighted( 1 );
        wait 1;
        self sethighlighted( 0 );
    }

    // Namespace dev_class/dev_class
    // Params 0
    // Checksum 0xd52b02fb, Offset: 0x1138
    // Size: 0x6c, Type: dev
    function dev_cac_overlay_think()
    {
        hud = dev_cac_overlay_create();
        level thread dev_cac_overlay_update( hud );
        level waittill( "<dev string:x319>" );
        dev_cac_overlay_destroy( hud );
    }

    // Namespace dev_class/dev_class
    // Params 1
    // Checksum 0x5d3fb044, Offset: 0x11b0
    // Size: 0x10, Type: dev
    function dev_cac_overlay_update( hud )
    {
        
    }

    // Namespace dev_class/dev_class
    // Params 1
    // Checksum 0x52bb88bc, Offset: 0x11c8
    // Size: 0xa4, Type: dev
    function dev_cac_overlay_destroy( hud )
    {
        for ( i = 0; i < hud.menu.size ; i++ )
        {
            hud.menu[ i ] destroy();
        }
        
        hud destroy();
        setdvar( "<dev string:x32f>", "<dev string:x342>" );
    }

    // Namespace dev_class/dev_class
    // Params 0
    // Checksum 0xae24711d, Offset: 0x1278
    // Size: 0xd94, Type: dev
    function dev_cac_overlay_create()
    {
        x = -80;
        y = 140;
        menu_name = "<dev string:x344>";
        hud = dev::new_hud( menu_name, undefined, x, y, 1 );
        hud setshader( "<dev string:x352>", 185, 285 );
        hud.alignx = "<dev string:x358>";
        hud.aligny = "<dev string:x35d>";
        hud.sort = 10;
        hud.alpha = 0.6;
        hud.color = ( 0, 0, 0.5 );
        x_offset = 100;
        hud.menu[ 0 ] = dev::new_hud( menu_name, "<dev string:x361>", x + 5, y + 10, 1.3 );
        hud.menu[ 1 ] = dev::new_hud( menu_name, "<dev string:x366>", x + 5, y + 25, 1 );
        hud.menu[ 2 ] = dev::new_hud( menu_name, "<dev string:x36d>", x + 5, y + 35, 1 );
        hud.menu[ 3 ] = dev::new_hud( menu_name, "<dev string:x375>", x + 5, y + 45, 1 );
        hud.menu[ 4 ] = dev::new_hud( menu_name, "<dev string:x37d>", x + 5, y + 55, 1 );
        hud.menu[ 5 ] = dev::new_hud( menu_name, "<dev string:x38a>", x + 5, y + 70, 1 );
        hud.menu[ 6 ] = dev::new_hud( menu_name, "<dev string:x36d>", x + 5, y + 80, 1 );
        hud.menu[ 7 ] = dev::new_hud( menu_name, "<dev string:x37d>", x + 5, y + 90, 1 );
        hud.menu[ 8 ] = dev::new_hud( menu_name, "<dev string:x393>", x + 5, y + 100, 1 );
        hud.menu[ 9 ] = dev::new_hud( menu_name, "<dev string:x3a2>", x + 5, y + 110, 1 );
        hud.menu[ 10 ] = dev::new_hud( menu_name, "<dev string:x3b5>", x + 5, y + 120, 1 );
        hud.menu[ 11 ] = dev::new_hud( menu_name, "<dev string:x3c8>", x + 5, y + 135, 1 );
        hud.menu[ 12 ] = dev::new_hud( menu_name, "<dev string:x36d>", x + 5, y + 145, 1 );
        hud.menu[ 13 ] = dev::new_hud( menu_name, "<dev string:x37d>", x + 5, y + 155, 1 );
        hud.menu[ 14 ] = dev::new_hud( menu_name, "<dev string:x3d7>", x + 5, y + 170, 1 );
        hud.menu[ 15 ] = dev::new_hud( menu_name, "<dev string:x36d>", x + 5, y + 180, 1 );
        hud.menu[ 16 ] = dev::new_hud( menu_name, "<dev string:x37d>", x + 5, y + 190, 1 );
        hud.menu[ 17 ] = dev::new_hud( menu_name, "<dev string:x3e9>", x + 5, y + 205, 1 );
        hud.menu[ 18 ] = dev::new_hud( menu_name, "<dev string:x3f0>", x + 5, y + 215, 1 );
        hud.menu[ 19 ] = dev::new_hud( menu_name, "<dev string:x3f8>", x + 5, y + 225, 1 );
        hud.menu[ 20 ] = dev::new_hud( menu_name, "<dev string:x404>", x + 5, y + 235, 1 );
        hud.menu[ 21 ] = dev::new_hud( menu_name, "<dev string:x40d>", x + 5, y + 245, 1 );
        hud.menu[ 22 ] = dev::new_hud( menu_name, "<dev string:x41a>", x + 5, y + 255, 1 );
        hud.menu[ 23 ] = dev::new_hud( menu_name, "<dev string:x426>", x + 5, y + 265, 1 );
        hud.menu[ 24 ] = dev::new_hud( menu_name, "<dev string:x430>", x + 5, y + 275, 1 );
        x_offset = 65;
        hud.menu[ 25 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 35, 1 );
        hud.menu[ 26 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 45, 1 );
        hud.menu[ 27 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 55, 1 );
        x_offset = 100;
        hud.menu[ 28 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 80, 1 );
        hud.menu[ 29 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 90, 1 );
        hud.menu[ 30 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 100, 1 );
        hud.menu[ 31 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 110, 1 );
        hud.menu[ 32 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 120, 1 );
        hud.menu[ 33 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 145, 1 );
        hud.menu[ 34 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 155, 1 );
        hud.menu[ 35 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 180, 1 );
        hud.menu[ 36 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 190, 1 );
        x_offset = 65;
        hud.menu[ 37 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 215, 1 );
        hud.menu[ 38 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 225, 1 );
        hud.menu[ 39 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 235, 1 );
        hud.menu[ 40 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 245, 1 );
        hud.menu[ 41 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 255, 1 );
        hud.menu[ 42 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 265, 1 );
        hud.menu[ 43 ] = dev::new_hud( menu_name, "<dev string:x3a>", x + x_offset, y + 275, 1 );
        return hud;
    }

    // Namespace dev_class/dev_class
    // Params 1
    // Checksum 0x4bcca278, Offset: 0x2018
    // Size: 0xa8, Type: dev
    function color( value )
    {
        r = 1;
        g = 1;
        b = 0;
        color = ( 0, 0, 0 );
        
        if ( value > 0 )
        {
            r -= value;
        }
        else
        {
            g += value;
        }
        
        c = ( r, g, b );
        return c;
    }

    // Namespace dev_class/dev_class
    // Params 0
    // Checksum 0x55727b4e, Offset: 0x20c8
    // Size: 0x1d6, Type: dev
    function dev_cac_gdt_update_think()
    {
        for ( ;; )
        {
            waitresult = level waittill( "<dev string:x439>" );
            asset = waitresult.asset;
            keyvalue = waitresult.keyvalue;
            keyvalue = strtok( keyvalue, "<dev string:x444>" );
            key = keyvalue[ 0 ];
            
            switch ( key )
            {
                case #"armorbullet":
                    key = "<dev string:xb7>";
                    break;
                case #"armorexplosive":
                    key = "<dev string:xec>";
                    break;
                case #"movespeed":
                    key = "<dev string:x120>";
                    break;
                case #"sprinttimetotal":
                    key = "<dev string:x47b>";
                    break;
                case #"sprinttimecooldown":
                    key = "<dev string:x4a0>";
                    break;
                default:
                    key = undefined;
                    break;
            }
            
            if ( !isdefined( key ) )
            {
                continue;
            }
            
            value = float( keyvalue[ 1 ] );
            level.cac_attributes[ key ][ asset ] = value;
            players = getplayers();
            
            for ( i = 0; i < players.size ; i++ )
            {
            }
        }
    }

    // Namespace dev_class/dev_class
    // Params 3
    // Checksum 0x610b7060, Offset: 0x22a8
    // Size: 0xd8, Type: dev
    function sort_greatest( func, attribute, greatest )
    {
        keys = getarraykeys( level.cac_functions[ func ] );
        greatest = keys[ 0 ];
        
        for ( i = 0; i < keys.size ; i++ )
        {
            if ( level.cac_attributes[ attribute ][ keys[ i ] ] > level.cac_attributes[ attribute ][ greatest ] )
            {
                greatest = keys[ i ];
            }
        }
        
        return greatest;
    }

    // Namespace dev_class/dev_class
    // Params 3
    // Checksum 0xd84e1dfc, Offset: 0x2388
    // Size: 0xd8, Type: dev
    function sort_least( func, attribute, least )
    {
        keys = getarraykeys( level.cac_functions[ func ] );
        least = keys[ 0 ];
        
        for ( i = 0; i < keys.size ; i++ )
        {
            if ( level.cac_attributes[ attribute ][ keys[ i ] ] < level.cac_attributes[ attribute ][ least ] )
            {
                least = keys[ i ];
            }
        }
        
        return least;
    }

    // Namespace dev_class/dev_class
    // Params 2
    // Checksum 0xc99ce03a, Offset: 0x2468
    // Size: 0xcc, Type: dev
    function dev_cac_set_model_range( sort_function, attribute )
    {
        if ( !dev_cac_player_valid() )
        {
            return;
        }
        
        player = level.dev_cac_player;
        player.cac_body_type = [[ sort_function ]]( "<dev string:x2ee>", attribute );
        player.cac_head_type = [[ sort_function ]]( "<dev string:x2fd>", attribute );
        player.cac_hat_type = [[ sort_function ]]( "<dev string:x4b5>", attribute );
        player dev_cac_set_player_model();
    }

#/
