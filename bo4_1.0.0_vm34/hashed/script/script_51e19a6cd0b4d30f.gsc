#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;

#namespace namespace_fe84c968;

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 0, eflags: 0x0
// Checksum 0xc7c2c167, Offset: 0xa8
// Size: 0x94
function init() {
    registerclientfield("toplayer", "RGB_keyboard_manager", 1, 3, "int");
    if (ispc() && getdvarint(#"hash_cca6902a7ce5273", 0) == 1) {
        callback::on_game_playing(&function_72ff96e1);
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 0, eflags: 0x0
// Checksum 0xbd7f8d07, Offset: 0x148
// Size: 0xa4
function function_72ff96e1() {
    if (level.console) {
        return;
    }
    if (sessionmodeismultiplayergame()) {
        thread function_eaf1096d();
    }
    level waittill(#"player_spawned");
    if (isdefined(level.playerinsertion) && level.playerinsertion == 0) {
        thread function_ce15a01e();
        return;
    }
    thread function_db6f95dc();
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 0, eflags: 0x0
// Checksum 0x1fa3e1b1, Offset: 0x1f8
// Size: 0x13c
function function_ce15a01e() {
    self endon(#"game_ended");
    level waittill(#"potm_selected");
    if (!isdefined(level.var_5394a567)) {
        return;
    }
    event = game.potmevents[level.var_5394a567];
    player = undefined;
    if (isdefined(event)) {
        player = level.players[event.clientnum];
        if (isdefined(event.currentevent) && isdefined(event.currentevent.killcamparams)) {
            killcamparams = event.currentevent.killcamparams;
            if (isdefined(killcamparams) && !event.currentevent.var_6f1176) {
                player = level.players[killcamparams.spectatorclient];
            }
        }
    }
    if (isdefined(player)) {
        player clientfield::set_to_player("RGB_keyboard_manager", 1);
    }
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x340
// Size: 0x4
function function_db6f95dc() {
    
}

// Namespace namespace_fe84c968/namespace_ad168a0f
// Params 0, eflags: 0x0
// Checksum 0x5b97b4c, Offset: 0x350
// Size: 0x204
function function_eaf1096d() {
    while (!(isdefined(level.gameended) && level.gameended)) {
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
            event = 2;
        } else if (winning_teams[0] == "allies") {
            event = 3;
        } else if (winning_teams[0] == "axis") {
            event = 4;
        }
        foreach (player in level.players) {
            player clientfield::set_to_player("RGB_keyboard_manager", event);
        }
    }
}

