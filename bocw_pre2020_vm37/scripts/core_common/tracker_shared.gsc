#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace tracker;

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x0
// Checksum 0xdde286ac, Offset: 0xc0
// Size: 0x84
function init_shared() {
    register_clientfields();
    level.trackerperk = spawnstruct();
    level.var_c8241070 = &function_c8241070;
    thread function_a7e7bda0();
    level.trackerperk.var_75492b09 = [];
    callback::on_spawned(&onplayerspawned);
}

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x0
// Checksum 0x2401828d, Offset: 0x150
// Size: 0x2c
function register_clientfields() {
    clientfield::register_clientuimodel("huditems.isExposedOnMinimap", 1, 1, "int");
}

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x0
// Checksum 0xcb33e65e, Offset: 0x188
// Size: 0x24
function onplayerspawned() {
    self clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 0);
}

// Namespace tracker/tracker_shared
// Params 2, eflags: 0x0
// Checksum 0xd791028e, Offset: 0x1b8
// Size: 0x16a
function function_c8241070(player, weapon) {
    if (!isdefined(level.trackerperk.var_75492b09[player.clientid])) {
        level.trackerperk.var_75492b09[player.clientid] = spawnstruct();
    }
    level.trackerperk.var_75492b09[player.clientid].var_80ec1137 = gettime();
    level.trackerperk.var_75492b09[player.clientid].var_2e0b3c25 = player.origin;
    level.trackerperk.var_75492b09[player.clientid].var_2672a259 = weapon;
    level.trackerperk.var_75492b09[player.clientid].var_851de005 = player;
    level.trackerperk.var_75492b09[player.clientid].expiretime = gettime() + float(getdvarint(#"hash_6f3f10e68d2fedba", 0)) / 1000;
}

// Namespace tracker/tracker_shared
// Params 1, eflags: 0x0
// Checksum 0xe10e3029, Offset: 0x330
// Size: 0x1a2
function function_43084f6c(player) {
    if (level.teambased) {
        otherteam = util::getotherteam(player.team);
        foreach (var_f53fe24c in getplayers(otherteam)) {
            if (var_f53fe24c function_d210981e(player.origin)) {
                return true;
            }
        }
    } else {
        enemies = getplayers();
        foreach (enemy in enemies) {
            if (enemy == player) {
                continue;
            }
            if (enemy function_d210981e(player.origin)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace tracker/tracker_shared
// Params 1, eflags: 0x0
// Checksum 0x16d023a4, Offset: 0x4e0
// Size: 0x62
function function_2c77961d(player) {
    if (!isdefined(level.trackerperk.var_75492b09[player.clientid])) {
        return false;
    }
    if (gettime() > level.trackerperk.var_75492b09[player.clientid].expiretime) {
        return false;
    }
    return true;
}

// Namespace tracker/tracker_shared
// Params 1, eflags: 0x0
// Checksum 0x150843ca, Offset: 0x550
// Size: 0xb0
function function_796e0334(player) {
    if (1 && globallogic_player::function_eddea888(player)) {
        return true;
    }
    if (1 && globallogic_player::function_43084f6c(player)) {
        return true;
    }
    if (1 && function_2c77961d(player)) {
        return true;
    }
    if (1 && globallogic_player::function_ce33e204(player)) {
        return true;
    }
    return false;
}

// Namespace tracker/tracker_shared
// Params 0, eflags: 0x0
// Checksum 0x40878c14, Offset: 0x608
// Size: 0x1c0
function function_a7e7bda0() {
    if (getgametypesetting(#"hardcoremode")) {
        return;
    }
    while (true) {
        foreach (player in level.players) {
            if (!isdefined(player)) {
                continue;
            }
            if (!player hasperk(#"specialty_detectedicon")) {
                continue;
            }
            if (function_796e0334(player)) {
                if (!isdefined(player.var_7241f6e3)) {
                    player.var_7241f6e3 = gettime() + 100;
                }
                if (player.var_7241f6e3 <= gettime()) {
                    player clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 1);
                    player.var_99811216 = gettime() + 100;
                }
                continue;
            }
            if (isdefined(player.var_99811216) && gettime() > player.var_99811216 && player clientfield::get_player_uimodel("huditems.isExposedOnMinimap")) {
                player clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 0);
                player.var_7241f6e3 = undefined;
            }
        }
        wait 0.1;
    }
}

