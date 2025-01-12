#namespace shaderanim;

// Namespace shaderanim/shaderanim_shared
// Params 6, eflags: 0x0
// Checksum 0xf6be28c8, Offset: 0x90
// Size: 0x1dc
function animate_crack(localclientnum, vectorname, delay, duration, start, end) {
    self endon(#"death");
    delayseconds = delay / 60;
    wait delayseconds;
    direction = 1;
    if (start > end) {
        direction = -1;
    }
    durationseconds = duration / 60;
    valstep = 0;
    if (durationseconds > 0) {
        valstep = (end - start) / durationseconds / 0.01;
    }
    timestep = 0.01 * direction;
    value = start;
    self mapshaderconstant(localclientnum, 0, vectorname, value, 0, 0, 0);
    for (i = 0; i < durationseconds; i += timestep) {
        value += valstep;
        wait 0.01;
        self mapshaderconstant(localclientnum, 0, vectorname, value, 0, 0, 0);
    }
    self mapshaderconstant(localclientnum, 0, vectorname, end, 0, 0, 0);
}

// Namespace shaderanim/shaderanim_shared
// Params 3, eflags: 0x0
// Checksum 0x1adf4d41, Offset: 0x278
// Size: 0x4c
function shaderanim_update_opacity(entity, localclientnum, opacity) {
    entity mapshaderconstant(localclientnum, 0, "scriptVector0", opacity, 0, 0, 0);
}

