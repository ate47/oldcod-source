#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;

#namespace hvo;

// Namespace hvo/high_value_operative
// Params 0, eflags: 0x2
// Checksum 0x51e2df3f, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"high_value_operative", &__init__, undefined, undefined);
}

// Namespace hvo/high_value_operative
// Params 0, eflags: 0x0
// Checksum 0xff73f5c9, Offset: 0xe0
// Size: 0x44
function __init__() {
    setdvar(#"hash_35dbebb08d656926", 0);
    callback::on_spawned(&function_304ae53d);
}

// Namespace hvo/high_value_operative
// Params 0, eflags: 0x0
// Checksum 0x691f5a45, Offset: 0x130
// Size: 0x61a
function function_6ce7e41a() {
    if (!getdvarint(#"hash_35dbebb08d656926", 0) || isdefined(self.pers[#"hvo"]) || isbot(self) || !level.rankedmatch || level.disablestattracking) {
        return;
    }
    self.pers[#"hvo"] = [];
    self.pers[#"hvo"][#"base"] = [];
    self.pers[#"hvo"][#"current"] = [];
    var_4f8ddf6d = getscriptbundlelist("hvolist");
    if (isdefined(var_4f8ddf6d) && isarray(var_4f8ddf6d)) {
        foreach (var_b7c77213 in var_4f8ddf6d) {
            hvo = getscriptbundle(var_b7c77213);
            if (!isdefined(hvo) || !isdefined(hvo.statsarray) || !isarray(hvo.statsarray)) {
                continue;
            }
            if (isdefined(hvo.var_dda83a78) && hvo.var_dda83a78 != "none" && hvo.var_dda83a78 != level.gametype) {
                continue;
            }
            foreach (stat in hvo.statsarray) {
                if (!isdefined(stat) || !isdefined(stat.stattype)) {
                    continue;
                }
                if (isdefined(stat.var_7bb3ffe8) && isdefined(self.pers[#"hvo"][#"base"][stat.var_7bb3ffe8]) || isdefined(self.pers[#"hvo"][#"base"][stat.stattype])) {
                    continue;
                }
                switch (stat.stattype) {
                case #"playerstatslist":
                    if (!isdefined(stat.var_7bb3ffe8)) {
                        break;
                    }
                    self.pers[#"hvo"][#"base"][stat.var_7bb3ffe8] = self stats::get_stat_global(stat.var_7bb3ffe8);
                    self.pers[#"hvo"][#"current"][stat.var_7bb3ffe8] = self stats::get_stat_global(stat.var_7bb3ffe8);
                    break;
                case #"razorwireekia":
                    razorwireekia = self stats::get_stat_global(#"stats_concertina_wire_snared_kill") + self stats::get_stat_global(#"stats_concertina_wire_kill");
                    self.pers[#"hvo"][#"base"][stat.stattype] = razorwireekia;
                    self.pers[#"hvo"][#"current"][stat.stattype] = razorwireekia;
                    break;
                case #"highestkillstreak":
                case #"objectivescore":
                case #"objectivetime":
                case #"damagedone":
                case #"highestmultikill":
                case #"objectiveekia":
                default:
                    self.pers[#"hvo"][#"base"][stat.stattype] = 0;
                    self.pers[#"hvo"][#"current"][stat.stattype] = 0;
                    break;
                }
            }
        }
    }
}

// Namespace hvo/high_value_operative
// Params 0, eflags: 0x0
// Checksum 0xead35fc2, Offset: 0x758
// Size: 0x60e
function function_304ae53d() {
    if (!getdvarint(#"hash_35dbebb08d656926", 0) || !(isdefined(self.var_a825d3c2) ? self.var_a825d3c2 : 0) || !level.rankedmatch || level.disablestattracking) {
        return;
    }
    var_4f8ddf6d = getscriptbundlelist("hvolist");
    var_31de575d = self.pers[#"hash_1b145cf9f0673e9"];
    if (!isdefined(var_4f8ddf6d) || !isarray(var_4f8ddf6d) || !isdefined(var_31de575d)) {
        return;
    }
    if (!isdefined(self.pers[#"hvo"][var_31de575d])) {
        self.pers[#"hvo"][var_31de575d] = [];
    }
    var_90336534 = [];
    foreach (var_b7c77213 in var_4f8ddf6d) {
        hvo = getscriptbundle(var_b7c77213);
        if (!isdefined(hvo) || !isdefined(hvo.statsarray) || !isarray(hvo.statsarray)) {
            continue;
        }
        if (isdefined(hvo.var_705e97e4) && hvo.var_705e97e4 != var_31de575d) {
            continue;
        }
        if (isdefined(hvo.var_dda83a78) && hvo.var_dda83a78 != "none" && hvo.var_dda83a78 != level.gametype) {
            continue;
        }
        foreach (stat in hvo.statsarray) {
            if (!isdefined(stat) || isdefined(stat.var_8d051dfe) && stat.var_8d051dfe || !isdefined(stat.stattype)) {
                continue;
            }
            switch (stat.stattype) {
            case #"playerstatslist":
                if (!isdefined(stat.var_7bb3ffe8)) {
                    break;
                }
                var_4b5c60b9 = self function_30e4a3ec(stat, var_31de575d, stat.stattype);
                var_90336534[stat.var_7bb3ffe8] = var_4b5c60b9;
                break;
            case #"razorwireekia":
                razorwireekia = self stats::get_stat_global(#"stats_concertina_wire_snared_kill") + self stats::get_stat_global(#"stats_concertina_wire_kill");
                self function_62a1fe47(stat, razorwireekia, var_31de575d);
                var_90336534[stat.stattype] = razorwireekia;
                break;
            case #"objectivescore":
            case #"objectivetime":
            case #"damagedone":
            case #"objectiveekia":
                var_4b5c60b9 = self function_62a1fe47(stat, self.pers[stat.stattype], var_31de575d);
                var_90336534[stat.stattype] = var_4b5c60b9;
                break;
            case #"highestkillstreak":
                var_4b5c60b9 = self.pers[#"cur_kill_streak"] - self.pers[#"hvo"][#"current"][#"highestkillstreak"];
                self function_9ec4ab69(stat, var_4b5c60b9, var_31de575d);
                break;
            }
        }
    }
    var_90336534[#"highestkillstreak"] = self.pers[#"cur_kill_streak"];
    foreach (index, stat in var_90336534) {
        self.pers[#"hvo"][#"current"][index] = stat;
    }
}

// Namespace hvo/high_value_operative
// Params 0, eflags: 0x0
// Checksum 0x760490b1, Offset: 0xd70
// Size: 0xcd8
function function_73ea84a3() {
    if (!getdvarint(#"hash_35dbebb08d656926", 0) || !level.rankedmatch || level.disablestattracking) {
        return;
    }
    var_4f8ddf6d = getscriptbundlelist("hvolist");
    players = getplayers();
    if (!isdefined(var_4f8ddf6d) || !isarray(var_4f8ddf6d) || !isdefined(players) || !isarray(players)) {
        return;
    }
    level.var_39207e3 = [];
    foreach (var_29f7be12, var_b7c77213 in var_4f8ddf6d) {
        hvo = getscriptbundle(var_b7c77213);
        if (!isdefined(hvo) || !isdefined(hvo.statsarray) || !isarray(hvo.statsarray)) {
            continue;
        }
        if (isdefined(hvo.var_dda83a78) && hvo.var_dda83a78 != "none" && hvo.var_dda83a78 != level.gametype) {
            continue;
        }
        foreach (player in players) {
            if (!isdefined(player) || isbot(player)) {
                continue;
            }
            assert(isdefined(player.pers), "<dev string:x30>");
            assert(isdefined(player.pers[#"hvo"]), "<dev string:x45>");
            var_118a2213 = function_b9650e7f(player player_role::get(), currentsessionmode());
            if (!isdefined(var_118a2213) || isdefined(hvo.var_705e97e4) && hvo.var_705e97e4 != var_118a2213 || !isdefined(player.pers) || !isdefined(player.pers[#"hvo"])) {
                continue;
            }
            if (!isdefined(player.pers[#"hvo"][var_118a2213])) {
                player.pers[#"hvo"][var_118a2213] = [];
            }
            var_ef4c1883 = 0;
            var_b40ee776 = [];
            foreach (stat in hvo.statsarray) {
                if (!isdefined(stat) || !isdefined(stat.stattype)) {
                    continue;
                }
                switch (stat.stattype) {
                case #"playerstatslist":
                    score = player function_22c725ef(stat, var_118a2213, stat.stattype);
                    break;
                case #"razorwireekia":
                    razorwireekia = player stats::get_stat_global(#"stats_concertina_wire_snared_kill") + player stats::get_stat_global(#"stats_concertina_wire_kill");
                    score = player function_d5920e54(stat, razorwireekia, var_118a2213);
                    break;
                case #"objectivescore":
                case #"objectivetime":
                case #"damagedone":
                case #"objectiveekia":
                    score = player function_d5920e54(stat, player.pers[stat.stattype], var_118a2213);
                    break;
                case #"highestkillstreak":
                    if (isdefined(stat.var_8d051dfe) && stat.var_8d051dfe) {
                        score = player.pers[#"cur_kill_streak"] < player.pers[#"best_kill_streak"] ? player.pers[#"best_kill_streak"] : player.pers[#"cur_kill_streak"];
                    } else {
                        if (!isdefined(player.pers[#"hvo"][var_118a2213][stat.stattype])) {
                            player.pers[#"hvo"][var_118a2213][stat.stattype] = 0;
                        }
                        score = player.pers[#"cur_kill_streak"] < player.pers[#"hvo"][var_118a2213][stat.stattype] ? player.pers[#"hvo"][var_118a2213][stat.stattype] : player.pers[#"cur_kill_streak"];
                    }
                    break;
                case #"highestmultikill":
                    score = isdefined(player.pers[stat.stattype]) ? player.pers[stat.stattype] : 0;
                    break;
                default:
                    score = 0;
                    break;
                }
                var_ef4c1883 += score * (isdefined(stat.var_8bff1c5b) ? stat.var_8bff1c5b : 0);
                var_b40ee776[var_b40ee776.size] = score;
            }
            for (index = 0; index < 3; index++) {
                if (!isdefined(level.var_39207e3[index])) {
                    level.var_39207e3[index] = spawnstruct();
                }
                if (var_ef4c1883 < (isdefined(level.var_39207e3[index].var_ef4c1883) ? level.var_39207e3[index].var_ef4c1883 : 0)) {
                    continue;
                }
                for (var_2837de63 = 2; var_2837de63 > index; var_2837de63--) {
                    if (!isdefined(level.var_39207e3[var_2837de63])) {
                        level.var_39207e3[var_2837de63] = spawnstruct();
                    }
                    if (!isdefined(level.var_39207e3[var_2837de63 - 1])) {
                        level.var_39207e3[var_2837de63 - 1] = spawnstruct();
                    }
                    level.var_39207e3[var_2837de63].var_ef4c1883 = level.var_39207e3[var_2837de63 - 1].var_ef4c1883;
                    level.var_39207e3[var_2837de63].player = level.var_39207e3[var_2837de63 - 1].player;
                    level.var_39207e3[var_2837de63].hvo = level.var_39207e3[var_2837de63 - 1].hvo;
                    level.var_39207e3[var_2837de63].var_29f7be12 = level.var_39207e3[var_2837de63 - 1].var_29f7be12;
                    level.var_39207e3[var_2837de63].var_b40ee776 = level.var_39207e3[var_2837de63 - 1].var_b40ee776;
                }
                level.var_39207e3[index].var_ef4c1883 = var_ef4c1883;
                level.var_39207e3[index].player = player;
                level.var_39207e3[index].hvo = hvo;
                level.var_39207e3[index].var_29f7be12 = var_29f7be12;
                level.var_39207e3[index].var_b40ee776 = var_b40ee776;
                break;
            }
        }
    }
    foreach (var_6dd68fc8 in level.var_39207e3) {
        luinotifyevent(#"hvo_card", 7, var_6dd68fc8.player.clientid, isdefined(var_6dd68fc8.var_29f7be12) ? var_6dd68fc8.var_29f7be12 : 0, isdefined(var_6dd68fc8.var_b40ee776[0]) ? var_6dd68fc8.var_b40ee776[0] : 0, isdefined(var_6dd68fc8.var_b40ee776[1]) ? var_6dd68fc8.var_b40ee776[1] : 0, isdefined(var_6dd68fc8.var_b40ee776[2]) ? var_6dd68fc8.var_b40ee776[2] : 0, isdefined(var_6dd68fc8.var_b40ee776[3]) ? var_6dd68fc8.var_b40ee776[3] : 0, isdefined(var_6dd68fc8.var_b40ee776[4]) ? var_6dd68fc8.var_b40ee776[4] : 0);
    }
}

// Namespace hvo/high_value_operative
// Params 3, eflags: 0x4
// Checksum 0x11ae91e3, Offset: 0x1a50
// Size: 0x1a4
function private function_22c725ef(stat, var_118a2213, ddl) {
    if (!isdefined(stat.var_7bb3ffe8)) {
        return 0;
    }
    if (isdefined(stat.var_8d051dfe) && stat.var_8d051dfe) {
        score = self stats::get_stat(ddl, stat.var_7bb3ffe8, #"statvalue") - self.pers[#"hvo"][#"base"][stat.var_7bb3ffe8];
    } else {
        score = isdefined(self.pers[#"hvo"][var_118a2213][stat.var_7bb3ffe8]) ? self.pers[#"hvo"][var_118a2213][stat.var_7bb3ffe8] : 0;
        score += self stats::get_stat(ddl, stat.var_7bb3ffe8, #"statvalue") - self.pers[#"hvo"][#"current"][stat.var_7bb3ffe8];
    }
    return score;
}

// Namespace hvo/high_value_operative
// Params 3, eflags: 0x4
// Checksum 0x14f85700, Offset: 0x1c00
// Size: 0x14e
function private function_30e4a3ec(stat, var_31de575d, ddl) {
    if (!isdefined(self.pers[#"hvo"][var_31de575d][stat.var_7bb3ffe8])) {
        self.pers[#"hvo"][var_31de575d][stat.var_7bb3ffe8] = 0;
    }
    var_4b5c60b9 = self stats::get_stat(ddl, stat.var_7bb3ffe8, #"statvalue");
    self.pers[#"hvo"][var_31de575d][stat.var_7bb3ffe8] = self.pers[#"hvo"][var_31de575d][stat.var_7bb3ffe8] + var_4b5c60b9 - self.pers[#"hvo"][#"current"][stat.var_7bb3ffe8];
    return var_4b5c60b9;
}

// Namespace hvo/high_value_operative
// Params 3, eflags: 0x4
// Checksum 0x43a5ff77, Offset: 0x1d58
// Size: 0x13c
function private function_d5920e54(stat, currentscore, var_118a2213) {
    if (isdefined(stat.var_8d051dfe) && stat.var_8d051dfe) {
        score = currentscore - self.pers[#"hvo"][#"base"][stat.stattype];
    } else {
        score = isdefined(self.pers[#"hvo"][var_118a2213][stat.stattype]) ? self.pers[#"hvo"][var_118a2213][stat.stattype] : 0;
        score += currentscore - self.pers[#"hvo"][#"current"][stat.stattype];
    }
    return score;
}

// Namespace hvo/high_value_operative
// Params 3, eflags: 0x4
// Checksum 0x9882b435, Offset: 0x1ea0
// Size: 0x116
function private function_62a1fe47(stat, score, var_31de575d) {
    if (!isdefined(self.pers[#"hvo"][var_31de575d][stat.stattype])) {
        self.pers[#"hvo"][var_31de575d][stat.stattype] = 0;
    }
    self.pers[#"hvo"][var_31de575d][stat.stattype] = self.pers[#"hvo"][var_31de575d][stat.stattype] + score - self.pers[#"hvo"][#"current"][stat.stattype];
    return score;
}

// Namespace hvo/high_value_operative
// Params 3, eflags: 0x4
// Checksum 0x8a917432, Offset: 0x1fc0
// Size: 0xe2
function private function_9ec4ab69(stat, score, var_31de575d) {
    if (!isdefined(self.pers[#"hvo"][var_31de575d][stat.stattype])) {
        self.pers[#"hvo"][var_31de575d][stat.stattype] = 0;
    }
    if (self.pers[#"hvo"][var_31de575d][stat.stattype] < score) {
        self.pers[#"hvo"][var_31de575d][stat.stattype] = score;
    }
}

