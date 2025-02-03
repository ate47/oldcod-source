#using script_7a8059ca02b7b09e;
#using scripts\core_common\array_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\scoreevents;

#namespace namespace_4b798cb0;

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x6
// Checksum 0xaf382cd3, Offset: 0x228
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_4b859fe530bf291d", &preinit, undefined, undefined, #"hash_53528dbbf6cd15c4");
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x4
// Checksum 0xbd53314a, Offset: 0x278
// Size: 0x59c
function private preinit() {
    if (getdvarint(#"hash_43b642374f5b1f22", 0) == 0) {
        return;
    }
    level.esports = {};
    level.esports.teams = [];
    level.var_268c70a7 = 1;
    level.map_name = util::get_map_name();
    telemetry::add_callback(#"on_game_playing", &function_e2603d58);
    telemetry::add_callback(#"hash_3ca80e35288a78d0", &function_84b3ab79);
    telemetry::add_callback(#"on_end_game", &function_a6efe6c9);
    telemetry::add_callback(#"on_player_connect", &function_5a676b2c);
    telemetry::add_callback(#"on_player_disconnect", &function_42fa3a5c);
    telemetry::add_callback(#"on_player_spawned", &on_player_spawned);
    telemetry::function_98df8818(#"hash_fc0d1250fc48d49", &on_player_killed);
    telemetry::add_callback(#"on_loadout", &function_e2162733);
    telemetry::add_callback(#"hash_7de173a0523c27c9", &function_d5aacfd7);
    switch (level.basegametype) {
    case #"koth":
        level.var_ab8dd45a = {#var_284ea17f:#"hash_75fa0382e49cdd2f", #data_function:&function_99b4929d};
        level.var_86d47028 = {#var_284ea17f:#"hash_4f85fe047c18a6f2", #data_function:&function_6607b43f};
        level.var_8d67cbd8 = {#var_284ea17f:#"hash_57af555874ed0050", #data_function:&function_712f816a};
        level.var_46fc4fdb = &function_4dc75f1b;
        break;
    case #"sd":
        level.var_ab8dd45a = {#var_284ea17f:#"hash_d9870c3e6c1e3c5", #data_function:&function_39e8afcf};
        level.var_86d47028 = {#var_284ea17f:#"hash_63c6c30aa3ff880", #data_function:&function_9555b8d2};
        level.var_8d67cbd8 = {#var_284ea17f:#"hash_628978e8b4daa872", #data_function:&function_150786f3};
        level.var_46fc4fdb = &function_86398c9c;
        break;
    case #"control":
        level.var_ab8dd45a = {#var_284ea17f:#"hash_22a8e3365d654f5b", #data_function:&function_91a0716f};
        level.var_86d47028 = {#var_284ea17f:#"hash_740ef2b9ec63f1fe", #data_function:&function_b16086a1};
        level.var_8d67cbd8 = {#var_284ea17f:#"hash_145e373d3b0196c4", #data_function:&function_cdce904b};
        level.var_46fc4fdb = &function_979f0cb4;
        break;
    }
    level thread function_1296760e();
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0x1dac1aa1, Offset: 0x820
// Size: 0x60
function function_8d2c5f27(array) {
    new_array = [];
    for (i = 0; i < array.size; i++) {
        new_array[i] = hash(array[i]);
    }
    return new_array;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 2, eflags: 0x0
// Checksum 0x704c5ccf, Offset: 0x888
// Size: 0x12e
function function_4dc75f1b(var_a504287b, persistent_data) {
    var_a504287b.var_20546359 = isdefined(persistent_data[#"hash_15d08de09ca7c066"]) ? persistent_data[#"hash_15d08de09ca7c066"] : 0;
    var_a504287b.var_c9ac1b25 = isdefined(persistent_data[#"hash_15d08ee09ca7c219"]) ? persistent_data[#"hash_15d08ee09ca7c219"] : 0;
    var_a504287b.var_17cc6b98 = isdefined(persistent_data[#"hash_15d08be09ca7bd00"]) ? persistent_data[#"hash_15d08be09ca7bd00"] : 0;
    var_a504287b.var_e6110dd7 = isdefined(persistent_data[#"hash_15d08ce09ca7beb3"]) ? persistent_data[#"hash_15d08ce09ca7beb3"] : 0;
    var_a504287b.var_1993c7d2 = isdefined(persistent_data[#"hash_15d091e09ca7c732"]) ? persistent_data[#"hash_15d091e09ca7c732"] : 0;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 2, eflags: 0x0
// Checksum 0xd86ab621, Offset: 0x9c0
// Size: 0x86
function function_86398c9c(var_a504287b, persistent_data) {
    var_a504287b.var_f177bc0c = isdefined(persistent_data[#"bombplanted"]) ? persistent_data[#"bombplanted"] : 0;
    var_a504287b.var_8a69e593 = isdefined(persistent_data[#"bombdefused"]) ? persistent_data[#"bombdefused"] : 0;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 2, eflags: 0x0
// Checksum 0xe60dc0d6, Offset: 0xa50
// Size: 0x2e
function function_979f0cb4(var_a504287b, persistent_data) {
    var_a504287b.var_a6134363 = persistent_data[#"hash_156cd38474282f8d"];
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x4a153e5d, Offset: 0xa88
// Size: 0x20e
function function_9f07d120() {
    foreach (player in self.players) {
        if (player.team != #"spectator") {
            persistent_data = player.pers;
            var_a504287b = {};
            var_a504287b.kills = persistent_data[#"kills"];
            var_a504287b.deaths = persistent_data[#"deaths"];
            var_a504287b.assists = persistent_data[#"assists"];
            var_a504287b.damage_done = persistent_data[#"damagedone"];
            var_a504287b.var_52bfc9cc = 0;
            var_a504287b.multikills = persistent_data[#"hash_104ec9727c3d4ef7"];
            var_a504287b.var_fc1e4ef3 = 0;
            var_a504287b.time_alive = persistent_data[#"time_played_alive"];
            var_a504287b.score = persistent_data[#"score"];
            var_a504287b.shots_hit = persistent_data[#"shotshit"];
            var_a504287b.shots_fired = persistent_data[#"shotsfired"];
            var_a504287b.var_d75d8ad2 = persistent_data[#"headshothits"];
            var_a504287b.objective_time = persistent_data[#"objtime"];
            if (isdefined(level.var_46fc4fdb)) {
                self [[ level.var_46fc4fdb ]](var_a504287b, persistent_data);
            }
            player.var_a504287b = var_a504287b;
        }
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0xcda6f248, Offset: 0xca0
// Size: 0x68
function function_1674a96a(team_id) {
    if (!isdefined(level.esports.teams[team_id])) {
        level.esports.teams[team_id] = function_638671f1(team_id);
    }
    return level.esports.teams[team_id];
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x870e936a, Offset: 0xd10
// Size: 0x42
function function_ce7dd3eb() {
    var_64e8f5a4 = 0;
    while (!isdefined(self.var_b2ca7b2b)) {
        wait 0.1;
        var_64e8f5a4++;
        if (var_64e8f5a4 >= 10) {
            break;
        }
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x506a4ae2, Offset: 0xd60
// Size: 0x152
function function_3d01c1b3() {
    var_c1e98979 = round::function_3624d032();
    switch (var_c1e98979) {
    case 0:
        return "dnf";
    case 1:
        return "completed";
    case 2:
        return "time limit";
    case 3:
        return "scorelimit";
    case 4:
        return "roundscorelimit";
    case 5:
        return "roundlimit";
    case 6:
        return "team eliminated";
    case 7:
        return "forfeit";
    case 8:
        return "ended game";
    case 9:
        return "host ended game";
    case 10:
        return "host ended sucks";
    case 11:
        return "gamemode-specific";
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x32f7eb20, Offset: 0xec0
// Size: 0xde
function function_d757edb5() {
    winning_team = round::get_winning_team();
    if (winning_team == game.attackers) {
        return {#side:#"attack", #var_9bfeafed:winning_team, #var_c7a20fbb:game.defenders};
    }
    if (winning_team == game.defenders) {
        return {#side:#"defense", #var_9bfeafed:winning_team, #var_c7a20fbb:game.attackers};
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0xc7ff777c, Offset: 0xfa8
// Size: 0x40
function function_ddf02547() {
    zoneindex = array::find(level.zones, level.zone) + 1;
    return "point_" + zoneindex;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x2bccd8c9, Offset: 0xff0
// Size: 0x52
function function_a6f108b5() {
    if (isdefined(self.label)) {
        if (self.label == "_a") {
            return "point_a";
        } else if (self.label == "_b") {
            return "point_b";
        }
    }
    return "bomb";
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0xa49faf9, Offset: 0x1050
// Size: 0x46
function function_d4ad62c7() {
    if (self.var_f23c87bd == "control_0") {
        return "point_a";
    } else if (self.var_f23c87bd == "control_1") {
        return "point_b";
    }
    return self.var_f23c87bd;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x34d125cd, Offset: 0x10a0
// Size: 0x7e
function function_9ad755c5() {
    var_c6af8b83 = float(self.pers[#"hash_20464b40eeb9b465"]);
    time_played_moving = float(self.pers[#"time_played_moving"]);
    return time_played_moving != 0 ? var_c6af8b83 / time_played_moving : 0;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x295b5888, Offset: 0x1128
// Size: 0x44
function function_e2603d58() {
    self function_9f07d120();
    if (util::isfirstround()) {
        self function_72c32279();
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x1408a92a, Offset: 0x1178
// Size: 0x6c
function function_84b3ab79() {
    util::function_64ebd94d();
    self on_round_end();
    if (util::isoneround() || util::waslastround()) {
        self function_d519e318();
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0xd7c94f90, Offset: 0x11f0
// Size: 0x8c
function function_a6efe6c9() {
    if (self.team == #"spectator") {
        return;
    }
    util::function_64ebd94d();
    self function_2d28a3b3();
    if (util::isoneround() || util::waslastround()) {
        self function_f0ffff28();
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x4
// Checksum 0xe5aaf17d, Offset: 0x1288
// Size: 0xea
function private function_5a676b2c() {
    self endon(#"disconnect");
    player_team = self.pers[#"team"];
    var_64e8f5a4 = 0;
    while (!isdefined(player_team) || isdefined(self.pers[#"needteam"])) {
        wait 0.1;
        player_team = self.pers[#"team"];
        if (player_team == #"spectator") {
            return;
        }
        var_64e8f5a4++;
        if (var_64e8f5a4 >= 10) {
            break;
        }
    }
    self.var_7a967a71 = {};
    self.var_b2ca7b2b = function_1674a96a(player_team);
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x4
// Checksum 0x60f9848f, Offset: 0x1380
// Size: 0xb4
function private function_42fa3a5c() {
    if (self.team == #"spectator" || !isdefined(self.var_7a967a71) || game.state == #"pregame") {
        return;
    }
    var_66e1aeea = self.var_7a967a71;
    if (var_66e1aeea.round_end !== 1) {
        self function_2d28a3b3();
    }
    if (var_66e1aeea.match_end !== 1) {
        self function_f0ffff28();
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x4
// Checksum 0x87f0ff63, Offset: 0x1440
// Size: 0x44c
function private function_1296760e() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        all_events = [];
        foreach (player in level.players) {
            if (!isdefined(player) || player.team == #"spectator") {
                continue;
            }
            esports_event = {#damage_dealt:player.pers[#"damagedone"], #assists:player.pers[#"assists"], #deaths:player.pers[#"deaths"], #kills:player.pers[#"kills"], #var_c6267937:player.pers[#"cur_kill_streak"], #var_52bfc9cc:player.pers[#"best_kill_streak"], #multikills:player.pers[#"hash_104ec9727c3d4ef7"], #var_fc1e4ef3:player.pers[#"highestmultikill"], #score:player.pers[#"score"], #shots_fired:player.pers[#"shotsfired"], #shots_hit:player.pers[#"shotshit"], #var_d75d8ad2:player.pers[#"hash_655e50439f6ad919"], #objective_time:player.pers[#"objtime"], #player:player.name};
            player_event = {#player:player, #event:esports_event};
            if (!isdefined(all_events)) {
                all_events = [];
            } else if (!isarray(all_events)) {
                all_events = array(all_events);
            }
            all_events[all_events.size] = player_event;
        }
        foreach (player_event in all_events) {
            player = player_event.player;
            if (!isdefined(player)) {
                continue;
            }
            player function_678f57c8(#"hash_38e3c906bd8063c0", player_event.event);
            waitframe(1);
        }
        wait 5;
    }
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0xc1543997, Offset: 0x1898
// Size: 0xbc
function function_72c32279() {
    esports_event = {#game_type:level.gametype, #map_name:level.map_name, #var_53efd038:function_1674a96a(game.attackers), #var_16d89ef:function_1674a96a(game.defenders)};
    function_92d1707f(#"hash_60026644979e3672", esports_event);
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x545a6399, Offset: 0x1960
// Size: 0x1c4
function function_d519e318() {
    team1 = game.attackers;
    team2 = game.defenders;
    team_scores = game.stat[#"teamscores"];
    var_9bfeafed = function_1674a96a(round::get_winning_team());
    esports_event = {#var_34d28e72:function_f8d53445(), #var_e394d7c0:game.roundsplayed, #var_53efd038:function_1674a96a(team1), #var_9953c424:team_scores[team1], #var_16d89ef:function_1674a96a(team2), #var_a41f3c35:team_scores[team2], #var_9bfeafed:isdefined(var_9bfeafed) ? var_9bfeafed : "draw", #game_type:level.gametype, #map_name:level.map_name};
    function_92d1707f(#"hash_59d78dad912aed7", esports_event);
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0x2746672d, Offset: 0x1b30
// Size: 0xce
function function_99b4929d(esports_event) {
    esports_event.var_5fb8d45b = self.pers[#"objtime"];
    esports_event.var_20546359 = self.pers[#"hash_15d08de09ca7c066"];
    esports_event.var_c9ac1b25 = self.pers[#"hash_15d08ee09ca7c219"];
    esports_event.var_17cc6b98 = self.pers[#"hash_15d08be09ca7bd00"];
    esports_event.var_e6110dd7 = self.pers[#"hash_15d08ce09ca7beb3"];
    esports_event.var_1993c7d2 = self.pers[#"hash_15d091e09ca7c732"];
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0x58e14b02, Offset: 0x1c08
// Size: 0x6e
function function_39e8afcf(esports_event) {
    esports_event.var_5fb8d45b = self.pers[#"objtime"];
    esports_event.var_f177bc0c = self.pers[#"bombplanted"];
    esports_event.var_8a69e593 = self.pers[#"bombdefused"];
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0xeb746925, Offset: 0x1c80
// Size: 0x4e
function function_91a0716f(esports_event) {
    esports_event.var_b675fed3 = self.pers[#"captures"];
    esports_event.var_79714d9b = self.pers[#"hash_156cd38474282f8d"];
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0xe760f3ce, Offset: 0x1cd8
// Size: 0x306
function function_f0ffff28() {
    persistent_data = self.pers;
    esports_event = {#player:self.name, #total_score:persistent_data[#"score"], #var_229e9030:persistent_data[#"assists"], #total_kills:persistent_data[#"kills"], #var_ef5017c7:persistent_data[#"best_kill_streak"], #total_deaths:persistent_data[#"deaths"], #var_35cd6992:persistent_data[#"headshots"], #var_62f25812:persistent_data[#"time_played_alive"], #var_3426c422:persistent_data[#"total_distance_travelled"], #var_2e369569:persistent_data[#"damagedone"], #var_be574ee1:self function_9ad755c5(), #var_5bda8eec:persistent_data[#"time_played_moving"], #var_d568c84:persistent_data[#"suicides"], #var_9411af72:persistent_data[#"shotsfired"], #var_e36aba01:persistent_data[#"headshothits"], #var_5afded2b:persistent_data[#"shotshit"], #var_f66612f0:persistent_data[#"hash_104ec9727c3d4ef7"], #var_fc1e4ef3:persistent_data[#"highestmultikill"], #var_e394d7c0:game.roundsplayed};
    var_284ea17f = #"hash_467c6c9bd786ed0d";
    if (isdefined(level.var_ab8dd45a)) {
        var_284ea17f = level.var_ab8dd45a.var_284ea17f;
        self [[ level.var_ab8dd45a.data_function ]](esports_event);
    }
    self function_678f57c8(var_284ea17f, esports_event);
    self.var_7a967a71.match_end = 1;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x74b9bf8c, Offset: 0x1fe8
// Size: 0x15c
function on_player_spawned() {
    player_position = self.origin;
    player_angles = self getplayerangles();
    esports_event = {#player:self.name, #var_34d28e72:function_f8d53445(), #origin_x:player_position[0], #origin_y:player_position[1], #var_58c899fa:player_position[2], #var_231262ec:player_angles[0], #var_c91e5a:player_angles[1], #var_e88b9d9:player_angles[2]};
    if (!isdefined(self.var_b2ca7b2b)) {
        self function_ce7dd3eb();
    }
    esports_event.player_team = self.var_b2ca7b2b;
    self function_678f57c8(#"hash_1bc66812d8d53094", esports_event);
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0x63d1cb67, Offset: 0x2150
// Size: 0x524
function on_player_killed(data) {
    attacker = data.attacker;
    victim = data.victim;
    results = data.results;
    if (isplayer(attacker)) {
        attackerposition = data.attackerorigin;
        attackerangles = data.attackerangles;
        attackerweapon = data.weapon;
        attacker_info = {#name:attacker.name, #team:attacker.var_b2ca7b2b, #origin_x:attackerposition[0], #origin_y:attackerposition[1], #var_58c899fa:attackerposition[2], #var_231262ec:attackerangles[0], #var_c91e5a:attackerangles[1], #var_e88b9d9:attackerangles[2], #weapon:attackerweapon.name, #weapon_attachments:function_8d2c5f27(attackerweapon.attachments)};
        var_ebf88f4 = {#is_ads:data.var_4c540e11 > 0.5, #var_c085dcdf:data.attackerwasflashed, #var_4aca04c6:data.var_91610392};
        kill_context = {#var_91b86b21:results.var_91b86b21 === 1, #var_a5aabf71:results.var_a5aabf71 === 1, #var_905bd140:results.var_905bd140 === 1};
    } else {
        attacker_info = {};
        var_ebf88f4 = {};
        kill_context = {};
    }
    var_48dd40c2 = data.victimorigin;
    victimangles = data.victimangles;
    victimweapon = data.victimweapon;
    victim_info = {#name:victim.name, #team:victim.var_b2ca7b2b, #origin_x:var_48dd40c2[0], #origin_y:var_48dd40c2[1], #var_58c899fa:var_48dd40c2[2], #var_231262ec:victimangles[0], #var_c91e5a:victimangles[1], #var_e88b9d9:victimangles[2], #weapon:victimweapon.name, #weapon_attachments:function_8d2c5f27(victimweapon.attachments)};
    var_61e89f84 = {#is_ads:data.var_f0b3c772 > 0.5, #var_c085dcdf:data.var_e020b97e, #var_4aca04c6:data.var_30db4425};
    kill_info = {#var_34d28e72:function_f8d53445(), #means_of_death:data.smeansofdeath, #var_cc573225:isdefined(results.kill_distance) ? results.kill_distance : 0};
    victim function_678f57c8(#"hash_36ba9c8216e49683", #"info", kill_info, #"attacker", attacker_info, #"attacker_status", var_ebf88f4, #"victim", victim_info, #"victim_status", var_61e89f84, #"kill_context", kill_context);
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x80288a32, Offset: 0x2680
// Size: 0x374
function function_e2162733() {
    if (self.curclass == self.lastclass) {
        return;
    }
    self.lastclass = self.curclass;
    primary_weapon = self loadout::function_18a77b37("primary");
    secondary_weapon = self loadout::function_18a77b37("secondary");
    primary_grenade = self loadout::function_18a77b37("primarygrenade");
    var_68f5c0ed = self loadout::function_18a77b37("secondarygrenade");
    field_upgrade = self loadout::function_18a77b37("specialgrenade");
    var_992d253 = self loadout::function_18a77b37("herogadget");
    var_7078908d = self loadout::function_18a77b37("ultimate");
    class_num = self.class_num;
    tactical_gear = self function_d78e0e04(class_num);
    scorestreaks = self.killstreak;
    perks = self function_4a9f1384(class_num);
    wildcards = self function_6f2c0492(class_num);
    esports_event = {#player:self.name, #var_34d28e72:function_f8d53445(), #primary_weapon:primary_weapon.name, #var_70eb2c9d:function_8d2c5f27(primary_weapon.attachments), #secondary_weapon:secondary_weapon.name, #var_85aac3ff:function_8d2c5f27(secondary_weapon.attachments), #primary_grenade:primary_grenade.name, #var_68f5c0ed:var_68f5c0ed.name, #field_upgrade:field_upgrade.name, #var_992d253:var_992d253.name, #var_7078908d:var_7078908d.name, #tactical_gear:tactical_gear, #scorestreaks:scorestreaks, #perks:perks, #wildcards:wildcards};
    self function_678f57c8(#"hash_8443c9b69d1ef55", esports_event);
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0x6b1578e4, Offset: 0x2a00
// Size: 0x10c
function on_round_end() {
    round_info = function_d757edb5();
    esports_event = {#result:function_3d01c1b3(), #var_77a9bf99:round_info.side, #var_34d28e72:function_f8d53445(), #game_type:level.gametype, #map_name:level.map_name, #var_9bfeafed:round_info.var_9bfeafed, #var_c7a20fbb:round_info.var_c7a20fbb};
    function_92d1707f(#"hash_1d858c5e8f79303a", esports_event);
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0xafdfb8b, Offset: 0x2b18
// Size: 0x1ca
function function_6607b43f(esports_event) {
    var_a504287b = self.var_a504287b;
    persistent_data = self.pers;
    objective_time = persistent_data[#"objtime"];
    var_20546359 = persistent_data[#"hash_15d08de09ca7c066"];
    var_c9ac1b25 = persistent_data[#"hash_15d08ee09ca7c219"];
    var_17cc6b98 = persistent_data[#"hash_15d08be09ca7bd00"];
    var_e6110dd7 = persistent_data[#"hash_15d08ce09ca7beb3"];
    var_1993c7d2 = persistent_data[#"hash_15d091e09ca7c732"];
    esports_event.objective_time = isdefined(objective_time) ? objective_time - var_a504287b.objective_time : 0;
    esports_event.var_20546359 = isdefined(var_20546359) ? var_20546359 - var_a504287b.var_20546359 : 0;
    esports_event.var_c9ac1b25 = isdefined(var_c9ac1b25) ? var_c9ac1b25 - var_a504287b.var_c9ac1b25 : 0;
    esports_event.var_17cc6b98 = isdefined(var_17cc6b98) ? var_17cc6b98 - var_a504287b.var_17cc6b98 : 0;
    esports_event.var_e6110dd7 = isdefined(var_e6110dd7) ? var_e6110dd7 - var_a504287b.var_e6110dd7 : 0;
    esports_event.var_1993c7d2 = isdefined(var_1993c7d2) ? var_1993c7d2 - var_a504287b.var_1993c7d2 : 0;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0x949d40bf, Offset: 0x2cf0
// Size: 0xfe
function function_9555b8d2(esports_event) {
    var_a504287b = self.var_a504287b;
    persistent_data = self.pers;
    objective_time = persistent_data[#"objtime"];
    var_f177bc0c = persistent_data[#"bombplanted"];
    var_8a69e593 = persistent_data[#"bombdefused"];
    esports_event.objective_time = isdefined(objective_time) ? objective_time - var_a504287b.objective_time : 0;
    esports_event.var_f177bc0c = isdefined(var_f177bc0c) ? var_f177bc0c - var_a504287b.var_f177bc0c : 0;
    esports_event.var_8a69e593 = isdefined(var_8a69e593) ? var_8a69e593 - var_a504287b.var_8a69e593 : 0;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0xf4924fda, Offset: 0x2df8
// Size: 0xa6
function function_b16086a1(esports_event) {
    var_a504287b = self.var_a504287b;
    objective_time = self.pers[#"objtime"];
    var_a6134363 = self.pers[#"hash_156cd38474282f8d"];
    esports_event.objective_time = isdefined(objective_time) ? objective_time - var_a504287b.objective_time : 0;
    esports_event.var_a6134363 = isdefined(var_a6134363) ? var_a6134363 - var_a504287b.var_a6134363 : 0;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 0, eflags: 0x0
// Checksum 0xc628d8ac, Offset: 0x2ea8
// Size: 0x2fe
function function_2d28a3b3() {
    var_a504287b = self.var_a504287b;
    persistent_data = self.pers;
    rounds_won = util::getroundswon(self.team);
    if (!isdefined(var_a504287b)) {
        return;
    }
    esports_event = {#kills:persistent_data[#"kills"] - var_a504287b.kills, #assists:persistent_data[#"deaths"] - var_a504287b.deaths, #deaths:persistent_data[#"assists"] - var_a504287b.assists, #damage_dealt:persistent_data[#"damagedone"] - var_a504287b.damage_done, #var_52bfc9cc:var_a504287b.var_52bfc9cc, #multikills:persistent_data[#"hash_104ec9727c3d4ef7"] - var_a504287b.multikills, #var_a0380c47:var_a504287b.var_fc1e4ef3, #time_alive:persistent_data[#"time_played_alive"] - var_a504287b.time_alive, #var_e394d7c0:game.roundsplayed, #rounds_won:isdefined(rounds_won) ? rounds_won : 0, #score:persistent_data[#"score"] - var_a504287b.score, #shots_fired:persistent_data[#"shotsfired"] - var_a504287b.shots_fired, #shots_hit:persistent_data[#"shotshit"] - var_a504287b.shots_hit, #var_d75d8ad2:persistent_data[#"headshothits"] - var_a504287b.var_d75d8ad2, #player:self.name};
    var_284ea17f = #"hash_15b84d837906d158";
    if (isdefined(level.var_86d47028)) {
        var_284ea17f = level.var_86d47028.var_284ea17f;
        self [[ level.var_86d47028.data_function ]](esports_event);
    }
    self function_678f57c8(var_284ea17f, esports_event);
    self.var_7a967a71.round_end = 1;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 2, eflags: 0x0
// Checksum 0x4f295310, Offset: 0x31b0
// Size: 0x8e
function function_712f816a(esports_event, player) {
    esports_event.var_943dace9 = self.var_a4926509 != #"none";
    esports_event.var_7407eb67 = self.iscontested;
    esports_event.var_a50591bc = function_ddf02547();
    if (!isdefined(player)) {
        esports_event.player = "none";
        return;
    }
    esports_event.player = player.name;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 2, eflags: 0x0
// Checksum 0x77665af, Offset: 0x3248
// Size: 0x92
function function_150786f3(esports_event, player) {
    if (!isdefined(player)) {
        esports_event.player = "none";
        esports_event.var_f4f5d0fd = 0;
    } else {
        esports_event.player = player.name;
        esports_event.var_f4f5d0fd = player.isbombcarrier;
    }
    esports_event.var_a50591bc = function_a6f108b5();
    esports_event.var_f04ca204 = level.bombplanted;
    esports_event.var_72f6a393 = level.bombdefused;
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 2, eflags: 0x0
// Checksum 0xd6dd98c0, Offset: 0x32e8
// Size: 0xb6
function function_cdce904b(esports_event, player) {
    esports_event.player = player.name;
    esports_event.var_a50591bc = function_d4ad62c7();
    esports_event.var_943dace9 = self.var_a4926509 != #"none";
    esports_event.var_7407eb67 = self.contested;
    esports_event.var_b910ed34 = game.lives[#"allies"];
    esports_event.var_33a590ba = game.lives[#"axis"];
}

// Namespace namespace_4b798cb0/namespace_4b798cb0
// Params 1, eflags: 0x0
// Checksum 0xa00de960, Offset: 0x33a8
// Size: 0x134
function function_d5aacfd7(credit_player) {
    origin = self.origin;
    esports_event = {#var_94e96e7d:origin[0], #var_830acac0:origin[1], #var_94d1ee7a:origin[2], #var_7b99e470:function_1674a96a(self.var_a4926509), #var_34d28e72:function_f8d53445()};
    var_284ea17f = #"hash_3cb91ecb4b176d16";
    if (isdefined(level.var_8d67cbd8)) {
        var_284ea17f = level.var_8d67cbd8.var_284ea17f;
        self [[ level.var_8d67cbd8.data_function ]](esports_event, credit_player);
    }
    function_92d1707f(var_284ea17f, esports_event);
}

