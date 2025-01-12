#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x6
// Checksum 0x9d138d5d, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"globallogic_player", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x5 linked
// Checksum 0x42749, Offset: 0xc8
// Size: 0x3c
function private function_70a657d8() {
    level.var_aadc08f8 = &function_4b7bb02c;
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0xe8bdf2f6, Offset: 0x110
// Size: 0x4e
function function_4b7bb02c(weapon) {
    if (!killstreaks::is_killstreak_weapon(weapon)) {
        return true;
    }
    if (killstreaks::is_killstreak_weapon_assist_allowed(weapon)) {
        return true;
    }
    return false;
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x2b7e0c0b, Offset: 0x168
// Size: 0x2c
function on_player_disconnect() {
    if (sessionmodeismultiplayergame()) {
        uploadstats();
    }
}

