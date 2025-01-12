#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace visionset_mgr;

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x2
// Checksum 0xdedcc64e, Offset: 0x198
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("visionset_mgr", &__init__, undefined, undefined);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x0
// Checksum 0x9e74423b, Offset: 0x1d8
// Size: 0xcc
function __init__() {
    level.vsmgr_initializing = 1;
    level.vsmgr_default_info_name = "__none";
    level.vsmgr = [];
    level thread register_type("visionset");
    level thread register_type("overlay");
    callback::on_finalize_initialization(&finalize_clientfields);
    level thread monitor();
    callback::on_connect(&on_player_connect);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 8, eflags: 0x0
// Checksum 0x55718cb0, Offset: 0x2b0
// Size: 0x1b0
function register_info(type, name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread) {
    assert(level.vsmgr_initializing, "<dev string:x28>");
    lower_name = tolower(name);
    validate_info(type, lower_name, priority);
    add_sorted_name_key(type, lower_name);
    add_sorted_priority_key(type, lower_name, priority);
    level.vsmgr[type].info[lower_name] = spawnstruct();
    level.vsmgr[type].info[lower_name] add_info(type, lower_name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread);
    if (level.vsmgr[type].highest_version < version) {
        level.vsmgr[type].highest_version = version;
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 6, eflags: 0x0
// Checksum 0xf31de6f8, Offset: 0x468
// Size: 0x1be
function activate(type, name, player, opt_param_1, opt_param_2, opt_param_3) {
    if (level.vsmgr[type].info[name].state.should_activate_per_player) {
        activate_per_player(type, name, player, opt_param_1, opt_param_2, opt_param_3);
        return;
    }
    state = level.vsmgr[type].info[name].state;
    if (state.ref_count_lerp_thread) {
        state.ref_count++;
        if (1 < state.ref_count) {
            return;
        }
    }
    if (isdefined(state.lerp_thread)) {
        state thread lerp_thread_wrapper(state.lerp_thread, opt_param_1, opt_param_2, opt_param_3);
        return;
    }
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        state set_state_active(players[player_index], 1);
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 3, eflags: 0x0
// Checksum 0xf92d7b50, Offset: 0x630
// Size: 0x164
function deactivate(type, name, player) {
    if (level.vsmgr[type].info[name].state.should_activate_per_player) {
        deactivate_per_player(type, name, player);
        return;
    }
    state = level.vsmgr[type].info[name].state;
    if (state.ref_count_lerp_thread) {
        state.ref_count--;
        if (0 < state.ref_count) {
            return;
        }
    }
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        state set_state_inactive(players[player_index]);
    }
    state notify(#"visionset_mgr_deactivate_all");
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 2, eflags: 0x0
// Checksum 0x1d8550c6, Offset: 0x7a0
// Size: 0xa4
function set_state_active(player, lerp) {
    player_entnum = player getentitynumber();
    if (!isdefined(self.players[player_entnum])) {
        return;
    }
    self.players[player_entnum].active = 1;
    self.players[player_entnum].lerp = lerp;
    player.var_c6655bf3 = 1;
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 1, eflags: 0x0
// Checksum 0x4908891c, Offset: 0x850
// Size: 0x94
function set_state_inactive(player) {
    player_entnum = player getentitynumber();
    if (!isdefined(self.players[player_entnum])) {
        return;
    }
    self.players[player_entnum].active = 0;
    self.players[player_entnum].lerp = 0;
    player.var_c6655bf3 = 1;
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 3, eflags: 0x0
// Checksum 0xd7b15d87, Offset: 0x8f0
// Size: 0xac
function timeout_lerp_thread(timeout, opt_param_2, opt_param_3) {
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        self set_state_active(players[player_index], 1);
    }
    wait timeout;
    deactivate(self.type, self.name);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 4, eflags: 0x0
// Checksum 0x8d9c589b, Offset: 0x9a8
// Size: 0x74
function timeout_lerp_thread_per_player(player, timeout, opt_param_2, opt_param_3) {
    self set_state_active(player, 1);
    wait timeout;
    deactivate_per_player(self.type, self.name, player);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 2, eflags: 0x0
// Checksum 0xb90cda8a, Offset: 0xa28
// Size: 0x15c
function duration_lerp_thread(duration, max_duration) {
    start_time = gettime();
    end_time = start_time + int(duration * 1000);
    if (isdefined(max_duration)) {
        start_time = end_time - int(max_duration * 1000);
    }
    while (true) {
        lerp = calc_remaining_duration_lerp(start_time, end_time);
        if (0 >= lerp) {
            break;
        }
        players = getplayers();
        for (player_index = 0; player_index < players.size; player_index++) {
            self set_state_active(players[player_index], lerp);
        }
        waitframe(1);
    }
    deactivate(self.type, self.name);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 3, eflags: 0x0
// Checksum 0xb15171ac, Offset: 0xb90
// Size: 0x114
function duration_lerp_thread_per_player(player, duration, max_duration) {
    start_time = gettime();
    end_time = start_time + int(duration * 1000);
    if (isdefined(max_duration)) {
        start_time = end_time - int(max_duration * 1000);
    }
    while (true) {
        lerp = calc_remaining_duration_lerp(start_time, end_time);
        if (0 >= lerp) {
            break;
        }
        self set_state_active(player, lerp);
        waitframe(1);
    }
    deactivate_per_player(self.type, self.name, player);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 2, eflags: 0x0
// Checksum 0xbbf5c3db, Offset: 0xcb0
// Size: 0xb6
function ramp_in_thread_per_player(player, duration) {
    start_time = gettime();
    end_time = start_time + int(duration * 1000);
    while (true) {
        lerp = calc_ramp_in_lerp(start_time, end_time);
        if (1 <= lerp) {
            break;
        }
        self set_state_active(player, lerp);
        waitframe(1);
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x0
// Checksum 0x4af0cbe3, Offset: 0xd70
// Size: 0x80
function ramp_in_out_thread_hold_func() {
    level endon(#"kill_ramp_in_out_thread_hold_func");
    while (true) {
        for (player_index = 0; player_index < level.players.size; player_index++) {
            self set_state_active(level.players[player_index], 1);
        }
        waitframe(1);
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 3, eflags: 0x0
// Checksum 0x836a8b8e, Offset: 0xdf8
// Size: 0x254
function ramp_in_out_thread(ramp_in, full_period, ramp_out) {
    start_time = gettime();
    end_time = start_time + int(ramp_in * 1000);
    while (true) {
        lerp = calc_ramp_in_lerp(start_time, end_time);
        if (1 <= lerp) {
            break;
        }
        players = getplayers();
        for (player_index = 0; player_index < players.size; player_index++) {
            self set_state_active(players[player_index], lerp);
        }
        waitframe(1);
    }
    self thread ramp_in_out_thread_hold_func();
    if (isfunctionptr(full_period)) {
        self [[ full_period ]]();
    } else {
        wait full_period;
    }
    level notify(#"kill_ramp_in_out_thread_hold_func");
    start_time = gettime();
    end_time = start_time + int(ramp_out * 1000);
    while (true) {
        lerp = calc_remaining_duration_lerp(start_time, end_time);
        if (0 >= lerp) {
            break;
        }
        players = getplayers();
        for (player_index = 0; player_index < players.size; player_index++) {
            self set_state_active(players[player_index], lerp);
        }
        waitframe(1);
    }
    deactivate(self.type, self.name);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 4, eflags: 0x0
// Checksum 0x9cf3c23f, Offset: 0x1058
// Size: 0x1cc
function ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out) {
    start_time = gettime();
    end_time = start_time + int(ramp_in * 1000);
    while (true) {
        lerp = calc_ramp_in_lerp(start_time, end_time);
        if (1 <= lerp) {
            break;
        }
        self set_state_active(player, lerp);
        waitframe(1);
    }
    self set_state_active(player, lerp);
    if (isfunctionptr(full_period)) {
        player [[ full_period ]]();
    } else {
        wait full_period;
    }
    start_time = gettime();
    end_time = start_time + int(ramp_out * 1000);
    while (true) {
        lerp = calc_remaining_duration_lerp(start_time, end_time);
        if (0 >= lerp) {
            break;
        }
        self set_state_active(player, lerp);
        waitframe(1);
    }
    deactivate_per_player(self.type, self.name, player);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 1, eflags: 0x0
// Checksum 0x531e5967, Offset: 0x1230
// Size: 0x94
function ramp_in_out_thread_watch_player_shutdown(player) {
    player notify(#"ramp_in_out_thread_watch_player_shutdown");
    player endon(#"ramp_in_out_thread_watch_player_shutdown");
    player endon(#"disconnect");
    player waittill("death");
    if (player isremotecontrolling() == 0) {
        deactivate_per_player(self.type, self.name, player);
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 4, eflags: 0x0
// Checksum 0x593813b5, Offset: 0x12d0
// Size: 0x6c
function ramp_in_out_thread_per_player_death_shutdown(player, ramp_in, full_period, ramp_out) {
    player endon(#"death");
    thread ramp_in_out_thread_watch_player_shutdown(player);
    ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 4, eflags: 0x0
// Checksum 0x611e8a30, Offset: 0x1348
// Size: 0x44
function ramp_in_out_thread_per_player(player, ramp_in, full_period, ramp_out) {
    ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 1, eflags: 0x0
// Checksum 0xaafb0ddc, Offset: 0x1398
// Size: 0x16c
function register_type(type) {
    level.vsmgr[type] = spawnstruct();
    level.vsmgr[type].type = type;
    level.vsmgr[type].in_use = 0;
    level.vsmgr[type].highest_version = 0;
    level.vsmgr[type].cf_slot_name = type + "_slot";
    level.vsmgr[type].cf_lerp_name = type + "_lerp";
    level.vsmgr[type].info = [];
    level.vsmgr[type].sorted_name_keys = [];
    level.vsmgr[type].sorted_prio_keys = [];
    register_info(type, level.vsmgr_default_info_name, 1, 0, 1, 0, undefined);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x0
// Checksum 0x7b41a08b, Offset: 0x1510
// Size: 0x94
function finalize_clientfields() {
    typekeys = getarraykeys(level.vsmgr);
    for (type_index = 0; type_index < typekeys.size; type_index++) {
        level.vsmgr[typekeys[type_index]] thread finalize_type_clientfields();
    }
    level.vsmgr_initializing = 0;
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x0
// Checksum 0x1602d109, Offset: 0x15b0
// Size: 0x2a4
function finalize_type_clientfields() {
    println("<dev string:x9d>" + self.type + "<dev string:xad>");
    if (1 >= self.info.size) {
        return;
    }
    self.in_use = 1;
    self.cf_slot_bit_count = getminbitcountfornum(self.info.size - 1);
    self.cf_lerp_bit_count = self.info[self.sorted_name_keys[0]].lerp_bit_count;
    for (i = 0; i < self.sorted_name_keys.size; i++) {
        self.info[self.sorted_name_keys[i]].slot_index = i;
        if (self.info[self.sorted_name_keys[i]].lerp_bit_count > self.cf_lerp_bit_count) {
            self.cf_lerp_bit_count = self.info[self.sorted_name_keys[i]].lerp_bit_count;
        }
        println("<dev string:xc5>" + self.info[self.sorted_name_keys[i]].name + "<dev string:xd0>" + self.info[self.sorted_name_keys[i]].version + "<dev string:xdc>" + self.info[self.sorted_name_keys[i]].lerp_step_count + "<dev string:xf0>");
    }
    clientfield::register("toplayer", self.cf_slot_name, self.highest_version, self.cf_slot_bit_count, "int");
    if (1 < self.cf_lerp_bit_count) {
        clientfield::register("toplayer", self.cf_lerp_name, self.highest_version, self.cf_lerp_bit_count, "float");
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 3, eflags: 0x0
// Checksum 0xd8e6169c, Offset: 0x1860
// Size: 0x24e
function validate_info(type, name, priority) {
    keys = getarraykeys(level.vsmgr);
    for (i = 0; i < keys.size; i++) {
        if (type == keys[i]) {
            break;
        }
    }
    assert(i < keys.size, "<dev string:xf1>" + type + "<dev string:x10a>");
    keys = getarraykeys(level.vsmgr[type].info);
    for (i = 0; i < keys.size; i++) {
        assert(level.vsmgr[type].info[keys[i]].name != name, "<dev string:x116>" + type + "<dev string:x131>" + name + "<dev string:x13b>");
        assert(level.vsmgr[type].info[keys[i]].priority != priority, "<dev string:x116>" + type + "<dev string:x15c>" + priority + "<dev string:x16a>" + name + "<dev string:x181>" + level.vsmgr[type].info[keys[i]].name + "<dev string:x1af>");
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 2, eflags: 0x0
// Checksum 0x29d8c173, Offset: 0x1ab8
// Size: 0xbc
function add_sorted_name_key(type, name) {
    for (i = 0; i < level.vsmgr[type].sorted_name_keys.size; i++) {
        if (name < level.vsmgr[type].sorted_name_keys[i]) {
            break;
        }
    }
    arrayinsert(level.vsmgr[type].sorted_name_keys, name, i);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 3, eflags: 0x0
// Checksum 0x3c24fc67, Offset: 0x1b80
// Size: 0xe4
function add_sorted_priority_key(type, name, priority) {
    for (i = 0; i < level.vsmgr[type].sorted_prio_keys.size; i++) {
        if (priority > level.vsmgr[type].info[level.vsmgr[type].sorted_prio_keys[i]].priority) {
            break;
        }
    }
    arrayinsert(level.vsmgr[type].sorted_prio_keys, name, i);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 8, eflags: 0x0
// Checksum 0x4ebb8ba4, Offset: 0x1c70
// Size: 0x198
function add_info(type, name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread) {
    self.type = type;
    self.name = name;
    self.version = version;
    self.priority = priority;
    self.lerp_step_count = lerp_step_count;
    self.lerp_bit_count = getminbitcountfornum(lerp_step_count);
    if (!isdefined(ref_count_lerp_thread)) {
        ref_count_lerp_thread = 0;
    }
    self.state = spawnstruct();
    self.state.type = type;
    self.state.name = name;
    self.state.should_activate_per_player = should_activate_per_player;
    self.state.lerp_thread = lerp_thread;
    self.state.ref_count_lerp_thread = ref_count_lerp_thread;
    self.state.players = [];
    if (ref_count_lerp_thread && !should_activate_per_player) {
        self.state.ref_count = 0;
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x0
// Checksum 0x5f7f0e93, Offset: 0x1e10
// Size: 0x1c
function on_player_connect() {
    self player_setup();
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x0
// Checksum 0xeecb65ed, Offset: 0x1e38
// Size: 0x316
function player_setup() {
    self.vsmgr_player_entnum = self getentitynumber();
    typekeys = getarraykeys(level.vsmgr);
    for (type_index = 0; type_index < typekeys.size; type_index++) {
        type = typekeys[type_index];
        if (!level.vsmgr[type].in_use) {
            continue;
        }
        for (name_index = 0; name_index < level.vsmgr[type].sorted_name_keys.size; name_index++) {
            name_key = level.vsmgr[type].sorted_name_keys[name_index];
            level.vsmgr[type].info[name_key].state.players[self.vsmgr_player_entnum] = spawnstruct();
            level.vsmgr[type].info[name_key].state.players[self.vsmgr_player_entnum].active = 0;
            level.vsmgr[type].info[name_key].state.players[self.vsmgr_player_entnum].lerp = 0;
            if (level.vsmgr[type].info[name_key].state.ref_count_lerp_thread && level.vsmgr[type].info[name_key].state.should_activate_per_player) {
                level.vsmgr[type].info[name_key].state.players[self.vsmgr_player_entnum].ref_count = 0;
            }
        }
        level.vsmgr[type].info[level.vsmgr_default_info_name].state set_state_active(self, 1);
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x0
// Checksum 0x9aa97185, Offset: 0x2158
// Size: 0x140
function player_shutdown() {
    self.vsmgr_player_entnum = self getentitynumber();
    typekeys = getarraykeys(level.vsmgr);
    for (type_index = 0; type_index < typekeys.size; type_index++) {
        type = typekeys[type_index];
        if (!level.vsmgr[type].in_use) {
            continue;
        }
        for (name_index = 0; name_index < level.vsmgr[type].sorted_name_keys.size; name_index++) {
            name_key = level.vsmgr[type].sorted_name_keys[name_index];
            deactivate_per_player(type, name_key, self);
        }
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 0, eflags: 0x0
// Checksum 0xef290a1c, Offset: 0x22a0
// Size: 0x180
function monitor() {
    while (level.vsmgr_initializing) {
        waitframe(1);
    }
    typekeys = getarraykeys(level.vsmgr);
    while (true) {
        waitframe(1);
        waittillframeend();
        players = getplayers();
        for (player_index = 0; player_index < players.size; player_index++) {
            player = players[player_index];
            if (isdefined(player.var_c6655bf3) && player.var_c6655bf3) {
                for (type_index = 0; type_index < typekeys.size; type_index++) {
                    type = typekeys[type_index];
                    if (!level.vsmgr[type].in_use) {
                        continue;
                    }
                    update_clientfields(player, level.vsmgr[type]);
                }
                player.var_c6655bf3 = undefined;
            }
        }
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 1, eflags: 0x0
// Checksum 0x84424edd, Offset: 0x2428
// Size: 0xc2
function get_first_active_name(type_struct) {
    size = type_struct.sorted_prio_keys.size;
    for (prio_index = 0; prio_index < size; prio_index++) {
        prio_key = type_struct.sorted_prio_keys[prio_index];
        if (type_struct.info[prio_key].state.players[self.vsmgr_player_entnum].active) {
            return prio_key;
        }
    }
    return level.vsmgr_default_info_name;
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 2, eflags: 0x0
// Checksum 0x47d562e1, Offset: 0x24f8
// Size: 0xec
function update_clientfields(player, type_struct) {
    name = player get_first_active_name(type_struct);
    player clientfield::set_to_player(type_struct.cf_slot_name, type_struct.info[name].slot_index);
    if (1 < type_struct.cf_lerp_bit_count) {
        player clientfield::set_to_player(type_struct.cf_lerp_name, type_struct.info[name].state.players[player.vsmgr_player_entnum].lerp);
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 4, eflags: 0x0
// Checksum 0x8cabf137, Offset: 0x25f0
// Size: 0x5a
function lerp_thread_wrapper(func, opt_param_1, opt_param_2, opt_param_3) {
    self notify(#"visionset_mgr_deactivate_all");
    self endon(#"visionset_mgr_deactivate_all");
    self [[ func ]](opt_param_1, opt_param_2, opt_param_3);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 5, eflags: 0x0
// Checksum 0x50b12a36, Offset: 0x2658
// Size: 0xb0
function lerp_thread_per_player_wrapper(func, player, opt_param_1, opt_param_2, opt_param_3) {
    player_entnum = player getentitynumber();
    self.players[player_entnum] notify(#"visionset_mgr_deactivate");
    self.players[player_entnum] endon(#"visionset_mgr_deactivate");
    player endon(#"disconnect");
    self [[ func ]](player, opt_param_1, opt_param_2, opt_param_3);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 6, eflags: 0x0
// Checksum 0xf497e171, Offset: 0x2710
// Size: 0x14c
function activate_per_player(type, name, player, opt_param_1, opt_param_2, opt_param_3) {
    player_entnum = player getentitynumber();
    state = level.vsmgr[type].info[name].state;
    if (state.ref_count_lerp_thread) {
        state.players[player_entnum].ref_count++;
        if (1 < state.players[player_entnum].ref_count) {
            return;
        }
    }
    if (isdefined(state.lerp_thread)) {
        state thread lerp_thread_per_player_wrapper(state.lerp_thread, player, opt_param_1, opt_param_2, opt_param_3);
        return;
    }
    state set_state_active(player, 1);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 3, eflags: 0x0
// Checksum 0xfb3e740d, Offset: 0x2868
// Size: 0x122
function deactivate_per_player(type, name, player) {
    player_entnum = player getentitynumber();
    state = level.vsmgr[type].info[name].state;
    if (state.players.size > 0) {
        if (state.ref_count_lerp_thread) {
            state.players[player_entnum].ref_count--;
            if (0 < state.players[player_entnum].ref_count) {
                return;
            }
        }
        state set_state_inactive(player);
        state.players[player_entnum] notify(#"visionset_mgr_deactivate");
    }
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 2, eflags: 0x0
// Checksum 0xa58afa99, Offset: 0x2998
// Size: 0x9a
function calc_ramp_in_lerp(start_time, end_time) {
    if (0 >= end_time - start_time) {
        return 1;
    }
    now = gettime();
    frac = float(now - start_time) / float(end_time - start_time);
    return math::clamp(frac, 0, 1);
}

// Namespace visionset_mgr/visionset_mgr_shared
// Params 2, eflags: 0x0
// Checksum 0x2aae833a, Offset: 0x2a40
// Size: 0x92
function calc_remaining_duration_lerp(start_time, end_time) {
    if (0 >= end_time - start_time) {
        return 0;
    }
    now = gettime();
    frac = float(end_time - now) / float(end_time - start_time);
    return math::clamp(frac, 0, 1);
}

