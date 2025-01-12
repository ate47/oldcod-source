#using scripts\abilities\ability_player;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\weapons\gravity_spikes;

#namespace gravity_spikes;

// Namespace gravity_spikes/gravity_spikes
// Params 0, eflags: 0x2
// Checksum 0x95a19711, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gravity_spikes", &__init__, undefined, undefined);
}

// Namespace gravity_spikes/gravity_spikes
// Params 0, eflags: 0x0
// Checksum 0xc72d1c4b, Offset: 0xf8
// Size: 0x34
function __init__() {
    init_shared();
    ability_player::register_gadget_activation_callbacks(7, &function_2b5233a4, undefined);
}

// Namespace gravity_spikes/gravity_spikes
// Params 2, eflags: 0x0
// Checksum 0xc1366d6, Offset: 0x138
// Size: 0x64
function function_2b5233a4(abilityslot, weapon) {
    self battlechatter::function_b505bc94(weapon, undefined, self geteye(), self);
    playfx("weapon/fx8_hero_grvity_slam_takeoff_3p", self.origin);
}

