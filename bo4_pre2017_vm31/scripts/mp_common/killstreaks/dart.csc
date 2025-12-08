#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace dart;

// Namespace dart/dart
// Params 0, eflags: 0x2
// Checksum 0xf9c07b84, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "dart", &__init__, undefined, undefined );
}

// Namespace dart/dart
// Params 0
// Checksum 0x17c635e9, Offset: 0x270
// Size: 0x16c
function __init__()
{
    clientfield::register( "toplayer", "dart_update_ammo", 1, 2, "int", &update_ammo, 0, 0 );
    clientfield::register( "toplayer", "fog_bank_3", 1, 1, "int", &fog_bank_3_callback, 0, 0 );
    level.dartbundle = struct::get_script_bundle( "killstreak", "killstreak_dart" );
    vehicle::add_vehicletype_callback( level.dartbundle.ksdartvehicle, &spawned );
    visionset_mgr::register_visionset_info( "dart_visionset", 1, 1, undefined, "mp_vehicles_dart" );
    visionset_mgr::register_visionset_info( "sentinel_visionset", 1, 1, undefined, "mp_vehicles_sentinel" );
    visionset_mgr::register_visionset_info( "remote_missile_visionset", 1, 1, undefined, "mp_hellstorm" );
}

// Namespace dart/dart
// Params 7
// Checksum 0xd01076bf, Offset: 0x3e8
// Size: 0x84
function update_ammo( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    setuimodelvalue( getuimodel( getuimodelforcontroller( localclientnum ), "vehicle.ammo" ), newval );
}

// Namespace dart/dart
// Params 1
// Checksum 0x873f8f2b, Offset: 0x478
// Size: 0x20
function spawned( localclientnum )
{
    self.killstreakbundle = level.dartbundle;
}

// Namespace dart/dart
// Params 7
// Checksum 0xa469555d, Offset: 0x4a0
// Size: 0x94
function fog_bank_3_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            setworldfogactivebank( localclientnum, 4 );
            return;
        }
        
        setworldfogactivebank( localclientnum, 1 );
    }
}

