#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_spectral_shield;

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x2
// Checksum 0x47e8c0c4, Offset: 0x370
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_weap_spectral_shield", &__init__, &__main__, undefined);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0xbf14d630, Offset: 0x3c0
// Size: 0x49c
function __init__() {
    level.var_3d9066fe = getweapon(#"zhield_spectral_turret");
    level.var_b258bbfd = getweapon(#"zhield_spectral_dw");
    level.var_cc1a6c85 = getweapon(#"zhield_spectral_turret_upgraded");
    level.var_42c2d7ca = getweapon(#"zhield_spectral_dw_upgraded");
    level.var_ef455672 = &function_62739726;
    level.var_e551c78f = &function_a36e1e65;
    level.riotshield_melee_power = &melee_power;
    level.var_c2531c4a = &zombie_knockdown;
    level.var_cf0e6db1 = [];
    level.var_cf0e6db1[level.var_cf0e6db1.size] = "guts";
    level.var_cf0e6db1[level.var_cf0e6db1.size] = "right_arm";
    level.var_cf0e6db1[level.var_cf0e6db1.size] = "left_arm";
    level.var_b4b81bee = [];
    clientfield::register("allplayers", "afterlife_vision_play", 1, 1, "int");
    clientfield::register("toplayer", "afterlife_window", 1, 1, "int");
    clientfield::register("scriptmover", "afterlife_entity_visibility", 1, 2, "int");
    clientfield::register("allplayers", "spectral_key_beam_fire", 1, 1, "int");
    clientfield::register("allplayers", "spectral_key_beam_flash", 1, 2, "int");
    n_bits = getminbitcountfornum(4);
    clientfield::register("actor", "zombie_spectral_key_stun", 1, n_bits, "int");
    clientfield::register("vehicle", "zombie_spectral_key_stun", 1, n_bits, "int");
    clientfield::register("scriptmover", "zombie_spectral_key_stun", 1, n_bits, "int");
    clientfield::register("scriptmover", "spectral_key_essence", 1, 1, "int");
    clientfield::register("allplayers", "spectral_key_charging", 1, 2, "int");
    clientfield::register("allplayers", "spectral_shield_blast", 1, 1, "counter");
    clientfield::register("scriptmover", "shield_crafting_fx", 1, 1, "counter");
    clientfield::register("actor", "spectral_blast_death", 1, 1, "int");
    zm_utility::register_slowdown(#"hash_119644e9a557f4e9", 0.5, 1);
    callback::on_ai_killed(&function_e2bdf4b0);
    callback::on_connect(&function_3385211a);
    zm::register_zombie_damage_override_callback(&function_abc04d76);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0x305f6be7, Offset: 0x868
// Size: 0x34
function __main__() {
    /#
        level thread function_4b519fe5();
    #/
    level thread function_a35aae2b();
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0x4e081f6d, Offset: 0x8a8
// Size: 0x2c
function function_3385211a() {
    self.var_65f7ac63 = 0;
    self callback::function_c4f1b25e(&function_c4f1b25e);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x82709d48, Offset: 0x8e0
// Size: 0x6e
function function_fa783e7(w_current) {
    if (w_current === level.var_b258bbfd || w_current === level.var_42c2d7ca) {
        return true;
    }
    if (w_current === level.var_3d9066fe || w_current === level.var_cc1a6c85) {
        return true;
    }
    return false;
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0x48408e28, Offset: 0x958
// Size: 0x186
function private function_c4f1b25e(eventstruct) {
    if (eventstruct.weapon === level.var_b258bbfd || eventstruct.weapon === level.var_42c2d7ca) {
        if (eventstruct.event === "give_weapon") {
            if (eventstruct.weapon === level.var_b258bbfd) {
                self.var_65f7ac63 = 0;
            }
            if (eventstruct.weapon === level.var_b258bbfd) {
                self setweaponammoclip(level.var_3d9066fe, 0);
                self.var_146f6928 = 2;
            } else {
                self setweaponammoclip(level.var_cc1a6c85, 0);
                self.var_146f6928 = 4;
            }
            self thread function_7362ef5e();
            return;
        }
        if (eventstruct.event === "take_weapon") {
            if (eventstruct.weapon === level.var_42c2d7ca) {
                self.var_65f7ac63 = 0;
            }
            if (function_fa783e7(eventstruct.weapon)) {
                self thread function_78096d70(0);
            }
            self notify(#"hash_1a22e1dd781f58d6");
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0x66e99edc, Offset: 0xae8
// Size: 0x1bc
function function_62739726() {
    w_current = self getcurrentweapon();
    self thread function_b7bd4e40(w_current);
    if (w_current == level.var_42c2d7ca || w_current == level.var_b258bbfd) {
        zm_hero_weapon::show_hint(w_current, #"hash_1656aebadea29360");
        self playsoundtoplayer(#"hash_6a9b5c781d4019b2", self);
    }
    if (w_current == level.var_42c2d7ca) {
        self.var_146f6928 = 4;
    } else if (w_current == level.var_b258bbfd) {
        self.var_146f6928 = 2;
    }
    if (!self clientfield::get_to_player("afterlife_window")) {
        self clientfield::set_to_player("afterlife_window", 1);
    }
    if (w_current == level.var_3d9066fe || w_current == level.var_cc1a6c85) {
        if (self clientfield::get("spectral_key_charging")) {
            zm_hero_weapon::show_hint(w_current, #"hash_7c3a1b7b56c4fac1");
        }
        self thread function_78096d70(1);
        return;
    }
    self thread function_78096d70(0);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0x22b901e2, Offset: 0xcb0
// Size: 0xa4
function function_a36e1e65() {
    self clientfield::set_to_player("afterlife_window", 0);
    self notify(#"hash_1b7c4bada7fa6175");
    if (function_fa783e7(self.previousweapon)) {
        self playsoundtoplayer(#"hash_6632e419b4028fc4", self);
    }
    self thread function_78096d70(0);
    self thread function_dea8d9ae(1);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x23267f05, Offset: 0xd60
// Size: 0xd4
function function_e2bdf4b0(s_params) {
    if (self clientfield::get("zombie_spectral_key_stun")) {
        self clientfield::set("zombie_spectral_key_stun", 0);
    }
    if (isplayer(s_params.eattacker) && (s_params.weapon == level.var_b258bbfd || s_params.weapon == level.var_42c2d7ca) && s_params.smeansofdeath === "MOD_ELECTROCUTED") {
        s_params.eattacker thread function_dd876e3c(self);
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 13, eflags: 0x0
// Checksum 0xfe58c0d9, Offset: 0xe40
// Size: 0x1d8
function function_abc04d76(willbekilled, einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (self clientfield::get("zombie_spectral_key_stun") && meansofdeath !== "MOD_ELECTROCUTED") {
        return 0;
    }
    if (isplayer(eattacker) && function_fa783e7(weapon)) {
        if (meansofdeath !== "MOD_IMPACT" && meansofdeath !== "MOD_ELECTROCUTED") {
            return 0;
        }
        if (self.animname === "zombie_eaten" && !(isdefined(self.allowdeath) && self.allowdeath) && self.health <= 1) {
            if ((weapon == level.var_b258bbfd || weapon == level.var_42c2d7ca) && meansofdeath === "MOD_ELECTROCUTED") {
                if (self clientfield::get("zombie_spectral_key_stun")) {
                    self clientfield::set("zombie_spectral_key_stun", 0);
                }
                eattacker thread function_dd876e3c(self);
            }
        }
    }
    return idamage;
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0x7133f809, Offset: 0x1020
// Size: 0x32e
function private function_dd876e3c(ai_zombie) {
    self endon(#"disconnect");
    v_pos = ai_zombie getcentroid();
    var_b44c4d3d = util::spawn_model("tag_origin", v_pos + (0, 0, 12), ai_zombie.angles);
    var_b44c4d3d clientfield::set("spectral_key_essence", 1);
    var_b44c4d3d playsound(#"zmb_sq_souls_release");
    n_dist = distance(var_b44c4d3d.origin, self gettagorigin("tag_weapon_right"));
    n_move_time = n_dist / 1200;
    n_dist_sq = distance2dsquared(var_b44c4d3d.origin, self gettagorigin("tag_weapon_right"));
    n_start_time = gettime();
    n_total_time = 0;
    while (n_dist_sq > 1024 && isalive(self)) {
        var_b44c4d3d moveto(self gettagorigin("tag_weapon_right"), n_move_time);
        wait 0.1;
        if (isalive(self)) {
            n_current_time = gettime();
            n_total_time = (n_current_time - n_start_time) / 1000;
            n_move_time = self function_a12ca473(var_b44c4d3d, n_total_time);
            if (n_move_time == 0) {
                break;
            }
            n_dist_sq = distance2dsquared(var_b44c4d3d.origin, self geteye());
        }
    }
    var_b44c4d3d clientfield::set("spectral_key_essence", 0);
    var_b44c4d3d playsound(#"zmb_sq_souls_impact");
    wait 0.5;
    var_b44c4d3d delete();
    self.var_65f7ac63 = math::clamp(self.var_65f7ac63 + 1, 0, self.var_146f6928 * 3);
    self thread function_dea8d9ae();
    self notify(#"hash_22a49f7903e394a5");
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 2, eflags: 0x0
// Checksum 0x38363397, Offset: 0x1358
// Size: 0x12c
function function_a12ca473(var_b44c4d3d, n_total_time) {
    if (n_total_time >= 2.5) {
        return 0;
    }
    if (n_total_time < 0.25) {
        var_dd160c2d = 0.25 - n_total_time;
        var_dd160c2d = var_dd160c2d < 0.05 ? 0.05 : var_dd160c2d;
    } else {
        var_dd160c2d = 0.05;
    }
    var_e3817aa9 = n_total_time * 0.25;
    var_388061ea = 1200 + 1200 * var_e3817aa9;
    n_dist = distance(var_b44c4d3d.origin, self geteye());
    n_move_time = n_dist / var_388061ea;
    n_move_time = n_move_time < var_dd160c2d ? var_dd160c2d : n_move_time;
    return n_move_time;
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0x142d414a, Offset: 0x1490
// Size: 0x246
function function_7362ef5e() {
    self endon(#"disconnect");
    var_e36a98a4 = self.var_146f6928 * 3;
    while (true) {
        s_result = self waittill(#"hash_22a49f7903e394a5", #"hash_1a22e1dd781f58d6", #"weapon_change", #"weapon_change_complete");
        var_ceb9925d = self clientfield::get("spectral_key_charging");
        if ((s_result._notify == "weapon_change" || s_result._notify == "weapon_change_complete") && !(isdefined(function_fa783e7(s_result.weapon)) && function_fa783e7(s_result.weapon))) {
            if (var_ceb9925d != 0) {
                self clientfield::set("spectral_key_charging", 0);
            }
            continue;
        }
        if (self.var_65f7ac63 >= var_e36a98a4) {
            if (var_ceb9925d != 2) {
                self clientfield::set("spectral_key_charging", 2);
                self thread zm_audio::create_and_play_dialog("shield", "charged", undefined, 1);
            }
        } else if (self.var_65f7ac63 >= 3) {
            if (var_ceb9925d != 1) {
                self clientfield::set("spectral_key_charging", 1);
            }
        } else if (var_ceb9925d != 0) {
            self clientfield::set("spectral_key_charging", 0);
        }
        if (s_result._notify === #"hash_1a22e1dd781f58d6") {
            return;
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0xe16cfead, Offset: 0x16e0
// Size: 0x154
function function_78096d70(b_enabled) {
    self endon(#"death");
    if (isdefined(b_enabled) && b_enabled) {
        if (!self clientfield::get("afterlife_vision_play")) {
            self clientfield::set("afterlife_vision_play", 1);
            self.snd_ent = spawn("script_origin", self.origin);
            self.snd_ent linkto(self);
            self.snd_ent playloopsound(#"hash_197dd6d18afad004");
        }
        return;
    }
    if (self clientfield::get("afterlife_vision_play")) {
        self clientfield::set("afterlife_vision_play", 0);
    }
    if (isdefined(self.snd_ent)) {
        self.snd_ent stoploopsound();
        self.snd_ent delete();
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0x8035c41e, Offset: 0x1840
// Size: 0x44
function function_92f68f2f() {
    level flag::wait_till("start_zombie_round_logic");
    self clientfield::set("afterlife_entity_visibility", 1);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x2a879a7a, Offset: 0x1890
// Size: 0x144
function melee_power(weapon) {
    if (self.var_65f7ac63 >= 3 && (weapon == level.var_3d9066fe || weapon == level.var_cc1a6c85)) {
        self clientfield::increment("spectral_shield_blast", 1);
        self playsound(#"hash_4fa7a7bff648310f");
        self.var_65f7ac63 = math::clamp(self.var_65f7ac63 - 3, 0, self.var_146f6928 * 3);
        self thread function_dea8d9ae();
        self notify(#"hash_22a49f7903e394a5");
        self thread function_66acba51();
        self thread function_ec74ee3a();
        self function_718436b1();
        return;
    }
    riotshield::riotshield_melee(weapon);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x4
// Checksum 0x1a4a9c48, Offset: 0x19e0
// Size: 0x1ac
function private function_66acba51() {
    self endon(#"death");
    a_e_afterlife = getentarray("blast_attack_interactables", "script_noteworthy");
    foreach (e_afterlife in a_e_afterlife) {
        n_dist_sq = distancesquared(e_afterlife.origin, self.origin);
        if (n_dist_sq < 262144) {
            var_7dda366c = self getweaponmuzzlepoint();
            v_normal = vectornormalize(e_afterlife.origin - var_7dda366c);
            var_9c5bd97c = self getweaponforwarddir();
            n_dot = vectordot(var_9c5bd97c, v_normal);
            if (n_dot > 0.61) {
                e_afterlife notify(#"blast_attack", {#e_player:self});
            }
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x4
// Checksum 0x32e7e73e, Offset: 0x1b98
// Size: 0x248
function private function_ec74ee3a() {
    var_7dda366c = self getweaponmuzzlepoint();
    v_forward_angles = self getweaponforwarddir();
    if (level.players.size == 1) {
        return;
    }
    foreach (e_player in level.players) {
        if (e_player == self) {
            continue;
        }
        n_dist_sq = distancesquared(e_player.origin, self.origin);
        if (n_dist_sq < 262144 && isdefined(e_player sightconetrace(var_7dda366c, self, v_forward_angles, 25)) && e_player sightconetrace(var_7dda366c, self, v_forward_angles, 25)) {
            if (e_player laststand::player_is_in_laststand()) {
                if (self zm_laststand::can_revive(e_player, 1, 1)) {
                    if (isdefined(e_player.revivetrigger) && isdefined(e_player.revivetrigger.beingrevived)) {
                        e_player.revivetrigger setinvisibletoall();
                        e_player.revivetrigger.beingrevived = 0;
                    }
                    e_player zm_laststand::auto_revive(self);
                    self notify(#"hash_6db9af45fe6345fc");
                }
                continue;
            }
            e_player function_5aeadec8(50);
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0xb7c992e7, Offset: 0x1de8
// Size: 0x3c
function private function_5aeadec8(n_armor) {
    self thread zm_utility::add_armor(#"hash_e03c12b01d03809", n_armor, 50);
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0x586ceda4, Offset: 0x1e30
// Size: 0x16e
function private function_718436b1(n_clientfield) {
    if (!isdefined(level.var_3d04da1f)) {
        level.var_3d04da1f = [];
        level.var_f6e8e865 = [];
        level.var_9ae95281 = [];
        level.var_c7431976 = [];
    }
    self function_2cd0fb95();
    self.var_4c087541 = 0;
    for (i = 0; i < level.var_9ae95281.size; i++) {
        level.var_9ae95281[i] thread function_2cabe61d(self, level.var_c7431976[i], i);
    }
    for (i = 0; i < level.var_3d04da1f.size; i++) {
        level.var_3d04da1f[i] thread function_aad61863(self, level.var_f6e8e865[i]);
    }
    self notify(#"hash_5ac00f85b943ba5f", self.var_4c087541);
    level.var_3d04da1f = [];
    level.var_f6e8e865 = [];
    level.var_9ae95281 = [];
    level.var_c7431976 = [];
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0x70ec8413, Offset: 0x1fa8
// Size: 0x618
function function_2cd0fb95() {
    var_7dda366c = self getweaponmuzzlepoint();
    a_zombies = array::get_all_closest(var_7dda366c, getaiteamarray(level.zombie_team), undefined, undefined, 1200);
    if (!a_zombies.size) {
        return;
    }
    var_4d852309 = 1440000;
    var_47565d03 = 1048576;
    n_fling_range_sq = 262144;
    var_ef2ca486 = 32400;
    var_f1ac3847 = 9216;
    var_ee612bb1 = 9216;
    var_9c5bd97c = self getweaponforwarddir();
    v_end_pos = var_7dda366c + vectorscale(var_9c5bd97c, 1200);
    for (i = 0; i < a_zombies.size; i++) {
        if (!isalive(a_zombies[i])) {
            continue;
        }
        v_zombie_origin = a_zombies[i] getcentroid();
        var_66a9d972 = distancesquared(var_7dda366c, v_zombie_origin);
        if (var_66a9d972 > var_4d852309) {
            return;
        }
        normal = vectornormalize(v_zombie_origin - var_7dda366c);
        dot = vectordot(var_9c5bd97c, normal);
        if (var_66a9d972 < var_ee612bb1) {
            level.var_9ae95281[level.var_9ae95281.size] = a_zombies[i];
            dist_mult = 1;
            fling_vec = vectornormalize(v_zombie_origin - var_7dda366c);
            fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
            fling_vec = vectorscale(fling_vec, 50 + 50 * dist_mult);
            level.var_c7431976[level.var_c7431976.size] = fling_vec;
            continue;
        } else if (var_66a9d972 < var_f1ac3847 && 0 > dot) {
            if (!isdefined(a_zombies[i].var_73b36dab)) {
                a_zombies[i].var_73b36dab = level.var_c2531c4a;
            }
            level.var_3d04da1f[level.var_3d04da1f.size] = a_zombies[i];
            level.var_f6e8e865[level.var_f6e8e865.size] = 0;
            continue;
        }
        if (0 > dot) {
            continue;
        }
        radial_origin = pointonsegmentnearesttopoint(var_7dda366c, v_end_pos, v_zombie_origin);
        if (distancesquared(v_zombie_origin, radial_origin) > var_ef2ca486) {
            continue;
        }
        if (0 == a_zombies[i] damageconetrace(var_7dda366c, self)) {
            continue;
        }
        a_zombies[i].var_56429f59 = 1.1 * sqrt(var_66a9d972) / 1200;
        if (var_66a9d972 < n_fling_range_sq) {
            level.var_9ae95281[level.var_9ae95281.size] = a_zombies[i];
            dist_mult = (n_fling_range_sq - var_66a9d972) / n_fling_range_sq;
            fling_vec = vectornormalize(v_zombie_origin - var_7dda366c);
            if (5000 < var_66a9d972) {
                fling_vec += vectornormalize(v_zombie_origin - radial_origin);
            }
            fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
            fling_vec = vectorscale(fling_vec, 50 + 50 * dist_mult);
            level.var_c7431976[level.var_c7431976.size] = fling_vec;
            continue;
        }
        if (var_66a9d972 < var_47565d03) {
            if (!isdefined(a_zombies[i].var_73b36dab)) {
                a_zombies[i].var_73b36dab = level.var_c2531c4a;
            }
            level.var_3d04da1f[level.var_3d04da1f.size] = a_zombies[i];
            level.var_f6e8e865[level.var_f6e8e865.size] = 1;
            continue;
        }
        if (!isdefined(a_zombies[i].var_73b36dab)) {
            a_zombies[i].var_73b36dab = level.var_c2531c4a;
        }
        level.var_3d04da1f[level.var_3d04da1f.size] = a_zombies[i];
        level.var_f6e8e865[level.var_f6e8e865.size] = 0;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 3, eflags: 0x0
// Checksum 0x3b57bdb5, Offset: 0x25c8
// Size: 0x18c
function function_2cabe61d(player, fling_vec, index) {
    delay = self.var_56429f59;
    if (isdefined(delay) && delay > 0.05) {
        wait delay;
    }
    if (!isalive(self)) {
        return;
    }
    if (isdefined(self.var_7bd92455)) {
        self [[ self.var_7bd92455 ]](player);
        return;
    }
    if (self.var_29ed62b2 === #"basic") {
        if (!(isdefined(self.gibbed) && self.gibbed) && !(isdefined(self.no_gib) && self.no_gib)) {
            self zombie_utility::gib_random_parts();
        }
        self zombie_utility::setup_zombie_knockdown(player);
    }
    self function_db39ce6f(player);
    if (self.health <= 0) {
        if (!(isdefined(self.no_damage_points) && self.no_damage_points)) {
            points = 10;
            if (1 == index) {
                points = 30;
            }
        }
        self.var_7584fb70 = 1;
        player.var_4c087541++;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 2, eflags: 0x0
// Checksum 0x88b58f5d, Offset: 0x2760
// Size: 0x1c8
function zombie_knockdown(player, gib) {
    delay = self.var_56429f59;
    if (isdefined(delay) && delay > 0.05) {
        wait delay;
    }
    if (!isalive(self)) {
        return;
    }
    if (!isvehicle(self)) {
        if (gib && !(isdefined(self.gibbed) && self.gibbed)) {
            self.a.gib_ref = array::random(level.var_cf0e6db1);
            self thread zombie_death::do_gib();
        } else {
            self zombie_utility::setup_zombie_knockdown(player);
        }
    }
    if (isdefined(level.var_fa9e5965)) {
        self [[ level.var_fa9e5965 ]](player, gib);
        return;
    }
    if (self.health < 15 && self.var_29ed62b2 !== #"popcorn") {
        self clientfield::set("spectral_blast_death", 1);
    }
    self dodamage(15, player.origin, player, player, undefined, "MOD_IMPACT", 0, player getcurrentweapon());
    if (self.health <= 0) {
        player.var_4c087541++;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0xa4d74a8e, Offset: 0x2930
// Size: 0x17c
function function_db39ce6f(e_attacker) {
    if (isdefined(self)) {
        if (isplayer(e_attacker)) {
            w_damage = e_attacker getcurrentweapon();
        } else {
            w_damage = undefined;
        }
        if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
            self thread zm_utility::function_447d3917(#"hash_119644e9a557f4e9");
            self dodamage(self.maxhealth * 0.1, e_attacker.origin, e_attacker, e_attacker, "torso_lower", "MOD_IMPACT", 0, w_damage);
            return;
        }
        if (self.var_29ed62b2 !== #"popcorn") {
            self clientfield::set("spectral_blast_death", 1);
        }
        self dodamage(self.health + 666, e_attacker.origin, e_attacker, e_attacker, undefined, "MOD_IMPACT", 0, w_damage);
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 2, eflags: 0x0
// Checksum 0xf85dd808, Offset: 0x2ab8
// Size: 0x64
function function_aad61863(player, gib) {
    self endon(#"death");
    if (!isalive(self)) {
        return;
    }
    if (isdefined(self.var_73b36dab)) {
        self [[ self.var_73b36dab ]](player, gib);
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0xba3e5449, Offset: 0x2b28
// Size: 0x1b8
function private function_b7bd4e40(var_7c5230bb) {
    self endoncallback(&function_3f8a930b, #"weapon_change", #"bled_out", #"disconnect", #"hash_1b7c4bada7fa6175");
    self thread function_dea8d9ae();
    while (true) {
        self waittill(#"weapon_fired");
        self clientfield::set("spectral_key_beam_fire", 1);
        self clientfield::set("spectral_key_beam_flash", 1);
        self thread function_5622c67d(var_7c5230bb);
        while (zm_utility::is_player_valid(self) && self attackbuttonpressed() && !self fragbuttonpressed()) {
            waitframe(1);
        }
        self.var_2aeb2774 = undefined;
        self clientfield::set("spectral_key_beam_fire", 0);
        self clientfield::set("spectral_key_beam_flash", 0);
        self notify(#"hash_7a5ea8904c04f16b");
        self thread function_dea8d9ae();
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0x1946c7ef, Offset: 0x2ce8
// Size: 0x8e
function private function_3f8a930b(var_e34146dc) {
    if (var_e34146dc == #"hash_1b7c4bada7fa6175" || var_e34146dc == "weapon_change") {
        self.var_2aeb2774 = undefined;
        self clientfield::set("spectral_key_beam_fire", 0);
        self clientfield::set("spectral_key_beam_flash", 0);
        self notify(#"hash_7a5ea8904c04f16b");
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x73c89602, Offset: 0x2d80
// Size: 0x714
function function_5622c67d(w_curr) {
    self endon(#"disconnect", #"hash_7a5ea8904c04f16b");
    n_dist_sq_max = 173056;
    while (true) {
        var_c18b4417 = 0;
        v_position = self getweaponmuzzlepoint();
        v_forward = self getweaponforwarddir();
        a_trace = beamtrace(v_position, v_position + v_forward * 416, 1, self);
        if (isdefined(a_trace[#"position"])) {
            n_dist_sq = distancesquared(self.origin, a_trace[#"position"]);
            if (n_dist_sq > n_dist_sq_max) {
                a_trace[#"entity"] = undefined;
            }
        }
        ai_zombie_target = self function_d1b5241e(w_curr, n_dist_sq_max);
        if (isdefined(a_trace[#"entity"]) || isdefined(ai_zombie_target)) {
            if (isdefined(ai_zombie_target)) {
                self.var_2aeb2774 = ai_zombie_target;
            } else if (isdefined(a_trace[#"entity"])) {
                self.var_2aeb2774 = a_trace[#"entity"];
            }
            e_last_target = self.var_2aeb2774;
            if (isai(e_last_target)) {
                self notify(#"hash_6ce63d9afba84f4c");
                if (!isdefined(e_last_target.maxhealth)) {
                    e_last_target.maxhealth = e_last_target.health;
                }
                if (isdefined(e_last_target.var_e1e2f768)) {
                    if (!(isdefined(e_last_target.var_65bbe67a) && e_last_target.var_65bbe67a)) {
                        e_last_target thread [[ e_last_target.var_e1e2f768 ]](self);
                    }
                } else {
                    switch (e_last_target.var_29ed62b2) {
                    case #"basic":
                        if (!isdefined(e_last_target.var_23292df)) {
                            e_last_target.var_23292df = e_last_target function_c1310f97();
                        }
                        if (!(isdefined(e_last_target.var_65bbe67a) && e_last_target.var_65bbe67a)) {
                            e_last_target thread function_54a22d90(self);
                            waitframe(1);
                        }
                        e_last_target dodamage(e_last_target.var_23292df, e_last_target getcentroid(), self, self, "torso_lower", "MOD_ELECTROCUTED");
                        break;
                    case #"heavy":
                    case #"miniboss":
                    case #"boss":
                        e_last_target dodamage(e_last_target.maxhealth * 0.01, e_last_target getcentroid(), self, self, "torso_lower", "MOD_ELECTROCUTED");
                        if (!(isdefined(e_last_target.var_65bbe67a) && e_last_target.var_65bbe67a)) {
                            e_last_target thread function_e8d2c355(self);
                        }
                        break;
                    case #"popcorn":
                        if (!isdefined(e_last_target.var_23292df)) {
                            e_last_target.var_23292df = e_last_target function_c1310f97();
                        }
                        if (!(isdefined(e_last_target.var_65bbe67a) && e_last_target.var_65bbe67a)) {
                            e_last_target thread function_e0d3bf15(self);
                        }
                        e_last_target dodamage(e_last_target.var_23292df, e_last_target getcentroid(), self, self, undefined, "MOD_ELECTROCUTED");
                        break;
                    default:
                        e_last_target dodamage(e_last_target.maxhealth * 0.01, e_last_target.origin, self, self, undefined, "MOD_ELECTROCUTED");
                        break;
                    }
                }
            } else if (function_a5354464(e_last_target)) {
                self notify(#"hash_6ce63d9afba84f4c");
                e_last_target dodamage(10, e_last_target.origin, self, self, undefined, "MOD_ELECTROCUTED");
            } else if (isdefined(level.var_b4b81bee)) {
                foreach (key_func in level.var_b4b81bee) {
                    if (!isdefined(e_last_target.var_4e954263)) {
                        self thread [[ key_func ]](e_last_target);
                        continue;
                    }
                    e_last_target notify(#"hash_2afc3e42ad78d30e");
                }
            }
        } else {
            self.var_2aeb2774 = undefined;
            var_c18b4417 = 0;
            switch (a_trace[#"surfacetype"]) {
            case #"glasscar":
            case #"rock":
            case #"metal":
            case #"metalcar":
            case #"glass":
                var_c18b4417 = 1;
                var_9449eaa2 = "reflective_geo";
                break;
            }
        }
        e_last_target = undefined;
        wait 0.1;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x4
// Checksum 0x2683f97a, Offset: 0x34a0
// Size: 0xc8
function private function_c1310f97() {
    if (self.var_29ed62b2 == #"popcorn") {
        var_d98a010d = 10;
    } else if (level.round_number < 16) {
        var_507fce19 = 2 / 16;
        var_efdf36d3 = (level.round_number - 1) * var_507fce19 + 2;
        var_d98a010d = var_efdf36d3 / 0.1;
    } else {
        var_d98a010d = 40;
    }
    n_damage = self.maxhealth / var_d98a010d;
    return n_damage;
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 2, eflags: 0x0
// Checksum 0x28765e3, Offset: 0x3570
// Size: 0x2f8
function function_d1b5241e(w_curr, n_dist_sq_max) {
    var_7dda366c = self getweaponmuzzlepoint();
    v_forward_angles = self getweaponforwarddir();
    if (isdefined(self.var_2aeb2774) && isdefined(self.var_2aeb2774 sightconetrace(var_7dda366c, self, v_forward_angles, 25)) && self.var_2aeb2774 sightconetrace(var_7dda366c, self, v_forward_angles, 25)) {
        return self.var_2aeb2774;
    }
    if (isdefined(level.var_9cdf0277)) {
        n_dist_sq = distancesquared(self.origin, level.var_9cdf0277.origin);
        if (n_dist_sq < n_dist_sq_max) {
            if (isdefined(level.var_9cdf0277 sightconetrace(var_7dda366c, self, v_forward_angles, 25)) && level.var_9cdf0277 sightconetrace(var_7dda366c, self, v_forward_angles, 25)) {
                return level.var_9cdf0277;
            }
        }
    }
    var_4fea511c = getaiteamarray(level.zombie_team);
    a_ai_zombies = arraysortclosest(var_4fea511c, var_7dda366c, 12);
    for (i = 0; i < a_ai_zombies.size; i++) {
        n_dist_sq = distancesquared(self.origin, a_ai_zombies[i].origin);
        if (n_dist_sq < n_dist_sq_max) {
            if (isdefined(a_ai_zombies[i] sightconetrace(var_7dda366c, self, v_forward_angles, 25) && isdefined(a_ai_zombies[i].allowdeath) && a_ai_zombies[i].allowdeath) && a_ai_zombies[i] sightconetrace(var_7dda366c, self, v_forward_angles, 25) && isdefined(a_ai_zombies[i].allowdeath) && a_ai_zombies[i].allowdeath) {
                return a_ai_zombies[i];
            }
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0x1c8a1f46, Offset: 0x3870
// Size: 0x376
function function_54a22d90(e_attacker) {
    self notify(#"hash_3f91506396266ee6");
    self endon(#"hash_3f91506396266ee6");
    e_attacker endon(#"disconnect");
    if (isdefined(self.aat_turned) && self.aat_turned || !isalive(self)) {
        return;
    }
    self.var_65bbe67a = 1;
    self ai::stun();
    self.instakill_func = &function_847b41da;
    if (!self clientfield::get("zombie_spectral_key_stun")) {
        var_382c276e = e_attacker getentitynumber();
        self clientfield::set("zombie_spectral_key_stun", var_382c276e + 1);
        e_attacker clientfield::set("spectral_key_beam_flash", 2);
        self zombie_utility::zombie_eye_glow_stop();
        if (self.var_29ed62b2 == #"basic") {
            bhtnactionstartevent(self, "electrocute");
        }
    }
    while (e_attacker.var_2aeb2774 === self && isalive(self)) {
        if (self.health <= self.maxhealth * 0.5 && !(isdefined(self.is_floating) && self.is_floating)) {
            self thread scene::play(#"aib_tplt_zombie_base_dth_f_float_notrans_01", self);
            self.is_floating = 1;
        }
        waitframe(1);
    }
    if (isdefined(self) && isdefined(self.is_floating) && self.is_floating) {
        self thread scene::stop(#"aib_tplt_zombie_base_dth_f_float_notrans_01");
        self.is_floating = undefined;
    }
    var_621a0307 = e_attacker clientfield::get("spectral_key_beam_flash");
    if (e_attacker attackbuttonpressed() && var_621a0307 === 2) {
        e_attacker clientfield::set("spectral_key_beam_flash", 1);
    }
    if (isalive(self)) {
        if (self clientfield::get("zombie_spectral_key_stun")) {
            self clientfield::set("zombie_spectral_key_stun", 0);
        }
        self.var_65bbe67a = 0;
        self ai::clear_stun();
        self zombie_utility::zombie_eye_glow();
        self.instakill_func = undefined;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 3, eflags: 0x4
// Checksum 0xcd751364, Offset: 0x3bf0
// Size: 0x5e
function private function_847b41da(e_player, mod, shitloc) {
    w_current = e_player getcurrentweapon();
    if (function_fa783e7(w_current)) {
        return true;
    }
    return false;
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0xf0c93a1e, Offset: 0x3c58
// Size: 0x1de
function function_e8d2c355(e_attacker) {
    self notify(#"hash_3c2776b4262d3359");
    self endon(#"hash_3c2776b4262d3359", #"death");
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    self.var_65bbe67a = 1;
    if (!self clientfield::get("zombie_spectral_key_stun")) {
        var_382c276e = e_attacker getentitynumber();
        self clientfield::set("zombie_spectral_key_stun", var_382c276e + 1);
        e_attacker clientfield::set("spectral_key_beam_flash", 2);
    }
    while (e_attacker.var_2aeb2774 === self && isalive(self)) {
        waitframe(1);
    }
    var_621a0307 = e_attacker clientfield::get("spectral_key_beam_flash");
    if (e_attacker attackbuttonpressed() && var_621a0307 === 2) {
        e_attacker clientfield::set("spectral_key_beam_flash", 1);
    }
    if (isdefined(self)) {
        if (self clientfield::get("zombie_spectral_key_stun")) {
            self clientfield::set("zombie_spectral_key_stun", 0);
        }
        self.var_65bbe67a = 0;
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x4
// Checksum 0xa98956cb, Offset: 0x3e40
// Size: 0x74
function private function_dc4394ec() {
    if (isdefined(self.var_c589f3f2) && self.var_c589f3f2) {
        return;
    }
    self.var_c589f3f2 = 1;
    self thread function_c8131732();
    self ai::stun();
    wait 1;
    self ai::clear_stun();
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x4
// Checksum 0x6b87028, Offset: 0x3ec0
// Size: 0x2a
function private function_c8131732() {
    self endon(#"death");
    wait 12.5;
    self.var_c589f3f2 = undefined;
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x4
// Checksum 0xed884184, Offset: 0x3ef8
// Size: 0x204
function private function_e0d3bf15(e_attacker) {
    self notify(#"hash_3c2776b4262d3359");
    self endon(#"hash_3c2776b4262d3359", #"death");
    e_attacker endon(#"disconnect");
    self.var_65bbe67a = 1;
    self ai::stun();
    if (!self clientfield::get("zombie_spectral_key_stun")) {
        var_382c276e = e_attacker getentitynumber();
        self clientfield::set("zombie_spectral_key_stun", var_382c276e + 1);
        e_attacker clientfield::set("spectral_key_beam_flash", 2);
    }
    while (e_attacker.var_2aeb2774 === self && isalive(self)) {
        waitframe(1);
    }
    var_621a0307 = e_attacker clientfield::get("spectral_key_beam_flash");
    if (e_attacker attackbuttonpressed() && var_621a0307 === 2) {
        e_attacker clientfield::set("spectral_key_beam_flash", 1);
    }
    if (isdefined(self)) {
        if (self clientfield::get("zombie_spectral_key_stun")) {
            self clientfield::set("zombie_spectral_key_stun", 0);
        }
        self.var_65bbe67a = undefined;
        self ai::clear_stun();
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 1, eflags: 0x0
// Checksum 0xe69aac19, Offset: 0x4108
// Size: 0x41c
function function_dea8d9ae(var_1a4985e2 = 0) {
    if (self hasweapon(level.var_42c2d7ca)) {
        if (self.var_65f7ac63 < 3 || isdefined(var_1a4985e2) && var_1a4985e2) {
            if (self getweaponammoclip(level.var_b258bbfd) !== 0) {
                self setweaponammoclip(level.var_42c2d7ca, 0);
                self setweaponammoclip(level.var_cc1a6c85, 0);
                self setweaponammoclip(getweapon(#"zhield_spectral_lh_upgraded"), 0);
            }
        } else if (self.var_65f7ac63 >= 3) {
            if (self getweaponammoclip(level.var_b258bbfd) !== int(self.var_65f7ac63 / 3)) {
                self setweaponammoclip(level.var_42c2d7ca, int(self.var_65f7ac63 / 3));
                self setweaponammoclip(level.var_cc1a6c85, int(self.var_65f7ac63 / 3));
                self setweaponammoclip(getweapon(#"zhield_spectral_lh_upgraded"), int(self.var_65f7ac63 / 3));
            }
        }
        return;
    }
    if (self hasweapon(level.var_b258bbfd)) {
        if (self.var_65f7ac63 < 3 || isdefined(var_1a4985e2) && var_1a4985e2) {
            if (self getweaponammoclip(level.var_b258bbfd) !== 0) {
                self setweaponammoclip(level.var_b258bbfd, 0);
                self setweaponammoclip(level.var_3d9066fe, 0);
                self setweaponammoclip(getweapon(#"zhield_spectral_lh"), 0);
            }
            return;
        }
        if (self.var_65f7ac63 >= 3) {
            if (self getweaponammoclip(level.var_b258bbfd) !== int(self.var_65f7ac63 / 3)) {
                self setweaponammoclip(level.var_b258bbfd, int(self.var_65f7ac63 / 3));
                self setweaponammoclip(level.var_3d9066fe, int(self.var_65f7ac63 / 3));
                self setweaponammoclip(getweapon(#"zhield_spectral_lh"), int(self.var_65f7ac63 / 3));
            }
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x4
// Checksum 0xb4f538e3, Offset: 0x4530
// Size: 0x80
function private function_a35aae2b() {
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        s_result = level waittill(#"crafting_started");
        if (isdefined(s_result.unitrigger)) {
            s_result.unitrigger thread function_aa7c4e9e();
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 0, eflags: 0x0
// Checksum 0xe356c250, Offset: 0x45b8
// Size: 0xec
function function_aa7c4e9e() {
    self endon(#"death");
    if (isdefined(self.stub.blueprint) && isdefined(self.stub.blueprint.var_29ca87bc) && self.stub.blueprint.var_29ca87bc === level.var_b258bbfd) {
        if (isdefined(self.stub.model)) {
            s_progress = self waittill(#"hash_6db03c91467a21f5");
            if (isdefined(s_progress.b_completed) && s_progress.b_completed) {
                self.stub.model clientfield::increment("shield_crafting_fx");
            }
        }
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 2, eflags: 0x0
// Checksum 0x367da929, Offset: 0x46b0
// Size: 0x6c
function render_debug_sphere(origin, color) {
    if (getdvarint(#"turret_debug_server", 0)) {
        /#
            sphere(origin, 2, color, 0.75, 1, 10, 100);
        #/
    }
}

// Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
// Params 3, eflags: 0x0
// Checksum 0x12a6f1c, Offset: 0x4728
// Size: 0x6c
function function_cd048702(origin1, origin2, color) {
    if (getdvarint(#"turret_debug_server", 0)) {
        /#
            line(origin1, origin2, color, 0.75, 1, 100);
        #/
    }
}

/#

    // Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
    // Params 0, eflags: 0x0
    // Checksum 0xebbcc69b, Offset: 0x47a0
    // Size: 0x5c
    function function_4b519fe5() {
        zm_devgui::add_custom_devgui_callback(&function_c07cef1e);
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:xa1>");
    }

    // Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
    // Params 1, eflags: 0x0
    // Checksum 0xd42337a, Offset: 0x4808
    // Size: 0x3d2
    function function_c07cef1e(cmd) {
        switch (cmd) {
        case #"hash_2346833eb7280698":
            foreach (e_player in level.players) {
                if (e_player hasweapon(level.var_3d9066fe)) {
                    e_player.var_65f7ac63 = math::clamp(e_player.var_146f6928 * 3, 0, e_player.var_146f6928 * 3);
                    e_player setweaponammoclip(level.var_3d9066fe, e_player.var_65f7ac63);
                    e_player notify(#"hash_22a49f7903e394a5");
                    e_player thread function_dea8d9ae();
                    continue;
                }
                if (e_player hasweapon(level.var_cc1a6c85)) {
                    e_player.var_65f7ac63 = math::clamp(e_player.var_146f6928 * 3, 0, e_player.var_146f6928 * 3);
                    e_player setweaponammoclip(level.var_cc1a6c85, e_player.var_65f7ac63);
                    e_player notify(#"hash_22a49f7903e394a5");
                    e_player thread function_dea8d9ae();
                }
            }
            break;
        case #"hash_5a13ac5a96bb700c":
            foreach (e_player in level.players) {
                if (e_player hasweapon(level.var_3d9066fe)) {
                    e_player.var_65f7ac63 = math::clamp(e_player.var_146f6928 * 3, 0, e_player.var_146f6928 * 3);
                    e_player setweaponammoclip(level.var_3d9066fe, e_player.var_146f6928);
                    e_player notify(#"hash_22a49f7903e394a5");
                    e_player thread function_5bd6b289(level.var_3d9066fe);
                    continue;
                }
                if (e_player hasweapon(level.var_cc1a6c85)) {
                    e_player.var_65f7ac63 = math::clamp(e_player.var_146f6928 * 3, 0, e_player.var_146f6928 * 3);
                    e_player setweaponammoclip(level.var_cc1a6c85, e_player.var_146f6928);
                    e_player notify(#"hash_22a49f7903e394a5");
                    e_player thread function_5bd6b289(level.var_cc1a6c85);
                }
            }
            break;
        }
    }

    // Namespace zm_weap_spectral_shield/zm_weap_spectral_shield
    // Params 1, eflags: 0x0
    // Checksum 0x983a5fce, Offset: 0x4be8
    // Size: 0x122
    function function_5bd6b289(w_shield) {
        self notify(#"hash_1f37709e96e62bf2");
        self endon(#"disconnect", #"hash_1f37709e96e62bf2");
        while (true) {
            self thread function_dea8d9ae();
            s_result = self waittill(#"hash_5ac00f85b943ba5f", #"take_weapon");
            if (!self hasweapon(w_shield)) {
                return;
            }
            self.var_65f7ac63 = math::clamp(self.var_146f6928 * 3, 0, self.var_146f6928 * 3);
            self setweaponammoclip(w_shield, self.var_146f6928);
            self notify(#"hash_22a49f7903e394a5");
        }
    }

#/
