#namespace serverfield;

// Namespace serverfield/serverfield_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x2308847a, Offset: 0x60
// Size: 0x4c
function register(str_name, n_version, n_bits, str_type, func_callback) {
    serverfieldregister(str_name, n_version, n_bits, str_type, func_callback);
}

// Namespace serverfield/serverfield_shared
// Params 1, eflags: 0x0
// Checksum 0x520dc746, Offset: 0xb8
// Size: 0x22
function get(field_name) {
    return serverfieldgetvalue(self, field_name);
}

