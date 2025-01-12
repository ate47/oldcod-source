#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace field_upgrades;

// Namespace field_upgrades/field_upgrades
// Params 0, eflags: 0x6
// Checksum 0x34f58df7, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"field_upgrades", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace field_upgrades/field_upgrades
// Params 0, eflags: 0x5 linked
// Checksum 0xf0d7ffac, Offset: 0x110
// Size: 0xbc
function private function_70a657d8() {
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.fieldUpgrade", #"hash_6f4b11a0bee9b73d", [#"hash_2f126bd99a74de8b", #"fieldupgrade"], 1, 5, "float", undefined, 0, 0);
    clientfield::register("missile", "fieldUpgradeActive", 1, 1, "int", &function_5fbd38e2, 0, 0);
}

// Namespace field_upgrades/field_upgrades
// Params 7, eflags: 0x5 linked
// Checksum 0x16bec3ac, Offset: 0x1d8
// Size: 0x64
function private function_5fbd38e2(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self function_1f0c7136(1);
    }
}

