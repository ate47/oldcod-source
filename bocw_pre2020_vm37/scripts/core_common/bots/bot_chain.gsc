#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace bot_chain;

// Namespace bot_chain
// Method(s) 2 Total 2
class class_92792865 {

    var startstruct;
    var var_4de004b7;
    var var_d1e3e893;
    var var_e7ce4106;

    // Namespace class_92792865/bot_chain
    // Params 0, eflags: 0x9 linked
    // Checksum 0xd30d2478, Offset: 0x160
    // Size: 0x32
    constructor() {
        var_4de004b7 = undefined;
        startstruct = undefined;
        var_e7ce4106 = undefined;
        var_d1e3e893 = undefined;
    }

}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x6
// Checksum 0xf67f390f, Offset: 0x118
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"bot_chain", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x5 linked
// Checksum 0xcbf453fc, Offset: 0x238
// Size: 0x2c
function private function_70a657d8() {
    function_e3eaa42b();
    level thread function_ea764100();
}

// Namespace bot_chain/bot_chain
// Params 1, eflags: 0x4
// Checksum 0xc51c2da2, Offset: 0x270
// Size: 0x10e
function private function_b1487cfa(var_72284260) {
    entities = bot::get_bots();
    foreach (entity in entities) {
        if (!isdefined(entity.bot)) {
            continue;
        }
        if (!isdefined(entity.bot.var_53ffa4c4)) {
            continue;
        }
        if (isdefined(entity.bot.var_53ffa4c4.var_4de004b7) && entity.bot.var_53ffa4c4.var_4de004b7 == var_72284260) {
            return true;
        }
    }
    return false;
}

