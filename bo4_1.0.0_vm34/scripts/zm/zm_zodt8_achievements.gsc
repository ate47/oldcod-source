#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zodt8_achievements;

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x22daa4ed, Offset: 0x170
// Size: 0x74
function init() {
    level thread function_51a6d87f();
    level thread function_d0ced3ef();
    callback::on_connect(&on_player_connect);
    callback::on_ai_killed(&on_ai_killed);
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0xd0495767, Offset: 0x1f0
// Size: 0xac
function on_player_connect() {
    self thread function_4acbb6c4();
    self thread function_722c4f95();
    self thread function_e8814729();
    self thread function_c20e3ca0();
    self thread function_8fcf5bed();
    self thread function_8e92208a();
    self thread function_73c891d2();
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 1, eflags: 0x0
// Checksum 0xbc41b4f5, Offset: 0x2a8
// Size: 0x18c
function on_ai_killed(params) {
    if (isplayer(params.eattacker)) {
        params.eattacker thread function_34144d33(params);
        if (self.archetype == #"zombie" || self.archetype == #"catalyst") {
            if (self clientfield::get("sndActorUnderwater")) {
                params.eattacker thread function_efe3dd61();
            }
            if (isdefined(params.einflictor) && params.einflictor.archetype === #"catalyst" && isdefined(params.einflictor.var_d06c62f1) && params.einflictor.var_d06c62f1) {
                params.eattacker thread function_56b1a1b9();
            }
            return;
        }
        if (self.archetype == #"stoker") {
            if (isdefined(self.var_2719861) && self.var_2719861) {
                params.eattacker thread function_3f548560();
            }
        }
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0xb54090ef, Offset: 0x440
// Size: 0x7c
function function_51a6d87f() {
    level endon(#"end_game");
    level flagsys::wait_till(#"hash_25d8c88ff3f91ee5");
    /#
        iprintlnbold("<dev string:x30>");
    #/
    zm_utility::giveachievement_wrapper("ZM_ZODT8_ARTIFACT", 1);
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0xf0498a98, Offset: 0x4c8
// Size: 0x11e
function function_4acbb6c4() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_8c3fba5b = 0;
    self thread function_1bad7655();
    while (true) {
        self waittill(#"hash_7ba738379777a068");
        self.var_8c3fba5b = 1;
        b_success = self function_fd7a4ee();
        if (isdefined(b_success) && b_success) {
            /#
                iprintlnbold("<dev string:x61>" + self getentnum());
            #/
            self zm_utility::giveachievement_wrapper("ZM_ZODT8_STOWAWAY", 0);
            self notify(#"hash_10404a179a65cd64");
            return;
        }
        self.var_8c3fba5b = 0;
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x9265e632, Offset: 0x5f0
// Size: 0xb8
function function_fd7a4ee() {
    level endon(#"end_game");
    self endon(#"death", #"hash_5a83ec4a73b3dc6");
    level waittill(#"start_of_round");
    var_9ef6b569 = level.round_number;
    while (true) {
        level waittill(#"end_of_round");
        if (level.round_number - var_9ef6b569 >= 5) {
            return 1;
        }
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x1d85b2c7, Offset: 0x6b0
// Size: 0x134
function function_1bad7655() {
    level endon(#"end_game");
    self endon(#"hash_10404a179a65cd64", #"disconnect");
    var_acb1fb06 = array(#"zone_cargo");
    while (true) {
        if (isdefined(self.zone_name)) {
            var_bc1b4589 = isstring(self.zone_name) ? hash(self.zone_name) : self.zone_name;
            if (isinarray(var_acb1fb06, var_bc1b4589)) {
                if (!self.var_8c3fba5b) {
                    self notify(#"hash_7ba738379777a068");
                }
            } else if (self.var_8c3fba5b) {
                self notify(#"hash_5a83ec4a73b3dc6");
            }
        }
        wait 0.5;
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x9f860176, Offset: 0x7f0
// Size: 0xc2
function function_d0ced3ef() {
    level endon(#"end_game", #"hash_5c62047f5c8fdbdd", #"hash_6cd15a5470217958");
    while (true) {
        level waittill(#"end_of_round");
        if (level.round_number >= 20) {
            wait 2;
            /#
                iprintlnbold("<dev string:x82>");
            #/
            zm_utility::giveachievement_wrapper("ZM_ZODT8_DEEP_END", 1);
            return;
        }
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x8d4b169c, Offset: 0x8c0
// Size: 0x1f4
function function_722c4f95() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"pap_taken");
        if (isdefined(level.s_pap_quest) && isdefined(level.s_pap_quest.var_a6956ec4)) {
            if (!isdefined(self.var_8c01e63d)) {
                self.var_8c01e63d = [];
            }
            if (!isinarray(self.var_8c01e63d, level.s_pap_quest.var_a6956ec4.prefabname)) {
                if (!isdefined(self.var_8c01e63d)) {
                    self.var_8c01e63d = [];
                } else if (!isarray(self.var_8c01e63d)) {
                    self.var_8c01e63d = array(self.var_8c01e63d);
                }
                if (!isinarray(self.var_8c01e63d, level.s_pap_quest.var_a6956ec4.prefabname)) {
                    self.var_8c01e63d[self.var_8c01e63d.size] = level.s_pap_quest.var_a6956ec4.prefabname;
                }
                if (self.var_8c01e63d.size > 3) {
                    wait 1;
                    if (isdefined(self)) {
                        /#
                            iprintlnbold("<dev string:xaf>" + self getentnum());
                        #/
                        self zm_utility::giveachievement_wrapper("ZM_ZODT8_LITTLE_PACK", 0);
                        self.var_8c01e63d = undefined;
                        return;
                    }
                }
            }
        }
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x49e55010, Offset: 0xac0
// Size: 0x1cc
function function_e8814729() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"fasttravel_bought");
        if (isdefined(self.var_cdec605d)) {
            if (!isdefined(self.var_2c015b2)) {
                self.var_2c015b2 = [];
            }
            if (!isinarray(self.var_2c015b2, self.var_cdec605d)) {
                if (!isdefined(self.var_2c015b2)) {
                    self.var_2c015b2 = [];
                } else if (!isarray(self.var_2c015b2)) {
                    self.var_2c015b2 = array(self.var_2c015b2);
                }
                if (!isinarray(self.var_2c015b2, self.var_cdec605d)) {
                    self.var_2c015b2[self.var_2c015b2.size] = self.var_cdec605d;
                }
                if (self.var_2c015b2.size > 7) {
                    self waittill(#"fasttravel_finished", #"death");
                    wait 1;
                    if (isdefined(self)) {
                        /#
                            iprintlnbold("<dev string:xdd>" + self getentnum());
                        #/
                        self zm_utility::giveachievement_wrapper("ZM_ZODT8_SHORTCUT", 0);
                        self.var_2c015b2 = undefined;
                        return;
                    }
                }
            }
        }
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0xe614ad48, Offset: 0xc98
// Size: 0xf8
function function_c20e3ca0() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_8f42ca24 = 0;
    while (true) {
        /#
            if (self.var_8f42ca24) {
                iprintln("<dev string:x107>" + self.var_8f42ca24);
            }
        #/
        if (self.var_8f42ca24 >= 9) {
            /#
                iprintlnbold("<dev string:x11c>" + self getentnum());
            #/
            self zm_utility::giveachievement_wrapper("ZM_ZODT8_TENTACLE", 0);
            return;
        }
        self.var_8f42ca24 = 0;
        wait 0.3;
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 1, eflags: 0x0
// Checksum 0xf4989536, Offset: 0xd98
// Size: 0x160
function function_34144d33(params) {
    var_8b1caea0 = array(level.var_23045784, level.var_72db4a17, getweapon(#"ww_tricannon_air_t8"), getweapon(#"ww_tricannon_air_t8_upgraded"), getweapon(#"ww_tricannon_earth_t8"), getweapon(#"ww_tricannon_earth_t8_upgraded"), getweapon(#"ww_tricannon_fire_t8"), getweapon(#"ww_tricannon_fire_t8_upgraded"), getweapon(#"ww_tricannon_water_t8"), getweapon(#"ww_tricannon_water_t8_upgraded"));
    if (isinarray(var_8b1caea0, params.weapon)) {
        self.var_8f42ca24++;
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x95d109b, Offset: 0xf00
// Size: 0xd6
function function_8fcf5bed() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_686078c5 = undefined;
    self.var_ba716ec6 = 0;
    while (true) {
        if (self.var_ba716ec6 >= 3) {
            /#
                iprintlnbold("<dev string:x147>" + self getentnum());
            #/
            self zm_utility::giveachievement_wrapper("ZM_ZODT8_STOKING", 0);
            self.var_a8617348 = 1;
            return;
        }
        wait 2;
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x3ca7d3a1, Offset: 0xfe0
// Size: 0xa4
function function_3f548560() {
    if (isdefined(self.var_a8617348) && self.var_a8617348) {
        return;
    }
    if (!isdefined(self.var_686078c5)) {
        self.var_686078c5 = level.round_number;
    }
    if (self.var_686078c5 != level.round_number) {
        self.var_686078c5 = level.round_number;
        self.var_ba716ec6 = 0;
    }
    self.var_ba716ec6++;
    /#
        iprintln("<dev string:x172>" + self.var_ba716ec6);
    #/
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x63c1780d, Offset: 0x1090
// Size: 0x110
function function_8e92208a() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_5345914e = 0;
    /#
        var_5689d023 = 0;
    #/
    while (true) {
        /#
            if (self.var_5345914e != var_5689d023) {
                iprintln("<dev string:x188>" + self.var_5345914e);
                var_5689d023 = self.var_5345914e;
            }
        #/
        if (self.var_5345914e >= 9) {
            /#
                iprintlnbold("<dev string:x19d>" + self getentnum());
            #/
            self zm_utility::giveachievement_wrapper("ZM_ZODT8_ROCK_PAPER", 0);
            return;
        }
        wait 2;
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x79101518, Offset: 0x11a8
// Size: 0x10
function function_56b1a1b9() {
    self.var_5345914e++;
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0xbb0e5b6d, Offset: 0x11c0
// Size: 0x110
function function_73c891d2() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_f7f20388 = 0;
    /#
        var_5689d023 = 0;
    #/
    while (true) {
        /#
            if (self.var_f7f20388 != var_5689d023) {
                iprintln("<dev string:x1c7>" + self.var_f7f20388);
                var_5689d023 = self.var_f7f20388;
            }
        #/
        if (self.var_f7f20388 >= 50) {
            /#
                iprintlnbold("<dev string:x1da>" + self getentnum());
            #/
            self zm_utility::giveachievement_wrapper("ZM_ZODT8_SWIMMING", 0);
            return;
        }
        wait 2;
    }
}

// Namespace zodt8_achievements/zm_zodt8_achievements
// Params 0, eflags: 0x0
// Checksum 0x5268ffe6, Offset: 0x12d8
// Size: 0x10
function function_efe3dd61() {
    self.var_f7f20388++;
}

