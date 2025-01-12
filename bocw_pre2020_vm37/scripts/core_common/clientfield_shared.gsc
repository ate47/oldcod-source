#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;

#namespace clientfield;

// Namespace clientfield/clientfield_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x1004bade, Offset: 0xc0
// Size: 0x4c
function register(str_pool_name, str_name, n_version, n_bits, str_type) {
    registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x813ee2b4, Offset: 0x118
// Size: 0x44
function function_5b7d846d(str_name, n_version, n_bits, str_type) {
    registerclientfield("worlduimodel", str_name, n_version, n_bits, str_type);
}

// Namespace clientfield/clientfield_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x4e704928, Offset: 0x168
// Size: 0x4c
function register_clientuimodel(str_name, n_version, n_bits, str_type, var_59f69872) {
    registerclientfield("clientuimodel", str_name, n_version, n_bits, str_type, var_59f69872);
}

// Namespace clientfield/clientfield_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xa0cf8fff, Offset: 0x1c0
// Size: 0x9c
function register_luielem(menu_name, var_483e93f7, field_name, n_version, n_bits, str_type, var_59f69872) {
    registerclientfield("clientuimodel", "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + field_name, n_version, n_bits, str_type, var_59f69872);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x0
// Checksum 0xc7e21e68, Offset: 0x268
// Size: 0x44
function register_bgcache(poolname, var_b693fec6, uniqueid, version) {
    function_3ff577e6(poolname, var_b693fec6, uniqueid, version);
}

// Namespace clientfield/clientfield_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x3aa5f4d6, Offset: 0x2b8
// Size: 0x3c
function function_d89771ec(var_b693fec6, uniqueid, version) {
    function_3ff577e6("worlduimodel", var_b693fec6, uniqueid, version);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x1 linked
// Checksum 0xe59bf097, Offset: 0x300
// Size: 0x44
function function_91cd7763(var_b693fec6, uniqueid, version, var_59f69872) {
    function_3ff577e6("clientuimodel", var_b693fec6, uniqueid, version, var_59f69872);
}

// Namespace clientfield/clientfield_shared
// Params 6, eflags: 0x1 linked
// Checksum 0x1dac5226, Offset: 0x350
// Size: 0x94
function function_b63c5dfe(var_b693fec6, menu_name, var_483e93f7, field_name, version, var_59f69872) {
    function_3ff577e6("clientuimodel", var_b693fec6, "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + field_name, version, var_59f69872);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xfa2a24c0, Offset: 0x3f0
// Size: 0x2c
function set(str_field_name, n_value) {
    self thread _set(str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xad9e6b6a, Offset: 0x428
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
// Params 1, eflags: 0x1 linked
// Checksum 0xed4dd74b, Offset: 0x540
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
// Params 2, eflags: 0x1 linked
// Checksum 0xc7ebfc64, Offset: 0x5c8
// Size: 0x22
function can_set(*str_field_name, *n_value) {
    return function_26b3a620();
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x37b15e28, Offset: 0x5f8
// Size: 0x84
function set_to_player(str_field_name, n_value) {
    assert(isplayer(self), "<dev string:x78>");
    if (isplayer(self)) {
        codesetplayerstateclientfield(self, str_field_name, n_value);
    }
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xe7aa629a, Offset: 0x688
// Size: 0x22
function function_ec6130f9(str_field_name) {
    return function_3424020a(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x99cf5dd, Offset: 0x6b8
// Size: 0x2c
function set_player_uimodel(str_field_name, n_value) {
    codesetuimodelclientfield(self, str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xb27ee137, Offset: 0x6f0
// Size: 0x22
function function_40aa8832(str_field_name) {
    return function_fcaed52(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x47329119, Offset: 0x720
// Size: 0x74
function function_9bf78ef8(menu_name, var_483e93f7, str_field_name, n_value) {
    codesetuimodelclientfield(self, "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x8a722510, Offset: 0x7a0
// Size: 0x6c
function function_bb878fc3(menu_name, var_483e93f7, str_field_name) {
    codeincrementuimodelclientfield(self, "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1fca017b, Offset: 0x818
// Size: 0x22
function get_player_uimodel(str_field_name) {
    return codegetuimodelclientfield(self, str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 3, eflags: 0x0
// Checksum 0x3a66d90a, Offset: 0x848
// Size: 0x6a
function function_f7ae6994(menu_name, var_483e93f7, str_field_name) {
    return codegetuimodelclientfield(self, "luielement." + menu_name + "." + (isdefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x84b0c943, Offset: 0x8c0
// Size: 0x2c
function set_world_uimodel(str_field_name, n_value) {
    codesetworlduimodelfield(str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x257a1422, Offset: 0x8f8
// Size: 0x22
function function_1bea0e72(str_field_name) {
    return function_a02eca40(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x88c535bb, Offset: 0x928
// Size: 0x22
function get_world_uimodel(str_field_name) {
    return codegetworlduimodelfield(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x44678c17, Offset: 0x958
// Size: 0x22
function increment_world_uimodel(str_field_name) {
    return codeincrementworlduimodelfield(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x5e09b209, Offset: 0x988
// Size: 0x2c
function increment(str_field_name, n_increment_count) {
    self thread _increment(str_field_name, n_increment_count);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x5 linked
// Checksum 0x90427cb5, Offset: 0x9c0
// Size: 0x104
function private _increment(str_field_name, n_increment_count = 1) {
    if (self != level) {
        self endon(#"death", #"disconnect");
    }
    for (i = 0; i < n_increment_count; i++) {
        if (self == level) {
            codeincrementworldclientfield(str_field_name);
            continue;
        }
        waittillframeend();
        assert(isdefined(level.var_58bc5d04));
        if (isdefined(self.birthtime) && self.birthtime >= level.var_58bc5d04) {
            util::wait_network_frame();
        }
        codeincrementclientfield(self, str_field_name);
    }
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xdd60af1b, Offset: 0xad0
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
// Params 2, eflags: 0x1 linked
// Checksum 0x33ad8de1, Offset: 0xbe8
// Size: 0x5c
function increment_to_player(str_field_name, n_increment_count = 1) {
    for (i = 0; i < n_increment_count; i++) {
        codeincrementplayerstateclientfield(self, str_field_name);
    }
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd9effe8f, Offset: 0xc50
// Size: 0x44
function get(str_field_name) {
    if (self == level) {
        return codegetworldclientfield(str_field_name);
    }
    return codegetclientfield(self, str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x1bdbdd1c, Offset: 0xca0
// Size: 0x22
function get_to_player(field_name) {
    return codegetplayerstateclientfield(self, field_name);
}

