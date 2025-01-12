#using scripts/core_common/audio_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/flashgrenades;

#namespace empgrenade;

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x2
// Checksum 0x812163f3, Offset: 0x330
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("empgrenade", &__init__, undefined, undefined);
}

// Namespace empgrenade/empgrenade
// Params 0, eflags: 0x0
// Checksum 0x5ca7d27, Offset: 0x370
// Size: 0xb4
function __init__() {
    clientfield::register("toplayer", "empd", 1, 1, "int", &onempchanged, 0, 1);
    clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int", &onempmonitordistancechanged, 0, 0);
    callback::on_spawned(&on_player_spawned);
}

// Namespace empgrenade/empgrenade
// Params 7, eflags: 0x0
// Checksum 0xe26a94f4, Offset: 0x430
// Size: 0xdc
function onempchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    if (newval == 1) {
        self startempeffects(localplayer);
        return;
    }
    already_distance_monitored = localplayer clientfield::get_to_player("empd_monitor_distance") == 1;
    if (!already_distance_monitored) {
        self stopempeffects(localplayer, oldval);
    }
}

// Namespace empgrenade/empgrenade
// Params 2, eflags: 0x0
// Checksum 0x7e756a27, Offset: 0x518
// Size: 0xbc
function startempeffects(localplayer, bwastimejump) {
    if (!isdefined(bwastimejump)) {
        bwastimejump = 0;
    }
    filter::init_filter_tactical(localplayer);
    filter::enable_filter_tactical(localplayer, 2);
    filter::set_filter_tactical_amount(localplayer, 2, 1);
    if (!bwastimejump) {
        playsound(0, "mpl_plr_emp_activate", (0, 0, 0));
    }
    audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

// Namespace empgrenade/empgrenade
// Params 3, eflags: 0x0
// Checksum 0x495135bd, Offset: 0x5e0
// Size: 0xb4
function stopempeffects(localplayer, oldval, bwastimejump) {
    if (!isdefined(bwastimejump)) {
        bwastimejump = 0;
    }
    filter::init_filter_tactical(localplayer);
    filter::disable_filter_tactical(localplayer, 2);
    if (oldval != 0 && !bwastimejump) {
        playsound(0, "mpl_plr_emp_deactivate", (0, 0, 0));
    }
    audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}

// Namespace empgrenade/empgrenade
// Params 1, eflags: 0x0
// Checksum 0x20410906, Offset: 0x6a0
// Size: 0x11c
function on_player_spawned(localclientnum) {
    self endon(#"disconnect");
    localplayer = getlocalplayer(localclientnum);
    if (localplayer != self) {
        return;
    }
    curval = localplayer clientfield::get_to_player("empd_monitor_distance");
    inkillcam = getinkillcam(localclientnum);
    if (curval > 0 && localplayer isempjammed()) {
        startempeffects(localplayer, inkillcam);
        localplayer monitordistance(localclientnum);
        return;
    }
    stopempeffects(localplayer, 0, 1);
    localplayer notify(#"end_emp_monitor_distance");
}

// Namespace empgrenade/empgrenade
// Params 7, eflags: 0x0
// Checksum 0xb5ef3e74, Offset: 0x7c8
// Size: 0xd4
function onempmonitordistancechanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    if (newval == 1) {
        startempeffects(localplayer, bwastimejump);
        localplayer monitordistance(localclientnum);
        return;
    }
    stopempeffects(localplayer, oldval, bwastimejump);
    localplayer notify(#"end_emp_monitor_distance");
}

// Namespace empgrenade/empgrenade
// Params 1, eflags: 0x0
// Checksum 0x4fddafe, Offset: 0x8a8
// Size: 0x2f8
function monitordistance(localclientnum) {
    localplayer = self;
    localplayer endon(#"death");
    localplayer endon(#"end_emp_monitor_distance");
    localplayer endon(#"team_changed");
    if (localplayer isempjammed() == 0) {
        return;
    }
    distance_to_closest_enemy_emp_ui_model = getuimodel(getuimodelforcontroller(localclientnum), "distanceToClosestEnemyEmpKillstreak");
    new_distance = 0;
    max_static_value = getdvarfloat("ks_emp_fullscreen_maxStaticValue");
    min_static_value = getdvarfloat("ks_emp_fullscreen_minStaticValue");
    min_radius_max_static = getdvarfloat("ks_emp_fullscreen_minRadiusMaxStatic");
    max_radius_min_static = getdvarfloat("ks_emp_fullscreen_maxRadiusMinStatic");
    if (isdefined(distance_to_closest_enemy_emp_ui_model)) {
        while (true) {
            /#
                max_static_value = getdvarfloat("<dev string:x28>");
                min_static_value = getdvarfloat("<dev string:x49>");
                min_radius_max_static = getdvarfloat("<dev string:x6a>");
                max_radius_min_static = getdvarfloat("<dev string:x8f>");
            #/
            new_distance = getuimodelvalue(distance_to_closest_enemy_emp_ui_model);
            range = max_radius_min_static - min_radius_max_static;
            current_static_value = max_static_value - (range <= 0 ? max_static_value : (new_distance - min_radius_max_static) / range);
            current_static_value = math::clamp(current_static_value, min_static_value, max_static_value);
            emp_grenaded = localplayer clientfield::get_to_player("empd") == 1;
            if (emp_grenaded && current_static_value < 1) {
                current_static_value = 1;
            }
            filter::set_filter_tactical_amount(localplayer, 2, current_static_value);
            wait 0.1;
        }
    }
}

