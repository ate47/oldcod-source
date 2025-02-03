#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;

#namespace activecamo;

// Namespace activecamo/activecamo_shared
// Params 0, eflags: 0x6
// Checksum 0xd2583cd9, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"activecamo", &preinit, undefined, undefined, undefined);
}

// Namespace activecamo/activecamo_shared
// Params 0, eflags: 0x4
// Checksum 0xce4fc9e1, Offset: 0x118
// Size: 0x5c
function private preinit() {
    callback::on_loadout(&on_player_loadout);
    callback::on_weapon_change(&on_weapon_change);
    /#
        thread function_265047c1();
    #/
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x29f2c5c, Offset: 0x180
// Size: 0xa0
function on_weapon_change(params) {
    if (is_true(level.var_b219667f)) {
        self function_8d3b94ea(params.weapon, 1);
    } else {
        self function_8d3b94ea(params.weapon, 0);
    }
    if (isdefined(level.var_3993dc8e)) {
        self [[ level.var_3993dc8e ]](params.weapon);
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x9d894430, Offset: 0x228
// Size: 0x3c
function on_player_death(*params) {
    if (game.state != #"playing") {
        return;
    }
    self function_27779784();
}

// Namespace activecamo/activecamo_shared
// Params 0, eflags: 0x0
// Checksum 0x407cf5b7, Offset: 0x270
// Size: 0x184
function function_27779784() {
    if (!isdefined(self) || !isdefined(self.pers) || !isdefined(self.pers[#"activecamo"])) {
        return;
    }
    foreach (activecamo in self.pers[#"activecamo"]) {
        foreach (var_dd54a13b in activecamo.var_dd54a13b) {
            activecamo.weapon = var_dd54a13b.weapon;
            activecamo.baseweapon = function_c14cb514(activecamo.weapon);
            self init_stages(activecamo, 0, 1);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 0, eflags: 0x0
// Checksum 0x1027226e, Offset: 0x400
// Size: 0xd0
function on_player_loadout() {
    self callback::remove_on_death(&on_player_death);
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        self function_8d3b94ea(weapon, 1);
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0x70680a9c, Offset: 0x4d8
// Size: 0x7c
function function_8d3b94ea(weapon, owned, b_has_weapon) {
    weapon = function_94c2605(weapon);
    var_f4eb4a50 = function_155299d(weapon, b_has_weapon);
    if (isdefined(var_f4eb4a50)) {
        self init_activecamo(weapon, var_f4eb4a50, owned);
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0x5536353c, Offset: 0x560
// Size: 0x274
function init_activecamo(weapon, var_f4eb4a50, owned) {
    if (isdefined(var_f4eb4a50.name)) {
        if (!isdefined(self.pers[#"activecamo"])) {
            self.pers[#"activecamo"] = [];
        }
        if (!isdefined(self.pers[#"activecamo"][var_f4eb4a50.name])) {
            self.pers[#"activecamo"][var_f4eb4a50.name] = {};
        }
        activecamo = self.pers[#"activecamo"][var_f4eb4a50.name];
        activecamo.var_13949c61 = function_8a6ced15(var_f4eb4a50);
        assert(isdefined(activecamo.var_13949c61));
        activecamo.weapon = weapon;
        activecamo.baseweapon = function_c14cb514(activecamo.weapon);
        if (!isdefined(activecamo.var_dd54a13b)) {
            activecamo.var_dd54a13b = [];
        }
        if (!isdefined(activecamo.var_dd54a13b[activecamo.baseweapon])) {
            activecamo.var_dd54a13b[activecamo.baseweapon] = {};
        }
        activecamo.var_dd54a13b[activecamo.baseweapon].weapon = weapon;
        activecamo.var_dd54a13b[activecamo.baseweapon].stagenum = undefined;
        if (!isdefined(activecamo.var_dd54a13b[activecamo.baseweapon].owned)) {
            activecamo.var_dd54a13b[activecamo.baseweapon].owned = 0;
        }
        activecamo.var_dd54a13b[activecamo.baseweapon].owned = activecamo.var_dd54a13b[activecamo.baseweapon].owned | owned;
        self init_stages(activecamo, 0, 0);
        self callback::on_death(&on_player_death);
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0xdb6c6cc, Offset: 0x7e0
// Size: 0x5fa
function function_8a6ced15(var_f4eb4a50) {
    var_13949c61 = undefined;
    if (isdefined(var_f4eb4a50.name)) {
        if (!isdefined(level.activecamoinfo)) {
            level.activecamoinfo = [];
        }
        if (!isdefined(level.activecamoinfo[var_f4eb4a50.name])) {
            level.activecamoinfo[var_f4eb4a50.name] = {};
        }
        var_13949c61 = level.activecamoinfo[var_f4eb4a50.name];
        var_13949c61.name = var_f4eb4a50.name;
        var_13949c61.isasync = var_f4eb4a50.isasync;
        var_13949c61.istiered = var_f4eb4a50.istiered;
        var_13949c61.var_ed6f91d5 = var_f4eb4a50.var_ed6f91d5;
        var_13949c61.var_bd863267 = var_f4eb4a50.var_bd863267;
        var_13949c61.istimer = var_f4eb4a50.istimer;
        var_13949c61.var_fa0465c6 = var_f4eb4a50.var_fa0465c6;
        var_13949c61.var_2034fabe = var_f4eb4a50.var_2034fabe;
        var_13949c61.var_9ae5a2b8 = var_f4eb4a50.var_9ae5a2b8;
        var_d3daabe = 0;
        if (isdefined(var_f4eb4a50.stages)) {
            if (!isdefined(var_13949c61.stages)) {
                var_13949c61.stages = [];
            }
            var_13949c61.statscache = [];
            foreach (key, var_3594168e in var_f4eb4a50.stages) {
                if (is_true(var_3594168e.disabled)) {
                    var_d3daabe++;
                    continue;
                }
                if (!isdefined(var_13949c61.stages[key - var_d3daabe])) {
                    var_13949c61.stages[key - var_d3daabe] = {};
                }
                stage = var_13949c61.stages[key - var_d3daabe];
                if (isdefined(var_3594168e.camooption)) {
                    stage.var_19b6044e = function_8b51d9d1(var_3594168e.camooption);
                }
                /#
                    if (!isdefined(stage.var_19b6044e)) {
                        self debug_error("<dev string:x38>" + var_13949c61.name + "<dev string:x3e>" + function_9e72a96(isdefined(var_3594168e.camooption) ? var_3594168e.camooption : "<dev string:x5b>") + "<dev string:x66>" + key);
                    } else {
                        activecamoname = getactivecamo(stage.var_19b6044e);
                        var_7216636e = undefined;
                        if (isdefined(activecamoname) && activecamoname != #"") {
                            var_7216636e = getscriptbundle(activecamoname);
                        }
                        if (!isdefined(var_7216636e)) {
                            self debug_error("<dev string:x38>" + var_13949c61.name + "<dev string:x78>" + stage.var_19b6044e + "<dev string:x66>" + key);
                        } else if (!isdefined(var_7216636e.name) || var_7216636e.name != var_13949c61.name) {
                            self debug_error("<dev string:x38>" + var_13949c61.name + "<dev string:xa3>" + stage.var_19b6044e + "<dev string:xb7>" + (isdefined(var_7216636e.name) ? var_7216636e.name : "<dev string:x5b>") + "<dev string:x66>" + key);
                        }
                        activecamoname = undefined;
                        var_7216636e = undefined;
                    }
                #/
                stage.permanent = var_3594168e.permanent;
                stage.statname = var_3594168e.statname;
                stage.permanentstatname = var_3594168e.permanentstatname;
                stage.var_e2dbd42d = isdefined(var_3594168e.var_e2dbd42d) ? var_3594168e.var_e2dbd42d : 0;
                stage.resettimer = isdefined(var_3594168e.resettimer) ? var_3594168e.resettimer : 0;
                stage.resetnotify = var_3594168e.resetnotify;
                stage.resetondeath = var_3594168e.resetondeath;
                stage.var_825ae630 = var_3594168e.var_c43b3dd3;
                stage.var_c33fcb85 = isdefined(var_3594168e.var_c33fcb85) ? var_3594168e.var_c33fcb85 : 0;
                if (isdefined(stage.statname)) {
                    if (!isdefined(var_13949c61.statscache[stage.statname])) {
                        var_13949c61.statscache[stage.statname] = 1;
                    }
                }
                if (isdefined(stage.permanentstatname)) {
                    if (!isdefined(var_13949c61.statscache[stage.permanentstatname])) {
                        var_13949c61.statscache[stage.permanentstatname] = 1;
                    }
                }
                /#
                    var_1936b16e = getdvarint(#"hash_45e0785aaf2e24af", 0);
                    if (var_1936b16e) {
                        stage.var_e2dbd42d = var_1936b16e;
                    }
                #/
            }
        }
    }
    return var_13949c61;
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0xa27ca587, Offset: 0xde8
// Size: 0xc2
function function_37a45562(camoindex, activecamo) {
    foreach (stagenum, stage in activecamo.var_13949c61.stages) {
        if (isdefined(stage) && isdefined(stage.var_19b6044e) && stage.var_19b6044e == camoindex) {
            return stagenum;
        }
    }
    return undefined;
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0x1217a973, Offset: 0xeb8
// Size: 0x9ec
function init_stages(activecamo, var_3a8a1e00, isdeath) {
    if (isdefined(activecamo.var_13949c61.stages)) {
        weaponoptions = self function_ade49959(activecamo.weapon);
        weaponstage = getactivecamostage(weaponoptions);
        camoindex = getcamoindex(weaponoptions);
        camoindexstage = function_37a45562(camoindex, activecamo);
        var_7491ec51 = activecamo.var_dd54a13b[activecamo.baseweapon].owned !== 1;
        if (!var_7491ec51) {
            var_7491ec51 = isdefined(camoindexstage);
            if (var_7491ec51) {
                weaponstage = camoindexstage;
            }
        }
        if (!isdefined(activecamo.stages)) {
            activecamo.stages = [];
        }
        foreach (stagenum, var_62b564ee in activecamo.var_13949c61.stages) {
            if (!isdefined(activecamo.stages[stagenum])) {
                activecamo.stages[stagenum] = {};
            }
            stage = activecamo.stages[stagenum];
            stage.var_62b564ee = var_62b564ee;
            assert(isdefined(stage.var_62b564ee));
            if (!isdefined(stage.var_dd54a13b)) {
                stage.var_dd54a13b = [];
            }
            if (!isdefined(stage.var_dd54a13b[activecamo.baseweapon])) {
                stage.var_dd54a13b[activecamo.baseweapon] = {};
            }
            if (!isdefined(stage.var_dd54a13b[activecamo.baseweapon].statvalue)) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
            }
            reset = 0;
            if (var_3a8a1e00) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
                reset = 1;
            } else if (isdeath) {
                if (is_true(stage.var_62b564ee.var_825ae630) && is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
                    stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                } else if (is_true(stage.var_62b564ee.resetondeath) || stage.var_62b564ee.resettimer > 0) {
                    stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
                    reset = 1;
                }
            }
            if (isdefined(stage.var_62b564ee.permanentstatname)) {
                camo_stat = self stats::get_stat_global(stage.var_62b564ee.permanentstatname);
                if (isdefined(camo_stat) && camo_stat < stage.var_62b564ee.var_e2dbd42d) {
                    var_7dfd59c3 = isdefined(stats::function_af5584ca(stage.var_62b564ee.permanentstatname)) ? stats::function_af5584ca(stage.var_62b564ee.permanentstatname) : 0;
                    if (var_7dfd59c3 > 0) {
                        camo_stat = stage.var_62b564ee.var_e2dbd42d;
                        self stats::set_stat_global(stage.var_62b564ee.permanentstatname, camo_stat);
                        self stats::set_stat_challenge(stage.var_62b564ee.permanentstatname, camo_stat);
                    }
                }
                if (isdefined(camo_stat)) {
                    stage.var_dd54a13b[activecamo.baseweapon].statvalue = camo_stat;
                }
            } else if (is_true(stage.var_62b564ee.permanent) && isdefined(stage.var_62b564ee.statname)) {
                camo_stat = self stats::get_stat_global(stage.var_62b564ee.statname);
                if (isdefined(camo_stat)) {
                    stage.var_dd54a13b[activecamo.baseweapon].statvalue = camo_stat;
                }
            }
            if (!reset && is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
                if (is_true(activecamo.var_13949c61.istiered)) {
                    if (weaponstage > stagenum) {
                        stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                    }
                }
                if (is_true(activecamo.var_13949c61.var_2034fabe)) {
                    if (isdefined(stage.var_62b564ee.permanentstatname)) {
                        if (weaponstage > stagenum) {
                            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                        }
                    } else if (is_true(stage.var_62b564ee.permanent) && isdefined(stage.var_62b564ee.statname)) {
                        if (weaponstage > stagenum) {
                            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                        }
                    } else if (weaponstage == stagenum) {
                        stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                    }
                }
            }
            stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
            if (var_7491ec51) {
                if (is_true(activecamo.var_13949c61.istiered)) {
                    if (weaponstage > stagenum) {
                        if (isdefined(stage.var_62b564ee.permanentstatname)) {
                            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                        } else if (is_true(stage.var_62b564ee.permanent) && isdefined(stage.var_62b564ee.statname)) {
                            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                        }
                    }
                }
                if (is_true(activecamo.var_13949c61.var_2034fabe)) {
                    if (isdefined(stage.var_62b564ee.permanentstatname)) {
                        if (weaponstage > stagenum) {
                            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                        }
                    } else if (is_true(stage.var_62b564ee.permanent) && isdefined(stage.var_62b564ee.statname)) {
                        if (weaponstage > stagenum) {
                            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                        }
                    } else if (weaponstage == stagenum) {
                        stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
                    }
                }
            }
            if (is_true(activecamo.var_13949c61.isasync)) {
                self thread function_f0d83504(activecamo, stage, stagenum);
            }
        }
        self function_e44edbd1(activecamo);
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0x8fc169fa, Offset: 0x18b0
// Size: 0x61c
function function_896ac347(oweapon, statname, value) {
    if (!isplayer(self)) {
        return;
    }
    if (!isdefined(self.pers) || !isdefined(self.pers[#"activecamo"])) {
        return;
    }
    if (!isdefined(oweapon)) {
        assertmsg("<dev string:xd2>");
        return;
    }
    weapon = function_94c2605(oweapon);
    if (!isdefined(weapon)) {
        assertmsg("<dev string:x107>" + function_9e72a96(oweapon.name));
        return;
    }
    activecamoname = function_b004e227(weapon);
    if (isdefined(activecamoname)) {
        activecamo = self.pers[#"activecamo"][activecamoname];
        if (isdefined(activecamo)) {
            if (!isdefined(activecamo.var_13949c61.statscache[statname])) {
                return;
            }
            activecamo.weapon = weapon;
            activecamo.baseweapon = function_c14cb514(activecamo.weapon);
            if (!isdefined(activecamo.baseweapon)) {
                assertmsg("<dev string:x14d>" + function_9e72a96(activecamo.weapon.name));
                return;
            }
            if (!isdefined(activecamo.var_dd54a13b[activecamo.baseweapon])) {
                assertmsg("<dev string:x19c>" + function_9e72a96(activecamo.baseweapon.name) + "<dev string:x1cd>");
                return;
            }
            if (isdefined(activecamo.stages)) {
                var_7a414d4a = 0;
                foreach (stage in activecamo.stages) {
                    if (is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
                        continue;
                    }
                    lastvalue = stage.var_dd54a13b[activecamo.baseweapon].statvalue;
                    if (isdefined(stage.var_62b564ee.permanentstatname) && activecamo.var_dd54a13b[activecamo.baseweapon].owned === 1) {
                        if (stage.var_62b564ee.statname == statname) {
                            if (self stats::function_dad108fa(stage.var_62b564ee.permanentstatname, value)) {
                                stage.var_dd54a13b[activecamo.baseweapon].statvalue = self stats::get_stat_global(stage.var_62b564ee.permanentstatname);
                            }
                        }
                    } else if (isdefined(stage.var_62b564ee.statname)) {
                        if (is_true(activecamo.var_13949c61.var_2034fabe)) {
                            if (!is_true(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)) {
                                continue;
                            }
                        }
                        if (is_true(stage.var_62b564ee.permanent) && activecamo.var_dd54a13b[activecamo.baseweapon].owned === 1) {
                            if (self stats::function_dad108fa(statname, value)) {
                                stage.var_dd54a13b[activecamo.baseweapon].statvalue = self stats::get_stat_global(statname);
                            }
                        } else if (stage.var_62b564ee.statname == statname) {
                            stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_dd54a13b[activecamo.baseweapon].statvalue + value;
                        }
                    }
                    var_804a253 = stage.var_dd54a13b[activecamo.baseweapon].statvalue > lastvalue;
                    if (var_804a253) {
                        var_7a414d4a = 1;
                    }
                    if (is_true(activecamo.var_13949c61.istiered)) {
                        break;
                    }
                }
                if (var_7a414d4a) {
                    self function_b9119037(activecamo);
                }
                if (statname == #"kills") {
                    self function_e2212969(activecamo, value);
                }
            }
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0xdea7f5fd, Offset: 0x1ed8
// Size: 0x1ba
function function_e2212969(activecamo, value) {
    if (!isdefined(activecamo.var_dd54a13b[activecamo.baseweapon].kills)) {
        activecamo.var_dd54a13b[activecamo.baseweapon].kills = 0;
    }
    newvalue = activecamo.var_dd54a13b[activecamo.baseweapon].kills + value;
    if (activecamo.var_dd54a13b[activecamo.baseweapon].kills < 5 && newvalue >= 5) {
        self function_896ac347(activecamo.weapon, "5th_kill", 1);
    }
    if (activecamo.var_dd54a13b[activecamo.baseweapon].kills < 9 && newvalue >= 9) {
        self function_896ac347(activecamo.weapon, "9th_kill", 1);
    }
    if (activecamo.var_dd54a13b[activecamo.baseweapon].kills < 100 && newvalue >= 100) {
        self function_896ac347(activecamo.weapon, "100th_kill", 1);
    }
    activecamo.var_dd54a13b[activecamo.baseweapon].kills = newvalue;
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0xb78f9251, Offset: 0x20a0
// Size: 0x6c
function function_f0d83504(activecamo, stage, stagenum) {
    self setactivecamostage(activecamo.weapon, stagenum, 1, is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared));
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x616d5990, Offset: 0x2118
// Size: 0x18c
function function_e44edbd1(activecamo) {
    if (is_true(activecamo.var_13949c61.istiered)) {
        var_e92afc26 = 0;
        for (stagenum = activecamo.stages.size - 1; stagenum >= 0; stagenum--) {
            stage = activecamo.stages[stagenum];
            if (stage.var_62b564ee.var_e2dbd42d > 0 && stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.var_62b564ee.var_e2dbd42d) {
                if (var_e92afc26 < stagenum) {
                    var_e92afc26 = stagenum;
                }
            }
            if (stagenum < var_e92afc26) {
                stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_62b564ee.var_e2dbd42d;
            }
        }
        self function_b9119037(activecamo);
        return;
    }
    if (is_true(activecamo.var_13949c61.var_2034fabe)) {
        activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = 0;
        self function_b9119037(activecamo);
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x28a2edae, Offset: 0x22b0
// Size: 0xb4
function function_b9119037(activecamo) {
    if (!isdefined(activecamo.baseweapon) || !isdefined(activecamo.var_dd54a13b[activecamo.baseweapon])) {
        return;
    }
    if (is_true(activecamo.var_13949c61.istiered)) {
        self function_5d692cf(activecamo);
        return;
    }
    if (is_true(activecamo.var_13949c61.var_2034fabe)) {
        self function_8eac065(activecamo);
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x28b7011c, Offset: 0x2370
// Size: 0x304
function function_5d692cf(activecamo) {
    stagenum = 0;
    var_c70461e6 = 0;
    foreach (key, stage in activecamo.stages) {
        if (!isdefined(stage.var_dd54a13b[activecamo.baseweapon])) {
            continue;
        }
        stagenum = key;
        if (stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.var_62b564ee.var_e2dbd42d) {
            stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
            if (activecamo.var_13949c61.var_9ae5a2b8 === 1 && stagenum == activecamo.stages.size - 1) {
                var_c70461e6 = 1;
                break;
            }
            continue;
        }
        break;
    }
    if (var_c70461e6 == 1) {
        var_2cc4646f = 0;
        foreach (key, stage in activecamo.stages) {
            if (!isdefined(stage.var_dd54a13b[activecamo.baseweapon])) {
                continue;
            }
            if (!var_2cc4646f) {
                if (stage.var_62b564ee.var_c33fcb85 === 1) {
                    var_2cc4646f = 1;
                    stagenum = key;
                } else {
                    continue;
                }
            }
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
            stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
        }
        if (var_2cc4646f) {
            set_stage_activecamo(activecamo, stagenum);
        }
        return;
    }
    weaponoptions = self function_ade49959(activecamo.weapon);
    weaponstage = getactivecamostage(weaponoptions);
    if (weaponstage != stagenum || activecamo.var_dd54a13b[activecamo.baseweapon].stagenum !== stagenum) {
        set_stage_activecamo(activecamo, stagenum);
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x8f04cda2, Offset: 0x2680
// Size: 0x42c
function function_8eac065(activecamo) {
    if (!is_true(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)) {
        var_8fc208a8 = 1;
        foreach (key, stage in activecamo.stages) {
            if (isdefined(stage.var_62b564ee.permanentstatname)) {
                if (!isdefined(stage.var_dd54a13b[activecamo.baseweapon])) {
                    continue;
                }
                if (stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.var_62b564ee.var_e2dbd42d) {
                    stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
                }
                if (!is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
                    var_8fc208a8 = 0;
                }
                continue;
            }
            break;
        }
        if (var_8fc208a8) {
            activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = 1;
        }
    }
    var_42d9b149 = 0;
    if (is_true(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)) {
        for (stagenum = activecamo.stages.size - 1; stagenum >= 0; stagenum--) {
            stage = activecamo.stages[stagenum];
            if (!isdefined(stage.var_dd54a13b[activecamo.baseweapon])) {
                continue;
            }
            if (!is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.var_62b564ee.var_e2dbd42d) {
                stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
                var_42d9b149 = stagenum;
                break;
            }
        }
        foreach (key, stage in activecamo.stages) {
            if (isdefined(stage.var_62b564ee.permanentstatname)) {
                continue;
            }
            if (var_42d9b149 == key) {
                continue;
            }
            if (!isdefined(stage.var_dd54a13b[activecamo.baseweapon])) {
                continue;
            }
            stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
            stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
        }
    }
    weaponoptions = self function_ade49959(activecamo.weapon);
    weaponstage = getactivecamostage(weaponoptions);
    if (weaponstage != var_42d9b149 || activecamo.var_dd54a13b[activecamo.baseweapon].stagenum !== var_42d9b149) {
        set_stage_activecamo(activecamo, var_42d9b149);
    }
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0x28434234, Offset: 0x2ab8
// Size: 0x154
function set_stage_activecamo(activecamo, stagenum) {
    stage = activecamo.stages[stagenum];
    if (!isdefined(stage)) {
        return;
    }
    activecamo.var_dd54a13b[activecamo.baseweapon].stagenum = stagenum;
    self setactivecamostage(activecamo.weapon, stagenum);
    if (isdefined(stage.var_62b564ee.var_19b6044e)) {
        self setcamo(activecamo.weapon, stage.var_62b564ee.var_19b6044e);
    }
    /#
        self debug_print("<dev string:x38>" + activecamo.var_13949c61.name + "<dev string:x1f7>" + stagenum + "<dev string:x207>" + (isdefined(stage.var_62b564ee.var_19b6044e) ? stage.var_62b564ee.var_19b6044e : "<dev string:x219>"));
    #/
    self thread function_a80cb651(activecamo, stagenum);
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0x11d14ec2, Offset: 0x2c18
// Size: 0x2ac
function function_a80cb651(activecamo, stagenum) {
    self notify("7511883100af680c");
    self endon("7511883100af680c");
    self endon(#"death");
    stage = activecamo.stages[stagenum];
    weapon = activecamo.weapon;
    baseweapon = function_c14cb514(weapon);
    if (isdefined(stage.var_62b564ee.resetnotify)) {
        resettime = undefined;
        while (true) {
            if (stage.var_62b564ee.resettimer > 0) {
                if (!isdefined(resettime)) {
                    resettime = gettime() + stage.var_62b564ee.resettimer;
                }
                waittime = float(resettime - gettime()) / 1000;
                s_result = self waittilltimeout(waittime, stage.var_62b564ee.resetnotify);
            } else {
                s_result = self waittill(stage.var_62b564ee.resetnotify);
            }
            if (s_result._notify == #"timeout") {
                break;
            }
            if (isdefined(s_result.weapon) && baseweapon == s_result.weapon) {
                break;
            }
        }
    } else if (stage.var_62b564ee.resettimer > 0) {
        wait float(stage.var_62b564ee.resettimer) / 1000;
    } else {
        return;
    }
    if (is_true(stage.var_dd54a13b[activecamo.baseweapon].cleared)) {
        return;
    }
    stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
    stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
    activecamo.weapon = weapon;
    activecamo.baseweapon = baseweapon;
    self init_stages(activecamo, 1, 0);
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0x276decb4, Offset: 0x2ed0
// Size: 0x9a
function function_155299d(weapon, b_has_weapon = 1) {
    var_f4eb4a50 = undefined;
    if (b_has_weapon) {
        camooptions = self function_ade49959(weapon);
    } else {
        camooptions = self getbuildkitweaponoptions(weapon);
    }
    var_f4eb4a50 = function_edd6511(camooptions);
    return var_f4eb4a50;
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0xe9afa498, Offset: 0x2f78
// Size: 0x9a
function function_b004e227(weapon, b_has_weapon = 1) {
    activecamoname = undefined;
    if (b_has_weapon) {
        camooptions = self function_ade49959(weapon);
    } else {
        camooptions = self getbuildkitweaponoptions(weapon);
    }
    activecamoname = function_5af7df72(camooptions);
    return activecamoname;
}

/#

    // Namespace activecamo/activecamo_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc03b9531, Offset: 0x3020
    // Size: 0xe4
    function debug_error(message, weapon) {
        if (getdvarint(#"activecamo_debug", 0) > 0) {
            weaponname = "<dev string:x226>";
            if (isdefined(weapon)) {
                weaponname = "<dev string:x22a>" + function_9e72a96(weapon.name);
            }
            self iprintlnbold("<dev string:x238>" + message + weaponname);
            println("<dev string:x259>" + self.playername + "<dev string:x26f>" + message + weaponname);
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 2, eflags: 0x0
    // Checksum 0xc1022af7, Offset: 0x3110
    // Size: 0xe4
    function debug_print(message, weapon) {
        if (getdvarint(#"activecamo_debug", 0) > 0) {
            weaponname = "<dev string:x226>";
            if (isdefined(weapon)) {
                weaponname = "<dev string:x22a>" + function_9e72a96(weapon.name);
            }
            self iprintlnbold("<dev string:x259>" + message + weaponname);
            println("<dev string:x259>" + self.playername + "<dev string:x26f>" + message + weaponname);
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3c640fb1, Offset: 0x3200
    // Size: 0xc4
    function function_265047c1() {
        callback::on_connect(&on_player_connect);
        callback::on_disconnect(&on_player_disconnect);
        level.var_630fbd77 = "<dev string:x275>" + 30 + "<dev string:x294>";
        root = "<dev string:x299>" + level.var_630fbd77;
        function_1039ce5c(root);
        thread devgui_think();
        thread function_12e53b2d();
    }

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0x12952189, Offset: 0x32d0
    // Size: 0x34
    function on_player_connect() {
        if (self getentnum() < 4) {
            self thread devgui_player_connect();
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0x86867e0a, Offset: 0x3310
    // Size: 0x34
    function on_player_disconnect() {
        if (self getentnum() < 4) {
            self thread devgui_player_disconnect();
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf473f9be, Offset: 0x3350
    // Size: 0xbe
    function devgui_player_connect() {
        if (!isdefined(level.var_630fbd77)) {
            return;
        }
        wait 2;
        root = level.var_630fbd77 + "<dev string:x2a8>";
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] != self) {
                continue;
            }
            thread devgui_add_player_commands(root, players[i].playername, i + 1);
            return;
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe823a8f5, Offset: 0x3418
    // Size: 0x74
    function devgui_player_disconnect() {
        if (!isdefined(level.var_630fbd77)) {
            return;
        }
        root = level.var_630fbd77 + "<dev string:x2a8>";
        cmd = "<dev string:x2b4>" + root + self.playername + "<dev string:x2c6>";
        thread util::add_debug_command(cmd);
    }

    // Namespace activecamo/activecamo_shared
    // Params 3, eflags: 0x0
    // Checksum 0xc1944aa7, Offset: 0x3498
    // Size: 0xac
    function devgui_add_player_commands(root, pname, index) {
        add_cmd_with_root = "<dev string:x299>" + root + pname + "<dev string:x294>";
        function_f1d01720(add_cmd_with_root, index);
        function_85cb822d(add_cmd_with_root, index);
        function_de358bfd(add_cmd_with_root, index);
        function_50d79d31(add_cmd_with_root, index);
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0x212188af, Offset: 0x3550
    // Size: 0x44
    function function_1039ce5c(root) {
        cmd = root + "<dev string:x2cc>" + "<dev string:x2dc>";
        thread util::add_debug_command(cmd);
    }

    // Namespace activecamo/activecamo_shared
    // Params 2, eflags: 0x0
    // Checksum 0x3a73e22d, Offset: 0x35a0
    // Size: 0xbc
    function function_f1d01720(root, index) {
        var_37949de1 = root;
        if (!isdefined(index)) {
            index = 0;
        }
        cmd = root + "<dev string:x2ff>" + "<dev string:x30a>" + index + "<dev string:x340>";
        thread util::add_debug_command(cmd);
        cmd = root + "<dev string:x347>" + "<dev string:x352>" + index + "<dev string:x340>";
        thread util::add_debug_command(cmd);
    }

    // Namespace activecamo/activecamo_shared
    // Params 2, eflags: 0x0
    // Checksum 0x9bf29af5, Offset: 0x3668
    // Size: 0x158
    function function_85cb822d(root, index) {
        var_37949de1 = root + "<dev string:x383>";
        if (!isdefined(index)) {
            index = 0;
        }
        activecamos = function_2c48197b();
        foreach (activecamo in activecamos) {
            if (activecamo == #"") {
                continue;
            }
            activecamoname = function_9e72a96(activecamo);
            cmd = var_37949de1 + activecamoname + "<dev string:x38d>" + activecamoname + "<dev string:x3be>" + index + "<dev string:x340>";
            thread util::add_debug_command(cmd);
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 2, eflags: 0x0
    // Checksum 0x1f6eab7f, Offset: 0x37c8
    // Size: 0x148
    function function_de358bfd(root, index) {
        var_1520a1da = root + "<dev string:x3d9>";
        if (!isdefined(index)) {
            index = 0;
        }
        weapons = [];
        weapons[0] = "<dev string:x3e5>";
        weapons[1] = "<dev string:x3f7>";
        weapons[2] = "<dev string:x40d>";
        weapons[3] = "<dev string:x420>";
        foreach (weapon in weapons) {
            cmd = var_1520a1da + weapon + "<dev string:x433>" + weapon + "<dev string:x3be>" + index + "<dev string:x340>";
            thread util::add_debug_command(cmd);
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 2, eflags: 0x0
    // Checksum 0x4b9477f0, Offset: 0x3918
    // Size: 0x168
    function function_50d79d31(root, index) {
        var_82c49718 = root + "<dev string:x467>";
        if (!isdefined(index)) {
            index = 0;
        }
        stages = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
        foreach (stage in stages) {
            cmd = var_82c49718 + stage + "<dev string:x475>" + stage + "<dev string:x3be>" + index + "<dev string:x340>";
            thread util::add_debug_command(cmd);
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0x21450ade, Offset: 0x3a88
    // Size: 0x330
    function devgui_think() {
        self notify("<dev string:x4a7>");
        self endon("<dev string:x4a7>");
        for (;;) {
            wait 0.5;
            reset = 1;
            host = util::gethostplayer();
            switch (getdvarstring(#"hash_3e1bb44a57b02ed8")) {
            case 0:
                reset = 0;
                break;
            case #"debugprints":
                setdvar(#"activecamo_debug", !getdvarint(#"activecamo_debug", 0));
                break;
            case #"reset":
                function_cc5baf7f(&function_58719455);
                break;
            case #"stage_next":
                function_cc5baf7f(&function_3ac4d286, 0);
                break;
            case #"stage_prev":
                function_cc5baf7f(&function_3ac4d286, 1);
                break;
            case #"set_camo":
                function_cc5baf7f(&function_9c361e56, getdvarstring(#"hash_3fe8dd280c325e8"));
                break;
            case #"give_weapon":
                function_cc5baf7f(&function_cc486b05, getdvarstring(#"hash_3fe8dd280c325e8"));
                break;
            case #"set_stage":
                function_cc5baf7f(&function_779a9561, getdvarstring(#"hash_3fe8dd280c325e8"));
                break;
            }
            if (reset) {
                setdvar(#"hash_3e1bb44a57b02ed8", "<dev string:x226>");
                setdvar(#"hash_3fe8dd280c325e8", "<dev string:x226>");
                setdvar(#"hash_324a391b56cb100", "<dev string:x226>");
            }
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 2, eflags: 0x0
    // Checksum 0x5b483cfe, Offset: 0x3dc0
    // Size: 0x152
    function function_cc5baf7f(callback, par) {
        pid = getdvarint(#"hash_324a391b56cb100", 0);
        if (pid > 0) {
            player = getplayers()[pid - 1];
            if (isdefined(player)) {
                if (isdefined(par)) {
                    player [[ callback ]](par);
                } else {
                    player [[ callback ]]();
                }
            }
            return;
        }
        players = getplayers();
        foreach (player in players) {
            if (isdefined(par)) {
                player [[ callback ]](par);
                continue;
            }
            player [[ callback ]]();
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0xca8944cc, Offset: 0x3f20
    // Size: 0x5c
    function function_cc486b05(weaponname) {
        weapon = getweapon(weaponname);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5d287b0a, Offset: 0x3f88
    // Size: 0x47c
    function function_779a9561(stagenum) {
        weapon = self getcurrentweapon();
        weapon = function_94c2605(weapon);
        activecamoname = function_b004e227(weapon);
        if (isdefined(activecamoname)) {
            activecamo = self.pers[#"activecamo"][activecamoname];
            if (isdefined(activecamo) && isdefined(activecamo.stages) && stagenum < activecamo.stages.size) {
                activecamo.weapon = weapon;
                activecamo.baseweapon = function_c14cb514(activecamo.weapon);
                if (is_true(activecamo.var_13949c61.istiered)) {
                    foreach (key, stage in activecamo.stages) {
                        statcount = 0;
                        if (key < stagenum) {
                            statcount = stage.var_62b564ee.var_e2dbd42d;
                        }
                        if (isdefined(stage.var_62b564ee.permanentstatname)) {
                            self stats::set_stat_global(stage.var_62b564ee.permanentstatname, statcount);
                        } else if (isdefined(stage.var_62b564ee.statname)) {
                            if (is_true(stage.var_62b564ee.permanent)) {
                                self stats::set_stat_global(stage.var_62b564ee.statname, statcount);
                            }
                        }
                        stage.var_dd54a13b[activecamo.baseweapon].statvalue = statcount;
                        stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
                    }
                } else if (is_true(activecamo.var_13949c61.var_2034fabe)) {
                    activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = undefined;
                    foreach (key, stage in activecamo.stages) {
                        statcount = 0;
                        if (key < stagenum) {
                            statcount = stage.var_62b564ee.var_e2dbd42d;
                        }
                        if (isdefined(stage.var_62b564ee.permanentstatname)) {
                            self stats::set_stat_global(stage.var_62b564ee.permanentstatname, statcount);
                        } else if (isdefined(stage.var_62b564ee.statname)) {
                            statcount = 0;
                            if (key == stagenum) {
                                statcount = stage.var_62b564ee.var_e2dbd42d;
                            }
                            if (is_true(stage.var_62b564ee.permanent)) {
                                self stats::set_stat_global(stage.var_62b564ee.statname, statcount);
                            }
                        }
                        stage.var_dd54a13b[activecamo.baseweapon].statvalue = statcount;
                        stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
                    }
                }
                self function_b9119037(activecamo);
            }
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0x42df1b39, Offset: 0x4410
    // Size: 0x74
    function function_9c361e56(activecamoname) {
        var_f4eb4a50 = getscriptbundle(activecamoname);
        weapon = self getcurrentweapon();
        if (isdefined(var_f4eb4a50)) {
            self init_activecamo(weapon, var_f4eb4a50, 1);
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc3ed8f4a, Offset: 0x4490
    // Size: 0x4c
    function function_3ac4d286(back) {
        weapon = self getcurrentweapon();
        self function_633fbf17(weapon, back);
    }

    // Namespace activecamo/activecamo_shared
    // Params 2, eflags: 0x0
    // Checksum 0x76de70ba, Offset: 0x44e8
    // Size: 0x1ac
    function function_633fbf17(weapon, back) {
        if (isdefined(weapon)) {
            self function_8d3b94ea(weapon, 1);
            weapon = function_94c2605(weapon);
            activecamoname = function_b004e227(weapon);
            if (isdefined(activecamoname)) {
                activecamo = self.pers[#"activecamo"][activecamoname];
                if (isdefined(activecamo)) {
                    if (isdefined(activecamo.stages)) {
                        activecamo.weapon = weapon;
                        activecamo.baseweapon = function_c14cb514(activecamo.weapon);
                        currentstage = isdefined(activecamo.var_dd54a13b[activecamo.baseweapon].stagenum) ? activecamo.var_dd54a13b[activecamo.baseweapon].stagenum : -1;
                        if (back) {
                            nextstage = (currentstage - 1 + activecamo.stages.size) % activecamo.stages.size;
                        } else {
                            nextstage = (currentstage + 1) % activecamo.stages.size;
                        }
                        self function_779a9561(nextstage);
                    }
                }
            }
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5eac948, Offset: 0x46a0
    // Size: 0x3c
    function function_58719455() {
        weapon = self getcurrentweapon();
        self function_3d928fb4(weapon);
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0x93446251, Offset: 0x46e8
    // Size: 0xf4
    function function_3d928fb4(weapon) {
        if (isdefined(weapon)) {
            self function_8d3b94ea(weapon, 1);
            weapon = function_94c2605(weapon);
            activecamoname = function_b004e227(weapon);
            if (isdefined(activecamoname)) {
                activecamo = self.pers[#"activecamo"][activecamoname];
                if (isdefined(activecamo)) {
                    activecamo.weapon = weapon;
                    activecamo.baseweapon = function_c14cb514(activecamo.weapon);
                    self function_9fc8a57c(activecamo);
                }
            }
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0x71eb3cb0, Offset: 0x47e8
    // Size: 0xcc
    function function_9fc8a57c(activecamo) {
        if (isdefined(activecamo)) {
            if (isdefined(activecamo.stages)) {
                foreach (stage in activecamo.stages) {
                    self function_dc6014e8(stage);
                }
                self init_stages(activecamo, 1, 0);
            }
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0x92835046, Offset: 0x48c0
    // Size: 0xbc
    function function_dc6014e8(stage) {
        if (isdefined(stage.var_62b564ee.permanentstatname)) {
            self stats::set_stat_global(stage.var_62b564ee.permanentstatname, 0);
            return;
        }
        if (isdefined(stage.var_62b564ee.statname)) {
            if (is_true(stage.var_62b564ee.permanent)) {
                self stats::set_stat_global(stage.var_62b564ee.statname, 0);
            }
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe776bf3a, Offset: 0x4988
    // Size: 0x20c
    function function_12e53b2d() {
        self notify("<dev string:x4bb>");
        self endon("<dev string:x4bb>");
        while (true) {
            var_f4eb4a50 = undefined;
            waitresult = level waittill(#"liveupdate");
            if (!isdefined(level.activecamoinfo)) {
                continue;
            }
            if (isdefined(waitresult.scriptbundlename)) {
                var_f4eb4a50 = getscriptbundle(waitresult.scriptbundlename);
                if (!isdefined(var_f4eb4a50.name)) {
                    continue;
                }
                if (!isdefined(level.activecamoinfo[var_f4eb4a50.name])) {
                    continue;
                }
                players = getplayers();
                foreach (player in players) {
                    if (!isalive(player)) {
                        continue;
                    }
                    if (!isdefined(player.pers[#"activecamo"][var_f4eb4a50.name])) {
                        continue;
                    }
                    activecamo = player.pers[#"activecamo"][var_f4eb4a50.name];
                    if (isdefined(activecamo.weapon)) {
                        player init_activecamo(activecamo.weapon, var_f4eb4a50, 1);
                    }
                }
            }
        }
    }

    // Namespace activecamo/activecamo_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2c6dd28, Offset: 0x4ba0
    // Size: 0x126
    function function_b008f9e9(weapon) {
        if (!isdefined(level.activecamoinfo)) {
            return;
        }
        if (self getcurrentweapon() != weapon) {
            self switchtoweapon(weapon);
            self waittilltimeout(2, #"weapon_change");
        }
        foreach (var_13949c61 in level.activecamoinfo) {
            var_f4eb4a50 = getscriptbundle(var_13949c61.name);
            self init_activecamo(weapon, var_f4eb4a50, 1);
            waitframe(1);
        }
    }

#/
