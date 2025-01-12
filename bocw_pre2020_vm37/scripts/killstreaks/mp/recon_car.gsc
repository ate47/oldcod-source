#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\remote_weapons;

#namespace recon_car;

// Namespace recon_car/recon_car
// Params 0, eflags: 0x6
// Checksum 0x9e1877cb, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register("recon_car", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x5 linked
// Checksum 0xb1ce1c6e, Offset: 0x120
// Size: 0x44
function private function_70a657d8() {
    killstreak_detect::init_shared();
    remote_weapons::init_shared();
    killstreaks::function_b5b6ef3e(&init_killstreak);
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x1 linked
// Checksum 0x41b7d86f, Offset: 0x170
// Size: 0x64
function init_killstreak() {
    bundle = getscriptbundle("killstreak_recon_car");
    killstreak_vehicle::init_killstreak(bundle);
    vehicle::add_main_callback("vehicle_t9_rcxd_racing", &function_d1661ada);
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x1 linked
// Checksum 0x4aed8716, Offset: 0x1e0
// Size: 0x11c
function function_d1661ada() {
    self killstreak_vehicle::init_vehicle();
    self util::make_sentient();
    self.var_7d4f75e = 1;
    self.ignore_death_jolt = 1;
    self.var_92043a49 = 1;
    self disabledriverfiring(1);
    self.var_a6ab9a09 = 1;
    self.var_5ab0177c = 1;
    self.var_68be82d = 1;
    bundle = killstreaks::get_script_bundle("recon_car");
    if (is_true(bundle.var_dad2e3a2)) {
        self.predictedcollisiontime = 0.2;
        self thread function_819fff9d();
    }
    self thread function_f3170551();
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x1 linked
// Checksum 0x714e5f76, Offset: 0x308
// Size: 0xa0
function function_819fff9d() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"veh_predictedcollision");
        if (isplayer(waitresult.target) && util::function_fbce7263(self.team, waitresult.target.team)) {
            self killstreak_vehicle::function_1f46c433();
        }
    }
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x1 linked
// Checksum 0x6bb99079, Offset: 0x3b0
// Size: 0x128
function function_f3170551() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"veh_landed");
        bundle = killstreaks::get_script_bundle("recon_car");
        if (isdefined(bundle.var_b771831a)) {
            a_trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);
            str_fx = self getfxfromsurfacetable(bundle.var_b771831a, a_trace[#"surfacetype"]);
            playfx(str_fx, a_trace[#"position"], (0, 0, 1));
        }
    }
}

