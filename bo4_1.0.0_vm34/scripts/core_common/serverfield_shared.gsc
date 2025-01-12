#namespace serverfield;

// Namespace serverfield/serverfield_shared
// Params 5, eflags: 0x0
// Checksum 0x7d7b4c30, Offset: 0x68
// Size: 0x54
function register(str_name, n_version, n_bits, str_type, func_callback) {
    serverfieldregister(str_name, n_version, n_bits, str_type, func_callback);
}

// Namespace serverfield/serverfield_shared
// Params 1, eflags: 0x0
// Checksum 0xaab96f4c, Offset: 0xc8
// Size: 0x22
function get(field_name) {
    return serverfieldgetvalue(self, field_name);
}

