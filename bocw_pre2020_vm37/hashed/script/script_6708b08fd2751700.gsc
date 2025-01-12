#using script_1029986e2bc8ca8e;
#using script_2618e0f3e5e11649;
#using script_3411bb48d41bd3b;
#using script_6a4a2311f8a4697;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\bots\bot;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace rat;

/#

    // Namespace rat/namespace_7d3a1543
    // Params 0, eflags: 0x6
    // Checksum 0xdca5897e, Offset: 0xc0
    // Size: 0x3c
    function private autoexec __init__system__() {
        system::register(#"hash_2a909a3d7374cf00", &function_70a657d8, undefined, undefined, undefined);
    }

    // Namespace rat/namespace_7d3a1543
    // Params 0, eflags: 0x4
    // Checksum 0xe87a90dc, Offset: 0x108
    // Size: 0x394
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
        addratscriptcmd("<dev string:xc7>", &function_baeffaeb);
        addratscriptcmd("<dev string:xd8>", &function_63a39134);
        addratscriptcmd("<dev string:xee>", &function_d19f7fe9);
        addratscriptcmd("<dev string:x107>", &function_2bd96c6e);
        addratscriptcmd("<dev string:x12a>", &function_ee280019);
        addratscriptcmd("<dev string:x158>", &function_40e4c9de);
        addratscriptcmd("<dev string:x17d>", &function_fea33619);
        addratscriptcmd("<dev string:x19b>", &function_163c296a);
        addratscriptcmd("<dev string:x1b3>", &function_92891f6e);
        addratscriptcmd("<dev string:x1ca>", &function_834d65f9);
        addratscriptcmd("<dev string:x1ee>", &function_ad78fe8a);
        addratscriptcmd("<dev string:x20b>", &function_adb96ff1);
        addratscriptcmd("<dev string:x222>", &function_a93cbd41);
        setdvar(#"rat_death_count", 0);
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x5069e205, Offset: 0x4a8
    // Size: 0x26
    function function_d50abf44(*params) {
        return getplayers().size;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x1de21eff, Offset: 0x4d8
    // Size: 0x19c
    function function_7eabbc02(params) {
        remaining = 0;
        host = [[ level.rat.common.gethostplayer ]]();
        hostteam = host.team;
        if (isdefined(params.remaining)) {
            remaining = int(params.remaining);
        }
        if (isdefined(getplayers())) {
            for (i = 0; i < getplayers().size; i++) {
                if (getplayers().size <= remaining) {
                    break;
                }
                if (!isdefined(getplayers()[i].bot) || getplayers()[i].team == hostteam || getplayers()[i].team == "<dev string:x246>") {
                    continue;
                }
                bot::remove_bot(getplayers()[i]);
            }
        }
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x3a70b959, Offset: 0x680
    // Size: 0xd4
    function function_684893c8(*params) {
        count = 0;
        if (isdefined(getplayers())) {
            foreach (player in getplayers()) {
                if (player laststand::player_is_in_laststand()) {
                    count++;
                }
            }
        }
        return count;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0xa6719ad, Offset: 0x760
    // Size: 0x4c
    function function_1251949b(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player laststand::player_is_in_laststand();
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x235306cc, Offset: 0x7b8
    // Size: 0x4c
    function function_70f41194(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player.inventory.var_c212de25;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x8d0e4b2f, Offset: 0x810
    // Size: 0x238
    function function_31980089(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        numitems = 1000;
        distance = 1000;
        name = "<dev string:x24e>";
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
            if (item.var_a6762160.name == "<dev string:x252>") {
                continue;
            }
            if (isdefined(params.handler)) {
                if (params.handler != item.var_a6762160.handler && params.handler != "<dev string:x26a>") {
                    continue;
                }
            }
            if (name == "<dev string:x24e>" || item.var_a6762160.name == name) {
                function_55e20e75(params._id, item.origin);
            }
        }
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0xe5235782, Offset: 0xa50
    // Size: 0x5e
    function function_89684f6a(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        return player.inventory.items[5].networkid != 32767;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0xc7ebca66, Offset: 0xab8
    // Size: 0xb6
    function function_baeffaeb(*params) {
        player = [[ level.rat.common.gethostplayer ]]();
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        guy = undefined;
        guy = namespace_85745671::function_9d3ad056("<dev string:x272>", player.origin, player.angles, "<dev string:x28b>");
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0xc2be8ea2, Offset: 0xb78
    // Size: 0x24
    function function_63a39134(*params) {
        return zombie_utility::get_current_zombie_count();
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x9e079993, Offset: 0xba8
    // Size: 0xdc
    function function_d19f7fe9(*params) {
        if (isdefined(level.var_2b36f9ae) && isdefined(level.var_2b36f9ae.clusters)) {
            foreach (cluster in level.var_2b36f9ae.clusters) {
                namespace_60c38ce9::function_94825461(cluster);
            }
        }
        namespace_ce1f29cc::function_368a7cde();
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x55a42d0, Offset: 0xc90
    // Size: 0x4c
    function function_2bd96c6e(params) {
        location = level.var_7d45d0d4.locations[params.location];
        return location.var_dcb924fd.content_script_name;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x3149ac8c, Offset: 0xce8
    // Size: 0x42
    function function_40e4c9de(params) {
        location = level.var_7d45d0d4.locations[params.location];
        location.var_dcb924fd = undefined;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x59b2b78f, Offset: 0xd38
    // Size: 0x84
    function function_ee280019(params) {
        location = level.var_7d45d0d4.locations[params.location];
        if (!isdefined(location.var_dcb924fd.var_4272a188)) {
            return;
        }
        function_55e20e75(params._id, location.var_dcb924fd.var_4272a188.origin);
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x2285dc97, Offset: 0xdc8
    // Size: 0xb4
    function function_fea33619(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        location = level.var_7d45d0d4.locations[params.location];
        if (!isdefined(location.var_dcb924fd) || !isdefined(location.var_dcb924fd.var_e55c8b4e)) {
            return 0;
        }
        location.var_dcb924fd.var_4272a188 useby(player);
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x41dea3a6, Offset: 0xe88
    // Size: 0x4c
    function function_163c296a(*params) {
        if (!isdefined(level.var_7d45d0d4.activeobjective)) {
            return "<dev string:x24e>";
        }
        return level.var_7d45d0d4.activeobjective.content_script_name;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0xd72a1017, Offset: 0xee0
    // Size: 0xa8
    function function_92891f6e(params) {
        var_4f7fa3d1 = 1;
        if (params.success === "<dev string:x29c>") {
            var_4f7fa3d1 = 0;
        }
        if (!isdefined(level.var_7d45d0d4.activeobjective)) {
            return 0;
        }
        instance = level.var_7d45d0d4.activeobjective;
        objective_manager::objective_ended(level.var_7d45d0d4.activeobjective, var_4f7fa3d1);
        return instance.success;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x6bb86d6b, Offset: 0xf90
    // Size: 0x184
    function function_834d65f9(params) {
        if (!isdefined(level.var_7d45d0d4.activeobjective) || level.var_7d45d0d4.activeobjective.content_script_name != "<dev string:x2a5>") {
            return;
        }
        var_4f7fa3d1 = 1;
        if (params.success === "<dev string:x29c>") {
            var_4f7fa3d1 = 0;
        }
        instance = level.var_7d45d0d4.activeobjective;
        if (var_4f7fa3d1) {
            level notify(#"timer_defend");
            objective_manager::stop_timer();
        } else {
            foreach (s_instance in instance.var_fe2612fe[#"console"]) {
                s_instance.var_4a416ea9.health = 0;
                s_instance.var_4a416ea9 notify(#"damage");
            }
        }
        return instance.success;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 0, eflags: 0x0
    // Checksum 0x7345652, Offset: 0x1120
    // Size: 0x74
    function function_ad78fe8a() {
        player = [[ level.rat.common.gethostplayer ]]();
        portal = level.var_7d75c960.var_fb516651;
        portal.var_56356783[0].mdl_gameobject gameobjects::use_object_onuse(player);
    }

    // Namespace rat/namespace_7d3a1543
    // Params 0, eflags: 0x0
    // Checksum 0x21e25372, Offset: 0x11a0
    // Size: 0x54
    function function_adb96ff1() {
        instance = level.var_7d45d0d4.activeobjective;
        level.var_7d75c960.var_fb516651.mdl_portal.health = 0;
        return instance.success;
    }

    // Namespace rat/namespace_7d3a1543
    // Params 1, eflags: 0x0
    // Checksum 0x772343f8, Offset: 0x1200
    // Size: 0xe0
    function function_a93cbd41(params) {
        if (!isdefined(level.var_7d45d0d4.activeobjective) || level.var_7d45d0d4.activeobjective.content_script_name != "<dev string:x2b7>") {
            return;
        }
        var_4f7fa3d1 = 1;
        if (params.success === "<dev string:x29c>") {
            var_4f7fa3d1 = 0;
        }
        instance = level.var_7d45d0d4.activeobjective;
        if (var_4f7fa3d1) {
        } else {
            level notify(#"hash_681a588173f0b1d7");
            objective_manager::stop_timer();
        }
        return instance.success;
    }

#/
