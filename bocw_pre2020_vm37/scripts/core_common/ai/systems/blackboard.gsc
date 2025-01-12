#namespace blackboard;

// Namespace blackboard/blackboard
// Params 4, eflags: 0x0
// Checksum 0x5e828076, Offset: 0x60
// Size: 0x11c
function registerblackboardattribute(entity, attributename, defaultattributevalue, getterfunction) {
    assert(isdefined(entity.__blackboard), "<dev string:x38>");
    assert(!isdefined(entity.__blackboard[attributename]), "<dev string:x78>" + attributename + "<dev string:x93>");
    if (isdefined(getterfunction)) {
        assert(isfunctionptr(getterfunction));
        entity.__blackboard[attributename] = getterfunction;
    } else {
        if (!isdefined(defaultattributevalue)) {
            defaultattributevalue = undefined;
        }
        entity.__blackboard[attributename] = defaultattributevalue;
    }
    /#
        if (isactor(entity)) {
            entity trackblackboardattribute(attributename);
        }
    #/
}

// Namespace blackboard/blackboard
// Params 2, eflags: 0x1 linked
// Checksum 0xc3ffd096, Offset: 0x188
// Size: 0xc2
function getstructblackboardattribute(struct, attributename) {
    assert(isstruct(struct) || isentity(struct));
    if (isfunctionptr(struct.__blackboard[attributename])) {
        getterfunction = struct.__blackboard[attributename];
        attributevalue = struct [[ getterfunction ]]();
        return attributevalue;
    }
    return struct.__blackboard[attributename];
}

// Namespace blackboard/blackboard
// Params 3, eflags: 0x0
// Checksum 0xc1624791, Offset: 0x258
// Size: 0xec
function setstructblackboardattribute(struct, attributename, attributevalue) {
    assert(isstruct(struct) || isentity(struct));
    if (isdefined(struct.__blackboard[attributename])) {
        if (!isdefined(attributevalue) && isfunctionptr(struct.__blackboard[attributename])) {
            return;
        }
        assert(!isfunctionptr(struct.__blackboard[attributename]), "<dev string:xab>");
    }
    struct.__blackboard[attributename] = attributevalue;
}

// Namespace blackboard/blackboard
// Params 1, eflags: 0x1 linked
// Checksum 0x4ec063ec, Offset: 0x350
// Size: 0x7c
function createblackboardforentity(entity) {
    if (!isdefined(entity.__blackboard)) {
        entity.__blackboard = [];
        if (isentity(entity)) {
            entity createblackboardentries();
        }
    }
    if (!isdefined(level._setblackboardattributefunc)) {
        level._setblackboardattributefunc = &setblackboardattribute;
    }
}

// Namespace blackboard/blackboard
// Params 1, eflags: 0x0
// Checksum 0x7e29d254, Offset: 0x3d8
// Size: 0xfc
function cloneblackboardfromstruct(struct) {
    assert(isstruct(struct) || isentity(struct));
    blackboard = [];
    if (isdefined(struct.__blackboard)) {
        foreach (k, v in struct.__blackboard) {
            blackboard[k] = getstructblackboardattribute(struct, k);
        }
    }
    return blackboard;
}

