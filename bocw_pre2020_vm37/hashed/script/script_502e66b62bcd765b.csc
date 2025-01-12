#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;

#namespace namespace_d916460b;

// Namespace namespace_d916460b/namespace_d916460b
// Params 0, eflags: 0x6
// Checksum 0xc0bfe2dd, Offset: 0x128
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_2d940adae179fd01", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0x86bafbf8, Offset: 0x178
// Size: 0x7c
function private function_70a657d8(*localclientnum) {
    vehicle::add_vehicletype_callback("helicopter_light", &function_aa9ec3fb);
    clientfield::register("scriptmover", "deathfx", 1, 1, "int", &field_do_deathfx, 0, 0);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0x2e9c835a, Offset: 0x200
// Size: 0x54
function private function_aa9ec3fb(localclientnum) {
    self.var_41860110 = &function_74272495;
    self.var_c6a9216 = &function_8411122e;
    self thread function_69fda304(localclientnum);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0xba121686, Offset: 0x260
// Size: 0x98
function private function_69fda304(localclientnum) {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"enter_vehicle");
        if (isdefined(waitresult.player)) {
            if (waitresult.player function_21c0fa55()) {
                waitresult.player thread function_732976d8(localclientnum, self);
            }
        }
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x4
// Checksum 0xffef54a, Offset: 0x300
// Size: 0x5c
function private heli_exit(localclientnum) {
    self endon(#"death");
    self endon(#"disconnect");
    self waittill(#"exit_vehicle");
    self function_d1731820(localclientnum);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0x97c32839, Offset: 0x368
// Size: 0x4e
function private function_d1731820(localclientnum) {
    if (isdefined(self) && isdefined(self.var_a9757792)) {
        self stoprumble(localclientnum, self.var_a9757792);
        self.var_a9757792 = undefined;
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 2, eflags: 0x5 linked
// Checksum 0x68ee594, Offset: 0x3c0
// Size: 0x84
function private function_ff8d2820(localclientnum, rumble) {
    if (!isdefined(self)) {
        return;
    }
    if (self.var_a9757792 === rumble) {
        return;
    }
    if (isdefined(self.var_a9757792)) {
        self function_d1731820(localclientnum);
    }
    self.var_a9757792 = rumble;
    self playrumblelooponentity(localclientnum, self.var_a9757792);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 2, eflags: 0x5 linked
// Checksum 0xabfd72dc, Offset: 0x450
// Size: 0x264
function private function_732976d8(localclientnum, vehicle) {
    self notify("1564e4213331c4f");
    self endon("1564e4213331c4f");
    self endon(#"death");
    self endon(#"disconnect");
    self endoncallback(&function_f2d7df13, #"exit_vehicle");
    var_26408b5d = function_a3f6cdac(210);
    offsetorigin = (0, 0, 210 * 2);
    while (true) {
        if (!isdefined(vehicle) || !isinvehicle(localclientnum, vehicle)) {
            waitframe(1);
            continue;
        }
        if (!vehicle function_973c841f(self) && self function_21c0fa55()) {
            self function_d1731820(localclientnum);
            wait 1;
            continue;
        }
        trace = bullettrace(vehicle.origin, vehicle.origin - offsetorigin, 0, vehicle, 1);
        distsqr = distancesquared(vehicle.origin, trace[#"position"]);
        if (trace[#"fraction"] == 1) {
            self function_d1731820(localclientnum);
            wait 1;
            continue;
        }
        if (distsqr > var_26408b5d) {
            self function_d1731820(localclientnum);
            wait 0.2;
            continue;
        }
        self function_ff8d2820(localclientnum, "fallwind_loop_slow");
        wait 0.2;
    }
    self function_d1731820(localclientnum);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 1, eflags: 0x5 linked
// Checksum 0x5f26f005, Offset: 0x6c0
// Size: 0x2c
function private function_f2d7df13(*notifyhash) {
    self function_d1731820(self.localclientnum);
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 7, eflags: 0x5 linked
// Checksum 0xd38d6d5a, Offset: 0x6f8
// Size: 0x6c
function private field_do_deathfx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self util::playfxontag(fieldname, "vehicle/fx8_vdest_heli_fuselage_destroyed", self, "tag_origin");
    }
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 2, eflags: 0x5 linked
// Checksum 0xd476f122, Offset: 0x770
// Size: 0x102
function private function_8411122e(*localclientnum, *owner) {
    surfaces = [];
    if (isdefined(self.trace)) {
        if (self.trace[#"fraction"] != 1) {
            if (!isdefined(surfaces)) {
                surfaces = [];
            } else if (!isarray(surfaces)) {
                surfaces = array(surfaces);
            }
            if (!isinarray(surfaces, driving_fx::function_73e08cca(self.trace[#"surfacetype"]))) {
                surfaces[surfaces.size] = driving_fx::function_73e08cca(self.trace[#"surfacetype"]);
            }
        }
    }
    return surfaces;
}

// Namespace namespace_d916460b/namespace_d916460b
// Params 2, eflags: 0x5 linked
// Checksum 0xafa6bfae, Offset: 0x880
// Size: 0x18
function private function_74272495(*localclientnum, *owner) {
    return true;
}

