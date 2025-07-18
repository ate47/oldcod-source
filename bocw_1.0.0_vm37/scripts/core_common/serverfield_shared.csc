#namespace serverfield;

// Namespace serverfield/serverfield_shared
// Params 4, eflags: 0x0
// Checksum 0xb793fbe4, Offset: 0x60
// Size: 0x44
function register(str_name, n_version, n_bits, str_type) {
    serverfieldregister(str_name, n_version, n_bits, str_type);
}

// Namespace serverfield/serverfield_shared
// Params 2, eflags: 0x0
// Checksum 0x49c29867, Offset: 0xb0
// Size: 0x2c
function set(str_field_name, n_value) {
    serverfieldsetval(self, str_field_name, n_value);
}

// Namespace serverfield/serverfield_shared
// Params 1, eflags: 0x0
// Checksum 0x3c6e39c, Offset: 0xe8
// Size: 0x22
function get(field_name) {
    return serverfieldgetvalue(self, field_name);
}

