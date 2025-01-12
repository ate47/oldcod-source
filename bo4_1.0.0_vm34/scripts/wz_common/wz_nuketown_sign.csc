#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_nuketown_sign;

// Namespace wz_nuketown_sign/wz_nuketown_sign
// Params 0, eflags: 0x2
// Checksum 0xb70e4c6e, Offset: 0xd0
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"wz_nuketown_sign", undefined, &__main__, undefined);
}

// Namespace wz_nuketown_sign/wz_nuketown_sign
// Params 0, eflags: 0x0
// Checksum 0x68e25c81, Offset: 0x110
// Size: 0x34
function __main__() {
    util::waitforclient(0);
    level thread nuked_population_sign_think();
}

// Namespace wz_nuketown_sign/wz_nuketown_sign
// Params 0, eflags: 0x0
// Checksum 0x8d9dc16b, Offset: 0x150
// Size: 0x3b4
function nuked_population_sign_think() {
    var_ab6a11c7 = getent(0, "counter_tens", "targetname");
    var_c1be0d64 = getent(0, "counter_ones", "targetname");
    zone = getent(0, "nuketown_island_zone", "targetname");
    /#
        level thread function_2f03ded(var_ab6a11c7, var_c1be0d64);
    #/
    step = 36;
    ones = -1;
    tens = 0;
    var_ab6a11c7 rotateroll(step, 0.05);
    var_c1be0d64 rotateroll(step, 0.05);
    for (;;) {
        wait 1;
        for (;;) {
            players = [];
            foreach (player in getplayers(0)) {
                if (istouching(player.origin, zone) && !player isplayerswimming()) {
                    if (!isdefined(players)) {
                        players = [];
                    } else if (!isarray(players)) {
                        players = array(players);
                    }
                    players[players.size] = player;
                }
            }
            dial = ones + tens * 10;
            if (players.size < dial) {
                ones--;
                time = set_dvar_float_if_unset("scr_dial_rotate_time", "0.5");
                if (ones < 0) {
                    ones = 9;
                    var_ab6a11c7 rotateroll(0 - step, time);
                    tens--;
                }
                var_c1be0d64 rotateroll(0 - step, time);
                var_c1be0d64 waittill(#"rotatedone");
                continue;
            }
            if (players.size > dial) {
                ones++;
                time = set_dvar_float_if_unset("scr_dial_rotate_time", "0.5");
                if (ones > 9) {
                    ones = 0;
                    var_ab6a11c7 rotateroll(step, time);
                    tens++;
                }
                var_c1be0d64 rotateroll(step, time);
                var_c1be0d64 waittill(#"rotatedone");
                continue;
            }
            break;
        }
    }
}

// Namespace wz_nuketown_sign/wz_nuketown_sign
// Params 2, eflags: 0x0
// Checksum 0x35f0e7d4, Offset: 0x510
// Size: 0x6a
function set_dvar_float_if_unset(dvar, value) {
    if (getdvarstring(dvar) == "") {
        setdvar(dvar, value);
    }
    return getdvarfloat(dvar, 0);
}

/#

    // Namespace wz_nuketown_sign/wz_nuketown_sign
    // Params 2, eflags: 0x0
    // Checksum 0x1f75a677, Offset: 0x588
    // Size: 0x4e
    function function_2f03ded(tens, ones) {
        while (!isdefined(tens) || !isdefined(ones)) {
            iprintlnbold("<dev string:x30>");
            wait 2;
        }
    }

#/
