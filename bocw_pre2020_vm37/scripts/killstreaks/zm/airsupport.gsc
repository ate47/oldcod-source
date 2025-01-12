#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace namespace_bf7415ae;

// Namespace namespace_bf7415ae/airsupport
// Params 5, eflags: 0x1 linked
// Checksum 0xb06a8193, Offset: 0xe8
// Size: 0x74
function function_890b3889(killstreakweapon, maxrange, var_f6825ff2, var_c7502f87, var_7551540f) {
    self thread function_b66d4fac(maxrange, var_f6825ff2);
    self thread function_f3305d7f(var_c7502f87, var_7551540f);
    self thread function_a2eec6c2(killstreakweapon);
}

// Namespace namespace_bf7415ae/airsupport
// Params 1, eflags: 0x5 linked
// Checksum 0x87ed38ba, Offset: 0x168
// Size: 0x1ce
function private function_a2eec6c2(killstreakweapon) {
    self endon(#"disconnect");
    waitresult = self waittill(#"weapon_fired", #"weapon_change");
    if (waitresult._notify === "weapon_fired" && waitresult.weapon === killstreakweapon) {
        self notify(#"lockin_selection");
        return;
    }
    if (waitresult._notify === "weapon_change" && waitresult.last_weapon === killstreakweapon) {
        self notify(#"cancel_selection");
        return;
    }
    /#
        str_notify = function_9e72a96(waitresult._notify);
        str_weapon = function_9e72a96(waitresult.weapon.name);
        var_d8d53d01 = isdefined(waitresult.last_weapon) ? function_9e72a96(waitresult.last_weapon.name) : "<dev string:x38>";
        assertmsg("<dev string:x45>" + str_notify + "<dev string:x54>" + str_weapon + "<dev string:x65>" + var_d8d53d01);
    #/
    self notify(#"cancel_selection");
}

// Namespace namespace_bf7415ae/airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0x57e3a448, Offset: 0x340
// Size: 0x9e
function function_be6de952() {
    self endon(#"disconnect");
    waitresult = self waittill(#"lockin_selection", #"cancel_selection");
    if (waitresult._notify === "lockin_selection") {
        s_location = spawnstruct();
        s_location.origin = self.mdl_target.origin;
        return s_location;
    }
    return undefined;
}

// Namespace namespace_bf7415ae/airsupport
// Params 2, eflags: 0x5 linked
// Checksum 0x869e7eba, Offset: 0x3e8
// Size: 0xbc
function private function_f3305d7f(var_c7502f87, var_7551540f) {
    self notify("78a307f001551c36");
    self endon("78a307f001551c36");
    waitresult = self waittill(#"disconnect", #"cancel_selection", #"lockin_selection");
    if (waitresult._notify === "lockin_selection") {
        self waittill(#"disconnect", var_7551540f);
    }
    self thread function_ecb58f93(var_c7502f87);
}

// Namespace namespace_bf7415ae/airsupport
// Params 1, eflags: 0x5 linked
// Checksum 0x6e8ff52, Offset: 0x4b0
// Size: 0x64
function private function_ecb58f93(var_c7502f87) {
    if (isdefined(self.mdl_target)) {
        mdl_target = self.mdl_target;
        mdl_target [[ var_c7502f87 ]]();
        util::wait_network_frame();
        mdl_target delete();
    }
}

// Namespace namespace_bf7415ae/airsupport
// Params 2, eflags: 0x5 linked
// Checksum 0xdc9f8c34, Offset: 0x520
// Size: 0x1c0
function private function_b66d4fac(maxrange, var_f6825ff2) {
    self notify("6b68092f3dd35251");
    self endon("6b68092f3dd35251");
    self endon(#"disconnect", #"cancel_selection", #"lockin_selection");
    var_4ad3bc13 = (0, 0, 8);
    if (!isdefined(self.mdl_target)) {
        self.mdl_target = util::spawn_model("tag_origin", self.origin, (270, 0, 0));
    }
    util::wait_network_frame();
    self.mdl_target [[ var_f6825ff2 ]]();
    while (true) {
        v_start = self geteye();
        v_forward = self getweaponforwarddir();
        v_end = v_start + v_forward * maxrange;
        a_trace = bullettrace(v_start, v_end, 0, self.mdl_target, 1, 0);
        self.var_5acfe25f = a_trace[#"position"];
        self.mdl_target moveto(self.var_5acfe25f + var_4ad3bc13, 0.05);
        wait 0.1;
    }
}

