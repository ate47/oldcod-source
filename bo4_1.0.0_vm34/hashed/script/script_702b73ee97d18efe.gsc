#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace bountyhunterbuy;

// Namespace bountyhunterbuy
// Method(s) 5 Total 12
class cbountyhunterbuy : cluielem {

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1, eflags: 0x0
    // Checksum 0xae5f28d1, Offset: 0x228
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 2, eflags: 0x0
    // Checksum 0xb515d6b6, Offset: 0x1d8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "BountyHunterBuy", persistent);
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1, eflags: 0x0
    // Checksum 0x4fa311ef, Offset: 0x1a8
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x7d1553fd, Offset: 0xb0
// Size: 0x40
function register(uid) {
    elem = new cbountyhunterbuy();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 2, eflags: 0x0
// Checksum 0x706d04f4, Offset: 0xf8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x7e5a3962, Offset: 0x138
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x6d97e32e, Offset: 0x160
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

