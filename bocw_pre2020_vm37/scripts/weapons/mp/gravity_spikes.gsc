#using scripts\abilities\ability_player;
#using scripts\core_common\battlechatter;
#using scripts\core_common\system_shared;
#using scripts\weapons\gravity_spikes;

#namespace gravity_spikes;

// Namespace gravity_spikes/gravity_spikes
// Params 0, eflags: 0x6
// Checksum 0xd989acda, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gravity_spikes", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace gravity_spikes/gravity_spikes
// Params 0, eflags: 0x4
// Checksum 0xbb944a8f, Offset: 0xf8
// Size: 0x34
function private function_70a657d8() {
    init_shared();
    ability_player::register_gadget_activation_callbacks(7, &function_20bb376d, undefined);
}

// Namespace gravity_spikes/gravity_spikes
// Params 2, eflags: 0x0
// Checksum 0x4c5e78c5, Offset: 0x138
// Size: 0xe2
function function_20bb376d(*var_3245778e, weapon) {
    self battlechatter::function_bd715920(weapon, undefined, self geteye(), self);
    playfx("weapon/fx8_hero_grvity_slam_takeoff_3p", self.origin);
    if (isdefined(self.var_ea1458aa)) {
        self.var_ea1458aa.var_6799f1da = 0;
        if (!self isonground() && isdefined(self.var_700a5910) && isdefined(self.challenge_jump_begin) && self.var_700a5910 > self.challenge_jump_begin) {
            self.var_ea1458aa.var_6799f1da = 1;
        }
    }
}

