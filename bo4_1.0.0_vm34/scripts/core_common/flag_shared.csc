#using scripts\core_common\util_shared;

#namespace flag;

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0xc2366413, Offset: 0x90
// Size: 0xb2
function init(str_flag, b_val = 0, b_is_trigger = 0) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    /#
        if (!isdefined(level.first_frame)) {
            assert(!isdefined(self.flag[str_flag]), "<dev string:x30>" + str_flag + "<dev string:x58>");
        }
    #/
    self.flag[str_flag] = b_val;
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xb7c6eff6, Offset: 0x150
// Size: 0x28
function exists(str_flag) {
    return isdefined(self.flag) && isdefined(self.flag[str_flag]);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x8190cdf8, Offset: 0x180
// Size: 0x72
function set(str_flag) {
    assert(exists(str_flag), "<dev string:x65>" + str_flag + "<dev string:x80>");
    self.flag[str_flag] = 1;
    self notify(str_flag);
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0x2d245fd6, Offset: 0x200
// Size: 0x3c
function delay_set(n_delay, str_flag, str_cancel) {
    self thread _delay_set(n_delay, str_flag, str_cancel);
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0x9efde972, Offset: 0x248
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
// Checksum 0x5c3f8cc2, Offset: 0x2b0
// Size: 0x64
function set_for_time(n_time, str_flag) {
    self notify("__flag::set_for_time__" + str_flag);
    self endon("__flag::set_for_time__" + str_flag);
    set(str_flag);
    wait n_time;
    clear(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x40ada68b, Offset: 0x320
// Size: 0x76
function clear(str_flag) {
    assert(exists(str_flag), "<dev string:x9a>" + str_flag + "<dev string:x80>");
    if (self.flag[str_flag]) {
        self.flag[str_flag] = 0;
        self notify(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x5ab39acd, Offset: 0x3a0
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
// Checksum 0x9ce849a8, Offset: 0x400
// Size: 0x58
function get(str_flag) {
    assert(exists(str_flag), "<dev string:xb7>" + str_flag + "<dev string:x80>");
    return self.flag[str_flag];
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xa797dea6, Offset: 0x460
// Size: 0x46
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x5da04f14, Offset: 0x4b0
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
// Checksum 0xe8ed4a9f, Offset: 0x540
// Size: 0x84
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
// Checksum 0x4ac22b29, Offset: 0x5d0
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
// Checksum 0x278c0ef5, Offset: 0x660
// Size: 0xa4
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
// Checksum 0x58d8e474, Offset: 0x710
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
// Checksum 0x38f5385, Offset: 0x7a0
// Size: 0x46
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0xbba08655, Offset: 0x7f0
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
// Checksum 0x6ee6d248, Offset: 0x880
// Size: 0x84
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
// Checksum 0x450313ef, Offset: 0x910
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
// Checksum 0xb016d2c6, Offset: 0x9a0
// Size: 0xb0
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
// Checksum 0x878ea79d, Offset: 0xa58
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
// Checksum 0xeb533958, Offset: 0xae8
// Size: 0x54
function delete(str_flag) {
    if (isdefined(self.flag[str_flag])) {
        self.flag[str_flag] = undefined;
        return;
    }
    println("<dev string:xcb>" + str_flag);
}

