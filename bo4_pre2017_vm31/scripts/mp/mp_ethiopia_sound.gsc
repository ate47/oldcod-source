#using scripts/core_common/audio_shared;
#using scripts/core_common/struct;

#namespace mp_ethiopia_sound;

// Namespace mp_ethiopia_sound/mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0x8b150cc1, Offset: 0x120
// Size: 0x4c
function main() {
    level thread snd_dmg_monk();
    level thread snd_dmg_cheet();
    level thread snd_dmg_boar();
}

// Namespace mp_ethiopia_sound/mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0xc2e65ea2, Offset: 0x178
// Size: 0xa6
function snd_dmg_monk() {
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
function snd_dmg_cheet() {
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
function snd_dmg_boar() {
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

