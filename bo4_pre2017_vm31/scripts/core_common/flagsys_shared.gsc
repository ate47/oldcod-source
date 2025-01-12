#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace flagsys;

// Namespace flagsys/flagsys_shared
// Params 0, eflags: 0x2
// Checksum 0x5591e413, Offset: 0xf0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("flagsys", &__init__, undefined, undefined);
}

// Namespace flagsys/flagsys_shared
// Params 0, eflags: 0x0
// Checksum 0xb7815f22, Offset: 0x130
// Size: 0x1c
function __init__() {
    level thread update_flag_dvars();
}

// Namespace flagsys/flagsys_shared
// Params 0, eflags: 0x0
// Checksum 0xdcfd5a37, Offset: 0x158
// Size: 0xe0
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
// Checksum 0x769a92f8, Offset: 0x240
// Size: 0xbe
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
// Checksum 0x6e4d0ee9, Offset: 0x308
// Size: 0x48
function set(str_flag) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    self.flag[str_flag] = 1;
    self notify(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x388a2690, Offset: 0x358
// Size: 0x7c
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
// Checksum 0x40ccee74, Offset: 0x3e0
// Size: 0xa4
function decrement(str_flag) {
    assert(isdefined(self.flag_count) && isdefined(self.flag_count[str_flag]) && self.flag_count[str_flag] > 0, "<dev string:x28>");
    self.flag_count[str_flag]--;
    if (self.flag_count[str_flag] == 0) {
        clear(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x278e4ace, Offset: 0x490
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
// Checksum 0x780de9b9, Offset: 0x510
// Size: 0x5e
function clear(str_flag) {
    if (isdefined(self.flag[str_flag]) && isdefined(self.flag) && self.flag[str_flag]) {
        self.flag[str_flag] = undefined;
        self notify(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x2cf67a6f, Offset: 0x578
// Size: 0x74
function set_val(str_flag, b_val) {
    assert(isdefined(b_val), "<dev string:x65>");
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0xfde7522, Offset: 0x5f8
// Size: 0x34
function toggle(str_flag) {
    set(!get(str_flag));
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x5bdcbb49, Offset: 0x638
// Size: 0x40
function get(str_flag) {
    return isdefined(self.flag[str_flag]) && isdefined(self.flag) && self.flag[str_flag];
}

// Namespace flagsys/flagsys_shared
// Params 1, eflags: 0x0
// Checksum 0x934a14c2, Offset: 0x680
// Size: 0x3e
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x80d3d5f1, Offset: 0x6c8
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
// Checksum 0x48691819, Offset: 0x758
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
// Checksum 0x56371078, Offset: 0x7e8
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
// Checksum 0xd7d2ef87, Offset: 0x878
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
// Checksum 0xff5a5c2b, Offset: 0x930
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
// Checksum 0x5555976c, Offset: 0x9c0
// Size: 0x3e
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys/flagsys_shared
// Params 2, eflags: 0x0
// Checksum 0x5c163dba, Offset: 0xa08
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
// Checksum 0x7ca91173, Offset: 0xa98
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
// Checksum 0xe284345a, Offset: 0xb28
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
// Checksum 0x66991a8f, Offset: 0xbb8
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
// Checksum 0xe04d83d5, Offset: 0xc80
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
// Checksum 0x8f84e646, Offset: 0xd10
// Size: 0x24
function delete(str_flag) {
    clear(str_flag);
}

// Namespace flagsys/flagsys_shared
// Params 0, eflags: 0x0
// Checksum 0xae171191, Offset: 0xd40
// Size: 0x3c
function script_flag_wait() {
    if (isdefined(self.script_flag_wait)) {
        self wait_till(self.script_flag_wait);
        return true;
    }
    return false;
}

