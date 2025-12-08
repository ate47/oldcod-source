#using scripts/core_common/array_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/dev_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/killcam_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/devgui;
#using scripts/mp_common/gametypes/dev_class;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hud_message;
#using scripts/mp_common/killstreaks/helicopter;
#using scripts/mp_common/killstreaks/helicopter_gunner;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/killstreaks/uav;
#using scripts/mp_common/util;

#namespace dev;

/#

    // Namespace dev/dev
    // Params 0, eflags: 0x2
    // Checksum 0xd25cf8e4, Offset: 0x470
    // Size: 0x3c, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "<dev string:x28>", &__init__, undefined, "<dev string:x2c>" );
    }

#/

// Namespace dev/dev
// Params 0
// Checksum 0xb87e1432, Offset: 0x4b8
// Size: 0x60
function __init__()
{
    callback::on_start_gametype( &init );
    callback::on_connect( &on_player_connected );
    level.devongetormakebot = &getormakebot;
}

// Namespace dev/dev
// Params 0
// Checksum 0x4f5ee60b, Offset: 0x520
// Size: 0x3a0
function init()
{
    /#
        if ( getdvarstring( "<dev string:x3c>" ) == "<dev string:x4b>" )
        {
            setdvar( "<dev string:x3c>", "<dev string:x4c>" );
        }
        
        if ( getdvarstring( "<dev string:x4e>" ) == "<dev string:x4b>" )
        {
            setdvar( "<dev string:x4e>", "<dev string:x4c>" );
        }
        
        if ( getdvarstring( "<dev string:x62>" ) == "<dev string:x4b>" )
        {
            setdvar( "<dev string:x62>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x75>" ) == "<dev string:x4b>" )
        {
            setdvar( "<dev string:x75>", "<dev string:x4c>" );
        }
        
        thread testscriptruntimeerror();
        thread testdvars();
        thread addenemyheli();
        thread addtestcarepackage();
        thread devhelipathdebugdraw();
        thread devstraferunpathdebugdraw();
        thread dev_class::dev_cac_init();
        thread globallogic_score::setplayermomentumdebug();
        setdvar( "<dev string:x90>", "<dev string:x4b>" );
        setdvar( "<dev string:x9d>", "<dev string:x4b>" );
        setdvar( "<dev string:xac>", "<dev string:x4c>" );
        thread engagement_distance_debug_toggle();
        thread equipment_dev_gui();
        thread grenade_dev_gui();
        setdvar( "<dev string:xbe>", "<dev string:x4c>" );
        level.dem_spawns = [];
        
        if ( level.gametype == "<dev string:xd8>" )
        {
            extra_spawns = [];
            extra_spawns[ 0 ] = "<dev string:xdc>";
            extra_spawns[ 1 ] = "<dev string:xf4>";
            extra_spawns[ 2 ] = "<dev string:x10c>";
            extra_spawns[ 3 ] = "<dev string:x124>";
            
            for ( i = 0; i < extra_spawns.size ; i++ )
            {
                points = getentarray( extra_spawns[ i ], "<dev string:x13c>" );
                
                if ( isdefined( points ) && points.size > 0 )
                {
                    level.dem_spawns = arraycombine( level.dem_spawns, points, 1, 0 );
                }
            }
        }
        
        for ( ;; )
        {
            updatedevsettings();
            wait 0.5;
        }
    #/
}

// Namespace dev/dev
// Params 0
// Checksum 0xe0d14ea6, Offset: 0x8c8
// Size: 0x44
function on_player_connected()
{
    /#
        if ( isdefined( level.devgui_unlimited_ammo ) && level.devgui_unlimited_ammo )
        {
            wait 1;
            self thread devgui_unlimited_ammo();
        }
    #/
}

