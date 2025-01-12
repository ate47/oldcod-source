#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_items;

// Namespace zm_items/zm_items
// Params 0, eflags: 0x2
// Checksum 0x78f5928, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_items", &__init__, undefined, undefined);
}

// Namespace zm_items/zm_items
// Params 0, eflags: 0x0
// Checksum 0xb9fb415b, Offset: 0x108
// Size: 0x4c
function __init__() {
    clientfield::register("item", "highlight_item", 1, 2, "int", &function_8d6434da, 0, 0);
}

// Namespace zm_items/zm_items
// Params 7, eflags: 0x0
// Checksum 0xb18092fe, Offset: 0x160
// Size: 0x84
function function_8d6434da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrenderoverridebundle("rob_sonar_set_friendly");
        return;
    }
    self stoprenderoverridebundle("rob_sonar_set_friendly");
}

