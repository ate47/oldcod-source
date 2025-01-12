#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace bot_position;

// Namespace bot_position/bot_position
// Params 0, eflags: 0x2
// Checksum 0x7e6d3d29, Offset: 0x128
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bot_position", &__init__, undefined, undefined);
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x2b43fb39, Offset: 0x170
// Size: 0x2ac
function __init__() {
    callback::on_spawned(&on_player_spawned);
    level.var_873feb82 = [];
    level.var_5dcca4e1 = [];
    function_63f593f5(#"default", &handle_default);
    function_63f593f5(#"in_combat", &function_fc7f84b6);
    function_63f593f5(#"hash_156be21f04d01350", &function_64a29ecf);
    function_63f593f5(#"hash_c0bcf7fa0d58e5", &function_178c7d48);
    function_63f593f5(#"revive_player", &function_1e3e2ec7);
    function_63f593f5(#"gameobject_interact", &function_6bc07ca2);
    function_63f593f5(#"hash_797d652ff338b7d4", &function_1a5ba243);
    function_63f593f5(#"visible_enemy", &handle_visible_enemy);
    function_63f593f5(#"hash_608fe62234892b49", &function_227d3c4);
    function_56bef20(#"goal", &get_goal_center);
    function_56bef20(#"gameobject_interact", &function_c29a0472);
    function_56bef20(#"revive_target", &function_40024125);
    function_56bef20(#"self", &function_aada12a0);
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x16d16351, Offset: 0x428
// Size: 0x54
function on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    self reset();
    self set_position(self.origin);
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x4133cbcd, Offset: 0x488
// Size: 0x9e
function start() {
    self thread handle_goal();
    self thread handle_goal_changed();
    self thread handle_path_success();
    self thread handle_path_failed();
    self thread function_b11ffed2();
    self.bot.var_3a7dca10 = undefined;
    self.bot.var_1b9fd613 = 1;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x219778a9, Offset: 0x530
// Size: 0x36
function stop() {
    self notify(#"hash_6cefc75b9a427c7d");
    if (isdefined(self.bot)) {
        self.bot.var_1b9fd613 = 0;
    }
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0xf28d997e, Offset: 0x570
// Size: 0x16
function reset() {
    self.bot.var_622eee0 = 0;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0x7d88743f, Offset: 0x590
// Size: 0x22a
function update(tacbundle) {
    if (!(isdefined(self.bot.var_1b9fd613) && self.bot.var_1b9fd613)) {
        return;
    }
    if (!self.goalforced && self function_f0fa8def(tacbundle)) {
        self.attackeraccuracy = 1;
        self set_position(self.origin);
        return;
    }
    if (self.bot.var_622eee0 > gettime()) {
        return;
    }
    /#
        self bot::record_text("<dev string:x30>", (0, 1, 1), "<dev string:x44>");
    #/
    self.attackeraccuracy = 1;
    if (self.goalforced) {
        /#
            self bot::record_text("<dev string:x57>", (1, 1, 1), "<dev string:x44>");
        #/
        if (isdefined(self.node)) {
            offsetposition = self function_33b393a6(self.node);
            if (isdefined(offsetposition)) {
                /#
                    self bot::record_text("<dev string:x63>", (0, 1, 1), "<dev string:x44>");
                #/
                self function_3c8dce03(offsetposition);
            }
        } else {
            self function_9f59031e();
        }
    } else {
        self function_e2fa90e2(tacbundle);
    }
    self.bot.var_622eee0 = bot::function_905773a(self.bot.tacbundle.var_9e723c34, self.bot.tacbundle.var_1b86fa2a);
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x22c69059, Offset: 0x7c8
// Size: 0x90
function handle_goal() {
    self endon(#"death", #"hash_6cefc75b9a427c7d");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
        self waittill(#"goal");
        /#
            self bot::record_text("<dev string:x71>", (0, 1, 1), "<dev string:x44>");
        #/
    }
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x7b31da1b, Offset: 0x860
// Size: 0x108
function handle_goal_changed() {
    self endon(#"death", #"hash_6cefc75b9a427c7d");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
        self waittill(#"goal_changed");
        goalinfo = self function_e9a79b0e();
        if (self.goalforced) {
            self usecovernode(goalinfo.node);
        } else if (!goalinfo.isatgoal) {
            self usecovernode(undefined);
        }
        if (!self isingoal(self.origin)) {
            self reset();
        }
    }
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x3454bc21, Offset: 0x970
// Size: 0x80
function handle_path_success() {
    self endon(#"death", #"hash_6cefc75b9a427c7d");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
        params = self waittill(#"bot_path_success");
        self bot_action::reset();
    }
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x166f11a1, Offset: 0x9f8
// Size: 0x13e
function handle_path_failed() {
    self endon(#"death", #"hash_6cefc75b9a427c7d");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
        params = self waittill(#"bot_path_failed");
        switch (params.reason) {
        case 1:
        case 2:
        case 3:
            self function_bff21d6d(params.count);
            break;
        case 4:
        case 5:
        case 6:
            break;
        case 7:
        case 8:
            break;
        default:
            break;
        }
    }
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0x8b3a6757, Offset: 0xb40
// Size: 0x94
function function_bff21d6d(failurecount) {
    startpos = self.origin;
    if (self function_1808d49b()) {
        /#
            self botprintwarning("<dev string:x76>" + startpos + "<dev string:x9c>" + self.origin);
        #/
        return;
    }
    /#
        self botprinterror("<dev string:xad>" + startpos);
    #/
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0xdd124f67, Offset: 0xbe0
// Size: 0x74
function function_1808d49b() {
    radius = self getpathfindingradius();
    navmeshpoint = getclosestpointonnavmesh(self.origin, 64, radius);
    if (isdefined(navmeshpoint)) {
        self setorigin(navmeshpoint);
        return true;
    }
    return false;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x47b33369, Offset: 0xc60
// Size: 0x104
function function_e7889b0d() {
    results = positionquery_source_navigation(self.origin, 0, 100, 100, 12, self);
    if (isdefined(results) && results.data.size > 0) {
        pos = results.data[randomint(results.data.size)];
        radius = self getpathfindingradius();
        navmeshpoint = getclosestpointonnavmesh(pos.origin, 64, radius);
        if (isdefined(navmeshpoint)) {
            self setorigin(navmeshpoint);
            return true;
        }
    }
    return false;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0xfe5dfb37, Offset: 0xd70
// Size: 0x1bc
function function_aad17f90() {
    players = [];
    foreach (player in getplayers()) {
        if (isbot(player)) {
            continue;
        }
        if (isalive(player) && !player cansee(self) && isdefined(player.sessionstate) && player.sessionstate == "playing" && !player isinvehicle() && self.team == player.team) {
            players[players.size] = player;
        }
    }
    if (players.size <= 0) {
        return;
    }
    player = players[randomint(players.size)];
    var_4cabed9d = self function_506de8bc(player, 250, 500);
    if (isdefined(var_4cabed9d)) {
        self setorigin(var_4cabed9d);
        return 1;
    }
    return 0;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0xc8f39406, Offset: 0xf38
// Size: 0x122
function can_teleport() {
    foreach (player in getplayers()) {
        if (isbot(player)) {
            continue;
        }
        fwd = anglestoforward(player.angles);
        if (self.team == player.team && vectordot(fwd, self.origin - player.origin) > 0) {
            return false;
        }
        if (player cansee(self)) {
            return false;
        }
    }
    return true;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x3df6dded, Offset: 0x1068
// Size: 0xb0
function function_b11ffed2() {
    self endon(#"death");
    self endon(#"hash_6cefc75b9a427c7d");
    level endon(#"game_ended");
    while (isdefined(self.bot)) {
        params = self waittill(#"grenade danger");
        if (isdefined(params.projectile) && params.projectile.team != self.team) {
            self reset();
        }
    }
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x4e4a5da9, Offset: 0x1120
// Size: 0x2a
function function_63f593f5(name, func) {
    level.var_873feb82[name] = func;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x665bd46a, Offset: 0x1158
// Size: 0x2a
function function_56bef20(name, func) {
    level.var_5dcca4e1[name] = func;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0x9f7b7d5c, Offset: 0x1190
// Size: 0x15c
function function_e2fa90e2(tacbundle) {
    if (!isdefined(tacbundle.positionhandlerlist)) {
        /#
            self bot::record_text("<dev string:xe3>", (1, 0, 0), "<dev string:x44>");
        #/
        return;
    }
    pixbeginevent(#"bot_position_update");
    aiprofile_beginentry("bot_position_update");
    handled = 0;
    foreach (params in tacbundle.positionhandlerlist) {
        if (self function_5893b2b5(params, tacbundle)) {
            self.bot.var_3a7dca10 = params.name;
            handled = 1;
            break;
        }
    }
    pixendevent();
    aiprofile_endentry();
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x959fc781, Offset: 0x12f8
// Size: 0x148
function function_5893b2b5(params, tacbundle) {
    if (!isdefined(params)) {
        return 0;
    }
    func = level.var_873feb82[params.name];
    if (!isdefined(func)) {
        /#
            self botprinterror("<dev string:xfa>" + params.name);
        #/
        return 0;
    }
    /#
        self bot::record_text(function_15979fa9(params.name), (1, 1, 1), "<dev string:x44>");
    #/
    pixbeginevent("bot_execute_position_handler: " + params.name);
    aiprofile_beginentry("bot_execute_position_handler: " + params.name);
    handled = self [[ func ]](params, tacbundle);
    pixendevent();
    aiprofile_endentry();
    return handled;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0xdb23573, Offset: 0x1448
// Size: 0x74
function function_1e52c3e0(name) {
    func = level.var_5dcca4e1[name];
    if (!isdefined(func)) {
        /#
            self botprinterror("<dev string:x11c>" + function_15979fa9(name));
        #/
        return undefined;
    }
    return self [[ func ]]();
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x9d5ad8da, Offset: 0x14c8
// Size: 0x290
function handle_default(params, tacbundle) {
    center = self function_1e52c3e0(params.center);
    if (!isdefined(center)) {
        /#
            self bot::record_text("<dev string:x13d>" + function_15979fa9(params.center), (1, 0, 0), "<dev string:x44>");
        #/
        return 0;
    }
    if (isint(center)) {
        /#
            self bot::record_text("<dev string:x150>" + center, (0, 1, 1), "<dev string:x44>");
        #/
        return function_2a1ba227(params, tacbundle);
    }
    if (isentity(center) && center getentitytype() == 20) {
        return function_f673da96(center);
    }
    query = positionquery_source_navigation(center.origin, 0, center.radius, center.halfheight, 12, self);
    position = undefined;
    if (query.data.size <= 0) {
        if (query.centeronnav) {
            position = center.origin;
        } else {
            /#
                self bot::record_text("<dev string:x159>" + function_15979fa9(params.center), (1, 0, 0), "<dev string:x44>");
                self botprinterror(function_15979fa9(params.name) + "<dev string:x171>" + params.center);
            #/
            return 0;
        }
    } else {
        position = query.data[0].origin;
    }
    self set_position(position);
    return 1;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0xa4abd304, Offset: 0x1760
// Size: 0x1b2
function function_1e3e2ec7(params, tacbundle) {
    if (!self ai::get_behavior_attribute("revive")) {
        /#
            self bot::record_text("<dev string:x189>", (1, 0, 0), "<dev string:x44>");
        #/
        return 0;
    }
    revivetarget = self bot::get_revive_target();
    if (!isdefined(revivetarget)) {
        return 0;
    }
    if (!isdefined(revivetarget.revivetrigger)) {
        self bot::clear_revive_target();
        return 0;
    }
    handled = 1;
    minradius = 30;
    if (distance2dsquared(self.origin, revivetarget.revivetrigger.origin) > minradius * minradius && self istouching(revivetarget.revivetrigger)) {
        self set_position(self.origin);
        handled = 1;
    } else if (self function_9e3c5d83(revivetarget.revivetrigger, minradius)) {
        handled = 1;
    }
    if (handled) {
        self.attackeraccuracy = 0.01;
    }
    return handled;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0xce1a57d3, Offset: 0x1920
// Size: 0x10a
function function_1a5ba243(params, tacbundle) {
    if (!self bot::function_7928da6()) {
        return 0;
    }
    gameobject = self bot::get_interact();
    vehicle = gameobject.e_object;
    if (!isdefined(vehicle) || !isvehicle(vehicle)) {
        return 0;
    }
    trigger = gameobject.trigger;
    if (!isdefined(trigger)) {
        return 0;
    }
    if (self istouching(trigger)) {
        self set_position(self.origin);
        return 1;
    }
    return self function_9e3c5d83(trigger);
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x11133fe, Offset: 0x1a38
// Size: 0x4a
function handle_visible_enemy(params, tacbundle) {
    if (!self bot::has_visible_enemy()) {
        return 0;
    }
    return function_2a1ba227(params, tacbundle);
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0xe898d92b, Offset: 0x1a90
// Size: 0x4a
function function_fc7f84b6(params, tacbundle) {
    if (!self bot::in_combat()) {
        return 0;
    }
    return function_2a1ba227(params, tacbundle);
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x4b0b0790, Offset: 0x1ae8
// Size: 0xaa
function function_64a29ecf(params, tacbundle) {
    goalinfo = self function_e9a79b0e();
    if (!isplayer(goalinfo.goalentity)) {
        return 0;
    }
    if (distancesquared(self.origin, goalinfo.goalentity.origin) < 2048 * 2048) {
        return 0;
    }
    return function_2a1ba227(params, tacbundle);
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x93929988, Offset: 0x1ba0
// Size: 0x4a
function function_178c7d48(params, tacbundle) {
    if (self bot::in_combat()) {
        return 0;
    }
    return function_2a1ba227(params, tacbundle);
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0xaaa04d6f, Offset: 0x1bf8
// Size: 0x1b8
function function_227d3c4(params, tacbundle) {
    facingpos = isdefined(self.enemy) ? self.enemy.origin : self.likelyenemyposition;
    nodes = findbestcovernodesatlocation(self.goalpos, self.goalradius, self.goalheight, self.team, facingpos);
    /#
        if (self bot::should_record("<dev string:x44>")) {
            recordsphere(facingpos, 8, (0, 1, 1), "<dev string:x1a7>", self);
            foreach (node in nodes) {
                function_1e80dbe9(node.origin, (-16, -16, 0), (16, 16, 16), node.angles[0], (0, 1, 1), "<dev string:x1a7>", self);
            }
        }
    #/
    if (nodes.size <= 0) {
        return false;
    }
    self function_3c8dce03(nodes[0]);
    return true;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0xe6dc0a47, Offset: 0x1db8
// Size: 0xca
function function_6bc07ca2(params, tacbundle) {
    if (!self bot::function_7928da6()) {
        return 0;
    }
    gameobject = self bot::get_interact();
    trigger = gameobject.trigger;
    if (!isdefined(trigger)) {
        return 0;
    }
    if (self istouching(trigger)) {
        self set_position(self.origin);
        return 1;
    }
    return self function_9e3c5d83(trigger);
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0xc0ceb6cd, Offset: 0x1e90
// Size: 0x180
function function_f673da96(trigger) {
    if (!isdefined(trigger) || !trigger istriggerenabled()) {
        return 0;
    }
    if (!isdefined(trigger.tacpoints)) {
        trigger.tacpoints = tacticalquery("stratcom_tacquery_trigger", trigger);
    }
    if (!isdefined(trigger.tacpoints) || trigger.tacpoints.size == 0) {
        return self function_9e3c5d83(trigger);
    }
    var_8a507c29 = !isdefined(self.var_eefe5a56) || gettime() - self.var_eefe5a56 > 12000;
    if (!self istouching(trigger)) {
        var_8a507c29 = 1;
    }
    if (var_8a507c29) {
        self.var_eefe5a56 = gettime();
        if (isdefined(trigger.tacpoints) && trigger.tacpoints.size > 0) {
            var_c6f7b849 = array::random(trigger.tacpoints);
            self set_position(var_c6f7b849.origin);
        }
    }
    return 1;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x33b656f2, Offset: 0x2018
// Size: 0x92
function get_goal_center() {
    info = self function_e9a79b0e();
    if (isdefined(info.goalvolume)) {
        return info.goalvolume;
    }
    if (isdefined(info.regionid)) {
        return info.regionid;
    }
    return ai::t_cylinder(info.goalpos, info.goalradius, info.goalheight);
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x655d9a22, Offset: 0x20b8
// Size: 0x3a
function function_c29a0472() {
    if (!self bot::function_7928da6()) {
        return undefined;
    }
    return bot::get_interact().trigger;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x99b478ff, Offset: 0x2100
// Size: 0x52
function function_40024125() {
    revivetarget = self bot::get_revive_target();
    if (!isdefined(revivetarget) || !isdefined(revivetarget.revivetrigger)) {
        return undefined;
    }
    return revivetarget.revivetrigger;
}

// Namespace bot_position/bot_position
// Params 0, eflags: 0x0
// Checksum 0x10283f5d, Offset: 0x2160
// Size: 0x6
function function_aada12a0() {
    return self;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x6f00aaa7, Offset: 0x2170
// Size: 0x1b4
function function_9e3c5d83(trigger, minradius = 0) {
    triggerradius = min(trigger.maxs[0], trigger.maxs[1]);
    results = positionquery_source_navigation(trigger.origin, minradius, triggerradius, trigger.maxs[2], 12, self);
    if (isdefined(results) && results.data.size > 0) {
        /#
            if (self bot::should_record("<dev string:x44>")) {
                foreach (pos in results.data) {
                    recordstar(pos.origin, (0, 1, 1), "<dev string:x1a7>", self);
                }
            }
        #/
        self set_position(results.data[0].origin);
        return true;
    }
    return false;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0xb67786f8, Offset: 0x2330
// Size: 0x270
function function_2a1ba227(params, tacbundle) {
    center = self function_1e52c3e0(params.center);
    if (!isdefined(center)) {
        /#
            self bot::record_text("<dev string:x13d>" + function_15979fa9(params.center), (1, 0, 0), "<dev string:x44>");
        #/
        return false;
    }
    if (isint(center)) {
        /#
            self bot::record_text("<dev string:x150>" + center, (0, 1, 1), "<dev string:x44>");
        #/
    }
    enemy = self.likelyenemyposition;
    if (self bot::in_combat() && isdefined(self.enemy)) {
        enemy = self.enemy;
    }
    position = function_b8a8fdd9(center, self.origin, enemy, params.querylist);
    if (!isdefined(position)) {
        /#
            self bot::record_text("<dev string:x159>" + function_15979fa9(params.center), (1, 0, 0), "<dev string:x44>");
            self botprinterror(function_15979fa9(params.name) + "<dev string:x171>" + params.center);
        #/
        return false;
    }
    claimnode = undefined;
    if (ispathnode(position)) {
        offsetposition = function_33b393a6(position);
        if (isdefined(offsetposition)) {
            claimnode = position;
            position = offsetposition;
        }
    }
    self set_position(position, claimnode);
    return true;
}

// Namespace bot_position/bot_position
// Params 4, eflags: 0x0
// Checksum 0x3803cd5b, Offset: 0x25a8
// Size: 0x84e
function function_b8a8fdd9(center, fillpos, enemy, querylist) {
    pixbeginevent(#"bot_get_tactical_position");
    aiprofile_beginentry("bot_get_tactical_position");
    centerpos = self function_e6eead46(center);
    var_c6a9ad83 = undefined;
    /#
        if (self bot::should_record("<dev string:x44>")) {
            if (isstruct(center) && isdefined(center.origin) && isdefined(center.radius) && isdefined(center.halfheight)) {
                recordcircle(center.origin - (0, 0, center.halfheight), center.radius, (0, 1, 1), "<dev string:x1a7>", self);
                recordcircle(center.origin + (0, 0, center.halfheight), center.radius, (0, 1, 1), "<dev string:x1a7>", self);
                recordline(center.origin - (0, 0, center.halfheight), center.origin + (0, 0, center.halfheight), (0, 1, 1), "<dev string:x1a7>", self);
            } else if (isstruct(center) && center.type == 2) {
                function_1e80dbe9(center.center, center.halfsize * -1, center.halfsize, center.angles[0], (0, 1, 1), "<dev string:x1a7>", self);
            } else if (isentity(center)) {
                maxs = center getmaxs();
                mins = center getmins();
                if (issubstr(center.classname, "<dev string:x1b0>")) {
                    radius = max(maxs[0], maxs[1]);
                    top = center.origin + (0, 0, maxs[2]);
                    bottom = center.origin + (0, 0, mins[2]);
                    recordcircle(bottom, radius, (0, 1, 1), "<dev string:x1a7>", self);
                    recordcircle(top, radius, (0, 1, 1), "<dev string:x1a7>", self);
                    recordline(bottom, top, (0, 1, 1), "<dev string:x1a7>", self);
                } else {
                    function_1e80dbe9(center.origin, mins, maxs, center.angles[0], (0, 1, 1), "<dev string:x1a7>", self);
                }
            }
            if (isdefined(enemy)) {
                enemypos = isentity(enemy) ? enemy.origin : enemy;
                recordline(centerpos, enemypos, (1, 0, 0), "<dev string:x1a7>", self);
                recordstar(enemypos, (1, 0, 0), "<dev string:x1a7>", self);
            }
        }
    #/
    forward = anglestoforward(self.angles);
    forwardpos = self.origin + forward * 100;
    foreach (query in querylist) {
        /#
            self bot::record_text("<dev string:x1b7>" + function_15979fa9(query.name), (1, 1, 1), "<dev string:x44>");
        #/
        tacpoints = tacticalquery(query.name, center, fillpos, centerpos, enemy, self, forward, forwardpos);
        if (tacpoints.size <= 0) {
            /#
                self bot::record_text("<dev string:x1ba>", (1, 0, 0), "<dev string:x44>");
            #/
            continue;
        }
        /#
            self bot::record_text("<dev string:x1ce>" + tacpoints.size + "<dev string:x1d3>", (0, 1, 1), "<dev string:x44>");
            if (self bot::should_record("<dev string:x44>")) {
                foreach (point in tacpoints) {
                    recordcircle(point.origin, 15, (0, 1, 1), "<dev string:x1a7>", self);
                }
            }
        #/
        var_c6a9ad83 = tacpoints[0];
        break;
    }
    pixendevent();
    aiprofile_endentry();
    if (!isdefined(var_c6a9ad83)) {
        return undefined;
    }
    if (isdefined(var_c6a9ad83.node)) {
        distsq = distance2dsquared(var_c6a9ad83.origin, var_c6a9ad83.node.origin);
        if (distsq > 900) {
            /#
                self botprinterror("<dev string:x1e1>" + sqrt(distsq) + "<dev string:x1ff>");
            #/
            return var_c6a9ad83.origin;
        }
        return var_c6a9ad83.node;
    }
    return var_c6a9ad83.origin;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0x46dc0d72, Offset: 0x2e00
// Size: 0x182
function function_33b393a6(node) {
    if (!isfullcovernode(node)) {
        return undefined;
    }
    var_15e215df = node.spawnflags & 262144;
    var_3dc95fa = node.spawnflags & 524288;
    if (!var_15e215df && !var_3dc95fa) {
        return undefined;
    }
    noderight = anglestoright(node.angles);
    offsetdir = noderight;
    if (var_15e215df && var_3dc95fa) {
        if (isdefined(self.enemylastseenpos)) {
            if (vectordot(noderight, self.enemylastseenpos - self.origin) < 0) {
                offsetdir = (0, 0, 0) - offsetdir;
            }
        } else if (randomint(2) > 0) {
            offsetdir = (0, 0, 0) - offsetdir;
        }
    } else if (var_15e215df) {
        offsetdir = (0, 0, 0) - offsetdir;
    }
    return checknavmeshdirection(node.origin, offsetdir, 18, 0);
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0x84349e40, Offset: 0x2f90
// Size: 0x238
function function_f0fa8def(tacbundle) {
    /#
        self bot::record_text("<dev string:x21c>", (0, 1, 1), "<dev string:x44>");
    #/
    if (!isdefined(tacbundle.pathenemyfightdist) || tacbundle.pathenemyfightdist <= 0) {
        /#
            self bot::record_text("<dev string:x23e>", (1, 0, 0), "<dev string:x44>");
        #/
        return false;
    }
    if (self ai::get_behavior_attribute("ignorepathenemyfightdist")) {
        /#
            self bot::record_text("<dev string:x25d>", (1, 0, 0), "<dev string:x44>");
        #/
        return false;
    }
    if (!isdefined(self.enemy)) {
        /#
            self bot::record_text("<dev string:x28c>", (1, 0, 0), "<dev string:x44>");
        #/
        return false;
    }
    if (!self cansee(self.enemy)) {
        /#
            self bot::record_text("<dev string:x297>", (1, 0, 0), "<dev string:x44>");
        #/
        return false;
    }
    distsq = tacbundle.pathenemyfightdist * tacbundle.pathenemyfightdist;
    if (distance2dsquared(self.origin, self.enemy.origin) > distsq) {
        /#
            self bot::record_text("<dev string:x2ab>", (1, 0, 0), "<dev string:x44>");
        #/
        return false;
    }
    /#
        self bot::record_text("<dev string:x2bb>", (0, 1, 1), "<dev string:x44>");
    #/
    return true;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0x2598c8b6, Offset: 0x31d0
// Size: 0x13c
function set_position(position, claimnode = undefined) {
    radius = self getpathfindingradius();
    if (ispathnode(position)) {
        if (!ispointonnavmesh(position.origin, radius)) {
            position = position.origin;
        }
    }
    if (isvec(position)) {
        self usecovernode(claimnode);
        navmeshpoint = getclosestpointonnavmesh(position, 64, radius);
        if (isdefined(navmeshpoint)) {
            self function_3c8dce03(navmeshpoint);
            return;
        } else {
            /#
                self botprinterror("<dev string:x2cb>" + position);
            #/
        }
    }
    self function_3c8dce03(position);
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0x9f92fc74, Offset: 0x3318
// Size: 0xea
function function_e6eead46(center) {
    if (isvec(center)) {
        return center;
    }
    if (isentity(center)) {
        return center.origin;
    }
    if (isstruct(center) && isdefined(center.origin)) {
        return center.origin;
    }
    if (isstruct(center) && isdefined(center.center)) {
        return center.center;
    }
    if (isint(center)) {
        return self.goalpos;
    }
    return undefined;
}

// Namespace bot_position/bot_position
// Params 2, eflags: 0x0
// Checksum 0xa82e9698, Offset: 0x3410
// Size: 0xe0
function function_196af21e(center, var_e6227cca) {
    if (!isdefined(var_e6227cca)) {
        return undefined;
    }
    tacpoints = tacticalquery(var_e6227cca, center);
    if (tacpoints.size == 0) {
        return undefined;
    }
    seeds = [];
    foreach (tacpoint in tacpoints) {
        seeds[seeds.size] = tacpoint.origin;
    }
    return seeds;
}

// Namespace bot_position/bot_position
// Params 1, eflags: 0x0
// Checksum 0x82bc96a, Offset: 0x34f8
// Size: 0x168
function get_pathable_point(points) {
    if (!isdefined(points) || points.size == 0) {
        return undefined;
    }
    radius = self getpathfindingradius();
    navmeshpoint = getclosestpointonnavmesh(self.origin, 64, radius);
    if (!isdefined(navmeshpoint)) {
        /#
            self botprinterror("<dev string:x2f7>" + self.origin);
        #/
        return undefined;
    }
    path = generatenavmeshpath(navmeshpoint, points, self);
    if (!isdefined(path) || !isdefined(path.pathpoints) || path.pathpoints.size == 0) {
        return undefined;
    }
    origin = path.pathpoints[path.pathpoints.size - 1];
    tacpoint = getclosesttacpoint(origin);
    if (isdefined(tacpoint)) {
        return tacpoint.origin;
    }
    return origin;
}

