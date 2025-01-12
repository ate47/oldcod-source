#using scripts\core_common\array_shared;

#namespace aispawningutility;

// Namespace aispawningutility/aispawning
// Params 3, eflags: 0x0
// Checksum 0xd7de0d0, Offset: 0x80
// Size: 0x51a
function function_c2f6a5c3(str_team, var_ef34ce7d, var_56d259ba) {
    var_cf63e4fc = [];
    if (isdefined(var_ef34ce7d)) {
        var_cf63e4fc = getentarray(var_ef34ce7d, "targetname");
    }
    if (var_cf63e4fc.size) {
        var_2debf413 = [];
        foreach (var_f6c9dd1c in var_cf63e4fc) {
            if (isspawner(var_f6c9dd1c)) {
                if (var_56d259ba === var_f6c9dd1c.var_ea94c12a) {
                    if (!isdefined(var_2debf413)) {
                        var_2debf413 = [];
                    } else if (!isarray(var_2debf413)) {
                        var_2debf413 = array(var_2debf413);
                    }
                    if (!isinarray(var_2debf413, var_f6c9dd1c)) {
                        var_2debf413[var_2debf413.size] = var_f6c9dd1c;
                    }
                }
            }
        }
        if (!var_2debf413.size) {
            /#
                println("<dev string:x30>" + var_56d259ba + "<dev string:x52>");
                iprintln("<dev string:x30>" + var_56d259ba + "<dev string:x52>");
            #/
            return undefined;
        }
        var_65174a6e = [];
        var_73265f45 = [];
        foreach (var_d4e8e1f3 in var_2debf413) {
            if (var_d4e8e1f3.count > 0 || isdefined(var_d4e8e1f3.spawnflags) && (var_d4e8e1f3.spawnflags & 64) == 64) {
                if (!isdefined(var_65174a6e)) {
                    var_65174a6e = [];
                } else if (!isarray(var_65174a6e)) {
                    var_65174a6e = array(var_65174a6e);
                }
                if (!isinarray(var_65174a6e, var_d4e8e1f3)) {
                    var_65174a6e[var_65174a6e.size] = var_d4e8e1f3;
                }
                if (isdefined(var_d4e8e1f3.spawnflags) && (var_d4e8e1f3.spawnflags & 32) == 32) {
                    if (!isdefined(var_73265f45)) {
                        var_73265f45 = [];
                    } else if (!isarray(var_73265f45)) {
                        var_73265f45 = array(var_73265f45);
                    }
                    if (!isinarray(var_73265f45, var_d4e8e1f3)) {
                        var_73265f45[var_73265f45.size] = var_d4e8e1f3;
                    }
                }
            }
        }
        if (var_73265f45.size) {
            spawner = array::random(var_73265f45);
            spawn_point[#"angles"] = spawner.angles;
            spawn_point[#"origin"] = spawner.origin;
            spawn_point[#"spawner"] = spawner;
            return spawn_point;
        } else if (var_65174a6e.size) {
            spawner = array::random(var_65174a6e);
            spawn_point[#"angles"] = spawner.angles;
            spawn_point[#"origin"] = spawner.origin;
            spawn_point[#"spawner"] = spawner;
            return spawn_point;
        }
        /#
            println("<dev string:x54>" + var_56d259ba + "<dev string:x7d>" + str_team + "<dev string:x83>");
            iprintln("<dev string:x54>" + var_56d259ba + "<dev string:x7d>" + str_team + "<dev string:x83>");
        #/
        return undefined;
    }
    return undefined;
}

