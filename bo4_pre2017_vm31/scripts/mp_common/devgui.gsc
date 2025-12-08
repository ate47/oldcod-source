#using scripts/core_common/array_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/dev_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/load_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/weapons;
#using scripts/core_common/weapons_shared;
#using scripts/mp_common/killstreaks/killstreaks;

#namespace devgui;

/#

    // Namespace devgui/devgui
    // Params 0, eflags: 0x2
    // Checksum 0x7bfc626f, Offset: 0x2b8
    // Size: 0x34, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "<dev string:x28>", &__init__, undefined, undefined );
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x7d137199, Offset: 0x2f8
    // Size: 0x51c, Type: dev
    function __init__()
    {
        setdvar( "<dev string:x2f>", "<dev string:x3e>" );
        setdvar( "<dev string:x3f>", 0 );
        setdvar( "<dev string:x53>", 0 );
        setdvar( "<dev string:x6f>", 0 );
        setdvar( "<dev string:x97>", 0 );
        setdvar( "<dev string:xb9>", 0 );
        setdvar( "<dev string:xea>", "<dev string:x122>" );
        setdvar( "<dev string:x127>", "<dev string:x122>" );
        setdvar( "<dev string:x15f>", "<dev string:x122>" );
        setdvar( "<dev string:x182>", "<dev string:x122>" );
        setdvar( "<dev string:x1a1>", "<dev string:x122>" );
        setdvar( "<dev string:x1c0>", "<dev string:x122>" );
        setdvar( "<dev string:x1df>", "<dev string:x122>" );
        setdvar( "<dev string:x1fe>", "<dev string:x122>" );
        setdvar( "<dev string:x21d>", "<dev string:x122>" );
        level.attachment_cycling_dvars = [];
        level.attachment_cycling_dvars[ level.attachment_cycling_dvars.size ] = "<dev string:x182>";
        level.attachment_cycling_dvars[ level.attachment_cycling_dvars.size ] = "<dev string:x1a1>";
        level.attachment_cycling_dvars[ level.attachment_cycling_dvars.size ] = "<dev string:x1c0>";
        level.attachment_cycling_dvars[ level.attachment_cycling_dvars.size ] = "<dev string:x1df>";
        level.attachment_cycling_dvars[ level.attachment_cycling_dvars.size ] = "<dev string:x1fe>";
        level.attachment_cycling_dvars[ level.attachment_cycling_dvars.size ] = "<dev string:x21d>";
        setdvar( "<dev string:x23c>", 0 );
        setdvar( "<dev string:x254>", 0 );
        setdvar( "<dev string:x26c>", 0 );
        setdvar( "<dev string:x284>", 0 );
        setdvar( "<dev string:x29c>", 0 );
        setdvar( "<dev string:x2b4>", 0 );
        level.var_1bb167c4 = [];
        level.var_1bb167c4[ level.var_1bb167c4.size ] = "<dev string:x23c>";
        level.var_1bb167c4[ level.var_1bb167c4.size ] = "<dev string:x254>";
        level.var_1bb167c4[ level.var_1bb167c4.size ] = "<dev string:x26c>";
        level.var_1bb167c4[ level.var_1bb167c4.size ] = "<dev string:x284>";
        level.var_1bb167c4[ level.var_1bb167c4.size ] = "<dev string:x29c>";
        level.var_1bb167c4[ level.var_1bb167c4.size ] = "<dev string:x2b4>";
        level thread devgui_weapon_think();
        level thread devgui_weapon_asset_name_display_think();
        level thread devgui_player_weapons();
        level thread devgui_test_chart_think();
        level thread devgui_player_spawn_think();
        level thread devgui_vehicle_spawn_think();
        thread init_debug_center_screen();
        level thread dev::body_customization_devgui( 1 );
        callback::on_connect( &hero_art_on_player_connect );
        callback::on_connect( &on_player_connect );
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0xafdad92b, Offset: 0x820
    // Size: 0x2c, Type: dev
    function on_player_connect()
    {
        /#
            self.devguilockspawn = 0;
            self thread devgui_player_spawn();
        #/
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x224880c5, Offset: 0x858
    // Size: 0x172, Type: dev
    function devgui_player_spawn()
    {
        wait 1;
        player_devgui_base_mp = "<dev string:x2cc>";
        waitframe( 1 );
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( player != self )
            {
                continue;
            }
            
            temp = player_devgui_base_mp + player.playername + "<dev string:x2eb>" + "<dev string:x53>" + "<dev string:x2f3>" + player.playername + "<dev string:x2f5>";
            adddebugcommand( player_devgui_base_mp + player.playername + "<dev string:x2eb>" + "<dev string:x53>" + "<dev string:x2f3>" + player.playername + "<dev string:x2f5>" );
        }
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x2eb9c730, Offset: 0x9d8
    // Size: 0x188, Type: dev
    function devgui_player_spawn_think()
    {
        for ( ;; )
        {
            playername = getdvarstring( "<dev string:x53>" );
            
            if ( playername == "<dev string:x3e>" )
            {
                waitframe( 1 );
                continue;
            }
            
            players = getplayers();
            
            foreach ( player in players )
            {
                if ( player.playername != playername )
                {
                    continue;
                }
                
                player.devguilockspawn = !player.devguilockspawn;
                
                if ( player.devguilockspawn )
                {
                    player.resurrect_origin = player.origin;
                    player.resurrect_angles = player.angles;
                }
            }
            
            setdvar( "<dev string:x53>", "<dev string:x3e>" );
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0xe15b425c, Offset: 0xb68
    // Size: 0xde, Type: dev
    function devgui_vehicle_spawn_think()
    {
        waitframe( 1 );
        
        for ( ;; )
        {
            val = getdvarint( "<dev string:x2f8>" );
            
            if ( val != 0 )
            {
                if ( val == 1 )
                {
                    add_vehicle_at_eye_trace( "<dev string:x309>" );
                }
                else if ( val == 2 )
                {
                    add_vehicle_at_eye_trace( "<dev string:x312>" );
                }
                else if ( val == 3 )
                {
                    add_vehicle_at_eye_trace( "<dev string:x320>" );
                }
                
                setdvar( "<dev string:x2f8>", "<dev string:x329>" );
            }
            
            waitframe( 1 );
        }
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x40b9c82e, Offset: 0xc50
    // Size: 0x94c, Type: dev
    function devgui_player_weapons()
    {
        level endon( #"game_ended" );
        
        if ( isdefined( game.devgui_weapons_added ) && game.devgui_weapons_added )
        {
            return;
        }
        
        level flag::wait_till( "<dev string:x32b>" );
        a_weapons = enumerateweapons( "<dev string:x33f>" );
        a_weapons_mp = [];
        a_grenades_mp = [];
        a_misc_mp = [];
        
        for ( i = 0; i < a_weapons.size ; i++ )
        {
            if ( ( weapons::is_primary_weapon( a_weapons[ i ] ) || weapons::is_side_arm( a_weapons[ i ] ) ) && !killstreaks::is_killstreak_weapon( a_weapons[ i ] ) )
            {
                arrayinsert( a_weapons_mp, a_weapons[ i ], 0 );
                continue;
            }
            
            if ( weapons::is_grenade( a_weapons[ i ] ) )
            {
                arrayinsert( a_grenades_mp, a_weapons[ i ], 0 );
                continue;
            }
            
            arrayinsert( a_misc_mp, a_weapons[ i ], 0 );
        }
        
        player_devgui_base_mp = "<dev string:x346>";
        menu_index = 1;
        level thread devgui_add_player_weapons( player_devgui_base_mp, "<dev string:x362>", 0, a_weapons_mp, "<dev string:x366>", menu_index );
        menu_index++;
        level thread devgui_add_player_weapons( player_devgui_base_mp, "<dev string:x362>", 0, a_grenades_mp, "<dev string:x36b>", menu_index );
        menu_index++;
        level thread devgui_add_player_weapons( player_devgui_base_mp, "<dev string:x362>", 0, a_misc_mp, "<dev string:x374>", menu_index );
        menu_index++;
        game.devgui_weapons_added = 1;
        waitframe( 1 );
        adddebugcommand( player_devgui_base_mp + "<dev string:x379>" + "<dev string:x38d>" + "<dev string:x6f>" + "<dev string:x398>" );
        menu_index++;
        adddebugcommand( player_devgui_base_mp + "<dev string:x3a0>" + "<dev string:x38d>" + "<dev string:x3f>" + "<dev string:x398>" );
        menu_index++;
        adddebugcommand( player_devgui_base_mp + "<dev string:x3bb>" + "<dev string:x38d>" + "<dev string:x97>" + "<dev string:x398>" );
        menu_index++;
        var_8edecd6e = player_devgui_base_mp + "<dev string:x3dc>" + "<dev string:x3ee>";
        menu_index++;
        var_14928e24 = 1;
        var_e55c4df9 = 1;
        
        for ( i = 0; i <= 3 ; i++ )
        {
            adddebugcommand( var_8edecd6e + "<dev string:x3f0>" + "<dev string:x3ee>" + i + "<dev string:x2eb>" + "<dev string:xb9>" + "<dev string:x2f3>" + i + "<dev string:x3fe>" );
            var_e55c4df9++;
        }
        
        var_14928e24++;
        attachmentnames = getattachmentnames();
        var_e55c4df9 = 1;
        
        for ( i = 0; i < attachmentnames.size ; i++ )
        {
            if ( issubstr( attachmentnames[ i ], "<dev string:x402>" ) )
            {
                continue;
            }
            
            util::waittill_can_add_debug_command();
            adddebugcommand( var_8edecd6e + "<dev string:x407>" + "<dev string:x3ee>" + attachmentnames[ i ] + "<dev string:x2eb>" + "<dev string:xea>" + "<dev string:x2f3>" + attachmentnames[ i ] + "<dev string:x3fe>" );
            var_e55c4df9++;
        }
        
        var_14928e24++;
        var_e55c4df9 = 1;
        
        for ( i = 0; i < attachmentnames.size ; i++ )
        {
            if ( issubstr( attachmentnames[ i ], "<dev string:x402>" ) )
            {
                continue;
            }
            
            util::waittill_can_add_debug_command();
            adddebugcommand( var_8edecd6e + "<dev string:x414>" + "<dev string:x3ee>" + attachmentnames[ i ] + "<dev string:x2eb>" + "<dev string:x127>" + "<dev string:x2f3>" + attachmentnames[ i ] + "<dev string:x3fe>" );
            var_e55c4df9++;
        }
        
        var_14928e24++;
        waitframe( 1 );
        attachment_cycling_devgui_base_mp = player_devgui_base_mp + "<dev string:x421>" + "<dev string:x3ee>";
        adddebugcommand( attachment_cycling_devgui_base_mp + "<dev string:x434>" + "<dev string:x15f>" + "<dev string:x445>" );
        adddebugcommand( attachment_cycling_devgui_base_mp + "<dev string:x453>" + "<dev string:x15f>" + "<dev string:x462>" );
        
        for ( i = 0; i < 6 ; i++ )
        {
            attachment_cycling_sub_menu_index = 1;
            adddebugcommand( attachment_cycling_devgui_base_mp + "<dev string:x46d>" + i + 1 + "<dev string:x479>" + "<dev string:x15f>" + "<dev string:x489>" + i + "<dev string:x3fe>" );
            
            for ( attachmentname = 0; attachmentname < attachmentnames.size ; attachmentname++ )
            {
                if ( issubstr( attachmentnames[ attachmentname ], "<dev string:x402>" ) )
                {
                    continue;
                }
                
                util::waittill_can_add_debug_command();
                adddebugcommand( attachment_cycling_devgui_base_mp + "<dev string:x46d>" + i + 1 + "<dev string:x3ee>" + attachmentnames[ attachmentname ] + "<dev string:x2eb>" + "<dev string:x15f>" + "<dev string:x491>" + level.attachment_cycling_dvars[ i ] + "<dev string:x2f3>" + attachmentnames[ attachmentname ] + "<dev string:x49f>" + level.var_1bb167c4[ i ] + "<dev string:x2f3>" + 0 + "<dev string:x3fe>" );
                attachment_cycling_sub_menu_index++;
                util::waittill_can_add_debug_command();
                adddebugcommand( attachment_cycling_devgui_base_mp + "<dev string:x46d>" + i + 1 + "<dev string:x3ee>" + attachmentnames[ attachmentname ] + "<dev string:x4a6>" + "<dev string:x15f>" + "<dev string:x491>" + level.attachment_cycling_dvars[ i ] + "<dev string:x2f3>" + attachmentnames[ attachmentname ] + "<dev string:x49f>" + level.var_1bb167c4[ i ] + "<dev string:x2f3>" + 1 + "<dev string:x3fe>" );
                attachment_cycling_sub_menu_index++;
            }
            
            if ( i % 2 )
            {
                waitframe( 1 );
            }
        }
        
        level thread function_496dcd72();
        level thread devgui_attachment_cycling_think();
    }

    // Namespace devgui/devgui
    // Params 6
    // Checksum 0xbfba3732, Offset: 0x15a8
    // Size: 0x226, Type: dev
    function devgui_add_player_weapons( root, pname, index, a_weapons, weapon_type, mindex )
    {
        level endon( #"game_ended" );
        
        if ( isdedicated() )
        {
            return;
        }
        
        devgui_root = root + weapon_type + "<dev string:x3ee>";
        
        if ( isdefined( a_weapons ) )
        {
            for ( i = 0; i < a_weapons.size ; i++ )
            {
                attachments = a_weapons[ i ].supportedattachments;
                name = a_weapons[ i ].name;
                
                if ( attachments.size )
                {
                    devgui_add_player_weap_command( devgui_root + name + "<dev string:x3ee>", index, name, i + 1 );
                    
                    foreach ( att in attachments )
                    {
                        if ( att != "<dev string:x122>" )
                        {
                            devgui_add_player_weap_command( devgui_root + name + "<dev string:x3ee>", index, name + "<dev string:x4b8>" + att, i + 1 );
                        }
                    }
                    
                    continue;
                }
                
                devgui_add_player_weap_command( devgui_root, index, name, i + 1 );
            }
        }
    }

    // Namespace devgui/devgui
    // Params 4
    // Checksum 0x12983e56, Offset: 0x17d8
    // Size: 0x84, Type: dev
    function devgui_add_player_weap_command( root, pid, weap_name, cmdindex )
    {
        util::waittill_can_add_debug_command();
        adddebugcommand( root + weap_name + "<dev string:x2eb>" + "<dev string:x2f>" + "<dev string:x2f3>" + weap_name + "<dev string:x3fe>" );
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x86ede67, Offset: 0x1868
    // Size: 0x90, Type: dev
    function devgui_weapon_think()
    {
        for ( ;; )
        {
            weapon_name = getdvarstring( "<dev string:x2f>" );
            
            if ( weapon_name != "<dev string:x3e>" )
            {
                devgui_handle_player_command( &devgui_give_weapon, weapon_name );
            }
            
            setdvar( "<dev string:x2f>", "<dev string:x3e>" );
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x6a9c031e, Offset: 0x1900
    // Size: 0x24, Type: dev
    function hero_art_on_player_connect()
    {
        self._debugheromodels = spawnstruct();
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0xb63a6528, Offset: 0x1930
    // Size: 0x400, Type: dev
    function devgui_weapon_asset_name_display_think()
    {
        update_time = 1;
        print_duration = int( update_time / 0.05 );
        printlnbold_update = int( 1 / update_time );
        printlnbold_counter = 0;
        colors = [];
        colors[ colors.size ] = ( 1, 1, 1 );
        colors[ colors.size ] = ( 1, 0, 0 );
        colors[ colors.size ] = ( 0, 1, 0 );
        colors[ colors.size ] = ( 1, 1, 0 );
        colors[ colors.size ] = ( 1, 0, 1 );
        colors[ colors.size ] = ( 0, 1, 1 );
        
        for ( ;; )
        {
            wait update_time;
            display = getdvarint( "<dev string:x97>" );
            
            if ( !display )
            {
                continue;
            }
            
            if ( !printlnbold_counter )
            {
                iprintlnbold( level.players[ 0 ] getcurrentweapon().name );
            }
            
            printlnbold_counter++;
            
            if ( printlnbold_counter >= printlnbold_update )
            {
                printlnbold_counter = 0;
            }
            
            color_index = 0;
            
            for ( i = 1; i < level.players.size ; i++ )
            {
                player = level.players[ i ];
                weapon = player getcurrentweapon();
                
                if ( !isdefined( weapon ) || level.weaponnone == weapon )
                {
                    continue;
                }
                
                print3d( player gettagorigin( "<dev string:x4ba>" ), weapon.name, colors[ color_index ], 1, 0.15, print_duration );
                color_index++;
                
                if ( color_index >= colors.size )
                {
                    color_index = 0;
                }
            }
            
            color_index = 0;
            ai_list = getaiarray();
            
            for ( i = 0; i < ai_list.size ; i++ )
            {
                ai = ai_list[ i ];
                
                if ( isvehicle( ai ) )
                {
                    weapon = ai.turretweapon;
                }
                else
                {
                    weapon = ai.weapon;
                }
                
                if ( !isdefined( weapon ) || level.weaponnone == weapon )
                {
                    continue;
                }
                
                print3d( ai gettagorigin( "<dev string:x4ba>" ), weapon.name, colors[ color_index ], 1, 0.15, print_duration );
                color_index++;
                
                if ( color_index >= colors.size )
                {
                    color_index = 0;
                }
            }
        }
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x68f4f810, Offset: 0x1d38
    // Size: 0x138, Type: dev
    function function_496dcd72()
    {
        var_4f415009 = 0;
        var_5a98ebfc = "<dev string:x122>";
        var_cca05b37 = "<dev string:x122>";
        
        for ( ;; )
        {
            index = getdvarint( "<dev string:xb9>" );
            var_820a0a2e = getdvarstring( "<dev string:xea>" );
            var_5c078fc5 = getdvarstring( "<dev string:x127>" );
            
            if ( var_5a98ebfc != var_820a0a2e || var_cca05b37 != var_5c078fc5 || var_4f415009 != index )
            {
                devgui_handle_player_command( &function_5ef38019, var_820a0a2e, var_5c078fc5 );
            }
            
            var_4f415009 = index;
            var_5a98ebfc = var_820a0a2e;
            var_cca05b37 = var_5c078fc5;
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 1
    // Checksum 0x3048d5e1, Offset: 0x1e78
    // Size: 0x64, Type: dev
    function devgui_attachment_cycling_clear( index )
    {
        setdvar( level.attachment_cycling_dvars[ index ], "<dev string:x122>" );
        setdvar( level.var_1bb167c4[ index ], 0 );
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x868a6504, Offset: 0x1ee8
    // Size: 0x524, Type: dev
    function devgui_attachment_cycling_update()
    {
        currentweapon = self getcurrentweapon();
        rootweapon = currentweapon.rootweapon;
        supportedattachments = currentweapon.supportedattachments;
        textcolors = [];
        attachments = [];
        var_49dd67d4 = [];
        originalattachments = [];
        var_28bb247d = [];
        
        for ( i = 0; i < 6 ; i++ )
        {
            originalattachments[ i ] = getdvarstring( level.attachment_cycling_dvars[ i ] );
            var_28bb247d[ i ] = getdvarint( level.var_1bb167c4[ i ] );
            textcolor[ i ] = "<dev string:x4c4>";
            attachments[ i ] = "<dev string:x122>";
            var_49dd67d4[ i ] = 0;
            name = originalattachments[ i ];
            
            if ( "<dev string:x122>" == name )
            {
                continue;
            }
            
            textcolor[ i ] = "<dev string:x4c7>";
            
            for ( supportedindex = 0; supportedindex < supportedattachments.size ; supportedindex++ )
            {
                if ( name == supportedattachments[ supportedindex ] )
                {
                    textcolor[ i ] = "<dev string:x4c4>";
                    attachments[ i ] = name;
                    var_49dd67d4[ i ] = var_28bb247d[ i ];
                    break;
                }
            }
        }
        
        for ( i = 0; i < 6 ; i++ )
        {
            if ( "<dev string:x122>" == originalattachments[ i ] )
            {
                continue;
            }
            
            for ( j = i + 1; j < 6 ; j++ )
            {
                if ( originalattachments[ i ] == originalattachments[ j ] )
                {
                    textcolor[ j ] = "<dev string:x4ca>";
                    attachments[ j ] = "<dev string:x122>";
                    var_49dd67d4[ j ] = 0;
                }
            }
        }
        
        msg = "<dev string:x3e>";
        
        for ( i = 0; i < 6 ; i++ )
        {
            if ( "<dev string:x122>" == originalattachments[ i ] )
            {
                continue;
            }
            
            msg += textcolor[ i ];
            msg += i;
            msg += "<dev string:x4cd>";
            msg += originalattachments[ i ];
            msg += "<dev string:x4d0>";
            msg += var_28bb247d[ i ];
            msg += "<dev string:x4d0>";
        }
        
        iprintlnbold( msg );
        self takeweapon( currentweapon );
        currentweapon = getweapon( rootweapon.name, attachments[ 0 ], attachments[ 1 ], attachments[ 2 ], attachments[ 3 ], attachments[ 4 ], attachments[ 5 ] );
        acvi = getattachmentcosmeticvariantindexes( currentweapon, attachments[ 0 ], var_49dd67d4[ 0 ], attachments[ 1 ], var_49dd67d4[ 1 ], attachments[ 2 ], var_49dd67d4[ 2 ], attachments[ 3 ], var_49dd67d4[ 3 ], attachments[ 4 ], var_49dd67d4[ 4 ], attachments[ 5 ], var_49dd67d4[ 5 ] );
        wait 0.25;
        self giveweapon( currentweapon, undefined, acvi );
        self switchtoweapon( currentweapon );
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x9adc5017, Offset: 0x2418
    // Size: 0x178, Type: dev
    function devgui_attachment_cycling_think()
    {
        for ( ;; )
        {
            state = getdvarstring( "<dev string:x15f>" );
            setdvar( "<dev string:x15f>", "<dev string:x122>" );
            
            if ( issubstr( state, "<dev string:x4d3>" ) )
            {
                if ( "<dev string:x4da>" == state )
                {
                    for ( i = 0; i < 6 ; i++ )
                    {
                        devgui_attachment_cycling_clear( i );
                    }
                }
                else
                {
                    index = int( getsubstr( state, 6, 7 ) );
                    devgui_attachment_cycling_clear( index );
                }
                
                state = "<dev string:x4e4>";
            }
            
            if ( "<dev string:x4e4>" == state )
            {
                array::thread_all( getplayers(), &devgui_attachment_cycling_update );
            }
            
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x103bc376, Offset: 0x2598
    // Size: 0x214, Type: dev
    function devgui_test_chart_think()
    {
        waitframe( 1 );
        old_val = getdvarint( "<dev string:x4eb>" );
        
        for ( ;; )
        {
            val = getdvarint( "<dev string:x4eb>" );
            
            if ( old_val != val )
            {
                if ( isdefined( level.test_chart_model ) )
                {
                    level.test_chart_model delete();
                    level.test_chart_model = undefined;
                }
                
                if ( val )
                {
                    player = getplayers()[ 0 ];
                    direction = player getplayerangles();
                    direction_vec = anglestoforward( ( 0, direction[ 1 ], 0 ) );
                    scale = 120;
                    direction_vec = ( direction_vec[ 0 ] * scale, direction_vec[ 1 ] * scale, direction_vec[ 2 ] * scale );
                    level.test_chart_model = spawn( "<dev string:x500>", player geteye() + direction_vec );
                    level.test_chart_model setmodel( "<dev string:x50d>" );
                    level.test_chart_model.angles = ( 0, direction[ 1 ], 0 ) + ( 0, 90, 0 );
                }
            }
            
            old_val = val;
            waitframe( 1 );
        }
    }

    // Namespace devgui/devgui
    // Params 1
    // Checksum 0x78651b69, Offset: 0x27b8
    // Size: 0x4a4, Type: dev
    function devgui_give_weapon( weapon_name )
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        self notify( #"devgui_give_ammo" );
        self endon( #"devgui_give_ammo" );
        currentweapon = self getcurrentweapon();
        split = strtok( weapon_name, "<dev string:x4b8>" );
        
        switch ( split.size )
        {
            case 1:
            default:
                weapon = getweapon( split[ 0 ] );
                break;
            case 2:
                weapon = getweapon( split[ 0 ], split[ 1 ] );
                break;
            case 3:
                weapon = getweapon( split[ 0 ], split[ 1 ], split[ 2 ] );
                break;
            case 4:
                weapon = getweapon( split[ 0 ], split[ 1 ], split[ 2 ], split[ 3 ] );
                break;
            case 5:
                weapon = getweapon( split[ 0 ], split[ 1 ], split[ 2 ], split[ 3 ], split[ 4 ] );
                break;
        }
        
        if ( currentweapon != weapon )
        {
            if ( weapon.isgrenadeweapon )
            {
                grenades = 0;
                pweapons = self getweaponslist();
                
                foreach ( pweapon in pweapons )
                {
                    if ( pweapon != weapon && pweapon.isgrenadeweapon )
                    {
                        grenades++;
                    }
                }
                
                if ( grenades > 1 )
                {
                    foreach ( pweapon in pweapons )
                    {
                        if ( pweapon != weapon && pweapon.isgrenadeweapon )
                        {
                            grenades--;
                            self takeweapon( pweapon );
                            
                            if ( grenades < 2 )
                            {
                                break;
                            }
                        }
                    }
                }
            }
            
            if ( getdvarint( "<dev string:x6f>" ) )
            {
                adddebugcommand( "<dev string:x51e>" + weapon_name );
                waitframe( 1 );
            }
            else
            {
                self giveweapon( weapon );
                
                if ( !weapon.isgrenadeweapon )
                {
                    self switchtoweapon( weapon );
                }
            }
            
            max = weapon.maxammo;
            
            if ( max )
            {
                self setweaponammostock( weapon, max );
            }
        }
    }

    // Namespace devgui/devgui
    // Params 2
    // Checksum 0x8c2c83fb, Offset: 0x2c68
    // Size: 0x15c, Type: dev
    function function_5ef38019( var_820a0a2e, var_5c078fc5 )
    {
        assert( isdefined( self ) );
        assert( isplayer( self ) );
        assert( isalive( self ) );
        currentweapon = self getcurrentweapon();
        variant_index = getdvarint( "<dev string:xb9>" );
        acvi = getattachmentcosmeticvariantindexes( currentweapon, var_820a0a2e, variant_index, var_5c078fc5, variant_index );
        self takeweapon( currentweapon );
        wait 0.25;
        self giveweapon( currentweapon, undefined, acvi );
        self switchtoweapon( currentweapon );
    }

    // Namespace devgui/devgui
    // Params 3
    // Checksum 0x840db36c, Offset: 0x2dd0
    // Size: 0x13c, Type: dev
    function devgui_handle_player_command( playercallback, pcb_param_1, pcb_param_2 )
    {
        pid = getdvarint( "<dev string:x2f>" );
        
        if ( pid > 0 )
        {
            player = getplayers()[ pid - 1 ];
            
            if ( isdefined( player ) )
            {
                if ( isdefined( pcb_param_2 ) )
                {
                    player thread [[ playercallback ]]( pcb_param_1, pcb_param_2 );
                }
                else if ( isdefined( pcb_param_1 ) )
                {
                    player thread [[ playercallback ]]( pcb_param_1 );
                }
                else
                {
                    player thread [[ playercallback ]]();
                }
            }
        }
        else
        {
            array::thread_all( getplayers(), playercallback, pcb_param_1, pcb_param_2 );
        }
        
        setdvar( "<dev string:x2f>", "<dev string:x524>" );
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x23e0502e, Offset: 0x2f18
    // Size: 0x132, Type: dev
    function init_debug_center_screen()
    {
        zero_idle_movement = "<dev string:x329>";
        
        for ( ;; )
        {
            if ( getdvarint( "<dev string:x3f>" ) )
            {
                if ( !isdefined( level.center_screen_debug_hudelem_active ) || level.center_screen_debug_hudelem_active == 0 )
                {
                    thread debug_center_screen();
                    zero_idle_movement = getdvarstring( "<dev string:x527>" );
                    
                    if ( isdefined( zero_idle_movement ) && zero_idle_movement == "<dev string:x329>" )
                    {
                        setdvar( "<dev string:x527>", "<dev string:x53a>" );
                        zero_idle_movement = "<dev string:x53a>";
                    }
                }
            }
            else
            {
                level notify( #"hash_8e42baed" );
                
                if ( zero_idle_movement == "<dev string:x53a>" )
                {
                    setdvar( "<dev string:x527>", "<dev string:x329>" );
                    zero_idle_movement = "<dev string:x329>";
                }
            }
            
            waitframe( 1 );
        }
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x21003a1b, Offset: 0x3058
    // Size: 0x284, Type: dev
    function debug_center_screen()
    {
        level.center_screen_debug_hudelem_active = 1;
        wait 0.1;
        level.center_screen_debug_hudelem1 = newclienthudelem( level.players[ 0 ] );
        level.center_screen_debug_hudelem1.alignx = "<dev string:x53c>";
        level.center_screen_debug_hudelem1.aligny = "<dev string:x543>";
        level.center_screen_debug_hudelem1.fontscale = 1;
        level.center_screen_debug_hudelem1.alpha = 0.5;
        level.center_screen_debug_hudelem1.x = 320 - 1;
        level.center_screen_debug_hudelem1.y = 240;
        level.center_screen_debug_hudelem1 setshader( "<dev string:x54a>", 1000, 1 );
        level.center_screen_debug_hudelem2 = newclienthudelem( level.players[ 0 ] );
        level.center_screen_debug_hudelem2.alignx = "<dev string:x53c>";
        level.center_screen_debug_hudelem2.aligny = "<dev string:x543>";
        level.center_screen_debug_hudelem2.fontscale = 1;
        level.center_screen_debug_hudelem2.alpha = 0.5;
        level.center_screen_debug_hudelem2.x = 320 - 1;
        level.center_screen_debug_hudelem2.y = 240;
        level.center_screen_debug_hudelem2 setshader( "<dev string:x54a>", 1, 480 );
        level waittill( "<dev string:x550>" );
        level.center_screen_debug_hudelem1 destroy();
        level.center_screen_debug_hudelem2 destroy();
        level.center_screen_debug_hudelem_active = 0;
    }

    // Namespace devgui/devgui
    // Params 1
    // Checksum 0xcdb0201, Offset: 0x32e8
    // Size: 0x142, Type: dev
    function add_vehicle_at_eye_trace( vehiclename )
    {
        host = util::gethostplayer();
        trace = host bot::eye_trace();
        veh_spawner = getent( vehiclename + "<dev string:x569>", "<dev string:x572>" );
        vehicle = veh_spawner spawnfromspawner( vehiclename, 1, 1, 1 );
        vehicle asmrequestsubstate( "<dev string:x57d>" );
        waitframe( 1 );
        vehicle makevehicleusable();
        vehicle.origin = trace[ "<dev string:x591>" ];
        vehicle.nojumping = 1;
        vehicle thread watch_player_death();
        return vehicle;
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x4d7472dd, Offset: 0x3438
    // Size: 0x96, Type: dev
    function watch_player_death()
    {
        self endon( #"death" );
        vehicle = self;
        
        while ( true )
        {
            driver = self getseatoccupant( 0 );
            
            if ( isdefined( driver ) && !isalive( driver ) )
            {
                driver unlink();
            }
            
            waitframe( 1 );
        }
    }

    // Namespace devgui/devgui
    // Params 0
    // Checksum 0x7a220c27, Offset: 0x34d8
    // Size: 0x54, Type: dev
    function devgui_add_ve_map_switches()
    {
        adddebugcommand( "<dev string:x59a>" );
        adddebugcommand( "<dev string:x5e8>" );
        adddebugcommand( "<dev string:x640>" );
    }

#/
