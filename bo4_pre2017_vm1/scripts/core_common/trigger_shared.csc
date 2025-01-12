#namespace trigger;

// Namespace trigger/trigger_shared
// Params 3, eflags: 0x0
// Checksum 0xec2c9784, Offset: 0x88
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
// Checksum 0x990e87c2, Offset: 0x188
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
// Checksum 0xb4da5e3e, Offset: 0x200
// Size: 0x62
function add_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xc3a628a0, Offset: 0x270
// Size: 0x82
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
// Checksum 0x7874336e, Offset: 0x300
// Size: 0x44
function death_monitor(ent, ender) {
    ent waittill("death");
    self endon(ender);
    self remove_from_ent(ent);
}

