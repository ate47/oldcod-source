#using script_11c9779550732489;
#using script_3c345dd878d144b7;
#using script_43de70169069c6ab;
#using script_4f8f41168a7c3ea8;
#using script_5db30ea2f37108d;
#using script_675455e5e6c0c5ad;
#using script_711bbbba637da80;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\powerup\zm_powerup_carpenter;
#using scripts\zm\powerup\zm_powerup_double_points;
#using scripts\zm\powerup\zm_powerup_fire_sale;
#using scripts\zm\powerup\zm_powerup_full_ammo;
#using scripts\zm\powerup\zm_powerup_insta_kill;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm\powerup\zm_powerup_zombie_blood;
#using scripts\zm\weapons\zm_weap_blundergat;
#using scripts\zm\weapons\zm_weap_cymbal_monkey;
#using scripts\zm\weapons\zm_weap_flamethrower;
#using scripts\zm\weapons\zm_weap_gravityspikes;
#using scripts\zm\weapons\zm_weap_katana;
#using scripts\zm\weapons\zm_weap_minigun;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm\weapons\zm_weap_spectral_shield;
#using scripts\zm\zm_escape_catwalk_event;
#using scripts\zm\zm_escape_fx;
#using scripts\zm\zm_escape_pap_quest;
#using scripts\zm\zm_escape_paschal;
#using scripts\zm\zm_escape_traps;
#using scripts\zm\zm_escape_util;
#using scripts\zm\zm_escape_weap_quest;
#using scripts\zm_common\load;
#using scripts\zm_common\util\ai_brutus_util;
#using scripts\zm_common\util\ai_dog_util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;

