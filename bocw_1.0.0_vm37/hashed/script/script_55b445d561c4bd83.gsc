#using scripts\core_common\callbacks_shared;

#namespace bot_difficulty;

// Namespace bot_difficulty/bot_difficulty
// Params 0, eflags: 0x0
// Checksum 0x3fc8c34d, Offset: 0x68
// Size: 0x24
function preinit() {
    callback::on_joined_team(&function_e161bc77);
}

// Namespace bot_difficulty/bot_difficulty
// Params 1, eflags: 0x4
// Checksum 0xaf88b1f7, Offset: 0x98
// Size: 0x3c
function private function_e161bc77(*params) {
    if (!isbot(self)) {
        return;
    }
    self assign();
}

// Namespace bot_difficulty/bot_difficulty
// Params 0, eflags: 0x0
// Checksum 0x6fcf4197, Offset: 0xe0
// Size: 0x74
function assign() {
    sessionmode = currentsessionmode();
    switch (sessionmode) {
    case 1:
        self function_d46cc4f5();
        break;
    }
    self callback::callback(#"hash_730d00ef91d71acf");
}

// Namespace bot_difficulty/bot_difficulty
// Params 0, eflags: 0x4
// Checksum 0x79d1444d, Offset: 0x160
// Size: 0x52
function private function_d46cc4f5() {
    difficulty = level function_c0e2f147(self.team);
    self.bot.difficulty = level function_abad20c4(difficulty);
}

// Namespace bot_difficulty/bot_difficulty
// Params 1, eflags: 0x4
// Checksum 0x3f171cf, Offset: 0x1c0
// Size: 0xda
function private function_c0e2f147(team) {
    if (is_true(getgametypesetting(#"hash_c6a2e6c3e86125a"))) {
        return getgametypesetting(#"bot_difficulty_vs_bots");
    }
    if (!level.teambased) {
        team = #"allies";
    }
    teamstr = level.teams[team];
    if (!isdefined(teamstr)) {
        return undefined;
    }
    return getgametypesetting(#"hash_7a5a6325a6e843b7" + teamstr);
}

// Namespace bot_difficulty/bot_difficulty
// Params 1, eflags: 0x4
// Checksum 0xca08e35d, Offset: 0x2a8
// Size: 0xfa
function private function_abad20c4(difficulty = 0) {
    switch (difficulty) {
    case 1:
        return getscriptbundle(#"hash_4e14664ff6086a77");
    case 2:
        return getscriptbundle(#"hash_70373311631d808e");
    case 3:
        return getscriptbundle(#"hash_4e151fcf3acee254");
    case 0:
    default:
        return getscriptbundle(#"hash_e8255beefa53aa1");
    }
}

