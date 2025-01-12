#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace mini_turret;

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x6
// Checksum 0x1341be0b, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"mini_turret", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x5 linked
// Checksum 0x292e51b8, Offset: 0x108
// Size: 0x4c
function private function_70a657d8() {
    clientfield::register("vehicle", "mini_turret_open", 1, 1, "int", &turret_open, 0, 0);
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 7, eflags: 0x1 linked
// Checksum 0xf17ba2b9, Offset: 0x160
// Size: 0xbc
function turret_open(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        return;
    }
    self util::waittill_dobj(fieldname);
    if (isdefined(self)) {
        self useanimtree("generic");
        self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
    }
}

