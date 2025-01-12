#using scripts/core_common/blood;
#using scripts/core_common/drown;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/explode;
#using scripts/core_common/fx_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/water_surface;
#using scripts/core_common/weapons/empgrenade;
#using scripts/core_common/weapons_shared;

#namespace load;

// Namespace load/load_shared
// Params 0, eflags: 0x2
// Checksum 0x780bf96a, Offset: 0x290
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("load", &__init__, undefined, undefined);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x1941e508, Offset: 0x2d0
// Size: 0x2c
function __init__() {
    /#
        level thread first_frame();
    #/
    apply_mature_filter();
}

/#

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4388335d, Offset: 0x308
    // Size: 0x2a
    function first_frame() {
        level.first_frame = 1;
        waitframe(1);
        level.first_frame = undefined;
    }

#/

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x834d0d6, Offset: 0x340
// Size: 0xba
function apply_mature_filter() {
    if (!util::is_mature()) {
        a_mature_models = findstaticmodelindexarray("mature_content");
        foreach (model in a_mature_models) {
            hidestaticmodel(model);
        }
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x6484f26, Offset: 0x408
// Size: 0x80
function art_review() {
    if (getdvarstring("art_review") == "") {
        setdvar("art_review", "0");
    }
    if (getdvarstring("art_review") == "1") {
        level waittill("forever");
    }
}

