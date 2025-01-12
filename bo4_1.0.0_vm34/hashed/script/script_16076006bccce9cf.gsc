#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace namespace_c30ca5c1;

// Namespace namespace_c30ca5c1/namespace_c30ca5c1
// Params 0, eflags: 0x2
// Checksum 0x9532f7a3, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"hash_5e3c6106d1627261", &__init__, undefined, #"character_unlock");
}

// Namespace namespace_c30ca5c1/namespace_c30ca5c1
// Params 0, eflags: 0x0
// Checksum 0xad6a8e79, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"hash_aac0796b2253387", #"hash_3b21afad4de26df7", #"warmachine_wz_item", undefined, #"hash_6d676c33e9df57d4");
}

