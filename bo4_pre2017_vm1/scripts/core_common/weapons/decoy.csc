#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace decoy;

// Namespace decoy/decoy
// Params 0, eflags: 0x0
// Checksum 0x34a262cb, Offset: 0x118
// Size: 0x44
function init_shared() {
    level thread function_e678919e();
    callback::add_weapon_type("nightingale", &spawned);
}

// Namespace decoy/decoy
// Params 1, eflags: 0x0
// Checksum 0x4b7a766d, Offset: 0x168
// Size: 0x24
function spawned(localclientnum) {
    self thread function_7756ea79(localclientnum);
}

// Namespace decoy/decoy
// Params 1, eflags: 0x0
// Checksum 0x55738f0, Offset: 0x198
// Size: 0x68
function function_7756ea79(localclientnum) {
    self endon(#"death");
    while (true) {
        self waittill("fake_fire");
        playfxontag(localclientnum, level._effect["decoy_fire"], self, "tag_origin");
    }
}

// Namespace decoy/decoy
// Params 0, eflags: 0x0
// Checksum 0xe31eccbe, Offset: 0x208
// Size: 0x1e
function function_e678919e() {
    while (true) {
        self waittill("fake_fire");
    }
}

