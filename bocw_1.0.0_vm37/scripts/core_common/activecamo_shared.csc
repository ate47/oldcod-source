#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace activecamo;

// Namespace activecamo/activecamo_shared
// Params 0, eflags: 0x6
// Checksum 0xd2583cd9, Offset: 0x168
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"activecamo", &preinit, undefined, undefined, undefined);
}

// Namespace activecamo/activecamo_shared
// Params 0, eflags: 0x4
// Checksum 0xbed964a6, Offset: 0x1b0
// Size: 0xd4
function private preinit() {
    callback::add_callback(#"updateactivecamo", &updateactivecamo);
    callback::on_spawned(&on_player_spawned);
    callback::on_weapon_change(&on_weapon_change);
    callback::on_localplayer_spawned(&on_local_player_spawned);
    level.var_b9b11197 = getgametypesetting(#"hash_1f3825ba2a669400");
    /#
        thread function_12e53b2d();
    #/
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x1a13ea54, Offset: 0x290
// Size: 0x44
function on_local_player_spawned(localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    function_e3e0feb5(localclientnum, self);
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0x8bdd8195, Offset: 0x2e0
// Size: 0x198
function function_e3e0feb5(localclientnum, localplayer) {
    players = getplayers(localclientnum);
    foreach (player in players) {
        if (!isdefined(player) || !player isplayer() || !isalive(player)) {
            continue;
        }
        if (player === localplayer) {
            continue;
        }
        if (!player hasdobj(localclientnum)) {
            continue;
        }
        weapon = player function_d2c2b168();
        weaponoptions = player function_e10e6c37();
        stagenum = getactivecamostage(weaponoptions);
        player function_158c76b1(localclientnum, weapon, "tag_weapon_right", stagenum, 1, weaponoptions);
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x75618c5f, Offset: 0x480
// Size: 0xd4
function on_weapon_change(params) {
    if (self == level || !isplayer(self)) {
        return;
    }
    localclientnum = params.localclientnum;
    weapon = self function_d2c2b168();
    weaponoptions = self function_e10e6c37();
    stagenum = getactivecamostage(weaponoptions);
    self function_158c76b1(localclientnum, weapon, "tag_weapon_right", stagenum, 1, weaponoptions);
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x1dcd50c4, Offset: 0x560
// Size: 0x9c
function on_player_spawned(localclientnum) {
    weapon = self function_d2c2b168();
    weaponoptions = self function_e10e6c37();
    stagenum = getactivecamostage(weaponoptions);
    self function_158c76b1(localclientnum, weapon, "tag_weapon_right", stagenum, 1, weaponoptions);
}

// Namespace activecamo/activecamo_shared
// Params 4, eflags: 0x0
// Checksum 0x973c8084, Offset: 0x608
// Size: 0x13e
function function_451a49f4(localclientnum, var_f4eb4a50, weapon, stagenum) {
    activecamo = self init_activecamo(var_f4eb4a50, 0);
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
// Params 3, eflags: 0x0
// Checksum 0x172f1e83, Offset: 0x750
// Size: 0x1b4
function function_130e0542(localclientnum, weapon, camoindex) {
    init_stage = 0;
    var_f4eb4a50 = function_13e12ab1(camoindex);
    activecamo = self init_activecamo(var_f4eb4a50, 0);
    if (isdefined(activecamo)) {
        if (isdefined(activecamo.var_13949c61.stages)) {
            var_f8bf269c = 0;
            foreach (key, stage in activecamo.var_13949c61.stages) {
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
        return function_451a49f4(localclientnum, var_f4eb4a50, weapon, init_stage);
    }
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0x5faf9a43, Offset: 0x910
// Size: 0x8c
function updateactivecamo(localclientnum, eventstruct) {
    weaponoptions = self function_e10e6c37();
    stagenum = getactivecamostage(weaponoptions);
    self function_158c76b1(localclientnum, eventstruct.weapon, eventstruct.tagname, stagenum, 0, eventstruct.camooptions);
}

// Namespace activecamo/activecamo_shared
// Params 6, eflags: 0x0
// Checksum 0x5b18cd09, Offset: 0x9a8
// Size: 0x614
function function_158c76b1(localclientnum, weapon, tagname, stagenum, var_d71e8c6e, camooptions) {
    var_d1460f46 = isdefined(tagname) && tagname == "tag_stowed_back";
    self function_7a55e60a(var_d1460f46);
    var_f4eb4a50 = function_edd6511(camooptions);
    if (!isdefined(var_f4eb4a50)) {
        function_3e27a7cb(localclientnum, tagname);
        return;
    }
    activecamo = self init_activecamo(var_f4eb4a50, 0);
    if (!isdefined(activecamo.var_13949c61.stages)) {
        function_3e27a7cb(localclientnum, tagname);
        return;
    }
    stage = activecamo.var_13949c61.stages[stagenum];
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
    var_58bac2d = function_16d7447b(localclientnum, tagname, 1);
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
                laststage = activecamo.var_13949c61.stages[var_9a7e487a];
                if (isdefined(laststage.var_1c54e7b8)) {
                    playsound(localclientnum, laststage.var_1c54e7b8);
                } else if (isdefined(stage.var_a000b430)) {
                    playsound(localclientnum, stage.var_a000b430);
                }
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
                        fx = stage.var_9828c877;
                        break;
                    }
                    if (isdefined(fx)) {
                        playviewmodelfx(localclientnum, fx, "tag_flash");
                    }
                }
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
            self thread function_b5b4013c(stage, tagname, layer, var_d71e8c6e);
        }
        self thread function_bc6005b5(stage, tagname, "Diffuse2 Alpha", stage.var_2eeeee1b, stage.diffuse2alpha, var_d71e8c6e);
        self thread function_bc6005b5(stage, tagname, "Diffuse3 Alpha", stage.var_7a3e0e45, stage.diffuse3alpha, var_d71e8c6e);
    }
    self function_e6d00a7e(localclientnum, weapon, activecamo, stagenum);
}

// Namespace activecamo/activecamo_shared
// Params 4, eflags: 0x0
// Checksum 0x1afd4dd7, Offset: 0xfc8
// Size: 0xec
function function_e6d00a7e(localclientnum, weapon, activecamo, var_42d9b149) {
    aries_is_ = var_42d9b149 + 1;
    if (isdefined(activecamo.var_13949c61.stages[aries_is_])) {
        nextstage = activecamo.var_13949c61.stages[aries_is_];
        if (isdefined(nextstage.var_19b6044e)) {
            renderoptionsweapon = self function_ade49959();
            var_fd90b0bb = self function_8cbd254d();
            function_d780f794(localclientnum, weapon, renderoptionsweapon, var_fd90b0bb, nextstage.var_19b6044e);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x557e57e, Offset: 0x10c0
// Size: 0x64
function player_on_death(params) {
    self function_3e27a7cb(params.localclientnum, "tag_weapon_right");
    self callback::function_52ac9652(#"death", &player_on_death);
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0x26805ddb, Offset: 0x1130
// Size: 0x6e
function function_3e27a7cb(localclientnum, tagname) {
    var_58bac2d = function_16d7447b(localclientnum, tagname, 0);
    if (isdefined(var_58bac2d.crob)) {
        self stoprenderoverridebundle(var_58bac2d.crob, tagname);
        var_58bac2d.crob = undefined;
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0xa672db50, Offset: 0x11a8
// Size: 0x140
function function_a946fb86(activecamo, stagenum, var_d1460f46) {
    foreach (key, stage in activecamo.var_13949c61.stages) {
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
// Params 3, eflags: 0x0
// Checksum 0x7e6ddaac, Offset: 0x12f0
// Size: 0xb6
function function_16d7447b(localclientnum, tagname, create) {
    if (!create && !isdefined(self.var_32d117a2[localclientnum][tagname])) {
        return undefined;
    }
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
// Params 6, eflags: 0x0
// Checksum 0xb6ff86ec, Offset: 0x13b0
// Size: 0x144
function function_bc6005b5(stage, tagname, var_eb6a239c, lerptime, var_f023ca7d, var_d71e8c6e) {
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
// Params 4, eflags: 0x0
// Checksum 0x49b093d2, Offset: 0x1500
// Size: 0x36c
function function_b5b4013c(stage, tagname, layer, var_d71e8c6e) {
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
// Params 2, eflags: 0x0
// Checksum 0xed8d2111, Offset: 0x1878
// Size: 0x4c6
function function_8a6ced15(var_f4eb4a50, forceupdate) {
    var_13949c61 = undefined;
    if (isdefined(var_f4eb4a50) && isdefined(var_f4eb4a50.name)) {
        if (!isdefined(level.activecamoinfo)) {
            level.activecamoinfo = [];
        }
        if (!forceupdate && isdefined(level.activecamoinfo[var_f4eb4a50.name])) {
            return level.activecamoinfo[var_f4eb4a50.name];
        }
        if (!isdefined(level.activecamoinfo[var_f4eb4a50.name])) {
            level.activecamoinfo[var_f4eb4a50.name] = {};
        }
        var_13949c61 = level.activecamoinfo[var_f4eb4a50.name];
        if (isdefined(var_f4eb4a50.stages)) {
            if (!isdefined(var_13949c61.stages)) {
                var_13949c61.stages = [];
            }
            var_d3daabe = 0;
            foreach (key, var_3594168e in var_f4eb4a50.stages) {
                if (is_true(var_3594168e.disabled)) {
                    var_d3daabe++;
                    continue;
                }
                if (!isdefined(var_13949c61.stages[key - var_d3daabe])) {
                    var_13949c61.stages[key - var_d3daabe] = {};
                }
                stage = var_13949c61.stages[key - var_d3daabe];
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
                }
                stage.diffuse2alpha = isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0;
                stage.var_2eeeee1b = isdefined(var_3594168e.var_2eeeee1b) ? var_3594168e.var_2eeeee1b : 0;
                stage.diffuse3alpha = isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0;
                stage.var_7a3e0e45 = isdefined(var_3594168e.var_7a3e0e45) ? var_3594168e.var_7a3e0e45 : 0;
            }
        }
    }
    return var_13949c61;
}

// Namespace activecamo/activecamo_shared
// Params 2, eflags: 0x0
// Checksum 0x99f2f01b, Offset: 0x1d48
// Size: 0x104
function init_activecamo(var_f4eb4a50, forceupdate) {
    if (isdefined(var_f4eb4a50)) {
        if (!isdefined(self.var_9413f8b4)) {
            self.var_9413f8b4 = [];
        }
        if (!forceupdate && isdefined(self.var_9413f8b4[var_f4eb4a50.name])) {
            return self.var_9413f8b4[var_f4eb4a50.name];
        }
        if (!isdefined(self.var_9413f8b4[var_f4eb4a50.name])) {
            self.var_9413f8b4[var_f4eb4a50.name] = {};
        }
        activecamo = self.var_9413f8b4[var_f4eb4a50.name];
        activecamo.var_13949c61 = function_8a6ced15(var_f4eb4a50, forceupdate);
        assert(isdefined(activecamo.var_13949c61));
        return activecamo;
    }
    return undefined;
}

// Namespace activecamo/activecamo_shared
// Params 4, eflags: 0x0
// Checksum 0x15c20da2, Offset: 0x1e58
// Size: 0x440
function function_6c9e0e1a(localclientnum, weaponmodel, var_3594168e, &var_49daa2f6) {
    if (!isdefined(var_3594168e.rob)) {
        return false;
    }
    stage = {};
    stage.rob = var_3594168e.rob;
    stage.diffuse2alpha = isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0;
    stage.var_2eeeee1b = isdefined(var_3594168e.var_2eeeee1b) ? var_3594168e.var_2eeeee1b : 0;
    stage.diffuse3alpha = isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0;
    stage.var_7a3e0e45 = isdefined(var_3594168e.var_7a3e0e45) ? var_3594168e.var_7a3e0e45 : 0;
    if (!weaponmodel function_d2503806(stage.rob, "tag_origin")) {
        weaponmodel playrenderoverridebundle(stage.rob, "tag_origin");
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
        weaponmodel function_78233d29(stage.rob, "tag_origin", var_604ae5c3, stage.(var_27c1d8a2));
        weaponmodel function_78233d29(stage.rob, "tag_origin", var_d6637dc6, stage.(var_f5747b8));
        weaponmodel function_78233d29(stage.rob, "tag_origin", var_ea35682d, stage.(var_7fd61736));
    }
    diffuse2alpha = isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0;
    diffuse3alpha = isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0;
    weaponmodel function_78233d29(stage.rob, "tag_origin", "Diffuse2 Alpha", diffuse2alpha);
    weaponmodel function_78233d29(stage.rob, "tag_origin", "Diffuse3 Alpha", diffuse3alpha);
    return true;
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0x7be8d95a, Offset: 0x22a0
// Size: 0xbc
function function_cbfd8fd6(localclientnum) {
    if (isdefined(self.weapon)) {
        weaponoptions = self function_e10e6c37();
        camoindex = getcamoindex(weaponoptions);
        var_f4eb4a50 = function_13e12ab1(camoindex);
        if (isdefined(var_f4eb4a50)) {
            stagenum = getactivecamostage(weaponoptions);
            self function_7721b2d5(localclientnum, var_f4eb4a50, stagenum);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 1, eflags: 0x0
// Checksum 0xf2930ea6, Offset: 0x2368
// Size: 0x13c
function function_e40c785a(localclientnum) {
    weaponoptions = self function_e10e6c37();
    camoindex = getcamoindex(weaponoptions);
    var_f4eb4a50 = function_13e12ab1(camoindex);
    if (isdefined(var_f4eb4a50)) {
        if (isdefined(var_f4eb4a50.stages)) {
            init_stage = 0;
            foreach (key, var_3594168e in var_f4eb4a50.stages) {
                if (isdefined(var_3594168e.permanentstatname)) {
                    continue;
                }
                init_stage = key;
                break;
            }
            self function_7721b2d5(localclientnum, var_f4eb4a50, init_stage);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0x831b2a44, Offset: 0x24b0
// Size: 0x27c
function function_6efb762c(localclientnum, camoweapon, weaponoptions) {
    camoindex = getcamoindex(weaponoptions);
    var_f4eb4a50 = function_13e12ab1(camoindex);
    if (isdefined(var_f4eb4a50)) {
        player = function_27673a7(localclientnum);
        activecamo = player init_activecamo(var_f4eb4a50, 0);
        if (isdefined(activecamo)) {
            baseweapon = function_c14cb514(camoweapon);
            init_stage = getactivecamostage(weaponoptions);
            if (isdefined(activecamo.var_fe56592) && isdefined(activecamo.var_fe56592[localclientnum]) && isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon])) {
                init_stage = activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum;
            } else {
                activecamo = player function_130e0542(localclientnum, camoweapon, camoindex);
                if (isdefined(activecamo) && isdefined(activecamo.var_fe56592) && isdefined(activecamo.var_fe56592[localclientnum]) && isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon])) {
                    init_stage = activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum;
                }
            }
            if (isdefined(var_f4eb4a50.stages)) {
                var_3594168e = var_f4eb4a50.stages[init_stage];
                if (isdefined(var_3594168e)) {
                    var_19b6044e = function_8b51d9d1(var_3594168e.camooption);
                    self setcamo(var_19b6044e);
                    self setactivecamostage(init_stage);
                }
            }
            self function_7721b2d5(localclientnum, var_f4eb4a50, init_stage);
        }
    }
}

// Namespace activecamo/activecamo_shared
// Params 3, eflags: 0x0
// Checksum 0x3a667b6a, Offset: 0x2738
// Size: 0x94
function function_7721b2d5(localclientnum, var_f4eb4a50, init_stage) {
    if (isdefined(var_f4eb4a50) && isdefined(var_f4eb4a50.stages)) {
        var_3594168e = var_f4eb4a50.stages[init_stage];
        if (isdefined(var_3594168e)) {
            if (!isdefined(self.var_49daa2f6)) {
                self.var_49daa2f6 = [];
            }
            function_6c9e0e1a(localclientnum, self, var_3594168e, self.var_49daa2f6);
        }
    }
}

/#

    // Namespace activecamo/activecamo_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfd72ef79, Offset: 0x27d8
    // Size: 0x1a0
    function function_12e53b2d() {
        self notify("<dev string:x38>");
        self endon("<dev string:x38>");
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
                players = getplayers(0);
                foreach (player in players) {
                    activecamo = player init_activecamo(var_f4eb4a50, 1);
                }
                function_e3e0feb5(0, undefined);
            }
        }
    }

#/
