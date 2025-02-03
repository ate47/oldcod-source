#using scripts\core_common\system_shared;
#using scripts\mp_common\teams\teamset;

#namespace teamset_axis;

// Namespace teamset_axis/teamset_axis
// Params 0, eflags: 0x6
// Checksum 0x83d74d17, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"teamset_axis", &preinit, undefined, undefined, undefined);
}

// Namespace teamset_axis/teamset_axis
// Params 0, eflags: 0x4
// Checksum 0x6e607f3b, Offset: 0x118
// Size: 0x4c
function private preinit() {
    if (!isdefined(level.teams[#"axis"])) {
        return;
    }
    init(level.teams[#"axis"]);
}

// Namespace teamset_axis/teamset_axis
// Params 1, eflags: 0x0
// Checksum 0xb64d42da, Offset: 0x170
// Size: 0x90
function init(team) {
    teamset::init();
    game.music["spawn_" + team] = "SPAWN_PMC";
    game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
    game.music["victory_" + team] = "VICTORY_PMC";
    game.voice[team] = "vox_pmc_";
}

