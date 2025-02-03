#using script_18b9d0e77614c97;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;

#namespace recon_car;

// Namespace recon_car/recon_car
// Params 0, eflags: 0x6
// Checksum 0x5a16d083, Offset: 0xa0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"recon_car", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x4
// Checksum 0x292ab4ce, Offset: 0xf0
// Size: 0xc4
function private preinit() {
    killstreak_detect::init_shared();
    bundle = getscriptbundle("killstreak_recon_car");
    level.var_af161ca6 = bundle;
    killstreak_vehicle::init_killstreak(bundle);
    vehicle::add_vehicletype_callback(bundle.ksvehicle, &spawned);
    self streamer::function_d46dcfc2(#"hash_60e8ba6fb4cba9f8", 1, &function_3665db4d, &function_b8d95025);
}

// Namespace recon_car/recon_car
// Params 1, eflags: 0x0
// Checksum 0xbf84a04d, Offset: 0x1c0
// Size: 0x3c
function spawned(*localclientnum) {
    self.killstreakbundle = level.var_af161ca6;
    self streamer::force_stream(#"hash_60e8ba6fb4cba9f8");
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x4
// Checksum 0x231a345e, Offset: 0x208
// Size: 0x2c
function private function_3665db4d() {
    function_334b8df9(level.var_af161ca6.var_1c30ba81, -1);
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x4
// Checksum 0x959504c6, Offset: 0x240
// Size: 0x24
function private function_b8d95025() {
    function_58250a30(level.var_af161ca6.var_1c30ba81);
}

