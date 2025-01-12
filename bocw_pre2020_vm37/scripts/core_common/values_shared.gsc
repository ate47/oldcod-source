#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\string_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace val;

// Namespace val/values_shared
// Params 0, eflags: 0x6
// Checksum 0x3ef40543, Offset: 0x400
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"values", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace val/values_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xd956df0e, Offset: 0x448
// Size: 0xfa4
function private function_70a657d8() {
    register("takedamage", 1, "$self", &set_takedamage, "$value");
    default_func("takedamage", "$self", &default_takedamage);
    register("allowdeath", 1, "$self", &set_allowdeath, "$value");
    default_func("allowdeath", "$self", &default_allowdeath);
    register("magic_bullet_shield", 1, "$self", &function_87a1ac43, "$value");
    default_func("magic_bullet_shield", "$self", &function_aac507e5);
    link("magic_bullet_shield", "allowdeath", &function_49321c2b);
    link("magic_bullet_shield", "attackeraccuracy", &function_25ef3fee);
    register("attackeraccuracy", 1);
    default_value("attackeraccuracy", 1);
    register("ignoreme", 1, "$self", &set_ignoreme, "$value");
    default_value("ignoreme", 0);
    register("ignoreall", 1, "$self", &set_ignoreall, "$value");
    default_value("ignoreall", 0);
    register("take_weapons", 1, "$self", &set_takeweapons, "$value");
    default_value("take_weapons", 0);
    register("disable_weapons", 1, "$self", &set_disableweapons, "$value");
    default_value("disable_weapons", 0);
    register("disable_weapon_cycling", 1, "$self", &function_f609f22c, "$value");
    default_value("disable_weapon_cycling", 0);
    register("disable_weapon_reload", 1, "$self", &function_debe5863, "$value");
    default_value("disable_weapon_reload", 0);
    register("disable_weapon_pickup", 1, "$self", &function_15d061e0, "$value");
    default_value("disable_weapon_pickup", 0);
    register("disable_weapon_fire", 1, "$self", &function_16f5ac8e, "$value");
    default_value("disable_weapon_fire", 0);
    register("disable_offhand_weapons", 1, "$self", &set_disableoffhandweapons, "$value");
    default_value("disable_offhand_weapons", 0);
    register("disable_offhand_special", 1, "$self", &function_37c7ffcd, "$value");
    default_value("disable_offhand_special", 0);
    register("disable_usability", 1, "$self", &function_737c794, "$value");
    default_value("disable_usability", 0);
    register("freezecontrols", 1, "$self", &freezecontrols, "$value");
    default_value("freezecontrols", 0);
    register("freezecontrols_allowlook", 1, "$self", &freezecontrolsallowlook, "$value");
    default_value("freezecontrols_allowlook", 0);
    register("disablegadgets", 1, "$self", &gadgetsdisabled, "$value");
    default_value("disablegadgets", 0);
    register("hide", 1, "$self", &set_hide, "$value");
    default_value("hide", 0);
    register("health_regen", 1, "$self", &set_health_regen, "$value");
    default_value("health_regen", 1);
    register("disable_health_regen_delay", 1, "$self", &set_disable_health_regen_delay, "$value");
    default_value("disable_health_regen_delay", 0);
    register("ignore_health_regen_delay", 1, "$self", &set_ignore_health_regen_delay, "$value");
    default_value("ignore_health_regen_delay", 0);
    register("show_hud", 1, "$self", &setclientuivisibilityflag, "hud_visible", "$value");
    default_value("show_hud", 1);
    register("show_weapon_hud", 1, "$self", &setclientuivisibilityflag, "weapon_hud_visible", "$value");
    default_value("show_weapon_hud", 1);
    register("show_crosshair", 1, "$self", &function_e0c7d69, "$value");
    default_value("show_crosshair", 1);
    register("disable_gestures", 1, "$self", &set_disablegestures, "$value");
    default_value("disable_gestures", 0);
    register("allow_jump", 1, "$self", &allowjump, "$value");
    default_value("allow_jump", 1);
    register("allow_double_jump", 1, "$self", &allowdoublejump, "$value");
    default_value("allow_double_jump", 1);
    register("allow_crouch", 1, "$self", &allowcrouch, "$value");
    default_value("allow_crouch", 1);
    register("allow_prone", 1, "$self", &allowprone, "$value");
    default_value("allow_prone", 1);
    register("allow_melee", 1, "$self", &allowmelee, "$value");
    default_value("allow_melee", 1);
    register("allow_melee_victim", 1, "$self", &allow_melee_victim, "$value");
    default_value("allow_melee_victim", 1);
    register("allow_climb", 1, "$self", &function_4f1b1444, "$value");
    default_value("allow_climb", 1);
    register("allow_mantle", 1, "$self", &allowmantle, "$value");
    default_value("allow_mantle", 1);
    register("allow_sprint", 1, "$self", &allowsprint, "$value");
    default_value("allow_sprint", 1);
    register("allow_ads", 1, "$self", &allowads, "$value");
    default_value("allow_ads", 1);
    register("allow_stand", 1, "$self", &allowstand, "$value");
    default_value("allow_stand", 1);
    register("low_ready", 1, "$self", &setlowready, "$value");
    default_value("low_ready", 0);
    register("goalradius", 2048, "$self", &set_goal_radius, "$value");
    default_value("goalradius", 2048);
    register("push_player", 1, "$self", &pushplayer, "$value");
    default_value("push_player", 0);
    register("pre_load_ghost", 1, "$self", &function_2be6e08d, "$value");
    default_value("pre_load_ghost", 0);
    register("skip_death", 1, "$self", &function_2d53d03d, "$value");
    default_value("skip_death", 0);
    register("skip_scene_death", 1, "$self", &function_2014cd50, "$value");
    default_value("skip_scene_death", 0);
    /#
        level thread debug_values();
        validate("<dev string:x38>", "<dev string:x46>", &validate_takedamage);
        validate("<dev string:x4f>", "<dev string:x46>", &arecontrolsfrozen);
        validate("<dev string:x61>", "<dev string:x46>", &function_5972c3cf);
        validate("<dev string:x7d>", "<dev string:x46>", &gadgetsdisabled);
        validate("<dev string:x8f>", "<dev string:x46>", &ishidden);
    #/
}

