#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_inventory;

#namespace zm_ui_inventory;

// Namespace zm_ui_inventory/zm_ui_inventory
// Params 0, eflags: 0x2
// Checksum 0x75373a43, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ui_inventory", &__init__, undefined, undefined);
}

// Namespace zm_ui_inventory/zm_ui_inventory
// Params 0, eflags: 0x4
// Checksum 0x92459ae5, Offset: 0x120
// Size: 0x150
function private __init__() {
    clientfield::register_bgcache("clientuimodel", "string", "hudItems.zmFeatureDescription", 1, undefined, 0, 0);
    zm_inventory::function_8e8bbf18();
    registeredfields = [];
    foreach (mapping in level.var_c67b847b) {
        if (!isdefined(registeredfields[mapping.var_b98f9b55])) {
            registeredfields[mapping.var_b98f9b55] = 1;
            var_5ab0bfe2 = "worlduimodel";
            if (isdefined(mapping.ispersonal)) {
                var_5ab0bfe2 = "clientuimodel";
            }
            clientfield::register(var_5ab0bfe2, mapping.var_b98f9b55, 1, mapping.numbits, "int", undefined, 0, 0);
        }
    }
}

