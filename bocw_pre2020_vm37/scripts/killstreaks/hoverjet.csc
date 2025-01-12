#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace hoverjet;

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x6
// Checksum 0x3858c497, Offset: 0xb8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hoverjet", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace hoverjet/hoverjet
// Params 0, eflags: 0x5 linked
// Checksum 0xf763ba61, Offset: 0x108
// Size: 0x4c
function private function_70a657d8() {
    clientfield::register("toplayer", "sndCockpitRoom", 1, 1, "int", &sndCockpitRoom, 0, 1);
}

// Namespace hoverjet/hoverjet
// Params 7, eflags: 0x1 linked
// Checksum 0xd2e47374, Offset: 0x160
// Size: 0x7c
function sndCockpitRoom(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        forceambientroom("killstreak_hoverjet");
        return;
    }
    forceambientroom("");
}

