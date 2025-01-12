#namespace ai_state;

// Namespace ai_state/state
// Params 8, eflags: 0x0
// Checksum 0xca57a04b, Offset: 0x68
// Size: 0xd6
function function_7014801d(state, start, update_goal, end, update_enemy, var_38aa2f7a, attack_origin, update_debug) {
    level.var_32742545.functions[state] = {#start:start, #update_goal:update_goal, #end:end, #update_enemy:update_enemy, #var_38aa2f7a:var_38aa2f7a, #attack_origin:attack_origin, #update_debug:update_debug};
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0x8e5c6085, Offset: 0x148
// Size: 0x78
function callback_start() {
    if (isdefined(self.ai.state) && isdefined(level.var_32742545.functions[self.ai.state].start)) {
        self thread [[ level.var_32742545.functions[self.ai.state].start ]]();
    }
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0xafeb7f2, Offset: 0x1c8
// Size: 0x78
function callback_end() {
    if (isdefined(self.ai.state) && isdefined(level.var_32742545.functions[self.ai.state].end)) {
        self thread [[ level.var_32742545.functions[self.ai.state].end ]]();
    }
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0x72478bbf, Offset: 0x248
// Size: 0x78
function function_6ea20b5e() {
    if (isdefined(self.ai.state) && isdefined(level.var_32742545.functions[self.ai.state].update_goal)) {
        self [[ level.var_32742545.functions[self.ai.state].update_goal ]]();
    }
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0xe89d8477, Offset: 0x2c8
// Size: 0x78
function function_e7060dfd() {
    if (isdefined(self.ai.state) && isdefined(level.var_32742545.functions[self.ai.state].update_enemy)) {
        self [[ level.var_32742545.functions[self.ai.state].update_enemy ]]();
    }
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0x610d6352, Offset: 0x348
// Size: 0x7a
function function_c1aee63() {
    if (isdefined(self.ai.state) && isdefined(level.var_32742545.functions[self.ai.state].var_38aa2f7a)) {
        return self [[ level.var_32742545.functions[self.ai.state].var_38aa2f7a ]]();
    }
    return 0;
}

// Namespace ai_state/state
// Params 0, eflags: 0x0
// Checksum 0xc46fcb9e, Offset: 0x3d0
// Size: 0x7a
function function_7c8eb77() {
    if (isdefined(self.ai.state) && isdefined(level.var_32742545.functions[self.ai.state].attack_origin)) {
        return self [[ level.var_32742545.functions[self.ai.state].attack_origin ]]();
    }
    return undefined;
}

// Namespace ai_state/state
// Params 1, eflags: 0x0
// Checksum 0xbe020a4d, Offset: 0x458
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
            self thread function_10c82215();
        #/
    }
}

// Namespace ai_state/state
// Params 1, eflags: 0x0
// Checksum 0x5cac6da7, Offset: 0x548
// Size: 0x20
function is_state(state) {
    return self.ai.state == state;
}

/#

    // Namespace ai_state/state
    // Params 0, eflags: 0x0
    // Checksum 0xeee141fe, Offset: 0x570
    // Size: 0x64
    function function_ec07834() {
        if (isdefined(level.var_32742545.functions[self.ai.state].update_debug)) {
            self [[ level.var_32742545.functions[self.ai.state].update_debug ]]();
        }
    }

    // Namespace ai_state/state
    // Params 0, eflags: 0x0
    // Checksum 0x74a2c191, Offset: 0x5e0
    // Size: 0x5e
    function function_10c82215() {
        self notify("<invalid>");
        self endon("<invalid>");
        self endon(#"death");
        while (true) {
            self function_ec07834();
            waitframe(1);
        }
    }

#/
