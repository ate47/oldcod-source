#using scripts\abilities\gadgets\gadget_jammer_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace listening_device;

// Namespace listening_device/listening_device
// Params 0, eflags: 0x6
// Checksum 0x1d80db20, Offset: 0x160
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"listening_device", &preinit, undefined, undefined, undefined);
}

// Namespace listening_device/listening_device
// Params 0, eflags: 0x4
// Checksum 0x4e1be5a4, Offset: 0x1a8
// Size: 0x10c
function private preinit() {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_connect(&function_9147a2d6);
    callback::add_weapon_type(#"listening_device", &function_9eeebbfd);
    level.var_8ddf6d3d = getscriptbundle(#"listeningdevicesettings");
    level.var_96492769 = getscriptbundle(#"listeningdevicesettings_deadsilence");
    clientfield::register("missile", "listening_device_hacked", 1, 1, "counter", &function_a7c5eafc, 0, 0);
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0x169904bb, Offset: 0x2c0
// Size: 0x24
function function_9147a2d6(localclientnum) {
    self thread on_game_ended(localclientnum);
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0x2d622afd, Offset: 0x2f0
// Size: 0x1ae
function on_localplayer_spawned(localclientnum) {
    profilestart();
    self function_92725cf9(localclientnum);
    if (isdefined(level.var_ec396f92)) {
        var_bbf88336 = level.var_8ddf6d3d.var_ec25308b !== 1;
        if (var_bbf88336 && self function_21c0fa55()) {
            foreach (ref in level.var_ec396f92) {
                if (isdefined(ref.var_12dddf05)) {
                    arrayremovevalue(ref.var_12dddf05, undefined);
                    foreach (icon in ref.var_12dddf05) {
                        icon function_811196d1(ref.owner !== self);
                    }
                }
            }
        }
    }
    profilestop();
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0xb2d19236, Offset: 0x4a8
// Size: 0x6c
function function_92725cf9(localclientnum) {
    if (!self function_21c0fa55()) {
        return;
    }
    self thread monitor_detectnearbyenemies(localclientnum);
    self thread function_3f62f7c4(localclientnum);
    self thread function_b6dacb5a(localclientnum);
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0x3ac5701e, Offset: 0x520
// Size: 0x364
function function_9eeebbfd(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    localplayer = function_5c10bd79(localclientnum);
    if (getuimodelvalue(getuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "squadSpawnActive")) == 1) {
        localplayer = function_27673a7(localclientnum);
    }
    if (isdefined(localplayer)) {
        self function_a7bc52b0(localclientnum);
        if (!isdefined(level.var_ec396f92)) {
            level.var_ec396f92 = [];
        }
        level.var_ec396f92[self getentitynumber()] = self;
        self thread function_2c8858f7(localclientnum);
        var_bbf88336 = level.var_8ddf6d3d.var_ec25308b !== 1;
        if (var_bbf88336 && isdefined(self.owner) && self.owner == localplayer || !var_bbf88336 && self function_ca024039()) {
            if (!isdefined(level.var_4bec2e4)) {
                level.var_4bec2e4 = [];
            }
            var_163fec9d = localplayer getentitynumber();
            if (!isdefined(level.var_4bec2e4[var_163fec9d])) {
                level.var_4bec2e4[var_163fec9d] = [];
            }
            level.var_4bec2e4[var_163fec9d][self getentitynumber()] = self;
        } else if (!self function_ca024039()) {
            if (!isdefined(level.var_a8644947)) {
                level.var_a8644947 = [];
            }
            var_163fec9d = localplayer getentitynumber();
            if (!isdefined(level.var_a8644947[var_163fec9d])) {
                level.var_a8644947[var_163fec9d] = [];
            }
            level.var_a8644947[var_163fec9d][self getentitynumber()] = self;
            self.enabledxp = self playloopsound(#"hash_3986cbfda8c21269", 0.1, (0, 0, 8));
            self thread function_ea9698c4(localclientnum);
        }
        self useanimtree("generic");
        self setanim(#"hash_491c03762321028b", 1);
    }
}

// Namespace listening_device/listening_device
// Params 3, eflags: 0x4
// Checksum 0xc6cf3cca, Offset: 0x890
// Size: 0x23c
function private function_cf419a0(localclientnum, icon, range) {
    if (!isdefined(self.var_12dddf05)) {
        self.var_12dddf05 = [];
    }
    var_a2774043 = spawn(localclientnum, self.origin, "script_model", self.owner getentitynumber(), self.team);
    var_a2774043 setmodel(#"tag_origin");
    var_a2774043 linkto(self);
    var_a2774043 setcompassicon(icon);
    var_a2774043 function_5e00861(range * 2, 1);
    var_a2774043 function_a5edb367(#"neutral");
    var_a2774043 function_8e04481f();
    var_a2774043 function_90eba4b2(localclientnum, level.var_8ddf6d3d.var_151e2c9b, self.angles[1], level.var_8ddf6d3d.var_b060dd0c * 2);
    if (!(level.var_8ddf6d3d.var_ec25308b === 1) && !self.owner function_21c0fa55()) {
        var_a2774043 function_811196d1(1);
    }
    if (!isdefined(self.var_12dddf05)) {
        self.var_12dddf05 = [];
    } else if (!isarray(self.var_12dddf05)) {
        self.var_12dddf05 = array(self.var_12dddf05);
    }
    self.var_12dddf05[self.var_12dddf05.size] = var_a2774043;
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0x6be8fb87, Offset: 0xad8
// Size: 0x124
function function_a7bc52b0(localclientnum) {
    assert(isdefined(self.owner));
    var_55336d8d = level.var_8ddf6d3d;
    var_c394e130 = level.var_96492769;
    var_bf4bed59 = max(var_55336d8d.var_151e2c9b, var_c394e130.var_151e2c9b) + 30;
    var_4c470b6d = var_55336d8d.var_dccff18f * var_bf4bed59;
    var_b4bd288a = var_55336d8d.var_a8e88375 * var_bf4bed59;
    function_cf419a0(localclientnum, "ui_hud_minimap_listening_device_flipbook", var_b4bd288a);
    function_cf419a0(localclientnum, "ui_hud_minimap_listening_device_flipbook_inner", var_4c470b6d);
    jammer::register(self, &function_298eeca8);
}

// Namespace listening_device/listening_device
// Params 7, eflags: 0x0
// Checksum 0x3fd0b8da, Offset: 0xc08
// Size: 0x120
function function_298eeca8(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self.var_12dddf05)) {
        return;
    }
    arrayremovevalue(self.var_12dddf05, undefined);
    foreach (icon in self.var_12dddf05) {
        if (bwastimejump == 1) {
            icon function_811196d1(1);
            continue;
        }
        if (bwastimejump == 0) {
            icon function_811196d1(0);
        }
    }
}

// Namespace listening_device/listening_device
// Params 7, eflags: 0x0
// Checksum 0x36d0eb2f, Offset: 0xd30
// Size: 0x3b8
function function_a7c5eafc(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    localplayer = function_5c10bd79(bwastimejump);
    if (!isdefined(localplayer)) {
        return;
    }
    var_163fec9d = localplayer getentitynumber();
    if (isdefined(level.var_4bec2e4[var_163fec9d][self getentitynumber()])) {
        level.var_4bec2e4[var_163fec9d][self getentitynumber()] = undefined;
        arrayremovevalue(level.var_4bec2e4[var_163fec9d], undefined, 1);
        if (isdefined(self.var_12dddf05)) {
            arrayremovevalue(self.var_12dddf05, undefined, 1);
            foreach (icon in self.var_12dddf05) {
                function_dd7263ec(bwastimejump, icon getentitynumber());
                if (isdefined(icon)) {
                    icon delete();
                }
            }
        }
    }
    var_bbf88336 = level.var_8ddf6d3d.var_ec25308b !== 1;
    if (var_bbf88336 && isdefined(self.owner) && self.owner == localplayer || !var_bbf88336 && self function_ca024039()) {
        var_163fec9d = localplayer getentitynumber();
        if (!isdefined(level.var_4bec2e4)) {
            level.var_4bec2e4 = [];
        }
        if (!isdefined(level.var_4bec2e4[var_163fec9d])) {
            level.var_4bec2e4[var_163fec9d] = [];
        }
        level.var_4bec2e4[var_163fec9d][self getentitynumber()] = self;
        self function_a7bc52b0(bwastimejump);
        self thread function_2c8858f7(bwastimejump);
    } else if (!self function_ca024039()) {
        var_163fec9d = localplayer getentitynumber();
        if (!isdefined(level.var_a8644947)) {
            level.var_a8644947 = [];
        }
        if (!isdefined(level.var_a8644947[var_163fec9d])) {
            level.var_a8644947[var_163fec9d] = [];
        }
        level.var_a8644947[var_163fec9d][self getentitynumber()] = self;
        self thread function_ea9698c4(bwastimejump);
    }
    level notify(#"hacked");
}

// Namespace listening_device/listening_device
// Params 3, eflags: 0x0
// Checksum 0xb28df597, Offset: 0x10f0
// Size: 0x5e
function function_3edf2cf8(dist_sq, var_73491815, var_47435b6f) {
    return dist_sq < sqr(var_47435b6f) && sqr(var_47435b6f) < sqr(var_73491815);
}

// Namespace listening_device/listening_device
// Params 2, eflags: 0x0
// Checksum 0x87bdb0f9, Offset: 0x1158
// Size: 0xf2
function function_bc3e2f11(awareness_action, bundle) {
    switch (awareness_action) {
    case #"slide_start":
        return bundle.var_146483e7;
    case #"landing":
        return bundle.var_fe0aa1d2;
    case #"damage_landing":
        return bundle.var_6ae8117c;
    case #"doublejump_boosted":
        return bundle.var_37bac39d;
    case #"hash_589eac8b592bcb4d":
        return bundle.var_3b22f5be;
    case #"weapon_fired":
        return bundle.var_abea5dd8;
    case #"hash_552ed0592ee3fb0e":
        return bundle.var_301350af;
    }
    return 0;
}

// Namespace listening_device/listening_device
// Params 3, eflags: 0x0
// Checksum 0x37d4e06b, Offset: 0x1258
// Size: 0x1d8
function function_9ba59a68(localplayer, radius, var_33d2c2e8) {
    var_3fdb367c = level.var_4bec2e4[localplayer getentitynumber()];
    if (!isdefined(var_3fdb367c)) {
        return [];
    }
    arrayremovevalue(var_3fdb367c, undefined, 1);
    radiussq = sqr(radius);
    var_bbf88336 = level.var_8ddf6d3d.var_ec25308b !== 1;
    var_c1f7d98b = [];
    foreach (listening_device in var_3fdb367c) {
        if (var_bbf88336 && isdefined(listening_device.owner) && listening_device.owner != localplayer) {
            continue;
        }
        if (radiussq > 0.1 && distance2dsquared(listening_device.origin, localplayer.origin) > radiussq) {
            continue;
        }
        if (var_33d2c2e8) {
            listening_device.var_2a5aebad = undefined;
        }
        var_c1f7d98b[listening_device getentitynumber()] = listening_device;
    }
    return var_c1f7d98b;
}

// Namespace listening_device/listening_device
// Params 4, eflags: 0x0
// Checksum 0x72174cd5, Offset: 0x1438
// Size: 0x1c2
function function_baaa957a(localplayer, origin, radius, var_33d2c2e8) {
    var_3fdb367c = level.var_4bec2e4[localplayer getentitynumber()];
    if (!isdefined(var_3fdb367c)) {
        return false;
    }
    arrayremovevalue(var_3fdb367c, undefined, 1);
    radiussq = sqr(radius);
    var_bbf88336 = level.var_8ddf6d3d.var_ec25308b !== 1;
    var_c1f7d98b = [];
    foreach (listening_device in var_3fdb367c) {
        if (var_bbf88336 && isdefined(listening_device.owner) && listening_device.owner != localplayer) {
            continue;
        }
        if (radiussq > 0.1 && distance2dsquared(listening_device.origin, origin) > radiussq) {
            continue;
        }
        if (var_33d2c2e8) {
            listening_device.var_2a5aebad = undefined;
        }
        return true;
    }
    return false;
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0xe0600818, Offset: 0x1608
// Size: 0x8a4
function monitor_detectnearbyenemies(localclientnum) {
    self endon(#"death", #"disconnect");
    var_55336d8d = level.var_8ddf6d3d;
    var_c394e130 = level.var_96492769;
    params = {};
    while (true) {
        /#
            if (getdvarint(#"hash_3a4c39a1452c5f36", 0) > 0) {
                level.var_8ddf6d3d = getscriptbundle(#"listeningdevicesettings");
                var_55336d8d = level.var_8ddf6d3d;
                level.var_96492769 = getscriptbundle(#"listeningdevicesettings_deadsilence");
                var_c394e130 = level.var_96492769;
            }
        #/
        localplayer = function_5c10bd79(localclientnum);
        var_44cb89ab = isdefined(localplayer) && isplayer(localplayer) && isalive(localplayer);
        if (!var_44cb89ab || function_1cbf351b(localclientnum) == 1) {
            if (isdefined(level.var_783d3911) && gettime() < level.var_783d3911 + 12000) {
                wait 0.5;
                continue;
            }
            self waittill(#"spawned", #"death", #"disconnect");
            continue;
        }
        if (self isremotecontrolling(localclientnum)) {
            wait 0.5;
            continue;
        }
        if (self.var_7122b2ff !== 1) {
            localplayer thread function_c2b5b27c();
        }
        var_bf4bed59 = max(var_55336d8d.var_151e2c9b, var_c394e130.var_151e2c9b) + 30;
        var_99edc583 = localplayer function_fd82b127();
        var_ae5aa281 = var_99edc583 * 0.5;
        var_f69116db = 0;
        if (var_f69116db) {
            var_93ef2e00 = var_ae5aa281 + 100 + var_bf4bed59;
        } else {
            var_93ef2e00 = 0;
        }
        var_c1f7d98b = localplayer function_9ba59a68(localplayer, var_93ef2e00, 1);
        if (var_c1f7d98b.size == 0) {
            wait 0.05;
            continue;
        }
        var_aa51be56 = [];
        foreach (device in var_c1f7d98b) {
            if (!isdefined(device.owner)) {
                continue;
            }
            if (device.owner != localplayer) {
                continue;
            }
            sixthsenseents = function_f6f34851(localclientnum, localplayer.team, device.origin, var_bf4bed59);
            foreach (sixthsenseent in sixthsenseents) {
                if (!isdefined(sixthsenseent)) {
                    continue;
                }
                if (var_aa51be56[sixthsenseent getentitynumber()] === 1) {
                    continue;
                }
                bundle = var_55336d8d;
                if (isplayer(sixthsenseent) && sixthsenseent hasperk(localclientnum, #"specialty_sixthsensejammer")) {
                    bundle = var_c394e130;
                }
                params.bundle = bundle;
                params.range = bundle.var_151e2c9b + 30;
                params.rangesq = sqr(params.range);
                params.speed = sixthsenseent getspeed();
                var_7aeac1e7 = sixthsenseent function_60b0e73f(device, params);
                if (var_7aeac1e7) {
                    sixthsenseent function_c1903d9d();
                    var_aa51be56[sixthsenseent getentitynumber()] = 1;
                    if (gettime() - (isdefined(sixthsenseent.var_6766ff79) ? sixthsenseent.var_6766ff79 : 0) > (isdefined(bundle.var_10ad1e72) ? bundle.var_10ad1e72 : 0)) {
                        playsound(localclientnum, #"hash_3f3c18deefb8a1b9");
                    }
                    sixthsenseent.var_6766ff79 = gettime();
                }
            }
        }
        var_bbf88336 = level.var_8ddf6d3d.var_ec25308b !== 1;
        if (!var_bbf88336) {
            foreach (device in var_c1f7d98b) {
                if (!isdefined(device)) {
                    continue;
                }
                if (device.owner === localplayer) {
                    continue;
                }
                sixthsenseents = function_f6f34851(localclientnum, localplayer.team, device.origin, var_bf4bed59);
                foreach (sixthsenseent in sixthsenseents) {
                    if (!isdefined(sixthsenseent)) {
                        continue;
                    }
                    if (var_aa51be56[sixthsenseent getentitynumber()] === 1) {
                        continue;
                    }
                    bundle = var_55336d8d;
                    if (isplayer(sixthsenseent) && sixthsenseent hasperk(localclientnum, #"specialty_sixthsensejammer")) {
                        bundle = var_c394e130;
                    }
                    params.bundle = bundle;
                    params.range = bundle.var_151e2c9b + 30;
                    params.rangesq = sqr(params.range);
                    params.speed = sixthsenseent getspeed();
                    var_7aeac1e7 = sixthsenseent function_60b0e73f(device, params);
                    if (var_7aeac1e7) {
                        sixthsenseent function_c1903d9d();
                        var_aa51be56[sixthsenseent getentitynumber()] = 1;
                    }
                }
            }
        }
        wait 0.05;
    }
}

// Namespace listening_device/listening_device
// Params 2, eflags: 0x4
// Checksum 0x29850391, Offset: 0x1eb8
// Size: 0x63e
function private function_60b0e73f(device, params) {
    sixthsenseent = self;
    if (device.isjammed === 1) {
        return false;
    }
    distcurrentsq = distance2dsquared(sixthsenseent.origin, device.origin);
    if (distcurrentsq > params.rangesq) {
        return false;
    }
    bundle = params.bundle;
    var_a8eeaacb = sixthsenseent.origin - device.origin;
    var_9f639ea5 = vectornormalize((var_a8eeaacb[0], var_a8eeaacb[1], 0));
    if (!isdefined(device.var_2a5aebad)) {
        device.var_2a5aebad = anglestoforward((0, device.angles[1], 0));
    }
    if (bundle.var_b060dd0c < 180) {
        dot = vectordot(var_9f639ea5, device.var_2a5aebad);
        if (dot < cos(bundle.var_b060dd0c)) {
            return false;
        }
    }
    var_d6ff0766 = 0;
    var_7aeac1e7 = 0;
    if (isplayer(sixthsenseent) && sixthsenseent isplayerswimming()) {
        if (sixthsenseent isplayerswimmingonsurface() && params.speed >= bundle.var_9b69c823) {
            var_d6ff0766 = bundle.var_c26d14da * params.range;
            var_7aeac1e7 = 1;
        }
    } else if (params.speed >= bundle.var_293163bd) {
        movement_type = sixthsenseent getmovementtype();
        if (isplayer(sixthsenseent) && sixthsenseent function_d76efdcc()) {
            movement_type = "";
        }
        switch (movement_type) {
        case #"run":
        case #"walk":
            stance = sixthsenseent getstance();
            if (stance == "stand" && sixthsenseent isplayerads()) {
                var_d6ff0766 = bundle.var_2b6e9133 * params.range;
                var_7aeac1e7 = 1;
            } else if (stance == "stand") {
                var_d6ff0766 = bundle.var_dbf6038b * params.range;
                var_7aeac1e7 = 1;
            } else if (stance == "crouch") {
                var_d6ff0766 = bundle.var_dccff18f * params.range;
                var_7aeac1e7 = 1;
            }
            break;
        case #"sprint":
            var_d6ff0766 = bundle.var_a8e88375 * params.range;
            var_7aeac1e7 = 1;
            break;
        }
    } else if (params.speed <= (isdefined(bundle.var_6cb0467e) ? bundle.var_6cb0467e : 0) && (isdefined(bundle.var_ad484b97) ? bundle.var_ad484b97 : 0) != 0) {
        var_d6ff0766 = (isdefined(bundle.var_ad484b97) ? bundle.var_ad484b97 : 0) * params.range;
        if (distcurrentsq < sqr(var_d6ff0766)) {
            var_7aeac1e7 = 1;
        }
    }
    if (isdefined(sixthsenseent.var_629d0f94)) {
        actionkeys = getarraykeys(sixthsenseent.var_629d0f94);
        foreach (action in actionkeys) {
            var_aaf15d9a = sixthsenseent.var_629d0f94[action];
            if (!isdefined(var_aaf15d9a)) {
                continue;
            }
            if (gettime() - var_aaf15d9a > 500) {
                sixthsenseent.var_629d0f94[action] = undefined;
                continue;
            }
            var_7cecdeb5 = function_bc3e2f11(action, bundle) * params.range;
            if (!var_7aeac1e7 || function_3edf2cf8(distcurrentsq, var_d6ff0766, var_7cecdeb5)) {
                var_d6ff0766 = var_7cecdeb5;
                var_7aeac1e7 = 1;
            }
        }
        arrayremovevalue(sixthsenseent.var_629d0f94, undefined, 1);
    }
    if (!var_7aeac1e7) {
        return false;
    }
    var_482e2661 = sqr(var_d6ff0766);
    detected = var_d6ff0766 == 0 || distcurrentsq < var_482e2661;
    if (!detected) {
        return false;
    }
    return true;
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x4
// Checksum 0xb992bd69, Offset: 0x2500
// Size: 0x308
function private function_3f62f7c4(localclientnum) {
    self endon(#"death", #"disconnect");
    bundle = level.var_8ddf6d3d;
    if (!isdefined(level.var_17d9f80)) {
        level.var_17d9f80 = [];
    }
    while (true) {
        localplayer = function_5c10bd79(localclientnum);
        var_44cb89ab = isdefined(localplayer) && isplayer(localplayer) && isalive(localplayer);
        if (!var_44cb89ab || function_1cbf351b(localclientnum) == 1) {
            if (isdefined(level.var_783d3911) && gettime() < level.var_783d3911 + 12000) {
                wait 0.5;
                continue;
            }
            self waittill(#"spawned", #"death", #"disconnect");
            continue;
        }
        if (self isremotecontrolling(localclientnum)) {
            wait 0.5;
            continue;
        }
        if (level.var_17d9f80.size == 0) {
            wait 0.05;
            continue;
        }
        var_93ef2e00 = bundle.var_151e2c9b + 30;
        foreach (nightingale in level.var_17d9f80) {
            if (!isdefined(nightingale)) {
                continue;
            }
            if (nightingale function_e9fc6a64()) {
                continue;
            }
            if (function_baaa957a(localplayer, nightingale.origin, var_93ef2e00, 1)) {
                nightingale function_c1903d9d();
                if (gettime() - (isdefined(nightingale.var_6766ff79) ? nightingale.var_6766ff79 : 0) > (isdefined(bundle.var_10ad1e72) ? bundle.var_10ad1e72 : 0)) {
                    playsound(localclientnum, #"hash_3f3c18deefb8a1b9");
                }
                nightingale.var_6766ff79 = gettime();
            }
        }
        wait 0.05;
    }
}

// Namespace listening_device/listening_device
// Params 0, eflags: 0x0
// Checksum 0xa860819, Offset: 0x2810
// Size: 0x104
function function_c2b5b27c() {
    if (self.var_7122b2ff === 1) {
        return;
    }
    self.var_7122b2ff = 1;
    while (true) {
        if (!isdefined(self)) {
            wait 0.5;
            continue;
        }
        waitresult = self waittill(#"awareness_action", #"death", #"disconnect");
        if (waitresult._notify !== #"awareness_action") {
            self.var_7122b2ff = undefined;
            return;
        }
        if (isdefined(waitresult.var_53714565)) {
            var_9f19a239 = waitresult.var_53714565;
            if (!isdefined(var_9f19a239.var_629d0f94)) {
                var_9f19a239.var_629d0f94 = [];
            }
            var_9f19a239.var_629d0f94[waitresult.action] = gettime();
        }
    }
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x4
// Checksum 0xed45c9e8, Offset: 0x2920
// Size: 0x13c
function private function_2c8858f7(localclientnum) {
    self waittill(#"death", #"disconnect");
    arrayremovevalue(self.var_12dddf05, undefined, 1);
    foreach (icon in self.var_12dddf05) {
        if (!isdefined(icon)) {
            continue;
        }
        var_45986af = icon getentitynumber();
        function_dd7263ec(localclientnum, var_45986af);
        if (isdefined(icon)) {
            icon delete();
        }
    }
    level.var_ec396f92[self getentitynumber()] = undefined;
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x4
// Checksum 0xf24920ee, Offset: 0x2a68
// Size: 0x56
function private function_ea9698c4(*localclientnum) {
    self waittill(#"death");
    if (isdefined(self.enabledxp)) {
        self stoploopsound(self.enabledxp);
        self.enabledxp = undefined;
    }
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x4
// Checksum 0x631f1f09, Offset: 0x2ac8
// Size: 0x3c
function private on_game_ended(localclientnum) {
    level waittill(#"game_ended");
    function_8c113a94(localclientnum);
}

// Namespace listening_device/listening_device
// Params 4, eflags: 0x0
// Checksum 0x6411b847, Offset: 0x2b10
// Size: 0x1c0
function function_c4aa9cb(*localclientnum, localplayer, radius, var_33d2c2e8) {
    var_3fdb367c = level.var_a8644947[localplayer getentitynumber()];
    if (!isdefined(var_3fdb367c)) {
        return [];
    }
    arrayremovevalue(var_3fdb367c, undefined, 1);
    radiussq = sqr(radius);
    var_48d4da6b = [];
    foreach (listening_device in var_3fdb367c) {
        if (listening_device.owner === localplayer) {
            continue;
        }
        if (listening_device function_e9fc6a64()) {
            continue;
        }
        if (radiussq > 0.1 && distance2dsquared(listening_device.origin, localplayer.origin) > radiussq) {
            continue;
        }
        if (var_33d2c2e8) {
            listening_device.var_2a5aebad = undefined;
        }
        var_48d4da6b[listening_device getentitynumber()] = listening_device;
    }
    return var_48d4da6b;
}

// Namespace listening_device/listening_device
// Params 1, eflags: 0x0
// Checksum 0xb7f6f350, Offset: 0x2cd8
// Size: 0x544
function function_b6dacb5a(localclientnum) {
    self endon(#"death", #"disconnect");
    var_55336d8d = level.var_8ddf6d3d;
    var_c394e130 = level.var_96492769;
    params = {};
    while (true) {
        localplayer = function_5c10bd79(localclientnum);
        var_44cb89ab = isdefined(localplayer) && isplayer(localplayer) && isalive(localplayer);
        if (!var_44cb89ab || function_1cbf351b(localclientnum) == 1) {
            if (isdefined(level.var_783d3911) && gettime() < level.var_783d3911 + 12000) {
                wait 0.5;
                continue;
            }
            self waittill(#"spawned", #"death", #"disconnect");
            continue;
        }
        if (self isremotecontrolling(localclientnum)) {
            wait 0.5;
            continue;
        }
        if (self.var_7122b2ff !== 1) {
            localplayer thread function_c2b5b27c();
        }
        var_bf4bed59 = max(var_55336d8d.var_151e2c9b, var_c394e130.var_151e2c9b) + 30;
        var_93ef2e00 = 100 + var_bf4bed59;
        var_48d4da6b = localplayer function_c4aa9cb(localclientnum, localplayer, var_93ef2e00, 1);
        if (var_48d4da6b.size == 0) {
            wait 0.05;
            continue;
        }
        var_aa51be56 = [];
        foreach (device in var_48d4da6b) {
            if (!isdefined(device.owner)) {
                continue;
            }
            sixthsenseents = [];
            if (!isdefined(sixthsenseents)) {
                sixthsenseents = [];
            } else if (!isarray(sixthsenseents)) {
                sixthsenseents = array(sixthsenseents);
            }
            sixthsenseents[sixthsenseents.size] = function_27673a7(0);
            foreach (sixthsenseent in sixthsenseents) {
                if (!isdefined(sixthsenseent)) {
                    continue;
                }
                if (var_aa51be56[sixthsenseent getentitynumber()] === 1) {
                    continue;
                }
                bundle = var_55336d8d;
                if (isplayer(sixthsenseent) && sixthsenseent hasperk(localclientnum, #"specialty_sixthsensejammer")) {
                    bundle = var_c394e130;
                }
                params.bundle = bundle;
                params.range = bundle.var_151e2c9b + 30;
                params.rangesq = sqr(params.range);
                params.speed = sixthsenseent getspeed();
                var_7aeac1e7 = sixthsenseent function_60b0e73f(device, params);
                if (var_7aeac1e7) {
                    var_aa51be56[sixthsenseent getentitynumber()] = 1;
                    if (isdefined(sixthsenseent.var_130d4592)) {
                        if (gettime() - sixthsenseent.var_130d4592 > (isdefined(bundle.var_5bb76e91) ? bundle.var_5bb76e91 : 0)) {
                            playsound(localclientnum, #"hash_aecd0fa1fde77a8");
                        }
                    }
                    sixthsenseent.var_130d4592 = gettime();
                }
            }
        }
        wait 0.05;
    }
}

