#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_cd6bd9f;

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 0, eflags: 0x6
// Checksum 0xfa9025c3, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_54149d856843e31a", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 0, eflags: 0x0
// Checksum 0x12acc2de, Offset: 0x100
// Size: 0x34
function function_70a657d8() {
    ai::add_archetype_spawn_function(#"hash_7c0d83ac1e845ac2", &function_7ec99c76);
}

// Namespace namespace_cd6bd9f/namespace_cd6bd9f
// Params 1, eflags: 0x4
// Checksum 0x297ae214, Offset: 0x140
// Size: 0x74
function private function_7ec99c76(localclientnum) {
    self enableonradar();
    playfx(localclientnum, "zombie/fx_portal_keeper_spawn_burst_zod_zmb", self.origin, anglestoforward((0, 0, 0)), anglestoup((0, 0, 0)));
}

