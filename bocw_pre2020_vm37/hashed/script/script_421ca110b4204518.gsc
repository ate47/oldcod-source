#using script_24c32478acf44108;
#using script_72401f526ba71638;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_2ab93693;

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 0, eflags: 0x6
// Checksum 0x1ebe46a3, Offset: 0x218
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_662c938bd03bd1ad", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 0, eflags: 0x5 linked
// Checksum 0x19bb13c2, Offset: 0x268
// Size: 0x3d4
function private function_70a657d8() {
    clientfield::register("scriptmover", "" + #"hash_142ed640bf2e09b9", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_717ed5a81b281ebd", 1, 1, "counter");
    namespace_1b527536::function_36e0540e(#"hash_1d9cb9dbd298acba", 1, 35, "field_upgrade_ring_of_fire_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_631a223758cd92a", 1, 35, "field_upgrade_ring_of_fire_1_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_631a123758cd777", 1, 35, "field_upgrade_ring_of_fire_2_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_631a023758cd5c4", 1, 35, "field_upgrade_ring_of_fire_3_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_6319f23758cd411", 1, 35, "field_upgrade_ring_of_fire_4_item_sr");
    namespace_1b527536::function_36e0540e(#"hash_6319e23758cd25e", 1, 35, "field_upgrade_ring_of_fire_5_item_sr");
    namespace_1b527536::function_dbd391bf(#"hash_1d9cb9dbd298acba", &function_309daad7);
    namespace_1b527536::function_dbd391bf(#"hash_631a223758cd92a", &function_309daad7);
    namespace_1b527536::function_dbd391bf(#"hash_631a123758cd777", &function_309daad7);
    namespace_1b527536::function_dbd391bf(#"hash_631a023758cd5c4", &function_309daad7);
    namespace_1b527536::function_dbd391bf(#"hash_6319f23758cd411", &function_309daad7);
    namespace_1b527536::function_dbd391bf(#"hash_6319e23758cd25e", &function_309daad7);
    namespace_9ff9f642::register_burn(#"hash_1d9cb9dbd298acba", 25, 6);
    namespace_9ff9f642::register_burn(#"hash_631a223758cd92a", 25, 6);
    namespace_9ff9f642::register_burn(#"hash_631a123758cd777", 25, 6);
    namespace_9ff9f642::register_burn(#"hash_631a023758cd5c4", 25, 6);
    namespace_9ff9f642::register_burn(#"hash_6319f23758cd411", 25, 6);
    namespace_9ff9f642::register_burn(#"hash_6319e23758cd25e", 25, 6);
    zm_player::register_player_damage_callback(&function_961b66a1);
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 1, eflags: 0x1 linked
// Checksum 0x73952492, Offset: 0x648
// Size: 0x94
function function_309daad7(params) {
    self namespace_1b527536::function_460882e2();
    weapon = params.weapon;
    if (isdefined(params.projectile) && !isdefined(params.projectile.owner)) {
        params.projectile.owner = self;
    }
    self thread function_1cbc22b0(weapon, 175);
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 2, eflags: 0x5 linked
// Checksum 0x9f7937d9, Offset: 0x6e8
// Size: 0x64
function private function_baaff75b(var_cb73750, entity) {
    n_radius_sq = var_cb73750.n_radius * var_cb73750.n_radius;
    if (distance2dsquared(var_cb73750.origin, entity.origin) <= n_radius_sq) {
        return true;
    }
    return false;
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 2, eflags: 0x5 linked
// Checksum 0xff2b6501, Offset: 0x758
// Size: 0x824
function private function_1cbc22b0(weapon, n_radius) {
    var_d71041e1 = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];
    var_3889eb68 = util::spawn_model("tag_origin", var_d71041e1);
    var_3889eb68.owner = self;
    var_3889eb68.n_radius = n_radius;
    var_3889eb68.weapon = weapon;
    var_3889eb68.var_ed039c7 = 0;
    var_3889eb68.var_bb41cf71 = 0;
    var_3889eb68.var_ae326339 = 0;
    var_3889eb68.var_f51698e8 = 0;
    n_duration = 15;
    if (!isdefined(level.var_686c81d7)) {
        level.var_686c81d7 = [];
    }
    if (!isdefined(level.var_686c81d7)) {
        level.var_686c81d7 = [];
    } else if (!isarray(level.var_686c81d7)) {
        level.var_686c81d7 = array(level.var_686c81d7);
    }
    if (!isinarray(level.var_686c81d7, var_3889eb68)) {
        level.var_686c81d7[level.var_686c81d7.size] = var_3889eb68;
    }
    switch (weapon.name) {
    case #"hash_1d9cb9dbd298acba":
        break;
    case #"hash_631a223758cd92a":
        var_3889eb68 thread function_64a3f9c6(1);
        break;
    case #"hash_631a123758cd777":
        var_3889eb68 thread function_64a3f9c6(1);
        var_3889eb68.var_ed039c7 = 1;
        break;
    case #"hash_631a023758cd5c4":
        var_3889eb68 thread function_64a3f9c6(1, 1);
        var_3889eb68.var_ed039c7 = 1;
        break;
    case #"hash_6319f23758cd411":
        var_3889eb68 thread function_64a3f9c6(1, 1);
        var_3889eb68.var_ed039c7 = 1;
        var_3889eb68.var_bb41cf71 = 1;
        break;
    case #"hash_6319e23758cd25e":
        var_3889eb68 thread function_64a3f9c6(1, 1, 1);
        var_3889eb68.var_ed039c7 = 1;
        n_duration = 20;
        var_3889eb68.var_bb41cf71 = 1;
        break;
    }
    var_3889eb68.n_duration = n_duration;
    var_3889eb68 clientfield::set("" + #"hash_142ed640bf2e09b9", 1);
    for (n_timer = 0; n_timer <= n_duration; n_timer += 1) {
        /#
            var_1bc24030 = int(1 / float(function_60d95f53()) / 1000);
            if (getdvarint(#"hash_3ce5890428b398f1", 0)) {
                cylinder(var_3889eb68.origin, var_3889eb68.origin + (0, 0, 100), n_radius, (1, 0.5, 0), 0, var_1bc24030);
            }
        #/
        if (isdefined(self)) {
            a_ai = self getenemiesinradius(var_3889eb68.origin, n_radius);
            a_ai = arraysortclosest(a_ai, var_3889eb68.origin);
        } else {
            a_ai = getaiteamarray(level.zombie_team);
            a_ai = arraysortclosest(a_ai, var_3889eb68.origin, undefined, 0, n_radius);
        }
        if (var_3889eb68.var_f51698e8) {
            /#
                if (getdvarint(#"hash_3ce5890428b398f1", 0)) {
                    debug2dtext((500, 200, 0), "<dev string:x38>", (1, 0.5, 0), undefined, (0, 0, 0), undefined, 1, var_1bc24030);
                }
            #/
            var_477abb8f = 75;
            var_acfbb779 = 3;
        } else if (var_3889eb68.var_ae326339) {
            /#
                if (getdvarint(#"hash_3ce5890428b398f1", 0)) {
                    debug2dtext((500, 200, 0), "<dev string:x57>", (1, 0.5, 0), undefined, (0, 0, 0), undefined, 1, var_1bc24030);
                }
            #/
            var_477abb8f = 50;
            var_acfbb779 = 2;
        } else {
            var_477abb8f = undefined;
            var_acfbb779 = 1;
        }
        foreach (ai in a_ai) {
            if (isalive(ai)) {
                ai namespace_9ff9f642::burn(weapon.name, self, weapon, var_477abb8f);
                if (var_3889eb68.var_bb41cf71 && isdefined(ai.archetype) && isinarray(array(#"bat", #"dog", #"zombie_dog", #"zombie"), ai.archetype) && math::cointoss(10 * var_acfbb779)) {
                    ai.allowdeath = 1;
                    ai kill(var_3889eb68.origin, self, var_3889eb68, weapon);
                }
            }
        }
        wait 1;
    }
    arrayremovevalue(level.var_686c81d7, var_3889eb68);
    var_3889eb68 clientfield::set("" + #"hash_142ed640bf2e09b9", 0);
    var_3889eb68 thread util::delayed_delete(0.5);
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 3, eflags: 0x5 linked
// Checksum 0x4c0dfd31, Offset: 0xf88
// Size: 0x8c6
function private function_64a3f9c6(var_dfbbc9a0 = 0, var_feefd408 = 0, var_cf53ab1f = 0) {
    var_8ad82414 = 0;
    while (isdefined(self)) {
        var_5e907852 = getactorarray();
        foreach (ai in var_5e907852) {
            if (!isdefined(ai)) {
                continue;
            }
            if (!is_true(ai.var_25e2200c) && function_baaff75b(self, ai)) {
                ai clientfield::increment("" + #"hash_717ed5a81b281ebd", 1);
                ai.var_25e2200c = 1;
                continue;
            }
            if (is_true(ai.var_25e2200c) && !function_baaff75b(self, ai)) {
                ai.var_25e2200c = undefined;
            }
        }
        if (var_dfbbc9a0) {
            var_315c9351 = getentarraybytype(4);
            if (isarray(level.var_9ded2ca6)) {
                arrayremovevalue(level.var_9ded2ca6, undefined);
                var_315c9351 = arraycombine(var_315c9351, level.var_9ded2ca6);
            }
            foreach (missile in var_315c9351) {
                if (!isdefined(missile) || isplayer(missile.originalowner) || isplayer(missile.owner) || missile.team === self.owner.team) {
                    continue;
                }
                if (function_baaff75b(self, missile)) {
                    v_dir = missile.origin - self.origin;
                    v_dir = vectornormalize(v_dir);
                    if (v_dir[0] == 0) {
                        var_c51499f8 = 1;
                    } else {
                        var_c51499f8 = v_dir[0];
                    }
                    playfx(#"hash_2d3cd6bf4ac44fc0", missile.origin, (var_c51499f8, 0, 0), (0, 0, 1), 0, self.owner.team);
                    missile notify(#"hash_38b24dfa52842786");
                    missile delete();
                }
            }
        }
        if (var_feefd408) {
            a_players = getplayers();
            foreach (player in a_players) {
                if (isalive(player) && function_baaff75b(self, player)) {
                    w_current = player getcurrentweapon();
                    if (!player perks::perk_hasperk(#"specialty_ammodrainsfromstockfirst") && !is_true(w_current.isheroweapon) && !zm_weapons::is_wonder_weapon(w_current)) {
                        player perks::perk_setperk(#"specialty_ammodrainsfromstockfirst");
                    }
                    continue;
                }
                if (!function_baaff75b(self, player)) {
                    if (player perks::perk_hasperk(#"specialty_ammodrainsfromstockfirst")) {
                        player perks::perk_unsetperk(#"specialty_ammodrainsfromstockfirst");
                    }
                }
            }
        }
        if (var_cf53ab1f) {
            if (isalive(self.owner) && function_baaff75b(self, self.owner)) {
                if (var_8ad82414 >= 15) {
                    if (self.var_ae326339) {
                        self.var_f51698e8 = 1;
                        self.var_ae326339 = 0;
                        self playsound(#"hash_5e1e162af8490f1d");
                    }
                } else if (var_8ad82414 >= 7) {
                    if (!self.var_ae326339 && !self.var_f51698e8) {
                        self.var_f51698e8 = 0;
                        self.var_ae326339 = 1;
                        self playsound(#"hash_5e1e162af8490f1d");
                    }
                }
            } else {
                var_8ad82414 = 0;
                if (self.var_f51698e8 || self.var_ae326339) {
                    self.var_f51698e8 = 0;
                    self.var_ae326339 = 0;
                    self playsound(#"hash_73b66a25abec1fe4");
                }
            }
            var_8ad82414 += float(function_60d95f53()) / 1000;
        }
        waitframe(1);
    }
    if (var_feefd408) {
        a_players = getplayers();
        foreach (player in a_players) {
            if (player perks::perk_hasperk("specialty_ammodrainsfromstockfirst")) {
                player perks::perk_unsetperk("specialty_ammodrainsfromstockfirst");
            }
        }
    }
    var_5e907852 = getactorarray();
    foreach (ai in var_5e907852) {
        if (!isdefined(ai)) {
            continue;
        }
        if (is_true(ai.var_25e2200c)) {
            ai.var_25e2200c = undefined;
        }
    }
}

// Namespace namespace_2ab93693/namespace_2ab93693
// Params 10, eflags: 0x5 linked
// Checksum 0x374e798b, Offset: 0x1858
// Size: 0x18c
function private function_961b66a1(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *sweapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (isarray(level.var_686c81d7)) {
        foreach (var_3889eb68 in level.var_686c81d7) {
            if (var_3889eb68.var_ed039c7 && function_baaff75b(var_3889eb68, self)) {
                if (var_3889eb68.var_f51698e8) {
                    var_8a90b7a2 = 3;
                } else if (var_3889eb68.var_ae326339) {
                    var_8a90b7a2 = 2;
                } else {
                    var_8a90b7a2 = 1;
                }
                psoffsettime -= psoffsettime * 0.3 * var_8a90b7a2;
                if (psoffsettime < 0) {
                    psoffsettime = 0;
                }
                return int(psoffsettime);
            }
        }
    }
    return -1;
}

