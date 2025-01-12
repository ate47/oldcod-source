#namespace namespace_956bd4dd;

// Namespace namespace_956bd4dd/namespace_956bd4dd
// Params 0, eflags: 0x1 linked
// Checksum 0x52f1bd1c, Offset: 0x70
// Size: 0x4a
function function_f45ee99d() {
    if (isdefined(level.radiation)) {
        return;
    }
    level.radiation = {};
    level.radiation.levels = [];
    level.radiation.sickness = [];
}

// Namespace namespace_956bd4dd/namespace_956bd4dd
// Params 4, eflags: 0x0
// Checksum 0x2355fe91, Offset: 0xc8
// Size: 0x10c
function function_df1ecefe(maxhealth, var_1263c72f, var_9653dad7 = 0, var_21a59205 = 2147483647) {
    if (!function_ab99e60c()) {
        return;
    }
    function_f45ee99d();
    radiationlevel = spawnstruct();
    radiationlevel.maxhealth = maxhealth;
    radiationlevel.sickness = [];
    radiationlevel.var_e8f27947 = int(var_1263c72f * 1000);
    radiationlevel.var_9653dad7 = var_9653dad7;
    radiationlevel.var_21a59205 = var_21a59205;
    level.radiation.levels[level.radiation.levels.size] = radiationlevel;
}

// Namespace namespace_956bd4dd/namespace_956bd4dd
// Params 4, eflags: 0x0
// Checksum 0xf3414bfa, Offset: 0x1e0
// Size: 0x1dc
function function_1cb3c52d(name, radiationlevel, duration, var_4267b283 = #"hash_4ae27316c3f95575") {
    if (!function_ab99e60c()) {
        return;
    }
    function_f45ee99d();
    if (!isint(radiationlevel) || !isint(duration) || !ishash(name)) {
        assert(0);
        return;
    }
    if (level.radiation.levels.size <= radiationlevel) {
        assertmsg("<dev string:x38>" + radiationlevel + "<dev string:x71>");
        return;
    }
    radiation = level.radiation.levels[radiationlevel];
    if (isdefined(radiation.sickness[name])) {
        assertmsg("<dev string:x89>" + name + "<dev string:xad>");
        return;
    }
    var_46bdb64c = spawnstruct();
    var_46bdb64c.duration = int(duration * 1000);
    var_46bdb64c.var_4bd5611f = var_4267b283;
    radiation.sickness[name] = var_46bdb64c;
}

// Namespace namespace_956bd4dd/namespace_956bd4dd
// Params 2, eflags: 0x0
// Checksum 0xcf913f4d, Offset: 0x3c8
// Size: 0x94
function function_6b384c0f(radiationlevel, sickness) {
    var_7720923c = level.radiation.levels[radiationlevel];
    keys = getarraykeys(var_7720923c.sickness);
    for (index = 0; index < keys.size; index++) {
        if (keys[index] == sickness) {
            return index;
        }
    }
}

// Namespace namespace_956bd4dd/namespace_956bd4dd
// Params 0, eflags: 0x1 linked
// Checksum 0x84abd2b7, Offset: 0x468
// Size: 0x6c
function function_ab99e60c() {
    return currentsessionmode() != 4 && is_true(isdefined(getgametypesetting("wzRadiation")) ? getgametypesetting("wzRadiation") : 0);
}

