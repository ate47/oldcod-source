#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_zombie_blood;

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 0, eflags: 0x2
// Checksum 0x49a55c14, Offset: 0x160
// Size: 0x34
function autoexec __init__system__() {
    system::register("zm_powerup_zombie_blood", &__init__, undefined, undefined);
}

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 0, eflags: 0x0
// Checksum 0x77717070, Offset: 0x1a0
// Size: 0x134
function __init__() {
    clientfield::register("allplayers", "" + #"player_zombie_blood_fx", 1, 1, "int", &toggle_player_zombie_blood_fx, 0, 1);
    level._effect[#"zombie_blood"] = "player/fx8_plyr_pstfx_katana_rush_loop";
    level._effect[#"zombie_blood_1st"] = "player/fx8_plyr_pstfx_katana_rush_loop";
    level._effect[#"zombie_blood_3p"] = "maps/zm_escape/fx8_pwr_up_blood";
    level._effect[#"hash_508127d9fa072319"] = "maps/zm_escape/fx8_pwr_up_blood_trail";
    zm_powerups::include_zombie_powerup("zombie_blood");
    zm_powerups::add_zombie_powerup("zombie_blood", "powerup_zombie_blood");
}

// Namespace zm_powerup_zombie_blood/zm_powerup_zombie_blood
// Params 7, eflags: 0x0
// Checksum 0xaef0b6bd, Offset: 0x2e0
// Size: 0x374
function toggle_player_zombie_blood_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (function_9a47ed7f(localclientnum)) {
        return;
    }
    if (!isdefined(self.var_bf46ff9a)) {
        self.var_bf46ff9a = [];
    }
    if (!isdefined(self.var_bf46ff9a[localclientnum])) {
        self.var_bf46ff9a[localclientnum] = [];
    }
    if (self.var_bf46ff9a[localclientnum].size) {
        self postfx::stoppostfxbundle(#"hash_4c9c4b6464bd9a1c");
        foreach (n_fx_id in self.var_bf46ff9a[localclientnum]) {
            stopfx(localclientnum, n_fx_id);
            n_fx_id = undefined;
        }
        if (newval == 0) {
            self.var_bf46ff9a[localclientnum] = undefined;
        }
    }
    if (newval == 1) {
        if (self getlocalclientnumber() === localclientnum) {
            self thread postfx::playpostfxbundle(#"hash_4c9c4b6464bd9a1c");
            self.var_bf46ff9a[localclientnum][self.var_bf46ff9a[localclientnum].size] = playfxoncamera(localclientnum, level._effect[#"zombie_blood_1st"]);
        } else {
            self.var_bf46ff9a[localclientnum][self.var_bf46ff9a[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"zombie_blood_3p"], self, "j_eyeball_le");
            self.var_bf46ff9a[localclientnum][self.var_bf46ff9a[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_508127d9fa072319"], self, "j_eyeball_le");
        }
        if (!isdefined(self.var_b912af17)) {
            self playsound(localclientnum, #"hash_7a3f11d83a3345c7");
            self.var_b912af17 = self playloopsound(#"hash_e994a747679fc33");
        }
        return;
    }
    if (isdefined(self.var_b912af17)) {
        self playsound(localclientnum, #"hash_5460a8de45586842");
        self stoploopsound(self.var_b912af17);
    }
}