/#

    // Namespace bot_chain/bot_chain
    // Params 3, eflags: 0x4
    // Checksum 0x135fc73, Offset: 0x388
    // Size: 0xf76
    function private function_8ded619(var_72284260, targetstructs = undefined, duration = 1) {
        drawheight = 8;
        active = function_b1487cfa(var_72284260);
        if (active) {
            sphere(var_72284260.origin, 8, (0, 1, 0), 1, 0, 12, duration);
        } else if (isinarray(level.var_40ed3318, var_72284260)) {
            sphere(var_72284260.origin, 6, (0.75, 0.75, 0.75), 0.7, 0, 10, duration);
        } else {
            sphere(var_72284260.origin, 6, (1, 0.5, 0), 0.7, 0, 10, duration);
        }
        if (!isdefined(targetstructs)) {
            targetstructs = [];
            if (isdefined(var_72284260.target)) {
                structs = struct::get_array(var_72284260.target);
                foreach (struct in structs) {
                    if (struct.variantname === "<dev string:x38>") {
                        array::add(targetstructs, struct);
                    }
                }
            }
            if (isdefined(var_72284260.script_bot_chain_src)) {
                var_354db6a0 = var_72284260 namespace_2e6206f9::get_target_structs("<dev string:x45>");
                if (var_354db6a0.size > 0) {
                    targetstructs = arraycombine(targetstructs, var_354db6a0, 0, 0);
                }
            }
        }
        foreach (struct in targetstructs) {
            if (active) {
                line(var_72284260.origin, struct.origin, (0, 1, 0), 1, 0, duration);
                continue;
            }
            line(var_72284260.origin, struct.origin, (1, 0.5, 0), 0.7, 0, duration);
        }
        if (isdefined(var_72284260.targetname)) {
            if (active) {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x59>" + var_72284260.targetname, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x59>" + var_72284260.targetname, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_72284260.script_flag_set)) {
            if (level flag::get(var_72284260.script_flag_set)) {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x63>" + var_72284260.script_flag_set, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x63>" + var_72284260.script_flag_set, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_72284260.script_flag_set)) {
            if (level flag::get(var_72284260.script_flag_set)) {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x6d>" + var_72284260.script_flag_set, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x6d>" + var_72284260.script_flag_set, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_72284260.script_flag_wait)) {
            if (level flag::get(var_72284260.script_flag_wait)) {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x7b>" + var_72284260.script_flag_wait, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x7b>" + var_72284260.script_flag_wait, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_72284260.script_flag_clear)) {
            if (level flag::get(var_72284260.script_flag_wait)) {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x8a>" + var_72284260.script_flag_clear, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x8a>" + var_72284260.script_flag_clear, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_72284260.script_flag_activate)) {
            if (level flag::get(var_72284260.script_flag_activate)) {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x9a>" + var_72284260.script_flag_activate, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x9a>" + var_72284260.script_flag_activate, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_72284260.script_aigroup)) {
            if (level flag::exists(var_72284260.script_aigroup) && level flag::get(var_72284260.script_aigroup)) {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:xad>" + var_72284260.script_aigroup, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:xad>" + var_72284260.script_aigroup, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_72284260.script_ent_flag_set)) {
            print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:xbb>" + var_72284260.script_ent_flag_set, (1, 1, 1), 1, 0.2, duration);
            drawheight += 4;
        }
        if (isdefined(var_72284260.script_ent_flag_clear)) {
            print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:xcd>" + var_72284260.script_ent_flag_clear, (1, 1, 1), 1, 0.2, duration);
            drawheight += 4;
        }
        if (!active) {
            return targetstructs;
        }
        if (!isdefined(var_72284260.target) && !isdefined(var_72284260.script_botchain_goal)) {
            return targetstructs;
        }
        goals = [];
        if (isdefined(var_72284260.target)) {
            nodes = getnodearray(var_72284260.target, "<dev string:xe1>");
            if (isdefined(nodes) && nodes.size > 0) {
                goals = arraycombine(goals, nodes, 0, 0);
            }
        }
        if (isdefined(var_72284260.script_botchain_goal)) {
            nodes = getnodearray(var_72284260.script_botchain_goal, "<dev string:xef>");
            if (isdefined(nodes) && nodes.size > 0) {
                goals = arraycombine(goals, nodes, 0, 0);
            }
        }
        if (isdefined(var_72284260.target)) {
            volumes = getentarray(var_72284260.target, "<dev string:xe1>");
            if (isdefined(volumes) && volumes.size > 0) {
                goals = arraycombine(goals, volumes, 0, 0);
            }
        }
        if (isdefined(var_72284260.script_botchain_goal)) {
            volumes = getentarray(var_72284260.script_botchain_goal, "<dev string:xef>");
            if (isdefined(volumes) && volumes.size > 0) {
                goals = arraycombine(goals, volumes, 0, 0);
            }
        }
        if (!goals.size) {
            return targetstructs;
        }
        foreach (goal in goals) {
            if (ispathnode(goal)) {
                line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
                nodecolor = (0, 1, 0);
                if (isdefined(goal.radius)) {
                    circle(goal.origin, goal.radius, (0, 1, 0), 0, 1, duration);
                } else {
                    nodecolor = (1, 0, 0);
                }
                box(goal.origin, (-16, -16, 0), (16, 16, 0), 0, nodecolor, 1, 1, duration);
                continue;
            }
            if (goal.classname === "<dev string:x107>") {
                maxs = goal getmaxs();
                mins = goal getmins();
                box(goal.origin, mins, maxs, 0, (0, 1, 0), 1, 1, duration);
                line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
                continue;
            }
            if (goal.variantname === "<dev string:x38>") {
                if (isdefined(goal.radius)) {
                    searchradius = goal.radius;
                } else {
                    print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x116>", (1, 0, 0), 1, 0.2);
                    drawheight += 4;
                }
                circle(goal.origin, searchradius, (0, 1, 0), 0, 1, duration);
                line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
            }
        }
        return targetstructs;
    }

