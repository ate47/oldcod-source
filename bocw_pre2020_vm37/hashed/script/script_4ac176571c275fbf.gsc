#using script_7a5cff90cf27582c;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicles\player_vehicle;

#namespace namespace_d2883a2e;

// Namespace namespace_d2883a2e/namespace_d2883a2e
// Params 0, eflags: 0x6
// Checksum 0x2e39cfa7, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_624dc0720663b513", undefined, &postinit, undefined, undefined );
}

// Namespace namespace_d2883a2e/namespace_d2883a2e
// Params 0
// Checksum 0x59509320, Offset: 0x138
// Size: 0x54
function postinit()
{
    /#
        init_devgui();
    #/
    
    callback::on_vehicle_spawned( &on_vehicle_spawned );
    level.var_d4865443 = blackseajetskideployprompt::register();
}

// Namespace namespace_d2883a2e/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0x5f272ef0, Offset: 0x198
// Size: 0xac
function event_handler[exit_vehicle] codecallback_vehicleexit( eventstruct )
{
    vehicle = eventstruct.vehicle;
    player = self;
    
    if ( isvehicle( vehicle ) && isdefined( vehicle.var_c11876a8 ) )
    {
        exit_pos = getclosestpointonnavmesh( self.origin, 256, 30 );
        
        if ( isvec( exit_pos ) )
        {
            player setorigin( exit_pos );
        }
    }
}

