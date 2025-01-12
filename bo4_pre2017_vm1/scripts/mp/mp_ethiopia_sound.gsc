#using scripts/core_common/audio_shared;
#using scripts/core_common/struct;

#namespace mp_ethiopia_sound;

// Namespace mp_ethiopia_sound/mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0x8b150cc1, Offset: 0x120
// Size: 0x4c
function main() {
    level thread function_a601dc4f();
    level thread function_c7368d93();
    level thread function_f6802baa();
}

// Namespace mp_ethiopia_sound/mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0xc2e65ea2, Offset: 0x178
// Size: 0xa6
function function_a601dc4f() {
    trigger = getent("snd_monkey", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        waitresult = trigger waittill("trigger");
        if (isplayer(waitresult.activator)) {
            trigger playsound("amb_monkey_shot");
            wait 15;
        }
    }
}

// Namespace mp_ethiopia_sound/mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0x7145cdcc, Offset: 0x228
// Size: 0xa6
function function_c7368d93() {
    trigger = getent("snd_cheet", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        waitresult = trigger waittill("trigger");
        if (isplayer(waitresult.activator)) {
            trigger playsound("amb_cheeta_shot");
            wait 15;
        }
    }
}

// Namespace mp_ethiopia_sound/mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0x1d594d13, Offset: 0x2d8
// Size: 0xa6
function function_f6802baa() {
    trigger = getent("snd_boar", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        waitresult = trigger waittill("trigger");
        if (isplayer(waitresult.activator)) {
            trigger playsound("amb_boar_shot");
            wait 15;
        }
    }
}

