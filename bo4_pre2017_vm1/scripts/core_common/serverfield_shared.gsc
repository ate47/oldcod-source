#namespace serverfield;

// Namespace serverfield/serverfield_shared
// Params 5, eflags: 0x0
// Checksum 0xd499909, Offset: 0x88
// Size: 0x54
function register(str_name, n_version, n_bits, str_type, func_callback) {
    serverfieldregister(str_name, n_version, n_bits, str_type, func_callback);
}

// Namespace serverfield/serverfield_shared
// Params 1, eflags: 0x0
// Checksum 0xdcfbe89f, Offset: 0xe8
// Size: 0x22
function get(field_name) {
    return serverfieldgetvalue(self, field_name);
}
