#using scripts\core_common\struct;
#using scripts\core_common\vehicle_shared;

#namespace siegebot;

// Namespace siegebot/siegebot
// Params 0, eflags: 0x2
// Checksum 0x3d5a6bc6, Offset: 0x80
// Size: 0x2c
function autoexec main()
{
    vehicle::add_vehicletype_callback( "siegebot", &_setup_ );
}

// Namespace siegebot/siegebot
// Params 1
// Checksum 0xcde41117, Offset: 0xb8
// Size: 0x48
function _setup_( *localclientnum )
{
    if ( isdefined( self.scriptbundlesettings ) )
    {
        settings = getscriptbundle( self.scriptbundlesettings );
    }
    
    if ( !isdefined( settings ) )
    {
        return;
    }
}

