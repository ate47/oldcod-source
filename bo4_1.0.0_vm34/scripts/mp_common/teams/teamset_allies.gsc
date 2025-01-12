#using scripts\core_common\system_shared;
#using scripts\mp_common\teams\teamset;

#namespace teamset_allies;

// Namespace teamset_allies/teamset_allies
// Params 0, eflags: 0x2
// Checksum 0xa6ac2ffc, Offset: 0x110
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"teamset_allies", &__init__, undefined, undefined);
}

// Namespace teamset_allies/teamset_allies
// Params 0, eflags: 0x0
// Checksum 0x5a3aa08b, Offset: 0x158
// Size: 0xc4
function __init__() {
    init("free");
    foreach (team in level.teams) {
        if (team == #"axis") {
            continue;
        }
        init(team);
    }
    teamset::customteam_init();
}

// Namespace teamset_allies/teamset_allies
// Params 1, eflags: 0x0
// Checksum 0x2bb06656, Offset: 0x228
// Size: 0x13a
function init(team) {
    teamset::init();
    level.teamprefix[team] = "vox_st";
    level.teampostfix[team] = "st6";
    game.music["spawn_" + team] = "SPAWN_ST6";
    game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
    game.music["victory_" + team] = "VICTORY_ST6";
    game.voice[team] = "vox_st6_";
    game.flagmodels[team] = "p7_mp_flag_allies";
    game.carry_flagmodels[team] = "p7_mp_flag_allies_carry";
    game.flagmodels[#"neutral"] = "p7_mp_flag_neutral";
}

