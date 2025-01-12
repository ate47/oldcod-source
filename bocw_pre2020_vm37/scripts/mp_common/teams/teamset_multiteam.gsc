#using scripts\mp_common\teams\teamset;

#namespace teamset_multiteam;

// Namespace teamset_multiteam/teamset_multiteam
// Params 0, eflags: 0x0
// Checksum 0xb9909c25, Offset: 0x108
// Size: 0xd4
function main() {
    teamset::init();
    toggle = 0;
    foreach (team in level.teams) {
        if (toggle % 2) {
            init_axis(team);
        } else {
            init_allies(team);
        }
        toggle++;
    }
}

// Namespace teamset_multiteam/teamset_multiteam
// Params 1, eflags: 0x0
// Checksum 0xad220ea6, Offset: 0x1e8
// Size: 0x80
function init_allies(team) {
    game.music["spawn_" + team] = "SPAWN_ST6";
    game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
    game.music["victory_" + team] = "VICTORY_ST6";
    game.voice[team] = "vox_st6_";
}

// Namespace teamset_multiteam/teamset_multiteam
// Params 1, eflags: 0x0
// Checksum 0xcfffbec3, Offset: 0x270
// Size: 0x80
function init_axis(team) {
    game.music["spawn_" + team] = "SPAWN_PMC";
    game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
    game.music["victory_" + team] = "VICTORY_PMC";
    game.voice[team] = "vox_pmc_";
}

