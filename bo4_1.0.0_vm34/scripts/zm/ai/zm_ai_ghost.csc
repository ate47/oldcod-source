#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;

#namespace zm_ai_ghost;

// Namespace zm_ai_ghost/zm_ai_ghost
// Params 0, eflags: 0x2
// Checksum 0x3880f58d, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_ghost", &__init__, undefined, undefined);
}

// Namespace zm_ai_ghost/zm_ai_ghost
// Params 0, eflags: 0x0
// Checksum 0xc17529c8, Offset: 0xd0
// Size: 0x2c
function __init__() {
    ai::add_archetype_spawn_function("ghost", &function_fc907a66);
}

// Namespace zm_ai_ghost/zm_ai_ghost
// Params 1, eflags: 0x4
// Checksum 0x5a68e3f7, Offset: 0x108
// Size: 0x24
function private function_fc907a66(localclientnum) {
    self thread function_94ef1252(localclientnum);
}

// Namespace zm_ai_ghost/zm_ai_ghost
// Params 1, eflags: 0x4
// Checksum 0xa2765851, Offset: 0x138
// Size: 0xfe
function private function_94ef1252(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"set_invisible", #"set_visible", #"hash_6ab654a4c018818c");
        switch (waitresult._notify) {
        case #"set_invisible":
            self fxclientutils::function_18fc3ca3(localclientnum, self, self.fxdef);
            break;
        case #"set_visible":
        case #"hash_6ab654a4c018818c":
            self fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
            break;
        }
    }
}

