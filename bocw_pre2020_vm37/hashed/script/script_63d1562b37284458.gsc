#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace namespace_9cf4c697;

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 0, eflags: 0x6
// Checksum 0x5d5980b4, Offset: 0x130
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_182e6e1e0572174a", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 0, eflags: 0x5 linked
// Checksum 0x9d3c5704, Offset: 0x178
// Size: 0x10a
function private function_70a657d8() {
    level.var_e02fab68 = struct::get_array("zipline_start", "script_noteworthy");
    /#
        level thread function_be9add5();
    #/
    level.var_8e1ba65f = [];
    level.var_58e84ce5 = getweapon(#"hash_3089757a990e0f6c");
    foreach (a in level.var_e02fab68) {
        function_2a1bd467(a);
    }
    level.var_e02fab68 = undefined;
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 1, eflags: 0x1 linked
// Checksum 0xb898d3e0, Offset: 0x290
// Size: 0x120
function function_e415c864(var_5da09c55) {
    var_912fa366 = spawn("trigger_radius_use", var_5da09c55.origin + (0, 0, 16), 0, 96, 128);
    var_912fa366.var_5da09c55 = var_5da09c55;
    var_912fa366 triggerignoreteam();
    var_912fa366 setvisibletoall();
    var_912fa366 setteamfortrigger(#"none");
    var_912fa366 setcursorhint("HINT_NOICON");
    hint = #"hash_5ca3696cb6c3bea9";
    var_912fa366 sethintstring(hint);
    var_912fa366 callback::on_trigger(&zipline_use);
    return var_912fa366;
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 1, eflags: 0x0
// Checksum 0xbfdd2966, Offset: 0x3b8
// Size: 0xd0
function function_77fde59c(var_5da09c55) {
    var_912fa366 = spawn("trigger_radius", var_5da09c55.origin + (0, 0, 16), 0, 96, 128);
    var_912fa366.var_5da09c55 = var_5da09c55;
    var_912fa366 triggerignoreteam();
    var_912fa366 setvisibletoall();
    var_912fa366 setteamfortrigger(#"none");
    var_912fa366 callback::on_trigger(&function_5abc3f1f);
    return var_912fa366;
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 1, eflags: 0x1 linked
// Checksum 0x32af14c3, Offset: 0x490
// Size: 0x1dc
function function_5abc3f1f(trigger_info) {
    player = trigger_info.activator;
    if (!isplayer(player)) {
        return;
    }
    if (player function_e128a831()) {
        return;
    }
    if (!player isinair()) {
        return;
    }
    velocity = player getvelocity();
    var_aba19503 = self.var_5da09c55.var_b53569ae.origin - self.var_5da09c55.origin;
    var_aba19503 = vectornormalize(var_aba19503);
    velocitymag = vectordot(var_aba19503, velocity);
    if (velocitymag < getdvarfloat(#"hash_22b8f78d9b451771", 170)) {
        return;
    }
    angles = player getangles();
    forward = anglestoforward(angles);
    if (vectordot(var_aba19503, forward) < getdvarfloat(#"hash_1d72909e619429dc", -1)) {
        return;
    }
    player function_827228db(self.var_5da09c55.var_b53569ae.origin, self.var_5da09c55.origin, 1);
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 1, eflags: 0x1 linked
// Checksum 0xafa503e4, Offset: 0x678
// Size: 0x82
function function_2a1bd467(struct) {
    var_b53569ae = struct::get(struct.target, "targetname");
    level.var_8e1ba65f[struct.target] = struct;
    struct.var_b53569ae = var_b53569ae;
    struct.inuse = 0;
    struct.trigger = function_e415c864(struct);
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 2, eflags: 0x1 linked
// Checksum 0xef6cb801, Offset: 0x708
// Size: 0x76
function function_f8e9f7d7(player, *var_5da09c55) {
    if (is_true(self.laststand)) {
        return false;
    }
    if (var_5da09c55 getstance() == "prone") {
        return false;
    }
    if (!var_5da09c55 function_b59f3ecd()) {
        return false;
    }
    return true;
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 1, eflags: 0x1 linked
// Checksum 0x35b72508, Offset: 0x788
// Size: 0x84
function zipline_use(trigger_info) {
    player = trigger_info.activator;
    var_5da09c55 = self.var_5da09c55;
    if (!function_f8e9f7d7(player, var_5da09c55)) {
        return;
    }
    player function_827228db(var_5da09c55.var_b53569ae.origin, var_5da09c55.origin, 0);
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 3, eflags: 0x1 linked
// Checksum 0x79d4c44d, Offset: 0x818
// Size: 0xdc
function function_827228db(target, start, inair) {
    var_b527f10 = spawn("script_model", self.origin);
    var_b527f10 setmodel("tag_origin");
    var_b527f10 setowner(self);
    var_b527f10 setweapon(level.var_58e84ce5);
    self function_ac5595ff(target, start, inair, var_b527f10);
    self.var_b527f10 = var_b527f10;
    self function_e1241ec();
}

// Namespace namespace_9cf4c697/namespace_9cf4c697
// Params 0, eflags: 0x1 linked
// Checksum 0x39d8061d, Offset: 0x900
// Size: 0x4c
function function_e1241ec() {
    gesture = self gestures::function_c77349d4("gestable_zipline_test");
    self gestures::play_gesture(gesture, undefined, 1);
}

/#

    // Namespace namespace_9cf4c697/namespace_9cf4c697
    // Params 0, eflags: 0x0
    // Checksum 0x8114a64f, Offset: 0x958
    // Size: 0x174
    function function_be9add5() {
        var_387d7e3b = level.var_e02fab68;
        while (getdvarint(#"hash_13a9fb4be8e86e13", 0)) {
            waitframe(1);
            foreach (zipline in var_387d7e3b) {
                var_86660d95 = zipline.origin;
                print3d(var_86660d95 + (0, 0, 16), zipline.targetname, (0, 1, 0));
                sphere(var_86660d95, 4, (0, 1, 0));
                circle(var_86660d95, 24, (0, 1, 0), 1, 1);
                line(var_86660d95, zipline.var_b53569ae.origin, (0, 1, 0));
            }
        }
    }

#/
