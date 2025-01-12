#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_takeo;

// Namespace character_unlock_takeo/character_unlock_takeo
// Params 0, eflags: 0x2
// Checksum 0x2d2d5610, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_takeo", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_takeo/character_unlock_takeo
// Params 0, eflags: 0x0
// Checksum 0x24f3c763, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"takeo_unlock", #"hash_36157750ed7c6584", #"hash_1648796d14ec438b", undefined, #"hash_56b5eb94fb75cbed");
}

