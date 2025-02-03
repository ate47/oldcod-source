#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace status_effect_dot;

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x6
// Checksum 0xd6c0dd43, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_dot", &preinit, undefined, undefined, undefined);
}

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x4
// Checksum 0xef595c1e, Offset: 0xf8
// Size: 0x94
function private preinit() {
    clientfield::register("toplayer", "dot_splatter", 1, 1, "counter", &on_dot_splatter, 0, 0);
    clientfield::register("toplayer", "dot_no_splatter", 1, 1, "counter", &on_dot_no_splatter, 0, 0);
}

// Namespace status_effect_dot/status_effect_dot
// Params 7, eflags: 0x0
// Checksum 0x8f8d37dd, Offset: 0x198
// Size: 0x4a
function on_dot_splatter(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.dot_damaged = 1;
}

// Namespace status_effect_dot/status_effect_dot
// Params 7, eflags: 0x0
// Checksum 0x60a7c363, Offset: 0x1f0
// Size: 0x4a
function on_dot_no_splatter(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.dot_no_splatter = 1;
}

