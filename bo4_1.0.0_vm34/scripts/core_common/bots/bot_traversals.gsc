#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_animation;

#namespace bot;

// Namespace bot/bot_traversals
// Params 6, eflags: 0x0
// Checksum 0x9ac884fb, Offset: 0xc0
// Size: 0x18c
function callback_botentereduseredge(startnode, endnode, mantlenode, startpos, endpos, mantlepos) {
    if (self isplayinganimscripted()) {
        /#
            self botprinterror("<dev string:x30>");
        #/
        waitframe(1);
        self botreleasemanualcontrol();
        return;
    }
    if (startnode.type !== "Volume") {
        /#
            self botprinterror("<dev string:x5f>");
        #/
        self thread fallback_traversal(endpos);
        return;
    }
    params = spawnstruct();
    params.startnode = startnode;
    params.endnode = endnode;
    params.mantlenode = mantlenode;
    params.startpos = startpos;
    params.endpos = endpos;
    params.mantlepos = mantlepos;
    self analyze(params);
    self thread volume_traversal(params);
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0x5a90147, Offset: 0x258
// Size: 0x16
function cancel() {
    self notify(#"hash_a729d7d4c6847f6");
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x2996ac1e, Offset: 0x278
// Size: 0xbc
function fallback_traversal(endpos) {
    self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_37fc5d1ffce4acaf");
    self endoncallback(&release_control, #"entering_last_stand", #"new_shot");
    level endon(#"game_ended");
    self teleport(endpos, "Legacy fallback");
    self botreleasemanualcontrol();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0xd16fbec8, Offset: 0x340
// Size: 0xc4
function function_2ccaf3ac(params) {
    self.traversestartnode = params.startnode;
    self.traversalstartpos = params.startpos;
    self.traverseendnode = params.endnode;
    self.traversalendpos = params.endpos;
    self.traversemantlenode = params.mantlenode;
    bot_animation::play_animation("parametric_traverse@traversal");
    self.traversestartnode = undefined;
    self.traversalstartpos = undefined;
    self.traverseendnode = undefined;
    self.traversalendpos = undefined;
    self.traversemantlenode = undefined;
    self release_control();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x7718b638, Offset: 0x410
// Size: 0x3dc
function volume_traversal(params) {
    self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_37fc5d1ffce4acaf");
    self endoncallback(&release_control, #"entering_last_stand", #"new_shot");
    level endon(#"game_ended");
    self.bot.traversal = params;
    self bot_action::reset();
    self thread traversal_timeout(params);
    if (params.var_c194b041) {
        self function_64b75eee(params);
    } else if (params.dist2d > 30) {
        /#
            self botprinterror("<dev string:x7c>");
        #/
        self thread function_2ccaf3ac(params);
        return;
    } else if (abs(params.targetheight) <= 18) {
        self walk_traversal(params);
    } else if (params.targetheight > 0) {
        if (params.var_6a81c0e0 < 0) {
            /#
                self botprinterror("<dev string:x8c>");
            #/
            self thread function_2ccaf3ac(params);
            return;
        } else {
            self mantle_traversal(params);
        }
    } else if (params.targetheight < -72) {
        /#
            self botprinterror("<dev string:x9e>");
        #/
        self thread function_2ccaf3ac(params);
        return;
    } else if (params.targetheight < 0) {
        self fall_traversal(params.endpos);
    } else {
        /#
            self botprinterror("<dev string:xaf>" + params.startnode.origin);
        #/
        self thread function_2ccaf3ac(params);
        return;
    }
    if (!ispointonnavmesh(self.origin, self)) {
        /#
            self botprinterror("<dev string:xc8>" + params.startnode.origin);
        #/
        self thread function_2ccaf3ac(params);
        return;
    } else if (distancesquared(self.origin, params.endpos) > distancesquared(self.origin, params.startpos)) {
        /#
            self botprinterror("<dev string:xe9>");
        #/
        self thread function_2ccaf3ac(params);
        return;
    }
    self release_control();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x5991f618, Offset: 0x7f8
// Size: 0x5c
function release_control(notifyhash) {
    self notify(#"hash_612231aa5def85e2");
    if (!isbot(self)) {
        return;
    }
    self.bot.traversal = undefined;
    self botreleasemanualcontrol();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x2c12637a, Offset: 0x860
// Size: 0xdc
function traversal_timeout(params) {
    self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_612231aa5def85e2");
    level endon(#"game_ended");
    wait 3.5;
    /#
        self botprinterror("<dev string:x112>" + params.startnode.origin);
    #/
    self notify(#"hash_37fc5d1ffce4acaf");
    self thread function_2ccaf3ac(params);
    self.bot.traversal = undefined;
    self botreleasemanualcontrol();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0xb01d295b, Offset: 0x948
// Size: 0x37c
function analyze(params) {
    params.starttrace = checknavmeshdirection(params.startpos, params.endpos - params.startpos, 112, 0);
    params.endtrace = checknavmeshdirection(params.endpos, params.startpos - params.endpos, 112, 0);
    params.targetpos = isdefined(params.mantlepos) ? params.mantlepos : params.endtrace;
    params.targetheight = params.targetpos[2] - params.starttrace[2];
    normal = params.startpos - params.endpos;
    params.normal = vectornormalize((normal[0], normal[1], 0));
    if (distance2dsquared(params.starttrace, params.targetpos) == 0) {
        params.var_6a81c0e0 = 0;
    } else {
        params.var_6a81c0e0 = vectordot(params.starttrace - params.targetpos, params.normal);
    }
    params.dist2d = distance2d(params.starttrace, params.targetpos);
    params.var_c194b041 = function_a7274313(params);
    /#
        if (self should_record("<dev string:x12b>")) {
            var_2bf1fe3d = (params.targetpos[0], params.targetpos[1], params.starttrace[2]);
            var_2a0e889a = params.dist2d < 30 ? (0, 1, 0) : (1, 0, 0);
            recordline(params.starttrace, var_2bf1fe3d, var_2a0e889a, "<dev string:x13a>", self);
            recordsphere(var_2bf1fe3d, 3, var_2a0e889a, "<dev string:x13a>", self);
            recordsphere(params.starttrace, 3, (0, 1, 0), "<dev string:x13a>", self);
            recordsphere(params.targetpos, 3, (1, 0, 1), "<dev string:x13a>", self);
        }
    #/
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0xcf46c1c0, Offset: 0xcd0
// Size: 0xc4
function function_a7274313(params) {
    if (params.targetheight < 18) {
        return false;
    }
    dir = vectornormalize(params.endpos - params.startpos);
    result = bullettrace(params.startpos, params.startpos + dir * 112, 0, self);
    if (result[#"surfacetype"] == "ladder") {
        return true;
    }
    return false;
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x4e154f50, Offset: 0xda0
// Size: 0xc4
function mantle_traversal(params) {
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x143>", self.origin, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
        }
    #/
    edge_approach(params.starttrace, params.normal, 20);
    jump(params.targetpos);
    mantle(params.targetpos);
}

// Namespace bot/bot_traversals
// Params 3, eflags: 0x0
// Checksum 0x8d31b226, Offset: 0xe70
// Size: 0x1ba
function ledge_traversal(endpos, ledgetop, normal) {
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x154>", self.origin, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
        }
    #/
    trace = bullettrace(ledgetop, ledgetop - (0, 0, 1024), 0, self);
    var_5211931d = trace[#"position"];
    self botsetmovepoint(endpos);
    for (var_6735ba31 = vectordot(self.origin - var_5211931d, normal); var_6735ba31 > 20; var_6735ba31 = vectordot(self.origin - var_5211931d, normal)) {
        waitframe(1);
    }
    self botsetmovemagnitude(0);
    self bottapbutton(10);
    waitframe(1);
    while (!self isonground() || self ismantling()) {
        waitframe(1);
    }
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x30e0cfff, Offset: 0x1038
// Size: 0xc4
function jump_traversal(params) {
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x164>", self.origin, (1, 1, 0), "<dev string:x13a>", undefined, 0.5);
        }
    #/
    self edge_approach(params.starttrace, params.normal);
    self jump(params.targetpos);
    self fall();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x6753aabb, Offset: 0x1108
// Size: 0xb4
function fall_traversal(endpos) {
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x173>", self.origin, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
        }
    #/
    self botsetmovemagnitude(1);
    self botsetmovepoint(endpos);
    self fall();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x52232ed6, Offset: 0x11c8
// Size: 0x132
function walk_traversal(params) {
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x182>", self.origin, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
        }
    #/
    self botsetmovemagnitude(1);
    self botsetmovepoint(params.endpos);
    dist = distance2dsquared(self.origin, params.endpos);
    prev_dist = dist;
    while (dist > 256 && prev_dist >= dist) {
        waitframe(1);
        prev_dist = dist;
        dist = distance2dsquared(self.origin, params.endpos);
    }
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x7f353f0a, Offset: 0x1308
// Size: 0x50
function function_64b75eee(params) {
    self botsetmovepoint(params.endpos);
    while (!self isonground()) {
        waitframe(1);
    }
}

// Namespace bot/bot_traversals
// Params 2, eflags: 0x0
// Checksum 0x166c11ce, Offset: 0x1360
// Size: 0xaa
function teleport(endpos, reason) {
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x191>" + reason, self.origin, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
        }
    #/
    self setorigin(endpos);
    self dontinterpolate();
    waitframe(1);
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0xb13d888c, Offset: 0x1418
// Size: 0xe2
function mantle(mantlepos) {
    self botsetmovemagnitude(1);
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x19c>", mantlepos, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
            recordsphere(mantlepos, 3, (1, 1, 0), "<dev string:x13a>", self);
        }
    #/
    while (!self isonground() || self ismantling()) {
        waitframe(1);
    }
}

// Namespace bot/bot_traversals
// Params 3, eflags: 0x0
// Checksum 0xd78c795f, Offset: 0x1508
// Size: 0x172
function edge_approach(edgepos, normal, dist = 0) {
    /#
        if (self should_record("<dev string:x12b>")) {
            recordtext = "<dev string:x1a3>";
            if (dist > 0) {
                recordtext = recordtext + "<dev string:x1b1>" + dist;
            }
            record3dtext(recordtext, edgepos, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
            recordsphere(edgepos, 3, (0, 1, 0), "<dev string:x13a>", self);
        }
    #/
    self botsetmovepoint(edgepos);
    self botsetmovemagnitude(1);
    for (var_c59c969a = vectordot(self.origin - edgepos, normal); var_c59c969a > dist; var_c59c969a = vectordot(self.origin - edgepos, normal)) {
        waitframe(1);
    }
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0xd54283da, Offset: 0x1688
// Size: 0xa2
function jump(var_77472651) {
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x1b3>", var_77472651, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
            recordsphere(var_77472651, 3, (1, 1, 1), "<dev string:x13a>", self);
        }
    #/
    self bottapbutton(10);
    waitframe(1);
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0xd8593e50, Offset: 0x1738
// Size: 0xa0
function fall() {
    /#
        if (self should_record("<dev string:x12b>")) {
            record3dtext("<dev string:x1b8>", self.origin, (1, 1, 1), "<dev string:x13a>", undefined, 0.5);
        }
    #/
    while (self isonground()) {
        waitframe(1);
    }
    while (!self isonground()) {
        waitframe(1);
    }
}

