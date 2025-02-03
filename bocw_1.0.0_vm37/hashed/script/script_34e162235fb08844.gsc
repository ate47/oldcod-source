#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\callbacks_shared;

#namespace namespace_255a2b21;

// Namespace namespace_255a2b21/namespace_255a2b21
// Params 0, eflags: 0x0
// Checksum 0xd169232c, Offset: 0x80
// Size: 0x114
function preinit() {
    if (currentsessionmode() == 4 || !(isdefined(getgametypesetting(#"allowlaststandforactiveclients")) ? getgametypesetting(#"allowlaststandforactiveclients") : 0)) {
        return;
    }
    callback::on_spawned(&on_player_spawned);
    callback::on_laststand(&on_player_laststand);
    callback::on_revived(&on_player_revived);
    callback::on_player_killed(&on_player_killed);
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace namespace_255a2b21/namespace_255a2b21
// Params 0, eflags: 0x4
// Checksum 0x363fc77, Offset: 0x1a0
// Size: 0x24
function private on_player_spawned() {
    level function_301f229d(self.team);
}

// Namespace namespace_255a2b21/namespace_255a2b21
// Params 0, eflags: 0x4
// Checksum 0x86b096e8, Offset: 0x1d0
// Size: 0x54
function private on_player_laststand() {
    if (isbot(self)) {
        self bot::clear_revive_target();
    }
    waitframe(1);
    level function_301f229d(self.team);
}

// Namespace namespace_255a2b21/namespace_255a2b21
// Params 1, eflags: 0x4
// Checksum 0x72bc291a, Offset: 0x230
// Size: 0x2c
function private on_player_revived(*params) {
    level function_301f229d(self.team);
}

// Namespace namespace_255a2b21/namespace_255a2b21
// Params 1, eflags: 0x4
// Checksum 0x5ac14c20, Offset: 0x268
// Size: 0x5c
function private on_player_killed(*params) {
    level function_301f229d(self.team);
    if (isbot(self)) {
        self bot::clear_revive_target();
    }
}

// Namespace namespace_255a2b21/namespace_255a2b21
// Params 0, eflags: 0x4
// Checksum 0x2af4d728, Offset: 0x2d0
// Size: 0x24
function private on_player_disconnect() {
    level function_301f229d(self.team);
}

// Namespace namespace_255a2b21/namespace_255a2b21
// Params 1, eflags: 0x4
// Checksum 0x37addeda, Offset: 0x300
// Size: 0x700
function private function_301f229d(team) {
    var_9e7013f = [];
    var_52e61055 = [];
    players = getplayers(team);
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        if (isdefined(player.revivetrigger)) {
            if (!is_true(player.revivetrigger.beingrevived)) {
                var_9e7013f[var_9e7013f.size] = player;
            }
            continue;
        }
        if (isbot(player)) {
            if (!player.ignoreall && !player isplayinganimscripted() && !player arecontrolsfrozen() && !player function_5972c3cf() && !player isinvehicle()) {
                if (!isdefined(player.bot.revivetarget) || !isdefined(player.bot.revivetarget.revivetrigger) || !is_true(player.is_reviving_any)) {
                    var_52e61055[var_52e61055.size] = player;
                }
            }
        }
    }
    assignments = [];
    foreach (bot in var_52e61055) {
        radius = bot getpathfindingradius();
        foreach (player in var_9e7013f) {
            distance = undefined;
            if (bot istouching(player.revivetrigger)) {
                distance = distance(bot.origin, player.origin);
                arrayinsert(assignments, {#bot:bot, #target:player, #distance:distance}, 0);
                continue;
            }
            navmeshpoint = bot_position::function_13796beb(player.origin);
            if (!isdefined(navmeshpoint)) {
                continue;
            }
            if (tracepassedonnavmesh(bot.origin, navmeshpoint, 15)) {
                distance = distance2d(bot.origin, navmeshpoint);
            } else {
                var_65c8979b = bot_position::function_13796beb(bot.origin);
                if (!isdefined(var_65c8979b)) {
                    continue;
                }
                path = generatenavmeshpath(var_65c8979b, navmeshpoint, bot);
                if (!isdefined(path) || !isdefined(path.pathpoints) || path.pathpoints.size == 0) {
                    continue;
                }
                distance = path.pathdistance;
            }
            if (distance > 2000) {
                continue;
            }
            for (i = 0; i < assignments.size; i++) {
                if (distance < assignments[i].distance) {
                    break;
                }
            }
            arrayinsert(assignments, {#bot:bot, #target:player, #distance:distance}, i);
        }
    }
    for (i = 0; i < assignments.size; i++) {
        assignment = assignments[i];
        if (assignment.bot bot::get_revive_target() !== assignment.target) {
            assignment.bot bot::set_revive_target(assignment.target);
        }
        arrayremovevalue(var_52e61055, assignment.bot);
        for (j = i + 1; j < assignments.size; j++) {
            var_ecf75b21 = assignments[j];
            if (var_ecf75b21.bot == assignment.bot || var_ecf75b21.target == assignment.target) {
                arrayremoveindex(assignments, j);
                continue;
            }
        }
    }
    foreach (bot in var_52e61055) {
        if (isdefined(bot bot::get_revive_target())) {
            bot bot::clear_revive_target();
        }
    }
}

