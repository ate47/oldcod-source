#using script_727042a075af51b7;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_85745671;

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x6
// Checksum 0xfabb94fd, Offset: 0x130
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_74761c506cae8855", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x5 linked
// Checksum 0xa6b0dad8, Offset: 0x178
// Size: 0x37c
function private function_70a657d8() {
    clientfield::register("scriptmover", "aizoneflag", 1, 2, "int", &function_5c69ac3b, 0, 0);
    clientfield::register("scriptmover", "aizoneflag_tu14", 1, 3, "int", &function_5c69ac3b, 0, 0);
    clientfield::register("scriptmover", "magicboxflag", 1, 3, "int", &function_7e5339f3, 0, 0);
    clientfield::register("actor", "zombie_died", 1, 1, "int", &function_46c950, 1, 0);
    clientfield::register("toplayer", "zombie_vehicle_shake", 1, 1, "counter", &function_3acc8ce4, 0, 0);
    level._effect[#"hash_2ff87d61167ea531"] = #"wz/fx8_zm_box_marker";
    level._effect[#"hash_1e5c0bbc60604949"] = #"wz/fx8_zm_box_marker_red";
    level._effect[#"hash_7fe086085cbbacac"] = #"hash_4bd4c9b0fb97f425";
    level._effect[#"hash_4048cb4967032c4a"] = #"hash_1e43d43c6586fcb5";
    level._effect[#"hash_1e35a559be3b8286"] = #"wz/fx8_magicbox_marker_fl_red";
    level._effect[#"hash_53f5cefd054ceacd"] = #"hash_6bcc939010112ea";
    level._effect[#"hash_62a055b8f2259270"] = #"hash_3235e29f5bf57d5a";
    level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect[#"hash_19f4dd97cbb87594"] = #"hash_5f376e9395e16666";
    level._effect[#"hash_4fbab83578c5a7e7"] = #"hash_5c4ef04b0752716a";
    level._effect[#"hash_538c528b09706dc8"] = #"zm_ai/fx8_zombie_soul_transfer";
    level.var_96add4a1 = #"hash_210be93b3bfae433";
    level.var_86e1b0cc = #"hash_1807f48a5193ce49";
}

// Namespace namespace_85745671/namespace_85745671
// Params 7, eflags: 0x1 linked
// Checksum 0xc0015544, Offset: 0x500
// Size: 0x12c
function function_46c950(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump === 1 && isdefined(self)) {
        spawn_pos = (self.origin[0], self.origin[1], self.origin[2] + 64);
        var_e2c1d066 = (randomint(1), randomint(1), 1);
        dynent = createdynentandlaunch(fieldname, #"p8_zm_red_floatie_duck", spawn_pos, self.angles, self.origin, var_e2c1d066);
        if (isdefined(dynent)) {
            dynent thread function_645efd58();
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 7, eflags: 0x0
// Checksum 0xaaf9c320, Offset: 0x638
// Size: 0x114
function handle_zombie_risers(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (bwastimejump) {
        localplayers = level.localplayers;
        playsound(0, #"zmb_zombie_spawn", self.origin);
        burst_fx = level._effect[#"rise_burst"];
        billow_fx = level._effect[#"rise_billow"];
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(fieldname, billow_fx, burst_fx);
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 3, eflags: 0x1 linked
// Checksum 0xb21ee9fc, Offset: 0x758
// Size: 0x104
function rise_dust_fx(clientnum, billow_fx, burst_fx) {
    self endon(#"death");
    dust_tag = "J_SpineUpper";
    if (isdefined(burst_fx)) {
        playfx(clientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
    }
    wait 0.25;
    if (isdefined(billow_fx)) {
        playfx(clientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0xf5c8e804, Offset: 0x868
// Size: 0x3c
function function_645efd58() {
    wait randomintrange(15, 25);
    if (isdefined(self)) {
        setdynentenabled(self, 0);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 7, eflags: 0x1 linked
// Checksum 0x57c7fdf7, Offset: 0x8b0
// Size: 0x2e6
function function_5c69ac3b(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump > 0) {
        if (isdefined(self.var_26a0bda1)) {
            stopfx(fieldname, self.var_26a0bda1);
            self.var_26a0bda1 = undefined;
        }
        if (bwastimejump == 1) {
            playfx(fieldname, level._effect[#"hash_4048cb4967032c4a"], self.origin);
            self.var_26a0bda1 = playfx(fieldname, level._effect[#"hash_2ff87d61167ea531"], self.origin);
        } else if (bwastimejump == 2) {
            playfx(fieldname, level._effect[#"hash_1e35a559be3b8286"], self.origin);
            self.var_26a0bda1 = playfx(fieldname, level._effect[#"hash_1e5c0bbc60604949"], self.origin);
        } else if (bwastimejump == 3) {
            self.var_26a0bda1 = playfx(fieldname, level._effect[#"hash_7fe086085cbbacac"], self.origin);
        } else if (bwastimejump == 4) {
            self.var_26a0bda1 = playfx(fieldname, level._effect[#"hash_53f5cefd054ceacd"], self.origin);
        } else if (bwastimejump == 5) {
            self.var_26a0bda1 = playfx(fieldname, level._effect[#"hash_62a055b8f2259270"], self.origin);
        }
        self playsound(fieldname, #"hash_7d0432d3e280bce1", self.origin);
        return;
    }
    if (isdefined(self.var_26a0bda1)) {
        stopfx(fieldname, self.var_26a0bda1);
        self.var_26a0bda1 = undefined;
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 7, eflags: 0x1 linked
// Checksum 0xb6531cc2, Offset: 0xba0
// Size: 0x1ca
function function_7e5339f3(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump > 0) {
        if (bwastimejump == 1) {
            util::playfxontag(fieldname, level._effect[#"hash_4fbab83578c5a7e7"], self, "tag_origin");
            self playsound(fieldname, level.var_86e1b0cc, self.origin);
            return;
        }
        if (bwastimejump == 2) {
            self.var_8ddb3e81 = util::playfxontag(fieldname, level._effect[#"hash_19f4dd97cbb87594"], self, "tag_origin");
            self playsound(fieldname, level.var_96add4a1, self.origin);
            return;
        }
        if (bwastimejump == 3) {
            if (isdefined(self.var_8ddb3e81)) {
                stopfx(fieldname, self.var_8ddb3e81);
                self.var_8ddb3e81 = undefined;
            }
            return;
        }
        if (bwastimejump == 4) {
            self.var_8ddb3e81 = util::playfxontag(fieldname, level._effect[#"hash_19f4dd97cbb87594"], self, "tag_origin");
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 7, eflags: 0x1 linked
// Checksum 0x407d4488, Offset: 0xd78
// Size: 0x8e
function function_3acc8ce4(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    id = earthquake(bwastimejump, 0.3, 1, self.origin, 1000);
}

