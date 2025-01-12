#using script_3a704cbcf4081bfb;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace archetype_mimic;

// Namespace archetype_mimic/archetype_mimic
// Params 0, eflags: 0x6
// Checksum 0xa832ad8d, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"archetype_mimic", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace archetype_mimic/archetype_mimic
// Params 0, eflags: 0x1 linked
// Checksum 0x3853a688, Offset: 0x128
// Size: 0x94
function function_70a657d8() {
    if (!isarchetypeloaded(#"mimic")) {
        return;
    }
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function(#"mimic", &function_9e93acd1);
    mimic_prop_spawn::init();
    /#
        function_b2616fd7();
    #/
}

// Namespace archetype_mimic/archetype_mimic
// Params 0, eflags: 0x1 linked
// Checksum 0xbe4d5629, Offset: 0x1c8
// Size: 0x3c
function function_9e93acd1() {
    function_5c843fec();
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
}

// Namespace archetype_mimic/archetype_mimic
// Params 0, eflags: 0x5 linked
// Checksum 0x325b6f0c, Offset: 0x210
// Size: 0x32
function private function_5c843fec() {
    blackboard::createblackboardforentity(self);
    self.___archetypeonanimscriptedcallback = &function_91dbc944;
}

// Namespace archetype_mimic/archetype_mimic
// Params 1, eflags: 0x5 linked
// Checksum 0x1682d1f0, Offset: 0x250
// Size: 0x2c
function private function_91dbc944(entity) {
    entity.__blackboard = undefined;
    entity function_5c843fec();
}

// Namespace archetype_mimic/archetype_mimic
// Params 0, eflags: 0x1 linked
// Checksum 0xb119827b, Offset: 0x288
// Size: 0x6c
function registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_ce7cc822));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2d48c1194e87de26", &function_ce7cc822);
}

