#using scripts\core_common\system_shared;
#using scripts\mp_common\teams\teamset;

#namespace teamset_axis;

// Namespace teamset_axis/teamset_axis
// Params 0, eflags: 0x6
// Checksum 0x4aefa7d9, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"teamset_axis", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace teamset_axis/teamset_axis
// Params 0, eflags: 0x5 linked
// Checksum 0x3beb018a, Offset: 0x118
// Size: 0x4c
function private function_70a657d8() {
    if (!isdefined(level.teams[#"axis"])) {
        return;
    }
    init(level.teams[#"axis"]);
}

// Namespace teamset_axis/teamset_axis
// Params 1, eflags: 0x1 linked
// Checksum 0xbbe32206, Offset: 0x170
// Size: 0x90
function init(team) {
    teamset::init();
    game.music["spawn_" + team] = "SPAWN_PMC";
    game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
    game.music["victory_" + team] = "VICTORY_PMC";
    game.voice[team] = "vox_pmc_";
}

