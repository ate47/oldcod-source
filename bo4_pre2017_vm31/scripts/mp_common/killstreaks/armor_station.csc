#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace armor_station;

// Namespace armor_station/armor_station
// Params 0, eflags: 0x2
// Checksum 0x4267a664, Offset: 0x1b0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "armor_station", &__init__, undefined, undefined );
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x78e045d2, Offset: 0x1f0
// Size: 0x94
function __init__()
{
    clientfield::register( "scriptmover", "armor_station_init", 1, 1, "int", &armor_station_init, 0, 0 );
    clientfield::register( "vehicle", "armor_station_deploy", 1, 1, "int", &armor_station_deploy_start, 0, 0 );
}

// Namespace armor_station/armor_station
// Params 7
// Checksum 0x588ada2f, Offset: 0x290
// Size: 0x46
function armor_station_init( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
}

// Namespace armor_station/armor_station
// Params 2
// Checksum 0xbad52480, Offset: 0x2e0
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

// Namespace armor_station/armor_station
// Params 7
// Checksum 0xb17e6656, Offset: 0x340
// Size: 0xd6
function armor_station_deploy_start( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"death" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        self thread armor_station_deploy( localclientnum );
        return;
    }
    
    self notify( #"kill_fx_cleanup" );
    
    if ( isdefined( self.fxhandle ) )
    {
        stopfx( localclientnum, self.fxhandle );
        self.fxhandle = undefined;
    }
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0xdfb98ac8, Offset: 0x420
// Size: 0x18
function armor_station_deploy( localclientnum )
{
    self endon( #"death" );
}

