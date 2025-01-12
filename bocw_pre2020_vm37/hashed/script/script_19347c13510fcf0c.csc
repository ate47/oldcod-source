#using script_2c02e4fb8b1b2e0c;
#using script_5520b91a8aa516ab;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace hawk_wz;

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x6
// Checksum 0x66295dfa, Offset: 0x178
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hawk_wz", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x5 linked
// Checksum 0x6e6fdf97, Offset: 0x1c0
// Size: 0x26c
function private function_70a657d8() {
    level.var_dde557d5 = 0;
    level.hawk_settings = spawnstruct();
    namespace_e579bb10::function_9b8847dd();
    level.var_ef287aa1 = [];
    level.var_eba5e1cc = [];
    level.var_eba5e1cc[#"stand"] = (0, 0, 60);
    level.var_eba5e1cc[#"crouch"] = (0, 0, 40);
    level.var_eba5e1cc[#"prone"] = (0, 0, 12);
    level.var_aac98621 = [];
    level.var_8dfa7ed7 = [];
    for (ti = 0; ti < level.hawk_settings.bundle.var_48e78794; ti++) {
        uifield = remote_missile_target_lockon::register_clientside();
        level.var_aac98621[ti] = uifield;
        level.var_8dfa7ed7[uifield.var_bf9c8c95] = ti;
    }
    clientfield::register("vehicle", "hawk_range", 13000, 1, "int", &function_6701affc, 0, 1);
    vehicle::add_vehicletype_callback("veh_hawk_player_wz", &hawk_spawned);
    vehicle::function_2f97bc52("veh_hawk_player_wz", &function_fbdbb841);
    vehicle::function_2f97bc52("veh_hawk_player_far_range_wz", &function_1ed9ef6a);
    vehicle::function_cd2ede5("veh_hawk_player_wz", &function_500d3fa7);
    vehicle::function_cd2ede5("veh_hawk_player_far_range_wz", &function_fc1227ca);
    callback::on_localplayer_spawned(&on_local_player_spawned);
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x3a318216, Offset: 0x438
// Size: 0x3c
function private hawk_spawned(localclientnum) {
    self function_811196d1(1);
    self thread function_23a9e4af(localclientnum);
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0xb1ea0039, Offset: 0x480
// Size: 0x2c
function private function_8bd7314c(*localclientnum) {
    function_1eaaceab(level.var_ef287aa1, 0);
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x5 linked
// Checksum 0x8e30f627, Offset: 0x4b8
// Size: 0x26
function private function_f95544c4(team1, team2) {
    if (team1 == team2) {
        return true;
    }
    return false;
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x882304af, Offset: 0x4e8
// Size: 0xbe
function private hawk_think(localclientnum) {
    self endoncallback(&function_8bd7314c, #"death");
    array::add(level.var_ef287aa1, self, 0);
    self.var_704e7b07 = [];
    self.targets = [];
    while (true) {
        self function_8487fabe(localclientnum);
        self function_76b4c572(localclientnum);
        self function_9ace0fb6(localclientnum);
        waitframe(1);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x445a0831, Offset: 0x5b0
// Size: 0x164
function private function_23a9e4af(localclientnum) {
    self endon(#"death");
    while (!isdefined(self.owner)) {
        wait 0.1;
    }
    if (isplayer(self.owner)) {
        var_fa76b7bf = self.owner;
        localplayer = function_5c10bd79(localclientnum);
        if (isdefined(localplayer) && function_f95544c4(var_fa76b7bf.team, localplayer.team)) {
            self function_811196d1(0);
        }
        if (var_fa76b7bf function_21c0fa55()) {
            setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "hawkActive"), 1);
            self thread function_2e07be71(localclientnum);
        }
    }
    self thread hawk_think(localclientnum);
}

// Namespace hawk_wz/hawk_wz
// Params 3, eflags: 0x5 linked
// Checksum 0x24ae5085, Offset: 0x720
// Size: 0x8c
function private function_25b776e2(localclientnum, ti, entnum) {
    if (!isdefined(self.var_e4102217[ti]) || self.var_e4102217[ti] != entnum) {
        uifield = level.var_aac98621[ti];
        uifield remote_missile_target_lockon::set_clientnum(localclientnum, entnum);
        self.var_e4102217[ti] = entnum;
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x14fa534f, Offset: 0x7b8
// Size: 0x18
function private function_bbb5186f(ti) {
    return self.var_e4102217[ti];
}

// Namespace hawk_wz/hawk_wz
// Params 3, eflags: 0x5 linked
// Checksum 0x713a85cf, Offset: 0x7d8
// Size: 0x74
function private set_target_locked(*localclientnum, ti, var_3c5beee7) {
    if (!isdefined(self.var_6a09a180[ti]) || self.var_6a09a180[ti] != var_3c5beee7) {
        uifield = level.var_aac98621[ti];
        self.var_6a09a180[ti] = var_3c5beee7;
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x3def308c, Offset: 0x858
// Size: 0x18
function private get_target_locked(ti) {
    return self.var_6a09a180[ti];
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x4df9352b, Offset: 0x878
// Size: 0x252
function private function_ec2a2906(localclientnum) {
    var_6d1bc3fe = function_1df4c3b0(localclientnum, #"remote_missile_target_lockon");
    player_entnum = self getentitynumber();
    for (ti = 0; ti < level.hawk_settings.bundle.var_48e78794; ti++) {
        uifield = level.var_aac98621[ti];
        if (!uifield remote_missile_target_lockon::is_open(localclientnum)) {
            uifield remote_missile_target_lockon::open(localclientnum);
        }
        var_9935a809 = isdefined(ti + 32) ? "" + ti + 32 : "";
        var_24a98e1f = var_9935a809 + ".target_locked";
        createuimodel(var_6d1bc3fe, var_24a98e1f);
        var_b4fbb3cb = var_9935a809 + ".clientnum";
        createuimodel(var_6d1bc3fe, var_b4fbb3cb);
        var_3d384de3 = var_9935a809 + ".lockonScale";
        self.var_d32addbf[ti] = createuimodel(var_6d1bc3fe, var_3d384de3);
        var_907cb130 = var_9935a809 + ".lockonObscured";
        self.var_fad86c46[ti] = createuimodel(var_6d1bc3fe, var_907cb130);
        self function_25b776e2(localclientnum, ti, player_entnum);
        self set_target_locked(localclientnum, ti, 0);
        uifield remote_missile_target_lockon::set_ishawktag(localclientnum, 1);
    }
    self.var_89285548 = 1;
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0xa67f7d06, Offset: 0xad8
// Size: 0xae
function private function_3c760dfe(localclientnum) {
    for (ti = 0; ti < level.hawk_settings.bundle.var_48e78794; ti++) {
        uifield = level.var_aac98621[ti];
        if (uifield remote_missile_target_lockon::is_open(localclientnum)) {
            uifield remote_missile_target_lockon::close(localclientnum);
        }
    }
    self.var_e4102217 = [];
    self.var_6a09a180 = [];
    self.var_89285548 = 0;
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x5 linked
// Checksum 0x944ea712, Offset: 0xb90
// Size: 0x160
function private function_364150fd() {
    result = [];
    var_c84ba99b = 0;
    foreach (hawk in level.var_ef287aa1) {
        if (!isdefined(hawk)) {
            var_c84ba99b = 1;
            continue;
        }
        if (isdefined(hawk.owner) && hawk.var_846bfed3 !== hawk.owner.team) {
            hawk.var_846bfed3 = hawk.owner.team;
        }
        if (isdefined(hawk) && isdefined(hawk.var_846bfed3) && function_f95544c4(hawk.var_846bfed3, self.team)) {
            result[result.size] = hawk;
        }
    }
    if (var_c84ba99b) {
        function_1eaaceab(level.var_ef287aa1, 0);
    }
    return result;
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x18760166, Offset: 0xcf8
// Size: 0x10a
function private function_a0e351e0(localclientnum) {
    if (!isdefined(self.var_89285548)) {
        self.var_89285548 = 0;
    }
    if (!isdefined(self.var_e4102217)) {
        self.var_e4102217 = [];
    }
    if (!isdefined(self.var_6a09a180)) {
        self.var_6a09a180 = [];
    }
    var_a980942f = self function_364150fd();
    inkillcam = function_1cbf351b(localclientnum);
    if (!self.var_89285548 && var_a980942f.size > 0 && !inkillcam) {
        self function_ec2a2906(localclientnum);
    }
    if (self.var_89285548 && var_a980942f.size == 0 || inkillcam) {
        self function_3c760dfe(localclientnum);
    }
    return self.var_89285548;
}

// Namespace hawk_wz/hawk_wz
// Params 3, eflags: 0x5 linked
// Checksum 0x23b0a2c2, Offset: 0xe10
// Size: 0x1ae
function private function_2d90a835(localclientnum, radius, var_1a0eaecb) {
    enemies = [];
    if (!var_1a0eaecb || isdefined(self.owner)) {
        players = getentitiesinradius(localclientnum, self.origin, radius, 1);
        local_player = function_5c10bd79(localclientnum);
        if (distancesquared(local_player.origin, self.origin) < function_a3f6cdac(radius) && !array::contains(players, local_player)) {
            players[players.size] = local_player;
        }
        foreach (player in players) {
            if (isalive(player) && !function_f95544c4(self.team, player.team)) {
                enemies[enemies.size] = player;
            }
        }
    }
    return enemies;
}

// Namespace hawk_wz/hawk_wz
// Params 3, eflags: 0x5 linked
// Checksum 0x40d07156, Offset: 0xfc8
// Size: 0x230
function private function_d952430d(localclientnum, &array, targets) {
    var_e5cf40eb = [];
    foreach (target in targets) {
        var_e5cf40eb[target getentitynumber()] = 1;
    }
    to_remove = [];
    foreach (entnum, _ in array) {
        if (isdefined(var_e5cf40eb[entnum])) {
            ent = getentbynum(localclientnum, entnum);
            if (!isdefined(ent) || !isplayer(ent) || !isalive(ent)) {
                to_remove[to_remove.size] = entnum;
            }
            continue;
        }
        to_remove[to_remove.size] = entnum;
    }
    foreach (entnum in to_remove) {
        arrayremoveindex(array, entnum, 1);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x8b23227f, Offset: 0x1200
// Size: 0x196
function private function_76b4c572(*localclientnum) {
    foreach (target in self.targets) {
        if (!isdefined(target)) {
            continue;
        }
        var_4ef4e267 = target getentitynumber();
        if (!isdefined(self.var_704e7b07[var_4ef4e267])) {
            self.var_704e7b07[var_4ef4e267] = spawnstruct();
            self.var_704e7b07[var_4ef4e267].visible = 0;
        }
    }
    foreach (var_4ef4e267, var_8712c5b8 in self.var_704e7b07) {
        var_8712c5b8.var_aaf744fe = var_8712c5b8.state === 1;
        var_8712c5b8.state = 0;
        var_8712c5b8.var_fb579b3e = var_8712c5b8.visible;
        var_8712c5b8.visible = 0;
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0xe5a25ec6, Offset: 0x13a0
// Size: 0x550
function private function_9ace0fb6(localclientnum) {
    time = gettime();
    bundle = level.hawk_settings.bundle;
    foreach (target in self.targets) {
        var_4ef4e267 = target getentitynumber();
        var_e5cf40eb[var_4ef4e267] = 1;
        info = self.var_704e7b07[var_4ef4e267];
        if (!info.var_fb579b3e) {
            info.first_visible = time;
        }
        info.visible = 1;
        info.var_1fe906d8 = time;
        tagtime = int(bundle.tag_time * 1000);
        if (target hasperk(localclientnum, #"specialty_nokillstreakreticle")) {
            tagtime *= bundle.var_59b7880b;
        }
        if (info.var_1fe906d8 - info.first_visible > tagtime) {
            if (isdefined(self.owner) && target function_21c0fa55() && !info.var_aaf744fe && !function_f95544c4(self.owner.team, target.team)) {
                target playsound(localclientnum, #"hash_4f43df2a649784d0");
            }
            info.state = 1;
            info.var_a7e1d732 = time;
        } else if (isdefined(info.var_a7e1d732) && time - info.var_a7e1d732 < int(bundle.var_fb7c1412 * 1000)) {
            info.state = 1;
            info.var_a7e1d732 = time;
        }
        if (info.state == 1) {
            if (!target function_d2503806(#"hash_38038ed7002fd3d3")) {
                target playrenderoverridebundle(#"hash_38038ed7002fd3d3");
            }
        } else if (target function_d2503806(#"hash_38038ed7002fd3d3")) {
            target stoprenderoverridebundle(#"hash_38038ed7002fd3d3");
        }
        self.var_704e7b07[var_4ef4e267] = info;
    }
    to_remove = [];
    foreach (entnum, info in self.var_704e7b07) {
        var_78b9056b = 0;
        ent = getentbynum(localclientnum, entnum);
        if (!isdefined(ent) || !isplayer(ent) || !isalive(ent)) {
            to_remove[to_remove.size] = entnum;
            var_78b9056b = 1;
        } else if (!function_cfd3bed0(info)) {
            to_remove[to_remove.size] = entnum;
            var_78b9056b = 1;
        }
        if (var_78b9056b && isdefined(ent)) {
            if (ent function_d2503806(#"hash_38038ed7002fd3d3")) {
                ent stoprenderoverridebundle(#"hash_38038ed7002fd3d3");
            }
        }
    }
    foreach (entnum in to_remove) {
        arrayremoveindex(self.var_704e7b07, entnum, 1);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x9adea07b, Offset: 0x18f8
// Size: 0x54
function private function_cfd3bed0(var_8712c5b8) {
    if (!is_true(var_8712c5b8.visible)) {
        if (!isdefined(var_8712c5b8.var_1fe906d8)) {
            return false;
        }
        if (gettime() - var_8712c5b8.var_1fe906d8 > 500) {
            return false;
        }
    }
    return true;
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x29633e5f, Offset: 0x1958
// Size: 0x11a
function private function_35046386(target) {
    var_4ef4e267 = target getentitynumber();
    foreach (hawk in level.var_ef287aa1) {
        if (isdefined(hawk) && isdefined(hawk.var_846bfed3) && function_f95544c4(hawk.var_846bfed3, self.team)) {
            info = hawk.var_704e7b07[var_4ef4e267];
            if (isdefined(info) && info.state == 1) {
                return true;
            }
        }
    }
    return false;
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x5 linked
// Checksum 0xc7fa26f6, Offset: 0x1a80
// Size: 0x59c
function private function_d53feb8c(localclientnum, targets) {
    var_b3f5ea99 = self getentitynumber();
    var_1dcaad7e = [];
    var_97e92766 = [];
    for (ti = 0; ti < level.hawk_settings.bundle.var_48e78794; ti++) {
        uifield = level.var_aac98621[ti];
        entnum = self function_bbb5186f(ti);
        if (entnum == var_b3f5ea99) {
            var_97e92766[var_97e92766.size] = uifield;
            continue;
        }
        var_1dcaad7e[entnum] = uifield;
    }
    bundle = level.hawk_settings.bundle;
    var_59d4144b = isdefined(bundle.var_59d4144b) ? bundle.var_59d4144b : 0.5;
    var_e7c561e2 = isdefined(bundle.var_e7c561e2) ? bundle.var_e7c561e2 : 0.3;
    var_98977cea = isdefined(bundle.var_98977cea) ? bundle.var_98977cea : 2;
    now = gettime();
    var_5044f28d = [];
    var_a980942f = self function_364150fd();
    foreach (target in targets) {
        var_4ef4e267 = target getentitynumber();
        uifield = undefined;
        if (isdefined(var_1dcaad7e[var_4ef4e267])) {
            uifield = var_1dcaad7e[var_4ef4e267];
        } else if (var_97e92766.size > 0) {
            uifield = var_97e92766[0];
            arrayremoveindex(var_97e92766, 0, 0);
            var_1dcaad7e[var_4ef4e267] = uifield;
        }
        if (isdefined(uifield)) {
            ti = level.var_8dfa7ed7[uifield.var_bf9c8c95];
            var_5044f28d[ti] = 1;
            self function_25b776e2(localclientnum, ti, var_4ef4e267);
            var_e06385a3 = 0;
            if (self function_35046386(target)) {
                var_e06385a3 = 1;
            }
            if (self get_target_locked(ti) != var_e06385a3) {
                self set_target_locked(localclientnum, ti, var_e06385a3);
                if (var_e06385a3 == 1) {
                    self playsound(localclientnum, bundle.tag_sound);
                }
            }
            assert(isdefined(ti));
            var_4759b4d3 = project3dto2d(localclientnum, target.origin);
            var_20a99afd = project3dto2d(localclientnum, target.origin + (0, 0, 60));
            screen_height = distance2d(var_4759b4d3, var_20a99afd);
            var_fcd926d5 = var_59d4144b * screen_height / 60;
            var_fcd926d5 = math::clamp(var_fcd926d5, var_e7c561e2, var_98977cea);
            setuimodelvalue(self.var_d32addbf[ti], var_fcd926d5);
            var_d7caaee9 = 1;
            foreach (hawk in var_a980942f) {
                if (isdefined(hawk.var_5f360c48[var_4ef4e267])) {
                    var_d7caaee9 = 0;
                    break;
                }
            }
            setuimodelvalue(self.var_fad86c46[ti], var_d7caaee9);
        }
    }
    for (ti = 0; ti < level.hawk_settings.bundle.var_48e78794; ti++) {
        if (!is_true(var_5044f28d[ti])) {
            self set_target_locked(localclientnum, ti, 0);
        }
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x892171be, Offset: 0x2028
// Size: 0xf6
function private function_a552c160(localclientnum) {
    self endon(#"death", #"disconnect");
    self.var_d32addbf = [];
    self.var_fad86c46 = [];
    var_a980942f = self function_364150fd();
    if (var_a980942f.size == 0) {
        self function_3c760dfe(localclientnum);
    }
    while (true) {
        if (function_a0e351e0(localclientnum)) {
            targets = self function_bba5f8f7();
            self function_d53feb8c(localclientnum, targets);
        }
        waitframe(1);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x1 linked
// Checksum 0xb55ca7e6, Offset: 0x2128
// Size: 0x44
function function_fbdbb841(localclientnum, *vehicle) {
    if (!self function_21c0fa55()) {
        return;
    }
    function_775073e(vehicle);
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x1 linked
// Checksum 0x1b83a922, Offset: 0x2178
// Size: 0x44
function function_1ed9ef6a(localclientnum, *vehicle) {
    if (!self function_21c0fa55()) {
        return;
    }
    function_6367489e(vehicle);
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x1 linked
// Checksum 0x6edf809, Offset: 0x21c8
// Size: 0x44
function function_500d3fa7(localclientnum, *vehicle) {
    if (!self function_21c0fa55()) {
        return;
    }
    function_3759fcf(vehicle);
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x1 linked
// Checksum 0x47807a5e, Offset: 0x2218
// Size: 0x44
function function_fc1227ca(localclientnum, *vehicle) {
    if (!self function_21c0fa55()) {
        return;
    }
    function_3759fcf(vehicle);
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0xfa259f4c, Offset: 0x2268
// Size: 0xc4
function on_local_player_spawned(localclientnum) {
    player = function_5c10bd79(localclientnum);
    vehicle = getplayervehicle(player);
    player function_a552c160(localclientnum);
    if (isdefined(vehicle) && (vehicle.vehicletype == #"veh_hawk_player_wz" || vehicle.vehicletype == #"veh_hawk_player_far_range_wz")) {
        return;
    }
    function_3759fcf(localclientnum);
}

// Namespace hawk_wz/hawk_wz
// Params 7, eflags: 0x1 linked
// Checksum 0xa1c2709, Offset: 0x2338
// Size: 0x114
function function_6701affc(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (self.vehicletype != #"veh_hawk_player_wz" && self.vehicletype != #"veh_hawk_player_far_range_wz") {
        return;
    }
    player = function_5c10bd79(fieldname);
    vehicle = getplayervehicle(player);
    if (isdefined(vehicle) && self == vehicle) {
        if (bwastimejump > 0) {
            vehicle.var_b61d83c4 = 1;
            function_6367489e(fieldname);
            return;
        }
        vehicle.var_b61d83c4 = 0;
        function_775073e(fieldname);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0xbb1e7af, Offset: 0x2458
// Size: 0xec
function function_775073e(localclientnum) {
    if (function_148ccc79(localclientnum, #"hash_63b0389eb9286669")) {
        codestoppostfxbundlelocal(localclientnum, #"hash_63b0389eb9286669");
    }
    if (!function_148ccc79(localclientnum, #"hash_594d5293046135ff")) {
        function_a837926b(localclientnum, #"hash_594d5293046135ff");
    }
    var_e39026ad = createuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "hawkWeakSignal");
    if (isdefined(var_e39026ad)) {
        setuimodelvalue(var_e39026ad, 0);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0x2e876436, Offset: 0x2550
// Size: 0xf4
function function_6367489e(localclientnum) {
    if (function_148ccc79(localclientnum, #"hash_594d5293046135ff")) {
        codestoppostfxbundlelocal(localclientnum, #"hash_594d5293046135ff");
    }
    if (!function_148ccc79(localclientnum, #"hash_63b0389eb9286669")) {
        function_a837926b(localclientnum, #"hash_63b0389eb9286669");
    }
    var_e39026ad = createuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "hawkWeakSignal");
    if (isdefined(var_e39026ad)) {
        setuimodelvalue(var_e39026ad, 1);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 2, eflags: 0x1 linked
// Checksum 0x61ea4662, Offset: 0x2650
// Size: 0xf4
function function_3759fcf(localclientnum, *var_c5e2f09a) {
    if (function_148ccc79(var_c5e2f09a, #"hash_594d5293046135ff")) {
        codestoppostfxbundlelocal(var_c5e2f09a, #"hash_594d5293046135ff");
    }
    if (function_148ccc79(var_c5e2f09a, #"hash_63b0389eb9286669")) {
        codestoppostfxbundlelocal(var_c5e2f09a, #"hash_63b0389eb9286669");
    }
    var_e39026ad = createuimodel(function_1df4c3b0(var_c5e2f09a, #"hash_6f4b11a0bee9b73d"), "hawkWeakSignal");
    if (isdefined(var_e39026ad)) {
        setuimodelvalue(var_e39026ad, 0);
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x1 linked
// Checksum 0x2ba71000, Offset: 0x2750
// Size: 0x1cc
function function_2e07be71(localclientnum) {
    notifyparam = localclientnum + "_" + self getentitynumber();
    var_17b7891d = "4fd3fe74405b9c5c" + notifyparam;
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    assert(isdefined(self.owner));
    self.owner endon(#"disconnect");
    var_3216cebd = self.owner getentitynumber();
    self waittill(#"death");
    if (isdefined(var_3216cebd)) {
        for (hawk_owner = getentbynum(localclientnum, var_3216cebd); !isdefined(hawk_owner); hawk_owner = getentbynum(localclientnum, var_3216cebd)) {
            waitframe(1);
        }
        if (isdefined(hawk_owner) && isplayer(hawk_owner) && hawk_owner function_21c0fa55()) {
            hawk_owner function_3c760dfe(localclientnum);
            setuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "hawkActive"), 0);
        }
    }
}

// Namespace hawk_wz/hawk_wz
// Params 1, eflags: 0x5 linked
// Checksum 0x907fa79c, Offset: 0x2928
// Size: 0x6f2
function private function_8487fabe(localclientnum) {
    self endon(#"death");
    bundle = level.hawk_settings.bundle;
    var_1a0eaecb = isdefined(bundle.var_1a0eaecb) ? bundle.var_1a0eaecb : 0;
    if (is_true(self.var_b61d83c4) || var_1a0eaecb && !isdefined(self.owner)) {
        self.var_5f360c48 = [];
        self.var_c55be3a2 = [];
        self.targets = [];
        return;
    }
    if (isdefined(self.owner) && isplayer(self.owner)) {
        var_82bf9f7b = self.owner getplayerangles();
        self.var_c568689e = var_82bf9f7b;
    }
    if (!isdefined(self.var_c568689e)) {
        self.var_c568689e = self.angles;
    }
    forward = anglestoforward(self.var_c568689e);
    var_e4f883c1 = function_a3f6cdac(bundle.var_957e91c4);
    enemies = self function_2d90a835(localclientnum, bundle.var_957e91c4, var_1a0eaecb);
    if (!isdefined(self.var_5f360c48)) {
        self.var_5f360c48 = [];
    }
    if (!isdefined(self.var_c55be3a2)) {
        self.var_c55be3a2 = [];
    }
    var_4d392c1d = int((isdefined(bundle.var_4f848330) ? bundle.var_4f848330 : 0) * 1000);
    var_d691d922 = int((isdefined(bundle.var_ab326589) ? bundle.var_ab326589 : 0) * 1000);
    bullet_traces_this_frame = 0;
    targets = [];
    foreach (player in enemies) {
        if (!isalive(player)) {
            continue;
        }
        now = gettime();
        vehicle = getplayervehicle(player);
        stance_offset = level.var_eba5e1cc[player getstance()];
        if (isdefined(vehicle)) {
            stance_offset = level.var_eba5e1cc[#"crouch"];
        }
        toplayer = vectornormalize(player.origin + stance_offset - self.origin);
        in_sight = 0;
        var_131803ce = vectordot(toplayer, forward) >= bundle.tag_fov;
        if (var_131803ce) {
            in_sight = bullettracepassed(self.origin, player.origin + stance_offset, 0, self, player, 1);
            bullet_traces_this_frame++;
            if (!in_sight && isdefined(vehicle)) {
                trace_result = bullettrace(self.origin, player.origin + stance_offset, 0, self);
                if (trace_result[#"fraction"] < 1 && trace_result[#"entity"] === vehicle) {
                    in_sight = 1;
                    bullet_traces_this_frame++;
                }
            }
        }
        valid_target = 0;
        if (!in_sight) {
            if (var_131803ce) {
                if (bundle.var_d1a5fb3b === 1) {
                    self.var_5f360c48[player getentitynumber()] = undefined;
                    continue;
                }
                if (isdefined(self.var_5f360c48[player getentitynumber()])) {
                    valid_target = var_4d392c1d == 0 || now - self.var_5f360c48[player getentitynumber()] < var_4d392c1d;
                }
            } else {
                if (bundle.var_4917731f === 1) {
                    self.var_c55be3a2[player getentitynumber()] = undefined;
                    continue;
                }
                if (isdefined(self.var_c55be3a2[player getentitynumber()])) {
                    valid_target = var_d691d922 == 0 || now - self.var_c55be3a2[player getentitynumber()] < var_d691d922;
                }
            }
        } else {
            valid_target = 1;
            self.var_5f360c48[player getentitynumber()] = now;
            self.var_c55be3a2[player getentitynumber()] = now;
        }
        if (valid_target) {
            targets[targets.size] = player;
        }
        if (bullet_traces_this_frame >= 2) {
            waitframe(1);
        }
    }
    function_1eaaceab(targets, 0);
    function_d952430d(localclientnum, self.var_5f360c48, targets);
    function_d952430d(localclientnum, self.var_c55be3a2, targets);
    self.targets = targets;
}

// Namespace hawk_wz/hawk_wz
// Params 0, eflags: 0x5 linked
// Checksum 0x64b818ef, Offset: 0x3028
// Size: 0x14a
function private function_bba5f8f7() {
    var_ef7046e6 = self.origin;
    targets = [];
    var_a980942f = function_364150fd();
    foreach (hawk in var_a980942f) {
        targets = arraycombine(targets, hawk.targets, 0, 0);
        if (hawk.owner === self) {
            var_ef7046e6 = hawk.origin;
        }
    }
    function_1eaaceab(targets);
    bundle = level.hawk_settings.bundle;
    return arraysortclosest(targets, var_ef7046e6, bundle.var_48e78794, 0, bundle.var_957e91c4);
}

