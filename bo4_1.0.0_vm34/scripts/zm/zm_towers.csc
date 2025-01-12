#using script_3f48538738283547;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\ai\zm_ai_elephant;
#using scripts\zm\powerup\zm_powerup_bonus_points_team;
#using scripts\zm\powerup\zm_powerup_carpenter;
#using scripts\zm\powerup\zm_powerup_double_points;
#using scripts\zm\powerup\zm_powerup_fire_sale;
#using scripts\zm\powerup\zm_powerup_free_perk;
#using scripts\zm\powerup\zm_powerup_full_ammo;
#using scripts\zm\powerup\zm_powerup_hero_weapon_power;
#using scripts\zm\powerup\zm_powerup_insta_kill;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm\zm_towers_gamemodes;
#using scripts\zm_common\load;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;

#namespace zm_towers;

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x2
// Checksum 0x74051b68, Offset: 0xa00
// Size: 0x22
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace zm_towers/level_init
// Params 1, eflags: 0x40
// Checksum 0x43b4f6c7, Offset: 0xa30
// Size: 0x2494
function event_handler[level_init] main(eventstruct) {
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int", undefined, 0, 0);
    clientfield::register("scriptmover", "entry_gate_dust", 1, 1, "int", &function_374b5948, 0, 0);
    clientfield::register("scriptmover", "zombie_head_pickup_glow", 1, 1, "int", &function_4f225d0d, 0, 0);
    clientfield::register("scriptmover", "blue_glow", 1, 1, "int", &toggle_blue_glow, 0, 0);
    clientfield::register("scriptmover", "" + #"chaos_ball", 1, 1, "int", &toggle_chaos_ball, 0, 0);
    clientfield::register("scriptmover", "sentinel_artifact_fx_mist", 1, 1, "int", &toggle_sentinel_artifact_mist_fx, 0, 0);
    clientfield::register("world", "special_round_smoke", 1, 1, "int", &function_55d9ef8a, 0, 0);
    clientfield::register("toplayer", "special_round_camera", 1, 2, "int", &special_round_camera_fx, 0, 0);
    clientfield::register("world", "brazier_fire_blue", 1, 2, "int", &function_fedaee77, 0, 0);
    clientfield::register("world", "brazier_fire_green", 1, 2, "int", &function_fb973422, 0, 0);
    clientfield::register("world", "brazier_fire_purple", 1, 2, "int", &function_3f5f2af9, 0, 0);
    clientfield::register("world", "brazier_fire_red", 1, 2, "int", &function_127f889e, 0, 0);
    clientfield::register("scriptmover", "head_fire_blue", 1, 1, "int", &function_a8405b54, 0, 0);
    clientfield::register("scriptmover", "head_fire_green", 1, 1, "int", &function_e8a48c3, 0, 0);
    clientfield::register("scriptmover", "head_fire_purple", 1, 1, "int", &function_390cb9ea, 0, 0);
    clientfield::register("scriptmover", "head_fire_red", 1, 1, "int", &function_8476b253, 0, 0);
    clientfield::register("scriptmover", "energy_soul", 1, 1, "int", &function_1d6b0f30, 0, 0);
    clientfield::register("scriptmover", "energy_soul_target", 1, 1, "int", &function_8077f496, 0, 0);
    clientfield::register("toplayer", "" + #"hash_2bbcb9e09bd7bb26", 1, 1, "counter", &function_6e01a618, 0, 0);
    clientfield::register("actor", "acid_trap_death_fx", 1, 1, "int", &acid_trap_death_fx, 0, 0);
    clientfield::register("scriptmover", "trap_switch_green", 1, 1, "int", &function_5bf3db3a, 0, 0);
    clientfield::register("scriptmover", "trap_switch_red", 1, 1, "int", &function_7fa1f79d, 0, 0);
    clientfield::register("scriptmover", "trap_switch_smoke", 1, 1, "int", &function_a7b2b976, 0, 0);
    clientfield::register("toplayer", "acid_trap_postfx", 1, 1, "int", &acid_trap_postfx, 0, 0);
    clientfield::register("toplayer", "" + #"pickup_dung", 1, 1, "int", &pickup_dung, 0, 0);
    clientfield::register("world", "crowd_react", 1, 2, "int", &crowd_react, 0, 1);
    clientfield::register("world", "crowd_react_boss", 1, 1, "int", &crowd_react_boss, 0, 1);
    clientfield::register("toplayer", "snd_crowd_react", 1, 4, "int", &snd_crowd_react, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_42cc4bf5e47478c5", 1, 1, "int", &function_b8aeb289, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_3b746cf6eec416b2", 1, 1, "int", &function_3eb2e808, 0, 0);
    clientfield::register("world", "" + #"hash_584e8f7433246444", 1, 1, "int", &function_b847d8ea, 0, 0);
    clientfield::register("world", "" + #"hash_418c1c843450232b", 1, 1, "int", &function_b90eb0fb, 0, 0);
    clientfield::register("world", "" + #"hash_4d547bf36c6cb2d8", 1, 1, "int", &function_5aeeefa2, 0, 0);
    clientfield::register("world", "" + #"hash_38ba3ad0902aa355", 1, 1, "int", &function_93d237bd, 0, 0);
    clientfield::register("world", "" + #"hash_24d7233bb17e6558", 1, 1, "int", &function_d897406e, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_2c6f04d08665dbda", 1, 1, "int", &function_d8d66c54, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_2a332df32456c86f", 1, 1, "int", &function_6d365cb, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_48ad84f9cf6a33f0", 1, 1, "counter", &function_585decea, 0, 0);
    clientfield::register("zbarrier", "" + #"hash_3974bea828fbf7f7", 1, 1, "int", &function_a30a76b, 0, 0);
    clientfield::register("zbarrier", "" + #"hash_1add6939914df65a", 1, 1, "int", &function_a73e61c8, 0, 0);
    clientfield::register("zbarrier", "" + #"hash_5dc6f97e5850e1d1", 1, 1, "int", &function_78be2a01, 0, 0);
    clientfield::register("toplayer", "" + #"ww_quest_earthquake", 1, 1, "counter", &ww_quest_earthquake, 0, 0);
    clientfield::register("world", "" + #"hash_3c58464f16d8a1be", 1, 1, "int", &function_39829164, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_6ff3eb2dd0078a51", 1, 1, "counter", &function_1872b289, 0, 0);
    clientfield::register("world", "" + #"hash_445060dbbf244b04", 1, 1, "int", &function_bd342a92, 0, 0);
    clientfield::register("world", "" + #"hash_a2fb645044ed12e", 1, 1, "int", &function_9e33ae0c, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_3f79f6da0222ebc2", 1, 1, "int", &function_91d020c8, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_c382c02584ba249", 1, 1, "int", &function_cbcec96d, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_273efcc293063e5e", 1, 1, "int", &function_8a04dec, 0, 0);
    clientfield::register("scriptmover", "" + #"fertilizer_smell", 1, 1, "int", &fertilizer_smell, 0, 0);
    clientfield::register("world", "" + #"hash_5a3e1454226ef7a4", 1, 1, "int", &function_3c8dbb3e, 0, 0);
    clientfield::register("world", "" + #"hash_73088ea3053b96f1", 1, 1, "int", &function_b8870a25, 0, 0);
    clientfield::register("actor", "" + #"hash_233e31d0c2b47b1b", 1, 1, "int", &function_4326fc58, 0, 0);
    clientfield::register("actor", "" + #"hash_12dfb8249f8212d2", 1, 1, "int", &function_b0005be4, 0, 0);
    clientfield::register("actor", "" + #"hash_17e3041649954b9f", 1, 1, "int", &function_642e66db, 0, 0);
    clientfield::register("scriptmover", "ra_eyes_beam_fire", 1, 1, "int", &ra_eyes_beam_fire, 0, 0);
    clientfield::register("scriptmover", "ra_rooftop_eyes_beam_fire", 1, 1, "int", &ra_rooftop_eyes_beam_fire, 0, 0);
    clientfield::register("world", "" + #"hash_57c08e5f4792690c", 1, 1, "int", &function_8e459f7e, 0, 0);
    clientfield::register("world", "" + #"hash_440f23773f551a48", 1, 1, "int", &function_7e98b76a, 0, 0);
    clientfield::register("world", "" + #"hash_4e5e2b411c997804", 1, 1, "int", &function_ba016e82, 0, 0);
    clientfield::register("toplayer", "" + #"maelstrom_initiate", 1, 1, "counter", &maelstrom_initiate, 0, 0);
    clientfield::register("world", "" + #"maelstrom_initiate_fx", 1, 1, "int", &maelstrom_initiate_fx, 0, 0);
    clientfield::register("actor", "" + #"hash_451db92b932d90bf", 1, 1, "int", &function_2763cea3, 0, 0);
    clientfield::register("scriptmover", "" + #"maelstrom_conduct", 1, 1, "int", &maelstrom_conduct, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_1814d4cc1867739c", 1, 1, "int", &function_9c6d38fa, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_314d3a2e542805c0", 1, 1, "int", &function_f50048da, 0, 0);
    clientfield::register("scriptmover", "" + #"maelstrom_discharge", 1, 1, "counter", &maelstrom_discharge, 0, 0);
    clientfield::register("actor", "" + #"maelstrom_death", 1, 1, "counter", &maelstrom_death, 0, 0);
    clientfield::register("toplayer", "" + #"maelstrom_storm", 1, 1, "int", &maelstrom_storm, 0, 0);
    clientfield::register("toplayer", "" + #"hash_182c03ff2a21c07c", 1, 1, "counter", &function_9c70916e, 0, 0);
    clientfield::register("toplayer", "" + #"maelstrom_ending", 1, 1, "int", &maelstrom_ending, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_23ba00d2f804acc2", 1, 1, "int", &function_7a09cd08, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_2407f687f7d24a83", 1, 1, "int", &function_50a807db, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_5afda864f8b64f5c", 1, 1, "int", &function_48080d32, 0, 0);
    clientfield::register("world", "" + #"hash_2383fd01b106ced8", 1, 1, "int", &function_6d205818, 0, 0);
    level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
    level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
    level._effect[#"hash_73172b799c18404e"] = #"hash_7d94f7b4389cad84";
    level._effect[#"entry_gate_dust"] = #"hash_43b2eaf6037de947";
    level._effect[#"special_round_smoke"] = #"hash_7f90f442be248933";
    level._effect[#"hash_2a49b738100ad198"] = #"hash_573f4333a69a2e97";
    level._effect[#"special_round_camera_start"] = #"hash_5e456969dcb6d449";
    level._effect[#"special_round_camera_persist"] = #"hash_30a51086d1de2e56";
    level._effect[#"trap_switch_green"] = #"hash_24ce0898c3432283";
    level._effect[#"trap_switch_red"] = #"hash_1d6280fe28ef047";
    level._effect[#"trap_switch_smoke"] = #"hash_22722c91ebbd77f9";
    level._effect[#"hash_42cc4bf5e47478c5"] = #"hash_387c78244f5f45e5";
    level._effect[#"hash_3b746cf6eec416b2"] = #"hash_396a3bd29f816da1";
    level._effect[#"hash_36535f89ec2488d7"] = #"hash_5efc6976bcba1957";
    level._effect[#"hash_584e8f7433246444"] = #"hash_682f944518a1171c";
    level._effect[#"ww_quest_scorpio"] = #"hash_2b4f2f30d115f02a";
    level._effect[#"hash_48ad84f9cf6a33f0"] = #"hash_232d6ea0cf34968b";
    level._effect[#"hash_3974bea828fbf7f7"] = #"hash_6fd3d30a984a4585";
    level._effect[#"hash_1add6939914df65a"] = #"hash_24d0d45080034da";
    level._effect[#"hash_5dc6f97e5850e1d1"] = #"hash_14d7c3ad478543a";
    level._effect[#"brazier_fire_blue"] = #"hash_6d3f50f00db41676";
    level._effect[#"brazier_fire_green"] = #"hash_1839d27856f4aed9";
    level._effect[#"brazier_fire_red"] = #"hash_4d95d8d2f3b07ca5";
    level._effect[#"brazier_fire_purple"] = #"hash_231c5e173b446f0c";
    level._effect[#"hash_169c8ab62603115c"] = #"hash_2a4dc3aacf70bb96";
    level._effect[#"head_fire_blue"] = #"hash_5089724c9ec9d4f7";
    level._effect[#"head_fire_green"] = #"hash_29adecede9b00a2";
    level._effect[#"head_fire_purple"] = #"hash_19cfaef54c89e021";
    level._effect[#"head_fire_red"] = #"hash_46234b48f3c3d22";
    level._effect[#"energy_soul"] = #"hash_24eb30a2d07ae5a9";
    level._effect[#"energy_soul_target"] = #"hash_6f5f4eb9267613e3";
    level._effect[#"acid_death"] = #"hash_78c487ac760f594c";
    level._effect[#"hash_233e31d0c2b47b1b"] = #"hash_4d11f0ab46451330";
    level._effect[#"chaos_ball"] = #"hash_2fa6e69cbbe0de1";
    level._effect[#"hash_4eddc2f547bc55f6"] = #"hash_246ba1502485a840";
    level._effect[#"hash_7bd75ae600e0a590"] = "maps/zm_towers/fx8_crowd_reward_flower_exp";
    level._effect[#"hash_4c4f96aa02c32a2a"] = "maps/zm_towers/fx8_crowd_reward_flower_trail";
    level._effect[#"hash_6ff3eb2dd0078a51"] = #"hash_71198dfc5b0fd85";
    level._effect[#"hash_3f79f6da0222ebc2"] = #"hash_2f1958cd9b473bec";
    level._effect[#"fertilizer_smell"] = #"hash_48344f893bb65bf2";
    level._effect[#"hash_5a3e1454226ef7a4"] = #"hash_62ef4090559ca8c8";
    level._effect[#"hash_1f7bfd354d2472e3"] = #"hash_153286962fe0c0c5";
    level._effect[#"hash_1f7511354d1e7631"] = #"hash_153992962fe6f3d7";
    level._effect[#"maelstrom_initiate"] = #"hash_223c6a623adb13fb";
    level._effect[#"hash_504ad50f841882fe"] = #"hash_26b672f2c1c8a570";
    level._effect[#"hash_2cf77bcee904664d"] = #"hash_50ce930e4dd4bc12";
    level._effect[#"hash_2cf75dcee9043353"] = #"hash_50c7bb0e4dcee15c";
    level._effect[#"hash_4a9ad8ec06102c34"] = #"hash_4d91ce766ebeda81";
    level._effect[#"hash_4a9abeec06100006"] = #"hash_4db3c6766edbb34f";
    level._effect[#"hash_59efd6cf7ca11195"] = #"hash_35d31a887a79e68e";
    level._effect[#"hash_59efc8cf7ca0f9cb"] = #"hash_361dea887ab98078";
    level._effect[#"hash_416145285a01faa3"] = #"hash_28ad85abec3ad058";
    level._effect[#"hash_416143285a01f73d"] = #"hash_28479dabebe445ee";
    level._effect[#"hash_df4673638509cab"] = #"hash_2543453edaf343d4";
    level._effect[#"hash_df475363850b475"] = #"hash_259b253edb3d834a";
    level._effect[#"maelstrom_conduct"] = #"zm_ai/fx8_elec_bolt";
    level._effect[#"hash_1814d4cc1867739c"] = #"hash_13f09e4051884309";
    level._effect[#"hash_314d3a2e542805c0"] = #"zombie/fx_powerup_on_red_zmb";
    level._effect[#"maelstrom_death"] = #"hash_6a5c671e82cb5243";
    level._effect[#"maelstrom_camera_fx"] = #"hash_33ca6401bbf3798c";
    level._effect[#"hash_23ba00d2f804acc2"] = #"hash_56b121a7e7eee303";
    level._effect[#"hash_5afda864f8b64f5c"] = #"hash_5f48f8d916a0f612";
    include_weapons();
    level.var_f24d2121 = zm_towers_crowd_meter::register("zm_towers_crowd_meter");
    load::main();
    util::waitforclient(0);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x645eb4da, Offset: 0x2ed0
// Size: 0x7c
function function_374b5948(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        function_fb03c761(localclientnum, level._effect[#"entry_gate_dust"], self, "p8_zm_gla_tunnel_gate");
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x81320c9a, Offset: 0x2f58
// Size: 0xbe
function pickup_dung(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self postfx::playpostfxbundle(#"hash_2ee8588651571cb");
        return;
    }
    self postfx::stoppostfxbundle(#"hash_2ee8588651571cb");
    if (isdefined(self.var_74b4c416)) {
        stopfx(localclientnum, self.var_74b4c416);
        self.var_74b4c416 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xfb3948c8, Offset: 0x3020
// Size: 0x9c
function function_1872b289(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect[#"hash_6ff3eb2dd0078a51"], self.origin);
    playsound(localclientnum, #"hash_2e08e4ff8f949d48", self.origin);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xeb30d390, Offset: 0x30c8
// Size: 0x8c
function function_bd342a92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        forcestreamxmodel(#"hash_77659f61538a4beb");
        return;
    }
    stopforcestreamingxmodel(#"hash_77659f61538a4beb");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x9e5f1653, Offset: 0x3160
// Size: 0x8c
function function_9e33ae0c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        forcestreamxmodel(#"hash_4286272708c5e5c0");
        return;
    }
    stopforcestreamingxmodel(#"hash_4286272708c5e5c0");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x2e3de863, Offset: 0x31f8
// Size: 0x15e
function function_91d020c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_531e1c65)) {
        self.var_531e1c65 = util::spawn_model(localclientnum, "tag_origin", self.origin);
        self.var_531e1c65 linkto(self);
    }
    if (newval) {
        self.var_a099675a = util::playfxontag(localclientnum, level._effect[#"hash_3f79f6da0222ebc2"], self.var_531e1c65, "tag_origin");
        return;
    }
    if (isdefined(self.var_a099675a)) {
        stopfx(localclientnum, self.var_a099675a);
        self.var_a099675a = undefined;
    }
    if (isdefined(self.var_531e1c65)) {
        self.var_531e1c65 unlink();
        self.var_531e1c65 delete();
        self.var_531e1c65 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x94e6f84e, Offset: 0x3360
// Size: 0x8c
function function_cbcec96d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrenderoverridebundle(#"hash_3e2336a0454b9574");
        return;
    }
    self stoprenderoverridebundle(#"hash_3e2336a0454b9574");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xff919f89, Offset: 0x33f8
// Size: 0x8c
function function_8a04dec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrenderoverridebundle(#"hash_616b1855bf6ea5f2");
        return;
    }
    self stoprenderoverridebundle(#"hash_616b1855bf6ea5f2");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x65c76dba, Offset: 0x3490
// Size: 0x15e
function fertilizer_smell(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_4642c353 = playfx(localclientnum, level._effect[#"fertilizer_smell"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        if (!isdefined(self.var_a742b0f6)) {
            self.var_a742b0f6 = self playloopsound(#"zmb_funtime_fert_smell_lp");
        }
        return;
    }
    if (isdefined(self.var_4642c353)) {
        stopfx(localclientnum, self.var_4642c353);
        self.var_4642c353 = undefined;
    }
    if (isdefined(self.var_a742b0f6)) {
        self stoploopsound(self.var_a742b0f6);
        self.var_a742b0f6 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xb80abdea, Offset: 0x35f8
// Size: 0x17c
function function_3c8dbb3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_fx = struct::get(#"hash_44451a49b3653789");
    if (newval) {
        s_fx.var_fc8557b6 = playfx(localclientnum, level._effect[#"hash_5a3e1454226ef7a4"], s_fx.origin + (0, 0, 4), anglestoforward(s_fx.angles), anglestoup(s_fx.angles));
        audio::playloopat("zmb_funtime_fert_smell_lp", s_fx.origin);
        return;
    }
    if (isdefined(s_fx.var_fc8557b6)) {
        stopfx(localclientnum, s_fx.var_fc8557b6);
        s_fx.var_fc8557b6 = undefined;
    }
    audio::stoploopat("zmb_funtime_fert_smell_lp", s_fx.origin);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x27379397, Offset: 0x3780
// Size: 0x1ec
function function_b8870a25(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!level flag::exists(#"hash_3f632a7ca8c645e9")) {
        level flag::init(#"hash_3f632a7ca8c645e9");
    }
    if (newval) {
        if (level flag::get(#"hash_3f632a7ca8c645e9")) {
            return;
        }
        level flag::set(#"hash_3f632a7ca8c645e9");
        callback::on_spawned(&function_6be7c942);
        a_e_players = getplayers(localclientnum);
        a_e_players = array::remove_dead(a_e_players);
        array::thread_all(a_e_players, &function_6be7c942, localclientnum);
        return;
    }
    if (!level flag::get(#"hash_3f632a7ca8c645e9")) {
        return;
    }
    level flag::clear(#"hash_3f632a7ca8c645e9");
    callback::remove_on_spawned(&function_6be7c942);
    array::notify_all(getplayers(localclientnum), #"hash_5f06618b8c668b18");
}

// Namespace zm_towers/zm_towers
// Params 1, eflags: 0x0
// Checksum 0xd9878954, Offset: 0x3978
// Size: 0x146
function function_6be7c942(localclientnum) {
    self notify("7aefb053e23b6d79");
    self endon("7aefb053e23b6d79");
    self endon(#"death", #"hash_5f06618b8c668b18");
    n_random_wait = randomfloatrange(1, 3);
    wait n_random_wait;
    while (true) {
        e_client = function_f97e7787(localclientnum);
        if (self === e_client && function_5459d334(localclientnum)) {
            playfxoncamera(localclientnum, level._effect[#"hash_1f7bfd354d2472e3"], (0, 0, 0), (1, 0, 0));
        } else {
            util::playfxontag(localclientnum, level._effect[#"hash_1f7511354d1e7631"], self, "j_head");
        }
        wait 3;
    }
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x829b3cb9, Offset: 0x3ac8
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table(#"gamedata/weapons/zm/zm_towers_weapons.csv", 0);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x87abe7de, Offset: 0x3af8
// Size: 0x276
function ra_eyes_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_fe7cb2a = struct::get("s_ra_puzzle_beam_end", "targetname");
        self.var_66f564ca = util::spawn_model(localclientnum, "tag_origin", var_fe7cb2a.origin, var_fe7cb2a.angles);
        level beam::launch(self, "tag_origin", self.var_66f564ca, "tag_origin", "beam8_zm_scepter_ray_lvl3");
        self playsound(localclientnum, #"hash_473e265e57e397c8");
        soundlineemitter(#"hash_4bc05f42a04dcfd8", self.origin, self.var_66f564ca.origin);
        self.var_66f564ca.sfx_id = self.var_66f564ca playloopsound(#"hash_c0bb4bb6f79f737");
        return;
    }
    if (isdefined(self) && isdefined(self.var_66f564ca)) {
        soundstoplineemitter(#"hash_4bc05f42a04dcfd8", self.origin, self.var_66f564ca.origin);
        self.var_66f564ca stoploopsound(self.var_66f564ca.sfx_id);
        self playsound(localclientnum, #"hash_488e51364172acd9");
        level beam::kill(self, "tag_origin", self.var_66f564ca, "tag_origin", "beam8_zm_scepter_ray_lvl3");
        self.var_66f564ca delete();
        self.var_66f564ca = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x488a992c, Offset: 0x3d78
// Size: 0x276
function ra_rooftop_eyes_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_fe7cb2a = struct::get("s_puzzle_complete_beam_end", "targetname");
        self.var_66f564ca = util::spawn_model(localclientnum, "tag_origin", var_fe7cb2a.origin, var_fe7cb2a.angles);
        level beam::launch(self, "tag_origin", self.var_66f564ca, "tag_origin", "beam8_zm_scepter_ray_lvl3");
        self playsound(localclientnum, #"hash_4ad6201a8477162e");
        soundlineemitter(#"hash_1befd714ba572b72", self.origin, self.var_66f564ca.origin);
        self.var_66f564ca.sfx_id = self.var_66f564ca playloopsound(#"hash_625ff5d45245151d");
        return;
    }
    if (isdefined(self) && isdefined(self.var_66f564ca)) {
        soundstoplineemitter(#"hash_1befd714ba572b72", self.origin, self.var_66f564ca.origin);
        self.var_66f564ca stoploopsound(self.var_66f564ca.sfx_id);
        self playsound(localclientnum, #"hash_1eeb0d38cf56cc1b");
        level beam::kill(self, "tag_origin", self.var_66f564ca, "tag_origin", "beam8_zm_scepter_ray_lvl3");
        self.var_66f564ca delete();
        self.var_66f564ca = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xe1b0b900, Offset: 0x3ff8
// Size: 0x7c
function function_8e459f7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        forcestreamxmodel("p8_zm_gla_target_bull_flat");
        return;
    }
    stopforcestreamingxmodel("p8_zm_gla_target_bull_flat");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x28530d3c, Offset: 0x4080
// Size: 0x7c
function function_7e98b76a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        forcestreamxmodel("p8_zm_gla_obelisk_med_02_glyph");
        return;
    }
    stopforcestreamingxmodel("p8_zm_gla_obelisk_med_02_glyph");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x31d61de, Offset: 0x4108
// Size: 0xb4
function function_4f225d0d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_4d48cfd0 = util::playfxontag(localclientnum, level._effect[#"powerup_on_solo"], self, "tag_eye");
        return;
    }
    if (isdefined(self.var_4d48cfd0)) {
        stopfx(localclientnum, self.var_4d48cfd0);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x26b7e2bf, Offset: 0x41c8
// Size: 0xb4
function function_4326fc58(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_4d48cfd0 = util::playfxontag(localclientnum, level._effect[#"hash_233e31d0c2b47b1b"], self, "j_neck");
        return;
    }
    if (isdefined(self.var_4d48cfd0)) {
        stopfx(localclientnum, self.var_4d48cfd0);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xa78bed7c, Offset: 0x4288
// Size: 0xae
function function_b0005be4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_4c036311 = util::playfxontag(localclientnum, level._effect[#"hash_4eddc2f547bc55f6"], self, "tag_weapon_left");
        return;
    }
    stopfx(localclientnum, self.var_4c036311);
    self.var_4c036311 = undefined;
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x3057a16c, Offset: 0x4340
// Size: 0xae
function function_642e66db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_6b33fc30 = util::playfxontag(localclientnum, level._effect[#"hash_4eddc2f547bc55f6"], self, "tag_weapon_right");
        return;
    }
    stopfx(localclientnum, self.var_6b33fc30);
    self.var_6b33fc30 = undefined;
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x724150f5, Offset: 0x43f8
// Size: 0xb4
function toggle_blue_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_4d48cfd0 = playfx(localclientnum, level._effect[#"powerup_on_solo"], self.origin);
        return;
    }
    if (isdefined(self.var_4d48cfd0)) {
        stopfx(localclientnum, self.var_4d48cfd0);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xc58f00aa, Offset: 0x44b8
// Size: 0xb4
function toggle_chaos_ball(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_a3177394 = util::playfxontag(localclientnum, level._effect[#"chaos_ball"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_a3177394)) {
        stopfx(localclientnum, self.var_a3177394);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xba370e8f, Offset: 0x4578
// Size: 0xb4
function function_3e5779d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_4d48cfd0 = playfx(localclientnum, level._effect[#"hash_37043a271f6dd852"], self.origin);
        return;
    }
    if (isdefined(self.var_4d48cfd0)) {
        stopfx(localclientnum, self.var_4d48cfd0);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x27101ce9, Offset: 0x4638
// Size: 0xb4
function toggle_sentinel_artifact_mist_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_9e429d95 = util::playfxontag(localclientnum, level._effect[#"hash_73172b799c18404e"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_9e429d95)) {
        stopfx(localclientnum, self.var_9e429d95);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xc0c6b467, Offset: 0x46f8
// Size: 0x2a0
function crowd_react_boss(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        smodelanimcmd("siege_crowds_battle", "unpause", "set_anim", array::random(array(#"hash_5cb3945473641f29", #"hash_503f5811c1c5e5e6", #"hash_1f6ed2b98c8d027b", #"hash_64e6aa218a7720e8", #"hash_4754434927e48765", #"hash_121b33ccb82a7192")));
    } else {
        smodelanimcmd("siege_crowds_battle", "unpause", "set_anim", array::random(array(#"hash_6b5a40bc4e870ff3", #"hash_56072b7700ddf344", #"hash_36841dd229ef8ac1", #"hash_592b16ba1f2e74aa", #"hash_23b34e6a58a2c83f", #"hash_5669312379919260")));
    }
    smodelanimcmd("siege_crowds_battle", "goto_random", "set_playback_speed", randomfloatrange(0.75, 1));
    if (newval) {
        a_structs = struct::get_array("mus_crowd_bossbattle", "targetname");
        foreach (s_struct in a_structs) {
            wait randomfloatrange(0.15, 0.5);
        }
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xc1e0bfbc, Offset: 0x49a0
// Size: 0x468
function crowd_react(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify("2bf4634add6d7515");
    self endon("2bf4634add6d7515");
    if (!isdefined(level.var_ababf381)) {
        level.var_ababf381 = 0;
    }
    switch (level.var_ababf381) {
    case 0:
        switch (newval) {
        case 0:
            var_7814e8cc = "seated";
            break;
        case 1:
            var_7814e8cc = "seated_to_angry";
            break;
        case 2:
            var_7814e8cc = "seated_to_neutral";
            break;
        case 3:
            var_7814e8cc = "seated_to_cheer";
            break;
        }
        break;
    case 1:
        switch (newval) {
        case 0:
            var_7814e8cc = "angry_to_seated";
            break;
        case 1:
            var_7814e8cc = "angry";
            break;
        case 2:
            var_7814e8cc = "angry_to_neutral";
            break;
        case 3:
            var_7814e8cc = "angry_to_cheer";
            break;
        }
        break;
    case 2:
        switch (newval) {
        case 0:
            var_7814e8cc = "neutral_to_seated";
            break;
        case 1:
            var_7814e8cc = "neutral_to_angry";
            break;
        case 2:
            var_7814e8cc = "neutral";
            break;
        case 3:
            var_7814e8cc = "neutral_to_cheer";
            break;
        }
        break;
    case 3:
        switch (newval) {
        case 0:
            var_7814e8cc = "cheer_to_seated";
            break;
        case 1:
            var_7814e8cc = "cheer_to_angry";
            break;
        case 2:
            var_7814e8cc = "cheer_to_neutral";
            break;
        case 3:
            var_7814e8cc = "cheer";
            break;
        }
        break;
    }
    level.var_ababf381 = newval;
    foreach (str_group in array("siege_crowds_grp27", "siege_zm_crowds_indv_1", "siege_zm_crowds_indv_2", "siege_zm_crowds_indv_3", "siege_zm_crowds_indv_4", "siege_zm_crowds_indv_5", "siege_zm_crowds_indv_6", "siege_zm_crowds_indv_7", "siege_zm_crowds_indv_8", "siege_zm_crowds_indv_9", "siege_zm_crowds_indv_10")) {
        if (str_group == "siege_crowds_grp27") {
            level thread function_f3b9ab2(str_group, var_7814e8cc);
        } else {
            level thread function_10abf0ef(str_group, var_7814e8cc);
        }
        function_c02e04c4();
    }
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0xeb55d8ea, Offset: 0x4e10
// Size: 0xeb4
function function_10abf0ef(str_group, var_7814e8cc) {
    assert(isdefined(var_7814e8cc), "<dev string:x30>");
    switch (var_7814e8cc) {
    case #"seated_to_angry":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5c60a6f5f1a9d64a")));
        wait 1.733;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5596d5887d732c0e", #"hash_5596d4887d732a5b", #"hash_5596d3887d7328a8", #"hash_5596da887d73348d", #"hash_5596d9887d7332da")));
        break;
    case #"seated_to_neutral":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_dec580832649b0")));
        wait 1.733;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_146c97641992ac6c", #"hash_146c9a641992b185", #"hash_146c99641992afd2", #"hash_146c94641992a753")));
        break;
    case #"seated_to_cheer":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_1ce343c6e117581e")));
        wait 2.033;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4da666f21f604782", #"hash_4da665f21f6045cf", #"hash_4da664f21f60441c", #"hash_4da663f21f604269", #"hash_4da662f21f6040b6")));
        break;
    case #"angry_to_seated":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4d9e626e573c7720")));
        wait 3.8333;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_73397fae2c5e2e65", #"hash_73397cae2c5e294c", #"hash_73397dae2c5e2aff", #"hash_73397aae2c5e25e6", #"hash_73397bae2c5e2799", #"hash_733978ae2c5e2280")));
        break;
    case #"angry_to_neutral":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4cff3d99c8e94c1")));
        wait 5;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_146c97641992ac6c", #"hash_146c9a641992b185", #"hash_146c99641992afd2", #"hash_146c94641992a753")));
        break;
    case #"angry_to_cheer":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4da666f21f604782", #"hash_4da665f21f6045cf", #"hash_4da664f21f60441c", #"hash_4da663f21f604269", #"hash_4da662f21f6040b6")));
        break;
    case #"neutral_to_seated":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6938770d4f4e8ff2")));
        wait 3.9;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_73397fae2c5e2e65", #"hash_73397cae2c5e294c", #"hash_73397dae2c5e2aff", #"hash_73397aae2c5e25e6", #"hash_73397bae2c5e2799", #"hash_733978ae2c5e2280")));
        break;
    case #"neutral_to_angry":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_130c0f8d88ebfed1")));
        wait 5;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5596d5887d732c0e", #"hash_5596d4887d732a5b", #"hash_5596d3887d7328a8", #"hash_5596da887d73348d", #"hash_5596d9887d7332da")));
        break;
    case #"neutral_to_cheer":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6c2063a701bdda05")));
        wait 3.333;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4da666f21f604782", #"hash_4da665f21f6045cf", #"hash_4da664f21f60441c", #"hash_4da663f21f604269", #"hash_4da662f21f6040b6")));
        break;
    case #"cheer_to_seated":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_72e771137a0c1fb4")));
        wait 2.7;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_73397fae2c5e2e65", #"hash_73397cae2c5e294c", #"hash_73397dae2c5e2aff", #"hash_73397aae2c5e25e6", #"hash_73397bae2c5e2799", #"hash_733978ae2c5e2280")));
        break;
    case #"cheer_to_angry":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5596d5887d732c0e", #"hash_5596d4887d732a5b", #"hash_5596d3887d7328a8", #"hash_5596da887d73348d", #"hash_5596d9887d7332da")));
        break;
    case #"cheer_to_neutral":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4573975901365b65")));
        wait 5;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_146c97641992ac6c", #"hash_146c9a641992b185", #"hash_146c99641992afd2", #"hash_146c94641992a753")));
        break;
    case #"seated":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_73397fae2c5e2e65", #"hash_73397cae2c5e294c", #"hash_73397dae2c5e2aff", #"hash_73397aae2c5e25e6", #"hash_73397bae2c5e2799", #"hash_733978ae2c5e2280")));
        break;
    case #"angry":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_5596d5887d732c0e", #"hash_5596d4887d732a5b", #"hash_5596d3887d7328a8", #"hash_5596da887d73348d", #"hash_5596d9887d7332da")));
        break;
    case #"neutral":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_146c97641992ac6c", #"hash_146c9a641992b185", #"hash_146c99641992afd2", #"hash_146c94641992a753")));
        break;
    case #"cheer":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_4da666f21f604782", #"hash_4da665f21f6045cf", #"hash_4da664f21f60441c", #"hash_4da663f21f604269", #"hash_4da662f21f6040b6")));
        break;
    }
    smodelanimcmd(str_group, "goto_random", "set_playback_speed", randomfloatrange(0.75, 1));
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0x7861fc29, Offset: 0x5cd0
// Size: 0xabc
function function_f3b9ab2(str_group, var_7814e8cc) {
    assert(isdefined(var_7814e8cc), "<dev string:x72>");
    switch (var_7814e8cc) {
    case #"seated_to_angry":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_2e2971c6c8f10114")));
        wait 2.7;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6b167472b1814bb2")));
        break;
    case #"seated_to_neutral":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_12629d4e935c4656")));
        wait 2.7;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_69dc776360ba1330")));
        break;
    case #"seated_to_cheer":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_2da56ff9700d9164")));
        wait 2.7;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_43f1a9a1879ea5d6")));
        break;
    case #"angry_to_seated":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6c024bd52bb7e766")));
        wait 5;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_f31fa5dc0acf5f")));
        break;
    case #"angry_to_neutral":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_baf5290a3576eed")));
        wait 8.333;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_69dc776360ba1330")));
        break;
    case #"angry_to_cheer":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_43f1a9a1879ea5d6")));
        break;
    case #"neutral_to_seated":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_3e5b404caf7e8b58")));
        wait 5;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_f31fa5dc0acf5f")));
        break;
    case #"neutral_to_angry":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_196682111694d8f1")));
        wait 8.333;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6b167472b1814bb2")));
        break;
    case #"neutral_to_cheer":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6afc936043f3a9f9")));
        wait 8.333;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_43f1a9a1879ea5d6")));
        break;
    case #"cheer_to_seated":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6f45d5578dd7000a")));
        wait 2.7;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_f31fa5dc0acf5f")));
        break;
    case #"cheer_to_angry":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6b167472b1814bb2")));
        break;
    case #"cheer_to_neutral":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_556eddf8af2677b1")));
        wait 6.666;
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_69dc776360ba1330")));
        break;
    case #"seated":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_f31fa5dc0acf5f")));
        break;
    case #"angry":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_6b167472b1814bb2")));
        break;
    case #"neutral":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_69dc776360ba1330")));
        break;
    case #"cheer":
        smodelanimcmd(str_group, "unpause", "set_anim", array::random(array(#"hash_43f1a9a1879ea5d6")));
        break;
    }
    smodelanimcmd(str_group, "goto_random", "set_playback_speed", randomfloatrange(0.75, 1));
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xdd8bd680, Offset: 0x6798
// Size: 0x34
function function_c02e04c4() {
    if (math::cointoss()) {
        wait randomfloatrange(0.15, 0.5);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x91ce49d6, Offset: 0x67d8
// Size: 0x48c
function snd_crowd_react(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 8) {
        level thread function_8da1424d(localclientnum);
        return;
    }
    if (newval == 11) {
        if (oldval == 5) {
            level thread function_dbf5724f(localclientnum, 0);
        }
        playsound(0, #"hash_4e3cdd42739b4a0b", (0, 0, 0));
        a_structs = struct::get_array("mus_crowd_bossbattle", "targetname");
        foreach (struct in a_structs) {
            playsound(localclientnum, #"hash_61052d99f398097", struct.origin);
            waitframe(1);
        }
        level notify(#"hash_18e33e7f341865b5");
        return;
    }
    if (newval == 12) {
        level thread function_36cffb66(localclientnum, 1);
        return;
    }
    if (newval == 13) {
        level thread function_36cffb66(localclientnum, 0);
        return;
    }
    if (newval == 9 || newval == 10) {
        if (oldval == 5) {
            level thread function_dbf5724f(localclientnum, 0);
        }
        level thread function_c893b614(localclientnum, newval);
        return;
    }
    if (newval == 14 || newval == 15) {
        if (oldval == 5) {
            level thread function_dbf5724f(localclientnum, 0);
        }
        level thread function_8a1cad55(localclientnum, newval);
        return;
    }
    if (newval == 5) {
        level thread function_dbf5724f(localclientnum, 1);
        return;
    } else if (oldval == 5) {
        level thread function_dbf5724f(localclientnum, 0);
    }
    switch (newval) {
    case 0:
        str_alias = #"hash_90cda71914ccf25";
        break;
    case 1:
        str_alias = #"hash_2a3c75c57c227b04";
        break;
    case 2:
        str_alias = #"hash_2a3c75c57c227b04";
        break;
    case 3:
        str_alias = #"amb_crowd_oneshot_positive";
        break;
    case 4:
        str_alias = #"amb_crowd_oneshot_positive";
        break;
    case 6:
        str_alias = #"hash_2a3c75c57c227b04";
        break;
    case 7:
        str_alias = #"amb_crowd_oneshot_positive";
        break;
    case 8:
        str_alias = #"amb_crowd_oneshot_positive";
        break;
    }
    level thread function_41c26e60(localclientnum, str_alias);
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0x85d7a69c, Offset: 0x6c70
// Size: 0x100
function function_41c26e60(localclientnum, str_alias) {
    a_structs = struct::get_array("sndCrowdOneshot", "targetname");
    foreach (s_struct in a_structs) {
        if (isdefined(s_struct.script_int) && s_struct.script_int) {
            playsound(localclientnum, str_alias, s_struct.origin);
            wait randomfloatrange(0.15, 0.5);
        }
    }
}

// Namespace zm_towers/zm_towers
// Params 1, eflags: 0x0
// Checksum 0xa5929689, Offset: 0x6d78
// Size: 0x1dc
function function_8da1424d(localclientnum) {
    a_structs = struct::get_array("sndCrowdOneshot", "targetname");
    a_structs = array::randomize(a_structs);
    s_oneshot = struct::get("sndCrowdLevelstart", "targetname");
    playsound(localclientnum, #"hash_481bb2830d09d01f", s_oneshot.origin);
    n_int = 1;
    foreach (s_struct in a_structs) {
        if (isdefined(s_struct.script_int) && s_struct.script_int) {
            playsound(localclientnum, #"hash_7ef570749fdb2ff2" + n_int, s_struct.origin);
            wait randomfloatrange(0.15, 0.5);
            n_int++;
        }
    }
    level notify(#"hash_18e33e7f341865b5");
    level notify(#"hash_61e23ff49a338bcf");
    wait 3;
    level thread function_c893b614(localclientnum, 9);
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0xc8e3e830, Offset: 0x6f60
// Size: 0x166
function function_c893b614(localclientnum, var_9dedd567) {
    a_structs = struct::get_array("mus_crowd", "targetname");
    var_9cceaac9 = "_start_";
    var_c6c1aef0 = randomintrange(1, 5);
    if (var_9dedd567 == 10) {
        var_9cceaac9 = "_end_";
        var_c6c1aef0 = randomintrange(1, 4);
    }
    foreach (s_struct in a_structs) {
        str_instrument = s_struct.script_string;
        playsound(localclientnum, "mus_crowd_" + str_instrument + var_9cceaac9 + var_c6c1aef0, s_struct.origin);
        waitframe(1);
    }
}

// Namespace zm_towers/zm_towers
// Params 3, eflags: 0x0
// Checksum 0x95f5e69a, Offset: 0x70d0
// Size: 0x24e
function function_dbf5724f(localclientnum, var_931bac44, var_cce459b0 = 0) {
    if (!isdefined(level.var_850bc861)) {
        level.var_850bc861 = 0;
    }
    if (var_931bac44) {
        level.var_850bc861 = randomintrangeinclusive(0, 4);
        a_structs = struct::get_array("sndCrowdOneshot", "targetname");
        a_structs = array::randomize(a_structs);
        foreach (s_struct in a_structs) {
            if (isdefined(s_struct.script_int) && s_struct.script_int || var_cce459b0) {
                audio::playloopat("amb_crowd_positive_max_lp_" + level.var_850bc861, s_struct.origin);
                waitframe(1);
            }
        }
        return;
    }
    a_structs = struct::get_array("sndCrowdOneshot", "targetname");
    foreach (s_struct in a_structs) {
        if (isdefined(s_struct.script_int) && s_struct.script_int || var_cce459b0) {
            audio::stoploopat("amb_crowd_positive_max_lp_" + level.var_850bc861, s_struct.origin);
            waitframe(1);
        }
    }
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0x75a5aaf7, Offset: 0x7328
// Size: 0x1c6
function function_8a1cad55(localclientnum, newval) {
    a_structs = struct::get_array("mus_crowd", "targetname");
    level thread function_41c26e60(localclientnum, "amb_crowd_oneshot_positive");
    if (newval == 14) {
        foreach (s_struct in a_structs) {
            str_instrument = s_struct.script_string;
            audio::playloopat("mus_crowd_" + str_instrument + "_special_loop", s_struct.origin);
            waitframe(1);
        }
        return;
    }
    if (newval == 15) {
        foreach (s_struct in a_structs) {
            str_instrument = s_struct.script_string;
            audio::stoploopat("mus_crowd_" + str_instrument + "_special_loop", s_struct.origin);
            waitframe(1);
        }
    }
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0x5b9ee7a7, Offset: 0x74f8
// Size: 0x2f6
function function_36cffb66(localclientnum, var_fff451a9) {
    a_structs = struct::get_array("mus_crowd_bossbattle", "targetname");
    if (var_fff451a9) {
        wait 4;
        foreach (s_struct in a_structs) {
            str_instrument = s_struct.script_string;
            playsound(localclientnum, "mus_crowd_" + str_instrument + "_boss_start", s_struct.origin);
            waitframe(1);
        }
        wait 4.8;
        foreach (s_struct in a_structs) {
            str_instrument = s_struct.script_string;
            audio::playloopat("mus_crowd_" + str_instrument + "_boss_loop", s_struct.origin);
            waitframe(1);
        }
        return;
    }
    foreach (s_struct in a_structs) {
        str_instrument = s_struct.script_string;
        playsound(localclientnum, "mus_crowd_" + str_instrument + "_boss_end", s_struct.origin);
        waitframe(1);
    }
    wait 1;
    foreach (s_struct in a_structs) {
        str_instrument = s_struct.script_string;
        audio::stoploopat("mus_crowd_" + str_instrument + "_boss_loop", s_struct.origin);
        waitframe(1);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xdafa4dee, Offset: 0x77f8
// Size: 0xfe
function special_round_camera_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    str_fx = "special_round_camera_start";
    var_fd460672 = "special_round_camera_persist";
    if (newval == 2) {
        str_fx = "maelstrom_camera_fx";
        var_fd460672 = "maelstrom_camera_fx";
    }
    if (newval) {
        self.fx_special_round_camera = playfxoncamera(localclientnum, level._effect[str_fx], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        self thread function_a6feb2ed(localclientnum, var_fd460672);
        return;
    }
    self notify(#"hash_19c9c2535b496f85");
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0xcb6ea7df, Offset: 0x7900
// Size: 0x80
function function_a6feb2ed(localclientnum, str_fx) {
    self endon(#"hash_19c9c2535b496f85", #"disconnect");
    while (true) {
        playfxoncamera(localclientnum, level._effect[str_fx], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        wait 0.25;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x39dc54d3, Offset: 0x7988
// Size: 0xb4
function function_55d9ef8a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level exploder::exploder("exp_special_round_gas");
        setexposureactivebank(localclientnum, 2);
        return;
    }
    level exploder::stop_exploder("exp_special_round_gas");
    setexposureactivebank(localclientnum, 1);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xc01bc503, Offset: 0x7a48
// Size: 0x11e
function function_a8405b54(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playsound(localclientnum, #"hash_539eb529963d7db4");
        self.fx = util::playfxontag(localclientnum, level._effect[#"head_fire_blue"], self, "j_neck");
        self.sfx = self playloopsound(#"hash_38c39a7f0966480e");
        return;
    }
    self.fx delete();
    if (isdefined(self.sfx)) {
        self stoploopsound(self.sfx);
        self.sfx = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x88b43c1e, Offset: 0x7b70
// Size: 0x11e
function function_e8a48c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playsound(localclientnum, #"hash_539eb529963d7db4");
        self.fx = util::playfxontag(localclientnum, level._effect[#"head_fire_green"], self, "j_neck");
        self.sfx = self playloopsound(#"hash_38c39a7f0966480e");
        return;
    }
    self.fx delete();
    if (isdefined(self.sfx)) {
        self stoploopsound(self.sfx);
        self.sfx = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x359f148, Offset: 0x7c98
// Size: 0x11e
function function_390cb9ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playsound(localclientnum, #"hash_539eb529963d7db4");
        self.fx = util::playfxontag(localclientnum, level._effect[#"head_fire_purple"], self, "j_neck");
        self.sfx = self playloopsound(#"hash_38c39a7f0966480e");
        return;
    }
    self.fx delete();
    if (isdefined(self.sfx)) {
        self stoploopsound(self.sfx);
        self.sfx = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xaef56ec0, Offset: 0x7dc0
// Size: 0x11e
function function_8476b253(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playsound(localclientnum, #"hash_539eb529963d7db4");
        self.fx = util::playfxontag(localclientnum, level._effect[#"head_fire_red"], self, "j_neck");
        self.sfx = self playloopsound(#"hash_38c39a7f0966480e");
        return;
    }
    self.fx delete();
    if (isdefined(self.sfx)) {
        self stoploopsound(self.sfx);
        self.sfx = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xd155e2c2, Offset: 0x7ee8
// Size: 0x2e2
function function_fedaee77(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_fx = struct::get("odin_brazier");
    switch (newval) {
    case 0:
        if (isdefined(s_fx.n_fire)) {
            stopfx(localclientnum, s_fx.n_fire);
        }
        audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
        audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
        break;
    case 1:
        s_fx.n_fire = playfx(localclientnum, level._effect[#"brazier_fire_blue"], s_fx.origin);
        playsound(localclientnum, #"hash_6e1881a291ad6bda", s_fx.origin);
        audio::playloopat(#"hash_929cb50cf634fb4", s_fx.origin);
        audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
        break;
    case 2:
        if (isdefined(s_fx.n_fire)) {
            stopfx(localclientnum, s_fx.n_fire);
        }
        s_fx.n_fire = playfx(localclientnum, level._effect[#"hash_169c8ab62603115c"], s_fx.origin);
        playsound(localclientnum, #"hash_5390d89dc611da6c", s_fx.origin);
        audio::playloopat(#"hash_3897a36236b75e0c", s_fx.origin);
        audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
        break;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x412de34f, Offset: 0x81d8
// Size: 0x2e2
function function_fb973422(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_fx = struct::get("danu_brazier");
    switch (newval) {
    case 0:
        if (isdefined(s_fx.n_fire)) {
            stopfx(localclientnum, s_fx.n_fire);
        }
        audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
        audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
        break;
    case 1:
        s_fx.n_fire = playfx(localclientnum, level._effect[#"brazier_fire_green"], s_fx.origin);
        playsound(localclientnum, #"hash_6e1881a291ad6bda", s_fx.origin);
        audio::playloopat(#"hash_929cb50cf634fb4", s_fx.origin);
        audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
        break;
    case 2:
        if (isdefined(s_fx.n_fire)) {
            stopfx(localclientnum, s_fx.n_fire);
        }
        s_fx.n_fire = playfx(localclientnum, level._effect[#"hash_169c8ab62603115c"], s_fx.origin);
        playsound(localclientnum, #"hash_5390d89dc611da6c", s_fx.origin);
        audio::playloopat(#"hash_3897a36236b75e0c", s_fx.origin);
        audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
        break;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x4b91adb3, Offset: 0x84c8
// Size: 0x2e2
function function_3f5f2af9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_fx = struct::get("zeus_brazier");
    switch (newval) {
    case 0:
        if (isdefined(s_fx.n_fire)) {
            stopfx(localclientnum, s_fx.n_fire);
        }
        audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
        audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
        break;
    case 1:
        s_fx.n_fire = playfx(localclientnum, level._effect[#"brazier_fire_purple"], s_fx.origin);
        playsound(localclientnum, #"hash_6e1881a291ad6bda", s_fx.origin);
        audio::playloopat(#"hash_929cb50cf634fb4", s_fx.origin);
        audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
        break;
    case 2:
        if (isdefined(s_fx.n_fire)) {
            stopfx(localclientnum, s_fx.n_fire);
        }
        s_fx.n_fire = playfx(localclientnum, level._effect[#"hash_169c8ab62603115c"], s_fx.origin);
        playsound(localclientnum, #"hash_5390d89dc611da6c", s_fx.origin);
        audio::playloopat(#"hash_3897a36236b75e0c", s_fx.origin);
        audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
        break;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xc932c66c, Offset: 0x87b8
// Size: 0x2e2
function function_127f889e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_fx = struct::get("ra_brazier");
    switch (newval) {
    case 0:
        if (isdefined(s_fx.n_fire)) {
            stopfx(localclientnum, s_fx.n_fire);
        }
        audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
        audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
        break;
    case 1:
        s_fx.n_fire = playfx(localclientnum, level._effect[#"brazier_fire_red"], s_fx.origin);
        playsound(localclientnum, #"hash_6e1881a291ad6bda", s_fx.origin);
        audio::playloopat(#"hash_929cb50cf634fb4", s_fx.origin);
        audio::stoploopat(#"hash_3897a36236b75e0c", s_fx.origin);
        break;
    case 2:
        if (isdefined(s_fx.n_fire)) {
            stopfx(localclientnum, s_fx.n_fire);
        }
        s_fx.n_fire = playfx(localclientnum, level._effect[#"hash_169c8ab62603115c"], s_fx.origin);
        playsound(localclientnum, #"hash_5390d89dc611da6c", s_fx.origin);
        audio::playloopat(#"hash_3897a36236b75e0c", s_fx.origin);
        audio::stoploopat(#"hash_929cb50cf634fb4", s_fx.origin);
        break;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xef04d44f, Offset: 0x8aa8
// Size: 0x9c
function function_1d6b0f30(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.fx = util::playfxontag(localclientnum, level._effect[#"energy_soul"], self, "j_neck");
        return;
    }
    self.fx delete();
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xb5f1566a, Offset: 0x8b50
// Size: 0x9c
function function_8077f496(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.fx = util::playfxontag(localclientnum, level._effect[#"energy_soul_target"], self, "j_neck");
        return;
    }
    self.fx delete();
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xc7e31107, Offset: 0x8bf8
// Size: 0x118
function function_6e01a618(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    a_s_crowd = struct::get_array("sndCrowdOneshot");
    foreach (s_crowd in a_s_crowd) {
        playsound(localclientnum, #"amb_crowd_oneshot_positive", s_crowd.origin);
        n_random_wait = randomfloatrange(0.15, 0.5);
        wait n_random_wait;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x41ad73d1, Offset: 0x8d18
// Size: 0xee
function acid_trap_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.n_acid_trap_death_fx = util::playfxontag(localclientnum, level._effect[#"acid_death"], self, "j_spine4");
        playsound(localclientnum, #"hash_4d4c9f8ad239b61f", self.origin);
        return;
    }
    if (isdefined(self.n_acid_trap_death_fx)) {
        stopfx(localclientnum, self.n_acid_trap_death_fx);
        self.n_acid_trap_death_fx = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xbf4f8216, Offset: 0x8e10
// Size: 0xc6
function function_5bf3db3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.var_458c4127 = util::playfxontag(localclientnum, level._effect[#"trap_switch_green"], self, "p8_zm_gla_trap_switch_01_handle_jnt");
        return;
    }
    if (isdefined(self.var_458c4127)) {
        stopfx(localclientnum, self.var_458c4127);
        self.var_458c4127 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xacda7ab2, Offset: 0x8ee0
// Size: 0xc6
function function_7fa1f79d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.var_4f1a5956 = util::playfxontag(localclientnum, level._effect[#"trap_switch_red"], self, "p8_zm_gla_trap_switch_01_handle_jnt");
        return;
    }
    if (isdefined(self.var_4f1a5956)) {
        stopfx(localclientnum, self.var_4f1a5956);
        self.var_4f1a5956 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xaa39c72e, Offset: 0x8fb0
// Size: 0x136
function function_a7b2b976(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.var_942f1095 = util::playfxontag(localclientnum, level._effect[#"trap_switch_smoke"], self, "p8_zm_gla_trap_switch_01_handle_jnt");
        if (!isdefined(self.var_952f8178)) {
            self.var_952f8178 = self playloopsound(#"hash_228d379ca7c13b55");
        }
        return;
    }
    if (isdefined(self.var_942f1095)) {
        stopfx(localclientnum, self.var_942f1095);
        self.var_942f1095 = undefined;
    }
    if (isdefined(self.var_952f8178)) {
        self stoploopsound(self.var_952f8178);
        self.var_952f8178 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x4af0755c, Offset: 0x90f0
// Size: 0xc4
function acid_trap_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self postfx::playpostfxbundle("pstfx_zm_acid_dmg_towers");
        self postfx::playpostfxbundle("pstfx_zm_acid_dmg_towers_2");
        return;
    }
    self postfx::exitpostfxbundle("pstfx_zm_acid_dmg_towers");
    self postfx::exitpostfxbundle("pstfx_zm_acid_dmg_towers_2");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xc75da44, Offset: 0x91c0
// Size: 0xbe
function function_b8aeb289(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_d552267b = util::playfxontag(localclientnum, level._effect[#"hash_42cc4bf5e47478c5"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_d552267b)) {
        stopfx(localclientnum, self.var_d552267b);
        self.var_d552267b = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x4d8848d3, Offset: 0x9288
// Size: 0x126
function function_3eb2e808(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_6598e21e = util::playfxontag(localclientnum, level._effect[#"hash_3b746cf6eec416b2"], self, "tag_origin");
        self.var_ce3da063 = util::playfxontag(localclientnum, level._effect[#"hash_36535f89ec2488d7"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_6598e21e)) {
        stopfx(localclientnum, self.var_6598e21e);
        stopfx(localclientnum, self.var_ce3da063);
        self.var_6598e21e = undefined;
        self.var_ce3da063 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x6d8fbb7b, Offset: 0x93b8
// Size: 0xd4
function function_b847d8ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    s_fx = struct::get(#"hash_43872a24dfb85c96");
    playfx(localclientnum, level._effect[#"hash_584e8f7433246444"], s_fx.origin, anglestoforward(s_fx.angles), anglestoup(s_fx.angles));
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x47016f9d, Offset: 0x9498
// Size: 0x5c
function function_b90eb0fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    function_9e369ede(localclientnum, "danu");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x2e1b535a, Offset: 0x9500
// Size: 0x5c
function function_5aeeefa2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    function_9e369ede(localclientnum, "ra");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x8dc01c75, Offset: 0x9568
// Size: 0x5c
function function_93d237bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    function_9e369ede(localclientnum, "odin");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xf6462c0b, Offset: 0x95d0
// Size: 0x5c
function function_d897406e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    function_9e369ede(localclientnum, "zeus");
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0x6e6e869d, Offset: 0x9638
// Size: 0x9c
function function_9e369ede(localclientnum, str_tower) {
    s_fx = struct::get(#"hash_73ea18ffc4b86f9b" + str_tower);
    playfx(localclientnum, level._effect[#"ww_quest_scorpio"], s_fx.origin, anglestoforward(s_fx.angles));
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x8673b319, Offset: 0x96e0
// Size: 0xbe
function function_d8d66c54(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_c01874d7 = util::playfxontag(localclientnum, level._effect[#"hash_4c4f96aa02c32a2a"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_c01874d7)) {
        stopfx(localclientnum, self.var_c01874d7);
        self.var_c01874d7 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x2414944e, Offset: 0x97a8
// Size: 0x74
function function_6d365cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    playfx(localclientnum, level._effect[#"hash_7bd75ae600e0a590"], self.origin);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xeb264ce8, Offset: 0x9828
// Size: 0x74
function function_585decea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    util::playfxontag(localclientnum, level._effect[#"hash_48ad84f9cf6a33f0"], self, "tag_fx");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x9e2316df, Offset: 0x98a8
// Size: 0xe6
function function_a30a76b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_475284b9 = self zbarriergetpiece(1);
    if (newval) {
        level.var_a041c633 = util::playfxontag(localclientnum, level._effect[#"hash_3974bea828fbf7f7"], var_475284b9, "tag_fx");
        return;
    }
    if (isdefined(level.var_a041c633)) {
        stopfx(localclientnum, level.var_a041c633);
        level.var_a041c633 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xf803db01, Offset: 0x9998
// Size: 0x1fe
function function_a73e61c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_475284b9 = self zbarriergetpiece(2);
    if (!isdefined(level.var_766f40ab)) {
        v_origin = var_475284b9 gettagorigin("j_lid");
        v_angles = var_475284b9 gettagangles("j_lid");
        v_angles += (0, 90, 0);
        level.var_766f40ab = util::spawn_model(localclientnum, "tag_origin", v_origin, v_angles);
        level.var_766f40ab linkto(var_475284b9, "j_lid");
    }
    if (newval) {
        level.var_69727bd4 = util::playfxontag(localclientnum, level._effect[#"hash_1add6939914df65a"], level.var_766f40ab, "tag_origin");
        return;
    }
    if (isdefined(level.var_69727bd4)) {
        stopfx(localclientnum, level.var_69727bd4);
        level.var_69727bd4 = undefined;
    }
    if (isdefined(level.var_766f40ab)) {
        level.var_766f40ab unlink();
        level.var_766f40ab delete();
        level.var_766f40ab = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x214c2509, Offset: 0x9ba0
// Size: 0xe6
function function_78be2a01(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_475284b9 = self zbarriergetpiece(2);
    if (newval) {
        level.var_f187f7ad = util::playfxontag(localclientnum, level._effect[#"hash_5dc6f97e5850e1d1"], var_475284b9, "tag_fx");
        return;
    }
    if (isdefined(level.var_f187f7ad)) {
        stopfx(localclientnum, level.var_f187f7ad);
        level.var_f187f7ad = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x349242db, Offset: 0x9c90
// Size: 0x7c
function ww_quest_earthquake(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    function_d2913e3e(localclientnum, #"zm_towers_earthquake_heavy");
    function_d2913e3e(localclientnum, #"zm_towers_earthquake_light");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xacbb4eb0, Offset: 0x9d18
// Size: 0xcc
function function_ba016e82(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        forcestreamxmodel(#"p8_zm_gla_artifact_podium");
        forcestreamxmodel(#"p8_zm_gla_artifact_podium_on");
        return;
    }
    stopforcestreamingxmodel(#"p8_zm_gla_artifact_podium");
    stopforcestreamingxmodel(#"p8_zm_gla_artifact_podium_on");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x54c8043f, Offset: 0x9df0
// Size: 0xb4
function maelstrom_initiate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self playsound(localclientnum, #"hash_63d588d1f28ecdc1");
    function_d2913e3e(localclientnum, "damage_heavy");
    earthquake(localclientnum, 1, 0.25, self.origin, 64);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x77f751cd, Offset: 0x9eb0
// Size: 0x110
function maelstrom_initiate_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    a_s_fx = struct::get_array("s_maelstrom_initiate_fx");
    foreach (s_fx in a_s_fx) {
        playfx(localclientnum, level._effect[#"maelstrom_initiate"], s_fx.origin, anglestoforward(s_fx.angles));
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xf9de7d23, Offset: 0x9fc8
// Size: 0x7ba
function function_2763cea3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        var_4117016e = [];
        var_c4b99b60 = util::playfxontag(localclientnum, level._effect[#"hash_4a9ad8ec06102c34"], self, "j_shoulder_le");
        var_3903f3ae = util::playfxontag(localclientnum, level._effect[#"hash_4a9abeec06100006"], self, "j_shoulder_re");
        var_e7fde41b = util::playfxontag(localclientnum, level._effect[#"hash_504ad50f841882fe"], self, "j_elbow_le");
        var_249e3541 = util::playfxontag(localclientnum, level._effect[#"hash_504ad50f841882fe"], self, "j_elbow_re");
        var_75f674e0 = util::playfxontag(localclientnum, level._effect[#"hash_2cf77bcee904664d"], self, "j_elbow_le");
        var_4aa0afaa = util::playfxontag(localclientnum, level._effect[#"hash_2cf75dcee9043353"], self, "j_elbow_re");
        var_1c0e98eb = util::playfxontag(localclientnum, level._effect[#"hash_59efd6cf7ca11195"], self, "j_ankle_le");
        var_37ffba75 = util::playfxontag(localclientnum, level._effect[#"hash_59efc8cf7ca0f9cb"], self, "j_ankle_ri");
        var_fcbc10ad = util::playfxontag(localclientnum, level._effect[#"hash_416145285a01faa3"], self, "j_hip_le");
        var_40f295b3 = util::playfxontag(localclientnum, level._effect[#"hash_416143285a01f73d"], self, "j_hip_ri");
        var_7705675 = util::playfxontag(localclientnum, level._effect[#"hash_df4673638509cab"], self, "j_knee_le");
        var_eb7f34eb = util::playfxontag(localclientnum, level._effect[#"hash_df475363850b475"], self, "j_knee_ri");
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_c4b99b60;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_3903f3ae;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_e7fde41b;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_75f674e0;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_249e3541;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_4aa0afaa;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_1c0e98eb;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_37ffba75;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_fcbc10ad;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_40f295b3;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_7705675;
        if (!isdefined(var_4117016e)) {
            var_4117016e = [];
        } else if (!isarray(var_4117016e)) {
            var_4117016e = array(var_4117016e);
        }
        var_4117016e[var_4117016e.size] = var_eb7f34eb;
        self.var_2cfe53e5 = var_4117016e;
        return;
    }
    if (isdefined(self.var_2cfe53e5)) {
        foreach (n_fx in self.var_2cfe53e5) {
            stopfx(localclientnum, n_fx);
        }
        self.var_2cfe53e5 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xa2268f25, Offset: 0xa790
// Size: 0xe6
function maelstrom_conduct(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_340800c8 = util::playfxontag(localclientnum, level._effect[#"maelstrom_conduct"], self, "tag_origin");
        self playsound(localclientnum, #"hash_63d588d1f28ecdc1");
        return;
    }
    if (isdefined(self.var_340800c8)) {
        stopfx(localclientnum, self.var_340800c8);
        self.var_340800c8 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xf18a34cd, Offset: 0xa880
// Size: 0xbe
function function_9c6d38fa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_9015526c = util::playfxontag(localclientnum, level._effect[#"hash_1814d4cc1867739c"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_9015526c)) {
        stopfx(localclientnum, self.var_9015526c);
        self.var_9015526c = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x97354c97, Offset: 0xa948
// Size: 0xbe
function function_f50048da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_faf5bbc8 = util::playfxontag(localclientnum, level._effect[#"hash_314d3a2e542805c0"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_faf5bbc8)) {
        stopfx(localclientnum, self.var_faf5bbc8);
        self.var_faf5bbc8 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xa4a269f9, Offset: 0xaa10
// Size: 0xa4
function maelstrom_discharge(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    playfx(localclientnum, level._effect[#"maelstrom_death"], self.origin, anglestoforward((0, 0, 0)), anglestoup((0, 0, 0)));
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x94688552, Offset: 0xaac0
// Size: 0xc4
function maelstrom_death(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    playfx(localclientnum, level._effect[#"maelstrom_death"], self.origin, anglestoforward((0, 0, 0)), anglestoup((0, 0, 0)));
    function_d2913e3e(localclientnum, "lightninggun_fire");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xde5adbd2, Offset: 0xab90
// Size: 0xae
function maelstrom_storm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self thread function_3b56899a(localclientnum);
        return;
    }
    self notify(#"hash_f1009da282756ec");
    if (isdefined(self.var_46297478)) {
        self stoploopsound(self.var_46297478);
        self.var_46297478 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 1, eflags: 0x0
// Checksum 0x1b51fb47, Offset: 0xac48
// Size: 0x8a
function function_3b56899a(localclientnum) {
    self endon(#"death", #"hash_f1009da282756ec");
    self playsound(localclientnum, #"hash_334d4a903f12856f");
    wait 1;
    self.var_46297478 = self playloopsound(#"hash_1fc7648098c65e92", 12);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x6ef224ef, Offset: 0xace0
// Size: 0x64
function function_9c70916e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self playsound(localclientnum, #"hash_334d4a903f12856f");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x88c73efa, Offset: 0xad50
// Size: 0xcc
function maelstrom_ending(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self playsound(localclientnum, #"hash_334d4a903f12856f");
    if (!isalive(self)) {
        return;
    }
    function_d2913e3e(localclientnum, "damage_heavy");
    earthquake(localclientnum, 1, 0.25, self.origin, 64);
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xd21f7d24, Offset: 0xae28
// Size: 0xbe
function function_7a09cd08(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_c4316c76 = util::playfxontag(localclientnum, level._effect[#"hash_23ba00d2f804acc2"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_c4316c76)) {
        stopfx(localclientnum, self.var_c4316c76);
        self.var_c4316c76 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x5f9b29e0, Offset: 0xaef0
// Size: 0x54
function function_50a807db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self thread function_3de06cea(newval);
}

// Namespace zm_towers/zm_towers
// Params 1, eflags: 0x0
// Checksum 0x3a1d914a, Offset: 0xaf50
// Size: 0x29e
function function_3de06cea(b_show) {
    self notify("445179c5717fefac");
    self endon("445179c5717fefac");
    self endon(#"death");
    if (!self flag::exists(#"hash_71f56d0cc4c3df1f")) {
        self flag::init(#"hash_71f56d0cc4c3df1f");
        self flag::set(#"hash_71f56d0cc4c3df1f");
        self playrenderoverridebundle(#"hash_16b8b568a95931e7");
    }
    n_start_time = gettime();
    n_end_time = n_start_time + int(0.5 * 1000);
    n_alpha_start = 0;
    n_alpha_end = 1;
    b_stream = 1;
    if (!b_show) {
        n_alpha_start = 1;
        n_alpha_end = 0;
        b_stream = 0;
    }
    if (b_stream) {
        forcestreamxmodel(self.model);
    } else {
        stopforcestreamingxmodel(self.model);
    }
    while (true) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            self function_98a01e4c(#"hash_16b8b568a95931e7", "brightness", n_alpha_end);
            self function_98a01e4c(#"hash_16b8b568a95931e7", "alpha", n_alpha_end);
            break;
        }
        n_alpha = mapfloat(n_start_time, n_end_time, n_alpha_start, n_alpha_end, n_time);
        self function_98a01e4c(#"hash_16b8b568a95931e7", "brightness", n_alpha);
        self function_98a01e4c(#"hash_16b8b568a95931e7", "alpha", n_alpha);
        waitframe(1);
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x38ae79ea, Offset: 0xb1f8
// Size: 0xee
function function_48080d32(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_b1eecfc0 = playfx(localclientnum, level._effect[#"hash_5afda864f8b64f5c"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        return;
    }
    if (isdefined(self.var_b1eecfc0)) {
        stopfx(localclientnum, self.var_b1eecfc0);
        self.var_b1eecfc0 = undefined;
    }
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0x2ec5ffa0, Offset: 0xb2f0
// Size: 0xc4
function function_39829164(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        function_a419c9f1(localclientnum, "ee_space");
        function_15f07337(localclientnum, "arena_occluder_volume");
        return;
    }
    function_9fb45cd8(localclientnum, "ee_space");
    function_78b4fa6c(localclientnum, "arena_occluder_volume");
}

// Namespace zm_towers/zm_towers
// Params 7, eflags: 0x0
// Checksum 0xf3e24dd9, Offset: 0xb3c0
// Size: 0x84
function function_6d205818(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        function_a419c9f1(localclientnum, "narrative_room");
        return;
    }
    function_9fb45cd8(localclientnum, "narrative_room");
}

