#using scripts/core_common/array_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace bot;

// Namespace bot/bot_traversals
// Params 3, eflags: 0x0
// Checksum 0x44fd3b41, Offset: 0x1c0
// Size: 0x314
function callback_botentereduseredge(startnode, endnode, endpos) {
    if (!isdefined(endpos)) {
        endpos = endnode.origin;
    }
    zdelta = endnode.origin[2] - startnode.origin[2];
    var_c8bf42bc = distance2d(startnode.origin, endnode.origin);
    var_fc8c7863 = getdvarfloat("player_standingViewHeight", 0);
    var_70bfad97 = var_fc8c7863 * getdvarfloat("player_swimHeightRatio", 0);
    var_d5ec191 = getwaterheight(startnode.origin);
    var_2a0bdecb = var_d5ec191 != 0 && var_d5ec191 > startnode.origin[2] + var_70bfad97;
    var_89153ffc = getwaterheight(endnode.origin);
    var_a56d3a36 = var_89153ffc != 0 && var_89153ffc > endnode.origin[2] + var_70bfad97;
    self botsetmovemagnitude(1);
    if (iswallrunnode(endnode)) {
        self thread function_b5d37467(startnode, endpos);
        return;
    }
    if (var_2a0bdecb && !var_a56d3a36) {
        self thread function_46343d89(endpos);
        return;
    }
    if (var_2a0bdecb && var_a56d3a36) {
        self thread function_6185fafe(endpos);
        return;
    }
    if (zdelta >= 0) {
        self thread jump_up_traversal(endpos);
        return;
    }
    if (zdelta < 0) {
        self thread jump_down_traversal(endpos);
        return;
    }
    self botreleasemanualcontrol();
    /#
        println("<dev string:x28>", self.name, "<dev string:x2d>");
    #/
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0xef1f34fb, Offset: 0x4e0
// Size: 0x7a
function function_e6661162() {
    return !self isonground() || self iswallrunning() || self isdoublejumping() || self ismantling() || self issliding();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0xb8798c37, Offset: 0x568
// Size: 0xbe
function function_46343d89(endpos) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self thread function_2c357c23();
    self botsetmovepoint(endpos);
    while (self isplayerunderwater()) {
        self botpressbutton(67);
        waitframe(1);
    }
    while (true) {
        self botpressbutton(65);
        waitframe(1);
    }
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x31883a1c, Offset: 0x630
// Size: 0x6c
function function_6185fafe(endpos) {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"hash_4c7b12b7");
    self botsetmovepoint(endpos);
    wait 0.5;
    self function_4c7b12b7();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x644027b1, Offset: 0x6a8
// Size: 0x2f4
function jump_up_traversal(endpos) {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"hash_4c7b12b7");
    self thread function_2c357c23();
    ledgetop = checknavmeshdirection(endpos, self.origin - endpos, 128, 1);
    height = ledgetop[2] - self.origin[2];
    if (height <= 72) {
        self thread jump_to(ledgetop);
        return;
    }
    /#
    #/
    dist = distance2d(self.origin, ledgetop);
    var_c9ff4189 = checknavmeshdirection(self.origin, ledgetop - self.origin, dist + 15, 1);
    var_13e97600 = distance2d(self.origin, var_c9ff4189);
    if (var_13e97600 <= dist) {
        self thread jump_to(ledgetop);
        return;
    }
    dist -= 15;
    height -= 72;
    t = height / 80;
    var_a625f80c = self function_a2e25eae();
    speed = self getplayerspeed();
    movedist = t * var_a625f80c;
    if (!movedist || dist > movedist) {
        self thread jump_to(ledgetop);
        return;
    }
    self botsetmovemagnitude(dist / movedist);
    waitframe(1);
    self thread jump_to(ledgetop);
    waitframe(1);
    while (self.origin[2] + 72 < ledgetop[2]) {
        waitframe(1);
    }
    self botsetmovemagnitude(1);
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x3b5df582, Offset: 0x9a8
// Size: 0x34c
function jump_down_traversal(endpos) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self thread function_2c357c23();
    startpos = self.origin;
    fwd = (endpos[0] - startpos[0], endpos[1] - startpos[1], 0);
    fwd = vectornormalize(fwd) * 128;
    start = startpos + (0, 0, 16);
    end = startpos + fwd + (0, 0, 16);
    result = bullettrace(start, end, 0, self);
    if (result["surfacetype"] != "none") {
        self botsetmovepoint(endpos);
        waitframe(1);
        self bottapbutton(10);
        return;
    }
    dist = distance2d(startpos, endpos);
    height = startpos[2] - endpos[2];
    gravity = self getplayergravity();
    t = sqrt(2 * height / gravity);
    var_a625f80c = self function_a2e25eae();
    if (t * var_a625f80c < dist) {
        ledgetop = checknavmeshdirection(startpos, endpos - startpos, 128, 1);
        var_13e97600 = dist - distance2d(startpos, ledgetop);
        var_c9ff4189 = checknavmeshdirection(endpos, startpos - endpos, var_13e97600, 1);
        var_1c7f5b12 = distance2d(ledgetop, var_c9ff4189);
        if (var_1c7f5b12 > 30) {
            self thread jump_to(endpos);
            return;
        }
    }
    self botsetmovepoint(endpos);
}

// Namespace bot/bot_traversals
// Params 3, eflags: 0x0
// Checksum 0xb5430589, Offset: 0xd00
// Size: 0x1ac
function function_b5d37467(startnode, endpos, vector) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self thread function_2c357c23();
    startpos = self.origin;
    wallnormal = getnavmeshfacenormal(endpos, 30);
    wallnormal = vectornormalize((wallnormal[0], wallnormal[1], 0));
    traversaldir = (startpos[0] - endpos[0], startpos[1] - endpos[1], 0);
    cross = vectorcross(wallnormal, traversaldir);
    var_88fb49cd = vectorcross(wallnormal, cross);
    self botsetlookdir(var_88fb49cd);
    self thread jump_to(endpos, vector);
    self thread function_dd501ea(startnode, endpos, wallnormal, var_88fb49cd);
}

