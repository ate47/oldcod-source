#using scripts/core_common/array_shared;

#namespace statemachine;

// Namespace statemachine/statemachine_shared
// Params 3, eflags: 0x0
// Checksum 0xc833bdfd, Offset: 0xd0
// Size: 0x142
function create(name, owner, change_notify) {
    if (!isdefined(change_notify)) {
        change_notify = "change_state";
    }
    state_machine = spawnstruct();
    state_machine.name = name;
    state_machine.states = [];
    state_machine.previous_state = undefined;
    state_machine.current_state = undefined;
    state_machine.next_state = undefined;
    state_machine.change_note = change_notify;
    if (isdefined(owner)) {
        state_machine.owner = owner;
    } else {
        state_machine.owner = level;
    }
    if (!isdefined(state_machine.owner.state_machines)) {
        state_machine.owner.state_machines = [];
    }
    state_machine.owner.state_machines[state_machine.name] = state_machine;
    return state_machine;
}

// Namespace statemachine/statemachine_shared
// Params 0, eflags: 0x0
// Checksum 0xfa923312, Offset: 0x220
// Size: 0xee
function clear() {
    if (isdefined(self.states) && isarray(self.states)) {
        foreach (state in self.states) {
            state.connections_notify = undefined;
            state.connections_utility = undefined;
        }
    }
    self.states = undefined;
    self.previous_state = undefined;
    self.current_state = undefined;
    self.next_state = undefined;
    self.owner = undefined;
    self notify(#"_cancel_connections");
}

// Namespace statemachine/statemachine_shared
// Params 5, eflags: 0x0
// Checksum 0xd5079a18, Offset: 0x318
// Size: 0x164
function add_state(name, enter_func, update_func, exit_func, reenter_func) {
    if (!isdefined(self.states[name])) {
        self.states[name] = spawnstruct();
    }
    self.states[name].name = name;
    self.states[name].enter_func = enter_func;
    self.states[name].exit_func = exit_func;
    self.states[name].update_func = update_func;
    self.states[name].reenter_func = reenter_func;
    self.states[name].connections_notify = [];
    self.states[name].connections_utility = [];
    self.states[name].owner = self;
    return self.states[name];
}

// Namespace statemachine/statemachine_shared
// Params 1, eflags: 0x0
// Checksum 0x71ed285f, Offset: 0x488
// Size: 0x1c
function get_state(name) {
    return self.states[name];
}

// Namespace statemachine/statemachine_shared
// Params 4, eflags: 0x0
// Checksum 0xe5cbbcd4, Offset: 0x4b0
// Size: 0x110
function add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc) {
    from_state = get_state(from_state_name);
    to_state = get_state(to_state_name);
    connection = spawnstruct();
    connection.to_state = to_state;
    connection.type = 0;
    connection.on_notify = on_notify;
    connection.checkfunc = checkfunc;
    from_state.connections_notify[on_notify] = connection;
    return from_state.connections_notify[from_state.connections_notify.size - 1];
}

// Namespace statemachine/statemachine_shared
// Params 4, eflags: 0x0
// Checksum 0xf3d3e8e7, Offset: 0x5c8
// Size: 0x1b8
function add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore) {
    from_state = get_state(from_state_name);
    to_state = get_state(to_state_name);
    connection = spawnstruct();
    connection.to_state = to_state;
    connection.type = 1;
    connection.checkfunc = checkfunc;
    connection.score = defaultscore;
    if (!isdefined(connection.score)) {
        connection.score = 100;
    }
    if (!isdefined(from_state.connections_utility)) {
        from_state.connections_utility = [];
    } else if (!isarray(from_state.connections_utility)) {
        from_state.connections_utility = array(from_state.connections_utility);
    }
    from_state.connections_utility[from_state.connections_utility.size] = connection;
    return from_state.connections_utility[from_state.connections_utility.size - 1];
}

