#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\killstreak_vehicle;
#using scripts\killstreaks\remote_weapons;
#using scripts\mp_common\player\player_utils;

#namespace recon_car;

// Namespace recon_car/recon_car
// Params 0, eflags: 0x2
// Checksum 0x8ccb4455, Offset: 0x128
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"recon_car", &__init__, undefined, #"killstreaks");
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0x856c7af1, Offset: 0x178
// Size: 0x44
function __init__() {
    killstreak_detect::init_shared();
    remote_weapons::init_shared();
    killstreaks::function_84669e37(&init_killstreak);
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0x57412d9e, Offset: 0x1c8
// Size: 0xec
function init_killstreak() {
    bundle = struct::get_script_bundle("killstreak", sessionmodeiswarzonegame() ? "killstreak_recon_car_wz" : "killstreak_recon_car");
    killstreak_vehicle::init_killstreak(bundle);
    killstreaks::register_alt_weapon("recon_car", getweapon(#"hash_38ffd09564931482"));
    callback::on_connect(&onplayerconnect);
    vehicle::add_main_callback("vehicle_t8_drone_recon", &function_e5d4d4a7);
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0xed926249, Offset: 0x2c0
// Size: 0x22
function onplayerconnect() {
    self.entnum = self getentitynumber();
}

// Namespace recon_car/recon_car
// Params 0, eflags: 0x0
// Checksum 0x5cfd41ae, Offset: 0x2f0
// Size: 0x74
function function_e5d4d4a7() {
    self killstreak_vehicle::init_vehicle();
    self util::make_sentient();
    self.var_68dfef06 = 1;
    self.ignore_death_jolt = 1;
    self.var_9c931473 = 1;
    self disabledriverfiring(1);
}