// Namespace bot/bot_traversals
// Params 4, eflags: 0x0
// Checksum 0x40c5e70f, Offset: 0xeb8
// Size: 0x174
function function_dd501ea(startnode, endpos, wallnormal, var_88fb49cd) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self waittill("wallrun_begin");
    self thread function_2c357c23();
    self botsetlookdir(var_88fb49cd);
    self botsetmovedir(var_88fb49cd);
    self botreleasebutton(65);
    index = self getnodeindexonpath(startnode);
    index++;
    var_c3cecb77 = self getnexttraversalnodeonpath(index);
    if (isdefined(var_c3cecb77)) {
        var_b024a368 = getothernodeinnegotiationpair(var_c3cecb77);
        if (isdefined(var_b024a368)) {
            self thread function_30486e13(var_c3cecb77, var_b024a368, wallnormal, vectornormalize(var_88fb49cd));
        }
    }
}

// Namespace bot/bot_traversals
// Params 4, eflags: 0x0
// Checksum 0x81216363, Offset: 0x1038
// Size: 0x3c2
function function_30486e13(startnode, endnode, wallnormal, var_c1dc8db1) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self thread function_2c357c23();
    gravity = self getplayergravity();
    vup = sqrt(80 * gravity);
    var_5c76b792 = vup / gravity;
    var_8edc7156 = self.origin[2] + 40;
    falldist = var_8edc7156 - endnode.origin[2];
    if (falldist > 0) {
        var_28ab58ec = sqrt(falldist / 0.5 * gravity);
    } else {
        var_28ab58ec = 0;
    }
    t = var_5c76b792 + var_28ab58ec;
    exitdir = endnode.origin - startnode.origin;
    var_14b3f23a = vectordot(exitdir, wallnormal);
    var_2aab1ec = var_14b3f23a / t;
    if (var_2aab1ec <= 200) {
        dot = sqrt(var_2aab1ec / 200);
        vforward = sqrt(40000 * dot * dot - var_2aab1ec * var_2aab1ec);
    } else {
        vforward = 0;
    }
    while (true) {
        waitframe(1);
        var_834051a9 = endnode.origin - self.origin;
        enddist = vectordot(var_834051a9, var_c1dc8db1);
        var_10d80214 = self function_a2e25eae();
        var_b1a6857a = (var_10d80214 + vforward) * t;
        if (enddist <= var_b1a6857a) {
            var_ee3a8d7e = wallnormal * var_2aab1ec + var_c1dc8db1 * vforward;
            if (iswallrunnode(endnode)) {
                self thread function_b5d37467(startnode, endnode.origin, var_ee3a8d7e);
                return;
            }
            self botsetlookpoint(endnode.origin);
            self thread jump_to(endnode.origin, var_ee3a8d7e);
            return;
        }
    }
}

