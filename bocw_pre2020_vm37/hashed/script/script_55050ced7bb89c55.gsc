#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_e8a84861;

// Namespace namespace_e8a84861/namespace_e8a84861
// Params 0, eflags: 0x6
// Checksum 0x63cb591a, Offset: 0xc0
// Size: 0x34
function private autoexec __init__system__() {
    system::register(#"hash_6f250debec542071", undefined, undefined, &finalize, undefined);
}

// Namespace namespace_e8a84861/namespace_e8a84861
// Params 0, eflags: 0x1 linked
// Checksum 0x5cae99ea, Offset: 0x100
// Size: 0x44
function finalize() {
    if (!getdvarint(#"hash_6653ddb198320c00", 1)) {
        return;
    }
    level thread function_40954450();
}

// Namespace namespace_e8a84861/namespace_e8a84861
// Params 0, eflags: 0x1 linked
// Checksum 0x9f973bd, Offset: 0x150
// Size: 0x1c0
function function_40954450() {
    var_a27d21ea = struct::get_array("gondola_pivot", "script_noteworthy");
    foreach (pivot in var_a27d21ea) {
        if (!isdefined(pivot.radius)) {
            pivot.radius = 128;
        }
        pivot.pivot = util::spawn_model(#"tag_origin", pivot.origin, pivot.angles);
        waitframe(1);
    }
    var_5a169077 = getentarray("gondola_car", "targetname");
    foreach (gondola in var_5a169077) {
        gondola setmovingplatformenabled(1, 0);
        gondola thread function_58c35c6d();
    }
}

// Namespace namespace_e8a84861/namespace_e8a84861
// Params 0, eflags: 0x1 linked
// Checksum 0x21f11b3b, Offset: 0x318
// Size: 0x256
function function_58c35c6d() {
    level endon(#"game_ended");
    self endon(#"death");
    last_pos = struct::get(self.target);
    while (true) {
        var_3148a2c7 = struct::get(last_pos.target);
        last_pos = var_3148a2c7;
        pivot = var_3148a2c7.pivot;
        speed = 400;
        if (is_true(var_3148a2c7.landing)) {
            speed = 64;
        }
        time = distance(self.origin, var_3148a2c7.origin) / getdvarint(#"hash_4b21c6a583e816b0", speed);
        if (time == 0) {
            continue;
        } else if (isdefined(pivot)) {
            speed = 64;
            time = 6.28318 * var_3148a2c7.radius * -180 / 360 / getdvarint(#"hash_636ad03fc0d939aa", speed);
            if (time < 0) {
                time *= -1;
            }
            self linkto(pivot);
            pivot rotateyaw(-180, time);
            wait time;
            self unlink();
            continue;
        }
        self rotateto(var_3148a2c7.angles, time);
        self moveto(var_3148a2c7.origin, time);
        wait time;
    }
}

