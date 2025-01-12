#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace zm_powerups;

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xef6f0ce9, Offset: 0x1f8
// Size: 0x224
function init() {
    if (!isdefined(level.zombie_powerups)) {
        level.zombie_powerups = [];
    }
    add_zombie_powerup("insta_kill_ug", "powerup_instant_kill_ug", 1);
    level._effect[#"powerup_on_caution"] = #"zombie/fx_powerup_on_caution_zmb";
    level._effect[#"hash_216d76ce6f19d51c"] = #"hash_2e09347c65fb17c1";
    level._effect[#"powerup_grabbed_caution"] = #"zombie/fx_powerup_grab_caution_zmb";
    if (is_true(level.using_zombie_powerups)) {
        level._effect[#"powerup_on_red"] = #"zombie/fx_powerup_on_red_zmb";
        level._effect[#"hash_68ab4922f64db792"] = #"hash_62b15f4f400643ab";
        level._effect[#"powerup_grabbed_red"] = #"zombie/fx_powerup_grab_red_zmb";
    }
    clientfield::register("scriptmover", "powerup_fx", 1, 3, "int", &powerup_fx_callback, 0, 0);
    clientfield::register("scriptmover", "powerup_intro_fx", 1, 3, "int", &function_618b5680, 0, 0);
    clientfield::register("scriptmover", "powerup_grabbed_fx", 1, 3, "int", &function_9f7265fd, 0, 0);
}

// Namespace zm_powerups/zm_powerups
// Params 3, eflags: 0x1 linked
// Checksum 0x10f5f137, Offset: 0x428
// Size: 0x2fa
function add_zombie_powerup(powerup_name, client_field_name, clientfield_version = 1) {
    if (isdefined(level.zombie_include_powerups) && !isdefined(level.zombie_include_powerups[powerup_name])) {
        return;
    }
    switch (powerup_name) {
    case #"full_ammo":
        var_f530d747 = "zmPowerupMaxAmmo";
        break;
    case #"fire_sale":
        var_f530d747 = "zmPowerupFireSale";
        break;
    case #"bonus_points_player_shared":
    case #"bonus_points_player":
    case #"bonus_points_team":
        var_f530d747 = "zmPowerupChaosPoints";
        break;
    case #"free_perk":
        var_f530d747 = "zmPowerupFreePerk";
        break;
    case #"nuke":
        var_f530d747 = "zmPowerupNuke";
        break;
    case #"hero_weapon_power":
        var_f530d747 = "zmPowerupSpecialWeapon";
        break;
    case #"insta_kill":
        var_f530d747 = "zmPowerupInstakill";
        break;
    case #"double_points":
        var_f530d747 = "zmPowerupDouble";
        break;
    case #"carpenter":
        var_f530d747 = "zmPowerupCarpenter";
        break;
    default:
        var_f530d747 = "";
        break;
    }
    if (var_f530d747 != "" && !is_true(getgametypesetting(var_f530d747))) {
        return;
    }
    struct = spawnstruct();
    struct.powerup_name = powerup_name;
    level.zombie_powerups[powerup_name] = struct;
    if (isdefined(client_field_name)) {
        var_4e6e65fa = "hudItems.zmPowerUps." + client_field_name + ".state";
        clientfield::register_clientuimodel(var_4e6e65fa, #"hash_6bba1b88c856cfdf", [hash(client_field_name), #"state"], clientfield_version, 2, "int", &powerup_state_callback, 0, 1);
        struct.client_field_name = var_4e6e65fa;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x5a1f5a70, Offset: 0x730
// Size: 0x3c
function include_zombie_powerup(powerup_name) {
    if (!isdefined(level.zombie_include_powerups)) {
        level.zombie_include_powerups = [];
    }
    level.zombie_include_powerups[powerup_name] = 1;
}

// Namespace zm_powerups/zm_powerups
// Params 7, eflags: 0x1 linked
// Checksum 0x4e6ff510, Offset: 0x778
// Size: 0x76
function powerup_state_callback(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    self notify(#"powerup", {#powerup:bwastimejump, #state:fieldname});
}

// Namespace zm_powerups/zm_powerups
// Params 7, eflags: 0x1 linked
// Checksum 0x96c96abe, Offset: 0x7f8
// Size: 0x14c
function powerup_fx_callback(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_d6070ac5(fieldname);
    switch (bwastimejump) {
    case 1:
        str_fx = #"hash_5e119c0907721bc6";
        break;
    case 2:
        str_fx = #"hash_159f72c30fdda87b";
        break;
    case 3:
        str_fx = level._effect[#"powerup_on_red"];
        break;
    case 4:
        str_fx = level._effect[#"powerup_on_caution"];
        break;
    default:
        return;
    }
    self play_powerup_fx(fieldname, str_fx);
}

// Namespace zm_powerups/zm_powerups
// Params 7, eflags: 0x1 linked
// Checksum 0x463ceb41, Offset: 0x950
// Size: 0x144
function function_618b5680(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_d6070ac5(fieldname);
    switch (bwastimejump) {
    case 1:
        str_fx = #"hash_511f70cb60957320";
        break;
    case 2:
        str_fx = #"hash_394b4cd00458a48b";
        break;
    case 3:
        str_fx = level._effect[#"hash_68ab4922f64db792"];
        break;
    case 4:
        str_fx = level._effect[#"hash_216d76ce6f19d51c"];
    default:
        return;
    }
    self play_powerup_fx(fieldname, str_fx, 1);
}

// Namespace zm_powerups/zm_powerups
// Params 7, eflags: 0x1 linked
// Checksum 0xed84fbc2, Offset: 0xaa0
// Size: 0x134
function function_9f7265fd(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 1:
        str_fx = #"hash_77e0a146edca56f1";
        break;
    case 2:
        str_fx = #"hash_51d73f69b757027e";
        break;
    case 3:
        str_fx = level._effect[#"powerup_grabbed_red"];
        break;
    case 4:
        str_fx = level._effect[#"powerup_grabbed_caution"];
        break;
    default:
        return;
    }
    playfx(fieldname, str_fx, self.origin);
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x5 linked
// Checksum 0x16f7181e, Offset: 0xbe0
// Size: 0x76
function private function_d6070ac5(localclientnum) {
    if (isdefined(self.n_powerup_fx)) {
        stopfx(localclientnum, self.n_powerup_fx);
        self.n_powerup_fx = undefined;
    }
    if (isdefined(self.var_71e06c56)) {
        self stoploopsound(self.var_71e06c56);
        self.var_71e06c56 = undefined;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 3, eflags: 0x5 linked
// Checksum 0x4c4a99b8, Offset: 0xc60
// Size: 0x14a
function private play_powerup_fx(localclientnum, str_fx, var_6df65756 = 0) {
    if (self.model !== #"tag_origin") {
        forcestreamxmodel(self.model);
        util::delay(1, undefined, &stopforcestreamingxmodel, self.model);
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (var_6df65756 && !isdefined(self.var_71e06c56)) {
        self playsound(localclientnum, #"hash_3a25dc0ad86a722c");
        self.var_71e06c56 = self playloopsound(#"hash_3119fa236ffcf847");
    }
    self.n_powerup_fx = util::playfxontag(localclientnum, str_fx, self, "tag_origin");
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xa4282e8e, Offset: 0xdb8
// Size: 0x1c
function function_cc33adc8() {
    return util::get_game_type() != "zcleansed";
}

