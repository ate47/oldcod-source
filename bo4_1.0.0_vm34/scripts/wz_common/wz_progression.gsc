#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\wz_common\gametypes\warzone;

#namespace wz_progression;

// Namespace wz_progression/wz_progression
// Params 2, eflags: 0x0
// Checksum 0xd86cf878, Offset: 0x98
// Size: 0xb4
function player_killed(attacker, victim) {
    attacker addrankxpvalue("kill", 1);
    var_5280054c = warzone::function_88b34120(undefined)[#"alive_players"];
    if (var_5280054c < 5) {
        victim stats::function_b48aa4e(#"top5", 1);
        victim addrankxpvalue("top5", 2);
    }
}

// Namespace wz_progression/wz_progression
// Params 1, eflags: 0x0
// Checksum 0xcd771c5, Offset: 0x158
// Size: 0xa0
function function_b49628df(team) {
    foreach (player in getplayers(team)) {
        player addrankxpvalue("win", 3);
    }
}

