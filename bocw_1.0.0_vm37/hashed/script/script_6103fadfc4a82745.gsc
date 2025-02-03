#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace scavenger_icon;

// Namespace scavenger_icon
// Method(s) 8 Total 15
class cscavenger_icon : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cscavenger_icon/scavenger_icon
    // Params 2, eflags: 0x0
    // Checksum 0x70b08f85, Offset: 0x2f0
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xa4c21fba, Offset: 0x3f8
    // Size: 0x3c
    function function_417df30c(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "rareScrapPulse");
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xc64bfa37, Offset: 0x3b0
    // Size: 0x3c
    function function_47e82a09(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "scrapPulse");
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xa123afa3, Offset: 0x338
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 0, eflags: 0x0
    // Checksum 0x75fec4b3, Offset: 0x250
    // Size: 0x94
    function setup_clientfields() {
        cluielem::setup_clientfields("scavenger_icon");
        cluielem::add_clientfield("ammoPulse", 1, 1, "counter");
        cluielem::add_clientfield("scrapPulse", 1, 1, "counter");
        cluielem::add_clientfield("rareScrapPulse", 4000, 1, "counter");
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xab0b17fe, Offset: 0x368
    // Size: 0x3c
    function function_e4e9c303(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "ammoPulse");
    }

}

// Namespace scavenger_icon/scavenger_icon
// Params 0, eflags: 0x0
// Checksum 0x17851ee6, Offset: 0xe8
// Size: 0x34
function register() {
    elem = new cscavenger_icon();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace scavenger_icon/scavenger_icon
// Params 2, eflags: 0x0
// Checksum 0x672bc8a8, Offset: 0x128
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x2194ec3f, Offset: 0x168
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x37b19c38, Offset: 0x190
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xe43ca43d, Offset: 0x1b8
// Size: 0x1c
function function_e4e9c303(player) {
    [[ self ]]->function_e4e9c303(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xd34d9a84, Offset: 0x1e0
// Size: 0x1c
function function_47e82a09(player) {
    [[ self ]]->function_47e82a09(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x4b3ddf79, Offset: 0x208
// Size: 0x1c
function function_417df30c(player) {
    [[ self ]]->function_417df30c(player);
}

