#namespace trigger;

// Namespace trigger/trigger_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xbce3b407, Offset: 0x70
// Size: 0x11c
function function_thread(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    myentnum = self getentitynumber();
    if (ent ent_already_in(myentnum)) {
        return;
    }
    add_to_ent(ent, myentnum);
    if (isdefined(on_enter_payload)) {
        [[ on_enter_payload ]](ent);
    }
    while (isdefined(ent) && isdefined(self) && ent istouching(self)) {
        wait 0.1;
    }
    if (isdefined(ent)) {
        if (isdefined(on_exit_payload)) {
            [[ on_exit_payload ]](ent);
        }
        remove_from_ent(ent, myentnum);
    }
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb3dff40f, Offset: 0x198
// Size: 0x4c
function ent_already_in(var_d35ff8d8) {
    if (!isdefined(self._triggers)) {
        return false;
    }
    if (!isdefined(self._triggers[var_d35ff8d8])) {
        return false;
    }
    if (!self._triggers[var_d35ff8d8]) {
        return false;
    }
    return true;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd2f823a3, Offset: 0x1f0
// Size: 0x40
function add_to_ent(ent, var_d35ff8d8) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[var_d35ff8d8] = 1;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x6f24b993, Offset: 0x238
// Size: 0x4c
function remove_from_ent(ent, var_d35ff8d8) {
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[var_d35ff8d8])) {
        return;
    }
    ent._triggers[var_d35ff8d8] = 0;
}

// Namespace trigger/trigger_shared
// Params 2, eflags: 0x0
// Checksum 0xf826a710, Offset: 0x290
// Size: 0x4c
function death_monitor(ent, ender) {
    ent waittill(#"death");
    self endon(ender);
    self remove_from_ent(ent);
}

// Namespace trigger/trigger_shared
// Params 1, eflags: 0x0
// Checksum 0x9b116791, Offset: 0x2e8
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

