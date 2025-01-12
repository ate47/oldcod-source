#using scripts\core_common\activecamo_shared;
#using scripts\core_common\delete;
#using scripts\core_common\dev_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace load;

// Namespace load/load_shared
// Params 0, eflags: 0x6
// Checksum 0x9ef561ba, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"load", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace load/load_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x98c86ba5, Offset: 0xf8
// Size: 0x34
function main() {
    assert(isdefined(level.var_f18a6bd6));
    [[ level.var_f18a6bd6 ]]();
}

// Namespace load/load_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x9614d9d1, Offset: 0x138
// Size: 0x8c
function private function_70a657d8() {
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
    // Checksum 0xada2f803, Offset: 0x1d0
    // Size: 0x2a
    function first_frame() {
        level.first_frame = 1;
        waitframe(1);
        level.first_frame = undefined;
    }

#/

// Namespace load/load_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2e966d81, Offset: 0x208
// Size: 0xb8
function apply_mature_filter() {
    if (!util::is_mature()) {
        a_mature_models = findstaticmodelindexarray("mature_content");
        foreach (model in a_mature_models) {
            hidestaticmodel(model);
        }
    }
}

// Namespace load/load_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x5b9f3af5, Offset: 0x2c8
// Size: 0x3c
function art_review() {
    if (getdvarint(#"art_review", 0)) {
        level waittill(#"forever");
    }
}

