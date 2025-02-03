#using scripts\core_common\bots\bot;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\laststand;

#namespace rat;

/#

    // Namespace rat/wz_rat
    // Params 0, eflags: 0x6
    // Checksum 0x4f5cd316, Offset: 0xa0
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"wz_rat", &preinit, undefined, undefined, undefined);
    }

    // Namespace rat/wz_rat
    // Params 0, eflags: 0x4
    // Checksum 0x8ad9a2d1, Offset: 0xe8
    // Size: 0x1b4
    function private preinit() {
        init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        level.rat.deathcount = 0;
        addratscriptcmd("<dev string:x38>", &function_70f41194);
        addratscriptcmd("<dev string:x55>", &function_31980089);
        addratscriptcmd("<dev string:x67>", &function_1251949b);
        addratscriptcmd("<dev string:x7c>", &function_684893c8);
        addratscriptcmd("<dev string:x8f>", &function_7eabbc02);
        addratscriptcmd("<dev string:x9d>", &function_d50abf44);
        addratscriptcmd("<dev string:xb0>", &function_89684f6a);
        addratscriptcmd("<dev string:xc7>", &function_4bf92a0d);
        setdvar(#"rat_death_count", 0);
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x7f3b63a7, Offset: 0x2a8
    // Size: 0x1e
    function function_d50abf44(*params) {
        return level.players.size;
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xb2bd0c43, Offset: 0x2d0
    // Size: 0x15c
    function function_7eabbc02(params) {
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
                if (!isdefined(level.players[i].bot) || level.players[i].team == hostteam || level.players[i].team == "<dev string:xd5>") {
                    continue;
                }
                bot::remove_bot(level.players[i]);
            }
        }
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xa641094e, Offset: 0x438
    // Size: 0xbc
    function function_684893c8(*params) {
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
    // Checksum 0x8a032a9a, Offset: 0x500
    // Size: 0x4c
    function function_1251949b(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player laststand::player_is_in_laststand();
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xe6fb9e47, Offset: 0x558
    // Size: 0x4c
    function function_70f41194(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player.inventory.var_c212de25;
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x704fe5df, Offset: 0x5b0
    // Size: 0x238
    function function_31980089(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        numitems = 1000;
        distance = 1000;
        name = "<dev string:xdd>";
        if (isdefined(params.var_1d978d3)) {
            numitems = int(params.var_1d978d3);
        }
        if (isdefined(params.distance)) {
            distance = int(params.distance);
        }
        if (isdefined(params.name)) {
            name = params.name;
        }
        items = item_world::function_2e3efdda(player.origin, undefined, numitems, distance);
        foreach (item in items) {
            if (item.itementry.name == "<dev string:xe1>") {
                continue;
            }
            if (isdefined(params.handler)) {
                if (params.handler != item.itementry.handler && params.handler != "<dev string:xf9>") {
                    continue;
                }
            }
            if (name == "<dev string:xdd>" || item.itementry.name == name) {
                function_55e20e75(params._id, item.origin);
            }
        }
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x30421025, Offset: 0x7f0
    // Size: 0x5e
    function function_89684f6a(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player.inventory.items[5].networkid != 32767;
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xdb05e08, Offset: 0x858
    // Size: 0x4c
    function function_4bf92a0d(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player isonground();
    }

#/
