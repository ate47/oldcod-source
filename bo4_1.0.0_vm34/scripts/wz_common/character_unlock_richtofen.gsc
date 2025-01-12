#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\wz_common\character_unlock;

#namespace character_unlock_richtofen;

// Namespace character_unlock_richtofen/character_unlock_richtofen
// Params 0, eflags: 0x2
// Checksum 0xfef25f46, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"character_unlock_richtofen", &__init__, undefined, #"character_unlock");
}

// Namespace character_unlock_richtofen/character_unlock_richtofen
// Params 0, eflags: 0x0
// Checksum 0x26ea6c14, Offset: 0xd0
// Size: 0x54
function __init__() {
    character_unlock::register_character_unlock(#"richtofen_unlock", #"hash_66b69b90a30bcc88", #"hash_12e5bf5389d7c8b7", undefined, #"hash_418312990213bc41");
}

