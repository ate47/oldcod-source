#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace zombie_utility;

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xe5d9b439, Offset: 0x490
// Size: 0xfa
function zombiespawnsetup() {
    self.zombie_move_speed = "walk";
    if (!isdefined(self.zombie_arms_position)) {
        if (randomint(3) == 0) {
            self.zombie_arms_position = "up";
        } else {
            self.zombie_arms_position = "down";
        }
    }
    self function_df5afb5e(0);
    if (!is_true(self.ai.var_870d0893)) {
        self setavoidancemask("avoid none");
    }
    self collidewithactors(1);
    clientfield::set("zombie", 1);
    self.ignorepathenemyfightdist = 1;
}

// Namespace zombie_utility/zombie_utility
// Params 3, eflags: 0x0
// Checksum 0x66b56935, Offset: 0x598
// Size: 0x25c
function get_closest_valid_player(origin, ignore_player, ignore_laststand_players = 0) {
    pixbeginevent(#"");
    valid_player_found = 0;
    targets = getplayers();
    if (isdefined(level.closest_player_targets_override)) {
        targets = [[ level.closest_player_targets_override ]]();
    }
    if (isdefined(ignore_player)) {
        for (i = 0; i < ignore_player.size; i++) {
            arrayremovevalue(targets, ignore_player[i]);
        }
    }
    done = 1;
    while (targets.size && !done) {
        done = 1;
        for (i = 0; i < targets.size; i++) {
            target = targets[i];
            if (!is_player_valid(target, 1, ignore_laststand_players)) {
                arrayremovevalue(targets, target);
                done = 0;
                break;
            }
        }
    }
    if (targets.size == 0) {
        profilestop();
        return undefined;
    }
    if (isdefined(self.closest_player_override)) {
        target = [[ self.closest_player_override ]](origin, targets);
    } else if (isdefined(level.closest_player_override)) {
        target = [[ level.closest_player_override ]](origin, targets);
    }
    if (isdefined(target)) {
        profilestop();
        return target;
    }
    sortedpotentialtargets = arraysortclosest(targets, self.origin);
    while (sortedpotentialtargets.size) {
        if (is_player_valid(sortedpotentialtargets[0], 1, ignore_laststand_players)) {
            profilestop();
            return sortedpotentialtargets[0];
        }
        arrayremovevalue(sortedpotentialtargets, sortedpotentialtargets[0]);
    }
    profilestop();
    return undefined;
}

// Namespace zombie_utility/zombie_utility
// Params 4, eflags: 0x0
// Checksum 0x8a5dd6f7, Offset: 0x800
// Size: 0x1a4
function is_player_valid(player, checkignoremeflag, ignore_laststand_players, var_da861165 = 1) {
    if (!isdefined(player)) {
        return 0;
    }
    if (!isalive(player)) {
        return 0;
    }
    if (!isplayer(player)) {
        return 0;
    }
    if (isdefined(player.is_zombie) && player.is_zombie == 1) {
        return 0;
    }
    if (player.sessionstate == "spectator") {
        return 0;
    }
    if (player.sessionstate == "intermission") {
        return 0;
    }
    if (!var_da861165 && player scene::is_igc_active()) {
        return 0;
    }
    if (is_true(player.intermission)) {
        return 0;
    }
    if (!is_true(ignore_laststand_players)) {
        if (player laststand::player_is_in_laststand()) {
            return 0;
        }
    }
    if (is_true(checkignoremeflag) && (player.ignoreme || player isnotarget())) {
        return 0;
    }
    if (isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](player);
    }
    return 1;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x2c6cbf7d, Offset: 0x9b0
// Size: 0x5a
function append_missing_legs_suffix(animstate) {
    if (is_true(self.missinglegs) && self hasanimstatefromasd(animstate + "_crawl")) {
        return (animstate + "_crawl");
    }
    return animstate;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xb0cf3446, Offset: 0xa18
// Size: 0x76
function initanimtree(animscript) {
    if (animscript != "pain" && animscript != "death") {
        self.a.special = "none";
    }
    assert(isdefined(animscript), "<dev string:x38>");
    self.a.script = animscript;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x5ee0e025, Offset: 0xa98
// Size: 0xae
function updateanimpose() {
    assert(self.a.movement == "<dev string:x64>" || self.a.movement == "<dev string:x6c>" || self.a.movement == "<dev string:x74>", "<dev string:x7b>" + self.a.pose + "<dev string:x8e>" + self.a.movement);
    self.desired_anim_pose = undefined;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xac1a1bc9, Offset: 0xb50
// Size: 0x214
function initialize(animscript) {
    if (isdefined(self.longdeathstarting)) {
        if (animscript != "pain" && animscript != "death") {
            self dodamage(self.health + 100, self.origin);
        }
        if (animscript != "pain") {
            self.longdeathstarting = undefined;
            self notify(#"kill_long_death");
        }
    }
    if (isdefined(self.a.mayonlydie) && animscript != "death") {
        self dodamage(self.health + 100, self.origin);
    }
    if (isdefined(self.a.postscriptfunc)) {
        scriptfunc = self.a.postscriptfunc;
        self.a.postscriptfunc = undefined;
        [[ scriptfunc ]](animscript);
    }
    if (animscript != "death") {
        self.a.nodeath = 0;
    }
    self.isholdinggrenade = undefined;
    self.covernode = undefined;
    self.changingcoverpos = 0;
    self.a.scriptstarttime = gettime();
    self.a.atconcealmentnode = 0;
    if (isdefined(self.node) && (self.node.type == #"conceal crouch" || self.node.type == #"conceal stand")) {
        self.a.atconcealmentnode = 1;
    }
    initanimtree(animscript);
    updateanimpose();
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x9ca801dc, Offset: 0xd70
// Size: 0x92
function getnodeyawtoorigin(pos) {
    if (isdefined(self.node)) {
        yaw = self.node.angles[1] - getyaw(pos);
    } else {
        yaw = self.angles[1] - getyaw(pos);
    }
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xa108100f, Offset: 0xe10
// Size: 0x142
function getnodeyawtoenemy() {
    pos = undefined;
    if (isvalidenemy(self.enemy)) {
        pos = self.enemy.origin;
    } else {
        if (isdefined(self.node)) {
            forward = anglestoforward(self.node.angles);
        } else {
            forward = anglestoforward(self.angles);
        }
        forward = vectorscale(forward, 150);
        pos = self.origin + forward;
    }
    if (isdefined(self.node)) {
        yaw = self.node.angles[1] - getyaw(pos);
    } else {
        yaw = self.angles[1] - getyaw(pos);
    }
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xbf7bf4ce, Offset: 0xf60
// Size: 0x132
function getcovernodeyawtoenemy() {
    pos = undefined;
    if (isvalidenemy(self.enemy)) {
        pos = self.enemy.origin;
    } else {
        forward = anglestoforward(self.covernode.angles + self.animarray[#"angle_step_out"][self.a.cornermode]);
        forward = vectorscale(forward, 150);
        pos = self.origin + forward;
    }
    yaw = self.covernode.angles[1] + self.animarray[#"angle_step_out"][self.a.cornermode] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xa77d2354, Offset: 0x10a0
// Size: 0x62
function getyawtospot(spot) {
    pos = spot;
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x60877c70, Offset: 0x1110
// Size: 0xca
function getyawtoenemy() {
    pos = undefined;
    if (isvalidenemy(self.enemy)) {
        pos = self.enemy.origin;
    } else {
        forward = anglestoforward(self.angles);
        forward = vectorscale(forward, 150);
        pos = self.origin + forward;
    }
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x1504f238, Offset: 0x11e8
// Size: 0x3e
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x345bfeb3, Offset: 0x1230
// Size: 0x66
function getyaw2d(org) {
    angles = vectortoangles((org[0], org[1], 0) - (self.origin[0], self.origin[1], 0));
    return angles[1];
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x4250257c, Offset: 0x12a0
// Size: 0xa2
function absyawtoenemy() {
    assert(isvalidenemy(self.enemy));
    yaw = self.angles[1] - getyaw(self.enemy.origin);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xcf188539, Offset: 0x1350
// Size: 0xa2
function absyawtoenemy2d() {
    assert(isvalidenemy(self.enemy));
    yaw = self.angles[1] - getyaw2d(self.enemy.origin);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xe0e712, Offset: 0x1400
// Size: 0x6a
function absyawtoorigin(org) {
    yaw = self.angles[1] - getyaw(org);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x98d375c2, Offset: 0x1478
// Size: 0x5a
function absyawtoangles(angles) {
    yaw = self.angles[1] - angles;
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x60bf420d, Offset: 0x14e0
// Size: 0x3e
function getyawfromorigin(org, start) {
    angles = vectortoangles(org - start);
    return angles[1];
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xfeac1f80, Offset: 0x1528
// Size: 0x7a
function getyawtotag(tag, org) {
    yaw = self gettagangles(tag)[1] - getyawfromorigin(org, self gettagorigin(tag));
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x304d6e65, Offset: 0x15b0
// Size: 0x52
function getyawtoorigin(org) {
    yaw = self.angles[1] - getyaw(org);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x43eddcb1, Offset: 0x1610
// Size: 0x6a
function geteyeyawtoorigin(org) {
    yaw = self gettagangles("TAG_EYE")[1] - getyaw(org);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x619d5393, Offset: 0x1688
// Size: 0x82
function getcovernodeyawtoorigin(org) {
    yaw = self.covernode.angles[1] + self.animarray[#"angle_step_out"][self.a.cornermode] - getyaw(org);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xbd1a6137, Offset: 0x1718
// Size: 0x4a
function isstanceallowedwrapper(stance) {
    if (isdefined(self.covernode)) {
        return doesnodeallowstance(self.covernode, stance);
    }
    return self isstanceallowed(stance);
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x4186a6a7, Offset: 0x1770
// Size: 0x62
function getclaimednode() {
    mynode = self.node;
    if (isdefined(mynode) && (self nearnode(mynode) || isdefined(self.covernode) && mynode == self.covernode)) {
        return mynode;
    }
    return undefined;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xa1f51bef, Offset: 0x17e0
// Size: 0x36
function getnodetype() {
    mynode = getclaimednode();
    if (isdefined(mynode)) {
        return mynode.type;
    }
    return "none";
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x67652eb2, Offset: 0x1820
// Size: 0x3e
function getnodedirection() {
    mynode = getclaimednode();
    if (isdefined(mynode)) {
        return mynode.angles[1];
    }
    return self.desiredangle;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x2201786a, Offset: 0x1868
// Size: 0x5a
function getnodeforward() {
    mynode = getclaimednode();
    if (isdefined(mynode)) {
        return anglestoforward(mynode.angles);
    }
    return anglestoforward(self.angles);
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x66d3820, Offset: 0x18d0
// Size: 0x36
function getnodeorigin() {
    mynode = getclaimednode();
    if (isdefined(mynode)) {
        return mynode.origin;
    }
    return self.origin;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x8f727e98, Offset: 0x1910
// Size: 0x4c
function safemod(a, b) {
    result = int(a) % b;
    result += b;
    return result % b;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xf140d2c, Offset: 0x1968
// Size: 0x4c
function angleclamp(angle) {
    anglefrac = angle / 360;
    angle = (anglefrac - floor(anglefrac)) * 360;
    return angle;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xecfa56ab, Offset: 0x19c0
// Size: 0x28c
function quadrantanimweights(yaw) {
    forwardweight = (90 - abs(yaw)) / 90;
    leftweight = (90 - absangleclamp180(abs(yaw - 90))) / 90;
    result[#"front"] = 0;
    result[#"right"] = 0;
    result[#"back"] = 0;
    result[#"left"] = 0;
    if (isdefined(self.alwaysrunforward)) {
        assert(self.alwaysrunforward);
        result[#"front"] = 1;
        return result;
    }
    useleans = getdvarint(#"ai_useleanrunanimations", 0);
    if (forwardweight > 0) {
        result[#"front"] = forwardweight;
        if (leftweight > 0) {
            result[#"left"] = leftweight;
        } else {
            result[#"right"] = -1 * leftweight;
        }
    } else if (useleans) {
        result[#"back"] = -1 * forwardweight;
        if (leftweight > 0) {
            result[#"left"] = leftweight;
        } else {
            result[#"right"] = -1 * leftweight;
        }
    } else {
        backweight = -1 * forwardweight;
        if (leftweight > backweight) {
            result[#"left"] = 1;
        } else if (leftweight < forwardweight) {
            result[#"right"] = 1;
        } else {
            result[#"back"] = 1;
        }
    }
    return result;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x35fa072b, Offset: 0x1c58
// Size: 0xa2
function getquadrant(angle) {
    angle = angleclamp(angle);
    if (angle < 45 || angle > 315) {
        quadrant = "front";
    } else if (angle < 135) {
        quadrant = "left";
    } else if (angle < 225) {
        quadrant = "back";
    } else {
        quadrant = "right";
    }
    return quadrant;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xaef294ef, Offset: 0x1d08
// Size: 0x56
function isinset(input, set) {
    for (i = set.size - 1; i >= 0; i--) {
        if (input == set[i]) {
            return true;
        }
    }
    return false;
}

// Namespace zombie_utility/zombie_utility
// Params 3, eflags: 0x0
// Checksum 0xd03094ca, Offset: 0x1d68
// Size: 0x3e
function notifyaftertime(notifystring, killmestring, time) {
    self endon(#"death", killmestring);
    wait time;
    self notify(notifystring);
}

/#

    // Namespace zombie_utility/zombie_utility
    // Params 4, eflags: 0x0
    // Checksum 0xfa590f80, Offset: 0x1db0
    // Size: 0x82
    function drawstringtime(msg, org, color, timer) {
        maxtime = timer * 20;
        for (i = 0; i < maxtime; i++) {
            print3d(org, msg, color, 1, 1);
            waitframe(1);
        }
    }

    // Namespace zombie_utility/zombie_utility
    // Params 1, eflags: 0x0
    // Checksum 0x2fe89e55, Offset: 0x1e40
    // Size: 0x110
    function showlastenemysightpos(string) {
        self notify(#"got known enemy2");
        self endon(#"got known enemy2", #"death");
        if (!isvalidenemy(self.enemy)) {
            return;
        }
        if (self.enemy.team == #"allies") {
            color = (0.4, 0.7, 1);
        } else {
            color = (1, 0.7, 0.4);
        }
        while (true) {
            waitframe(1);
            if (!isdefined(self.lastenemysightpos)) {
                continue;
            }
            print3d(self.lastenemysightpos, string, color, 1, 2.15);
        }
    }

#/

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xda7f67a6, Offset: 0x1f58
// Size: 0x1e
function debugtimeout() {
    wait 5;
    self notify(#"timeout");
}

// Namespace zombie_utility/zombie_utility
// Params 3, eflags: 0x0
// Checksum 0x224380b6, Offset: 0x1f80
// Size: 0x138
function debugposinternal(org, string, size) {
    /#
        self endon(#"death");
        self notify("<dev string:x93>" + org);
        self endon("<dev string:x93>" + org);
        ent = spawnstruct();
        ent thread debugtimeout();
        ent endon(#"timeout");
        if (self.enemy.team == #"allies") {
            color = (0.4, 0.7, 1);
        } else {
            color = (1, 0.7, 0.4);
        }
        while (true) {
            waitframe(1);
            print3d(org, string, color, 1, size);
        }
    #/
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x883b6d39, Offset: 0x20c0
// Size: 0x34
function debugpos(org, string) {
    thread debugposinternal(org, string, 2.15);
}

// Namespace zombie_utility/zombie_utility
// Params 3, eflags: 0x0
// Checksum 0x8e3bb5d9, Offset: 0x2100
// Size: 0x34
function debugpossize(org, string, size) {
    thread debugposinternal(org, string, size);
}

// Namespace zombie_utility/zombie_utility
// Params 4, eflags: 0x0
// Checksum 0xbc68891b, Offset: 0x2140
// Size: 0x96
function showdebugproc(frompoint, topoint, color, printtime) {
    /#
        self endon(#"death");
        timer = printtime * 20;
        for (i = 0; i < timer; i += 1) {
            waitframe(1);
            line(frompoint, topoint, color);
        }
    #/
}

// Namespace zombie_utility/zombie_utility
// Params 4, eflags: 0x0
// Checksum 0xe303e2b6, Offset: 0x21e0
// Size: 0x54
function showdebugline(frompoint, topoint, color, printtime) {
    self thread showdebugproc(frompoint, topoint + (0, 0, -5), color, printtime);
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xc1dd9de4, Offset: 0x2240
// Size: 0x32e
function getnodeoffset(node) {
    if (isdefined(node.offset)) {
        return node.offset;
    }
    cover_left_crouch_offset = (-26, 0.4, 36);
    cover_left_stand_offset = (-32, 7, 63);
    cover_right_crouch_offset = (43.5, 11, 36);
    cover_right_stand_offset = (36, 8.3, 63);
    cover_crouch_offset = (3.5, -12.5, 45);
    cover_stand_offset = (-3.7, -22, 63);
    cornernode = 0;
    nodeoffset = (0, 0, 0);
    right = anglestoright(node.angles);
    forward = anglestoforward(node.angles);
    switch (node.type) {
    case #"hash_4767a02d3b3b87cc":
    case #"cover left":
        if (node isnodedontstand() && !node isnodedontcrouch()) {
            nodeoffset = calculatenodeoffset(right, forward, cover_left_crouch_offset);
        } else {
            nodeoffset = calculatenodeoffset(right, forward, cover_left_stand_offset);
        }
        break;
    case #"cover right":
    case #"hash_3aeea178f890eb31":
        if (node isnodedontstand() && !node isnodedontcrouch()) {
            nodeoffset = calculatenodeoffset(right, forward, cover_right_crouch_offset);
        } else {
            nodeoffset = calculatenodeoffset(right, forward, cover_right_stand_offset);
        }
        break;
    case #"conceal stand":
    case #"turret":
    case #"cover stand":
        nodeoffset = calculatenodeoffset(right, forward, cover_stand_offset);
        break;
    case #"conceal crouch":
    case #"cover crouch window":
    case #"cover crouch":
        nodeoffset = calculatenodeoffset(right, forward, cover_crouch_offset);
        break;
    }
    node.offset = nodeoffset;
    return node.offset;
}

// Namespace zombie_utility/zombie_utility
// Params 3, eflags: 0x0
// Checksum 0xf79e4d3, Offset: 0x2578
// Size: 0x48
function calculatenodeoffset(right, forward, baseoffset) {
    return vectorscale(right, baseoffset[0]) + vectorscale(forward, baseoffset[1]) + (0, 0, baseoffset[2]);
}

/#

    // Namespace zombie_utility/zombie_utility
    // Params 3, eflags: 0x0
    // Checksum 0x6d136067, Offset: 0x25c8
    // Size: 0x6e
    function showlines(start, end, end2) {
        for (;;) {
            line(start, end, (1, 0, 0), 1);
            waitframe(1);
            line(start, end2, (0, 0, 1), 1);
            waitframe(1);
        }
    }

#/

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xd38040a2, Offset: 0x2640
// Size: 0x148
function anim_array(animarray, animweights) {
    total_anims = animarray.size;
    idleanim = randomint(total_anims);
    assert(total_anims);
    assert(animarray.size == animweights.size);
    if (total_anims == 1) {
        return animarray[0];
    }
    weights = 0;
    total_weight = 0;
    for (i = 0; i < total_anims; i++) {
        total_weight += animweights[i];
    }
    anim_play = randomfloat(total_weight);
    current_weight = 0;
    for (i = 0; i < total_anims; i++) {
        current_weight += animweights[i];
        if (anim_play >= current_weight) {
            continue;
        }
        idleanim = i;
        break;
    }
    return animarray[idleanim];
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x897e51e9, Offset: 0x2790
// Size: 0x3a
function notforcedcover() {
    return self.a.forced_cover == "none" || self.a.forced_cover == "Show";
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x799e737b, Offset: 0x27d8
// Size: 0x36
function forcedcover(msg) {
    return isdefined(self.a.forced_cover) && self.a.forced_cover == msg;
}

/#

    // Namespace zombie_utility/zombie_utility
    // Params 6, eflags: 0x0
    // Checksum 0xa81e2918, Offset: 0x2818
    // Size: 0x92
    function print3dtime(timer, org, msg, color, alpha, scale) {
        newtime = timer / 0.05;
        for (i = 0; i < newtime; i++) {
            print3d(org, msg, color, alpha, scale);
            waitframe(1);
        }
    }

    // Namespace zombie_utility/zombie_utility
    // Params 5, eflags: 0x0
    // Checksum 0x744a6786, Offset: 0x28b8
    // Size: 0xba
    function print3drise(org, msg, color, alpha, scale) {
        newtime = 100;
        up = 0;
        org = org;
        for (i = 0; i < newtime; i++) {
            up += 0.5;
            print3d(org + (0, 0, up), msg, color, alpha, scale);
            waitframe(1);
        }
    }

#/

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x1736bfa9, Offset: 0x2980
// Size: 0xda
function random_weight(array) {
    idleanim = randomint(array.size);
    if (array.size > 1) {
        anim_weight = 0;
        for (i = 0; i < array.size; i++) {
            anim_weight += array[i];
        }
        anim_play = randomfloat(anim_weight);
        anim_weight = 0;
        for (i = 0; i < array.size; i++) {
            anim_weight += array[i];
            if (anim_play < anim_weight) {
                idleanim = i;
                break;
            }
        }
    }
    return idleanim;
}

/#

    // Namespace zombie_utility/zombie_utility
    // Params 2, eflags: 0x0
    // Checksum 0xc19b2ed8, Offset: 0x2a68
    // Size: 0x86
    function persistentdebugline(start, end) {
        self endon(#"death");
        level notify(#"newdebugline");
        level endon(#"newdebugline");
        for (;;) {
            line(start, end, (0.3, 1, 0), 1);
            waitframe(1);
        }
    }

#/

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xbf0457d8, Offset: 0x2af8
// Size: 0x16
function isnodedontstand() {
    return (self.spawnflags & 4) == 4;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x7b7115b5, Offset: 0x2b18
// Size: 0x16
function isnodedontcrouch() {
    return (self.spawnflags & 8) == 8;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x52bcd695, Offset: 0x2b38
// Size: 0xb8
function animarray(animname) {
    assert(isdefined(self.a.array));
    /#
        if (!isdefined(self.a.array[animname])) {
            dumpanimarray();
            assert(isdefined(self.a.array[animname]), "<dev string:xa2>" + animname + "<dev string:xb5>");
        }
    #/
    return self.a.array[animname];
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x87e0cdaf, Offset: 0x2bf8
// Size: 0xbe
function animarrayanyexist(animname) {
    assert(isdefined(self.a.array));
    /#
        if (!isdefined(self.a.array[animname])) {
            dumpanimarray();
            assert(isdefined(self.a.array[animname]), "<dev string:xa2>" + animname + "<dev string:xb5>");
        }
    #/
    return self.a.array[animname].size > 0;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x6b9d85bd, Offset: 0x2cc0
// Size: 0x146
function animarraypickrandom(animname) {
    assert(isdefined(self.a.array));
    /#
        if (!isdefined(self.a.array[animname])) {
            dumpanimarray();
            assert(isdefined(self.a.array[animname]), "<dev string:xa2>" + animname + "<dev string:xb5>");
        }
    #/
    assert(self.a.array[animname].size > 0);
    if (self.a.array[animname].size > 1) {
        index = randomint(self.a.array[animname].size);
    } else {
        index = 0;
    }
    return self.a.array[animname][index];
}

/#

    // Namespace zombie_utility/zombie_utility
    // Params 0, eflags: 0x0
    // Checksum 0x7829c4c4, Offset: 0x2e10
    // Size: 0x118
    function dumpanimarray() {
        println("<dev string:xc9>");
        foreach (k, v in self.a.array) {
            if (isarray(v)) {
                println("<dev string:xda>" + k + "<dev string:xe7>" + v.size + "<dev string:x100>");
                continue;
            }
            println("<dev string:xda>" + k + "<dev string:x105>", v);
        }
    }

#/

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xf2a120cc, Offset: 0x2f30
// Size: 0x4a
function getanimendpos(theanim) {
    movedelta = getmovedelta(theanim, 0, 1);
    return self localtoworldcoords(movedelta);
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x47ed67f3, Offset: 0x2f88
// Size: 0x1c
function isvalidenemy(enemy) {
    if (!isdefined(enemy)) {
        return false;
    }
    return true;
}

// Namespace zombie_utility/zombie_utility
// Params 12, eflags: 0x0
// Checksum 0xf5d56217, Offset: 0x2fb0
// Size: 0x21e
function damagelocationisany(a, b, c, d, e, f, g, h, i, j, k, ovr) {
    if (!isdefined(self.damagelocation)) {
        return false;
    }
    if (!isdefined(a)) {
        return false;
    }
    if (self.damagelocation == a) {
        return true;
    }
    if (!isdefined(b)) {
        return false;
    }
    if (self.damagelocation == b) {
        return true;
    }
    if (!isdefined(c)) {
        return false;
    }
    if (self.damagelocation == c) {
        return true;
    }
    if (!isdefined(d)) {
        return false;
    }
    if (self.damagelocation == d) {
        return true;
    }
    if (!isdefined(e)) {
        return false;
    }
    if (self.damagelocation == e) {
        return true;
    }
    if (!isdefined(f)) {
        return false;
    }
    if (self.damagelocation == f) {
        return true;
    }
    if (!isdefined(g)) {
        return false;
    }
    if (self.damagelocation == g) {
        return true;
    }
    if (!isdefined(h)) {
        return false;
    }
    if (self.damagelocation == h) {
        return true;
    }
    if (!isdefined(i)) {
        return false;
    }
    if (self.damagelocation == i) {
        return true;
    }
    if (!isdefined(j)) {
        return false;
    }
    if (self.damagelocation == j) {
        return true;
    }
    if (!isdefined(k)) {
        return false;
    }
    if (self.damagelocation == k) {
        return true;
    }
    assert(!isdefined(ovr));
    return false;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x4937b1a5, Offset: 0x31d8
// Size: 0xe4
function set_orient_mode(mode, val1) {
    /#
        if (level.dog_debug_orient == self getentnum()) {
            if (isdefined(val1)) {
                println("<dev string:x10f>" + mode + "<dev string:x8e>" + val1 + "<dev string:x8e>" + gettime());
            } else {
                println("<dev string:x10f>" + mode + "<dev string:x8e>" + gettime());
            }
        }
    #/
    if (isdefined(val1)) {
        self orientmode(mode, val1);
        return;
    }
    self orientmode(mode);
}

/#

    // Namespace zombie_utility/zombie_utility
    // Params 1, eflags: 0x0
    // Checksum 0x6555b4b2, Offset: 0x32c8
    // Size: 0xac
    function debug_anim_print(text) {
        if (isdefined(level.dog_debug_anims) && level.dog_debug_anims) {
            println(text + "<dev string:x8e>" + gettime());
        }
        if (isdefined(level.dog_debug_anims_ent) && level.dog_debug_anims_ent == self getentnum()) {
            println(text + "<dev string:x8e>" + gettime());
        }
    }

    // Namespace zombie_utility/zombie_utility
    // Params 2, eflags: 0x0
    // Checksum 0x294ab88b, Offset: 0x3380
    // Size: 0x17c
    function debug_turn_print(text, *line) {
        if (isdefined(level.dog_debug_turns) && level.dog_debug_turns == self getentnum()) {
            duration = 200;
            currentyawcolor = (1, 1, 1);
            lookaheadyawcolor = (1, 0, 0);
            desiredyawcolor = (1, 1, 0);
            currentyaw = angleclamp180(self.angles[1]);
            desiredyaw = angleclamp180(self.desiredangle);
            lookaheaddir = self.lookaheaddir;
            lookaheadangles = vectortoangles(lookaheaddir);
            lookaheadyaw = angleclamp180(lookaheadangles[1]);
            println(line + "<dev string:x8e>" + gettime() + "<dev string:x12e>" + currentyaw + "<dev string:x138>" + lookaheadyaw + "<dev string:x143>" + desiredyaw);
        }
    }

#/

// Namespace zombie_utility/zombie_utility
// Params 4, eflags: 0x0
// Checksum 0x943a361a, Offset: 0x3508
// Size: 0x128
function set_zombie_var(zvar, value, defaultvalue, is_team_based = 0) {
    if (!isdefined(level.zombie_vars)) {
        level.zombie_vars = [];
    }
    if (!isdefined(value)) {
        value = defaultvalue;
    }
    if (is_team_based) {
        foreach (team, _ in level.teams) {
            if (!isdefined(level.zombie_vars[team])) {
                level.zombie_vars[team] = [];
            }
            level.zombie_vars[team][zvar] = value;
        }
    } else {
        level.zombie_vars[zvar] = value;
    }
    return value;
}

// Namespace zombie_utility/zombie_utility
// Params 3, eflags: 0x0
// Checksum 0x4c940d10, Offset: 0x3638
// Size: 0x7a
function set_zombie_var_team(zvar, team, value) {
    if (!isdefined(level.zombie_vars)) {
        level.zombie_vars = [];
    }
    if (!isdefined(level.zombie_vars[team])) {
        level.zombie_vars[team] = [];
    }
    level.zombie_vars[team][zvar] = value;
    return value;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x20281e44, Offset: 0x36c0
// Size: 0x38
function get_zombie_var(zvar) {
    if (!isdefined(level.zombie_vars)) {
        level.zombie_vars = [];
    }
    return level.zombie_vars[zvar];
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x44b08a79, Offset: 0x3700
// Size: 0x3c
function get_zombie_var_team(zvar, team) {
    if (isdefined(level.zombie_vars[team])) {
        return level.zombie_vars[team][zvar];
    }
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x8a7e90a1, Offset: 0x3748
// Size: 0x68
function set_zombie_var_player(zvar, value) {
    assert(isplayer(self), "<dev string:x151>");
    if (!isdefined(self.zombie_vars)) {
        self.zombie_vars = [];
    }
    self.zombie_vars[zvar] = value;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xc0d7897f, Offset: 0x37b8
// Size: 0x60
function get_zombie_var_player(zvar) {
    assert(isplayer(self), "<dev string:x186>");
    if (!isdefined(self.zombie_vars)) {
        self.zombie_vars = [];
    }
    return self.zombie_vars[zvar];
}

// Namespace zombie_utility/zombie_utility
// Params 4, eflags: 0x0
// Checksum 0x5a377aa8, Offset: 0x3820
// Size: 0x2f2
function spawn_zombie(spawner, target_name, spawn_point, round_number) {
    if (!isdefined(spawner)) {
        println("<dev string:x1bb>");
        return undefined;
    }
    while (getfreeactorcount() < 1) {
        waitframe(1);
    }
    spawner.script_moveoverride = 1;
    if (is_true(spawner.script_forcespawn)) {
        if (isactorspawner(spawner) && isdefined(level.overridezombiespawn)) {
            guy = [[ level.overridezombiespawn ]](spawner, target_name, spawn_point, round_number);
        } else {
            guy = spawner spawnfromspawner(0, 1);
        }
        if (!zombie_spawn_failed(guy)) {
            if (isdefined(level.giveextrazombies)) {
                guy [[ level.giveextrazombies ]]();
            }
            guy enableaimassist();
            if (isdefined(round_number)) {
                guy._starting_round_number = round_number;
            }
            if (isdefined(level.zombie_team)) {
                guy.team = level.zombie_team;
            }
            if (isactor(guy)) {
                guy clearentityowner();
            }
            level.zombiemeleeplayercounter = 0;
            if (isactor(guy)) {
                guy forceteleport(spawner.origin);
            }
            guy show();
            spawner.count = 666;
            if (isdefined(target_name)) {
                guy.targetname = target_name;
            }
            if (isdefined(spawn_point) && isdefined(level.move_spawn_func)) {
                guy thread [[ level.move_spawn_func ]](spawn_point);
            }
            /#
                if (isdefined(spawner.zm_variant_type)) {
                    guy.variant_type = spawner.zm_variant_type;
                }
            #/
            return guy;
        } else {
            println("<dev string:x1e6>", spawner.origin);
            return undefined;
        }
    } else {
        println("<dev string:x228>", spawner.origin);
        return undefined;
    }
    return undefined;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x8f2a9f35, Offset: 0x3b20
// Size: 0x4e
function zombie_spawn_failed(spawn) {
    if (isdefined(spawn) && isalive(spawn)) {
        if (isalive(spawn)) {
            return false;
        }
    }
    return true;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x5b7e7d61, Offset: 0x3b78
// Size: 0xda
function get_desired_origin() {
    if (isdefined(self.target)) {
        ent = getent(self.target, "targetname");
        if (!isdefined(ent)) {
            ent = struct::get(self.target, "targetname");
        }
        if (!isdefined(ent)) {
            ent = getnode(self.target, "targetname");
        }
        assert(isdefined(ent), "<dev string:x266>" + self.target + "<dev string:x295>" + self.origin);
        return ent.origin;
    }
    return undefined;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xf495249c, Offset: 0x3c60
// Size: 0x7a
function hide_pop() {
    self endon(#"death");
    self ghost();
    wait 0.5;
    if (isdefined(self)) {
        self show();
        util::wait_network_frame();
        if (isdefined(self)) {
            self.create_eyes = 1;
        }
    }
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x6a072660, Offset: 0x3ce8
// Size: 0x2c
function handle_rise_notetracks(note, spot) {
    self thread finish_rise_notetracks(note, spot);
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x574a09fe, Offset: 0x3d20
// Size: 0x70
function finish_rise_notetracks(note, spot) {
    if (note == "deathout" || note == "deathhigh") {
        self.zombie_rise_death_out = 1;
        self notify(#"zombie_rise_death_out");
        wait 2;
        spot notify(#"stop_zombie_rise_fx");
    }
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x54c82ee5, Offset: 0x3d98
// Size: 0xdc
function zombie_rise_death(zombie, spot) {
    zombie.zombie_rise_death_out = 0;
    zombie endon(#"rise_anim_finished", #"death");
    while (isdefined(zombie) && isdefined(zombie.health) && zombie.health > 1) {
        zombie waittill(#"damage");
    }
    if (isdefined(spot)) {
        spot notify(#"stop_zombie_rise_fx");
    }
    if (isdefined(zombie)) {
        zombie.deathanim = zombie get_rise_death_anim();
        zombie stopanimscripted();
    }
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x7e3ac3cd, Offset: 0x3e80
// Size: 0x3a
function get_rise_death_anim() {
    if (self.zombie_rise_death_out) {
        return "zm_rise_death_out";
    }
    self.noragdoll = 1;
    self.nodeathragdoll = 1;
    return "zm_rise_death_in";
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x3552f734, Offset: 0x3ec8
// Size: 0x7a
function reset_attack_spot() {
    if (isdefined(self.601)) {
        node = self.601;
        index = self.attacking_spot_index;
        node.attack_spots_taken[index] = 0;
        node notify(#"hash_45aa77702fef26f4");
    }
    self.601 = undefined;
    self.attacking_spot_index = undefined;
    self.attacking_spot = undefined;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x13e7d268, Offset: 0x3f50
// Size: 0x4c
function zombie_gut_explosion() {
    self.guts_explosion = 1;
    self playsound(#"zmb_zombie_head_gib");
    gibserverutils::annihilate(self);
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x3b01c318, Offset: 0x3fa8
// Size: 0x12a
function round_spawn_failsafe_debug_draw() {
    self notify("7a43702ee566cd8");
    self endon("7a43702ee566cd8");
    self endon(#"death");
    for (prevorigin = self.origin; true; prevorigin = self.origin) {
        if (is_true(level.toggle_keyline_always)) {
            self clientfield::set("zombie_keyline_render", 1);
            wait 1;
            continue;
        }
        wait 4;
        if (isdefined(self.lastchunk_destroy_time)) {
            if (gettime() - self.lastchunk_destroy_time < 8000) {
                continue;
            }
        }
        if (distancesquared(self.origin, prevorigin) < 576) {
            self clientfield::set("zombie_keyline_render", 1);
            continue;
        }
        self clientfield::set("zombie_keyline_render", 0);
    }
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x2329ac64, Offset: 0x40e0
// Size: 0x4be
function round_spawn_failsafe() {
    self notify("79f4c7cce4a2f648");
    self endon("79f4c7cce4a2f648");
    self endon(#"death");
    if (is_true(level.debug_keyline_zombies)) {
        self thread round_spawn_failsafe_debug_draw();
    }
    for (v_prev_origin = self.origin; true; v_prev_origin = self.origin) {
        if (!get_zombie_var(#"zombie_use_failsafe")) {
            return;
        }
        if (is_true(self.ignore_round_spawn_failsafe)) {
            return;
        }
        if (!isdefined(level.failsafe_waittime)) {
            level.failsafe_waittime = 30;
        }
        wait level.failsafe_waittime;
        if (is_true(self.missinglegs)) {
            wait 10;
        }
        if (is_true(self.is_inert)) {
            continue;
        }
        if (isdefined(self.lastchunk_destroy_time) && gettime() - self.lastchunk_destroy_time < 8000) {
            continue;
        }
        if (self.origin[2] < get_zombie_var(#"below_world_check")) {
            if (isdefined(level.var_455393ef)) {
                self thread [[ level.var_455393ef ]](v_prev_origin);
            } else {
                if (is_true(level.put_timed_out_zombies_back_in_queue) && !is_true(self.isscreecher)) {
                    level.zombie_total++;
                    level.zombie_total_subtract++;
                }
                self.var_e700d5e2 = 1;
                self dodamage(self.health + 100, (0, 0, 0));
            }
            break;
        }
        var_25e376fd = 0;
        if (isdefined(level.var_62fc4786)) {
            var_25e376fd = self [[ level.var_62fc4786 ]](v_prev_origin);
        } else if (distancesquared(self.origin, v_prev_origin) < 576) {
            var_25e376fd = 1;
        }
        if (var_25e376fd) {
            if (isdefined(level.var_455393ef)) {
                self thread [[ level.var_455393ef ]](v_prev_origin);
            } else {
                if (is_true(level.put_timed_out_zombies_back_in_queue)) {
                    if (!is_true(self.nuked) && !is_true(self.marked_for_death) && !is_true(self.isscreecher) && !is_true(self.missinglegs)) {
                        level.zombie_total++;
                        level.zombie_total_subtract++;
                        var_1a8c05ae = {#n_health:self.health, #var_e0d660f6:self.var_e0d660f6};
                        if (!isdefined(level.var_fc73bad4[self.archetype])) {
                            level.var_fc73bad4[self.archetype] = [];
                        } else if (!isarray(level.var_fc73bad4[self.archetype])) {
                            level.var_fc73bad4[self.archetype] = array(level.var_fc73bad4[self.archetype]);
                        }
                        level.var_fc73bad4[self.archetype][level.var_fc73bad4[self.archetype].size] = var_1a8c05ae;
                    }
                }
                level.zombies_timeout_playspace++;
                self.var_e700d5e2 = 1;
                self dodamage(self.health + 100, (0, 0, 0));
            }
            break;
        }
    }
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xd75ec977, Offset: 0x45a8
// Size: 0x1aa
function ai_calculate_health(base_health, round_number) {
    if (isdefined(level.var_5d1805c4)) {
        var_d082c739 = [[ level.var_5d1805c4 ]](base_health, round_number);
        if (var_d082c739 >= 0) {
            return var_d082c739;
        }
    }
    if (util::get_game_type() == #"zclassic" && level.gamedifficulty < 2 && round_number > 35) {
        round_number = 35;
    }
    var_d082c739 = base_health;
    for (i = 2; i <= round_number; i++) {
        if (i >= 10 && !is_true(level.var_50dd0ec5)) {
            old_health = var_d082c739;
            var_d082c739 += int(var_d082c739 * get_zombie_var(#"zombie_health_increase_multiplier"));
            if (var_d082c739 < old_health) {
                var_d082c739 = old_health;
                break;
            }
            continue;
        }
        var_d082c739 = int(var_d082c739 + get_zombie_var(#"zombie_health_increase"));
    }
    return var_d082c739;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xb2dbb375, Offset: 0x4760
// Size: 0x25e
function default_max_zombie_func(max_num, n_round) {
    /#
        count = getdvarint(#"zombie_default_max", -1);
        if (count > -1) {
            return count;
        }
    #/
    n_players = getplayers().size;
    var_872cd28a = array(6, 7, 11, 14, 17);
    var_753ada67 = array(8, 9, 12, 18, 21);
    var_41446be2 = array(13, 15, 18, 25, 31);
    var_68849261 = array(18, 21, 25, 33, 40);
    var_979708f = array(24, 27, 32, 42, 48);
    switch (n_round) {
    case 1:
        max = var_872cd28a[n_players - 1];
        break;
    case 2:
        max = var_753ada67[n_players - 1];
        break;
    case 3:
        max = var_41446be2[n_players - 1];
        break;
    case 4:
        max = var_68849261[n_players - 1];
        break;
    case 5:
        max = var_979708f[n_players - 1];
        break;
    default:
        max = max_num;
        break;
    }
    return max;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xa8860e36, Offset: 0x49c8
// Size: 0x24
function get_current_zombie_count() {
    enemies = get_round_enemy_array();
    return enemies.size;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xd04092ea, Offset: 0x49f8
// Size: 0xdc
function get_round_enemy_array() {
    a_ai_enemies = [];
    a_ai_valid_enemies = [];
    a_ai_enemies = getaiteamarray(level.zombie_team);
    for (i = 0; i < a_ai_enemies.size; i++) {
        if (is_true(a_ai_enemies[i].ignore_enemy_count)) {
            continue;
        }
        if (!isdefined(a_ai_valid_enemies)) {
            a_ai_valid_enemies = [];
        } else if (!isarray(a_ai_valid_enemies)) {
            a_ai_valid_enemies = array(a_ai_valid_enemies);
        }
        a_ai_valid_enemies[a_ai_valid_enemies.size] = a_ai_enemies[i];
    }
    return a_ai_valid_enemies;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xea3d26db, Offset: 0x4ae0
// Size: 0x3a
function get_zombie_array() {
    valid_enemies = getaiarchetypearray(#"zombie", level.zombie_team);
    return valid_enemies;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xb1b64c4e, Offset: 0x4b28
// Size: 0x32
function set_zombie_run_cycle_override_value(new_move_speed) {
    set_zombie_run_cycle(new_move_speed);
    self.zombie_move_speed_override = new_move_speed;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xe7112b97, Offset: 0x4b68
// Size: 0x34
function set_zombie_run_cycle_restore_from_override() {
    str_restore_move_speed = self.zombie_move_speed_restore;
    self.zombie_move_speed_override = undefined;
    set_zombie_run_cycle(str_restore_move_speed);
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xdb2b1472, Offset: 0x4ba8
// Size: 0x1e4
function function_d2f660ce(var_a598c292) {
    if (is_true(self.var_b518759e)) {
        return var_a598c292;
    }
    if (isdefined(level.var_43fb4347)) {
        switch (level.var_43fb4347) {
        case #"run":
            if (var_a598c292 == "walk") {
                var_70b46d1c = "run";
            }
            break;
        case #"sprint":
            if (var_a598c292 == "walk" || var_a598c292 == "run") {
                var_70b46d1c = "sprint";
            }
            break;
        case #"super_sprint":
            if (var_a598c292 != "super_sprint") {
                var_70b46d1c = "super_sprint";
            }
            break;
        }
    }
    if (isdefined(level.var_102b1301)) {
        switch (level.var_102b1301) {
        case #"walk":
            if (var_a598c292 != "walk") {
                var_70b46d1c = "walk";
            }
            break;
        case #"run":
            if (var_a598c292 == "sprint" || var_a598c292 == "super_sprint") {
                var_70b46d1c = "run";
            }
            break;
        case #"sprint":
            if (var_a598c292 == "super_sprint") {
                var_70b46d1c = "sprint";
            }
            break;
        }
    }
    if (isdefined(var_70b46d1c)) {
        return var_70b46d1c;
    }
    return var_a598c292;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xbe62b163, Offset: 0x4d98
// Size: 0x304
function set_zombie_run_cycle(new_move_speed) {
    if (isdefined(level.var_deb2145c)) {
        self [[ level.var_deb2145c ]]();
        return;
    }
    if (isdefined(self.zombie_move_speed_override)) {
        if (!isdefined(new_move_speed)) {
            new_move_speed = function_33da7a07();
        }
        new_move_speed = self function_d2f660ce(new_move_speed);
        self.zombie_move_speed_restore = new_move_speed;
        return;
    }
    if (isdefined(new_move_speed)) {
        self.zombie_move_speed = new_move_speed;
    } else if (level.gamedifficulty === 0) {
        self.zombie_move_speed = function_33da7a07(1);
    } else {
        self.zombie_move_speed = function_33da7a07();
    }
    self.zombie_move_speed = self function_d2f660ce(self.zombie_move_speed);
    if (isdefined(level.zm_variant_type_max)) {
        /#
            if (false) {
                debug_variant_type = getdvarint(#"scr_zombie_variant_type", -1);
                if (debug_variant_type != -1) {
                    if (debug_variant_type <= level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]) {
                        self.variant_type = debug_variant_type;
                    } else {
                        self.variant_type = level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position] - 1;
                    }
                } else {
                    self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
                }
            }
        #/
        if (self.archetype === #"zombie" || self.archetype === #"catalyst") {
            if (isdefined(self.zm_variant_type_max)) {
                self.variant_type = randomint(self.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
            } else {
                self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
            }
        }
    }
    self.needs_run_update = 1;
    self notify(#"needs_run_update");
    self.deathanim = self append_missing_legs_suffix("zm_death");
    self callback::callback(#"hash_dfbeaa068b23e7c");
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x428b0fb0, Offset: 0x50a8
// Size: 0xca
function function_33da7a07(is_easy) {
    if (!isdefined(self._starting_round_number)) {
        self._starting_round_number = level.round_number;
    }
    if (self._starting_round_number == 1) {
        n_move_speed = 1;
    } else {
        n_move_speed = int(self._starting_round_number * get_zombie_var(#"zombie_move_speed_multiplier"));
    }
    var_750836cc = randomintrange(n_move_speed, n_move_speed + 35);
    return function_f9c50a93(var_750836cc, is_easy);
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x297a76ac, Offset: 0x5180
// Size: 0xac
function function_f9c50a93(move_speed, is_easy) {
    if (is_true(is_easy)) {
        if (move_speed <= 35) {
            return "walk";
        } else {
            return "run";
        }
    }
    if (move_speed <= 35) {
        return "walk";
    }
    if (move_speed <= 70) {
        return "run";
    }
    if (move_speed <= 236) {
        return "sprint";
    }
    return "super_sprint";
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xa71ec3f2, Offset: 0x5238
// Size: 0x342
function setup_zombie_knockdown(var_5f02306b, var_43b3242) {
    if (!isactor(self) || is_true(self.missinglegs) || is_true(self.var_5dd07a80) || is_true(self.isinmantleaction) || self isplayinganimscripted() || self function_dd070839() && !is_true(var_43b3242)) {
        return;
    }
    if (!isdefined(var_5f02306b)) {
        return;
    }
    self.knockdown = 1;
    if (isvec(var_5f02306b)) {
        zombie_to_entity = var_5f02306b - self.origin;
    } else {
        zombie_to_entity = var_5f02306b.origin - self.origin;
    }
    zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
    zombie_forward = anglestoforward(self.angles);
    zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
    zombie_right = anglestoright(self.angles);
    zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
    dot = vectordot(zombie_to_entity_2d, zombie_forward_2d);
    if (dot >= 0.5) {
        self.knockdown_direction = "front";
        self.getup_direction = "getup_back";
        return;
    }
    if (dot < 0.5 && dot > -0.5) {
        dot = vectordot(zombie_to_entity_2d, zombie_right_2d);
        if (dot > 0) {
            self.knockdown_direction = "right";
            if (math::cointoss()) {
                self.getup_direction = "getup_back";
            } else {
                self.getup_direction = "getup_belly";
            }
        } else {
            self.knockdown_direction = "left";
            self.getup_direction = "getup_belly";
        }
        return;
    }
    self.knockdown_direction = "back";
    self.getup_direction = "getup_belly";
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x86e37426, Offset: 0x5588
// Size: 0x102
function function_fc0cb93d(entity) {
    self.pushed = 1;
    zombie_to_entity = entity.origin - self.origin;
    zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
    zombie_right = anglestoright(self.angles);
    zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
    dot = vectordot(zombie_to_entity_2d, zombie_right_2d);
    if (dot < 0) {
        self.push_direction = "right";
        return;
    }
    self.push_direction = "left";
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x9d21d2c9, Offset: 0x5698
// Size: 0x7c
function clear_all_corpses() {
    level notify(#"clear_all_corpses");
    corpse_array = getcorpsearray();
    for (i = 0; i < corpse_array.size; i++) {
        if (isdefined(corpse_array[i])) {
            corpse_array[i] delete();
        }
    }
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x1e80d16a, Offset: 0x5720
// Size: 0x74
function get_current_actor_count() {
    count = 0;
    actors = getaispeciesarray(level.zombie_team, "all");
    if (isdefined(actors)) {
        count += actors.size;
    }
    count += get_current_corpse_count();
    return count;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x887c8f92, Offset: 0x57a0
// Size: 0x30
function get_current_corpse_count() {
    corpse_array = getcorpsearray();
    if (isdefined(corpse_array)) {
        return corpse_array.size;
    }
    return 0;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x607f3714, Offset: 0x57d8
// Size: 0xa8
function zombie_gib_on_damage() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"damage");
        self thread zombie_gib(waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.tag_name, waitresult.model_name, waitresult.part_name, waitresult.weapon);
    }
}

// Namespace zombie_utility/zombie_utility
// Params 9, eflags: 0x0
// Checksum 0x2a9dad7e, Offset: 0x5888
// Size: 0x7e0
function zombie_gib(amount, attacker, *direction_vec, point, type, *tagname, *modelname, *partname, weapon) {
    if (!isdefined(self)) {
        return;
    }
    if (!self zombie_should_gib(type, tagname, partname, weapon)) {
        return;
    }
    if (self head_should_gib(tagname, partname, modelname) && partname != "MOD_BURNED") {
        self zombie_head_gib(tagname, partname);
        return;
    }
    if (!is_true(self.gibbed) && !isdefined(self.damagelocation)) {
        if (type >= self.maxhealth * 0.5 && self.health - type > 0 && (partname != "MOD_GRENADE" || partname != "MOD_GRENADE_SPLASH" || partname != "MOD_PROJECTILE" || partname != "MOD_PROJECTILE_SPLASH")) {
            self derive_damage_refs(modelname, 0);
        }
    }
    if (!is_true(self.gibbed) && isdefined(self.damagelocation)) {
        if (self damagelocationisany("head", "helmet", "neck")) {
            return;
        }
        if (self damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot", "left_leg_upper", "left_leg_lower", "left_foot") && type < self.maxhealth * 0.5 && (partname != "MOD_GRENADE" || partname != "MOD_GRENADE_SPLASH" || partname != "MOD_PROJECTILE" || partname != "MOD_PROJECTILE_SPLASH")) {
            return;
        }
        self.stumble = undefined;
        b_gibbed = 1;
        switch (self.damagelocation) {
        case #"right_arm_lower":
        case #"right_arm_upper":
        case #"right_hand":
            if (!gibserverutils::isgibbed(self, 32)) {
                gibserverutils::gibrightarm(self);
            }
            break;
        case #"left_arm_lower":
        case #"left_arm_upper":
        case #"left_hand":
            if (!gibserverutils::isgibbed(self, 16)) {
                gibserverutils::gibleftarm(self);
            }
            break;
        case #"right_leg_upper":
        case #"right_leg_lower":
        case #"right_foot":
            if (is_true(self.nocrawler) || is_true(level.var_41259f0d) || isdefined(level.var_9b91564e) && (isdefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e) {
                break;
            }
            gibserverutils::gibrightleg(self);
            if (randomint(100) > 75) {
                gibserverutils::gibleftleg(self);
            }
            self function_df5afb5e(1);
            break;
        case #"left_leg_lower":
        case #"left_foot":
        case #"left_leg_upper":
            if (is_true(self.nocrawler) || is_true(level.var_41259f0d) || isdefined(level.var_9b91564e) && (isdefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e) {
                break;
            }
            gibserverutils::gibleftleg(self);
            if (randomint(100) > 75) {
                gibserverutils::gibrightleg(self);
            }
            self function_df5afb5e(1);
            break;
        default:
            if (self.damagelocation == "none") {
                if (partname == "MOD_GRENADE" || partname == "MOD_GRENADE_SPLASH" || partname == "MOD_PROJECTILE" || partname == "MOD_PROJECTILE_SPLASH") {
                    self derive_damage_refs(modelname);
                    break;
                }
            }
            break;
        }
        if (isdefined(level.custom_derive_damage_refs)) {
            self [[ level.custom_derive_damage_refs ]](modelname, weapon);
        }
        if (is_true(self.missinglegs) && self.health > 0) {
            b_gibbed = 1;
            level notify(#"crawler_created", {#zombie:self, #player:tagname, #weapon:weapon});
            self allowedstances("crouch");
            self setphysparams(15, 0, 24);
            self allowpitchangle(1);
            self setpitchorient();
            health = self.health;
            health *= 0.1;
            if (isdefined(self.crawl_anim_override)) {
                self [[ self.crawl_anim_override ]]();
            }
        }
        if (b_gibbed && self.health > 0) {
            if (isdefined(level.gib_on_damage)) {
                self thread [[ level.gib_on_damage ]](tagname);
            }
        }
    }
}

// Namespace zombie_utility/zombie_utility
// Params 3, eflags: 0x0
// Checksum 0x4af01279, Offset: 0x6070
// Size: 0x74
function add_zombie_gib_weapon_callback(weapon_name, gib_callback, gib_head_callback) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    level.zombie_gib_weapons[weapon_name] = gib_callback;
    level.zombie_gib_head_weapons[weapon_name] = gib_head_callback;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xe4c1c75f, Offset: 0x60f0
// Size: 0x86
function have_zombie_weapon_gib_callback(weapon) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    if (isweapon(weapon)) {
        weapon = weapon.name;
    }
    if (isdefined(level.zombie_gib_weapons[weapon])) {
        return true;
    }
    return false;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xae87ff5f, Offset: 0x6180
// Size: 0xa4
function get_zombie_weapon_gib_callback(weapon, damage_percent) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    if (isweapon(weapon)) {
        weapon = weapon.name;
    }
    if (isdefined(level.zombie_gib_weapons[weapon])) {
        return self [[ level.zombie_gib_weapons[weapon] ]](damage_percent);
    }
    return 0;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x48fc47ba, Offset: 0x6230
// Size: 0x86
function have_zombie_weapon_gib_head_callback(weapon) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    if (isweapon(weapon)) {
        weapon = weapon.name;
    }
    if (isdefined(level.zombie_gib_head_weapons[weapon])) {
        return true;
    }
    return false;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x1dd4a61d, Offset: 0x62c0
// Size: 0xa4
function get_zombie_weapon_gib_head_callback(weapon, damage_location) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    if (isweapon(weapon)) {
        weapon = weapon.name;
    }
    if (isdefined(level.zombie_gib_head_weapons[weapon])) {
        return self [[ level.zombie_gib_head_weapons[weapon] ]](damage_location);
    }
    return 0;
}

// Namespace zombie_utility/zombie_utility
// Params 4, eflags: 0x0
// Checksum 0x834bb321, Offset: 0x6370
// Size: 0x298
function zombie_should_gib(amount, attacker, type, weapon) {
    if (!isdefined(type)) {
        return false;
    }
    if (is_true(self.is_on_fire)) {
        return false;
    }
    if (isdefined(self.no_gib) && self.no_gib == 1) {
        return false;
    }
    prev_health = amount + self.health;
    if (prev_health <= 0) {
        prev_health = 1;
    }
    damage_percent = amount / prev_health * 100;
    if (isdefined(attacker)) {
        if (isplayer(attacker) || is_true(attacker.can_gib_zombies)) {
            if (isdefined(weapon) && is_true(weapon.doannihilate)) {
                return false;
            }
            if (have_zombie_weapon_gib_callback(weapon)) {
                if (self get_zombie_weapon_gib_callback(weapon, damage_percent)) {
                    return true;
                }
                return false;
            }
        }
    }
    switch (type) {
    case #"mod_telefrag":
    case #"mod_unknown":
    case #"mod_burned":
    case #"mod_trigger_hurt":
    case #"mod_suicide":
    case #"mod_falling":
        return false;
    case #"mod_melee":
        return false;
    }
    if (type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
        if (!isdefined(attacker) || !isplayer(attacker)) {
            return false;
        }
        if (weapon == level.weaponnone || isdefined(level.start_weapon) && weapon == level.start_weapon || weapon.isgasweapon) {
            return false;
        }
    }
    return true;
}

// Namespace zombie_utility/zombie_utility
// Params 3, eflags: 0x0
// Checksum 0x10393679, Offset: 0x6610
// Size: 0x32e
function head_should_gib(attacker, type, point) {
    if (is_true(self.head_gibbed)) {
        return false;
    }
    if (!isdefined(attacker) || !isplayer(attacker)) {
        if (!is_true(attacker.can_gib_zombies)) {
            return false;
        }
    }
    if (isplayer(attacker)) {
        weapon = attacker getcurrentweapon();
    } else {
        weapon = attacker.weapon;
    }
    if (have_zombie_weapon_gib_head_callback(weapon)) {
        if (self get_zombie_weapon_gib_head_callback(weapon, self.damagelocation)) {
            return true;
        }
        return false;
    }
    if (type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET") {
        if (type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") {
            if (distance(point, self gettagorigin("j_head")) > 55) {
                return false;
            } else {
                return true;
            }
        } else if (type == "MOD_PROJECTILE") {
            if (distance(point, self gettagorigin("j_head")) > 10) {
                return false;
            } else {
                return true;
            }
        } else if (weapon.weapclass != "spread") {
            return false;
        }
    }
    if (!self damagelocationisany("head", "helmet", "neck")) {
        return false;
    }
    if (type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg" || weapon == level.weaponnone || isdefined(level.start_weapon) && weapon == level.start_weapon || weapon.isgasweapon) {
        return false;
    }
    if (sessionmodeiscampaigngame() && type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg") {
        return false;
    }
    low_health_percent = self.health / self.maxhealth * 100;
    if (low_health_percent > 10) {
        return false;
    }
    return true;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xb48a9861, Offset: 0x6948
// Size: 0x114
function zombie_hat_gib(*attacker, *means_of_death) {
    self endon(#"death");
    if (is_true(self.hat_gibbed)) {
        return;
    }
    if (!isdefined(self.gibspawn5) || !isdefined(self.gibspawntag5)) {
        return;
    }
    self.hat_gibbed = 1;
    if (isdefined(self.hatmodel)) {
        self detach(self.hatmodel, "");
    }
    temp_array = [];
    temp_array[0] = level._zombie_gib_piece_index_hat;
    self gib("normal", temp_array);
    if (isdefined(level.track_gibs)) {
        level [[ level.track_gibs ]](self, temp_array);
    }
}

// Namespace zombie_utility/zombie_utility
// Params 4, eflags: 0x0
// Checksum 0x727c41e7, Offset: 0x6a68
// Size: 0x158
function damage_over_time(dmg, delay, attacker, means_of_death) {
    self endon(#"death", #"exploding");
    self endon(#"exploding");
    if (!isalive(self)) {
        return;
    }
    if (!isplayer(attacker)) {
        attacker = self;
    }
    if (!isdefined(means_of_death)) {
        means_of_death = "MOD_UNKNOWN";
    }
    while (true) {
        if (isdefined(delay)) {
            wait delay;
        }
        if (isdefined(self)) {
            var_223fc6f5 = self gettagorigin("j_neck");
            if (!isdefined(var_223fc6f5)) {
                var_223fc6f5 = self.origin;
            }
            if (isdefined(attacker)) {
                self dodamage(dmg, var_223fc6f5, attacker, self, self.damagelocation, means_of_death, 4096, self.damageweapon);
                continue;
            }
            self dodamage(dmg, var_223fc6f5);
        }
    }
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xc12c41b, Offset: 0x6bc8
// Size: 0x49c
function derive_damage_refs(point, var_87a07ff5 = 1) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(point)) {
        return;
    }
    if (!isdefined(level.gib_tags)) {
        init_gib_tags();
    }
    closesttag = "tag_origin";
    closestdistsq = distancesquared(point, self.origin);
    for (i = 0; i < level.gib_tags.size; i++) {
        tagorigin = self gettagorigin(level.gib_tags[i]);
        if (!isdefined(tagorigin)) {
            continue;
        }
        distsq = distancesquared(point, tagorigin);
        if (distsq < closestdistsq) {
            closesttag = level.gib_tags[i];
            closestdistsq = distsq;
        }
    }
    if (closesttag == "J_SpineLower" || closesttag == "J_SpineUpper" || closesttag == "J_Spine4") {
        gibserverutils::gibrightarm(self);
        return;
    }
    if (closesttag == "J_Shoulder_LE" || closesttag == "J_Elbow_LE" || closesttag == "J_Wrist_LE") {
        if (!gibserverutils::isgibbed(self, 16)) {
            gibserverutils::gibleftarm(self);
        }
        return;
    }
    if (closesttag == "J_Shoulder_RI" || closesttag == "J_Elbow_RI" || closesttag == "J_Wrist_RI") {
        if (!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
        }
        return;
    }
    if (closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE") {
        if (is_true(self.nocrawler) || is_true(level.var_41259f0d) || isdefined(level.var_9b91564e) && (isdefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e) {
            return;
        }
        gibserverutils::gibleftleg(self);
        if (var_87a07ff5) {
            if (randomint(100) > 75) {
                gibserverutils::gibrightleg(self);
            }
        }
        self function_df5afb5e(1);
        return;
    }
    if (closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI") {
        if (is_true(self.nocrawler) || is_true(level.var_41259f0d) || isdefined(level.var_9b91564e) && (isdefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e) {
            return;
        }
        gibserverutils::gibrightleg(self);
        if (var_87a07ff5) {
            if (randomint(100) > 75) {
                gibserverutils::gibleftleg(self);
            }
        }
        self function_df5afb5e(1);
    }
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xaf5f5ba9, Offset: 0x7070
// Size: 0x14c
function init_gib_tags() {
    tags = [];
    tags[tags.size] = "J_SpineLower";
    tags[tags.size] = "J_SpineUpper";
    tags[tags.size] = "J_Spine4";
    tags[tags.size] = "J_Shoulder_LE";
    tags[tags.size] = "J_Elbow_LE";
    tags[tags.size] = "J_Wrist_LE";
    tags[tags.size] = "J_Shoulder_RI";
    tags[tags.size] = "J_Elbow_RI";
    tags[tags.size] = "J_Wrist_RI";
    tags[tags.size] = "J_Hip_LE";
    tags[tags.size] = "J_Knee_LE";
    tags[tags.size] = "J_Ankle_LE";
    tags[tags.size] = "J_Hip_RI";
    tags[tags.size] = "J_Knee_RI";
    tags[tags.size] = "J_Ankle_RI";
    level.gib_tags = tags;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xa7f4ff55, Offset: 0x71c8
// Size: 0x9e
function getanimdirection(damageyaw) {
    if (damageyaw > 135 || damageyaw <= -135) {
        return "front";
    } else if (damageyaw > 45 && damageyaw <= 135) {
        return "right";
    } else if (damageyaw > -45 && damageyaw <= 45) {
        return "back";
    } else {
        return "left";
    }
    return "front";
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xefb8e81c, Offset: 0x7270
// Size: 0x200
function makezombiecrawler(b_both_legs) {
    if (is_true(level.var_41259f0d) || !is_true(level.var_6d8a8e47) && isdefined(level.var_9b91564e) && (isdefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e) {
        return;
    }
    if (is_true(b_both_legs)) {
        val = 100;
    } else {
        val = randomint(100);
    }
    if (val > 75) {
        gibserverutils::gibrightleg(self);
        gibserverutils::gibleftleg(self);
    } else if (val > 37) {
        gibserverutils::gibrightleg(self);
    } else {
        gibserverutils::gibleftleg(self);
    }
    self.has_legs = 0;
    self function_df5afb5e(1);
    self allowedstances("crouch");
    self setphysparams(15, 0, 24);
    self allowpitchangle(1);
    self setpitchorient();
    health = self.health;
    health *= 0.1;
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x1de58047, Offset: 0x7478
// Size: 0xc4
function zombie_head_gib(attacker, means_of_death) {
    self endon(#"death");
    if (is_true(self.head_gibbed)) {
        return;
    }
    self.head_gibbed = 1;
    if (!is_true(self.disable_head_gib)) {
        gibserverutils::gibhead(self);
    }
    self thread damage_over_time(ceil(self.health * 0.2), 1, attacker, means_of_death);
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xad404d73, Offset: 0x7548
// Size: 0x1ca
function gib_random_part() {
    if (is_true(self.no_gib)) {
        return;
    }
    playsoundatposition(#"zmb_death_gibss", self.origin);
    gib_index = randomint(5);
    if (gib_index == 3 && gibserverutils::isgibbed(self, 32) || gib_index == 4 && gibserverutils::isgibbed(self, 16)) {
        gib_index = randomint(3);
    }
    switch (gib_index) {
    case 0:
        self zombie_head_gib();
        break;
    case 1:
        gibserverutils::gibrightleg(self);
        break;
    case 2:
        gibserverutils::gibleftleg(self);
        break;
    case 3:
        gibserverutils::gibrightarm(self);
        break;
    case 4:
        gibserverutils::gibleftarm(self);
        break;
    default:
        break;
    }
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x61817902, Offset: 0x7720
// Size: 0x1ac
function gib_random_parts() {
    if (is_true(self.no_gib)) {
        return;
    }
    playsoundatposition(#"zmb_death_gibss", self.origin);
    val = randomint(100);
    if (val > 50) {
        self zombie_head_gib();
    }
    val = randomint(100);
    if (val > 50) {
        gibserverutils::gibrightleg(self);
    }
    val = randomint(100);
    if (val > 50) {
        gibserverutils::gibleftleg(self);
    }
    val = randomint(100);
    if (val > 50) {
        if (!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
        }
    }
    val = randomint(100);
    if (val > 50) {
        if (!gibserverutils::isgibbed(self, 16)) {
            gibserverutils::gibleftarm(self);
        }
    }
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x963e5bec, Offset: 0x78d8
// Size: 0xd2
function function_df5afb5e(missinglegs = 0) {
    if (missinglegs) {
        self.var_177172b0 = gettime();
        self.knockdown = 0;
        if (is_true(self.var_1731eda3)) {
            self.var_1731eda3 = undefined;
        }
        if (isdefined(level.var_9b91564e)) {
            if (!isdefined(level.num_crawlers)) {
                level.num_crawlers = 0;
            }
            level.num_crawlers++;
            self callback::function_d8abfc3d(#"on_ai_killed", &function_c768f32b);
        }
    }
    self.missinglegs = missinglegs;
}

// Namespace zombie_utility/zombie_utility
// Params 1, eflags: 0x4
// Checksum 0xd8e7c0d6, Offset: 0x79b8
// Size: 0x18
function private function_c768f32b(*params) {
    level.num_crawlers--;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x2
// Checksum 0x7f34796d, Offset: 0x79d8
// Size: 0x10
function autoexec init_ignore_player_handler() {
    level._ignore_player_handler = [];
}

// Namespace zombie_utility/zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xdafe1829, Offset: 0x79f0
// Size: 0x84
function register_ignore_player_handler(archetype, ignore_player_func) {
    assert(isdefined(archetype), "<dev string:x29e>");
    assert(!isdefined(level._ignore_player_handler[archetype]), "<dev string:x2ca>" + archetype + "<dev string:x2e6>");
    level._ignore_player_handler[archetype] = ignore_player_func;
}

// Namespace zombie_utility/zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x401788f3, Offset: 0x7a80
// Size: 0x36
function run_ignore_player_handler() {
    if (isdefined(level._ignore_player_handler[self.archetype])) {
        self [[ level._ignore_player_handler[self.archetype] ]]();
    }
}

/#

    // Namespace zombie_utility/zombie_utility
    // Params 0, eflags: 0x0
    // Checksum 0xfe99aa0c, Offset: 0x7ac0
    // Size: 0x118
    function updateanimationrate() {
        self notify(#"updateanimationrate");
        self endon(#"death", #"updateanimationrate");
        settings_bundle = self ai::function_9139c839();
        if (!isdefined(settings_bundle)) {
            return;
        }
        var_fd8e23d9 = self ai::function_9139c839().var_450edb3b;
        if (isdefined(var_fd8e23d9)) {
            self asmsetanimationrate(var_fd8e23d9);
        }
        while (true) {
            wait 1;
            animation_rate = self ai::function_9139c839().var_450edb3b;
            if (!isdefined(animation_rate)) {
                return;
            }
            if (var_fd8e23d9 == animation_rate) {
                continue;
            }
            self asmsetanimationrate(animation_rate);
            var_fd8e23d9 = animation_rate;
        }
    }

#/
