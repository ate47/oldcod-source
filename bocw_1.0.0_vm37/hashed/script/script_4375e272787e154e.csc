#using script_84f5590d2ac48f8;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\map;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;

#namespace namespace_66d6aa44;

// Namespace namespace_66d6aa44/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x97370c97, Offset: 0x128
// Size: 0xe0
function event_handler[level_preinit] codecallback_preinitialization(*eventstruct) {
    clientfield::register("world", "hide_intro_models", 1, 1, "int", &hide_intro_models, 1, 0);
    clientfield::register_clientuimodel("closeLoadingMovie", #"hash_414f1dabe0f0c1a5", #"closeloadingmovie", 1, 1, "int", undefined, 0, 0);
    var_43a36c6f = function_6681bbf6();
    function_e526b83(var_43a36c6f);
    level.var_5337a48a = [];
}

// Namespace namespace_66d6aa44/level_init
// Params 1, eflags: 0x40
// Checksum 0x46796a82, Offset: 0x210
// Size: 0x24
function event_handler[level_init] function_9347830c(*eventstruct) {
    full_screen_movie::register("full_screen_movie");
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 0, eflags: 0x0
// Checksum 0x42c048ec, Offset: 0x240
// Size: 0x5a
function function_6681bbf6() {
    mapbundle = map::get_script_bundle();
    if (!isdefined(mapbundle) || !isdefined(mapbundle.var_f9631c9d)) {
        return undefined;
    }
    return getscriptbundle(mapbundle.var_f9631c9d);
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0x97344ad8, Offset: 0x2a8
// Size: 0x68
function function_b69a4f47(var_2f252ea4) {
    clientfield::register("toplayer", var_2f252ea4.uniqueid, 1, 1, "int", &function_e7722af4, 1, 0);
    level.var_5337a48a[var_2f252ea4.uniqueid] = var_2f252ea4;
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 7, eflags: 0x0
// Checksum 0x5aeea74c, Offset: 0x318
// Size: 0x17c
function function_e7722af4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    println("<dev string:x38>" + bwastimejump);
    postfxbundle = getscriptbundle(bwastimejump);
    if (!isdefined(postfxbundle)) {
        return;
    }
    if (!isdefined(postfxbundle.var_aaf5aae7)) {
        return;
    }
    if (fieldname > 0) {
        if (!function_148ccc79(binitialsnap, postfxbundle.var_aaf5aae7)) {
            println("<dev string:x53>" + postfxbundle.var_aaf5aae7);
            function_a837926b(binitialsnap, postfxbundle.var_aaf5aae7);
        }
        return;
    }
    if (function_148ccc79(binitialsnap, postfxbundle.var_aaf5aae7)) {
        println("<dev string:x6f>" + postfxbundle.var_aaf5aae7);
        codestoppostfxbundlelocal(binitialsnap, postfxbundle.var_aaf5aae7);
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 1, eflags: 0x0
// Checksum 0xb3920eef, Offset: 0x4a0
// Size: 0xf0
function function_e526b83(var_43a36c6f) {
    if (!isdefined(var_43a36c6f.var_96c3f045)) {
        return;
    }
    var_20314119 = getscriptbundlelist(var_43a36c6f.var_96c3f045);
    if (!isdefined(var_20314119)) {
        return;
    }
    foreach (var_39796f0f in var_20314119) {
        var_c5470032 = getscriptbundle(var_39796f0f);
        function_b69a4f47(var_c5470032);
    }
}

// Namespace namespace_66d6aa44/namespace_66d6aa44
// Params 7, eflags: 0x0
// Checksum 0xb4215db, Offset: 0x598
// Size: 0x188
function hide_intro_models(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_6d963dbf = findstaticmodelindexarray("intro_scene_models");
    if (is_true(bwastimejump)) {
        audio::snd_set_snapshot("mpl_intro_igc");
        foreach (n_index in var_6d963dbf) {
            hidestaticmodel(n_index);
        }
        return;
    }
    foreach (n_index in var_6d963dbf) {
        unhidestaticmodel(n_index);
    }
}

