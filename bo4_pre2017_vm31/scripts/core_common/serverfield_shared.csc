#namespace serverfield;

// Namespace serverfield/serverfield_shared
// Params 4, eflags: 0x0
// Checksum 0xb40ef66a, Offset: 0x88
// Size: 0x44
function register(str_name, n_version, n_bits, str_type) {
    serverfieldregister(str_name, n_version, n_bits, str_type);
}

// Namespace serverfield/serverfield_shared
// Params 2, eflags: 0x0
// Checksum 0x76643677, Offset: 0xd8
// Size: 0x34
function set(str_field_name, n_value) {
    serverfieldsetval(self, str_field_name, n_value);
}

// Namespace serverfield/serverfield_shared
// Params 1, eflags: 0x0
// Checksum 0x2ab80880, Offset: 0x118
// Size: 0x24
function increment(str_field_name) {
    serverfieldincrement(self, str_field_name);
}

