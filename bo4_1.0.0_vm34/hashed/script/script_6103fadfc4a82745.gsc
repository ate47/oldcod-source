#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace scavenger_icon;

// Namespace scavenger_icon
// Method(s) 6 Total 13
class cscavenger_icon : cluielem {

    var var_57a3d576;

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0xf157c062, Offset: 0x2b8
    // Size: 0x34
    function increment_pulse(player) {
        player clientfield::function_9d68ee55(var_57a3d576, "pulse");
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0x8e1f0424, Offset: 0x288
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 2, eflags: 0x0
    // Checksum 0xa1a60146, Offset: 0x238
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "scavenger_icon", persistent);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0x69424ef3, Offset: 0x1e0
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("pulse", 1, 1, "counter");
    }

}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x871c7773, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new cscavenger_icon();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace scavenger_icon/scavenger_icon
// Params 2, eflags: 0x0
// Checksum 0x7d421219, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x70755759, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xade728a0, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xd9d72a67, Offset: 0x198
// Size: 0x1c
function increment_pulse(player) {
    [[ self ]]->increment_pulse(player);
}

