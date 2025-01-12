#using scripts\core_common\callbacks_shared;
#using scripts\core_common\map;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace oob;

// Namespace oob/oow
// Params 0, eflags: 0x6
// Checksum 0x40a50d52, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"out_of_world", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace oob/oow
// Params 0, eflags: 0x5 linked
// Checksum 0xf5500d28, Offset: 0xf8
// Size: 0x64
function private function_70a657d8() {
    level.oow = {#height_min:-2147483647, #height_max:2147483647};
    callback::on_game_playing(&on_game_playing);
}

// Namespace oob/oow
// Params 0, eflags: 0x1 linked
// Checksum 0x67263008, Offset: 0x168
// Size: 0x154
function on_game_playing() {
    var_65792f8b = map::get_script_bundle();
    if (isdefined(var_65792f8b)) {
        if (!isdefined(var_65792f8b.var_aa91547b)) {
            var_65792f8b.var_aa91547b = 0;
        }
        if (!isdefined(var_65792f8b.var_eac026ad)) {
            var_65792f8b.var_eac026ad = 0;
        }
        if (var_65792f8b.var_aa91547b != 0 || var_65792f8b.var_eac026ad != 0) {
            level.oow.height_min = isdefined(var_65792f8b.var_aa91547b) ? var_65792f8b.var_aa91547b : 0;
            level.oow.height_max = isdefined(var_65792f8b.var_eac026ad) ? var_65792f8b.var_eac026ad : 0;
            assert(level.oow.height_min <= level.oow.height_max);
            if (!(level.oow.height_min <= level.oow.height_max)) {
                return;
            }
        }
    }
    level thread function_e8f5803d();
}

// Namespace oob/oow
// Params 0, eflags: 0x1 linked
// Checksum 0x40851e5d, Offset: 0x2c8
// Size: 0x138
function function_e8f5803d() {
    while (true) {
        wait 5;
        foreach (team, _ in level.teams) {
            foreach (player in function_a1ef346b(team)) {
                if (!isdefined(player)) {
                    continue;
                }
                if (player function_eb7eb3d4()) {
                    kill_entity(player);
                }
            }
        }
    }
}

// Namespace oob/oow
// Params 0, eflags: 0x1 linked
// Checksum 0xfdab64d2, Offset: 0x408
// Size: 0x9e
function function_eb7eb3d4() {
    if (!isdefined(self)) {
        return false;
    }
    /#
        if (self isinmovemode("<dev string:x38>", "<dev string:x3f>")) {
            return false;
        }
    #/
    height = self.origin[2];
    if (level.oow.height_min > height || level.oow.height_max < height) {
        return true;
    }
    return false;
}

// Namespace oob/oow
// Params 1, eflags: 0x1 linked
// Checksum 0x17bd4db9, Offset: 0x4b0
// Size: 0x1dc
function kill_entity(entity) {
    if (isplayer(entity) && entity isinvehicle()) {
        vehicle = entity getvehicleoccupied();
        occupants = vehicle getvehoccupants();
        foreach (occupant in occupants) {
            occupant unlink();
        }
        if (!is_false(vehicle.allowdeath)) {
            vehicle dodamage(vehicle.health + 10000, vehicle.origin, undefined, undefined, "none", "MOD_EXPLOSIVE", 8192);
        }
    }
    entity dodamage(entity.health + 10000, entity.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT", 8192 | 16384);
    if (isplayer(entity)) {
        entity suicide();
    }
}

