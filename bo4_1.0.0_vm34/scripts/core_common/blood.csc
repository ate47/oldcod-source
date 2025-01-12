#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace blood;

// Namespace blood/blood
// Params 0, eflags: 0x2
// Checksum 0x9c9acfdd, Offset: 0x308
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"blood", undefined, &__postload_init__, undefined);
}

// Namespace blood/blood
// Params 0, eflags: 0x0
// Checksum 0x45627e17, Offset: 0x348
// Size: 0x54
function __postload_init__() {
    function_75a741b6();
    callback::on_localplayer_spawned(&function_70335a11);
    callback::on_localclient_connect(&localclient_connect);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x2077523d, Offset: 0x3a8
// Size: 0x2c
function private getsplatter(localclientnum) {
    return level.blood.var_fddc1a1e.var_925e3756[localclientnum];
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x2029f9cb, Offset: 0x3e0
// Size: 0x24
function private localclient_connect(localclientnum) {
    level thread player_splatter(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xcfdaa394, Offset: 0x410
// Size: 0x1e4
function private function_70335a11(localclientnum) {
    if (!self function_60dbc438()) {
        return;
    }
    if (function_d9327eb5(localclientnum, #"hash_73c750f53749d44d")) {
        codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
    }
    function_127a1177(localclientnum);
    self.var_aa0bfc82 = 0;
    if (level.blood.rob.stage == 0) {
        self.var_f8ec6531 = 1;
        self.var_261d7a7d = 1;
    } else {
        self.var_f8ec6531 = 0;
        self.var_261d7a7d = 0;
    }
    self.stage2amount = 0;
    self.stage3amount = 0;
    self.lastbloodupdate = 0;
    self stop_breath(localclientnum);
    level thread wait_game_ended(localclientnum);
    self stoprenderoverridebundle("rob_wound_blood_splatter");
    self thread function_a6933c1e(localclientnum);
    self thread function_32f1a32f(localclientnum);
    new_health_model_ui_model = createuimodel(getuimodelforcontroller(localclientnum), "usingNewHealthModel");
    if (isdefined(new_health_model_ui_model)) {
        setuimodelvalue(new_health_model_ui_model, level.new_health_model);
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0x5a3668e5, Offset: 0x600
// Size: 0xb4
function private setcontrollerlightbarcolorpulsing(localclientnum, color, pulserate) {
    curcolor = color * 0.2;
    scale = gettime() % pulserate / pulserate * 0.5;
    if (scale > 1) {
        scale = (scale - 2) * -1;
    }
    curcolor += color * 0.8 * scale;
    setcontrollerlightbarcolor(localclientnum, curcolor);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x19655ea0, Offset: 0x6c0
// Size: 0x154
function private update_lightbar(localclientnum) {
    if (!(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange)) {
        if (self.stage3amount > 0) {
            setcontrollerlightbarcolorpulsing(localclientnum, (1, 0, 0), 600);
            return;
        }
        if (self.stage2amount == 1) {
            setcontrollerlightbarcolorpulsing(localclientnum, (0.8, 0, 0), 1200);
            return;
        }
        if ((!sessionmodeiscampaigngame() || codegetuimodelclientfield(self, "playerAbilities.inRange")) && getgadgetpower(localclientnum) == 1) {
            setcontrollerlightbarcolorpulsing(localclientnum, (1, 1, 0), 2000);
            return;
        }
        if (isdefined(self.controllercolor)) {
            setcontrollerlightbarcolor(localclientnum, self.controllercolor);
            return;
        }
        setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x8dcd46c3, Offset: 0x820
// Size: 0x3c
function private enter_critical_health(localclientnum) {
    self thread play_critical_health_rumble(localclientnum);
    self play_breath(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xd8280bc6, Offset: 0x868
// Size: 0x158
function private play_critical_health_rumble(localclientnum) {
    self endon(#"death", #"disconnect", #"critical_health_end", #"spawned");
    var_d9626148 = "new_health_stage_critical";
    while (true) {
        self waittill(#"pulse_blood");
        self playrumbleonentity(localclientnum, var_d9626148);
        name = self getmpdialogname();
        if (!isdefined(name)) {
            name = #"human";
        }
        if (name == #"reaper") {
            sound = #"mpl_reaper_heartbeat";
        } else {
            sound = #"mpl_player_heartbeat";
        }
        if (!(isdefined(self.var_ee10be2d) && self.var_ee10be2d)) {
            self playsound(localclientnum, sound);
        }
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xbcef995, Offset: 0x9c8
// Size: 0x84
function private play_breath(localclientnum) {
    self stop_breath(localclientnum);
    snd_handle = function_987d57a7(localclientnum, "chr_health_low_breath_loop", 0.1);
    level.hurt_breath_snd_handle[localclientnum] = snd_handle;
    self thread watch_end_breath(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x1fd1c1, Offset: 0xa58
// Size: 0x64
function private watch_end_breath(localclientnum) {
    self waittill(#"death", #"disconnect", #"critical_health_end", #"spawned");
    stop_breath(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x6147bb86, Offset: 0xac8
// Size: 0x7c
function private stop_breath(localclientnum) {
    if (!isdefined(level.hurt_breath_snd_handle)) {
        level.hurt_breath_snd_handle = [];
    }
    if (isdefined(level.hurt_breath_snd_handle[localclientnum])) {
        function_4f246249(localclientnum, level.hurt_breath_snd_handle[localclientnum], 1);
        level.hurt_breath_snd_handle[localclientnum] = undefined;
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xb71fb68f, Offset: 0xb50
// Size: 0xde
function private wait_game_ended(localclientnum) {
    if (!isdefined(level.watching_blood_game_ended)) {
        level.watching_blood_game_ended = [];
    }
    if (level.watching_blood_game_ended[localclientnum] === 1) {
        return;
    }
    level.watching_blood_game_ended[localclientnum] = 1;
    level waittill(#"game_ended");
    stop_breath(localclientnum);
    localplayer = function_f97e7787(localclientnum);
    if (isdefined(localplayer)) {
        localplayer notify(#"critical_health_end");
    }
    level.watching_blood_game_ended[localclientnum] = 0;
}

// Namespace blood/blood
// Params 2, eflags: 0x4
// Checksum 0x7c96cd31, Offset: 0xc38
// Size: 0x6c
function private function_ba7b7c6(localclientnum, damage) {
    if (damage > level.blood.rob.damage_threshold) {
        self playrenderoverridebundle("rob_wound_blood_splatter");
        self thread function_3a859914(localclientnum);
    }
}

// Namespace blood/blood
// Params 2, eflags: 0x4
// Checksum 0x2166afb3, Offset: 0xcb0
// Size: 0x1ac
function private function_3a859914(localclientnum, duration) {
    self notify("1b7997360c1b9f5d");
    self endon("1b7997360c1b9f5d");
    self endon(#"death");
    self endon(#"killbloodoverlay");
    self function_98a01e4c("rob_wound_blood_splatter", "U Offset", randomfloatrange(0, 1));
    self function_98a01e4c("rob_wound_blood_splatter", "V Offset", randomfloatrange(0, 1));
    self function_98a01e4c("rob_wound_blood_splatter", "Threshold", 1);
    wait float(level.blood.rob.hold_time) / 1000;
    self thread ramprobsetting(localclientnum, 1, 0, level.blood.rob.fade_time, "Threshold");
    wait float(level.blood.rob.fade_time) / 1000;
    self stoprenderoverridebundle("rob_wound_blood_splatter");
}

// Namespace blood/blood
// Params 5, eflags: 0x0
// Checksum 0x53ed45b7, Offset: 0xe68
// Size: 0xac
function ramprobsetting(localclientnum, from, to, ramptime, key) {
    self endon(#"death");
    self endon(#"killbloodoverlay");
    self notify("rampROBsetting" + key);
    self endon("rampROBsetting" + key);
    util::lerp_generic(localclientnum, ramptime, &function_e7956521, from, to, key);
}

// Namespace blood/blood
// Params 7, eflags: 0x0
// Checksum 0x127b383a, Offset: 0xf20
// Size: 0x9c
function function_e7956521(currenttime, elapsedtime, localclientnum, duration, stagefrom, stageto, key) {
    percent = elapsedtime / duration;
    amount = stageto * percent + stagefrom * (1 - percent);
    self function_98a01e4c("rob_wound_blood_splatter", key, amount);
}

// Namespace blood/blood
// Params 2, eflags: 0x0
// Checksum 0x5e10031e, Offset: 0xfc8
// Size: 0x19c
function function_86ce9452(localclientnum, shockrifle) {
    if (isdefined(shockrifle) && shockrifle) {
        function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Enable Tint", 0.9);
        function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Tint Color R", 4);
        function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Tint Color G", 4);
        function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Tint Color B", 4);
        return;
    }
    function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Enable Tint", 1);
    function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Tint Color R", 0.3);
    function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Tint Color G", 0.025);
    function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Tint Color B", 0);
}

// Namespace blood/blood
// Params 5, eflags: 0x4
// Checksum 0x2513e44e, Offset: 0x1170
// Size: 0xb4
function private function_265b6f6f(localclientnum, damage, death, dot, shockrifle) {
    splatter = getsplatter(localclientnum);
    splatter.shockrifle = shockrifle;
    splatter.var_2c5e621d++;
    var_dba1ea60 = splatter.var_2c5e621d % 4;
    level thread splatter_postfx(localclientnum, self, damage, var_dba1ea60, death, dot);
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0x725781ad, Offset: 0x1230
// Size: 0x14c
function private update_damage_effects(localclientnum, damage, death) {
    if (isdefined(self.dot_no_splatter) && self.dot_no_splatter && damage < 10 && damage > 0) {
        self.dot_no_splatter = 0;
    } else if (isdefined(self.var_43a24fe6) && self.var_43a24fe6 && damage > 0) {
        function_265b6f6f(localclientnum, damage, death, 0, 1);
        self.var_43a24fe6 = 0;
    } else if (self.dot_damaged === 1 && damage > 0) {
        function_265b6f6f(localclientnum, damage, death, 1, 0);
        self.dot_damaged = 0;
    } else if (damage > 0) {
        function_265b6f6f(localclientnum, damage, death, 0, 0);
    }
    self function_ba7b7c6(localclientnum, damage);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x1e224a67, Offset: 0x1388
// Size: 0x2d6
function private player_splatter(localclientnum) {
    level notify("player_splatter" + localclientnum);
    level endon("player_splatter" + localclientnum);
    while (true) {
        splatter = getsplatter(localclientnum);
        blur = 0;
        opacity = 0;
        for (i = 0; i < 4; i++) {
            if (isdefined(splatter.splatters[i][#"blur amount"]) && splatter.splatters[i][#"blur amount"] > blur) {
                blur = splatter.splatters[i][#"blur amount"];
            }
            if (isdefined(splatter.splatters[i][#"opacity"]) && splatter.splatters[i][#"opacity"] > opacity) {
                opacity = splatter.splatters[i][#"opacity"];
            }
        }
        if (blur > 0 || opacity > 0) {
            splatter.var_a77d85b = 1;
            function_e10ea0ed(localclientnum, #"hash_73c750f53749d44d");
            function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Blur Amount", blur);
            if (isdefined(splatter.shockrifle) && splatter.shockrifle) {
                opacity *= 0.05;
            }
            function_d3532280(localclientnum, #"hash_73c750f53749d44d", "Opacity", opacity);
            function_86ce9452(localclientnum, splatter.shockrifle);
        } else if (isdefined(self.var_a77d85b) && self.var_a77d85b) {
            splatter.var_a77d85b = 0;
            codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
        }
        waitframe(1);
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0xcbef0333, Offset: 0x1668
// Size: 0xae
function private function_d1c067d0(localclientnum, splatter, damage) {
    if (damage > level.blood.var_fddc1a1e.dot.var_a0a55a4d) {
        return true;
    }
    if (!isdefined(splatter.var_f598a2b1)) {
        return true;
    }
    if (getservertime(localclientnum) - splatter.var_f598a2b1 < level.blood.var_fddc1a1e.dot.var_fe6a8bc7) {
        return false;
    }
    return true;
}

// Namespace blood/blood
// Params 6, eflags: 0x4
// Checksum 0xe64deec2, Offset: 0x1720
// Size: 0x45c
function private splatter_postfx(localclientnum, player, damage, var_dba1ea60, death, dot) {
    level notify(localclientnum + "splatter_postfx" + var_dba1ea60);
    level endon(localclientnum + "splatter_postfx" + var_dba1ea60);
    blur = 0;
    opacity = 0;
    var_6ce5d6b3 = 0;
    var_f2fa3500 = 0;
    hold_time = 0;
    splatter = getsplatter(localclientnum);
    if (dot && !death) {
        splatter.var_f598a2b1 = getservertime(localclientnum);
        blur = level.blood.var_fddc1a1e.dot.blur;
        opacity = level.blood.var_fddc1a1e.dot.opacity;
        var_6ce5d6b3 = level.blood.var_fddc1a1e.dot.var_6ce5d6b3;
        hold_time = level.blood.var_fddc1a1e.dot.hold_time;
    } else if (function_d1c067d0(localclientnum, splatter, damage)) {
        for (i = level.blood.var_fddc1a1e.damage_ranges - 1; i >= 0; i--) {
            if (damage > level.blood.var_fddc1a1e.range[i].start || level.blood.scriptbundle.var_f4ef2c7 - 1 == i && death) {
                blur = level.blood.var_fddc1a1e.range[i].blur;
                opacity = level.blood.var_fddc1a1e.range[i].opacity;
                var_6ce5d6b3 = level.blood.var_fddc1a1e.var_6ce5d6b3[i];
                var_f2fa3500 = level.blood.var_fddc1a1e.var_f2fa3500[i];
                hold_time = level.blood.var_fddc1a1e.hold_time[i];
                break;
            }
        }
    }
    if (isdefined(level.var_b33aa896) && [[ level.var_b33aa896 ]](localclientnum, player, damage)) {
        blur = 0;
        opacity = 0;
        var_6ce5d6b3 = 0;
        var_f2fa3500 = 0;
        hold_time = 0;
    }
    level thread rampvalue(localclientnum, 0, opacity, var_6ce5d6b3, var_dba1ea60, "Opacity");
    level thread rampvalue(localclientnum, 0, blur, var_6ce5d6b3, var_dba1ea60, "Blur Amount");
    wait float(var_6ce5d6b3) / 1000;
    wait float(hold_time) / 1000;
    level thread rampvalue(localclientnum, opacity, 0, var_f2fa3500, var_dba1ea60, "Opacity");
    level thread rampvalue(localclientnum, blur, 0, var_f2fa3500, var_dba1ea60, "Blur Amount");
}

// Namespace blood/blood
// Params 6, eflags: 0x0
// Checksum 0xb5497a9e, Offset: 0x1b88
// Size: 0xac
function rampvalue(localclientnum, stagefrom, stageto, ramptime, var_dba1ea60, key) {
    level notify(localclientnum + "rampValue" + var_dba1ea60 + key);
    level endon(localclientnum + "rampValue" + var_dba1ea60 + key);
    util::lerp_generic(localclientnum, ramptime, &function_d7f10bf7, stagefrom, stageto, var_dba1ea60, key);
}

// Namespace blood/blood
// Params 8, eflags: 0x0
// Checksum 0x131d2853, Offset: 0x1c40
// Size: 0xd4
function function_d7f10bf7(currenttime, elapsedtime, localclientnum, duration, stagefrom, stageto, var_dba1ea60, key) {
    percent = 1;
    if (duration > 0) {
        percent = elapsedtime / duration;
    }
    amount = stageto * percent + stagefrom * (1 - percent);
    splatter = getsplatter(localclientnum);
    splatter.splatters[var_dba1ea60][key] = amount;
}

// Namespace blood/blood
// Params 0, eflags: 0x4
// Checksum 0xfbcfa8e, Offset: 0x1d20
// Size: 0x8a
function private player_base_health() {
    if (!self function_cd182a88()) {
        return 150;
    }
    basehealth = self getplayerspawnhealth();
    basehealth += isdefined(level.var_9ef11bf6) ? level.var_9ef11bf6 : 0;
    if (isdefined(self.var_fdaf1ef6)) {
        basehealth = self.var_fdaf1ef6;
    }
    return basehealth;
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x994b623d, Offset: 0x1db8
// Size: 0x26e
function private function_a6933c1e(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killbloodoverlay");
    self util::function_cee87e61();
    basehealth = player_base_health();
    priorplayerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
    var_2e50ef02 = basehealth * priorplayerhealth;
    self thread function_3e7b5188(localclientnum);
    while (true) {
        if (renderhealthoverlay(localclientnum)) {
            basehealth = player_base_health();
            playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
            var_7bd1f9e0 = basehealth * playerhealth;
            damageamount = var_2e50ef02 - var_7bd1f9e0;
            update_damage_effects(localclientnum, damageamount, playerhealth == 0);
            shouldenabledoverlay = 0;
            if (playerhealth < 1) {
                shouldenabledoverlay = 1;
            } else if (isdefined(self.blood_enabled) && self.blood_enabled) {
                self function_670d6e3d(localclientnum);
            }
            priorplayerhealth = playerhealth;
            var_2e50ef02 = var_7bd1f9e0;
            if (!(isdefined(self.blood_enabled) && self.blood_enabled) && shouldenabledoverlay) {
                self function_1ab85714(localclientnum);
            }
            self function_b6df9352(localclientnum, var_7bd1f9e0);
            self update_lightbar(localclientnum);
        } else if (isdefined(self.blood_enabled) && self.blood_enabled) {
            self function_670d6e3d(localclientnum);
        }
        waitframe(1);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x31db192c, Offset: 0x2030
// Size: 0x24c
function private function_3e7b5188(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killbloodoverlay");
    if (!level.blood.var_95c31838) {
        return;
    }
    while (true) {
        waitframe(1);
        if (isdefined(self.blood_enabled) && self.blood_enabled) {
            for (pulse = 0; pulse < 2; pulse++) {
                self notify(#"pulse_blood");
                self thread function_810eb82f(localclientnum, 0, 1, level.blood.var_b61a66f4.var_53022589[pulse], #"damage pulse", #"hash_263a0659c7ff81ad");
                wait float(level.blood.var_b61a66f4.var_53022589[pulse]) / 1000;
                wait float(level.blood.var_b61a66f4.var_abd30b0f[pulse]) / 1000;
                self thread function_810eb82f(localclientnum, 1, 0, level.blood.var_b61a66f4.var_b1f1aaa0[pulse], #"damage pulse", #"hash_263a0659c7ff81ad");
                wait float(level.blood.var_b61a66f4.var_b1f1aaa0[pulse]) / 1000;
                wait float(level.blood.var_b61a66f4.var_e5a8ae8[pulse]) / 1000;
            }
        }
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x8def99ef, Offset: 0x2288
// Size: 0x3c
function private function_32f1a32f(localclientnum) {
    self waittill(#"death");
    self function_670d6e3d(localclientnum);
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0x51dbdd39, Offset: 0x22d0
// Size: 0x6e
function private function_587dc713(localclientnum, new_blood_stage, prior_blood_stage) {
    if (new_blood_stage >= level.blood.rob.stage) {
        self.var_f8ec6531 = 1;
    } else {
        self.var_f8ec6531 = 0;
    }
    self.var_261d7a7d = self.var_f8ec6531;
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0x78edd449, Offset: 0x2348
// Size: 0x1ce
function private function_e9ce1529(localclientnum, new_blood_stage, prior_blood_stage) {
    if (new_blood_stage == 4) {
        self.var_aa0bfc82 = 1;
        self enter_critical_health(localclientnum);
        if (isdefined(self.blood_enabled) && self.blood_enabled) {
            self function_202a8b08(#"hash_263a0659c7ff81ad", #"damage pulse", 1);
        }
        if (isdefined(level.blood.scriptbundle.pulse_loop)) {
            level.blood.soundhandle = function_987d57a7(localclientnum, level.blood.scriptbundle.pulse_loop);
        }
    } else if (self.var_aa0bfc82) {
        if (isdefined(level.blood.soundhandle)) {
            function_4f246249(localclientnum, level.blood.soundhandle);
            level.blood.soundhandle = undefined;
        }
        self.var_aa0bfc82 = 0;
        if (isdefined(self.blood_enabled) && self.blood_enabled) {
            self function_202a8b08(#"hash_263a0659c7ff81ad", #"damage pulse", 0);
        }
    }
    if (new_blood_stage < 4) {
        self notify(#"critical_health_end");
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xb4474b63, Offset: 0x2520
// Size: 0x140
function private function_bc85e04a(stage) {
    for (pulse = 0; pulse < 2; pulse++) {
        level.blood.var_b61a66f4.var_53022589[pulse] = level.blood.var_b61a66f4.time_in[pulse][stage];
        level.blood.var_b61a66f4.var_abd30b0f[pulse] = level.blood.var_b61a66f4.var_6e69ec28[pulse][stage];
        level.blood.var_b61a66f4.var_b1f1aaa0[pulse] = level.blood.var_b61a66f4.time_out[pulse][stage];
        level.blood.var_b61a66f4.var_e5a8ae8[pulse] = level.blood.var_b61a66f4.var_75ac8e19[pulse][stage];
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xffa899be, Offset: 0x2668
// Size: 0x7e
function private play_new_stage_rumble(localclientnum) {
    self endon(#"death", #"disconnect");
    for (i = 0; i < 2; i++) {
        self playrumbleonentity(localclientnum, "new_health_stage");
        wait 0.4;
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0xba50267a, Offset: 0x26f0
// Size: 0x4c
function private function_15db3b69(localclientnum, new_blood_stage, prior_blood_stage) {
    if (new_blood_stage > 0) {
        if (new_blood_stage > prior_blood_stage) {
            self thread play_new_stage_rumble(localclientnum);
        }
    }
}

// Namespace blood/blood
// Params 2, eflags: 0x4
// Checksum 0x17d78a60, Offset: 0x2748
// Size: 0x512
function private function_b6df9352(localclientnum, playerhealth) {
    if (!isdefined(self.last_blood_stage)) {
        self.last_blood_stage = 0;
    }
    var_6388eb5a = level.blood.threshold[1];
    stage2_threshold = level.blood.threshold[2];
    stage3_threshold = level.blood.threshold[3];
    stage4_threshold = level.blood.threshold[4];
    prior_blood_stage = self.last_blood_stage;
    new_blood_stage = 0;
    if (!(isdefined(self.nobloodoverlay) && self.nobloodoverlay)) {
        if (playerhealth <= var_6388eb5a && playerhealth > 0) {
            if (playerhealth <= stage3_threshold) {
                new_blood_stage = playerhealth <= stage4_threshold ? 4 : 3;
            } else {
                new_blood_stage = playerhealth <= stage2_threshold ? 2 : 1;
            }
        }
    }
    if (new_blood_stage != prior_blood_stage) {
        ramptime = prior_blood_stage < new_blood_stage ? level.blood.var_6ce5d6b3 : level.blood.var_f2fa3500;
        self thread function_810eb82f(localclientnum, level.blood.fade[prior_blood_stage], level.blood.fade[new_blood_stage], ramptime, #"fade", #"hash_263a0659c7ff81ad");
        self thread function_810eb82f(localclientnum, level.blood.opacity[prior_blood_stage], level.blood.opacity[new_blood_stage], ramptime, #"opacity", #"hash_263a0659c7ff81ad");
        self thread function_810eb82f(localclientnum, level.blood.var_8645128b[prior_blood_stage], level.blood.var_8645128b[new_blood_stage], ramptime, #"vignette darkening amount", #"hash_263a0659c7ff81ad");
        self thread function_810eb82f(localclientnum, level.blood.var_82f935f2[prior_blood_stage], level.blood.var_82f935f2[new_blood_stage], ramptime, #"vignette darkening factor", #"hash_263a0659c7ff81ad");
        self thread function_810eb82f(localclientnum, level.blood.blur[prior_blood_stage], level.blood.blur[new_blood_stage], ramptime, #"blur", #"hash_263a0659c7ff81ad");
        if (level.blood.var_c68ef8f6) {
            self thread function_810eb82f(localclientnum, level.blood.refraction[prior_blood_stage], level.blood.refraction[new_blood_stage], ramptime, #"refraction", #"hash_263a0659c7ff81ad");
        }
        if (isdefined(self.blood_enabled) && self.blood_enabled) {
            self function_202a8b08(#"hash_263a0659c7ff81ad", #"hash_3886e6a5c0c3df4c", level.blood.blood_boost[new_blood_stage]);
        }
        self function_bc85e04a(new_blood_stage);
        self function_15db3b69(localclientnum, new_blood_stage, prior_blood_stage);
        self function_587dc713(localclientnum, new_blood_stage, prior_blood_stage);
        self function_e9ce1529(localclientnum, new_blood_stage, prior_blood_stage);
    }
    self.last_blood_stage = new_blood_stage;
}

// Namespace blood/blood
// Params 6, eflags: 0x0
// Checksum 0xabf5ada5, Offset: 0x2c68
// Size: 0xc4
function function_810eb82f(localclientnum, stagefrom, stageto, ramptime, key, postfx) {
    self endon(#"death");
    self endon(#"hash_6d50f64fe99aed76");
    self notify("rampPostFx" + key + postfx);
    self endon("rampPostFx" + key + postfx);
    util::lerp_generic(localclientnum, ramptime, &function_5671acbd, stagefrom, stageto, key, postfx);
}

// Namespace blood/blood
// Params 8, eflags: 0x0
// Checksum 0xdeae4f91, Offset: 0x2d38
// Size: 0xbc
function function_5671acbd(currenttime, elapsedtime, localclientnum, duration, stagefrom, stageto, key, postfx) {
    percent = elapsedtime / duration;
    amount = stageto * percent + stagefrom * (1 - percent);
    if (isdefined(self.blood_enabled) && self.blood_enabled) {
        self function_202a8b08(postfx, key, amount);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x67c9ab6f, Offset: 0x2e00
// Size: 0x54
function private function_1ab85714(localclientnum) {
    self.blood_enabled = 1;
    if (isdefined(self.blood_enabled) && self.blood_enabled) {
        self codeplaypostfxbundle(#"hash_263a0659c7ff81ad");
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x20d4f34c, Offset: 0x2e60
// Size: 0x174
function private function_670d6e3d(localclientnum) {
    self notify(#"hash_6d50f64fe99aed76");
    if (isdefined(self)) {
        if (self function_6bf2b84(#"hash_263a0659c7ff81ad")) {
            self codestoppostfxbundle(#"hash_263a0659c7ff81ad");
        }
        if (self function_6bf2b84(#"hash_73c750f53749d44d")) {
            self codestoppostfxbundle(#"hash_73c750f53749d44d");
        }
        self.blood_enabled = 0;
    } else {
        if (function_d9327eb5(localclientnum, #"hash_263a0659c7ff81ad")) {
            codestoppostfxbundlelocal(localclientnum, #"hash_263a0659c7ff81ad");
        }
        if (function_d9327eb5(localclientnum, #"hash_73c750f53749d44d")) {
            codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
        }
    }
    if (!isdefined(self) || !(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange)) {
        setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace blood/blood
// Params 0, eflags: 0x4
// Checksum 0x73f69b7b, Offset: 0x2fe0
// Size: 0x16f2
function private function_75a741b6() {
    level.blood = spawnstruct();
    level.blood.scriptbundle = getgametypesetting(#"hardcoremode") ? getscriptbundle("hardcore_blood_settings") : getscriptbundle("blood_settings");
    assert(isdefined(level.blood.scriptbundle));
    if (!isdefined(level.blood.var_c68ef8f6)) {
        level.blood.var_c68ef8f6 = isdefined(level.blood.scriptbundle.var_c68ef8f6) ? level.blood.scriptbundle.var_c68ef8f6 : 0;
    }
    level.blood.refraction = [];
    if (!isdefined(level.blood.refraction[0])) {
        level.blood.refraction[0] = isdefined(level.blood.scriptbundle.var_9f01c0fa) ? level.blood.scriptbundle.var_9f01c0fa : 0;
    }
    if (!isdefined(level.blood.refraction[1])) {
        level.blood.refraction[1] = isdefined(level.blood.scriptbundle.var_c5043b63) ? level.blood.scriptbundle.var_c5043b63 : 0;
    }
    if (!isdefined(level.blood.refraction[2])) {
        level.blood.refraction[2] = isdefined(level.blood.scriptbundle.var_52fccc28) ? level.blood.scriptbundle.var_52fccc28 : 0;
    }
    if (!isdefined(level.blood.refraction[3])) {
        level.blood.refraction[3] = isdefined(level.blood.scriptbundle.var_78ff4691) ? level.blood.scriptbundle.var_78ff4691 : 0;
    }
    if (!isdefined(level.blood.refraction[4])) {
        level.blood.refraction[4] = isdefined(level.blood.scriptbundle.var_370baa9e) ? level.blood.scriptbundle.var_370baa9e : 0;
    }
    level.blood.blood_boost = [];
    if (!isdefined(level.blood.blood_boost[0])) {
        level.blood.blood_boost[0] = isdefined(level.blood.scriptbundle.var_c8cbb111) ? level.blood.scriptbundle.var_c8cbb111 : 0;
    }
    if (!isdefined(level.blood.blood_boost[1])) {
        level.blood.blood_boost[1] = isdefined(level.blood.scriptbundle.var_a2c936a8) ? level.blood.scriptbundle.var_a2c936a8 : 0;
    }
    if (!isdefined(level.blood.blood_boost[2])) {
        level.blood.blood_boost[2] = isdefined(level.blood.scriptbundle.var_14d0a5e3) ? level.blood.scriptbundle.var_14d0a5e3 : 0;
    }
    if (!isdefined(level.blood.blood_boost[3])) {
        level.blood.blood_boost[3] = isdefined(level.blood.scriptbundle.var_eece2b7a) ? level.blood.scriptbundle.var_eece2b7a : 0;
    }
    if (!isdefined(level.blood.blood_boost[4])) {
        level.blood.blood_boost[4] = isdefined(level.blood.scriptbundle.var_60d59ab5) ? level.blood.scriptbundle.var_60d59ab5 : 0;
    }
    level.blood.blur = [];
    if (!isdefined(level.blood.blur[0])) {
        level.blood.blur[0] = isdefined(level.blood.scriptbundle.var_245a3a3c) ? level.blood.scriptbundle.var_245a3a3c : 0;
    }
    if (!isdefined(level.blood.blur[1])) {
        level.blood.blur[1] = isdefined(level.blood.scriptbundle.var_4a5cb4a5) ? level.blood.scriptbundle.var_4a5cb4a5 : 0;
    }
    if (!isdefined(level.blood.blur[2])) {
        level.blood.blur[2] = isdefined(level.blood.scriptbundle.var_705f2f0e) ? level.blood.scriptbundle.var_705f2f0e : 0;
    }
    if (!isdefined(level.blood.blur[3])) {
        level.blood.blur[3] = isdefined(level.blood.scriptbundle.var_9661a977) ? level.blood.scriptbundle.var_9661a977 : 0;
    }
    if (!isdefined(level.blood.blur[4])) {
        level.blood.blur[4] = isdefined(level.blood.scriptbundle.var_8c505098) ? level.blood.scriptbundle.var_8c505098 : 0;
    }
    level.blood.opacity = [];
    if (!isdefined(level.blood.opacity[0])) {
        level.blood.opacity[0] = isdefined(level.blood.scriptbundle.var_7f05cfda) ? level.blood.scriptbundle.var_7f05cfda : 0;
    }
    if (!isdefined(level.blood.opacity[1])) {
        level.blood.opacity[1] = isdefined(level.blood.scriptbundle.var_a5084a43) ? level.blood.scriptbundle.var_a5084a43 : 0;
    }
    if (!isdefined(level.blood.opacity[2])) {
        level.blood.opacity[2] = isdefined(level.blood.scriptbundle.var_3300db08) ? level.blood.scriptbundle.var_3300db08 : 0;
    }
    if (!isdefined(level.blood.opacity[3])) {
        level.blood.opacity[3] = isdefined(level.blood.scriptbundle.var_59035571) ? level.blood.scriptbundle.var_59035571 : 0;
    }
    if (!isdefined(level.blood.opacity[4])) {
        level.blood.opacity[4] = isdefined(level.blood.scriptbundle.var_170fb97e) ? level.blood.scriptbundle.var_170fb97e : 0;
    }
    level.blood.threshold = [];
    if (!isdefined(level.blood.threshold[0])) {
        level.blood.threshold[0] = isdefined(level.blood.scriptbundle.var_b8fe8efc) ? level.blood.scriptbundle.var_b8fe8efc : 0;
    }
    if (!isdefined(level.blood.threshold[1])) {
        level.blood.threshold[1] = isdefined(level.blood.scriptbundle.var_df010965) ? level.blood.scriptbundle.var_df010965 : 0;
    }
    if (!isdefined(level.blood.threshold[2])) {
        level.blood.threshold[2] = isdefined(level.blood.scriptbundle.var_50383ce) ? level.blood.scriptbundle.var_50383ce : 0;
    }
    if (!isdefined(level.blood.threshold[3])) {
        level.blood.threshold[3] = isdefined(level.blood.scriptbundle.var_2b05fe37) ? level.blood.scriptbundle.var_2b05fe37 : 0;
    }
    if (!isdefined(level.blood.threshold[4])) {
        level.blood.threshold[4] = isdefined(level.blood.scriptbundle.var_20f4a558) ? level.blood.scriptbundle.var_20f4a558 : 0;
    }
    level.blood.fade = [];
    if (!isdefined(level.blood.fade[0])) {
        level.blood.fade[0] = isdefined(level.blood.scriptbundle.var_1fcaf839) ? level.blood.scriptbundle.var_1fcaf839 : 0;
    }
    if (!isdefined(level.blood.fade[1])) {
        level.blood.fade[1] = isdefined(level.blood.scriptbundle.var_f9c87dd0) ? level.blood.scriptbundle.var_f9c87dd0 : 0;
    }
    if (!isdefined(level.blood.fade[2])) {
        level.blood.fade[2] = isdefined(level.blood.scriptbundle.var_6bcfed0b) ? level.blood.scriptbundle.var_6bcfed0b : 0;
    }
    if (!isdefined(level.blood.fade[3])) {
        level.blood.fade[3] = isdefined(level.blood.scriptbundle.var_45cd72a2) ? level.blood.scriptbundle.var_45cd72a2 : 0;
    }
    if (!isdefined(level.blood.fade[4])) {
        level.blood.fade[4] = isdefined(level.blood.scriptbundle.var_b7d4e1dd) ? level.blood.scriptbundle.var_b7d4e1dd : 0;
    }
    level.blood.var_8645128b = [];
    if (!isdefined(level.blood.var_8645128b[0])) {
        level.blood.var_8645128b[0] = isdefined(level.blood.scriptbundle.var_a575d921) ? level.blood.scriptbundle.var_a575d921 : 0;
    }
    if (!isdefined(level.blood.var_8645128b[1])) {
        level.blood.var_8645128b[1] = isdefined(level.blood.scriptbundle.var_7f735eb8) ? level.blood.scriptbundle.var_7f735eb8 : 0;
    }
    if (!isdefined(level.blood.var_8645128b[2])) {
        level.blood.var_8645128b[2] = isdefined(level.blood.scriptbundle.var_f17acdf3) ? level.blood.scriptbundle.var_f17acdf3 : 0;
    }
    if (!isdefined(level.blood.var_8645128b[3])) {
        level.blood.var_8645128b[3] = isdefined(level.blood.scriptbundle.var_cb78538a) ? level.blood.scriptbundle.var_cb78538a : 0;
    }
    if (!isdefined(level.blood.var_8645128b[4])) {
        level.blood.var_8645128b[4] = isdefined(level.blood.scriptbundle.var_3d7fc2c5) ? level.blood.scriptbundle.var_3d7fc2c5 : 0;
    }
    level.blood.var_82f935f2 = [];
    if (!isdefined(level.blood.var_82f935f2[0])) {
        level.blood.var_82f935f2[0] = isdefined(level.blood.scriptbundle.var_bd3c6888) ? level.blood.scriptbundle.var_bd3c6888 : 0;
    }
    if (!isdefined(level.blood.var_82f935f2[1])) {
        level.blood.var_82f935f2[1] = isdefined(level.blood.scriptbundle.var_e33ee2f1) ? level.blood.scriptbundle.var_e33ee2f1 : 0;
    }
    if (!isdefined(level.blood.var_82f935f2[2])) {
        level.blood.var_82f935f2[2] = isdefined(level.blood.scriptbundle.var_9415d5a) ? level.blood.scriptbundle.var_9415d5a : 0;
    }
    if (!isdefined(level.blood.var_82f935f2[3])) {
        level.blood.var_82f935f2[3] = isdefined(level.blood.scriptbundle.var_2f43d7c3) ? level.blood.scriptbundle.var_2f43d7c3 : 0;
    }
    if (!isdefined(level.blood.var_82f935f2[4])) {
        level.blood.var_82f935f2[4] = isdefined(level.blood.scriptbundle.var_5546522c) ? level.blood.scriptbundle.var_5546522c : 0;
    }
    function_290ee39c();
    function_b4e469fb();
    level.blood.rob = spawnstruct();
    if (!isdefined(level.blood.rob.stage)) {
        level.blood.rob.stage = isdefined(level.blood.scriptbundle.rob_stage) ? level.blood.scriptbundle.rob_stage : 0;
    }
    if (!isdefined(level.blood.rob.hold_time)) {
        level.blood.rob.hold_time = isdefined(level.blood.scriptbundle.var_9f443fb2) ? level.blood.scriptbundle.var_9f443fb2 : 0;
    }
    if (!isdefined(level.blood.rob.fade_time)) {
        level.blood.rob.fade_time = isdefined(level.blood.scriptbundle.var_a86f469d) ? level.blood.scriptbundle.var_a86f469d : 0;
    }
    if (!isdefined(level.blood.rob.damage_threshold)) {
        level.blood.rob.damage_threshold = isdefined(level.blood.scriptbundle.var_7bac9046) ? level.blood.scriptbundle.var_7bac9046 : 0;
    }
    if (!isdefined(level.blood.var_95c31838)) {
        level.blood.var_95c31838 = isdefined(level.blood.scriptbundle.var_95c31838) ? level.blood.scriptbundle.var_95c31838 : 0;
    }
    level.blood.var_6ce5d6b3 = level.blood.scriptbundle.var_6ce5d6b3;
    level.blood.var_f2fa3500 = level.blood.scriptbundle.var_f2fa3500;
    if (!isdefined(level.blood.var_95c31838)) {
        level.blood.var_95c31838 = isdefined(level.blood.scriptbundle.var_95c31838) ? level.blood.scriptbundle.var_95c31838 : 0;
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x994849c1, Offset: 0x46e0
// Size: 0x9e
function private function_127a1177(localclientnum) {
    splatter = spawnstruct();
    splatter.splatters = [];
    for (j = 0; j < 4; j++) {
        splatter.splatters[j] = [];
    }
    splatter.var_2c5e621d = 0;
    level.blood.var_fddc1a1e.var_925e3756[localclientnum] = splatter;
}

// Namespace blood/blood
// Params 0, eflags: 0x4
// Checksum 0xd1232ea6, Offset: 0x4788
// Size: 0xb62
function private function_b4e469fb() {
    level.blood.var_fddc1a1e = spawnstruct();
    level.blood.var_fddc1a1e.localclients = [];
    for (i = 0; i < getmaxlocalclients(); i++) {
        function_127a1177(i);
    }
    if (!isdefined(level.blood.var_fddc1a1e.enabled)) {
        level.blood.var_fddc1a1e.enabled = isdefined(level.blood.scriptbundle.var_5ba3c725) ? level.blood.scriptbundle.var_5ba3c725 : 0;
    }
    if (!isdefined(level.blood.var_fddc1a1e.damage_ranges)) {
        level.blood.var_fddc1a1e.damage_ranges = isdefined(level.blood.scriptbundle.damage_ranges) ? level.blood.scriptbundle.damage_ranges : 1;
    }
    if (!isdefined(level.blood.var_fddc1a1e.var_f4ef2c7)) {
        level.blood.var_fddc1a1e.var_f4ef2c7 = isdefined(level.blood.scriptbundle.var_f4ef2c7) ? level.blood.scriptbundle.var_f4ef2c7 : 1;
    }
    level.blood.var_fddc1a1e.range = [];
    level.blood.var_fddc1a1e.var_6ce5d6b3 = [];
    level.blood.var_fddc1a1e.var_f2fa3500 = [];
    level.blood.var_fddc1a1e.hold_time = [];
    for (i = 0; i < level.blood.var_fddc1a1e.damage_ranges; i++) {
        level.blood.var_fddc1a1e.range[i] = spawnstruct();
        if (i > 0) {
            if (!isdefined(level.blood.var_fddc1a1e.range[i].start)) {
                level.blood.var_fddc1a1e.range[i].start = isdefined(level.blood.scriptbundle.("damage_range_start_" + i)) ? level.blood.scriptbundle.("damage_range_start_" + i) : level.blood.var_fddc1a1e.range[i - 1].start;
            }
        } else if (!isdefined(level.blood.var_fddc1a1e.range[i].start)) {
            level.blood.var_fddc1a1e.range[i].start = isdefined(level.blood.scriptbundle.("damage_range_start_" + i)) ? level.blood.scriptbundle.("damage_range_start_" + i) : 0;
        }
        if (!isdefined(level.blood.var_fddc1a1e.range[i].blur)) {
            level.blood.var_fddc1a1e.range[i].blur = isdefined(level.blood.scriptbundle.("damage_range_blur_" + i)) ? level.blood.scriptbundle.("damage_range_blur_" + i) : 0;
        }
        if (!isdefined(level.blood.var_fddc1a1e.range[i].opacity)) {
            level.blood.var_fddc1a1e.range[i].opacity = isdefined(level.blood.scriptbundle.("damage_range_opacity_" + i)) ? level.blood.scriptbundle.("damage_range_opacity_" + i) : 0;
        }
        if (!isdefined(level.blood.var_fddc1a1e.var_6ce5d6b3[i])) {
            level.blood.var_fddc1a1e.var_6ce5d6b3[i] = isdefined(level.blood.scriptbundle.("hit_flash_ramp_in_time_" + i)) ? level.blood.scriptbundle.("hit_flash_ramp_in_time_" + i) : 0;
        }
        if (!isdefined(level.blood.var_fddc1a1e.var_f2fa3500[i])) {
            level.blood.var_fddc1a1e.var_f2fa3500[i] = isdefined(level.blood.scriptbundle.("hit_flash_ramp_out_time_" + i)) ? level.blood.scriptbundle.("hit_flash_ramp_out_time_" + i) : 0;
        }
        if (!isdefined(level.blood.var_fddc1a1e.hold_time[i])) {
            level.blood.var_fddc1a1e.hold_time[i] = isdefined(level.blood.scriptbundle.("hit_flash_hold_time_" + i)) ? level.blood.scriptbundle.("hit_flash_hold_time_" + i) : 0;
        }
    }
    level.blood.var_fddc1a1e.dot = spawnstruct();
    if (!isdefined(level.blood.var_fddc1a1e.dot.blur)) {
        level.blood.var_fddc1a1e.dot.blur = isdefined(level.blood.scriptbundle.("dot_blur")) ? level.blood.scriptbundle.("dot_blur") : 0;
    }
    if (!isdefined(level.blood.var_fddc1a1e.dot.opacity)) {
        level.blood.var_fddc1a1e.dot.opacity = isdefined(level.blood.scriptbundle.("dot_opacity")) ? level.blood.scriptbundle.("dot_opacity") : 0;
    }
    if (!isdefined(level.blood.var_fddc1a1e.dot.var_6ce5d6b3)) {
        level.blood.var_fddc1a1e.dot.var_6ce5d6b3 = isdefined(level.blood.scriptbundle.("dot_hit_flash_ramp_in_time")) ? level.blood.scriptbundle.("dot_hit_flash_ramp_in_time") : 0;
    }
    if (!isdefined(level.blood.var_fddc1a1e.dot.var_f2fa3500)) {
        level.blood.var_fddc1a1e.dot.var_f2fa3500 = isdefined(level.blood.scriptbundle.("dot_hit_flash_ramp_out_time")) ? level.blood.scriptbundle.("dot_hit_flash_ramp_out_time") : 0;
    }
    if (!isdefined(level.blood.var_fddc1a1e.dot.hold_time)) {
        level.blood.var_fddc1a1e.dot.hold_time = isdefined(level.blood.scriptbundle.("dot_hit_flash_hold_time")) ? level.blood.scriptbundle.("dot_hit_flash_hold_time") : 0;
    }
    if (!isdefined(level.blood.var_fddc1a1e.dot.var_a0a55a4d)) {
        level.blood.var_fddc1a1e.dot.var_a0a55a4d = isdefined(level.blood.scriptbundle.("dot_ignore_damage_threshold")) ? level.blood.scriptbundle.("dot_ignore_damage_threshold") : 0;
    }
    if (!isdefined(level.blood.var_fddc1a1e.dot.var_fe6a8bc7)) {
        level.blood.var_fddc1a1e.dot.var_fe6a8bc7 = isdefined(level.blood.scriptbundle.("dot_ignore_damage_time")) ? level.blood.scriptbundle.("dot_ignore_damage_time") : 0;
    }
}

// Namespace blood/blood
// Params 0, eflags: 0x4
// Checksum 0x9770ca4a, Offset: 0x52f8
// Size: 0x1ba2
function private function_290ee39c() {
    level.blood.var_b61a66f4 = spawnstruct();
    level.blood.var_b61a66f4.time_in = [];
    level.blood.var_b61a66f4.var_6e69ec28 = [];
    level.blood.var_b61a66f4.time_out = [];
    level.blood.var_b61a66f4.var_75ac8e19 = [];
    level.blood.var_b61a66f4.var_53022589 = [];
    level.blood.var_b61a66f4.var_abd30b0f = [];
    level.blood.var_b61a66f4.var_b1f1aaa0 = [];
    level.blood.var_b61a66f4.var_e5a8ae8 = [];
    level.blood.var_b61a66f4.time_in[0] = [];
    if (!isdefined(level.blood.var_b61a66f4.time_in[0][0])) {
        level.blood.var_b61a66f4.time_in[0][0] = isdefined(level.blood.scriptbundle.var_45f21349) ? level.blood.scriptbundle.var_45f21349 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_in[0][1])) {
        level.blood.var_b61a66f4.time_in[0][1] = isdefined(level.blood.scriptbundle.var_1fef98e0) ? level.blood.scriptbundle.var_1fef98e0 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_in[0][2])) {
        level.blood.var_b61a66f4.time_in[0][2] = isdefined(level.blood.scriptbundle.var_91f7081b) ? level.blood.scriptbundle.var_91f7081b : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_in[0][3])) {
        level.blood.var_b61a66f4.time_in[0][3] = isdefined(level.blood.scriptbundle.var_6bf48db2) ? level.blood.scriptbundle.var_6bf48db2 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_in[0][4])) {
        level.blood.var_b61a66f4.time_in[0][4] = isdefined(level.blood.scriptbundle.var_ddfbfced) ? level.blood.scriptbundle.var_ddfbfced : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_53022589[0])) {
        level.blood.var_b61a66f4.var_53022589[0] = level.blood.var_b61a66f4.time_in[0][0];
    }
    level.blood.var_b61a66f4.time_in[1] = [];
    if (!isdefined(level.blood.var_b61a66f4.time_in[1][0])) {
        level.blood.var_b61a66f4.time_in[1][0] = isdefined(level.blood.scriptbundle.var_3a1c76c0) ? level.blood.scriptbundle.var_3a1c76c0 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_in[1][1])) {
        level.blood.var_b61a66f4.time_in[1][1] = isdefined(level.blood.scriptbundle.var_601ef129) ? level.blood.scriptbundle.var_601ef129 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_in[1][2])) {
        level.blood.var_b61a66f4.time_in[1][2] = isdefined(level.blood.scriptbundle.var_86216b92) ? level.blood.scriptbundle.var_86216b92 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_in[1][3])) {
        level.blood.var_b61a66f4.time_in[1][3] = isdefined(level.blood.scriptbundle.var_ac23e5fb) ? level.blood.scriptbundle.var_ac23e5fb : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_in[1][4])) {
        level.blood.var_b61a66f4.time_in[1][4] = isdefined(level.blood.scriptbundle.var_d2266064) ? level.blood.scriptbundle.var_d2266064 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_53022589[1])) {
        level.blood.var_b61a66f4.var_53022589[1] = level.blood.var_b61a66f4.time_in[1][0];
    }
    level.blood.var_b61a66f4.var_6e69ec28[0] = [];
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[0][0])) {
        level.blood.var_b61a66f4.var_6e69ec28[0][0] = isdefined(level.blood.scriptbundle.var_37c6ac7d) ? level.blood.scriptbundle.var_37c6ac7d : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[0][1])) {
        level.blood.var_b61a66f4.var_6e69ec28[0][1] = isdefined(level.blood.scriptbundle.var_11c43214) ? level.blood.scriptbundle.var_11c43214 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[0][2])) {
        level.blood.var_b61a66f4.var_6e69ec28[0][2] = isdefined(level.blood.scriptbundle.var_83cba14f) ? level.blood.scriptbundle.var_83cba14f : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[0][3])) {
        level.blood.var_b61a66f4.var_6e69ec28[0][3] = isdefined(level.blood.scriptbundle.var_5dc926e6) ? level.blood.scriptbundle.var_5dc926e6 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[0][4])) {
        level.blood.var_b61a66f4.var_6e69ec28[0][4] = isdefined(level.blood.scriptbundle.var_9fbcc2d9) ? level.blood.scriptbundle.var_9fbcc2d9 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_abd30b0f[0])) {
        level.blood.var_b61a66f4.var_abd30b0f[0] = level.blood.var_b61a66f4.var_6e69ec28[0][0];
    }
    level.blood.var_b61a66f4.var_6e69ec28[1] = [];
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[1][0])) {
        level.blood.var_b61a66f4.var_6e69ec28[1][0] = isdefined(level.blood.scriptbundle.var_2f8ae714) ? level.blood.scriptbundle.var_2f8ae714 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[1][1])) {
        level.blood.var_b61a66f4.var_6e69ec28[1][1] = isdefined(level.blood.scriptbundle.var_558d617d) ? level.blood.scriptbundle.var_558d617d : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[1][2])) {
        level.blood.var_b61a66f4.var_6e69ec28[1][2] = isdefined(level.blood.scriptbundle.var_7b8fdbe6) ? level.blood.scriptbundle.var_7b8fdbe6 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[1][3])) {
        level.blood.var_b61a66f4.var_6e69ec28[1][3] = isdefined(level.blood.scriptbundle.var_a192564f) ? level.blood.scriptbundle.var_a192564f : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_6e69ec28[1][4])) {
        level.blood.var_b61a66f4.var_6e69ec28[1][4] = isdefined(level.blood.scriptbundle.var_9780fd70) ? level.blood.scriptbundle.var_9780fd70 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_abd30b0f[1])) {
        level.blood.var_b61a66f4.var_abd30b0f[1] = level.blood.var_b61a66f4.var_6e69ec28[1][0];
    }
    level.blood.var_b61a66f4.time_out[0] = [];
    if (!isdefined(level.blood.var_b61a66f4.time_out[0][0])) {
        level.blood.var_b61a66f4.time_out[0][0] = isdefined(level.blood.scriptbundle.var_1c996e76) ? level.blood.scriptbundle.var_1c996e76 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_out[0][1])) {
        level.blood.var_b61a66f4.time_out[0][1] = isdefined(level.blood.scriptbundle.var_429be8df) ? level.blood.scriptbundle.var_429be8df : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_out[0][2])) {
        level.blood.var_b61a66f4.time_out[0][2] = isdefined(level.blood.scriptbundle.var_d09479a4) ? level.blood.scriptbundle.var_d09479a4 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_out[0][3])) {
        level.blood.var_b61a66f4.time_out[0][3] = isdefined(level.blood.scriptbundle.var_f696f40d) ? level.blood.scriptbundle.var_f696f40d : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_out[0][4])) {
        level.blood.var_b61a66f4.time_out[0][4] = isdefined(level.blood.scriptbundle.var_848f84d2) ? level.blood.scriptbundle.var_848f84d2 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_b1f1aaa0[0])) {
        level.blood.var_b61a66f4.var_b1f1aaa0[0] = level.blood.var_b61a66f4.time_out[0][0];
    }
    level.blood.var_b61a66f4.time_out[1] = [];
    if (!isdefined(level.blood.var_b61a66f4.time_out[1][0])) {
        level.blood.var_b61a66f4.time_out[1][0] = isdefined(level.blood.scriptbundle.var_514ba047) ? level.blood.scriptbundle.var_514ba047 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_out[1][1])) {
        level.blood.var_b61a66f4.time_out[1][1] = isdefined(level.blood.scriptbundle.var_2b4925de) ? level.blood.scriptbundle.var_2b4925de : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_out[1][2])) {
        level.blood.var_b61a66f4.time_out[1][2] = isdefined(level.blood.scriptbundle.var_546ab75) ? level.blood.scriptbundle.var_546ab75 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_out[1][3])) {
        level.blood.var_b61a66f4.time_out[1][3] = isdefined(level.blood.scriptbundle.var_df44310c) ? level.blood.scriptbundle.var_df44310c : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.time_out[1][4])) {
        level.blood.var_b61a66f4.time_out[1][4] = isdefined(level.blood.scriptbundle.var_b941b6a3) ? level.blood.scriptbundle.var_b941b6a3 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_b1f1aaa0[1])) {
        level.blood.var_b61a66f4.var_b1f1aaa0[1] = level.blood.var_b61a66f4.time_out[1][0];
    }
    level.blood.var_b61a66f4.var_75ac8e19[0] = [];
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[0][0])) {
        level.blood.var_b61a66f4.var_75ac8e19[0][0] = isdefined(level.blood.scriptbundle.var_6310138) ? level.blood.scriptbundle.var_6310138 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[0][1])) {
        level.blood.var_b61a66f4.var_75ac8e19[0][1] = isdefined(level.blood.scriptbundle.var_2c337ba1) ? level.blood.scriptbundle.var_2c337ba1 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[0][2])) {
        level.blood.var_b61a66f4.var_75ac8e19[0][2] = isdefined(level.blood.scriptbundle.var_5235f60a) ? level.blood.scriptbundle.var_5235f60a : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[0][3])) {
        level.blood.var_b61a66f4.var_75ac8e19[0][3] = isdefined(level.blood.scriptbundle.var_78387073) ? level.blood.scriptbundle.var_78387073 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[0][4])) {
        level.blood.var_b61a66f4.var_75ac8e19[0][4] = isdefined(level.blood.scriptbundle.var_9e3aeadc) ? level.blood.scriptbundle.var_9e3aeadc : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_e5a8ae8[0])) {
        level.blood.var_b61a66f4.var_e5a8ae8[0] = level.blood.var_b61a66f4.var_75ac8e19[0][0];
    }
    level.blood.var_b61a66f4.var_75ac8e19[1] = [];
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[1][0])) {
        level.blood.var_b61a66f4.var_75ac8e19[1][0] = isdefined(level.blood.scriptbundle.var_e615ed81) ? level.blood.scriptbundle.var_e615ed81 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[1][1])) {
        level.blood.var_b61a66f4.var_75ac8e19[1][1] = isdefined(level.blood.scriptbundle.var_c0137318) ? level.blood.scriptbundle.var_c0137318 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[1][2])) {
        level.blood.var_b61a66f4.var_75ac8e19[1][2] = isdefined(level.blood.scriptbundle.var_321ae253) ? level.blood.scriptbundle.var_321ae253 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[1][3])) {
        level.blood.var_b61a66f4.var_75ac8e19[1][3] = isdefined(level.blood.scriptbundle.var_c1867ea) ? level.blood.scriptbundle.var_c1867ea : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_75ac8e19[1][4])) {
        level.blood.var_b61a66f4.var_75ac8e19[1][4] = isdefined(level.blood.scriptbundle.var_7e1fd725) ? level.blood.scriptbundle.var_7e1fd725 : 0;
    }
    if (!isdefined(level.blood.var_b61a66f4.var_e5a8ae8[1])) {
        level.blood.var_b61a66f4.var_e5a8ae8[1] = level.blood.var_b61a66f4.var_75ac8e19[1][0];
    }
}

