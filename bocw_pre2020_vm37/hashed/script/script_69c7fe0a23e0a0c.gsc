#using scripts\core_common\array_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_3206b0a4;

// Namespace namespace_3206b0a4/namespace_3206b0a4
// Params 0, eflags: 0x6
// Checksum 0xc425e169, Offset: 0xc8
// Size: 0x34
function private autoexec __init__system__() {
    system::register(#"hash_2cf4edd9e894548e", undefined, undefined, &finalize, undefined);
}

// Namespace namespace_3206b0a4/namespace_3206b0a4
// Params 0, eflags: 0x1 linked
// Checksum 0x450b1b2f, Offset: 0x108
// Size: 0x7c
function finalize() {
    if (!getdvarint(#"hash_2ab32b7978f04c19", 1)) {
        array::delete_all(getentarray("ski_lift_chair", "targetname"));
        return;
    }
    level thread function_80daa09c();
}

// Namespace namespace_3206b0a4/namespace_3206b0a4
// Params 0, eflags: 0x1 linked
// Checksum 0x8cf79611, Offset: 0x190
// Size: 0x1c0
function function_80daa09c() {
    var_e3d4ea5b = struct::get_array("ski_lift_pivot", "script_noteworthy");
    foreach (pivot in var_e3d4ea5b) {
        if (!isdefined(pivot.radius)) {
            pivot.radius = 128;
        }
        pivot.pivot = util::spawn_model(#"tag_origin", pivot.origin, pivot.angles);
        waitframe(1);
    }
    var_8055df37 = getentarray("ski_lift_chair", "targetname");
    foreach (chair in var_8055df37) {
        chair setmovingplatformenabled(1, 0);
        chair thread function_70c029d9();
    }
}

// Namespace namespace_3206b0a4/namespace_3206b0a4
// Params 0, eflags: 0x1 linked
// Checksum 0x8d26c00d, Offset: 0x358
// Size: 0x216
function function_70c029d9() {
    level endon(#"game_ended");
    self endon(#"death");
    last_pos = struct::get(self.target);
    while (true) {
        var_3148a2c7 = struct::get(last_pos.target);
        last_pos = var_3148a2c7;
        pivot = var_3148a2c7.pivot;
        time = distance(self.origin, var_3148a2c7.origin) / getdvarint(#"hash_4b21c6a583e816b0", 300);
        if (time == 0) {
            continue;
        } else if (isdefined(pivot)) {
            time = 6.28318 * var_3148a2c7.radius * -180 / 360 / getdvarint(#"hash_636ad03fc0d939aa", 64);
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

