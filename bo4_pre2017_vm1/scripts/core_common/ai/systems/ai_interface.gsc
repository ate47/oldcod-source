#namespace ai_interface;

/#

    // Namespace ai_interface/ai_interface
    // Params 0, eflags: 0x2
    // Checksum 0x312cb16c, Offset: 0x108
    // Size: 0x30
    function autoexec main() {
        level.__ai_debuginterface = getdvarint("<dev string:x28>");
    }

    // Namespace ai_interface/ai_interface
    // Params 3, eflags: 0x4
    // Checksum 0x4485d7d4, Offset: 0x140
    // Size: 0x2e6
    function private _checkvalue(archetype, attributename, value) {
        attribute = level.__ai_interface[archetype][attributename];
        switch (attribute["<dev string:x3a>"]) {
        case #"_interface_entity":
            break;
        case #"_interface_match":
            possiblevalues = attribute["<dev string:x62>"];
            assert(!isarray(possiblevalues) || isinarray(possiblevalues, value), "<dev string:x69>" + value + "<dev string:x6f>" + attributename + "<dev string:xa2>");
            break;
        case #"_interface_numeric":
            maxvalue = attribute["<dev string:xb8>"];
            minvalue = attribute["<dev string:xc2>"];
            assert(isint(value) || isfloat(value), "<dev string:xcc>" + attributename + "<dev string:xdc>" + value + "<dev string:xfd>");
            assert(value <= maxvalue && (!isdefined(maxvalue) && !isdefined(minvalue) || value >= minvalue), "<dev string:x69>" + value + "<dev string:x111>" + minvalue + "<dev string:x135>" + maxvalue + "<dev string:x137>");
            break;
        case #"_interface_vector":
            if (isdefined(value)) {
                assert(isvec(value), "<dev string:xcc>" + attributename + "<dev string:x14c>" + value + "<dev string:xfd>");
            }
            break;
        default:
            assert("<dev string:x16c>" + attribute["<dev string:x3a>"] + "<dev string:x18c>" + attributename + "<dev string:xa2>");
            break;
        }
    }

    // Namespace ai_interface/ai_interface
    // Params 2, eflags: 0x4
    // Checksum 0xe465e6fa, Offset: 0x430
    // Size: 0x2f4
    function private _checkprerequisites(entity, attribute) {
        assert(isentity(entity) || isstruct(entity), "<dev string:x19e>");
        assert(isactor(entity) || isvehicle(entity) || isstruct(entity), "<dev string:x1ce>");
        assert(isstring(attribute), "<dev string:x208>");
        if (isdefined(level.__ai_debuginterface) && level.__ai_debuginterface > 0) {
            assert(isarray(entity.__interface), "<dev string:x231>" + entity.archetype + "<dev string:x23d>" + "<dev string:x26e>");
            assert(isarray(level.__ai_interface), "<dev string:x29d>");
            assert(isarray(level.__ai_interface[entity.archetype]), "<dev string:x2e6>" + entity.archetype + "<dev string:x308>");
            assert(isarray(level.__ai_interface[entity.archetype][attribute]), "<dev string:xcc>" + attribute + "<dev string:x320>" + entity.archetype + "<dev string:x34a>");
            assert(isstring(level.__ai_interface[entity.archetype][attribute]["<dev string:x3a>"]), "<dev string:x351>" + attribute + "<dev string:xa2>");
        }
    }

    // Namespace ai_interface/ai_interface
    // Params 3, eflags: 0x4
    // Checksum 0xddd124ad, Offset: 0x730
    // Size: 0xcc
    function private _checkregistrationprerequisites(archetype, attribute, callbackfunction) {
        assert(isstring(archetype), "<dev string:x377>");
        assert(isstring(attribute), "<dev string:x3ac>");
        assert(!isdefined(callbackfunction) || isfunctionptr(callbackfunction), "<dev string:x3e1>");
    }

#/

// Namespace ai_interface/ai_interface
// Params 1, eflags: 0x4
// Checksum 0xe337ee84, Offset: 0x808
// Size: 0x56
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
// Checksum 0x9090fe25, Offset: 0x868
// Size: 0x30
function createinterfaceforentity(entity) {
    if (!isdefined(entity.__interface)) {
        entity.__interface = [];
    }
}

