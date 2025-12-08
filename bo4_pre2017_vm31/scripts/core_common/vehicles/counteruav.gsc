#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0, eflags: 0x2
// Checksum 0x353608c1, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "counteruav", &__init__, undefined, undefined );
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xb8de1b59, Offset: 0x278
// Size: 0x2c
function __init__()
{
    vehicle::add_main_callback( "counteruav", &function_3c868cce );
}

#using_animtree( "generic" );

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xdc94c529, Offset: 0x2b0
// Size: 0x190
function function_3c868cce()
{
    self useanimtree( #animtree );
    target_set( self, ( 0, 0, 0 ) );
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self setvehicleavoidance( 1 );
    self sethoverparams( 50, 100, 100 );
    self.vehaircraftcollisionenabled = 1;
    assert( isdefined( self.scriptbundlesettings ) );
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    self.goalradius = 999999;
    self.goalheight = 999999;
    self setgoal( self.origin, 0, self.goalradius, self.goalheight );
    self.overridevehicledamage = &drone_callback_damage;
    
    if ( isdefined( level.vehicle_initializer_cb ) )
    {
        [[ level.vehicle_initializer_cb ]]( self );
    }
}

// Namespace counteruav/counteruav
// Params 15
// Checksum 0xebd26319, Offset: 0x448
// Size: 0xd4
function drone_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    idamage = vehicle_ai::shared_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal );
    return idamage;
}

