#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;

#namespace player_helicopter_huey;

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x6
// Checksum 0x6b33366b, Offset: 0x128
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"player_helicopter_huey", &preinit, undefined, undefined, #"player_vehicle" );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 0, eflags: 0x4
// Checksum 0x8da4d53d, Offset: 0x178
// Size: 0x2c
function private preinit()
{
    vehicle::add_vehicletype_callback( "player_helicopter_huey", &function_de7295bc );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 7, eflags: 0x4
// Checksum 0xc0965e31, Offset: 0x1b0
// Size: 0x6c
function private field_do_deathfx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        self util::playfxontag( fieldname, "vehicle/fx8_vdest_heli_fuselage_destroyed", self, "tag_origin" );
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 7, eflags: 0x4
// Checksum 0x165426d1, Offset: 0x228
// Size: 0x112
function private function_b4806ee( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.settings ) && isdefined( self.scriptbundlesettings ) )
    {
        self.settings = getscriptbundle( self.scriptbundlesettings );
    }
    
    if ( isdefined( self.var_ec515b18 ) )
    {
        stopfx( fieldname, self.var_ec515b18 );
        self.var_ec515b18 = undefined;
    }
    
    if ( bwastimejump == 1 )
    {
        if ( isdefined( self.settings ) && isdefined( self.settings.vehicle_turret ) )
        {
            self.var_ec515b18 = self util::playfxontag( fieldname, self.settings.vehicle_turret, self, "tag_gunner_flash1" );
        }
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 2, eflags: 0x4
// Checksum 0xd7e88766, Offset: 0x348
// Size: 0x5c
function private function_de7295bc( localclientnum, *data )
{
    self.var_41860110 = &function_74272495;
    self.var_c6a9216 = &function_8411122e;
    self thread function_69fda304( data );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 2, eflags: 0x4
// Checksum 0x98d9929f, Offset: 0x3b0
// Size: 0x102
function private function_8411122e( *localclientnum, *owner )
{
    surfaces = [];
    
    if ( isdefined( self.trace ) )
    {
        if ( self.trace[ #"fraction" ] != 1 )
        {
            if ( !isdefined( surfaces ) )
            {
                surfaces = [];
            }
            else if ( !isarray( surfaces ) )
            {
                surfaces = array( surfaces );
            }
            
            if ( !isinarray( surfaces, driving_fx::function_73e08cca( self.trace[ #"surfacetype" ] ) ) )
            {
                surfaces[ surfaces.size ] = driving_fx::function_73e08cca( self.trace[ #"surfacetype" ] );
            }
        }
    }
    
    return surfaces;
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 2, eflags: 0x4
// Checksum 0x5e03ad2e, Offset: 0x4c0
// Size: 0x18, Type: bool
function private function_74272495( *localclientnum, *owner )
{
    return true;
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0x5b034880, Offset: 0x4e0
// Size: 0x98
function private function_69fda304( localclientnum )
{
    self endon( #"death" );
    
    while ( true )
    {
        waitresult = self waittill( #"enter_vehicle" );
        
        if ( isdefined( waitresult.player ) )
        {
            if ( waitresult.player function_21c0fa55() )
            {
                waitresult.player thread function_732976d8( localclientnum, self );
            }
        }
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xdf5d9186, Offset: 0x580
// Size: 0x5c
function private heli_exit( localclientnum )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"exit_vehicle" );
    self function_d1731820( localclientnum );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 1, eflags: 0x4
// Checksum 0xf6030208, Offset: 0x5e8
// Size: 0x4e
function private function_d1731820( localclientnum )
{
    if ( isdefined( self ) && isdefined( self.var_a9757792 ) )
    {
        self stoprumble( localclientnum, self.var_a9757792 );
        self.var_a9757792 = undefined;
    }
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 2, eflags: 0x4
// Checksum 0x6371e4a1, Offset: 0x640
// Size: 0x84
function private function_ff8d2820( localclientnum, rumble )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.var_a9757792 === rumble )
    {
        return;
    }
    
    if ( isdefined( self.var_a9757792 ) )
    {
        self function_d1731820( localclientnum );
    }
    
    self.var_a9757792 = rumble;
    self playrumblelooponentity( localclientnum, self.var_a9757792 );
}

// Namespace player_helicopter_huey/player_helicopter_huey
// Params 2, eflags: 0x4
// Checksum 0x9eb629cf, Offset: 0x6d0
// Size: 0x23c
function private function_732976d8( localclientnum, vehicle )
{
    self notify( "58c83e709e918b2f" );
    self endon( "58c83e709e918b2f" );
    self endon( #"death" );
    self endon( #"disconnect" );
    var_26408b5d = sqr( 210 );
    offsetorigin = ( 0, 0, 210 * 2 );
    
    while ( true )
    {
        if ( !isdefined( vehicle ) || !isinvehicle( localclientnum, vehicle ) )
        {
            break;
        }
        
        if ( !vehicle isdrivingvehicle( self ) && self function_21c0fa55() )
        {
            self function_d1731820( localclientnum );
            wait 1;
            continue;
        }
        
        trace = bullettrace( vehicle.origin, vehicle.origin - offsetorigin, 0, vehicle, 1 );
        distsqr = distancesquared( vehicle.origin, trace[ #"position" ] );
        
        if ( trace[ #"fraction" ] == 1 )
        {
            self function_d1731820( localclientnum );
            wait 1;
            continue;
        }
        
        if ( distsqr > var_26408b5d )
        {
            self function_d1731820( localclientnum );
            wait 0.2;
            continue;
        }
        
        self function_ff8d2820( localclientnum, "fallwind_loop_slow" );
        wait 0.2;
    }
    
    self function_d1731820( localclientnum );
}

