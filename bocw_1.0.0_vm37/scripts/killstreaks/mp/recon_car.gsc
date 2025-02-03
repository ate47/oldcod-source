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
// Checksum 0x36ad79a4, Offset: 0x100
// Size: 0x3c
function private autoexec __init__system__() {
    system::register("recon_car", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x4
// Checksum 0x4c8c1c4f, Offset: 0x148
// Size: 0x44
function private preinit() {
    killstreak_detect::init_shared();
    remote_weapons::init_shared();
    killstreaks::function_b5b6ef3e(&init_killstreak);
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0x3235e15, Offset: 0x198
// Size: 0x94
function init_killstreak() {
    if (sessionmodeiswarzonegame()) {
        bundle = getscriptbundle("killstreak_recon_car_wz");
    } else {
        bundle = getscriptbundle("killstreak_recon_car");
    }
    killstreak_vehicle::init_killstreak(bundle);
    vehicle::add_main_callback("vehicle_t9_rcxd_racing", &function_d1661ada);
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0x52479ef8, Offset: 0x238
// Size: 0x144
function function_d1661ada() {
    self killstreak_vehicle::init_vehicle();
    self util::make_sentient();
    self.var_7d4f75e = 1;
    self.ignore_death_jolt = 1;
    self.var_92043a49 = 1;
    self.var_20c65a3e = 0;
    self disabledriverfiring(1);
    self.var_a6ab9a09 = 1;
    self.var_5ab0177c = 1;
    self.var_68be82d = 1;
    bundle = killstreaks::get_script_bundle("recon_car");
    if (is_true(bundle.var_dad2e3a2)) {
        self.predictedcollisiontime = 0.1;
        self thread function_819fff9d();
    }
    if (isdefined(bundle.var_1c30ba81)) {
        self.var_a0f50ca8 = &function_2087b17f;
    }
    self thread function_f3170551();
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0x852110ba, Offset: 0x388
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
// Params 0, eflags: 0x0
// Checksum 0x7957827c, Offset: 0x430
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

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0xf90b376, Offset: 0x560
// Size: 0x134
function function_2087b17f() {
    bundle = killstreaks::get_script_bundle("recon_car");
    trace = groundtrace(self.origin + (0, 0, 70), self.origin + (0, 0, -100), 0, self);
    explosionfx = self getfxfromsurfacetable(bundle.var_1c30ba81, trace[#"surfacetype"]);
    if (isdefined(explosionfx)) {
        fxorigin = self gettagorigin("tag_body");
        if (!isdefined(fxorigin)) {
            fxorigin = self.origin;
        }
        playfx(explosionfx, fxorigin, (0, 0, 1));
    }
    playsoundatposition(#"hash_2d5cdc03d392d5ec", self.origin);
}