// Namespace statemachine/statemachine_shared
// Params 2, eflags: 0x0
// Checksum 0x52d6ec3a, Offset: 0x788
// Size: 0x2a8
function set_state(name, state_params) {
    state = self.states[name];
    if (!isdefined(self.owner)) {
        return false;
    }
    if (!isdefined(state)) {
        assertmsg("<dev string:x28>" + name + "<dev string:x44>" + self.name);
        return false;
    }
    reenter = self.current_state === state;
    if (isdefined(state.reenter_func) && reenter) {
        shouldreenter = self.owner [[ state.reenter_func ]](state.state_params);
    }
    if (reenter && shouldreenter !== 1) {
        return false;
    }
    if (isdefined(self.current_state)) {
        self.next_state = state;
        if (isdefined(self.current_state.exit_func)) {
            self.owner [[ self.current_state.exit_func ]](self.current_state.state_params);
        }
        if (!reenter) {
            self.previous_state = self.current_state;
        }
        self.current_state.state_params = undefined;
    }
    if (!isdefined(state_params)) {
        state_params = spawnstruct();
    }
    state.state_params = state_params;
    self.owner notify(self.change_note);
    self.current_state = state;
    self threadnotifyconnections(self.current_state);
    if (isdefined(self.current_state.enter_func)) {
        self.owner [[ self.current_state.enter_func ]](self.current_state.state_params);
    }
    if (isdefined(self.current_state.update_func)) {
        self.owner thread [[ self.current_state.update_func ]](self.current_state.state_params);
    }
    return true;
}

// Namespace statemachine/statemachine_shared
// Params 1, eflags: 0x0
// Checksum 0xe003de9b, Offset: 0xa38
// Size: 0xea
function threadnotifyconnections(state) {
    self notify(#"_cancel_connections");
    foreach (connection in state.connections_notify) {
        assert(connection.type == 0);
        self.owner thread connection_on_notify(self, connection.on_notify, connection);
    }
}

// Namespace statemachine/statemachine_shared
// Params 3, eflags: 0x0
// Checksum 0x268ee2f3, Offset: 0xb30
// Size: 0xb30
function connection_on_notify(state_machine, notify_name, connection) {
    self endon(state_machine.change_note);
    state_machine endon(#"_cancel_connections");
    while (true) {
        waitresult = self waittill(notify_name);
        params = spawnstruct();
        params.notify_param = [];
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param0;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param1;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param2;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param3;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param4;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param5;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param6;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param7;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param8;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param9;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param10;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param11;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.param12;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.var_bd69a304;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.var_9767289b;
        if (!isdefined(params.notify_param)) {
            params.notify_param = [];
        } else if (!isarray(params.notify_param)) {
            params.notify_param = array(params.notify_param);
        }
        params.notify_param[params.notify_param.size] = waitresult.var_7164ae32;
        connectionvalid = 1;
        if (isdefined(connection.checkfunc)) {
            connectionvalid = self [[ connection.checkfunc ]](self.current_state, connection.to_state.name, connection, params);
        }
        if (connectionvalid) {
            state_machine thread set_state(connection.to_state.name, params);
        }
    }
}

// Namespace statemachine/statemachine_shared
// Params 2, eflags: 0x0
// Checksum 0x9e985f99, Offset: 0x1668
// Size: 0x2ec
function evaluate_connections(eval_func, params) {
    assert(isdefined(self.current_state));
    connectionarray = [];
    scorearray = [];
    best_connection = undefined;
    best_score = -1;
    foreach (connection in self.current_state.connections_utility) {
        assert(connection.type == 1);
        score = connection.score;
        if (isdefined(connection.checkfunc)) {
            score = self.owner [[ connection.checkfunc ]](self.current_state.name, connection.to_state.name, connection);
        }
        if (score > 0) {
            if (!isdefined(connectionarray)) {
                connectionarray = [];
            } else if (!isarray(connectionarray)) {
                connectionarray = array(connectionarray);
            }
            connectionarray[connectionarray.size] = connection;
            if (!isdefined(scorearray)) {
                scorearray = [];
            } else if (!isarray(scorearray)) {
                scorearray = array(scorearray);
            }
            scorearray[scorearray.size] = score;
            if (score > best_score) {
                best_connection = connection;
                best_score = score;
            }
        }
    }
    if (isdefined(eval_func) && connectionarray.size > 0) {
        best_connection = self.owner [[ eval_func ]](connectionarray, scorearray, self.current_state);
    }
    if (isdefined(best_connection)) {
        self thread set_state(best_connection.to_state.name, params);
    }
}

// Namespace statemachine/statemachine_shared
// Params 0, eflags: 0x0
// Checksum 0x50934671, Offset: 0x1960
// Size: 0x2c
function debugon() {
    dvarval = getdvarint("statemachine_debug");
    return dvarval;
}

