#using scripts\core_common\util_shared;

#namespace flagsys;

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x9c0ea8be, Offset: 0x90
// Size: 0x3e
function set(str_flag) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    self.flag[str_flag] = 1;
    self notify(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0xae813626, Offset: 0xd8
// Size: 0x64
function set_for_time(n_time, str_flag) {
    self notify("__flag::set_for_time__" + str_flag);
    self endon("__flag::set_for_time__" + str_flag);
    set(str_flag);
    wait n_time;
    clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x92d0880c, Offset: 0x148
// Size: 0x58
function clear(str_flag) {
    if (isdefined(self.flag) && isdefined(self.flag[str_flag]) && self.flag[str_flag]) {
        self.flag[str_flag] = undefined;
        self notify(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0xe57da005, Offset: 0x1a8
// Size: 0x6c
function set_val(str_flag, b_val) {
    assert(isdefined(b_val), "<dev string:x30>");
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x5904febd, Offset: 0x220
// Size: 0x3c
function toggle(str_flag) {
    set_val(str_flag, !get(str_flag));
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x49b6e167, Offset: 0x268
// Size: 0x3c
function get(str_flag) {
    return isdefined(self.flag) && isdefined(self.flag[str_flag]) && self.flag[str_flag];
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x565fcab2, Offset: 0x2b0
// Size: 0x46
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0xe75e64e9, Offset: 0x300
// Size: 0x84
function wait_till_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x5114b992, Offset: 0x390
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

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x577eb744, Offset: 0x420
// Size: 0x84
function wait_till_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_all(a_flags);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x70bb1fc4, Offset: 0x4b0
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

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0xa8e2465, Offset: 0x560
// Size: 0x84
function wait_till_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_any(a_flags);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0xbae49548, Offset: 0x5f0
// Size: 0x46
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x59627875, Offset: 0x640
// Size: 0x84
function wait_till_clear_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x4760e027, Offset: 0x6d0
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

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x11f881d2, Offset: 0x760
// Size: 0x84
function wait_till_clear_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_all(a_flags);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x3138b836, Offset: 0x7f0
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

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x2369eab7, Offset: 0x8a8
// Size: 0x84
function wait_till_clear_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_any(a_flags);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0xd279b56e, Offset: 0x938
// Size: 0x24
function delete(str_flag) {
    clear(str_flag);
}

