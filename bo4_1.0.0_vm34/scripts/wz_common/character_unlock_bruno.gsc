#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_bruno;

// Namespace character_unlock_bruno/character_unlock_bruno
// Params 0, eflags: 0x2
// Checksum 0x9979da51, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_bruno", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_bruno/character_unlock_bruno
// Params 0, eflags: 0x0
// Checksum 0xfbc73fe2, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"bruno_unlock", #"hash_4815f130a1c1d840", #"hash_1ae4a778cda71730", undefined, #"hash_21c5510d64c20b71");
}

