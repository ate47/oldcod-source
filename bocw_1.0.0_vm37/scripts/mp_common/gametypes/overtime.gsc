#namespace overtime;

// Namespace overtime/overtime
// Params 0, eflags: 0x2
// Checksum 0xc9077878, Offset: 0x70
// Size: 0x3c
function autoexec main() {
    if (!isdefined(game.overtime_round)) {
        game.overtime_round = 0;
    }
    if (!isdefined(level.nextroundisovertime)) {
        level.nextroundisovertime = 0;
    }
}

// Namespace overtime/overtime
// Params 0, eflags: 0x0
// Checksum 0xe8325ffe, Offset: 0xb8
// Size: 0x1c
function is_overtime_round() {
    if (game.overtime_round > 0) {
        return true;
    }
    return false;
}

// Namespace overtime/overtime
// Params 0, eflags: 0x0
// Checksum 0x94f50251, Offset: 0xe0
// Size: 0x19a
function round_stats_init() {
    if (is_overtime_round()) {
        setmatchflag("overtime", 1);
    } else {
        setmatchflag("overtime", 0);
    }
    if (!isdefined(game.stat[#"overtimeroundswon"])) {
        game.stat[#"overtimeroundswon"] = [];
    }
    if (!isdefined(game.stat[#"overtimeroundswon"][#"tie"])) {
        game.stat[#"overtimeroundswon"][#"tie"] = 0;
    }
    foreach (team, _ in level.teams) {
        if (!isdefined(game.stat[#"overtimeroundswon"][team])) {
            game.stat[#"overtimeroundswon"][team] = 0;
        }
    }
}

// Namespace overtime/overtime
// Params 0, eflags: 0x0
// Checksum 0x7c320daa, Offset: 0x288
// Size: 0x30
function get_rounds_played() {
    if (game.overtime_round == 0) {
        return game.overtime_round;
    }
    return game.overtime_round - 1;
}

// Namespace overtime/overtime
// Params 0, eflags: 0x0
// Checksum 0x63f34f75, Offset: 0x2c0
// Size: 0x44
function function_f435f4dd() {
    if (isdefined(level.shouldplayovertimeround)) {
        if ([[ level.shouldplayovertimeround ]]()) {
            level.nextroundisovertime = 1;
            return;
        }
    }
    level.nextroundisovertime = 0;
}

