#using scripts/core_common/callbacks_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace blood;

// Namespace blood/blood
// Params 0, eflags: 0x2
// Checksum 0xe2a9962b, Offset: 0x398
// Size: 0x2c
function autoexec __init__sytem__() {
    system::register("blood", undefined, &__postload_init__, undefined);
}

// Namespace blood/blood
// Params 0, eflags: 0x0
// Checksum 0x628f987a, Offset: 0x3d0
// Size: 0x1c4
function __postload_init__() {
    if (function_326e25d1()) {
        level.var_506d15d3 = [];
        level.var_506d15d3[1] = "generic_blood_overlay_01";
        level.var_506d15d3[2] = "generic_blood_overlay_02";
        level.var_506d15d3[3] = "generic_blood_overlay_03";
        level.var_506d15d3[4] = "generic_blood_overlay_04";
        callback::on_localplayer_spawned(&function_9ea652d1);
        return;
    }
    level.var_3c53fa9a = getdvarfloat("cg_t7HealthOverlay_Threshold3", 0.5);
    level.var_62567503 = getdvarfloat("cg_t7HealthOverlay_Threshold2", 0.8);
    level.var_f04f05c8 = getdvarfloat("cg_t7HealthOverlay_Threshold1", 0.99);
    level.var_d9defa1c = getdvarfloat("scr_use_digital_blood_enabled", 1);
    if (isdefined(level.var_3fd73fb2) && level.var_3fd73fb2) {
        level.var_3c53fa9a = 0.8;
    }
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace blood/blood
// Params 1, eflags: 0x0
// Checksum 0x3c3b6b3a, Offset: 0x5a0
// Size: 0x13c
function localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    /#
        level.var_d9defa1c = getdvarfloat("<dev string:x28>", level.var_d9defa1c);
    #/
    self.var_d38c16be = 0;
    bodytype = self getcharacterbodytype();
    if (level.var_d9defa1c && bodytype >= 0) {
        var_f99f1882 = getcharacterfields(bodytype, currentsessionmode());
        self.var_d38c16be = isdefined(var_f99f1882.digitalblood) ? var_f99f1882.digitalblood : 0;
    }
    self thread function_ff801c5b(localclientnum);
    self thread function_d707564c(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x0
// Checksum 0x6c0254cf, Offset: 0x6e8
// Size: 0x34
function function_d707564c(localclientnum) {
    self waittill("death");
    self function_14cd2c76(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xbe6a2f69, Offset: 0x728
// Size: 0x104
function private function_5cc93aa5(localclientnum) {
    self.blood_enabled = 1;
    filter::function_cfe957f(localclientnum, self.var_d38c16be);
    filter::function_c6391b80(localclientnum, 2, 2, self.var_d38c16be);
    filter::function_ba8f6d71(localclientnum, 2, 2, 65, 32);
    filter::function_1532508d(localclientnum, self.var_d38c16be);
    filter::function_c4e616ee(localclientnum, 2, 1, self.var_d38c16be);
    filter::function_db8726c7(localclientnum, 2, 1, randomfloat(1));
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xf6e32af6, Offset: 0x838
// Size: 0x94
function private function_14cd2c76(localclientnum) {
    if (isdefined(self)) {
        self.blood_enabled = 0;
    }
    filter::function_4a86fcb7(localclientnum, 2, 2);
    filter::function_e8ee9075(localclientnum, 2, 1);
    if (!(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange)) {
        setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace blood/blood
// Params 2, eflags: 0x4
// Checksum 0xb8413b30, Offset: 0x8d8
// Size: 0x2e4
function private function_704ec8bf(localclientnum, playerhealth) {
    if (level.new_health_model) {
        playerhealth *= getdvarfloat("new_blood_in_scale", 0.66);
    }
    if (playerhealth < level.var_3c53fa9a) {
        self.stage3amount = (level.var_3c53fa9a - playerhealth) / level.var_3c53fa9a;
    } else {
        self.stage3amount = 0;
    }
    if (playerhealth < level.var_62567503) {
        self.stage2amount = (level.var_62567503 - playerhealth) / level.var_62567503;
    } else {
        self.stage2amount = 0;
    }
    var_e11af197 = level.new_health_model ? 0 : 1;
    filter::function_dd2f5261(localclientnum, 2, 2, var_e11af197);
    filter::function_fd3a600(localclientnum, 2, 2, self.stage3amount);
    filter::function_f3adf179(localclientnum, 2, 2, self.stage2amount);
    if (playerhealth < level.var_f04f05c8) {
        var_f3107012 = 0.55;
        if (isdefined(level.var_3fd73fb2) && level.var_3fd73fb2) {
            var_f3107012 = 0.96;
        }
        /#
            assert(level.var_f04f05c8 > var_f3107012);
        #/
        var_44739e87 = playerhealth - var_f3107012;
        if (var_44739e87 < 0) {
            var_44739e87 = 0;
        }
        self.var_ca7d9806 = 1 - var_44739e87 / (level.var_f04f05c8 - var_f3107012);
    } else {
        self.var_ca7d9806 = 0;
    }
    filter::function_dd2f5261(localclientnum, 2, 1, var_e11af197);
    filter::function_c511e703(localclientnum, 2, 1, self.var_ca7d9806);
    filter::function_5152516c(localclientnum, 2, 1, getservertime(localclientnum));
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xfd7c48a1, Offset: 0xbc8
// Size: 0x24c
function private function_2bd5d4ea(localclientnum) {
    currenttime = getservertime(localclientnum);
    elapsedtime = currenttime - self.lastbloodupdate;
    self.lastbloodupdate = currenttime;
    var_cdf3aad1 = level.new_health_model ? getdvarint("new_blood_fade_rate", 1800) : 1000;
    if (var_cdf3aad1 <= 100) {
        var_cdf3aad1 = 100;
    }
    subtract = elapsedtime / var_cdf3aad1;
    if (self.stage3amount > 0) {
        self.stage3amount -= subtract;
    }
    if (self.stage3amount < 0) {
        self.stage3amount = 0;
    }
    if (self.stage2amount > 0) {
        self.stage2amount -= subtract;
    }
    if (self.stage2amount < 0) {
        self.stage2amount = 0;
    }
    filter::function_fd3a600(localclientnum, 2, 2, self.stage3amount);
    filter::function_f3adf179(localclientnum, 2, 2, self.stage2amount);
    if (self.var_ca7d9806 > 0) {
        self.var_ca7d9806 -= subtract;
    }
    if (self.var_ca7d9806 < 0) {
        self.var_ca7d9806 = 0;
    }
    filter::function_c511e703(localclientnum, 2, 1, self.var_ca7d9806);
    filter::function_5152516c(localclientnum, 2, 1, getservertime(localclientnum));
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x9b486312, Offset: 0xe20
// Size: 0x41e
function private function_ff801c5b(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killbloodoverlay");
    self.stage2amount = 0;
    self.stage3amount = 0;
    self.lastbloodupdate = 0;
    basehealth = level.new_health_model ? 100 : 0;
    priorplayerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
    self function_704ec8bf(localclientnum, priorplayerhealth);
    while (true) {
        if (renderhealthoverlay(localclientnum) && !(isdefined(self.nobloodoverlay) && self.nobloodoverlay)) {
            shouldenabledoverlay = 0;
            playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
            if (playerhealth < priorplayerhealth && playerhealth < 1) {
                shouldenabledoverlay = 1;
                self function_704ec8bf(localclientnum, playerhealth);
            } else if (playerhealth == priorplayerhealth && playerhealth < 1) {
                shouldenabledoverlay = 1;
                self.lastbloodupdate = getservertime(localclientnum);
            } else if (self.stage2amount > 0 || self.stage3amount > 0) {
                shouldenabledoverlay = 1;
                self function_2bd5d4ea(localclientnum);
            } else if (isdefined(self.blood_enabled) && self.blood_enabled) {
                self function_14cd2c76(localclientnum);
            }
            priorplayerhealth = playerhealth;
            if (!(isdefined(self.blood_enabled) && self.blood_enabled) && shouldenabledoverlay) {
                self function_5cc93aa5(localclientnum);
            }
            if (!(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange)) {
                if (self.stage3amount > 0) {
                    setcontrollerlightbarcolorpulsing(localclientnum, (1, 0, 0), 600);
                } else if (self.stage2amount == 1) {
                    setcontrollerlightbarcolorpulsing(localclientnum, (0.8, 0, 0), 1200);
                } else if ((!sessionmodeiscampaigngame() || codegetuimodelclientfield(self, "playerAbilities.inRange")) && getgadgetpower(localclientnum) == 1) {
                    setcontrollerlightbarcolorpulsing(localclientnum, (1, 1, 0), 2000);
                } else if (isdefined(self.controllercolor)) {
                    setcontrollerlightbarcolor(localclientnum, self.controllercolor);
                } else {
                    setcontrollerlightbarcolor(localclientnum);
                }
            }
        } else if (isdefined(self.blood_enabled) && self.blood_enabled) {
            self function_14cd2c76(localclientnum);
        }
        waitframe(1);
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0xa6143992, Offset: 0x1248
// Size: 0xc4
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
// Params 0, eflags: 0x0
// Checksum 0xc2e5a392, Offset: 0x1318
// Size: 0x30
function function_326e25d1() {
    return level.new_health_model && getdvarint("new_blood_version", 1) == 2;
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x6b294f3f, Offset: 0x1350
// Size: 0xf4
function private function_9ea652d1(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    self stop_breath(localclientnum);
    level thread wait_game_ended(localclientnum);
    self thread function_db927f4(localclientnum);
    self thread function_e36b58d7(localclientnum);
    new_health_model_ui_model = createuimodel(getuimodelforcontroller(localclientnum), "usingNewHealthModel");
    if (isdefined(new_health_model_ui_model)) {
        setuimodelvalue(new_health_model_ui_model, level.new_health_model);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x7f382392, Offset: 0x1450
// Size: 0x4c
function private function_e36b58d7(localclientnum) {
    self waittill("death");
    self function_5e0fa6d5(localclientnum);
    self end_splatter(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xde2d7c5a, Offset: 0x14a8
// Size: 0xbc
function private function_c3dba3d2(localclientnum) {
    self.blood_enabled = 1;
    if (!isdefined(self.var_343bd12e)) {
        self.var_343bd12e = "generic_blood_overlay_01";
    }
    setfilterpassmaterial(localclientnum, 2, 1, get_mat_id(localclientnum, self.var_343bd12e));
    filter::function_f3adf179(localclientnum, 2, 1, 1);
    setfilterpassenabled(localclientnum, 2, 1, 1);
}

// Namespace blood/blood
// Params 2, eflags: 0x4
// Checksum 0xa19ae970, Offset: 0x1570
// Size: 0x7c
function private get_mat_id(localclientnum, filter_name) {
    mat_id = filter::mapped_material_id(filter_name);
    if (!isdefined(mat_id)) {
        filter::map_material_helper_by_localclientnum(localclientnum, filter_name);
        mat_id = filter::mapped_material_id(filter_name);
    }
    return mat_id;
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xc5877bbd, Offset: 0x15f8
// Size: 0x84
function private function_5e0fa6d5(localclientnum) {
    if (isdefined(self)) {
        self.blood_enabled = 0;
    }
    setfilterpassenabled(localclientnum, 2, 1, 0);
    if (!isdefined(self) || !(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange)) {
        setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xa5ce2846, Offset: 0x1688
// Size: 0x1f6
function private function_db927f4(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killbloodoverlay");
    /#
        assert(level.new_health_model == 1);
    #/
    basehealth = 100;
    playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
    while (true) {
        if (!isdefined(self.blood_enabled)) {
            self.blood_enabled = 0;
        }
        var_b57d12af = 0;
        if (renderhealthoverlay(localclientnum)) {
            priorplayerhealth = playerhealth;
            playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
            if (priorplayerhealth - playerhealth > 0.05) {
                self thread splatter(localclientnum);
            }
            shouldenabledoverlay = 0;
            if (playerhealth < 1) {
                var_b57d12af = 1;
            }
            self function_578fc2c0(localclientnum, playerhealth);
        }
        if (var_b57d12af) {
            if (!self.blood_enabled) {
                self function_c3dba3d2(localclientnum);
            }
        } else if (self.blood_enabled) {
            self function_5e0fa6d5(localclientnum);
        }
        waitframe(1);
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0xa64ab1ca, Offset: 0x1888
// Size: 0x27c
function private function_578fc2c0(localclientnum, playerhealth, basehealth) {
    if (!isdefined(basehealth)) {
        basehealth = 100;
    }
    if (!isdefined(self.last_blood_stage)) {
        self.last_blood_stage = 0;
    }
    stage2_threshold = getdvarint("new_blood_stage_2", 75) / basehealth;
    stage3_threshold = getdvarint("new_blood_stage_3", 50) / basehealth;
    stage4_threshold = getdvarint("new_blood_stage_4", 25) / basehealth;
    prior_blood_stage = self.last_blood_stage;
    new_blood_stage = 0;
    if (playerhealth < 1 && playerhealth > 0) {
        if (playerhealth <= stage3_threshold) {
            new_blood_stage = playerhealth <= stage4_threshold ? 4 : 3;
        } else {
            new_blood_stage = playerhealth <= stage2_threshold ? 2 : 1;
        }
    }
    if (new_blood_stage != prior_blood_stage) {
        if (new_blood_stage > 0) {
            self.var_343bd12e = level.var_506d15d3[new_blood_stage];
            filter::map_material_helper_by_localclientnum(localclientnum, self.var_343bd12e);
            if (self.blood_enabled) {
                setfilterpassmaterial(localclientnum, 2, 1, filter::mapped_material_id(self.var_343bd12e));
            }
            if (new_blood_stage > prior_blood_stage) {
                self thread play_new_stage_rumble(localclientnum);
                if (new_blood_stage == 4) {
                    self enter_critical_health(localclientnum);
                }
            }
            if (new_blood_stage < 4) {
                self notify(#"critical_health_end");
            }
        }
    }
    self.last_blood_stage = new_blood_stage;
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xf440daa0, Offset: 0x1b10
// Size: 0x1fc
function private splatter(localclientnum) {
    self notify(#"hash_691c90a");
    self endon(#"hash_691c90a");
    splatter_opacity = 1;
    start_splatter(localclientnum);
    initial_delay = math::clamp(getdvarint("new_blood_splatter_hold", 300), 10, 3000);
    wait initial_delay / 1000;
    if (!isdefined(self)) {
        return;
    }
    lasttime = self getclienttime();
    while (splatter_opacity > 0 && isdefined(self)) {
        now = self getclienttime();
        elapsedtime = now - lasttime;
        if (elapsedtime > 0) {
            fadeduration = math::clamp(getdvarint("new_blood_splatter_fade", 300), 10, 88000);
            splatter_opacity -= elapsedtime / fadeduration;
            splatter_opacity = math::clamp(splatter_opacity, 0, 1);
            lasttime = now;
        }
        filter::function_f3adf179(localclientnum, 2, 0, splatter_opacity);
        waitframe(1);
    }
    end_splatter(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xc1cf3b5f, Offset: 0x1d18
// Size: 0xa4
function private start_splatter(localclientnum) {
    filter::map_material_helper_by_localclientnum(localclientnum, "generic_blood_overlay_00");
    setfilterpassmaterial(localclientnum, 2, 0, filter::mapped_material_id("generic_blood_overlay_00"));
    filter::function_f3adf179(localclientnum, 2, 0, 1);
    setfilterpassenabled(localclientnum, 2, 0, 1);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x1dc1d6f6, Offset: 0x1dc8
// Size: 0x2c
function private end_splatter(localclientnum) {
    setfilterpassenabled(localclientnum, 2, 0, 0);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xc9e9761c, Offset: 0x1e00
// Size: 0x6e
function private play_new_stage_rumble(localclientnum) {
    self endon(#"death", #"disconnect");
    for (i = 0; i < 2; i++) {
        self playrumbleonentity(localclientnum, "new_health_stage");
        wait 0.4;
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x21dbce56, Offset: 0x1e78
// Size: 0x3c
function private enter_critical_health(localclientnum) {
    self thread play_critical_health_rumble(localclientnum);
    self play_breath(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xe61c6444, Offset: 0x1ec0
// Size: 0x90
function private play_critical_health_rumble(localclientnum) {
    self endon(#"death", #"disconnect", #"critical_health_end", #"spawned");
    wait 1.4;
    while (true) {
        self playrumbleonentity(localclientnum, "new_health_stage");
        self playsound(localclientnum, "mpl_player_heartbeat");
        wait 1;
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xd2f3faef, Offset: 0x1f58
// Size: 0x84
function private play_breath(localclientnum) {
    self stop_breath(localclientnum);
    snd_handle = self playloopsound("chr_health_low_breath_loop", 0.1);
    level.hurt_breath_snd_handle[localclientnum] = snd_handle;
    self thread watch_end_breath(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x3609beb7, Offset: 0x1fe8
// Size: 0x4c
function private watch_end_breath(localclientnum) {
    self waittill("death", "disconnect", "critical_health_end", "spawned");
    stop_breath(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x7af0ae9f, Offset: 0x2040
// Size: 0xb4
function private stop_breath(localclientnum) {
    if (!isdefined(level.hurt_breath_snd_handle)) {
        level.hurt_breath_snd_handle = [];
    }
    if (isdefined(level.hurt_breath_snd_handle[localclientnum])) {
        localplayer = getlocalplayer(localclientnum);
        if (isdefined(localplayer)) {
            localplayer stoploopsound(level.hurt_breath_snd_handle[localclientnum], 1);
        }
        level.hurt_breath_snd_handle[localclientnum] = undefined;
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x43031192, Offset: 0x2100
// Size: 0xd6
function private wait_game_ended(localclientnum) {
    if (!isdefined(level.watching_blood_game_ended)) {
        level.watching_blood_game_ended = [];
    }
    if (level.watching_blood_game_ended[localclientnum] === 1) {
        return;
    }
    level.watching_blood_game_ended[localclientnum] = 1;
    level waittill("game_ended");
    stop_breath(localclientnum);
    localplayer = getlocalplayer(localclientnum);
    if (isdefined(localplayer)) {
        localplayer notify(#"critical_health_end");
    }
    level.watching_blood_game_ended[localclientnum] = 0;
}

