#using scripts\core_common\bots\bot;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\item_world;
#using scripts\mp_common\laststand_warzone;

#namespace rat;

/#

    // Namespace rat/wz_rat
    // Params 0, eflags: 0x2
    // Checksum 0x90e2021, Offset: 0xa8
    // Size: 0x3c
    function autoexec __init__system__() {
        system::register(#"wz_rat", &__init__, undefined, undefined);
    }

    // Namespace rat/wz_rat
    // Params 0, eflags: 0x0
    // Checksum 0x93c5c6d2, Offset: 0xf0
    // Size: 0x18c
    function __init__() {
        init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        level.rat.deathcount = 0;
        addratscriptcmd("<dev string:x30>", &function_cc4f8c21);
        addratscriptcmd("<dev string:x4a>", &function_99741d8c);
        addratscriptcmd("<dev string:x59>", &function_f2db77a8);
        addratscriptcmd("<dev string:x6b>", &function_d1ba1c27);
        addratscriptcmd("<dev string:x7b>", &function_84a87135);
        addratscriptcmd("<dev string:x86>", &function_c6978d93);
        addratscriptcmd("<dev string:x96>", &function_4f3a2f60);
        setdvar(#"rat_death_count", 0);
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x20ea111d, Offset: 0x288
    // Size: 0x1e
    function function_c6978d93(params) {
        return level.players.size;
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xbbd88d76, Offset: 0x2b0
    // Size: 0x166
    function function_84a87135(params) {
        remaining = 0;
        host = [[ level.rat.common.gethostplayer ]]();
        hostteam = host.team;
        if (isdefined(params.remaining)) {
            remaining = int(params.remaining);
        }
        if (isdefined(level.players)) {
            for (i = 0; i < level.players.size; i++) {
                if (level.players.size <= remaining) {
                    break;
                }
                if (!isdefined(level.players[i].bot) || level.players[i].team == hostteam || level.players[i].team == "<dev string:xaa>") {
                    continue;
                }
                bot::remove_bot(level.players[i]);
            }
        }
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x951c3f8, Offset: 0x420
    // Size: 0xb6
    function function_d1ba1c27(params) {
        count = 0;
        if (isdefined(level.players)) {
            foreach (player in level.players) {
                if (player laststand::player_is_in_laststand()) {
                    count++;
                }
            }
        }
        return count;
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x89d1e365, Offset: 0x4e0
    // Size: 0x4c
    function function_f2db77a8(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player laststand::player_is_in_laststand();
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x4d1da3c9, Offset: 0x538
    // Size: 0x50
    function function_cc4f8c21(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player.inventory.var_7d6932b1;
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xaf1badc7, Offset: 0x590
    // Size: 0x248
    function function_99741d8c(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        numitems = 1000;
        distance = 1000;
        name = "<dev string:xaf>";
        if (isdefined(params.var_ace83db6)) {
            numitems = int(params.var_ace83db6);
        }
        if (isdefined(params.distance)) {
            distance = int(params.distance);
        }
        if (isdefined(params.name)) {
            name = params.name;
        }
        items = item_world::function_33d2057a(player.origin, undefined, numitems, distance);
        foreach (item in items) {
            if (item.itementry.name == "<dev string:xb0>") {
                continue;
            }
            if (isdefined(params.handler)) {
                if (params.handler != item.itementry.handler && params.handler != "<dev string:xc5>") {
                    continue;
                }
            }
            if (name == "<dev string:xaf>" || item.itementry.name == name) {
                function_dd184abd(params._id, item.origin);
            }
        }
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x9bfb6149, Offset: 0x7e0
    // Size: 0x62
    function function_4f3a2f60(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player.inventory.items[10].networkid != 32767;
    }

#/
