#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace flag;

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xb011b7a, Offset: 0x98
// Size: 0x34
function init_dvar(str_dvar) {
    util::init_dvar(str_dvar, 0, &function_4a18565a);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x4176ea28, Offset: 0xd8
// Size: 0x54
function private function_4a18565a(params) {
    level set_val(params.name, is_true(int(params.value)));
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xfc380833, Offset: 0x138
// Size: 0xc8
function init(str_flag, b_val = 0) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    if (!isdefined(self.var_491938f6)) {
        self.var_491938f6 = [];
    }
    /#
        if (!isdefined(level.first_frame)) {
            assert(!isdefined(self.flag[str_flag]), "<dev string:x38>" + str_flag + "<dev string:x63>");
        }
    #/
    self.flag[str_flag] = b_val;
    self.var_491938f6[str_flag] = 1;
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc66b52bc, Offset: 0x208
// Size: 0x26
function exists(str_flag) {
    return isdefined(self.flag) && isdefined(self.flag[str_flag]);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xae7c1caa, Offset: 0x238
// Size: 0x74
function delete(str_flag) {
    if (isdefined(self.var_491938f6) && isdefined(self.var_491938f6[str_flag])) {
        self.var_491938f6[str_flag] = undefined;
    }
    if (isdefined(self.var_491938f6) && self.var_491938f6.size == 0) {
        self.var_491938f6 = undefined;
    }
    clear(str_flag);
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x0
// Checksum 0xeccb5a3a, Offset: 0x2b8
// Size: 0x34
function delay_set(n_delay, str_flag, str_cancel) {
    self thread _delay_set(n_delay, str_flag, str_cancel);
}

// Namespace flag/flag_shared
// Params 3, eflags: 0x5 linked
// Checksum 0x1148411f, Offset: 0x2f8
// Size: 0x5c
function private _delay_set(n_delay, str_flag, str_cancel) {
    if (isdefined(str_cancel)) {
        self endon(str_cancel);
    }
    self endon(#"death");
    wait n_delay;
    set(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd122e5fa, Offset: 0x360
// Size: 0x60
function set(str_flag) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    self.flag[str_flag] = 1;
    self notify(str_flag);
    if (isdefined(level.var_53af20e)) {
        [[ level.var_53af20e ]](str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xeb8a05ee, Offset: 0x3c8
// Size: 0x6c
function set_val(str_flag, b_val) {
    assert(isdefined(b_val), "<dev string:x73>");
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x566a7aec, Offset: 0x440
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

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xe547bdb6, Offset: 0x4b8
// Size: 0x94
function decrement(str_flag) {
    assert(isdefined(self.flag_count[str_flag]) && self.flag_count[str_flag] > 0, "<dev string:x9f>");
    self.flag_count[str_flag]--;
    if (self.flag_count[str_flag] == 0) {
        clear(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x9eeae1ea, Offset: 0x558
// Size: 0x64
function set_for_time(n_time, str_flag) {
    self notify("__flag::set_for_time__" + str_flag);
    self endon("__flag::set_for_time__" + str_flag);
    set(str_flag);
    wait n_time;
    clear(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xad6fe971, Offset: 0x5c8
// Size: 0xa0
function clear(str_flag) {
    if (is_true(self.flag[str_flag])) {
        if (is_true(self.var_491938f6[str_flag])) {
            self.flag[str_flag] = 0;
        } else {
            self.flag[str_flag] = undefined;
        }
        self notify(str_flag);
        if (isdefined(level.var_53af20e)) {
            [[ level.var_53af20e ]](str_flag);
        }
    }
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x3ad65966, Offset: 0x670
// Size: 0x3c
function toggle(str_flag) {
    set_val(str_flag, !get(str_flag));
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x464adb96, Offset: 0x6b8
// Size: 0x2a
function get(str_flag) {
    return is_true(self.flag[str_flag]);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0xfcaf602a, Offset: 0x6f0
// Size: 0x9a
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
// Checksum 0x650a6, Offset: 0x798
// Size: 0x9a
function get_all(&array) {
    foreach (str_flag in array) {
        if (!get(str_flag)) {
            return false;
        }
    }
    return true;
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd4b8e3c6, Offset: 0x840
// Size: 0x46
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0xe7be5b08, Offset: 0x890
// Size: 0x7c
function wait_till_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xdeaea523, Offset: 0x918
// Size: 0x7a
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
// Checksum 0xb991d6ec, Offset: 0x9a0
// Size: 0x7c
function wait_till_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_all(a_flags);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x879522b7, Offset: 0xa28
// Size: 0xc4
function wait_till_any(a_flags) {
    self endon(#"death");
    foreach (flag in a_flags) {
        if (get(flag)) {
            return {#_notify:flag};
        }
    }
    return self waittill(a_flags);
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x453dff, Offset: 0xaf8
// Size: 0x7c
function wait_till_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_any(a_flags);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x4aae2b8e, Offset: 0xb80
// Size: 0x46
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x10bcc1d8, Offset: 0xbd0
// Size: 0x94
function wait_till_clear_timeout(n_timeout, str_flag) {
    self endon(#"death");
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear(str_flag);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x5d3f75c3, Offset: 0xc70
// Size: 0x7a
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
// Checksum 0x37d8970f, Offset: 0xcf8
// Size: 0x3e2
function function_4bf6d64f(var_5d544245, var_44bd221) {
    self endon(#"death");
    foreach (flag in var_5d544245) {
        if (get(flag)) {
            return {#_notify:flag};
        }
    }
    foreach (flag in var_44bd221) {
        if (!get(flag)) {
            return {#_notify:flag};
        }
    }
    var_b1f5a9d1 = arraycombine(var_5d544245, var_44bd221, 1);
    var_36b86152 = [];
    foreach (flag in var_5d544245) {
        if (!isdefined(var_36b86152)) {
            var_36b86152 = [];
        } else if (!isarray(var_36b86152)) {
            var_36b86152 = array(var_36b86152);
        }
        var_36b86152[var_36b86152.size] = hash(flag);
    }
    var_c50f1f7b = [];
    foreach (flag in var_44bd221) {
        if (!isdefined(var_c50f1f7b)) {
            var_c50f1f7b = [];
        } else if (!isarray(var_c50f1f7b)) {
            var_c50f1f7b = array(var_c50f1f7b);
        }
        var_c50f1f7b[var_c50f1f7b.size] = hash(flag);
    }
    while (true) {
        result = self waittill(var_b1f5a9d1);
        flag = result._notify;
        if (isinarray(var_36b86152, flag) && get(flag)) {
            return {#_notify:flag};
        }
        if (isinarray(var_c50f1f7b, flag) && !get(flag)) {
            return {#_notify:flag};
        }
    }
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x0
// Checksum 0x368fcb8b, Offset: 0x10e8
// Size: 0x104
function function_5f02becb(n_timeout) {
    if (isdefined(n_timeout) && n_timeout > 0) {
        if (isdefined(n_timeout)) {
            __s = spawnstruct();
            __s endon(#"timeout");
            __s util::delay_notify(n_timeout, "timeout");
        }
    }
    if (isdefined(self.script_flag_true)) {
        var_ed5ed076 = util::create_flags_and_return_tokens(self.script_flag_true);
        level wait_till_all(var_ed5ed076);
    }
    if (isdefined(self.script_flag_false)) {
        var_b1418b4 = util::create_flags_and_return_tokens(self.script_flag_false);
        level wait_till_clear_all(var_b1418b4);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0x27fc7c54, Offset: 0x11f8
// Size: 0x7c
function wait_till_clear_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_all(a_flags);
}

// Namespace flag/flag_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x89fe29e4, Offset: 0x1280
// Size: 0xd2
function wait_till_clear_any(a_flags) {
    self endon(#"death");
    while (true) {
        foreach (flag in a_flags) {
            if (!get(flag)) {
                return {#_notify:flag};
            }
        }
        return self waittill(a_flags);
    }
}

// Namespace flag/flag_shared
// Params 2, eflags: 0x0
// Checksum 0xe286a634, Offset: 0x1360
// Size: 0x7c
function wait_till_clear_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_any(a_flags);
}

// Namespace flag/flag_shared
// Params 0, eflags: 0x0
// Checksum 0x54ff0b64, Offset: 0x13e8
// Size: 0x34
function script_flag_wait() {
    if (isdefined(self.script_flag_wait)) {
        self wait_till(self.script_flag_wait);
        return true;
    }
    return false;
}

