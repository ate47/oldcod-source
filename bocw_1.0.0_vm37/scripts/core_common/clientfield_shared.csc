#namespace clientfield;

// Namespace clientfield/clientfield_shared
// Params 8, eflags: 0x0
// Checksum 0x690efaf, Offset: 0x98
// Size: 0x6c
function register(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
    registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 9, eflags: 0x0
// Checksum 0x607bd018, Offset: 0x110
// Size: 0x74
function function_5b7d846d(str_name, var_91c404f, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
    function_c750339b("worlduimodel", str_name, var_91c404f, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 9, eflags: 0x0
// Checksum 0xe0f70781, Offset: 0x190
// Size: 0x74
function register_clientuimodel(str_name, var_91c404f, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
    function_c750339b("clientuimodel", str_name, var_91c404f, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 10, eflags: 0x0
// Checksum 0xf4e4cfd6, Offset: 0x210
// Size: 0x7c
function register_luielem(str_name, menu_name, var_483e93f7, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
    function_e231bfd4(str_name, menu_name, var_483e93f7, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 7, eflags: 0x0
// Checksum 0x16708988, Offset: 0x298
// Size: 0x5c
function register_bgcache(poolname, var_b693fec6, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new) {
    function_3ff577e6(poolname, var_b693fec6, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 8, eflags: 0x0
// Checksum 0x22dc16bf, Offset: 0x300
// Size: 0x6c
function function_d89771ec(var_b693fec6, uniqueid, var_91c404f, path, version, func_callback, b_host, b_callback_for_zero_when_new) {
    function_bac6598a("worlduimodel", var_b693fec6, uniqueid, var_91c404f, path, version, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 8, eflags: 0x0
// Checksum 0x6e874b1a, Offset: 0x378
// Size: 0x6c
function function_91cd7763(var_b693fec6, uniqueid, var_91c404f, path, version, func_callback, b_host, b_callback_for_zero_when_new) {
    function_bac6598a("clientuimodel", var_b693fec6, uniqueid, var_91c404f, path, version, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 9, eflags: 0x0
// Checksum 0xe47bd173, Offset: 0x3f0
// Size: 0x74
function function_b63c5dfe(var_b693fec6, uniqueid, menu_name, var_483e93f7, path, version, func_callback, b_host, b_callback_for_zero_when_new) {
    function_9a992427(var_b693fec6, uniqueid, menu_name, var_483e93f7, path, version, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xbbd36fa0, Offset: 0x470
// Size: 0x44
function get(field_name) {
    if (self == level) {
        return codegetworldclientfield(field_name);
    }
    return codegetclientfield(self, field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xb8e25e49, Offset: 0x4c0
// Size: 0x22
function get_to_player(field_name) {
    return codegetplayerstateclientfield(self, field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x93108c5a, Offset: 0x4f0
// Size: 0x22
function get_player_uimodel(field_name) {
    return codegetuimodelclientfield(self, field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0xff2d5952, Offset: 0x520
// Size: 0x42
function function_f7ae6994(unique_name, str_field_name) {
    return codegetuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name);
}

