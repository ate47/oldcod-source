#using script_40fc784c60f9fa7b;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_49fc7b6a;

// Namespace namespace_49fc7b6a/namespace_49fc7b6a
// Params 0, eflags: 0x6
// Checksum 0x2cdeb5a7, Offset: 0xa8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_2b57f9acbfaf5ccd", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace namespace_49fc7b6a/namespace_49fc7b6a
// Params 0, eflags: 0x5 linked
// Checksum 0xa4bbba85, Offset: 0xf8
// Size: 0x2c
function private function_70a657d8() {
    vehicle::add_main_callback("helicopter_light", &function_87c26647);
}

// Namespace namespace_49fc7b6a/namespace_49fc7b6a
// Params 0, eflags: 0x5 linked
// Checksum 0xc6f9f8d0, Offset: 0x130
// Size: 0x9a
function private function_87c26647() {
    if (!isdefined(self) || function_3132f113(self)) {
        return;
    }
    self player_vehicle::function_bc79899e();
    self vehicle_ai::get_state_callbacks("off").enter_func = &function_aa6eca0a;
    self vehicle_ai::get_state_callbacks("off").exit_func = &function_cead8760;
}

// Namespace namespace_49fc7b6a/namespace_49fc7b6a
// Params 1, eflags: 0x5 linked
// Checksum 0x7a958656, Offset: 0x1d8
// Size: 0x1cc
function private function_aa6eca0a(params) {
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self sethoverparams(0);
    self setgoal(self.origin, 1, 0);
    self setrotorspeed(0);
    if (is_true(params.makeunusable) || is_true(self.var_1ba362d5)) {
        self player_vehicle::function_8cf138bb();
    }
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self vehicle::function_bbc1d940(0);
    self disableaimassist();
    vehicle_ai::turnoffallambientanims();
    vehicle_ai::clearalllookingandtargeting();
    vehicle_ai::clearallmovement();
    if (!is_true(params.isinitialstate)) {
        self vehicle::function_7f0bbde3();
    }
}

// Namespace namespace_49fc7b6a/namespace_49fc7b6a
// Params 1, eflags: 0x5 linked
// Checksum 0xa5036568, Offset: 0x3b0
// Size: 0x15c
function private function_cead8760(params) {
    params.var_32a85fa1 = 2;
    params.var_1751c737 = 1;
    params.var_da88902a = 1;
    params.var_30a04b16 = 1;
    self vehicle::toggle_tread_fx(1);
    self vehicle::toggle_exhaust_fx(1);
    self thread vehicle::function_fa4236af(params);
    self enableaimassist();
    self setphysacceleration((0, 0, 0));
    self thread vehicle_ai::nudge_collision();
    self setrotorspeed(1);
    if (isdefined(level.enable_thermal)) {
        if (self vehicle_ai::get_next_state() !== "death") {
            [[ level.enable_thermal ]]();
        }
    }
    if (!is_true(self.nolights)) {
        self vehicle::lights_on();
    }
}