#namespace zm_escape;

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x2
// Checksum 0x87e0a58d, Offset: 0x2f0
// Size: 0x22
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace zm_escape/level_init
// Params 1, eflags: 0x40
// Checksum 0x59ea0c44, Offset: 0x320
// Size: 0x55c
function event_handler[level_init] main(eventstruct) {
    clientfield::register("clientuimodel", "" + #"player_lives", 1, 2, "int", undefined, 0, 0);
    clientfield::register("toplayer", "" + #"rumble_gondola", 1, 1, "int", &rumble_gondola, 0, 0);
    clientfield::register("toplayer", "" + #"hash_51b0de5e2b184c28", 1, 1, "int", &function_3db4c1ff, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_4be2ce4248d80d22", 1, 1, "int", &function_c68eeda0, 0, 0);
    clientfield::register("world", "" + #"hash_24deaa9795e06d41", 1, 1, "int", &function_63b929c5, 0, 0);
    clientfield::register("world", "" + #"hash_4a8a7b58bf6cd5d8", 1, 1, "int", &function_d8d549e6, 0, 0);
    clientfield::register("world", "" + #"hash_cd028842e18845e", 1, 1, "counter", &function_546ef7cc, 0, 0);
    zm_escape_catwalk_event::init_clientfields();
    namespace_a9db3299::init_clientfields();
    zm_escape_util::init_clientfields();
    paschal::init();
    namespace_d8b81d0b::init_clientfields();
    level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
    level._effect[#"hash_4d2e5c87bde94856"] = #"hash_4948d849a833ddd5";
    zm_escape_catwalk_event::init_fx();
    level._uses_default_wallbuy_fx = 1;
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    include_weapons();
    level._effect[#"hash_2bba72fdcc5508b5"] = #"hash_2ac7ec38d265c496";
    level._effect[#"chest_light_closed"] = #"hash_5b118cefec864e37";
    level._effect[#"hash_9d26763cbe16490"] = #"hash_5a9159bef624d260";
    level._effect[#"magic_box_leave"] = #"hash_2b008afec3e70add";
    level._effect[#"switch_sparks"] = #"hash_26f37488feec03c3";
    level.var_affe400c = "pstfx_zm_hellhole";
    namespace_a9db3299::init();
    pap_quest::init();
    load::main();
    exploder::exploder("lgt_vending_mulekick_on");
    util::waitforclient(0);
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0xeba4437, Offset: 0x888
// Size: 0x3c
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table(#"gamedata/weapons/zm/zm_escape_weapons.csv", 1);
    zm_wallbuy::function_9e8dccbe();
}

// Namespace zm_escape/zm_escape
// Params 7, eflags: 0x0
// Checksum 0x1d061cc0, Offset: 0x8d0
// Size: 0x134
function rumble_gondola(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    self endon(#"disconnect");
    if (newval == 1) {
        self endon(#"hash_6d7afe7c92e095d8");
        while (true) {
            if (isinarray(getlocalplayers(), self)) {
                self playrumbleonentity(localclientnum, "reload_small");
            }
            wait 0.25;
        }
        return;
    }
    self notify(#"hash_6d7afe7c92e095d8");
    if (isinarray(getlocalplayers(), self)) {
        self playrumbleonentity(localclientnum, "damage_heavy");
    }
}

// Namespace zm_escape/zm_escape
// Params 7, eflags: 0x0
// Checksum 0x351f5f4a, Offset: 0xa10
// Size: 0xce
function function_3db4c1ff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    self endon(#"disconnect");
    if (newval == 1) {
        self endon(#"hash_2e4f137d472e68e9");
        while (true) {
            self playrumbleonentity(localclientnum, "reload_small");
            wait 0.25;
        }
        return;
    }
    self notify(#"hash_2e4f137d472e68e9");
}

// Namespace zm_escape/zm_escape
// Params 7, eflags: 0x0
// Checksum 0x530cd632, Offset: 0xae8
// Size: 0x84
function function_63b929c5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    s_catwalk_lava_exp = struct::get("s_catwalk_lava_exp");
    playrumbleonposition(localclientnum, "zm_escape_warden_catwalk_rumble", s_catwalk_lava_exp.origin);
}

// Namespace zm_escape/zm_escape
// Params 7, eflags: 0x0
// Checksum 0x8434debd, Offset: 0xb78
// Size: 0xe4
function function_546ef7cc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_74d7234d = struct::get("s_break_large_metal");
    playrumbleonposition(localclientnum, "zm_escape_metal_rumble1", var_74d7234d.origin);
    wait 3;
    playrumbleonposition(localclientnum, "zm_escape_metal_rumble2", var_74d7234d.origin);
    wait 5;
    playrumbleonposition(localclientnum, "zm_escape_metal_rumble3", var_74d7234d.origin);
}

// Namespace zm_escape/zm_escape
// Params 7, eflags: 0x0
// Checksum 0x8e637dc2, Offset: 0xc68
// Size: 0x78
function function_d8d549e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        level thread function_80b939c7(localclientnum);
        return;
    }
    level notify(#"hash_235b9fcd660e7b1d");
}

// Namespace zm_escape/zm_escape
// Params 1, eflags: 0x4
// Checksum 0x3aa162b5, Offset: 0xce8
// Size: 0xa0
function private function_80b939c7(localclientnum) {
    level endon(#"hash_235b9fcd660e7b1d");
    s_sound_origin = struct::get("s_b_64_sound");
    while (true) {
        playsound(localclientnum, #"hash_6fb66d7d2c8a65af", s_sound_origin.origin);
        wait randomfloatrange(3, 5);
    }
}

// Namespace zm_escape/zm_escape
// Params 7, eflags: 0x0
// Checksum 0x6a0e09b2, Offset: 0xd90
// Size: 0x13a
function function_c68eeda0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
        self.n_fx_id = undefined;
    }
    if (isdefined(self.var_1bfe429b)) {
        self stoploopsound(self.var_1bfe429b);
        self.var_1bfe429b = undefined;
    }
    if (newval) {
        self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"switch_sparks"], self, "tag_origin");
        playsound(localclientnum, #"hash_3281ee130e7c69e", self.origin);
        self.var_1bfe429b = self playloopsound(#"hash_27ae537b191e913d");
    }
}

