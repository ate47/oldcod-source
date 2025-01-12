#namespace clientfield;

// Namespace clientfield/clientfield_shared
// Params 5, eflags: 0x0
// Checksum 0x9de01fe3, Offset: 0x88
// Size: 0x54
function register(str_pool_name, str_name, n_version, n_bits, str_type) {
    registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

// Namespace clientfield/clientfield_shared
// Params 5, eflags: 0x0
// Checksum 0x594cadca, Offset: 0xe8
// Size: 0x6c
function register_luielem(unique_name, field_name, n_version, n_bits, str_type) {
    registerclientfield("clientuimodel", "luielement." + unique_name + "." + field_name, n_version, n_bits, str_type);
}

// Namespace clientfield/clientfield_shared
// Params 4, eflags: 0x0
// Checksum 0xc6aea39e, Offset: 0x160
// Size: 0x44
function register_bgcache(poolname, var_8a35a0a3, uniqueid, version) {
    function_f54b6b5e(poolname, var_8a35a0a3, uniqueid, version);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0xb7c55573, Offset: 0x1b0
// Size: 0x5c
function set(str_field_name, n_value) {
    if (self == level) {
        codesetworldclientfield(str_field_name, n_value);
        return;
    }
    codesetclientfield(self, str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x75960f1c, Offset: 0x218
// Size: 0x22
function can_set(str_field_name, n_value) {
    return function_657ed095();
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0xf08f23b6, Offset: 0x248
// Size: 0x2c
function set_to_player(str_field_name, n_value) {
    codesetplayerstateclientfield(self, str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x90d03d11, Offset: 0x280
// Size: 0x2c
function set_player_uimodel(str_field_name, n_value) {
    codesetuimodelclientfield(self, str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 3, eflags: 0x0
// Checksum 0xadcbab3f, Offset: 0x2b8
// Size: 0x4c
function function_8fe7322a(unique_name, str_field_name, n_value) {
    codesetuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0xd207184c, Offset: 0x310
// Size: 0x44
function function_9d68ee55(unique_name, str_field_name) {
    codeincrementuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xf2482a69, Offset: 0x360
// Size: 0x22
function get_player_uimodel(str_field_name) {
    return codegetuimodelclientfield(self, str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0xa4ac7ca6, Offset: 0x390
// Size: 0x42
function function_c601af3e(unique_name, str_field_name) {
    return codegetuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x2c6c786c, Offset: 0x3e0
// Size: 0x2c
function set_world_uimodel(str_field_name, n_value) {
    codesetworlduimodelfield(str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xf6186d0c, Offset: 0x418
// Size: 0x22
function get_world_uimodel(str_field_name) {
    return codegetworlduimodelfield(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xfd6de681, Offset: 0x448
// Size: 0x22
function increment_world_uimodel(str_field_name) {
    return codeincrementworlduimodelfield(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x88a343fe, Offset: 0x478
// Size: 0x7e
function increment(str_field_name, n_increment_count = 1) {
    for (i = 0; i < n_increment_count; i++) {
        if (self == level) {
            codeincrementworldclientfield(str_field_name);
            continue;
        }
        codeincrementclientfield(self, str_field_name);
    }
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x1b248130, Offset: 0x500
// Size: 0x106
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
// Checksum 0x95007e28, Offset: 0x610
// Size: 0x5e
function increment_to_player(str_field_name, n_increment_count = 1) {
    for (i = 0; i < n_increment_count; i++) {
        codeincrementplayerstateclientfield(self, str_field_name);
    }
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x822570fa, Offset: 0x678
// Size: 0x44
function get(str_field_name) {
    if (self == level) {
        return codegetworldclientfield(str_field_name);
    }
    return codegetclientfield(self, str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x8eac50e7, Offset: 0x6c8
// Size: 0x22
function get_to_player(field_name) {
    return codegetplayerstateclientfield(self, field_name);
}