// Namespace ai/ai_interface
// Params 2, eflags: 0x0
// Checksum 0xea0efd36, Offset: 0x8a0
// Size: 0x8c
function getaiattribute(entity, attribute) {
    /#
        ai_interface::_checkprerequisites(entity, attribute);
    #/
    if (!isdefined(entity.__interface[attribute])) {
        return level.__ai_interface[entity.archetype][attribute]["default_value"];
    }
    return entity.__interface[attribute];
}

// Namespace ai/ai_interface
// Params 2, eflags: 0x0
// Checksum 0x15ce1adc, Offset: 0x938
// Size: 0x90
function hasaiattribute(entity, attribute) {
    return isdefined(entity) && isdefined(attribute) && isdefined(entity.archetype) && isdefined(level.__ai_interface) && isdefined(level.__ai_interface[entity.archetype]) && isdefined(level.__ai_interface[entity.archetype][attribute]);
}

// Namespace ai/ai_interface
// Params 4, eflags: 0x0
// Checksum 0x65d21183, Offset: 0x9d0
// Size: 0x16c
function registerentityinterface(archetype, attribute, defaultvalue, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x69>" + attribute + "<dev string:x431>" + archetype + "<dev string:x459>");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute]["type"] = "_interface_entity";
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai/ai_interface
// Params 5, eflags: 0x0
// Checksum 0x7eca11bd, Offset: 0xb48
// Size: 0x1dc
function registermatchedinterface(archetype, attribute, defaultvalue, possiblevalues, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
        assert(!isdefined(possiblevalues) || isarray(possiblevalues), "<dev string:x45b>");
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x69>" + attribute + "<dev string:x431>" + archetype + "<dev string:x459>");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute]["type"] = "_interface_match";
    level.__ai_interface[archetype][attribute]["values"] = possiblevalues;
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai/ai_interface
// Params 6, eflags: 0x0
// Checksum 0xd87b1baa, Offset: 0xd30
// Size: 0x31c
function registernumericinterface(archetype, attribute, defaultvalue, minimum, maximum, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
        assert(!isdefined(minimum) || isint(minimum) || isfloat(minimum), "<dev string:x49f>");
        assert(!isdefined(maximum) || isint(maximum) || isfloat(maximum), "<dev string:x4dd>");
        assert(isdefined(minimum) && (!isdefined(minimum) && !isdefined(maximum) || isdefined(maximum)), "<dev string:x51b>");
        assert(!isdefined(minimum) && !isdefined(maximum) || minimum <= maximum, "<dev string:xcc>" + attribute + "<dev string:x56f>" + "<dev string:x598>");
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x69>" + attribute + "<dev string:x431>" + archetype + "<dev string:x459>");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute]["max_value"] = maximum;
    level.__ai_interface[archetype][attribute]["min_value"] = minimum;
    level.__ai_interface[archetype][attribute]["type"] = "_interface_numeric";
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai/ai_interface
// Params 4, eflags: 0x0
// Checksum 0xdb35a9df, Offset: 0x1058
// Size: 0x16c
function registervectorinterface(archetype, attribute, defaultvalue, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x69>" + attribute + "<dev string:x431>" + archetype + "<dev string:x459>");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute]["type"] = "_interface_vector";
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai/ai_interface
// Params 3, eflags: 0x0
// Checksum 0xbd6aea3c, Offset: 0x11d0
// Size: 0x142
function setaiattribute(entity, attribute, value) {
    /#
        ai_interface::_checkprerequisites(entity, attribute);
        ai_interface::_checkvalue(entity.archetype, attribute, value);
    #/
    oldvalue = entity.__interface[attribute];
    if (!isdefined(oldvalue)) {
        oldvalue = level.__ai_interface[entity.archetype][attribute]["default_value"];
    }
    entity.__interface[attribute] = value;
    callback = level.__ai_interface[entity.archetype][attribute]["callback"];
    if (isfunctionptr(callback)) {
        [[ callback ]](entity, attribute, oldvalue, value);
    }
}

