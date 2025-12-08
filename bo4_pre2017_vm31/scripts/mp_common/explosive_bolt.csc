#using scripts/core_common/callbacks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/util;

#namespace explosive_bolt;

// Namespace explosive_bolt/explosive_bolt
// Params 0, eflags: 0x2
// Checksum 0xfbe6032d, Offset: 0x1c0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "explosive_bolt", &__init__, undefined, undefined );
}

// Namespace explosive_bolt/explosive_bolt
// Params 0
// Checksum 0x66cf4504, Offset: 0x200
// Size: 0x4c
function __init__()
{
    level._effect[ "crossbow_light" ] = "weapon/fx_equip_light_os";
    callback::add_weapon_type( "explosive_bolt", &spawned );
}

// Namespace explosive_bolt/explosive_bolt
// Params 1
// Checksum 0xa962ab45, Offset: 0x258
// Size: 0x44
function spawned( localclientnum )
{
    if ( self isgrenadedud() )
    {
        return;
    }
    
    self thread fx_think( localclientnum );
}

// Namespace explosive_bolt/explosive_bolt
// Params 1
// Checksum 0xc8606bb7, Offset: 0x2a8
// Size: 0x12c
function fx_think( localclientnum )
{
    self notify( #"light_disable" );
    self endon( #"death" );
    self endon( #"light_disable" );
    self util::waittill_dobj( localclientnum );
    
    for ( interval = 0.3;  ; interval = math::clamp( interval / 1.2, 0.08, 0.3 ) )
    {
        self stop_light_fx( localclientnum );
        self start_light_fx( localclientnum );
        self fullscreen_fx( localclientnum );
        self playsound( localclientnum, "wpn_semtex_alert" );
        util::server_wait( localclientnum, interval, 0.016, "player_switch" );
    }
}

// Namespace explosive_bolt/explosive_bolt
// Params 1
// Checksum 0x932fa93d, Offset: 0x3e0
// Size: 0x6c
function start_light_fx( localclientnum )
{
    player = getlocalplayer( localclientnum );
    self.fx = playfxontag( localclientnum, level._effect[ "crossbow_light" ], self, "tag_origin" );
}

// Namespace explosive_bolt/explosive_bolt
// Params 1
// Checksum 0x44ef4e99, Offset: 0x458
// Size: 0x56
function stop_light_fx( localclientnum )
{
    if ( isdefined( self.fx ) && self.fx != 0 )
    {
        stopfx( localclientnum, self.fx );
        self.fx = undefined;
    }
}

// Namespace explosive_bolt/explosive_bolt
// Params 1
// Checksum 0xdd698108, Offset: 0x4b8
// Size: 0xf4
function fullscreen_fx( localclientnum )
{
    player = getlocalplayer( localclientnum );
    
    if ( isdefined( player ) )
    {
        if ( player getinkillcam( localclientnum ) )
        {
            return;
        }
        else if ( player util::is_player_view_linked_to_entity( localclientnum ) )
        {
            return;
        }
    }
    
    if ( self util::friend_not_foe( localclientnum ) )
    {
        return;
    }
    
    parent = self getparententity();
    
    if ( isdefined( parent ) && parent == player )
    {
        parent playrumbleonentity( localclientnum, "buzz_high" );
    }
}

