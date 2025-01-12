#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;

#namespace character_banter;

// Namespace character_banter/character_banter
// Params 0, eflags: 0x6
// Checksum 0x9a43b089, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"character_banter", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace character_banter/character_banter
// Params 0, eflags: 0x5 linked
// Checksum 0x85e48282, Offset: 0xd0
// Size: 0x50
function private function_70a657d8() {
    callback::on_joined_team(&on_joined_team);
    callback::on_disconnect(&on_player_disconnect);
    level.var_8dcd4dc8 = [];
}

// Namespace character_banter/character_banter
// Params 1, eflags: 0x1 linked
// Checksum 0xa534722a, Offset: 0x128
// Size: 0xbc
function on_joined_team(*params) {
    if (!isdefined(level.var_8dcd4dc8)) {
        return;
    }
    players = level.var_8dcd4dc8[self.team];
    if (!isarray(players)) {
        if (!isdefined(players)) {
            level.var_8dcd4dc8[self.team] = array(self);
        }
        return;
    }
    arrayinsert(players, self, randomint(players.size + 1));
}

// Namespace character_banter/character_banter
// Params 0, eflags: 0x1 linked
// Checksum 0x78f8fe6f, Offset: 0x1f0
// Size: 0x9c
function on_player_disconnect() {
    if (!isdefined(level.var_8dcd4dc8)) {
        return;
    }
    players = level.var_8dcd4dc8[self.team];
    if (getplayers(self.team).size <= 1) {
        level.var_8dcd4dc8[self.team] = [];
        return;
    }
    if (isarray(players)) {
        arrayremovevalue(players, self);
    }
}

// Namespace character_banter/character_banter
// Params 0, eflags: 0x1 linked
// Checksum 0x844d362f, Offset: 0x298
// Size: 0x1d0
function start() {
    if (!isdefined(level.var_8dcd4dc8)) {
        return;
    }
    if (level.maxteamplayers < 2) {
        return;
    }
    level endon(#"stop_banter");
    globallogic::waitforplayers();
    lookup = function_bb3ec038();
    var_8dcd4dc8 = [];
    while (true) {
        foreach (team, players in level.var_8dcd4dc8) {
            if (isarray(players) && players.size > 1) {
                foreach (player in players) {
                    if (isdefined(player) && player function_4d9b2d83(players, lookup)) {
                        level.var_8dcd4dc8[team] = 1;
                        break;
                    }
                }
                waitframe(1);
            }
        }
        waitframe(1);
    }
}

// Namespace character_banter/character_banter
// Params 0, eflags: 0x1 linked
// Checksum 0x74f0d00f, Offset: 0x470
// Size: 0xfe
function function_bb3ec038() {
    lookup = [];
    rowcount = tablelookuprowcount(#"hash_5ec1825aeab754a2");
    for (i = 0; i < rowcount; i++) {
        row = tablelookuprow(#"hash_5ec1825aeab754a2", i);
        player1 = row[0];
        player2 = row[1];
        if (!isdefined(lookup[player1])) {
            lookup[player1] = [];
        }
        banters = lookup[player1];
        if (!isdefined(banters[player2])) {
            banters[player2] = 0;
        }
        banters[player2]++;
    }
    return lookup;
}

// Namespace character_banter/character_banter
// Params 2, eflags: 0x1 linked
// Checksum 0xc5b408a3, Offset: 0x578
// Size: 0x1d0
function function_4d9b2d83(players, lookup) {
    if (!self isonground()) {
        return false;
    }
    assetname = self getmpdialogname();
    if (!isdefined(assetname)) {
        return false;
    }
    banters = lookup[assetname];
    if (!isdefined(banters) || banters.size <= 0) {
        return false;
    }
    foreach (player in players) {
        if (!isdefined(player) || player == self || !player isonground() || distancesquared(self.origin, player.origin) > 1000000) {
            continue;
        }
        var_d8c635a4 = player getmpdialogname();
        if (!isdefined(var_d8c635a4)) {
            continue;
        }
        var_a9f3e2d4 = banters[player getmpdialogname()];
        if (isdefined(var_a9f3e2d4)) {
            self function_18aba49d(1, undefined, player);
            return true;
        }
    }
    return false;
}

// Namespace character_banter/character_banter
// Params 0, eflags: 0x1 linked
// Checksum 0xa8964ca9, Offset: 0x750
// Size: 0x42
function stop() {
    if (level.prematchperiod > 10) {
        wait level.prematchperiod - 10;
    }
    level notify(#"stop_banter");
    level.var_8dcd4dc8 = undefined;
}

