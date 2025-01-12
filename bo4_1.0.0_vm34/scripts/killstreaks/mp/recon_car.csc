#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\mp\killstreak_vehicle;

#namespace recon_car;

// Namespace recon_car/recon_car
// Params 0, eflags: 0x2
// Checksum 0xb1194001, Offset: 0xc8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"recon_car", &__init__, undefined, #"killstreaks");
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0x23b5cdb9, Offset: 0x118
// Size: 0xb4
function __init__() {
    killstreak_detect::init_shared();
    bundle = struct::get_script_bundle("killstreak", sessionmodeiswarzonegame() ? "killstreak_recon_car_wz" : "killstreak_recon_car");
    level.var_67c572cc = bundle;
    killstreak_vehicle::init_killstreak(bundle);
    vehicle::add_vehicletype_callback(bundle.ksvehicle, &spawned);
}

// Namespace recon_car/recon_car
// Params 2, eflags: 0x0
// Checksum 0x4ab48364, Offset: 0x1d8
// Size: 0x26
function spawned(localclientnum, killstreak_duration) {
    self.killstreakbundle = level.var_67c572cc;
}

