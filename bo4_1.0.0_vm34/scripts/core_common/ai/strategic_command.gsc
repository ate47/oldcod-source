#using scripts\core_common\ai\planner_squad;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_chain;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;

#namespace strategic_command;

// Namespace strategic_command/strategic_command
// Params 0, eflags: 0x2
// Checksum 0x424980a9, Offset: 0x2b0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"strategic_command", &strategiccommandutility::__init__, undefined, undefined);
}

#namespace strategiccommandutility;

// Namespace strategiccommandutility/strategic_command
// Params 0, eflags: 0x4
// Checksum 0x139d19ea, Offset: 0x2f8
// Size: 0xec
function private __init__() {
    /#
        level thread _debuggameobjects();
        level thread function_a39e45a9();
        level thread function_eb077221();
        level thread function_d3861cae();
        level thread function_aabacaa7();
    #/
    if (!isdefined(level.strategic_command_throttle)) {
        level.strategic_command_throttle = new throttle();
        [[ level.strategic_command_throttle ]]->initialize(1, float(function_f9f48566()) / 1000);
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x4
// Checksum 0x751766ca, Offset: 0x3f0
// Size: 0x19e
function private function_4abff4af(entity, points) {
    path = undefined;
    shortestpath = undefined;
    start = entity getclosestpointonnavvolume(entity.origin, 200);
    for (index = 0; index < points.size; index += 16) {
        goalpoints = [];
        for (goalindex = index; goalindex - index < 16 && goalindex < points.size; goalindex++) {
            goalpoints[goalpoints.size] = entity getclosestpointonnavvolume(points[goalindex].origin, 200);
        }
        possiblepath = function_c98422e0(start, goalpoints, entity);
        if (isdefined(possiblepath) && possiblepath.status === "succeeded") {
            if (!isdefined(shortestpath) || possiblepath.pathdistance < shortestpath) {
                path = possiblepath;
                shortestpath = possiblepath.pathdistance;
                return path;
            }
        }
    }
    return path;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x4
// Checksum 0xf4062c6a, Offset: 0x598
// Size: 0x210
function private _calculatepathtopoints(entity, points) {
    path = undefined;
    shortestpath = undefined;
    entradius = entity getpathfindingradius();
    entposition = getclosestpointonnavmesh(entity.origin, 200, entradius);
    for (index = 0; index < points.size; index += 16) {
        goalpoints = [];
        for (goalindex = index; goalindex - index < 16 && goalindex < points.size; goalindex++) {
            if (ispointonnavmesh(points[goalindex].origin, entradius)) {
                goalpoints[goalpoints.size] = points[goalindex].origin;
            }
        }
        if (isbot(entity)) {
            possiblepath = generatenavmeshpath(entposition, goalpoints, entity, undefined, undefined, 5000);
        } else {
            possiblepath = generatenavmeshpath(entposition, goalpoints, undefined, undefined, undefined, 5000);
        }
        if (isdefined(possiblepath) && possiblepath.status === "succeeded") {
            if (!isdefined(shortestpath) || possiblepath.pathdistance < shortestpath) {
                path = possiblepath;
                shortestpath = possiblepath.pathdistance;
            }
        }
    }
    return path;
}

/#

    // Namespace strategiccommandutility/strategic_command
    // Params 1, eflags: 0x4
    // Checksum 0x44c2e427, Offset: 0x7b0
    // Size: 0x152
    function private function_ee925b95(members) {
        var_8ae2dd4e = 0;
        working = array();
        foreach (member in members) {
            entnum = member getentitynumber();
            working[entnum] = member;
            if (entnum > var_8ae2dd4e) {
                var_8ae2dd4e = entnum;
            }
        }
        sorted = array();
        for (index = 0; index <= var_8ae2dd4e; index++) {
            if (isdefined(working[index])) {
                sorted[sorted.size] = working[index];
            }
        }
        return sorted;
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 3, eflags: 0x4
    // Checksum 0xc5ce0fa0, Offset: 0x910
    // Size: 0x200
    function private function_947f5c19(commander, member, vehicle = undefined) {
        if (isdefined(vehicle)) {
            occupant = vehicle getseatoccupant(0);
            if (isplayer(occupant) && !isbot(occupant)) {
                return "<dev string:x30>";
            }
            if (isdefined(vehicle.attachedpath)) {
                return "<dev string:x37>";
            }
            if (member bot_chain::function_3a0e73ad()) {
                return "<dev string:x3e>";
            }
            if (isdefined(commander) && !commander.pause && function_fe34c4b4(member)) {
                return "<dev string:x48>";
            }
            if (vehicle.goalforced) {
                return "<dev string:x52>";
            }
        } else {
            autonomous = ai::getaiattribute(member, "<dev string:x5b>") == "<dev string:x63>";
            if (function_d5770bb4(member) || function_60baf68b(member)) {
                return "<dev string:x6e>";
            }
            if (autonomous) {
                if (member bot_chain::function_3a0e73ad()) {
                    return "<dev string:x3e>";
                }
                return "<dev string:x52>";
            }
            if (isdefined(commander) && !commander.pause && isvalidbot(member)) {
                return "<dev string:x48>";
            }
        }
        return "<dev string:x76>";
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 1, eflags: 0x4
    // Checksum 0x70a4c39b, Offset: 0xb18
    // Size: 0xa8
    function private function_b0f700a6(var_9fe81aac) {
        switch (var_9fe81aac) {
        case #"bot chain":
        case #"spline":
            return (0, 1, 0);
        case #"scripted":
            return (1, 0, 0);
        case #"commander":
        case #"player":
        case #"vehicle":
            return (1, 0.5, 0);
        }
        return (1, 0, 0);
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 4, eflags: 0x4
    // Checksum 0x74acb05f, Offset: 0xbc8
    // Size: 0x36a
    function private function_ee24bb8c(member, vehicle, commander, var_9fe81aac) {
        switch (var_9fe81aac) {
        case #"bot chain":
            if (isdefined(member.bot.var_7ef83d.startstruct)) {
                return ("<dev string:x7e>" + member.bot.var_7ef83d.startstruct.targetname + "<dev string:x86>");
            }
        case #"commander":
            foreach (squad in commander.squads) {
                bots = plannersquadutility::getblackboardattribute(squad, "<dev string:x88>");
                if (bots.size > 0 && bots[0][#"entnum"] == member getentitynumber()) {
                    target = plannersquadutility::getblackboardattribute(squad, "<dev string:x93>");
                    if (isdefined(target)) {
                        bundle = target[#"__unsafe__"][#"bundle"];
                        missioncomponent = target[#"__unsafe__"][#"mission_component"];
                        if (isdefined(missioncomponent)) {
                            return missioncomponent.scriptbundlename;
                        }
                        object = target[#"__unsafe__"][#"object"];
                        if (isdefined(object) && isdefined(object.e_object) && isdefined(object.e_object.scriptbundlename)) {
                            return object.e_object.scriptbundlename;
                        }
                    }
                    order = plannersquadutility::getblackboardattribute(squad, "<dev string:x9a>");
                    return order;
                }
            }
            break;
        }
        if (isdefined(vehicle)) {
            switch (var_9fe81aac) {
            case #"spline":
                return vehicle.attachedpath.targetname;
            }
            return;
        }
        switch (var_9fe81aac) {
        case #"vehicle":
            vehicle = member getvehicleoccupied();
            if (isdefined(vehicle)) {
                return vehicle.vehicleclass;
            }
            break;
        }
    }

#/

// Namespace strategiccommandutility/strategic_command
// Params 3, eflags: 0x4
// Checksum 0xd71cd646, Offset: 0xf40
// Size: 0x2bc
function private function_3982de09(var_179f4e3e, var_986dcdf9, commander) {
    /#
        if (!isdefined(commander)) {
            return var_986dcdf9;
        }
        var_2974d58a = 0;
        yspacing = 27;
        textcolor = (1, 1, 1);
        textalpha = 1;
        backgroundcolor = (0, 0, 0);
        backgroundalpha = 0.8;
        textsize = 1.25;
        team = blackboard::getstructblackboardattribute(commander, #"team");
        paused = isdefined(commander.pause) && commander.pause;
        squadcount = commander.squads.size;
        debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xa0>" + function_15979fa9(team) + "<dev string:x86>", textcolor, textalpha, backgroundcolor, backgroundalpha, textsize);
        var_179f4e3e += var_2974d58a;
        var_986dcdf9 += yspacing;
        var_179f4e3e += 25;
        debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xac>" + squadcount, !paused && squadcount > 0 || paused && squadcount == 0 ? (0, 1, 0) : (1, 0.5, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
        var_179f4e3e += var_2974d58a;
        var_986dcdf9 += yspacing;
        debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xb5>" + (paused ? "<dev string:xbe>" : "<dev string:xc5>"), paused ? (0, 1, 0) : (1, 0.5, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
        var_179f4e3e += var_2974d58a;
        var_986dcdf9 += yspacing;
    #/
    return var_986dcdf9;
}

// Namespace strategiccommandutility/strategic_command
// Params 4, eflags: 0x4
// Checksum 0xafdef57f, Offset: 0x1208
// Size: 0xab0
function private function_e35abbd6(var_179f4e3e, var_986dcdf9, members, commander) {
    /#
        var_2974d58a = 0;
        yspacing = 27;
        textcolor = (1, 1, 1);
        textalpha = 1;
        backgroundcolor = (0, 0, 0);
        backgroundalpha = 0.8;
        textsize = 1.25;
        var_61e7a8e7 = 350;
        var_3e3ecdee = 25;
        foreach (member in members) {
            yoffset = var_986dcdf9;
            debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xcd>" + member getentitynumber() + "<dev string:xd0>" + member.name + "<dev string:xd2>" + function_15979fa9(member.team) + "<dev string:x86>", textcolor, textalpha, backgroundcolor, backgroundalpha, textsize);
            var_179f4e3e += var_2974d58a;
            var_986dcdf9 += yspacing;
            var_179f4e3e += var_3e3ecdee;
            var_9fe81aac = function_947f5c19(commander, member);
            debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xd5>" + (member isplayinganimscripted() ? "<dev string:xe4>" : "<dev string:xe7>"), member isplayinganimscripted() ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
            var_179f4e3e += var_2974d58a;
            var_986dcdf9 += yspacing;
            debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xeb>" + var_9fe81aac, function_b0f700a6(var_9fe81aac), textalpha, backgroundcolor, backgroundalpha, textsize);
            var_179f4e3e += var_2974d58a;
            var_986dcdf9 += yspacing;
            var_8a550557 = function_ee24bb8c(member, undefined, commander, var_9fe81aac);
            if (isdefined(var_8a550557)) {
                var_179f4e3e += var_3e3ecdee;
                debug2dtext((var_179f4e3e, var_986dcdf9, 0), var_8a550557, function_b0f700a6(var_9fe81aac), textalpha, backgroundcolor, backgroundalpha, textsize);
                var_179f4e3e += var_2974d58a;
                var_986dcdf9 += yspacing;
                var_179f4e3e -= var_3e3ecdee;
            }
            debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xfa>" + (member.ignoreme ? "<dev string:xe4>" : "<dev string:xe7>"), member.ignoreme ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
            var_179f4e3e += var_2974d58a;
            var_986dcdf9 += yspacing;
            debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:x105>" + (member.ignoreall ? "<dev string:xe4>" : "<dev string:xe7>"), member.ignoreall ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
            var_179f4e3e += var_2974d58a;
            var_986dcdf9 += yspacing;
            debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:x111>" + (member.takedamage ? "<dev string:xe4>" : "<dev string:xe7>"), member.takedamage ? (0, 1, 0) : (1, 0.5, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
            var_179f4e3e += var_2974d58a;
            var_986dcdf9 += yspacing;
            newyoffset = var_986dcdf9;
            if (member isinvehicle()) {
                vehicle = member getvehicleoccupied();
                seatnum = vehicle getoccupantseat(member);
                var_986dcdf9 = yoffset;
                var_179f4e3e += var_61e7a8e7;
                debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xcd>" + vehicle getentitynumber() + "<dev string:xd0>" + vehicle.scriptvehicletype + "<dev string:xd2>" + function_15979fa9(vehicle.team) + "<dev string:x86>", textcolor, textalpha, backgroundcolor, backgroundalpha, textsize);
                var_179f4e3e += var_2974d58a;
                var_986dcdf9 += yspacing;
                var_179f4e3e += var_3e3ecdee;
                var_9fe81aac = function_947f5c19(commander, member, vehicle);
                debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xd5>" + (vehicle isplayinganimscripted() ? "<dev string:xe4>" : "<dev string:xe7>"), vehicle isplayinganimscripted() ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
                var_179f4e3e += var_2974d58a;
                var_986dcdf9 += yspacing;
                debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xeb>" + var_9fe81aac, function_b0f700a6(var_9fe81aac), textalpha, backgroundcolor, backgroundalpha, textsize);
                var_179f4e3e += var_2974d58a;
                var_986dcdf9 += yspacing;
                var_8a550557 = function_ee24bb8c(member, vehicle, commander, var_9fe81aac);
                if (isdefined(var_8a550557)) {
                    var_179f4e3e += var_3e3ecdee;
                    debug2dtext((var_179f4e3e, var_986dcdf9, 0), var_8a550557, function_b0f700a6(var_9fe81aac), textalpha, backgroundcolor, backgroundalpha, textsize);
                    var_179f4e3e += var_2974d58a;
                    var_986dcdf9 += yspacing;
                    var_179f4e3e -= var_3e3ecdee;
                }
                debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:xfa>" + (vehicle.ignoreme ? "<dev string:xe4>" : "<dev string:xe7>"), vehicle.ignoreme ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
                var_179f4e3e += var_2974d58a;
                var_986dcdf9 += yspacing;
                debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:x105>" + (vehicle.ignoreall ? "<dev string:xe4>" : "<dev string:xe7>"), vehicle.ignoreall ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
                var_179f4e3e += var_2974d58a;
                var_986dcdf9 += yspacing;
                debug2dtext((var_179f4e3e, var_986dcdf9, 0), "<dev string:x111>" + (vehicle.takedamage ? "<dev string:xe4>" : "<dev string:xe7>"), vehicle.takedamage ? (0, 1, 0) : (1, 0.5, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
                var_179f4e3e += var_2974d58a;
                var_986dcdf9 += yspacing;
                var_986dcdf9 = newyoffset;
                var_179f4e3e -= var_61e7a8e7;
                var_179f4e3e -= var_3e3ecdee;
            }
            var_179f4e3e -= var_3e3ecdee;
            var_986dcdf9 += 10;
        }
    #/
    return var_986dcdf9;
}

/#

    // Namespace strategiccommandutility/strategic_command
    // Params 0, eflags: 0x4
    // Checksum 0x6dcaf28e, Offset: 0x1cc0
    // Size: 0x2e2
    function private function_aabacaa7() {
        xoffset = 150;
        yoffset = 100;
        var_5fbc0f2c = 850;
        var_9511f952 = 50;
        for (debugmode = getdvarint(#"hash_2010e59417406d5f", 0); true; debugmode = getdvarint(#"hash_2010e59417406d5f", 0)) {
            waitframe(1);
            var_c7ebff9f = getdvarint(#"hash_2010e59417406d5f", 0);
            if (var_c7ebff9f != 0) {
                if (!debugmode) {
                    /#
                        iprintlnbold("<dev string:x11e>");
                    #/
                }
                var_179f4e3e = xoffset;
                var_986dcdf9 = yoffset;
                var_18c68a13 = 0;
                if (var_c7ebff9f != 3) {
                    var_18c68a13 = function_3982de09(var_179f4e3e, var_986dcdf9, level.alliescommander);
                    var_179f4e3e += var_5fbc0f2c;
                }
                if (var_c7ebff9f != 2) {
                    var_18c68a13 = function_3982de09(var_179f4e3e, var_986dcdf9, level.axiscommander);
                }
                var_179f4e3e = xoffset;
                var_986dcdf9 = var_18c68a13 + var_9511f952;
                if (var_c7ebff9f != 3) {
                    allies = function_ee925b95(util::get_bot_players(#"allies"));
                    function_e35abbd6(var_179f4e3e, var_986dcdf9, allies, level.alliescommander);
                    var_179f4e3e += var_5fbc0f2c;
                    var_986dcdf9 = var_18c68a13 + var_9511f952;
                }
                if (var_c7ebff9f != 2) {
                    axis = function_ee925b95(util::get_bot_players(#"axis"));
                    function_e35abbd6(var_179f4e3e, var_986dcdf9, axis, level.axiscommander);
                }
                continue;
            }
            if (debugmode) {
                /#
                    iprintlnbold("<dev string:x134>");
                #/
            }
        }
    }

#/

// Namespace strategiccommandutility/strategic_command
// Params 0, eflags: 0x4
// Checksum 0xc7126568, Offset: 0x1fb0
// Size: 0xd4
function private _debuggameobjects() {
    while (true) {
        waitframe(1);
        /#
            if (!getdvarint(#"ai_debuggameobjects", 0) || !isdefined(level.a_gameobjects)) {
                continue;
            }
            foreach (gameobject in level.a_gameobjects) {
                function_f18098bc(gameobject);
            }
        #/
    }
}

/#

    // Namespace strategiccommandutility/strategic_command
    // Params 0, eflags: 0x4
    // Checksum 0x5aa9cd48, Offset: 0x2090
    // Size: 0xaa
    function private function_a39e45a9() {
        while (true) {
            waitframe(1);
            if (!getdvarint(#"hash_1e47802a0e8997e3", 0) || !isdefined(level.var_76ffb58b)) {
                continue;
            }
            for (i = 0; i < level.var_76ffb58b.size; i++) {
                function_7aa1ebac(level.var_76ffb58b[i], i);
            }
        }
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 0, eflags: 0x4
    // Checksum 0x7c363319, Offset: 0x2148
    // Size: 0xaa
    function private function_eb077221() {
        while (true) {
            waitframe(1);
            if (!getdvarint(#"hash_2e02207d5878b8eb", 0) || !isdefined(level.a_s_breadcrumbs)) {
                continue;
            }
            for (i = 0; i < level.a_s_breadcrumbs.size; i++) {
                function_227d434(level.a_s_breadcrumbs[i], i);
            }
        }
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 2, eflags: 0x4
    // Checksum 0xc16b6b1, Offset: 0x2200
    // Size: 0x5dc
    function private function_7aa1ebac(missioncomponent, index) {
        if (!isdefined(index)) {
            index = "<dev string:x14b>";
        }
        /#
            origin = missioncomponent.origin;
            identifiertext = missioncomponent.scriptbundlename + "<dev string:xd2>" + index + "<dev string:x86>";
            origintext = "<dev string:x14d>" + int(origin[0]) + "<dev string:x155>" + int(origin[1]) + "<dev string:x155>" + int(origin[2]) + "<dev string:x158>";
            var_5efb9c57 = "<dev string:x15b>" + missioncomponent.script_team + "<dev string:x86>";
            var_d659535 = "<dev string:x161>" + (isdefined(missioncomponent.var_24319d1) ? "<dev string:x172>" : "<dev string:x178>");
            var_c5187a1d = "<dev string:x17f>" + (isdefined(missioncomponent.var_5018173b) ? missioncomponent.var_5018173b : "<dev string:x187>") + "<dev string:x86>";
            var_eb1af486 = "<dev string:x188>" + (isdefined(missioncomponent.var_de10a800) ? missioncomponent.var_de10a800 : "<dev string:x187>") + "<dev string:x86>";
            statustext = "<dev string:x190>";
            statuscolor = (1, 1, 1);
            tacpointtext = "<dev string:x19c>";
            errortext = undefined;
            component = missioncomponent.var_a06b4dbd;
            if (isdefined(component) && missioncomponent flag::get("<dev string:x1aa>")) {
                statustext = "<dev string:x1b2>";
                statuscolor = (0, 1, 0);
                gameobject = component.e_objective;
                var_fc501a8d = undefined;
                if (isdefined(gameobject)) {
                    var_fc501a8d = gameobject.mdl_gameobject.trigger;
                    function_f18098bc(gameobject.mdl_gameobject);
                    recordline(origin, gameobject.mdl_gameobject.origin, statuscolor, "<dev string:x1ba>");
                } else {
                    if (isdefined(component.var_d9c3be3e)) {
                        var_fc501a8d = component.var_d9c3be3e;
                        function_71fd190d(component.var_d9c3be3e, statuscolor, "<dev string:x1ba>");
                        recordline(origin, component.var_d9c3be3e.origin, statuscolor, "<dev string:x1ba>");
                        record3dtext("<dev string:x1c5>", component.var_d9c3be3e.origin + (0, 0, -5), statuscolor, "<dev string:x1ba>");
                    }
                    if (isdefined(component.var_2b8386bb)) {
                        function_71fd190d(component.var_2b8386bb, statuscolor, "<dev string:x1ba>");
                        recordline(origin, component.var_2b8386bb.origin, statuscolor, "<dev string:x1ba>");
                        record3dtext("<dev string:x1d5>", component.var_2b8386bb.origin + (0, 0, 5), statuscolor, "<dev string:x1ba>");
                    }
                }
                if (isdefined(var_fc501a8d)) {
                    points = tacticalquery(#"stratcom_tacquery_trigger", var_fc501a8d);
                    tacpointtext = "<dev string:x1e9>" + points.size + "<dev string:x86>";
                    if (points.size == 0) {
                        errortext = "<dev string:x1f5>";
                    }
                } else if (!isdefined(component.var_2b8386bb)) {
                    errortext = "<dev string:x20d>";
                }
            } else if (missioncomponent flag::get("<dev string:x21d>")) {
                statustext = "<dev string:x21d>";
                statuscolor = (0.1, 0.1, 0.1);
            }
            textcolor = isdefined(errortext) ? (1, 0, 0) : (1, 1, 1);
            function_e745173a(origin, textcolor, "<dev string:x1ba>", identifiertext, statustext, origintext, var_5efb9c57, var_d659535, var_c5187a1d, var_eb1af486, tacpointtext, errortext);
            recordsphere(origin, 20, statuscolor);
        #/
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 2, eflags: 0x4
    // Checksum 0x61b3ddec, Offset: 0x27e8
    // Size: 0x79c
    function private function_f18098bc(gameobject, position) {
        /#
            entnum = gameobject getentitynumber();
            origin = gameobject.origin;
            identifiertext = (isdefined(gameobject gameobjects::get_identifier()) ? gameobject gameobjects::get_identifier() : "<dev string:x226>") + "<dev string:x231>" + entnum + "<dev string:x86>";
            var_96eb3490 = "<dev string:x235>" + gameobject.type + "<dev string:x86>";
            origintext = "<dev string:x14d>" + int(origin[0]) + "<dev string:x155>" + int(origin[1]) + "<dev string:x155>" + int(origin[2]) + "<dev string:x158>";
            var_8e82e9ce = "<dev string:x23b>";
            var_bab55dc5 = "<dev string:x248>";
            var_5efb9c57 = "<dev string:x15b>" + function_15979fa9(gameobject.team) + "<dev string:x86>";
            var_a7b0d07c = "<dev string:x257>" + (isdefined(gameobject.absolute_visible_and_interact_team) ? function_15979fa9(gameobject.absolute_visible_and_interact_team) : "<dev string:x187>") + "<dev string:x86>";
            tacpointtext = "<dev string:x19c>";
            errortext = undefined;
            var_7e55faed = "<dev string:x187>";
            var_7d85dc2e = "<dev string:x187>";
            var_b08a6238 = "<dev string:x266>";
            if (isdefined(gameobject.identifier)) {
                var_b08a6238 += gameobject.identifier;
            }
            var_b08a6238 += "<dev string:x86>";
            var_c29e7436 = undefined;
            var_505f6d31 = undefined;
            if (isdefined(gameobject.e_object)) {
                var_8e82e9ce = "<dev string:x271>" + (isdefined(gameobject.e_object.targetname) ? gameobject.e_object.targetname : "<dev string:x187>") + "<dev string:x86>";
                if (isdefined(gameobject.e_object.scriptbundlename)) {
                    var_bab55dc5 = "<dev string:x27d>" + gameobject.e_object.scriptbundlename + "<dev string:x86>";
                    gameobjectbundle = getscriptbundle(gameobject.e_object.scriptbundlename);
                    if (isdefined(gameobjectbundle)) {
                        var_c29e7436 = gameobjectbundle.var_5018173b;
                        var_505f6d31 = gameobjectbundle.var_de10a800;
                    }
                }
            }
            if (isdefined(gameobject.s_minigame) && isdefined(gameobject.s_minigame.var_fe880250) && isdefined(gameobject.s_minigame.var_fe880250.var_aba2d232)) {
                foreach (location in gameobject.s_minigame.var_fe880250.var_aba2d232) {
                    if (location.mdl_gameobject === gameobject) {
                        if (isdefined(gameobject.s_minigame.var_5018173b)) {
                            var_c29e7436 = gameobject.s_minigame.var_5018173b;
                            var_7e55faed = "<dev string:x28b>";
                        }
                        if (isdefined(gameobject.s_minigame.var_de10a800)) {
                            var_505f6d31 = gameobject.s_minigame.var_de10a800;
                            var_7d85dc2e = "<dev string:x28b>";
                        }
                        break;
                    }
                }
            }
            var_c5187a1d = "<dev string:x17f>" + (isdefined(var_c29e7436) ? var_c29e7436 : "<dev string:x187>") + "<dev string:x86>" + var_7e55faed;
            var_eb1af486 = "<dev string:x188>" + (isdefined(var_505f6d31) ? var_505f6d31 : "<dev string:x187>") + "<dev string:x86>" + var_7d85dc2e;
            statuscolor = gameobject.type !== "<dev string:x297>" ? (1, 1, 1) : (0.1, 0.1, 0.1);
            if (isdefined(gameobject.trigger) && gameobject.trigger istriggerenabled()) {
                points = tacticalquery(#"stratcom_tacquery_trigger", gameobject.trigger);
                tacpointtext = "<dev string:x1e9>" + points.size + "<dev string:x86>";
                if (points.size == 0) {
                    errortext = "<dev string:x1f5>";
                }
                statuscolor = (0, 1, 1);
                function_71fd190d(gameobject.trigger, statuscolor, "<dev string:x1ba>");
                recordline(origin, gameobject.trigger.origin, statuscolor, "<dev string:x1ba>");
                record3dtext("<dev string:x2a5>", gameobject.trigger.origin + (0, 0, 5), statuscolor, "<dev string:x1ba>");
            }
            textcolor = isdefined(errortext) ? (1, 0, 0) : (1, 1, 1);
            function_e745173a(origin, textcolor, "<dev string:x1ba>", identifiertext, var_96eb3490, var_bab55dc5, origintext, var_8e82e9ce, var_5efb9c57, var_a7b0d07c, var_c5187a1d, var_eb1af486, tacpointtext, var_b08a6238, errortext);
            recordsphere(origin, 17, statuscolor, "<dev string:x1ba>");
        #/
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 2, eflags: 0x4
    // Checksum 0xd3a21feb, Offset: 0x2f90
    // Size: 0x2d4
    function private function_227d434(breadcrumb, index) {
        if (!isdefined(index)) {
            index = "<dev string:x14b>";
        }
        /#
            origin = breadcrumb.origin;
            identifiertext = "<dev string:x2b8>" + index + "<dev string:x86>";
            origintext = "<dev string:x14d>" + int(origin[0]) + "<dev string:x155>" + int(origin[1]) + "<dev string:x155>" + int(origin[2]) + "<dev string:x158>";
            var_5efb9c57 = "<dev string:x15b>" + breadcrumb.script_team + "<dev string:x86>";
            statuscolor = (1, 1, 1);
            tacpointtext = "<dev string:x19c>";
            errortext = undefined;
            if (isdefined(breadcrumb.trigger)) {
                statuscolor = (1, 1, 0);
                function_71fd190d(breadcrumb.trigger, (1, 1, 0), "<dev string:x1ba>");
                recordline(origin, breadcrumb.trigger.origin, (1, 1, 0), "<dev string:x1ba>");
                record3dtext("<dev string:x2c4>", breadcrumb.trigger.origin, (1, 1, 0), "<dev string:x1ba>");
                points = tacticalquery(#"stratcom_tacquery_trigger", breadcrumb.trigger);
                tacpointtext = "<dev string:x1e9>" + points.size + "<dev string:x86>";
                if (points.size == 0) {
                    errortext = "<dev string:x1f5>";
                }
            }
            recordsphere(origin, 14, statuscolor);
            textcolor = isdefined(errortext) ? (1, 0, 0) : (1, 1, 1);
            function_e745173a(origin, textcolor, "<dev string:x1ba>", identifiertext, origintext, var_5efb9c57, tacpointtext, errortext);
        #/
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 4, eflags: 0x24 variadic
    // Checksum 0x81bddc01, Offset: 0x3270
    // Size: 0xdc
    function private function_e745173a(pos, color, channel, ...) {
        /#
            recordstr = "<dev string:x187>";
            foreach (str in vararg) {
                if (!isdefined(str)) {
                    continue;
                }
                recordstr += str + "<dev string:x2d6>";
            }
            record3dtext(recordstr, pos, color, channel);
        #/
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 3, eflags: 0x4
    // Checksum 0x60fa3ac, Offset: 0x3358
    // Size: 0x1b4
    function private function_71fd190d(volume, color, channel) {
        /#
            maxs = volume getmaxs();
            mins = volume getmins();
            if (issubstr(volume.classname, "<dev string:x2da>")) {
                radius = max(maxs[0], maxs[1]);
                top = volume.origin + (0, 0, maxs[2]);
                bottom = volume.origin + (0, 0, mins[2]);
                recordcircle(bottom, radius, color, channel);
                recordcircle(top, radius, color, channel);
                recordline(bottom, top, color, channel);
                return;
            }
            function_1e80dbe9(volume.origin, mins, maxs, volume.angles[0], color, channel);
        #/
    }

    // Namespace strategiccommandutility/strategic_command
    // Params 0, eflags: 0x4
    // Checksum 0xf6ca6cea, Offset: 0x3518
    // Size: 0x48e
    function private function_d3861cae() {
        while (true) {
            if (getdvarint(#"hash_53bff1e7234da64b", 0)) {
                offset = 30;
                position = (0, 0, 0);
                xoffset = 0;
                yoffset = 10;
                textscale = 0.7;
                var_6f02abfe = 0;
                if (isdefined(level.var_1166849)) {
                    var_6f02abfe = level.var_1166849.size;
                }
                recordtext("<dev string:x2e1>" + var_6f02abfe, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x1ba>", textscale);
                yoffset += 13;
                assaultobjects = 0;
                defendobjects = 0;
                botcount = 0;
                objectivecount = 0;
                targetcount = 0;
                for (index = 0; index < var_6f02abfe; index++) {
                    commander = level.var_1166849[index];
                    assaultobjects += blackboard::getstructblackboardattribute(commander, #"gameobjects_assault").size;
                    defendobjects += blackboard::getstructblackboardattribute(commander, #"gameobjects_defend").size;
                    botcount += blackboard::getstructblackboardattribute(commander, #"doppelbots").size;
                    objectivecount += blackboard::getstructblackboardattribute(commander, #"objectives").size;
                    targetcount += commander.var_b851105b;
                }
                xoffset += 15;
                recordtext("<dev string:x2f3>" + botcount, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x1ba>", textscale);
                yoffset += 13;
                recordtext("<dev string:x30f>" + objectivecount, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x1ba>", textscale);
                yoffset += 13;
                recordtext("<dev string:x321>" + assaultobjects, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x1ba>", textscale);
                yoffset += 13;
                recordtext("<dev string:x33c>" + defendobjects, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x1ba>", textscale);
                yoffset += 13;
                recordtext("<dev string:x356>" + targetcount, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x1ba>", textscale);
                yoffset += 13;
                yoffset += 13;
                xoffset -= 15;
                squadcount = 0;
                for (index = 0; index < var_6f02abfe; index++) {
                    commander = level.var_1166849[index];
                    squadcount += commander.squads.size;
                }
                recordtext("<dev string:x366>" + squadcount, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x1ba>", textscale);
            }
            waitframe(1);
        }
    }

#/

// Namespace strategiccommandutility/strategic_command
// Params 5, eflags: 0x4
// Checksum 0xbf66af9c, Offset: 0x39b0
// Size: 0x10a
function private function_475273f2(strategy, var_5f0face4, var_d739f843, doppelbots = 1, companions = 1) {
    assert(isdefined(strategy));
    var_1dc61399 = strategy.(var_5f0face4) === 1;
    var_7e0cd578 = var_1dc61399;
    if (strategy.("customizecompanions") === 1) {
        var_7e0cd578 = strategy.(var_d739f843) === 1;
    }
    if (doppelbots && companions) {
        return (var_1dc61399 && var_7e0cd578);
    } else if (doppelbots) {
        return var_1dc61399;
    } else if (companions) {
        return var_7e0cd578;
    }
    return 0;
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x6157d270, Offset: 0x3ac8
// Size: 0x2c8
function function_e4aaa38b(bundle) {
    assert(isdefined(bundle));
    var_8a639169 = spawnstruct();
    /#
        var_8a639169.name = bundle.name;
    #/
    var_ea7a0e2 = array("doppelbotsignore", "doppelbotsallowair", "doppelbotsallowground", "doppelbotspriority", "doppelbotstactics", "doppelbotsfocus", "doppelbotsinteractions", "doppelbotsdistribution");
    var_7e548b31 = array("companionsignore", "companionsallowair", "companionsallowground", "companionspriority", "companionstactics", "companionsfocus", "companionsinteractions", "companionsdistribution");
    foreach (kvp in var_ea7a0e2) {
        if (!isdefined(bundle.(kvp))) {
            var_8a639169.(kvp) = 0;
            continue;
        }
        var_8a639169.(kvp) = bundle.(kvp);
    }
    if (bundle.("customizecompanions") === 1) {
        for (index = 0; index < var_7e548b31.size; index++) {
            kvp = var_7e548b31[index];
            if (!isdefined(bundle.(kvp))) {
                var_8a639169.(kvp) = 0;
                continue;
            }
            if (bundle.(kvp) === "inherit from doppelbot") {
                var_8a639169.(kvp) = var_8a639169.(var_ea7a0e2[index]);
                continue;
            }
            var_8a639169.(kvp) = bundle.(kvp);
        }
    } else {
        for (index = 0; index < var_7e548b31.size; index++) {
            kvp = var_7e548b31[index];
            var_8a639169.(kvp) = var_8a639169.(var_ea7a0e2[index]);
        }
    }
    return var_8a639169;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x9ff16bd3, Offset: 0x3d98
// Size: 0xcc
function function_92a57941(entity, bundle) {
    assert(isdefined(bundle));
    if (!function_980223db(entity)) {
        return;
    }
    if (bundle.m_str_type == "escortbiped") {
        if (!isdefined(bundle.var_f09fedbb)) {
            return;
        }
        if (entity === bundle.var_f09fedbb) {
            return calculatepathtoposition(entity, entity.goalpos);
        }
        return calculatepathtoposition(entity, bundle.var_f09fedbb.origin);
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x3b0e1136, Offset: 0x3e70
// Size: 0x11a
function function_a8875aa2(bot, component) {
    assert(isdefined(component));
    if (!function_980223db(bot)) {
        return;
    }
    switch (component.m_str_type) {
    case #"goto":
        break;
    case #"destroy":
    case #"defend":
        if (function_d5770bb4(bot)) {
            return calculatepathtotrigger(bot, component.var_2b8386bb);
        } else {
            return calculatepathtotrigger(bot, component.var_d9c3be3e);
        }
        break;
    case #"capturearea":
        return calculatepathtotrigger(bot, component.var_5065689f);
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xba58797f, Offset: 0x3f98
// Size: 0x134
function calculatepathtogameobject(bot, gameobject) {
    assert(isdefined(gameobject));
    if (!function_980223db(bot)) {
        return;
    }
    if (function_d5770bb4(bot)) {
        return calculatepathtotrigger(bot, gameobject.trigger);
    }
    var_4fc5861e = bot getpathfindingradius();
    botposition = getclosestpointonnavmesh(bot.origin, 200, var_4fc5861e);
    if (!isdefined(botposition)) {
        return;
    }
    points = querypointsaroundgameobject(bot, gameobject);
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    return _calculatepathtopoints(bot, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xb1d7296d, Offset: 0x40d8
// Size: 0xba
function function_b397007a(bot, breadcrumb) {
    assert(isdefined(breadcrumb));
    if (!function_980223db(bot)) {
        return;
    }
    var_4fc5861e = bot getpathfindingradius();
    botposition = getclosestpointonnavmesh(bot.origin, 200, var_4fc5861e);
    if (!isdefined(botposition)) {
        return;
    }
    return calculatepathtotrigger(bot, breadcrumb.trigger);
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x84d9307c, Offset: 0x41a0
// Size: 0x19c
function calculatepathtoobjective(bot, objective) {
    assert(isdefined(objective));
    if (!function_980223db(bot)) {
        return;
    }
    inair = function_d5770bb4(bot);
    vehicle = undefined;
    if (inair) {
        vehicle = bot getvehicleoccupied();
        botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
    } else {
        var_4fc5861e = bot getpathfindingradius();
        botposition = getclosestpointonnavmesh(bot.origin, 200, var_4fc5861e);
    }
    if (!isdefined(botposition)) {
        return;
    }
    points = querypointsinsideobjective(bot, objective);
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    if (inair) {
        return function_4abff4af(vehicle, points);
    }
    return _calculatepathtopoints(bot, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xf16ffd99, Offset: 0x4348
// Size: 0xd2
function calculatepathtopoints(bot, points) {
    assert(isdefined(points));
    if (!function_980223db(bot)) {
        return;
    }
    var_4fc5861e = bot getpathfindingradius();
    botposition = getclosestpointonnavmesh(bot.origin, 200, var_4fc5861e);
    if (!isdefined(botposition)) {
        return;
    }
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    return _calculatepathtopoints(bot, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 4, eflags: 0x0
// Checksum 0xa149a385, Offset: 0x4428
// Size: 0x132
function calculatepathtoposition(entity, position, radius = 200, halfheight = 100) {
    assert(isdefined(position));
    if (!function_980223db(entity)) {
        return;
    }
    var_4fc5861e = entity getpathfindingradius();
    botposition = getclosestpointonnavmesh(entity.origin, 200, var_4fc5861e);
    if (!isdefined(botposition)) {
        return;
    }
    points = querypointsinsideposition(entity, position, radius, halfheight);
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    return _calculatepathtopoints(entity, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x8d70e564, Offset: 0x4568
// Size: 0x182
function calculatepathtotrigger(bot, trigger) {
    if (!isdefined(trigger)) {
        return;
    }
    if (!function_980223db(bot)) {
        return;
    }
    inair = function_d5770bb4(bot);
    vehicle = undefined;
    if (inair) {
        vehicle = bot getvehicleoccupied();
        botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
    } else {
        var_4fc5861e = bot getpathfindingradius();
        botposition = getclosestpointonnavmesh(bot.origin, 200, var_4fc5861e);
    }
    if (!isdefined(botposition)) {
        return;
    }
    points = querypointsinsidetrigger(bot, trigger);
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    if (inair) {
        return function_4abff4af(vehicle, points);
    }
    return _calculatepathtopoints(bot, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x78923b5f, Offset: 0x46f8
// Size: 0x182
function function_b5a3d333(bot, trigger) {
    if (!isdefined(trigger)) {
        return;
    }
    if (!function_980223db(bot)) {
        return;
    }
    inair = function_d5770bb4(bot);
    vehicle = undefined;
    if (inair) {
        vehicle = bot getvehicleoccupied();
        botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
    } else {
        var_4fc5861e = bot getpathfindingradius();
        botposition = getclosestpointonnavmesh(bot.origin, 200, var_4fc5861e);
    }
    if (!isdefined(botposition)) {
        return;
    }
    points = function_8b8b940c(bot, trigger);
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    if (inair) {
        return function_4abff4af(vehicle, points);
    }
    return _calculatepathtopoints(bot, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 6, eflags: 0x0
// Checksum 0x5af42d3d, Offset: 0x4888
// Size: 0x13c
function calculateprogressrushing(lowerboundpercentile, upperboundpercentile, destroyedobjects, totalobjects, enemydestroyedobjects, enemytotalobjects) {
    if (enemytotalobjects <= 0) {
        return false;
    }
    if (totalobjects <= 0) {
        return false;
    }
    gameobjectcost = 1 / totalobjects;
    enemygameobjectcost = 1 / enemytotalobjects;
    currentgameobjectcost = min(gameobjectcost * destroyedobjects, 1);
    currentenemygameobjectcost = min(enemygameobjectcost * enemydestroyedobjects, 1);
    return max(min(lowerboundpercentile + currentenemygameobjectcost, 1), 0) > max(min(gameobjectcost + currentgameobjectcost, 1), 0);
}

// Namespace strategiccommandutility/strategic_command
// Params 6, eflags: 0x0
// Checksum 0xdc640c68, Offset: 0x49d0
// Size: 0x144
function calculateprogressthrottling(lowerboundpercentile, upperboundpercentile, destroyedobjects, totalobjects, enemydestroyedobjects, enemytotalobjects) {
    if (enemytotalobjects <= 0) {
        return true;
    }
    if (totalobjects <= 0) {
        return false;
    }
    gameobjectcost = 1 / totalobjects;
    enemygameobjectcost = 1 / enemytotalobjects;
    currentgameobjectcost = min(gameobjectcost * destroyedobjects, 1);
    currentenemygameobjectcost = min(enemygameobjectcost * enemydestroyedobjects, 1);
    return max(min(upperboundpercentile + currentenemygameobjectcost, 1), 0) < max(min(gameobjectcost + currentgameobjectcost, 1), 0);
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x5acbe6ba, Offset: 0x4b20
// Size: 0x340
function function_3719b43f(var_22b0c585, var_87ad1085) {
    assert(isdefined(var_22b0c585));
    assert(isdefined(var_87ad1085));
    var_8a639169 = spawnstruct();
    var_ea7a0e2 = array("doppelbotsignore", "doppelbotsallowair", "doppelbotsallowground", "doppelbotspriority", "doppelbotstactics", "doppelbotsfocus", "doppelbotsinteractions", "doppelbotsdistribution");
    var_7e548b31 = array("companionsignore", "companionsallowair", "companionsallowground", "companionspriority", "companionstactics", "companionsfocus", "companionsinteractions", "companionsdistribution");
    assert(var_ea7a0e2.size == var_7e548b31.size);
    foreach (kvp in var_ea7a0e2) {
        if (!isdefined(var_87ad1085.(kvp)) || var_87ad1085.(kvp) === #"hash_13275474a58f1175") {
            if (!isdefined(var_22b0c585.(kvp))) {
                var_8a639169.(kvp) = 0;
            } else {
                var_8a639169.(kvp) = var_22b0c585.(kvp);
            }
            continue;
        }
        var_8a639169.(kvp) = var_87ad1085.(kvp);
    }
    if (var_87ad1085.("customizecompanions") === 1) {
        for (index = 0; index < var_7e548b31.size; index++) {
            kvp = var_7e548b31[index];
            if (!isdefined(var_87ad1085.(kvp))) {
                var_8a639169.(kvp) = 0;
                continue;
            }
            if (var_87ad1085.(kvp) === "inherit from doppelbot") {
                var_8a639169.(kvp) = var_8a639169.(var_ea7a0e2[index]);
                continue;
            }
            var_8a639169.(kvp) = var_87ad1085.(kvp);
        }
    } else {
        for (index = 0; index < var_7e548b31.size; index++) {
            kvp = var_7e548b31[index];
            var_8a639169.(kvp) = var_8a639169.(var_ea7a0e2[index]);
        }
    }
    return var_8a639169;
}

// Namespace strategiccommandutility/strategic_command
// Params 4, eflags: 0x0
// Checksum 0x731a385d, Offset: 0x4e68
// Size: 0x532
function function_e9bbf61c(side, var_c54e7319 = undefined, missioncomponent = undefined, gameobject = undefined) {
    assert(isstring(side));
    strategy = function_54b78124(side);
    if (!isdefined(strategy)) {
        function_3ebf7ac8(#"default_strategicbundle", side);
        strategy = function_54b78124(side);
    }
    /#
        sdebug = ["<dev string:x374>" + strategy.name];
    #/
    strategy = function_3719b43f(strategy, strategy);
    if (isdefined(var_c54e7319)) {
        var_af105ed2 = var_c54e7319.("scriptbundle_strategy_" + side);
        if (isdefined(var_af105ed2)) {
            strategy = function_3719b43f(strategy, getscriptbundle(var_af105ed2));
        }
        /#
            sdebug[sdebug.size] = var_c54e7319.type + "<dev string:xd2>" + var_c54e7319.name + "<dev string:x37e>" + (isdefined(var_af105ed2) ? var_af105ed2 : "<dev string:x187>");
        #/
    }
    if (isdefined(missioncomponent)) {
        var_b08ad499 = missioncomponent.("scriptbundle_strategy_" + side);
        if (isdefined(var_b08ad499)) {
            strategy = function_3719b43f(strategy, getscriptbundle(var_b08ad499));
        }
        /#
            sdebug[sdebug.size] = missioncomponent.scriptbundlename + "<dev string:x382>" + (isdefined(var_b08ad499) ? var_b08ad499 : "<dev string:x187>");
        #/
    }
    if (isdefined(gameobject)) {
        var_3e217e51 = 0;
        if (isdefined(gameobject.s_minigame) && isdefined(gameobject.s_minigame.var_fe880250) && isdefined(gameobject.s_minigame.var_fe880250.var_aba2d232)) {
            foreach (location in gameobject.s_minigame.var_fe880250.var_aba2d232) {
                if (location.mdl_gameobject === gameobject) {
                    var_3e217e51 = 1;
                    var_f4f89ee9 = gameobject.s_minigame.("scriptbundle_strategy_" + side);
                    if (isdefined(var_f4f89ee9)) {
                        strategy = function_3719b43f(strategy, getscriptbundle(var_f4f89ee9));
                    }
                }
                /#
                    sdebug[sdebug.size] = "<dev string:x385>" + gameobject getentitynumber() + "<dev string:x37e>" + (isdefined(var_f4f89ee9) ? var_f4f89ee9 : "<dev string:x187>") + "<dev string:x28b>";
                #/
                break;
            }
        }
        if (!var_3e217e51 && isdefined(gameobject.e_object) && isdefined(gameobject.e_object.scriptbundlename)) {
            gameobjectbundle = getscriptbundle(gameobject.e_object.scriptbundlename);
            if (isdefined(gameobjectbundle)) {
                var_f4f89ee9 = gameobjectbundle.("scriptbundle_strategy_" + side);
                if (isdefined(var_f4f89ee9)) {
                    strategy = function_3719b43f(strategy, getscriptbundle(var_f4f89ee9));
                }
            }
            /#
                sdebug[sdebug.size] = "<dev string:x385>" + gameobject getentitynumber() + "<dev string:x37e>" + (isdefined(var_f4f89ee9) ? var_f4f89ee9 : "<dev string:x187>");
            #/
        }
    }
    /#
        strategy.sdebug = sdebug;
    #/
    return strategy;
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0xd35056a8, Offset: 0x53a8
// Size: 0x92
function function_8d3bd065(vehicle) {
    assert(isdefined(vehicle) && isvehicle(vehicle));
    switch (vehicle.vehicleclass) {
    case #"helicopter":
        return "air";
    case #"4 wheel":
        return "ground";
    }
    return "ground";
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xd6492246, Offset: 0x5448
// Size: 0x96
function canattackgameobject(team, gameobject) {
    return gameobject.team == team && gameobject.interactteam == #"friendly" || gameobject.team != team && gameobject.interactteam == #"enemy" || gameobject.absolute_visible_and_interact_team === team;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xc221a84d, Offset: 0x54e8
// Size: 0x80
function candefendgameobject(team, gameobject) {
    return gameobject.team == team && gameobject.interactteam == #"enemy" || gameobject.team != team && gameobject.interactteam == #"friendly";
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x717e8cca, Offset: 0x5570
// Size: 0x4a
function function_d4dcfc8e(team) {
    var_d19899a0 = "sideA";
    if (util::get_team_mapping("sidea") !== team) {
        var_d19899a0 = "sideB";
    }
    return var_d19899a0;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x604baf35, Offset: 0x55c8
// Size: 0xca
function function_b684ed38(entity, component) {
    assert(isdefined(entity));
    assert(isdefined(component));
    switch (component.m_str_type) {
    case #"destroy":
    case #"defend":
        if (function_d5770bb4(entity)) {
            return component.var_2b8386bb;
        }
        return component.var_d9c3be3e;
    case #"capturearea":
        return component.var_5065689f;
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0xc2e23f7d, Offset: 0x56a0
// Size: 0x9c
function function_4736e93(side) {
    assert(isdefined(side));
    if (!isdefined(level.var_9318b450)) {
        level.var_9318b450 = [];
    } else if (!isarray(level.var_9318b450)) {
        level.var_9318b450 = array(level.var_9318b450);
    }
    return level.var_9318b450[side];
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x1bf00d0a, Offset: 0x5748
// Size: 0x9c
function function_54b78124(side) {
    assert(isdefined(side));
    if (!isdefined(level.var_de617f05)) {
        level.var_de617f05 = [];
    } else if (!isarray(level.var_de617f05)) {
        level.var_de617f05 = array(level.var_de617f05);
    }
    return level.var_de617f05[side];
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x7aad0787, Offset: 0x57f0
// Size: 0x5e
function function_db159321(gpbundle, team) {
    var_d19899a0 = function_d4dcfc8e(team);
    return gpbundle.var_b9cf6593 == var_d19899a0 || gpbundle.var_b9cf6593 == team;
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x3fc3babf, Offset: 0x5858
// Size: 0x68
function function_d5770bb4(entity) {
    if (entity isinvehicle()) {
        vehicle = entity getvehicleoccupied();
        return (function_8d3bd065(vehicle) == "air");
    }
    return false;
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x8fe84b86, Offset: 0x58c8
// Size: 0x68
function function_60baf68b(entity) {
    if (entity isinvehicle()) {
        vehicle = entity getvehicleoccupied();
        return (function_8d3bd065(vehicle) == "ground");
    }
    return false;
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0xe93120ed, Offset: 0x5938
// Size: 0x52
function function_980223db(entity) {
    if (isactor(entity)) {
        return isalive(entity);
    }
    return isvalidbotorplayer(entity);
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x80e96cb0, Offset: 0x5998
// Size: 0x3c
function isvalidbotorplayer(client) {
    return isvalidbot(client) || isvalidplayer(client);
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x4c4b4b0d, Offset: 0x59e0
// Size: 0x86
function isvalidbot(bot) {
    return isdefined(bot) && isbot(bot) && bot bot::initialized() && !bot isplayinganimscripted() && ai::getaiattribute(bot, "control") === "commander";
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x16dff9bf, Offset: 0x5a70
// Size: 0x88
function function_fe34c4b4(bot) {
    if (bot isinvehicle()) {
        vehicle = bot getvehicleoccupied();
        seatnum = vehicle getoccupantseat(bot);
        return (seatnum == 0 && !isdefined(vehicle.attachedpath));
    }
    return false;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xcae4fcd9, Offset: 0x5b00
// Size: 0x166
function function_8c503eb0(gpbundle, var_d19899a0) {
    team = util::get_team_mapping(var_d19899a0);
    bundle = gpbundle.o_gpbundle;
    if (!isdefined(bundle)) {
        return false;
    }
    if (!(bundle.var_b9cf6593 === var_d19899a0 || bundle.var_b9cf6593 === team || bundle.var_7a8583ab === var_d19899a0 || bundle.var_7a8583ab === team)) {
        return false;
    }
    if (!bundle flag::get("bundle_initialized")) {
        return false;
    }
    type = gpbundle.classname;
    switch (type) {
    case #"hash_1c67b29f3576b10d":
        if (!isdefined(bundle.var_f09fedbb)) {
            return false;
        }
        if (!isdefined(bundle.var_f09fedbb.mdl_gameobject)) {
            return false;
        }
        break;
    default:
        return false;
    }
    return true;
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0xadda6adf, Offset: 0x5c70
// Size: 0x6e
function isvalidplayer(client) {
    return isdefined(client) && !isbot(client) && isplayer(client) && !client isinmovemode("ufo", "noclip");
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x2d66d82f, Offset: 0x5ce8
// Size: 0x1c6
function function_ee65cade(missioncomponent, commanderteam) {
    component = missioncomponent.var_a06b4dbd;
    assert(commanderteam == #"any" || commanderteam == #"allies" || commanderteam == #"axis", "<dev string:x394>" + commanderteam + "<dev string:x3a5>");
    if (!isdefined(component)) {
        return false;
    }
    if (!missioncomponent flag::get("enabled")) {
        return false;
    }
    if (missioncomponent flag::get("complete")) {
        return false;
    }
    if (component.m_str_team !== commanderteam && component.m_str_team != #"any") {
        if (!isdefined(missioncomponent.var_24319d1) || missioncomponent.var_24319d1 == 0) {
            return false;
        }
    }
    type = missioncomponent.scriptbundlename;
    switch (type) {
    case #"hash_6e9081699001bcd9":
        break;
    case #"hash_3bf68fbcb5c53b6c":
        break;
    case #"hash_4984fd4b0ba666a2":
        break;
    default:
        return false;
    }
    return true;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xa114928f, Offset: 0x5eb8
// Size: 0x16c
function querypointsaroundgameobject(bot, gameobject) {
    assert(isdefined(gameobject));
    if (!function_980223db(bot)) {
        return;
    }
    points = array();
    if (isdefined(gameobject) && isdefined(gameobject.trigger)) {
        points = tacticalquery(#"stratcom_tacquery_gameobject", gameobject.trigger);
    }
    /#
        if (getdvarint(#"ai_debugsquadpointquery", 0)) {
            foreach (point in points) {
                recordstar(point.origin, (1, 0.5, 0), "<dev string:x1ba>");
            }
        }
    #/
    return points;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x520fdc88, Offset: 0x6030
// Size: 0x244
function querypointsinsideobjective(bot, trigger) {
    assert(isdefined(trigger));
    if (!function_980223db(bot)) {
        return [];
    }
    points = [];
    if (function_d5770bb4(bot)) {
        vehicle = bot getvehicleoccupied();
        botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
        radius = distance2d(trigger.maxs, (0, 0, 0));
        query = positionquery_source_navigation(trigger.origin, 0, radius, trigger.maxs[2], 100, vehicle);
        if (isdefined(query) && isdefined(query.data)) {
            points = query.data;
        }
    } else {
        points = tacticalquery(#"stratcom_tacquery_objective", trigger);
        /#
            if (getdvarint(#"ai_debugsquadpointquery", 0)) {
                foreach (point in points) {
                    recordstar(point.origin, (1, 0.5, 0), "<dev string:x1ba>");
                }
            }
        #/
    }
    return points;
}

// Namespace strategiccommandutility/strategic_command
// Params 4, eflags: 0x0
// Checksum 0x2e4a0672, Offset: 0x6280
// Size: 0x16c
function querypointsinsideposition(bot, position, radius, halfheight) {
    assert(isdefined(position));
    if (!function_980223db(bot)) {
        return [];
    }
    cylinder = ai::t_cylinder(position, radius, halfheight);
    points = tacticalquery(#"stratcom_tacquery_position", cylinder);
    /#
        if (getdvarint(#"ai_debugsquadpointquery", 0)) {
            foreach (point in points) {
                recordstar(point.origin, (1, 0.5, 0), "<dev string:x1ba>");
            }
        }
    #/
    return points;
}

/#

    // Namespace strategiccommandutility/strategic_command
    // Params 2, eflags: 0x4
    // Checksum 0xfb168974, Offset: 0x63f8
    // Size: 0x158
    function private function_e20a825b(points, obb) {
        var_a4bf4c5a = 50;
        var_9bd56228 = 0;
        while (var_9bd56228 < var_a4bf4c5a) {
            if (getdvarint(#"ai_debugsquadpointquery", 0)) {
                function_1e80dbe9(obb.center, obb.halfsize * -1, obb.halfsize, obb.angles[1], (0, 1, 0), "<dev string:x1ba>");
                foreach (point in points) {
                    recordstar(point.origin, (1, 0.5, 0), "<dev string:x1ba>");
                }
            }
            var_9bd56228++;
            waitframe(1);
        }
    }

#/

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xb2dade1, Offset: 0x6558
// Size: 0x1c8
function querypointsinsidetrigger(bot, trigger) {
    assert(isdefined(trigger));
    if (!function_980223db(bot)) {
        return [];
    }
    points = [];
    if (function_d5770bb4(bot)) {
        vehicle = bot getvehicleoccupied();
        botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
        radius = distance2d(trigger.maxs, (0, 0, 0));
        query = positionquery_source_navigation(trigger.origin, 0, radius, trigger.maxs[2], 100, vehicle);
        if (isdefined(query) && isdefined(query.data)) {
            points = query.data;
        }
    } else {
        obb = bot bot::function_75b62024(trigger);
        points = tacticalquery(#"stratcom_tacquery_trigger", obb);
        /#
            level thread function_e20a825b(points, obb);
        #/
    }
    return points;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x87465a69, Offset: 0x6728
// Size: 0x100
function function_8b8b940c(bot, trigger) {
    assert(isdefined(trigger));
    if (!function_980223db(bot)) {
        return [];
    }
    points = [];
    if (function_d5770bb4(bot)) {
        assert(0, "<dev string:x3c1>");
    } else {
        obb = bot bot::function_80dce372(trigger);
        points = tacticalquery(#"stratcom_tacquery_trigger", obb);
        /#
            level thread function_e20a825b(points, obb);
        #/
    }
    return points;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xcd2405d, Offset: 0x6830
// Size: 0xf4
function function_c3b80bd5(strategicbundle, side) {
    assert(isdefined(side));
    if (!isdefined(level.var_9318b450)) {
        level.var_9318b450 = [];
    } else if (!isarray(level.var_9318b450)) {
        level.var_9318b450 = array(level.var_9318b450);
    }
    strategy = getscriptbundle(strategicbundle);
    if (isdefined(strategy) && isdefined(side)) {
        level.var_9318b450[side] = strategicbundle;
        function_3ebf7ac8(strategicbundle, side);
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x5e47d14, Offset: 0x6930
// Size: 0x74
function function_b4c68f9a(side) {
    assert(isdefined(side));
    if (isdefined(level.var_9318b450) && isdefined(level.var_9318b450[side])) {
        function_3ebf7ac8(level.var_9318b450[side], side);
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x45437ca6, Offset: 0x69b0
// Size: 0xee
function function_3ebf7ac8(strategicbundle, side) {
    assert(isdefined(side));
    if (!isdefined(level.var_de617f05)) {
        level.var_de617f05 = [];
    } else if (!isarray(level.var_de617f05)) {
        level.var_de617f05 = array(level.var_de617f05);
    }
    strategy = getscriptbundle(strategicbundle);
    if (isdefined(strategy) && isdefined(side)) {
        level.var_de617f05[side] = function_e4aaa38b(strategy);
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0xb69bf251, Offset: 0x6aa8
// Size: 0x24e
function function_be0f2866(var_52b2ed00) {
    focuses = array();
    switch (var_52b2ed00) {
    case #"hash_617966a33a6bad2b":
        focuses[focuses.size] = #"hash_617966a33a6bad2b";
        break;
    case #"follow player":
        focuses[focuses.size] = #"follow player";
        break;
    case #"hash_a465dbf9320e821":
        focuses[focuses.size] = #"hash_617966a33a6bad2b";
        focuses[focuses.size] = #"follow player";
        break;
    case #"hash_964e75ec7937916":
        focuses[focuses.size] = #"hash_964e75ec7937916";
        break;
    case #"hash_64a01d6e814c8dc":
        focuses[focuses.size] = #"hash_64a01d6e814c8dc";
        break;
    case #"hash_584bf5a5b6fe57ca":
        focuses[focuses.size] = #"hash_964e75ec7937916";
        focuses[focuses.size] = #"hash_64a01d6e814c8dc";
        break;
    case #"hash_833af17ffa224fe":
        focuses[focuses.size] = #"hash_617966a33a6bad2b";
        focuses[focuses.size] = #"hash_964e75ec7937916";
        break;
    case #"hash_692e498c8008c994":
        focuses[focuses.size] = #"follow player";
        focuses[focuses.size] = #"hash_64a01d6e814c8dc";
        break;
    case #"objective":
        focuses[focuses.size] = #"objective";
        break;
    }
    return focuses;
}

// Namespace strategiccommandutility/strategic_command
// Params 3, eflags: 0x0
// Checksum 0xaedb270c, Offset: 0x6d00
// Size: 0x62
function function_81fe17e9(strategy, doppelbots = 1, companions = 1) {
    return function_475273f2(strategy, "doppelbotsignore", "companionsignore", doppelbots, companions);
}

// Namespace strategiccommandutility/strategic_command
// Params 3, eflags: 0x0
// Checksum 0x59f870ba, Offset: 0x6d70
// Size: 0x62
function function_e83d46e6(strategy, doppelbots = 1, companions = 1) {
    return function_475273f2(strategy, "doppelbotsallowair", "companionsallowair", doppelbots, companions);
}

// Namespace strategiccommandutility/strategic_command
// Params 3, eflags: 0x0
// Checksum 0x2360a3f7, Offset: 0x6de0
// Size: 0x62
function function_5306537b(strategy, doppelbots = 1, companions = 1) {
    return function_475273f2(strategy, "doppelbotsallowground", "companionsallowground", doppelbots, companions);
}

