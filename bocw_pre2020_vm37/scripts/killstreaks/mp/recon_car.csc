#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;

#namespace recon_car;

// Namespace recon_car/recon_car
// Params 0, eflags: 0x6
// Checksum 0x189461fa, Offset: 0xa0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"recon_car", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x5 linked
// Checksum 0x379fe279, Offset: 0xf0
// Size: 0x84
function private function_70a657d8() {
    killstreak_detect::init_shared();
    bundle = getscriptbundle("killstreak_recon_car");
    level.var_af161ca6 = bundle;
    killstreak_vehicle::init_killstreak(bundle);
    vehicle::add_vehicletype_callback(bundle.ksvehicle, &spawned);
}

// Namespace recon_car/recon_car
// Params 2, eflags: 0x1 linked
// Checksum 0x26099e1f, Offset: 0x180
// Size: 0x26
function spawned(*localclientnum, *killstreak_duration) {
    self.killstreakbundle = level.var_af161ca6;
}

