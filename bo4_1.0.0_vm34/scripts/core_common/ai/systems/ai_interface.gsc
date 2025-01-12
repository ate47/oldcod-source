#namespace ai_interface;

/#

    // Namespace ai_interface/ai_interface
    // Params 0, eflags: 0x2
    // Checksum 0x53edcf0c, Offset: 0xb0
    // Size: 0x36
    function autoexec main() {
        level.__ai_debuginterface = getdvarint(#"ai_debuginterface", 0);
    }

    // Namespace ai_interface/ai_interface
    // Params 3, eflags: 0x4
    // Checksum 0xf00c9c9b, Offset: 0xf0
    // Size: 0x32a
    function private _checkvalue(archetype, attributename, value) {
        attribute = level.__ai_interface[archetype][attributename];
        switch (attribute[#"type"]) {
        case #"_interface_entity":
            break;
        case #"_interface_match":
            possiblevalues = attribute[#"values"];
            assert(!isarray(possiblevalues) || isinarray(possiblevalues, value), "<dev string:x30>" + value + "<dev string:x36>" + attributename + "<dev string:x69>");
            break;
        case #"_interface_numeric":
            maxvalue = attribute[#"max_value"];
            minvalue = attribute[#"min_value"];
            assert(isint(value) || isfloat(value), "<dev string:x6c>" + attributename + "<dev string:x7c>" + value + "<dev string:x9d>");
            assert(!isdefined(maxvalue) && !isdefined(minvalue) || value <= maxvalue && value >= minvalue, "<dev string:x30>" + value + "<dev string:xb1>" + minvalue + "<dev string:xd5>" + maxvalue + "<dev string:xd7>");
            break;
        case #"_interface_vector":
            if (isdefined(value)) {
                assert(isvec(value), "<dev string:x6c>" + attributename + "<dev string:xda>" + value + "<dev string:x9d>");
            }
            break;
        default:
            assert("<dev string:xfa>" + attribute[#"type"] + "<dev string:x11a>" + attributename + "<dev string:x69>");
            break;
        }
    }

    // Namespace ai_interface/ai_interface
    // Params 2, eflags: 0x4
    // Checksum 0xe1c1de23, Offset: 0x428
    // Size: 0x314
    function private _checkprerequisites(entity, attribute) {
        if (isdefined(level.__ai_debuginterface) && level.__ai_debuginterface > 0) {
            assert(isentity(entity) || isstruct(entity), "<dev string:x12c>");
            assert(isactor(entity) || isvehicle(entity) || isstruct(entity) || isbot(entity), "<dev string:x15c>");
            assert(isstring(attribute), "<dev string:x196>");
            assert(isarray(entity.__interface), "<dev string:x1bf>" + function_15979fa9(entity.archetype) + "<dev string:x1cb>" + "<dev string:x1fc>");
            assert(isarray(level.__ai_interface), "<dev string:x22b>");
            assert(isarray(level.__ai_interface[entity.archetype]), "<dev string:x274>" + function_15979fa9(entity.archetype) + "<dev string:x296>");
            assert(isarray(level.__ai_interface[entity.archetype][attribute]), "<dev string:x6c>" + attribute + "<dev string:x2ae>" + function_15979fa9(entity.archetype) + "<dev string:x2d8>");
            assert(isstring(level.__ai_interface[entity.archetype][attribute][#"type"]), "<dev string:x2df>" + attribute + "<dev string:x69>");
        }
    }

    // Namespace ai_interface/ai_interface
    // Params 3, eflags: 0x4
    // Checksum 0x8aec4f17, Offset: 0x748
    // Size: 0xc4
    function private _checkregistrationprerequisites(archetype, attribute, callbackfunction) {
        assert(isstring(archetype), "<dev string:x305>");
        assert(isstring(attribute), "<dev string:x33a>");
        assert(!isdefined(callbackfunction) || isfunctionptr(callbackfunction), "<dev string:x36f>");
    }

#/

// Namespace ai_interface/ai_interface
// Params 1, eflags: 0x4
// Checksum 0xb4e7dc4c, Offset: 0x818
// Size: 0x52
function private _initializelevelinterface(archetype) {
    if (!isdefined(level.__ai_interface)) {
        level.__ai_interface = [];
    }
    if (!isdefined(level.__ai_interface[archetype])) {
        level.__ai_interface[archetype] = [];
    }
}

#namespace ai;

// Namespace ai/ai_interface
// Params 1, eflags: 0x0
// Checksum 0x57abf96e, Offset: 0x878
// Size: 0x2a
function createinterfaceforentity(entity) {
    if (!isdefined(entity.__interface)) {
        entity.__interface = [];
    }
}

// Namespace ai/ai_interface
// Params 2, eflags: 0x0
// Checksum 0x756f53ca, Offset: 0x8b0
// Size: 0x8c
function getaiattribute(entity, attribute) {
    /#
        ai_interface::_checkprerequisites(entity, attribute);
    #/
    if (!isdefined(entity.__interface[attribute])) {
        return level.__ai_interface[entity.archetype][attribute][#"default_value"];
    }
    return entity.__interface[attribute];
}

// Namespace ai/ai_interface
// Params 2, eflags: 0x0
// Checksum 0x30451ca, Offset: 0x948
// Size: 0x86
function hasaiattribute(entity, attribute) {
    return isdefined(entity) && isdefined(attribute) && isdefined(entity.archetype) && isdefined(level.__ai_interface) && isdefined(level.__ai_interface[entity.archetype]) && isdefined(level.__ai_interface[entity.archetype][attribute]);
}

// Namespace ai/ai_interface
// Params 4, eflags: 0x0
// Checksum 0x5ac95771, Offset: 0x9d8
// Size: 0x17c
function registerentityinterface(archetype, attribute, defaultvalue, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x30>" + attribute + "<dev string:x3bf>" + archetype + "<dev string:x3e7>");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute][#"type"] = "_interface_entity";
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai/ai_interface
// Params 5, eflags: 0x0
// Checksum 0x5d9b33d2, Offset: 0xb60
// Size: 0x1f4
function registermatchedinterface(archetype, attribute, defaultvalue, possiblevalues, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
        assert(!isdefined(possiblevalues) || isarray(possiblevalues), "<dev string:x3e9>");
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x30>" + attribute + "<dev string:x3bf>" + archetype + "<dev string:x3e7>");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute][#"type"] = "_interface_match";
    level.__ai_interface[archetype][attribute][#"values"] = possiblevalues;
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai/ai_interface
// Params 6, eflags: 0x0
// Checksum 0x7a34d386, Offset: 0xd60
// Size: 0x33c
function registernumericinterface(archetype, attribute, defaultvalue, minimum, maximum, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
        assert(!isdefined(minimum) || isint(minimum) || isfloat(minimum), "<dev string:x42d>");
        assert(!isdefined(maximum) || isint(maximum) || isfloat(maximum), "<dev string:x46b>");
        assert(!isdefined(minimum) && !isdefined(maximum) || isdefined(minimum) && isdefined(maximum), "<dev string:x4a9>");
        assert(!isdefined(minimum) && !isdefined(maximum) || minimum <= maximum, "<dev string:x6c>" + attribute + "<dev string:x4fd>" + "<dev string:x526>");
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x30>" + attribute + "<dev string:x3bf>" + archetype + "<dev string:x3e7>");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute][#"max_value"] = maximum;
    level.__ai_interface[archetype][attribute][#"min_value"] = minimum;
    level.__ai_interface[archetype][attribute][#"type"] = "_interface_numeric";
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai/ai_interface
// Params 4, eflags: 0x0
// Checksum 0x8b49a7c3, Offset: 0x10a8
// Size: 0x17c
function registervectorinterface(archetype, attribute, defaultvalue, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x30>" + attribute + "<dev string:x3bf>" + archetype + "<dev string:x3e7>");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute][#"type"] = "_interface_vector";
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai/ai_interface
// Params 3, eflags: 0x0
// Checksum 0x94e1b94, Offset: 0x1230
// Size: 0x130
function setaiattribute(entity, attribute, value) {
    /#
        ai_interface::_checkprerequisites(entity, attribute);
        ai_interface::_checkvalue(entity.archetype, attribute, value);
    #/
    oldvalue = entity.__interface[attribute];
    if (!isdefined(oldvalue)) {
        oldvalue = level.__ai_interface[entity.archetype][attribute][#"default_value"];
    }
    entity.__interface[attribute] = value;
    callback = level.__ai_interface[entity.archetype][attribute][#"callback"];
    if (isfunctionptr(callback)) {
        [[ callback ]](entity, attribute, oldvalue, value);
    }
}

