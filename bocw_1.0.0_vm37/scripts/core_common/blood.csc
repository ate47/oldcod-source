#using script_59f62971655f7103;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace blood;

// Namespace blood/blood
// Params 0, eflags: 0x6
// Checksum 0xb5eac5b3, Offset: 0x328
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"blood", &preload, &postload, undefined, undefined);
}

// Namespace blood/blood
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x380
// Size: 0x4
function preload() {
    
}

// Namespace blood/blood
// Params 0, eflags: 0x0
// Checksum 0x3e1bf0cb, Offset: 0x390
// Size: 0x6c
function postload() {
    function_dd830dee();
    callback::on_localplayer_spawned(&function_e79ccfd8);
    callback::on_localclient_connect(&localclient_connect);
    level.var_f771ff42 = util::is_mature();
}

// Namespace blood/blood
// Params 1, eflags: 0x0
// Checksum 0x4b6b119b, Offset: 0x408
// Size: 0x2c
function getsplatter(localclientnum) {
    return level.blood.var_de10c136.var_51036e02[localclientnum];
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xbbd2298a, Offset: 0x440
// Size: 0x24
function private localclient_connect(localclientnum) {
    level thread player_splatter(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xba93424e, Offset: 0x470
// Size: 0x1fc
function private function_e79ccfd8(localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    if (function_148ccc79(localclientnum, #"hash_73c750f53749d44d")) {
        codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
    }
    self.pstfx_blood = #"hash_44dcb6ac5e8787e0";
    self.wound_rob = "rob_wound_blood_splatter";
    self.var_82dad7be = self battlechatter::get_player_dialog_alias("exertBreatheHurt");
    function_6deee27e(localclientnum);
    function_162fe6ec(localclientnum);
    self.var_9861062 = 0;
    if (isdefined(level.blood.soundhandle)) {
        function_d48752e(localclientnum, level.blood.soundhandle);
        level.blood.soundhandle = undefined;
    }
    level thread wait_game_ended(localclientnum);
    if (self function_d2cb869e("rob_wound_blood_splatter")) {
        self stoprenderoverridebundle("rob_wound_blood_splatter");
    }
    if (self function_d2cb869e("rob_wound_blood_splatter_reaper")) {
        self stoprenderoverridebundle("rob_wound_blood_splatter_reaper");
    }
    self thread function_87544c4a(localclientnum);
    self thread function_493a8fbc(localclientnum);
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0x20d70e5e, Offset: 0x678
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
// Checksum 0x2e9351d, Offset: 0x738
// Size: 0x3c
function private enter_critical_health(localclientnum) {
    self thread play_critical_health_rumble(localclientnum);
    self thread play_breath(localclientnum);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xc8354f59, Offset: 0x780
// Size: 0x158
function private play_critical_health_rumble(localclientnum) {
    self endon(#"death", #"disconnect", #"critical_health_end", #"spawned");
    var_cf155b98 = "new_health_stage_critical";
    while (true) {
        self waittill(#"pulse_blood");
        self playrumbleonentity(localclientnum, var_cf155b98);
        name = self getmpdialogname();
        if (!isdefined(name)) {
            name = #"human";
        }
        if (name == #"reaper") {
            sound = #"hash_14e9bc45552b1ab9";
        } else {
            sound = #"hash_318f22e4d70ee6d3";
        }
        if (!is_true(self.var_e9dd2ca0)) {
            self playsound(localclientnum, sound);
        }
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x48c5f019, Offset: 0x8e0
// Size: 0x10e
function private play_breath(localclientnum) {
    self endon(#"death", #"disconnect", #"game_ended", #"critical_health_end");
    self.var_82dad7be = isdefined(self.var_82dad7be) ? self.var_82dad7be : self battlechatter::get_player_dialog_alias("exertBreatheHurt");
    while (true) {
        if (isdefined(self.var_82dad7be)) {
            var_a1b836dd = self playsound(localclientnum, self.var_82dad7be);
        }
        if (!isdefined(var_a1b836dd)) {
            return;
        }
        while (isdefined(var_a1b836dd) && soundplaying(var_a1b836dd)) {
            wait 0.1;
        }
        wait 2;
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x7b9a545b, Offset: 0x9f8
// Size: 0xb8
function private wait_game_ended(localclientnum) {
    if (!isdefined(level.watching_blood_game_ended)) {
        level.watching_blood_game_ended = [];
    }
    if (level.watching_blood_game_ended[localclientnum] === 1) {
        return;
    }
    level.watching_blood_game_ended[localclientnum] = 1;
    level waittill(#"game_ended");
    localplayer = function_5c10bd79(localclientnum);
    if (isdefined(localplayer)) {
        localplayer notify(#"critical_health_end");
    }
    level.watching_blood_game_ended[localclientnum] = 0;
}

// Namespace blood/blood
// Params 2, eflags: 0x4
// Checksum 0xbb97e5b8, Offset: 0xab8
// Size: 0x1fc
function private function_f192f00b(localclientnum, rob) {
    self notify("288e4e111576700c");
    self endon("288e4e111576700c");
    self endon(#"death");
    if (function_148ccc79(localclientnum, rob)) {
        self function_78233d29(rob, "", "U Offset", randomfloatrange(0, 1));
        self function_78233d29(rob, "", "V Offset", randomfloatrange(0, 1));
        self function_78233d29(rob, "", "Threshold", 1);
    }
    wait float(level.blood.rob.hold_time) / 1000;
    if (function_148ccc79(localclientnum, rob)) {
        self thread ramprobsetting(localclientnum, 1, 0, level.blood.rob.fade_time, "Threshold");
    }
    wait float(level.blood.rob.fade_time) / 1000;
    if (function_148ccc79(localclientnum, rob)) {
        self stoprenderoverridebundle(rob);
    }
}

// Namespace blood/blood
// Params 5, eflags: 0x0
// Checksum 0xfe261074, Offset: 0xcc0
// Size: 0x94
function ramprobsetting(localclientnum, from, to, ramptime, key) {
    self endon(#"death");
    self notify("rampROBsetting" + key);
    self endon("rampROBsetting" + key);
    util::lerp_generic(localclientnum, ramptime, &function_1126eb8c, from, to, key, self.wound_rob);
}

// Namespace blood/blood
// Params 8, eflags: 0x0
// Checksum 0x5526f771, Offset: 0xd60
// Size: 0xc4
function function_1126eb8c(*currenttime, elapsedtime, *localclientnum, duration, stagefrom, stageto, key, rob) {
    percent = localclientnum / duration;
    amount = stageto * percent + stagefrom * (1 - percent);
    if (isdefined(self) && self function_d2cb869e(rob)) {
        self function_78233d29(rob, "", key, amount);
    }
}

// Namespace blood/blood
// Params 2, eflags: 0x0
// Checksum 0xa20c7584, Offset: 0xe30
// Size: 0x2dc
function function_672c739(localclientnum, shockrifle) {
    if (is_true(shockrifle)) {
        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"enable tint", 0.9);
        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color r", 4);
        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color g", 4);
        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color b", 4);
        return;
    }
    if (util::function_2c435484()) {
        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"enable tint", 1);
        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color r", 0.15);
        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color g", 0.13);
        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color b", 0.24);
        return;
    }
    function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"enable tint", 1);
    function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color r", 0.3);
    function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color g", 0.025);
    function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"tint color b", 0);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xb32164f4, Offset: 0x1118
// Size: 0x68
function private function_27d3ba05(localclientnum) {
    if (function_92beaa28(localclientnum) && !function_d17ae3cc(localclientnum)) {
        return false;
    }
    if (level.var_4ecf5754 === #"silent_film") {
        return false;
    }
    return true;
}

// Namespace blood/blood
// Params 5, eflags: 0x4
// Checksum 0xb453f0c5, Offset: 0x1188
// Size: 0xbc
function private function_47d0632f(localclientnum, damage, death, dot, shockrifle) {
    if (function_27d3ba05(localclientnum)) {
        splatter = getsplatter(localclientnum);
        splatter.shockrifle = shockrifle;
        splatter.var_120a7b2c++;
        var_cd141ca2 = splatter.var_120a7b2c % 4;
        level thread splatter_postfx(localclientnum, self, damage, var_cd141ca2, death, dot);
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0xa1736532, Offset: 0x1250
// Size: 0x17c
function private update_damage_effects(localclientnum, damage, death) {
    assert(damage > 0);
    if (damage < 10 && is_true(self.dot_no_splatter)) {
        self.dot_no_splatter = 0;
    } else if (self.dot_damaged === 1) {
        function_47d0632f(localclientnum, damage, death, 1, 0);
        self.dot_damaged = 0;
    } else {
        function_47d0632f(localclientnum, damage, death, 0, 0);
    }
    if (damage > level.blood.rob.damage_threshold) {
        if (!self function_d2503806(self.wound_rob)) {
            self playrenderoverridebundle(self.wound_rob);
        }
        if (self function_d2503806(self.wound_rob)) {
            self thread function_f192f00b(localclientnum, self.wound_rob);
        }
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x8b4d2ba1, Offset: 0x13d8
// Size: 0x32a
function private player_splatter(localclientnum) {
    level notify("player_splatter" + localclientnum);
    level endon("player_splatter" + localclientnum);
    while (true) {
        level waittill(#"splatters_active");
        splatter = getsplatter(localclientnum);
        splatters = splatter.splatters;
        while (true) {
            blur = 0;
            opacity = 0;
            for (i = 0; i < 4; i++) {
                if (splatters[i][#"blur amount"] > blur) {
                    blur = splatters[i][#"blur amount"];
                }
                if (splatters[i][#"opacity"] > opacity) {
                    opacity = splatters[i][#"opacity"];
                }
            }
            if (opacity > 0 || blur > 0) {
                local_player = function_5c10bd79(localclientnum);
                if (isdefined(local_player)) {
                    splatter.var_9e4cc220 = 1;
                    if (!local_player function_d2cb869e(#"hash_73c750f53749d44d")) {
                        function_a837926b(localclientnum, #"hash_73c750f53749d44d");
                    }
                    if (local_player function_d2cb869e(#"hash_73c750f53749d44d")) {
                        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"blur amount", blur);
                        if (is_true(splatter.shockrifle)) {
                            opacity *= 0.05;
                        }
                        function_4238734d(localclientnum, #"hash_73c750f53749d44d", #"opacity", opacity);
                        function_672c739(localclientnum, splatter.shockrifle);
                    }
                }
            } else if (is_true(splatter.var_9e4cc220)) {
                splatter.var_9e4cc220 = 0;
                if (function_148ccc79(localclientnum, #"hash_73c750f53749d44d")) {
                    codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
                }
            } else {
                break;
            }
            waitframe(1);
        }
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0x9c1278b6, Offset: 0x1710
// Size: 0xaa
function private function_b51756a0(localclientnum, splatter, damage) {
    if (damage > level.blood.var_de10c136.dot.var_6264f8dd) {
        return true;
    }
    if (!isdefined(splatter.var_90495387)) {
        return true;
    }
    if (getservertime(localclientnum) - splatter.var_90495387 < level.blood.var_de10c136.dot.var_372dff4b) {
        return false;
    }
    return true;
}

// Namespace blood/blood
// Params 6, eflags: 0x4
// Checksum 0xf9b7688e, Offset: 0x17c8
// Size: 0x3e4
function private splatter_postfx(localclientnum, player, damage, var_cd141ca2, death, dot) {
    var_97b5c837 = localclientnum + "splatter_postfx" + var_cd141ca2;
    level notify(var_97b5c837);
    level endon(var_97b5c837);
    blur = 0;
    opacity = 0;
    var_587ce5b0 = 0;
    var_49774f1 = 0;
    hold_time = 0;
    splatter = getsplatter(localclientnum);
    if (dot && !death) {
        splatter.var_90495387 = getservertime(localclientnum);
        blur = level.blood.var_de10c136.dot.blur;
        opacity = level.blood.var_de10c136.dot.opacity;
        var_587ce5b0 = level.blood.var_de10c136.dot.var_587ce5b0;
        hold_time = level.blood.var_de10c136.dot.hold_time;
    } else if (function_b51756a0(localclientnum, splatter, damage)) {
        var_de10c136 = level.blood.var_de10c136;
        var_813d0fe9 = level.blood.scriptbundle.var_3e1e9389 - 1;
        for (i = var_de10c136.damage_ranges - 1; i >= 0; i--) {
            if (damage > var_de10c136.range[i].start || death && var_813d0fe9 == i) {
                blur = var_de10c136.range[i].blur;
                opacity = var_de10c136.range[i].opacity;
                var_587ce5b0 = var_de10c136.var_587ce5b0[i];
                var_49774f1 = var_de10c136.var_49774f1[i];
                hold_time = var_de10c136.hold_time[i];
                break;
            }
        }
    }
    if (isdefined(level.var_7db2b064) && [[ level.var_7db2b064 ]](localclientnum, player, damage)) {
        blur = 0;
        opacity = 0;
        var_587ce5b0 = 0;
        var_49774f1 = 0;
        hold_time = 0;
    }
    if (blur == 0) {
        level thread function_23901270(localclientnum, var_587ce5b0, var_cd141ca2, 0, opacity);
        wait float(var_587ce5b0 + hold_time) / 1000;
        level thread function_23901270(localclientnum, var_49774f1, var_cd141ca2, opacity, 0);
        return;
    }
    level thread function_90064049(localclientnum, var_587ce5b0, var_cd141ca2, 0, opacity, 0, blur);
    wait float(var_587ce5b0 + hold_time) / 1000;
    level thread function_90064049(localclientnum, var_49774f1, var_cd141ca2, opacity, 0, blur, 0);
}

// Namespace blood/blood
// Params 5, eflags: 0x0
// Checksum 0x2656a50a, Offset: 0x1bb8
// Size: 0x2e0
function function_23901270(localclientnum, ramptime, var_cd141ca2, var_9f153e5b, var_a3c5be40) {
    var_97b5c837 = localclientnum + "rampSplatterValue" + var_cd141ca2;
    level notify(var_97b5c837);
    level endon(var_97b5c837);
    localplayer = function_5c10bd79(localclientnum);
    if (!isdefined(localplayer)) {
        return;
    }
    starttime = localplayer getclienttime();
    var_d183f050 = getservertime(localclientnum);
    currenttime = starttime;
    elapsedtime = 0;
    var_6dc11453 = getsplatter(localclientnum);
    var_9cdbd967 = &var_6dc11453.splatters[var_cd141ca2];
    var_484d4e48 = var_a3c5be40 > 0 && var_9f153e5b == 0;
    var_e04a3690 = 0;
    while (elapsedtime < ramptime) {
        percent = 1;
        if (ramptime > 0) {
            percent = elapsedtime / ramptime;
        }
        var_a2f77259 = 1 - percent;
        var_3a331087 = var_a3c5be40 * percent + var_9f153e5b * var_a2f77259;
        send_notify = var_484d4e48 && var_3a331087 > 0 && var_9cdbd967[#"opacity"] == 0;
        var_9cdbd967[#"opacity"] = var_3a331087;
        if (send_notify) {
            level notify(#"splatters_active");
            var_e04a3690 = 1;
        }
        waitframe(1);
        localplayer = function_5c10bd79(localclientnum);
        if (!isdefined(localplayer)) {
            return;
        }
        currenttime = localplayer getclienttime();
        var_5710f35c = getservertime(localclientnum);
        if (var_5710f35c < var_d183f050) {
            return;
        }
        elapsedtime = currenttime - starttime;
    }
    var_9cdbd967[#"opacity"] = var_a3c5be40;
    if (var_484d4e48 && !var_e04a3690) {
        level notify(#"splatters_active");
    }
}

// Namespace blood/blood
// Params 7, eflags: 0x0
// Checksum 0xa5852e8c, Offset: 0x1ea0
// Size: 0x378
function function_90064049(localclientnum, ramptime, var_cd141ca2, var_9f153e5b, var_a3c5be40, var_1f06be44, var_b19159d7) {
    var_97b5c837 = localclientnum + "rampSplatterValue" + var_cd141ca2;
    level notify(var_97b5c837);
    level endon(var_97b5c837);
    localplayer = function_5c10bd79(localclientnum);
    if (!isdefined(localplayer)) {
        return;
    }
    starttime = localplayer getclienttime();
    var_d183f050 = getservertime(localclientnum);
    currenttime = starttime;
    elapsedtime = 0;
    var_6dc11453 = getsplatter(localclientnum);
    var_9cdbd967 = var_6dc11453.splatters[var_cd141ca2];
    var_484d4e48 = var_a3c5be40 > 0 && var_9f153e5b == 0 || var_b19159d7 > 0 && var_1f06be44 == 0;
    var_e04a3690 = 0;
    while (elapsedtime < ramptime) {
        percent = 1;
        if (ramptime > 0) {
            percent = elapsedtime / ramptime;
        }
        var_a2f77259 = 1 - percent;
        var_3a331087 = var_a3c5be40 * percent + var_9f153e5b * var_a2f77259;
        var_85322688 = var_b19159d7 * percent + var_1f06be44 * var_a2f77259;
        send_notify = var_484d4e48 && (var_3a331087 > 0 && var_9cdbd967[#"opacity"] == 0 || var_85322688 > 0 && var_9cdbd967[#"blur amount"] == 0);
        var_9cdbd967[#"opacity"] = var_3a331087;
        var_9cdbd967[#"blur amount"] = var_85322688;
        if (send_notify) {
            level notify(#"splatters_active");
            var_e04a3690 = 1;
        }
        waitframe(1);
        localplayer = function_5c10bd79(localclientnum);
        if (!isdefined(localplayer)) {
            return;
        }
        currenttime = localplayer getclienttime();
        var_5710f35c = getservertime(localclientnum);
        if (var_5710f35c < var_d183f050) {
            return;
        }
        elapsedtime = currenttime - starttime;
    }
    var_9cdbd967[#"opacity"] = var_a3c5be40;
    var_9cdbd967[#"blur amount"] = var_b19159d7;
    if (var_484d4e48 && !var_e04a3690) {
        level notify(#"splatters_active");
    }
}

// Namespace blood/blood
// Params 0, eflags: 0x4
// Checksum 0x80c9dabf, Offset: 0x2220
// Size: 0x6a
function private player_base_health() {
    if (isdefined(self.var_ee9b8af0)) {
        return self.var_ee9b8af0;
    }
    if (!self function_700ca4f5()) {
        return 150;
    }
    return self getplayerspawnhealth() + (isdefined(level.var_90bb9821) ? level.var_90bb9821 : 0);
}

// Namespace blood/blood
// Params 0, eflags: 0x4
// Checksum 0x5b4475d6, Offset: 0x2298
// Size: 0x13a
function private function_55d01d42() {
    assert(self function_700ca4f5());
    character_index = self getcharacterbodytype();
    fields = getcharacterfields(character_index, currentsessionmode());
    if (isdefined(fields) && (isdefined(fields.digitalblood) ? fields.digitalblood : 0)) {
        self.pstfx_blood = #"hash_21152915158b09dd";
        self.wound_rob = "rob_wound_blood_splatter_reaper";
        return;
    }
    if (util::is_mature()) {
        self.pstfx_blood = #"hash_263a0659c7ff81ad";
        self.wound_rob = "rob_wound_blood_splatter";
        return;
    }
    self.pstfx_blood = #"hash_44dcb6ac5e8787e0";
    self.wound_rob = "rob_wound_blood_splatter";
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xa75d82f2, Offset: 0x23e0
// Size: 0x346
function private function_87544c4a(localclientnum) {
    self endon(#"death", #"disconnect");
    if (!isdefined(self.blood_enabled)) {
        self.blood_enabled = 0;
    }
    self util::function_6d0694af();
    basehealth = player_base_health();
    priorplayerhealth = renderhealthoverlayhealth(localclientnum, isdefined(self.prop) ? 0 : basehealth);
    var_a234f6c2 = basehealth * priorplayerhealth;
    var_406028bf = var_a234f6c2;
    var_4cdccc55 = util::is_mature();
    self function_55d01d42();
    self thread function_8d8880(localclientnum);
    while (true) {
        forceupdate = 0;
        if (util::is_mature() != var_4cdccc55) {
            forceupdate = 1;
            self function_436ee4c2(localclientnum, #"hash_263a0659c7ff81ad");
            self function_436ee4c2(localclientnum, #"hash_44dcb6ac5e8787e0");
            var_4cdccc55 = util::is_mature();
            self function_55d01d42();
        }
        if (renderhealthoverlay(localclientnum)) {
            profilestart();
            basehealth = player_base_health();
            playerhealth = renderhealthoverlayhealth(localclientnum, isdefined(self.prop) ? 0 : basehealth);
            if (playerhealth != priorplayerhealth) {
                var_406028bf = basehealth * playerhealth;
                if (var_a234f6c2 > var_406028bf) {
                    update_damage_effects(localclientnum, var_a234f6c2 - var_406028bf, playerhealth == 0);
                }
            }
            if (playerhealth < 1) {
                if (!self.blood_enabled) {
                    self function_70299400(localclientnum);
                }
            } else if (self.blood_enabled) {
                self function_436ee4c2(localclientnum, self.pstfx_blood);
            }
            function_9a8dc0ec(localclientnum, var_406028bf, var_a234f6c2, forceupdate);
            if (playerhealth != priorplayerhealth) {
                priorplayerhealth = playerhealth;
                var_a234f6c2 = var_406028bf;
            }
            profilestop();
        } else if (self.blood_enabled) {
            self function_436ee4c2(localclientnum, self.pstfx_blood);
        }
        waitframe(1);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x64ab95f6, Offset: 0x2730
// Size: 0x22a
function private function_8d8880(localclientnum) {
    self endon(#"death", #"disconnect");
    if (!level.blood.var_f5479429) {
        return;
    }
    while (true) {
        waitframe(1);
        if (is_true(self.blood_enabled)) {
            for (pulse = 0; pulse < 2; pulse++) {
                self notify(#"pulse_blood");
                self thread function_c0cdd1f2(localclientnum, 0, 1, level.blood.var_f2de135e.var_562c41de[pulse], #"damage pulse", self.pstfx_blood);
                wait float(level.blood.var_f2de135e.var_562c41de[pulse]) / 1000;
                wait float(level.blood.var_f2de135e.var_18f673f1[pulse]) / 1000;
                self thread function_c0cdd1f2(localclientnum, 1, 0, level.blood.var_f2de135e.var_92fc0d45[pulse], #"damage pulse", self.pstfx_blood);
                wait float(level.blood.var_f2de135e.var_92fc0d45[pulse]) / 1000;
                wait float(level.blood.var_f2de135e.var_5b5500f7[pulse]) / 1000;
            }
        }
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x9e663243, Offset: 0x2968
// Size: 0x44
function private function_493a8fbc(localclientnum) {
    self waittill(#"death");
    self function_436ee4c2(localclientnum, self.pstfx_blood);
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x7cfb7cb6, Offset: 0x29b8
// Size: 0xee
function private function_62b7e00d(localclientnum) {
    if (isdefined(level.blood.soundhandle)) {
        return;
    }
    level.blood.soundhandle = function_604c9983(localclientnum, level.blood.var_d8dc9013);
    waitresult = self waittill(#"death", #"disconnect", #"critical_health_end");
    if (isdefined(level.blood.soundhandle)) {
        function_d48752e(localclientnum, level.blood.soundhandle);
        level.blood.soundhandle = undefined;
    }
}

// Namespace blood/blood
// Params 4, eflags: 0x4
// Checksum 0x53bff686, Offset: 0x2ab0
// Size: 0x1b6
function private function_e91b92e2(localclientnum, new_blood_stage, *prior_blood_stage, playerhealth) {
    if (prior_blood_stage == 4) {
        self.var_9861062 = 1;
        self enter_critical_health(new_blood_stage);
        if (is_true(self.blood_enabled)) {
            self function_116b95e5(self.pstfx_blood, #"damage pulse", 1);
        }
        if (playerhealth > 0) {
            playsound(new_blood_stage, level.blood.var_8691ed16, (0, 0, 0));
            self thread function_62b7e00d(new_blood_stage);
        }
    } else if (self.var_9861062) {
        if (isdefined(level.blood.soundhandle)) {
            if (playerhealth > 0) {
                playsound(new_blood_stage, level.blood.var_dad052de, (0, 0, 0));
            }
        }
        self.var_9861062 = 0;
        if (is_true(self.blood_enabled)) {
            self function_116b95e5(self.pstfx_blood, #"damage pulse", 0);
        }
    }
    if (prior_blood_stage < 4) {
        self notify(#"critical_health_end");
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xa14b61d2, Offset: 0x2c70
// Size: 0xcc
function private function_56419db8(stage) {
    var_f2de135e = level.blood.var_f2de135e;
    for (pulse = 0; pulse < 2; pulse++) {
        var_f2de135e.var_562c41de[pulse] = var_f2de135e.time_in[pulse][stage];
        var_f2de135e.var_18f673f1[pulse] = var_f2de135e.var_a79aba98[pulse][stage];
        var_f2de135e.var_92fc0d45[pulse] = var_f2de135e.time_out[pulse][stage];
        var_f2de135e.var_5b5500f7[pulse] = var_f2de135e.var_97aa6fd2[pulse][stage];
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0xa1b51dfb, Offset: 0x2d48
// Size: 0x7c
function private play_new_stage_rumble(localclientnum) {
    self endon(#"death", #"disconnect");
    for (i = 0; i < 2; i++) {
        self playrumbleonentity(localclientnum, "new_health_stage");
        wait 0.4;
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0x1151cea2, Offset: 0x2dd0
// Size: 0x44
function private function_5a719e5(localclientnum, new_blood_stage, prior_blood_stage) {
    if (new_blood_stage > 0) {
        if (new_blood_stage > prior_blood_stage) {
            self thread play_new_stage_rumble(localclientnum);
        }
    }
}

// Namespace blood/blood
// Params 3, eflags: 0x4
// Checksum 0xe53411dc, Offset: 0x2e20
// Size: 0x1bc
function private update_lightbar(localclientnum, new_blood_stage, prior_blood_stage) {
    if (new_blood_stage > 0) {
        switch (new_blood_stage) {
        case 1:
            setcontrollerlightbarcolorpulsing(localclientnum, (1, 1, 0), 2400);
            break;
        case 2:
            setcontrollerlightbarcolorpulsing(localclientnum, (1, 0.66, 0), 1800);
            break;
        case 3:
            setcontrollerlightbarcolorpulsing(localclientnum, (1, 0.33, 0), 1200);
            break;
        case 4:
            setcontrollerlightbarcolorpulsing(localclientnum, (1, 0, 0), 600);
            break;
        default:
            setcontrollerlightbarcolor(localclientnum);
            break;
        }
        return;
    }
    if (new_blood_stage != prior_blood_stage) {
        if (isdefined(level.controllercolor) && isdefined(level.controllercolor[localclientnum])) {
            setcontrollerlightbarcolor(localclientnum, level.controllercolor[localclientnum]);
            return;
        }
        setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace blood/blood
// Params 4, eflags: 0x4
// Checksum 0x6825dfc4, Offset: 0x2fe8
// Size: 0x27a
function private function_9a8dc0ec(localclientnum, playerhealth, priorplayerhealth, forceupdate) {
    if (!isdefined(self.last_blood_stage)) {
        self.last_blood_stage = 0;
    }
    prior_blood_stage = self.last_blood_stage;
    new_blood_stage = 0;
    if (!is_true(self.nobloodoverlay)) {
        if (playerhealth > 0) {
            if (playerhealth == priorplayerhealth) {
                new_blood_stage = prior_blood_stage;
            } else if (playerhealth <= level.blood.threshold[1]) {
                if (playerhealth <= level.blood.threshold[3]) {
                    new_blood_stage = playerhealth <= level.blood.threshold[4] ? 4 : 3;
                } else {
                    new_blood_stage = playerhealth <= level.blood.threshold[2] ? 2 : 1;
                }
            }
        }
    }
    self update_lightbar(localclientnum, new_blood_stage, prior_blood_stage);
    if (new_blood_stage != prior_blood_stage || forceupdate) {
        ramptime = prior_blood_stage < new_blood_stage ? level.blood.var_587ce5b0 : level.blood.var_49774f1;
        self thread function_8fe966f4(localclientnum, prior_blood_stage, new_blood_stage, ramptime, self.pstfx_blood);
        if (is_true(self.blood_enabled)) {
            self function_116b95e5(self.pstfx_blood, #"hash_3886e6a5c0c3df4c", level.blood.blood_boost[new_blood_stage]);
        }
        self function_56419db8(new_blood_stage);
        self function_5a719e5(localclientnum, new_blood_stage, prior_blood_stage);
        self function_e91b92e2(localclientnum, new_blood_stage, prior_blood_stage, playerhealth);
    }
    self.last_blood_stage = new_blood_stage;
}

// Namespace blood/blood
// Params 5, eflags: 0x0
// Checksum 0x957566, Offset: 0x3270
// Size: 0x684
function function_8fe966f4(localclientnum, var_bfd952c7, new_stage, ramptime, postfx) {
    self endon(#"death", #"hash_6d50f64fe99aed76");
    self notify(#"hash_224e2e71d8e6add3");
    self endon(#"hash_224e2e71d8e6add3");
    localplayer = function_5c10bd79(localclientnum);
    if (!isdefined(localplayer)) {
        return;
    }
    starttime = localplayer getclienttime();
    var_d183f050 = getservertime(localclientnum);
    var_e9d8aaf5 = level.blood.var_e9d8aaf5;
    var_5831bf35 = level.blood.var_5831bf35;
    currenttime = starttime;
    for (elapsedtime = 0; elapsedtime < ramptime; elapsedtime = currenttime - starttime) {
        var_a0b59ea2 = elapsedtime / ramptime;
        var_3198c720 = 1 - var_a0b59ea2;
        if (is_true(self.blood_enabled)) {
            self function_116b95e5(postfx, #"fade", level.blood.fade[var_bfd952c7] * var_3198c720 + level.blood.fade[new_stage] * var_a0b59ea2);
            self function_116b95e5(postfx, #"opacity", level.blood.opacity[var_bfd952c7] * var_3198c720 + level.blood.opacity[new_stage] * var_a0b59ea2);
            self function_116b95e5(postfx, #"vignette darkening amount", level.blood.var_4c8629ad[var_bfd952c7] * var_3198c720 + level.blood.var_4c8629ad[new_stage] * var_a0b59ea2);
            self function_116b95e5(postfx, #"vignette darkening factor", level.blood.var_ea220db3[var_bfd952c7] * var_3198c720 + level.blood.var_ea220db3[new_stage] * var_a0b59ea2);
            self function_116b95e5(postfx, #"blur", level.blood.blur[var_bfd952c7] * var_3198c720 + level.blood.blur[new_stage] * var_a0b59ea2);
            if (var_e9d8aaf5) {
                self function_116b95e5(postfx, #"refraction", level.blood.refraction[var_bfd952c7] * var_3198c720 + level.blood.refraction[new_stage] * var_a0b59ea2);
            }
            if (var_5831bf35) {
                self function_116b95e5(postfx, #"desaturation", level.blood.desaturation[var_bfd952c7] * var_3198c720 + level.blood.desaturation[new_stage] * var_a0b59ea2);
            }
        }
        waitframe(1);
        localplayer = function_5c10bd79(localclientnum);
        if (!isdefined(localplayer)) {
            return;
        }
        currenttime = localplayer getclienttime();
        var_5710f35c = getservertime(localclientnum);
        if (var_5710f35c < var_d183f050) {
            return;
        }
    }
    if (is_true(self.blood_enabled)) {
        self function_116b95e5(postfx, #"fade", level.blood.fade[new_stage]);
        self function_116b95e5(postfx, #"opacity", level.blood.opacity[new_stage]);
        self function_116b95e5(postfx, #"vignette darkening amount", level.blood.var_4c8629ad[new_stage]);
        self function_116b95e5(postfx, #"vignette darkening factor", level.blood.var_ea220db3[new_stage]);
        self function_116b95e5(postfx, #"blur", level.blood.blur[new_stage]);
        if (var_e9d8aaf5) {
            self function_116b95e5(postfx, #"refraction", level.blood.refraction[new_stage]);
        }
        if (var_5831bf35) {
            self function_116b95e5(postfx, #"desaturation", level.blood.desaturation[new_stage]);
        }
    }
}

// Namespace blood/blood
// Params 6, eflags: 0x0
// Checksum 0x45c864b4, Offset: 0x3900
// Size: 0x22c
function function_c0cdd1f2(localclientnum, stagefrom, stageto, ramptime, key, postfx) {
    self endon(#"death", #"hash_6d50f64fe99aed76");
    var_97b5c837 = "rampPostFx" + key + postfx;
    self notify(var_97b5c837);
    self endon(var_97b5c837);
    localplayer = function_5c10bd79(localclientnum);
    if (!isdefined(localplayer)) {
        return;
    }
    starttime = localplayer getclienttime();
    var_d183f050 = getservertime(localclientnum);
    currenttime = starttime;
    for (elapsedtime = 0; elapsedtime < ramptime; elapsedtime = currenttime - starttime) {
        percent = elapsedtime / ramptime;
        amount = stageto * percent + stagefrom * (1 - percent);
        if (is_true(self.blood_enabled)) {
            self function_116b95e5(postfx, key, amount);
        }
        waitframe(1);
        localplayer = function_5c10bd79(localclientnum);
        if (!isdefined(localplayer)) {
            return;
        }
        currenttime = localplayer getclienttime();
        var_5710f35c = getservertime(localclientnum);
        if (var_5710f35c < var_d183f050) {
            return;
        }
    }
    if (is_true(self.blood_enabled)) {
        self function_116b95e5(postfx, key, stageto);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x225d1c71, Offset: 0x3b38
// Size: 0x74
function private function_70299400(*localclientnum) {
    if (level.var_4ecf5754 === #"silent_film") {
        return;
    }
    self.blood_enabled = 1;
    if (!self function_d2cb869e(self.pstfx_blood)) {
        self codeplaypostfxbundle(self.pstfx_blood);
    }
}

// Namespace blood/blood
// Params 2, eflags: 0x4
// Checksum 0xcd4c80a6, Offset: 0x3bb8
// Size: 0x18c
function private function_436ee4c2(localclientnum, pstfx_blood) {
    self notify(#"hash_6d50f64fe99aed76");
    if (isdefined(self)) {
        if (self function_d2cb869e(pstfx_blood)) {
            self codestoppostfxbundle(pstfx_blood);
        }
        if (self function_d2cb869e(#"hash_73c750f53749d44d")) {
            self codestoppostfxbundle(#"hash_73c750f53749d44d");
        }
        self.blood_enabled = 0;
    } else {
        if (function_148ccc79(localclientnum, pstfx_blood)) {
            codestoppostfxbundlelocal(localclientnum, pstfx_blood);
        }
        if (function_148ccc79(localclientnum, #"hash_73c750f53749d44d")) {
            codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
        }
    }
    if (!isdefined(self)) {
        if (isdefined(level.controllercolor) && isdefined(level.controllercolor[localclientnum])) {
            setcontrollerlightbarcolor(localclientnum, level.controllercolor[localclientnum]);
            return;
        }
        setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x2e253c36, Offset: 0x3d50
// Size: 0x1b46
function private function_dd830dee(var_3942c692) {
    level.blood = spawnstruct();
    if (isdefined(var_3942c692)) {
        level.blood.scriptbundle = getscriptbundle(var_3942c692);
    } else if (sessionmodeiswarzonegame()) {
        level.blood.scriptbundle = getscriptbundle("wz_blood_settings");
    } else {
        level.blood.scriptbundle = getgametypesetting(#"hardcoremode") ? getscriptbundle("hardcore_blood_settings") : getscriptbundle("blood_settings");
    }
    assert(isdefined(level.blood.scriptbundle));
    if (!isdefined(level.blood.var_e9d8aaf5)) {
        level.blood.var_e9d8aaf5 = isdefined(level.blood.scriptbundle.var_e9d8aaf5) ? level.blood.scriptbundle.var_e9d8aaf5 : 0;
    }
    level.blood.refraction = [];
    if (!isdefined(level.blood.refraction[0])) {
        level.blood.refraction[0] = isdefined(level.blood.scriptbundle.var_9e65e691) ? level.blood.scriptbundle.var_9e65e691 : 0;
    }
    if (!isdefined(level.blood.refraction[1])) {
        level.blood.refraction[1] = isdefined(level.blood.scriptbundle.var_49ddbdf6) ? level.blood.scriptbundle.var_49ddbdf6 : 0;
    }
    if (!isdefined(level.blood.refraction[2])) {
        level.blood.refraction[2] = isdefined(level.blood.scriptbundle.var_83022fca) ? level.blood.scriptbundle.var_83022fca : 0;
    }
    if (!isdefined(level.blood.refraction[3])) {
        level.blood.refraction[3] = isdefined(level.blood.scriptbundle.var_90b9cb39) ? level.blood.scriptbundle.var_90b9cb39 : 0;
    }
    if (!isdefined(level.blood.refraction[4])) {
        level.blood.refraction[4] = isdefined(level.blood.scriptbundle.var_e790f8e6) ? level.blood.scriptbundle.var_e790f8e6 : 0;
    }
    if (!isdefined(level.blood.var_5831bf35)) {
        level.blood.var_5831bf35 = isdefined(level.blood.scriptbundle.var_5831bf35) ? level.blood.scriptbundle.var_5831bf35 : 0;
    }
    level.blood.desaturation = [];
    if (!isdefined(level.blood.desaturation[0])) {
        level.blood.desaturation[0] = isdefined(level.blood.scriptbundle.var_39a52851) ? level.blood.scriptbundle.var_39a52851 : 0;
    }
    if (!isdefined(level.blood.desaturation[1])) {
        level.blood.desaturation[1] = isdefined(level.blood.scriptbundle.var_53df5cdd) ? level.blood.scriptbundle.var_53df5cdd : 0;
    }
    if (!isdefined(level.blood.desaturation[2])) {
        level.blood.desaturation[2] = isdefined(level.blood.scriptbundle.var_56136145) ? level.blood.scriptbundle.var_56136145 : 0;
    }
    if (!isdefined(level.blood.desaturation[3])) {
        level.blood.desaturation[3] = isdefined(level.blood.scriptbundle.var_285085c0) ? level.blood.scriptbundle.var_285085c0 : 0;
    }
    if (!isdefined(level.blood.desaturation[4])) {
        level.blood.desaturation[4] = isdefined(level.blood.scriptbundle.var_3c8fae3e) ? level.blood.scriptbundle.var_3c8fae3e : 0;
    }
    level.blood.blood_boost = [];
    if (!isdefined(level.blood.blood_boost[0])) {
        level.blood.blood_boost[0] = isdefined(level.blood.scriptbundle.var_fd86eebc) ? level.blood.scriptbundle.var_fd86eebc : 0;
    }
    if (!isdefined(level.blood.blood_boost[1])) {
        level.blood.blood_boost[1] = isdefined(level.blood.scriptbundle.var_e741c232) ? level.blood.scriptbundle.var_e741c232 : 0;
    }
    if (!isdefined(level.blood.blood_boost[2])) {
        level.blood.blood_boost[2] = isdefined(level.blood.scriptbundle.var_e11b35e5) ? level.blood.scriptbundle.var_e11b35e5 : 0;
    }
    if (!isdefined(level.blood.blood_boost[3])) {
        level.blood.blood_boost[3] = isdefined(level.blood.scriptbundle.var_cadf096d) ? level.blood.scriptbundle.var_cadf096d : 0;
    }
    if (!isdefined(level.blood.blood_boost[4])) {
        level.blood.blood_boost[4] = isdefined(level.blood.scriptbundle.var_c3ad7b0a) ? level.blood.scriptbundle.var_c3ad7b0a : 0;
    }
    level.blood.blur = [];
    if (!isdefined(level.blood.blur[0])) {
        level.blood.blur[0] = isdefined(level.blood.scriptbundle.var_d4e546df) ? level.blood.scriptbundle.var_d4e546df : 0;
    }
    if (!isdefined(level.blood.blur[1])) {
        level.blood.blur[1] = isdefined(level.blood.scriptbundle.var_e6a76a63) ? level.blood.scriptbundle.var_e6a76a63 : 0;
    }
    if (!isdefined(level.blood.blur[2])) {
        level.blood.blur[2] = isdefined(level.blood.scriptbundle.var_b9320f69) ? level.blood.scriptbundle.var_b9320f69 : 0;
    }
    if (!isdefined(level.blood.blur[3])) {
        level.blood.blur[3] = isdefined(level.blood.scriptbundle.var_9af9d2f9) ? level.blood.scriptbundle.var_9af9d2f9 : 0;
    }
    if (!isdefined(level.blood.blur[4])) {
        level.blood.blur[4] = isdefined(level.blood.scriptbundle.var_acaf7664) ? level.blood.scriptbundle.var_acaf7664 : 0;
    }
    level.blood.opacity = [];
    if (!isdefined(level.blood.opacity[0])) {
        level.blood.opacity[0] = isdefined(level.blood.scriptbundle.var_a05e6a18) ? level.blood.scriptbundle.var_a05e6a18 : 0;
    }
    if (!isdefined(level.blood.opacity[1])) {
        level.blood.opacity[1] = isdefined(level.blood.scriptbundle.var_920ccd75) ? level.blood.scriptbundle.var_920ccd75 : 0;
    }
    if (!isdefined(level.blood.opacity[2])) {
        level.blood.opacity[2] = isdefined(level.blood.scriptbundle.var_54f2533d) ? level.blood.scriptbundle.var_54f2533d : 0;
    }
    if (!isdefined(level.blood.opacity[3])) {
        level.blood.opacity[3] = isdefined(level.blood.scriptbundle.var_467fb658) ? level.blood.scriptbundle.var_467fb658 : 0;
    }
    if (!isdefined(level.blood.opacity[4])) {
        level.blood.opacity[4] = isdefined(level.blood.scriptbundle.var_ed5b8411) ? level.blood.scriptbundle.var_ed5b8411 : 0;
    }
    level.blood.threshold = [];
    if (!isdefined(level.blood.threshold[0])) {
        level.blood.threshold[0] = isdefined(level.blood.scriptbundle.var_4e06fd93) ? level.blood.scriptbundle.var_4e06fd93 : 0;
    }
    if (!isdefined(level.blood.threshold[1])) {
        level.blood.threshold[1] = isdefined(level.blood.scriptbundle.var_3bc4590e) ? level.blood.scriptbundle.var_3bc4590e : 0;
    }
    if (!isdefined(level.blood.threshold[2])) {
        level.blood.threshold[2] = isdefined(level.blood.scriptbundle.var_bc1cd9c5) ? level.blood.scriptbundle.var_bc1cd9c5 : 0;
    }
    if (!isdefined(level.blood.threshold[3])) {
        level.blood.threshold[3] = isdefined(level.blood.scriptbundle.var_91558437) ? level.blood.scriptbundle.var_91558437 : 0;
    }
    if (!isdefined(level.blood.threshold[4])) {
        level.blood.threshold[4] = isdefined(level.blood.scriptbundle.var_7f6fe064) ? level.blood.scriptbundle.var_7f6fe064 : 0;
    }
    level.blood.fade = [];
    if (!isdefined(level.blood.fade[0])) {
        level.blood.fade[0] = isdefined(level.blood.scriptbundle.var_5eab69fa) ? level.blood.scriptbundle.var_5eab69fa : 0;
    }
    if (!isdefined(level.blood.fade[1])) {
        level.blood.fade[1] = isdefined(level.blood.scriptbundle.var_83dbb45a) ? level.blood.scriptbundle.var_83dbb45a : 0;
    }
    if (!isdefined(level.blood.fade[2])) {
        level.blood.fade[2] = isdefined(level.blood.scriptbundle.var_720a10b7) ? level.blood.scriptbundle.var_720a10b7 : 0;
    }
    if (!isdefined(level.blood.fade[3])) {
        level.blood.fade[3] = isdefined(level.blood.scriptbundle.var_f1f39088) ? level.blood.scriptbundle.var_f1f39088 : 0;
    }
    if (!isdefined(level.blood.fade[4])) {
        level.blood.fade[4] = isdefined(level.blood.scriptbundle.var_2945ff2c) ? level.blood.scriptbundle.var_2945ff2c : 0;
    }
    level.blood.var_4c8629ad = [];
    if (!isdefined(level.blood.var_4c8629ad[0])) {
        level.blood.var_4c8629ad[0] = isdefined(level.blood.scriptbundle.var_43305756) ? level.blood.scriptbundle.var_43305756 : 0;
    }
    if (!isdefined(level.blood.var_4c8629ad[1])) {
        level.blood.var_4c8629ad[1] = isdefined(level.blood.scriptbundle.var_517af3eb) ? level.blood.scriptbundle.var_517af3eb : 0;
    }
    if (!isdefined(level.blood.var_4c8629ad[2])) {
        level.blood.var_4c8629ad[2] = isdefined(level.blood.scriptbundle.var_6ec52e7f) ? level.blood.scriptbundle.var_6ec52e7f : 0;
    }
    if (!isdefined(level.blood.var_4c8629ad[3])) {
        level.blood.var_4c8629ad[3] = isdefined(level.blood.scriptbundle.var_7cfacaea) ? level.blood.scriptbundle.var_7cfacaea : 0;
    }
    if (!isdefined(level.blood.var_4c8629ad[4])) {
        level.blood.var_4c8629ad[4] = isdefined(level.blood.scriptbundle.var_fd0b4b01) ? level.blood.scriptbundle.var_fd0b4b01 : 0;
    }
    level.blood.var_ea220db3 = [];
    if (!isdefined(level.blood.var_ea220db3[0])) {
        level.blood.var_ea220db3[0] = isdefined(level.blood.scriptbundle.var_79c59717) ? level.blood.scriptbundle.var_79c59717 : 0;
    }
    if (!isdefined(level.blood.var_ea220db3[1])) {
        level.blood.var_ea220db3[1] = isdefined(level.blood.scriptbundle.var_a403eb93) ? level.blood.scriptbundle.var_a403eb93 : 0;
    }
    if (!isdefined(level.blood.var_ea220db3[2])) {
        level.blood.var_ea220db3[2] = isdefined(level.blood.scriptbundle.var_95514e2e) ? level.blood.scriptbundle.var_95514e2e : 0;
    }
    if (!isdefined(level.blood.var_ea220db3[3])) {
        level.blood.var_ea220db3[3] = isdefined(level.blood.scriptbundle.var_bf94a2b4) ? level.blood.scriptbundle.var_bf94a2b4 : 0;
    }
    if (!isdefined(level.blood.var_ea220db3[4])) {
        level.blood.var_ea220db3[4] = isdefined(level.blood.scriptbundle.var_3fe4235d) ? level.blood.scriptbundle.var_3fe4235d : 0;
    }
    function_f50652a9();
    function_b0e51f43();
    level.blood.rob = spawnstruct();
    if (!isdefined(level.blood.rob.stage)) {
        level.blood.rob.stage = isdefined(level.blood.scriptbundle.rob_stage) ? level.blood.scriptbundle.rob_stage : 0;
    }
    if (!isdefined(level.blood.rob.hold_time)) {
        level.blood.rob.hold_time = isdefined(level.blood.scriptbundle.var_ae06158b) ? level.blood.scriptbundle.var_ae06158b : 0;
    }
    if (!isdefined(level.blood.rob.fade_time)) {
        level.blood.rob.fade_time = isdefined(level.blood.scriptbundle.var_356550c9) ? level.blood.scriptbundle.var_356550c9 : 0;
    }
    if (!isdefined(level.blood.rob.damage_threshold)) {
        level.blood.rob.damage_threshold = isdefined(level.blood.scriptbundle.var_8635c7a1) ? level.blood.scriptbundle.var_8635c7a1 : 0;
    }
    if (!isdefined(level.blood.var_f5479429)) {
        level.blood.var_f5479429 = isdefined(level.blood.scriptbundle.var_f5479429) ? level.blood.scriptbundle.var_f5479429 : 0;
    }
    level.blood.var_587ce5b0 = level.blood.scriptbundle.var_587ce5b0;
    level.blood.var_49774f1 = level.blood.scriptbundle.var_49774f1;
    if (!isdefined(level.blood.var_f5479429)) {
        level.blood.var_f5479429 = isdefined(level.blood.scriptbundle.var_f5479429) ? level.blood.scriptbundle.var_f5479429 : 0;
    }
    if (!isdefined(level.blood.var_8691ed16)) {
        level.blood.var_8691ed16 = isdefined(level.blood.scriptbundle.var_8691ed16) ? level.blood.scriptbundle.var_8691ed16 : "";
    }
    if (!isdefined(level.blood.var_d8dc9013)) {
        level.blood.var_d8dc9013 = isdefined(level.blood.scriptbundle.var_d8dc9013) ? level.blood.scriptbundle.var_d8dc9013 : "";
    }
    if (!isdefined(level.blood.var_dad052de)) {
        level.blood.var_dad052de = isdefined(level.blood.scriptbundle.var_dad052de) ? level.blood.scriptbundle.var_dad052de : "";
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x7104e191, Offset: 0x58a0
// Size: 0x6a
function private function_6deee27e(localclientnum) {
    level notify(localclientnum + "splatter_postfx");
    var_97b5c837 = localclientnum + "rampSplatterValue";
    for (i = 0; i < 4; i++) {
        level notify(var_97b5c837 + i);
    }
}

// Namespace blood/blood
// Params 1, eflags: 0x4
// Checksum 0x3a4887b5, Offset: 0x5918
// Size: 0x132
function private function_162fe6ec(localclientnum) {
    splatter = getsplatter(localclientnum);
    if (!isdefined(splatter)) {
        splatter = spawnstruct();
        splatter.splatters = [];
        level.blood.var_de10c136.var_51036e02 = [];
        level.blood.var_de10c136.var_51036e02[localclientnum] = splatter;
    }
    for (j = 0; j < 4; j++) {
        if (!isdefined(splatter.splatters[j])) {
            splatter.splatters[j] = [];
        }
        splatter.splatters[j][#"blur amount"] = 0;
        splatter.splatters[j][#"opacity"] = 0;
    }
    splatter.var_120a7b2c = 0;
    splatter.var_90495387 = undefined;
}

// Namespace blood/blood
// Params 0, eflags: 0x4
// Checksum 0x94cfe4d6, Offset: 0x5a58
// Size: 0xb5a
function private function_b0e51f43() {
    level.blood.var_de10c136 = spawnstruct();
    level.blood.var_de10c136.localclients = [];
    for (i = 0; i < getmaxlocalclients(); i++) {
        function_162fe6ec(i);
    }
    if (!isdefined(level.blood.var_de10c136.enabled)) {
        level.blood.var_de10c136.enabled = isdefined(level.blood.scriptbundle.var_f70c3e8d) ? level.blood.scriptbundle.var_f70c3e8d : 0;
    }
    if (!isdefined(level.blood.var_de10c136.damage_ranges)) {
        level.blood.var_de10c136.damage_ranges = isdefined(level.blood.scriptbundle.damage_ranges) ? level.blood.scriptbundle.damage_ranges : 1;
    }
    if (!isdefined(level.blood.var_de10c136.var_3e1e9389)) {
        level.blood.var_de10c136.var_3e1e9389 = isdefined(level.blood.scriptbundle.var_3e1e9389) ? level.blood.scriptbundle.var_3e1e9389 : 1;
    }
    level.blood.var_de10c136.range = [];
    level.blood.var_de10c136.var_587ce5b0 = [];
    level.blood.var_de10c136.var_49774f1 = [];
    level.blood.var_de10c136.hold_time = [];
    for (i = 0; i < level.blood.var_de10c136.damage_ranges; i++) {
        level.blood.var_de10c136.range[i] = spawnstruct();
        if (i > 0) {
            if (!isdefined(level.blood.var_de10c136.range[i].start)) {
                level.blood.var_de10c136.range[i].start = isdefined(level.blood.scriptbundle.("damage_range_start_" + i)) ? level.blood.scriptbundle.("damage_range_start_" + i) : level.blood.var_de10c136.range[i - 1].start;
            }
        } else if (!isdefined(level.blood.var_de10c136.range[i].start)) {
            level.blood.var_de10c136.range[i].start = isdefined(level.blood.scriptbundle.("damage_range_start_" + i)) ? level.blood.scriptbundle.("damage_range_start_" + i) : 0;
        }
        if (!isdefined(level.blood.var_de10c136.range[i].blur)) {
            level.blood.var_de10c136.range[i].blur = isdefined(level.blood.scriptbundle.("damage_range_blur_" + i)) ? level.blood.scriptbundle.("damage_range_blur_" + i) : 0;
        }
        if (!isdefined(level.blood.var_de10c136.range[i].opacity)) {
            level.blood.var_de10c136.range[i].opacity = isdefined(level.blood.scriptbundle.("damage_range_opacity_" + i)) ? level.blood.scriptbundle.("damage_range_opacity_" + i) : 0;
        }
        if (!isdefined(level.blood.var_de10c136.var_587ce5b0[i])) {
            level.blood.var_de10c136.var_587ce5b0[i] = isdefined(level.blood.scriptbundle.("hit_flash_ramp_in_time_" + i)) ? level.blood.scriptbundle.("hit_flash_ramp_in_time_" + i) : 0;
        }
        if (!isdefined(level.blood.var_de10c136.var_49774f1[i])) {
            level.blood.var_de10c136.var_49774f1[i] = isdefined(level.blood.scriptbundle.("hit_flash_ramp_out_time_" + i)) ? level.blood.scriptbundle.("hit_flash_ramp_out_time_" + i) : 0;
        }
        if (!isdefined(level.blood.var_de10c136.hold_time[i])) {
            level.blood.var_de10c136.hold_time[i] = isdefined(level.blood.scriptbundle.("hit_flash_hold_time_" + i)) ? level.blood.scriptbundle.("hit_flash_hold_time_" + i) : 0;
        }
    }
    level.blood.var_de10c136.dot = spawnstruct();
    if (!isdefined(level.blood.var_de10c136.dot.blur)) {
        level.blood.var_de10c136.dot.blur = isdefined(level.blood.scriptbundle.("dot_blur")) ? level.blood.scriptbundle.("dot_blur") : 0;
    }
    if (!isdefined(level.blood.var_de10c136.dot.opacity)) {
        level.blood.var_de10c136.dot.opacity = isdefined(level.blood.scriptbundle.("dot_opacity")) ? level.blood.scriptbundle.("dot_opacity") : 0;
    }
    if (!isdefined(level.blood.var_de10c136.dot.var_587ce5b0)) {
        level.blood.var_de10c136.dot.var_587ce5b0 = isdefined(level.blood.scriptbundle.("dot_hit_flash_ramp_in_time")) ? level.blood.scriptbundle.("dot_hit_flash_ramp_in_time") : 0;
    }
    if (!isdefined(level.blood.var_de10c136.dot.var_49774f1)) {
        level.blood.var_de10c136.dot.var_49774f1 = isdefined(level.blood.scriptbundle.("dot_hit_flash_ramp_out_time")) ? level.blood.scriptbundle.("dot_hit_flash_ramp_out_time") : 0;
    }
    if (!isdefined(level.blood.var_de10c136.dot.hold_time)) {
        level.blood.var_de10c136.dot.hold_time = isdefined(level.blood.scriptbundle.("dot_hit_flash_hold_time")) ? level.blood.scriptbundle.("dot_hit_flash_hold_time") : 0;
    }
    if (!isdefined(level.blood.var_de10c136.dot.var_6264f8dd)) {
        level.blood.var_de10c136.dot.var_6264f8dd = isdefined(level.blood.scriptbundle.("dot_ignore_damage_threshold")) ? level.blood.scriptbundle.("dot_ignore_damage_threshold") : 0;
    }
    if (!isdefined(level.blood.var_de10c136.dot.var_372dff4b)) {
        level.blood.var_de10c136.dot.var_372dff4b = isdefined(level.blood.scriptbundle.("dot_ignore_damage_time")) ? level.blood.scriptbundle.("dot_ignore_damage_time") : 0;
    }
}

// Namespace blood/blood
// Params 0, eflags: 0x4
// Checksum 0x4564fd83, Offset: 0x65c0
// Size: 0x1b30
function private function_f50652a9() {
    level.blood.var_f2de135e = spawnstruct();
    level.blood.var_f2de135e.time_in = [];
    level.blood.var_f2de135e.var_a79aba98 = [];
    level.blood.var_f2de135e.time_out = [];
    level.blood.var_f2de135e.var_97aa6fd2 = [];
    level.blood.var_f2de135e.var_562c41de = [];
    level.blood.var_f2de135e.var_18f673f1 = [];
    level.blood.var_f2de135e.var_92fc0d45 = [];
    level.blood.var_f2de135e.var_5b5500f7 = [];
    level.blood.var_f2de135e.time_in[0] = [];
    if (!isdefined(level.blood.var_f2de135e.time_in[0][0])) {
        level.blood.var_f2de135e.time_in[0][0] = isdefined(level.blood.scriptbundle.var_b3272558) ? level.blood.scriptbundle.var_b3272558 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_in[0][1])) {
        level.blood.var_f2de135e.time_in[0][1] = isdefined(level.blood.scriptbundle.var_d014df1f) ? level.blood.scriptbundle.var_d014df1f : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_in[0][2])) {
        level.blood.var_f2de135e.time_in[0][2] = isdefined(level.blood.scriptbundle.var_bdca3a8a) ? level.blood.scriptbundle.var_bdca3a8a : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_in[0][3])) {
        level.blood.var_f2de135e.time_in[0][3] = isdefined(level.blood.scriptbundle.var_ab891608) ? level.blood.scriptbundle.var_ab891608 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_in[0][4])) {
        level.blood.var_f2de135e.time_in[0][4] = isdefined(level.blood.scriptbundle.var_996371bd) ? level.blood.scriptbundle.var_996371bd : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_562c41de[0])) {
        level.blood.var_f2de135e.var_562c41de[0] = level.blood.var_f2de135e.time_in[0][0];
    }
    level.blood.var_f2de135e.time_in[1] = [];
    if (!isdefined(level.blood.var_f2de135e.time_in[1][0])) {
        level.blood.var_f2de135e.time_in[1][0] = isdefined(level.blood.scriptbundle.var_8623b2d2) ? level.blood.scriptbundle.var_8623b2d2 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_in[1][1])) {
        level.blood.var_f2de135e.time_in[1][1] = isdefined(level.blood.scriptbundle.var_7862174f) ? level.blood.scriptbundle.var_7862174f : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_in[1][2])) {
        level.blood.var_f2de135e.time_in[1][2] = isdefined(level.blood.scriptbundle.var_d2b4cbf3) ? level.blood.scriptbundle.var_d2b4cbf3 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_in[1][3])) {
        level.blood.var_f2de135e.time_in[1][3] = isdefined(level.blood.scriptbundle.var_bcf6a077) ? level.blood.scriptbundle.var_bcf6a077 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_in[1][4])) {
        level.blood.var_f2de135e.time_in[1][4] = isdefined(level.blood.scriptbundle.var_af1f04c8) ? level.blood.scriptbundle.var_af1f04c8 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_562c41de[1])) {
        level.blood.var_f2de135e.var_562c41de[1] = level.blood.var_f2de135e.time_in[1][0];
    }
    level.blood.var_f2de135e.var_a79aba98[0] = [];
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[0][0])) {
        level.blood.var_f2de135e.var_a79aba98[0][0] = isdefined(level.blood.scriptbundle.var_a647a17d) ? level.blood.scriptbundle.var_a647a17d : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[0][1])) {
        level.blood.var_f2de135e.var_a79aba98[0][1] = isdefined(level.blood.scriptbundle.var_2fc5ae5) ? level.blood.scriptbundle.var_2fc5ae5 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[0][2])) {
        level.blood.var_f2de135e.var_a79aba98[0][2] = isdefined(level.blood.scriptbundle.var_10be7669) ? level.blood.scriptbundle.var_10be7669 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[0][3])) {
        level.blood.var_f2de135e.var_a79aba98[0][3] = isdefined(level.blood.scriptbundle.var_9147f772) ? level.blood.scriptbundle.var_9147f772 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[0][4])) {
        level.blood.var_f2de135e.var_a79aba98[0][4] = isdefined(level.blood.scriptbundle.var_5f8a13f7) ? level.blood.scriptbundle.var_5f8a13f7 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_18f673f1[0])) {
        level.blood.var_f2de135e.var_18f673f1[0] = level.blood.var_f2de135e.var_a79aba98[0][0];
    }
    level.blood.var_f2de135e.var_a79aba98[1] = [];
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[1][0])) {
        level.blood.var_f2de135e.var_a79aba98[1][0] = isdefined(level.blood.scriptbundle.var_96868f33) ? level.blood.scriptbundle.var_96868f33 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[1][1])) {
        level.blood.var_f2de135e.var_a79aba98[1][1] = isdefined(level.blood.scriptbundle.var_16780f18) ? level.blood.scriptbundle.var_16780f18 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[1][2])) {
        level.blood.var_f2de135e.var_a79aba98[1][2] = isdefined(level.blood.scriptbundle.var_48c373ae) ? level.blood.scriptbundle.var_48c373ae : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[1][3])) {
        level.blood.var_f2de135e.var_a79aba98[1][3] = isdefined(level.blood.scriptbundle.var_38fed425) ? level.blood.scriptbundle.var_38fed425 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_a79aba98[1][4])) {
        level.blood.var_f2de135e.var_a79aba98[1][4] = isdefined(level.blood.scriptbundle.var_6b3d38a1) ? level.blood.scriptbundle.var_6b3d38a1 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_18f673f1[1])) {
        level.blood.var_f2de135e.var_18f673f1[1] = level.blood.var_f2de135e.var_a79aba98[1][0];
    }
    level.blood.var_f2de135e.time_out[0] = [];
    if (!isdefined(level.blood.var_f2de135e.time_out[0][0])) {
        level.blood.var_f2de135e.time_out[0][0] = isdefined(level.blood.scriptbundle.var_54f5763f) ? level.blood.scriptbundle.var_54f5763f : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_out[0][1])) {
        level.blood.var_f2de135e.time_out[0][1] = isdefined(level.blood.scriptbundle.var_7cedbf3) ? level.blood.scriptbundle.var_7cedbf3 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_out[0][2])) {
        level.blood.var_f2de135e.time_out[0][2] = isdefined(level.blood.scriptbundle.var_3959bf08) ? level.blood.scriptbundle.var_3959bf08 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_out[0][3])) {
        level.blood.var_f2de135e.time_out[0][3] = isdefined(level.blood.scriptbundle.var_3e6f492f) ? level.blood.scriptbundle.var_3e6f492f : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_out[0][4])) {
        level.blood.var_f2de135e.time_out[0][4] = isdefined(level.blood.scriptbundle.var_704a2ce8) ? level.blood.scriptbundle.var_704a2ce8 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_92fc0d45[0])) {
        level.blood.var_f2de135e.var_92fc0d45[0] = level.blood.var_f2de135e.time_out[0][0];
    }
    level.blood.var_f2de135e.time_out[1] = [];
    if (!isdefined(level.blood.var_f2de135e.time_out[1][0])) {
        level.blood.var_f2de135e.time_out[1][0] = isdefined(level.blood.scriptbundle.var_50fd2cd8) ? level.blood.scriptbundle.var_50fd2cd8 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_out[1][1])) {
        level.blood.var_f2de135e.time_out[1][1] = isdefined(level.blood.scriptbundle.var_b2c3f064) ? level.blood.scriptbundle.var_b2c3f064 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_out[1][2])) {
        level.blood.var_f2de135e.time_out[1][2] = isdefined(level.blood.scriptbundle.var_855a1591) ? level.blood.scriptbundle.var_855a1591 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_out[1][3])) {
        level.blood.var_f2de135e.time_out[1][3] = isdefined(level.blood.scriptbundle.var_9731393f) ? level.blood.scriptbundle.var_9731393f : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.time_out[1][4])) {
        level.blood.var_f2de135e.time_out[1][4] = isdefined(level.blood.scriptbundle.var_e9dd5e9a) ? level.blood.scriptbundle.var_e9dd5e9a : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_92fc0d45[1])) {
        level.blood.var_f2de135e.var_92fc0d45[1] = level.blood.var_f2de135e.time_out[1][0];
    }
    level.blood.var_f2de135e.var_97aa6fd2[0] = [];
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][0])) {
        level.blood.var_f2de135e.var_97aa6fd2[0][0] = isdefined(level.blood.scriptbundle.var_9e799d8c) ? level.blood.scriptbundle.var_9e799d8c : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][1])) {
        level.blood.var_f2de135e.var_97aa6fd2[0][1] = isdefined(level.blood.scriptbundle.var_8bb8f80b) ? level.blood.scriptbundle.var_8bb8f80b : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][2])) {
        level.blood.var_f2de135e.var_97aa6fd2[0][2] = isdefined(level.blood.scriptbundle.var_7205c4a5) ? level.blood.scriptbundle.var_7205c4a5 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][3])) {
        level.blood.var_f2de135e.var_97aa6fd2[0][3] = isdefined(level.blood.scriptbundle.var_619e23d6) ? level.blood.scriptbundle.var_619e23d6 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][4])) {
        level.blood.var_f2de135e.var_97aa6fd2[0][4] = isdefined(level.blood.scriptbundle.var_56f00e7a) ? level.blood.scriptbundle.var_56f00e7a : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_5b5500f7[0])) {
        level.blood.var_f2de135e.var_5b5500f7[0] = level.blood.var_f2de135e.var_97aa6fd2[0][0];
    }
    level.blood.var_f2de135e.var_97aa6fd2[1] = [];
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][0])) {
        level.blood.var_f2de135e.var_97aa6fd2[1][0] = isdefined(level.blood.scriptbundle.var_ff41f2f5) ? level.blood.scriptbundle.var_ff41f2f5 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][1])) {
        level.blood.var_f2de135e.var_97aa6fd2[1][1] = isdefined(level.blood.scriptbundle.var_f0f35658) ? level.blood.scriptbundle.var_f0f35658 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][2])) {
        level.blood.var_f2de135e.var_97aa6fd2[1][2] = isdefined(level.blood.scriptbundle.var_9cf6ae3c) ? level.blood.scriptbundle.var_9cf6ae3c : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][3])) {
        level.blood.var_f2de135e.var_97aa6fd2[1][3] = isdefined(level.blood.scriptbundle.var_1ca22db5) ? level.blood.scriptbundle.var_1ca22db5 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][4])) {
        level.blood.var_f2de135e.var_97aa6fd2[1][4] = isdefined(level.blood.scriptbundle.var_6530117) ? level.blood.scriptbundle.var_6530117 : 0;
    }
    if (!isdefined(level.blood.var_f2de135e.var_5b5500f7[1])) {
        level.blood.var_f2de135e.var_5b5500f7[1] = level.blood.var_f2de135e.var_97aa6fd2[1][0];
    }
}

