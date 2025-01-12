#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\wz_firing_range;

#namespace character_unlock_seraph;

// Namespace character_unlock_seraph/character_unlock_seraph
// Params 0, eflags: 0x2
// Checksum 0xa539a617, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"character_unlock_seraph", &__init__, undefined, undefined);
}

// Namespace character_unlock_seraph/character_unlock_seraph
// Params 0, eflags: 0x0
// Checksum 0xb639acc3, Offset: 0xc8
// Size: 0x24
function __init__() {
    callback::on_finalize_initialization(&on_finalize_initialization);
}

// Namespace character_unlock_seraph/character_unlock_seraph
// Params 1, eflags: 0x0
// Checksum 0x532ffd55, Offset: 0xf8
// Size: 0x2c
function on_finalize_initialization(localclientnum) {
    wz_firing_range::init_targets(#"hash_3af83a27a707345a");
}

