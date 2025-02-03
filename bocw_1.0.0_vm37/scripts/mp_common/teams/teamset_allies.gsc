#using scripts\core_common\system_shared;
#using scripts\mp_common\teams\teamset;

#namespace teamset_allies;

// Namespace teamset_allies/teamset_allies
// Params 0, eflags: 0x6
// Checksum 0xcf4aac9d, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"teamset_allies", &preinit, undefined, undefined, undefined);
}

// Namespace teamset_allies/teamset_allies
// Params 0, eflags: 0x4
// Checksum 0x203cf25c, Offset: 0x118
// Size: 0xc8
function private preinit() {
    init(#"none");
    foreach (team in level.teams) {
        if (team == #"axis") {
            continue;
        }
        init(team);
    }
}

// Namespace teamset_allies/teamset_allies
// Params 1, eflags: 0x0
// Checksum 0xccee5b2b, Offset: 0x1e8
// Size: 0x90
function init(team) {
    teamset::init();
    game.music["spawn_" + team] = "SPAWN_ST6";
    game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
    game.music["victory_" + team] = "VICTORY_ST6";
    game.voice[team] = "vox_st6_";
}

