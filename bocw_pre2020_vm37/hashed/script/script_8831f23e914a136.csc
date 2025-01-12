#using scripts\core_common\system_shared;

#namespace namespace_131517b7;

// Namespace namespace_131517b7/namespace_131517b7
// Params 0, eflags: 0x6
// Checksum 0x819ec55e, Offset: 0x88
// Size: 0x34
function private autoexec __init__system__() {
    system::register(#"hash_26735a31c43bda52", undefined, undefined, &function_5b164bbc, undefined);
}

// Namespace namespace_131517b7/namespace_131517b7
// Params 0, eflags: 0x1 linked
// Checksum 0x7eb25b10, Offset: 0xc8
// Size: 0x126
function function_5b164bbc() {
    foreach (dynent in function_dc7f007()) {
        dynent.ondestroyed = &function_61fb9b33;
        bundle = function_489009c1(dynent);
        if (isdefined(bundle) && isdefined(bundle.var_e32432cf)) {
            switch (bundle.var_e32432cf) {
            case #"hash_3c27aafc8cd27c4":
                dynent.start_origin = dynent.origin;
                dynent.start_angles = dynent.angles;
                dynent thread function_733e5314();
                break;
            }
        }
    }
}

// Namespace namespace_131517b7/namespace_131517b7
// Params 1, eflags: 0x1 linked
// Checksum 0xd4e11cbb, Offset: 0x1f8
// Size: 0xec
function function_61fb9b33(eventstruct) {
    function_27b5ddff(eventstruct.ent);
    launchdynent(eventstruct.ent, eventstruct.dir * 5, eventstruct.position);
    bundle = function_489009c1(eventstruct.ent);
    if (isdefined(bundle) && isdefined(bundle.dynentstates)) {
        stateindex = isdefined(bundle.destroyed) ? bundle.destroyed : 0;
        if (isdefined(bundle.dynentstates[stateindex])) {
            function_e2a06860(0, eventstruct.ent, stateindex);
        }
    }
}

// Namespace namespace_131517b7/namespace_131517b7
// Params 0, eflags: 0x1 linked
// Checksum 0xad026a3e, Offset: 0x2f0
// Size: 0x6b8
function function_733e5314() {
    self endon(#"state_changed");
    var_25dac1e7 = randomfloatrange(30, 90);
    bundle = function_489009c1(self);
    var_2828eabf = isdefined(bundle.destroyed) ? bundle.destroyed : 0;
    var_d3b6e91d = isdefined(bundle.idlestate) ? bundle.idlestate : 0;
    var_60138ede = isdefined(bundle.var_7320b70a) ? bundle.var_7320b70a : 0;
    var_5f94b69b = isdefined(bundle.cleanupstate) ? bundle.cleanupstate : 0;
    var_de89d793 = bundle.dynentstates[var_60138ede];
    if (!isdefined(var_de89d793) || !isdefined(var_de89d793.stateanim)) {
        return;
    }
    var_381de367 = var_de89d793.stateanim;
    var_931fd54a = is_true(var_de89d793.var_3f644836);
    idle_anim = bundle.dynentstates[var_d3b6e91d].stateanim;
    bundle = undefined;
    self.var_621ee87d = 1;
    state = 0;
    for (waitresult = undefined; self.health > 0; waitresult = self waittilltimeout(randomfloatrange(3, 5), #"hash_2b397aad1337c105", #"wall_detected")) {
        angles = undefined;
        var_5430ce52 = var_25dac1e7;
        if (!isdefined(waitresult) || waitresult._notify !== "wall_detected") {
            timeout = getrealtime();
        }
        if (self.origin[2] < -10000 || getrealtime() - timeout > 3000) {
            function_e2a06860(0, self, var_5f94b69b);
            wait 1;
            self.origin = self.start_origin;
            self.angles = self.start_angles;
            wait 5;
            function_e2a06860(0, self, var_d3b6e91d);
            self thread function_733e5314();
            return;
        }
        if (!isdefined(waitresult) || waitresult._notify === "timeout") {
            if (state === 2 || state === 1) {
                var_116c2a14 = function_76904e7f();
                angles = vectortoangles(var_116c2a14);
                if (state === 1) {
                    function_27b5ddff(self);
                }
                state = 0;
                var_da43a859 = 1;
            } else {
                function_1e23c01f(self, idle_anim);
                self.var_b18f1e7a = idle_anim;
                function_d380c9a3(self);
                state = 2;
            }
        } else if (isdefined(waitresult) && waitresult._notify === "wall_detected") {
            if (lengthsquared(waitresult.normal) == 0) {
                function_e2a06860(0, self, var_5f94b69b);
                wait 1;
                self.origin = self.start_origin;
                self.angles = self.start_angles;
                wait 5;
                function_e2a06860(0, self, var_d3b6e91d);
                self thread function_733e5314();
                return;
            }
            right = vectorcross(waitresult.normal, (0, 0, 1));
            angles = vectortoangles(right);
            if (absangleclamp360(angles[1] - self.angles[1]) < 0.001) {
                angles = (angles[0], angles[1] * -1, angles[2]);
            }
            var_5430ce52 = 90;
        } else {
            var_21a930c2 = self.origin - waitresult.var_6be223c2;
            angles = vectortoangles(var_21a930c2);
            if (state === 0) {
                function_27b5ddff(self);
            }
            state = 1;
            var_da43a859 = 1;
            var_5430ce52 = 240;
        }
        if (isdefined(angles)) {
            if (self.var_b18f1e7a !== var_381de367 || self.var_51b1adce !== var_da43a859) {
                function_1ef41caa(self, var_381de367, undefined, var_da43a859, var_931fd54a);
                self.var_b18f1e7a = var_381de367;
                self.var_51b1adce = var_da43a859;
            }
            function_64303428(self, angles[1], var_5430ce52);
        }
        if (waitresult._notify === "wall_detected") {
            wait 1;
        }
        waitresult = undefined;
    }
}

// Namespace namespace_131517b7/namespace_131517b7
// Params 0, eflags: 0x1 linked
// Checksum 0xe54ca6ae, Offset: 0x9b0
// Size: 0x6e
function function_76904e7f() {
    theta = randomfloatrange(0, 360);
    x = sin(theta);
    y = cos(theta);
    return (x, y, 0);
}

