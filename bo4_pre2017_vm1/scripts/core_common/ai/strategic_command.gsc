#using scripts/core_common/ai_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/throttle_shared;

#namespace strategic_command;

// Namespace strategic_command/strategic_command
// Params 0, eflags: 0x2
// Checksum 0xe742f8a0, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("strategic_command", &strategiccommandutility::__init__, undefined, undefined);
}

#namespace strategiccommandutility;

// Namespace strategiccommandutility/strategic_command
// Params 0, eflags: 0x4
// Checksum 0x219fbf79, Offset: 0x238
// Size: 0x6c
function private __init__() {
    /#
        level thread _debuggameobjects();
    #/
    if (!isdefined(level.strategic_command_throttle)) {
        [[ new throttle ]]->__constructor();
        level.strategic_command_throttle = <error pop>;
        [[ level.strategic_command_throttle ]]->initialize(1, 0.05);
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x4
// Checksum 0x71b61093, Offset: 0x2b0
// Size: 0x194
function private _calculatepathtopoints(bot, points) {
    path = undefined;
    shortestpath = undefined;
    botposition = getclosestpointonnavmesh(bot.origin, 200);
    for (index = 0; index < points.size; index += 16) {
        goalpoints = [];
        for (goalindex = index; goalindex - index < 16 && goalindex < points.size; goalindex++) {
            goalpoints[goalpoints.size] = points[goalindex].origin;
        }
        possiblepath = generatenavmeshpath(botposition, goalpoints);
        if (isdefined(possiblepath) && possiblepath.status === "succeeded") {
            if (!isdefined(shortestpath) || possiblepath.pathdistance < shortestpath) {
                path = possiblepath;
                shortestpath = possiblepath.pathdistance;
            }
        }
    }
    return path;
}

// Namespace strategiccommandutility/strategic_command
// Params 0, eflags: 0x4
// Checksum 0xd88a9739, Offset: 0x450
// Size: 0x3fc
function private _debuggameobjects() {
    while (true) {
        if (getdvarint("ai_debugGameobjects")) {
            position = (0, 0, 0);
            xoffset = 400;
            yoffset = 50;
            textscale = 0.7;
            if (isdefined(level.a_gameobjects)) {
                foreach (gameobject in level.a_gameobjects) {
                    if (isdefined(gameobject.trigger)) {
                        color = (1, 1, 1);
                        points = tacticalquery("stratcom_tacquery_trigger", gameobject.trigger);
                        origin = gameobject.trigger.origin;
                        identifier = gameobject gameobjects::get_identifier();
                        if (points.size <= 0) {
                            color = (1, 0, 0);
                        }
                        spacer3d = "\n \n";
                        identifiertext = "identifier(";
                        if (isdefined(identifier)) {
                            identifiertext += identifier;
                        }
                        identifiertext += ") ";
                        tacpointtext = "tac_points(" + points.size + ") ";
                        origintext = "origin(" + int(origin[0]) + ", " + int(origin[1]) + ", " + int(origin[2]) + ") ";
                        /#
                            record3dtext(identifiertext + spacer3d + tacpointtext + spacer3d + origintext, origin, color, "<dev string:x28>");
                            recordsphere(origin, 20, color);
                            sphere(origin, 20, color, 0, 0);
                            if (isdefined(gameobject.trigger.radius)) {
                                recordcircle(origin, gameobject.trigger.radius, color, "<dev string:x28>");
                            }
                        #/
                        if (points.size <= 0) {
                            /#
                                recordtext(identifiertext + tacpointtext + origintext, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x28>", textscale);
                            #/
                            yoffset += 13;
                        }
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xee1712cc, Offset: 0x858
// Size: 0xf2
function calculatepathtogameobject(bot, gameobject) {
    /#
        assert(isvalidbotorplayer(bot));
    #/
    /#
        assert(isdefined(gameobject));
    #/
    botposition = getclosestpointonnavmesh(bot.origin, 200);
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
// Checksum 0x3e1c6557, Offset: 0x958
// Size: 0xf2
function calculatepathtoobjective(bot, objective) {
    /#
        assert(isvalidbotorplayer(bot));
    #/
    /#
        assert(isdefined(objective));
    #/
    botposition = getclosestpointonnavmesh(bot.origin, 200);
    if (!isdefined(botposition)) {
        return;
    }
    points = querypointsinsideobjective(bot, objective);
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    return _calculatepathtopoints(bot, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xdb73ed3a, Offset: 0xa58
// Size: 0xd2
function calculatepathtopoints(bot, points) {
    /#
        assert(isvalidbotorplayer(bot));
    #/
    /#
        assert(isdefined(points));
    #/
    botposition = getclosestpointonnavmesh(bot.origin, 200);
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
// Checksum 0x62bf245c, Offset: 0xb38
// Size: 0x132
function calculatepathtoposition(bot, position, radius, halfheight) {
    if (!isdefined(radius)) {
        radius = 200;
    }
    if (!isdefined(halfheight)) {
        halfheight = 100;
    }
    /#
        assert(bot isbot());
    #/
    /#
        assert(isdefined(position));
    #/
    botposition = getclosestpointonnavmesh(bot.origin, 200);
    if (!isdefined(botposition)) {
        return;
    }
    points = querypointsinsideposition(bot, position, radius, halfheight);
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    return _calculatepathtopoints(bot, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x8312f902, Offset: 0xc78
// Size: 0xf2
function calculatepathtotrigger(bot, trigger) {
    /#
        assert(bot isbot());
    #/
    /#
        assert(isdefined(trigger));
    #/
    botposition = getclosestpointonnavmesh(bot.origin, 200);
    if (!isdefined(botposition)) {
        return;
    }
    points = querypointsinsidetrigger(bot, trigger);
    if (!isdefined(points) || points.size <= 0) {
        return;
    }
    return _calculatepathtopoints(bot, points);
}

// Namespace strategiccommandutility/strategic_command
// Params 6, eflags: 0x0
// Checksum 0x3f961ce, Offset: 0xd78
// Size: 0x14c
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
// Checksum 0x9329706f, Offset: 0xed0
// Size: 0x14c
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
// Checksum 0x8a926fd9, Offset: 0x1028
// Size: 0x78
function canattackgameobject(team, gameobject) {
    return gameobject.team != team && (gameobject.team == team && gameobject.interactteam == "friendly" || gameobject.interactteam == "enemy");
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xa00a75c9, Offset: 0x10a8
// Size: 0x78
function candefendgameobject(team, gameobject) {
    return gameobject.team != team && (gameobject.team == team && gameobject.interactteam == "enemy" || gameobject.interactteam == "friendly");
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x49161578, Offset: 0x1128
// Size: 0x42
function isvalidbotorplayer(bot) {
    return bot isbot() || isdefined(bot) && isplayer(bot);
}

// Namespace strategiccommandutility/strategic_command
// Params 1, eflags: 0x0
// Checksum 0x1526b117, Offset: 0x1178
// Size: 0x2a
function isvalidbot(bot) {
    return isdefined(bot) && bot isbot();
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0xd214055d, Offset: 0x11b0
// Size: 0x18e
function querypointsaroundgameobject(bot, gameobject) {
    /#
        assert(isvalidbotorplayer(bot));
    #/
    /#
        assert(isdefined(gameobject));
    #/
    points = array();
    if (isdefined(gameobject) && isdefined(gameobject.trigger)) {
        points = tacticalquery("stratcom_tacquery_gameobject", gameobject.trigger);
    }
    /#
        if (getdvarint("<dev string:x33>")) {
            foreach (point in points) {
                recordstar(point.origin, (1, 0.5, 0), "<dev string:x28>");
            }
        }
    #/
    return points;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x60e31eb2, Offset: 0x1348
// Size: 0x156
function querypointsinsideobjective(bot, trigger) {
    /#
        assert(isvalidbotorplayer(bot));
    #/
    /#
        assert(isdefined(trigger));
    #/
    points = tacticalquery("stratcom_tacquery_objective", trigger);
    /#
        if (getdvarint("<dev string:x33>")) {
            foreach (point in points) {
                recordstar(point.origin, (1, 0.5, 0), "<dev string:x28>");
            }
        }
    #/
    return points;
}

// Namespace strategiccommandutility/strategic_command
// Params 4, eflags: 0x0
// Checksum 0xb7aed2, Offset: 0x14a8
// Size: 0x18e
function querypointsinsideposition(bot, position, radius, halfheight) {
    /#
        assert(bot isbot());
    #/
    /#
        assert(isdefined(position));
    #/
    cylinder = ai::t_cylinder(position, radius, halfheight);
    points = tacticalquery("stratcom_tacquery_position", cylinder);
    /#
        if (getdvarint("<dev string:x33>")) {
            foreach (point in points) {
                recordstar(point.origin, (1, 0.5, 0), "<dev string:x28>");
            }
        }
    #/
    return points;
}

// Namespace strategiccommandutility/strategic_command
// Params 2, eflags: 0x0
// Checksum 0x9f99a8de, Offset: 0x1640
// Size: 0x156
function querypointsinsidetrigger(bot, trigger) {
    /#
        assert(isvalidbotorplayer(bot));
    #/
    /#
        assert(isdefined(trigger));
    #/
    points = tacticalquery("stratcom_tacquery_trigger", trigger);
    /#
        if (getdvarint("<dev string:x33>")) {
            foreach (point in points) {
                recordstar(point.origin, (1, 0.5, 0), "<dev string:x28>");
            }
        }
    #/
    return points;
}

