#namespace ping;

// Namespace ping/ping_shared
// Params 1, eflags: 0x0
// Checksum 0x37f0659f, Offset: 0x60
// Size: 0x7c
function function_fed6948(type) {
    switch (type) {
    case 3:
    case 6:
    case 7:
        return -1;
    case 1:
    case 2:
        return -2;
    }
    return undefined;
}

// Namespace ping/ping_shared
// Params 1, eflags: 0x0
// Checksum 0xd0786ae2, Offset: 0xe8
// Size: 0x42
function function_5947d757(type) {
    return isdefined(function_fed6948(type)) ? function_fed6948(type) : type;
}

// Namespace ping/ping_shared
// Params 1, eflags: 0x0
// Checksum 0xd3ae0c0d, Offset: 0x138
// Size: 0x1c0
function function_44806bba(type) {
    pool = function_5947d757(type);
    if (pool == -1) {
        return getdvarint(#"hash_135ab15dc980084b", 2);
    } else if (pool == -2) {
        return getdvarint(#"hash_5ef51cd5a0446de9", 2);
    } else if (pool == 0) {
        return getdvarint(#"hash_4b0a67e50aeacdee", 1);
    } else if (pool == 4) {
        return getdvarint(#"hash_4685d89a104a6860", 1);
    } else if (pool == 5) {
        return getdvarint(#"hash_60e62eecbe40e4ee", 1);
    } else if (pool == 8) {
        return getdvarint(#"hash_37085d816592dbe3", 2);
    } else {
        assertmsg("<dev string:x38>" + type + "<dev string:x69>" + pool + "<dev string:x76>");
    }
    return 1;
}

