#using script_309ce7f5a9a023de;
#using script_644007a8c3885fc;

#namespace namespace_2d440395;

// Namespace namespace_2d440395/namespace_2d440395
// Params 0, eflags: 0x2
// Checksum 0x13c37ec3, Offset: 0x70
// Size: 0x14
function autoexec function_88ff61e0() {
    thread function_45a212c0();
}

// Namespace namespace_2d440395/namespace_2d440395
// Params 0, eflags: 0x0
// Checksum 0x25f020e5, Offset: 0x90
// Size: 0x70
function function_45a212c0() {
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
    // Checksum 0x3ae3b787, Offset: 0x108
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
    // Checksum 0x16d85a48, Offset: 0x188
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
