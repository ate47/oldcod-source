#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace status_effect_dot;

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x2
// Checksum 0xfae7d404, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_dot", &__init__, undefined, undefined);
}

// Namespace status_effect_dot/status_effect_dot
// Params 0, eflags: 0x0
// Checksum 0x736bdb33, Offset: 0xf0
// Size: 0x94
function __init__() {
    clientfield::register("toplayer", "dot_splatter", 1, 1, "counter", &on_dot_splatter, 0, 0);
    clientfield::register("toplayer", "dot_no_splatter", 1, 1, "counter", &on_dot_no_splatter, 0, 0);
}

// Namespace status_effect_dot/status_effect_dot
// Params 7, eflags: 0x0
// Checksum 0x8fa41bab, Offset: 0x190
// Size: 0x4a
function on_dot_splatter(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.dot_damaged = 1;
}

// Namespace status_effect_dot/status_effect_dot
// Params 7, eflags: 0x0
// Checksum 0x84d67990, Offset: 0x1e8
// Size: 0x4a
function on_dot_no_splatter(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.dot_no_splatter = 1;
}

