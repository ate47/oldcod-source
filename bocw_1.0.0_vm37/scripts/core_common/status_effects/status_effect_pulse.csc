#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace status_effect_pulse;

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x6
// Checksum 0xaccff64f, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_pulse", &preinit, undefined, undefined, undefined);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x4
// Checksum 0x5c0efbb, Offset: 0xf8
// Size: 0x4c
function private preinit() {
    clientfield::register("toplayer", "pulsed", 1, 1, "int", &on_pulsed_change, 0, 0);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 7, eflags: 0x0
// Checksum 0x53a87ac3, Offset: 0x150
// Size: 0xa4
function on_pulsed_change(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    localplayer = function_5c10bd79(binitialsnap);
    if (bwastimejump == 1) {
        self start_pulse_effects(localplayer);
        return;
    }
    self stop_pulse_effects(localplayer, fieldname);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 2, eflags: 0x0
// Checksum 0xe99c4b05, Offset: 0x200
// Size: 0x6c
function start_pulse_effects(*localplayer, bwastimejump = 0) {
    if (!bwastimejump) {
        playsound(0, #"mpl_plr_emp_activate", (0, 0, 0));
    }
    audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 3, eflags: 0x0
// Checksum 0xafc24b01, Offset: 0x278
// Size: 0x84
function stop_pulse_effects(*localplayer, oldval, bwastimejump = 0) {
    if (oldval != 0 && !bwastimejump) {
        playsound(0, #"mpl_plr_emp_deactivate", (0, 0, 0));
    }
    audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}

