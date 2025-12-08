#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace ammo_station;

// Namespace ammo_station/ammo_station
// Params 0, eflags: 0x2
// Checksum 0xa556d272, Offset: 0x1d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "ammo_station", &__init__, undefined, undefined );
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0xbb497601, Offset: 0x218
// Size: 0x94
function __init__()
{
    clientfield::register( "scriptmover", "ammo_station_init", 1, 1, "int", &ammo_station_init, 0, 0 );
    clientfield::register( "vehicle", "ammo_station_deploy", 1, 1, "int", &ammo_station_deploy_start, 0, 0 );
}

#using_animtree( "mp_emp_power_core" );

// Namespace ammo_station/ammo_station
// Params 7
// Checksum 0xf3a75e2c, Offset: 0x2b8
// Size: 0xc4
function ammo_station_init( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
    
    self useanimtree( #animtree );
    self setanimrestart( %o_turret_emp_core_deploy, 1, 0, 0 );
    self setanimtime( %o_turret_emp_core_deploy, 0 );
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0x1c896d82, Offset: 0x388
// Size: 0x54
function cleanup_fx_on_shutdown( localclientnum, handle )
{
    self endon( #"kill_fx_cleanup" );
    self waittill( "death" );
    
    if ( isdefined( handle ) )
    {
        stopfx( localclientnum, handle );
    }
}

// Namespace ammo_station/ammo_station
// Params 7
// Checksum 0x48c0a56d, Offset: 0x3e8
// Size: 0xd6
function ammo_station_deploy_start( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"death" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        self thread ammo_station_deploy( localclientnum );
        return;
    }
    
    self notify( #"kill_fx_cleanup" );
    
    if ( isdefined( self.fxhandle ) )
    {
        stopfx( localclientnum, self.fxhandle );
        self.fxhandle = undefined;
    }
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x9ed09183, Offset: 0x4c8
// Size: 0x144
function ammo_station_deploy( localclientnum )
{
    self endon( #"death" );
    self useanimtree( #animtree );
    self setanimrestart( %o_turret_emp_core_deploy, 1, 0, 1 );
    length = getanimlength( %o_turret_emp_core_deploy );
    wait length * 0.75;
    self useanimtree( #animtree );
    self setanim( %o_turret_emp_core_spin, 1 );
    self thread cleanup_fx_on_shutdown( localclientnum, self.fxhandle );
    wait length * 0.25;
    self setanim( %o_turret_emp_core_deploy, 0 );
}

