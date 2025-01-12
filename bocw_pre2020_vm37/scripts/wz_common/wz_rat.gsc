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
    // Checksum 0x68a6f2f, Offset: 0xa0
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"wz_rat", &function_70a657d8, undefined, undefined, undefined);
    }

    // Namespace rat/wz_rat
    // Params 0, eflags: 0x4
    // Checksum 0x83c3771, Offset: 0xe8
    // Size: 0x18c
    function private function_70a657d8() {
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
        setdvar(#"rat_death_count", 0);
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xb86a481d, Offset: 0x280
    // Size: 0x1e
    function function_d50abf44(*params) {
        return level.players.size;
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xc50f828e, Offset: 0x2a8
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
                if (!isdefined(level.players[i].bot) || level.players[i].team == hostteam || level.players[i].team == "<dev string:xc7>") {
                    continue;
                }
                bot::remove_bot(level.players[i]);
            }
        }
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xd586aca6, Offset: 0x410
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
    // Checksum 0x7b0eaeeb, Offset: 0x4d8
    // Size: 0x4c
    function function_1251949b(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player laststand::player_is_in_laststand();
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xabcfdf03, Offset: 0x530
    // Size: 0x4c
    function function_70f41194(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player.inventory.var_c212de25;
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0xbf1431ee, Offset: 0x588
    // Size: 0x238
    function function_31980089(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        numitems = 1000;
        distance = 1000;
        name = "<dev string:xcf>";
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
            if (item.var_a6762160.name == "<dev string:xd3>") {
                continue;
            }
            if (isdefined(params.handler)) {
                if (params.handler != item.var_a6762160.handler && params.handler != "<dev string:xeb>") {
                    continue;
                }
            }
            if (name == "<dev string:xcf>" || item.var_a6762160.name == name) {
                function_55e20e75(params._id, item.origin);
            }
        }
    }

    // Namespace rat/wz_rat
    // Params 1, eflags: 0x0
    // Checksum 0x37a19dc2, Offset: 0x7c8
    // Size: 0x5e
    function function_89684f6a(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player.inventory.items[5].networkid != 32767;
    }

#/
