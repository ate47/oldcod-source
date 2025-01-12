#namespace clientfield;

// Namespace clientfield/clientfield_shared
// Params 8, eflags: 0x0
// Checksum 0xa5577adc, Offset: 0x88
// Size: 0x74
function register(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
    registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 8, eflags: 0x0
// Checksum 0x4df60e70, Offset: 0x108
// Size: 0x8c
function register_luielem(unique_name, field_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
    registerclientfield("clientuimodel", "luielement." + unique_name + "." + field_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 7, eflags: 0x0
// Checksum 0x26e194c9, Offset: 0x1a0
// Size: 0x6c
function register_bgcache(poolname, var_8a35a0a3, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new) {
    function_f54b6b5e(poolname, var_8a35a0a3, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x5efb5e75, Offset: 0x218
// Size: 0x44
function get(field_name) {
    if (self == level) {
        return codegetworldclientfield(field_name);
    }
    return codegetclientfield(self, field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x1b977795, Offset: 0x268
// Size: 0x22
function get_to_player(field_name) {
    return codegetplayerstateclientfield(self, field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xf4769a04, Offset: 0x298
// Size: 0x22
function get_player_uimodel(field_name) {
    return codegetuimodelclientfield(self, field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x31b33dd1, Offset: 0x2c8
// Size: 0x42
function function_c601af3e(unique_name, str_field_name) {
    return codegetuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name);
}

