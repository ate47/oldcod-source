#namespace flowgraph_sound;

// Namespace flowgraph_sound/flowgraph_sound
// Params 3, eflags: 0x0
// Checksum 0x90b73d25, Offset: 0x60
// Size: 0x38
function playsoundaliasatposition(*x, snd_name, v_position) {
    playsoundatposition(snd_name, v_position);
    return true;
}

