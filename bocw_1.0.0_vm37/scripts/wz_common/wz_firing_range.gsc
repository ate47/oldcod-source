#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace wz_firing_range;

// Namespace wz_firing_range/wz_firing_range
// Params 1, eflags: 0x0
// Checksum 0x42a221ec, Offset: 0x80
// Size: 0xc8
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
// Checksum 0xc15ae92e, Offset: 0x150
// Size: 0x14a
function private init_target() {
    self.hitindex = 1;
    if (!isdefined(self.target)) {
        return false;
    }
    structs = [];
    totalms = 0;
    var_dc0e8c88 = struct::get(self.target, "targetname");
    struct = var_dc0e8c88;
    do {
        if (!isdefined(struct) || !isint(struct.script_int) || struct.script_int <= 0) {
            return false;
        }
        structs[structs.size] = struct;
        totalms += struct.script_int;
        struct = struct::get(struct.target, "targetname");
    } while (struct != var_dc0e8c88);
    assert(structs.size == 2);
    self.structs = structs;
    self.totalms = totalms;
    return true;
}

// Namespace wz_firing_range/wz_firing_range
// Params 2, eflags: 0x4
// Checksum 0x21b314b9, Offset: 0x2a8
// Size: 0x84
function private function_5bab934a(*struct, var_d1d733b4) {
    var_32c844bb = var_d1d733b4 - gettime();
    if (var_32c844bb <= 0) {
        var_32c844bb = int(1 * 1000);
    }
    movetime = float(var_32c844bb) / 1000;
    return movetime;
}

// Namespace wz_firing_range/wz_firing_range
// Params 0, eflags: 0x4
// Checksum 0x9c68d309, Offset: 0x338
// Size: 0x166
function private follow_path() {
    starttime = int(floor(gettime() / self.totalms) * self.totalms + self.totalms);
    while (gettime() < starttime) {
        waitframe(1);
    }
    endtime = starttime;
    while (true) {
        endtime += self.structs[0].script_int;
        movetime = function_5bab934a(self.structs[0], endtime);
        self function_49ed8678(self.structs[1].origin, movetime);
        wait movetime;
        endtime += self.structs[1].script_int;
        movetime = function_5bab934a(self.structs[1], endtime);
        self function_49ed8678(self.structs[0].origin, movetime);
        wait movetime;
    }
}

// Namespace wz_firing_range/event_cf200f34
// Params 1, eflags: 0x44
// Checksum 0x8e1ea73b, Offset: 0x4a8
// Size: 0x1d2
function private event_handler[event_cf200f34] function_209450ae(eventstruct) {
    dynent = eventstruct.ent;
    if (!isdefined(dynent.hitindex)) {
        return;
    }
    dynent.health = 50;
    if (function_ffdbe8c2(dynent) != 0) {
        return;
    }
    angles = dynent.angles - (0, 270, 0);
    fwd = anglestoforward(angles);
    if (vectordot((0, 0, 0) - eventstruct.dir, fwd) <= 0) {
        return;
    }
    bundle = function_489009c1(dynent);
    if (isstruct(bundle) && isarray(bundle.dynentstates)) {
        var_daedea1b = bundle.dynentstates[dynent.hitindex];
        if (isdefined(var_daedea1b.stateanim)) {
            function_e2a06860(dynent, dynent.hitindex);
            animlength = getanimlength(var_daedea1b.stateanim);
            wait animlength;
            function_e2a06860(dynent, 0);
            dynent.hitindex = 1 + dynent.hitindex % 2;
        }
    }
}

