#using scripts/core_common/ai/archetype_utility;

#namespace animationstatenetworkutility;

// Namespace animationstatenetworkutility/animation_state_machine_utility
// Params 2, eflags: 0x0
// Checksum 0x8920f95, Offset: 0xd0
// Size: 0x4c
function requeststate(entity, statename) {
    assert(isdefined(entity));
    entity asmrequestsubstate(statename);
}

// Namespace animationstatenetworkutility/animation_state_machine_utility
// Params 2, eflags: 0x0
// Checksum 0x72407972, Offset: 0x128
// Size: 0x84
function searchanimationmap(entity, aliasname) {
    if (isdefined(entity) && isdefined(aliasname)) {
        animationname = entity animmappingsearch(istring(aliasname));
        if (isdefined(animationname)) {
            return findanimbyname("generic", animationname);
        }
    }
}

