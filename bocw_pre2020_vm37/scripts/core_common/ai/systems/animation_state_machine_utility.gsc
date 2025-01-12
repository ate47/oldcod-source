#namespace animationstatenetworkutility;

// Namespace animationstatenetworkutility/animation_state_machine_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x59db3ab3, Offset: 0x60
// Size: 0x44
function requeststate(entity, statename) {
    assert(isdefined(entity));
    entity asmrequestsubstate(statename);
}

// Namespace animationstatenetworkutility/animation_state_machine_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x5b2259b8, Offset: 0xb0
// Size: 0x4c
function searchanimationmap(entity, aliasname) {
    if (isdefined(entity) && isdefined(aliasname)) {
        animationname = entity animmappingsearch(aliasname);
        return animationname;
    }
}

