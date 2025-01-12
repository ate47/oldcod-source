#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_items;

// Namespace zm_items/zm_items
// Params 0, eflags: 0x6
// Checksum 0x4ebe50d1, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_items", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_items/zm_items
// Params 0, eflags: 0x5 linked
// Checksum 0x507e6dc3, Offset: 0x110
// Size: 0x4c
function private function_70a657d8() {
    clientfield::register("item", "highlight_item", 1, 2, "int", &function_39e7c9dd, 0, 0);
}

// Namespace zm_items/zm_items
// Params 7, eflags: 0x1 linked
// Checksum 0x450580db, Offset: 0x168
// Size: 0x84
function function_39e7c9dd(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self playrenderoverridebundle("rob_sonar_set_friendly");
        return;
    }
    self stoprenderoverridebundle("rob_sonar_set_friendly");
}

