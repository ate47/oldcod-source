#using script_18b9d0e77614c97;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\delete;
#using scripts\core_common\dev_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace load;

// Namespace load/load_shared
// Params 0, eflags: 0x6
// Checksum 0x57cd8b74, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"load", &preinit, undefined, undefined, undefined);
}

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x3f082b55, Offset: 0x100
// Size: 0x34
function main() {
    assert(isdefined(level.var_f18a6bd6));
    [[ level.var_f18a6bd6 ]]();
}

// Namespace load/load_shared
// Params 0, eflags: 0x4
// Checksum 0xa0e68def, Offset: 0x140
// Size: 0x8c
function private preinit() {
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
    // Checksum 0x3809bc6b, Offset: 0x1d8
    // Size: 0x38
    function first_frame() {
        level.first_frame = 1;
        waitframe(1);
        level.first_frame = undefined;
        level.var_22944a63 = 1;
    }

#/

// Namespace load/load_shared
// Params 0, eflags: 0x0
// Checksum 0x621e5c95, Offset: 0x218
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
// Params 0, eflags: 0x0
// Checksum 0xc4a1394e, Offset: 0x2d8
// Size: 0x3c
function art_review() {
    if (getdvarint(#"art_review", 0)) {
        level waittill(#"forever");
    }
}

