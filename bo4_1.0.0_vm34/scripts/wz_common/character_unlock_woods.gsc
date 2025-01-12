#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_woods;

// Namespace character_unlock_woods/character_unlock_woods
// Params 0, eflags: 0x2
// Checksum 0x53ad7894, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_woods", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_woods/character_unlock_woods
// Params 0, eflags: 0x0
// Checksum 0x6b432670, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"woods_unlock", #"hash_3f01badbd66b2962", #"hash_1cfbe6a4d8abea22", undefined, #"hash_17a4baf5ec553be7");
}

