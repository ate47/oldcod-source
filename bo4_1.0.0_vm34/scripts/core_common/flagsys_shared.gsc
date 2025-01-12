#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace flagsys;

// Namespace flagsys/flagsys_shared
// Params 0, eflags: 0x2
// Checksum 0x34ef9509, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"flagsys", &__init__, undefined, undefined);
}

// Namespace flagsys/flagsys_shared
// Params 0, eflags: 0x0
// Checksum 0xec442f41, Offset: 0xe0
// Size: 0x1c
function __init__() {
    level thread update_flag_dvars();
}

// Namespace flagsys/flagsys_shared
// Params 0, eflags: 0x0
// Checksum 0x608e63c0, Offset: 0x108
// Size: 0xd0
function update_flag_dvars() {
    while (true) {
        if (isdefined(level.flag_dvars)) {
            foreach (str_dvar in level.flag_dvars) {
                set_val(str_dvar, getdvarint(str_dvar, 0));
            }
        }
        wait randomfloatrange(0.666667, 1.33333);
    }
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x908b5dfb, Offset: 0x1e0
// Size: 0xb2
function init_dvar(str_dvar) {
    if (!isdefined(level.flag_dvars)) {
        level.flag_dvars = [];
    } else if (!isarray(level.flag_dvars)) {
        level.flag_dvars = array(level.flag_dvars);
    }
    if (!isinarray(level.flag_dvars, str_dvar)) {
        level.flag_dvars[level.flag_dvars.size] = str_dvar;
    }
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x37815889, Offset: 0x2a0
// Size: 0x3e
function set(str_flag) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    self.flag[str_flag] = 1;
    self notify(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0xb9643db0, Offset: 0x2e8
// Size: 0x6c
function increment(str_flag) {
    if (!isdefined(self.flag_count)) {
        self.flag_count = [];
    }
    if (!isdefined(self.flag_count[str_flag])) {
        self.flag_count[str_flag] = 0;
    }
    self.flag_count[str_flag]++;
    set(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0xbaad40ad, Offset: 0x360
// Size: 0x9c
function decrement(str_flag) {
    assert(isdefined(self.flag_count) && isdefined(self.flag_count[str_flag]) && self.flag_count[str_flag] > 0, "<dev string:x30>");
    self.flag_count[str_flag]--;
    if (self.flag_count[str_flag] == 0) {
        clear(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x4337928e, Offset: 0x408
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
// Checksum 0xcac8c616, Offset: 0x478
// Size: 0x58
function clear(str_flag) {
    if (isdefined(self.flag) && isdefined(self.flag[str_flag]) && self.flag[str_flag]) {
        self.flag[str_flag] = undefined;
        self notify(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x4e362eda, Offset: 0x4d8
// Size: 0x6c
function set_val(str_flag, b_val) {
    assert(isdefined(b_val), "<dev string:x6d>");
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x53861e4e, Offset: 0x550
// Size: 0x3c
function toggle(str_flag) {
    set_val(str_flag, !get(str_flag));
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x474aa9b5, Offset: 0x598
// Size: 0x3c
function get(str_flag) {
    return isdefined(self.flag) && isdefined(self.flag[str_flag]) && self.flag[str_flag];
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x9f989c25, Offset: 0x5e0
// Size: 0x46
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x3c063cdc, Offset: 0x630
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
// Checksum 0x1d52256e, Offset: 0x6c0
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
// Checksum 0x698ff4a2, Offset: 0x750
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
// Checksum 0x45dfb03a, Offset: 0x7e0
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
// Checksum 0x788c1b87, Offset: 0x890
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
// Checksum 0x675140eb, Offset: 0x920
// Size: 0x46
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0xf3557626, Offset: 0x970
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
// Checksum 0x63df56a0, Offset: 0xa00
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
// Checksum 0x99398ca5, Offset: 0xa90
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
// Checksum 0x3e8e677e, Offset: 0xb20
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
// Checksum 0x63605972, Offset: 0xbd8
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
// Checksum 0xda8857ac, Offset: 0xc68
// Size: 0x24
function delete(str_flag) {
    clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 0, eflags: 0x0
// Checksum 0x4604f66d, Offset: 0xc98
// Size: 0x34
function script_flag_wait() {
    if (isdefined(self.script_flag_wait)) {
        self wait_till(self.script_flag_wait);
        return true;
    }
    return false;
}

