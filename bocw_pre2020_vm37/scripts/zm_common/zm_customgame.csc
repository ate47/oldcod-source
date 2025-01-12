#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace zm_custom;

// Namespace zm_custom/zm_customgame
// Params 0, eflags: 0x2
// Checksum 0x5e456691, Offset: 0xe0
// Size: 0x4
function autoexec function_d776b402() {
    
}

// Namespace zm_custom/zm_customgame
// Params 3, eflags: 0x5 linked
// Checksum 0x96fad84e, Offset: 0x228
// Size: 0x44
function private function_ecc5a0b9(*local_client_num, *player, damage) {
    if (int(damage) == 5) {
        return true;
    }
    return false;
}

// Namespace zm_custom/zm_customgame
// Params 1, eflags: 0x1 linked
// Checksum 0xdfca7e9a, Offset: 0x278
// Size: 0x70
function function_901b751c(var_c9db62d5) {
    if (var_c9db62d5 === "") {
        return undefined;
    }
    setting = getgametypesetting(var_c9db62d5);
    assert(isdefined(setting), "<dev string:x38>" + var_c9db62d5 + "<dev string:x51>");
    return setting;
}

