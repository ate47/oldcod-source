#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_mod_quick_revive;

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x2
// Checksum 0xd615c504, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_quick_revive", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x4bab23e9, Offset: 0x100
// Size: 0x14
function __init__() {
    enable_quick_revive_perk_for_level();
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0xb1de3ab, Offset: 0x120
// Size: 0xa4
function enable_quick_revive_perk_for_level() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_quickrevive", "mod_revive", #"specialty_quickrevive", 2500);
    zm_perks::register_perk_threads(#"specialty_mod_quickrevive", &give_perk, &take_perk);
    callback::on_revived(&on_revived);
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0xba21db8d, Offset: 0x1d0
// Size: 0x1c
function give_perk() {
    self thread monitor_health_regen();
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 3, eflags: 0x0
// Checksum 0xacc5e9f6, Offset: 0x1f8
// Size: 0x6c
function take_perk(b_pause, str_perk, str_result) {
    self notify(#"hash_478eed143ecc82fc");
    if (self hasperk(#"specialty_sprintspeed")) {
        self perks::perk_unsetperk(#"specialty_sprintspeed");
    }
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 1, eflags: 0x0
// Checksum 0x9104b477, Offset: 0x270
// Size: 0xc4
function on_revived(s_params) {
    if (isplayer(s_params.e_reviver) && s_params.e_reviver hasperk(#"specialty_mod_quickrevive")) {
        s_params.e_reviver zm_utility::set_max_health();
        s_params.e_reviver thread function_f02f8d15();
    } else {
        return;
    }
    if (isplayer(s_params.e_revivee)) {
        s_params.e_revivee thread function_f02f8d15();
    }
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0xc6a1df87, Offset: 0x340
// Size: 0x58
function monitor_health_regen() {
    self endon(#"hash_478eed143ecc82fc", #"disconnect");
    while (true) {
        self waittill(#"snd_breathing_better");
        self thread function_f02f8d15();
    }
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x2b5237b5, Offset: 0x3a0
// Size: 0xd4
function function_f02f8d15() {
    self notify("12acdb15fa9cce47");
    self endon("12acdb15fa9cce47");
    self endon(#"hash_478eed143ecc82fc", #"disconnect");
    if (!self hasperk(#"specialty_sprintspeed")) {
        self perks::perk_setperk(#"specialty_sprintspeed");
    }
    wait 3;
    if (self hasperk(#"specialty_sprintspeed")) {
        self perks::perk_unsetperk(#"specialty_sprintspeed");
    }
}

