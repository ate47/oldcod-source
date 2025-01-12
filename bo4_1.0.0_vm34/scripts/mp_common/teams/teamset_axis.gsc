#using scripts\core_common\system_shared;
#using scripts\mp_common\teams\teamset;

#namespace teamset_axis;

// Namespace teamset_axis/teamset_axis
// Params 0, eflags: 0x2
// Checksum 0xa5072b83, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"teamset_axis", &__init__, undefined, undefined);
}

// Namespace teamset_axis/teamset_axis
// Params 0, eflags: 0x0
// Checksum 0x82ef2b89, Offset: 0x150
// Size: 0x3c
function __init__() {
    init(level.teams[#"axis"]);
    teamset::customteam_init();
}

// Namespace teamset_axis/teamset_axis
// Params 1, eflags: 0x0
// Checksum 0xb333acf9, Offset: 0x198
// Size: 0x13a
function init(team) {
    teamset::init();
    level.teamprefix[team] = "vox_pm";
    level.teampostfix[team] = "axis";
    game.music["spawn_" + team] = "SPAWN_PMC";
    game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
    game.music["victory_" + team] = "VICTORY_PMC";
    game.voice[team] = "vox_pmc_";
    game.flagmodels[team] = "p7_mp_flag_axis";
    game.carry_flagmodels[team] = "p7_mp_flag_axis_carry";
    game.flagmodels[#"neutral"] = "p7_mp_flag_neutral";
}

