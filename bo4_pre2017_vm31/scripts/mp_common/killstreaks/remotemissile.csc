#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/util;

#namespace remotemissile;

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x2
// Checksum 0x3cf1f407, Offset: 0x210
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "remotemissile", &__init__, undefined, undefined );
}

// Namespace remotemissile/remotemissile
// Params 0
// Checksum 0xfa5b6330, Offset: 0x250
// Size: 0x94
function __init__()
{
    clientfield::register( "missile", "remote_missile_bomblet_fired", 1, 1, "int", &bomblets_deployed, 0, 0 );
    clientfield::register( "missile", "remote_missile_fired", 1, 2, "int", &missile_fired, 0, 0 );
}

// Namespace remotemissile/remotemissile
// Params 7
// Checksum 0x88f61155, Offset: 0x2f0
// Size: 0x2dc
function missile_fired( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        player = getlocalplayer( localclientnum );
        owner = self getowner( localclientnum );
        clientobjid = util::getnextobjid( localclientnum );
        objective_add( localclientnum, clientobjid, "invisible", self.origin, self.team, owner );
        objective_onentity( localclientnum, clientobjid, self, 1, 0, 1 );
        self.hellfireobjid = clientobjid;
        self thread destruction_watcher( localclientnum, clientobjid );
        objective_setstate( localclientnum, clientobjid, "active" );
        
        if ( player hasperk( localclientnum, "specialty_showenemyequipment" ) || self.team == player.team )
        {
            objective_seticon( localclientnum, clientobjid, "remotemissile_target" );
            objective_seticonsize( localclientnum, clientobjid, 50 );
        }
        
        self thread hud_update( localclientnum );
    }
    else if ( newval == 2 )
    {
        if ( isdefined( self.hellfireobjid ) )
        {
            self notify( #"hellfire_detonated" );
            objective_delete( localclientnum, self.hellfireobjid );
            util::releaseobjid( localclientnum, self.hellfireobjid );
        }
    }
    else
    {
        self notify( #"cleanup_objectives" );
    }
    
    ammo_ui_data_model = getuimodel( getuimodelforcontroller( localclientnum ), "vehicle.ammo" );
    
    if ( isdefined( ammo_ui_data_model ) )
    {
        setuimodelvalue( ammo_ui_data_model, 1 );
    }
}

// Namespace remotemissile/remotemissile
// Params 7
// Checksum 0x7847004e, Offset: 0x5d8
// Size: 0x23c
function bomblets_deployed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( bnewent && oldval == newval )
    {
        return;
    }
    
    if ( newval == 1 )
    {
        player = getlocalplayer( localclientnum );
        owner = self getowner( localclientnum );
        clientobjid = util::getnextobjid( localclientnum );
        objective_add( localclientnum, clientobjid, "invisible", self.origin, self.team, owner );
        objective_onentity( localclientnum, clientobjid, self, 1, 0, 1 );
        self thread destruction_watcher( localclientnum, clientobjid );
        objective_setstate( localclientnum, clientobjid, "active" );
        
        if ( player hasperk( localclientnum, "specialty_showenemyequipment" ) || player.team == self.team )
        {
            objective_seticon( localclientnum, clientobjid, "remotemissile_target" );
        }
    }
    else
    {
        self notify( #"cleanup_objectives" );
    }
    
    ammo_ui_data_model = getuimodel( getuimodelforcontroller( localclientnum ), "vehicle.ammo" );
    
    if ( isdefined( ammo_ui_data_model ) )
    {
        setuimodelvalue( ammo_ui_data_model, 0 );
    }
}

// Namespace remotemissile/remotemissile
// Params 2
// Checksum 0x38ae13fb, Offset: 0x820
// Size: 0x74
function destruction_watcher( localclientnum, clientobjid )
{
    self waittill( "death", "cleanup_objectives" );
    wait 0.1;
    
    if ( isdefined( clientobjid ) )
    {
        objective_delete( localclientnum, clientobjid );
        util::releaseobjid( localclientnum, clientobjid );
    }
}

// Namespace remotemissile/remotemissile
// Params 1
// Checksum 0xec261e0, Offset: 0x8a0
// Size: 0x1d8
function hud_update( localclientnum )
{
    self endon( #"death" );
    self notify( #"remote_missile_singeton" );
    self endon( #"remote_missile_singeton" );
    missile = self;
    altitude_ui_data_model = getuimodel( getuimodelforcontroller( localclientnum ), "vehicle.altitude" );
    speed_ui_data_model = getuimodel( getuimodelforcontroller( localclientnum ), "vehicle.speed" );
    
    if ( !isdefined( altitude_ui_data_model ) || !isdefined( speed_ui_data_model ) )
    {
        return;
    }
    
    prev_z = missile.origin[ 2 ];
    fps = 20;
    delay = 1 / fps;
    
    while ( true )
    {
        cur_z = missile.origin[ 2 ];
        setuimodelvalue( altitude_ui_data_model, cur_z );
        dist = ( prev_z - cur_z ) * fps;
        val = dist / 17.6;
        setuimodelvalue( speed_ui_data_model, val );
        prev_z = cur_z;
        wait delay;
    }
}

