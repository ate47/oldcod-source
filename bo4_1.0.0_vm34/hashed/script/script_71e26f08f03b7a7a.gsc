#using scripts\core_common\flagsys_shared;
#using scripts\core_common\system_shared;
#using scripts\mp_common\item_supply_drop;

#namespace namespace_2831d7ca;

// Namespace namespace_2831d7ca/namespace_2831d7ca
// Params 0, eflags: 0x2
// Checksum 0x59af474b, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"hash_280fe2667ed2d300", &__init__, undefined, #"item_supply_drop");
}

// Namespace namespace_2831d7ca/namespace_2831d7ca
// Params 0, eflags: 0x4
// Checksum 0xe0880ff9, Offset: 0xd0
// Size: 0x56
function private __init__() {
    if (!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
}

// Namespace namespace_2831d7ca/namespace_2831d7ca
// Params 3, eflags: 0x0
// Checksum 0x851521f9, Offset: 0x130
// Size: 0x390
function start(supplydrops = 1, minwaittime = 20, var_8a59dd13 = 20) {
    level flagsys::wait_till(#"hash_405e46788e83af41");
    /#
        if (isarray(minwaittime)) {
            foreach (key, value in minwaittime) {
                minwaittime[key] = minwaittime[key] / level.deathcircletimescale;
            }
        } else {
            minwaittime /= level.deathcircletimescale;
        }
        if (isarray(var_8a59dd13)) {
            foreach (key, value in var_8a59dd13) {
                var_8a59dd13[key] = var_8a59dd13[key] / level.deathcircletimescale;
            }
        } else {
            var_8a59dd13 /= level.deathcircletimescale;
        }
    #/
    var_ccae32e8 = 0;
    while (true) {
        if (!isdefined(level.deathcircleindex)) {
            return;
        }
        deathcircle = level.deathcircles[level.deathcircleindex];
        var_2c8aa476 = minwaittime;
        if (isarray(minwaittime)) {
            var_2c8aa476 = minwaittime[int(min(var_ccae32e8, minwaittime.size - 1))];
        }
        var_8bc6c193 = var_8a59dd13;
        if (isarray(var_8a59dd13)) {
            var_8bc6c193 = var_8a59dd13[int(min(var_ccae32e8, var_8a59dd13.size - 1))];
        }
        waitsec = deathcircle.waitsec;
        scalesec = deathcircle.scalesec;
        circletime = waitsec + scalesec;
        waittime = circletime - var_8bc6c193;
        if (waittime > var_2c8aa476) {
            wait randomfloatrange(var_2c8aa476, waittime);
            level thread item_supply_drop::function_50a4cbe6();
            var_ccae32e8++;
        }
        if (var_ccae32e8 >= supplydrops) {
            return;
        }
        level waittill(#"hash_1ff3496c9049969");
    }
}

