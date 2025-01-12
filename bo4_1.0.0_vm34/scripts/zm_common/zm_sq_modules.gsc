#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;

#namespace zm_sq_modules;

// Namespace zm_sq_modules/zm_sq_modules
// Params 6, eflags: 0x0
// Checksum 0x37fb4575, Offset: 0xc0
// Size: 0x204
function function_8ab612a3(id, version, var_98b91db6, var_aa2ddcce, var_134869ba, var_7be87474 = 0) {
    if (!isdefined(level.var_289b1288)) {
        callback::on_actor_killed(&function_5e099947);
        if (var_7be87474) {
            callback::on_vehicle_killed(&function_5e099947);
        }
        level.var_289b1288 = [];
    }
    if (isstruct(var_98b91db6)) {
        capture_point = var_98b91db6;
    } else {
        capture_point = struct::get(var_98b91db6, "script_noteworthy");
    }
    var_e3a5299c = {#id:id, #capture_point:capture_point, #origin:capture_point.origin, #active:0, #var_1ce0ded1:var_aa2ddcce, #var_f4718d55:var_134869ba, #var_7be87474:var_7be87474};
    level.var_289b1288[id] = var_e3a5299c;
    clientfield::register("actor", "soul_capture" + id, version, 1, "int");
    if (var_7be87474) {
        clientfield::register("vehicle", "soul_capture" + id, version, 1, "int");
    }
}

// Namespace zm_sq_modules/zm_sq_modules
// Params 1, eflags: 0x0
// Checksum 0xfff8cad7, Offset: 0x2d0
// Size: 0x42
function function_b4f7eda8(id) {
    var_e3a5299c = level.var_289b1288[id];
    if (!isdefined(var_e3a5299c)) {
        return;
    }
    var_e3a5299c.active = 1;
}

// Namespace zm_sq_modules/zm_sq_modules
// Params 1, eflags: 0x0
// Checksum 0x5d6d4f3b, Offset: 0x320
// Size: 0x6a
function function_c39c525(id) {
    var_e3a5299c = level.var_289b1288[id];
    if (!isdefined(var_e3a5299c)) {
        return;
    }
    playsoundatposition(#"hash_21967fb66e85ac4e", var_e3a5299c.origin);
    var_e3a5299c.active = 0;
}

// Namespace zm_sq_modules/zm_sq_modules
// Params 1, eflags: 0x4
// Checksum 0xd76a673d, Offset: 0x398
// Size: 0x174
function private function_5e099947(params) {
    if (self.is_exploding !== 1 && isdefined(params.eattacker) && params.eattacker.classname === "worldspawn") {
        return;
    }
    foreach (var_e3a5299c in level.var_289b1288) {
        if (!var_e3a5299c.active) {
            continue;
        }
        if (isvehicle(self) && !var_e3a5299c.var_7be87474) {
            continue;
        }
        if ([[ var_e3a5299c.var_1ce0ded1 ]](var_e3a5299c.capture_point, self)) {
            [[ var_e3a5299c.var_f4718d55 ]](var_e3a5299c.capture_point, self);
            self clientfield::set("soul_capture" + var_e3a5299c.id, 1);
            break;
        }
    }
}

