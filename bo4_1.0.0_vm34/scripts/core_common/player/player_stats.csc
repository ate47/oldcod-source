#namespace stats;

/#

    // Namespace stats/player_stats
    // Params 2, eflags: 0x0
    // Checksum 0xd131fb43, Offset: 0x68
    // Size: 0x124
    function function_d0a8636e(result, vararg) {
        if (!isdefined(result)) {
            pathstr = ishash(vararg[0]) ? function_15979fa9(vararg[0]) : vararg[0];
            if (!isdefined(pathstr)) {
                return;
            }
            for (i = 1; i < vararg.size; i++) {
                pathstr = pathstr + "<dev string:x30>" + (ishash(vararg[i]) ? function_15979fa9(vararg[i]) : vararg[i]);
            }
            println("<dev string:x32>" + pathstr);
        }
    }

#/

// Namespace stats/player_stats
// Params 2, eflags: 0x20 variadic
// Checksum 0x8e6cbe07, Offset: 0x198
// Size: 0x68
function get_stat(localclientnum, ...) {
    result = readstat(localclientnum, currentsessionmode(), vararg);
    /#
        function_d0a8636e(result, vararg);
    #/
    return result;
}

// Namespace stats/player_stats
// Params 3, eflags: 0x20 variadic
// Checksum 0xdc943141, Offset: 0x208
// Size: 0x68
function function_94eeedde(localclientnum, sessionmode, ...) {
    result = readstat(localclientnum, sessionmode, vararg);
    /#
        function_d0a8636e(result, vararg);
    #/
    return result;
}

