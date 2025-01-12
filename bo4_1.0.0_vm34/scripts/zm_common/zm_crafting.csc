#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_progress;
#using scripts\zm_common\zm_utility;

#namespace zm_crafting;

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x2
// Checksum 0xf42acc96, Offset: 0xd0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_crafting", &__init__, &__main__, undefined);
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0xfd583653, Offset: 0x120
// Size: 0x1e
function __init__() {
    level.var_f25c1c2a = [];
    level.crafting_components = [];
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0xabe45ccd, Offset: 0x148
// Size: 0x14
function __main__() {
    function_b028db56();
}

// Namespace zm_crafting/zm_crafting
// Params 0, eflags: 0x0
// Checksum 0x83466b4b, Offset: 0x168
// Size: 0x98
function function_b028db56() {
    foundries = getscriptbundles("craftfoundry");
    foreach (foundry in foundries) {
        setup_craftfoundry(foundry);
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0xa4f260b5, Offset: 0x208
// Size: 0x262
function setup_craftfoundry(craftfoundry) {
    if (isdefined(craftfoundry)) {
        if (!(isdefined(craftfoundry.loaded) && craftfoundry.loaded)) {
            craftfoundry.loaded = 1;
            craftfoundry.blueprints = [];
            switch (craftfoundry.var_689a6873) {
            case 8:
                craftfoundry.blueprints[7] = function_ad17f25(craftfoundry.blueprint08);
            case 7:
                craftfoundry.blueprints[6] = function_ad17f25(craftfoundry.blueprint07);
            case 6:
                craftfoundry.blueprints[5] = function_ad17f25(craftfoundry.blueprint06);
            case 5:
                craftfoundry.blueprints[4] = function_ad17f25(craftfoundry.blueprint05);
            case 4:
                craftfoundry.blueprints[3] = function_ad17f25(craftfoundry.blueprint04);
            case 3:
                craftfoundry.blueprints[2] = function_ad17f25(craftfoundry.blueprint03);
            case 2:
                craftfoundry.blueprints[1] = function_ad17f25(craftfoundry.blueprint02);
            case 1:
                craftfoundry.blueprints[0] = function_ad17f25(craftfoundry.blueprint01);
                break;
            }
        }
    }
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x5d732a1d, Offset: 0x478
// Size: 0x328
function function_ad17f25(name) {
    blueprint = getscriptbundle(name);
    if (isdefined(blueprint)) {
        if (!(isdefined(blueprint.loaded) && blueprint.loaded)) {
            blueprint.loaded = 1;
            blueprint.name = name;
            blueprint.components = [];
            switch (blueprint.componentcount) {
            case 8:
                blueprint.components[7] = get_component(blueprint.var_361b57c6);
            case 7:
                blueprint.components[6] = get_component(blueprint.var_a822c701);
            case 6:
                blueprint.components[5] = get_component(blueprint.var_82204c98);
            case 5:
                blueprint.components[4] = get_component(blueprint.var_f427bbd3);
            case 4:
                blueprint.components[3] = get_component(blueprint.var_ce25416a);
            case 3:
                blueprint.components[2] = get_component(blueprint.var_402cb0a5);
            case 2:
                blueprint.components[1] = get_component(blueprint.var_1a2a363c);
            case 1:
                blueprint.components[0] = get_component(blueprint.var_8c31a577);
                break;
            }
            blueprint.var_29ca87bc = get_component(blueprint.result);
            level.var_f25c1c2a[name] = blueprint;
            if (!isdefined(blueprint.var_a05722e9)) {
                blueprint.var_a05722e9 = "ERROR: Missing Prompt String";
            }
        }
    } else {
        assertmsg("<dev string:x30>" + name);
    }
    return blueprint;
}

// Namespace zm_crafting/zm_crafting
// Params 1, eflags: 0x0
// Checksum 0x50b3445f, Offset: 0x7a8
// Size: 0x5c
function get_component(component) {
    if (!isdefined(level.crafting_components[component.name])) {
        level.crafting_components[component.name] = component;
    }
    return level.crafting_components[component.name];
}

