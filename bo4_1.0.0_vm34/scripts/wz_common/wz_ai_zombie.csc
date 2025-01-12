#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_ai_zombie;

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x2
// Checksum 0x3c095914, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_ai_zombie", &__init__, undefined, undefined);
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 0, eflags: 0x0
// Checksum 0x3fcf4efe, Offset: 0x128
// Size: 0x122
function __init__() {
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 1, 1);
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 0);
    level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect[#"eye_glow"] = #"zm_ai/fx8_zombie_eye_glow_orange";
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 7, eflags: 0x0
// Checksum 0x4839023e, Offset: 0x258
// Size: 0xf6
function handle_zombie_risers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval) {
        localplayers = level.localplayers;
        burst_fx = level._effect[#"rise_burst"];
        billow_fx = level._effect[#"rise_billow"];
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(localclientnum, billow_fx, burst_fx);
        }
    }
}

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 3, eflags: 0x0
// Checksum 0x9e763232, Offset: 0x358
// Size: 0x10c
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

// Namespace wz_ai_zombie/wz_ai_zombie
// Params 7, eflags: 0x0
// Checksum 0x81ada027, Offset: 0x470
// Size: 0x134
function zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_cb2e3984)) {
        self stoprenderoverridebundle(self.var_cb2e3984, "j_head");
    }
    if (isdefined(self.var_e5be23ac)) {
        stopfx(localclientnum, self.var_e5be23ac);
        self.var_e5be23ac = undefined;
    }
    if (newval) {
        self.var_cb2e3984 = "rob_zm_eyes_red";
        var_c8e0e4d8 = "eye_glow";
        self playrenderoverridebundle(self.var_cb2e3984, "j_head");
        self.var_e5be23ac = util::playfxontag(localclientnum, level._effect[var_c8e0e4d8], self, "tag_eye");
        self enableonradar();
    }
}

