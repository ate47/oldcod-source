#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
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
// Checksum 0xc81f60db, Offset: 0xd0
// Size: 0x24
function autoexec __init__() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace player/player
// Params 0, eflags: 0x0
// Checksum 0xbc723bf7, Offset: 0x100
// Size: 0x33c
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
            if (!(isdefined(level.inprematchperiod) && level.inprematchperiod)) {
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
// Params 0, eflags: 0x0
// Checksum 0x5d9e0158, Offset: 0x448
// Size: 0x8c
function on_player_spawned() {
    profilestart();
    if (util::is_frontend_map()) {
        return;
    }
    self thread last_valid_position();
    profilestop();
    if (function_7d64cef6()) {
        self allowjump(0);
        wait 0.5;
        if (!isdefined(self)) {
            return;
        }
        self allowjump(1);
    }
}

// Namespace player/player
// Params 0, eflags: 0x0
// Checksum 0x2b9bdca8, Offset: 0x4e0
// Size: 0x6e
function function_a1724399() {
    return self isinvehicle() && !self isremotecontrolling() && self function_80cbd71f() && self playerads() >= 1;
}

// Namespace player/player
// Params 0, eflags: 0x0
// Checksum 0x20585e9c, Offset: 0x558
// Size: 0xa0
function function_c55f4782() {
    origin = self.origin;
    if (self function_a1724399()) {
        forward = anglestoforward(self.angles);
        origin += forward * self function_97b67b0();
        origin -= (0, 0, isdefined(self.var_6d1aee3e) ? self.var_6d1aee3e : 0);
    }
    return origin;
}

// Namespace player/player
// Params 0, eflags: 0x0
// Checksum 0x6a971327, Offset: 0x600
// Size: 0x288
function last_valid_position() {
    self endon(#"disconnect");
    self notify(#"stop_last_valid_position");
    self endon(#"stop_last_valid_position");
    while (!isdefined(self.last_valid_position)) {
        origin = self function_c55f4782();
        self.last_valid_position = getclosestpointonnavmesh(origin, 2048, 0);
        wait 0.1;
    }
    while (true) {
        origin = self function_c55f4782();
        if (getdvarint(#"hash_1a597b008cc91bd8", 0) > 0) {
            wait 1;
            continue;
        }
        playerradius = self getpathfindingradius();
        if (distance2dsquared(origin, self.last_valid_position) < playerradius * playerradius && (origin[2] - self.last_valid_position[2]) * (origin[2] - self.last_valid_position[2]) < 16 * 16) {
            wait 0.1;
            continue;
        }
        if (ispointonnavmesh(origin, self)) {
            self.last_valid_position = origin;
        } else if (!ispointonnavmesh(origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(origin, self.last_valid_position) < 32 * 32) {
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

