#using scripts/core_common/audio_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace status_effect_pulse;

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x2
// Checksum 0x4f4c45c9, Offset: 0x1b8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("status_effect_pulse", &__init__, undefined, undefined);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0x6496b196, Offset: 0x1f8
// Size: 0x4c
function __init__() {
    clientfield::register("toplayer", "pulsed", 1, 1, "int", &on_pulsed_change, 0, 0);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 7, eflags: 0x0
// Checksum 0x3b4cdcc, Offset: 0x250
// Size: 0xa4
function on_pulsed_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    if (newval == 1) {
        self start_pulse_effects(localplayer);
        return;
    }
    self stop_pulse_effects(localplayer, oldval);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 2, eflags: 0x0
// Checksum 0x2e976394, Offset: 0x300
// Size: 0xbc
function start_pulse_effects(localplayer, bwastimejump) {
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

// Namespace status_effect_pulse/status_effect_pulse
// Params 3, eflags: 0x0
// Checksum 0x6e148e54, Offset: 0x3c8
// Size: 0xb4
function stop_pulse_effects(localplayer, oldval, bwastimejump) {
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

