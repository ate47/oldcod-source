#using scripts/core_common/array_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace utility_eval;

// Namespace utility_eval/utility_eval
// Params 3, eflags: 0x0
// Checksum 0x3e896a61, Offset: 0x110
// Size: 0xaa
function function_5cf508eb(paramslist, var_ba49acbd, &var_40b0dbbb) {
    foreach (params in paramslist) {
        function_62678d8b(params, var_ba49acbd, var_40b0dbbb);
    }
}

// Namespace utility_eval/utility_eval
// Params 3, eflags: 0x0
// Checksum 0xedb57a1d, Offset: 0x1c8
// Size: 0xb8
function function_62678d8b(params, var_ba49acbd, &var_40b0dbbb) {
    var_c76c7c = evaluate(params, var_ba49acbd);
    for (i = 0; i < var_40b0dbbb.size; i++) {
        if (var_40b0dbbb[i].utility <= var_c76c7c.utility) {
            break;
        }
    }
    arrayinsert(var_40b0dbbb, var_c76c7c, i);
    return var_c76c7c;
}

// Namespace utility_eval/utility_eval
// Params 2, eflags: 0x0
// Checksum 0x498c3f38, Offset: 0x288
// Size: 0x64
function evaluate(params, var_ba49acbd) {
    var_c76c7c = spawnstruct();
    var_c76c7c.utility = [[ var_ba49acbd ]](params);
    var_c76c7c.params = params;
    return var_c76c7c;
}

// Namespace utility_eval/utility_eval
// Params 2, eflags: 0x0
// Checksum 0x8685ca2a, Offset: 0x2f8
// Size: 0xbc
function function_b5509e59(var_40b0dbbb, var_48cabfb1) {
    if (!isdefined(var_48cabfb1)) {
        var_48cabfb1 = 0;
    }
    foreach (var_c76c7c in var_40b0dbbb) {
        if (var_c76c7c.utility >= var_48cabfb1) {
            return var_c76c7c.params;
        }
    }
    return undefined;
}

// Namespace utility_eval/utility_eval
// Params 1, eflags: 0x0
// Checksum 0x462c3840, Offset: 0x3c0
// Size: 0xb2
function pick_random(var_40b0dbbb) {
    if (var_40b0dbbb.size <= 0) {
        return undefined;
    }
    var_b1e47019 = var_40b0dbbb[0].utility;
    for (i = 1; i < var_40b0dbbb.size; i++) {
        if (var_40b0dbbb[i].utility < var_b1e47019) {
            break;
        }
    }
    return var_40b0dbbb[randomint(i)].params;
}

/#

    // Namespace utility_eval/utility_eval
    // Params 2, eflags: 0x0
    // Checksum 0x9398c742, Offset: 0x480
    // Size: 0x13e
    function utility_color(utility, targetutility) {
        colorscale = array((1, 0, 0), (1, 0.5, 0), (1, 1, 0), (0, 1, 0));
        if (utility >= targetutility) {
            return colorscale[colorscale.size - 1];
        } else if (utility <= 0) {
            return colorscale[0];
        }
        utilityindex = utility * colorscale.size / targetutility;
        utilityindex -= 1;
        colorindex = int(utilityindex);
        colorfrac = utilityindex - colorindex;
        utilitycolor = vectorlerp(colorscale[colorindex], colorscale[colorindex + 1], colorfrac);
        return utilitycolor;
    }

#/
