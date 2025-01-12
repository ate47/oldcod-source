#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace wz_firing_range;

// Namespace wz_firing_range/wz_firing_range
// Params 1, eflags: 0x0
// Checksum 0x6cc0ad57, Offset: 0x98
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
// Checksum 0xafe2462f, Offset: 0x158
// Size: 0x142
function private init_target() {
    self.hitindex = 1;
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
// Checksum 0xe3c81cbe, Offset: 0x2a8
// Size: 0x1d4
function private follow_path() {
    while (true) {
        timems = gettime();
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
            playsoundatposition("amb_target_stop", self.origin);
        }
        self.struct = struct;
        waitframe(1);
    }
}

// Namespace wz_firing_range/event_52bf9a5a
// Params 1, eflags: 0x44
// Checksum 0x39b538ba, Offset: 0x488
// Size: 0x1e6
function private event_handler[event_52bf9a5a] function_8e98cf9d(eventstruct) {
    dynent = eventstruct.ent;
    if (!isdefined(dynent.hitindex)) {
        return;
    }
    dynent.health = 50;
    if (function_7f51b166(dynent) != 0) {
        return;
    }
    angles = dynent.angles - (0, 270, 0);
    fwd = anglestoforward(angles);
    if (vectordot((0, 0, 0) - eventstruct.dir, fwd) <= 0) {
        return;
    }
    bundle = function_474cb3a(dynent);
    if (isstruct(bundle) && isarray(bundle.dynentstates)) {
        var_a822c37f = bundle.dynentstates[dynent.hitindex];
        if (isdefined(var_a822c37f.stateanim)) {
            function_9e7b6692(dynent, dynent.hitindex);
            animlength = getanimlength(var_a822c37f.stateanim);
            wait animlength;
            function_9e7b6692(dynent, 0);
            dynent.hitindex = 1 + dynent.hitindex % 2;
        }
    }
}

