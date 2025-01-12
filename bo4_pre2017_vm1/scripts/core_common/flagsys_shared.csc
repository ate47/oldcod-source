#using scripts/core_common/util_shared;

#namespace flagsys;

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x566388bd, Offset: 0xc8
// Size: 0x48
function set(str_flag) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    self.flag[str_flag] = 1;
    self notify(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x3dcc6de, Offset: 0x118
// Size: 0x74
function set_for_time(n_time, str_flag) {
    self notify("__flag::set_for_time__" + str_flag);
    self endon("__flag::set_for_time__" + str_flag);
    set(str_flag);
    wait n_time;
    clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0xfcb27f43, Offset: 0x198
// Size: 0x5e
function clear(str_flag) {
    if (isdefined(self.flag[str_flag]) && isdefined(self.flag) && self.flag[str_flag]) {
        self.flag[str_flag] = undefined;
        self notify(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x3829ae6d, Offset: 0x200
// Size: 0x74
function set_val(str_flag, b_val) {
    /#
        assert(isdefined(b_val), "<dev string:x28>");
    #/
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0xc793011, Offset: 0x280
// Size: 0x34
function toggle(str_flag) {
    set(!get(str_flag));
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0xb4c30d6c, Offset: 0x2c0
// Size: 0x40
function get(str_flag) {
    return isdefined(self.flag[str_flag]) && isdefined(self.flag) && self.flag[str_flag];
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x98121c7c, Offset: 0x308
// Size: 0x3e
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x4d0bc935, Offset: 0x350
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
// Checksum 0xe21ca51b, Offset: 0x3e0
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

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x9814c2b5, Offset: 0x470
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
// Checksum 0xd891e477, Offset: 0x500
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

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x4fd463fb, Offset: 0x5b8
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
// Checksum 0xb118cd3b, Offset: 0x648
// Size: 0x3e
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x63173466, Offset: 0x690
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
// Checksum 0xaf7626f6, Offset: 0x720
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

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x8e6f282d, Offset: 0x7b0
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
// Checksum 0x38059af5, Offset: 0x840
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

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x4a2b0f8b, Offset: 0x908
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
// Checksum 0x7ea1e0df, Offset: 0x998
// Size: 0x24
function delete(str_flag) {
    clear(str_flag);
}

