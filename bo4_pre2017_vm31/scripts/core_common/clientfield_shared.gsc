#namespace clientfield;

// Namespace clientfield/clientfield_shared
// Params 5, eflags: 0x0
// Checksum 0xa86493bd, Offset: 0x88
// Size: 0x54
function register(str_pool_name, str_name, n_version, n_bits, str_type) {
    registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x5439338c, Offset: 0xe8
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
// Checksum 0x683e7b74, Offset: 0x150
// Size: 0x34
function set_to_player(str_field_name, n_value) {
    codesetplayerstateclientfield(self, str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x2aa3d339, Offset: 0x190
// Size: 0x34
function set_player_uimodel(str_field_name, n_value) {
    codesetuimodelclientfield(self, str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x8f6ea48d, Offset: 0x1d0
// Size: 0x22
function get_player_uimodel(str_field_name) {
    return codegetuimodelclientfield(self, str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x7eb21b75, Offset: 0x200
// Size: 0x2c
function set_world_uimodel(str_field_name, n_value) {
    codesetworlduimodelfield(str_field_name, n_value);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x250bff15, Offset: 0x238
// Size: 0x22
function get_world_uimodel(str_field_name) {
    return codegetworlduimodelfield(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0xb4d94d94, Offset: 0x268
// Size: 0x22
function increment_world_uimodel(str_field_name) {
    return codeincrementworlduimodelfield(str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 2, eflags: 0x0
// Checksum 0x13a8fa0, Offset: 0x298
// Size: 0x96
function increment(str_field_name, n_increment_count) {
    if (!isdefined(n_increment_count)) {
        n_increment_count = 1;
    }
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
// Checksum 0x9815df79, Offset: 0x338
// Size: 0x126
function increment_uimodel(str_field_name, n_increment_count) {
    if (!isdefined(n_increment_count)) {
        n_increment_count = 1;
    }
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
// Checksum 0xa5847a39, Offset: 0x468
// Size: 0x66
function increment_to_player(str_field_name, n_increment_count) {
    if (!isdefined(n_increment_count)) {
        n_increment_count = 1;
    }
    for (i = 0; i < n_increment_count; i++) {
        codeincrementplayerstateclientfield(self, str_field_name);
    }
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x8a3ee5b2, Offset: 0x4d8
// Size: 0x4c
function get(str_field_name) {
    if (self == level) {
        return codegetworldclientfield(str_field_name);
    }
    return codegetclientfield(self, str_field_name);
}

// Namespace clientfield/clientfield_shared
// Params 1, eflags: 0x0
// Checksum 0x3e5bdb4, Offset: 0x530
// Size: 0x22
function get_to_player(field_name) {
    return codegetplayerstateclientfield(self, field_name);
}

