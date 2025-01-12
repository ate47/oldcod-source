#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_nikolai;

// Namespace character_unlock_nikolai/character_unlock_nikolai
// Params 0, eflags: 0x2
// Checksum 0xea4957cd, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_nikolai", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_nikolai/character_unlock_nikolai
// Params 0, eflags: 0x0
// Checksum 0x86481acb, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"nikolai_unlock", #"hash_1d718be46a94371f", #"hash_37c250994d0a88c3", undefined, #"hash_6a5c9e02cc60e87e");
}

