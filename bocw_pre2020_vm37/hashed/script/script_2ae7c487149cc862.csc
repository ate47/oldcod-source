#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace namespace_4db53432;

// Namespace namespace_4db53432/level_init
// Params 1, eflags: 0x40
// Checksum 0xe79abeef, Offset: 0xe0
// Size: 0xd4
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("toplayer", "" + #"hash_69409daf95eb8ffe", 1, 1, "int", &function_bd4ba224, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7a1ca107322a0dbc", 1, 1, "counter", &function_3b1a36d9, 0, 0);
    util::waitforclient(0);
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 7, eflags: 0x0
// Checksum 0x27ac0c13, Offset: 0x1c0
// Size: 0x9c
function function_3b1a36d9(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playfx(bwastimejump, "maps/zm_escape/fx8_brutus_transformation_shockwave", self.origin + (0, 0, 32), anglestoforward(self.angles), anglestoup(self.angles));
}

// Namespace namespace_4db53432/namespace_4db53432
// Params 7, eflags: 0x0
// Checksum 0xb5b7fc35, Offset: 0x268
// Size: 0xa4
function function_bd4ba224(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (bwastimejump == 1) {
        self postfx::playpostfxbundle(#"hash_4a8a66363bf60fc1");
        return;
    }
    self postfx::exitpostfxbundle(#"hash_4a8a66363bf60fc1");
}

