#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\system_shared;

#namespace status_effect_pulse;

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x2
// Checksum 0x404d048d, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_pulse", &__init__, undefined, undefined);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0xc45c1d68, Offset: 0xf8
// Size: 0x4c
function __init__() {
    clientfield::register("toplayer", "pulsed", 1, 1, "int", &on_pulsed_change, 0, 0);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 7, eflags: 0x0
// Checksum 0x774ed6eb, Offset: 0x150
// Size: 0xa4
function on_pulsed_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = function_f97e7787(localclientnum);
    if (newval == 1) {
        self start_pulse_effects(localplayer);
        return;
    }
    self stop_pulse_effects(localplayer, oldval);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 2, eflags: 0x0
// Checksum 0x473aed07, Offset: 0x200
// Size: 0xbc
function start_pulse_effects(localplayer, bwastimejump = 0) {
    filter::init_filter_tactical(localplayer);
    filter::enable_filter_tactical(localplayer, 2);
    filter::set_filter_tactical_amount(localplayer, 2, 1);
    if (!bwastimejump) {
        playsound(0, #"mpl_plr_emp_activate", (0, 0, 0));
    }
    audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 3, eflags: 0x0
// Checksum 0x6cc6944f, Offset: 0x2c8
// Size: 0xb4
function stop_pulse_effects(localplayer, oldval, bwastimejump = 0) {
    filter::init_filter_tactical(localplayer);
    filter::disable_filter_tactical(localplayer, 2);
    if (oldval != 0 && !bwastimejump) {
        playsound(0, #"mpl_plr_emp_deactivate", (0, 0, 0));
    }
    audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}

