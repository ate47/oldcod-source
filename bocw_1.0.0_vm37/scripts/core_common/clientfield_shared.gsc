#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;

#namespace clientfield;

// Namespace clientfield/clientfield_shared
// Params 5, eflags: 0x0
// Checksum 0xc4c6455a, Offset: 0xc0
// Size: 0x4c
function register(str_pool_name, str_name, n_version, n_bits, str_type) {
    registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x0
// Checksum 0x124ccdba, Offset: 0x118
// Size: 0x44
function function_5b7d846d(str_name, n_version, n_bits, str_type) {
    registerclientfield("worlduimodel", str_name, n_version, n_bits, str_type);
}

// Namespace clientfield/clientfield_shared
// Params 5, eflags: 0x0
// Checksum 0x95a989bf, Offset: 0x168
// Size: 0x4c
function register_clientuimodel(str_name, n_version, n_bits, str_type, var_59f69872) {
    registerclientfield("clientuimodel", str_name, n_version, n_bits, str_type, var_59f69872);
}

// Namespace clientfield/clientfield_shared
// Params 7, eflags: 0x0
// Checksum 0x9e2ae63c, Offset: 0x1c0
// Size: 0x9c
function register_luielem(menu_name, var_483e93f7, field_name, n_version, n_bits, str_type, var_59f69872) {
    registerclientfield("clientuimodel", "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + field_name, n_version, n_bits, str_type, var_59f69872);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x0
// Checksum 0xc8e369be, Offset: 0x268
// Size: 0x44
function register_bgcache(poolname, var_b693fec6, uniqueid, version) {
    function_3ff577e6(poolname, var_b693fec6, uniqueid, version);
}

// Namespace clientfield/clientfield_shared
// Params 3, eflags: 0x0
// Checksum 0x1e4f7d8f, Offset: 0x2b8
// Size: 0x3c
function function_d89771ec(var_b693fec6, uniqueid, version) {
    function_3ff577e6("worlduimodel", var_b693fec6, uniqueid, version);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x0
// Checksum 0x8349e058, Offset: 0x300
// Size: 0x44
function function_91cd7763(var_b693fec6, uniqueid, version, var_59f69872) {
    function_3ff577e6("clientuimodel", var_b693fec6, uniqueid, version, var_59f69872);
}

// Namespace clientfield/clientfield_shared
// Params 6, eflags: 0x0
// Checksum 0x3992a6f9, Offset: 0x350
// Size: 0x94
function function_b63c5dfe(var_b693fec6, menu_name, var_483e93f7, field_name, version, var_59f69872) {
    function_3ff577e6("clientuimodel", var_b693fec6, "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + field_name, version, var_59f69872);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0xd4930321, Offset: 0x3f0
// Size: 0x2c
function set(str_field_name, n_value) {
    self thread _set(str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x3452f5c0, Offset: 0x428
// Size: 0x10c
function _set(str_field_name, n_value) {
    if (!isdefined(str_field_name)) {
        assertmsg("<dev string:x38>");
        return;
    }
    if (!level flag::get(#"hash_4f4b65226250fc99")) {
        var_17b7891d = "1be1d21ba1b21218" + str_field_name;
        self notify(var_17b7891d);
        self endon(var_17b7891d);
        self endon(#"death");
        level flag::wait_till(#"hash_4f4b65226250fc99");
    }
    if (self == level) {
        codesetworldclientfield(str_field_name, n_value);
        return;
    }
    codesetclientfield(self, str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x6c578fb2, Offset: 0x540
// Size: 0x7c
function is_registered(field_name) {
    if (self == level) {
        return function_6de43d39(field_name);
    }
    var_24d738a9 = function_cf197fb7(self);
    if (var_24d738a9 == -1) {
        return 0;
    }
    return function_bda9951d(var_24d738a9, field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x3172b033, Offset: 0x5c8
// Size: 0x22
function can_set(*str_field_name, *n_value) {
    return function_26b3a620();
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x1d557442, Offset: 0x5f8
// Size: 0x84
function set_to_player(str_field_name, n_value) {
    assert(isplayer(self), "<dev string:x78>");
    if (isplayer(self)) {
        codesetplayerstateclientfield(self, str_field_name, n_value);
    }
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x861869d7, Offset: 0x688
// Size: 0x22
function function_ec6130f9(str_field_name) {
    return function_3424020a(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x1b50ae0f, Offset: 0x6b8
// Size: 0x2c
function set_player_uimodel(str_field_name, n_value) {
    codesetuimodelclientfield(self, str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x1f582850, Offset: 0x6f0
// Size: 0x22
function function_40aa8832(str_field_name) {
    return function_fcaed52(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x0
// Checksum 0xdc753612, Offset: 0x720
// Size: 0x74
function function_9bf78ef8(menu_name, var_483e93f7, str_field_name, n_value) {
    codesetuimodelclientfield(self, "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 3, eflags: 0x0
// Checksum 0x1c51a8a0, Offset: 0x7a0
// Size: 0x6c
function function_bb878fc3(menu_name, var_483e93f7, str_field_name) {
    codeincrementuimodelclientfield(self, "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x41bed735, Offset: 0x818
// Size: 0x22
function get_player_uimodel(str_field_name) {
    return codegetuimodelclientfield(self, str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 3, eflags: 0x0
// Checksum 0x35ab6b18, Offset: 0x848
// Size: 0x6a
function function_f7ae6994(menu_name, var_483e93f7, str_field_name) {
    return codegetuimodelclientfield(self, "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x61cfdef8, Offset: 0x8c0
// Size: 0x2c
function set_world_uimodel(str_field_name, n_value) {
    codesetworlduimodelfield(str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xce91eeeb, Offset: 0x8f8
// Size: 0x22
function function_1bea0e72(str_field_name) {
    return function_a02eca40(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x81474935, Offset: 0x928
// Size: 0x22
function get_world_uimodel(str_field_name) {
    return codegetworlduimodelfield(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xc855de0b, Offset: 0x958
// Size: 0x22
function increment_world_uimodel(str_field_name) {
    return codeincrementworlduimodelfield(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0xf8c1763b, Offset: 0x988
// Size: 0x2c
function increment(str_field_name, n_increment_count) {
    self thread _increment(str_field_name, n_increment_count);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x4
// Checksum 0x6b4300d6, Offset: 0x9c0
// Size: 0x114
function private _increment(str_field_name, n_increment_count = 1) {
    if (self != level) {
        self endon(#"death", #"disconnect");
        waittillframeend();
    }
    for (i = 0; i < n_increment_count; i++) {
        if (self == level) {
            codeincrementworldclientfield(str_field_name);
            continue;
        }
        assert(isdefined(level.var_58bc5d04));
        if (isdefined(self.birthtime) && self.birthtime >= level.var_58bc5d04) {
            util::wait_network_frame();
        }
        if (isdefined(self)) {
            codeincrementclientfield(self, str_field_name);
        }
    }
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x82a3d4c9, Offset: 0xae0
// Size: 0x10c
function increment_uimodel(str_field_name, n_increment_count = 1) {
    if (self == level) {
        foreach (player in level.players) {
            for (i = 0; i < n_increment_count; i++) {
                codeincrementuimodelclientfield(player, str_field_name);
            }
        }
        return;
    }
    for (i = 0; i < n_increment_count; i++) {
        codeincrementuimodelclientfield(self, str_field_name);
    }
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0xd446ab6f, Offset: 0xbf8
// Size: 0x5c
function increment_to_player(str_field_name, n_increment_count = 1) {
    for (i = 0; i < n_increment_count; i++) {
        codeincrementplayerstateclientfield(self, str_field_name);
    }
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xb052685d, Offset: 0xc60
// Size: 0x44
function get(str_field_name) {
    if (self == level) {
        return codegetworldclientfield(str_field_name);
    }
    return codegetclientfield(self, str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xe901b864, Offset: 0xcb0
// Size: 0x22
function get_to_player(field_name) {
    return codegetplayerstateclientfield(self, field_name);
}

