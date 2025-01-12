#namespace mp_silo_sound;

// Namespace mp_silo_sound/mp_silo_sound
// Params 0, eflags: 0x0
// Checksum 0xda86609f, Offset: 0x68
// Size: 0x34
function main() {
    level thread function_ad18e146();
    level thread function_bdfdb340();
}

// Namespace mp_silo_sound/mp_silo_sound
// Params 0, eflags: 0x0
// Checksum 0xfc07fbcd, Offset: 0xa8
// Size: 0x58
function function_ad18e146() {
    while (true) {
        level waittill(#"hash_388057c56b2acf4c");
        playsoundatposition(#"hash_3eeefdf762713cfa", (-7169, -4858, 547));
    }
}

// Namespace mp_silo_sound/mp_silo_sound
// Params 0, eflags: 0x0
// Checksum 0x332bd929, Offset: 0x108
// Size: 0x88
function function_bdfdb340() {
    while (true) {
        level waittill(#"hash_771bf8874446d6f6");
        playsoundatposition(#"hash_3ca0f0298d34aa6a", (-5364, -10363, 608));
        playsoundatposition(#"hash_3ca0f0298d34aa6a", (-7397, 8858, 1244));
    }
}

