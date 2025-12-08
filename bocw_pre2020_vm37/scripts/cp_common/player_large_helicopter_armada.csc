#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;

#namespace player_large_helicopter_armada;

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 0, eflags: 0x6
// Checksum 0x7df5867e, Offset: 0x180
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"player_large_helicopter_armada", &preinit, undefined, undefined, #"player_vehicle" );
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 0, eflags: 0x4
// Checksum 0x389b43c9, Offset: 0x1d0
// Size: 0x74
function private preinit()
{
    vehicle::add_vehicletype_callback( "player_large_helicopter_armada", &function_38ae4287 );
    clientfield::register( "scriptmover", "armada_chopper_deathfx", 1, 1, "int", &field_do_deathfx, 0, 0 );
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 2, eflags: 0x4
// Checksum 0x3ccb1b71, Offset: 0x250
// Size: 0x5c
function private function_38ae4287( localclientnum, *data )
{
    self.var_41860110 = &function_74272495;
    self.var_c6a9216 = &function_8411122e;
    self thread function_69fda304( data );
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 7, eflags: 0x4
// Checksum 0xdf4c4da2, Offset: 0x2b8
// Size: 0x6c
function private field_do_deathfx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        self util::playfxontag( fieldname, "vehicle/fx8_vdest_heli_fuselage_destroyed", self, "tag_origin" );
    }
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 7, eflags: 0x4
// Checksum 0x214be81e, Offset: 0x330
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

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 2, eflags: 0x4
// Checksum 0xab0d0a8a, Offset: 0x450
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

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 2, eflags: 0x4
// Checksum 0xe344c1b2, Offset: 0x560
// Size: 0x18, Type: bool
function private function_74272495( *localclientnum, *owner )
{
    return true;
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 1, eflags: 0x4
// Checksum 0xca5e0424, Offset: 0x580
// Size: 0x106
function private function_69fda304( localclientnum )
{
    self endon( #"death" );
    
    while ( true )
    {
        waitresult = self waittill( #"enter_vehicle" );
        
        if ( "right" == "right" )
        {
            self function_4e9da3d7( 1 );
        }
        
        if ( isdefined( waitresult.player ) )
        {
            if ( waitresult.player function_21c0fa55() )
            {
                waitresult.player thread function_732976d8( localclientnum, self );
                self thread function_ef93e0f5( waitresult.player );
            }
        }
        
        self thread function_5e7d8e1e();
        waitframe( 1 );
    }
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 0, eflags: 0x4
// Checksum 0x4d46822e, Offset: 0x690
// Size: 0x62
function private function_5e7d8e1e()
{
    self notify( "5825fc11634841f0" );
    self endon( "5825fc11634841f0" );
    self endon( #"death", #"disconnect", #"exit_vehicle" );
    
    while ( true )
    {
        waitframe( 1 );
    }
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 1, eflags: 0x4
// Checksum 0xd84ae485, Offset: 0x700
// Size: 0x74
function private heli_exit( localclientnum )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"exit_vehicle" );
    self function_d1731820( localclientnum );
    self function_bada59a4();
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 1, eflags: 0x4
// Checksum 0x3b6267f4, Offset: 0x780
// Size: 0xec
function private function_ef93e0f5( player )
{
    seatnum = self getoccupantseat( 0, player );
    
    if ( 1 && isdefined( seatnum ) && seatnum == 0 )
    {
        self setanim( #"t9_arm_huey_ambient_delta_dummy" );
        self setanim( #"t9_arm_huey_ambient_hover_additive" );
        return;
    }
    
    if ( 0 && isdefined( seatnum ) && seatnum != 0 )
    {
        self setanim( #"t9_arm_huey_ambient_delta_dummy" );
        self setanim( #"t9_arm_huey_ambient_hover_additive" );
    }
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 0, eflags: 0x4
// Checksum 0x2a08956a, Offset: 0x878
// Size: 0x44
function private function_bada59a4()
{
    self clearanim( #"t9_arm_huey_ambient_delta_dummy", 0 );
    self clearanim( #"t9_arm_huey_ambient_hover_additive", 0 );
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 1, eflags: 0x4
// Checksum 0xa50d4808, Offset: 0x8c8
// Size: 0x4e
function private function_d1731820( localclientnum )
{
    if ( isdefined( self ) && isdefined( self.var_a9757792 ) )
    {
        self stoprumble( localclientnum, self.var_a9757792 );
        self.var_a9757792 = undefined;
    }
}

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 2, eflags: 0x4
// Checksum 0xd6eb6a54, Offset: 0x920
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

// Namespace player_large_helicopter_armada/player_large_helicopter_armada
// Params 2, eflags: 0x4
// Checksum 0x34b42902, Offset: 0x9b0
// Size: 0x23c
function private function_732976d8( localclientnum, vehicle )
{
    self notify( "464688c098446c3e" );
    self endon( "464688c098446c3e" );
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

