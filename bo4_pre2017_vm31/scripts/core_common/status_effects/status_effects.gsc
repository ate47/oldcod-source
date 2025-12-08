#using scripts/core_common/callbacks_shared;
#using scripts/core_common/status_effects/status_effect_blind;
#using scripts/core_common/status_effects/status_effect_burn;
#using scripts/core_common/status_effects/status_effect_deaf;
#using scripts/core_common/status_effects/status_effect_poison;
#using scripts/core_common/status_effects/status_effect_pulse;
#using scripts/core_common/status_effects/status_effect_shock;
#using scripts/core_common/status_effects/status_effect_slowed;
#using scripts/core_common/status_effects/status_effect_stagger;
#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect;

// Namespace status_effect/status_effects
// Params 0, eflags: 0x2
// Checksum 0x1e2b5ab3, Offset: 0x328
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "status_effects", &__init__, undefined, undefined );
}

// Namespace status_effect/status_effects
// Params 0
// Checksum 0x6581a072, Offset: 0x368
// Size: 0x7c
function __init__()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    callback::on_disconnect( &on_player_disconnect );
    
    /#
        level thread status_effects_init();
    #/
}

// Namespace status_effect/status_effects
// Params 0
// Checksum 0x7d19edda, Offset: 0x3f0
// Size: 0x3c
function on_player_connect()
{
    if ( !isdefined( self._gadgets_player ) )
    {
        self._gadgets_player = [];
    }
    
    /#
        self thread status_effects_devgui_player_connect();
    #/
}

// Namespace status_effect/status_effects
// Params 0
// Checksum 0x80f724d1, Offset: 0x438
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace status_effect/status_effects
// Params 0
// Checksum 0xb0691452, Offset: 0x448
// Size: 0x1c
function on_player_disconnect()
{
    /#
        self thread status_effects_devgui_player_disconnect();
    #/
}

