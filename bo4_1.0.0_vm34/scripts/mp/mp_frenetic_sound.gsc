#namespace mp_frenetic_sound;

// Namespace mp_frenetic_sound/mp_frenetic_sound
// Params 0, eflags: 0x0
// Checksum 0xfff5009e, Offset: 0x68
// Size: 0x34
function main() {
    level thread function_56df857b();
    level thread function_c3d4662d();
}

// Namespace mp_frenetic_sound/mp_frenetic_sound
// Params 0, eflags: 0x0
// Checksum 0xea5090af, Offset: 0xa8
// Size: 0xa8
function function_56df857b() {
    while (true) {
        wait 300;
        playsoundatposition(#"hash_4eb7a29f1b1a264", (905, 50, 1091));
        playsoundatposition(#"hash_44f8b894cb0ec41e", (1053, 975, 304));
        playsoundatposition(#"hash_44f8b794cb0ec26b", (1218, -1599, 270));
    }
}

// Namespace mp_frenetic_sound/mp_frenetic_sound
// Params 0, eflags: 0x0
// Checksum 0xcc07cb8f, Offset: 0x158
// Size: 0x58
function function_c3d4662d() {
    while (true) {
        level waittill(#"hash_5b10534e0aa25120");
        playsoundatposition(#"hash_119425eb77c9699a", (905, 50, 1091));
    }
}

