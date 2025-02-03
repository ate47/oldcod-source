#using scripts\core_common\lui_shared;

#namespace incursion_infiltrationtitlecards;

// Namespace incursion_infiltrationtitlecards
// Method(s) 8 Total 15
class class_7c3faeda : cluielem {

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 1, eflags: 0x0
    // Checksum 0x1b1a6fb, Offset: 0x4b0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 0, eflags: 0x0
    // Checksum 0xf16e220f, Offset: 0x420
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("Incursion_InfiltrationTitleCards");
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 1, eflags: 0x0
    // Checksum 0x91a3eec3, Offset: 0x3a0
    // Size: 0x74
    function setup_clientfields(var_f1385203) {
        cluielem::setup_clientfields("Incursion_InfiltrationTitleCards");
        cluielem::add_clientfield("_state", 1, 4, "int");
        cluielem::add_clientfield("SelectedInfiltration", 1, 3, "int", var_f1385203);
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 2, eflags: 0x0
    // Checksum 0x710943cc, Offset: 0x4e0
    // Size: 0x34c
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"hash_1c7fa28cf1485078" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        if (#"hash_41af72ac3698f06f" == state_name) {
            set_data(localclientnum, "_state", 2);
            return;
        }
        if (#"hash_5b1f56f3d27d25f0" == state_name) {
            set_data(localclientnum, "_state", 3);
            return;
        }
        if (#"hash_249ee0339eddec66" == state_name) {
            set_data(localclientnum, "_state", 4);
            return;
        }
        if (#"hash_55a524ad199904e9" == state_name) {
            set_data(localclientnum, "_state", 5);
            return;
        }
        if (#"hash_37b2af92df0bfd42" == state_name) {
            set_data(localclientnum, "_state", 6);
            return;
        }
        if (#"hash_30029804cf01e828" == state_name) {
            set_data(localclientnum, "_state", 7);
            return;
        }
        if (#"hash_386af01523f194e5" == state_name) {
            set_data(localclientnum, "_state", 8);
            return;
        }
        if (#"hash_c5a40437efffe76" == state_name) {
            set_data(localclientnum, "_state", 9);
            return;
        }
        if (#"hash_88bd3835c23cdbc" == state_name) {
            set_data(localclientnum, "_state", 10);
            return;
        }
        if (#"hash_55e75da288d110d4" == state_name) {
            set_data(localclientnum, "_state", 11);
            return;
        }
        if (#"hash_3eb38ea38a92fe35" == state_name) {
            set_data(localclientnum, "_state", 12);
            return;
        }
        if (#"hash_79efd6a9d00cac13" == state_name) {
            set_data(localclientnum, "_state", 13);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 2, eflags: 0x0
    // Checksum 0xd5c68493, Offset: 0x838
    // Size: 0x30
    function function_ee0c7ef6(localclientnum, value) {
        set_data(localclientnum, "SelectedInfiltration", value);
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 1, eflags: 0x0
    // Checksum 0xf05413cb, Offset: 0x448
    // Size: 0x60
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "SelectedInfiltration", 0);
    }

}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 1, eflags: 0x0
// Checksum 0xf36cc3bf, Offset: 0xe8
// Size: 0x176
function register(var_f1385203) {
    elem = new class_7c3faeda();
    [[ elem ]]->setup_clientfields(var_f1385203);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"incursion_infiltrationtitlecards"])) {
        level.var_ae746e8f[#"incursion_infiltrationtitlecards"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"incursion_infiltrationtitlecards"])) {
        level.var_ae746e8f[#"incursion_infiltrationtitlecards"] = [];
    } else if (!isarray(level.var_ae746e8f[#"incursion_infiltrationtitlecards"])) {
        level.var_ae746e8f[#"incursion_infiltrationtitlecards"] = array(level.var_ae746e8f[#"incursion_infiltrationtitlecards"]);
    }
    level.var_ae746e8f[#"incursion_infiltrationtitlecards"][level.var_ae746e8f[#"incursion_infiltrationtitlecards"].size] = elem;
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 0, eflags: 0x0
// Checksum 0x7b5e6010, Offset: 0x268
// Size: 0x34
function register_clientside() {
    elem = new class_7c3faeda();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 1, eflags: 0x0
// Checksum 0x7e8bedc5, Offset: 0x2a8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 1, eflags: 0x0
// Checksum 0xa4050258, Offset: 0x2d0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 1, eflags: 0x0
// Checksum 0xd15b7cf, Offset: 0x2f8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 2, eflags: 0x0
// Checksum 0x4e384855, Offset: 0x320
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 2, eflags: 0x0
// Checksum 0xf5a6067e, Offset: 0x350
// Size: 0x28
function function_ee0c7ef6(localclientnum, value) {
    [[ self ]]->function_ee0c7ef6(localclientnum, value);
}

