#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace status_effect_dot;

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x6
// Checksum 0x1ff8378d, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_dot", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x5 linked
// Checksum 0x7b6e09c4, Offset: 0xf8
// Size: 0x94
function private function_70a657d8() {
    clientfield::register("toplayer", "dot_splatter", 1, 1, "counter", &on_dot_splatter, 0, 0);
    clientfield::register("toplayer", "dot_no_splatter", 1, 1, "counter", &on_dot_no_splatter, 0, 0);
}

// Namespace status_effect_dot/status_effect_dot
// Params 7, eflags: 0x1 linked
// Checksum 0x3d03cfaf, Offset: 0x198
// Size: 0x4a
function on_dot_splatter(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.dot_damaged = 1;
}

// Namespace status_effect_dot/status_effect_dot
// Params 7, eflags: 0x1 linked
// Checksum 0x1a05ec61, Offset: 0x1f0
// Size: 0x4a
function on_dot_no_splatter(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.dot_no_splatter = 1;
}

