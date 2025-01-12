#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\sound_shared;
#using scripts\core_common\util_shared;

#namespace smokegrenade;

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x9d52584d, Offset: 0x130
// Size: 0x194
function init_shared() {
    clientfield::register("allplayers", "inenemysmoke", 14000, 1, "int", &insmoke, 0, 0);
    clientfield::register("scriptmover", "smoke_state", 16000, 1, "int", &function_ffbaa2ce, 0, 0);
    clientfield::register("allplayers", "insmoke", 16000, 2, "int", &insmoke, 0, 0);
    renderoverridebundle::function_f72f089c(#"hash_8120ecc0ceec5c6", "rob_mute_smoke_outline", &function_28db726, undefined, undefined, 1);
    renderoverridebundle::function_f72f089c(#"hash_224b6b4d7364dbb5", "rob_mute_smoke_outline_team", &function_62ec0142, undefined, undefined, 1);
    callback::on_localplayer_spawned(&on_local_player_spawned);
    level.var_7cc76271 = &vehicle_transition;
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x84d0c0e6, Offset: 0x2d0
// Size: 0x108
function on_local_player_spawned(local_client_num) {
    thread function_e69d0e4d(local_client_num);
    thread track_grenades(local_client_num);
    players = getplayers(local_client_num);
    foreach (player in players) {
        if (isdefined(player) && isalive(player)) {
            player function_4fc900e1(local_client_num);
        }
    }
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x460a767b, Offset: 0x3e0
// Size: 0x9e
function track_grenades(*local_client_num) {
    self notify(#"track_grenades");
    self endon(#"track_grenades", #"death", #"disconnect");
    waitresult = self waittill(#"grenade_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;
}

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x91fb4f0f, Offset: 0x488
// Size: 0xae
function function_709fad19() {
    weapon = getweapon(#"eq_smoke");
    if (!isdefined(weapon) || weapon == level.weaponnone || !isdefined(weapon.customsettings)) {
        return 128;
    }
    var_b0b958b3 = getscriptbundle(weapon.customsettings);
    return isdefined(var_b0b958b3.var_40dfefd1) ? var_b0b958b3.var_40dfefd1 : 128;
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0xb7c56367, Offset: 0x540
// Size: 0x260
function monitor_smoke(local_client_num) {
    var_d3f60df1 = self;
    self notify(#"monitor_smoke");
    self endon(#"monitor_smoke", #"death", #"delete");
    localplayer = function_5c10bd79(local_client_num);
    if (isdefined(var_d3f60df1) && isdefined(var_d3f60df1.owner) && isdefined(localplayer) && var_d3f60df1.owner != localplayer) {
        return;
    }
    radius = function_709fad19();
    while (isdefined(var_d3f60df1)) {
        waitresult = var_d3f60df1 waittilltimeout(0.25, #"death");
        players = getplayers(local_client_num);
        foreach (player in players) {
            dist = distance2d(player.origin, var_d3f60df1.origin);
            if (dist < radius) {
                if (!isdefined(player.var_d3f60df1)) {
                    player.var_d3f60df1 = var_d3f60df1;
                    player function_4fc900e1(local_client_num);
                }
                continue;
            }
            if (isdefined(player.var_d3f60df1)) {
                player.var_d3f60df1 = undefined;
                player function_4fc900e1(local_client_num);
            }
        }
        if (waitresult._notify != "timeout") {
            break;
        }
    }
}

// Namespace smokegrenade/smokegrenade
// Params 7, eflags: 0x0
// Checksum 0xa3dc2215, Offset: 0x7a8
// Size: 0x148
function function_ffbaa2ce(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self thread monitor_smoke(fieldname);
        return;
    }
    self notify(#"monitor_smoke");
    players = getplayers(fieldname);
    foreach (player in players) {
        if (isdefined(player) && isalive(player)) {
            player.var_d3f60df1 = undefined;
            player function_4fc900e1(fieldname);
        }
    }
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0xcbfac667, Offset: 0x8f8
// Size: 0x1dc
function function_e69d0e4d(local_client_num) {
    self notify(#"hash_2286178f49f4601d");
    self endon(#"hash_2286178f49f4601d", #"death", #"disconnect");
    var_e098466f = 0;
    while (true) {
        var_7bf0773f = function_7bf0773f(local_client_num);
        if (is_true(var_e098466f) && !var_7bf0773f || !is_true(var_e098466f) && var_7bf0773f) {
            var_85098191 = function_5778f82(local_client_num, #"hash_410c46b5ff702c96");
            if (var_85098191) {
                players = getplayers(local_client_num);
                foreach (player in players) {
                    if (isdefined(player) && isalive(player)) {
                        player function_4fc900e1(local_client_num);
                    }
                }
            }
            var_e098466f = var_7bf0773f;
        }
        wait 0.25;
    }
}

// Namespace smokegrenade/smokegrenade
// Params 2, eflags: 0x0
// Checksum 0x3daec059, Offset: 0xae0
// Size: 0x1f0
function function_62ec0142(local_client_num, *bundle) {
    var_85098191 = function_5778f82(bundle, #"hash_410c46b5ff702c96");
    if (!var_85098191) {
        return false;
    }
    if (util::is_player_view_linked_to_entity(bundle)) {
        return false;
    }
    if (!self function_ca024039()) {
        return false;
    }
    if (function_7bf0773f(bundle)) {
        return false;
    }
    if (!(isdefined(self.insmoke) && self.insmoke & 2)) {
        return false;
    }
    localplayer = function_5c10bd79(bundle);
    if (self == localplayer) {
        curweapon = self function_d2c2b168();
        blade = getweapon(#"sig_blade");
        if (!isthirdperson(bundle) || curweapon != blade) {
            return false;
        }
    }
    weapon = getweapon("eq_smoke");
    if (isdefined(weapon.customsettings)) {
        var_ed9e87ac = getscriptbundle(weapon.customsettings);
        assert(isdefined(var_ed9e87ac));
        if (!(isdefined(var_ed9e87ac.var_563d4859) ? var_ed9e87ac.var_563d4859 : 0)) {
            return false;
        }
    }
    return true;
}

// Namespace smokegrenade/smokegrenade
// Params 2, eflags: 0x0
// Checksum 0x912b01c7, Offset: 0xcd8
// Size: 0x180
function function_28db726(local_client_num, *bundle) {
    var_85098191 = function_5778f82(bundle, #"hash_410c46b5ff702c96");
    if (!var_85098191) {
        return false;
    }
    if (util::is_player_view_linked_to_entity(bundle)) {
        return false;
    }
    if (self function_ca024039()) {
        return false;
    }
    if (function_7bf0773f(bundle)) {
        return false;
    }
    if (!(isdefined(self.insmoke) && self.insmoke & 1)) {
        return false;
    }
    weapon = getweapon("eq_smoke");
    if (isdefined(weapon.customsettings)) {
        var_ed9e87ac = getscriptbundle(weapon.customsettings);
        assert(isdefined(var_ed9e87ac));
        if ((isdefined(var_ed9e87ac.var_ae2b2941) ? var_ed9e87ac.var_ae2b2941 : 0) && self function_6c32d092(bundle, #"talent_coldblooded")) {
            return false;
        }
    }
    return true;
}

// Namespace smokegrenade/smokegrenade
// Params 7, eflags: 0x0
// Checksum 0xca08370b, Offset: 0xe60
// Size: 0x128
function vehicle_transition(local_client_num, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    players = getplayers(bwastimejump);
    foreach (player in players) {
        if (isalive(player)) {
            var_85098191 = function_5778f82(bwastimejump, #"hash_410c46b5ff702c96");
            if (var_85098191) {
                player function_4fc900e1(bwastimejump);
            }
        }
    }
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x2eddfa9f, Offset: 0xf90
// Size: 0x7c
function function_4fc900e1(local_client_num) {
    self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly_smoke", #"hash_8120ecc0ceec5c6");
    self renderoverridebundle::function_c8d97b8e(local_client_num, #"enemy_smoke", #"hash_224b6b4d7364dbb5");
}

// Namespace smokegrenade/smokegrenade
// Params 7, eflags: 0x0
// Checksum 0xa39711, Offset: 0x1018
// Size: 0x9c
function insmoke(local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    player = self;
    player.insmoke = bwastimejump;
    var_85098191 = function_5778f82(fieldname, #"hash_410c46b5ff702c96");
    if (var_85098191) {
        function_4fc900e1(fieldname);
    }
}

