#using scripts/core_common/ai_shared;
#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/string_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;

#namespace val;

// Namespace val/values_shared
// Params 0, eflags: 0x2
// Checksum 0x65871f73, Offset: 0x300
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("values", &__init__, undefined, undefined);
}

// Namespace val/values_shared
// Params 0, eflags: 0x0
// Checksum 0xfd540d94, Offset: 0x340
// Size: 0x33c
function __init__() {
    register("takedamage", "$self", &set_takedamage, "$value");
    default_func("takedamage", "$self", &default_takedamage);
    register("allowdeath");
    default_func("allowdeath", undefined, &issentient, "$self");
    register("ignoreme");
    default_value("ignoreme", 0);
    register("ignoreall");
    default_value("ignoreall", 0);
    register("take_weapons", "$self", &set_takeweapons, "$value");
    default_value("take_weapons", 0);
    register("disable_weapons", "$self", &set_disableweapons, "$value");
    default_value("disable_weapons", 0);
    register("freezecontrols", "$self", &freezecontrols, "$value");
    default_value("freezecontrols", 0);
    register("show_hud", "$self", &setclientuivisibilityflag, "hud_visible", "$value");
    default_value("show_hud", 1);
    register("show_weapon_hud", "$self", &setclientuivisibilityflag, "weapon_hud_visible", "$value");
    default_value("show_weapon_hud", 1);
    /#
        level thread debug_values();
        validate("<dev string:x28>", "<dev string:x33>", &validate_takedamage);
        validate("<dev string:x39>", "<dev string:x33>", &arecontrolsfrozen);
    #/
}

// Namespace val/values_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0x46b5aa04, Offset: 0x688
// Size: 0x15e
function register(str_name, call_on, func, ...) {
    if (!isdefined(call_on)) {
        call_on = "$self";
    }
    if (!isdefined(level.values)) {
        level.values = [];
    }
    a_registered = getarraykeys(level.values);
    if (isinarray(a_registered, str_name)) {
        /#
            assertmsg("<dev string:x48>" + str_name + "<dev string:x50>");
        #/
        return;
    }
    s_value = spawnstruct();
    s_value.str_name = str_name;
    s_value.call_on = call_on;
    s_value.func = func;
    s_value.a_args = vararg;
    level.values[str_name] = s_value;
}

// Namespace val/values_shared
// Params 1, eflags: 0x4
// Checksum 0x8b82898b, Offset: 0x7f0
// Size: 0x8c
function private assert_registered(str_name) {
    /#
        a_registered = getarraykeys(level.values);
        if (!isinarray(a_registered, str_name)) {
            /#
                assertmsg("<dev string:x48>" + str_name + "<dev string:x66>");
            #/
            return false;
        }
    #/
    return true;
}

// Namespace val/values_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0x4e7861f, Offset: 0x888
// Size: 0x98
function default_func(str_name, call_on, value, ...) {
    if (assert_registered(str_name)) {
        s_value = level.values[str_name];
        s_value.default_call_on = call_on;
        s_value.default_value = value;
        s_value.default_args = vararg;
    }
}

// Namespace val/values_shared
// Params 2, eflags: 0x0
// Checksum 0xb3a66661, Offset: 0x928
// Size: 0x60
function default_value(str_name, value) {
    if (assert_registered(str_name)) {
        s_value = level.values[str_name];
        s_value.default_value = value;
    }
}

// Namespace val/values_shared
// Params 3, eflags: 0x0
// Checksum 0x75a8b39f, Offset: 0x990
// Size: 0x6c
function set(str_id, str_name, value) {
    if (assert_registered(str_name)) {
        _push_value(str_id, str_name, value);
        _set_value(str_name, value);
    }
}