// Namespace bot/bot_traversals
// Params 2, eflags: 0x0
// Checksum 0x4f9f50e6, Offset: 0x1408
// Size: 0x25c
function jump_to(target, vector) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    if (isdefined(vector)) {
        self botsetmovedir(vector);
        movedir = vectornormalize((vector[0], vector[1], 0));
    } else {
        self botsetmovepoint(target);
        targetdelta = target - self.origin;
        movedir = vectornormalize((targetdelta[0], targetdelta[1], 0));
    }
    velocity = self getvelocity();
    var_819400cd = vectornormalize((velocity[0], velocity[1], 0));
    if (vectordot(movedir, var_819400cd) < 0.94) {
        waitframe(1);
    }
    self bottapbutton(10);
    waitframe(1);
    while (!self isonground() && !self ismantling() && !self iswallrunning() && !self function_6918d9ba(target)) {
        self botpressbutton(65);
        if (!isdefined(vector)) {
            self botsetmovepoint(target);
        }
        waitframe(1);
    }
    self botreleasebutton(65);
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x535ece69, Offset: 0x1670
// Size: 0x66
function function_6581f3cc(target) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    while (!self ismantling()) {
        self botsetmovepoint(target);
        waitframe(1);
    }
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x26ed5772, Offset: 0x16e0
// Size: 0x19e
function function_6918d9ba(target) {
    velocity = self getvelocity();
    targetdir = target - self.origin;
    targetdir = (targetdir[0], targetdir[1], 0);
    if (self.origin[2] > target[2] && vectordot(velocity, targetdir) <= 0) {
        return true;
    }
    targetdist = length(targetdir);
    targetspeed = length(velocity);
    if (targetspeed == 0) {
        return false;
    }
    t = targetdist / targetspeed;
    gravity = self getplayergravity();
    height = self.origin[2] + velocity[2] * t - gravity * t * t * 0.5;
    /#
    #/
    return height >= target[2] + 32;
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0x55365838, Offset: 0x1888
// Size: 0x54
function function_a2e25eae() {
    velocity = self getvelocity();
    var_a625f80c = distance2d(velocity, (0, 0, 0));
    return var_a625f80c;
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0xe4e4d379, Offset: 0x18e8
// Size: 0x94
function function_2c357c23() {
    self notify(#"hash_8a16cc3b");
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    self endon(#"hash_8a16cc3b");
    level endon(#"game_ended");
    self thread function_f0530225();
    self thread function_fe1ccdcd();
    self waittill("acrobatics_end");
    self thread function_4c7b12b7();
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0xd5c8e169, Offset: 0x1988
// Size: 0x94
function function_fe1ccdcd() {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    self endon(#"hash_8a16cc3b");
    level endon(#"game_ended");
    while (self isplayerswimming()) {
        waitframe(1);
    }
    waitframe(1);
    while (!self isplayerswimming()) {
        waitframe(1);
    }
    self thread function_4c7b12b7();
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0x85e5188b, Offset: 0x1a28
// Size: 0x54
function function_f0530225() {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    self endon(#"hash_8a16cc3b");
    level endon(#"game_ended");
    wait 8;
    self thread function_4c7b12b7();
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0xdafff51, Offset: 0x1a88
// Size: 0x5c
function function_4c7b12b7() {
    self notify(#"hash_4c7b12b7");
    self botreleasebutton(65);
    self botsetmovemagnitude(1);
    self botreleasemanualcontrol();
}

