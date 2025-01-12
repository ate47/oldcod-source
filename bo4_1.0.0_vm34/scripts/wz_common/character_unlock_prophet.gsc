#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_prophet;

// Namespace character_unlock_prophet/character_unlock_prophet
// Params 0, eflags: 0x2
// Checksum 0x50f8b8af, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_prophet", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_prophet/character_unlock_prophet
// Params 0, eflags: 0x0
// Checksum 0x3da3cc9b, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"prophet_unlock", #"hash_62361c68e083d401", #"hash_23906e94e27842d8", undefined, #"hash_63b7bd67a959fc47");
}