// Namespace val/values_shared
// Params 4, eflags: 0x0
// Checksum 0x2352b306, Offset: 0xa08
// Size: 0x6c
function set_for_time(n_time, str_id, str_name, value) {
    self endon(#"death");
    set(str_id, str_name, value);
    wait n_time;
    reset(str_id, str_name);
}

// Namespace val/values_shared
// Params 2, eflags: 0x0
// Checksum 0x60b382c2, Offset: 0xa80
// Size: 0xac
function reset(str_id, str_name) {
    n_index = _remove_value(str_id, str_name);
    if (!n_index) {
        var_2176e2af = function_d8ee9d0d(str_name);
        if (var_2176e2af.size > 0) {
            _set_value(str_name, var_2176e2af[0].value);
            return;
        }
        _set_default(str_name);
    }
}

// Namespace val/values_shared
// Params 1, eflags: 0x4
// Checksum 0x50a052fd, Offset: 0xb38
// Size: 0x60
function private function_d8ee9d0d(str_name) {
    if (!isdefined(self.values)) {
        self.values = [];
    }
    if (!isdefined(self.values[str_name])) {
        self.values[str_name] = [];
    }
    return self.values[str_name];
}

// Namespace val/values_shared
// Params 3, eflags: 0x4
// Checksum 0x3fe3c20b, Offset: 0xba0
// Size: 0xa4
function private _push_value(str_id, str_name, value) {
    _remove_value(str_id, str_name);
    s_value = spawnstruct();
    s_value.str_id = str_id;
    s_value.value = value;
    arrayinsert(function_d8ee9d0d(str_name), s_value, 0);
}

// Namespace val/values_shared
// Params 2, eflags: 0x4
// Checksum 0xb8803248, Offset: 0xc50
// Size: 0xa6
function private _remove_value(str_id, str_name) {
    var_2176e2af = function_d8ee9d0d(str_name);
    for (n_index = var_2176e2af.size - 1; n_index >= 0; n_index--) {
        if (var_2176e2af[n_index].str_id == str_id) {
            arrayremoveindex(var_2176e2af, n_index);
            break;
        }
    }
    return n_index;
}

// Namespace val/values_shared
// Params 2, eflags: 0x4
// Checksum 0xfa81482a, Offset: 0xd00
// Size: 0xe8
function private _set_value(str_name, value) {
    s_value = level.values[str_name];
    if (isdefined(s_value) && isdefined(s_value.func)) {
        call_on = s_value.call_on === "$self" ? self : s_value.call_on;
        util::single_func_argarray(call_on, s_value.func, _replace_values(s_value.a_args, value));
        return;
    }
    self.(str_name) = value;
}

// Namespace val/values_shared
// Params 1, eflags: 0x4
// Checksum 0x52e292d5, Offset: 0xdf0
// Size: 0x11c
function private _set_default(str_name) {
    s_value = level.values[str_name];
    if (isdefined(s_value.default_value)) {
        if (isfunctionptr(s_value.default_value)) {
            call_on = s_value.default_call_on === "$self" ? self : s_value.default_call_on;
            default_value = util::single_func_argarray(call_on, s_value.default_value, _replace_values(s_value.default_args));
        } else {
            default_value = s_value.default_value;
        }
        _set_value(str_name, default_value);
    }
}

// Namespace val/values_shared
// Params 2, eflags: 0x4
// Checksum 0xe973f4e1, Offset: 0xf18
// Size: 0x6c
function private _replace_values(a_args, value) {
    a_args = array::replace(a_args, "$self", self);
    if (isdefined(value)) {
        a_args = array::replace(a_args, "$value", value);
    }
    return a_args;
}

// Namespace val/values_shared
// Params 1, eflags: 0x4
// Checksum 0x38ca6248, Offset: 0xf90
// Size: 0x80
function private set_takedamage(b_value) {
    if (!isdefined(b_value)) {
        b_value = 1;
    }
    if (isplayer(self)) {
        if (b_value) {
            self disableinvulnerability();
        } else {
            self enableinvulnerability();
        }
        return;
    }
    self.takedamage = b_value;
}

// Namespace val/values_shared
// Params 0, eflags: 0x0
// Checksum 0xc2dfc6b0, Offset: 0x1018
// Size: 0x32
function default_takedamage() {
    return issentient(self) || isvehicle(self);
}

// Namespace val/values_shared
// Params 0, eflags: 0x4
// Checksum 0x3f0b381, Offset: 0x1058
// Size: 0x44
function private validate_takedamage() {
    if (isplayer(self)) {
        return !self getinvulnerability();
    }
    return self.takedamage;
}

// Namespace val/values_shared
// Params 1, eflags: 0x4
// Checksum 0xb48e3126, Offset: 0x10a8
// Size: 0xd4
function private set_takeweapons(b_value) {
    if (!isdefined(b_value)) {
        b_value = 1;
    }
    if (b_value) {
        if (!(isdefined(self.gun_removed) && self.gun_removed)) {
            if (isplayer(self)) {
                self player::take_weapons();
            } else {
                self animation::detach_weapon();
            }
        }
        return;
    }
    if (isplayer(self)) {
        self player::give_back_weapons();
        return;
    }
    self animation::attach_weapon();
}

// Namespace val/values_shared
// Params 1, eflags: 0x4
// Checksum 0x4ffe8f6e, Offset: 0x1188
// Size: 0x54
function private set_disableweapons(b_value) {
    if (!isdefined(b_value)) {
        b_value = 1;
    }
    if (b_value) {
        self disableweapons();
        return;
    }
    self enableweapons();
}

/#

    // Namespace val/values_shared
    // Params 4, eflags: 0x24 variadic
    // Checksum 0xb7514019, Offset: 0x11e8
    // Size: 0x10c
    function private validate(str_name, call_on, func, ...) {
        a_registered = getarraykeys(level.values);
        if (!isinarray(a_registered, str_name)) {
            /#
                assertmsg("<dev string:x48>" + str_name + "<dev string:x66>");
            #/
            return;
        }
        s_value = level.values[str_name];
        s_value.b_validate = 1;
        s_value.func_validate = func;
        s_value.validate_call_on = call_on;
        s_value.validate_args = vararg;
    }

    // Namespace val/values_shared
    // Params 3, eflags: 0x4
    // Checksum 0xff9af331, Offset: 0x1300
    // Size: 0x17a
    function private _validate_value(str_name, value, b_assert) {
        if (!isdefined(b_assert)) {
            b_assert = 0;
        }
        s_value = level.values[str_name];
        if (isdefined(s_value.func_validate)) {
            call_on = s_value.validate_call_on === "<dev string:x33>" ? self : s_value.validate_call_on;
            current_value = util::single_func_argarray(call_on, s_value.func_validate, _replace_values(s_value.validate_args));
        } else {
            current_value = self.(str_name);
        }
        b_match = current_value === value;
        if (b_assert) {
            /#
                assert(b_match, "<dev string:x78>" + str_name + "<dev string:x8b>" + current_value + "<dev string:x92>" + value + "<dev string:xa4>");
            #/
        }
        return b_match;
    }

    // Namespace val/values_shared
    // Params 0, eflags: 0x4
    // Checksum 0x4c6ae185, Offset: 0x1488
    // Size: 0x4d0
    function private debug_values() {
        level flagsys::init_dvar("<dev string:xa7>");
        level flagsys::wait_till("<dev string:xb8>");
        while (true) {
            level flagsys::wait_till("<dev string:xa7>");
            str_debug_values_entity = getdvarstring("<dev string:xcc>", "<dev string:xe4>");
            if (str_debug_values_entity == "<dev string:xe4>" || str_debug_values_entity == "<dev string:xe5>" || str_debug_values_entity == "<dev string:xe8>") {
                hud_ent = level.host;
                str_label = "<dev string:xed>";
            } else if (strisnumber(str_debug_values_entity)) {
                hud_ent = getentbynum(int(str_debug_values_entity));
                str_label = "<dev string:xf9>" + str_debug_values_entity;
            } else {
                str_value = str_debug_values_entity;
                str_key = "<dev string:x101>";
                if (issubstr(str_value, "<dev string:x10c>")) {
                    a_toks = strtok(str_value, "<dev string:x10c>");
                    str_value = a_toks[0];
                    str_key = a_toks[1];
                }
                hud_ent = getent(str_value, str_key, 1);
                str_label = str_value + "<dev string:x10c>" + str_key;
            }
            debug2dtext((200, 100, 0), str_label, (1, 1, 1), 1, (0, 0, 0), 0.5, 0.8, 1);
            if (!isdefined(hud_ent) || !isdefined(hud_ent.values)) {
                waitframe(1);
                continue;
            }
            a_all_ents = getentarray();
            foreach (ent in a_all_ents) {
                if (isdefined(ent.values)) {
                    i = 1;
                    foreach (str_name, a_value in ent.values) {
                        top_value = a_value[0];
                        if (isdefined(top_value)) {
                            b_valid = 1;
                            if (isdefined(level.values[str_name].b_validate) && level.values[str_name].b_validate) {
                                b_assert = getdvarint("<dev string:xa7>") > 1;
                                b_valid = hud_ent _validate_value(str_name, top_value.value, b_assert);
                            }
                            ent display_value(i, str_name, top_value.str_id, top_value.value, b_valid, ent == hud_ent);
                            i++;
                        }
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace val/values_shared
    // Params 6, eflags: 0x0
    // Checksum 0x44af668a, Offset: 0x1960
    // Size: 0x1dc
    function display_value(index, str_name, str_id, value, b_valid, on_hud) {
        if (!isdefined(on_hud)) {
            on_hud = 0;
        }
        str_value = "<dev string:xe4>";
        if ((isdefined(str_name) ? "<dev string:xe4>" + str_name : "<dev string:xe4>") != "<dev string:xe4>") {
            str_value = string::rjust(str_name, 20) + "<dev string:x10e>" + (isdefined(value) ? "<dev string:xe4>" + value : "<dev string:xe4>") + "<dev string:x112>" + string::ljust(isdefined(str_id) ? "<dev string:xe4>" + str_id : "<dev string:xe4>", 30);
        }
        color = b_valid ? (1, 1, 1) : (1, 0, 0);
        if (on_hud) {
            debug2dtext((200, 100 + index * 20, 0), str_value, color, 1, (0, 0, 0), 0.5, 0.8, 1);
        }
        print3d(self.origin - (0, 0, index * 8), str_value, color, 1, 0.3, 1);
    }

#/
