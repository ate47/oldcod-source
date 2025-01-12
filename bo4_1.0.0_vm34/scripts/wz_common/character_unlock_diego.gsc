#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_diego;

// Namespace character_unlock_diego/character_unlock_diego
// Params 0, eflags: 0x2
// Checksum 0x68daa388, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_diego", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_diego/character_unlock_diego
// Params 0, eflags: 0x0
// Checksum 0x360f65fb, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"diego_unlock", #"hash_7fc15da2c5864d3c", #"hash_785c14ec8112efe2", undefined, #"hash_7d0b41a17f2e9a9");
}

