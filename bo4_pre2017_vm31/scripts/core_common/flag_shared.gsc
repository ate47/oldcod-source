#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;

#namespace flag;

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0x67ffc378, Offset: 0xe8
// Size: 0x16a
function init(str_flag, b_val, b_is_trigger) {
    if (!isdefined(b_val)) {
        b_val = 0;
    }
    if (!isdefined(b_is_trigger)) {
        b_is_trigger = 0;
    }
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    if (!isdefined(self.flag_count)) {
        self.flag_count = [];
    }
    /#
        if (!isdefined(level.first_frame)) {
            assert(!isdefined(self.flag[str_flag]), "<dev string:x28>" + str_flag + "<dev string:x50>");
        }
    #/
    self.flag[str_flag] = b_val;
    self.flag_count[str_flag] = 0;
    if (b_is_trigger) {
        if (!isdefined(level.trigger_flags)) {
            trigger::init_flags();
            level.trigger_flags[str_flag] = [];
            return;
        }
        if (!isdefined(level.trigger_flags[str_flag])) {
            level.trigger_flags[str_flag] = [];
        }
    }
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x84908fe1, Offset: 0x260
// Size: 0x2e
function exists(str_flag) {
    return isdefined(self.flag) && isdefined(self.flag[str_flag]);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x68eb9474, Offset: 0x298
// Size: 0x84
function set(str_flag) {
    assert(exists(str_flag), "<dev string:x5d>" + str_flag + "<dev string:x78>");
    self.flag[str_flag] = 1;
    self notify(str_flag);
    trigger::set_flag_permissions(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x722b140, Offset: 0x328
// Size: 0x74
function increment(str_flag) {
    assert(exists(str_flag), "<dev string:x92>" + str_flag + "<dev string:x78>");
    self.flag_count[str_flag]++;
    set(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xc63c8512, Offset: 0x3a8
// Size: 0xbc
function decrement(str_flag) {
    assert(exists(str_flag), "<dev string:xb3>" + str_flag + "<dev string:x78>");
    assert(self.flag_count[str_flag] > 0, "<dev string:xd4>");
    self.flag_count[str_flag]--;
    if (self.flag_count[str_flag] == 0) {
        clear(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0xefde9495, Offset: 0x470
// Size: 0x3c
function delay_set(n_delay, str_flag, str_cancel) {
    self thread _delay_set(n_delay, str_flag, str_cancel);
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0x91923c4b, Offset: 0x4b8
// Size: 0x5c
function _delay_set(n_delay, str_flag, str_cancel) {
    if (isdefined(str_cancel)) {
        self endon(str_cancel);
    }
    self endon(#"death");
    wait n_delay;
    set(str_flag);
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x91a0b39e, Offset: 0x520
// Size: 0x74
function set_val(str_flag, b_val) {
    assert(isdefined(b_val), "<dev string:x111>");
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x94e676a, Offset: 0x5a0
// Size: 0x74
function set_for_time(n_time, str_flag) {
    self notify("__flag::set_for_time__" + str_flag);
    self endon("__flag::set_for_time__" + str_flag);
    set(str_flag);
    wait n_time;
    clear(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xf0690bb1, Offset: 0x620
// Size: 0x94
function clear(str_flag) {
    assert(exists(str_flag), "<dev string:x13d>" + str_flag + "<dev string:x78>");
    if (self.flag[str_flag]) {
        self.flag[str_flag] = 0;
        self notify(str_flag);
        trigger::set_flag_permissions(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x3856051c, Offset: 0x6c0
// Size: 0x54
function toggle(str_flag) {
    if (get(str_flag)) {
        clear(str_flag);
        return;
    }
    set(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xb8f19201, Offset: 0x720
// Size: 0x5c
function get(str_flag) {
    assert(exists(str_flag), "<dev string:x15a>" + str_flag + "<dev string:x78>");
    return self.flag[str_flag];
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x9c5a5e31, Offset: 0x788
// Size: 0x9c
function get_any(&array) {
    foreach (str_flag in array) {
        if (get(str_flag)) {
            return true;
        }
    }
    return false;
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xb9b6627f, Offset: 0x830
// Size: 0x3e
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x403fe11d, Offset: 0x878
// Size: 0x84
function wait_till_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x18e078e8, Offset: 0x908
// Size: 0x86
function wait_till_all(a_flags) {
    self endon(#"death");
    for (i = 0; i < a_flags.size; i++) {
        str_flag = a_flags[i];
        if (!get(str_flag)) {
            self waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x7f7bab07, Offset: 0x998
// Size: 0x84
function wait_till_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_all(a_flags);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x1110e6fa, Offset: 0xa28
// Size: 0xae
function wait_till_any(a_flags) {
    self endon(#"death");
    foreach (flag in a_flags) {
        if (get(flag)) {
            return flag;
        }
    }
    self waittill(a_flags);
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0xe12b87b4, Offset: 0xae0
// Size: 0x84
function wait_till_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_any(a_flags);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xc8c8c772, Offset: 0xb70
// Size: 0x3e
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x44564dd5, Offset: 0xbb8
// Size: 0x84
function wait_till_clear_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x9e470cb7, Offset: 0xc48
// Size: 0x86
function wait_till_clear_all(a_flags) {
    self endon(#"death");
    for (i = 0; i < a_flags.size; i++) {
        str_flag = a_flags[i];
        if (get(str_flag)) {
            self waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x8366bdaf, Offset: 0xcd8
// Size: 0x84
function wait_till_clear_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_all(a_flags);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xadd4c75, Offset: 0xd68
// Size: 0xba
function wait_till_clear_any(a_flags) {
    self endon(#"death");
    while (true) {
        foreach (flag in a_flags) {
            if (!get(flag)) {
                return flag;
            }
        }
        self waittill(a_flags);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x9b544490, Offset: 0xe30
// Size: 0x84
function wait_till_clear_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_any(a_flags);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xfb69db8f, Offset: 0xec0
// Size: 0x5c
function delete(str_flag) {
    if (isdefined(self.flag[str_flag])) {
        self.flag[str_flag] = undefined;
        return;
    }
    println("<dev string:x16e>" + str_flag);
}

// Namespace flag/flag_shared
// Params 0, eflags: 0x0
// Checksum 0x32454875, Offset: 0xf28
// Size: 0x3c
function script_flag_wait() {
    if (isdefined(self.script_flag_wait)) {
        self wait_till(self.script_flag_wait);
        return true;
    }
    return false;
}

