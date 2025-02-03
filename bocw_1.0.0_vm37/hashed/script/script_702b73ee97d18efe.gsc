#using scripts\core_common\lui_shared;

#namespace bountyhunterbuy;

// Namespace bountyhunterbuy
// Method(s) 5 Total 12
class cbountyhunterbuy : cluielem {

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 2, eflags: 0x0
    // Checksum 0x17ecf036, Offset: 0x1c0
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1, eflags: 0x0
    // Checksum 0xfe1401af, Offset: 0x208
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 0, eflags: 0x0
    // Checksum 0xe815de45, Offset: 0x198
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("BountyHunterBuy");
    }

}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 0, eflags: 0x0
// Checksum 0xcf75d06e, Offset: 0xa8
// Size: 0x34
function register() {
    elem = new cbountyhunterbuy();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 2, eflags: 0x0
// Checksum 0x35673d9d, Offset: 0xe8
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x9a12b086, Offset: 0x128
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x49a08577, Offset: 0x150
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