#/

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x5 linked
// Checksum 0x4707488d, Offset: 0x1308
// Size: 0x2b0
function private function_ea764100() {
    /#
        level.var_40ed3318 = [];
        structs = struct::get_array("<dev string:x38>", "<dev string:x127>");
        targetstructs = [];
        duration = 10;
        viewdistancesq = function_a3f6cdac(3000);
        while (true) {
            waitframe(duration);
            var_b1285611 = getdvarint(#"hash_5bc9f81b4f504592", 0);
            if (!var_b1285611) {
                targetstructs = [];
                continue;
            }
            entities = bot::get_bots();
            players = getplayers();
            campos = (0, 0, 0);
            if (players.size > 0) {
                campos = players[0].origin;
            }
            foreach (entity in entities) {
                if (!isdefined(entity.bot)) {
                    continue;
                }
                if (!isdefined(entity.bot.var_53ffa4c4)) {
                    continue;
                }
                if (isdefined(entity.bot.var_53ffa4c4.var_4de004b7)) {
                    line(entity.origin, entity.bot.var_53ffa4c4.var_4de004b7.origin, (0, 1, 1), 1, 0, duration);
                }
            }
            for (index = 0; index < structs.size; index++) {
                if (distance2dsquared(campos, structs[index].origin) <= viewdistancesq) {
                    targetstructs[index] = function_8ded619(structs[index], targetstructs[index], duration);
                }
            }
        }
    #/
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x5 linked
// Checksum 0x8627d316, Offset: 0x15c0
// Size: 0x180
function private function_e3eaa42b() {
    structs = struct::get_array("bot_chain", "variantname");
    if (!isdefined(structs)) {
        return;
    }
    foreach (struct in structs) {
        if (isdefined(struct.script_flag_set)) {
            if (!isdefined(level.flag[struct.script_flag_set])) {
                level flag::init(struct.script_flag_set);
            }
        }
        if (isdefined(struct.script_flag_wait)) {
            if (!isdefined(level.flag[struct.script_flag_wait])) {
                level flag::init(struct.script_flag_wait);
            }
        }
        if (isdefined(struct.script_flag_activate)) {
            if (!isdefined(level.flag[struct.script_flag_activate])) {
                level flag::init(struct.script_flag_activate);
            }
        }
    }
}

// Namespace bot_chain/bot_chain
// Params 1, eflags: 0x5 linked
// Checksum 0xb3b533ad, Offset: 0x1748
// Size: 0x456
function private function_e7b80b1e(var_72284260) {
    self endon(#"hash_382a628dad5ecbb5");
    assert(isdefined(var_72284260));
    if (!isdefined(var_72284260.target) && !isdefined(var_72284260.script_bot_chain_src)) {
        return undefined;
    }
    structs = [];
    if (isdefined(var_72284260.target)) {
        var_436fb4d0 = struct::get_array(var_72284260.target);
        if (isdefined(var_436fb4d0) && var_436fb4d0.size) {
            structs = arraycombine(structs, var_436fb4d0, 0, 0);
        }
    }
    if (isdefined(var_72284260.script_bot_chain_src)) {
        var_436fb4d0 = var_72284260 namespace_2e6206f9::get_target_structs("script_bot_chain");
        if (var_436fb4d0.size > 0) {
            structs = arraycombine(structs, var_436fb4d0, 0, 0);
        }
    }
    var_d8bb5bb6 = [];
    foreach (struct in structs) {
        if (struct.variantname === "bot_chain") {
            array::add(var_d8bb5bb6, struct);
        }
    }
    var_7bc3c842 = [];
    var_653c94ca = [];
    flagarray = [];
    foreach (struct in var_d8bb5bb6) {
        if (!isdefined(struct.script_flag_activate) || level flag::get(struct.script_flag_activate)) {
            array::add(var_7bc3c842, struct);
        }
        if (isdefined(struct.script_flag_activate) && !level flag::get(struct.script_flag_activate)) {
            array::add(var_653c94ca, struct);
            array::add(flagarray, struct.script_flag_activate);
        }
    }
    if (var_7bc3c842.size) {
        return array::random(var_7bc3c842);
    }
    if (var_653c94ca.size) {
        assert(flagarray.size);
        level flag::wait_till_any(flagarray);
        foreach (struct in var_653c94ca) {
            assert(isdefined(struct.script_flag_activate));
            if (level flag::get(struct.script_flag_activate)) {
                return struct;
            }
        }
    }
    if (var_d8bb5bb6.size > 0) {
        return array::random(var_d8bb5bb6);
    }
    return undefined;
}

// Namespace bot_chain/bot_chain
// Params 2, eflags: 0x5 linked
// Checksum 0x447ea66b, Offset: 0x1ba8
// Size: 0x96
function private function_ea88f102(entity, goal) {
    assert(isdefined(goal));
    if (!isdefined(entity.bot.var_53ffa4c4)) {
        return false;
    }
    if (isdefined(entity.bot.var_53ffa4c4.var_d1e3e893) && entity.bot.var_53ffa4c4.var_d1e3e893 == goal) {
        return true;
    }
    return false;
}

// Namespace bot_chain/bot_chain
// Params 2, eflags: 0x5 linked
// Checksum 0xeefab745, Offset: 0x1c48
// Size: 0x282
function private function_ce1ee70(goal, bot) {
    assert(isdefined(bot));
    assert(isdefined(goal));
    bots = bot bot::get_friendly_bots();
    arrayremovevalue(bots, bot);
    if (!bot.size) {
        return false;
    }
    if (ispathnode(goal)) {
        foreach (entity in bots) {
            if (function_ea88f102(entity, goal)) {
                return true;
            }
        }
        return false;
    } else if (goal.classname === "info_volume") {
        foreach (entity in bots) {
            if (function_ea88f102(entity, goal)) {
                return true;
            }
        }
        return false;
    }
    assert(isvec(goal));
    foreach (entity in bots) {
        if (function_ea88f102(entity, goal)) {
            return true;
        }
    }
    return false;
}

// Namespace bot_chain/bot_chain
// Params 2, eflags: 0x5 linked
// Checksum 0xb4004c67, Offset: 0x1ed8
// Size: 0x4aa
function private function_c2d874f1(var_72284260, bot) {
    assert(isdefined(var_72284260));
    assert(isdefined(bot));
    if (!isdefined(var_72284260.target) && !isdefined(var_72284260.script_botchain_goal)) {
        return var_72284260;
    }
    assert(isdefined(var_72284260.target) || isdefined(var_72284260.script_botchain_goal));
    goals = [];
    if (isdefined(var_72284260.target)) {
        var_cfc087ec = getnodearray(var_72284260.target, "targetname");
        if (isdefined(var_cfc087ec) && var_cfc087ec.size) {
            goals = arraycombine(goals, var_cfc087ec, 0, 0);
        }
    }
    if (isdefined(var_72284260.script_botchain_goal)) {
        var_cfc087ec = getnodearray(var_72284260.script_botchain_goal, "script_botchain_goal");
        if (isdefined(var_cfc087ec) && var_cfc087ec.size) {
            goals = arraycombine(goals, var_cfc087ec, 0, 0);
        }
    }
    if (isdefined(var_72284260.target)) {
        var_ddf842e8 = getentarray(var_72284260.target, "targetname");
        if (isdefined(var_ddf842e8) && var_ddf842e8.size) {
            goals = arraycombine(goals, var_ddf842e8, 0, 0);
        }
    }
    if (isdefined(var_72284260.script_botchain_goal)) {
        var_ddf842e8 = getentarray(var_72284260.script_botchain_goal, "script_botchain_goal");
        if (isdefined(var_ddf842e8) && var_ddf842e8.size) {
            goals = arraycombine(goals, var_ddf842e8, 0, 0);
        }
    }
    if (!goals.size) {
        return var_72284260;
    }
    var_1bfc6c1d = [];
    if (isdefined(self.bot.var_53ffa4c4.var_e7ce4106)) {
        foreach (goal in goals) {
            if (isdefined(goal.script_botchain_color) && goal.script_botchain_color == self.bot.var_53ffa4c4.var_e7ce4106) {
                array::add(var_1bfc6c1d, goal);
            }
        }
    }
    if (var_1bfc6c1d.size) {
        return var_1bfc6c1d;
    }
    var_133e0bbb = [];
    foreach (goal in goals) {
        if (function_ce1ee70(goal, bot)) {
            array::add(var_133e0bbb, goal);
        }
    }
    foreach (goal in var_133e0bbb) {
        arrayremovevalue(goals, goal);
    }
    if (goals.size) {
        return goals;
    }
    if (var_133e0bbb.size) {
        goals = arraycombine(goals, var_133e0bbb, 0, 0);
    }
    return goals;
}

// Namespace bot_chain/bot_chain
// Params 1, eflags: 0x5 linked
// Checksum 0xc109caba, Offset: 0x2390
// Size: 0xc6
function private set_goalradius_based_on_settings(goal) {
    assert(isbot(self) || isvehicle(self));
    assert(isdefined(goal));
    if (is_true(goal.script_forcegoal)) {
        return;
    }
    if (spawner::node_has_radius(goal)) {
        self.goalradius = goal.radius;
    }
    if (isdefined(goal.height)) {
        self.goalheight = goal.height;
    }
}

// Namespace bot_chain/bot_chain
// Params 1, eflags: 0x0
// Checksum 0xe3131c6c, Offset: 0x2460
// Size: 0x3ac
function function_95d17a51(startstruct) {
    structs = array();
    if (isstring(startstruct)) {
        startstruct = struct::get(startstruct);
        assert(isdefined(startstruct));
    } else {
        assert(isdefined(startstruct) && isstruct(startstruct));
    }
    var_5842dd6c = array();
    targets = array();
    if (isdefined(startstruct.target)) {
        targets[targets.size] = startstruct.target;
        var_5842dd6c[startstruct.target] = 1;
    }
    structs[structs.size] = startstruct;
    while (targets.size > 0) {
        target = targets[0];
        arrayremoveindex(targets, 0);
        targetstructs = struct::get_array(target);
        foreach (struct in targetstructs) {
            structs[structs.size] = struct;
            if (isdefined(struct.target) && !isdefined(var_5842dd6c[struct.target])) {
                targets[targets.size] = struct.target;
                var_5842dd6c[struct.target] = 1;
            }
        }
    }
    targets = array();
    if (isdefined(startstruct.script_bot_chain_src)) {
        targets[targets.size] = startstruct.script_bot_chain_src;
        var_5842dd6c[startstruct.script_bot_chain_src] = 1;
    }
    while (targets.size > 0) {
        target = targets[0];
        arrayremoveindex(targets, 0);
        targetstructs = struct::get_array(target, "script_bot_chain_target");
        foreach (struct in targetstructs) {
            structs[structs.size] = struct;
            if (isdefined(struct.script_bot_chain_src) && !isdefined(var_5842dd6c[struct.script_bot_chain_src])) {
                targets[targets.size] = struct.script_bot_chain_src;
                var_5842dd6c[struct.script_bot_chain_src] = 1;
            }
        }
    }
    return structs;
}

// Namespace bot_chain/bot_chain
// Params 2, eflags: 0x1 linked
// Checksum 0xb0c46284, Offset: 0x2818
// Size: 0x6e4
function function_cf70f2fe(startstruct, resuming = 0) {
    assert(isbot(self));
    assert(isdefined(self.bot));
    if (isstring(startstruct)) {
        startstruct = struct::get(startstruct);
        assert(isdefined(startstruct));
    } else {
        assert(isdefined(startstruct) && isstruct(startstruct));
    }
    assert(startstruct.variantname == "<dev string:x38>");
    goalent = self isinvehicle() ? self getvehicleoccupied() : self;
    goalent endon(#"death");
    self endon(#"death");
    self notify(#"hash_382a628dad5ecbb5");
    self endon(#"hash_382a628dad5ecbb5");
    debugstart = startstruct;
    if (resuming && isdefined(self.bot.var_53ffa4c4)) {
        debugstart = self.bot.var_53ffa4c4.startstruct;
    }
    self.bot.var_53ffa4c4 = new class_92792865();
    self.bot.var_53ffa4c4.var_4de004b7 = startstruct;
    self.bot.var_53ffa4c4.startstruct = debugstart;
    for (;;) {
        var_4de004b7 = self.bot.var_53ffa4c4.var_4de004b7;
        goals = function_c2d874f1(var_4de004b7, self);
        if (!isdefined(goals)) {
            break;
        }
        if (isarray(goals)) {
            goal = array::random(goals);
        } else if (goals == var_4de004b7) {
            goal = goals;
        }
        if (ispathnode(goal) || isstruct(goal)) {
            goalent set_goalradius_based_on_settings(goal);
        }
        if (ispathnode(goal)) {
            goalent setgoal(goal, is_true(goal.script_forcegoal));
        } else if (isstruct(goal)) {
            goalent setgoal(goal.origin, is_true(goal.script_forcegoal));
        } else {
            goalent setgoal(goal);
        }
        self.bot.var_53ffa4c4.var_d1e3e893 = goal;
        goalent waittill(#"goal");
        if (isdefined(var_4de004b7.script_notify)) {
            self notify(var_4de004b7.script_notify);
        }
        if (isdefined(goal.script_botchain_color)) {
            self.bot.var_53ffa4c4.var_e7ce4106 = goal.script_botchain_color;
        }
        if (isdefined(var_4de004b7.script_flag_set)) {
            level flag::set(var_4de004b7.script_flag_set);
        }
        if (isdefined(var_4de004b7.script_flag_clear)) {
            level flag::set(var_4de004b7.script_flag_clear);
        }
        if (isdefined(var_4de004b7.script_ent_flag_set)) {
            if (!self flag::exists(var_4de004b7.script_ent_flag_set)) {
                assertmsg("<dev string:x136>" + var_4de004b7.script_ent_flag_set + "<dev string:x153>");
            }
            self flag::set(var_4de004b7.script_ent_flag_set);
        }
        if (isdefined(var_4de004b7.script_ent_flag_clear)) {
            if (!self flag::exists(var_4de004b7.script_ent_flag_clear)) {
                assertmsg("<dev string:x16c>" + var_4de004b7.script_ent_flag_clear + "<dev string:x153>");
            }
            self flag::clear(var_4de004b7.script_ent_flag_clear);
        }
        if (isdefined(var_4de004b7.script_flag_wait)) {
            level flag::wait_till(var_4de004b7.script_flag_wait);
        }
        if (isdefined(var_4de004b7.script_aigroup)) {
            if (isdefined(level._ai_group[var_4de004b7.script_aigroup])) {
                spawner::waittill_ai_group_cleared(var_4de004b7.script_aigroup);
            }
        }
        var_4de004b7 util::script_delay();
        var_18c2bdb3 = function_e7b80b1e(var_4de004b7);
        /#
            array::add(level.var_40ed3318, var_4de004b7, 0);
        #/
        if (!isdefined(var_18c2bdb3)) {
            break;
        }
        self.bot.var_53ffa4c4.var_4de004b7 = var_18c2bdb3;
    }
    self function_73d1cfe6();
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x1 linked
// Checksum 0xf0ae8256, Offset: 0x2f08
// Size: 0x8c
function function_34a84039() {
    assert(isbot(self));
    if (isdefined(self.bot.var_53ffa4c4) && isdefined(self.bot.var_53ffa4c4.var_4de004b7)) {
        self thread function_cf70f2fe(self.bot.var_53ffa4c4.var_4de004b7, 1);
    }
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x1 linked
// Checksum 0x5fce874e, Offset: 0x2fa0
// Size: 0x5e
function function_73d1cfe6() {
    assert(isbot(self));
    if (isdefined(self.bot.var_53ffa4c4)) {
        self.bot.var_53ffa4c4 = undefined;
    }
    self notify(#"hash_382a628dad5ecbb5");
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x1 linked
// Checksum 0x6dd4323e, Offset: 0x3008
// Size: 0x48
function function_58b429fb() {
    assert(isbot(self));
    if (isdefined(self.bot.var_53ffa4c4)) {
        return true;
    }
    return false;
}

