#namespace animationstatenetworkutility;

// Namespace animationstatenetworkutility/animation_state_machine_utility
// Params 2, eflags: 0x0
// Checksum 0x625abe5f, Offset: 0x68
// Size: 0x44
function requeststate(entity, statename) {
    assert(isdefined(entity));
    entity asmrequestsubstate(statename);
}

// Namespace animationstatenetworkutility/animation_state_machine_utility
// Params 2, eflags: 0x0
// Checksum 0x6960b53c, Offset: 0xb8
// Size: 0x4c
function searchanimationmap(entity, aliasname) {
    if (isdefined(entity) && isdefined(aliasname)) {
        animationname = entity animmappingsearch(aliasname);
        return animationname;
    }
}