// Namespace namespace_d2883a2e/namespace_d2883a2e
// Params 0
// Checksum 0xca851d4a, Offset: 0x250
// Size: 0x5ac
function on_vehicle_spawned()
{
    level endon( #"game_ended" );
    wait 1;
    waitframe( 1 );
    
    /#
        self thread function_d765ccad();
    #/
    
    if ( isdefined( self ) && isdefined( self.target ) )
    {
        var_d8cde75b = struct::get( self.target );
        
        if ( isdefined( var_d8cde75b ) && is_true( var_d8cde75b.var_2fdd4465 ) && getdvarint( #"hash_11091de0ff4dd715", 1 ) )
        {
            self player_vehicle::function_971ca64b();
            
            if ( !isdefined( var_d8cde75b.script_side ) )
            {
                var_d8cde75b.script_side = "port";
            }
            
            var_c11876a8 = util::spawn_model( #"tag_origin", var_d8cde75b.origin, var_d8cde75b.angles );
            self.var_c11876a8 = var_c11876a8;
            self.origin = var_d8cde75b.origin;
            self.angles = var_d8cde75b.angles;
            fall = struct::get( var_d8cde75b.target );
            fall.targetname = undefined;
            fall thread scene::init( fall.scriptbundlename );
            var_d487d45c = fall.scene_ents[ #"prop 1" ];
            
            if ( isdefined( var_d487d45c ) && isdefined( var_c11876a8 ) && isalive( self ) )
            {
                var_c11876a8 setmovingplatformenabled( 1 );
                self linkto( var_c11876a8, "tag_origin" );
                var_c11876a8 linkto( var_d487d45c, "tag_jetski" );
            }
            
            var_c8229258 = "enter_vehicle";
            
            if ( getdvarint( #"hash_23e9bea0349746ee", 1 ) )
            {
                var_c8229258 = "deploy";
            }
            
            if ( isalive( self ) )
            {
                self thread function_8f1b924f();
                self waittill( #"death", #"delete", var_c8229258 );
            }
            
            waitframe( 1 );
            
            if ( isdefined( var_d8cde75b ) )
            {
                if ( isdefined( fall ) && isdefined( fall.scriptbundlename ) )
                {
                    fall thread scene::play( fall.scriptbundlename );
                    
                    if ( isalive( self ) )
                    {
                        var_2e4576cb = groundtrace( self.origin, self.origin + ( 0, 0, -1024 ), 1, self, 0, 0 );
                        offset = vectorscale( anglestoright( self.angles ) * -1, 18 );
                        rotation = 42;
                        
                        if ( var_d8cde75b.script_side == "starboard" )
                        {
                            rotation = -42;
                            offset = vectorscale( anglestoright( self.angles ), 18 );
                        }
                        
                        var_6b6fec6c = var_2e4576cb[ #"position" ] + offset;
                        fall_time = abs( distance( self.origin, var_6b6fec6c ) / 390 );
                        
                        if ( isdefined( var_c11876a8 ) )
                        {
                            var_c11876a8 unlink();
                            var_c11876a8 moveto( var_6b6fec6c, fall_time );
                            var_c11876a8 rotateyaw( rotation, fall_time );
                            var_c11876a8 waittill( #"movedone" );
                        }
                        
                        player = self.var_3ba86b09;
                        
                        if ( isalive( player ) && isdefined( self ) )
                        {
                            player setplayerangles( self.angles );
                        }
                    }
                }
                
                if ( isdefined( self ) )
                {
                    self unlink();
                }
                
                if ( isdefined( var_c11876a8 ) )
                {
                    var_c11876a8 delete();
                }
            }
            
            waitframe( 1 );
            
            if ( isalive( self ) )
            {
                self player_vehicle::function_a2626745();
            }
        }
    }
}

// Namespace namespace_d2883a2e/namespace_d2883a2e
// Params 0
// Checksum 0x5976b9b1, Offset: 0x808
// Size: 0x3c6
function function_8f1b924f()
{
    vehicle = self;
    player = undefined;
    vehicle endon( #"death", #"delete" );
    
    while ( getdvarint( #"hash_23e9bea0349746ee", 1 ) )
    {
        if ( isalive( player ) && player isinvehicle() )
        {
            while ( isalive( player ) && player !== vehicle getseatoccupant( 0 ) )
            {
                waitframe( 1 );
            }
            
            level.var_d4865443 blackseajetskideployprompt::open( player );
        }
        else
        {
            waitresult = vehicle waittill( #"enter_vehicle", #"exit_vehicle", #"change_seat" );
            player = waitresult.player;
            
            if ( player == vehicle getseatoccupant( 0 ) )
            {
                level.var_d4865443 blackseajetskideployprompt::open( player );
            }
        }
        
        while ( isalive( player ) && player === vehicle getseatoccupant( 0 ) && !player vehiclemoveupbuttonpressed() )
        {
            waitframe( 1 );
        }
        
        while ( isalive( player ) && player === vehicle getseatoccupant( 0 ) )
        {
            time = gettime();
            progress = 0;
            
            while ( isalive( player ) && player vehiclemoveupbuttonpressed() )
            {
                var_2755519a = gettime();
                progress = ( var_2755519a - time ) / int( 0.8 * 1000 );
                level.var_d4865443 blackseajetskideployprompt::function_26d9350e( player, progress );
                
                if ( var_2755519a - time >= int( 0.8 * 1000 ) )
                {
                    vehicle.var_3ba86b09 = player;
                    level.var_d4865443 blackseajetskideployprompt::close( player );
                    
                    /#
                        vehicle.var_1c364998 = 1;
                    #/
                    
                    vehicle notify( #"deploy" );
                    return;
                }
                
                waitframe( 1 );
            }
            
            level.var_d4865443 blackseajetskideployprompt::function_26d9350e( player, progress );
            waitframe( 1 );
        }
        
        level.var_d4865443 blackseajetskideployprompt::close( player );
    }
    
    self notify( #"deploy" );
}

// Namespace namespace_d2883a2e/namespace_d2883a2e
// Params 1
// Checksum 0x3bde0fe5, Offset: 0xbd8
// Size: 0x34
function function_c23a7764( *var_1f4fe801 )
{
    if ( isdefined( self.vehicle ) )
    {
        self.vehicle notify( #"deploy" );
    }
}

/#

    // Namespace namespace_d2883a2e/namespace_d2883a2e
    // Params 0
    // Checksum 0x6dea2c79, Offset: 0xc18
    // Size: 0x486, Type: dev
    function function_d765ccad()
    {
        if ( !getdvarint( #"hash_434bcbd42475a326", 0 ) )
        {
            return;
        }
        
        str_type = function_9e72a96( self.vehicletype );
        
        if ( str_type === "<dev string:x38>" )
        {
            return;
        }
        
        self endon( #"death" );
        
        if ( !isdefined( level.var_6eef6733 ) )
        {
            level.var_6eef6733 = [];
        }
        
        if ( !isdefined( level.var_6eef6733[ function_9e72a96( self.vehicletype ) ] ) )
        {
            level.var_6eef6733[ function_9e72a96( self.vehicletype ) ] = [];
        }
        
        if ( !isdefined( level.var_6eef6733[ function_9e72a96( self.vehicletype ) ] ) )
        {
            level.var_6eef6733[ function_9e72a96( self.vehicletype ) ] = [];
        }
        else if ( !isarray( level.var_6eef6733[ function_9e72a96( self.vehicletype ) ] ) )
        {
            level.var_6eef6733[ function_9e72a96( self.vehicletype ) ] = array( level.var_6eef6733[ function_9e72a96( self.vehicletype ) ] );
        }
        
        level.var_6eef6733[ function_9e72a96( self.vehicletype ) ][ level.var_6eef6733[ function_9e72a96( self.vehicletype ) ].size ] = self;
        v_spawn_pos = self.origin;
        level thread function_f567f0cd();
        level flag::wait_till( "<dev string:x5c>" );
        location = self.origin;
        
        if ( isdefined( self.target ) )
        {
            deploy = struct::get( self.target );
            var_b3d2d0b5 = deploy.origin;
        }
        
        while ( getdvarint( #"hash_434bcbd42475a326", 0 ) )
        {
            var_91d1913b = distance( level.players[ 0 ].origin, location );
            n_radius = 0.015 * var_91d1913b;
            
            if ( n_radius > 768 )
            {
                n_radius = 768;
            }
            
            if ( var_91d1913b > 768 )
            {
                sphere( location, n_radius, ( 1, 0, 1 ) );
                
                if ( var_91d1913b < 2048 )
                {
                    print3d( location + ( 0, 0, 32 ), str_type, ( 1, 0, 1 ) );
                }
                
                if ( isdefined( deploy ) )
                {
                    sphere( var_b3d2d0b5, n_radius, ( 1, 1, 0 ) );
                    
                    if ( var_91d1913b < 2048 )
                    {
                        print3d( var_b3d2d0b5 + ( 0, 0, 32 ), str_type, ( 1, 1, 0 ) );
                    }
                }
            }
            
            if ( getdvarint( #"hash_434bcbd42475a326", 0 ) && distance2d( v_spawn_pos, location ) > 768 )
            {
                line( v_spawn_pos, location, ( 0, 1, 0 ) );
                circle( v_spawn_pos, 64, ( 0, 1, 0 ), 0, 1 );
            }
            
            waitframe( 1 );
        }
    }

    // Namespace namespace_d2883a2e/namespace_d2883a2e
    // Params 0
    // Checksum 0x8ffaf1ca, Offset: 0x10a8
    // Size: 0x276, Type: dev
    function function_f567f0cd()
    {
        level notify( #"hash_79845fe0e187bb22" );
        level endon( #"hash_79845fe0e187bb22" );
        
        while ( getdvarint( #"hash_434bcbd42475a326", 0 ) )
        {
            n_total = 0;
            var_bd9acc19 = 176;
            
            foreach ( var_f0ffe8b2 in level.var_6eef6733 )
            {
                var_bd9acc19 += 24;
                n_total += var_f0ffe8b2.size;
                
                foreach ( var_3ed342fe in var_f0ffe8b2 )
                {
                    if ( isvehicle( var_3ed342fe ) && isdefined( var_f0ffe8b2 ) && isdefined( var_f0ffe8b2[ 0 ] ) && isdefined( var_f0ffe8b2[ 0 ].vehicletype ) )
                    {
                        debug2dtext( ( 810, var_bd9acc19, 0 ), function_9e72a96( var_f0ffe8b2[ 0 ].vehicletype ) + "<dev string:x74>" + var_f0ffe8b2.size, var_3ed342fe function_b2775b52() );
                        break;
                    }
                }
            }
            
            debug2dtext( ( 810, 176, 0 ), "<dev string:x7a>" + n_total, ( 1, 1, 1 ) );
            waitframe( 1 );
        }
    }

    // Namespace namespace_d2883a2e/namespace_d2883a2e
    // Params 2
    // Checksum 0xdc240be2, Offset: 0x1328
    // Size: 0x2c, Type: dev
    function function_b2775b52( deploy, *type )
    {
        if ( isdefined( type ) )
        {
            return ( 1, 1, 0 );
        }
        
        return ( 0, 1, 0 );
    }

    // Namespace namespace_d2883a2e/namespace_d2883a2e
    // Params 0
    // Checksum 0xca55a23c, Offset: 0x1360
    // Size: 0x74, Type: dev
    function init_devgui()
    {
        mapname = util::get_map_name();
        adddebugcommand( "<dev string:x94>" + mapname + "<dev string:xa5>" );
        adddebugcommand( "<dev string:x94>" + mapname + "<dev string:x10a>" );
    }

#/
