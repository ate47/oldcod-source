#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_generic_commander;
#using scripts\core_common\ai\systems\planner;

#namespace namespace_ceda4ee8;

// Namespace namespace_ceda4ee8/namespace_481d858b
// Params 1, eflags: 0x4
// Checksum 0x78815163, Offset: 0xa8
// Size: 0x32
function private _createcommanderplanner(team) {
    planner = plannerutility::createplannerfromasset("tdm_commander.ai_htn");
    return planner;
}

// Namespace namespace_ceda4ee8/namespace_481d858b
// Params 1, eflags: 0x4
// Checksum 0x83af176c, Offset: 0xe8
// Size: 0x32
function private _createsquadplanner(team) {
    planner = plannerutility::createplannerfromasset("tdm_squad.ai_htn");
    return planner;
}

// Namespace namespace_ceda4ee8/namespace_481d858b
// Params 1, eflags: 0x0
// Checksum 0x764140dc, Offset: 0x128
// Size: 0x80
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

