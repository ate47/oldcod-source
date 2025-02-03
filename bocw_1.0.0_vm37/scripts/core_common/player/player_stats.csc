#namespace stats;

/#

    // Namespace stats/player_stats
    // Params 2, eflags: 0x0
    // Checksum 0x8c673b98, Offset: 0x60
    // Size: 0x104
    function function_d92cb558(result, vararg) {
        if (!isdefined(result)) {
            pathstr = ishash(vararg[0]) ? function_9e72a96(vararg[0]) : vararg[0];
            if (!isdefined(pathstr)) {
                return;
            }
            for (i = 1; i < vararg.size; i++) {
                pathstr = pathstr + "<dev string:x38>" + (ishash(vararg[i]) ? function_9e72a96(vararg[i]) : vararg[i]);
            }
            println("<dev string:x3d>" + pathstr);
        }
    }

#/

// Namespace stats/player_stats
// Params 2, eflags: 0x20 variadic
// Checksum 0x793f7517, Offset: 0x170
// Size: 0x76
function get_stat(localclientnum, ...) {
    result = readstat(localclientnum, currentsessionmode(), vararg);
    /#
        function_d92cb558(result, vararg);
    #/
    if (!isdefined(result)) {
        result = 0;
    }
    return result;
}

// Namespace stats/player_stats
// Params 3, eflags: 0x20 variadic
// Checksum 0x1ae4fb90, Offset: 0x1f0
// Size: 0x60
function function_842e069e(localclientnum, sessionmode, ...) {
    result = readstat(localclientnum, sessionmode, vararg);
    /#
        function_d92cb558(result, vararg);
    #/
    return result;
}

// Namespace stats/player_stats
// Params 2, eflags: 0x0
// Checksum 0x1d640633, Offset: 0x258
// Size: 0x42
function get_stat_global(localclientnum, statname) {
    return get_stat(localclientnum, #"playerstatslist", statname, #"statvalue");
}

