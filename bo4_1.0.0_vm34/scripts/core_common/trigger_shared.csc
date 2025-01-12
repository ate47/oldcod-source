#namespace trigger;

// Namespace trigger/trigger_shared
// Params 3, eflags: 0x0
// Checksum 0x1123ffd2, Offset: 0x70
// Size: 0xf4
function function_thread(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"death");
    if (ent ent_already_in(self)) {
        return;
    }
    add_to_ent(ent, self);
    if (isdefined(on_enter_payload)) {
        [[ on_enter_payload ]](ent);
    }
    while (isdefined(ent) && ent istouching(self)) {
        waitframe(1);
    }
    if (isdefined(ent) && isdefined(on_exit_payload)) {
        [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        remove_from_ent(ent, self);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x40425d66, Offset: 0x170
// Size: 0x70
function ent_already_in(trig) {
    if (!isdefined(self._triggers)) {
        return false;
    }
    if (!isdefined(self._triggers[trig getentitynumber()])) {
        return false;
    }
    if (!self._triggers[trig getentitynumber()]) {
        return false;
    }
    return true;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x5feefc2c, Offset: 0x1e8
// Size: 0x5a
function add_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x991194f3, Offset: 0x250
// Size: 0x72
function remove_from_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[trig getentitynumber()])) {
        return;
    }
    ent._triggers[trig getentitynumber()] = 0;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0x977b53f5, Offset: 0x2d0
// Size: 0x4c
function death_monitor(ent, ender) {
    ent waittill(#"death");
    self endon(ender);
    self remove_from_ent(ent);
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0xed7716b9, Offset: 0x328
// Size: 0x7c
function trigger_wait(n_clientnum) {
    self endon(#"trigger");
    if (isdefined(self.targetname)) {
        trig = getent(n_clientnum, self.targetname, "target");
        if (isdefined(trig)) {
            trig waittill(#"trigger");
        }
    }
}

