#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace namespace_1e38a8f6;

// Namespace namespace_1e38a8f6/namespace_78f31cd9
// Params 0, eflags: 0x1 linked
// Checksum 0x74e74102, Offset: 0xb8
// Size: 0x54
function init() {
    registerclientfield("toplayer", "RGB_keyboard_manager", 1, 3, "int");
    callback::on_game_playing(&function_ca0a1ea4);
}

// Namespace namespace_1e38a8f6/namespace_78f31cd9
// Params 0, eflags: 0x1 linked
// Checksum 0x9f85ac8a, Offset: 0x118
// Size: 0x44
function function_ca0a1ea4() {
    level waittill(#"player_spawned");
    if (sessionmodeismultiplayergame()) {
        thread function_9e94a567();
    }
}

// Namespace namespace_1e38a8f6/namespace_78f31cd9
// Params 0, eflags: 0x1 linked
// Checksum 0x32515c54, Offset: 0x168
// Size: 0x22c
function function_9e94a567() {
    while (!is_true(level.gameended)) {
        wait 0.5;
        score = 0;
        winning_teams = [];
        if (!isdefined(level.teams)) {
            continue;
        }
        foreach (team, _ in level.teams) {
            team_score = game.stat[#"teamscores"][team];
            if (team_score > score) {
                score = team_score;
                winning_teams = [];
            }
            if (team_score == score) {
                winning_teams[winning_teams.size] = team;
            }
        }
        if (winning_teams.size != 1) {
            event = 1;
        } else if (winning_teams[0] == "allies") {
            event = 2;
        } else if (winning_teams[0] == "axis") {
            event = 3;
        }
        foreach (player in level.players) {
            if (player function_8b1a219a()) {
                player clientfield::set_to_player("RGB_keyboard_manager", event);
            }
        }
    }
}