// Namespace archetype_mimic/archetype_mimic
// Params 1, eflags: 0x1 linked
// Checksum 0x51d5be97, Offset: 0x300
// Size: 0x18a
function function_ce7cc822(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    var_ff38566a = lengthsquared(entity.enemy getvelocity());
    var_17c3916f = function_a3f6cdac(100);
    if (var_ff38566a < function_a3f6cdac(175)) {
        var_17c3916f = function_a3f6cdac(190);
    }
    if (!is_true(level.intermission)) {
        if (distancesquared(entity.origin, entity.enemy.origin) > var_17c3916f) {
            return false;
        }
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

/#

    // Namespace archetype_mimic/archetype_mimic
    // Params 0, eflags: 0x0
    // Checksum 0xbcafab55, Offset: 0x498
    // Size: 0x2d4
    function function_b2616fd7() {
        function_5ac4dc99(#"hash_63d887d4b23cb6e", "<dev string:x38>");
        function_cd140ee9(#"hash_63d887d4b23cb6e", &function_c19802);
        util::add_debug_command("<dev string:x3c>");
        util::add_debug_command("<dev string:x66>");
        util::add_debug_command("<dev string:x90>" + "<dev string:xac>" + "<dev string:xbf>" + "<dev string:xc6>" + "<dev string:xee>");
        util::add_debug_command("<dev string:x90>" + "<dev string:xf3>" + "<dev string:xbf>" + "<dev string:x107>" + "<dev string:xee>");
        util::add_debug_command("<dev string:x90>" + "<dev string:x130>" + "<dev string:xbf>" + "<dev string:x144>" + "<dev string:xee>");
        util::add_debug_command("<dev string:x90>" + "<dev string:x16d>" + "<dev string:xbf>" + "<dev string:x191>" + "<dev string:xee>");
        util::add_debug_command("<dev string:x90>" + "<dev string:x1c4>" + "<dev string:xbf>" + "<dev string:x1db>" + "<dev string:xee>");
        util::add_debug_command("<dev string:x90>" + "<dev string:x206>" + "<dev string:xbf>" + "<dev string:x21c>" + "<dev string:xee>");
        util::add_debug_command("<dev string:x90>" + "<dev string:x247>" + "<dev string:xbf>" + "<dev string:x262>" + "<dev string:xee>");
        util::add_debug_command("<dev string:x292>" + "<dev string:x2af>" + "<dev string:xbf>" + "<dev string:x2c4>" + "<dev string:xee>");
        util::add_debug_command("<dev string:x292>" + "<dev string:x2df>" + "<dev string:xbf>" + "<dev string:x2f3>" + "<dev string:xee>");
    }

    // Namespace archetype_mimic/archetype_mimic
    // Params 1, eflags: 0x0
    // Checksum 0x56e4ee35, Offset: 0x778
    // Size: 0x19c
    function function_c19802(dvar) {
        switch (dvar.value) {
        case #"hash_31323c2655b560b7":
            level thread function_f543fa16();
            break;
        case #"hash_252ab6031286d4fb":
            level thread function_a42f6839();
            break;
        case #"hash_7369a81a09f4035":
            level thread function_d70b96a8();
            break;
        case #"hash_22d6e20b320c956b":
            level.var_bce8fb65 = !is_true(level.var_bce8fb65);
            break;
        case #"hash_721abb229b429d1d":
            level thread function_37c34605();
            break;
        case #"hash_28efc47a2a09bfd4":
            function_9bf1a66b();
            break;
        case #"hash_10ab0e022e9a6697":
            mimic_prop_spawn::function_fd24f982();
            break;
        case 0:
            return;
        }
        setdvar(#"hash_63d887d4b23cb6e", "<dev string:x38>");
    }

    // Namespace archetype_mimic/archetype_mimic
    // Params 0, eflags: 0x0
    // Checksum 0xec164808, Offset: 0x920
    // Size: 0x1fa
    function function_f543fa16() {
        level.var_f543fa16 = !is_true(level.var_f543fa16);
        if (!is_true(level.var_f543fa16)) {
            level notify(#"hash_76be9a1cc0c723d2");
            return;
        }
        level endon(#"hash_76be9a1cc0c723d2");
        while (true) {
            var_2a1f535d = mimic_prop_spawn::function_2e8c33f6();
            foreach (var_1386d828 in var_2a1f535d) {
                color = is_true(var_1386d828.var_3a3cdab8) ? (1, 0, 0) : (0, 1, 1);
                debugstar(var_1386d828.origin, 1, color);
                line(var_1386d828.origin, var_1386d828.origin + (0, 0, 900), color);
                if (is_true(var_1386d828.var_3a3cdab8)) {
                    print3d(var_1386d828.origin + (0, 0, 48), "<dev string:x30d>", color);
                }
            }
            waitframe(1);
        }
    }

    // Namespace archetype_mimic/archetype_mimic
    // Params 0, eflags: 0x0
    // Checksum 0x244b4c41, Offset: 0xb28
    // Size: 0x1ec
    function function_a42f6839() {
        self notify("<dev string:x317>");
        self endon("<dev string:x317>");
        waitframe(1);
        player = getplayers()[0];
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        queryresult = positionquery_source_navigation(trace[#"position"], 0, 1000, 256, 128);
        if (!queryresult.data.size) {
            return;
        }
        var_a6fe91fd = mimic_prop_spawn::function_c928b745(queryresult.data, getdvarint(#"hash_1c58dfdfc2778462", 1));
        for (i = 0; i < getdvarint(#"hash_6abb2efa700ce9aa", 0); i++) {
            mimic_prop_spawn::function_913ecbbc(var_a6fe91fd);
        }
    }

    // Namespace archetype_mimic/archetype_mimic
    // Params 0, eflags: 0x0
    // Checksum 0x17c5fc4a, Offset: 0xd20
    // Size: 0x1ac
    function function_d70b96a8() {
        self notify("<dev string:x32b>");
        self endon("<dev string:x32b>");
        waitframe(1);
        player = getplayers()[0];
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        var_a6fe91fd = mimic_prop_spawn::function_4cc90533(trace[#"position"], 1000, getdvarint(#"hash_1c58dfdfc2778462", 1));
        for (i = 0; i < getdvarint(#"hash_6abb2efa700ce9aa", 0); i++) {
            mimic_prop_spawn::function_913ecbbc(var_a6fe91fd);
        }
    }

    // Namespace archetype_mimic/archetype_mimic
    // Params 0, eflags: 0x0
    // Checksum 0x961e6b, Offset: 0xed8
    // Size: 0x142
    function function_37c34605() {
        level.var_65602da9 = !is_true(level.var_76006b18);
        if (!is_true(level.var_65602da9)) {
            level notify(#"hash_640b8f0797cedfcc");
            return;
        }
        level endon(#"hash_640b8f0797cedfcc");
        spawn_points = struct::get_array("<dev string:x33f>");
        while (true) {
            foreach (point in spawn_points) {
                debugstar(point.origin, 5, (1, 0, 0));
            }
            waitframe(5);
        }
    }

    // Namespace archetype_mimic/archetype_mimic
    // Params 0, eflags: 0x0
    // Checksum 0x5de1b8aa, Offset: 0x1028
    // Size: 0x54
    function function_9bf1a66b() {
        pause = !is_true(level.var_dbc40a0b);
        level.var_dbc40a0b = pause;
        mimic_prop_spawn::function_4237218(pause);
    }

#/
