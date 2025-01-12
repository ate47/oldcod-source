#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x2
// Checksum 0x37257729, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"globallogic_player", &__init__, undefined, undefined);
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xf29da1a9, Offset: 0xc8
// Size: 0x1e
function __init__() {
    level.var_4df933c4 = &function_fba457e5;
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x0
// Checksum 0x9cf80670, Offset: 0xf0
// Size: 0x4e
function function_fba457e5(weapon) {
    if (!killstreaks::is_killstreak_weapon(weapon)) {
        return true;
    }
    if (killstreaks::is_killstreak_weapon_assist_allowed(weapon)) {
        return true;
    }
    return false;
}

