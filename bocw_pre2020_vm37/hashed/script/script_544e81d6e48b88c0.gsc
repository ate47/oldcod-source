#using script_19c6c147c637b960;

#namespace namespace_99c84a33;

// Namespace namespace_99c84a33/namespace_99c84a33
// Params 3, eflags: 0x0
// Checksum 0x74708830, Offset: 0x78
// Size: 0x8c
function function_99652b58(name, index, *team) {
    cameras = getentarray(0, index, "targetname");
    if (cameras.size) {
        addobjectivecamerapoint(index, team, #"none", cameras[0].origin, cameras[0].angles);
    }
}

// Namespace namespace_99c84a33/namespace_99c84a33
// Params 3, eflags: 0x1 linked
// Checksum 0xd7f5935c, Offset: 0x110
// Size: 0x8c
function function_bb3bbc2c(name, index, *team) {
    cameras = territory::function_5c7345a3(index, "targetname");
    if (cameras.size) {
        addobjectivecamerapoint(index, team, #"none", cameras[0].origin, cameras[0].angles);
    }
}

