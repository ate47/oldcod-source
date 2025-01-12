#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_inventory;

#namespace zm_ui_inventory;

// Namespace zm_ui_inventory/zm_ui_inventory
// Params 0, eflags: 0x6
// Checksum 0xdb1a3c63, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_ui_inventory", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_ui_inventory/zm_ui_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0x885abc93, Offset: 0x108
// Size: 0x198
function private function_70a657d8() {
    clientfield::function_91cd7763("string", "hudItems.zmFeatureDescription", #"hash_6f4b11a0bee9b73d", #"zmfeaturedescription", 1, undefined, 0, 0);
    zm_inventory::function_c7c05a13();
    registeredfields = [];
    foreach (mapping in level.var_a16c38d9) {
        if (!isdefined(registeredfields[mapping.var_cd35dfb2])) {
            registeredfields[mapping.var_cd35dfb2] = 1;
            if (isdefined(mapping.var_7f12f171)) {
                clientfield::register_clientuimodel(mapping.var_cd35dfb2, mapping.var_a88efd0b, mapping.var_2972a1c0, 1, mapping.numbits, "int", undefined, 0, 0);
                continue;
            }
            clientfield::function_5b7d846d(mapping.var_cd35dfb2, mapping.var_a88efd0b, mapping.var_2972a1c0, 1, mapping.numbits, "int", undefined, 0, 0);
        }
    }
}