/#

    // Namespace dev/dev
    // Params 0
    // Checksum 0xead9e265, Offset: 0x918
    // Size: 0x4ee, Type: dev
    function updatehardpoints()
    {
        var_4916b3a0 = 0;
        var_631de724 = var_4916b3a0 ? "<dev string:x146>" : "<dev string:x4b>";
        keys = getarraykeys( level.killstreaks );
        
        for ( i = 0; i < keys.size ; i++ )
        {
            dvar = level.killstreaks[ keys[ i ] ].devdvar;
            enemydvar = level.killstreaks[ keys[ i ] ].devenemydvar;
            host = util::gethostplayer();
            
            if ( isdefined( dvar ) && getdvarint( dvar ) == 1 )
            {
                if ( keys[ i ] == "<dev string:x151>" )
                {
                    if ( isdefined( level.vtol ) )
                    {
                        iprintln( "<dev string:x163>" );
                    }
                    else
                    {
                        host killstreaks::give( var_631de724 + keys[ i ] );
                    }
                }
                else
                {
                    foreach ( player in level.players )
                    {
                        if ( isdefined( level.usingscorestreaks ) && isdefined( level.usingmomentum ) && level.usingmomentum && level.usingscorestreaks )
                        {
                            player killstreaks::give( var_631de724 + keys[ i ] );
                            continue;
                        }
                        
                        if ( player isbot() )
                        {
                            player.bot[ "<dev string:x184>" ] = [];
                            player.bot[ "<dev string:x184>" ][ 0 ] = killstreaks::get_menu_name( keys[ i ] );
                            killstreakweapon = killstreaks::get_killstreak_weapon( keys[ i ] );
                            player killstreaks::give_weapon( killstreakweapon, 1 );
                            globallogic_score::_setplayermomentum( player, 2000 );
                            continue;
                        }
                        
                        player killstreaks::give( var_631de724 + keys[ i ] );
                    }
                }
                
                setdvar( dvar, "<dev string:x4c>" );
            }
            
            if ( isdefined( enemydvar ) && getdvarint( enemydvar ) == 1 )
            {
                team = "<dev string:x190>";
                player = util::gethostplayer();
                
                if ( isdefined( player.team ) )
                {
                    team = util::getotherteam( player.team );
                }
                
                ent = getormakebot( team );
                
                if ( !isdefined( ent ) )
                {
                    println( "<dev string:x19b>" );
                    continue;
                }
                
                wait 1;
                
                if ( ent isbot() )
                {
                    ent killstreaks::give( "<dev string:x146>" + keys[ i ] );
                }
                else
                {
                    ent killstreaks::give( var_631de724 + keys[ i ] );
                }
                
                setdvar( enemydvar, "<dev string:x4c>" );
            }
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0x6cb4e0b6, Offset: 0xe10
    // Size: 0x54, Type: dev
    function warpalltohost( team )
    {
        host = util::gethostplayer();
        warpalltoplayer( team, host.name );
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0x4ebd6448, Offset: 0xe70
    // Size: 0x374, Type: dev
    function warpalltoplayer( team, player )
    {
        players = getplayers();
        target = undefined;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( players[ i ].name == player )
            {
                target = players[ i ];
                break;
            }
        }
        
        if ( isdefined( target ) )
        {
            origin = target.origin;
            nodes = getnodesinradius( origin, 128, 32, 128, "<dev string:x1b5>" );
            angles = target getplayerangles();
            yaw = ( 0, angles[ 1 ], 0 );
            forward = anglestoforward( yaw );
            spawn_origin = origin + forward * 128 + ( 0, 0, 16 );
            
            if ( !bullettracepassed( target geteye(), spawn_origin, 0, target ) )
            {
                spawn_origin = undefined;
            }
            
            for ( i = 0; i < players.size ; i++ )
            {
                if ( players[ i ] == target )
                {
                    continue;
                }
                
                if ( isdefined( team ) )
                {
                    if ( strstartswith( team, "<dev string:x1ba>" ) && target.team == players[ i ].team )
                    {
                        continue;
                    }
                    
                    if ( strstartswith( team, "<dev string:x1c3>" ) && target.team != players[ i ].team )
                    {
                        continue;
                    }
                }
                
                if ( isdefined( spawn_origin ) )
                {
                    players[ i ] setorigin( spawn_origin );
                    continue;
                }
                
                if ( nodes.size > 0 )
                {
                    node = array::random( nodes );
                    players[ i ] setorigin( node.origin );
                    continue;
                }
                
                players[ i ] setorigin( origin );
            }
        }
        
        setdvar( "<dev string:x1cf>", "<dev string:x4b>" );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x9c349d54, Offset: 0x11f0
    // Size: 0x484, Type: dev
    function updatedevsettingszm()
    {
        if ( level.players.size > 0 )
        {
            if ( getdvarstring( "<dev string:x1de>" ) == "<dev string:x1f3>" )
            {
                if ( !isdefined( level.streamdumpteamindex ) )
                {
                    level.streamdumpteamindex = 0;
                }
                else
                {
                    level.streamdumpteamindex++;
                }
                
                numpoints = 0;
                spawnpoints = [];
                location = level.scr_zm_map_start_location;
                
                if ( ( location == "<dev string:x1f5>" || location == "<dev string:x4b>" ) && isdefined( level.default_start_location ) )
                {
                    location = level.default_start_location;
                }
                
                match_string = level.scr_zm_ui_gametype + "<dev string:x1fd>" + location;
                
                if ( level.streamdumpteamindex < level.teams.size )
                {
                    structs = struct::get_array( "<dev string:x1ff>", "<dev string:x20d>" );
                    
                    if ( isdefined( structs ) )
                    {
                        foreach ( struct in structs )
                        {
                            if ( isdefined( struct.script_string ) )
                            {
                                tokens = strtok( struct.script_string, "<dev string:x21f>" );
                                
                                foreach ( token in tokens )
                                {
                                    if ( token == match_string )
                                    {
                                        spawnpoints[ spawnpoints.size ] = struct;
                                    }
                                }
                            }
                        }
                    }
                    
                    if ( !isdefined( spawnpoints ) || spawnpoints.size == 0 )
                    {
                        spawnpoints = struct::get_array( "<dev string:x221>", "<dev string:x236>" );
                    }
                    
                    if ( isdefined( spawnpoints ) )
                    {
                        numpoints = spawnpoints.size;
                    }
                }
                
                if ( numpoints == 0 )
                {
                    setdvar( "<dev string:x1de>", "<dev string:x4c>" );
                    level.streamdumpteamindex = -1;
                    return;
                }
                
                averageorigin = ( 0, 0, 0 );
                averageangles = ( 0, 0, 0 );
                
                foreach ( spawnpoint in spawnpoints )
                {
                    averageorigin += spawnpoint.origin / numpoints;
                    averageangles += spawnpoint.angles / numpoints;
                }
                
                level.players[ 0 ] setplayerangles( averageangles );
                level.players[ 0 ] setorigin( averageorigin );
                wait 5;
                setdvar( "<dev string:x1de>", "<dev string:x241>" );
            }
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x8b730a7b, Offset: 0x1680
    // Size: 0x2414, Type: dev
    function updatedevsettings()
    {
        show_spawns = getdvarint( "<dev string:x3c>" );
        show_start_spawns = getdvarint( "<dev string:x4e>" );
        player = util::gethostplayer();
        
        if ( show_spawns >= 1 )
        {
            show_spawns = 1;
        }
        else
        {
            show_spawns = 0;
        }
        
        if ( show_start_spawns >= 1 )
        {
            show_start_spawns = 1;
        }
        else
        {
            show_start_spawns = 0;
        }
        
        if ( !isdefined( level.show_spawns ) || level.show_spawns != show_spawns )
        {
            level.show_spawns = show_spawns;
            setdvar( "<dev string:x3c>", level.show_spawns );
            
            if ( level.show_spawns )
            {
                showspawnpoints();
            }
            else
            {
                hidespawnpoints();
            }
        }
        
        if ( !isdefined( level.show_start_spawns ) || level.show_start_spawns != show_start_spawns )
        {
            level.show_start_spawns = show_start_spawns;
            setdvar( "<dev string:x4e>", level.show_start_spawns );
            
            if ( level.show_start_spawns )
            {
                showstartspawnpoints();
            }
            else
            {
                hidestartspawnpoints();
            }
        }
        
        updateminimapsetting();
        
        if ( level.players.size > 0 )
        {
            updatehardpoints();
            playerwarp_string = getdvarstring( "<dev string:x1cf>" );
            
            if ( playerwarp_string == "<dev string:x243>" )
            {
                warpalltohost();
            }
            else if ( playerwarp_string == "<dev string:x248>" )
            {
                warpalltohost( playerwarp_string );
            }
            else if ( playerwarp_string == "<dev string:x255>" )
            {
                warpalltohost( playerwarp_string );
            }
            else if ( strstartswith( playerwarp_string, "<dev string:x1ba>" ) )
            {
                name = getsubstr( playerwarp_string, 8 );
                warpalltoplayer( playerwarp_string, name );
            }
            else if ( strstartswith( playerwarp_string, "<dev string:x1c3>" ) )
            {
                name = getsubstr( playerwarp_string, 11 );
                warpalltoplayer( playerwarp_string, name );
            }
            else if ( strstartswith( playerwarp_string, "<dev string:x265>" ) )
            {
                name = getsubstr( playerwarp_string, 4 );
                warpalltoplayer( undefined, name );
            }
            else if ( playerwarp_string == "<dev string:x26a>" )
            {
                players = getplayers();
                setdvar( "<dev string:x1cf>", "<dev string:x4b>" );
                
                if ( !isdefined( level.devgui_start_spawn_index ) )
                {
                    level.devgui_start_spawn_index = 0;
                }
                
                player = util::gethostplayer();
                spawns = level.spawn_start[ player.pers[ "<dev string:x27b>" ] ];
                
                if ( !isdefined( spawns ) || spawns.size <= 0 )
                {
                    return;
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] setorigin( spawns[ level.devgui_start_spawn_index ].origin );
                    players[ i ] setplayerangles( spawns[ level.devgui_start_spawn_index ].angles );
                }
                
                level.devgui_start_spawn_index++;
                
                if ( level.devgui_start_spawn_index >= spawns.size )
                {
                    level.devgui_start_spawn_index = 0;
                }
            }
            else if ( playerwarp_string == "<dev string:x280>" )
            {
                players = getplayers();
                setdvar( "<dev string:x1cf>", "<dev string:x4b>" );
                
                if ( !isdefined( level.devgui_start_spawn_index ) )
                {
                    level.devgui_start_spawn_index = 0;
                }
                
                player = util::gethostplayer();
                spawns = level.spawn_start[ player.pers[ "<dev string:x27b>" ] ];
                
                if ( !isdefined( spawns ) || spawns.size <= 0 )
                {
                    return;
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] setorigin( spawns[ level.devgui_start_spawn_index ].origin );
                    players[ i ] setplayerangles( spawns[ level.devgui_start_spawn_index ].angles );
                }
                
                level.devgui_start_spawn_index--;
                
                if ( level.devgui_start_spawn_index < 0 )
                {
                    level.devgui_start_spawn_index = spawns.size - 1;
                }
            }
            else if ( playerwarp_string == "<dev string:x291>" )
            {
                players = getplayers();
                setdvar( "<dev string:x1cf>", "<dev string:x4b>" );
                
                if ( !isdefined( level.devgui_spawn_index ) )
                {
                    level.devgui_spawn_index = 0;
                }
                
                spawns = level.spawnpoints;
                spawns = arraycombine( spawns, level.dem_spawns, 1, 0 );
                
                if ( !isdefined( spawns ) || spawns.size <= 0 )
                {
                    return;
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] setorigin( spawns[ level.devgui_spawn_index ].origin );
                    players[ i ] setplayerangles( spawns[ level.devgui_spawn_index ].angles );
                }
                
                level.devgui_spawn_index++;
                
                if ( level.devgui_spawn_index >= spawns.size )
                {
                    level.devgui_spawn_index = 0;
                }
            }
            else if ( playerwarp_string == "<dev string:x29c>" )
            {
                players = getplayers();
                setdvar( "<dev string:x1cf>", "<dev string:x4b>" );
                
                if ( !isdefined( level.devgui_spawn_index ) )
                {
                    level.devgui_spawn_index = 0;
                }
                
                spawns = level.spawnpoints;
                spawns = arraycombine( spawns, level.dem_spawns, 1, 0 );
                
                if ( !isdefined( spawns ) || spawns.size <= 0 )
                {
                    return;
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    players[ i ] setorigin( spawns[ level.devgui_spawn_index ].origin );
                    players[ i ] setplayerangles( spawns[ level.devgui_spawn_index ].angles );
                }
                
                level.devgui_spawn_index--;
                
                if ( level.devgui_spawn_index < 0 )
                {
                    level.devgui_spawn_index = spawns.size - 1;
                }
            }
            else if ( getdvarstring( "<dev string:x2a7>" ) != "<dev string:x4b>" )
            {
                player = util::gethostplayer();
                
                if ( !isdefined( player.devgui_spawn_active ) )
                {
                    player.devgui_spawn_active = 0;
                }
                
                if ( !player.devgui_spawn_active )
                {
                    iprintln( "<dev string:x2b8>" );
                    iprintln( "<dev string:x2db>" );
                    player.devgui_spawn_active = 1;
                    player thread devgui_spawn_think();
                }
                else
                {
                    player notify( #"devgui_spawn_think" );
                    player.devgui_spawn_active = 0;
                    player setactionslot( 3, "<dev string:x2fb>" );
                }
                
                setdvar( "<dev string:x2a7>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x303>" ) != "<dev string:x4b>" )
            {
                players = getplayers();
                
                if ( !isdefined( level.devgui_unlimited_ammo ) )
                {
                    level.devgui_unlimited_ammo = 1;
                }
                else
                {
                    level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
                }
                
                if ( level.devgui_unlimited_ammo )
                {
                    iprintln( "<dev string:x313>" );
                }
                else
                {
                    iprintln( "<dev string:x338>" );
                }
                
                for ( i = 0; i < players.size ; i++ )
                {
                    if ( level.devgui_unlimited_ammo )
                    {
                        players[ i ] thread devgui_unlimited_ammo();
                        continue;
                    }
                    
                    players[ i ] notify( #"devgui_unlimited_ammo" );
                }
                
                setdvar( "<dev string:x303>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x360>" ) != "<dev string:x4b>" )
            {
                if ( !isdefined( level.devgui_unlimited_momentum ) )
                {
                    level.devgui_unlimited_momentum = 1;
                }
                else
                {
                    level.devgui_unlimited_momentum = !level.devgui_unlimited_momentum;
                }
                
                if ( level.devgui_unlimited_momentum )
                {
                    iprintln( "<dev string:x374>" );
                    level thread devgui_unlimited_momentum();
                }
                else
                {
                    iprintln( "<dev string:x39d>" );
                    level notify( #"devgui_unlimited_momentum" );
                }
                
                setdvar( "<dev string:x360>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x3c9>" ) != "<dev string:x4b>" )
            {
                level thread devgui_increase_momentum( getdvarint( "<dev string:x3c9>" ) );
                setdvar( "<dev string:x3c9>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x3df>" ) != "<dev string:x4b>" )
            {
                players = getplayers();
                
                for ( i = 0; i < players.size ; i++ )
                {
                    player = players[ i ];
                    weapons = player getweaponslist();
                    arrayremovevalue( weapons, level.weaponbasemelee );
                    
                    for ( j = 0; j < weapons.size ; j++ )
                    {
                        if ( weapons[ j ] == level.weaponnone )
                        {
                            continue;
                        }
                        
                        player setweaponammostock( weapons[ j ], 0 );
                        player setweaponammoclip( weapons[ j ], 0 );
                    }
                }
                
                setdvar( "<dev string:x3df>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x3f4>" ) != "<dev string:x4b>" )
            {
                players = getplayers();
                
                for ( i = 0; i < players.size ; i++ )
                {
                    player = players[ i ];
                    
                    if ( getdvarstring( "<dev string:x3f4>" ) == "<dev string:x4c>" )
                    {
                        player setempjammed( 0 );
                        continue;
                    }
                    
                    player setempjammed( 1 );
                }
                
                setdvar( "<dev string:x3f4>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x403>" ) != "<dev string:x4b>" )
            {
                if ( !level.timerstopped )
                {
                    iprintln( "<dev string:x413>" );
                    globallogic_utils::pausetimer();
                }
                else
                {
                    iprintln( "<dev string:x427>" );
                    globallogic_utils::resumetimer();
                }
                
                setdvar( "<dev string:x403>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x43c>" ) != "<dev string:x4b>" )
            {
                level globallogic::forceend();
                setdvar( "<dev string:x43c>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x44a>" ) != "<dev string:x4c>" )
            {
                players = getplayers();
                host = util::gethostplayer();
                
                if ( !isdefined( host.devgui_health_debug ) )
                {
                    host.devgui_health_debug = 0;
                }
                
                if ( host.devgui_health_debug )
                {
                    host.devgui_health_debug = 0;
                    
                    for ( i = 0; i < players.size ; i++ )
                    {
                        players[ i ] notify( #"devgui_health_debug" );
                        
                        if ( isdefined( players[ i ].debug_health_bar ) )
                        {
                            players[ i ].debug_health_bar destroy();
                            players[ i ].debug_health_text destroy();
                            players[ i ].debug_health_bar = undefined;
                            players[ i ].debug_health_text = undefined;
                        }
                    }
                }
                else
                {
                    host.devgui_health_debug = 1;
                    
                    for ( i = 0; i < players.size ; i++ )
                    {
                        players[ i ] thread devgui_health_debug();
                    }
                }
                
                setdvar( "<dev string:x44a>", "<dev string:x4b>" );
            }
            else if ( getdvarstring( "<dev string:x62>" ) != "<dev string:x4b>" )
            {
                if ( !isdefined( level.devgui_show_hq ) )
                {
                    level.devgui_show_hq = 0;
                }
                
                if ( level.gametype == "<dev string:x45b>" && isdefined( level.radios ) )
                {
                    if ( !level.devgui_show_hq )
                    {
                        for ( i = 0; i < level.radios.size ; i++ )
                        {
                            color = ( 1, 0, 0 );
                            level showonespawnpoint( level.radios[ i ], color, "<dev string:x460>", 32, "<dev string:x46f>" );
                        }
                    }
                    else
                    {
                        level notify( #"hide_hq_points" );
                    }
                    
                    level.devgui_show_hq = !level.devgui_show_hq;
                }
                
                setdvar( "<dev string:x62>", "<dev string:x4b>" );
            }
            
            if ( getdvarstring( "<dev string:x1de>" ) == "<dev string:x1f3>" )
            {
                if ( !isdefined( level.streamdumpteamindex ) )
                {
                    level.streamdumpteamindex = 0;
                }
                else
                {
                    level.streamdumpteamindex++;
                }
                
                numpoints = 0;
                
                if ( level.streamdumpteamindex < level.teams.size )
                {
                    teamname = getarraykeys( level.teams )[ level.streamdumpteamindex ];
                    
                    if ( isdefined( level.spawn_start[ teamname ] ) )
                    {
                        numpoints = level.spawn_start[ teamname ].size;
                    }
                }
                
                if ( numpoints == 0 )
                {
                    setdvar( "<dev string:x1de>", "<dev string:x4c>" );
                    level.streamdumpteamindex = -1;
                }
                else
                {
                    averageorigin = ( 0, 0, 0 );
                    averageangles = ( 0, 0, 0 );
                    
                    foreach ( spawnpoint in level.spawn_start[ teamname ] )
                    {
                        averageorigin += spawnpoint.origin / numpoints;
                        averageangles += spawnpoint.angles / numpoints;
                    }
                    
                    level.players[ 0 ] setplayerangles( averageangles );
                    level.players[ 0 ] setorigin( averageorigin );
                    wait 5;
                    setdvar( "<dev string:x1de>", "<dev string:x241>" );
                }
            }
        }
        
        if ( getdvarstring( "<dev string:x90>" ) == "<dev string:x4c>" )
        {
            players = getplayers();
            iprintln( "<dev string:x478>" );
            
            for ( i = 0; i < players.size ; i++ )
            {
                players[ i ] clearperks();
            }
            
            setdvar( "<dev string:x90>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x90>" ) != "<dev string:x4b>" )
        {
            perk = getdvarstring( "<dev string:x90>" );
            specialties = strtok( perk, "<dev string:x49a>" );
            players = getplayers();
            iprintln( "<dev string:x49c>" + perk + "<dev string:x4b7>" );
            
            for ( i = 0; i < players.size ; i++ )
            {
                for ( j = 0; j < specialties.size ; j++ )
                {
                    players[ i ] setperk( specialties[ j ] );
                    players[ i ].extraperks[ specialties[ j ] ] = 1;
                }
            }
            
            setdvar( "<dev string:x90>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x4b9>" ) != "<dev string:x4b>" )
        {
            force_grenade_throw( getweapon( getdvarstring( "<dev string:x4b9>" ) ) );
            setdvar( "<dev string:x4b9>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x9d>" ) != "<dev string:x4b>" )
        {
            event = getdvarstring( "<dev string:x9d>" );
            player = util::gethostplayer();
            forward = anglestoforward( player.angles );
            right = anglestoright( player.angles );
            
            if ( event == "<dev string:x4ca>" )
            {
                player dodamage( 1, player.origin + forward );
            }
            else if ( event == "<dev string:x4d4>" )
            {
                player dodamage( 1, player.origin - forward );
            }
            else if ( event == "<dev string:x4dd>" )
            {
                player dodamage( 1, player.origin - right );
            }
            else if ( event == "<dev string:x4e6>" )
            {
                player dodamage( 1, player.origin + right );
            }
            
            setdvar( "<dev string:x9d>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x4f0>" ) != "<dev string:x4b>" )
        {
            perk = getdvarstring( "<dev string:x4f0>" );
            
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] unsetperk( perk );
                level.players[ i ].extraperks[ perk ] = undefined;
            }
            
            setdvar( "<dev string:x4f0>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x4fd>" ) != "<dev string:x4b>" )
        {
            nametokens = strtok( getdvarstring( "<dev string:x4fd>" ), "<dev string:x21f>" );
            
            if ( nametokens.size > 1 )
            {
                thread xkillsy( nametokens[ 0 ], nametokens[ 1 ] );
            }
            
            setdvar( "<dev string:x4fd>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x50b>" ) != "<dev string:x4b>" )
        {
            ownername = getdvarstring( "<dev string:x50b>" );
            setdvar( "<dev string:x50b>", "<dev string:x4b>" );
            owner = undefined;
            
            for ( index = 0; index < level.players.size ; index++ )
            {
                if ( level.players[ index ].name == ownername )
                {
                    owner = level.players[ index ];
                }
            }
            
            if ( isdefined( owner ) )
            {
                owner killstreaks::trigger_killstreak( "<dev string:x517>" );
            }
        }
        
        if ( getdvarstring( "<dev string:x51c>" ) != "<dev string:x4b>" )
        {
            player.pers[ "<dev string:x52a>" ] = 0;
            player.pers[ "<dev string:x52f>" ] = 0;
            newrank = min( getdvarint( "<dev string:x51c>" ), 54 );
            newrank = max( newrank, 1 );
            setdvar( "<dev string:x51c>", "<dev string:x4b>" );
            lastxp = 0;
            
            for ( index = 0; index <= newrank ; index++ )
            {
                newxp = rank::getrankinfominxp( index );
                player thread rank::giverankxp( "<dev string:x536>", newxp - lastxp );
                lastxp = newxp;
                wait 0.25;
                self notify( #"cancel_notify" );
            }
        }
        
        if ( getdvarstring( "<dev string:x53b>" ) != "<dev string:x4b>" )
        {
            player thread rank::giverankxp( "<dev string:x546>", getdvarint( "<dev string:x53b>" ), 1 );
            setdvar( "<dev string:x53b>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x550>" ) != "<dev string:x4b>" )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] hud_message::function_2bb1fc0( getdvarstring( "<dev string:x550>" ), getdvarstring( "<dev string:x550>" ), game.icons[ "<dev string:x55e>" ] );
            }
            
            announcement( getdvarstring( "<dev string:x550>" ), 0 );
            setdvar( "<dev string:x550>", "<dev string:x4b>" );
        }
        
        if ( getdvarstring( "<dev string:x565>" ) != "<dev string:x4b>" )
        {
            ents = getentarray();
            level.entarray = [];
            level.entcounts = [];
            level.entgroups = [];
            
            for ( index = 0; index < ents.size ; index++ )
            {
                classname = ents[ index ].classname;
                
                if ( !issubstr( classname, "<dev string:x572>" ) )
                {
                    curent = ents[ index ];
                    level.entarray[ level.entarray.size ] = curent;
                    
                    if ( !isdefined( level.entcounts[ classname ] ) )
                    {
                        level.entcounts[ classname ] = 0;
                    }
                    
                    level.entcounts[ classname ]++;
                    
                    if ( !isdefined( level.entgroups[ classname ] ) )
                    {
                        level.entgroups[ classname ] = [];
                    }
                    
                    level.entgroups[ classname ][ level.entgroups[ classname ].size ] = curent;
                }
            }
        }
        
        if ( getdvarstring( "<dev string:xbe>" ) == "<dev string:x579>" && !isdefined( level.larry ) )
        {
            thread larry_thread();
        }
        else if ( getdvarstring( "<dev string:xbe>" ) == "<dev string:x4c>" )
        {
            level notify( #"kill_larry" );
        }
        
        if ( getdvarint( "<dev string:x57b>" ) == 1 )
        {
            level thread killcam::do_final_killcam();
            level thread waitthennotifyfinalkillcam();
        }
        
        if ( getdvarint( "<dev string:x592>" ) == 1 )
        {
            level thread killcam::do_final_killcam();
            level thread waitthennotifyroundkillcam();
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xc2030e43, Offset: 0x3aa0
    // Size: 0x34, Type: dev
    function waitthennotifyroundkillcam()
    {
        waitframe( 1 );
        level notify( #"play_final_killcam" );
        setdvar( "<dev string:x592>", 0 );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xaa676e9, Offset: 0x3ae0
    // Size: 0x3c, Type: dev
    function waitthennotifyfinalkillcam()
    {
        waitframe( 1 );
        level notify( #"play_final_killcam" );
        waitframe( 1 );
        setdvar( "<dev string:x57b>", 0 );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x366bab52, Offset: 0x3b28
    // Size: 0x190, Type: dev
    function devgui_spawn_think()
    {
        self notify( #"devgui_spawn_think" );
        self endon( #"devgui_spawn_think" );
        self endon( #"disconnect" );
        dpad_left = 0;
        dpad_right = 0;
        
        for ( ;; )
        {
            self setactionslot( 3, "<dev string:x4b>" );
            self setactionslot( 4, "<dev string:x4b>" );
            
            if ( !dpad_left && self buttonpressed( "<dev string:x5a9>" ) )
            {
                setdvar( "<dev string:x1cf>", "<dev string:x29c>" );
                dpad_left = 1;
            }
            else if ( !self buttonpressed( "<dev string:x5a9>" ) )
            {
                dpad_left = 0;
            }
            
            if ( !dpad_right && self buttonpressed( "<dev string:x5b3>" ) )
            {
                setdvar( "<dev string:x1cf>", "<dev string:x291>" );
                dpad_right = 1;
            }
            else if ( !self buttonpressed( "<dev string:x5b3>" ) )
            {
                dpad_right = 0;
            }
            
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x22fae7ac, Offset: 0x3cc0
    // Size: 0x172, Type: dev
    function devgui_unlimited_ammo()
    {
        self notify( #"devgui_unlimited_ammo" );
        self endon( #"devgui_unlimited_ammo" );
        self endon( #"disconnect" );
        
        for ( ;; )
        {
            wait 1;
            primary_weapons = self getweaponslistprimaries();
            offhand_weapons_and_alts = array::exclude( self getweaponslist( 1 ), primary_weapons );
            weapons = arraycombine( primary_weapons, offhand_weapons_and_alts, 0, 0 );
            arrayremovevalue( weapons, level.weaponbasemelee );
            
            for ( i = 0; i < weapons.size ; i++ )
            {
                weapon = weapons[ i ];
                
                if ( weapon == level.weaponnone )
                {
                    continue;
                }
                
                if ( killstreaks::is_killstreak_weapon( weapon ) )
                {
                    continue;
                }
                
                self givemaxammo( weapon );
            }
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xdd2e86e0, Offset: 0x3e40
    // Size: 0x11e, Type: dev
    function devgui_unlimited_momentum()
    {
        level notify( #"devgui_unlimited_momentum" );
        level endon( #"devgui_unlimited_momentum" );
        
        for ( ;; )
        {
            wait 1;
            players = getplayers();
            
            foreach ( player in players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( !isalive( player ) )
                {
                    continue;
                }
                
                if ( player.sessionstate != "<dev string:x5be>" )
                {
                    continue;
                }
                
                globallogic_score::_setplayermomentum( player, 5000 );
            }
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0x644f420f, Offset: 0x3f68
    // Size: 0x112, Type: dev
    function devgui_increase_momentum( score )
    {
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.sessionstate != "<dev string:x5be>" )
            {
                continue;
            }
            
            player globallogic_score::giveplayermomentumnotification( score, &"<dev string:x5c6>", "<dev string:x5dc>" );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xce26831, Offset: 0x4088
    // Size: 0x340, Type: dev
    function devgui_health_debug()
    {
        self notify( #"devgui_health_debug" );
        self endon( #"devgui_health_debug" );
        self endon( #"disconnect" );
        x = 80;
        y = 40;
        self.debug_health_bar = newclienthudelem( self );
        self.debug_health_bar.x = x + 80;
        self.debug_health_bar.y = y + 2;
        self.debug_health_bar.alignx = "<dev string:x5e9>";
        self.debug_health_bar.aligny = "<dev string:x5ee>";
        self.debug_health_bar.horzalign = "<dev string:x5f2>";
        self.debug_health_bar.vertalign = "<dev string:x5f2>";
        self.debug_health_bar.alpha = 1;
        self.debug_health_bar.foreground = 1;
        self.debug_health_bar setshader( "<dev string:x5fd>", 1, 8 );
        self.debug_health_text = newclienthudelem( self );
        self.debug_health_text.x = x + 80;
        self.debug_health_text.y = y;
        self.debug_health_text.alignx = "<dev string:x5e9>";
        self.debug_health_text.aligny = "<dev string:x5ee>";
        self.debug_health_text.horzalign = "<dev string:x5f2>";
        self.debug_health_text.vertalign = "<dev string:x5f2>";
        self.debug_health_text.alpha = 1;
        self.debug_health_text.fontscale = 1;
        self.debug_health_text.foreground = 1;
        
        if ( !isdefined( self.maxhealth ) || self.maxhealth <= 0 )
        {
            self.maxhealth = 100;
        }
        
        for ( ;; )
        {
            waitframe( 1 );
            width = self.health / self.maxhealth * 300;
            width = int( max( width, 1 ) );
            self.debug_health_bar setshader( "<dev string:x5fd>", width, 8 );
            self.debug_health_text setvalue( self.health );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x4ac167a7, Offset: 0x43d0
    // Size: 0xce, Type: dev
    function giveextraperks()
    {
        if ( !isdefined( self.extraperks ) )
        {
            return;
        }
        
        perks = getarraykeys( self.extraperks );
        
        for ( i = 0; i < perks.size ; i++ )
        {
            println( "<dev string:x603>" + self.name + "<dev string:x60e>" + perks[ i ] + "<dev string:x619>" );
            self setperk( perks[ i ] );
        }
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0x10554032, Offset: 0x44a8
    // Size: 0x16c, Type: dev
    function xkillsy( attackername, victimname )
    {
        attacker = undefined;
        victim = undefined;
        
        for ( index = 0; index < level.players.size ; index++ )
        {
            if ( level.players[ index ].name == attackername )
            {
                attacker = level.players[ index ];
                continue;
            }
            
            if ( level.players[ index ].name == victimname )
            {
                victim = level.players[ index ];
            }
        }
        
        if ( !isalive( attacker ) || !isalive( victim ) )
        {
            return;
        }
        
        victim thread [[ level.callbackplayerdamage ]]( attacker, attacker, 1000, 0, "<dev string:x627>", level.weaponnone, ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x638>", ( 0, 0, 0 ), 0, 0, ( 1, 0, 0 ) );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xb73b1c29, Offset: 0x4620
    // Size: 0x24, Type: dev
    function testscriptruntimeerrorassert()
    {
        wait 1;
        assert( 0 );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x7491f33d, Offset: 0x4650
    // Size: 0x2c, Type: dev
    function testscriptruntimeassertmsgassert()
    {
        wait 1;
        assertmsg( "<dev string:x63d>" );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x59e28a2e, Offset: 0x4688
    // Size: 0x2c, Type: dev
    function testscriptruntimeerrormsgassert()
    {
        wait 1;
        errormsg( "<dev string:x654>" );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x58810a42, Offset: 0x46c0
    // Size: 0x44, Type: dev
    function testscriptruntimeerror2()
    {
        myundefined = "<dev string:x66a>";
        
        if ( myundefined == 1 )
        {
            println( "<dev string:x66f>" );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x6990065e, Offset: 0x4710
    // Size: 0x1c, Type: dev
    function testscriptruntimeerror1()
    {
        testscriptruntimeerror2();
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x2471501, Offset: 0x4738
    // Size: 0x11c, Type: dev
    function testscriptruntimeerror()
    {
        wait 5;
        
        for ( ;; )
        {
            if ( getdvarstring( "<dev string:x75>" ) != "<dev string:x4c>" )
            {
                break;
            }
            
            wait 1;
        }
        
        myerror = getdvarstring( "<dev string:x75>" );
        setdvar( "<dev string:x75>", "<dev string:x4c>" );
        
        if ( myerror == "<dev string:x695>" )
        {
            testscriptruntimeerrorassert();
        }
        else if ( myerror == "<dev string:x69c>" )
        {
            testscriptruntimeassertmsgassert();
        }
        else if ( myerror == "<dev string:x6a6>" )
        {
            testscriptruntimeerrormsgassert();
        }
        else
        {
            testscriptruntimeerror1();
        }
        
        thread testscriptruntimeerror();
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x9b7954e5, Offset: 0x4860
    // Size: 0xf4, Type: dev
    function testdvars()
    {
        wait 5;
        
        for ( ;; )
        {
            if ( getdvarstring( "<dev string:x6af>" ) != "<dev string:x4b>" )
            {
                break;
            }
            
            wait 1;
        }
        
        tokens = strtok( getdvarstring( "<dev string:x6af>" ), "<dev string:x21f>" );
        dvarname = tokens[ 0 ];
        dvarvalue = tokens[ 1 ];
        setdvar( dvarname, dvarvalue );
        setdvar( "<dev string:x6af>", "<dev string:x4b>" );
        thread testdvars();
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x2d8acbe6, Offset: 0x4960
    // Size: 0x1fc, Type: dev
    function addenemyheli()
    {
        wait 5;
        
        for ( ;; )
        {
            if ( getdvarint( "<dev string:x6bc>" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        enemyheli = getdvarint( "<dev string:x6bc>" );
        setdvar( "<dev string:x6bc>", 0 );
        team = "<dev string:x190>";
        player = util::gethostplayer();
        
        if ( isdefined( player.pers[ "<dev string:x27b>" ] ) )
        {
            team = util::getotherteam( player.pers[ "<dev string:x27b>" ] );
        }
        
        ent = getormakebot( team );
        
        if ( !isdefined( ent ) )
        {
            println( "<dev string:x19b>" );
            wait 1;
            thread addenemyheli();
            return;
        }
        
        switch ( enemyheli )
        {
            case 1:
                level.helilocation = ent.origin;
                ent thread helicopter::usekillstreakhelicopter( "<dev string:x6cf>" );
                wait 0.5;
                ent notify( #"confirm_location", { #position:level.helilocation } );
                break;
            case 2:
                break;
        }
        
        thread addenemyheli();
    }

#/

// Namespace dev/dev
// Params 1
// Checksum 0x162ad022, Offset: 0x4b68
// Size: 0xf8
function getormakebot( team )
{
    /#
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ].team == team )
            {
                if ( level.players[ i ] isbot() )
                {
                    return level.players[ i ];
                }
            }
        }
        
        ent = bot::add_bot( team );
        
        if ( isdefined( ent ) )
        {
            sound::play_on_players( "<dev string:x6e2>" );
            wait 1;
        }
        
        return ent;
    #/
}

/#

    // Namespace dev/dev
    // Params 0
    // Checksum 0x74317094, Offset: 0x4c68
    // Size: 0x20c, Type: dev
    function addtestcarepackage()
    {
        wait 5;
        
        for ( ;; )
        {
            if ( getdvarint( "<dev string:x6f4>" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        supplydrop = getdvarint( "<dev string:x6f4>" );
        team = "<dev string:x190>";
        player = util::gethostplayer();
        
        if ( isdefined( player.pers[ "<dev string:x27b>" ] ) )
        {
            switch ( supplydrop )
            {
                case 2:
                    team = util::getotherteam( player.pers[ "<dev string:x27b>" ] );
                    break;
                case 1:
                default:
                    team = player.pers[ "<dev string:x27b>" ];
                    break;
            }
        }
        
        setdvar( "<dev string:x6f4>", 0 );
        ent = getormakebot( team );
        
        if ( !isdefined( ent ) )
        {
            println( "<dev string:x19b>" );
            wait 1;
            thread addtestcarepackage();
            return;
        }
        
        ent killstreakrules::killstreakstart( "<dev string:x70b>", team );
        ent thread supplydrop::helidelivercrate( ent.origin, getweapon( "<dev string:x717>" ), ent, team );
        thread addtestcarepackage();
    }

    // Namespace dev/dev
    // Params 5
    // Checksum 0x64be9f71, Offset: 0x4e80
    // Size: 0x5b6, Type: dev
    function showonespawnpoint( spawn_point, color, notification, height, print )
    {
        if ( !isdefined( height ) || height <= 0 )
        {
            height = util::get_player_height();
        }
        
        if ( !isdefined( print ) )
        {
            if ( level.convert_spawns_to_structs )
            {
                print = spawn_point.targetname;
            }
            else
            {
                print = spawn_point.classname;
            }
        }
        
        center = spawn_point.origin;
        forward = anglestoforward( spawn_point.angles );
        right = anglestoright( spawn_point.angles );
        forward = vectorscale( forward, 16 );
        right = vectorscale( right, 16 );
        a = center + forward - right;
        b = center + forward + right;
        c = center - forward + right;
        d = center - forward - right;
        thread lineuntilnotified( a, b, color, 0, notification );
        thread lineuntilnotified( b, c, color, 0, notification );
        thread lineuntilnotified( c, d, color, 0, notification );
        thread lineuntilnotified( d, a, color, 0, notification );
        thread lineuntilnotified( a, a + ( 0, 0, height ), color, 0, notification );
        thread lineuntilnotified( b, b + ( 0, 0, height ), color, 0, notification );
        thread lineuntilnotified( c, c + ( 0, 0, height ), color, 0, notification );
        thread lineuntilnotified( d, d + ( 0, 0, height ), color, 0, notification );
        a += ( 0, 0, height );
        b += ( 0, 0, height );
        c += ( 0, 0, height );
        d += ( 0, 0, height );
        thread lineuntilnotified( a, b, color, 0, notification );
        thread lineuntilnotified( b, c, color, 0, notification );
        thread lineuntilnotified( c, d, color, 0, notification );
        thread lineuntilnotified( d, a, color, 0, notification );
        center += ( 0, 0, height / 2 );
        arrow_forward = anglestoforward( spawn_point.angles );
        arrowhead_forward = anglestoforward( spawn_point.angles );
        arrowhead_right = anglestoright( spawn_point.angles );
        arrow_forward = vectorscale( arrow_forward, 32 );
        arrowhead_forward = vectorscale( arrowhead_forward, 24 );
        arrowhead_right = vectorscale( arrowhead_right, 8 );
        a = center + arrow_forward;
        b = center + arrowhead_forward - arrowhead_right;
        c = center + arrowhead_forward + arrowhead_right;
        thread lineuntilnotified( center, a, color, 0, notification );
        thread lineuntilnotified( a, b, color, 0, notification );
        thread lineuntilnotified( a, c, color, 0, notification );
        thread print3duntilnotified( spawn_point.origin + ( 0, 0, height ), print, color, 1, 1, notification );
        return;
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xa07ade98, Offset: 0x5440
    // Size: 0x100, Type: dev
    function showspawnpoints()
    {
        if ( isdefined( level.spawnpoints ) )
        {
            color = ( 1, 1, 1 );
            
            for ( spawn_point_index = 0; spawn_point_index < level.spawnpoints.size ; spawn_point_index++ )
            {
                showonespawnpoint( level.spawnpoints[ spawn_point_index ], color, "<dev string:x722>" );
            }
        }
        
        for ( i = 0; i < level.dem_spawns.size ; i++ )
        {
            color = ( 0, 1, 0 );
            showonespawnpoint( level.dem_spawns[ i ], color, "<dev string:x722>" );
        }
        
        return;
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x446b7384, Offset: 0x5548
    // Size: 0x1a, Type: dev
    function hidespawnpoints()
    {
        level notify( #"hide_spawnpoints" );
        return;
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xa7bbbbf1, Offset: 0x5570
    // Size: 0x2cc, Type: dev
    function showstartspawnpoints()
    {
        if ( !isdefined( level.spawn_start ) )
        {
            return;
        }
        
        if ( level.teambased )
        {
            team_colors = [];
            team_colors[ "<dev string:x733>" ] = ( 1, 0, 1 );
            team_colors[ "<dev string:x55e>" ] = ( 0, 1, 1 );
            team_colors[ "<dev string:x738>" ] = ( 1, 1, 0 );
            team_colors[ "<dev string:x73e>" ] = ( 0, 1, 0 );
            team_colors[ "<dev string:x744>" ] = ( 0, 0, 1 );
            team_colors[ "<dev string:x74a>" ] = ( 1, 0.7, 0 );
            team_colors[ "<dev string:x750>" ] = ( 0.25, 0.25, 1 );
            team_colors[ "<dev string:x756>" ] = ( 0.88, 0, 1 );
            
            foreach ( key, color in team_colors )
            {
                if ( !isdefined( level.spawn_start[ key ] ) )
                {
                    continue;
                }
                
                foreach ( spawnpoint in level.spawn_start[ key ] )
                {
                    showonespawnpoint( spawnpoint, color, "<dev string:x75c>" );
                }
            }
            
            return;
        }
        
        color = ( 1, 0, 1 );
        
        foreach ( spawnpoint in level.spawn_start )
        {
            showonespawnpoint( spawnpoint, color, "<dev string:x75c>" );
        }
        
        return;
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xf93dae1b, Offset: 0x5848
    // Size: 0x1a, Type: dev
    function hidestartspawnpoints()
    {
        level notify( #"hide_startspawnpoints" );
        return;
    }

    // Namespace dev/dev
    // Params 6
    // Checksum 0x4804b3cf, Offset: 0x5870
    // Size: 0x76, Type: dev
    function print3duntilnotified( origin, text, color, alpha, scale, notification )
    {
        level endon( notification );
        
        for ( ;; )
        {
            print3d( origin, text, color, alpha, scale );
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 5
    // Checksum 0xc27e11bb, Offset: 0x58f0
    // Size: 0x66, Type: dev
    function lineuntilnotified( start, end, color, depthtest, notification )
    {
        level endon( notification );
        
        for ( ;; )
        {
            line( start, end, color, depthtest );
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xd26e06fb, Offset: 0x5960
    // Size: 0x164, Type: dev
    function engagement_distance_debug_toggle()
    {
        level endon( #"kill_engage_dist_debug_toggle_watcher" );
        
        if ( !isdefined( getdvarint( "<dev string:x772>" ) ) )
        {
            setdvar( "<dev string:x772>", "<dev string:x4c>" );
        }
        
        laststate = getdvarint( "<dev string:x772>", 0 );
        
        while ( true )
        {
            currentstate = getdvarint( "<dev string:x772>", 0 );
            
            if ( dvar_turned_on( currentstate ) && !dvar_turned_on( laststate ) )
            {
                weapon_engage_dists_init();
                thread debug_realtime_engage_dist();
                laststate = currentstate;
            }
            else if ( !dvar_turned_on( currentstate ) && dvar_turned_on( laststate ) )
            {
                level notify( #"kill_all_engage_dist_debug" );
                laststate = currentstate;
            }
            
            wait 0.3;
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0x4a146f53, Offset: 0x5ad0
    // Size: 0x2a, Type: dev
    function dvar_turned_on( val )
    {
        if ( val <= 0 )
        {
            return 0;
        }
        
        return 1;
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x66304fbb, Offset: 0x5b08
    // Size: 0x494, Type: dev
    function engagement_distance_debug_init()
    {
        level.debug_xpos = -50;
        level.debug_ypos = 250;
        level.debug_yinc = 18;
        level.debug_fontscale = 1.5;
        level.white = ( 1, 1, 1 );
        level.green = ( 0, 1, 0 );
        level.yellow = ( 1, 1, 0 );
        level.red = ( 1, 0, 0 );
        level.realtimeengagedist = newhudelem();
        level.realtimeengagedist.alignx = "<dev string:x5e9>";
        level.realtimeengagedist.fontscale = level.debug_fontscale;
        level.realtimeengagedist.x = level.debug_xpos;
        level.realtimeengagedist.y = level.debug_ypos;
        level.realtimeengagedist.color = level.white;
        level.realtimeengagedist settext( "<dev string:x785>" );
        xpos = level.debug_xpos + 207;
        level.realtimeengagedist_value = newhudelem();
        level.realtimeengagedist_value.alignx = "<dev string:x5e9>";
        level.realtimeengagedist_value.fontscale = level.debug_fontscale;
        level.realtimeengagedist_value.x = xpos;
        level.realtimeengagedist_value.y = level.debug_ypos;
        level.realtimeengagedist_value.color = level.white;
        level.realtimeengagedist_value setvalue( 0 );
        xpos += 37;
        level.realtimeengagedist_middle = newhudelem();
        level.realtimeengagedist_middle.alignx = "<dev string:x5e9>";
        level.realtimeengagedist_middle.fontscale = level.debug_fontscale;
        level.realtimeengagedist_middle.x = xpos;
        level.realtimeengagedist_middle.y = level.debug_ypos;
        level.realtimeengagedist_middle.color = level.white;
        level.realtimeengagedist_middle settext( "<dev string:x7a3>" );
        xpos += 105;
        level.realtimeengagedist_offvalue = newhudelem();
        level.realtimeengagedist_offvalue.alignx = "<dev string:x5e9>";
        level.realtimeengagedist_offvalue.fontscale = level.debug_fontscale;
        level.realtimeengagedist_offvalue.x = xpos;
        level.realtimeengagedist_offvalue.y = level.debug_ypos;
        level.realtimeengagedist_offvalue.color = level.white;
        level.realtimeengagedist_offvalue setvalue( 0 );
        hudobjarray = [];
        hudobjarray[ 0 ] = level.realtimeengagedist;
        hudobjarray[ 1 ] = level.realtimeengagedist_value;
        hudobjarray[ 2 ] = level.realtimeengagedist_middle;
        hudobjarray[ 3 ] = level.realtimeengagedist_offvalue;
        return hudobjarray;
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0xd08d66, Offset: 0x5fa8
    // Size: 0x6e, Type: dev
    function engage_dist_debug_hud_destroy( hudarray, killnotify )
    {
        level waittill( killnotify );
        
        for ( i = 0; i < hudarray.size ; i++ )
        {
            hudarray[ i ] destroy();
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xc7c05b82, Offset: 0x6020
    // Size: 0x8cc, Type: dev
    function weapon_engage_dists_init()
    {
        level.engagedists = [];
        genericpistol = spawnstruct();
        genericpistol.engagedistmin = 125;
        genericpistol.engagedistoptimal = 225;
        genericpistol.engagedistmulligan = 50;
        genericpistol.engagedistmax = 400;
        shotty = spawnstruct();
        shotty.engagedistmin = 50;
        shotty.engagedistoptimal = 200;
        shotty.engagedistmulligan = 75;
        shotty.engagedistmax = 350;
        genericsmg = spawnstruct();
        genericsmg.engagedistmin = 100;
        genericsmg.engagedistoptimal = 275;
        genericsmg.engagedistmulligan = 100;
        genericsmg.engagedistmax = 500;
        genericlmg = spawnstruct();
        genericlmg.engagedistmin = 325;
        genericlmg.engagedistoptimal = 550;
        genericlmg.engagedistmulligan = 150;
        genericlmg.engagedistmax = 850;
        genericriflesa = spawnstruct();
        genericriflesa.engagedistmin = 325;
        genericriflesa.engagedistoptimal = 550;
        genericriflesa.engagedistmulligan = 150;
        genericriflesa.engagedistmax = 850;
        genericriflebolt = spawnstruct();
        genericriflebolt.engagedistmin = 350;
        genericriflebolt.engagedistoptimal = 600;
        genericriflebolt.engagedistmulligan = 150;
        genericriflebolt.engagedistmax = 900;
        generichmg = spawnstruct();
        generichmg.engagedistmin = 390;
        generichmg.engagedistoptimal = 600;
        generichmg.engagedistmulligan = 100;
        generichmg.engagedistmax = 900;
        genericsniper = spawnstruct();
        genericsniper.engagedistmin = 950;
        genericsniper.engagedistoptimal = 1700;
        genericsniper.engagedistmulligan = 300;
        genericsniper.engagedistmax = 3000;
        engage_dists_add( "<dev string:x7ba>", genericpistol );
        engage_dists_add( "<dev string:x7bf>", genericpistol );
        engage_dists_add( "<dev string:x7c5>", genericpistol );
        engage_dists_add( "<dev string:x7cd>", genericpistol );
        engage_dists_add( "<dev string:x7d5>", genericsmg );
        engage_dists_add( "<dev string:x7de>", genericsmg );
        engage_dists_add( "<dev string:x7ea>", genericsmg );
        engage_dists_add( "<dev string:x7ef>", genericsmg );
        engage_dists_add( "<dev string:x7f4>", genericsmg );
        engage_dists_add( "<dev string:x7fa>", genericsmg );
        engage_dists_add( "<dev string:x7ff>", genericsmg );
        engage_dists_add( "<dev string:x80d>", shotty );
        engage_dists_add( "<dev string:x815>", genericlmg );
        engage_dists_add( "<dev string:x819>", genericlmg );
        engage_dists_add( "<dev string:x823>", genericlmg );
        engage_dists_add( "<dev string:x82e>", genericlmg );
        engage_dists_add( "<dev string:x83f>", genericlmg );
        engage_dists_add( "<dev string:x844>", genericlmg );
        engage_dists_add( "<dev string:x84f>", genericlmg );
        engage_dists_add( "<dev string:x854>", genericlmg );
        engage_dists_add( "<dev string:x85f>", genericlmg );
        engage_dists_add( "<dev string:x864>", genericlmg );
        engage_dists_add( "<dev string:x86f>", genericriflesa );
        engage_dists_add( "<dev string:x878>", genericriflesa );
        engage_dists_add( "<dev string:x882>", genericriflesa );
        engage_dists_add( "<dev string:x888>", genericriflesa );
        engage_dists_add( "<dev string:x891>", genericriflebolt );
        engage_dists_add( "<dev string:x89d>", genericriflebolt );
        engage_dists_add( "<dev string:x8aa>", genericriflebolt );
        engage_dists_add( "<dev string:x8b6>", genericriflebolt );
        engage_dists_add( "<dev string:x8bd>", genericriflebolt );
        engage_dists_add( "<dev string:x8c9>", generichmg );
        engage_dists_add( "<dev string:x8cf>", generichmg );
        engage_dists_add( "<dev string:x8db>", generichmg );
        engage_dists_add( "<dev string:x8e0>", generichmg );
        engage_dists_add( "<dev string:x8eb>", genericsniper );
        engage_dists_add( "<dev string:x8fe>", genericsniper );
        engage_dists_add( "<dev string:x912>", genericsniper );
        engage_dists_add( "<dev string:x925>", genericsniper );
        engage_dists_add( "<dev string:x933>", genericsniper );
        engage_dists_add( "<dev string:x93f>", genericsniper );
        level thread engage_dists_watcher();
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0xa6a9f55e, Offset: 0x68f8
    // Size: 0x42, Type: dev
    function engage_dists_add( weaponname, values )
    {
        level.engagedists[ getweapon( weaponname ) ] = values;
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0x9cf62655, Offset: 0x6948
    // Size: 0x42, Type: dev
    function get_engage_dists( weapon )
    {
        if ( isdefined( level.engagedists[ weapon ] ) )
        {
            return level.engagedists[ weapon ];
        }
        
        return undefined;
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xc513286d, Offset: 0x6998
    // Size: 0x126, Type: dev
    function engage_dists_watcher()
    {
        level endon( #"kill_all_engage_dist_debug" );
        level endon( #"kill_engage_dists_watcher" );
        
        while ( true )
        {
            player = util::gethostplayer();
            playerweapon = player getcurrentweapon();
            
            if ( !isdefined( player.lastweapon ) )
            {
                player.lastweapon = playerweapon;
            }
            else if ( player.lastweapon == playerweapon )
            {
                waitframe( 1 );
                continue;
            }
            
            values = get_engage_dists( playerweapon );
            
            if ( isdefined( values ) )
            {
                level.weaponengagedistvalues = values;
            }
            else
            {
                level.weaponengagedistvalues = undefined;
            }
            
            player.lastweapon = playerweapon;
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x34c16d82, Offset: 0x6ac8
    // Size: 0x4ce, Type: dev
    function debug_realtime_engage_dist()
    {
        level endon( #"kill_all_engage_dist_debug" );
        level endon( #"kill_realtime_engagement_distance_debug" );
        hudobjarray = engagement_distance_debug_init();
        level thread engage_dist_debug_hud_destroy( hudobjarray, "<dev string:x952>" );
        level.debugrtengagedistcolor = level.green;
        player = util::gethostplayer();
        
        while ( true )
        {
            lasttracepos = ( 0, 0, 0 );
            direction = player getplayerangles();
            direction_vec = anglestoforward( direction );
            eye = player geteye();
            eye = ( eye[ 0 ], eye[ 1 ], eye[ 2 ] + 20 );
            trace = bullettrace( eye, eye + vectorscale( direction_vec, 10000 ), 1, player );
            tracepoint = trace[ "<dev string:x96d>" ];
            tracenormal = trace[ "<dev string:x976>" ];
            tracedist = int( distance( eye, tracepoint ) );
            
            if ( tracepoint != lasttracepos )
            {
                lasttracepos = tracepoint;
                
                if ( !isdefined( level.weaponengagedistvalues ) )
                {
                    hudobj_changecolor( hudobjarray, level.white );
                    hudobjarray engagedist_hud_changetext( "<dev string:x97d>", tracedist );
                }
                else
                {
                    engagedistmin = level.weaponengagedistvalues.engagedistmin;
                    engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
                    engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
                    engagedistmax = level.weaponengagedistvalues.engagedistmax;
                    
                    if ( tracedist >= engagedistmin && tracedist <= engagedistmax )
                    {
                        if ( tracedist >= engagedistoptimal - engagedistmulligan && tracedist <= engagedistoptimal + engagedistmulligan )
                        {
                            hudobjarray engagedist_hud_changetext( "<dev string:x984>", tracedist );
                            hudobj_changecolor( hudobjarray, level.green );
                        }
                        else
                        {
                            hudobjarray engagedist_hud_changetext( "<dev string:x98c>", tracedist );
                            hudobj_changecolor( hudobjarray, level.yellow );
                        }
                    }
                    else if ( tracedist < engagedistmin )
                    {
                        hudobj_changecolor( hudobjarray, level.red );
                        hudobjarray engagedist_hud_changetext( "<dev string:x98f>", tracedist );
                    }
                    else if ( tracedist > engagedistmax )
                    {
                        hudobj_changecolor( hudobjarray, level.red );
                        hudobjarray engagedist_hud_changetext( "<dev string:x995>", tracedist );
                    }
                }
            }
            
            thread function_57e53630( 1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal );
            thread function_57e53630( 1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal );
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0x328ef636, Offset: 0x6fa0
    // Size: 0x96, Type: dev
    function hudobj_changecolor( hudobjarray, newcolor )
    {
        for ( i = 0; i < hudobjarray.size ; i++ )
        {
            hudobj = hudobjarray[ i ];
            
            if ( hudobj.color != newcolor )
            {
                hudobj.color = newcolor;
                level.debugrtengagedistcolor = newcolor;
            }
        }
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0x3822f21f, Offset: 0x7040
    // Size: 0x310, Type: dev
    function engagedist_hud_changetext( engagedisttype, units )
    {
        if ( !isdefined( level.lastdisttype ) )
        {
            level.lastdisttype = "<dev string:x638>";
        }
        
        if ( engagedisttype == "<dev string:x984>" )
        {
            self[ 1 ] setvalue( units );
            self[ 2 ] settext( "<dev string:x99a>" );
            self[ 3 ].alpha = 0;
        }
        else if ( engagedisttype == "<dev string:x98c>" )
        {
            self[ 1 ] setvalue( units );
            self[ 2 ] settext( "<dev string:x9aa>" );
            self[ 3 ].alpha = 0;
        }
        else if ( engagedisttype == "<dev string:x98f>" )
        {
            amountunder = level.weaponengagedistvalues.engagedistmin - units;
            self[ 1 ] setvalue( units );
            self[ 3 ] setvalue( amountunder );
            self[ 3 ].alpha = 1;
            
            if ( level.lastdisttype != engagedisttype )
            {
                self[ 2 ] settext( "<dev string:x9b5>" );
            }
        }
        else if ( engagedisttype == "<dev string:x995>" )
        {
            amountover = units - level.weaponengagedistvalues.engagedistmax;
            self[ 1 ] setvalue( units );
            self[ 3 ] setvalue( amountover );
            self[ 3 ].alpha = 1;
            
            if ( level.lastdisttype != engagedisttype )
            {
                self[ 2 ] settext( "<dev string:x9c6>" );
            }
        }
        else if ( engagedisttype == "<dev string:x97d>" )
        {
            self[ 1 ] setvalue( units );
            self[ 2 ] settext( "<dev string:x9d6>" );
            self[ 3 ].alpha = 0;
        }
        
        level.lastdisttype = engagedisttype;
    }

    // Namespace dev/dev
    // Params 6
    // Checksum 0xa7783f9a, Offset: 0x7358
    // Size: 0x1ee, Type: dev
    function function_57e53630( radius1, radius2, time, color, origin, normal )
    {
        if ( !isdefined( color ) )
        {
            color = ( 0, 1, 0 );
        }
        
        var_9f8f8bbe = 0.05;
        circleres = 6;
        var_242ed014 = circleres / 2;
        circleinc = 360 / circleres;
        circleres++;
        plotpoints = [];
        rad = 0;
        timer = gettime() + time * 1000;
        radius = radius1;
        
        while ( gettime() < timer )
        {
            radius = radius2;
            angletoplayer = vectortoangles( normal );
            
            for ( i = 0; i < circleres ; i++ )
            {
                plotpoints[ plotpoints.size ] = origin + vectorscale( anglestoforward( angletoplayer + ( rad, 90, 0 ) ), radius );
                rad += circleinc;
            }
            
            util::plot_points( plotpoints, color[ 0 ], color[ 1 ], color[ 2 ], var_9f8f8bbe );
            plotpoints = [];
            wait var_9f8f8bbe;
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xe452bb2d, Offset: 0x7550
    // Size: 0x1fa, Type: dev
    function larry_thread()
    {
        setdvar( "<dev string:x9f9>", "<dev string:x4c>" );
        setdvar( "<dev string:xa0b>", "<dev string:x4c>" );
        setdvar( "<dev string:xa1b>", "<dev string:x4c>" );
        setdvar( "<dev string:xa2e>", "<dev string:x4c>" );
        level.larry = spawnstruct();
        player = util::gethostplayer();
        player thread larry_init( level.larry );
        level waittill( "<dev string:xa40>" );
        larry_hud_destroy( level.larry );
        
        if ( isdefined( level.larry.model ) )
        {
            level.larry.model delete();
        }
        
        if ( isdefined( level.larry.ai ) )
        {
            for ( i = 0; i < level.larry.ai.size ; i++ )
            {
                kick( level.larry.ai[ i ] getentitynumber() );
            }
        }
        
        level.larry = undefined;
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0xe9eed46, Offset: 0x7758
    // Size: 0x264, Type: dev
    function larry_init( larry )
    {
        level endon( #"kill_larry" );
        larry_hud_init( larry );
        larry.model = spawn( "<dev string:xa4b>", ( 0, 0, 0 ) );
        larry.model setmodel( "<dev string:xa58>" );
        larry.ai = [];
        wait 0.1;
        
        for ( ;; )
        {
            waitframe( 1 );
            
            if ( larry.ai.size > 0 )
            {
                larry.model hide();
                continue;
            }
            
            direction = self getplayerangles();
            direction_vec = anglestoforward( direction );
            eye = self geteye();
            trace = bullettrace( eye, eye + vectorscale( direction_vec, 8000 ), 0, undefined );
            dist = distance( eye, trace[ "<dev string:x96d>" ] );
            position = eye + vectorscale( direction_vec, dist - 64 );
            larry.model.origin = position;
            larry.model.angles = self.angles + ( 0, 180, 0 );
            
            if ( self usebuttonpressed() )
            {
                self larry_ai( larry );
                
                while ( self usebuttonpressed() )
                {
                    waitframe( 1 );
                }
            }
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0x870d34f5, Offset: 0x79c8
    // Size: 0x10c, Type: dev
    function larry_ai( larry )
    {
        larry.ai[ larry.ai.size ] = bot::add_bot( "<dev string:x190>" );
        i = larry.ai.size - 1;
        larry.ai[ i ] thread larry_ai_thread( larry, larry.model.origin, larry.model.angles );
        larry.ai[ i ] thread larry_ai_damage( larry );
        larry.ai[ i ] thread larry_ai_health( larry );
    }

    // Namespace dev/dev
    // Params 3
    // Checksum 0x42f4869a, Offset: 0x7ae0
    // Size: 0x1d8, Type: dev
    function larry_ai_thread( larry, origin, angles )
    {
        level endon( #"kill_larry" );
        
        for ( ;; )
        {
            self waittill( "<dev string:xa65>" );
            larry.menu[ larry.menu_health ] setvalue( self.health );
            larry.menu[ larry.menu_damage ] settext( "<dev string:x4b>" );
            larry.menu[ larry.menu_range ] settext( "<dev string:x4b>" );
            larry.menu[ larry.menu_hitloc ] settext( "<dev string:x4b>" );
            larry.menu[ larry.menu_weapon ] settext( "<dev string:x4b>" );
            larry.menu[ larry.menu_perks ] settext( "<dev string:x4b>" );
            self setorigin( origin );
            self setplayerangles( angles );
            self clearperks();
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0xaf5c25d7, Offset: 0x7cc0
    // Size: 0x2c8, Type: dev
    function larry_ai_damage( larry )
    {
        level endon( #"kill_larry" );
        
        for ( ;; )
        {
            waitresult = self waittill( "<dev string:xa74>" );
            attacker = waitresult.attacker;
            damage = waitresult.amount;
            point = waitresult.position;
            
            if ( !isdefined( attacker ) )
            {
                continue;
            }
            
            player = util::gethostplayer();
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( attacker != player )
            {
                continue;
            }
            
            eye = player geteye();
            range = int( distance( eye, point ) );
            larry.menu[ larry.menu_health ] setvalue( self.health );
            larry.menu[ larry.menu_damage ] setvalue( damage );
            larry.menu[ larry.menu_range ] setvalue( range );
            
            if ( isdefined( self.cac_debug_location ) )
            {
                larry.menu[ larry.menu_hitloc ] settext( self.cac_debug_location );
            }
            else
            {
                larry.menu[ larry.menu_hitloc ] settext( "<dev string:xa7b>" );
            }
            
            if ( isdefined( self.cac_debug_weapon ) )
            {
                larry.menu[ larry.menu_weapon ] settext( self.cac_debug_weapon );
                continue;
            }
            
            larry.menu[ larry.menu_weapon ] settext( "<dev string:xa7b>" );
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0xc24ba146, Offset: 0x7f90
    // Size: 0x60, Type: dev
    function larry_ai_health( larry )
    {
        level endon( #"kill_larry" );
        
        for ( ;; )
        {
            waitframe( 1 );
            larry.menu[ larry.menu_health ] setvalue( self.health );
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0xe07acdfc, Offset: 0x7ff8
    // Size: 0x5c6, Type: dev
    function larry_hud_init( larry )
    {
        /#
            x = -45;
            y = 275;
            menu_name = "<dev string:xa85>";
            larry.hud = new_hud( menu_name, undefined, x, y, 1 );
            larry.hud setshader( "<dev string:xa90>", 135, 65 );
            larry.hud.alignx = "<dev string:x5e9>";
            larry.hud.aligny = "<dev string:x5ee>";
            larry.hud.sort = 10;
            larry.hud.alpha = 0.6;
            larry.hud.color = ( 0, 0, 0.5 );
            larry.menu[ 0 ] = new_hud( menu_name, "<dev string:xa96>", x + 5, y + 10, 1 );
            larry.menu[ 1 ] = new_hud( menu_name, "<dev string:xaa4>", x + 5, y + 20, 1 );
            larry.menu[ 2 ] = new_hud( menu_name, "<dev string:xaac>", x + 5, y + 30, 1 );
            larry.menu[ 3 ] = new_hud( menu_name, "<dev string:xab3>", x + 5, y + 40, 1 );
            larry.menu[ 4 ] = new_hud( menu_name, "<dev string:xac1>", x + 5, y + 50, 1 );
            larry.cleartextmarker = newdebughudelem();
            larry.cleartextmarker.alpha = 0;
            larry.cleartextmarker settext( "<dev string:xac9>" );
            larry.menu_health = larry.menu.size;
            larry.menu_damage = larry.menu.size + 1;
            larry.menu_range = larry.menu.size + 2;
            larry.menu_hitloc = larry.menu.size + 3;
            larry.menu_weapon = larry.menu.size + 4;
            larry.menu_perks = larry.menu.size + 5;
            x_offset = 70;
            larry.menu[ larry.menu_health ] = new_hud( menu_name, "<dev string:x4b>", x + x_offset, y + 10, 1 );
            larry.menu[ larry.menu_damage ] = new_hud( menu_name, "<dev string:x4b>", x + x_offset, y + 20, 1 );
            larry.menu[ larry.menu_range ] = new_hud( menu_name, "<dev string:x4b>", x + x_offset, y + 30, 1 );
            larry.menu[ larry.menu_hitloc ] = new_hud( menu_name, "<dev string:x4b>", x + x_offset, y + 40, 1 );
            larry.menu[ larry.menu_weapon ] = new_hud( menu_name, "<dev string:x4b>", x + x_offset, y + 50, 1 );
            larry.menu[ larry.menu_perks ] = new_hud( menu_name, "<dev string:x4b>", x + x_offset, y + 60, 1 );
        #/
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0x630cb871, Offset: 0x85c8
    // Size: 0xbc, Type: dev
    function larry_hud_destroy( larry )
    {
        if ( isdefined( larry.hud ) )
        {
            larry.hud destroy();
            
            for ( i = 0; i < larry.menu.size ; i++ )
            {
                larry.menu[ i ] destroy();
            }
            
            larry.cleartextmarker destroy();
        }
    }

    // Namespace dev/dev
    // Params 5
    // Checksum 0x63b52078, Offset: 0x8690
    // Size: 0xda, Type: dev
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

    // Namespace dev/dev
    // Params 7
    // Checksum 0x1bf120e3, Offset: 0x8778
    // Size: 0x1a2, Type: dev
    function set_hudelem( text, x, y, scale, alpha, sort, debug_hudelem )
    {
        /#
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
            
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
            hud.location = 0;
            hud.alignx = "<dev string:x5e9>";
            hud.aligny = "<dev string:xad0>";
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
        #/
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xe8759a99, Offset: 0x8928
    // Size: 0x10, Type: dev
    function function_d99660db()
    {
        return "<dev string:xad7>";
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xe627ab7f, Offset: 0x8940
    // Size: 0x3b0, Type: dev
    function function_c5833485()
    {
        self endon( #"disconnect" );
        clientnum = self getentitynumber();
        
        if ( clientnum != 0 )
        {
            return;
        }
        
        dpad_left = 0;
        dpad_right = 0;
        dpad_up = 0;
        dpad_down = 0;
        var_96f03d58 = 0;
        var_e90d1b0d = function_d99660db();
        
        for ( ;; )
        {
            if ( self buttonpressed( var_e90d1b0d ) )
            {
                if ( !dpad_left && self buttonpressed( "<dev string:x5a9>" ) )
                {
                    self giveweaponnextattachment( "<dev string:xae0>" );
                    dpad_left = 1;
                    self thread print_weapon_name();
                }
                
                if ( !dpad_right && self buttonpressed( "<dev string:x5b3>" ) )
                {
                    self giveweaponnextattachment( "<dev string:xae7>" );
                    dpad_right = 1;
                    self thread print_weapon_name();
                }
                
                if ( !dpad_up && self buttonpressed( "<dev string:xaef>" ) )
                {
                    self giveweaponnextattachment( "<dev string:x5ee>" );
                    dpad_up = 1;
                    self thread print_weapon_name();
                }
                
                if ( !dpad_down && self buttonpressed( "<dev string:xaf7>" ) )
                {
                    self giveweaponnextattachment( "<dev string:xb01>" );
                    dpad_down = 1;
                    self thread print_weapon_name();
                }
                
                if ( !var_96f03d58 && self buttonpressed( "<dev string:xb08>" ) )
                {
                    self giveweaponnextattachment( "<dev string:xb16>" );
                    var_96f03d58 = 1;
                    self thread print_weapon_name();
                }
            }
            
            if ( !self buttonpressed( "<dev string:x5a9>" ) )
            {
                dpad_left = 0;
            }
            
            if ( !self buttonpressed( "<dev string:x5b3>" ) )
            {
                dpad_right = 0;
            }
            
            if ( !self buttonpressed( "<dev string:xaef>" ) )
            {
                dpad_up = 0;
            }
            
            if ( !self buttonpressed( "<dev string:xaf7>" ) )
            {
                dpad_down = 0;
            }
            
            if ( !self buttonpressed( "<dev string:xb08>" ) )
            {
                var_96f03d58 = 0;
            }
            
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x80bd1399, Offset: 0x8cf8
    // Size: 0x134, Type: dev
    function print_weapon_name()
    {
        self notify( #"print_weapon_name" );
        self endon( #"print_weapon_name" );
        wait 0.2;
        
        if ( self isswitchingweapons() )
        {
            waitresult = self waittill( "<dev string:xb1e>" );
            fail_safe = 0;
            
            while ( waitresult.weapon == level.weaponnone )
            {
                waitresult = self waittill( "<dev string:xb1e>" );
                waitframe( 1 );
                fail_safe++;
                
                if ( fail_safe > 120 )
                {
                    break;
                }
            }
        }
        else
        {
            weapon = self getcurrentweapon();
        }
        
        printweaponname = getdvarint( "<dev string:xb35>", 1 );
        
        if ( printweaponname )
        {
            iprintlnbold( weapon.name );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x16e6104c, Offset: 0x8e38
    // Size: 0x1e6, Type: dev
    function set_equipment_list()
    {
        if ( isdefined( level.dev_equipment ) )
        {
            return;
        }
        
        level.dev_equipment = [];
        level.dev_equipment[ 1 ] = getweapon( "<dev string:xb4b>" );
        level.dev_equipment[ 2 ] = getweapon( "<dev string:xb5b>" );
        level.dev_equipment[ 3 ] = getweapon( "<dev string:xb68>" );
        level.dev_equipment[ 4 ] = getweapon( "<dev string:xb71>" );
        level.dev_equipment[ 5 ] = getweapon( "<dev string:xb80>" );
        level.dev_equipment[ 6 ] = getweapon( "<dev string:xb8a>" );
        level.dev_equipment[ 7 ] = getweapon( "<dev string:xb9d>" );
        level.dev_equipment[ 8 ] = getweapon( "<dev string:xbab>" );
        level.dev_equipment[ 9 ] = getweapon( "<dev string:xbb9>" );
        level.dev_equipment[ 10 ] = getweapon( "<dev string:xbc2>" );
        level.dev_equipment[ 11 ] = getweapon( "<dev string:xbd2>" );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x3e74af7d, Offset: 0x9028
    // Size: 0x20e, Type: dev
    function set_grenade_list()
    {
        if ( isdefined( level.dev_grenade ) )
        {
            return;
        }
        
        level.dev_grenade = [];
        level.dev_grenade[ 1 ] = getweapon( "<dev string:xbe0>" );
        level.dev_grenade[ 2 ] = getweapon( "<dev string:xbed>" );
        level.dev_grenade[ 3 ] = getweapon( "<dev string:xbfc>" );
        level.dev_grenade[ 4 ] = getweapon( "<dev string:xc04>" );
        level.dev_grenade[ 5 ] = getweapon( "<dev string:xc0f>" );
        level.dev_grenade[ 6 ] = getweapon( "<dev string:xc21>" );
        level.dev_grenade[ 7 ] = getweapon( "<dev string:xc2f>" );
        level.dev_grenade[ 8 ] = getweapon( "<dev string:xc42>" );
        level.dev_grenade[ 9 ] = getweapon( "<dev string:xc4e>" );
        level.dev_grenade[ 10 ] = getweapon( "<dev string:xc5a>" );
        level.dev_grenade[ 11 ] = getweapon( "<dev string:xc69>" );
        level.dev_grenade[ 12 ] = getweapon( "<dev string:xc7c>" );
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0xc27700c, Offset: 0x9240
    // Size: 0xc6, Type: dev
    function take_all_grenades_and_equipment( player )
    {
        for ( i = 0; i < level.dev_equipment.size ; i++ )
        {
            player takeweapon( level.dev_equipment[ i + 1 ] );
        }
        
        for ( i = 0; i < level.dev_grenade.size ; i++ )
        {
            player takeweapon( level.dev_grenade[ i + 1 ] );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xb58f566b, Offset: 0x9310
    // Size: 0x140, Type: dev
    function equipment_dev_gui()
    {
        set_equipment_list();
        set_grenade_list();
        setdvar( "<dev string:xc91>", "<dev string:x4b>" );
        
        while ( true )
        {
            wait 0.5;
            devgui_int = getdvarint( "<dev string:xc91>" );
            
            if ( devgui_int != 0 )
            {
                for ( i = 0; i < level.players.size ; i++ )
                {
                    take_all_grenades_and_equipment( level.players[ i ] );
                    level.players[ i ] devgui::devgui_give_weapon( level.dev_equipment[ devgui_int ].name );
                }
                
                setdvar( "<dev string:xc91>", "<dev string:x4c>" );
            }
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xa77021fa, Offset: 0x9458
    // Size: 0x140, Type: dev
    function grenade_dev_gui()
    {
        set_equipment_list();
        set_grenade_list();
        setdvar( "<dev string:xca4>", "<dev string:x4b>" );
        
        while ( true )
        {
            wait 0.5;
            devgui_int = getdvarint( "<dev string:xca4>" );
            
            if ( devgui_int != 0 )
            {
                for ( i = 0; i < level.players.size ; i++ )
                {
                    take_all_grenades_and_equipment( level.players[ i ] );
                    level.players[ i ] devgui::devgui_give_weapon( level.dev_grenade[ devgui_int ].name );
                }
                
                setdvar( "<dev string:xca4>", "<dev string:x4c>" );
            }
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0xf923c3e6, Offset: 0x95a0
    // Size: 0x28c, Type: dev
    function force_grenade_throw( weapon )
    {
        if ( weapon == level.weaponnone )
        {
            return;
        }
        
        setdvar( "<dev string:x9f9>", "<dev string:x4c>" );
        setdvar( "<dev string:xa0b>", "<dev string:x4c>" );
        setdvar( "<dev string:xa1b>", "<dev string:x4c>" );
        setdvar( "<dev string:xa2e>", "<dev string:x4c>" );
        setdvar( "<dev string:xcb5>", "<dev string:x4c>" );
        host = util::gethostplayer();
        
        if ( !isdefined( host.team ) )
        {
            iprintln( "<dev string:xcce>" );
            return;
        }
        
        bot = getormakebot( util::getotherteam( host.team ) );
        
        if ( !isdefined( bot ) )
        {
            iprintln( "<dev string:x19b>" );
            return;
        }
        
        angles = host getplayerangles();
        angles = ( 0, angles[ 1 ], 0 );
        dir = anglestoforward( angles );
        dir = vectornormalize( dir );
        origin = host geteye() + vectorscale( dir, 256 );
        velocity = vectorscale( dir, -1024 );
        grenade = bot magicgrenadeplayer( weapon, origin, velocity );
        grenade setteam( bot.team );
        grenade setowner( bot );
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0x712f7295, Offset: 0x9838
    // Size: 0x498, Type: dev
    function devstraferunpathdebugdraw()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        violet = ( 0.4, 0, 0.6 );
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = ( 0, 0, -50 );
        endonmsg = "<dev string:xcf3>";
        
        while ( true )
        {
            if ( killstreaks::should_draw_debug( "<dev string:xd11>" ) > 0 )
            {
                nodes = [];
                end = 0;
                node = getvehiclenode( "<dev string:xd1d>", "<dev string:x236>" );
                
                if ( !isdefined( node ) )
                {
                    println( "<dev string:xd2b>" );
                    setdvar( "<dev string:xd44>", "<dev string:x4c>" );
                    continue;
                }
                
                while ( isdefined( node.target ) )
                {
                    new_node = getvehiclenode( node.target, "<dev string:x236>" );
                    
                    foreach ( n in nodes )
                    {
                        if ( n == new_node )
                        {
                            end = 1;
                        }
                    }
                    
                    textscale = 30;
                    
                    if ( drawtime == maxdrawtime )
                    {
                        node thread drawpathsegment( new_node, violet, violet, 1, textscale, origintextoffset, drawtime, endonmsg );
                    }
                    
                    if ( isdefined( node.script_noteworthy ) )
                    {
                        textscale = 10;
                        
                        switch ( node.script_noteworthy )
                        {
                            case #"strafe_start":
                                textcolor = green;
                                textalpha = 1;
                                break;
                            case #"strafe_stop":
                                textcolor = red;
                                textalpha = 1;
                                break;
                            case #"strafe_leave":
                                textcolor = white;
                                textalpha = 1;
                                break;
                        }
                        
                        switch ( node.script_noteworthy )
                        {
                            case #"strafe_leave":
                            case #"strafe_start":
                            case #"strafe_stop":
                                sides = 10;
                                radius = 100;
                                
                                if ( drawtime == maxdrawtime )
                                {
                                    sphere( node.origin, radius, textcolor, textalpha, 1, sides, drawtime * 1000 );
                                }
                                
                                node draworiginlines();
                                node drawnoteworthytext( textcolor, textalpha, textscale );
                                break;
                        }
                    }
                    
                    if ( end )
                    {
                        break;
                    }
                    
                    nodes[ nodes.size ] = new_node;
                    node = new_node;
                }
                
                drawtime -= 0.05;
                
                if ( drawtime < 0 )
                {
                    drawtime = maxdrawtime;
                }
                
                waitframe( 1 );
                continue;
            }
            
            wait 1;
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xa0dff2d0, Offset: 0x9cd8
    // Size: 0x3c0, Type: dev
    function devhelipathdebugdraw()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        textcolor = white;
        textalpha = 1;
        textscale = 1;
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = ( 0, 0, -50 );
        endonmsg = "<dev string:xd88>";
        
        while ( true )
        {
            if ( getdvarint( "<dev string:xda2>" ) > 0 )
            {
                script_origins = getentarray( "<dev string:xdbc>", "<dev string:x13c>" );
                
                foreach ( ent in script_origins )
                {
                    if ( isdefined( ent.targetname ) )
                    {
                        switch ( ent.targetname )
                        {
                            case #"heli_start":
                                textcolor = blue;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case #"heli_loop_start":
                                textcolor = green;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case #"heli_attack_area":
                                textcolor = red;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case #"heli_leave":
                                textcolor = white;
                                textalpha = 1;
                                textscale = 3;
                                break;
                        }
                        
                        switch ( ent.targetname )
                        {
                            case #"heli_attack_area":
                            case #"heli_leave":
                            case #"heli_loop_start":
                            case #"heli_start":
                                if ( drawtime == maxdrawtime )
                                {
                                    ent thread drawpath( textcolor, white, textalpha, textscale, origintextoffset, drawtime, endonmsg );
                                }
                                
                                ent draworiginlines();
                                ent drawtargetnametext( textcolor, textalpha, textscale );
                                ent draworigintext( textcolor, textalpha, textscale, origintextoffset );
                                break;
                        }
                    }
                }
                
                drawtime -= 0.05;
                
                if ( drawtime < 0 )
                {
                    drawtime = maxdrawtime;
                }
            }
            
            if ( getdvarint( "<dev string:xda2>" ) == 0 )
            {
                level notify( endonmsg );
                drawtime = maxdrawtime;
                wait 1;
            }
            
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xf1127b54, Offset: 0xa0a0
    // Size: 0x11c, Type: dev
    function draworiginlines()
    {
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        line( self.origin, self.origin + anglestoforward( self.angles ) * 10, red );
        line( self.origin, self.origin + anglestoright( self.angles ) * 10, green );
        line( self.origin, self.origin + anglestoup( self.angles ) * 10, blue );
    }

    // Namespace dev/dev
    // Params 4
    // Checksum 0xaf926610, Offset: 0xa1c8
    // Size: 0x74, Type: dev
    function drawtargetnametext( textcolor, textalpha, textscale, textoffset )
    {
        if ( !isdefined( textoffset ) )
        {
            textoffset = ( 0, 0, 0 );
        }
        
        print3d( self.origin + textoffset, self.targetname, textcolor, textalpha, textscale );
    }

    // Namespace dev/dev
    // Params 4
    // Checksum 0xc8b377e6, Offset: 0xa248
    // Size: 0x74, Type: dev
    function drawnoteworthytext( textcolor, textalpha, textscale, textoffset )
    {
        if ( !isdefined( textoffset ) )
        {
            textoffset = ( 0, 0, 0 );
        }
        
        print3d( self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale );
    }

    // Namespace dev/dev
    // Params 4
    // Checksum 0x67016567, Offset: 0xa2c8
    // Size: 0xd4, Type: dev
    function draworigintext( textcolor, textalpha, textscale, textoffset )
    {
        if ( !isdefined( textoffset ) )
        {
            textoffset = ( 0, 0, 0 );
        }
        
        originstring = "<dev string:xe01>" + self.origin[ 0 ] + "<dev string:xe03>" + self.origin[ 1 ] + "<dev string:xe03>" + self.origin[ 2 ] + "<dev string:xe06>";
        print3d( self.origin + textoffset, originstring, textcolor, textalpha, textscale );
    }

    // Namespace dev/dev
    // Params 4
    // Checksum 0xff642084, Offset: 0xa3a8
    // Size: 0xec, Type: dev
    function drawspeedacceltext( textcolor, textalpha, textscale, textoffset )
    {
        if ( isdefined( self.script_airspeed ) )
        {
            print3d( self.origin + ( 0, 0, textoffset[ 2 ] * 2 ), "<dev string:xe08>" + self.script_airspeed, textcolor, textalpha, textscale );
        }
        
        if ( isdefined( self.script_accel ) )
        {
            print3d( self.origin + ( 0, 0, textoffset[ 2 ] * 3 ), "<dev string:xe19>" + self.script_accel, textcolor, textalpha, textscale );
        }
    }

    // Namespace dev/dev
    // Params 7
    // Checksum 0x7466b72c, Offset: 0xa4a0
    // Size: 0x158, Type: dev
    function drawpath( linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg )
    {
        level endon( endonmsg );
        ent = self;
        entfirsttarget = ent.targetname;
        
        while ( isdefined( ent.target ) )
        {
            enttarget = getent( ent.target, "<dev string:x236>" );
            ent thread drawpathsegment( enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg );
            
            if ( ent.targetname == "<dev string:xdd5>" )
            {
                entfirsttarget = ent.target;
            }
            else if ( ent.target == entfirsttarget )
            {
                break;
            }
            
            ent = enttarget;
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 8
    // Checksum 0xd3d20080, Offset: 0xa600
    // Size: 0x128, Type: dev
    function drawpathsegment( enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg )
    {
        level endon( endonmsg );
        
        while ( drawtime > 0 )
        {
            if ( isdefined( self.targetname ) && self.targetname == "<dev string:xd1d>" )
            {
                print3d( self.origin + textoffset, self.targetname, textcolor, textalpha, textscale );
            }
            
            line( self.origin, enttarget.origin, linecolor );
            self drawspeedacceltext( textcolor, textalpha, textscale, textoffset );
            drawtime -= 0.05;
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0xdf68c2d8, Offset: 0xa730
    // Size: 0xc6, Type: dev
    function get_lookat_origin( player )
    {
        angles = player getplayerangles();
        forward = anglestoforward( angles );
        dir = vectorscale( forward, 8000 );
        eye = player geteye();
        trace = bullettrace( eye, eye + dir, 0, undefined );
        return trace[ "<dev string:x96d>" ];
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0x5703f7a3, Offset: 0xa800
    // Size: 0x74, Type: dev
    function draw_pathnode( node, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 1 );
        }
        
        box( node.origin, ( -16, -16, 0 ), ( 16, 16, 16 ), 0, color, 1, 0, 1 );
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0x58227463, Offset: 0xa880
    // Size: 0x4e, Type: dev
    function draw_pathnode_think( node, color )
    {
        level endon( #"draw_pathnode_stop" );
        
        for ( ;; )
        {
            draw_pathnode( node, color );
            waitframe( 1 );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xfed17d99, Offset: 0xa8d8
    // Size: 0x1c, Type: dev
    function draw_pathnodes_stop()
    {
        wait 5;
        level notify( #"draw_pathnode_stop" );
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0x3210308e, Offset: 0xa900
    // Size: 0x120, Type: dev
    function node_get( player )
    {
        for ( ;; )
        {
            waitframe( 1 );
            origin = get_lookat_origin( player );
            node = getnearestnode( origin );
            
            if ( !isdefined( node ) )
            {
                continue;
            }
            
            if ( player buttonpressed( "<dev string:xe27>" ) )
            {
                return node;
            }
            else if ( player buttonpressed( "<dev string:xe30>" ) )
            {
                return undefined;
            }
            
            if ( node.type == "<dev string:x1b5>" )
            {
                draw_pathnode( node, ( 1, 0, 1 ) );
                continue;
            }
            
            draw_pathnode( node, ( 0.85, 0.85, 0.1 ) );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xcf448467, Offset: 0xaa28
    // Size: 0x1b8, Type: dev
    function dev_get_node_pair()
    {
        player = util::gethostplayer();
        start = undefined;
        
        while ( !isdefined( start ) )
        {
            start = node_get( player );
            
            if ( player buttonpressed( "<dev string:xe30>" ) )
            {
                level notify( #"draw_pathnode_stop" );
                return undefined;
            }
        }
        
        level thread draw_pathnode_think( start, ( 0, 1, 0 ) );
        
        while ( player buttonpressed( "<dev string:xe27>" ) )
        {
            waitframe( 1 );
        }
        
        end = undefined;
        
        while ( !isdefined( end ) )
        {
            end = node_get( player );
            
            if ( player buttonpressed( "<dev string:xe30>" ) )
            {
                level notify( #"draw_pathnode_stop" );
                return undefined;
            }
        }
        
        level thread draw_pathnode_think( end, ( 0, 1, 0 ) );
        level thread draw_pathnodes_stop();
        array = [];
        array[ 0 ] = start;
        array[ 1 ] = end;
        return array;
    }

    // Namespace dev/dev
    // Params 2
    // Checksum 0x2066f3d6, Offset: 0xabe8
    // Size: 0x5c, Type: dev
    function draw_point( origin, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 1 );
        }
        
        sphere( origin, 16, color, 0.25, 0, 16, 1 );
    }

    // Namespace dev/dev
    // Params 1
    // Checksum 0x9edce0da, Offset: 0xac50
    // Size: 0xa0, Type: dev
    function point_get( player )
    {
        for ( ;; )
        {
            waitframe( 1 );
            origin = get_lookat_origin( player );
            
            if ( player buttonpressed( "<dev string:xe27>" ) )
            {
                return origin;
            }
            else if ( player buttonpressed( "<dev string:xe30>" ) )
            {
                return undefined;
            }
            
            draw_point( origin, ( 1, 0, 1 ) );
        }
    }

    // Namespace dev/dev
    // Params 0
    // Checksum 0xe8448344, Offset: 0xacf8
    // Size: 0x120, Type: dev
    function dev_get_point_pair()
    {
        player = util::gethostplayer();
        start = undefined;
        points = [];
        
        while ( !isdefined( start ) )
        {
            start = point_get( player );
            
            if ( !isdefined( start ) )
            {
                return points;
            }
        }
        
        while ( player buttonpressed( "<dev string:xe27>" ) )
        {
            waitframe( 1 );
        }
        
        end = undefined;
        
        while ( !isdefined( end ) )
        {
            end = point_get( player );
            
            if ( !isdefined( end ) )
            {
                return points;
            }
        }
        
        points[ 0 ] = start;
        points[ 1 ] = end;
        return points;
    }

#/
