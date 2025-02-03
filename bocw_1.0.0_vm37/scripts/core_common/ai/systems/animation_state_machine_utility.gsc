#namespace animationstatenetworkutility;

// Namespace animationstatenetworkutility/animation_state_machine_utility
// Params 2, eflags: 0x0
// Checksum 0xe8c8df2, Offset: 0x60
// Size: 0x44
function requeststate(entity, statename) {
    assert(isdefined(entity));
    entity asmrequestsubstate(statename);
}

// Namespace animationstatenetworkutility/animation_state_machine_utility
// Params 2, eflags: 0x0
// Checksum 0xc15c83c1, Offset: 0xb0
// Size: 0x4c
function searchanimationmap(entity, aliasname) {
    if (isdefined(entity) && isdefined(aliasname)) {
        animationname = entity animmappingsearch(aliasname);
        return animationname;
    }
}

