#namespace zm_silver_sound;

// Namespace zm_silver_sound/zm_silver_sound
// Params 0, eflags: 0x1 linked
// Checksum 0xacf2a376, Offset: 0x80
// Size: 0x1c
function init() {
    level thread function_c1db8d1a();
}

// Namespace zm_silver_sound/zm_silver_sound
// Params 0, eflags: 0x1 linked
// Checksum 0x68a6ddc5, Offset: 0xa8
// Size: 0xcc
function function_c1db8d1a() {
    level waittill(#"hash_3537191335625c");
    var_581d3017 = getent("audio_bfm", "targetname");
    playsoundatposition(#"hash_4ec7d60ade69984c", var_581d3017.origin);
    wait 1;
    playsoundatposition(#"hash_189fe24269ad58d", var_581d3017.origin);
    wait 1;
    var_581d3017 playloopsound(#"hash_6890863e534ae68d");
}

