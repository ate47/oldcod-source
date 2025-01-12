#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_inventory;

#namespace zm_ui_inventory;

// Namespace zm_ui_inventory/zm_ui_inventory
// Params 0, eflags: 0x2
// Checksum 0xd1c277f9, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ui_inventory", &__init__, undefined, undefined);
}

// Namespace zm_ui_inventory/zm_ui_inventory
// Params 0, eflags: 0x0
// Checksum 0x8ac98010, Offset: 0x110
// Size: 0x148
function __init__() {
    clientfield::register_bgcache("clientuimodel", "string", "hudItems.zmFeatureDescription", 1);
    zm_inventory::function_8e8bbf18();
    registeredfields = [];
    foreach (mapping in level.var_c67b847b) {
        if (!isdefined(registeredfields[mapping.var_b98f9b55])) {
            registeredfields[mapping.var_b98f9b55] = 1;
            var_5ab0bfe2 = "worlduimodel";
            if (isdefined(mapping.ispersonal)) {
                var_5ab0bfe2 = "clientuimodel";
            }
            clientfield::register(var_5ab0bfe2, mapping.var_b98f9b55, 1, mapping.numbits, "int");
        }
    }
}

// Namespace zm_ui_inventory/zm_ui_inventory
// Params 3, eflags: 0x0
// Checksum 0x5e738a12, Offset: 0x260
// Size: 0xbc
function function_31a39683(fieldname, value, player) {
    var_453f2f48 = level.var_c67b847b[fieldname];
    if (!isdefined(var_453f2f48.ispersonal)) {
        self clientfield::set_world_uimodel(var_453f2f48.var_b98f9b55, value);
        return;
    }
    assert(isplayer(player));
    player clientfield::set_player_uimodel(var_453f2f48.var_b98f9b55, value);
}

// Namespace zm_ui_inventory/zm_ui_inventory
// Params 1, eflags: 0x0
// Checksum 0x9612b9ba, Offset: 0x328
// Size: 0x2c
function function_794e8679(var_34c42ef6) {
    self clientfield::set_player_uimodel("hudItems.zmFeatureDescription", var_34c42ef6);
}

