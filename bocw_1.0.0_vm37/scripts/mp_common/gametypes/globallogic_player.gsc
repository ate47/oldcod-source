#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x6
// Checksum 0x542b6793, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"globallogic_player", &preinit, undefined, undefined, undefined);
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x4
// Checksum 0x45a97bec, Offset: 0xc8
// Size: 0x3c
function private preinit() {
    level.var_aadc08f8 = &function_4b7bb02c;
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xdad06004, Offset: 0x110
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
// Params 0, eflags: 0x0
// Checksum 0xa47a5a63, Offset: 0x168
// Size: 0x2c
function on_player_disconnect() {
    if (sessionmodeismultiplayergame()) {
        uploadstats();
    }
}

