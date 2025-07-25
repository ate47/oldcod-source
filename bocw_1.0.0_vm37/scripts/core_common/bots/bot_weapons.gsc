#using script_4e44ad88a2b0f559;
#using scripts\core_common\bots\bot_action;
#using scripts\killstreaks\killstreakrules_shared;

#namespace bot_weapons;

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x0
// Checksum 0x64b6eaec, Offset: 0x1f0
// Size: 0x64
function preinit() {
    function_ce850bf4();
    function_c50262c4();
    function_ece9035a();
    function_c7dfc94();
    function_1f3281d9();
    function_d4db3361();
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0x647fa017, Offset: 0x260
// Size: 0x784
function private function_ce850bf4() {
    bot_action::register_weapon(#"ar_accurate_t9", &function_319dfab4, &use_ar);
    bot_action::register_weapon(#"ar_damage_t9", &function_319dfab4, &use_ar);
    bot_action::register_weapon(#"ar_fastfire_t9", &function_319dfab4, &use_ar);
    bot_action::register_weapon(#"ar_fasthandling_t9", &function_319dfab4, &use_ar);
    bot_action::register_weapon(#"ar_mobility_t9", &function_319dfab4, &use_ar);
    bot_action::register_weapon(#"ar_slowfire_t9", &function_319dfab4, &use_ar);
    bot_action::register_weapon(#"ar_slowhandling_t9", &function_319dfab4, &use_ar);
    bot_action::register_weapon(#"ar_standard_t9", &function_319dfab4, &use_ar);
    bot_action::register_weapon(#"lmg_accurate_t9", &function_aadbe8c, &use_lmg);
    bot_action::register_weapon(#"lmg_fastfire_t9", &function_aadbe8c, &use_lmg);
    bot_action::register_weapon(#"lmg_light_t9", &function_aadbe8c, &use_lmg);
    bot_action::register_weapon(#"lmg_slowfire_t9", &function_aadbe8c, &use_lmg);
    bot_action::register_weapon(#"smg_accurate_t9", &function_b9557a8a, &use_smg);
    bot_action::register_weapon(#"smg_burst_t9", &function_b9557a8a, &use_smg);
    bot_action::register_weapon(#"smg_capacity_t9", &function_b9557a8a, &use_smg);
    bot_action::register_weapon(#"smg_fastfire_t9", &function_b9557a8a, &use_smg);
    bot_action::register_weapon(#"smg_handling_t9", &function_b9557a8a, &use_smg);
    bot_action::register_weapon(#"smg_heavy_t9", &function_b9557a8a, &use_smg);
    bot_action::register_weapon(#"smg_spray_t9", &function_b9557a8a, &use_smg);
    bot_action::register_weapon(#"smg_standard_t9", &function_b9557a8a, &use_smg);
    bot_action::register_weapon(#"sniper_accurate_t9", &function_c75d81ab, &use_sniper);
    bot_action::register_weapon(#"sniper_cannon_t9", &function_c75d81ab, &use_sniper);
    bot_action::register_weapon(#"sniper_powersemi_t9", &function_c75d81ab, &use_sniper);
    bot_action::register_weapon(#"sniper_quickscope_t9", &function_c75d81ab, &use_sniper);
    bot_action::register_weapon(#"sniper_standard_t9", &function_c75d81ab, &use_sniper);
    bot_action::register_weapon(#"tr_damagesemi_t9", &function_183e848d, &use_tr);
    bot_action::register_weapon(#"tr_fastburst_t9", &function_183e848d, &use_tr);
    bot_action::register_weapon(#"tr_longburst_t9", &function_183e848d, &use_tr);
    bot_action::register_weapon(#"tr_powerburst_t9", &function_183e848d, &use_tr);
    bot_action::register_weapon(#"tr_precisionsemi_t9", &function_183e848d, &use_tr);
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0xb21025ef, Offset: 0x9f0
// Size: 0x284
function private function_c50262c4() {
    bot_action::register_weapon(#"knife_loadout", &function_97bc2873, &function_5f7cac29);
    bot_action::register_weapon(#"launcher_freefire_t9", &function_3929fa65, &use_launcher);
    bot_action::register_weapon(#"launcher_standard_t9", &function_3929fa65, &use_launcher);
    bot_action::register_weapon(#"pistol_burst_t9", &function_6aa40bb4, &use_pistol);
    bot_action::register_weapon(#"pistol_fullauto_t9", &function_6aa40bb4, &use_pistol);
    bot_action::register_weapon(#"pistol_revolver_t9", &function_6aa40bb4, &use_pistol);
    bot_action::register_weapon(#"pistol_semiauto_t9", &function_6aa40bb4, &use_pistol);
    bot_action::register_weapon(#"shotgun_fullauto_t9", &function_408f0f07, &function_78135f4c);
    bot_action::register_weapon(#"shotgun_pump_t9", &function_408f0f07, &function_78135f4c);
    bot_action::register_weapon(#"shotgun_semiauto_t9", &function_408f0f07, &function_78135f4c);
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0x766703bc, Offset: 0xc80
// Size: 0x144
function private function_ece9035a() {
    bot_action::register_weapon(#"eq_molotov", &function_16906804, &function_84092214);
    bot_action::register_weapon(#"eq_sticky_grenade", &function_d3c685b8, &function_84092214);
    bot_action::register_weapon(#"frag_grenade", &function_22630da6, &function_84092214);
    bot_action::register_weapon(#"hatchet", &function_643065f9, &function_84092214);
    bot_action::register_weapon(#"satchel_charge", &function_66e1fe37, &function_84092214);
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0x8de9f10f, Offset: 0xdd0
// Size: 0x144
function private function_c7dfc94() {
    bot_action::register_weapon(#"hash_5453c9b880261bcb", &function_e105d8c8, &function_6bc8e929);
    bot_action::register_weapon(#"eq_slow_grenade", &function_8640f24, &function_6bc8e929);
    bot_action::register_weapon(#"hash_364914e1708cb629", &function_bd46948a, &function_6bc8e929);
    bot_action::register_weapon(#"nightingale", &function_66e1fe37, &function_6bc8e929);
    bot_action::register_weapon(#"willy_pete", &function_66e1fe37, &function_6bc8e929);
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0xf6448ba6, Offset: 0xf20
// Size: 0x204
function private function_1f3281d9() {
    bot_action::register_weapon(#"ability_smart_cover", &function_66e1fe37, &function_de73a533);
    bot_action::register_weapon(#"gadget_jammer", &function_c329e7cf, &function_de73a533);
    bot_action::register_weapon(#"gadget_supplypod", &function_86ce2c, &function_de73a533);
    bot_action::register_weapon(#"land_mine", &function_66e1fe37, &function_de73a533);
    bot_action::register_weapon(#"listening_device", &function_d6e71e28, &function_de73a533);
    bot_action::register_weapon(#"missile_turret", &function_5c276034, &function_de73a533);
    bot_action::register_weapon(#"tear_gas", &function_126a6787, &function_de73a533);
    bot_action::register_weapon(#"trophy_system", &function_69624ba2, &function_de73a533);
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0xf7b78c36, Offset: 0x1130
// Size: 0xbb4
function private function_d4db3361() {
    bot_action::register_weapon(#"ac130", &function_66e1fe37, &function_778e2491);
    bot_action::register_weapon(#"inventory_" + "ac130", &function_66e1fe37, &function_778e2491);
    bot_action::register_weapon(#"counteruav", &function_f023f6f9, &counteruav);
    bot_action::register_weapon(#"inventory_" + "counteruav", &function_f023f6f9, &counteruav);
    bot_action::register_weapon(#"chopper_gunner", &function_66e1fe37, &function_10b07ab6);
    bot_action::register_weapon(#"inventory_" + "chopper_gunner", &function_66e1fe37, &function_10b07ab6);
    bot_action::register_weapon(#"helicopter_comlink", &function_5f352eb0, &function_7943cde5);
    bot_action::register_weapon(#"inventory_" + "helicopter_comlink", &function_5f352eb0, &function_7943cde5);
    bot_action::register_weapon(#"helicopter_guard", &function_5f352eb0, &function_7943cde5);
    bot_action::register_weapon(#"inventory_" + "helicopter_guard", &function_5f352eb0, &function_7943cde5);
    bot_action::register_weapon(#"hero_annihilator", &function_43848868, &use_hero_annihilator);
    bot_action::register_weapon(#"inventory_" + "hero_annihilator", &function_43848868, &use_hero_annihilator);
    bot_action::register_weapon(#"hero_flamethrower", &function_66e1fe37, &function_2bbdd2b4);
    bot_action::register_weapon(#"inventory_" + "hero_flamethrower", &function_66e1fe37, &function_2bbdd2b4);
    bot_action::register_weapon(#"hero_pineapplegun", &function_43395ff9, &function_27ae97ef);
    bot_action::register_weapon(#"inventory_" + "hero_pineapplegun", &function_43395ff9, &function_27ae97ef);
    bot_action::register_weapon(#"hoverjet", &function_66e1fe37, &function_d0cdb00e);
    bot_action::register_weapon(#"inventory_" + "hoverjet", &function_66e1fe37, &function_d0cdb00e);
    bot_action::register_weapon(#"jetfighter", &function_8d7445b8, &function_9839161a);
    bot_action::register_weapon(#"inventory_" + "jetfighter", &function_8d7445b8, &function_9839161a);
    bot_action::register_weapon(#"napalm_strike", &function_f70eb03b, &napalm_strike);
    bot_action::register_weapon(#"inventory_" + "napalm_strike", &function_f70eb03b, &napalm_strike);
    bot_action::register_weapon(#"planemortar", &function_eb23222e, &planemortar);
    bot_action::register_weapon(#"inventory_" + "planemortar", &function_eb23222e, &planemortar);
    bot_action::register_weapon(#"recon_car", &function_66e1fe37, &function_84a16b0);
    bot_action::register_weapon(#"inventory_" + "recon_car", &function_66e1fe37, &function_84a16b0);
    bot_action::register_weapon(#"recon_plane", &function_14ccb855, &function_bdf61e8f);
    bot_action::register_weapon(#"inventory_" + "recon_plane", &function_14ccb855, &function_bdf61e8f);
    bot_action::register_weapon(#"remote_missile", &function_f1fb9968, &remote_missile);
    bot_action::register_weapon(#"inventory_" + "remote_missile", &function_f1fb9968, &remote_missile);
    bot_action::register_weapon(#"sig_bow_flame", &function_184e01c, &function_5d035c24);
    bot_action::register_weapon(#"inventory_" + "sig_bow_flame", &function_184e01c, &function_5d035c24);
    bot_action::register_weapon(#"sig_lmg", &function_fee832f, &function_397a1c0a);
    bot_action::register_weapon(#"inventory_" + "sig_lmg", &function_fee832f, &function_397a1c0a);
    bot_action::register_weapon(#"straferun", &function_25933177, &straferun);
    bot_action::register_weapon(#"inventory_" + "straferun", &function_25933177, &straferun);
    bot_action::register_weapon(#"supplydrop_marker", &function_66e1fe37, &function_69658e9b);
    bot_action::register_weapon(#"inventory_" + "supplydrop_marker", &function_66e1fe37, &function_69658e9b);
    bot_action::register_weapon(#"uav", &function_c5a0aa09, &uav);
    bot_action::register_weapon(#"inventory_" + "uav", &function_c5a0aa09, &uav);
    bot_action::register_weapon(#"ultimate_turret", &function_66e1fe37, &function_12b05f25);
    bot_action::register_weapon(#"inventory_" + "ultimate_turret", &function_66e1fe37, &function_12b05f25);
    bot_action::register_weapon(#"weapon_armor", &function_784440a3, &weapon_armor);
    bot_action::register_weapon(#"inventory_" + "weapon_armor", &function_784440a3, &weapon_armor);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x2977724d, Offset: 0x1cf0
// Size: 0x32
function private function_66e1fe37(actionparams) {
    /#
        actionparams.debug[actionparams.debug.size] = #"not implemented";
    #/
    return undefined;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x90f8a67e, Offset: 0x1d30
// Size: 0x92
function private function_319dfab4(actionparams) {
    if (!self function_d55b60f8(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 80, 90, 80);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x11182b51, Offset: 0x1dd0
// Size: 0x1ce
function private use_ar(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (!(self.bot.enemydist <= 200) && self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
                if (self function_d8b388a6()) {
                    self fire_weapon(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x60dbf9d9, Offset: 0x1fa8
// Size: 0x92
function private function_aadbe8c(actionparams) {
    if (!self function_d55b60f8(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 80, 90, 80);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xb4c15245, Offset: 0x2048
// Size: 0x1ce
function private use_lmg(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (!(self.bot.enemydist <= 200) && self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
                if (self function_d8b388a6()) {
                    self fire_weapon(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x5f829dd7, Offset: 0x2220
// Size: 0x92
function private function_183e848d(actionparams) {
    if (!self function_d55b60f8(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 80, 80, 80);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x77e37eed, Offset: 0x22c0
// Size: 0x1b6
function private use_tr(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
                if (self function_d8b388a6()) {
                    self fire_weapon(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x43a2bcd2, Offset: 0x2480
// Size: 0x92
function private function_c75d81ab(actionparams) {
    if (!self function_d55b60f8(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 60, 80, 90);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x4d30ed98, Offset: 0x2520
// Size: 0x1d6
function private use_sniper(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self playerads() >= 1 && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
                if (self function_d8b388a6()) {
                    self fire_weapon(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xaf37f96c, Offset: 0x2700
// Size: 0x92
function private function_b9557a8a(actionparams) {
    if (!self function_d55b60f8(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 80, 70, 60);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xea44f769, Offset: 0x27a0
// Size: 0x1ce
function private use_smg(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (!(self.bot.enemydist <= 200) && self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
                if (self function_d8b388a6()) {
                    self fire_weapon(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xc4c23f4e, Offset: 0x2978
// Size: 0x92
function private function_6aa40bb4(actionparams) {
    if (!self function_d55b60f8(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 70, 70, 70);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xd1abfa9b, Offset: 0x2a18
// Size: 0x1ce
function private use_pistol(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (!(self.bot.enemydist <= 200) && self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
                if (self function_d8b388a6()) {
                    self fire_weapon(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x61b1d403, Offset: 0x2bf0
// Size: 0x102
function private function_408f0f07(actionparams) {
    if (!self function_d55b60f8(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    weapon = actionparams.weapon;
    damage = self function_6b54ab21(weapon);
    if (damage <= 0) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_6100adb01aed83f8";
        #/
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 90, 70, 60);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xa02c2536, Offset: 0x2d00
// Size: 0x1ce
function private function_78135f4c(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (!(self.bot.enemydist <= 200) && self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
                if (self function_d8b388a6()) {
                    self fire_weapon(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xca6b1512, Offset: 0x2ed8
// Size: 0x1f4
function private function_3929fa65(actionparams) {
    if (!self function_d55b60f8(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    weapon = actionparams.weapon;
    target = self.enemy;
    if (isplayer(self.enemy) && self.enemy isinvehicle() && !self.enemy isremotecontrolling()) {
        target = self.enemy getvehicleoccupied();
    }
    if (weapon.lockontype == #"legacy single") {
        if (target_istarget(target)) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_1c1fadf51fa38d5f";
            #/
            return 91;
        }
    }
    if (isvehicle(target)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"vehicle enemy";
        #/
        return self function_4b1db2f8(actionparams, 80, 90, 90);
    }
    /#
        actionparams.debug[actionparams.debug.size] = #"hash_18db4acb1408239d";
    #/
    return 60;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x9e6a5e9d, Offset: 0x30d8
// Size: 0x386
function private use_launcher(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    var_677906a4 = weapon.explosionradius * 0.6;
    lockedflag = 1 << self getentitynumber();
    self function_185a3c39(weapon);
    while (true) {
        target = self.enemy;
        if (isplayer(self.enemy) && self.enemy isinvehicle() && !self.enemy isremotecontrolling()) {
            target = self.enemy getvehicleoccupied();
        }
        lockon = target_istarget(target) && weapon.lockontype != #"none";
        self function_bbef6e21();
        if (lockon) {
            self.bot.var_32d8dabe = undefined;
        } else {
            self function_411e397e();
        }
        if (self.bot.var_9931c7dc && self botgetlookdot() >= 0.766) {
            self bottapbutton(11);
            if (self.bot.enemyvisible && self playerads() >= 1 && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500) && !self isfiring()) {
                if (lockon) {
                    if (isdefined(self.stingertarget) && isdefined(self.stingertarget.locked_on) && self.stingertarget.locked_on & lockedflag) {
                        self bottapbutton(0);
                    }
                } else if (!(self.bot.enemydist <= var_677906a4)) {
                    if (self function_d8b388a6()) {
                        self fire_weapon(weapon);
                    }
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x34fd7047, Offset: 0x3468
// Size: 0x68
function private function_97bc2873(actionparams) {
    weapon = actionparams.weapon;
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    return 50;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xa5c7a6a2, Offset: 0x34d8
// Size: 0x8c
function private function_5f7cac29(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x9e2e736e, Offset: 0x3570
// Size: 0x1d2
function private function_e105d8c8(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    if (self function_64f2e29(actionparams) || self function_a469c9cd(actionparams)) {
        return undefined;
    }
    if (self.bot.enemydist <= 600) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_71800c4878bd026d";
        #/
        return undefined;
    }
    if (self.bot.enemyvisible) {
        if (!self function_754cc239(actionparams)) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_7ff8e322102305fd";
            #/
            return undefined;
        }
        actionparams.aimpoint = self.enemy.origin;
    } else {
        actionparams.aimpoint = self.enemylastseenpos;
    }
    if (!isdefined(actionparams.aimpoint)) {
        actionparams.aimpoint = self.enemylastseenpos;
    }
    if (!self function_4e17fb37(actionparams, 40) || !self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x1c4f7e63, Offset: 0x3750
// Size: 0x1e2
function private function_16906804(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    if (self function_64f2e29(actionparams) || self function_a469c9cd(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self.bot.enemydist <= weapon.explosionradius * 1.2) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_71800c4878bd026d";
        #/
        return undefined;
    }
    if (self.bot.enemyvisible) {
        if (!self function_754cc239(actionparams)) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_7ff8e322102305fd";
            #/
            return undefined;
        }
        actionparams.aimpoint = self.enemy.origin;
    } else {
        actionparams.aimpoint = self.enemylastseenpos;
    }
    if (!self function_4e17fb37(actionparams, 40) || !self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xbae4dd8a, Offset: 0x3940
// Size: 0x1ba
function private function_8640f24(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    if (self function_64f2e29(actionparams) || self function_a469c9cd(actionparams)) {
        return undefined;
    }
    if (self.bot.enemydist <= 600) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_71800c4878bd026d";
        #/
        return undefined;
    }
    if (self.bot.enemyvisible) {
        if (!self function_754cc239(actionparams)) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_7ff8e322102305fd";
            #/
            return undefined;
        }
        actionparams.aimpoint = self.enemy.origin;
    } else {
        actionparams.aimpoint = self.enemylastseenpos;
    }
    if (!self function_4e17fb37(actionparams, 40) || !self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xec1cf17c, Offset: 0x3b08
// Size: 0x1ba
function private function_d3c685b8(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    if (self function_a469c9cd(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self.bot.enemydist <= weapon.explosionradius * 0.6) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_71800c4878bd026d";
        #/
        return undefined;
    }
    if (self.bot.enemyvisible) {
        if (!self function_754cc239(actionparams)) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_7ff8e322102305fd";
            #/
            return undefined;
        }
        actionparams.aimpoint = undefined;
    } else {
        actionparams.aimpoint = self.enemylastseenpos;
    }
    if (!self function_4e17fb37(actionparams, 40) || !self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x2c0a1fdc, Offset: 0x3cd0
// Size: 0x196
function private function_bd46948a(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    healthratio = self.health / self.maxhealth;
    /#
        actionparams.debug[actionparams.debug.size] = #"hash_c90c30ea9fcad9d" + self.health + "<dev string:x38>" + self.maxhealth + "<dev string:x3d>" + string(healthratio);
    #/
    if (is_true(self.heal.enabled)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_79840b33c01531d9";
        #/
        return undefined;
    }
    if (healthratio > 0.7) {
        return undefined;
    }
    /#
        actionparams.debug[actionparams.debug.size] = #"hash_203858dc9db13ce9";
    #/
    if (self.bot.enemyvisible) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_7ff8e322102305fd";
        #/
        return undefined;
    }
    if (!self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x5cec842e, Offset: 0x3e70
// Size: 0x54
function private function_55d06cb0(*actionparams) {
    self.bot.var_e636e51e = gettime() + int(5 * 1000);
    self bottapbutton(15);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x5d2591c4, Offset: 0x3ed0
// Size: 0x1aa
function private function_22630da6(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    if (self function_64f2e29(actionparams) || self function_a469c9cd(actionparams)) {
        return undefined;
    }
    if (self.bot.enemyvisible) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_7ff8e322102305fd";
        #/
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self.bot.enemydist <= weapon.explosionradius * 0.6) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_71800c4878bd026d";
        #/
        return undefined;
    }
    actionparams.aimpoint = self.enemylastseenpos;
    if (!self function_4e17fb37(actionparams, 40) || !self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xc603a374, Offset: 0x4088
// Size: 0x152
function private function_643065f9(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (!self.bot.enemyvisible) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_53aa4f678b9a027c";
        #/
        return undefined;
    }
    if (self function_64f2e29(actionparams) || self function_a469c9cd(actionparams)) {
        return undefined;
    }
    if (self.bot.enemydist <= 200) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_71800c4878bd026d";
        #/
        return undefined;
    }
    if (!self function_754cc239(actionparams)) {
        return undefined;
    }
    if (!self function_4e17fb37(actionparams, 20) || !self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x72b7a0a8, Offset: 0x41e8
// Size: 0x8c
function private function_778e2491(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x5d4f5b1a, Offset: 0x4280
// Size: 0xd6
function private function_f023f6f9(actionparams) {
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams)) {
        return undefined;
    }
    if (isdefined(level.activecounteruavs) && isdefined(level.activecounteruavs[self.team]) && level.activecounteruavs[self.team] > 0) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_2edecc464042406a";
        #/
        return undefined;
    }
    if (!self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x4815265d, Offset: 0x4360
// Size: 0x3c
function private counteruav(actionparams) {
    weapon = actionparams.weapon;
    self function_c1515256(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xc6f2050f, Offset: 0x43a8
// Size: 0x8c
function private function_10b07ab6(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x91d9b345, Offset: 0x4440
// Size: 0x62
function private function_5f352eb0(actionparams) {
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xc8c17bf4, Offset: 0x44b0
// Size: 0x3c
function private function_7943cde5(actionparams) {
    weapon = actionparams.weapon;
    self function_c1515256(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xf8ba02f0, Offset: 0x44f8
// Size: 0x70
function private function_43848868(actionparams) {
    if (!self function_303bbccf(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 90, 80, 70) + 1;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x3a450834, Offset: 0x4570
// Size: 0x1ee
function private use_hero_annihilator(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_6b01cd20();
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self playerads() >= 1 && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500) && self function_d8b388a6()) {
                self fire_weapon(weapon);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x86d9d08, Offset: 0x4768
// Size: 0x10e
function private function_2bbdd2b4(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
            self fire_weapon(weapon);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x498ad016, Offset: 0x4880
// Size: 0x70
function private function_43395ff9(actionparams) {
    if (!self function_303bbccf(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 90, 90, 80) + 1;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x8c8500fd, Offset: 0x48f8
// Size: 0x296
function private function_27ae97ef(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    var_677906a4 = weapon.explosionradius * 0.6;
    self function_185a3c39(weapon);
    while (true) {
        self function_6b01cd20();
        self.bot.var_f50fa466 = weapon;
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (!(self.bot.enemydist <= 200) && self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (!(self.bot.enemydist <= var_677906a4) && self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500) && self function_d8b388a6()) {
                trace = self function_6e8a2d86(weapon, self getplayerangles());
                if (function_e63ee3e8(trace, self.bot.enemydist - 40)) {
                    self fire_weapon(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xbfa18ac2, Offset: 0x4b98
// Size: 0x2e6
function private function_d0cdb00e(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (!self function_a39f313c()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    enemies = function_f6f34851(self.team);
    targetlocations = [];
    foreach (enemy in enemies) {
        tpoint = getclosesttacpoint(enemy.origin);
        if (!isdefined(tpoint) || !isdefined(tpoint.ceilingheight) || tpoint.ceilingheight < 65534) {
            continue;
        }
        targetlocations[targetlocations.size] = tpoint.origin;
    }
    if (targetlocations.size <= 0) {
        targetlocations[0] = (0, 0, 0);
    }
    location = targetlocations[randomint(targetlocations.size)];
    location += (randomfloatrange(500 * -1, 500), randomfloatrange(500 * -1, 500), 0);
    self notify(#"confirm_location", {#position:location, #yaw:0});
    while (!self function_a39f313c() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x6870e49d, Offset: 0x4e88
// Size: 0x28e
function private function_8d7445b8(actionparams) {
    if (!isarray(level.var_500867a0)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_511cde69ac409b1b";
        #/
        return undefined;
    }
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams)) {
        return undefined;
    }
    targetfound = 0;
    time = gettime();
    foreach (streaks in level.var_500867a0) {
        if (!isarray(streaks)) {
            continue;
        }
        foreach (streak in streaks) {
            if (!isdefined(streak) || self.team == streak.team) {
                continue;
            }
            if (!isdefined(streak.killstreakendtime) || !isdefined(streak.birthtime) || time - streak.birthtime < 1500 || streak.killstreakendtime - time < 3000) {
                continue;
            }
            targetfound = 1;
            break;
        }
    }
    if (!targetfound) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_66f0e93a3c9b4252";
        #/
        return undefined;
    }
    if (!self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x430aba5, Offset: 0x5120
// Size: 0x3c
function private function_9839161a(actionparams) {
    weapon = actionparams.weapon;
    self function_c1515256(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xd4e6c4aa, Offset: 0x5168
// Size: 0xba
function private function_f70eb03b(actionparams) {
    weapon = actionparams.weapon;
    if (self getcurrentweapon() == weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_351eb9fe2e4cbe5d";
        #/
        return 100;
    }
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xdfcbd89d, Offset: 0x5230
// Size: 0x1de
function private napalm_strike(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    self.bot.var_6bea1d82 = 1;
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (!self function_a39f313c()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    wait 0.9;
    target = undefined;
    enemies = self function_67ca228b();
    if (enemies.size > 0) {
        target = enemies[randomint(enemies.size)].origin + (randomfloatrange(-250, 250), randomfloatrange(-250, 250), 0);
    } else {
        target = self function_d19a634f();
    }
    self notify(#"confirm_location", {#position:target, #yaw:randomint(360)});
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x662c90c0, Offset: 0x5418
// Size: 0xba
function private function_eb23222e(actionparams) {
    weapon = actionparams.weapon;
    if (self getcurrentweapon() == weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_351eb9fe2e4cbe5d";
        #/
        return 100;
    }
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x8e955247, Offset: 0x54e0
// Size: 0x210
function private planemortar(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    self.bot.var_6bea1d82 = 1;
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (!self function_a39f313c()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    wait 0.9;
    target = undefined;
    enemies = self function_67ca228b();
    if (enemies.size > 0) {
        target = enemies[randomint(enemies.size)].origin;
    } else {
        target = self function_d19a634f();
    }
    for (i = 0; i < 3; i++) {
        position = target + (randomfloatrange(-250, 250), randomfloatrange(-250, 250), 0);
        self notify(#"confirm_location", {#position:position, #yaw:0});
        wait 0.5;
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xc0a3cbaf, Offset: 0x56f8
// Size: 0x8c
function private function_84a16b0(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xaf00081e, Offset: 0x5790
// Size: 0x92
function private function_14ccb855(actionparams) {
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams) || self function_f338aefb(actionparams) || self function_82350d4c(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x7ae243, Offset: 0x5830
// Size: 0x3c
function private function_bdf61e8f(actionparams) {
    weapon = actionparams.weapon;
    self function_c1515256(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x5232265b, Offset: 0x5878
// Size: 0xba
function private function_f1fb9968(actionparams) {
    weapon = actionparams.weapon;
    if (self getcurrentweapon() == weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = #"in progress";
        #/
        return 100;
    }
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x65ae7ad3, Offset: 0x5940
// Size: 0x2d6
function private remote_missile(actionparams) {
    self endoncallback(&function_17d6fe21, #"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    self.bot.var_6bea1d82 = 1;
    weapon = actionparams.weapon;
    function_185a3c39(weapon);
    while (!isdefined(self.rocket)) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    target = undefined;
    while (isdefined(self.rocket) && self.rocket.targetname == #"remote_missile") {
        if (!isdefined(target) || !isalive(target)) {
            targets = [];
            players = function_f6f34851(self.team);
            foreach (player in players) {
                if (player hasperk(#"specialty_nokillstreakreticle") || is_true(player.ignoreme) || !bullettracepassed(player.origin + (0, 0, 60), player.origin + (0, 0, 1000), 0, player)) {
                    continue;
                }
                targets[targets.size] = player;
            }
            if (targets.size > 0) {
                target = targets[randomint(targets.size)];
            } else {
                target = undefined;
            }
            self.rocket missile_settarget(target);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xff13c71d, Offset: 0x5c20
// Size: 0x54
function private function_17d6fe21(*notifyhash) {
    if (isdefined(self.rocket) && self.rocket.targetname == #"remote_missile") {
        self.rocket missile_settarget(undefined);
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xc25317b, Offset: 0x5c80
// Size: 0x70
function private function_184e01c(actionparams) {
    if (!self function_303bbccf(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 90, 90, 80) + 1;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x9af7ce27, Offset: 0x5cf8
// Size: 0x306
function private function_5d035c24(actionparams) {
    self endoncallback(&function_5e217f4d, #"hash_1ae115949cd752c8");
    self endon(#"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_6b01cd20();
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (!(self.bot.enemydist <= 200) && self botgetlookdot() >= 0.766) {
                self bottapbutton(11);
            }
            if (self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500)) {
                if (self function_a39f313c()) {
                    if (!self attackbuttonpressed()) {
                        self.bot.chargetime = gettime() + int(0.25 * 1000);
                    }
                    self bottapbutton(0);
                }
                if (self.bot.enemyvisible && self attackbuttonpressed() && (!isdefined(self.bot.chargetime) || self.bot.chargetime <= gettime()) && self function_d8b388a6()) {
                    self botreleasebutton(0);
                }
            } else if (self attackbuttonpressed()) {
                self.bot.chargetime = undefined;
                self bottapbutton(49);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xb342040c, Offset: 0x6008
// Size: 0x44
function private function_5e217f4d(*notifyhash) {
    self.bot.chargetime = undefined;
    if (self attackbuttonpressed()) {
        self bottapbutton(49);
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xa9901174, Offset: 0x6058
// Size: 0x70
function private function_fee832f(actionparams) {
    if (!self function_303bbccf(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return self function_4b1db2f8(actionparams, 80, 90, 80) + 1;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xe1d7fe99, Offset: 0x60d0
// Size: 0x1be
function private function_397a1c0a(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        self function_6b01cd20();
        self function_bbef6e21();
        self function_411e397e();
        if (self.bot.var_9931c7dc) {
            if (!(self.bot.enemydist <= 200) && self botgetlookdot() >= 0.866) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self botgetlookdot() >= 0.965) {
                self fire_weapon(weapon);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xed2167d6, Offset: 0x6298
// Size: 0xba
function private function_25933177(actionparams) {
    weapon = actionparams.weapon;
    if (self getcurrentweapon() == weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_351eb9fe2e4cbe5d";
        #/
        return 100;
    }
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x2004de05, Offset: 0x6360
// Size: 0x1de
function private straferun(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    self.bot.var_6bea1d82 = 1;
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (!self function_a39f313c()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    wait 0.9;
    target = undefined;
    enemies = self function_67ca228b();
    if (enemies.size > 0) {
        target = enemies[randomint(enemies.size)].origin + (randomfloatrange(-250, 250), randomfloatrange(-250, 250), 0);
    } else {
        target = self function_d19a634f();
    }
    self notify(#"confirm_location", {#position:target, #yaw:randomint(360)});
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xab1efcfe, Offset: 0x6548
// Size: 0x1ae
function private function_69658e9b(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    point = isdefined(actionparams.point) ? actionparams.point : self function_1c8f36a4();
    while (true) {
        self botsetlookpoint(point);
        self bottapbutton(0);
        if (self function_a39f313c() && self botgetlookdot() > 0.99) {
            break;
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
    self waittill(#"hash_77f2882ff9140e86");
    while (self isfiring()) {
        self botsetlookpoint(point);
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0x4c003002, Offset: 0x6700
// Size: 0x42
function private function_1c8f36a4() {
    fwd = anglestoforward(self.angles);
    return self.origin + fwd * 200;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x1a16a3d2, Offset: 0x6750
// Size: 0x92
function private function_c5a0aa09(actionparams) {
    if (!self function_303bbccf(actionparams) || self bot_action::in_combat(actionparams) || self function_f338aefb(actionparams) || self function_82350d4c(actionparams) || !self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x43989374, Offset: 0x67f0
// Size: 0x3c
function private uav(actionparams) {
    weapon = actionparams.weapon;
    self function_c1515256(weapon);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x43f2d1bd, Offset: 0x6838
// Size: 0xa4
function private function_12b05f25(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    self bottapbutton(0);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xc315576b, Offset: 0x68e8
// Size: 0xee
function private function_784440a3(actionparams) {
    weapon = actionparams.weapon;
    if (self getcurrentweapon() == weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = #"in progress";
        #/
        return 100;
    }
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (self.combatstate != #"combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_5ff27b6b0a6d2c08";
        #/
        return undefined;
    }
    if (!self function_808ca6bb(actionparams)) {
        return undefined;
    }
    return 99;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x7e688759, Offset: 0x69e0
// Size: 0xa4
function private weapon_armor(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    self bottapbutton(0);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xf394510e, Offset: 0x6a90
// Size: 0x216
function private function_c329e7cf(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (self.bot.order !== #"capture" && self.bot.order !== #"defend") {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_6ef3b55c5d05427a";
        #/
        return undefined;
    }
    if (self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_b0e78729bd8dfce";
        #/
        return undefined;
    }
    ents = getentitiesinradius(self.origin, 1000, 4);
    weapon = actionparams.weapon;
    foreach (ent in ents) {
        if (ent.team == self.team && ent.item == weapon) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_4ba65c4749a07103" + getweaponname(weapon);
            #/
            return undefined;
        }
    }
    if (!self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x8fe93651, Offset: 0x6cb0
// Size: 0x102
function private function_86ce2c(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    goldenammo = self function_e8e1d88e();
    if (goldenammo > 0) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_51e16bdecd933178" + goldenammo;
        #/
        return undefined;
    }
    if (isdefined(self.bot.var_538135ed)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_1dff7a8b83fc563c";
        #/
        return undefined;
    }
    if (self bot_action::in_combat(actionparams) || !self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x627d7862, Offset: 0x6dc0
// Size: 0x216
function private function_d6e71e28(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (self.bot.order !== #"capture" && self.bot.order !== #"defend") {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_6ef3b55c5d05427a";
        #/
        return undefined;
    }
    if (self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_b0e78729bd8dfce";
        #/
        return undefined;
    }
    ents = getentitiesinradius(self.origin, 1000, 4);
    weapon = actionparams.weapon;
    foreach (ent in ents) {
        if (ent.team == self.team && ent.item == weapon) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_4ba65c4749a07103" + getweaponname(weapon);
            #/
            return undefined;
        }
    }
    if (!self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x99cd58a4, Offset: 0x6fe0
// Size: 0x18a
function private function_5c276034(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (!self.bot.enemyvisible && !self function_6faf985b()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"no enemy";
        #/
        return undefined;
    }
    target = self.enemy;
    if (isplayer(self.enemy) && self.enemy isinvehicle() && !self.enemy isremotecontrolling()) {
        target = self.enemy getvehicleoccupied();
    }
    if (!target_istarget(target)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_bdb94cf566c2704";
        #/
        return undefined;
    }
    if (self function_82350d4c(actionparams) || !self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0xb07f978f, Offset: 0x7178
// Size: 0x112
function private function_6faf985b() {
    if (!isdefined(self.enemy) || !isdefined(self.enemy.targetname) || is_true(self.enemy.leaving)) {
        return 0;
    }
    if (self.enemy.targetname != "uav" && self.enemy.targetname != "counteruav" && self.enemy.targetname != "chopper_gunner" && self.enemy.targetname != "ac130" && self.enemy.targetname != "hoverjet") {
        return 0;
    }
    return self cansee(self.enemy, 250);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x9ca80e73, Offset: 0x7298
// Size: 0x216
function private function_126a6787(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (self.bot.order !== #"capture" && self.bot.order !== #"defend") {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_6ef3b55c5d05427a";
        #/
        return undefined;
    }
    if (self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_b0e78729bd8dfce";
        #/
        return undefined;
    }
    ents = getentitiesinradius(self.origin, 1000, 4);
    weapon = actionparams.weapon;
    foreach (ent in ents) {
        if (ent.team == self.team && ent.item == weapon) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_4ba65c4749a07103" + getweaponname(weapon);
            #/
            return undefined;
        }
    }
    if (!self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xea5a5593, Offset: 0x74b8
// Size: 0x216
function private function_69624ba2(actionparams) {
    if (!self function_303bbccf(actionparams)) {
        return undefined;
    }
    if (self.bot.order !== #"capture" && self.bot.order !== #"defend") {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_6ef3b55c5d05427a";
        #/
        return undefined;
    }
    if (self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_b0e78729bd8dfce";
        #/
        return undefined;
    }
    ents = getentitiesinradius(self.origin, 1000, 4);
    weapon = actionparams.weapon;
    foreach (ent in ents) {
        if (ent.team == self.team && ent.item == weapon) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_4ba65c4749a07103" + getweaponname(weapon);
            #/
            return undefined;
        }
    }
    if (!self function_98a9dad4(actionparams)) {
        return undefined;
    }
    return 94;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x87000a5c, Offset: 0x76d8
// Size: 0x110
function private function_303bbccf(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    if (weapon.iscliponly) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_649eec90cdc06cdd" + clipammo + "<dev string:x38>" + weapon.clipsize;
        #/
    } else {
        stockammo = self getweaponammostock(weapon);
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_649eec90cdc06cdd" + clipammo + "<dev string:x38>" + weapon.clipsize + "<dev string:x44>" + stockammo;
        #/
    }
    return clipammo > 0;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x384599f5, Offset: 0x77f0
// Size: 0x108
function private function_d55b60f8(actionparams) {
    if (!self function_303bbccf(actionparams) || self bot_action::function_ebb8205b(actionparams) || self bot_action::function_a0b0f487(actionparams) || self bot_action::function_2c3ea0c6(actionparams) || self bot_action::in_vehicle(actionparams)) {
        return false;
    }
    if (!self weaponcyclingenabled()) {
        weapon = actionparams.weapon;
        if (weapon != self getcurrentweapon()) {
            /#
                actionparams.debug[actionparams.debug.size] = #"hash_4655fb464b842dfc";
            #/
            return false;
        }
    }
    return true;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x1ec9f973, Offset: 0x7900
// Size: 0x178
function private function_98a9dad4(actionparams) {
    if (!(!isdefined(self.bot.var_e636e51e) || self.bot.var_e636e51e <= gettime())) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_499c1441b9e70c21";
        #/
        return false;
    }
    if (self bot_action::function_a43bc7e2(actionparams) || self bot_action::just_spawned(actionparams) || self bot_action::flashed(actionparams) || self bot_action::function_ebb8205b(actionparams) || self bot_action::function_a0b0f487(actionparams) || self bot_action::function_2c3ea0c6(actionparams) || self bot_action::in_vehicle(actionparams) || self bot_action::function_ed7b2f42(actionparams)) {
        return false;
    }
    if (!self offhandweaponsenabled()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_6ac9b1d785eef92";
        #/
        return false;
    }
    return true;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x69186e3, Offset: 0x7a80
// Size: 0x218
function private function_808ca6bb(actionparams) {
    if (self bot_action::function_a43bc7e2(actionparams) || self bot_action::just_spawned(actionparams) || self bot_action::flashed(actionparams) || self bot_action::function_ebb8205b(actionparams) || self bot_action::function_a0b0f487(actionparams) || self bot_action::function_2c3ea0c6(actionparams) || self bot_action::in_vehicle(actionparams) || self bot_action::function_ed7b2f42(actionparams)) {
        return false;
    }
    weapon = actionparams.weapon;
    registered = 0;
    foreach (type, killstreak in level.killstreaks) {
        if (killstreak.weapon == weapon) {
            registered = 1;
            break;
        }
    }
    if (!registered) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_40fce486e054dde0";
        #/
        return false;
    }
    if (!self killstreakrules::iskillstreakallowed(type, self.team, 1)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_15c89d85f9320bf6";
        #/
        return false;
    }
    return true;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x3724e63c, Offset: 0x7ca0
// Size: 0x1e4
function private function_f338aefb(actionparams) {
    if (isdefined(level.activeuavs) && isdefined(level.activeuavs[self.team]) && level.activeuavs[self.team] > 0) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_36676f11c5573c1e";
        #/
        return true;
    }
    if (isdefined(level.var_eb10c6a7) && isdefined(level.var_eb10c6a7[self.team]) && level.var_eb10c6a7[self.team] > 0) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_3839215d605aaf2f";
        #/
        return true;
    }
    if (isdefined(level.activecounteruavs)) {
        foreach (team in level.teams) {
            if (team == self.team) {
                continue;
            }
            if (isdefined(level.activecounteruavs[team]) && level.activecounteruavs[team] > 0) {
                /#
                    actionparams.debug[actionparams.debug.size] = #"hash_669d47e05d0f549f";
                #/
                return true;
            }
        }
    }
    return false;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x21710e7c, Offset: 0x7e90
// Size: 0x104
function private function_82350d4c(actionparams) {
    if (isdefined(level.activecounteruavs)) {
        foreach (team in level.teams) {
            if (team == self.team) {
                continue;
            }
            if (isdefined(level.activecounteruavs[team]) && level.activecounteruavs[team] > 0) {
                /#
                    actionparams.debug[actionparams.debug.size] = #"hash_669d47e05d0f549f";
                #/
                return true;
            }
        }
    }
    return false;
}

// Namespace bot_weapons/bot_weapons
// Params 2, eflags: 0x4
// Checksum 0x4193680c, Offset: 0x7fa0
// Size: 0x178
function private function_4e17fb37(actionparams, hitradius) {
    weapon = actionparams.weapon;
    aimpoint = actionparams.aimpoint;
    if (!isdefined(aimpoint)) {
        if (!isdefined(self.enemy)) {
            return false;
        }
        aimpoint = self.enemy getcentroid();
    }
    aimangles = self botgetprojectileaimangles(weapon, aimpoint);
    if (!isdefined(aimangles)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_4861201ac3ea229e";
        #/
        return false;
    }
    trace = self function_6e8a2d86(weapon, aimangles.var_478aeacd);
    dist = distance2d(self.origin, aimpoint) - hitradius;
    if (!function_e63ee3e8(trace, dist)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_50c1f0722206aaa8";
        #/
        return false;
    }
    return true;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x15e63043, Offset: 0x8120
// Size: 0x8c
function private function_754cc239(actionparams) {
    if (self.bot.var_faa25d47 || !self.bot.var_e9ff4b76) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_74827205c9eaaffe";
        #/
        return false;
    }
    /#
        actionparams.debug[actionparams.debug.size] = #"hash_3e4e2bab6555c31b";
    #/
    return true;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x3d44b826, Offset: 0x81b8
// Size: 0xe8
function private function_64f2e29(actionparams) {
    if (!isdefined(self.enemy)) {
        return false;
    }
    if (isvehicle(self.enemy)) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_18edaf9b6eee19a1";
        #/
        return true;
    }
    if (isplayer(self.enemy) && self.enemy isinvehicle() && !self.enemy isremotecontrolling()) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_28145be29cdebb73";
        #/
        return true;
    }
    return false;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x700729f5, Offset: 0x82a8
// Size: 0x70
function private function_a469c9cd(actionparams) {
    if (isdefined(self.enemy) && self.enemy.classname == #"grenade") {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_495e9766dfcb4aa3";
        #/
        return true;
    }
    return false;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x8b4a0ceb, Offset: 0x8320
// Size: 0xa6
function private function_6b54ab21(weapon) {
    dist = self.bot.enemydist;
    if (weapon.weapclass == "spread" && dist > weapon.mindamagerange) {
        return 0;
    }
    damage = function_2cf16636(weapon, dist);
    multishotbasedamage = function_bfb63695(weapon, dist);
    return multishotbasedamage + damage * weapon.shotcount;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x8848d53b, Offset: 0x83d0
// Size: 0x74
function private min_damage(weapon) {
    damagevalues = weapon.damagevalues;
    var_89a5bdab = weapon.var_72960e43;
    damage = damagevalues[damagevalues.size - 1];
    multishotbasedamage = var_89a5bdab[var_89a5bdab.size - 1];
    return multishotbasedamage + damage;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xeb4ff64c, Offset: 0x8450
// Size: 0x4e
function private max_damage(weapon) {
    damage = weapon.damagevalues[0];
    multishotbasedamage = weapon.var_72960e43[0];
    return multishotbasedamage + damage * weapon.shotcount;
}

// Namespace bot_weapons/bot_weapons
// Params 4, eflags: 0x4
// Checksum 0x3f7a745d, Offset: 0x84a8
// Size: 0xdc
function private function_4b1db2f8(actionparams, var_f97fefd9, var_f7b379b8, var_edd1b764) {
    if (self.bot.enemydist <= 500) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_22d191cc118ae2f5";
        #/
        return var_f97fefd9;
    } else if (self.bot.enemydist <= 1500) {
        /#
            actionparams.debug[actionparams.debug.size] = #"hash_29c69b288d5c7dbc";
        #/
        return var_f7b379b8;
    }
    /#
        actionparams.debug[actionparams.debug.size] = #"hash_4b3f063cd1f54255";
    #/
    return var_edd1b764;
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0xc6743083, Offset: 0x8590
// Size: 0x132
function private function_67ca228b() {
    aliveenemies = function_f6f34851(self.team);
    enemies = [];
    foreach (enemy in aliveenemies) {
        if (enemy hasperk(#"hash_59dc70c4ee13d1b6")) {
            continue;
        }
        tpoint = getclosesttacpoint(enemy.origin);
        if (!isdefined(tpoint) || !isdefined(tpoint.ceilingheight) || tpoint.ceilingheight < 65534) {
            continue;
        }
        enemies[enemies.size] = enemy;
    }
    return enemies;
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0x645d548a, Offset: 0x86d0
// Size: 0x1ce
function private function_d19a634f() {
    var_ded51cc0 = function_548ca110();
    if (var_ded51cc0 > 1) {
        tries = 0;
        while (tries < 10) {
            tries++;
            id = randomintrange(1, var_ded51cc0);
            info = function_b507a336(id);
            if (info.tacpoints.size <= 0) {
                continue;
            }
            tacpoint = info.tacpoints[randomint(info.tacpoints.size)];
            if (distance2dsquared(self.origin, tacpoint.origin) < 500 * 500) {
                continue;
            }
            if (tacpoint.ceilingheight < 65534) {
                continue;
            }
            return tacpoint.origin;
        }
    }
    radius = randomintrange(500, 1500);
    yaw = randomint(320);
    return (radius * cos(yaw), radius * sin(yaw), self.origin[2]);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x95638544, Offset: 0x88a8
// Size: 0x62
function private function_9dfd5e88(trace) {
    if (!isdefined(self.enemy) || !isdefined(trace)) {
        return false;
    }
    var_d6e7a23f = trace[#"entity"];
    return isdefined(var_d6e7a23f) && var_d6e7a23f == self.enemy;
}

// Namespace bot_weapons/bot_weapons
// Params 2, eflags: 0x4
// Checksum 0xd3cf5765, Offset: 0x8918
// Size: 0x58
function private function_e5a76b54(trace, origin) {
    if (!isdefined(trace)) {
        return false;
    }
    distsq = distancesquared(trace[#"position"], origin);
    return distsq <= 100;
}

// Namespace bot_weapons/bot_weapons
// Params 2, eflags: 0x4
// Checksum 0xd3892da0, Offset: 0x8978
// Size: 0x50
function private function_e63ee3e8(trace, distance) {
    if (!isdefined(trace)) {
        return false;
    }
    return distance2d(self.origin, trace[#"position"]) >= distance;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x4f7d2eed, Offset: 0x89d0
// Size: 0x76
function private function_185a3c39(weapon) {
    while (self getcurrentweapon() != weapon) {
        if (!self isswitchingweapons()) {
            self botswitchtoweapon(weapon);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x185f8230, Offset: 0x8a50
// Size: 0x3c
function private function_c1515256(weapon) {
    self function_88128d60(weapon);
    self bottapbutton(85);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x9784029b, Offset: 0x8a98
// Size: 0x1dc
function private fire_weapon(weapon) {
    if (weapon.firetype == #"single shot" || weapon.firetype == #"burst") {
        if (self isfiring() || !(!isdefined(self.bot.var_51cee2ad) || self.bot.var_51cee2ad <= gettime())) {
            return;
        }
        if (weapon.firetype == #"single shot") {
            self.bot.var_51cee2ad = gettime() + int((isdefined(self.bot.difficulty.var_b489efb7) ? self.bot.difficulty.var_b489efb7 : 0) * 1000);
        } else if (weapon.firetype == #"burst") {
            self.bot.var_51cee2ad = gettime() + int((isdefined(self.bot.difficulty.burstdelay) ? self.bot.difficulty.burstdelay : 0) * 1000);
        }
    }
    self bottapbutton(0);
    if (weapon.dualwieldweapon != level.weaponnone) {
        self bottapbutton(24);
    }
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0x8efca8c3, Offset: 0x8c80
// Size: 0x58
function private function_6b01cd20() {
    if (self.bot.var_e8c84f98) {
        return;
    }
    self bot_action::clear();
    do {
        self waittill(#"hash_77f2882ff9140e86");
    } while (!self.bot.var_e8c84f98);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x7d187c37, Offset: 0x8ce0
// Size: 0x2c
function private function_84092214(actionparams) {
    self throw_offhand(actionparams, 14);
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xc14b99e8, Offset: 0x8d18
// Size: 0x2c
function private function_6bc8e929(actionparams) {
    self throw_offhand(actionparams, 15);
}

// Namespace bot_weapons/bot_weapons
// Params 2, eflags: 0x4
// Checksum 0xc5a412b5, Offset: 0x8d50
// Size: 0x266
function private throw_offhand(actionparams, var_dd95d559) {
    self endoncallback(&function_39cec272, #"hash_1ae115949cd752c8");
    self endon(#"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    self.bot.var_6bea1d82 = 1;
    weapon = actionparams.weapon;
    self.bot.var_f50fa466 = weapon;
    while (true) {
        self.bot.var_87751145 = actionparams.aimpoint;
        self function_e1e3b64c(0);
        while (!self function_d911b948() || !(self botgetlookdot() >= lerpfloat(0.996195, 0.999962, self.bot.enemydist / 500))) {
            if (self botgetlookdot() >= 0.866) {
                self bottapbutton(var_dd95d559);
            } else if (self isthrowinggrenade()) {
                self bottapbutton(49);
            }
            self waittill(#"hash_77f2882ff9140e86");
        }
        while (self function_d911b948() || self isthrowinggrenade()) {
            self waittill(#"hash_77f2882ff9140e86");
        }
        self.bot.var_e636e51e = gettime() + int(5 * 1000);
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x1b33b1c5, Offset: 0x8fc0
// Size: 0x6e
function private function_39cec272(*notifyhash) {
    self.bot.var_e636e51e = gettime() + int(5 * 1000);
    if (self function_d911b948()) {
        self bottapbutton(49);
    }
    self.throwinggrenade = 0;
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0x429b387a, Offset: 0x9038
// Size: 0x102
function private function_de73a533(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle");
    while (!self function_d911b948()) {
        self bottapbutton(70);
        self waittill(#"hash_77f2882ff9140e86");
    }
    while (self function_d911b948()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    self.bot.var_e636e51e = gettime() + int(5 * 1000);
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0xfcdcd434, Offset: 0x9148
// Size: 0x8e
function private function_bbef6e21() {
    if (!isdefined(self.bot.difficulty) || is_true(self.bot.difficulty.var_33be320f)) {
        return;
    }
    stop = self.bot.var_9931c7dc && self.bot.enemyvisible;
    self.bot.var_6bea1d82 = stop;
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0xf3fe873f, Offset: 0x91e0
// Size: 0x2aa
function private function_411e397e() {
    shoottime = isdefined(self.bot.difficulty.shoottime) ? self.bot.difficulty.shoottime : 0;
    if (shoottime <= 0) {
        return;
    }
    if (isdefined(self.enemy) && self.bot.lastenemy !== self.enemy) {
        self.bot.var_d70788cb = undefined;
        self.bot.shoottime = undefined;
        self.bot.var_32d8dabe = undefined;
    }
    if (!self.bot.var_9931c7dc || !self.bot.enemyvisible) {
        return;
    }
    if (!isdefined(self.bot.var_32d8dabe)) {
        self function_e1e3b64c(1);
    }
    if (!(!isdefined(self.bot.shoottime) || self.bot.shoottime <= gettime()) || !(self botgetlookdot() >= 0.766)) {
        return;
    }
    if (isdefined(self.bot.shoottime)) {
        self function_e1e3b64c(1);
    }
    delaytime = isdefined(self.bot.difficulty.var_d70788cb) ? self.bot.difficulty.var_d70788cb : 0;
    var_8a2cf681 = self function_7067eabd();
    if (var_8a2cf681 >= 2.5 || !(self.bot.enemydist <= var_8a2cf681 * 500)) {
        delaytime += self function_957aa281();
    }
    totaltime = delaytime + shoottime;
    self.bot.var_d70788cb = gettime() + int(delaytime * 1000);
    self.bot.shoottime = gettime() + int(totaltime * 1000);
}

// Namespace bot_weapons/bot_weapons
// Params 0, eflags: 0x4
// Checksum 0x7a0fc0cd, Offset: 0x9498
// Size: 0xac
function private function_d8b388a6() {
    if ((isdefined(self.bot.difficulty.shoottime) ? self.bot.difficulty.shoottime : 0) <= 0) {
        return true;
    }
    return (!isdefined(self.bot.var_d70788cb) || self.bot.var_d70788cb <= gettime()) && !(!isdefined(self.bot.shoottime) || self.bot.shoottime <= gettime());
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xa39e8517, Offset: 0x9550
// Size: 0x19c
function private function_e1e3b64c(currentweapon) {
    ymin = -10;
    ymax = 10;
    zmin = -10;
    zmax = 10;
    if (self function_9160a207(currentweapon)) {
        if (self.bot.enemyvisible && self function_e3b275f0(self.enemy, "j_head")) {
            self.bot.var_2d563ebf = "j_head";
        } else {
            self.bot.var_2d563ebf = undefined;
        }
    } else {
        self.bot.var_2d563ebf = undefined;
        if (randomint(2) > 0) {
            ymin = 18;
            ymax = 30;
        } else {
            ymin = -30;
            ymax = -18;
        }
        zmin = 10;
        zmax = 20;
    }
    y = randomfloatrange(ymin, ymax);
    z = randomfloatrange(zmin, zmax);
    self.bot.var_32d8dabe = (0, y, z);
    self namespace_87549638::think();
}

// Namespace bot_weapons/bot_weapons
// Params 1, eflags: 0x4
// Checksum 0xb42dd93a, Offset: 0x96f8
// Size: 0x290
function private function_9160a207(currentweapon) {
    if (!isdefined(self.bot.difficulty)) {
        return true;
    }
    var_f519fbc6 = isdefined(self.bot.difficulty.var_d20ff29c) ? self.bot.difficulty.var_d20ff29c : 0;
    if (currentweapon && !(self.bot.enemydist <= 200)) {
        if (!(self.bot.enemydist <= 500)) {
            var_8a2cf681 = self function_7067eabd();
            mindist = var_8a2cf681 * 500;
            var_e99f12e5 = self.bot.enemydist - mindist;
            var_f4b40c21 = var_8a2cf681 * 2500 - mindist;
            var_66a04f11 = isdefined(self.bot.difficulty.var_65a25108) ? self.bot.difficulty.var_65a25108 : 0;
            var_7e2f0732 = isdefined(self.bot.difficulty.var_e0e4be1b) ? self.bot.difficulty.var_e0e4be1b : 0;
            falloff = lerpfloat(var_66a04f11, var_7e2f0732, var_e99f12e5 / var_f4b40c21);
            var_f519fbc6 *= falloff;
        }
        if (self playerads() < 1) {
            var_f519fbc6 *= isdefined(self.bot.difficulty.var_363a4bcd) ? self.bot.difficulty.var_363a4bcd : 0;
        }
    }
    /#
        self.bot.var_9e5aaf8d = var_f519fbc6;
    #/
    if (var_f519fbc6 <= 0) {
        return false;
    }
    return randomfloat(100) < var_f519fbc6;
}

// Namespace bot_weapons/bot_weapons
// Params 2, eflags: 0x4
// Checksum 0x239169ee, Offset: 0x9990
// Size: 0xc8
function private function_e3b275f0(enemy, var_755136c1) {
    if (!isdefined(enemy gettagorigin(var_755136c1))) {
        return false;
    }
    var_6e53ed46 = isdefined(self.bot.difficulty.var_fa680c5e) ? self.bot.difficulty.var_fa680c5e : 0;
    if (var_6e53ed46 <= 0) {
        return false;
    } else if (var_6e53ed46 >= 100) {
        return true;
    }
    return randomfloat(100) < var_6e53ed46;
}

