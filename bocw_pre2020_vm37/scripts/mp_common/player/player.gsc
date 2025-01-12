#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\player\player_utils;

#namespace player;

// Namespace player/player
// Params 0, eflags: 0x2
// Checksum 0xa32792, Offset: 0xf0
// Size: 0x44
function autoexec __init__() {
    callback::on_spawned(&on_player_spawned);
    callback::on_game_playing(&on_game_playing);
}

// Namespace player/player
// Params 0, eflags: 0x1 linked
// Checksum 0x6f402371, Offset: 0x140
// Size: 0x32c
function spectate_player_watcher() {
    self endon(#"disconnect");
    /#
        if (!level.splitscreen && !level.hardcoremode && getdvarint(#"scr_showperksonspawn", 0) == 1 && !gamestate::is_game_over() && !isdefined(self.perkhudelem)) {
            if (level.perksenabled == 1) {
                self hud::showperks();
            }
        }
    #/
    self.watchingactiveclient = 1;
    while (true) {
        if (self.pers[#"team"] != #"spectator" || level.gameended) {
            if (!is_true(level.inprematchperiod)) {
                self val::reset(#"spectate", "freezecontrols");
                self val::reset(#"spectate", "disablegadgets");
            }
            self.watchingactiveclient = 0;
            break;
        }
        count = 0;
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].team != #"spectator") {
                count++;
                break;
            }
        }
        if (count > 0) {
            if (!self.watchingactiveclient) {
                self val::reset(#"spectate", "freezecontrols");
                self val::reset(#"spectate", "disablegadgets");
                self luinotifyevent(#"player_spawned", 0);
            }
            self.watchingactiveclient = 1;
        } else {
            if (self.watchingactiveclient) {
                [[ level.onspawnspectator ]]();
                self val::set(#"spectate", "freezecontrols", 1);
                self val::set(#"spectate", "disablegadgets", 1);
            }
            self.watchingactiveclient = 0;
        }
        wait 0.5;
    }
}

// Namespace player/player
// Params 0, eflags: 0x1 linked
// Checksum 0xd8da24ad, Offset: 0x478
// Size: 0x2c
function reset_doublexp_timer() {
    self notify(#"reset_doublexp_timer");
    self thread doublexp_timer();
}

// Namespace player/player
// Params 0, eflags: 0x1 linked
// Checksum 0xb82f2447, Offset: 0x4b0
// Size: 0xbc
function doublexp_timer() {
    self notify(#"doublexp_timer");
    self endon(#"doublexp_timer", #"reset_doublexp_timer", #"end_game");
    level flag::wait_till("game_start_doublexp");
    if (!level.onlinegame) {
        return;
    }
    wait 60;
    if (level.onlinegame) {
        if (!isdefined(self)) {
            return;
        }
        self doublexptimerfired();
    }
    self thread reset_doublexp_timer();
}

// Namespace player/player
// Params 0, eflags: 0x1 linked
// Checksum 0x64392407, Offset: 0x578
// Size: 0x94
function on_player_spawned() {
    self thread doublexp_timer();
    profilestart();
    if (util::is_frontend_map()) {
        profilestop();
        return;
    }
    profilestop();
    if (self function_8b1a219a()) {
        self allowjump(0);
        wait 0.5;
        if (!isdefined(self)) {
            return;
        }
        self allowjump(1);
    }
}

// Namespace player/player
// Params 0, eflags: 0x1 linked
// Checksum 0x449c35d8, Offset: 0x618
// Size: 0x24
function on_game_playing() {
    level flag::set("game_start_doublexp");
}

// Namespace player/player
// Params 0, eflags: 0x1 linked
// Checksum 0xff90e8c9, Offset: 0x648
// Size: 0x6e
function function_490dc3d3() {
    return self isinvehicle() && !self isremotecontrolling() && self function_a867284b() && self playerads() >= 1;
}

// Namespace player/player
// Params 0, eflags: 0x1 linked
// Checksum 0x66fc4a9d, Offset: 0x6c0
// Size: 0x98
function function_c3eed624() {
    origin = self.origin;
    if (self function_490dc3d3()) {
        forward = anglestoforward(self.angles);
        origin += forward * self function_85d25868();
        origin -= (0, 0, isdefined(self.var_2d23ee07) ? self.var_2d23ee07 : 0);
    }
    return origin;
}

// Namespace player/player
// Params 0, eflags: 0x0
// Checksum 0x8f227b5a, Offset: 0x760
// Size: 0x2a8
function last_valid_position() {
    self endon(#"disconnect");
    self notify(#"stop_last_valid_position");
    self endon(#"stop_last_valid_position");
    while (!isdefined(self.last_valid_position) && isdefined(self)) {
        origin = self function_c3eed624();
        self.last_valid_position = getclosestpointonnavmesh(origin, 2048, 0);
        wait 0.1;
    }
    while (isdefined(self)) {
        origin = self function_c3eed624();
        if (getdvarint(#"hash_1a597b008cc91bd8", 0) > 0) {
            wait 1;
            continue;
        }
        playerradius = self getpathfindingradius();
        if (distance2dsquared(origin, self.last_valid_position) < function_a3f6cdac(playerradius) && function_a3f6cdac(origin[2] - self.last_valid_position[2]) < function_a3f6cdac(16)) {
            wait 0.1;
            continue;
        }
        if (ispointonnavmesh(origin, self)) {
            self.last_valid_position = origin;
        } else if (!ispointonnavmesh(origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(origin, self.last_valid_position) < function_a3f6cdac(32)) {
            wait 0.1;
            continue;
        } else {
            position = getclosestpointonnavmesh(origin, 100, playerradius);
            if (isdefined(position)) {
                self.last_valid_position = position;
            }
        }
        wait 0.1;
    }
}

