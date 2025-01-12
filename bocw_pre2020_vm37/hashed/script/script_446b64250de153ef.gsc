#using script_309ce7f5a9a023de;
#using script_644007a8c3885fc;

#namespace namespace_2d440395;

// Namespace namespace_2d440395/namespace_2d440395
// Params 0, eflags: 0x2
// Checksum 0x84641c06, Offset: 0x70
// Size: 0x14
function autoexec function_88ff61e0() {
    thread function_45a212c0();
}

// Namespace namespace_2d440395/namespace_2d440395
// Params 0, eflags: 0x1 linked
// Checksum 0x51cdae19, Offset: 0x90
// Size: 0xb8
function function_45a212c0() {
    var_a12b4736 = &item_world_fixup::function_96ff7b88;
    var_d2223309 = &item_world_fixup::function_261ab7f5;
    var_b5014996 = &item_world_fixup::function_19089c75;
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    while (!isdefined(level)) {
        waitframe(1);
    }
    level.var_21f73755 = 1;
}

/#

    // Namespace namespace_2d440395/namespace_2d440395
    // Params 2, eflags: 0x4
    // Checksum 0x823b587c, Offset: 0x150
    // Size: 0x74
    function private function_205a8326(msg, var_9fb99f62) {
        if (isdefined(var_9fb99f62)) {
            println("<dev string:x38>" + msg + "<dev string:x50>" + var_9fb99f62);
            return;
        }
        println("<dev string:x38>" + msg);
    }

    // Namespace namespace_2d440395/namespace_2d440395
    // Params 1, eflags: 0x4
    // Checksum 0x2ea18147, Offset: 0x1d0
    // Size: 0x124
    function private function_48b77dbf(customgame) {
        var_9fb99f62 = "<dev string:x5e>";
        if (!is_true(getgametypesetting(#"wzenablespraycans"))) {
            var_9fb99f62 = "<dev string:x69>" + (isdefined(getgametypesetting(#"wzenablespraycans")) ? getgametypesetting(#"wzenablespraycans") : "<dev string:x81>");
        } else if (customgame) {
            if (gamemodeismode(1)) {
                var_9fb99f62 = "<dev string:x8e>";
            } else if (gamemodeismode(7)) {
                var_9fb99f62 = "<dev string:x9f>";
            }
        }
        function_205a8326("<dev string:xb6>", var_9fb99f62);
    }

#/
