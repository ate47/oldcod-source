#using scripts/core_common/bb_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/util_shared;

#namespace globallogic_score;

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xd5df73b2, Offset: 0x1c8
// Size: 0x54
function inctotalkills(team) {
    if (level.teambased && isdefined(level.teams[team])) {
        game.totalkillsteam[team]++;
    }
    game.totalkills++;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xb1d08094, Offset: 0x228
// Size: 0x4c
function givekillstats(smeansofdeath, weapon, evictim) {
    if (isdefined(level.scoreevents_givekillstats)) {
        [[ level.scoreevents_givekillstats ]](smeansofdeath, weapon, evictim);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xe9862b75, Offset: 0x280
// Size: 0x6c
function processassist(killedplayer, damagedone, weapon, assist_level) {
    if (!isdefined(assist_level)) {
        assist_level = undefined;
    }
    if (isdefined(level.scoreevents_processassist)) {
        [[ level.scoreevents_processassist ]](killedplayer, damagedone, weapon, assist_level);
    }
}

