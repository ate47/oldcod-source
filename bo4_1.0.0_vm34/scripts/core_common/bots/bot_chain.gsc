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
class class_8f7edd0a {

    var activecolor;
    var startstruct;
    var var_886408fc;
    var var_a1852e7e;

    // Namespace class_8f7edd0a/bot_chain
    // Params 0, eflags: 0x8
    // Checksum 0x6028e735, Offset: 0x158
    // Size: 0x32
    constructor() {
        var_886408fc = undefined;
        startstruct = undefined;
        activecolor = undefined;
        var_a1852e7e = undefined;
    }

}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x2
// Checksum 0x7b6ed6a7, Offset: 0x110
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bot_chain", &__init__, undefined, undefined);
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x0
// Checksum 0xc4366e7e, Offset: 0x238
// Size: 0x2c
function __init__() {
    function_3438d586();
    level thread function_6dfab14f();
}

// Namespace bot_chain/bot_chain
// Params 1, eflags: 0x4
// Checksum 0xb1e6ff83, Offset: 0x270
// Size: 0x102
function private function_1711bd5c(var_7a1d02c8) {
    entities = bot::get_bots();
    foreach (entity in entities) {
        if (!isdefined(entity.bot)) {
            continue;
        }
        if (!isdefined(entity.bot.var_7ef83d)) {
            continue;
        }
        if (isdefined(entity.bot.var_7ef83d.var_886408fc) && entity.bot.var_7ef83d.var_886408fc == var_7a1d02c8) {
            return true;
        }
    }
    return false;
}

