#using script_4e44ad88a2b0f559;
#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace namespace_d9f3dd47;

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x1 linked
// Checksum 0x6a0441e3, Offset: 0x290
// Size: 0xaa
function function_70a657d8() {
    if (!isdefined(level.gametype)) {
        return;
    }
    switch (level.gametype) {
    case #"oic":
        function_978e521e();
        break;
    case #"sas":
        function_33e887a4();
        break;
    default:
        function_9cefb01();
        break;
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0x691f00a7, Offset: 0x348
// Size: 0x64
function private function_9cefb01() {
    function_ce850bf4();
    function_c50262c4();
    function_ece9035a();
    function_c7dfc94();
    function_1f3281d9();
    function_d4db3361();
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0xaca57870, Offset: 0x3b8
// Size: 0x44
function private function_978e521e() {
    bot_action::register_weapon(level.var_bf82f6b0.name, &function_6aa40bb4, &function_f69e4d87);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x408
// Size: 0x4
function private function_33e887a4() {
    
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0xb7225f, Offset: 0x418
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
    bot_action::register_weapon(#"lmg_accurate_t9", &function_aadbe8c, &function_82ebbce);
    bot_action::register_weapon(#"lmg_fastfire_t9", &function_aadbe8c, &function_82ebbce);
    bot_action::register_weapon(#"lmg_light_t9", &function_aadbe8c, &function_82ebbce);
    bot_action::register_weapon(#"lmg_slowfire_t9", &function_aadbe8c, &function_82ebbce);
    bot_action::register_weapon(#"smg_accurate_t9", &function_b9557a8a, &function_b3992b0);
    bot_action::register_weapon(#"smg_burst_t9", &function_b9557a8a, &function_b3992b0);
    bot_action::register_weapon(#"smg_capacity_t9", &function_b9557a8a, &function_b3992b0);
    bot_action::register_weapon(#"smg_fastfire_t9", &function_b9557a8a, &function_b3992b0);
    bot_action::register_weapon(#"smg_handling_t9", &function_b9557a8a, &function_b3992b0);
    bot_action::register_weapon(#"smg_heavy_t9", &function_b9557a8a, &function_b3992b0);
    bot_action::register_weapon(#"smg_spray_t9", &function_b9557a8a, &function_b3992b0);
    bot_action::register_weapon(#"smg_standard_t9", &function_b9557a8a, &function_b3992b0);
    bot_action::register_weapon(#"sniper_accurate_t9", &function_c75d81ab, &function_d6921803);
    bot_action::register_weapon(#"sniper_cannon_t9", &function_c75d81ab, &function_d6921803);
    bot_action::register_weapon(#"sniper_powersemi_t9", &function_c75d81ab, &function_d6921803);
    bot_action::register_weapon(#"sniper_quickscope_t9", &function_c75d81ab, &function_d6921803);
    bot_action::register_weapon(#"sniper_standard_t9", &function_c75d81ab, &function_d6921803);
    bot_action::register_weapon(#"tr_damagesemi_t9", &function_183e848d, &use_tr);
    bot_action::register_weapon(#"tr_fastburst_t9", &function_183e848d, &use_tr);
    bot_action::register_weapon(#"tr_longburst_t9", &function_183e848d, &use_tr);
    bot_action::register_weapon(#"tr_powerburst_t9", &function_183e848d, &use_tr);
    bot_action::register_weapon(#"tr_precisionsemi_t9", &function_183e848d, &use_tr);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0x76ba8b9d, Offset: 0xba8
// Size: 0x284
function private function_c50262c4() {
    bot_action::register_weapon(#"knife_loadout", &function_97bc2873, &function_5f7cac29);
    bot_action::register_weapon(#"launcher_freefire_t9", &function_291cd9ab, &function_b81aa700);
    bot_action::register_weapon(#"launcher_standard_t9", &function_291cd9ab, &function_b81aa700);
    bot_action::register_weapon(#"pistol_burst_t9", &function_6aa40bb4, &function_3f4d56d1);
    bot_action::register_weapon(#"pistol_fullauto_t9", &function_6aa40bb4, &function_3f4d56d1);
    bot_action::register_weapon(#"pistol_revolver_t9", &function_6aa40bb4, &function_3f4d56d1);
    bot_action::register_weapon(#"pistol_semiauto_t9", &function_6aa40bb4, &function_3f4d56d1);
    bot_action::register_weapon(#"shotgun_fullauto_t9", &function_408f0f07, &function_78135f4c);
    bot_action::register_weapon(#"shotgun_pump_t9", &function_408f0f07, &function_78135f4c);
    bot_action::register_weapon(#"shotgun_semiauto_t9", &function_408f0f07, &function_78135f4c);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0xaf6126b8, Offset: 0xe38
// Size: 0x144
function private function_ece9035a() {
    bot_action::register_weapon(#"eq_molotov", &function_66e1fe37, &throw_molotov);
    bot_action::register_weapon(#"eq_sticky_grenade", &function_66e1fe37, &function_ec1cc88e);
    bot_action::register_weapon(#"frag_grenade", &function_22630da6, &function_e9a4be74);
    bot_action::register_weapon(#"hatchet", &function_66e1fe37, &function_b6ef3089);
    bot_action::register_weapon(#"satchel_charge", &function_66e1fe37, &function_f10db563);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0xa760e161, Offset: 0xf88
// Size: 0x104
function private function_c7dfc94() {
    bot_action::register_weapon(#"hash_5453c9b880261bcb", &function_66e1fe37, &function_930c3fac);
    bot_action::register_weapon(#"eq_slow_grenade", &function_66e1fe37, &function_b9fb5915);
    bot_action::register_weapon(#"hash_364914e1708cb629", &function_66e1fe37, &function_b2a592cd);
    bot_action::register_weapon(#"willy_pete", &function_66e1fe37, &function_c3e34352);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0x4a3c2b30, Offset: 0x1098
// Size: 0x204
function private function_1f3281d9() {
    bot_action::register_weapon(#"ability_smart_cover", &function_66e1fe37, &function_8eb027ee);
    bot_action::register_weapon(#"gadget_jammer", &function_66e1fe37, &function_defcd71a);
    bot_action::register_weapon(#"gadget_supplypod", &function_66e1fe37, &function_bef2b171);
    bot_action::register_weapon(#"hash_2b9efbad11308e02", &function_66e1fe37, &function_23d9a53c);
    bot_action::register_weapon(#"listening_device", &function_66e1fe37, &function_5c902535);
    bot_action::register_weapon(#"missile_turret", &function_66e1fe37, &function_bd51bffc);
    bot_action::register_weapon(#"tear_gas", &function_66e1fe37, &function_aeb691ff);
    bot_action::register_weapon(#"trophy_system", &function_66e1fe37, &function_2376e275);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0x777e7abd, Offset: 0x12a8
// Size: 0xbb4
function private function_d4db3361() {
    bot_action::register_weapon(#"ac130", &function_a1364416, &function_342393ee);
    bot_action::register_weapon(#"inventory_" + "ac130", &function_a1364416, &function_342393ee);
    bot_action::register_weapon(#"counteruav", &function_8268ab89, &function_dd83d8f1);
    bot_action::register_weapon(#"inventory_" + "counteruav", &function_8268ab89, &function_dd83d8f1);
    bot_action::register_weapon(#"chopper_gunner", &function_6c5006a6, &function_80fd313c);
    bot_action::register_weapon(#"inventory_" + "chopper_gunner", &function_6c5006a6, &function_80fd313c);
    bot_action::register_weapon(#"helicopter_comlink", &function_df289ae1, &function_18f5a85);
    bot_action::register_weapon(#"inventory_" + "helicopter_comlink", &function_df289ae1, &function_18f5a85);
    bot_action::register_weapon(#"helicopter_guard", &function_df289ae1, &function_18f5a85);
    bot_action::register_weapon(#"inventory_" + "helicopter_guard", &function_df289ae1, &function_18f5a85);
    bot_action::register_weapon(#"hero_annihilator", &function_3e277793, &function_f69e4d87);
    bot_action::register_weapon(#"inventory_" + "hero_annihilator", &function_3e277793, &function_f69e4d87);
    bot_action::register_weapon(#"hero_flamethrower", &function_b90ad6ab, &function_4cbb2225);
    bot_action::register_weapon(#"inventory_" + "hero_flamethrower", &function_b90ad6ab, &function_4cbb2225);
    bot_action::register_weapon(#"hero_pineapplegun", &function_9fe7dc8d, &function_f2c37dfe);
    bot_action::register_weapon(#"inventory_" + "hero_pineapplegun", &function_9fe7dc8d, &function_f2c37dfe);
    bot_action::register_weapon(#"hoverjet", &function_9782a4ec, &function_d0cdb00e);
    bot_action::register_weapon(#"inventory_" + "hoverjet", &function_9782a4ec, &function_d0cdb00e);
    bot_action::register_weapon(#"jetfighter", &function_8d7445b8, &function_9839161a);
    bot_action::register_weapon(#"inventory_" + "jetfighter", &function_8d7445b8, &function_9839161a);
    bot_action::register_weapon(#"napalm_strike", &function_f70eb03b, &function_d196f6fe);
    bot_action::register_weapon(#"inventory_" + "napalm_strike", &function_f70eb03b, &function_d196f6fe);
    bot_action::register_weapon(#"planemortar", &function_eebed729, &function_daacd60e);
    bot_action::register_weapon(#"inventory_" + "planemortar", &function_eebed729, &function_daacd60e);
    bot_action::register_weapon(#"recon_car", &function_f8a2b8bb, &function_d608e1e5);
    bot_action::register_weapon(#"inventory_" + "recon_car", &function_f8a2b8bb, &function_d608e1e5);
    bot_action::register_weapon(#"recon_plane", &function_8c614f92, &function_8f8c4099);
    bot_action::register_weapon(#"inventory_" + "recon_plane", &function_8c614f92, &function_8f8c4099);
    bot_action::register_weapon(#"remote_missile", &function_f1fb9968, &function_38a474ba);
    bot_action::register_weapon(#"inventory_" + "remote_missile", &function_f1fb9968, &function_38a474ba);
    bot_action::register_weapon(#"sig_bow_flame", &function_e3c2c9df, &function_330a4859);
    bot_action::register_weapon(#"inventory_" + "sig_bow_flame", &function_e3c2c9df, &function_330a4859);
    bot_action::register_weapon(#"sig_lmg", &function_87e7fa1d, &function_4fe38a9a);
    bot_action::register_weapon(#"inventory_" + "sig_lmg", &function_87e7fa1d, &function_4fe38a9a);
    bot_action::register_weapon(#"straferun", &function_25933177, &function_443e6bac);
    bot_action::register_weapon(#"inventory_" + "straferun", &function_25933177, &function_443e6bac);
    bot_action::register_weapon(#"supplydrop_marker", &function_4bc0c239, &function_69658e9b);
    bot_action::register_weapon(#"inventory_" + "supplydrop_marker", &function_4bc0c239, &function_69658e9b);
    bot_action::register_weapon(#"uav", &function_c5a0aa09, &function_feadf846);
    bot_action::register_weapon(#"inventory_" + "uav", &function_c5a0aa09, &function_feadf846);
    bot_action::register_weapon(#"ultimate_turret", &function_6f837b80, &function_5a122360);
    bot_action::register_weapon(#"inventory_" + "ultimate_turret", &function_6f837b80, &function_5a122360);
    bot_action::register_weapon(#"weapon_armor", &function_66e1fe37, &use_armor);
    bot_action::register_weapon(#"inventory_" + "weapon_armor", &function_66e1fe37, &use_armor);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x4
// Checksum 0xea18355d, Offset: 0x1e68
// Size: 0x44
function private function_f064534d() {
    bot_action::register_weapon(#"hash_788c96e19cc7a46e", &function_d65a66c1, &function_dd653fb);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x35faff26, Offset: 0x1eb8
// Size: 0x2e
function private function_66e1fe37(actionparams) {
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x38>";
    #/
    return undefined;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x713fa662, Offset: 0x1ef0
// Size: 0x142
function private function_319dfab4(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize + "<dev string:x5a>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (clipammo > 0) {
        return self function_6b54ab21(weapon);
    }
    return self min_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x55508ef5, Offset: 0x2040
// Size: 0x196
function private use_ar(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self.bot.var_9931c7dc) {
            if (self bot::function_12b52153()) {
                if (self.bot.enemyvisible && self namespace_87549638::function_df48dc35()) {
                    self function_e243333d(weapon);
                }
            } else if (self namespace_87549638::function_16245ece()) {
                self bottapbutton(11);
                if (self.bot.enemyvisible && self namespace_87549638::function_a231de5d()) {
                    self function_e243333d(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x1b515b88, Offset: 0x21e0
// Size: 0x16a
function private function_aadbe8c(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize + "<dev string:x5a>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return undefined;
    }
    if (self.combatstate != "combat_state_in_combat" && self.combatstate != "combat_state_has_visible_enemy") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x6d>";
        #/
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    return self function_6b54ab21(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xf2410ec5, Offset: 0x2358
// Size: 0x196
function private function_82ebbce(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self.bot.var_9931c7dc) {
            if (self bot::function_12b52153()) {
                if (self.bot.enemyvisible && self namespace_87549638::function_df48dc35()) {
                    self function_e243333d(weapon);
                }
            } else if (namespace_87549638::function_16245ece()) {
                self bottapbutton(11);
                if (self.bot.enemyvisible && self namespace_87549638::function_a231de5d()) {
                    self function_e243333d(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x476b340f, Offset: 0x24f8
// Size: 0x142
function private function_183e848d(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize + "<dev string:x5a>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (clipammo > 0) {
        return self function_6b54ab21(weapon);
    }
    return self min_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x6e12179, Offset: 0x2648
// Size: 0x13e
function private use_tr(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self.bot.var_9931c7dc) {
            if (self namespace_87549638::function_16245ece()) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && namespace_87549638::function_a231de5d()) {
                self function_e243333d(weapon);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x1099bf3c, Offset: 0x2790
// Size: 0x142
function private function_c75d81ab(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize + "<dev string:x5a>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (clipammo > 0) {
        return self function_6b54ab21(weapon);
    }
    return self min_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x3630264a, Offset: 0x28e0
// Size: 0x15e
function private function_d6921803(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self.bot.var_9931c7dc) {
            if (namespace_87549638::function_16245ece()) {
                self bottapbutton(11);
            }
            if (self.bot.enemyvisible && self playerads() >= 1 && namespace_87549638::function_a231de5d()) {
                self function_e243333d(weapon);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xfc2b9853, Offset: 0x2a48
// Size: 0x142
function private function_b9557a8a(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize + "<dev string:x5a>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (clipammo > 0) {
        return self function_6b54ab21(weapon);
    }
    return self min_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x710d79ee, Offset: 0x2b98
// Size: 0x196
function private function_b3992b0(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self.bot.var_9931c7dc) {
            if (self bot::function_12b52153()) {
                if (self.bot.enemyvisible && self namespace_87549638::function_df48dc35()) {
                    self function_e243333d(weapon);
                }
            } else if (namespace_87549638::function_16245ece()) {
                self bottapbutton(11);
                if (self.bot.enemyvisible && self namespace_87549638::function_a231de5d()) {
                    self function_e243333d(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe36228a2, Offset: 0x2d38
// Size: 0x142
function private function_6aa40bb4(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize + "<dev string:x5a>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (clipammo > 0) {
        return self function_6b54ab21(weapon);
    }
    return self min_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xf988905c, Offset: 0x2e88
// Size: 0x196
function private function_3f4d56d1(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self.bot.var_9931c7dc) {
            if (self bot::function_12b52153()) {
                if (self.bot.enemyvisible && self namespace_87549638::function_df48dc35()) {
                    self function_e243333d(weapon);
                }
            } else if (namespace_87549638::function_16245ece()) {
                self bottapbutton(11);
                if (self.bot.enemyvisible && self namespace_87549638::function_a231de5d()) {
                    self function_e243333d(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xbba33894, Offset: 0x3028
// Size: 0x17a
function private function_408f0f07(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize + "<dev string:x5a>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    damage = self function_6b54ab21(weapon);
    if (damage <= 0) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x7e>";
        #/
        return undefined;
    }
    if (clipammo > 0) {
        return damage;
    }
    return self min_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x3f406ef7, Offset: 0x31b0
// Size: 0x196
function private function_78135f4c(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self.bot.var_9931c7dc) {
            if (self bot::function_12b52153()) {
                if (self.bot.enemyvisible && self namespace_87549638::function_df48dc35()) {
                    self function_e243333d(weapon);
                }
            } else if (namespace_87549638::function_16245ece()) {
                self bottapbutton(11);
                if (self.bot.enemyvisible && self namespace_87549638::function_a231de5d()) {
                    self function_e243333d(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x97b828da, Offset: 0x3350
// Size: 0x156
function private function_291cd9ab(actionparams) {
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize + "<dev string:x5a>" + stockammo;
    #/
    if (clipammo <= 0 && stockammo <= 0) {
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (self.bot.enemydist < weapon.explosionradius * 3) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x8e>";
        #/
        return undefined;
    }
    return weapon.explosionouterdamage;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xda081675, Offset: 0x34b0
// Size: 0x166
function private function_b81aa700(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self.bot.var_9931c7dc && self namespace_87549638::function_16245ece()) {
            self bottapbutton(11);
            if (self.bot.enemyvisible && self playerads() >= 1 && self namespace_87549638::function_a231de5d()) {
                self function_e243333d(weapon);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x16f95bca, Offset: 0x3620
// Size: 0xbe
function private function_97bc2873(actionparams) {
    weapon = actionparams.weapon;
    target = self.enemy;
    if (!self.bot.enemyvisible) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (self.bot.enemydist > weapon.var_bfbec33f * 2) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:xac>";
        #/
        return undefined;
    }
    return weapon.meleedamage;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xa8f70752, Offset: 0x36e8
// Size: 0x9c
function private function_5f7cac29(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xb9fd7e66, Offset: 0x3790
// Size: 0x242
function private function_d65a66c1(actionparams) {
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:xcd>" + self.health + "<dev string:x55>" + self.maxhealth;
    #/
    healthratio = self.health / self.maxhealth;
    if (healthratio >= 1) {
        return undefined;
    }
    if (!self function_f2d612c5(actionparams)) {
        return undefined;
    }
    if (!self offhandweaponsenabled()) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:xd9>";
        #/
        return undefined;
    }
    if (is_true(self.heal.enabled)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:xf5>";
        #/
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self function_55acff10() && self getcurrentoffhand() == weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x107>";
        #/
        return undefined;
    }
    if (self getweaponammoclip(weapon) <= 0) {
        slot = self gadgetgetslot(weapon);
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x111>" + self gadgetpowerget(slot) + "<dev string:x122>";
        #/
        return undefined;
    }
    if (healthratio > 0.7) {
        return (100 * (1 - healthratio));
    }
    return 100 * healthratio;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xa7d4a33d, Offset: 0x39e0
// Size: 0x24
function private function_dd653fb(*actionparams) {
    self bottapbutton(15);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe0dc8800, Offset: 0x3a10
// Size: 0x8c
function private function_930c3fac(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(15);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xef56e1a9, Offset: 0x3aa8
// Size: 0x8c
function private throw_molotov(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(14);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x17a2ec8c, Offset: 0x3b40
// Size: 0x8c
function private function_b9fb5915(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(15);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x127f5c3d, Offset: 0x3bd8
// Size: 0x8c
function private function_ec1cc88e(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(14);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xd7e135b6, Offset: 0x3c70
// Size: 0x24
function private function_b2a592cd(*actionparams) {
    self bottapbutton(15);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x15661ba7, Offset: 0x3ca0
// Size: 0x2a2
function private function_22630da6(actionparams) {
    if (!self function_c29dcb98(actionparams)) {
        return undefined;
    }
    if (self.goalforced) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x127>";
        #/
        return undefined;
    }
    weapon = actionparams.weapon;
    clipammo = self getweaponammoclip(weapon);
    /#
        actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo;
    #/
    if (clipammo <= 0) {
        return undefined;
    }
    if (self.bot.enemyvisible) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x136>";
        #/
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (!self.bot.var_9931c7dc) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x147>";
        #/
        return undefined;
    }
    if (self.bot.enemydist < weapon.explosionradius * 3) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x8e>";
        #/
        return undefined;
    }
    var_94a7f067 = self.enemylastseenpos;
    aimangles = self botgetprojectileaimangles(weapon, var_94a7f067);
    if (!isdefined(aimangles)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x161>";
        #/
        return undefined;
    }
    trace = self function_6e8a2d86(weapon, aimangles.var_478aeacd);
    if (!function_6bdb18b7(trace, var_94a7f067)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x171>";
        #/
        return undefined;
    }
    actionparams.var_94a7f067 = var_94a7f067;
    return weapon.explosionouterdamage;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x82bc66f0, Offset: 0x3f50
// Size: 0x1a6
function private function_e9a4be74(actionparams) {
    self endoncallback(&function_a91bdeef, #"hash_1ae115949cd752c8");
    self endon(#"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    var_94a7f067 = actionparams.var_94a7f067;
    self bot_position::hold();
    self namespace_87549638::projectile_weapon(weapon);
    self namespace_87549638::function_aa7316c1(var_94a7f067);
    self namespace_87549638::think();
    while (true) {
        if (!self isthrowinggrenade() && self namespace_87549638::function_df48dc35()) {
            if (!self function_d911b948() || !self namespace_87549638::function_6e1ecc98()) {
                self bottapbutton(14);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x7b0500a2, Offset: 0x4100
// Size: 0x3c
function private function_a91bdeef(*notifyhash) {
    if (self isthrowinggrenade()) {
        self bottapbutton(49);
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x8abd2170, Offset: 0x4148
// Size: 0x8c
function private function_b6ef3089(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(14);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xdc6a1d1, Offset: 0x41e0
// Size: 0x24
function private function_f10db563(*actionparams) {
    self bottapbutton(14);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe3ab347c, Offset: 0x4210
// Size: 0x8c
function private function_c3e34352(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(15);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x4901a60f, Offset: 0x42a8
// Size: 0xb8
function private function_a1364416(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy" || self.combatstate == "combat_state_aware_of_enemies") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x18e>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xcc555b41, Offset: 0x4368
// Size: 0x9c
function private function_342393ee(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x3b65e0c5, Offset: 0x4410
// Size: 0xa0
function private function_8268ab89(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1a0>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x890971b1, Offset: 0x44b8
// Size: 0x34
function private function_dd83d8f1(actionparams) {
    weapon = actionparams.weapon;
    function_c1515256(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xb4466542, Offset: 0x44f8
// Size: 0xb8
function private function_6c5006a6(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy" || self.combatstate == "combat_state_aware_of_enemies") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x18e>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x4b07b576, Offset: 0x45b8
// Size: 0x9c
function private function_80fd313c(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xb9bce844, Offset: 0x4660
// Size: 0xa0
function private function_df289ae1(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x53bb95f4, Offset: 0x4708
// Size: 0x34
function private function_18f5a85(actionparams) {
    weapon = actionparams.weapon;
    function_c1515256(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x591e0843, Offset: 0x4748
// Size: 0xf2
function private function_3e277793(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    currentweapon = self getcurrentweapon();
    if (self.combatstate == "combat_state_in_combat" && currentweapon != weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1c6>";
        #/
        return undefined;
    }
    return max_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x6178d2d6, Offset: 0x4848
// Size: 0x1a6
function private function_f69e4d87(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self bot::function_12b52153()) {
            if (self.bot.enemyvisible && self namespace_87549638::function_a231de5d()) {
                self function_e243333d(weapon);
            }
        } else if (self namespace_87549638::function_16245ece()) {
            self bottapbutton(11);
            if (self.bot.enemyvisible && self playerads() >= 1 && self namespace_87549638::function_a231de5d()) {
                self function_e243333d(weapon);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xed93df28, Offset: 0x49f8
// Size: 0x152
function private function_b90ad6ab(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    currentweapon = self getcurrentweapon();
    if (self.combatstate == "combat_state_in_combat" && currentweapon != weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1c6>";
        #/
        return undefined;
    }
    if (self.combatstate != "combat_state_idle" && self.bot.var_e8c84f98) {
        if (self.bot.enemydist > 500) {
            /#
                actionparams.debug[actionparams.debug.size] = "<dev string:x1db>";
            #/
            return undefined;
        }
    }
    return max_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xfa651d3c, Offset: 0x4b58
// Size: 0xee
function private function_4cbb2225(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self namespace_87549638::function_df48dc35()) {
            self function_e243333d(weapon);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xa12c25cc, Offset: 0x4c50
// Size: 0x192
function private function_9fe7dc8d(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    currentweapon = self getcurrentweapon();
    if (self.combatstate != "combat_state_in_combat" && self.combatstate != "combat_state_has_visible_enemy") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x6d>";
        #/
        return undefined;
    }
    if (!self.bot.var_e8c84f98) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x61>";
        #/
        return undefined;
    }
    if (self.combatstate != "combat_state_idle" && self.bot.var_e8c84f98) {
        radiusmultiplier = currentweapon == weapon ? 0.9 : 1.5;
        if (self.bot.enemydist < weapon.explosionradius * radiusmultiplier) {
            /#
                actionparams.debug[actionparams.debug.size] = "<dev string:x1f2>";
            #/
            return undefined;
        }
    }
    return max_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xab00c081, Offset: 0x4df0
// Size: 0x28e
function private function_f2c37dfe(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    self namespace_87549638::projectile_weapon(weapon);
    self namespace_87549638::function_7c7431fc("tag_origin");
    self namespace_87549638::think();
    while (true) {
        if (self bot::function_12b52153() && self playerads() <= 0 && self namespace_87549638::function_6e1ecc98()) {
            trace = self function_6e8a2d86(weapon, self getplayerangles());
            if (function_9dfd5e88(trace)) {
                self function_e243333d(weapon);
            }
        } else if (self namespace_87549638::function_16245ece()) {
            self bottapbutton(11);
            if (self playerads() >= 1 && self namespace_87549638::function_6e1ecc98()) {
                trace = self function_6e8a2d86(weapon, self getplayerangles());
                if (function_9dfd5e88(trace)) {
                    self function_e243333d(weapon);
                }
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xf1fd6093, Offset: 0x5088
// Size: 0xb8
function private function_9782a4ec(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy" || self.combatstate == "combat_state_aware_of_enemies") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x18e>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe89b19d0, Offset: 0x5148
// Size: 0x2f6
function private function_d0cdb00e(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (!self function_a39f313c()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    enemies = function_f6f34851(self.team);
    var_4e2b3e3a = [];
    foreach (enemy in enemies) {
        tpoint = getclosesttacpoint(enemy.origin);
        if (!isdefined(tpoint) || !isdefined(tpoint.ceilingheight) || tpoint.ceilingheight < 65534) {
            continue;
        }
        var_4e2b3e3a[var_4e2b3e3a.size] = tpoint.origin;
    }
    if (var_4e2b3e3a.size <= 0) {
        var_4e2b3e3a[0] = (0, 0, 0);
    }
    location = var_4e2b3e3a[randomint(var_4e2b3e3a.size)];
    location += (randomfloatrange(500 * -1, 500), randomfloatrange(500 * -1, 500), 0);
    self notify(#"confirm_location", {#position:location, #yaw:0});
    while (!self function_a39f313c() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x54ba896f, Offset: 0x5448
// Size: 0x378
function private function_8d7445b8(actionparams) {
    if (!isarray(level.var_500867a0)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x211>";
        #/
        return undefined;
    }
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy" || self.combatstate == "combat_state_aware_of_enemies") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x18e>";
        #/
        return undefined;
    }
    bundle = killstreaks::get_script_bundle("jetfighter");
    radiussq = function_a3f6cdac(bundle.var_41c04fda);
    targetfound = 0;
    time = gettime();
    foreach (streaks in level.var_500867a0) {
        if (!isarray(streaks)) {
            continue;
        }
        foreach (streak in streaks) {
            if (!isdefined(streak) || !util::function_fbce7263(self.team, streak.team)) {
                continue;
            }
            if (!isdefined(streak.killstreakendtime) || !isdefined(streak.birthtime) || time - streak.birthtime < 1500 || streak.killstreakendtime - time < 3000) {
                continue;
            }
            if (sessionmodeiswarzonegame() && distance2dsquared(self.origin, streak.origin) > radiussq) {
                continue;
            }
            targetfound = 1;
            break;
        }
    }
    if (!targetfound) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x22c>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x9f04ca56, Offset: 0x57c8
// Size: 0x3c
function private function_9839161a(actionparams) {
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xb7c15672, Offset: 0x5810
// Size: 0xb8
function private function_f70eb03b(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy" || self.combatstate == "combat_state_aware_of_enemies") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x18e>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x7464c071, Offset: 0x58d0
// Size: 0x30e
function private function_d196f6fe(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (!self function_a39f313c()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    enemies = function_f6f34851(self.team);
    var_4e2b3e3a = [];
    foreach (enemy in enemies) {
        tpoint = getclosesttacpoint(enemy.origin);
        if (!isdefined(tpoint) || !isdefined(tpoint.ceilingheight) || tpoint.ceilingheight < 65534) {
            continue;
        }
        var_4e2b3e3a[var_4e2b3e3a.size] = tpoint.origin;
    }
    if (var_4e2b3e3a.size <= 0) {
        var_4e2b3e3a[0] = (0, 0, 0);
    }
    location = var_4e2b3e3a[randomint(var_4e2b3e3a.size)];
    location += (randomfloatrange(500 * -1, 500), randomfloatrange(500 * -1, 500), 0);
    self notify(#"confirm_location", {#position:location, #yaw:randomint(360)});
    while (!self function_a39f313c() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe3731b17, Offset: 0x5be8
// Size: 0xb8
function private function_eebed729(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy" || self.combatstate == "combat_state_aware_of_enemies") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x18e>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x6792c93c, Offset: 0x5ca8
// Size: 0x366
function private function_daacd60e(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (!self function_a39f313c()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    enemies = function_f6f34851(self.team);
    var_4e2b3e3a = [];
    foreach (enemy in enemies) {
        tpoint = getclosesttacpoint(enemy.origin);
        if (!isdefined(tpoint) || !isdefined(tpoint.ceilingheight) || tpoint.ceilingheight < 65534) {
            continue;
        }
        randomindex = randomint(var_4e2b3e3a.size + 1);
        arrayinsert(var_4e2b3e3a, tpoint.origin, randomindex);
    }
    if (var_4e2b3e3a.size <= 0) {
        while (var_4e2b3e3a.size < 3) {
            var_4e2b3e3a[var_4e2b3e3a.size] = (0, 0, 0);
        }
    }
    for (i = 0; i < 3; i++) {
        index = i % var_4e2b3e3a.size;
        location = var_4e2b3e3a[index];
        location += (randomfloatrange(500 * -1, 500), randomfloatrange(500 * -1, 500), 0);
        self notify(#"confirm_location", {#position:location, #yaw:0});
    }
    while (!self function_a39f313c() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x70138180, Offset: 0x6018
// Size: 0xa0
function private function_f8a2b8bb(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xd149407b, Offset: 0x60c0
// Size: 0x9c
function private function_d608e1e5(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xb738ce61, Offset: 0x6168
// Size: 0xa0
function private function_8c614f92(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1a0>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xdcdf8349, Offset: 0x6210
// Size: 0x34
function private function_8f8c4099(actionparams) {
    weapon = actionparams.weapon;
    function_c1515256(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xd401104c, Offset: 0x6250
// Size: 0x150
function private function_f1fb9968(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    if (isdefined(self.rocket) && self.rocket.targetname == #"remote_missile") {
        if (self getcurrentweapon() == weapon) {
            /#
                actionparams.debug[actionparams.debug.size] = "<dev string:x244>";
            #/
            return 100;
        } else {
            /#
                actionparams.debug[actionparams.debug.size] = "<dev string:x25c>";
            #/
            return undefined;
        }
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xc0ef804e, Offset: 0x63a8
// Size: 0x1be
function private function_38a474ba(actionparams) {
    self endoncallback(&function_17d6fe21, #"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    function_185a3c39(weapon);
    while (!isdefined(self.rocket)) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    target = undefined;
    while (isdefined(self.rocket) && self.rocket.targetname == #"remote_missile") {
        if (!isdefined(target) || !isalive(target)) {
            players = function_f6f34851(self.team);
            if (players.size > 0) {
                target = players[randomint(players.size)];
            } else {
                target = undefined;
            }
            self.rocket missile_settarget(target);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x2b87480a, Offset: 0x6570
// Size: 0x54
function private function_17d6fe21(*notifyhash) {
    if (isdefined(self.rocket) && self.rocket.targetname == #"remote_missile") {
        self.rocket missile_settarget(undefined);
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x4aa46170, Offset: 0x65d0
// Size: 0x156
function private function_e3c2c9df(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    currentweapon = self getcurrentweapon();
    if (self.combatstate == "combat_state_in_combat" && currentweapon != weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1c6>";
        #/
        return undefined;
    }
    if (self.combatstate != "combat_state_idle" && self.bot.var_e8c84f98) {
        if (self.bot.enemydist < weapon.explosionradius * 1.5) {
            /#
                actionparams.debug[actionparams.debug.size] = "<dev string:x1f2>";
            #/
            return undefined;
        }
    }
    return weapon.explosionouterdamage;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x4f2190eb, Offset: 0x6730
// Size: 0x13e
function private function_330a4859(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    if (!self.bot.var_e8c84f98) {
        return;
    }
    while (true) {
        if (self namespace_87549638::function_16245ece()) {
            self bottapbutton(11);
        }
        if (self.bot.enemyvisible && self namespace_87549638::function_a231de5d()) {
            self function_e243333d(weapon);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe94de2ea, Offset: 0x6878
// Size: 0xf2
function private function_87e7fa1d(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    currentweapon = self getcurrentweapon();
    if (self.combatstate == "combat_state_in_combat" && currentweapon != weapon) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1c6>";
        #/
        return undefined;
    }
    return max_damage(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe69d0688, Offset: 0x6978
// Size: 0x186
function private function_4fe38a9a(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (true) {
        if (self bot::function_12b52153()) {
            if (self.bot.enemyvisible && self namespace_87549638::function_df48dc35()) {
                self function_e243333d(weapon);
            }
        } else if (self namespace_87549638::function_16245ece()) {
            self bottapbutton(11);
            if (self.bot.enemyvisible && self namespace_87549638::function_a231de5d()) {
                self function_e243333d(weapon);
            }
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe8e63bbc, Offset: 0x6b08
// Size: 0xb8
function private function_25933177(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy" || self.combatstate == "combat_state_aware_of_enemies") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x18e>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x3f19c91, Offset: 0x6bc8
// Size: 0x316
function private function_443e6bac(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    while (!self function_a39f313c()) {
        self waittill(#"hash_77f2882ff9140e86");
    }
    enemies = function_f6f34851(self.team);
    var_4e2b3e3a = [];
    foreach (enemy in enemies) {
        tpoint = getclosesttacpoint(enemy.origin);
        if (!isdefined(tpoint) || !isdefined(tpoint.ceilingheight) || tpoint.ceilingheight < 65534) {
            continue;
        }
        var_4e2b3e3a[var_4e2b3e3a.size] = tpoint.origin;
    }
    if (var_4e2b3e3a.size <= 0) {
        var_4e2b3e3a[var_4e2b3e3a.size] = (0, 0, 0);
    }
    location = var_4e2b3e3a[randomint(var_4e2b3e3a.size)];
    location += (randomfloatrange(500 * -1, 500), randomfloatrange(500 * -1, 500), 0);
    self notify(#"confirm_location", {#position:location, #yaw:randomint(360)});
    while (!self function_a39f313c() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x6dd1e8c1, Offset: 0x6ee8
// Size: 0x1d6
function private function_4bc0c239(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_has_visible_enemy" || self.combatstate == "combat_state_aware_of_enemies") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x18e>";
        #/
        return undefined;
    }
    end = self function_1c8f36a4();
    if (!tracepassedonnavmesh(self.origin, end, 15)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x284>";
        #/
        return undefined;
    }
    tpoint = getclosesttacpoint(end);
    if (!isdefined(tpoint)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x29a>";
        #/
        return undefined;
    }
    if (!isdefined(tpoint.ceilingheight) || tpoint.ceilingheight < 65534) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x2a7>";
        #/
        return undefined;
    }
    actionparams.point = tpoint.origin;
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x6dcdb0bd, Offset: 0x70c8
// Size: 0x1be
function private function_69658e9b(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
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

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 0, eflags: 0x5 linked
// Checksum 0x616494b5, Offset: 0x7290
// Size: 0x42
function private function_1c8f36a4() {
    fwd = anglestoforward(self.angles);
    return self.origin + fwd * 200;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xe965463e, Offset: 0x72e0
// Size: 0xa0
function private function_c5a0aa09(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x9ef02189, Offset: 0x7388
// Size: 0x34
function private function_feadf846(actionparams) {
    weapon = actionparams.weapon;
    function_c1515256(weapon);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x7f4bc7e1, Offset: 0x73c8
// Size: 0xb4
function private function_6f837b80(actionparams) {
    if (!function_e7fa3d0(actionparams)) {
        return undefined;
    }
    weapon = actionparams.weapon;
    if (self.combatstate == "combat_state_in_combat") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x181>";
        #/
        return undefined;
    }
    if (self.combatstate == "combat_state_idle") {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x1b1>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x1a4c668b, Offset: 0x7488
// Size: 0xb4
function private function_5a122360(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    self bottapbutton(0);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x67baa937, Offset: 0x7548
// Size: 0xb4
function private use_armor(actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    weapon = actionparams.weapon;
    self function_185a3c39(weapon);
    self bottapbutton(0);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xff93a4c2, Offset: 0x7608
// Size: 0x8c
function private function_8eb027ee(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(70);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xd127e958, Offset: 0x76a0
// Size: 0x8c
function private function_defcd71a(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(70);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x88ae418e, Offset: 0x7738
// Size: 0x8c
function private function_bef2b171(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(70);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xec052e4a, Offset: 0x77d0
// Size: 0x8c
function private function_23d9a53c(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(70);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xeb69a318, Offset: 0x7868
// Size: 0x8c
function private function_5c902535(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(70);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x4d63f364, Offset: 0x7900
// Size: 0x8c
function private function_bd51bffc(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(70);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xd0a21363, Offset: 0x7998
// Size: 0x8c
function private function_aeb691ff(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(70);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x99f7d1e3, Offset: 0x7a30
// Size: 0x8c
function private function_2376e275(*actionparams) {
    self endon(#"hash_1ae115949cd752c8", #"hash_6280ac8ed281ce3c", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    self bottapbutton(70);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x3dcc6acd, Offset: 0x7ac8
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

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xa4ad9664, Offset: 0x7b78
// Size: 0x74
function private min_damage(weapon) {
    var_2d276877 = weapon.var_2d276877;
    var_89a5bdab = weapon.var_72960e43;
    damage = var_2d276877[var_2d276877.size - 1];
    multishotbasedamage = var_89a5bdab[var_89a5bdab.size - 1];
    return multishotbasedamage + damage;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x9775f72b, Offset: 0x7bf8
// Size: 0x4e
function private max_damage(weapon) {
    damage = weapon.var_2d276877[0];
    multishotbasedamage = weapon.var_72960e43[0];
    return multishotbasedamage + damage * weapon.shotcount;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xa7365cf3, Offset: 0x7c50
// Size: 0x84
function private function_c29dcb98(actionparams) {
    if (!self ai::get_behavior_attribute(#"primaryoffhand")) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x2b1>" + function_9e72a96(#"primaryoffhand") + "<dev string:x2bf>";
        #/
        return false;
    }
    return true;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x803b6cd0, Offset: 0x7ce0
// Size: 0x84
function private function_f2d612c5(actionparams) {
    if (!self ai::get_behavior_attribute(#"secondaryoffhand")) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x2b1>" + function_9e72a96(#"secondaryoffhand") + "<dev string:x2bf>";
        #/
        return false;
    }
    return true;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x4
// Checksum 0xd36d9cc1, Offset: 0x7d70
// Size: 0x84
function private function_f6d4c082(actionparams) {
    if (!self ai::get_behavior_attribute(#"specialoffhand")) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x2b1>" + function_9e72a96(#"specialoffhand") + "<dev string:x2bf>";
        #/
        return false;
    }
    return true;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x7d0a781, Offset: 0x7e00
// Size: 0x2c0
function private function_e7fa3d0(actionparams) {
    if (!self ai::get_behavior_attribute(#"scorestreak")) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x2b1>" + function_9e72a96(#"scorestreak") + "<dev string:x2bf>";
        #/
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
            actionparams.debug[actionparams.debug.size] = "<dev string:x2cd>";
        #/
        return false;
    }
    clipammo = self getweaponammoclip(weapon);
    if (clipammo > 0) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x4b>" + clipammo + "<dev string:x55>" + weapon.clipsize;
        #/
    } else if (isdefined(killstreak.momentumcost) && killstreak.momentumcost > 0) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x2f2>" + self.momentum + "<dev string:x55>" + killstreak.momentumcost;
        #/
        if (killstreak.momentumcost > self.momentum) {
            return false;
        }
    } else {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x2fd>";
        #/
        return false;
    }
    if (!self killstreakrules::iskillstreakallowed(type, self.team, 1)) {
        /#
            actionparams.debug[actionparams.debug.size] = "<dev string:x311>";
        #/
        return false;
    }
    return true;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0xa8b986a7, Offset: 0x80c8
// Size: 0x62
function private function_9dfd5e88(trace) {
    if (!isdefined(self.enemy) || !isdefined(trace)) {
        return false;
    }
    var_d6e7a23f = trace[#"entity"];
    return isdefined(var_d6e7a23f) && var_d6e7a23f == self.enemy;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 2, eflags: 0x5 linked
// Checksum 0xab52773c, Offset: 0x8138
// Size: 0x78
function private function_6bdb18b7(trace, origin) {
    if (!isdefined(trace)) {
        return false;
    }
    mindist = distance2d(self.origin, origin) + -10;
    return distance2d(self.origin, trace[#"position"]) >= mindist;
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x9c9c7cc0, Offset: 0x81b8
// Size: 0x76
function private function_185a3c39(weapon) {
    while (self getcurrentweapon() != weapon) {
        if (!self isswitchingweapons()) {
            self botswitchtoweapon(weapon);
        }
        self waittill(#"hash_77f2882ff9140e86");
    }
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x9f7af8af, Offset: 0x8238
// Size: 0x3c
function private function_c1515256(weapon) {
    self function_88128d60(weapon);
    self bottapbutton(85);
}

// Namespace namespace_d9f3dd47/namespace_d9f3dd47
// Params 1, eflags: 0x5 linked
// Checksum 0x4458be96, Offset: 0x8280
// Size: 0x104
function private function_e243333d(weapon) {
    if (weapon.firetype == #"single shot" || weapon.firetype == #"burst") {
        if (self isfiring() || gettime() < self.bot.var_51cee2ad) {
            return;
        }
        self.bot.var_51cee2ad = gettime() + randomintrange(self.bot.var_b2b8f0b6, self.bot.var_e8c941d6);
    }
    self bottapbutton(0);
    if (weapon.dualwieldweapon != level.weaponnone) {
        self bottapbutton(24);
    }
}