/#

    // Namespace status_effect/status_effects
    // Params 0
    // Checksum 0x401e3219, Offset: 0x470
    // Size: 0xcc, Type: dev
    function status_effects_init()
    {
        setdvar( "scr_status_effects_devgui_cmd", "" );
        setdvar( "scr_status_effects_devgui_arg", 0 );
        setdvar( "scr_status_effects_devgui_player", 0 );
        
        if ( isdedicated() )
        {
            return;
        }
        
        level.status_effects_devgui_base = "\"Player/Status Effects/.";
        level.status_effects_devgui_player_connect = &status_effects_devgui_player_connect;
        level.status_effects_devgui_player_disconnect = &status_effects_devgui_player_disconnect;
        level thread status_effects_devgui_think();
    }

    // Namespace status_effect/status_effects
    // Params 0
    // Checksum 0x9b284f63, Offset: 0x548
    // Size: 0x6c, Type: dev
    function status_effects_devgui_player_disconnect()
    {
        if ( !isdefined( level.status_effects_devgui_base ) )
        {
            return;
        }
        
        remove_cmd_with_root = "devgui_remove " + level.status_effects_devgui_base + self.playername + "\" \n";
        util::add_queued_debug_command( remove_cmd_with_root );
    }

    // Namespace status_effect/status_effects
    // Params 0
    // Checksum 0x18d3a08d, Offset: 0x5c0
    // Size: 0xf0, Type: dev
    function status_effects_devgui_player_connect()
    {
        if ( !isdefined( level.status_effects_devgui_base ) )
        {
            return;
        }
        
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( players[ i ] != self )
            {
                continue;
            }
            
            status_effects_devgui_add_player_status_effects( level.status_effects_devgui_base, players[ i ].playername, i + 1 );
            status_effects_devgui_add_player_grenades( level.status_effects_devgui_base, players[ i ].playername, i + 1 );
            return;
        }
    }

    // Namespace status_effect/status_effects
    // Params 3
    // Checksum 0x16795cc3, Offset: 0x6b8
    // Size: 0x10e, Type: dev
    function status_effects_devgui_add_player_status_effects( root, pname, index )
    {
        add_cmd_with_root = "devgui_cmd " + root + pname + "/ Apply Effect /";
        pid = "" + index;
        
        if ( isdefined( level._status_effects ) )
        {
            for ( i = 0; i < level._status_effects.size ; i++ )
            {
                if ( isdefined( level._status_effects[ i ].name ) )
                {
                    status_effects_devgui_add_player_command( add_cmd_with_root, pid, level._status_effects[ i ].name, "set_active", i );
                }
            }
        }
    }

    // Namespace status_effect/status_effects
    // Params 3
    // Checksum 0x20685619, Offset: 0x7d0
    // Size: 0x126, Type: dev
    function status_effects_devgui_add_player_grenades( root, pname, index )
    {
        add_cmd_with_root = "devgui_cmd " + root + pname + "/ Give Grenade /";
        pid = "" + index;
        
        if ( isdefined( level._status_effects ) )
        {
            for ( i = 0; i < level._status_effects.size ; i++ )
            {
                if ( isdefined( level._status_effects[ i ].name ) )
                {
                    grenade = "status_effect_grenade_" + level._status_effects[ i ].name;
                    status_effects_devgui_add_player_command( add_cmd_with_root, pid, grenade, "give_grenade", grenade );
                }
            }
        }
    }

    // Namespace status_effect/status_effects
    // Params 5
    // Checksum 0x752f4d64, Offset: 0x900
    // Size: 0xcc, Type: dev
    function status_effects_devgui_add_player_command( root, pid, cmdname, cmddvar, argdvar )
    {
        if ( !isdefined( argdvar ) )
        {
            argdvar = "no_args";
        }
        
        adddebugcommand( root + cmdname + "\" \"set " + "scr_status_effects_devgui_player" + " " + pid + ";set " + "scr_status_effects_devgui_cmd" + " " + cmddvar + ";set " + "scr_status_effects_devgui_arg" + " " + argdvar + "\" \n" );
    }

    // Namespace status_effect/status_effects
    // Params 0
    // Checksum 0xc37d4628, Offset: 0x9d8
    // Size: 0x120, Type: dev
    function status_effects_devgui_think()
    {
        for ( ;; )
        {
            cmd = getdvarstring( "scr_status_effects_devgui_cmd" );
            
            if ( cmd == "" )
            {
                waitframe( 1 );
                continue;
            }
            
            pid = getdvarint( "scr_status_effects_devgui_player" );
            
            switch ( cmd )
            {
                case #"set_active":
                    status_effects_set_active_effect( pid );
                    break;
                case #"give_grenade":
                    status_effects_give_grenade( pid );
                    break;
                default:
                    break;
            }
            
            setdvar( "scr_status_effects_devgui_cmd", "" );
            setdvar( "scr_status_effects_devgui_arg", "" );
            wait 0.5;
        }
    }

    // Namespace status_effect/status_effects
    // Params 1
    // Checksum 0x9ac7e7a, Offset: 0xb00
    // Size: 0x84, Type: dev
    function status_effects_set_active_effect( pid )
    {
        arg = getdvarint( "scr_status_effects_devgui_arg" );
        player = getplayers()[ pid - 1 ];
        
        if ( isdefined( player ) )
        {
            player status_effect_apply( arg );
        }
    }

    // Namespace status_effect/status_effects
    // Params 1
    // Checksum 0xfbf6124e, Offset: 0xb90
    // Size: 0x22c, Type: dev
    function status_effects_give_grenade( pid )
    {
        arg = getdvarstring( "scr_status_effects_devgui_arg" );
        player = getplayers()[ pid - 1 ];
        
        if ( isdefined( player ) )
        {
            weapon = getweapon( arg );
            grenades = 0;
            pweapons = player getweaponslist();
            
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
                        player takeweapon( pweapon );
                        
                        if ( grenades < 2 )
                        {
                            break;
                        }
                    }
                }
            }
            
            player giveweapon( weapon );
        }
    }

#/