/#

    // Namespace bot_chain/bot_chain
    // Params 3, eflags: 0x4
    // Checksum 0xd2dd0cf3, Offset: 0x380
    // Size: 0xff6
    function private function_242fb8c3(var_7a1d02c8, targetstructs = undefined, duration = 1) {
        drawheight = 8;
        active = function_1711bd5c(var_7a1d02c8);
        if (active) {
            sphere(var_7a1d02c8.origin, 8, (0, 1, 0), 1, 0, 12, duration);
        } else if (isinarray(level.var_6bdcb369, var_7a1d02c8)) {
            sphere(var_7a1d02c8.origin, 6, (0.75, 0.75, 0.75), 0.7, 0, 10, duration);
        } else {
            sphere(var_7a1d02c8.origin, 6, (1, 0.5, 0), 0.7, 0, 10, duration);
        }
        if (!isdefined(targetstructs)) {
            targetstructs = [];
            if (isdefined(var_7a1d02c8.target)) {
                structs = struct::get_array(var_7a1d02c8.target);
                foreach (struct in structs) {
                    if (struct.variantname === "<dev string:x30>") {
                        array::add(targetstructs, struct);
                    }
                }
            }
            if (isdefined(var_7a1d02c8.script_bot_chain_src)) {
                var_4d121183 = var_7a1d02c8 namespace_8955127e::get_target_structs("<dev string:x3a>");
                if (var_4d121183.size > 0) {
                    targetstructs = arraycombine(targetstructs, var_4d121183, 0, 0);
                }
            }
        }
        foreach (struct in targetstructs) {
            if (active) {
                line(var_7a1d02c8.origin, struct.origin, (0, 1, 0), 1, 0, duration);
                continue;
            }
            line(var_7a1d02c8.origin, struct.origin, (1, 0.5, 0), 0.7, 0, duration);
        }
        if (isdefined(var_7a1d02c8.targetname)) {
            if (active) {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x4b>" + var_7a1d02c8.targetname, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x4b>" + var_7a1d02c8.targetname, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_7a1d02c8.script_flag_set)) {
            if (level flag::get(var_7a1d02c8.script_flag_set)) {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x52>" + var_7a1d02c8.script_flag_set, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x52>" + var_7a1d02c8.script_flag_set, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_7a1d02c8.script_flag_set)) {
            if (level flag::get(var_7a1d02c8.script_flag_set)) {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x59>" + var_7a1d02c8.script_flag_set, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x59>" + var_7a1d02c8.script_flag_set, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_7a1d02c8.script_flag_wait)) {
            if (level flag::get(var_7a1d02c8.script_flag_wait)) {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x64>" + var_7a1d02c8.script_flag_wait, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x64>" + var_7a1d02c8.script_flag_wait, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_7a1d02c8.script_flag_clear)) {
            if (level flag::get(var_7a1d02c8.script_flag_wait)) {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x70>" + var_7a1d02c8.script_flag_clear, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x70>" + var_7a1d02c8.script_flag_clear, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_7a1d02c8.script_flag_activate)) {
            if (level flag::get(var_7a1d02c8.script_flag_activate)) {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x7d>" + var_7a1d02c8.script_flag_activate, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x7d>" + var_7a1d02c8.script_flag_activate, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_7a1d02c8.script_aigroup)) {
            if (level flag::exists(var_7a1d02c8.script_aigroup) && level flag::get(var_7a1d02c8.script_aigroup)) {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x8d>" + var_7a1d02c8.script_aigroup, (0, 1, 0), 1, 0.2, duration);
            } else {
                print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x8d>" + var_7a1d02c8.script_aigroup, (1, 0.5, 0), 1, 0.2, duration);
            }
            drawheight += 4;
        }
        if (isdefined(var_7a1d02c8.script_ent_flag_set)) {
            print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:x98>" + var_7a1d02c8.script_ent_flag_set, (1, 1, 1), 1, 0.2, duration);
            drawheight += 4;
        }
        if (isdefined(var_7a1d02c8.script_ent_flag_clear)) {
            print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:xa7>" + var_7a1d02c8.script_ent_flag_clear, (1, 1, 1), 1, 0.2, duration);
            drawheight += 4;
        }
        if (!active) {
            return targetstructs;
        }
        if (!isdefined(var_7a1d02c8.target) && !isdefined(var_7a1d02c8.script_botchain_goal)) {
            return targetstructs;
        }
        goals = [];
        if (isdefined(var_7a1d02c8.target)) {
            nodes = getnodearray(var_7a1d02c8.target, "<dev string:xb8>");
            if (isdefined(nodes) && nodes.size > 0) {
                goals = arraycombine(goals, nodes, 0, 0);
            }
        }
        if (isdefined(var_7a1d02c8.script_botchain_goal)) {
            nodes = getnodearray(var_7a1d02c8.script_botchain_goal, "<dev string:xc3>");
            if (isdefined(nodes) && nodes.size > 0) {
                goals = arraycombine(goals, nodes, 0, 0);
            }
        }
        if (isdefined(var_7a1d02c8.target)) {
            volumes = getentarray(var_7a1d02c8.target, "<dev string:xb8>");
            if (isdefined(volumes) && volumes.size > 0) {
                goals = arraycombine(goals, volumes, 0, 0);
            }
        }
        if (isdefined(var_7a1d02c8.script_botchain_goal)) {
            volumes = getentarray(var_7a1d02c8.script_botchain_goal, "<dev string:xc3>");
            if (isdefined(volumes) && volumes.size > 0) {
                goals = arraycombine(goals, volumes, 0, 0);
            }
        }
        if (!goals.size) {
            return targetstructs;
        }
        foreach (goal in goals) {
            if (ispathnode(goal)) {
                line(var_7a1d02c8.origin, goal.origin, (0, 1, 0), 1, 0, duration);
                nodecolor = (0, 1, 0);
                if (isdefined(goal.radius)) {
                    circle(goal.origin, goal.radius, (0, 1, 0), 0, 1, duration);
                } else {
                    nodecolor = (1, 0, 0);
                }
                box(goal.origin, (-16, -16, 0), (16, 16, 0), 0, nodecolor, 1, 1, duration);
                continue;
            }
            if (goal.classname === "<dev string:xd8>") {
                maxs = goal getmaxs();
                mins = goal getmins();
                box(goal.origin, mins, maxs, 0, (0, 1, 0), 1, 1, duration);
                line(var_7a1d02c8.origin, goal.origin, (0, 1, 0), 1, 0, duration);
                continue;
            }
            if (goal.variantname === "<dev string:x30>") {
                if (isdefined(goal.radius)) {
                    searchradius = goal.radius;
                } else {
                    print3d(var_7a1d02c8.origin + (0, 0, drawheight), "<dev string:xe4>", (1, 0, 0), 1, 0.2);
                    drawheight += 4;
                }
                circle(goal.origin, searchradius, (0, 1, 0), 0, 1, duration);
                line(var_7a1d02c8.origin, goal.origin, (0, 1, 0), 1, 0, duration);
            }
        }
        return targetstructs;
    }

