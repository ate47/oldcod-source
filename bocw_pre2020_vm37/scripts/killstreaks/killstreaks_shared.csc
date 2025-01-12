#using script_13da4e6b98ca81a1;
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
// Params 0, eflags: 0x1 linked
// Checksum 0xcc08880e, Offset: 0x238
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
// Params 7, eflags: 0x5 linked
// Checksum 0xcbe0109a, Offset: 0x6b8
// Size: 0x64
function private function_5ec060c4(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self function_1f0c7136(2);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xdaab7f20, Offset: 0x728
// Size: 0x232
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
                self playsound(fieldname, beepalias);
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
// Params 7, eflags: 0x1 linked
// Checksum 0x947c9b85, Offset: 0x968
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
// Params 7, eflags: 0x1 linked
// Checksum 0x46e58fbd, Offset: 0xa80
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
// Params 2, eflags: 0x1 linked
// Checksum 0xe9ffbead, Offset: 0xbd0
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
// Params 2, eflags: 0x1 linked
// Checksum 0x62406e8e, Offset: 0xd00
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
// Params 7, eflags: 0x1 linked
// Checksum 0x87143ebe, Offset: 0xe20
// Size: 0xbc
function function_77515127(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self thread renderoverridebundle::function_ee77bff9(bwastimejump, "thermal_glow", #"hash_2c6fce4151016478", &function_429c452);
    self thread renderoverridebundle::function_ee77bff9(bwastimejump, "thermal_glow_enemies_only", #"hash_53798044d9a468d7", &function_e56218ab);
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xc5a87636, Offset: 0xee8
// Size: 0x5c
function on_player_spawned(localclientnum) {
    self renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_2c6fce4151016478");
    self renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_53798044d9a468d7");
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf6c722f, Offset: 0xf50
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
// Params 7, eflags: 0x1 linked
// Checksum 0xc2f02b97, Offset: 0x1058
// Size: 0xf0
function function_eef48704(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    entnum = self getentitynumber();
    function_fb18ebcc(fieldname, entnum);
    if (bwastimejump == 1) {
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
// Params 2, eflags: 0x1 linked
// Checksum 0x72f71cb1, Offset: 0x1150
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
// Params 7, eflags: 0x1 linked
// Checksum 0xdc73f44d, Offset: 0x1240
// Size: 0x8c
function function_11044e2b(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 0) {
        return;
    }
    if (!isdefined(self.killstreakbundle.var_7021eaaa)) {
        return;
    }
    playtagfxset(fieldname, self.killstreakbundle.var_7021eaaa, self);
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x3d36228, Offset: 0x12d8
// Size: 0x8c
function function_d440313(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 0) {
        return;
    }
    if (!isdefined(self.killstreakbundle.var_349c25fe)) {
        return;
    }
    playtagfxset(fieldname, self.killstreakbundle.var_349c25fe, self);
}

// Namespace killstreaks/killstreaks_shared
// Params 7, eflags: 0x1 linked
// Checksum 0x33ac1d4f, Offset: 0x1370
// Size: 0x11c
function function_ce367b0c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"disconnect");
    killstreakbundle = function_bd2d5a8e(self.weapon.name);
    postfxbundle = killstreakbundle.var_bda68f72;
    var_9243b194 = killstreakbundle.var_d80ce136;
    if (!isdefined(postfxbundle)) {
        return;
    }
    if (self postfx::function_556665f2(postfxbundle)) {
        self postfx::stoppostfxbundle(postfxbundle);
    }
    if (bwastimejump) {
        self postfx::playpostfxbundle(postfxbundle);
        if (isdefined(var_9243b194)) {
            self playsound(fieldname, var_9243b194);
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x5 linked
// Checksum 0x896f25f, Offset: 0x1498
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

