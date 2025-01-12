#using script_474309807eb94f34;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace activecamo;

// Namespace activecamo/activecamo_shared
// Params 0, eflags: 0x6
// Checksum 0x48746200, Offset: 0x168
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"activecamo", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace activecamo/activecamo_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x7ec800f1, Offset: 0x1b0
// Size: 0x104
function private function_70a657d8() {
    callback::add_callback(#"updateactivecamo", &updateactivecamo);
    callback::on_spawned(&on_player_spawned);
    callback::on_weapon_change(&on_weapon_change);
    callback::on_localplayer_spawned(&on_local_player_spawned);
    level.var_b9b11197 = getgametypesetting(#"hash_1f3825ba2a669400");
    if (!isdefined(level.var_ab319180)) {
        level.var_ab319180 = [];
    }
    level.var_ab319180[getweapon(#"sniper_mini14_t8")] = 1;
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc4547e99, Offset: 0x2c0
// Size: 0x1b8
function on_local_player_spawned(localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    players = getplayers(localclientnum);
    foreach (player in players) {
        if (!isdefined(player) || !player isplayer() || !isalive(player)) {
            continue;
        }
        if (player function_21c0fa55()) {
            continue;
        }
        if (!player hasdobj(localclientnum)) {
            continue;
        }
        weapon = player function_d2c2b168();
        weaponoptions = player function_e10e6c37();
        stagenum = getactivecamostage(weaponoptions);
        player update_active_camo(localclientnum, weapon, "tag_weapon_right", stagenum, 0, 1, weaponoptions);
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xaf69e753, Offset: 0x480
// Size: 0xd4
function on_weapon_change(params) {
    if (self == level || !isplayer(self)) {
        return;
    }
    localclientnum = params.localclientnum;
    weapon = self function_d2c2b168();
    weaponoptions = self function_e10e6c37();
    stagenum = getactivecamostage(weaponoptions);
    self update_active_camo(localclientnum, weapon, "tag_weapon_right", stagenum, 0, 1, weaponoptions);
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xb7c657f7, Offset: 0x560
// Size: 0x9c
function on_player_spawned(localclientnum) {
    weapon = self function_d2c2b168();
    weaponoptions = self function_e10e6c37();
    stagenum = getactivecamostage(weaponoptions);
    self update_active_camo(localclientnum, weapon, "tag_weapon_right", stagenum, 0, 1, weaponoptions);
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2f4e7a41, Offset: 0x608
// Size: 0x72
function function_ae141bf2(camoindex) {
    activecamoinfo = undefined;
    activecamoname = getactivecamo(camoindex);
    if (isdefined(activecamoname) && activecamoname != #"") {
        activecamoinfo = getscriptbundle(activecamoname);
    }
    return activecamoinfo;
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x5a7ae80e, Offset: 0x688
// Size: 0x42
function function_3d96ad48(camooptions) {
    camoindex = getcamoindex(camooptions);
    return function_ae141bf2(camoindex);
}

// Namespace activecamo/activecamo_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x95016315, Offset: 0x6d8
// Size: 0x13e
function function_451a49f4(localclientnum, activecamoinfo, weapon, stagenum) {
    activecamo = self init_activecamo(activecamoinfo);
    if (isdefined(activecamo)) {
        if (!isdefined(activecamo.var_fe56592)) {
            activecamo.var_fe56592 = [];
        }
        if (!isdefined(activecamo.var_fe56592[localclientnum])) {
            activecamo.var_fe56592[localclientnum] = {};
        }
        if (!isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b)) {
            activecamo.var_fe56592[localclientnum].var_dd54a13b = [];
        }
        baseweapon = function_c14cb514(weapon);
        if (!isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon])) {
            activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon] = {};
        }
        activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum = stagenum;
    }
    return activecamo;
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xfc3ce87, Offset: 0x820
// Size: 0x1ac
function function_130e0542(localclientnum, weapon, camoindex) {
    init_stage = 0;
    activecamoinfo = function_ae141bf2(camoindex);
    activecamo = self init_activecamo(activecamoinfo);
    if (isdefined(activecamo)) {
        if (isdefined(activecamo.info.stages)) {
            var_f8bf269c = 0;
            foreach (key, stage in activecamo.info.stages) {
                if (isdefined(stage.permanentstatname)) {
                    camo_stat = stats::get_stat_global(localclientnum, stage.permanentstatname);
                    if (isdefined(camo_stat) && camo_stat >= stage.var_e2dbd42d) {
                        var_f8bf269c = 1;
                        continue;
                    }
                }
                if (var_f8bf269c || stage.var_19b6044e === camoindex) {
                    init_stage = key;
                    break;
                }
            }
        }
        return function_451a49f4(localclientnum, activecamoinfo, weapon, init_stage);
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0x1769975c, Offset: 0x9d8
// Size: 0x9a
function function_95f12bac(localclientnum, weapon, weaponoptions) {
    camoindex = getcamoindex(weaponoptions);
    stagenum = getactivecamostage(weaponoptions);
    activecamoinfo = function_ae141bf2(camoindex);
    return function_451a49f4(localclientnum, activecamoinfo, weapon, stagenum);
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x308cb7d2, Offset: 0xa80
// Size: 0x9c
function updateactivecamo(localclientnum, eventstruct) {
    weaponoptions = self function_e10e6c37();
    stagenum = getactivecamostage(weaponoptions);
    self update_active_camo(localclientnum, eventstruct.weapon, eventstruct.tagname, stagenum, eventstruct.impulse, 0, eventstruct.camooptions);
}

// Namespace activecamo/activecamo_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x38b6faef, Offset: 0xb28
// Size: 0x73c
function update_active_camo(localclientnum, weapon, tagname, stagenum, impulse, var_d71e8c6e, camooptions) {
    var_d1460f46 = isdefined(tagname) && tagname == "tag_stowed_back";
    self function_7a55e60a(var_d1460f46);
    activecamoinfo = function_3d96ad48(camooptions);
    if (!isdefined(activecamoinfo)) {
        function_3e27a7cb(localclientnum, tagname);
        return;
    }
    activecamo = self init_activecamo(activecamoinfo);
    if (!isdefined(activecamo) || !isdefined(activecamo.info) || !isdefined(activecamo.info.stages)) {
        function_3e27a7cb(localclientnum, tagname);
        return;
    }
    stage = activecamo.info.stages[stagenum];
    if (!isdefined(stage)) {
        function_3e27a7cb(localclientnum, tagname);
        return;
    }
    if (!isdefined(activecamo.var_fe56592)) {
        activecamo.var_fe56592 = [];
    }
    if (!isdefined(activecamo.var_fe56592[localclientnum])) {
        activecamo.var_fe56592[localclientnum] = {};
    }
    if (!isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b)) {
        activecamo.var_fe56592[localclientnum].var_dd54a13b = [];
    }
    baseweapon = function_c14cb514(weapon);
    if (!isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon])) {
        activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon] = {};
    }
    var_58bac2d = function_16d7447b(localclientnum, tagname);
    if (isdefined(var_58bac2d.crob) && var_58bac2d.crob !== stage.rob) {
        function_3e27a7cb(localclientnum, tagname);
    }
    self function_a946fb86(activecamo, stagenum, var_d1460f46);
    var_5bdd03ea = 0;
    if (self function_21c0fa55()) {
        var_5bdd03ea = isswitchingweapons(localclientnum);
        if (!var_5bdd03ea) {
            var_9a7e487a = activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum;
            if (isdefined(var_9a7e487a) && var_9a7e487a < stagenum) {
                laststage = activecamo.info.stages[var_9a7e487a];
                if (isdefined(laststage.var_1c54e7b8)) {
                    playsound(localclientnum, laststage.var_1c54e7b8);
                } else if (isdefined(stage.var_a000b430)) {
                    playsound(localclientnum, stage.var_a000b430);
                }
                if (isdefined(stage.var_2a4f6f28)) {
                    util::playfxontag(localclientnum, stage.var_2a4f6f28, self, tagname);
                }
                fx = stage.var_9828c877;
                if (isdefined(weapon)) {
                    switch (weapon.weapclass) {
                    case #"rocketlauncher":
                    case #"mg":
                    case #"rifle":
                        fx = stage.var_69896523;
                        break;
                    case #"pistol":
                        fx = stage.var_bafc7841;
                        break;
                    default:
                        break;
                    }
                }
                if (isdefined(fx)) {
                    playviewmodelfx(localclientnum, fx, "tag_flash");
                }
            }
            if (is_true(impulse) && isdefined(stage.var_8fc4c50d)) {
                playsound(localclientnum, stage.var_8fc4c50d);
            }
        }
    }
    activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum = stagenum;
    var_58bac2d.crob = stage.rob;
    var_d71e8c6e = var_d71e8c6e || var_5bdd03ea;
    if (isdefined(stage.rob) && tagname == "tag_weapon_right") {
        if (!self function_d2503806(stage.rob, tagname)) {
            self playrenderoverridebundle(stage.rob, tagname);
        }
        self callback::add_entity_callback(#"death", &player_on_death);
        for (layer = 1; layer <= 3; layer++) {
            self thread function_42887bfe(stage, tagname, layer, impulse, var_d71e8c6e);
        }
        self thread function_c55b3123(stage, tagname, "Diffuse2 Alpha", stage.var_2eeeee1b, stage.diffuse2alpha, var_d71e8c6e);
        self thread function_c55b3123(stage, tagname, "Diffuse3 Alpha", stage.var_7a3e0e45, stage.diffuse3alpha, var_d71e8c6e);
    }
    aries_is_ = stagenum + 1;
    if (isdefined(activecamo.info.stages[aries_is_])) {
        nextstage = activecamo.info.stages[aries_is_];
        if (isdefined(nextstage.var_19b6044e)) {
            weaponoptions = self function_ade49959();
            function_d780f794(localclientnum, weapon, weaponoptions, nextstage.var_19b6044e);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xea389287, Offset: 0x1270
// Size: 0x64
function player_on_death(params) {
    self function_3e27a7cb(params.localclientnum, "tag_weapon_right");
    self callback::function_52ac9652(#"death", &player_on_death);
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x827f369f, Offset: 0x12e0
// Size: 0x6e
function function_3e27a7cb(localclientnum, tagname) {
    var_58bac2d = function_16d7447b(localclientnum, tagname);
    if (isdefined(var_58bac2d.crob)) {
        self stoprenderoverridebundle(var_58bac2d.crob, tagname);
        var_58bac2d.crob = undefined;
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x25d6f285, Offset: 0x1358
// Size: 0x140
function function_a946fb86(activecamo, stagenum, var_d1460f46) {
    foreach (key, stage in activecamo.info.stages) {
        if (key > stagenum) {
            break;
        }
        if (isdefined(stage.var_9fbd261d)) {
            if (is_true(stage.var_d04f3816) || key < stagenum && is_true(stage.var_413aa223) || key == stagenum && is_true(stage.var_2873d2ba)) {
                self function_f0d52864(stage.var_9fbd261d, var_d1460f46);
            }
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xe2d53eb5, Offset: 0x14a0
// Size: 0x86
function function_16d7447b(localclientnum, tagname) {
    if (!isdefined(self.var_32d117a2)) {
        self.var_32d117a2 = [];
    }
    if (!isdefined(self.var_32d117a2[localclientnum])) {
        self.var_32d117a2[localclientnum] = [];
    }
    if (!isdefined(self.var_32d117a2[localclientnum][tagname])) {
        self.var_32d117a2[localclientnum][tagname] = {};
    }
    return self.var_32d117a2[localclientnum][tagname];
}

// Namespace activecamo/activecamo_shared
// Params 6, eflags: 0x1 linked
// Checksum 0xaef1cd8d, Offset: 0x1530
// Size: 0x144
function function_c55b3123(stage, tagname, var_eb6a239c, lerptime, var_f023ca7d, var_d71e8c6e) {
    self endon(#"death", #"weapon_change");
    if (!var_d71e8c6e && lerptime > 0) {
        endtime = gettime() + stage.var_2eeeee1b * 1000;
        do {
            waitframe(1);
            if (!isdefined(self) || !isplayer(self)) {
                return;
            }
            currenttime = gettime();
            var_31cfb10 = var_f023ca7d;
            if (!isplayer(self)) {
                return;
            }
            self function_78233d29(stage.rob, tagname, var_eb6a239c, var_31cfb10);
        } while (currenttime <= endtime);
    }
    self function_78233d29(stage.rob, tagname, var_eb6a239c, var_f023ca7d);
}

// Namespace activecamo/activecamo_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x96cde02f, Offset: 0x1680
// Size: 0x62c
function function_42887bfe(stage, tagname, layer, impulse, var_d71e8c6e) {
    self endon(#"death", #"weapon_change");
    var_238c3eeb = "Layer" + layer;
    var_604ae5c3 = var_238c3eeb + " Brightness";
    var_d6637dc6 = var_238c3eeb + " Fade";
    var_ea35682d = var_238c3eeb + " Tint";
    var_d1732bd2 = "robLayer" + layer;
    var_27c1d8a2 = var_d1732bd2 + "_Brightness";
    var_f5747b8 = var_d1732bd2 + "_Fade";
    var_4a72a14a = var_d1732bd2 + "_LerpTime";
    var_7fd61736 = var_d1732bd2 + "_Tint";
    if (!var_d71e8c6e && impulse) {
        var_b96a2aa7 = var_27c1d8a2 + "_i";
        var_ffcf1e1a = var_f5747b8 + "_i";
        var_b6cde499 = var_4a72a14a + "_i";
        var_bc211a50 = var_7fd61736 + "_i";
        lerptime = isdefined(stage.(var_b6cde499)) ? stage.(var_b6cde499) : 0;
        brightness = isdefined(stage.(var_b96a2aa7)) ? stage.(var_b96a2aa7) : 0;
        fade = isdefined(stage.(var_ffcf1e1a)) ? stage.(var_ffcf1e1a) : 0;
        tint = isdefined(stage.(var_bc211a50)) ? stage.(var_bc211a50) : 0;
        if (lerptime > 0) {
            endtime = gettime() + lerptime * 1000;
            do {
                waitframe(1);
                if (!isdefined(self) || !isplayer(self)) {
                    return;
                }
                currenttime = gettime();
                var_b9c539b7 = brightness;
                var_a5e1ab6c = fade;
                var_df9b6bd0 = tint;
                self function_78233d29(stage.rob, tagname, var_604ae5c3, var_b9c539b7);
                self function_78233d29(stage.rob, tagname, var_d6637dc6, var_a5e1ab6c);
                self function_78233d29(stage.rob, tagname, var_ea35682d, var_df9b6bd0);
            } while (currenttime <= endtime);
        }
        self function_78233d29(stage.rob, tagname, var_604ae5c3, brightness);
        self function_78233d29(stage.rob, tagname, var_d6637dc6, fade);
        self function_78233d29(stage.rob, tagname, var_ea35682d, tint);
        wait max(lerptime, 0.5);
        if (!isdefined(self) || !isplayer(self)) {
            return;
        }
    }
    lerptime = isdefined(stage.(var_4a72a14a)) ? stage.(var_4a72a14a) : 0;
    brightness = isdefined(stage.(var_27c1d8a2)) ? stage.(var_27c1d8a2) : 0;
    fade = isdefined(stage.(var_f5747b8)) ? stage.(var_f5747b8) : 0;
    tint = isdefined(stage.(var_7fd61736)) ? stage.(var_7fd61736) : 0;
    if (!var_d71e8c6e && lerptime > 0) {
        endtime = gettime() + lerptime * 1000;
        do {
            waitframe(1);
            if (!isdefined(self) || !isplayer(self)) {
                return;
            }
            currenttime = gettime();
            var_b9c539b7 = brightness;
            var_a5e1ab6c = fade;
            var_df9b6bd0 = tint;
            self function_78233d29(stage.rob, tagname, var_604ae5c3, var_b9c539b7);
            self function_78233d29(stage.rob, tagname, var_d6637dc6, var_a5e1ab6c);
            self function_78233d29(stage.rob, tagname, var_ea35682d, var_df9b6bd0);
        } while (currenttime <= endtime);
    }
    self function_78233d29(stage.rob, tagname, var_604ae5c3, brightness);
    self function_78233d29(stage.rob, tagname, var_d6637dc6, fade);
    self function_78233d29(stage.rob, tagname, var_ea35682d, tint);
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x80d43ac2, Offset: 0x1cb8
// Size: 0x58e
function function_3aa81e0e(activecamoinfo) {
    info = undefined;
    if (isdefined(activecamoinfo) && isdefined(activecamoinfo.name)) {
        if (!isdefined(level.activecamoinfo)) {
            level.activecamoinfo = [];
        }
        if (isdefined(level.activecamoinfo[activecamoinfo.name])) {
            return level.activecamoinfo[activecamoinfo.name];
        }
        if (!isdefined(level.activecamoinfo[activecamoinfo.name])) {
            level.activecamoinfo[activecamoinfo.name] = {};
        }
        info = level.activecamoinfo[activecamoinfo.name];
        if (isdefined(activecamoinfo.stages)) {
            if (!isdefined(info.stages)) {
                info.stages = [];
            }
            var_d3daabe = 0;
            foreach (key, var_3594168e in activecamoinfo.stages) {
                if (is_true(var_3594168e.disabled)) {
                    var_d3daabe++;
                    continue;
                }
                if (!isdefined(info.stages[key - var_d3daabe])) {
                    info.stages[key - var_d3daabe] = {};
                }
                stage = info.stages[key - var_d3daabe];
                stage.rob = var_3594168e.rob;
                if (isdefined(var_3594168e.camooption)) {
                    stage.var_19b6044e = function_8b51d9d1(var_3594168e.camooption);
                }
                stage.var_9fbd261d = var_3594168e.var_9fbd261d;
                stage.permanentstatname = var_3594168e.permanentstatname;
                stage.var_e2dbd42d = isdefined(var_3594168e.var_e2dbd42d) ? var_3594168e.var_e2dbd42d : 0;
                if (isdefined(stage.var_9fbd261d)) {
                    stage.var_d04f3816 = var_3594168e.var_d04f3816;
                    stage.var_413aa223 = var_3594168e.var_413aa223;
                    stage.var_2873d2ba = var_3594168e.var_2873d2ba;
                }
                if (is_true(level.var_b9b11197)) {
                    stage.var_1c54e7b8 = var_3594168e.var_1c54e7b8;
                    stage.var_a000b430 = var_3594168e.var_a000b430;
                    stage.var_8fc4c50d = var_3594168e.var_8fc4c50d;
                }
                stage.var_bafc7841 = var_3594168e.var_bafc7841;
                stage.var_9828c877 = var_3594168e.var_9828c877;
                stage.var_69896523 = var_3594168e.var_69896523;
                for (layer = 1; layer <= 3; layer++) {
                    var_d1732bd2 = "robLayer" + layer;
                    var_4a72a14a = var_d1732bd2 + "_LerpTime";
                    var_27c1d8a2 = var_d1732bd2 + "_Brightness";
                    var_f5747b8 = var_d1732bd2 + "_Fade";
                    var_7fd61736 = var_d1732bd2 + "_Tint";
                    stage.(var_4a72a14a) = var_3594168e.(var_4a72a14a);
                    stage.(var_27c1d8a2) = var_3594168e.(var_27c1d8a2);
                    stage.(var_f5747b8) = var_3594168e.(var_f5747b8);
                    stage.(var_7fd61736) = var_3594168e.(var_7fd61736);
                    var_b6cde499 = var_4a72a14a + "_i";
                    var_b96a2aa7 = var_27c1d8a2 + "_i";
                    var_ffcf1e1a = var_f5747b8 + "_i";
                    var_bc211a50 = var_7fd61736 + "_i";
                    stage.(var_b6cde499) = var_3594168e.(var_b6cde499);
                    stage.(var_b96a2aa7) = var_3594168e.(var_b96a2aa7);
                    stage.(var_ffcf1e1a) = var_3594168e.(var_ffcf1e1a);
                    stage.(var_bc211a50) = var_3594168e.(var_bc211a50);
                }
                stage.diffuse2alpha = isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0;
                stage.var_2eeeee1b = isdefined(var_3594168e.var_2eeeee1b) ? var_3594168e.var_2eeeee1b : 0;
                stage.diffuse3alpha = isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0;
                stage.var_7a3e0e45 = isdefined(var_3594168e.var_7a3e0e45) ? var_3594168e.var_7a3e0e45 : 0;
            }
        }
    }
    return info;
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xba4f88d4, Offset: 0x2250
// Size: 0xca
function init_activecamo(activecamoinfo) {
    if (isdefined(activecamoinfo)) {
        if (!isdefined(self.var_9413f8b4)) {
            self.var_9413f8b4 = [];
        }
        if (isdefined(self.var_9413f8b4[activecamoinfo.name])) {
            return self.var_9413f8b4[activecamoinfo.name];
        }
        if (!isdefined(self.var_9413f8b4[activecamoinfo.name])) {
            self.var_9413f8b4[activecamoinfo.name] = {};
        }
        activecamo = self.var_9413f8b4[activecamoinfo.name];
        activecamo.info = function_3aa81e0e(activecamoinfo);
        return activecamo;
    }
    return undefined;
}

// Namespace activecamo/activecamo_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x6adf807, Offset: 0x2328
// Size: 0x418
function function_374e37a0(localclientnum, weaponmodel, var_3594168e, &var_49daa2f6) {
    tagname = "tag_origin";
    stage = {};
    stage.rob = var_3594168e.rob;
    if (!isdefined(stage.rob)) {
        return false;
    }
    stage.diffuse2alpha = isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0;
    stage.var_2eeeee1b = isdefined(var_3594168e.var_2eeeee1b) ? var_3594168e.var_2eeeee1b : 0;
    stage.diffuse3alpha = isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0;
    stage.var_7a3e0e45 = isdefined(var_3594168e.var_7a3e0e45) ? var_3594168e.var_7a3e0e45 : 0;
    if (!weaponmodel function_d2503806(stage.rob, tagname)) {
        weaponmodel playrenderoverridebundle(stage.rob, tagname);
        var_49daa2f6[localclientnum] = stage.rob;
    }
    for (layer = 1; layer <= 3; layer++) {
        var_d1732bd2 = "robLayer" + layer;
        var_27c1d8a2 = var_d1732bd2 + "_Brightness";
        var_f5747b8 = var_d1732bd2 + "_Fade";
        var_7fd61736 = var_d1732bd2 + "_Tint";
        stage.(var_27c1d8a2) = isdefined(var_3594168e.(var_27c1d8a2)) ? var_3594168e.(var_27c1d8a2) : 0;
        stage.(var_f5747b8) = isdefined(var_3594168e.(var_f5747b8)) ? var_3594168e.(var_f5747b8) : 0;
        stage.(var_7fd61736) = isdefined(var_3594168e.(var_7fd61736)) ? var_3594168e.(var_7fd61736) : 0;
        var_238c3eeb = "Layer" + layer;
        var_604ae5c3 = var_238c3eeb + " Brightness";
        var_d6637dc6 = var_238c3eeb + " Fade";
        var_ea35682d = var_238c3eeb + " Tint";
        weaponmodel function_78233d29(stage.rob, tagname, var_604ae5c3, stage.(var_27c1d8a2));
        weaponmodel function_78233d29(stage.rob, tagname, var_d6637dc6, stage.(var_f5747b8));
        weaponmodel function_78233d29(stage.rob, tagname, var_ea35682d, stage.(var_7fd61736));
    }
    diffuse2alpha = isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0;
    diffuse3alpha = isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0;
    weaponmodel function_78233d29(stage.rob, tagname, "Diffuse2 Alpha", diffuse2alpha);
    weaponmodel function_78233d29(stage.rob, tagname, "Diffuse3 Alpha", diffuse3alpha);
    return true;
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x48aa4243, Offset: 0x2748
// Size: 0xbc
function function_cbfd8fd6(localclientnum) {
    if (isdefined(self.weapon)) {
        weaponoptions = self function_e10e6c37();
        camoindex = getcamoindex(weaponoptions);
        activecamoinfo = function_ae141bf2(camoindex);
        if (isdefined(activecamoinfo)) {
            stagenum = getactivecamostage(weaponoptions);
            self function_b3a0e4f0(localclientnum, activecamoinfo, stagenum);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf21ab6e2, Offset: 0x2810
// Size: 0x13c
function function_e40c785a(localclientnum) {
    weaponoptions = self function_e10e6c37();
    camoindex = getcamoindex(weaponoptions);
    activecamoinfo = function_ae141bf2(camoindex);
    if (isdefined(activecamoinfo)) {
        if (isdefined(activecamoinfo.stages)) {
            init_stage = 0;
            foreach (key, var_3594168e in activecamoinfo.stages) {
                if (isdefined(var_3594168e.permanentstatname)) {
                    continue;
                }
                init_stage = key;
                break;
            }
            self function_b3a0e4f0(localclientnum, activecamoinfo, init_stage);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x446c199e, Offset: 0x2958
// Size: 0x27c
function function_6efb762c(localclientnum, camoweapon, weaponoptions) {
    camoindex = getcamoindex(weaponoptions);
    activecamoinfo = function_ae141bf2(camoindex);
    if (isdefined(activecamoinfo)) {
        player = function_27673a7(localclientnum);
        activecamo = player init_activecamo(activecamoinfo);
        baseweapon = function_c14cb514(camoweapon);
        if (isdefined(activecamo)) {
            init_stage = getactivecamostage(weaponoptions);
            if (isdefined(activecamo.var_fe56592) && isdefined(activecamo.var_fe56592[localclientnum]) && isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon])) {
                init_stage = activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum;
            } else {
                activecamo = player function_130e0542(localclientnum, camoweapon, camoindex);
                if (isdefined(activecamo) && isdefined(activecamo.var_fe56592) && isdefined(activecamo.var_fe56592[localclientnum]) && isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon])) {
                    init_stage = activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum;
                }
            }
            if (isdefined(activecamoinfo.stages)) {
                var_3594168e = activecamoinfo.stages[init_stage];
                if (isdefined(var_3594168e)) {
                    var_19b6044e = function_8b51d9d1(var_3594168e.camooption);
                    self setcamo(var_19b6044e);
                    self setactivecamostage(init_stage);
                }
            }
            self function_b3a0e4f0(localclientnum, activecamoinfo, init_stage);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x8ed1ccf7, Offset: 0x2be0
// Size: 0x94
function function_b3a0e4f0(localclientnum, activecamoinfo, init_stage) {
    if (isdefined(activecamoinfo) && isdefined(activecamoinfo.stages)) {
        var_3594168e = activecamoinfo.stages[init_stage];
        if (isdefined(var_3594168e)) {
            if (!isdefined(self.var_49daa2f6)) {
                self.var_49daa2f6 = [];
            }
            function_374e37a0(localclientnum, self, var_3594168e, self.var_49daa2f6);
        }
    }
}

