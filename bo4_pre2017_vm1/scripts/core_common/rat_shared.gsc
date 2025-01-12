#using scripts/core_common/array_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace rat_shared;

/#

    // Namespace rat_shared/rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaf574e3b, Offset: 0xf0
    // Size: 0x11c
    function init() {
        if (!isdefined(level.rat)) {
            level.rat = spawnstruct();
            level.rat.common = spawnstruct();
            level.rat.script_command_list = [];
            addratscriptcmd("<dev string:x28>", &rscteleport);
            addratscriptcmd("<dev string:x31>", &function_edac6d3e);
            addratscriptcmd("<dev string:x41>", &rscsimulatescripterror);
            addratscriptcmd("<dev string:x55>", &rscrecteleport);
        }
    }

    // Namespace rat_shared/rat_shared
    // Params 2, eflags: 0x0
    // Checksum 0x8dc901ff, Offset: 0x218
    // Size: 0x4a
    function addratscriptcmd(commandname, functioncallback) {
        init();
        level.rat.script_command_list[commandname] = functioncallback;
    }

    // Namespace rat_shared/rat_scriptcommand
    // Params 1, eflags: 0x40
    // Checksum 0xfa5fea10, Offset: 0x270
    // Size: 0x10a
    function event_handler[rat_scriptcommand] codecallback_ratscriptcommand(params) {
        init();
        assert(isdefined(params._cmd));
        assert(isdefined(params._id));
        assert(isdefined(level.rat.script_command_list[params._cmd]), "<dev string:x62>" + params._cmd);
        callback = level.rat.script_command_list[params._cmd];
        level thread [[ callback ]](params);
    }

    // Namespace rat_shared/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xf6bf2267, Offset: 0x388
    // Size: 0x17c
    function rscteleport(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        pos = (float(params.x), float(params.y), float(params.z));
        player setorigin(pos);
        if (isdefined(params.ax)) {
            angles = (float(params.ax), float(params.ay), float(params.az));
            player setplayerangles(angles);
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat_shared/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc6a2115c, Offset: 0x510
    // Size: 0x1f4
    function function_edac6d3e(params) {
        foreach (player in level.players) {
            if (!isdefined(player.bot)) {
                continue;
            }
            pos = (float(params.x), float(params.y), float(params.z));
            player setorigin(pos);
            if (isdefined(params.ax)) {
                angles = (float(params.ax), float(params.ay), float(params.az));
                player setplayerangles(angles);
            }
            if (!isdefined(params.all)) {
                break;
            }
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat_shared/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8bbc3e6b, Offset: 0x710
    // Size: 0x8c
    function rscsimulatescripterror(params) {
        if (params.errorlevel == "<dev string:x7e>") {
            assertmsg("<dev string:x84>");
        } else {
            thisdoesntexist.orthis = 0;
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat_shared/rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe5ffa565, Offset: 0x7a8
    // Size: 0x164
    function rscrecteleport(params) {
        println("<dev string:x9d>");
        player = [[ level.rat.common.gethostplayer ]]();
        pos = player getorigin();
        angles = player getplayerangles();
        cmd = "<dev string:xbf>" + pos[0] + "<dev string:xd0>" + pos[1] + "<dev string:xd4>" + pos[2] + "<dev string:xd8>" + angles[0] + "<dev string:xdd>" + angles[1] + "<dev string:xe2>" + angles[2];
        ratrecordmessage(0, "<dev string:xe7>", cmd);
        setdvar("<dev string:xf4>", "<dev string:x110>");
    }

#/
