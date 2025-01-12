#using scripts\core_common\lui_shared;

#namespace scavenger_icon;

// Namespace scavenger_icon
// Method(s) 7 Total 13
class cscavenger_icon : cluielem {

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0x1601ed4f, Offset: 0x318
    // Size: 0x6c
    function increment_pulse(localclientnum) {
        current_val = get_data(localclientnum, "pulse");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "pulse", new_val);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0x6b826a08, Offset: 0x2e0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"scavenger_icon");
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0x5d5a9ed, Offset: 0x298
    // Size: 0x40
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "pulse", 0);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 1, eflags: 0x0
    // Checksum 0x28594e43, Offset: 0x268
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cscavenger_icon/scavenger_icon
    // Params 2, eflags: 0x0
    // Checksum 0xaecada84, Offset: 0x208
    // Size: 0x54
    function setup_clientfields(uid, var_9bf17359) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("pulse", 1, 1, "counter", var_9bf17359);
    }

}

// Namespace scavenger_icon/scavenger_icon
// Params 2, eflags: 0x0
// Checksum 0xf1b681cb, Offset: 0xa8
// Size: 0x4c
function register(uid, var_9bf17359) {
    elem = new cscavenger_icon();
    [[ elem ]]->setup_clientfields(uid, var_9bf17359);
    return elem;
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x6d675090, Offset: 0x100
// Size: 0x40
function register_clientside(uid) {
    elem = new cscavenger_icon();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x50b9142d, Offset: 0x148
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0x192a85ad, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xa82f1efc, Offset: 0x198
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace scavenger_icon/scavenger_icon
// Params 1, eflags: 0x0
// Checksum 0xb76f1632, Offset: 0x1c0
// Size: 0x1c
function increment_pulse(localclientnum) {
    [[ self ]]->increment_pulse(localclientnum);
}