#/

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x4
// Checksum 0x3abfb65b, Offset: 0x1380
// Size: 0x2bc
function private function_6dfab14f() {
    /#
        level.var_6bdcb369 = [];
        structs = struct::get_array("<dev string:x30>", "<dev string:xf2>");
        targetstructs = [];
        duration = 10;
        viewdistancesq = 3000 * 3000;
        while (true) {
            waitframe(duration);
            var_640db5c0 = getdvarint(#"hash_5bc9f81b4f504592", 0);
            if (!var_640db5c0) {
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
                if (!isdefined(entity.bot.var_7ef83d)) {
                    continue;
                }
                if (isdefined(entity.bot.var_7ef83d.var_886408fc)) {
                    line(entity.origin, entity.bot.var_7ef83d.var_886408fc.origin, (0, 1, 1), 1, 0, duration);
                }
            }
            for (index = 0; index < structs.size; index++) {
                if (distance2dsquared(campos, structs[index].origin) <= viewdistancesq) {
                    targetstructs[index] = function_242fb8c3(structs[index], targetstructs[index], duration);
                }
            }
        }
    #/
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x4
// Checksum 0xf066e09b, Offset: 0x1648
// Size: 0x170
function private function_3438d586() {
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
// Params 1, eflags: 0x4
// Checksum 0x85379c30, Offset: 0x17c0
// Size: 0x44e
function private function_be5afbbf(var_7a1d02c8) {
    self endon(#"hash_382a628dad5ecbb5");
    assert(isdefined(var_7a1d02c8));
    if (!isdefined(var_7a1d02c8.target) && !isdefined(var_7a1d02c8.script_bot_chain_src)) {
        return undefined;
    }
    structs = [];
    if (isdefined(var_7a1d02c8.target)) {
        var_a9f33c86 = struct::get_array(var_7a1d02c8.target);
        if (isdefined(var_a9f33c86) && var_a9f33c86.size) {
            structs = arraycombine(structs, var_a9f33c86, 0, 0);
        }
    }
    if (isdefined(var_7a1d02c8.script_bot_chain_src)) {
        var_a9f33c86 = var_7a1d02c8 namespace_8955127e::get_target_structs("script_bot_chain");
        if (var_a9f33c86.size > 0) {
            structs = arraycombine(structs, var_a9f33c86, 0, 0);
        }
    }
    var_567910e3 = [];
    foreach (struct in structs) {
        if (struct.variantname === "bot_chain") {
            array::add(var_567910e3, struct);
        }
    }
    var_259566d2 = [];
    var_2f9c7313 = [];
    flagarray = [];
    foreach (struct in var_567910e3) {
        if (!isdefined(struct.script_flag_activate) || level flag::get(struct.script_flag_activate)) {
            array::add(var_259566d2, struct);
        }
        if (isdefined(struct.script_flag_activate) && !level flag::get(struct.script_flag_activate)) {
            array::add(var_2f9c7313, struct);
            array::add(flagarray, struct.script_flag_activate);
        }
    }
    if (var_259566d2.size) {
        return array::random(var_259566d2);
    }
    if (var_2f9c7313.size) {
        assert(flagarray.size);
        level flag::wait_till_any(flagarray);
        foreach (struct in var_2f9c7313) {
            assert(isdefined(struct.script_flag_activate));
            if (level flag::get(struct.script_flag_activate)) {
                return struct;
            }
        }
    }
    if (var_567910e3.size > 0) {
        return array::random(var_567910e3);
    }
    return undefined;
}

// Namespace bot_chain/bot_chain
// Params 2, eflags: 0x4
// Checksum 0xb7a2a026, Offset: 0x1c18
// Size: 0x96
function private function_a0649d7c(entity, goal) {
    assert(isdefined(goal));
    if (!isdefined(entity.bot.var_7ef83d)) {
        return false;
    }
    if (isdefined(entity.bot.var_7ef83d.var_a1852e7e) && entity.bot.var_7ef83d.var_a1852e7e == goal) {
        return true;
    }
    return false;
}

// Namespace bot_chain/bot_chain
// Params 2, eflags: 0x4
// Checksum 0x5784fb1b, Offset: 0x1cb8
// Size: 0x25a
function private function_cc8f4e40(goal, bot) {
    assert(isdefined(bot));
    assert(isdefined(goal));
    bots = bot bot::get_friendly_bots();
    arrayremovevalue(bots, bot);
    if (!bot.size) {
        return false;
    }
    if (ispathnode(goal)) {
        foreach (entity in bots) {
            if (function_a0649d7c(entity, goal)) {
                return true;
            }
        }
        return false;
    } else if (goal.classname === "info_volume") {
        foreach (entity in bots) {
            if (function_a0649d7c(entity, goal)) {
                return true;
            }
        }
        return false;
    }
    assert(isvec(goal));
    foreach (entity in bots) {
        if (function_a0649d7c(entity, goal)) {
            return true;
        }
    }
    return false;
}

// Namespace bot_chain/bot_chain
// Params 2, eflags: 0x4
// Checksum 0xaf7366e, Offset: 0x1f20
// Size: 0x4ca
function private function_e77d8382(var_7a1d02c8, bot) {
    assert(isdefined(var_7a1d02c8));
    assert(isdefined(bot));
    if (!isdefined(var_7a1d02c8.target) && !isdefined(var_7a1d02c8.script_botchain_goal)) {
        return var_7a1d02c8;
    }
    assert(isdefined(var_7a1d02c8.target) || isdefined(var_7a1d02c8.script_botchain_goal));
    goals = [];
    if (isdefined(var_7a1d02c8.target)) {
        var_509e07b = getnodearray(var_7a1d02c8.target, "targetname");
        if (isdefined(var_509e07b) && var_509e07b.size) {
            goals = arraycombine(goals, var_509e07b, 0, 0);
        }
    }
    if (isdefined(var_7a1d02c8.script_botchain_goal)) {
        var_509e07b = getnodearray(var_7a1d02c8.script_botchain_goal, "script_botchain_goal");
        if (isdefined(var_509e07b) && var_509e07b.size) {
            goals = arraycombine(goals, var_509e07b, 0, 0);
        }
    }
    if (isdefined(var_7a1d02c8.target)) {
        var_bd55c09d = getentarray(var_7a1d02c8.target, "targetname");
        if (isdefined(var_bd55c09d) && var_bd55c09d.size) {
            goals = arraycombine(goals, var_bd55c09d, 0, 0);
        }
    }
    if (isdefined(var_7a1d02c8.script_botchain_goal)) {
        var_bd55c09d = getentarray(var_7a1d02c8.script_botchain_goal, "script_botchain_goal");
        if (isdefined(var_bd55c09d) && var_bd55c09d.size) {
            goals = arraycombine(goals, var_bd55c09d, 0, 0);
        }
    }
    if (!goals.size) {
        return var_7a1d02c8;
    }
    var_40dfe8e0 = [];
    if (isdefined(self.bot.var_7ef83d.activecolor)) {
        foreach (goal in goals) {
            if (isdefined(goal.script_botchain_color) && goal.script_botchain_color == self.bot.var_7ef83d.activecolor) {
                array::add(var_40dfe8e0, goal);
            }
        }
    }
    if (var_40dfe8e0.size) {
        return var_40dfe8e0;
    }
    var_b0290d00 = [];
    foreach (goal in goals) {
        if (function_cc8f4e40(goal, bot)) {
            array::add(var_b0290d00, goal);
        }
    }
    foreach (goal in var_b0290d00) {
        arrayremovevalue(goals, goal);
    }
    if (goals.size) {
        return goals;
    }
    if (var_b0290d00.size) {
        goals = arraycombine(goals, var_b0290d00, 0, 0);
    }
    return goals;
}

// Namespace bot_chain/bot_chain
// Params 1, eflags: 0x4
// Checksum 0x945d8fbb, Offset: 0x23f8
// Size: 0xd6
function private set_goalradius_based_on_settings(goal) {
    assert(isbot(self) || isvehicle(self));
    assert(isdefined(goal));
    if (isdefined(goal.script_forcegoal) && goal.script_forcegoal) {
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
// Checksum 0xa3b2c97a, Offset: 0x24d8
// Size: 0x3da
function function_63055348(startstruct) {
    structs = array();
    if (isstring(startstruct)) {
        startstruct = struct::get(startstruct);
        assert(isdefined(startstruct));
    } else {
        assert(isdefined(startstruct) && isstruct(startstruct));
    }
    seentargets = array();
    targets = array();
    if (isdefined(startstruct.target)) {
        targets[targets.size] = startstruct.target;
        seentargets[startstruct.target] = 1;
    }
    structs[structs.size] = startstruct;
    while (targets.size > 0) {
        target = targets[0];
        arrayremoveindex(targets, 0);
        targetstructs = struct::get_array(target);
        foreach (struct in targetstructs) {
            structs[structs.size] = struct;
            if (isdefined(struct.target) && !isdefined(seentargets[struct.target])) {
                targets[targets.size] = struct.target;
                seentargets[struct.target] = 1;
            }
        }
    }
    targets = array();
    if (isdefined(startstruct.script_bot_chain_src)) {
        targets[targets.size] = startstruct.script_bot_chain_src;
        seentargets[startstruct.script_bot_chain_src] = 1;
    }
    while (targets.size > 0) {
        target = targets[0];
        arrayremoveindex(targets, 0);
        targetstructs = struct::get_array(target, "script_bot_chain_target");
        foreach (struct in targetstructs) {
            structs[structs.size] = struct;
            if (isdefined(struct.script_bot_chain_src) && !isdefined(seentargets[struct.script_bot_chain_src])) {
                targets[targets.size] = struct.script_bot_chain_src;
                seentargets[struct.script_bot_chain_src] = 1;
            }
        }
    }
    return structs;
}

// Namespace bot_chain/bot_chain
// Params 2, eflags: 0x0
// Checksum 0x43327b54, Offset: 0x28c0
// Size: 0x70c
function function_92ea793e(startstruct, resuming = 0) {
    assert(isbot(self));
    assert(isdefined(self.bot));
    if (isstring(startstruct)) {
        startstruct = struct::get(startstruct);
        assert(isdefined(startstruct));
    } else {
        assert(isdefined(startstruct) && isstruct(startstruct));
    }
    assert(startstruct.variantname == "<dev string:x30>");
    goalent = self isinvehicle() ? self getvehicleoccupied() : self;
    goalent endon(#"death");
    self endon(#"death");
    self notify(#"hash_382a628dad5ecbb5");
    self endon(#"hash_382a628dad5ecbb5");
    debugstart = startstruct;
    if (resuming && isdefined(self.bot.var_7ef83d)) {
        debugstart = self.bot.var_7ef83d.startstruct;
    }
    self.bot.var_7ef83d = new class_8f7edd0a();
    self.bot.var_7ef83d.var_886408fc = startstruct;
    self.bot.var_7ef83d.startstruct = debugstart;
    for (;;) {
        var_886408fc = self.bot.var_7ef83d.var_886408fc;
        goals = function_e77d8382(var_886408fc, self);
        if (!isdefined(goals)) {
            break;
        }
        if (isarray(goals)) {
            goal = array::random(goals);
        } else if (goals == var_886408fc) {
            goal = goals;
        }
        if (ispathnode(goal) || isstruct(goal)) {
            goalent set_goalradius_based_on_settings(goal);
        }
        if (ispathnode(goal)) {
            goalent setgoal(goal, isdefined(goal.script_forcegoal) && goal.script_forcegoal);
        } else if (isstruct(goal)) {
            goalent setgoal(goal.origin, isdefined(goal.script_forcegoal) && goal.script_forcegoal);
        } else {
            goalent setgoal(goal);
        }
        self.bot.var_7ef83d.var_a1852e7e = goal;
        goalent waittill(#"goal");
        if (isdefined(var_886408fc.script_notify)) {
            self notify(var_886408fc.script_notify);
        }
        if (isdefined(goal.script_botchain_color)) {
            self.bot.var_7ef83d.activecolor = goal.script_botchain_color;
        }
        if (isdefined(var_886408fc.script_flag_set)) {
            level flag::set(var_886408fc.script_flag_set);
        }
        if (isdefined(var_886408fc.script_flag_clear)) {
            level flag::set(var_886408fc.script_flag_clear);
        }
        if (isdefined(var_886408fc.script_ent_flag_set)) {
            if (!self flag::exists(var_886408fc.script_ent_flag_set)) {
                assertmsg("<dev string:xfe>" + var_886408fc.script_ent_flag_set + "<dev string:x118>");
            }
            self flag::set(var_886408fc.script_ent_flag_set);
        }
        if (isdefined(var_886408fc.script_ent_flag_clear)) {
            if (!self flag::exists(var_886408fc.script_ent_flag_clear)) {
                assertmsg("<dev string:x12e>" + var_886408fc.script_ent_flag_clear + "<dev string:x118>");
            }
            self flag::clear(var_886408fc.script_ent_flag_clear);
        }
        if (isdefined(var_886408fc.script_flag_wait)) {
            level flag::wait_till(var_886408fc.script_flag_wait);
        }
        if (isdefined(var_886408fc.script_aigroup)) {
            if (isdefined(level._ai_group[var_886408fc.script_aigroup])) {
                spawner::waittill_ai_group_cleared(var_886408fc.script_aigroup);
            }
        }
        var_886408fc util::script_delay();
        var_1c9d11b3 = function_be5afbbf(var_886408fc);
        /#
            array::add(level.var_6bdcb369, var_886408fc, 0);
        #/
        if (!isdefined(var_1c9d11b3)) {
            break;
        }
        self.bot.var_7ef83d.var_886408fc = var_1c9d11b3;
    }
    self function_cd3d3573();
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x0
// Checksum 0xa7e93a94, Offset: 0x2fd8
// Size: 0x8c
function function_dda3d64() {
    assert(isbot(self));
    if (isdefined(self.bot.var_7ef83d) && isdefined(self.bot.var_7ef83d.var_886408fc)) {
        self thread function_92ea793e(self.bot.var_7ef83d.var_886408fc, 1);
    }
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x0
// Checksum 0xd6b0f5fe, Offset: 0x3070
// Size: 0x5e
function function_cd3d3573() {
    assert(isbot(self));
    if (isdefined(self.bot.var_7ef83d)) {
        self.bot.var_7ef83d = undefined;
    }
    self notify(#"hash_382a628dad5ecbb5");
}

// Namespace bot_chain/bot_chain
// Params 0, eflags: 0x0
// Checksum 0xc04d6542, Offset: 0x30d8
// Size: 0x48
function function_3a0e73ad() {
    assert(isbot(self));
    if (isdefined(self.bot.var_7ef83d)) {
        return true;
    }
    return false;
}

