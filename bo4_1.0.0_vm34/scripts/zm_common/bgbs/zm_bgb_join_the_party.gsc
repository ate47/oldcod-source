#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_player;

#namespace zm_bgb_join_the_party;

// Namespace zm_bgb_join_the_party/zm_bgb_join_the_party
// Params 0, eflags: 0x2
// Checksum 0x9e5f72ee, Offset: 0x98
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_join_the_party", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_join_the_party/zm_bgb_join_the_party
// Params 0, eflags: 0x0
// Checksum 0x48ff62a2, Offset: 0xe8
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_join_the_party", "activated", 1, undefined, undefined, &validation, &activation);
}

// Namespace zm_bgb_join_the_party/zm_bgb_join_the_party
// Params 0, eflags: 0x0
// Checksum 0x9fbdf88a, Offset: 0x168
// Size: 0x98
function activation() {
    foreach (player in level.players) {
        if (player util::is_spectating()) {
            player thread zm_player::spectator_respawn_player();
        }
    }
}

// Namespace zm_bgb_join_the_party/zm_bgb_join_the_party
// Params 0, eflags: 0x0
// Checksum 0x96793a49, Offset: 0x208
// Size: 0x8a
function validation() {
    foreach (player in level.players) {
        if (player util::is_spectating()) {
            return true;
        }
    }
    return false;
}

