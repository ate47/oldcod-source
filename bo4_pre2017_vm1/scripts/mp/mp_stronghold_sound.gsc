#using scripts/core_common/struct;

#namespace namespace_5f813f0f;

// Namespace namespace_5f813f0f/namespace_5f813f0f
// Params 0, eflags: 0x0
// Checksum 0x236f91bb, Offset: 0xc8
// Size: 0x1c
function main() {
    level thread function_b6d60d2();
}

// Namespace namespace_5f813f0f/namespace_5f813f0f
// Params 0, eflags: 0x0
// Checksum 0x8e4e090b, Offset: 0xf0
// Size: 0xa0
function function_b6d60d2() {
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

