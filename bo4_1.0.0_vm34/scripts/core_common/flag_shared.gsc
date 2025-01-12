#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace flag;

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x31a97022, Offset: 0x98
// Size: 0xce
function init(str_flag, b_val = 0) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    if (!isdefined(self.flag_count)) {
        self.flag_count = [];
    }
    /#
        if (!isdefined(level.first_frame)) {
            assert(!isdefined(self.flag[str_flag]), "<dev string:x30>" + str_flag + "<dev string:x58>");
        }
    #/
    self.flag[str_flag] = b_val;
    self.flag_count[str_flag] = 0;
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xdbf6b534, Offset: 0x170
// Size: 0x28
function exists(str_flag) {
    return isdefined(self.flag) && isdefined(self.flag[str_flag]);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xd15111db, Offset: 0x1a0
// Size: 0x7c
function set(str_flag) {
    assert(exists(str_flag), "<dev string:x65>" + str_flag + "<dev string:x80>");
    self.flag[str_flag] = 1;
    self notify(str_flag);
    trigger::set_flag_permissions(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x7a7b92b0, Offset: 0x228
// Size: 0x74
function increment(str_flag) {
    assert(exists(str_flag), "<dev string:x9a>" + str_flag + "<dev string:x80>");
    self.flag_count[str_flag]++;
    set(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x2c3289ea, Offset: 0x2a8
// Size: 0xbc
function decrement(str_flag) {
    assert(exists(str_flag), "<dev string:xbb>" + str_flag + "<dev string:x80>");
    assert(self.flag_count[str_flag] > 0, "<dev string:xdc>");
    self.flag_count[str_flag]--;
    if (self.flag_count[str_flag] == 0) {
        clear(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0xf45fff78, Offset: 0x370
// Size: 0x3c
function delay_set(n_delay, str_flag, str_cancel) {
    self thread _delay_set(n_delay, str_flag, str_cancel);
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0x866c0cd3, Offset: 0x3b8
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
// Checksum 0xd4381b4d, Offset: 0x420
// Size: 0x6c
function set_val(str_flag, b_val) {
    assert(isdefined(b_val), "<dev string:x119>");
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0xa36036bb, Offset: 0x498
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
// Checksum 0xa4018f4c, Offset: 0x508
// Size: 0x8c
function clear(str_flag) {
    assert(exists(str_flag), "<dev string:x145>" + str_flag + "<dev string:x80>");
    if (self.flag[str_flag]) {
        self.flag[str_flag] = 0;
        self notify(str_flag);
        trigger::set_flag_permissions(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x63a5a4de, Offset: 0x5a0
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
// Checksum 0x3573de2e, Offset: 0x600
// Size: 0x58
function get(str_flag) {
    assert(exists(str_flag), "<dev string:x162>" + str_flag + "<dev string:x80>");
    return self.flag[str_flag];
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x9d626f4e, Offset: 0x660
// Size: 0x8a
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
// Checksum 0xc5f37642, Offset: 0x6f8
// Size: 0x8a
function get_all(&array) {
    foreach (str_flag in array) {
        if (!get(str_flag)) {
            return false;
        }
    }
    return true;
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x69930a4c, Offset: 0x790
// Size: 0x46
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x8af259c7, Offset: 0x7e0
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
// Checksum 0x1eb84f7, Offset: 0x870
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
// Checksum 0xffa10c74, Offset: 0x900
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
// Checksum 0x89363e00, Offset: 0x990
// Size: 0xa2
function wait_till_any(a_flags) {
    self endon(#"death");
    foreach (flag in a_flags) {
        if (get(flag)) {
            return flag;
        }
    }
    return self waittill(a_flags);
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x69dbc3b5, Offset: 0xa40
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
// Checksum 0xd06e5c12, Offset: 0xad0
// Size: 0x46
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x3b5194ea, Offset: 0xb20
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
// Checksum 0x3c7af1f6, Offset: 0xbb0
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
// Params 1, eflags: 0x0
// Checksum 0xb45dc295, Offset: 0xc40
// Size: 0x10c
function function_6814c108(n_timeout) {
    if (isdefined(n_timeout) && n_timeout > 0) {
        if (isdefined(n_timeout)) {
            __s = spawnstruct();
            __s endon(#"timeout");
            __s util::delay_notify(n_timeout, "timeout");
        }
    }
    if (isdefined(self.script_flag_true)) {
        var_33eb1eb1 = util::create_flags_and_return_tokens(self.script_flag_true);
        level wait_till_all(var_33eb1eb1);
    }
    if (isdefined(self.script_flag_false)) {
        var_a09190c2 = util::create_flags_and_return_tokens(self.script_flag_false);
        level wait_till_clear_all(var_a09190c2);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x4dace9d7, Offset: 0xd58
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
// Checksum 0x947131e0, Offset: 0xde8
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
// Checksum 0xb5a54f06, Offset: 0xea0
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
// Checksum 0xcb4de503, Offset: 0xf30
// Size: 0x54
function delete(str_flag) {
    if (isdefined(self.flag[str_flag])) {
        self.flag[str_flag] = undefined;
        return;
    }
    println("<dev string:x176>" + str_flag);
}

// Namespace flag/flag_shared
// Params 0, eflags: 0x0
// Checksum 0x7e9a70e4, Offset: 0xf90
// Size: 0x34
function script_flag_wait() {
    if (isdefined(self.script_flag_wait)) {
        self wait_till(self.script_flag_wait);
        return true;
    }
    return false;
}

