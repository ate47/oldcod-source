#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace scavenger_icon;

// Namespace scavenger_icon
// Method(s) 6 Total 13
class cscavenger_icon : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cscavenger_icon/scavenger_icon
    // Params 2, eflags: 0x1 linked
    // Checksum 0x220858ac, Offset: 0x230
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x1 linked
    // Checksum 0x88ef8bd9, Offset: 0x278
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x1 linked
    // Checksum 0x590d3a5, Offset: 0x2a8
    // Size: 0x3c
    function increment_pulse(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "pulse");
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe71d0614, Offset: 0x1e0
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("scavenger_icon");
        cluielem::add_clientfield("pulse", 1, 1, "counter");
    }

}

// Namespace scavenger_icon/scavenger_icon
// Params 0, eflags: 0x1 linked
// Checksum 0x2eb6dda5, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new cscavenger_icon();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace scavenger_icon/scavenger_icon
// Params 2, eflags: 0x1 linked
// Checksum 0x35a9b000, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x8ae26129, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x1 linked
// Checksum 0x7830f9a3, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x1 linked
// Checksum 0xef8461db, Offset: 0x198
// Size: 0x1c
function increment_pulse(player) {
    [[ self ]]->increment_pulse(player);
}

