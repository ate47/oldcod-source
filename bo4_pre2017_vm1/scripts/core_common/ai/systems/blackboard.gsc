#namespace blackboard;

// Namespace blackboard/blackboard
// Params 4, eflags: 0x0
// Checksum 0xb0458770, Offset: 0x88
// Size: 0x15c
function registerblackboardattribute(entity, attributename, defaultattributevalue, getterfunction) {
    /#
        assert(isdefined(entity.__blackboard), "<dev string:x28>");
    #/
    /#
        assert(!isdefined(entity.__blackboard[attributename]), "<dev string:x65>" + attributename + "<dev string:x7d>");
    #/
    if (isdefined(getterfunction)) {
        /#
            assert(isfunctionptr(getterfunction));
        #/
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
// Params 2, eflags: 0x0
// Checksum 0x53c81d1e, Offset: 0x1f0
// Size: 0xca
function getstructblackboardattribute(struct, attributename) {
    /#
        assert(isstruct(struct));
    #/
    if (isfunctionptr(struct.__blackboard[attributename])) {
        getterfunction = struct.__blackboard[attributename];
        attributevalue = struct [[ getterfunction ]]();
        return attributevalue;
    }
    return struct.__blackboard[attributename];
}

// Namespace blackboard/blackboard
// Params 3, eflags: 0x0
// Checksum 0xdf04a328, Offset: 0x2c8
// Size: 0xfe
function setstructblackboardattribute(struct, attributename, attributevalue) {
    /#
        assert(isstruct(struct));
    #/
    if (isdefined(struct.__blackboard[attributename])) {
        if (!isdefined(attributevalue) && isfunctionptr(struct.__blackboard[attributename])) {
            return;
        }
        /#
            assert(!isfunctionptr(struct.__blackboard[attributename]), "<dev string:x92>");
        #/
    }
    struct.__blackboard[attributename] = attributevalue;
}

// Namespace blackboard/blackboard
// Params 1, eflags: 0x0
// Checksum 0xf1739bd6, Offset: 0x3d0
// Size: 0x88
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
// Checksum 0x85f00b7a, Offset: 0x460
// Size: 0x130
function cloneblackboardfromstruct(struct) {
    /#
        assert(isstruct(struct));
    #/
    blackboard = array();
    if (isdefined(struct.__blackboard)) {
        attributes = getarraykeys(struct.__blackboard);
        foreach (attribute in attributes) {
            blackboard[attribute] = getstructblackboardattribute(struct, attribute);
        }
    }
    return blackboard;
}