// Namespace val/values_shared
// Params 5, eflags: 0x21 linked variadic
// Checksum 0x25417e5, Offset: 0x13f8
// Size: 0x140
function register(str_name, var_3509ed3e, call_on = "$self", func, ...) {
    if (!isdefined(level.values)) {
        level.values = [];
    }
    a_registered = getarraykeys(level.values);
    if (isinarray(a_registered, hash(str_name))) {
        assertmsg("<dev string:x97>" + str_name + "<dev string:xa2>");
        return;
    }
    s_value = spawnstruct();
    s_value.str_name = str_name;
    s_value.call_on = call_on;
    s_value.func = func;
    s_value.var_3509ed3e = var_3509ed3e;
    s_value.a_args = vararg;
    level.values[str_name] = s_value;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xdefe8219, Offset: 0x1540
// Size: 0x94
function private assert_registered(str_name) {
    /#
        a_registered = getarraykeys(level.values);
        if (!isinarray(a_registered, hash(str_name))) {
            assertmsg("<dev string:x97>" + str_name + "<dev string:xbb>");
            return false;
        }
    #/
    return true;
}

// Namespace val/values_shared
// Params 4, eflags: 0x21 linked variadic
// Checksum 0x4cc7fa26, Offset: 0x15e0
// Size: 0x7e
function default_func(str_name, call_on, value, ...) {
    if (assert_registered(str_name)) {
        s_value = level.values[str_name];
        s_value.default_call_on = call_on;
        s_value.default_value = value;
        s_value.default_args = vararg;
    }
}

// Namespace val/values_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x32af04c3, Offset: 0x1668
// Size: 0x56
function default_value(str_name, value) {
    if (assert_registered(str_name)) {
        s_value = level.values[str_name];
        s_value.default_value = value;
    }
}

// Namespace val/values_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x139cbd82, Offset: 0x16c8
// Size: 0x84
function link(str_name, var_8e7e7e96, func) {
    if (assert_registered(str_name)) {
        s_value = level.values[str_name];
        s_value.links[var_8e7e7e96] = {#name:var_8e7e7e96, #func:func};
    }
}

// Namespace val/values_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x61d373d, Offset: 0x1758
// Size: 0x158
function set(str_id, str_name, value) {
    if (assert_registered(str_name)) {
        if (!isdefined(value)) {
            value = level.values[str_name].var_3509ed3e;
        }
        _push_value(str_id, str_name, value);
        _set_value(str_name, value);
    }
    if (isarray(level.values[str_name].links)) {
        foreach (var_3c691af1 in level.values[str_name].links) {
            set(str_id, var_3c691af1.name, [[ var_3c691af1.func ]](value));
        }
    }
}

// Namespace val/values_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x400fec17, Offset: 0x18b8
// Size: 0x3c
function function_3e65ae71(str_name, value) {
    set(#"radiant", str_name, value);
}

// Namespace val/values_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x19a8ad00, Offset: 0x1900
// Size: 0x74
function set_for_time(n_time, str_id, str_name, value) {
    self endon(#"death");
    set(str_id, str_name, value);
    wait n_time;
    reset(str_id, str_name);
}

// Namespace val/values_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x9457387b, Offset: 0x1980
// Size: 0x178
function reset(str_id, str_name) {
    n_index = _remove_value(str_id, str_name);
    if (!n_index) {
        if (isdefined(self.values[str_name]) && self.values[str_name].size > 0) {
            _set_value(str_name, self.values[str_name][0].value);
        } else {
            _set_default(str_name);
        }
    }
    if (isarray(level.values[str_name].links)) {
        foreach (var_3c691af1 in level.values[str_name].links) {
            reset(str_id, var_3c691af1.name);
        }
    }
}

// Namespace val/values_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xde5f5aad, Offset: 0x1b00
// Size: 0x144
function function_e681e68e(str_id) {
    if (!isdefined(self.values)) {
        return;
    }
    var_bb7c988d = arraycopy(self.values);
    foreach (var_629dd807, var_ae0593af in var_bb7c988d) {
        foreach (state in var_ae0593af) {
            if (state.str_id === str_id) {
                self reset(str_id, var_629dd807);
            }
        }
    }
}

// Namespace val/values_shared
// Params 1, eflags: 0x0
// Checksum 0x7824aa8a, Offset: 0x1c50
// Size: 0x2c
function function_ade0d537(str_name) {
    reset(#"radiant", str_name);
}

// Namespace val/values_shared
// Params 1, eflags: 0x0
// Checksum 0xe472ce67, Offset: 0x1c88
// Size: 0x34
function nuke(str_name) {
    self.values[str_name] = [];
    _set_default(str_name);
}

// Namespace val/values_shared
// Params 3, eflags: 0x5 linked
// Checksum 0xcf0f3beb, Offset: 0x1cc8
// Size: 0xbc
function private _push_value(str_id, str_name, value) {
    _remove_value(str_id, str_name);
    if (!isdefined(self.values)) {
        self.values = [];
    }
    if (!isdefined(self.values[str_name])) {
        self.values[str_name] = [];
    }
    arrayinsert(self.values[str_name], {#str_id:str_id, #value:value}, 0);
}

// Namespace val/values_shared
// Params 2, eflags: 0x5 linked
// Checksum 0x8ce8a2cd, Offset: 0x1d90
// Size: 0x10a
function private _remove_value(str_id, str_name) {
    if (!isdefined(self)) {
        return -1;
    }
    if (isdefined(self.values) && isdefined(self.values[str_name])) {
        for (n_index = self.values[str_name].size - 1; n_index >= 0; n_index--) {
            if (self.values[str_name][n_index].str_id == str_id) {
                arrayremoveindex(self.values[str_name], n_index);
                break;
            }
        }
        if (!self.values[str_name].size) {
            self.values[str_name] = undefined;
            if (!self.values.size) {
                self.values = undefined;
            }
        }
    }
    return isdefined(n_index) ? n_index : -1;
}

// Namespace val/values_shared
// Params 2, eflags: 0x5 linked
// Checksum 0x9c9db415, Offset: 0x1ea8
// Size: 0xc8
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
// Params 1, eflags: 0x5 linked
// Checksum 0x9669224b, Offset: 0x1f78
// Size: 0xec
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
// Params 2, eflags: 0x5 linked
// Checksum 0xbc995488, Offset: 0x2070
// Size: 0x5a
function private _replace_values(a_args, value) {
    a_args = array::replace(a_args, "$self", self);
    a_args = array::replace(a_args, "$value", value);
    return a_args;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x73e33008, Offset: 0x20d8
// Size: 0x7e
function private set_takedamage(b_value = 1) {
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
// Params 0, eflags: 0x5 linked
// Checksum 0x54a548c0, Offset: 0x2160
// Size: 0x34
function private default_takedamage() {
    return issentient(self) || isvehicle(self);
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xf572e7a6, Offset: 0x21a0
// Size: 0x2a
function private set_allowdeath(b_value = 1) {
    self.allowdeath = b_value;
}

// Namespace val/values_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x7f60fe59, Offset: 0x21d8
// Size: 0x34
function private default_allowdeath() {
    return issentient(self) || isvehicle(self);
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xb1eca677, Offset: 0x2218
// Size: 0x5c
function private function_87a1ac43(b_value = 1) {
    self.magic_bullet_shield = b_value;
    if (isactor(self)) {
        self bloodimpact("hero");
    }
}

// Namespace val/values_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x13a2490e, Offset: 0x2280
// Size: 0x44
function private function_aac507e5() {
    self.magic_bullet_shield = undefined;
    if (isactor(self)) {
        self bloodimpact("normal");
    }
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xe9f08a74, Offset: 0x22d0
// Size: 0x12
function private function_49321c2b(var_110b9b81) {
    return !var_110b9b81;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x77e5221b, Offset: 0x22f0
// Size: 0x22
function private function_25ef3fee(var_110b9b81) {
    return var_110b9b81 ? 0.1 : 1;
}

// Namespace val/values_shared
// Params 0, eflags: 0x4
// Checksum 0xb1a39636, Offset: 0x2320
// Size: 0x44
function private validate_takedamage() {
    if (isplayer(self)) {
        return !self getinvulnerability();
    }
    return self.takedamage;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x4430ab1f, Offset: 0x2370
// Size: 0xcc
function private set_takeweapons(b_value = 1) {
    if (b_value) {
        if (!is_true(self.gun_removed)) {
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
// Params 1, eflags: 0x5 linked
// Checksum 0xe28c26c9, Offset: 0x2448
// Size: 0x6c
function private set_disableweapons(value = 1) {
    if (value != 0) {
        self disableweapons(value === 2 ? 1 : 0);
        return;
    }
    self enableweapons();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x55284a55, Offset: 0x24c0
// Size: 0x54
function private function_f609f22c(b_value = 1) {
    if (b_value) {
        self disableweaponcycling();
        return;
    }
    self enableweaponcycling();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xc48fba27, Offset: 0x2520
// Size: 0x54
function private function_16f5ac8e(b_value = 1) {
    if (b_value) {
        self disableweaponfire();
        return;
    }
    self enableweaponfire();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xe89d05e4, Offset: 0x2580
// Size: 0x54
function private function_debe5863(b_value = 1) {
    if (b_value) {
        self function_205350ab();
        return;
    }
    self function_6e1804bd();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x1bc4a19d, Offset: 0x25e0
// Size: 0x54
function private function_15d061e0(b_value = 1) {
    if (b_value) {
        self disableweaponpickup();
        return;
    }
    self enableweaponpickup();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x1d06404, Offset: 0x2640
// Size: 0x54
function private set_disableoffhandweapons(b_value = 1) {
    if (b_value) {
        self disableoffhandweapons();
        return;
    }
    self enableoffhandweapons();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xff4f8f63, Offset: 0x26a0
// Size: 0x54
function private function_37c7ffcd(b_value = 1) {
    if (b_value) {
        self disableoffhandspecial();
        return;
    }
    self enableoffhandspecial();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x8cd37399, Offset: 0x2700
// Size: 0x54
function private function_737c794(b_value = 1) {
    if (b_value) {
        self disableusability();
        return;
    }
    self enableusability();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xd7219aac, Offset: 0x2760
// Size: 0x52
function private set_ignoreme(b_value = 1) {
    if (function_ffa5b184(self)) {
        self.var_becd4d91 = b_value;
        return;
    }
    self.ignoreme = b_value;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xe43b4974, Offset: 0x27c0
// Size: 0x2a
function private set_ignoreall(b_value = 1) {
    self.ignoreall = b_value;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xdde70fd4, Offset: 0x27f8
// Size: 0x42
function private set_disablegestures(b_value = 1) {
    if (isplayer(self)) {
        self.disablegestures = b_value;
    }
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x709b3182, Offset: 0x2848
// Size: 0x74
function private set_hide(b_value = 1) {
    if (b_value) {
        if (b_value == 1) {
            self hide();
        } else {
            self ghost();
        }
        return;
    }
    self show();
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x3faa08a9, Offset: 0x28c8
// Size: 0x4a
function private set_health_regen(b_value = 1) {
    if (b_value) {
        self.heal.enabled = 1;
        return;
    }
    self.heal.enabled = 0;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xd214864c, Offset: 0x2920
// Size: 0x42
function private set_disable_health_regen_delay(b_value = 1) {
    if (b_value) {
        self.disable_health_regen_delay = 1;
        return;
    }
    self.disable_health_regen_delay = 0;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xb4c38383, Offset: 0x2970
// Size: 0x42
function private set_ignore_health_regen_delay(b_value = 1) {
    if (b_value) {
        self.ignore_health_regen_delay = 1;
        return;
    }
    self.ignore_health_regen_delay = 0;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x455dafbf, Offset: 0x29c0
// Size: 0xa2
function private set_goal_radius(val) {
    if (isdefined(val)) {
        self.goalradius = val;
        return;
    }
    if (isdefined(self.radius)) {
        self.goalradius = float(self.radius);
        return;
    }
    if (isdefined(self.spawner.radius)) {
        self.goalradius = float(self.spawner.radius);
        return;
    }
    self.goalradius = 2048;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x23919951, Offset: 0x2a70
// Size: 0x36
function private function_2d53d03d(b_value = 1) {
    self.skipdeath = b_value ? 1 : 0;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0xc72bb9cb, Offset: 0x2ab0
// Size: 0x36
function private function_2014cd50(b_value = 1) {
    self.skipscenedeath = b_value ? 1 : undefined;
}

// Namespace val/values_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x5e8f4fe, Offset: 0x2af0
// Size: 0x36
function private allow_melee_victim(b_value = 1) {
    self.canbemeleed = b_value ? 1 : 0;
}

/#

    // Namespace val/values_shared
    // Params 4, eflags: 0x24 variadic
    // Checksum 0x688cd93c, Offset: 0x2b30
    // Size: 0xf2
    function private validate(str_name, call_on, func, ...) {
        a_registered = getarraykeys(level.values);
        if (!isinarray(a_registered, hash(str_name))) {
            assertmsg("<dev string:x97>" + str_name + "<dev string:xbb>");
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
    // Checksum 0x7c197f64, Offset: 0x2c30
    // Size: 0x15a
    function private _validate_value(str_name, value, b_assert) {
        if (!isdefined(b_assert)) {
            b_assert = 0;
        }
        s_value = level.values[str_name];
        if (isdefined(s_value.func_validate)) {
            call_on = s_value.validate_call_on === "<dev string:x46>" ? self : s_value.validate_call_on;
            current_value = util::single_func_argarray(call_on, s_value.func_validate, _replace_values(s_value.validate_args));
        } else {
            current_value = self.(str_name);
        }
        b_match = current_value === value;
        if (b_assert) {
            assert(b_match, "<dev string:xd0>" + function_9e72a96(str_name) + "<dev string:xe6>" + current_value + "<dev string:xf0>" + value + "<dev string:x105>");
        }
        return b_match;
    }

    // Namespace val/values_shared
    // Params 0, eflags: 0x4
    // Checksum 0x727981bd, Offset: 0x2d98
    // Size: 0x44a
    function private debug_values() {
        level flag::init_dvar("<dev string:x10b>");
        level flag::wait_till("<dev string:x11f>");
        while (true) {
            level flag::wait_till("<dev string:x10b>");
            str_debug_values_entity = getdvarstring(#"scr_debug_values_entity", "<dev string:x136>");
            if (str_debug_values_entity == "<dev string:x136>" || str_debug_values_entity == "<dev string:x13a>" || str_debug_values_entity == "<dev string:x140>") {
                hud_ent = level.host;
                str_label = "<dev string:x148>";
            } else if (strisnumber(str_debug_values_entity)) {
                hud_ent = getentbynum(int(str_debug_values_entity));
                str_label = "<dev string:x157>" + str_debug_values_entity;
            } else {
                str_value = str_debug_values_entity;
                str_key = "<dev string:x162>";
                if (issubstr(str_value, "<dev string:x170>")) {
                    a_toks = strtok(str_value, "<dev string:x170>");
                    str_value = a_toks[0];
                    str_key = a_toks[1];
                }
                hud_ent = getent(str_value, str_key, 1);
                str_label = str_value + "<dev string:x170>" + str_key;
            }
            debug2dtext((200, 100, 0), str_label, (1, 1, 1), 1, (0, 0, 0), 0.5, 0.8, 1);
            a_all_ents = getentarray();
            foreach (ent in a_all_ents) {
                if (isdefined(ent.values)) {
                    i = 1;
                    foreach (str_name, a_value in ent.values) {
                        top_value = a_value[0];
                        if (isdefined(top_value)) {
                            b_valid = 1;
                            if (is_true(level.values[str_name].b_validate)) {
                                b_assert = getdvarint(#"scr_debug_values", 0) > 1;
                                b_valid = ent _validate_value(str_name, top_value.value, b_assert);
                            }
                            ent display_value(i, str_name, top_value.str_id, top_value.value, b_valid, ent === hud_ent);
                            i++;
                        }
                    }
                }
            }
            waitframe(1);
        }
    }

    // Namespace val/values_shared
    // Params 6, eflags: 0x4
    // Checksum 0xb4b6fb31, Offset: 0x31f0
    // Size: 0x21c
    function private display_value(index, str_name, str_id, value, b_valid, on_hud) {
        if (!isdefined(on_hud)) {
            on_hud = 0;
        }
        if (ishash(str_name)) {
            str_name = function_9e72a96(str_name);
        }
        if (ishash(str_id)) {
            str_id = function_9e72a96(str_id);
        }
        str_value = "<dev string:x136>";
        if ((isdefined(str_name) ? "<dev string:x136>" + str_name : "<dev string:x136>") != "<dev string:x136>") {
            str_value = string::rjust(str_name, 20);
            if (isdefined(value)) {
                str_value += "<dev string:x175>" + value;
            }
            str_value += "<dev string:x17c>" + string::ljust(isdefined(str_id) ? "<dev string:x136>" + str_id : "<dev string:x136>", 30);
        }
        color = b_valid ? (1, 1, 1) : (1, 0, 0);
        if (on_hud) {
            debug2dtext((200, 100 + index * 20, 0), str_value, color, 1, (0, 0, 0), 0.5, 0.8, 1);
        }
        print3d(self.origin - (0, 0, index * 8), str_value, color, 1, 0.3, 1);
    }

#/
