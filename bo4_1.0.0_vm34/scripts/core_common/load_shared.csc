#using scripts\core_common\delete;
#using scripts\core_common\dev_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace load;

// Namespace load/load_shared
// Params 0, eflags: 0x2
// Checksum 0xeb395913, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"load", &__init__, undefined, undefined);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x40c19a71, Offset: 0xf0
// Size: 0x9c
function __init__() {
    if (sessionmodeiscampaigngame()) {
        level.game_mode_suffix = "_cp";
    } else if (sessionmodeiszombiesgame()) {
        level.game_mode_suffix = "_zm";
    } else {
        level.game_mode_suffix = "_mp";
    }
    /#
        level thread first_frame();
    #/
    apply_mature_filter();
}

/#

    // Namespace load/load_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3a2a922f, Offset: 0x198
    // Size: 0x26
    function first_frame() {
        level.first_frame = 1;
        waitframe(1);
        level.first_frame = undefined;
    }

#/

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x6ad24bda, Offset: 0x1c8
// Size: 0xa8
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
// Checksum 0x9056961b, Offset: 0x278
// Size: 0x3c
function art_review() {
    if (getdvarint(#"art_review", 0)) {
        level waittill(#"forever");
    }
}

