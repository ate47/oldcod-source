#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_crossbow;

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x2
// Checksum 0xa3cd20f7, Offset: 0x278
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_crossbow", &__init__, undefined, undefined);
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x0
// Checksum 0x71de67d, Offset: 0x2c0
// Size: 0x50c
function __init__() {
    level.w_crossbow = getweapon(#"ww_crossbow_t8");
    level.w_crossbow_upgraded = getweapon(#"ww_crossbow_t8_upgraded");
    level.w_crossbow_charged = getweapon(#"ww_crossbow_charged_t8");
    level.w_crossbow_charged_upgraded = getweapon(#"ww_crossbow_charged_t8_upgraded");
    level.var_5e9eed4a = [];
    clientfield::register("missile", "" + #"hash_6308b5ed3cbd99e3", 1, 1, "counter");
    clientfield::register("scriptmover", "" + #"hash_37c2ef99d645cf87", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_37c2ef99d645cf87", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_690509b9a2ec2ef3", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_290836b72f987780", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_6c3560ab45e186ec", 1, 1, "counter");
    clientfield::register("allplayers", "" + #"hash_b38c687db71dae", 1, 1, "int");
    callback::on_ai_damage(&function_e70aecac);
    callback::on_connect(&function_76b12c7f);
    callback::on_connect(&function_5def6ef4);
    callback::on_weapon_change(&crossbow_weapon_change);
    callback::add_weapon_fired(level.w_crossbow, &function_2ccde406);
    callback::add_weapon_fired(level.w_crossbow_upgraded, &function_2ccde406);
    callback::add_weapon_fired(level.w_crossbow_charged, &function_2ccde406);
    callback::add_weapon_fired(level.w_crossbow_charged_upgraded, &function_2ccde406);
    zm_utility::register_slowdown(#"hash_664a130410d3fd9a", 0.75, 12);
    zm_utility::register_slowdown(#"hash_2607a6ffde83b4a7", 0.5, 12);
    zm_utility::register_slowdown(#"hash_3a067a5eb7a19857", 0.75, 12);
    zm_utility::register_slowdown(#"hash_280fa271c70412cd", 0.75, 12);
    zm_utility::register_slowdown(#"hash_68f295e541f78cf5", 0.75, 12);
    zm_score::register_score_event("crossbow_capture_hold", &function_1014b859);
    zm_score::register_score_event("crossbow_crawler", &function_8b39235);
    level.var_306625ad = new throttle();
    [[ level.var_306625ad ]]->initialize(6, 0.1);
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x4
// Checksum 0x5a749c99, Offset: 0x7d8
// Size: 0x13e
function private function_5def6ef4() {
    self endon(#"disconnect");
    while (true) {
        w_current = self getcurrentweapon();
        if (is_crossbow(w_current) && self attackbuttonpressed()) {
            self clientfield::set("" + #"hash_290836b72f987780", 1);
            while (self attackbuttonpressed() && is_crossbow(w_current) && !self laststand::player_is_in_laststand()) {
                w_current = self getcurrentweapon();
                waitframe(1);
            }
            self clientfield::set("" + #"hash_290836b72f987780", 0);
        }
        waitframe(1);
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0xe82022b6, Offset: 0x920
// Size: 0xa6
function crossbow_weapon_change(params) {
    if (is_crossbow(params.weapon) && !is_crossbow_charged(params.weapon)) {
        self clientfield::set("" + #"hash_b38c687db71dae", 1);
        self thread function_7ffeae8c();
        return;
    }
    self notify(#"hash_72be12bd6b55fdab");
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x0
// Checksum 0xb1c881c9, Offset: 0x9d0
// Size: 0x168
function function_7ffeae8c() {
    self notify("20a090f39f4ae1bc");
    self endon("20a090f39f4ae1bc");
    self endoncallback(&function_a83f526, #"death", #"disconnect", #"hash_72be12bd6b55fdab");
    self.b_crossbow_charged = 0;
    while (true) {
        w_current = self getcurrentweapon();
        if (is_crossbow(w_current) && self.chargeshotlevel > 1 && !self.b_crossbow_charged) {
            self clientfield::set("" + #"hash_b38c687db71dae", 0);
            self.b_crossbow_charged = 1;
        } else if (self.b_crossbow_charged && self.chargeshotlevel <= 1) {
            self clientfield::set("" + #"hash_b38c687db71dae", 1);
            self.b_crossbow_charged = 0;
        }
        waitframe(1);
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0xa39dfad2, Offset: 0xb40
// Size: 0x34
function function_a83f526(str_notify) {
    self clientfield::set("" + #"hash_b38c687db71dae", 0);
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x4
// Checksum 0x6516b49c, Offset: 0xb80
// Size: 0x8a
function private function_76b12c7f() {
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"weapon_change");
        w_current = s_waitresult.weapon;
        if (is_crossbow(w_current)) {
            self thread zm_equipment::show_hint_text(#"hash_781f9cab14f565c8");
            return;
        }
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x0
// Checksum 0xc5943d7a, Offset: 0xc18
// Size: 0x2c
function function_2c376487() {
    self endon(#"death");
    self delete();
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0xd9a422fe, Offset: 0xc50
// Size: 0x3a2
function function_e70aecac(params) {
    if (!is_crossbow(params.weapon)) {
        return;
    }
    if (isdefined(self.var_50765bef) && self.var_50765bef) {
        return;
    }
    if (!isplayer(params.eattacker)) {
        return;
    }
    self notify(#"hash_2fb2eddfa6a0ef3f");
    var_fd4d0962 = self gettagorigin("j_knee_le");
    if (isdefined(params.einflictor) && params.shitloc === "none" && isdefined(var_fd4d0962)) {
        var_be09d309 = params.einflictor.origin[2] - var_fd4d0962[2];
        if (params.einflictor.origin[2] < var_fd4d0962[2] || abs(var_be09d309) <= 16) {
            params.shitloc = "left_foot";
        }
    }
    switch (params.shitloc) {
    case #"right_leg_upper":
    case #"left_leg_lower":
    case #"right_leg_lower":
    case #"left_foot":
    case #"right_foot":
    case #"left_leg_upper":
        if (isalive(self)) {
            if (self.archetype == "zombie") {
                if (is_crossbow_charged(params.weapon) || self.missinglegs && !(isdefined(self.var_d91ec28e) && self.var_d91ec28e)) {
                    self thread function_b7ff190d(params);
                } else {
                    params.eattacker zm_score::player_add_points("crossbow_crawler", 20);
                    self zombie_utility::makezombiecrawler(1);
                    level notify(#"crawler_created", {#zombie:self, #player:params.eattacker, #weapon:params.weapon});
                    self thread function_d3de40d7();
                }
            } else {
                self thread function_b7ff190d(params);
            }
        }
        break;
    default:
        if (isalive(self) && !(isdefined(self.var_d91ec28e) && self.var_d91ec28e)) {
            self thread function_b7ff190d(params);
        }
        break;
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x0
// Checksum 0xe68e0b9f, Offset: 0x1000
// Size: 0x36
function function_d3de40d7() {
    self endon(#"death");
    self.var_d91ec28e = 1;
    wait 1;
    self.var_d91ec28e = undefined;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 3, eflags: 0x0
// Checksum 0xb45de28b, Offset: 0x1040
// Size: 0x1dc
function function_592418cc(var_a5b96b53, str_scene, str_shot) {
    self endon(#"death");
    params = {#eattacker:var_a5b96b53.attacker, #einflictor:var_a5b96b53.inflictor, #weapon:var_a5b96b53.weapon, #smeansofdeath:var_a5b96b53.mod, #shitloc:"none"};
    self.var_dd309789 = 1;
    self clientfield::set("" + #"hash_37c2ef99d645cf87", 1);
    if (isdefined(str_scene)) {
        if (isdefined(str_shot)) {
            self thread scene::play(str_scene, str_shot, self);
        } else {
            self thread scene::play(str_scene, self);
        }
    } else {
        self thread function_34de1e7d(is_crossbow_upgraded(params.weapon));
    }
    self function_de63e97f(params);
    self clientfield::set("" + #"hash_37c2ef99d645cf87", 0);
    self.var_dd309789 = undefined;
    if (isdefined(str_scene)) {
        self thread scene::stop(str_scene);
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x4
// Checksum 0xe02c84d, Offset: 0x1228
// Size: 0xbe
function private function_34de1e7d(var_5655ffeb = 0) {
    self endon(#"death");
    if (var_5655ffeb) {
        var_edf26f2 = 3;
    } else {
        var_edf26f2 = 1.5;
    }
    while (isdefined(self.var_dd309789) && self.var_dd309789) {
        self rotateyaw(var_edf26f2, float(function_f9f48566()) / 1000);
        waitframe(1);
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0x4125dd4c, Offset: 0x12f0
// Size: 0x946
function function_b7ff190d(params) {
    player = params.eattacker;
    w_crossbow = params.weapon;
    [[ level.var_306625ad ]]->waitinqueue(self);
    if (!isactor(self) || !isplayer(player)) {
        return;
    }
    if (!isdefined(player.var_5e9eed4a)) {
        player.var_5e9eed4a = [];
    }
    player.var_5e9eed4a = array::remove_dead(player.var_5e9eed4a);
    if (!is_crossbow_charged(w_crossbow, player) || isdefined(self.var_da4cbdc4) && self.var_da4cbdc4 || isdefined(self.var_b4fdbf25) && self.var_b4fdbf25 || isdefined(self.var_dd309789) && self.var_dd309789 || params.smeansofdeath === "MOD_MELEE" || self.archetype == #"elephant_rider" || self.archetype == #"dust_ball") {
        if (isdefined(self.var_b4fdbf25) && self.var_b4fdbf25 || isdefined(self.var_dd309789) && self.var_dd309789) {
            return;
        }
        self.var_50765bef = 1;
        n_damage = self function_1ad5a919(params);
        self function_a386c05e(n_damage, player, self.origin, params);
        if (isdefined(params.vdir) && self.health <= 0) {
            if (params.shitloc === "head" || params.shitloc === "helmet") {
                gibserverutils::gibhead(self);
            } else if (self.archetype === "zombie") {
                self zombie_utility::derive_damage_refs(params.vpoint);
            }
            var_e9481891 = 75 * vectornormalize(params.vdir);
            var_e9481891 = (var_e9481891[0], var_e9481891[1], 20);
            self startragdoll();
            self launchragdoll(var_e9481891);
        }
        self.var_50765bef = undefined;
        return;
    }
    if (player.var_5e9eed4a.size >= 2) {
        var_62a3b3d5 = player.var_5e9eed4a.size - 2 + 1;
        for (i = 0; i < var_62a3b3d5; i++) {
            ai_zombie = player.var_5e9eed4a[i];
            if (isalive(ai_zombie)) {
                player.var_5e9eed4a[i].var_dd309789 = undefined;
            }
        }
    }
    self.var_dd309789 = 1;
    self.instakill_func = &function_4e96898d;
    level.var_5e9eed4a = array::remove_dead(level.var_5e9eed4a);
    if (!isdefined(level.var_5e9eed4a)) {
        level.var_5e9eed4a = [];
    } else if (!isarray(level.var_5e9eed4a)) {
        level.var_5e9eed4a = array(level.var_5e9eed4a);
    }
    level.var_5e9eed4a[level.var_5e9eed4a.size] = self;
    if (!isdefined(player.var_5e9eed4a)) {
        player.var_5e9eed4a = [];
    } else if (!isarray(player.var_5e9eed4a)) {
        player.var_5e9eed4a = array(player.var_5e9eed4a);
    }
    player.var_5e9eed4a[player.var_5e9eed4a.size] = self;
    self clientfield::set("" + #"hash_37c2ef99d645cf87", 1);
    str_scene = self function_59ef4710();
    if (isdefined(str_scene) && isalive(self)) {
        self thread scene::play(str_scene, self);
    } else if (is_crossbow_upgraded(w_crossbow)) {
        self function_fc10cd92(16);
    } else {
        self function_fc10cd92(12);
    }
    self function_de63e97f(params);
    if (isdefined(player)) {
        player zm_score::player_add_points("crossbow_capture_hold", 50);
    }
    if (isalive(self)) {
        if (isdefined(str_scene)) {
            if (scene::function_68180861(str_scene, "outro")) {
                self thread scene::play(str_scene, "outro", self);
            } else {
                self scene::stop(str_scene);
            }
        } else {
            self function_d262fa89();
        }
        self.dont_die_on_me = undefined;
        arrayremovevalue(level.var_5e9eed4a, self);
        arrayremovevalue(player.var_5e9eed4a, self);
        n_damage = self function_1ad5a919(params);
        self function_a386c05e(n_damage, player, self.origin, params);
        self.var_dd309789 = undefined;
        self.var_b4fdbf25 = undefined;
        self.instakill_func = undefined;
        self clientfield::set("" + #"hash_37c2ef99d645cf87", 0);
        if (self.health <= 0 && self.archetype !== "elephant") {
            self playsound("wpn_scorpion_zombie_explode");
            gibserverutils::annihilate(self);
            v_origin = self.origin;
            a_zombies = array::exclude(getaiteamarray(level.zombie_team), self);
            foreach (ai in a_zombies) {
                if (isalive(ai) && ai function_e3e12a98(v_origin, w_crossbow)) {
                    n_damage = ai function_1ad5a919(params);
                    ai function_a386c05e(n_damage, player, v_origin, params);
                    waitframe(1);
                }
            }
        }
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 2, eflags: 0x0
// Checksum 0x60652dcc, Offset: 0x1c40
// Size: 0x8c
function function_e3e12a98(v_origin, weapon) {
    if (is_crossbow_upgraded(weapon)) {
        if (distancesquared(self.origin, v_origin) <= 44100) {
            return true;
        }
    } else if (distancesquared(self.origin, v_origin) <= 25600) {
        return true;
    }
    return false;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 4, eflags: 0x0
// Checksum 0xd05cd6a1, Offset: 0x1cd8
// Size: 0x8c
function function_a386c05e(n_amount, player, v_origin, params) {
    if (isdefined(player)) {
        self dodamage(n_amount, v_origin, player, params.einflictor, params.shitloc, params.smeansofdeath);
        return;
    }
    self dodamage(n_amount, v_origin);
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0x9881b5a4, Offset: 0x1d70
// Size: 0x40
function get_base_crossbow(weapon) {
    if (is_crossbow_upgraded(weapon)) {
        return level.w_crossbow_upgraded;
    }
    return level.w_crossbow;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0xaa04ea54, Offset: 0x1db8
// Size: 0x66
function is_crossbow(weapon) {
    if (weapon === level.w_crossbow || weapon === level.w_crossbow_upgraded || weapon === level.w_crossbow_charged || weapon === level.w_crossbow_charged_upgraded) {
        return true;
    }
    return false;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 2, eflags: 0x0
// Checksum 0x56ae6d58, Offset: 0x1e28
// Size: 0xd2
function is_crossbow_charged(weapon, player) {
    if (isdefined(player)) {
        w_crossbow_base = get_base_crossbow(weapon);
        n_ammo_stock = player getweaponammostock(w_crossbow_base);
        if (n_ammo_stock >= 9 && (weapon === level.w_crossbow_charged || weapon === level.w_crossbow_charged_upgraded)) {
            return true;
        }
    } else if (weapon === level.w_crossbow_charged || weapon === level.w_crossbow_charged_upgraded) {
        return true;
    }
    return false;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0x4e2ef59f, Offset: 0x1f08
// Size: 0x3e
function is_crossbow_upgraded(weapon) {
    if (weapon === level.w_crossbow_upgraded || weapon === level.w_crossbow_charged_upgraded) {
        return true;
    }
    return false;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0xa2c5378c, Offset: 0x1f50
// Size: 0x6f0
function function_de63e97f(params) {
    v_origin = self.origin;
    player = params.eattacker;
    e_inflictor = params.einflictor;
    w_crossbow = params.weapon;
    if (is_crossbow_upgraded(w_crossbow)) {
        var_d8ed122 = 1;
        n_time = 16;
    } else {
        var_d8ed122 = 0;
        n_time = 12;
    }
    wait 0.5;
    while (n_time > 0 && isalive(self) && isdefined(self.var_dd309789) && self.var_dd309789) {
        level.var_5e9eed4a = array::remove_dead(level.var_5e9eed4a);
        a_zombies = array::exclude(getaiteamarray(level.zombie_team), level.var_5e9eed4a);
        if (self.archetype === "elephant" && isdefined(self.ai) && isdefined(self.ai.riders)) {
            a_zombies = array::exclude(a_zombies, self.ai.riders);
        }
        foreach (ai in a_zombies) {
            if (isalive(ai) && ai function_e3e12a98(v_origin, w_crossbow) && ai.archetype !== #"dust_ball") {
                if (!(isdefined(ai.var_b4fdbf25) && ai.var_b4fdbf25)) {
                    if (isdefined(player)) {
                        if (!isdefined(player.var_bd04dc3f)) {
                            player.var_bd04dc3f = [];
                        } else if (!isarray(player.var_bd04dc3f)) {
                            player.var_bd04dc3f = array(player.var_bd04dc3f);
                        }
                        player.var_bd04dc3f[player.var_bd04dc3f.size] = ai;
                        player.var_bd04dc3f = array::remove_dead(player.var_bd04dc3f);
                    }
                    ai.var_b4fdbf25 = 1;
                    if (is_crossbow_upgraded(w_crossbow)) {
                        ai function_fc10cd92(16);
                    } else {
                        ai function_fc10cd92(12);
                    }
                    ai clientfield::set("" + #"hash_690509b9a2ec2ef3", 1);
                    wait 0.05;
                }
                /#
                    if (isalive(ai) && !isdefined(ai.maxhealth) && isdefined(ai.archetype)) {
                        iprintlnbold("<dev string:x30>" + function_15979fa9(ai.archetype) + "<dev string:x58>");
                    }
                #/
                if (isalive(ai) && isdefined(ai.maxhealth)) {
                    if (var_d8ed122) {
                        ai function_a386c05e(int(ai.maxhealth * 0.2), player, v_origin, params);
                    } else {
                        ai function_a386c05e(int(ai.maxhealth * 0.1), player, v_origin, params);
                    }
                    waitframe(1);
                    continue;
                }
            }
        }
        if (!(isdefined(self.var_dd309789) && self.var_dd309789)) {
            break;
        }
        wait 1;
        n_time -= 1;
    }
    a_zombies = array::exclude(getaiteamarray(level.zombie_team), level.var_5e9eed4a);
    foreach (ai in a_zombies) {
        if (isalive(ai) && isdefined(ai.var_b4fdbf25) && ai.var_b4fdbf25) {
            if (isdefined(player) && isarray(player.var_bd04dc3f)) {
                arrayremovevalue(player.var_bd04dc3f, ai);
            }
            ai.var_b4fdbf25 = undefined;
            ai clientfield::set("" + #"hash_690509b9a2ec2ef3", 0);
            ai function_d262fa89();
            util::wait_network_frame();
        }
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0xb5e1b684, Offset: 0x2648
// Size: 0xda
function function_e4552efc(archetype) {
    switch (archetype) {
    case #"catalyst":
    case #"zombie":
        return #"hash_664a130410d3fd9a";
    case #"tiger":
        return #"hash_2607a6ffde83b4a7";
    case #"stoker":
    case #"gladiator":
        return #"hash_3a067a5eb7a19857";
    case #"blight_father":
        return #"hash_280fa271c70412cd";
    case #"elephant":
        return #"hash_68f295e541f78cf5";
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0xeb829e39, Offset: 0x2730
// Size: 0xd4
function function_fc10cd92(var_c0f5a3d8 = 12) {
    var_e5ea96cd = function_e4552efc(self.archetype);
    switch (self.archetype) {
    case #"catalyst":
    case #"zombie":
        self zombie_utility::set_zombie_run_cycle_override_value("walk");
        break;
    }
    if (isdefined(var_e5ea96cd)) {
        self thread zm_utility::function_447d3917(var_e5ea96cd);
    }
    self ai::stun(var_c0f5a3d8);
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x0
// Checksum 0x61098bc9, Offset: 0x2810
// Size: 0xfc
function function_d262fa89() {
    switch (self.archetype) {
    case #"zombie":
        self zombie_utility::set_zombie_run_cycle_restore_from_override();
        break;
    case #"catalyst":
    case #"tiger":
        self zombie_utility::set_zombie_run_cycle_restore_from_override();
        break;
    case #"gladiator":
    case #"blight_father":
    case #"elephant":
        break;
    }
    var_2c960851 = function_e4552efc(self.archetype);
    self zm_utility::function_95398de5(var_2c960851);
    self ai::clear_stun();
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x0
// Checksum 0x92d0a944, Offset: 0x2918
// Size: 0x11e
function function_59ef4710() {
    switch (self.archetype) {
    case #"zombie":
        str_scene = "aib_t8_zm_zombie_base_dth_ww_xbow";
        break;
    case #"tiger":
        str_scene = "aib_t8_zm_tiger_dth_ww_xbow";
        break;
    case #"catalyst":
        str_scene = "aib_t8_zm_zombie_base_dth_ww_xbow";
        break;
    case #"stoker":
        str_scene = "aib_t8_zm_stoker_dth_ww_xbow";
        break;
    case #"gladiator":
        str_scene = "aib_t8_zm_gladiator_dth_ww_xbow";
        break;
    case #"blight_father":
        str_scene = "aib_t8_zm_blightfather_dth_ww_xbow";
        break;
    case #"elephant":
        str_scene = undefined;
        break;
    default:
        str_scene = "aib_t8_zm_zombie_base_dth_ww_xbow";
        break;
    }
    return str_scene;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0xfd489689, Offset: 0x2a40
// Size: 0x3d2
function function_1ad5a919(params) {
    if (!is_crossbow_upgraded(params.weapon)) {
        switch (self.archetype) {
        case #"zombie":
            var_82d0250 = 1;
            var_49ba89df = 2;
            break;
        case #"tiger":
            var_82d0250 = 1;
            var_49ba89df = 2;
            break;
        case #"catalyst":
            var_82d0250 = 0.5;
            var_49ba89df = 1;
            break;
        case #"stoker":
        case #"gladiator":
            var_82d0250 = 0.25;
            var_49ba89df = 1;
            break;
        case #"blight_father":
            var_82d0250 = 0.2;
            var_49ba89df = 1;
            break;
        case #"elephant":
            var_82d0250 = 0.1;
            var_49ba89df = 1;
            break;
        default:
            var_82d0250 = 1;
            var_49ba89df = 1;
            break;
        }
    } else {
        switch (self.archetype) {
        case #"zombie":
            var_82d0250 = 1;
            var_49ba89df = 2;
            break;
        case #"tiger":
            var_82d0250 = 1;
            var_49ba89df = 2;
            break;
        case #"catalyst":
            var_82d0250 = 1;
            var_49ba89df = 2;
            break;
        case #"stoker":
        case #"gladiator":
            var_82d0250 = 0.25;
            var_49ba89df = 1;
            break;
        case #"blight_father":
            var_82d0250 = 0.25;
            var_49ba89df = 1;
            break;
        case #"elephant":
            var_82d0250 = 0.2;
            var_49ba89df = 1;
            break;
        default:
            var_82d0250 = 1;
            var_49ba89df = 1;
            break;
        }
    }
    /#
        if (!isdefined(self.maxhealth) && isdefined(self.archetype)) {
            iprintlnbold("<dev string:x30>" + function_15979fa9(self.archetype) + "<dev string:x58>");
        }
    #/
    n_damage = 0;
    if (level.round_number <= 23 && isdefined(self.maxhealth)) {
        n_damage = int(self.maxhealth * var_82d0250);
    } else if (isdefined(self.maxhealth)) {
        var_c2b6d2bf = var_82d0250 - (level.round_number - 23) * var_49ba89df / 100;
        var_c2b6d2bf = math::clamp(var_c2b6d2bf, 0.01, 1);
        n_damage = int(self.maxhealth * var_c2b6d2bf);
    }
    return n_damage;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0x95002870, Offset: 0x2e20
// Size: 0x320
function function_2ccde406(weapon) {
    self notify("6996d617c985c61");
    self endon("6996d617c985c61");
    self endon(#"disconnect");
    if (is_crossbow_charged(weapon, self)) {
        self clientfield::increment("" + #"hash_6c3560ab45e186ec");
    }
    s_waitresult = self waittill(#"reload", #"death", #"player_downed", #"weapon_change_complete");
    if (isarray(self.weaponobjectwatcherarray)) {
        foreach (s_weapon_object in self.weaponobjectwatcherarray) {
            if (!is_crossbow(s_weapon_object.weapon)) {
                continue;
            }
            if (s_weapon_object.onfizzleout === &function_2c376487) {
                continue;
            }
            s_weapon_object.onfizzleout = &function_2c376487;
        }
    }
    if (is_crossbow_charged(weapon, self)) {
        w_crossbow_base = get_base_crossbow(weapon);
        n_ammo_stock = self getweaponammostock(w_crossbow_base) - 9;
        n_ammo_stock = math::clamp(n_ammo_stock, 0, w_crossbow_base.maxammo);
        self setweaponammostock(w_crossbow_base, n_ammo_stock);
    }
    if (level flagsys::get(#"hash_cad6742c753621")) {
        v_start = self getweaponmuzzlepoint();
        v_end = v_start + self getweaponforwarddir() * 1000;
        s_trace = bullettrace(v_start, v_end, 0, self);
        level notify(#"xbow_hit", {#player:self, #position:s_trace[#"position"]});
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 3, eflags: 0x0
// Checksum 0x2c861370, Offset: 0x3148
// Size: 0x5e
function function_4e96898d(player, mod, shitloc) {
    w_player = player getcurrentweapon();
    if (is_crossbow(w_player)) {
        return true;
    }
    return false;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 5, eflags: 0x0
// Checksum 0x51836dfd, Offset: 0x31b0
// Size: 0x30
function function_1014b859(event, mod, hit_location, zombie_team, damage_weapon) {
    return 50;
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 5, eflags: 0x0
// Checksum 0x3d6e0fd2, Offset: 0x31e8
// Size: 0x30
function function_8b39235(event, mod, hit_location, zombie_team, damage_weapon) {
    return 20;
}

