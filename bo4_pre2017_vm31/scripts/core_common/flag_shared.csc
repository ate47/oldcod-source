#using scripts/core_common/util_shared;

#namespace flag;

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0xfde1d75d, Offset: 0xc0
// Size: 0xca
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
    /#
        if (!isdefined(level.first_frame)) {
            assert(!isdefined(self.flag[str_flag]), "<dev string:x28>" + str_flag + "<dev string:x50>");
        }
    #/
    self.flag[str_flag] = b_val;
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xd0ec5444, Offset: 0x198
// Size: 0x2e
function exists(str_flag) {
    return isdefined(self.flag) && isdefined(self.flag[str_flag]);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x4cb45dd9, Offset: 0x1d0
// Size: 0x74
function set(str_flag) {
    assert(exists(str_flag), "<dev string:x5d>" + str_flag + "<dev string:x78>");
    self.flag[str_flag] = 1;
    self notify(str_flag);
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0xc8592cca, Offset: 0x250
// Size: 0x3c
function delay_set(n_delay, str_flag, str_cancel) {
    self thread _delay_set(n_delay, str_flag, str_cancel);
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0x4ec1b999, Offset: 0x298
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
// Checksum 0x337f1df8, Offset: 0x300
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
// Checksum 0x576be808, Offset: 0x380
// Size: 0x7c
function clear(str_flag) {
    assert(exists(str_flag), "<dev string:x92>" + str_flag + "<dev string:x78>");
    if (self.flag[str_flag]) {
        self.flag[str_flag] = 0;
        self notify(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x7400e4bf, Offset: 0x408
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
// Checksum 0xa0a08ec8, Offset: 0x468
// Size: 0x5c
function get(str_flag) {
    assert(exists(str_flag), "<dev string:xaf>" + str_flag + "<dev string:x78>");
    return self.flag[str_flag];
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x3ee2b835, Offset: 0x4d0
// Size: 0x3e
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x4544d8c3, Offset: 0x518
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
// Checksum 0xb2393152, Offset: 0x5a8
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
// Checksum 0x3a806d35, Offset: 0x638
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
// Checksum 0x75906262, Offset: 0x6c8
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
// Checksum 0x7d41bfdd, Offset: 0x780
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
// Checksum 0x56800b05, Offset: 0x810
// Size: 0x3e
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x6cd78be, Offset: 0x858
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
// Checksum 0x7b6c6e30, Offset: 0x8e8
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
// Checksum 0xa29cd4fb, Offset: 0x978
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
// Checksum 0x2ac82d34, Offset: 0xa08
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
// Checksum 0xd2c798f2, Offset: 0xad0
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
// Checksum 0x3ec8091b, Offset: 0xb60
// Size: 0x5c
function delete(str_flag) {
    if (isdefined(self.flag[str_flag])) {
        self.flag[str_flag] = undefined;
        return;
    }
    println("<dev string:xc3>" + str_flag);
}

