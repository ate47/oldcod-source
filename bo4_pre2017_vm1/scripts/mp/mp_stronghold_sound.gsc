#using scripts/core_common/struct;

#namespace mp_stronghold_sound;

// Namespace mp_stronghold_sound/mp_stronghold_sound
// Params 0, eflags: 0x0
// Checksum 0x236f91bb, Offset: 0xc8
// Size: 0x1c
function main() {
    level thread snd_dmg_chant();
}

// Namespace mp_stronghold_sound/mp_stronghold_sound
// Params 0, eflags: 0x0
// Checksum 0x8e4e090b, Offset: 0xf0
// Size: 0xa0
function snd_dmg_chant() {
    trigger = getent("snd_chant", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        waitresult = trigger waittill("trigger");
        if (isplayer(waitresult.activator)) {
            trigger playsound("amb_monk_chant");
        }
    }
}

