#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace telemetry;

// Namespace telemetry/namespace_f4a96b08
// Params 2, eflags: 0x0
// Checksum 0x43a8f490, Offset: 0x70
// Size: 0x2c
function add_callback(callback_id, callback_func) {
    callback::add_callback(callback_id, callback_func);
}

// Namespace telemetry/namespace_f4a96b08
// Params 2, eflags: 0x0
// Checksum 0xbaa13947, Offset: 0xa8
// Size: 0x7a
function function_98df8818(callback, func) {
    if (!isdefined(level.var_1bebdc8e)) {
        level.var_1bebdc8e = [];
    }
    if (!isdefined(level.var_1bebdc8e[callback])) {
        level.var_1bebdc8e[callback] = [];
    }
    level.var_1bebdc8e[callback][level.var_1bebdc8e[callback].size] = func;
}

// Namespace telemetry/namespace_f4a96b08
// Params 2, eflags: 0x0
// Checksum 0xc63ef414, Offset: 0x130
// Size: 0xc8
function function_18135b72(callback, data) {
    if (!isdefined(level.var_1bebdc8e)) {
        return;
    }
    if (!isdefined(level.var_1bebdc8e[callback])) {
        return;
    }
    if (isdefined(data)) {
        for (i = 0; i < level.var_1bebdc8e[callback].size; i++) {
            thread [[ level.var_1bebdc8e[callback][i] ]](data);
        }
        return;
    }
    for (i = 0; i < level.var_1bebdc8e[callback].size; i++) {
        thread [[ level.var_1bebdc8e[callback][i] ]]();
    }
}

// Namespace telemetry/namespace_f4a96b08
// Params 0, eflags: 0x0
// Checksum 0x8c0ebc8b, Offset: 0x200
// Size: 0x2c
function function_f397069a() {
    while (level.var_d3427749 === gettime()) {
        waitframe(1);
    }
    level.var_d3427749 = gettime();
}

