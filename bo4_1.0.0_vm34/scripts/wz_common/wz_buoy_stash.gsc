#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\mp_common\item_world;

#namespace wz_buoy_stash;

// Namespace wz_buoy_stash/wz_buoy_stash
// Params 0, eflags: 0x2
// Checksum 0xc78f09b0, Offset: 0xe8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"wz_buoy_stash", &__init__, &__main__, undefined);
}

// Namespace wz_buoy_stash/wz_buoy_stash
// Params 0, eflags: 0x0
// Checksum 0x1ce8141e, Offset: 0x138
// Size: 0x34
function __init__() {
    clientfield::register("scriptmover", "buoy_light_fx_changed", 1, 2, "int");
}

// Namespace wz_buoy_stash/wz_buoy_stash
// Params 0, eflags: 0x0
// Checksum 0xd6bdb25, Offset: 0x178
// Size: 0x1c
function __main__() {
    level thread function_f34dce2f();
}

// Namespace wz_buoy_stash/wz_buoy_stash
// Params 0, eflags: 0x0
// Checksum 0x5175fcf6, Offset: 0x1a0
// Size: 0x238
function function_f34dce2f() {
    var_88edd90a = struct::get_array("buoy_stash", "targetname");
    foreach (scene in var_88edd90a) {
        wait randomint(4);
        scene thread scene::play(#"p8_fxanim_wz_floating_buoy_bundle");
    }
    item_world::function_6df9665a();
    foreach (scene in var_88edd90a) {
        var_ae51f12b = getdynent("dock_yard_stash_2");
        if (isdefined(var_ae51f12b)) {
            var_d624b478 = distance2d(var_ae51f12b.origin, scene.origin);
            if (var_d624b478 < 200) {
                scene.scene_ents[#"prop 1"] clientfield::set("buoy_light_fx_changed", 2);
                scene.scene_ents[#"prop 1"] function_f24a9a4a();
                continue;
            }
            scene.scene_ents[#"prop 1"] clientfield::set("buoy_light_fx_changed", 1);
        }
    }
}

// Namespace wz_buoy_stash/wz_buoy_stash
// Params 0, eflags: 0x0
// Checksum 0xe466a118, Offset: 0x3e0
// Size: 0xa4
function function_f24a9a4a() {
    buoy_stash = getdynent("dock_yard_stash_2");
    var_c778c33 = 0;
    if (isdefined(buoy_stash)) {
        while (!var_c778c33 && isdefined(self)) {
            if (function_7f51b166(buoy_stash) == 2) {
                var_c778c33 = 1;
                self clientfield::set("buoy_light_fx_changed", 1);
                break;
            }
            wait 1;
        }
    }
}

