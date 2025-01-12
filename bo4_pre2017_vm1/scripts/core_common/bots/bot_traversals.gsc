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
    xydist = distance2d(startnode.origin, endnode.origin);
    standingviewheight = getdvarfloat("player_standingViewHeight", 0);
    swimwaterheight = standingviewheight * getdvarfloat("player_swimHeightRatio", 0);
    startwaterheight = getwaterheight(startnode.origin);
    startinwater = startwaterheight != 0 && startwaterheight > startnode.origin[2] + swimwaterheight;
    endwaterheight = getwaterheight(endnode.origin);
    endinwater = endwaterheight != 0 && endwaterheight > endnode.origin[2] + swimwaterheight;
    self botsetmovemagnitude(1);
    if (iswallrunnode(endnode)) {
        self thread wallrun_traversal(startnode, endpos);
        return;
    }
    if (startinwater && !endinwater) {
        self thread leave_water_traversal(endpos);
        return;
    }
    if (startinwater && endinwater) {
        self thread swim_traversal(endpos);
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
function traversing() {
    return !self isonground() || self iswallrunning() || self isdoublejumping() || self ismantling() || self issliding();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0xb8798c37, Offset: 0x568
// Size: 0xbe
function leave_water_traversal(endpos) {
    self endon(#"death");
    self endon(#"traversal_end");
    level endon(#"game_ended");
    self thread watch_traversal_end();
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
function swim_traversal(endpos) {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"traversal_end");
    self botsetmovepoint(endpos);
    wait 0.5;
    self traversal_end();
}

// Namespace bot/bot_traversals
// Params 1, eflags: 0x0
// Checksum 0x644027b1, Offset: 0x6a8
// Size: 0x2f4
function jump_up_traversal(endpos) {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"traversal_end");
    self thread watch_traversal_end();
    ledgetop = checknavmeshdirection(endpos, self.origin - endpos, 128, 1);
    height = ledgetop[2] - self.origin[2];
    if (height <= 72) {
        self thread jump_to(ledgetop);
        return;
    }
    /#
    #/
    dist = distance2d(self.origin, ledgetop);
    ledgebottom = checknavmeshdirection(self.origin, ledgetop - self.origin, dist + 15, 1);
    bottomdist = distance2d(self.origin, ledgebottom);
    if (bottomdist <= dist) {
        self thread jump_to(ledgetop);
        return;
    }
    dist -= 15;
    height -= 72;
    t = height / 80;
    speed2d = self bot_speed2d();
    speed = self getplayerspeed();
    movedist = t * speed2d;
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
    self endon(#"traversal_end");
    level endon(#"game_ended");
    self thread watch_traversal_end();
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
    speed2d = self bot_speed2d();
    if (t * speed2d < dist) {
        ledgetop = checknavmeshdirection(startpos, endpos - startpos, 128, 1);
        bottomdist = dist - distance2d(startpos, ledgetop);
        ledgebottom = checknavmeshdirection(endpos, startpos - endpos, bottomdist, 1);
        meshdist = distance2d(ledgetop, ledgebottom);
        if (meshdist > 30) {
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
function wallrun_traversal(startnode, endpos, vector) {
    self endon(#"death");
    self endon(#"traversal_end");
    level endon(#"game_ended");
    self thread watch_traversal_end();
    startpos = self.origin;
    wallnormal = getnavmeshfacenormal(endpos, 30);
    wallnormal = vectornormalize((wallnormal[0], wallnormal[1], 0));
    traversaldir = (startpos[0] - endpos[0], startpos[1] - endpos[1], 0);
    cross = vectorcross(wallnormal, traversaldir);
    rundir = vectorcross(wallnormal, cross);
    self botsetlookdir(rundir);
    self thread jump_to(endpos, vector);
    self thread wait_wallrun_begin(startnode, endpos, wallnormal, rundir);
}

// Namespace bot/bot_traversals
// Params 4, eflags: 0x0
// Checksum 0x40c5e70f, Offset: 0xeb8
// Size: 0x174
function wait_wallrun_begin(startnode, endpos, wallnormal, rundir) {
    self endon(#"death");
    self endon(#"traversal_end");
    level endon(#"game_ended");
    self waittill("wallrun_begin");
    self thread watch_traversal_end();
    self botsetlookdir(rundir);
    self botsetmovedir(rundir);
    self botreleasebutton(65);
    index = self getnodeindexonpath(startnode);
    index++;
    exitstartnode = self getnexttraversalnodeonpath(index);
    if (isdefined(exitstartnode)) {
        exitendnode = getothernodeinnegotiationpair(exitstartnode);
        if (isdefined(exitendnode)) {
            self thread exit_wallrun(exitstartnode, exitendnode, wallnormal, vectornormalize(rundir));
        }
    }
}

// Namespace bot/bot_traversals
// Params 4, eflags: 0x0
// Checksum 0x81216363, Offset: 0x1038
// Size: 0x3c2
function exit_wallrun(startnode, endnode, wallnormal, runnormal) {
    self endon(#"death");
    self endon(#"traversal_end");
    level endon(#"game_ended");
    self thread watch_traversal_end();
    gravity = self getplayergravity();
    vup = sqrt(80 * gravity);
    tpeak = vup / gravity;
    hpeak = self.origin[2] + 40;
    falldist = hpeak - endnode.origin[2];
    if (falldist > 0) {
        tfall = sqrt(falldist / 0.5 * gravity);
    } else {
        tfall = 0;
    }
    t = tpeak + tfall;
    exitdir = endnode.origin - startnode.origin;
    dnormal = vectordot(exitdir, wallnormal);
    vnormal = dnormal / t;
    if (vnormal <= 200) {
        dot = sqrt(vnormal / 200);
        vforward = sqrt(40000 * dot * dot - vnormal * vnormal);
    } else {
        vforward = 0;
    }
    while (true) {
        waitframe(1);
        enddir = endnode.origin - self.origin;
        enddist = vectordot(enddir, runnormal);
        vrun = self bot_speed2d();
        dforward = (vrun + vforward) * t;
        if (enddist <= dforward) {
            jumpangle = wallnormal * vnormal + runnormal * vforward;
            if (iswallrunnode(endnode)) {
                self thread wallrun_traversal(startnode, endnode.origin, jumpangle);
                return;
            }
            self botsetlookpoint(endnode.origin);
            self thread jump_to(endnode.origin, jumpangle);
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
    self endon(#"traversal_end");
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
    velocitydir = vectornormalize((velocity[0], velocity[1], 0));
    if (vectordot(movedir, velocitydir) < 0.94) {
        waitframe(1);
    }
    self bottapbutton(10);
    waitframe(1);
    while (!self isonground() && !self ismantling() && !self iswallrunning() && !self bot_hit_target(target)) {
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
function bot_update_move_angle(target) {
    self endon(#"death");
    self endon(#"traversal_end");
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
function bot_hit_target(target) {
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
function bot_speed2d() {
    velocity = self getvelocity();
    speed2d = distance2d(velocity, (0, 0, 0));
    return speed2d;
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0xe4e4d379, Offset: 0x18e8
// Size: 0x94
function watch_traversal_end() {
    self notify(#"watch_travesal_end");
    self endon(#"death");
    self endon(#"traversal_end");
    self endon(#"watch_travesal_end");
    level endon(#"game_ended");
    self thread wait_traversal_timeout();
    self thread watch_start_swimming();
    self waittill("acrobatics_end");
    self thread traversal_end();
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0xd5c8e169, Offset: 0x1988
// Size: 0x94
function watch_start_swimming() {
    self endon(#"death");
    self endon(#"traversal_end");
    self endon(#"watch_travesal_end");
    level endon(#"game_ended");
    while (self isplayerswimming()) {
        waitframe(1);
    }
    waitframe(1);
    while (!self isplayerswimming()) {
        waitframe(1);
    }
    self thread traversal_end();
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0x85e5188b, Offset: 0x1a28
// Size: 0x54
function wait_traversal_timeout() {
    self endon(#"death");
    self endon(#"traversal_end");
    self endon(#"watch_travesal_end");
    level endon(#"game_ended");
    wait 8;
    self thread traversal_end();
}

// Namespace bot/bot_traversals
// Params 0, eflags: 0x0
// Checksum 0xdafff51, Offset: 0x1a88
// Size: 0x5c
function traversal_end() {
    self notify(#"traversal_end");
    self botreleasebutton(65);
    self botsetmovemagnitude(1);
    self botreleasemanualcontrol();
}

