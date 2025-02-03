#using script_13da4e6b98ca81a1;
#using script_3d0f36632dad12df;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace killstreaks;

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0xf95f5c12, Offset: 0x250
// Size: 0x474
function init_shared() {
    clientfield::register_clientuimodel("locSel.commandMode", #"hash_5bbe0cd6740ab2b6", #"commandmode", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("locSel.snapTo", #"hash_5bbe0cd6740ab2b6", #"snapto", 1, 1, "int", undefined, 0, 0);
    clientfield::register("vehicle", "timeout_beep", 1, 2, "int", &timeout_beep, 0, 0);
    clientfield::register("toplayer", "thermal_glow", 1, 1, "int", &function_6d265b7f, 0, 1);
    clientfield::register("toplayer", "thermal_glow_enemies_only", 12000, 1, "int", &function_c66f053, 0, 1);
    clientfield::register("allplayers", "killstreak_spawn_protection", 1, 1, "int", &function_77515127, 0, 0);
    clientfield::register("vehicle", "timeout_beep", 1, 2, "int", &timeout_beep, 0, 0);
    clientfield::register("vehicle", "standardTagFxSet", 1, 1, "int", &function_eef48704, 0, 0);
    clientfield::register("scriptmover", "standardTagFxSet", 1, 1, "int", &function_eef48704, 0, 0);
    clientfield::register("scriptmover", "lowHealthTagFxSet", 1, 1, "int", &function_11044e2b, 0, 0);
    clientfield::register("scriptmover", "deathTagFxSet", 1, 1, "int", &function_d440313, 0, 0);
    clientfield::register("toplayer", "" + #"hash_524d30f5676b2070", 1, 1, "int", &function_ce367b0c, 0, 0);
    clientfield::register("vehicle", "scorestreakActive", 1, 1, "int", &function_5ec060c4, 0, 0);
    clientfield::register("scriptmover", "scorestreakActive", 1, 1, "int", &function_5ec060c4, 0, 0);
    callback::on_spawned(&on_player_spawned);
    callback::function_a880899e(&function_a880899e);
    level.killstreakcorebundle = getscriptbundle("killstreak_core");
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x4
// Checksum 0x24e925b8, Offset: 0x6d0
// Size: 0xd4
function private function_5ec060c4(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        if (self.weapon == getweapon(#"uav") || self.weapon == getweapon(#"counteruav")) {
            if (self function_e9fc6a64()) {
                return;
            }
        }
        self function_1f0c7136(2);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0x415e97a, Offset: 0x7b0
// Size: 0x27a
function timeout_beep(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"timeout_beep");
    if (!bwastimejump) {
        return;
    }
    if (isdefined(self.killstreakbundle)) {
        beepalias = self.killstreakbundle.kstimeoutbeepalias;
    } else if (isdefined(self.settingsbundle)) {
        beepalias = self.settingsbundle.kstimeoutbeepalias;
        var_4f5f9e46 = self.settingsbundle.var_90af4f48;
    }
    self endon(#"death");
    self endon(#"timeout_beep");
    interval = 1;
    if (bwastimejump == 2) {
    }
    for (interval = 0.133; true; interval = math::clamp(interval / 1.17, 0.1, 1)) {
        if (isdefined(beepalias)) {
            var_91e09a3a = 1;
            if (var_4f5f9e46 === 1) {
                driver = self getlocalclientdriver();
                if (!isdefined(driver)) {
                    var_91e09a3a = 0;
                }
            }
            if (var_91e09a3a) {
                offset = (0, 0, isdefined(self.killstreakbundle.var_19d5e80a) ? self.killstreakbundle.var_19d5e80a : 0);
                self playsound(fieldname, beepalias, self.origin + offset);
            }
        }
        if (self.timeoutlightsoff === 1) {
            self vehicle::lights_on(fieldname);
            self.timeoutlightsoff = 0;
        } else {
            self vehicle::lights_off(fieldname);
            self.timeoutlightsoff = 1;
        }
        util::server_wait(fieldname, interval);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0xd577bbe3, Offset: 0xa38
// Size: 0x110
function function_6d265b7f(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    players = getplayers(fieldname);
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        player renderoverridebundle::function_f4eab437(fieldname, bwastimejump, #"hash_2c6fce4151016478", &function_429c452);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0xd771f2f0, Offset: 0xb50
// Size: 0x148
function function_c66f053(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    local_player = self;
    var_c86e6ba8 = self.team;
    players = getplayers(fieldname);
    should_play = bwastimejump == 1;
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        player renderoverridebundle::function_f4eab437(fieldname, should_play, #"hash_53798044d9a468d7", &function_e56218ab);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xcf01ed91, Offset: 0xca0
// Size: 0x126
function function_429c452(localclientnum, should_play) {
    if (!should_play) {
        return 0;
    }
    if (!isdefined(self)) {
        return 0;
    }
    if (!isplayer(self)) {
        return should_play;
    }
    localplayer = function_5c10bd79(localclientnum);
    if (isdefined(localplayer) && !localplayer util::isenemyteam(self.team)) {
        return 0;
    }
    if (!function_266be0d4(localclientnum)) {
        return 0;
    }
    if (self hasperk(localclientnum, #"specialty_nokillstreakreticle")) {
        return 0;
    }
    if (self clientfield::get("killstreak_spawn_protection")) {
        return 0;
    }
    if (codcaster::function_45a5c04c(localclientnum)) {
        return 0;
    }
    return 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xad24a7ae, Offset: 0xdd0
// Size: 0x116
function function_e56218ab(localclientnum, should_play) {
    if (!should_play) {
        return 0;
    }
    if (!isdefined(self)) {
        return 0;
    }
    if (!isplayer(self)) {
        return should_play;
    }
    localplayer = function_5c10bd79(localclientnum);
    if (isdefined(localplayer) && localplayer.team == self.team) {
        return 0;
    }
    if (!function_266be0d4(localclientnum)) {
        return 0;
    }
    if (self hasperk(localclientnum, #"specialty_nokillstreakreticle")) {
        return 0;
    }
    if (self clientfield::get("killstreak_spawn_protection")) {
        return 0;
    }
    if (codcaster::function_45a5c04c(localclientnum)) {
        return 0;
    }
    return 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0xc2f006fb, Offset: 0xef0
// Size: 0xbc
function function_77515127(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self thread renderoverridebundle::function_ee77bff9(bwastimejump, "thermal_glow", #"hash_2c6fce4151016478", &function_429c452);
    self thread renderoverridebundle::function_ee77bff9(bwastimejump, "thermal_glow_enemies_only", #"hash_53798044d9a468d7", &function_e56218ab);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xe9a24812, Offset: 0xfb8
// Size: 0xce
function on_player_spawned(localclientnum) {
    self renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_2c6fce4151016478");
    self renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_53798044d9a468d7");
    if (self function_da43934d()) {
        if (isdefined(self.var_29806c31) && self function_d2cb869e(self.var_29806c31)) {
            self codestoppostfxbundle(self.var_29806c31);
            self.var_29806c31 = undefined;
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x15a45841, Offset: 0x1090
// Size: 0x100
function function_a880899e(eventparams) {
    localclientnum = eventparams.localclientnum;
    if (codcaster::function_45a5c04c(localclientnum)) {
        foreach (player in getplayers(localclientnum)) {
            if (isdefined(player) && !function_3132f113(player)) {
                player renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_2c6fce4151016478");
            }
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0xb9c56426, Offset: 0x1198
// Size: 0x108
function function_eef48704(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    entnum = self getentitynumber();
    function_fb18ebcc(fieldname, entnum);
    if (bwastimejump == 1) {
        self util::waittill_dobj(fieldname);
        waittillframeend();
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(self.killstreakbundle.var_d81025a)) {
            return;
        }
        if (!isdefined(level.var_da32fba8)) {
            level.var_da32fba8 = [];
        }
        level.var_da32fba8[entnum] = playtagfxset(fieldname, self.killstreakbundle.var_d81025a, self);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x569a3f61, Offset: 0x12a8
// Size: 0xe8
function function_fb18ebcc(localclientnum, entnum) {
    if (!isdefined(entnum)) {
        return;
    }
    if (!isdefined(level.var_da32fba8[entnum])) {
        return;
    }
    fxarray = level.var_da32fba8[entnum];
    foreach (fx_id in fxarray) {
        stopfx(localclientnum, fx_id);
    }
    level.var_da32fba8[entnum] = undefined;
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0x35eca6bc, Offset: 0x1398
// Size: 0xa4
function function_11044e2b(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 0) {
        return;
    }
    if (!isdefined(self.killstreakbundle.var_7021eaaa)) {
        return;
    }
    self util::waittill_dobj(fieldname);
    playtagfxset(fieldname, self.killstreakbundle.var_7021eaaa, self);
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0x5316a10d, Offset: 0x1448
// Size: 0xa4
function function_d440313(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 0) {
        return;
    }
    if (!isdefined(self.killstreakbundle.var_349c25fe)) {
        return;
    }
    self util::waittill_dobj(fieldname);
    playtagfxset(fieldname, self.killstreakbundle.var_349c25fe, self);
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x0
// Checksum 0x3b3dedb2, Offset: 0x14f8
// Size: 0x19c
function function_ce367b0c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"disconnect");
    if (isdefined(self.var_29806c31)) {
        if (self function_d2cb869e(self.var_29806c31)) {
            self codestoppostfxbundle(self.var_29806c31);
        }
        self.var_29806c31 = undefined;
    }
    if (squad_spawn::function_21b773d5(fieldname)) {
        return;
    }
    if (bwastimejump) {
        killstreakbundle = function_bd2d5a8e(self.weapon.name);
        postfxbundle = killstreakbundle.var_bda68f72;
        if (!isdefined(postfxbundle)) {
            return;
        }
        self codeplaypostfxbundle(postfxbundle);
        self.var_29806c31 = postfxbundle;
        if (isdefined(killstreakbundle.var_d80ce136)) {
            self playsound(fieldname, killstreakbundle.var_d80ce136);
        }
        if (function_1cbf351b(fieldname)) {
            self thread function_2dab81c1(postfxbundle);
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x4
// Checksum 0x950d7f03, Offset: 0x16a0
// Size: 0x14e
function private function_bd2d5a8e(killstreakweaponname) {
    if (!isdefined(killstreakweaponname)) {
        return;
    }
    switch (killstreakweaponname) {
    case #"inventory_ac130":
    case #"ac130":
        bundle = getscriptbundle("killstreak_ac130");
        break;
    case #"inventory_chopper_gunner":
    case #"chopper_gunner":
        bundle = getscriptbundle("killstreak_chopper_gunner");
        break;
    case #"recon_car":
    case #"inventory_recon_car":
        bundle = getscriptbundle("killstreak_recon_car");
        break;
    case #"remote_missile":
    case #"inventory_remote_missile":
        bundle = getscriptbundle("killstreak_remote_missile");
        break;
    default:
        break;
    }
    return bundle;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xfec2f31, Offset: 0x17f8
// Size: 0xae
function function_2dab81c1(bundlename) {
    var_17b7891d = "58631a4a6c470f1f" + bundlename;
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    localclientnum = self.localclientnum;
    self waittill(#"death");
    if (function_148ccc79(localclientnum, bundlename)) {
        codestoppostfxbundlelocal(localclientnum, bundlename);
        if (self.var_29806c31 === bundlename) {
            self.var_29806c31 = undefined;
        }
    }
}

