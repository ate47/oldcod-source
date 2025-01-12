#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_flamethrower;

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x2
// Checksum 0x4eb1cf6f, Offset: 0x180
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_flamethrower", &__init__, undefined, undefined);
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x0
// Checksum 0xc38fb976, Offset: 0x1c8
// Size: 0x22a
function __init__() {
    clientfield::register("scriptmover", "flamethrower_tornado_fx", 1, 1, "int", &flamethrower_tornado_fx, 0, 0);
    clientfield::register("actor", "flamethrower_corpse_fx", 1, 1, "int", &flamethrower_corpse_fx, 0, 0);
    clientfield::register("toplayer", "hero_flamethrower_vigor_postfx", 1, 1, "counter", &function_1a751bb4, 0, 0);
    clientfield::register("toplayer", "flamethrower_wind_blast_flash", 1, 1, "counter", &flamethrower_wind_blast_flash, 0, 0);
    clientfield::register("toplayer", "flamethrower_tornado_blast_flash", 1, 1, "counter", &flamethrower_tornado_blast_flash, 0, 0);
    level._effect[#"flamethrower_tornado"] = #"hash_2f45879d2658065c";
    level._effect[#"wind_blast_flash"] = #"hash_312fc9707e06f6f4";
    level._effect[#"hash_34db403668f7f353"] = #"hash_52e3de5257e268c2";
    level._effect[#"tornado_blast_flash"] = #"hash_5c5ffb835c39dce3";
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 7, eflags: 0x0
// Checksum 0x39d17f56, Offset: 0x400
// Size: 0x196
function flamethrower_tornado_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.n_tornado_fx)) {
            stopfx(localclientnum, self.n_tornado_fx);
        }
        self.n_tornado_fx = util::playfxontag(localclientnum, level._effect[#"flamethrower_tornado"], self, "tag_origin");
        if (!isdefined(self.var_e4222e97)) {
            self thread function_1f173065(localclientnum);
        }
        self thread function_81de305a(localclientnum);
        return;
    }
    if (isdefined(self.n_tornado_fx)) {
        stopfx(localclientnum, self.n_tornado_fx);
        self.n_tornado_fx = undefined;
    }
    if (isdefined(self.var_e4222e97)) {
        self playsound(localclientnum, #"hash_51812161eb23c96f");
        self stoploopsound(self.var_e4222e97);
        self.var_e4222e97 = undefined;
    }
    self notify(#"hash_4a10e61d27734104");
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 7, eflags: 0x0
// Checksum 0xfa706055, Offset: 0x5a0
// Size: 0x11e
function flamethrower_corpse_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_c8389239)) {
            stopfx(localclientnum, self.var_c8389239);
        }
        str_tag = "j_spineupper";
        if (!isdefined(self gettagorigin(str_tag))) {
            str_tag = "tag_origin";
        }
        self.var_c8389239 = util::playfxontag(localclientnum, level._effect[#"character_fire_death_torso"], self, str_tag);
        return;
    }
    if (isdefined(self.var_c8389239)) {
        stopfx(localclientnum, self.var_c8389239);
        self.var_c8389239 = undefined;
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0xe96eebb5, Offset: 0x6c8
// Size: 0x8a
function function_1f173065(localclientnum) {
    self endon(#"death", #"hash_4a10e61d27734104");
    wait 0.1;
    self playsound(localclientnum, #"hash_2e4b3d95b5a51afa");
    self.var_e4222e97 = self playloopsound(#"hash_468cabb7402e170e");
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 7, eflags: 0x0
// Checksum 0x143edef, Offset: 0x760
// Size: 0x15c
function function_81de305a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death", #"hash_4a10e61d27734104");
    while (true) {
        a_e_players = getlocalplayers();
        foreach (e_player in a_e_players) {
            if (!e_player util::function_162f7df2(localclientnum)) {
                continue;
            }
            if (distance(e_player.origin, self.origin) <= 128) {
                e_player playrumbleonentity(localclientnum, "damage_heavy");
            }
        }
        wait 0.25;
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 7, eflags: 0x4
// Checksum 0xd5ac48ec, Offset: 0x8c8
// Size: 0x64
function private function_1a751bb4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self thread postfx::playpostfxbundle(#"hash_28d2c6df1a547302");
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 7, eflags: 0x0
// Checksum 0x682b64ab, Offset: 0x938
// Size: 0xcc
function flamethrower_wind_blast_flash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        playviewmodelfx(localclientnum, level._effect[#"wind_blast_flash"], "tag_flash");
        return;
    }
    util::playfxontag(localclientnum, level._effect[#"hash_34db403668f7f353"], self, "tag_flash");
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 7, eflags: 0x0
// Checksum 0x907780be, Offset: 0xa10
// Size: 0xcc
function flamethrower_tornado_blast_flash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        playviewmodelfx(localclientnum, level._effect[#"tornado_blast_flash"], "tag_flash");
        return;
    }
    util::playfxontag(localclientnum, level._effect[#"tornado_blast_flash"], self, "tag_flash");
}

