#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_mason;

// Namespace character_unlock_mason/character_unlock_mason
// Params 0, eflags: 0x2
// Checksum 0x85b65597, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_mason", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_mason/character_unlock_mason
// Params 0, eflags: 0x0
// Checksum 0x84b33c13, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"mason_unlock", #"hash_72350169be9133ae", #"hash_7388dde2bae9bb8e", undefined, #"hash_7334970069e5e147");
}

