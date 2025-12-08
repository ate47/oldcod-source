#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/mp_common/util;
#using scripts/mp_common/vehicle;

#namespace ai_tank;

// Namespace ai_tank/ai_tank
// Params 0, eflags: 0x2
// Checksum 0xadd664cd, Offset: 0x3e0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "ai_tank", &__init__, undefined, undefined );
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x44a4586a, Offset: 0x420
// Size: 0x26c
function __init__()
{
    bundle = struct::get_script_bundle( "killstreak", "killstreak_ai_tank_drop" );
    level.aitankkillstreakbundle = bundle;
    level._ai_tank_fx = [];
    level._ai_tank_fx[ "light_green" ] = "killstreaks/fx_agr_vlight_eye_grn";
    level._ai_tank_fx[ "light_red" ] = "killstreaks/fx_agr_vlight_eye_red";
    level._ai_tank_fx[ "stun" ] = "killstreaks/fx_agr_emp_stun";
    clientfield::register( "vehicle", "ai_tank_death", 1, 1, "int", &death, 0, 0 );
    clientfield::register( "vehicle", "ai_tank_missile_fire", 1, 2, "int", &missile_fire, 0, 0 );
    clientfield::register( "vehicle", "ai_tank_stun", 1, 1, "int", &tank_stun, 0, 0 );
    clientfield::register( "toplayer", "ai_tank_update_hud", 1, 1, "counter", &update_hud, 0, 0 );
    vehicle::add_vehicletype_callback( "ai_tank_drone_mp", &spawned );
    vehicle::add_vehicletype_callback( "spawner_bo3_ai_tank_mp", &spawned );
    vehicle::add_vehicletype_callback( "spawner_bo3_ai_tank_mp_player", &spawned );
    visionset_mgr::register_visionset_info( "agr_visionset", 1, 16, undefined, "mp_vehicles_agr" );
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0xa4b8a284, Offset: 0x698
// Size: 0x40
function spawned( localclientnum, killstreak_duration )
{
    self thread play_driving_rumble( localclientnum );
    self.killstreakbundle = level.aitankkillstreakbundle;
}

#using_animtree( "mp_vehicles" );

// Namespace ai_tank/ai_tank
// Params 7
// Checksum 0x76583b3f, Offset: 0x6e0
// Size: 0x1f4
function missile_fire( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"death" );
    self util::waittill_dobj( localclientnum );
    
    if ( self hasanimtree() == 0 )
    {
        self useanimtree( #animtree );
    }
    
    missiles_loaded = newval;
    
    if ( newval == 2 )
    {
        self setanimrestart( %o_drone_tank_missile1_fire, 1, 0, 0.5 );
    }
    else if ( newval == 1 )
    {
        self setanimrestart( %o_drone_tank_missile2_fire, 1, 0, 0.5 );
    }
    else if ( newval == 0 )
    {
        self setanimrestart( %o_drone_tank_missile3_fire, 1, 0, 0.5 );
    }
    else if ( newval == 3 )
    {
        self setanimrestart( %o_drone_tank_missile_full_reload, 1, 0, 1 );
    }
    
    if ( missiles_loaded <= 3 )
    {
        update_ui_ammo_count( localclientnum, missiles_loaded );
    }
}

// Namespace ai_tank/ai_tank
// Params 7
// Checksum 0x53a78e47, Offset: 0x8e0
// Size: 0xb4
function update_hud( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"disconnect" );
    waitframe( 1 );
    vehicle = getplayervehicle( self );
    
    if ( isdefined( vehicle ) )
    {
        self update_ui_model_ammo_count( localclientnum, vehicle clientfield::get( "ai_tank_missile_fire" ) );
    }
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0x5fba5d55, Offset: 0x9a0
// Size: 0x64
function update_ui_ammo_count( localclientnum, missiles_loaded )
{
    if ( self islocalclientdriver( localclientnum ) || isspectating( localclientnum ) )
    {
        update_ui_model_ammo_count( localclientnum, missiles_loaded );
    }
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0x3a3070e1, Offset: 0xa10
// Size: 0x74
function update_ui_model_ammo_count( localclientnum, missiles_loaded )
{
    ammo_ui_data_model = getuimodel( getuimodelforcontroller( localclientnum ), "vehicle.ammo" );
    
    if ( isdefined( ammo_ui_data_model ) )
    {
        setuimodelvalue( ammo_ui_data_model, missiles_loaded );
    }
}

// Namespace ai_tank/ai_tank
// Params 7
// Checksum 0xd6bade62, Offset: 0xa90
// Size: 0xac
function tank_stun( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"death" );
    
    if ( newval )
    {
        self notify( #"light_disable" );
        self stop_stun_fx( localclientnum );
        self start_stun_fx( localclientnum );
        return;
    }
    
    self stop_stun_fx( localclientnum );
}

// Namespace ai_tank/ai_tank
// Params 7
// Checksum 0x25058dde, Offset: 0xb48
// Size: 0xba
function death( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( player getinkillcam( localclientnum ) )
    {
        return;
    }
    
    if ( newval )
    {
        self stop_stun_fx( localclientnum );
        self notify( #"light_disable" );
    }
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xa5dc5cd4, Offset: 0xc10
// Size: 0x74
function start_stun_fx( localclientnum )
{
    self.stun_fx = playfxontag( localclientnum, level._ai_tank_fx[ "stun" ], self, "tag_origin" );
    playsound( localclientnum, "veh_talon_shutdown", self.origin );
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xbe5605eb, Offset: 0xc90
// Size: 0x46
function stop_stun_fx( localclientnum )
{
    if ( isdefined( self.stun_fx ) )
    {
        stopfx( localclientnum, self.stun_fx );
        self.stun_fx = undefined;
    }
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xbe893759, Offset: 0xce0
// Size: 0x110
function play_driving_rumble( localclientnum )
{
    self notify( #"driving_rumble" );
    self endon( #"death" );
    self endon( #"driving_rumble" );
    
    for ( ;; )
    {
        if ( isinvehicle( localclientnum, self ) )
        {
            speed = self getspeed();
            
            if ( speed >= 40 || speed <= -40 )
            {
                player = getlocalplayer( localclientnum );
                
                if ( isdefined( player ) )
                {
                    player earthquake( 0.1, 0.1, self.origin, 200 );
                }
            }
        }
        
        util::server_wait( localclientnum, 0.05 );
    }
}

