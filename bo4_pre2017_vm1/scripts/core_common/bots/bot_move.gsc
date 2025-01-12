#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/utility_eval;

#namespace namespace_d9f95110;

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x2
// Checksum 0x7003da83, Offset: 0x2a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bot_move", &__init__, undefined, undefined);
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x284e2927, Offset: 0x2e0
// Size: 0xa4
function __init__() {
    level.var_7c7d578b = [];
    function_9eedbbca("default", &sprint, &walk, &function_957a877c);
    function_9eedbbca("companion", &sprint, &walk, &function_957a877c);
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 4, eflags: 0x0
// Checksum 0xd7667fe1, Offset: 0x390
// Size: 0x92
function function_9eedbbca(name, var_21f0f22, var_d7983787, var_628c53c5) {
    table = spawnstruct();
    table.var_21f0f22 = var_21f0f22;
    table.var_d7983787 = var_d7983787;
    table.var_628c53c5 = var_628c53c5;
    level.var_7c7d578b[name] = table;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 3, eflags: 0x0
// Checksum 0x2d7471a, Offset: 0x430
// Size: 0x212
function function_2ea4aef7(var_5650366c, var_aeda73e, var_3150b3e) {
    if (self.goalforced) {
        /#
            self record_text("<dev string:x28>", (0, 1, 1));
        #/
        self.overridepos = undefined;
        return 1;
    }
    center = self function_3ea3eeba();
    if (!isdefined(center)) {
        return 0;
    }
    fillpos = self get_pathable_point(var_5650366c, center, (0, 1, 1));
    if (!isdefined(fillpos)) {
        return 0;
    }
    centerpos = center.origin;
    var_b23bef1e = undefined;
    var_a925cc7a = self function_6e40efe0(centerpos, var_b23bef1e);
    enemy = self get_enemy();
    /#
        recordline(centerpos, self.origin, (0, 1, 1), "<dev string:x49>", self);
        self function_57994579(center, fillpos, centerpos, var_b23bef1e, var_a925cc7a, enemy);
    #/
    var_d6e8de62 = function_30950e6a(center, var_aeda73e, var_3150b3e);
    return self function_14ea14e0(var_d6e8de62, center, fillpos, centerpos, var_b23bef1e, var_a925cc7a, enemy, (0, 1, 1));
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x6d8d14de, Offset: 0x650
// Size: 0xb2
function function_3ea3eeba() {
    center = self function_3fe05b06();
    if (isdefined(center)) {
        return center;
    }
    center = self function_8fdebdaa();
    if (isdefined(center)) {
        return center;
    }
    center = self function_7394ab3e();
    if (isdefined(center)) {
        return center;
    }
    center = self function_dfb9a0e7();
    if (isdefined(center)) {
        return center;
    }
    return undefined;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0xfefceeb7, Offset: 0x710
// Size: 0xaa
function function_3fe05b06() {
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    objective = self bot::function_12ce9d6f();
    if (!isdefined(objective)) {
        return undefined;
    }
    /#
        self record_text("<dev string:x52>", (0, 1, 1));
    #/
    return self function_2741a3fe(objective.trigger, (0, 1, 1));
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x4a2531f2, Offset: 0x7c8
// Size: 0x1cc
function function_8fdebdaa() {
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    if (!isdefined(self.protectent) || !isplayer(self.protectent) || !isalive(self.protectent)) {
        return undefined;
    }
    foreach (objective in level.a_gameobjects) {
        if (!self bot::can_interact_with(objective) || objective.type != "useObject" || objective.triggertype != "proximity" || !self.protectent istouching(objective.trigger)) {
            continue;
        }
        /#
            self record_text("<dev string:x71>", (0, 1, 1));
        #/
        return self function_2741a3fe(objective.trigger, (0, 1, 1));
    }
    return undefined;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0xac09a94c, Offset: 0x9a0
// Size: 0x102
function function_7394ab3e() {
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    if (isdefined(self.protectent.revivetrigger.beingrevived) && (!isdefined(self.protectent) || !isdefined(self.protectent.revivetrigger) || self.protectent.revivetrigger.beingrevived)) {
        return undefined;
    }
    /#
        self record_text("<dev string:xa3>", (0, 1, 1));
    #/
    self bot::set_revive_target(self.protectent);
    return self function_2741a3fe(self.protectent.revivetrigger, (0, 1, 1));
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x64e6ebae, Offset: 0xab0
// Size: 0x3ae
function function_dfb9a0e7() {
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    pixbeginevent("get_friendly_revive_center");
    aiprofile_beginentry("get_friendly_revive_center");
    players = getplayers();
    players = arraysort(players, self.origin);
    foreach (player in players) {
        if (isdefined(player.revivetrigger.beingrevived) && (player == self || player.team != self.team || !isdefined(player.revivetrigger) || player.revivetrigger.beingrevived)) {
            continue;
        }
        if (distancesquared(self.origin, player.origin) > 1.04858e+06) {
            pixendevent();
            aiprofile_endentry();
            return undefined;
        }
        otherplayers = arraysort(players, player.origin);
        foreach (otherplayer in otherplayers) {
            if (!otherplayer isbot() || otherplayer.team != self.team || otherplayer == player || otherplayer laststand::player_is_in_laststand()) {
                continue;
            }
            var_ab5142b9 = otherplayer bot::get_revive_target();
            if (isdefined(var_ab5142b9)) {
                if (player == var_ab5142b9) {
                    break;
                }
                continue;
            }
            if (self == otherplayer) {
                pixendevent();
                aiprofile_endentry();
                self bot::set_revive_target(player);
                return self function_2741a3fe(player.revivetrigger, (0, 1, 1));
            }
            break;
        }
    }
    pixendevent();
    aiprofile_endentry();
    return undefined;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 2, eflags: 0x0
// Checksum 0xd0b4272e, Offset: 0xe68
// Size: 0x190
function function_2741a3fe(trigger, debugcolor) {
    if (!issubstr(trigger.classname, "radius")) {
        return trigger;
    }
    /#
        if (self bot::should_record("<dev string:xca>")) {
            maxs = trigger getmaxs();
            mins = trigger getmins();
            radius = maxs[0];
            top = trigger.origin + (0, 0, maxs[2]);
            bottom = trigger.origin + (0, 0, mins[2]);
            recordcircle(bottom, radius, debugcolor, "<dev string:x49>", self);
            recordcircle(top, radius, debugcolor, "<dev string:x49>", self);
            recordline(bottom, top, debugcolor, "<dev string:x49>", self);
        }
    #/
    return trigger;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 3, eflags: 0x0
// Checksum 0xe55a3648, Offset: 0x1000
// Size: 0x70
function function_30950e6a(center, var_aeda73e, var_3150b3e) {
    if (!isentity(center)) {
        return var_aeda73e;
    }
    if (issubstr(center.classname, "use")) {
        return var_aeda73e;
    }
    return var_3150b3e;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 3, eflags: 0x0
// Checksum 0xbf0d5f7c, Offset: 0x1078
// Size: 0x212
function function_53b0caa0(var_5650366c, var_d6e8de62, var_8a136cb0) {
    if (!isdefined(var_d6e8de62) && !isdefined(var_8a136cb0)) {
        /#
            self record_text("<dev string:xd9>", (0, 1, 0));
        #/
        return 0;
    }
    /#
        self record_text("<dev string:xf0>", (0, 1, 0));
    #/
    center = self get_goal_center((0, 1, 0));
    fillpos = self get_pathable_point(var_5650366c, center, (0, 1, 0));
    if (!isdefined(fillpos)) {
        return 0;
    }
    centerpos = center.origin;
    var_b23bef1e = self function_c28bf13a();
    var_a925cc7a = self function_6e40efe0(centerpos, var_b23bef1e);
    enemy = self get_enemy();
    /#
        self function_57994579(center, fillpos, centerpos, var_b23bef1e, var_a925cc7a, enemy);
    #/
    if (self function_14ea14e0(var_d6e8de62, center, fillpos, centerpos, var_b23bef1e, var_a925cc7a, enemy, (0, 1, 0))) {
        return 1;
    }
    return self function_14ea14e0(var_8a136cb0, center, fillpos, centerpos, var_b23bef1e, var_a925cc7a, enemy, (0, 1, 0));
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 1, eflags: 0x0
// Checksum 0x4d377175, Offset: 0x1298
// Size: 0x198
function get_goal_center(debugcolor) {
    goalvolume = self getgoalvolume();
    if (isdefined(goalvolume)) {
        return goalvolume;
    }
    center = ai::t_cylinder(self.goalpos, self.goalradius, self.goalheight);
    /#
        if (self bot::should_record("<dev string:xca>")) {
            recordcircle(center.origin - (0, 0, center.halfheight), center.radius, debugcolor, "<dev string:x49>", self);
            recordcircle(center.origin + (0, 0, center.halfheight), center.radius, debugcolor, "<dev string:x49>", self);
            recordline(center.origin - (0, 0, center.halfheight), center.origin + (0, 0, center.halfheight), debugcolor, "<dev string:x49>", self);
        }
    #/
    return center;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x61b63986, Offset: 0x1438
// Size: 0x72
function function_c28bf13a() {
    if (isdefined(self.goalent)) {
        fwd = anglestoforward(self.goalent.angles) * 50;
        var_b23bef1e = self.goalent.origin + fwd;
        return var_b23bef1e;
    }
    return undefined;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 2, eflags: 0x0
// Checksum 0x8c885778, Offset: 0x14b8
// Size: 0xea
function function_6e40efe0(pos, var_b23bef1e) {
    if (!isdefined(var_b23bef1e)) {
        return undefined;
    }
    var_13f655e5 = var_b23bef1e - pos;
    selfdir = self.origin - pos;
    selfdir = (selfdir[0], selfdir[1], 0);
    var_dff3a439 = vectorprojection(selfdir, var_13f655e5);
    var_1f16c011 = selfdir - var_dff3a439;
    var_1f16c011 = vectornormalize(var_1f16c011);
    var_a925cc7a = pos + var_1f16c011 * 50;
    return var_a925cc7a;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x4090f5d7, Offset: 0x15b0
// Size: 0xe
function get_enemy() {
    return self.enemy;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 8, eflags: 0x0
// Checksum 0xe9bf9d54, Offset: 0x15c8
// Size: 0x3ae
function function_14ea14e0(var_d6e8de62, center, fillpos, centerpos, var_b23bef1e, var_a925cc7a, enemy, debugcolor) {
    if (!isdefined(var_d6e8de62)) {
        return false;
    }
    pixbeginevent("bot_pick_tactical_position");
    aiprofile_beginentry("bot_pick_tactical_position");
    tacpoints = tacticalquery(var_d6e8de62, center, fillpos, centerpos, isdefined(var_b23bef1e) ? var_b23bef1e : centerpos, isdefined(var_a925cc7a) ? var_a925cc7a : centerpos, isdefined(enemy) ? enemy : centerpos, self);
    pixendevent();
    aiprofile_endentry();
    if (tacpoints.size <= 0) {
        /#
            self record_text("<dev string:x101>" + var_d6e8de62 + "<dev string:x105>", debugcolor);
        #/
        return false;
    }
    /#
        self record_text("<dev string:x101>" + var_d6e8de62 + "<dev string:x117>" + tacpoints.size + "<dev string:x11a>", debugcolor);
    #/
    pickedpoint = undefined;
    foreach (tacpoint in tacpoints) {
        if (!self isposinclaimedlocation(tacpoint.origin)) {
            pickedpoint = tacpoint;
            break;
        }
    }
    if (!isdefined(pickedpoint)) {
        /#
            self record_text("<dev string:x128>", debugcolor);
        #/
        self.overridepos = self.origin;
        return false;
    }
    if (isdefined(pickedpoint.node)) {
        self.overridenode = pickedpoint.node;
    } else {
        self.overridepos = pickedpoint.origin;
    }
    /#
        if (self bot::should_record("<dev string:xca>")) {
            foreach (point in tacpoints) {
                recordcircle(point.origin, 15, debugcolor, "<dev string:x49>", self);
            }
        }
    #/
    return true;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 3, eflags: 0x0
// Checksum 0xec3b2b8b, Offset: 0x1980
// Size: 0x334
function get_pathable_point(var_d6e8de62, center, debugcolor) {
    if (!isdefined(var_d6e8de62)) {
        return undefined;
    }
    pixbeginevent("bot_get_pathable_point");
    aiprofile_beginentry("bot_get_pathable_point");
    tacpoints = tacticalquery(var_d6e8de62, center);
    if (tacpoints.size <= 0) {
        pixendevent();
        aiprofile_endentry();
        /#
            self record_text("<dev string:x140>", debugcolor);
        #/
        return undefined;
    }
    goalpoints = [];
    foreach (tacpoint in tacpoints) {
        if (!isdefined(goalpoints)) {
            goalpoints = [];
        } else if (!isarray(goalpoints)) {
            goalpoints = array(goalpoints);
        }
        goalpoints[goalpoints.size] = tacpoint.origin;
    }
    /#
        if (self bot::should_record("<dev string:xca>")) {
            foreach (point in goalpoints) {
                recordline(point, point + (0, 0, 50), debugcolor, "<dev string:x49>", self);
            }
        }
    #/
    path = generatenavmeshpath(self.origin, goalpoints, self);
    pixendevent();
    aiprofile_endentry();
    if (!isdefined(path)) {
        /#
            self record_text("<dev string:x153>", debugcolor);
        #/
        return undefined;
    }
    return path.pathpoints[path.pathpoints.size - 1];
}

/#

    // Namespace namespace_d9f95110/namespace_d9f95110
    // Params 2, eflags: 0x0
    // Checksum 0x6fcf7353, Offset: 0x1cc0
    // Size: 0x64
    function record_text(text, textcolor) {
        if (self bot::should_record("<dev string:xca>")) {
            record3dtext(text, self.origin, textcolor, "<dev string:x163>", self, 0.5);
        }
    }

    // Namespace namespace_d9f95110/namespace_d9f95110
    // Params 6, eflags: 0x0
    // Checksum 0x55039a22, Offset: 0x1d30
    // Size: 0x1dc
    function function_57994579(center, fillpos, centerpos, var_b23bef1e, var_a925cc7a, enemy) {
        if (self bot::should_record("<dev string:xca>")) {
            recordline(fillpos, fillpos + (0, 0, 100), (1, 0, 1), "<dev string:x49>", self);
            recordstar(fillpos, (0, 1, 1), "<dev string:x49>", self);
            if (isdefined(var_b23bef1e)) {
                recordline(centerpos, var_b23bef1e, (0, 0, 1), "<dev string:x49>", self);
                recordstar(var_b23bef1e, (0, 0, 1), "<dev string:x49>", self);
            }
            if (isdefined(var_a925cc7a)) {
                recordline(centerpos, var_a925cc7a, (1, 0, 1), "<dev string:x49>", self);
                recordstar(var_a925cc7a, (1, 0, 1), "<dev string:x49>", self);
            }
            if (isdefined(enemy)) {
                enemypos = isentity(enemy) ? enemy.origin : enemy;
                recordline(centerpos, enemypos, (1, 0, 0), "<dev string:x49>", self);
                recordstar(enemypos, (1, 0, 0), "<dev string:x49>", self);
            }
        }
    }

#/

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x101e005e, Offset: 0x1f18
// Size: 0x64
function function_80f06707() {
    self thread handle_path_success();
    self thread handle_path_failed();
    self thread handle_goal_reached();
    self thread handle_goal_changed();
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0xb677e892, Offset: 0x1f88
// Size: 0x12
function function_39041145() {
    self notify(#"hash_f47db3f7");
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x64a3e562, Offset: 0x1fa8
// Size: 0x58
function handle_path_success() {
    self endon(#"death");
    self endon(#"hash_f47db3f7");
    level endon(#"game_ended");
    while (true) {
        self waittill("bot_path_success");
        self function_3d54f865();
    }
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x8786c9ab, Offset: 0x2008
// Size: 0x46
function handle_path_failed() {
    self endon(#"death");
    self endon(#"hash_f47db3f7");
    level endon(#"game_ended");
    while (true) {
        self waittill("bot_path_failed");
    }
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x88819be3, Offset: 0x2058
// Size: 0x58
function handle_goal_reached() {
    self endon(#"death");
    self endon(#"hash_f47db3f7");
    level endon(#"game_ended");
    while (true) {
        self waittill("bot_goal_reached");
        self function_3d54f865();
    }
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x482032, Offset: 0x20b8
// Size: 0x5a
function handle_goal_changed() {
    self endon(#"death");
    self endon(#"hash_f47db3f7");
    level endon(#"game_ended");
    while (true) {
        self waittill("goal_changed");
        if (self.goalforced) {
            self.overridepos = undefined;
        }
    }
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x7e6c090b, Offset: 0x2120
// Size: 0xec
function function_3d54f865() {
    name = self bot::function_fab42cc7();
    stance = level.var_7c7d578b[name];
    if (!self isingoal(self.origin)) {
        self [[ stance.var_21f0f22 ]]();
        return;
    }
    if (self haspath()) {
        self [[ stance.var_d7983787 ]]();
        return;
    }
    node = self bot::get_position_node();
    self [[ stance.var_628c53c5 ]](node);
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 3, eflags: 0x0
// Checksum 0xdefc3ca8, Offset: 0x2218
// Size: 0x78
function function_dd550d46(var_e94ccbe0, var_d65c492d, var_dd259df) {
    stance = spawnstruct();
    stance.var_e94ccbe0 = var_e94ccbe0;
    stance.var_d65c492d = var_d65c492d;
    stance.var_dd259df = var_dd259df;
    return stance;
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 1, eflags: 0x0
// Checksum 0x9ec2ce4, Offset: 0x2298
// Size: 0xe4
function function_957a877c(node) {
    if (!isdefined(node)) {
        self walk();
        return;
    }
    if (strstartswith(node.type, "Cover")) {
        if (node.spawnflags & 131072) {
            self crouch();
        } else {
            self walk();
        }
        return;
    }
    if (node.spawnflags & 8) {
        self crouch();
        return;
    }
    self walk();
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0xd1dfa213, Offset: 0x2388
// Size: 0x4c
function sprint() {
    self botpressbutton(1);
    self botreleasebutton(9);
    self botreleasebutton(8);
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0xa4ae61a5, Offset: 0x23e0
// Size: 0x4c
function walk() {
    self botreleasebutton(1);
    self botreleasebutton(9);
    self botreleasebutton(8);
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0x1996b284, Offset: 0x2438
// Size: 0x4c
function crouch() {
    self botreleasebutton(1);
    self botpressbutton(9);
    self botreleasebutton(8);
}

// Namespace namespace_d9f95110/namespace_d9f95110
// Params 0, eflags: 0x0
// Checksum 0xcd5ff56d, Offset: 0x2490
// Size: 0x4c
function prone() {
    self botreleasebutton(1);
    self botreleasebutton(9);
    self botpressbutton(8);
}

