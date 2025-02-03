#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zipline_player;

// Namespace zipline_player/zipline_player
// Params 0, eflags: 0x6
// Checksum 0x814b2c6e, Offset: 0x120
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zipline_player", &preinit, undefined, undefined, undefined);
}

// Namespace zipline_player/zipline_player
// Params 0, eflags: 0x4
// Checksum 0xb6bfbc78, Offset: 0x168
// Size: 0x10a
function private preinit() {
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

// Namespace zipline_player/zipline_player
// Params 1, eflags: 0x0
// Checksum 0xc78ae78c, Offset: 0x280
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

// Namespace zipline_player/zipline_player
// Params 1, eflags: 0x0
// Checksum 0xf8cb579d, Offset: 0x3a8
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

// Namespace zipline_player/zipline_player
// Params 1, eflags: 0x0
// Checksum 0x1753f8f9, Offset: 0x480
// Size: 0x1dc
function function_5abc3f1f(trigger_info) {
    player = trigger_info.activator;
    if (!isplayer(player)) {
        return;
    }
    if (player isziplining()) {
        return;
    }
    if (!player isinair()) {
        return;
    }
    velocity = player getvelocity();
    var_aba19503 = self.var_5da09c55.endstruct.origin - self.var_5da09c55.origin;
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
    player function_827228db(self.var_5da09c55.endstruct.origin, self.var_5da09c55.origin, 1);
}

// Namespace zipline_player/zipline_player
// Params 1, eflags: 0x0
// Checksum 0x16884635, Offset: 0x668
// Size: 0x8a
function function_2a1bd467(struct) {
    endstruct = struct::get(struct.target, "targetname");
    if (!isdefined(endstruct)) {
        return;
    }
    level.var_8e1ba65f[struct.target] = struct;
    struct.endstruct = endstruct;
    struct.inuse = 0;
    struct.trigger = function_e415c864(struct);
}

// Namespace zipline_player/zipline_player
// Params 2, eflags: 0x0
// Checksum 0xc50859db, Offset: 0x700
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

// Namespace zipline_player/zipline_player
// Params 1, eflags: 0x0
// Checksum 0xffe03635, Offset: 0x780
// Size: 0x84
function zipline_use(trigger_info) {
    player = trigger_info.activator;
    var_5da09c55 = self.var_5da09c55;
    if (!function_f8e9f7d7(player, var_5da09c55)) {
        return;
    }
    player function_827228db(var_5da09c55.endstruct.origin, var_5da09c55.origin, 0);
}

// Namespace zipline_player/zipline_player
// Params 3, eflags: 0x0
// Checksum 0x431f81f7, Offset: 0x810
// Size: 0xca
function function_827228db(target, start, inair) {
    var_b527f10 = spawn("script_model", self.origin);
    var_b527f10 setmodel("tag_origin");
    var_b527f10 setowner(self);
    var_b527f10 setweapon(level.var_58e84ce5);
    self function_ac5595ff(target, start, inair, var_b527f10);
    self.var_b527f10 = var_b527f10;
}

/#

    // Namespace zipline_player/zipline_player
    // Params 0, eflags: 0x0
    // Checksum 0xc81bdbf6, Offset: 0x8e8
    // Size: 0x364
    function function_be9add5() {
        if (!getdvarint(#"hash_13a9fb4be8e86e13", 0)) {
            return;
        }
        ziplines = level.var_e02fab68;
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");
        while (getdvarint(#"hash_13a9fb4be8e86e13", 0)) {
            waitframe(1);
            foreach (zipline in ziplines) {
                var_86660d95 = zipline.origin;
                print3d(var_86660d95 + (0, 0, 16), zipline.targetname, (0, 1, 0));
                sphere(var_86660d95, 4, (0, 1, 0));
                circle(var_86660d95, 94, (0, 1, 0), 1, 1);
                line(var_86660d95, zipline.endstruct.origin, (0, 1, 0));
                if (isdefined(level.var_94f4ca81)) {
                    foreach (dataset in level.var_94f4ca81.dataset) {
                        foreach (spawn in dataset.spawns) {
                            spawn_origin = spawn.origin;
                            if (distance2dsquared(spawn_origin, var_86660d95) <= 4096) {
                                cylinder(spawn_origin, spawn_origin + (0, 0, 72), 15, (1, 0, 0));
                                sphere(spawn_origin, 4, (1, 0, 0));
                            }
                        }
                    }
                }
            }
        }
    }

#/
