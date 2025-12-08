#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\callbacks;
#using scripts\weapons\cp\explosive_bolt;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x6
// Checksum 0x58fda1d3, Offset: 0xe8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"callback", &preinit, undefined, undefined, undefined );
}

// Namespace callback/callbacks
// Params 0, eflags: 0x4
// Checksum 0x2ba5d305, Offset: 0x130
// Size: 0x1c
function private preinit()
{
    level thread set_default_callbacks();
}

// Namespace callback/callbacks
// Params 0
// Checksum 0x7d340826, Offset: 0x158
// Size: 0xac
function set_default_callbacks()
{
    level.callbackplayerspawned = &playerspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackcreatingcorpse = &creating_corpse;
    level.callbackentityspawned = &entityspawned;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level._custom_weapon_cb_func = &spawned_weapon_type;
    level.var_6b11d5f6 = &function_cbfd8fd6;
}

// Namespace callback/callbacks
// Params 1
// Checksum 0xdf77e340, Offset: 0x210
// Size: 0x9c
function localclientconnect( localclientnum )
{
    println( "<dev string:x38>" + localclientnum );
    
    if ( isdefined( level.charactercustomizationsetup ) )
    {
        [[ level.charactercustomizationsetup ]]( localclientnum );
    }
    
    if ( isdefined( level.weaponcustomizationiconsetup ) )
    {
        [[ level.weaponcustomizationiconsetup ]]( localclientnum );
    }
    
    callback( #"on_localclient_connect", localclientnum );
}

// Namespace callback/callbacks
// Params 1
// Checksum 0x9d70b10a, Offset: 0x2b8
// Size: 0xc4
function playerspawned( localclientnum )
{
    self endon( #"death" );
    util::function_89a98f85();
    
    if ( isdefined( level.infraredvisionset ) )
    {
        function_8608b950( localclientnum, level.infraredvisionset );
    }
    
    if ( self function_21c0fa55() )
    {
        callback( #"on_localplayer_spawned", localclientnum );
    }
    
    callback( #"on_player_spawned", localclientnum );
}

// Namespace callback/callbacks
// Params 1
// Checksum 0x993f3a7d, Offset: 0x388
// Size: 0x2c4
function entityspawned( localclientnum )
{
    self endon( #"death" );
    util::function_89a98f85();
    
    if ( !isdefined( self.type ) )
    {
        println( "<dev string:x68>" );
        return;
    }
    
    if ( isplayer( self ) )
    {
        if ( isdefined( level._clientfaceanimonplayerspawned ) )
        {
            self thread [[ level._clientfaceanimonplayerspawned ]]( localclientnum );
        }
    }
    
    if ( self.type == "missile" )
    {
        if ( isdefined( level._custom_weapon_cb_func ) )
        {
            self thread [[ level._custom_weapon_cb_func ]]( localclientnum );
        }
        
        switch ( self.weapon.name )
        {
            case #"explosive_bolt":
                self thread explosive_bolt::spawned( localclientnum );
                break;
        }
        
        return;
    }
    
    if ( self.type == "vehicle" || self.type == "helicopter" || self.type == "plane" )
    {
        if ( isdefined( level._customvehiclecbfunc ) )
        {
            self thread [[ level._customvehiclecbfunc ]]( localclientnum );
        }
        
        self thread vehicle::field_toggle_exhaustfx_handler( localclientnum, undefined, 0, 1 );
        self thread vehicle::field_toggle_lights_handler( localclientnum, undefined, 0, 1 );
        
        if ( self.vehicleclass == "plane" || self.vehicleclass == "helicopter" )
        {
            self thread vehicle::aircraft_dustkick();
        }
        
        return;
    }
    
    if ( self.type == "actor" )
    {
        self enableonradar();
        
        if ( isdefined( level._customactorcbfunc ) )
        {
            self thread [[ level._customactorcbfunc ]]( localclientnum );
        }
        
        self callback( #"hash_1fc6e31d0d02aa3", localclientnum );
        return;
    }
    
    if ( self.type == "NA" )
    {
        if ( isdefined( self.weapon ) )
        {
            if ( isdefined( level.var_6b11d5f6 ) )
            {
                self thread [[ level.var_6b11d5f6 ]]( localclientnum );
            }
        }
    }
}

// Namespace callback/callbacks
// Params 2
// Checksum 0xc5929eff, Offset: 0x658
// Size: 0x14
function creating_corpse( *localclientnum, *player )
{
    
}

// Namespace callback/callbacks
// Params 7
// Checksum 0x7b8fa674, Offset: 0x678
// Size: 0x96
function callback_stunned( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.stunned = bwastimejump;
    println( "<dev string:x82>" );
    
    if ( bwastimejump )
    {
        self notify( #"stunned" );
        return;
    }
    
    self notify( #"not_stunned" );
}

// Namespace callback/callbacks
// Params 7
// Checksum 0x7955c321, Offset: 0x718
// Size: 0x96
function callback_emp( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.emp = bwastimejump;
    println( "<dev string:x96>" );
    
    if ( bwastimejump )
    {
        self notify( #"emp" );
        return;
    }
    
    self notify( #"not_emp" );
}

// Namespace callback/callbacks
// Params 7
// Checksum 0xb075e2d4, Offset: 0x7b8
// Size: 0x4a
function callback_proximity( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.enemyinproximity = bwastimejump;
}

