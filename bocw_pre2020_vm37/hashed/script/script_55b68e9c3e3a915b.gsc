#using scripts\core_common\lui_shared;

#namespace sr_perk_machine_choice;

// Namespace sr_perk_machine_choice
// Method(s) 5 Total 12
class class_a19c3039 : cluielem {

    // Namespace namespace_a19c3039/sr_perk_machine_choice
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7bc5c3b9, Offset: 0x1c8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_a19c3039/sr_perk_machine_choice
    // Params 1, eflags: 0x1 linked
    // Checksum 0x493789eb, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_a19c3039/sr_perk_machine_choice
    // Params 0, eflags: 0x1 linked
    // Checksum 0xedf25a4e, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_perk_machine_choice");
    }

}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 0, eflags: 0x1 linked
// Checksum 0x3312f25f, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new class_a19c3039();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 2, eflags: 0x1 linked
// Checksum 0xab93d0f6, Offset: 0xf0
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 1, eflags: 0x1 linked
// Checksum 0x2f3c9e91, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_perk_machine_choice/sr_perk_machine_choice
// Params 1, eflags: 0x1 linked
// Checksum 0x54a16eec, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

