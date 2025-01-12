#using scripts/core_common/ai/systems/weaponlist;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace gameskill;

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x2
// Checksum 0x800beb8b, Offset: 0x470
// Size: 0x14
function autoexec init() {
    level.gameskill = 0;
}

// Namespace gameskill/gameskill_shared
// Params 2, eflags: 0x0
// Checksum 0xe6b53e87, Offset: 0x490
// Size: 0x24c
function setskill(reset, var_4f8d5b23) {
    if (!isdefined(level.script)) {
        level.script = tolower(getdvarstring("mapname"));
    }
    if (!(isdefined(reset) && reset)) {
        if (isdefined(level.var_6108a7cb) && level.var_6108a7cb) {
            return;
        }
        level.var_6a21f752 = &function_79977f70;
        level.var_e88bb559 = &function_79977f70;
        level.var_6c56e098 = &function_79977f70;
        util::set_console_status();
        thread function_610dfe1();
        if (util::coopgame()) {
            thread function_4c34249a();
            thread function_4e14dca9();
            thread function_a3f0621e();
        }
        level.var_6108a7cb = 1;
    }
    var_6dba9ec = getdvarint("ui_singlemission");
    if (var_6dba9ec == 1) {
        var_fd945ffe = getdvarint("ui_singlemission_difficulty");
        if (var_fd945ffe >= 0) {
            var_4f8d5b23 = var_fd945ffe;
        }
    }
    level thread function_2fb240f(var_4f8d5b23);
    if (!isdefined(level.var_878f8b6)) {
        level.var_878f8b6 = 1;
    }
    anim.run_accuracy = 0.5;
    level.var_f5410582 = 1;
    anim.pain_test = &pain_protection;
    set_difficulty_from_locked_settings();
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0x1251652a, Offset: 0x6e8
// Size: 0x11c
function function_40e90163(var_f5d45e8b) {
    level.playerhealth_regularregendelay = function_c127b241();
    level.worthydamageratio = function_1aed2639();
    if (level.var_f5410582) {
        thread function_2a22a275(var_f5d45e8b);
    }
    level.longregentime = function_41990a66();
    anim.var_9d0779eb = function_36a65b50();
    anim.dog_health = function_f4229065();
    anim.var_70acedfa = function_8a1f9500();
    setsaveddvar("ai_accuracyDistScale", 1);
    thread function_93270a2(var_f5d45e8b);
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xedcfbcdf, Offset: 0x810
// Size: 0xaa
function function_2a22a275(var_f5d45e8b) {
    level flag::wait_till("all_players_connected");
    players = level.players;
    for (i = 0; i < players.size; i++) {
        players[i].threatbias = int(function_872f62f0());
    }
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xf51bafe6, Offset: 0x8c8
// Size: 0xc
function function_93270a2(var_f5d45e8b) {
    
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xe37a573d, Offset: 0x8e0
// Size: 0x24
function set_difficulty_from_locked_settings() {
    function_40e90163(&function_829cbbf8);
}

// Namespace gameskill/gameskill_shared
// Params 2, eflags: 0x0
// Checksum 0x4b427f22, Offset: 0x910
// Size: 0x32
function function_829cbbf8(msg, ignored) {
    return level.difficultysettings[msg][level.currentdifficulty];
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x1be32f2a, Offset: 0x950
// Size: 0x6
function always_pain() {
    return false;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xd8adaa70, Offset: 0x960
// Size: 0x4a
function pain_protection() {
    if (!pain_protection_check()) {
        return false;
    }
    return randomint(100) > function_f8ae406c() * 100;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x74d34d98, Offset: 0x9b8
// Size: 0xea
function pain_protection_check() {
    if (!isalive(self.enemy)) {
        return false;
    }
    if (!isplayer(self.enemy)) {
        return false;
    }
    if (!isalive(level.painai) || level.painai.a.script != "pain") {
        level.painai = self;
    }
    if (self == level.painai) {
        return false;
    }
    if (self.damageweapon != level.weaponnone && self.damageweapon.isboltaction) {
        return false;
    }
    return true;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xce2527c2, Offset: 0xab0
// Size: 0xe8
function function_610dfe1() {
    /#
        setdvar("<dev string:x28>", "<dev string:x39>");
        waittillframeend();
        while (true) {
            while (true) {
                if (getdvarstring("<dev string:x28>") != "<dev string:x39>") {
                    break;
                }
                wait 0.5;
            }
            thread function_6227a919();
            while (true) {
                if (getdvarstring("<dev string:x28>") == "<dev string:x39>") {
                    break;
                }
                wait 0.5;
            }
            level notify(#"hash_31415269");
            function_b75a45fc();
        }
    #/
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xdf154f5a, Offset: 0xba0
// Size: 0x70e
function function_6227a919() {
    level notify(#"hash_3871a4a1");
    level endon(#"hash_3871a4a1");
    y = 40;
    level.var_7e842153 = [];
    level.var_fbe7c2fe[0] = "Health";
    level.var_fbe7c2fe[1] = "No Hit Time";
    level.var_fbe7c2fe[2] = "No Die Time";
    if (!isdefined(level.var_76f0070e)) {
        level.var_76f0070e = 0;
    }
    if (!isdefined(level.var_6ab88489)) {
        level.var_6ab88489 = 0;
    }
    for (i = 0; i < level.var_fbe7c2fe.size; i++) {
        key = level.var_fbe7c2fe[i];
        var_31704579 = newhudelem();
        var_31704579.x = 150;
        var_31704579.y = y;
        var_31704579.alignx = "left";
        var_31704579.aligny = "top";
        var_31704579.horzalign = "fullscreen";
        var_31704579.vertalign = "fullscreen";
        var_31704579 settext(key);
        bgbar = newhudelem();
        bgbar.x = 150 + 79;
        bgbar.y = y + 1;
        bgbar.z = 1;
        bgbar.alignx = "left";
        bgbar.aligny = "top";
        bgbar.horzalign = "fullscreen";
        bgbar.vertalign = "fullscreen";
        bgbar.maxwidth = 3;
        bgbar setshader("white", bgbar.maxwidth, 10);
        bgbar.color = (0.5, 0.5, 0.5);
        bar = newhudelem();
        bar.x = 150 + 80;
        bar.y = y + 2;
        bar.alignx = "left";
        bar.aligny = "top";
        bar.horzalign = "fullscreen";
        bar.vertalign = "fullscreen";
        bar setshader("black", 1, 8);
        bar.sort = 1;
        var_31704579.bar = bar;
        var_31704579.bgbar = bgbar;
        var_31704579.key = key;
        y += 10;
        level.var_7e842153[key] = var_31704579;
    }
    level flag::wait_till("all_players_spawned");
    while (true) {
        waitframe(1);
        players = level.players;
        for (i = 0; i < level.var_fbe7c2fe.size && players.size > 0; i++) {
            key = level.var_fbe7c2fe[i];
            player = players[0];
            width = 0;
            if (i == 0) {
                width = player.health / player.maxhealth * 300;
                level.var_7e842153[key] settext(level.var_fbe7c2fe[0] + " " + player.health);
            } else if (i == 1) {
                width = (level.var_76f0070e - gettime()) / 1000 * 40;
            } else if (i == 2) {
                width = (level.var_6ab88489 - gettime()) / 1000 * 40;
            }
            width = int(max(width, 1));
            width = int(min(width, 300));
            bar = level.var_7e842153[key].bar;
            bar setshader("black", width, 8);
            bgbar = level.var_7e842153[key].bgbar;
            if (width + 2 > bgbar.maxwidth) {
                bgbar.maxwidth = width + 2;
                bgbar setshader("white", bgbar.maxwidth, 10);
                bgbar.color = (0.5, 0.5, 0.5);
            }
        }
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x45fe26e4, Offset: 0x12b8
// Size: 0xf6
function function_b75a45fc() {
    level notify(#"hash_3871a4a1");
    if (!isdefined(level.var_7e842153)) {
        return;
    }
    for (i = 0; i < level.var_fbe7c2fe.size; i++) {
        level.var_7e842153[level.var_fbe7c2fe[i]].bgbar destroy();
        level.var_7e842153[level.var_fbe7c2fe[i]].bar destroy();
        level.var_7e842153[level.var_fbe7c2fe[i]] destroy();
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x860a212, Offset: 0x13b8
// Size: 0x5c
function function_f7773608() {
    self endon(#"long_death");
    self endon(#"death");
    if (isdefined(level.script) && level.script != "core_frontend") {
        self function_80e52fad();
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x6c96c581, Offset: 0x1420
// Size: 0x34
function function_54f3f08b() {
    self endon(#"long_death");
    self endon(#"death");
    self function_e2c49328();
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x1cfbe546, Offset: 0x1460
// Size: 0x398
function function_fabc32f() {
    self endon(#"death");
    self endon(#"hash_84984c12");
    self.var_1428596a = 0;
    for (;;) {
        waitresult = self waittill("damage");
        if (isdefined(waitresult.attacker) && isplayer(waitresult.attacker)) {
            continue;
        }
        self.var_1428596a = 1;
        self.damagepoint = waitresult.position;
        self.damageattacker = waitresult.attacker;
        if (isdefined(waitresult.mod) && waitresult.mod == "MOD_BURNED") {
            self setburn(0.5);
            self playsound("chr_burn");
        }
        var_7a2a169 = waitresult.amount / self.maxhealth >= level.worthydamageratio;
        var_4c5c8654 = 0;
        if (isdefined(waitresult.attacker) && !isplayer(waitresult.attacker)) {
            if (self.health <= 1 && self function_10a2e0f5()) {
                var_7a2a169 = 1;
                var_23fe4143 = function_9d895340();
                var_a66b3dd5 = function_d6a24e36();
                var_4c5c8654 = var_23fe4143 * var_a66b3dd5;
                self.var_73881ee1 = 0;
                self thread function_58f840ea();
                level.var_6ab88489 = gettime() + var_4c5c8654;
            }
        }
        var_3d0925a9 = self.health / self.maxhealth;
        level notify(#"hit_again");
        var_4d2b26fb = 0;
        hurttime = gettime();
        if (!isdefined(level.var_eafffb33)) {
            self startfadingblur(3, 0.8);
        }
        if (!var_7a2a169) {
            continue;
        }
        if (self flag::get("player_is_invulnerable")) {
            continue;
        }
        self flag::set("player_is_invulnerable");
        level notify(#"hash_b995d6a3");
        if (var_4c5c8654 < function_6c4efa62()) {
            var_2ce8450a = function_6c4efa62();
        } else {
            var_2ce8450a = var_4c5c8654;
        }
        self thread function_bd76f2fc(var_2ce8450a);
    }
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xc1e5d740, Offset: 0x1800
// Size: 0xac
function function_bd76f2fc(timer) {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_b13e596e = self.attackeraccuracy;
    if (timer > 0) {
        self.attackeraccuracy = 0;
        level.var_76f0070e = gettime() + timer * 1000;
        wait timer;
    }
    self.attackeraccuracy = self.var_b13e596e;
    self.ignorebulletdamage = 0;
    self flag::clear("player_is_invulnerable");
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xf8498ff3, Offset: 0x18b8
// Size: 0xec
function grenadeawareness() {
    if (self.team == "allies") {
        self.grenadeawareness = 0.9;
        return;
    }
    if (self.team == "axis") {
        if (isdefined(level.gameskill) && level.gameskill >= 2) {
            if (randomint(100) < 33) {
                self.grenadeawareness = 0.2;
            } else {
                self.grenadeawareness = 0.5;
            }
            return;
        }
        if (randomint(100) < 33) {
            self.grenadeawareness = 0;
            return;
        }
        self.grenadeawareness = 0.2;
    }
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xac2aef44, Offset: 0x19b0
// Size: 0x108
function function_7d69a720(healthcap) {
    self endon(#"disconnect");
    self endon(#"killed_player");
    wait 2;
    player = self;
    ent = undefined;
    for (;;) {
        wait 0.2;
        if (player.health >= healthcap) {
            if (isdefined(ent)) {
                ent stoploopsound(1.5);
                level thread delayed_delete(ent, 1.5);
            }
            continue;
        }
        ent = spawn("script_origin", self.origin);
        ent playloopsound("", 0.5);
    }
}

// Namespace gameskill/gameskill_shared
// Params 2, eflags: 0x0
// Checksum 0xde1ddd89, Offset: 0x1ac0
// Size: 0x3c
function delayed_delete(ent, time) {
    wait time;
    ent delete();
    ent = undefined;
}

// Namespace gameskill/gameskill_shared
// Params 2, eflags: 0x0
// Checksum 0xb188d8a6, Offset: 0x1b08
// Size: 0xcc
function function_5cad004c(overlay, var_4fa2ad65) {
    self notify(#"hash_48d7d8e0");
    self endon(#"hash_48d7d8e0");
    while (!(isdefined(level.var_a250f238) && level.var_a250f238) && var_4fa2ad65 > 0) {
        waitframe(1);
        var_4fa2ad65 -= 0.05;
    }
    if (isdefined(level.var_a250f238) && level.var_a250f238) {
        overlay.alpha = 0;
        overlay fadeovertime(0.05);
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1be0
// Size: 0x4
function function_8ddec31d() {
    
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x87bbe645, Offset: 0x1bf0
// Size: 0x2c
function healthoverlay() {
    self endon(#"disconnect");
    self endon(#"noHealthOverlay");
    function_8ddec31d();
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0x31c566bd, Offset: 0x1c28
// Size: 0x1b4
function function_105a9902(aligny) {
    if (level.console) {
        self.fontscale = 2;
    } else {
        self.fontscale = 1.6;
    }
    self.x = 0;
    self.y = -36;
    self.alignx = "center";
    self.aligny = "bottom";
    self.horzalign = "center";
    self.vertalign = "middle";
    if (!isdefined(self.background)) {
        return;
    }
    self.background.x = 0;
    self.background.y = -40;
    self.background.alignx = "center";
    self.background.aligny = "middle";
    self.background.horzalign = "center";
    self.background.vertalign = "middle";
    if (level.console) {
        self.background setshader("popmenu_bg", 650, 52);
    } else {
        self.background setshader("popmenu_bg", 650, 42);
    }
    self.background.alpha = 0.5;
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xe76a9372, Offset: 0x1de8
// Size: 0xd0
function function_810b6482(player) {
    level notify(#"hash_ba9b454a");
    hudelem = newhudelem();
    hudelem function_105a9902();
    hudelem thread function_f4820efa(player);
    hudelem settext(%GAME_GET_TO_COVER);
    hudelem.fontscale = 1.85;
    hudelem.alpha = 1;
    hudelem.color = (1, 0.6, 0);
    return hudelem;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x76ab8d52, Offset: 0x1ec0
// Size: 0x64
function function_87118343() {
    if (isdefined(self.veryhurt)) {
        if (self.veryhurt == 0) {
            if (randomintrange(0, 1) == 1) {
                playsoundatposition("chr_breathing_hurt_start", self.origin);
            }
        }
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x38e780c3, Offset: 0x1f30
// Size: 0x22
function function_1819459d() {
    level endon(#"hit_again");
    self waittill("damage");
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xdbbc3d76, Offset: 0x1f60
// Size: 0x5c
function function_f4820efa(player) {
    self endon(#"being_destroyed");
    self endon(#"death");
    level flag::wait_till("missionfailed");
    self thread function_24c9c57a(1);
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0x88f03543, Offset: 0x1fc8
// Size: 0x8c
function function_24c9c57a(fadeout) {
    self notify(#"being_destroyed");
    self.beingdestroyed = 1;
    if (fadeout) {
        self fadeovertime(0.5);
        self.alpha = 0;
        wait 0.5;
    }
    self util::death_notify_wrapper();
    self destroy();
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xbd0daa26, Offset: 0x2060
// Size: 0x34
function function_f651876d(var_17dfcbe) {
    if (!isdefined(var_17dfcbe)) {
        return false;
    }
    if (isdefined(var_17dfcbe.beingdestroyed)) {
        return false;
    }
    return true;
}

// Namespace gameskill/gameskill_shared
// Params 2, eflags: 0x0
// Checksum 0xee1ef871, Offset: 0x20a0
// Size: 0x80
function function_fd208a76(scale, timer) {
    self endon(#"death");
    scale *= 2;
    dif = scale - self.fontscale;
    self changefontscaleovertime(timer);
    self.fontscale += dif;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x1354da43, Offset: 0x2128
// Size: 0x1dc
function function_cd0999e2() {
    level endon(#"missionfailed");
    if (self shouldshowcoverwarning()) {
        var_17dfcbe = function_810b6482(self);
        level.var_f0887a01 = var_17dfcbe;
        var_17dfcbe endon(#"death");
        var_af9bd93e = gettime() + level.longregentime;
        var_72edb94e = 0.7;
        while (gettime() < var_af9bd93e && isalive(self)) {
            for (i = 0; i < 7; i++) {
                var_72edb94e += 0.03;
                var_17dfcbe.color = (1, var_72edb94e, 0);
                waitframe(1);
            }
            for (i = 0; i < 7; i++) {
                var_72edb94e -= 0.03;
                var_17dfcbe.color = (1, var_72edb94e, 0);
                waitframe(1);
            }
        }
        if (function_f651876d(var_17dfcbe)) {
            var_17dfcbe fadeovertime(0.5);
            var_17dfcbe.alpha = 0;
        }
        wait 0.5;
        wait 5;
        var_17dfcbe destroy();
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x6d0d62bc, Offset: 0x2310
// Size: 0xe
function shouldshowcoverwarning() {
    return false;
}

// Namespace gameskill/gameskill_shared
// Params 5, eflags: 0x0
// Checksum 0x6145b44f, Offset: 0x2410
// Size: 0x398
function function_bbe24e91(overlay, var_17dfcbe, severity, mult, var_7170800d) {
    fadeintime = 0.8 * 0.1;
    var_a93d5122 = 0.8 * (0.1 + severity * 0.2);
    var_ac705df5 = 0.8 * (0.1 + severity * 0.1);
    var_97b1675d = 0.8 * 0.3;
    remainingtime = 0.8 - fadeintime - var_a93d5122 - var_ac705df5 - var_97b1675d;
    assert(remainingtime >= -0.001);
    if (remainingtime < 0) {
        remainingtime = 0;
    }
    var_84c9a0be = 0.8 + severity * 0.1;
    var_833e5b9c = 0.5 + severity * 0.3;
    overlay fadeovertime(fadeintime);
    overlay.alpha = mult * 1;
    if (function_f651876d(var_17dfcbe)) {
        if (!var_7170800d) {
            var_17dfcbe fadeovertime(fadeintime);
            var_17dfcbe.alpha = mult * 1;
        }
    }
    if (isdefined(var_17dfcbe)) {
        var_17dfcbe thread function_fd208a76(1, fadeintime);
    }
    wait fadeintime + var_a93d5122;
    overlay fadeovertime(var_ac705df5);
    overlay.alpha = mult * var_84c9a0be;
    if (function_f651876d(var_17dfcbe)) {
        if (!var_7170800d) {
            var_17dfcbe fadeovertime(var_ac705df5);
            var_17dfcbe.alpha = mult * var_84c9a0be;
        }
    }
    wait var_ac705df5;
    overlay fadeovertime(var_97b1675d);
    overlay.alpha = mult * var_833e5b9c;
    if (function_f651876d(var_17dfcbe)) {
        if (!var_7170800d) {
            var_17dfcbe fadeovertime(var_97b1675d);
            var_17dfcbe.alpha = mult * var_833e5b9c;
        }
    }
    if (isdefined(var_17dfcbe)) {
        var_17dfcbe thread function_fd208a76(0.9, var_97b1675d);
    }
    wait var_97b1675d;
    wait remainingtime;
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0x158cfb6f, Offset: 0x27b0
// Size: 0x5c
function function_2d8009b8(overlay) {
    self endon(#"disconnect");
    self waittill("noHealthOverlay", "death");
    overlay fadeovertime(3.5);
    overlay.alpha = 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x72517ba, Offset: 0x2818
// Size: 0x9c
function function_499dc9dc() {
    var_fc70911a = level.script == "training" || level.script == "cargoship" || level.script == "coup";
    if (getlocalprofileint("takeCoverWarnings") == -1 || var_fc70911a) {
        setlocalprofilevar("takeCoverWarnings", 9);
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xf1d1e571, Offset: 0x28c0
// Size: 0xdc
function function_a52cfd21() {
    if (!isplayer(self)) {
        return;
    }
    level notify(#"hash_310aee47");
    level endon(#"hash_310aee47");
    self waittill("death");
    if (!self flag::get("player_has_red_flashing_overlay")) {
        return;
    }
    if (level.gameskill > 1) {
        return;
    }
    var_cf4def2a = getlocalprofileint("takeCoverWarnings");
    if (var_cf4def2a < 10) {
        setlocalprofilevar("takeCoverWarnings", var_cf4def2a + 1);
    }
}

// Namespace gameskill/gameskill_shared
// Params 5, eflags: 0x0
// Checksum 0x4b98bc1d, Offset: 0x29a8
// Size: 0x2c
function function_79977f70(type, loc, point, attacker, amount) {
    
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xe1184a86, Offset: 0x29e0
// Size: 0x3d4
function function_2fb240f(var_4f8d5b23) {
    level notify(#"hash_16cdf7b1");
    level endon(#"hash_16cdf7b1");
    level.var_57830ddc = 9999;
    level.var_a76de5fa = 0;
    var_1fc6cd58 = -1;
    while (!isdefined(var_4f8d5b23)) {
        level.gameskill = getlocalprofileint("g_gameskill");
        if (level.gameskill != var_1fc6cd58) {
            if (!isdefined(level.gameskill)) {
                level.gameskill = 0;
            }
            setdvar("saved_gameskill", level.gameskill);
            switch (level.gameskill) {
            case 0:
                setdvar("currentDifficulty", "easy");
                level.currentdifficulty = "easy";
                break;
            case 1:
                setdvar("currentDifficulty", "normal");
                level.currentdifficulty = "normal";
                break;
            case 2:
                setdvar("currentDifficulty", "hardened");
                level.currentdifficulty = "hardened";
                break;
            case 3:
                setdvar("currentDifficulty", "veteran");
                level.currentdifficulty = "veteran";
                break;
            case 4:
                setdvar("currentDifficulty", "realistic");
                level.currentdifficulty = "realistic";
                break;
            }
            println("<dev string:x3b>" + level.gameskill);
            var_1fc6cd58 = level.gameskill;
            if (level.gameskill < level.var_57830ddc) {
                level.var_57830ddc = level.gameskill;
                matchrecordsetleveldifficultyforindex(2, level.gameskill);
            }
            if (level.gameskill > level.var_a76de5fa) {
                level.var_a76de5fa = level.gameskill;
                matchrecordsetleveldifficultyforindex(3, level.gameskill);
            }
            foreach (player in getplayers()) {
                player clientfield::set_player_uimodel("serverDifficulty", level.gameskill);
            }
        }
        wait 1;
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x91d0d374, Offset: 0x2dc0
// Size: 0xac
function function_4e14dca9() {
    level flagsys::wait_till("load_main_complete");
    level flag::wait_till("all_players_connected");
    while (level.players.size > 1) {
        players = getplayers("allies");
        level.var_82243644 = function_6979803c();
        wait 0.5;
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x33fe33de, Offset: 0x2e78
// Size: 0xac
function function_a3f0621e() {
    level flagsys::wait_till("load_main_complete");
    level flag::wait_till("all_players_connected");
    while (level.players.size > 1) {
        players = getplayers("allies");
        level.var_b8384d83 = function_c29e1b7d();
        wait 0.5;
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x37d15302, Offset: 0x2f30
// Size: 0x64
function function_80e52fad() {
    self endon(#"death");
    initialvalue = self.baseaccuracy;
    self.baseaccuracy = initialvalue * function_6979803c();
    wait randomfloatrange(3, 5);
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x424ec077, Offset: 0x2fa0
// Size: 0x98
function function_e2c49328() {
    self endon(#"death");
    initialvalue = self.baseaccuracy;
    while (level.players.size > 1) {
        if (!isdefined(level.var_b8384d83)) {
            wait 0.5;
            continue;
        }
        self.baseaccuracy = initialvalue * level.var_b8384d83;
        wait randomfloatrange(3, 5);
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3040
// Size: 0x4
function function_4c34249a() {
    
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0xd8758572, Offset: 0x3050
// Size: 0xc
function function_f099ec5c(player) {
    
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x39be2b3f, Offset: 0x3068
// Size: 0x116
function function_74d15397() {
    if (!isdefined(level.var_1bace747)) {
        level.var_1bace747 = [];
        level.var_1bace747[0] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_easy");
        level.var_1bace747[1] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_medium");
        level.var_1bace747[2] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_hard");
        level.var_1bace747[3] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_veteran");
        level.var_1bace747[4] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_realistic");
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x923f9295, Offset: 0x3188
// Size: 0x6
function function_872f62f0() {
    return false;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xe6d8cdc0, Offset: 0x3198
// Size: 0x5e
function function_684ec97e() {
    function_74d15397();
    var_2e40420 = level.var_1bace747[level.gameskill].difficulty_xp_multiplier;
    if (isdefined(var_2e40420)) {
        return var_2e40420;
    }
    return 1;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xf0a540b4, Offset: 0x3200
// Size: 0x5c
function function_a7c2f2c3() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].healthoverlaycutoff;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xdf5b21b1, Offset: 0x3268
// Size: 0x8
function function_f8ae406c() {
    return true;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x160557d7, Offset: 0x3278
// Size: 0x5c
function function_9d895340() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].player_deathinvulnerabletime;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xefa7a14f, Offset: 0x32e0
// Size: 0x5c
function function_72524c50() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].base_enemy_accuracy;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xa23b272b, Offset: 0x3348
// Size: 0x5c
function function_f0299cbc() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].playerdifficultyhealth;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xff3c149e, Offset: 0x33b0
// Size: 0x88
function function_6c4efa62() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].playerhitinvulntime;
    modifier = function_e314b70d();
    if (isdefined(var_d35c182a)) {
        var_d35c182a = modifier * var_d35c182a;
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x37ed7bcf, Offset: 0x3440
// Size: 0x5c
function function_702b3695() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].misstimeconstant;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x35818f51, Offset: 0x34a8
// Size: 0x5c
function function_7deab2f2() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].misstimeresetdelay;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x7ee9dbc6, Offset: 0x3510
// Size: 0x5c
function function_43c73456() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].misstimedistancefactor;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x967f5dca, Offset: 0x3578
// Size: 0x5c
function function_f4229065() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].dog_health;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x569afcd1, Offset: 0x35e0
// Size: 0x5c
function function_8a1f9500() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].var_70acedfa;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xb5e4acb8, Offset: 0x3648
// Size: 0x5c
function function_36a65b50() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].var_9d0779eb;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xaad53a9a, Offset: 0x36b0
// Size: 0x5c
function function_41990a66() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].longregentime;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xf80ed269, Offset: 0x3718
// Size: 0x5c
function function_c127b241() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].playerhealth_regularregendelay;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xc28a4f09, Offset: 0x3780
// Size: 0x5c
function function_1aed2639() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].worthydamageratio;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x3e7ef0f3, Offset: 0x37e8
// Size: 0x16a
function function_6979803c() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_689cb84e;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_ed19e9a8;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_537a43e;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_7c30779c;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    }
    return 1;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xc9ec8cec, Offset: 0x3960
// Size: 0x176
function function_c29e1b7d() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_e6ba970d;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_ed274ed3;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_f071abbd;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_fd59fce7;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    default:
        return 1;
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x959d0554, Offset: 0x3ae0
// Size: 0x176
function function_35c3fd5f() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_84dbf919;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_4c0a2833;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_7c84daa9;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_f45f8e27;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    default:
        return 1;
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x2f149b95, Offset: 0x3c60
// Size: 0x176
function function_c7e81340() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_17d30e79;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_b19673f7;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_520c9b29;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_7fc7ac2b;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    default:
        return 1;
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xdd54eb0b, Offset: 0x3de0
// Size: 0x176
function function_d6a24e36() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_4b093797;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_89052855;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_c2c11e27;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_161f6fd1;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    default:
        return 1;
    }
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x25027612, Offset: 0x3f60
// Size: 0x16a
function function_e314b70d() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_c58523a1;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_9ef90923;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_b23aedb1;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_f2af205f;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    }
    return 1;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x10dca48d, Offset: 0x40d8
// Size: 0x16a
function function_242ea84e() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_8dfa5ba;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_1bb1260;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_f2f8b9aa;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_550f6f64;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    }
    return 1;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xd95d6ab3, Offset: 0x4250
// Size: 0x4a
function get_general_difficulty_level() {
    value = level.gameskill + level.players.size - 1;
    if (value < 0) {
        value = 0;
    }
    return value;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x706859be, Offset: 0x42a8
// Size: 0x7a
function function_10a2e0f5() {
    if (isdefined(level.var_7ef66e8f) && level.var_7ef66e8f) {
        return 0;
    }
    player = self;
    if (level.gameskill >= 4) {
        return 0;
    }
    if (!isdefined(self.var_73881ee1)) {
        self.var_73881ee1 = 1;
    }
    return self.var_73881ee1;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0x96adcabd, Offset: 0x4330
// Size: 0x5a
function function_58f840ea() {
    self endon(#"disconnect");
    self endon(#"death");
    while (!self.var_73881ee1) {
        if (self.health >= self.maxhealth) {
            self.var_73881ee1 = 1;
        }
        waitframe(1);
    }
}

// Namespace gameskill/gameskill_shared
// Params 7, eflags: 0x0
// Checksum 0x9caa574, Offset: 0x4398
// Size: 0xa4
function function_57ab3c9d(player, eattacker, einflictor, idamage, weapon, shitloc, var_785f4b6e) {
    if (!isplayer(eattacker)) {
        var_c3484aa3 = function_f0299cbc();
        var_6a9a46fe = 100 / var_c3484aa3;
        idamage *= var_6a9a46fe;
    }
    return idamage;
}

// Namespace gameskill/gameskill_shared
// Params 7, eflags: 0x0
// Checksum 0xf7037cc, Offset: 0x4448
// Size: 0x146
function function_904126cf(player, eattacker, einflictor, idamage, weapon, shitloc, var_785f4b6e) {
    if ((var_785f4b6e == "MOD_MELEE" || var_785f4b6e == "MOD_MELEE_WEAPON_BUTT") && isentity(eattacker) && !isplayer(eattacker)) {
        idamage /= 5;
        if (idamage > 40) {
            playerforward = anglestoforward(player.angles);
            var_ca0031a3 = vectornormalize(eattacker.origin - player.origin);
            if (vectordot(playerforward, var_ca0031a3) < 0.342) {
                idamage = 40;
            }
        }
    }
    return idamage;
}

// Namespace gameskill/gameskill_shared
// Params 0, eflags: 0x0
// Checksum 0xa49d5ce6, Offset: 0x4598
// Size: 0x24
function function_305cdc5c() {
    self endon(#"death");
    self.baseaccuracy = self.accuracy;
}

// Namespace gameskill/gameskill_shared
// Params 1, eflags: 0x0
// Checksum 0x5c017065, Offset: 0x45c8
// Size: 0x4d6
function function_bc280431(ai) {
    self endon(#"death");
    if (getdvarint("ai_codeGameskill")) {
        return;
    }
    while (true) {
        if (isdefined(ai.enemy)) {
            if (isplayer(ai.enemy)) {
                if (!isdefined(ai.var_ffec2e60)) {
                    ai.var_ffec2e60 = ai.enemy;
                    ai.var_5a348cf0 = 0;
                    ai.var_8a14057b = gettime();
                    ai.lastshottime = ai.var_8a14057b;
                }
                if (ai.enemy != ai.var_ffec2e60) {
                    ai.var_ffec2e60 = ai.enemy;
                    ai.var_5a348cf0 = 0;
                    ai.var_8a14057b = gettime();
                    ai.lastshottime = ai.var_8a14057b;
                } else {
                    ai.var_42a4172a = function_702b3695();
                    ai.var_31b4c6e3 = function_43c73456();
                    ai.var_5017455f = function_7deab2f2();
                    if (ai.accuratefire) {
                        ai.var_5017455f *= 2;
                    }
                    var_a8d559fa = gettime();
                    var_9b68b629 = var_a8d559fa - ai.var_8a14057b;
                    distance = distance(ai.origin, ai.enemy.origin);
                    misstime = ai.var_42a4172a * 1000;
                    var_a82beafe = misstime + distance * ai.var_31b4c6e3;
                    var_d9ed1275 = anglestoforward(ai.enemy.angles);
                    var_e8ca7d79 = vectornormalize(ai.origin - ai.enemy.origin);
                    if (vectordot(var_d9ed1275, var_e8ca7d79) < 0.7) {
                        var_a82beafe *= 2;
                    }
                    if (var_a8d559fa - ai.lastshottime > ai.var_5017455f) {
                        ai.var_5a348cf0 = 0;
                        ai.var_8a14057b = var_a8d559fa;
                        var_9b68b629 = 0;
                    }
                    if (var_9b68b629 > var_a82beafe) {
                        ai.var_5a348cf0 = 1;
                    }
                    if (var_9b68b629 <= var_a82beafe && var_9b68b629 > var_a82beafe * 0.66) {
                        ai.var_5a348cf0 = 0.66;
                    }
                    if (var_9b68b629 <= var_a82beafe * 0.66 && var_9b68b629 > var_a82beafe * 0.33) {
                        ai.var_5a348cf0 = 0.33;
                    }
                    if (var_9b68b629 <= var_a82beafe * 0.33) {
                        ai.var_5a348cf0 = 0;
                    }
                    ai.lastshottime = var_a8d559fa;
                }
            } else {
                ai.var_5a348cf0 = 1;
            }
            ai.accuracy = ai.baseaccuracy * ai.var_5a348cf0;
        }
        self waittill("about_to_shoot");
    }
}

