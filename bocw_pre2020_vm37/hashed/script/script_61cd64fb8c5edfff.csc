#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace electroball_grenade;

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x6
// Checksum 0xdb6662da, Offset: 0x260
// Size: 0x34
function private autoexec __init__system__() {
    system::register("electroball_grenade", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace electroball_grenade/electroball_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0x1476fcbb, Offset: 0x2a0
// Size: 0x1dc
function function_70a657d8() {
    clientfield::register("toplayer", "electroball_tazered", 1, 1, "int", undefined, 0, 0);
    clientfield::register("allplayers", "electroball_shock", 1, 1, "int", &function_7ec61d7a, 0, 0);
    clientfield::register("missile", "electroball_stop_trail", 1, 1, "int", &function_7b605b7b, 0, 0);
    clientfield::register("missile", "electroball_play_landed_fx", 1, 1, "int", &electroball_play_landed_fx, 0, 0);
    level._effect[#"hash_782d8b3c7cf0155a"] = "zm_ai/fx9_mech_wpn_115_blob";
    level._effect[#"hash_20d1b299e564ead7"] = "zm_ai/fx9_mech_wpn_115_bul_trail";
    level._effect[#"hash_6eac1e89faaa9560"] = "zm_ai/fx9_mech_wpn_115_canister";
    level._effect[#"hash_3a6575aae8a7ccd4"] = "weapon/fx_prox_grenade_impact_player_spwner";
    level._effect[#"hash_58bd536e46d7c711"] = "weapon/fx_prox_grenade_exp";
    callback::add_weapon_type("electroball_grenade", &proximity_spawned);
}

// Namespace electroball_grenade/electroball_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xe758ed73, Offset: 0x488
// Size: 0xc2
function proximity_spawned(localclientnum) {
    self util::waittill_dobj(localclientnum);
    if (self isgrenadedud()) {
        return;
    }
    self.var_78b154ef = util::playfxontag(localclientnum, level._effect[#"hash_20d1b299e564ead7"], self, "j_grenade_front");
    self.var_de70e6e2 = util::playfxontag(localclientnum, level._effect[#"hash_6eac1e89faaa9560"], self, "j_grenade_back");
}

// Namespace electroball_grenade/electroball_grenade
// Params 7, eflags: 0x1 linked
// Checksum 0xea37adb7, Offset: 0x558
// Size: 0x7e
function function_7ec61d7a(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    fx = util::playfxontag(bwastimejump, level._effect[#"hash_3a6575aae8a7ccd4"], self, "J_SpineUpper");
}

// Namespace electroball_grenade/electroball_grenade
// Params 7, eflags: 0x1 linked
// Checksum 0x23bb024a, Offset: 0x5e0
// Size: 0x134
function function_7b605b7b(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.var_542ac835)) {
        level.var_542ac835 = [];
    }
    array::add(level.var_542ac835, self);
    self callback::on_shutdown(&function_76787bb);
    if (isdefined(self.var_78b154ef)) {
        stopfx(bwastimejump, self.var_78b154ef);
    }
    if (isdefined(self.var_87f9f380)) {
        stopfx(bwastimejump, self.var_87f9f380);
    }
    if (isdefined(self.var_d026ca4e)) {
        stopfx(bwastimejump, self.var_d026ca4e);
    }
    if (isdefined(self.var_de70e6e2)) {
        stopfx(bwastimejump, self.var_de70e6e2);
    }
}

// Namespace electroball_grenade/electroball_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x6efb1041, Offset: 0x720
// Size: 0x2c
function function_76787bb(*params) {
    arrayremovevalue(level.var_542ac835, undefined);
}

// Namespace electroball_grenade/electroball_grenade
// Params 7, eflags: 0x1 linked
// Checksum 0x47d207da, Offset: 0x758
// Size: 0xbe
function electroball_play_landed_fx(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.var_ac6e3a4d = util::playfxontag(bwastimejump, level._effect[#"hash_782d8b3c7cf0155a"], self, "tag_origin");
    dynent = createdynentandlaunch(bwastimejump, "p7_zm_ctl_115_grenade_broken", self.origin, self.angles, self.origin, (0, 0, 0));
}

