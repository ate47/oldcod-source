#namespace overtime;

// Namespace overtime/overtime
// Params 0, eflags: 0x2
// Checksum 0x35430ed3, Offset: 0x78
// Size: 0x3e
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
// Checksum 0x462330cf, Offset: 0xc0
// Size: 0x1c
function is_overtime_round() {
    if (game.overtime_round > 0) {
        return true;
    }
    return false;
}

// Namespace overtime/overtime
// Params 0, eflags: 0x0
// Checksum 0x755aa54f, Offset: 0xe8
// Size: 0x1a0
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
// Checksum 0xb3e0691d, Offset: 0x290
// Size: 0x30
function get_rounds_played() {
    if (game.overtime_round == 0) {
        return game.overtime_round;
    }
    return game.overtime_round - 1;
}

// Namespace overtime/overtime
// Params 0, eflags: 0x0
// Checksum 0x66071a8f, Offset: 0x2c8
// Size: 0x46
function function_d699aea2() {
    if (isdefined(level.shouldplayovertimeround)) {
        if ([[ level.shouldplayovertimeround ]]()) {
            level.nextroundisovertime = 1;
            return;
        }
    }
    level.nextroundisovertime = 0;
}

