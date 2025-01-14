#namespace ai_state;

// Namespace ai_state/state
// Params 8, eflags: 0x0
// Checksum 0x8a1cdf98, Offset: 0x60
// Size: 0xd4
function function_e9b061a8(state, start, update_goal, end, update_enemy, var_edc20efd, var_ff716a93, update_debug) {
    level.extra_screen_electricity_.functions[state] = {#start:start, #update_goal:update_goal, #end:end, #update_enemy:update_enemy, #var_edc20efd:var_edc20efd, #var_ff716a93:var_ff716a93, #update_debug:update_debug};
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0xae20f6dc, Offset: 0x140
// Size: 0x78
function callback_start() {
    if (isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].start)) {
        self thread [[ level.extra_screen_electricity_.functions[self.ai.state].start ]]();
    }
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0x7ad2467f, Offset: 0x1c0
// Size: 0x78
function callback_end() {
    if (isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].end)) {
        self thread [[ level.extra_screen_electricity_.functions[self.ai.state].end ]]();
    }
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0xc7a28a6d, Offset: 0x240
// Size: 0x78
function function_e8e7cf45() {
    if (isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].update_goal)) {
        self [[ level.extra_screen_electricity_.functions[self.ai.state].update_goal ]]();
    }
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0x8079f63d, Offset: 0x2c0
// Size: 0x78
function function_e0e1a7fc() {
    if (isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].update_enemy)) {
        self [[ level.extra_screen_electricity_.functions[self.ai.state].update_enemy ]]();
    }
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0x4aa15ad0, Offset: 0x340
// Size: 0x7a
function function_4af1ff64() {
    if (isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].var_edc20efd)) {
        return self [[ level.extra_screen_electricity_.functions[self.ai.state].var_edc20efd ]]();
    }
    return 0;
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0x556af11, Offset: 0x3c8
// Size: 0x7a
function function_a78474f2() {
    if (isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].var_ff716a93)) {
        return self [[ level.extra_screen_electricity_.functions[self.ai.state].var_ff716a93 ]]();
    }
    return undefined;
}

// Namespace ai_state/state
// Params 1, eflags: 0x0
// Checksum 0xe03e260a, Offset: 0x450
// Size: 0xe4
function set_state(state) {
    if (!isdefined(self.ai)) {
        self.ai = {#state:undefined};
    }
    if (!isdefined(self.ai.state) || self.ai.state != state) {
        if (isdefined(self.ai.state)) {
            callback_end();
        }
        self.ai.state = state;
        callback_start();
        self notify(#"state_changed", state);
        /#
            self thread function_3a57bb58();
        #/
    }
}

// Namespace ai_state/state
// Params 1, eflags: 0x0
// Checksum 0x702b5183, Offset: 0x540
// Size: 0x20
function is_state(state) {
    return self.ai.state === state;
}

/#

    // Namespace ai_state/state
    // Params 0, eflags: 0x0
    // Checksum 0xa371d343, Offset: 0x568
    // Size: 0x64
    function function_c1d2ede8() {
        if (isdefined(level.extra_screen_electricity_.functions[self.ai.state].update_debug)) {
            self [[ level.extra_screen_electricity_.functions[self.ai.state].update_debug ]]();
        }
    }

    // Namespace ai_state/state
    // Params 0, eflags: 0x0
    // Checksum 0xd515cc7b, Offset: 0x5d8
    // Size: 0x5e
    function function_3a57bb58() {
        self notify("<dev string:x38>");
        self endon("<dev string:x38>");
        self endon(#"death");
        while (true) {
            self function_c1d2ede8();
            waitframe(1);
        }
    }

#/
