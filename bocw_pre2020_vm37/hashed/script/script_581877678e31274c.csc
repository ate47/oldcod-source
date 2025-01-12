#using scripts\abilities\gadgets\gadget_jammer_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_68a80213;

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x6
// Checksum 0x19982416, Offset: 0xd8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_512409f8a5de10e4", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x4
// Checksum 0xacb7a83f, Offset: 0x130
// Size: 0x5c
function private function_70a657d8() {
    clientfield::register("actor", "" + #"hash_c5d06ae18fde4c0", 1, 1, "int", &function_870656e3, 0, 0);
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function private postinit() {
    
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 7, eflags: 0x0
// Checksum 0x8ec0b9a1, Offset: 0x1a8
// Size: 0xf6
function function_870656e3(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump) {
        self.death_fx = function_239993de(fieldname, "zm_ai/fx9_hound_hell_dth_aoe", self, "j_spine4");
        self playsound(fieldname, #"hash_6a76932cce379c66");
        return;
    }
    if (isdefined(self.death_fx)) {
        stopfx(fieldname, self.death_fx);
        self.death_fx = undefined;
    }
}

