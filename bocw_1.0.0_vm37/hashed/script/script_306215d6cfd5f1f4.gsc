#using scripts\core_common\territory;

#namespace namespace_99c84a33;

// Namespace namespace_99c84a33/namespace_99c84a33
// Params 3, eflags: 0x0
// Checksum 0xbc2b662c, Offset: 0x78
// Size: 0xa4
function function_99652b58(name, index, team = #"none") {
    cameras = territory::function_1f583d2e(name, "targetname");
    if (cameras.size) {
        addobjectivecamerapoint(name, index, team, cameras[0].origin, cameras[0].angles);
        return true;
    }
    return false;
}

// Namespace namespace_99c84a33/namespace_99c84a33
// Params 5, eflags: 0x0
// Checksum 0xb159c974, Offset: 0x128
// Size: 0x64
function function_67b65e2a(name, index, team, origin, angles) {
    addobjectivecamerapoint(name, index, team, origin, angles);
    function_e795803(name, 1);
}

// Namespace namespace_99c84a33/namespace_99c84a33
// Params 1, eflags: 0x0
// Checksum 0xcb57a7ca, Offset: 0x198
// Size: 0x34
function function_99c84a33(index) {
    self.spectatorclient = -1;
    self function_eccd0b1c(index);
}

