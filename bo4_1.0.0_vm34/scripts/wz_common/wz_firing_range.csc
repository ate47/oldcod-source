#using scripts\core_common\struct;

#namespace wz_firing_range;

// Namespace wz_firing_range/wz_firing_range
// Params 1, eflags: 0x0
// Checksum 0xb560c08a, Offset: 0x80
// Size: 0xb8
function init_targets(targetname) {
    targets = getdynentarray(targetname);
    foreach (target in targets) {
        if (target init_target()) {
            target thread follow_path();
        }
    }
}

// Namespace wz_firing_range/wz_firing_range
// Params 0, eflags: 0x4
// Checksum 0x94087a77, Offset: 0x140
// Size: 0x132
function private init_target() {
    if (!isdefined(self.target)) {
        return false;
    }
    structs = [];
    totalms = 0;
    var_fac93038 = struct::get(self.target, "targetname");
    struct = var_fac93038;
    do {
        if (!isdefined(struct) || !isint(struct.script_int) || struct.script_int <= 0) {
            return false;
        }
        structs[structs.size] = struct;
        totalms += struct.script_int;
        struct = struct::get(struct.target, "targetname");
    } while (struct != var_fac93038);
    self.structs = structs;
    self.totalms = totalms;
    return true;
}

// Namespace wz_firing_range/wz_firing_range
// Params 0, eflags: 0x4
// Checksum 0x17782707, Offset: 0x280
// Size: 0x1c4
function private follow_path() {
    while (true) {
        timems = getservertime(0);
        var_11b1fe4c = timems % self.totalms;
        for (i = 0; var_11b1fe4c > self.structs[i].script_int; i++) {
            var_11b1fe4c -= self.structs[i].script_int;
        }
        struct = self.structs[i];
        var_94e74ee1 = self.structs[(i + 1) % self.structs.size];
        self.origin = vectorlerp(struct.origin, var_94e74ee1.origin, var_11b1fe4c / struct.script_int);
        angles = (0, 270, 0) + struct.angles;
        if (!isdefined(self.struct)) {
            self.angles = angles;
        } else if (self.struct != struct) {
            self function_f8af4dff(angles, isdefined(struct.script_float) ? struct.script_float : 1);
        }
        self.struct = struct;
        waitframe(1);
    }
}

